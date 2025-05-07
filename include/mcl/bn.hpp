#pragma once
/**
	@file
	@brief optimal ate pairing over BN-curve / BLS12-curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/g1_def.hpp>
#include <mcl/g2_def.hpp>
#include <mcl/curve_type.hpp>
#include <assert.h>
#ifndef CYBOZU_DONT_USE_EXCEPTION
#include <vector>
#endif

#ifdef MCL_USE_OMP
#include <omp.h>
#endif

namespace mcl {

#ifndef MCL_MSM
  #if (/*defined(_WIN64) ||*/ defined(__x86_64__)) && !defined(__APPLE__) && (MCL_SIZEOF_UNIT == 8)
    #define MCL_MSM 1
  #else
    #define MCL_MSM 0
  #endif
#endif

#if MCL_MSM == 1
namespace msm {

// only for BLS12-381
struct FrA {
	uint64_t v[4];
};

struct FpA {
	uint64_t v[6];
};

struct G1A {
	uint64_t v[6*3];
};

typedef size_t (*invVecFpFunc)(Fp *y, const Fp *x, size_t n, size_t _N);
typedef void (*normalizeVecG1Func)(G1A *y, const G1A *x, size_t n);
typedef void (*addG1Func)(G1A& z, const G1A& x, const G1A& y);
typedef void (*dblG1Func)(G1A& z, const G1A& x);
typedef void (*mulG1Func)(G1A& z, const G1A& x, const FrA& y, bool constTime);
typedef void (*clearG1Func)(G1A& z);

struct Func {
	const mcl::fp::Op *fp;
	const mcl::fp::Op *fr;
	invVecFpFunc invVecFp;
	normalizeVecG1Func normalizeVecG1;
	addG1Func addG1;
	dblG1Func dblG1;
	mulG1Func mulG1;
	clearG1Func clearG1;
};


bool initMsm(const mcl::CurveParam& cp, const msm::Func *func);
void mulVecAVX512(Unit *_P, Unit *_x, const Unit *_y, size_t n, size_t b);
void mulEachAVX512(Unit *_x, const Unit *_y, size_t n);

} // mcl::msm
#endif

namespace bn {

// backward compatibility
typedef mcl::Fp Fp;
typedef mcl::Fr Fr;
typedef mcl::G1 G1;
typedef mcl::G2 G2;
typedef mcl::GT GT;
typedef mcl::Fp2 Fp2;
typedef mcl::Fp6 Fp6;
typedef mcl::Fp12 Fp12;

typedef mcl::FpDbl FpDbl;
typedef mcl::Fp2Dbl Fp2Dbl;
typedef mcl::Fp6Dbl Fp6Dbl;

inline void Frobenius(Fp2& y, const Fp2& x)
{
	Fp2::Frobenius(y, x);
}
inline void Frobenius(Fp12& y, const Fp12& x)
{
	Fp12::Frobenius(y, x);
}

// mapTo
void mapToInit(const mpz_class& cofactor, const mpz_class &z, int curveType);

namespace local {

typedef mcl::FixedArray<int8_t, 128> SignVec;

inline size_t getPrecomputeQcoeffSize(const SignVec& sv)
{
	size_t idx = 2 + 1;
	if (sv[1]) idx++;
	for (size_t i = 2; i < sv.size(); i++) {
		idx++;
		if (sv[i]) idx++;
	}
	return idx;
}

template<class X, class C, size_t N>
X evalPoly(const X& x, const C (&c)[N])
{
	X ret = c[N - 1];
	for (size_t i = 1; i < N; i++) {
		ret *= x;
		ret += c[N - 1 - i];
	}
	return ret;
}

enum TwistBtype {
	tb_generic,
	tb_1m1i, // 1 - 1i
	tb_1m2i // 1 - 2i
};

/*
	l = (a, b, c) => (a, b * P.y, c * P.x)
*/
inline void updateLine(Fp6& l, const G1& P)
{
#if 1
	assert(!P.isZero());
#else
	if (P.isZero()) {
		l.b.clear();
		l.c.clear();
		return;
	}
#endif
	l.b.a *= P.y;
	l.b.b *= P.y;
	l.c.a *= P.x;
	l.c.b *= P.x;
}

struct Compress {
	Fp12& z_;
	Fp2& g1_;
	Fp2& g2_;
	Fp2& g3_;
	Fp2& g4_;
	Fp2& g5_;
	// z is output area
	Compress(Fp12& z, const Fp12& x)
		: z_(z)
		, g1_(z.getFp2()[4])
		, g2_(z.getFp2()[3])
		, g3_(z.getFp2()[2])
		, g4_(z.getFp2()[1])
		, g5_(z.getFp2()[5])
	{
		g2_ = x.getFp2()[3];
		g3_ = x.getFp2()[2];
		g4_ = x.getFp2()[1];
		g5_ = x.getFp2()[5];
	}
	Compress(Fp12& z, const Compress& c)
		: z_(z)
		, g1_(z.getFp2()[4])
		, g2_(z.getFp2()[3])
		, g3_(z.getFp2()[2])
		, g4_(z.getFp2()[1])
		, g5_(z.getFp2()[5])
	{
		g2_ = c.g2_;
		g3_ = c.g3_;
		g4_ = c.g4_;
		g5_ = c.g5_;
	}
	void decompressBeforeInv(Fp2& nume, Fp2& denomi) const
	{
		assert(&nume != &denomi);

		if (g2_.isZero()) {
			Fp2::mul2(nume, g4_);
			nume *= g5_;
			denomi = g3_;
		} else {
			Fp2 t;
			Fp2::sqr(nume, g5_);
			Fp2::mul_xi(denomi, nume);
			Fp2::sqr(nume, g4_);
			Fp2::sub(t, nume, g3_);
			Fp2::mul2(t, t);
			t += nume;
			Fp2::add(nume, denomi, t);
			Fp2::divBy4(nume, nume);
			denomi = g2_;
		}
	}

	// output to z
	void decompressAfterInv()
	{
		Fp2& g0 = z_.getFp2()[0];
		Fp2 t0, t1;
		// Compute g0.
		Fp2::sqr(t0, g1_);
		Fp2::mul(t1, g3_, g4_);
		t0 -= t1;
		Fp2::mul2(t0, t0);
		t0 -= t1;
		Fp2::mul(t1, g2_, g5_);
		t0 += t1;
		Fp2::mul_xi(g0, t0);
		g0.a += Fp::one();
	}

public:
	void decompress() // for test
	{
		Fp2 nume, denomi;
		decompressBeforeInv(nume, denomi);
		Fp2::inv(denomi, denomi);
		g1_ = nume * denomi; // g1 is recoverd.
		decompressAfterInv();
	}
	/*
		2275clk * 186 = 423Kclk QQQ
	*/
	static void squareC(Compress& z)
	{
		Fp2 t0, t1, t2;
		Fp2Dbl T0, T1, T2, T3;
		Fp2Dbl::sqrPre(T0, z.g4_);
		Fp2Dbl::sqrPre(T1, z.g5_);
		Fp2Dbl::mul_xi(T2, T1);
		T2 += T0;
		Fp2Dbl::mod(t2, T2);
		Fp2::add(t0, z.g4_, z.g5_);
		Fp2Dbl::sqrPre(T2, t0);
		T0 += T1;
		T2 -= T0;
		Fp2Dbl::mod(t0, T2);
		Fp2::add(t1, z.g2_, z.g3_);
		Fp2Dbl::sqrPre(T3, t1);
		Fp2Dbl::sqrPre(T2, z.g2_);
		Fp2::mul_xi(t1, t0);
		z.g2_ += t1;
		Fp2::mul2(z.g2_, z.g2_);
		z.g2_ += t1;
		Fp2::sub(t1, t2, z.g3_);
		Fp2::mul2(t1, t1);
		Fp2Dbl::sqrPre(T1, z.g3_);
		Fp2::add(z.g3_, t1, t2);
		Fp2Dbl::mul_xi(T0, T1);
		T0 += T2;
		Fp2Dbl::mod(t0, T0);
		Fp2::sub(z.g4_, t0, z.g4_);
		Fp2::mul2(z.g4_, z.g4_);
		z.g4_ += t0;
		Fp2Dbl::addPre(T2, T2, T1);
		T3 -= T2;
		Fp2Dbl::mod(t0, T3);
		z.g5_ += t0;
		Fp2::mul2(z.g5_, z.g5_);
		z.g5_ += t0;
	}
	static void square_n(Compress& z, int n)
	{
		for (int i = 0; i < n; i++) {
			squareC(z);
		}
	}
	/*
		Exponentiation over compression for:
		z = x^Param::z.abs()
	*/
	static void fixed_power(Fp12& z, const Fp12& x)
	{
		if (x.isOne()) {
			z = 1;
			return;
		}
		Fp12 x_org = x;
		Fp12 d62;
		Fp2 c55nume, c55denomi, c62nume, c62denomi;
		Compress c55(z, x);
		square_n(c55, 55);
		c55.decompressBeforeInv(c55nume, c55denomi);
		Compress c62(d62, c55);
		square_n(c62, 62 - 55);
		c62.decompressBeforeInv(c62nume, c62denomi);
		Fp2 acc;
		Fp2::mul(acc, c55denomi, c62denomi);
		Fp2::inv(acc, acc);
		Fp2 t;
		Fp2::mul(t, acc, c62denomi);
		Fp2::mul(c55.g1_, c55nume, t);
		c55.decompressAfterInv();
		Fp2::mul(t, acc, c55denomi);
		Fp2::mul(c62.g1_, c62nume, t);
		c62.decompressAfterInv();
		z *= x_org;
		z *= d62;
	}
};

/*
	Software implementation of Attribute-Based Encryption: Appendixes
	GLV for G1 on BN/BLS12
*/

struct GLV1 : mcl::GLV1T<G1, Fr> {
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
				optimizedSplit = optimizedSplitForBLS12_381;
			} else
#if 1
			if (curveType == BLS12_377.curveType) {
				optimizedSplit = optimizedSplitForBLS12_377;
			} else
#endif
			{
				optimizedSplit = splitForBLS12;
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
	// x = (a + b L) mod r
	static inline void splitForBLS12(mpz_class u[2], const mpz_class& x)
	{
		mpz_class& a = u[0];
		mpz_class& b = u[1];
		mpz_class t;
		b = (x * v0) >> rBitSize;
		a = x - b * B[0][0];
	}
	static inline void optimizedSplitForBLS12_381(mpz_class u[2], const mpz_class& x)
	{
		static const size_t n = 128 / mcl::UnitBitSize;
		Unit xa[n*2], a[n], b[n];
		bool dummy;
		mcl::gmp::getArray(&dummy, xa, n*2, x);
		assert(dummy);
		ec::local::optimizedSplitRawForBLS12_381(a, b, xa);
		gmp::setArray(&dummy, u[0], a, n);
		gmp::setArray(&dummy, u[1], b, n);
		assert(dummy);
		(void)dummy;
	}
	static inline void optimizedSplitForBLS12_377(mpz_class u[2], const mpz_class& x)
	{
		static const size_t n = 128 / mcl::UnitBitSize;
		Unit xa[n*2], a[n], b[n];
		bool dummy;
		mcl::gmp::getArray(&dummy, xa, n*2, x);
		assert(dummy);
		ec::local::optimizedSplitRawForBLS12_377(a, b, xa);
		gmp::setArray(&dummy, u[0], a, n);
		gmp::setArray(&dummy, u[1], b, n);
		assert(dummy);
		(void)dummy;
	}
};

/*
	GLV method for G2 and GT on BN/BLS12
*/
template<class _Fr>
struct GLV2T {
	typedef GLV2T<_Fr> GLV2;
	static const int splitN = 4;
	typedef _Fr Fr;
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
	static void split(mpz_class u[4], mpz_class& x)
	{
		Fr::getOp().modp.modp(x, x);
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

template<class Fr> size_t GLV2T<Fr>::rBitSize = 0;
template<class Fr> mpz_class GLV2T<Fr>::B[4][4];
template<class Fr> mpz_class GLV2T<Fr>::v[4];
template<class Fr> mpz_class GLV2T<Fr>::z;
template<class Fr> mpz_class GLV2T<Fr>::abs_z;
template<class Fr> bool GLV2T<Fr>::isBLS12 = false;

typedef GLV2T<Fr> GLV2;

bool powVecGLV(Fp12& z, const Fp12 *xVec, const void *yVec, size_t n);

void dblLineWithoutP(Fp6& l, G2& Q);
void addLineWithoutP(Fp6& l, G2& R, const G2& Q);

inline void dblLine(Fp6& l, G2& Q, const G1& P)
{
	dblLineWithoutP(l, Q);
	local::updateLine(l, P);
}
inline void addLine(Fp6& l, G2& R, const G2& Q, const G1& P)
{
	addLineWithoutP(l, R, Q);
	local::updateLine(l, P);
}

void mulSparse(Fp12& z, const Fp6& x);

} // mcl::bn::local

/*
	y = x^((p^12 - 1) / r)
	(p^12 - 1) / r = (p^2 + 1) (p^6 - 1) (p^4 - p^2 + 1)/r
	(a + bw)^(p^6) = a - bw in Fp12
	(p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
*/
void finalExp(Fp12& y, const Fp12& x);
void millerLoop(Fp12& f, const G1& P_, const G2& Q_);

inline void pairing(Fp12& f, const G1& P, const G2& Q)
{
	millerLoop(f, P, Q);
	finalExp(f, f);
}
/*
	allocate param.precomputedQcoeffSize elements of Fp6 for Qcoeff
*/
void precomputeG2(Fp6 *Qcoeff, const G2& Q_);

/*
	millerLoop(e, P, Q) is same as the following
	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Q);
	precomputedMillerLoop(e, P, Qcoeff);
*/
#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputeG2(std::vector<Fp6>& Qcoeff, const G2& Q);
#endif

size_t getPrecomputedQcoeffSize();

template<class Array>
void precomputeG2(bool *pb, Array& Qcoeff, const G2& Q)
{
	*pb = Qcoeff.resize(getPrecomputedQcoeffSize());
	if (!*pb) return;
	precomputeG2(Qcoeff.data(), Q);
}

void precomputedMillerLoop(Fp12& f, const G1& P_, const Fp6* Qcoeff);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputedMillerLoop(Fp12& f, const G1& P, const std::vector<Fp6>& Qcoeff);
#endif
/*
	f = MillerLoop(P1, Q1) x MillerLoop(P2, Q2)
	Q2coeff : precomputed Q2
*/
void precomputedMillerLoop2mixed(Fp12& f, const G1& P1_, const G2& Q1_, const G1& P2_, const Fp6* Q2coeff);
/*
	f = MillerLoop(P1, Q1) x MillerLoop(P2, Q2)
	Q1coeff, Q2coeff : precomputed Q1, Q2
*/
void precomputedMillerLoop2(Fp12& f, const G1& P1_, const Fp6* Q1coeff, const G1& P2_, const Fp6* Q2coeff);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputedMillerLoop2(Fp12& f, const G1& P1, const std::vector<Fp6>& Q1coeff, const G1& P2, const std::vector<Fp6>& Q2coeff);
void precomputedMillerLoop2mixed(Fp12& f, const G1& P1, const G2& Q1, const G1& P2, const std::vector<Fp6>& Q2coeff);
#endif

/*
	_f = prod_{i=0}^{n-1} millerLoop(Pvec[i], Qvec[i])
	if initF:
	  f = _f
	else:
	  f *= _f
*/
void millerLoopVec(Fp12& f, const G1* Pvec, const G2* Qvec, size_t n, bool initF = true);

// multi thread version of millerLoopVec
// the num of thread is automatically detected if cpuN = 0
void millerLoopVecMT(Fp12& f, const G1* Pvec, const G2* Qvec, size_t n, size_t cpuN = 0);

bool setMapToMode(int mode);
int getMapToMode();
void mapToG1(bool *pb, G1& P, const Fp& x);
void mapToG2(bool *pb, G2& P, const Fp2& x);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void mapToG1(G1& P, const Fp& x);
void mapToG2(G2& P, const Fp2& x);
#endif

void hashAndMapToG1(G1& P, const void *buf, size_t bufSize);
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize);
void hashAndMapToG1(G1& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize);
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize);
// set the default dst for G1
// return 0 if success else -1
bool setDstG1(const char *dst, size_t dstSize);
// set the default dst for G2
// return 0 if success else -1
bool setDstG2(const char *dst, size_t dstSize);

#ifndef CYBOZU_DONT_USE_STRING
void hashAndMapToG1(G1& P, const std::string& str);
void hashAndMapToG2(G2& P, const std::string& str);
#endif

void verifyOrderG1(bool doVerify);
void verifyOrderG2(bool doVerify);

/*
	Faster Subgroup Checks for BLS12-381
	Sean Bowe, https://eprint.iacr.org/2019/814
	Frob^2(P) - z Frob^3(P) == P
*/
bool isValidOrderBLS12(const G2& P);
bool isValidOrderBLS12(const G1& P);

// backward compatibility
using mcl::CurveParam;
static const CurveParam& CurveFp254BNb = BN254;
static const CurveParam& CurveFp382_1 = BN381_1;
static const CurveParam& CurveFp382_2 = BN381_2;
static const CurveParam& CurveFp462 = BN462;
static const CurveParam& CurveSNARK1 = BN_SNARK1;

/*
	FrobeniusOnTwist for Dtype
	p mod 6 = 1, w^6 = xi
	Frob(x', y') = phi Frob phi^-1(x', y')
	= phi Frob (x' w^2, y' w^3)
	= phi (x'^p w^2p, y'^p w^3p)
	= (F(x') w^2(p - 1), F(y') w^3(p - 1))
	= (F(x') g^2, F(y') g^3)

	FrobeniusOnTwist for Mtype(BLS12-381)
	use (1/g) instead of g
*/
void Frobenius(G2& D, const G2& S);
void Frobenius2(G2& D, const G2& S);
void Frobenius3(G2& D, const G2& S);

namespace BN {

using namespace mcl::bn; // backward compatibility


void init(bool *pb, const mcl::CurveParam& cp = mcl::BN254, fp::Mode mode = fp::FP_AUTO);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void init(const mcl::CurveParam& cp = mcl::BN254, fp::Mode mode = fp::FP_AUTO);
#endif

} // mcl::bn::BN

const CurveParam& getCurveParam();
int getCurveType();

void initPairing(bool *pb, const mcl::CurveParam& cp = mcl::BN254, fp::Mode mode = fp::FP_AUTO);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void initPairing(const mcl::CurveParam& cp = mcl::BN254, fp::Mode mode = fp::FP_AUTO);
#endif

void initG1only(bool *pb, const mcl::EcParam& para);

const G1& getG1basePoint();

/*
	check x in Fp12 is in GT.
	return true if x^r = 1
*/
bool isValidGT(const GT& x);

} } // mcl::bn

