#include <cybozu/test.hpp>
#include <mcl/bn256.hpp>

#define BN256_DEFINE_STRUCT
#include <mcl/bn256_if.h>

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

using namespace mcl::bn256;

CYBOZU_TEST_AUTO(init)
{
	int ret;
	CYBOZU_TEST_EQUAL(sizeof(BN256_Fr), sizeof(Fr));
	CYBOZU_TEST_EQUAL(sizeof(BN256_G1), sizeof(G1));
	CYBOZU_TEST_EQUAL(sizeof(BN256_G2), sizeof(G2));
	CYBOZU_TEST_EQUAL(sizeof(BN256_GT), sizeof(Fp12));

	ret = BN256_setErrFile("stderr");
	CYBOZU_TEST_EQUAL(ret, 0);

	ret = BN256_init();
	CYBOZU_TEST_EQUAL(ret, 0);
}

CYBOZU_TEST_AUTO(Fr)
{
	BN256_Fr x, y;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN256_Fr_isZero(&x));

	BN256_Fr_clear(&x);
	CYBOZU_TEST_ASSERT(BN256_Fr_isZero(&x));

	BN256_Fr_setInt(&x, 1);
	CYBOZU_TEST_ASSERT(BN256_Fr_isOne(&x));

	BN256_Fr_setInt(&y, -1);
	CYBOZU_TEST_ASSERT(!BN256_Fr_isSame(&x, &y));

	BN256_Fr_copy(&y, &x);
	CYBOZU_TEST_ASSERT(BN256_Fr_isSame(&x, &y));

	BN256_Fr_setMsg(&x, "");
	BN256_Fr_setMsg(&y, "abc");
	CYBOZU_TEST_ASSERT(!BN256_Fr_isSame(&x, &y));
	BN256_Fr_setMsg(&x, "abc");
	CYBOZU_TEST_ASSERT(BN256_Fr_isSame(&x, &y));

	char buf[1024];
	BN256_Fr_setInt(&x, 12345678);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "12345678");

	BN256_Fr_setInt(&x, -7654321);
	BN256_Fr_neg(&x, &x);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "7654321");

	BN256_Fr_setInt(&y, 123 - 7654321);
	BN256_Fr_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "123");

	BN256_Fr_setInt(&y, 100);
	BN256_Fr_sub(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "23");

	BN256_Fr_mul(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "2300");

	BN256_Fr_div(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "23");

	CYBOZU_TEST_ASSERT(!BN256_Fr_setStr(&x, "12345678901234567"));
	CYBOZU_TEST_ASSERT(!BN256_Fr_setStr(&y, "20000000000000000"));
	BN256_Fr_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");

	BN256_Fr_setInt(&x, 1);
	BN256_Fr_neg(&x, &x);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_ASSERT(!BN256_Fr_setStr(&y, buf));
	CYBOZU_TEST_ASSERT(BN256_Fr_isSame(&x, &y));
}

CYBOZU_TEST_AUTO(G1)
{
	BN256_G1 x, y, z;
	BN256_G1_clear(&x);
	BN256_G1_setStr(&y, "0");
	CYBOZU_TEST_ASSERT(BN256_G1_isZero(&x));
	CYBOZU_TEST_ASSERT(BN256_G1_isZero(&y));
	CYBOZU_TEST_ASSERT(!BN256_G1_setStr(&y, "1 -1 1")); // "1 <x> <y>"
	CYBOZU_TEST_ASSERT(!BN256_G1_isZero(&y));
	char buf[1024];
	CYBOZU_TEST_ASSERT(!BN256_G1_getStr(buf, sizeof(buf), &y));
	CYBOZU_TEST_ASSERT(!BN256_G1_setStr(&x, buf));
	CYBOZU_TEST_ASSERT(BN256_G1_isSame(&x, &y));

	CYBOZU_TEST_ASSERT(!BN256_G1_setStr(&x, "1 -1 -1")); // "1 <x> <y>"
	CYBOZU_TEST_ASSERT(!BN256_G1_isZero(&x));
	BN256_G1_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(BN256_G1_isZero(&x));

	CYBOZU_TEST_ASSERT(!BN256_G1_setStr(&x, "1 -1 -1")); // "1 <x> <y>"
	BN256_G1_neg(&x, &x);
	CYBOZU_TEST_ASSERT(BN256_G1_isSame(&x, &y));

	CYBOZU_TEST_ASSERT(!BN256_G1_hashAndMapTo(&y, "abc"));

	BN256_G1_dbl(&x, &y); // x = 2y
	BN256_G1_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(BN256_G1_isSame(&x, &z));
	BN256_G1_add(&z, &z, &y); // z = 3y
	BN256_Fr n;
	BN256_Fr_setInt(&n, 3);
	BN256_G1_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(BN256_G1_isSame(&x, &z));
	BN256_G1_sub(&x, &x, &y); // x = 2y

	BN256_Fr_setInt(&n, 2);
	BN256_G1_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(BN256_G1_isSame(&x, &z));
}

CYBOZU_TEST_AUTO(G2)
{
	BN256_G2 x, y, z;
	BN256_G2_clear(&x);
	BN256_G2_setStr(&y, "0");
	CYBOZU_TEST_ASSERT(BN256_G2_isZero(&x));
	CYBOZU_TEST_ASSERT(BN256_G2_isZero(&y));

	CYBOZU_TEST_ASSERT(!BN256_G2_hashAndMapTo(&x, "abc"));

	char buf[1024];
	CYBOZU_TEST_ASSERT(!BN256_G2_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_ASSERT(!BN256_G2_setStr(&y, buf));
	CYBOZU_TEST_ASSERT(BN256_G2_isSame(&x, &y));

	BN256_G2_neg(&x, &x);
	BN256_G2_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(BN256_G2_isZero(&x));

	BN256_G2_dbl(&x, &y); // x = 2y
	BN256_G2_add(&z, &y, &y);
	CYBOZU_TEST_ASSERT(BN256_G2_isSame(&x, &z));
	BN256_G2_add(&z, &z, &y); // z = 3y
	BN256_Fr n;
	BN256_Fr_setInt(&n, 3);
	BN256_G2_mul(&x, &y, &n); //  x = 3y
	CYBOZU_TEST_ASSERT(BN256_G2_isSame(&x, &z));
	BN256_G2_sub(&x, &x, &y); // x = 2y

	BN256_Fr_setInt(&n, 2);
	BN256_G2_mul(&z, &y, &n); //  z = 2y
	CYBOZU_TEST_ASSERT(BN256_G2_isSame(&x, &z));
}

CYBOZU_TEST_AUTO(GT)
{
	BN256_GT x, y, z;
	memset(&x, 1, sizeof(x));
	CYBOZU_TEST_ASSERT(!BN256_GT_isZero(&x));

	BN256_GT_clear(&x);
	CYBOZU_TEST_ASSERT(BN256_GT_isZero(&x));

	char buf[1024];
	CYBOZU_TEST_ASSERT(!BN256_GT_setStr(&x, "1 2 3 4 5 6 7 8 9 10 11 12"));
	CYBOZU_TEST_ASSERT(!BN256_GT_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "1 2 3 4 5 6 7 8 9 10 11 12");

	BN256_GT_copy(&y, &x);
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&x, &y));

	CYBOZU_TEST_ASSERT(!BN256_GT_setStr(&z, "-1 -2 -3 -4 -5 -6 -7 -8 -9 -10 -11 -12"));
	CYBOZU_TEST_ASSERT(!BN256_GT_getStr(buf, sizeof(buf), &z));
	CYBOZU_TEST_ASSERT(!BN256_GT_setStr(&y, buf));

	BN256_GT_neg(&z, &y);
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&x, &z));

	BN256_GT_add(&y, &x, &y);
	CYBOZU_TEST_ASSERT(BN256_GT_isZero(&y));

	CYBOZU_TEST_ASSERT(!BN256_GT_setStr(&y, "2 0 0 0 0 0 0 0 0 0 0 0"));
	BN256_GT_mul(&z, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_GT_getStr(buf, sizeof(buf), &z));
	CYBOZU_TEST_EQUAL(buf, "2 4 6 8 10 12 14 16 18 20 22 24");

	BN256_GT_div(&z, &z, &y);
	CYBOZU_TEST_ASSERT(!BN256_GT_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&x, &z));

	BN256_Fr n;
	BN256_Fr_setInt(&n, 3);
	BN256_GT_pow(&z, &x, &n);
	BN256_GT_mul(&y, &x, &x);
	BN256_GT_mul(&y, &y, &x);
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&y, &z));
}

CYBOZU_TEST_AUTO(pairing)
{
	BN256_Fr a, b, ab;
	BN256_Fr_setInt(&a, 123);
	BN256_Fr_setInt(&b, 456);
	BN256_Fr_mul(&ab, &a, &b);
	BN256_G1 P, aP;
	BN256_G2 Q, bQ;
	BN256_GT e, e1, e2;

	CYBOZU_TEST_ASSERT(!BN256_G1_setStr(&P, "1 -1 1")); // "1 <x> <y>"
	CYBOZU_TEST_ASSERT(!BN256_G2_hashAndMapTo(&Q, "1"));

	BN256_G1_mul(&aP, &P, &a);
	BN256_G2_mul(&bQ, &Q, &b);

	BN256_pairing(&e, &P, &Q);
	BN256_GT_pow(&e1, &e, &a);
	BN256_pairing(&e2, &aP, &Q);
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&e1, &e2));

	BN256_GT_pow(&e1, &e, &b);
	BN256_pairing(&e2, &P, &bQ);
	CYBOZU_TEST_ASSERT(BN256_GT_isSame(&e1, &e2));
}

CYBOZU_TEST_AUTO(end)
{
	int ret = BN256_setErrFile("");
	CYBOZU_TEST_EQUAL(ret, 0);
}