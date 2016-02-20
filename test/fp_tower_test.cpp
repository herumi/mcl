#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <time.h>
#include <mcl/fp.hpp>
#include <mcl/fp_tower.hpp>

typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::BnT<Fp> bn;
typedef bn::Fp2 Fp2;
typedef bn::FpDbl FpDbl;

void testFp2()
{
	puts(__FUNCTION__);
	const int xi_c = 9;
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
	/*
		xi = 9 + u
		(1 - 2u)(9 + u) = (9 + 2) + (1 - 18)u = 11 - 17u
	*/
	z = Fp2(1, -2);
	Fp2::mul_xi(z, z);
	CYBOZU_TEST_EQUAL(z, Fp2(11, -17));
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

void testFpDbl()
{
	puts(__FUNCTION__);
	{
		std::string pstr;
		Fp::getModulo(pstr);
		mpz_class mp(pstr);
		mp <<= Fp::getUnitSize() * mcl::fp::UnitBitSize;
		mpz_class mp1 = mp - 1;
		mcl::Gmp::getStr(pstr, mp1);
		const char *tbl[] = {
			"0", "1", "123456", "123456789012345668909", pstr.c_str(),
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			mpz_class mx(tbl[i]), my;
			FpDbl x;
			x.setMpz(mx);
			x.getMpz(my);
			CYBOZU_TEST_EQUAL(mx, my);
			for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
				FpDbl y, z;
				mpz_class mz, mo;
				my = tbl[j];
				y.setMpz(my);
				FpDbl::add(z, x, y);
				mcl::Gmp::addMod(mo, mx, my, mp);
				z.getMpz(mz);
				CYBOZU_TEST_EQUAL(mz, mo);
				mcl::Gmp::subMod(mo, mx, my, mp);
				FpDbl::sub(z, x, y);
				z.getMpz(mz);
				CYBOZU_TEST_EQUAL(mz, mo);
			}
		}
	}
}

void test(const char *p, mcl::fp::Mode mode)
{
	Fp::setModulo(p, 0, mode);
	testFp2();
	if (Fp::getBitSize() <= 256) {
		testFpDbl();
	}
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
		const char *p = tbl[i];
		printf("prime=%s\n", p);
		test(tbl[i], mcl::fp::FP_GMP);
#ifdef MCL_USE_LLVM
		test(tbl[i], mcl::fp::FP_LLVM);
		test(tbl[i], mcl::fp::FP_LLVM_MONT);
#endif
#ifdef MCL_USE_XBYAK
		test(tbl[i], mcl::fp::FP_XBYAK);
#endif
	}
}

