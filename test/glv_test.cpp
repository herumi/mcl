#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

#if 1
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#else
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#endif

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

void testGLV(const mcl::bn::CurveParam& cp)
{
	bn384init(cp);
	G1::setCompressedExpression(false);

	G1 P0, P1, P2;
	cybozu::XorShift rg;
	mcl::bn::GLV<Fp> glv;
	glv.init(BN::param.r, BN::param.z, BN::param.isNegative);
	for (int i = 1; i < 100; i++) {
		BN::mapToG1(P0, i);
		Fr s;
		s.setRand(rg);
		mpz_class ss = s.getMpz();
		G1::mul(P1, P0, ss);
		glv.mul(P2, P0, ss);
		CYBOZU_TEST_EQUAL(P1, P2);
	}
	Fr s;
	BN::mapToG1(P0, 123);
	CYBOZU_BENCH_C("Ec::mul", 100, P1 = P0; s.setRand(rg); G1::mul, P2, P1, s.getMpz());
	CYBOZU_BENCH_C("Ec::glv", 100, P1 = P0; s.setRand(rg); glv.mul, P2, P1, s.getMpz());
}

CYBOZU_TEST_AUTO(glv)
{
	testGLV(mcl::bn::CurveFp382_1);
	testGLV(mcl::bn::CurveFp382_2);
	testGLV(mcl::bn::CurveFp254BNb);
}
