#pragma once
/**
	@file
	@brief C interface of 256/384-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifndef MBN_FP_UNIT_SIZE
	#error "define MBN_FP_UNIT_SIZE 4(or 6)"
#endif

#include <stdint.h> // for uint64_t, uint8_t
#include <stdlib.h> // for size_t

#ifdef _MSC_VER
#ifdef MBN_DLL_EXPORT
#define MBN_DLL_API __declspec(dllexport)
#else
#define MBN_DLL_API __declspec(dllimport)
#ifndef MCL_NO_AUTOLINK
	#if MBN_FP_UNIT_SIZE == 4
		#pragma comment(lib, "mclbn256.lib")
	#else
		#pragma comment(lib, "mclbn384.lib")
	#endif
#endif
#endif
#else
#define MBN_DLL_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef MBN_DEFINE_STRUCT

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE];
} mbnFr;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 3];
} mbnG1;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 2 * 3];
} mbnG2;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 12];
} mbnGT;

#else

typedef struct mbnFr mbnFr;
typedef struct mbnG1 mbnG1;
typedef struct mbnG2 mbnG2;
typedef struct mbnGT mbnGT;

#endif

/*
	set errlog file name
	use stderr if name == "stderr"
	close if name == ""
	return 0 if success
	@note not threadsafe
*/
MBN_DLL_API int mbn_setErrFile(const char *name);

enum {
	mbn_curveFp254BNb = 0,
	mbn_curveFp382_1 = 1,
	mbn_curveFp382_2 = 2
};

/*
	init library
	@param curve [in] type of bn curve
	@param maxUnitSize [in] 4 or 6
	curve = MBN_CurveFp254BNb is allowed if maxUnitSize = 4
	curve = MBN_CurveFp254BNb/MBN_CurveFp382_1/MBN_CurveFp382_2 are allowed if maxUnitSize = 6
	@note not threadsafe
	@note MBN_init is used in libeay32
*/
MBN_DLL_API int mbn_init(int curve, int maxUnitSize);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void mbnFr_clear(mbnFr *x);

// set x to y
MBN_DLL_API void mbnFr_setInt(mbnFr *y, int x);

/*
	ioMode
	10 : decimal number
	16 : hexadecimal number
*/
// return 0 if success
MBN_DLL_API int mbnFr_setStr(mbnFr *x, const char *buf, size_t bufSize, int ioMode);
// mask buf with (1 << (bitLen(r) - 1)) - 1 if buf >= r
MBN_DLL_API int mbnFr_setLittleEndian(mbnFr *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int mbnFr_isValid(const mbnFr *x);
MBN_DLL_API int mbnFr_isEqual(const mbnFr *x, const mbnFr *y);
MBN_DLL_API int mbnFr_isZero(const mbnFr *x);
MBN_DLL_API int mbnFr_isOne(const mbnFr *x);

MBN_DLL_API void mbnFr_setByCSPRNG(mbnFr *x);

// hash(s) and set x
MBN_DLL_API int mbnFr_setHashOf(mbnFr *x, const void *buf, size_t bufSize);

// return strlen(buf) if sucess else 0
MBN_DLL_API size_t mbnFr_getStr(char *buf, size_t maxBufSize, const mbnFr *x, int ioMode);
// return written byte if sucess else 0
MBN_DLL_API size_t mbnFr_getLittleEndian(void *buf, size_t bufSize, const mbnFr *x);

MBN_DLL_API void mbnFr_neg(mbnFr *y, const mbnFr *x);
MBN_DLL_API void mbnFr_inv(mbnFr *y, const mbnFr *x);
MBN_DLL_API void mbnFr_add(mbnFr *z, const mbnFr *x, const mbnFr *y);
MBN_DLL_API void mbnFr_sub(mbnFr *z, const mbnFr *x, const mbnFr *y);
MBN_DLL_API void mbnFr_mul(mbnFr *z, const mbnFr *x, const mbnFr *y);
MBN_DLL_API void mbnFr_div(mbnFr *z, const mbnFr *x, const mbnFr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void mbnG1_clear(mbnG1 *x);

// return 0 if success
MBN_DLL_API int mbnG1_setStr(mbnG1 *x, const char *buf, size_t bufSize, int ioMode);
MBN_DLL_API int mbnG1_deserialize(mbnG1 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int mbnG1_isValid(const mbnG1 *x);
MBN_DLL_API int mbnG1_isEqual(const mbnG1 *x, const mbnG1 *y);
MBN_DLL_API int mbnG1_isZero(const mbnG1 *x);

MBN_DLL_API int mbnG1_hashAndMapTo(mbnG1 *x, const void *buf, size_t bufSize);

// return 0 if success
MBN_DLL_API size_t mbnG1_getStr(char *buf, size_t maxBufSize, const mbnG1 *x, int ioMode);
// return written size if sucess else 0
MBN_DLL_API size_t mbnG1_serialize(void *buf, size_t maxBufSize, const mbnG1 *x);

MBN_DLL_API void mbnG1_neg(mbnG1 *y, const mbnG1 *x);
MBN_DLL_API void mbnG1_dbl(mbnG1 *y, const mbnG1 *x);
MBN_DLL_API void mbnG1_add(mbnG1 *z, const mbnG1 *x, const mbnG1 *y);
MBN_DLL_API void mbnG1_sub(mbnG1 *z, const mbnG1 *x, const mbnG1 *y);
MBN_DLL_API void mbnG1_mul(mbnG1 *z, const mbnG1 *x, const mbnFr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void mbnG2_clear(mbnG2 *x);

// return 0 if success
MBN_DLL_API int mbnG2_setStr(mbnG2 *x, const char *buf, size_t bufSize, int ioMode);
MBN_DLL_API int mbnG2_deserialize(mbnG2 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int mbnG2_isValid(const mbnG2 *x);
MBN_DLL_API int mbnG2_isEqual(const mbnG2 *x, const mbnG2 *y);
MBN_DLL_API int mbnG2_isZero(const mbnG2 *x);

MBN_DLL_API int mbnG2_hashAndMapTo(mbnG2 *x, const void *buf, size_t bufSize);

// return 0 if success
MBN_DLL_API size_t mbnG2_getStr(char *buf, size_t maxBufSize, const mbnG2 *x, int ioMode);
// return written size if sucess else 0
MBN_DLL_API size_t mbnG2_serialize(void *buf, size_t maxBufSize, const mbnG2 *x);

MBN_DLL_API void mbnG2_neg(mbnG2 *y, const mbnG2 *x);
MBN_DLL_API void mbnG2_dbl(mbnG2 *y, const mbnG2 *x);
MBN_DLL_API void mbnG2_add(mbnG2 *z, const mbnG2 *x, const mbnG2 *y);
MBN_DLL_API void mbnG2_sub(mbnG2 *z, const mbnG2 *x, const mbnG2 *y);
MBN_DLL_API void mbnG2_mul(mbnG2 *z, const mbnG2 *x, const mbnFr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void mbnGT_clear(mbnGT *x);

// return 0 if success
MBN_DLL_API int mbnGT_setStr(mbnGT *x, const char *buf, size_t bufSize, int ioMode);
MBN_DLL_API int mbnGT_deserialize(mbnGT *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int mbnGT_isEqual(const mbnGT *x, const mbnGT *y);
MBN_DLL_API int mbnGT_isZero(const mbnGT *x);
MBN_DLL_API int mbnGT_isOne(const mbnGT *x);

// return 0 if success
MBN_DLL_API size_t mbnGT_getStr(char *buf, size_t maxBufSize, const mbnGT *x, int ioMode);
// return written size if sucess else 0
MBN_DLL_API size_t mbnGT_serialize(void *buf, size_t maxBufSize, const mbnGT *x);

MBN_DLL_API void mbnGT_neg(mbnGT *y, const mbnGT *x);
MBN_DLL_API void mbnGT_inv(mbnGT *y, const mbnGT *x);
MBN_DLL_API void mbnGT_add(mbnGT *z, const mbnGT *x, const mbnGT *y);
MBN_DLL_API void mbnGT_sub(mbnGT *z, const mbnGT *x, const mbnGT *y);
MBN_DLL_API void mbnGT_mul(mbnGT *z, const mbnGT *x, const mbnGT *y);
MBN_DLL_API void mbnGT_div(mbnGT *z, const mbnGT *x, const mbnGT *y);

MBN_DLL_API void mbnGT_pow(mbnGT *z, const mbnGT *x, const mbnFr *y);

MBN_DLL_API void mbn_pairing(mbnGT *z, const mbnG1 *x, const mbnG2 *y);
MBN_DLL_API void mbn_finalExp(mbnGT *y, const mbnGT *x);
MBN_DLL_API void mbn_millerLoop(mbnGT *z, const mbnG1 *x, const mbnG2 *y);

// return precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t)
MBN_DLL_API int mbn_getUint64NumToPrecompute(void);

// allocate Qbuf[MBN_getUint64NumToPrecompute()] before calling this
MBN_DLL_API void mbn_precomputeG2(uint64_t *Qbuf, const mbnG2 *Q);

MBN_DLL_API void mbn_precomputedMillerLoop(mbnGT *f, const mbnG1 *P, const uint64_t *Qbuf);
MBN_DLL_API void mbn_precomputedMillerLoop2(mbnGT *f, const mbnG1 *P1, const uint64_t *Q1buf, const mbnG1 *P2, const uint64_t *Q2buf);

#ifdef __cplusplus
}
#endif
