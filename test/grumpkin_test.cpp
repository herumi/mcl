/*
	the class GG : the 2-cycle partner of the BN curve fixed by MCL_USE_GRUMPKIN
	1 : Grumpkin : y^2 = x^3 - 17 over the Fr of BN_SNARK1, the order is the p of BN_SNARK1
	2 : Grumpkin382 : y^2 = x^3 + 2 over the Fr of BN382, the order is the p of BN382
	G1 / G2 / GT of the BN curve and GG are used at the same time
*/
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/bn.hpp>
#include <vector>

using namespace mcl;

cybozu::XorShift g_rg;

#if MCL_USE_GRUMPKIN == 1
const int g_bnType = MCL_BN_SNARK1;
const int g_ggType = MCL_GRUMPKIN;
const int g_otherMode = 2;
#else
const int g_bnType = MCL_BN382;
const int g_ggType = MCL_GRUMPKIN382;
const int g_otherMode = 1;
#endif

// the random points are multiples of the base point
void setRandom(GG& P)
{
	Fp s;
	s.setByCSPRNG(g_rg);
	GG::mul(P, getGGbasePoint(), s);
}

CYBOZU_TEST_AUTO(init)
{
	// initGrumpkin fails without changing anything if the mode is not the MCL_USE_GRUMPKIN of the library
	{
		const int modeTbl[] = { g_otherMode, 0, -1, 3 };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(modeTbl); i++) {
			bool b = true;
			initGrumpkin(&b, modeTbl[i]);
			CYBOZU_TEST_ASSERT(!b);
			CYBOZU_TEST_EXCEPTION(initGrumpkin(modeTbl[i]), cybozu::Exception);
			CYBOZU_TEST_EQUAL(Fp::getOp().mp, 0);
			CYBOZU_TEST_EQUAL(Fr::getOp().mp, 0);
		}
	}
	// initGrumpkin calls initPairing
	initGrumpkin();
	CYBOZU_TEST_EQUAL(getCurveType(), g_bnType);
	CYBOZU_TEST_EQUAL(Fp::getOp().mp, mpz_class(getEcParam(g_ggType)->n));
	CYBOZU_TEST_EQUAL(Fr::getOp().mp, mpz_class(getEcParam(g_ggType)->p));
	// the base field of GG is Fr and the scalar field is Fp
	CYBOZU_TEST_EQUAL(sizeof(GG), sizeof(Fr) * 3);
	CYBOZU_TEST_EQUAL(GG::getSerializedByteSize(), Fr::getByteSize());
	const GG& G = getGGbasePoint();
	CYBOZU_TEST_ASSERT(!G.isZero());
	CYBOZU_TEST_ASSERT(G.isValid());
	CYBOZU_TEST_ASSERT(G.isNormalized());
#if MCL_USE_GRUMPKIN == 1
	CYBOZU_TEST_EQUAL(G.x, 1);
	CYBOZU_TEST_EQUAL(G.y, Fr("0x2cf135e7506a45d632d270d45f1181294833fc48d823f272c"));
	// y^2 = x^3 - 17
	Fr t;
	Fr::sqr(t, G.y);
	CYBOZU_TEST_EQUAL(t, Fr(1) - 17);
#else
	// (-1, 1) on y^2 = x^3 + 2
	CYBOZU_TEST_EQUAL(G.x, -1);
	CYBOZU_TEST_EQUAL(G.y, 1);
	CYBOZU_TEST_EQUAL(Fp::getBitSize(), 382u);
	CYBOZU_TEST_EQUAL(Fr::getBitSize(), 382u);
	CYBOZU_TEST_EQUAL(int(MCL_BN382), int(MCL_BN381_1));
	CYBOZU_TEST_ASSERT(mcl::BN382 == mcl::BN381_1);
#endif
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
	const mcl::EcParam *para = getEcParam(g_ggType);
	CYBOZU_TEST_ASSERT(para);
	CYBOZU_TEST_EQUAL(mpz_class(para->p), Fr::getOp().mp);
	CYBOZU_TEST_EQUAL(mpz_class(para->n), Fp::getOp().mp);
}

// MCL_USE_GRUMPKIN=1 : the AVX-512 IFMA kernels of G1 (BN_SNARK1) and GG are registered at the same time (the two instances of src/msm_avx_impl.hpp)
// MCL_USE_GRUMPKIN=2 : no kernel
CYBOZU_TEST_AUTO(msmKernel)
{
	const bool ifma = (mcl::bint::getCpuType() & mcl::bint::tAVX512_IFMA) != 0;
	printf("AVX-512 IFMA=%d G1::msmKernel=%d GG::msmKernel=%d G1::mulEachOpti=%d GG::mulEachOpti=%d\n",
		ifma, G1::msmKernel != 0, GG::msmKernel != 0, G1::mulEachOpti != 0, GG::mulEachOpti != 0);
#if MCL_MSM == 1 && MCL_USE_GRUMPKIN == 1
	CYBOZU_TEST_EQUAL(G1::msmKernel != 0, ifma);
	CYBOZU_TEST_EQUAL(GG::msmKernel != 0, ifma);
	CYBOZU_TEST_EQUAL(GG::mulEachOpti != 0, ifma);
	if (ifma) {
		CYBOZU_TEST_ASSERT(GG::msmKernel != G1::msmKernel);
		CYBOZU_TEST_ASSERT(GG::msmKernel->batchMinN > 0);
	}
#else
	CYBOZU_TEST_ASSERT(GG::msmKernel == 0);
	CYBOZU_TEST_ASSERT(GG::mulEachOpti == 0);
#endif
#if MCL_USE_GRUMPKIN == 2
	CYBOZU_TEST_ASSERT(G1::msmKernel == 0);
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

void setRandom(G1& P)
{
	Fr s;
	s.setByCSPRNG(g_rg);
	hashAndMapToG1(P, "foldVec", 7);
	G1::mul(P, P, s);
}

// z[i] = sum_{t<n} yVec[t] xVec[t * stride + i]
template<class G>
void foldVecTest()
{
	typedef typename G::Fr F;
	const size_t maxN = 18; // > mcl::fp::maxMulVecNGLV : the generic one
	const size_t stride = 300;
	std::vector<G> base(maxN * stride), xVec, z(stride), ok(stride);
	for (size_t i = 0; i < base.size(); i++) setRandom(base[i]);
	G::normalizeVec(base.data(), base.data(), base.size());
	// the special points
	base[0 * stride + 0].clear();
	base[1 * stride + 1] = base[0 * stride + 1]; // the same point
	G::neg(base[1 * stride + 2], base[0 * stride + 2]); // the negative
	for (size_t t = 0; t < maxN; t++) base[t * stride + 3].clear(); // the output is zero
	for (size_t t = 0; t < maxN; t++) base[t * stride + 4] = base[4]; // all the same
	for (size_t t = 0; t < maxN; t++) base[t * stride + 5] = (t & 1) ? base[stride + 5] : base[5];
	std::vector<F> yVec(maxN);
	const size_t nTbl[] = { 1, 2, 3, 4, 8, 15, 16, 17, 18 };
	const size_t mTbl[] = { 1, 6, 31, 32, 33, 255, 256, 257, 300 };
	for (int mode = 0; mode < 5; mode++) {
		for (size_t t = 0; t < maxN; t++) yVec[t].setByCSPRNG(g_rg);
		switch (mode) {
		case 1: for (size_t t = 0; t < maxN; t++) yVec[t] = 1; break;
		case 2: for (size_t t = 0; t < maxN; t++) yVec[t] = 0; break;
		case 3: yVec[0] = -1; yVec[1] = 2; yVec[2] = 0; yVec[3] = yVec[4]; break;
		case 4: yVec[0] = 1; yVec[1] = yVec[0]; yVec[2] = -yVec[3]; break; // the same and the opposite scalars
		default: break;
		}
		xVec = base;
		if (mode == 3) {
			// a non-normalized point : the generic one
			G::dbl(xVec[40], xVec[40]);
			G::dbl(xVec[stride + 290], xVec[stride + 290]);
		}
		for (size_t ni = 0; ni < CYBOZU_NUM_OF_ARRAY(nTbl); ni++) {
			const size_t n = nTbl[ni];
			for (size_t i = 0; i < stride; i++) {
				ok[i].clear();
				for (size_t t = 0; t < n; t++) {
					G T;
					G::mul(T, xVec[t * stride + i], yVec[t]);
					ok[i] += T;
				}
			}
			for (size_t mi = 0; mi < CYBOZU_NUM_OF_ARRAY(mTbl); mi++) {
				const size_t m = mTbl[mi];
				const size_t off = stride - m; // the tail of each row
				for (size_t i = 0; i < m; i++) z[i] = xVec[0];
				G::foldVec(z.data(), xVec.data() + off, yVec.data(), n, m, stride);
				bool same = true;
				for (size_t i = 0; i < m; i++) {
					if (z[i] != ok[off + i] || !z[i].isNormalized()) same = false;
				}
				CYBOZU_TEST_ASSERT(same);
				if (!same) printf("foldVec mode=%d n=%d m=%d\n", mode, (int)n, (int)m);
			}
		}
	}
}

CYBOZU_TEST_AUTO(foldVec)
{
	CYBOZU_TEST_ASSERT(G1::foldVecOpti != 0);
	CYBOZU_TEST_ASSERT(GG::foldVecOpti != 0);
	foldVecTest<G1>();
	foldVecTest<GG>();
	// without the batch affine version
	G1::FoldVecOptiFunc f = G1::foldVecOpti;
	G1::setFoldVecOpti(0);
	foldVecTest<G1>();
	G1::setFoldVecOpti(f);
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
		// G1 of the BN curve for comparison (the same cost if the kernels of both are available)
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

// the initialization of another curve / modulus fails and does not break the current state
CYBOZU_TEST_AUTO(otherCurve)
{
	initGrumpkin();
	const mpz_class p = Fp::getOp().mp;
	const mpz_class r = Fr::getOp().mp;
	G1 P;
	G2 Q;
	hashAndMapToG1(P, "abc");
	hashAndMapToG2(Q, "abc");
	Fp12 e1;
	pairing(e1, P, Q);
	bool b;
	initPairing(&b, mcl::BN254);
	CYBOZU_TEST_ASSERT(!b);
	initPairing(&b); // the default parameter is BN254
	CYBOZU_TEST_ASSERT(!b);
	{
		// the other pairing curves (BN_SNARK1 for BN382, BN382 for BN_SNARK1, ...)
		const int typeTbl[] = { MCL_BN254, MCL_BN382, MCL_BN381_2, MCL_BN_SNARK1, MCL_BLS12_381, MCL_BLS12_377 };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(typeTbl); i++) {
			if (typeTbl[i] == g_bnType) continue;
			initPairing(&b, *mcl::getCurveParam(typeTbl[i]));
			CYBOZU_TEST_ASSERT(!b);
		}
		// the partner of the other mode
		const int otherGG = (g_ggType == MCL_GRUMPKIN) ? MCL_GRUMPKIN382 : MCL_GRUMPKIN;
		initG1only(&b, *getEcParam(otherGG));
		CYBOZU_TEST_ASSERT(!b);
		mcl::initCurve<G1>(&b, otherGG);
		CYBOZU_TEST_ASSERT(!b);
		initG1only(&b, mcl::ecparam::secp384r1);
		CYBOZU_TEST_ASSERT(!b);
		initGrumpkin(&b, g_otherMode);
		CYBOZU_TEST_ASSERT(!b);
	}
	initG1only(&b, mcl::ecparam::secp256k1);
	CYBOZU_TEST_ASSERT(!b);
	mcl::initCurve<G1>(&b, MCL_SECP256K1);
	CYBOZU_TEST_ASSERT(!b);
	mcl::initCurve<G1>(&b, MCL_NIST_P256);
	CYBOZU_TEST_ASSERT(!b);
	const char *otherTbl[] = {
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013", // the p of BN254
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // the p of secp256k1
		"0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed", // 2^255 - 19
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd49", // the p of BN_SNARK1 + 2
#if MCL_USE_GRUMPKIN == 1
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd45", // the p of BN_SNARK1 - 2
#else
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47", // the p of BN_SNARK1
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab", // the p of BLS12-381
		"0x24009015183f94892d996cc179c6d1666f82cefbe47879bba6e58dbe43002a0609480097801382be004e000000000013", // the p of BN381_2
		"0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000015", // the p of BN382 + 2
#endif
		"65537",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(otherTbl); i++) {
		Fp::init(&b, otherTbl[i]);
		CYBOZU_TEST_ASSERT(!b);
		Fr::init(&b, otherTbl[i]);
		CYBOZU_TEST_ASSERT(!b);
	}
	// the state is not broken
	CYBOZU_TEST_EQUAL(Fp::getOp().mp, p);
	CYBOZU_TEST_EQUAL(Fr::getOp().mp, r);
	CYBOZU_TEST_EQUAL(getCurveType(), g_bnType);
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(Q.isValid());
	{
		Fr a;
		a.setByCSPRNG(g_rg);
		G1 aP;
		G1::mul(aP, P, a);
		Fp12 e2, e3;
		pairing(e2, P, Q);
		CYBOZU_TEST_EQUAL(e1, e2);
		pairing(e2, aP, Q);
		Fp12::pow(e3, e1, a);
		CYBOZU_TEST_EQUAL(e2, e3);
	}
	{
		// the order of GG is the p of the BN curve
		GG R;
		GG::mul(R, getGGbasePoint(), Fp(-1));
		R += getGGbasePoint();
		CYBOZU_TEST_ASSERT(R.isZero());
	}
	// the moduli of the fixed curve are accepted again
	initPairing(&b, *mcl::getCurveParam(g_bnType));
	CYBOZU_TEST_ASSERT(b);
	initGrumpkin(&b);
	CYBOZU_TEST_ASSERT(b);
	{
		GG R;
		GG::mul(R, getGGbasePoint(), Fp(-1));
		R += getGGbasePoint();
		CYBOZU_TEST_ASSERT(R.isZero());
	}
	// G1 as the partner curve by initCurve<G1> exchanges Fp and Fr ; initGrumpkin restores them by initPairing
	{
		G1 P0;
		mcl::initCurve<G1>(&b, g_ggType, &P0);
		CYBOZU_TEST_ASSERT(b);
		CYBOZU_TEST_EQUAL(Fp::getOp().mp, r);
		CYBOZU_TEST_EQUAL(Fr::getOp().mp, p);
		G1 P1, P2;
		Fr s;
		s.setByCSPRNG(g_rg);
		G1::mul(P1, P0, s); // GLV
		G1::mulGeneric(P2, P0, s.getMpz());
		CYBOZU_TEST_EQUAL(P1, P2);
		initGrumpkin(&b);
		CYBOZU_TEST_ASSERT(b);
		CYBOZU_TEST_EQUAL(Fp::getOp().mp, p);
		CYBOZU_TEST_EQUAL(Fr::getOp().mp, r);
		CYBOZU_TEST_EQUAL(getCurveType(), g_bnType);
		G1 P3;
		G2 Q3;
		hashAndMapToG1(P3, "abc");
		hashAndMapToG2(Q3, "abc");
		Fp12 e2;
		pairing(e2, P3, Q3);
		CYBOZU_TEST_EQUAL(e1, e2);
		GG R;
		GG::mul(R, getGGbasePoint(), Fp(-1));
		R += getGGbasePoint();
		CYBOZU_TEST_ASSERT(R.isZero());
	}
}
