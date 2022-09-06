#include <iostream>
#include <vector>
#include <cybozu/test.hpp>
#include "../src/low_func.hpp"

CYBOZU_TEST_AUTO(cpu)
{
	mcl::bint::initBint();
}

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

struct Montgomery {
	mpz_class p_;
	mpz_class R_; // (1 << (pn_ * 64)) % p
	mpz_class RR_; // (R * R) % p
	Unit rp_; // rp * p = -1 mod M = 1 << 64
	size_t pn_;
	std::vector<Unit> v_;
	const Unit *rpp_;
	bool isFullBit_;
	Montgomery() {}
	void put() const
	{
		PUT(p_);
		PUT(R_);
		PUT(RR_);
		PUT(rp_);
	}
	static Unit getLow(const mpz_class& x)
	{
		if (x == 0) return 0;
		return mcl::gmp::getUnit(x, 0);
	}
	explicit Montgomery(const mpz_class& p)
	{
		p_ = p;
		rp_ = mcl::fp::getMontgomeryCoeff(getLow(p));
		pn_ = mcl::gmp::getUnitSize(p);
		R_ = 1;
		R_ = (R_ << (pn_ * sizeof(Unit) * 8)) % p_;
		RR_ = (R_ * R_) % p_;
		v_.resize(pn_ + 1);
		mcl::gmp::getArray(&v_[1], pn_, p);
		v_[0] = rp_;
		rpp_ = v_.data() + 1;
		isFullBit_ = v_[pn_ - 1] >> (sizeof(Unit) * 8 - 1);
	}

	mpz_class toMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, RR_);
		return y;
	}
	mpz_class fromMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, 1);
		return y;
	}
	void mul(mpz_class& z, const mpz_class& x, const mpz_class& y) const
	{
		z = x * y;
		for (size_t i = 0; i < pn_; i++) {
			Unit q = getLow(z) * rp_;
			z += p_ * q;
			z >>= sizeof(Unit) * 8;
		}
		if (z >= p_) {
			z -= p_;
		}
	}
	void mod(mpz_class& z, const mpz_class& xy) const
	{
		z = xy;
		for (size_t i = 0; i < pn_; i++) {
			Unit q = getLow(z) * rp_;
			mpz_class t;
			mcl::gmp::set(t, q);
			z += p_ * t;
			z >>= sizeof(Unit) * 8;
		}
		if (z >= p_) {
			z -= p_;
		}
	}
};

template<size_t N>
void testEdgeOne(const Montgomery& mont, const mpz_class& x1, const mpz_class& x2)
{
	Unit x1Buf[N] = {}, x2Buf[N] = {};
	Unit z1Buf[N] = {}, z2Buf[N] = {};
	mpz_class xy = (x1 * x2) % mont.p_;
	mpz_class mx1 = mont.toMont(x1);
	mpz_class mx2 = mont.toMont(x2);
	mcl::gmp::getArray(x1Buf, N, mx1);
	mcl::gmp::getArray(x2Buf, N, mx2);
	if (mont.isFullBit_) {
		mcl::fp::mulMontT<N>(z1Buf, x1Buf, x2Buf, mont.rpp_);
	} else {
		mcl::fp::mulMontNFT<N>(z1Buf, x1Buf, x2Buf, mont.rpp_);
		Unit z3Buf[N] = {};
		mcl::fp::mulMontT<N>(z3Buf, x1Buf, x2Buf, mont.rpp_);
		CYBOZU_TEST_EQUAL_ARRAY(z1Buf, z3Buf, N);
	}
	mpz_class z1, z2;
	mcl::gmp::setArray(z1, z1Buf, N);
	mont.mul(z2, mx1, mx2);
	CYBOZU_TEST_EQUAL(z1, z2);
	mont.fromMont(z1);
	CYBOZU_TEST_EQUAL(z1, xy);
	mont.toMont(xy);
	Unit xyBuf[N * 2] = {};
	mcl::gmp::getArray(xyBuf, N * 2, xy);
	if (mont.isFullBit_) {
		mcl::fp::modRedT<N>(z2Buf, xyBuf, mont.rpp_);
	} else {
		mcl::fp::modRedNFT<N>(z2Buf, xyBuf, mont.rpp_);
		Unit z3Buf[N] = {};
		mcl::fp::modRedT<N>(z3Buf, xyBuf, mont.rpp_);
		CYBOZU_TEST_EQUAL_ARRAY(z2Buf, z3Buf, N);
	}
	CYBOZU_TEST_EQUAL_ARRAY(z1Buf, z2Buf, N);
}

template<size_t N>
void testEdge(const mpz_class& p)
{
	Montgomery mont(p);
	CYBOZU_TEST_EQUAL(mont.pn_, N);
	mpz_class tbl[] = { 0, 1, 2, 0x1234568, mont.R_, mont.p_ - mont.R_, p-1, p-2, p-3 };
	const size_t n = CYBOZU_NUM_OF_ARRAY(tbl);
	for (size_t i = 0; i < n; i++) {
		for (size_t j = i; j < n; j++) {
			testEdgeOne<N>(mont, tbl[i], tbl[j]);
		}
	}
}

CYBOZU_TEST_AUTO(limit)
{
	std::cout << std::hex;
	const char *tbl4[] = {
#if 0
		"0x0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
#endif
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff", // not prime
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		printf("p=%s\n", tbl4[i]);
		mpz_class p;
		p.setStr(tbl4[i], 16);
		testEdge<4 * (8 / sizeof(Unit))>(p);
	}
}

