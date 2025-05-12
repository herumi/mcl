#pragma once

namespace mcl {

#ifndef MCL_MSM
	#if (/*defined(_WIN64) ||*/ defined(__x86_64__)) && !defined(__APPLE__) && MCL_SIZEOF_UNIT == 8 && MCL_FP_BIT == 384 && MCL_FR_BIT == 256
		#define MCL_MSM 1
	#else
		#define MCL_MSM 0
	#endif
#endif

#if MCL_MSM == 1
namespace msm {

bool initMsm(const mcl::CurveParam& cp);
void mulVecAVX512(Unit *_P, Unit *_x, const Unit *_y, size_t n, size_t b);
void mulEachAVX512(Unit *_x, const Unit *_y, size_t n);

} // mcl::msm
#endif

} // mcl
