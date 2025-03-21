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
	#define MCL_DONT_USE_MALLOC
#endif

#ifndef MCL_SIZEOF_UNIT
	#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
		#define MCL_SIZEOF_UNIT 4
	#else
		#define MCL_SIZEOF_UNIT 8
	#endif
#endif

#if MCL_SIZEOF_UNIT == 8
	#define MCL_U64_TO_UNIT(x) mcl::Unit(x)
#else
	#define MCL_U64_TO_UNIT(x) mcl::Unit(x), mcl::Unit(uint64_t(x)>>32)
#endif

#ifdef MCL_STANDALONE
	#define MCL_DONT_USE_OPENSSL
	#define CYBOZU_DONT_USE_STRING
	#define CYBOZU_DONT_USE_EXCEPTION
	#define MCL_DONT_USE_CSPRNG
	#define MCL_DONT_USE_MALLOC
#endif

#include <stdint.h> // for uint64_t, uint8_t
#include <stddef.h> // for size_t

// check MCL_MAX_BIT_SIZE and MCL_MAX_FP_BYTE for backward compatilibity
#ifdef MCL_MAX_BIT_SIZE
	#ifndef MCL_MAX_FP_BYTE
		#define MCL_MAX_FP_BYTE ((MCL_MAX_BIT_SIZE)/8)
	#endif
#endif

#ifndef MCL_MAX_FP_BYTE
	#define MCL_MAX_FP_BYTE 48
#endif

#ifndef MCL_MAX_BIT_SIZE
	#define MCL_MAX_BIT_SIZE ((MCL_MAX_FP_BYTE)*8)
#endif

#if MCL_MAX_BIT_SIZE != ((MCL_MAX_FP_BYTE)*8)
	#error "bad MCL_MAX_BIT_SIZE"
#endif

#ifndef MCL_MAX_FR_BYTE
	#define MCL_MAX_FR_BYTE 32
#endif

#if !defined(MCL_USE_OPENSSL) && !defined(MCL_DONT_USE_OPENSSL)
	#define MCL_DONT_USE_OPENSSL
#endif

#if !defined(MCL_USE_GMP) && !defined(MCL_USE_VINT)
	#define MCL_USE_VINT
#endif

#define MCL_UNIT_BIT_SIZE (MCL_SIZEOF_UNIT * 8)
#define MCL_ROUNDUP(x, n) (((x) + (n) - 1) / (n))

#define MCL_MAX_UNIT_SIZE MCL_ROUNDUP(MCL_MAX_BIT_SIZE, MCL_UNIT_BIT_SIZE)

#ifdef _MSC_VER
	#ifdef MCL_DLL_EXPORT
		#define MCL_DLL_API __declspec(dllexport)
	#else
		#define MCL_DLL_API
	#endif
#else
	#define MCL_DLL_API
#endif

#ifdef __cplusplus
namespace mcl {

#if MCL_SIZEOF_UNIT == 8
typedef uint64_t Unit;
#else
typedef uint32_t Unit;
#endif

const size_t UnitBitSize = sizeof(Unit) * 8;

static inline size_t roundUp(size_t x, size_t n)
{
	return (x + n - 1) / n;
}
template<size_t x, size_t n>
struct RoundUpT {
	static const size_t N = (x + n - 1) / n;
};

const size_t maxUnitSize = (MCL_MAX_BIT_SIZE + UnitBitSize - 1) / UnitBitSize;

} // mcl
#endif
