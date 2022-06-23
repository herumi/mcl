#pragma once

#include <mcl/bint.hpp>

namespace mcl { namespace bint {

#if MCL_BINT_ASM != 1
#ifdef MCL_WASM32
inline uint64_t load8byte(const uint32_t *x)
{
	return x[0] | (uint64_t(x[1]) << 32);
}
inline void store8byte(uint32_t *x, uint64_t v)
{
	x[0] = uint32_t(v);
	x[1] = uint32_t(v >> 32);
}
#endif
template<size_t N>
Unit addT(Unit *z, const Unit *x, const Unit *y)
{
#ifdef MCL_WASM32
	// wasm32 supports 64-bit add
	Unit c = 0;
	for (size_t i = 0; i < N / 2; i++) {
		Unit xc = load8byte(x + i * 2) + c;
		c = xc < c;
		Unit yi = load8byte(y + i * 2);
		xc += yi;
		c += xc < yi;
		store8byte(z + i * 2, xc);
	}
	if ((N & 1) == 1) {
		Unit xc = x[N - 1] + c;
		c = xc < c;
		Unit yi = y[N - 1];
		xc += yi;
		c += xc < yi;
		z[N - 1] = xc;
	}
	return c;
#else
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
#endif
}

template<size_t N>
Unit subT(Unit *z, const Unit *x, const Unit *y)
{
#ifdef MCL_WASM32
	// wasm32 supports 64-bit sub
	Unit c = 0;
	for (size_t i = 0; i < N / 2; i++) {
		Unit yi = load8byte(y + i * 2);
		yi += c;
		c = yi < c;
		Unit xi = load8byte(x + i * 2);
		c += xi < yi;
		store8byte(z + i * 2, xi - yi);
	}
	if ((N & 1) == 1) {
		Unit yi = y[N - 1];
		yi += c;
		c = yi < c;
		Unit xi = x[N - 1];
		c += xi < yi;
		z[N - 1] = xi - yi;
	}
	return c;
#else
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
#endif
}

template<size_t N>
Unit mulUnitT(Unit *z, const Unit *x, Unit y)
{
#ifdef MCL_WASM32
	uint64_t H = 0;
	uint64_t yy = y;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = x[i] * yy;
		v += H;
		z[i] = uint32_t(v);
		H = v >> 32;
	}
	return uint32_t(H);
#elif defined(MCL_DEFINED_UINT128_T)
	uint64_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint128_t v = uint128_t(x[i]) * y;
		v += H;
		z[i] = uint64_t(v);
		H = uint64_t(v >> 64);
	}
	return uint64_t(H); // z[n]
#else
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
#endif
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

// [return:z[N]] = x[N] << y
// 0 < y < UnitBitSize
Unit shl(Unit *pz, const Unit *px, Unit bit, size_t n)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[n - 1];
	Unit keep = prev;
	for (size_t i = n - 1; i > 0; i--) {
		Unit t = px[i - 1];
		pz[i] = (prev << bit) | (t >> bitRev);
		prev = t;
	}
	pz[0] = prev << bit;
	return keep >> bitRev;
}

// z[n] = x[n] >> bit
// 0 < bit < UnitBitSize
void shr(Unit *pz, const Unit *px, size_t bit, size_t n)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[0];
	for (size_t i = 1; i < n; i++) {
		Unit t = px[i];
		pz[i - 1] = (prev >> bit) | (t << bitRev);
		prev = t;
	}
	pz[n - 1] = prev >> bit;
}

/*
	generic version
	y[yn] = x[xn] << bit
	yn = xn + roundUp(bit, UnitBitSize)
	accept y == x
	return yn
*/
size_t shiftLeft(Unit *y, const Unit *x, size_t bit, size_t xn)
{
	assert(xn > 0);
	size_t q = bit / UnitBitSize;
	size_t r = bit % UnitBitSize;
	size_t yn = xn + q;
	if (r == 0) {
		// don't use copyN(y + q, x, xn); if overlaped
		for (size_t i = 0; i < xn; i++) {
			y[q + xn - 1 - i] = x[xn - 1 - i];
		}
	} else {
		y[q + xn] = shl(y + q, x, r, xn);
		yn++;
	}
	clearN(y, q);
	return yn;
}

/*
	generic version
	y[yn] = x[xn] >> bit
	yn = xn - bit / UnitBitSize
	return yn
*/
size_t shiftRight(Unit *y, const Unit *x, size_t bit, size_t xn)
{
	assert(xn > 0);
	size_t q = bit / UnitBitSize;
	size_t r = bit % UnitBitSize;
	assert(xn >= q);
	if (r == 0) {
		copyN(y, x + q, xn - q);
	} else {
		shr(y, x + q, r, xn - q);
	}
	return xn - q;
}

// [return:y[n]] += x
Unit addUnit(Unit *y, size_t n, Unit x)
{
	if (n == 0) return 0;
	Unit t = y[0] + x;
	y[0] = t;
	if (t >= x) return 0;
	for (size_t i = 1; i < n; i++) {
		t = y[i] + 1;
		y[i] = t;
		if (t != 0) return 0;
	}
	return 1;
}

// y[n] -= x, return CF
Unit subUnit(Unit *y, size_t n, Unit x)
{
	if (n == 0) return 0;
	Unit t = y[0];
	y[0] = t - x;
	if (t >= x) return 0;
	for (size_t i = 1; i < n; i++) {
		t = y[i];
		y[i] = t - 1;
		if (t != 0) return 0;
	}
	return 1;
}

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
Unit divUnit(Unit *q, const Unit *x, size_t n, Unit y)
{
	assert(y);
	if (n == 0) return 0;
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
Unit modUnit(const Unit *x, size_t n, Unit y)
{
	assert(y);
	if (n == 0) return 0;
	Unit r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		divUnit1(&r, r, x[i], y);
	}
	return r;
}

#include "bint_switch.hpp"

} } // mcl::bint

