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
	Montgomery() {}
	void put() const
	{
		PUT(p_);
		PUT(R_);
		PUT(RR_);
		PUT(rp_);
	}
	explicit Montgomery(const mpz_class& p)
	{
		p_ = p;
		rp_ = mcl::fp::getMontgomeryCoeff(mcl::gmp::getUnit(p, 0));
		pn_ = mcl::gmp::getUnitSize(p);
		R_ = 1;
		R_ = (R_ << (pn_ * 64)) % p_;
		RR_ = (R_ * R_) % p_;
		v_.resize(pn_ + 1);
		mcl::gmp::getArray(&v_[1], pn_, p);
		v_[0] = rp_;
		rpp_ = v_.data() + 1;
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
			Unit q = mcl::gmp::getUnit(z, 0) * rp_;
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
			Unit q = mcl::gmp::getUnit(z, 0) * rp_;
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
	Unit x1Buf[N], x2Buf[N], z1Buf[N], z2Buf[N], xyBuf[N * 2];
	mpz_class xy = (x1 * x2) % mont.p_;
	mpz_class mx1 = mont.toMont(x1);
	mpz_class mx2 = mont.toMont(x2);
	mcl::gmp::getArray(x1Buf, N, mx1);
	mcl::gmp::getArray(x2Buf, N, mx2);
	mcl::fp::mulMontT<N>(z1Buf, x1Buf, x2Buf, mont.rpp_);
	mpz_class z1, z2;
	mcl::gmp::setArray(z1, z1Buf, N);
	mont.mul(z2, mx1, mx2);
	CYBOZU_TEST_EQUAL(z1, z2);
	mont.fromMont(z1);
	CYBOZU_TEST_EQUAL(z1, xy);
	mont.toMont(xy);
	mcl::gmp::getArray(xyBuf, N * 2, xy);
	mcl::fp::modRedT<N>(z2Buf, xyBuf, mont.rpp_);
	CYBOZU_TEST_EQUAL_ARRAY(z1Buf, z2Buf, N);
}

template<size_t N>
void testEdge(const mpz_class& p)
{
	Montgomery mont(p);
	CYBOZU_TEST_EQUAL(mont.pn_, N);
	mpz_class tbl[] = { 0, 1, 2, 0x1234568, p-1, p-2, p-3 };
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
	const size_t N = 4;
	mpz_class p = (mpz_class(1) << (sizeof(Unit) * 8 * N)) - 1;
	testEdge<N>(p);
}

