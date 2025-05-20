#pragma once
/*
	@file
	@brief low level functions
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/config.hpp>
#include <mcl/util.hpp>
#include <assert.h>
#ifndef MCL_STANDALONE
#include <stdio.h>
#endif

//#define MCL_BINT_ASM 1
#ifdef MCL_WASM32
	#define MCL_BINT_ASM 0
#endif
#ifndef MCL_BINT_ASM
	#define MCL_BINT_ASM 1
#endif

#if CYBOZU_HOST == CYBOZU_HOST_INTEL && MCL_SIZEOF_UNIT == 8 && MCL_BINT_ASM == 1 && (!defined(MCL_BINT_ASM_X64) || MCL_BINT_ASM_X64 == 1)
	#define MCL_BINT_ASM_X64 1

#if defined(_MSC_VER) && (_MSC_VER < 1920)
extern "C" unsigned __int64 mclb_udiv128(
   unsigned __int64 highDividend,
   unsigned __int64 lowDividend,
   unsigned __int64 divisor,
   unsigned __int64 *remainder
);
#endif

#else
	#define MCL_BINT_ASM_X64 0
#endif

namespace mcl { namespace bint {

typedef Unit (*u_ppp)(Unit*, const Unit*, const Unit*);
typedef Unit (*u_ppu)(Unit*, const Unit*, Unit);
typedef void (*void_pppp)(Unit*, const Unit*, const Unit*, const Unit*);
typedef void (*void_ppp)(Unit*, const Unit*, const Unit*);
typedef void (*void_pp)(Unit*, const Unit*);
enum CpuType {
	tAVX_BMI2_ADX = 1<<0,
	tAVX512_IFMA = 1<<1
};
extern const uint32_t g_cpuType;
extern uint32_t initBint();

// show integer as little endian
template<class T>
inline void dump(const T *x, size_t n, const char *msg = "")
{
#ifdef MCL_STANDALONE
	(void)x;
	(void)n;
	(void)msg;
#else
	if (msg) printf("%s ", msg);
	for (size_t i = 0; i < n; i++) {
		T v = x[n - 1 - i];
		for (size_t j = 0; j < sizeof(T); j++) {
			printf("%02x", uint8_t(v >> (sizeof(T) - 1 - j) * 8));
		}
	}
	printf("\n");
#endif
}

/*
	[H:L] <= x * y
	@return L
*/
inline uint32_t mulUnit1(uint32_t *pH, uint32_t x, uint32_t y)
{
	uint64_t t = uint64_t(x) * y;
	*pH = uint32_t(t >> 32);
	return uint32_t(t);
}

/*
	q = [H:L] / y
	r = [H:L] % y
	return q
*/
inline uint32_t divUnit1(uint32_t *pr, uint32_t H, uint32_t L, uint32_t y)
{
	assert(H < y);
	uint64_t t = (uint64_t(H) << 32) | L;
	uint32_t q = uint32_t(t / y);
	*pr = uint32_t(t % y);
	return q;
}

#if MCL_SIZEOF_UNIT == 8

#if !defined(_MSC_VER) || defined(__INTEL_COMPILER) || defined(__clang__)
typedef __attribute__((mode(TI))) unsigned int uint128_t;
#define MCL_DEFINED_UINT128_T
#endif

inline uint64_t mulUnit1(uint64_t *pH, uint64_t x, uint64_t y)
{
#ifdef MCL_DEFINED_UINT128_T
	uint128_t t = uint128_t(x) * y;
	*pH = uint64_t(t >> 64);
	return uint64_t(t);
#else
	return _umul128(x, y, pH);
#endif
}

inline uint64_t divUnit1(uint64_t *pr, uint64_t H, uint64_t L, uint64_t y)
{
	assert(H < y);
#ifdef MCL_DEFINED_UINT128_T
	uint128_t t = (uint128_t(H) << 64) | L;
	uint64_t q = uint64_t(t / y);
	*pr = uint64_t(t % y);
	return q;
#elif defined(_MSC_VER) && (_MSC_VER < 1920)
	return mclb_udiv128(H, L, y, pr);
#else
	return _udiv128(H, L, y, pr);
#endif
}

#endif // MCL_SIZEOF_UNIT == 8

// get function pointers
MCL_DLL_API u_ppp get_add(size_t n);
MCL_DLL_API u_ppp get_sub(size_t n);
MCL_DLL_API u_ppp get_subNF(size_t n);
MCL_DLL_API void_ppp get_addNF(size_t n);
MCL_DLL_API u_ppu get_mulUnit(size_t n);
MCL_DLL_API u_ppu get_mulUnitAdd(size_t n);
MCL_DLL_API void_ppp get_mul(size_t n);
MCL_DLL_API void_pp get_sqr(size_t n);

inline Unit addN(Unit *z, const Unit *x, const Unit *y, size_t n) { return get_add(n)(z, x, y); }
inline Unit subN(Unit *z, const Unit *x, const Unit *y, size_t n) { return get_sub(n)(z, x, y); }
inline void addNFN(Unit *z, const Unit *x, const Unit *y, size_t n) { return get_addNF(n)(z, x, y); }
inline Unit subNFN(Unit *z, const Unit *x, const Unit *y, size_t n) { return get_subNF(n)(z, x, y); }
inline Unit mulUnitN(Unit *z, const Unit *x, Unit y, size_t n) { return get_mulUnit(n)(z, x, y); }
inline Unit mulUnitAddN(Unit *z, const Unit *x, Unit y, size_t n) { return get_mulUnitAdd(n)(z, x, y); }
// z[n * 2] = x[n] * y[n]
inline void mulN(Unit *z, const Unit *x, const Unit *y, size_t n) { return get_mul(n)(z, x, y); }
// y[n * 2] = x[n] * x[n]
inline void sqrN(Unit *y, const Unit *x, size_t n) { return get_sqr(n)(y, x); }

// z[N] = x[N] + y[N] and return CF(0 or 1)
template<size_t N>Unit addT(Unit *z, const Unit *x, const Unit *y);
// z[N] = x[N] - y[N] and return CF(0 or 1)
template<size_t N, typename T>Unit subT(Unit *z, const T *x, const Unit *y);
// z[N] = x[N] + y[N]. assume x, y are Not Full bit
template<size_t N>void addNFT(Unit *z, const Unit *x, const Unit *y);
// z[N] = x[N] - y[N] and return CF(0 or 1). assume x, y are Not Full bit
template<size_t N>Unit subNFT(Unit *z, const Unit *x, const Unit *y);
// [ret:z[N]] = x[N] * y
template<size_t N, typename T>Unit mulUnitT(T *z, const Unit *x, Unit y);
// [ret:z[N]] = z[N] + x[N] * y
template<size_t N, typename T>Unit mulUnitAddT(T *z, const Unit *x, Unit y);
// z[2N] = x[N] * y[N]
template<size_t N>void mulT(Unit *pz, const Unit *px, const Unit *py);
// y[2N] = x[N] * x[N]
template<size_t N>void sqrT(Unit *py, const Unit *px);

#if MCL_BINT_ASM == 1
template<size_t N>Unit addT(Unit *z, const Unit *x, const Unit *y) { return addN(z, x, y, N); }
template<size_t N, typename T>Unit subT(Unit *z, const T *x, const Unit *y) { return subN(z, x, y, N); }
template<size_t N>void addNFT(Unit *z, const Unit *x, const Unit *y) { return addNFN(z, x, y, N); }
template<size_t N>Unit subNFT(Unit *z, const Unit *x, const Unit *y) { return subNFN(z, x, y, N); }
template<size_t N, typename T>Unit mulUnitT(T *z, const Unit *x, Unit y) { return mulUnitN(z, x, y, N); }
template<size_t N, typename T>Unit mulUnitAddT(T *z, const Unit *x, Unit y) { return mulUnitAddN(z, x, y, N); }
template<size_t N>void mulT(Unit *pz, const Unit *px, const Unit *py) { return mulN(pz, px, py, N); }
template<size_t N>void sqrT(Unit *py, const Unit *px) { return sqrN(py, px, N); }
#endif

// no restriction of xn
inline Unit mulUnitNany(Unit *z, const Unit *x, Unit y, size_t xn)
{
	Unit H = 0;
	for (size_t i = 0; i < xn; i++) {
		Unit t = H;
		Unit L = mulUnit1(&H, x[i], y);
		z[i] = t + L;
		if (z[i] < t) {
			H++;
		}
	}
	return H;
}

// z[xn * yn] = x[xn] * y[ym]
MCL_DLL_API void mulNM(Unit *z, const Unit *x, size_t xn, const Unit *y, size_t yn);

// explicit specialization of template functions and external asm functions
//#include "bint_proto.hpp"

template<size_t N, typename T, typename U>
void copyT(T *y, const U *x)
{
	for (size_t i = 0; i < N; i++) y[i] = T(x[i]);
}

// y[n] = x[n]
template<typename T, typename U>
void copyN(T *y, const U *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = T(x[i]);
}

template<size_t N, typename T>
void clearT(T *x)
{
	for (size_t i = 0; i < N; i++) x[i] = 0;
}

// x[n] = 0
template<typename T>
void clearN(T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) x[i] = 0;
}

// return true if x[] == 0
template<size_t N, typename T>
bool isZeroT(const T *x)
{
	for (size_t i = 0; i < N; i++) if (x[i]) return false;
	return true;
}

template<typename T>
bool isZeroN(const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) if (x[i]) return false;
	return true;
}

// return the real size of x
// return 1 if x[n] == 0
template<typename T>
size_t getRealSize(const T *x, size_t n)
{
	while (n > 0) {
		if (x[n - 1]) break;
		n--;
	}
	return n > 0 ? n : 1;
}

template<size_t N, typename T>
int cmpT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x != y) return x > y ? 1 : -1;
	}
	return 0;
}

// true if x[N] == y[N]
template<size_t N, typename T>
bool cmpEqT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[N] >= y[N]
template<size_t N, typename T>
bool cmpGeT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[N] > y[N]
template<size_t N, typename T>
bool cmpGtT(const T *px, const T *py)
{
	for (size_t i = 0; i < N; i++) {
		const T x = px[N - 1 - i];
		const T y = py[N - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[N] <= y[N]
template<size_t N, typename T>
bool cmpLeT(const T *px, const T *py)
{
	return !cmpGtT<N>(px, py);
}

// true if x[N] < y[N]
template<size_t N, typename T>
bool cmpLtT(const T *px, const T *py)
{
	return !cmpGeT<N>(px, py);
}

// true if x[] == y[]
template<typename T>
bool cmpEqN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (px[i] != py[i]) return false;
	}
	return true;
}

// true if x[n] >= y[n]
template<typename T>
bool cmpGeN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return true;
}

// true if x[n] > y[n]
template<typename T>
bool cmpGtN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x > y) return true;
		if (x < y) return false;
	}
	return false;
}

// true if x[n] <= y[n]
template<typename T>
bool cmpLeN(const T *px, const T *py, size_t n)
{
	return !cmpGtN(px, py, n);
}

// true if x[n] < y[n]
template<typename T>
bool cmpLtN(const T *px, const T *py, size_t n)
{
	return !cmpGeN(px, py, n);
}

template<typename T>
int cmpN(const T *px, const T *py, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const T x = px[n - 1 - i];
		const T y = py[n - 1 - i];
		if (x != y) return x > y ? 1 : -1;
	}
	return 0;
}

// [return:z[N]] = x[N] << bit
// 0 < bit < UnitBitSize
template<size_t N>
Unit shlT(Unit *pz, const Unit *px, Unit bit)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[N - 1];
	Unit keep = prev;
	for (size_t i = N - 1; i > 0; i--) {
		Unit t = px[i - 1];
		pz[i] = (prev << bit) | (t >> bitRev);
		prev = t;
	}
	pz[0] = prev << bit;
	return keep >> bitRev;
}

// z[N] = x[N] >> bit
// 0 < bit < UnitBitSize
template<size_t N>
void shrT(Unit *pz, const Unit *px, size_t bit)
{
	assert(0 < bit && bit < UnitBitSize);
	size_t bitRev = UnitBitSize - bit;
	Unit prev = px[0];
	for (size_t i = 1; i < N; i++) {
		Unit t = px[i];
		pz[i - 1] = (prev >> bit) | (t << bitRev);
		prev = t;
	}
	pz[N - 1] = prev >> bit;
}

// [return:z[N]] = x[N] << y
// 0 < y < UnitBitSize
MCL_DLL_API Unit shlN(Unit *pz, const Unit *px, Unit bit, size_t n);

// z[n] = x[n] >> bit
// 0 < bit < UnitBitSize
MCL_DLL_API void shrN(Unit *pz, const Unit *px, size_t bit, size_t n);

/*
	generic version
	y[yn] = x[xn] << bit
	yn = xn + roundUp(bit, UnitBitSize)
	accept y == x
	return yn
*/
MCL_DLL_API size_t shiftLeft(Unit *y, const Unit *x, size_t bit, size_t xn);

/*
	generic version
	y[yn] = x[xn] >> bit
	yn = xn - bit / UnitBitSize
	return yn
*/
MCL_DLL_API size_t shiftRight(Unit *y, const Unit *x, size_t bit, size_t xn);

// [return:y[n]] += x
MCL_DLL_API Unit addUnit(Unit *y, size_t n, Unit x);

// y[n] -= x, return CF
MCL_DLL_API Unit subUnit(Unit *y, size_t n, Unit x);

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
MCL_DLL_API Unit divUnit(Unit *q, const Unit *x, size_t n, Unit y);

/*
	q[] = x[] / y
	@retval r = x[] % y
*/
MCL_DLL_API Unit modUnit(const Unit *x, size_t n, Unit y);

/*
	y must be UnitBitSize * N bit
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] if q != NULL
	return new xn
*/
MCL_DLL_API size_t divFullBit(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

/*
	assume xn <= yn
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] if q != NULL
	assume(n >= 2);
	return new xn (1 if modulo is zero) if computed else 0
*/
MCL_DLL_API Unit divSmall(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

/*
	x[xn] %= y[yn]
	q[qn] = x[xn] / y[yn] ; qn == xn - yn + 1 if xn >= yn else 1
	allow q == 0
	return new xn
	@note x[new xn:xn] may not be cleared
*/
MCL_DLL_API size_t div(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y, size_t yn);

MCL_DLL_API void mod_SECP256K1(Unit *z, const Unit *x, const Unit *p);
MCL_DLL_API void mul_SECP256K1(Unit *z, const Unit *x, const Unit *y, const Unit *p);
MCL_DLL_API void sqr_SECP256K1(Unit *y, const Unit *x, const Unit *p);

// x &= (1 << bitSize) - 1
MCL_DLL_API void maskN(Unit *x, size_t n, size_t bitSize);

// ppLow = Unit(p)
inline Unit getMontgomeryCoeff(Unit pLow, size_t bitSize = sizeof(Unit) * 8)
{
	Unit pp = 0;
	Unit t = 0;
	Unit x = 1;
	for (size_t i = 0; i < bitSize; i++) {
		if ((t & 1) == 0) {
			t += pLow;
			pp += x;
		}
		t >>= 1;
		x <<= 1;
	}
	return pp;
}

struct SmallModP {
	static const size_t d = 16; // d = 26 if use double in approx
	static const size_t MAX_MUL_N = 1; // not used because mulSmallUnit is call at first.
	static const size_t maxE_ = d - 2;
	const Unit *p_;
	Unit tbl_[MAX_MUL_N][MCL_MAX_UNIT_SIZE+1];
	size_t n_;
	size_t l_;
	uint32_t p0_;

	SmallModP()
		: n_(0)
		, l_(0)
		, p0_(0)
	{
	}
	// p must not be temporary.
	void init(const Unit *p, size_t n)
	{
		p_ = p;
		n_ = n;
		l_ = mcl::fp::getBitSize(p, n);
		Unit *t = (Unit*)CYBOZU_ALLOCA((n_+1)*sizeof(Unit));
		mcl::bint::clearN(t, n_+1);
		size_t pos = d + l_ - 1;
		{
			size_t q = pos / MCL_UNIT_BIT_SIZE;
			size_t r = pos % MCL_UNIT_BIT_SIZE;
			t[q] = Unit(1) << r;
		}
		// p0 = 2**(d+l-1)/p
		Unit q[2];
		mcl::bint::div(q, 2, t, n_+1, p, n_);
		assert(q[1] == 0);
		p0_ = uint32_t(q[0]);
		for (size_t i = 0; i < MAX_MUL_N; i++) {
			tbl_[i][n_] = mcl::bint::mulUnitN(tbl_[i], p_, Unit(i+1), n_); // 1~MAX_MUL_N
		}
	}
	Unit approx(Unit x0, size_t a) const
	{
//		uint64_t t = uint64_t(double(x0) * double(p0_)); // for d = 26
		uint32_t t = uint32_t(x0 * p0_);
		return Unit(t >> (2 * d + l_ - 1 - a));
	}
	// x[xn] %= p
	// the effective range of return value is [0, n_)
	bool quot(Unit *pQ, const Unit *x, size_t xn) const
	{
		size_t a = mcl::fp::getBitSize(x, xn);
		if (a < l_) {
			*pQ = 0;
			return true;
		}
		size_t e = a - l_ + 1;
		if (e > maxE_) return false;
		Unit x0 = mcl::fp::getUnitAt(x, xn, a - d);
		*pQ = approx(x0, a);
		return true;
	}
	// return false if x[0, xn) is large
	bool mod(Unit *z, const Unit *x, size_t xn) const
	{
		assert(xn <= n_ + 1);
		Unit Q;
		if (!quot(&Q, x, xn)) return false;
		if (Q == 0) {
			mcl::bint::copyN(z, x, n_);
			return true;
		}
		Unit *t = (Unit*)CYBOZU_ALLOCA((n_+1)*sizeof(Unit));
		const Unit *pQ = 0;
		if (Q <= MAX_MUL_N) {
			assert(Q > 0);
			pQ = tbl_[Q-1];
		} else {
			t[n_] = mcl::bint::mulUnitN(t, p_, Q, n_);
			pQ = t;
		}
		bool b = mcl::bint::subN(t, x, pQ, xn);
		assert(!b); (void)b;
		if (mcl::bint::cmpGeN(t, tbl_[0], xn)) { // tbl_[0] == p and tbl_[n_] = 0
			mcl::bint::subN(z, t, p_, n_);
		} else {
			mcl::bint::copyN(z, t, n_);
		}
		return true;
	}
#if 1
	// return false if x[0, xn) is large
	template<size_t N>
	bool modT(Unit z[N], const Unit *x, size_t xn) const
	{
		assert(xn <= N + 1);
		Unit Q;
		if (!quot(&Q, x, xn)) return false;
		if (Q == 0) {
			mcl::bint::copyT<N>(z, x);
			return true;
		}
		Unit t[N+1];
		const Unit *pQ = 0;
		if (Q <= MAX_MUL_N) {
			pQ = tbl_[Q-1];
		} else {
			t[N] = mcl::bint::mulUnitT<N>(t, p_, Q);
			pQ = t;
		}
		bool b = mcl::bint::subT<N+1>(t, x, pQ);
		assert(!b); (void)b;
		if (mcl::bint::cmpGeT<N+1>(t, tbl_[0])) {
			mcl::bint::subT<N>(z, t, p_);
		} else {
			mcl::bint::copyT<N>(z, t);
		}
		return true;
	}
#endif
	template<size_t N>
	static bool mulUnit(const SmallModP& smp, Unit z[N], const Unit x[N], Unit y)
	{
		Unit xy[N+1];
		xy[N] = mulUnitT<N>(xy, x, y);
		return smp.modT<N>(z, xy, N+1);
//		return smp.mod(z, xy, N+1);
	}
};

} } // mcl::bint

