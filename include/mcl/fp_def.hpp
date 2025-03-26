#pragma once
/**
	@file
	@brief Define class Fp
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/fp.hpp>

namespace mcl {

struct FpTag;
typedef FpT<FpTag, MCL_FP_BIT> Fp;

} // mcl
