#pragma once
/**
	@file
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

// only for 32bit not full bit prime version

namespace mcl {

template<size_t N>
void copyT(uint32_t y[N], const uint32_t x[N])
{
	for (size_t i = 0; i < N; i++) {
		y[i] = x[i];
	}
}

// [return:y[N]] += x
template<size_t N>
inline bool addUnitT(uint32_t y[N], uint32_t x)
{
	uint64_t v = uint64_t(y[0]) + x;
	y[0] = uint32_t(v);
	bool c = (v >> 32) != 0;
	if (!c) return false;
	for (size_t i = 1; i < N; i++) {
		v = uint64_t(y[i]) + 1;
		y[i] = uint32_t(v);
		if ((v >> 32) == 0) return false;
	}
	return true;
}

template<size_t N>
bool addT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N])
{
	bool c = false;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) + y[i] + c;
		z[i] = uint32_t(v);
		c = (v >> 32) != 0;
	}
	return c;
}

template<size_t N>
bool subT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N])
{
	bool c = false;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) - y[i] - c;
		z[i] = uint32_t(v);
		c = (v >> 32) != 0;
	}
	return c;
}

// [return:z[N]] = x[N] * y
template<size_t N>
uint32_t mulUnitT(uint32_t z[N], const uint32_t x[N], uint32_t y)
{
	uint32_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) * y;
		v += H;
		z[i] = uint32_t(v);
		H = uint32_t(v >> 32);
	}
	return H;
}

// [return:z[N]] = z[N] + x[N] * z
template<size_t N>
uint32_t addMulUnitT(uint32_t z[N], const uint32_t x[N], uint32_t y)
{
	uint32_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) * y;
		v += H;
		v += z[i];
		z[i] = uint32_t(v);
		H = uint32_t(v >> 32);
	}
	return H;
}

// z[N * 2] = x[N] * y[N]
template<size_t N>
void mulT(uint32_t z[N * 2], const uint32_t x[N], const uint32_t y[N])
{
	z[N] = mulUnitT<N>(z, x, y[0]);
	for (size_t i = 1; i < N; i++) {
		z[N + i] = addMulUnitT<N>(&z[i], x, y[i]);
	}
}

/*
	z[N * 2] = x[N] * y[N]
	H = N/2
	W = 1 << (H * 32)
	x = aW + b, y = cW + d
	assume a < W/2, c < W/2
	(aW + b)(cW + d) = acW^2 + (ad + bc)W + bd
	ad + bc = (a + b)(c + d) - ac - bd < (1 << (N * 32))
*/
template<size_t N>
void karatsubaT(uint32_t z[N * 2], const uint32_t x[N], const uint32_t y[N])
{
	assert((N % 2) == 0);
	assert((x[N - 1] & 0x80000000) == 0);
	assert((y[N - 1] & 0x80000000) == 0);
	const size_t H = N / 2;
	mulT<H>(z, x, y); // bd
	mulT<H>(z + N, x + H, y + H); // ac
	uint32_t a_b[H];
	uint32_t c_d[H];
	bool c1 = addT<H>(a_b, x, x + H); // a + b
	bool c2 = addT<H>(c_d, y, y + H); // c + d
	uint32_t tmp[N];
	mulT<H>(tmp, a_b, c_d);
	if (c1) {
		addT<H>(tmp + H, tmp + H, c_d);
	}
	if (c2) {
		addT<H>(tmp + H, tmp + H, a_b);
	}
	// c:tmp[N] = (a + b)(c + d)
	subT<N>(tmp, tmp, z);
	subT<N>(tmp, tmp, z + N);
	// c:tmp[N] = ad + bc
	if (addT<N>(z + H, z + H, tmp)) {
		addUnitT<H>(z + N + H, 1);
	}
}

template<size_t N>
void addModT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N], const uint32_t p[N])
{
	uint32_t t[N];
	addT<N>(z, x, y);
	bool c = subT<N>(t, z, p);
	if (!c) {
		copyT<N>(z, t);
	}
}

template<size_t N>
void subModT(uint32_t *z, const uint32_t *x, const uint32_t *y, const uint32_t *p)
{
	bool c = subT<N>(z, x, y);
	if (c) {
		addT<N>(z, z, p);
	}
}

} // mcl

