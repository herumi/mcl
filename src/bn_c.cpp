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

static Fr *cast(MBN_Fr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const MBN_Fr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(MBN_G1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const MBN_G1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(MBN_G2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const MBN_G2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(MBN_GT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const MBN_GT *p) { return reinterpret_cast<const Fp12*>(p); }

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

int MBN_setErrFile(const char *name)
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

int MBN_init(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != MBN_FP_UNIT_SIZE) {
		if (g_fp) fprintf(g_fp, "MBN_init:maxUnitSize is mismatch %d %d\n", maxUnitSize, MBN_FP_UNIT_SIZE);
		return -1;
	}
	mcl::bn::CurveParam cp;
	switch (curve) {
	case MBN_curveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
#if MBN_FP_UNIT_SIZE == 6
	case MBN_curveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case MBN_curveFp382_2:
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
void MBN_Fr_clear(MBN_Fr *x)
{
	cast(x)->clear();
}

// set x to y
void MBN_Fr_setInt(MBN_Fr *y, int x)
{
	*cast(y) = x;
}

int MBN_Fr_setDecStr(MBN_Fr *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 10, "MBN_Fr_setDecStr", false);
}
int MBN_Fr_setHexStr(MBN_Fr *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 16, "MBN_Fr_setHexStr", false);
}
int MBN_Fr_setLittleEndian(MBN_Fr *x, const void *buf, size_t bufSize)
{
	const size_t byteSize = cast(x)->getByteSize();
	if (bufSize > byteSize) bufSize = byteSize;
	std::string s((const char *)buf, bufSize);
	s.resize(byteSize);
	return deserialize(x, s.c_str(), s.size(), mcl::IoFixedSizeByteSeq, "MBN_Fr_setLittleEndian", false);
}

// return 1 if true
int MBN_Fr_isValid(const MBN_Fr *x)
{
	return cast(x)->isValid();
}
int MBN_Fr_isEqual(const MBN_Fr *x, const MBN_Fr *y)
{
	return *cast(x) == *cast(y);
}
int MBN_Fr_isZero(const MBN_Fr *x)
{
	return cast(x)->isZero();
}
int MBN_Fr_isOne(const MBN_Fr *x)
{
	return cast(x)->isOne();
}

void MBN_Fr_setByCSPRNG(MBN_Fr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(buf) and set x
int MBN_hashToFr(MBN_Fr *x, const void *buf, size_t bufSize)
	try
{
	cast(x)->setHashOf(buf, bufSize);
	return 0;
} catch (std::exception& e) {
	return -1;
}

size_t MBN_Fr_getDecStr(char *buf, size_t maxBufSize, const MBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 10, "MBN_Fr_getDecStr", false);
}
size_t MBN_Fr_getHexStr(char *buf, size_t maxBufSize, const MBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, 16, "MBN_Fr_getHexStr", false);
}
size_t MBN_Fr_getLittleEndian(void *buf, size_t maxBufSize, const MBN_Fr *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_Fr_getLittleEndian", false);
}

void MBN_Fr_neg(MBN_Fr *y, const MBN_Fr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void MBN_Fr_inv(MBN_Fr *y, const MBN_Fr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void MBN_Fr_add(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void MBN_Fr_sub(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void MBN_Fr_mul(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void MBN_Fr_div(MBN_Fr *z, const MBN_Fr *x, const MBN_Fr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MBN_G1_clear(MBN_G1 *x)
{
	cast(x)->clear();
}

int MBN_G1_setHexStr(MBN_G1 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MBN_G1_setHexStr", true);
}
int MBN_G1_deserialize(MBN_G1 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MBN_G1_setHexStr", false);
}

// return 1 if true
int MBN_G1_isValid(const MBN_G1 *x)
{
	return cast(x)->isValid();
}
int MBN_G1_isEqual(const MBN_G1 *x, const MBN_G1 *y)
{
	return *cast(x) == *cast(y);
}
int MBN_G1_isZero(const MBN_G1 *x)
{
	return cast(x)->isZero();
}

int MBN_hashAndMapToG1(MBN_G1 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "MBN_hashAndMapToG1 %s\n", e.what());
	return 1;
}

size_t MBN_G1_getHexStr(char *buf, size_t maxBufSize, const MBN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_G1_getHexStr", true);
}

size_t MBN_G1_serialize(void *buf, size_t maxBufSize, const MBN_G1 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_G1_serialize", false);
}

void MBN_G1_neg(MBN_G1 *y, const MBN_G1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void MBN_G1_dbl(MBN_G1 *y, const MBN_G1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void MBN_G1_add(MBN_G1 *z, const MBN_G1 *x, const MBN_G1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void MBN_G1_sub(MBN_G1 *z, const MBN_G1 *x, const MBN_G1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void MBN_G1_mul(MBN_G1 *z, const MBN_G1 *x, const MBN_Fr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MBN_G2_clear(MBN_G2 *x)
{
	cast(x)->clear();
}

int MBN_G2_setHexStr(MBN_G2 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MBN_G2_setHexStr", true);
}
int MBN_G2_deserialize(MBN_G2 *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MBN_G2_setHexStr", false);
}

// return 1 if true
int MBN_G2_isValid(const MBN_G2 *x)
{
	return cast(x)->isValid();
}
int MBN_G2_isEqual(const MBN_G2 *x, const MBN_G2 *y)
{
	return *cast(x) == *cast(y);
}
int MBN_G2_isZero(const MBN_G2 *x)
{
	return cast(x)->isZero();
}

int MBN_hashAndMapToG2(MBN_G2 *x, const void *buf, size_t bufSize)
	try
{
	Fp y;
	y.setHashOf(buf, bufSize);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "MBN_hashAndMapToG2 %s\n", e.what());
	return 1;
}

size_t MBN_G2_getHexStr(char *buf, size_t maxBufSize, const MBN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_G2_getHexStr", true);
}

size_t MBN_G2_serialize(void *buf, size_t maxBufSize, const MBN_G2 *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_G2_serialize", false);
}

void MBN_G2_neg(MBN_G2 *y, const MBN_G2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void MBN_G2_dbl(MBN_G2 *y, const MBN_G2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void MBN_G2_add(MBN_G2 *z, const MBN_G2 *x, const MBN_G2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void MBN_G2_sub(MBN_G2 *z, const MBN_G2 *x, const MBN_G2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void MBN_G2_mul(MBN_G2 *z, const MBN_G2 *x, const MBN_Fr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void MBN_GT_clear(MBN_GT *x)
{
	cast(x)->clear();
}

int MBN_GT_setDecStr(MBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 10, "MBN_GT_setDecStr", false);
}
int MBN_GT_setHexStr(MBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, 16, "MBN_GT_setHexStr", false);
}
int MBN_GT_deserialize(MBN_GT *x, const char *buf, size_t bufSize)
{
	return deserialize(x, buf, bufSize, mcl::IoFixedSizeByteSeq, "MBN_GT_setHexStr", false);
}

// return 1 if true
int MBN_GT_isEqual(const MBN_GT *x, const MBN_GT *y)
{
	return *cast(x) == *cast(y);
}
int MBN_GT_isZero(const MBN_GT *x)
{
	return cast(x)->isZero();
}
int MBN_GT_isOne(const MBN_GT *x)
{
	return cast(x)->isOne();
}

size_t MBN_GT_getDecStr(char *buf, size_t maxBufSize, const MBN_GT *x)
{
	return serialize(buf, maxBufSize, x, 10, "MBN_GT_getDecStr", false);
}

size_t MBN_GT_getHexStr(char *buf, size_t maxBufSize, const MBN_GT *x)
{
	return serialize(buf, maxBufSize, x, 16, "MBN_GT_getHexStr", false);
}

size_t MBN_GT_serialize(void *buf, size_t maxBufSize, const MBN_GT *x)
{
	return serialize(buf, maxBufSize, x, mcl::IoFixedSizeByteSeq, "MBN_GT_serialize", false);
}

void MBN_GT_neg(MBN_GT *y, const MBN_GT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void MBN_GT_inv(MBN_GT *y, const MBN_GT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void MBN_GT_add(MBN_GT *z, const MBN_GT *x, const MBN_GT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void MBN_GT_sub(MBN_GT *z, const MBN_GT *x, const MBN_GT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void MBN_GT_mul(MBN_GT *z, const MBN_GT *x, const MBN_GT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void MBN_GT_div(MBN_GT *z, const MBN_GT *x, const MBN_GT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void MBN_GT_pow(MBN_GT *z, const MBN_GT *x, const MBN_Fr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void MBN_pairing(MBN_GT *z, const MBN_G1 *x, const MBN_G2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void MBN_finalExp(MBN_GT *y, const MBN_GT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void MBN_millerLoop(MBN_GT *z, const MBN_G1 *x, const MBN_G2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
int MBN_getUint64NumToPrecompute(void)
{
	return int(BN::param.precomputedQcoeffSize * sizeof(Fp6) / sizeof(uint64_t));
}

void MBN_precomputeG2(uint64_t *Qbuf, const MBN_G2 *Q)
{
	BN::precomputeG2(cast(Qbuf), *cast(Q));
}

void MBN_precomputedMillerLoop(MBN_GT *f, const MBN_G1 *P, const uint64_t *Qbuf)
{
	BN::precomputedMillerLoop(*cast(f), *cast(P), cast(Qbuf));
}

void MBN_precomputedMillerLoop2(MBN_GT *f, const MBN_G1 *P1, const uint64_t  *Q1buf, const MBN_G1 *P2, const uint64_t *Q2buf)
{
	BN::precomputedMillerLoop2(*cast(f), *cast(P1), cast(Q1buf), *cast(P2), cast(Q2buf));
}
