#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <mcl/fp.hpp>

typedef mcl::FpT<> Fp;

void benchFpSub(const char *pStr, const char *xStr, const char *yStr, mcl::fp::Mode mode)
{
	const char *s;
	switch (mode) {
	case mcl::fp::FP_GMP: s = "gmp"; break;
	case mcl::fp::FP_LLVM: s = "llvm"; break;
	case mcl::fp::FP_LLVM_MONT: s = "llvm+mont"; break;
	case mcl::fp::FP_XBYAK: s = "xbyak"; break;
	default: throw cybozu::Exception("benchFpSub:bad mode") << mode;
	}
	Fp::setModulo(pStr, 0, mode);
	Fp x(xStr);
	Fp y(yStr);

	double addT, subT, mulT, invT;
	CYBOZU_BENCH_T(addT, Fp::add, x, x, x);
	CYBOZU_BENCH_T(subT, Fp::sub, x, x, y);
	CYBOZU_BENCH_T(mulT, Fp::mul, x, x, x);
	CYBOZU_BENCH_T(invT, x += y;Fp::inv, x, x); // avoid same jmp
	printf("%10s bit % 3d add %8.2f sub %8.2f mul %8.2f inv %8.2f\n", s, (int)Fp::getBitSize(), addT, subT, mulT, invT);
}

void benchFp(size_t bitSize, int mode)
{
	const struct {
		size_t bitSize;
		const char *p;
		const char *x;
		const char *y;
	} tbl[] = {
		{
			192,
			"0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d",
			"0x148094810948190412345678901234567900342423332197",
			"0x7fffffffffffffffffffffe26f2fc170f69466a74defd8d",
		},
		{
			256,
			"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
			"0x1480948109481904123456789234234242423424201234567900342423332197",
			"0x151342342342341517fffffffffffffffffffffe26f2fc170f69466a74defd8d",
		},
		{
			384,
			"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
			"0x19481084109481094820948209482094820984290482212345678901234567900342308472047204720422423332197",
			"0x209348209481094820984209842094820948204204243123456789012345679003423084720472047204224233321972",
			
		},
		{
			521,
			"0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
			"0x2908209582095820941098410948109482094820984209840294829049240294242498540975555312345678901234567900342308472047204720422423332197",
			"0x3948384209834029834092384204920349820948205872380573205782385729385729385723985837ffffffffffffffffffffffe26f2fc170f69466a74defd8d",

		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		if (bitSize != 0 && tbl[i].bitSize != bitSize) continue;
		if (mode & (1 << 0)) benchFpSub(tbl[i].p, tbl[i].x, tbl[i].y, mcl::fp::FP_GMP);
#ifdef MCL_USE_LLVM
		if (mode & (1 << 1)) benchFpSub(tbl[i].p, tbl[i].x, tbl[i].y, mcl::fp::FP_LLVM);
		if (mode & (1 << 2)) benchFpSub(tbl[i].p, tbl[i].x, tbl[i].y, mcl::fp::FP_LLVM_MONT);
#endif
#ifdef MCL_USE_XBYAK
		if (mode & (1 << 3)) benchFpSub(tbl[i].p, tbl[i].x, tbl[i].y, mcl::fp::FP_XBYAK);
#endif
	}
}

void benchEc(size_t, int)
{
}

int main(int argc, char *argv[])
	try
{
	size_t bitSize;
	int mode;
	bool ecOnly;
	bool fpOnly;
	cybozu::Option opt;
	opt.appendOpt(&bitSize, 0, "b", ": bitSize");
	opt.appendOpt(&mode, 0, "m", ": mode(0:all, sum of 1:gmp, 2:llvm, 8:llvm+mont, 8:xbyak");
	opt.appendBoolOpt(&ecOnly, "ec", ": ec only");
	opt.appendBoolOpt(&fpOnly, "fp", ": fp only");
	opt.appendHelp("h", ": show this message");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		exit(1);
	}
	if (mode < 0 || mode > 15) {
		printf("bad mode %d\n", mode);
		opt.usage();
		exit(1);
	}
	if (mode == 0) mode = 15;
	if (!ecOnly) benchFp(bitSize, mode);
	if (!fpOnly) benchEc(bitSize, mode);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
}

