#pragma once
/**
	@file
	@brief curve type
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/curve_type.h>

namespace mcl {

struct CurveParam {
	/*
		y^2 = x^3 + b
		i^2 = -u
		xi = xi_a + i
		v^3 = xi
		w^2 = v
	*/
	const char *z;
	int b; // y^2 = x^3 + b
	int xi_a; // xi = xi_a + i
	/*
		BN254, BN381, BLS12_377 : Dtype
		BLS12-381, BN_P256 : Mtype
	*/
	bool isMtype;
	int curveType; // same in curve_type.h
	int u; // Fp2 = Fp[X]/(X^2+u)
	CurveParam(const char *z = "", int b = 0, int xi_a = 0, bool isMtype = false, int curveType = 0, int u = 1)
		: z(z), b(b), xi_a(xi_a), isMtype(isMtype), curveType(curveType), u(u) {}
	bool operator==(const CurveParam& rhs) const
	{
		return curveType == rhs.curveType;
	}
	bool operator!=(const CurveParam& rhs) const { return !operator==(rhs); }
};

const CurveParam BN254("-0x4080000000000001", 2, 1, false, MCL_BN254); // -(2^62 + 2^55 + 1)
const CurveParam BN_P256("-0x6882f5c030b0a801", 3, 1, true, MCL_BN_P256); // BN P256 defined in TCG Algorithm Registry Family "2.0", Revision 1.32
// provisional(experimental) param with maxBitSize = 384
const CurveParam BN381_1("-0x400011000000000000000001", 2, 1, false, MCL_BN381_1); // -(2^94 + 2^76 + 2^72 + 1) // A Family of Implementation-Friendly BN Elliptic Curves
const CurveParam BN381_2("-0x400040090001000000000001", 2, 1, false, MCL_BN381_2); // -(2^94 + 2^78 + 2^67 + 2^64 + 2^48 + 1) // used in relic-toolkit
const CurveParam BN462("0x4001fffffffffffffffffffffbfff", 5, 2, false, MCL_BN462); // 2^114 + 2^101 - 2^14 - 1 // https://eprint.iacr.org/2017/334
const CurveParam BN_SNARK1("4965661367192848881", 3, 9, false, MCL_BN_SNARK1);
const CurveParam BLS12_381("-0xd201000000010000", 4, 1, true, MCL_BLS12_381);
const CurveParam BN160("0x4000000031", 3, 4, false, MCL_BN160);
const CurveParam BLS12_461("-0x1ffffffbfffe00000000", 4, 1, true, MCL_BLS12_461);
const CurveParam BLS12_377("0x8508c00000000001", 1, 0, false, MCL_BLS12_377, 5);

#ifdef __clang__
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wreturn-type-c-linkage"
#endif
inline const CurveParam* getCurveParam(int type)
{
	switch (type) {
	case MCL_BN254: return &mcl::BN254;
	case MCL_BN_P256: return &mcl::BN_P256;
	case MCL_BN381_1: return &mcl::BN381_1;
	case MCL_BN381_2: return &mcl::BN381_2;
	case MCL_BN462: return &mcl::BN462;
	case MCL_BN_SNARK1: return &mcl::BN_SNARK1;
	case MCL_BLS12_381: return &mcl::BLS12_381;
	case MCL_BLS12_377: return &mcl::BLS12_377;
	case MCL_BN160: return &mcl::BN160;
	default:
		return CYBOZU_NULLPTR;
	}
}
#ifdef __clang__
	#pragma GCC diagnostic pop
#endif

} // mcl
