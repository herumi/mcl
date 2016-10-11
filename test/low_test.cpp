#ifndef MCL_USE_LLVM
	#define MCL_USE_LLVM
#endif
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/itoa.hpp>
#include "../src/fp_proto.hpp"
#include <cybozu/benchmark.hpp>

cybozu::XorShift rg;

extern "C" void add_test(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);

template<size_t N>
void addNC(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);

template<size_t N>
void subNC(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);

#define DEF_FUNC(BIT) \
	template<> void addNC<BIT>(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y) { mcl_fp_addNC ## BIT(z, x, y); } \
	template<> void subNC<BIT>(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y) { mcl_fp_subNC ## BIT(z, x, y); }

DEF_FUNC(64)
DEF_FUNC(128)
DEF_FUNC(192)
DEF_FUNC(256)
DEF_FUNC(320)
DEF_FUNC(384)
DEF_FUNC(448)
DEF_FUNC(512)
//DEF_FUNC(96)
//DEF_FUNC(160)
//DEF_FUNC(224)

template<size_t bit>
void bench()
{
	using namespace mcl::fp;
	const size_t N = bit / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_addNC_G<N>(z, x, y);
		addNC<bit>(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);

		low_subNC_G<N>(z, x, y);
		subNC<bit>(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
	const std::string bitS = cybozu::itoa(bit);
	std::string name;
	name = "add" + bitS; CYBOZU_BENCH(name.c_str(), addNC<bit>, x, x, y);
	name = "sub" + bitS; CYBOZU_BENCH(name.c_str(), subNC<bit>, x, x, y);
}

CYBOZU_TEST_AUTO(addNC64) { bench<64>(); }
CYBOZU_TEST_AUTO(addNC128) { bench<128>(); }
CYBOZU_TEST_AUTO(addNC192) { bench<192>(); }
CYBOZU_TEST_AUTO(addNC256) { bench<256>(); }
CYBOZU_TEST_AUTO(addNC320) { bench<320>(); }
CYBOZU_TEST_AUTO(addNC384) { bench<384>(); }
CYBOZU_TEST_AUTO(addNC448) { bench<448>(); }
CYBOZU_TEST_AUTO(addNC512) { bench<512>(); }
//CYBOZU_TEST_AUTO(addNC96) { bench<96>(); }
//CYBOZU_TEST_AUTO(addNC160) { bench<160>(); }
//CYBOZU_TEST_AUTO(addNC224) { bench<224>(); }
#if 0
CYBOZU_TEST_AUTO(addNC)
{
	using namespace mcl::fp;
	const size_t bit = 128;
	const size_t N = bit / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_addNC_G<N>(z, x, y);
		addNC<bit>(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
		add_test(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
	std::string name = "add" + cybozu::itoa(bit);
	CYBOZU_BENCH(name.c_str(), addNC<bit>, x, x, y);
	CYBOZU_BENCH("add", add_test, x, x, y);
}
#endif

