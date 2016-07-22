/*
	large prime sample for 64-bit arch
	make USE_LLVM=1 CFLAGS_USER="-DMCL_MAX_OP_BIT_SIZE=768"
*/
#include <mcl/fp.hpp>
#include <cybozu/benchmark.hpp>

typedef mcl::FpT<> Fp;

typedef mcl::fp::Unit Unit;
using namespace mcl::fp;

#include "../src/low_gmp.hpp"
const size_t N = 12;

#if 0
void mulPre768(Unit *pz, const Unit *px, const Unit *py)
{
	/*
		W = 1 << H
		(aW + b)(cW + d) = acW^2 + (ad + bc)W + bd
		ad + bc = (a + b)(c + d) - ac - bd
	*/
	const size_t H = N / 2;
	low_mul<H>(pz, px, py); // bd
	low_mul<H>(pz + N, px + H, py + H); // ac
	Unit a_b[H + 1];
	Unit c_d[H + 1];
	a_b[H] = low_add<H>(a_b, px, px + H); // a + b
	c_d[H] = low_add<H>(c_d, py, py + H); // c + d
	Unit work[N + H] = {};
	low_mul<H>(work, a_b, c_d);
	if (c_d[H]) low_add<H + 1>(work + H, work + H, c_d);
	if (a_b[H]) low_add<H + 1>(work + H, work + H, a_b);
	work[N] -= low_sub<H>(work, work, pz);
	work[N] -= low_sub<H>(work, work, pz + N);
	low_add<H + N>(pz + H, pz + H, work);
}
void testMul()
{
	mcl::fp::Unit ux[N], uy[N], a[N * 2], b[N * 2];
	for (size_t i = 0; i < N; i++) {
		ux[i] = -i * i + 5;
		uy[i] = -i * i + 9;
	}
	low_mul<12>(a, ux, uy);
	mulPre768(b, ux, uy);
	for (size_t i = 0; i < N * 2; i++) {
		if (a[i] != b[i]) {
			printf("ERR %016llx %016llx\n", (long long)a[i], (long long)b[i]);
		}
	}
	puts("end testMul");
	CYBOZU_BENCH("mulPre768", mulPre768, ux, ux, uy);
}
#endif

void mulGmp(mpz_class& z, const mpz_class& x, const mpz_class& y, const mpz_class& p)
{
	z = (x * y) % p;
}
void compareGmp(const std::string& pStr)
{
	Fp::init(pStr);
	std::string xStr = "2104871209348712947120947102843728";
	{
		Fp x(xStr);
		CYBOZU_BENCH_C("mul by mcl", 1000, Fp::mul, x, x, x);
		std::cout << "ret=" << x << std::endl;
	}
	{
		const mpz_class p(pStr);
		mpz_class x(xStr);
		CYBOZU_BENCH_C("mul by GMP", 1000, mulGmp, x, x, x, p);
		std::cout << "ret=" << x << std::endl;
	}
}

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
	compareGmp(pStr);
}
int main()
	try
{
	const char *pTbl[] = {
		"40347654345107946713373737062547060536401653012956617387979052445947619094013143666088208645002153616185987062074179207",
		"13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006083527",
		"776259046150354467574489744231251277628443008558348305569526019013025476343188443165439204414323238975243865348565536603085790022057407195722143637520590569602227488010424952775132642815799222412631499596858234375446423426908029627",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(pTbl); i++) {
		testAll(pTbl[i]);
	}
//	testMul();
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	puts("make clean");
	puts("make CFLAGS_USER=\"-DMCL_MAX_OP_BIT_SIZE=768\"");
	return 1;
}

