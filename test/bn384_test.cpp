#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <cybozu/xorshift.hpp>
#include <mcl/bn384.hpp>
#include <mcl/bn.hpp>

using namespace mcl::bn384;

mcl::fp::Mode g_mode;

#include "bench.hpp"

#include "common_test.hpp"

void testMulBLS12_377(Fp2& z, const Fp& a, const Fp& b, const Fp& c, const Fp& d, uint32_t u)
{
	// xy = (a+bi)(c+di) = (ac-bdu) + (ad+bc)i
	CYBOZU_TEST_EQUAL(z.a, a * c - b * d * u);
	CYBOZU_TEST_EQUAL(z.b, a * d + b * c);
}

void testFp2BLS12_377()
{
	// &dst != &src
	{
		Fp2 x, y, z;
		uint32_t u = Fp::getOp().u;
		CYBOZU_TEST_EQUAL(u, 5u);
		x.a = 9;
		x.b = 2;
		y.a = 6;
		y.b = 5;
		Fp a = x.a;
		Fp b = x.b;
		Fp c = y.a;
		Fp d = y.b;
		Fp2::mul(z, x, y);
		testMulBLS12_377(z, a, b, c, d, u);
		Fp2::sqr(z, x);
		testMulBLS12_377(z, a, b, a, b, u);

		Fp2::mul_xi(z, x);
		testMulBLS12_377(z, a, b, 0, 1, u);

		Fp2Dbl xx;
		Fp2Dbl::mulPre(xx, x, y);
		Fp2Dbl::mod(z, xx);
		CYBOZU_TEST_EQUAL(z, x * y);

		Fp2Dbl::sqrPre(xx, x);
		Fp2Dbl::mod(z, xx);
		CYBOZU_TEST_EQUAL(z, x * x);

		Fp2::inv(y, x);
		Fp2::mul(z, y, x);
		CYBOZU_TEST_EQUAL(z, 1);

        for (int i = 0; i < 20; i++) {
            if (Fp2::squareRoot(y, x)) {
                CYBOZU_TEST_EQUAL(y * y, x);
            }
            x += 1;
        }
        Fp2::Frobenius(y, x);
        Fp2::pow(z, x, Fp::getOp().mp);
        CYBOZU_TEST_EQUAL(y, z);
	}
	// &dst = &src
	{
		Fp2 x;
		uint32_t u = Fp::getOp().u;
		x.a = 111;
		x.b = 234;
		Fp a = x.a;
		Fp b = x.b;
		Fp c = x.a;
		Fp d = x.b;
		Fp2::mul(x, x, x);
		testMulBLS12_377(x, a, b, c, d, u);
		a = x.a;
		b = x.b;
		Fp2::sqr(x, x);
		testMulBLS12_377(x, a, b, a, b, u);

		a = x.a;
		b = x.b;
		Fp2::mul_xi(x, x);
		testMulBLS12_377(x, a, b, 0, 1, u);

		Fp2 y = x;
		Fp2::inv(y, y);
		Fp2::mul(x, y, x);
		CYBOZU_TEST_EQUAL(x, 1);
	}
}

void testG1BLS12_377(G1& P)
{
	const char *xStr = "0x008848defe740a67c8fc6225bf87ff5485951e2caa9d41bb188282c8bd37cb5cd5481512ffcd394eeab9b16eb21be9ef";
	const char *yStr = "0x1914a69c5102eff1f674f5d30afeec4bd7fb348ca3e52d96d182ad44fb82305c2fe3d3634a9591afd82de55559c8ea6";
	Fp x, y;
	x.setStr(xStr);
	y.setStr(yStr);
	P.set(x, y);
	G1 Q;
	CYBOZU_TEST_ASSERT(P.isValid());
	G1::mul(Q, P, Fr::getOp().mp - 1);
	CYBOZU_TEST_ASSERT(Q.isValid());
	CYBOZU_TEST_EQUAL(P, -Q);
	CYBOZU_TEST_ASSERT((P+Q).isZero());
}

void testG2BLS12_377(G2& P)
{
	const char *xStr = "0x018480be71c785fec89630a2a3841d01c565f071203e50317ea501f557db6b9b71889f52bb53540274e3e48f7c005196 0x00ea6040e700403170dc5a51b1b140d5532777ee6651cecbe7223ece0799c9de5cf89984bff76fe6b26bfefa6ea16afe";
	const char *yStr = "0x00690d665d446f7bd960736bcbb2efb4de03ed7274b49a58e458c282f832d204f2cf88886d8c7c2ef094094409fd4ddf 0x00f8169fd28355189e549da3151a70aa61ef11ac3d591bf12463b01acee304c24279b83f5e52270bd9a1cdd185eb8f93";
	Fp2 x, y;
	x.setStr(xStr);
	y.setStr(yStr);
	P.set(x, y);
	G2 Q;
	CYBOZU_TEST_ASSERT(P.isValid());
	G2::mul(Q, P, Fr::getOp().mp - 1);
	CYBOZU_TEST_ASSERT(Q.isValid());
	CYBOZU_TEST_EQUAL(P, -Q);
	CYBOZU_TEST_ASSERT((P+Q).isZero());
}

void testGTBLS12_377(const G1& P, const G2& Q)
{
	const char *eStr = "0x00b718ff624a95f189bfb44bcd6d6556226837c1f74d1afbf4bea573b71c17d3a243cae41d966e2164aad0991fd790cc\
 0x0197261459eb50c526a28ebbdbd4b5b33d4c55b759d8c926289c96e4ea032783da4f1994ed09ee68fd791367c8b54d87\
 0x00756970de5e545d91121e151ce96c26ad820ebe4ffbc9dee234351401925eaa4193e377135ced4d3845057c0c39ecd6\
 0x00373f07857759dbec3d57af8bfdc79d28f44db5103e523e28ea69c688af7c831e726417cb5123530fadb5540ac05763\
 0x00ec2d5430932820eb74bd698a2d919cf7086335f235019815501b97fd833d90f07eb111885af785beb343ea1db8d4e7\
 0x0051ae2dce91bcd2251abbaf8dfb67c7e5cf6d864c61f81a09aaeac3dfdcf6ae0b3168929ccc7d91abb8b4e13974b7db\
 0x0095fcebb2a29b10d2f5283a40b147a82ea62114c9bae68e0d745c1afc70c6eeaf1b1c5bf6352d82931b6bdcbff8da47\
 0x001fdad7541653e8ac2d735c24f472716122bb24a3e675c20ab2c23d7380c7a349d49dd0db11f95c08861744e3b19a8e\
 0x00b3530a66bf5754b3e0b7b2c070a35c072bb613698c32db836cef1fcb77086125efd02528d4235f7d7b87e554174d82\
 0x004064943ac5c2fc0ef854d8168c67f56adb2a5a16d900dba15be3ecb0172a9ecd96ebf6375d0262f5d43d0709dc8c5f\
 0x0066910d06a91685179f1b448b9b198d5ed2eabc44d21580005e5f708a3c7858eb9b921691e40ba25804aced41190d34\
 0x0008f3e3e451ff584f864ca1d53fc34562f2ebf3baa7c610d8a3b51a7fa9e8dfaac34399e40540e3bc57a73d11924c03";
	GT e1, e2, e3;
	const mpz_class& p = Fp::getOp().mp;
	const mpz_class& r = Fr::getOp().mp;
	e1.setStr(eStr);
	GT::pow(e2, e1, r);
	CYBOZU_TEST_ASSERT(e2.isOne());
	GT::Frobenius(e2, e1);
	GT::pow(e3, e1, p);
	CYBOZU_TEST_EQUAL(e2, e3);
	GT::Frobenius(e2, e2);
	GT::Frobenius2(e3, e1);
	CYBOZU_TEST_EQUAL(e2, e3);
	GT::Frobenius(e2, e2);
	GT::Frobenius3(e3, e1);
	CYBOZU_TEST_EQUAL(e2, e3);

	pairing(e2, P, Q);
	CYBOZU_TEST_EQUAL(e1, e2);
}

void testBLS12_377()
{
	testFp2BLS12_377();
	G1 P;
	G2 Q;
	testG1BLS12_377(P);
	testG2BLS12_377(Q);
	testGTBLS12_377(P, Q);
}

void testCurve(const mcl::CurveParam& cp)
{
	initPairing(cp, g_mode);
	if (cp == mcl::BLS12_377) {
		testBLS12_377();
	}
	G1 P;
	G2 Q;
#if 1
	mapToG1(P, 1);
	mapToG2(Q, 1);
#else
	hashAndMapToG1(P, "abc");
	hashAndMapToG2(Q, "abc");
#endif
	GT e1, e2;
#ifdef ONLY_BENCH
	cybozu::CpuClock clk;
	for (int i = 0; i < 10000; i++) { clk.begin(); pairing(e1, P, Q); clk.end(); }
	clk.put();
	return;
#endif
	pairing(e1, P, Q);
	{
		GT e;
		pairing(e, P + P, Q);
		CYBOZU_TEST_EQUAL(e1 * e1, e);
		pairing(e, P, Q + Q);
		CYBOZU_TEST_EQUAL(e1 * e1, e);
	}
	cybozu::XorShift rg;
	for (int i = 0; i < 100; i++) {
		Fr a, b;
		G1 aP;
		G2 bQ;
		GT e;
		a.setRand(rg);
		b.setRand(rg);
		aP = P * a;
		bQ = Q * b;
		pairing(e2, aP, bQ);
		GT::pow(e, e1, a * b);
		CYBOZU_TEST_EQUAL(e2, e);
	}
	testCommon(P, Q);
	testBench(P, Q);
	testSquareRoot();
	testLagrange();
}

CYBOZU_TEST_AUTO(pairing)
{
//	puts("BN160");
//	testCurve(mcl::BN160);
	puts("BLS12_377");
	testCurve(mcl::BLS12_377);
	puts("BN_P256");
	testCurve(mcl::BN_P256);
	puts("BN254");
	testCurve(mcl::BN254);
	puts("BN381_1");
	testCurve(mcl::BN381_1);
	puts("BN381_2");
	testCurve(mcl::BN381_2);
	puts("BLS12_381");
	testCurve(mcl::BLS12_381);
	// Q is not on EcT, but bad order
	{
		const char *s = "1 18d3d8c085a5a5e7553c3a4eb628e88b8465bf4de2612e35a0a4eb018fb0c82e9698896031e62fd7633ffd824a859474 1dc6edfcf33e29575d4791faed8e7203832217423bf7f7fbf1f6b36625b12e7132c15fbc15562ce93362a322fb83dd0d 65836963b1f7b6959030ddfa15ab38ce056097e91dedffd996c1808624fa7e2644a77be606290aa555cda8481cfb3cb 1b77b708d3d4f65aeedf54b58393463a42f0dc5856baadb5ce608036baeca398c5d9e6b169473a8838098fd72fd28b50";
		G2 Q;
		CYBOZU_TEST_EXCEPTION(Q.setStr(s, 16), std::exception);
	}
}

int main(int argc, char *argv[])
	try
{
	cybozu::Option opt;
	std::string mode;
	opt.appendOpt(&mode, "auto", "m", ": mode(gmp/gmp_mont/llvm/llvm_mont/xbyak)");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	g_mode = mcl::fp::StrToMode(mode);
	return cybozu::test::autoRun.run(argc, argv);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
