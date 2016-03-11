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

void benchRaw(const char *p, mcl::fp::Mode mode)
{
	Fp::setModulo(p, 0, mode);
	Fp2::init(1);
	typedef mcl::fp::Unit Unit;
	const size_t maxN = sizeof(Fp) / sizeof(Unit);
	const mcl::fp::Op& op = Fp::getOp();
	cybozu::XorShift rg;
	Fp fx, fy;
	fx.setRand(rg);
	fy.setRand(rg);
	Unit ux[maxN * 2] = {};
	Unit uy[maxN * 2] = {};
	Unit uz[maxN * 2] = {};
	memcpy(ux, fx.getUnit(), sizeof(Unit) * op.N);
	memcpy(ux + op.N, fx.getUnit(), sizeof(Unit) * op.N);
	memcpy(uy, fy.getUnit(), sizeof(Unit) * op.N);
	memcpy(ux + op.N, fx.getUnit(), sizeof(Unit) * op.N);
	double fp_sqrT, fp_addT, fp_subT, fp_mulT;
	double fpDbl_addT, fpDbl_subT;
	double fpDbl_sqrPreT, fpDbl_mulPreT, fpDbl_modT;
	double fp2_sqrT, fp2_mulT, fp2_mul2T;
	CYBOZU_BENCH_T(fp_sqrT, op.fp_sqr, uz, ux);
	CYBOZU_BENCH_T(fp_addT, op.fp_add, uz, ux, uy);
	CYBOZU_BENCH_T(fp_subT, op.fp_sub, uz, uy, ux);
	CYBOZU_BENCH_T(fp_mulT, op.fp_mul, uz, ux, uy);
	CYBOZU_BENCH_T(fpDbl_addT, op.fpDbl_add, uz, ux, uy);
	CYBOZU_BENCH_T(fpDbl_subT, op.fpDbl_sub, uz, uy, ux);
	CYBOZU_BENCH_T(fpDbl_sqrPreT, op.fpDbl_sqrPre, uz, ux);
	CYBOZU_BENCH_T(fpDbl_mulPreT, op.fpDbl_mulPre, uz, ux, uy);
	CYBOZU_BENCH_T(fpDbl_modT, op.fpDbl_mod, uz, ux);
	Fp2 f2x, f2y;
	f2x.a = fx;
	f2x.b = fy;
	f2y = f2x;
	CYBOZU_BENCH_T(fp2_sqrT, Fp2::sqr, f2x, f2x);
	CYBOZU_BENCH_T(fp2_mulT, Fp2::mul, f2x, f2x, f2y);
	CYBOZU_BENCH_T(fp2_mul2T, Fp2::mul2, f2x, f2x, f2y);
	printf("%s\n", getModeStr(mode));
	const char *tStrTbl[] = {
		"fp_add", "fp_sub", "fp_sqr", "fp_mul",
		"D_add", "D_sub",
		"D_sqrPre", "D_mulPre", "D_mod",
		"fp2_sqr", "fp2_mul", "fp2_mul2",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tStrTbl); i++) {
		printf(" %8s", tStrTbl[i]);
	}
	printf("\n");
	const double tTbl[] = {
		fp_addT, fp_subT, fp_sqrT, fp_mulT,
		fpDbl_addT, fpDbl_subT,
		fpDbl_sqrPreT, fpDbl_mulPreT, fpDbl_modT,
		fp2_sqrT, fp2_mulT, fp2_mul2T,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tTbl); i++) {
		printf(" %8.2f", tTbl[i]);
	}
	printf("\n");
}

int main(int argc, char *argv[])
{
	cybozu::Option opt;
	size_t bitSize;
	opt.appendOpt(&bitSize, 0, "s", ": bitSize");
	opt.appendHelp("h", ": show this message");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	const char *tbl[] = {
		// N = 2
		"0x0000000000000001000000000000000d",
		"0x7fffffffffffffffffffffffffffffff",
		"0x8000000000000000000000000000001d",
		"0xffffffffffffffffffffffffffffff61",

		// N = 3
		"0x000000000000000100000000000000000000000000000033", // min prime
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d",
		"0xfffffffffffffffffffffffffffffffeffffffffffffffff",
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
		if (bitSize > 0 && (strlen(p) - 2) * 4 != bitSize) {
			continue;
		}
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

