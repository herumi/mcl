#pragma once
/**
	@file
	@brief generic function for each N
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <cybozu/bit_operation.hpp>

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
#endif

namespace mcl { namespace fp {

template<size_t N>
static void shr1T(Unit *y, const Unit *x)
{
	bint::shrT<N>(y, x, 1);
}

template<size_t N>
void addModT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	if (bint::addT<N>(z, x, y)) {
		bint::subT<N>(z, z, p);
		return;
	}
	Unit tmp[N];
	if (bint::subT<N>(tmp, z, p) == 0) {
		bint::copyT<N>(z, tmp);
	}
}

template<size_t N>
void addModNFT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	bint::addNFT<N>(z, x, y);
	Unit tmp[N];
	if (bint::subNFT<N>(tmp, z, p) == 0) {
		bint::copyT<N>(z, tmp);
	}
}

template<size_t N>
void subModT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	if (bint::subT<N>(z, x, y)) {
		bint::addT<N>(z, z, p);
	}
}

template<size_t N>
void subModNFT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	if (bint::subNFT<N>(z, x, y)) {
		bint::addNFT<N>(z, z, p);
	}
}

// y[N] <- (-x[N]) % p[N]
template<size_t N>
static void negT(Unit *y, const Unit *x, const Unit *p)
{
	if (bint::isZeroT<N>(x)) {
		if (x != y) bint::clearT<N>(y);
		return;
	}
	bint::subT<N>(y, p, x);
}

// z[N + 1] <- x[N] * y
template<size_t N>
static void mulUnitPreT(Unit *z, const Unit *x, Unit y)
{
	z[N] = bint::mulUnitT<N>(z, x, y);
}

// z[N] <- (x[N] * y) % p[N]
template<size_t N>
static void mulUnitModT(Unit *z, const Unit *x, Unit y, const Unit *p)
{
	Unit xy[N + 1];
	mulUnitPreT<N>(xy, x, y);
	size_t n = bint::div(0, 0, xy, N + 1, p, N);
	bint::copyN(z, xy, n);
	bint::clearN(z + n, N - n);
}

// z[N] <- x[N * 2] % p[N]
template<size_t N>
static void fpDblModT(Unit *y, const Unit *x, const Unit *p)
{
	Unit t[N * 2];
	bint::copyN(t, x, N * 2);
	size_t n = bint::div(0, 0, t, N * 2, p, N);
	bint::copyN(y, t, n);
	bint::clearN(y + n, N - n);
}

//	z[N * 2] <- (x[N * 2] + y[N * 2]) mod p[N] << (N * UnitBitSize)
template<size_t N>
static void fpDblAddModT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	if (bint::addT<N * 2>(z, x, y)) {
		bint::subT<N>(z + N, z + N, p);
		return;
	}
	Unit tmp[N];
	if (bint::subT<N>(tmp, z + N, p) == 0) {
		bint::copyN(z + N, tmp, N);
	}
}

//	z[N * 2] <- (x[N * 2] - y[N * 2]) mod p[N] << (N * UnitBitSize)
template<size_t N>
static void fpDblSubModT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	if (bint::subT<N * 2>(z, x, y)) {
		bint::addT<N>(z + N, z + N, p);
	}
}

/*
	z[N] <- montRed(xy[N * 2], p[N])
	REMARK : assume p[-1] = rp
*/
template<size_t N>
static void modRedT(Unit *z, const Unit *xy, const Unit *p)
{
	const Unit rp = p[-1];
	Unit pq[N + 1];
	Unit buf[N * 2 + 1];
	bint::copyT<N - 1>(buf + N + 1, xy + N + 1);
	buf[N * 2] = 0;
	Unit q = xy[0] * rp;
	mulUnitPreT<N>(pq, p, q);
	Unit up = bint::addT<N + 1>(buf, xy, pq);
	if (up) {
		buf[N * 2] = bint::addUnit(buf + N + 1, N - 1, 1);
	}
	Unit *c = buf + 1;
	for (size_t i = 1; i < N; i++) {
		q = c[0] * rp;
		mulUnitPreT<N>(pq, p, q);
		up = bint::addT<N + 1>(c, c, pq);
		if (up) {
			bint::addUnit(c + N + 1, N - i, 1);
		}
		c++;
	}
	if (c[N]) {
		bint::subT<N>(z, c, p);
	} else {
		if (bint::subT<N>(z, c, p)) {
			bint::copyT<N>(z, c);
		}
	}
}

// [return:z[N+1]] = z[N+1] + x[N] * y + (cc << (N * 32))
template<size_t N>
Unit addMulUnit2T(Unit z[N + 1], const Unit x[N], Unit y, const Unit *cc = 0)
{
	Unit H = bint::mulUnitAddT<N>(z, x, y);
	if (cc) H += *cc;
	Unit v = z[N];
	v += H;
	z[N] = v;
	return v < H;
}

template<size_t N>
static void modRedNFT(Unit *z, const Unit *xy, const Unit *p)
{
	const Unit rp = p[-1];
	Unit buf[N * 2];
	bint::copyT<N * 2>(buf, xy);
	Unit c = 0;
	for (size_t i = 0; i < N; i++) {
		Unit q = buf[i] * rp;
		c = addMulUnit2T<N>(buf + i, p, q, &c);
	}
	if (bint::subT<N>(z, buf + N, p)) {
		bint::copyT<N>(z, buf + N);
	}
}

/*
	z[N] <- Montgomery(x[N], y[N], p[N])
	REMARK : assume p[-1] = rp
*/
template<size_t N>
static void mulMontT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	const Unit rp = p[-1];
	Unit buf[N * 2 + 2];
	Unit *c = buf;
	mulUnitPreT<N>(c, x, y[0]); // x * y[0]
	Unit q = c[0] * rp;
	Unit t[N + 2];
	mulUnitPreT<N>(t, p, q); // p * q
	t[N + 1] = 0; // always zero
	c[N + 1] = bint::addT<N + 1>(c, c, t);
	c++;
	for (size_t i = 1; i < N; i++) {
		mulUnitPreT<N>(t, x, y[i]);
		c[N + 1] = bint::addT<N + 1>(c, c, t);
		q = c[0] * rp;
		mulUnitPreT<N>(t, p, q);
		bint::addT<N + 2>(c, c, t);
		c++;
	}
	if (c[N]) {
		bint::subT<N>(z, c, p);
	} else {
		if (bint::subT<N>(z, c, p)) {
			bint::copyT<N>(z, c);
		}
	}
}

template<size_t N>
static void mulMontNFT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	const Unit rp = p[-1];
	/*
		R = 1 << 64
		L % 64 = 63 ; not full bit
		F = 1 << (L + 1)
		max p = (1 << L) - 1
		x, y <= p - 1
		max x * y[0], p * q <= ((1 << L) - 1)(R - 1)
		t = x * y[i] + p * q <= 2((1 << L) - 1)(R - 1) = (F - 2)(R - 1)
		t >> 64 <= (F - 2)(R - 1)/R = (F - 2) - (F - 2)/R
			t + (t >> 64) = (F - 2)R - (F - 2)/R < FR
	*/
	Unit buf[N * 2];
	buf[N] = bint::mulUnitT<N>(buf, x, y[0]);
	Unit q = buf[0] * rp;
	buf[N] += bint::mulUnitAddT<N>(buf, p, q);
	for (size_t i = 1; i < N; i++) {
		buf[N + i] = bint::mulUnitAddT<N>(buf + i, x, y[i]);
		q = buf[i] * rp;
		buf[N + i] += bint::mulUnitAddT<N>(buf + i, p, q);
	}
	if (bint::subT<N>(z, buf + N, p)) {
		bint::copyT<N>(z, buf + N);
	}
}

// z[N] <- Montgomery(x[N], x[N], p[N])
template<size_t N>
static void sqrMontT(Unit *y, const Unit *x, const Unit *p)
{
	mulMontT<N>(y, x, x, p);
}

template<size_t N>
static void sqrMontNFT(Unit *y, const Unit *x, const Unit *p)
{
	mulMontNFT<N>(y, x, x, p);
}

// z[N] <- (x[N] * y[N]) % p[N]
template<size_t N>
static void mulModT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	Unit xy[N * 2];
	bint::mulT<N>(xy, x, y);
	fpDblModT<N>(z, xy, p);
}

// y[N] <- (x[N] * x[N]) % p[N]
template<size_t N>
static void sqrModT(Unit *y, const Unit *x, const Unit *p)
{
	Unit xx[N * 2];
	bint::sqrT<N>(xx, x);
	fpDblModT<N>(y, xx, p);
}

template<size_t N>
static void fp2_mulNFT(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	const Unit *const a = x;
	const Unit *const b = x + N;
	const Unit *const c = y;
	const Unit *const d = y + N;
	Unit d0[N * 2];
	Unit d1[N * 2];
	Unit d2[N * 2];
	Unit s[N];
	Unit t[N];
	bint::addT<N>(s, a, b);
	bint::addT<N>(t, c, d);
	bint::mulT<N>(d0, s, t);
	bint::mulT<N>(d1, a, c);
	bint::mulT<N>(d2, b, d);
	bint::subT<N * 2>(d0, d0, d1);
	bint::subT<N * 2>(d0, d0, d2);
	modRedNFT<N>(z + N, d0, p);
	fpDblSubModT<N>(d1, d1, d2, p);
	modRedNFT<N>(z, d1, p);
}

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
