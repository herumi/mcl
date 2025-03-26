#pragma once
/**
	@file
	@brief Define class G1, Fp, Fr
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/fp.hpp>
#include <mcl/ec.hpp>

namespace mcl {

typedef mcl::FpT<mcl::FpTag, MCL_FP_BIT> Fp;
typedef mcl::FpT<mcl::ZnTag, MCL_FR_BIT> Fr;

typedef mcl::EcT<Fp, Fr> G1;

} // mcl
