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
	CYBOZU_BENCH("gmp   ", (MulPre<N, Gtag>::f), z, z, x);
	CYBOZU_BENCH("gmp-k ", (MulPre<N, Gtag>::karatsuba), z, z, x);
	CYBOZU_BENCH("llvm  ", (MulPre<N, Ltag>::f), z, z, x);
	CYBOZU_BENCH("llvm-k", (MulPre<N, Ltag>::karatsuba), z, z, x);
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

CYBOZU_TEST_AUTO(mulPre)
{
	cybozu::XorShift rg;
//	const char *p = "0x2523648240000001ba344d80000000086121000000000013a700000000000013";
//	const char *p = "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff";
//	Fp::init(p, mcl::fp::FP_LLVM);
//	const mcl::fp::Op& op = Fp::getOp();
	const size_t N = 10;
	Unit x[N], y[N], z[N * 2], w[N * 2];
	for (int i = 0; i < 10; i++) {
		rg.read(x, N);
		rg.read(y, N);
		mpn_mul_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
		MulPre<N, Gtag>::karatsuba(w, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, w, N * 2);
	}
}
