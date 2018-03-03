#pragma once
/**
	@file
	@brief utility for pairings
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp_tower.hpp>
#include <mcl/ec.hpp>
#include <mcl/curve_type.h>
#include <assert.h>

namespace mcl {

struct CurveParam {
	/*
		y^2 = x^3 + b
		i^2 = -1
		xi = xi_a + i
		v^3 = xi
		w^2 = v
	*/
	const char *z;
	int b; // y^2 = x^3 + b
	int xi_a; // xi = xi_a + i
	int curveType; // same in bn.h
	bool operator==(const CurveParam& rhs) const { return z == rhs.z && b == rhs.b && xi_a == rhs.xi_a; }
	bool operator!=(const CurveParam& rhs) const { return !operator==(rhs); }
};

namespace bn {

const CurveParam CurveFp254BNb = { "-0x4080000000000001", 2, 1, mclBn_CurveFp254BNb }; // -(2^62 + 2^55 + 1)
// provisional(experimental) param with maxBitSize = 384
const CurveParam CurveFp382_1 = { "-0x400011000000000000000001", 2, 1, mclBn_CurveFp382_1 }; // -(2^94 + 2^76 + 2^72 + 1) // A Family of Implementation-Friendly BN Elliptic Curves
const CurveParam CurveFp382_2 = { "-0x400040090001000000000001", 2, 1, mclBn_CurveFp382_2 }; // -(2^94 + 2^78 + 2^67 + 2^64 + 2^48 + 1) // used in relic-toolkit
const CurveParam CurveFp462 = { "0x4001fffffffffffffffffffffbfff", 5, 2, mclBn_CurveFp462 }; // 2^114 + 2^101 - 2^14 - 1 // https://eprint.iacr.org/2017/334
const CurveParam CurveSNARK1 = { "4965661367192848881", 3, 9, mclBn_CurveSNARK1 };

} // mcl::bn

namespace bls12 {

const CurveParam CurveFp381 = { "-0xd201000000010000", 4, 1, mclBls12_CurveFp381 };

} // mcl::bls12

inline const CurveParam& getCurveParam(int type)
{
	switch (type) {
	case mclBn_CurveFp254BNb: return bn::CurveFp254BNb;
	case mclBn_CurveFp382_1: return bn::CurveFp382_1;
	case mclBn_CurveFp382_2: return bn::CurveFp382_2;
	case mclBn_CurveFp462: return bn::CurveFp462;
	case mclBn_CurveSNARK1: return bn::CurveSNARK1;
	case mclBls12_CurveFp381: return bls12::CurveFp381;
	default:
		throw cybozu::Exception("getCurveParam:bad type") << type;
	}
}

namespace util {

typedef std::vector<int8_t> SignVec;

inline size_t getPrecomputeQcoeffSize(const SignVec& sv)
{
	size_t idx = 2 + 2;
	for (size_t i = 2; i < sv.size(); i++) {
		idx++;
		if (sv[i]) idx++;
	}
	return idx;
}

template<class X, class C, size_t N>
X evalPoly(const X& x, const C (&c)[N])
{
	X ret = c[N - 1];
	for (size_t i = 1; i < N; i++) {
		ret *= x;
		ret += c[N - 1 - i];
	}
	return ret;
}
enum TwistBtype {
	tb_generic,
	tb_1m1i, // 1 - 1i
	tb_1m2i // 1 - 2i
};

template<class _Fp>
struct CommonParamT {
	typedef _Fp Fp;
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	int curveType;
	bool isCurveFp254BNb;
	mpz_class z;
	mpz_class abs_z;
	bool isNegative;
	mpz_class p;
	mpz_class r;
	int b;
	/*
		BN254, BN381, etc. : Dtype
		BLS12-381 : Mtype
	*/
	bool isMtype;
	/*
		Dtype twist
		(x', y') = phi(x, y) = (x/w^2, y/w^3)
		y^2 = x^3 + b
		=> (y'w^3)^2 = (x'w^2)^3 + b
		=> y'^2 = x'^3 + b / w^6 ; w^6 = xi
		=> y'^2 = x'^3 + twist_b;
	*/
	Fp2 twist_b;
	util::TwistBtype twist_b_type;
	bool is_b_div_xi_1_m1i;
	mpz_class exp_c0;
	mpz_class exp_c1;
	mpz_class exp_c2;
	mpz_class exp_c3;

	// Loop parameter for the Miller loop part of opt. ate pairing.
	util::SignVec siTbl;
	size_t precomputedQcoeffSize;
	bool useNAF;
	util::SignVec zReplTbl;

	void initCommonParam(const CurveParam& cp, fp::Mode mode, bool isBLS12)
	{
		curveType = cp.curveType;
		z = mpz_class(cp.z);
		isCurveFp254BNb = cp == bn::CurveFp254BNb;
		isMtype = isBLS12 ? true : false; // ad hoc
		isNegative = z < 0;
		if (isNegative) {
			abs_z = -z;
		} else {
			abs_z = z;
		}
		if (isBLS12) {
			mpz_class z2 = z * z;
			mpz_class z4 = z2 * z2;
			r = z4 - z2 + 1;
			p = z - 1;
			p = p * p * r / 3 + z;
		} else {
			const int pCoff[] = { 1, 6, 24, 36, 36 };
			const int rCoff[] = { 1, 6, 18, 36, 36 };
			p = util::evalPoly(z, pCoff);
			assert((p % 6) == 1);
			r = util::evalPoly(z, rCoff);
		}
		Fp::init(p, mode);
		Fp2::init(cp.xi_a);
		b = cp.b;
		Fp2 xi(cp.xi_a, 1);
		if (isMtype) {
			twist_b = Fp2(b) * xi;
		} else {
			twist_b = Fp2(b) / xi;
		}
		if (twist_b == Fp2(1, -1)) {
			twist_b_type = tb_1m1i;
		} else if (twist_b == Fp2(1, -2)) {
			twist_b_type = tb_1m2i;
		} else {
			twist_b_type = tb_generic;
		}
		G1::init(0, b, mcl::ec::Proj);
		G2::init(0, twist_b, mcl::ec::Proj);
		G2::setOrder(r);

		const mpz_class largest_c = isBLS12 ? abs_z : gmp::abs(z * 6 + 2);
		useNAF = gmp::getNAF(siTbl, largest_c);
		precomputedQcoeffSize = util::getPrecomputeQcoeffSize(siTbl);
		gmp::getNAF(zReplTbl, gmp::abs(z));
		if (isBLS12) {
			mpz_class z2 = z * z;
			mpz_class z3 = z2 * z;
			mpz_class z4 = z3 * z;
			mpz_class z5 = z4 * z;
			exp_c0 = z5 - 2 * z4 + 2 * z2 - z + 3;
			exp_c1 = z4 - 2 * z3 + 2 * z - 1;
			exp_c2 = z3 - 2 * z2 + z;
			exp_c3 = z2 - 2 * z + 1;
		} else {
			exp_c0 = -2 + z * (-18 + z * (-30 - 36 * z));
			exp_c1 = 1 + z * (-12 + z * (-18 - 36 * z));
			exp_c2 = 6 * z * z + 1;
		}
	}
};

/*
	l = (a, b, c) => (a, b * P.y, c * P.x)
*/
template<class Fp6,  class G1>
void updateLine(Fp6& l, const G1& P)
{
	l.b.a *= P.y;
	l.b.b *= P.y;
	l.c.a *= P.x;
	l.c.b *= P.x;
}

template<class Fp12, class Fp6>
void convertFp6toFp12(Fp12& y, const Fp6& x)
{
	y.clear();
#ifdef MCL_DEV
	y.a.a = x.b;
	y.b.a = x.c;
	y.b.b = x.a;
#else
	y.a.a = x.a;
	y.a.c = x.c;
	y.b.b = x.b;
#endif
}

template<class Param, class Fp2>
void mul_b_div_xi(const Param& param, Fp2& y, const Fp2& x)
{
	typedef typename Fp2::BaseFp Fp;
	switch (param.twist_b_type) {
	case util::tb_1m1i:
		/*
			b / xi = 1 - 1i
			(a + bi)(1 - 1i) = (a + b) + (b - a)i
		*/
		{
			Fp t;
			Fp::add(t, x.a, x.b);
			Fp::sub(y.b, x.b, x.a);
			y.a = t;
		}
		return;
	case util::tb_1m2i:
		/*
			b / xi = 1 - 2i
			(a + bi)(1 - 2i) = (a + 2b) + (b - 2a)i
		*/
		{
			Fp t;
			Fp::sub(t, x.b, x.a);
			t -= x.a;
			Fp::add(y.a, x.a, x.b);
			y.a += x.b;
			y.b = t;
		}
		return;
	case util::tb_generic:
		Fp2::mul(y, x, param.twist_b);
		return;
	}
}

} // mcl::util

} // mcl

