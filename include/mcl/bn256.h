#pragma once
/**
	@file
	@brief C interface of 256-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifdef BN256_DEFINE_STRUCT

typedef struct {
	uint64_t d[4];
} BN256_Fr; // sizeof(BN256_Fr) = 32

typedef struct {
	uint64_t d[4 * 3];
} BN256_G1; // sizeof(BN256_G1) = 96

typedef struct {
	uint64_t d[4 * 2 * 3];
} BN256_G2; // sizeof(BN256_G2) == 192

typedef struct {
	uint64_t d[4 * 12];
} BN256_GT; // sizeof(BN256_GT) == 384

#else

typedef struct BN256_Fr BN256_Fr;
typedef struct BN256_G1 BN256_G1;
typedef struct BN256_G2 BN256_G2;
typedef struct BN256_GT BN256_GT;

#endif

#ifdef _MSC_VER
#ifdef BN256_DLL_EXPORT
#define BN256_DLL_API __declspec(dllexport)
#else
#define BN256_DLL_API __declspec(dllimport)
#ifndef MCL_NO_AUTOLINK
	#pragma comment(lib, "bn256.lib")
#endif
#endif
#else
#define BN256_DLL_API
#endif

/*
	set errlog file name
	use stderr if name == "stderr"
	close if name == ""
	return 0 if success
*/
BN256_DLL_API int BN256_setErrFile(const char *name);

BN256_DLL_API int BN256_init(void);

////////////////////////////////////////////////
// set zero
BN256_DLL_API void BN256_Fr_clear(BN256_Fr *x);

// set x to y
BN256_DLL_API void BN256_Fr_setInt(BN256_Fr *y, int x);

BN256_DLL_API void BN256_Fr_copy(BN256_Fr *y, const BN256_Fr *x);

// return 0 if success
BN256_DLL_API int BN256_Fr_setStr(BN256_Fr *x, const char *s);

// return 1 if true and 0 otherwise
BN256_DLL_API int BN256_Fr_isValid(const BN256_Fr *x);
BN256_DLL_API int BN256_Fr_isSame(const BN256_Fr *x, const BN256_Fr *y);
BN256_DLL_API int BN256_Fr_isZero(const BN256_Fr *x);
BN256_DLL_API int BN256_Fr_isOne(const BN256_Fr *x);

BN256_DLL_API void BN256_Fr_setRand(BN256_Fr *x);

// hash(s) and set x
BN256_DLL_API void BN256_Fr_setMsg(BN256_Fr *x, const char *s);

// return 0 if success
BN256_DLL_API int BN256_Fr_getStr(char *buf, int maxBufSize, const BN256_Fr *x);

BN256_DLL_API void BN256_Fr_neg(BN256_Fr *y, const BN256_Fr *x);
BN256_DLL_API void BN256_Fr_inv(BN256_Fr *y, const BN256_Fr *x);
BN256_DLL_API void BN256_Fr_add(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y);
BN256_DLL_API void BN256_Fr_sub(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y);
BN256_DLL_API void BN256_Fr_mul(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y);
BN256_DLL_API void BN256_Fr_div(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y);

////////////////////////////////////////////////
// set zero
BN256_DLL_API void BN256_G1_clear(BN256_G1 *x);

BN256_DLL_API void BN256_G1_copy(BN256_G1 *y, const BN256_G1 *x);

// return 0 if success
BN256_DLL_API int BN256_G1_setStr(BN256_G1 *x, const char *s);

// return 1 if true and 0 otherwise
BN256_DLL_API int BN256_G1_isValid(const BN256_G1 *x);
BN256_DLL_API int BN256_G1_isSame(const BN256_G1 *x, const BN256_G1 *y);
BN256_DLL_API int BN256_G1_isZero(const BN256_G1 *x);

BN256_DLL_API int BN256_G1_hashAndMapTo(BN256_G1 *x, const char *s);

// return 0 if success
BN256_DLL_API int BN256_G1_getStr(char *buf, int maxBufSize, const BN256_G1 *x);

BN256_DLL_API void BN256_G1_neg(BN256_G1 *y, const BN256_G1 *x);
BN256_DLL_API void BN256_G1_dbl(BN256_G1 *y, const BN256_G1 *x);
BN256_DLL_API void BN256_G1_add(BN256_G1 *z, const BN256_G1 *x, const BN256_G1 *y);
BN256_DLL_API void BN256_G1_sub(BN256_G1 *z, const BN256_G1 *x, const BN256_G1 *y);
BN256_DLL_API void BN256_G1_mul(BN256_G1 *z, const BN256_G1 *x, const BN256_Fr *y);

////////////////////////////////////////////////
// set zero
BN256_DLL_API void BN256_G2_clear(BN256_G2 *x);

BN256_DLL_API void BN256_G2_copy(BN256_G2 *y, const BN256_G2 *x);

// return 0 if success
BN256_DLL_API int BN256_G2_setStr(BN256_G2 *x, const char *s);

// return 1 if true and 0 otherwise
BN256_DLL_API int BN256_G2_isValid(const BN256_G2 *x);
BN256_DLL_API int BN256_G2_isSame(const BN256_G2 *x, const BN256_G2 *y);
BN256_DLL_API int BN256_G2_isZero(const BN256_G2 *x);

BN256_DLL_API int BN256_G2_hashAndMapTo(BN256_G2 *x, const char *s);

// return 0 if success
BN256_DLL_API int BN256_G2_getStr(char *buf, int maxBufSize, const BN256_G2 *x);

BN256_DLL_API void BN256_G2_neg(BN256_G2 *y, const BN256_G2 *x);
BN256_DLL_API void BN256_G2_dbl(BN256_G2 *y, const BN256_G2 *x);
BN256_DLL_API void BN256_G2_add(BN256_G2 *z, const BN256_G2 *x, const BN256_G2 *y);
BN256_DLL_API void BN256_G2_sub(BN256_G2 *z, const BN256_G2 *x, const BN256_G2 *y);
BN256_DLL_API void BN256_G2_mul(BN256_G2 *z, const BN256_G2 *x, const BN256_Fr *y);

////////////////////////////////////////////////
// set zero
BN256_DLL_API void BN256_GT_clear(BN256_GT *x);

BN256_DLL_API void BN256_GT_copy(BN256_GT *y, const BN256_GT *x);

// return 0 if success
BN256_DLL_API int BN256_GT_setStr(BN256_GT *x, const char *s);

// return 1 if true and 0 otherwise
BN256_DLL_API int BN256_GT_isSame(const BN256_GT *x, const BN256_GT *y);
BN256_DLL_API int BN256_GT_isZero(const BN256_GT *x);
BN256_DLL_API int BN256_GT_isOne(const BN256_GT *x);

// return 0 if success
BN256_DLL_API int BN256_GT_getStr(char *buf, int maxBufSize, const BN256_GT *x);

BN256_DLL_API void BN256_GT_neg(BN256_GT *y, const BN256_GT *x);
BN256_DLL_API void BN256_GT_inv(BN256_GT *y, const BN256_GT *x);
BN256_DLL_API void BN256_GT_add(BN256_GT *z, const BN256_GT *x, const BN256_GT *y);
BN256_DLL_API void BN256_GT_sub(BN256_GT *z, const BN256_GT *x, const BN256_GT *y);
BN256_DLL_API void BN256_GT_mul(BN256_GT *z, const BN256_GT *x, const BN256_GT *y);
BN256_DLL_API void BN256_GT_div(BN256_GT *z, const BN256_GT *x, const BN256_GT *y);

BN256_DLL_API void BN256_GT_finalExp(BN256_GT *y, const BN256_GT *x);
BN256_DLL_API void BN256_GT_pow(BN256_GT *z, const BN256_GT *x, const BN256_Fr *y);

BN256_DLL_API void BN256_pairing(BN256_GT *z, const BN256_G1 *x, const BN256_G2 *y);
BN256_DLL_API void BN256_millerLoop(BN256_GT *z, const BN256_G1 *x, const BN256_G2 *y);

#ifdef __cplusplus
}
#endif
