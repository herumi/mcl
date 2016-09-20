#ifndef MCL_USE_LLVM
	#define MCL_USE_LLVM
#endif
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/itoa.hpp>
#include "../src/fp_proto.hpp"
#include "../src/low_gmp.hpp"
#include <cybozu/benchmark.hpp>

cybozu::XorShift rg;

extern "C" void mcl_fp_addNC64(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC96(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC128(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC160(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC192(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC224(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void mcl_fp_addNC256(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);
extern "C" void add_test(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);

template<size_t N>
void addNC(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y);

#define DEF_ADD(BIT) template<> void addNC<BIT>(mcl::fp::Unit *z, const mcl::fp::Unit *x, const mcl::fp::Unit *y) { mcl_fp_addNC ## BIT(z, x, y); }

DEF_ADD(64)
DEF_ADD(128)
DEF_ADD(192)
DEF_ADD(256)
DEF_ADD(320)
DEF_ADD(384)
DEF_ADD(448)
DEF_ADD(512)
//DEF_ADD(96)
//DEF_ADD(160)
//DEF_ADD(224)

#define CAT(S, BIT) "S##BIT"

template<size_t bit>
void benchAdd()
{
	using namespace mcl::fp;
	const size_t N = bit / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_add<N>(z, x, y);
		addNC<bit>(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
	std::string name = "add" + cybozu::itoa(bit);
	CYBOZU_BENCH(name.c_str(), addNC<bit>, x, x, y);
}

CYBOZU_TEST_AUTO(addNC64) { benchAdd<64>(); }
CYBOZU_TEST_AUTO(addNC128) { benchAdd<128>(); }
CYBOZU_TEST_AUTO(addNC192) { benchAdd<192>(); }
CYBOZU_TEST_AUTO(addNC256) { benchAdd<256>(); }
CYBOZU_TEST_AUTO(addNC320) { benchAdd<320>(); }
CYBOZU_TEST_AUTO(addNC384) { benchAdd<384>(); }
CYBOZU_TEST_AUTO(addNC448) { benchAdd<448>(); }
CYBOZU_TEST_AUTO(addNC512) { benchAdd<512>(); }
//CYBOZU_TEST_AUTO(addNC96) { benchAdd<96>(); }
//CYBOZU_TEST_AUTO(addNC160) { benchAdd<160>(); }
//CYBOZU_TEST_AUTO(addNC224) { benchAdd<224>(); }
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
		low_add<N>(z, x, y);
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

