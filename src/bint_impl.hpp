#pragma once
/*
	This file is intended to be included only once and exclusively from src/fp.cpp
*/

#include <mcl/bint.hpp>

#if CYBOZU_HOST == CYBOZU_HOST_INTEL

#include <string.h>

#define XBYAK_DISABLE_AVX512
#ifndef XBYAK_NO_EXCEPTION
	#define XBYAK_NO_EXCEPTION
#endif

#include "xbyak/xbyak_util.h"

extern "C" void mclb_enable_fast();
#endif

namespace mcl { namespace bint {


uint32_t initBint()
{
	uint32_t type = 0;

#if CYBOZU_HOST == CYBOZU_HOST_INTEL

	using namespace Xbyak::util;
	Cpu cpu;
	if (cpu.has(Cpu::tAVX | Cpu::tBMI2 | Cpu::tADX)) {
		type |= tAVX_BMI2_ADX;
	}
	if (cpu.has(Cpu::tAVX512_IFMA)) {
		type |= tAVX512_IFMA;
	}
	const char *env = 0;
	const char *key = "MCL_CPU";
#ifdef _WIN32
	char envBuf[128];
	size_t size;
	if (getenv_s(&size, envBuf, key) == 0) {
		if (size > 0) {
			env = envBuf;
		}
	}
#else
	env = getenv(key);
#endif
	if (env) {
		if (strcmp(env, "noadx") == 0) {
			type = 0;
		} else if (strcmp(env, "noifma") == 0) {
			type &= tAVX512_IFMA;
		}
	}
#if MCL_BINT_ASM_X64 == 1
	if (type & tAVX_BMI2_ADX) {
		mclb_enable_fast();
	}
#endif
#endif
	return type;
}

const uint32_t g_cpuType = initBint();

#include "bint_switch.hpp"

#if MCL_BINT_ASM != 1
template<size_t N>
Unit addT(Unit *z, const Unit *x, const Unit *y)
{
#ifdef MCL_WASM32
	// wasm32 supports 64-bit add
	uint64_t c = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) + y[i] + c;
		z[i] = uint32_t(v);
		c = v >> 32;
	}
	return uint32_t(c);
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

template<size_t N, typename T>
Unit subT(Unit *z, const T *x, const Unit *y)
{
#ifdef MCL_WASM32
	// wasm32 supports 64-bit sub
	uint64_t c = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) - y[i] - c;
		z[i] = uint32_t(v);
		c = v >> 63;
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
void addNFT(Unit *z, const Unit *x, const Unit *y)
{
	addT<N>(z, x, y);
}

template<size_t N>
Unit subNFT(Unit *z, const Unit *x, const Unit *y)
{
	return subT<N>(z, x, y);
}


template<size_t N, typename T>
Unit mulUnitT(T *z, const Unit *x, Unit y)
{
#if MCL_SIZEOF_UNIT == 4
// use T as uint64_t to reduce conversion
	uint64_t y_ = y;
	uint64_t v = x[0] * y_;
	z[0] = uint32_t(v);
	for (size_t i = 1; i < N; i++) {
		v = x[i] * y_ + (v >> 32);
		z[i] = uint32_t(v);
	}
	return uint32_t(v >> 32);
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

template<size_t N, typename T>
Unit mulUnitAddT(T *z, const Unit *x, Unit y)
{
#ifdef MCL_WASM32
	uint64_t y_ = y;
	uint64_t v = z[0] + x[0] * y_;
	z[0] = uint32_t(v);
	for (size_t i = 1; i < N; i++) {
		v = z[i] + x[i] * y_ + (v >> 32);
		z[i] = uint32_t(v);
	}
	return uint32_t(v >> 32);
#else
	Unit xy[N], ret;
	ret = mulUnitT<N>(xy, x, y);
	ret += addT<N>(z, z, xy);
	return ret;
#endif
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

// y[2N] = x[N] * x[N]
template<size_t N>
void sqrT(Unit *py, const Unit *px)
{
	// QQQ : optimize this later
	mulT<N>(py, px, px);
}

#endif // MCL_BINT_ASM != 1

// [return:z[N]] = x[N] << y
// 0 < y < UnitBitSize
MCL_DLL_API Unit shlN(Unit *pz, const Unit *px, Unit bit, size_t n)
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
MCL_DLL_API void shrN(Unit *pz, const Unit *px, size_t bit, size_t n)
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
MCL_DLL_API size_t shiftLeft(Unit *y, const Unit *x, size_t bit, size_t xn)
{
	assert(bit <= MCL_FP_BIT * 2); // many be too big
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
		y[q + xn] = shlN(y + q, x, r, xn);
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
MCL_DLL_API size_t shiftRight(Unit *y, const Unit *x, size_t bit, size_t xn)
{
	assert(bit <= MCL_SIZEOF_UNIT * 8 * xn);
	assert(xn > 0);
	size_t q = bit / UnitBitSize;
	size_t r = bit % UnitBitSize;
	assert(xn >= q);
	if (r == 0) {
		copyN(y, x + q, xn - q);
	} else {
		shrN(y, x + q, r, xn - q);
	}
	return xn - q;
}

// [return:y[n]] += x
MCL_DLL_API Unit addUnit(Unit *y, size_t n, Unit x)
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
MCL_DLL_API Unit subUnit(Unit *y, size_t n, Unit x)
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
MCL_DLL_API Unit divUnit(Unit *q, const Unit *x, size_t n, Unit y)
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
MCL_DLL_API Unit modUnit(const Unit *x, size_t n, Unit y)
{
	assert(y);
	if (n == 0) return 0;
	Unit r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		divUnit1(&r, r, x[i], y);
	}
	return r;
}

MCL_DLL_API Unit divSmall(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn)
{
	if (xn > yn) return 0;
	assert(yn > 0);
	const Unit yTop = y[yn - 1];
	assert(yTop > 0);
	Unit qv = 0;
	int ret = xn < yn ? -1 : cmpN(x, y, yn);
	if (ret < 0) { // q = 0, r = x if x < y
		goto EXIT;
	}
	if (ret == 0) { // q = 1, r = 0 if x == y
		clearN(x, xn);
		qv = 1;
		goto EXIT;
	}
	assert(xn == yn);
	if (yTop >= Unit(1) << (UnitBitSize / 2)) {
		u_ppp sub = get_sub(yn);
		if (yTop == Unit(-1)) {
			sub(x, x, y);
			qv = 1;
		} else {
			Unit *t = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * yn);
			qv = x[yn - 1] / (yTop + 1);
			mulUnitN(t, y, qv, yn);
			sub(x, x, t);
		}
		// expect that loop is at most once
		while (cmpGeN(x, y, yn)) {
			sub(x, x, y);
			qv++;
		}
		goto EXIT;
	}
	return 0;
EXIT:
	if (q) {
		q[0] = qv;
		clearN(q + 1, qn - 1);
	}
	return getRealSize(x, xn);
}

MCL_DLL_API size_t divFullBit(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn)
{
	assert(xn > 0);
	assert(q != x && q != y && x != y);
	const Unit yTop = y[yn - 1];
	assert(yTop >> (UnitBitSize - 1));
	if (q) clearN(q, qn);
	Unit *t = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * yn);
	Unit rev = 0;
	// rev = M/2 M / yTop where M = 1 << UnitBitSize
	if (yTop != Unit(-1)) {
		Unit r;
		rev = divUnit1(&r, Unit(1) << (UnitBitSize - 1), 0, yTop + 1);
	}
	u_ppp sub = get_sub(yn);
	u_ppu mulUnit = get_mulUnit(yn);
	while (xn >= yn) {
		if (x[xn - 1] == 0) {
			xn--;
			continue;
		}
		size_t d = xn - yn;
		if (cmpGeN(x + d, y, yn)) {
			subN(x + d, x + d, y, yn);
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
				Unit L = mulUnit1(&v, x[xn - 1], rev);
				v = (v << 1) | (L >> (UnitBitSize - 1));
				if (v == 0) v = 1;
			}
			Unit ret = mulUnit(t, y, v);
			ret += sub(x + d - 1, x + d - 1, t);
			x[xn-1] -= ret;
			if (q) addUnit(q + d - 1, qn - d + 1, v);
		}
	}
	assert(xn < yn || (xn == yn && cmpLtN(x, y, yn)));
	xn = getRealSize(x, xn);
	return xn;
}

// yn == 1
inline size_t div1(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	assert(xn > 0);
	assert(q == 0 || qn >= xn);
	assert(y[0] != 0);
	xn = getRealSize(x, xn);
	Unit t;
	if (q) {
		if (qn > xn) {
			clearN(q + xn, qn - xn);
		}
		t = divUnit(q, x, xn, y[0]);
	} else {
		t = modUnit(x, xn, y[0]);
	}
	x[0] = t;
	clearN(x + 1, xn - 1);
	return 1;
}

MCL_DLL_API size_t div(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn)
{
	if (yn == 1) return div1(q, qn, x, xn, y);
	assert(xn > 0 && yn > 1);
	assert(xn < yn || (q == 0 || qn >= xn - yn + 1));
	assert(y[yn - 1] != 0);
	xn = getRealSize(x, xn);
	size_t new_xn = divSmall(q, qn, x, xn, y, yn);
	if (new_xn > 0) return new_xn;

	/*
		bitwise left shift x and y to adjust MSB of y[yn - 1] = 1
	*/
	const size_t yTopBit = cybozu::bsr(y[yn - 1]);
	const size_t shift = UnitBitSize - 1 - yTopBit;
	if (shift) {
		Unit *yShift = (Unit *)CYBOZU_ALLOCA(sizeof(Unit) * yn);
		shlN(yShift, y, shift, yn);
		Unit *xx = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * (xn + 1));
		Unit v = shlN(xx, x, shift, xn);
		if (v) {
			xx[xn] = v;
			xn++;
		}
		xn = divFullBit(q, qn, xx, xn, yShift, yn);
		shrN(x, xx, shift, xn);
		return xn;
	} else {
		return divFullBit(q, qn, x, xn, y, yn);
	}
}


void mulNM(Unit *z, const Unit *x, size_t xn, const Unit *y, size_t yn)
{
	if (xn == 0 || yn == 0) return;
	if (yn > xn) {
		fp::swap_(yn, xn);
		fp::swap_(x, y);
	}
	assert(xn >= yn);
	if (z == x) {
		Unit *p = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * xn);
		copyN(p, x, xn);
		x = p;
	}
	if (z == y) {
		Unit *p = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * yn);
		copyN(p, y, yn);
		y = p;
	}
	z[xn] = mulUnitN(z, x, y[0], xn);
	u_ppu mulUnitAdd = get_mulUnitAdd(xn);
	for (size_t i = 1; i < yn; i++) {
		z[xn + i] = mulUnitAdd(&z[i], x, y[i]);
	}
}

/*
	M=1<<256
	a=(1<<32)+0x3d1
	p=M-a
	0<=x<=(p-1)^2=M(M-2a-2)+(a+1)^2
	H=M-2a-2, L=(a+1)^2
	H=M-2a-3, L=M-1
	x1=H a + L <= (M-2a-3)a+M-1=Ma+(M-2a^2-3a-1)
	H2=a, L2=M-2a^2-3a-1
	H2=a-1, L2=M-1
	x2=H2 a + L2 <= (a-1)a + M-1=M+(a^2-a-1)
	H3=1, L3=a^2-a-1
	H3=0, L3=M-1
	x3=H3 a + L1 <= M-1
*/
MCL_DLL_API void mod_SECP256K1(Unit *z, const Unit *x, const Unit *p)
{
	const size_t N = 32 / MCL_SIZEOF_UNIT;
#if MCL_SIZEOF_UNIT == 8
	const Unit a = (uint64_t(1) << 32) + 0x3d1;
	Unit buf[5];
	buf[4] = mulUnitT<N>(buf, x + 4, a); // H * a
	buf[4] += addT<4>(buf, buf, x); // t = H * a + L
	Unit x2[2];
	x2[0] = mulUnit1(&x2[1], buf[4], a);
	Unit x3 = addT<2>(buf, buf, x2);
	if (x3) {
		x3 = addUnit(buf + 2, 2, 1); // t' = H' * a + L'
		if (x3) {
			x3 = addUnit(buf, 4, a);
			assert(x3 == 0);
		}
	}
#else
	Unit buf[N + 2];
	// H * a = H * 0x3d1 + (H << 32)
	buf[N] = mulUnitT<N>(buf, x + N, 0x3d1u); // H * 0x3d1
	buf[N + 1] = addT<N>(buf + 1, buf + 1, x + N);
	// t = H * a + L
	Unit t = addT<N>(buf, buf, x);
	addUnit(buf + N, 2, t);
	Unit x2[4];
	// x2 = buf[N:N+2] * a
	x2[2] = mulUnitT<2>(x2, buf + N, 0x3d1u);
	x2[3] = addT<2>(x2 + 1, x2 + 1, buf + N);
	Unit x3 = addT<4>(buf, buf, x2);
	if (x3) {
		x3 = addUnit(buf + 4, N - 4, 1);
		if (x3) {
			Unit a[2] = { 0x3d1, 1 };
			x3 = addT<2>(buf, buf, a);
			if (x3) {
				addUnit(buf + 2, N - 2, 1);
			}
		}
	}
#endif
	if (cmpGeT<N>(buf, p)) {
		subT<N>(z, buf, p);
	} else {
		copyT<N>(z, buf);
	}
}

MCL_DLL_API void mul_SECP256K1(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	const size_t N = 32 / MCL_SIZEOF_UNIT;
	Unit xy[N * 2];
	mulT<N>(xy, x, y);
	mod_SECP256K1(z, xy, p);
}

MCL_DLL_API void sqr_SECP256K1(Unit *y, const Unit *x, const Unit *p)
{
	const size_t N = 32 / MCL_SIZEOF_UNIT;
	Unit xx[N * 2];
	mulT<N>(xx, x, x);
	mod_SECP256K1(y, xx, p);
}

// x &= (1 << bitSize) - 1
MCL_DLL_API void maskN(Unit *x, size_t n, size_t bitSize)
{
	assert(bitSize <= UnitBitSize * n);
	const size_t q = bitSize / UnitBitSize;
	const size_t r = bitSize % UnitBitSize;
	if (r) {
		x[q] &= (Unit(1) << r) - 1;
		clearN(x + q + 1, n - (q + 1));
	} else {
		clearN(x + q, n - q);
	}
}

} } // mcl::bint

