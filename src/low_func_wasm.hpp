#pragma once
/**
	@file
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
	@note for only 32bit not full bit prime version
	assert((p[N - 1] & 0x80000000) == 0);
*/
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

namespace mcl {

template<size_t N>
uint64_t addT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N])
{
#if 1
	return mcl::bint::addT<N>(z, x, y);
#else
	uint64_t c = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) + y[i] + c;
		z[i] = uint32_t(v);
		c = v >> 32;
	}
	return c;
#endif
}

template<size_t N>
uint64_t subT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N])
{
#if 1
	return mcl::bint::subT<N>(z, x, y);
#else
	uint64_t c = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) - y[i] - c;
		z[i] = uint32_t(v);
		c = v >> 63;
	}
	return c;
#endif
}

// [return:z[N]] = x[N] * y
template<size_t N>
uint64_t mulUnitT(uint32_t z[N], const uint32_t x[N], uint32_t y_)
{
#if 1
	return mcl::bint::mulUnitT<N>(z, x, y_);
#else
	uint64_t H = 0;
	uint64_t y = y_;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = x[i] * y;
		v += H;
		z[i] = uint32_t(v);
		H = v >> 32;
	}
	return H;
#endif
}

// [return:z[N]] = z[N] + x[N] * uint32_t(y)
template<size_t N>
uint64_t addMulUnitT(uint32_t z[N], const uint32_t x[N], uint32_t y_)
{
#if 1
	return mcl::bint::mulUnitAddT<N>(z, x, y_);
#else
	// reduce cast operation
	uint64_t H = 0;
	uint64_t y = y_;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = x[i] * y;
		v += H;
		v += z[i];
		z[i] = uint32_t(v);
		H = v >> 32;
	}
	return H;
#endif
}

template<size_t N>
void addModT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N], const uint32_t p[N])
{
	uint32_t t[N];
	addT<N>(z, x, y);
	uint64_t c = subT<N>(t, z, p);
	if (!c) {
		bint::copyT<N>(z, t);
	}
}

template<size_t N>
void subModT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N], const uint32_t p[N])
{
	uint64_t c = subT<N>(z, x, y);
	if (c) {
		addT<N>(z, z, p);
	}
}

/*
	z[N] = Montgomery(x[N], y[N], p[N])
	@remark : assume p[-1] = rp
*/
template<size_t N>
void mulMontT(uint32_t z[N], const uint32_t x[N], const uint32_t y[N], const uint32_t p[N])
{
	const uint32_t rp = p[-1];
	assert((p[N - 1] & 0x80000000) == 0);
	uint32_t buf[N * 2];
	buf[N] = mulUnitT<N>(buf, x, y[0]);
	uint32_t q = buf[0] * rp;
	buf[N] += addMulUnitT<N>(buf, p, q);
	for (size_t i = 1; i < N; i++) {
		buf[N + i] = addMulUnitT<N>(buf + i, x, y[i]);
		uint32_t q = buf[i] * rp;
		buf[N + i] += addMulUnitT<N>(buf + i, p, q);
	}
	if (subT<N>(z, buf + N, p)) {
		bint::copyT<N>(z, buf + N);
	}
}

// [return:z[N+1]] = z[N+1] + x[N] * y + (cc << (N * 32))
template<size_t N>
uint32_t addMulUnit2T(uint32_t z[N + 1], const uint32_t x[N], uint32_t y, const uint32_t *cc = 0)
{
	uint32_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = uint64_t(x[i]) * y;
		v += H;
		v += z[i];
		z[i] = uint32_t(v);
		H = uint32_t(v >> 32);
	}
	if (cc) H += *cc;
	uint64_t v = uint64_t(z[N]);
	v += H;
	z[N] = uint32_t(v);
	return uint32_t(v >> 32);
}

/*
	z[N] = Montgomery reduction(y[N], xy[N], p[N])
	@remark : assume p[-1] = rp
*/
template<size_t N>
void modT(uint32_t y[N], const uint32_t xy[N * 2], const uint32_t p[N])
{
	const uint32_t rp = p[-1];
	assert((p[N - 1] & 0x80000000) == 0);
	uint32_t buf[N * 2];
	bint::copyT<N * 2>(buf, xy);
	uint32_t c = 0;
	for (size_t i = 0; i < N; i++) {
		uint32_t q = buf[i] * rp;
		c = addMulUnit2T<N>(buf + i, p, q, &c);
	}
	if (subT<N>(y, buf + N, p)) {
		bint::copyT<N>(y, buf + N);
	}
}

/*
	z[N] = Montgomery(x[N], y[N], p[N])
	@remark : assume p[-1] = rp
*/
template<size_t N>
void sqrMontT(uint32_t y[N], const uint32_t x[N], const uint32_t p[N])
{
	mulMontT<N>(y, x, x, p);
}

} // mcl

