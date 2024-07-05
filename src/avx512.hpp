#pragma once

#ifdef _WIN32
#include <intrin.h>
#else
#include <x86intrin.h>
#endif

#if defined(__GNUC__)
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wunused-function"
#endif

typedef __m512i Vec;
typedef __mmask8 Vmask;
static const size_t vN = 2;
struct VecA {
	Vec v[vN];
};

struct VmaskA {
	Vmask v[vN];
};

inline Vec vzero()
{
	return _mm512_setzero_epi32();
}

inline Vec vone()
{
	return _mm512_set1_epi32(1);
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

inline Vec vpaddq(const Vec& a, const Vec& b)
{
	return _mm512_add_epi64(a, b);
}

inline Vec vpaddq(const Vmask& v, const Vec& a, const Vec& b)
{
	return _mm512_mask_add_epi64(a, v, a, b);
}

inline Vec vpsubq(const Vec& a, const Vec& b)
{
	return _mm512_sub_epi64(a, b);
}

inline Vec vpsubq(const Vmask& v, const Vec& a, const Vec& b)
{
	return _mm512_mask_sub_epi64(a, v, a, b);
}

inline Vec vpsrlq(const Vec& a, size_t b)
{
	return _mm512_srli_epi64(a, int(b));
}

inline Vec vpsllq(const Vec& a, size_t b)
{
	return _mm512_slli_epi64(a, int(b));
}

inline Vec vpandq(const Vec& a, const Vec& b)
{
	return _mm512_and_epi64(a, b);
}

inline Vec vporq(const Vec& a, const Vec& b)
{
	return _mm512_or_epi64(a, b);
}

inline Vec vpxorq(const Vec& a, const Vec& b)
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

inline Vmask vpcmpeqq(const Vec& a, const Vec& b)
{
	return _mm512_cmpeq_epi64_mask(a, b);
}

inline Vmask vpcmpneqq(const Vec& a, const Vec& b)
{
	return _mm512_cmpneq_epi64_mask(a, b);
}

inline Vmask vpcmpgtq(const Vec& a, const Vec& b)
{
	return _mm512_cmpgt_epi64_mask(a, b);
}

inline Vmask kandb(const Vmask& a, const Vmask& b)
{
	return (Vmask)_mm512_kand(a, b);
}

inline Vec vpbroadcastq(int64_t a)
{
	return _mm512_set1_epi64(a);
}

// return c ? a&b : d;
inline Vec vpandq(const Vmask& c, const Vec& a, const Vec& b, const Vec& d)
{
	return _mm512_mask_and_epi64(d, c, a, b);
}

// return c ? a : b;
inline Vec vselect(const Vmask& c, const Vec& a, const Vec& b)
{
	return vpandq(c, a, a, b);
}

/////

inline VecA vmulL(const VecA& a, const VecA& b, const VecA& c)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vmulL(a.v[i], b.v[i], c.v[i]);
	return r;
}

inline VecA vmulH(const VecA& a, const VecA& b, const VecA& c)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vmulH(a.v[i], b.v[i], c.v[i]);
	return r;
}

inline VecA vpaddq(const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpaddq(a.v[i], b.v[i]);
	return r;
}

inline VecA vpaddq(const VmaskA& v, const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpaddq(v.v[i], a.v[i], b.v[i]);
	return r;
}

inline VecA vpsubq(const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpsubq(a.v[i], b.v[i]);
	return r;
}

inline VecA vpsubq(const VmaskA& v, const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpsubq(v.v[i], a.v[i], b.v[i]);
	return r;
}

inline VecA vpsrlq(const VecA& a, size_t b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpsrlq(a.v[i], b);
	return r;
}

inline VecA vpsllq(const VecA& a, size_t b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpsllq(a.v[i], b);
	return r;
}

inline VecA vpandq(const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpandq(a.v[i], b.v[i]);
	return r;
}

inline VecA vpandq(const VecA& a, const Vec& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpandq(a.v[i], b);
	return r;
}

inline VecA vporq(const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vporq(a.v[i], b.v[i]);
	return r;
}

inline VecA vpxorq(const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpxorq(a.v[i], b.v[i]);
	return r;
}

//template<int scale=8>
inline VecA vpgatherqq(const VecA& idx, const void *base[])
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpgatherqq(idx.v[i], base[i]);
	return r;
}

inline void vpscatterqq(void *base[], const VecA& idx, const VecA& v)
{
	for (size_t i = 0; i < vN; i++) vpscatterqq(base[i], idx.v[i], v.v[i]);
}

// return [H:L][idx]
inline VecA vperm2tq(const VecA& L, const VecA& idx, const VecA& H)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vperm2tq(L.v[i], idx.v[i], H.v[i]);
	return r;
}

inline VmaskA vpcmpeqq(const VecA& a, const VecA& b)
{
	VmaskA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpcmpeqq(a.v[i], b.v[i]);
	return r;
}

inline VmaskA vpcmpneqq(const VecA& a, const VecA& b)
{
	VmaskA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpcmpneqq(a.v[i], b.v[i]);
	return r;
}

inline VmaskA vpcmpgtq(const VecA& a, const VecA& b)
{
	VmaskA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpcmpgtq(a.v[i], b.v[i]);
	return r;
}

inline VmaskA kandb(const VmaskA& a, const VmaskA& b)
{
	VmaskA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = kandb(a.v[i], b.v[i]);
	return r;
}

/*
inline VecA vpbroadcastq(int64_t a)
{
	return _mm512_set1_epi64(a);
}
*/

// return c ? a&b : d;
inline VecA vpandq(const VmaskA& c, const VecA& a, const VecA& b, const VecA& d)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vpandq(c.v[i], a.v[i], b.v[i], d.v[i]);
	return r;
}

// return c ? a : b;
inline VecA vselect(const VmaskA& c, const VecA& a, const VecA& b)
{
	VecA r;
	for (size_t i = 0; i < vN; i++) r.v[i] = vselect(c.v[i], a.v[i], b.v[i]);
	return r;
}

#if defined(__GNUC__)
	#pragma GCC diagnostic pop
#endif

