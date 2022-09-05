#include <iostream>
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
	}

	void toMont(mpz_class& x) const { mul(x, x, RR_); }
	void fromMont(mpz_class& x) const { mul(x, x, 1); }

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

CYBOZU_TEST_AUTO(limit)
{
	std::cout << std::hex;
	const size_t N = 4;
	mpz_class p = (mpz_class(1) << (sizeof(Unit) * 8 * N)) - 1;
	Montgomery mont(p);
	mont.put();
}

