#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <time.h>
#include <mcl/fp.hpp>
#include <mcl/fp_tower.hpp>
struct FpTag;
typedef mcl::FpT<FpTag, 256> Fp;
typedef mcl::Fp2T<Fp> Fp2;

void testFp2()
{
	puts(__FUNCTION__);
	const int xi_c = 1;
	Fp2::init(xi_c);
	Fp2 x, y, z;
	x.a = 1;
	x.b = 2;
	y.a = 3;
	y.b = 4;
	/*
		x = 1 + 2u
		y = 3 + 4u
	*/
	Fp2::add(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp2(4, 6));
	Fp2::sub(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp2(-2, -2));
	Fp2::mul(z, x, y);
	/*
		(1 + 2u)(3 + 4u) = (3 - 8) + (4 + 6)u = -5 + 10u
	*/
	CYBOZU_TEST_EQUAL(z, Fp2(-5, 10));
	Fp2::neg(z, z);
	CYBOZU_TEST_EQUAL(z, Fp2(5, -10));
	z = x * x;
	Fp2::sqr(y, x);
	CYBOZU_TEST_EQUAL(z, y);
	x.a = -123456789;
	x.b = 464652165165;
	y = x * x;
	Fp2::sqr(x, x);
	CYBOZU_TEST_EQUAL(x, y);
	{
		std::ostringstream oss;
		oss << x;
		std::istringstream iss(oss.str());
		Fp2 w;
		iss >> w;
		CYBOZU_TEST_EQUAL(x, w);
	}
	y = x;
	Fp2::inv(y, x);
	y *= x;
	CYBOZU_TEST_EQUAL(y, 1);
}

void test(const char *p)
{
	printf("prime=%s\n", p);
	Fp::setModulo(p);
	testFp2();
}
#if 0
void benchFp2()
{
	Fp2 x, y;
	x.a.set("4");
	x.b.set("464652165165");
	y = x * x;
	CYBOZU_BENCH("Fp2::add     ", Fp2::add, x, x, y);
	CYBOZU_BENCH("Fp2::addNC   ", Fp2::addNC, x, x, y);
	CYBOZU_BENCH("Fp2::sub     ", Fp2::sub, x, x, y);
	CYBOZU_BENCH("Fp2::neg     ", Fp2::neg, x, x);
	CYBOZU_BENCH("Fp2::mul     ", Fp2::mul, x, x, y);
	CYBOZU_BENCH("Fp2::inverse ", x.inverse);
	CYBOZU_BENCH("Fp2::square  ", Fp2::square, x, x);
	CYBOZU_BENCH("Fp2::mul_xi  ", Fp2::mul_xi, x, x);
	CYBOZU_BENCH("Fp2::mul_Fp_0", Fp2::mul_Fp_0, x, x, Param::half);
	CYBOZU_BENCH("Fp2::mul_Fp_1", Fp2::mul_Fp_1, x, Param::half);
	CYBOZU_BENCH("Fp2::divBy2  ", Fp2::divBy2, x, x);
	CYBOZU_BENCH("Fp2::divBy4  ", Fp2::divBy4, x, x);
}
#endif

CYBOZU_TEST_AUTO(test)
{
	const char *tbl[] = {
		// N = 3
		"0x000000000000000100000000000000000000000000000033", // min prime
		"0x00000000fffffffffffffffffffffffffffffffeffffac73",
		"0x0000000100000000000000000001b8fa16dfab9aca16b6b3",
		"0x000000010000000000000000000000000000000000000007",
		"0x30000000000000000000000000000000000000000000002b",
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffffffffffffffffffeffffee37",
		"0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d",
		"0xffffffffffffffffffffffffffffffffffffffffffffff13", // max prime

		// N = 4
		"0x0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		test(tbl[i]);
	}
}

