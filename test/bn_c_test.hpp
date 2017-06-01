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
	CYBOZU_TEST_EQUAL(sizeof(MBN_Fr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(MBN_G1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(MBN_G2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(MBN_GT), sizeof(Fp12));

	ret = MBN_setErrFile("stderr");
	CYBOZU_TEST_EQUAL(ret, 0);

#if MBN_FP_UNIT_SIZE == 4
	printf("test MBN_curveFp254BNb %d\n", MBN_FP_UNIT_SIZE);
	ret = MBN_init(MBN_curveFp254BNb, MBN_FP_UNIT_SIZE);
#else
	printf("test MBN_curveFp382_1 %d\n", MBN_FP_UNIT_SIZE);
	ret = MBN_init(MBN_curveFp382_1, MBN_FP_UNIT_SIZE);
#endif
	CYBOZU_TEST_EQUAL(ret, 0);
}

CYBOZU_TEST_AUTO(Fr)
{
	MBN_Fr x, y;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MBN_Fr_isValid(&x));
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(MBN_Fr_isValid(&x));
	CYBOZU_TEST_ASSERT(!MBN_Fr_isZero(&x));

	MBN_Fr_clear(&x);
	CYBOZU_TEST_ASSERT(MBN_Fr_isZero(&x));

	MBN_Fr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(MBN_Fr_isOne(&x));

	MBN_Fr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!MBN_Fr_isEqual(&x, &y));

	y = x;
	CYBOZU_TEST_ASSERT(MBN_Fr_isEqual(&x, &y));

	MBN_hashToFr(&x, "", 0);
	MBN_hashToFr(&y, "abc", 3);
	CYBOZU_TEST_ASSERT(!MBN_Fr_isEqual(&x, &y));
	MBN_hashToFr(&x, "abc", 3);
	CYBOZU_TEST_ASSERT(MBN_Fr_isEqual(&x, &y));

	char buf[1024];
	MBN_Fr_setInt(&x, 12345678);
	size_t size;
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 8);
	CYBOZU_TEST_EQUAL(buf, "12345678");

	MBN_Fr_setInt(&x, -7654321);
	MBN_Fr_neg(&x, &x);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 7);
	CYBOZU_TEST_EQUAL(buf, "7654321");

	MBN_Fr_setInt(&y, 123 - 7654321);
	MBN_Fr_add(&x, &x, &y);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 3);
	CYBOZU_TEST_EQUAL(buf, "123");

	MBN_Fr_setInt(&y, 100);
	MBN_Fr_sub(&x, &x, &y);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	MBN_Fr_mul(&x, &x, &y);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 4);
	CYBOZU_TEST_EQUAL(buf, "2300");

	MBN_Fr_div(&x, &x, &y);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	CYBOZU_TEST_ASSERT(!MBN_Fr_setDecStr(&x, "12345678901234567", 17));
	CYBOZU_TEST_ASSERT(!MBN_Fr_setDecStr(&y, "20000000000000000", 17));
	MBN_Fr_add(&x, &x, &y);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 17);
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	MBN_Fr_setInt(&x, 1);
	MBN_Fr_neg(&x, &x);
	size = MBN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MBN_Fr_setDecStr(&y, buf, size));
	CYBOZU_TEST_ASSERT(MBN_Fr_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	MBN_G1 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MBN_G1_isValid(&x));
	MBN_G1_clear(&x);
	CYBOZU_TEST_ASSERT(MBN_G1_isValid(&x));
	CYBOZU_TEST_ASSERT(MBN_G1_isZero(&x));

	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG1(&y, "abc", 3));

	char buf[1024];
	size_t size;
	size = MBN_G1_getHexStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MBN_G1_setHexStr(&y, buf, strlen(buf)));
	CYBOZU_TEST_ASSERT(MBN_G1_isEqual(&x, &y));

	MBN_G1_neg(&x, &x);
	MBN_G1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(MBN_G1_isZero(&x));

	MBN_G1_dbl(&x, &y); // x = 2y
	MBN_G1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(MBN_G1_isEqual(&x, &z));
	MBN_G1_add(&z, &z, &y); // z = 3y
	MBN_Fr n;
	MBN_Fr_setInt(&n, 3);
	MBN_G1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(MBN_G1_isEqual(&x, &z));
	MBN_G1_sub(&x, &x, &y); // x = 2y

	MBN_Fr_setInt(&n, 2);
	MBN_G1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(MBN_G1_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	MBN_G2 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!MBN_G2_isValid(&x));
	MBN_G2_clear(&x);
	CYBOZU_TEST_ASSERT(MBN_G2_isValid(&x));
	CYBOZU_TEST_ASSERT(MBN_G2_isZero(&x));

	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG2(&x, "abc", 3));

	char buf[1024];
	size_t size;
	size = MBN_G2_getHexStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MBN_G2_setHexStr(&y, buf, strlen(buf)));
	CYBOZU_TEST_ASSERT(MBN_G2_isEqual(&x, &y));

	MBN_G2_neg(&x, &x);
	MBN_G2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(MBN_G2_isZero(&x));

	MBN_G2_dbl(&x, &y); // x = 2y
	MBN_G2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(MBN_G2_isEqual(&x, &z));
	MBN_G2_add(&z, &z, &y); // z = 3y
	MBN_Fr n;
	MBN_Fr_setInt(&n, 3);
	MBN_G2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(MBN_G2_isEqual(&x, &z));
	MBN_G2_sub(&x, &x, &y); // x = 2y

	MBN_Fr_setInt(&n, 2);
	MBN_G2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(MBN_G2_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	MBN_GT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!MBN_GT_isZero(&x));

	MBN_GT_clear(&x);
	CYBOZU_TEST_ASSERT(MBN_GT_isZero(&x));

	char buf[2048];
	const char *s = "1 2 3 4 5 6 7 8 9 10 11 12";
	size_t size;
	CYBOZU_TEST_ASSERT(!MBN_GT_setDecStr(&x,s , strlen(s)));
	size = MBN_GT_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, s);

	y = x;
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&x, &y));

	s = "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12";
	CYBOZU_TEST_ASSERT(!MBN_GT_setDecStr(&z, s, strlen(s)));
	size = MBN_GT_getDecStr(buf, sizeof(buf), &z);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(!MBN_GT_setDecStr(&y, buf, size));

	MBN_GT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&x, &z));

	MBN_GT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(MBN_GT_isZero(&y));

	s = "2 0 0 0 0 0 0 0 0 0 0 0";
	CYBOZU_TEST_ASSERT(!MBN_GT_setDecStr(&y, s, strlen(s)));
	MBN_GT_mul(&z, &x, &y);
	size = MBN_GT_getDecStr(buf, sizeof(buf), &z);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	MBN_GT_div(&z, &z, &y);
	size = MBN_GT_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(size > 0);
	CYBOZU_TEST_EQUAL(size, strlen(buf));
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&x, &z));

	MBN_Fr n;
	MBN_Fr_setInt(&n, 3);
	MBN_GT_pow(&z, &x, &n);
	MBN_GT_mul(&y, &x, &x);
	MBN_GT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(pairing)
{
	MBN_Fr a, b, ab;
	MBN_Fr_setInt(&a, 123);
	MBN_Fr_setInt(&b, 456);
	MBN_Fr_mul(&ab, &a, &b);
	MBN_G1 P, aP;
	MBN_G2 Q, bQ;
	MBN_GT e, e1, e2;

	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG1(&P, "1", 1));
	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG2(&Q, "1", 1));

	MBN_G1_mul(&aP, &P, &a);
	MBN_G2_mul(&bQ, &Q, &b);

	MBN_pairing(&e, &P, &Q);
	MBN_GT_pow(&e1, &e, &a);
	MBN_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&e1, &e2));

	MBN_GT_pow(&e1, &e, &b);
	MBN_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&e1, &e2));
}

CYBOZU_TEST_AUTO(precomputed)
{
	MBN_G1 P1, P2;
	MBN_G2 Q1, Q2;
	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG1(&P1, "1", 1));
	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG1(&P2, "123", 3));
	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG2(&Q1, "1", 1));
	CYBOZU_TEST_ASSERT(!MBN_hashAndMapToG2(&Q2, "2", 1));

	const int size = MBN_getUint64NumToPrecompute();
	std::vector<uint64_t> Q1buf, Q2buf;
	Q1buf.resize(size);
	Q2buf.resize(size);
	MBN_precomputeG2(Q1buf.data(), &Q1);
	MBN_precomputeG2(Q2buf.data(), &Q2);

	MBN_GT e1, e2, f1, f2, f3;
	MBN_pairing(&e1, &P1, &Q1);
	MBN_precomputedMillerLoop(&f1, &P1, Q1buf.data());
	MBN_finalExp(&f1, &f1);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&e1, &f1));

	MBN_pairing(&e2, &P2, &Q2);
	MBN_precomputedMillerLoop(&f2, &P2, Q2buf.data());
	MBN_finalExp(&f2, &f2);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&e2, &f2));

	MBN_precomputedMillerLoop2(&f3, &P1, Q1buf.data(), &P2, Q2buf.data());
	MBN_finalExp(&f3, &f3);

	MBN_GT_mul(&e1, &e1, &e2);
	CYBOZU_TEST_ASSERT(MBN_GT_isEqual(&e1, &f3));
}

CYBOZU_TEST_AUTO(end)
{
	int ret = MBN_setErrFile("bn_if.log");
	CYBOZU_TEST_EQUAL(ret, 0);
}
