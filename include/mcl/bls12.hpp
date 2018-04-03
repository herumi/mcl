#pragma once
/**
	@file
	@brief BLS12-381 curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/pairing_util.hpp>

namespace mcl { namespace bls12 {

using mcl::CurveParam;
using mcl::getCurveParam;

template<class Fp>
struct ParamT : public util::CommonParamT<Fp> {
	typedef util::CommonParamT<Fp> Common;
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	util::MapToT<Fp> mapTo;

	void init(const CurveParam& cp = mcl::BLS12_381, fp::Mode mode = fp::FP_AUTO)
	{
		Common::initCommonParam(cp, mode);
		mapTo.init(0, this->z, false);
	}
};

template<class Fp>
struct BLS12T : mcl::util::BasePairingT<BLS12T<Fp>, Fp, ParamT<Fp> > {
	typedef ParamT<Fp> Param;
	typedef typename mcl::util::BasePairingT<BLS12T<Fp>, Fp, Param> Base;
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::Fp6T<Fp> Fp6;
	typedef mcl::Fp12T<Fp> Fp12;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef util::HaveFrobenius<G2> G2withF;
	typedef mcl::FpDblT<Fp> FpDbl;
	typedef mcl::Fp2DblT<Fp> Fp2Dbl;
	static void init(const mcl::CurveParam& cp = mcl::BLS12_381, fp::Mode mode = fp::FP_AUTO)
	{
		Base::param.init(cp, mode);
		G2withF::init(cp.isMtype);
	}
};

} } // mcl::bls12

