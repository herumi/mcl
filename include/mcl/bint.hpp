#pragma once
/*
	@file
	@brief low level functions
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/config.hpp>
#include <cybozu/bit_operation.hpp>
#include <assert.h>

//#define MCL_BINT_ASM 1
#ifdef MCL_WASM32
	#define MCL_BINT_ASM 0
#endif
#ifndef MCL_BINT_ASM
	#define MCL_BINT_ASM 0 //1
#endif

namespace mcl { namespace bint {

inline void dump(const Unit *x, size_t n, const char *msg = "")
{
	if (msg) printf("%s ", msg);
	for (size_t i = 0; i < n; i++) {
#if MCL_SIZEOF_UNIT == 4
		printf("%08x", x[n - 1 - i]);
#else
		uint64_t v = x[n - 1 - i];
		printf("%08x%08x", uint32_t(v >> 32), uint32_t(v));
#endif
	}
	printf("\n");
}

/*
	[H:L] <= x * y
	@return L
*/
inline uint32_t mulUnit1(uint32_t *pH, uint32_t x, uint32_t y)
{
	uint64_t t = uint64_t(x) * y;
	*pH = uint32_t(t >> 32);
	return uint32_t(t);
}

/*
	q = [H:L] / y
	r = [H:L] % y
	return q
*/
inline uint32_t divUnit1(uint32_t *pr, uint32_t H, uint32_t L, uint32_t y)
{
	assert(H < y);
	uint64_t t = (uint64_t(H) << 32) | L;
	uint32_t q = uint32_t(t / y);
	*pr = uint32_t(t % y);
	return q;
}

#if MCL_SIZEOF_UNIT == 8

#if !defined(_MSC_VER) || defined(__INTEL_COMPILER) || defined(__clang__)
typedef __attribute__((mode(TI))) unsigned int uint128_t;
#define MCL_DEFINED_UINT128_T
#endif

inline uint64_t mulUnit1(uint64_t *pH, uint64_t x, uint64_t y)
{
#ifdef MCL_DEFINED_UINT128_T
	uint128_t t = uint128_t(x) * y;
	*pH = uint64_t(t >> 64);
	return uint64_t(t);
#else
	return _umul128(x, y, pH);
#endif
}

inline uint64_t divUnit1(uint64_t *pr, uint64_t H, uint64_t L, uint64_t y)
{
	assert(H < y);
#ifdef MCL_DEFINED_UINT128_T
	uint128_t t = (uint128_t(H) << 64) | L;
	uint64_t q = uint64_t(t / y);
	*pr = uint64_t(t % y);
	return q;
#else
	return _udiv128(H, L, y, pr);
#endif
}

#endif // MCL_SIZEOF_UNIT == 8

// z[N] = x[N] + y[N] and return CF(0 or 1)
template<size_t N>Unit addT(Unit *z, const Unit *x, const Unit *y);
// z[N] = x[N] - y[N] and return CF(0 or 1)
template<size_t N>Unit subT(Unit *z, const Unit *x, const Unit *y);
// [ret:z[N]] = x[N] * y
template<size_t N>Unit mulUnitT(Unit *z, const Unit *x, Unit y);
// [ret:z[N]] = z[N] + x[N] * y
template<size_t N>Unit mulUnitAddT(Unit *z, const Unit *x, Unit y);

Unit addN(Unit *z, const Unit *x, const Unit *y, size_t n);
Unit subN(Unit *z, const Unit *x, const Unit *y, size_t n);
Unit mulUnitN(Unit *z, const Unit *x, Unit y, size_t n);
Unit mulUnitAddN(Unit *z, const Unit *x, Unit y, size_t n);
// z[n * 2] = x[n] * y[n]
void mulN(Unit *z, const Unit *x, const Unit *y, size_t n);
// y[n * 2] = x[n] * x[n]
void sqrN(Unit *y, const Unit *x, size_t xn);
// z[xn * yn] = x[xn] * y[ym]
void mulNM(Unit *z, const Unit *x, size_t xn, const Unit *y, size_t yn);

// explicit specialization of template functions and external asm functions
#include "bint_asm.hpp"

template<size_t N, typename T>
void copyT(T *y, const T *x)
{
	for (size_t i = 0; i < N; i++) y[i] = x[i];
}

// y[n] = x[n]
template<typename T>
void copyN(T *y, const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

template<size_t N, typename T>
void clearT(T *x)
{
	for (size_t i = 0; i < N; i++) x[i] = 0;
}

// x[n] = 0
template<typename T>
void clearN(T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) x[i] = 0;
}

// return true if x[] == 0
template<size_t N, typename T>
bool isZeroT(const T *x)
{
	for (size_t i = 0; i < N; i++) if (x[i]) return false;
	return true;
}

template<typename T>
bool isZeroN(const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) if (x[i]) return false;
	return true;
}

// return the real size of x
// return 1 if x[n] == 0
template<typename T>
size_t getRealSize(const T *x, size_t n)
{
	while (n > 0) {
		if (x[n - 1]) break;
		n--;
	}
	return n > 0 ? n : 1;
}

template<size_t N, typename T>
int cmpT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x != y) return x > y ? 1 : -1;
	}
	return 0;
}

// true if x[N] == y[N]
template<size_t N, typename T>
bool cmpEqT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[N] >= y[N]
template<size_t N, typename T>
bool cmpGeT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[N] > y[N]
template<size_t N, typename T>
bool cmpGtT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[N] <= y[N]
template<size_t N, typename T>
bool cmpLeT(const T *px, const T *py)
{
	return !cmpGtT<N>(px, py);
}

// true if x[N] < y[N]
template<size_t N, typename T>
bool cmpLtT(const T *px, const T *py)
{
	return !cmpGeT<N>(px, py);
}

// true if x[] == y[]
template<typename T>
bool cmpEqN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[n] >= y[n]
template<typename T>
bool cmpGeN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[n] > y[n]
template<typename T>
bool cmpGtN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[n] <= y[n]
template<typename T>
bool cmpLeN(const T *px, const T *py, size_t n)
{
	return !cmpGtN(px, py, n);
}

// true if x[n] < y[n]
template<typename T>
bool cmpLtN(const T *px, const T *py, size_t n)
{
	return !cmpGeN(px, py, n);
}

template<typename T>
int cmpN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x != y) return x > y ? 1 : -1;
	}
	return 0;
}

// z[2N] = x[N] * y[N]
template<size_t N>
void mulT(Unit *pz, const Unit *px, const Unit *py)
{
	pz[N] = mulUnitT<N>(pz, px, py[0]);
	for (size_t i = 1; i < N; i++) {
		pz[N + i] = mulUnitAddT<N>(&pz[i], px, py[i]);
	}
}

// [return:z[N]] = x[N] << bit
// 0 < bit < UnitBitSize
template<size_t N>
Unit shlT(Unit *pz, const Unit *px, Unit bit)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[N - 1];
	Unit keep = prev;
	for (size_t i = N - 1; i > 0; i--) {
		Unit t = px[i - 1];
		pz[i] = (prev << bit) | (t >> bitRev);
		prev = t;
	}
	pz[0] = prev << bit;
	return keep >> bitRev;
}

// z[N] = x[N] >> bit
// 0 < bit < UnitBitSize
template<size_t N>
void shrT(Unit *pz, const Unit *px, size_t bit)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[0];
	for (size_t i = 1; i < N; i++) {
		Unit t = px[i];
		pz[i - 1] = (prev >> bit) | (t << bitRev);
		prev = t;
	}
	pz[N - 1] = prev >> bit;
}

// [return:z[N]] = x[N] << y
// 0 < y < UnitBitSize
Unit shl(Unit *pz, const Unit *px, Unit bit, size_t n);

// z[n] = x[n] >> bit
// 0 < bit < UnitBitSize
void shr(Unit *pz, const Unit *px, size_t bit, size_t n);

/*
	generic version
	y[yn] = x[xn] << bit
	yn = xn + roundUp(bit, UnitBitSize)
	accept y == x
	return yn
*/
size_t shiftLeft(Unit *y, const Unit *x, size_t bit, size_t xn);

/*
	generic version
	y[yn] = x[xn] >> bit
	yn = xn - bit / UnitBitSize
	return yn
*/
size_t shiftRight(Unit *y, const Unit *x, size_t bit, size_t xn);

// [return:y[n]] += x
Unit addUnit(Unit *y, size_t n, Unit x);

// y[n] -= x, return CF
Unit subUnit(Unit *y, size_t n, Unit x);

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
Unit divUnit(Unit *q, const Unit *x, size_t n, Unit y);

/*
	q[] = x[] / y
	@retval r = x[] % y
*/
Unit modUnit(const Unit *x, size_t n, Unit y);

/*
	y must be UnitBitSize * N bit
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] if q != NULL
	return new xn
*/
size_t divFullBit(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

/*
	assume xn <= yn
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] if q != NULL
	assume(n >= 2);
	return new xn (1 if modulo is zero) if computed else 0
*/
Unit divSmall(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

/*
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] ; qn == xn - yn + 1 if xn >= yn else 1
	allow q == 0
	return new xn
	@note x[new xn:xn] may not be cleared
*/
size_t div(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

void mod_SECP256K1(Unit *z, const Unit *x, const Unit *p);
void mul_SECP256K1(Unit *z, const Unit *x, const Unit *y, const Unit *p);
void sqr_SECP256K1(Unit *y, const Unit *x, const Unit *p);

// x &= (1 << bitSize) - 1
void maskN(Unit *x, size_t n, size_t bitSize);

} } // mcl::bint

