#pragma once
/**
	@file
	@brief finite field extension class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp.hpp>

namespace mcl {

/*
	beta = -1
	Fp2 = F[u] / (u^2 + 1)
	x = a_ + b u
*/
template<class Fp>
class Fp2T {
public:
	Fp a, b;
	Fp2T() { }
	Fp2T(int x)
		: a(x), b(0)
	{
	}
	Fp2T(const Fp& a, const Fp& b) : a(a), b(b) { }
	Fp2T(int64_t a, int64_t b) : a(a), b(b) { }
	Fp2T(const std::string& a, const std::string& b, int base = 0) : a(a, base), b(b, base) {}
	Fp* get() { return &a; }
	const Fp* get() const { return &a; }
	void clear()
	{
		a.clear();
		b.clear();
	}
	static inline void add(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_add(z.a.v_, x.a.v_, y.a.v_); }
	static inline void sub(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_sub(z.a.v_, x.a.v_, y.a.v_); }
	static inline void mul(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_mul(z.a.v_, x.a.v_, y.a.v_); }
	static inline void inv(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_inv(y.a.v_, x.a.v_); }
	static inline void neg(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_neg(y.a.v_, x.a.v_); }
	static inline void sqr(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_sqr(y.a.v_, x.a.v_); }
	static inline void div(Fp2T& z, const Fp2T& x, const Fp2T& y)
	{
		Fp2T rev;
		inv(rev, y);
		mul(z, x, rev);
	}
	inline friend Fp2T operator+(const Fp2T& x, const Fp2T& y) { Fp2T z; add(z, x, y); return z; }
	inline friend Fp2T operator-(const Fp2T& x, const Fp2T& y) { Fp2T z; sub(z, x, y); return z; }
	inline friend Fp2T operator*(const Fp2T& x, const Fp2T& y) { Fp2T z; mul(z, x, y); return z; }
	inline friend Fp2T operator/(const Fp2T& x, const Fp2T& y) { Fp2T z; div(z, x, y); return z; }
	Fp2T& operator+=(const Fp2T& x) { add(*this, *this, x); return *this; }
	Fp2T& operator-=(const Fp2T& x) { sub(*this, *this, x); return *this; }
	Fp2T& operator*=(const Fp2T& x) { mul(*this, *this, x); return *this; }
	Fp2T& operator/=(const Fp2T& x) { div(*this, *this, x); return *this; }
	Fp2T operator-() const { Fp2T x; neg(x, *this); return x; }
	/*
		Fp2T = '[' + <a> + ',' + <b> + ']'
	*/
	void getStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		str = '[';
		str += a.getStr(base, withPrefix);
		str += ',';
		str += b.getStr(base, withPrefix);
		str += ']';
	}
	void setStr(const std::string& str, int base = 0)
	{
		const size_t size = str.size();
		const size_t pos = str.find(',');
		if (size >= 5 && str[0] == '[' && pos != std::string::npos && str[size - 1] == ']') {
			a.setStr(str.substr(1, pos - 1), base);
			b.setStr(str.substr(pos + 1, size - pos - 2), base);
			return;
		}
		throw cybozu::Exception("Fp2T:setStr:bad format") << str;
	}
	std::string getStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		getStr(str, base, withPrefix);
		return str;
	}
	friend inline std::ostream& operator<<(std::ostream& os, const Fp2T& self)
	{
		const std::ios_base::fmtflags f = os.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("Fp2T:operator<<:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 10;
		const bool showBase = (f & std::ios_base::showbase) != 0;
		return os << self.getStr(base, showBase);
	}
	friend inline std::istream& operator>>(std::istream& is, Fp2T& self)
	{
		const std::ios_base::fmtflags f = is.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator>>:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 0;
		std::string str;
		is >> str;
		self.setStr(str, base);
		return is;
	}
	bool isZero() const { return a.isZero() && b.isZero(); }
	bool operator==(const Fp2T& rhs) const { return a == rhs.a && b == rhs.b; }
	bool operator!=(const Fp2T& rhs) const { return !operator==(rhs); }
	void normalize() {} // dummy method
	template<class tag2, size_t maxBitSize2>
	static inline void power(Fp2T& z, const Fp2T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powerArray(z, x, b.p, b.n, false);
	}
	static inline void power(Fp2T& z, const Fp2T& x, int y)
	{
		const fp::Unit u = abs(y);
		powerArray(z, x, &u, 1, y < 0);
	}
	static inline void power(Fp2T& z, const Fp2T& x, const mpz_class& y)
	{
		powerArray(z, x, Gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0);
	}
private:
	static inline void powerArray(Fp2T& z, const Fp2T& x, const fp::Unit *y, size_t yn, bool isNegative)
	{
		Fp2T tmp;
		const Fp2T *px = &x;
		if (&z == &x) {
			tmp = x;
			px = &tmp;
		}
		z = 1;
		fp::powerGeneric(z, *px, y, yn, Fp2T::mul, Fp2T::sqr);
		if (isNegative) {
			Fp2T::inv(z, z);
		}
	}
};

} // mcl

