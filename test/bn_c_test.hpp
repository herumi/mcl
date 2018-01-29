/*
	include from bn_if256_test.cpp and bn_if384_test.cpp
*/
#include <mcl/bn.h>
#include <cybozu/test.hpp>
#include <iostream>

template<size_t N>
std::ostream& dump(std::ostream& os, const uint64_t (&x)[N])
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
	CYBOZU_TEST_EQUAL(sizeof(mclBnFr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(mclBnG1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(mclBnG2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(mclBnGT), sizeof(Fp12));

//	ret = mclBn_setErrFile("stderr");
//	CYBOZU_TEST_EQUAL(ret, 0);

#if MCLBN_FP_UNIT_SIZE == 4
	printf("test MCLBN_curveFp254BNb %d\n", MCLBN_FP_UNIT_SIZE);
	ret = mclBn_init(mclBn_CurveFp254BNb, MCLBN_FP_UNIT_SIZE);
#elif MCLBN_FP_UNIT_SIZE == 6
	printf("test MCLBN_curveFp382_1 %d\n", MCLBN_FP_UNIT_SIZE);
	ret = mclBn_init(mclBn_CurveFp382_1, MCLBN_FP_UNIT_SIZE);
#elif MCLBN_FP_UNIT_SIZE == 8
	printf("test MCLBN_curveFp462 %d\n", MCLBN_FP_UNIT_SIZE);
	ret = mclBn_init(mclBn_CurveFp462, MCLBN_FP_UNIT_SIZE);
#else
	#error "bad MCLBN_FP_UNIT_SIZE"
#endif
	CYBOZU_TEST_EQUAL(ret, 0);
	if (ret != 0) exit(1);
}

CYBOZU_TEST_AUTO(Fr)
{
	mclBnFr x, y;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mclBnFr_isValid(&x));
	CYBOZU_TEST_ASSERT(!mclBnFr_isZero(&x));

	mclBnFr_clear(&x);
	CYBOZU_TEST_ASSERT(mclBnFr_isZero(&x));

	mclBnFr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(mclBnFr_isOne(&x));

	mclBnFr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!mclBnFr_isEqual(&x, &y));

	y = x;
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x, &y));

	mclBnFr_setHashOf(&x, "", 0);
	mclBnFr_setHashOf(&y, "abc", 3);
	CYBOZU_TEST_ASSERT(!mclBnFr_isEqual(&x, &y));
	mclBnFr_setHashOf(&x, "abc", 3);
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x, &y));

	char buf[1024];
	mclBnFr_setInt(&x, 12345678);
	size_t size;
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 8);
	CYBOZU_TEST_EQUAL(buf, "12345678");

	mclBnFr_setInt(&x, -7654321);
	mclBnFr_neg(&x, &x);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 7);
	CYBOZU_TEST_EQUAL(buf, "7654321");

	mclBnFr_setInt(&y, 123 - 7654321);
	mclBnFr_add(&x, &x, &y);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 3);
	CYBOZU_TEST_EQUAL(buf, "123");

	mclBnFr_setInt(&y, 100);
	mclBnFr_sub(&x, &x, &y);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	mclBnFr_mul(&x, &x, &y);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 4);
	CYBOZU_TEST_EQUAL(buf, "2300");

	mclBnFr_div(&x, &x, &y);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	mclBnFr_mul(&x, &y, &y);
	mclBnFr_sqr(&y, &y);
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x, &y));

	const char *s = "12345678901234567";
	CYBOZU_TEST_ASSERT(!mclBnFr_setStr(&x, s, strlen(s), 10));
	s = "20000000000000000";
	CYBOZU_TEST_ASSERT(!mclBnFr_setStr(&y, s, strlen(s), 10));
	mclBnFr_add(&x, &x, &y);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_EQUAL(size, 17);
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	mclBnFr_setInt(&x, 1);
	mclBnFr_neg(&x, &x);
	size = mclBnFr_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mclBnFr_setStr(&y, buf, size, 10));
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	mclBnG1 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mclBnG1_isValid(&x));
	mclBnG1_clear(&x);
	CYBOZU_TEST_ASSERT(mclBnG1_isValid(&x));
	CYBOZU_TEST_ASSERT(mclBnG1_isZero(&x));

	CYBOZU_TEST_ASSERT(!mclBnG1_hashAndMapTo(&y, "abc", 3));

	char buf[1024];
	size_t size;
	size = mclBnG1_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mclBnG1_setStr(&y, buf, strlen(buf), 10));
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&x, &y));

	mclBnG1_neg(&x, &x);
	mclBnG1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(mclBnG1_isZero(&x));

	mclBnG1_dbl(&x, &y); // x = 2y
	mclBnG1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&x, &z));
	mclBnG1_add(&z, &z, &y); // z = 3y
	mclBnFr n;
	mclBnFr_setInt(&n, 3);
	mclBnG1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&x, &z));
	mclBnG1_sub(&x, &x, &y); // x = 2y

	mclBnFr_setInt(&n, 2);
	mclBnG1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&x, &z));
	mclBnG1_normalize(&y, &z);
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	mclBnG2 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!mclBnG2_isValid(&x));
	mclBnG2_clear(&x);
	CYBOZU_TEST_ASSERT(mclBnG2_isValid(&x));
	CYBOZU_TEST_ASSERT(mclBnG2_isZero(&x));

	CYBOZU_TEST_ASSERT(!mclBnG2_hashAndMapTo(&x, "abc", 3));

	char buf[1024];
	size_t size;
	size = mclBnG2_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mclBnG2_setStr(&y, buf, strlen(buf), 10));
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&x, &y));

	mclBnG2_neg(&x, &x);
	mclBnG2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(mclBnG2_isZero(&x));

	mclBnG2_dbl(&x, &y); // x = 2y
	mclBnG2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&x, &z));
	mclBnG2_add(&z, &z, &y); // z = 3y
	mclBnFr n;
	mclBnFr_setInt(&n, 3);
	mclBnG2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&x, &z));
	mclBnG2_sub(&x, &x, &y); // x = 2y

	mclBnFr_setInt(&n, 2);
	mclBnG2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&x, &z));
	mclBnG2_normalize(&y, &z);
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	mclBnGT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!mclBnGT_isZero(&x));

	mclBnGT_clear(&x);
	CYBOZU_TEST_ASSERT(mclBnGT_isZero(&x));

	mclBnGT_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(mclBnGT_isOne(&x));
	char buf[2048];
	size_t size;
	size = mclBnGT_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	const char *s = "1 0 0 0 0 0 0 0 0 0 0 0";
	CYBOZU_TEST_EQUAL(buf, s);

	s = "1 2 3 4 5 6 7 8 9 10 11 12";
	CYBOZU_TEST_ASSERT(!mclBnGT_setStr(&x,s , strlen(s), 10));
	size = mclBnGT_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, s);

	y = x;
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&x, &y));

	s = "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12";
	CYBOZU_TEST_ASSERT(!mclBnGT_setStr(&z, s, strlen(s), 10));
	size = mclBnGT_getStr(buf, sizeof(buf), &z, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!mclBnGT_setStr(&y, buf, size, 10));

	mclBnGT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&x, &z));

	mclBnGT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(mclBnGT_isZero(&y));

	s = "2 0 0 0 0 0 0 0 0 0 0 0";
	CYBOZU_TEST_ASSERT(!mclBnGT_setStr(&y, s, strlen(s), 10));
	mclBnGT_mul(&z, &x, &y);
	size = mclBnGT_getStr(buf, sizeof(buf), &z, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	mclBnGT_div(&z, &z, &y);
	size = mclBnGT_getStr(buf, sizeof(buf), &x, 10);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&x, &z));

	/*
		can't use mclBnGT_pow because x is not in GT
	*/
	mclBnFr n;
	mclBnFr_setInt(&n, 3);
	mclBnGT_powGeneric(&z, &x, &n);
	mclBnGT_mul(&y, &x, &x);
	mclBnGT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&y, &z));

	mclBnGT_mul(&x, &y, &y);
	mclBnGT_sqr(&y, &y);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(pairing)
{
	mclBnFr a, b, ab;
	mclBnFr_setInt(&a, 123);
	mclBnFr_setInt(&b, 456);
	mclBnFr_mul(&ab, &a, &b);
	mclBnG1 P, aP;
	mclBnG2 Q, bQ;
	mclBnGT e, e1, e2;

	CYBOZU_TEST_ASSERT(!mclBnG1_hashAndMapTo(&P, "1", 1));
	CYBOZU_TEST_ASSERT(!mclBnG2_hashAndMapTo(&Q, "1", 1));

	mclBnG1_mul(&aP, &P, &a);
	mclBnG2_mul(&bQ, &Q, &b);

	mclBn_pairing(&e, &P, &Q);
	mclBnGT_pow(&e1, &e, &a);
	mclBn_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e1, &e2));

	mclBnGT_pow(&e1, &e, &b);
	mclBn_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e1, &e2));

	mclBnFr n;
	mclBnFr_setInt(&n, 3);
	mclBnGT_pow(&e1, &e, &n);
	mclBnGT_mul(&e2, &e, &e);
	mclBnGT_mul(&e2, &e2, &e);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e1, &e2));
}

CYBOZU_TEST_AUTO(precomputed)
{
	mclBnG1 P1, P2;
	mclBnG2 Q1, Q2;
	CYBOZU_TEST_ASSERT(!mclBnG1_hashAndMapTo(&P1, "1", 1));
	CYBOZU_TEST_ASSERT(!mclBnG1_hashAndMapTo(&P2, "123", 3));
	CYBOZU_TEST_ASSERT(!mclBnG2_hashAndMapTo(&Q1, "1", 1));
	CYBOZU_TEST_ASSERT(!mclBnG2_hashAndMapTo(&Q2, "2", 1));

	const int size = mclBn_getUint64NumToPrecompute();
	std::vector<uint64_t> Q1buf, Q2buf;
	Q1buf.resize(size);
	Q2buf.resize(size);
	mclBn_precomputeG2(Q1buf.data(), &Q1);
	mclBn_precomputeG2(Q2buf.data(), &Q2);

	mclBnGT e1, e2, f1, f2, f3;
	mclBn_pairing(&e1, &P1, &Q1);
	mclBn_precomputedMillerLoop(&f1, &P1, Q1buf.data());
	mclBn_finalExp(&f1, &f1);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e1, &f1));

	mclBn_pairing(&e2, &P2, &Q2);
	mclBn_precomputedMillerLoop(&f2, &P2, Q2buf.data());
	mclBn_finalExp(&f2, &f2);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e2, &f2));

	mclBn_precomputedMillerLoop2(&f3, &P1, Q1buf.data(), &P2, Q2buf.data());
	mclBn_finalExp(&f3, &f3);

	mclBnGT_mul(&e1, &e1, &e2);
	CYBOZU_TEST_ASSERT(mclBnGT_isEqual(&e1, &f3));
}

CYBOZU_TEST_AUTO(serialize)
{
	const size_t G1Size = mclBn_getG1ByteSize();
	mclBnFr x1, x2;
	mclBnG1 P1, P2;
	mclBnG2 Q1, Q2;
	char buf[1024];
	size_t n;
	size_t expectSize;
	int ret;
	// Fr
	expectSize = G1Size;
	mclBnFr_setInt(&x1, -1);
	n = mclBnFr_serialize(buf, sizeof(buf), &x1);
	CYBOZU_TEST_EQUAL(n, expectSize);

	ret = mclBnFr_deserialize(&x2, buf, n);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x1, &x2));

	ret = mclBnFr_deserialize(&x2, buf, n - 1);
	CYBOZU_TEST_EQUAL(ret, 0);

	memset(&x2, 0, sizeof(x2));
	ret = mclBnFr_deserialize(&x2, buf, n + 1);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnFr_isEqual(&x1, &x2));

	n = mclBnFr_serialize(buf, expectSize, &x1);
	CYBOZU_TEST_EQUAL(n, expectSize);

	// G1
	expectSize = G1Size;
	mclBnG1_hashAndMapTo(&P1, "1", 1);
	n = mclBnG1_serialize(buf, sizeof(buf), &P1);
	CYBOZU_TEST_EQUAL(n, expectSize);

	ret = mclBnG1_deserialize(&P2, buf, n);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&P1, &P2));

	ret = mclBnG1_deserialize(&P2, buf, n - 1);
	CYBOZU_TEST_EQUAL(ret, 0);

	memset(&P2, 0, sizeof(P2));
	ret = mclBnG1_deserialize(&P2, buf, n + 1);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnG1_isEqual(&P1, &P2));

	n = mclBnG1_serialize(buf, expectSize, &P1);
	CYBOZU_TEST_EQUAL(n, expectSize);

	// G2
	expectSize = G1Size * 2;
	mclBnG2_hashAndMapTo(&Q1, "1", 1);
	n = mclBnG2_serialize(buf, sizeof(buf), &Q1);
	CYBOZU_TEST_EQUAL(n, expectSize);

	ret = mclBnG2_deserialize(&Q2, buf, n);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&Q1, &Q2));

	ret = mclBnG2_deserialize(&Q2, buf, n - 1);
	CYBOZU_TEST_EQUAL(ret, 0);

	memset(&Q2, 0, sizeof(Q2));
	ret = mclBnG2_deserialize(&Q2, buf, n + 1);
	CYBOZU_TEST_EQUAL(ret, n);
	CYBOZU_TEST_ASSERT(mclBnG2_isEqual(&Q1, &Q2));

	n = mclBnG2_serialize(buf, expectSize, &Q1);
	CYBOZU_TEST_EQUAL(n, expectSize);
}

#if MCLBN_FP_UNIT_SIZE == 6
CYBOZU_TEST_AUTO(badG2)
{
	int ret;
	ret = mclBn_init(mclBn_CurveFp382_1, MCLBN_FP_UNIT_SIZE);
	CYBOZU_TEST_EQUAL(ret, 0);
	const char *s = "1 18d3d8c085a5a5e7553c3a4eb628e88b8465bf4de2612e35a0a4eb018fb0c82e9698896031e62fd7633ffd824a859474 1dc6edfcf33e29575d4791faed8e7203832217423bf7f7fbf1f6b36625b12e7132c15fbc15562ce93362a322fb83dd0d 65836963b1f7b6959030ddfa15ab38ce056097e91dedffd996c1808624fa7e2644a77be606290aa555cda8481cfb3cb 1b77b708d3d4f65aeedf54b58393463a42f0dc5856baadb5ce608036baeca398c5d9e6b169473a8838098fd72fd28b50";
	mclBnG2 Q;
	ret = mclBnG2_setStr(&Q, s, strlen(s), 16);
	CYBOZU_TEST_ASSERT(ret != 0);
}
#endif

CYBOZU_TEST_AUTO(end)
{
	int ret = mclBn_setErrFile("bn_if.log");
	CYBOZU_TEST_EQUAL(ret, 0);
}
