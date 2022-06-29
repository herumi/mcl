#include <cybozu/benchmark.hpp>
//cybozu::CpuClock g_clk;
#include <stdio.h>
#include <mcl/bint.hpp>
#include <mcl/conversion.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <gmpxx.h>
#include <iostream>

#ifdef MCL_BINT_FUNC_PTR
#define XBYAK_ONLY_CLASS_CPU
#include "../src/xbyak/xbyak_util.h"
CYBOZU_TEST_AUTO(cpu)
{
	using namespace Xbyak::util;
	Cpu cpu;
	if (!cpu.has(Cpu::tBMI2 | Cpu::tADX)) {
		fprintf(stderr, "bmi2 and adx are not available\n");
		mcl::bint::mclb_disable_fast();
	}
}

#endif

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

using namespace mcl::bint;
typedef mcl::Unit Unit;
static const size_t UnitBitSize = mcl::UnitBitSize;

template<class RG>
void setRand(Unit *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = (Unit)rg.get64();
	}
}

mpz_class to_mpz(Unit x)
{
	return mp_limb_t(x);
}

void setArray(mpz_class& z, const Unit *buf, size_t n)
{
	mpz_import(z.get_mpz_t(), n, -1, sizeof(*buf), 0, 0, buf);
}
void divmod(mpz_class& q, mpz_class& r, const mpz_class& x, const mpz_class& y)
{
	mpz_divmod(q.get_mpz_t(), r.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
}

CYBOZU_TEST_AUTO(cmpT)
{
	const Unit x[] = { 1, 2, 4, 5 };
	const Unit y[] = { 1, 2, 3, 8 };

	CYBOZU_TEST_ASSERT(!cmpEqT<3>(x, y));
	CYBOZU_TEST_ASSERT(cmpEqT<3>(x, x));
	CYBOZU_TEST_ASSERT(cmpEqT<2>(x, y));

	CYBOZU_TEST_ASSERT(cmpGeT<3>(x, y));
	CYBOZU_TEST_ASSERT(cmpGeT<3>(x, x));
	CYBOZU_TEST_ASSERT(!cmpGeT<3>(y, x));
	CYBOZU_TEST_ASSERT(cmpGeT<2>(x, y));
	CYBOZU_TEST_ASSERT(!cmpGeT<4>(x, y));

	CYBOZU_TEST_ASSERT(cmpGtT<3>(x, y));
	CYBOZU_TEST_ASSERT(!cmpGtT<3>(x, x));
	CYBOZU_TEST_ASSERT(!cmpGtT<3>(y, x));

	CYBOZU_TEST_ASSERT(!cmpLeT<3>(x, y));
	CYBOZU_TEST_ASSERT(cmpLeT<3>(x, x));
	CYBOZU_TEST_ASSERT(cmpLeT<3>(y, x));
	CYBOZU_TEST_ASSERT(cmpLeT<2>(x, x));
	CYBOZU_TEST_ASSERT(cmpLeT<4>(x, y));
}

CYBOZU_TEST_AUTO(addT)
{
	const Unit x[] = { 9, 2, 3 };
	const Unit y[] = { Unit(-1), 5, 4 };
	const Unit ok[] = { 8, 8, 7 };
	Unit z[3], CF;
	z[0] = 9;
	z[1] = 10;
	CF = addT<1>(z, x, y);
	CYBOZU_TEST_EQUAL(z[0], ok[0]);
	CYBOZU_TEST_EQUAL(CF, 1u);
	CYBOZU_TEST_EQUAL(z[1], 10u); // not changed

	CF = addT<1>(z, x + 1, y + 1);
	CYBOZU_TEST_EQUAL(z[0], x[1] + y[1]);
	CYBOZU_TEST_EQUAL(CF, 0u);
	CYBOZU_TEST_EQUAL(z[1], 10u); // not changed

	CF = addT<3>(z, x, y);
	CYBOZU_TEST_EQUAL_ARRAY(z, ok, 3);
	CYBOZU_TEST_EQUAL(CF, 0u);
}

CYBOZU_TEST_AUTO(subT)
{
	const size_t N = 4;
	Unit x[N], y[N], z[N], x2[N];
	cybozu::XorShift rg;
	mpz_class mx, my, mz;
	for (int i = 0; i < 100; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		Unit CF = addT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(my, y, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx + my, mz + (to_mpz(CF) << (sizeof(x) * 8)));
		Unit CF2 = subT<N>(x2, z, y);
		CYBOZU_TEST_EQUAL_ARRAY(x, x2, N);
		CYBOZU_TEST_EQUAL(CF, CF2);

	}
}

CYBOZU_TEST_AUTO(mulUnitT)
{
	const size_t N = 4;
	Unit x[N], y, z[N];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		Unit u = mulUnitT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx * to_mpz(y), mz + (to_mpz(u) << (sizeof(x) * 8)));
	}
#ifdef NDEBUG
	const int C = 1000;
	CYBOZU_BENCH_C("mulUnit", C, mulUnitT<N>, z, x, y);
#endif
}

CYBOZU_TEST_AUTO(mulUnitAddT)
{
	const size_t N = 4;
	Unit x[N], z[N];
	cybozu::XorShift rg;
	mpz_class mx, mz, mt;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(z, N, rg);
		setArray(mx, x, N);
		setArray(mz, z, N);
		setRand(&y, 1, rg);
		Unit u = mulUnitAddT<N>(z, x, y);
		setArray(mt, z, N);
		CYBOZU_TEST_EQUAL(mz + mx * to_mpz(y), mt + (to_mpz(u) << (sizeof(x) * 8)));
	}
}

CYBOZU_TEST_AUTO(mulT)
{
	const size_t N = 4;
	Unit x[N], y[N], z[N * 2];
	cybozu::XorShift rg;
	mpz_class mx, my, mz;
	for (int i = 0; i < 100; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		mulT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(my, y, N);
		setArray(mz, z, N * 2);
		CYBOZU_TEST_EQUAL(mx * my, mz);
	}
}

CYBOZU_TEST_AUTO(shlT)
{
	const size_t N = 4;
	Unit x[N], z[N];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		y &= sizeof(Unit) * 8 - 1;
		if (y == 0) y = 1;
		Unit u = shlT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx << y, mz + (to_mpz(u) << (sizeof(x) * 8)));
	}
}

CYBOZU_TEST_AUTO(shrT)
{
	const size_t N = 4;
	Unit x[N], z[N];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		y &= sizeof(Unit) * 8 - 1;
		if (y == 0) y = 1;
		shrT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx >> y, mz);
	}
}

CYBOZU_TEST_AUTO(shiftLeft)
{
	const size_t N = 4;
	Unit x[N], z[N*2];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		y %= UnitBitSize * 3;
		size_t yn = shiftLeft(z, x, y, N);
		setArray(mx, x, N);
		setArray(mz, z, yn);
		CYBOZU_TEST_EQUAL(mx << y, mz);
	}
}

CYBOZU_TEST_AUTO(shiftRight)
{
	const size_t N = 4;
	Unit x[N*2], z[N*2];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N*2, rg);
		setArray(mx, x, N*2);
		setRand(&y, 1, rg);
		y %= UnitBitSize * 3;
		size_t yn = shiftRight(z, x, y, N*2);
		setArray(mz, z, yn);
		CYBOZU_TEST_EQUAL(mx >> y, mz);
	}
}

CYBOZU_TEST_AUTO(addUnit)
{
	const size_t N = 2;
	const struct {
		Unit x[N];
		Unit y;
	} tbl[] = {
		{ { 1, 2 }, 3 },
		{ { 1, Unit(-1) }, 5 },
		{ { Unit(-1), Unit(-2) }, 7 },
	};
	mpz_class mx, mz;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Unit *x = tbl[i].x;
		Unit y = tbl[i].y;
		Unit z[N];
		copyN(z, x, N);
		Unit u = addUnit(z, N, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx + to_mpz(y), mz + (to_mpz(u) << (sizeof(Unit) * N * 8)));
		Unit x2[N];
		copyN(x2, z, N);
		Unit u2 = subUnit(x2, N, y);
		CYBOZU_TEST_EQUAL_ARRAY(x2, x, N);
		CYBOZU_TEST_EQUAL(u, u2);
	}
}

CYBOZU_TEST_AUTO(divUnit)
{
	const size_t N = 4;
	Unit x[N], q[N];
	cybozu::XorShift rg;
	mpz_class mx, mq;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		if (y == 0) y = 1;
		Unit r = divUnit(q, x, N, y);
		setArray(mx, x, N);
		setArray(mq, q, N);
		CYBOZU_TEST_EQUAL(mx, mq * to_mpz(y) + to_mpz(r));
		Unit r2 = modUnit(x, N, y);
		CYBOZU_TEST_EQUAL(r, r2);
	}
}

template<class RG, class F>
void setRandAndTest(size_t xN, RG& rg, const F& f, Unit *q, size_t qn, const Unit *y, size_t yn)
{
	Unit *x = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * xN);
	setRand(x, xN, rg);
	f(q, qn, x, xN, y, yn);
}


CYBOZU_TEST_AUTO(divFullBit)
{
	const size_t xN = 8;
	const size_t yN = 4;
	const size_t qN = xN - yN + 1;
	Unit x[xN], y[yN], q[qN];
	cybozu::XorShift rg;
	mpz_class mx, my, mq, mr;
	for (int i = 0; i < 100; i++) {
		setRand(x, xN, rg);
		setRand(y, yN, rg);
		y[yN - 1] |= Unit(1) << (sizeof(Unit) * 8 - 1); // full bit
		setArray(mx, x, xN);
		setArray(my, y, yN);
		size_t rn = divFullBit(q, qN, x, xN, y, yN);
		setArray(mq, q, qN);
		setArray(mr, x, rn);
		CYBOZU_TEST_EQUAL(mq, mx / my);
		CYBOZU_TEST_EQUAL(mr, mx % my);
	}
#ifdef NDEBUG
//g_clk.clear();
	const int C = 1000;
	CYBOZU_BENCH_C("gmp ", C, divmod, mq, mr, mx, my);
	CYBOZU_BENCH_C("full", C, setRandAndTest, xN, rg, divFullBit, q, qN, y, yN);
//printf("count=%d\n", g_clk.getCount());
//g_clk.put();
#endif
}

CYBOZU_TEST_AUTO(divSmall)
{
	const size_t N = 4;
	Unit x[N], y[N], q;
	cybozu::XorShift rg;
	mpz_class mx, my, mr;
	for (int i = 0; i < 100; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		y[N - 1] |= Unit(1) << (sizeof(Unit) * 8 / 2); // at least half
		setArray(mx, x, N);
		setArray(my, y, N);
		q = 0;
		bool done = divSmall(&q, 1, x, N, y, N);
		CYBOZU_TEST_ASSERT(done);
		setArray(mr, x, N);
		CYBOZU_TEST_EQUAL(to_mpz(q) * my + mr, mx);
	}
#ifdef NDEBUG
	mpz_class mq;
	const int C = 1000;
	CYBOZU_BENCH_C("gmp  ", C, divmod, mq, mr, mx, my);
	CYBOZU_BENCH_C("small", C, setRandAndTest, N, rg, divSmall, &q, 1, y, N);
#endif
}


CYBOZU_TEST_AUTO(div)
{
	const size_t xN = 8;
	const size_t yN = 4;
	const size_t qN = xN - yN + 1;
	Unit x[xN], y[yN], q[qN];
	cybozu::XorShift rg;
	mpz_class mx, my, mq, mr;
	for (int i = 0; i < 100; i++) {
		setRand(x, xN, rg);
		setRand(y, yN, rg);
		setArray(mx, x, xN);
		setArray(my, y, yN);
		size_t xn = div(q, qN, x, xN, y, yN);
		setArray(mq, q, qN);
		setArray(mr, x, xn);
		CYBOZU_TEST_EQUAL(mq * my + mr, mx);
	}
#ifdef NDEBUG
	const int C = 1000;
	CYBOZU_BENCH_C("gmp", C, divmod, mq, mr, mx, my);
	CYBOZU_BENCH_C("div", C, setRandAndTest, xN, rg, mcl::bint::div, q, qN, y, yN);
#endif
}

CYBOZU_TEST_AUTO(divMod)
{
	const struct {
		const char *x;
		const char *y;
		const char *r;
	} tbl[] = {
		{
			"1ba632a3ff569785cca9f0822f4b25ccaa5f9ef29f9e65f35230e5410232f6de65e6feab40280f3683d9172f43e5d925d3bfa87144d07bd2fc0811e05aef03f6",
			"b64000000000ecbf9e00000073543404300018f825373836c206f994412505bf",
			"a01a4b23364138fb6cf6b0bc1c04db875386bb572e4b762eb303ebb5479ff8c2",
		},
		{
			"1da8c492d8dc0164384dcde24574c8fdda3bd617ff3e1d00ed7f8576351143b6e6e10a6b16c1d78f44b8d87f6b862ef470fa270d3287754b8302edc9265034c",
			"b64000000000ecbf9e00000073543404300018f825373836c206f994412505bf",
			"5c89114e7ae32958cbfe9652a5419a870bd8cb2ac262d0578a4ad30cc392506a",
		},
		{
			"ffffffffffffffaa57a034c6472dabe94494c8aa55682873eb7e5dae5f47204abd160817aa4cfaef470fa270d3287754b8302edc9265034c",
			"b64000000000ecbf9e00000073543404300018f825373836c206f994412505bf",
			"b3eadcf63f3f9d1cc0c1263a467371fc05b898d850acdc91d8c015c6fd6c1a16",
		},
		{
			"2e0d4c0000003bd2ab3ca0001d2456e4cee1064f33e7640456272330a6360a8f8e6",
			"b64000000000ecbf9e00000073543404300018f825373836c206f994412505bf",
			"b64000000000ecbf9e00000073543404300018f825373836c206f994411fc370",
		},
		{
			"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
			"100000000000000000000000000000000000000000000000001",
			"fffffffffffffffffffffffffffffffffffffffff000000000",
		},
		{
			"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
			"1000000000000000000000000000000000000000000000000000000000000000000000000000000001",
			"fffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000",
		},
		{
			"fffffffffffff000000000000000000000000000000000000000000000000000000000000000000",
			"100000000000000000000000000000000000000000000000000000000000000000001",
			"fefffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000001",
		},
		{
			"fffffffffffff000000000000000000000000000000000000000000000000000000000000000000",
			"fffffffffffff0000000000000000000000000000000000000000000000000000000000000001",
			"ffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff01",
		},
		{
			"1230000000000000456",
			"1230000000000000457",
			"1230000000000000456",
		},
		{
			"1230000000000000456",
			"1230000000000000456",
			"0",
		},
		{
			"1230000000000000456",
			"1230000000000000455",
			"1",
		},
		{
			"1230000000000000456",
			"2000000000000000000",
			"1230000000000000456",
		},
		{
			"ffffffffffffffffffffffffffffffff",
			"80000000000000000000000000000000",
			"7fffffffffffffffffffffffffffffff",
		},
		{
			"ffffffffffffffffffffffffffffffff",
			"7fffffffffffffffffffffffffffffff",
			"1",
		},
		{
			"ffffffffffffffffffffffffffffffff",
			"70000000000000000000000000000000",
			"1fffffffffffffffffffffffffffffff",
		},
		{
			"ffffffffffffffffffffffffffffffff",
			"30000000000000000000000000000000",
			"fffffffffffffffffffffffffffffff",
		},
		{
			"ffffffffffffffffffffffffffffffff",
			"10000000000000000000000000000000",
			"fffffffffffffffffffffffffffffff",
		},
		{
			"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
			"2523648240000001ba344d80000000086121000000000013a700000000000013",
			"212ba4f27ffffff5a2c62effffffffcdb939ffffffffff8a15ffffffffffff8d",
		},
		{
			"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
			"2523648240000001ba344d8000000007ff9f800000000010a10000000000000d",
			"212ba4f27ffffff5a2c62effffffffd00242ffffffffff9c39ffffffffffffb1",
		},
	};
	const size_t N = 8;
	Unit xBuf[N];
	Unit yBuf[N];
	Unit qBuf[N];
	Unit rBuf[N];
	mpz_class mx, my, mq, mr, mr2;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		size_t xn = mcl::fp::hexToArray(xBuf, N, tbl[i].x, strlen(tbl[i].x));
		size_t yn = mcl::fp::hexToArray(yBuf, N, tbl[i].y, strlen(tbl[i].y));
		size_t rn = mcl::fp::hexToArray(rBuf, N, tbl[i].r, strlen(tbl[i].r));
		CYBOZU_TEST_ASSERT(xn > 0 && yn > 0 && rn > 0);
		setArray(mx, xBuf, xn);
		setArray(my, yBuf, yn);
		setArray(mr, rBuf, rn);
		size_t rn2 = div(qBuf, N, xBuf, xn, yBuf, yn);
		setArray(mq, qBuf, N);
		setArray(mr2, xBuf, rn2);
		CYBOZU_TEST_EQUAL(mr, mr2);
		CYBOZU_TEST_EQUAL(mx, mq * my + mr2);
	}
}

CYBOZU_TEST_AUTO(maskN)
{
	const size_t n64 = 2;
	uint64_t org64[n64] = { uint64_t(0xabce1234ffffef32ull), uint64_t(0x12345678ffffffffull) };
	uint32_t org32[n64 * 2];
	for (size_t i = 0; i < n64; i++) {
		org32[i * 2 + 0] = uint32_t(org64[i]);
		org32[i * 2 + 1] = uint32_t(org64[i] >> 32);
	}
#if MCL_SIZEOF_UNIT == 8
	const uint64_t *org = org64;
	const size_t n = n64;
	(void)org32;
#else
	const uint64_t *org = org32;
	const size_t n = n64 * 2;
#endif
	mpz_class morg, mx;
	setArray(morg, org, n);
	for (size_t i = 0; i <= MCL_SIZEOF_UNIT * 8 * n; i++) {
		Unit x[n];
		memcpy(x, org, MCL_SIZEOF_UNIT * n);
		maskN(x, n, i);
		setArray(mx, x, n);
		CYBOZU_TEST_EQUAL(morg & ((mpz_class(1) << i) - 1), mx);
	}
}

