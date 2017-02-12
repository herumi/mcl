#define PUT(x) std::cout << #x "=" << x << std::endl;
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/benchmark.hpp>
cybozu::CpuClock clk;
#include <cybozu/test.hpp>
#include <mcl/bn256.hpp>
#include <cybozu/option.hpp>

typedef mcl::bn256::BN::Compress Compress;
using namespace mcl::bn256;

mcl::fp::Mode g_mode;

const struct TestSet {
	mcl::bn::CurveParam cp;
	struct G2 {
		const char *aa;
		const char *ab;
		const char *ba;
		const char *bb;
	} g2;
	struct G1 {
		int a;
		int b;
	} g1;
	const char *e;
} g_testSetTbl[] = {
	{
		mcl::bn::CurveFp254BNb,
		{
			"12723517038133731887338407189719511622662176727675373276651903807414909099441",
			"4168783608814932154536427934509895782246573715297911553964171371032945126671",
			"13891744915211034074451795021214165905772212241412891944830863846330766296736",
			"7937318970632701341203597196594272556916396164729705624521405069090520231616",
		},
		{
			-1, 1
		},
		"8118772341496577043438385328606447626730215814727396173233264007541007797690 "
		"6742571767760762192519140673058087976840103832045324348366170860928670686713 "
		"9727912590495366720378364920530546614235713408261568635512172059018197267630 "
		"10180700148605185348549931182990442059136187839792856455707820203302941578832 "
		"5054507763444412917986776641611331046146804026682679569910978464879371792565 "
		"6917005519826733659554708445125877487590687705432214234949972860245110398023 "
		"10448556317747236258066222816126375978842661908560317699736569642190930635294 "
		"1516980358051268127904344653343215863076753141133525905743113718749531324025 "
		"9794836735385959178744195210089532061310424844916928682580569566332541022353 "
		"9375574834170998962484906689780052970915033987453510324648351251071086068423 "
		"710778048594563655498360873129325895716179849942646859397874562033386335205 "
		"10688745994254573144943003027511098295097561129365638275727908595677791826005"
	},
	{
		mcl::bn::CurveSNARK1,
		{
			"15267802884793550383558706039165621050290089775961208824303765753922461897946",
			"9034493566019742339402378670461897774509967669562610788113215988055021632533",
			"644888581738283025171396578091639672120333224302184904896215738366765861164",
			"20532875081203448695448744255224543661959516361327385779878476709582931298750",
		},
		{
			1, 2
		},
		"15163392945550945552839911839294582974434771053565812675833291179413834896953 "
		"20389211011850518572149982239826345669421868561029856883955740401696801984953 "
		"17766795911013516700216709333389761327222334145011922123798810516425387779347 "
		"6064163297423711021549973931984064750876944939004405231004441199168710504090 "
		"296093106139306574860102680862436174771023602986903675151017278048818344347 "
		"1573596951222456889652521728261836933382094474023551133585236991207205981715 "
		"3511871642997169996730611220058787939468653751355351269812083879279936651479 "
		"17848534184080172844395614793152774197360421729995967636680357250333093768504 "
		"3273860031361637906105800996652640969711942192883181518057117446820546419132 "
		"7212721189663231589365009629980400132745687533815732336503876102977912682966 "
		"18569236611881855981733896549089319395087993987737891870319625215675547032585 "
		"10088832670068482545658647976676953228519838542958787800193793260459700064172 "
	},
};

CYBOZU_TEST_AUTO(size)
{
	CYBOZU_TEST_EQUAL(sizeof(Fp), 32u);
	CYBOZU_TEST_EQUAL(sizeof(Fp2), sizeof(Fp) * 2);
	CYBOZU_TEST_EQUAL(sizeof(Fp6), sizeof(Fp) * 6);
	CYBOZU_TEST_EQUAL(sizeof(Fp12), sizeof(Fp) * 12);
	CYBOZU_TEST_EQUAL(sizeof(G1), sizeof(Fp) * 3);
	CYBOZU_TEST_EQUAL(sizeof(G2), sizeof(Fp2) * 3);
}

void testSetStr(const G2& Q0)
{
	G2::setCompressedExpression();
	G2 Q;
	for (int i = 0; i < 10; i++) {
		G2 R;
		R.setStr(Q.getStr());
		CYBOZU_TEST_EQUAL(Q, R);
		G2::add(Q, Q, Q0);
	}
}

void testMapToG1()
{
	const mcl::bn::MapToT<Fp>& mapTo = BN::param.mapTo;

	G1 g;
	for (int i = 1; i < 10; i++) {
		mapTo.calcG1(g, i);
		CYBOZU_TEST_ASSERT(!g.isZero());
		G1 gr;
		G1::mul(gr, g, BN::param.r);
		CYBOZU_TEST_ASSERT(gr.isZero());
	}
	if (BN::param.b == 2) {
		CYBOZU_TEST_EXCEPTION(mapTo.calcG1(g, 0), cybozu::Exception);
		CYBOZU_TEST_EXCEPTION(mapTo.calcG1(g, mapTo.c1), cybozu::Exception);
		CYBOZU_TEST_EXCEPTION(mapTo.calcG1(g, -mapTo.c1), cybozu::Exception);
	}
}

void testMapToG2()
{
	const mcl::bn::MapToT<Fp>& mapTo = BN::param.mapTo;

	G2 g;
	for (int i = 1; i < 10; i++) {
		mapTo.calcG2(g, i);
		CYBOZU_TEST_ASSERT(!g.isZero());
		G2 gr;
		G2::mul(gr, g, BN::param.r);
		CYBOZU_TEST_ASSERT(gr.isZero());
	}
	if (BN::param.b == 2) {
		CYBOZU_TEST_EXCEPTION(mapTo.calcG2(g, 0), cybozu::Exception);
	}
}

void testCyclotomic()
{
	Fp12 a;
	for (int i = 0; i < 12; ++i) {
		a.getFp0()[i] = i * i;
	}
	BN::mapToCyclotomic(a, a);
	Fp12 d;
	Compress b(d, a);
	a *= a;
	Fp12 d2;
	Compress c(d2, b);
	Compress::square_n(c, 1);
	c.decompress();
	CYBOZU_TEST_EQUAL(a, d2);
	Compress::square_n(b, 1);
	b.decompress();
	CYBOZU_TEST_EQUAL(a, d);
}

void testCompress()
{
	if (!BN::param.isCurveFp254BNb) return;
	Fp12 a;
	for (int i = 0; i < 12; ++i) {
		a.getFp0()[i] = i;
	}
	BN::mapToCyclotomic(a, a);
	Fp12 b;
	Compress::fixed_power(b, a);
	Fp12 c;
	Fp12::pow(c, a, BN::param.abs_z);
	CYBOZU_TEST_EQUAL(b, c);
}

void testPrecomputed(const G1& P, const G2& Q)
{
	Fp12 e1, e2;
	BN::pairing(e1, P, Q);
	std::vector<Fp6> Qcoeff;
	BN::precomputeG2(Qcoeff, Q);
	BN::precomputedMillerLoop(e2, P, Qcoeff);
	BN::finalExp(e2, e2);
	CYBOZU_TEST_EQUAL(e1, e2);
}

void testMillerLoop2(const G1& P1, const G2& Q1)
{
	Fp12 e1, e2;
	mpz_class c1("12342342423442");
	mpz_class c2("329428049820348209482");
	G2 Q2;
	G1 P2;
	G2::mul(Q2, Q1, c1);
	G1::mul(P2, P1, c2);
	BN::pairing(e1, P1, Q1);
	BN::pairing(e2, P2, Q2);
	e1 *= e2;

	std::vector<Fp6> Q1coeff, Q2coeff;
	BN::precomputeG2(Q1coeff, Q1);
	BN::precomputeG2(Q2coeff, Q2);
	BN::precomputedMillerLoop2(e2, P1, Q1coeff, P2, Q2coeff);
	BN::finalExp(e2, e2);
	CYBOZU_TEST_EQUAL(e1, e2);
}

void testPairing(const G1& P, const G2& Q, const char *eStr)
{
	Fp12 e1;
	BN::pairing(e1, P, Q);
	Fp12 e2;
	{
		std::stringstream ss(eStr);
		ss >> e2;
	}
	CYBOZU_TEST_EQUAL(e1, e2);
#if 0
	for (int i = 0; i < 1000; i++) BN::pairing(e1, P, Q);
//	CYBOZU_BENCH_C("pairing", 1000, BN::pairing, e1, P, Q); // 2.4Mclk
#else
	{
		Fp12 e = e1, ea;
		G1 Pa;
		G2 Qa;
#if CYBOZU_OS_BIT == 64
		const int count = 1000;
#else
		const int count = 100;
#endif
		mpz_class a("0x18b48dddfb2f81cc829b4b9acd393ccb1e90909aabe126bcdbe6a96438eaf313");
		for (int i = 0; i < count; i++) {
			Fp12::pow(ea, e, a);
			G1::mul(Pa, P, a);
			G2::mul(Qa, Q, a);
			BN::pairing(e1, Pa, Q);
			BN::pairing(e2, P, Qa);
			CYBOZU_TEST_EQUAL(ea, e1);
			CYBOZU_TEST_EQUAL(ea, e2);
			a--;
		}
	}
	CYBOZU_BENCH("pairing", BN::pairing, e1, P, Q); // 2.4Mclk
	CYBOZU_BENCH("finalExp", BN::finalExp, e1, e1); // 1.3Mclk
#endif
}

CYBOZU_TEST_AUTO(naive)
{
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(g_testSetTbl); i++) {
//i=1;
		const TestSet& ts = g_testSetTbl[i];
		bn256init(ts.cp, g_mode);
		G1 P(ts.g1.a, ts.g1.b);
		G2 Q(Fp2(ts.g2.aa, ts.g2.ab), Fp2(ts.g2.ba, ts.g2.bb));
		testSetStr(Q);
		testMapToG1();
		testMapToG2();
		testCyclotomic();
		testCompress();
		testPairing(P, Q, ts.e);
		testPrecomputed(P, Q);
		testMillerLoop2(P, Q);
//break;
	}
	int count = (int)clk.getCount();
	if (count) {
		printf("count=%d ", count);
		clk.put();
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
	printf("JIT %d\n", mcl::fp::isEnableJIT());
	return cybozu::test::autoRun.run(argc, argv);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
