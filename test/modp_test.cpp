#include <mcl/gmp_util.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/test.hpp>

#define PUT(x) std::cout << #x << "=" << x << std::endl;

CYBOZU_TEST_AUTO(modp)
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
		modp.init(p);
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(xTbl); j++) {
			const mpz_class x(xTbl[j]);
			std::cout << std::hex << "x=" << x << std::endl;
			mpz_class r1, r2;
			r1 = x % p;
			modp.modp(r2, x);
			CYBOZU_TEST_EQUAL(r1, r2);
			CYBOZU_BENCH_C("x % p", C, mcl::gmp::mod, r1, x, p);
			CYBOZU_BENCH_C("modp ", C, modp.modp, r2, x);
		}
	}
}
