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
			mcl::fp::dumpUnit(v_[n - 1 - i]);
		}
		printf("\n");
	}
	friend std::ostream& operator<<(std::ostream& os, const FpDblT& x)
	{
		char buf[20];
		const size_t n = getUnitSize();
		for (size_t i = 0; i < n; i++) {
			mcl::fp::UnitToHex(buf, sizeof(buf), x.v_[n - 1 - i]);
			os << buf;
		}
		return os;
	}
	void clear()
	{
		const size_t n = getUnitSize();
		for (size_t i = 0; i < n; i++) {
			v_[i] = 0;
		}
	}
	FpDblT& operator=(const FpDblT& rhs)
	{
		const size_t n = getUnitSize();
		for (size_t i = 0; i < n; i++) {
			v_[i] = rhs.v_[i];
		}
		return *this;
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
	mpz_class getMpz() const
	{
		mpz_class x;
		getMpz(x);
		return x;
	}
	static void add(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_add(z.v_, x.v_, y.v_, Fp::op_.p); }
	static void sub(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_sub(z.v_, x.v_, y.v_, Fp::op_.p); }
	static void addPre(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_addPre(z.v_, x.v_, y.v_); }
	static void subPre(FpDblT& z, const FpDblT& x, const FpDblT& y) { Fp::op_.fpDbl_subPre(z.v_, x.v_, y.v_); }
	/*
		mul(z, x, y) = mulPre(xy, x, y) + mod(z, xy)
	*/
	static void mulPre(FpDblT& xy, const Fp& x, const Fp& y) { Fp::op_.fpDbl_mulPre(xy.v_, x.v_, y.v_); }
	static void sqrPre(FpDblT& xx, const Fp& x) { Fp::op_.fpDbl_sqrPre(xx.v_, x.v_); }
	static void mod(Fp& z, const FpDblT& xy) { Fp::op_.fpDbl_mod(z.v_, xy.v_, Fp::op_.p); }
	static void mulUnit(FpDblT& z, const FpDblT& x, Unit y)
	{
		if (mulSmallUnit(z, x, y)) return;
		throw cybozu::Exception("mulUnit:not supported") << y;
	}
	void operator+=(const FpDblT& x) { add(*this, *this, x); }
	void operator-=(const FpDblT& x) { sub(*this, *this, x); }
};

template<class Fp> struct Fp12T;
template<class Fp> class BNT;
/*
	beta = -1
	Fp2 = F[i] / (i^2 + 1)
	x = a + bi
*/
template<class Fp>
class Fp2T : public fp::Operator<Fp2T<Fp> > {
	typedef fp::Unit Unit;
	typedef FpDblT<Fp> FpDbl;
	static uint32_t xi_a_;
	static const size_t gN = 5;
	/*
		g = xi^((p - 1) / 6)
		g[] = { g^2, g^4, g^1, g^3, g^5 }
	*/
	static Fp2T g[gN];
	static Fp2T g2[gN];
	static Fp2T g3[gN];
public:
	static const Fp2T *get_gTbl() { return &g[0]; }
	static const Fp2T *get_g2Tbl() { return &g2[0]; }
	static const Fp2T *get_g3Tbl() { return &g3[0]; }
	typedef typename Fp::BaseFp BaseFp;
	static const size_t maxSize = Fp::maxSize * 2;
	static inline size_t getByteSize() { return Fp::getByteSize() * 2; }
	void dump() const
	{
		a.dump();
		b.dump();
	}
	Fp a, b;
	Fp2T() { }
	Fp2T(int64_t a) : a(a), b(0) { }
	Fp2T(const Fp& a, const Fp& b) : a(a), b(b) { }
	Fp2T(int64_t a, int64_t b) : a(a), b(b) { }
	Fp2T(const std::string& a, const std::string& b, int base = 0) : a(a, base), b(b, base) {}
	Fp* getFp0() { return &a; }
	const Fp* getFp0() const { return &a; }
	void clear()
	{
		a.clear();
		b.clear();
	}
	void set(const Fp &a_, const Fp &b_)
	{
		a = a_;
		b = b_;
	}
	static void add(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_add(z.a.v_, x.a.v_, y.a.v_); }
	static void sub(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::op_.fp2_sub(z.a.v_, x.a.v_, y.a.v_); }
	static void addPre(Fp2T& z, const Fp2T& x, const Fp2T& y) { Fp::addPre(z.a, x.a, y.a); Fp::addPre(z.b, x.b, y.b); }
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
	static void divBy4(Fp2T& y, const Fp2T& x)
	{
		Fp::divBy4(y.a, x.a);
		Fp::divBy4(y.b, x.b);
	}
	static void mulFp(Fp2T& z, const Fp2T& x, const Fp& y)
	{
		Fp::mul(z.a, x.a, y);
		Fp::mul(z.b, x.b, y);
	}
	template<class S>
	void setArray(const S *buf, size_t n)
	{
		if ((n & 1) != 0) throw cybozu::Exception("Fp2T:setArray:bad size") << n;
		n /= 2;
		a.setArray(buf, n);
		b.setArray(buf + n, n);
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
	/*
		Fp2T = <a> + ' ' + <b>
	*/
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
	friend std::istream& operator>>(std::istream& is, Fp2T& self)
	{
		return self.readStream(is, fp::detectIoMode(Fp::BaseFp::getIoMode(), is));
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp2T& self)
	{
		return os << self.getStr(fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
	}
	bool isZero() const { return a.isZero() && b.isZero(); }
	bool isOne() const { return a.isOne() && b.isZero(); }
	bool operator==(const Fp2T& rhs) const { return a == rhs.a && b == rhs.b; }
	bool operator!=(const Fp2T& rhs) const { return !operator==(rhs); }
	/*
		return true is a is odd (do not consider b)
		this function is for only compressed reprezentation of EC
		isOdd() is not good naming. QQQ
	*/
	bool isOdd() const { return a.isOdd(); }
	/*
		(a + bi)^2 = (a^2 - b^2) + 2ab i = c + di
		A = a^2
		B = b^2
		A = (c +/- sqrt(c^2 + d^2))/2
		b = d / 2a
	*/
	static inline bool squareRoot(Fp2T& y, const Fp2T& x)
	{
		Fp t1, t2;
		if (x.b.isZero()) {
			if (Fp::squareRoot(t1, x.a)) {
				y.a = t1;
				y.b.clear();
			} else {
				if (!Fp::squareRoot(t1, -x.a)) throw cybozu::Exception("Fp2T:squareRoot:internal error1") << x;
				y.a.clear();
				y.b = t1;
			}
			return true;
		}
		Fp::sqr(t1, x.a);
		Fp::sqr(t2, x.b);
		t1 += t2; // c^2 + d^2
		if (!Fp::squareRoot(t1, t1)) return false;
		Fp::add(t2, x.a, t1);
		Fp::divBy2(t2, t2);
		if (!Fp::squareRoot(t2, t2)) {
			Fp::sub(t2, x.a, t1);
			Fp::divBy2(t2, t2);
			if (!Fp::squareRoot(t2, t2)) throw cybozu::Exception("Fp2T:squareRoot:internal error2") << x;
		}
		y.a = t2;
		t2 += t2;
		Fp::inv(t2, t2);
		Fp::mul(y.b, x.b, t2);
		return true;
	}
	static void inline norm(Fp& y, const Fp2T& x)
	{
		Fp aa, bb;
		Fp::sqr(aa, x.a);
		Fp::sqr(bb, x.b);
		Fp::add(y, aa, bb);
	}
	/*
		Frobenius
		i^2 = -1
		(a + bi)^p = a + bi^p in Fp
		= a + bi if p = 1 mod 4
		= a - bi if p = 3 mod 4
	*/
	static void Frobenius(Fp2T& y, const Fp2T& x)
	{
		if (Fp::getOp().pmod4 == 1) {
			if (&y != &x) {
				y = x;
			}
		} else {
			if (&y != &x) {
				y.a = x.a;
			}
			Fp::neg(y.b, x.b);
		}
	}

	static uint32_t get_xi_a() { return xi_a_; }
	static void init(uint32_t xi_a)
	{
//		assert(Fp::maxSize <= 256);
		xi_a_ = xi_a;
		mcl::fp::Op& op = Fp::op_;
		op.fp2_add = fp2_addW;
		op.fp2_sub = fp2_subW;
		if (op.isFastMod) {
			op.fp2_mul = fp2_mulW;
		} else if (!op.isFullBit) {
			if (0 && sizeof(Fp) * 8 == op.N * fp::UnitBitSize && op.fp2_mulNF) {
				op.fp2_mul = fp2_mulNFW;
			} else {
				op.fp2_mul = fp2_mulUseDblUseNCW;
			}
		} else {
			op.fp2_mul = fp2_mulUseDblW;
		}
		op.fp2_neg = fp2_negW;
		op.fp2_inv = fp2_invW;
		op.fp2_sqr = fp2_sqrW;
		if (xi_a == 1) {
			op.fp2_mul_xi = fp2_mul_xi_1_1i;
		} else {
			op.fp2_mul_xi = fp2_mul_xiW;
		}
		const Fp2T xi(xi_a, 1);
		const mpz_class& p = Fp::getOp().mp;
		Fp2T::pow(g[0], xi, (p - 1) / 6); // g = xi^((p-1)/6)
		for (size_t i = 1; i < gN; i++) {
			g[i] = g[i - 1] * g[0];
		}
		/*
			permutate [0, 1, 2, 3, 4] => [1, 3, 0, 2, 4]
			g[0] = g^2
			g[1] = g^4
			g[2] = g^1
			g[3] = g^3
			g[4] = g^5
		*/
		{
			Fp2T t = g[0];
			g[0] = g[1];
			g[1] = g[3];
			g[3] = g[2];
			g[2] = t;
		}
		for (size_t i = 0; i < gN; i++) {
			Fp2T t(g[i].a, g[i].b);
			if (Fp::getOp().pmod4 == 3) Fp::neg(t.b, t.b);
			Fp2T::mul(g2[i], t, g[i]);
			g3[i] = g[i] * g2[i];
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
		Fp::add(s, a, b);
		Fp::add(t, c, d);
		FpDbl::mulPre(d0, s, t); // (a + b)(c + d)
		FpDbl::mulPre(d1, a, c);
		FpDbl::mulPre(d2, b, d);
		FpDbl::sub(d0, d0, d1); // (a + b)(c + d) - ac
		FpDbl::sub(d0, d0, d2); // (a + b)(c + d) - ac - bd
		Fp *pz = reinterpret_cast<Fp*>(z);
		FpDbl::mod(pz[1], d0);
		FpDbl::sub(d1, d1, d2); // ac - bd
		FpDbl::mod(pz[0], d1); // set z0
	}
	static void fp2_mulNFW(Unit *z, const Unit *x, const Unit *y)
	{
		const fp::Op& op = Fp::op_;
		op.fp2_mulNF(z, x, y, op.p);
	}
	static void fp2_mulUseDblUseNCW(Unit *z, const Unit *x, const Unit *y)
	{
		const Fp *px = reinterpret_cast<const Fp*>(x);
		const Fp *py = reinterpret_cast<const Fp*>(y);
		const Fp& a = px[0];
		const Fp& b = px[1];
		const Fp& c = py[0];
		const Fp& d = py[1];
		FpDbl d0, d1, d2;
		Fp s, t;
		Fp::addPre(s, a, b);
		Fp::addPre(t, c, d);
		FpDbl::mulPre(d0, s, t); // (a + b)(c + d)
		FpDbl::mulPre(d1, a, c);
		FpDbl::mulPre(d2, b, d);
		FpDbl::subPre(d0, d0, d1); // (a + b)(c + d) - ac
		FpDbl::subPre(d0, d0, d2); // (a + b)(c + d) - ac - bd
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
		Fp::addPre(t1, b, b); // 2b
		FpDbl::mulPre(d2, t1, a); // 2ab
		Fp::addPre(t1, a, b); // a + b
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
		Fp::mulUnit(t, a, xi_a_);
		t -= b;
		Fp::mulUnit(py[1], b, xi_a_);
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
};

template<class Fp>
struct Fp2DblT {
	typedef FpDblT<Fp> FpDbl;
	typedef Fp2T<Fp> Fp2;
	FpDbl a, b;
	static void add(Fp2DblT& z, const Fp2DblT& x, const Fp2DblT& y)
	{
		FpDbl::add(z.a, x.a, y.a);
		FpDbl::add(z.b, x.b, y.b);
	}
	static void addPre(Fp2DblT& z, const Fp2DblT& x, const Fp2DblT& y)
	{
		FpDbl::addPre(z.a, x.a, y.a);
		FpDbl::addPre(z.b, x.b, y.b);
	}
	static void sub(Fp2DblT& z, const Fp2DblT& x, const Fp2DblT& y)
	{
		FpDbl::sub(z.a, x.a, y.a);
		FpDbl::sub(z.b, x.b, y.b);
	}
	static void subPre(Fp2DblT& z, const Fp2DblT& x, const Fp2DblT& y)
	{
		FpDbl::subPre(z.a, x.a, y.a);
		FpDbl::subPre(z.b, x.b, y.b);
	}
	static void neg(Fp2DblT& y, const Fp2DblT& x)
	{
		FpDbl::neg(y.a, x.a);
		FpDbl::neg(y.b, x.b);
	}
	static void mul_xi(Fp2DblT& y, const Fp2DblT& x)
	{
		const uint32_t xi_a = Fp2::get_xi_a();
		if (xi_a == 1) {
			FpDbl t;
			FpDbl::add(t, x.a, x.b);
			FpDbl::sub(y.a, x.a, x.b);
			y.b = t;
		} else {
			FpDbl t;
			FpDbl::mulUnit(t, x.a, xi_a);
			FpDbl::sub(t, t, x.b);
			FpDbl::mulUnit(y.b, x.b, xi_a);
			FpDbl::add(y.b, y.b, x.a);
			y.a = t;
		}
	}
	static void sqrPre(Fp2DblT& y, const Fp2& x)
	{
		Fp t1, t2;
		if (Fp::isFullBit()) {
			Fp::add(t1, x.b, x.b); // 2b
			Fp::add(t2, x.a, x.b); // a + b
		} else {
			Fp::addPre(t1, x.b, x.b); // 2b
			Fp::addPre(t2, x.a, x.b); // a + b
		}
		FpDbl::mulPre(y.b, t1, x.a); // 2ab
		Fp::sub(t1, x.a, x.b); // a - b
		FpDbl::mulPre(y.a, t1, t2); // (a + b)(a - b)
	}
	static void mulPre(Fp2DblT& z, const Fp2& x, const Fp2& y)
	{
		const Fp& a = x.a;
		const Fp& b = x.b;
		const Fp& c = y.a;
		const Fp& d = y.b;
		if (Fp::isFullBit()) {
			FpDbl BD;
			Fp s, t;
			Fp::add(s, a, b); // s = a + b
			Fp::add(t, c, d); // t = c + d
			FpDbl::mulPre(BD, b, d); // BD = bd
			FpDbl::mulPre(z.a, a, c); // z.a = ac
			FpDbl::mulPre(z.b, s, t); // z.b = st
			FpDbl::sub(z.b, z.b, z.a); // z.b = st - ac
			FpDbl::sub(z.b, z.b, BD); // z.b = st - ac - bd = ad + bc
			FpDbl::sub(z.a, z.a, BD); // ac - bd
		} else {
			FpDbl BD;
			Fp s, t;
			Fp::addPre(s, a, b); // s = a + b
			Fp::addPre(t, c, d); // t = c + d
			FpDbl::mulPre(BD, b, d); // BD = bd
			FpDbl::mulPre(z.a, a, c); // z.a = ac
			FpDbl::mulPre(z.b, s, t); // z.b = st
			FpDbl::subPre(z.b, z.b, z.a); // z.b = st - ac
			FpDbl::subPre(z.b, z.b, BD); // z.b = st - ac - bd = ad + bc
			FpDbl::sub(z.a, z.a, BD); // ac - bd
		}
	}
	static void mod(Fp2& y, const Fp2DblT& x)
	{
		FpDbl::mod(y.a, x.a);
		FpDbl::mod(y.b, x.b);
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp2DblT& x)
	{
		return os << x.a << ' ' << x.b;
	}
	void operator+=(const Fp2DblT& x) { add(*this, *this, x); }
	void operator-=(const Fp2DblT& x) { sub(*this, *this, x); }
};

template<class Fp> uint32_t Fp2T<Fp>::xi_a_;
template<class Fp> Fp2T<Fp> Fp2T<Fp>::g[Fp2T<Fp>::gN];
template<class Fp> Fp2T<Fp> Fp2T<Fp>::g2[Fp2T<Fp>::gN];
template<class Fp> Fp2T<Fp> Fp2T<Fp>::g3[Fp2T<Fp>::gN];

/*
	Fp6T = Fp2[v] / (v^3 - xi)
	x = a + b v + c v^2
*/
template<class Fp>
struct Fp6T : public fp::Operator<Fp6T<Fp> > {
	typedef Fp2T<Fp> Fp2;
	typedef Fp2DblT<Fp> Fp2Dbl;
	typedef Fp BaseFp;
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
	typedef Fp BaseFp;
	Fp6 a, b;
	Fp12T() {}
	Fp12T(int64_t a) : a(a), b(0) {}
	Fp12T(const Fp6& a, const Fp6& b) : a(a), b(b) {}
	void clear()
	{
		a.clear();
		b.clear();
	}
	void setOne()
	{
		clear();
		a.a.a = 1;
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
	/*
		y = 1 / x = conjugate of x if |x| = 1
	*/
	static void unitaryInv(Fp12T& y, const Fp12T& x)
	{
		if (&y != &x) y.a = x.a;
		Fp6::neg(y.b, x.b);
	}
	/*
		Frobenius
		i^2 = -1
		(a + bi)^p = a + bi^p in Fp
		= a + bi if p = 1 mod 4
		= a - bi if p = 3 mod 4

		g = xi^(p - 1) / 6
		v^3 = xi in Fp2
		v^p = ((v^6) ^ (p-1)/6) v = g^2 v
		v^2p = g^4 v^2
		(a + bv + cv^2)^p in Fp6
		= F(a) + F(b)g^2 v + F(c) g^4 v^2

		w^p = ((w^6) ^ (p-1)/6) w = g w
		((a + bv + cv^2)w)^p in Fp12T
		= (F(a) g + F(b) g^3 v + F(c) g^5 v^2)w
	*/
	static void Frobenius(Fp12T& y, const Fp12T& x)
	{
		for (int i = 0; i < 6; i++) {
			Fp2::Frobenius(y.getFp2()[i], x.getFp2()[i]);
		}
		for (int i = 1; i < 6; i++) {
			y.getFp2()[i] *= Fp2::get_gTbl()[i - 1];
		}
	}
	static void Frobenius2(Fp12T& y, const Fp12T& x)
	{
#if 0
		Frobenius(y, x);
		Frobenius(y, y);
#else
		y.getFp2()[0] = x.getFp2()[0];
		if (Fp::getOp().pmod4 == 1) {
			for (int i = 1; i < 6; i++) {
				Fp2::mul(y.getFp2()[i], x.getFp2()[i], Fp2::get_g2Tbl()[i]);
			}
		} else {
			for (int i = 1; i < 6; i++) {
				Fp2::mulFp(y.getFp2()[i], x.getFp2()[i], Fp2::get_g2Tbl()[i - 1].a);
			}
		}
#endif
	}
	static void Frobenius3(Fp12T& y, const Fp12T& x)
	{
#if 0
		Frobenius(y, x);
		Frobenius(y, y);
		Frobenius(y, y);
#else
		Fp2::Frobenius(y.getFp2()[0], x.getFp2()[0]);
		for (int i = 1; i < 6; i++) {
			Fp2::Frobenius(y.getFp2()[i], x.getFp2()[i]);
			y.getFp2()[i] *= Fp2::get_g3Tbl()[i - 1];
		}
#endif
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

/*
	convert multiplicative group to additive group
*/
template<class T>
struct GroupMtoA : public T {
	static T& self(GroupMtoA& x) { return static_cast<T&>(x); }
	static const T& self(const GroupMtoA& x) { return static_cast<const T&>(x); }
	void clear()
	{
		self(*this) = 1;
	}
	static void add(GroupMtoA& z, const GroupMtoA& x, const GroupMtoA& y)
	{
		T::mul(self(z), self(x), self(y));
	}
	static void dbl(GroupMtoA& y, const GroupMtoA& x)
	{
		T::sqr(self(y), self(x));
	}
	static void neg(GroupMtoA& y, const GroupMtoA& x)
	{
		// assume Fp12
		T::unitaryInv(self(y), self(x));
	}
	static void Frobenus(GroupMtoA& y, const GroupMtoA& x)
	{
		T::Frobenius(self(y), self(x));
	}
	template<class INT>
	static void mul(GroupMtoA& z, const GroupMtoA& x, const INT& y)
	{
		T::pow(self(z), self(x), y);
	}
	void operator+=(const GroupMtoA& rhs)
	{
		add(*this, *this, rhs);
	}
};

} // mcl

