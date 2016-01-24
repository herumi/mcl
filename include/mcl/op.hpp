#pragma once
/**
	@file
	@brief definition of Op
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>

#ifndef MCL_MAX_OP_BIT_SIZE
	#define MCL_MAX_OP_BIT_SIZE 521
#endif
#if !defined(MCL_DONT_USE_XBYAK) && (defined(_WIN64) || defined(__x86_64__))
	#define MCL_USE_XBYAK
#endif

namespace mcl { namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
typedef uint32_t Unit;
#else
typedef uint64_t Unit;
#endif
const size_t UnitBitSize = sizeof(Unit) * 8;

const size_t maxOpUnitSize = (MCL_MAX_OP_BIT_SIZE + UnitBitSize - 1) / UnitBitSize;

struct FpGenerator;
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
	Unit v_[maxOpUnitSize];
};

enum Mode {
	FP_AUTO,
	FP_GMP,
	FP_LLVM,
	FP_LLVM_MONT,
	FP_XBYAK
};

struct Op {
	mpz_class mp;
	mcl::SquareRoot sq;
	Unit p[maxOpUnitSize];
	Unit half[maxOpUnitSize]; // (p - 1) / 2
	Unit oneRep[maxOpUnitSize]; // 1(=inv R if Montgomery)
	/*
		for Montgomery
		one = 1
		R = (1 << (N * sizeof(Unit) * 8)) % p
		R2 = (R * R) % p
		R3 = RR^3
	*/
	Unit one[maxOpUnitSize];
	Unit R2[maxOpUnitSize];
	Unit R3[maxOpUnitSize];
	std::vector<Unit> invTbl;
	size_t N;
	size_t bitSize;
	// independent from p
	bool (*isZero)(const Unit*);
	void1u clear;
	void2u copy;
	// not require p(function having p)
	void2u neg;
	void2u sqr;
	void3u add;
	void3u sub;
	void3u mul;
	// for Montgomery
	bool useMont;
	int2u preInv;
	// these two members are for mcl_fp_mont
	Unit rp;
	void (*mont)(Unit *z, const Unit *x, const Unit *y, const Unit *p, Unit rp);
	// require p
	void3u negP;
	void2u sqrPreP;
	void2uOp invOp;
	void4u addP;
	void4u subP;
	void3u mulPreP;
	void3u modP;
	FpGenerator *fg;
	Op()
		: N(0), bitSize(0)
		, isZero(0), clear(0), copy(0)
		, neg(0), sqr(0), add(0), sub(0), mul(0)
		, useMont(false), preInv(0)
		, rp(0), mont(0)
		, negP(0), sqrPreP(0), invOp(0), addP(0), subP(0), mulPreP(0), modP(0)
		, fg(createFpGenerator())
	{
	}
	~Op()
	{
		destroyFpGenerator(fg);
	}
	void fromMont(Unit* y, const Unit *x) const
	{
		/*
			M(x, y) = xyR^-1
			y = M(x, 1) = xR^-1
		*/
		mul(y, x, one);
	}
	void toMont(Unit* y, const Unit *x) const
	{
		/*
			y = M(x, R2) = xR^2 R^-1 = xR
		*/
		mul(y, x, R2);
	}
	void init(const std::string& mstr, int base, size_t maxBitSize, Mode mode);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
private:
	Op(const Op&);
	void operator=(const Op&);
};

} } // mcl::fp
