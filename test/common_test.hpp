void testMulVec()
{
	using namespace mcl::bn;
	const size_t n = 5;
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
}

void testCommon()
{
	testMulVec();
}
