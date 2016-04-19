#pragma once
/**
	@file
	@brief operator class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>
#include <mcl/util.hpp>
#ifdef _MSC_VER
	#ifndef MCL_FORCE_INLINE
		#define MCL_FORCE_INLINE __forceinline
	#endif
	#pragma warning(push)
	#pragma warning(disable : 4714)
#else
	#ifndef MCL_FORCE_INLINE
		#define MCL_FORCE_INLINE __attribute__((always_inline))
	#endif
#endif

namespace mcl { namespace fp {

template<class T>
struct Empty {};

/*
	T must have add, sub, mul, inv, neg
*/
template<class T, class E = Empty<T> >
struct Operator : E {
	template<class S> MCL_FORCE_INLINE T& operator+=(const S& rhs) { T::add(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> MCL_FORCE_INLINE T& operator-=(const S& rhs) { T::sub(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator+(const T& a, const S& b) { T c; T::add(c, a, b); return c; }
	template<class S> friend MCL_FORCE_INLINE T operator-(const T& a, const S& b) { T c; T::sub(c, a, b); return c; }
	template<class S> MCL_FORCE_INLINE T& operator*=(const S& rhs) { T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator*(const T& a, const S& b) { T c; T::mul(c, a, b); return c; }
	MCL_FORCE_INLINE T& operator/=(const T& rhs) { T c; T::inv(c, rhs); T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), c); return static_cast<T&>(*this); }
	friend MCL_FORCE_INLINE void div(const T& z, const T& x, const T& y) { T t; T::inv(t, y); T::mul(z, x, t); }
	friend MCL_FORCE_INLINE T operator/(const T& a, const T& b) { T c; T::inv(c, b); T::mul(c, c, a); return c; }
	MCL_FORCE_INLINE T operator-() const { T c; T::neg(c, static_cast<const T&>(*this)); return c; }
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
	static inline void power(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powerArray(z, x, b.p, b.n, false);
	}
	static inline void power(T& z, const T& x, int y)
	{
		const Unit u = abs(y);
		powerArray(z, x, &u, 1, y < 0);
	}
	static inline void power(T& z, const T& x, const mpz_class& y)
	{
		powerArray(z, x, gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0);
	}
private:
	static inline void powerArray(T& z, const T& x, const Unit *y, size_t yn, bool isNegative)
	{
		T tmp;
		const T *px = &x;
		if (&z == &x) {
			tmp = x;
			px = &tmp;
		}
		z = 1;
		fp::powerGeneric(z, *px, y, yn, T::mul, T::sqr);
		if (isNegative) {
			T::inv(z, z);
		}
	}
};

} } // mcl::fp

