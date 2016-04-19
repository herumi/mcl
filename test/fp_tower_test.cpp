#define PUT(x) std::cout << #x "=" << (x) << std::endl
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <time.h>
#include <mcl/fp.hpp>
#include <mcl/fp_tower.hpp>

typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::Fp2T<Fp> Fp2;
typedef mcl::FpDblT<Fp> FpDbl;
typedef mcl::Fp6T<Fp> Fp6;
typedef mcl::Fp12T<Fp> Fp12;

bool g_benchOnly = false;

void testFp2()
{
	puts(__FUNCTION__);
	CYBOZU_TEST_EQUAL(sizeof(Fp), 32);
	CYBOZU_TEST_EQUAL(sizeof(Fp2), 32 * 2);
	CYBOZU_TEST_EQUAL(sizeof(Fp6), 32 * 6);
	CYBOZU_TEST_EQUAL(sizeof(Fp12), 32 * 12);
	Fp2 x, y, z;
	x.a = 1;
	x.b = 2;

	{
		std::stringstream os;
		os << x;
		os >> y;
		CYBOZU_TEST_EQUAL(x, y);
	}
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
	Fp2::mulXi(z, z);
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
	y = 1;
	for (int i = 0; i < 10; i++) {
		Fp2::power(z, x, i);
		CYBOZU_TEST_EQUAL(z, y);
		y *= x;
	}
	/*
		(a + bi)^p = a + bi if p % 4 = 1
		(a + bi)^p = a - bi if p % 4 = 3
	*/
	{
		const mpz_class& mp = Fp::getOp().mp;
		y = x;
		Fp2::power(z, y, mp);
		if ((mp % 4) == 3) {
			Fp::neg(z.b, z.b);
		}
		CYBOZU_TEST_EQUAL(z, y);
	}
	y = x;
	Fp2::inv(y, x);
	y *= x;
	CYBOZU_TEST_EQUAL(y, 1);
}

void testFp6sqr(const Fp2& a, const Fp2& b, const Fp2& c, const Fp6& x)
{
	Fp2 t;
	t = b * c * 2;
	Fp2::mulXi(t, t);
	t += a * a;
	CYBOZU_TEST_EQUAL(x.a, t);
	t = c * c;
	Fp2::mulXi(t, t);
	t += a * b * 2;
	CYBOZU_TEST_EQUAL(x.b, t);
	t = b * b + a * c * 2;
	CYBOZU_TEST_EQUAL(x.c, t);
}

void testFp6()
{
	puts(__FUNCTION__);
	Fp2 a(1, 2), b(3, 4), c(5, 6);
	Fp6 x(a, b, c);
	Fp6 y(Fp2(-1, 1), Fp2(4, -3), Fp2(-6, 2));
	Fp6 z, w;
	{
		std::stringstream ss;
		ss << x;
		ss >> z;
		CYBOZU_TEST_EQUAL(x, z);
	}
	Fp6::add(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp6(Fp2(0, 3), Fp2(7, 1), Fp2(-1, 8)));
	Fp6::sub(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp6(Fp2(2, 1), Fp2(-1, 7), Fp2(11, 4)));
	Fp6::neg(z, x);
	CYBOZU_TEST_EQUAL(z, Fp6(-a, -b, -c));
	Fp6::sqr(z, x);
	Fp6::mul(w, x, x);
	testFp6sqr(a, b, c, z);
	testFp6sqr(a, b, c, w);
	z = x;
	Fp6::sqr(z, z);
	Fp6::mul(w, x, x);
	testFp6sqr(a, b, c, z);
	testFp6sqr(a, b, c, w);
	for (int i = 0; i < 10; i++) {
		Fp6::inv(y, x);
		Fp6::mul(z, y, x);
		CYBOZU_TEST_EQUAL(z, 1);
		x += y;
		y = x;
		Fp6::inv(y, y);
		y *= x;
		CYBOZU_TEST_EQUAL(y, 1);
	}
}

void testFp12()
{
	puts(__FUNCTION__);
	Fp6 xa(Fp2(1, 2), Fp2(3, 4), Fp2(5, 6));
	Fp6 xb(Fp2(3, 1), Fp2(6, -1), Fp2(-2, 5));
	Fp12 x(xa, xb);
	Fp6 ya(Fp2(2, 1), Fp2(5, 3), Fp2(4, 1));
	Fp6 yb(Fp2(1, -3), Fp2(2, -1), Fp2(-3, 1));
	Fp12 y(ya, yb);
	Fp12 z;
	Fp12::add(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp12(Fp6(Fp2(3, 3), Fp2(8, 7), Fp2(9, 7)), Fp6(Fp2(4, -2), Fp2(8, -2), Fp2(-5, 6))));
	Fp12::sub(z, x, y);
	CYBOZU_TEST_EQUAL(z, Fp12(Fp6(Fp2(-1, 1), Fp2(-2, 1), Fp2(1, 5)), Fp6(Fp2(2, 4), Fp2(4, 0), Fp2(1, 4))));
	Fp12::neg(z, x);
	CYBOZU_TEST_EQUAL(z, Fp12(-xa, -xb));

	y.b.clear();
	z = y;
	Fp12::sqr(z, z);
	CYBOZU_TEST_EQUAL(z.a, y.a * y.a);
	z = y * y;
	CYBOZU_TEST_EQUAL(z.a, y.a * y.a);
	CYBOZU_TEST_ASSERT(z.b.isZero());
	Fp12 w;
	y = x;
	z = x * x;
	w = x;
	Fp12::sqr(w, w);
	CYBOZU_TEST_EQUAL(z, w);
	y = x;
	y *= y;
	Fp12::sqr(x, x);
	CYBOZU_TEST_EQUAL(x, y);
	for (int i = 0; i < 10; i++) {
		w = x;
		Fp12::inv(w, w);
		Fp12::mul(y, w, x);
		CYBOZU_TEST_EQUAL(y, 1);
		x += y;
	}
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
			mpz_class mx(tbl[i]);
			FpDbl x;
			x.setMpz(mx);
			for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
				FpDbl y, z;
				mpz_class mz, mo;
				mpz_class my(tbl[j]);
				y.setMpz(my);
				FpDbl::add(z, x, y);
				mcl::Gmp::addMod(mo, mx, my, mp);
				z.getMpz(mz);
				CYBOZU_TEST_EQUAL(mz, mo);
				mcl::Gmp::subMod(mo, mx, my, mp);
				FpDbl::sub(z, x, y);
				z.getMpz(mz);
				CYBOZU_TEST_EQUAL(mz, mo);
				if (!Fp::isFullBit()) {
					FpDbl::addNC(z, x, y);
					mo = mx + my;
					z.getMpz(mz);
					CYBOZU_TEST_EQUAL(mz, mo);
					if (mx >= my) {
						FpDbl::subNC(z, x, y);
						mo = mx - my;
						z.getMpz(mz);
						CYBOZU_TEST_EQUAL(mz, mo);
					}
				}
			}
		}
	}
	{
		std::string pstr;
		Fp::getModulo(pstr);
		const mpz_class mp(pstr);
		cybozu::XorShift rg;
		for (int i = 0; i < 3; i++) {
			Fp x, y, z;
			mpz_class mx, my, mz, mo;
			x.setRand(rg);
			y.setRand(rg);
			x.getMpz(mx);
			y.getMpz(my);
			FpDbl d;
			FpDbl::mulPre(d, x, y);
			d.getMpz(mz);
			{
				Fp tx, ty;
				tx = x;
				ty = y;
				tx.toMont();
				ty.toMont();
				mpz_class mtx, mty;
				tx.getMpz(mtx);
				ty.getMpz(mty);
				mo = mtx * mty;
			}
			CYBOZU_TEST_EQUAL(mz, mo);

			FpDbl::mod(z, d);
			z.getMpz(mz);
			mo = (mx * my) % mp;
			CYBOZU_TEST_EQUAL(mz, mo);
			CYBOZU_TEST_EQUAL(z, x * y);

			FpDbl::sqrPre(d, x);
			d.getMpz(mz);
			{
				Fp tx;
				tx = x;
				tx.toMont();
				mpz_class mtx;
				tx.getMpz(mtx);
				mo = mtx * mtx;
			}
			CYBOZU_TEST_EQUAL(mz, mo);

			FpDbl::mod(z, d);
			z.getMpz(mz);
			mo = (mx * mx) % mp;
			CYBOZU_TEST_EQUAL(mz, mo);
			CYBOZU_TEST_EQUAL(z, x * x);
		}
	}
}

void benchFp2()
{
	puts(__FUNCTION__);
	Fp2 x, y;
	x.a.setStr("4");
	x.b.setStr("464652165165");
	y = x * x;
	double addT, subT, mulT, sqrT, invT, mulXiT;
	CYBOZU_BENCH_T(addT,    Fp2::add, x, x, y);
	CYBOZU_BENCH_T(subT,    Fp2::sub, x, x, y);
	CYBOZU_BENCH_T(mulT,    Fp2::mul, x, x, y);
	CYBOZU_BENCH_T(sqrT,    Fp2::sqr, x, x);
	CYBOZU_BENCH_T(invT,    Fp2::inv, x, x);
	CYBOZU_BENCH_T(mulXiT, Fp2::mulXi, x, x);
//	CYBOZU_BENCH("Fp2::mul_Fp_0", Fp2::mul_Fp_0, x, x, Param::half);
//	CYBOZU_BENCH("Fp2::mul_Fp_1", Fp2::mul_Fp_1, x, Param::half);
//	CYBOZU_BENCH("Fp2::divBy2  ", Fp2::divBy2, x, x);
//	CYBOZU_BENCH("Fp2::divBy4  ", Fp2::divBy4, x, x);
	printf("add %8.2f|sub %8.2f|mul %8.2f|sqr %8.2f|inv %8.2f|mulXi %8.2f\n", addT, subT, mulT, sqrT, invT, mulXiT);
}

void test(const char *p, mcl::fp::Mode mode)
{
	Fp::setModulo(p, 0, mode);
	printf("mode=%s\n", mcl::fp::ModeToStr(mode));
	const int xi_a = 9;
	Fp2::init(xi_a);
	if (Fp::getBitSize() > 256) {
		printf("not support p=%s\n", p);
		return;
	}
	if (g_benchOnly) {
		benchFp2();
		return;
	}
	testFp2();
	testFpDbl();
	testFp6();
	testFp12();
}

void testAll()
{
	const char *tbl[] = {
		// N = 2
		"0x0000000000000001000000000000000d",
		"0x7fffffffffffffffffffffffffffffff",
		"0x8000000000000000000000000000001d",
		"0xffffffffffffffffffffffffffffff61",

		// N = 3
		"0x000000000000000100000000000000000000000000000033", // min prime
		"0x00000000fffffffffffffffffffffffffffffffeffffac73",
		"0x0000000100000000000000000001b8fa16dfab9aca16b6b3",
		"0x000000010000000000000000000000000000000000000007",
		"0x30000000000000000000000000000000000000000000002b",
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffffffffffeffffffffffffffff",
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
		printf("prime=%s %d\n", p, (int)(strlen(p) - 2) * 4);
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

CYBOZU_TEST_AUTO(testAll)
{
	testAll();
}

int main(int argc, char *argv[])
{
	if (argc > 1 && strcmp(argv[1], "-bench") == 0) {
		g_benchOnly = true;
	}
	if (g_benchOnly) {
		testAll();
		return 0;
	} else {
		return cybozu::test::autoRun.run(argc, argv);
	}
}
