/*
	sudo cpufreq-set -c 0 -g performance
	mycl karatsuba.cpp -DMCL_USE_LLVM=1 ../lib/libmcl.a && ./a.out
*/
#include <stdio.h>
#include <mcl/fp.hpp>
#include <cybozu/xorshift.hpp>
#include "../src/fp_proto.hpp"
#ifdef MCL_USE_LLVM
#include "../src/fp_llvm.hpp"
#endif
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
	MulPre<8, Gtag>::f(z, x, y);
}
void gggLLVM(uint64_t *z, const uint64_t *x, const uint64_t *y)
{
	MulPre<8, Ltag>::f(z, x, y);
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

#ifdef MCL_USE_LLVM
	CYBOZU_BENCH("l:mulpre", (MulPreCore<N, Ltag>::f), z, z, x);
	CYBOZU_BENCH("l:kara  ", (MulPre<N, Ltag>::karatsuba), z, z, x);
#endif
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

