#define MCL_USE_LLVM
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include "../src/fp_proto.hpp"
#include "../src/low_gmp.hpp"

cybozu::XorShift rg;

CYBOZU_TEST_AUTO(addNC)
{
	using namespace mcl::fp;
	const size_t N = 256 / UnitBitSize;
	Unit x[N], y[N];
	for (int i = 0; i < 10; i++) {
		Unit z[N];
		Unit w[N];
		rg.read(x, N);
		rg.read(y, N);
		low_add<N>(z, x, y);
		mcl_fp_addNC256(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N);
	}
}

