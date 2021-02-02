#pragma once
/**
	@file
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdint.h>
#include <stdlib.h>

// for 32bit not full version

namespace mcl {

template<size_t N>
void copyT(uint32_t *y, const uint32_t *x)
{
	for (size_t i = 0; i < N; i++) {
		y[i] = x[i];
	}
}

template<size_t N>
void addT(uint32_t *z, const uint32_t *x, const uint32_t *y)
{
	bool c = false;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) + y[i] + c;
		z[i] = uint32_t(v);
		c = (v >> 32) != 0;
	}
}

template<size_t N>
bool subT(uint32_t *z, const uint32_t *x, const uint32_t *y)
{
	bool c = false;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) - y[i] - c;
		z[i] = uint32_t(v);
		c = (v >> 32) != 0;
	}
	return c;
}

template<size_t N>
void addModT(uint32_t *z, const uint32_t *x, const uint32_t *y, const uint32_t *p)
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

