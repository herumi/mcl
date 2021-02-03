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

// [return:z[N]] = z[N] + x[N] * y
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
uint32_t mulUnitWithTblT(uint32_t z[N], const uint64_t *tbl_j)
{
	uint32_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = tbl_j[i];
		v += H;
		z[i] = uint32_t(v);
		H = uint32_t(v >> 32);
	}
	return H;
}

template<size_t N>
uint32_t addMulUnitWithTblT(uint32_t z[N], const uint64_t *tbl_j)
{
	uint32_t H = 0;
	for (size_t i = 0; i < N; i++) {
		uint64_t v = tbl_j[i];
		v += H;
		v += z[i];
		z[i] = uint32_t(v);
		H = uint32_t(v >> 32);
	}
	return H;
}


// y[N * 2] = x[N] * x[N]
template<size_t N>
void sqrT(uint32_t y[N * 2], const uint32_t x[N])
{
	uint64_t tbl[N * N]; // x[i]x[j]
	for (size_t i = 0; i < N; i++) {
		uint64_t xi = x[i];
		tbl[i * N + i] = xi * xi;
		for (size_t j = i + 1; j < N; j++) {
			uint64_t v = xi * x[j];
			tbl[i * N + j] = v;
			tbl[j * N + i] = v;
		}
	}
	y[N] = mulUnitWithTblT<N>(y, tbl);
	for (size_t i = 1; i < N; i++) {
		y[N + i] = addMulUnitWithTblT<N>(&y[i], tbl + N * i);
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

/*
	z[N] = Montgomery(x[N], y[N], p[N])
	@remark : assume p[-1] = rp
*/
template<size_t N>
void montT(uint32_t *z, const uint32_t *x, const uint32_t *y, const uint32_t *p)
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
		copyT<N>(z, buf + N);
	}
}

} // mcl

