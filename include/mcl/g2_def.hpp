#pragma once
/**
	@file
	@brief Define class extension of G2, GT, extension of Fp
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/g1_def.hpp>
#include <mcl/fp_tower.hpp>

namespace mcl {

typedef Fp12T<Fp, Fr> Fp12;
typedef Fp12 GT;
typedef EcT<Fp2, Fr> G2;

} // mcl
