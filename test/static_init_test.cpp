/*
	If the binary compiled with DEBUG=1 and MCL_USE_GMP=1 calls init in a constructor of a static value,
	then it will show GMP memory leaks, but this is a rare case.
*/
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <mcl/bn.hpp>
#include <stdio.h>

using namespace mcl::bn;
static struct Init {
    Init()
	{
		puts("Init cstr");
		mcl::Unit x[2] = { 1, 2 }, z[4];
		printf("ptr=%p\n", mcl::bint::get_mulUnit(2));
		mcl::bint::mulT<2>(z, x, x);
		// must be nonzero
		CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
		puts("initPairing");
		mcl::bn::initPairing();
		CYBOZU_TEST_ASSERT(Fr::getOp().N > 0);
		CYBOZU_TEST_ASSERT(Fp::getOp().N > 0);
	}
} init;

int main(int argc, char *argv[])
	try
{
	puts("main");
	CYBOZU_TEST_ASSERT(Fr::getOp().N > 0);
	CYBOZU_TEST_ASSERT(Fp::getOp().N > 0);
	// the static data members of EcT must keep the values set by initPairing() (order_ has a dynamic initializer)
	{
		G1 P;
		hashAndMapToG1(P, "abc", 3);
		CYBOZU_TEST_ASSERT(P.isValidOrder()); // instantiates G1::order_ in this TU
		const mpz_class *order = static_cast<const mpz_class*>(mcl::ec::getStaticMember(mcl::ec::StaticIdG1)->order);
		CYBOZU_TEST_ASSERT(*order != 0);
		order = static_cast<const mpz_class*>(mcl::ec::getStaticMember(mcl::ec::StaticIdG2)->order);
		CYBOZU_TEST_ASSERT(*order != 0);
	}
	mcl::Unit x[2] = { 1, 2 }, z[4];
	mcl::bint::mulT<2>(z, x, x);
	CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
	mcl::bn::Fr fr;
	fr.setByCSPRNG();
	printf("fr=%s\n", fr.getStr(16).c_str());
	return cybozu::test::autoRun.run(argc, argv);
} catch (std::exception& e) {
	printf("ERR %s\n", e.what());
	return 1;
}
