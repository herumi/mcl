#include <mcl/ec.hpp>
#include <math.h>

int f(int n, int x)
{
//	return int((n + pow(2, x+1) - 1)/x);
	return int((n + (1ull<<(x+1))-2)/x);
}

void put(int n, int x)
{
	printf(" x=%d(%d)", x, f(n, x));
}

int getmin(int n)
{
	int min = 100000000;
	int a = 0;
	for (int x = 1; x < 30; x++) {
		int v = f(n, x);
		if (v < min) {
			a = x;
			min = v;
		}
	}
	return a;
}

int getmin2(int n)
{
	int x = mcl::ec::argminForMulVec(n);
	int v = f(n, x);
	if (x > 0 && f(n, x-1) <= v) return x-1;
	if (f(n,x+1) < v) return x+1;
	return x;
}

void disp(int n)
{
	int x0 = getmin(n);
	int x1 = mcl::ec::argminForMulVec(n);
	int x2 = getmin2(n);
	printf("n=%d", n);
	put(n, x0);
	put(n, x1);
	put(n, x2);
	printf(" diff=%d x0==x2=%d\n", x1-x0, x0==x2);
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
}
