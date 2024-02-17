/*
	make clean && make MCL_USE_OMP=1 -j bin/mt_test.exe CFLAGS_USER=-DCYBOZU_BENCH_USE_GETTIMEOFDAY
	bin/mt_test.exe -n 2000
*/
#include <cybozu/benchmark.hpp>
#include <mcl/bls12_381.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/option.hpp>

using namespace mcl::bls12;

int main(int argc, char *argv[])
	try
{
	cybozu::Option opt;
	size_t n;
	int bit;
	size_t cpuN;
	bool g1only;
	int C;
	opt.appendOpt(&n, 100, "n");
	opt.appendOpt(&cpuN, 0, "cpu");
	opt.appendOpt(&C, 50, "c");
	opt.appendOpt(&bit, 0, "b");
	opt.appendBoolOpt(&g1only, "g1");
	opt.appendHelp("h");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	if (bit) n = 1u << bit;
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
	G1 P1, P2;
	CYBOZU_BENCH_C("single", C, G1::mulVec, P1, Pvec.data(), xVec.data(), n);
	if (g1only) return 0;
	CYBOZU_BENCH_C("multi ", C, G1::mulVecMT, P2, Pvec.data(), xVec.data(), n, cpuN);
	printf("G1 ret %s\n", P1 == P2 ? "ok" : "ng");
	G2 Q1, Q2;
	CYBOZU_BENCH_C("single", C, G2::mulVec, Q1, Qvec.data(), xVec.data(), n);
	CYBOZU_BENCH_C("multi ", C, G2::mulVecMT, Q2, Qvec.data(), xVec.data(), n, cpuN);
	printf("G2 ret %s\n", Q1 == Q2 ? "ok" : "ng");
	Fp12 e1, e2;
	CYBOZU_BENCH_C("single", C, millerLoopVec, e1, Pvec.data(), Qvec.data(), n);
	CYBOZU_BENCH_C("multi ", C, millerLoopVecMT, e2, Pvec.data(), Qvec.data(), n, cpuN);
	printf("GT ret %s\n", e1 == e2 ? "ok" : "ng");
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return 1;
}
