#pragma once
/**
	@file
	@brief C api of somewhat homomorphic encryption with one-time multiplication, based on prime-order pairings
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/bn.h>

#ifdef _MSC_VER
#ifdef MCLSHE_DLL_EXPORT
#define MCLSHE_DLL_API __declspec(dllexport)
#else
#define MCLSHE_DLL_API __declspec(dllimport)
#ifndef MCLSHE_NO_AUTOLINK
	#if MCLBN_FP_UNIT_SIZE == 4
		#pragma comment(lib, "mclshe256.lib")
	#elif MCLBN_FP_UNIT_SIZE == 6
		#pragma comment(lib, "mclshe384.lib")
	#else
		#pragma comment(lib, "mclshe512.lib")
	#endif
#endif
#endif
#else
#ifdef __EMSCRIPTEN__
	#define MCLSHE_DLL_API __attribute__((used))
#else
	#define MCLSHE_DLL_API
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
	mclBnFr x;
	mclBnFr y;
} sheSecretKey;

typedef struct {
	mclBnG1 xP;
	mclBnG2 yQ;
} shePublicKey;

typedef struct {
	mclBnG1 S;
	mclBnG1 T;
} sheCipherTextG1;

typedef struct {
	mclBnG2 S;
	mclBnG2 T;
} sheCipherTextG2;

typedef struct {
	mclBnGT g[4];
} sheCipherTextGT;

/*
	initialize this library
	call this once before using the other functions
	@param curve [in] enum value defined in mcl/bn.h
	@param maxUnitSize [in] MCLBN_FP_UNIT_SIZE (fixed)
	return 0 if success
	@note sheInit() is thread safe and serialized if it is called simultaneously
	but don't call it while using other functions.
*/
MCLSHE_DLL_API int sheInit(int curve, int maxUnitSize);

// return written byte size if success else 0
MCLSHE_DLL_API size_t sheSecretKeySerialize(void *buf, size_t maxBufSize, const sheSecretKey *sec);
MCLSHE_DLL_API size_t shePublicKeySerialize(void *buf, size_t maxBufSize, const shePublicKey *pub);
MCLSHE_DLL_API size_t sheCipherTextG1Serialize(void *buf, size_t maxBufSize, const sheCipherTextG1 *c);
MCLSHE_DLL_API size_t sheCipherTextG2Serialize(void *buf, size_t maxBufSize, const sheCipherTextG2 *c);
MCLSHE_DLL_API size_t sheCipherTextGTSerialize(void *buf, size_t maxBufSize, const sheCipherTextGT *c);

// return 0 if success
MCLSHE_DLL_API int sheSecretKeyDeserialize(sheSecretKey* sec, const void *buf, size_t bufSize);
MCLSHE_DLL_API int shePublicKeyDeserialize(shePublicKey* pub, const void *buf, size_t bufSize);
MCLSHE_DLL_API int sheCipherTextG1Deserialize(sheCipherTextG1* c, const void *buf, size_t bufSize);
MCLSHE_DLL_API int sheCipherTextG2Deserialize(sheCipherTextG2* c, const void *buf, size_t bufSize);
MCLSHE_DLL_API int sheCipherTextGTDeserialize(sheCipherTextGT* c, const void *buf, size_t bufSize);

/*
	set secretKey if system has /dev/urandom or CryptGenRandom
	return 0 if success
*/
MCLSHE_DLL_API int sheSecretKeySetByCSPRNG(sheSecretKey *sec);

MCLSHE_DLL_API void sheGetPublicKey(shePublicKey *pub, const sheSecretKey *sec);

/*
	make table to decode DLP
	return 0 if success
*/
MCLSHE_DLL_API int sheSetRangeForDLP(size_t hashSize, size_t tryNum);
MCLSHE_DLL_API int sheSetRangeForG1DLP(size_t hashSize, size_t tryNum);
MCLSHE_DLL_API int sheSetRangeForG2DLP(size_t hashSize, size_t tryNum);
MCLSHE_DLL_API int sheSetRangeForGTDLP(size_t hashSize, size_t tryNum);

// return 0 if success
MCLSHE_DLL_API int sheEncG1(sheCipherTextG1 *c, const shePublicKey *pub, int64_t m);
MCLSHE_DLL_API int sheEncG2(sheCipherTextG2 *c, const shePublicKey *pub, int64_t m);
MCLSHE_DLL_API int sheEncGT(sheCipherTextGT *c, const shePublicKey *pub, int64_t m);

// for JavaScript
MCLSHE_DLL_API int sheEnc32G1(sheCipherTextG1 *c, const shePublicKey *pub, int m);
MCLSHE_DLL_API int sheEnc32G2(sheCipherTextG2 *c, const shePublicKey *pub, int m);
MCLSHE_DLL_API int sheEnc32GT(sheCipherTextGT *c, const shePublicKey *pub, int m);

/*
	decode c and set m
	return 0 if success
*/
MCLSHE_DLL_API int sheDecG1(int64_t *m, const sheSecretKey *sec, const sheCipherTextG1 *c);
MCLSHE_DLL_API int sheDecG2(int64_t *m, const sheSecretKey *sec, const sheCipherTextG2 *c);
MCLSHE_DLL_API int sheDecGT(int64_t *m, const sheSecretKey *sec, const sheCipherTextGT *c);

/*
	return 1 if dec(c) == 0
*/
MCLSHE_DLL_API int sheIsZeroG1(const sheSecretKey *sec, const sheCipherTextG1 *c);
MCLSHE_DLL_API int sheIsZeroG2(const sheSecretKey *sec, const sheCipherTextG2 *c);
MCLSHE_DLL_API int sheIsZeroGT(const sheSecretKey *sec, const sheCipherTextGT *c);

// return 0 if success
// z = x + y
MCLSHE_DLL_API int sheAddG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, const sheCipherTextG1 *y);
MCLSHE_DLL_API int sheAddG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, const sheCipherTextG2 *y);
MCLSHE_DLL_API int sheAddGT(sheCipherTextGT *z, const sheCipherTextGT *x, const sheCipherTextGT *y);

// return 0 if success
// z = x - y
MCLSHE_DLL_API int sheSubG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, const sheCipherTextG1 *y);
MCLSHE_DLL_API int sheSubG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, const sheCipherTextG2 *y);
MCLSHE_DLL_API int sheSubGT(sheCipherTextGT *z, const sheCipherTextGT *x, const sheCipherTextGT *y);

// return 0 if success
// z = x * y
MCLSHE_DLL_API int sheMulG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, int64_t y);
MCLSHE_DLL_API int sheMulG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, int64_t y);
MCLSHE_DLL_API int sheMulGT(sheCipherTextGT *z, const sheCipherTextGT *x, int64_t y);

// for JavaScript
MCLSHE_DLL_API int sheMul32G1(sheCipherTextG1 *z, const sheCipherTextG1 *x, int y);
MCLSHE_DLL_API int sheMul32G2(sheCipherTextG2 *z, const sheCipherTextG2 *x, int y);
MCLSHE_DLL_API int sheMul32GT(sheCipherTextGT *z, const sheCipherTextGT *x, int y);

// return 0 if success
// z = x * y
MCLSHE_DLL_API int sheMul(sheCipherTextGT *z, const sheCipherTextG1 *x, const sheCipherTextG2 *y);

// return 0 if success
// rerandomize(c)
MCLSHE_DLL_API int sheReRandG1(sheCipherTextG1 *c, const shePublicKey *pub);
MCLSHE_DLL_API int sheReRandG2(sheCipherTextG2 *c, const shePublicKey *pub);
MCLSHE_DLL_API int sheReRandGT(sheCipherTextGT *c, const shePublicKey *pub);

// return 0 if success
// y = convert(x)
MCLSHE_DLL_API int sheConvertG1(sheCipherTextGT *y, const shePublicKey *pub, const sheCipherTextG1 *x);
MCLSHE_DLL_API int sheConvertG2(sheCipherTextGT *y, const shePublicKey *pub, const sheCipherTextG2 *x);

#ifdef __cplusplus
}
#endif
