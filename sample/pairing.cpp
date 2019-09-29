#include <mcl/bls12_381.hpp>

using namespace mcl::bn;

void minimum_sample(const G1& P, const G2& Q)
{
	const mpz_class a = 123;
	const mpz_class b = 456;
	Fp12 e1, e2;
	pairing(e1, P, Q);
	G2 aQ;
	G1 bP;
	G2::mul(aQ, Q, a);
	G1::mul(bP, P, b);
	pairing(e2, bP, aQ);
	Fp12::pow(e1, e1, a * b);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

void miller_and_finel_exp(const G1& P, const G2& Q)
{
	Fp12 e1, e2;
	pairing(e1, P, Q);

	millerLoop(e2, P, Q);
	finalExp(e2, e2);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

void precomputed(const G1& P, const G2& Q)
{
	Fp12 e1, e2;
	pairing(e1, P, Q);
	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Q);
	precomputedMillerLoop(e2, P, Qcoeff);
	finalExp(e2, e2);
	printf("%s\n", e1 == e2 ? "ok" : "ng");
}

int main()
{
	initPairing(mcl::BLS12_381);
	G1 P;
	G2 Q;
	hashAndMapToG1(P, "abc", 3);
	hashAndMapToG2(Q, "abc", 3);

	minimum_sample(P, Q);
	miller_and_finel_exp(P, Q);
	precomputed(P, Q);
}

