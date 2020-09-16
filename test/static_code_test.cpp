#include <mcl/bls12_381.hpp>

using namespace mcl::bn;

void testFr()
{
	Fr x, y, z;
	x = 3;
	y = 5;
	z = x + y;
	printf("x=%s\n", x.getStr().c_str());
	printf("y=%s\n", y.getStr().c_str());
	printf("z=%s\n", z.getStr().c_str());
	z = x * y;
	printf("z=%s\n", z.getStr().c_str());
	Fr::sqr(z, x);
	printf("z=%s\n", z.getStr().c_str());
}

void testFp()
{
	Fp x, y, z;
	x = 3;
	y = 5;
	z = x + y;
	printf("x=%s\n", x.getStr().c_str());
	printf("y=%s\n", y.getStr().c_str());
	printf("z=%s\n", z.getStr().c_str());
	z = x * y;
	printf("z=%s\n", z.getStr().c_str());
	Fp::sqr(z, x);
	printf("z=%s\n", z.getStr().c_str());
}

int main()
{
	initPairing(mcl::BLS12_381);
	testFr();
	testFp();
}
