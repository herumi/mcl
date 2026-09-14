#pragma once
/**
	@file
	@brief invMod definition
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/config.hpp>

namespace mcl {

namespace inv {

#if MCL_SIZEOF_UNIT == 4
typedef int32_t Sint;
static const int modL = 30;
#else
typedef int64_t Sint;
static const int modL = 62;
#endif
static const Sint modN = Sint(1) << modL;
static const Sint half = modN / 2;
static const Sint MASK = modN - 1;
// a signed limb of modL bits (secp256k1_modinv{64,32}_signed{62,30})
typedef Sint Limb;

template<int N>
struct InvModT {
	// the number of limbs : ceil((UnitBitSize N + 2) / modL) so that -2M < d, e < M fits
	static const int L = (MCL_UNIT_BIT_SIZE * N + modL + 1) / modL;
	Limb M[L]; // M in signed limbs
	Unit Mi; // M^-1 mod 2^modL
};

} } // mcl::inv

