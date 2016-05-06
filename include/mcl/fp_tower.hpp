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
	static size_t getUnitSize() { return Fp::op_.N * 2; }
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
		const size_t xn = gmp::getUnitSize(x);
		const size_t N2 = getUnitSize();
		if (xn > N2) {
			throw cybozu::Exception("FpDblT:setMpz:too large") << x;
		}
		memcpy(v_, gmp::getUnit(x), xn * sizeof(Unit));
		memset(v_ + xn, 0, (N2 - xn) * sizeof(Unit));
	}
	void getMpz(mpz_class& x) const
	{
		gmp::setArray(x, v_, Fp::op_.N * 2);
	}
	static void add(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_add(z.v_, x.v_, y.v_); }
	static void sub(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_sub(z.v_, x.v_, y.v_); }
	static void addNC(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_addNC(z.v_, x.v_, y.v_); }
	static void subNC(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_subNC(z.v_, x.v_, y.v_); }
	/*
		mul(z, x, y) = mulPre(xy, x, y) + mod(z, xy)
	*/
	static void mulPre(FpDblT& xy, const Fp& x, const Fp& y) { Fp::op_.fpDbl_mulPre(xy.v_, x.v_, y.v_); }
	static void sqrPre(FpDblT& xx, const Fp& x) { Fp::op_.fpDbl_sqrPre(xx.v_, x.v_); }
	static void mod(Fp& z, const FpDblT& xy) { Fp::op_.fpDbl_mod(z.v_, xy.v_); }
};

/*
	beta = -1
	Fp2 = F[i] / (i^2 + 1)
	x = a + bi
*/
template<class Fp>
class Fp2T : public fp::Operator<Fp2T<Fp> > {
	typedef fp::Unit Unit;
	typedef FpDblT<Fp> FpDbl;
	static Fp xi_a_;
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
	static void add(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_add(z.a.v_, x.a.v_, y.a.v_); }
	static void sub(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_sub(z.a.v_, x.a.v_, y.a.v_); }
	static void mul(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_mul(z.a.v_, x.a.v_, y.a.v_); }
	static void inv(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_inv(y.a.v_, x.a.v_); }
	static void neg(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_neg(y.a.v_, x.a.v_); }
	static void sqr(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_sqr(y.a.v_, x.a.v_); }
	static void mul_xi(Fp2T& y, const Fp2T& x) { Fp::op_.fp2_mul_xi(y.a.v_, x.a.v_); }
	static void divBy2(Fp2T& y, const Fp2T& x)
	{
		Fp::divBy2(y.a, x.a);
		Fp::divBy2(y.b, x.b);
	}
	/*
		Fp2T = <a> + ' ' + <b>
	*/
	friend std::ostream& operator<<(std::ostream& os, const Fp2T& self)
	{
		return os << self.a << ' ' << self.b;
	}
	friend std::istream& operator>>(std::istream& is, Fp2T& self)
	{
		return is >> self.a >> self.b;
	}
	std::string getStr(int base = 10, bool withPrefix = false)
	{
		return a.getStr(base, withPrefix) + ' ' + b.getStr(base, withPrefix);
	}
	bool isZero() const { return a.isZero() && b.isZero(); }
	bool isOne() const { return a.isOne() && b.isZero(); }
	bool operator==(const Fp2T& rhs) const { return a == rhs.a && b == rhs.b; }
	bool operator!=(const Fp2T& rhs) const { return !operator==(rhs); }
	void normalize() {} // dummy method
	/*
		return true is a is odd (do not consider b)
		this function is for only compressed reprezentation of EC
		isOdd() is not good naming. QQQ
	*/
	bool isOdd() const { return a.isOdd(); }
	static const Fp& getXi_a() { return xi_a_; }
	static void init(uint32_t xi_a)
	{
		assert(Fp::maxSize <= 256);
		xi_a_ = xi_a;
		mcl::fp::Op& op = Fp::op_;
		op.fp2_add = fp2_addW;
		op.fp2_sub = fp2_subW;
		op.fp2_mul = op.isFastMod ? fp2_mulW : fp2_mulUseDblW;
		op.fp2_neg = fp2_negW;
		op.fp2_inv = fp2_invW;
		op.fp2_sqr = fp2_sqrW;
		if (xi_a == 1) {
			op.fp2_mul_xi = fp2_mul_xi_1_1i;
		} else {
			op.fp2_mul_xi = fp2_mul_xiW;
		}
	}
private:
	/*
		default Fp2T operator
		Fp2T = Fp[i]/(i^2 + 1)
	*/
	static void fp2_addW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		Fp *pz = reinterpret_cast<Fp*>(z);
		Fp::add(pz[0], px[0], py[0]);
		Fp::add(pz[1], px[1], py[1]);
	}
	static void fp2_subW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		Fp *pz = reinterpret_cast<Fp*>(z);
		Fp::sub(pz[0], px[0], py[0]);
		Fp::sub(pz[1], px[1], py[1]);
	}
	static void fp2_negW(Unit *y, const Unit *x)
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
		# of mod = 3
	*/
	static void fp2_mulW(Unit *z, const Unit *x, const Unit *y)
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
		# of mod = 2
		@note mod of NIST_P192 is fast
	*/
	static void fp2_mulUseDblW(Unit *z, const Unit *x, const Unit *y)
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
		y = x^2 = (a + bi)^2 = (a + b)(a - b) + 2abi
	*/
	static void fp2_sqrW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
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
	}
	/*
		xi = xi_a + i
		x = a + bi
		y = (a + bi)xi = (a + bi)(xi_a + i)
		=(a * x_ia - b) + (a + b xi_a)i
	*/
	static void fp2_mul_xiW(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		Fp t;
		Fp::mul(t, a, xi_a_);
		t -= b;
		Fp::mul(py[1], b, xi_a_);
		py[1] += a;
		py[0] = t;
	}
	/*
		xi = 1 + i ; xi_a = 1
		y = (a + bi)xi = (a - b) + (a + b)i
	*/
	static void fp2_mul_xi_1_1i(Unit *y, const Unit *x)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		Fp *py = reinterpret_cast<Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		Fp t;
		Fp::add(t, a, b);
		Fp::sub(py[0], a, b);
		py[1] = t;
	}
	/*
		x = a + bi
		1 / x = (a - bi) / (a^2 + b^2)
	*/
	static void fp2_invW(Unit *y, const Unit *x)
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
		Fp::mul(py[0], a, aa);
		Fp::mul(py[1], b, aa);
		Fp::neg(py[1], py[1]);
	}
	struct Dbl;
};

template<class Fp>
struct Fp2T<Fp>::Dbl {
	typedef fp::Unit Unit;
	typedef typename Fp::Dbl FpDbl;
	FpDbl a, b;
	static void add(Dbl& z, const Dbl& x, const Dbl& y)
	{
		FpDbl::add(z.a, x.a, y.a);
		FpDbl::add(z.b, x.b, y.b);
	}
	static void addNC(Dbl& z, const Dbl& x, const Dbl& y)
	{
		FpDbl::addNC(z.a, x.a, y.a);
		FpDbl::addNC(z.b, x.b, y.b);
	}
	static void sub(Dbl& z, const Dbl& x, const Dbl& y)
	{
		FpDbl::sub(z.a, x.a, y.a);
		FpDbl::sub(z.b, x.b, y.b);
	}
	static void subNC(Dbl& z, const Dbl& x, const Dbl& y)
	{
		FpDbl::subNC(z.a, x.a, y.a);
		FpDbl::subNC(z.b, x.b, y.b);
	}
	static void neg(Dbl& y, const Dbl& x)
	{
		FpDbl::neg(y.a, x.a);
		FpDbl::neg(y.b, x.b);
	}
	static void sqr(Dbl& y, const Fp2T& x)
	{
		Fp t1, t2;
		Fp::addNC(t1, x.b, x.b); // 2b
		FpDbl::mulPre(y.b, t1, x.a); // 2ab
		Fp::addNC(t1, x.a, x.b); // a + b
		Fp::sub(t2, x.a, x.b); // a - b
		FpDbl::mulPre(y.a, t1, t2); // (a + b)(a - b)
	}
	static void mod(Fp2T& y, const Dbl& x)
	{
		FpDbl::mod(y.a, x.a);
		FpDbl::mod(y.b, x.b);
	}
};

template<class Fp> Fp Fp2T<Fp>::xi_a_;

/*
	Fp6T = Fp2[v] / (v^3 - xi)
	x = a + b v + c v^2
*/
template<class Fp>
struct Fp6T : public fp::Operator<Fp6T<Fp> > {
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
	friend std::ostream& operator<<(std::ostream& os, const Fp6T& x)
	{
		return os << x.a << ' ' << x.b << ' ' << x.c;
	}
	friend std::istream& operator>>(std::istream& is, Fp6T& x)
	{
		return is >> x.a >> x.b >> x.c;
	}
	static void add(Fp6T& z, const Fp6T& x, const Fp6T& y)
	{
		Fp2::add(z.a, x.a, y.a);
		Fp2::add(z.b, x.b, y.b);
		Fp2::add(z.c, x.c, y.c);
	}
	static void sub(Fp6T& z, const Fp6T& x, const Fp6T& y)
	{
		Fp2::sub(z.a, x.a, y.a);
		Fp2::sub(z.b, x.b, y.b);
		Fp2::sub(z.c, x.c, y.c);
	}
	static void neg(Fp6T& y, const Fp6T& x)
	{
		Fp2::neg(y.a, x.a);
		Fp2::neg(y.b, x.b);
		Fp2::neg(y.c, x.c);
	}
	/*
		x = a + bv + cv^2, v^3 = xi
		x^2 = (a^2 + 2bc xi) + (c^2 xi + 2ab)v + (b^2 + 2ac)v^2

		b^2 + 2ac = (a + b + c)^2 - a^2 - 2bc - c^2 - 2ab
	*/
	static void sqr(Fp6T& y, const Fp6T& x)
	{
		Fp2 t1, t2, t3;
		Fp2::mul(t1, x.a, x.b);
		t1 += t1; // 2ab
		Fp2::mul(t2, x.b, x.c);
		t2 += t2; // 2bc
		Fp2::sqr(t3, x.c); // c^2
		Fp2::add(y.c, x.a, x.c); // a + c, destroy y.c
		y.c += x.b; // a + b + c
		Fp2::sqr(y.b, y.c); // (a + b + c)^2, destroy y.b
		y.b -= t2; // (a + b + c)^2 - 2bc
		Fp2::mul_xi(t2, t2); // 2bc xi
		Fp2::sqr(y.a, x.a); // a^2, destroy y.a
		y.b -= y.a; // (a + b + c)^2 - 2bc - a^2
		y.a += t2; // a^2 + 2bc xi
		Fp2::sub(y.c, y.b, t3); // (a + b + c)^2 - 2bc - a^2 - c^2
		Fp2::mul_xi(y.b, t3); // c^2 xi
		y.b += t1; // c^2 xi + 2ab
		y.c -= t1; // b^2 + 2ac
	}
	/*
		x = a + bv + cv^2, y = d + ev + fv^2, v^3 = xi
		xy = (ad + (bf + ce)xi) + ((ae + bd) + cf xi)v + ((af + cd) + be)v^2
		bf + ce = (b + c)(e + f) - be - cf
		ae + bd = (a + b)(e + d) - ad - be
		af + cd = (a + c)(d + f) - ad - cf
	*/
	static void mul(Fp6T& z, const Fp6T& x, const Fp6T& y)
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
		t1 *= t2;
		t1 -= be;
		t1 -= cf;
		Fp2::mul_xi(t1, t1);

		Fp2::add(t2, a, b);
		Fp2::add(t3, e, d);
		t2 *= t3;
		t2 -= ad;
		t2 -= be;

		Fp2::add(t3, a, c);
		Fp2::add(t4, d, f);
		t3 *= t4;
		t3 -= ad;
		t3 -= cf;

		Fp2::add(z.a, ad, t1);
		Fp2::mul_xi(z.b, cf);
		z.b += t2;
		Fp2::add(z.c, t3, be);
	}
	/*
		x = a + bv + cv^2, v^3 = xi
		y = 1/x = p/q where
		p = (a^2 - bc xi) + (c^2 xi - ab)v + (b^2 - ac)v^2
		q = c^3 xi^2 + b(b^2 - 3ac)xi + a^3
		  = (a^2 - bc xi)a + ((c^2 xi - ab)c + (b^2 - ac)b) xi
	*/
	static void inv(Fp6T& y, const Fp6T& x)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		Fp2 aa, bb, cc, ab, bc, ac;
		Fp2::sqr(aa, a);
		Fp2::sqr(bb, b);
		Fp2::sqr(cc, c);
		Fp2::mul(ab, a, b);
		Fp2::mul(bc, b, c);
		Fp2::mul(ac, c, a);

		Fp6T p;
		Fp2::mul_xi(p.a, bc);
		Fp2::sub(p.a, aa, p.a); // a^2 - bc xi
		Fp2::mul_xi(p.b, cc);
		p.b -= ab; // c^2 xi - ab
		Fp2::sub(p.c, bb, ac); // b^2 - ac
		Fp2 q, t;
		Fp2::mul(q, p.b, c);
		Fp2::mul(t, p.c, b);
		q += t;
		Fp2::mul_xi(q, q);
		Fp2::mul(t, p.a, a);
		q += t;
		Fp2::inv(q, q);

		Fp2::mul(y.a, p.a, q);
		Fp2::mul(y.b, p.b, q);
		Fp2::mul(y.c, p.c, q);
	}
	void normalize() {} // dummy
};

/*
	Fp12T = Fp6[w] / (w^2 - v)
	x = a + b w
*/
template<class Fp>
struct Fp12T : public fp::Operator<Fp12T<Fp> > {
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
	static void add(Fp12T& z, const Fp12T& x, const Fp12T& y)
	{
		Fp6::add(z.a, x.a, y.a);
		Fp6::add(z.b, x.b, y.b);
	}
	static void sub(Fp12T& z, const Fp12T& x, const Fp12T& y)
	{
		Fp6::sub(z.a, x.a, y.a);
		Fp6::sub(z.b, x.b, y.b);
	}
	static void neg(Fp12T& z, const Fp12T& x)
	{
		Fp6::neg(z.a, x.a);
		Fp6::neg(z.b, x.b);
	}
	/*
		z = x v + y
		in Fp6 : (a + bv + cv^2)v = cv^3 + av + bv^2 = cxi + av + bv^2
	*/
	static void mulVadd(Fp6& z, const Fp6& x, const Fp6& y)
	{
		Fp2 t;
		Fp2::mul_xi(t, x.c);
		Fp2::add(z.c, x.b, y.c);
		Fp2::add(z.b, x.a, y.b);
		Fp2::add(z.a, t, y.a);
	}
	/*
		x = a + bw, y = c + dw, w^2 = v
		z = xy = (a + bw)(c + dw) = (ac + bdv) + (ad + bc)w
		ad+bc = (a + b)(c + d) - ac - bd

		in Fp6 : (a + bv + cv^2)v = cv^3 + av + bv^2 = cxi + av + bv^2
	*/
	static void mul(Fp12T& z, const Fp12T& x, const Fp12T& y)
	{
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		const Fp6& c = y.a;
		const Fp6& d = y.b;
		Fp6 t1, t2, ac, bd;
		Fp6::add(t1, a, b);
		Fp6::add(t2, c, d);
		t1 *= t2; // (a + b)(c + d)
		Fp6::mul(ac, a, c);
		Fp6::mul(bd, b, d);
		mulVadd(z.a, bd, ac);
		t1 -= ac;
		Fp6::sub(z.b, t1, bd);
	}
	/*
		x = a + bw, w^2 = v
		y = x^2 = (a + bw)^2 = (a^2 + b^2v) + 2abw
		a^2 + b^2v = (a + b)(bv + a) - (abv + ab)
	*/
	static void sqr(Fp12T& y, const Fp12T& x)
	{
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		Fp6 t0, t1;
		Fp6::add(t0, a, b); // a + b
		mulVadd(t1, b, a); // bv + a
		t0 *= t1; // (a + b)(bv + a)
		Fp6::mul(t1, a, b); // ab
		Fp6::add(y.b, t1, t1); // 2ab
		mulVadd(y.a, t1, t1); // abv + ab
		Fp6::sub(y.a, t0, y.a);
	}
	/*
		x = a + bw, w^2 = v
		y = 1/x = (a - bw) / (a^2 - b^2v)
	*/
	static void inv(Fp12T& y, const Fp12T& x)
	{
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		Fp6 t0, t1;
		Fp6::sqr(t0, a);
		Fp6::sqr(t1, b);
		Fp2::mul_xi(t1.c, t1.c);
		t0.a -= t1.c;
		t0.b -= t1.a;
		t0.c -= t1.b; // t0 = a^2 - b^2v
		Fp6::inv(t0, t0);
		Fp6::mul(y.a, x.a, t0);
		Fp6::mul(y.b, x.b, t0);
		Fp6::neg(y.b, y.b);
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp12T& self)
	{
		return os << self.a << ' ' << self.b;
	}
	friend std::istream& operator>>(std::istream& is, Fp12T& self)
	{
		return is >> self.a >> self.b;
	}
	void normalize() {} // dummy
};

} // mcl

