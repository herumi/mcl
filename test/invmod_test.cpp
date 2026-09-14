#include <mcl/invmod.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

#include <cybozu/xorshift.hpp>

// useTwos : the two's complement version (inv::twos) or the sign-magnitude one
template<int N>
void testSub(const mpz_class& M, bool useTwos)
{
	printf("useTwos=%d\n", useTwos);
	mcl::inv::InvModT<N> im;
	mcl::inv::init(im, M);
	CYBOZU_TEST_ASSERT(!useTwos || im.useTwos);
	im.useTwos = useTwos;
	mpz_class x, y, z;
	x = 0;
	mcl::inv::exec(im, z, x);
	CYBOZU_TEST_EQUAL(z, 0);
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
	// random x in [0, M)
	cybozu::XorShift rg;
	for (int i = 0; i < 10000; i++) {
		mcl::Unit v[N];
		for (int j = 0; j < N; j++) v[j] = (mcl::Unit)rg.get64();
		mcl::gmp::setArray(x, v, N);
		x %= M;
		if (x == 0) continue;
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
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
			mcl::inv::exec(im, z, x);
			CYBOZU_TEST_EQUAL(y, z);
		}
	}
#ifdef NDEBUG
	const char *msg = useTwos ? "invMod(twos)" : "invMod(sm)  ";
	CYBOZU_BENCH_C(msg, 1000, x++;mcl::inv::exec, im, x, x);
#endif
}

template<int N>
void test(const char *Mstr)
{
	printf("p=%s\n", Mstr);
	mpz_class M;
	mcl::gmp::setStr(M, Mstr, 16);
	mcl::inv::InvModT<N> im;
	mcl::inv::init(im, M);
	if (im.useTwos) testSub<N>(M, true);
	testSub<N>(M, false);
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
