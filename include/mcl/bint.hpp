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

inline uint64_t make64(uint32_t H, uint32_t L)
{
	return ((uint64_t)H << 32) | L;
}

inline void split64(uint32_t *H, uint32_t *L, uint64_t x)
{
	*H = uint32_t(x >> 32);
	*L = uint32_t(x);
}

/*
	[H:L] <= x * y
	@return L
*/
inline uint32_t mulUnit1(uint32_t *pH, uint32_t x, uint32_t y)
{
	uint64_t t = uint64_t(x) * y;
	uint32_t L;
	split64(pH, &L, t);
	return L;
}

/*
	q = [H:L] / y
	r = [H:L] % y
	return q
*/
inline uint32_t divUnit1(uint32_t *pr, uint32_t H, uint32_t L, uint32_t y)
{
	assert(H < y);
	uint64_t t = make64(H, L);
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
void mulN(Unit *z, const Unit *x, const Unit *y, size_t n);

#if MCL_BINT_ASM == 1
#include "bint_asm.hpp"
#endif

template<size_t N>
void copyT(Unit *y, const Unit *x)
{
	for (size_t i = 0; i < N; i++) y[i] = x[i];
}

// y[n] = x[n]
inline void copy(Unit *y, const Unit *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

template<size_t N>
void clearT(Unit *x)
{
	for (size_t i = 0; i < N; i++) x[i] = 0;
}

// x[n] = 0
inline void clear(Unit *x, size_t n)
{
	for (size_t i = 0; i < n; i++) x[i] = 0;
}


// return the real size of x
// return 1 if x[n] == 0
inline size_t getRealSize(const Unit *x, size_t n)
{
	while (n > 0) {
		if (x[n - 1]) break;
		n--;
	}
	return n > 0 ? n : 1;
}

template<size_t N>
int cmpT(const Unit *px, const Unit *py)
{
	for (size_t i = 0; i < N; i++) {
		const Unit x = px[N - 1 - i];
		const Unit y = py[N - 1 - i];
		if (x != y) return x > y ? 1 : -1;
	}
	return 0;
}

// true if x[N] == y[N]
template<size_t N>
bool cmpEqT(const Unit *px, const Unit *py)
{
	for (size_t i = 0; i < N; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[N] >= y[N]
template<size_t N>
bool cmpGeT(const Unit *px, const Unit *py)
{
	for (size_t i = 0; i < N; i++) {
		const Unit x = px[N - 1 - i];
		const Unit y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[N] > y[N]
template<size_t N>
bool cmpGtT(const Unit *px, const Unit *py)
{
	for (size_t i = 0; i < N; i++) {
		const Unit x = px[N - 1 - i];
		const Unit y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[N] <= y[N]
template<size_t N>
bool cmpLeT(const Unit *px, const Unit *py)
{
	return !cmpGtT<N>(px, py);
}

// true if x[N] < y[N]
template<size_t N>
bool cmpLtT(const Unit *px, const Unit *py)
{
	return !cmpGeT<N>(px, py);
}

// true if x[] == y[]
inline bool cmpEq(const Unit *px, const Unit *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[n] >= y[n]
inline bool cmpGe(const Unit *px, const Unit *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const Unit x = px[n - 1 - i];
		const Unit y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[n] > y[n]
inline bool cmpGt(const Unit *px, const Unit *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const Unit x = px[n - 1 - i];
		const Unit y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[n] <= y[n]
inline bool cmpLe(const Unit *px, const Unit *py, size_t n)
{
	return !cmpGt(px, py, n);
}

// true if x[n] < y[n]
inline bool cmpLt(const Unit *px, const Unit *py, size_t n)
{
	return !cmpGe(px, py, n);
}

inline int cmp(const Unit *px, const Unit *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const Unit x = px[n - 1 - i];
		const Unit y = py[n - 1 - i];
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
	x[xn] = x[xn] % y[N]
	q[qn] = x[xn] / y[N] if q != NULL
	return new xn
*/
template<size_t N>
size_t divFullBitT(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	assert(xn > 0);
	assert(q != x && q != y && x != y);
	const Unit yTop = y[N - 1];
	assert(yTop >> (UnitBitSize - 1));
	if (q) clear(q, qn);
	Unit t[N];
	Unit rev = 0;
	// rev = M/2 M / yTop where M = 1 << UnitBitSize
	if (yTop != Unit(-1)) {
		Unit r;
		rev = divUnit1(&r, Unit(1) << (UnitBitSize - 1), 0, yTop + 1);
	}
	while (xn >= N) {
		if (x[xn - 1] == 0) {
			xn--;
			continue;
		}
		size_t d = xn - N;
		if (cmpGe(x + d, y, N)) {
			subT<N>(x + d, x + d, y);
			if (q) addUnit(q + d, qn - d, 1);
			if (d == 0) {
				break;
			}
		} else {
			if (d == 0) break;
			Unit v;
			if (yTop == Unit(-1)) {
				v = x[xn - 1];
			} else {
				mulUnit1(&v, x[xn - 1], rev);
				v <<= 1;
				if (v == 0) v = 1;
			}
			Unit ret = mulUnitT<N>(t, y, v);
			ret += subT<N>(x + d - 1, x + d - 1, t);
			x[xn-1] -= ret;
			if (q) addUnit(q + d - 1, qn - d + 1, v);
		}
	}
	assert(xn < N || (xn == N && cmpLt(x, y, N)));
	xn = getRealSize(x, xn);
	return xn;
}

/*
	assume xn <= N
	x[xn] = x[xn] % y[N]
	q[qn] = x[xn] / y[N] if q != NULL
	assume(n >= 2);
	return true if computed else false
*/
template<size_t N>
bool divSmallT(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	if (xn > N) return false;
	const Unit yTop = y[N - 1];
	assert(yTop > 0);
	Unit qv = 0;
	int ret = xn < N ? -1 : cmpT<N>(x, y);
	if (ret < 0) { // q = 0, r = x if x < y
		goto EXIT;
	}
	if (ret == 0) { // q = 1, r = 0 if x == y
		clear(x, xn);
		qv = 1;
		goto EXIT;
	}
	assert(xn == N);
	if (yTop >= Unit(1) << (UnitBitSize / 2)) {
		if (yTop == Unit(-1)) {
			subT<N>(x, x, y);
			qv = 1;
		} else {
			Unit t[N];
			qv = x[N - 1] / (yTop + 1);
			mulUnitT<N>(t, y, qv);
			subT<N>(x, x, t);
		}
		// expect that loop is at most once
		while (cmpGe(x, y, N)) {
			subT<N>(x, x, y);
			qv++;
		}
		goto EXIT;
	}
	return false;
EXIT:
	if (q) {
		q[0] = qv;
		clear(q + 1, qn - 1);
	}
	return true;
}

/*
	x[rn] = x[xn] % y[N] ; rn = N before getRealSize
	q[qn] = x[xn] / y[N] ; qn == xn - N + 1 if xn >= N if q
	allow q == 0
	return new xn
*/
template<size_t N>
size_t divT(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	assert(xn > 0 && N > 1);
	assert(xn < N || (q == 0 || qn >= xn - N + 1));
	assert(y[N - 1] != 0);
	xn = getRealSize(x, xn);
	if (divSmallT<N>(q, qn, x, xn, y)) return 1;

	/*
		bitwise left shift x and y to adjust MSB of y[N - 1] = 1
	*/
	const size_t yTopBit = cybozu::bsr(y[N - 1]);
	const size_t shift = UnitBitSize - 1 - yTopBit;
	if (shift) {
		Unit yShift[N];
		shlT<N>(yShift, y, shift);
		Unit *xx = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * (xn + 1));
		Unit v = shl(xx, x, shift, xn);
		if (v) {
			xx[xn] = v;
			xn++;
		}
		xn = divFullBitT<N>(q, qn, xx, xn, yShift);
		shr(x, xx, shift, xn);
		return xn;
	} else {
		return divFullBitT<N>(q, qn, x, xn, y);
	}
}

template<>
inline size_t divT<1>(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	assert(xn > 0);
	assert(q == 0 || qn >= xn);
	assert(y[0] != 0);
	xn = getRealSize(x, xn);
	Unit t;
	if (q) {
		if (qn > xn) {
			clear(q + xn, qn - xn);
		}
		t = divUnit(q, x, xn, y[0]);
	} else {
		t = modUnit(x, xn, y[0]);
	}
	x[0] = t;
	clear(x + 1, xn - 1);
	return 1;
}

} } // mcl::bint

