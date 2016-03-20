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

template<class Fp>
class FpDblT {
	typedef fp::Unit Unit;
	Unit v_[Fp::maxSize * 2];
public:
	static inline size_t getUnitSize() { return Fp::op_.N * 2; }
	void dump() const
	{
		const size_t n = getUnitSize();
		for (size_t i = 0; i < n; i++) {
			printf("%016llx ", (long long)v_[n - 1 - i]);
		}
		printf("\n");
	}
	// QQQ : does not check range of x strictly(use for debug)
	void setMpz(const mpz_class& x)
	{
		if (x < 0) throw cybozu::Exception("FpDblT:_setMpz:negative is not supported") << x;
		const size_t xn = Gmp::getUnitSize(x);
		const size_t N2 = getUnitSize();
		if (xn > N2) {
			throw cybozu::Exception("FpDblT:setMpz:too large") << x;
		}
		memcpy(v_, Gmp::getUnit(x), xn * sizeof(Unit));
		memset(v_ + xn, 0, (N2 - xn) * sizeof(Unit));
	}
	void getMpz(mpz_class& x) const
	{
		Gmp::setArray(x, v_, Fp::op_.N * 2);
	}
	static inline void add(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_add(z.v_, x.v_, y.v_); }
	static inline void sub(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_sub(z.v_, x.v_, y.v_); }
	static inline void addNC(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_addNC(z.v_, x.v_, y.v_); }
	static inline void subNC(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_subNC(z.v_, x.v_, y.v_); }
	/*
		mul(z, x, y) = mulPre(xy, x, y) + mod(z, xy)
	*/
	static inline void mulPre(FpDblT& xy, const Fp& x, const Fp& y) { Fp::op_.fpDbl_mulPre(xy.v_, x.v_, y.v_); }
	static inline void sqrPre(FpDblT& xx, const Fp& x) { Fp::op_.fpDbl_sqrPre(xx.v_, x.v_); }
	static inline void mod(Fp& z, const FpDblT& xy) { Fp::op_.fpDbl_mod(z.v_, xy.v_); }
};

/*
	beta = -1
	Fp2 = F[i] / (i^2 + 1)
	x = a + bi
*/
template<class Fp>
class Fp2T {
	typedef fp::Unit Unit;
	typedef FpDblT<Fp> FpDbl;
	static Fp xi_c_;
public:
	Fp a, b;
	Fp2T() { }
	Fp2T(int64_t a) : a(a), b(0) { }
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
	static inline void mul_xi(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_mul_xi(y.a.v_, x.a.v_); }
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
	static inline void init(int xi_c)
	{
		assert(Fp::maxSize <= 256);
		xi_c_ = xi_c;
		mcl::fp::Op& op = Fp::op_;
		op.fp2_add = fp2_addW;
		op.fp2_sub = fp2_subW;
		op.fp2_mul = op.isFastMod ? fp2_mulW : fp2_mulUseDblW;
		op.fp2_neg = fp2_negW;
		op.fp2_inv = fp2_invW;
		op.fp2_sqr = fp2_sqrW;
		op.fp2_mul_xi = fp2_mul_xiW;
	}
private:
	/*
		default Fp2T operator
		Fp2T = Fp[i]/(i^2 + 1)
	*/
	static inline void fp2_addW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		Fp *pz = reinterpret_cast<Fp*>(z);
		Fp::add(pz[0], px[0], py[0]);
		Fp::add(pz[1], px[1], py[1]);
	}
	static inline void fp2_subW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		Fp *pz = reinterpret_cast<Fp*>(z);
		Fp::sub(pz[0], px[0], py[0]);
		Fp::sub(pz[1], px[1], py[1]);
	}
	static inline void fp2_negW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		Fp::neg(py[0], px[0]);
		Fp::neg(py[1], px[1]);
	}
	/*
		x = a + bi, y = c + di, i^2 = -1
		z = xy = (a + bi)(c + di) = (ac - bd) + (ad + bc)i
		ad+bc = (a + b)(c + d) - ac - bd
		# mod = 3
	*/
	static inline void fp2_mulW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		const Fp& c = py[0];
		const Fp& d = py[1];
		Fp *pz = reinterpret_cast<Fp*>(z);
		Fp t1, t2, ac, bd;
		Fp::add(t1, a, b);
		Fp::add(t2, c, d);
		t1 *= t2; // (a + b)(c + d)
		Fp::mul(ac, a, c);
		Fp::mul(bd, b, d);
		Fp::sub(pz[0], ac, bd); // ac - bd
		Fp::sub(pz[1], t1, ac);
		pz[1] -= bd;
	}
	/*
		# mod = 2
		@note mod of NIST_P192 is fast
	*/
	static inline void fp2_mulUseDblW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		const Fp& c = py[0];
		const Fp& d = py[1];
		FpDbl d0, d1, d2;
		Fp s, t;
		Fp::addNC(s, a, b);
		Fp::addNC(t, c, d);
		FpDbl::mulPre(d0, s, t); // (a + b)(c + d)
		FpDbl::mulPre(d1, a, c);
		FpDbl::mulPre(d2, b, d);
		FpDbl::subNC(d0, d0, d1); // (a + b)(c + d) - ac
		FpDbl::subNC(d0, d0, d2); // (a + b)(c + d) - ac - bd
		Fp *pz = reinterpret_cast<Fp*>(z);
		FpDbl::mod(pz[1], d0);
		FpDbl::sub(d1, d1, d2); // ac - bd
		FpDbl::mod(pz[0], d1); // set z0
	}
	/*
		x = a + bi, i^2 = -1
		y = x^2 = (a + bi)^2 = (a^2 - b^2) + 2abi
		  = (a + b)(a - b) + 2abi
	*/
	static inline void fp2_sqrW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
#if 0
		Fp aa, bb, t;
		Fp::sqr(aa, a);
		Fp::sqr(bb, b);
		Fp::mul(t, a, b);
		Fp::sub(py[0], aa, bb); // a^2 - b^2
		Fp::add(py[1], t, t); // 2ab
#else
#if 1 // faster than using FpDbl
		Fp t1, t2, t3;
		Fp::add(t1, b, b); // 2b
		t1 *= a; // 2ab
		Fp::add(t2, a, b); // a + b
		Fp::sub(t3, a, b); // a - b
		Fp::mul(py[0], t2, t3); // (a + b)(a - b)
		py[1] = t1;
#else
		Fp t1, t2;
		FpDbl d1, d2;
		Fp::addNC(t1, b, b); // 2b
		FpDbl::mulPre(d2, t1, a); // 2ab
		Fp::addNC(t1, a, b); // a + b
		Fp::sub(t2, a, b); // a - b
		FpDbl::mulPre(d1, t1, t2); // (a + b)(a - b)
		FpDbl::mod(py[0], d1);
		FpDbl::mod(py[1], d2);
#endif
#endif
	}
	/*
		xi = xi_c + i
		x = a + bi
		y = (a + bi)xi = (a + bi)(xi_c + i)
		=(a * x_ic - b) + (a + b xi_c)i
	*/
	static inline void fp2_mul_xiW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		Fp t;
		Fp::mul(t, a, xi_c_);
		t -= b;
		Fp::mul(py[1], b, xi_c_);
		py[1] += a;
		py[0] = t;
	}
	/*
		x = a + bi
		1 / x = (a - bi) / (a^2 + b^2)
	*/
	static inline void fp2_invW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		Fp aa, bb;
		Fp::sqr(aa, a);
		Fp::sqr(bb, b);
		aa += bb;
		Fp::inv(aa, aa); // aa = 1 / (a^2 + b^2)
		py[0] *= aa;
		py[1] *= aa;
		Fp::neg(py[1], py[1]);
	}
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

template<class Fp> Fp Fp2T<Fp>::xi_c_;

/*
	Fp6T = Fp2[v] / (v^3 - xi)
	x = a + b v + c v^2
*/
template<class Fp>
struct Fp6T {
	typedef Fp2T<Fp> Fp2;
	Fp2 a, b, c;
	Fp6T() { }
	Fp6T(int64_t a) : a(a) , b(0) , c(0) { }
	Fp6T(const Fp2& a, const Fp2& b, const Fp2& c) : a(a) , b(b) , c(c) { }
	void clear()
	{
		a.clear();
		b.clear();
		c.clear();
	}
	Fp* get() { return a.get(); }
	const Fp* get() const { return a.get(); }
	Fp2* getFp2() { return &a; }
	const Fp2* getFp2() const { return &a; }
	bool isZero() const
	{
		return a.isZero() && b.isZero() && c.isZero();
	}
	bool operator==(const Fp6T& rhs) const
	{
		return a == rhs.a && b == rhs.b && c == rhs.c;
	}
	bool operator!=(const Fp6T& rhs) const { return !operator==(rhs); }
	void getStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		str = '[';
		str += a.getStr(base, withPrefix);
		str += ',';
		str += b.getStr(base, withPrefix);
		str += ',';
		str += c.getStr(base, withPrefix);
		str += ']';
	}
	void setStr(const std::string& str, int base = 0)
	{
		const size_t size = str.size();
		if (size >= 4 + 5 * 3 && str[0] == '[' && str[size - 1] == ']') { // '[' + <a> + ',' + <b> + ',' + <c> + ']'
			size_t pos = str.find(']', 1);
			if (pos != std::string::npos) {
				a.setStr(str.substr(1, pos - 1 + 1), base);
				if (str[pos + 1] == ',') {
					pos += 2;
					size_t pos2 = str.find(']', pos);
					if (pos2 != std::string::npos) {
						b.setStr(str.substr(pos, pos2 - pos + 1), base);
						if (str[pos2 + 1] == ',') {
							pos = pos2 + 2;
							pos2 = str.find(']', pos);
							if (pos2 != std::string::npos) {
								c.setStr(str.substr(pos, pos2 - pos + 1), base);
								return;
							}
						}
					}
				}
			}
		}
		throw cybozu::Exception("Fp6T:setStr:bad format") << str;
	}
	std::string getStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		getStr(str, base, withPrefix);
		return str;
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp6T& x)
	{
		return os << "[" << x.a << ",\n " << x.b << ",\n " << x.c << "]";
	}
	friend std::istream& operator>>(std::istream& is, Fp6T& x)
	{
		char c1, c2, c3, c4;
		is >> c1 >> x.a_ >> c2 >> x.b_ >> c3 >> x.c_ >> c4;
		if (c1 == '[' && c2 == ',' && c3 == ',' && c4 == ']') return is;
		throw std::ios_base::failure("bad Fp6T");
	}
	inline friend Fp6T operator+(const Fp6T& x, const Fp6T& y) { Fp6T z; add(z, x, y); return z; }
	inline friend Fp6T operator-(const Fp6T& x, const Fp6T& y) { Fp6T z; sub(z, x, y); return z; }
	inline friend Fp6T operator*(const Fp6T& x, const Fp6T& y) { Fp6T z; mul(z, x, y); return z; }
	Fp6T& operator+=(const Fp6T& x) { add(*this, *this, x); return *this; }
	Fp6T& operator-=(const Fp6T& x) { sub(*this, *this, x); return *this; }
	Fp6T& operator*=(const Fp6T& x) { mul(*this, *this, x); return *this; }
	Fp6T operator-() const { Fp6T x; neg(x, *this); return x; }
	static inline void add(Fp6T& z, const Fp6T& x, const Fp6T& y)
	{
		Fp2::add(z.a, x.a, y.a);
		Fp2::add(z.b, x.b, y.b);
		Fp2::add(z.c, x.c, y.c);
	}
	static inline void sub(Fp6T& z, const Fp6T& x, const Fp6T& y)
	{
		Fp2::sub(z.a, x.a, y.a);
		Fp2::sub(z.b, x.b, y.b);
		Fp2::sub(z.c, x.c, y.c);
	}
	static inline void neg(Fp6T& y, const Fp6T& x)
	{
		Fp2::neg(y.a, x.a);
		Fp2::neg(y.b, x.b);
		Fp2::neg(y.c, x.c);
	}
	/*
		x = a + bv + cv^2, v^3 = xi
		x^2 = (a^2 + 2bc xi) + (c^2 xi + 2ab)v + (b^2 + 2ac)v^2

		b^2 + 2ac = (a + c - b)^2 + 2bc - a^2 - c^2 + 2ab
	*/
	static inline void sqr(Fp6T& y, const Fp6T& x)
	{
		Fp2 t1, t2, t3;
		Fp2::mul(t1, x.a, x.b);
		t1 += t1; // 2ab
		Fp2::mul(t2, x.b, x.c);
		t2 += t2; // 2bc
		Fp2::sqr(t3, x.c); // c^2
		Fp2::add(y.c, x.a, x.c); // a + c, destroy y.c
		y.c -= x.b; // a - b + c
		Fp2::sqr(y.b, y.c); // (a + c - b)^2, destroy y.b
		y.b += t2; // (a + c - b)^2 + 2bc
		Fp2::mul_xi(t2, t2); // 2bc xi
		Fp2::sqr(y.a, x.a); // a^2, destroy y.a
		y.b -= y.a; // (a + c - b)^2 + 2bc - a^2
		y.a += t2; // a^2 + 2bc xi
		Fp2::sub(y.c, y.b, t3); // (a + c - b)^2 + 2bc - a^2 - c^2
		Fp2::mul_xi(y.b, t3); // c^2 xi
		y.b += t1; // c^2 xi + 2ab
		y.c += t1; // b^2 + 2ab
	}
	/*
		x = a + bv + cv^2, y = d + ev + fv^2, v^3 = xi
		xy = (ad + (bf + ce)xi) + (ae + bd + cf xi)v + (af + be + cd)v^2
		bf + ce = (b + c)(e + f) - be - cf
		ae + bd = (a + b)(e + d) - ad - be
		af + cd = (a + c)(d + f) - ad - cf
	*/
	static inline void mul(Fp6T& z, const Fp6T& x, const Fp6T& y)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		const Fp2& d = y.a;
		const Fp2& e = y.b;
		const Fp2& f = y.c;
		Fp2 ad, be, cf;
		Fp2::mul(ad, a, d);
		Fp2::mul(be, b, e);
		Fp2::mul(cf, c, f);
		Fp2 t1, t2, t3, t4;
		Fp2::add(t1, b, c);
		Fp2::add(t2, e, f);
		t1 *= t2; // (b + c)(e + f)
		t1 -= be;
		t1 -= cf;
		Fp2::mul_xi(t1, t1);
		Fp2::add(z.a, ad, t1);
		Fp2::add(t1, a, b);
		Fp2::add(t2, e, d);
		t1 *= t2; // (a + b)(e + d)
		t1 -= ad;
		t1 -= be;
		Fp2::mul_xi(t2, cf);
		Fp2::add(z.b, t1, t2);
		Fp2::add(t1, a, c);
		Fp2::add(t2, d, f);
		t1 *= t2; // (a + c)(d + f)
		t1 -= ad;
		t1 -= cf;
		Fp2::add(z.c, t1, be);
	}
};

/*
	Fp12T = Fp6[w] / (w^2 - v)
	x = a + b w
*/
template<class Fp>
struct Fp12T {
	typedef Fp2T<Fp> Fp2;
	typedef Fp6T<Fp> Fp6;
	Fp6 a, b;
	Fp12T() {}
	Fp12T(int64_t a) : a(a), b(0) {}
	Fp12T(const Fp6& a, const Fp6& b) : a(a), b(b) {}
	void clear()
	{
		a.clear();
		b.clear();
	}

	Fp* get() { return a.get(); }
	const Fp* get() const { return a.get(); }
	Fp2* getFp2() { return a.getFp2(); }
	const Fp2* getFp2() const { return a.getFp2(); }
	void set(const Fp2& v0, const Fp2& v1, const Fp2& v2, const Fp2& v3, const Fp2& v4, const Fp2& v5)
	{
		a.set(v0, v1, v2);
		b.set(v3, v4, v5);
	}

	bool isZero() const
	{
		return a.isZero() && b.isZero();
	}
	bool operator==(const Fp12T& rhs) const
	{
		return a == rhs.a && b == rhs.b;
	}
	bool operator!=(const Fp12T& rhs) const { return !operator==(rhs); }
	static inline void add(Fp12T& z, const Fp12T& x, const Fp12T& y)
	{
		Fp6::add(z.a, x.a, y.a);
		Fp6::add(z.b, x.b, y.b);
	}
	static inline void sub(Fp12T& z, const Fp12T& x, const Fp12T& y)
	{
		Fp6::sub(z.a, x.a, y.a);
		Fp6::sub(z.b, x.b, y.b);
	}
	static inline void neg(Fp12T& z, const Fp12T& x)
	{
		Fp6::neg(z.a, x.a);
		Fp6::neg(z.b, x.b);
	}
	void getStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		str = '[';
		str += a.getStr(base, withPrefix);
		str += ',';
		str += b.getStr(base, withPrefix);
		str += ']';
	}
	std::string getStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		getStr(str, base, withPrefix);
		return str;
	}
	friend inline std::ostream& operator<<(std::ostream& os, const Fp12T& self)
	{
		const std::ios_base::fmtflags f = os.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("Fp12T:operator<<:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 10;
		const bool showBase = (f & std::ios_base::showbase) != 0;
		return os << self.getStr(base, showBase);
	}
};

} // mcl

