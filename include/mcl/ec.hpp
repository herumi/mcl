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
	Fp x, y, z;
	static int mode_;
#endif
	static Fp a_;
	static Fp b_;
	static int specialA_;
	static int ioMode_;
	/*
		order_ is the order of G2 which is the subgroup of EcT<Fp2>.
		check the order of the elements if verifyOrder_ is true
	*/
	static bool verifyOrder_;
	static mpz_class order_;
	static void (*mulArrayGLV)(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime);
	/* default constructor is undefined value */
	EcT() {}
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
	void normalizeJacobi()
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
	void normalizeProj()
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
public:
#endif
	void normalize()
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
	static void normalize(EcT& y, const EcT& x)
	{
		y = x;
		y.normalize();
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
		verifyOrder_ = false;
		order_ = 0;
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
	/*
		verify the order of *this is equal to order if order != 0
		in constructor, set, setStr, operator<<().
	*/
	static void setOrder(const mpz_class& order)
	{
		verifyOrder_ = order != 0;
		order_ = order;
	}
	static void setMulArrayGLV(void f(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime))
	{
		mulArrayGLV = f;
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
	// verify the order
	bool isValidOrder() const
	{
		EcT Q;
		EcT::mulGeneric(Q, *this, order_);
		return Q.isZero();
	}
	bool isValid() const
	{
		if (isZero()) return true;
		bool isOK = false;
#ifndef MCL_EC_USE_AFFINE
		if (!z.isOne()) {
			switch (mode_) {
			case ec::Jacobi:
				isOK = isValidJacobi();
				break;
			case ec::Proj:
				isOK = isValidProj();
				break;
			}
		} else
#endif
		{
			isOK = isValid(x, y);
		}
		if (!isOK) return false;
		if (verifyOrder_) return isValidOrder();
		return true;
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
		if (verify && verifyOrder_ && !isValidOrder()) {
			throw cybozu::Exception("EcT:set:bad order") << *this;
		}
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
	template<class tag, size_t maxBitSize, template<class _tag, size_t _maxBitSize>class FpT>
	static inline void mulCT(EcT& z, const EcT& x, const FpT<tag, maxBitSize>& y)
	{
		fp::Block b;
		y.getBlock(b);
		mulArray(z, x, b.p, b.n, false, true);
	}
	static inline void mulCT(EcT& z, const EcT& x, const mpz_class& y)
	{
		mulArray(z, x, gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0, true);
	}
	/*
		0 <= P for any P
		(Px, Py) <= (P'x, P'y) iff Px < P'x or Px == P'x and Py <= P'y
		@note compare function calls normalize()
	*/
	template<class F>
	static inline int compareFunc(const EcT& P_, const EcT& Q_, F comp)
	{
		const bool QisZero = Q_.isZero();
		if (P_.isZero()) {
			if (QisZero) return 0;
			return -1;
		}
		if (QisZero) return 1;
		EcT P(P_), Q(Q_);
		P.normalize();
		Q.normalize();
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
	static inline bool isFixedSizeByteSeq()
	{
		return !b_.isZero() && (Fp::BaseFp::getBitSize() & 7) != 0;
	}
	/*
		see mcl/op.hpp for the format of ioMode
	*/
	void getStr(std::string& str, int ioMode = 0) const
	{
		const char *sep = fp::getIoSeparator(ioMode);
		if (ioMode & IoEcProj) {
			str = '4';
			str += sep;
			str += x.getStr(ioMode);
			str += sep;
			str += y.getStr(ioMode);
			str += sep;
			str += z.getStr(ioMode);
			return;
		}
		EcT P(*this);
		P.normalize();
		if (ioMode & IoFixedSizeByteSeq) {
			if (!isFixedSizeByteSeq()) throw cybozu::Exception("EcT:getStr:not supported ioMode") << ioMode;
			const size_t n = Fp::getByteSize();
			if (isZero()) {
				str.clear();
				str.resize(n);
				return;
			}
			P.x.getStr(str, ioMode);
			assert(str.size() == n && (str[n - 1] & 0x80) == 0);
			if (P.y.isOdd()) {
				str[n - 1] |= 0x80;
			}
			return;
		}
		if (isZero()) {
			str = '0';
			return;
		}
		if (ioMode & IoEcCompY) {
			str = P.y.isOdd() ? '3' : '2';
			str += sep;
			str += P.x.getStr(ioMode);
		} else {
			str = '1';
			str += sep;
			str += P.x.getStr(ioMode);
			str += sep;
			str += P.y.getStr(ioMode);
		}
	}
	std::string getStr(int ioMode = 0) const
	{
		std::string str;
		getStr(str, ioMode);
		return str;
	}
	friend inline std::ostream& operator<<(std::ostream& os, const EcT& self)
	{
		int ioMode = fp::detectIoMode(getIoMode(), os);
		return os << self.getStr(ioMode);
	}
	std::istream& readStream(std::istream& is, int ioMode)
	{
#ifdef MCL_EC_USE_AFFINE
		inf_ = false;
#else
		z = 1;
#endif
		if (ioMode & IoFixedSizeByteSeq) {
			if (!isFixedSizeByteSeq()) throw cybozu::Exception("EcT:readStream:not supported ioMode") << ioMode;
			std::string str;
			const size_t n = Fp::getByteSize();
			str.resize(n);
			is.read(&str[0], n);
			if (fp::isZeroArray(&str[0], n)) {
				clear();
				return is;
			}
			bool isYodd = (str[n - 1] >> 7) != 0;
			str[n - 1] &= 0x7f;
			x.setStr(str, ioMode);
			getYfromX(y, x, isYodd);
		} else {
			char c = 0;
			if (!(is >> c)) {
				throw cybozu::Exception("EcT:readStream:no header");
			}
			if (c == '0') {
				clear();
				return is;
			}
			x.readStream(is, ioMode);
			if (c == '1') {
				y.readStream(is, ioMode);
				if (!isValid(x, y)) {
					throw cybozu::Exception("EcT:readStream:bad value") << x << y;
				}
			} else if (c == '2' || c == '3') {
				bool isYodd = c == '3';
				getYfromX(y, x, isYodd);
			} else if (c == '4') {
				y.readStream(is, ioMode);
				z.readStream(is, ioMode);
			} else {
				throw cybozu::Exception("EcT:readStream:bad format") << (int)c;
			}
		}
		if (verifyOrder_ && !isValidOrder()) {
			throw cybozu::Exception("EcT:readStream:bad order") << *this;
		}
		return is;
	}
	friend inline std::istream& operator>>(std::istream& is, EcT& self)
	{
		int ioMode = fp::detectIoMode(getIoMode(), is);
		return self.readStream(is, ioMode);
	}
	void setStr(const std::string& str, int ioMode = 0)
	{
		std::istringstream is(str);
		readStream(is, ioMode);
	}
	// deplicated
	static void setCompressedExpression(bool compressedExpression = true)
	{
		if (compressedExpression) {
			ioMode_ |= IoEcCompY;
		} else {
			ioMode_ &= ~IoEcCompY;
		}
	}
	/*
		set IoMode for operator<<(), or operator>>()
	*/
	static void setIoMode(int ioMode)
	{
		if (ioMode & 0xff) throw cybozu::Exception("EcT:setIoMode:use Fp::setIomode") << ioMode;
		ioMode_ = ioMode;
	}
	static inline int getIoMode() { return Fp::BaseFp::getIoMode() | ioMode_; }
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
		if (!Fp::squareRoot(y, y)) {
			throw cybozu::Exception("EcT:getYfromX") << x << isYodd;
		}
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
		return compare(*this, rhs) < 0;
	}
	bool operator>=(const EcT& rhs) const { return !operator<(rhs); }
	bool operator>(const EcT& rhs) const { return rhs < *this; }
	bool operator<=(const EcT& rhs) const { return !operator>(rhs); }
	static inline void mulArray(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime = false)
	{
		if (mulArrayGLV && (constTime || yn > 1)) {
			mulArrayGLV(z, x, y, yn, isNegative, constTime);
			return;
		}
		mulArrayBase(z, x, y, yn, isNegative, constTime);
	}
	static inline void mulArrayBase(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		EcT tmp;
		const EcT *px = &x;
		if (&z == &x) {
			tmp = x;
			px = &tmp;
		}
		z.clear();
		fp::powGeneric(z, *px, y, yn, EcT::add, EcT::dbl, EcT::normalize, constTime ? Fp::BaseFp::getBitSize() : 0);
		if (isNegative) {
			neg(z, z);
		}
	}
	/*
		generic mul
	*/
	static inline void mulGeneric(EcT& z, const EcT& x, const mpz_class& y, bool constTime = false)
	{
		mulArrayBase(z, x, gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0, constTime);
	}
};

template<class Fp> Fp EcT<Fp>::a_;
template<class Fp> Fp EcT<Fp>::b_;
template<class Fp> int EcT<Fp>::specialA_;
template<class Fp> int EcT<Fp>::ioMode_;
template<class Fp> bool EcT<Fp>::verifyOrder_;
template<class Fp> mpz_class EcT<Fp>::order_;
template<class Fp> void (*EcT<Fp>::mulArrayGLV)(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime);
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
size_t hash_value(const mcl::EcT<Fp>& P_)
{
	if (P_.isZero()) return 0;
	mcl::EcT<Fp> P(P_); P.normalize();
	return mcl::hash_value(P.y, mcl::hash_value(P.x));
}

}
#else
namespace std { CYBOZU_NAMESPACE_TR1_BEGIN

template<class Fp>
struct hash<mcl::EcT<Fp> > {
	size_t operator()(const mcl::EcT<Fp>& P_) const
	{
		if (P_.isZero()) return 0;
		mcl::EcT<Fp> P(P_); P.normalize();
		return hash<Fp>()(P.y, hash<Fp>()(P.x));
	}
};

CYBOZU_NAMESPACE_TR1_END } // std
#endif

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
