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
	Unit one[maxUnitN]; // 1
	Unit RR[maxUnitN]; // (R * R) % p
	size_t N;
	size_t bitLen;
	// independent from p
	bool (*isZero)(const Unit*);
	void1op clear;
	void2op copy;
	// not require p(function having p)
	void2op neg;
	void2op inv;
	void3op add;
	void3op sub;
	void3op mul;
	// for Montgomery
	bool useMont;
	// require p
	void3op negG;
	void2opOp invG;
	void4op addG;
	void4op subG;
	void3op mulPreG;
	void3op modG;
	FpGenerator *fg;
	Op()
		: p(), N(0), bitLen(0)
		, isZero(0), clear(0), copy(0)
		, neg(0), inv(0), add(0), sub(0), mul(0)
		, useMont(false)//, toMont(0), fromMont(0)
		, negG(0), invG(0), addG(0), subG(0), mulPreG(0), modG(0)
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


#ifdef USE_MONT_FP
template<class tag, size_t bitN>
struct MontFp {
	typedef fp::Unit Unit;
	static const size_t N = (bitN + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	static const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	static Unit invTbl_[invTblN][N];
	static FpGenerator fg_;

	static inline void fromRawGmp(Unit *y, size_t n, const mpz_class& x)
	{
		local::toArray(y, n, x.get_mpz_t());
	}
	static void initInvTbl(Unit invTbl[invTblN][N], const Op& op)
	{
		Unit t[N];
		memset(t, 0, sizeof(t));
		t[0] = 2;
		op.toMont(t, t);
		for (int i = 0; i < invTblN; i++) {
			op.copy(invTbl[invTblN - 1 - i], t);
			op.add(t, t, t);
		}
	}
	static inline void copy(Unit *y, const Unit *x)
	{
		local::copyArray(y, x, N);
	}
	static inline void invC(Unit *y, const Unit *x, const Op& op)
	{
		const int2op preInv = Xbyak::CastTo<int2op>(op.fg->preInv_);
		Unit r[N];
		int k = preInv(r, x);
		/*
			xr = 2^k
			R = 2^(N * 64)
			get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
		*/
		op.mul(y, r, invTbl_[k]);
	}
	static inline void init(Op& op, const Unit *p)
	{
		mpz_class t = 1;
		fromRawGmp(op.one, N, t);
		t = (t << (N * 64)) % op.mp;
		t = (t * t) % op.mp;
		fromRawGmp(op.RR, N, t);
		fg_.init(p, N);

		op.neg = Xbyak::CastTo<void2op>(fg_.neg_);
		op.invG = &invC;
		op.add = Xbyak::CastTo<void3op>(fg_.add_);
		op.sub = Xbyak::CastTo<void3op>(fg_.sub_);
		op.mul = Xbyak::CastTo<void3op>(fg_.mul_);
		op.useMont = true;

		initInvTbl(invTbl_, op);
		op.fg = &fg_;
	}
};
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::invTbl_[MontFp<tag, bitN>::invTblN][MontFp<tag, bitN>::N];
template<class tag, size_t bitN> FpGenerator MontFp<tag, bitN>::fg_;
#endif

} } // mcl::fp
