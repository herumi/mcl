#pragma once
/**
	@file
	@brief prototype of asm function
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>

#ifdef MCL_USE_LLVM

extern "C" {

#define MCL_FP_DEF_FUNC(len) \
void mcl_fp_add ## len ## S(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_add ## len ## L(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_sub ## len ## S(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_sub ## len ## L(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_mulPre ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_mont ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, mcl::fp::Unit);

MCL_FP_DEF_FUNC(128)
MCL_FP_DEF_FUNC(192)
MCL_FP_DEF_FUNC(256)
MCL_FP_DEF_FUNC(320)
MCL_FP_DEF_FUNC(384)
MCL_FP_DEF_FUNC(448)
MCL_FP_DEF_FUNC(512)
#if CYBOZU_OS_BIT == 32
MCL_FP_DEF_FUNC(160)
MCL_FP_DEF_FUNC(224)
MCL_FP_DEF_FUNC(288)
MCL_FP_DEF_FUNC(352)
MCL_FP_DEF_FUNC(416)
MCL_FP_DEF_FUNC(480)
MCL_FP_DEF_FUNC(544)
#else
MCL_FP_DEF_FUNC(576)
#endif

void mcl_fp_mul_NIST_P192(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*);

}

#endif

