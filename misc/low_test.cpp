#include <stdio.h>
#include <stdint.h>

void dump(const char *msg, const uint32_t *x, size_t n)
{
	printf("%s", msg);
	for (size_t i = 0; i < n; i++) {
		printf("%08x", x[n - 1 - i]);
	}
	printf("\n");
}

#include <mcl/vint.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/util.hpp>

#include "../src/bint_impl.hpp"
#include "../src/low_func.hpp"
#include "../test/mont.hpp"

const int C = 10000;

template<class RG>
void setRand(uint32_t *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = rg.get32();
	}
}

template<size_t N>
void mulMontTest(const char *pStr)
{
	mcl::Vint vp;
	vp.setStr(pStr);
	Montgomery mont(vp);

	cybozu::XorShift rg;
	uint32_t x[N];
	uint32_t y[N];
	uint32_t z[N];
	uint32_t _p[N + 1];
	uint32_t *const p = _p + 1;
	vp.getArray(p, N);
	p[-1] = mont.rp_;

	for (size_t i = 0; i < 1000; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		// remove MSB
		x[N - 1] &= 0x7fffffff;
		y[N - 1] &= 0x7fffffff;
		mcl::Vint vx, vy, vz;
		vx.setArray(x, N);
		vy.setArray(y, N);
		mont.mul(vz, vx, vy);
		mcl::fp::mulMontT<N>(z, x, y, p);
		CYBOZU_TEST_EQUAL_ARRAY(z, vz.getUnit(), N);

		mont.mul(vz, vx, vx);
		mcl::fp::sqrMontT<N>(z, x, p);
		CYBOZU_TEST_EQUAL_ARRAY(z, vz.getUnit(), N);
	}
	CYBOZU_BENCH_C("mulMontT", C, mcl::fp::mulMontT<N>, x, x, y, p);
	CYBOZU_BENCH_C("sqrMontT", C, mcl::fp::sqrMontT<N>, x, x, p);
}

template<size_t N>
void modTest(const char *pStr)
{
	mcl::Vint vp;
	vp.setStr(pStr);
	Montgomery mont(vp);

	cybozu::XorShift rg;
	uint32_t xy[N * 2];
	uint32_t z[N];
	uint32_t _p[N + 1];
	uint32_t *const p = _p + 1;
	vp.getArray(p, N);
	p[-1] = mont.rp_;

	for (size_t i = 0; i < 1000; i++) {
		setRand(xy, N * 2, rg);
		// remove MSB
		xy[N * 2 - 1] &= 0x7fffffff;
		mcl::Vint vxy, vz;
		vxy.setArray(xy, N * 2);
		mont.mod(vz, vxy);
		mcl::fp::modRedT<N>(z, xy, p);
		CYBOZU_TEST_EQUAL_ARRAY(z, vz.getUnit(), N);
	}
	CYBOZU_BENCH_C("modT", C, mcl::fp::modRedT<N>, z, xy, p);
}

CYBOZU_TEST_AUTO(mont)
{
	const char *pBN254 = "0x2523648240000001ba344d80000000086121000000000013a700000000000013";
	puts("BN254");
	mulMontTest<8>(pBN254);
	modTest<8>(pBN254);

	const char *pBLS12_381 = "0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab";
	puts("BLS12");
	mulMontTest<12>(pBLS12_381);
	modTest<12>(pBLS12_381);
}

