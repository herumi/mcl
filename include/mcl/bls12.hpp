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
		Common::initCommonParam(cp, mode);
		mapTo.init(this->z);
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
	static void init(const mcl::bls12::CurveParam& cp = CurveFp381, fp::Mode mode = fp::FP_AUTO)
	{
		Base::param.init(cp, mode);
		G2withF::init(cp.isMtype);
	}
	/*
		Implementing Pairings at the 192-bit Security Level
		D.F.Aranha, L.F.Castaneda, E.Knapp, A.Menezes, F.R.Henriquez
		Section 4
	*/
	static void expHardPart(Fp12& y, const Fp12& x)
	{
#if 0
		const mpz_class& p = param.p;
		mpz_class p2 = p * p;
		mpz_class p4 = p2 * p2;
		Fp12::pow(y, x, (p4 - p2 + 1) / param.r * 3);
		return;
#endif
#if 1
		Fp12 a0, a1, a2, a3, a4, a5, a6, a7;
		Fp12::unitaryInv(a0, x); // a0 = x^-1
		Base::fasterSqr(a1, a0); // x^-2
		Base::pow_z(a2, x); // x^z
		Base::fasterSqr(a3, a2); // x^2z
		a1 *= a2; // a1 = x^(z-2)
		Base::pow_z(a7, a1); // a7 = x^(z^2-2z)
		Base::pow_z(a4, a7); // a4 = x^(z^3-2z^2)
		Base::pow_z(a5, a4); // a5 = x^(z^4-2z^3)
		a3 *= a5; // a3 = x^(z^4-2z^3+2z)
		Base::pow_z(a6, a3); // a6 = x^(z^5-2z^4+2z^2)

		Fp12::unitaryInv(a1, a1); // x^(2-z)
		a1 *= a6; // x^(z^5-2z^4+2z^2-z+2)
		a1 *= x; // x^(z^5-2z^4+2z^2-z+3) = x^c0
		a3 *= a0; // x^(z^4-2z^3-1) = x^c1
		Fp12::Frobenius(a3, a3); // x^(c1 p)
		a1 *= a3; // x^(c0 + c1 p)
		a4 *= a2; // x^(z^3-2z^2+z) = x^c2
		Fp12::Frobenius2(a4, a4);  // x^(c2 p^2)
		a1 *= a4; // x^(c0 + c1 p + c2 p^2)
		a7 *= x; // x^(z^2-2z+1) = x^c3
		Fp12::Frobenius3(y, a7);
		y *= a1;
#else
		Fp12 t1, t2, t3;
		Fp12::Frobenius(t1, x);
		Fp12::Frobenius(t2, t1);
		Fp12::Frobenius(t3, t2);
		Fp12::pow(t1, t1, param.exp_c1);
		Fp12::pow(t2, t2, param.exp_c2);
		Fp12::pow(t3, t3, param.exp_c3);
		Fp12::pow(y, x, param.exp_c0);
		y *= t1;
		y *= t2;
		y *= t3;
#endif
	}
};

} } // mcl::bls12

