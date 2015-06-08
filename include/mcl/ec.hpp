#pragma once
/**
	@file
	@brief elliptic curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <sstream>
#include <cybozu/exception.hpp>
#include <mcl/power.hpp>
#include <mcl/gmp_util.hpp>

namespace mcl {

#define MCL_EC_USE_AFFINE 0
#define MCL_EC_USE_PROJ 1
#define MCL_EC_USE_JACOBI 2

//#define MCL_EC_COORD MCL_EC_USE_JACOBI
//#define MCL_EC_COORD MCL_EC_USE_PROJ
#ifndef MCL_EC_COORD
	#define MCL_EC_COORD MCL_EC_USE_PROJ
#endif
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
	typedef typename Fp::BlockType BlockType;
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
	Fp x, y;
	bool inf_;
#else
	mutable Fp x, y, z;
#endif
	static Fp a_;
	static Fp b_;
	static int specialA_;
	static bool compressedExpression_;
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
	EcT() : inf_(true) {}
#else
	EcT() { z.clear(); }
#endif
	EcT(const Fp& _x, const Fp& _y)
	{
		set(_x, _y);
	}
	void normalize() const
	{
#if MCL_EC_COORD == MCL_EC_USE_JACOBI
		if (isZero() || z == 1) return;
		Fp rz, rz2;
		Fp::inv(rz, z);
		rz2 = rz * rz;
		x *= rz2;
		y *= rz2 * rz;
		z = 1;
#elif MCL_EC_COORD == MCL_EC_USE_PROJ
		if (isZero() || z == 1) return;
		Fp rz;
		Fp::inv(rz, z);
		x *= rz;
		y *= rz;
		z = 1;
#endif
	}

	static inline void setParam(const std::string& astr, const std::string& bstr)
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
	}
	static inline bool isValid(const Fp& _x, const Fp& _y)
	{
		return _y * _y == (_x * _x + a_) * _x + b_;
	}
	void set(const Fp& _x, const Fp& _y, bool verify = true)
	{
		if (verify && !isValid(_x, _y)) throw cybozu::Exception("ec:EcT:set") << _x << _y;
		x = _x; y = _y;
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
		inf_ = false;
#else
		z = 1;
#endif
	}
	void clear()
	{
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
		inf_ = true;
#else
		z = 0;
#endif
		x.clear();
		y.clear();
	}

	static inline void dbl(EcT& R, const EcT& P, bool verifyInf = true)
	{
		if (verifyInf) {
			if (P.isZero()) {
				R.clear(); return;
			}
		}
#if MCL_EC_COORD == MCL_EC_USE_JACOBI
		Fp S, M, t, y2;
		Fp::square(y2, P.y);
		Fp::mul(S, P.x, y2);
		S += S;
		S += S;
		Fp::square(M, P.x);
		switch (specialA_) {
		case zero:
			Fp::add(t, M, M);
			M += t;
			break;
		case minus3:
			Fp::square(t, P.z);
			Fp::square(t, t);
			M -= t;
			Fp::add(t, M, M);
			M += t;
			break;
		case generic:
		default:
			Fp::square(t, P.z);
			Fp::square(t, t);
			t *= a_;
			t += M;
			M += M;
			M += t;
			break;
		}
		Fp::square(R.x, M);
		R.x -= S;
		R.x -= S;
		Fp::mul(R.z, P.y, P.z);
		R.z += R.z;
		Fp::square(y2, y2);
		y2 += y2;
		y2 += y2;
		y2 += y2;
		Fp::sub(R.y, S, R.x);
		R.y *= M;
		R.y -= y2;
#elif MCL_EC_COORD == MCL_EC_USE_PROJ
		Fp w, t, h;
		switch (specialA_) {
		case zero:
			Fp::square(w, P.x);
			Fp::add(t, w, w);
			w += t;
			break;
		case minus3:
			Fp::square(w, P.x);
			Fp::square(t, P.z);
			w -= t;
			Fp::add(t, w, w);
			w += t;
			break;
		case generic:
		default:
			Fp::square(w, P.z);
			w *= a_;
			Fp::square(t, P.x);
			w += t;
			w += t;
			w += t; // w = a z^2 + 3x^2
			break;
		}
		Fp::mul(R.z, P.y, P.z); // s = yz
		Fp::mul(t, R.z, P.x);
		t *= P.y; // xys
		t += t;
		t += t; // 4(xys) ; 4B
		Fp::square(h, w);
		h -= t;
		h -= t; // w^2 - 8B
		Fp::mul(R.x, h, R.z);
		t -= h; // h is free
		t *= w;
		Fp::square(w, P.y);
		R.x += R.x;
		R.z += R.z;
		Fp::square(h, R.z);
		w *= h;
		R.z *= h;
		Fp::sub(R.y, t, w);
		R.y -= w;
#else
		Fp t, s;
		Fp::square(t, P.x);
		Fp::add(s, t, t);
		t += s;
		t += a_;
		Fp::add(s, P.y, P.y);
		t /= s;
		Fp::square(s, t);
		s -= P.x;
		Fp x3;
		Fp::sub(x3, s, P.x);
		Fp::sub(s, P.x, x3);
		s *= t;
		Fp::sub(R.y, s, P.y);
		R.x = x3;
		R.inf_ = false;
#endif
	}
	static inline void add(EcT& R, const EcT& P, const EcT& Q)
	{
		if (P.isZero()) { R = Q; return; }
		if (Q.isZero()) { R = P; return; }
#if MCL_EC_COORD == MCL_EC_USE_JACOBI
		Fp r, U1, S1, H, H3;
		Fp::square(r, P.z);
		Fp::square(S1, Q.z);
		Fp::mul(U1, P.x, S1);
		Fp::mul(H, Q.x, r);
		H -= U1;
		r *= P.z;
		S1 *= Q.z;
		S1 *= P.y;
		Fp::mul(r, Q.y, r);
		r -= S1;
		if (H.isZero()) {
			if (r.isZero()) {
				dbl(R, P, false);
			} else {
				R.clear();
			}
			return;
		}
		Fp::mul(R.z, P.z, Q.z);
		R.z *= H;
		Fp::square(H3, H); // H^2
		Fp::square(R.y, r); // r^2
		U1 *= H3; // U1 H^2
		H3 *= H; // H^3
		R.y -= U1;
		R.y -= U1;
		Fp::sub(R.x, R.y, H3);
		U1 -= R.x;
		U1 *= r;
		H3 *= S1;
		Fp::sub(R.y, U1, H3);
#elif MCL_EC_COORD == MCL_EC_USE_PROJ
		Fp r, PyQz, v, A, vv;
		Fp::mul(r, P.x, Q.z);
		Fp::mul(PyQz, P.y, Q.z);
		Fp::mul(A, Q.y, P.z);
		Fp::mul(v, Q.x, P.z);
		v -= r;
		if (v.isZero()) {
			Fp::add(vv, A, PyQz);
			if (vv.isZero()) {
				R.clear();
			} else {
				dbl(R, P, false);
			}
			return;
		}
		Fp::sub(R.y, A, PyQz);
		Fp::square(A, R.y);
		Fp::square(vv, v);
		r *= vv;
		vv *= v;
		Fp::mul(R.z, P.z, Q.z);
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
#else
		Fp t;
		Fp::neg(t, Q.y);
		if (P.y == t) { R.clear(); return; }
		Fp::sub(t, Q.x, P.x);
		if (t.isZero()) {
			dbl(R, P, false);
			return;
		}
		Fp s;
		Fp::sub(s, Q.y, P.y);
		Fp::div(t, s, t);
		R.inf_ = false;
		Fp x3;
		Fp::square(x3, t);
		x3 -= P.x;
		x3 -= Q.x;
		Fp::sub(s, P.x, x3);
		s *= t;
		Fp::sub(R.y, s, P.y);
		R.x = x3;
#endif
	}
	static inline void sub(EcT& R, const EcT& P, const EcT& Q)
	{
#if 0
		if (P.inf_) { neg(R, Q); return; }
		if (Q.inf_) { R = P; return; }
		if (P.y == Q.y) { R.clear(); return; }
		Fp t;
		Fp::sub(t, Q.x, P.x);
		if (t.isZero()) {
			dbl(R, P, false);
			return;
		}
		Fp s;
		Fp::add(s, Q.y, P.y);
		Fp::neg(s, s);
		Fp::div(t, s, t);
		R.inf_ = false;
		Fp x3;
		Fp::mul(x3, t, t);
		x3 -= P.x;
		x3 -= Q.x;
		Fp::sub(s, P.x, x3);
		s *= t;
		Fp::sub(R.y, s, P.y);
		R.x = x3;
#else
		EcT nQ;
		neg(nQ, Q);
		add(R, P, nQ);
#endif
	}
	static inline void neg(EcT& R, const EcT& P)
	{
		if (P.isZero()) {
			R.clear();
			return;
		}
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
		R.inf_ = false;
		R.x = P.x;
		Fp::neg(R.y, P.y);
#else
		R.x = P.x;
		Fp::neg(R.y, P.y);
		R.z = P.z;
#endif
	}
	template<class N>
	static inline void power(EcT& z, const EcT& x, const N& y)
	{
		power_impl::power(z, x, y);
	}
#if 0
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
		return compareFunc(P, Q, _Fp::compare);
	}
	static inline int compareRaw(const EcT& P, const EcT& Q)
	{
		return compareFunc(P, Q, _Fp::compareRaw);
	}
#endif
	bool isZero() const
	{
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
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
#if MCL_EC_COORD == MCL_EC_USE_AFFINE
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
		Fp::square(t, x);
		t += a_;
		t *= x;
		t += b_;
		Fp::squareRoot(y, t);
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
		sub(R, *this, rhs);
		return R.isZero();
	}
	bool operator!=(const EcT& rhs) const { return !operator==(rhs); }
};

template<class T>
struct TagMultiGr<EcT<T> > {
	static void square(EcT<T>& z, const EcT<T>& x)
	{
		EcT<T>::dbl(z, x);
	}
	static void mul(EcT<T>& z, const EcT<T>& x, const EcT<T>& y)
	{
		EcT<T>::add(z, x, y);
	}
	static void inv(EcT<T>& z, const EcT<T>& x)
	{
		EcT<T>::neg(z, x);
	}
	static void div(EcT<T>& z, const EcT<T>& x, const EcT<T>& y)
	{
		EcT<T>::sub(z, x, y);
	}
	static void init(EcT<T>& x)
	{
		x.clear();
	}
};

template<class _Fp> _Fp EcT<_Fp>::a_;
template<class _Fp> _Fp EcT<_Fp>::b_;
template<class _Fp> int EcT<_Fp>::specialA_;
template<class _Fp> bool EcT<_Fp>::compressedExpression_;

struct EcParam {
	const char *name;
	const char *p;
	const char *a;
	const char *b;
	const char *gx;
	const char *gy;
	const char *n;
	size_t bitLen; // bit length of p
};

} // mcl

namespace std { CYBOZU_NAMESPACE_TR1_BEGIN
template<class T> struct hash;

template<class _Fp>
struct hash<mcl::EcT<_Fp> > {
	size_t operator()(const mcl::EcT<_Fp>& P) const
	{
		if (P.isZero()) return 0;
		P.normalize();
		uint64_t v = hash<_Fp>()(P.x);
		v = hash<_Fp>()(P.y, v);
		return static_cast<size_t>(v);
	}
};

CYBOZU_NAMESPACE_TR1_END } // std
