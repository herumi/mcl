#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <cybozu/xorshift.hpp>
#include <mcl/bn512.hpp>
#include <mcl/bn.hpp>

using namespace mcl::bn512;

mcl::fp::Mode g_mode;

#include "bench.hpp"

void testHashAndMapto(const mcl::bn::CurveParam& cp)
{
	G1 P;
	G2 Q;
	BN::hashAndMapToG1(P, "test", 4);
	BN::hashAndMapToG2(Q, "test", 4);
	const char *p = 0;
	const char *q = 0;
	if (cp == mcl::bn::CurveFp462) {
		p = "1 10953c12172901fcbdada97c50a248ee33f57ecad739b5e16d5dee3abf43e4ef282c76eb6dec6e639b5df4a3bde3000d8e850db82b7b0465a979 1326c1cba10792ce942bf7064795c8f6222242a2ece48cf92a227e481588ce8bbdc0e661bfbefd421c440fb9859f95ce0e0a43e81522b1ded5";
		q = "1 118143ce614efdcddd2a56a78615a5a37eb544e0e2456a18e378de01e967d2c28a8e3175211b140e764255e04dbadc3cac95dd8fc78829169513 1603d1906a39839ded9154f199039ace8c564bd205f14b96fd43180f71400df02f9d117bf68b008a845ea952699d163d4ce8c274d092faa42c90 1c81acea0fba05de766733651fc9fe0aa05c490d27ff54236212b0e5c3ed9efc6d91d505d88ce0ef3ac30eb4ae1eb49a7fabeaac3625f21d279b 1d51b2613d65f1f93462163e37415bf75bdfda6eaefba4034a1375590edd340f295f5cbca7f8afe9d1bdf4fbe85a279a5ebe19f403dcf4f35263";
	} else if (cp == mcl::bn::CurveFp382_1) {
		p = "1 21e43f3aecae284f008bcf780ef3064c92951c40357de8d6653fecdcaaaa4e539847e3d74becab9a6edcce475cb56374 1668854173ac1d40921a325ed482cf39aad24570eb5ba04b71d96f8f9b5385652a48167365039974c3e215c79305d4f8";
		q = "1 141ed1e349e553088bdd1e118b5cdf10ae382f7305100c7afc8f30c685c659ff3428261f2dc52079fb0ec6158e08689b 1cf6f471ef1a959ae0170a8ee5e9637defeb41b1f85f953223b20349de894741e0f5882dcacbfb7efbb301ec1ba0807c 16a2ce4c680918b0e80596d51d2add3fcc51a9ec986d9eff0be328ebe75cee039047055317871d8b2101b687bda58739 10fed1bc206bd46f48e58b371f70c4df8da5477c5de15c0014967cd81664b131917709216618ee6795ec81a6cad6cc3";
	} else if (cp == mcl::bn::CurveFp382_2) {
		p = "1 16e20771f6138ac9254a2b2d03af648192230c1d54a74490ba1c8ea9d4f4962fef22fda740ec8c3600faa49cca4b265f c62cd3384224dacee20b34926e7deb45887959f3db948dc358fe00917fa9723dad5e5146822c513a22888f74156bff3";
		q = "1 5c4a9258661680ffa4bb27db209ad3fb7d1778826fc4c701d0f6b47fc1b0c366ec0b1fcd4873d14a9a4e024e03bbdd5 c0f34a7ad7d698f8aa0821a9c3693d2b396803ec96ebcdfca2cf02b164955c04b582b9f49e6cea2bcd8087546199252 1760d4d6f5b96f18a215fc03756c81ae40582bd2d5c403f0cef4eba774e250db37bcc5cf99fff863b4e3a60a57c4753e 6d432706c8dcc0213cd7f316058a6d97b8e785d6a82158dbd93f0be041acb0c1a732da3e2abff331450fbef5ae42401";
	} else if (cp == mcl::bn::CurveFp254BNb) {
		p = "1 eec3cf4d6081a968f03332701b07163bf6b69fdef0b995f067857f018cb7761 1a47fcc17416ae55d2a8c32be5662ff2446e044252d77eb66299e13b38a71452";
		q = "1 1890d3fee3f3cbed840f62846b54cb7386b776da11ae16b2d1b72d1d2467f6ad 1aec28931fbac01fb567b297a5d70252521a965a2a8c890c5ce700d2801742f5 113fd22d2c5264d7ef1a98344777407ed3a622bb8ce9e5efeec15f2c03dc9698 b0ac220896b9efca039babada9536e04cf392cb482508eafab2ad7362509b4a";
	} else {
		CYBOZU_TEST_ASSERT(0);
	}
	G1 P2;
	G2 Q2;
	P2.setStr(p, 16);
	Q2.setStr(q, 16);
	CYBOZU_TEST_EQUAL(P, P2);
	CYBOZU_TEST_EQUAL(Q, Q2);
}


void testCurve(const mcl::bn::CurveParam& cp)
{
	initPairing(cp, g_mode);
	G1 P;
	G2 Q;
	BN::mapToG1(P, 1);
	BN::mapToG2(Q, 1);
	GT e1, e2;
	BN::pairing(e1, P, Q);
	cybozu::XorShift rg;
	mpz_class a, b;
	Fr r;
	r.setRand(rg); a = r.getMpz();
	r.setRand(rg); b = r.getMpz();
	G1 aP;
	G2 bQ;
	G1::mul(aP, P, a);
	G2::mul(bQ, Q, b);
	BN::pairing(e2, aP, bQ);
	GT::pow(e1, e1, a * b);
	CYBOZU_TEST_EQUAL(e1, e2);
	testHashAndMapto(cp);
	testBench(P, Q);
}

CYBOZU_TEST_AUTO(pairing)
{
	puts("CurveFp462");
	testCurve(mcl::bn::CurveFp462);
	puts("CurveFp382_1");
	testCurve(mcl::bn::CurveFp382_1);
	puts("CurveFp382_2");
	testCurve(mcl::bn::CurveFp382_2);
	puts("CurveFp254BNb");
	testCurve(mcl::bn::CurveFp254BNb);
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
