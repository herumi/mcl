#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <mcl/fp.hpp>
#include <mcl/conversion.hpp>
#include <mcl/ecparam.hpp>

typedef mcl::FpT<> Fp;
struct tagZn;
typedef mcl::FpT<tagZn> Zn;
typedef mcl::EcT<Fp> Ec;

const char *getModeStr(mcl::fp::Mode mode)
{
	switch (mode) {
	case mcl::fp::FP_GMP: return "gmp";
	case mcl::fp::FP_LLVM: return "llvm";
	case mcl::fp::FP_LLVM_MONT: return "llvm+mont";
	case mcl::fp::FP_XBYAK: return "xbyak";
	default: throw cybozu::Exception("benchFpSub:bad mode") << mode;
	}
}
void benchFpSub(const char *pStr, const char *xStr, const char *yStr, mcl::fp::Mode mode)
{
	const char *s = getModeStr(mode);
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

void benchEcSub(const mcl::EcParam& para, mcl::fp::Mode mode)
{
	Fp::setModulo(para.p, 0, mode);
	Zn::setModulo(para.n);
	Ec::setParam(para.a, para.b);
	Fp x(para.gx);
	Fp y(para.gy);
	Ec P(x, y);
	Ec Q = P + P + P;
	double addT, subT, dblT, mulT;
	CYBOZU_BENCH_T(addT, Ec::add, Q, P, Q);
	CYBOZU_BENCH_T(subT, Ec::sub, Q, P, Q);
	CYBOZU_BENCH_T(dblT, Ec::dbl, P, P);
	Zn z("-3");
	CYBOZU_BENCH_T(mulT, Ec::mul, P, P, z);
	printf("%10s %10s add %8.2f sub %8.2f dbl %8.2f mul %8.2f\n", para.name, getModeStr(mode), addT, subT, dblT, mulT);

}
void benchEc(size_t bitSize, int mode)
{
	const struct mcl::EcParam tbl[] = {
		mcl::ecparam::secp160k1,
		mcl::ecparam::secp192k1,
		mcl::ecparam::NIST_P192,
		mcl::ecparam::secp224k1,
		mcl::ecparam::secp256k1,
		mcl::ecparam::NIST_P224,
		mcl::ecparam::NIST_P256,
//		mcl::ecparam::secp384r1,
		mcl::ecparam::NIST_P384,
//		mcl::ecparam::secp521r1,
		mcl::ecparam::NIST_P521,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		if (bitSize != 0 && tbl[i].bitSize != bitSize) continue;
		if (mode & (1 << 0)) benchEcSub(tbl[i], mcl::fp::FP_GMP);
#ifdef MCL_USE_LLVM
		if (mode & (1 << 1)) benchEcSub(tbl[i], mcl::fp::FP_LLVM);
		if (mode & (1 << 2)) benchEcSub(tbl[i], mcl::fp::FP_LLVM_MONT);
#endif
#ifdef MCL_USE_XBYAK
		if (mode & (1 << 3)) benchEcSub(tbl[i], mcl::fp::FP_XBYAK);
#endif
	}
}

void benchToStr16()
{
	puts("benchToStr16");
	const char *tbl[] = {
		"0x0",
		"0x5",
		"0x123",
		"0x123456789012345679adbc",
		"0xffffffff26f2fc170f69466a74defd8d",
		"0x100000000000000000000000000000033",
		"0x11ee12312312940000000000000000000000000002342343"
	};
	Fp::setModulo("0xffffffffffffffffffffffffffffffffffffffffffffff13");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str;
		Fp x(tbl[i]);
		CYBOZU_BENCH("fp::toStr16", mcl::fp::toStr16, str, x.getUnit(), x.getUnitSize(), 16);
		mpz_class y(tbl[i]);
		CYBOZU_BENCH("Gmp:getStr ", mcl::Gmp::getStr, str, y, 16);
	}
}

void benchFromStr16()
{
	puts("benchFromStr16");
	const char *tbl[] = {
		"0",
		"5",
		"123",
		"123456789012345679adbc",
		"ffffffff26f2fc170f69466a74defd8d",
		"100000000000000000000000000000033",
		"11ee12312312940000000000000000000000000002342343"
	};
	Fp::setModulo("0xffffffffffffffffffffffffffffffffffffffffffffff13");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str = tbl[i];
		Fp x;
		const size_t N = 64;
		mcl::fp::Unit buf[N];
		CYBOZU_BENCH("fp:fromStr16", mcl::fp::fromStr16, buf, N, str.c_str(), str.size());

		mpz_class y;
		CYBOZU_BENCH("Gmp:setStr  ", mcl::Gmp::setStr, y, str, 16);
	}
}

int main(int argc, char *argv[])
	try
{
	size_t bitSize;
	int mode;
	bool ecOnly;
	bool fpOnly;
	bool misc;
	cybozu::Option opt;
	opt.appendOpt(&bitSize, 0, "b", ": bitSize");
	opt.appendOpt(&mode, 0, "m", ": mode(0:all, sum of 1:gmp, 2:llvm, 8:llvm+mont, 8:xbyak");
	opt.appendBoolOpt(&ecOnly, "ec", ": ec only");
	opt.appendBoolOpt(&fpOnly, "fp", ": fp only");
	opt.appendBoolOpt(&misc, "misc", ": other benchmark");
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
	if (misc) {
		benchToStr16();
		benchFromStr16();
	} else {
		if (!ecOnly) benchFp(bitSize, mode);
		if (!fpOnly) benchEc(bitSize, mode);
	}
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
}

