#pragma once
/**
	@file
	@brief preset class for 381-bit optimal ate pairing over BLS12 curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/bn.hpp>

namespace mcl { namespace bls12_381 {

namespace local {
struct FpTag;
struct FrTag;
}

typedef mcl::FpT<local::FpTag, 384> Fp;
typedef mcl::bn::BNT<Fp> BLS12;
typedef BLS12::Fp2 Fp2;
typedef BLS12::Fp6 Fp6;
typedef BLS12::Fp12 Fp12;
typedef BLS12::G1 G1;
typedef BLS12::G2 G2;
typedef BLS12::Fp12 GT;

/* the order of G1 is r */
typedef mcl::FpT<local::FrTag, 256> Fr;

static inline void initPairing(const mcl::CurveParam& cp = mcl::BLS12_381, fp::Mode mode = fp::FP_AUTO)
{
	BLS12::init(cp, mode);
	G1::setCompressedExpression();
	G2::setCompressedExpression();
	Fr::init(BLS12::param.r);
}

} } // mcl::bls12_381

