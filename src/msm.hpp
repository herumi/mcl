#pragma once

namespace mcl {

#ifndef MCL_MSM
	#if (defined(_M_X64) || defined(__x86_64__)) && !defined(__APPLE__) && MCL_SIZEOF_UNIT == 8 && (MCL_FP_BIT == 256 || MCL_FP_BIT == 384) && MCL_FR_BIT == 256
		#define MCL_MSM 1
	#else
		#define MCL_MSM 0
	#endif
#endif

#if MCL_MSM == 1
namespace msm {

/*
	set the constants of the current curve (curveType = MCL_BN254, MCL_BLS12_381, ...) and register
	the SIMD kernel of the batch affine addition of G1::mulVec (G1::setMsmKernel, see src/glv.hpp)
	and mulEachAVX512 (Jacobian coordinates, a = 0). return false if the curve is not supported.
	splitRaw : the fixed-width GLV split of G1 (GLV1::splitRaw, used by mulEachAVX512)
	AVX-512 IFMA is required
*/
bool initMsm(int curveType, uint32_t (*splitRaw)(Unit *a, Unit *b, const Unit *x));
const ec::MsmKernel* getMsmKernelAVX512();
void mulEachAVX512(G1 *x, const Fr *y, size_t n);
#ifdef MCL_MSM_TEST
// the old MSM (each SIMD lane has its own buckets), only for comparison
void mulVecAVX512(G1& P, G1 *x, const Fr *y, size_t n, size_t b);
#endif

#if MCL_USE_GRUMPKIN == 1
/*
	the same for GG (Grumpkin : the base field Fr, the scalar field Fp) by the second kernel (mcl::msm_gg of msm_avx_impl.hpp)
	curveType = MCL_GRUMPKIN, splitRaw = GLV1T<GG>::splitRaw. the kernels of G1 and GG can be registered at the same time
*/
bool initMsmGG(int curveType, uint32_t (*splitRaw)(Unit *a, Unit *b, const Unit *x));
#endif

} // mcl::msm

#if MCL_USE_GRUMPKIN == 1
namespace msm_gg {

const ec::MsmKernel* getMsmKernelAVX512();
void mulEachAVX512(GG *x, const Fp *y, size_t n);

} // mcl::msm_gg
#endif
#endif

} // mcl
