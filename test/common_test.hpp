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
void testMulVec(const G& P)
{
	using namespace mcl::bn;
	const int N = 33;
	G xVec[N];
	Fr yVec[N];

	for (size_t i = 0; i < N; i++) {
		G::mul(xVec[i], P, i + 3);
		yVec[i].setByCSPRNG();
	}
	const size_t nTbl[] = { 1, 2, 3, 5, 7, 8, 9, 14, 15, 16, 30, 31, 32, 33 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		G Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naiveMulVec(Q1, xVec, yVec, n);
		G::mulVec(Q2, xVec, yVec, n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
#if 0//#ifdef NDEBUG
		printf("n=%zd\n", n);
		const int C = 400;
		CYBOZU_BENCH_C("naive ", C, naiveMulVec, Q1, xVec, yVec, n);
		CYBOZU_BENCH_C("mulVec", C, G::mulVec, Q1, xVec, yVec, n);
#endif
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
	for (size_t i = 0; i < N; i++) {
		if (i > 0) G::mul(xVec[i], xVec[i - 1], e);
		yVec[i].setByCSPRNG();
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

void testCommon(const G1& P, const G2& Q)
{
	puts("G1");
	testMulVec(P);
	puts("G2");
	testMulVec(Q);
	GT e;
	mcl::bn::pairing(e, P, Q);
	puts("GT");
	testPowVec(e);
}
