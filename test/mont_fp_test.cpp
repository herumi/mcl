#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <time.h>

#ifndef USE_MONT_FP
	#define USE_MONT_FP
#endif
#include <mcl/fp.hpp>
typedef mcl::FpT<> Zn;
typedef mcl::FpT<> MontFp3;
typedef mcl::FpT<> MontFp4;
typedef mcl::FpT<> MontFp6;
typedef mcl::FpT<> MontFp9;

struct Montgomery {
	typedef mcl::Gmp::Unit Unit;
	mpz_class p_;
	mpz_class R_; // (1 << (pn_ * 64)) % p
	mpz_class RR_; // (R * R) % p
	Unit pp_; // p * pp = -1 mod M = 1 << 64
	size_t pn_;
	Montgomery() {}
	explicit Montgomery(const mpz_class& p)
	{
		p_ = p;
		pp_ = mcl::fp::getMontgomeryCoeff(mcl::Gmp::getUnit(p, 0));
		pn_ = mcl::Gmp::getUnitSize(p);
		R_ = 1;
		R_ = (R_ << (pn_ * 64)) % p_;
		RR_ = (R_ * R_) % p_;
	}

	void toMont(mpz_class& x) const { mul(x, x, RR_); }
	void fromMont(mpz_class& x) const { mul(x, x, 1); }

	void mul(mpz_class& z, const mpz_class& x, const mpz_class& y) const
	{
#if 0
		const size_t ySize = mcl::Gmp::getUnitSize(y);
		mpz_class c = x * mcl::Gmp::getUnit(y, 0);
		Unit q = mcl::Gmp::getUnit(c, 0) * pp_;
		c += p_ * q;
		c >>= sizeof(Unit) * 8;
		for (size_t i = 1; i < pn_; i++) {
			if (i < ySize) {
				c += x * mcl::Gmp::getUnit(y, i);
			}
			Unit q = mcl::Gmp::getUnit(c, 0) * pp_;
			c += p_ * q;
			c >>= sizeof(Unit) * 8;
		}
		if (c >= p_) {
			c -= p_;
		}
		z = c;
#else
		z = x * y;
		for (size_t i = 0; i < pn_; i++) {
			Unit q = mcl::Gmp::getUnit(z, 0) * pp_;
			z += p_ * (mp_limb_t)q;
			z >>= sizeof(Unit) * 8;
		}
		if (z >= p_) {
			z -= p_;
		}
#endif
	}
};

template<class T>
mpz_class getMpz(const T& x)
{
	std::string str = x.getStr();
	mpz_class t;
	mcl::Gmp::setStr(t, str);
	return t;
}

template<class T>
std::string getStr(const T& x)
{
	std::ostringstream os;
	os << x;
	return os.str();
}

template<class T, class U>
T castTo(const U& x)
{
	T t;
	t.setStr(getStr(x));
	return t;
}

template<class T>
void putRaw(const T& x)
{
	const uint64_t *p = x.getInnerValue();
	for (size_t i = 0, n = T::BlockSize; i < n; i++) {
		printf("%016llx", p[n - 1 - i]);
	}
	printf("\n");
}

template<size_t N>
void put(const uint64_t (&x)[N])
{
	for (size_t i = 0; i < N; i++) {
		printf("%016llx", x[N - 1 - i]);
	}
	printf("\n");
}

template<size_t N>
struct Test {
	typedef mcl::FpT<> Fp;
	mpz_class m;
	void run(const char *p)
	{
		Fp::setModulo(p);
		m = p;
		Zn::setModulo(p);
		edge();
		cstr();
		getStr();
		setStr();
		stream();
		conv();
		compare();
		modulo();
		ope();
		power();
		power_Zn();
		setArray();
		set64bit();
		bench();
	}
	void cstr()
	{
		const struct {
			const char *str;
			int val;
		} tbl[] = {
			{ "0", 0 },
			{ "1", 1 },
			{ "123", 123 },
			{ "0x123", 0x123 },
			{ "0b10101", 21 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			// string cstr
			Fp x(tbl[i].str);
			CYBOZU_TEST_EQUAL(x, tbl[i].val);

			// int cstr
			Fp y(tbl[i].val);
			CYBOZU_TEST_EQUAL(y, x);

			// copy cstr
			Fp z(x);
			CYBOZU_TEST_EQUAL(z, x);

			// assign int
			Fp w;
			w = tbl[i].val;
			CYBOZU_TEST_EQUAL(w, x);

			// assign self
			Fp u;
			u = w;
			CYBOZU_TEST_EQUAL(u, x);

			// conv
			std::ostringstream os;
			os << tbl[i].val;

			std::string str;
			x.getStr(str);
			CYBOZU_TEST_EQUAL(str, os.str());
		}
		const struct {
			const char *str;
			int val;
		} tbl2[] = {
			{ "-123", 123 },
			{ "-0x123", 0x123 },
			{ "-0b10101", 21 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl2); i++) {
			Fp x(tbl2[i].str);
			x = -x;
			CYBOZU_TEST_EQUAL(x, tbl2[i].val);
		}
	}
	void getStr()
	{
		Fp x(0);
		std::string str;
		str = x.getStr();
		CYBOZU_TEST_EQUAL(str, "0");
		str = x.getStr(2, true);
		CYBOZU_TEST_EQUAL(str, "0b0");
		str = x.getStr(2, false);
		CYBOZU_TEST_EQUAL(str, "0");
		str = x.getStr(16, true);
		CYBOZU_TEST_EQUAL(str, "0x0");
		str = x.getStr(16, false);
		CYBOZU_TEST_EQUAL(str, "0");

		x = 123;
		str = x.getStr();
		CYBOZU_TEST_EQUAL(str, "123");
		str = x.getStr(2, true);
		CYBOZU_TEST_EQUAL(str, "0b1111011");
		str = x.getStr(2, false);
		CYBOZU_TEST_EQUAL(str, "1111011");
		str = x.getStr(16, true);
		CYBOZU_TEST_EQUAL(str, "0x7b");
		str = x.getStr(16, false);
		CYBOZU_TEST_EQUAL(str, "7b");

		{
			std::ostringstream os;
			os << x;
			CYBOZU_TEST_EQUAL(os.str(), "123");
		}
		{
			std::ostringstream os;
			os << std::hex << std::showbase << x;
			CYBOZU_TEST_EQUAL(os.str(), "0x7b");
		}
		{
			std::ostringstream os;
			os << std::hex << x;
			CYBOZU_TEST_EQUAL(os.str(), "7b");
		}
	}

	void setStr()
	{
		const struct {
			const char *in;
			int out;
			int base;
		} tbl[] = {
			{ "100", 100, 0 }, // set base = 10 if base = 0
			{ "100", 4, 2 },
			{ "100", 256, 16 },
			{ "0b100", 4, 0 },
			{ "0b100", 4, 2 },
			{ "0x100", 256, 0 },
			{ "0x100", 256, 16 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			Fp x;
			x.setStr(tbl[i].in, tbl[i].base);
			CYBOZU_TEST_EQUAL(x, tbl[i].out);
		}
		// conflict prefix with base
		Fp x;
		CYBOZU_TEST_EXCEPTION(x.setStr("0b100", 16), cybozu::Exception);
		CYBOZU_TEST_EXCEPTION(x.setStr("0x100", 2), cybozu::Exception);
	}

	void stream()
	{
		const struct {
			const char *in;
			int out10;
			int out16;
		} tbl[] = {
			{ "100", 100, 256 }, // set base = 10 if base = 0
			{ "0x100", 256, 256 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			{
				std::istringstream is(tbl[i].in);
				Fp x;
				is >> x;
				CYBOZU_TEST_EQUAL(x, tbl[i].out10);
			}
			{
				std::istringstream is(tbl[i].in);
				Fp x;
				is >> std::hex >> x;
				CYBOZU_TEST_EQUAL(x, tbl[i].out16);
			}
		}
		std::istringstream is("0b100");
		Fp x;
		CYBOZU_TEST_EXCEPTION(is >> std::hex >> x, cybozu::Exception);
	}
	void edge()
	{
#if 0
		std::cout << std::hex;
		/*
			real mont
			   0    0
			   1    R^-1
			   R    1
			  -1    -R^-1
			  -R    -1
		*/
		mpz_class t = 1;
		const mpz_class R = (t << (N * 64)) % m;
		const mpz_class tbl[] = {
			0, 1, R, m - 1, m - R
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			const mpz_class& x = tbl[i];
			for (size_t j = i; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
				const mpz_class& y = tbl[j];
				mpz_class z = (x * y) % m;
				Fp xx, yy;
				Fp::toMont(xx, x);
				Fp::toMont(yy, y);
				Fp zz = xx * yy;
				mpz_class t;
				Fp::fromMont(t, zz);
				CYBOZU_TEST_EQUAL(z, t);
			}
		}
		std::cout << std::dec;
#endif
	}

	void conv()
	{
		const char *bin = "0b100100011010001010110011110001001000000010010001101000101011001111000100100000001001000110100010101100111100010010000";
		const char *hex = "0x123456789012345678901234567890";
		const char *dec = "94522879687365475552814062743484560";
		Fp b(bin);
		Fp h(hex);
		Fp d(dec);
		CYBOZU_TEST_EQUAL(b, h);
		CYBOZU_TEST_EQUAL(b, d);

		std::string str;
		b.getStr(str, 2, true);
		CYBOZU_TEST_EQUAL(str, bin);
		b.getStr(str);
		CYBOZU_TEST_EQUAL(str, dec);
		b.getStr(str, 16, true);
		CYBOZU_TEST_EQUAL(str, hex);
	}

	void compare()
	{
		const struct {
			int lhs;
			int rhs;
			int cmp;
		} tbl[] = {
			{ 0, 0, 0 },
			{ 1, 0, 1 },
			{ 0, 1, -1 },
			{ -1, 0, 1 }, // m-1, 0
			{ 0, -1, -1 }, // 0, m-1
			{ 123, 456, -1 },
			{ 456, 123, 1 },
			{ 5, 5, 0 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			const Fp x(tbl[i].lhs);
			const Fp y(tbl[i].rhs);
			const int cmp = tbl[i].cmp;
			if (cmp == 0) {
				CYBOZU_TEST_EQUAL(x, y);
			} else {
				CYBOZU_TEST_ASSERT(x != y);
			}
		}
	}

	void modulo()
	{
		std::ostringstream ms;
		ms << m;

		std::string str;
		Fp::getModulo(str);
		CYBOZU_TEST_EQUAL(str, ms.str());
	}

	void ope()
	{
		const struct {
			Zn x;
			Zn y;
			Zn add; // x + y
			Zn sub; // x - y
			Zn mul; // x * y
			Zn sqr; // x * x
		} tbl[] = {
			{ 0, 1, 1, -1, 0, 0 },
			{ 9, 7, 16, 2, 63, 81 },
			{ 10, 13, 23, -3, 130, 100 },
			{ 2000, -1000, 1000, 3000, -2000000, 4000000 },
			{ -12345, -9999, -(12345 + 9999), - 12345 + 9999, 12345 * 9999, 12345 * 12345 },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			const Fp x(castTo<Fp>(tbl[i].x));
			const Fp y(castTo<Fp>(tbl[i].y));
			Fp z;
			Fp::add(z, x, y);
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].add));
			Fp::sub(z, x, y);
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].sub));
			Fp::mul(z, x, y);
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].mul));

			Fp r;
			Fp::inv(r, y);
			Zn rr = 1 / tbl[i].y;
			CYBOZU_TEST_EQUAL(r, castTo<Fp>(rr));
			Fp::mul(z, z, r);
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].x));

			z = x + y;
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].add));
			z = x - y;
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].sub));
			z = x * y;
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].mul));
			Fp::square(z, x);
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].sqr));

			z = x / y;
			z *= y;
			CYBOZU_TEST_EQUAL(z, castTo<Fp>(tbl[i].x));
		}
	}
	void power()
	{
		Fp x, y, z;
		x = 12345;
		z = 1;
		for (int i = 0; i < 100; i++) {
			Fp::power(y, x, i);
			CYBOZU_TEST_EQUAL(y, z);
			z *= x;
		}
	}

	void power_Zn()
	{
		Fp x, y, z;
		x = 12345;
		z = 1;
		for (int i = 0; i < 100; i++) {
			Fp::power(y, x, Zn(i));
			CYBOZU_TEST_EQUAL(y, z);
			z *= x;
		}
	}

	void setArray()
	{
		// QQQ
#if 0
		char b1[] = { 0x56, 0x34, 0x12 };
		Fp x;
		x.setArray(b1, 3);
		CYBOZU_TEST_EQUAL(x, 0x123456);
		int b2[] = { 0x12, 0x34 };
		x.setArray(b2, 2);
		CYBOZU_TEST_EQUAL(x, Fp("0x3400000012"));
#endif
	}

	void set64bit()
	{
		const struct {
			const char *p;
			int64_t i;
		} tbl[] = {
			{ "0x1234567812345678", uint64_t(0x1234567812345678ull) },
			{ "0x1234567812345678", int64_t(0x1234567812345678ll) },
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			Fp x(tbl[i].p);
			Fp y(tbl[i].i);
			if (tbl[i].i < 0) x = -x;
			CYBOZU_TEST_EQUAL(x, y);
		}
	}
	void bench()
	{
		Fp x("-123456789");
		Fp y("-0x7ffffffff");
		CYBOZU_BENCH("add", operator+, x, x);
		CYBOZU_BENCH("sub", operator-, x, y);
		CYBOZU_BENCH("mul", operator*, x, x);
		CYBOZU_BENCH("sqr", Fp::square, x, x);
		CYBOZU_BENCH("div", y += x; operator/, x, y);
	}
};

void customTest(const char *pStr, const char *xStr, const char *yStr)
{
#if 0
	{
		pStr = "0xfffffffffffffffffffffffffffffffffffffffeffffee37",
		MontFp3::setModulo(pStr);
		static uint64_t x[3] = { 1, 0, 0 };
		uint64_t z[3];
std::cout<<std::hex;
		MontFp3::inv(*(MontFp3*)z, *(const MontFp3*)x);
put(z);
		exit(1);
	}
#endif
#if 0
	std::cout << std::hex;
	uint64_t x[9] = { 0xff7fffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0x1ff };
	uint64_t y[9] = { 0xff7fffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0x1ff };
	uint64_t z1[9], z2[9];
	MontFp9::setModulo(pStr);
	MontFp9::fg_.mul_(z2, x, y);
	put(z2);
	{
		puts("C");
		mpz_class p(pStr);
		Montgomery mont(p);
		mpz_class xx, yy;
		mcl::Gmp::setArray(xx, x, CYBOZU_NUM_OF_ARRAY(x));
		mcl::Gmp::setArray(yy, y, CYBOZU_NUM_OF_ARRAY(y));
		mpz_class z;
		mont.mul(z, xx, yy);
		std::cout << std::hex << z << std::endl;
	}
	exit(1);
#else
	std::string rOrg, rC, rAsm;
	Zn::setModulo(pStr);
	Zn s(xStr), t(yStr);
	s *= t;
	rOrg = getStr(s);
	{
		puts("C");
		mpz_class p(pStr);
		Montgomery mont(p);
		mpz_class x(xStr), y(yStr);
		mont.toMont(x);
		mont.toMont(y);
		mpz_class z;
		mont.mul(z, x, y);
		mont.fromMont(z);
		rC = getStr(z);
	}

	puts("asm");
	MontFp9::setModulo(pStr);
	MontFp9 x(xStr), y(yStr);
	x *= y;
	rAsm = getStr(x);
	CYBOZU_TEST_EQUAL(rOrg, rC);
	CYBOZU_TEST_EQUAL(rOrg, rAsm);
#endif
}

CYBOZU_TEST_AUTO(customTest)
{
	const struct {
		const char *p;
		const char *x;
		const char *y;
	} tbl[] = {
		{
			"0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
//			"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
//			"0xfffffffffffffffffffffffffffffffffffffffeffffee37",
			"0x1fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe",
			"0x1fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe"
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		customTest(tbl[i].p, tbl[i].x, tbl[i].y);
	}
}

CYBOZU_TEST_AUTO(test3)
{
	Test<3> test;
	const char *tbl[] = {
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
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("prime=%s\n", tbl[i]);
		test.run(tbl[i]);
	}
}

CYBOZU_TEST_AUTO(test4)
{
	Test<4> test;
	const char *tbl[] = {
		"0x0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"0x2523648240000001ba344d80000000086121000000000013a700000000000013",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("prime=%s\n", tbl[i]);
		test.run(tbl[i]);
	}
}

CYBOZU_TEST_AUTO(test6)
{
	Test<6> test;
	const char *tbl[] = {
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("prime=%s\n", tbl[i]);
		test.run(tbl[i]);
	}
}

CYBOZU_TEST_AUTO(test9)
{
	Test<9> test;
	const char *tbl[] = {
		"0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("prime=%s\n", tbl[i]);
		test.run(tbl[i]);
	}
}

CYBOZU_TEST_AUTO(toStr16)
{
	const char *tbl[] = {
		"0x0",
		"0x5",
		"0x123",
		"0x123456789012345679adbc",
		"0xffffffff26f2fc170f69466a74defd8d",
		"0x100000000000000000000000000000033",
		"0x11ee12312312940000000000000000000000000002342343"
	};
	MontFp3::setModulo("0xffffffffffffffffffffffffffffffffffffffffffffff13");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str, str2;
		MontFp3 x(tbl[i]);
		x.getStr(str, 16);
		mpz_class y(tbl[i]);
		mcl::Gmp::getStr(str2, y, 16);
		CYBOZU_TEST_EQUAL(str, str2);
	}
}

#if 0
CYBOZU_TEST_AUTO(toStr16bench)
{
	const char *tbl[] = {
		"0x0",
		"0x5",
		"0x123",
		"0x123456789012345679adbc",
		"0xffffffff26f2fc170f69466a74defd8d",
		"0x100000000000000000000000000000033",
		"0x11ee12312312940000000000000000000000000002342343"
	};
	const int C = 500000;
	MontFp3::setModulo("0xffffffffffffffffffffffffffffffffffffffffffffff13");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str, str2;
		MontFp3 x(tbl[i]);
		CYBOZU_BENCH_C("Mont:getStr", C, x.getStr, str, 16);
		mpz_class y(tbl[i]);
		CYBOZU_BENCH_C("Gmp:getStr ", C, mcl::Gmp::getStr, str2, y, 16);
		str2.insert(0, "0x");
		CYBOZU_TEST_EQUAL(str, str2);
	}
}

CYBOZU_TEST_AUTO(fromStr16bench)
{
	const char *tbl[] = {
		"0x0",
		"0x5",
		"0x123",
		"0x123456789012345679adbc",
		"0xffffffff26f2fc170f69466a74defd8d",
		"0x100000000000000000000000000000033",
		"0x11ee12312312940000000000000000000000000002342343"
	};
	const int C = 500000;
	MontFp3::setModulo("0xffffffffffffffffffffffffffffffffffffffffffffff13");
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		std::string str = tbl[i];
		MontFp3 x;
		CYBOZU_BENCH_C("Mont:setStr", C, x.setStr, str);

		mpz_class y;
		str.erase(0, 2);
		CYBOZU_BENCH_C("Gmp:setStr ", C, mcl::Gmp::setStr, y, str, 16);
		x.getStr(str, 16);
		std::string str2;
		mcl::Gmp::getStr(str2, y, 16);
		str2.insert(0, "0x");
		CYBOZU_TEST_EQUAL(str, str2);
	}
}
#endif
