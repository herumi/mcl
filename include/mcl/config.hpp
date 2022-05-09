#pragma once
/**
	@file
	@brief constant macro
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cybozu/inttype.hpp>

#if defined(__EMSCRIPTEN__) || defined(__wasm__)
	#define MCL_SIZEOF_UNIT 4
	#define MCL_WASM32
#endif

#ifndef MCL_SIZEOF_UNIT
	#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
		#define MCL_SIZEOF_UNIT 4
	#else
		#define MCL_SIZEOF_UNIT 8
	#endif
#endif

#ifndef MCL_MAX_BIT_SIZE
	#define MCL_MAX_BIT_SIZE 512
#endif

namespace mcl {

#if MCL_SIZEOF_UNIT == 8
typedef uint64_t Unit;
#else
typedef uint32_t Unit;
#endif
#define MCL_UNIT_BIT_SIZE (MCL_SIZEOF_UNIT * 8)

const size_t UnitBitSize = sizeof(Unit) * 8;

const size_t maxUnitSize = (MCL_MAX_BIT_SIZE + UnitBitSize - 1) / UnitBitSize;
#define MCL_MAX_UNIT_SIZE ((MCL_MAX_BIT_SIZE + MCL_UNIT_BIT_SIZE - 1) / MCL_UNIT_BIT_SIZE)

} // mcl
