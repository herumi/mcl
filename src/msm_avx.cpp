/**
	@file
	@brief multi scalar multiplication with AVX-512 IFMA
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdint.h>
#include <mcl/ec.hpp>
#ifdef _WIN32
#include <intrin.h>
#else
#include <x86intrin.h>
#endif
#define XBYAK_NO_EXCEPTION
#include "xbyak/xbyak_util.h"

typedef mcl::Unit Unit;
typedef __m512i Vec;
typedef __mmask8 Vmask;

static mcl::msm::Param g_param;

const size_t S = sizeof(Unit)*8-1; // 63
const size_t W = 52;
const size_t N = 8; // = ceil(384/52)
const size_t M = sizeof(Vec) / sizeof(Unit);
const uint64_t g_mask = (Unit(1)<<W) - 1;

static Unit g_mpM2[6]; // x^(-1) = x^(p-2) mod p

static Vec vmask;
static Vec vrp;
static Vec vpN[N];
static Vec g_vmpM2[6]; // NOT 52-bit but 64-bit
static Vec g_vmask4;
static Vec g_offset;
static Vec g_vi192;

inline Unit getMask(int w)
{
	if (w == 64) return Unit(-1);
	return (Unit(1) << w) - 1;
}

template<size_t N, int w = W>
inline void toArray(Unit x[N], mpz_class mx)
{
	const Unit mask = getMask(w);
	for (size_t i = 0; i < N; i++) {
		mpz_class a = mx & mask;
		x[i] = mcl::gmp::getUnit(a)[0];
		mx >>= w;
	}
}

template<size_t N>
inline mpz_class fromArray(const Unit x[N])
{
	mpz_class mx = x[N-1];
	for (size_t i = 1; i < N; i++) {
		mx <<= W;
		mx += x[N-1-i];
	}
	return mx;
}

inline Vec vzero()
{
	return _mm512_setzero_epi32();
}

inline Vec vone()
{
	return _mm512_set1_epi32(1);
}

// set x[j] to i-th SIMD element of v[j]
inline void set(Vec v[N], size_t i, const Unit x[N])
{
	assert(i < M);
	Unit *p = (Unit *)v;
	for (size_t j = 0; j < N; j++) {
		p[j*M+i] = x[j];
	}
}

inline void get(Unit x[N], const Vec v[N], size_t i)
{
	assert(i < M);
	const Unit *p = (const Unit *)v;
	for (size_t j = 0; j < N; j++) {
		x[j] = p[j*M+i];
	}
}

inline void cvt(Vec yN[N], const Unit x[N*M])
{
	for (size_t i = 0; i < M; i++) {
		set(yN, i, x+i*N);
	}
}

inline void cvt(Unit y[N*M], const Vec xN[N])
{
	for (size_t i = 0; i < M; i++) {
		get(y+i*N, xN, i);
	}
}

// expand x to Vec
inline void expand(Vec& v, Unit x)
{
	Unit *p = (Unit *)&v;
	for (size_t i = 0; i < M; i++) {
		p[i] = x;
	}
}

inline void expandN(Vec v[N], const mpz_class& x)
{
	Unit a[N];
	toArray<N>(a, x);
	for (size_t i = 0; i < N; i++) {
		expand(v[i], a[i]);
	}
}

// low(c+a*b)
inline Vec vmulL(const Vec& a, const Vec& b, const Vec& c = vzero())
{
	return _mm512_madd52lo_epu64(c, a, b);
}

// high(c+a*b)
inline Vec vmulH(const Vec& a, const Vec& b, const Vec& c = vzero())
{
	return _mm512_madd52hi_epu64(c, a, b);
}

inline Vec vadd(const Vec& a, const Vec& b)
{
	return _mm512_add_epi64(a, b);
}

inline Vec vsub(const Vec& a, const Vec& b)
{
	return _mm512_sub_epi64(a, b);
}

inline Vec vpsrlq(const Vec& a, size_t b)
{
	return _mm512_srli_epi64(a, int(b));
}

inline Vec vpsllq(const Vec& a, size_t b)
{
	return _mm512_slli_epi64(a, int(b));
}

inline Vec vand(const Vec& a, const Vec& b)
{
	return _mm512_and_epi64(a, b);
}

inline Vec vor(const Vec& a, const Vec& b)
{
	return _mm512_or_epi64(a, b);
}

inline Vec vxor(const Vec& a, const Vec& b)
{
	return _mm512_xor_epi64(a, b);
}

//template<int scale=8>
inline Vec vpgatherqq(const Vec& idx, const void *base)
{
#if 0
	const Unit *p = (const Unit *)&idx;
	const Unit *src = (const Unit *)base;
	Vec v;
	Unit *q = (Unit *)&v;
	for (size_t i = 0; i < M; i++) {
		q[i] = src[idx[i]];
	}
	return v;
#else
	const int scale = 8;
	return _mm512_i64gather_epi64(idx, base, scale);
#endif
}

inline void vpscatterqq(void *base, const Vec& idx, const Vec& v)
{
	const int scale = 8;
	_mm512_i64scatter_epi64(base, idx, v, scale);
}

// return [H:L][idx]
inline Vec vperm2tq(const Vec& L, const Vec& idx, const Vec& H)
{
	return _mm512_permutex2var_epi64(L, idx, H);
}

inline Vmask vcmpeq(const Vec& a, const Vec& b)
{
	return _mm512_cmpeq_epi64_mask(a, b);
}

inline Vmask vcmpneq(const Vec& a, const Vec& b)
{
	return _mm512_cmpneq_epi64_mask(a, b);
}

inline Vmask vcmpgt(const Vec& a, const Vec& b)
{
	return _mm512_cmpgt_epi64_mask(a, b);
}

inline Vmask mand(const Vmask& a, const Vmask& b)
{
	return _mm512_kand(a, b);
}

inline Vmask mor(const Vmask& a, const Vmask& b)
{
	return _mm512_kor(a, b);
}

inline Vec vpbroadcastq(int64_t a)
{
	return _mm512_set1_epi64(a);
}

// return c ? a&b : d;
inline Vec vand(const Vmask& c, const Vec& a, const Vec& b, const Vec& d)
{
	return _mm512_mask_and_epi64(d, c, a, b);
}

// return c ? a : b;
inline Vec vselect(const Vmask& c, const Vec& a, const Vec& b)
{
	return vand(c, a, a, b);
}

template<size_t n=N>
inline void vrawAdd(Vec *z, const Vec *x, const Vec *y)
{
	Vec t = vadd(x[0], y[0]);
	Vec c = vpsrlq(t, W);
	z[0] = vand(t, vmask);

	for (size_t i = 1; i < n; i++) {
		t = vadd(x[i], y[i]);
		t = vadd(t, c);
		if (i == n-1) {
			z[i] = t;
			return;
		}
		c = vpsrlq(t, W);
		z[i] = vand(t, vmask);
	}
}

template<size_t n=N>
inline Vmask vrawSub(Vec *z, const Vec *x, const Vec *y)
{
	Vec t = vsub(x[0], y[0]);
	Vec c = vpsrlq(t, S);
	z[0] = vand(t, vmask);
	for (size_t i = 1; i < n; i++) {
		t = vsub(x[i], y[i]);
		t = vsub(t, c);
		c = vpsrlq(t, S);
		z[i] = vand(t, vmask);
	}
	return vcmpneq(c, vzero());
}

inline void uvselect(Vec *z, const Vmask& c, const Vec *a, const Vec *b)
{
	for (size_t i = 0; i < N; i++) {
		z[i] = vselect(c, a[i], b[i]);
	}
}

inline void uvadd(Vec *z, const Vec *x, const Vec *y)
{
	Vec sN[N], tN[N];
	vrawAdd(sN, x, y);
	Vmask c = vrawSub(tN, sN, vpN);
	uvselect(z, c, sN, tN);
}

inline void uvsub(Vec *z, const Vec *x, const Vec *y)
{
	Vec sN[N], tN[N];
	Vmask c = vrawSub(sN, x, y);
	vrawAdd(tN, sN, vpN);
	tN[N-1] = vand(tN[N-1], vmask);
	uvselect(z, c, tN, sN);
}

inline void vrawMulUnitOrg(Vec *z, const Vec *x, const Vec& y)
{
	Vec L[N], H[N];
	for (size_t i = 0; i < N; i++) {
		L[i] = vmulL(x[i], y);
		H[i] = vmulH(x[i], y);
	}
	z[0] = L[0];
	for (size_t i = 1; i < N; i++) {
		z[i] = vadd(L[i], H[i-1]);
	}
	z[N] = H[N-1];
}

inline Vec vrawMulUnitAddOrg(Vec *z, const Vec *x, const Vec& y)
{
	Vec L[N], H[N];
	for (size_t i = 0; i < N; i++) {
		L[i] = vmulL(x[i], y);
		H[i] = vmulH(x[i], y);
	}
	z[0] = vadd(z[0], L[0]);
	for (size_t i = 1; i < N; i++) {
		z[i] = vadd(z[i], vadd(L[i], H[i-1]));
	}
	return H[N-1];
}

template<size_t n=N>
inline void vrawMulUnit(Vec *z, const Vec *x, const Vec& y)
{
	Vec H;
	z[0] = vmulL(x[0], y);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < n; i++) {
		z[i] = vmulL(x[i], y, H);
		H = vmulH(x[i], y);
	}
	z[n] = H;
}

template<size_t n=N>
inline Vec vrawMulUnitAdd(Vec *z, const Vec *x, const Vec& y)
{
	Vec H;
	z[0] = vmulL(x[0], y, z[0]);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < n; i++) {
		z[i] = vadd(vmulL(x[i], y, H), z[i]);
		H = vmulH(x[i], y);
	}
	return H;
}

template<size_t n=N>
inline void vrawMul(Vec z[n*2], const Vec x[n], const Vec y[n])
{
	vrawMulUnit<n>(z, x, y[0]);
	for (size_t i = 1; i < n; i++) {
		z[n+i] = vrawMulUnitAdd<n>(z+i, x, y[i]);
	}
}

template<size_t n=N>
inline void vrawSqr(Vec z[n*2], const Vec x[n])
{
	for (size_t i = 1; i < n; i++) {
		z[i*2-1] = vmulL(x[i], x[i-1]);
		z[i*2  ] = vmulH(x[i], x[i-1]);
	}
	for (size_t j = 2; j < n; j++) {
		for (size_t i = j; i < n; i++) {
//			z[i*2-j  ] = vadd(z[i*2-j  ], vmulL(x[i], x[i-j]));
//			z[i*2-j+1] = vadd(z[i*2-j+1], vmulH(x[i], x[i-j]));
			z[i*2-j  ] = vmulL(x[i], x[i-j], z[i*2-j  ]);
			z[i*2-j+1] = vmulH(x[i], x[i-j], z[i*2-j+1]);
		}
	}
	for (size_t i = 1; i < n*2-1; i++) {
		z[i] = vadd(z[i], z[i]);
	}
	z[0] = vmulL(x[0], x[0]);
	for (size_t i = 1; i < n; i++) {
//		z[i*2-1] = vadd(z[i*2-1], vmulH(x[i-1], x[i-1]));
//		z[i*2] = vadd(z[i*2], vmulL(x[i], x[i]));
		z[i*2-1] = vmulH(x[i-1], x[i-1], z[i*2-1]);
		z[i*2] = vmulL(x[i], x[i], z[i*2]);
	}
	z[n*2-1] = vmulH(x[n-1], x[n-1]);
}

// t[n] = c ? a[n] : zero
template<size_t n=N>
inline void vset(Vec *t, const Vmask& c, const Vec a[n])
{
	for (size_t i = 0; i < n; i++) {
		t[i] = vselect(c, a[i], vzero());
	}
}

inline void uvmont(Vec z[N], Vec xy[N*2])
{
	for (size_t i = 0; i < N; i++) {
		Vec q = vmulL(xy[i], vrp);
		xy[N+i] = vadd(xy[N+i], vrawMulUnitAdd(xy+i, vpN, q));
		xy[i+1] = vadd(xy[i+1], vpsrlq(xy[i], W));
	}
	for (size_t i = N; i < N*2-1; i++) {
		xy[i+1] = vadd(xy[i+1], vpsrlq(xy[i], W));
		xy[i] = vand(xy[i], vmask);
	}
	Vmask c = vrawSub(z, xy+N, vpN);
	uvselect(z, c, xy+N, z);
}

inline void uvmul(Vec *z, const Vec *x, const Vec *y)
{
#if 0
	Vec xy[N*2];
	vrawMul(xy, x, y);
	uvmont(z, xy);
#else
	Vec t[N*2], q;
	vrawMulUnit(t, x, y[0]);
	q = vmulL(t[0], vrp);
	t[N] = vadd(t[N], vrawMulUnitAdd(t, vpN, q));
	for (size_t i = 1; i < N; i++) {
		t[N+i] = vrawMulUnitAdd(t+i, x, y[i]);
		t[i] = vadd(t[i], vpsrlq(t[i-1], W));
		q = vmulL(t[i], vrp);
		t[N+i] = vadd(t[N+i], vrawMulUnitAdd(t+i, vpN, q));
	}
	for (size_t i = N; i < N*2; i++) {
		t[i] = vadd(t[i], vpsrlq(t[i-1], W));
		t[i-1] = vand(t[i-1], vmask);
	}
	Vmask c = vrawSub(z, t+N, vpN);
	uvselect(z, c, t+N, z);
#endif
}

// slower than uvmul
inline void uvsqr(Vec *z, const Vec *x)
{
	Vec xx[N*2];
	vrawSqr<N>(xx, x);
	uvmont(z, xx);
}

// out = c ? a : b
inline void select(Unit *out, bool c, const Unit *a, const Unit *b)
{
	const Unit *o = c ? a : b;
	for (size_t i = 0; i < N; i++) {
		out[i] = o[i];
	}
}

inline Vec getUnitAt(const Vec *x, size_t xN, size_t bitPos)
{
	const size_t bitSize = 64;
	const size_t q = bitPos / bitSize;
	const size_t r = bitPos % bitSize;
	if (r == 0) return x[q];
	if (q == xN - 1) return vpsrlq(x[q], r);
	return vor(vpsrlq(x[q], r), vpsllq(x[q+1], bitSize - r));
}

inline void split(Unit a[2], Unit b[2], const Unit x[4])
{
	/*
		z = -0xd201000000010000
		L = z^2-1 = 0xac45a4010001a40200000000ffffffff
		r = L^2+L+1 = 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001
		s=255
		v = 0xbe35f678f00fd56eb1fb72917b67f718
	*/
	static const uint64_t Lv[] = { 0x00000000ffffffff, 0xac45a4010001a402 };
	static const uint64_t vv[] = { 0xb1fb72917b67f718, 0xbe35f678f00fd56e };
	static const size_t n = 128 / mcl::UnitBitSize;
	Unit t[n*3];
	mcl::bint::mulNM(t, x, n*2, vv, n);
	mcl::bint::shrT<n+1>(t, t+n*2-1, mcl::UnitBitSize-1); // >>255
	b[0] = t[0];
	b[1] = t[1];
	mcl::bint::mulT<n>(t, t, Lv);
	mcl::bint::subT<n>(a, x, t);
}

class Montgomery {
	Unit v_[N];
public:
	mpz_class mp;
	mpz_class mR; // (1 << (N * 64)) % p
	mpz_class mR2; // (R * R) % p
	Unit rp; // rp * p = -1 mod M = 1 << 64
	const Unit *p;
	bool isFullBit;
	Montgomery() {}
	static Unit getLow(const mpz_class& x)
	{
		if (x == 0) return 0;
		return mcl::gmp::getUnit(x, 0) & g_mask;
	}
	void set(const mpz_class& _p)
	{
		mp = _p;
		mR = 1;
		mR = (mR << (W * N)) % mp;
		mR2 = (mR * mR) % mp;
		toArray<N>(v_, _p);
		rp = mcl::bint::getMontgomeryCoeff(v_[0], W);
		p = v_;
		isFullBit = p[N-1] >> (W-1);
	}

	mpz_class toMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, mR2);
		return y;
	}
	mpz_class fromMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, 1);
		return y;
	}

	void mul(mpz_class& z, const mpz_class& x, const mpz_class& y) const
	{
		mod(z, x * y);
	}
	void mod(mpz_class& z, const mpz_class& xy) const
	{
		z = xy;
		for (size_t i = 0; i < N; i++) {
			Unit q = (getLow(z) * rp) & g_mask;
			mpz_class t = q;
			z += mp * t;
			z >>= W;
		}
		if (z >= mp) {
			z -= mp;
		}
	}
};

Montgomery g_mont;

/*
	 |64   |64   |64   |64   |64    |64   |
	x|52:12|40:24|28:36|16:48|4:52:8|44:20|
    y|52|52   |52   |52   |52  |52|52  |20|
*/
inline void split52bit(Vec y[8], const Vec x[6])
{
	assert(&y != &x);
	y[0] = vand(x[0], vmask);
	y[1] = vand(vor(vpsrlq(x[0], 52), vpsllq(x[1], 12)), vmask);
	y[2] = vand(vor(vpsrlq(x[1], 40), vpsllq(x[2], 24)), vmask);
	y[3] = vand(vor(vpsrlq(x[2], 28), vpsllq(x[3], 36)), vmask);
	y[4] = vand(vor(vpsrlq(x[3], 16), vpsllq(x[4], 48)), vmask);
	y[5] = vand(vpsrlq(x[4], 4), vmask);
	y[6] = vand(vor(vpsrlq(x[4], 56), vpsllq(x[5], 8)), vmask);
	y[7] = vpsrlq(x[5], 44);
}

/*
	 |52|52   |52   |52   |52  |52|52  |20|
	x|52|12:40|24:28|36:16|48:4|52|8:44|20|
    y|64   |64   |64   |64   |64    |64
*/
inline void concat52bit(Vec y[6], const Vec x[8])
{
	assert(&y != &x);
	y[0] = vor(x[0], vpsllq(x[1], 52));
	y[1] = vor(vpsrlq(x[1], 12), vpsllq(x[2], 40));
	y[2] = vor(vpsrlq(x[2], 24), vpsllq(x[3], 28));
	y[3] = vor(vpsrlq(x[3], 36), vpsllq(x[4], 16));
	y[4] = vor(vor(vpsrlq(x[4], 48), vpsllq(x[5], 4)), vpsllq(x[6], 56));
	y[5] = vor(vpsrlq(x[6], 8), vpsllq(x[7], 44));
}

/*
	384bit = 6U (U=64)
	G1(=6U x 3(x, y, z)) x 8 => 8Ux8x3
*/
static CYBOZU_ALIGN(64) uint64_t g_pickUpEc[8] = {
	18*0, 18*1, 18*2, 18*3, 18*4, 18*5, 18*6, 18*7,
};
static const Vec& v_pickUpEc = *(const Vec*)g_pickUpEc;
inline void cvt6Ux3x8to8Ux8x3(Vec y[8*3], const Unit x[6*3*8])
{
	for (int j = 0; j < 3; j++) {
		Vec t[6];
		for (int i = 0; i < 6; i++) {
			t[i] = vpgatherqq(v_pickUpEc, x+j*6+i);
		}
		split52bit(&y[j*8], t);
	}
}

// EcM(=8Ux8x3) => G1(=6U x 3) x 8
inline void cvt8Ux8x3to6Ux3x8(Unit y[6*3*8], const Vec x[8*3])
{
	for (size_t j = 0; j < 3; j++) {
		Vec t[6];
		concat52bit(t, x+8*j);
		for (size_t i = 0; i < 6; i++) {
#if 1
			vpscatterqq(y+j*6+i, v_pickUpEc, t[i]);
#else
			const Unit *pt = (const Unit *)t;
			for (size_t k = 0; k < 8; k++) {
				y[j*6+k*18+i] = pt[k+i*8];
			}
#endif
		}
	}
}

// Fr x 8 = U4x8 => Vec(U8) x 4
inline void cvt4Ux8to8Ux4(Vec y[4], const Unit x[4*8])
{
	const size_t w = 4;
	for (size_t j = 0; j < M; j++) {
		for (size_t i = 0; i < w; i++) {
			((Unit *)y)[i*M+j] = x[j*w+i];
		}
	}
}

static const CYBOZU_ALIGN(64) uint64_t g_pickUpFp[8] = {
	6*0, 6*1, 6*2, 6*3, 6*4, 6*5, 6*6, 6*7,
};
static const Vec& v_pickUpFp = *(const Vec*)g_pickUpFp;
// FpM(8Ux8) => Fp(=6U) x 8
inline void cvt8Ux8to6Ux8(Unit y[6*8], const Vec x[8])
{
	Vec t[6];
	concat52bit(t, x);
	for (size_t i = 0; i < 6; i++) {
		vpscatterqq(y+i, v_pickUpFp, t[i]);
	}
}
// Fp(=6U)x8 => FpM(8Ux8)
inline void cvt6Ux8to8Ux8(Vec y[8], const Unit x[6*8])
{
	Vec t[6];
	for (int i = 0; i < 6; i++) {
		t[i] = vpgatherqq(v_pickUpFp, x+i);
	}
	split52bit(y, t);
}

struct FpM {
	Vec v[N];
	static FpM one_;
	static FpM rawOne_;
	static FpM rw_;
	static FpM mR2_;
	static FpM m64to52_;
	static FpM m52to64_;
	static void add(FpM& z, const FpM& x, const FpM& y)
	{
		uvadd(z.v, x.v, y.v);
	}
	static void mul2(FpM& z, const FpM& x)
	{
		add(z, x, x);
	}
	static void sub(FpM& z, const FpM& x, const FpM& y)
	{
		uvsub(z.v, x.v, y.v);
	}
	static void mul(FpM& z, const FpM& x, const FpM& y)
	{
		uvmul(z.v, x.v, y.v);
	}
	static void sqr(FpM& z, const FpM& x)
	{
//		uvsqr(z.v, x.v); // slow
		mul(z, x, x);
	}
	void set(const mpz_class& x, size_t i)
	{
		mpz_class r = g_mont.toMont(x);
		Unit rv[N];
		toArray<N>(rv, r);
		::set(v, i, rv);
	}
	void set(const mpz_class& x)
	{
		mpz_class r = g_mont.toMont(x);
		Unit rv[N];
		toArray<N>(rv, r);
		for (size_t i = 0; i < M; i++) {
			::set(v, i, rv);
		}
	}
	void toMont(FpM& x) const
	{
		mul(x, *this, mR2_);
	}
	void fromMont(const FpM &x)
	{
		mul(*this, x, rawOne_);
	}
	mpz_class getRaw(size_t i) const
	{
		Unit x[N];
		::get(x, v, i);
		return fromArray<N>(x);
	}
	mpz_class get(size_t i) const
	{
		mpz_class r = getRaw(i);
		return g_mont.fromMont(r);
	}
	bool operator==(const FpM& rhs) const
	{
		for (size_t i = 0; i < N; i++) {
			if (memcmp(&v[i], &rhs.v[i], sizeof(Vec)) != 0) return false;
		}
		return true;
	}
	bool operator!=(const FpM& rhs) const { return !operator==(rhs); }
	Vmask isEqualAll(const FpM& rhs) const
	{
		Vec t = vxor(v[0], rhs.v[0]);
		for (size_t i = 1; i < M; i++) {
			t = vor(t, vxor(v[i], rhs.v[i]));
		}
		return vcmpeq(t, vzero());
	}
	static void pow(FpM& z, const FpM& x, const Vec *y, size_t yn)
	{
		const int w = 4;
		assert(w == 4);
		const int tblN = 1<<w;
		FpM tbl[tblN];
		tbl[0] = one_;
		tbl[1] = x;
		for (size_t i = 2; i < tblN; i++) {
			mul(tbl[i], tbl[i-1], x);
		}
		const size_t bitLen = sizeof(Unit)*8;
		const size_t jn = bitLen / w;
		z = tbl[0];
		for (size_t i = 0; i < yn; i++) {
			const Vec& v = y[yn-1-i];
			for (size_t j = 0; j < jn; j++) {
				for (int k = 0; k < w; k++) FpM::sqr(z, z);
				Vec idx = vand(vpsrlq(v, bitLen-w-j*w), g_vmask4);
				idx = vpsllq(idx, 6); // 512 B = 64 Unit
				idx = vadd(idx, g_offset);
				FpM t;
				for (size_t k = 0; k < N; k++) {
					t.v[k] = vpgatherqq(idx, &tbl[0].v[k]);
				}
				mul(z, z, t);
			}
		}
	}
	void setFp(const Unit *v)
	{
		Unit v8[6*8];
		for (size_t i = 0; i < 8; i++) {
			mcl::bint::copyT<6>(v8+i*6, v);
		}
		cvt6Ux8to8Ux8(this->v, v8);
		FpM::mul(*this, *this, FpM::m64to52_);
	}
	void setFp(const mcl::msm::FpA v[M])
	{
		cvt6Ux8to8Ux8(this->v, v[0].v);
		FpM::mul(*this, *this, FpM::m64to52_);
	}
	void getFp(mcl::msm::FpA v[M]) const
	{
		FpM t;
		FpM::mul(t, *this, FpM::m52to64_);
		cvt8Ux8to6Ux8((Unit*)v, t.v);
	}
	static void inv(FpM& z, const FpM& x)
	{
#if 1
		mcl::msm::FpA v[M];
		x.getFp(v);
		g_param.invVecFp(v, v, M, M);
		z.setFp(v);
#else
		pow(z, x, g_vmpM2, 6);
#endif
	}
	// condition set (set x if c)
	void cset(const Vmask& c, const FpM& x)
	{
		for (size_t i = 0; i < N; i++) {
			v[i] = vselect(c, x.v[i], v[i]);
		}
	}
};

FpM FpM::one_;
FpM FpM::rawOne_;
FpM FpM::rw_;
FpM FpM::mR2_;
FpM FpM::m64to52_;
FpM FpM::m52to64_;

template<class E>
inline Vmask isZero(const E& P)
{
	Vec v = P.z.v[0];
	for (size_t i = 1; i < N; i++) {
		v = vor(v, P.z.v[i]);
	}
	return vcmpeq(v, vzero());
}

template<class E, size_t n>
inline void normalizeJacobiVec(E P[n])
{
	assert(n >= 2);
	typedef typename E::Fp F;
	F tbl[n];
	tbl[0] = P[0].z;
	for (size_t i = 1; i < n; i++) {
		F::mul(tbl[i], tbl[i-1], P[i].z);
	}
	F r;
	F::inv(r, tbl[n-1]);
	for (size_t i = 0; i < n; i++) {
		size_t pos = n-1-i;
		F t = P[pos].z;
		F rz, rz2;
		if (pos > 0) {
			F::mul(rz, r, tbl[pos-1]);
			F::mul(r, r, t);
		} else {
			rz = r;
		}
		F::sqr(rz2, rz);
		F::mul(P[pos].x, P[pos].x, rz2); // xz^-2
		F::mul(rz2, rz2, rz);
		F::mul(P[pos].y, P[pos].y, rz2); // yz^-3
		P[pos].z = F::one_;
	}
}

// 8M+3S+7A
// assume P.x != Q.x, P != Q
// asseume all Q are normalized
template<class E>
inline void addJacobiMixedNoCheck(E& R, const E& P, const E& Q)
{
	typedef typename E::Fp F;
	Vmask c = isZero(Q);
	E saveP = P;
	F r, U1, S1, H, H3;
	F::sqr(r, P.z);
	U1 = P.x;
	F::mul(H, Q.x, r);
	F::sub(H, H, U1);
	S1 = P.y;
	F::mul(r, r, P.z);
	F::mul(r, r, Q.y);
	F::sub(r, r, S1);
	F::mul(R.z, P.z, H);
	F::sqr(H3, H); // H^2
	F::sqr(R.y, r); // r^2
	F::mul(U1, U1, H3); // U1 H^2
	F::mul(H3, H3, H); // H^3
	F::sub(R.y, R.y, U1);
	F::sub(R.y, R.y, U1);
	F::sub(R.x, R.y, H3);
	F::sub(U1, U1, R.x);
	F::mul(U1, U1, r);
	F::mul(H3, H3, S1);
	F::sub(R.y, U1, H3);
	R.cset(c, saveP);
}

// 12M+4S+7A
// assume P.x != Q.x, P != Q
template<class E>
inline void addJacobiNoCheck(E& R, const E& P, const E& Q)
{
	typedef typename E::Fp F;
	Vmask c = isZero(Q);
	E saveP = P;
	F r, U1, S1, H, H3;
	F::sqr(r, P.z);
	F::sqr(S1, Q.z);
	F::mul(U1, P.x, S1);
	F::mul(H, Q.x, r);
	F::sub(H, H, U1);
	F::mul(S1, S1, Q.z);
	F::mul(S1, S1, P.y);
	F::mul(r, r, P.z);
	F::mul(r, r, Q.y);
	F::sub(r, r, S1);
	F::mul(R.z, P.z, Q.z);
	F::mul(R.z, R.z, H);
	F::sqr(H3, H); // H^2
	F::sqr(R.y, r); // r^2
	F::mul(U1, U1, H3); // U1 H^2
	F::mul(H3, H3, H); // H^3
	F::sub(R.y, R.y, U1);
	F::sub(R.y, R.y, U1);
	F::sub(R.x, R.y, H3);
	F::sub(U1, U1, R.x);
	F::mul(U1, U1, r);
	F::mul(H3, H3, S1);
	F::sub(R.y, U1, H3);
	R.cset(c, saveP);
}

// assume a = 0
// 3M+4S+12A
template<class E>
inline void dblJacobiNoCheck(E& R, const E& P)
{
	typedef typename E::Fp F;
	F x2, y2, xy, t;
	F::sqr(x2, P.x);
	F::sqr(y2, P.y);
	F::mul(xy, P.x, y2);
	F::mul2(xy, xy);
	F::sqr(y2, y2);
	F::mul2(xy, xy); // 4xy^2
	F::mul2(t, x2);
	F::add(x2, x2, t);
	F::sqr(R.x, x2);
	F::sub(R.x, R.x, xy);
	F::sub(R.x, R.x, xy);
	F::mul(R.z, P.y, P.z);
	F::mul2(R.z, R.z);
	F::sub(R.y, xy, R.x);
	F::mul(R.y, R.y, x2);
	F::mul2(y2, y2);
	F::mul2(y2, y2);
	F::mul2(y2, y2);
	F::sub(R.y, R.y, y2);
}

struct EcM {
	typedef FpM Fp;
	static const int a_ = 0;
	static const int b_ = 4;
	static const int specialB_ = mcl::ec::local::Plus4;
	static const int w = 4;
	static const int tblN = 1<<w;
	static const size_t bitLen = sizeof(Unit)*8;
	static FpM b3_;
	static EcM zeroProj_;
	static EcM zeroJacobi_;
	FpM x, y, z;
	template<bool isProj=true, bool mixed=false>
	static void add(EcM& z, const EcM& x, const EcM& y)
	{
		if (isProj) {
			mcl::ec::addCTProj(z, x, y);
		} else {
			if (mixed) {
				addJacobiMixedNoCheck(z, x, y);
			} else {
				addJacobiNoCheck(z, x, y);
			}
		}
	}
	template<bool isProj=true>
	static void dbl(EcM& z, const EcM& x)
	{
		if (isProj) {
			mcl::ec::dblCTProj(z, x);
		} else {
			dblJacobiNoCheck(z, x);
		}
	}
	static void init(Montgomery& mont)
	{
		const int b = 4;
		mpz_class b3 = mont.toMont(b * 3);
		expandN(b3_.v, b3);
		zeroJacobi_.x.set(1);
		zeroJacobi_.y.set(1);
		zeroJacobi_.z.set(0);
		zeroProj_.x.set(0);
		zeroProj_.y.set(1);
		zeroProj_.z.set(0);
	}
	template<bool isProj=true>
	static const EcM& zero()
	{
		return isProj ? zeroProj_ : zeroJacobi_;
	}
	template<bool isProj=true>
	void clear()
	{
		*this = zero<isProj>();
	}
	void setArray(const Unit a[6*3*M])
	{
		cvt6Ux3x8to8Ux8x3(x.v, a);
	}
	void getArray(Unit a[6*3*M]) const
	{
		cvt8Ux8x3to6Ux3x8(a, x.v);
	}
	void setG1(const mcl::msm::G1A v[M], bool JacobiToProj = true)
	{
#if 1
		setArray(v[0].v);
		FpM::mul(x, x, FpM::m64to52_);
		FpM::mul(y, y, FpM::m64to52_);
		FpM::mul(z, z, FpM::m64to52_);
#else
		Unit a[6*3*M];
		const Unit *src = (const Unit *)v;
		for (size_t i = 0; i < M*3; i++) {
			mcl::bn::Fp::getOp().fromMont(a+i*6, src+i*6);
		}
		setArray(a);
		x.toMont(x);
		y.toMont(y);
		z.toMont(z);
#endif
		if (JacobiToProj) mcl::ec::JacobiToProj(*this, *this);
	}
	void getG1(mcl::msm::G1A v[M], bool ProjToJacobi = true) const
	{
		EcM T = *this;
		if (ProjToJacobi) mcl::ec::ProjToJacobi(T, T);
#if 1
		FpM::mul(T.x, T.x, FpM::m52to64_);
		FpM::mul(T.y, T.y, FpM::m52to64_);
		FpM::mul(T.z, T.z, FpM::m52to64_);
		T.getArray(v[0].v);
#else
		T.x.fromMont(T.x);
		T.y.fromMont(T.y);
		T.z.fromMont(T.z);
		Unit a[6*3*M];
		T.getArray(a);
		Unit *dst = (Unit *)v;
		for (size_t i = 0; i < M*3; i++) {
			mcl::bn::Fp::getOp().toMont(dst+i*6, a+i*6);
		}
#endif
	}
	void normalize()
	{
		FpM r;
		FpM::inv(r, z);
		FpM::mul(x, x, r);
		FpM::mul(y, y, r);
		z = FpM::one_;
	}
	template<bool isProj=true, bool mixed=false>
	static void makeTable(EcM *tbl, const EcM& P)
	{
		tbl[0].clear();
		tbl[1] = P;
		dbl<isProj>(tbl[2], P);
		for (size_t i = 3; i < tblN; i++) {
			add<isProj, mixed>(tbl[i], tbl[i-1], P);
		}
	}
	void gather(const EcM *tbl, Vec idx)
	{
		idx = vmulL(idx, g_vi192, g_offset);
		for (size_t i = 0; i < N; i++) {
			x.v[i] = vpgatherqq(idx, &tbl[0].x.v[i]);
			y.v[i] = vpgatherqq(idx, &tbl[0].y.v[i]);
			z.v[i] = vpgatherqq(idx, &tbl[0].z.v[i]);
		}
	}
	void scatter(EcM *tbl, Vec idx) const
	{
		idx = vmulL(idx, g_vi192, g_offset);
		for (size_t i = 0; i < N; i++) {
			vpscatterqq(&tbl[0].x.v[i], idx, x.v[i]);
			vpscatterqq(&tbl[0].y.v[i], idx, y.v[i]);
			vpscatterqq(&tbl[0].z.v[i], idx, z.v[i]);
		}
	}

	static void mul(EcM& Q, const EcM& P, const Vec *y, size_t yn)
	{
		EcM tbl[tblN];
		makeTable(tbl, P);
		const size_t jn = bitLen / w;
		Q = tbl[0];
		for (size_t i = 0; i < yn; i++) {
			const Vec& v = y[yn-1-i];
			for (size_t j = 0; j < jn; j++) {
				for (int k = 0; k < w; k++) EcM::dbl(Q, Q);
				Vec idx = vand(vpsrlq(v, bitLen-w-j*w), g_vmask4);
				EcM T;
				T.gather(tbl, idx);
				add(Q, Q, T);
			}
		}
	}
	static void mulLambda(EcM& Q, const EcM& P)
	{
		FpM::mul(Q.x, P.x, FpM::rw_);
		Q.y = P.y;
		Q.z = P.z;
	}
	template<bool isProj=true, bool mixed=false>
	static void mulGLV(EcM& Q, const EcM& _P, const Vec y[4])
	{
		EcM P = _P;
		if (!isProj) mcl::ec::ProjToJacobi(P, _P);
		Vec a[2], b[2];
		EcM tbl1[tblN], tbl2[tblN];
		makeTable<isProj, mixed>(tbl1, P);
		if (!isProj) normalizeJacobiVec<EcM, tblN-1>(tbl1+1);
		for (size_t i = 0; i < tblN; i++) {
			mulLambda(tbl2[i], tbl1[i]);
		}
		const Unit *src = (const Unit*)y;
		Unit *pa = (Unit*)a;
		Unit *pb = (Unit*)b;
		for (size_t i = 0; i < M; i++) {
			Unit buf[4] = { src[i+M*0], src[i+M*1], src[i+M*2], src[i+M*3] };
			Unit aa[2], bb[2];
			split(aa, bb, buf);
			pa[i+M*0] = aa[0]; pa[i+M*1] = aa[1];
			pb[i+M*0] = bb[0]; pb[i+M*1] = bb[1];
		}
#if 1
		const size_t jn = bitLen / w;
		const size_t yn = 2;
		bool first = true;
		for (size_t i = 0; i < yn; i++) {
			const Vec& v1 = a[yn-1-i];
			const Vec& v2 = b[yn-1-i];
			for (size_t j = 0; j < jn; j++) {
				if (!first) for (int k = 0; k < w; k++) EcM::dbl<isProj>(Q, Q);
				EcM T;
				Vec idx;
				idx = vand(vpsrlq(v1, bitLen-w-j*w), g_vmask4);
				if (first) {
					Q.gather(tbl1, idx);
					first = false;
				} else {
					T.gather(tbl1, idx);
					add<isProj, mixed>(Q, Q, T);
				}
				idx = vand(vpsrlq(v2, bitLen-w-j*w), g_vmask4);
				T.gather(tbl2, idx);
				add<isProj, mixed>(Q, Q, T);
			}
		}
#else
		mul(Q, P, a, 2);
		mul(T, T, b, 2);
		add(Q, Q, T);
#endif
		if (!isProj) mcl::ec::JacobiToProj(Q, Q);
	}
	static void mulGLVbn(mcl::msm::G1A _Q[8], mcl::msm::G1A _P[8], const Vec y[4])
	{
		const bool isProj = false;
		const bool mixed = true;
//		mcl::ec::normalizeVec(_P, _P, 8);
		g_param.normalizeVecG1(_P, _P, 8);
		EcM P, Q;
		P.setG1(_P, isProj);
		mulGLV<isProj, mixed>(Q, P, y);
		Q.getG1(_Q);
	}
	void cset(const Vmask& c, const EcM& v)
	{
		x.cset(c, v.x);
		y.cset(c, v.y);
		z.cset(c, v.z);
	}
	Vmask isEqualAll(const EcM& rhs) const
	{
		FpM s1, s2, t1, t2;
		Vmask v1, v2;
		FpM::sqr(s1, z);
		FpM::sqr(s2, rhs.z);
		FpM::mul(t1, x, s2);
		FpM::mul(t2, rhs.x, s1);
		v1 = t2.isEqualAll(s1);
		FpM::mul(t1, y, s2);
		FpM::mul(t2, rhs.y, s1);
		FpM::mul(t1, t1, rhs.z);
		FpM::mul(t2, t2, z);
		v2 = t1.isEqualAll(t2);
		return mand(v1, v2);
	}
};

FpM EcM::b3_;
EcM EcM::zeroProj_;
EcM EcM::zeroJacobi_;

inline void reduceSum(mcl::msm::G1A& Q, const EcM& P)
{

	mcl::msm::G1A z[8];
	P.getG1(z);
	Q = z[0];
	for (int i = 1; i < 8; i++) {
		g_param.addG1(Q, Q, z[i]);
	}
}

inline void cvtFr8toVec4(Vec yv[4], const mcl::msm::FrA y[8])
{
	Unit ya[4*8];
	for (size_t i = 0; i < 8; i++) {
		g_param.fr->fromMont(ya+i*4, y[i].v);
	}
	cvt4Ux8to8Ux4(yv, ya);
}

template<bool isProj=true>
inline void mulVecAVX512_naive(mcl::msm::G1A& P, const mcl::msm::G1A *x, const mcl::msm::FrA *y, size_t n)
{
	assert(n % 8 == 0);
	EcM R;
	for (size_t i = 0; i < n; i += 8) {
		Vec yv[4];
		cvtFr8toVec4(yv, y+i);
		EcM T, X;
		X.setG1(x+i, isProj);
		if (i == 0) {
			EcM::mulGLV<isProj>(R, X, yv);
		} else {
			EcM::mulGLV<isProj>(T, X, yv);
			EcM::add<isProj>(R, R, T);
		}
	}
	if (!isProj) mcl::ec::JacobiToProj(R, R);
	reduceSum(P, R);
}

// xVec[n], yVec[n * maxBitSize/64]
// assume xVec[] is normalized
inline void mulVecAVX512_inner(mcl::msm::G1A& P, const EcM *xVec, const Vec *yVec, size_t n, size_t maxBitSize)
{
	size_t c = mcl::ec::argminForMulVec(n);
	size_t tblN = size_t(1) << c;
	EcM *tbl = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * tblN, 64);
	const size_t yn = maxBitSize / 64;
	const size_t winN = (maxBitSize + c-1) / c;
	EcM *win = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * winN, 64);

	const Vec m = vpbroadcastq(tblN-1);
	for (size_t w = 0; w < winN; w++) {
		for (size_t i = 0; i < tblN; i++) {
			tbl[i].clear();
		}
		for (size_t i = 0; i < n; i++) {
			Vec v = getUnitAt(yVec+i*yn, yn, c*w);
			v = vand(v, m);
			EcM T;
			T.gather(tbl, v);
			EcM::add(T, T, xVec[i]);
			T.scatter(tbl, v);
		}
		EcM sum = tbl[tblN - 1];
		win[w] = sum;
		for (size_t i = 1; i < tblN - 1; i++) {
			EcM::add(sum, sum, tbl[tblN - 1- i]);
			EcM::add(win[w], win[w], sum);
		}
	}
	EcM T = win[winN - 1];
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < c; i++) {
			EcM::dbl(T, T);
		}
		EcM::add(T, T, win[winN - 1- w]);
	}
	reduceSum(P, T);
	Xbyak::AlignedFree(win);
	Xbyak::AlignedFree(tbl);
}

#if 0
void mulVec_naive(mcl::msm::G1A& P, const mcl::msm::G1A *x, const mcl::msm::FrA *y, size_t n)
{
	size_t c = mcl::ec::argminForMulVec(n);
	size_t tblN = (1 << c) - 0;
	mcl::msm::G1A *tbl = (mcl::msm::G1A*)CYBOZU_ALLOCA(sizeof(mcl::msm::G1A) * tblN);
	const size_t maxBitSize = 256;
	const size_t winN = (maxBitSize + c-1) / c;
	mcl::msm::G1A *win = (mcl::msm::G1A*)CYBOZU_ALLOCA(sizeof(mcl::msm::G1A) * winN);

	Unit *yVec = (Unit*)CYBOZU_ALLOCA(sizeof(mcl::msm::FrA) * n);
	const mcl::msm::addG1Func addG1 = g_param.addG1;
	const mcl::msm::dblG1Func dblG1 = g_param.dblG1;
	const mcl::msm::clearG1Func clearG1 = g_param.clearG1;
	for (size_t i = 0; i < n; i++) {
		g_param.fr->fromMont(yVec+i*4, y[i].v);
	}
	for (size_t w = 0; w < winN; w++) {
		for (size_t i = 0; i < tblN; i++) {
			clearG1(tbl[i]);
		}
		for (size_t i = 0; i < n; i++) {
			Unit v = mcl::fp::getUnitAt(yVec+i*4, 4, c * w) & (tblN-1);
			addG1(tbl[v], tbl[v], x[i]);
		}
		mcl::msm::G1A sum = tbl[tblN-1];
		win[w] = sum;
		for (size_t i = 1; i < tblN-1; i++) {
			addG1(sum, sum, tbl[tblN - 1 - i]);
			addG1(win[w], win[w], sum);
		}
	}
	P = win[winN - 1];
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < c; i++) {
			dblG1(P, P);
		}
		addG1(P, P, win[winN - 1 - w]);
	}
}
#endif

namespace mcl { namespace msm {

void mulVecAVX512(Unit *_P, Unit *_x, const Unit *_y, size_t n)
{
	G1A& P = *(G1A*)_P;
	mcl::msm::G1A *x = (mcl::msm::G1A*)_x;
	const mcl::msm::FrA *y = (const mcl::msm::FrA*)_y;
	const size_t n8 = n/8;
	const mcl::fp::Op *fr = g_param.fr;
#if 1
//	mcl::ec::normalizeVec(x, x, n);
	EcM *xVec = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * n8 * 2, 64);
	for (size_t i = 0; i < n8; i++) {
		xVec[i*2].setG1(x+i*8);
		EcM::mulLambda(xVec[i*2+1], xVec[i*2]);
	}
	Vec *yVec = (Vec*)Xbyak::AlignedMalloc(sizeof(Vec) * n8 * 4, 64);
	Unit *py = (Unit*)yVec;
	for (size_t i = 0; i < n8; i++) {
		for (size_t j = 0; j < 8; j++) {
			Unit ya[4];
			fr->fromMont(ya, y[i*8+j].v);
			Unit a[2], b[2];
			split(a, b, ya);
			py[j+0] = a[0];
			py[j+8] = a[1];
			py[j+16] = b[0];
			py[j+24] = b[1];
		}
		py += 32;
	}
	mulVecAVX512_inner(P, xVec, yVec, n8*2, 128);
#else
	EcM *xVec = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * n8, 64);
	for (size_t i = 0; i < n8; i++) {
		xVec[i].setG1(x+i*8);
	}
	Vec *yVec = (Vec*)Xbyak::AlignedMalloc(sizeof(Vec) * n8 * 4, 64);
	for (size_t i = 0; i < n8; i++) {
		cvtFr8toVec4(yVec+i*4, y+i*8);
	}
	mulVecAVX512_inner(P, xVec, yVec, n8, 256);
#endif
	Xbyak::AlignedFree(yVec);
	Xbyak::AlignedFree(xVec);
	const bool constTime = false;
	for (size_t i = n8*8; i < n; i++) {
		mcl::msm::G1A Q;
		g_param.mulG1(Q, x[i], y[i], constTime);
		g_param.addG1(P, P, Q);
	}
}

bool initMsm(const mcl::CurveParam& cp, const mcl::msm::Param *param)
{
	if (cp != mcl::BLS12_381) return false;
	Xbyak::util::Cpu cpu;
	if (!cpu.has(Xbyak::util::Cpu::tAVX512_IFMA)) return false;
	g_param = *param;

	Montgomery& mont = g_mont;
	const mpz_class& mp = g_param.fp->mp;

	mont.set(mp);
	toArray<6, 64>(g_mpM2, mp-2);
	expand(vmask, g_mask);
	expandN(vpN, mp);
	expand(vrp, mont.rp);
	for (int i = 0; i < 6; i++) {
		expand(g_vmpM2[i], g_mpM2[i]);
	}
	expand(g_vmask4, getMask(4));
	for (int i = 0; i < 8; i++) {
		((Unit*)&g_offset)[i] = i;
	}
	expand(g_vi192, 192);
	expandN(FpM::one_.v, g_mont.toMont(1));
	expandN(FpM::rawOne_.v, mpz_class(1));
	expandN(FpM::mR2_.v, g_mont.mR2);
	{
		mpz_class t(1);
		t <<= 32;
		FpM::m64to52_.set(t);
		FpM::pow(FpM::m52to64_, FpM::m64to52_, g_vmpM2, 6);
	}
	FpM::rw_.setFp(g_param.rw);
	EcM::init(mont);
	return true;
}

} } // mcl::msm

