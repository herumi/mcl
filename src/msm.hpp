#pragma once

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

} // mcl
