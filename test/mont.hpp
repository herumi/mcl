/*
	Montgomery class for test
*/
struct Montgomery {
	typedef mcl::Unit Unit;
	mpz_class p_;
	mpz_class R_; // (1 << (pn_ * 64)) % p
	mpz_class RR_; // (R * R) % p
	Unit rp_; // rp * p = -1 mod M = 1 << 64
	size_t pn_;
	std::vector<Unit> v_;
	const Unit *rpp_;
	bool isFullBit_;
	Montgomery() {}
	static Unit getLow(const mpz_class& x)
	{
		if (x == 0) return 0;
		return mcl::gmp::getUnit(x, 0);
	}
	void put() const
	{
		std::cout << std::hex;
		std::cout << "p=0x" << p_ << std::endl;
		std::cout << "R=0x" << R_ << std::endl;
		std::cout << "RR=0x" << RR_ << std::endl;
		std::cout << "rp=0x" << rp_ << std::endl;
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

	void toMont(mpz_class& x) const { mul(x, x, RR_); }
	void fromMont(mpz_class& x) const { mul(x, x, 1); }
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
#if 0
		const size_t ySize = mcl::gmp::getUnitSize(y);
		mpz_class c = x * mcl::gmp::getUnit(y, 0);
		Unit q = mcl::gmp::getUnit(c, 0) * rp_;
		c += p_ * q;
		c >>= sizeof(Unit) * 8;
		for (size_t i = 1; i < pn_; i++) {
			if (i < ySize) {
				c += x * mcl::gmp::getUnit(y, i);
			}
			Unit q = mcl::gmp::getUnit(c, 0) * rp_;
			c += p_ * q;
			c >>= sizeof(Unit) * 8;
		}
		if (c >= p_) {
			c -= p_;
		}
		z = c;
#else
		mod(z, x * y);
#endif
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

