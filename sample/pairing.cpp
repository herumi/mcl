#include <mcl/bn256.hpp>

using namespace mcl::bn256;

const char *aa = "12723517038133731887338407189719511622662176727675373276651903807414909099441";
const char *ab = "4168783608814932154536427934509895782246573715297911553964171371032945126671";
const char *ba = "13891744915211034074451795021214165905772212241412891944830863846330766296736";
const char *bb = "7937318970632701341203597196594272556916396164729705624521405069090520231616";

void minimum_sample(const G2& Q, const G1& P)
{
	const mpz_class a = 123;
	const mpz_class b = 456;
	Fp12 e1, e2;
	BN::pairing(e1, Q, P);
	G2 aQ;
	G1 bP;
	G2::mul(aQ, Q, a);
	G1::mul(bP, P, b);
	BN::pairing(e2, aQ, bP);
	Fp12::pow(e1, e1, a * b);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

void miller_and_finel_exp(const G2& Q, const G1& P)
{
	Fp12 e1, e2;
	BN::pairing(e1, Q, P);

	BN::millerLoop(e2, Q, P);
	BN::finalExp(e2, e2);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

void precomputed(const G2& Q, const G1& P)
{
	Fp12 e1, e2;
	BN::pairing(e1, Q, P);
	std::vector<Fp6> Qcoeff;
	BN::precomputeG2(Qcoeff, Q);
	BN::precomputedMillerLoop(e2, Qcoeff, P);
	BN::finalExp(e2, e2);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

int main()
{
	bn256init();
	G2 Q(Fp2(aa, ab), Fp2(ba, bb));
	G1 P(-1, 1);

	minimum_sample(Q, P);
	miller_and_finel_exp(Q, P);
	precomputed(Q, P);
}

