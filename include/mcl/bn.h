#pragma once
/**
	@file
	@brief C interface of 256/384-bit optimal ate pairing over BN curves
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifndef MCLBN_FP_UNIT_SIZE
	#error "define MCLBN_FP_UNIT_SIZE 4(, 6 or 8)"
#endif

#include <stdint.h> // for uint64_t, uint8_t
#include <stdlib.h> // for size_t


#if defined(_MSC_VER)
	#ifdef MCLBN_DLL_EXPORT
		#define MCLBN_DLL_API __declspec(dllexport)
	#else
		#define MCLBN_DLL_API __declspec(dllimport)
		#ifndef MCLBN_NO_AUTOLINK
			#if MCLBN_FP_UNIT_SIZE == 4
				#pragma comment(lib, "mclbn256.lib")
			#elif MCLBN_FP_UNIT_SIZE == 6
				#pragma comment(lib, "mclbn384.lib")
			#else
				#pragma comment(lib, "mclbn512.lib")
			#endif
		#endif
	#endif
#elif defined(__EMSCRIPTEN__)
	#define MCLBN_DLL_API __attribute__((used))
#else
	#define MCLBN_DLL_API
#endif

#ifdef __EMSCRIPTEN__
	// avoid 64-bit integer
	#define mclSize unsigned int
	#define mclInt int
#else
	// use #define for cgo
	#define mclSize size_t
	#define mclInt int64_t
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
	mclBn_CurveFp382_2 = 2,
	mclBn_CurveFp462 = 3,
	mclBn_CurveSNARK1 = 4
};

/*
	init library
	@param curve [in] type of bn curve
	@param maxUnitSize [in] MCLBN_FP_UNIT_SIZE
	curve = MCLBN_CurveFp254BNb is allowed if maxUnitSize = 4
	curve = MCLBN_CurveFp254BNb/MCLBN_CurveFp382_1/MCLBN_CurveFp382_2 are allowed if maxUnitSize = 6
	This parameter is used to detect a library compiled with different MCLBN_FP_UNIT_SIZE for safety.
	@note not threadsafe
	@note MCLBN_init is used in libeay32
*/
MCLBN_DLL_API int mclBn_init(int curve, int maxUnitSize);


/*
	pairing : G1 x G2 -> GT
	#G1 = #G2 = r
	G1 is a curve defined on Fp

	serialized size of elements
	|Fr| = |G1| = 32 bytes (if CurveFp254BNb), 48 bytes (if CurevFp382_{1,2})
	|G2| = |G1| * 2
	|GT| = |G1| * 12
*/
/*
	return the num of Unit(=uint64_t) to store Fr
	4 if curve is mclBn_CurveFp254BNb
	6 if curve is mclBn_CurveFp382_{1,2}
*/
MCLBN_DLL_API int mclBn_getOpUnitSize();

/*
	return decimal string of the order of the curve(=the characteristic of Fr)
	return str(buf) if success
*/
MCLBN_DLL_API mclSize mclBn_getCurveOrder(char *buf, mclSize maxBufSize);

/*
	return decimal string of the characteristic of Fp
	return str(buf) if success
*/
MCLBN_DLL_API mclSize mclBn_getFieldOrder(char *buf, mclSize maxBufSize);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnFr_clear(mclBnFr *x);

// set x to y
MCLBN_DLL_API void mclBnFr_setInt(mclBnFr *y, mclInt x);
MCLBN_DLL_API void mclBnFr_setInt32(mclBnFr *y, int x);

/*
	ioMode
	10 : decimal number
	16 : hexadecimal number
*/
// return 0 if success
MCLBN_DLL_API int mclBnFr_setStr(mclBnFr *x, const char *buf, mclSize bufSize, int ioMode);
MCLBN_DLL_API mclSize mclBnFr_deserialize(mclBnFr *x, const void *buf, mclSize bufSize);
// mask buf with (1 << (bitLen(r) - 1)) - 1 if buf >= r
MCLBN_DLL_API int mclBnFr_setLittleEndian(mclBnFr *x, const void *buf, mclSize bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnFr_isValid(const mclBnFr *x);
MCLBN_DLL_API int mclBnFr_isEqual(const mclBnFr *x, const mclBnFr *y);
MCLBN_DLL_API int mclBnFr_isZero(const mclBnFr *x);
MCLBN_DLL_API int mclBnFr_isOne(const mclBnFr *x);

// return 0 if success
MCLBN_DLL_API int mclBnFr_setByCSPRNG(mclBnFr *x);

// hash(s) and set x
// return 0 if success
MCLBN_DLL_API int mclBnFr_setHashOf(mclBnFr *x, const void *buf, mclSize bufSize);

// return strlen(buf) if sucess else 0
MCLBN_DLL_API mclSize mclBnFr_getStr(char *buf, mclSize maxBufSize, const mclBnFr *x, int ioMode);
// return written byte if sucess else 0
MCLBN_DLL_API mclSize mclBnFr_serialize(void *buf, mclSize maxBufSize, const mclBnFr *x);

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
MCLBN_DLL_API int mclBnG1_setStr(mclBnG1 *x, const char *buf, mclSize bufSize, int ioMode);
MCLBN_DLL_API mclSize mclBnG1_deserialize(mclBnG1 *x, const void *buf, mclSize bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnG1_isValid(const mclBnG1 *x);
MCLBN_DLL_API int mclBnG1_isEqual(const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API int mclBnG1_isZero(const mclBnG1 *x);

MCLBN_DLL_API int mclBnG1_hashAndMapTo(mclBnG1 *x, const void *buf, mclSize bufSize);

// return 0 if success
MCLBN_DLL_API mclSize mclBnG1_getStr(char *buf, mclSize maxBufSize, const mclBnG1 *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API mclSize mclBnG1_serialize(void *buf, mclSize maxBufSize, const mclBnG1 *x);

MCLBN_DLL_API void mclBnG1_neg(mclBnG1 *y, const mclBnG1 *x);
MCLBN_DLL_API void mclBnG1_dbl(mclBnG1 *y, const mclBnG1 *x);
MCLBN_DLL_API void mclBnG1_add(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API void mclBnG1_sub(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y);
MCLBN_DLL_API void mclBnG1_mul(mclBnG1 *z, const mclBnG1 *x, const mclBnFr *y);

/*
	constant time mul
*/
MCLBN_DLL_API void mclBnG1_mulCT(mclBnG1 *z, const mclBnG1 *x, const mclBnFr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnG2_clear(mclBnG2 *x);

// return 0 if success
MCLBN_DLL_API int mclBnG2_setStr(mclBnG2 *x, const char *buf, mclSize bufSize, int ioMode);
MCLBN_DLL_API mclSize mclBnG2_deserialize(mclBnG2 *x, const void *buf, mclSize bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnG2_isValid(const mclBnG2 *x);
MCLBN_DLL_API int mclBnG2_isEqual(const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API int mclBnG2_isZero(const mclBnG2 *x);

MCLBN_DLL_API int mclBnG2_hashAndMapTo(mclBnG2 *x, const void *buf, mclSize bufSize);

// return 0 if success
MCLBN_DLL_API mclSize mclBnG2_getStr(char *buf, mclSize maxBufSize, const mclBnG2 *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API mclSize mclBnG2_serialize(void *buf, mclSize maxBufSize, const mclBnG2 *x);

MCLBN_DLL_API void mclBnG2_neg(mclBnG2 *y, const mclBnG2 *x);
MCLBN_DLL_API void mclBnG2_dbl(mclBnG2 *y, const mclBnG2 *x);
MCLBN_DLL_API void mclBnG2_add(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API void mclBnG2_sub(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y);
MCLBN_DLL_API void mclBnG2_mul(mclBnG2 *z, const mclBnG2 *x, const mclBnFr *y);
/*
	constant time mul
*/
MCLBN_DLL_API void mclBnG2_mulCT(mclBnG2 *z, const mclBnG2 *x, const mclBnFr *y);

////////////////////////////////////////////////
// set zero
MCLBN_DLL_API void mclBnGT_clear(mclBnGT *x);
// set x to y
MCLBN_DLL_API void mclBnGT_setInt(mclBnGT *y, mclInt x);
MCLBN_DLL_API void mclBnGT_setInt32(mclBnGT *y, int x);

// return 0 if success
MCLBN_DLL_API int mclBnGT_setStr(mclBnGT *x, const char *buf, mclSize bufSize, int ioMode);
MCLBN_DLL_API mclSize mclBnGT_deserialize(mclBnGT *x, const void *buf, mclSize bufSize);

// return 1 if true and 0 otherwise
MCLBN_DLL_API int mclBnGT_isEqual(const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API int mclBnGT_isZero(const mclBnGT *x);
MCLBN_DLL_API int mclBnGT_isOne(const mclBnGT *x);

// return 0 if success
MCLBN_DLL_API mclSize mclBnGT_getStr(char *buf, mclSize maxBufSize, const mclBnGT *x, int ioMode);
// return written size if sucess else 0
MCLBN_DLL_API mclSize mclBnGT_serialize(void *buf, mclSize maxBufSize, const mclBnGT *x);

MCLBN_DLL_API void mclBnGT_neg(mclBnGT *y, const mclBnGT *x);
MCLBN_DLL_API void mclBnGT_inv(mclBnGT *y, const mclBnGT *x);
MCLBN_DLL_API void mclBnGT_add(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_sub(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_mul(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);
MCLBN_DLL_API void mclBnGT_div(mclBnGT *z, const mclBnGT *x, const mclBnGT *y);

/*
	pow for all elements of Fp12
*/
MCLBN_DLL_API void mclBnGT_powGeneric(mclBnGT *z, const mclBnGT *x, const mclBnFr *y);
/*
	pow for only {x|x^r = 1} in Fp12 by GLV method
	the value generated by pairing satisfies the condition
*/
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

/*
	Lagrange interpolation
	recover out = y(0) by { (xVec[i], yVec[i]) }
	return 0 if success else -1
	@note k >= 2, xVec[i] != 0, xVec[i] != xVec[j] for i != j
*/
MCLBN_DLL_API int mclBn_FrLagrangeInterpolation(mclBnFr *out, const mclBnFr *xVec, const mclBnFr *yVec, mclSize k);
MCLBN_DLL_API int mclBn_G1LagrangeInterpolation(mclBnG1 *out, const mclBnFr *xVec, const mclBnG1 *yVec, mclSize k);
MCLBN_DLL_API int mclBn_G2LagrangeInterpolation(mclBnG2 *out, const mclBnFr *xVec, const mclBnG2 *yVec, mclSize k);

/*
	evaluate polynomial
	out = f(x) = c[0] + c[1] * x + c[2] * x^2 + ... + c[cSize - 1] * x^(cSize - 1)
	@note cSize >= 2
*/
MCLBN_DLL_API int mclBn_FrEvaluatePolynomial(mclBnFr *out, const mclBnFr *cVec, mclSize cSize, const mclBnFr *x);
MCLBN_DLL_API int mclBn_G1EvaluatePolynomial(mclBnG1 *out, const mclBnG1 *cVec, mclSize cSize, const mclBnFr *x);
MCLBN_DLL_API int mclBn_G2EvaluatePolynomial(mclBnG2 *out, const mclBnG2 *cVec, mclSize cSize, const mclBnFr *x);


#ifdef __cplusplus
}
#endif
