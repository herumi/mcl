#pragma once

namespace mcl {

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
	return heuristic backet size which is faster than glvGetTheoreticBucketSize
	n : the number of (split) scalars (= 2 * the number of G1 points of BN / BLS12 by GLV)
	measured on Xeon w9-3495X with BN254 / BLS12-381 G1 (signed digits, 2^(b-1) buckets,
	batch affine addition for n >= MCL_MSM_BATCH_MIN_N);
	the batch affine addition makes the bucket addition cheaper, so the bucket reduction (2^b additions per window)
	is relatively expensive and b is smaller than before for n < 2^16.
	for n in [2^16, 2^19) b = 13 (2^12 buckets fit in L2) is the best, b = 15 for n in [2^19, 2^20),
	for n >= 2^20 b = 16 (8 windows for the 128-bit split scalars) is the best
*/
inline size_t glvGetBucketSize(size_t n)
{
	if (n <= 2) return 2;
	size_t log2n = ilog2(n);
	const size_t tblMin = 8;
	if (log2n < tblMin) return 3;
	// n >= 2^tblMin
	static const size_t tbl[] = {
	//  log2n = 8  9  10 11 12 13  14  15  16  17  18  19  20  21  22
		3, 6, 7, 8, 8, 10, 10, 11, 12, 13, 13, 13, 15, 16, 16
	};
	if (log2n >= CYBOZU_NUM_OF_ARRAY(tbl) + tblMin) return 16;
	size_t ret = tbl[log2n - tblMin];
	return ret;
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

/*
	split x in [0, r-1] to (a, b) such that x = a + b L, 0 <= a < L, 0 <= b <= L+1
	a[] : 128 bit
	b[] : 128 bit
	x[] : 256 bit
*/
inline void optimizedSplitForBLS12_381(Unit *a, Unit *b, const Unit *x)
{
	/*
		z = -0xd201000000010000
		L = z^2-1 = 0xac45a4010001a40200000000ffffffff
		s=255
		q = (1<<s)//L = 0xbe35f678f00fd56eb1fb72917b67f718
		H = 1<<128
	*/
	static const Unit L[] = { MCL_U64_TO_UNIT(0x00000000ffffffff), MCL_U64_TO_UNIT(0xac45a4010001a402) };
	static const Unit q[] = { MCL_U64_TO_UNIT(0xb1fb72917b67f718), MCL_U64_TO_UNIT(0xbe35f678f00fd56e) };
	static const Unit one[] = { MCL_U64_TO_UNIT(1), MCL_U64_TO_UNIT(0) };
	static const size_t n = 128 / mcl::UnitBitSize;
	Unit xH[n+1]; // x = xH * (H/2) + xL
	mcl::bint::shrT<n+1>(xH, x+n-1, mcl::UnitBitSize-1); // >>127
	Unit t[n*2];
	mcl::bint::mulT<n>(t, xH, q);
	mcl::bint::copyT<n>(b, t+n); // (xH * q)/H
	mcl::bint::mulT<n>(t, b, L); // bL
	mcl::bint::subT<n*2>(t, x, t); // x - bL
	Unit d = mcl::bint::subT<n>(a, t, L);
	if (t[n] - d == 0) {
		mcl::bint::addT<n>(b, b, one);
	} else {
		mcl::bint::copyT<n>(a, t);
	}
}

inline void optimizedSplitForBLS12_377(Unit *a, Unit *b, const Unit *x)
{
	/*
		z = -0xd201000000010000
		L = z^2-1 = 0x452217cc900000010a11800000000000
		s=254
		q = (1<<s)//L = 0xecfdeaa5a7f4dc581fdcbb4cabe4060b
		H = 1<<128
	*/
	static const Unit L[] = { MCL_U64_TO_UNIT(0x0a11800000000000), MCL_U64_TO_UNIT(0x452217cc90000001) };
	static const Unit q[] = { MCL_U64_TO_UNIT(0x1fdcbb4cabe4060b), MCL_U64_TO_UNIT(0xecfdeaa5a7f4dc58) };
	static const Unit one[] = { MCL_U64_TO_UNIT(1), MCL_U64_TO_UNIT(0) };
	static const size_t n = 128 / mcl::UnitBitSize;
	Unit xH[n+1]; // x = xH * (H/4) + xL
	mcl::bint::shrT<n+1>(xH, x+n-1, mcl::UnitBitSize-2); // >>126
	Unit t[n*2];
	mcl::bint::mulT<n>(t, xH, q);
	mcl::bint::copyT<n>(b, t+n); // (xH * q)/H
	mcl::bint::mulT<n>(t, b, L); // bL
	mcl::bint::subT<n*2>(t, x, t); // x - bL
	Unit d = mcl::bint::subT<n>(a, t, L);
	if (d == 0) {
		mcl::bint::addT<n>(b, b, one);
	} else {
		mcl::bint::copyT<n>(a, t);
	}
}

#ifndef MCL_GLV_ONLY_FUNC

#ifndef MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC
	// use (1 << glvGetBucketSize(n)) * sizeof(G) bytes stack + alpha
	// (1 << b) * sizeof(G) bytes with b = glvGetBucketSize(n) <= 8 : about 24KiB (G1) or 48KiB (G2) for n = 1024
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

const uint32_t msmSign = uint32_t(1) << 31; // the sign bit of a digit or an index
const uint32_t msmIdxMask = msmSign - 1;
const uint32_t msmNone = uint32_t(-1); // d = 0 (no bucket) or no point

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
#ifndef MCL_MSM_BATCH_MIN_N
	// use the batch affine addition if the number of (split) scalars >= MCL_MSM_BATCH_MIN_N
	#define MCL_MSM_BATCH_MIN_N 256
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
/*
	d[j] = 1/d[j] for j in [0, m) by the Montgomery trick (d[j] != 0), prod : F[m]
	K independent product chains are interleaved to hide the latency of mul
*/
template<class F>
void invBatch(F *d, F *prod, size_t m)
{
	const size_t K = 4;
	if (m < 2 * K) {
		prod[0] = d[0];
		for (size_t j = 1; j < m; j++) {
			F::mul(prod[j], prod[j - 1], d[j]);
		}
		F inv;
		F::inv(inv, prod[m - 1]);
		for (size_t j = m - 1; j > 0; j--) {
			F t;
			F::mul(t, inv, prod[j - 1]);
			F::mul(inv, inv, d[j]);
			d[j] = t;
		}
		d[0] = inv;
		return;
	}
	// chain c = d[c] d[c+K] d[c+2K] ...
	for (size_t c = 0; c < K; c++) prod[c] = d[c];
	for (size_t j = K; j < m; j++) {
		F::mul(prod[j], prod[j - K], d[j]);
	}
	// invert the K products of the chains
	size_t last[K];
	F q[K];
	for (size_t c = 0; c < K; c++) {
		last[c] = (m - 1 - c) / K * K + c;
		if (c == 0) {
			q[0] = prod[last[0]];
		} else {
			F::mul(q[c], q[c - 1], prod[last[c]]);
		}
	}
	F inv;
	F::inv(inv, q[K - 1]);
	F ic[K]; // ic[c] = the inverse of the product of chain c
	for (size_t c = K - 1; c > 0; c--) {
		F::mul(ic[c], inv, q[c - 1]);
		F::mul(inv, inv, prod[last[c]]);
	}
	ic[0] = inv;
	for (size_t j = m - 1; j >= K; j--) {
		const size_t c = j % K;
		F t;
		F::mul(t, ic[c], prod[j - K]);
		F::mul(ic[c], ic[c], d[j]);
		d[j] = t;
	}
	for (size_t c = 0; c < K; c++) d[c] = ic[c];
}

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
		invBatch(d, prod, mm);
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

// work buffers for mulVecUpdateTableBatch
template<class G>
struct MsmBatchWork {
	typedef typename G::Fp F;
	static const size_t CHUNK = MCL_MSM_BATCH_CHUNK;
	uint32_t *D; // [n] (bucket | sign) of each scalar
	uint32_t *idx; // [n] the indexes of the scalars sorted by bucket
	uint32_t *off; // [tblN + 1] the offset of each bucket in idx
	uint32_t *ia; // [CHUNK] the pairs of the current level
	uint32_t *ib; // [CHUNK]
	MsmPart *part[2]; // [CHUNK + 1] the parts (a bucket in the chunk) of the current and next level
	G *S; // [CHUNK] the work array of the points
	F *fwork; // [3 * MCL_MSM_BATCH_SUB]
	void *buf_;
	MsmBatchWork() : buf_(0) {}
	~MsmBatchWork() { if (buf_) free(buf_); }
	bool init(size_t n, size_t tblN)
	{
		if (n >= msmIdxMask) return false;
		const size_t fwSize = 3 * MCL_MSM_BATCH_SUB;
		size_t size = sizeof(G) * CHUNK + sizeof(F) * fwSize;
		size += sizeof(uint32_t) * (2 * n + (tblN + 1) + 2 * CHUNK) + sizeof(MsmPart) * 2 * (CHUNK + 1);
		buf_ = malloc(size);
		if (buf_ == 0) return false;
		char *p = (char*)buf_;
		S = (G*)p; p += sizeof(G) * CHUNK;
		fwork = (F*)p; p += sizeof(F) * fwSize;
		D = (uint32_t*)p; p += sizeof(uint32_t) * n;
		idx = (uint32_t*)p; p += sizeof(uint32_t) * n;
		off = (uint32_t*)p; p += sizeof(uint32_t) * (tblN + 1);
		ia = (uint32_t*)p; p += sizeof(uint32_t) * CHUNK;
		ib = (uint32_t*)p; p += sizeof(uint32_t) * CHUNK;
		part[0] = (MsmPart*)p; p += sizeof(MsmPart) * (CHUNK + 1);
		part[1] = (MsmPart*)p;
		return true;
	}
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

// the batch affine addition is available only for EcT (not for GroupMtoA)
template<class G>
struct MsmBatch {
	static const bool enabled = false;
	struct Work {
		bool init(size_t, size_t) { return false; }
	};
};
template<class Fp>
struct MsmBatch<EcT<Fp> > {
	static const bool enabled = true;
	typedef MsmBatchWork<EcT<Fp> > Work;
};

} // mcl::ec::local

/*
	the batch affine version of mulVecUpdateTable
	xVec[i] must be affine (z = 1) or zero
	1. D[i] = (bucket, sign) of the digit of yVec[i], off[k] = the offset of the bucket k (counting sort)
	2. idx[off[k] ...] = the indexes of the scalars whose bucket is k (with the sign bit)
	3. for each chunk of CHUNK entries of idx : fold the points of each bucket by a binary tree
	   level 0 : pairs of xVec[idx[]] -> S, level >= 1 : pairs of S -> S (in place),
	   a bucket with one point is added to tbl[k] (a bucket may be split by the chunk boundary)
	   all the additions of a level are done by addAffineBatch (sharing one inversion per MCL_MSM_BATCH_SUB pairs)
	4. win (+)= tbl[0] + 2 tbl[1] + ... (tbl[k] is affine or zero, so addJacobi uses the Q.z = 1 formula)
	The number of additions is the same as mulVecUpdateTable (n - the number of non-empty buckets)
	and the batches do not degenerate even if all scalars are equal.
*/
template<class G>
void mulVecUpdateTableBatch(G& win, G *tbl, size_t tblN, size_t b, const G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, local::MsmBatchWork<G>& wk)
{
	using namespace local;
	const size_t CHUNK = MsmBatchWork<G>::CHUNK;
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
					msmAddToBucket(tbl[k], xVec, wk.idx[start]);
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
		addAffineBatch(wk.S, xVec, wk.ia, wk.ib, m, wk.fwork);
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
					msmAddToBucket(tbl[cur[p].k], wk.S, uint32_t(start));
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
			if (m > 0) addAffineBatch(wk.S, wk.S, wk.ia, wk.ib, m, wk.fwork);
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
	static void call(G&, G *, size_t, size_t, const G *, const Unit *, size_t, size_t, size_t, size_t, bool, bool, W&) {}
};
template<class Fp>
struct mulVecUpdateTableBatchT<EcT<Fp> > {
	typedef EcT<Fp> G;
	static void call(G& win, G *tbl, size_t tblN, size_t b, const G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop, MsmBatchWork<G>& wk)
	{
		mulVecUpdateTableBatch(win, tbl, tblN, b, xVec, yVec, yUnitSize, next, pos, n, first, isTop, wk);
	}
};

} // mcl::ec::local

/*
	z = sum_{i=0}^{n-1} xVec[i] * yVec[i]
	yVec[i] means yVec[i*next:(i+1)*next+yUnitSize]
	return numbers of done, which may be smaller than n if malloc fails
	@note xVec may be normlized
	fast for n >= 256
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

#ifndef MCL_DONT_USE_MALLOC
	G *tbl_ = 0; // malloc is used if tbl_ != 0
	// if n is large then try to use malloc
	if (n > MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC) {
		if (b == 0) b = glvGetBucketSize(n);
		tblN = size_t(1) << b;
		tbl_ = (G*)malloc(sizeof(G) * tblN);
		if (tbl_) {
			tbl = tbl_;
			goto main;
		}
	}
#endif
	// n is small or malloc fails so use stack
	if (n > MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC) n = MCL_MAX_N_TO_USE_STACK_FOR_MUL_VEC;
	if (b == 0) b = glvGetBucketSize(n);
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
	const bool useBatch = local::MsmBatch<G>::enabled && n >= MCL_MSM_BATCH_MIN_N && wk.init(n, tblN);
	if (useBatch) {
		local::mulVecUpdateTableBatchT<G>::call(z, tbl, size_t(1) << rem, b, xVec, yVec, yUnitSize, next, b * (winN-1), n, true, true, wk);
	} else {
		mulVecUpdateTable(z, tbl, size_t(1) << rem, b, xVec, yVec, yUnitSize, next, b * (winN-1), n, true, true);
	}
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < b; i++) {
			G::dbl(z, z);
		}
		if (useBatch) {
			local::mulVecUpdateTableBatchT<G>::call(z, tbl, tblN / 2, b, xVec, yVec, yUnitSize, next, b * (winN-1-w), n, false, false, wk);
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

// for n >= 128
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
	for (size_t i = 0; i < n; i++) {
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
	if (n >= 128) {
		return mulVecGLVlarge<GLV, G>(z, xVec, yVec, n, b);
	}
	return false;
}

#endif

} // mcl::ec

#ifndef MCL_GLV_ONLY_FUNC

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
	static void (*optimizedSplit)(Unit *a, Unit *b, const Unit *x); // for BLS12-381/377
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
		if (optimizedSplit) {
			static const size_t n = 128 / mcl::UnitBitSize;
			Unit a[n], b[n];
			optimizedSplit(a, b, _x);
			gmp::setArray(&ok, u[0], a, n);
			assert(ok);
			gmp::setArray(&ok, u[1], b, n);
			assert(ok);
			(void)ok;
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
		init() is defined in bn.hpp
	*/
	static void initForSecp256k1()
	{
		bool b = Fp::squareRoot(rw, -3);
		assert(b);
		(void)b;
		rw = -(rw + 1) / 2;
		rBitSize = Fr::getOp().bitSize;
		rBitSize = (rBitSize + UnitBitSize - 1) & ~(UnitBitSize - 1);
		gmp::setStr(&b, B[0][0], "0x3086d221a7d46bcde86c90e49284eb15");
		assert(b); (void)b;
		gmp::setStr(&b, B[0][1], "-0xe4437ed6010e88286f547fa90abfe4c3");
		assert(b); (void)b;
		gmp::setStr(&b, B[1][0], "0x114ca50f7a8e2f3f657c1108d9d44cfd8");
		assert(b); (void)b;
		B[1][1] = B[0][0];
		const mpz_class& r = Fr::getOp().mp;
		v0 = ((B[1][1]) << rBitSize) / r;
		v1 = ((-B[0][1]) << rBitSize) / r;
		isBLS12 = false;
		optimizedSplit = 0;
	}
};

// rw = 1 / w = (-1 - sqrt(-3)) / 2
template<class Ec> typename Ec::Fp GLV1T<Ec>::rw;
template<class Ec> size_t GLV1T<Ec>::rBitSize;
template<class Ec> mpz_class GLV1T<Ec>::v0;
template<class Ec> mpz_class GLV1T<Ec>::v1;
template<class Ec> mpz_class GLV1T<Ec>::B[2][2];
template<class Ec> bool GLV1T<Ec>::isBLS12;
template<class Ec> void (*GLV1T<Ec>::optimizedSplit)(Unit *a, Unit *b, const Unit *x);

/*
	Software implementation of Attribute-Based Encryption: Appendixes
	GLV for G1 on BN/BLS12
*/
struct GLV1 : GLV1T<G1> {
	static bool usePrecomputedTable(int curveType)
	{
		if (curveType < 0) return false;
		const struct Tbl {
			int curveType;
			const char *rw;
			size_t rBitSize;
			const char *v0, *v1;
			const char *B[2][2];
		} tbl[] = {
			{
				MCL_BN254,
				"49b36240000000024909000000000006cd80000000000007",
				256,
				"2a01fab7e04a017b9c0eb31ff36bf3357",
				"37937ca688a6b4904",
				{
					{
						"61818000000000028500000000000004",
						"8100000000000001",
					},
					{
						"8100000000000001",
						"-61818000000000020400000000000003",
					},
				},
			},
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			if (tbl[i].curveType != curveType) continue;
			bool b;
			rw.setStr(&b, tbl[i].rw, 16); if (!b) continue;
			rBitSize = tbl[i].rBitSize;
			gmp::setStr(&b, v0, tbl[i].v0, 16); if (!b) continue;
			gmp::setStr(&b, v1, tbl[i].v1, 16); if (!b) continue;
			gmp::setStr(&b, B[0][0], tbl[i].B[0][0], 16); if (!b) continue;
			gmp::setStr(&b, B[0][1], tbl[i].B[0][1], 16); if (!b) continue;
			gmp::setStr(&b, B[1][0], tbl[i].B[1][0], 16); if (!b) continue;
			gmp::setStr(&b, B[1][1], tbl[i].B[1][1], 16); if (!b) continue;
			return true;
		}
		return false;
	}
	static void init(const mpz_class& z, bool isBLS12, int curveType)
	{
		GLV1::isBLS12 = isBLS12;
		optimizedSplit = 0;
		if (usePrecomputedTable(curveType)) return;
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
			if (curveType == BLS12_381.curveType) {
				optimizedSplit = ec::optimizedSplitForBLS12_381;
			} else if (curveType == BLS12_377.curveType) {
				optimizedSplit = ec::optimizedSplitForBLS12_377;
			}
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
