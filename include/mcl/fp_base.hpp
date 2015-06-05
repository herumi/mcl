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
#ifdef USE_MONT_FP
#include <mcl/fp_generator.hpp>
#else
namespace mcl {
struct FpGenerator;
}
#endif

namespace mcl { namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
typedef uint32_t Unit;
#else
typedef uint64_t Unit;
#endif

struct Op;

typedef void (*void1u)(Unit*);
typedef void (*void2u)(Unit*, const Unit*);
typedef void (*void2uOp)(Unit*, const Unit*, const Op&);
typedef void (*void3u)(Unit*, const Unit*, const Unit*);
typedef void (*void4u)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2u)(Unit*, const Unit*);

} } // mcl::fp

#ifdef MCL_USE_LLVM

extern "C" {

#define MCL_FP_DEF_FUNC(len) \
void mcl_fp_add ## len ## S(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_add ## len ## L(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_sub ## len ## S(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_sub ## len ## L(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_mulPre ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*); \
void mcl_fp_mont ## len(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*, mcl::fp::Unit);

MCL_FP_DEF_FUNC(128)
MCL_FP_DEF_FUNC(192)
MCL_FP_DEF_FUNC(256)
MCL_FP_DEF_FUNC(320)
MCL_FP_DEF_FUNC(384)
MCL_FP_DEF_FUNC(448)
MCL_FP_DEF_FUNC(512)
#if CYBOZU_OS_BIT == 32
MCL_FP_DEF_FUNC(160)
MCL_FP_DEF_FUNC(224)
MCL_FP_DEF_FUNC(288)
MCL_FP_DEF_FUNC(352)
MCL_FP_DEF_FUNC(416)
MCL_FP_DEF_FUNC(480)
MCL_FP_DEF_FUNC(544)
#else
MCL_FP_DEF_FUNC(576)
#endif

void mcl_fp_mul_NIST_P192(mcl::fp::Unit*, const mcl::fp::Unit*, const mcl::fp::Unit*);

}

#endif

namespace mcl { namespace fp {

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
struct TagDefault;

#ifndef MCL_FP_BLOCK_MAX_BIT_N
	#define MCL_FP_BLOCK_MAX_BIT_N 521
#endif

FpGenerator *createFpGenerator();
void destroyFpGenerator(FpGenerator*);

struct Op {
	static const size_t UnitByteN = sizeof(Unit);
	static const size_t maxUnitN = (MCL_FP_BLOCK_MAX_BIT_N + UnitByteN * 8 - 1) / (UnitByteN * 8);
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
};


} } // mcl::fp
