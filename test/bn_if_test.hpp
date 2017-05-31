/*
	include from bn_if256_test.cpp and bn_if384_test.cpp
*/
#include <mcl/bn_if.h>
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
	CYBOZU_TEST_EQUAL(sizeof(BN_Fr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(BN_G1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(BN_G2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(BN_GT), sizeof(Fp12));

	ret = BN_setErrFile("stderr");
	CYBOZU_TEST_EQUAL(ret, 0);

#if BN_MAX_OP_UNIT_SIZE == 4
	printf("test BN_curveFp254BNb %d\n", BN_MAX_OP_UNIT_SIZE);
	ret = BN_initLib(BN_curveFp254BNb, BN_MAX_OP_UNIT_SIZE);
#else
	printf("test BN_curveFp382_1 %d\n", BN_MAX_OP_UNIT_SIZE);
	ret = BN_initLib(BN_curveFp382_1, BN_MAX_OP_UNIT_SIZE);
#endif
	CYBOZU_TEST_EQUAL(ret, 0);
}

CYBOZU_TEST_AUTO(Fr)
{
	BN_Fr x, y;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN_Fr_isValid(&x));
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(BN_Fr_isValid(&x));
	CYBOZU_TEST_ASSERT(!BN_Fr_isZero(&x));

	BN_Fr_clear(&x);
	CYBOZU_TEST_ASSERT(BN_Fr_isZero(&x));

	BN_Fr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(BN_Fr_isOne(&x));

	BN_Fr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!BN_Fr_isEqual(&x, &y));

	y = x;
	CYBOZU_TEST_ASSERT(BN_Fr_isEqual(&x, &y));

	BN_hashToFr(&x, "", 0);
	BN_hashToFr(&y, "abc", 3);
	CYBOZU_TEST_ASSERT(!BN_Fr_isEqual(&x, &y));
	BN_hashToFr(&x, "abc", 3);
	CYBOZU_TEST_ASSERT(BN_Fr_isEqual(&x, &y));

	char buf[1024];
	BN_Fr_setInt(&x, 12345678);
	size_t size;
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 8);
	CYBOZU_TEST_EQUAL(buf, "12345678");

	BN_Fr_setInt(&x, -7654321);
	BN_Fr_neg(&x, &x);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 7);
	CYBOZU_TEST_EQUAL(buf, "7654321");

	BN_Fr_setInt(&y, 123 - 7654321);
	BN_Fr_add(&x, &x, &y);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 3);
	CYBOZU_TEST_EQUAL(buf, "123");

	BN_Fr_setInt(&y, 100);
	BN_Fr_sub(&x, &x, &y);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	BN_Fr_mul(&x, &x, &y);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 4);
	CYBOZU_TEST_EQUAL(buf, "2300");

	BN_Fr_div(&x, &x, &y);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 2);
	CYBOZU_TEST_EQUAL(buf, "23");

	CYBOZU_TEST_ASSERT(!BN_Fr_setDecStr(&x, "12345678901234567"));
	CYBOZU_TEST_ASSERT(!BN_Fr_setDecStr(&y, "20000000000000000"));
	BN_Fr_add(&x, &x, &y);
	size = BN_Fr_getDecStr(buf, sizeof(buf), &x);
	CYBOZU_TEST_EQUAL(size, 17);
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	BN_Fr_setInt(&x, 1);
	BN_Fr_neg(&x, &x);
	CYBOZU_TEST_ASSERT(BN_Fr_getDecStr(buf, sizeof(buf), &x) > 0);
	CYBOZU_TEST_ASSERT(!BN_Fr_setDecStr(&y, buf));
	CYBOZU_TEST_ASSERT(BN_Fr_isEqual(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	BN_G1 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN_G1_isValid(&x));
	BN_G1_clear(&x);
	CYBOZU_TEST_ASSERT(BN_G1_isValid(&x));
	CYBOZU_TEST_ASSERT(BN_G1_isZero(&x));

	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG1(&y, "abc", 3));

	char buf[1024];
	CYBOZU_TEST_ASSERT(BN_G1_getHexStr(buf, sizeof(buf), &x) > 0);
	CYBOZU_TEST_ASSERT(!BN_G1_setHexStr(&y, buf));
	CYBOZU_TEST_ASSERT(BN_G1_isEqual(&x, &y));

	BN_G1_neg(&x, &x);
	BN_G1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(BN_G1_isZero(&x));

	BN_G1_dbl(&x, &y); // x = 2y
	BN_G1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(BN_G1_isEqual(&x, &z));
	BN_G1_add(&z, &z, &y); // z = 3y
	BN_Fr n;
	BN_Fr_setInt(&n, 3);
	BN_G1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(BN_G1_isEqual(&x, &z));
	BN_G1_sub(&x, &x, &y); // x = 2y

	BN_Fr_setInt(&n, 2);
	BN_G1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(BN_G1_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	BN_G2 x, y, z;
	memset(&x, 0xff, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN_G2_isValid(&x));
	BN_G2_clear(&x);
	CYBOZU_TEST_ASSERT(BN_G2_isValid(&x));
	CYBOZU_TEST_ASSERT(BN_G2_isZero(&x));

	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG2(&x, "abc", 3));

	char buf[1024];
	CYBOZU_TEST_ASSERT(BN_G2_getHexStr(buf, sizeof(buf), &x) > 0);
	CYBOZU_TEST_ASSERT(!BN_G2_setHexStr(&y, buf));
	CYBOZU_TEST_ASSERT(BN_G2_isEqual(&x, &y));

	BN_G2_neg(&x, &x);
	BN_G2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(BN_G2_isZero(&x));

	BN_G2_dbl(&x, &y); // x = 2y
	BN_G2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(BN_G2_isEqual(&x, &z));
	BN_G2_add(&z, &z, &y); // z = 3y
	BN_Fr n;
	BN_Fr_setInt(&n, 3);
	BN_G2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(BN_G2_isEqual(&x, &z));
	BN_G2_sub(&x, &x, &y); // x = 2y

	BN_Fr_setInt(&n, 2);
	BN_G2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(BN_G2_isEqual(&x, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	BN_GT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN_GT_isZero(&x));

	BN_GT_clear(&x);
	CYBOZU_TEST_ASSERT(BN_GT_isZero(&x));

	char buf[2048];
	CYBOZU_TEST_ASSERT(!BN_GT_setDecStr(&x, "1 2 3 4 5 6 7 8 9 10 11 12"));
	CYBOZU_TEST_ASSERT(BN_GT_getDecStr(buf, sizeof(buf), &x) > 0);
	CYBOZU_TEST_EQUAL(buf, "1 2 3 4 5 6 7 8 9 10 11 12");

	y = x;
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&x, &y));

	CYBOZU_TEST_ASSERT(!BN_GT_setDecStr(&z, "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12"));
	CYBOZU_TEST_ASSERT(BN_GT_getDecStr(buf, sizeof(buf), &z) > 0);
	CYBOZU_TEST_ASSERT(!BN_GT_setDecStr(&y, buf));

	BN_GT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&x, &z));

	BN_GT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(BN_GT_isZero(&y));

	CYBOZU_TEST_ASSERT(!BN_GT_setDecStr(&y, "2 0 0 0 0 0 0 0 0 0 0 0"));
	BN_GT_mul(&z, &x, &y);
	CYBOZU_TEST_ASSERT(BN_GT_getDecStr(buf, sizeof(buf), &z) > 0);
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	BN_GT_div(&z, &z, &y);
	CYBOZU_TEST_ASSERT(BN_GT_getDecStr(buf, sizeof(buf), &x) > 0);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&x, &z));

	BN_Fr n;
	BN_Fr_setInt(&n, 3);
	BN_GT_pow(&z, &x, &n);
	BN_GT_mul(&y, &x, &x);
	BN_GT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&y, &z));
}

CYBOZU_TEST_AUTO(pairing)
{
	BN_Fr a, b, ab;
	BN_Fr_setInt(&a, 123);
	BN_Fr_setInt(&b, 456);
	BN_Fr_mul(&ab, &a, &b);
	BN_G1 P, aP;
	BN_G2 Q, bQ;
	BN_GT e, e1, e2;

	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG1(&P, "1", 1));
	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG2(&Q, "1", 1));

	BN_G1_mul(&aP, &P, &a);
	BN_G2_mul(&bQ, &Q, &b);

	BN_pairing(&e, &P, &Q);
	BN_GT_pow(&e1, &e, &a);
	BN_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&e1, &e2));

	BN_GT_pow(&e1, &e, &b);
	BN_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&e1, &e2));
}

CYBOZU_TEST_AUTO(precomputed)
{
	BN_G1 P1, P2;
	BN_G2 Q1, Q2;
	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG1(&P1, "1", 1));
	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG1(&P2, "123", 3));
	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG2(&Q1, "1", 1));
	CYBOZU_TEST_ASSERT(!BN_hashAndMapToG2(&Q2, "2", 1));

	const int size = BN_getUint64NumToPrecompute();
	std::vector<uint64_t> Q1buf, Q2buf;
	Q1buf.resize(size);
	Q2buf.resize(size);
	BN_precomputeG2(Q1buf.data(), &Q1);
	BN_precomputeG2(Q2buf.data(), &Q2);

	BN_GT e1, e2, f1, f2, f3;
	BN_pairing(&e1, &P1, &Q1);
	BN_precomputedMillerLoop(&f1, &P1, Q1buf.data());
	BN_finalExp(&f1, &f1);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&e1, &f1));

	BN_pairing(&e2, &P2, &Q2);
	BN_precomputedMillerLoop(&f2, &P2, Q2buf.data());
	BN_finalExp(&f2, &f2);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&e2, &f2));

	BN_precomputedMillerLoop2(&f3, &P1, Q1buf.data(), &P2, Q2buf.data());
	BN_finalExp(&f3, &f3);

	BN_GT_mul(&e1, &e1, &e2);
	CYBOZU_TEST_ASSERT(BN_GT_isEqual(&e1, &f3));
}

CYBOZU_TEST_AUTO(end)
{
	int ret = BN_setErrFile("bn_if.log");
	CYBOZU_TEST_EQUAL(ret, 0);
}
