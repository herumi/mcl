#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <vector>

#include <mcl/bls12_381.hpp>
#define MCL_GLV_ONLY_FUNC
#include "../src/glv.hpp"
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
		Fr ss;
		ss.setRand(rg);
		G::mulGeneric(P1, P, ss.getMpz());
		G::mul(P2, P, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	// the edge values of the GLV split : 2^k, r - 2^k, (r - 1) >> k
	{
		const mpz_class& r = Fr::getOp().mp;
		const size_t bitSize = Fr::getBitSize();
		for (size_t k = 0; k < bitSize; k++) {
			const mpz_class pk = mpz_class(1) << k;
			const mpz_class tbl[] = { pk, r - pk, (r - 1) >> k, pk - 1 };
			for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
				Fr s;
				s.setMpz(tbl[j]);
				G::mulGeneric(P1, P, s.getMpz());
				G::mul(P2, P, s);
				CYBOZU_TEST_EQUAL(P1, P2);
			}
		}
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

/*
	special inputs for the batch affine addition of mulVec (src/glv.hpp)
	all scalars are equal, scalars in {0, 1}, zero points, P + P and P + (-P) in the same bucket
*/
template<class G>
void testMulVecSpecial(const G& P, const char *name)
{
	printf("testMulVecSpecial %s\n", name);
	const size_t N = 3000; // > MCL_MSM_BATCH_MIN_N / 2
	std::vector<G> xVec(N);
	std::vector<Fr> yVec(N);
	for (size_t i = 0; i < N; i++) {
		G::mul(xVec[i], P, i + 3);
	}
	G Q1, Q2;
	// all scalars are equal
	{
		Fr y;
		y.setByCSPRNG();
		for (size_t i = 0; i < N; i++) yVec[i] = y;
		naiveMulVec(Q1, xVec.data(), yVec.data(), N);
		G::mulVec(Q2, xVec.data(), yVec.data(), N);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
	// scalars in {0, 1}
	{
		cybozu::XorShift rg;
		for (size_t i = 0; i < N; i++) yVec[i] = rg.get32() & 1;
		naiveMulVec(Q1, xVec.data(), yVec.data(), N);
		G::mulVec(Q2, xVec.data(), yVec.data(), N);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
	// small scalars (many equal digits), zero points and equal points
	{
		cybozu::XorShift rg;
		for (size_t i = 0; i < N; i++) {
			yVec[i] = rg.get32() % 7;
			if (i % 5 == 1) xVec[i].clear();
			if (i % 5 == 2) xVec[i] = xVec[i - 1];
			if (i % 5 == 3) xVec[i] = xVec[0];
		}
		naiveMulVec(Q1, xVec.data(), yVec.data(), N);
		G::mulVec(Q2, xVec.data(), yVec.data(), N);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
	// P + P (doubling) and P + (-P) (zero) in a bucket : the same point with y and -y
	{
		for (size_t i = 0; i < N; i++) {
			G::mul(xVec[i], P, i / 3 + 3);
			yVec[i].setByCSPRNG();
		}
		for (size_t i = 0; i + 2 < N; i += 3) {
			yVec[i + 1] = yVec[i]; // xVec[i] + xVec[i+1] = 2 xVec[i]
			Fr::neg(yVec[i + 2], yVec[i]); // xVec[i] - xVec[i+2] = 0
		}
		naiveMulVec(Q1, xVec.data(), yVec.data(), N);
		G::mulVec(Q2, xVec.data(), yVec.data(), N);
		CYBOZU_TEST_EQUAL(Q1, Q2);
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
//		{ mcl::BN_P256, "BN_P256" },
#if MCL_FP_BIT >= 384
		{ mcl::BLS12_377, "BLS12_377" },
		{ mcl::BLS12_381, "BLS12_381" },
#endif
		{ mcl::BN254, "BN254" },
		{ mcl::BN_SNARK1, "BN_SNARK1" },
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
		testMulVecSpecial(P, "G1");
		testMulVecSpecial(Q, "G2");
		testPowVec(e);
	}
}

/*
	the cost model of the window size b (glvGetBucketSizeByCost) vs the measured one
	measured on Xeon w9-3495X by sweeping b (misc/msm_sweep.cpp, 2026-11-04) : n (split) scalars of 128 bits of G1,
	[lo, hi] is the range of b whose time is within 6% of the best (the valley is shallow)
	n >= 2^19 is bounded by MCL_MSM_MAX_TBL_BYTES, so it is not tested here
*/
CYBOZU_TEST_AUTO(bucketSizeModel)
{
	const size_t nTbl[] = { 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144 };
	const size_t N = CYBOZU_NUM_OF_ARRAY(nTbl);
	const struct {
		const char *name;
		const mcl::ec::MsmCostParam *prm;
		size_t lo[N];
		size_t hi[N];
	} tbl[] = {
		{ "generic BLS12-381", &mcl::ec::msmCostParamGeneric(), { 5, 6, 7, 8, 8, 9, 10, 10, 12, 12, 12, 13 }, { 6, 7, 8, 8, 10, 11, 12, 13, 13, 13, 13, 15 } },
		{ "generic BN254", &mcl::ec::msmCostParamGeneric(), { 5, 6, 6, 7, 8, 9, 10, 10, 11, 12, 12, 13 }, { 6, 7, 8, 9, 10, 11, 12, 13, 13, 13, 14, 14 } },
		{ "batch BLS12-381", &mcl::ec::msmCostParamBatch(), { 5, 5, 6, 7, 8, 8, 9, 10, 10, 11, 12, 13 }, { 6, 7, 8, 8, 9, 10, 10, 11, 13, 13, 13, 15 } },
		{ "batch BN254", &mcl::ec::msmCostParamBatch(), { 6, 6, 6, 7, 7, 8, 9, 9, 10, 11, 12, 13 }, { 6, 7, 8, 8, 9, 10, 10, 12, 13, 13, 14, 15 } },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		for (size_t j = 0; j < N; j++) {
			const size_t n = nTbl[j];
			const size_t b = mcl::ec::glvGetBucketSizeByCost(n, 128, sizeof(G1), *tbl[i].prm);
			const bool ok = tbl[i].lo[j] <= b && b <= tbl[i].hi[j];
			CYBOZU_TEST_ASSERT(ok);
			if (!ok) printf("%s n=%zd model b=%zd measured [%zd, %zd]\n", tbl[i].name, n, b, tbl[i].lo[j], tbl[i].hi[j]);
		}
	}
	// the window size is bounded by MCL_MSM_MAX_TBL_BYTES (2 MiB) : 2^(b-1) * sizeof(G1) <= 2 MiB
	for (size_t n = 1 << 19; n <= (size_t(1) << 24); n *= 4) {
		const size_t b = mcl::ec::glvGetBucketSizeByCost(n, 128, sizeof(G1), mcl::ec::msmCostParamBatch());
		CYBOZU_TEST_ASSERT((size_t(1) << (b - 1)) * sizeof(G1) <= MCL_MSM_MAX_TBL_BYTES);
	}
}
