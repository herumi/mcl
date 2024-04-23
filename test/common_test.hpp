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
void testMulVec(const G& P)
{
	using namespace mcl::bn;
	const int N = 4096;
	std::vector<G> x0Vec(N);
	std::vector<G> xVec(N);
	std::vector<Fr> yVec(N);

	cybozu::XorShift rg;
	for (size_t i = 0; i < N; i++) {
		G::mul(x0Vec[i], P, i + 3);
		xVec[i] = x0Vec[i];
		yVec[i].setByCSPRNG(rg);
	}
	const size_t nTbl[] = { 1, 2, 3, 15, 16, 17, 32, 64, 128, 256,
#if 0
		512, 1024, 2048, N
#endif
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		G Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naiveMulVec(Q1, xVec.data(), yVec.data(), n);
		G::mulVec(Q2, xVec.data(), yVec.data(), n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
		Q2.clear();
#if 0 // #ifdef NDEBUG
		printf("n=%zd\n", n);
		const int C = 10;
		CYBOZU_BENCH_C("naive ", C, naiveMulVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("mulVec", C, G::mulVec, Q1, xVec.data(), yVec.data(), n);
		CYBOZU_BENCH_C("mulVecCopy", C, mulVecCopy, Q1, xVec.data(), yVec.data(), n, x0Vec.data());
#endif
	}
	puts("mulEach");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		xVec = x0Vec;
		G::mulEach(xVec.data(), yVec.data(), n);
		for (size_t j = 0; j < n; j++) {
			G T;
			G::mul(T, x0Vec[i], yVec[i]);
			CYBOZU_TEST_EQUAL(xVec[i], T);
		}
	}
}

template<class G>
void naivePowVec(G& out, const G *xVec, const Fr *yVec, size_t n)
{
	if (n == 1) {
		G::pow(out, xVec[0], yVec[0]);
		return;
	}
	G r, t;
	r.setOne();
	for (size_t i = 0; i < n; i++) {
		G::pow(t, xVec[i], yVec[i]);
		r *= t;
	}
	out = r;
}

template<class G>
inline void testPowVec(const G& e)
{
	using namespace mcl::bn;
	const int N = 33;
	G xVec[N];
	Fr yVec[N];

	xVec[0] = e;
	cybozu::XorShift rg;
	for (size_t i = 0; i < N; i++) {
		if (i > 0) G::mul(xVec[i], xVec[i - 1], e);
		yVec[i].setByCSPRNG(rg);
	}
	const size_t nTbl[] = { 1, 2, 3, 5, 7, 8, 9, 14, 15, 16, 30, 31, 32, 33 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		G Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naivePowVec(Q1, xVec, yVec, n);
		G::powVec(Q2, xVec, yVec, n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
#if 0//#ifdef NDEBUG
		printf("n=%zd\n", n);
		const int C = 400;
		CYBOZU_BENCH_C("naive ", C, naivePowVec, Q1, xVec, yVec, n);
		CYBOZU_BENCH_C("mulVec", C, G::powVec, Q1, xVec, yVec, n);
#endif
	}
}

template<class G>
void testMulCT(const G& P)
{
	cybozu::XorShift rg;
	G Q1, Q2;
	for (int i = 0; i < 100; i++) {
		Fr x;
		x.setByCSPRNG(rg);
		G::mul(Q1, P, x);
		G::mulCT(Q2, P, x);
		CYBOZU_TEST_EQUAL(Q1, Q2);
	}
}

void testMul2()
{
	puts("testMul2");
	cybozu::XorShift rg;
	Fp x1, x2;
	x1.setByCSPRNG(rg);
	x2 = x1;
	for (int i = 0; i < 100; i++) {
		Fp::mul2(x1, x1);
		x2 += x2;
		CYBOZU_TEST_EQUAL(x1, x2);
	}
	Fp2 y1;
	y1.a = x1;
	y1.b = -x1;
	Fp2 y2 = y1;
	for (int i = 0; i < 100; i++) {
		Fp2::mul2(y1, y1);
		y2 += y2;
		CYBOZU_TEST_EQUAL(y1, y2);
	}
}

void testABCDsub(const Fp2& a, const Fp2& b, const Fp2& c, const Fp2& d)
{
	const bool isLtQuad = Fp::getOp().isLtQuad;
	Fp2 t1, t2;
	if (isLtQuad) {
		Fp2::addPre(t1, a, b);
		Fp2::addPre(t2, c, d);
	} else {
		Fp2::add(t1, a, b);
		Fp2::add(t2, c, d);
	}
	Fp2Dbl T1, AC, BD;
	Fp2Dbl::mulPre(T1, t1, t2);
	Fp2Dbl::mulPre(AC, a, c);
	Fp2Dbl::mulPre(BD, b, d);
	if (isLtQuad) {
		Fp2Dbl::subSpecial<true>(T1, AC);
		Fp2Dbl::subSpecial<true>(T1, BD);
	} else {
		Fp2Dbl::subSpecial<false>(T1, AC);
		Fp2Dbl::subSpecial<false>(T1, BD);
	}
	Fp2Dbl::mod(t1, T1);
	CYBOZU_TEST_EQUAL(t1, a * d + b * c);
}

void testABCD()
{
	puts("testMisc1");
	// (a + b)(c + d) - ac - bd = ad + bc
	Fp2 a[4];
	a[0].a = -1;
	a[0].b = -1;
	a[1] = a[0];
	a[2] = a[0];
	a[3] = a[0];
	testABCDsub(a[0], a[1], a[2], a[3]);
	cybozu::XorShift rg;
	for (int i = 0; i < 100; i++) {
		for (int j = 0; j < 4; j++) {
			a[j].a.setByCSPRNG(rg);
			a[j].b.setByCSPRNG(rg);
		}
		testABCDsub(a[0], a[1], a[2], a[3]);
	}
}

void testFp2Dbl_mul_xi1()
{
	const uint32_t xi_a = Fp2::get_xi_a();
	if (xi_a != 1) return;
	puts("testFp2Dbl_mul_xi1");
	cybozu::XorShift rg;
	for (int i = 0; i < 10; i++) {
		Fp a1, a2;
		a1.setByCSPRNG(rg);
		a2.setByCSPRNG(rg);
		Fp2Dbl x;
		FpDbl::mulPre(x.a, a1, a2);
		a1.setByCSPRNG(rg);
		a2.setByCSPRNG(rg);
		FpDbl::mulPre(x.b, a1, a2);
		Fp2Dbl ok;
		{
			FpDbl::mulUnit(ok.a, x.a, xi_a);
			ok.a -= x.b;
			FpDbl::mulUnit(ok.b, x.b, xi_a);
			ok.b += x.a;
		}
		Fp2Dbl::mul_xi(x, x);
		CYBOZU_TEST_EQUAL_ARRAY(ok.a.getUnit(), x.a.getUnit(), ok.a.getUnitSize());
		CYBOZU_TEST_EQUAL_ARRAY(ok.b.getUnit(), x.b.getUnit(), ok.b.getUnitSize());
	}
}

void testMulSmall()
{
	puts("testMulSmall");
	cybozu::XorShift rg;
	for (int y = 0; y < 10; y++) {
		for (int i = 0; i < 40; i++) {
			Fp x, z1, z2;
			x.setByCSPRNG(rg);
			Fp::mulSmall(z1, x, y);
			z2 = x * y;
			CYBOZU_TEST_EQUAL(z1, z2);
		}
	}
}

void testCommon(const G1& P, const G2& Q)
{
	testMulSmall();
	testFp2Dbl_mul_xi1();
	testABCD();
	testMul2();
	puts("G1");
	testMulVec(P);
	puts("G2");
	testMulVec(Q);
	testMulCT(Q);
	GT e;
	mcl::bn::pairing(e, P, Q);
	puts("GT");
	testPowVec(e);
	CYBOZU_TEST_ASSERT(mcl::bn::isValidGT(e));
	GT e2 = e;
	e2 += 1;
	CYBOZU_TEST_ASSERT(!mcl::bn::isValidGT(e2));
}
