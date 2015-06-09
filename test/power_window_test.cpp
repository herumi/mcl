#include <cybozu/test.hpp>
#include <mcl/power_window.hpp>
#include <mcl/fp.hpp>


CYBOZU_TEST_AUTO(int)
{
	typedef mcl::FpT<> Fp;
	Fp::setModulo("65537");

	typedef mcl::PowerWindow<Fp> PW;
	const Fp g = 123;
	const size_t bitLen = 16;
	for (size_t winSize = 1; winSize <= 16; winSize++) {
		PW pw(g, bitLen, winSize);
		for (int i = 0; i < (1 << bitLen); i++) {
			Fp x, y;
			pw.power(x, i);
			Fp::power(y, g, i);
			CYBOZU_TEST_EQUAL(x, y);
		}
	}
}
