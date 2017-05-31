#pragma once
/**
	@file
	@brief C interface of 256/384-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifndef MCLBN_MAX_OP_UNIT_SIZE
	#error "define MCLBN_MAX_OP_UNIT_SIZE 4(or 6)"
#endif

#include <stdint.h> // for uint64_t, uint8_t
#include <stdlib.h> // for size_t

#ifdef _MSC_VER
#ifdef MCLBN_DLL_EXPORT
#define MCLBN_DLL_API __declspec(dllexport)
#else
#define MCLBN_DLL_API __declspec(dllimport)
#ifndef MCL_NO_AUTOLINK
	#if MCLBN_MAX_OP_UNIT_SIZE == 4
		#pragma comment(lib, "bn_if256.lib")
	#else
		#pragma comment(lib, "bn_if384.lib")
	#endif
#endif
#endif
#else
#define MCLBN_DLL_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef MCLBN_DEFINE_STRUCT

typedef struct {
	uint64_t d[MCLBN_MAX_OP_UNIT_SIZE];
} MCLBN_Fr;

typedef struct {
	uint64_t d[MCLBN_MAX_OP_UNIT_SIZE * 3];
} MCLBN_G1;

typedef struct {
	uint64_t d[MCLBN_MAX_OP_UNIT_SIZE * 2 * 3];
} MCLBN_G2;

typedef struct {
	uint64_t d[MCLBN_MAX_OP_UNIT_SIZE * 12];
} MCLBN_GT;

#else

typedef struct MCLBN_Fr MCLBN_Fr;
typedef struct MCLBN_G1 MCLBN_G1;
typedef struct MCLBN_G2 MCLBN_G2;
typedef struct MCLBN_GT MCLBN_GT;

#endif

/*
	set errlog file name
	use stderr if name == "stderr"
	close if name == ""
	return 0 if success
	@note not threadsafe
*/
MCLBN_DLL_API int MCLBN_setErrFile(const char *name);

enum {
	MCLBN_curveFp254BNb = 0,
	MCLBN_curveFp382_1 = 1,
	MCLBN_curveFp382_2 = 2
};

/*
	init library
	@param curve [in] type of bn curve
	@param maxUnitSize [in] 4 or 6
	curve = MCLBN_CurveFp254BNb is allowed if maxUnitSize = 4
	curve = MCLBN_CurveFp254BNb/MCLBN_CurveFp382_1/MCLBN_CurveFp382_2 are allowed if maxUnitSize = 6
	@note not threadsafe
	@note MCLBN_init is used in libeay32
*/
MCLBN_DLL_API int MCLBN_initLib(int curve, int maxUnitSize);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void MCLBN_Fr_clear(MCLBN_Fr *x);

// set x to y
MCLBN_DLL_API void MCLBN_Fr_setInt(MCLBN_Fr *y, int x);

// return 0 if success
MCLBN_DLL_API int MCLBN_Fr_setDecStr(MCLBN_Fr *x, const char *buf, size_t bufSize);
MCLBN_DLL_API int MCLBN_Fr_setHexStr(MCLBN_Fr *x, const char *buf, size_t bufSize);
// mask buf with (1 << (bitLen(r) - 1)) - 1 if buf >= r
MCLBN_DLL_API int MCLBN_Fr_setLittleEndian(MCLBN_Fr *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int MCLBN_Fr_isValid(const MCLBN_Fr *x);
MCLBN_DLL_API int MCLBN_Fr_isEqual(const MCLBN_Fr *x, const MCLBN_Fr *y);
MCLBN_DLL_API int MCLBN_Fr_isZero(const MCLBN_Fr *x);
MCLBN_DLL_API int MCLBN_Fr_isOne(const MCLBN_Fr *x);

MCLBN_DLL_API void MCLBN_Fr_setByCSPRNG(MCLBN_Fr *x);

// hash(s) and set x
MCLBN_DLL_API void MCLBN_hashToFr(MCLBN_Fr *x, const void *buf, size_t bufSize);

// return strlen(buf) if sucess else 0
MCLBN_DLL_API size_t MCLBN_Fr_getDecStr(char *buf, size_t maxBufSize, const MCLBN_Fr *x);
MCLBN_DLL_API size_t MCLBN_Fr_getHexStr(char *buf, size_t maxBufSize, const MCLBN_Fr *x);
// return written byte if sucess else 0
MCLBN_DLL_API size_t MCLBN_Fr_getLittleEndian(void *buf, size_t bufSize, const MCLBN_Fr *x);

MCLBN_DLL_API void MCLBN_Fr_neg(MCLBN_Fr *y, const MCLBN_Fr *x);
MCLBN_DLL_API void MCLBN_Fr_inv(MCLBN_Fr *y, const MCLBN_Fr *x);
MCLBN_DLL_API void MCLBN_Fr_add(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y);
MCLBN_DLL_API void MCLBN_Fr_sub(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y);
MCLBN_DLL_API void MCLBN_Fr_mul(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y);
MCLBN_DLL_API void MCLBN_Fr_div(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void MCLBN_G1_clear(MCLBN_G1 *x);

// return 0 if success
MCLBN_DLL_API int MCLBN_G1_setHexStr(MCLBN_G1 *x, const char *buf, size_t bufSize);
MCLBN_DLL_API int MCLBN_G1_deserialize(MCLBN_G1 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int MCLBN_G1_isValid(const MCLBN_G1 *x);
MCLBN_DLL_API int MCLBN_G1_isEqual(const MCLBN_G1 *x, const MCLBN_G1 *y);
MCLBN_DLL_API int MCLBN_G1_isZero(const MCLBN_G1 *x);

MCLBN_DLL_API int MCLBN_hashAndMapToG1(MCLBN_G1 *x, const void *buf, size_t bufSize);

// return 0 if success
MCLBN_DLL_API size_t MCLBN_G1_getHexStr(char *buf, size_t maxBufSize, const MCLBN_G1 *x);
// return written size if sucess else 0
MCLBN_DLL_API size_t MCLBN_G1_serialize(void *buf, size_t maxBufSize, const MCLBN_G1 *x);

MCLBN_DLL_API void MCLBN_G1_neg(MCLBN_G1 *y, const MCLBN_G1 *x);
MCLBN_DLL_API void MCLBN_G1_dbl(MCLBN_G1 *y, const MCLBN_G1 *x);
MCLBN_DLL_API void MCLBN_G1_add(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_G1 *y);
MCLBN_DLL_API void MCLBN_G1_sub(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_G1 *y);
MCLBN_DLL_API void MCLBN_G1_mul(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_Fr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void MCLBN_G2_clear(MCLBN_G2 *x);

// return 0 if success
MCLBN_DLL_API int MCLBN_G2_setHexStr(MCLBN_G2 *x, const char *buf, size_t bufSize);
MCLBN_DLL_API int MCLBN_G2_deserialize(MCLBN_G2 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int MCLBN_G2_isValid(const MCLBN_G2 *x);
MCLBN_DLL_API int MCLBN_G2_isEqual(const MCLBN_G2 *x, const MCLBN_G2 *y);
MCLBN_DLL_API int MCLBN_G2_isZero(const MCLBN_G2 *x);

MCLBN_DLL_API int MCLBN_hashAndMapToG2(MCLBN_G2 *x, const void *buf, size_t bufSize);

// return 0 if success
MCLBN_DLL_API size_t MCLBN_G2_getHexStr(char *buf, size_t maxBufSize, const MCLBN_G2 *x);
// return written size if sucess else 0
MCLBN_DLL_API size_t MCLBN_G2_serialize(void *buf, size_t maxBufSize, const MCLBN_G2 *x);

MCLBN_DLL_API void MCLBN_G2_neg(MCLBN_G2 *y, const MCLBN_G2 *x);
MCLBN_DLL_API void MCLBN_G2_dbl(MCLBN_G2 *y, const MCLBN_G2 *x);
MCLBN_DLL_API void MCLBN_G2_add(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_G2 *y);
MCLBN_DLL_API void MCLBN_G2_sub(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_G2 *y);
MCLBN_DLL_API void MCLBN_G2_mul(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_Fr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void MCLBN_GT_clear(MCLBN_GT *x);

// return 0 if success
MCLBN_DLL_API int MCLBN_GT_setDecStr(MCLBN_GT *x, const char *buf, size_t bufSize);
MCLBN_DLL_API int MCLBN_GT_setHexStr(MCLBN_GT *x, const char *buf, size_t bufSize);
MCLBN_DLL_API int MCLBN_GT_deserialize(MCLBN_GT *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int MCLBN_GT_isEqual(const MCLBN_GT *x, const MCLBN_GT *y);
MCLBN_DLL_API int MCLBN_GT_isZero(const MCLBN_GT *x);
MCLBN_DLL_API int MCLBN_GT_isOne(const MCLBN_GT *x);

// return 0 if success
MCLBN_DLL_API size_t MCLBN_GT_getDecStr(char *buf, size_t maxBufSize, const MCLBN_GT *x);
MCLBN_DLL_API size_t MCLBN_GT_getHexStr(char *buf, size_t maxBufSize, const MCLBN_GT *x);
// return written size if sucess else 0
MCLBN_DLL_API size_t MCLBN_GT_serialize(void *buf, size_t maxBufSize, const MCLBN_GT *x);

MCLBN_DLL_API void MCLBN_GT_neg(MCLBN_GT *y, const MCLBN_GT *x);
MCLBN_DLL_API void MCLBN_GT_inv(MCLBN_GT *y, const MCLBN_GT *x);
MCLBN_DLL_API void MCLBN_GT_add(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y);
MCLBN_DLL_API void MCLBN_GT_sub(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y);
MCLBN_DLL_API void MCLBN_GT_mul(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y);
MCLBN_DLL_API void MCLBN_GT_div(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y);

MCLBN_DLL_API void MCLBN_GT_pow(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_Fr *y);

MCLBN_DLL_API void MCLBN_pairing(MCLBN_GT *z, const MCLBN_G1 *x, const MCLBN_G2 *y);
MCLBN_DLL_API void MCLBN_finalExp(MCLBN_GT *y, const MCLBN_GT *x);
MCLBN_DLL_API void MCLBN_millerLoop(MCLBN_GT *z, const MCLBN_G1 *x, const MCLBN_G2 *y);

// return precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t)
MCLBN_DLL_API int MCLBN_getUint64NumToPrecompute(void);

// allocate Qbuf[MCLBN_getUint64NumToPrecompute()] before calling this
MCLBN_DLL_API void MCLBN_precomputeG2(uint64_t *Qbuf, const MCLBN_G2 *Q);

MCLBN_DLL_API void MCLBN_precomputedMillerLoop(MCLBN_GT *f, const MCLBN_G1 *P, const uint64_t *Qbuf);
MCLBN_DLL_API void MCLBN_precomputedMillerLoop2(MCLBN_GT *f, const MCLBN_G1 *P1, const uint64_t *Q1buf, const MCLBN_G1 *P2, const uint64_t *Q2buf);

#ifdef __cplusplus
}
#endif
