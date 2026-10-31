#pragma once

namespace mcl {

#ifndef MCL_MSM
	#if (defined(_M_X64) || defined(__x86_64__)) && !defined(__APPLE__) && MCL_SIZEOF_UNIT == 8 && MCL_FP_BIT == 384 && MCL_FR_BIT == 256
		#define MCL_MSM 1
	#else
		#define MCL_MSM 0
	#endif
#endif

#if MCL_MSM == 1
namespace msm {

// splitRaw : the fixed-width GLV split of G1 (GLV1::splitRaw, used by mulEachAVX512)
bool initMsm(const mcl::CurveParam& cp, uint32_t (*splitRaw)(Unit *a, Unit *b, const Unit *x));
// the SIMD kernel of the batch affine addition of G1::mulVec (see src/glv.hpp), set by G1::setMsmKernel
const ec::MsmKernel* getMsmKernelAVX512();
void mulEachAVX512(G1 *x, const Fr *y, size_t n);
#ifdef MCL_MSM_TEST
// the old MSM (each SIMD lane has its own buckets), only for comparison
void mulVecAVX512(G1& P, G1 *x, const Fr *y, size_t n, size_t b);
#endif

} // mcl::msm
#endif

} // mcl
