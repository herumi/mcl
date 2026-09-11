#include <mcl/bls12_381.hpp>
#include <mcl/gmp_util.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>

#define PUT(x) std::cout << #x << "=" << x << std::endl;

using namespace mcl;
/*
	Barrett Reduction
	for non GMP version
	mod of GMP is faster than ModpOld
*/
struct ModpOld {
	static const size_t unitBitSize = sizeof(mcl::Unit) * 8;
	mpz_class p_;
	mpz_class u_;
	mpz_class a_;
	size_t pBitSize_;
	size_t N_;
	bool initU_; // Is u_ initialized?
	ModpOld()
		: pBitSize_(0)
		, N_(0)
		, initU_(false)
	{
	}
	// x &= 1 << (unitBitSize * unitSize)
	void shrinkSize(mpz_class &x, size_t unitSize) const
	{
		size_t u = gmp::getUnitSize(x);
		if (u < unitSize) return;
		bool b;
		gmp::setArray(&b, x, gmp::getUnit(x), unitSize);
		(void)b;
		assert(b);
	}
	// p_ is set by p and compute (u_, a_) if possible
	void init(const mpz_class& p)
	{
		p_ = p;
		pBitSize_ = gmp::getBitSize(p);
		N_ = (pBitSize_ + unitBitSize - 1) / unitBitSize;
		initU_ = false;
#if 0
		u_ = (mpz_class(1) << (unitBitSize * 2 * N_)) / p_;
#else
		/*
			1 << (unitBitSize * 2 * N_) may be overflow,
			so use (1 << (unitBitSize * 2 * N_)) - 1 because u_ is same.
		*/
		uint8_t buf[48 * 2];
		const size_t byteSize = unitBitSize / 8 * 2 * N_;
		if (byteSize > sizeof(buf)) return;
		memset(buf, 0xff, byteSize);
		bool b;
		gmp::setArray(&b, u_, buf, byteSize);
		if (!b) return;
#endif
		u_ /= p_;
		a_ = mpz_class(1) << (unitBitSize * (N_ + 1));
		initU_ = true;
	}
	void modp(mpz_class& r, const mpz_class& t) const
	{
		if (t < p_) {
			r = t;
			return;
		}
		assert(p_ > 0);
		const size_t tBitSize = gmp::getBitSize(t);
		// use gmp::mod if init() fails or t is too large
		if (tBitSize > pBitSize_ + unitBitSize * N_ - 1 || !initU_) {
			gmp::mod(r, t, p_);
			return;
		}
		if (tBitSize < pBitSize_) {
			r = t;
			return;
		}
		// mod is faster than modp if t is small
		if (tBitSize <= unitBitSize * N_) {
			gmp::mod(r, t, p_);
			return;
		}
		mpz_class q;
		q = t;
		q >>= unitBitSize * (N_ - 1);
		q *= u_;
		q >>= unitBitSize * (N_ + 1);
		q *= p_;
		shrinkSize(q, N_ + 1);
		r = t;
		shrinkSize(r, N_ + 1);
		r -= q;
		if (r < 0) {
			r += a_;
		}
		if (r >= p_) {
			r -= p_;
		}
	}
};


namespace mcl { namespace bint {

/*
	SmallModP was removed from bint.hpp on 2026-09-10 (Fp::mulUnit uses Modp::mulUnitMod now).
	It is kept here for reference and for comparing with Modp::modp1.
	x[xn] % p for x < p 2^14 by a 16-bit approximate quotient (no 2-unit multiplication)
*/
struct SmallModP {
	static const size_t d = 16; // d = 26 if use double in approx
	static const size_t MAX_MUL_N = 1; // not used because mulSmallUnit is call at first.
	static const size_t maxE_ = d - 2;
	const Unit *p_;
	Unit tbl_[MAX_MUL_N][MCL_MAX_UNIT_SIZE+1];
	size_t n_;
	size_t l_;
	uint32_t p0_;

	SmallModP()
		: n_(0)
		, l_(0)
		, p0_(0)
	{
	}
	// p must not be temporary.
	void init(const Unit *p, size_t n)
	{
		p_ = p;
		n_ = n;
		l_ = mcl::fp::getBitSize(p, n);
		Unit *t = (Unit*)CYBOZU_ALLOCA((n_+1)*sizeof(Unit));
		mcl::bint::clearN(t, n_+1);
		size_t pos = d + l_ - 1;
		{
			size_t q = pos / MCL_UNIT_BIT_SIZE;
			size_t r = pos % MCL_UNIT_BIT_SIZE;
			t[q] = Unit(1) << r;
		}
		// p0 = 2**(d+l-1)/p
		Unit q[2];
		mcl::bint::div(q, 2, t, n_+1, p, n_);
		assert(q[1] == 0);
		p0_ = uint32_t(q[0]);
		for (size_t i = 0; i < MAX_MUL_N; i++) {
			tbl_[i][n_] = mcl::bint::mulUnitN(tbl_[i], p_, Unit(i+1), n_); // 1~MAX_MUL_N
		}
	}
	Unit approx(Unit x0, size_t a) const
	{
//		uint64_t t = uint64_t(double(x0) * double(p0_)); // for d = 26
		uint32_t t = uint32_t(x0 * p0_);
		return Unit(t >> (2 * d + l_ - 1 - a));
	}
	// x[xn] %= p
	// the effective range of return value is [0, n_)
	bool quot(Unit *pQ, const Unit *x, size_t xn) const
	{
		size_t a = mcl::fp::getBitSize(x, xn);
		if (a < l_) {
			*pQ = 0;
			return true;
		}
		size_t e = a - l_ + 1;
		if (e > maxE_) return false;
		Unit x0 = mcl::fp::getUnitAt(x, xn, a - d);
		*pQ = approx(x0, a);
		return true;
	}
	// return false if x[0, xn) is large
	bool mod(Unit *z, const Unit *x, size_t xn) const
	{
		assert(xn <= n_ + 1);
		Unit Q;
		if (!quot(&Q, x, xn)) return false;
		if (Q == 0) {
			mcl::bint::copyN(z, x, n_);
			return true;
		}
		Unit *t = (Unit*)CYBOZU_ALLOCA((n_+1)*sizeof(Unit));
		const Unit *pQ = 0;
		if (Q <= MAX_MUL_N) {
			assert(Q > 0);
			pQ = tbl_[Q-1];
		} else {
			t[n_] = mcl::bint::mulUnitN(t, p_, Q, n_);
			pQ = t;
		}
		bool b = mcl::bint::subN(t, x, pQ, xn);
		assert(!b); (void)b;
		if (mcl::bint::cmpGeN(t, tbl_[0], xn)) { // tbl_[0] == p and tbl_[n_] = 0
			mcl::bint::subN(z, t, p_, n_);
		} else {
			mcl::bint::copyN(z, t, n_);
		}
		return true;
	}
#if 1
	// return false if x[0, xn) is large
	template<size_t N>
	bool modT(Unit z[N], const Unit *x, size_t xn) const
	{
		assert(xn <= N + 1);
		Unit Q;
		if (!quot(&Q, x, xn)) return false;
		if (Q == 0) {
			mcl::bint::copyT<N>(z, x);
			return true;
		}
		Unit t[N+1];
		const Unit *pQ = 0;
		if (Q <= MAX_MUL_N) {
			pQ = tbl_[Q-1];
		} else {
			t[N] = mcl::bint::mulUnitT<N>(t, p_, Q);
			pQ = t;
		}
		bool b = mcl::bint::subT<N+1>(t, x, pQ);
		assert(!b); (void)b;
		if (mcl::bint::cmpGeT<N+1>(t, tbl_[0])) {
			mcl::bint::subT<N>(z, t, p_);
		} else {
			mcl::bint::copyT<N>(z, t);
		}
		return true;
	}
#endif
	template<size_t N>
	static bool mulUnit(const SmallModP& smp, Unit z[N], const Unit x[N], Unit y)
	{
		Unit xy[N+1];
		xy[N] = mulUnitT<N>(xy, x, y);
		return smp.modT<N>(z, xy, N+1);
//		return smp.mod(z, xy, N+1);
	}
};

} } // mcl::bint

// the old test of SmallModP (from bint_test.cpp)
template<size_t N>
void setAndModT(const mcl::bint::SmallModP& smp, Unit x[N+1])
{
	x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], x[0] & 0x3f);
	size_t xn = x[N] == 0 ? N : N+1;
	if (!smp.modT<N>(x, x, xn)) {
		puts("ERR2");
		exit(1);
	}
}

template<size_t N>
void setAndMod(const mcl::bint::SmallModP& smp, Unit x[N+1])
{
	x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], x[0] & 0x3f);
	size_t xn = x[N] == 0 ? N : N+1;
	if (!smp.mod(x, x, xn)) {
		puts("ERR1");
		exit(1);
	}
}

template<size_t N>
void testSmallModP(const char *pStr)
{
	printf("p=%s\n", pStr);
	Unit p[N];
	const size_t FACTOR = 128;
	size_t xn = mcl::fp::hexToArray(p, N, pStr, strlen(pStr));
	CYBOZU_TEST_EQUAL(xn, N);
	mcl::bint::SmallModP smp;
	smp.init(p, N);
	cybozu::XorShift rg;
	Unit x[N+1];
	mcl::bint::copyT<N>(x, p);
	for (size_t i = 0; i < 10; i++) {
		uint32_t a = rg.get32() % FACTOR;
		x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], a);
		xn = x[N] == 0 ? N : N+1;
		Unit q[2], r[N+1];
		mcl::bint::copyN(r, x, xn);
		mcl::bint::div(q, 2, r, xn, p, N);
		CYBOZU_TEST_ASSERT(q[0] <= FACTOR && q[1] == 0);
		for (int mode = 0; mode < 2; mode++) {
			Unit r2[N];
			bool b = false;
			switch (mode) {
			case 0: b = smp.mod(r2, x, xn); break;
			case 1: b = smp.modT<N>(r2, x, xn); break;
			}
			CYBOZU_TEST_ASSERT(b);
			CYBOZU_TEST_EQUAL_ARRAY(r2, r, N);
		}
		mcl::bint::copyT<N>(x, r);
	}
#ifdef NDEBUG
	{
		if ((smp.p_[N-1] >> (MCL_UNIT_BIT_SIZE - 8)) == 0) return; // top 8-bit must be not zero
		CYBOZU_BENCH_C("mod ", 1000, setAndMod<N>, smp, x);
		CYBOZU_BENCH_C("modT", 1000, setAndModT<N>, smp, x);
	}
#endif
}

CYBOZU_TEST_AUTO(SmallModP)
{
	const size_t adj = 8 / sizeof(Unit);
	const char *tbl4[] = {
		"2523648240000001ba344d80000000086121000000000013a700000000000013",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001", // BLS12-381 r
		"7523648240000001ba344d80000000086121000000000013a700000000000017",
		"800000000000000000000000000000000000000000000000000000000000005f",
		"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
		// not primes
		"ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		testSmallModP<4 * adj>(tbl4[i]);
	}
	const char *tbl6[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab", // BLS12-381 p
		"240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d", // BN381 r
		"240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013", // BN381 p
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		testSmallModP<6 * adj>(tbl6[i]);
	}
}

// Modp::init() may fail (e.g. min prime), then modp() returns false
CYBOZU_TEST_AUTO(modp_init)
{
#ifdef NDEBUG
	const int C = 1000000;
#endif
	const char *pTbl[] = {
		"0x30000000000000000000000000000000000000000000002b",
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffffffffffffffffffeffffee37",
		"0xfffffffffffffffffffffffe26f2fc170f69466a74defd8d",
		"0xffffffffffffffffffffffffffffffffffffffffffffff13", // max prime
		"0x0000000000000001000000000000000000000000000000000000000000000085", // min prime
		"0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001",
		"0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d",
		"0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001",
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001",
		"0x240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d",
		"0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
	};
	const char *xTbl[] = {
		"0x12345678892082039482094823",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
		"0x10000000000000000000000000000000000000000000000000000000000000000",
		"0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	mcl::Modp modp;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(pTbl); i++) {
		const mpz_class p(pTbl[i]);
		std::cout << std::hex << "p=" << p << std::endl;
		const bool ok = modp.init(p);
		std::cout << "init=" << (ok ? "ok" : "fail") << std::endl;
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(xTbl); j++) {
			const mpz_class x(xTbl[j]);
			std::cout << std::hex << "x=" << x << std::endl;
			const mcl::Unit *px = mcl::gmp::getUnit(x);
			const size_t xn = mcl::gmp::getUnitSize(x);
			mcl::Unit y[mcl::maxUnitSize];
			const bool b = modp.modp(y, px, xn);
			CYBOZU_TEST_EQUAL(b, ok);
			mpz_class r1, r2;
			r1 = x % p;
#ifdef NDEBUG
			CYBOZU_BENCH_C("x % p", C, mcl::gmp::mod, r1, x, p);
#endif
			if (!b) continue;
			bool b2;
			mcl::gmp::setArray(&b2, r2, y, modp.N);
			CYBOZU_TEST_ASSERT(b2);
			CYBOZU_TEST_EQUAL(r1, r2);
#ifdef NDEBUG
			CYBOZU_BENCH_C("modp ", C, modp.modp, y, px, xn);
#endif
		}
	}
}

CYBOZU_TEST_AUTO(modp)
{
#ifdef NDEBUG
	const int C = 1000000;
#endif
	const char *pTbl[] = {
		"0x30000000000000000000000000000000000000000000002b",
		"0x70000000000000000000000000000000000000000000001f",
		"0x800000000000000000000000000000000000000000000005",
		"0xfffffffffffffffffffffffffffffffffffffffeffffee37",
		"0xffffffffffffffffffffffffffffffffffffffffffffff13", // max prime
		"0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001",
		"0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d",
		"0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001",
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47",
		"0x7523648240000001ba344d80000000086121000000000013a700000000000017",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001",
		"0x240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d",
		"0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
	};
	const size_t maxXN = 64 / sizeof(mcl::Unit); // the generated function accepts xN <= maxXN
	// modp_generic accepts any xN ; 2 maxUnitSize is the largest size mpz_class (Vint) can hold
	const size_t maxGenericXN = mcl::maxUnitSize * 2;
	cybozu::XorShift rg;
	mcl::Modp modp;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(pTbl); i++) {
		const mpz_class p(pTbl[i]);
		std::cout << std::hex << "p=" << p << std::endl;
		CYBOZU_TEST_ASSERT(modp.init(p));
		const size_t N = modp.N;
		// modp() calls the generated function (mclb_modp*) if modp_asm is set
		std::cout << "modp_asm=" << (modp.modp_asm ? "yes" : "no") << std::endl;
		for (size_t xN = 0; xN <= maxGenericXN; xN++) {
			for (int j = 0; j < 100; j++) {
				mcl::Unit x[maxGenericXN > maxXN ? maxGenericXN : maxXN] = {};
				mcl::Unit y[mcl::maxUnitSize] = {};
				for (size_t k = 0; k < xN; k++) {
					x[k] = rg.get64();
					// mix in extreme values
					int r = rg.get32() % 8;
					if (r == 0) x[k] = 0;
					if (r == 1) x[k] = mcl::Unit(-1);
				}
				if (j == 0 && xN == N) {
					// x = p - 1
					mpz_class t = p - 1;
					bool b;
					mcl::gmp::getArray(&b, x, xN, t);
					CYBOZU_TEST_ASSERT(b);
				}
				if (j == 1 && xN == N) {
					// x = p
					bool b;
					mcl::gmp::getArray(&b, x, xN, p);
					CYBOZU_TEST_ASSERT(b);
				}
				mpz_class mx, r1, r2;
				mcl::gmp::setArray(mx, x, xN);
				r1 = mx % p;
				CYBOZU_TEST_ASSERT(modp.modp_generic(y, x, xN));
				mcl::gmp::setArray(r2, y, N);
				CYBOZU_TEST_EQUAL(r1, r2);
				// modp() uses modp_asm if xN <= maxXN, otherwise modp_generic()
				mcl::Unit y2[mcl::maxUnitSize] = {};
				CYBOZU_TEST_ASSERT(modp.modp(y2, x, xN));
				CYBOZU_TEST_EQUAL_ARRAY(y, y2, N);
			}
		}
#ifdef NDEBUG
		{
			mcl::Unit x[maxXN], y[mcl::maxUnitSize];
			for (size_t k = 0; k < maxXN; k++) x[k] = rg.get64();
			CYBOZU_BENCH_C("modp_generic", C, modp.modp_generic, y, x, maxXN);
			if (modp.modp_asm) CYBOZU_BENCH_C("modp_asm    ", C, modp.modp, y, x, maxXN);
		}
#endif
	}
}

// mulUnitMod (x < p, any y) and modp1 (xx < p 2^BIT)
CYBOZU_TEST_AUTO(mulUnitMod)
{
#ifdef NDEBUG
	const int C = 1000000;
#endif
	const char *pTbl[] = {
		"0x30000000000000000000000000000000000000000000002b",
		"0x800000000000000000000000000000000000000000000005",
		"0xffffffffffffffffffffffffffffffffffffffffffffff13", // max prime
		"0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001",
		"0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47",
		"0x800000000000000000000000000000000000000000000000000000000000005f",
		"0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001",
		"0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013",
		"0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff",
	};
	cybozu::XorShift rg;
	mcl::Modp modp;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(pTbl); i++) {
		const mpz_class p(pTbl[i]);
		std::cout << std::hex << "p=" << p << std::endl;
		CYBOZU_TEST_ASSERT(modp.init(p));
		const size_t N = modp.N;
		std::cout << "modp_asm=" << (modp.modp_asm ? "yes" : "no") << std::endl;
		for (int j = 0; j < 1000; j++) {
			mcl::Unit x[mcl::maxUnitSize] = {};
			mpz_class mx;
			if (j == 0) {
				mx = p - 1;
			} else {
				for (size_t k = 0; k < N; k++) x[k] = rg.get64();
				mcl::gmp::setArray(mx, x, N);
				mx %= p;
			}
			bool b;
			mcl::gmp::getArray(&b, x, N, mx);
			CYBOZU_TEST_ASSERT(b);
			mcl::Unit y;
			switch (j % 4) {
			case 0: y = mcl::Unit(-1); break;
			case 1: y = j % 20; break;
			case 2: y = rg.get32(); break;
			default: y = rg.get64(); break;
			}
			const mpz_class r1 = (mx * mpz_class(y)) % p;
			mcl::Unit z[mcl::maxUnitSize] = {};
			CYBOZU_TEST_ASSERT(modp.mulUnitMod(z, x, y));
			mpz_class r2;
			mcl::gmp::setArray(r2, z, N);
			CYBOZU_TEST_EQUAL(r1, r2);
			// modp1 is used by mulUnitMod only if modp_asm is null, so test it directly
			mcl::Unit xy[mcl::maxUnitSize + 1];
			xy[N] = mcl::bint::mulUnitN(xy, x, y, N);
			mcl::Unit z2[mcl::maxUnitSize] = {};
			modp.modp1(z2, xy);
			CYBOZU_TEST_EQUAL_ARRAY(z, z2, N);
			// modpSmall accepts xy if y < 2^(smallMaxE - 1) (it may accept a larger y)
			mcl::Unit z3[mcl::maxUnitSize] = {};
			const bool small = modp.modpSmall(z3, xy);
			if (y < (mcl::Unit(1) << (mcl::Modp::smallMaxE - 1))) CYBOZU_TEST_ASSERT(small);
			if (small) CYBOZU_TEST_EQUAL_ARRAY(z, z3, N);
		}
		// x y in [2^(N BIT), 2^(N BIT) + y) for a full-bit p (p > 2^(N BIT - 1)) : xy[N] = 1 must not take the q == 0 path
		if (mcl::gmp::getBitSize(p) == N * mcl::UnitBitSize) {
			for (mcl::Unit y = 2; y <= 100; y++) {
				mpz_class mx = ((mpz_class(1) << (N * mcl::UnitBitSize)) + y - 1) / y; // ceil(2^(N BIT) / y) < p
				CYBOZU_TEST_ASSERT(mx < p);
				mcl::Unit x[mcl::maxUnitSize] = {};
				bool b;
				mcl::gmp::getArray(&b, x, N, mx);
				CYBOZU_TEST_ASSERT(b);
				mcl::Unit xy[mcl::maxUnitSize + 1];
				xy[N] = mcl::bint::mulUnitN(xy, x, y, N);
				CYBOZU_TEST_EQUAL(xy[N], 1u);
				mcl::Unit z[mcl::maxUnitSize] = {};
				CYBOZU_TEST_ASSERT(modp.modpSmall(z, xy));
				mpz_class r1, r2;
				r1 = (mx * mpz_class(y)) % p;
				mcl::gmp::setArray(r2, z, N);
				CYBOZU_TEST_EQUAL(r1, r2);
			}
		}
		{
			mcl::Unit x[mcl::maxUnitSize];
			bool b;
			mcl::gmp::getArray(&b, x, N, p - 1);
			CYBOZU_TEST_ASSERT(b);
			const mpz_class mx = p - 1;
			for (mcl::Unit y = 0; y < (mcl::Unit(1) << (mcl::Modp::smallMaxE - 1)); y++) {
				mcl::Unit xy[mcl::maxUnitSize + 1];
				xy[N] = mcl::bint::mulUnitN(xy, x, y, N);
				mcl::Unit z[mcl::maxUnitSize] = {};
				CYBOZU_TEST_ASSERT(modp.modpSmall(z, xy));
				mpz_class r1, r2;
				r1 = (mx * mpz_class(y)) % p;
				mcl::gmp::setArray(r2, z, N);
				CYBOZU_TEST_EQUAL(r1, r2);
			}
		}
#ifdef NDEBUG
		{
			mcl::Unit x[mcl::maxUnitSize], z[mcl::maxUnitSize];
			bool b;
			mcl::gmp::getArray(&b, x, N, p - 1);
			CYBOZU_TEST_ASSERT(b);
			const mcl::Unit y = rg.get64();
			CYBOZU_BENCH_C("mulUnitMod", C, modp.mulUnitMod, z, x, y);
			mcl::Unit xy[mcl::maxUnitSize + 1];
			xy[N] = mcl::bint::mulUnitN(xy, x, y, N);
			CYBOZU_BENCH_C("modp1     ", C, modp.modp1, z, xy);
			xy[N] = mcl::bint::mulUnitN(xy, x, 100, N);
			CYBOZU_BENCH_C("modpSmall ", C, modp.modpSmall, z, xy);
		}
#endif
	}
	// init fails for min prime, then mulUnitMod returns false
	{
		const mpz_class p("0x0000000000000001000000000000000000000000000000000000000000000085");
		CYBOZU_TEST_ASSERT(!modp.init(p));
		mcl::Unit x[mcl::maxUnitSize] = {}, z[mcl::maxUnitSize];
		CYBOZU_TEST_ASSERT(!modp.mulUnitMod(z, x, 3));
	}
}

// Fp::mulUnit / Fr::mulUnit (from the old smallmodp_test.cpp)
template<class F>
void testMulUnit(const char *s)
{
	puts(s);
	cybozu::XorShift rg;
	F x, z1, z2;
	for (size_t i = 0; i < 1000; i++) {
		x.setByCSPRNG(rg);
		uint32_t y = uint32_t(i);
		z1 = x * y;
		F::mulUnit(z2, x, y);
		CYBOZU_TEST_EQUAL(z1, z2);
	}
	// x = p - 1 with random y
	x = -1;
	for (size_t i = 0; i < 1000; i++) {
		Unit y = (i & 1) ? Unit(rg.get32()) : Unit(rg.get64());
		// F(y) treats y as int64_t, so build F(y) from two halves
		const F fy = F(int64_t(y >> 32)) * F(int64_t(1) << 32) + F(int64_t(y & 0xffffffff));
		z1 = x * fy;
		F::mulUnit(z2, x, y);
		CYBOZU_TEST_EQUAL(z1, z2);
	}
#ifdef NDEBUG
	const int C = 100000;
	x.setByCSPRNG(rg);
	for (uint32_t i = 1; i < 10; i++) {
		printf("i=% 2d ", i);
		CYBOZU_BENCH_C("mulUnit", C, F::mulUnit, x, x, i);
	}
	// random y (branch prediction does not work)
	const size_t YN = 1024;
	static Unit ys[4][YN];
	const char *name[4] = { "[1-9]", "[10-255]", "[1000-1255]", "[0-2^64)" };
	for (size_t i = 0; i < YN; i++) {
		ys[0][i] = 1 + rg.get32() % 9;
		ys[1][i] = 10 + rg.get32() % 246;
		ys[2][i] = 1000 + rg.get32() % 256;
		ys[3][i] = rg.get64();
	}
	F z;
	for (int r = 0; r < 4; r++) {
		const Unit *y = ys[r];
		size_t idx = 0;
		printf("y in %-12s ", name[r]);
		CYBOZU_BENCH_C("mulUnit", C, F::mulUnit, z, x, y[idx = (idx + 1) & (YN - 1)]);
	}
	CYBOZU_BENCH_C("mul(F, u32)", C, F::mul, x, x, uint32_t(*x.getUnit()));
	CYBOZU_BENCH_C("mul(F, F)", C, F::mul, x, x, x);
	CYBOZU_TEST_ASSERT(x != 0);
#endif
}

template<size_t N>
void mulUnitSmallT(const mcl::Modp& modp, Unit *z, const Unit *x, Unit y, Unit *xy)
{
	xy[N] = mcl::bint::mulUnitT<N>(xy, x, y);
	if (!modp.modpSmall(z, xy)) modp.modp1(z, xy);
}

// compare the removed SmallModP with Modp::mulUnitMod / modp1 / modpSmall for z = x y mod p (x < p)
template<class F, size_t N>
void benchSmallModP(const char *name)
{
	printf("=== %s N=%d ===\n", name, (int)N);
	const fp::Op& op = F::getOp();
	CYBOZU_TEST_EQUAL(op.N, N);
	mcl::bint::SmallModP smp;
	smp.init(op.p, N);
	cybozu::XorShift rg;
	F x, z;
	x.setByCSPRNG(rg);
	const Unit *px = x.getUnit();
	for (int i = 0; i < 1000; i++) {
		const Unit y = rg.get32() % 10000; // SmallModP requires x y < p 2^14
		Unit z1[N], z2[N], z3[N];
		mcl::Unit xy[N + 1];
		xy[N] = mcl::bint::mulUnitT<N>(xy, px, y);
		CYBOZU_TEST_ASSERT(smp.mulUnit<N>(smp, z1, px, y));
		CYBOZU_TEST_ASSERT(op.modp.mulUnitMod(z2, px, y));
		op.modp.modp1(z3, xy);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z2, N);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z3, N);
		CYBOZU_TEST_ASSERT(op.modp.modpSmall(z3, xy));
		CYBOZU_TEST_EQUAL_ARRAY(z1, z3, N);
		op.modp.template mulUnitModT<N>(z3, px, y);
		CYBOZU_TEST_EQUAL_ARRAY(z1, z3, N);
	}
#ifdef NDEBUG
	const int C = 1000000;
	Unit *pz = const_cast<Unit*>(z.getUnit());
	const size_t YN = 1024;
	static Unit ys[YN];
	for (size_t i = 0; i < YN; i++) ys[i] = 10 + rg.get32() % 246;
	size_t idx = 0;
	CYBOZU_BENCH_C("SmallModP::mulUnit", C, smp.mulUnit<N>, smp, pz, px, ys[idx = (idx + 1) & (YN - 1)]);
	idx = 0;
	CYBOZU_BENCH_C("Modp::mulUnitMod  ", C, op.modp.mulUnitMod, pz, px, ys[idx = (idx + 1) & (YN - 1)]);
	{
		Unit xy[N + 1];
		xy[N] = mcl::bint::mulUnitT<N>(xy, px, ys[0]);
		CYBOZU_BENCH_C("Modp::modp1       ", C, op.modp.modp1, pz, xy);
		CYBOZU_BENCH_C("Modp::modpSmall   ", C, op.modp.modpSmall, pz, xy);
	}
	{
		// mulUnitPre + modpSmall (the path of mulUnitMod without modp_asm)
		Unit xy[N + 1];
		idx = 0;
		CYBOZU_BENCH_C("mulUnitT+modpSmall", C, mulUnitSmallT<N>, op.modp, pz, px, ys[idx = (idx + 1) & (YN - 1)], xy);
		idx = 0;
		CYBOZU_BENCH_C("mulUnitModT<N>    ", C, op.modp.template mulUnitModT<N>, pz, px, ys[idx = (idx + 1) & (YN - 1)]);
		idx = 0;
		CYBOZU_BENCH_C("mulUnitModT<0>    ", C, op.modp.template mulUnitModT<0>, pz, px, ys[idx = (idx + 1) & (YN - 1)]);
		idx = 0;
		CYBOZU_BENCH_C("F::mulUnit        ", C, F::mulUnit, z, x, ys[idx = (idx + 1) & (YN - 1)]);
	}
	CYBOZU_TEST_ASSERT(z != 0 || z == 0);
#endif
}

// z = x y by op.fp_mulUnit (Modp::mulUnitModT<N>) without the add chain of mulSmallUnit
template<class F>
inline void modpMul(F& z, const F& x, Unit y)
{
	const fp::Op& op = F::getOp();
	op.fp_mulUnit(const_cast<Unit*>(z.getUnit()), x.getUnit(), y, op);
}

// mulUnit with the add chain only for y <= TH (TH = -1 : never, TH = 4 : F::mulUnit)
template<class F, int TH>
inline void mulUnitTH(F& z, const F& x, Unit y)
{
	if (TH >= 0 && y <= Unit(TH)) {
		if (fp::mulSmallUnit(z, x, y)) return;
	}
	modpMul(z, x, y);
}

// issue #199 style : s += x[i] y[i] for small integers y[i]
template<class F, int TH>
void dotTH(F& s, const F *x, const Unit *y, size_t n)
{
	F t;
	s.clear();
	for (size_t i = 0; i < n; i++) {
		mulUnitTH<F, TH>(t, x[i], y[i]);
		F::add(s, s, t);
	}
}
template<class F>
void dot(F& s, const F *x, const Unit *y, size_t n)
{
	F t;
	s.clear();
	for (size_t i = 0; i < n; i++) {
		F::mulUnit(t, x[i], y[i]);
		F::add(s, s, t);
	}
}
template<class F>
void dotRef(F& s, const F *x, const Unit *y, size_t n)
{
	F t;
	s.clear();
	for (size_t i = 0; i < n; i++) {
		t = int64_t(y[i]);
		F::mul(t, t, x[i]);
		F::add(s, s, t);
	}
}
template<class F, class Dot>
double benchDot(Dot dotF, const F *x, const Unit *y, size_t n, int C)
{
	F s;
	cybozu::CpuClock clk;
	clk.begin(); for (int i = 0; i < C; i++) dotF(s, x, y, n); clk.end();
	return clk.getClock() / double(C) / n;
}
// throughput : z[i] = x[i] y (independent)
template<class F, class Mul>
double benchThr(Mul mul, F *z, const F *x, size_t n, int C)
{
	cybozu::CpuClock clk;
	clk.begin(); for (int i = 0; i < C; i++) for (size_t j = 0; j < n; j++) mul(z[j], x[j]); clk.end();
	return clk.getClock() / double(C) / n;
}
// latency : x = x y (dependent chain)
template<class F, class Mul>
double benchLat(Mul mul, F& x, int C)
{
	cybozu::CpuClock clk;
	clk.begin(); for (int i = 0; i < C; i++) mul(x, x); clk.end();
	return clk.getClock() / double(C);
}
template<class F, Unit Y>
struct ConstSmall { void operator()(F& z, const F& x) const { fp::mulSmallUnit(z, x, Y); } };
template<class F, Unit Y>
struct ConstModp { void operator()(F& z, const F& x) const { modpMul(z, x, Y); } };
template<class F, Unit Y>
void benchConstY(F *z, const F *x, size_t n, int C)
{
	F a = x[0], b = x[0];
	printf("y=%d  thr: add %5.1f modp %5.1f  lat: add %5.1f modp %5.1f\n", (int)Y,
		benchThr(ConstSmall<F, Y>(), z, x, n, C), benchThr(ConstModp<F, Y>(), z, x, n, C),
		benchLat(ConstSmall<F, Y>(), a, C * (int)n), benchLat(ConstModp<F, Y>(), b, C * (int)n));
}

/*
	the dot product (s += x[i] y[i]) is the criterion to compare mulUnit implementations
	because a micro benchmark of mulUnit alone varies with how it is inlined.
	the add chain of mulSmallUnit is used in F::mulUnit only for y <= 4 (see the constant y bench).
	CpuClock is clock_gettime on macOS arm64, so "clk" means nsec there.
*/
template<class F>
void testDot(const char *name)
{
	const size_t n = 1024;
	static F x[n], z[n];
	static Unit ys[4][n];
	cybozu::XorShift rg;
	for (size_t i = 0; i < n; i++) {
		x[i].setByCSPRNG(rg);
		ys[0][i] = rg.get32() % 10;
		ys[1][i] = rg.get32() % 256;
		ys[2][i] = 1000 + rg.get32() % 256;
		ys[3][i] = rg.get32();
	}
	for (int r = 0; r < 4; r++) {
		F s1, s2, s3;
		dot(s1, x, ys[r], n);
		dotRef(s2, x, ys[r], n);
		dotTH<F, -1>(s3, x, ys[r], n);
		CYBOZU_TEST_EQUAL(s1, s2);
		CYBOZU_TEST_EQUAL(s1, s3);
	}
	(void)name; // used only in the NDEBUG part
#ifdef NDEBUG
	const char *rn[4] = { "[0,9]", "[0,255]", "[1000,1255]", "[0,2^32)" };
	const int C = 2000;
	printf("=== %s dot (clk per element, n=%d) ===\n", name, (int)n);
	// warm up
	benchThr(ConstModp<F, 2>(), z, x, n, C); benchLat(ConstModp<F, 2>(), z[0], C * (int)n);
	for (int r = 0; r < 4; r++) {
		const Unit *y = ys[r];
		printf("y in %-12s mulUnit+add %5.1f  F(y)*x+add %5.1f  add chain: none %5.1f y<=2 %5.1f y<=4 %5.1f y<=9 %5.1f\n", rn[r],
			benchDot(dot<F>, x, y, n, C), benchDot(dotRef<F>, x, y, n, C),
			benchDot(dotTH<F, -1>, x, y, n, C), benchDot(dotTH<F, 2>, x, y, n, C),
			benchDot(dotTH<F, 4>, x, y, n, C), benchDot(dotTH<F, 9>, x, y, n, C));
	}
	printf("--- constant y : add chain (mulSmallUnit) vs modp (fp_mulUnit)\n");
	benchConstY<F, 2>(z, x, n, C);
	benchConstY<F, 3>(z, x, n, C);
	benchConstY<F, 4>(z, x, n, C);
	benchConstY<F, 5>(z, x, n, C);
	benchConstY<F, 6>(z, x, n, C);
	benchConstY<F, 7>(z, x, n, C);
	benchConstY<F, 8>(z, x, n, C);
	benchConstY<F, 9>(z, x, n, C);
#endif
}

CYBOZU_TEST_AUTO(mulUnit)
{
	mcl::bn::initPairing(mcl::BLS12_381);
	testMulUnit<mcl::bn::Fr>("Fr");
	testMulUnit<mcl::bn::Fp>("Fp");
	const size_t adj = 8 / sizeof(Unit);
	benchSmallModP<mcl::bn::Fr, 4 * adj>("Fr");
	benchSmallModP<mcl::bn::Fp, 6 * adj>("Fp");
	testDot<mcl::bn::Fr>("Fr");
	testDot<mcl::bn::Fp>("Fp");
}
