#include <mcl/bn384.hpp>
#include <iostream>

using namespace mcl::bn;

int main()
{
	initPairing(mcl::BN254);
	G2 Q;
	mapToG2(Q, 1);
	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Q);
	printf("static const char *tbl[%d] = {\n", (int)Qcoeff.size());
	for (size_t i = 0; i < Qcoeff.size(); i++) {
		printf("\"%s\",\n", Qcoeff[i].getStr(16).c_str());
	}
	puts("};");
}
