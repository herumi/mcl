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
#include "../src/low_funct.hpp"

#define MCL_USE_VINT
#define MCL_VINT_FIXED_BUFFER
#define MCL_SIZEOF_UNIT 4
#define MCL_MAX_BIT_SIZE 768
#include <mcl/vint.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/util.hpp>

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

struct Montgomery {
	mcl::Vint p_;
	mcl::Vint R_; // (1 << (pn_ * 64)) % p
	mcl::Vint RR_; // (R * R) % p
	uint32_t rp_; // rp * p = -1 mod M = 1 << 64
	size_t pn_;
	Montgomery() {}
	explicit Montgomery(const mcl::Vint& p)
	{
		p_ = p;
		rp_ = mcl::fp::getMontgomeryCoeff(p.getUnit()[0]);
		pn_ = p.getUnitSize();
		R_ = 1;
		R_ = (R_ << (pn_ * 64)) % p_;
		RR_ = (R_ * R_) % p_;
	}

	void toMont(mcl::Vint& x) const { mul(x, x, RR_); }
	void fromMont(mcl::Vint& x) const { mul(x, x, 1); }

	void mul(mcl::Vint& z, const mcl::Vint& x, const mcl::Vint& y) const
	{
		const size_t ySize = y.getUnitSize();
		mcl::Vint c = x * y.getUnit()[0];
		uint32_t q = c.getUnit()[0] * rp_;
		c += p_ * q;
		c >>= sizeof(uint32_t) * 8;
		for (size_t i = 1; i < pn_; i++) {
			if (i < ySize) {
				c += x * y.getUnit()[i];
			}
			uint32_t q = c.getUnit()[0] * rp_;
			c += p_ * q;
			c >>= sizeof(uint32_t) * 8;
		}
		if (c >= p_) {
			c -= p_;
		}
		z = c;
	}
};

template<size_t N>
void montTest(const char *pStr)
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
		mcl::montT<N>(z, x, y, p);
		CYBOZU_TEST_EQUAL_ARRAY(z, vz.getUnit(), N);
	}
}

CYBOZU_TEST_AUTO(mont)
{
	const char *pStr = "0x2523648240000001ba344d80000000086121000000000013a700000000000013";
	montTest<8>(pStr);
}
