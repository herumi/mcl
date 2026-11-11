#pragma once
/**
	@file
	@brief Define class GG (Grumpkin)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/g1_def.hpp>

#if MCL_USE_GRUMPKIN != 1 || MCL_FP_BIT != 256
	#error "GG (Grumpkin) requires MCL_USE_GRUMPKIN=1 and MCL_FP_BIT=256"
#endif

namespace mcl {

/*
	Grumpkin : y^2 = x^3 - 17 over Fr (the r of BN_SNARK1), the order is the p of BN_SNARK1
	the 2-cycle with BN_SNARK1 (alt_bn128) : (initGrumpkin in bn.hpp)
*/
typedef EcT<Fr, Fp> GG;

namespace ec {
template<> struct StaticId<Fr> { static const int id = StaticIdGG; };
} // mcl::ec

} // mcl
