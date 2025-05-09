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
typedef EcT<Fp2> G2;

/*
	twisted Frobenius for G2

	FrobeniusOnTwist for Dtype
	p mod 6 = 1, w^6 = xi
	Frob(x', y') = phi Frob phi^-1(x', y')
	= phi Frob (x' w^2, y' w^3)
	= phi (x'^p w^2p, y'^p w^3p)
	= (F(x') w^2(p - 1), F(y') w^3(p - 1))
	= (F(x') g^2, F(y') g^3)

	FrobeniusOnTwist for Mtype(BLS12-381)
	use (1/g) instead of g
*/
void Frobenius(G2& D, const G2& S);
void Frobenius2(G2& D, const G2& S);
void Frobenius3(G2& D, const G2& S);

} // mcl
