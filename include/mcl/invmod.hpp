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

#include <string.h>
#include <mcl/bint.hpp>
#include <cybozu/bit_operation.hpp>
#include <mcl/invmod_fwd.hpp>
#include <mcl/util.hpp>
#if defined(_MSC_VER) && MCL_SIZEOF_UNIT == 8
	#include <intrin.h>
#endif

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
	f, g, d, e are L signed limbs of modL bits (int64_t limbs of 62 bits for
	64-bit units as secp256k1_modinv64_signed62, int32_t limbs of 30 bits for
	32-bit units as secp256k1_modinv32_signed30): the low limbs are in
	[0, 2^modL) and the top limb is signed. L = ceil((UnitBitSize N + 2) / modL)
	(InvModT::L), so |f|, |g| <= M and -2M < d, e < M (the safegcd invariants,
	cf. safegcd_implementation.md "Avoiding modulus operations") always fit.
	The limb products are accumulated in Acc (2 units wide): the 2-bit headroom
	of the limbs means no carry chain and no sign correction
	(cf. secp256k1_modinv{64,32}_update_{fg,de}_{62,30}).
*/
#if MCL_SIZEOF_UNIT == 8
#if defined(__SIZEOF_INT128__) && !defined(MCL_INVMOD_STRUCT_ACC)
typedef __int128 Acc;
inline Acc mulAcc(Limb a, Limb b) { return (Acc)a * b; }
inline void accumMul(Acc& c, Limb a, Limb b) { c += (Acc)a * b; }
inline void shrAcc(Acc& c) { c >>= modL; }
inline Limb lowAcc(const Acc& c) { return (Limb)c; }
#else
/*
	128-bit signed accumulator without __int128 (MSVC) as libsecp256k1's
	int128_struct_impl.h. MCL_INVMOD_STRUCT_ACC forces it (to test it with gcc/clang).
*/
struct Acc {
	uint64_t lo;
	int64_t hi;
};
// [*hi:return] = a * b (signed)
inline uint64_t mulLoHi(int64_t a, int64_t b, int64_t *hi)
{
#if defined(_MSC_VER) && defined(_M_X64)
	return (uint64_t)_mul128(a, b, hi);
#elif defined(_MSC_VER) && defined(_M_ARM64)
	*hi = __mulh(a, b);
	return (uint64_t)a * (uint64_t)b;
#elif defined(__SIZEOF_INT128__)
	__int128 t = (__int128)a * b;
	*hi = (int64_t)(t >> 64);
	return (uint64_t)t;
#else
	#error "no 64x64 -> 128 multiply"
#endif
}
inline Acc mulAcc(Limb a, Limb b)
{
	Acc c;
	c.lo = mulLoHi(a, b, &c.hi);
	return c;
}
inline void accumMul(Acc& c, Limb a, Limb b)
{
	int64_t hi;
	uint64_t lo = mulLoHi(a, b, &hi);
	c.lo += lo;
	c.hi = (int64_t)((uint64_t)c.hi + (uint64_t)hi + (c.lo < lo));
}
// arithmetic shift
inline void shrAcc(Acc& c)
{
	c.lo = (c.lo >> modL) | ((uint64_t)c.hi << (64 - modL));
	c.hi >>= modL;
}
inline Limb lowAcc(const Acc& c) { return (Limb)c.lo; }
#endif
#else // MCL_SIZEOF_UNIT == 4
// |a| <= 2^30 and |b| < 2^31, so three products and a carry fit in int64_t
typedef int64_t Acc;
inline Acc mulAcc(Limb a, Limb b) { return (Acc)a * b; }
inline void accumMul(Acc& c, Limb a, Limb b) { c += (Acc)a * b; }
inline void shrAcc(Acc& c) { c >>= modL; }
inline Limb lowAcc(const Acc& c) { return (Limb)c; }
#endif

static const int limbBits = sizeof(Limb) * 8;
static const Limb limbMask = (Limb)MASK;

// y[L] = x[N] (nonnegative units) in signed limbs
template<int N>
void toLimb(Limb *y, const Unit *x)
{
	const int L = InvModT<N>::L;
	for (int i = 0; i < L; i++) {
		int bit = modL * i;
		int idx = bit / MCL_UNIT_BIT_SIZE, off = bit % MCL_UNIT_BIT_SIZE;
		Unit lo = idx < N ? x[idx] >> off : 0;
		Unit hi = (off > MCL_UNIT_BIT_SIZE - modL && idx + 1 < N) ? x[idx + 1] << (MCL_UNIT_BIT_SIZE - off) : 0;
		y[i] = (Limb)((lo | hi) & (Unit)limbMask);
	}
}

// x[N] = y[L] (normalized nonnegative limbs, < 2^(UnitBitSize N))
template<int N>
void fromLimb(Unit *x, const Limb *y)
{
	const int L = InvModT<N>::L;
	for (int i = 0; i < N; i++) x[i] = 0;
	for (int i = 0; i < L; i++) {
		int bit = modL * i;
		int idx = bit / MCL_UNIT_BIT_SIZE, off = bit % MCL_UNIT_BIT_SIZE;
		Unit v = (Unit)y[i];
		if (idx < N) x[idx] |= v << off;
		if (off > MCL_UNIT_BIT_SIZE - modL && idx + 1 < N) x[idx + 1] |= v >> (MCL_UNIT_BIT_SIZE - off);
	}
}

template<int L>
bool isZero(const Limb *x)
{
	Limb r = 0;
	for (int i = 0; i < L; i++) r |= x[i];
	return r == 0;
}

// (f, g) = ((u f + v g) >> modL, (q f + r g) >> modL)
template<int L>
void update_fg(Limb *f, Limb *g, const Quad& t)
{
	const Limb u = (Limb)t.u, v = (Limb)t.v, q = (Limb)t.q, r = (Limb)t.r;
	Limb fi = f[0], gi = g[0];
	Acc cf = mulAcc(u, fi); accumMul(cf, v, gi);
	Acc cg = mulAcc(q, fi); accumMul(cg, r, gi);
	// the low modL bits are zero
	shrAcc(cf);
	shrAcc(cg);
	for (int i = 1; i < L; i++) {
		fi = f[i];
		gi = g[i];
		accumMul(cf, u, fi); accumMul(cf, v, gi);
		accumMul(cg, q, fi); accumMul(cg, r, gi);
		f[i - 1] = lowAcc(cf) & limbMask; shrAcc(cf);
		g[i - 1] = lowAcc(cg) & limbMask; shrAcc(cg);
	}
	f[L - 1] = lowAcc(cf);
	g[L - 1] = lowAcc(cg);
}

/*
	d = (u d + v e + md M) >> modL, e = (q d + r e + me M) >> modL
	md = ud - ((Mi (u d + v e) + ud) mod 2^modL) (in (ud - 2^modL, ud], ud = u [d < 0] + v [e < 0]),
	so u d + v e + md M = 0 mod 2^modL and -2M < d, e < M is kept.
*/
template<int L>
void update_de(const Limb *M, Unit Mi, Limb *d, Limb *e, const Quad& t)
{
	const Limb u = (Limb)t.u, v = (Limb)t.v, q = (Limb)t.q, r = (Limb)t.r;
	const Limb d0 = d[0], e0 = e[0];
	const Limb sd = d[L - 1] >> (limbBits - 1);
	const Limb se = e[L - 1] >> (limbBits - 1);
	Limb md = (u & sd) + (v & se);
	Limb me = (q & sd) + (r & se);
	Acc cd = mulAcc(u, d0); accumMul(cd, v, e0);
	Acc ce = mulAcc(q, d0); accumMul(ce, r, e0);
	md -= (Limb)((Mi * (Unit)lowAcc(cd) + (Unit)md) & (Unit)limbMask);
	me -= (Limb)((Mi * (Unit)lowAcc(ce) + (Unit)me) & (Unit)limbMask);
	accumMul(cd, M[0], md);
	accumMul(ce, M[0], me);
	// the low modL bits are zero
	shrAcc(cd);
	shrAcc(ce);
	for (int i = 1; i < L; i++) {
		accumMul(cd, u, d[i]); accumMul(cd, v, e[i]); accumMul(cd, M[i], md);
		accumMul(ce, q, d[i]); accumMul(ce, r, e[i]); accumMul(ce, M[i], me);
		d[i - 1] = lowAcc(cd) & limbMask; shrAcc(cd);
		e[i - 1] = lowAcc(ce) & limbMask; shrAcc(ce);
	}
	d[L - 1] = lowAcc(cd);
	e[L - 1] = lowAcc(ce);
}

// r in (-2M, M) -> [0, M) (negated if sign < 0), cf. secp256k1_modinv64_normalize_62
template<int L>
void normalize(Limb *r, Limb sign, const Limb *M)
{
	Limb cond = r[L - 1] >> (limbBits - 1);
	for (int i = 0; i < L; i++) r[i] += M[i] & cond;
	cond = sign >> (limbBits - 1);
	for (int i = 0; i < L; i++) r[i] = (r[i] ^ cond) - cond;
	for (int i = 0; i < L - 1; i++) {
		r[i + 1] += r[i] >> modL;
		r[i] &= limbMask;
	}
	cond = r[L - 1] >> (limbBits - 1);
	for (int i = 0; i < L; i++) r[i] += M[i] & cond;
	for (int i = 0; i < L - 1; i++) {
		r[i + 1] += r[i] >> modL;
		r[i] &= limbMask;
	}
}

// y[N] = x[N]^-1 mod M (0 if x = 0) ; y = x is allowed
template<int N>
void exec(const InvModT<N>& im, Unit *py, const Unit *px)
{
	const int L = InvModT<N>::L;
	Sint eta = -1;
	Limb f[L], g[L], d[L], e[L];
	memcpy(f, im.M, sizeof(f));
	toLimb<N>(g, px);
	memset(d, 0, sizeof(d));
	memset(e, 0, sizeof(e));
	e[0] = 1;
	Quad t;
	while (!isZero<L>(g)) {
		// the low modL bits of f and g are the low limbs
		eta = divsteps_n_matrix(t, eta, (Unit)f[0], (Unit)g[0]);
		update_fg<L>(f, g, t);
		update_de<L>(im.M, im.Mi, d, e, t);
	}
	normalize<L>(d, f[L - 1], im.M);
	fromLimb<N>(py, d);
}

// M[N] : odd modulus
template<int N>
void init(InvModT<N>& invMod, const Unit *M)
{
	toLimb<N>(invMod.M, M);
	// getMontgomeryCoeff(M[0], modL) = -M^-1 mod 2^modL
	invMod.Mi = (0 - bint::getMontgomeryCoeff(M[0], modL)) & (Unit)MASK;
}

} // mcl::inv

} // mcl
