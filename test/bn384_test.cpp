#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/bn.hpp>

typedef mcl::FpT<mcl::FpTag, 384> Fp;
typedef mcl::FpT<mcl::ZnTag, 384> Fr;
typedef mcl::bn::BNT<Fp> BN;
typedef BN::Fp2 Fp2;
typedef BN::Fp6 Fp6;
typedef BN::Fp12 Fp12;
typedef BN::G1 G1;
typedef BN::G2 G2;
typedef BN::Fp12 GT;

CYBOZU_TEST_AUTO(pairing)
{
	BN::init(mcl::bn::CurveFp382_1);
	G1 P;
	G2 Q;
	BN::mapToG1(P, 1);
	BN::mapToG2(Q, 1);
	std::cout << P << std::endl;
	std::cout << Q << std::endl;
	GT e1, e2;
	BN::pairing(e1, P, Q);
	std::cout << e1 << std::endl;
	mpz_class a("293842098420840298420842342342449");
	mpz_class b("2035739487659287420847209482048");
	G1 aP;
	G2 bQ;
	G1::mul(aP, P, a);
	G2::mul(bQ, Q, b);
	BN::pairing(e2, aP, bQ);
	GT::pow(e1, e1, a * b);
	std::cout << e1 << std::endl;
	CYBOZU_TEST_EQUAL(e1, e2);
	CYBOZU_BENCH("pairing", BN::pairing, e1, P, Q);
	CYBOZU_BENCH("finalExp", BN::finalExp, e1, e1);
}
