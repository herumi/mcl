#pragma once
/**
	@file
	@brief elliptic curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <sstream>
#include <stdlib.h>
#include <cybozu/exception.hpp>
#include <mcl/op.hpp>
#include <mcl/util.hpp>

//#define MCL_EC_USE_AFFINE

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4458)
#endif

namespace mcl {

namespace ec {

enum Mode {
	Jacobi,
	Proj
};

} // mcl::ecl

/*
	elliptic curve
	y^2 = x^3 + ax + b (affine)
	y^2 = x^3 + az^4 + bz^6 (Jacobi) x = X/Z^2, y = Y/Z^3
*/
template<class _Fp>
class EcT {
	enum {
		zero,
		minus3,
		generic
	};
public:
	typedef _Fp Fp;
#ifdef MCL_EC_USE_AFFINE
	Fp x, y;
	bool inf_;
#else
	mutable Fp x, y, z;
	static int mode_;
#endif
	static Fp a_;
	static Fp b_;
	static int specialA_;
	static bool compressedExpression_;
#ifdef MCL_EC_USE_AFFINE
	EcT() : inf_(true) {}
#else
	EcT() { z.clear(); }
#endif
	EcT(const Fp& _x, const Fp& _y)
	{
		set(_x, _y);
	}
	bool isNormalized() const
	{
#ifdef MCL_EC_USE_AFFINE
		return true;
#else
		return isZero() || z.isOne();
#endif
	}
#ifndef MCL_EC_USE_AFFINE
private:
	void normalizeJacobi() const
	{
		assert(!z.isZero());
		Fp rz2;
		Fp::inv(z, z);
		Fp::sqr(rz2, z);
		x *= rz2;
		y *= rz2;
		y *= z;
		z = 1;
	}
	void normalizeProj() const
	{
		assert(!z.isZero());
		Fp::inv(z, z);
		x *= z;
		y *= z;
		z = 1;
	}
	// Y^2 == X(X^2 + aZ^4) + bZ^6
	bool isValidJacobi() const
	{
		Fp y2, x2, z2, z4, t;
		Fp::sqr(x2, x);
		Fp::sqr(y2, y);
		Fp::sqr(z2, z);
		Fp::sqr(z4, z2);
		Fp::mul(t, z4, a_);
		t += x2;
		t *= x;
		z4 *= z2;
		z4 *= b_;
		t += z4;
		return y2 == t;
	}
	// (Y^2 - bZ^2)Z = X(X^2 + aZ^2)
	bool isValidProj() const
	{
		Fp y2, x2, z2, t;
		Fp::sqr(x2, x);
		Fp::sqr(y2, y);
		Fp::sqr(z2, z);
		Fp::mul(t, a_, z2);
		t += x2;
		t *= x;
		z2 *= b_;
		y2 -= z2;
		y2 *= z;
		return y2 == t;
	}
public:
#endif
	void normalize() const
	{
#ifndef MCL_EC_USE_AFFINE
		if (isNormalized()) return;
		switch (mode_) {
		case ec::Jacobi:
			normalizeJacobi();
			break;
		case ec::Proj:
			normalizeProj();
			break;
		}
#endif
	}
	static inline void init(const Fp& a, const Fp& b, int mode = ec::Jacobi)
	{
		a_ = a;
		b_ = b;
		if (a_.isZero()) {
			specialA_ = zero;
		} else if (a_ == -3) {
			specialA_ = minus3;
		} else {
			specialA_ = generic;
		}
#ifdef MCL_EC_USE_AFFINE
		cybozu::disable_warning_unused_variable(mode);
#else
		switch (mode) {
		case ec::Jacobi:
		case ec::Proj:
			mode_ = mode;
			break;
		default:
			throw cybozu::Exception("ec:EcT:init:bad mode") << mode;
		}
#endif
	}
	// backward compatilibity
	static inline void setParam(const std::string& astr, const std::string& bstr, int mode = ec::Jacobi)
	{
		init(astr, bstr, mode);
	}
	static inline void init(const std::string& astr, const std::string& bstr, int mode = ec::Jacobi)
	{
		init(Fp(astr), Fp(bstr), mode);
	}
	// y^2 == (x^2 + a)x + b
	static inline bool isValid(const Fp& _x, const Fp& _y)
	{
		Fp y2, t;
		Fp::sqr(y2, _y);
		Fp::sqr(t, _x);
		t += a_;
		t *= _x;
		t += b_;
		return y2 == t;
	}
	bool isValid() const
	{
		if (isZero()) return true;
#ifndef MCL_EC_USE_AFFINE
		if (!z.isOne()) {
			switch (mode_) {
			case ec::Jacobi:
				return isValidJacobi();
			case ec::Proj:
				return isValidProj();
			}
		}
#endif
		return isValid(x, y);
	}
	void set(const Fp& _x, const Fp& _y, bool verify = true)
	{
		if (verify && !isValid(_x, _y)) throw cybozu::Exception("ec:EcT:set") << _x << _y;
		x = _x; y = _y;
#ifdef MCL_EC_USE_AFFINE
		inf_ = false;
#else
		z = 1;
#endif
	}
	void clear()
	{
#ifdef MCL_EC_USE_AFFINE
		inf_ = true;
#else
		z.clear();
#endif
		x.clear();
		y.clear();
	}
#ifndef MCL_EC_USE_AFFINE
	static inline void dblNoVerifyInfJacobi(EcT& R, const EcT& P)
	{
		Fp S, M, t, y2;
		Fp::sqr(y2, P.y);
		Fp::mul(S, P.x, y2);
		const bool isPzOne = P.z.isOne();
		S += S;
		S += S;
		Fp::sqr(M, P.x);
		switch (specialA_) {
		case zero:
			Fp::add(t, M, M);
			M += t;
			break;
		case minus3:
			if (isPzOne) {
				M -= P.z;
			} else {
				Fp::sqr(t, P.z);
				Fp::sqr(t, t);
				M -= t;
			}
			Fp::add(t, M, M);
			M += t;
			break;
		case generic:
		default:
			if (isPzOne) {
				t = a_;
			} else {
				Fp::sqr(t, P.z);
				Fp::sqr(t, t);
				t *= a_;
			}
			t += M;
			M += M;
			M += t;
			break;
		}
		Fp::sqr(R.x, M);
		R.x -= S;
		R.x -= S;
		if (isPzOne) {
			R.z = P.y;
		} else {
			Fp::mul(R.z, P.y, P.z);
		}
		R.z += R.z;
		Fp::sqr(y2, y2);
		y2 += y2;
		y2 += y2;
		y2 += y2;
		Fp::sub(R.y, S, R.x);
		R.y *= M;
		R.y -= y2;
	}
	static inline void dblNoVerifyInfProj(EcT& R, const EcT& P)
	{
		const bool isPzOne = P.z.isOne();
		Fp w, t, h;
		switch (specialA_) {
		case zero:
			Fp::sqr(w, P.x);
			Fp::add(t, w, w);
			w += t;
			break;
		case minus3:
			Fp::sqr(w, P.x);
			if (isPzOne) {
				w -= P.z;
			} else {
				Fp::sqr(t, P.z);
				w -= t;
			}
			Fp::add(t, w, w);
			w += t;
			break;
		case generic:
		default:
			if (isPzOne) {
				w = a_;
			} else {
				Fp::sqr(w, P.z);
				w *= a_;
			}
			Fp::sqr(t, P.x);
			w += t;
			w += t;
			w += t; // w = a z^2 + 3x^2
			break;
		}
		if (isPzOne) {
			R.z = P.y;
		} else {
			Fp::mul(R.z, P.y, P.z); // s = yz
		}
		Fp::mul(t, R.z, P.x);
		t *= P.y; // xys
		t += t;
		t += t; // 4(xys) ; 4B
		Fp::sqr(h, w);
		h -= t;
		h -= t; // w^2 - 8B
		Fp::mul(R.x, h, R.z);
		t -= h; // h is free
		t *= w;
		Fp::sqr(w, P.y);
		R.x += R.x;
		R.z += R.z;
		Fp::sqr(h, R.z);
		w *= h;
		R.z *= h;
		Fp::sub(R.y, t, w);
		R.y -= w;
	}
#endif
	static inline void dblNoVerifyInf(EcT& R, const EcT& P)
	{
#ifdef MCL_EC_USE_AFFINE
		Fp t, s;
		Fp::sqr(t, P.x);
		Fp::add(s, t, t);
		t += s;
		t += a_;
		Fp::add(s, P.y, P.y);
		t /= s;
		Fp::sqr(s, t);
		s -= P.x;
		Fp x3;
		Fp::sub(x3, s, P.x);
		Fp::sub(s, P.x, x3);
		s *= t;
		Fp::sub(R.y, s, P.y);
		R.x = x3;
		R.inf_ = false;
#else
		switch (mode_) {
		case ec::Jacobi:
			dblNoVerifyInfJacobi(R, P);
			break;
		case ec::Proj:
			dblNoVerifyInfProj(R, P);
			break;
		}
#endif
	}
	static inline void dbl(EcT& R, const EcT& P)
	{
		if (P.isZero()) {
			R.clear();
			return;
		}
		dblNoVerifyInf(R, P);
	}
#ifndef MCL_EC_USE_AFFINE
	static inline void addJacobi(EcT& R, const EcT& P, const EcT& Q)
	{
		const bool isQzOne = Q.z.isOne();
		Fp r, U1, S1, H, H3;
		Fp::sqr(r, P.z);
		if (isQzOne) {
			U1 = P.x;
			Fp::mul(H, Q.x, r);
			H -= U1;
			r *= P.z;
			S1 = P.y;
		} else {
			Fp::sqr(S1, Q.z);
			Fp::mul(U1, P.x, S1);
			Fp::mul(H, Q.x, r);
			H -= U1;
			r *= P.z;
			S1 *= Q.z;
			S1 *= P.y;
		}
		r *= Q.y;
		r -= S1;
		if (H.isZero()) {
			if (r.isZero()) {
				dblNoVerifyInf(R, P);
			} else {
				R.clear();
			}
			return;
		}
		if (isQzOne) {
			Fp::mul(R.z, P.z, H);
		} else {
			Fp::mul(R.z, P.z, Q.z);
			R.z *= H;
		}
		Fp::sqr(H3, H); // H^2
		Fp::sqr(R.y, r); // r^2
		U1 *= H3; // U1 H^2
		H3 *= H; // H^3
		R.y -= U1;
		R.y -= U1;
		Fp::sub(R.x, R.y, H3);
		U1 -= R.x;
		U1 *= r;
		H3 *= S1;
		Fp::sub(R.y, U1, H3);
	}
	static inline void addProj(EcT& R, const EcT& P, const EcT& Q)
	{
		const bool isQzOne = Q.z.isOne();
		Fp r, PyQz, v, A, vv;
		if (isQzOne) {
			r = P.x;
			PyQz = P.y;
		} else {
			Fp::mul(r, P.x, Q.z);
			Fp::mul(PyQz, P.y, Q.z);
		}
		Fp::mul(A, Q.y, P.z);
		Fp::mul(v, Q.x, P.z);
		v -= r;
		if (v.isZero()) {
			if (A == PyQz) {
				dblNoVerifyInf(R, P);
			} else {
				R.clear();
			}
			return;
		}
		Fp::sub(R.y, A, PyQz);
		Fp::sqr(A, R.y);
		Fp::sqr(vv, v);
		r *= vv;
		vv *= v;
		if (isQzOne) {
			R.z = P.z;
		} else {
			Fp::mul(R.z, P.z, Q.z);
		}
		A *= R.z;
		R.z *= vv;
		A -= vv;
		vv *= PyQz;
		A -= r;
		A -= r;
		Fp::mul(R.x, v, A);
		r -= A;
		R.y *= r;
		R.y -= vv;
	}
#endif
	static inline void add(EcT& R, const EcT& P0, const EcT& Q0)
	{
		if (P0.isZero()) { R = Q0; return; }
		if (Q0.isZero()) { R = P0; return; }
		if (&P0 == &Q0) {
			dblNoVerifyInf(R, P0);
			return;
		}
#ifdef MCL_EC_USE_AFFINE
		const EcT& P(P0);
		const EcT& Q(Q0);
		Fp t;
		Fp::neg(t, Q.y);
		if (P.y == t) { R.clear(); return; }
		Fp::sub(t, Q.x, P.x);
		if (t.isZero()) {
			dblNoVerifyInf(R, P);
			return;
		}
		Fp s;
		Fp::sub(s, Q.y, P.y);
		Fp::div(t, s, t);
		R.inf_ = false;
		Fp x3;
		Fp::sqr(x3, t);
		x3 -= P.x;
		x3 -= Q.x;
		Fp::sub(s, P.x, x3);
		s *= t;
		Fp::sub(R.y, s, P.y);
		R.x = x3;
#else
		const EcT *pP = &P0;
		const EcT *pQ = &Q0;
		if (pP->z.isOne()) {
			std::swap(pP, pQ);
		}
		const EcT& P(*pP);
		const EcT& Q(*pQ);
		switch (mode_) {
		case ec::Jacobi:
			addJacobi(R, P, Q);
			break;
		case ec::Proj:
			addProj(R, P, Q);
			break;
		}
#endif
	}
	static inline void sub(EcT& R, const EcT& P, const EcT& Q)
	{
		EcT nQ;
		neg(nQ, Q);
		add(R, P, nQ);
	}
	static inline void neg(EcT& R, const EcT& P)
	{
		if (P.isZero()) {
			R.clear();
			return;
		}
		R.x = P.x;
		Fp::neg(R.y, P.y);
#ifdef MCL_EC_USE_AFFINE
		R.inf_ = false;
#else
		R.z = P.z;
#endif
	}
	template<class tag, size_t maxBitSize, template<class _tag, size_t _maxBitSize>class FpT>
	static inline void mul(EcT& z, const EcT& x, const FpT<tag, maxBitSize>& y)
	{
		fp::Block b;
		y.getBlock(b);
		mulArray(z, x, b.p, b.n, false);
	}
	static inline void mul(EcT& z, const EcT& x, int y)
	{
		const fp::Unit u = abs(y);
		mulArray(z, x, &u, 1, y < 0);
	}
	static inline void mul(EcT& z, const EcT& x, const mpz_class& y)
	{
		mulArray(z, x, gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0);
	}
	/*
		0 <= P for any P
		(Px, Py) <= (P'x, P'y) iff Px < P'x or Px == P'x and Py <= P'y
	*/
	template<class F>
	static inline int compareFunc(const EcT& P, const EcT& Q, F comp)
	{
		P.normalize();
		Q.normalize();
		const bool QisZero = Q.isZero();
		if (P.isZero()) {
			if (QisZero) return 0;
			return -1;
		}
		if (QisZero) return 1;
		int c = comp(P.x, Q.x);
		if (c > 0) return 1;
		if (c < 0) return -1;
		return comp(P.y, Q.y);
	}
	static inline int compare(const EcT& P, const EcT& Q)
	{
		return compareFunc(P, Q, Fp::compare);
	}
	static inline int compareRaw(const EcT& P, const EcT& Q)
	{
		return compareFunc(P, Q, Fp::compareRaw);
	}
	bool isZero() const
	{
#ifdef MCL_EC_USE_AFFINE
		return inf_;
#else
		return z.isZero();
#endif
	}
	/*
		"0" ; infinity
		"1 <x> <y is odd ? 1 : 0>" ; compressed
		"2 <x> <y>" ; not compressed
	*/
	void getStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		if (isZero()) {
			str = '0';
			return;
		}
		normalize();
		if (compressedExpression_) {
			str = "1 ";
			str += x.getStr(base, withPrefix);
			const char *p = y.isOdd() ? " 1" : " 0";
			str += p;
		} else {
			str = "2 ";
			str += x.getStr(base, withPrefix);
			str += ' ';
			str += y.getStr(base, withPrefix);
		}
	}
	std::string getStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		getStr(str, base, withPrefix);
		return str;
	}
	friend inline std::ostream& operator<<(std::ostream& os, const EcT& self)
	{
		const std::ios_base::fmtflags f = os.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator<<:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 10;
		const bool withPrefix = (f & std::ios_base::showbase) != 0;
		return os << self.getStr(base, withPrefix);
	}
	friend inline std::istream& operator>>(std::istream& is, EcT& self)
	{
		std::string str;
		is >> str;
		if (str == "0") {
			self.clear();
			return is;
		}
#ifdef MCL_EC_USE_AFFINE
		self.inf_ = false;
#else
		self.z = 1;
#endif
		is >> self.x;
		if (str == "1") {
			is >> str;
			if (str == "0") {
				getYfromX(self.y, self.x, false);
			} else if (str == "1") {
				getYfromX(self.y, self.x, true);
			} else {
				throw cybozu::Exception("EcT:operator>>:bad y") << str;
			}
		} else if (str == "2") {
			is >> self.y;
			if (!isValid(self.x, self.y)) {
				throw cybozu::Exception("EcT:setStr:bad value") << self.x << self.y;
			}
		} else {
			throw cybozu::Exception("EcT:operator>>:bad format") << str;
		}
		return is;
	}
	void setStr(const std::string& str)
	{
		std::istringstream is(str);
		if (!(is >> *this)) {
			throw cybozu::Exception("EcT:setStr:bad str") << str;
		}
	}
	static inline void setCompressedExpression(bool compressedExpression = true)
	{
		compressedExpression_ = compressedExpression;
	}
	static inline void getWeierstrass(Fp& yy, const Fp& x)
	{
		Fp t;
		Fp::sqr(t, x);
		t += a_;
		t *= x;
		Fp::add(yy, t, b_);
	}
	static inline void getYfromX(Fp& y, const Fp& x, bool isYodd)
	{
		getWeierstrass(y, x);
		if (!Fp::squareRoot(y, y)) throw cybozu::Exception("EcT:getYfromX") << x << isYodd;
		if (y.isOdd() ^ isYodd) {
			Fp::neg(y, y);
		}
	}
	inline friend EcT operator+(const EcT& x, const EcT& y) { EcT z; add(z, x, y); return z; }
	inline friend EcT operator-(const EcT& x, const EcT& y) { EcT z; sub(z, x, y); return z; }
	EcT& operator+=(const EcT& x) { add(*this, *this, x); return *this; }
	EcT& operator-=(const EcT& x) { sub(*this, *this, x); return *this; }
	EcT operator-() const { EcT x; neg(x, *this); return x; }
	bool operator==(const EcT& rhs) const
	{
		EcT R;
		sub(R, *this, rhs); // QQQ : optimized later
		return R.isZero();
	}
	bool operator!=(const EcT& rhs) const { return !operator==(rhs); }
	bool operator<(const EcT& rhs) const
	{
		if (isZero()) {
			return !rhs.isZero();
		}
		if (rhs.isZero()) return false;
		normalize();
		rhs.normalize();
		int cmp = Fp::compare(x, rhs.x);
		if (cmp < 0) return true;
		if (cmp > 0) return false;
		return y < rhs.y;
	}
	bool operator>=(const EcT& rhs) const { return !operator<(rhs); }
	bool operator>(const EcT& rhs) const { return rhs < *this; }
	bool operator<=(const EcT& rhs) const { return !operator>(rhs); }
private:
	static inline void mulArray(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative)
	{
		x.normalize();
		EcT tmp;
		const EcT *px = &x;
		if (&z == &x) {
			tmp = x;
			px = &tmp;
		}
		z.clear();
		fp::powGeneric(z, *px, y, yn, EcT::add, EcT::dbl);
		if (isNegative) {
			neg(z, z);
		}
	}
};

template<class Fp> Fp EcT<Fp>::a_;
template<class Fp> Fp EcT<Fp>::b_;
template<class Fp> int EcT<Fp>::specialA_;
template<class Fp> bool EcT<Fp>::compressedExpression_;
#ifndef MCL_EC_USE_AFFINE
template<class Fp> int EcT<Fp>::mode_;
#endif

struct EcParam {
	const char *name;
	const char *p;
	const char *a;
	const char *b;
	const char *gx;
	const char *gy;
	const char *n;
	size_t bitSize; // bit length of p
};

} // mcl

#ifdef CYBOZU_USE_BOOST
namespace mcl {
template<class Fp>
size_t hash_value(const mcl::EcT<Fp>& P)
{
	if (P.isZero()) return 0;
	P.normalize();
	return mcl::hash_value(P.y, mcl::hash_value(P.x));
}

}
#else
namespace std { CYBOZU_NAMESPACE_TR1_BEGIN

template<class Fp>
struct hash<mcl::EcT<Fp> > {
	size_t operator()(const mcl::EcT<Fp>& P) const
	{
		if (P.isZero()) return 0;
		P.normalize();
		return hash<Fp>()(P.y, hash<Fp>()(P.x));
	}
};

CYBOZU_NAMESPACE_TR1_END } // std
#endif

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
