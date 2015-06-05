#pragma once
/**
	@file
	@brief basic operation
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4616)
	#pragma warning(disable : 4800)
	#pragma warning(disable : 4244)
	#pragma warning(disable : 4127)
	#pragma warning(disable : 4512)
	#pragma warning(disable : 4146)
#endif
#include <iostream>
#include <stdint.h>
#include <assert.h>
#include <mcl/gmp_util.hpp>
#ifdef _MSC_VER
	#pragma warning(pop)
#endif
#include <cybozu/inttype.hpp>

#ifndef MCL_FP_BLOCK_MAX_BIT_N
	#define MCL_FP_BLOCK_MAX_BIT_N 521
#endif

namespace mcl {

struct FpGenerator;

namespace montgomery {

} } // mcl::montgomery


namespace mcl { namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
typedef uint32_t Unit;
#else
typedef uint64_t Unit;
#endif
const size_t UnitBitN = sizeof(Unit) * 8;
const size_t maxUnitN = (MCL_FP_BLOCK_MAX_BIT_N + UnitBitN - 1) / UnitBitN;

struct Op;

typedef void (*void1u)(Unit*);
typedef void (*void2u)(Unit*, const Unit*);
typedef void (*void2uOp)(Unit*, const Unit*, const Op&);
typedef void (*void3u)(Unit*, const Unit*, const Unit*);
typedef void (*void4u)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2u)(Unit*, const Unit*);

struct Op {
	mpz_class mp;
	mcl::SquareRoot sq;
	Unit p[maxUnitN];
	/*
		for Montgomery
		one = 1
		R = (1 << (N * sizeof(Unit) * 8)) % p
		RR = (R * R) % p
	*/
	Unit one[maxUnitN];
	Unit RR[maxUnitN];
	std::vector<Unit> invTbl;
	size_t N;
	size_t bitLen;
	// independent from p
	bool (*isZero)(const Unit*);
	void1u clear;
	void2u copy;
	// not require p(function having p)
	void2u neg;
	void3u add;
	void3u sub;
	void3u mul;
	// for Montgomery
	bool useMont;
	int2u preInv;
	// require p
	void3u negP;
	void2uOp invOp;
	void4u addP;
	void4u subP;
	void3u mulPreP;
	void3u modP;
	FpGenerator *fg;
	Op()
		: p(), N(0), bitLen(0)
		, isZero(0), clear(0), copy(0)
		, neg(0), add(0), sub(0), mul(0)
		, useMont(false), preInv(0)
		, negP(0), invOp(0), addP(0), subP(0), mulPreP(0), modP(0)
		, fg(createFpGenerator())
	{
	}
	~Op()
	{
		destroyFpGenerator(fg);
	}
	void fromMont(Unit* y, const Unit *x) const
	{
		mul(y, x, one);
	}
	void toMont(Unit* y, const Unit *x) const
	{
		mul(y, x, RR);
	}
	void init(const Unit *p, size_t bitLen);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
};

/*
	get pp such that p * pp = -1 mod M,
	where p is prime and M = 1 << 64(or 32).
	@param pLow [in] p mod M
	T is uint32_t or uint64_t
*/
inline Unit getMontgomeryCoeff(Unit pLow)
{
	Unit ret = 0;
	Unit t = 0;
	Unit x = 1;

	for (size_t i = 0; i < UnitBitN; i++) {
		if ((t & 1) == 0) {
			t += pLow;
			ret += x;
		}
		t >>= 1;
		x <<= 1;
	}
	return ret;
}

namespace local {

inline int compareArray(const Unit* x, const Unit* y, size_t n)
{
	for (size_t i = n - 1; i != size_t(-1); i--) {
		if (x[i] < y[i]) return -1;
		if (x[i] > y[i]) return 1;
	}
	return 0;
}

inline bool isEqualArray(const Unit* x, const Unit* y, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i] != y[i]) return false;
	}
	return true;
}

inline bool isZeroArray(const Unit *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i]) return false;
	}
	return true;
}

inline void clearArray(Unit *x, size_t begin, size_t end)
{
	for (size_t i = begin; i < end; i++) x[i] = 0;
}

inline void copyArray(Unit *y, const Unit *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

inline void toArray(Unit *y, size_t yn, const mpz_srcptr x)
{
	const int xn = x->_mp_size;
	assert(xn >= 0);
	const Unit* xp = (const Unit*)x->_mp_d;
	assert(xn <= (int)yn);
	copyArray(y, xp, xn);
	clearArray(y, xn, yn);
}

} // mcl::fp::local

struct Block {
	const Unit *p; // pointer to original FpT.v_
	size_t n;
	Unit v_[maxUnitN];
};

} } // mcl::fp
