#include <iostream>
#include <vector>
#include <cybozu/test.hpp>
#include "../src/low_func.hpp"
#include <cybozu/benchmark.hpp>

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

using namespace mcl::bint;
typedef mcl::Unit Unit;

template<class RG>
void setRand(Unit *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = (Unit)rg.get64();
	}
}

#include "mont.hpp"

template<size_t N>
void testEdgeOne(const Montgomery& mont, const mpz_class& x1, const mpz_class& x2)
{
	mpz_class mx1 = mont.toMont(x1);
	mpz_class mx2 = mont.toMont(x2);
	mpz_class mz1;
	mont.mul(mz1, mx1, mx2);

	Unit x1Buf[N] = {};
	Unit x2Buf[N] = {};
	mcl::gmp::getArray(x1Buf, N, mx1);
	mcl::gmp::getArray(x2Buf, N, mx2);
	Unit z1Buf[N] = {};
	if (mont.isFullBit) {
		mcl::fp::mulMontT<N>(z1Buf, x1Buf, x2Buf, mont.p);
	} else {
		mcl::fp::mulMontNFT<N>(z1Buf, x1Buf, x2Buf, mont.p);
		Unit z2Buf[N] = {};
		mcl::fp::mulMontT<N>(z2Buf, x1Buf, x2Buf, mont.p);
		CYBOZU_TEST_EQUAL_ARRAY(z1Buf, z2Buf, N);
	}
	mpz_class mz2;
	mcl::gmp::setArray(mz2, z1Buf, N);
	CYBOZU_TEST_EQUAL(mz1, mz2);
	Unit xyBuf[N * 2] = {};
	mcl::gmp::getArray(xyBuf, N * 2, mx1 * mx2);
	if (mont.isFullBit) {
		mcl::fp::modRedT<N>(z1Buf, xyBuf, mont.p);
	} else {
		mcl::fp::modRedNFT<N>(z1Buf, xyBuf, mont.p);
		Unit z2Buf[N] = {};
		mcl::fp::modRedT<N>(z2Buf, xyBuf, mont.p);
		CYBOZU_TEST_EQUAL_ARRAY(z1Buf, z2Buf, N);
	}
	mz2 = 0;
	mcl::gmp::setArray(mz2, z1Buf, N);
	CYBOZU_TEST_EQUAL(mz1, mz2);
}

template<size_t N>
void testEdge(const mpz_class& p)
{
	Montgomery mont(p);
	CYBOZU_TEST_EQUAL(mont.N, N);
	mpz_class tbl[] = { 0, 1, 2, 0x1234568, mont.mR, mont.mp - mont.mR, p-1, p-2, p-3 };
	const size_t n = CYBOZU_NUM_OF_ARRAY(tbl);
	for (size_t i = 1; i < n; i++) {
		for (size_t j = i; j < n; j++) {
			testEdgeOne<N>(mont, tbl[i], tbl[j]);
		}
	}
}

CYBOZU_TEST_AUTO(limit)
{
	const size_t adj = 8 / sizeof(Unit);
	std::cout << std::hex;
	const char *tbl4[] = {
		"0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"2523648240000001ba344d80000000086121000000000013a700000000000013",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001", // BLS12-381 r
		"7523648240000001ba344d80000000086121000000000013a700000000000017",
		"800000000000000000000000000000000000000000000000000000000000005f",
		"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
		// not primes
		"ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		printf("p=%s\n", tbl4[i]);
		mpz_class p;
		mcl::gmp::setStr(p, tbl4[i], 16);
		testEdge<4 * adj>(p);
	}
	const char *tbl6[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab", // BLS12-381 p
		"240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d", // BN381 r
		"240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013", // BN381 p
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		printf("p=%s\n", tbl6[i]);
		mpz_class p;
		mcl::gmp::setStr(p, tbl6[i], 16);
		testEdge<6 * adj>(p);
	}
}

