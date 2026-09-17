#include <mcl/invmod.hpp>
#include <mcl/gmp_util.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>

// the iteration count of the benchmark (raise it where the clock is coarse, e.g. wasm)
#ifndef INVMOD_BENCH_N
	#define INVMOD_BENCH_N 1000
#endif

// returns false if M does not fit in N units
template<int N>
bool invModInit(mcl::inv::InvModT<N>& im, const mpz_class& M)
{
	mcl::Unit uM[N];
	bool b;
	mcl::gmp::getArray(&b, uM, N, M);
	if (!b) return false;
	mcl::inv::init<N>(im, uM);
	return true;
}

// returns false if x does not fit in N units
template<int N>
bool invModExec(const mcl::inv::InvModT<N>& im, mpz_class& y, const mpz_class& x)
{
	mcl::Unit ux[N], uy[N];
	bool b;
	mcl::gmp::getArray(&b, ux, N, x);
	if (!b) return false;
	mcl::inv::exec<N>(im, uy, ux);
	mcl::gmp::setArray(&b, y, uy, N);
	return b;
}

template<int N>
void test(const char *Mstr)
{
	printf("p=%s\n", Mstr);
	mpz_class M;
	mcl::gmp::setStr(M, Mstr, 16);
	mcl::inv::InvModT<N> im;
	CYBOZU_TEST_ASSERT(invModInit(im, M));
	mpz_class x, y, z;
	x = 0;
	CYBOZU_TEST_ASSERT(invModExec(im, z, x));
	CYBOZU_TEST_EQUAL(z, 0);
	x = 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		invModExec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x++;
	}
	x = M - 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		invModExec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x--;
	}
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		invModExec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x = y + 1;
	}
	// random x in [0, M)
	cybozu::XorShift rg;
	for (int i = 0; i < 10000; i++) {
		mcl::Unit v[N];
		for (int j = 0; j < N; j++) v[j] = (mcl::Unit)rg.get64();
		mcl::gmp::setArray(x, v, N);
		x %= M;
		if (x == 0) continue;
		mcl::gmp::invMod(y, x, M);
		invModExec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
	}
	typedef mcl::Unit Unit;
	const Unit ff = Unit(-1);
	const Unit _80 = Unit(1) << (MCL_UNIT_BIT_SIZE-1);
	const Unit tbl[] = {
		ff, ff >> 1, _80, _80-1,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
			Unit v[2] = { tbl[i], tbl[j] };
			mcl::gmp::setArray(x, v, 2);
			if (x == 0) continue;
			mcl::gmp::invMod(y, x, M);
			invModExec(im, z, x);
			CYBOZU_TEST_EQUAL(y, z);
		}
	}
	// in place (Unit version)
	{
		Unit ux[N], uy[N];
		mcl::gmp::getArray(ux, N, x);
		mcl::inv::exec<N>(im, uy, ux);
		mcl::inv::exec<N>(im, ux, ux);
		CYBOZU_TEST_EQUAL_ARRAY(ux, uy, N);
	}
	// x (or M) does not fit in N units
	{
		mpz_class big = mpz_class(1) << (MCL_UNIT_BIT_SIZE * N);
		CYBOZU_TEST_ASSERT(!invModExec(im, z, big));
		mcl::inv::InvModT<N> im2;
		CYBOZU_TEST_ASSERT(!invModInit(im2, big + 1));
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("invMod", INVMOD_BENCH_N, x++;invModExec, im, x, x);
#endif
}

CYBOZU_TEST_AUTO(modinv)
{
	const char *tbl6[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
	};
	const char *tbl4[] = {
		"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		"2523648240000001ba344d8000000007ff9f800000000010a10000000000000d",
		"2523648240000001ba344d80000000086121000000000013a700000000000013",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		test<4 * 8 / MCL_SIZEOF_UNIT>(tbl4[i]); // N = 4 (64-bit units) or 8 (32-bit units)
	}
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		test<6 * 8 / MCL_SIZEOF_UNIT>(tbl6[i]); // N = 6 or 12
	}
}
