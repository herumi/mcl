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
struct Operator : public E {
	template<class S> MCL_FORCE_INLINE T& operator+=(const S& rhs) { T::add(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> MCL_FORCE_INLINE T& operator-=(const S& rhs) { T::sub(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator+(const T& a, const S& b) { T c; T::add(c, a, b); return c; }
	template<class S> friend MCL_FORCE_INLINE T operator-(const T& a, const S& b) { T c; T::sub(c, a, b); return c; }
	template<class S> MCL_FORCE_INLINE T& operator*=(const S& rhs) { T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	template<class S> friend MCL_FORCE_INLINE T operator*(const T& a, const S& b) { T c; T::mul(c, a, b); return c; }
	MCL_FORCE_INLINE T& operator/=(const T& rhs) { T c; T::inv(c, rhs); T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), c); return static_cast<T&>(*this); }
	static MCL_FORCE_INLINE void div(T& c, const T& a, const T& b) { T t; T::inv(t, b); T::mul(c, a, t); }
	friend MCL_FORCE_INLINE T operator/(const T& a, const T& b) { T c; T::inv(c, b); c *= a; return c; }
	MCL_FORCE_INLINE T operator-() const { T c; T::neg(c, static_cast<const T&>(*this)); return c; }
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
	static void pow(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powArray(z, x, b.p, b.n, false, false);
	}
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
	static void powGeneric(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powArrayBase(z, x, b.p, b.n, false, false);
	}
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
	static void powCT(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powArray(z, x, b.p, b.n, false, true);
	}
	static void pow(T& z, const T& x, int64_t y)
	{
		const uint64_t u = fp::abs_(y);
#if MCL_SIZEOF_UNIT == 8
		powArray(z, x, &u, 1, y < 0, false);
#else
		uint32_t ua[2] = { uint32_t(u), uint32_t(u >> 32) };
		size_t un = ua[1] ? 2 : 1;
		powArray(z, x, ua, un, y < 0, false);
#endif
	}
	static void pow(T& z, const T& x, const mpz_class& y)
	{
		powArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0, false);
	}
	static void powGeneric(T& z, const T& x, const mpz_class& y)
	{
		powArrayBase(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0, false);
	}
	static void powCT(T& z, const T& x, const mpz_class& y)
	{
		powArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0, true);
	}
	static void setPowArrayGLV(void f(T& z, const T& x, const Unit *y, size_t yn, bool isNegative, bool constTime), size_t g(T& z, const T *xVec, const mpz_class *yVec, size_t n) = 0)
	{
		powArrayGLV = f;
		powVecNGLV = g;
	}
	static const size_t powVecMaxN = 16;
	template<class tag, size_t maxBitSize, template<class _tag, size_t _maxBitSize>class FpT>
	static void powVec(T& z, const T* xVec, const FpT<tag, maxBitSize> *yVec, size_t n)
	{
		assert(powVecNGLV);
		T r;
		r.setOne();
		const size_t N = mcl::fp::maxMulVecNGLV;
		mpz_class myVec[N];
		while (n > 0) {
			T t;
			size_t tn = fp::min_(n, N);
			for (size_t i = 0; i < tn; i++) {
				bool b;
				yVec[i].getMpz(&b, myVec[i]);
				assert(b); (void)b;
			}
			size_t done = powVecNGLV(t, xVec, myVec, tn);
			r *= t;
			xVec += done;
			yVec += done;
			n -= done;
		}
		z = r;
	}
private:
	static void (*powArrayGLV)(T& z, const T& x, const Unit *y, size_t yn, bool isNegative, bool constTime);
	static size_t (*powVecNGLV)(T& z, const T* xVec, const mpz_class *yVec, size_t n);
	static void powArray(T& z, const T& x, const Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		if (powArrayGLV && (constTime || yn > 1)) {
			powArrayGLV(z, x, y, yn, isNegative, constTime);
			return;
		}
		powArrayBase(z, x, y, yn, isNegative, constTime);
	}
	static void powArrayBase(T& z, const T& x, const Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		T tmp;
		const T *px = &x;
		if (&z == &x) {
			tmp = x;
			px = &tmp;
		}
		z = 1;
		fp::powGeneric(z, *px, y, yn, T::mul, T::sqr, (void (*)(T&, const T&))0, constTime ? T::BaseFp::getBitSize() : 0);
		if (isNegative) {
			T::inv(z, z);
		}
	}
};

template<class T, class E>
void (*Operator<T, E>::powArrayGLV)(T& z, const T& x, const Unit *y, size_t yn, bool isNegative, bool constTime);

template<class T, class E>
size_t (*Operator<T, E>::powVecNGLV)(T& z, const T* xVec, const mpz_class *yVec, size_t n);

/*
	T must have save and load
*/
template<class T, class E = Empty<T> >
struct Serializable : public E {
	void setStr(bool *pb, const char *str, int ioMode = 0)
	{
		size_t len = strlen(str);
		size_t n = deserialize(str, len, ioMode);
		*pb = n > 0 && n == len;
	}
	// return strlen(buf) if success else 0
	size_t getStr(char *buf, size_t maxBufSize, int ioMode = 0) const
	{
		size_t n = serialize(buf, maxBufSize, ioMode);
		if (n == 0 || n == maxBufSize - 1) return 0;
		buf[n] = '\0';
		return n;
	}
#ifndef CYBOZU_DONT_USE_STRING
	void setStr(const std::string& str, int ioMode = 0)
	{
		cybozu::StringInputStream is(str);
		static_cast<T&>(*this).load(is, ioMode);
	}
	void getStr(std::string& str, int ioMode = 0) const
	{
		str.clear();
		cybozu::StringOutputStream os(str);
		static_cast<const T&>(*this).save(os, ioMode);
	}
	std::string getStr(int ioMode = 0) const
	{
		std::string str;
		getStr(str, ioMode);
		return str;
	}
	std::string serializeToHexStr() const
	{
		std::string str(sizeof(T) * 2, 0);
		size_t n = serialize(&str[0], str.size(), IoSerializeHexStr);
		str.resize(n);
		return str;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	void deserializeHexStr(const std::string& str)
	{
		size_t n = deserialize(str.c_str(), str.size(), IoSerializeHexStr);
		if (n == 0) throw cybozu::Exception("bad str") << str;
	}
#endif
#endif
	// return written bytes
	size_t serialize(void *buf, size_t maxBufSize, int ioMode = IoSerialize) const
	{
		cybozu::MemoryOutputStream os(buf, maxBufSize);
		bool b;
		static_cast<const T&>(*this).save(&b, os, ioMode);
		return b ? os.getPos() : 0;
	}
	// return read bytes
	size_t deserialize(const void *buf, size_t bufSize, int ioMode = IoSerialize)
	{
		cybozu::MemoryInputStream is(buf, bufSize);
		bool b;
		static_cast<T&>(*this).load(&b, is, ioMode);
		return b ? is.getPos() : 0;
	}
};

} } // mcl::fp

