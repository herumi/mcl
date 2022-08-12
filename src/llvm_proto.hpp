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
}
void4u get_llvm_fp_add(size_t n)
{
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
}
void4u get_llvm_fp_sub(size_t n)
{
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
}
void4u get_llvm_fp_addNF(size_t n)
{
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
}
void4u get_llvm_fp_subNF(size_t n)
{
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
}
void4u get_llvm_fp_mont(size_t n)
{
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
}
void4u get_llvm_fp_montNF(size_t n)
{
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
}
void3u get_llvm_fp_montRed(size_t n)
{
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
}
void3u get_llvm_fp_montRedNF(size_t n)
{
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
}
void4u get_llvm_fpDbl_add(size_t n)
{
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
}
void4u get_llvm_fpDbl_sub(size_t n)
{
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
}
}}
