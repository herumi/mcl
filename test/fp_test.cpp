#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/test.hpp>
#include <mcl/fp.hpp>
#include <cybozu/benchmark.hpp>
#include "../src/fp_proto.hpp"
#include <time.h>

#ifdef _MSC_VER
	#pragma warning(disable: 4127) // const condition
#endif

typedef mcl::FpT<> Fp;

const int m = 65537;
struct Init {
	Init()
	{
		std::ostringstream ms;
		ms << m;
		Fp::setModulo(ms.str());
	}
};

CYBOZU_TEST_SETUP_FIXTURE(Init);

CYBOZU_TEST_AUTO(cstr)
{
	const struct {
		const char *str;
		int val;
	} tbl[] = {
		{ "0", 0 },
		{ "1", 1 },
		{ "123", 123 },
		{ "0x123", 0x123 },
		{ "0b10101", 21 },
		{ "-123", m - 123 },
		{ "-0x123", m - 0x123 },
		{ "-0b10101", m - 21 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		// string cstr
		Fp x(tbl[i].str);
		CYBOZU_TEST_EQUAL(x, tbl[i].val);

		// int cstr
		Fp y(tbl[i].val);
		CYBOZU_TEST_EQUAL(y, x);

		// copy cstr
		Fp z(x);
		CYBOZU_TEST_EQUAL(z, x);

		// assign int
		Fp w;
		w = tbl[i].val;
		CYBOZU_TEST_EQUAL(w, x);

		// assign self
		Fp u;
		u = w;
		CYBOZU_TEST_EQUAL(u, x);

		// conv
		std::ostringstream os;
		os << tbl[i].val;

		std::string str;
		x.getStr(str);
		CYBOZU_TEST_EQUAL(str, os.str());
	}
}

CYBOZU_TEST_AUTO(setStr)
{
	const struct {
		const char *in;
		int out;
		int base;
	} tbl[] = {
		{ "100", 100, 0 }, // set base = 10 if base = 0
		{ "100", 4, 2 },
		{ "100", 256, 16 },
		{ "0b100", 4, 0 },
		{ "0b100", 4, 2 },
		{ "0x100", 256, 0 },
		{ "0x100", 256, 16 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Fp x;
		x.setStr(tbl[i].in, tbl[i].base);
		CYBOZU_TEST_EQUAL(x, tbl[i].out);
	}
	// conflict prefix with base
	Fp x;
	CYBOZU_TEST_EXCEPTION(x.setStr("0b100", 16), cybozu::Exception);
	CYBOZU_TEST_EXCEPTION(x.setStr("0x100", 2), cybozu::Exception);
}

CYBOZU_TEST_AUTO(stream)
{
	const struct {
		const char *in;
		int out10;
		int out16;
	} tbl[] = {
		{ "100", 100, 256 }, // set base = 10 if base = 0
		{ "0x100", 256, 256 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		{
			std::istringstream is(tbl[i].in);
			Fp x;
			is >> x;
			CYBOZU_TEST_EQUAL(x, tbl[i].out10);
		}
		{
			std::istringstream is(tbl[i].in);
			Fp x;
			is >> std::hex >> x;
			CYBOZU_TEST_EQUAL(x, tbl[i].out16);
		}
	}
	std::istringstream is("0b100");
	Fp x;
	CYBOZU_TEST_EXCEPTION(is >> std::hex >> x, cybozu::Exception);
}

CYBOZU_TEST_AUTO(conv)
{
	const char *bin = "0b1001000110100";
	const char *hex = "0x1234";
	const char *dec = "4660";
	Fp b(bin);
	Fp h(hex);
	Fp d(dec);
	CYBOZU_TEST_EQUAL(b, h);
	CYBOZU_TEST_EQUAL(b, d);

	std::string str;
	b.getStr(str, 2, true);
	CYBOZU_TEST_EQUAL(str, bin);
	b.getStr(str);
	CYBOZU_TEST_EQUAL(str, dec);
	b.getStr(str, 16, true);
	CYBOZU_TEST_EQUAL(str, hex);
}

CYBOZU_TEST_AUTO(compare)
{
	const struct {
		int lhs;
		int rhs;
		int cmp;
	} tbl[] = {
		{ 0, 0, 0 },
		{ 1, 0, 1 },
		{ 0, 1, -1 },
		{ -1, 0, 1 }, // m-1, 0
		{ 0, -1, -1 }, // 0, m-1
		{ 123, 456, -1 },
		{ 456, 123, 1 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Fp x(tbl[i].lhs);
		const Fp y(tbl[i].rhs);
		const int cmp = tbl[i].cmp;
		if (cmp == 0) {
			CYBOZU_TEST_EQUAL(x, y);
			CYBOZU_TEST_ASSERT(x >= y);
			CYBOZU_TEST_ASSERT(x <= y);
		} else if (cmp > 0) {
			CYBOZU_TEST_ASSERT(x > y);
			CYBOZU_TEST_ASSERT(x >= y);
		} else {
			CYBOZU_TEST_ASSERT(x < y);
			CYBOZU_TEST_ASSERT(x <= y);
		}
	}
	{
		Fp x(5);
		CYBOZU_TEST_ASSERT(x < 10);
		CYBOZU_TEST_ASSERT(x == 5);
		CYBOZU_TEST_ASSERT(x > 2);
	}
}

CYBOZU_TEST_AUTO(modulo)
{
	std::ostringstream ms;
	ms << m;

	std::string str;
	Fp::getModulo(str);
	CYBOZU_TEST_EQUAL(str, ms.str());
}

CYBOZU_TEST_AUTO(ope)
{
	const struct {
		int x;
		int y;
		int add; // x + y
		int sub; // x - y
		int mul; // x * y
		int sqr; // x^2
	} tbl[] = {
		{ 0, 1, 1, m - 1, 0, 0 },
		{ 9, 5, 14, 4, 45, 81 },
		{ 10, 13, 23, m - 3, 130, 100 },
		{ 2000, 1000, 3000, 1000, (2000 * 1000) % m, (2000 * 2000) % m },
		{ 12345, 9999, 12345 + 9999, 12345 - 9999, (12345 * 9999) % m, (12345 * 12345) % m },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Fp x(tbl[i].x);
		const Fp y(tbl[i].y);
		Fp z;
		Fp::add(z, x, y);
		CYBOZU_TEST_EQUAL(z, tbl[i].add);
		Fp::sub(z, x, y);
		CYBOZU_TEST_EQUAL(z, tbl[i].sub);
		Fp::mul(z, x, y);
		CYBOZU_TEST_EQUAL(z, tbl[i].mul);

		Fp r;
		Fp::inv(r, y);
		Fp::mul(z, z, r);
		CYBOZU_TEST_EQUAL(z, tbl[i].x);
		z = x + y;
		CYBOZU_TEST_EQUAL(z, tbl[i].add);
		z = x - y;
		CYBOZU_TEST_EQUAL(z, tbl[i].sub);
		z = x * y;
		CYBOZU_TEST_EQUAL(z, tbl[i].mul);

		Fp::sqr(z, x);
		CYBOZU_TEST_EQUAL(z, tbl[i].sqr);

		z = x / y;
		z *= y;
		CYBOZU_TEST_EQUAL(z, tbl[i].x);
	}
	Fp x(5), y(3), z;
	Fp::addNC(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp(8));
	Fp::subNC(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp(2));
}

struct tag2;

CYBOZU_TEST_AUTO(power)
{
	Fp x, y, z;
	x = 12345;
	z = 1;
	for (int i = 0; i < 100; i++) {
		Fp::power(y, x, i);
		CYBOZU_TEST_EQUAL(y, z);
		z *= x;
	}
	typedef mcl::FpT<tag2, 128> Fp2;
	Fp2::setModulo("1009");
	x = 5;
	Fp2 n = 3;
	z = 3;
	Fp::power(x, x, z);
	CYBOZU_TEST_EQUAL(x, 125);
	x = 5;
	Fp::power(x, x, n);
	CYBOZU_TEST_EQUAL(x, 125);
}

CYBOZU_TEST_AUTO(neg_power)
{
	Fp x, y, z;
	x = 12345;
	z = 1;
	Fp rx = 1 / x;
	for (int i = 0; i < 100; i++) {
		Fp::power(y, x, -i);
		CYBOZU_TEST_EQUAL(y, z);
		z *= rx;
	}
}

CYBOZU_TEST_AUTO(power_fp)
{
	Fp x, y, z;
	x = 12345;
	z = 1;
	for (int i = 0; i < 100; i++) {
		Fp::power(y, x, Fp(i));
		CYBOZU_TEST_EQUAL(y, z);
		z *= x;
	}
}

struct TagAnother;

CYBOZU_TEST_AUTO(another)
{
	typedef mcl::FpT<TagAnother, 128> G;
	G::setModulo("13");
	G a = 3;
	G b = 9;
	a *= b;
	CYBOZU_TEST_EQUAL(a, 1);
}

CYBOZU_TEST_AUTO(setArray)
{
	Fp::setModulo("1000000000000000000117");
	char b1[] = { 0x56, 0x34, 0x12 };
	Fp x;
	x.setArray(b1, 3);
	CYBOZU_TEST_EQUAL(x, 0x123456);
	int b2[] = { 0x12, 0x34 };
	x.setArray(b2, 2);
	CYBOZU_TEST_EQUAL(x, Fp("0x3400000012"));

	Fp::setModulo("0x10000000000001234567a5");
	const struct {
		uint32_t buf[3];
		size_t bufN;
		const char *expected;
	} tbl[] = {
		{ { 0x234567a4, 0x00000001, 0x00100000}, 1, "0x234567a4" },
		{ { 0x234567a4, 0x00000001, 0x00100000}, 2, "0x1234567a4" },
		{ { 0x234567a4, 0x00000001, 0x00080000}, 3, "0x08000000000001234567a4" },
		{ { 0x234567a4, 0x00000001, 0x00100000}, 3, "0x10000000000001234567a4" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		x.setArray(tbl[i].buf, tbl[i].bufN);
		CYBOZU_TEST_EQUAL(x, Fp(tbl[i].expected));
	}
	uint32_t large[3] = { 0x234567a5, 0x00000001, 0x00100000};
	CYBOZU_TEST_EXCEPTION(x.setArray(large, 3), cybozu::Exception);
}

CYBOZU_TEST_AUTO(setArrayMask)
{
	Fp::setModulo("1000000000000000000117");
	char b1[] = { 0x56, 0x34, 0x12 };
	Fp x;
	x.setArrayMask(b1, 3);
	CYBOZU_TEST_EQUAL(x, 0x123456);
	int b2[] = { 0x12, 0x34 };
	x.setArrayMask(b2, 2);
	CYBOZU_TEST_EQUAL(x, Fp("0x3400000012"));

	Fp::setModulo("0x10000000000001234567a5");
	const struct {
		uint32_t buf[3];
		size_t bufN;
		const char *expected;
	} tbl[] = {
		{ { 0x234567a4, 0x00000001, 0x00100000}, 1, "0x234567a4" },
		{ { 0x234567a4, 0x00000001, 0x00100000}, 2, "0x1234567a4" },
		{ { 0x234567a4, 0x00000001, 0x00100000}, 3, "0x00000000000001234567a4" },
		{ { 0x234567a5, 0xfffffff1, 0xffffffff}, 3, "0x0ffffffffffff1234567a5" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		x.setArrayMask(tbl[i].buf, tbl[i].bufN);
		CYBOZU_TEST_EQUAL(x, Fp(tbl[i].expected));
	}
}

CYBOZU_TEST_AUTO(set64bit)
{
	Fp::setModulo("0x1000000000000000000f");
	const struct {
		const char *p;
		int64_t i;
	} tbl[] = {
		{ "0x1234567812345678", int64_t(0x1234567812345678ull) },
		{ "0xfffedcba987edcba997", -int64_t(0x1234567812345678ull) },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Fp x(tbl[i].p);
		Fp y(tbl[i].i);
		CYBOZU_TEST_EQUAL(x, y);
	}
}

CYBOZU_TEST_AUTO(getUint64)
{
	Fp::setModulo("0x1000000000000000000f");
	const uint64_t tbl[] = {
		0, 1, 123, 0xffffffff, int64_t(0x7fffffffffffffffull)
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		uint64_t a = tbl[i];
		Fp x(a);
		uint64_t b = x.getUint64();
		CYBOZU_TEST_ASSERT(!x.isNegative());
		CYBOZU_TEST_EQUAL(a, b);
	}
	{
		Fp x("0xffffffffffffffff");
		CYBOZU_TEST_EQUAL(x.getUint64(), uint64_t(0xffffffffffffffffull));
	}
	{
		Fp x("0x10000000000000000");
		CYBOZU_TEST_EXCEPTION(x.getUint64(), cybozu::Exception);
		x = -1;
		CYBOZU_TEST_EXCEPTION(x.getUint64(), cybozu::Exception);
	}
	{
		Fp x("0x10000000000000000");
		bool b = true;
		CYBOZU_TEST_EQUAL(x.getUint64(&b), 0);
		CYBOZU_TEST_ASSERT(!b);
	}
}

CYBOZU_TEST_AUTO(getInt64)
{
	Fp::setModulo("0x1000000000000000000f");
	const int64_t tbl[] = {
		0, 1, 123, 0xffffffff, int64_t(0x7fffffffffffffffull),
		-1, -2, -12345678, -int64_t(1) << 63,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		int64_t a = tbl[i];
		Fp x(a);
		CYBOZU_TEST_EQUAL(x.isNegative(), a < 0);
		int64_t b = x.getInt64();
		CYBOZU_TEST_EQUAL(a, b);
	}
	{
		Fp x("0x8000000000000000");
		CYBOZU_TEST_EXCEPTION(x.getInt64(), cybozu::Exception);
	}
	{
		Fp x("0x8000000000000000");
		bool b = true;
		CYBOZU_TEST_EQUAL(x.getInt64(&b), 0);
		CYBOZU_TEST_ASSERT(!b);
	}
}

CYBOZU_TEST_AUTO(getArray)
{
	const struct {
		const char *s;
		uint32_t v[4];
		size_t vn;
	} tbl[] = {
		{ "0", { 0, 0, 0, 0 }, 1 },
		{ "1234", { 1234, 0, 0, 0 }, 1 },
		{ "0xaabbccdd12345678", { 0x12345678, 0xaabbccdd, 0, 0 }, 2 },
		{ "0x11112222333344445555666677778888", { 0x77778888, 0x55556666, 0x33334444, 0x11112222 }, 4 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		mpz_class x(tbl[i].s);
		const size_t bufN = 8;
		uint32_t buf[bufN];
		mcl::Gmp::getArray(buf, bufN, x);
		size_t n = mcl::fp::getNonZeroArraySize(buf, bufN);
		CYBOZU_TEST_EQUAL(n, tbl[i].vn);
		CYBOZU_TEST_EQUAL_ARRAY(buf, tbl[i].v, n);
	}
}

CYBOZU_TEST_AUTO(getStr)
{
	const char *tbl[] = {
		"0x0",
		"0x5",
		"0x123",
		"0x123456789012345679adbc",
		"0xffffffff26f2fc170f69466a74defd8d",
		"0x100000000000000000000000000000033",
		"0x11ee12312312940000000000000000000000000002342343"
	};
	Fp::setModulo("0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		mpz_class x(tbl[i]);
		Fp y(tbl[i]);
		std::string xs, ys;
		mcl::Gmp::getStr(xs, x, 16);
		y.getStr(ys, 16);
		CYBOZU_TEST_EQUAL(xs, ys);
	}
}

#include <iostream>
#if defined(MCL_USE_LLVM) || defined(MCL_USE_XBYAK)
CYBOZU_TEST_AUTO(mod_NIST_P521)
{
	const size_t len = 521;
	const size_t N = len / mcl::fp::UnitBitSize;
	const char *tbl[] = {
		"0",
		"0xffffffff",
		"0x1fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0",
		"0x1fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe",
		"0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
		"0x20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
		"0x20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00111423424",
		"0x11111111111111112222222222222222333333333333333344444444444444445555555555555555666666666666666677777777777777778888888888888888aaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbccccccccccccccccddddddddddddddddeeeeeeeeeeeeeeeeffffffffffffffff1234712341234123412341234123412341234",
		"0x3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	const char *p = "0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
	Fp::setModulo(p, 0, mcl::fp::FP_XBYAK);
	const mcl::fp::Op& op = Fp::getOp();
	const mpz_class mp(p);
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		mpz_class mx(tbl[i]);
		mcl::fp::Unit in[N * 2 + 1] = {};
		mcl::fp::Unit ok[N + 1];
		mcl::fp::Unit ex[N + 1];
		mcl::Gmp::getArray(in, N * 2 + 1, mx);
		mpz_class my = mx % mp;
		mcl::Gmp::getArray(ok, N + 1, my);
#ifdef MCL_USE_LLVM
		mcl_fpDbl_mod_NIST_P521(ex, in);
		CYBOZU_TEST_ASSERT(memcmp(ex, ok, sizeof(ex)) == 0);
#endif
#ifdef MCL_USE_XBYAK
		op.fpDbl_mod(ex, in);
		CYBOZU_TEST_ASSERT(memcmp(ex, ok, sizeof(ex)) == 0);
#endif
	}
}
#endif
