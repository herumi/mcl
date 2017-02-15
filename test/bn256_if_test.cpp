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

	BN256_Fr_setStr(&x, "12345678901234567");
	BN256_Fr_setStr(&y, "20000000000000000");
	BN256_Fr_add(&x, &x, &y);
	CYBOZU_TEST_ASSERT(!BN256_Fr_getStr(buf, sizeof(buf), &x));
	CYBOZU_TEST_EQUAL(buf, "32345678901234567");
}
