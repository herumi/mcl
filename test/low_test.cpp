#define MCL_USE_LLVM
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/itoa.hpp>
#include "../src/fp_proto.hpp"
#include "../src/low_gmp.hpp"
#include <cybozu/benchmark.hpp>

cybozu::XorShift rg;

extern "C" void mcl_fp_addNC64(uint32_t *z, const uint32_t *x, const uint32_t *y);
extern "C" void mcl_fp_addNC96(uint32_t *z, const uint32_t *x, const uint32_t *y);
extern "C" void mcl_fp_addNC128(uint32_t *z, const uint32_t *x, const uint32_t *y);

template<size_t N>
void addNC(uint32_t *z, const uint32_t *x, const uint32_t *y);

#define DEF_ADD(BIT) template<> void addNC<BIT>(uint32_t *z, const uint32_t *x, const uint32_t *y) { mcl_fp_addNC ## BIT(z, x, y); }

DEF_ADD(64)
DEF_ADD(96)
//DEF_ADD(128)

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
	std::string name = "name" + cybozu::itoa(bit);
	CYBOZU_BENCH(name.c_str(), addNC<bit>, x, x, y);
}

CYBOZU_TEST_AUTO(addNC64)
{
	benchAdd<64>();
}
CYBOZU_TEST_AUTO(addNC96)
{
	benchAdd<96>();
}

