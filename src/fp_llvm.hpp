#pragma once

namespace mcl { namespace fp {

template<>
struct EnableKaratsuba<Ltag> {
	static const size_t minMulN = 8;
	static const size_t minSqrN = 6;
};

#define MCL_DEF_LLVM_FUNC(n) \
template<>const u3u AddPre<n, Ltag>::f = &mcl_fp_addPre ## n ## L; \
template<>const u3u SubPre<n, Ltag>::f = &mcl_fp_subPre ## n ## L; \
template<>const void3u MulPreCore<n, Ltag>::f = &mcl_fpDbl_mulPre ## n ## L; \
template<>const void2u SqrPreCore<n, Ltag>::f = &mcl_fpDbl_sqrPre ## n ## L; \
template<>const void2uI MulUnitPre<n, Ltag>::f = &mcl_fp_mulUnitPre ## n ## L; \
template<>const void4u Add<n, Ltag>::f = &mcl_fp_add ## n ## L; \
template<>const void4u Sub<n, Ltag>::f = &mcl_fp_sub ## n ## L; \
template<>const void4u Mont<n, Ltag>::f = &mcl_fp_mont ## n ## L; \
template<>const void3u MontRed<n, Ltag>::f = &mcl_fp_montRed ## n ## L; \
template<>const void4u DblAdd<n, Ltag>::f = &mcl_fpDbl_add ## n ## L; \
template<>const void4u DblSub<n, Ltag>::f = &mcl_fpDbl_sub ## n ## L; \

MCL_DEF_LLVM_FUNC(1)
MCL_DEF_LLVM_FUNC(2)
MCL_DEF_LLVM_FUNC(3)
MCL_DEF_LLVM_FUNC(4)
MCL_DEF_LLVM_FUNC(5)
MCL_DEF_LLVM_FUNC(6)
MCL_DEF_LLVM_FUNC(7)
MCL_DEF_LLVM_FUNC(8)
MCL_DEF_LLVM_FUNC(9)
#if CYBOZU_OS_BIT == 32 || MCL_MAX_BIT_SIZE == 768
MCL_DEF_LLVM_FUNC(10)
MCL_DEF_LLVM_FUNC(11)
MCL_DEF_LLVM_FUNC(12)
#endif
#if CYBOZU_OS_BIT == 32
MCL_DEF_LLVM_FUNC(13)
MCL_DEF_LLVM_FUNC(14)
MCL_DEF_LLVM_FUNC(15)
MCL_DEF_LLVM_FUNC(16)
MCL_DEF_LLVM_FUNC(17)
#endif

} } // mcl::fp

