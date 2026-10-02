#define MCL_FP_BIT_LLVM 384
namespace mcl { namespace fp {
extern "C" {
void mcl_fp_add3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_add16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_sub16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_addNF16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_subNF16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mont16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montNF16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_montRed3L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed4L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed6L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed7L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed8L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed12L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRed16L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF3L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF4L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF6L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF7L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF8L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF12L(Unit*, const Unit*, const Unit*);
void mcl_fp_montRedNF16L(Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_add16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub3L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub7L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fpDbl_sub16L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp_mulNIST_P192L(Unit *, const Unit *, const Unit *, const Unit *);
void mcl_fp_sqr_NIST_P192L(Unit *, const Unit *, const Unit *);
void mcl_fpDbl_mod_NIST_P192L(Unit *, const Unit *, const Unit *);
void mcl_fpDbl_mod_NIST_P521L(Unit *, const Unit *, const Unit *);
void mcl_fp_mul_SECP256K1L(Unit *, const Unit *, const Unit *, const Unit *);
void mcl_fp_sqr_SECP256K1L(Unit *, const Unit *, const Unit *);
void mcl_fpDbl_mod_SECP256K1L(Unit *, const Unit *, const Unit *);
}
#ifdef MCL_USE_LLVM
#if MCL_SIZEOF_UNIT == 4
static inline void mcl_fp_sqrMont6L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont6L(z, x, x, p); }
static inline void mcl_fp_sqrMont7L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont7L(z, x, x, p); }
static inline void mcl_fp_sqrMont8L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont8L(z, x, x, p); }
static inline void mcl_fp_sqrMont12L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont12L(z, x, x, p); }
static inline void mcl_fp_sqrMont16L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont16L(z, x, x, p); }
#else
static inline void mcl_fp_sqrMont3L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont3L(z, x, x, p); }
static inline void mcl_fp_sqrMont4L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont4L(z, x, x, p); }
static inline void mcl_fp_sqrMont6L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont6L(z, x, x, p); }
static inline void mcl_fp_sqrMont8L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_mont8L(z, x, x, p); }
#endif
#endif
#ifdef MCL_USE_LLVM
#if MCL_SIZEOF_UNIT == 4
static inline void mcl_fp_sqrMontNF6L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF6L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF7L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF7L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF8L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF8L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF12L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF12L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF16L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF16L(z, x, x, p); }
#else
static inline void mcl_fp_sqrMontNF3L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF3L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF4L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF4L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF6L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF6L(z, x, x, p); }
static inline void mcl_fp_sqrMontNF8L(Unit *z, const Unit *x, const Unit *p) { return mcl_fp_montNF8L(z, x, x, p); }
#endif
#endif
static inline bint::void_pppp get_llvm_fp_add(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_add6L;
	case 7: return mcl_fp_add7L;
	case 8: return mcl_fp_add8L;
	case 12: return mcl_fp_add12L;
	case 16: return mcl_fp_add16L;
#else
	case 3: return mcl_fp_add3L;
	case 4: return mcl_fp_add4L;
	case 6: return mcl_fp_add6L;
	case 8: return mcl_fp_add8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fp_sub(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_sub6L;
	case 7: return mcl_fp_sub7L;
	case 8: return mcl_fp_sub8L;
	case 12: return mcl_fp_sub12L;
	case 16: return mcl_fp_sub16L;
#else
	case 3: return mcl_fp_sub3L;
	case 4: return mcl_fp_sub4L;
	case 6: return mcl_fp_sub6L;
	case 8: return mcl_fp_sub8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fp_addNF(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_addNF6L;
	case 7: return mcl_fp_addNF7L;
	case 8: return mcl_fp_addNF8L;
	case 12: return mcl_fp_addNF12L;
	case 16: return mcl_fp_addNF16L;
#else
	case 3: return mcl_fp_addNF3L;
	case 4: return mcl_fp_addNF4L;
	case 6: return mcl_fp_addNF6L;
	case 8: return mcl_fp_addNF8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fp_subNF(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_subNF6L;
	case 7: return mcl_fp_subNF7L;
	case 8: return mcl_fp_subNF8L;
	case 12: return mcl_fp_subNF12L;
	case 16: return mcl_fp_subNF16L;
#else
	case 3: return mcl_fp_subNF3L;
	case 4: return mcl_fp_subNF4L;
	case 6: return mcl_fp_subNF6L;
	case 8: return mcl_fp_subNF8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fp_mont(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_mont6L;
	case 7: return mcl_fp_mont7L;
	case 8: return mcl_fp_mont8L;
	case 12: return mcl_fp_mont12L;
	case 16: return mcl_fp_mont16L;
#else
	case 3: return mcl_fp_mont3L;
	case 4: return mcl_fp_mont4L;
	case 6: return mcl_fp_mont6L;
	case 8: return mcl_fp_mont8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fp_montNF(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_montNF6L;
	case 7: return mcl_fp_montNF7L;
	case 8: return mcl_fp_montNF8L;
	case 12: return mcl_fp_montNF12L;
	case 16: return mcl_fp_montNF16L;
#else
	case 3: return mcl_fp_montNF3L;
	case 4: return mcl_fp_montNF4L;
	case 6: return mcl_fp_montNF6L;
	case 8: return mcl_fp_montNF8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_ppp get_llvm_fp_montRed(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_montRed6L;
	case 7: return mcl_fp_montRed7L;
	case 8: return mcl_fp_montRed8L;
	case 12: return mcl_fp_montRed12L;
	case 16: return mcl_fp_montRed16L;
#else
	case 3: return mcl_fp_montRed3L;
	case 4: return mcl_fp_montRed4L;
	case 6: return mcl_fp_montRed6L;
	case 8: return mcl_fp_montRed8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_ppp get_llvm_fp_montRedNF(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_montRedNF6L;
	case 7: return mcl_fp_montRedNF7L;
	case 8: return mcl_fp_montRedNF8L;
	case 12: return mcl_fp_montRedNF12L;
	case 16: return mcl_fp_montRedNF16L;
#else
	case 3: return mcl_fp_montRedNF3L;
	case 4: return mcl_fp_montRedNF4L;
	case 6: return mcl_fp_montRedNF6L;
	case 8: return mcl_fp_montRedNF8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fpDbl_add(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fpDbl_add6L;
	case 7: return mcl_fpDbl_add7L;
	case 8: return mcl_fpDbl_add8L;
	case 12: return mcl_fpDbl_add12L;
	case 16: return mcl_fpDbl_add16L;
#else
	case 3: return mcl_fpDbl_add3L;
	case 4: return mcl_fpDbl_add4L;
	case 6: return mcl_fpDbl_add6L;
	case 8: return mcl_fpDbl_add8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_pppp get_llvm_fpDbl_sub(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fpDbl_sub6L;
	case 7: return mcl_fpDbl_sub7L;
	case 8: return mcl_fpDbl_sub8L;
	case 12: return mcl_fpDbl_sub12L;
	case 16: return mcl_fpDbl_sub16L;
#else
	case 3: return mcl_fpDbl_sub3L;
	case 4: return mcl_fpDbl_sub4L;
	case 6: return mcl_fpDbl_sub6L;
	case 8: return mcl_fpDbl_sub8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_ppp get_llvm_fp_sqrMont(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_sqrMont6L;
	case 7: return mcl_fp_sqrMont7L;
	case 8: return mcl_fp_sqrMont8L;
	case 12: return mcl_fp_sqrMont12L;
	case 16: return mcl_fp_sqrMont16L;
#else
	case 3: return mcl_fp_sqrMont3L;
	case 4: return mcl_fp_sqrMont4L;
	case 6: return mcl_fp_sqrMont6L;
	case 8: return mcl_fp_sqrMont8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
static inline bint::void_ppp get_llvm_fp_sqrMontNF(size_t n)
{
#ifdef MCL_USE_LLVM
	switch (n) {
	default: return 0;
#if MCL_SIZEOF_UNIT == 4
	case 6: return mcl_fp_sqrMontNF6L;
	case 7: return mcl_fp_sqrMontNF7L;
	case 8: return mcl_fp_sqrMontNF8L;
	case 12: return mcl_fp_sqrMontNF12L;
	case 16: return mcl_fp_sqrMontNF16L;
#else
	case 3: return mcl_fp_sqrMontNF3L;
	case 4: return mcl_fp_sqrMontNF4L;
	case 6: return mcl_fp_sqrMontNF6L;
	case 8: return mcl_fp_sqrMontNF8L;
#endif
	}
#else
	(void)n;
	return 0;
#endif
}
#if defined(MCL_USE_LLVM) && !defined(MCL_WASM32) && !defined(MCL_X64_ASM)
// the p-generic functions for the A_ slots (see common.gen_generic_fp / gen_generic_fp2 in src/gen.py)
extern "C" {
#if MCL_SIZEOF_UNIT == 4
void mcl_fp_neg8L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2_8L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2NF8L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqr8L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqrNF8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_add8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sub8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_neg8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul2_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u1_8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u1_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u1_8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u1_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u5_8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u5_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u5_8L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u5_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x1_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x1_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x9_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x9_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u5x0_8L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u5x0_8L(Unit*, const Unit*, const Unit*);
void mcl_fp_neg12L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2_12L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2NF12L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqr12L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqrNF12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_add12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sub12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_neg12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul2_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u1_12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u1_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u1_12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u1_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u5_12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u5_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u5_12L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u5_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x1_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x1_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x9_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x9_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u5x0_12L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u5x0_12L(Unit*, const Unit*, const Unit*);
#else
void mcl_fp_neg4L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2_4L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2NF4L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqr4L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqrNF4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_add4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sub4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_neg4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul2_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u1_4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u1_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u1_4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u1_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u5_4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u5_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u5_4L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u5_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x1_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x1_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x9_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x9_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u5x0_4L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u5x0_4L(Unit*, const Unit*, const Unit*);
void mcl_fp_neg6L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2_6L(Unit*, const Unit*, const Unit*);
void mcl_fp_mul2NF6L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqr6L(Unit*, const Unit*, const Unit*);
void mcl_fp_sqrNF6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_add6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sub6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_neg6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul2_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u1_6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u1_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u1_6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u1_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_u5_6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2_sqr_u5_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mulPre_u5_6L(Unit*, const Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_sqrPre_u5_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x1_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x1_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u1x9_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u1x9_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2_mul_xi_u5x0_6L(Unit*, const Unit*, const Unit*);
void mcl_fp2Dbl_mul_xi_u5x0_6L(Unit*, const Unit*, const Unit*);
#endif
}
// set the A_ slots of Fp (and fpDbl_{mod,add,sub}A_) of op to the p-generic
// functions of N units; false if N is not supported (then op is not changed)
static inline bool set_llvm_fp(Op& op, size_t N, bool isFullBit)
{
	switch (N) {
#if MCL_SIZEOF_UNIT == 4
	case 8:
		if (isFullBit) {
			op.fp_addA_ = mcl_fp_add8L;
			op.fp_subA_ = mcl_fp_sub8L;
			op.fp_negA_ = mcl_fp_neg8L;
			op.fp_mul2A_ = mcl_fp_mul2_8L;
			op.fp_mulA_ = mcl_fp_mont8L;
			op.fp_sqrA_ = mcl_fp_sqr8L;
			op.fpDbl_modA_ = mcl_fp_montRed8L;
			op.fpDbl_addA_ = mcl_fpDbl_add8L;
			op.fpDbl_subA_ = mcl_fpDbl_sub8L;
		}
		else {
			op.fp_addA_ = mcl_fp_addNF8L;
			op.fp_subA_ = mcl_fp_subNF8L;
			op.fp_negA_ = mcl_fp_neg8L;
			op.fp_mul2A_ = mcl_fp_mul2NF8L;
			op.fp_mulA_ = mcl_fp_montNF8L;
			op.fp_sqrA_ = mcl_fp_sqrNF8L;
			op.fpDbl_modA_ = mcl_fp_montRedNF8L;
			op.fpDbl_addA_ = mcl_fpDbl_add8L;
			op.fpDbl_subA_ = mcl_fpDbl_sub8L;
		}
		break;
	case 12:
		if (isFullBit) {
			op.fp_addA_ = mcl_fp_add12L;
			op.fp_subA_ = mcl_fp_sub12L;
			op.fp_negA_ = mcl_fp_neg12L;
			op.fp_mul2A_ = mcl_fp_mul2_12L;
			op.fp_mulA_ = mcl_fp_mont12L;
			op.fp_sqrA_ = mcl_fp_sqr12L;
			op.fpDbl_modA_ = mcl_fp_montRed12L;
			op.fpDbl_addA_ = mcl_fpDbl_add12L;
			op.fpDbl_subA_ = mcl_fpDbl_sub12L;
		}
		else {
			op.fp_addA_ = mcl_fp_addNF12L;
			op.fp_subA_ = mcl_fp_subNF12L;
			op.fp_negA_ = mcl_fp_neg12L;
			op.fp_mul2A_ = mcl_fp_mul2NF12L;
			op.fp_mulA_ = mcl_fp_montNF12L;
			op.fp_sqrA_ = mcl_fp_sqrNF12L;
			op.fpDbl_modA_ = mcl_fp_montRedNF12L;
			op.fpDbl_addA_ = mcl_fpDbl_add12L;
			op.fpDbl_subA_ = mcl_fpDbl_sub12L;
		}
		break;
#else
	case 4:
		if (isFullBit) {
			op.fp_addA_ = mcl_fp_add4L;
			op.fp_subA_ = mcl_fp_sub4L;
			op.fp_negA_ = mcl_fp_neg4L;
			op.fp_mul2A_ = mcl_fp_mul2_4L;
			op.fp_mulA_ = mcl_fp_mont4L;
			op.fp_sqrA_ = mcl_fp_sqr4L;
			op.fpDbl_modA_ = mcl_fp_montRed4L;
			op.fpDbl_addA_ = mcl_fpDbl_add4L;
			op.fpDbl_subA_ = mcl_fpDbl_sub4L;
		}
		else {
			op.fp_addA_ = mcl_fp_addNF4L;
			op.fp_subA_ = mcl_fp_subNF4L;
			op.fp_negA_ = mcl_fp_neg4L;
			op.fp_mul2A_ = mcl_fp_mul2NF4L;
			op.fp_mulA_ = mcl_fp_montNF4L;
			op.fp_sqrA_ = mcl_fp_sqrNF4L;
			op.fpDbl_modA_ = mcl_fp_montRedNF4L;
			op.fpDbl_addA_ = mcl_fpDbl_add4L;
			op.fpDbl_subA_ = mcl_fpDbl_sub4L;
		}
		break;
	case 6:
		if (isFullBit) {
			op.fp_addA_ = mcl_fp_add6L;
			op.fp_subA_ = mcl_fp_sub6L;
			op.fp_negA_ = mcl_fp_neg6L;
			op.fp_mul2A_ = mcl_fp_mul2_6L;
			op.fp_mulA_ = mcl_fp_mont6L;
			op.fp_sqrA_ = mcl_fp_sqr6L;
			op.fpDbl_modA_ = mcl_fp_montRed6L;
			op.fpDbl_addA_ = mcl_fpDbl_add6L;
			op.fpDbl_subA_ = mcl_fpDbl_sub6L;
		}
		else {
			op.fp_addA_ = mcl_fp_addNF6L;
			op.fp_subA_ = mcl_fp_subNF6L;
			op.fp_negA_ = mcl_fp_neg6L;
			op.fp_mul2A_ = mcl_fp_mul2NF6L;
			op.fp_mulA_ = mcl_fp_montNF6L;
			op.fp_sqrA_ = mcl_fp_sqrNF6L;
			op.fpDbl_modA_ = mcl_fp_montRedNF6L;
			op.fpDbl_addA_ = mcl_fpDbl_add6L;
			op.fpDbl_subA_ = mcl_fpDbl_sub6L;
		}
		break;
#endif
	default: return false;
	}
	op.fp_mul = op.fp_mulA_; // used in toMont/fromMont
	return true;
}
// set the Fp2 / Fp2Dbl A_ slots of op to the p-generic functions of N units
// for Fp2 = Fp[i]/(i^2 + u) with xi = xi_a + i; false if (N, u, xi_a) is not
// supported (then op is not changed). The caller checks sizeof(Fp) ==
// MCL_FP_BIT_LLVM / 8, p not full bit and p < R/4.
static inline bool set_llvm_fp2(Op& op, size_t N, int u, int xi_a)
{
	if (!((u == 1 && xi_a == 1) || (u == 1 && xi_a == 9) || (u == 5 && xi_a == 0))) return false;
	switch (N) {
#if MCL_SIZEOF_UNIT == 4
	case 8:
		op.fp2_addA_ = mcl_fp2_add8L;
		op.fp2_subA_ = mcl_fp2_sub8L;
		op.fp2_negA_ = mcl_fp2_neg8L;
		op.fp2_mul2A_ = mcl_fp2_mul2_8L;
		if (u == 1 && xi_a == 1) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_8L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_8L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_8L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_8L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x1_8L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x1_8L;
		} else if (u == 1 && xi_a == 9) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_8L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_8L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_8L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_8L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x9_8L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x9_8L;
		} else if (u == 5 && xi_a == 0) {
			op.fp2_mulA_ = mcl_fp2_mul_u5_8L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u5_8L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u5_8L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u5_8L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u5x0_8L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u5x0_8L;
		}
		break;
	case 12:
		op.fp2_addA_ = mcl_fp2_add12L;
		op.fp2_subA_ = mcl_fp2_sub12L;
		op.fp2_negA_ = mcl_fp2_neg12L;
		op.fp2_mul2A_ = mcl_fp2_mul2_12L;
		if (u == 1 && xi_a == 1) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_12L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_12L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_12L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_12L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x1_12L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x1_12L;
		} else if (u == 1 && xi_a == 9) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_12L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_12L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_12L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_12L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x9_12L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x9_12L;
		} else if (u == 5 && xi_a == 0) {
			op.fp2_mulA_ = mcl_fp2_mul_u5_12L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u5_12L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u5_12L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u5_12L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u5x0_12L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u5x0_12L;
		}
		break;
#else
	case 4:
		op.fp2_addA_ = mcl_fp2_add4L;
		op.fp2_subA_ = mcl_fp2_sub4L;
		op.fp2_negA_ = mcl_fp2_neg4L;
		op.fp2_mul2A_ = mcl_fp2_mul2_4L;
		if (u == 1 && xi_a == 1) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_4L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_4L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_4L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_4L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x1_4L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x1_4L;
		} else if (u == 1 && xi_a == 9) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_4L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_4L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_4L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_4L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x9_4L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x9_4L;
		} else if (u == 5 && xi_a == 0) {
			op.fp2_mulA_ = mcl_fp2_mul_u5_4L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u5_4L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u5_4L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u5_4L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u5x0_4L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u5x0_4L;
		}
		break;
	case 6:
		op.fp2_addA_ = mcl_fp2_add6L;
		op.fp2_subA_ = mcl_fp2_sub6L;
		op.fp2_negA_ = mcl_fp2_neg6L;
		op.fp2_mul2A_ = mcl_fp2_mul2_6L;
		if (u == 1 && xi_a == 1) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_6L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_6L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_6L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_6L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x1_6L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x1_6L;
		} else if (u == 1 && xi_a == 9) {
			op.fp2_mulA_ = mcl_fp2_mul_u1_6L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u1_6L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u1_6L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u1_6L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u1x9_6L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u1x9_6L;
		} else if (u == 5 && xi_a == 0) {
			op.fp2_mulA_ = mcl_fp2_mul_u5_6L;
			op.fp2_sqrA_ = mcl_fp2_sqr_u5_6L;
			op.fp2Dbl_mulPreA_ = mcl_fp2Dbl_mulPre_u5_6L;
			op.fp2Dbl_sqrPreA_ = mcl_fp2Dbl_sqrPre_u5_6L;
			op.fp2_mul_xiA_ = mcl_fp2_mul_xi_u5x0_6L;
			op.fp2Dbl_mul_xiA_ = mcl_fp2Dbl_mul_xi_u5x0_6L;
		}
		break;
#endif
	default: return false;
	}
	return true;
}
#endif
}}
