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
template<class T, class Tout, class Tin, size_t N = 256>
size_t invVecT(Tout& y, Tin& x, size_t n)
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
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
	static void pow(T& z, const T& x, const FpT<tag2, maxBitSize2>& y)
	{
		typedef FpT<tag2, maxBitSize2> F;
		fp::getMpzAtType getMpzAt = fp::getMpzAtT<F>;
		fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
		if (powVecGLV) {
			powVecGLV(z, &x, &y, 1, getMpzAt, getUnitAt);
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
	template<class tag2, size_t maxBitSize2, template<class _tag, size_t _maxBitSize> class FpT>
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
	static bool (*powVecGLV)(T& z, const T *xVec, const void *yVec, size_t yn, fp::getMpzAtType getMpzAt, fp::getUnitAtType getUnitAt);
	static void powArray(T& z, const T& x, const Unit *y, size_t yn, bool isNegative = false)
	{
		while (yn > 0 && y[yn - 1] == 0) {
			yn--;
		}
		if (yn == 0) {
			z = 1;
			return;
		}
		const size_t w = 4;
		const size_t N = 1 << w;
		uint8_t idxTbl[sizeof(T) * 8 / w];
		mcl::fp::BitIterator<Unit> iter(y, yn);
		size_t idxN = 0;
		while (iter.hasNext()) {
			assert(idxN < sizeof(idxTbl));
			idxTbl[idxN++] = iter.getNext(w);
		}
		assert(idxN > 0);
		T tbl[N];
		tbl[1] = x;
		for (size_t i = 2; i < N; i++) {
			tbl[i] = tbl[i-1] * x;
		}
		uint32_t idx = idxTbl[idxN - 1];
		z = idx == 0 ? 1 : tbl[idx];
		for (size_t i = 1; i < idxN; i++) {
			for (size_t j = 0; j < w; j++) {
				T::sqr(z, z);
			}
			idx = idxTbl[idxN - 1 - i];
			if (idx) {
				z *= tbl[idx];
			}
		}
		if (isNegative) {
			T::inv(z, z);
		}
	}
};

template<class T, class E>
bool (*Operator<T, E>::powVecGLV)(T& z, const T *xVec, const void *yVec, size_t yn, fp::getMpzAtType getMpzAt, fp::getUnitAtType getUnitAt);

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
size_t invVec(T *y, const T* x, size_t n)
{
	mcl::local::AsConstArray<T> in(x);
	return invVecT<T>(y, in, n);
}

} // mcl::fp

