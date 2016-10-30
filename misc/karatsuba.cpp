/*
	sudo cpufreq-set -c 0 -g performance
	mycl karatsuba.cpp -DMCL_USE_LLVM=1 ../lib/libmcl.a && ./a.out
*/
#include <stdio.h>
#include <mcl/fp.hpp>
#include <cybozu/xorshift.hpp>
#include "../src/fp_proto.hpp"
#include "../src/fp_llvm.hpp"
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

typedef mcl::FpT<> Fp;

using namespace mcl::fp;

void dump(const Unit *x, size_t N)
{
	for (size_t i = 0; i < N; i++) {
		printf("%016llx ", (long long)x[N - 1 - i]);
	}
	printf("\n");
}

void gggKara(uint64_t *z, const uint64_t *x, const uint64_t *y)
{
	MulPre<6, Gtag>::karatsuba(z, x, y);
}
void gggLLVM(uint64_t *z, const uint64_t *x, const uint64_t *y)
{
	MulPre<6, Ltag>::f(z, x, y);
}

template<size_t N>
void benchKaratsuba()
{
	cybozu::XorShift rg;
	printf("N=%d\n", (int)N);
	Unit x[N], z[N * 2];
	rg.read(x, N);
	rg.read(z, N);
	CYBOZU_BENCH("g:mulpre", (MulPreCore<N, Gtag>::f), z, z, x);
	CYBOZU_BENCH("g:kara  ", (MulPre<N, Gtag>::karatsuba), z, z, x);

	CYBOZU_BENCH("l:mulpre", (MulPreCore<N, Ltag>::f), z, z, x);
	CYBOZU_BENCH("l:kara  ", (MulPre<N, Ltag>::karatsuba), z, z, x);
}

CYBOZU_TEST_AUTO(karatsuba)
{
	benchKaratsuba<4>();
	benchKaratsuba<6>();
	benchKaratsuba<8>();
#if MCL_MAX_BIT_SIZE == 768
	benchKaratsuba<10>();
	benchKaratsuba<12>();
#endif
}

#if 0
CYBOZU_TEST_AUTO(mulPre)
{
	cybozu::XorShift rg;
//	const char *p = "0x2523648240000001ba344d80000000086121000000000013a700000000000013";
//	const char *p = "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff";
//	const char *p = "4562440617622195218641171605700291324893228507248559930579192517899275167208677386505912811317371399778642309573594407310688704721375437998252661319722214188251994674360264950082874192246603471"; // 640 bit
	const char *p = "1552518092300708935148979488462502555256886017116696611139052038026050952686376886330878408828646477950487730697131073206171580044114814391444287275041181139204454976020849905550265285631598444825262999193716468750892846853816057031"; // 768 bit
	Fp::init(p, mcl::fp::FP_LLVM);
	const mcl::fp::Op& op = Fp::getOp();
	const size_t N = 12;
	Unit x[N], y[N];
	rg.read(x, N);
	rg.read(y, N);
	CYBOZU_BENCH("g:mul ", (Mul<N, Gtag>::f), y, y, x, op.p);
	CYBOZU_BENCH("g:mont", (Mont<N, Gtag>::f), y, y, x, op.p);
	CYBOZU_BENCH("l:mul ", (Mul<N, Ltag>::f), y, y, x, op.p);
	CYBOZU_BENCH("l:mont", (Mont<N, Ltag>::f), y, y, x, op.p);
}
#endif
