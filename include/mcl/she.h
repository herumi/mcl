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
MCLSHE_DLL_API mclSize sheSecretKeySerialize(void *buf, mclSize maxBufSize, const sheSecretKey *sec);
MCLSHE_DLL_API mclSize shePublicKeySerialize(void *buf, mclSize maxBufSize, const shePublicKey *pub);
MCLSHE_DLL_API mclSize sheCipherTextG1Serialize(void *buf, mclSize maxBufSize, const sheCipherTextG1 *c);
MCLSHE_DLL_API mclSize sheCipherTextG2Serialize(void *buf, mclSize maxBufSize, const sheCipherTextG2 *c);
MCLSHE_DLL_API mclSize sheCipherTextGTSerialize(void *buf, mclSize maxBufSize, const sheCipherTextGT *c);

// return read byte size if sucess else 0
MCLSHE_DLL_API mclSize sheSecretKeyDeserialize(sheSecretKey* sec, const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize shePublicKeyDeserialize(shePublicKey* pub, const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize sheCipherTextG1Deserialize(sheCipherTextG1* c, const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize sheCipherTextG2Deserialize(sheCipherTextG2* c, const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize sheCipherTextGTDeserialize(sheCipherTextGT* c, const void *buf, mclSize bufSize);

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
MCLSHE_DLL_API int sheSetRangeForDLP(mclSize hashSize, mclSize tryNum);
MCLSHE_DLL_API int sheSetRangeForG1DLP(mclSize hashSize, mclSize tryNum);
MCLSHE_DLL_API int sheSetRangeForG2DLP(mclSize hashSize, mclSize tryNum);
MCLSHE_DLL_API int sheSetRangeForGTDLP(mclSize hashSize, mclSize tryNum);

/*
	load table for DLP
	return read size if success else 0
*/
MCLSHE_DLL_API mclSize sheLoadTableForG1DLP(const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize sheLoadTableForG2DLP(const void *buf, mclSize bufSize);
MCLSHE_DLL_API mclSize sheLoadTableForGTDLP(const void *buf, mclSize bufSize);

/*
	save table for DLP
	return written size if success else 0
*/
MCLSHE_DLL_API mclSize sheSaveTableForG1DLP(void *buf, mclSize maxBufSize);
MCLSHE_DLL_API mclSize sheSaveTableForG2DLP(void *buf, mclSize maxBufSize);
MCLSHE_DLL_API mclSize sheSaveTableForGTDLP(void *buf, mclSize maxBufSize);

// return 0 if success
MCLSHE_DLL_API int sheEncG1(sheCipherTextG1 *c, const shePublicKey *pub, mclInt m);
MCLSHE_DLL_API int sheEncG2(sheCipherTextG2 *c, const shePublicKey *pub, mclInt m);
MCLSHE_DLL_API int sheEncGT(sheCipherTextGT *c, const shePublicKey *pub, mclInt m);

/*
	decode c and set m
	return 0 if success
*/
MCLSHE_DLL_API int sheDecG1(mclInt *m, const sheSecretKey *sec, const sheCipherTextG1 *c);
MCLSHE_DLL_API int sheDecG2(mclInt *m, const sheSecretKey *sec, const sheCipherTextG2 *c);
MCLSHE_DLL_API int sheDecGT(mclInt *m, const sheSecretKey *sec, const sheCipherTextGT *c);

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
MCLSHE_DLL_API int sheMulG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, mclInt y);
MCLSHE_DLL_API int sheMulG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, mclInt y);
MCLSHE_DLL_API int sheMulGT(sheCipherTextGT *z, const sheCipherTextGT *x, mclInt y);

// return 0 if success
// z = x * y
MCLSHE_DLL_API int sheMul(sheCipherTextGT *z, const sheCipherTextG1 *x, const sheCipherTextG2 *y);
/*
	sheMul(z, x, y) = sheMulML(z, x, y) + sheFinalExpGT(z)
	@note
	Mul(x1, y1) + ... + Mul(xn, yn) = finalExp(MulML(x1, y1) + ... + MulML(xn, yn))
*/
MCLSHE_DLL_API int sheMulML(sheCipherTextGT *z, const sheCipherTextG1 *x, const sheCipherTextG2 *y);
MCLSHE_DLL_API int sheFinalExpGT(sheCipherTextGT *y, const sheCipherTextGT *x);

// return 0 if success
// rerandomize(c)
MCLSHE_DLL_API int sheReRandG1(sheCipherTextG1 *c, const shePublicKey *pub);
MCLSHE_DLL_API int sheReRandG2(sheCipherTextG2 *c, const shePublicKey *pub);
MCLSHE_DLL_API int sheReRandGT(sheCipherTextGT *c, const shePublicKey *pub);

// return 0 if success
// y = convert(x)
MCLSHE_DLL_API int sheConvertG1(sheCipherTextGT *y, const shePublicKey *pub, const sheCipherTextG1 *x);
MCLSHE_DLL_API int sheConvertG2(sheCipherTextGT *y, const shePublicKey *pub, const sheCipherTextG2 *x);

struct shePrecomputedPublicKey;
MCLSHE_DLL_API shePrecomputedPublicKey *shePrecomputedPublicKeyCreate();
MCLSHE_DLL_API void shePrecomputedPublicKeyDestroy(shePrecomputedPublicKey *ppub);
// return 0 if success
MCLSHE_DLL_API int shePrecomputedPublicKeyInit(shePrecomputedPublicKey *ppub, const shePublicKey *pub);
MCLSHE_DLL_API int shePrecomputedPublicKeyEncG1(sheCipherTextG1 *c, const shePrecomputedPublicKey *ppub, mclInt m);
MCLSHE_DLL_API int shePrecomputedPublicKeyEncG2(sheCipherTextG2 *c, const shePrecomputedPublicKey *ppub, mclInt m);
MCLSHE_DLL_API int shePrecomputedPublicKeyEncGT(sheCipherTextGT *c, const shePrecomputedPublicKey *ppub, mclInt m);

#ifdef __cplusplus
}
#endif
