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
#else
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#endif

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
size_t serialize(void *buf, size_t maxBufSize, const T *x, int ioMode, const char *msg, bool convertToHex)
	try
{
	std::string str;
	cast(x)->getStr(str, ioMode);
	if (convertToHex) {
		str = mcl::fp::littleEndianToHexStr(str.c_str(), str.size());
	}
	size_t terminate = (convertToHex || ioMode == 10 || ioMode == 16) ? 1 : 0;
	if (str.size() + terminate > maxBufSize) {
		if (g_fp) fprintf(g_fp, "%s:serialize:small maxBufSize %d %d %d\n", msg, (int)maxBufSize, (int)str.size(), (int)terminate);
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
int deserialize(T *x, const void *buf, size_t bufSize, int ioMode, const char *msg, bool convertFromHex)
	try
{
	std::string str;
	if (convertFromHex) {
		str = mcl::fp::hexStrToLittleEndian((const char *)buf, bufSize);
	} else {
		str.assign((const char *)buf, bufSize);
	}
	cast(x)->setStr(str, ioMode);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s %s\n", msg, e.what());
	return -1;
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
		if (g_fp) fprintf(g_fp, "mclBn_init:maxUnitSize is mismatch %d %d\n", maxUnitSize, MCLBN_FP_UNIT_SIZE);
		return -1;
	}
	mcl::bn::CurveParam cp;
	switch (curve) {
	case mclBn_CurveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
#if MCLBN_FP_UNIT_SIZE == 6
	case mclBn_CurveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case mclBn_CurveFp382_2:
		cp = mcl::bn::CurveFp382_2;
		break;
#endif
	default:
		if (g_fp) fprintf(g_fp, "MCLBN_init:not supported curve %d\n", curve);
		return -1;
	}
#if MCLBN_FP_UNIT_SIZE == 4
	bn256init(cp);
#else
	bn384init(cp);
#endif
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return -1;
}

int mclBn_getOpUnitSize()
{
	return Fp::getUnitSize() * sizeof(mcl::fp::Unit) / sizeof(uint64_t);
}

size_t copyStrAndReturnSize(char *buf, size_t maxBufSize, const std::string& str)
{
	if (str.size() >= maxBufSize) return 0;
	strcpy(buf, str.c_str());
	return str.size();
}

size_t mclBn_getCurveOrder(char *buf, size_t maxBufSize)
{
	std::string str;
	Fr::getModulo(str);
	return copyStrAndReturnSize(buf, maxBufSize, str);
}

size_t mclBn_getFieldOrder(char *buf, size_t maxBufSize)
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
void mclBnFr_setInt(mclBnFr *y, int64_t x)
{
	*cast(y) = x;
}

int mclBnFr_setStr(mclBnFr *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mclBnFr_setStr", false);
}
int mclBnFr_setLittleEndian(mclBnFr *x, const void *buf, size_t bufSize)
{
	const size_t byteSize = cast(x)->getByteSize();
	if (bufSize > byteSize) bufSize = byteSize;
	std::string s((const char *)buf, bufSize);
	s.resize(byteSize);
	return deserialize(x, s.c_str(), s.size(), mcl::IoFixedSizeByteSeq, "mclBnFr_setLittleEndian", false);
}
int mclBnFr_deserialize(mclBnFr *x, const void *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mclBnFr_deserialize", false);
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
int mclBnFr_setHashOf(mclBnFr *x, const void *buf, size_t bufSize)
	try
{
	cast(x)->setHashOf(buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnFr_setHashOf %s\n", e.what());
	return -1;
}

size_t mclBnFr_getStr(char *buf, size_t maxBufSize, const mclBnFr *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mclBnFr_getStr", false);
}
size_t mclBnFr_serialize(void *buf, size_t maxBufSize, const mclBnFr *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mclBnFr_serialize", false);
}

void mclBnFr_neg(mclBnFr *y, const mclBnFr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void mclBnFr_inv(mclBnFr *y, const mclBnFr *x)
{
	Fr::inv(*cast(y), *cast(x));
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

int mclBnG1_setStr(mclBnG1 *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mclBnG1_setStr", false);
}
int mclBnG1_deserialize(mclBnG1 *x, const void *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mclBnG1_deserialize", false);
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

int mclBnG1_hashAndMapTo(mclBnG1 *x, const void *buf, size_t bufSize)
	try
{
	BN::hashAndMapToG1(*cast(x), buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnG1_hashAndMapTo %s\n", e.what());
	return 1;
}

size_t mclBnG1_getStr(char *buf, size_t maxBufSize, const mclBnG1 *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mclBnG1_getStr", false);
}

size_t mclBnG1_serialize(void *buf, size_t maxBufSize, const mclBnG1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mclBnG1_serialize", false);
}

void mclBnG1_neg(mclBnG1 *y, const mclBnG1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void mclBnG1_dbl(mclBnG1 *y, const mclBnG1 *x)
{
	G1::dbl(*cast(y), *cast(x));
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

////////////////////////////////////////////////
// set zero
void mclBnG2_clear(mclBnG2 *x)
{
	cast(x)->clear();
}

int mclBnG2_setStr(mclBnG2 *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mclBnG2_setStr", false);
}
int mclBnG2_deserialize(mclBnG2 *x, const void *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mclBnG2_deserialize", false);
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

int mclBnG2_hashAndMapTo(mclBnG2 *x, const void *buf, size_t bufSize)
	try
{
	BN::hashAndMapToG2(*cast(x), buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mclBnG2_hashAndMapTo %s\n", e.what());
	return 1;
}

size_t mclBnG2_getStr(char *buf, size_t maxBufSize, const mclBnG2 *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mclBnG2_getStr", false);
}
size_t mclBnG2_serialize(void *buf, size_t maxBufSize, const mclBnG2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mclBnG2_serialize", false);
}

void mclBnG2_neg(mclBnG2 *y, const mclBnG2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void mclBnG2_dbl(mclBnG2 *y, const mclBnG2 *x)
{
	G2::dbl(*cast(y), *cast(x));
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

////////////////////////////////////////////////
// set zero
void mclBnGT_clear(mclBnGT *x)
{
	cast(x)->clear();
}

int mclBnGT_setStr(mclBnGT *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mclBnGT_setStr", false);
}
int mclBnGT_deserialize(mclBnGT *x, const void *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mclBnGT_deserialize", false);
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

size_t mclBnGT_getStr(char *buf, size_t maxBufSize, const mclBnGT *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mclBnGT_getStr", false);
}

size_t mclBnGT_serialize(void *buf, size_t maxBufSize, const mclBnGT *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mclBnGT_serialize", false);
}

void mclBnGT_neg(mclBnGT *y, const mclBnGT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void mclBnGT_inv(mclBnGT *y, const mclBnGT *x)
{
	Fp12::inv(*cast(y), *cast(x));
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
