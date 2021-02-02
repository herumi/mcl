#include "../src/low_funct.hpp"

#define MCL_VINT_FIXED_BUFFER
#define MCL_SIZEOF_UNIT 4
#define MCL_MAX_BIT_SIZE 384
#include <mcl/vint.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>

void mul3(uint32_t z[6], const uint32_t x[3], uint32_t y[3])
{
	return mcl::mulT<3>(z, x, y);
}

template<class RG>
void setRand(uint32_t *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = rg.get32();
	}
}

CYBOZU_TEST_AUTO(mul3)
{
	cybozu::XorShift rg;
	uint32_t x[3];
	uint32_t y[3];
	uint32_t z[6];
	for (size_t i = 0; i < 1000; i++) {
		setRand(x, 3, rg);
		setRand(y, 3, rg);
		mcl::Vint vx, vy;
		vx.setArray(x, 3);
		vy.setArray(y, 3);
		printf("vx=%s\n", vx.getStr(16).c_str());
		printf("vy=%s\n", vy.getStr(16).c_str());
		vx *= vy;
		printf("xy=%s\n", vx.getStr(16).c_str());
		mul3(z, x, y);
		CYBOZU_TEST_EQUAL_ARRAY(z, vx.getUnit(), 6);
	}
}
