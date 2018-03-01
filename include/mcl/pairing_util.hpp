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

const CurveParam CurveFp254BNb = { "-0x4080000000000001", 2, 1, 0 }; // -(2^62 + 2^55 + 1)
// provisional(experimental) param with maxBitSize = 384
const CurveParam CurveFp382_1 = { "-0x400011000000000000000001", 2, 1, 1 }; // -(2^94 + 2^76 + 2^72 + 1) // A Family of Implementation-Friendly BN Elliptic Curves
const CurveParam CurveFp382_2 = { "-0x400040090001000000000001", 2, 1, 2 }; // -(2^94 + 2^78 + 2^67 + 2^64 + 2^48 + 1) // used in relic-toolkit
const CurveParam CurveFp462 = { "0x4001fffffffffffffffffffffbfff", 5, 2, 3 }; // 2^114 + 2^101 - 2^14 - 1 // https://eprint.iacr.org/2017/334
const CurveParam CurveSNARK1 = { "4965661367192848881", 3, 9, 4 };
//const CurveParam CurveSNARK2 = { "4965661367192848881", 82, 9 };

} // mcl::bn

inline const CurveParam& getCurveParam(int type)
{
	switch (type) {
	case 0: return bn::CurveFp254BNb;
	case 1: return bn::CurveFp382_1;
	case 2: return bn::CurveFp382_2;
	case 3: return bn::CurveFp462;
	case 4: return bn::CurveSNARK1;
	default:
		throw cybozu::Exception("getCurveParam:bad type") << type;
	}
}

namespace util {
} // mcl::util

} // mcl

