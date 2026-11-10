#pragma once
#include <assert.h>
#include <string.h>
#include <new> // placement new of the per-thread work of mulVecCorePar
#if defined(__linux__)
#include <sys/mman.h> // madvise(MADV_HUGEPAGE) of mallocLarge
#endif
#ifdef _MSC_VER
	#include <intrin.h> // _mm_prefetch, __prefetch
#endif

namespace mcl {

template<class Ec> struct GLV1T;

namespace ec {

inline size_t ilog2(size_t n)
{
	if (n == 0) return 0;
	return cybozu::bsr(n) + 1;
}

// The number of ADD for n-elements with bucket size b
inline size_t glvCost(size_t n, size_t b)
{
	return (n + (size_t(1)<<(b+1))-1)/b;
}
// approximate value such that argmin { b : glvCost(n, b) }
inline size_t estimateBucketSize(size_t n)
{
	if (n <= 16) return 2;
	size_t log2n = ilog2(n);
	return log2n - ilog2(log2n);
}

/*
	First, get approximate value x and compute glvCost of x-1 and x+1,
	and return the minimum value.
*/
inline size_t glvGetTheoreticBucketSize(size_t n)
{
	size_t x = estimateBucketSize(n);
	size_t vm1 = x > 1 ? glvCost(n, x-1) : n;
	size_t v0 = glvCost(n, x);
	size_t vp1 = glvCost(n, x+1);
	if (vm1 <= v0) return x-1;
	if (vp1 < v0) return x+1;
	return x;
}

#ifndef MCL_MSM_MAX_TBL_BYTES
	// the max byte size of the bucket table 2^(b-1) * sizeof(G) of mulVecCore (the generic path) : b <= 16 for G1 (144 bytes)
	// the cost model (not the cache) selects b <= 13 for n <= 2^18 split scalars and b = 16 for n >= 2^19 on Xeon w9-3495X, i9-13900H and Apple M4 Pro,
	// so the bound is loose for the generic path. The AVX-512 kernel passes its own bound (see getBucketSizeAffM in src/msm_avx.cpp).
	#define MCL_MSM_MAX_TBL_BYTES (size_t(8) << 20)
#endif
#ifndef MCL_MSM_REDUCE_MIN_B
	// use the batched bucket reduction (mulVecReduceTableBatch) if the number of the buckets of a window >= MCL_MSM_REDUCE_MIN_B
	// (the chains of the batch affine addition share one inversion per 2 M pairs, so the batch is slower for a small table :
	// 1.1-1.7x faster than the Jacobi running sums at B = 128, 1.2-2.2x at 256, 1.4-2.8x at 512 on Xeon w9-3495X, see memo 2026-11-05)
	#define MCL_MSM_REDUCE_MIN_B 128
#endif
#ifndef MCL_MSM_REDUCE_MAX_M
	// the max number of the chains of the batched bucket reduction (see msmReduceChainN)
	#define MCL_MSM_REDUCE_MAX_M 256
#endif

/*
	the number of the chains of the batched bucket reduction (mulVecReduceTableBatch) for B buckets (a power of 2) :
	a larger M makes the Jacobi combination of the chains (about 2000 clk per chain) expensive
	and a smaller M makes the inversion shared by 2 M pairs expensive.
	the best M measured on Xeon w9-3495X (BLS12-381 / BN254, the AVX-512 kernel and the generic one, see memo 2026-11-05) :
	16 for B <= 256, 32 for B = 512, B / 32 (in [32, MCL_MSM_REDUCE_MAX_M]) for B >= 1024, and the neighbors are within 5-15%
*/
inline size_t msmReduceChainN(size_t B)
{
	size_t M = B / 32;
	if (M < 32) M = (B >= 512) ? 32 : 16;
	if (M > MCL_MSM_REDUCE_MAX_M) M = MCL_MSM_REDUCE_MAX_M;
	return M;
}

/*
	cost model of the bucket method (mulVecCore) for n (split) scalars of maxBitSize bits with the window size b :
	the number of windows winN = ceil(maxBitSize / b), B = 2^(b-1) buckets (signed digits), and per window
	  (n - #nonempty buckets) bucket additions (cost 1 each) + B reductions (cost r each : sum += tbl[k], win += sum)
	  + a fixed cost c0 (doublings, the sort and the inversions of the batch affine addition, etc.)
	The weights are in units of 1/64 of a bucket addition and depend on the mode (the generic Jacobian addition,
	the batch affine addition, the SIMD kernel), not on the curve (the ratios of the field operations are the same).
	The expected number of nonempty buckets is B (1 - (1 - 1/B)^n).
	The batch affine addition reduces the buckets by the chains of the kernel (mulVecReduceTableBatch) if B >= MCL_MSM_REDUCE_MIN_B,
	which is cheaper than the Jacobi running sums : its cost is B r2 + M m2 (M = msmReduceChainN(B) chains, m2 = the fixed cost of a chain :
	the conversions to Jacobi and the Jacobi additions of the combination) instead of B r.
	The weights are fitted by misc/fit_msm.py (r, c0) and misc/fit_msm_reduce.py (r2, m2, c0 with r fixed)
	on the sweep of b by misc/msm_sweep.cpp (see memo 2026-11-04 and 2026-11-05).
*/
struct MsmCostParam {
	int32_t r;
	int32_t c0;
	int32_t r2; // the reduction of a bucket by the batched reduction (B >= MCL_MSM_REDUCE_MIN_B), r if 0
	int32_t m2; // the fixed cost of a chain of the batched reduction
};
inline uint64_t glvCostModel(size_t n, size_t b, size_t maxBitSize, const MsmCostParam& prm)
{
	const uint64_t winN = (maxBitSize + b - 1) / b;
	const uint64_t B = uint64_t(1) << (b - 1);
	const bool batchReduce = B >= MCL_MSM_REDUCE_MIN_B && prm.r2;
	const int32_t r = batchReduce ? prm.r2 : prm.r;
	const int64_t chainCost = batchReduce ? int64_t(msmReduceChainN(B)) * prm.m2 : 0;
	uint64_t adds;
	if (n >= 16 * B) {
		adds = n - B; // (1 - 1/B)^n < e^-16
	} else {
		// p = (1 - 1/B)^n in Q32 fixed point
		uint64_t base = (uint64_t(1) << 32) - ((uint64_t(1) << 32) / B);
		uint64_t p = uint64_t(1) << 32;
		for (size_t e = n; e > 0; e >>= 1) {
			if (e & 1) p = (p * base) >> 32;
			base = (base * base) >> 32;
		}
		const uint64_t nonempty = B - ((B * p) >> 32);
		adds = n - nonempty;
	}
	int64_t cost = int64_t(adds) * 64 + int64_t(B) * r + chainCost + prm.c0;
	if (cost < 0) cost = 0;
	return winN * uint64_t(cost);
}
/*
	argmin_b glvCostModel for b in [2, bMax] where 2^(bMax-1) * pointSize <= maxTblBytes (bMax <= 16)
	pointSize : sizeof(G) of the bucket table
*/
inline size_t glvGetBucketSizeByCost(size_t n, size_t maxBitSize, size_t pointSize, const MsmCostParam& prm, size_t maxTblBytes = MCL_MSM_MAX_TBL_BYTES)
{
	size_t bMax = 2;
	while (bMax < 16 && (size_t(1) << bMax) * pointSize <= maxTblBytes) bMax++;
	size_t best = 2;
	uint64_t bestCost = uint64_t(-1);
	for (size_t b = 2; b <= bMax; b++) {
		const uint64_t c = glvCostModel(n, b, maxBitSize, prm);
		if (c < bestCost) {
			bestCost = c;
			best = b;
		}
	}
	return best;
}
/*
	the weights fitted on Xeon w9-3495X (BLS12-381 and BN254 G1 together, n <= 2^19 split scalars, misc/fit_msm.py)
	and checked on i9-13900H and Apple M4 Pro : the model is within 6% of the measured best for n in [2^7, 2^18] (test/glv_test.cpp).
	r = 3.5 puts the crossing of b = 13 and b = 16 (cost(13) - cost(16) = 2n - 221184 (r - 1) for 128-bit scalars) between 2^18 and 2^19
	as measured on the three machines (b = 16 is 5-20% faster for n >= 2^19 and 7-8% slower at 2^18).
*/
// the generic Jacobian mixed addition : r = 3.5, c0 = -12.4 (no batched reduction)
inline const MsmCostParam& msmCostParamGeneric() { static const MsmCostParam prm = { 224, -791, 0, 0 }; return prm; }
/*
	the batch affine addition : r = 3.5, c0 = 12.2, r2 = 2.2, m2 = 5.7 (refitted on 2026-11-05 with the batched reduction, Xeon w9-3495X :
	the model is within 0.8% (BLS12-381) / 3.6% (BN254) of the measured best for n in [2^7, 2^19] split scalars, and selects b = 16 from 2^18)
*/
inline const MsmCostParam& msmCostParamBatch() { static const MsmCostParam prm = { 224, 781, 141, 367 }; return prm; }

#ifndef MCL_GLV_ONLY_FUNC

#ifndef MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC
	// use (1 << b) * sizeof(G) bytes stack + alpha if n <= MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC (otherwise malloc)
	// b = glvGetBucketSizeByCost(n, ...) <= 9 for n <= 1024 : at most 72KiB (G1) or 144KiB (G2)
	// you can decrease this value but this algorithm is slow if n < 256
	#define MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC 1024
#endif
#ifndef MCL_MSM_MAX_STACK_TBL_BYTES
	// the max byte size of the bucket table (1 << b) * sizeof(G) on the stack
	// b of the cost model is at most 9 for n <= 1024 but b of the argument of mulVec may be large (b = 16 : 9.4MiB for G1),
	// then malloc is tried first and b is reduced if it fails
	#define MCL_MSM_MAX_STACK_TBL_BYTES (size_t(256) << 10)
#endif

/*
	Extract b bits from yVec[i] starting at the pos-th bit as a signed digit d:
	d = v + c where v is the b-bit value and c is the (pos-1)-th bit (the carry from the lower window),
	and d -= 2^b if the top bit of v is set (= the carry into the upper window),
	so |d| <= 2^(b-1) and tbl needs tblN = 2^(b-1) entries.
	(The lower pos bits are represented in [-2^(pos-1), 2^(pos-1)] by the lower windows, so
	the carry into this window is 1 iff the (pos-1)-th bit is set.)
	tbl[|d|-1] += sign(d) xVec[i]
	win (+)= tbl[0] + 2 tbl[1] + 3 tbl[2] + ... + tblN tbl[tblN-1]
	isTop : the top window has no carry out, so d = v + c in [0, 2^rem] is used as is
	(rem = the bit size of the window <= b) and the caller passes tblN = 2^rem.
*/
namespace local {

// msmSign, msmIdxMask and msmNone are defined in ec.hpp (used by ec::MsmKernel)

/*
	return (|d| - 1) | (d < 0 ? msmSign : 0), or msmNone if d = 0
	see mulVecUpdateTable for the signed digit d
*/
inline uint32_t getSignedDigit(const Unit *y, size_t yUnitSize, size_t pos, size_t b, bool isTop)
{
	const size_t full = size_t(1) << b;
	const Unit mask = Unit(full - 1);
	const size_t v = size_t(fp::getUnitAt(y, yUnitSize, pos) & mask);
	const size_t c = pos > 0 ? size_t(fp::getUnitAt(y, yUnitSize, pos - 1) & 1) : 0;
	if (isTop || v < full / 2) {
		const size_t d = v + c; // d <= 2^(b-1) (<= 2^rem if isTop)
		return d ? uint32_t(d - 1) : msmNone;
	} else {
		const size_t d = full - v - c; // d <= 2^(b-1)
		return d ? uint32_t(d - 1) | msmSign : msmNone;
	}
}

// win (+)= tbl[0] + 2 tbl[1] + 3 tbl[2] + ... + tblN tbl[tblN-1]
template<class G>
void mulVecReduceTable(G& win, const G *tbl, size_t tblN, bool first)
{
	G sum = tbl[tblN - 1];
	if (first) {
		win = sum;
	} else {
		win += sum;
	}
	for (size_t i = 1; i < tblN; i++) {
		sum += tbl[tblN - 1 - i];
		win += sum;
	}
}

} // mcl::ec::local

template<class G>
void mulVecUpdateTable(G& win, G *tbl, size_t tblN, size_t b, const G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop)
{
	for (size_t i = 0; i < tblN; i++) {
		tbl[i].clear();
	}
	for (size_t i = 0; i < n; i++) {
		const uint32_t d = local::getSignedDigit(yVec + next * i, yUnitSize, pos, b, isTop);
		if (d == local::msmNone) continue;
		const size_t k = d & local::msmIdxMask;
		assert(k < tblN);
		if (d & local::msmSign) {
			tbl[k] -= xVec[i];
		} else {
			tbl[k] += xVec[i];
		}
	}
	local::mulVecReduceTable(win, tbl, tblN, first);
}

/*
	batch affine addition for the bucket method (see mulVecUpdateTableBatch)
*/
#ifndef MCL_MSM_MIN_SPLIT_N
	// use the bucket method (mulVecGLVlarge) if the number of the split scalars (n * splitN) >= MCL_MSM_MIN_SPLIT_N, otherwise the NAF method (EcT::mulVecN)
	// the bucket method (b = 5) is faster than the NAF method from about 64 to 80 split scalars (x64, BLS12-381 / BN254 G1)
	#define MCL_MSM_MIN_SPLIT_N 80
#endif
#ifndef MCL_MSM_MIN_SPLIT_N_NO_BATCH
	// the same threshold for the group without the batch affine addition (GT = GroupMtoA<Fp12> : the bucket addition and the reduction are the same Fp12 mul),
	// the bucket method is faster than the NAF method from about 56 to 64 elements (224 to 256 split scalars with splitN = 4) on x64 (BLS12-381 / BN254 GT)
	#define MCL_MSM_MIN_SPLIT_N_NO_BATCH 256
#endif
#ifndef MCL_MSM_BATCH_MIN_N
	// use the batch affine addition if the number of (split) scalars >= MCL_MSM_BATCH_MIN_N (the generic kernel ; a SIMD kernel may have its own MsmKernel::batchMinN)
	// the batch affine addition is faster than the Jacobi mixed addition from about 115 (BLS12-381) to 190 (BN254, but the loss is 1% at 128) split scalars on x64 (the fixed cost of the inversions),
	// and from about 64 on wasm (the inversion is cheap)
	#define MCL_MSM_BATCH_MIN_N 128
#endif
#ifndef MCL_MSM_BATCH_CHUNK
	// the number of entries folded at once (the work array S has this number of points)
	#define MCL_MSM_BATCH_CHUNK 8192
#endif
#ifndef MCL_MSM_PAR_MIN_CHUNK
	// the min number of the (split) scalars of a point chunk of the parallel mulVec (mulVecCorePar ; the parallel-for of ec::setParallelFor)
	#define MCL_MSM_PAR_MIN_CHUNK 2048
#endif
#ifndef MCL_MSM_BATCH_SUB
	// the number of pairs sharing one inversion
	#define MCL_MSM_BATCH_SUB 512
#endif
#ifndef MCL_MSM_PREFETCH_DIST
	// the distance (in pairs) of the software prefetch of the points of addAffineBatch (0 : no prefetch)
	#if defined(__wasm__)
		// wasm has no prefetch instruction (__builtin_prefetch is a no-op)
		#define MCL_MSM_PREFETCH_DIST 0
	#else
		#define MCL_MSM_PREFETCH_DIST 16
	#endif
#endif
#ifndef MCL_MSM_PREFETCH_MIN_BYTES
	/*
		use the software prefetch if the byte size of the points (n * sizeof(G)) >= this value
		(the reads of the points at the level 0 are random ; on Apple M4 Pro (L2 16 MiB) the prefetch is neutral
		if the points are in the L2 and saves 11-15% from 2^17 points (BLS12-381 18 MiB, BN254 12 MiB), 2-5% at 2^16)
	*/
	#define MCL_MSM_PREFETCH_MIN_BYTES (6u << 20)
#endif
#ifndef MCL_CACHE_LINE_SIZE
	// the size of a cache line (used by the software prefetch ; Apple silicon has 128-byte lines)
	#if defined(__APPLE__) && defined(__aarch64__)
		#define MCL_CACHE_LINE_SIZE 128
	#else
		#define MCL_CACHE_LINE_SIZE 64
	#endif
#endif

namespace local {

/*
	malloc of a large buffer of mulVec (freed by free) :
	on Linux the buffer is 2 MiB aligned and madvise(MADV_HUGEPAGE) (effective if /sys/kernel/mm/transparent_hugepage/enabled is always or madvise),
	because the page faults of the first touch of a fresh mmap (a buffer over the mmap threshold of glibc is unmapped by free and mapped again by the next malloc)
	are the bottleneck of the parallel mulVec (2^20 points on 56 threads : 100 ms with 4 KiB pages, 75 ms with 2 MiB pages)
*/
inline void* mallocLarge(size_t size)
{
#if defined(__linux__) && defined(MADV_HUGEPAGE) && !defined(MCL_MSM_NO_HUGEPAGE)
	const size_t HUGE = size_t(2) << 20;
	if (size >= HUGE) {
		const size_t roundSize = (size + HUGE - 1) / HUGE * HUGE;
		void *p = 0;
		if (posix_memalign(&p, HUGE, roundSize) == 0) {
			madvise(p, roundSize, MADV_HUGEPAGE);
			return p;
		}
	}
#endif
	return malloc(size);
}

// the buffer of mallocLarge (freed by the destructor), p = 0 if it fails
struct LargeBuf {
	void *p;
	explicit LargeBuf(size_t size) : p(mallocLarge(size)) {}
	~LargeBuf() { free(p); }
private:
	LargeBuf(const LargeBuf&);
	void operator=(const LargeBuf&);
};

// prefetch the cache line of p for reading (PREFETCHT0 on x64, PRFM PLDL1KEEP on AArch64)
inline void prefetchRead(const void *p)
{
#if defined(__GNUC__) || defined(__clang__)
	__builtin_prefetch(p, 0, 3);
#elif defined(_MSC_VER) && (defined(_M_X64) || defined(_M_IX86))
	_mm_prefetch((const char*)p, _MM_HINT_T0);
#elif defined(_MSC_VER) && defined(_M_ARM64)
	__prefetch(p);
#else
	(void)p;
#endif
}

// prefetch the cache lines of the point base[i & msmIdxMask] (sizeof(G) bytes, not aligned to a cache line)
template<class G>
inline void prefetchPoint(const G *base, uint32_t i)
{
	if (i == msmNone) return;
	const size_t L = MCL_CACHE_LINE_SIZE;
	const uintptr_t p = (uintptr_t)&base[i & msmIdxMask];
	const uintptr_t last = (p + sizeof(G) - 1) & ~(L - 1);
	for (uintptr_t q = p & ~(L - 1); q <= last; q += L) prefetchRead((const void*)q);
}

/*
	R[j] = P(ia[j]) + P(ib[j]) for j in [0, m)
	where P(i) = (i & msmSign) ? -base[i & msmIdxMask] : base[i & msmIdxMask] and P(msmNone) = 0
	base[*] must be affine (z = 1) or zero (z = 0), then R[j] is affine or zero
	R may overlap base if &R[j] <= &base[ia[j] & msmIdxMask], &base[ib[j] & msmIdxMask] for all j
	(the inputs of the j-th pair are read before R[j] is written and R[0], R[1], ... are written in this order)
	work : Fp[3 * MCL_MSM_BATCH_SUB]
	cost : 5M + 1S + inv/MCL_MSM_BATCH_SUB per pair
	prefetch : software prefetch of the points MCL_MSM_PREFETCH_DIST pairs ahead (for a large base)
*/
template<bool prefetch, class G>
void addAffineBatch(G *R, const G *base, const uint32_t *ia, const uint32_t *ib, size_t m, typename G::Fp *work)
{
	typedef typename G::Fp F;
	const size_t SUB = MCL_MSM_BATCH_SUB;
	F *d = work; // the denominator of lambda, then its inverse
	F *num = work + SUB; // the numerator of lambda
	F *prod = work + 2 * SUB;
	uint8_t st[SUB]; // 0 : R = lambda formula, 1 : R = P(ia), 2 : R = P(ib), 3 : R = 0
	const F one(1);
	for (size_t j0 = 0; j0 < m; j0 += SUB) {
		const size_t mm = (m - j0 < SUB) ? m - j0 : SUB;
		// classify the pairs and compute d and num
		for (size_t j = 0; j < mm; j++) {
			/*
				software prefetch of the points of the pair j0 + j + MCL_MSM_PREFETCH_DIST
				(the reads of base at the level 0 are random and a large base exceeds the cache)
			*/
			if (prefetch && MCL_MSM_PREFETCH_DIST > 0 && j0 + j + MCL_MSM_PREFETCH_DIST < m) {
				prefetchPoint(base, ia[j0 + j + MCL_MSM_PREFETCH_DIST]);
				prefetchPoint(base, ib[j0 + j + MCL_MSM_PREFETCH_DIST]);
			}
			const uint32_t a = ia[j0 + j];
			const uint32_t bb = ib[j0 + j];
			if (bb == msmNone || base[bb & msmIdxMask].z.isZero()) {
				st[j] = 1;
				d[j] = one;
				continue;
			}
			if (a == msmNone || base[a & msmIdxMask].z.isZero()) {
				st[j] = 2;
				d[j] = one;
				continue;
			}
			const G& A = base[a & msmIdxMask];
			const G& B = base[bb & msmIdxMask];
			F::sub(d[j], B.x, A.x);
			F ya, yb;
			if (a & msmSign) F::neg(ya, A.y); else ya = A.y;
			if (bb & msmSign) F::neg(yb, B.y); else yb = B.y;
			if (!d[j].isZero()) {
				F::sub(num[j], yb, ya);
				st[j] = 0;
				continue;
			}
			if (ya == yb) {
				// doubling : lambda = (3x^2 + a) / (2y)
				F::mul2(d[j], ya);
				if (d[j].isZero()) {
					st[j] = 3; // the point of order 2
					d[j] = one;
					continue;
				}
				F t;
				F::sqr(t, A.x);
				F::mul2(num[j], t);
				num[j] += t;
				if (G::specialA_ != Zero) num[j] += G::a_;
				st[j] = 0;
			} else {
				st[j] = 3; // A = -B
				d[j] = one;
			}
		}
		mcl::local::invVecWork<false>(d, d, mm, prod); // d[j] = 1/d[j] (d[j] != 0)
		// compute R
		for (size_t j = 0; j < mm; j++) {
			const uint32_t a = ia[j0 + j];
			const uint32_t bb = ib[j0 + j];
			G& r = R[j0 + j];
			if (st[j] == 0) {
				const G& A = base[a & msmIdxMask];
				const G& B = base[bb & msmIdxMask];
				F lambda, x3, t;
				F::mul(lambda, num[j], d[j]);
				F::sqr(x3, lambda);
				x3 -= A.x;
				x3 -= B.x; // = lambda^2 - 2 A.x if doubling
				F::sub(t, A.x, x3);
				t *= lambda;
				if (a & msmSign) t += A.y; else t -= A.y; // y3 = lambda (x1 - x3) - y1
				r.x = x3;
				r.y = t;
				r.z = one;
				continue;
			}
			const uint32_t src = (st[j] == 1) ? a : (st[j] == 2) ? bb : msmNone;
			if (src == msmNone || base[src & msmIdxMask].z.isZero()) {
				r.clear();
				continue;
			}
			const G& A = base[src & msmIdxMask];
			if (src & msmSign) {
				F::neg(r.y, A.y);
			} else {
				r.y = A.y;
			}
			r.x = A.x;
			r.z = one;
		}
	}
}

struct MsmPart {
	uint32_t k; // bucket index
	uint32_t start; // the position of the first point
	uint32_t cnt; // the number of points
};

// tbl (+)= P(i) where P(i) = (i & msmSign) ? -base[i & msmIdxMask] : base[i & msmIdxMask]
template<class G>
void msmAddToBucket(G& tbl, const G *base, uint32_t i)
{
	const G& P = base[i & msmIdxMask];
	if (tbl.isZero()) {
		tbl = P;
		if (i & msmSign) G::neg(tbl, tbl);
	} else if (i & msmSign) {
		tbl -= P;
	} else {
		tbl += P;
	}
}

/*
	the generic kernel (ec::MsmKernel) of the batch affine addition :
	the layout of a point is G (affine or zero) and the additions are done by addAffineBatch and msmAddToBucket
*/
template<class G>
struct MsmGenericKernel {
	template<bool prefetch>
	static void addPairs(void *R, const void *base, const uint32_t *ia, const uint32_t *ib, size_t m, void *work)
	{
		addAffineBatch<prefetch>((G*)R, (const G*)base, ia, ib, m, (typename G::Fp*)work);
	}
	static void addToBucket(void *tbl, const void *base, uint32_t i)
	{
		msmAddToBucket(*(G*)tbl, (const G*)base, i);
	}
	// n : the number of the points of the base (the software prefetch is used if the base is large)
	static void set(ec::MsmKernel& kn, size_t n)
	{
		kn.pointSize = sizeof(G);
		kn.workSize = sizeof(typename G::Fp) * 3 * MCL_MSM_BATCH_SUB;
		kn.cvtBase = 0;
		kn.addPairs = (n * sizeof(G) >= MCL_MSM_PREFETCH_MIN_BYTES) ? addPairs<true> : addPairs<false>;
		kn.addToBucket = addToBucket;
		kn.getBucketSize = 0;
		kn.batchMinN = 0;
		kn.cvtBaseGLV = 0;
	}
};

// the threshold of the batch affine addition (the number of the (split) scalars) of the kernel (0 : the generic one)
inline size_t msmBatchMinN(const ec::MsmKernel *kernel)
{
	return (kernel && kernel->batchMinN) ? kernel->batchMinN : MCL_MSM_BATCH_MIN_N;
}

// work buffers for mulVecUpdateTableBatch
template<class G>
struct MsmBatchWork {
	static const size_t CHUNK = MCL_MSM_BATCH_CHUNK;
	ec::MsmKernel kn; // the kernel of the batch affine addition
	size_t chunk; // min(CHUNK, n) : the max number of the entries of idx processed at once (the fixed cost of the buffers is small for small n)
	size_t tblN; // the max number of the buckets of a window (2^b)
	size_t chainN; // the max number of the chains of the batched reduction (msmReduceChainN(tblN))
	uint32_t *D; // [n] (bucket | sign) of each scalar
	uint32_t *idx; // [n] the indexes of the scalars sorted by bucket
	uint32_t *off; // [tblN + 1] the offset of each bucket in idx
	uint32_t *ia; // [max(chunk, 2 chainN)] the pairs of the current level (or of a step of the reduction)
	uint32_t *ib; // [max(chunk, 2 chainN)]
	MsmPart *part[2]; // [chunk + 1] the parts (a bucket in the chunk) of the current and next level
	void *S; // [chunk * kn.pointSize] the work array of the points (64-byte aligned)
	void *work; // [kn.workSize] the work area of kn.addPairs (64-byte aligned)
	void *base; // [n * kn.pointSize] xVec converted by kn.cvtBase (0 if kn.cvtBase == 0)
	/*
		[(tblN + 4 chainN) * kn.pointSize] the bucket table of a window in the layout of the kernel (64-byte aligned),
		followed by the two state buffers (2 chainN points each) of the batched reduction
		(the base of addPairs is one array, so the table and the states are in the same array)
	*/
	void *tbl;
	uint8_t *filled; // [tblN] 1 if tbl[k] has a point
	uint32_t *pendK; // [pendMax] the buckets of the pending additions (a bucket split by a chunk boundary gets two or more points)
	G *pendQ; // [pendMax] the sums of the pending additions (Jacobi)
	size_t pendN;
	size_t pendMax; // the number of the chunk boundaries + 1
	mcl::Array<uint8_t> buf_;
	// kernel : the SIMD kernel (0 : the generic one), hasBase : the caller gives the points in the layout of the kernel (base is not allocated)
	bool init(size_t n, size_t tblN, const ec::MsmKernel *kernel, bool hasBase = false)
	{
		if (n >= msmIdxMask) return false;
		if (kernel) {
			kn = *kernel;
		} else {
			MsmGenericKernel<G>::set(kn, n);
		}
		this->tblN = tblN;
		chainN = msmReduceChainN(tblN);
		chunk = (n < CHUNK) ? n : CHUNK;
		pendMax = n / chunk + 2;
		pendN = 0;
		const size_t pairN = (chunk > 2 * chainN) ? chunk : 2 * chainN; // the size of ia and ib
		const size_t align = 64;
		const size_t sSize = (kn.pointSize * chunk + align - 1) / align * align;
		const size_t wSize = (kn.workSize + align - 1) / align * align;
		const bool allocBase = kn.cvtBase && !hasBase;
		const size_t bSize = allocBase ? (kn.pointSize * n + align - 1) / align * align : 0;
		const size_t tSize = (kn.pointSize * (tblN + 4 * chainN) + align - 1) / align * align;
		const size_t qSize = (sizeof(G) * pendMax + align - 1) / align * align;
		size_t size = align + sSize + wSize + bSize + tSize + qSize;
		size += sizeof(uint32_t) * (2 * n + (tblN + 1) + 2 * pairN + pendMax) + sizeof(MsmPart) * 2 * (chunk + 1) + tblN;
		if (!buf_.resize(size)) return false;
		char *p = (char*)(((uintptr_t)buf_.data() + align - 1) & ~(uintptr_t)(align - 1));
		S = p; p += sSize;
		work = p; p += wSize;
		base = allocBase ? p : 0; p += bSize;
		tbl = p; p += tSize;
		pendQ = (G*)p; p += qSize;
		D = (uint32_t*)p; p += sizeof(uint32_t) * n;
		idx = (uint32_t*)p; p += sizeof(uint32_t) * n;
		off = (uint32_t*)p; p += sizeof(uint32_t) * (tblN + 1);
		ia = (uint32_t*)p; p += sizeof(uint32_t) * pairN;
		ib = (uint32_t*)p; p += sizeof(uint32_t) * pairN;
		pendK = (uint32_t*)p; p += sizeof(uint32_t) * pendMax;
		part[0] = (MsmPart*)p; p += sizeof(MsmPart) * (chunk + 1);
		part[1] = (MsmPart*)p; p += sizeof(MsmPart) * (chunk + 1);
		filled = (uint8_t*)p;
		return true;
	}
	// the i-th point of tbl
	char *pt(size_t i) const { return (char*)tbl + i * kn.pointSize; }
	// clear the table of B buckets (the zero point is all-zero bytes in the layout of the kernel)
	void clearTbl(size_t B)
	{
		assert(B <= tblN);
		memset(tbl, 0, kn.pointSize * B);
		memset(filled, 0, B);
		pendN = 0;
	}
	/*
		tbl[k] (+)= src (a point in the layout of the kernel)
		the first point of a bucket is copied, the others (a bucket split by chunk boundaries) are added by the Jacobi addition
		and converted back by flushPending
	*/
	void setBucket(size_t k, const void *src)
	{
		char *dst = pt(k);
		if (!filled[k]) {
			memcpy(dst, src, kn.pointSize);
			filled[k] = 1;
			return;
		}
		G *Q;
		if (pendN > 0 && pendK[pendN - 1] == k) {
			// the bucket spans three or more chunks
			Q = &pendQ[pendN - 1];
		} else {
			assert(pendN < pendMax);
			pendK[pendN] = uint32_t(k);
			Q = &pendQ[pendN++];
			Q->clear();
			kn.addToBucket(Q, dst, 0);
		}
		kn.addToBucket(Q, src, 0);
	}
	// tbl[pendK[j]] = pendQ[j] (normalized at once)
	void flushPending()
	{
		if (pendN == 0) return;
		G::normalizeVec(pendQ, pendQ, pendN);
		for (size_t j = 0; j < pendN; j++) {
			char *dst = pt(pendK[j]);
			if (kn.cvtBase) {
				kn.cvtBase(dst, &pendQ[j], 1);
			} else {
				memcpy(dst, &pendQ[j], kn.pointSize);
			}
		}
		pendN = 0;
	}
};

// the batch affine addition is available only for EcT (not for GroupMtoA)
template<class G>
struct MsmBatch {
	static const bool enabled = false;
	struct Work {
		ec::MsmKernel kn;
		void *base;
		bool init(size_t, size_t, const ec::MsmKernel *, bool = false) { return false; }
	};
	static const ec::MsmKernel* getKernel() { return 0; }
	static bool isNormalizedVec(const G *, size_t) { return false; }
};
template<class Fp, class Fr>
struct MsmBatch<EcT<Fp, Fr> > {
	static const bool enabled = true;
	typedef MsmBatchWork<EcT<Fp, Fr> > Work;
	static const ec::MsmKernel* getKernel() { return EcT<Fp, Fr>::msmKernel; }
	// all the points are affine or zero
	static bool isNormalizedVec(const EcT<Fp, Fr> *xVec, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			if (!(xVec[i].z.isOne() || xVec[i].z.isZero())) return false;
		}
		return true;
	}
};

} // mcl::ec::local

/*
	the batched bucket reduction : win (+)= tbl[0] + 2 tbl[1] + ... + B tbl[B-1] (tbl = wk.tbl in the layout of the kernel, B = a power of 2)
	by M = msmReduceChainN(B) chains of the batch affine addition (2 additions of kn.addPairs per bucket instead of J+A and J+J of mulVecReduceTable).
	the buckets are split into M segments of L = B / M buckets. for the segment j = [jL, (j+1)L),
	  S_j = the running sum of the segment from the top (tbl[(j+1)L-1], then += tbl[(j+1)L-2], ...), W_j = the sum of the running sums,
	  U_j = S_j at the end (= the sum of the segment).
	then sum_k (k+1) tbl[k] = sum_j W_j + L sum_j j U_j (the running sum of the bucket k of the segment j is S_j + sum_{j' > j} U_j').
	each step advances all the chains by one call of kn.addPairs of 2 M pairs (W_j += S_j (old), S_j += tbl[i]) :
	all the pairs read the states before the step, so the states are double-buffered (wk.tbl[B' + 2 M (0 or 1) + j], B' = wk.tblN).
	the zero point, the doubling and A = -B are handled by the kernel.
	the combination (M conversions to Jacobi, 2 M Jacobi additions and log2(L) doublings) is cheap for M <= 256.
	about 3.7x (BLS12-381, the AVX-512 kernel), 2.3x (BN254, AVX-512), 1.6x (the generic kernel) faster than mulVecReduceTable for B = 4096.
*/
template<class G>
void mulVecReduceTableBatch(G& win, local::MsmBatchWork<G>& wk, size_t B, bool first)
{
	using namespace local;
	const ec::MsmKernel& kn = wk.kn;
	const size_t M = msmReduceChainN(B);
	assert(M <= wk.chainN && B >= 2 * M && (B & (B - 1)) == 0);
	const size_t L = B / M;
	const uint32_t st[2] = { uint32_t(wk.tblN), uint32_t(wk.tblN + 2 * M) }; // the state buffers : S_j = st + j, W_j = st + M + j
	uint32_t *ia = wk.ia;
	uint32_t *ib = wk.ib;
	int cur = 0;
	// init : S_j = tbl[(j+1)L - 1], W_j = 0
	for (size_t j = 0; j < M; j++) {
		ia[j] = uint32_t((j + 1) * L - 1);
		ib[j] = msmNone;
		ia[M + j] = msmNone;
		ib[M + j] = msmNone;
	}
	kn.addPairs(wk.pt(st[cur]), wk.tbl, ia, ib, 2 * M, wk.work);
	// steps : W_j += S_j (old), S_j += tbl[(j+1)L - 1 - t]
	for (size_t t = 1; t < L; t++) {
		const uint32_t s = st[cur];
		for (size_t j = 0; j < M; j++) {
			ia[j] = s + uint32_t(j);
			ib[j] = uint32_t((j + 1) * L - 1 - t);
			ia[M + j] = s + uint32_t(M + j);
			ib[M + j] = s + uint32_t(j);
		}
		kn.addPairs(wk.pt(st[1 - cur]), wk.tbl, ia, ib, 2 * M, wk.work);
		cur = 1 - cur;
	}
	// final : F_j = W_j + S_j -> the other buffer, U_j = S_j
	const uint32_t s = st[cur];
	for (size_t j = 0; j < M; j++) {
		ia[j] = s + uint32_t(M + j);
		ib[j] = s + uint32_t(j);
	}
	kn.addPairs(wk.pt(st[1 - cur]), wk.tbl, ia, ib, M, wk.work);
	const uint32_t f = st[1 - cur];
	// R = sum_{j >= 1} j U_j by the running sum from the top (V = U_{M-1}, R = V, V += U_j, R += V, ...)
	G V, R, T;
	V.clear();
	kn.addToBucket(&V, wk.tbl, s + uint32_t(M - 1));
	R = V;
	for (size_t j = M - 2; j >= 1; j--) {
		kn.addToBucket(&V, wk.tbl, s + uint32_t(j));
		R += V;
	}
	// T = sum_j F_j + L R
	T.clear();
	for (size_t j = 0; j < M; j++) {
		kn.addToBucket(&T, wk.tbl, f + uint32_t(j));
	}
	for (size_t i = 1; i < L; i *= 2) G::dbl(R, R);
	T += R;
	if (first) {
		win = T;
	} else {
		win += T;
	}
}

/*
	the batch affine version of mulVecUpdateTable
	xVec[i] must be affine (z = 1) or zero
	1. D[i] = (bucket, sign) of the digit of yVec[i], off[k] = the offset of the bucket k (counting sort)
	2. idx[off[k] ...] = the indexes of the scalars whose bucket is k (with the sign bit)
	3. for each chunk of wk.chunk (= min(MCL_MSM_BATCH_CHUNK, n)) entries of idx : fold the points of each bucket by a binary tree
	   level 0 : pairs of xVec[idx[]] -> S (a bucket with one point is the pair (idx, msmNone)), level >= 1 : pairs of S -> S (in place),
	   the folded point of a bucket is copied to wk.tbl[k] (in the layout of the kernel) by wk.setBucket
	   (a bucket split by the chunk boundary gets two or more points : they are added by the Jacobi addition and converted back by wk.flushPending)
	   all the additions of a level are done by addAffineBatch (sharing one inversion per MCL_MSM_BATCH_SUB pairs)
	4. win (+)= tbl[0] + 2 tbl[1] + ... by mulVecReduceTableBatch if tblN >= MCL_MSM_REDUCE_MIN_B,
	   otherwise by the running sums of the Jacobi addition (tbl[k] is affine or zero, so addJacobi uses the Q.z = 1 formula)
	The number of additions is the same as mulVecUpdateTable (n - the number of non-empty buckets)
	and the batches do not degenerate even if all scalars are equal.
	base : xVec in the layout of the kernel wk.kn (xVec itself for the generic kernel)
*/
template<class G>
void mulVecUpdateTableBatch(G& win, size_t tblN, size_t b, const void *base, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, local::MsmBatchWork<G>& wk)
{
	using namespace local;
	const size_t CHUNK = wk.chunk;
	const ec::MsmKernel& kn = wk.kn;
	const size_t ps = kn.pointSize;
	wk.clearTbl(tblN);
	uint32_t *off = wk.off;
	for (size_t k = 0; k <= tblN; k++) off[k] = 0;
	// off[k + 1] = the number of the scalars in the bucket k
	for (size_t i = 0; i < n; i++) {
		const uint32_t d = getSignedDigit(yVec + next * i, yUnitSize, pos, b, isTop);
		wk.D[i] = d;
		if (d == msmNone) continue;
		const size_t k = d & msmIdxMask;
		assert(k < tblN);
		off[k + 1]++;
	}
	for (size_t k = 0; k < tblN; k++) off[k + 1] += off[k];
	const size_t total = off[tblN];
	// scatter : idx[off[k] + j] = the j-th scalar of the bucket k
	// use off[k] as the write position, then restore it
	for (size_t i = 0; i < n; i++) {
		const uint32_t d = wk.D[i];
		if (d == msmNone) continue;
		const size_t k = d & msmIdxMask;
		wk.idx[off[k]++] = uint32_t(i) | (d & msmSign);
	}
	for (size_t k = tblN; k > 0; k--) off[k] = off[k - 1];
	off[0] = 0;
	// fold each chunk
	size_t k = 0; // the current bucket
	for (size_t e0 = 0; e0 < total; e0 += CHUNK) {
		const size_t e1 = (total - e0 < CHUNK) ? total : e0 + CHUNK;
		// level 0 : the parts of this chunk are read from xVec via idx and written to S
		MsmPart *cur = wk.part[0];
		size_t partN = 0;
		size_t m = 0; // the number of pairs
		size_t outPos = 0;
		while (k < tblN && off[k] < e1) {
			const size_t start = off[k] > e0 ? off[k] : e0;
			const size_t end = off[k + 1] < e1 ? off[k + 1] : e1;
			if (end > start) {
				const size_t cnt = end - start;
				for (size_t j = 0; j + 1 < cnt; j += 2) {
					wk.ia[m] = wk.idx[start + j];
					wk.ib[m] = wk.idx[start + j + 1];
					m++;
				}
				if (cnt & 1) {
					// a single point (cnt == 1) is copied (with its sign) to S by the kernel
					wk.ia[m] = wk.idx[end - 1];
					wk.ib[m] = msmNone;
					m++;
				}
				cur[partN].k = uint32_t(k);
				cur[partN].start = uint32_t(outPos);
				cur[partN].cnt = uint32_t((cnt + 1) / 2);
				partN++;
				outPos += (cnt + 1) / 2;
			}
			if (off[k + 1] <= e1) {
				k++;
			} else {
				break;
			}
		}
		if (m == 0) continue;
		kn.addPairs(wk.S, base, wk.ia, wk.ib, m, wk.work);
		// level >= 1 : fold S in place
		MsmPart *nxt = wk.part[1];
		while (partN > 0) {
			size_t nxtN = 0;
			m = 0;
			outPos = 0;
			for (size_t p = 0; p < partN; p++) {
				const size_t cnt = cur[p].cnt;
				const size_t start = cur[p].start;
				if (cnt == 1) {
					wk.setBucket(cur[p].k, (const char*)wk.S + ps * start);
					continue;
				}
				for (size_t j = 0; j + 1 < cnt; j += 2) {
					wk.ia[m] = uint32_t(start + j);
					wk.ib[m] = uint32_t(start + j + 1);
					m++;
				}
				if (cnt & 1) {
					wk.ia[m] = uint32_t(start + cnt - 1);
					wk.ib[m] = msmNone;
					m++;
				}
				nxt[nxtN].k = cur[p].k;
				nxt[nxtN].start = uint32_t(outPos);
				nxt[nxtN].cnt = uint32_t((cnt + 1) / 2);
				nxtN++;
				outPos += (cnt + 1) / 2;
			}
			if (m > 0) kn.addPairs(wk.S, wk.S, wk.ia, wk.ib, m, wk.work);
			MsmPart *t = cur; cur = nxt; nxt = t;
			partN = nxtN;
		}
	}
	wk.flushPending();
	if (tblN >= MCL_MSM_REDUCE_MIN_B) {
		mulVecReduceTableBatch(win, wk, tblN, first);
		return;
	}
	// the running sums of the Jacobi addition for a small table (see mulVecReduceTable ; tbl[k] is read by kn.addToBucket)
	G sum;
	sum.clear();
	for (size_t i = 0; i < tblN; i++) {
		kn.addToBucket(&sum, wk.tbl, uint32_t(tblN - 1 - i));
		if (i == 0 && first) {
			win = sum;
		} else {
			win += sum;
		}
	}
}

namespace local {

template<class G>
struct mulVecUpdateTableBatchT {
	template<class W>
	static void call(G&, size_t, size_t, const void *, const Unit *, size_t, size_t, size_t, size_t, bool, bool, W&) {}
};
template<class Fp, class Fr>
struct mulVecUpdateTableBatchT<EcT<Fp, Fr> > {
	typedef EcT<Fp, Fr> G;
	static void call(G& win, size_t tblN, size_t b, const void *base, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, MsmBatchWork<G>& wk)
	{
		mulVecUpdateTableBatch(win, tblN, b, base, yVec, yUnitSize, next, pos, n, first, isTop, wk);
	}
};

/*
	win = the sum of the window w of the bucket method (pos = b w ; w = winN - 1 is the top window of rem bits) of
	the n (split) scalars yVec and the points xVec (generic) or base (the batch affine addition ; the layout of wk->kn)
*/
template<class G>
void msmWindow(G& win, size_t w, size_t winN, size_t b, size_t rem, const G *xVec, const void *base, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, bool useBatch, typename MsmBatch<G>::Work *wk, G *tbl)
{
	const bool isTop = w == winN - 1;
	const size_t tblN = size_t(1) << (isTop ? rem : b - 1);
	const size_t pos = b * w;
	if (useBatch) {
		mulVecUpdateTableBatchT<G>::call(win, tblN, b, base, yVec, yUnitSize, next, pos, n, true, isTop, *wk);
	} else {
		mulVecUpdateTable(win, tbl, tblN, b, xVec, yVec, yUnitSize, next, pos, n, true, isTop);
	}
}

/*
	the number of the chunks C and the window size b (by the cost model for the n / C scalars of a chunk) of the parallel mulVec (see mulVecCorePar) :
	the C winN tasks of about (n / C + 2^b) additions each (the bucket additions and the reduction) are run in ceil(C winN / maxThreads) rounds,
	so C minimizes rounds (n / C + 2^b) among 1 <= C <= min(n / MCL_MSM_PAR_MIN_CHUNK, 4 maxThreads)
	(e.g. 2^17 scalars, 16 threads, 10 windows : C = 2 gives 20 tasks in 2 rounds, C = 3 gives 30 tasks in 2 rounds of smaller tasks)
*/
template<class G>
size_t msmParChunks(size_t n, size_t maxThreads, size_t& b, size_t bArg, size_t maxBitSize, bool tryBatch, const ec::MsmKernel *kernel, size_t batchMinN)
{
	size_t maxC = n / MCL_MSM_PAR_MIN_CHUNK;
	if (tryBatch && maxC > n / batchMinN) maxC = n / batchMinN;
	if (maxC > 4 * maxThreads) maxC = 4 * maxThreads;
	if (maxC < 1) maxC = 1;
	size_t bestC = 1;
	size_t bestB = 0;
	uint64_t bestCost = uint64_t(-1);
	for (size_t C = 1; C <= maxC; C++) {
		const size_t nc = (n + C - 1) / C;
		size_t bC;
		if (bArg) {
			bC = bArg;
		} else if (tryBatch && kernel && kernel->getBucketSize) {
			bC = kernel->getBucketSize(nc, maxBitSize, sizeof(G));
		} else {
			bC = glvGetBucketSizeByCost(nc, maxBitSize, sizeof(G), tryBatch ? msmCostParamBatch() : msmCostParamGeneric());
		}
		const size_t winN = (maxBitSize + bC - 1) / bC;
		const uint64_t rounds = (C * winN + maxThreads - 1) / maxThreads;
		const uint64_t cost = rounds * (nc + (size_t(1) << bC));
		if (cost < bestCost) {
			bestCost = cost;
			bestC = C;
			bestB = bC;
		}
	}
	b = bestB;
	return bestC;
}

/*
	the context of the parallel mulVec : the tasks are (chunk c, window w) with the index i = c winN + w
	(the windows of a chunk are consecutive, so the points of the chunk stay in the cache of the thread)
*/
template<class G>
struct MsmParCtx {
	typedef typename MsmBatch<G>::Work Work;
	// the work of a thread (allocated by the thread at its first task)
	struct ThreadWork {
		Work wk;
		mcl::Array<G> tbl; // the bucket table of the generic path
		bool ready;
		bool ok;
		ThreadWork() : ready(false), ok(false) {}
	};
	size_t n; // the number of the (split) scalars
	size_t C; // the number of the chunks
	size_t winN;
	size_t b;
	size_t rem;
	size_t tblN; // 2^b
	size_t yUnitSize;
	size_t next;
	G *xVec; // normalized in place if doNormalize
	bool doNormalize;
	const void *base; // the points in the layout of the kernel (0 : xVec)
	void *baseW; // the buffer of base converted by cvtBase (0 if base is given or the generic kernel)
	size_t pointSize;
	const Unit *yVec;
	bool useBatch;
	const ec::MsmKernel *kernel;
	G *res; // [C winN] the sum of each task
	ThreadWork *works; // [workN]
	size_t workN;
	uint8_t *ok; // [C winN] 1 if the task is done
	size_t chunkBegin(size_t c) const { return n * c / C; }
	// normalize and convert the chunks of the points
	static void prepareTask(size_t begin, size_t end, size_t, void *arg)
	{
		MsmParCtx& ctx = *(MsmParCtx*)arg;
		assert(begin < end && end <= ctx.C);
		if (begin >= end || end > ctx.C) return; // the parallel-for violates the contract (the chunks are left unprepared, then the windows see non-normalized points : ok = 0 is not set here, see windowTask)
		for (size_t c = begin; c < end; c++) {
			const size_t off = ctx.chunkBegin(c);
			const size_t nc = ctx.chunkBegin(c + 1) - off;
			if (ctx.doNormalize) G::normalizeVec(ctx.xVec + off, ctx.xVec + off, nc);
			if (ctx.baseW) ctx.kernel->cvtBase((char*)ctx.baseW + off * ctx.pointSize, ctx.xVec + off, nc);
		}
	}
	static void windowTask(size_t begin, size_t end, size_t tid, void *arg)
	{
		MsmParCtx& ctx = *(MsmParCtx*)arg;
		const size_t numTasks = ctx.C * ctx.winN;
		assert(tid < ctx.workN && begin < end && end <= numTasks);
		if (tid >= ctx.workN || begin >= end || end > numTasks) return; // the parallel-for violates the contract : the tasks are left undone (ok = 0, then the caller runs the sequential one)
		ThreadWork& tw = ctx.works[tid];
		if (!tw.ready) {
			tw.ready = true;
			const size_t nMax = (ctx.n + ctx.C - 1) / ctx.C;
			if (ctx.useBatch) {
				tw.ok = tw.wk.init(nMax, ctx.tblN, ctx.kernel, true);
			} else {
				tw.ok = tw.tbl.resize(ctx.tblN);
			}
		}
		if (!tw.ok) return;
		for (size_t i = begin; i < end; i++) {
			const size_t c = i / ctx.winN;
			const size_t w = i % ctx.winN;
			const size_t off = ctx.chunkBegin(c);
			const size_t nc = ctx.chunkBegin(c + 1) - off;
			const void *base = ctx.base ? (const char*)ctx.base + off * ctx.pointSize : 0;
			const G *xVec = ctx.xVec ? ctx.xVec + off : 0; // xVec = 0 if the caller gives base
			msmWindow(ctx.res[i], w, ctx.winN, ctx.b, ctx.rem, xVec, base, ctx.yVec + off * ctx.next, ctx.yUnitSize, ctx.next, nc, ctx.useBatch, &tw.wk, tw.tbl.data());
			ctx.ok[i] = 1;
		}
	}
};

/*
	the parallel version of mulVecCore by the parallel-for par (ec::ParallelFor) of par.maxThreads threads :
	the points are split into C chunks and the (chunk, window) pairs are the tasks (each thread has its own bucket table and work),
	then z = sum_w 2^(b w) sum_c res[c][w].
	return n if done, 0 if not (the memory allocation fails or the tasks are too few : then the caller runs the sequential one)
*/
template<class G>
size_t mulVecCorePar(G& z, G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, size_t bArg, bool doNormalize, size_t maxBitSize, const void *baseArg, const ec::MsmKernel *kernel, bool tryBatch, size_t batchMinN, const ec::ParallelFor& par)
{
	typedef MsmParCtx<G> Ctx;
	const size_t maxThreads = par.maxThreads;
	typedef typename Ctx::ThreadWork ThreadWork;
	Ctx ctx;
	ctx.b = 0;
	ctx.C = msmParChunks<G>(n, maxThreads, ctx.b, bArg, maxBitSize, tryBatch, kernel, batchMinN);
	ctx.winN = (maxBitSize + ctx.b - 1) / ctx.b;
	ctx.rem = maxBitSize - ctx.b * (ctx.winN - 1);
	ctx.tblN = size_t(1) << ctx.b;
	const size_t numTasks = ctx.C * ctx.winN;
	if (numTasks < 2) return 0;
	ctx.n = n;
	ctx.yUnitSize = yUnitSize;
	ctx.next = next;
	ctx.xVec = xVec;
	ctx.doNormalize = doNormalize;
	ctx.yVec = yVec;
	ctx.useBatch = tryBatch;
	ctx.kernel = kernel;
	ctx.pointSize = (tryBatch && kernel) ? kernel->pointSize : sizeof(G);
	const bool needCvt = tryBatch && kernel && kernel->cvtBase && baseArg == 0;
	const size_t align = 64;
	const size_t baseBytes = needCvt ? (ctx.pointSize * n + align - 1) / align * align : 0;
	const size_t resBytes = (sizeof(G) * numTasks + align - 1) / align * align;
	ctx.workN = maxThreads < numTasks ? maxThreads : numTasks;
	const size_t workBytes = (sizeof(ThreadWork) * ctx.workN + align - 1) / align * align;
	local::LargeBuf buf(align + baseBytes + resBytes + workBytes + numTasks);
	if (buf.p == 0) return 0;
	char *p = (char*)(((uintptr_t)buf.p + align - 1) & ~(uintptr_t)(align - 1));
	ctx.baseW = needCvt ? p : 0; p += baseBytes;
	ctx.res = (G*)p; p += resBytes;
	ctx.works = (ThreadWork*)p; p += workBytes;
	ctx.ok = (uint8_t*)p;
	memset(ctx.ok, 0, numTasks);
	for (size_t i = 0; i < ctx.workN; i++) new(&ctx.works[i]) ThreadWork();
	ctx.base = baseArg ? baseArg : needCvt ? ctx.baseW : tryBatch ? (const void*)xVec : 0;
	if (doNormalize || needCvt) par.run(Ctx::prepareTask, &ctx, ctx.C);
	par.run(Ctx::windowTask, &ctx, numTasks);
	bool ok = true;
	for (size_t i = 0; i < numTasks; i++) {
		if (!ctx.ok[i]) {
			ok = false;
			break;
		}
	}
	if (ok) {
		// z = sum_w 2^(b w) sum_c res[c winN + w]
		for (size_t w = ctx.winN; w > 0; w--) {
			if (w < ctx.winN) {
				for (size_t i = 0; i < ctx.b; i++) G::dbl(z, z);
			}
			for (size_t c = 0; c < ctx.C; c++) {
				const G& r = ctx.res[c * ctx.winN + w - 1];
				if (w == ctx.winN && c == 0) {
					z = r;
				} else {
					z += r;
				}
			}
		}
	}
	for (size_t i = 0; i < ctx.workN; i++) ctx.works[i].~ThreadWork();
	return ok ? n : 0;
}

} // mcl::ec::local

/*
	z = sum_{i=0}^{n-1} xVec[i] * yVec[i]
	yVec[i] means yVec[i*next:(i+1)*next+yUnitSize]
	return numbers of done, which may be smaller than n if malloc fails
	@note xVec may be normlized
	fast for n >= MCL_MSM_MIN_SPLIT_N
	maxBitSize : the max bit size of yVec[i] (yUnitSize * UnitBitSize if 0)
	baseArg : xVec converted to the layout of the SIMD kernel by the caller (then xVec is not used, the batch affine addition with the kernel is required
	and 0 is returned if its work buffer can not be allocated)
*/
template<class G>
size_t mulVecCore(G& z, G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, size_t b, bool doNormalize, const ec::ParallelFor& par, size_t maxBitSize = 0, const void *baseArg = 0)
{
	if (n == 0) {
		z.clear();
		return 0;
	}
	if (n == 1) {
		G::mulArray(z, xVec[0], yVec, yUnitSize);
		return 1;
	}
	if (maxBitSize == 0) maxBitSize = sizeof(Unit) * yUnitSize * 8;

	size_t tblN; // 2^b for the top window (see mulVecUpdateTable), the others use 2^(b-1)
	G *tbl = 0;
	// the SIMD kernel of the batch affine addition (0 : the generic one), which may have its own cost model of the window size
	const ec::MsmKernel *kernel = local::MsmBatch<G>::getKernel();
	// the batch affine addition is used for n >= batchMinN if wk.init succeeds (see below)
	const size_t batchMinN = local::msmBatchMinN(kernel);
	assert(baseArg == 0 || (kernel && n >= batchMinN));
	const bool tryBatch = local::MsmBatch<G>::enabled && n >= batchMinN;
	const size_t bArg = b;
	if (b == 0) {
		if (tryBatch && kernel && kernel->getBucketSize) {
			b = kernel->getBucketSize(n, maxBitSize, sizeof(G));
		} else {
			b = glvGetBucketSizeByCost(n, maxBitSize, sizeof(G), tryBatch ? msmCostParamBatch() : msmCostParamGeneric());
		}
	}

	// the parallel version if par is parallel and n is large enough
	if (par.isParallel() && n >= 2 * MCL_MSM_PAR_MIN_CHUNK) {
		const size_t done = local::mulVecCorePar<G>(z, xVec, yVec, yUnitSize, next, n, bArg, doNormalize, maxBitSize, baseArg, kernel, tryBatch, batchMinN, par);
		if (done) return done;
	}

	tblN = size_t(1) << b;
	// the batch affine addition has its own bucket table (wk.tbl in the layout of the kernel), so tbl is allocated only for the generic path
	typename local::MsmBatch<G>::Work wk;
	const bool useBatch = local::MsmBatch<G>::enabled && n >= batchMinN && wk.init(n, tblN, kernel, baseArg != 0);
	if (baseArg && !useBatch) return 0; // the caller gives only the converted points
#ifndef MCL_DONT_USE_MALLOC
	mcl::Array<G> tbl_; // the table on the heap if not on the stack
#endif
	if (!useBatch) {
		// the table is put on the stack if n and the table are small (b of the argument may be large even if n is small)
		const bool useStack = n <= MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC && sizeof(G) * tblN <= MCL_MSM_MAX_STACK_TBL_BYTES;
		(void)useStack;
#ifndef MCL_DONT_USE_MALLOC
		// if n or the table is large then try to use malloc
		if (!useStack && tbl_.resize(tblN)) tbl = tbl_.data();
#endif
		if (tbl == 0) {
			// n is small or malloc fails so use stack
			if (n > MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC) {
				n = MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC;
				// recompute b for the reduced n (the generic model : the batch affine addition is not used)
				if (bArg == 0) b = glvGetBucketSizeByCost(n, maxBitSize, sizeof(G), msmCostParamGeneric());
			}
			// reduce b (of the argument) so that the table fits in the stack
			while (b > 2 && (sizeof(G) << b) > MCL_MSM_MAX_STACK_TBL_BYTES) b--;
			tblN = size_t(1) << b;
			tbl = (G*)CYBOZU_ALLOCA(sizeof(G) * tblN);
		}
	}
	const size_t winN = (maxBitSize + b-1) / b;
	const size_t rem = maxBitSize - b * (winN-1); // the bit size of the top window in [1, b]

	// about 10% faster
	if (doNormalize) G::normalizeVec(xVec, xVec, n);

	// the batch affine addition requires affine (or zero) xVec, which is guaranteed by normalizeVec of the caller
	const void *base = baseArg ? baseArg : xVec; // xVec in the layout of the kernel (converted once and shared by all the windows)
	if (useBatch && wk.base) {
		wk.kn.cvtBase(wk.base, xVec, n);
		base = wk.base;
	}
	// z = sum_w 2^(b w) win[w] from the top window
	local::msmWindow(z, winN - 1, winN, b, rem, xVec, base, yVec, yUnitSize, next, n, useBatch, &wk, tbl);
	for (size_t w = winN - 1; w > 0; w--) {
		for (size_t i = 0; i < b; i++) {
			G::dbl(z, z);
		}
		G t;
		local::msmWindow(t, w - 1, winN, b, rem, xVec, base, yVec, yUnitSize, next, n, useBatch, &wk, tbl);
		z += t;
	}
	return n;
}
template<class G>
void mulVecLong(G& z, G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, size_t b, bool doNormalize, const ec::ParallelFor& par, size_t maxBitSize = 0)
{
	size_t done = mulVecCore(z, xVec, yVec, yUnitSize, next, n, b, doNormalize, par, maxBitSize);
	if (done == n) return;
	do {
		xVec += done;
		yVec += next * done;
		n -= done;
		G t;
		done = mulVecCore(t, xVec, yVec, yUnitSize, next, n, b, doNormalize, par, maxBitSize);
		z += t;
	} while (done < n);
}

namespace local {

// the fixed-width split of GLV1T (0 if not available), see GLV1T::splitRaw
typedef uint32_t (*SplitRawFunc)(Unit *a, Unit *b, const Unit *x);
inline SplitRawFunc getSplitRaw(const void *) { return 0; }
template<class Ec>
SplitRawFunc getSplitRaw(const GLV1T<Ec> *) { return GLV1T<Ec>::splitRaw; }

// ya = |a|, yb = |b| of the split y = a + b lambda by splitRaw (zero-padded to next units), updates maxBitSize and returns the sign bits (1 : a < 0, 2 : b < 0)
inline uint32_t msmSplitRaw(Unit *ya, Unit *yb, const Unit *y, size_t next, SplitRawFunc splitRaw, size_t& maxBitSize)
{
	const size_t rawN = 128 / UnitBitSize; // the size of a, b of splitRaw
	assert(next >= rawN);
	const uint32_t neg = splitRaw(ya, yb, y);
	for (size_t k = rawN; k < next; k++) {
		ya[k] = 0;
		yb[k] = 0;
	}
	size_t bitSize = fp::getBitSize(ya, rawN);
	if (bitSize > maxBitSize) maxBitSize = bitSize;
	bitSize = fp::getBitSize(yb, rawN);
	if (bitSize > maxBitSize) maxBitSize = bitSize;
	return neg;
}

/*
	the GLV split of the scalars by splitRaw in C chunks (the tasks of the parallel-for of mulVecGLVlarge ; C = 1 : sequential)
	fused (neg != 0) : neg[i] = the signs and the split scalars of the chunk c = [off, off + nc) are yp[2 off + j] (a) and yp[2 off + nc + j] (b)
	  (the same layout as cvtBaseGLV of the chunk, so the chunks are converted independently)
	generic (neg = 0) : yp[i] = |a|, yp[n + i] = |b| and tbl[i], tbl[n + i] are negated by the signs
*/
/*
	the contract of the parallel-for for the chunk tasks of mulVecGLVlarge : [begin, end) is a part of [0, C) and each chunk is done exactly once.
	a violation is an assert, and the caller detects it by done[c] (the number of times the chunk c is processed) and runs the sequential one.
*/
inline bool msmChunkRangeOk(size_t begin, size_t end, size_t C)
{
	assert(begin < end && end <= C);
	return begin < end && end <= C;
}
inline bool msmChunksDoneOnce(const uint8_t *done, size_t C)
{
	for (size_t c = 0; c < C; c++) {
		if (done[c] != 1) return false;
	}
	return true;
}

template<class G>
struct MsmSplitCtx {
	typedef typename G::Fr F;
	fp::getUnitAtType getUnitAt;
	const void *yVec;
	size_t n;
	size_t next;
	size_t C;
	SplitRawFunc splitRaw;
	Unit *yp;
	uint8_t *neg;
	G *tbl;
	size_t *maxBit; // [C] the max bit size of the split scalars of each chunk
	uint8_t *done; // [C]
	size_t chunkBegin(size_t c) const { return n * c / C; }
	static void task(size_t begin, size_t end, size_t, void *arg)
	{
		MsmSplitCtx& ctx = *(MsmSplitCtx*)arg;
		if (!msmChunkRangeOk(begin, end, ctx.C)) return;
		Unit y[F::maxSize];
		for (size_t c = begin; c < end; c++) {
			ctx.done[c]++;
			const size_t off = ctx.chunkBegin(c);
			const size_t nc = ctx.chunkBegin(c + 1) - off;
			size_t maxBitSize = 0;
			for (size_t j = 0; j < nc; j++) {
				const size_t i = off + j;
				ctx.getUnitAt(y, ctx.yVec, i);
				Unit *ya, *yb;
				if (ctx.neg) {
					ya = ctx.yp + (2 * off + j) * ctx.next;
					yb = ctx.yp + (2 * off + nc + j) * ctx.next;
				} else {
					ya = ctx.yp + i * ctx.next;
					yb = ctx.yp + (ctx.n + i) * ctx.next;
				}
				const uint32_t r = msmSplitRaw(ya, yb, y, ctx.next, ctx.splitRaw, maxBitSize);
				if (ctx.neg) {
					ctx.neg[i] = uint8_t(r);
				} else {
					if (r & 1) G::neg(ctx.tbl[i], ctx.tbl[i]);
					if (r & 2) G::neg(ctx.tbl[ctx.n + i], ctx.tbl[ctx.n + i]);
				}
			}
			ctx.maxBit[c] = maxBitSize;
		}
	}
	// run the split (by par if C > 1) and set the max bit size. return false if the parallel-for violates the contract
	bool run(const ec::ParallelFor& par, size_t *pMaxBitSize)
	{
		memset(done, 0, C);
		if (C > 1) {
			par.run(task, this, C);
		} else {
			task(0, 1, 0, this);
		}
		if (!msmChunksDoneOnce(done, C)) return false;
		size_t maxBitSize = 0;
		for (size_t c = 0; c < C; c++) {
			if (maxBit[c] > maxBitSize) maxBitSize = maxBit[c];
		}
		*pMaxBitSize = maxBitSize;
		return true;
	}
};

// the max number of the chunks of the GLV split (the stack arrays of mulVecGLVlarge)
static const size_t MAX_PAR_CHUNKS = 1024;

// the number of the chunks of the GLV split : min(par.maxThreads, n / MCL_MSM_PAR_MIN_CHUNK, MAX_PAR_CHUNKS) if par is parallel
inline size_t msmSplitChunks(size_t n, const ec::ParallelFor& par)
{
	if (!par.isParallel()) return 1;
	size_t C = n / MCL_MSM_PAR_MIN_CHUNK;
	if (C > par.maxThreads) C = par.maxThreads;
	if (C > MAX_PAR_CHUNKS) C = MAX_PAR_CHUNKS;
	return C < 1 ? 1 : C;
}

// the chunked MsmBatch<G>::isNormalizedVec (the task of the parallel-for of the fused path of mulVecGLVlarge)
template<class G>
struct MsmNormalizedCtx {
	const G *xVec;
	size_t n;
	size_t C;
	uint8_t *flag; // [C] 1 if the chunk is normalized
	uint8_t *done; // [C]
	size_t chunkBegin(size_t c) const { return n * c / C; }
	static void task(size_t begin, size_t end, size_t, void *arg)
	{
		const MsmNormalizedCtx& ctx = *(const MsmNormalizedCtx*)arg;
		if (!msmChunkRangeOk(begin, end, ctx.C)) return;
		for (size_t c = begin; c < end; c++) {
			ctx.done[c]++;
			const size_t off = ctx.chunkBegin(c);
			ctx.flag[c] = MsmBatch<G>::isNormalizedVec(ctx.xVec + off, ctx.chunkBegin(c + 1) - off) ? 1 : 0;
		}
	}
	// set *pNormalized = true if all the points are normalized. return false if the parallel-for violates the contract
	bool run(const ec::ParallelFor& par, bool *pNormalized)
	{
		memset(done, 0, C);
		if (C > 1) {
			par.run(task, this, C);
		} else {
			task(0, 1, 0, this);
		}
		if (!msmChunksDoneOnce(done, C)) return false;
		*pNormalized = true;
		for (size_t c = 0; c < C; c++) {
			if (!flag[c]) {
				*pNormalized = false;
				break;
			}
		}
		return true;
	}
};

// the chunked cvtBaseGLV (the task of the parallel-for of the fused path of mulVecGLVlarge)
template<class G>
struct MsmCvtGLVCtx {
	const ec::MsmKernel *kernel;
	void *base;
	const G *xVec;
	const uint8_t *neg;
	size_t n;
	size_t C;
	uint8_t *done; // [C]
	size_t chunkBegin(size_t c) const { return n * c / C; }
	static void task(size_t begin, size_t end, size_t, void *arg)
	{
		const MsmCvtGLVCtx& ctx = *(const MsmCvtGLVCtx*)arg;
		if (!msmChunkRangeOk(begin, end, ctx.C)) return;
		for (size_t c = begin; c < end; c++) {
			ctx.done[c]++;
			const size_t off = ctx.chunkBegin(c);
			const size_t nc = ctx.chunkBegin(c + 1) - off;
			ctx.kernel->cvtBaseGLV((char*)ctx.base + 2 * off * ctx.kernel->pointSize, ctx.xVec + off, nc, ctx.neg + off);
		}
	}
	// return false if the parallel-for violates the contract
	bool run(const ec::ParallelFor& par)
	{
		memset(done, 0, C);
		if (C > 1) {
			par.run(task, this, C);
		} else {
			task(0, 1, 0, this);
		}
		return msmChunksDoneOnce(done, C);
	}
};

} // mcl::ec::local

/*
	the bucket method for n * splitN >= MCL_MSM_MIN_SPLIT_N (MCL_MSM_MIN_SPLIT_N_NO_BATCH for GT)
	return 1 if done, 0 if malloc fails, -1 if the tasks of par violate the contract (then retry sequentially)
*/
template<class GLV, class G>
int mulVecGLVlargeCore(G& z, const G *xVec, const void *yVec, size_t n, size_t bucket, const ec::ParallelFor& par)
{
	const int splitN = GLV::splitN;
	assert(n > 0);
	uint8_t done[local::MAX_PAR_CHUNKS]; // the chunk counters of the tasks of par
	typedef typename G::Fr F;
	fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
	typedef mcl::Unit Unit;
	const size_t next = F::getUnitSize();
	mpz_class u[splitN];
	Unit y[F::maxSize];

	const size_t ypByteSize = sizeof(Unit) * next * splitN * n;
	// the fixed-width split (no mpz) if available
	const local::SplitRawFunc splitRaw = (splitN == 2) ? local::getSplitRaw((const GLV*)0) : 0;
	size_t maxBitSize = 0; // of the split scalars (about 128 bits for G1 of BN / BLS12)
	/*
		the fused path : the SIMD kernel converts xVec and lambda(xVec) with the signs of the split scalars directly to its layout (cvtBaseGLV),
		so the copy of 2 n G (normalizeVec, mulLambda and neg) and its conversion (cvtBase in mulVecCore) are not needed
		(xVec is normalized to a copy of n G if it has a non-affine point)
	*/
	const ec::MsmKernel *kernel = local::MsmBatch<G>::getKernel();
	// the split (and cvtBaseGLV) are done in C chunks by the parallel-for par if parallel
	const size_t C = splitRaw ? local::msmSplitChunks(n, par) : 1;
	const size_t maxBitByteSize = sizeof(size_t) * C;
	if (splitRaw && kernel && kernel->cvtBaseGLV && n * splitN >= local::msmBatchMinN(kernel)) {
		const size_t align = 64;
		const size_t baseByteSize = (kernel->pointSize * splitN * n + align - 1) / align * align;
		bool normalized;
		{
			uint8_t flag[local::MAX_PAR_CHUNKS];
			local::MsmNormalizedCtx<G> ctx = { xVec, n, C, flag, done };
			if (!ctx.run(par, &normalized)) return -1;
		}
		const size_t tmpByteSize = normalized ? 0 : (sizeof(G) * n + align - 1) / align * align;
		const size_t negByteSize = (n + align - 1) / align * align;
		local::LargeBuf buf(align + baseByteSize + tmpByteSize + negByteSize + ypByteSize + maxBitByteSize);
		if (buf.p == 0) return 0;
		char *p = (char*)(((uintptr_t)buf.p + align - 1) & ~(uintptr_t)(align - 1));
		void *base = p; p += baseByteSize;
		G *tmp = (G*)p; p += tmpByteSize;
		uint8_t *neg = (uint8_t*)p; p += negByteSize;
		Unit *yp = (Unit*)p; p += ypByteSize;
		size_t *maxBit = (size_t*)p;
		if (!normalized) {
			G::normalizeVec(tmp, xVec, n);
			xVec = tmp;
		}
		{
			local::MsmSplitCtx<G> ctx = { getUnitAt, yVec, n, next, C, splitRaw, yp, neg, 0, maxBit, done };
			if (!ctx.run(par, &maxBitSize)) return -1;
		}
		if (maxBitSize == 0) {
			z.clear();
			return 1;
		}
		local::MsmCvtGLVCtx<G> ctx = { kernel, base, xVec, neg, n, C, done };
		if (!ctx.run(par)) return -1;
		const size_t yUnitSize = (maxBitSize + UnitBitSize - 1) / UnitBitSize;
		return mulVecCore(z, (G*)0, yp, yUnitSize, next, n * splitN, bucket, false, par, maxBitSize, base) == n * splitN ? 1 : 0;
	}

	const size_t tblByteSize = sizeof(G) * splitN * n;
	local::LargeBuf buf(tblByteSize + ypByteSize + maxBitByteSize);
	if (buf.p == 0) return 0;
	G *tbl = (G*)buf.p;

	Unit *yp = (Unit *)(tbl + splitN * n);
	size_t *maxBit = (size_t*)((char*)yp + ypByteSize);

	G::normalizeVec(tbl, xVec, n);
	for (int i = 1; i < splitN; i++) {
		for (size_t j = 0; j < n; j++) {
			GLV::mulLambda(tbl[i * n + j], tbl[(i - 1) * n + j]);
		}
	}
	if (splitRaw) {
		local::MsmSplitCtx<G> ctx = { getUnitAt, yVec, n, next, C, splitRaw, yp, 0, tbl, maxBit, done };
		if (!ctx.run(par, &maxBitSize)) return -1;
	}
	for (size_t i = 0; splitRaw == 0 && i < n; i++) {
		getUnitAt(y, yVec, i);
		GLV::split(u, y);
		for (size_t j = 0; j < splitN; j++) {
			size_t idx = j * n + i;
			if (u[j] < 0) {
				u[j] = -u[j];
				G::neg(tbl[idx], tbl[idx]);
			}
			bool b;
			mcl::gmp::getArray(&b, &yp[idx * next], next, u[j]);
			assert(b); (void)b;
			size_t bitSize = fp::getBitSize(&yp[idx * next], next);
			if (bitSize > maxBitSize) maxBitSize = bitSize;
		}
	}
	if (maxBitSize == 0) {
		z.clear();
	} else {
		const size_t yUnitSize = (maxBitSize + UnitBitSize - 1) / UnitBitSize;
		mulVecLong(z, tbl, yp, yUnitSize, next, n * splitN, bucket, false, par, maxBitSize);
	}
	return 1;
}

template<class GLV, class G>
bool mulVecGLVlarge(G& z, const G *xVec, const void *yVec, size_t n, size_t bucket, const ec::ParallelFor& par)
{
	int r = mulVecGLVlargeCore<GLV, G>(z, xVec, yVec, n, bucket, par);
	// the buffers of the parallel run are released before the sequential retry
	if (r < 0) r = mulVecGLVlargeCore<GLV, G>(z, xVec, yVec, n, bucket, ec::ParallelFor::seq());
	return r > 0;
}

/*
	z += xVec[i] * yVec[i] for i = 0, ..., min(N, n)
	splitN = 2(G1) or 4(G2)
	w : window size
	for n <= 16
*/
template<class GLV, class G, int w>
static void mulVecGLVsmall(G& z, const G *xVec, const void* yVec, size_t n)
{
	assert(n <= mcl::fp::maxMulVecNGLV);
	const int splitN = GLV::splitN;
	const size_t tblSize = 1 << (w - 2);
	typedef typename G::Fr F;
	fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
	typedef mcl::FixedArray<int8_t, sizeof(F) * 8 / splitN + splitN> NafArray;
	NafArray (*naf)[splitN] = (NafArray (*)[splitN])CYBOZU_ALLOCA(sizeof(NafArray) * n * splitN);
	// layout tbl[splitN][n][tblSize];
	G (*tbl)[tblSize] = (G (*)[tblSize])CYBOZU_ALLOCA(sizeof(G) * splitN * n * tblSize);
	mpz_class u[splitN];
	Unit y[F::maxSize];
	size_t maxBit = 0;

	for (size_t i = 0; i < n; i++) {
		getUnitAt(y, yVec, i);
		if (n == 1) {
			const size_t yn = bint::getRealSize(y, F::getUnitSize());
			if (yn <= 1 && mulSmallInt(z, xVec[0], y[0], false)) return;
		}
		GLV::split(u, y);

		for (int j = 0; j < splitN; j++) {
			bool b;
			gmp::getNAFwidth(&b, naf[i][j], u[j], w);
			assert(b); (void)b;
			if (naf[i][j].size() > maxBit) maxBit = naf[i][j].size();
		}

		G P2;
		G::dbl(P2, xVec[i]);
		tbl[0 * n + i][0] = xVec[i];
		for (size_t j = 1; j < tblSize; j++) {
			G::add(tbl[0 * n + i][j], tbl[0 * n + i][j - 1], P2);
		}
	}
	G::normalizeVec(&tbl[0][0], &tbl[0][0], n * tblSize);
	for (size_t i = 0; i < n; i++) {
		for (int k = 1; k < splitN; k++) {
			GLV::mulLambda(tbl[k * n + i][0], tbl[(k - 1) * n + i][0]);
		}
		for (size_t j = 1; j < tblSize; j++) {
			for (int k = 1; k < splitN; k++) {
				GLV::mulLambda(tbl[k * n + i][j], tbl[(k - 1) * n + i][j]);
			}
		}
	}
	z.clear();
	for (size_t i = 0; i < maxBit; i++) {
		const size_t bit = maxBit - 1 - i;
		G::dbl(z, z);
		for (size_t j = 0; j < n; j++) {
			for (int k = 0; k < splitN; k++) {
				local::addTbl(z, tbl[k * n + j], naf[j][k], bit);
			}
		}
	}
}

/*
	Q = x P
	splitN = 2(G1) or 4(G2)
	w : window size
*/
template<class GLV, class G>
void mulGLV_CT(G& Q, const G& P, const void *yVec)
{
	const size_t w = 4;
	typedef typename G::Fr F;
	fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
	const int splitN = GLV::splitN;
	const size_t tblSize = 1 << w;
	G tbl[splitN][tblSize];
	bool negTbl[splitN];
	mpz_class u[splitN];
	Unit y[F::maxSize];
	getUnitAt(y, yVec, 0);
	GLV::split(u, y);
	for (int i = 0; i < splitN; i++) {
		if (u[i] < 0) {
			gmp::neg(u[i], u[i]);
			negTbl[i] = true;
		} else {
			negTbl[i] = false;
		}
		tbl[i][0].clear();
	}
	tbl[0][1] = P;
	for (size_t j = 2; j < tblSize; j++) {
		G::add(tbl[0][j], tbl[0][j - 1], P);
	}
	for (int i = 1; i < splitN; i++) {
		for (size_t j = 1; j < tblSize; j++) {
			GLV::mulLambda(tbl[i][j], tbl[i - 1][j]);
		}
	}
	for (int i = 0; i < splitN; i++) {
		if (negTbl[i]) {
			for (size_t j = 0; j < tblSize; j++) {
				G::neg(tbl[i][j], tbl[i][j]);
			}
		}
	}
	mcl::FixedArray<uint8_t, sizeof(F) * 8 / w + 1> vTbl[splitN];
	size_t loopN = 0;
	{
		size_t maxBitSize = 0;
		fp::BitIterator<Unit> itr[splitN];
		for (int i = 0; i < splitN; i++) {
			itr[i].init(gmp::getUnit(u[i]), gmp::getUnitSize(u[i]));
			size_t bitSize = itr[i].getBitSize();
			if (bitSize > maxBitSize) maxBitSize = bitSize;
		}
		loopN = (maxBitSize + w - 1) / w;
		for (int i = 0; i < splitN; i++) {
			bool b = vTbl[i].resize(loopN);
			assert(b);
			(void)b;
			for (size_t j = 0; j < loopN; j++) {
				vTbl[i][loopN - 1 - j] = (uint8_t)itr[i].getNext(w);
			}
		}
	}
	Q.clear();
	for (size_t k = 0; k < loopN; k++) {
		for (size_t i = 0; i < w; i++) {
			G::dbl(Q, Q);
		}
		for (size_t i = 0; i < splitN; i++) {
			uint8_t v = vTbl[i][k];
			G::add(Q, Q, tbl[i][v]);
		}
	}
}

// return false if malloc fails or n is not in a target range
template<class GLV, class G>
bool mulVecGLVT(G& z, const G *xVec, const void *yVec, size_t n, bool constTime, size_t b, const ec::ParallelFor& par)
{
	if (n == 1 && constTime) {
		mulGLV_CT<GLV, G>(z, xVec[0], yVec);
		return true;
	}
	if (n <= mcl::fp::maxMulVecNGLV) {
		mulVecGLVsmall<GLV, G, 5>(z, xVec, yVec, n);
		return true;
	}
	const size_t minSplitN = local::MsmBatch<G>::enabled ? MCL_MSM_MIN_SPLIT_N : MCL_MSM_MIN_SPLIT_N_NO_BATCH;
	if (n * GLV::splitN >= minSplitN) {
		return mulVecGLVlarge<GLV, G>(z, xVec, yVec, n, b, par);
	}
	return false;
}

#endif

} // mcl::ec

#ifndef MCL_GLV_ONLY_FUNC

#include "glv_param.hpp"

// r = the order of Ec
template<class Ec>
struct GLV1T {
	typedef GLV1T<Ec> GLV1;
	typedef typename Ec::Fp Fp;
	typedef typename Ec::Fr Fr; // the scalar field (mcl::Fr for G1, mcl::Fp for GG)
	static const int splitN = 2;
	static Fp rw; // rw = 1 / w = (-1 - sqrt(-3)) / 2
	static size_t rBitSize;
	static mpz_class v0, v1;
	static mpz_class B[2][2];
	static bool isBLS12;
	/*
		the fixed-width split without mpz (0 if not available, then split() uses mpz)
		x = a + b lambda mod r, |a|, |b| < 2^128 (a, b : rawN Unit), return the sign bits (bit0 : a < 0, bit1 : b < 0)
		x : the lower 256 bits of the scalar (x < r < 2^256)
	*/
	typedef uint32_t (*SplitRawFunc)(Unit *a, Unit *b, const Unit *x);
	static SplitRawFunc splitRaw;
	static const size_t rawN = 128 / UnitBitSize;
	// the parameters of splitRawTbl (see src/glv_param.hpp)
	static const size_t xn = 256 / UnitBitSize; // the size of x of splitRaw
	static const size_t bn = 192 / UnitBitSize; // the size of BU
	static Unit v0U[xn];
	static Unit v1U[xn];
	static Unit BU[2][2][bn]; // |B[i][j]| < 2^(128 + UnitBitSize) : BU[i][j][rawN] is the top Unit, BU[i][j][k] = 0 for k > rawN
	static uint32_t Bneg; // the bit (i * 2 + j) is set if B[i][j] < 0
	static Unit LU[rawN]; // L = z^2 - 1 for BLS12
	static Unit qU[rawN]; // floor(2^rBitSize / L) for BLS12
public:
#ifndef CYBOZU_DONT_USE_STRING
	static void dump(const mpz_class& x)
	{
		printf("\"%s\",\n", mcl::gmp::getStr(x, 16).c_str());
	}
	static void dump()
	{
		printf("\"%s\",\n", rw.getStr(16).c_str());
		printf("%d,\n", (int)rBitSize);
		dump(v0);
		dump(v1);
		dump(B[0][0]); dump(B[0][1]); dump(B[1][0]); dump(B[1][1]);
	}
#endif
	/*
		L (x, y) = (rw x, y)
	*/
	static void mulLambda(Ec& Q, const Ec& P)
	{
		Fp::mul(Q.x, P.x, rw);
		Q.y = P.y;
		Q.z = P.z;
	}
	/*
		x = u[0] + u[1] * lambda mod r
		x[Fr::getUnitSize()] < r
	*/
	static void split(mpz_class u[2], const Unit *_x)
	{
		const fp::Op& op = Fr::getOp();
		assert(bint::cmpLtN(_x, op.p, op.N)); // _x < r
		bool ok;
		if (splitRaw) {
			Unit a[rawN], b[rawN];
			const uint32_t neg = splitRaw(a, b, _x);
			gmp::setArray(&ok, u[0], a, rawN);
			assert(ok);
			gmp::setArray(&ok, u[1], b, rawN);
			assert(ok);
			(void)ok;
			if (neg & 1) u[0] = -u[0];
			if (neg & 2) u[1] = -u[1];
			return;
		}
		mpz_class x;
		gmp::setArray(&ok, x, _x, op.N);
		assert(ok);
		(void)ok;
		mpz_class& a = u[0];
		mpz_class& b = u[1];
		if (isBLS12) {
			// x = (a + b L) mod r
			b = (x * v0) >> rBitSize;
			a = x - b * B[0][0];
			return;
		}
		mpz_class t;
		t = (x * v0) >> rBitSize;
		b = (x * v1) >> rBitSize;
		a = x - (t * B[0][0] + b * B[1][0]);
		b = - (t * B[0][1] + b * B[1][1]);
	}
	/*
		the fixed-width version of split for BLS12 in glv1ParamBLS12Tbl
		x = a + b L, 0 <= a < L, 0 <= b <= L+1 (L = z^2-1, r = L^2 + L + 1)
		b = ((x >> (rBitSize - 128)) q) >> 128 with q = floor(2^rBitSize / L), a = x - bL
		b <= x/L so a >= 0, and a < 2L is verified in src/gen_glv.py, so a -= L, b += 1 once if a >= L
	*/
	static uint32_t splitRawBLS12(Unit *a, Unit *b, const Unit *x)
	{
		const Unit *L = LU;
		Unit xH[rawN]; // x >> (rBitSize - 128) < 2^128 because x < r < 2^rBitSize
		shrRaw(xH, x, rBitSize - 128);
		Unit t[rawN * 2];
		bint::mulT<rawN>(t, xH, qU);
		bint::copyT<rawN>(b, t + rawN); // (xH q) >> 128
		bint::mulT<rawN>(t, b, L); // bL
		bint::subT<rawN * 2>(t, x, t); // x - bL < 2L (may be 129 bits)
		Unit d = bint::subT<rawN>(a, t, L);
		if (t[rawN] - d == 0) { // x - bL >= L
			Unit one[rawN];
			bint::clearT<rawN>(one);
			one[0] = 1;
			bint::addT<rawN>(b, b, one);
		} else {
			bint::copyT<rawN>(a, t);
		}
		return 0;
	}
	// y[rawN] = (x >> s) mod 2^128 ; x must have (s / UnitBitSize) + rawN + 1 Unit
	static void shrRaw(Unit *y, const Unit *x, size_t s)
	{
		const size_t q = s / UnitBitSize;
		const size_t rem = s % UnitBitSize;
		if (rem == 0) {
			bint::copyT<rawN>(y, x + q);
		} else {
			Unit t[rawN + 1];
			bint::shrN(t, x + q, rem, rawN + 1);
			bint::copyT<rawN>(y, t);
		}
	}
	// y[rawN] = |x[xn]| (x is two's complement and |x| < 2^128), return 1 if x < 0
	static uint32_t absRaw(Unit *y, Unit *x)
	{
		const uint32_t neg = uint32_t(x[xn - 1] >> (UnitBitSize - 1));
		if (neg) {
			Unit zero[xn];
			bint::clearT<xn>(zero);
			bint::subT<xn>(x, zero, x);
		}
		bint::copyT<rawN>(y, x);
		for (size_t i = rawN; i < xn; i++) {
			assert(x[i] == 0);
			(void)x;
		}
		return neg;
	}
	/*
		the fixed-width version of split for BN and secp256k1 in glv1ParamBNTbl
		t = (x v0 + 2^(rBitSize-1)) >> rBitSize, b0 = (x v1 + 2^(rBitSize-1)) >> rBitSize (rounding, rBitSize = 256 + 64)
		a = x - (t B00 + b0 B10), b = -(t B01 + b0 B11) (mod 2^256)
		|a|, |b| < 2^128 is verified in src/gen_glv.py (the intermediate values may wrap mod 2^256)
	*/
	static uint32_t splitRawTbl(Unit *a, Unit *b, const Unit *x)
	{
		Unit t[rawN], b0[rawN];
		{
			Unit z[xn * 2];
			bint::mulT<xn>(z, x, v0U);
			roundShrRaw(t, z, rBitSize);
			bint::mulT<xn>(z, x, v1U);
			roundShrRaw(b0, z, rBitSize);
		}
		Unit p0[xn], p1[xn], acc[xn];
		// a = x - (B00 t + B10 b0)
		mulB(p0, t, BU[0][0]);
		mulB(p1, b0, BU[1][0]);
		bint::copyT<xn>(acc, x);
		if (Bneg & 1) bint::addT<xn>(acc, acc, p0); else bint::subT<xn>(acc, acc, p0);
		if (Bneg & 4) bint::addT<xn>(acc, acc, p1); else bint::subT<xn>(acc, acc, p1);
		uint32_t neg = absRaw(a, acc);
		// b = -(B01 t + B11 b0)
		mulB(p0, t, BU[0][1]);
		mulB(p1, b0, BU[1][1]);
		bint::clearT<xn>(acc);
		if (Bneg & 2) bint::addT<xn>(acc, acc, p0); else bint::subT<xn>(acc, acc, p0);
		if (Bneg & 8) bint::addT<xn>(acc, acc, p1); else bint::subT<xn>(acc, acc, p1);
		neg |= absRaw(b, acc) << 1;
		return neg;
	}
	// y[xn] = (t[rawN] * B) mod 2^256 where B = B[rawN] 2^128 + B[0..rawN)
	static void mulB(Unit *y, const Unit *t, const Unit *B)
	{
		bint::mulT<rawN>(y, t, B);
		const Unit top = B[rawN];
		if (top) {
			Unit q[rawN + 1];
			bint::mulUnitT<rawN>(q, t, top);
			bint::addT<rawN>(y + rawN, y + rawN, q);
		}
	}
	// y[rawN] = ((x[xn * 2] + 2^(s-1)) >> s) mod 2^128 ; x is broken
	static void roundShrRaw(Unit *y, Unit *x, size_t s)
	{
		const size_t q = (s - 1) / UnitBitSize;
		const Unit half = Unit(1) << ((s - 1) % UnitBitSize);
		assert(q < xn * 2);
		bint::addUnit(x + q, xn * 2 - q, half);
		shrRaw(y, x, s);
	}
	// Unit y[yn] = uint64_t x[xn]
	static void cvtU64ToUnit(Unit *y, size_t yn, const uint64_t *x, size_t xn)
	{
		const size_t m = 64 / UnitBitSize;
		assert(yn == xn * m);
		(void)yn;
		for (size_t i = 0; i < xn; i++) {
			for (size_t j = 0; j < m; j++) {
				y[i * m + j] = Unit(x[i] >> (j * UnitBitSize));
			}
		}
	}
	static void setMpz(mpz_class& z, const uint64_t *x, size_t xn, bool neg)
	{
		const size_t m = 64 / UnitBitSize;
		Unit u[4 * m];
		assert(xn <= 4);
		cvtU64ToUnit(u, xn * m, x, xn);
		bool b;
		gmp::setArray(&b, z, u, xn * m);
		assert(b);
		(void)b;
		if (neg) z = -z;
	}
	/*
		set the parameters from glv1ParamBNTbl / glv1ParamBLS12Tbl (generated by src/gen_glv.py)
		return false if not found
	*/
	static bool useParamTbl(int curveType)
	{
		if (curveType < 0) return false;
		if (Fr::getOp().bitSize > 256) return false;
		bool b;
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(glv1ParamBNTbl); i++) {
			const GLV1ParamBN& prm = glv1ParamBNTbl[i];
			if (prm.curveType != curveType) continue;
			rw.setStr(&b, prm.rw, 16);
			if (!b) return false;
			isBLS12 = false;
			rBitSize = prm.shift;
			setMpz(v0, prm.v0, 4, false);
			setMpz(v1, prm.v1, 4, false);
			for (int j = 0; j < 2; j++) {
				for (int k = 0; k < 2; k++) {
					setMpz(B[j][k], prm.B[j][k], 3, (prm.Bneg & (1 << (j * 2 + k))) != 0);
					cvtU64ToUnit(BU[j][k], bn, prm.B[j][k], 3);
					for (size_t m = rawN + 1; m < bn; m++) {
						assert(BU[j][k][m] == 0);
						(void)m;
					}
				}
			}
			cvtU64ToUnit(v0U, xn, prm.v0, 4);
			cvtU64ToUnit(v1U, xn, prm.v1, 4);
			Bneg = prm.Bneg;
			splitRaw = splitRawTbl;
			return true;
		}
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(glv1ParamBLS12Tbl); i++) {
			const GLV1ParamBLS12& prm = glv1ParamBLS12Tbl[i];
			if (prm.curveType != curveType) continue;
			rw.setStr(&b, prm.rw, 16);
			if (!b) return false;
			isBLS12 = true;
			rBitSize = prm.rBitSize;
			setMpz(B[0][0], prm.L, 2, false); // for dump
			cvtU64ToUnit(LU, rawN, prm.L, 2);
			cvtU64ToUnit(qU, rawN, prm.q, 2);
			splitRaw = splitRawBLS12;
			return true;
		}
		return false;
	}
};

// rw = 1 / w = (-1 - sqrt(-3)) / 2
template<class Ec> typename Ec::Fp GLV1T<Ec>::rw;
template<class Ec> size_t GLV1T<Ec>::rBitSize;
template<class Ec> mpz_class GLV1T<Ec>::v0;
template<class Ec> mpz_class GLV1T<Ec>::v1;
template<class Ec> mpz_class GLV1T<Ec>::B[2][2];
template<class Ec> bool GLV1T<Ec>::isBLS12;
template<class Ec> typename GLV1T<Ec>::SplitRawFunc GLV1T<Ec>::splitRaw;
template<class Ec> Unit GLV1T<Ec>::v0U[GLV1T<Ec>::xn];
template<class Ec> Unit GLV1T<Ec>::v1U[GLV1T<Ec>::xn];
template<class Ec> Unit GLV1T<Ec>::BU[2][2][GLV1T<Ec>::bn];
template<class Ec> uint32_t GLV1T<Ec>::Bneg;
template<class Ec> Unit GLV1T<Ec>::LU[GLV1T<Ec>::rawN];
template<class Ec> Unit GLV1T<Ec>::qU[GLV1T<Ec>::rawN];

/*
	Software implementation of Attribute-Based Encryption: Appendixes
	GLV for G1 on BN/BLS12
*/
struct GLV1 : GLV1T<G1> {
	static void init(const mpz_class& z, bool isBLS12, int curveType)
	{
		GLV1::isBLS12 = isBLS12;
		splitRaw = 0;
		if (useParamTbl(curveType)) return;
		bool b = Fp::squareRoot(rw, -3);
		assert(b);
		(void)b;
		rw = -(rw + 1) / 2;
		rBitSize = Fr::getOp().bitSize;
		if (isBLS12) {
			/*
				BLS12
				L = z^4
				(-z^2+1) + L = 0
				1 + z^2 L = 0
			*/
			// only B[0][0] and v0 are used
			const mpz_class& r = Fr::getOp().mp;
			B[0][0] = z * z - 1; // L
			v0 = (B[0][0] << rBitSize) / r;
		} else {
			/*
				BN
				L = 36z^4 - 1
				(6z^2+2z) - (2z+1)   L = 0
				(-2z-1) - (6z^2+4z+1)L = 0
			*/
			B[0][0] = 6 * z * z + 2 * z;
			B[0][1] = -2 * z - 1;
			B[1][0] = -2 * z - 1;
			B[1][1] = -6 * z * z - 4 * z - 1;
			// [v0 v1] = [r 0] * B^(-1)
			const mpz_class& r = Fr::getOp().mp;
			v0 = ((-B[1][1]) << rBitSize) / r;
			v1 = ((B[1][0]) << rBitSize) / r;
		}
	}
};

/*
	GLV method for G2 and GT on BN/BLS12
*/
struct GLV2 {
	static const int splitN = 4;
	static size_t rBitSize;
	static mpz_class B[4][4];
	static mpz_class v[4];
	static mpz_class z;
	static mpz_class abs_z;
	static bool isBLS12;
	static void init(const mpz_class& z, bool isBLS12 = false)
	{
		const mpz_class& r = Fr::getOp().mp;
		GLV2::z = z;
		GLV2::abs_z = z < 0 ? -z : z;
		GLV2::isBLS12 = isBLS12;
		rBitSize = Fr::getOp().bitSize;
		rBitSize = (rBitSize + mcl::UnitBitSize - 1) & ~(mcl::UnitBitSize - 1);// a little better size
		mpz_class z2p1 = z * 2 + 1;
		B[0][0] = z + 1;
		B[0][1] = z;
		B[0][2] = z;
		B[0][3] = -2 * z;
		B[1][0] = z2p1;
		B[1][1] = -z;
		B[1][2] = -(z + 1);
		B[1][3] = -z;
		B[2][0] = 2 * z;
		B[2][1] = z2p1;
		B[2][2] = z2p1;
		B[2][3] = z2p1;
		B[3][0] = z - 1;
		B[3][1] = 2 * z2p1;
		B[3][2] =  -2 * z + 1;
		B[3][3] = z - 1;
		/*
			v[] = [r 0 0 0] * B^(-1) = [2z^2+3z+1, 12z^3+8z^2+z, 6z^3+4z^2+z, -(2z+1)]
		*/
		const char *zBN254 = "-4080000000000001";
		mpz_class t;
		bool b;
		mcl::gmp::setStr(&b, t, zBN254, 16);
		assert(b);
		(void)b;
		if (z == t) {
			static const char *vTblBN254[] = {
				"e00a8e7f56e007e5b09fe7fdf43ba998",
				"-152aff56a8054abf9da75db2da3d6885101e5fd3997d41cb1",
				"-a957fab5402a55fced3aed96d1eb44295f40f136ee84e09b",
				"-e00a8e7f56e007e929d7b2667ea6f29c",
			};
			for (int i = 0; i < 4; i++) {
				mcl::gmp::setStr(&b, v[i], vTblBN254[i], 16);
				assert(b);
				(void)b;
			}
		} else {
			v[0] = ((1 + z * (3 + z * 2)) << rBitSize) / r;
			v[1] = ((z * (1 + z * (8 + z * 12))) << rBitSize) / r;
			v[2] = ((z * (1 + z * (4 + z * 6))) << rBitSize) / r;
			v[3] = -((z * (1 + z * 2)) << rBitSize) / r;
		}
	}
	/*
		u[] = [x, 0, 0, 0] - v[] * x * B
	*/
	// x[Fr::getUnitSize()] < r
	static void split(mpz_class u[4], const Unit *_x)
	{
		const fp::Op& op = Fr::getOp();
		assert(bint::cmpLtN(_x, op.p, op.N)); // _x < r
		mpz_class x;
		bool ok;
		gmp::setArray(&ok, x, _x, op.N);
		assert(ok);
		(void)ok;
		if (isBLS12) {
			/*
				Frob(P) = zP
				x = u[0] + u[1] z + u[2] z^2 + u[3] z^3
			*/
			bool isNeg = false;
			mpz_class t = x;
			if (t < 0) {
				t = -t;
				isNeg = true;
			}
			for (int i = 0; i < 4; i++) {
				// t = t / abs_z, u[i] = t % abs_z
				mcl::gmp::divmod(t, u[i], t, abs_z);
				if (((z < 0) && (i & 1)) ^ isNeg) {
					u[i] = -u[i];
				}
			}
			return;
		}
		// BN
		mpz_class t[4];
		for (int i = 0; i < 4; i++) {
			t[i] = (x * v[i]) >> rBitSize;
		}
		for (int i = 0; i < 4; i++) {
			u[i] = (i == 0) ? x : 0;
			for (int j = 0; j < 4; j++) {
				u[i] -= t[j] * B[j][i];
			}
		}
	}
	template<class T>
	static void mulLambda(T& Q, const T& P)
	{
		Frobenius(Q, P);
	}
};

size_t GLV2::rBitSize = 0;
mpz_class GLV2::B[4][4];
mpz_class GLV2::v[4];
mpz_class GLV2::z;
mpz_class GLV2::abs_z;
bool GLV2::isBLS12 = false;

#endif

} // mcl
