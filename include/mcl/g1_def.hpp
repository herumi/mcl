#pragma once
/**
	@file
	@brief Define class Fr and G1
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/fp_def.hpp>
#include <mcl/fr_def.hpp>
#include <mcl/ec.hpp>

namespace mcl {

typedef EcT<Fp, Fr> G1;

} // mcl
