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
#endif

namespace mcl { namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
typedef uint32_t Unit;
#else
typedef uint64_t Unit;
#endif

typedef void (*void1op)(Unit*);
typedef void (*void2op)(Unit*, const Unit*);
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

inline void set_mpz_t(mpz_t& z, const Unit* p, int n)
{
	z->_mp_alloc = n;
	int i = n;
	while (i > 0 && p[i - 1] == 0) {
		i--;
	}
	z->_mp_size = i;
	z->_mp_d = (mp_limb_t*)const_cast<Unit*>(p);
}

inline void set_zero(mpz_t& z, Unit *p, size_t n)
{
	z->_mp_alloc = (int)n;
	z->_mp_size = 0;
	z->_mp_d = (mp_limb_t*)p;
}

} // mcl::fp::local
struct TagDefault;

static inline void modC(Unit *y, const Unit *x, const mpz_class& mp, size_t N)
{
	mpz_t mx, my;
	local::set_mpz_t(mx, x, N * 2);
	local::set_mpz_t(my, y, N);
	mpz_mod(my, mx, mp.get_mpz_t());
	local::clearArray(y, my->_mp_size, N);
}

#ifndef MCL_FP_BLOCK_MAX_BIT_N
	#define MCL_FP_BLOCK_MAX_BIT_N 521
#endif

struct Op {
	static const size_t UnitByteN = sizeof(Unit);
	static const size_t maxUnitN = (MCL_FP_BLOCK_MAX_BIT_N + UnitByteN * 8 - 1) / (UnitByteN * 8);
	mpz_class mp;
	mcl::SquareRoot sq;
	Unit p[maxUnitN];
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
	void2op toMont;
	void2op fromMont;
	// require p
	void3op negG;
	void3op invG;
	void4op addG;
	void4op subG;
	void3op mulPreG;
	void3op modG;
	Op()
		: p(), N(0), bitLen(0)
		, isZero(0), clear(0), copy(0)
		, neg(0), inv(0), add(0), sub(0), mul(0)
		, toMont(0), fromMont(0)
		, negG(0), invG(0), addG(0), subG(0), mulPreG(0), modG(0)
	{
	}
};

template<size_t bitN>
struct OpeFunc {
	typedef fp::Unit Unit;
	static const size_t N = (bitN + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	static inline void set_mpz_t(mpz_t& z, const Unit* p, int n = (int)N)
	{
		z->_mp_alloc = n;
		int i = n;
		while (i > 0 && p[i - 1] == 0) {
			i--;
		}
		z->_mp_size = i;
		z->_mp_d = (mp_limb_t*)const_cast<Unit*>(p);
	}
	static inline void set_zero(mpz_t& z, Unit *p, size_t n)
	{
		z->_mp_alloc = (int)n;
		z->_mp_size = 0;
		z->_mp_d = (mp_limb_t*)p;
	}
	static inline void clearC(Unit *x)
	{
		local::clearArray(x, 0, N);
	}
	static inline void copyC(Unit *y, const Unit *x)
	{
		local::copyArray(y, x, N);
	}
	static inline void addC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit ret[N + 2]; // not N + 1
		mpz_t mz, mx, my, mp;
		set_zero(mz, ret, N + 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_add(mz, mx, my);
		if (mpz_cmp(mz, mp) >= 0) {
			mpz_sub(mz, mz, mp);
		}
		local::toArray(z, N, mz);
	}
	static inline void subC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit ret[N + 1];
		mpz_t mz, mx, my;
		set_zero(mz, ret, N + 1);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_sub(mz, mx, my);
		if (mpz_sgn(mz) < 0) {
			mpz_t mp;
			set_mpz_t(mp, p);
			mpz_add(mz, mz, mp);
		}
		local::toArray(z, N, mz);
	}
	static inline void mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpz_t mx, my, mz;
		set_zero(mz, z, N * 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_mul(mz, mx, my);
		local::toArray(z, N * 2, mz);
	}
	// x[N * 2] -> y[N]
	static inline void modC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_t mx, my, mp;
		set_mpz_t(mx, x, N * 2);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_mod(my, mx, mp);
		local::clearArray(y, my->_mp_size, N);
	}
	static inline void invC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_class my;
		mpz_t mx, mp;
		set_mpz_t(mx, x);
		set_mpz_t(mp, p);
		mpz_invert(my.get_mpz_t(), mx, mp);
		local::toArray(y, N, my.get_mpz_t());
	}
	static inline bool isZeroC(const Unit *x)
	{
		return local::isZeroArray(x, N);
	}
	static inline void negC(Unit *y, const Unit *x, const Unit *p)
	{
		if (isZeroC(x)) {
			if (x != y) clearC(y);
			return;
		}
		subC(y, p, x, p);
	}
};

inline void initOp(Op& op, size_t bitN, const fp::Unit*)
{
	typedef fp::Unit Unit;
	assert(sizeof(mp_limb_t) == sizeof(Unit));
	const size_t UnitBitN = sizeof(Unit) * 8;

	if (bitN <= 128) {
		op.N = 128 / UnitBitN;
		op.isZero = OpeFunc<128>::isZeroC;
		op.clear = OpeFunc<128>::clearC;
		op.copy = OpeFunc<128>::copyC;
		op.negG = OpeFunc<128>::negC;
		op.invG = OpeFunc<128>::invC;
		op.addG = OpeFunc<128>::addC;
		op.subG = OpeFunc<128>::subC;
		op.mulPreG = OpeFunc<128>::mulPreC;
		op.modG = OpeFunc<128>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add128S;
		op.subG = mcl_fp_sub128S;
		op.mulPreG = mcl_fp_mulPre128;
#endif
	} else
#if CYBOZU_OS_BIT == 32
	if (bitN <= 160) {
		op.N = 160 / UnitBitN;
		op.isZero = OpeFunc<160>::isZeroC;
		op.clear = OpeFunc<160>::clearC;
		op.copy = OpeFunc<160>::copyC;
		op.negG = OpeFunc<160>::negC;
		op.invG = OpeFunc<160>::invC;
		op.addG = OpeFunc<160>::addC;
		op.subG = OpeFunc<160>::subC;
		op.mulPreG = OpeFunc<160>::mulPreC;
		op.modG = OpeFunc<160>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add160S;
		op.subG = mcl_fp_sub160S;
		op.mulPreG = mcl_fp_mulPre160;
#endif
	} else
#endif
	if (bitN <= 192) {
		op.N = 192 / UnitBitN;
		op.isZero = OpeFunc<192>::isZeroC;
		op.clear = OpeFunc<192>::clearC;
		op.copy = OpeFunc<192>::copyC;
		op.negG = OpeFunc<192>::negC;
		op.invG = OpeFunc<192>::invC;
		op.addG = OpeFunc<192>::addC;
		op.subG = OpeFunc<192>::subC;
		op.mulPreG = OpeFunc<192>::mulPreC;
		op.modG = OpeFunc<192>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add192S;
		op.subG = mcl_fp_sub192S;
		op.mulPreG = mcl_fp_mulPre192;
#endif
	} else
#if CYBOZU_OS_BIT == 32
	if (bitN <= 224) {
		op.N = 224 / UnitBitN;
		op.isZero = OpeFunc<224>::isZeroC;
		op.clear = OpeFunc<224>::clearC;
		op.copy = OpeFunc<224>::copyC;
		op.negG = OpeFunc<224>::negC;
		op.invG = OpeFunc<224>::invC;
		op.addG = OpeFunc<224>::addC;
		op.subG = OpeFunc<224>::subC;
		op.mulPreG = OpeFunc<224>::mulPreC;
		op.modG = OpeFunc<224>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add224S;
		op.subG = mcl_fp_sub224S;
		op.mulPreG = mcl_fp_mulPre224;
#endif
	} else
#endif
	if (bitN <= 256) {
		op.N = 256 / UnitBitN;
		op.isZero = OpeFunc<256>::isZeroC;
		op.clear = OpeFunc<256>::clearC;
		op.copy = OpeFunc<256>::copyC;
		op.negG = OpeFunc<256>::negC;
		op.invG = OpeFunc<256>::invC;
		op.addG = OpeFunc<256>::addC;
		op.subG = OpeFunc<256>::subC;
		op.mulPreG = OpeFunc<256>::mulPreC;
		op.modG = OpeFunc<256>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add256S;
		op.subG = mcl_fp_sub256S;
		op.mulPreG = mcl_fp_mulPre256;
#endif
	} else
	if (bitN <= 384) {
		op.N = 384 / UnitBitN;
		op.isZero = OpeFunc<384>::isZeroC;
		op.clear = OpeFunc<384>::clearC;
		op.copy = OpeFunc<384>::copyC;
		op.negG = OpeFunc<384>::negC;
		op.invG = OpeFunc<384>::invC;
		op.addG = OpeFunc<384>::addC;
		op.subG = OpeFunc<384>::subC;
		op.mulPreG = OpeFunc<384>::mulPreC;
		op.modG = OpeFunc<384>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add384S;
		op.subG = mcl_fp_sub384S;
		op.mulPreG = mcl_fp_mulPre384;
#endif
	} else
#if CYBOZU_OS_BIT == 64
	if (bitN <= 576) {
		op.N = 576 / UnitBitN;
		op.isZero = OpeFunc<576>::isZeroC;
		op.clear = OpeFunc<576>::clearC;
		op.copy = OpeFunc<576>::copyC;
		op.negG = OpeFunc<576>::negC;
		op.invG = OpeFunc<576>::invC;
		op.addG = OpeFunc<576>::addC;
		op.subG = OpeFunc<576>::subC;
		op.mulPreG = OpeFunc<576>::mulPreC;
		op.modG = OpeFunc<576>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add576S;
		op.subG = mcl_fp_sub576S;
		op.mulPreG = mcl_fp_mulPre576;
#endif
	}
#else
	if (bitN <= 544) {
		op.N = 544 / UnitBitN;
		op.isZero = OpeFunc<544>::isZeroC;
		op.clear = OpeFunc<544>::clearC;
		op.copy = OpeFunc<544>::copyC;
		op.negG = OpeFunc<544>::negC;
		op.invG = OpeFunc<544>::invC;
		op.addG = OpeFunc<544>::addC;
		op.subG = OpeFunc<544>::subC;
		op.mulPreG = OpeFunc<544>::mulPreC;
		op.modG = OpeFunc<544>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add544S;
		op.subG = mcl_fp_sub544S;
		op.mulPreG = mcl_fp_mulPre544;
#endif
	}
#endif

#ifdef MCL_USE_LLVM
	if (op.mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		op.mul = &mcl_fp_mul_NIST_P192; // slower than MontFp192
	}
#endif
}


#ifdef USE_MONT_FP
template<class tag, size_t bitN>
struct MontFp {
	typedef fp::Unit Unit;
	static const size_t N = (bitN + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	static const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	static mpz_class mp_;
//	static mcl::SquareRoot sq_;
	static Unit p_[N];
	static Unit one_[N];
	static Unit R_[N]; // (1 << (N * 64)) % p
	static Unit RR_[N]; // (R * R) % p
	static Unit invTbl_[invTblN][N];
	static size_t modBitLen_;
	static FpGenerator fg_;
	static void3op add_;
	static void3op mul_;

	static inline void fromRawGmp(Unit *y, const mpz_class& x)
	{
		local::toArray(y, N, x.get_mpz_t());
	}
	static inline void setModulo(const Unit *p)
	{
		copy(p_, p);
		Gmp::setRaw(mp_, p, N);
//		sq_.set(pOrg_);

		mpz_class t = 1;
		fromRawGmp(one_, t);
		t = (t << (N * 64)) % mp_;
		fromRawGmp(R_, t);
		t = (t * t) % mp_;
		fromRawGmp(RR_, t);
		fg_.init(p_, N);

		add_ = Xbyak::CastTo<void3op>(fg_.add_);
		mul_ = Xbyak::CastTo<void3op>(fg_.mul_);
	}
	static void initInvTbl(Unit invTbl[invTblN][N])
	{
		Unit t[N];
		clear(t);
		t[0] = 2;
		toMont(t, t);
		for (int i = 0; i < invTblN; i++) {
			copy(invTbl[invTblN - 1 - i], t);
			add_(t, t, t);
		}
	}
	static inline void clear(Unit *x)
	{
		local::clearArray(x, 0, N);
	}
	static inline void copy(Unit *y, const Unit *x)
	{
		local::copyArray(y, x, N);
	}
	static inline bool isZero(const Unit *x)
	{
		return local::isZeroArray(x, N);
	}
	static inline void invC(Unit *y, const Unit *x)
	{
		const int2op preInv = Xbyak::CastTo<int2op>(fg_.preInv_);
		Unit r[N];
		int k = preInv(r, x);
		/*
			xr = 2^k
			R = 2^(N * 64)
			get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
		*/
		mul_(y, r, invTbl_[k]);
	}
	static inline void squareC(Unit *y, const Unit *x)
	{
		mul_(y, x, x);
	}
	static inline void toMont(Unit *y, const Unit *x)
	{
		mul_(y, x, RR_);
	}
	static inline void fromMont(Unit *y, const Unit *x)
	{
		mul_(y, x, one_);
	}
	static inline void init(Op& op, const Unit *p)
	{
puts("use MontFp2");
		setModulo(p);
		op.N = N;
		op.isZero = &isZero;
		op.clear = &clear;
		op.neg = Xbyak::CastTo<void2op>(fg_.neg_);
		op.inv = &invC;
//		{
//			void2op square = Xbyak::CastTo<void2op>(fg_.sqr_);
//			if (square) op.square = square;
//		}
		op.copy = &copy;
		op.add = add_;
		op.sub = Xbyak::CastTo<void3op>(fg_.sub_);
		op.mul = mul_;
		op.mp = mp_;
//		op.p = &p_[0];
		copy(op.p, p_);
		op.toMont = &toMont;
		op.fromMont = &fromMont;

//		shr1 = Xbyak::CastTo<void2op>(fg_.shr1_);
//		addNc = Xbyak::CastTo<bool3op>(fg_.addNc_);
//		subNc = Xbyak::CastTo<bool3op>(fg_.subNc_);
		initInvTbl(invTbl_);
	}
};
template<class tag, size_t bitN> mpz_class MontFp<tag, bitN>::mp_;
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::p_[MontFp<tag, bitN>::N];
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::one_[MontFp<tag, bitN>::N];
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::R_[MontFp<tag, bitN>::N];
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::RR_[MontFp<tag, bitN>::N];
template<class tag, size_t bitN> fp::Unit MontFp<tag, bitN>::invTbl_[MontFp<tag, bitN>::invTblN][MontFp<tag, bitN>::N];
template<class tag, size_t bitN> size_t MontFp<tag, bitN>::modBitLen_;
template<class tag, size_t bitN> FpGenerator MontFp<tag, bitN>::fg_;
template<class tag, size_t bitN> void3op MontFp<tag, bitN>::add_;
template<class tag, size_t bitN> void3op MontFp<tag, bitN>::mul_;
#endif

} } // mcl::fp
