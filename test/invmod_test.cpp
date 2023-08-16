#include <mcl/invmod.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

template<int N>
void test(const char *Mstr)
{
	printf("p=%s\n", Mstr);
	mpz_class M;
	mcl::gmp::setStr(M, Mstr, 16);
	mcl::inv::InvModT<N> im;
	mcl::inv::init(im, M);
	mpz_class x, y, z;
	x = 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x++;
	}
	x = M - 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x--;
	}
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x = y + 1;
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("invMod", 1000, x++;mcl::inv::exec, im, x, x);
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
		test<4>(tbl4[i]);
	}
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		test<6>(tbl6[i]);
	}
}
