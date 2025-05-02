#pragma once
/**
	@file
	@brief Define class Fr
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/fp.hpp>

namespace mcl {

struct FrTag;
typedef FpT<FrTag, MCL_FR_BIT> Fr;

} // mcl
