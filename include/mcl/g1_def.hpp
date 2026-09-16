#pragma once
/**
	@file
	@brief Define class Fr and G1
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/ec.hpp>

namespace mcl {

typedef EcT<Fp> G1;

namespace ec {
template<> struct StaticId<Fp> { static const int id = StaticIdG1; };
} // mcl::ec

} // mcl
