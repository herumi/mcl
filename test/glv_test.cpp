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
		if (!Fp::squareRoot(w, -3)) throw cybozu::Exception("oldGLV:init");
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

void testGLV1()
{
	G1 P0, P1, P2;
	BN::mapToG1(P0, 1);
	cybozu::XorShift rg;

	oldGLV oldGlv;
	oldGlv.init(BN::param.r, BN::param.z);

	mcl::bn::GLV1<Fp> glv;
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

template<class Fp2>
struct GLV2 {
	typedef mcl::EcT<Fp2> G2;
	size_t m;
	mpz_class B[4][4];
	mpz_class r;
	mpz_class v[4];
	void init(const mpz_class& r, const mpz_class& z)
	{
		this->r = r;
		m = mcl::gmp::getBitSize(r);
		m = (m + mcl::fp::UnitBitSize - 1) & ~(mcl::fp::UnitBitSize - 1);// a little better size
		/*
			v[] = [1, 0, 0, 0] * B^(-1) = [2z^2+3z+1, 12z^3+8z^2+z, 6z^3+4z^2+z, -(2z+1)]
		*/
		v[0] = ((1 + z * (3 + z * 2)) << m) / r;
		v[1] = ((z * (1 + z * (8 + z * 12))) << m) / r;
		v[2] = ((z * (1 + z * (4 + z * 6))) << m) / r;
		v[3] = -((z * (1 + z * 2)) << m) / r;
		const mpz_class z2p1 = z * 2 + 1;
		B[0][0] = z + 1;
		B[0][1] = z;
		B[0][2] = z;
		B[0][3] = -2 * z;
		B[1][0] = z2p1;
		B[1][1] = -z;
		B[1][2] = -(z + 1);
		B[1][3] = -z;
		B[2][0] = 2 * z;
		B[2][1] = z2p1;
		B[2][2] = z2p1;
		B[2][3] = z2p1;
		B[3][0] = z - 1;
		B[3][1] = 2 * z2p1;
		B[3][2] =  -2 * z + 1;
		B[3][3] = z - 1;
	}
	/*
		u[] = [x, 0, 0, 0] - v[] * x * B
	*/
	void split(mpz_class u[4], const mpz_class& x) const
	{
		mpz_class t[4];
		for (int i = 0; i < 4; i++) {
			t[i] = (x * v[i]) >> m;
		}
		for (int i = 0; i < 4; i++) {
			u[i] = (i == 0) ? x : 0;
			for (int j = 0; j < 4; j++) {
				u[i] -= t[j] * B[j][i];
			}
		}
	}
	void mulOrg(G2& Q, const G2& P, mpz_class x) const
	{
		x %= r;
		if (x == 0) {
			Q.clear();
			return;
		}
		if (x < 0) {
			x += r;
		}
		mpz_class u[4];
		split(u, x);
		G2 in[4];
		in[0] = P;
		BN::FrobeniusOnTwist(in[1], in[0]);
		BN::FrobeniusOnTwist(in[2], in[1]);
		BN::FrobeniusOnTwist(in[3], in[2]);
		for (int i = 0; i < 4; i++) {
			G2::mul(in[i], in[i], u[i]);
		}
		G2::add(Q, in[0], in[1]);
		Q += in[2];
		Q += in[3];
	}
	void mul(G2& Q, const G2& P, mpz_class x) const
	{
		x %= r;
		if (x == 0) {
			Q.clear();
			return;
		}
		if (x < 0) {
			x += r;
		}
		mpz_class u[4];
		split(u, x);
		G2 in[4];
		in[0] = P;
		BN::FrobeniusOnTwist(in[1], in[0]);
		BN::FrobeniusOnTwist(in[2], in[1]);
		BN::FrobeniusOnTwist(in[3], in[2]);
		for (int i = 0; i < 4; i++) {
			if (u[i] < 0) {
				u[i] = -u[i];
				G2::neg(in[i], in[i]);
			}
			in[i].normalize();
		}
#if 0
		for (int i = 0; i < 4; i++) {
			G2::mul(in[i], in[i], u[i]);
		}
		G2::add(Q, in[0], in[1]);
		Q += in[2];
		Q += in[3];
#else
		G2 tbl[16];
		for (size_t i = 0; i < 16; i++) {
			tbl[i].clear();
		}
		for (size_t i = 0; i < 16; i++) {
			if (i & 1) {
				tbl[i] += in[0];
			}
			if (i & 2) {
				tbl[i] += in[1];
			}
			if (i & 4) {
				tbl[i] += in[2];
			}
			if (i & 8) {
				tbl[i] += in[3];
			}
		}
		for (size_t i = 0; i < 16; i++) {
			tbl[i].normalize();
		}
		typedef mcl::fp::Unit Unit;
		const size_t maxUnit = 4;
		int bitTbl[4]; // bit size of u[i]
		Unit w[4][maxUnit]; // unit array of u[i]
		for (int i = 0; i < 4; i++) {
			mcl::gmp::getArray(w[i], maxUnit, u[i]);
			bitTbl[i] = (int)mcl::gmp::getBitSize(u[i]);
		}
		int maxBit = bitTbl[0]; // max bit of u[i]
		for (int i = 1; i < 4; i++) {
			maxBit = std::max(maxBit, bitTbl[i]);
		}
		assert(maxBit > 0);
		int maxN = maxBit / mcl::fp::UnitBitSize;
		int m = maxBit % mcl::fp::UnitBitSize;
		Q.clear();
		for (int i = maxN - 1; i >= 0; i--) {
			for (int j = m; j >= 0; j--) {
				G2::dbl(Q, Q);
				Unit b0 = (w[0][i] >> j) & 1;
				Unit b1 = (w[1][i] >> j) & 1;
				Unit b2 = (w[2][i] >> j) & 1;
				Unit b3 = (w[3][i] >> j) & 1;
				Unit c = b3 * 8 + b2 * 4 + b1 * 2 + b0;
				Q += tbl[c];
			}
			m = (int)mcl::fp::UnitBitSize - 1;
		}
#endif
	}
};
/*
	lambda = 6 * z * z
	mul (lambda * 2) = FrobeniusOnTwist * 2
*/
void testGLV2()
{
	G2 Q0, Q1, Q2;
	mpz_class z = BN::param.z;
	mpz_class r = BN::param.r;
	mpz_class lambda = 6 * z * z;
	GLV2<Fp2> glv2;
	glv2.init(r, z);
	mpz_class u[4];
	mpz_class n;
	cybozu::XorShift rg;
	for (int i = 1; i < 5; i++) {
		mcl::gmp::getRand(n, glv2.m, rg);
		n %= r;
		BN::mapToG2(Q0, i);
		G2::mul(Q1, Q0, n);
		glv2.mul(Q2, Q0, n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
}

CYBOZU_TEST_AUTO(glv)
{
	const mcl::bn::CurveParam tbl[] = {
		mcl::bn::CurveFp254BNb,
		mcl::bn::CurveFp382_1,
		mcl::bn::CurveFp382_2,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const mcl::bn::CurveParam& cp = tbl[i];
		bn384init(cp);
		testGLV1();
//		testGLV2();
	}
}
