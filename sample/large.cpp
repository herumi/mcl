/*
	large prime sample for 64-bit arch
	make CFLAGS_USER="-DMCL_MAX_OP_BIT_SIZE=768"
*/
#include <mcl/fp.hpp>

typedef mcl::FpT<> Fp;

int main()
	try
{
	std::string pStr = "776259046150354467574489744231251277628443008558348305569526019013025476343188443165439204414323238975243865348565536603085790022057407195722143637520590569602227488010424952775132642815799222412631499596858234375446423426908029627";
	Fp::init(pStr);
	mpz_class p(pStr);
	Fp a = 123456;
	Fp::pow(a, a, p);
	std::cout << a << std::endl;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	puts("make clean");
	puts("make CFLAGS_USER=\"-DMCL_MAX_OP_BIT_SIZE=768\"");
	return 1;
}
