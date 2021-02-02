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

template<size_t N>
void addT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N])
{
	bool c = false;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) + y[i] + c;
		z[i] = uint32_t(v);
		c = (v >> 32) != 0;
	}
	assert(!c);
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

