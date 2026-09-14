#pragma once
/**
	@file
	@brief non constant time invMod by safegcd
	@author MITSUNARI Shigeo(@herumi)
	cf. The original code is https://github.com/bitcoin-core/secp256k1/blob/master/doc/safegcd_implementation.md
	It is offered under the MIT license.
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/gmp_util.hpp>
#include <mcl/bint.hpp>
#include <cybozu/bit_operation.hpp>
#include <mcl/invmod_fwd.hpp>
#include <mcl/util.hpp>

namespace mcl {

namespace inv {

struct Quad {
	Unit u, v, q, r;
};

template<int N>
void _add(SintT<N>& z, const SintT<N>& x, const Unit *y, bool ySign)
{
	if (x.sign == ySign) {
		Unit ret = mcl::bint::addT<N>(z.v, x.v, y);
		(void)ret;
		assert(ret == 0);
		z.sign = x.sign;
		return;
	}
	int r = mcl::bint::cmpT<N>(x.v, y);
	if (r >= 0) {
		mcl::bint::subT<N>(z.v, x.v, y);
		z.sign = x.sign;
		return;
	}
	mcl::bint::subT<N>(z.v, y, x.v);
	z.sign = ySign;
}

template<int N>
void set(SintT<N>& y, const Unit *x, bool sign)
{
	mcl::bint::copyT<N>(y.v, x);
	y.sign = sign;
}

template<int N>
void clear(SintT<N>& x)
{
	x.sign = false;
	mcl::bint::clearT<N>(x.v);
}

template<int N>
bool isZero(const SintT<N>& x)
{
	Unit r = x.v[0];
	for (int i = 1; i < N; i++) r |= x.v[i];
	return r == 0;
}

template<int N>
void add(SintT<N>& z, const SintT<N>& x, const SintT<N>& y)
{
	_add(z, x, y.v, y.sign);
}

template<int N>
void sub(SintT<N>& z, const SintT<N>& x, const SintT<N>& y)
{
	_add(z, x, y.v, !y.sign);
}

template<int N>
void mulUnit(SintT<N+1>&z, const SintT<N>& x, INT y)
{
	Unit abs_y = y < 0 ? -y : y;
	z.v[N] = mcl::bint::mulUnitT<N>(z.v, x.v, abs_y);
	z.sign = x.sign ^ (y < 0);
}

template<int N>
void shr(SintT<N>& y, int x)
{
	mcl::bint::shrT<N>(y.v, y.v, x);
}

template<int N>
Unit getLow(const SintT<N>& x)
{
	Unit r = x.v[0];
	if (x.sign) r = -r;
	return r;
}

template<int N>
Unit getLowMask(const SintT<N>& x)
{
	Unit r = getLow(x);
	return r & MASK;
}

template<int N2>
void toSint(SintT<N2>& y, const mpz_class& x)
{
	const size_t n = mcl::gmp::getUnitSize(x);
	const Unit *p = mcl::gmp::getUnit(x);
	for (size_t i = 0; i < n; i++) {
		y.v[i] = p[i];
	}
	for (size_t i = n; i < N2; i++) y.v[i] = 0;
	y.sign = x < 0;
}
template<int N2>
void toMpz(mpz_class& y, const SintT<N2>& x)
{
	mcl::gmp::setArray(y, x.v, N2);
	if (x.sign) y = -y;
}

/*
	modL divsteps on the low bits (f, g) as a matrix t (cf. secp256k1_modinv64_divsteps_62_var).
	Each inner iteration cancels the low min(limit, 8) bits of g by adding
	w f (w = g (-f^-1 mod 256) mod 2^limit), so it takes fewer iterations than
	the 4-bit table version.
*/
static inline INT divsteps_n_matrix(Quad& t, INT eta, Unit f, Unit g)
{
	// negInv256[(f & 255) >> 1] = -f^-1 mod 256 for odd f
	static const uint8_t negInv256[128] = {
		255, 85, 51, 73, 199, 93, 59, 17, 15, 229, 195, 89, 215, 237, 203, 33,
		31, 117, 83, 105, 231, 125, 91, 49, 47, 5, 227, 121, 247, 13, 235, 65,
		63, 149, 115, 137, 7, 157, 123, 81, 79, 37, 3, 153, 23, 45, 11, 97,
		95, 181, 147, 169, 39, 189, 155, 113, 111, 69, 35, 185, 55, 77, 43, 129,
		127, 213, 179, 201, 71, 221, 187, 145, 143, 101, 67, 217, 87, 109, 75, 161,
		159, 245, 211, 233, 103, 253, 219, 177, 175, 133, 99, 249, 119, 141, 107, 193,
		191, 21, 243, 9, 135, 29, 251, 209, 207, 165, 131, 25, 151, 173, 139, 225,
		223, 53, 19, 41, 167, 61, 27, 241, 239, 197, 163, 57, 183, 205, 171, 1,
	};
	Unit u = 1, v = 0, q = 0, r = 1;
	int i = modL;
	for (;;) {
		// zeros = min(i, bsf(g)) (i if g == 0); bit i of the argument is set, so bsf is defined
		INT zeros = cybozu::bsf(g | (~Unit(0) << i));
		eta -= zeros;
		i -= zeros;
		g >>= zeros;
		u <<= zeros;
		v <<= zeros;
		if (i == 0) break;
		if (eta < 0) {
			Unit u0 = u;
			Unit v0 = v;
			Unit f0 = f;
			eta = -eta;
			f = g;
			u = q;
			v = r;
			g = -f0;
			q = -u0;
			r = -v0;
		}
		// 1 <= limit <= modL ; the mask is the low min(limit, 8) bits
		int limit = mcl::fp::min_<INT>(eta + 1, i);
		Unit w = (g * negInv256[(f & 255) >> 1]) & ((Unit(-1) >> (UnitBitSize - limit)) & 255);
		g += w * f;
		q += w * u;
		r += w * v;
	}
	t.u = u;
	t.v = v;
	t.q = q;
	t.r = r;
	return eta;
}

template<int N>
void update_fg(SintT<N>& f, SintT<N>& g, const Quad& t)
{
	SintT<N+1> f1, f2, g1, g2;
	mulUnit(f1, f, t.u);
	mulUnit(f2, f, t.q);
	mulUnit(g1, g, t.v);
	mulUnit(g2, g, t.r);
	add(f1, f1, g1);
	add(g1, f2, g2);
	shr(f1, modL);
	shr(g1, modL);
	assert(f1.v[N] == 0);
	assert(g1.v[N] == 0);
	set(f, f1.v, f1.sign);
	set(g, g1.v, g1.sign);
}

template<int N>
void update_de(const InvModT<N>& im, SintT<N>& d, SintT<N>& e, const Quad& t)
{
	const SintT<N>& M = im.M;
	const INT Mi = im.Mi;
	Unit ud = 0;
	Unit ue = 0;
	if (d.sign) {
		ud = t.u;
		ue = t.q;
	}
	if (e.sign) {
		ud += t.v;
		ue += t.r;
	}
	SintT<N+1> d1, d2, e1, e2;
	// d = d * u + e * v
	// e = d * q + e * r
	mulUnit(d1, d, t.u);
	mulUnit(d2, d, t.q);
	mulUnit(e1, e, t.v);
	mulUnit(e2, e, t.r);
	add(d1, d1, e1);
	add(e1, d2, e2);
	Unit di = getLow(d1) + im.lowM * ud;
	Unit ei = getLow(e1) + im.lowM * ue;
	ud -= Mi * di;
	ue -= Mi * ei;
	INT sd = ud & MASK;
	INT se = ue & MASK;
	if (sd >= half) sd -= modN;
	if (se >= half) se -= modN;
	// d = (d + M * sd) >> modL
	// e = (e + M * se) >> modL
	mulUnit(d2, M, sd);
	mulUnit(e2, M, se);
	add(d1, d1, d2);
	add(e1, e1, e2);
	shr(d1, modL);
	shr(e1, modL);
	assert(d1.v[N] == 0);
	assert(e1.v[N] == 0);
	set(d, d1.v, d1.sign);
	set(e, e1.v, e1.sign);
}

template<int N>
void normalize(const InvModT<N>& im, SintT<N>& v, bool minus)
{
	const SintT<N>& M = im.M;
	if (v.sign) {
		add(v, v, M);
	}
	if (minus) {
		sub(v, M, v);
	}
	if (v.sign) {
		add(v, v, M);
	}
}

// sign-magnitude version (any M < 2^(UnitBitSize * N))
template<int N>
void execSM(const InvModT<N>& im, Unit *py, const Unit *px)
{
	INT eta = -1;
	SintT<N> f = im.M, g, d, e;
	set(g, px, false);

	clear(d);
	clear(e); e.v[0] = 1;
	Quad t;
	while (!isZero(g)) {
		Unit fLow = getLowMask(f);
		Unit gLow = getLowMask(g);
		eta = divsteps_n_matrix(t, eta, fLow, gLow);
		update_fg(f, g, t);
		update_de(im, d, e, t);
	}
	normalize(im, d, f.sign);
	mcl::bint::copyT<N>(py, d.v);
}


/*
	two's complement version
	f, g, d, e are N-unit two's complement values instead of SintT<N>, so
	add/sub are plain addT/subT (no sign compare and branch as in _add).
	It requires |d|, |e| < 2M (the safegcd invariant) to fit in a signed
	N-unit value, i.e. M < 2^(UnitBitSize * N - 2) (see init).
*/
namespace twos {

inline Unit signMask(Unit x)
{
	return Unit(0) - (x >> (UnitBitSize - 1));
}

/*
	z[N+1] = x[N] * a + y[N] * b (x, y : two's complement, a, b : signed units)
	The result fits in N+1 units, so the low N+1 units of the unsigned
	products are corrected as
	x a = x_u a_u - [x < 0] (a_u << (N UnitBitSize)) - [a < 0] (x_u << UnitBitSize)
	mod 2^((N+1) UnitBitSize) (the same for y b). The two (x_u << UnitBitSize)
	corrections are summed before the subtraction (mod 2^(N UnitBitSize) suffices).
*/
template<int N>
void mulAdd2(Unit *z, const Unit *x, Unit a, const Unit *y, Unit b)
{
	z[N] = mcl::bint::mulUnitT<N>(z, x, a);
	z[N] += mcl::bint::mulUnitAddT<N>(z, y, b);
	z[N] -= (a & signMask(x[N - 1])) + (b & signMask(y[N - 1]));
	const Unit ma = signMask(a);
	const Unit mb = signMask(b);
	Unit s[N], t[N];
	for (int i = 0; i < N; i++) {
		s[i] = x[i] & ma;
		t[i] = y[i] & mb;
	}
	mcl::bint::addT<N>(s, s, t);
	mcl::bint::subT<N>(z + 1, z + 1, s);
}

// z[N+1] += x[N] * y (x >= 0 (M), y : signed unit)
template<int N>
void mulAddNonNeg(Unit *z, const Unit *x, Unit y)
{
	z[N] += mcl::bint::mulUnitAddT<N>(z, x, y);
	const Unit m = signMask(y);
	Unit t[N];
	for (int i = 0; i < N; i++) t[i] = x[i] & m;
	mcl::bint::subT<N>(z + 1, z + 1, t);
}

// y[N] = x[N+1] >> modL (arithmetic shift ; the result fits in N units)
template<int N>
void shr(Unit *y, const Unit *x)
{
	// the top 3 bits of x[N] must be equal so that the result fits in N units
	assert((x[N] >> (UnitBitSize - 3)) == 0 || (x[N] >> (UnitBitSize - 3)) == 7);
	for (int i = 0; i < N; i++) {
		y[i] = (x[i] >> modL) | (x[i + 1] << (UnitBitSize - modL));
	}
}

template<int N>
void update_fg(Unit *f, Unit *g, const Quad& t)
{
	Unit f1[N + 1], g1[N + 1];
	mulAdd2<N>(f1, f, t.u, g, t.v);
	mulAdd2<N>(g1, f, t.q, g, t.r);
	shr<N>(f, f1);
	shr<N>(g, g1);
}

template<int N>
void update_de(const InvModT<N>& im, Unit *d, Unit *e, const Quad& t)
{
	const Unit *M = im.M.v;
	const Unit md = signMask(d[N - 1]);
	const Unit me = signMask(e[N - 1]);
	Unit ud = (t.u & md) + (t.v & me);
	Unit ue = (t.q & md) + (t.r & me);
	Unit d1[N + 1], e1[N + 1];
	// d = d * u + e * v
	// e = d * q + e * r
	mulAdd2<N>(d1, d, t.u, e, t.v);
	mulAdd2<N>(e1, d, t.q, e, t.r);
	// the low unit of a two's complement value is getLow
	Unit di = d1[0] + im.lowM * ud;
	Unit ei = e1[0] + im.lowM * ue;
	ud -= im.Mi * di;
	ue -= im.Mi * ei;
	// sd = (ud mod 2^modL) in [-half, half) as a two's complement unit
	Unit sd = ud & Unit(MASK);
	Unit se = ue & Unit(MASK);
	sd -= (sd & Unit(half)) << 1;
	se -= (se & Unit(half)) << 1;
	// d = (d + M * sd) >> modL
	// e = (e + M * se) >> modL
	mulAddNonNeg<N>(d1, M, sd);
	mulAddNonNeg<N>(e1, M, se);
	shr<N>(d, d1);
	shr<N>(e, e1);
}

// v += M if v < 0
template<int N>
void addMifNeg(Unit *v, const Unit *M)
{
	const Unit m = signMask(v[N - 1]);
	Unit t[N];
	for (int i = 0; i < N; i++) t[i] = M[i] & m;
	mcl::bint::addT<N>(v, v, t);
}

template<int N>
void normalize(const InvModT<N>& im, Unit *v, bool minus)
{
	const Unit *M = im.M.v;
	addMifNeg<N>(v, M);
	if (minus) {
		mcl::bint::subT<N>(v, M, v);
	}
	addMifNeg<N>(v, M);
}

template<int N>
void exec(const InvModT<N>& im, Unit *py, const Unit *px)
{
	INT eta = -1;
	Unit f[N], g[N], d[N], e[N];
	mcl::bint::copyT<N>(f, im.M.v);
	mcl::bint::copyT<N>(g, px);
	mcl::bint::clearT<N>(d);
	mcl::bint::clearT<N>(e); e[0] = 1;
	Quad t;
	while (!mcl::bint::isZeroT<N>(g)) {
		Unit fLow = f[0] & Unit(MASK);
		Unit gLow = g[0] & Unit(MASK);
		eta = divsteps_n_matrix(t, eta, fLow, gLow);
		update_fg<N>(f, g, t);
		update_de<N>(im, d, e, t);
	}
	normalize<N>(im, d, (f[N - 1] >> (UnitBitSize - 1)) != 0);
	mcl::bint::copyT<N>(py, d);
}

} // mcl::inv::twos

template<int N>
void exec(const InvModT<N>& im, Unit *py, const Unit *px)
{
	if (im.useTwos) {
		twos::exec<N>(im, py, px);
	} else {
		execSM<N>(im, py, px);
	}
}

template<int N>
void exec(const InvModT<N>& im, mpz_class& y, const mpz_class& x)
{
	Unit ux[N], uy[N];
	mcl::gmp::getArray(ux, N, x);
	exec<N>(im, uy, ux);
	mcl::gmp::setArray(y, uy, N);
}

template<int N>
void init(InvModT<N>& invMod, const mpz_class& mM)
{
	toSint(invMod.M, mM);
	invMod.lowM = getLow(invMod.M);
	mpz_class inv;
	mpz_class mod = mpz_class(1) << modL;
	mcl::gmp::invMod(inv, mM, mod);
	invMod.Mi = mcl::gmp::getUnit(inv)[0] & MASK;
	invMod.useTwos = mcl::gmp::getBitSize(mM) <= UnitBitSize * N - 2;
}

} // mcl::inv

} // mcl
