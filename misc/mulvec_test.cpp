#include <mcl/ec.hpp>
#include <math.h>

void put(int n, int x)
{
	printf(" x=%d(%zd)", x, mcl::ec::costMulVec(n, x));
}

int getmin(int n)
{
	int min = 100000000;
	int a = 0;
	for (int x = 1; x < 30; x++) {
		int v = mcl::ec::costMulVec(n, x);
		if (v < min) {
			a = x;
			min = v;
		}
	}
	return a;
}

void disp(int n)
{
	int x0 = getmin(n);
	int x1 = mcl::ec::argminForMulVec(n);
	printf("n=%d", n);
	put(n, x0);
	put(n, x1);
	printf(" diff=%d\n", x1-x0);
}

int main()
{
	for (int i = 1; i < 16; i++) {
		disp(i);
	}
	for (int i = 4; i < 30; i++) {
		int n = 1 << i;
		disp(n*0.9);
		disp(n);
		disp(n*1.1);
	}
	puts("all search");
	for (int i = 1; i < 100000000; i++) {
		int x0 = getmin(i);
		int x1 = mcl::ec::argminForMulVec(i);
//		if (std::abs(x0-x1) > 1) printf("i=%d x0=%d x1=%d\n", i, x0, x1);
		if (x0 != x1) printf("i=%d x0=%d x1=%d\n", i, x0, x1);
	}
}
