#pragma once
/*
	low level functions
*/

#include <mcl/config.hpp>
#include <assert.h>
#ifdef _MSC_VER
#include <intrin.h>
#endif

//#define MCL_BITINT_ASM 0
#ifndef MCL_BITINT_ASM
	#define MCL_BITINT_ASM 1
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
	assert(y != 0);
	uint64_t t = make64(H, L);
	uint32_t q = uint32_t(t / y);
	*pr = uint32_t(t % y);
	return q;
}

#if MCL_SIZEOF_UNIT == 8
inline uint64_t mulUnit1(uint64_t *pH, uint64_t x, uint64_t y)
{
#if defined(_MSC_VER) && !defined(__INTEL_COMPILER) && !defined(__clang__)
	return _umul128(x, y, pH);
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = uint128(x) * y;
	*pH = uint64_t(t >> 64);
	return uint64_t(t);
#endif
}

inline uint64_t divUnit1(uint64_t *pr, uint64_t H, uint64_t L, uint64_t y)
{
	assert(y != 0);
#if defined(_MSC_VER) && !defined(__INTEL_COMPILER) && !defined(__clang__)
	return _udiv128(H, L, y, pr);
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = (uint128(H) << 64) | L;
	uint64_t q = uint64_t(t / y);
	*pr = uint64_t(t % y);
	return q;
#endif
}


// z[N] = x[N] + y[N] and return CF(0 or 1)
template<size_t N>Unit addT(Unit *z, const Unit *x, const Unit *y);
// z[N] = x[N] - y[N] and return CF(0 or 1)
template<size_t N>Unit subT(Unit *z, const Unit *x, const Unit *y);
// [ret:z[N]] = x[N] * y
template<size_t N>Unit mulUnitT(Unit *z, const Unit *x, Unit y);
// [ret:z[N]] = z[N] + x[N] * y
template<size_t N>Unit mulUnitAddT(Unit *z, const Unit *x, Unit y);

#if defined(MCL_BITINT_ASM) && (MCL_BITINT_ASM == 1)
#include "bitint_asm.hpp"
#else
template<size_t N>
Unit addT(Unit *z, const Unit *x, const Unit *y)
{
	Unit c = 0;
	for (size_t i = 0; i < N; i++) {
		Unit xc = x[i] + c;
		c = xc < c;
		Unit yi = y[i];
		xc += yi;
		c += xc < yi;
		z[i] = xc;
	}
	return c;
}

template<size_t N>
Unit subT(Unit *z, const Unit *x, const Unit *y)
{
	Unit c = 0;
	for (size_t i = 0; i < N; i++) {
		Unit yi = y[i];
		yi += c;
		c = yi < c;
		Unit xi = x[i];
		c += xi < yi;
		z[i] = xi - yi;
	}
	return c;
}

template<size_t N>
Unit mulUnitT(Unit *z, const Unit *x, Unit y)
{
	Unit H = 0;
	for (size_t i = 0; i < N; i++) {
		Unit t = H;
		Unit L = mulUnit1(&H, x[i], y);
		z[i] = t + L;
		if (z[i] < t) {
			H++;
		}
	}
	return H; // z[n]
}

template<size_t N>
Unit mulUnitAddT(Unit *z, const Unit *x, Unit y)
{
	Unit xy[N], ret;
	ret = mulUnitT<N>(xy, x, y);
	ret += addT<N>(z, z, xy);
	return ret;
}

#endif

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

#endif // MCL_SIZEOF_UNIT == 8

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


// z[2N] = x[N] * y[N]
template<size_t N>
void mulT(Unit *pz, const Unit *px, const Unit *py)
{
	pz[N] = mulUnitT<N>(pz, px, py[0]);
	for (size_t i = 1; i < N; i++) {
		pz[N + i] = mulUnitAddT<N>(&pz[i], px, py[i]);
	}
}

// [return:z[N]] = x[N] << y
// 0 < y < sizeof(Unit) * 8
template<size_t N>
Unit shlT(Unit *pz, const Unit *px, Unit y)
{
	assert(0 < y && y < sizeof(Unit) * 8);
	assert(xn > 0);
	size_t yRev = sizeof(Unit) * 8 - y;
	Unit prev = px[N - 1];
	Unit keep = prev;
	for (size_t i = N - 1; i > 0; i--) {
		Unit t = px[i - 1];
		pz[i] = (prev << y) | (t >> yRev);
		prev = t;
	}
	pz[0] = prev << y;
	return keep >> yRev;
}

// z[N] = x[N] >> y
// 0 < y < sizeof(Unit) * 8
template<size_t N>
void shrT(Unit *pz, const Unit *px, size_t y)
{
	assert(0 < y && y < sizeof(Unit) * 8);
	size_t yRev = sizeof(Unit) * 8 - y;
	Unit prev = px[0];
	for (size_t i = 1; i < N; i++) {
		Unit t = px[i];
		pz[i - 1] = (prev >> y) | (t << yRev);
		prev = t;
	}
	pz[N - 1] = prev >> y;
}

// z[n] = x[n] + y
inline Unit addUnit(Unit *z, const Unit *x, size_t n, Unit y)
{
	assert(n > 0);
	Unit t = x[0] + y;
	z[0] = t;
	size_t i = 0;
	if (t >= y) goto EXIT_0;
	i = 1;
	for (; i < n; i++) {
		t = x[i] + 1;
		z[i] = t;
		if (t != 0) goto EXIT_0;
	}
	return 1;
EXIT_0:
	i++;
	for (; i < n; i++) {
		z[i] = x[i];
	}
	return 0;
}
// x[n] += y
inline Unit addUnit(Unit *x, size_t n, Unit y)
{
	assert(n > 0);
	Unit t = x[0] + y;
	x[0] = t;
	size_t i = 0;
	if (t >= y) return 0;
	i = 1;
	for (; i < n; i++) {
		t = x[i] + 1;
		x[i] = t;
		if (t != 0) return 0;
	}
	return 1;
}

// z[n] = x[n] - y
inline Unit subUnit(Unit *z, const Unit *x, size_t n, Unit y)
{
	assert(n > 0);
	Unit c = x[0] < y ? 1 : 0;
	z[0] = x[0] - y;
	for (size_t i = 1; i < n; i++) {
		if (x[i] < c) {
			z[i] = Unit(-1);
		} else {
			z[i] = x[i] - c;
			c = 0;
		}
	}
	return c;
}

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
inline Unit divUnit(Unit *q, const Unit *x, size_t n, Unit y)
{
	assert(n > 0);
	Unit r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		q[i] = divUnit1(&r, r, x[i], y);
	}
	return r;
}
/*
	q[] = x[] / y
	@retval r = x[] % y
*/
inline Unit modUnit(const Unit *x, size_t n, Unit y)
{
	assert(n > 0);
	Unit r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		divUnit1(&r, r, x[i], y);
	}
	return r;
}

// x[n] = 0
inline void clear(Unit *x, size_t n)
{
	for (size_t i = 0; i < n; i++) x[i] = 0;
}

template<size_t N>
struct FuncT {
	static inline Unit add(Unit *z, const Unit *x, const Unit *y)
	{
		return addT<N>(z, x, y);
	}
	static inline Unit sub(Unit *z, const Unit *x, const Unit *y)
	{
		return subT<N>(z, x, y);
	}
	static inline Unit mulUnit(Unit *z, const Unit *x, Unit y)
	{
		return mulUnitT<N>(z, x, y);
	}
	static inline bool cmpGe(const Unit *x, const Unit *y)
	{
		return cmpGeT<N>(x, y);
	}
};
/*
	y must be sizeof(Unit) * 8 * N bit
	x[xn] = x[xn] % y[N]
	q[qn] = x[xn] / y[N] if q != NULL
	return new xn
*/
template<size_t N, typename Func = FuncT<N> >
size_t divFullBitT(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	assert(xn > 0);
	assert((y[N - 1] >> (sizeof(Unit) * 8 - 1)) != 0);
	assert(q != x && q != y && x != y);
	if (q) clear(q, qn);
	Unit *t = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * N);
	while (xn > N) {
		if (x[xn - 1] == 0) {
			xn--;
			continue;
		}
		size_t d = xn - N;
		if (Func::cmpGe(x + d, y)) {
			Func::sub(x + d, x + d, y);
			if (q) addUnit(q + d, qn - d, 1);
		} else {
			Unit xTop = x[xn - 1];
			if (xTop == 1) {
				Unit ret = Func::sub(x + d - 1, x + d - 1, y);
				x[xn-1] -= ret;
			} else {
				Unit ret = Func::mulUnit(t, y, xTop);
				ret += Func::sub(x + d - 1, x + d - 1, t);
				x[xn-1] -= ret;
			}
			if (q) addUnit(q + d - 1, qn - d + 1, xTop);
		}
	}
	if (Func::cmpGe(x, y)) {
		Func::sub(x, x, y);
		if (q) addUnit(q, qn, 1);
	}
	xn = getRealSize(x, xn);
	return xn;
}

#include "bitint_switch.hpp"

} } // mcl::bint

