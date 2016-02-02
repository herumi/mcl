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
	bool (*fp_isZero)(const Unit*);
	void1u fp_clear;
	void2u fp_copy;
	// not require p(function having p)
	void2u fp_neg;
	void2u fp_sqr;
	void3u fp_add;
	void3u fp_sub;
	void3u fp_mul;
	// for Montgomery
	bool useMont;
	int2u fp_preInv;
	// these two members are for mcl_fp_mont
	Unit rp;
	void (*mont)(Unit *z, const Unit *x, const Unit *y, const Unit *p, Unit rp);
	// require p
	void3u fp_negP;
	void2u fp_sqrPreP;
	void2uOp fp_invOp;
	void4u fp_addP;
	void4u fp_subP;
	void3u fp_mulPreP;
	void3u fp_modP;
	FpGenerator *fg;
	Op()
		: N(0), bitSize(0)
		, fp_isZero(0), fp_clear(0), fp_copy(0)
		, fp_neg(0), fp_sqr(0), fp_add(0), fp_sub(0), fp_mul(0)
		, useMont(false), fp_preInv(0)
		, rp(0), mont(0)
		, fp_negP(0), fp_sqrPreP(0), fp_invOp(0), fp_addP(0), fp_subP(0), fp_mulPreP(0), fp_modP(0)
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
		fp_mul(y, x, one);
	}
	void toMont(Unit* y, const Unit *x) const
	{
		/*
			y = M(x, R2) = xR^2 R^-1 = xR
		*/
		fp_mul(y, x, R2);
	}
	void init(const std::string& mstr, int base, size_t maxBitSize, Mode mode);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
private:
	Op(const Op&);
	void operator=(const Op&);
};

/*
	for Fp2 = F[u] / (u^2 + 1)
	x = a + bu
*/
struct Op2 {
	Op *op;
	int xi_c; // xi = u + xi_c
	void3u add;
	void3u sub;
	void3u mul;
	void2u neg;
	void2u sqr;
	void2u mul_xi;
	Op2()
		: op(0), xi_c(0), add(0), sub(0), mul(0), neg(0), sqr(0), mul_xi(0)
	{
	}
	void init(Op *op, int xi_c);
};

} } // mcl::fp
