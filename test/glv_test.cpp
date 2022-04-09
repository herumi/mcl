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
void testGLV(const G& P)
{
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
	}
	for (int i = 1; i < 100; i++) {
		Fr s;
		s.setRand(rg);
		G::mulGeneric(P1, P, s.getMpz());
		G::mul(P2, P, s);
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
	mcl::ec::mulVecLong(z, x, y, n);
}

template<class G>
void testMulVec(const G& P)
{
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
		Q2.clear();
		mcl::ec::mulVecLong(Q2, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
#ifdef NDEBUG
		printf("n=%zd\n", n);
		const int C = 10;
		CYBOZU_BENCH_C("naive ", C, naiveMulVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("mulVec", C, G::mulVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("mulVecLong", C, mulVecCopy, Q1, xVec.data(), yVec.data(), n, x0Vec.data());
		CYBOZU_BENCH_C("mulVecLong(normalized)", C, mcl::ec::mulVecLong, Q1, xVec.data(), yVec.data(), n);
#endif
	}
}


void testGT()
{
	G1 P;
	G2 Q;
	GT x, y, z;
	hashAndMapToG1(P, "abc", 3);
	hashAndMapToG2(Q, "abc", 3);
	pairing(x, P, Q);
	int n = 200;
	y = x;
	for (int i = 0; i < n; i++) {
		y *= y;
	}
	mpz_class t = 1;
	t <<= n;
	GT::pow(z, x, t);
	CYBOZU_TEST_EQUAL(y, z);
}

CYBOZU_TEST_AUTO(glv)
{
	const mcl::CurveParam tbl[] = {
		mcl::BN254,
		mcl::BLS12_381,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const mcl::CurveParam& cp = tbl[i];
		initPairing(cp);
		G1 P;
		G2 Q;
		mapToG1(P, 1);
		mapToG2(Q, 1);
		testGLV(P);
		testGLV(Q);
		testGT();
		testMulVec(P);
		testMulVec(Q);
	}
}
