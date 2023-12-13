/*
	If the binary compiled with DEBUG=1 and MCL_USE_GMP=1 calls init in a constructor of a static value,
	then it will show GMP memory leaks, but this is a rare case.
*/
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <mcl/bn256.hpp>
#include <stdio.h>

using namespace mcl::bn;
static struct Init {
    Init()
	{
		puts("init");
		mcl::Unit x[2] = { 1, 2 }, z[4];
		mcl::bint::mulT<2>(z, x, x);
		// must be nonzero
		CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
		mcl::bn::initPairing();
		CYBOZU_TEST_ASSERT(Fr::getOp().N > 0);
		CYBOZU_TEST_ASSERT(Fp::getOp().N > 0);
	}
} init;

int main()
{
	CYBOZU_TEST_ASSERT(Fr::getOp().N > 0);
	CYBOZU_TEST_ASSERT(Fp::getOp().N > 0);
	mcl::Unit x[2] = { 1, 2 }, z[4];
	mcl::bint::mulT<2>(z, x, x);
	puts("main");
	CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
	mcl::bn::Fr fr;
	fr.setByCSPRNG();
}
