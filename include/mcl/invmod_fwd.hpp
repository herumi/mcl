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
typedef int32_t INT;
static const int modL = 30;
#else
typedef int64_t INT;
static const int modL = 62;
#endif
static const INT modN = INT(1) << modL;
static const INT half = modN / 2;
static const INT MASK = modN - 1;

template<int N>
struct InvModT {
	Unit lowM; // M mod 2^UnitBitSize
	Unit Mi; // M^-1 mod 2^modL
	Unit M[N + 1]; // zero-extended to N + 1 units
	// f, g, d, e of exec are (N + 1)-unit two's complement values if wide
	// (M >= 2^(UnitBitSize N - 2)) and N-unit values otherwise (see init)
	bool wide;
};

} } // mcl::inv

