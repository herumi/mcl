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

typedef Fp12 GT;
typedef EcT<Fp2, Fr> G2;

namespace bn {

/*
	twisted Frobenius for G2
*/
void Frobenius(G2& D, const G2& S);
void Frobenius2(G2& D, const G2& S);
void Frobenius3(G2& D, const G2& S);

} // mcl::bn

} // mcl
