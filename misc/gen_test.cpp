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
void mclb_fp_add6(Unit *z, const Unit *x, const Unit *y, const Unit *p);

}

// asm version
template<size_t N>
void fp_addA(Unit *z, const Unit *x, const Unit *y, const Unit *p);
template<size_t N>
void fp_addL(Unit *z, const Unit *x, const Unit *y, const Unit *p);

template<>
void fp_addA<4>(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	mclb_fp_add4(z, x, y, p);
}
template<>
void fp_addA<6>(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	mclb_fp_add6(z, x, y, p);
}

// llvm version
template<>
void fp_addL<4>(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	mcl_fp_add4L(z, x, y, p);
}
template<>
void fp_addL<6>(Unit *z, const Unit *x, const Unit *y, const Unit *p)
{
	mcl_fp_add6L(z, x, y, p);
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
		fp_addA<N>(z1, x, y, p);
		fp_addL<N>(z2, x, y, p);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
	}
	puts("random");
	CYBOZU_BENCH_C("asm ", CC, fp_addA<N>, z1, z1, z1, p);
	CYBOZU_BENCH_C("llvm", CC, fp_addL<N>, z1, z1, z1, p);

	puts("1");
	bint::clearN(z2, N);
	z2[0]++;
	CYBOZU_BENCH_C("asm ", CC, fp_addA<N>, z1, z1, z2, p);
	CYBOZU_BENCH_C("llvm", CC, fp_addL<N>, z1, z1, z2, p);

	puts("p-1");
	bint::copyN(z2, p, N);
	z2[0]--;
	CYBOZU_BENCH_C("asm ", CC, fp_addA<N>, z1, z1, z2, p);
	CYBOZU_BENCH_C("llvm", CC, fp_addL<N>, z1, z1, z2, p);
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
	const char *tbl6[] = {
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		testFpAdd<6>(tbl6[i]);
	}
}

