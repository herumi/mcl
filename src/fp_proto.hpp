#pragma once
/**
	@file
	@brief prototype of asm function
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>

namespace mcl { namespace fp {

// (carry, z[N]) <- x[N] + y[N]
template<size_t N, class Tag>class AddPre { static const u3u f; };
// (carry, z[N]) <- x[N] - y[N]
template<size_t N, class Tag>class SubPre { static const u3u f; };
// z[N * 2] <- x[N] * y[N]
template<size_t N, class Tag>class MulPre { static const void3u f; };
// z[N * 2] <- x[N] * x[N]
template<size_t N, class Tag>class SqrPre { static const void2u f; };
// z[N + 1] <- x[N] * y
template<size_t N, class Tag>class Mul_UnitPre { static const void2uI f; };
// z[N] <- x[N + 1] % p[N]
template<size_t N, class Tag>class N1_Mod { static const void3u f; };
// z[N] <- x[N * 2] % p[N]
template<size_t N, class Tag>class Dbl_Mod { static const void3u f; };

} } // mcl::fp

#ifdef MCL_USE_LLVM

extern "C" {

#define MCL_FP_DEF_FUNC_SUB(len, suf) \
void mcl_fp_add ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_sub ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_addNC ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_subNC ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_mul_UnitPre ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, mcl::fp::Unit y); \
void mcl_fpDbl_mulPre ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fpDbl_sqrPre ## len ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x); \
void mcl_fp_mont ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_montRed ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* p); \
void mcl_fpDbl_add ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fpDbl_sub ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p);

#define MCL_FP_DEF_FUNC(len) \
	MCL_FP_DEF_FUNC_SUB(len, G) \
	MCL_FP_DEF_FUNC_SUB(len, L) \
	MCL_FP_DEF_FUNC_SUB(len, A)

#define MCL_FP_DEF_FUNC_SPECIAL(suf) \
	void mcl_fpDbl_mod_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */); \
	void mcl_fp_mul_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* /* dummy */); \
	void mcl_fp_sqr_NIST_P192 ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x, const mcl::fp::Unit* /* dummy */); \
	void mcl_fpDbl_mod_NIST_P521 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */);

MCL_FP_DEF_FUNC(64)
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

MCL_FP_DEF_FUNC_SPECIAL(G)
MCL_FP_DEF_FUNC_SPECIAL(L)
MCL_FP_DEF_FUNC_SPECIAL(A)

#undef MCL_FP_DEF_FUNC_SUB
#undef MCL_FP_DEF_FUNC

}

#endif

