#pragma once
/**
	@file
	@brief BLS12-381 curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#define MCL_MTYPE
#define MCL_USE_BLS12
#include <mcl/pairing_util.hpp>

namespace mcl { namespace bls12 {

using mcl::CurveParam;
using mcl::getCurveParam;

template<class Fp>
struct MapToT {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef util::HaveFrobenius<G2> G2withF;
	mpz_class z_;
	mpz_class cofactor1_;
	/*
		#(Fp) / r = (z + 1 - t) / r = (z - 1)^2 / 3
	*/
	void mulByCofactor(G1& Q, const G1& P) const
	{
		assert(cofactor1_ != 0);
		G1::mulGeneric(Q, P, cofactor1_);
	}
	/*
		Efficient hash maps to G2 on BLS curves
		Alessandro Budroni, Federico Pintore
		Q = (z(z-1)-1)P + Frob((z-1)P) + Frob^2(2P)
	*/
	void mulByCofactor(G2& Q, const G2& P) const
	{
		G2 T0, T1;
		G2::mulGeneric(T0, P, z_ - 1);
		G2::mulGeneric(T1, T0, z_);
		T1 -= P;
		G2withF::Frobenius(T0, T0);
		T0 += T1;
		G2::dbl(T1, P);
		G2withF::Frobenius2(T1, T1);
		G2::add(Q, T0, T1);
	}
	void init(const mpz_class& z)
	{
		z_ = z;
		cofactor1_ = (z - 1) * (z - 1) / 3;
	}
	template<class G, class F>
	void calc(G& P, const F& t) const
	{
		F x = t;
		for (;;) {
			F y;
			G::getWeierstrass(y, x);
			if (F::squareRoot(y, y)) {
				P.set(x, y, false);
				return;
			}
			*x.getFp0() += Fp::one();
		}
	}
	void calcG1(G1& P, const Fp& t) const
	{
		calc<G1, Fp>(P, t);
		mulByCofactor(P, P);
	}
	/*
		get the element in G2 by multiplying the cofactor
	*/
	void calcG2(G2& P, const Fp2& t) const
	{
		calc<G2, Fp2>(P, t);
		mulByCofactor(P, P);
	}
};

template<class Fp>
struct ParamT : public util::CommonParamT<Fp> {
	typedef util::CommonParamT<Fp> Common;
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	MapToT<Fp> mapTo;

	void init(const CurveParam& cp = CurveFp381, fp::Mode mode = fp::FP_AUTO)
	{
		Common::initCommonParam(cp, mode, true);
		mapTo.init(this->z);
	}
};

template<class Fp>
struct BLS12T : mcl::util::BasePairingT<Fp, ParamT<Fp> > {
	typedef ParamT<Fp> Param;
	typedef typename mcl::util::BasePairingT<Fp, Param> Base;
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::Fp6T<Fp> Fp6;
	typedef mcl::Fp12T<Fp> Fp12;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef util::HaveFrobenius<G2> G2withF;
	typedef mcl::FpDblT<Fp> FpDbl;
	typedef mcl::Fp2DblT<Fp> Fp2Dbl;
	static void init(const mcl::bls12::CurveParam& cp = CurveFp381, fp::Mode mode = fp::FP_AUTO)
	{
		Base::param.init(cp, mode);
		G2withF::init(Base::param.isMtype);
	}
};

} } // mcl::bls12

