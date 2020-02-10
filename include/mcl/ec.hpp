#pragma once
/**
	@file
	@brief elliptic curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdlib.h>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>

//#define MCL_EC_USE_AFFINE

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4458)
#endif

namespace mcl {

template<class _Fp> class Fp2T;

namespace ec {

enum Mode {
	Jacobi = 0,
	Proj = 1
};

namespace local {

// x is negative <=> x < half(:=(p+1)/2) <=> a = 1
template<class Fp>
bool get_a_flag(const Fp& x)
{
	return x.isNegative();
}

// Im(x) is negative <=> Im(x)  < half(:=(p+1)/2) <=> a = 1

template<class Fp>
bool get_a_flag(const mcl::Fp2T<Fp>& x)
{
	return get_a_flag(x.b); // x = a + bi
}

} // mcl::ec::local

} // mcl::ec

namespace local {

template<class Ec, class Vec>
void addTbl(Ec& Q, const Ec *tbl, const Vec& naf, size_t i)
{
	if (i >= naf.size()) return;
	int n = naf[i];
	if (n > 0) {
		Q += tbl[(n - 1) >> 1];
	} else if (n < 0) {
		Q -= tbl[(-n - 1) >> 1];
	}
}

} // mcl::local

/*
	elliptic curve
	y^2 = x^3 + ax + b (affine)
	y^2 = x^3 + az^4 + bz^6 (Jacobi) x = X/Z^2, y = Y/Z^3
*/
template<class _Fp>
class EcT : public fp::Serializable<EcT<_Fp> > {
	enum {
		zero,
		minus3,
		generic
	};
public:
	typedef _Fp Fp;
	typedef _Fp BaseFp;
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
	static size_t (*mulVecNGLV)(EcT& z, const EcT *xVec, const mpz_class *yVec, size_t yn);
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
#endif
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
		ioMode_ = 0;
		verifyOrder_ = false;
		order_ = 0;
		mulArrayGLV = 0;
		mulVecNGLV = 0;
#ifdef MCL_EC_USE_AFFINE
		cybozu::disable_warning_unused_variable(mode);
#else
		assert(mode == ec::Jacobi || mode == ec::Proj);
		mode_ = mode;
#endif
	}
	/*
		verify the order of *this is equal to order if order != 0
		in constructor, set, setStr, operator<<().
	*/
	static void setOrder(const mpz_class& order)
	{
		if (order != 0) {
			verifyOrder_ = true;
			order_ = order;
		} else {
			verifyOrder_ = false;
			// don't clear order_ because it is used for isValidOrder()
		}
	}
	static void setMulArrayGLV(void f(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime), size_t g(EcT& z, const EcT *xVec, const mpz_class *yVec, size_t yn) = 0)
	{
		mulArrayGLV = f;
		mulVecNGLV = g;
	}
	static inline void init(bool *pb, const char *astr, const char *bstr, int mode = ec::Jacobi)
	{
		Fp a, b;
		a.setStr(pb, astr);
		if (!*pb) return;
		b.setStr(pb, bstr);
		if (!*pb) return;
		init(a, b, mode);
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
	void set(bool *pb, const Fp& _x, const Fp& _y, bool verify = true)
	{
		if (verify && !isValid(_x, _y)) {
			*pb = false;
			return;
		}
		x = _x; y = _y;
#ifdef MCL_EC_USE_AFFINE
		inf_ = false;
#else
		z = 1;
#endif
		if (verify && verifyOrder_ && !isValidOrder()) {
			*pb = false;
		} else {
			*pb = true;
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
	static inline void addJacobi(EcT& R, const EcT& P, const EcT& Q, bool isPzOne, bool isQzOne)
	{
		Fp r, U1, S1, H, H3;
		if (isPzOne) {
			// r = 1;
		} else {
			Fp::sqr(r, P.z);
		}
		if (isQzOne) {
			U1 = P.x;
			if (isPzOne) {
				H = Q.x;
			} else {
				Fp::mul(H, Q.x, r);
			}
			H -= U1;
			S1 = P.y;
		} else {
			Fp::sqr(S1, Q.z);
			Fp::mul(U1, P.x, S1);
			if (isPzOne) {
				H = Q.x;
			} else {
				Fp::mul(H, Q.x, r);
			}
			H -= U1;
			S1 *= Q.z;
			S1 *= P.y;
		}
		if (isPzOne) {
			r = Q.y;
		} else {
			r *= P.z;
			r *= Q.y;
		}
		r -= S1;
		if (H.isZero()) {
			if (r.isZero()) {
				dblNoVerifyInf(R, P);
			} else {
				R.clear();
			}
			return;
		}
		if (isPzOne) {
			if (isQzOne) {
				R.z = H;
			} else {
				Fp::mul(R.z, H, Q.z);
			}
		} else {
			if (isQzOne) {
				Fp::mul(R.z, P.z, H);
			} else {
				Fp::mul(R.z, P.z, Q.z);
				R.z *= H;
			}
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
	static inline void addProj(EcT& R, const EcT& P, const EcT& Q, bool isPzOne, bool isQzOne)
	{
		Fp r, PyQz, v, A, vv;
		if (isQzOne) {
			r = P.x;
			PyQz = P.y;
		} else {
			Fp::mul(r, P.x, Q.z);
			Fp::mul(PyQz, P.y, Q.z);
		}
		if (isPzOne) {
			A = Q.y;
			v = Q.x;
		} else {
			Fp::mul(A, Q.y, P.z);
			Fp::mul(v, Q.x, P.z);
		}
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
			if (isPzOne) {
				R.z = Q.z;
			} else {
				Fp::mul(R.z, P.z, Q.z);
			}
		}
		// R.z = 1 if isPzOne && isQzOne
		if (isPzOne && isQzOne) {
			R.z = vv;
		} else {
			A *= R.z;
			R.z *= vv;
		}
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
	static inline void add(EcT& R, const EcT& P, const EcT& Q) {
		if (P.isZero()) { R = Q; return; }
		if (Q.isZero()) { R = P; return; }
		if (&P == &Q) {
			dblNoVerifyInf(R, P);
			return;
		}
#ifdef MCL_EC_USE_AFFINE
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
		bool isPzOne = P.z.isOne();
		bool isQzOne = Q.z.isOne();
		switch (mode_) {
		case ec::Jacobi:
			addJacobi(R, P, Q, isPzOne, isQzOne);
			break;
		case ec::Proj:
			addProj(R, P, Q, isPzOne, isQzOne);
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
	static inline void mul(EcT& z, const EcT& x, int64_t y)
	{
		const uint64_t u = fp::abs_(y);
#if MCL_SIZEOF_UNIT == 8
		mulArray(z, x, &u, 1, y < 0);
#else
		uint32_t ua[2] = { uint32_t(u), uint32_t(u >> 32) };
		size_t un = ua[1] ? 2 : 1;
		mulArray(z, x, ua, un, y < 0);
#endif
	}
	static inline void mul(EcT& z, const EcT& x, const mpz_class& y)
	{
		mulArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0);
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
		mulArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0, true);
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
	static inline bool isMSBserialize()
	{
		return !b_.isZero() && (Fp::BaseFp::getBitSize() & 7) != 0;
	}
	template<class OutputStream>
	void save(bool *pb, OutputStream& os, int ioMode) const
	{
		const char sep = *fp::getIoSeparator(ioMode);
		if (ioMode & IoEcProj) {
			cybozu::writeChar(pb, os, '4'); if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
			x.save(pb, os, ioMode); if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
			y.save(pb, os, ioMode); if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
#ifndef MCL_EC_USE_AFFINE
			z.save(pb, os, ioMode);
#endif
			return;
		}
		EcT P(*this);
		P.normalize();
		if (ioMode & IoEcAffineSerialize) {
			if (b_ == 0) { // assume Zero if x = y = 0
				*pb = false;
				return;
			}
			if (isZero()) {
				// all zero
				P.z.save(pb, os, IoSerialize);
				if (!*pb) return;
				P.z.save(pb, os, IoSerialize);
				return;
			}
			P.x.save(pb, os, IoSerialize);
			if (!*pb) return;
			P.y.save(pb, os, IoSerialize);
			return;
		}
		if (ioMode & (IoSerialize | IoSerializeHexStr)) {
			const size_t n = Fp::getByteSize();
			const size_t adj = isMSBserialize() ? 0 : 1;
			uint8_t buf[sizeof(Fp) + 1];
			if (Fp::BaseFp::isETHserialization()) {
				const uint8_t c_flag = 0x80;
				const uint8_t b_flag = 0x40;
				const uint8_t a_flag = 0x20;
				if (P.isZero()) {
					buf[0] = c_flag | b_flag;
					memset(buf + 1, 0, n - 1);
				} else {
					cybozu::MemoryOutputStream mos(buf, n);
					P.x.save(pb, mos, IoSerialize); if (!*pb) return;
					uint8_t cba = c_flag;
					if (ec::local::get_a_flag(P.y)) cba |= a_flag;
					buf[0] |= cba;
				}
			} else {
				/*
					if (isMSBserialize()) {
					  // n bytes
					  x | (y.isOdd ? 0x80 : 0)
					} else {
					  // n + 1 bytes
					  (y.isOdd ? 3 : 2), x
					}
				*/
				if (isZero()) {
					memset(buf, 0, n + adj);
				} else {
					cybozu::MemoryOutputStream mos(buf + adj, n);
					P.x.save(pb, mos, IoSerialize); if (!*pb) return;
					if (adj) {
						buf[0] = P.y.isOdd() ? 3 : 2;
					} else {
						if (P.y.isOdd()) {
							buf[n - 1] |= 0x80;
						}
					}
				}
			}
			if (ioMode & IoSerializeHexStr) {
				mcl::fp::writeHexStr(pb, os, buf, n + adj);
			} else {
				cybozu::write(pb, os, buf, n + adj);
			}
			return;
		}
		if (isZero()) {
			cybozu::writeChar(pb, os, '0');
			return;
		}
		if (ioMode & IoEcCompY) {
			cybozu::writeChar(pb, os, P.y.isOdd() ? '3' : '2');
			if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
			P.x.save(pb, os, ioMode);
		} else {
			cybozu::writeChar(pb, os, '1'); if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
			P.x.save(pb, os, ioMode); if (!*pb) return;
			if (sep) {
				cybozu::writeChar(pb, os, sep);
				if (!*pb) return;
			}
			P.y.save(pb, os, ioMode);
		}
	}
	template<class InputStream>
	void load(bool *pb, InputStream& is, int ioMode)
	{
#ifdef MCL_EC_USE_AFFINE
		inf_ = false;
#else
		z = 1;
#endif
		if (ioMode & IoEcAffineSerialize) {
			if (b_ == 0) { // assume Zero if x = y = 0
				*pb = false;
				return;
			}
			x.load(pb, is, IoSerialize);
			if (!*pb) return;
			y.load(pb, is, IoSerialize);
			if (!*pb) return;
			if (x.isZero() && y.isZero()) {
				z.clear();
				return;
			}
			goto verifyValidness;
		}
		if (ioMode & (IoSerialize | IoSerializeHexStr)) {
			const size_t n = Fp::getByteSize();
			const size_t adj = isMSBserialize() ? 0 : 1;
			const size_t n1 = n + adj;
			uint8_t buf[sizeof(Fp) + 1];
			size_t readSize;
			if (ioMode & IoSerializeHexStr) {
				readSize = mcl::fp::readHexStr(buf, n1, is);
			} else {
				readSize = cybozu::readSome(buf, n1, is);
			}
			if (readSize != n1) {
				*pb = false;
				return;
			}
			if (Fp::BaseFp::isETHserialization()) {
				const uint8_t c_flag = 0x80;
				const uint8_t b_flag = 0x40;
				const uint8_t a_flag = 0x20;
				*pb = false;
				if ((buf[0] & c_flag) == 0) { // assume compressed
					return;
				}
				if (buf[0] & b_flag) { // infinity
					if (buf[0] != (c_flag | b_flag)) return;
					for (size_t i = 1; i < n - 1; i++) {
						if (buf[i]) return;
					}
					clear();
					*pb = true;
					return;
				}
				bool a = (buf[0] & a_flag) != 0;
				buf[0] &= ~(c_flag | b_flag | a_flag);
				mcl::fp::local::byteSwap(buf, n);
				x.setArray(pb, buf, n);
				if (!*pb) return;
				getWeierstrass(y, x);
				if (!Fp::squareRoot(y, y)) {
					*pb = false;
					return;
				}
				if (ec::local::get_a_flag(y) ^ a) {
					Fp::neg(y, y);
				}
				goto verifyOrder;
			}
			if (fp::isZeroArray(buf, n1)) {
				clear();
				*pb = true;
				return;
			}
			bool isYodd;
			if (adj) {
				char c = buf[0];
				if (c != 2 && c != 3) {
					*pb = false;
					return;
				}
				isYodd = c == 3;
			} else {
				isYodd = (buf[n - 1] >> 7) != 0;
				buf[n - 1] &= 0x7f;
			}
			x.setArray(pb, buf + adj, n);
			if (!*pb) return;
			*pb = getYfromX(y, x, isYodd);
			if (!*pb) return;
		} else {
			char c = 0;
			if (!fp::local::skipSpace(&c, is)) {
				*pb = false;
				return;
			}
			if (c == '0') {
				clear();
				*pb = true;
				return;
			}
			x.load(pb, is, ioMode); if (!*pb) return;
			if (c == '1') {
				y.load(pb, is, ioMode); if (!*pb) return;
				goto verifyValidness;
			} else if (c == '2' || c == '3') {
				bool isYodd = c == '3';
				*pb = getYfromX(y, x, isYodd);
				if (!*pb) return;
			} else if (c == '4') {
				y.load(pb, is, ioMode); if (!*pb) return;
#ifndef MCL_EC_USE_AFFINE
				z.load(pb, is, ioMode); if (!*pb) return;
#endif
			} else {
				*pb = false;
				return;
			}
		}
	verifyOrder:
		if (verifyOrder_ && !isValidOrder()) {
			*pb = false;
		} else {
			*pb = true;
		}
		return;
	verifyValidness:
		if (!isValid(x, y)) {
			*pb = false;
			return;
		}
		goto verifyOrder;
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
		assert(!(ioMode & 0xff));
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
	static inline bool getYfromX(Fp& y, const Fp& x, bool isYodd)
	{
		getWeierstrass(y, x);
		if (!Fp::squareRoot(y, y)) {
			return false;
		}
		if (y.isOdd() ^ isYodd) {
			Fp::neg(y, y);
		}
		return true;
	}
	inline friend EcT operator+(const EcT& x, const EcT& y) { EcT z; add(z, x, y); return z; }
	inline friend EcT operator-(const EcT& x, const EcT& y) { EcT z; sub(z, x, y); return z; }
	template<class INT>
	inline friend EcT operator*(const EcT& x, const INT& y) { EcT z; mul(z, x, y); return z; }
	EcT& operator+=(const EcT& x) { add(*this, *this, x); return *this; }
	EcT& operator-=(const EcT& x) { sub(*this, *this, x); return *this; }
	template<class INT>
	EcT& operator*=(const INT& x) { mul(*this, *this, x); return *this; }
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
	static inline void mulArray(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime = false, bool useGLV = true)
	{
		if (!constTime) {
			if (yn == 0) {
				z.clear();
				return;
			}
			yn = fp::getNonZeroArraySize(y, yn);
			if (yn <= 1 && mulSmallInt(z, x, *y, isNegative)) return;
		}
		if (useGLV && mulArrayGLV && (yn * sizeof(fp::Unit) > 8)) {
			mulArrayGLV(z, x, y, yn, isNegative, constTime);
			return;
		}
		mulArrayBase(z, x, y, yn, isNegative, constTime);
	}
	static inline bool mulSmallInt(EcT& z, const EcT& x, fp::Unit y, bool isNegative)
	{
		switch (y) {
		case 0: z.clear(); return true;
		case 1: z = x; break;
		case 2: dbl(z, x); break;
		case 3: {
			EcT t;
			dbl(t, x);
			add(z, t, x);
			break;
		}
		case 4: {
			dbl(z, x);
			dbl(z, z);
			break;
		}
		case 5: {
			EcT t;
			dbl(t, x);
			dbl(t, t);
			add(z, t, x);
			break;
		}
		case 6: {
			EcT t;
			dbl(t, x);
			add(z, t, x);
			dbl(z, z);
			break;
		}
		case 7: {
			EcT t;
			dbl(t, x);
			dbl(t, t);
			dbl(t, t);
			sub(z, t, x);
			break;
		}
		case 8: {
			dbl(z, x);
			dbl(z, z);
			dbl(z, z);
			break;
		}
		case 9: {
			EcT t;
			dbl(t, x);
			dbl(t, t);
			dbl(t, t);
			add(z, t, x);
			break;
		}
		case 10: {
			EcT t;
			dbl(t, x);
			dbl(t, t);
			add(z, t, x);
			dbl(z, z);
			break;
		}
		case 11: {
			EcT t1, t2;
			dbl(t1, x); // 2x
			dbl(t2, t1);
			dbl(t2, t2); // 8x
			add(t2, t2, t1);
			add(z, t2, x);
			break;
		}
		case 12: {
			EcT t1, t2;
			dbl(t1, x);
			dbl(t1, t1); // 4x
			dbl(t2, t1); // 8x
			add(z, t1, t2);
			break;
		}
		case 13: {
			EcT t1, t2;
			dbl(t1, x);
			dbl(t1, t1); // 4x
			dbl(t2, t1); // 8x
			add(t1, t1, t2); // 12x
			add(z, t1, x);
			break;
		}
		case 14: {
			EcT t;
			// (8 - 1) * 2
			dbl(t, x);
			dbl(t, t);
			dbl(t, t);
			sub(t, t, x);
			dbl(z, t);
			break;
		}
		case 15: {
			EcT t;
			dbl(t, x);
			dbl(t, t);
			dbl(t, t);
			dbl(t, t);
			sub(z, t, x);
			break;
		}
		case 16: {
			dbl(z, x);
			dbl(z, z);
			dbl(z, z);
			dbl(z, z);
			break;
		}
		default:
			return false;
		}
		if (isNegative) {
			neg(z, z);
		}
		return true;
	}
	static inline void mulArrayBase(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		(void)constTime;
		mpz_class v;
		bool b;
		gmp::setArray(&b, v, y, yn);
		assert(b); (void)b;
		if (isNegative) v = -v;
		const int maxW = 5;
		const int maxTblSize = 1 << (maxW - 2);
		/*
			L = log2(y), w = (L <= 32) ? 3 : (L <= 128) ? 4 : 5;
		*/
		const int w = (yn == 1 && *y <= (1ull << 32)) ? 3 : (yn * sizeof(fp::Unit) > 16) ? 5 : 4;
		const size_t tblSize = size_t(1) << (w - 2);
		typedef mcl::FixedArray<int8_t, sizeof(EcT::Fp) * 8 + 1> NafArray;
		NafArray naf;
		EcT tbl[maxTblSize];
		gmp::getNAFwidth(&b, naf, v, w);
		assert(b); (void)b;
		EcT P2;
		dbl(P2, x);
		tbl[0] = x;
		for (size_t i = 1; i < tblSize; i++) {
			add(tbl[i], tbl[i - 1], P2);
		}
		z.clear();
		for (size_t i = 0; i < naf.size(); i++) {
			EcT::dbl(z, z);
			local::addTbl(z, tbl, naf, naf.size() - 1 - i);
		}
	}
	/*
		generic mul
		GLV can't be applied in Fp12 - GT
	*/
	static inline void mulGeneric(EcT& z, const EcT& x, const mpz_class& y, bool constTime = false)
	{
		mulArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0, constTime, false);
	}
	/*
		z = sum_{i=0}^{n-1} xVec[i] * yVec[i]
		return min(N, n)
		@note &z != xVec[i]
	*/
private:
	template<class tag, size_t maxBitSize, template<class _tag, size_t _maxBitSize>class FpT>
	static inline size_t mulVecN(EcT& z, const EcT *xVec, const FpT<tag, maxBitSize> *yVec, size_t n)
	{
		const size_t N = mcl::fp::maxMulVecN;
		if (n > N) n = N;
		const int w = 5;
		const size_t tblSize = 1 << (w - 2);
		typedef mcl::FixedArray<int8_t, sizeof(EcT::Fp) * 8 + 1> NafArray;
		NafArray naf[N];
		EcT tbl[N][tblSize];
		size_t maxBit = 0;
		mpz_class y;
		for (size_t i = 0; i < n; i++) {
			bool b;
			yVec[i].getMpz(&b, y);
			assert(b); (void)b;
			gmp::getNAFwidth(&b, naf[i], y, w);
			assert(b); (void)b;
			if (naf[i].size() > maxBit) maxBit = naf[i].size();
			EcT P2;
			EcT::dbl(P2, xVec[i]);
			tbl[i][0] = xVec[i];
			for (size_t j = 1; j < tblSize; j++) {
				EcT::add(tbl[i][j], tbl[i][j - 1], P2);
			}
		}
		z.clear();
		for (size_t i = 0; i < maxBit; i++) {
			EcT::dbl(z, z);
			for (size_t j = 0; j < n; j++) {
				local::addTbl(z, tbl[j], naf[j], maxBit - 1 - i);
			}
		}
		return n;
	}

public:
	template<class tag, size_t maxBitSize, template<class _tag, size_t _maxBitSize>class FpT>
	static inline void mulVec(EcT& z, const EcT *xVec, const FpT<tag, maxBitSize> *yVec, size_t n)
	{
		/*
			mulVecNGLV is a little slow for large n
		*/
		if (mulVecNGLV && n < mcl::fp::maxMulVecNGLV) {
			mpz_class myVec[mcl::fp::maxMulVecNGLV];
			for (size_t i = 0; i < n; i++) {
				bool b;
				yVec[i].getMpz(&b, myVec[i]);
				assert(b); (void)b;
			}
			size_t done = mulVecNGLV(z, xVec, myVec, n);
			assert(done == n); (void)done;
			return;
		}
		EcT r;
		r.clear();
		while (n > 0) {
			EcT t;
			size_t done = mulVecN(t, xVec, yVec, n);
			r += t;
			xVec += done;
			yVec += done;
			n -= done;
		}
		z = r;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	static inline void init(const std::string& astr, const std::string& bstr, int mode = ec::Jacobi)
	{
		bool b;
		init(&b, astr.c_str(), bstr.c_str(), mode);
		if (!b) throw cybozu::Exception("mcl:EcT:init");
	}
	void set(const Fp& _x, const Fp& _y, bool verify = true)
	{
		bool b;
		set(&b, _x, _y, verify);
		if (!b) throw cybozu::Exception("ec:EcT:set") << _x << _y;
	}
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		bool b;
		save(&b, os, ioMode);
		if (!b) throw cybozu::Exception("EcT:save");
	}
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		bool b;
		load(&b, is, ioMode);
		if (!b) throw cybozu::Exception("EcT:load");
	}
#endif
#ifndef CYBOZU_DONT_USE_STRING
	// backward compatilibity
	static inline void setParam(const std::string& astr, const std::string& bstr, int mode = ec::Jacobi)
	{
		init(astr, bstr, mode);
	}
	friend inline std::istream& operator>>(std::istream& is, EcT& self)
	{
		self.load(is, fp::detectIoMode(getIoMode(), is));
		return is;
	}
	friend inline std::ostream& operator<<(std::ostream& os, const EcT& self)
	{
		self.save(os, fp::detectIoMode(getIoMode(), os));
		return os;
	}
#endif
};

template<class Fp> Fp EcT<Fp>::a_;
template<class Fp> Fp EcT<Fp>::b_;
template<class Fp> int EcT<Fp>::specialA_;
template<class Fp> int EcT<Fp>::ioMode_;
template<class Fp> bool EcT<Fp>::verifyOrder_;
template<class Fp> mpz_class EcT<Fp>::order_;
template<class Fp> void (*EcT<Fp>::mulArrayGLV)(EcT& z, const EcT& x, const fp::Unit *y, size_t yn, bool isNegative, bool constTime);
template<class Fp> size_t (*EcT<Fp>::mulVecNGLV)(EcT& z, const EcT *xVec, const mpz_class *yVec, size_t yn);
#ifndef MCL_EC_USE_AFFINE
template<class Fp> int EcT<Fp>::mode_;
#endif

// r = the order of Ec
template<class Ec, class _Fr>
struct GLV1T {
	typedef typename Ec::Fp Fp;
	typedef _Fr Fr;
	static Fp rw; // rw = 1 / w = (-1 - sqrt(-3)) / 2
	static size_t rBitSize;
	static mpz_class v0, v1;
	static mpz_class B[2][2];
public:
#ifndef CYBOZU_DONT_USE_STRING
	static void dump(const mpz_class& x)
	{
		printf("\"%s\",\n", mcl::gmp::getStr(x, 16).c_str());
	}
	static void dump()
	{
		printf("\"%s\",\n", rw.getStr(16).c_str());
		printf("%d,\n", (int)rBitSize);
		dump(v0);
		dump(v1);
		dump(B[0][0]); dump(B[0][1]); dump(B[1][0]); dump(B[1][1]);
	}
#endif
	/*
		L (x, y) = (rw x, y)
	*/
	static void mulLambda(Ec& Q, const Ec& P)
	{
		Fp::mul(Q.x, P.x, rw);
		Q.y = P.y;
		Q.z = P.z;
	}
	/*
		x = a + b * lambda mod r
	*/
	static void split(mpz_class& a, mpz_class& b, const mpz_class& x)
	{
		mpz_class t;
		t = (x * v0) >> rBitSize;
		b = (x * v1) >> rBitSize;
		a = x - (t * B[0][0] + b * B[1][0]);
		b = - (t * B[0][1] + b * B[1][1]);
	}
	static void mul(Ec& Q, const Ec& P, const mpz_class& x, bool /*constTime*/ = false)
	{
		mulVecNGLV(Q, &P, &x, 1);
	}
	static inline size_t mulVecNGLV(Ec& z, const Ec *xVec, const mpz_class *yVec, size_t n)
	{
		const size_t N = mcl::fp::maxMulVecNGLV;
		if (n > N) n = N;
		const int w = 5;
		const mpz_class& r = Fr::getOp().mp;
		const size_t tblSize = 1 << (w - 2);
		typedef mcl::FixedArray<int8_t, sizeof(Fr) * 8 / 2 + 2> NafArray;
		NafArray naf[N][2];
		Ec tbl[N][2][tblSize];
		bool b;
		mpz_class u[2], y;
		size_t maxBit = 0;
		for (size_t i = 0; i < n; i++) {
			y = yVec[i];
			y %= r;
			if (y < 0) {
				y += r;
			}
			split(u[0], u[1], y);

			for (int j = 0; j < 2; j++) {
				gmp::getNAFwidth(&b, naf[i][j], u[j], w);
				assert(b); (void)b;
				if (naf[i][j].size() > maxBit) maxBit = naf[i][j].size();
			}

			Ec P2;
			Ec::dbl(P2, xVec[i]);
			tbl[i][0][0] = xVec[i];
			mulLambda(tbl[i][1][0], tbl[i][0][0]);
			for (size_t j = 1; j < tblSize; j++) {
				Ec::add(tbl[i][0][j], tbl[i][0][j - 1], P2);
				mulLambda(tbl[i][1][j], tbl[i][0][j]);
			}
		}
		z.clear();
		for (size_t i = 0; i < maxBit; i++) {
			Ec::dbl(z, z);
			for (size_t j = 0; j < n; j++) {
				local::addTbl(z, tbl[j][0], naf[j][0], maxBit - 1 - i);
				local::addTbl(z, tbl[j][1], naf[j][1], maxBit - 1 - i);
			}
		}
		return n;
	}
	static void mulArrayGLV(Ec& z, const Ec& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		mpz_class s;
		bool b;
		mcl::gmp::setArray(&b, s, y, yn);
		assert(b);
		if (isNegative) s = -s;
		mul(z, x, s, constTime);
	}
	/*
		initForBN() is defined in bn.hpp
	*/
	static void initForSecp256k1()
	{
		bool b = Fp::squareRoot(rw, -3);
		assert(b);
		(void)b;
		rw = -(rw + 1) / 2;
		rBitSize = Fr::getOp().bitSize;
		rBitSize = (rBitSize + fp::UnitBitSize - 1) & ~(fp::UnitBitSize - 1);
		gmp::setStr(&b, B[0][0], "0x3086d221a7d46bcde86c90e49284eb15");
		assert(b); (void)b;
		gmp::setStr(&b, B[0][1], "-0xe4437ed6010e88286f547fa90abfe4c3");
		assert(b); (void)b;
		gmp::setStr(&b, B[1][0], "0x114ca50f7a8e2f3f657c1108d9d44cfd8");
		assert(b); (void)b;
		B[1][1] = B[0][0];
		const mpz_class& r = Fr::getOp().mp;
		v0 = ((B[1][1]) << rBitSize) / r;
		v1 = ((-B[0][1]) << rBitSize) / r;
	}
};

// rw = 1 / w = (-1 - sqrt(-3)) / 2
template<class Ec, class Fr> typename Ec::Fp GLV1T<Ec, Fr>::rw;
template<class Ec, class Fr> size_t GLV1T<Ec, Fr>::rBitSize;
template<class Ec, class Fr> mpz_class GLV1T<Ec, Fr>::v0;
template<class Ec, class Fr> mpz_class GLV1T<Ec, Fr>::v1;
template<class Ec, class Fr> mpz_class GLV1T<Ec, Fr>::B[2][2];

/*
	Ec : elliptic curve
	Zn : cyclic group of the order |Ec|
	set P the generator of Ec if P != 0
*/
template<class Ec, class Zn>
void initCurve(bool *pb, int curveType, Ec *P = 0, mcl::fp::Mode mode = fp::FP_AUTO, mcl::ec::Mode ecMode = ec::Jacobi)
{
	typedef typename Ec::Fp Fp;
	*pb = false;
	const EcParam *ecParam = getEcParam(curveType);
	if (ecParam == 0) return;

	Zn::init(pb, ecParam->n, mode);
	if (!*pb) return;
	Fp::init(pb, ecParam->p, mode);
	if (!*pb) return;
	Ec::init(pb, ecParam->a, ecParam->b, ecMode);
	if (!*pb) return;
	if (P) {
		Fp x, y;
		x.setStr(pb, ecParam->gx);
		if (!*pb) return;
		y.setStr(pb, ecParam->gy);
		if (!*pb) return;
		P->set(pb, x, y);
		if (!*pb) return;
	}
	if (curveType == MCL_SECP256K1) {
		GLV1T<Ec, Zn>::initForSecp256k1();
		Ec::setMulArrayGLV(GLV1T<Ec, Zn>::mulArrayGLV, GLV1T<Ec, Zn>::mulVecNGLV);
	} else {
		Ec::setMulArrayGLV(0);
	}
}

#ifndef CYBOZU_DONT_USE_EXCEPTION
template<class Ec, class Zn>
void initCurve(int curveType, Ec *P = 0, mcl::fp::Mode mode = fp::FP_AUTO, mcl::ec::Mode ecMode = ec::Jacobi)
{
	bool b;
	initCurve<Ec, Zn>(&b, curveType, P, mode, ecMode);
	if (!b) throw cybozu::Exception("mcl:initCurve") << curveType << mode << ecMode;
}
#endif

} // mcl

#ifndef CYBOZU_DONT_USE_EXCEPTION
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
#endif

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
