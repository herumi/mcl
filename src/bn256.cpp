#include <mcl/bn256.hpp>
#define BN_DLL_EXPORT
#define BN_DEFINE_STRUCT
#include <mcl/bn256.h>
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
static std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
static cybozu::RandomGenerator g_rg;
#endif

using namespace mcl::bn256;

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

int BN_init(void)
	try
{
	bn256init();
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
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

void BN_Fr_copy(BN_Fr *y, const BN_Fr *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN_Fr_setStr(BN_Fr *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN_Fr_isValid(const BN_Fr *x)
{
	return cast(x)->isValid();
}
int BN_Fr_isSame(const BN_Fr *x, const BN_Fr *y)
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

void BN_Fr_setRand(BN_Fr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(str) and set x
void BN_Fr_setHashOf(BN_Fr *x, const char *str)
{
	cast(x)->setHashOf(str);
}

// return 0 if success
int BN_Fr_getStr(char *buf, int maxBufSize, const BN_Fr *x)
	try
{
	std::string str;
	cast(x)->getStr(str);
	if ((int)str.size() < maxBufSize) {
		memcpy(buf, str.c_str(), str.size() + 1);
		return 0;
	}
	return 1;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
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

void BN_G1_copy(BN_G1 *y, const BN_G1 *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN_G1_setStr(BN_G1 *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN_G1_isValid(const BN_G1 *x)
{
	return cast(x)->isValid();
}
int BN_G1_isSame(const BN_G1 *x, const BN_G1 *y)
{
	return *cast(x) == *cast(y);
}
int BN_G1_isZero(const BN_G1 *x)
{
	return cast(x)->isZero();
}

int BN_G1_hashAndMapTo(BN_G1 *x, const char *str)
	try
{
	Fp y;
	y.setHashOf(str);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 0 if success
int BN_G1_getStr(char *buf, int maxBufSize, const BN_G1 *x)
	try
{
	std::string str;
	cast(x)->getStr(str);
	if ((int)str.size() < maxBufSize) {
		memcpy(buf, str.c_str(), str.size() + 1);
		return 0;
	}
	return 1;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
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

void BN_G2_copy(BN_G2 *y, const BN_G2 *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN_G2_setStr(BN_G2 *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN_G2_isValid(const BN_G2 *x)
{
	return cast(x)->isValid();
}
int BN_G2_isSame(const BN_G2 *x, const BN_G2 *y)
{
	return *cast(x) == *cast(y);
}
int BN_G2_isZero(const BN_G2 *x)
{
	return cast(x)->isZero();
}

int BN_G2_hashAndMapTo(BN_G2 *x, const char *str)
	try
{
	Fp y;
	y.setHashOf(str);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 0 if success
int BN_G2_getStr(char *buf, int maxBufSize, const BN_G2 *x)
	try
{
	std::string str;
	cast(x)->getStr(str);
	if ((int)str.size() < maxBufSize) {
		memcpy(buf, str.c_str(), str.size() + 1);
		return 0;
	}
	return 1;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
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

void BN_GT_copy(BN_GT *y, const BN_GT *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN_GT_setStr(BN_GT *x, const char *str)
	try
{
	std::istringstream is(str);
	is >> *cast(x);
	return is ? 0 : 1;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN_GT_isSame(const BN_GT *x, const BN_GT *y)
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

// return 0 if success
int BN_GT_getStr(char *buf, int maxBufSize, const BN_GT *x)
	try
{
	std::string str = cast(x)->getStr();
	if ((int)str.size() < maxBufSize) {
		memcpy(buf, str.c_str(), str.size() + 1);
		return 0;
	}
	return 1;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
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

void BN_GT_finalExp(BN_GT *y, const BN_GT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void BN_GT_pow(BN_GT *z, const BN_GT *x, const BN_Fr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void BN_pairing(BN_GT *z, const BN_G1 *x, const BN_G2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
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
