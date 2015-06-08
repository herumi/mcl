#include <cybozu/test.hpp>
#if CYBOZU_OS_BIT == 32
// not support
#else
#include <mcl/gmp_util.hpp>
#include <stdint.h>
#include <string>
#include <cybozu/itoa.hpp>
#include <mcl/fp.hpp>
#include <mcl/fp_generator.hpp>
#include <iostream>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

typedef mcl::FpT<> Fp;

const int MAX_N = 4;

const char *primeTable[] = {
	"7fffffffffffffffffffffffffffffff", // 127bit(not full)
	"ffffffffffffffffffffffffffffff61", // 128bit(full)
	"fffffffffffffffffffffffffffffffffffffffeffffee37", // 192bit(full)
	"2523648240000001ba344d80000000086121000000000013a700000000000013", // 254bit(not full)
};

/*
	p is output buffer
	pStr is hex
	return the size of p
*/
int convertToArray(uint64_t *p, const mpz_class& x)
{
	const int pn = int(sizeof(mp_limb_t) * x.get_mpz_t()->_mp_size / sizeof(*p));
	if (pn > MAX_N) {
		printf("pn(%d) is too large\n", pn);
		exit(1);
	}
	const uint64_t *q = (const uint64_t*)x.get_mpz_t()->_mp_d;
	std::copy(q, q + pn, p);
	std::fill(p + pn, p + MAX_N, 0);
	return pn;
}
int convertToArray(uint64_t *p, const char *pStr)
{
	mpz_class x;
	x.set_str(pStr, 16);
	return convertToArray(p, x);
}

struct Int {
	int vn;
	uint64_t v[MAX_N];
	Int()
		: vn(0)
	{
	}
	explicit Int(int vn)
	{
		if (vn > MAX_N) {
			printf("vn(%d) is too large\n", vn);
			exit(1);
		}
		this->vn = vn;
	}
	void set(const char *str) { fromStr(str); }
	void set(const Fp& rhs)
	{
		convertToArray(v, rhs.toGmp());
	}
	void set(const uint64_t* x)
	{
		for (int i = 0; i < vn; i++) v[i] = x[i];
	}
	void fromStr(const char *str)
	{
		convertToArray(v, str);
	}
	std::string toStr() const
	{
		std::string ret;
		for (int i = 0; i < vn; i++) {
			ret += cybozu::itohex(v[vn - 1 - i], false);
		}
		return ret;
	}
	void put(const char *msg = "") const
	{
		if (msg) printf("%s=", msg);
		printf("%s\n", toStr().c_str());
	}
	bool operator==(const Int& rhs) const
	{
		if (vn != rhs.vn) return false;
		for (int i = 0; i < vn; i++) {
			if (v[i] != rhs.v[i]) return false;
		}
		return true;
	}
	bool operator!=(const Int& rhs) const { return !operator==(rhs); }
	bool operator==(const Fp& rhs) const
	{
		Int t(vn);
		t.set(rhs);
		return operator==(t);
	}
	bool operator!=(const Fp& rhs) const { return !operator==(rhs); }
};
static inline std::ostream& operator<<(std::ostream& os, const Int& x)
{
	return os << x.toStr();
}

void testAddSub(const mcl::fp::FpGenerator& fg, int pn)
{
	Fp x, y;
	Int mx(pn), my(pn);
	x.fromStr("0x8811aabb23427cc");
	y.fromStr("0x8811aabb23427cc11");
	mx.set(x);
	my.set(y);
	for (int i = 0; i < 30; i++) {
		CYBOZU_TEST_EQUAL(mx, x);
		x += x;
		fg.add_(mx.v, mx.v, mx.v);
	}
	for (int i = 0; i < 30; i++) {
		CYBOZU_TEST_EQUAL(mx, x);
		x += y;
		fg.add_(mx.v, mx.v, my.v);
	}
	for (int i = 0; i < 30; i++) {
		CYBOZU_TEST_EQUAL(my, y);
		y -= x;
		fg.sub_(my.v, my.v, mx.v);
	}
}

void testNeg(const mcl::fp::FpGenerator& fg, int pn)
{
	Fp x;
	Int mx(pn), my(pn);
	const char *tbl[] = {
		"0",
		"0x12346",
		"0x11223344556677881122334455667788",
		"0x0abbccddeeffaabb0000000000000000",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		x.fromStr(tbl[i]);
		mx.set(x);
		x = -x;
		fg.neg_(mx.v, mx.v);
		CYBOZU_TEST_EQUAL(mx, x);
	}
}

void testMulI(const mcl::fp::FpGenerator& fg, int pn)
{
	cybozu::XorShift rg;
	for (int i = 0; i < 100; i++) {
		uint64_t x[MAX_N];
		uint64_t z[MAX_N + 1];
		rg.read(x, pn);
		uint64_t y = rg.get64();
		mpz_class mx;
		mcl::Gmp::setRaw(mx, x, pn);
		mpz_class my;
		mcl::Gmp::set(my, y);
		mx *= my;
		uint64_t d = fg.mulI_(z, x, y);
		z[pn] = d;
		mcl::Gmp::setRaw(my, z, pn + 1);
		CYBOZU_TEST_EQUAL(mx, my);
	}
	{
		uint64_t x[MAX_N];
		uint64_t z[MAX_N + 1];
		rg.read(x, pn);
		uint64_t y = rg.get64();
		CYBOZU_BENCH_C("mulI", 10000000, fg.mulI_, z, x, y);
	}
}

void testShr1(const mcl::fp::FpGenerator& fg, int pn)
{
	cybozu::XorShift rg;
	for (int i = 0; i < 100; i++) {
		uint64_t x[MAX_N];
		uint64_t z[MAX_N];
		rg.read(x, pn);
		mpz_class mx;
		mcl::Gmp::setRaw(mx, x, pn);
		mx >>= 1;
		fg.shr1_(z, x);
		mpz_class my;
		mcl::Gmp::setRaw(my, z, pn);
		CYBOZU_TEST_EQUAL(mx, my);
	}
}

void test(const char *pStr)
{
	Fp::setModulo(pStr, 16);
	uint64_t p[MAX_N];
	const int pn = convertToArray(p, pStr);
	printf("pn=%d\n", pn);
	mcl::fp::FpGenerator fg;
	fg.init(p, pn);
	testAddSub(fg, pn);
	testNeg(fg, pn);
	testMulI(fg, pn);
	testShr1(fg, pn);
}

CYBOZU_TEST_AUTO(all)
{
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(primeTable); i++) {
		printf("test prime i=%d\n", (int)i);
		test(primeTable[i]);
	}
}
#endif
