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
	CYBOZU_TEST_EQUAL(sizeof(mbnFr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(mbnG1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(mbnG2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(mbnGT), sizeof(Fp12));

	ret = mbn_setErrFile("stderr");
	CYBOZU_TEST_EQUAL(ret, 0);

#if MBN_FP_UNIT_SIZE == 4
	printf("test MBN_curveFp254BNb %d\n", MBN_FP_UNIT_SIZE);
	ret = mbn_init(mbn_curveFp254BNb, MBN_FP_UNIT_SIZE);
#else
	printf("test MBN_curveFp382_1 %d\n", MBN_FP_UNIT_SIZE);
	ret = mbn_init(mbn_curveFp382_1, MBN_FP_UNIT_SIZE);
#endif
	CYBOZU_TEST_EQUAL(ret, 0);
}

CYBOZU_TEST_AUTO(Fr)
{
	mbnFr x, y;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mbnFr_isValid(&x));
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(mbnFr_isValid(&x));
	CYBOZU_TEST_ASSERT(!mbnFr_isZero(&x));

	mbnFr_clear(&x);
	CYBOZU_TEST_ASSERT(mbnFr_isZero(&x));

	mbnFr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(mbnFr_isOne(&x));

	mbnFr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!mbnFr_isEqual(&x, &y));

	y = x;
	CYBOZU_TEST_ASSERT(mbnFr_isEqual(&x, &y));

	mbnFr_setHashOf(&x, "", 0);
	mbnFr_setHashOf(&y, "abc", 3);
	CYBOZU_TEST_ASSERT(!mbnFr_isEqual(&x, &y));
	mbnFr_setHashOf(&x, "abc", 3);
	CYBOZU_TEST_ASSERT(mbnFr_isEqual(&x, &y));

	char buf[1024];
	mbnFr_setInt(&x, 12345678);
	size_t size;
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 8);
	CYBOZU_TEST_EQUAL(buf, "12345678");

	mbnFr_setInt(&x, -7654321);
	mbnFr_neg(&x, &x);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 7);
	CYBOZU_TEST_EQUAL(buf, "7654321");

	mbnFr_setInt(&y, 123 - 7654321);
	mbnFr_add(&x, &x, &y);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 3);
	CYBOZU_TEST_EQUAL(buf, "123");

	mbnFr_setInt(&y, 100);
	mbnFr_sub(&x, &x, &y);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	mbnFr_mul(&x, &x, &y);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 4);
	CYBOZU_TEST_EQUAL(buf, "2300");

	mbnFr_div(&x, &x, &y);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	const char *s = "12345678901234567";
	CYBOZU_TEST_ASSERT(!mbnFr_setStr(&x, s, strlen(s), 10));
	s = "20000000000000000";
	CYBOZU_TEST_ASSERT(!mbnFr_setStr(&y, s, strlen(s), 10));
	mbnFr_add(&x, &x, &y);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 17);
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	mbnFr_setInt(&x, 1);
	mbnFr_neg(&x, &x);
	size = mbnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mbnFr_setStr(&y, buf, size, 10));
	CYBOZU_TEST_ASSERT(mbnFr_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	mbnG1 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mbnG1_isValid(&x));
	mbnG1_clear(&x);
	CYBOZU_TEST_ASSERT(mbnG1_isValid(&x));
	CYBOZU_TEST_ASSERT(mbnG1_isZero(&x));

	CYBOZU_TEST_ASSERT(!mbnG1_hashAndMapTo(&y, "abc", 3));

	char buf[1024];
	size_t size;
	size = mbnG1_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mbnG1_setStr(&y, buf, strlen(buf), 10));
	CYBOZU_TEST_ASSERT(mbnG1_isEqual(&x, &y));

	mbnG1_neg(&x, &x);
	mbnG1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(mbnG1_isZero(&x));

	mbnG1_dbl(&x, &y); // x = 2y
	mbnG1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(mbnG1_isEqual(&x, &z));
	mbnG1_add(&z, &z, &y); // z = 3y
	mbnFr n;
	mbnFr_setInt(&n, 3);
	mbnG1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(mbnG1_isEqual(&x, &z));
	mbnG1_sub(&x, &x, &y); // x = 2y

	mbnFr_setInt(&n, 2);
	mbnG1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(mbnG1_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	mbnG2 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mbnG2_isValid(&x));
	mbnG2_clear(&x);
	CYBOZU_TEST_ASSERT(mbnG2_isValid(&x));
	CYBOZU_TEST_ASSERT(mbnG2_isZero(&x));

	CYBOZU_TEST_ASSERT(!mbnG2_hashAndMapTo(&x, "abc", 3));

	char buf[1024];
	size_t size;
	size = mbnG2_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mbnG2_setStr(&y, buf, strlen(buf), 10));
	CYBOZU_TEST_ASSERT(mbnG2_isEqual(&x, &y));

	mbnG2_neg(&x, &x);
	mbnG2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(mbnG2_isZero(&x));

	mbnG2_dbl(&x, &y); // x = 2y
	mbnG2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(mbnG2_isEqual(&x, &z));
	mbnG2_add(&z, &z, &y); // z = 3y
	mbnFr n;
	mbnFr_setInt(&n, 3);
	mbnG2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(mbnG2_isEqual(&x, &z));
	mbnG2_sub(&x, &x, &y); // x = 2y

	mbnFr_setInt(&n, 2);
	mbnG2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(mbnG2_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	mbnGT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!mbnGT_isZero(&x));

	mbnGT_clear(&x);
	CYBOZU_TEST_ASSERT(mbnGT_isZero(&x));

	char buf[2048];
	const char *s = "1 2 3 4 5 6 7 8 9 10 11 12";
	size_t size;
	CYBOZU_TEST_ASSERT(!mbnGT_setStr(&x,s , strlen(s), 10));
	size = mbnGT_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, s);

	y = x;
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&x, &y));

	s = "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12";
	CYBOZU_TEST_ASSERT(!mbnGT_setStr(&z, s, strlen(s), 10));
	size = mbnGT_getStr(buf, sizeof(buf), &z, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mbnGT_setStr(&y, buf, size, 10));

	mbnGT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&x, &z));

	mbnGT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(mbnGT_isZero(&y));

	s = "2 0 0 0 0 0 0 0 0 0 0 0";
	CYBOZU_TEST_ASSERT(!mbnGT_setStr(&y, s, strlen(s), 10));
	mbnGT_mul(&z, &x, &y);
	size = mbnGT_getStr(buf, sizeof(buf), &z, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	mbnGT_div(&z, &z, &y);
	size = mbnGT_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&x, &z));

	mbnFr n;
	mbnFr_setInt(&n, 3);
	mbnGT_pow(&z, &x, &n);
	mbnGT_mul(&y, &x, &x);
	mbnGT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(pairing)
{
	mbnFr a, b, ab;
	mbnFr_setInt(&a, 123);
	mbnFr_setInt(&b, 456);
	mbnFr_mul(&ab, &a, &b);
	mbnG1 P, aP;
	mbnG2 Q, bQ;
	mbnGT e, e1, e2;

	CYBOZU_TEST_ASSERT(!mbnG1_hashAndMapTo(&P, "1", 1));
	CYBOZU_TEST_ASSERT(!mbnG2_hashAndMapTo(&Q, "1", 1));

	mbnG1_mul(&aP, &P, &a);
	mbnG2_mul(&bQ, &Q, &b);

	mbn_pairing(&e, &P, &Q);
	mbnGT_pow(&e1, &e, &a);
	mbn_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&e1, &e2));

	mbnGT_pow(&e1, &e, &b);
	mbn_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&e1, &e2));
}

CYBOZU_TEST_AUTO(precomputed)
{
	mbnG1 P1, P2;
	mbnG2 Q1, Q2;
	CYBOZU_TEST_ASSERT(!mbnG1_hashAndMapTo(&P1, "1", 1));
	CYBOZU_TEST_ASSERT(!mbnG1_hashAndMapTo(&P2, "123", 3));
	CYBOZU_TEST_ASSERT(!mbnG2_hashAndMapTo(&Q1, "1", 1));
	CYBOZU_TEST_ASSERT(!mbnG2_hashAndMapTo(&Q2, "2", 1));

	const int size = mbn_getUint64NumToPrecompute();
	std::vector<uint64_t> Q1buf, Q2buf;
	Q1buf.resize(size);
	Q2buf.resize(size);
	mbn_precomputeG2(Q1buf.data(), &Q1);
	mbn_precomputeG2(Q2buf.data(), &Q2);

	mbnGT e1, e2, f1, f2, f3;
	mbn_pairing(&e1, &P1, &Q1);
	mbn_precomputedMillerLoop(&f1, &P1, Q1buf.data());
	mbn_finalExp(&f1, &f1);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&e1, &f1));

	mbn_pairing(&e2, &P2, &Q2);
	mbn_precomputedMillerLoop(&f2, &P2, Q2buf.data());
	mbn_finalExp(&f2, &f2);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&e2, &f2));

	mbn_precomputedMillerLoop2(&f3, &P1, Q1buf.data(), &P2, Q2buf.data());
	mbn_finalExp(&f3, &f3);

	mbnGT_mul(&e1, &e1, &e2);
	CYBOZU_TEST_ASSERT(mbnGT_isEqual(&e1, &f3));
}

CYBOZU_TEST_AUTO(end)
{
	int ret = mbn_setErrFile("bn_if.log");
	CYBOZU_TEST_EQUAL(ret, 0);
}
