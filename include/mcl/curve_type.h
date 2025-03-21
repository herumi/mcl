#pragma once
/**
	@file
	@brief curve type
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

enum {
	MCL_BN254 = 0,
	MCL_BN381_1 = 1,
	MCL_BN381_2 = 2,
	MCL_BN462 = 3, // deprecated
	MCL_BN_SNARK1 = 4,
	MCL_BLS12_381 = 5,
	MCL_BN160 = 6,
	MCL_BLS12_461 = 7, // deprecated
	MCL_BLS12_377 = 8,
	MCL_BN_P256 = 9,

	/*
		for only G1
		the size of curve must be <= MCLBN_FP_UNIT_SIZE
	*/
	MCL_EC_BEGIN = 100,
	MCL_SECP192K1 = MCL_EC_BEGIN,
	MCL_SECP224K1 = 101,
	MCL_SECP256K1 = 102,
	MCL_SECP384R1 = 103,
	MCL_SECP521R1 = 104, // deprecated
	MCL_NIST_P192 = 105,
	MCL_NIST_P224 = 106,
	MCL_NIST_P256 = 107,
	MCL_SECP160K1 = 108,
	MCL_P160_1 = 109,
	MCL_EC_END = MCL_P160_1 + 1,
	MCL_NIST_P384 = MCL_SECP384R1,
	MCL_NIST_P521 = MCL_SECP521R1 // deprecated
};

/*
	remark : if irtf-cfrg-hash-to-curve is compeletely fixed, then
	MCL_MAP_TO_MODE_WB19, MCL_MAP_TO_MODE_HASH_TO_CURVE_0? will be removed and
	only MCL_MAP_TO_MODE_HASH_TO_CURVE will be available.
*/
enum {
	MCL_MAP_TO_MODE_ORIGINAL, // see MapTo::calcBN
	MCL_MAP_TO_MODE_TRY_AND_INC, // try-and-incremental-x
	MCL_MAP_TO_MODE_ETH2, // (deprecated) old eth2.0 spec
	MCL_MAP_TO_MODE_WB19, // (deprecated) used in new eth2.0 spec
	MCL_MAP_TO_MODE_HASH_TO_CURVE_05 = MCL_MAP_TO_MODE_WB19, // (deprecated) draft-irtf-cfrg-hash-to-curve-05
	MCL_MAP_TO_MODE_HASH_TO_CURVE_06, // (deprecated) draft-irtf-cfrg-hash-to-curve-06
	MCL_MAP_TO_MODE_HASH_TO_CURVE_07 = 5, /* don't change this value! */ // draft-irtf-cfrg-hash-to-curve-07
	MCL_MAP_TO_MODE_HASH_TO_CURVE = MCL_MAP_TO_MODE_HASH_TO_CURVE_07, // the latset version
	MCL_MAP_TO_MODE_ETH2_LEGACY // (deprecated) backwards compatible version of MCL_MAP_TO_MODE_ETH2 with commit 730c50d4eaff1e0d685a92ac8c896e873749471b
};

