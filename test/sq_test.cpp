#include <mcl/gmp_util.hpp>
#include <cybozu/test.hpp>
#include <iostream>

CYBOZU_TEST_AUTO(sqrt)
{
	const int tbl[] = { 3, 5, 7, 11, 13, 17, 19, 257, 997, 1031 };
	mcl::SquareRoot sq;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const mpz_class p = tbl[i];
		sq.set(p);
		for (mpz_class a = 0; a < p; a++) {
			mpz_class x;
			bool b1 = sq.get(x, a);
			mpz_class x2;
			bool b2 = sq.get2(x2, a);
			CYBOZU_TEST_EQUAL(b1, b2);
			if (b1) {
				mpz_class y;
				y = (x * x) % p;
				CYBOZU_TEST_EQUAL(a, y);
				CYBOZU_TEST_EQUAL(x, x2);
			}
		}
	}
}
