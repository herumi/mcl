#define BN_DLL_EXPORT
#define BN_DEFINE_STRUCT
#include <mcl/bn_if.h>
#if 0 // #if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
static std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
static cybozu::RandomGenerator g_rg;
#endif

#if BN_MAX_OP_UNIT_SIZE == 4
#include <mcl/bn256.hpp>
using namespace mcl::bn256;
#else
#include <mcl/bn384.hpp>
using namespace mcl::bn384;
#endif

static FILE *g_fp = NULL;

static Fr *cast(BN_Fr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const BN_Fr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(BN_G1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const BN_G1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(BN_G2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const BN_G2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(BN_GT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const BN_GT *p) { return reinterpret_cast<const Fp12*>(p); }

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

int BN_setErrFile(const char *name)
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

int BN_initLib(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != BN_MAX_OP_UNIT_SIZE) {
		if (g_fp) fprintf(g_fp, "BN_initLib:maxUnitSize is mismatch %d %d\n", maxUnitSize, BN_MAX_OP_UNIT_SIZE);
		return -1;
	}
	mcl::bn::CurveParam cp;
	switch (curve) {
	case BN_curveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
#if BN_MAX_OP_UNIT_SIZE == 6
	case BN_curveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case BN_curveFp382_2:
		cp = mcl::bn::CurveFp382_2;
		break;
#endif
	default:
		if (g_fp) fprintf(g_fp, "BN_initLib:not supported curve %d\n", curve);
		return -1;
	}
#if BN_MAX_OP_UNIT_SIZE == 4
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
void BN_Fr_clear(BN_Fr *x)
{
	cast(x)->clear();
}

// set x to y
void BN_Fr_setInt(BN_Fr *y, int x)
{
	*cast(y) = x;
}

int BN_Fr_setDecStr(BN_Fr *x, const char *s)
{
	return deserialize(x, s, strlen(s), 10, "BN_Fr_setDecStr", false);
}
int BN_Fr_setHexStr(BN_Fr *x, const char *s)
{
	return deserialize(x, s, strlen(s), 16, "BN_Fr_setHexStr", false);
}
int BN_Fr_setLittleEndian(BN_Fr *x, const void *buf, size_t bufSize)
{
	const size_t byteSize = cast(x)->getByteSize();
	if (bufSize > byteSize) bufSize = byteSize;
	std::string s((const char *)buf, bufSize);
	s.resize(byteSize);
	return deserialize(x, s.c_str(), s.size(), mcl::IoFixedSizeByteSeq, "BN_Fr_setLittleEndian", false);
}

// return 1 if true
int BN_Fr_isValid(const BN_Fr *x)
{
	return cast(x)->isValid();
}
int BN_Fr_isEqual(const BN_Fr *x, const BN_Fr *y)
{
	return *cast(x) == *cast(y);
}
int BN_Fr_isZero(const BN_Fr *x)
{
	return cast(x)->isZero();
}
int BN_Fr_isOne(const BN_Fr *x)
{
	return cast(x)->isOne();
}

void BN_Fr_setByCSPRNG(BN_Fr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(buf) and set x
void BN_hashToFr(BN_Fr *x, const void *buf, size_t bufSize)
{
	cast(x)->setHashOf(buf, bufSize);
}

size_t BN_Fr_getDecStr(char *buf, size_t maxBufSize, const BN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 10, "BN_Fr_getDecStr", false);
}
size_t BN_Fr_getHexStr(char *buf, size_t maxBufSize, const BN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 16, "BN_Fr_getHexStr", false);
}
size_t BN_Fr_getLittleEndian(void *buf, size_t maxBufSize, const BN_Fr *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_Fr_getLittleEndian", false);
}

void BN_Fr_neg(BN_Fr *y, const BN_Fr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void BN_Fr_inv(BN_Fr *y, const BN_Fr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void BN_Fr_add(BN_Fr *z, const BN_Fr *x, const BN_Fr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void BN_Fr_sub(BN_Fr *z, const BN_Fr *x, const BN_Fr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void BN_Fr_mul(BN_Fr *z, const BN_Fr *x, const BN_Fr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void BN_Fr_div(BN_Fr *z, const BN_Fr *x, const BN_Fr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN_G1_clear(BN_G1 *x)
{
	cast(x)->clear();
}

int BN_G1_setHexStr(BN_G1 *x, const char *s)
{
	return deserialize(x, s, strlen(s), mcl::IoFixedSizeByteSeq, "BN_G1_setHexStr", true);
}
int BN_G1_deserialize(BN_G1 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "BN_G1_setHexStr", false);
}

// return 1 if true
int BN_G1_isValid(const BN_G1 *x)
{
	return cast(x)->isValid();
}
int BN_G1_isEqual(const BN_G1 *x, const BN_G1 *y)
{
	return *cast(x) == *cast(y);
}
int BN_G1_isZero(const BN_G1 *x)
{
	return cast(x)->isZero();
}

int BN_hashAndMapToG1(BN_G1 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "BN_hashAndMapToG1 %s\n", e.what());
	return 1;
}

size_t BN_G1_getHexStr(char *buf, size_t maxBufSize, const BN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_G1_getHexStr", true);
}

size_t BN_G1_serialize(void *buf, size_t maxBufSize, const BN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_G1_serialize", false);
}

void BN_G1_neg(BN_G1 *y, const BN_G1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void BN_G1_dbl(BN_G1 *y, const BN_G1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void BN_G1_add(BN_G1 *z, const BN_G1 *x, const BN_G1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void BN_G1_sub(BN_G1 *z, const BN_G1 *x, const BN_G1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void BN_G1_mul(BN_G1 *z, const BN_G1 *x, const BN_Fr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN_G2_clear(BN_G2 *x)
{
	cast(x)->clear();
}

int BN_G2_setHexStr(BN_G2 *x, const char *s)
{
	return deserialize(x, s, strlen(s), mcl::IoFixedSizeByteSeq, "BN_G2_setHexStr", true);
}
int BN_G2_deserialize(BN_G2 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "BN_G2_setHexStr", false);
}

// return 1 if true
int BN_G2_isValid(const BN_G2 *x)
{
	return cast(x)->isValid();
}
int BN_G2_isEqual(const BN_G2 *x, const BN_G2 *y)
{
	return *cast(x) == *cast(y);
}
int BN_G2_isZero(const BN_G2 *x)
{
	return cast(x)->isZero();
}

int BN_hashAndMapToG2(BN_G2 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "BN_hashAndMapToG2 %s\n", e.what());
	return 1;
}

size_t BN_G2_getHexStr(char *buf, size_t maxBufSize, const BN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_G2_getHexStr", true);
}

size_t BN_G2_serialize(void *buf, size_t maxBufSize, const BN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_G2_serialize", false);
}

void BN_G2_neg(BN_G2 *y, const BN_G2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void BN_G2_dbl(BN_G2 *y, const BN_G2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void BN_G2_add(BN_G2 *z, const BN_G2 *x, const BN_G2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void BN_G2_sub(BN_G2 *z, const BN_G2 *x, const BN_G2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void BN_G2_mul(BN_G2 *z, const BN_G2 *x, const BN_Fr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN_GT_clear(BN_GT *x)
{
	cast(x)->clear();
}

int BN_GT_setDecStr(BN_GT *x, const char *s)
{
	return deserialize(x, s, strlen(s), 10, "BN_GT_setDecStr", false);
}
int BN_GT_setHexStr(BN_GT *x, const char *s)
{
	return deserialize(x, s, strlen(s), 16, "BN_GT_setHexStr", false);
}
int BN_GT_deserialize(BN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "BN_GT_setHexStr", false);
}

// return 1 if true
int BN_GT_isEqual(const BN_GT *x, const BN_GT *y)
{
	return *cast(x) == *cast(y);
}
int BN_GT_isZero(const BN_GT *x)
{
	return cast(x)->isZero();
}
int BN_GT_isOne(const BN_GT *x)
{
	return cast(x)->isOne();
}

size_t BN_GT_getDecStr(char *buf, size_t maxBufSize, const BN_GT *x)
{
	return serialize(buf, maxBufSize, x, 10, "BN_GT_getDecStr", false);
}

size_t BN_GT_getHexStr(char *buf, size_t maxBufSize, const BN_GT *x)
{
	return serialize(buf, maxBufSize, x, 16, "BN_GT_getHexStr", false);
}

size_t BN_GT_serialize(void *buf, size_t maxBufSize, const BN_GT *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "BN_GT_serialize", false);
}

void BN_GT_neg(BN_GT *y, const BN_GT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void BN_GT_inv(BN_GT *y, const BN_GT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void BN_GT_add(BN_GT *z, const BN_GT *x, const BN_GT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void BN_GT_sub(BN_GT *z, const BN_GT *x, const BN_GT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void BN_GT_mul(BN_GT *z, const BN_GT *x, const BN_GT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void BN_GT_div(BN_GT *z, const BN_GT *x, const BN_GT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void BN_GT_pow(BN_GT *z, const BN_GT *x, const BN_Fr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void BN_pairing(BN_GT *z, const BN_G1 *x, const BN_G2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void BN_finalExp(BN_GT *y, const BN_GT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void BN_millerLoop(BN_GT *z, const BN_G1 *x, const BN_G2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
int BN_getUint64NumToPrecompute(void)
{
	return int(BN::param.precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t));
}

void BN_precomputeG2(uint64_t *Qbuf, const BN_G2 *Q)
{
	BN::precomputeG2(cast(Qbuf), *cast(Q));
}

void BN_precomputedMillerLoop(BN_GT *f, const BN_G1 *P, const uint64_t *Qbuf)
{
	BN::precomputedMillerLoop(*cast(f), *cast(P), cast(Qbuf));
}

void BN_precomputedMillerLoop2(BN_GT *f, const BN_G1 *P1, const uint64_t  *Q1buf, const BN_G1 *P2, const uint64_t *Q2buf)
{
	BN::precomputedMillerLoop2(*cast(f), *cast(P1), cast(Q1buf), *cast(P2), cast(Q2buf));
}
