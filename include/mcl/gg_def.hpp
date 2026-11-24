#pragma once
/**
	@file
	@brief Define class GG (Grumpkin / Grumpkin382)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/g1_def.hpp>

#if MCL_USE_GRUMPKIN == 0
	#error "GG requires MCL_USE_GRUMPKIN=1 (MCL_FP_BIT=256) or 2 (MCL_FP_BIT=384)"
#endif

namespace mcl {

/*
	MCL_USE_GRUMPKIN=1 : Grumpkin : y^2 = x^3 - 17 over Fr (the r of BN_SNARK1), the order is the p of BN_SNARK1
	MCL_USE_GRUMPKIN=2 : Grumpkin382 : y^2 = x^3 + 2 over Fr (the r of BN382), the order is the p of BN382
	the 2-cycle with BN_SNARK1 (alt_bn128) / BN382 : (initGrumpkin in bn.hpp)
*/
typedef EcT<Fr, Fp> GG;

namespace ec {
template<> struct StaticId<Fr> { static const int id = StaticIdGG; };
} // mcl::ec

} // mcl
