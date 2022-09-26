#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/config.hpp>

#include <mcl/fp.hpp>
#include "../src/llvm_proto.hpp"

using namespace mcl;
using namespace mcl::fp;

typedef mcl::FpT<> Fp;

extern "C" {
void mclb_fp_add4(Unit *z, const Unit *x, const Unit *y, const Unit *p);

}

template<class RG>
void setRand(Unit *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = (Unit)rg.get64();
	}
}

template<class RG>
void setRandNF(Unit *x, size_t n, RG& rg)
{
	setRand(x, n, rg);
#if MCL_SIZEOF_UNIT == 4
	x[n - 1] &= 0x7fffffff;
#else
	x[n - 1] &= 0x7fffffffffffffffull;
#endif
}

void putHex(const char *msg, const Unit *x, size_t N)
{
	Vint t;
	t.setArray(x, N);
	printf("%s=0x%s\n", msg, t.getStr(16).c_str());
}

const size_t C = 100;
const int CC = 10000;

template<size_t N>
void testFpAdd(const char *pStr)
{
	printf("testFpAdd p=%s\n", pStr);
	Fp::init(pStr);
	const Unit *p = Fp::getOp().p;
	cybozu::XorShift rg;
	Fp fx, fy;
	const Unit *x = fx.getUnit();
	const Unit *y = fy.getUnit();
	Unit z1[N], z2[N];
	for (size_t i = 0; i < C; i++) {
		fx.setByCSPRNG(rg);
		fy.setByCSPRNG(rg);
		mclb_fp_add4(z1, x, y, p);
		mcl_fp_add4L(z2, x, y, p);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
	}
	CYBOZU_BENCH_C("asm ", CC, mclb_fp_add4, z1, z1, z1, p);
	CYBOZU_BENCH_C("llvm", CC, mcl_fp_add4L, z2, z2, z2, p);
}

CYBOZU_TEST_AUTO(add)
{
	const char *tbl4[] = {
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
		"0xffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551",
		"0xffffffff00000001000000000000000000000000ffffffffffffffffffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		testFpAdd<4>(tbl4[i]);
	}
}

