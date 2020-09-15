#include <mcl/bls12_381.hpp>

using namespace mcl::bn;

int main()
{
	initPairing(mcl::BLS12_381);
	Fr x;
	x = 3;
	printf("%s\n", x.getStr(16).c_str());
}
