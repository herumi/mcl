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

inline Vmask vcmpeqq(const Vec& a, const Vec& b)
{
	return _mm512_cmpeq_epi64_mask(a, b);
}

inline Vmask vcmpneqq(const Vec& a, const Vec& b)
{
	return _mm512_cmpneq_epi64_mask(a, b);
}

inline Vmask vcmpgtq(const Vec& a, const Vec& b)
{
	return _mm512_cmpgt_epi64_mask(a, b);
}

inline Vmask kandb(const Vmask& a, const Vmask& b)
{
	return _mm512_kand(a, b);
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

#if defined(__GNUC__)
	#pragma GCC diagnostic pop
#endif

