#pragma once
#include <mcl/op.hpp>

namespace mcl { namespace fp {

template<size_t N>
Unit low_add(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_add_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
template<size_t N>
Unit low_sub(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_sub_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
// Z[N * 2]
template<size_t N>
void low_mul(Unit *z, const Unit *x, const Unit *y)
{
	return mpn_mul_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
}
template<size_t N>
void low_sqr(Unit *y, const Unit *x)
{
	return mpn_sqr((mp_limb_t*)y, (const mp_limb_t*)x, N);
}
// Z[N + 1]
template<size_t N>
void low_mul_Unit(Unit *z, const Unit *x, Unit y)
{
	z[N] = mpn_mul_1((mp_limb_t*)z, (const mp_limb_t*)x, N, y);
}
// y[N] <- X[N + 1] mod p[N]
template<size_t N>
void low_N1_mod(Unit *y, const Unit *x, const Unit *p)
{
	mp_limb_t q[2]; // not used
	mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N + 1, (const mp_limb_t*)p, N);
}
// y[N] <- X[N * 2] mod p[N]
template<size_t N>
void low_mod(Unit *y, const Unit *x, const Unit *p)
{
	mp_limb_t q[N + 1]; // not used
	mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N * 2, (const mp_limb_t*)p, N);
}

} } // mcl::fp

