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
}}
