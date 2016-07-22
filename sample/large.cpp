/*
	large prime sample for 64-bit arch
	make USE_LLVM=1 CFLAGS_USER="-DMCL_MAX_OP_BIT_SIZE=768"
*/
#include <mcl/fp.hpp>
#include <cybozu/benchmark.hpp>

typedef mcl::FpT<> Fp;

typedef mcl::fp::Unit Unit;

void test(const std::string& pStr, mcl::fp::Mode mode)
{
	printf("test %s\n", mcl::fp::ModeToStr(mode));
	Fp::init(pStr, mode);
	const mcl::fp::Op& op = Fp::getOp();
	printf("bitSize=%d\n", (int)Fp::getBitSize());
	mpz_class p(pStr);
	Fp x = 123456;
	Fp::pow(x, x, p);
	std::cout << x << std::endl;
	const size_t N = 24;
	mcl::fp::Unit ux[N], uy[N];
	for (size_t i = 0; i < N; i++) {
		ux[i] = -i * i + 5;
		uy[i] = -i * i + 9;
	}
	CYBOZU_BENCH("mulPre", op.fpDbl_mulPre, ux, ux, uy);
	CYBOZU_BENCH("sqrPre", op.fpDbl_sqrPre, ux, ux);
	CYBOZU_BENCH("mont", op.fpDbl_mod, ux, ux);
	CYBOZU_BENCH("mul", Fp::mul, x, x, x);
}

void testAll(const std::string& pStr)
{
	test(pStr, mcl::fp::FP_GMP);
	test(pStr, mcl::fp::FP_GMP_MONT);
#ifdef MCL_USE_LLVM
	test(pStr, mcl::fp::FP_LLVM);
	test(pStr, mcl::fp::FP_LLVM_MONT);
#endif
}
int main()
	try
{
	const char *pTbl[] = {
		"40347654345107946713373737062547060536401653012956617387979052445947619094013143666088208645002153616185987062074179207",
		"776259046150354467574489744231251277628443008558348305569526019013025476343188443165439204414323238975243865348565536603085790022057407195722143637520590569602227488010424952775132642815799222412631499596858234375446423426908029627",
	};
	testAll(pTbl[0]);
	testAll(pTbl[1]);
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	puts("make clean");
	puts("make CFLAGS_USER=\"-DMCL_MAX_OP_BIT_SIZE=768\"");
	return 1;
}

