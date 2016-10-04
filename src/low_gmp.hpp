#pragma once
#include <mcl/op.hpp>
#include "fp_proto.hpp"

namespace mcl { namespace fp {

struct GTag;

template<size_t N>
struct AddPre<N, GTag> {
	static inline Unit addPre(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_add_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const u3u f;
};

template<size_t N>
const u3u AddPre<N, GTag>::f = &AddPre<N, GTag>::addPre;

template<size_t N>
inline Unit low_addNC_G(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_add_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
template<size_t N>
inline Unit low_subNC_G(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_sub_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
// Z[N * 2]
template<size_t N>
inline void low_mul_G(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_mul_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
template<size_t N>
inline void low_sqr_G(Unit *y, const Unit *x)
{
	return mpn_sqr((mp_limb_t*)y, (const mp_limb_t*)x, N);
}
// Z[N + 1]
template<size_t N>
inline void low_mul_Unit_G(Unit *z, const Unit *x, Unit y)
{
	z[N] = mpn_mul_1((mp_limb_t*)z, (const mp_limb_t*)x, N, y);
}
// y[N] <- X[N + 1] mod p[N]
template<size_t N>
inline void low_N1_mod_G(Unit *y, const Unit *x, const Unit *p)
{
	mp_limb_t q[2]; // not used
	mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N + 1, (const mp_limb_t*)p, N);
}
// y[N] <- X[N * 2] mod p[N]
template<size_t N>
inline void low_mod_G(Unit *y, const Unit *x, const Unit *p)
{
	mp_limb_t q[N + 1]; // not used
	mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N * 2, (const mp_limb_t*)p, N);
}

} } // mcl::fp

