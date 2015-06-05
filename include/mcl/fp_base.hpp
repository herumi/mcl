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

typedef void (*void1op)(Unit*);
typedef void (*void2op)(Unit*, const Unit*);
typedef void (*void2opOp)(Unit*, const Unit*, const Op&);
typedef void (*void3op)(Unit*, const Unit*, const Unit*);
typedef void (*void4op)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2op)(Unit*, const Unit*);

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
	void1op clear;
	void2op copy;
	// not require p(function having p)
	void2op neg;
	void3op add;
	void3op sub;
	void3op mul;
	// for Montgomery
	bool useMont;
	int2op preInv;
	// require p
	void3op negP;
	void2opOp invOp;
	void4op addP;
	void4op subP;
	void3op mulPreP;
	void3op modP;
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
	void initInvTbl(size_t N)
	{
		assert(N <= maxUnitN);
		const size_t invTblN = N * sizeof(Unit) * 8 * 2;
		invTbl.resize(invTblN * N);
		Unit *tbl = invTbl.data() + (invTblN - 1) * N;
		Unit t[maxUnitN] = {};
		t[0] = 2;
		toMont(tbl, t);
		for (size_t i = 0; i < invTblN - 1; i++) {
			add(tbl - N, tbl, tbl);
			tbl -= N;
		}
	}
};


#ifdef USE_MONT_FP
const size_t UnitByteN = sizeof(Unit);
const size_t maxUnitN = (MCL_FP_BLOCK_MAX_BIT_N + UnitByteN * 8 - 1) / (UnitByteN * 8);
inline void invOpForMont(Unit *y, const Unit *x, const Op& op)
{
	Unit r[maxUnitN];
	int k = op.preInv(r, x);
	/*
		xr = 2^k
		R = 2^(N * 64)
		get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
	*/
	op.mul(y, r, op.invTbl.data() + k * op.N);
}
inline void fromRawGmp(Unit *y, size_t n, const mpz_class& x)
{
	local::toArray(y, n, x.get_mpz_t());
}

inline void initForMont(Op& op, const Unit *p)
{
	size_t N = (op.bitLen + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	if (N < 2) N = 2;
	mpz_class t = 1;
	fromRawGmp(op.one, N, t);
	t = (t << (N * 64)) % op.mp;
	t = (t * t) % op.mp;
	fromRawGmp(op.RR, N, t);
	FpGenerator *fg = op.fg;
	if (fg == 0) return;
	fg->init(p, N);

	op.neg = Xbyak::CastTo<void2op>(fg->neg_);
	op.add = Xbyak::CastTo<void3op>(fg->add_);
	op.sub = Xbyak::CastTo<void3op>(fg->sub_);
	op.mul = Xbyak::CastTo<void3op>(fg->mul_);
	op.preInv = Xbyak::CastTo<int2op>(op.fg->preInv_);
	op.invOp = &invOpForMont;
	op.useMont = true;

	op.initInvTbl(N);
}
#endif

} } // mcl::fp
