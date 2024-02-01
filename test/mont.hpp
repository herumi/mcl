/*
	Montgomery class for test
*/
class Montgomery {
	typedef mcl::Unit Unit;
	std::vector<Unit> v_;
public:
	mpz_class mp;
	mpz_class mR; // (1 << (N * 64)) % p
	mpz_class mR2; // (R * R) % p
	Unit rp; // rp * p = -1 mod M = 1 << 64
	size_t N;
	const Unit *p;
	bool isFullBit;
	Montgomery() {}
	static Unit getLow(const mpz_class& x)
	{
		if (x == 0) return 0;
		return mcl::gmp::getUnit(x, 0);
	}
	void put() const
	{
		std::cout << std::hex;
		std::cout << "p=0x" << mp << std::endl;
		std::cout << "R=0x" << mR << std::endl;
		std::cout << "R2=0x" << mR2 << std::endl;
		std::cout << "rp=0x" << rp << std::endl;
	}
	explicit Montgomery(const mpz_class& _p)
	{
		mp = _p;
		N = mcl::gmp::getUnitSize(_p);
		mR = 1;
		mR = (mR << (N * sizeof(Unit) * 8)) % mp;
		mR2 = (mR * mR) % mp;
		v_.resize(N + 1);
		Unit *base = &v_[1];
		mcl::gmp::getArray(base, N, _p);
		base[-1] = rp = mcl::bint::getMontgomeryCoeff(base[0]);
		p = base;
		isFullBit = p[N - 1] >> (sizeof(Unit) * 8 - 1);
	}

	void toMont(mpz_class& x) const { mul(x, x, mR2); }
	void fromMont(mpz_class& x) const { mul(x, x, 1); }
	mpz_class toMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, mR2);
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
		Unit q = mcl::gmp::getUnit(c, 0) * rp;
		c += mp * q;
		c >>= sizeof(Unit) * 8;
		for (size_t i = 1; i < N; i++) {
			if (i < ySize) {
				c += x * mcl::gmp::getUnit(y, i);
			}
			Unit q = mcl::gmp::getUnit(c, 0) * rp;
			c += mp * q;
			c >>= sizeof(Unit) * 8;
		}
		if (c >= mp) {
			c -= mp;
		}
		z = c;
#else
		mod(z, x * y);
#endif
	}
	void mod(mpz_class& z, const mpz_class& xy) const
	{
		z = xy;
		for (size_t i = 0; i < N; i++) {
			Unit q = getLow(z) * rp;
			mpz_class t;
			mcl::gmp::set(t, q);
			z += mp * t;
			z >>= sizeof(Unit) * 8;
		}
		if (z >= mp) {
			z -= mp;
		}
	}
};

