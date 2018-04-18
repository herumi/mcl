#pragma once
/**
	@file
	@brief preset class for 384-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/bn.hpp>

namespace mcl { namespace bn384 {

namespace local {
struct FpTag;
struct FrTag;
}

typedef mcl::FpT<local::FpTag, 384> Fp;
typedef mcl::FpT<local::FrTag, 384> Fr;

#include <mcl/bn_common.hpp>

} } // mcl::bn384

