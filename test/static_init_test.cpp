#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <mcl/bn256.hpp>
#include <stdio.h>

static struct Init {
    Init()
	{
		puts("init");
		// must be nonzero
		CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
		mcl::bn::initPairing();
	}
} init;

int main()
{
	puts("main");
	CYBOZU_TEST_ASSERT(mcl::bint::get_mulUnit(1));
//	mcl::bn::initPairing();
	mcl::bn::Fr fr;
	fr.setByCSPRNG();
}
