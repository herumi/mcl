#include <mcl/bn256.hpp>
#define BN256_DLL_EXPORT
#define BN256_DEFINE_STRUCT
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

static Fr *cast(BN256_Fr *p) { return reinterpret_cast<Fr*>(p); }
static const Fr *cast(const BN256_Fr *p) { return reinterpret_cast<const Fr*>(p); }

static G1 *cast(BN256_G1 *p) { return reinterpret_cast<G1*>(p); }
static const G1 *cast(const BN256_G1 *p) { return reinterpret_cast<const G1*>(p); }

static G2 *cast(BN256_G2 *p) { return reinterpret_cast<G2*>(p); }
static const G2 *cast(const BN256_G2 *p) { return reinterpret_cast<const G2*>(p); }

static Fp12 *cast(BN256_GT *p) { return reinterpret_cast<Fp12*>(p); }
static const Fp12 *cast(const BN256_GT *p) { return reinterpret_cast<const Fp12*>(p); }

static int closeErrFile()
{
	if (g_fp == NULL || g_fp == stderr) {
		return 0;
	}
	int ret = fclose(g_fp);
	g_fp = NULL;
	return ret;
}

int BN256_setErrFile(const char *name)
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

int BN256_init(void)
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
void BN256_Fr_clear(BN256_Fr *x)
{
	cast(x)->clear();
}

// set x to y
void BN256_Fr_setInt(BN256_Fr *y, int x)
{
	*cast(y) = x;
}

void BN256_Fr_copy(BN256_Fr *y, const BN256_Fr *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN256_Fr_setStr(BN256_Fr *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN256_Fr_isValid(const BN256_Fr *x)
{
	return cast(x)->isValid();
}
int BN256_Fr_isSame(const BN256_Fr *x, const BN256_Fr *y)
{
	return *cast(x) == *cast(y);
}
int BN256_Fr_isZero(const BN256_Fr *x)
{
	return cast(x)->isZero();
}
int BN256_Fr_isOne(const BN256_Fr *x)
{
	return cast(x)->isOne();
}

void BN256_Fr_setRand(BN256_Fr *x)
{
	cast(x)->setRand(g_rg);
}

// hash(str) and set x
void BN256_Fr_setMsg(BN256_Fr *x, const char *str)
{
	cast(x)->setMsg(str);
}

// return 0 if success
int BN256_Fr_getStr(char *buf, int maxBufSize, const BN256_Fr *x)
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

void BN256_Fr_neg(BN256_Fr *y, const BN256_Fr *x)
{
	Fr::neg(*cast(y), *cast(x));
}
void BN256_Fr_inv(BN256_Fr *y, const BN256_Fr *x)
{
	Fr::inv(*cast(y), *cast(x));
}
void BN256_Fr_add(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y)
{
	Fr::add(*cast(z),*cast(x), *cast(y));
}
void BN256_Fr_sub(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y)
{
	Fr::sub(*cast(z),*cast(x), *cast(y));
}
void BN256_Fr_mul(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y)
{
	Fr::mul(*cast(z),*cast(x), *cast(y));
}
void BN256_Fr_div(BN256_Fr *z, const BN256_Fr *x, const BN256_Fr *y)
{
	Fr::div(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN256_G1_clear(BN256_G1 *x)
{
	cast(x)->clear();
}

void BN256_G1_copy(BN256_G1 *y, const BN256_G1 *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN256_G1_setStr(BN256_G1 *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN256_G1_isValid(const BN256_G1 *x)
{
	return cast(x)->isValid();
}
int BN256_G1_isSame(const BN256_G1 *x, const BN256_G1 *y)
{
	return *cast(x) == *cast(y);
}
int BN256_G1_isZero(const BN256_G1 *x)
{
	return cast(x)->isZero();
}

int BN256_G1_hashAndMapTo(BN256_G1 *x, const char *str)
	try
{
	Fp y;
	y.setMsg(str);
	BN::mapToG1(*cast(x), y);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 0 if success
int BN256_G1_getStr(char *buf, int maxBufSize, const BN256_G1 *x)
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

void BN256_G1_neg(BN256_G1 *y, const BN256_G1 *x)
{
	G1::neg(*cast(y), *cast(x));
}
void BN256_G1_dbl(BN256_G1 *y, const BN256_G1 *x)
{
	G1::dbl(*cast(y), *cast(x));
}
void BN256_G1_add(BN256_G1 *z, const BN256_G1 *x, const BN256_G1 *y)
{
	G1::add(*cast(z),*cast(x), *cast(y));
}
void BN256_G1_sub(BN256_G1 *z, const BN256_G1 *x, const BN256_G1 *y)
{
	G1::sub(*cast(z),*cast(x), *cast(y));
}
void BN256_G1_mul(BN256_G1 *z, const BN256_G1 *x, const BN256_Fr *y)
{
	G1::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN256_G2_clear(BN256_G2 *x)
{
	cast(x)->clear();
}

void BN256_G2_copy(BN256_G2 *y, const BN256_G2 *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN256_G2_setStr(BN256_G2 *x, const char *str)
	try
{
	cast(x)->setStr(str);
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 1 if true
int BN256_G2_isValid(const BN256_G2 *x)
{
	return cast(x)->isValid();
}
int BN256_G2_isSame(const BN256_G2 *x, const BN256_G2 *y)
{
	return *cast(x) == *cast(y);
}
int BN256_G2_isZero(const BN256_G2 *x)
{
	return cast(x)->isZero();
}

int BN256_G2_hashAndMapTo(BN256_G2 *x, const char *str)
	try
{
	Fp y;
	y.setMsg(str);
	BN::mapToG2(*cast(x), Fp2(y, 0));
	return 0;
} catch (std::exception& e) {
	if (g_fp) fprintf(g_fp, "%s\n", e.what());
	return 1;
}

// return 0 if success
int BN256_G2_getStr(char *buf, int maxBufSize, const BN256_G2 *x)
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

void BN256_G2_neg(BN256_G2 *y, const BN256_G2 *x)
{
	G2::neg(*cast(y), *cast(x));
}
void BN256_G2_dbl(BN256_G2 *y, const BN256_G2 *x)
{
	G2::dbl(*cast(y), *cast(x));
}
void BN256_G2_add(BN256_G2 *z, const BN256_G2 *x, const BN256_G2 *y)
{
	G2::add(*cast(z),*cast(x), *cast(y));
}
void BN256_G2_sub(BN256_G2 *z, const BN256_G2 *x, const BN256_G2 *y)
{
	G2::sub(*cast(z),*cast(x), *cast(y));
}
void BN256_G2_mul(BN256_G2 *z, const BN256_G2 *x, const BN256_Fr *y)
{
	G2::mul(*cast(z),*cast(x), *cast(y));
}

////////////////////////////////////////////////
// set zero
void BN256_GT_clear(BN256_GT *x)
{
	cast(x)->clear();
}

void BN256_GT_copy(BN256_GT *y, const BN256_GT *x)
{
	*cast(y) = *cast(x);
}

// return 0 if success
int BN256_GT_setStr(BN256_GT *x, const char *str)
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
int BN256_GT_isSame(const BN256_GT *x, const BN256_GT *y)
{
	return *cast(x) == *cast(y);
}
int BN256_GT_isZero(const BN256_GT *x)
{
	return cast(x)->isZero();
}
int BN256_GT_isOne(const BN256_GT *x)
{
	return cast(x)->isOne();
}

// return 0 if success
int BN256_GT_getStr(char *buf, int maxBufSize, const BN256_GT *x)
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

void BN256_GT_neg(BN256_GT *y, const BN256_GT *x)
{
	Fp12::neg(*cast(y), *cast(x));
}
void BN256_GT_inv(BN256_GT *y, const BN256_GT *x)
{
	Fp12::inv(*cast(y), *cast(x));
}
void BN256_GT_add(BN256_GT *z, const BN256_GT *x, const BN256_GT *y)
{
	Fp12::add(*cast(z),*cast(x), *cast(y));
}
void BN256_GT_sub(BN256_GT *z, const BN256_GT *x, const BN256_GT *y)
{
	Fp12::sub(*cast(z),*cast(x), *cast(y));
}
void BN256_GT_mul(BN256_GT *z, const BN256_GT *x, const BN256_GT *y)
{
	Fp12::mul(*cast(z),*cast(x), *cast(y));
}
void BN256_GT_div(BN256_GT *z, const BN256_GT *x, const BN256_GT *y)
{
	Fp12::div(*cast(z),*cast(x), *cast(y));
}

void BN256_GT_finalExp(BN256_GT *y, const BN256_GT *x)
{
	BN::finalExp(*cast(y), *cast(x));
}
void BN256_GT_pow(BN256_GT *z, const BN256_GT *x, const BN256_Fr *y)
{
	Fp12::pow(*cast(z), *cast(x), *cast(y));
}

void BN256_pairing(BN256_GT *z, const BN256_G1 *x, const BN256_G2 *y)
{
	BN::pairing(*cast(z), *cast(x), *cast(y));
}
void BN256_millerLoop(BN256_GT *z, const BN256_G1 *x, const BN256_G2 *y)
{
	BN::millerLoop(*cast(z), *cast(x), *cast(y));
}
