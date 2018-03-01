#pragma once
/**
	@file
	@brief curve type
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#ifndef MCL_CURVE_TYPE_DEFINED
#define MCL_CURVE_TYPE_DEFINED
enum {
	mclBn_CurveFp254BNb = 0,
	mclBn_CurveFp382_1 = 1,
	mclBn_CurveFp382_2 = 2,
	mclBn_CurveFp462 = 3,
	mclBn_CurveSNARK1 = 4,
	mclBls12_CurveFp381 = 5
};
#endif
