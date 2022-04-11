#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <vector>

#include <mcl/bls12_381.hpp>
using namespace mcl::bn;

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

template<class G>
void testGLV(const G& P, const char *name)
{
	printf("testGLV %s\n", name);
	G P1, P2;
	cybozu::XorShift rg;

	for (int i = -100; i < 100; i++) {
		Fr s = i;
		G::mulGeneric(P1, P, s.getMpz());
		G::mul(P2, P, i);
		CYBOZU_TEST_EQUAL(P1, P2);
		P2.clear();
		G::mul(P2, P, s);
		CYBOZU_TEST_EQUAL(P1, P2);
		P2.clear();
	}
	for (int i = 1; i < 100; i++) {
		Fr s;
		s.setRand(rg);
		G::mulGeneric(P1, P, s.getMpz());
		G::mul(P2, P, s);
		CYBOZU_TEST_EQUAL(P1, P2);
		Fp ss;
		ss.setRand(rg);
		G::mulGeneric(P1, P, ss.getMpz());
		G::mul(P2, P, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
}

template<class G>
void naiveMulVec(G& out, const G *xVec, const Fr *yVec, size_t n)
{
	if (n == 1) {
		G::mul(out, xVec[0], yVec[0]);
		return;
	}
	G r, t;
	r.clear();
	for (size_t i = 0; i < n; i++) {
		G::mul(t, xVec[i], yVec[i]);
		r += t;
	}
	out = r;
}

template<class G>
void mulVecCopy(G& z, G *x, const Fr *y, size_t n, const G* x0)
{
	for (size_t i = 0; i < n; i++) x[i] = x0[i];
	G::mulVec(z, x, y, n);
}

template<class G>
void testMulVec(const G& P, const char *name)
{
	printf("testMulVec %s\n", name);
	using namespace mcl::bn;
	const int N = 4096;
	std::vector<G> x0Vec(N);
	std::vector<G> xVec(N);
	std::vector<Fr> yVec(N);

	for (size_t i = 0; i < N; i++) {
		G::mul(x0Vec[i], P, i + 3);
		xVec[i] = x0Vec[i];
		yVec[i].setByCSPRNG();
	}
	const size_t nTbl[] = { 1, 2, 3, 15, 16, 17, 32, 64, 128, 256, 512, 1024, 2048, N };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		G Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naiveMulVec(Q1, xVec.data(), yVec.data(), n);
		G::mulVec(Q2, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
#ifdef NDEBUG
		printf("n=%zd\n", n);
		const int C = 10;
		CYBOZU_BENCH_C("naive ", C, naiveMulVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("mulVec", C, mulVecCopy, Q1, xVec.data(), yVec.data(), n, x0Vec.data());
#endif
	}
}

void naivePowVec(GT& out, const GT *xVec, const Fr *yVec, size_t n)
{
	if (n == 1) {
		GT::pow(out, xVec[0], yVec[0]);
		return;
	}
	GT r, t;
	r = 1;
	for (size_t i = 0; i < n; i++) {
		GT::pow(t, xVec[i], yVec[i]);
		r *= t;
	}
	out = r;
}

void testPowVec(const GT& e)
{
	puts("testPowVec");
	using namespace mcl::bn;
	const int N = 4096;
	std::vector<GT> x0Vec(N);
	std::vector<GT> xVec(N);
	std::vector<Fr> yVec(N);

	for (size_t i = 0; i < N; i++) {
		GT::pow(x0Vec[i], e, i + 3);
		xVec[i] = x0Vec[i];
		yVec[i].setByCSPRNG();
	}
	const size_t nTbl[] = { 1, 2, 3, 15, 16, 17, 32, 64, 128, 256, 512, 1024, 2048, N };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		GT Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naivePowVec(Q1, xVec.data(), yVec.data(), n);
		GT::powVec(Q2, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
#ifdef NDEBUG
		const int C = 10;
		CYBOZU_BENCH_C("naive ", C, naivePowVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("powVec", C, GT::powVec, Q1, xVec.data(), yVec.data(), n);
#endif
	}
}



void testGT(const GT& e)
{
	GT P1, P2;
	cybozu::XorShift rg;

	for (int i = -100; i < 100; i++) {
		Fr s = i;
		GT::powGeneric(P1, e, s.getMpz());
		GT::pow(P2, e, i);
		CYBOZU_TEST_EQUAL(P1, P2);
		P2.clear();
		GT::pow(P2, e, s);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	for (int i = 1; i < 100; i++) {
		Fr s;
		s.setRand(rg);
		GT::powGeneric(P1, e, s.getMpz());
		GT::pow(P2, e, s);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
}

CYBOZU_TEST_AUTO(glv)
{
	const struct {
		const mcl::CurveParam& param;
		const char *name;
	} tbl[] = {
		{ mcl::BLS12_381, "BLS12_381" },
		{ mcl::BN254, "BN254" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("name=%s\n", tbl[i].name);
		const mcl::CurveParam& cp = tbl[i].param;
		initPairing(cp);
		G1 P;
		G2 Q;
		GT e;
		mapToG1(P, 1);
		mapToG2(Q, 1);
		pairing(e, P, Q);
		testGLV(P, "G1");
		testGLV(Q, "G2");
		testGT(e);
		testMulVec(P, "G1");
		testMulVec(Q, "G2");
		testPowVec(e);
	}
}
