#include <cybozu/benchmark.hpp>
//cybozu::CpuClock g_clk;
#include <stdio.h>
#include <mcl/bint.hpp>
#include <mcl/conversion.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <gmpxx.h> // for test bint
#include <iostream>
#include <cybozu/link_mpir.hpp>

#ifdef NDEBUG
const int C = 1000;
#else
const int C = 100;
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

template<class RG>
void setRandNF(Unit *x, size_t n, RG& rg)
{
	setRand(x, n, rg);
#if MCL_SIZEOF_UNIT == 4
	x[n - 1] &= 0x7fffffff;
#else
	x[n - 1] &= 0x7fffffffffffffffull;
#endif
}

mpz_class to_mpz(Unit x)
{
#if MCL_SIZEOF_UNIT == 4
	return x;
#else
	uint32_t L = uint32_t(x);
	uint32_t H = uint32_t(x >> 32);
	return (mpz_class(H) << 32) | L;
#endif
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
	const size_t N = 6;
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
#ifdef NDEBUG
	const int CC = 20000;
	CYBOZU_BENCH_C("gmp(4)", CC, mpn_mul_n, (mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, (int)4);
	CYBOZU_BENCH_C("mul4", CC, mulT<4>, z, x, y);
	CYBOZU_BENCH_C("mulN(4)", CC, mulN, z, x, y, 4);
	CYBOZU_BENCH_C("gmp(6)", CC, mpn_mul_n, (mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, (int)N);
	CYBOZU_BENCH_C("mul6", CC, mulT<N>, z, x, y);
	CYBOZU_BENCH_C("mulN(6)", CC, mulN, z, x, y, N);
#endif
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

template<size_t N>
void testAdd()
{
	cybozu::XorShift rg;
	Unit x[N], y[N], z[N], CF;
	mpz_class mx, my, mz;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		setArray(mx, x, N);
		setArray(my, y, N);
		CF = addT<N>(z, x, y);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mz + (to_mpz(CF) << (N * UnitBitSize)), mx + my);
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("addT", 1000, addT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(add)
{
	testAdd<1>();
	testAdd<2>();
	testAdd<3>();
	testAdd<4>();
	testAdd<5>();
	testAdd<6>();
	testAdd<7>();
	testAdd<8>();
}

template<size_t N>
void testAddNF()
{
	cybozu::XorShift rg;
	Unit x[N], y[N], z[N];
	mpz_class mx, my, mz;
	for (size_t i = 0; i < C; i++) {
		setRandNF(x, N, rg);
		setRandNF(y, N, rg);
		setArray(mx, x, N);
		setArray(my, y, N);
		addNFT<N>(z, x, y);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mz, mx + my);
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("addNFT", 1000, addNFT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(addNF)
{
	testAddNF<1>();
	testAddNF<2>();
	testAddNF<3>();
	testAddNF<4>();
	testAddNF<5>();
	testAddNF<6>();
	testAddNF<7>();
	testAddNF<8>();
}

template<size_t N>
void testSub()
{
	cybozu::XorShift rg;
	Unit x[N], y[N], z[N], CF;
	mpz_class mx, my, mz;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		setArray(mx, x, N);
		setArray(my, y, N);
		CF = subT<N>(z, x, y);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(CF != 0, mx < my);
		if (mx >= my) {
			CYBOZU_TEST_EQUAL(mz, mx - my);
		} else {
			CYBOZU_TEST_EQUAL(mz, mx - my + (to_mpz(CF) << (N * UnitBitSize)));
		}
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("subT", 1000, subT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(sub)
{
	testSub<1>();
	testSub<2>();
	testSub<3>();
	testSub<4>();
	testSub<5>();
	testSub<6>();
	testSub<7>();
	testSub<8>();
}

template<size_t N>
void testSubNF()
{
	cybozu::XorShift rg;
	Unit x[N], y[N], z[N], CF;
	mpz_class mx, my, mz;
	for (size_t i = 0; i < C; i++) {
		setRandNF(x, N, rg);
		setRandNF(y, N, rg);
		setArray(mx, x, N);
		setArray(my, y, N);
		CF = subNFT<N>(z, x, y);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(CF != 0, mx < my);
		if (mx >= my) {
			CYBOZU_TEST_EQUAL(mz, mx - my);
		} else {
			CYBOZU_TEST_EQUAL(mz, mx - my + (to_mpz(CF) << (N * UnitBitSize)));
		}
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("subNFT", 1000, subNFT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(subNF)
{
	testSubNF<1>();
	testSubNF<2>();
	testSubNF<3>();
	testSubNF<4>();
	testSubNF<5>();
	testSubNF<6>();
	testSubNF<7>();
	testSubNF<8>();
}

template<size_t N>
void testMulUnit()
{
	cybozu::XorShift rg;
	Unit x[N], y, z[N], ret;
	mpz_class mx, mz;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		setArray(mx, x, N);
		ret = mulUnitT<N>(z, x, y);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mz + (to_mpz(ret) << (N * UnitBitSize)), mx * to_mpz(y));
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("mulUnitT", 1000, mulUnitT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(mulUnit)
{
	testMulUnit<1>();
	testMulUnit<2>();
	testMulUnit<3>();
	testMulUnit<4>();
	testMulUnit<5>();
	testMulUnit<6>();
	testMulUnit<7>();
	testMulUnit<8>();
}

template<size_t N>
void testMulUnitAdd()
{
	cybozu::XorShift rg;
	Unit x[N], y, z[N], ret;
	mpz_class mx, mz, mz2;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		setRand(z, N, rg);
		setRand(&y, 1, rg);
		setArray(mx, x, N);
		setArray(mz, z, N);
		ret = mulUnitAddT<N>(z, x, y);
		setArray(mz2, z, N);
		CYBOZU_TEST_EQUAL(mz2 + (to_mpz(ret) << (N * UnitBitSize)), mz + mx * to_mpz(y));
	}
	printf("%2zd ", N);
	CYBOZU_BENCH_C("mulUnitAddT", 1000, mulUnitAddT<N>, z, x, y);
}

CYBOZU_TEST_AUTO(mulUnitAdd)
{
	testMulUnitAdd<1>();
	testMulUnitAdd<2>();
	testMulUnitAdd<3>();
	testMulUnitAdd<4>();
	testMulUnitAdd<5>();
	testMulUnitAdd<6>();
	testMulUnitAdd<7>();
	testMulUnitAdd<8>();
}

static Unit g_zero[32];

// z[N * 2] = x[N] * y[N] by Karatsuba
// (aM + b)(cM + d) = acM^2 + bd + (ad + bc)M
// ad + bc = (a + b)(c + d) - ac - bd
template<size_t N>
void mulKar(Unit *z, const Unit *x, const Unit *y)
{
	assert((N % 2) == 0);
	const size_t H = N / 2;
	Unit buf1[H]; // a + b
	Unit buf2[H]; // c + d
	Unit buf3[N]; // ad + bc
	Unit CF1 = addT<H>(buf1, x + H, x);
	Unit CF2 = addT<H>(buf2, y + H, y);
	Unit CF3 = CF1 & CF2;
	const Unit *p1 = CF1 ? buf2 : g_zero;
	const Unit *p2 = CF2 ? buf1 : g_zero;
	mulT<H>(buf3, buf1, buf2);
	CF3 += addT<H>(buf3 + H, buf3 + H, p1);
	CF3 += addT<H>(buf3 + H, buf3 + H, p2);
	mulT<H>(z + N, x + H, y + H);
	mulT<H>(z, x, y);
	CF3 -= subT<N>(buf3, buf3, z);
	CF3 -= subT<N>(buf3, buf3, z + N); // buf3[] = ad + bc
	CF3 += addT<N>(z + H, z + H, buf3);
	addUnit(z + H * 3, H, CF3);
}

template<size_t N, bool exec>
struct testMulKar {
	static inline void call(Unit *z, const Unit *x, const Unit *y, const mpz_class& mx, const mpz_class& my)
	{
		mulKar<N>(z, x, y);
		mpz_class mz = 0;
		setArray(mz, z, N * 2);
		CYBOZU_TEST_EQUAL(mx * my, mz);
	}
	static inline void bench(Unit *z, const Unit *x, const Unit *y, int CC)
	{
		printf("  ");
		CYBOZU_BENCH_C("mulKar", CC, mulKar<N>, z, x, y);
	}
};

template<size_t N>
struct testMulKar <N, false> {
	static inline void call(Unit *, const Unit *, const Unit *, const mpz_class&, const mpz_class&) {}
	static inline void bench(Unit *, const Unit *, const Unit *, int) {}
};

template<size_t N>
void testMul()
{
	cybozu::XorShift rg;
	Unit x[N], y[N], z[N * 2];
	mpz_class mx, my, mz;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		setRand(y, N, rg);
		mulT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(my, y, N);
		setArray(mz, z, N * 2);
		CYBOZU_TEST_EQUAL(mx * my, mz);
		testMulKar<N, ((N % 2) == 0 && N >= 4)>::call(z, x, y, mx, my);
	}
#ifdef NDEBUG
	const int CC = 20000;
	printf("%zd ", N);
	CYBOZU_BENCH_C("gmp", CC, mpn_mul_n, (mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, (int)N);
	printf("  ");
	CYBOZU_BENCH_C("mul", CC, mulT<N>, z, x, y);
	testMulKar<N, ((N % 2) == 0 && N >= 4)>::bench(z, x, y, CC);
#endif
}

CYBOZU_TEST_AUTO(mul)
{
	testMul<1>();
	testMul<2>();
	testMul<3>();
	testMul<4>();
	testMul<5>();
	testMul<6>();
	testMul<7>();
	testMul<8>();
	testMul<9>();
}

// z[N * 2] = x[N] * x[N] by Kar
template<size_t N>
void sqrKar(Unit *z, const Unit *x)
{
	const size_t H = N / 2;
	sqrT<H>(z, x); // b^2
	sqrT<H>(z + N, x + H); // a^2
	Unit ab[N];
	mulT<H>(ab, x, x + H); // ab
//	Unit c = shlT<N>(ab, ab, 1);
	Unit c = addT<N>(ab, ab, ab);
	c += addT<N>(z + H, z + H, ab);
	if (c) {
		addUnit(z + N + H, H, c);
	}
}

template<size_t N, bool exec>
struct testSqrKar {
	static inline void call(Unit *y, const Unit *x, const mpz_class& mx)
	{
		sqrKar<N>(y, x);
		mpz_class my = 0;
		setArray(my, y, N * 2);
		CYBOZU_TEST_EQUAL(mx * mx, my);
	}
	static inline void bench(Unit *y, const Unit *x, int CC)
	{
		printf("  ");
		CYBOZU_BENCH_C("sqrKar", CC, sqrKar<N>, y, x);
	}
};

template<size_t N>
struct testSqrKar <N, false> {
	static inline void call(Unit *, const Unit *, const mpz_class&)  {}
	static inline void bench(Unit *, const Unit *, int) {}
};

template<size_t N>
void testSqr()
{
	cybozu::XorShift rg;
	Unit x[N], y[N * 2];
	mpz_class mx, my;
	for (size_t i = 0; i < C; i++) {
		setRand(x, N, rg);
		sqrT<N>(y, x);
		setArray(mx, x, N);
		setArray(my, y, N * 2);
		CYBOZU_TEST_EQUAL(mx * mx, my);
		memset(y, 0, sizeof(y));
		testSqrKar<N, ((N % 2) == 0 && N >= 4)>::call(y, x, mx);
	}
#ifdef NDEBUG
	const int CC = 20000;
	printf("%zd ", N);
	CYBOZU_BENCH_C("gmp", CC, mpn_sqr, (mp_limb_t*)y, (const mp_limb_t*)x, (int)N);
	printf("  ");
	CYBOZU_BENCH_C("sqr", CC, sqrT<N>, y, x);
	testSqrKar<N, ((N % 2) == 0 && N >= 4)>::bench(y, x, CC);
#endif
}

CYBOZU_TEST_AUTO(sqr)
{
	testSqr<1>();
	testSqr<2>();
	testSqr<3>();
	testSqr<4>();
	testSqr<5>();
	testSqr<6>();
	testSqr<7>();
	testSqr<8>();
	testSqr<9>();
}

template<size_t N>
void setAndModT(const mcl::bint::SmallModP& smp, Unit x[N+1])
{
	x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], x[0] & 0x3f);
	size_t xn = x[N] == 0 ? N : N+1;
	if (!smp.modT<N>(x, x, xn)) {
		puts("ERR2");
		exit(1);
	}
}

template<size_t N>
void setAndMod(const mcl::bint::SmallModP& smp, Unit x[N+1])
{
	x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], x[0] & 0x3f);
	size_t xn = x[N] == 0 ? N : N+1;
	if (!smp.mod(x, x, xn)) {
		puts("ERR1");
		exit(1);
	}
}

template<size_t N>
void testSmallModP(const char *pStr)
{
	printf("p=%s\n", pStr);
	Unit p[N];
	const size_t FACTOR = 128;
	size_t xn = mcl::fp::hexToArray(p, N, pStr, strlen(pStr));
	CYBOZU_TEST_EQUAL(xn, N);
	mcl::bint::SmallModP smp;
	smp.init(p, N);
	cybozu::XorShift rg;
	Unit x[N+1];
	mcl::bint::copyT<N>(x, p);
	for (size_t i = 0; i < 10; i++) {
		uint32_t a = rg.get32() % FACTOR;
		x[N-1] = mcl::bint::mulUnit1(&x[N], x[N-1], a);
		size_t xn = x[N] == 0 ? N : N+1;
		Unit q[2], r[N+1];
		mcl::bint::copyN(r, x, xn);
		mcl::bint::div(q, 2, r, xn, p, N);
		CYBOZU_TEST_ASSERT(q[0] <= FACTOR && q[1] == 0);
		for (int mode = 0; mode < 2; mode++) {
			Unit r2[N];
			bool b = false;
			switch (mode) {
			case 0: b = smp.mod(r2, x, xn); break;
			case 1: b = smp.modT<N>(r2, x, xn); break;
			}
			CYBOZU_TEST_ASSERT(b);
			CYBOZU_TEST_EQUAL_ARRAY(r2, r, N);
		}
		mcl::bint::copyT<N>(x, r);
	}
#ifdef NDEBUG
	{
		if ((smp.p_[N-1] >> (MCL_UNIT_BIT_SIZE - 8)) == 0) return; // top 8-bit must be not zero
		CYBOZU_BENCH_C("mod ", 1000, setAndMod<N>, smp, x);
		CYBOZU_BENCH_C("modT", 1000, setAndModT<N>, smp, x);
	}
#endif
}

CYBOZU_TEST_AUTO(SmallModP)
{
	const size_t adj = 8 / sizeof(Unit);
	const char *tbl4[] = {
		"2523648240000001ba344d80000000086121000000000013a700000000000013",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001", // BLS12-381 r
		"7523648240000001ba344d80000000086121000000000013a700000000000017",
		"800000000000000000000000000000000000000000000000000000000000005f",
		"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", // secp256k1
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43", // max prime
		// not primes
		"ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000001",
		"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		testSmallModP<4 * adj>(tbl4[i]);
	}
	const char *tbl6[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab", // BLS12-381 p
		"240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d", // BN381 r
		"240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013", // BN381 p
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		testSmallModP<6 * adj>(tbl6[i]);
	}
}

