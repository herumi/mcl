#pragma once
/**
	@file
	@brief definition of Op
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <assert.h>
#include <cybozu/inttype.hpp>
#include <mcl/unit.hpp>

#ifndef MCL_MAX_OP_BIT_N
	#define MCL_MAX_OP_BIT_N 521
#endif

namespace mcl {

namespace fp {

struct FpGenerator;

const size_t maxOpUnitN = (MCL_MAX_OP_BIT_N + UnitBitN - 1) / UnitBitN;

struct Op;

typedef void (*void1u)(Unit*);
typedef void (*void2u)(Unit*, const Unit*);
typedef void (*void2uOp)(Unit*, const Unit*, const Op&);
typedef void (*void3u)(Unit*, const Unit*, const Unit*);
typedef void (*void4u)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2u)(Unit*, const Unit*);

struct Block {
	const Unit *p; // pointer to original FpT.v_
	size_t n;
	Unit v_[maxOpUnitN];
};

struct Op {
	mpz_class mp;
	mcl::SquareRoot sq;
	Unit p[maxOpUnitN];
	/*
		for Montgomery
		one = 1
		R = (1 << (N * sizeof(Unit) * 8)) % p
		RR = (R * R) % p
	*/
	Unit one[maxOpUnitN];
	Unit RR[maxOpUnitN];
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
private:
	Op(const Op&);
	void operator==(const Op&);
};

} } // mcl::fp
