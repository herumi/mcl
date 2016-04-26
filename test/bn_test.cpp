#define PUT(x) std::cout << #x "=" << x << std::endl;
#include <cybozu/test.hpp>
#include <mcl/gmp_util.hpp>
#include <mcl/bn.hpp>
#include <mcl/ec.hpp>


typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::bn::Naive<Fp> Naive;
typedef Naive::Fp2 Fp2;
typedef Naive::Fp6 Fp6;
typedef Naive::Fp12 Fp12;
typedef Naive::G1 G1;
typedef Naive::G2 G2;

typedef mcl::bn::ParamT<Fp> Param;

const struct Point {
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
} g_pointTbl[] = {
	// Aranha
	{
		{
			"12723517038133731887338407189719511622662176727675373276651903807414909099441",
			"4168783608814932154536427934509895782246573715297911553964171371032945126671",
			"13891744915211034074451795021214165905772212241412891944830863846330766296736",
			"7937318970632701341203597196594272556916396164729705624521405069090520231616",
		},
		{
			-1, 1
		},
	},
};

CYBOZU_TEST_AUTO(naive)
{
	const Point& pt = g_pointTbl[0];
	Param param;
	param.init();
	G1 P(pt.g1.a, pt.g1.b);
	G2 Q;
	Q.x = Fp2(pt.g2.aa, pt.g2.ab);
	Q.y = Fp2(pt.g2.ba, pt.g2.bb);
	Q.z = 1;
	Fp12 e;
	Naive::optimalAtePairing(e, Q, P, param.z);
	PUT(e);
}
