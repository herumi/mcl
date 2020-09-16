#include <mcl/bls12_381.hpp>

using namespace mcl::bn;

int main()
{
	initPairing(mcl::BLS12_381);
	Fp x, y, z;
	x = 3;
	y = 5;
	z = x + y;
	printf("x=%s\n", x.getStr(16).c_str());
	printf("y=%s\n", y.getStr(16).c_str());
	printf("z=%s\n", z.getStr(16).c_str());
}
