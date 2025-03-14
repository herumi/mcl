#include <cybozu/test.hpp>
#include <mcl/conversion.hpp>

CYBOZU_TEST_AUTO(arrayToDec)
{
	const bool bit64 = MCL_SIZEOF_UNIT == 8;
	const struct {
		mcl::Unit x[192 / MCL_UNIT_BIT_SIZE];
		size_t xn;
		const char *s;
	} tbl[] = {
		{ { MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, 1, "0" },
		{ { MCL_U64_TO_UNIT(9), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, 1, "9" },
		{ { MCL_U64_TO_UNIT(123456789), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, 1, "123456789" },
		{ { MCL_U64_TO_UNIT(2147483647), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, 1, "2147483647" },
		{ { MCL_U64_TO_UNIT(0xffffffff), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, 1, "4294967295" },
		{ { MCL_U64_TO_UNIT(0x2540be400), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, bit64 ? 1 : 2, "10000000000" },
		{ { MCL_U64_TO_UNIT(0xffffffffffffffff), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, bit64 ? 1 : 2, "18446744073709551615" },
		{ { MCL_U64_TO_UNIT(0x8ac7230489e80001), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, bit64 ? 1 : 2, "10000000000000000001" },
		{ { MCL_U64_TO_UNIT(0x8ac72304c582ca00), MCL_U64_TO_UNIT(0), MCL_U64_TO_UNIT(0) }, bit64 ? 1 : 2, "10000000001000000000" },
		{ { MCL_U64_TO_UNIT(0x0), MCL_U64_TO_UNIT(1), MCL_U64_TO_UNIT(0) }, bit64 ? 2 : 3, "18446744073709551616" },
		{ { MCL_U64_TO_UNIT(0xffffffffffffffff), MCL_U64_TO_UNIT(0xffffffffffffffff), MCL_U64_TO_UNIT(0) }, bit64 ? 2 : 4, "340282366920938463463374607431768211455" },
		{ { MCL_U64_TO_UNIT(0xffffffffffffffff), MCL_U64_TO_UNIT(0xffffffffffffffff), MCL_U64_TO_UNIT(0xffffffff) }, bit64 ? 3 : 5, "1461501637330902918203684832716283019655932542975" },
		{ { MCL_U64_TO_UNIT(0x5e3f37003b9aca00), MCL_U64_TO_UNIT(0x04f6433a1cbfa532), MCL_U64_TO_UNIT(0xd83ff078) }, bit64 ? 3 : 5, "1234567901234560000000000000000000000001000000000" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const size_t bufSize = 128;
		char buf[bufSize] = {};
		const char *str = tbl[i].s;
		const mcl::Unit *x = tbl[i].x;
		const size_t strLen = strlen(str);
		size_t n = mcl::fp::arrayToDec(buf, bufSize, x, tbl[i].xn);
		CYBOZU_TEST_EQUAL(n, strLen);
		CYBOZU_TEST_EQUAL_ARRAY(buf + bufSize - n, str, n);
		const size_t maxN = 32;
		mcl::Unit xx[maxN] = {};
		size_t xn = mcl::fp::decToArray(xx, maxN, str, strLen);
		CYBOZU_TEST_EQUAL(xn, tbl[i].xn);
		CYBOZU_TEST_EQUAL_ARRAY(xx, x, xn);
	}
}

CYBOZU_TEST_AUTO(writeHexStr)
{
	const char *hex1tbl = "0123456789abcdef";
	const char *hex2tbl = "0123456789ABCDEF";
	for (size_t i = 0; i < 16; i++) {
		uint8_t v = 0xff;
		CYBOZU_TEST_ASSERT(mcl::fp::local::hexCharToUint8(&v, hex1tbl[i]));
		CYBOZU_TEST_EQUAL(v, i);
		CYBOZU_TEST_ASSERT(mcl::fp::local::hexCharToUint8(&v, hex2tbl[i]));
		CYBOZU_TEST_EQUAL(v, i);
	}
	const struct Tbl {
		const char *bin;
		size_t n;
		const char *hex;
	} tbl[] = {
		{ "", 0, "" },
		{ "\x12\x34\xab", 3, "1234ab" },
		{ "\xff\xfc\x00\x12", 4, "fffc0012" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		char buf[32];
		cybozu::MemoryOutputStream os(buf, sizeof(buf));
		const char *bin = tbl[i].bin;
		const char *hex = tbl[i].hex;
		size_t n = tbl[i].n;
		bool b;
		mcl::fp::writeHexStr(&b, os, bin, n);
		CYBOZU_TEST_ASSERT(b);
		CYBOZU_TEST_EQUAL(os.getPos(), n * 2);
		CYBOZU_TEST_EQUAL_ARRAY(buf, hex, n * 2);

		cybozu::MemoryInputStream is(hex, n * 2);
		size_t w = mcl::fp::readHexStr(buf, n, is);
		CYBOZU_TEST_EQUAL(w, n);
		CYBOZU_TEST_EQUAL_ARRAY(buf, bin, n);
	}
}
