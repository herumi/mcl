#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <mcl/fp_util.hpp>
#include <cybozu/test.hpp>

CYBOZU_TEST_AUTO(toStr16)
{
	const struct {
		uint32_t x[4];
		size_t n;
		const char *str;
	} tbl[] = {
		{ { 0, 0, 0, 0 }, 0, "0" },
		{ { 0x123, 0, 0, 0 }, 1, "123" },
		{ { 0x12345678, 0xaabbcc, 0, 0 }, 2, "aabbcc12345678" },
		{ { 0, 0x12, 0x234a, 0 }, 3, "234a0000001200000000" },
		{ { 1, 2, 0xffffffff, 0x123abc }, 4, "123abcffffffff0000000200000001" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str;
		mcl::fp::toStr16(str, tbl[i].x, tbl[i].n, false);
		CYBOZU_TEST_EQUAL(str, tbl[i].str);
		mcl::fp::toStr16(str, tbl[i].x, tbl[i].n, true);
		CYBOZU_TEST_EQUAL(str, std::string("0x") + tbl[i].str);
	}
}

// CYBOZU_TEST_AUTO(toStr2) // QQQ
// CYBOZU_TEST_AUTO(verifyStr) // QQQ

CYBOZU_TEST_AUTO(fromStr16)
{
	const struct {
		const char *str;
		uint64_t x[4];
	} tbl[] = {
		{ "0", { 0, 0, 0, 0 } },
		{ "5", { 5, 0, 0, 0 } },
		{ "123", { 0x123, 0, 0, 0 } },
		{ "123456789012345679adbc", { uint64_t(0x789012345679adbcull), 0x123456, 0, 0 } },
		{ "ffffffff26f2fc170f69466a74defd8d", { uint64_t(0x0f69466a74defd8dull), uint64_t(0xffffffff26f2fc17ull), 0, 0 } },
		{ "100000000000000000000000000000033", { uint64_t(0x0000000000000033ull), 0, 1, 0 } },
		{ "11ee12312312940000000000000000000000000002342343", { uint64_t(0x0000000002342343ull), uint64_t(0x0000000000000000ull), uint64_t(0x11ee123123129400ull), 0 } },
		{ "1234567890abcdefABCDEF123456789aba32134723424242424", { uint64_t(0x2134723424242424ull), uint64_t(0xDEF123456789aba3ull), uint64_t(0x4567890abcdefABCull), 0x123 } },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const size_t xN = 4;
		uint64_t x[xN];
		mcl::fp::fromStr16(x, xN, tbl[i].str, strlen(tbl[i].str));
		for (size_t j = 0; j < xN; j++) {
			CYBOZU_TEST_EQUAL(x[j], tbl[i].x[j]);
		}
	}
}

CYBOZU_TEST_AUTO(compareArray)
{
	const struct {
		uint32_t a[4];
		uint32_t b[4];
		size_t n;
		int expect;
	} tbl[] = {
		{ { 0, 0, 0, 0 }, { 0, 0, 0, 0 }, 0, 0 },
		{ { 1, 0, 0, 0 }, { 0, 0, 0, 0 }, 1, 1 },
		{ { 0, 0, 0, 0 }, { 1, 0, 0, 0 }, 1, -1 },
		{ { 1, 0, 0, 0 }, { 1, 0, 0, 0 }, 1, 0 },
		{ { 3, 1, 1, 0 }, { 2, 1, 1, 0 }, 4, 1 },
		{ { 9, 2, 1, 1 }, { 1, 3, 1, 1 }, 4, -1 },
		{ { 1, 7, 8, 4 }, { 1, 7, 8, 9 }, 3, 0 },
		{ { 1, 7, 8, 4 }, { 1, 7, 8, 9 }, 4, -1 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		int e = mcl::fp::compareArray(tbl[i].a, tbl[i].b, tbl[i].n);
		CYBOZU_TEST_EQUAL(e, tbl[i].expect);
	}
}

struct Rand {
	std::vector<uint32_t> v;
	size_t pos;
	int count;
	void read(uint32_t *x, size_t n)
	{
		if (v.size() < pos + n) throw cybozu::Exception("Rand:get:bad n") << v.size() << pos << n;
		std::copy(v.begin() + pos, v.begin() + pos + n, x);
		pos += n;
		count++;
	}
	Rand(const uint32_t *x, size_t n)
		: pos(0)
		, count(0)
	{
		for (size_t i = 0; i < n; i++) {
			v.push_back(x[i]);
		}
	}
};

CYBOZU_TEST_AUTO(getRandVal)
{
	const size_t rn = 8;
	const struct {
		uint32_t r[rn];
		uint32_t mod[2];
		size_t bitLen;
		int count;
		uint32_t expect[2];
	} tbl[] = {
		{ { 1, 2, 3, 4, 5, 6, 7, 8 }, { 5, 6 }, 64, 1, { 1, 2 } },
		{ { 0xfffffffc, 0x7, 3, 4, 5, 6, 7, 8 }, { 0xfffffffe, 0x3 }, 34, 1, { 0xfffffffc, 0x3 } },
		{ { 0xfffffffc, 0x7, 3, 4, 5, 6, 7, 8 }, { 0xfffffffb, 0x3 }, 34, 2, { 3, 0 } },
		{ { 2, 3, 5, 7, 4, 3, 0, 3 }, { 1, 0x3 }, 34, 4, { 0, 3 } },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		Rand rg(tbl[i].r, rn);
		uint32_t out[2];
		mcl::fp::getRandVal(out, rg, tbl[i].mod, tbl[i].bitLen);
		CYBOZU_TEST_EQUAL(out[0], tbl[i].expect[0]);
		CYBOZU_TEST_EQUAL(out[1], tbl[i].expect[1]);
		CYBOZU_TEST_EQUAL(rg.count, tbl[i].count);
	}
}

CYBOZU_TEST_AUTO(shiftLeftOr)
{
	const struct {
		uint32_t x[4];
		size_t n;
		size_t shift;
		uint32_t y;
		uint32_t z[4];
		uint32_t ret;
	} tbl[] = {
		{ { 0x12345678, 0, 0, 0 }, 1, 0, 0, { 0x12345678, 0, 0, 0 }, 0 },
		{ { 0x12345678, 0, 0, 0 }, 1, 1, 0, { 0x2468acf0, 0, 0, 0 }, 0 },
		{ { 0xf2345678, 0, 0, 0 }, 1, 1, 5, { 0xe468acf5, 0, 0, 0 }, 1 },
		{ { 0x12345678, 0x9abcdef0, 0x11112222, 0xffccaaee }, 4, 19, 0x1234, { 0xb3c01234, 0xf78091a2, 0x1114d5e6, 0x57708889 }, 0x7fe65 },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		uint32_t z[4];
		uint32_t ret = mcl::fp::shiftLeftOr(z, tbl[i].x, tbl[i].n, tbl[i].shift, tbl[i].y);
		CYBOZU_TEST_EQUAL_ARRAY(z, tbl[i].z, tbl[i].n);
		CYBOZU_TEST_EQUAL(ret, tbl[i].ret);
	}
}

CYBOZU_TEST_AUTO(shiftRight)
{
	const struct {
		uint32_t x[4];
		size_t n;
		size_t shift;
		uint32_t z[4];
	} tbl[] = {
		{ { 0x12345678, 0, 0, 0 }, 4, 0, { 0x12345678, 0, 0, 0 } },
		{ { 0x12345678, 0xaaaabbbb, 0xffeebbcc, 0xfeba9874 }, 4, 1, { 0x891a2b3c, 0x55555ddd, 0x7ff75de6, 0x7f5d4c3a } },
		{ { 0x12345678, 0xaaaabbbb, 0xffeebbcc, 0xfeba9874 }, 4, 18, { 0xaeeec48d, 0xaef32aaa, 0xa61d3ffb, 0x3fae } },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		uint32_t z[4];
		mcl::fp::shiftRight(z, tbl[i].x, tbl[i].n, tbl[i].shift);
		CYBOZU_TEST_EQUAL_ARRAY(z, tbl[i].z, tbl[i].n);
	}
}

CYBOZU_TEST_AUTO(splitBitVec)
{
	uint32_t tbl[] = { 0x12345678, 0xaaaabbbb, 0xffeebbcc };
	typedef cybozu::BitVectorT<uint32_t> BitVec;
	typedef std::vector<int> IntVec;
	BitVec bv;
	bv.append(tbl, sizeof(tbl) * 8);
	for (size_t len = bv.size(); len > 0; len--) {
		bv.resize(len);
		for (size_t w = 1; w < 18; w++) {
			IntVec iv;
			size_t last = mcl::fp::splitBitVec(iv, bv, w);
			size_t q = len / w;
			size_t r = len % w;
			if (r == 0) {
				r = w;
			} else {
				q++;
			}
			CYBOZU_TEST_EQUAL(iv.size(), q);
			BitVec bv2;
			mcl::fp::concatBitVec(bv2, iv, w, last);
			CYBOZU_TEST_ASSERT(bv == bv2);
		}
	}
}
