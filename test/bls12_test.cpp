#define PUT(x) std::cout << #x "=" << x << std::endl;
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/benchmark.hpp>
cybozu::CpuClock clk;
#include <cybozu/test.hpp>
#include <mcl/bls12_381.hpp>
#include <cybozu/option.hpp>
#include <cybozu/xorshift.hpp>

#if defined(__EMSCRIPTEN__) && !defined(MCL_AVOID_EXCEPTION_TEST)
	#define MCL_AVOID_EXCEPTION_TEST
#endif

using namespace mcl::bls12;

#include "common_test.hpp"
#define MCL_GLV_ONLY_FUNC
#include "../src/glv.hpp"

const struct TestSet {
	mcl::CurveParam cp;
	const char *name;
	const char *p;
	const char *r;
	struct G2 {
		const char *aa;
		const char *ab;
		const char *ba;
		const char *bb;
	} g2;
	struct G1 {
		const char *a;
		const char *b;
	} g1;
	const char *e;
} g_testSetTbl[] = {
	{
		mcl::BLS12_381,
		"BLS12_381",
		"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		{
			"0x024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8",
			"0x13e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e",
			"0x0ce5d527727d6e118cc9cdc6da2e351aadfd9baa8cbdd3a76d429a695160d12c923ac9cc3baca289e193548608b82801",
			"0x0606c4a02ea734cc32acd2b02bc28b99cb3e287e85a763af267492ab572e99ab3f370d275cec1da1aaa9075ff05f79be",
		},
		{
			"0x17f1d3a73197d7942695638c4fa9ac0fc3688c4f9774b905a14e3a3f171bac586c55e83ff97a1aeffb3af00adb22c6bb",
			"0x08b3f481e3aaa0f1a09e30ed741d8ae4fcf5e095d5d00af600db18cb2c04b3edd03cc744a2888ae40caa232946c5e7e1",
		},
		"0x1250EBD871FC0A92A7B2D83168D0D727272D441BEFA15C503DD8E90CE98DB3E7B6D194F60839C508A84305AACA1789B6 "
		"0x089A1C5B46E5110B86750EC6A532348868A84045483C92B7AF5AF689452EAFABF1A8943E50439F1D59882A98EAA0170F "
		"0x1368BB445C7C2D209703F239689CE34C0378A68E72A6B3B216DA0E22A5031B54DDFF57309396B38C881C4C849EC23E87 "
		"0x193502B86EDB8857C273FA075A50512937E0794E1E65A7617C90D8BD66065B1FFFE51D7A579973B1315021EC3C19934F "
		"0x01B2F522473D171391125BA84DC4007CFBF2F8DA752F7C74185203FCCA589AC719C34DFFBBAAD8431DAD1C1FB597AAA5 "
		"0x018107154F25A764BD3C79937A45B84546DA634B8F6BE14A8061E55CCEBA478B23F7DACAA35C8CA78BEAE9624045B4B6 "
		"0x19F26337D205FB469CD6BD15C3D5A04DC88784FBB3D0B2DBDEA54D43B2B73F2CBB12D58386A8703E0F948226E47EE89D "
		"0x06FBA23EB7C5AF0D9F80940CA771B6FFD5857BAAF222EB95A7D2809D61BFE02E1BFD1B68FF02F0B8102AE1C2D5D5AB1A "
		"0x11B8B424CD48BF38FCEF68083B0B0EC5C81A93B330EE1A677D0D15FF7B984E8978EF48881E32FAC91B93B47333E2BA57 "
		"0x03350F55A7AEFCD3C31B4FCB6CE5771CC6A0E9786AB5973320C806AD360829107BA810C5A09FFDD9BE2291A0C25A99A2 "
		"0x04C581234D086A9902249B64728FFD21A189E87935A954051C7CDBA7B3872629A4FAFC05066245CB9108F0242D0FE3EF "
		"0x0F41E58663BF08CF068672CBD01A7EC73BACA4D72CA93544DEFF686BFD6DF543D48EAA24AFE47E1EFDE449383B676631 "
	},
};

CYBOZU_TEST_AUTO(size)
{
	CYBOZU_TEST_EQUAL(sizeof(Fp), 48u);
	CYBOZU_TEST_EQUAL(sizeof(Fr), 32u);
	CYBOZU_TEST_EQUAL(sizeof(Fp2), sizeof(Fp) * 2);
	CYBOZU_TEST_EQUAL(sizeof(Fp6), sizeof(Fp) * 6);
	CYBOZU_TEST_EQUAL(sizeof(Fp12), sizeof(Fp) * 12);
	CYBOZU_TEST_EQUAL(sizeof(G1), sizeof(Fp) * 3);
	CYBOZU_TEST_EQUAL(sizeof(G2), sizeof(Fp2) * 3);
}

void testParam(const TestSet& ts)
{
	CYBOZU_TEST_EQUAL(Fr::getOp().mp, mpz_class(ts.r));
	CYBOZU_TEST_EQUAL(Fp::getOp().mp, mpz_class(ts.p));
}

void finalExpC(Fp12& y, const Fp12& x)
{
	const mpz_class& r = Fr::getOp().mp;
	const mpz_class& p = Fp::getOp().mp;
	mpz_class p2 = p * p;
	mpz_class p4 = p2 * p2;
#if 1
	Fp12::pow(y, x, p2 + 1);
	Fp12::pow(y, y, p4 * p2 - 1);
	Fp12::pow(y, y, (p4 - p2 + 1) / r * 3);
#else
	Fp12::pow(y, x, (p4 * p4 * p4 - 1) / r * 3);
#endif
}

void pairingC(Fp12& e, const G1& P, const G2& Q)
{
	millerLoop(e, P, Q);
	finalExp(e, e);
}
void testIoAll(const G1& P, const G2& Q)
{
	const int FpTbl[] = { 0, 2, 2|mcl::IoPrefix, 10, 16, 16|mcl::IoPrefix, mcl::IoArray, mcl::IoArrayRaw };
	const int EcTbl[] = { mcl::IoEcAffine, mcl::IoEcProj, mcl::IoEcCompY, mcl::IoSerialize, mcl::IoEcAffineSerialize };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(FpTbl); i++) {
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(EcTbl); j++) {
			G1 P2 = P, P3;
			G2 Q2 = Q, Q3;
			int ioMode = FpTbl[i] | EcTbl[j];
			std::string s = P2.getStr(ioMode);
			P3.setStr(s, ioMode);
			CYBOZU_TEST_EQUAL(P2, P3);
			s = Q2.getStr(ioMode);
			Q3.setStr(s, ioMode);
			CYBOZU_TEST_EQUAL(Q2, Q3);
			s = P.x.getStr(ioMode);
			Fp Px;
			Px.setStr(s, ioMode);
			CYBOZU_TEST_EQUAL(P.x, Px);
			s = Q.x.getStr(ioMode);
			Fp2 Qx;
			Qx.setStr(s, ioMode);
			CYBOZU_TEST_EQUAL(Q.x, Qx);
		}
	}
}

void testIo(const G1& P, const G2& Q)
{
	testIoAll(P, Q);
	G1 Z1;
	G2 Z2;
	Z1.clear();
	Z2.clear();
	testIoAll(Z1, Z2);
}

void testSetStr(const G2& Q0)
{
	G2::setCompressedExpression();
	G2 Q;
	Q.clear();
	for (int i = 0; i < 10; i++) {
		G2 R;
		R.setStr(Q.getStr());
		CYBOZU_TEST_EQUAL(Q, R);
		G2::add(Q, Q, Q0);
	}
}

void testMapToG1()
{
	G1 g;
	for (int i = 1; i < 10; i++) {
		mapToG1(g, i);
		CYBOZU_TEST_ASSERT(!g.isZero());
		G1 gr;
		G1::mul(gr, g, Fr::getOp().mp);
		CYBOZU_TEST_ASSERT(gr.isZero());
	}
}

void testMapToG2()
{
	G2 g;
	for (int i = 1; i < 10; i++) {
		mapToG2(g, i);
		CYBOZU_TEST_ASSERT(!g.isZero());
		G2 gr;
		G2::mul(gr, g, Fr::getOp().mp);
		CYBOZU_TEST_ASSERT(gr.isZero());
	}
	Fp x;
	x.setHashOf("abc");
	mapToG2(g, Fp2(x, 0));
	CYBOZU_TEST_ASSERT(g.isValid());
}

void testPrecomputed(const G1& P, const G2& Q)
{
	Fp12 e1, e2;
	pairing(e1, P, Q);
	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Q);
	precomputedMillerLoop(e2, P, Qcoeff);
	finalExp(e2, e2);
	CYBOZU_TEST_EQUAL(e1, e2);
}

#if  0
void testFp12pow(const G1& P, const G2& Q)
{
	Fp12 e, e1, e2;
	pairing(e, P, Q);
	cybozu::XorShift rg;
	for (int i = -10; i < 10; i++) {
		mpz_class xm = i;
		Fp12::pow(e1, e, xm);
		Fp12::powGeneric(e2, e, xm);
		CYBOZU_TEST_EQUAL(e1, e2);
	}
	for (int i = 0; i < 10; i++) {
		Fr x;
		x.setRand(rg);
		mpz_class xm = x.getMpz();
		Fp12::pow(e1, e, xm);
		param.glv2.pow(e2, e, xm);
		CYBOZU_TEST_EQUAL(e1, e2);
	}
}
#endif

void testMillerLoop2(const G1& P1, const G2& Q1)
{
	Fp12 e1, e2, e3;
	mpz_class c1("12342342423442");
	mpz_class c2("329428049820348209482");
	G2 Q2;
	G1 P2;
	G2::mul(Q2, Q1, c1);
	G1::mul(P2, P1, c2);
	pairing(e1, P1, Q1);
	pairing(e2, P2, Q2);
	e1 *= e2;

	std::vector<Fp6> Q1coeff, Q2coeff;
	precomputeG2(Q1coeff, Q1);
	precomputeG2(Q2coeff, Q2);
	precomputedMillerLoop2(e2, P1, Q1coeff, P2, Q2coeff);
	precomputedMillerLoop2mixed(e3, P1, Q1, P2, Q2coeff);
	CYBOZU_TEST_EQUAL(e2, e3);
	finalExp(e2, e2);
	CYBOZU_TEST_EQUAL(e1, e2);

	// special value
	G2 Z;
	Z.clear();
	Q2 += Q2;
	precomputeG2(Q1coeff, Z);
	precomputeG2(Q2coeff, Q2);
	precomputedMillerLoop2(e2, P1, Q1coeff, P2, Q2coeff);
	precomputedMillerLoop2mixed(e3, P1, Z, P2, Q2coeff);
	finalExp(e2, e2);
	finalExp(e3, e3);
	CYBOZU_TEST_EQUAL(e2, e3);
}

void testPairing(const G1& P, const G2& Q, const char *eStr)
{
	Fp12 e1;
	pairing(e1, P, Q);
	Fp12 e2;
	{
		std::stringstream ss(eStr);
		ss >> e2;
	}
	CYBOZU_TEST_EQUAL(e1, e2);
	Fp12 e = e1, ea;
	G1 Pa;
	G2 Qa;
#if defined(__EMSCRIPTEN__) || MCL_SIZEOF_UNIT == 4
	const int count = 100;
#else
	const int count = 1000;
#endif
	mpz_class a;
	cybozu::XorShift rg;
	for (int i = 0; i < count; i++) {
		Fr r;
		r.setRand(rg);
		a = r.getMpz();
		Fp12::pow(ea, e, a);
		G1::mul(Pa, P, a);
		G2::mul(Qa, Q, a);
		G1 T;
		G1::mulCT(T, P, a);
		CYBOZU_TEST_EQUAL(Pa, T);
		pairing(e1, Pa, Q);
		pairing(e2, P, Qa);
		CYBOZU_TEST_EQUAL(ea, e1);
		CYBOZU_TEST_EQUAL(ea, e2);
	}
}

void testTrivial(const G1& P, const G2& Q)
{
	G1 Z1; Z1.clear();
	G2 Z2; Z2.clear();
	Fp12 e;
	pairing(e, Z1, Q);
	CYBOZU_TEST_EQUAL(e, 1);
	pairing(e, P, Z2);
	CYBOZU_TEST_EQUAL(e, 1);
	pairing(e, Z1, Z2);
	CYBOZU_TEST_EQUAL(e, 1);

	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Z2);
	precomputedMillerLoop(e, P, Qcoeff);
	finalExp(e, e);
	CYBOZU_TEST_EQUAL(e, 1);

	precomputeG2(Qcoeff, Q);
	precomputedMillerLoop(e, Z1, Qcoeff);
	finalExp(e, e);
	CYBOZU_TEST_EQUAL(e, 1);
}

template<class T>
void deserializeAndSerialize(const T& x)
{
	char buf[1024];
	size_t n = x.serialize(buf, sizeof(buf));
	CYBOZU_TEST_EQUAL(n, T::getSerializedByteSize());
	CYBOZU_TEST_ASSERT(n > 0);
	T y;
	CYBOZU_TEST_EQUAL(y.deserialize(buf, n), n);
	CYBOZU_TEST_EQUAL(x, y);
}

void testSerialize(const G1& P, const G2& Q)
{
	Fp::setETHserialization(true); // big endian
	const struct FpTbl {
		const char *in;
		const char out[97];
	} fpTbl[] = {
		{
			"0x12345678901234567",
			"000000000000000000000000000000000000000000000000000000000000000000000000000000012345678901234567"
		},
	};
	char buf[1024];
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(fpTbl); i++) {
		Fp x, y;
		x.setStr(fpTbl[i].in);
		size_t n = x.serialize(buf, sizeof(buf), mcl::IoSerializeHexStr);
		CYBOZU_TEST_EQUAL(n, sizeof(fpTbl[i].out) - 1);
		CYBOZU_TEST_EQUAL_ARRAY(buf, fpTbl[i].out, n);
		CYBOZU_TEST_EQUAL(y.deserialize(buf, n, mcl::IoSerializeHexStr), n);
		CYBOZU_TEST_EQUAL(x, y);
	}
	deserializeAndSerialize(P);
	deserializeAndSerialize(-P);
	G1 zero1;
	zero1.clear();
	deserializeAndSerialize(zero1);

	deserializeAndSerialize(Q);
	deserializeAndSerialize(-Q);
	G2 zero2;
	zero2.clear();
	deserializeAndSerialize(zero2);
	Fp::setETHserialization(false);
}

#include "bench.hpp"

void testMulVec()
{
	puts("testMulVec");
#ifndef NDEBUG
	puts("skip in debug");
	return;
#endif
	const size_t n = 8192;
	cybozu::XorShift rg;
	std::vector<G1> Pvec(n);
	std::vector<Fr> xVec(n);
	hashAndMapToG1(Pvec[0], "abc", 3);
	for (size_t i = 1; i < n; i++) {
		G1::add(Pvec[i], Pvec[i-1], Pvec[0]);
	}
	for (size_t i = 0; i < n; i++) {
		xVec[i].setByCSPRNG(rg);
	}
	G1 P;
	G1 P8191;
	P8191.setStr("1 c252fef934098904eca8e3fbd9cc8c78877e434d9ce01e424ef07302cec5652dc17d341b8abd4278255a75718cebd67 17455f24f76e7e7d1dd3231d8f144a40decc40d5b129734879b8aad4a209a2e6d83d8256221e46aaf8205e254355d9ad", 16);
	G1 P8192;
	P8192.setStr("1 f0d44ba84af56d1db97f46660bfd12401aae239a6650cdfc168158d1076d68c5149ac3a311b9c058ad4e61ad1b8063 b2240da1e42c5f469ccf818e58901aca2283d1bd29565f5efbfa14e48cdae199c7a7981b958bfec332f6e613cf36990", 16);
	G1::mulVec(P, Pvec.data(), xVec.data(), n-1);
	CYBOZU_TEST_EQUAL(P, P8191);
	G1::mulVec(P, Pvec.data(), xVec.data(), n);
	CYBOZU_TEST_EQUAL(P, P8192);
}


CYBOZU_TEST_AUTO(naive)
{
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(g_testSetTbl); i++) {
		const TestSet& ts = g_testSetTbl[i];
		printf("i=%d curve=%s\n", int(i), ts.name);
		initPairing(ts.cp);
		const G1 P(Fp(ts.g1.a), Fp(ts.g1.b));
		const G2 Q(Fp2(ts.g2.aa, ts.g2.ab), Fp2(ts.g2.ba, ts.g2.bb));
#ifdef ONLY_BENCH
		{
			Fp12 e;
			for (int i = 0; i < 1000; i++) pairing(e, P, Q);
		}
		clk.put();
		return;
#endif
		testLagrange();
		testMulVec();
		testSerialize(P, Q);
		testParam(ts);
		testIo(P, Q);
//		testFp12pow(P, Q);
		testTrivial(P, Q);
		testSetStr(Q);
		testMapToG1();
		testMapToG2();
		testPairing(P, Q, ts.e);
		testPrecomputed(P, Q);
		testMillerLoop2(P, Q);
		testCommon(P, Q);
		testBench(P, Q);
	}
	int count = (int)clk.getCount();
	if (count) {
		printf("count=%d ", count);
		clk.put();
	}
}

CYBOZU_TEST_AUTO(finalExp)
{
	const char *e0Str =
"012974491575E232199B73B30FE53FF643FEAE11023BCA7AF961C3600B45DFECFE4B30D52A62E73DA4C0409810304997\n"
"05CE2FB890FE65E20EC36347190ECB4884E401A64B666557B53E561F6D0979B7A96AD9E647ED78BD47187195C00F563C\n"
"02E85D1E559488603A70FEE99354DA8847215EC97282CA230DE96FED6DD5D4DD4EF4D901DB7F544A1A45EBEBA1450109\n"
"048FB1E44DDABF18D55C95704158A24678AA2A6ED0844108762E88306E5880E8C67BF44E24E40AB3F93D9E3713170341\n"
"07EF7BE685DC0DBA1B3E1D2E9090CD98EAD1325B60881772F17077386A3182B117F5FD839363F5891D08E82B88EC6F12\n"
"17803435700EF7A16C06404C6D17EB4FD84079FE9872207302A36C791B6E90447B33D703BBFE04ECB641C3A573E2CD50\n"
"19A494E6A872E46FC85D09FD6D30844B6FF05729BC253A9640F7BE64AAA8C2C8E0AE014A9DD816C53A3EDEBB2FA649EB\n"
"020949ABAA14F1DCE17FA9E091DDA963E9E492BA788E12B9B610E80A4D94DB9CC50341ED107C7D50E5738052595D4A27\n"
"09E217B513B3603723DAC3188A2F7CBDD84A56E7E5004446E7D4C63D6E378DA26E411C10898E48DB4B0C065E4699A9C5\n"
"12393BD23D0EC122082A1EC892A982F3C9AFD14240CE85258D8A3EF0A13CB545D6EF7848FD40DD4AEF1554341C5C5BBF\n"
"07EA8A0D6A57C78E5663F94E2B1ABC0D760ED18DBA64305EAD5EE350FB0342A7A81C0D5C8B3AD826D009276B0F32D2C8\n"
"16804D0D4A2633ED01568B0F8F06C4497E46E88D05FD191AAE530ACA791D0E114D74874FA88E33FAF48757153B09BB0E";

const char *e1Str =
"0E05D19E90D2C501E5502C7AC80D77201C47DF147DD1076440F0DF0179DF9802CA0775E0E73DD9174F1094D2280787B3\n"
"14D2F5C84279E7177A3543FBEAE261DE8F6C97EFD5F3FF3F959EC9FC0303F620A4B3AF00DF409496CECADDD0A7F0A164\n"
"1414E9B9DF8DF1EAC2E70D5538018377788C62016A54F28B037A68740705089AE431B86756F98CBE19690A5EAC0C2466\n"
"12D8B32157836A131CCA3CA313DAAAF909BC3AD6BDD15885BB429922B9CD7D1246D1163E5E6F88D68BF1B75E451EFABB\n"
"102C9A839A924E0D603D13F2E08A919E0B9EE2A269FC75727BA13D66027C157B9BB4077977FA94557DE4427BF11B234B\n"
"19DBEB7F2E3096AFFD44837655BD8249741B484B0EB0DBEE569DEA8D9E38AE09D210C8BC16AA6DFBC923095B2C9A8B2B\n"
"19B9A6DCCD01FA0D04D5CE94D8BDCE1DF64AFEB7FD493B955180A5C6B236E469F0E07CC9BB4203FCAC46AE6F8E5419D6\n"
"02BFA87AF7A3726A7ABACDCFDD53694AF651554F3A431AB4274F67D5DAD2D6C88AF794705FF456A936C83594731AD8DC\n"
"0F21E0173E3B50DD98EFA815B410631A57399B451FD6E1056FFD09C9FE50EFAD3D026F0C46C8BB1583A50B7853D990DA\n"
"02230237AE04B61F9269F6E7CD2FCF1231CEE4690AA658B0018EFC0D0770FD0A56B3B7294086E8D306B1465CDDD858CD\n"
"087EB8F6547015661E9CD48D6525C808636FCB8420B867CB2A87E006B2A93BBD5EF675E6CDDA9E6F94519C49EA8BB689\n"
"19F5C988B2DD6E33D7D3D34EFB1991F80DC28006AC75E0AB53FD98FC6F2476D05DD4ECA582F5FF72B8DDD9DDDE80FFC9";

	Fp12 e0, e1, e2;
	e0.setStr(e0Str, 16);
	e1.setStr(e1Str, 16);
	finalExp(e2, e0);
//	finalExpC(e2, e0);
	CYBOZU_TEST_EQUAL(e1, e2);
#ifndef NDEBUG
	puts("skip bench of finalExp in debug");
	return;
#endif
	CYBOZU_BENCH_C("finalExp", 100, finalExp, e2, e0);
}

CYBOZU_TEST_AUTO(pairing)
{
	const int mode = mcl::IoEcProj | 16;

const char *pStr =
"4 0FD3977C60EC322BC281C915955ED534B491E39C72E8E800271CEF3F0492D890829FA69C45FCE93D9847A0CAB325D871\n"
"17CC2C36C5D283C05BFCECCF48DBB2050332DA058DD67326A9EE520967DBCAEDFCB5F05A085D1A49DF08BB968CC782C5\n"
"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
const char *qStr =
"4 0B5C339C23F8EAB3647E974BCDDF72C96F97A444346BE72CA73AB1323B83B8F6161257AB34C7E0CF34F6C45086CA5868\n"
"13C2235E9F9DFB33344BA2EE5A71435859022880732EDC9EC75AC79AE9DA972593CDC40A0AC334D6D2E8D7FAD1D98D0B\n"
"134B8EED8196A00D3B70ADBC26FF963B725A351CF0B73FE1A541788AFB0BB081AF82A438021B5E878B15D53B1D27C6A7\n"
"18CC69F847BEE826B939DCB4030D33020D03B046465C9EE103AA8009A175DB169070294E75771586687FE361DB884BCD\n"
"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001\n"
"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
const char *eStr =
"0E05D19E90D2C501E5502C7AC80D77201C47DF147DD1076440F0DF0179DF9802CA0775E0E73DD9174F1094D2280787B3\n"
"14D2F5C84279E7177A3543FBEAE261DE8F6C97EFD5F3FF3F959EC9FC0303F620A4B3AF00DF409496CECADDD0A7F0A164\n"
"1414E9B9DF8DF1EAC2E70D5538018377788C62016A54F28B037A68740705089AE431B86756F98CBE19690A5EAC0C2466\n"
"12D8B32157836A131CCA3CA313DAAAF909BC3AD6BDD15885BB429922B9CD7D1246D1163E5E6F88D68BF1B75E451EFABB\n"
"102C9A839A924E0D603D13F2E08A919E0B9EE2A269FC75727BA13D66027C157B9BB4077977FA94557DE4427BF11B234B\n"
"19DBEB7F2E3096AFFD44837655BD8249741B484B0EB0DBEE569DEA8D9E38AE09D210C8BC16AA6DFBC923095B2C9A8B2B\n"
"19B9A6DCCD01FA0D04D5CE94D8BDCE1DF64AFEB7FD493B955180A5C6B236E469F0E07CC9BB4203FCAC46AE6F8E5419D6\n"
"02BFA87AF7A3726A7ABACDCFDD53694AF651554F3A431AB4274F67D5DAD2D6C88AF794705FF456A936C83594731AD8DC\n"
"0F21E0173E3B50DD98EFA815B410631A57399B451FD6E1056FFD09C9FE50EFAD3D026F0C46C8BB1583A50B7853D990DA\n"
"02230237AE04B61F9269F6E7CD2FCF1231CEE4690AA658B0018EFC0D0770FD0A56B3B7294086E8D306B1465CDDD858CD\n"
"087EB8F6547015661E9CD48D6525C808636FCB8420B867CB2A87E006B2A93BBD5EF675E6CDDA9E6F94519C49EA8BB689\n"
"19F5C988B2DD6E33D7D3D34EFB1991F80DC28006AC75E0AB53FD98FC6F2476D05DD4ECA582F5FF72B8DDD9DDDE80FFC9";
	G1 P;
	G2 Q;
	P.setStr(pStr, mode);
	Q.setStr(qStr, mode);
	Fp12 e1, e2;
	e1.setStr(eStr, 16);
	pairing(e2, P, Q);
	CYBOZU_TEST_EQUAL(e1, e2);
}

void testCurve(const mcl::CurveParam& cp)
{
	initPairing(cp);
	G1 P;
	G2 Q;
	mapToG1(P, 1);
	mapToG2(Q, 1);
	GT e1, e2;
	pairing(e1, P, Q);
	cybozu::XorShift rg;
	mpz_class a, b;
	Fr r;
	r.setRand(rg); a = r.getMpz();
	r.setRand(rg); b = r.getMpz();
	G1 aP;
	G2 bQ;
	G1::mul(aP, P, a);
	G2::mul(bQ, Q, b);
	pairing(e2, aP, bQ);
	GT::pow(e1, e1, a * b);
	CYBOZU_TEST_EQUAL(e1, e2);
}
CYBOZU_TEST_AUTO(multi)
{
#ifndef NDEBUG
	puts("skip multi in debug");
	return;
#endif
	G1 P;
	G2 Q;
	int i;

#ifndef MCL_STATIC_CODE
	puts("BN254");
	testCurve(mcl::BN254);
	i = 1;
	CYBOZU_BENCH_C("mapToG1", 100, mcl::bn::mapToG1, P, i++);
	CYBOZU_BENCH_C("naiveG1", 100, (mcl::ec::tryAndIncMapTo<G1>), P, i++);
	CYBOZU_BENCH_C("mapToG2", 100, mcl::bn::mapToG2, Q, i++);
	CYBOZU_BENCH_C("naiveG2", 100, (mcl::ec::tryAndIncMapTo<G2>), Q, i++);
#endif
	puts("BLS12_381");
	testCurve(mcl::BLS12_381);
	i = 1;
	CYBOZU_BENCH_C("mapToG1", 100, mcl::bn::mapToG1, P, i++);
	CYBOZU_BENCH_C("naiveG1", 100, (mcl::ec::tryAndIncMapTo<G1>), P, i++);
	CYBOZU_BENCH_C("mapToG2", 100, mcl::bn::mapToG2, Q, i++);
	CYBOZU_BENCH_C("naiveG2", 100, (mcl::ec::tryAndIncMapTo<G2>), Q, i++);
}

CYBOZU_TEST_AUTO(deserialize)
{
	if (getCurveType() != MCL_BLS12_381) return;
	G1 P;
	G2 Q;
	mapToG1(P, 5);
	mapToG2(Q, 5);
	char buf1[128];
	char buf2[128];
	size_t n1 = P.serialize(buf1, sizeof(buf1));
	CYBOZU_TEST_ASSERT(n1 > 0);
	CYBOZU_TEST_EQUAL(P.deserialize(buf1, n1), n1);
	size_t n2 = Q.serialize(buf2, sizeof(buf2));
	CYBOZU_TEST_ASSERT(n2 > 0);
	CYBOZU_TEST_EQUAL(Q.deserialize(buf2, n2), n2);
#ifndef NDEBUG
	puts("skip bench in debug");
	return;
#endif
	for (int i = 0; i < 2; i++) {
		bool doVerify = i == 0;
		printf("verifyOrder(%d)\n", doVerify);
		verifyOrderG1(doVerify);
		verifyOrderG2(doVerify);
		CYBOZU_BENCH_C("deserializeG1", 1000, P.deserialize, buf1, n1);
		CYBOZU_BENCH_C("deserializeG2", 1000, Q.deserialize, buf2, n2);
	}
}

CYBOZU_TEST_AUTO(verifyG1)
{
	const char *ok_x = "ad50e39253e0de4fad89440f01f1874c8bc91fdcd59ad66162984b10690e51ccf4d95e4222df14549d745d8b971199";
	const char *ok_y = "2f76c6f3a006f0bbfb88c02a4643702ff52ff34c1fcb59af611b7f1cf47938ffbf2c68a6e31a40bf668544087374f70";

	const char *ng_x = "1534fc82e2566c826b195314b32bf47576c24632444450d701de2601cec0c0d6b6090e7227850005e81f54039066602b";
	const char *ng_y = "15899715142d265027d1a9fba8f2f10a3f21938071b4bbdb5dce8c5caa0d93588482d33d9a62bcbbd23ab6af6d689710";

	Fp x, y;
	G1 P, Q;
	char buf[128];
	size_t n;
	P.x.setStr(ok_x, 16);
	P.y.setStr(ok_y, 16);
	P.z = 1;

	// valid point, valid order
	verifyOrderG1(false);
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(P.isValidOrder());
	n = P.serialize(buf, sizeof(buf));
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0);
	CYBOZU_TEST_EQUAL(P, Q);

	verifyOrderG1(true);
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(P.isValidOrder());
	Q.clear();
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0);
	CYBOZU_TEST_EQUAL(P, Q);

	// invalid point
	P.z = 2;
	CYBOZU_TEST_ASSERT(!P.isValid());

	// valid point, invalid order
	verifyOrderG1(false);
	P.x.setStr(ng_x, 16);
	P.y.setStr(ng_y, 16);
	P.z = 1;
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(!P.isValidOrder());
	n = P.serialize(buf, sizeof(buf));
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0); // success because of no-check the order
	CYBOZU_TEST_EQUAL(P, Q);

	verifyOrderG1(true);
	CYBOZU_TEST_ASSERT(!P.isValid()); // fail because of invalid order
	Q.clear();
	n = Q.deserialize(buf, n); // fail because of invalid order
	CYBOZU_TEST_ASSERT(n == 0);
}

CYBOZU_TEST_AUTO(verifyG2)
{
	const char *ok_x = "1400ddb63494b2f3717d8706a834f928323cef590dd1f2bc8edaf857889e82c9b4cf242324526c9045bc8fec05f98fe9 14b38e10fd6d2d63dfe704c3f0b1741474dfeaef88d6cdca4334413320701c74e5df8c7859947f6901c0a3c30dba23c9";
	const char *ok_y = "187452296c28d5206880d2a86e8c7fc79df88e20b906a1fc1d5855da6b2b4ae6f8c83a591e2e5350753d2d7fe3c7b4 9c205210f33e9cdaaa4630b3f6fad29744224e5100456973fcaf031cdbce8ad3f71d42af3f7733a3985d3a3d2f4be53";

	const char *ng_x = "717f18d36bd40d090948f2d4dac2a03f6469d234f4beb75f67e66d51ea5540652189c61d01d1cfe3f5e9318e48bdf8a 13fc0389cb74ad6c8875c34f85e2bb93ca1bed48c14f2dd0f5cd741853014fe278c9551a9ac5850f678a423664f8287f";
	const char *ng_y = "5412e6cef6b7189f31810c0cbac6b6350b18691be1fefed131a033f2df393b9c3a423c605666226c1efa833de11363b 101ed6eafbf85be7273ec5aec3471aa2c1018d7463cc48dfe9a7c872a7745e81317c88ce0c89a9086975feb4a2749074";

	Fp x, y;
	G2 P, Q;
	char buf[128];
	size_t n;
	P.x.setStr(ok_x, 16);
	P.y.setStr(ok_y, 16);
	P.z = 1;

	// valid point, valid order
	verifyOrderG2(false);
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(P.isValidOrder());
	n = P.serialize(buf, sizeof(buf));
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0);
	CYBOZU_TEST_EQUAL(P, Q);

	verifyOrderG2(true);
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(P.isValidOrder());
	Q.clear();
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0);
	CYBOZU_TEST_EQUAL(P, Q);

	// invalid point
	P.z = 2;
	CYBOZU_TEST_ASSERT(!P.isValid());

	// valid point, invalid order
	verifyOrderG2(false);
	P.x.setStr(ng_x, 16);
	P.y.setStr(ng_y, 16);
	P.z = 1;
	CYBOZU_TEST_ASSERT(P.isValid());
	CYBOZU_TEST_ASSERT(!P.isValidOrder());
	n = P.serialize(buf, sizeof(buf));
	n = Q.deserialize(buf, n);
	CYBOZU_TEST_ASSERT(n > 0); // success because of no-check the order
	CYBOZU_TEST_EQUAL(P, Q);

	verifyOrderG2(true);
	CYBOZU_TEST_ASSERT(!P.isValid()); // fail because of invalid order
	Q.clear();
	n = Q.deserialize(buf, n); // fail because of invalid order
	CYBOZU_TEST_ASSERT(n == 0);
}

void splitTest(const mpz_class& mx, const mpz_class& L)
{
	mcl::Unit x[4], a[2], b[2];
	mcl::gmp::getArray(x, 4, mx);
	mcl::ec::optimizedSplitRawForBLS12_381(a, b, x);
	mpz_class ma, mb;
	mcl::gmp::setArray(ma, a, 2);
	mcl::gmp::setArray(mb, b, 2);
	CYBOZU_TEST_EQUAL(mb, mx / L);
	CYBOZU_TEST_EQUAL(ma, mx % L);
}

CYBOZU_TEST_AUTO(split)
{
	const char *Ls = "ac45a4010001a40200000000ffffffff";
	mpz_class L;
	mcl::gmp::setStr(L, Ls, 16);
	cybozu::XorShift rg;
	Fr x;
	for (int i = 0; i < 100; i++) {
		x.setByCSPRNG(rg);
		splitTest(x.getMpz(), L);
	}
	const mpz_class LL = L*L;
	const mpz_class tbl[] = {
		0, 1, 2, 3, L-1, L, L+1, L*2, L*2-1, L*2+1, LL-L, LL-1, LL+1, LL+L-2, LL+L-1, LL+L,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		splitTest(tbl[i], L);
	}
}

typedef std::vector<Fp> FpVec;

void f(FpVec& zv, const FpVec& xv, const FpVec& yv)
{
	for (size_t i = 0; i < zv.size(); i++) {
		Fp::mul(zv[i], xv[i], yv[i]);
	}
}
int main(int argc, char *argv[])
	try
{
#ifdef MCL_STATIC_CODE
	printf("static code for BLS12-381\n");
#else
	printf("JIT %d\n", mcl::fp::isEnableJIT());
#endif
	return cybozu::test::autoRun.run(argc, argv);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
