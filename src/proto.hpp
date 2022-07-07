#pragma once
/**
	@file
	@brief prototype of asm function
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>

#define MCL_FP_DEF_FUNC_SUB(n, suf) \
void mcl_fp_add ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_addNF ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_sub ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_subNF ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_shr1_ ## n ## suf(mcl::Unit*y, const mcl::Unit* x); \
mcl::Unit mcl_fp_addPre ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y); \
mcl::Unit mcl_fp_subPre ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y); \
void mcl_fp_mulUnitPre ## n ## suf(mcl::Unit* z, const mcl::Unit* x, mcl::Unit y); \
void mcl_fpDbl_mulPre ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y); \
void mcl_fpDbl_sqrPre ## n ## suf(mcl::Unit* y, const mcl::Unit* x); \
void mcl_fp_mont ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_montNF ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fp_montRed ## n ## suf(mcl::Unit* z, const mcl::Unit* xy, const mcl::Unit* p); \
void mcl_fp_montRedNF ## n ## suf(mcl::Unit* z, const mcl::Unit* xy, const mcl::Unit* p); \
void mcl_fpDbl_add ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p); \
void mcl_fpDbl_sub ## n ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* p);

#define MCL_FP_DEF_FUNC(n) MCL_FP_DEF_FUNC_SUB(n, L)

#define MCL_FP_DEF_FUNC_SPECIAL(suf) \
void mcl_fpDbl_mod_NIST_P192 ## suf(mcl::Unit* z, const mcl::Unit* xy, const mcl::Unit* /* dummy */); \
void mcl_fp_mulNIST_P192 ## suf(mcl::Unit* z, const mcl::Unit* x, const mcl::Unit* y, const mcl::Unit* /* dummy */); \
void mcl_fp_sqr_NIST_P192 ## suf(mcl::Unit* y, const mcl::Unit* x, const mcl::Unit* /* dummy */); \
void mcl_fpDbl_mod_NIST_P521 ## suf(mcl::Unit* z, const mcl::Unit* xy, const mcl::Unit* /* dummy */);

extern "C" {

#if MCL_SIZEOF_UNIT == 4

MCL_FP_DEF_FUNC(6)
MCL_FP_DEF_FUNC(7)
MCL_FP_DEF_FUNC(8)
#if MCL_MAX_UNIT_SIZE >= 12
MCL_FP_DEF_FUNC(12)
#endif
#if MCL_MAX_UNIT_SIZE >= 16
MCL_FP_DEF_FUNC(16)
#endif

#else // 64

MCL_FP_DEF_FUNC(3)
MCL_FP_DEF_FUNC(4)
#if MCL_MAX_UNIT_SIZE >= 6
MCL_FP_DEF_FUNC(6)
#endif
#if MCL_MAX_UNIT_SIZE >= 8
MCL_FP_DEF_FUNC(8)
#endif

#endif

MCL_FP_DEF_FUNC_SPECIAL(L)

}

#undef MCL_FP_DEF_FUNC_SUB
#undef MCL_FP_DEF_FUNC

