#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/bn384.hpp>
#include <mcl/bn.hpp>

using namespace mcl::bn384;

void testCurve(const mcl::bn::CurveParam& cp)
{
	bn384init(cp);
	G1 P;
	G2 Q;
	BN::mapToG1(P, 1);
	BN::mapToG2(Q, 1);
	GT e1, e2;
	BN::pairing(e1, P, Q);
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

CYBOZU_TEST_AUTO(pairing)
{
	testCurve(mcl::bn::CurveFp382_1);
	testCurve(mcl::bn::CurveFp382_2);
	// support 256-bit pairing
	testCurve(mcl::bn::CurveFp254BNb);
}
