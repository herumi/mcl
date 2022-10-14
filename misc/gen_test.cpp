#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/config.hpp>

#include <mcl/fp.hpp>
#define MCL_USE_LLVM
#include "../src/llvm_proto.hpp"

using namespace mcl;
using namespace mcl::fp;

typedef mcl::FpT<> Fp;

extern "C" {
void mclb_fp_add4(Unit *z, const Unit *x, const Unit *y, const Unit *p);
void mclb_fp_add6(Unit *z, const Unit *x, const Unit *y, const Unit *p);

void mclb_fp_addNF4(Unit *z, const Unit *x, const Unit *y, const Unit *p);
void mclb_fp_addNF6(Unit *z, const Unit *x, const Unit *y, const Unit *p);

void mclb_fp_sub4(Unit *z, const Unit *x, const Unit *y, const Unit *p);
void mclb_fp_sub6(Unit *z, const Unit *x, const Unit *y, const Unit *p);

void mclb_fp_subB4(Unit *z, const Unit *x, const Unit *y, const Unit *p);
void mclb_fp_subB6(Unit *z, const Unit *x, const Unit *y, const Unit *p);

}

bint::void_pppp get_fp_addA(size_t n)
{
	switch (n) {
	default: return 0;
	case 4: return mclb_fp_add4;
	case 6: return mclb_fp_add6;
	}
}

bint::void_pppp get_fp_addNFA(size_t n)
{
	switch (n) {
	default: return 0;
	case 4: return mclb_fp_addNF4;
	case 6: return mclb_fp_addNF6;
	}
}

bint::void_pppp get_fp_subA(size_t n)
{
	switch (n) {
	default: return 0;
	case 4: return mclb_fp_sub4;
	case 6: return mclb_fp_sub6;
	}
}

bint::void_pppp get_fp_subB(size_t n)
{
	switch (n) {
	default: return 0;
	case 4: return mclb_fp_subB4;
	case 6: return mclb_fp_subB6;
	}
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
	bool isNF = !Fp::getOp().isFullBit;
	bint::void_pppp addA = get_fp_addA(N);
	bint::void_pppp addL = get_llvm_fp_add(N);
	bint::void_pppp addNFA = get_fp_addNFA(N);
	bint::void_pppp addNFL = get_llvm_fp_addNF(N);
	bint::void_pppp subA = get_fp_subA(N);
	bint::void_pppp subB = get_fp_subB(N);
	bint::void_pppp subL = get_llvm_fp_sub(N);
	cybozu::XorShift rg;
	Fp fx, fy;
	Unit *x = const_cast<Unit*>(fx.getUnit());
	Unit *y = const_cast<Unit*>(fy.getUnit());
	Unit z1[N], z2[N];
	for (size_t i = 0; i < C; i++) {
		fx.setByCSPRNG(rg);
		fy.setByCSPRNG(rg);
		addA(z1, x, y, p);
		addL(z2, x, y, p);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
		subA(z1, z1, x, p);
		subL(z2, z2, x, p);
		CYBOZU_TEST_EQUAL_ARRAY(z1, y, N);
		CYBOZU_TEST_EQUAL_ARRAY(z2, y, N);
		subB(z1, z1, x, p);
		subL(z2, z2, x, p);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
		if (isNF) {
			bint::clearN(z1, N);
			bint::clearN(z2, N);
			addNFA(z1, x, y, p);
			addNFL(z2, x, y, p);
			CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
		}
	}
	puts("random");
	CYBOZU_BENCH_C("addA r", CC, addA, z1, z1, z1, p);
	CYBOZU_BENCH_C("addL r", CC, addL, z1, z1, z1, p);
	if (isNF) {
		puts("NF");
		CYBOZU_BENCH_C("addNFA r", CC, addNFA, z1, z1, z1, p);
		CYBOZU_BENCH_C("addNFL r", CC, addNFL, z1, z1, z1, p);
	}

	puts("0");
	bint::clearN(z2, N);
	CYBOZU_BENCH_C("addA 0", CC, addA, z1, z1, z2, p);
	CYBOZU_BENCH_C("addL 0", CC, addL, z1, z1, z2, p);
	if (isNF) {
		puts("NF");
		CYBOZU_BENCH_C("addNFA 0", CC, addNFA, z1, z1, z2, p);
		CYBOZU_BENCH_C("addNFL 0", CC, addNFL, z1, z1, z2, p);
	}

	puts("p-1");
	bint::copyN(z2, p, N);
	z2[0]--;
	CYBOZU_BENCH_C("addA m", CC, addA, z1, z1, z2, p);
	CYBOZU_BENCH_C("addL m", CC, addL, z1, z1, z2, p);
	if (isNF) {
		puts("NF");
		CYBOZU_BENCH_C("addNFA m", CC, addNFA, z1, z1, z2, p);
		CYBOZU_BENCH_C("addNFL m", CC, addNFL, z1, z1, z2, p);
	}
	puts("testFpSub");
	puts("random");
	CYBOZU_BENCH_C("subA r", CC, fx.setByCSPRNG(rg);subA, z1, z1, x, p);
	CYBOZU_BENCH_C("subB r", CC, fx.setByCSPRNG(rg);subB, z1, z1, x, p);
	CYBOZU_BENCH_C("subA r", CC, fx.setByCSPRNG(rg);subA, z1, z1, x, p);
	CYBOZU_BENCH_C("subL r", CC, fx.setByCSPRNG(rg);subL, z1, z1, x, p);
	puts("0");
	bint::clearN(z2, N);
	CYBOZU_BENCH_C("subA 0", CC, fx.setByCSPRNG(rg);subA, x, x, z2, p);
	CYBOZU_BENCH_C("subB 0", CC, fx.setByCSPRNG(rg);subB, x, x, z2, p);
	CYBOZU_BENCH_C("subL 0", CC, fx.setByCSPRNG(rg);subL, x, x, z2, p);
	puts("p-1");
	bint::copyN(z2, p, N);
	z2[0]--;
	CYBOZU_BENCH_C("subA m", CC, fx.setByCSPRNG(rg);subA, x, x, z2, p);
	CYBOZU_BENCH_C("subB m", CC, fx.setByCSPRNG(rg);subB, x, x, z2, p);
	CYBOZU_BENCH_C("subL m", CC, fx.setByCSPRNG(rg);subL, x, x, z2, p);
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

