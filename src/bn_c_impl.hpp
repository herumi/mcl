#define MCLBN_DLL_EXPORT
#include <mcl/bn.h>
#if 0 // #if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
static std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
static cybozu::RandomGenerator g_rg;
#endif

#if MCLBN_FP_UNIT_SIZE == 4
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#elif MCLBN_FP_UNIT_SIZE == 6
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#elif MCLBN_FP_UNIT_SIZE == 8
#include <mcl/bn512.hpp>
using namespace mcl::bn512;
#endif
#include <mcl/lagrange.hpp>

static FILE *g_fp = NULL;

static Fr *cast(mclBnFr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const mclBnFr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(mclBnG1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const mclBnG1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(mclBnG2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const mclBnG2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(mclBnGT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const mclBnGT *p) { return reinterpret_cast<const Fp12*>(p); }

static Fp6 *cast(uint64_t *p) { return reinterpret_cast<Fp6*>(p); }
static const Fp6 *cast(const uint64_t *p) { return reinterpret_cast<const Fp6*>(p); }

static int closeErrFile()
{
	if (g_fp == NULL || g_fp == stderr) {
		return 0;
	}
	int ret = fclose(g_fp);
	g_fp = NULL;
	return ret;
}

template<class T>
mclSize getStr(void *buf, mclSize maxBufSize, const T *x, int ioMode, const char *msg)
	try
{
	std::string str;
	cast(x)->getStr(str, ioMode);
	mclSize terminate = (ioMode == 10 || ioMode == 16) ? 1 : 0;
	if (str.size() + terminate > maxBufSize) {
		if (g_fp) fprintf(g_fp, "%s:getStr:small maxBufSize %d %d %d\n", msg, (int)maxBufSize, (int)str.size(), (int)terminate);
		return 0;
	}
	memcpy(buf, str.c_str(), str.size());
	if (terminate) {
		((char *)buf)[str.size()] = '\0';
	}
	return str.size();
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s %s\n", msg, e.what());
	return 0;
}

template<class T>
mclSize serialize(void *buf, mclSize maxBufSize, const T *x, const char *msg)
	try
{
	return (mclSize)cast(x)->serialize(buf, maxBufSize);
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s %s\n", msg, e.what());
	return 0;
}

template<class T>
int setStr(T *x, const char *buf, mclSize bufSize, int ioMode, const char *msg)
	try
{
	cast(x)->setStr(std::string(buf, bufSize), ioMode);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s %s\n", msg, e.what());
	return -1;
}

template<class T>
mclSize deserialize(T *x, const void *buf, mclSize bufSize, const char *msg)
	try
{
	const size_t n = cast(x)->deserialize(buf, bufSize);
	return (mclSize)n;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s %s\n", msg, e.what());
	return 0;
}

int mclBn_setErrFile(const char *name)
{
	int ret = closeErrFile();
	if (name == NULL || *name == '\0') {
		return ret;
	}
	if (ret) return ret;
	if (strcmp(name, "stderr") == 0) {
		g_fp = stderr;
		return 0;
	}
#ifdef _MSC_VER
	return fopen_s(&g_fp, name, "wb");
#else
	g_fp = fopen(name, "wb");
	return  g_fp ? 0 : errno;
#endif
}

int mclBn_init(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != MCLBN_FP_UNIT_SIZE) {
		fprintf(stderr, "mclBn_init:maxUnitSize is mismatch %d %d\n", maxUnitSize, MCLBN_FP_UNIT_SIZE);
		return -1;
	}
	const mcl::CurveParam& cp = mcl::getCurveParam(curve);
	initPairing(cp);
	return 0;
} catch (std::exception& e) {
	fprintf(stderr, "%s\n", e.what());
	return -1;
}

int mclBn_getOpUnitSize()
{
	return (int)Fp::getUnitSize() * sizeof(mcl::fp::Unit) / sizeof(uint64_t);
}

int mclBn_getG1ByteSize()
{
	return (int)Fp::getByteSize();
}

mclSize copyStrAndReturnSize(char *buf, mclSize maxBufSize, const std::string& str)
{
	if (str.size() >= maxBufSize) return 0;
	memcpy(buf, str.c_str(), str.size());
	buf[str.size()] = '\0';
	return str.size();
}

mclSize mclBn_getCurveOrder(char *buf, mclSize maxBufSize)
{
	std::string str;
	Fr::getModulo(str);
	return copyStrAndReturnSize(buf, maxBufSize, str);
}

mclSize mclBn_getFieldOrder(char *buf, mclSize maxBufSize)
{
	std::string str;
	Fp::getModulo(str);
	return copyStrAndReturnSize(buf, maxBufSize, str);
}
////////////////////////////////////////////////
// set zero
void mclBnFr_clear(mclBnFr *x)
{
	cast(x)->clear();
}

// set x to y
void mclBnFr_setInt(mclBnFr *y, mclInt x)
{
	*cast(y) = x;
}
void mclBnFr_setInt32(mclBnFr *y, int x)
{
	*cast(y) = x;
}

int mclBnFr_setStr(mclBnFr *x, const char *buf, mclSize bufSize, int ioMode)
{
	return setStr(x, buf, bufSize, ioMode, "mclBnFr_setStr");
}
int mclBnFr_setLittleEndian(mclBnFr *x, const void *buf, mclSize bufSize)
	try
{
	cast(x)->setArrayMask((const char *)buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "setArrayMask %s\n", e.what());
	return -1;
}
mclSize mclBnFr_deserialize(mclBnFr *x, const void *buf, mclSize bufSize)
{
	return deserialize(x, buf, bufSize, "mclBnFr_deserialize");
}
// return 1 if true
int mclBnFr_isValid(const mclBnFr *x)
{
	return cast(x)->isValid();
}
int mclBnFr_isEqual(const mclBnFr *x, const mclBnFr *y)
{
	return *cast(x) == *cast(y);
}
int mclBnFr_isZero(const mclBnFr *x)
{
	return cast(x)->isZero();
}
int mclBnFr_isOne(const mclBnFr *x)
{
	return cast(x)->isOne();
}

int mclBnFr_setByCSPRNG(mclBnFr *x)
	try
{
	cast(x)->setRand(g_rg);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnFr_setByCSPRNG %s\n", e.what());
	return -1;
}

// hash(buf) and set x
int mclBnFr_setHashOf(mclBnFr *x, const void *buf, mclSize bufSize)
	try
{
	cast(x)->setHashOf(buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnFr_setHashOf %s\n", e.what());
	return -1;
}

mclSize mclBnFr_getStr(char *buf, mclSize maxBufSize, const mclBnFr *x, int ioMode)
{
	return getStr(buf, maxBufSize, x, ioMode, "mclBnFr_getStr");
}
mclSize mclBnFr_serialize(void *buf, mclSize maxBufSize, const mclBnFr *x)
{
	return serialize(buf, maxBufSize, x, "mclBnFr_serialize");
}

void mclBnFr_neg(mclBnFr *y, const mclBnFr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void mclBnFr_inv(mclBnFr *y, const mclBnFr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void mclBnFr_sqr(mclBnFr *y, const mclBnFr *x)
{
	Fr::sqr(*cast(y), *cast(x));
}
void mclBnFr_add(mclBnFr *z, const mclBnFr *x, const mclBnFr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void mclBnFr_sub(mclBnFr *z, const mclBnFr *x, const mclBnFr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void mclBnFr_mul(mclBnFr *z, const mclBnFr *x, const mclBnFr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void mclBnFr_div(mclBnFr *z, const mclBnFr *x, const mclBnFr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mclBnG1_clear(mclBnG1 *x)
{
	cast(x)->clear();
}

int mclBnG1_setStr(mclBnG1 *x, const char *buf, mclSize bufSize, int ioMode)
{
	return setStr(x, buf, bufSize, ioMode, "mclBnG1_setStr");
}
mclSize mclBnG1_deserialize(mclBnG1 *x, const void *buf, mclSize bufSize)
{
	return deserialize(x, buf, bufSize, "mclBnG1_deserialize");
}

// return 1 if true
int mclBnG1_isValid(const mclBnG1 *x)
{
	return cast(x)->isValid();
}
int mclBnG1_isEqual(const mclBnG1 *x, const mclBnG1 *y)
{
	return *cast(x) == *cast(y);
}
int mclBnG1_isZero(const mclBnG1 *x)
{
	return cast(x)->isZero();
}

int mclBnG1_hashAndMapTo(mclBnG1 *x, const void *buf, mclSize bufSize)
	try
{
	BN::hashAndMapToG1(*cast(x), buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnG1_hashAndMapTo %s\n", e.what());
	return 1;
}

mclSize mclBnG1_getStr(char *buf, mclSize maxBufSize, const mclBnG1 *x, int ioMode)
{
	return getStr(buf, maxBufSize, x, ioMode, "mclBnG1_getStr");
}

mclSize mclBnG1_serialize(void *buf, mclSize maxBufSize, const mclBnG1 *x)
{
	return serialize(buf, maxBufSize, x, "mclBnG1_serialize");
}

void mclBnG1_neg(mclBnG1 *y, const mclBnG1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void mclBnG1_dbl(mclBnG1 *y, const mclBnG1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void mclBnG1_normalize(mclBnG1 *y, const mclBnG1 *x)
{
	G1::normalize(*cast(y), *cast(x));
}
void mclBnG1_add(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void mclBnG1_sub(mclBnG1 *z, const mclBnG1 *x, const mclBnG1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void mclBnG1_mul(mclBnG1 *z, const mclBnG1 *x, const mclBnFr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}
void mclBnG1_mulCT(mclBnG1 *z, const mclBnG1 *x, const mclBnFr *y)
{
	G1::mulCT(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mclBnG2_clear(mclBnG2 *x)
{
	cast(x)->clear();
}

int mclBnG2_setStr(mclBnG2 *x, const char *buf, mclSize bufSize, int ioMode)
{
	return setStr(x, buf, bufSize, ioMode, "mclBnG2_setStr");
}
mclSize mclBnG2_deserialize(mclBnG2 *x, const void *buf, mclSize bufSize)
{
	return deserialize(x, buf, bufSize, "mclBnG2_deserialize");
}

// return 1 if true
int mclBnG2_isValid(const mclBnG2 *x)
{
	return cast(x)->isValid();
}
int mclBnG2_isEqual(const mclBnG2 *x, const mclBnG2 *y)
{
	return *cast(x) == *cast(y);
}
int mclBnG2_isZero(const mclBnG2 *x)
{
	return cast(x)->isZero();
}

int mclBnG2_hashAndMapTo(mclBnG2 *x, const void *buf, mclSize bufSize)
	try
{
	BN::hashAndMapToG2(*cast(x), buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnG2_hashAndMapTo %s\n", e.what());
	return 1;
}

mclSize mclBnG2_getStr(char *buf, mclSize maxBufSize, const mclBnG2 *x, int ioMode)
{
	return getStr(buf, maxBufSize, x, ioMode, "mclBnG2_getStr");
}
mclSize mclBnG2_serialize(void *buf, mclSize maxBufSize, const mclBnG2 *x)
{
	return serialize(buf, maxBufSize, x, "mclBnG2_serialize");
}

void mclBnG2_neg(mclBnG2 *y, const mclBnG2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void mclBnG2_dbl(mclBnG2 *y, const mclBnG2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void mclBnG2_normalize(mclBnG2 *y, const mclBnG2 *x)
{
	G2::normalize(*cast(y), *cast(x));
}
void mclBnG2_add(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void mclBnG2_sub(mclBnG2 *z, const mclBnG2 *x, const mclBnG2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void mclBnG2_mul(mclBnG2 *z, const mclBnG2 *x, const mclBnFr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}
void mclBnG2_mulCT(mclBnG2 *z, const mclBnG2 *x, const mclBnFr *y)
{
	G2::mulCT(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mclBnGT_clear(mclBnGT *x)
{
	cast(x)->clear();
}
void mclBnGT_setInt(mclBnGT *y, mclInt x)
{
	cast(y)->clear();
	*(cast(y)->getFp0()) = x;
}
void mclBnGT_setInt32(mclBnGT *y, int x)
{
	cast(y)->clear();
	*(cast(y)->getFp0()) = x;
}

int mclBnGT_setStr(mclBnGT *x, const char *buf, mclSize bufSize, int ioMode)
{
	return setStr(x, buf, bufSize, ioMode, "mclBnGT_setStr");
}
mclSize mclBnGT_deserialize(mclBnGT *x, const void *buf, mclSize bufSize)
{
	return deserialize(x, buf, bufSize, "mclBnGT_deserialize");
}

// return 1 if true
int mclBnGT_isEqual(const mclBnGT *x, const mclBnGT *y)
{
	return *cast(x) == *cast(y);
}
int mclBnGT_isZero(const mclBnGT *x)
{
	return cast(x)->isZero();
}
int mclBnGT_isOne(const mclBnGT *x)
{
	return cast(x)->isOne();
}

mclSize mclBnGT_getStr(char *buf, mclSize maxBufSize, const mclBnGT *x, int ioMode)
{
	return getStr(buf, maxBufSize, x, ioMode, "mclBnGT_getStr");
}

mclSize mclBnGT_serialize(void *buf, mclSize maxBufSize, const mclBnGT *x)
{
	return serialize(buf, maxBufSize, x, "mclBnGT_serialize");
}

void mclBnGT_neg(mclBnGT *y, const mclBnGT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void mclBnGT_inv(mclBnGT *y, const mclBnGT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void mclBnGT_sqr(mclBnGT *y, const mclBnGT *x)
{
	Fp12::sqr(*cast(y), *cast(x));
}
void mclBnGT_add(mclBnGT *z, const mclBnGT *x, const mclBnGT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void mclBnGT_sub(mclBnGT *z, const mclBnGT *x, const mclBnGT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void mclBnGT_mul(mclBnGT *z, const mclBnGT *x, const mclBnGT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void mclBnGT_div(mclBnGT *z, const mclBnGT *x, const mclBnGT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void mclBnGT_pow(mclBnGT *z, const mclBnGT *x, const mclBnFr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}
void mclBnGT_powGeneric(mclBnGT *z, const mclBnGT *x, const mclBnFr *y)
{
	Fp12::powGeneric(*cast(z), *cast(x), *cast(y));
}

void mclBn_pairing(mclBnGT *z, const mclBnG1 *x, const mclBnG2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void mclBn_finalExp(mclBnGT *y, const mclBnGT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void mclBn_millerLoop(mclBnGT *z, const mclBnG1 *x, const mclBnG2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
int mclBn_getUint64NumToPrecompute(void)
{
	return int(BN::param.precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t));
}

void mclBn_precomputeG2(uint64_t *Qbuf, const mclBnG2 *Q)
{
	BN::precomputeG2(cast(Qbuf), *cast(Q));
}

void mclBn_precomputedMillerLoop(mclBnGT *f, const mclBnG1 *P, const uint64_t *Qbuf)
{
	BN::precomputedMillerLoop(*cast(f), *cast(P), cast(Qbuf));
}

void mclBn_precomputedMillerLoop2(mclBnGT *f, const mclBnG1 *P1, const uint64_t  *Q1buf, const mclBnG1 *P2, const uint64_t *Q2buf)
{
	BN::precomputedMillerLoop2(*cast(f), *cast(P1), cast(Q1buf), *cast(P2), cast(Q2buf));
}

int mclBn_FrLagrangeInterpolation(mclBnFr *out, const mclBnFr *xVec, const mclBnFr *yVec, mclSize k)
	try
{
	mcl::LagrangeInterpolation(*cast(out), cast(xVec), cast(yVec), k);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_FrLagrangeInterpolation %s\n", e.what());
	return -1;
}
int mclBn_G1LagrangeInterpolation(mclBnG1 *out, const mclBnFr *xVec, const mclBnG1 *yVec, mclSize k)
	try
{
	mcl::LagrangeInterpolation(*cast(out), cast(xVec), cast(yVec), k);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_G1LagrangeInterpolation %s\n", e.what());
	return -1;
}
int mclBn_G2LagrangeInterpolation(mclBnG2 *out, const mclBnFr *xVec, const mclBnG2 *yVec, mclSize k)
	try
{
	mcl::LagrangeInterpolation(*cast(out), cast(xVec), cast(yVec), k);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_G2LagrangeInterpolation %s\n", e.what());
	return -1;
}
int mclBn_FrEvaluatePolynomial(mclBnFr *out, const mclBnFr *cVec, mclSize cSize, const mclBnFr *x)
	try
{
	mcl::evaluatePolynomial(*cast(out), cast(cVec), cSize, *cast(x));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_FrEvaluatePolynomial %s\n", e.what());
	return -1;
}
int mclBn_G1EvaluatePolynomial(mclBnG1 *out, const mclBnG1 *cVec, mclSize cSize, const mclBnFr *x)
	try
{
	mcl::evaluatePolynomial(*cast(out), cast(cVec), cSize, *cast(x));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_G1EvaluatePolynomial %s\n", e.what());
	return -1;
}
int mclBn_G2EvaluatePolynomial(mclBnG2 *out, const mclBnG2 *cVec, mclSize cSize, const mclBnFr *x)
	try
{
	mcl::evaluatePolynomial(*cast(out), cast(cVec), cSize, *cast(x));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBn_G2EvaluatePolynomial %s\n", e.what());
	return -1;
}

void mclBn_verifyOrderG1(int doVerify)
{
	if (BN::param.isBLS12) {
		G1::setOrder(doVerify ? BN::param.r : 0);
	}
}

void mclBn_verifyOrderG2(int doVerify)
{
	G2::setOrder(doVerify ? BN::param.r : 0);
}

