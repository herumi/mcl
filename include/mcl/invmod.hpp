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

/*
	modL divsteps on the low bits (f, g) as a matrix t (cf. secp256k1_modinv64_divsteps_62_var).
	Each inner iteration cancels the low min(limit, 8) bits of g by adding
	w f (w = g (-f^-1 mod 256) mod 2^limit), so it takes fewer iterations than
	the 4-bit table version.
*/
static inline Sint divsteps_n_matrix(Quad& t, Sint eta, Unit f, Unit g)
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
		Sint zeros = cybozu::bsf(g | (~Unit(0) << i));
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
		int limit = mcl::fp::min_<Sint>(eta + 1, i);
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

/*
	f, g, d, e are W-unit two's complement values (W = N or N + 1, see InvModT::wide),
	so add/sub are plain addT/subT without sign compare and branch.
	The safegcd invariants |f|, |g| <= M and -2M < d, e < M
	(cf. safegcd_implementation.md "Avoiding modulus operations") must fit in
	a signed W-unit value: M < 2^(UnitBitSize W - 2).
*/
namespace twos {

inline Unit signMask(Unit x)
{
	return Unit(0) - (x >> (UnitBitSize - 1));
}

/*
	z[W+1] = x[W] * a + y[W] * b (x, y : two's complement, a, b : signed units)
	The result fits in W+1 units, so the low W+1 units of the unsigned
	products are corrected as
	x a = x_u a_u - [x < 0] (a_u << (W UnitBitSize)) - [a < 0] (x_u << UnitBitSize)
	mod 2^((W+1) UnitBitSize) (the same for y b). The two (x_u << UnitBitSize)
	corrections are summed before the subtraction (mod 2^(W UnitBitSize) suffices).
*/
template<int W>
void mulAdd2(Unit *z, const Unit *x, Unit a, const Unit *y, Unit b)
{
	z[W] = mcl::bint::mulUnitT<W>(z, x, a);
	z[W] += mcl::bint::mulUnitAddT<W>(z, y, b);
	z[W] -= (a & signMask(x[W - 1])) + (b & signMask(y[W - 1]));
	const Unit ma = signMask(a);
	const Unit mb = signMask(b);
	Unit s[W], t[W];
	for (int i = 0; i < W; i++) {
		s[i] = x[i] & ma;
		t[i] = y[i] & mb;
	}
	mcl::bint::addT<W>(s, s, t);
	mcl::bint::subT<W>(z + 1, z + 1, s);
}

// z[W+1] += x[W] * y (x >= 0 (M), y : signed unit)
template<int W>
void mulAddNonNeg(Unit *z, const Unit *x, Unit y)
{
	z[W] += mcl::bint::mulUnitAddT<W>(z, x, y);
	const Unit m = signMask(y);
	Unit t[W];
	for (int i = 0; i < W; i++) t[i] = x[i] & m;
	mcl::bint::subT<W>(z + 1, z + 1, t);
}

// y[W] = x[W+1] >> modL (arithmetic shift ; the result fits in W units)
template<int W>
void shr(Unit *y, const Unit *x)
{
	// the top 3 bits of x[W] must be equal so that the result fits in W units
	assert((x[W] >> (UnitBitSize - 3)) == 0 || (x[W] >> (UnitBitSize - 3)) == 7);
	for (int i = 0; i < W; i++) {
		y[i] = (x[i] >> modL) | (x[i + 1] << (UnitBitSize - modL));
	}
}

template<int W>
void update_fg(Unit *f, Unit *g, const Quad& t)
{
	Unit f1[W + 1], g1[W + 1];
	mulAdd2<W>(f1, f, t.u, g, t.v);
	mulAdd2<W>(g1, f, t.q, g, t.r);
	shr<W>(f, f1);
	shr<W>(g, g1);
}

/*
	d = (d u + e v + sd M) >> modL, e = (d q + e r + se M) >> modL
	sd = ud - ((Mi cd) mod 2^modL) (in (ud - 2^modL, ud], ud = u [d < 0] + v [e < 0],
	cd = the low unit of d u + e v + M ud), so d u + e v + sd M = 0 mod 2^modL and
	-2M < d, e < M is kept (cf. secp256k1_modinv64_update_de_62).
*/
template<int N, int W>
void update_de(const InvModT<N>& im, Unit *d, Unit *e, const Quad& t)
{
	const Unit *M = im.M;
	const Unit md = signMask(d[W - 1]);
	const Unit me = signMask(e[W - 1]);
	Unit ud = (t.u & md) + (t.v & me);
	Unit ue = (t.q & md) + (t.r & me);
	Unit d1[W + 1], e1[W + 1];
	mulAdd2<W>(d1, d, t.u, e, t.v);
	mulAdd2<W>(e1, d, t.q, e, t.r);
	// the low unit of a two's complement value is its value mod 2^UnitBitSize
	Unit di = d1[0] + im.lowM * ud;
	Unit ei = e1[0] + im.lowM * ue;
	Unit sd = ud - ((im.Mi * di) & Unit(MASK));
	Unit se = ue - ((im.Mi * ei) & Unit(MASK));
	mulAddNonNeg<W>(d1, M, sd);
	mulAddNonNeg<W>(e1, M, se);
	shr<W>(d, d1);
	shr<W>(e, e1);
}

// v += M if v < 0
template<int W>
void addMifNeg(Unit *v, const Unit *M)
{
	const Unit m = signMask(v[W - 1]);
	Unit t[W];
	for (int i = 0; i < W; i++) t[i] = M[i] & m;
	mcl::bint::addT<W>(v, v, t);
}

// v in (-2M, M) -> [0, M) (negated if minus)
template<int W>
void normalize(const Unit *M, Unit *v, bool minus)
{
	addMifNeg<W>(v, M);
	if (minus) {
		Unit zero[W];
		mcl::bint::clearT<W>(zero);
		mcl::bint::subT<W>(v, zero, v);
	}
	addMifNeg<W>(v, M);
}

template<int N, int W>
void exec(const InvModT<N>& im, Unit *py, const Unit *px)
{
	Sint eta = -1;
	Unit f[W], g[W], d[W], e[W];
	mcl::bint::copyT<W>(f, im.M);
	mcl::bint::copyT<N>(g, px);
	for (int i = N; i < W; i++) g[i] = 0;
	mcl::bint::clearT<W>(d);
	mcl::bint::clearT<W>(e); e[0] = 1;
	Quad t;
	while (!mcl::bint::isZeroT<W>(g)) {
		Unit fLow = f[0] & Unit(MASK);
		Unit gLow = g[0] & Unit(MASK);
		eta = divsteps_n_matrix(t, eta, fLow, gLow);
		update_fg<W>(f, g, t);
		update_de<N, W>(im, d, e, t);
	}
	normalize<W>(im.M, d, (f[W - 1] >> (UnitBitSize - 1)) != 0);
	mcl::bint::copyT<N>(py, d);
}

} // mcl::inv::twos

template<int N>
void exec(const InvModT<N>& im, Unit *py, const Unit *px)
{
	if (im.wide) {
		twos::exec<N, N + 1>(im, py, px);
	} else {
		twos::exec<N, N>(im, py, px);
	}
}

// returns false if x does not fit in N units
template<int N>
bool exec(const InvModT<N>& im, mpz_class& y, const mpz_class& x)
{
	Unit ux[N], uy[N];
	bool b;
	mcl::gmp::getArray(&b, ux, N, x);
	if (!b) return false;
	exec<N>(im, uy, ux);
	mcl::gmp::setArray(&b, y, uy, N);
	return b;
}

// returns false if M does not fit in N units
template<int N>
bool init(InvModT<N>& invMod, const mpz_class& mM)
{
	bool b;
	mcl::gmp::getArray(&b, invMod.M, N, mM);
	if (!b) return false;
	invMod.M[N] = 0;
	invMod.lowM = invMod.M[0];
	mpz_class inv;
	mpz_class mod = mpz_class(1) << modL;
	mcl::gmp::invMod(inv, mM, mod);
	invMod.Mi = mcl::gmp::getUnit(inv, 0) & MASK;
	invMod.wide = mcl::gmp::getBitSize(mM) > UnitBitSize * N - 2;
	return true;
}

} // mcl::inv

} // mcl
