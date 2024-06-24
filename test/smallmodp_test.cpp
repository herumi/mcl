#include <mcl/bls12_381.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/test.hpp>

using namespace mcl;
using namespace mcl::bn;

template<class F>
void test(const char *s)
{
	puts(s);
	cybozu::XorShift rg;
	F x, z1, z2;
	for (size_t i = 0; i < 1000; i++) {
		x.setByCSPRNG(rg);
		uint32_t y = uint32_t(i);
		z1 = x * y;
		F::mulUnit(z2, x, y);
		CYBOZU_TEST_EQUAL(z1, z2);
	}
#ifdef NDEBUG
	const int C = 100000;
	for (uint32_t i = 1; i < 10; i++) {
		printf("i=% 2d ", i);
		CYBOZU_BENCH_C("mulUnit", C, F::mulUnit, x, x, i);
	}
	CYBOZU_BENCH_C("mulUnit [1-256]", C, F::mulUnit, x, x, (*x.getUnit() % 256) + 1);
	CYBOZU_BENCH_C("mulUnit [1000-1255]", C, F::mulUnit, x, x, (*x.getUnit() % 256) + 1000);
	CYBOZU_BENCH_C("mulUnit all", C, F::mulUnit, x, x, uint32_t(*x.getUnit()));
	CYBOZU_BENCH_C("mul(F, u32)", C, F::mul, x, x, uint32_t(*x.getUnit()));
	CYBOZU_BENCH_C("mul(F, F)", C, F::mul, x, x, x);
	CYBOZU_TEST_ASSERT(x != 0);
#endif
}

CYBOZU_TEST_AUTO(main)
{
	initPairing(BLS12_381);
	test<Fr>("Fr");
	test<Fp>("Fp");
}
