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
#include <assert.h>
#include <mcl/curve_type.h>

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

} // mcl::util

} // mcl

