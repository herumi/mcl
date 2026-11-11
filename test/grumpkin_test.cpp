/*
	Grumpkin (class GG) : y^2 = x^3 - 17 over the Fr of BN_SNARK1, the order is the p of BN_SNARK1
	the 2-cycle with BN_SNARK1 : G1 / G2 / GT of BN_SNARK1 and GG are used at the same time
*/
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/bn.hpp>
#include <vector>

using namespace mcl;

cybozu::XorShift g_rg;

// the random points are multiples of the base point
void setRandom(GG& P)
{
	Fp s;
	s.setByCSPRNG(g_rg);
	GG::mul(P, getGGbasePoint(), s);
}

CYBOZU_TEST_AUTO(init)
{
	initPairing(mcl::BN_SNARK1);
	initGrumpkin();
	// the base field of GG is Fr and the scalar field is Fp
	CYBOZU_TEST_EQUAL(sizeof(GG), sizeof(Fr) * 3);
	CYBOZU_TEST_EQUAL(GG::getSerializedByteSize(), Fr::getByteSize());
	const GG& G = getGGbasePoint();
	CYBOZU_TEST_ASSERT(!G.isZero());
	CYBOZU_TEST_ASSERT(G.isValid());
	CYBOZU_TEST_ASSERT(G.isNormalized());
	CYBOZU_TEST_EQUAL(G.x, 1);
	CYBOZU_TEST_EQUAL(G.y, Fr("0x2cf135e7506a45d632d270d45f1181294833fc48d823f272c"));
	// y^2 = x^3 - 17
	Fr t;
	Fr::sqr(t, G.y);
	CYBOZU_TEST_EQUAL(t, Fr(1) - 17);
	// the order is p (= the modulus of Fp)
	const mpz_class& p = Fp::getOp().mp;
	GG Q;
	GG::mulGeneric(Q, G, p);
	CYBOZU_TEST_ASSERT(Q.isZero());
	GG::mul(Q, G, p);
	CYBOZU_TEST_ASSERT(Q.isZero());
	GG::mulGeneric(Q, G, p - 1);
	CYBOZU_TEST_EQUAL(Q, -G);
	Fp s = -1; // p - 1
	GG::mul(Q, G, s);
	CYBOZU_TEST_EQUAL(Q, -G);
	Q = G * s;
	CYBOZU_TEST_EQUAL(Q, -G);
	// the parameters of EcParam
	const mcl::EcParam *para = getEcParam(MCL_GRUMPKIN);
	CYBOZU_TEST_ASSERT(para);
	CYBOZU_TEST_EQUAL(mpz_class(para->p), Fr::getOp().mp);
	CYBOZU_TEST_EQUAL(mpz_class(para->n), Fp::getOp().mp);
}

// the pairing of BN_SNARK1 is not broken by initGrumpkin
// the AVX-512 IFMA kernels of G1 (BN_SNARK1) and GG are registered at the same time (the two instances of src/msm_avx_impl.hpp)
CYBOZU_TEST_AUTO(msmKernel)
{
	const bool ifma = (mcl::bint::getCpuType() & mcl::bint::tAVX512_IFMA) != 0;
	printf("AVX-512 IFMA=%d G1::msmKernel=%d GG::msmKernel=%d G1::mulEachOpti=%d GG::mulEachOpti=%d\n",
		ifma, G1::msmKernel != 0, GG::msmKernel != 0, G1::mulEachOpti != 0, GG::mulEachOpti != 0);
#if MCL_MSM == 1
	CYBOZU_TEST_EQUAL(G1::msmKernel != 0, ifma);
	CYBOZU_TEST_EQUAL(GG::msmKernel != 0, ifma);
	CYBOZU_TEST_EQUAL(GG::mulEachOpti != 0, ifma);
	if (ifma) {
		CYBOZU_TEST_ASSERT(GG::msmKernel != G1::msmKernel);
		CYBOZU_TEST_ASSERT(GG::msmKernel->batchMinN > 0);
	}
#else
	CYBOZU_TEST_ASSERT(GG::msmKernel == 0);
#endif
}

CYBOZU_TEST_AUTO(pairing)
{
	G1 P;
	G2 Q;
	hashAndMapToG1(P, "abc");
	hashAndMapToG2(Q, "abc");
	Fr a;
	a.setByCSPRNG(g_rg);
	GT e1, e2;
	pairing(e1, P, Q);
	GT::pow(e1, e1, a);
	G1 aP;
	G1::mul(aP, P, a);
	pairing(e2, aP, Q);
	CYBOZU_TEST_EQUAL(e1, e2);
	CYBOZU_TEST_ASSERT(e1 != 1);
}

// mul (the GLV method) and mulGeneric must agree for the edge scalars of the GLV split
CYBOZU_TEST_AUTO(glv)
{
	const GG& G = getGGbasePoint();
	GG P;
	setRandom(P);
	const mpz_class& p = Fp::getOp().mp;
	const size_t bitSize = Fp::getBitSize();
	GG P1, P2;
	for (size_t k = 0; k < bitSize; k++) {
		const mpz_class pk = mpz_class(1) << k;
		const mpz_class tbl[] = { pk, p - pk, (p - 1) >> k, pk - 1 };
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
			Fp s;
			s.setMpz(tbl[j]);
			GG::mulGeneric(P1, P, s.getMpz());
			GG::mul(P2, P, s);
			CYBOZU_TEST_EQUAL(P1, P2);
			GG::mulCT(P2, P, s);
			CYBOZU_TEST_EQUAL(P1, P2);
		}
	}
	for (int i = 0; i < 100; i++) {
		Fp s;
		s.setByCSPRNG(g_rg);
		GG::mulGeneric(P1, G, s.getMpz());
		GG::mul(P2, G, s);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
}

void naiveMulVec(GG& z, const GG *xVec, const Fp *yVec, size_t n)
{
	z.clear();
	for (size_t i = 0; i < n; i++) {
		GG t;
		GG::mulGeneric(t, xVec[i], yVec[i].getMpz());
		z += t;
	}
}

// mulVec of the NAF method (small n), mulVecGLVsmall and the bucket method with the generic batch affine addition (n * 2 >= MCL_MSM_MIN_SPLIT_N = 80)
CYBOZU_TEST_AUTO(mulVec)
{
	const size_t N = 5000;
	std::vector<GG> xVec(N), xVec2(N);
	std::vector<Fp> yVec(N);
	for (size_t i = 0; i < N; i++) {
		setRandom(xVec[i]);
		yVec[i].setByCSPRNG(g_rg);
	}
	// the special points and scalars
	xVec[0].clear();
	xVec[7].clear();
	xVec[N - 1].clear();
	yVec[1] = 0;
	yVec[2] = 1;
	yVec[3] = -1;
	xVec[4] = xVec[5]; // the same point
	GG::neg(xVec[6], xVec[5]); yVec[6] = yVec[5]; // the cancellation
	xVec[8] = xVec[9]; yVec[8] = yVec[9]; // the doubling
	for (size_t i = 10; i < 20; i++) xVec[i] = xVec[10]; // the same point for the batch addition
	// non-normalized points
	for (size_t i = 20; i < 30; i++) GG::dbl(xVec[i], xVec[i]);
	const size_t nTbl[] = { 1, 2, 3, 15, 16, 17, 39, 40, 41, 79, 80, 81, 100, 127, 128, 129, 300, 1000, N };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		GG Q1, Q2;
		naiveMulVec(Q1, xVec.data(), yVec.data(), n);
		GG::mulVecConstRef(Q2, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
		xVec2 = xVec;
		GG::mulVec(Q2, xVec2.data(), yVec.data(), n); // may normalize xVec2
		CYBOZU_TEST_EQUAL(Q1, Q2);
		GG::mulVecMT(Q2, xVec2.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
	// mulEach
	xVec2 = xVec;
	GG::mulEach(xVec2.data(), yVec.data(), 100);
	for (size_t i = 0; i < 100; i++) {
		GG Q;
		GG::mul(Q, xVec[i], yVec[i]);
		CYBOZU_TEST_EQUAL(Q, xVec2[i]);
	}
}

CYBOZU_TEST_AUTO(serialize)
{
	GG P;
	setRandom(P);
	const GG tbl[] = { P, -P, GG() };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		GG Q = tbl[i];
		if (i == 2) Q.clear();
		// the ETH serialization (the 3 flag bits of BLS12-381) does not fit the 254-bit Fr (2 spare bits), so it is not tested (the same as G1 of BN curves)
		{
			for (int comp = 0; comp < 2; comp++) {
				GG::setCompressedExpression(comp == 1);
				char buf[128];
				size_t n = Q.serialize(buf, sizeof(buf));
				CYBOZU_TEST_EQUAL(n, GG::getSerializedByteSize());
				GG R;
				size_t m = R.deserialize(buf, n);
				CYBOZU_TEST_EQUAL(m, n);
				CYBOZU_TEST_EQUAL(Q, R);
			}
			const int ioTbl[] = { 10, 16, mcl::IoEcAffine, mcl::IoEcProj, mcl::IoEcCompY };
			for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(ioTbl); j++) {
				std::string s = Q.getStr(ioTbl[j]);
				GG R;
				R.setStr(s, ioTbl[j]);
				CYBOZU_TEST_EQUAL(Q, R);
			}
		}
	}
	GG::setCompressedExpression(false);
	// an invalid point (not on the curve)
	{
		GG Q;
		bool b;
		Fr x = 2, y = 3;
		Q.set(&b, x, y);
		CYBOZU_TEST_ASSERT(!b);
	}
}

CYBOZU_TEST_AUTO(bench)
{
	const GG& G = getGGbasePoint();
	GG P, Q;
	setRandom(P);
	Fp s;
	s.setByCSPRNG(g_rg);
	CYBOZU_BENCH_C("GG::add", 10000, GG::add, Q, P, G);
	CYBOZU_BENCH_C("GG::dbl", 10000, GG::dbl, Q, P);
	CYBOZU_BENCH_C("GG::mul", 1000, GG::mul, Q, P, s);
	const size_t nTbl[] = { 1 << 10, 1 << 14 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		std::vector<GG> xVec(n);
		std::vector<Fp> yVec(n);
		for (size_t j = 0; j < n; j++) {
			setRandom(xVec[j]);
			yVec[j].setByCSPRNG(g_rg);
		}
		printf("n=%zd ", n);
		CYBOZU_BENCH_C("GG::mulVec", 3, GG::mulVec, Q, xVec.data(), yVec.data(), n);
		// G1 of BN_SNARK1 for comparison (the same cost if the kernels of both are available)
		std::vector<G1> xVec1(n);
		std::vector<Fr> yVec1(n);
		for (size_t j = 0; j < n; j++) {
			hashAndMapToG1(xVec1[j], &j, sizeof(j));
			yVec1[j].setByCSPRNG(g_rg);
		}
		G1 Q1;
		printf("n=%zd ", n);
		CYBOZU_BENCH_C("G1::mulVec", 3, G1::mulVec, Q1, xVec1.data(), yVec1.data(), n);
	}
}

// initGrumpkin fails if Fp / Fr are initialized for another curve and does not break them (keep this test last)
CYBOZU_TEST_AUTO(otherCurve)
{
	initPairing(mcl::BN254);
	const mpz_class p = Fp::getOp().mp;
	const mpz_class r = Fr::getOp().mp;
	bool b;
	initGrumpkin(&b);
	CYBOZU_TEST_ASSERT(!b);
	CYBOZU_TEST_EQUAL(Fp::getOp().mp, p);
	CYBOZU_TEST_EQUAL(Fr::getOp().mp, r);
	G1 P;
	hashAndMapToG1(P, "abc");
	CYBOZU_TEST_ASSERT(P.isValid());
}
