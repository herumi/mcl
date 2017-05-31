/*
	include from bn_if256_test.cpp and bn_if384_test.cpp
*/
#include <mcl/bn.h>
#include <cybozu/test.hpp>
#include <iostream>

template<size_t N>
std::ostream dump(std::ostream& os, const uint64_t (&x)[N])
{
	for (size_t i = 0; i < N; i++) {
		char buf[64];
		CYBOZU_SNPRINTF(buf, sizeof(buf), "%016llx", (long long)x[i]);
		os << buf;
	}
	return os;
}

CYBOZU_TEST_AUTO(init)
{
	int ret;
	CYBOZU_TEST_EQUAL(sizeof(MCLBN_Fr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(MCLBN_G1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(MCLBN_G2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(MCLBN_GT), sizeof(Fp12));

	ret = MCLBN_setErrFile("stderr");
	CYBOZU_TEST_EQUAL(ret, 0);

#if MCLBN_FP_UNIT_SIZE == 4
	printf("test MCLBN_curveFp254BNb %d\n", MCLBN_FP_UNIT_SIZE);
	ret = MCLBN_initLib(MCLBN_curveFp254BNb, MCLBN_FP_UNIT_SIZE);
#else
	printf("test MCLBN_curveFp382_1 %d\n", MCLBN_FP_UNIT_SIZE);
	ret = MCLBN_initLib(MCLBN_curveFp382_1, MCLBN_FP_UNIT_SIZE);
#endif
	CYBOZU_TEST_EQUAL(ret, 0);
}

CYBOZU_TEST_AUTO(Fr)
{
	MCLBN_Fr x, y;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_isValid(&x));
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isValid(&x));
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_isZero(&x));

	MCLBN_Fr_clear(&x);
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isZero(&x));

	MCLBN_Fr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isOne(&x));

	MCLBN_Fr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_isEqual(&x, &y));

	y = x;
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isEqual(&x, &y));

	MCLBN_hashToFr(&x, "", 0);
	MCLBN_hashToFr(&y, "abc", 3);
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_isEqual(&x, &y));
	MCLBN_hashToFr(&x, "abc", 3);
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isEqual(&x, &y));

	char buf[1024];
	MCLBN_Fr_setInt(&x, 12345678);
	size_t size;
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 8);
	CYBOZU_TEST_EQUAL(buf, "12345678");

	MCLBN_Fr_setInt(&x, -7654321);
	MCLBN_Fr_neg(&x, &x);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 7);
	CYBOZU_TEST_EQUAL(buf, "7654321");

	MCLBN_Fr_setInt(&y, 123 - 7654321);
	MCLBN_Fr_add(&x, &x, &y);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 3);
	CYBOZU_TEST_EQUAL(buf, "123");

	MCLBN_Fr_setInt(&y, 100);
	MCLBN_Fr_sub(&x, &x, &y);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	MCLBN_Fr_mul(&x, &x, &y);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 4);
	CYBOZU_TEST_EQUAL(buf, "2300");

	MCLBN_Fr_div(&x, &x, &y);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	CYBOZU_TEST_ASSERT(!MCLBN_Fr_setDecStr(&x, "12345678901234567", 17));
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_setDecStr(&y, "20000000000000000", 17));
	MCLBN_Fr_add(&x, &x, &y);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 17);
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	MCLBN_Fr_setInt(&x, 1);
	MCLBN_Fr_neg(&x, &x);
	size = MCLBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MCLBN_Fr_setDecStr(&y, buf, size));
	CYBOZU_TEST_ASSERT(MCLBN_Fr_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	MCLBN_G1 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MCLBN_G1_isValid(&x));
	MCLBN_G1_clear(&x);
	CYBOZU_TEST_ASSERT(MCLBN_G1_isValid(&x));
	CYBOZU_TEST_ASSERT(MCLBN_G1_isZero(&x));

	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG1(&y, "abc", 3));

	char buf[1024];
	size_t size;
	size = MCLBN_G1_getHexStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MCLBN_G1_setHexStr(&y, buf, strlen(buf)));
	CYBOZU_TEST_ASSERT(MCLBN_G1_isEqual(&x, &y));

	MCLBN_G1_neg(&x, &x);
	MCLBN_G1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(MCLBN_G1_isZero(&x));

	MCLBN_G1_dbl(&x, &y); // x = 2y
	MCLBN_G1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(MCLBN_G1_isEqual(&x, &z));
	MCLBN_G1_add(&z, &z, &y); // z = 3y
	MCLBN_Fr n;
	MCLBN_Fr_setInt(&n, 3);
	MCLBN_G1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(MCLBN_G1_isEqual(&x, &z));
	MCLBN_G1_sub(&x, &x, &y); // x = 2y

	MCLBN_Fr_setInt(&n, 2);
	MCLBN_G1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(MCLBN_G1_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	MCLBN_G2 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MCLBN_G2_isValid(&x));
	MCLBN_G2_clear(&x);
	CYBOZU_TEST_ASSERT(MCLBN_G2_isValid(&x));
	CYBOZU_TEST_ASSERT(MCLBN_G2_isZero(&x));

	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG2(&x, "abc", 3));

	char buf[1024];
	size_t size;
	size = MCLBN_G2_getHexStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MCLBN_G2_setHexStr(&y, buf, strlen(buf)));
	CYBOZU_TEST_ASSERT(MCLBN_G2_isEqual(&x, &y));

	MCLBN_G2_neg(&x, &x);
	MCLBN_G2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(MCLBN_G2_isZero(&x));

	MCLBN_G2_dbl(&x, &y); // x = 2y
	MCLBN_G2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(MCLBN_G2_isEqual(&x, &z));
	MCLBN_G2_add(&z, &z, &y); // z = 3y
	MCLBN_Fr n;
	MCLBN_Fr_setInt(&n, 3);
	MCLBN_G2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(MCLBN_G2_isEqual(&x, &z));
	MCLBN_G2_sub(&x, &x, &y); // x = 2y

	MCLBN_Fr_setInt(&n, 2);
	MCLBN_G2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(MCLBN_G2_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	MCLBN_GT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!MCLBN_GT_isZero(&x));

	MCLBN_GT_clear(&x);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isZero(&x));

	char buf[2048];
	const char *s = "1 2 3 4 5 6 7 8 9 10 11 12";
	size_t size;
	CYBOZU_TEST_ASSERT(!MCLBN_GT_setDecStr(&x,s , strlen(s)));
	size = MCLBN_GT_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, s);

	y = x;
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&x, &y));

	s = "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12";
	CYBOZU_TEST_ASSERT(!MCLBN_GT_setDecStr(&z, s, strlen(s)));
	size = MCLBN_GT_getDecStr(buf, sizeof(buf), &z);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MCLBN_GT_setDecStr(&y, buf, size));

	MCLBN_GT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&x, &z));

	MCLBN_GT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isZero(&y));

	s = "2 0 0 0 0 0 0 0 0 0 0 0";
	CYBOZU_TEST_ASSERT(!MCLBN_GT_setDecStr(&y, s, strlen(s)));
	MCLBN_GT_mul(&z, &x, &y);
	size = MCLBN_GT_getDecStr(buf, sizeof(buf), &z);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	MCLBN_GT_div(&z, &z, &y);
	size = MCLBN_GT_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&x, &z));

	MCLBN_Fr n;
	MCLBN_Fr_setInt(&n, 3);
	MCLBN_GT_pow(&z, &x, &n);
	MCLBN_GT_mul(&y, &x, &x);
	MCLBN_GT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(pairing)
{
	MCLBN_Fr a, b, ab;
	MCLBN_Fr_setInt(&a, 123);
	MCLBN_Fr_setInt(&b, 456);
	MCLBN_Fr_mul(&ab, &a, &b);
	MCLBN_G1 P, aP;
	MCLBN_G2 Q, bQ;
	MCLBN_GT e, e1, e2;

	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG1(&P, "1", 1));
	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG2(&Q, "1", 1));

	MCLBN_G1_mul(&aP, &P, &a);
	MCLBN_G2_mul(&bQ, &Q, &b);

	MCLBN_pairing(&e, &P, &Q);
	MCLBN_GT_pow(&e1, &e, &a);
	MCLBN_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&e1, &e2));

	MCLBN_GT_pow(&e1, &e, &b);
	MCLBN_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&e1, &e2));
}

CYBOZU_TEST_AUTO(precomputed)
{
	MCLBN_G1 P1, P2;
	MCLBN_G2 Q1, Q2;
	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG1(&P1, "1", 1));
	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG1(&P2, "123", 3));
	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG2(&Q1, "1", 1));
	CYBOZU_TEST_ASSERT(!MCLBN_hashAndMapToG2(&Q2, "2", 1));

	const int size = MCLBN_getUint64NumToPrecompute();
	std::vector<uint64_t> Q1buf, Q2buf;
	Q1buf.resize(size);
	Q2buf.resize(size);
	MCLBN_precomputeG2(Q1buf.data(), &Q1);
	MCLBN_precomputeG2(Q2buf.data(), &Q2);

	MCLBN_GT e1, e2, f1, f2, f3;
	MCLBN_pairing(&e1, &P1, &Q1);
	MCLBN_precomputedMillerLoop(&f1, &P1, Q1buf.data());
	MCLBN_finalExp(&f1, &f1);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&e1, &f1));

	MCLBN_pairing(&e2, &P2, &Q2);
	MCLBN_precomputedMillerLoop(&f2, &P2, Q2buf.data());
	MCLBN_finalExp(&f2, &f2);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&e2, &f2));

	MCLBN_precomputedMillerLoop2(&f3, &P1, Q1buf.data(), &P2, Q2buf.data());
	MCLBN_finalExp(&f3, &f3);

	MCLBN_GT_mul(&e1, &e1, &e2);
	CYBOZU_TEST_ASSERT(MCLBN_GT_isEqual(&e1, &f3));
}

CYBOZU_TEST_AUTO(end)
{
	int ret = MCLBN_setErrFile("bn_if.log");
	CYBOZU_TEST_EQUAL(ret, 0);
}
