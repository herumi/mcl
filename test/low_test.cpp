#define MCL_USE_LLVM
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include "../src/fp_proto.hpp"
#include "../src/low_gmp.hpp"
#include <cybozu/benchmark.hpp>

cybozu::XorShift rg;

extern "C" void mcl_fp_addNC64(uint32_t *z, const uint32_t *x, const uint32_t *y);
extern "C" void mcl_fp_addNC96_1(uint32_t *z, const uint32_t *x, const uint32_t *y);
extern "C" void mcl_fp_addNC96_2(uint32_t *z, const uint32_t *x, const uint32_t *y);

CYBOZU_TEST_AUTO(addNC64)
{
	using namespace mcl::fp;
	const size_t N = 64 / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_add<N>(z, x, y);
		mcl_fp_addNC64(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
	CYBOZU_BENCH("add64", mcl_fp_addNC64, x, x, y);
}
CYBOZU_TEST_AUTO(addNC)
{
	using namespace mcl::fp;
	const size_t N = 96 / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_add<N>(z, x, y);
		mcl_fp_addNC96_1(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
		mcl_fp_addNC96_2(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
	CYBOZU_BENCH("add96_1", mcl_fp_addNC96_1, x, x, y);
	CYBOZU_BENCH("add96_2", mcl_fp_addNC96_2, x, x, y);
}

