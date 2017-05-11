#pragma once
/**
	@file
	@brief finite field extension of degree 2
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
public:
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

} // mcl

