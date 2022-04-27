#include "../src/bitint.hpp"
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <gmpxx.h>
#include <iostream>

#define PUT(x) std::cout << #x "=" << (x) << std::endl;

using namespace mcl::bint;
typedef mcl::Unit Unit;

template<class RG>
void setRand(Unit *x, size_t n, RG& rg)
{
	for (size_t i = 0; i < n; i++) {
		x[i] = (Unit)rg.get64();
	}
}

void setArray(mpz_class& z, const Unit *buf, size_t n)
{
	mpz_import(z.get_mpz_t(), n, -1, sizeof(*buf), 0, 0, buf);
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
	CYBOZU_TEST_EQUAL(CF, 1);
	CYBOZU_TEST_EQUAL(z[1], 10); // not changed

	CF = addT<1>(z, x + 1, y + 1);
	CYBOZU_TEST_EQUAL(z[0], x[1] + y[1]);
	CYBOZU_TEST_EQUAL(CF, 0);
	CYBOZU_TEST_EQUAL(z[1], 10); // not changed

	CF = addT<3>(z, x, y);
	CYBOZU_TEST_EQUAL_ARRAY(z, ok, 3);
	CYBOZU_TEST_EQUAL(CF, 0);
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
		CYBOZU_TEST_EQUAL(mx + my, mz + (mpz_class(CF) << (sizeof(x) * 8)));
		Unit CF2 = subT<N>(x2, z, y);
		CYBOZU_TEST_EQUAL_ARRAY(x, x2, N);
		CYBOZU_TEST_EQUAL(CF, CF2);

	}
}

CYBOZU_TEST_AUTO(mulUnitT)
{
	const size_t N = 4;
	Unit x[N], z[N];
	cybozu::XorShift rg;
	mpz_class mx, mz;
	for (int i = 0; i < 100; i++) {
		Unit y;
		setRand(x, N, rg);
		setRand(&y, 1, rg);
		Unit u = mulUnitT<N>(z, x, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx * y, mz + (mpz_class(u) << (sizeof(x) * 8)));
	}
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
		CYBOZU_TEST_EQUAL(mz + mx * y, mt + (mpz_class(u) << (sizeof(x) * 8)));
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
		CYBOZU_TEST_EQUAL(mx << y, mz + (mpz_class(u) << (sizeof(x) * 8)));
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
		Unit u = addUnit(z, x, N, y);
		setArray(mx, x, N);
		setArray(mz, z, N);
		CYBOZU_TEST_EQUAL(mx + y, mz + (mpz_class(u) << (sizeof(Unit) * N * 8)));
		Unit x2[N];
		Unit u2 = subUnit(x2, z, N, y);
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
		CYBOZU_TEST_EQUAL(mx, mq * y + r);
		Unit r2 = modUnit(x, N, y);
		CYBOZU_TEST_EQUAL(r, r2);
	}
}

CYBOZU_TEST_AUTO(divFullBitT)
{
	const size_t xN = 7;
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
		size_t rn = divFullBitT<yN>(q, qN, x, xN, y);
		setArray(mq, q, qN);
		setArray(mr, x, rn);
		CYBOZU_TEST_EQUAL(mq * my + mr, mx);
	}
}
