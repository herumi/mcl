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

bool initMsm(const mcl::CurveParam& cp);
void mulVecAVX512(Unit *_P, Unit *_x, const Unit *_y, size_t n, size_t b);
void mulEachAVX512(Unit *_x, const Unit *_y, size_t n);

} // mcl::msm
#endif

} // mcl
