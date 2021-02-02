#include <stdio.h>
#include "../src/low_funct.hpp"

#define MCL_USE_VINT
#define MCL_VINT_FIXED_BUFFER
#define MCL_SIZEOF_UNIT 4
#define MCL_MAX_BIT_SIZE 768
#include <mcl/vint.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

template<class RG>
void setRand(uint32_t *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = rg.get32();
	}
}

/*
g++ -Ofast -DNDEBUG -Wall -Wextra -m32 -I ./include/ misc/low_test.cpp
Core i7-8700
         mulT  karatsuba
N =  6, 182clk   225clk
N =  8, 300clk   350clk
N = 12, 594clk   730clk
*/
template<size_t N>
void mulTest()
{
	printf("N=%zd (%zdbit)\n", N, N * 32);
	cybozu::XorShift rg;
	uint32_t x[N];
	uint32_t y[N];
	uint32_t z[N * 2];
	for (size_t i = 0; i < 1000; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		// remove MSB
		x[N - 1] &= 0x7fffffff;
		y[N - 1] &= 0x7fffffff;
		mcl::Vint vx, vy;
		vx.setArray(x, N);
		vy.setArray(y, N);
		vx *= vy;
		mcl::mulT<N>(z, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, vx.getUnit(), N * 2);
		memset(z, 0, sizeof(z));
		mcl::karatsubaT<N>(z, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, vx.getUnit(), N * 2);
	}
	CYBOZU_BENCH_C("mulT", 10000, mcl::mulT<N>, z, x, y);
	CYBOZU_BENCH_C("kara", 10000, mcl::karatsubaT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(mulT)
{
	mulTest<8>();
	mulTest<12>();
}
