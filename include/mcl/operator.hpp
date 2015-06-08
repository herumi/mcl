#pragma once
/**
	@file
	@brief operator
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <ios>
#include <cybozu/exception.hpp>

#ifdef _WIN32
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

namespace mcl { namespace ope {

template<class T>
struct Empty {};

/*
	T must have compare
*/
template<class T, class E = Empty<T> >
struct comparable : E {
	friend MCL_FORCE_INLINE bool operator<(const T& x, const T& y) { return T::compare(x, y) < 0; }
	friend MCL_FORCE_INLINE bool operator>=(const T& x, const T& y) { return !operator<(x, y); }

	friend MCL_FORCE_INLINE bool operator>(const T& x, const T& y) { return T::compare(x, y) > 0; }
	friend MCL_FORCE_INLINE bool operator<=(const T& x, const T& y) { return !operator>(x, y); }
	friend MCL_FORCE_INLINE bool operator==(const T& x, const T& y) { return T::compare(x, y) == 0; }
	friend MCL_FORCE_INLINE bool operator!=(const T& x, const T& y) { return !operator==(x, y); }
};

/*
	T must have add, sub
*/
template<class T, class E = Empty<T> >
struct addsub : E {
	template<class S> MCL_FORCE_INLINE T& operator+=(const S& rhs) { T::add(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> MCL_FORCE_INLINE T& operator-=(const S& rhs) { T::sub(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator+(const T& a, const S& b) { T c; T::add(c, a, b); return c; }
	template<class S> friend MCL_FORCE_INLINE T operator-(const T& a, const S& b) { T c; T::sub(c, a, b); return c; }
};

/*
	T must have mul
*/
template<class T, class E = Empty<T> >
struct mulable : E {
	template<class S> MCL_FORCE_INLINE T& operator*=(const S& rhs) { T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator*(const T& a, const S& b) { T c; T::mul(c, a, b); return c; }
};

/*
	T must have inv, mul
*/
template<class T, class E = Empty<T> >
struct invertible : E {
	MCL_FORCE_INLINE T& operator/=(const T& rhs) { T c; T::inv(c, rhs); T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), c); return static_cast<T&>(*this); }
	friend MCL_FORCE_INLINE T operator/(const T& a, const T& b) { T c; T::inv(c, b); T::mul(c, c, a); return c; }
};

/*
	T must have neg
*/
template<class T, class E = Empty<T> >
struct hasNegative : E {
	MCL_FORCE_INLINE T operator-() const { T c; T::neg(c, static_cast<const T&>(*this)); return c; }
};

template<class T, class E = Empty<T> >
struct hasIO : E {
	friend inline std::ostream& operator<<(std::ostream& os, const T& self)
	{
		const std::ios_base::fmtflags f = os.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator<<:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 10;
		const bool showBase = (f & std::ios_base::showbase) != 0;
		std::string str;
		self.getStr(str, base, showBase);
		return os << str;
	}
	friend inline std::istream& operator>>(std::istream& is, T& self)
	{
		const std::ios_base::fmtflags f = is.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator>>:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 0;
		std::string str;
		is >> str;
		self.setStr(str, base);
		return is;
	}
};

} } // mcl::ope

#ifdef _WIN32
//	#pragma warning(pop)
#endif
