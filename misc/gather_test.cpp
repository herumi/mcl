#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <vector>
#include <string.h>
#include "../src/avx512.hpp"
#include <map>

typedef std::map<size_t, double> Mem2Clk;

void gatherBench(Mem2Clk& bench, uint64_t *base, size_t bit, size_t c, cybozu::XorShift& rg, int mode)
{
	cybozu::CpuClock clk;
	clk.begin();
	Vec v = vzero();
	const size_t n = size_t(1) << bit;
	const size_t mask = n - 1;

	uint64_t tbl[8];
	for (size_t i = 0; i < c; i++) {
		for (size_t i = 0; i < 8; i++) {
			tbl[i] = rg.get32() & mask;
		}
		Vec idx;
		memcpy(&idx, tbl, sizeof(idx));
		v = vpaddq(v, vpgatherqq(idx, base));
		if (mode == 1) {
			vpscatterqq(base, idx, v);
		}
	}
	clk.end();
	uint64_t s = 0;
	memcpy(tbl, &v, sizeof(v));
	for (size_t i = 0; i < 8; i++) s += tbl[i];

	double ave = clk.getClock() / double(c);
	char m[64];
	if (n * 8 < 1024 * 1024) {
		snprintf(m, sizeof(m), "%zd KiB", n * 8 / 1024);
	} else {
		size_t mem = n * 8 / 1024 / 1024;
		snprintf(m, sizeof(m), "%zd MiB", mem);
		bench[mem] = ave;
	}
	printf("%2zd %10s %8.2f clk %llx\n", bit, m, ave, (long long)s);
}

void printTable(const Mem2Clk& bench, bool csv)
{
	if (csv) {
		printf("MiB");
		for (auto i = bench.begin(); i != bench.end(); ++i) {
			printf(",%zd", i->first);
		}
		printf("\n");
		printf("cycle");
		for (auto i = bench.begin(); i != bench.end(); ++i) {
			printf(",%.2f", i->second);
		}
		printf("\n");
	} else {
		// markdown
		printf("MiB");
		for (auto i = bench.begin(); i != bench.end(); ++i) {
			printf("|%zd", i->first);
		}
		printf("\n");
		printf("-");
		for (auto i = bench.begin(); i != bench.end(); ++i) {
			printf("|-");
		}
		printf("\n");
		printf("cycle");
		for (auto i = bench.begin(); i != bench.end(); ++i) {
			printf("|%.2f", i->second);
		}
		printf("\n");
	}
}

int main()
{
	const size_t maxB = 29;
	const size_t n = size_t(1) << maxB;
	std::vector<uint64_t> v(n);
	cybozu::XorShift rg;
	for (size_t i = 0; i < n; i++) {
		v[i] = rg.get32();
	}
	for (int mode = 0; mode < 2; mode++) {
		printf("%s\n", mode == 0 ? "RO" : "RW");
		Mem2Clk bench;
		for (size_t b = 8; b <= maxB; b++) {
			gatherBench(bench, v.data(), b, 100000, rg, mode);
		}
		printTable(bench, true);
		printTable(bench, false);
	}
}
