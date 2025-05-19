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

namespace mcl {

namespace local {

template<class T>
struct AsConstArray {
	const T *p;
	AsConstArray(const T *p) : p(p) {}
	const T& operator[](size_t i) const { return p[i]; }
	void operator+=(size_t i) { p += i; }
};

template<class Tout, class Tin, class T>
size_t invVecWork(Tout& y, Tin& x, size_t n, T *t)
{
	size_t pos = 0;
	for (size_t i = 0; i < n; i++) {
		if (!(x[i].isZero() || x[i].isOne())) {
			if (pos == 0) {
				t[pos] = x[i];
			} else {
				T::mul(t[pos], t[pos - 1], x[i]);
			}
			pos++;
		}
	}
	const size_t retNum = pos;
	T inv;
	if (pos > 0) {
		T::inv(inv, t[pos - 1]);
		pos--;
	}
	bool x_is_equal_y = &x[0] == &y[0];
	for (size_t i = 0; i < n; i++) {
		const size_t idx = n - 1 - i;
		if (x[idx].isZero() || x[idx].isOne()) {
			if (!x_is_equal_y) y[idx] = x[idx];
		} else {
			if (pos > 0) {
				if (x_is_equal_y) {
					T tmp = x[idx];
					T::mul(y[idx], inv, t[pos - 1]);
					inv *= tmp;
				} else {
					T::mul(y[idx], inv, t[pos - 1]);
					inv *= x[idx];
				}
				pos--;
			} else {
				y[idx] = inv;
			}
		}
	}
	return retNum;
}

} // mcl::local

/*
	template version of invVec
	y[i] = 1/x[i] for x[i] != 0 else 0
	return num of x[i] not in {0, 1}
	t must be T[n]
	x[i] returns i-th const T&
*/
template<class T, class Tout, class Tin>
size_t invVecT(Tout& y, Tin& x, size_t n, size_t N = 1024)
{
	T *t = (T*)CYBOZU_ALLOCA(sizeof(T) * N);
	size_t retNum = 0;
	for (;;) {
		size_t doneN = (n < N) ? n : N;
		retNum += mcl::local::invVecWork(y, x, doneN, t);
		n -= doneN;
		if (n == 0) return retNum;
		y += doneN;
		x += doneN;
	}
}

namespace fp {

typedef void (*getMpzAtType)(mpz_class&, const void *, size_t);
typedef void (*getUnitAtType)(Unit *, const void *, size_t);

template<class F>
void getMpzAtT(mpz_class& v, const void *_xVec, size_t i)
{
	const F* xVec = (const F*)_xVec;
	bool b;
	xVec[i].getMpz(&b, v);
	assert(b); (void)b;
}

template<class F>
void getUnitAtT(Unit *p, const void *_xVec, size_t i)
{
	const F* xVec = (const F*)_xVec;
	xVec[i].getUnitArray(p);
}

/*
	len(bin) = sizeof(Unit) * xn + 1
	bin[i] = 0 or (|bin[i]| <= 2^w-1 and odd)
	x = sum_i bin[ret-1-i] 2^i
	return the size of bin
	return 1 if x == 0
*/
inline size_t getBinWidth(uint8_t *bin, size_t maxBinN, const Unit *_x, size_t xn, size_t w)
{
	Unit *x = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * xn);
	bint::copyN(x, _x, xn);
	size_t pos = 0;
	size_t zeroNum = 0;
	const Unit maskW = (Unit(1) << w) - 1;
	while (!bint::isZeroN(x, xn)) {
		size_t z = gmp::getLowerZeroBitNum(x, xn);
		if (z) {
			xn = bint::shiftRight(x, x, z, xn);
			zeroNum += z;
		}
		for (size_t i = 0; i < zeroNum; i++) {
			if (pos == maxBinN) return 0;
			bin[pos++] = 0;
		}
		int v = x[0] & maskW;
		xn = bint::shiftRight(x, x, w, xn);
		if (pos == maxBinN) return 0;
		bin[pos++] = v;
		zeroNum = w - 1;
	}
	if (pos == 0) {
		bin[0] = 0;
		return 1;
	}
	return pos;
}

// argmin (size//w + 2**(w-1))
inline size_t argminWforPow(size_t size)
{
	if (size <= 12) return 2;
	if (size <= 56) return 3;
	if (size <= 175) return 4;
	return 5;
}

// z = x^y[yn]
template<class F>
void powUnit(F& z, const F& x, const Unit *y, size_t yn)
{
	if (yn == 0) {
		z = 1;
		return;
	}
	yn = bint::getRealSize(y, yn);
	if (yn == 1) {
		switch (y[0]) {
		case 0:
			z = 1;
			return;
		case 1:
			z = x;
			return;
		case 2:
			F::sqr(z, x);
			return;
		case 3:
			{
				F t;
				F::sqr(t, x);
				F::mul(z, t, x);
			}
			return;
		case 4:
			F::sqr(z, x);
			F::sqr(z, z);
			return;
		}
	}
	const size_t w = argminWforPow(mcl::fp::getBitSize(y, yn));
	size_t bn = sizeof(Unit) * 8 * yn + 1;
	uint8_t *bin = (uint8_t*)CYBOZU_ALLOCA(bn);
	bn = getBinWidth(bin, bn, y, yn, w);
	assert(bn > 0);
	const size_t tblSize = size_t(1) << (w - 1);
	F *tbl = (F*)CYBOZU_ALLOCA(sizeof(F) * tblSize);
	tbl[0] = x;
	F x2;
	F::sqr(x2, x);
	for (size_t i = 1; i < tblSize; i++) {
		F::mul(tbl[i], tbl[i - 1], x2);
	}
	z = 1;
	for (size_t i = 0; i < bn; i++) {
		F::sqr(z, z);
		uint8_t v = bin[bn-1-i];
		if (v) {
			F::mul(z, z, tbl[(v-1)/2]);
		}
	}
}

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

	/*
		powGeneric = pow if T = Fp, Fp2, Fp6
		pow is for GT (use GLV method and unitaryInv)
		powGeneric is for Fp12
	*/
	template<int tag2, size_t maxBitSize2, template<int _tag, size_t _maxBitSize> class FpT>
	static void pow(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		if (powVecGLV) {
			powVecGLV(z, &x, &y, 1);
			return;
		}
		fp::Block b;
		y.getBlock(b);
		powArray(z, x, b.p, b.n);
	}
	static void pow(T& z, const T& x, int64_t y)
	{
		const uint64_t u = fp::abs_(y);
#if MCL_SIZEOF_UNIT == 8
		const uint64_t *ua = &u;
		const size_t un = 1;
#else
		uint32_t ua[2] = { uint32_t(u), uint32_t(u >> 32) };
		const size_t un = ua[1] ? 2 : 1;
#endif
		powArray(z, x, ua, un, y < 0);
	}
	static void pow(T& z, const T& x, const mpz_class& y)
	{
		powArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0);
	}
	template<int tag2, size_t maxBitSize2, template<int _tag, size_t _maxBitSize> class FpT>
	static void powGeneric(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powArray(z, x, b.p, b.n);
	}
	static void powGeneric(T& z, const T& x, const mpz_class& y)
	{
		powArray(z, x, gmp::getUnit(y), gmp::getUnitSize(y), y < 0);
	}
protected:
	static bool (*powVecGLV)(T& z, const T *xVec, const void *yVec, size_t yn);
	static void powArray(T& z, const T& x, const Unit *y, size_t yn, bool isNegative = false)
	{
		powUnit(z, x, y, yn);
		if (isNegative) {
			T::inv(z, z);
		}
	}
};

template<class T, class E>
bool (*Operator<T, E>::powVecGLV)(T& z, const T *xVec, const void *yVec, size_t yn);

/*
	T must have save and load
*/
template<class T, class E = Empty<T> >
struct Serializable : public E {
	// may set *pb = false if the size of str is too large.
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
	// may throw exception if the size of str is too large.
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

}

// array version of invVec
template<class T>
size_t invVec(T *y, const T* x, size_t n, size_t N = 256)
{
	mcl::local::AsConstArray<T> in(x);
	return invVecT<T>(y, in, n, N);
}

} // mcl

