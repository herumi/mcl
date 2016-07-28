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
void mcl_fp_add ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_sub ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_addNC ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_subNC ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_mul_UnitPre ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, mcl::fp::Unit y); \
void mcl_fpDbl_mulPre ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fpDbl_sqrPre ## len(mcl::fp::Unit* y, const mcl::fp::Unit* x); \
void mcl_fp_mont ## len(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p, mcl::fp::Unit r); \
void mcl_fp_montRed ## len(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* p, mcl::fp::Unit r); \
void mcl_fpDbl_add ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fpDbl_sub ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*);

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
MCL_FP_DEF_FUNC(640)
MCL_FP_DEF_FUNC(704)
MCL_FP_DEF_FUNC(768)
MCL_FP_DEF_FUNC(1024)
MCL_FP_DEF_FUNC(1152)
MCL_FP_DEF_FUNC(1280)
MCL_FP_DEF_FUNC(1408)
MCL_FP_DEF_FUNC(1536)
#endif

#undef MCL_FP_DEF_FUNC

void mcl_fpDbl_mod_NIST_P192(mcl::fp::Unit*, const mcl::fp::Unit*);
void mcl_fp_mul_NIST_P192(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*);
void mcl_fp_sqr_NIST_P192(mcl::fp::Unit*, const mcl::fp::Unit*);

void mcl_fpDbl_mod_NIST_P521(mcl::fp::Unit*, const mcl::fp::Unit*);

}

#endif

