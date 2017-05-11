#pragma once
/**
	@file
	@brief finite field extension class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp.hpp>
#include <mcl/fp2.hpp>

namespace mcl {

/*
	Fp6T = Fp2[v] / (v^3 - xi)
	x = a + b v + c v^2
*/
template<class Fp>
struct Fp6T : public fp::Operator<Fp6T<Fp> > {
	typedef Fp2T<Fp> Fp2;
	typedef Fp2DblT<Fp> Fp2Dbl;
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
	Fp* getFp0() { return a.getFp0(); }
	const Fp* getFp0() const { return a.getFp0(); }
	Fp2* getFp2() { return &a; }
	const Fp2* getFp2() const { return &a; }
	void set(const Fp2 &a_, const Fp2 &b_, const Fp2 &c_)
	{
		a = a_;
		b = b_;
		c = c_;
	}
	bool isZero() const
	{
		return a.isZero() && b.isZero() && c.isZero();
	}
	bool isOne() const
	{
		return a.isOne() && b.isZero() && c.isZero();
	}
	bool operator==(const Fp6T& rhs) const
	{
		return a == rhs.a && b == rhs.b && c == rhs.c;
	}
	bool operator!=(const Fp6T& rhs) const { return !operator==(rhs); }
	std::istream& readStream(std::istream& is, int ioMode)
	{
		a.readStream(is, ioMode);
		b.readStream(is, ioMode);
		c.readStream(is, ioMode);
		return is;
	}
	void setStr(const std::string& str, int ioMode = 0)
	{
		std::istringstream is(str);
		readStream(is, ioMode);
	}
	void getStr(std::string& str, int ioMode = 0) const
	{
		const char *sep = fp::getIoSeparator(ioMode);
		str = a.getStr(ioMode);
		str += sep;
		str += b.getStr(ioMode);
		str += sep;
		str += c.getStr(ioMode);
	}
	std::string getStr(int ioMode = 0) const
	{
		std::string str;
		getStr(str, ioMode);
		return str;
	}
	friend std::istream& operator>>(std::istream& is, Fp6T& self)
	{
		return self.readStream(is, fp::detectIoMode(Fp::BaseFp::getIoMode(), is));
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp6T& self)
	{
		return os << self.getStr(fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
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
//clk.begin();
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		const Fp2& d = y.a;
		const Fp2& e = y.b;
		const Fp2& f = y.c;
#if 1
		Fp2Dbl AD, BE, CF;
		Fp2Dbl::mulPre(AD, a, d);
		Fp2Dbl::mulPre(BE, b, e);
		Fp2Dbl::mulPre(CF, c, f);

		Fp2 t1, t2, t3, t4;
		Fp2::add(t1, b, c);
		Fp2::add(t2, e, f);
		Fp2Dbl T1;
		Fp2Dbl::mulPre(T1, t1, t2);
		Fp2Dbl::sub(T1, T1, BE);
		Fp2Dbl::sub(T1, T1, CF);
		Fp2Dbl::mul_xi(T1, T1);

		Fp2::add(t2, a, b);
		Fp2::add(t3, e, d);
		Fp2Dbl T2;
		Fp2Dbl::mulPre(T2, t2, t3);
		Fp2Dbl::sub(T2, T2, AD);
		Fp2Dbl::sub(T2, T2, BE);

		Fp2::add(t3, a, c);
		Fp2::add(t4, d, f);
		Fp2Dbl T3;
		Fp2Dbl::mulPre(T3, t3, t4);
		Fp2Dbl::sub(T3, T3, AD);
		Fp2Dbl::sub(T3, T3, CF);

		Fp2Dbl::add(AD, AD, T1);
		Fp2Dbl::mod(z.a, AD);
		Fp2Dbl::mul_xi(CF, CF);
		Fp2Dbl::add(CF, CF, T2);
		Fp2Dbl::mod(z.b, CF);
		Fp2Dbl::add(T3, T3, BE);
		Fp2Dbl::mod(z.c, T3);
#else
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
#endif
//clk.end();
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

	Fp* getFp0() { return a.getFp0(); }
	const Fp* getFp0() const { return a.getFp0(); }
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
	bool isOne() const
	{
		return a.isOne() && b.isZero();
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
	std::istream& readStream(std::istream& is, int ioMode)
	{
		a.readStream(is, ioMode);
		b.readStream(is, ioMode);
		return is;
	}
	void setStr(const std::string& str, int ioMode = 0)
	{
		std::istringstream is(str);
		readStream(is, ioMode);
	}
	void getStr(std::string& str, int ioMode = 0) const
	{
		const char *sep = fp::getIoSeparator(ioMode);
		str = a.getStr(ioMode);
		str += sep;
		str += b.getStr(ioMode);
	}
	std::string getStr(int ioMode = 0) const
	{
		std::string str;
		getStr(str, ioMode);
		return str;
	}
	friend std::istream& operator>>(std::istream& is, Fp12T& self)
	{
		return self.readStream(is, fp::detectIoMode(Fp::getIoMode(), is));
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp12T& self)
	{
		return os << self.getStr(fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
	}
};

} // mcl

