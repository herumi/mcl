#pragma once
/**
	@file
	@brief finite field extension class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp_def.hpp>
#include <mcl/fr_def.hpp>

namespace mcl {

class FpDbl : public fp::Serializable<FpDbl> {
	Unit v_[Fp::maxSize * 2];
	friend struct Fp2Dbl;
public:
	static size_t getUnitSize() { return Fp::op_.N * 2; }
	const Unit *getUnit() const { return v_; }
	void dump() const
	{
		bint::dump(v_, getUnitSize());
	}
	template<class OutputStream>
	void save(bool *pb, OutputStream& os, int) const
	{
		char buf[1024];
		size_t n = mcl::fp::arrayToHex(buf, sizeof(buf), v_, getUnitSize());
		if (n == 0) {
			*pb = false;
			return;
		}
		cybozu::write(pb, os, buf + sizeof(buf) - n, sizeof(buf));
	}
	template<class InputStream>
	void load(bool *pb, InputStream& is, int)
	{
		char buf[1024];
		*pb = false;
		size_t n = fp::local::loadWord(buf, sizeof(buf), is);
		if (n == 0) return;
		n = fp::hexToArray(v_, getUnitSize(), buf, n);
		if (n == 0) return;
		for (size_t i = n; i < getUnitSize(); i++) v_[i] = 0;
		*pb = true;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		bool b;
		save(&b, os, ioMode);
		if (!b) throw cybozu::Exception("FpDbl:save") << ioMode;
	}
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		bool b;
		load(&b, is, ioMode);
		if (!b) throw cybozu::Exception("FpDbl:load") << ioMode;
	}
	void getMpz(mpz_class& x) const
	{
		bool b;
		getMpz(&b, x);
		if (!b) throw cybozu::Exception("FpDbl:getMpz");
	}
	mpz_class getMpz() const
	{
		mpz_class x;
		getMpz(x);
		return x;
	}
#endif
	void clear()
	{
		const size_t n = getUnitSize();
		for (size_t i = 0; i < n; i++) {
			v_[i] = 0;
		}
	}
	FpDbl& operator=(const FpDbl& rhs)
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
		assert(x >= 0);
		const size_t xn = gmp::getUnitSize(x);
		const size_t N2 = getUnitSize();
		if (xn > N2) {
			assert(0);
			return;
		}
		memcpy(v_, gmp::getUnit(x), xn * sizeof(Unit));
		memset(v_ + xn, 0, (N2 - xn) * sizeof(Unit));
	}
	void getMpz(bool *pb, mpz_class& x) const
	{
		gmp::setArray(pb, x, v_, Fp::op_.N * 2);
	}
	static inline void add(FpDbl& z, const FpDbl& x, const FpDbl& y)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fpDbl_addA_(z.v_, x.v_, y.v_);
#else
		Fp::op_.fpDbl_add(z.v_, x.v_, y.v_, Fp::op_.p);
#endif
	}
	static inline void sub(FpDbl& z, const FpDbl& x, const FpDbl& y)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fpDbl_subA_(z.v_, x.v_, y.v_);
#else
		Fp::op_.fpDbl_sub(z.v_, x.v_, y.v_, Fp::op_.p);
#endif
	}
	static inline void neg(FpDbl& z, const FpDbl& x)
	{
		static const Unit zero_[Fp::maxSize * 2] = {};
		const FpDbl& zero = *(const FpDbl*)zero_;
		sub(z, zero, x);
	}
	static inline void mod(Fp& z, const FpDbl& xy)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fpDbl_modA_(z.v_, xy.v_);
#else
		Fp::op_.fpDbl_mod(z.v_, xy.v_, Fp::op_.p);
#endif
	}
#ifdef MCL_XBYAK_DIRECT_CALL
	static void addA(Unit *z, const Unit *x, const Unit *y) { Fp::op_.fpDbl_add(z, x, y, Fp::op_.p); }
	static void subA(Unit *z, const Unit *x, const Unit *y) { Fp::op_.fpDbl_sub(z, x, y, Fp::op_.p); }
	static void modA(Unit *z, const Unit *xy) { Fp::op_.fpDbl_mod(z, xy, Fp::op_.p); }
#endif
	static void addPre(FpDbl& z, const FpDbl& x, const FpDbl& y) { Fp::op_.fpDbl_addPre(z.v_, x.v_, y.v_); }
	static void subPre(FpDbl& z, const FpDbl& x, const FpDbl& y) { Fp::op_.fpDbl_subPre(z.v_, x.v_, y.v_); }
	/*
		mul(z, x, y) = mulPre(xy, x, y) + mod(z, xy)
	*/
	static void mulPre(FpDbl& xy, const Fp& x, const Fp& y) { Fp::op_.fpDbl_mulPre(xy.v_, x.v_, y.v_); }
	static void sqrPre(FpDbl& xx, const Fp& x) { Fp::op_.fpDbl_sqrPre(xx.v_, x.v_); }
	static void mulUnit(FpDbl& z, const FpDbl& x, Unit y)
	{
		if (mulSmallUnit(z, x, y)) return;
		assert(0); // not supported y
	}
	static void init()
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		mcl::fp::Op& op = Fp::op_;
		if (op.fpDbl_addA_ == 0) {
			op.fpDbl_addA_ = addA;
		}
		if (op.fpDbl_subA_ == 0) {
			op.fpDbl_subA_ = subA;
		}
		if (op.fpDbl_modA_ == 0) {
			op.fpDbl_modA_ = modA;
		}
#endif
	}
	void operator+=(const FpDbl& x) { add(*this, *this, x); }
	void operator-=(const FpDbl& x) { sub(*this, *this, x); }
};

/*
	Fp2 = F[i] / (i^2 + u)
	x = a + b i
*/
class Fp2 : public fp::Serializable<Fp2, fp::Operator<Fp2> > {
	static const size_t gN = 5;
	static Fp u_pm1o2; // u^((p-1)/2)
	/*
		g = xi^((p - 1) / 6)
		g[] = { g^2, g^4, g^1, g^3, g^5 }
	*/
	static Fp2 g[gN];
	static Fp2 g2[gN];
	static Fp2 g3[gN];
public:
	static const Fp2 *get_gTbl() { return &g[0]; }
	static const Fp2 *get_g2Tbl() { return &g2[0]; }
	static const Fp2 *get_g3Tbl() { return &g3[0]; }
	typedef Fp::BaseFp BaseFp;
	static const size_t maxSize = Fp::maxSize * 2;
	static inline size_t getByteSize() { return Fp::getByteSize() * 2; }
	void dump() const
	{
		a.dump();
		b.dump();
	}
	Fp a, b;
	Fp2() { }
	Fp2(int64_t a) : a(a), b(0) { }
	Fp2(const Fp& a, const Fp& b) : a(a), b(b) { }
	Fp2(int64_t a, int64_t b) : a(a), b(b) { }
	Fp* getFp0() { return &a; }
	const Fp* getFp0() const { return &a; }
	const Unit* getUnit() const { return a.getUnit(); }
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
	static void add(Fp2& z, const Fp2& x, const Fp2& y)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_addA_(z.a.v_, x.a.v_, y.a.v_);
#else
		addA(z.a.v_, x.a.v_, y.a.v_);
#endif
	}
	static void sub(Fp2& z, const Fp2& x, const Fp2& y)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_subA_(z.a.v_, x.a.v_, y.a.v_);
#else
		subA(z.a.v_, x.a.v_, y.a.v_);
#endif
	}
	static void neg(Fp2& y, const Fp2& x)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_negA_(y.a.v_, x.a.v_);
#else
		negA(y.a.v_, x.a.v_);
#endif
	}
	static void mul(Fp2& z, const Fp2& x, const Fp2& y)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_mulA_(z.a.v_, x.a.v_, y.a.v_);
#else
		mulA(z.a.v_, x.a.v_, y.a.v_);
#endif
	}
	static void sqr(Fp2& y, const Fp2& x)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_sqrA_(y.a.v_, x.a.v_);
#else
		if (Fp::op_.u == 1) {
			sqrA(y.a.v_, x.a.v_);
		} else {
			assert(Fp::op_.u == 5);
			sqrAu5(y.a.v_, x.a.v_);
		}
#endif
	}
	static void mul2(Fp2& y, const Fp2& x)
	{
#ifdef MCL_XBYAK_DIRECT_CALL
		Fp::op_.fp2_mul2A_(y.a.v_, x.a.v_);
#else
		mul2A(y.a.v_, x.a.v_);
#endif
	}
	static void mul_xi(Fp2& y, const Fp2& x)
	{
		Fp::op_.fp2_mul_xiA_(y.a.v_, x.a.v_);
	}
	/*
		x = a + bi
		1 / x = (a - bi) / (a^2 + b^2 u)
	*/
	static void inv(Fp2& y, const Fp2& x)
	{
		assert(!x.isZero());
		const Fp& a = x.a;
		const Fp& b = x.b;
		Fp r;
		norm(r, x);
		Fp::inv(r, r); // r = 1 / (a^2 + b^2 u)
		Fp::mul(y.a, a, r);
		Fp::mul(y.b, b, r);
		Fp::neg(y.b, y.b);
	}
	static void addPre(Fp2& z, const Fp2& x, const Fp2& y)
	{
		Fp::addPre(z.a, x.a, y.a);
		Fp::addPre(z.b, x.b, y.b);
	}
	static void divBy2(Fp2& y, const Fp2& x)
	{
		Fp::divBy2(y.a, x.a);
		Fp::divBy2(y.b, x.b);
	}
	static void divBy4(Fp2& y, const Fp2& x)
	{
		Fp::divBy4(y.a, x.a);
		Fp::divBy4(y.b, x.b);
	}
	static void mulFp(Fp2& z, const Fp2& x, const Fp& y)
	{
		Fp::mul(z.a, x.a, y);
		Fp::mul(z.b, x.b, y);
	}
	template<class S>
	void setArray(bool *pb, const S *buf, size_t n)
	{
		assert((n & 1) == 0);
		n /= 2;
		a.setArray(pb, buf, n);
		if (!*pb) return;
		b.setArray(pb, buf + n, n);
	}
	template<class InputStream>
	void load(bool *pb, InputStream& is, int ioMode)
	{
		Fp *ap = &a, *bp = &b;
		if (Fp::getETHserialization() && ioMode & (IoSerialize | IoSerializeHexStr)) {
			fp::swap_(ap, bp);
		}
		ap->load(pb, is, ioMode);
		if (!*pb) return;
		bp->load(pb, is, ioMode);
	}
	/*
		Fp2 = <a> + ' ' + <b>
	*/
	template<class OutputStream>
	void save(bool *pb, OutputStream& os, int ioMode) const
	{
		const Fp *ap = &a, *bp = &b;
		if (Fp::getETHserialization() && ioMode & (IoSerialize | IoSerializeHexStr)) {
			fp::swap_(ap, bp);
		}
		const char sep = *fp::getIoSeparator(ioMode);
		ap->save(pb, os, ioMode);
		if (!*pb) return;
		if (sep) {
			cybozu::writeChar(pb, os, sep);
			if (!*pb) return;
		}
		bp->save(pb, os, ioMode);
	}
	bool isZero() const { return a.isZero() && b.isZero(); }
	bool isOne() const { return a.isOne() && b.isZero(); }
	bool operator==(const Fp2& rhs) const { return a == rhs.a && b == rhs.b; }
	bool operator!=(const Fp2& rhs) const { return !operator==(rhs); }
	/*
		return true is a is odd (do not consider b)
		this function is for only compressed reprezentation of EC
		isOdd() is not good naming. QQQ
	*/
	bool isOdd() const { return a.isOdd(); }
	/*
		(a + bi)^2 = (a^2 - b^2 u) + 2ab i = c + di
		A = a^2
		B = b^2
		A = (c +/- sqrt(c^2 + d^2 u))/2
		b = d / 2a
	*/
	static inline bool squareRoot(Fp2& y, const Fp2& x)
	{
		Fp t1, t2;
		if (x.b.isZero()) {
			if (Fp::squareRoot(t1, x.a)) {
				y.a = t1;
				y.b.clear();
			} else {
				bool b = Fp::squareRoot(t1, -x.a);
				assert(b); (void)b;
				y.a.clear();
				y.b = t1;
			}
			return true;
		}
		norm(t1, x);
		if (!Fp::squareRoot(t1, t1)) return false;
		Fp::add(t2, x.a, t1);
		Fp::divBy2(t2, t2);
		if (!Fp::squareRoot(t2, t2)) {
			Fp::sub(t2, x.a, t1);
			Fp::divBy2(t2, t2);
			bool b = Fp::squareRoot(t2, t2);
			assert(b); (void)b;
		}
		y.a = t2;
		t2 += t2;
		Fp::inv(t2, t2);
		Fp::mul(y.b, x.b, t2);
		return true;
	}
	// y = a^2 + b^2 u
	static void inline norm(Fp& y, const Fp2& x)
	{
		FpDbl AA, BB;
		FpDbl::sqrPre(AA, x.a);
		FpDbl::sqrPre(BB, x.b);
		uint32_t u = Fp::getOp().u;
		if (u != 1) {
			mcl::fp::mulSmallUnit(BB, BB, u);
		}
		if (Fp::getOp().isFullBit) {
			FpDbl::add(AA, AA, BB);
		} else {
			FpDbl::addPre(AA, AA, BB);
		}
		FpDbl::mod(y, AA);
	}
	/*
		Frobenius
		i^2 = -u
		(a + bi)^p = a + bi^p in Fp
		= a + bi c if p = 1 mod 4
		= a - bi c if p = 3 mod 4
		where c = u^((p-1)/2)
	*/
	static void Frobenius(Fp2& y, const Fp2& x)
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
		if (Fp::getOp().u != 1) {
			y.b *= u_pm1o2;
		}
	}

	static uint32_t get_xi_a() { return Fp::getOp().xi_a; }
	static void init(bool *pb);
#ifndef CYBOZU_DONT_USE_EXCEPTION
	static void init()
	{
		bool b;
		init(&b);
		if (!b) throw cybozu::Exception("Fp2::init");
	}
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		bool b;
		load(&b, is, ioMode);
		if (!b) throw cybozu::Exception("Fp2:load");
	}
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		bool b;
		save(&b, os, ioMode);
		if (!b) throw cybozu::Exception("Fp2:save");
	}
	template<class S>
	void setArray(const S *buf, size_t n)
	{
		bool b;
		setArray(&b, buf, n);
		if (!b) throw cybozu::Exception("Fp2:setArray");
	}
#endif
#ifndef CYBOZU_DONT_USE_STRING
	Fp2(const std::string& a, const std::string& b, int base = 0) : a(a, base), b(b, base) {}
	friend std::istream& operator>>(std::istream& is, Fp2& self)
	{
		self.load(is, fp::detectIoMode(Fp::BaseFp::getIoMode(), is));
		return is;
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp2& self)
	{
		self.save(os, fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
		return os;
	}
#endif
private:
	static Fp2& cast(Unit *x) { return *reinterpret_cast<Fp2*>(x); }
	static const Fp2& cast(const Unit *x) { return *reinterpret_cast<const Fp2*>(x); }
	/*
		default Fp2 operator
		Fp2 = Fp[i]/(i^2 + 1)
	*/
	static void addA(Unit *pz, const Unit *px, const Unit *py)
	{
		Fp2& z = cast(pz);
		const Fp2& x = cast(px);
		const Fp2& y = cast(py);
		Fp::add(z.a, x.a, y.a);
		Fp::add(z.b, x.b, y.b);
	}
	static void subA(Unit *pz, const Unit *px, const Unit *py)
	{
		Fp2& z = cast(pz);
		const Fp2& x = cast(px);
		const Fp2& y = cast(py);
		Fp::sub(z.a, x.a, y.a);
		Fp::sub(z.b, x.b, y.b);
	}
	static void negA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		Fp::neg(y.a, x.a);
		Fp::neg(y.b, x.b);
	}
	static void mulA(Unit *pz, const Unit *px, const Unit *py);
#if 0
	{
		Fp2& z = cast(pz);
		const Fp2& x = cast(px);
		const Fp2& y = cast(py);
		Fp2Dbl d;
		Fp2Dbl::mulPre(d, x, y);
		FpDbl::mod(z.a, d.a);
		FpDbl::mod(z.b, d.b);
	}
#endif
	static void mul2A(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		Fp::mul2(y.a, x.a);
		Fp::mul2(y.b, x.b);
	}
	/*
		x = a + bi, i^2 = -1
		y = x^2 = (a + bi)^2 = (a + b)(a - b) + 2abi
	*/
	static void sqrA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		const Fp& a = x.a;
		const Fp& b = x.b;
		Fp t1, t2, t3;
		Fp::mul2(t1, b);
		t1 *= a; // 2ab
		Fp::add(t2, a, b); // a + b
		Fp::sub(t3, a, b); // a - b
		Fp::mul(y.a, t2, t3); // (a + b)(a - b)
		y.b = t1;
	}
	/*
		xi = xi_a + i
		x = a + bi
		y = (a + bi)xi = (a + bi)(xi_a + i)
		=(a * x_ia - b) + (a + b xi_a)i
	*/
	static void fp2_mul_xi_a_iA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		const Fp& a = x.a;
		const Fp& b = x.b;
		Fp t;
		Fp::mulUnit(t, a, Fp::getOp().xi_a);
		t -= b;
		Fp::mulUnit(y.b, b, Fp::getOp().xi_a);
		y.b += a;
		y.a = t;
	}
	/*
		xi = 1 + i ; xi_a = 1
		y = (a + bi)xi = (a - b) + (a + b)i
	*/
	static void fp2_mul_xi_1_iA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		const Fp& a = x.a;
		const Fp& b = x.b;
		Fp t;
		Fp::add(t, a, b);
		Fp::sub(y.a, a, b);
		y.b = t;
	}
	// The following functions are for u != 1.
	static void sqrAu5(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		const Fp& a = x.a;
		const Fp& b = x.b;
		assert(Fp::getOp().u == 5);
		Fp t1, t2, t3;
		Fp::mul2(t1, b); // 2b
		Fp::mul2(t2, t1); // 4b
		Fp::add(t2, t2, b); // 5b
		Fp::add(t2, t2, a); // a+5b
		Fp::sub(t3, a, b); // a-b
		Fp::mul(y.b, t1, a); // 2ab
		Fp::mul(y.a, t2, t3); // (a-b)(a+5b)
		Fp::mul2(t1, y.b); // 2ab
		Fp::sub(y.a, y.a, t1); // (a-b)(a+5b)-4ab
	}
#if 0
	/*
		xi = xi_a + i
		x = a + bi
		y = (a + bi)xi = (a + bi)(xi_a + i)
		=(a x_ia - b u) + (a + b xi_a)i
	*/
	static void fp2u_mul_xi_a_iA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		const Fp& a = x.a;
		const Fp& b = x.b;
		Fp t;
		Fp::mulUnit(t, a, Fp::getOp().xi_a);
		Fp bu;
		Fp::mulUnit(bu, b, Fp::getOp().u);
		t -= bu;
		Fp::mulUnit(y.b, b, Fp::getOp().xi_a);
		y.b += a;
		y.a = t;
	}
#endif
	/*
		xi = i ; xi_a = 0
		y = (a + bi)xi = (-u) b + a i
	*/
	static void fp2u_mul_xi_0_iA(Unit *py, const Unit *px)
	{
		Fp2& y = cast(py);
		const Fp2& x = cast(px);
		Fp t;
		Fp::mulUnit(t, x.b, Fp::getOp().u);
		y.b = x.a;
		Fp::neg(y.a, t);
	}
};

struct Fp2Dbl {
	FpDbl a, b;
	static void add(Fp2Dbl& z, const Fp2Dbl& x, const Fp2Dbl& y)
	{
		FpDbl::add(z.a, x.a, y.a);
		FpDbl::add(z.b, x.b, y.b);
	}
	static void addPre(Fp2Dbl& z, const Fp2Dbl& x, const Fp2Dbl& y)
	{
		FpDbl::addPre(z.a, x.a, y.a);
		FpDbl::addPre(z.b, x.b, y.b);
	}
	static void sub(Fp2Dbl& z, const Fp2Dbl& x, const Fp2Dbl& y)
	{
		FpDbl::sub(z.a, x.a, y.a);
		FpDbl::sub(z.b, x.b, y.b);
	}
	static void subPre(Fp2Dbl& z, const Fp2Dbl& x, const Fp2Dbl& y)
	{
		FpDbl::subPre(z.a, x.a, y.a);
		FpDbl::subPre(z.b, x.b, y.b);
	}
	/*
		imaginary part of Fp2Dbl::mul uses only add,
		so it does not require mod.
	*/
	template<bool isLtQuad>
	static void subSpecial(Fp2Dbl& y, const Fp2Dbl& x)
	{
		FpDbl::sub(y.a, y.a, x.a);
		if (isLtQuad) {
			FpDbl::subPre(y.b, y.b, x.b);
		} else {
			FpDbl::sub(y.b, y.b, x.b);
		}
	}
	static void neg(Fp2Dbl& y, const Fp2Dbl& x)
	{
		FpDbl::neg(y.a, x.a);
		FpDbl::neg(y.b, x.b);
	}
	static void mulPre(Fp2Dbl& z, const Fp2& x, const Fp2& y)
	{
		Fp::getOp().fp2Dbl_mulPreA_(z.a.v_, x.getUnit(), y.getUnit());
	}
	static void sqrPre(Fp2Dbl& y, const Fp2& x)
	{
		Fp::getOp().fp2Dbl_sqrPreA_(y.a.v_, x.getUnit());
	}
	static void mul_xi(Fp2Dbl& y, const Fp2Dbl& x)
	{
		Fp::getOp().fp2Dbl_mul_xiA_(y.a.v_, x.a.getUnit());
	}
	static void mod(Fp2& y, const Fp2Dbl& x)
	{
		FpDbl::mod(y.a, x.a);
		FpDbl::mod(y.b, x.b);
	}
	void operator+=(const Fp2Dbl& x) { add(*this, *this, x); }
	void operator-=(const Fp2Dbl& x) { sub(*this, *this, x); }
	static void init()
 	{
		bool isFullBit = Fp::getOp().isFullBit;
		mcl::fp::Op& op = Fp::getOpNonConst();
		uint32_t u = op.u;
		if (op.fp2Dbl_mulPreA_ == 0) {
			if (isFullBit) {
				op.fp2Dbl_mulPreA_ = u == 1 ? mulPreA<true> : mulPreAu<true>;
			} else {
				op.fp2Dbl_mulPreA_ = u == 1 ? mulPreA<false> : mulPreAu<false>;
			}
		}
		if (op.fp2Dbl_sqrPreA_ == 0) {
			assert(u == 1 || u == 5);
			if (isFullBit) {
				op.fp2Dbl_sqrPreA_ = u == 1 ? sqrPreA<true> : sqrPreAu5;
			} else {
				op.fp2Dbl_sqrPreA_ = u == 1 ? sqrPreA<false> : sqrPreAu5;
			}
		}
		if (u == 1) {
			if (op.fp2Dbl_mul_xiA_ == 0) {
				const uint32_t xi_a = Fp2::get_xi_a();
				if (xi_a == 1) {
					op.fp2Dbl_mul_xiA_ = mul_xi_1_iA;
				} else {
					op.fp2Dbl_mul_xiA_ = mul_xi_a_iA;
				}
			}
		} else {
			if (op.fp2Dbl_mul_xiA_ == 0) {
				const uint32_t xi_a = Fp2::get_xi_a();
				if (xi_a == 0) {
					op.fp2Dbl_mul_xiA_ = mulu_xi_0_iA;
				} else {
					assert(0);
				}
			}
		}
	}
private:
	static Fp2 cast(Unit *x) { return *reinterpret_cast<Fp2*>(x); }
	static const Fp2 cast(const Unit *x) { return *reinterpret_cast<const Fp2*>(x); }
	static Fp2Dbl& castD(Unit *x) { return *reinterpret_cast<Fp2Dbl*>(x); }
	static const Fp2Dbl& castD(const Unit *x) { return *reinterpret_cast<const Fp2Dbl*>(x); }
	/*
		Fp2Dbl::mulPre by FpDbl
		(a + bi)(c + di) = (ac-bd) + ((a+b)(c+d)-ac-bd)i
		@note mod of NIST_P192 is fast
	*/
	template<bool isFullBit>
	static void mulPreA(Unit *pz, const Unit *px, const Unit *py)
	{
		Fp2Dbl& z = castD(pz);
		const Fp2& x = cast(px);
		const Fp2& y = cast(py);
		const Fp& a = x.a;
		const Fp& b = x.b;
		const Fp& c = y.a;
		const Fp& d = y.b;
		FpDbl& d0 = z.a;
		FpDbl& d1 = z.b;
		FpDbl d2;
		Fp s, t;
		if (isFullBit) {
			Fp::add(s, a, b);
			Fp::add(t, c, d);
		} else {
			Fp::addPre(s, a, b);
			Fp::addPre(t, c, d);
		}
		FpDbl::mulPre(d1, s, t); // (a + b)(c + d)
		FpDbl::mulPre(d0, a, c);
		FpDbl::mulPre(d2, b, d);
		if (isFullBit) {
			FpDbl::sub(d1, d1, d0);
			FpDbl::sub(d1, d1, d2);
		} else {
			FpDbl::subPre(d1, d1, d0);
			FpDbl::subPre(d1, d1, d2);
		}
		FpDbl::sub(d0, d0, d2); // ac - bd
	}
	template<bool isFullBit>
	static void sqrPreA(Unit *py, const Unit *px)
	{
		Fp2Dbl& y = castD(py);
		const Fp2& x = cast(px);
		Fp t1, t2;
		if (isFullBit) {
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
	static void mul_xi_1_iA(Unit *py, const Unit *px)
	{
		Fp2Dbl& y = castD(py);
		const Fp2Dbl& x = castD(px);
		FpDbl t;
		FpDbl::add(t, x.a, x.b);
		FpDbl::sub(y.a, x.a, x.b);
		y.b = t;
	}
	static void mul_xi_a_iA(Unit *py, const Unit *px)
	{
		const uint32_t xi_a = Fp2::get_xi_a();
		Fp2Dbl& y = castD(py);
		const Fp2Dbl& x = castD(px);
		FpDbl t;
		FpDbl::mulUnit(t, x.a, xi_a);
		FpDbl::sub(t, t, x.b);
		FpDbl::mulUnit(y.b, x.b, xi_a);
		FpDbl::add(y.b, y.b, x.a);
		y.a = t;
	}
	/*
		for u != 1
		(a + bi)(c + di) = (ac-bd u) + ((a+b)(c+d)-ac-bd)i
	*/
	template<bool isFullBit>
	static void mulPreAu(Unit *pz, const Unit *px, const Unit *py)
	{
		Fp2Dbl& z = castD(pz);
		const Fp2& x = cast(px);
		const Fp2& y = cast(py);
		const Fp& a = x.a;
		const Fp& b = x.b;
		const Fp& c = y.a;
		const Fp& d = y.b;
		FpDbl& d0 = z.a;
		FpDbl& d1 = z.b;
		FpDbl d2;
		Fp s, t;
		if (isFullBit) {
			Fp::add(s, a, b);
			Fp::add(t, c, d);
		} else {
			Fp::addPre(s, a, b);
			Fp::addPre(t, c, d);
		}
		FpDbl::mulPre(d1, s, t); // (a + b)(c + d)
		FpDbl::mulPre(d0, a, c);
		FpDbl::mulPre(d2, b, d);
		if (isFullBit) {
			FpDbl::sub(d1, d1, d0);
			FpDbl::sub(d1, d1, d2);
		} else {
			FpDbl::subPre(d1, d1, d0);
			FpDbl::subPre(d1, d1, d2);
		}
		uint32_t u = Fp::getOp().u;
		mcl::fp::mulSmallUnit(d2, d2, u);
		FpDbl::sub(d0, d0, d2); // ac - bd u
	}
	// (a + bi)^2 = (a^2 - b^2 u) + 2ab i = ((a-b)(a+u b) - a (u-1)b) + a 2b i
	static void sqrPreAu5(Unit *py, const Unit *px)
	{
		Fp2Dbl& y = castD(py);
		const Fp2& x = cast(px);
		assert(Fp::getOp().u == 5);
		Fp t1, t2, t3;
		Fp::mul2(t1, x.b); // 2b
		FpDbl::mulPre(y.b, x.a, t1); // 2ab
		Fp::mul2(t1, t1); // 4b
		Fp::add(t1, t1, x.b); // 5b
		Fp::add(t1, t1, x.a); // a+5b
		Fp::sub(t2, x.a, x.b); // a-b
		FpDbl::mulPre(y.a, t1, t2); // (a-b)(a+5b)
		FpDbl::sub(y.a, y.a, y.b);
		FpDbl::sub(y.a, y.a, y.b); // (a-b)(a+5b)-4ab
	}
	static void mulu_xi_0_iA(Unit *py, const Unit *px)
	{
		Fp2Dbl& y = castD(py);
		const Fp2Dbl& x = castD(px);
		uint32_t u = Fp::getOp().u;
		FpDbl t;
		mcl::fp::mulSmallUnit(t, x.b, u);
		y.b = x.a;
		FpDbl::neg(y.a, t);
	}
};

/*
	Fp6 = Fp2[v] / (v^3 - xi)
	x = a + b v + c v^2
*/
struct Fp6 : public fp::Serializable<Fp6, fp::Operator<Fp6> > {
	typedef Fp BaseFp;
	Fp2 a, b, c;
	Fp6() { }
	Fp6(int64_t a) : a(a) , b(0) , c(0) { }
	Fp6(const Fp2& a, const Fp2& b, const Fp2& c) : a(a) , b(b) , c(c) { }
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
	bool operator==(const Fp6& rhs) const
	{
		return a == rhs.a && b == rhs.b && c == rhs.c;
	}
	bool operator!=(const Fp6& rhs) const { return !operator==(rhs); }
	template<class InputStream>
	void load(bool *pb, InputStream& is, int ioMode)
	{
		a.load(pb, is, ioMode); if (!*pb) return;
		b.load(pb, is, ioMode); if (!*pb) return;
		c.load(pb, is, ioMode); if (!*pb) return;
	}
	template<class OutputStream>
	void save(bool *pb, OutputStream& os, int ioMode) const
	{
		const char sep = *fp::getIoSeparator(ioMode);
		a.save(pb, os, ioMode); if (!*pb) return;
		if (sep) {
			cybozu::writeChar(pb, os, sep);
			if (!*pb) return;
		}
		b.save(pb, os, ioMode); if (!*pb) return;
		if (sep) {
			cybozu::writeChar(pb, os, sep);
			if (!*pb) return;
		}
		c.save(pb, os, ioMode);
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		bool b;
		load(&b, is, ioMode);
		if (!b) throw cybozu::Exception("Fp6:load");
	}
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		bool b;
		save(&b, os, ioMode);
		if (!b) throw cybozu::Exception("Fp6:save");
	}
#endif
#ifndef CYBOZU_DONT_USE_STRING
	friend std::istream& operator>>(std::istream& is, Fp6& self)
	{
		self.load(is, fp::detectIoMode(Fp::BaseFp::getIoMode(), is));
		return is;
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp6& self)
	{
		self.save(os, fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
		return os;
	}
#endif
	static void add(Fp6& z, const Fp6& x, const Fp6& y)
	{
		Fp2::add(z.a, x.a, y.a);
		Fp2::add(z.b, x.b, y.b);
		Fp2::add(z.c, x.c, y.c);
	}
	static void sub(Fp6& z, const Fp6& x, const Fp6& y)
	{
		Fp2::sub(z.a, x.a, y.a);
		Fp2::sub(z.b, x.b, y.b);
		Fp2::sub(z.c, x.c, y.c);
	}
	static void neg(Fp6& y, const Fp6& x)
	{
		Fp2::neg(y.a, x.a);
		Fp2::neg(y.b, x.b);
		Fp2::neg(y.c, x.c);
	}
	static void mul2(Fp6& y, const Fp6& x)
	{
		Fp2::mul2(y.a, x.a);
		Fp2::mul2(y.b, x.b);
		Fp2::mul2(y.c, x.c);
	}
	static void sqr(Fp6& y, const Fp6& x);
	static void mul(Fp6& z, const Fp6& x, const Fp6& y);
	static void inv(Fp6& y, const Fp6& x);
};

struct Fp6Dbl {
	Fp2Dbl a, b, c;
	static void add(Fp6Dbl& z, const Fp6Dbl& x, const Fp6Dbl& y)
	{
		Fp2Dbl::add(z.a, x.a, y.a);
		Fp2Dbl::add(z.b, x.b, y.b);
		Fp2Dbl::add(z.c, x.c, y.c);
	}
	static void sub(Fp6Dbl& z, const Fp6Dbl& x, const Fp6Dbl& y)
	{
		Fp2Dbl::sub(z.a, x.a, y.a);
		Fp2Dbl::sub(z.b, x.b, y.b);
		Fp2Dbl::sub(z.c, x.c, y.c);
	}
	static void (*mulPre)(Fp6Dbl& z, const Fp6& x, const Fp6& y);
	/*
		x = a + bv + cv^2, y = d + ev + fv^2, v^3 = xi
		xy = (ad + (bf + ce)xi) + ((ae + bd) + cf xi)v + ((af + cd) + be)v^2
		bf + ce = (b + c)(e + f) - be - cf
		ae + bd = (a + b)(e + d) - ad - be
		af + cd = (a + c)(d + f) - ad - cf
		assum p < W/4 where W = 1 << (sizeof(Unit) * 8 * N)
		then (b + c)(e + f) < 4p^2 < pW
	*/
	template<bool isLtQuad>
	static void mulPreT(Fp6Dbl& z, const Fp6& x, const Fp6& y)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		const Fp2& d = y.a;
		const Fp2& e = y.b;
		const Fp2& f = y.c;
		Fp2Dbl& ZA = z.a;
		Fp2Dbl& ZB = z.b;
		Fp2Dbl& ZC = z.c;
		Fp2 t1, t2;
		Fp2Dbl BE, CF, AD;
		if (isLtQuad) {
			Fp2::addPre(t1, b, c);
			Fp2::addPre(t2, e, f);
		} else {
			Fp2::add(t1, b, c);
			Fp2::add(t2, e, f);
		}
		Fp2Dbl::mulPre(ZA, t1, t2);
		if (isLtQuad) {
			Fp2::addPre(t1, a, b);
			Fp2::addPre(t2, e, d);
		} else {
			Fp2::add(t1, a, b);
			Fp2::add(t2, e, d);
		}
		Fp2Dbl::mulPre(ZB, t1, t2);
		if (isLtQuad) {
			Fp2::addPre(t1, a, c);
			Fp2::addPre(t2, d, f);
		} else {
			Fp2::add(t1, a, c);
			Fp2::add(t2, d, f);
		}
		Fp2Dbl::mulPre(ZC, t1, t2);
		Fp2Dbl::mulPre(BE, b, e);
		Fp2Dbl::mulPre(CF, c, f);
		Fp2Dbl::mulPre(AD, a, d);
		Fp2Dbl::template subSpecial<isLtQuad>(ZA, BE);
		Fp2Dbl::template subSpecial<isLtQuad>(ZA, CF);
		Fp2Dbl::template subSpecial<isLtQuad>(ZB, AD);
		Fp2Dbl::template subSpecial<isLtQuad>(ZB, BE);
		Fp2Dbl::template subSpecial<isLtQuad>(ZC, AD);
		Fp2Dbl::template subSpecial<isLtQuad>(ZC, CF);
		Fp2Dbl::mul_xi(ZA, ZA);
		Fp2Dbl::add(ZA, ZA, AD);
		Fp2Dbl::mul_xi(CF, CF);
		Fp2Dbl::add(ZB, ZB, CF);
		Fp2Dbl::add(ZC, ZC, BE);
	}
	/*
		x = a + bv + cv^2, v^3 = xi
		x^2 = (a^2 + 2bc xi) + (c^2 xi + 2ab)v + (b^2 + 2ac)v^2

		b^2 + 2ac = (a + b + c)^2 - a^2 - 2bc - c^2 - 2ab
	*/
	static void sqrPre(Fp6Dbl& y, const Fp6& x)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		Fp2 t;
		Fp2Dbl BC2, AB2, AA, CC, T;
		Fp2::mul2(t, b);
		Fp2Dbl::mulPre(BC2, t, c); // 2bc
		Fp2Dbl::mulPre(AB2, t, a); // 2ab
		Fp2Dbl::sqrPre(AA, a);
		Fp2Dbl::sqrPre(CC, c);
		Fp2::add(t, a, b);
		Fp2::add(t, t, c);
		Fp2Dbl::sqrPre(T, t); // (a + b + c)^2
		Fp2Dbl::sub(T, T, AA);
		Fp2Dbl::sub(T, T, BC2);
		Fp2Dbl::sub(T, T, CC);
		Fp2Dbl::sub(y.c, T, AB2);
		Fp2Dbl::mul_xi(BC2, BC2);
		Fp2Dbl::add(y.a, AA, BC2);
		Fp2Dbl::mul_xi(CC, CC);
		Fp2Dbl::add(y.b, CC, AB2);
	}
	static void mod(Fp6& y, const Fp6Dbl& x)
	{
		Fp2Dbl::mod(y.a, x.a);
		Fp2Dbl::mod(y.b, x.b);
		Fp2Dbl::mod(y.c, x.c);
	}
	static void init()
	{
		const mcl::fp::Op& op = Fp::getOp();
		if (op.isLtQuad) {
			mulPre = mulPreT<true>;
		} else {
			mulPre = mulPreT<false>;
		}
	}
};

/*
	Fp12 = Fp6[w] / (w^2 - v)
	x = a + b w
*/
struct Fp12 : public fp::Serializable<Fp12, fp::Operator<Fp12> > {
	typedef fp::Serializable<Fp12, fp::Operator<Fp12> > BaseClass;

	typedef Fp BaseFp;
	Fp6 a, b;
	Fp12() {}
	Fp12(int64_t a) : a(a), b(0) {}
	Fp12(const Fp6& a, const Fp6& b) : a(a), b(b) {}
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
	bool operator==(const Fp12& rhs) const
	{
		return a == rhs.a && b == rhs.b;
	}
	bool operator!=(const Fp12& rhs) const { return !operator==(rhs); }
	static void add(Fp12& z, const Fp12& x, const Fp12& y)
	{
		Fp6::add(z.a, x.a, y.a);
		Fp6::add(z.b, x.b, y.b);
	}
	static void sub(Fp12& z, const Fp12& x, const Fp12& y)
	{
		Fp6::sub(z.a, x.a, y.a);
		Fp6::sub(z.b, x.b, y.b);
	}
	static void neg(Fp12& z, const Fp12& x)
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
	static void mulVadd(Fp6Dbl& z, const Fp6Dbl& x, const Fp6Dbl& y)
	{
		Fp2Dbl t;
		Fp2Dbl::mul_xi(t, x.c);
		Fp2Dbl::add(z.c, x.b, y.c);
		Fp2Dbl::add(z.b, x.a, y.b);
		Fp2Dbl::add(z.a, t, y.a);
	}
	/*
		x = a + bw, y = c + dw, w^2 = v
		z = xy = (a + bw)(c + dw) = (ac + bdv) + (ad + bc)w
		ad+bc = (a + b)(c + d) - ac - bd

		in Fp6 : (a + bv + cv^2)v = cv^3 + av + bv^2 = cxi + av + bv^2
	*/
	static void mul(Fp12& z, const Fp12& x, const Fp12& y)
	{
		// 4.7Kclk -> 4.55Kclk
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		const Fp6& c = y.a;
		const Fp6& d = y.b;
		Fp6 t1, t2;
		Fp6::add(t1, a, b);
		Fp6::add(t2, c, d);
		Fp6Dbl T, AC, BD;
		Fp6Dbl::mulPre(AC, a, c);
		Fp6Dbl::mulPre(BD, b, d);
		mulVadd(T, BD, AC);
		Fp6Dbl::mod(z.a, T);
		Fp6Dbl::mulPre(T, t1, t2); // (a + b)(c + d)
		Fp6Dbl::sub(T, T, AC);
		Fp6Dbl::sub(T, T, BD);
		Fp6Dbl::mod(z.b, T);
	}
	/*
		x = a + bw, w^2 = v
		y = x^2 = (a + bw)^2 = (a^2 + b^2v) + 2abw
		a^2 + b^2v = (a + b)(bv + a) - (abv + ab)
	*/
	static void sqr(Fp12& y, const Fp12& x)
	{
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		Fp6 t0, t1;
		Fp6::add(t0, a, b); // a + b
		mulVadd(t1, b, a); // bv + a
		t0 *= t1; // (a + b)(bv + a)
		Fp6::mul(t1, a, b); // ab
		Fp6::mul2(y.b, t1); // 2ab
		mulVadd(y.a, t1, t1); // abv + ab
		Fp6::sub(y.a, t0, y.a);
	}
	/*
		x = a + bw, w^2 = v
		y = 1/x = (a - bw) / (a^2 - b^2v)
	*/
	static void inv(Fp12& y, const Fp12& x)
	{
		const Fp6& a = x.a;
		const Fp6& b = x.b;
		Fp6Dbl AA, BB;
		Fp6Dbl::sqrPre(AA, a);
		Fp6Dbl::sqrPre(BB, b);
		Fp2Dbl::mul_xi(BB.c, BB.c);
		Fp2Dbl::sub(AA.a, AA.a, BB.c);
		Fp2Dbl::sub(AA.b, AA.b, BB.a);
		Fp2Dbl::sub(AA.c, AA.c, BB.b); // a^2 - b^2 v
		Fp6 t;
		Fp6Dbl::mod(t, AA);
		Fp6::inv(t, t);
		Fp6::mul(y.a, x.a, t);
		Fp6::mul(y.b, x.b, t);
		Fp6::neg(y.b, y.b);
	}
	/*
		y = 1 / x = conjugate of x if |x| = 1
	*/
	static void unitaryInv(Fp12& y, const Fp12& x)
	{
		if (&y != &x) y.a = x.a;
		Fp6::neg(y.b, x.b);
	}
	/*
		Frobenius
		i^2 = -u
		(a + bi)^p = a + bi^p in Fp
		= a + bi c if p = 1 mod 4
		= a - bi c if p = 3 mod 4 where c = u^((p-1)/2)

		g = xi^(p - 1) / 6
		v^3 = xi in Fp2
		v^p = ((v^6) ^ (p-1)/6) v = g^2 v
		v^2p = g^4 v^2
		(a + bv + cv^2)^p in Fp6
		= F(a) + F(b)g^2 v + F(c) g^4 v^2

		w^p = ((w^6) ^ (p-1)/6) w = g w
		((a + bv + cv^2)w)^p in Fp12
		= (F(a) g + F(b) g^3 v + F(c) g^5 v^2)w
	*/
	static void Frobenius(Fp12& y, const Fp12& x)
	{
		for (int i = 0; i < 6; i++) {
			Fp2::Frobenius(y.getFp2()[i], x.getFp2()[i]);
		}
		for (int i = 1; i < 6; i++) {
			y.getFp2()[i] *= Fp2::get_gTbl()[i - 1];
		}
	}
	static void Frobenius2(Fp12& y, const Fp12& x)
	{
#if 0
		Frobenius(y, x);
		Frobenius(y, y);
#else
		y.getFp2()[0] = x.getFp2()[0];
		if (Fp::getOp().pmod4 == 1 && Fp::getOp().u == 1) {
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
	static void Frobenius3(Fp12& y, const Fp12& x)
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
	template<class InputStream>
	void load(bool *pb, InputStream& is, int ioMode)
	{
		a.load(pb, is, ioMode); if (!*pb) return;
		b.load(pb, is, ioMode);
	}
	template<class OutputStream>
	void save(bool *pb, OutputStream& os, int ioMode) const
	{
		const char sep = *fp::getIoSeparator(ioMode);
		a.save(pb, os, ioMode); if (!*pb) return;
		if (sep) {
			cybozu::writeChar(pb, os, sep);
			if (!*pb) return;
		}
		b.save(pb, os, ioMode);
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		bool b;
		load(&b, is, ioMode);
		if (!b) throw cybozu::Exception("Fp12:load");
	}
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		bool b;
		save(&b, os, ioMode);
		if (!b) throw cybozu::Exception("Fp12:save");
	}
#endif
#ifndef CYBOZU_DONT_USE_STRING
	friend std::istream& operator>>(std::istream& is, Fp12& self)
	{
		self.load(is, fp::detectIoMode(Fp::BaseFp::getIoMode(), is));
		return is;
	}
	friend std::ostream& operator<<(std::ostream& os, const Fp12& self)
	{
		self.save(os, fp::detectIoMode(Fp::BaseFp::getIoMode(), os));
		return os;
	}
#endif
	static void setPowVecGLV(bool f(Fp12& z, const Fp12 *xVec, const void *yVec, size_t yn) = 0)
	{
		BaseClass::powVecGLV = f;
	}
	static inline void powVec(Fp12& z, const Fp12 *xVec, const Fr *yVec, size_t n)
	{
		if (n == 0) {
			z.clear();
			return;
		}
		if (BaseClass::powVecGLV && BaseClass::powVecGLV(z, xVec, yVec, n)) {
			return;
		}
		size_t done = powVecN(z, xVec, yVec, n);
		for (;;) {
			xVec += done;
			yVec += done;
			n -= done;
			if (n == 0) break;
			Fp12 t;
			done = powVecN(t, xVec, yVec, n);
			z *= t;
		}
	}
private:
	template<class G, class Vec>
	static void mulTbl(G& Q, const G *tbl, const Vec& naf, size_t i)
	{
		if (i >= naf.size()) return;
		int n = naf[i];
		if (n > 0) {
			Q *= tbl[(n - 1) >> 1];
		} else if (n < 0) {
//			Q -= tbl[(-n - 1) >> 1];
			G inv;
			G::unitaryInv(inv, tbl[(-n - 1) >> 1]);
			Q *= inv;
		}
	}

	template<class _F>
	static inline size_t powVecN(Fp12& z, const Fp12 *xVec, const _F *yVec, size_t n)
	{
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4459)
#endif
		const size_t N = mcl::fp::maxMulVecN;
#ifdef _MSC_VER
	#pragma warning(pop)
#endif
		if (n > N) n = N;
		const int w = 5;
		const size_t tblSize = 1 << (w - 2);
		typedef mcl::FixedArray<int8_t, sizeof(Fp12::BaseFp) * 8 + 1> NafArray;
		NafArray naf[N];
		Fp12 tbl[N][tblSize];
		size_t maxBit = 0;
		mpz_class y;
		for (size_t i = 0; i < n; i++) {
			bool b;
			yVec[i].getMpz(&b, y);
			assert(b); (void)b;
			gmp::getNAFwidth(&b, naf[i], y, w);
			assert(b); (void)b;
			if (naf[i].size() > maxBit) maxBit = naf[i].size();
			Fp12 P2;
			Fp12::sqr(P2, xVec[i]);
			tbl[i][0] = xVec[i];
			for (size_t j = 1; j < tblSize; j++) {
				Fp12::mul(tbl[i][j], tbl[i][j - 1], P2);
			}
		}
		z = 1;
		for (size_t i = 0; i < maxBit; i++) {
			Fp12::sqr(z, z);
			for (size_t j = 0; j < n; j++) {
				mulTbl(z, tbl[j], naf[j], maxBit - 1 - i);
			}
		}
		return n;
	}
};

/*
	convert multiplicative group to additive group
*/
template<class T>
struct GroupMtoA : public T {
	static T& castT(GroupMtoA& x) { return static_cast<T&>(x); }
	static const T& castT(const GroupMtoA& x) { return static_cast<const T&>(x); }
	void clear()
	{
		castT(*this) = 1;
	}
	bool isZero() const { return castT(*this).isOne(); }
	static void add(GroupMtoA& z, const GroupMtoA& x, const GroupMtoA& y)
	{
		T::mul(castT(z), castT(x), castT(y));
	}
	static void sub(GroupMtoA& z, const GroupMtoA& x, const GroupMtoA& y)
	{
		T r;
		T::unitaryInv(r, castT(y));
		T::mul(castT(z), castT(x), r);
	}
	static void dbl(GroupMtoA& y, const GroupMtoA& x)
	{
		T::sqr(castT(y), castT(x));
	}
	static void neg(GroupMtoA& y, const GroupMtoA& x)
	{
		// assume Fp12
		T::unitaryInv(castT(y), castT(x));
	}
	static void Frobenus(GroupMtoA& y, const GroupMtoA& x)
	{
		T::Frobenius(castT(y), castT(x));
	}
	template<class INT>
	static void mul(GroupMtoA& z, const GroupMtoA& x, const INT& y)
	{
		T::pow(castT(z), castT(x), y);
	}
	template<class INT>
	static void mulGeneric(GroupMtoA& z, const GroupMtoA& x, const INT& y)
	{
		T::powGeneric(castT(z), castT(x), y);
	}
	void operator+=(const GroupMtoA& rhs)
	{
		add(*this, *this, rhs);
	}
	void operator-=(const GroupMtoA& rhs)
	{
		sub(*this, *this, rhs);
	}
	void normalize() {}
	static void normalizeVec(GroupMtoA *y, const GroupMtoA *x, size_t n)
	{
		if (y == x) return;
		for (size_t i = 0; i < n; i++) y[i] = x[i];
	}
	static void mulArray(GroupMtoA& z, const GroupMtoA& x, const Unit *y, size_t yn)
	{
		T::powArray(z, x, y, yn);
	}
private:
	bool isOne() const;
};

inline void Frobenius(Fp2& y, const Fp2& x)
{
	Fp2::Frobenius(y, x);
}

inline void Frobenius(Fp12& y, const Fp12& x)
{
	Fp12::Frobenius(y, x);
}

} // mcl

