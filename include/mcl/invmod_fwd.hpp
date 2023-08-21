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
struct SintT {
	bool sign;
	Unit v[N];
};

template<int N>
struct InvModT {
	Unit lowM;
	Unit Mi;
	SintT<N> M;
};

} } // mcl::inv

