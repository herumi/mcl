#pragma once
/**
	@file
	@brief C interface of 256/384-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifndef MCLBN_FP_UNIT_SIZE
	#error "define MCLBN_FP_UNIT_SIZE 4(or 6)"
#endif

#include <stdint.h> // for uint64_t, uint8_t
#include <stdlib.h> // for size_t

#ifdef _MSC_VER
#ifdef MCLBN_DLL_EXPORT
#define MCLBN_DLL_API __declspec(dllexport)
#else
#define MCLBN_DLL_API __declspec(dllimport)
#ifndef MCL_NO_AUTOLINK
	#if MCLBN_FP_UNIT_SIZE == 4
		#pragma comment(lib, "mclbn256.lib")
	#else
		#pragma comment(lib, "mclbn384.lib")
	#endif
#endif
#endif
#else
#define MCLBN_DLL_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef MCLBN_NOT_DEFINE_STRUCT

typedef struct mclBnFr mclBnFr;
typedef struct mclBnG1 mclBnG1;
typedef struct mclBnG2 mclBnG2;
typedef struct mclBnGT mclBnGT;

#else

typedef struct {
	uint64_t d[MCLBN_FP_UNIT_SIZE];
} mclBnFr;

typedef struct {
	uint64_t d[MCLBN_FP_UNIT_SIZE * 3];
} mclBnG1;

typedef struct {
	uint64_t d[MCLBN_FP_UNIT_SIZE * 2 * 3];
} mclBnG2;

typedef struct {
	uint64_t d[MCLBN_FP_UNIT_SIZE * 12];
} mclBnGT;

#endif

/*
	set errlog file name
	use stderr if name == "stderr"
	close if name == ""
	return 0 if success
	@note not threadsafe
*/
MCLBN_DLL_API int mclBn_setErrFile(const char *name);

enum {
	mclBn_CurveFp254BNb = 0,
	mclBn_CurveFp382_1 = 1,
	mclBn_CurveFp382_2 = 2
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
MCLBN_DLL_API int mclBn_init(int curve, int maxUnitSize);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnFr_clear(mclBnFr *x);

// set x to y
MCLBN_DLL_API void mclBnFr_setInt(mclBnFr *y, int x);

/*
	ioMode
	10 : decimal number
	16 : hexadecimal number
*/
// return 0 if success
MCLBN_DLL_API int mclBnFr_setStr(mclBnFr *x, const char *buf, size_t bufSize, int ioMode);
MCLBN_DLL_API int mclBnFr_deserialize(mclBnFr *x, const void *buf, size_t bufSize);
// mask buf with (1 << (bitLen(r) - 1)) - 1 if buf >= r
MCLBN_DLL_API int mclBnFr_setLittleEndian(mclBnFr *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnFr_isValid(const mclBnFr *x);
MCLBN_DLL_API int mclBnFr_isEqual(const mclBnFr *x, const mclBnFr *y);
MCLBN_DLL_API int mclBnFr_isZero(const mclBnFr *x);
MCLBN_DLL_API int mclBnFr_isOne(const mclBnFr *x);

// return 0 if success
MCLBN_DLL_API int mclBnFr_setByCSPRNG(mclBnFr *x);

// hash(s) and set x
// return 0 if success
MCLBN_DLL_API int mclBnFr_setHashOf(mclBnFr *x, const void *buf, size_t bufSize);

// return strlen(buf) if sucess else 0
MCLBN_DLL_API size_t mclBnFr_getStr(char *buf, size_t maxBufSize, const mclBnFr *x, int ioMode);
// return written byte if sucess else 0
MCLBN_DLL_API size_t mclBnFr_serialize(void *buf, size_t maxBufSize, const mclBnFr *x);

MCLBN_DLL_API void mclBnFr_neg(mclBnFr *y, const mclBnFr *x);
MCLBN_DLL_API void mclBnFr_inv(mclBnFr *y, const mclBnFr *x);
MCLBN_DLL_API void mclBnFr_add(mclBnFr *z, const mclBnFr *x, const mclBnFr *y);
MCLBN_DLL_API void mclBnFr_sub(mclBnFr *z, const mclBnFr *x, const mclBnFr *y);
MCLBN_DLL_API void mclBnFr_mul(mclBnFr *z, const mclBnFr *x, const mclBnFr *y);
MCLBN_DLL_API void mclBnFr_div(mclBnFr *z, const mclBnFr *x, const mclBnFr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnG1_clear(mclBnG1 *x);

// return 0 if success
MCLBN_DLL_API int mclBnG1_setStr(mclBnG1 *x, const char *buf, size_t bufSize, int ioMode);
MCLBN_DLL_API int mclBnG1_deserialize(mclBnG1 *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnG1_isValid(const mclBnG1 *x);
MCLBN_DLL_API int mclBnG1_isEqual(const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API int mclBnG1_isZero(const mclBnG1 *x);

MCLBN_DLL_API int mclBnG1_hashAndMapTo(mclBnG1 *x, const void *buf, size_t bufSize);

// return 0 if success
MCLBN_DLL_API size_t mclBnG1_getStr(char *buf, size_t maxBufSize, const mclBnG1 *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API size_t mclBnG1_serialize(void *buf, size_t maxBufSize, const mclBnG1 *x);

MCLBN_DLL_API void mclBnG1_neg(mclBnG1 *y, const mclBnG1 *x);
MCLBN_DLL_API void mclBnG1_dbl(mclBnG1 *y, const mclBnG1 *x);
MCLBN_DLL_API void mclBnG1_add(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API void mclBnG1_sub(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API void mclBnG1_mul(mclBnG1 *z, const mclBnG1 *x, const mclBnFr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnG2_clear(mclBnG2 *x);

// return 0 if success
MCLBN_DLL_API int mclBnG2_setStr(mclBnG2 *x, const char *buf, size_t bufSize, int ioMode);
MCLBN_DLL_API int mclBnG2_deserialize(mclBnG2 *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnG2_isValid(const mclBnG2 *x);
MCLBN_DLL_API int mclBnG2_isEqual(const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API int mclBnG2_isZero(const mclBnG2 *x);

MCLBN_DLL_API int mclBnG2_hashAndMapTo(mclBnG2 *x, const void *buf, size_t bufSize);

// return 0 if success
MCLBN_DLL_API size_t mclBnG2_getStr(char *buf, size_t maxBufSize, const mclBnG2 *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API size_t mclBnG2_serialize(void *buf, size_t maxBufSize, const mclBnG2 *x);

MCLBN_DLL_API void mclBnG2_neg(mclBnG2 *y, const mclBnG2 *x);
MCLBN_DLL_API void mclBnG2_dbl(mclBnG2 *y, const mclBnG2 *x);
MCLBN_DLL_API void mclBnG2_add(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API void mclBnG2_sub(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API void mclBnG2_mul(mclBnG2 *z, const mclBnG2 *x, const mclBnFr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnGT_clear(mclBnGT *x);

// return 0 if success
MCLBN_DLL_API int mclBnGT_setStr(mclBnGT *x, const char *buf, size_t bufSize, int ioMode);
MCLBN_DLL_API int mclBnGT_deserialize(mclBnGT *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnGT_isEqual(const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API int mclBnGT_isZero(const mclBnGT *x);
MCLBN_DLL_API int mclBnGT_isOne(const mclBnGT *x);

// return 0 if success
MCLBN_DLL_API size_t mclBnGT_getStr(char *buf, size_t maxBufSize, const mclBnGT *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API size_t mclBnGT_serialize(void *buf, size_t maxBufSize, const mclBnGT *x);

MCLBN_DLL_API void mclBnGT_neg(mclBnGT *y, const mclBnGT *x);
MCLBN_DLL_API void mclBnGT_inv(mclBnGT *y, const mclBnGT *x);
MCLBN_DLL_API void mclBnGT_add(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_sub(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_mul(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_div(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);

MCLBN_DLL_API void mclBnGT_pow(mclBnGT *z, const mclBnGT *x, const mclBnFr *y);

MCLBN_DLL_API void mclBn_pairing(mclBnGT *z, const mclBnG1 *x, const mclBnG2 *y);
MCLBN_DLL_API void mclBn_finalExp(mclBnGT *y, const mclBnGT *x);
MCLBN_DLL_API void mclBn_millerLoop(mclBnGT *z, const mclBnG1 *x, const mclBnG2 *y);

// return precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t)
MCLBN_DLL_API int mclBn_getUint64NumToPrecompute(void);

// allocate Qbuf[MCLBN_getUint64NumToPrecompute()] before calling this
MCLBN_DLL_API void mclBn_precomputeG2(uint64_t *Qbuf, const mclBnG2 *Q);

MCLBN_DLL_API void mclBn_precomputedMillerLoop(mclBnGT *f, const mclBnG1 *P, const uint64_t *Qbuf);
MCLBN_DLL_API void mclBn_precomputedMillerLoop2(mclBnGT *f, const mclBnG1 *P1, const uint64_t *Q1buf, const mclBnG1 *P2, const uint64_t *Q2buf);

#ifdef __cplusplus
}
#endif
