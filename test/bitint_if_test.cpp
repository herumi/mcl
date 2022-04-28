#include <mcl/bitint_if.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <iostream>
#include <cybozu/benchmark.hpp>
#include <mcl/gmp_util.hpp>

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

using namespace mcl::gmp;

typedef mcl::Unit Unit;

template<class RG>
void setRand(Unit *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = (Unit)rg.get64();
	}
}
CYBOZU_TEST_AUTO(divFullBitT)
{
	const size_t xN = 7;
	const size_t yN = 4;
	const size_t qN = xN - yN + 1;
	Unit x[xN], y[yN], q[qN];
	cybozu::XorShift rg;
	mpz_class mx, my, mq, mr;
	for (int i = 0; i < 100; i++) {
		setRand(x, xN, rg);
		setRand(y, yN, rg);
		y[yN - 1] |= Unit(1) << (sizeof(Unit) * 8 - 1); // full bit
		setArray(mx, x, xN);
		setArray(my, y, yN);
		assert(yN == 4);
		size_t rn = mcl::bint::divFullBit4(q, qN, x, xN, y);
		setArray(mq, q, qN);
		setArray(mr, x, rn);
		CYBOZU_TEST_EQUAL(mq * my + mr, mx);
	}
	const int C = 1000;
	CYBOZU_BENCH_C("gmp", C, mcl::gmp::divmod, mq, mr, mx, my);
	CYBOZU_BENCH_C("myC", C, mcl::bint::divFullBit4, q, qN, x, xN, y);
}
