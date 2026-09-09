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


// Modp::init() may fail (e.g. min prime), then modp() returns false
CYBOZU_TEST_AUTO(modp_init)
{
	const int C = 1000000;
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
			CYBOZU_BENCH_C("x % p", C, mcl::gmp::mod, r1, x, p);
			if (!b) continue;
			bool b2;
			mcl::gmp::setArray(&b2, r2, y, modp.N);
			CYBOZU_TEST_ASSERT(b2);
			CYBOZU_TEST_EQUAL(r1, r2);
			CYBOZU_BENCH_C("modp ", C, modp.modp, y, px, xn);
		}
	}
}

CYBOZU_TEST_AUTO(modp)
{
	const int C = 1000000;
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
		{
			mcl::Unit x[maxXN], y[mcl::maxUnitSize];
			for (size_t k = 0; k < maxXN; k++) x[k] = rg.get64();
			CYBOZU_BENCH_C("modp_generic", C, modp.modp_generic, y, x, maxXN);
			if (modp.modp_asm) CYBOZU_BENCH_C("modp_asm    ", C, modp.modp, y, x, maxXN);
		}
	}
}
