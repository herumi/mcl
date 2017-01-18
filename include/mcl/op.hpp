#pragma once
/**
	@file
	@brief definition of Op
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>

#ifndef MCL_MAX_BIT_SIZE
	#define MCL_MAX_BIT_SIZE 521
#endif
#if !defined(MCL_DONT_USE_XBYAK) && (defined(_WIN64) || defined(__x86_64__))
	#define MCL_USE_XBYAK
#endif

namespace mcl {

namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
typedef uint32_t Unit;
#else
typedef uint64_t Unit;
#endif
const size_t UnitBitSize = sizeof(Unit) * 8;

const size_t maxOpUnitSize = (MCL_MAX_BIT_SIZE + UnitBitSize - 1) / UnitBitSize;

struct FpGenerator;
struct Op;

typedef void (*void1u)(Unit*);
typedef void (*void2u)(Unit*, const Unit*);
typedef void (*void2uI)(Unit*, const Unit*, Unit);
typedef void (*void2uIu)(Unit*, const Unit*, Unit, const Unit*);
typedef void (*void2uOp)(Unit*, const Unit*, const Op&);
typedef void (*void3u)(Unit*, const Unit*, const Unit*);
typedef void (*void4u)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2u)(Unit*, const Unit*);

typedef Unit (*u1uII)(Unit*, Unit, Unit);
typedef Unit (*u3u)(Unit*, const Unit*, const Unit*);

struct Block {
	const Unit *p; // pointer to original FpT.v_
	size_t n;
	Unit v_[maxOpUnitSize];
};

enum Mode {
	FP_AUTO,
	FP_GMP,
	FP_GMP_MONT,
	FP_LLVM,
	FP_LLVM_MONT,
	FP_XBYAK
};

enum PrimeMode {
	PM_GENERIC = 0,
	PM_NICT_P192,
	PM_NICT_P521
};

struct Op {
	/*
		don't change the layout of rp and p
		asm code assumes &rp + 1 == p
	*/
	Unit rp;
	Unit p[maxOpUnitSize];
	mpz_class mp;
	mcl::SquareRoot sq;
	FpGenerator *fg;
	Unit half[maxOpUnitSize]; // (p + 1) / 2
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
	bool (*fp_isZero)(const Unit*);
	void1u fp_clear;
	void2u fp_copy;
	void2u fp_shr1;
	void3u fp_neg;
	void4u fp_add;
	void4u fp_sub;
	void4u fp_mul;
	void3u fp_sqr;
	void2uOp fp_invOp;
	void2uIu fp_mulUnit; // fpN1_mod + fp_mulUnitPre

	void3u fpDbl_mulPre;
	void2u fpDbl_sqrPre;
	int2u fp_preInv;
	void2uI fp_mulUnitPre; // z[N + 1] = x[N] * y
	void3u fpN1_mod; // y[N] = x[N + 1] % p[N]

	void4u fpDbl_add;
	void4u fpDbl_sub;
	void3u fpDbl_mod;

	u3u fp_addPre; // without modulo p
	u3u fp_subPre; // without modulo p
	u3u fpDbl_addPre;
	u3u fpDbl_subPre;
	/*
		for Fp2 = F[u] / (u^2 + 1)
		x = a + bu
	*/
	int xi_a; // xi = xi_a + u
	void3u fp2_add;
	void3u fp2_sub;
	void3u fp2_mul;
	void4u fp2_mulNF;
	void2u fp2_neg;
	void2u fp2_inv;
	void2u fp2_sqr;
	void2u fp2_mul_xi;

	PrimeMode primeMode;
	bool isFullBit; // true if bitSize % uniSize == 0
	bool isMont; // true if use Montgomery
	bool isFastMod; // true if modulo is fast

	Op()
	{
		clear();
		fg = 0;
	}
	~Op()
	{
		destroyFpGenerator(fg);
	}
	void clear()
	{
		rp = 0;
		memset(p, 0, sizeof(p));
		mp = 0;
		sq.clear();
		// fg is not set
		memset(half, 0, sizeof(half));
		memset(oneRep, 0, sizeof(oneRep));
		memset(one, 0, sizeof(one));
		memset(R2, 0, sizeof(R2));
		memset(R3, 0, sizeof(R3));
		invTbl.clear();
		N = 0;
		bitSize = 0;
		fp_isZero = 0;
		fp_clear = 0;
		fp_copy = 0;
		fp_shr1 = 0;
		fp_neg = 0;
		fp_add = 0;
		fp_sub = 0;
		fp_mul = 0;
		fp_sqr = 0;
		fp_invOp = 0;
		fp_mulUnit = 0;

		fpDbl_mulPre = 0;
		fpDbl_sqrPre = 0;
		fp_preInv = 0;
		fp_mulUnitPre = 0;
		fpN1_mod = 0;

		fpDbl_add = 0;
		fpDbl_sub = 0;
		fpDbl_mod = 0;

		fp_addPre = 0;
		fp_subPre = 0;
		fpDbl_addPre = 0;
		fpDbl_subPre = 0;

		xi_a = 0;
		fp2_add = 0;
		fp2_sub = 0;
		fp2_mul = 0;
		fp2_mulNF = 0;
		fp2_neg = 0;
		fp2_inv = 0;
		fp2_sqr = 0;
		fp2_mul_xi = 0;

		primeMode = PM_GENERIC;
		isFullBit = false;
		isMont = false;
		isFastMod = false;
	}
	void fromMont(Unit* y, const Unit *x) const
	{
		/*
			M(x, y) = xyR^-1
			y = M(x, 1) = xR^-1
		*/
		fp_mul(y, x, one, p);
	}
	void toMont(Unit* y, const Unit *x) const
	{
		/*
			y = M(x, R2) = xR^2 R^-1 = xR
		*/
		fp_mul(y, x, R2, p);
	}
	void init(const std::string& mstr, size_t maxBitSize, Mode mode);
	void initFp2(int xi_a);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
private:
	Op(const Op&);
	void operator=(const Op&);
};

} } // mcl::fp
