#pragma once

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
	// the max byte size of the bucket table 2^(b-1) * sizeof(G) of mulVecCore (the random access to tbl[k] misses the cache
	// beyond L2) : it bounds the window size b for large n instead of a cache term of the cost model (see glvGetBucketSizeByCost)
	#define MCL_MSM_MAX_TBL_BYTES (size_t(2) << 20)
#endif

/*
	cost model of the bucket method (mulVecCore) for n (split) scalars of maxBitSize bits with the window size b :
	the number of windows winN = ceil(maxBitSize / b), B = 2^(b-1) buckets (signed digits), and per window
	  (n - #nonempty buckets) bucket additions (cost 1 each) + B reductions (cost r each : sum += tbl[k], win += sum)
	  + a fixed cost c0 (doublings, the sort and the inversions of the batch affine addition, etc.)
	The weights are in units of 1/64 of a bucket addition and depend on the mode (the generic Jacobian addition,
	the batch affine addition, the SIMD kernel), not on the curve (the ratios of the field operations are the same).
	The expected number of nonempty buckets is B (1 - (1 - 1/B)^n).
	The weights are fitted by misc/fit_msm.py on the sweep of b by misc/msm_sweep.cpp (see memo 2026-11-04).
*/
struct MsmCostParam {
	int32_t r;
	int32_t c0;
};
inline uint64_t glvCostModel(size_t n, size_t b, size_t maxBitSize, const MsmCostParam& prm)
{
	const uint64_t winN = (maxBitSize + b - 1) / b;
	const uint64_t B = uint64_t(1) << (b - 1);
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
	int64_t cost = int64_t(adds) * 64 + int64_t(B) * prm.r + prm.c0;
	if (cost < 0) cost = 0;
	return winN * uint64_t(cost);
}
/*
	argmin_b glvCostModel for b in [2, bMax] where 2^(bMax-1) * pointSize <= MCL_MSM_MAX_TBL_BYTES (bMax <= 16)
	pointSize : sizeof(G) of the bucket table
*/
inline size_t glvGetBucketSizeByCost(size_t n, size_t maxBitSize, size_t pointSize, const MsmCostParam& prm)
{
	size_t bMax = 2;
	while (bMax < 16 && (size_t(1) << bMax) * pointSize <= MCL_MSM_MAX_TBL_BYTES) bMax++;
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
	the weights fitted on Xeon w9-3495X (BLS12-381 and BN254 G1 together, n <= 2^16 split scalars)
	the model is within 6% of the measured best for n in [2^7, 2^18] (test/glv_test.cpp)
*/
// the generic Jacobian mixed addition : r = 2.22, c0 = -12.2
inline const MsmCostParam& msmCostParamGeneric() { static const MsmCostParam prm = { 142, -778 }; return prm; }
// the batch affine addition : r = 2.88, c0 = 28.3 (the cheaper bucket addition makes the reduction relatively expensive)
inline const MsmCostParam& msmCostParamBatch() { static const MsmCostParam prm = { 184, 1813 }; return prm; }

#ifndef MCL_GLV_ONLY_FUNC

#ifndef MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC
	// use (1 << b) * sizeof(G) bytes stack + alpha
	// b = glvGetBucketSizeByCost(n, ...) <= 8 for n <= 1024 : about 36KiB (G1) or 72KiB (G2)
	// you can decrease this value but this algorithm is slow if n < 256
	#define MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC 1024
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
#ifndef MCL_MSM_BATCH_MIN_N
	// use the batch affine addition if the number of (split) scalars >= MCL_MSM_BATCH_MIN_N
	// the batch affine addition is faster than the Jacobi mixed addition from about 90 (BLS12-381) to 170 (BN254) split scalars on x64 (the fixed cost of the inversions),
	// and from about 64 on wasm (the inversion is cheap)
	#define MCL_MSM_BATCH_MIN_N 128
#endif
#ifndef MCL_MSM_BATCH_CHUNK
	// the number of entries folded at once (the work array S has this number of points)
	#define MCL_MSM_BATCH_CHUNK 8192
#endif
#ifndef MCL_MSM_BATCH_SUB
	// the number of pairs sharing one inversion
	#define MCL_MSM_BATCH_SUB 512
#endif

namespace local {

/*
	R[j] = P(ia[j]) + P(ib[j]) for j in [0, m)
	where P(i) = (i & msmSign) ? -base[i & msmIdxMask] : base[i & msmIdxMask] and P(msmNone) = 0
	base[*] must be affine (z = 1) or zero (z = 0), then R[j] is affine or zero
	R may overlap base if &R[j] <= &base[ia[j] & msmIdxMask], &base[ib[j] & msmIdxMask] for all j
	(the inputs of the j-th pair are read before R[j] is written and R[0], R[1], ... are written in this order)
	work : Fp[3 * MCL_MSM_BATCH_SUB]
	cost : 5M + 1S + inv/MCL_MSM_BATCH_SUB per pair
*/
template<class G>
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
	static void addPairs(void *R, const void *base, const uint32_t *ia, const uint32_t *ib, size_t m, void *work)
	{
		addAffineBatch((G*)R, (const G*)base, ia, ib, m, (typename G::Fp*)work);
	}
	static void addToBucket(void *tbl, const void *base, uint32_t i)
	{
		msmAddToBucket(*(G*)tbl, (const G*)base, i);
	}
	static void set(ec::MsmKernel& kn)
	{
		kn.pointSize = sizeof(G);
		kn.workSize = sizeof(typename G::Fp) * 3 * MCL_MSM_BATCH_SUB;
		kn.cvtBase = 0;
		kn.addPairs = addPairs;
		kn.addToBucket = addToBucket;
		kn.getBucketSize = 0;
	}
};

// work buffers for mulVecUpdateTableBatch
template<class G>
struct MsmBatchWork {
	static const size_t CHUNK = MCL_MSM_BATCH_CHUNK;
	ec::MsmKernel kn; // the kernel of the batch affine addition
	size_t chunk; // min(CHUNK, n) : the max number of the entries of idx processed at once (the fixed cost of the buffers is small for small n)
	uint32_t *D; // [n] (bucket | sign) of each scalar
	uint32_t *idx; // [n] the indexes of the scalars sorted by bucket
	uint32_t *off; // [tblN + 1] the offset of each bucket in idx
	uint32_t *ia; // [chunk] the pairs of the current level
	uint32_t *ib; // [chunk]
	MsmPart *part[2]; // [chunk + 1] the parts (a bucket in the chunk) of the current and next level
	void *S; // [chunk * kn.pointSize] the work array of the points (64-byte aligned)
	void *work; // [kn.workSize] the work area of kn.addPairs (64-byte aligned)
	void *base; // [n * kn.pointSize] xVec converted by kn.cvtBase (0 if kn.cvtBase == 0)
	void *buf_;
	MsmBatchWork() : buf_(0) {}
	~MsmBatchWork() { if (buf_) free(buf_); }
	// kernel : the SIMD kernel (0 : the generic one)
	bool init(size_t n, size_t tblN, const ec::MsmKernel *kernel)
	{
		if (n >= msmIdxMask) return false;
		if (kernel) {
			kn = *kernel;
		} else {
			MsmGenericKernel<G>::set(kn);
		}
		chunk = (n < CHUNK) ? n : CHUNK;
		const size_t align = 64;
		const size_t sSize = (kn.pointSize * chunk + align - 1) / align * align;
		const size_t wSize = (kn.workSize + align - 1) / align * align;
		const size_t bSize = kn.cvtBase ? (kn.pointSize * n + align - 1) / align * align : 0;
		size_t size = align + sSize + wSize + bSize;
		size += sizeof(uint32_t) * (2 * n + (tblN + 1) + 2 * chunk) + sizeof(MsmPart) * 2 * (chunk + 1);
		buf_ = malloc(size);
		if (buf_ == 0) return false;
		char *p = (char*)(((uintptr_t)buf_ + align - 1) & ~(uintptr_t)(align - 1));
		S = p; p += sSize;
		work = p; p += wSize;
		base = kn.cvtBase ? p : 0; p += bSize;
		D = (uint32_t*)p; p += sizeof(uint32_t) * n;
		idx = (uint32_t*)p; p += sizeof(uint32_t) * n;
		off = (uint32_t*)p; p += sizeof(uint32_t) * (tblN + 1);
		ia = (uint32_t*)p; p += sizeof(uint32_t) * chunk;
		ib = (uint32_t*)p; p += sizeof(uint32_t) * chunk;
		part[0] = (MsmPart*)p; p += sizeof(MsmPart) * (chunk + 1);
		part[1] = (MsmPart*)p;
		return true;
	}
};

// the batch affine addition is available only for EcT (not for GroupMtoA)
template<class G>
struct MsmBatch {
	static const bool enabled = false;
	struct Work {
		ec::MsmKernel kn;
		void *base;
		bool init(size_t, size_t, const ec::MsmKernel *) { return false; }
	};
	static const ec::MsmKernel* getKernel() { return 0; }
};
template<class Fp>
struct MsmBatch<EcT<Fp> > {
	static const bool enabled = true;
	typedef MsmBatchWork<EcT<Fp> > Work;
	static const ec::MsmKernel* getKernel() { return EcT<Fp>::msmKernel; }
};

} // mcl::ec::local

/*
	the batch affine version of mulVecUpdateTable
	xVec[i] must be affine (z = 1) or zero
	1. D[i] = (bucket, sign) of the digit of yVec[i], off[k] = the offset of the bucket k (counting sort)
	2. idx[off[k] ...] = the indexes of the scalars whose bucket is k (with the sign bit)
	3. for each chunk of wk.chunk (= min(MCL_MSM_BATCH_CHUNK, n)) entries of idx : fold the points of each bucket by a binary tree
	   level 0 : pairs of xVec[idx[]] -> S, level >= 1 : pairs of S -> S (in place),
	   a bucket with one point is added to tbl[k] (a bucket may be split by the chunk boundary)
	   all the additions of a level are done by addAffineBatch (sharing one inversion per MCL_MSM_BATCH_SUB pairs)
	4. win (+)= tbl[0] + 2 tbl[1] + ... (tbl[k] is affine or zero, so addJacobi uses the Q.z = 1 formula)
	The number of additions is the same as mulVecUpdateTable (n - the number of non-empty buckets)
	and the batches do not degenerate even if all scalars are equal.
	base : xVec in the layout of the kernel wk.kn (xVec itself for the generic kernel)
*/
template<class G>
void mulVecUpdateTableBatch(G& win, G *tbl, size_t tblN, size_t b, const void *base, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, local::MsmBatchWork<G>& wk)
{
	using namespace local;
	const size_t CHUNK = wk.chunk;
	const ec::MsmKernel& kn = wk.kn;
	for (size_t i = 0; i < tblN; i++) {
		tbl[i].clear();
	}
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
				if (cnt == 1) {
					kn.addToBucket(&tbl[k], base, wk.idx[start]);
				} else {
					for (size_t j = 0; j + 1 < cnt; j += 2) {
						wk.ia[m] = wk.idx[start + j];
						wk.ib[m] = wk.idx[start + j + 1];
						m++;
					}
					if (cnt & 1) {
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
					kn.addToBucket(&tbl[cur[p].k], wk.S, uint32_t(start));
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
	local::mulVecReduceTable(win, tbl, tblN, first);
}

namespace local {

template<class G>
struct mulVecUpdateTableBatchT {
	template<class W>
	static void call(G&, G *, size_t, size_t, const void *, const Unit *, size_t, size_t, size_t, size_t, bool, bool, W&) {}
};
template<class Fp>
struct mulVecUpdateTableBatchT<EcT<Fp> > {
	typedef EcT<Fp> G;
	static void call(G& win, G *tbl, size_t tblN, size_t b, const void *base, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, MsmBatchWork<G>& wk)
	{
		mulVecUpdateTableBatch(win, tbl, tblN, b, base, yVec, yUnitSize, next, pos, n, first, isTop, wk);
	}
};

} // mcl::ec::local

/*
	z = sum_{i=0}^{n-1} xVec[i] * yVec[i]
	yVec[i] means yVec[i*next:(i+1)*next+yUnitSize]
	return numbers of done, which may be smaller than n if malloc fails
	@note xVec may be normlized
	fast for n >= MCL_MSM_MIN_SPLIT_N
	maxBitSize : the max bit size of yVec[i] (yUnitSize * UnitBitSize if 0)
*/
template<class G>
size_t mulVecCore(G& z, G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, size_t b, bool doNormalize, size_t maxBitSize = 0)
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
	// the batch affine addition is used if wk.init succeeds (see below)
	const bool tryBatch = local::MsmBatch<G>::enabled && n >= MCL_MSM_BATCH_MIN_N;
	const size_t bArg = b;
	if (b == 0) {
		if (tryBatch && kernel && kernel->getBucketSize) {
			b = kernel->getBucketSize(n, maxBitSize, sizeof(G));
		} else {
			b = glvGetBucketSizeByCost(n, maxBitSize, sizeof(G), tryBatch ? msmCostParamBatch() : msmCostParamGeneric());
		}
	}

#ifndef MCL_DONT_USE_MALLOC
	G *tbl_ = 0; // malloc is used if tbl_ != 0
	// if n is large then try to use malloc
	if (n > MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC) {
		tblN = size_t(1) << b;
		tbl_ = (G*)malloc(sizeof(G) * tblN);
		if (tbl_) {
			tbl = tbl_;
			goto main;
		}
	}
#endif
	// n is small or malloc fails so use stack
	if (n > MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC) {
		n = MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC;
		// recompute b for the reduced n (the generic model : the batch affine addition is not used for this n if MCL_MSM_BATCH_MIN_N > n)
		if (bArg == 0) b = glvGetBucketSizeByCost(n, maxBitSize, sizeof(G), (local::MsmBatch<G>::enabled && n >= MCL_MSM_BATCH_MIN_N) ? msmCostParamBatch() : msmCostParamGeneric());
	}
	tblN = size_t(1) << b;
	tbl = (G*)CYBOZU_ALLOCA(sizeof(G) * tblN);
	// keep tbl_ = 0
#ifndef MCL_DONT_USE_MALLOC
main:
#endif
	const size_t winN = (maxBitSize + b-1) / b;
	const size_t rem = maxBitSize - b * (winN-1); // the bit size of the top window in [1, b]

	// about 10% faster
	if (doNormalize) G::normalizeVec(xVec, xVec, n);

	// the batch affine addition requires affine (or zero) xVec, which is guaranteed by normalizeVec of the caller
	typename local::MsmBatch<G>::Work wk;
	const bool useBatch = local::MsmBatch<G>::enabled && n >= MCL_MSM_BATCH_MIN_N && wk.init(n, tblN, kernel);
	const void *base = xVec; // xVec in the layout of the kernel (converted once and shared by all the windows)
	if (useBatch && wk.base) {
		wk.kn.cvtBase(wk.base, xVec, n);
		base = wk.base;
	}
	if (useBatch) {
		local::mulVecUpdateTableBatchT<G>::call(z, tbl, size_t(1) << rem, b, base, yVec, yUnitSize, next, b * (winN-1), n, true, true, wk);
	} else {
		mulVecUpdateTable(z, tbl, size_t(1) << rem, b, xVec, yVec, yUnitSize, next, b * (winN-1), n, true, true);
	}
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < b; i++) {
			G::dbl(z, z);
		}
		if (useBatch) {
			local::mulVecUpdateTableBatchT<G>::call(z, tbl, tblN / 2, b, base, yVec, yUnitSize, next, b * (winN-1-w), n, false, false, wk);
		} else {
			mulVecUpdateTable(z, tbl, tblN / 2, b, xVec, yVec, yUnitSize, next, b * (winN-1-w), n, false, false);
		}
	}
#ifndef MCL_DONT_USE_MALLOC
	if (tbl_) free(tbl_);
#endif
	return n;
}
template<class G>
void mulVecLong(G& z, G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t n, size_t b, bool doNormalize, size_t maxBitSize = 0)
{
	size_t done = mulVecCore(z, xVec, yVec, yUnitSize, next, n, b, doNormalize, maxBitSize);
	if (done == n) return;
	do {
		xVec += done;
		yVec += next * done;
		n -= done;
		G t;
		done = mulVecCore(t, xVec, yVec, yUnitSize, next, n, b, doNormalize, maxBitSize);
		z += t;
	} while (done < n);
}

namespace local {

// the fixed-width split of GLV1T (0 if not available), see GLV1T::splitRaw
typedef uint32_t (*SplitRawFunc)(Unit *a, Unit *b, const Unit *x);
inline SplitRawFunc getSplitRaw(const void *) { return 0; }
template<class Ec>
SplitRawFunc getSplitRaw(const GLV1T<Ec> *) { return GLV1T<Ec>::splitRaw; }

} // mcl::ec::local

// the bucket method for n * splitN >= MCL_MSM_MIN_SPLIT_N
template<class GLV, class G>
bool mulVecGLVlarge(G& z, const G *xVec, const void *yVec, size_t n, size_t bucket)
{
	const int splitN = GLV::splitN;
	assert(n > 0);
	typedef Fr F;
	fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
	typedef mcl::Unit Unit;
	const size_t next = F::getUnitSize();
	mpz_class u[splitN];
	Unit y[F::maxSize];

	const size_t tblByteSize = sizeof(G) * splitN * n;
	const size_t ypByteSize = sizeof(Unit) * next * splitN * n;
	G *tbl = (G*)malloc(tblByteSize + ypByteSize);
	if (tbl == 0) return false;

	Unit *yp = (Unit *)(tbl + splitN * n);

	G::normalizeVec(tbl, xVec, n);
	for (int i = 1; i < splitN; i++) {
		for (size_t j = 0; j < n; j++) {
			GLV::mulLambda(tbl[i * n + j], tbl[(i - 1) * n + j]);
		}
	}
	size_t maxBitSize = 0; // of the split scalars (about 128 bits for G1 of BN / BLS12)
	// the fixed-width split (no mpz) if available
	const local::SplitRawFunc splitRaw = (splitN == 2) ? local::getSplitRaw((const GLV*)0) : 0;
	const size_t rawN = 128 / UnitBitSize; // the size of a, b of splitRaw
	assert(next >= rawN);
	for (size_t i = 0; i < n; i++) {
		getUnitAt(y, yVec, i);
		if (splitRaw) {
			Unit *ya = &yp[i * next];
			Unit *yb = &yp[(n + i) * next];
			const uint32_t neg = splitRaw(ya, yb, y);
			for (size_t k = rawN; k < next; k++) {
				ya[k] = 0;
				yb[k] = 0;
			}
			if (neg & 1) G::neg(tbl[i], tbl[i]);
			if (neg & 2) G::neg(tbl[n + i], tbl[n + i]);
			size_t bitSize = fp::getBitSize(ya, rawN);
			if (bitSize > maxBitSize) maxBitSize = bitSize;
			bitSize = fp::getBitSize(yb, rawN);
			if (bitSize > maxBitSize) maxBitSize = bitSize;
			continue;
		}
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
		mulVecLong(z, tbl, yp, yUnitSize, next, n * splitN, bucket, false, maxBitSize);
	}
	free(tbl);
	return true;
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
	typedef Fr F;
	fp::getUnitAtType getUnitAt = fp::getUnitAtT<F>;
	typedef mcl::FixedArray<int8_t, sizeof(Fr) * 8 / splitN + splitN> NafArray;
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
	typedef Fr F;
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
bool mulVecGLVT(G& z, const G *xVec, const void *yVec, size_t n, bool constTime = false, size_t b = 0)
{
	if (n == 1 && constTime) {
		mulGLV_CT<GLV, G>(z, xVec[0], yVec);
		return true;
	}
	if (n <= mcl::fp::maxMulVecNGLV) {
		mulVecGLVsmall<GLV, G, 5>(z, xVec, yVec, n);
		return true;
	}
	if (n * GLV::splitN >= MCL_MSM_MIN_SPLIT_N) {
		return mulVecGLVlarge<GLV, G>(z, xVec, yVec, n, b);
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
