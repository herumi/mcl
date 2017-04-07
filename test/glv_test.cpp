#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

#if 1
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#else
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#endif

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

/*
	Skew Frobenius Map and Efficient Scalar Multiplication for Pairing-Based Cryptography
	Y. Sakemi, Y. Nogami, K. Okeya, H. Kato, Y. Morikawa
*/
struct oldGLV {
	Fp w; // (-1 + sqrt(-3)) / 2
	mpz_class r;
	mpz_class v; // 6z^2 + 4z + 1 > 0
	mpz_class c; // 2z + 1
	void init(const mpz_class& r, const mpz_class& z)
	{
		if (!Fp::squareRoot(w, -3)) throw cybozu::Exception("GLV:init");
		w = (w - 1) / 2;
		this->r = r;
		v = 1 + z * (4 + z * 6);
		c = 2 * z + 1;
	}
	/*
		(p^2 mod r) (x, y) = (wx, -y)
	*/
	void mulP2(G1& Q, const G1& P) const
	{
		Fp::mul(Q.x, P.x, w);
		Fp::neg(Q.y, P.y);
		Q.z = P.z;
	}
	/*
		x = ap^2 + b mod r
		assume(x < r);
	*/
	void split(mpz_class& a, mpz_class& b, const mpz_class& x) const
	{
		assert(0 < x && x < r);
		/*
			x = s1 * v + s2                  // s1 = x / v, s2 = x % v
			= s1 * c * p^2 + s2              // vP = cp^2 P
			= (s3 * v + s4) * p^2 + s2       // s3 = (s1 * c) / v, s4 = (s1 * c) % v
			= (s3 * c * p^2 + s4) * p^2 + s2
			= (s3 * c) * p^4 + s4 * p^2 + s2 // s5 = s3 * c, p^4 = p^2 - 1
			= s5 * (p^2 - 1) + s4 * p^2 + s2
			= (s4 + s5) * p^2 + (s2 - s5)
		*/
		mpz_class t;
		mcl::gmp::divmod(a, t, x, v); // a = t / v, t = t % v
		a *= c;
		mcl::gmp::divmod(b, a, a, v); // b = a / v, a = a % v
		b *= c;
		a += b;
		b = t - b;
	}
	template<class G1>
	void mul(G1& Q, const G1& P, const mpz_class& x) const
	{
		G1 A, B;
		mpz_class a, b;
		split(a, b, x);
		mulP2(A, P);
		G1::mul(A, A, a);
		G1::mul(B, P, b);
		G1::add(Q, A, B);
	}
};

template<class GLV1, class GLV2>
void compareLength(const GLV1& rhs, const GLV2& lhs)
{
	cybozu::XorShift rg;
	int Rc = 0;
	int Lc = 0;
	int eq = 0;
	mpz_class R0, R1, L0, L1, x;
	Fr r;
	for (int i = 1; i < 1000; i++) {
		r.setRand(rg);
		x = r.getMpz();
		rhs.split(R0, R1, x);
		lhs.split(L0, L1, x);

		size_t R0n = mcl::gmp::getBitSize(R0);
		size_t R1n = mcl::gmp::getBitSize(R1);
		size_t L0n = mcl::gmp::getBitSize(L0);
		size_t L1n = mcl::gmp::getBitSize(L1);
		size_t Rn = std::max(R0n, R1n);
		size_t Ln = std::max(L0n, L1n);
		if (Rn == Ln) {
			eq++;
		}
		if (Rn > Ln) {
			Rc++;
		}
		if (Rn < Ln) {
			Lc++;
		}
	}
	printf("eq=%d small is better rhs=%d, lhs=%d\n", eq, Rc, Lc);
}

void testGLV(const mcl::bn::CurveParam& cp)
{
	bn384init(cp);
	G1::setCompressedExpression(false);

	G1 P0, P1, P2;
	BN::mapToG1(P0, 1);
	cybozu::XorShift rg;

	oldGLV oldGlv;
	oldGlv.init(BN::param.r, BN::param.z);

	mcl::bn::GLV<Fp> glv;
	glv.init(BN::param.r, BN::param.z);
	compareLength(glv, oldGlv);

	for (int i = 1; i < 100; i++) {
		BN::mapToG1(P0, i);
		Fr s;
		s.setRand(rg);
		mpz_class ss = s.getMpz();
		G1::mulBase(P1, P0, ss);
		glv.mul(P2, P0, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
		glv.mul(P2, P0, ss, true);
		CYBOZU_TEST_EQUAL(P1, P2);
		oldGlv.mul(P2, P0, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	for (int i = -100; i < 100; i++) {
		mpz_class ss = i;
		G1::mulBase(P1, P0, ss);
		glv.mul(P2, P0, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
		glv.mul(P2, P0, ss, true);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	Fr s;
	BN::mapToG1(P0, 123);
	CYBOZU_BENCH_C("Ec::mul", 100, P1 = P0; s.setRand(rg); G1::mul, P2, P1, s.getMpz());
	CYBOZU_BENCH_C("Ec::glv", 100, P1 = P0; s.setRand(rg); glv.mul, P2, P1, s.getMpz());
}

CYBOZU_TEST_AUTO(glv)
{
	testGLV(mcl::bn::CurveFp254BNb);
	testGLV(mcl::bn::CurveFp382_1);
	testGLV(mcl::bn::CurveFp382_2);
}
