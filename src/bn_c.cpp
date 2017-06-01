#define MBN_DLL_EXPORT
#define MBN_DEFINE_STRUCT
#include <mcl/bn.h>
#if 0 // #if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
static std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
static cybozu::RandomGenerator g_rg;
#endif

#if MBN_FP_UNIT_SIZE == 4
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#else
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#endif

static FILE *g_fp = NULL;

static Fr *cast(mbnFr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const mbnFr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(mbnG1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const mbnG1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(mbnG2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const mbnG2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(mbnGT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const mbnGT *p) { return reinterpret_cast<const Fp12*>(p); }

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

int mbn_setErrFile(const char *name)
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

int mbn_init(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != MBN_FP_UNIT_SIZE) {
		if (g_fp) fprintf(g_fp, "mbn_init:maxUnitSize is mismatch %d %d\n", maxUnitSize, MBN_FP_UNIT_SIZE);
		return -1;
	}
	mcl::bn::CurveParam cp;
	switch (curve) {
	case mbn_curveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
#if MBN_FP_UNIT_SIZE == 6
	case mbn_curveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case mbn_curveFp382_2:
		cp = mcl::bn::CurveFp382_2;
		break;
#endif
	default:
		if (g_fp) fprintf(g_fp, "MBN_init:not supported curve %d\n", curve);
		return -1;
	}
#if MBN_FP_UNIT_SIZE == 4
	bn256init(cp);
#else
	bn384init(cp);
#endif
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return -1;
}

////////////////////////////////////////////////
// set zero
void mbnFr_clear(mbnFr *x)
{
	cast(x)->clear();
}

// set x to y
void mbnFr_setInt(mbnFr *y, int x)
{
	*cast(y) = x;
}

int mbnFr_setStr(mbnFr *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mbnFr_setStr", false);
}
int mbnFr_setLittleEndian(mbnFr *x, const void *buf, size_t bufSize)
{
	const size_t byteSize = cast(x)->getByteSize();
	if (bufSize > byteSize) bufSize = byteSize;
	std::string s((const char *)buf, bufSize);
	s.resize(byteSize);
	return deserialize(x, s.c_str(), s.size(), mcl::IoFixedSizeByteSeq, "mbnFr_setLittleEndian", false);
}
int mbnFr_deserialize(mbnFr *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mbnFr_deserialize", false);
}
// return 1 if true
int mbnFr_isValid(const mbnFr *x)
{
	return cast(x)->isValid();
}
int mbnFr_isEqual(const mbnFr *x, const mbnFr *y)
{
	return *cast(x) == *cast(y);
}
int mbnFr_isZero(const mbnFr *x)
{
	return cast(x)->isZero();
}
int mbnFr_isOne(const mbnFr *x)
{
	return cast(x)->isOne();
}

void mbnFr_setByCSPRNG(mbnFr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(buf) and set x
int mbnFr_setHashOf(mbnFr *x, const void *buf, size_t bufSize)
	try
{
	cast(x)->setHashOf(buf, bufSize);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mbnFr_setHashOf %s\n", e.what());
	return -1;
}

size_t mbnFr_getStr(char *buf, size_t maxBufSize, const mbnFr *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mbnFr_getStr", false);
}
size_t mbnFr_serialize(void *buf, size_t maxBufSize, const mbnFr *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mbnFr_serialize", false);
}

void mbnFr_neg(mbnFr *y, const mbnFr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void mbnFr_inv(mbnFr *y, const mbnFr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void mbnFr_add(mbnFr *z, const mbnFr *x, const mbnFr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void mbnFr_sub(mbnFr *z, const mbnFr *x, const mbnFr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void mbnFr_mul(mbnFr *z, const mbnFr *x, const mbnFr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void mbnFr_div(mbnFr *z, const mbnFr *x, const mbnFr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mbnG1_clear(mbnG1 *x)
{
	cast(x)->clear();
}

int mbnG1_setStr(mbnG1 *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mbnG1_setStr", false);
}

// return 1 if true
int mbnG1_isValid(const mbnG1 *x)
{
	return cast(x)->isValid();
}
int mbnG1_isEqual(const mbnG1 *x, const mbnG1 *y)
{
	return *cast(x) == *cast(y);
}
int mbnG1_isZero(const mbnG1 *x)
{
	return cast(x)->isZero();
}

int mbnG1_hashAndMapTo(mbnG1 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mbnG1_hashAndMapTo %s\n", e.what());
	return 1;
}

size_t mbnG1_getStr(char *buf, size_t maxBufSize, const mbnG1 *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mbnG1_getStr", false);
}

size_t mbnG1_serialize(void *buf, size_t maxBufSize, const mbnG1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mbnG1_serialize", false);
}

void mbnG1_neg(mbnG1 *y, const mbnG1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void mbnG1_dbl(mbnG1 *y, const mbnG1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void mbnG1_add(mbnG1 *z, const mbnG1 *x, const mbnG1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void mbnG1_sub(mbnG1 *z, const mbnG1 *x, const mbnG1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void mbnG1_mul(mbnG1 *z, const mbnG1 *x, const mbnFr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mbnG2_clear(mbnG2 *x)
{
	cast(x)->clear();
}

int mbnG2_setStr(mbnG2 *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mbnG2_setStr", false);
}

// return 1 if true
int mbnG2_isValid(const mbnG2 *x)
{
	return cast(x)->isValid();
}
int mbnG2_isEqual(const mbnG2 *x, const mbnG2 *y)
{
	return *cast(x) == *cast(y);
}
int mbnG2_isZero(const mbnG2 *x)
{
	return cast(x)->isZero();
}

int mbnG2_hashAndMapTo(mbnG2 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "mbnG2_hashAndMapTo %s\n", e.what());
	return 1;
}

size_t mbnG2_getStr(char *buf, size_t maxBufSize, const mbnG2 *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mbnG2_getStr", false);
}

void mbnG2_neg(mbnG2 *y, const mbnG2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void mbnG2_dbl(mbnG2 *y, const mbnG2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void mbnG2_add(mbnG2 *z, const mbnG2 *x, const mbnG2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void mbnG2_sub(mbnG2 *z, const mbnG2 *x, const mbnG2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void mbnG2_mul(mbnG2 *z, const mbnG2 *x, const mbnFr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void mbnGT_clear(mbnGT *x)
{
	cast(x)->clear();
}

int mbnGT_setStr(mbnGT *x, const char *buf, size_t bufSize, int ioMode)
{
	return deserialize(x, buf, bufSize, ioMode, "mbnGT_setStr", false);
}
int mbnGT_deserialize(mbnGT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "mbnGT_deserialize", false);
}

// return 1 if true
int mbnGT_isEqual(const mbnGT *x, const mbnGT *y)
{
	return *cast(x) == *cast(y);
}
int mbnGT_isZero(const mbnGT *x)
{
	return cast(x)->isZero();
}
int mbnGT_isOne(const mbnGT *x)
{
	return cast(x)->isOne();
}

size_t mbnGT_getStr(char *buf, size_t maxBufSize, const mbnGT *x, int ioMode)
{
	return serialize(buf, maxBufSize, x, ioMode, "mbnGT_getStr", false);
}

size_t mbnGT_serialize(void *buf, size_t maxBufSize, const mbnGT *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "mbnGT_serialize", false);
}

void mbnGT_neg(mbnGT *y, const mbnGT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void mbnGT_inv(mbnGT *y, const mbnGT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void mbnGT_add(mbnGT *z, const mbnGT *x, const mbnGT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void mbnGT_sub(mbnGT *z, const mbnGT *x, const mbnGT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void mbnGT_mul(mbnGT *z, const mbnGT *x, const mbnGT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void mbnGT_div(mbnGT *z, const mbnGT *x, const mbnGT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void mbnGT_pow(mbnGT *z, const mbnGT *x, const mbnFr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void mbn_pairing(mbnGT *z, const mbnG1 *x, const mbnG2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void mbn_finalExp(mbnGT *y, const mbnGT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void mbn_millerLoop(mbnGT *z, const mbnG1 *x, const mbnG2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
int mbn_getUint64NumToPrecompute(void)
{
	return int(BN::param.precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t));
}

void mbn_precomputeG2(uint64_t *Qbuf, const mbnG2 *Q)
{
	BN::precomputeG2(cast(Qbuf), *cast(Q));
}

void mbn_precomputedMillerLoop(mbnGT *f, const mbnG1 *P, const uint64_t *Qbuf)
{
	BN::precomputedMillerLoop(*cast(f), *cast(P), cast(Qbuf));
}

void mbn_precomputedMillerLoop2(mbnGT *f, const mbnG1 *P1, const uint64_t  *Q1buf, const mbnG1 *P2, const uint64_t *Q2buf)
{
	BN::precomputedMillerLoop2(*cast(f), *cast(P1), cast(Q1buf), *cast(P2), cast(Q2buf));
}
