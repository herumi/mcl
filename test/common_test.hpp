template<class G, class F>
void naiveMulVec(G& out, const G *xVec, const F *yVec, size_t n)
{
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
	mcl::bn::Fr yVec[N];

	for (size_t i = 0; i < N; i++) {
		G::mul(xVec[i], P, i + 3);
		yVec[i].setByCSPRNG();
	}
	const size_t nTbl[] = { 1, 2, 3, 5, 30, 31, 32, 33 };
	const int C = 400;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		G Q1, Q2;
		CYBOZU_TEST_ASSERT(n <= N);
		naiveMulVec(Q1, xVec, yVec, n);
		G::mulVec(Q2, xVec, yVec, n);
		CYBOZU_TEST_EQUAL(Q1, Q2);
		printf("n=%zd\n", n);
		CYBOZU_BENCH_C("naive ", C, naiveMulVec, Q1, xVec, yVec, n);
		CYBOZU_BENCH_C("mulVec", C, G::mulVec, Q1, xVec, yVec, n);
	}
}

template<class G1, class G2>
void testCommon(const G1& P, const G2&)
{
	testMulVec(P);
}
