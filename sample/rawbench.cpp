#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <cybozu/xorshift.hpp>
#include <mcl/fp.hpp>
#include <mcl/fp_tower.hpp>

typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::Fp2T<Fp> Fp2;
typedef mcl::FpDblT<Fp> FpDbl;
typedef mcl::Fp6T<Fp> Fp6;
typedef mcl::Fp12T<Fp> Fp12;

const char *getModeStr(mcl::fp::Mode mode)
{
	switch (mode) {
	case mcl::fp::FP_GMP: return "gmp";
	case mcl::fp::FP_LLVM: return "llvm";
	case mcl::fp::FP_LLVM_MONT: return "llvm+mont";
	case mcl::fp::FP_XBYAK: return "xbyak";
	default: throw cybozu::Exception("bad mode") << mode;
	}
}
void benchFpSub(const char *pStr, const char *xStr, const char *yStr, mcl::fp::Mode mode)
{
	const char *s = getModeStr(mode);
	Fp::setModulo(pStr, 0, mode);
	Fp x(xStr);
	Fp y(yStr);

	double addT, subT, mulT, sqrT, invT;
	CYBOZU_BENCH_T(addT, Fp::add, x, x, x);
	CYBOZU_BENCH_T(subT, Fp::sub, x, x, y);
	CYBOZU_BENCH_T(mulT, Fp::mul, x, x, x);
	CYBOZU_BENCH_T(sqrT, Fp::sqr, x, x);
	CYBOZU_BENCH_T(invT, x += y;Fp::inv, x, x); // avoid same jmp
	printf("%10s bit % 3d add %8.2f sub %8.2f mul %8.2f sqr %8.2f inv %8.2f\n", s, (int)Fp::getBitSize(), addT, subT, mulT, sqrT, invT);
}

void benchRaw(const char *p, mcl::fp::Mode mode)
{
	const char *s = getModeStr(mode);
	Fp::setModulo(p, 0, mode);
	const mcl::fp::Op& op = Fp::getOp();
	Fp fx = -1, fy;
	mpz_class mp(p);
	fy.setMpz(mp / 2);
	const size_t maxN = sizeof(Fp) / sizeof(mcl::fp::Unit);
	mcl::fp::Unit ux[maxN * 2] = {};
	mcl::fp::Unit uy[maxN * 2] = {};
	memcpy(ux, fx.getUnit(), sizeof(fx));
	memcpy(uy, fy.getUnit(), sizeof(fy));
	double fp_sqrT, fp_addT, fp_subT, fp_mulT;
	double fpDbl_addT, fpDbl_subT;
//	double fp_sqrPreT, fp_mulPreT, fp_modT;
//	double fp2_mulT, fp2_sqrT;
//	double fp_addNCT, fp_subNCT, fpDbl_addNCT,fpDbl_subNCT;
	CYBOZU_BENCH_T(fp_sqrT, op.fp_sqr, ux, ux);
	CYBOZU_BENCH_T(fp_addT, op.fp_add, ux, ux, ux);
	CYBOZU_BENCH_T(fp_subT, op.fp_sub, ux, uy, ux);
	CYBOZU_BENCH_T(fp_mulT, op.fp_mul, ux, ux, ux);
	CYBOZU_BENCH_T(fpDbl_addT, op.fpDbl_add, ux, ux, ux);
	CYBOZU_BENCH_T(fpDbl_subT, op.fpDbl_sub, ux, uy, ux);
	printf("%10s ", s);
	const double Ttbl[] = {
		fp_sqrT, fp_addT, fp_subT, fp_mulT,
		fpDbl_addT, fpDbl_subT,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(Ttbl); i++) {
		printf(" %8.2f", Ttbl[i]);
	}
	printf("\n");
}

int main()
{
	const char *tbl[] = {
		// N = 3
		"0x000000000000000100000000000000000000000000000033", // min prime
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d",
		"0xffffffffffffffffffffffffffffffffffffffffffffff13", // max prime

		// N = 4
		"0x0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const char *p = tbl[i];
		printf("prime=%s\n", p);
		benchRaw(tbl[i], mcl::fp::FP_GMP);
#ifdef MCL_USE_LLVM
		benchRaw(tbl[i], mcl::fp::FP_LLVM);
		benchRaw(tbl[i], mcl::fp::FP_LLVM_MONT);
#endif
#ifdef MCL_USE_XBYAK
		benchRaw(tbl[i], mcl::fp::FP_XBYAK);
#endif
	}
}

