#define MCLBN_DLL_EXPORT
#define MCLBN_DEFINE_STRUCT
#include <mcl/bn.h>
#if 0 // #if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
static std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
static cybozu::RandomGenerator g_rg;
#endif

#if MCLBN_MAX_OP_UNIT_SIZE == 4
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#else
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#endif

static FILE *g_fp = NULL;

static Fr *cast(MCLBN_Fr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const MCLBN_Fr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(MCLBN_G1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const MCLBN_G1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(MCLBN_G2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const MCLBN_G2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(MCLBN_GT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const MCLBN_GT *p) { return reinterpret_cast<const Fp12*>(p); }

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

int MCLBN_setErrFile(const char *name)
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

int MCLBN_initLib(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != MCLBN_MAX_OP_UNIT_SIZE) {
		if (g_fp) fprintf(g_fp, "MCLBN_initLib:maxUnitSize is mismatch %d %d\n", maxUnitSize, MCLBN_MAX_OP_UNIT_SIZE);
		return -1;
	}
	mcl::bn::CurveParam cp;
	switch (curve) {
	case MCLBN_curveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
#if MCLBN_MAX_OP_UNIT_SIZE == 6
	case MCLBN_curveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case MCLBN_curveFp382_2:
		cp = mcl::bn::CurveFp382_2;
		break;
#endif
	default:
		if (g_fp) fprintf(g_fp, "MCLBN_initLib:not supported curve %d\n", curve);
		return -1;
	}
#if MCLBN_MAX_OP_UNIT_SIZE == 4
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
void MCLBN_Fr_clear(MCLBN_Fr *x)
{
	cast(x)->clear();
}

// set x to y
void MCLBN_Fr_setInt(MCLBN_Fr *y, int x)
{
	*cast(y) = x;
}

int MCLBN_Fr_setDecStr(MCLBN_Fr *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 10, "MCLBN_Fr_setDecStr", false);
}
int MCLBN_Fr_setHexStr(MCLBN_Fr *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 16, "MCLBN_Fr_setHexStr", false);
}
int MCLBN_Fr_setLittleEndian(MCLBN_Fr *x, const void *buf, size_t bufSize)
{
	const size_t byteSize = cast(x)->getByteSize();
	if (bufSize > byteSize) bufSize = byteSize;
	std::string s((const char *)buf, bufSize);
	s.resize(byteSize);
	return deserialize(x, s.c_str(), s.size(), mcl::IoFixedSizeByteSeq, "MCLBN_Fr_setLittleEndian", false);
}

// return 1 if true
int MCLBN_Fr_isValid(const MCLBN_Fr *x)
{
	return cast(x)->isValid();
}
int MCLBN_Fr_isEqual(const MCLBN_Fr *x, const MCLBN_Fr *y)
{
	return *cast(x) == *cast(y);
}
int MCLBN_Fr_isZero(const MCLBN_Fr *x)
{
	return cast(x)->isZero();
}
int MCLBN_Fr_isOne(const MCLBN_Fr *x)
{
	return cast(x)->isOne();
}

void MCLBN_Fr_setByCSPRNG(MCLBN_Fr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(buf) and set x
void MCLBN_hashToFr(MCLBN_Fr *x, const void *buf, size_t bufSize)
{
	cast(x)->setHashOf(buf, bufSize);
}

size_t MCLBN_Fr_getDecStr(char *buf, size_t maxBufSize, const MCLBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 10, "MCLBN_Fr_getDecStr", false);
}
size_t MCLBN_Fr_getHexStr(char *buf, size_t maxBufSize, const MCLBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 16, "MCLBN_Fr_getHexStr", false);
}
size_t MCLBN_Fr_getLittleEndian(void *buf, size_t maxBufSize, const MCLBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_Fr_getLittleEndian", false);
}

void MCLBN_Fr_neg(MCLBN_Fr *y, const MCLBN_Fr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void MCLBN_Fr_inv(MCLBN_Fr *y, const MCLBN_Fr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void MCLBN_Fr_add(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void MCLBN_Fr_sub(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void MCLBN_Fr_mul(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void MCLBN_Fr_div(MCLBN_Fr *z, const MCLBN_Fr *x, const MCLBN_Fr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MCLBN_G1_clear(MCLBN_G1 *x)
{
	cast(x)->clear();
}

int MCLBN_G1_setHexStr(MCLBN_G1 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MCLBN_G1_setHexStr", true);
}
int MCLBN_G1_deserialize(MCLBN_G1 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MCLBN_G1_setHexStr", false);
}

// return 1 if true
int MCLBN_G1_isValid(const MCLBN_G1 *x)
{
	return cast(x)->isValid();
}
int MCLBN_G1_isEqual(const MCLBN_G1 *x, const MCLBN_G1 *y)
{
	return *cast(x) == *cast(y);
}
int MCLBN_G1_isZero(const MCLBN_G1 *x)
{
	return cast(x)->isZero();
}

int MCLBN_hashAndMapToG1(MCLBN_G1 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "MCLBN_hashAndMapToG1 %s\n", e.what());
	return 1;
}

size_t MCLBN_G1_getHexStr(char *buf, size_t maxBufSize, const MCLBN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_G1_getHexStr", true);
}

size_t MCLBN_G1_serialize(void *buf, size_t maxBufSize, const MCLBN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_G1_serialize", false);
}

void MCLBN_G1_neg(MCLBN_G1 *y, const MCLBN_G1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void MCLBN_G1_dbl(MCLBN_G1 *y, const MCLBN_G1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void MCLBN_G1_add(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_G1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void MCLBN_G1_sub(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_G1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void MCLBN_G1_mul(MCLBN_G1 *z, const MCLBN_G1 *x, const MCLBN_Fr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MCLBN_G2_clear(MCLBN_G2 *x)
{
	cast(x)->clear();
}

int MCLBN_G2_setHexStr(MCLBN_G2 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MCLBN_G2_setHexStr", true);
}
int MCLBN_G2_deserialize(MCLBN_G2 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MCLBN_G2_setHexStr", false);
}

// return 1 if true
int MCLBN_G2_isValid(const MCLBN_G2 *x)
{
	return cast(x)->isValid();
}
int MCLBN_G2_isEqual(const MCLBN_G2 *x, const MCLBN_G2 *y)
{
	return *cast(x) == *cast(y);
}
int MCLBN_G2_isZero(const MCLBN_G2 *x)
{
	return cast(x)->isZero();
}

int MCLBN_hashAndMapToG2(MCLBN_G2 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "MCLBN_hashAndMapToG2 %s\n", e.what());
	return 1;
}

size_t MCLBN_G2_getHexStr(char *buf, size_t maxBufSize, const MCLBN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_G2_getHexStr", true);
}

size_t MCLBN_G2_serialize(void *buf, size_t maxBufSize, const MCLBN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_G2_serialize", false);
}

void MCLBN_G2_neg(MCLBN_G2 *y, const MCLBN_G2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void MCLBN_G2_dbl(MCLBN_G2 *y, const MCLBN_G2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void MCLBN_G2_add(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_G2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void MCLBN_G2_sub(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_G2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void MCLBN_G2_mul(MCLBN_G2 *z, const MCLBN_G2 *x, const MCLBN_Fr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MCLBN_GT_clear(MCLBN_GT *x)
{
	cast(x)->clear();
}

int MCLBN_GT_setDecStr(MCLBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 10, "MCLBN_GT_setDecStr", false);
}
int MCLBN_GT_setHexStr(MCLBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 16, "MCLBN_GT_setHexStr", false);
}
int MCLBN_GT_deserialize(MCLBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MCLBN_GT_setHexStr", false);
}

// return 1 if true
int MCLBN_GT_isEqual(const MCLBN_GT *x, const MCLBN_GT *y)
{
	return *cast(x) == *cast(y);
}
int MCLBN_GT_isZero(const MCLBN_GT *x)
{
	return cast(x)->isZero();
}
int MCLBN_GT_isOne(const MCLBN_GT *x)
{
	return cast(x)->isOne();
}

size_t MCLBN_GT_getDecStr(char *buf, size_t maxBufSize, const MCLBN_GT *x)
{
	return serialize(buf, maxBufSize, x, 10, "MCLBN_GT_getDecStr", false);
}

size_t MCLBN_GT_getHexStr(char *buf, size_t maxBufSize, const MCLBN_GT *x)
{
	return serialize(buf, maxBufSize, x, 16, "MCLBN_GT_getHexStr", false);
}

size_t MCLBN_GT_serialize(void *buf, size_t maxBufSize, const MCLBN_GT *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MCLBN_GT_serialize", false);
}

void MCLBN_GT_neg(MCLBN_GT *y, const MCLBN_GT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void MCLBN_GT_inv(MCLBN_GT *y, const MCLBN_GT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void MCLBN_GT_add(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void MCLBN_GT_sub(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void MCLBN_GT_mul(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void MCLBN_GT_div(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_GT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void MCLBN_GT_pow(MCLBN_GT *z, const MCLBN_GT *x, const MCLBN_Fr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void MCLBN_pairing(MCLBN_GT *z, const MCLBN_G1 *x, const MCLBN_G2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void MCLBN_finalExp(MCLBN_GT *y, const MCLBN_GT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void MCLBN_millerLoop(MCLBN_GT *z, const MCLBN_G1 *x, const MCLBN_G2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
int MCLBN_getUint64NumToPrecompute(void)
{
	return int(BN::param.precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t));
}

void MCLBN_precomputeG2(uint64_t *Qbuf, const MCLBN_G2 *Q)
{
	BN::precomputeG2(cast(Qbuf), *cast(Q));
}

void MCLBN_precomputedMillerLoop(MCLBN_GT *f, const MCLBN_G1 *P, const uint64_t *Qbuf)
{
	BN::precomputedMillerLoop(*cast(f), *cast(P), cast(Qbuf));
}

void MCLBN_precomputedMillerLoop2(MCLBN_GT *f, const MCLBN_G1 *P1, const uint64_t  *Q1buf, const MCLBN_G1 *P2, const uint64_t *Q2buf)
{
	BN::precomputedMillerLoop2(*cast(f), *cast(P1), cast(Q1buf), *cast(P2), cast(Q2buf));
}
