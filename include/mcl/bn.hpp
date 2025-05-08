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

// mapTo
void mapToInit(const mpz_class& cofactor, const mpz_class &z, int curveType);

/*
	y = x^((p^12 - 1) / r)
	(p^12 - 1) / r = (p^2 + 1) (p^6 - 1) (p^4 - p^2 + 1)/r
	(a + bw)^(p^6) = a - bw in Fp12
	(p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
*/
void finalExp(Fp12& y, const Fp12& x);
void millerLoop(Fp12& f, const G1& P_, const G2& Q_);
void pairing(Fp12& f, const G1& P, const G2& Q);

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

// for backward compatibility
namespace bn {
using namespace mcl;
} // mcl::bn

} // mcl
