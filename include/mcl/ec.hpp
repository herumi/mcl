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
#ifndef MCL_EC_USE_AFFINE
	void normalizeJacobi() const
	{
		if (isZero() || z.isOne()) return;
		Fp rz, rz2;
		Fp::inv(rz, z);
		rz2 = rz * rz;
		x *= rz2;
		y *= rz2 * rz;
		z = 1;
	}
	void normalizeProj() const
	{
		if (isZero() || z.isOne()) return;
		Fp rz;
		Fp::inv(rz, z);
		x *= rz;
		y *= rz;
		z = 1;
	}
#endif
	void normalize() const
	{
#ifndef MCL_EC_USE_AFFINE
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
	static inline void setParam(const std::string& astr, const std::string& bstr, int mode = ec::Jacobi)
	{
		a_.setStr(astr);
		b_.setStr(bstr);
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
			throw cybozu::Exception("ec:EcT:setParam:bad mode") << mode;
		}
#endif
	}
	static inline bool isValid(const Fp& _x, const Fp& _y)
	{
		return _y * _y == (_x * _x + a_) * _x + b_;
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
	static inline void add(EcT& R, const EcT& _P, const EcT& _Q)
	{
		if (_P.isZero()) { R = _Q; return; }
		if (_Q.isZero()) { R = _P; return; }
		if (&_P == &_Q) {
			dblNoVerifyInf(R, _P);
			return;
		}
#ifdef MCL_EC_USE_AFFINE
		const EcT& P(_P);
		const EcT& Q(_Q);
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
		const EcT *pP = &_P;
		const EcT *pQ = &_Q;
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
		fp::powerGeneric(z, *px, y, yn, EcT::add, EcT::dbl);
		if (isNegative) {
			neg(z, z);
		}
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
		mulArray(z, x, Gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0);
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
	friend inline std::ostream& operator<<(std::ostream& os, const EcT& self)
	{
		if (self.isZero()) {
			return os << '0';
		} else {
			self.normalize();
			os << self.x.getStr(16) << '_';
			if (compressedExpression_) {
				return os << Fp::isOdd(self.y);
			} else {
				return os << self.y.getStr(16);
			}
		}
	}
	friend inline std::istream& operator>>(std::istream& is, EcT& self)
	{
		std::string str;
		is >> str;
		if (str == "0") {
			self.clear();
		} else {
#ifdef MCL_EC_USE_AFFINE
			self.inf_ = false;
#else
			self.z = 1;
#endif
			size_t pos = str.find('_');
			if (pos == std::string::npos) throw cybozu::Exception("EcT:operator>>:bad format") << str;
			str[pos] = '\0';
			self.x.setStr(&str[0], 16);
			if (compressedExpression_) {
				const char c = str[pos + 1];
				if ((c == '0' || c == '1') && str.size() == pos + 2) {
					getYfromX(self.y, self.x, c == '1');
				} else {
					str[pos] = '_';
					throw cybozu::Exception("EcT:operator>>:bad y") << str;
				}
			} else {
				self.y.setStr(&str[pos + 1], 16);
			}
		}
		return is;
	}
	static inline void setCompressedExpression(bool compressedExpression)
	{
		compressedExpression_ = compressedExpression;
	}
	static inline void getYfromX(Fp& y, const Fp& x, bool isYodd)
	{
		Fp t;
		Fp::sqr(t, x);
		t += a_;
		t *= x;
		t += b_;
		Fp::sqrRoot(y, t);
		if (Fp::isOdd(y) ^ isYodd) {
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

namespace std { CYBOZU_NAMESPACE_TR1_BEGIN
template<class T> struct hash;

template<class Fp>
struct hash<mcl::EcT<Fp> > {
	size_t operator()(const mcl::EcT<Fp>& P) const
	{
		if (P.isZero()) return 0;
		P.normalize();
		uint64_t v = hash<Fp>()(P.x);
		v = hash<Fp>()(P.y, v);
		return static_cast<size_t>(v);
	}
};

CYBOZU_NAMESPACE_TR1_END } // std
