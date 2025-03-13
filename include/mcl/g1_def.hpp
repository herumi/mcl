#pragma once
/**
	@file
	@brief Define class Fp and Fr and G1
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/fp.hpp>
#include <mcl/ec.hpp>

/*
	set bit size of Fp and Fr
*/
#ifndef MCL_MAX_FP_BIT_SIZE
	#define MCL_MAX_FP_BIT_SIZE 256
#endif

#ifndef MCL_MAX_FR_BIT_SIZE
	#define MCL_MAX_FR_BIT_SIZE MCL_MAX_FP_BIT_SIZE
#endif

namespace mcl {

typedef mcl::FpT<mcl::FpTag, MCL_MAX_FP_BIT_SIZE> Fp;
typedef mcl::FpT<mcl::ZnTag, MCL_MAX_FR_BIT_SIZE> Fr;

typedef mcl::EcT<Fp, Fr> G1;

} // mcl
