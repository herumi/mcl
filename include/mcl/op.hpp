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

namespace mcl {

namespace fp {

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
typedef void (*void2uI)(Unit*, const Unit*, Unit);
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
	FP_GMP_MONT,
	FP_LLVM,
	FP_LLVM_MONT,
	FP_XBYAK
};

enum PrimeMode {
	PM_GENERIC = 0,
	PM_NICT_P192,
	PM_NICT_P521,
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
	void3u fp_neg;
	void3u fp_sqr;
	void4u fp_add;
	void4u fp_sub;
	void4u fp_mul;
	void2uI fp_mul_UnitPre; // z[N + 1] = x[N] * y
	void3u fpN1_mod; // y[N] = x[N + 1] % p[N]
	void2uI fp_mul_Unit; // fpN1_mod + fp_mul_UnitPre

	bool isFullBit; // true if bitSize % uniSize == 0
	bool isMont; // true if use Montgomery
	PrimeMode primeMode;
	bool isFastMod; // true if modulo is fast
	/*
		same fp_add, fp_sub if isFullBit
	*/
	void3u fp_addNC; // assume no carry if !isFullBit
	void3u fp_subNC; // assume x > y
	// for Montgomery
	int2u fp_preInv;
	void2uOp fp_invOp;

	/*
		for FpDbl
	*/
	void4u fpDbl_add;
	void4u fpDbl_sub;
	void3u fpDbl_addNC;
	void3u fpDbl_subNC;

	/*
		FpDbl <=> Fp
	*/
	void2u fpDbl_sqrPre;
	void3u fpDbl_mulPre;
	void3u fpDbl_mod;

	/*
		for Fp2 = F[u] / (u^2 + 1)
		x = a + bu
	*/
	int xi_a; // xi = xi_a + u
	void3u fp2_add;
	void3u fp2_sub;
	void3u fp2_mul;
	void2u fp2_neg;
	void2u fp2_inv;
	void2u fp2_sqr;
	void2u fp2_mul_xi;

	Op()
	{
		clear();
		fg = createFpGenerator();
	}
	~Op()
	{
		destroyFpGenerator(fg);
	}
	void clear()
	{
		rp = 0;
		mp = 0;
		sq.clear();
		// fg is not set
		invTbl.clear();
		N = 0;
		bitSize = 0;
		fp_isZero = 0;
		fp_clear = 0;
		fp_copy = 0;
		fp_neg = 0;
		fp_sqr = 0;
		fp_add = 0;
		fp_sub = 0;
		fp_mul = 0;
		fp_mul_UnitPre = 0;
		fpN1_mod = 0;
		fp_mul_Unit = 0;
		isFullBit = false;
		isMont = false;
		primeMode = PM_GENERIC;
		isFastMod = false;
		fp_addNC = 0;
		fp_subNC = 0;
		fp_preInv = 0;
		fp_invOp = 0;
		fpDbl_add = 0;
		fpDbl_sub = 0;
		fpDbl_addNC = 0;
		fpDbl_subNC = 0;
		fpDbl_sqrPre = 0;
		fpDbl_mulPre = 0;
		fpDbl_mod = 0;
		xi_a = 0;
		fp2_add = 0;
		fp2_sub = 0;
		fp2_mul = 0;
		fp2_neg = 0;
		fp2_inv = 0;
		fp2_sqr = 0;
		fp2_mul_xi = 0;
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
	void init(const std::string& mstr, int base, size_t maxBitSize, Mode mode);
	void initFp2(int xi_a);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
private:
	Op(const Op&);
	void operator=(const Op&);
};

} } // mcl::fp
