#pragma once
/**
	@file
	@brief preset class for 512-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/bn.hpp>

namespace mcl { namespace bn512 {

namespace local {
struct FpTag;
struct FrTag;
}

typedef mcl::FpT<local::FpTag, 512> Fp;
typedef mcl::bn::BNT<Fp> BN;
typedef BN::Fp2 Fp2;
typedef BN::Fp6 Fp6;
typedef BN::Fp12 Fp12;
typedef BN::G1 G1;
typedef BN::G2 G2;
typedef BN::Fp12 GT;

/* the order of G1 is r */
typedef mcl::FpT<local::FrTag, 512> Fr;

static inline void initPairing(const mcl::bn::CurveParam& cp = mcl::bn::CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
{
	BN::init(cp, mode);
	G1::setCompressedExpression();
	G2::setCompressedExpression();
	Fr::init(BN::param.r);
}

} } // mcl::bn512

