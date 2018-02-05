#include <mcl/gmp_util.hpp>
#include <vector>
#include <cybozu/test.hpp>

CYBOZU_TEST_AUTO(testBit)
{
	const size_t maxBit = 100;
	const size_t tbl[] = {
		3, 9, 5, 10, 50, maxBit
	};
	mpz_class a;
	std::vector<bool> b(maxBit + 1);
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		a |= mpz_class(1) << tbl[i];
		b[tbl[i]] = 1;
	}
	for (size_t i = 0; i <= maxBit; i++) {
		bool c1 = mcl::gmp::testBit(a, i);
		bool c2 = b[i] != 0;
		CYBOZU_TEST_EQUAL(c1, c2);
	}
}

CYBOZU_TEST_AUTO(getRandPrime)
{
	for (int i = 0; i < 10; i++) {
		mpz_class z;
		mcl::gmp::getRandPrime(z, i * 10 + 3);
		CYBOZU_TEST_ASSERT(mcl::gmp::isPrime(z));
	}
}
