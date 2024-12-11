#include <mcl/ec.hpp>
#include <math.h>

void put(size_t n, size_t x)
{
	printf(" x=%zd(%zd)", x, mcl::ec::glvCost(n, x));
}

size_t getmin(size_t n)
{
	size_t min = 100000000;
	size_t a = 0;
	for (size_t x = 1; x < 30; x++) {
		size_t v = mcl::ec::glvCost(n, x);
		if (v < min) {
			a = x;
			min = v;
		}
	}
	return a;
}

void disp(size_t n)
{
	size_t x0 = getmin(n);
	size_t x1 = mcl::ec::glvGetBucketSize(n);
	printf("n=%zd", n);
	put(n, x0);
	put(n, x1);
	printf(" diff=%zd\n", x1-x0);
}

inline size_t ilog2(size_t n)
{
	if (n == 0) return 0;
	return cybozu::bsr(n) + 1;
}

inline size_t glvCost(size_t n, size_t x)
{
	return (n + (size_t(1)<<(x+1))-1)/x;
}
// calculate approximate value such that argmin { x : (n + 2^(x+1)-1)/x }
inline size_t estimateBucketSize(size_t n)
{
	if (n <= 16) return 2;
	size_t log2n = ilog2(n);
	return log2n - ilog2(log2n);
}

/*
	First, get approximate value x and compute glvCost of x-1 and x+1,
	and return the minimum value.
*/
inline size_t glvGetBucketSize(size_t n)
{
	size_t x = estimateBucketSize(n);
#if 1
	size_t vm1 = x > 1 ? glvCost(n, x-1) : n;
	size_t v0 = glvCost(n, x);
	size_t vp1 = glvCost(n, x+1);
	if (vm1 <= v0) return x-1;
	if (vp1 < v0) return x+1;
#endif
	return x;
}

int main()
{
	for (size_t i = 1; i < 16; i++) {
		disp(i);
	}
	for (size_t i = 4; i < 30; i++) {
		size_t n = size_t(1) << i;
		disp(n*0.9);
		disp(n);
		disp(n*1.1);
	}
	for (size_t i = 5; i <= 27; i++) {
		size_t n = size_t(1) << i;
		size_t glvN = n/8*2;
		printf("n=2^%zd=%zd v=%zd\n", i, n, getmin(glvN));
	}
	puts("all search");
	for (size_t i = 1; i < 200000000; i++) {
		size_t x0 = getmin(i);
		size_t x1 = glvGetBucketSize(i);
//		if (std::abs(x0-x1) > 1) printf("i=%zd x0=%zd x1=%zd\n", i, x0, x1);
		if (x0 != x1) printf("i=%zd x0=%zd x1=%zd\n", i, x0, x1);
	}
	for (size_t i = 1; i <= 100000000; i *= 10) {
		size_t x = glvGetBucketSize(i);
		printf("i=%zd x=%zd\n", i, x);
	}
}
