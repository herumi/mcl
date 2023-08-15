#include <mcl/invmod.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

template<int N>
void test(const char *Mstr)
{
	printf("M=%s\n", Mstr);
	mpz_class mM;
	mcl::gmp::setStr(mM, Mstr, 16);
	InvModT<mcl::Unit, N, long> invMod;
	invMod.init(mM);
	mpz_class x, y;
	x = 1;
	for (int i = 0; i < 10000; i++) {
		invMod.inv(y, x);
		if ((x * y) % mM != 1) {
			std::cout << "err" << std::endl;
			std::cout << "x=" << x << std::endl;
			std::cout << "y=" << y << std::endl;
			return;
		}
		x = y + 1;
	}
	puts("ok");
	CYBOZU_BENCH_C("modinv", 1000, x++;invMod.inv, x, x);
}

int main()
{
	const char *tbl[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
	};
	test<6>(tbl[0]);
	test<4>(tbl[1]);
}
