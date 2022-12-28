#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <mcl/bn256.hpp>
#include <stdio.h>

static struct Init {
    Init()
	{
		puts("init");
		mcl::Unit x[2] = { 1, 2 }, z[4];
		mcl::bint::mulT<2>(z, x, x);
		// must be nonzero
		CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
		mcl::bn::initPairing();
	}
} init;

int main()
{
	mcl::Unit x[2] = { 1, 2 }, z[4];
	mcl::bint::mulT<2>(z, x, x);
	puts("main");
	CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
	mcl::bn::Fr fr;
	fr.setByCSPRNG();
}
