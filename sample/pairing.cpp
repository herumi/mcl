#include <cybozu/benchmark.hpp>
#include <cybozu/option.hpp>
#include <mcl/bn.hpp>

typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::bn::BNT<Fp> BN;
typedef BN::Fp2 Fp2;
typedef BN::Fp6 Fp6;
typedef BN::Fp12 Fp12;
typedef BN::G1 G1;
typedef BN::G2 G2;

void minimum_sample()
{
	const char *aa = "12723517038133731887338407189719511622662176727675373276651903807414909099441";
	const char *ab = "4168783608814932154536427934509895782246573715297911553964171371032945126671";
	const char *ba = "13891744915211034074451795021214165905772212241412891944830863846330766296736";
	const char *bb = "7937318970632701341203597196594272556916396164729705624521405069090520231616";

	BN::init();

	G2 Q(Fp2(aa, ab), Fp2(ba, bb));
	G1 P(-1, 1);

	const mpz_class a = 123;
	const mpz_class b = 456;
	Fp12 e1, e2;
	BN::optimalAtePairing(e1, Q, P);
	G2::mul(Q, Q, a);
	G1::mul(P, P, b);
	BN::optimalAtePairing(e2, Q, P);
	Fp12::pow(e1, e1, a * b);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

int main()
{
	minimum_sample();
}

