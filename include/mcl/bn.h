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
} MBN_Fr;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 3];
} MBN_G1;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 2 * 3];
} MBN_G2;

typedef struct {
	uint64_t d[MBN_FP_UNIT_SIZE * 12];
} MBN_GT;

#else

typedef struct MBN_Fr MBN_Fr;
typedef struct MBN_G1 MBN_G1;
typedef struct MBN_G2 MBN_G2;
typedef struct MBN_GT MBN_GT;

#endif

/*
	set errlog file name
	use stderr if name == "stderr"
	close if name == ""
	return 0 if success
	@note not threadsafe
*/
MBN_DLL_API int MBN_setErrFile(const char *name);

enum {
	MBN_curveFp254BNb = 0,
	MBN_curveFp382_1 = 1,
	MBN_curveFp382_2 = 2
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
MBN_DLL_API int MBN_init(int curve, int maxUnitSize);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void MBN_Fr_clear(MBN_Fr *x);

// set x to y
MBN_DLL_API void MBN_Fr_setInt(MBN_Fr *y, int x);

// return 0 if success
MBN_DLL_API int MBN_Fr_setDecStr(MBN_Fr *x, const char *buf, size_t bufSize);
MBN_DLL_API int MBN_Fr_setHexStr(MBN_Fr *x, const char *buf, size_t bufSize);
// mask buf with (1 << (bitLen(r) - 1)) - 1 if buf >= r
MBN_DLL_API int MBN_Fr_setLittleEndian(MBN_Fr *x, const void *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int MBN_Fr_isValid(const MBN_Fr *x);
MBN_DLL_API int MBN_Fr_isEqual(const MBN_Fr *x, const MBN_Fr *y);
MBN_DLL_API int MBN_Fr_isZero(const MBN_Fr *x);
MBN_DLL_API int MBN_Fr_isOne(const MBN_Fr *x);

MBN_DLL_API void MBN_Fr_setByCSPRNG(MBN_Fr *x);

// hash(s) and set x
MBN_DLL_API void MBN_hashToFr(MBN_Fr *x, const void *buf, size_t bufSize);

// return strlen(buf) if sucess else 0
MBN_DLL_API size_t MBN_Fr_getDecStr(char *buf, size_t maxBufSize, const MBN_Fr *x);
MBN_DLL_API size_t MBN_Fr_getHexStr(char *buf, size_t maxBufSize, const MBN_Fr *x);
// return written byte if sucess else 0
MBN_DLL_API size_t MBN_Fr_getLittleEndian(void *buf, size_t bufSize, const MBN_Fr *x);

MBN_DLL_API void MBN_Fr_neg(MBN_Fr *y, const MBN_Fr *x);
MBN_DLL_API void MBN_Fr_inv(MBN_Fr *y, const MBN_Fr *x);
MBN_DLL_API void MBN_Fr_add(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y);
MBN_DLL_API void MBN_Fr_sub(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y);
MBN_DLL_API void MBN_Fr_mul(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y);
MBN_DLL_API void MBN_Fr_div(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void MBN_G1_clear(MBN_G1 *x);

// return 0 if success
MBN_DLL_API int MBN_G1_setHexStr(MBN_G1 *x, const char *buf, size_t bufSize);
MBN_DLL_API int MBN_G1_deserialize(MBN_G1 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int MBN_G1_isValid(const MBN_G1 *x);
MBN_DLL_API int MBN_G1_isEqual(const MBN_G1 *x, const MBN_G1 *y);
MBN_DLL_API int MBN_G1_isZero(const MBN_G1 *x);

MBN_DLL_API int MBN_hashAndMapToG1(MBN_G1 *x, const void *buf, size_t bufSize);

// return 0 if success
MBN_DLL_API size_t MBN_G1_getHexStr(char *buf, size_t maxBufSize, const MBN_G1 *x);
// return written size if sucess else 0
MBN_DLL_API size_t MBN_G1_serialize(void *buf, size_t maxBufSize, const MBN_G1 *x);

MBN_DLL_API void MBN_G1_neg(MBN_G1 *y, const MBN_G1 *x);
MBN_DLL_API void MBN_G1_dbl(MBN_G1 *y, const MBN_G1 *x);
MBN_DLL_API void MBN_G1_add(MBN_G1 *z, const MBN_G1 *x, const MBN_G1 *y);
MBN_DLL_API void MBN_G1_sub(MBN_G1 *z, const MBN_G1 *x, const MBN_G1 *y);
MBN_DLL_API void MBN_G1_mul(MBN_G1 *z, const MBN_G1 *x, const MBN_Fr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void MBN_G2_clear(MBN_G2 *x);

// return 0 if success
MBN_DLL_API int MBN_G2_setHexStr(MBN_G2 *x, const char *buf, size_t bufSize);
MBN_DLL_API int MBN_G2_deserialize(MBN_G2 *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int MBN_G2_isValid(const MBN_G2 *x);
MBN_DLL_API int MBN_G2_isEqual(const MBN_G2 *x, const MBN_G2 *y);
MBN_DLL_API int MBN_G2_isZero(const MBN_G2 *x);

MBN_DLL_API int MBN_hashAndMapToG2(MBN_G2 *x, const void *buf, size_t bufSize);

// return 0 if success
MBN_DLL_API size_t MBN_G2_getHexStr(char *buf, size_t maxBufSize, const MBN_G2 *x);
// return written size if sucess else 0
MBN_DLL_API size_t MBN_G2_serialize(void *buf, size_t maxBufSize, const MBN_G2 *x);

MBN_DLL_API void MBN_G2_neg(MBN_G2 *y, const MBN_G2 *x);
MBN_DLL_API void MBN_G2_dbl(MBN_G2 *y, const MBN_G2 *x);
MBN_DLL_API void MBN_G2_add(MBN_G2 *z, const MBN_G2 *x, const MBN_G2 *y);
MBN_DLL_API void MBN_G2_sub(MBN_G2 *z, const MBN_G2 *x, const MBN_G2 *y);
MBN_DLL_API void MBN_G2_mul(MBN_G2 *z, const MBN_G2 *x, const MBN_Fr *y);

////////////////////////////////////////////////
// set zero
MBN_DLL_API void MBN_GT_clear(MBN_GT *x);

// return 0 if success
MBN_DLL_API int MBN_GT_setDecStr(MBN_GT *x, const char *buf, size_t bufSize);
MBN_DLL_API int MBN_GT_setHexStr(MBN_GT *x, const char *buf, size_t bufSize);
MBN_DLL_API int MBN_GT_deserialize(MBN_GT *x, const char *buf, size_t bufSize);

// return 1 if true and 0 otherwise
MBN_DLL_API int MBN_GT_isEqual(const MBN_GT *x, const MBN_GT *y);
MBN_DLL_API int MBN_GT_isZero(const MBN_GT *x);
MBN_DLL_API int MBN_GT_isOne(const MBN_GT *x);

// return 0 if success
MBN_DLL_API size_t MBN_GT_getDecStr(char *buf, size_t maxBufSize, const MBN_GT *x);
MBN_DLL_API size_t MBN_GT_getHexStr(char *buf, size_t maxBufSize, const MBN_GT *x);
// return written size if sucess else 0
MBN_DLL_API size_t MBN_GT_serialize(void *buf, size_t maxBufSize, const MBN_GT *x);

MBN_DLL_API void MBN_GT_neg(MBN_GT *y, const MBN_GT *x);
MBN_DLL_API void MBN_GT_inv(MBN_GT *y, const MBN_GT *x);
MBN_DLL_API void MBN_GT_add(MBN_GT *z, const MBN_GT *x, const MBN_GT *y);
MBN_DLL_API void MBN_GT_sub(MBN_GT *z, const MBN_GT *x, const MBN_GT *y);
MBN_DLL_API void MBN_GT_mul(MBN_GT *z, const MBN_GT *x, const MBN_GT *y);
MBN_DLL_API void MBN_GT_div(MBN_GT *z, const MBN_GT *x, const MBN_GT *y);

MBN_DLL_API void MBN_GT_pow(MBN_GT *z, const MBN_GT *x, const MBN_Fr *y);

MBN_DLL_API void MBN_pairing(MBN_GT *z, const MBN_G1 *x, const MBN_G2 *y);
MBN_DLL_API void MBN_finalExp(MBN_GT *y, const MBN_GT *x);
MBN_DLL_API void MBN_millerLoop(MBN_GT *z, const MBN_G1 *x, const MBN_G2 *y);

// return precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t)
MBN_DLL_API int MBN_getUint64NumToPrecompute(void);

// allocate Qbuf[MBN_getUint64NumToPrecompute()] before calling this
MBN_DLL_API void MBN_precomputeG2(uint64_t *Qbuf, const MBN_G2 *Q);

MBN_DLL_API void MBN_precomputedMillerLoop(MBN_GT *f, const MBN_G1 *P, const uint64_t *Qbuf);
MBN_DLL_API void MBN_precomputedMillerLoop2(MBN_GT *f, const MBN_G1 *P1, const uint64_t *Q1buf, const MBN_G1 *P2, const uint64_t *Q2buf);

#ifdef __cplusplus
}
#endif
