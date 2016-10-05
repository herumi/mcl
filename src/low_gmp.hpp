#pragma once
#include <mcl/op.hpp>
#include "fp_proto.hpp"

namespace mcl { namespace fp {

struct Gtag;

template<size_t N>
struct AddNC<N, Gtag> {
	static inline Unit func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_add_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const u3u f;
};

template<size_t N>
const u3u AddNC<N, Gtag>::f = &AddNC<N, Gtag>::func;

template<size_t N>
struct SubNC<N, Gtag> {
	static inline Unit func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_sub_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const u3u f;
};

template<size_t N>
const u3u SubNC<N, Gtag>::f = &SubNC<N, Gtag>::func;

template<size_t N>
struct MulPre<N, Gtag> {
	static inline void func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_mul_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const void3u f;
};

template<size_t N>
const void3u MulPre<N, Gtag>::f = &MulPre<N, Gtag>::func;

template<size_t N>
struct SqrPre<N, Gtag> {
	static inline void func(Unit *y, const Unit *x)
	{
		return mpn_sqr((mp_limb_t*)y, (const mp_limb_t*)x, N);
	}
	static const void2u f;
};

template<size_t N>
const void2u SqrPre<N, Gtag>::f = &SqrPre<N, Gtag>::func;

template<size_t N>
struct Mul_UnitPre<N, Gtag> {
	static inline void func(Unit *z, const Unit *x, Unit y)
	{
		z[N] = mpn_mul_1((mp_limb_t*)z, (const mp_limb_t*)x, N, y);
	}
	static const void2uI f;
};

template<size_t N>
const void2uI Mul_UnitPre<N, Gtag>::f = &Mul_UnitPre<N, Gtag>::func;

template<size_t N>
struct N1_Mod<N, Gtag> {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		mp_limb_t q[2]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N + 1, (const mp_limb_t*)p, N);
	}
	static const void3u f;
};

template<size_t N>
const void3u N1_Mod<N, Gtag>::f = &N1_Mod<N, Gtag>::func;

template<size_t N>
struct Dbl_Mod<N, Gtag> {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		mp_limb_t q[N + 1]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N * 2, (const mp_limb_t*)p, N);
	}
	static const void3u f;
};

template<size_t N>
const void3u Dbl_Mod<N, Gtag>::f = &Dbl_Mod<N, Gtag>::func;

} } // mcl::fp

