#pragma once
/**
	@file
	@brief functions for T[]
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>
#include <cybozu/bit_operation.hpp>

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4456)
	#pragma warning(disable : 4459)
#endif

namespace mcl { namespace fp {

/*
	get pp such that p * pp = -1 mod M,
	where p is prime and M = 1 << 64(or 32).
	@param pLow [in] p mod M
*/
template<class T>
T getMontgomeryCoeff(T pLow)
{
	T ret = 0;
	T t = 0;
	T x = 1;
	for (size_t i = 0; i < sizeof(T) * 8; i++) {
		if ((t & 1) == 0) {
			t += pLow;
			ret += x;
		}
		t >>= 1;
		x <<= 1;
	}
	return ret;
}

template<class T>
int compareArray(const T* x, const T* y, size_t n)
{
	for (size_t i = n - 1; i != size_t(-1); i--) {
		T a = x[i];
		T b = y[i];
		if (a != b) return a < b ? -1 : 1;
	}
	return 0;
}

template<class T>
bool isLessArray(const T *x, const T* y, size_t n)
{
	for (size_t i = n - 1; i != size_t(-1); i--) {
		T a = x[i];
		T b = y[i];
		if (a != b) return a < b;
	}
	return false;
}

template<class T>
bool isGreaterOrEqualArray(const T *x, const T* y, size_t n)
{
	return !isLessArray(x, y, n);
}

template<class T>
bool isLessOrEqualArray(const T *x, const T* y, size_t n)
{
	for (size_t i = n - 1; i != size_t(-1); i--) {
		T a = x[i];
		T b = y[i];
		if (a != b) return a < b;
	}
	return true;
}

template<class T>
bool isGreaterArray(const T *x, const T* y, size_t n)
{
	return !isLessOrEqualArray(x, y, n);
}

template<class T>
bool isEqualArray(const T* x, const T* y, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i] != y[i]) return false;
	}
	return true;
}

template<class T>
bool isZeroArray(const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i]) return false;
	}
	return true;
}

template<class T>
void clearArray(T *x, size_t begin, size_t end)
{
	for (size_t i = begin; i < end; i++) x[i] = 0;
}

template<class T>
void copyArray(T *y, const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

/*
	x &= (1 << bitSize) - 1
*/
template<class T>
void maskArray(T *x, size_t n, size_t bitSize)
{
	const size_t TbitSize = sizeof(T) * 8;
	assert(bitSize <= TbitSize * n);
	const size_t q = bitSize / TbitSize;
	const size_t r = bitSize % TbitSize;
	if (r) {
		x[q] &= (T(1) << r) - 1;
		clearArray(x, q + 1, n);
	} else {
		clearArray(x, q, n);
	}
}

/*
	return non zero size of x[]
	return 1 if x[] == 0
*/
template<class T>
size_t getNonZeroArraySize(const T *x, size_t n)
{
	assert(n > 0);
	while (n > 0) {
		if (x[n - 1]) return n;
		n--;
	}
	return 1;
}

namespace impl {

template<class T, class RG>
static void readN(T* out, size_t n, RG& rg)
{
	if (sizeof(T) == 8) {
		for (size_t i = 0; i < n; i++) {
			T L = rg();
			T H = rg();
			out[i] = L | (uint64_t(H) << 32);
		}
	} else {
		for (size_t i = 0; i < n; i++) {
			out[i] = rg();
		}
	}
}

} // impl
/*
	get random value less than in[]
	n = (bitSize + sizeof(T) * 8) / (sizeof(T) * 8)
	input  in[0..n)
	output out[n..n)
	0 <= out < in
*/
template<class RG, class T>
void getRandVal(T *out, RG& rg, const T *in, size_t bitSize)
{
	const size_t TbitSize = sizeof(T) * 8;
	const size_t n = (bitSize + TbitSize - 1) / TbitSize;
	const size_t rem = bitSize & (TbitSize - 1);
	for (;;) {
		impl::readN(out, n, rg);
//		rg.read(out, n);
		if (rem > 0) out[n - 1] &= (T(1) << rem) - 1;
		if (isLessArray(out, in, n)) return;
	}
}

/*
	@param out [inout] : set element of G ; out = x^y[]
	@param x [in]
	@param y [in]
	@param n [in] size of y[]
	@param constTime [in] use const-time method depending on only bit length of y if true
	@note &out != x and out = the unit element of G
*/
template<class G, class T>
void powGeneric(G& out, const G& x_, const T *y, size_t n, void mul(G&, const G&, const G&) , void sqr(G&, const G&), bool constTime = false)
{
	assert(&out != &x_);
	while (n > 0) {
		if (y[n - 1]) break;
		n--;
	}
	if (n == 0) return;
	if (n == 1) {
		switch (y[0]) {
		case 1:
			out = x_;
			return;
		case 2:
			sqr(out, x_);
			return;
		case 3:
			sqr(out, x_);
			mul(out, out, x_);
			return;
		case 4:
			sqr(out, x_);
			sqr(out, out);
			return;
		}
	}
	G tbl[4]; // tbl = { discard, x, x^2, x^3 }
	G x(x_);
	x.normalize();
	tbl[0] = x;
	tbl[1] = x;
	sqr(tbl[2], tbl[1]); tbl[2].normalize();
	mul(tbl[3], tbl[2], x); tbl[3].normalize();
	T v = y[n - 1];
	int m = cybozu::bsr<T>(v);
	if (m & 1) {
		m--;
		T idx = (v >> m) & 3;
		assert(idx > 0);
		out = tbl[idx];
	} else {
		out = x;
	}
	if (constTime) {
		G *pTbl[] = { &tbl[0], &out, &out, &out };
		for (int i = (int)n - 1; i >= 0; i--) {
			T v = y[i];
			for (int j = m - 2; j >= 0; j -= 2) {
				sqr(out, out);
				sqr(out, out);
				T idx = (v >> j) & 3;
				mul(*pTbl[idx], *pTbl[idx], tbl[idx]);
			}
			m = (int)sizeof(T) * 8;
		}
	} else {
		for (int i = (int)n - 1; i >= 0; i--) {
			T v = y[i];
			for (int j = m - 2; j >= 0; j -= 2) {
				sqr(out, out);
				sqr(out, out);
				T idx = (v >> j) & 3;
				if (idx > 0) {
					mul(out, out, tbl[idx]);
				}
			}
			m = (int)sizeof(T) * 8;
		}
	}
}

/*
	shortcut of multiplication by Unit
*/
template<class T, class U>
bool mulSmallUnit(T& z, const T& x, U y)
{
	switch (y) {
	case 0: z.clear(); break;
	case 1: z = x; break;
	case 2: T::add(z, x, x); break;
	case 3: { T t; T::add(t, x, x); T::add(z, t, x); break; }
	case 4: T::add(z, x, x); T::add(z, z, z); break;
	case 5: { T t; T::add(t, x, x); T::add(t, t, t); T::add(z, t, x); break; }
	case 6: { T t; T::add(t, x, x); T::add(t, t, x); T::add(z, t, t); break; }
	case 7: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, t); T::sub(z, t, x); break; }
	case 8: T::add(z, x, x); T::add(z, z, z); T::add(z, z, z); break;
	case 9: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, t); T::add(z, t, x); break; }
	case 10: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, x); T::add(z, t, t); break; }
	default:
		return false;
	}
	return true;
}

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
