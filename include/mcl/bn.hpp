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

