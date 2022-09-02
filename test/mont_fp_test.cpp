#define PUT(x) std::cout << #x "=" << (x) << std::endl
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <time.h>
#include <mcl/fp.hpp>
#include "../src/low_func.hpp"

typedef mcl::FpT<> Fp;

struct Montgomery {
	typedef mcl::Unit Unit;
	mpz_class p_;
	mpz_class R_; // (1 << (pn_ * 64)) % p
	mpz_class RR_; // (R * R) % p
	Unit rp_; // rp * p = -1 mod M = 1 << 64
	size_t pn_;
	Montgomery() {}
	explicit Montgomery(const mpz_class& p)
	{
		p_ = p;
		rp_ = mcl::fp::getMontgomeryCoeff(mcl::gmp::getUnit(p, 0));
		pn_ = mcl::gmp::getUnitSize(p);
		R_ = 1;
		R_ = (R_ << (pn_ * 64)) % p_;
		RR_ = (R_ * R_) % p_;
	}

	void toMont(mpz_class& x) const { mul(x, x, RR_); }
	void fromMont(mpz_class& x) const { mul(x, x, 1); }

	void mul(mpz_class& z, const mpz_class& x, const mpz_class& y) const
	{
#if 0
		const size_t ySize = mcl::gmp::getUnitSize(y);
		mpz_class c = x * mcl::gmp::getUnit(y, 0);
		Unit q = mcl::gmp::getUnit(c, 0) * rp_;
		c += p_ * q;
		c >>= sizeof(Unit) * 8;
		for (size_t i = 1; i < pn_; i++) {
			if (i < ySize) {
				c += x * mcl::gmp::getUnit(y, i);
			}
			Unit q = mcl::gmp::getUnit(c, 0) * rp_;
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
			Unit q = mcl::gmp::getUnit(z, 0) * rp_;
#ifdef MCL_USE_VINT
			z += p_ * q;
#else
			mpz_class t;
			mcl::gmp::set(t, q);
			z += p_ * t;
#endif
			z >>= sizeof(Unit) * 8;
		}
		if (z >= p_) {
			z -= p_;
		}
#endif
	}
	void mod(mpz_class& z, const mpz_class& xy) const
	{
		z = xy;
		for (size_t i = 0; i < pn_; i++) {
//printf("i=%zd\n", i);
//std::cout << "z=" << std::hex << z << std::endl;
			Unit q = mcl::gmp::getUnit(z, 0) * rp_;
//std::cout << "q=" << q << std::endl;
			mpz_class t;
			mcl::gmp::set(t, q);
			z += p_ * t;
			z >>= sizeof(Unit) * 8;
//std::cout << "z=" << std::hex << z << std::endl;
		}
		if (z >= p_) {
			z -= p_;
		}
//std::cout << "z=" << std::hex << z << std::endl;
	}
};

template<class T>
mpz_class getMpz(const T& x)
{
	std::string str = x.getStr();
	mpz_class t;
	mcl::gmp::setStr(t, str);
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

struct Test {
	void run(const char *p)
	{
		Fp::init(p);
		Fp x("-123456789");
		Fp y("-0x7ffffffff");
		CYBOZU_BENCH("add", operator+, x, x);
		CYBOZU_BENCH("sub", operator-, x, y);
		CYBOZU_BENCH("mul", operator*, x, x);
		CYBOZU_BENCH("sqr", Fp::sqr, x, x);
		CYBOZU_BENCH("div", y += x; operator/, x, y);
	}
};

#if MCL_MAX_BIT_SIZE >= 521
void customTest(const char *pStr, const char *xStr, const char *yStr)
{
	struct ZnTag;
	typedef mcl::FpT<ZnTag> Zn;
	std::string rOrg, rC, rAsm;
	Zn::init(pStr);
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
	Fp::init(pStr);
	Fp x(xStr), y(yStr);
	x *= y;
	rAsm = getStr(x);
	CYBOZU_TEST_EQUAL(rOrg, rC);
	CYBOZU_TEST_EQUAL(rOrg, rAsm);
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
#endif

CYBOZU_TEST_AUTO(test)
{
	Test test;
	const char *tbl[] = {
#if 1
		// N = 3
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
#endif

#if MCL_MAX_BIT_SIZE >= 384
		// N = 6
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
#endif

#if MCL_MAX_BIT_SIZE >= 521
		// N = 9
		"0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
#endif
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		printf("prime=%s\n", tbl[i]);
		test.run(tbl[i]);
	}
}
