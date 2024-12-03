/*
	make clean && make MCL_USE_OMP=1 -j bin/mt_test.exe CFLAGS_USER=-DCYBOZU_BENCH_USE_GETTIMEOFDAY
	bin/mt_test.exe -n 2000
*/
#include <cybozu/benchmark.hpp>
#include <mcl/bls12_381.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/option.hpp>

using namespace mcl::bls12;

void mulVec_naive(G1& P, const G1 *x, const Fr *y, size_t n)
{
	G1::mul(P, x[0], y[0]);
	for (size_t i = 1; i < n; i++) {
		G1 T;
		G1::mul(T, x[i], y[i]);
		P += T;
	}
}

//#define USE_CLK
#ifdef USE_CLK
extern cybozu::CpuClock clk0;
extern cybozu::CpuClock clk1;
extern cybozu::CpuClock clk2;
extern cybozu::CpuClock clk3;
extern cybozu::CpuClock clk4;
#endif
inline size_t argminForMulVecAVX512(size_t n)
{
	if (n <= 2) return 2;
	size_t log2n = mcl::ec::ilog2(n);
	const size_t tblMin = 7;
	if (log2n < tblMin) return 4;
	// n >= 2^tblMin
	static const size_t tbl[] = {
		4, 5, 5, 6, 7, 8, 8, 10, 10, 10, 10, 10, 13, 15, 15, 16, 16, 16, 16, 16
	};
	if (log2n >= CYBOZU_NUM_OF_ARRAY(tbl)) return 16;
	size_t ret = tbl[log2n - tblMin];
	return ret;
}

int main(int argc, char *argv[])
	try
{
	cybozu::Option opt;
	size_t n;
	int bit;
	size_t cpuN;
	bool g1only;
	bool msmOnly;
	int C;
	opt.appendOpt(&n, 100, "n", ": array size");
	opt.appendOpt(&bit, 0, "b", ": set n to 1<<b");
	opt.appendOpt(&cpuN, 0, "cpu", ": # of cpu for OpenMP");
	opt.appendOpt(&C, 50, "c", ": count of loop");
	opt.appendBoolOpt(&g1only, "g1", ": benchmark for G1 only");
	opt.appendBoolOpt(&msmOnly, "msm", ": msm bench");
	opt.appendHelp("h", ": show this message");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	if (bit) n = size_t(1) << bit;
	printf("n=%zd cpuN=%zd C=%d\n", n, cpuN, C);

	initPairing(mcl::BLS12_381);
	cybozu::XorShift rg;
	std::vector<G1> Pvec(n);
	std::vector<G2> Qvec(n);
	std::vector<Fr> xVec(n);
	hashAndMapToG1(Pvec[0], "abc", 3);
	hashAndMapToG2(Qvec[0], "abc", 3);
	for (size_t i = 1; i < n; i++) {
		G1::add(Pvec[i], Pvec[i-1], Pvec[0]);
		G2::add(Qvec[i], Qvec[i-1], Qvec[0]);
	}
	for (size_t i = 0; i < n; i++) {
		xVec[i].setByCSPRNG(rg);
	}
	G1 P1, P2;
#ifdef MCL_MSM
	if (msmOnly) {
		for (size_t nn = 1u<<9; nn <= n; nn *= 2) {
			printf("% 8zd", nn);
			CYBOZU_BENCH_C(" ", C, G1::mulVec, P1, Pvec.data(), xVec.data(), nn);
			fflush(stdout);
#ifdef USE_CLK
printf("getCount g=%d %d %d %d %d %d %d\n", clk.getCount(), clk0.getCount(), clk1.getCount(), clk2.getCount(), clk3.getCount(), clk4.getCount(), clk5.getCount());
			clk0.put("clk0"); clk0.clear();
			clk1.put("clk1"); clk1.clear();
			clk2.put("clk2"); clk2.clear();
			clk3.put("clk3"); clk3.clear();
			clk4.put("clk4"); clk4.clear();
#endif
		}
		return 0;
	}
#endif
	CYBOZU_BENCH_C("G1 single", C, G1::mulVec, P1, Pvec.data(), xVec.data(), n);
	if (n < 1024) {
		CYBOZU_BENCH_C("naive", C, mulVec_naive, P2, Pvec.data(), xVec.data(), n);
		if (P1 != P2) puts("G1::mulVec err");
	}
	if (g1only) return 0;
	P2.clear();
	CYBOZU_BENCH_C("G1 multi ", C, G1::mulVecMT, P2, Pvec.data(), xVec.data(), n, cpuN);
	if (P1 != P2) puts("G1::mulVecMT err");
	CYBOZU_BENCH_C("G1 mulEach", C, G1::mulEach, Pvec.data(), xVec.data(), n);
	G2 Q1, Q2;
	CYBOZU_BENCH_C("G2 single", C, G2::mulVec, Q1, Qvec.data(), xVec.data(), n);
	CYBOZU_BENCH_C("G2 multi ", C, G2::mulVecMT, Q2, Qvec.data(), xVec.data(), n, cpuN);
	if (Q1 != Q2) puts("G2::mulVecMT err");
	Fp12 e1, e2;
	CYBOZU_BENCH_C("ML single", 10, millerLoopVec, e1, Pvec.data(), Qvec.data(), n);
	CYBOZU_BENCH_C("ML multi ", 10, millerLoopVecMT, e2, Pvec.data(), Qvec.data(), n, cpuN);
	if (e1 != e2) puts("millerLoopVec err");
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return 1;
}
