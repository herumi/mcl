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
	measured on Xeon w9-3495X with BN254 / BLS12-381 G1 (signed digits, 2^(b-1) buckets);
	for n in [2^18, 2^21) the differences are small and b = 13 (2^12 buckets fit in L2) is preferred,
	for n >= 2^21 b = 16 (8 windows for the 128-bit split scalars) is the best for BLS12-381
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
		3, 6, 8, 8, 9, 10, 11, 12, 13, 13, 13, 13, 13, 16, 16
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
template<class G>
void mulVecUpdateTable(G& win, G *tbl, size_t tblN, size_t b, const G *xVec, const Unit *yVec, size_t yUnitSize, size_t next, size_t pos, size_t n, bool first, bool isTop)
{
	for (size_t i = 0; i < tblN; i++) {
		tbl[i].clear();
	}
	const size_t full = size_t(1) << b;
	const Unit mask = Unit(full - 1);
	for (size_t i = 0; i < n; i++) {
		const Unit *y = yVec + next * i;
		const size_t v = size_t(fp::getUnitAt(y, yUnitSize, pos) & mask);
		const size_t c = pos > 0 ? size_t(fp::getUnitAt(y, yUnitSize, pos - 1) & 1) : 0;
		if (isTop || v < full / 2) {
			const size_t d = v + c; // d <= 2^(b-1) (<= 2^rem if isTop)
			assert(d <= tblN);
			if (d) tbl[d - 1] += xVec[i];
		} else {
			const size_t d = full - v - c; // d <= 2^(b-1)
			if (d) G::sub(tbl[d - 1], tbl[d - 1], xVec[i]);
		}
	}
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

	mulVecUpdateTable(z, tbl, size_t(1) << rem, b, xVec, yVec, yUnitSize, next, b * (winN-1), n, true, true);
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < b; i++) {
			G::dbl(z, z);
		}
		mulVecUpdateTable(z, tbl, tblN / 2, b, xVec, yVec, yUnitSize, next, b * (winN-1-w), n, false, false);
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
