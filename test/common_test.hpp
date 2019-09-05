void testMulVec()
{
	using namespace mcl::bn;
	const size_t n = 3;
	G1 xVec[n];
	Fr yVec[n];
	G1 ok;
	ok.clear();
	char c = 'a';
	for (size_t i = 0; i < n; i++) {
		hashAndMapToG1(xVec[i], &c, 1);
		yVec[i].setByCSPRNG();
		G1 t;
		G1::mul(t, xVec[i], yVec[i]);
		ok += t;
	}
	G1 z;
	G1::mulVec(z, xVec, yVec, n);
	CYBOZU_TEST_EQUAL(z, ok);
	CYBOZU_BENCH_C("mulVec(new)", 1000, G1::mulVec, z, xVec, yVec, n);
	CYBOZU_BENCH_C("mulVec(old)", 1000, G1::mulVec, z, xVec, yVec, n, true);
}

void testCommon()
{
	testMulVec();
}
