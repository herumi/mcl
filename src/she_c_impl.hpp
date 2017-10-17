#include <iostream>
#include <sstream>
#include <vector>
#include <string>
#include <iosfwd>
#include <stdint.h>
#include <memory.h>
#include "../src/bn_c_impl.hpp"
#define MCLSHE_DLL_EXPORT

#include <mcl/she.h>
#include <mcl/she.hpp>

using namespace mcl::she;
using namespace mcl::bn_current;

#if defined(CYBOZU_CPP_VERSION) && CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <mutex>
	#define USE_STD_MUTEX
#else
#include <cybozu/mutex.hpp>
#endif

static SecretKey *cast(sheSecretKey *p) { return reinterpret_cast<SecretKey*>(p); }
static const SecretKey *cast(const sheSecretKey *p) { return reinterpret_cast<const SecretKey*>(p); }

static PublicKey *cast(shePublicKey *p) { return reinterpret_cast<PublicKey*>(p); }
static const PublicKey *cast(const shePublicKey *p) { return reinterpret_cast<const PublicKey*>(p); }

static CipherTextG1 *cast(sheCipherTextG1 *p) { return reinterpret_cast<CipherTextG1*>(p); }
static const CipherTextG1 *cast(const sheCipherTextG1 *p) { return reinterpret_cast<const CipherTextG1*>(p); }

static CipherTextG2 *cast(sheCipherTextG2 *p) { return reinterpret_cast<CipherTextG2*>(p); }
static const CipherTextG2 *cast(const sheCipherTextG2 *p) { return reinterpret_cast<const CipherTextG2*>(p); }

static CipherTextGT *cast(sheCipherTextGT *p) { return reinterpret_cast<CipherTextGT*>(p); }
static const CipherTextGT *cast(const sheCipherTextGT *p) { return reinterpret_cast<const CipherTextGT*>(p); }

int sheInit(int curve, int maxUnitSize)
	try
{
	if (maxUnitSize != MCLBN_FP_UNIT_SIZE) {
		printf("err sheInit:maxUnitSize is mismatch %d %d\n", maxUnitSize, MCLBN_FP_UNIT_SIZE);
		return -1;
	}
#ifdef USE_STD_MUTEX
	static std::mutex m;
	std::lock_guard<std::mutex> lock(m);
#else
	static cybozu::Mutex m;
	cybozu::AutoLock lock(m);
#endif
	static int g_curve = -1;
	if (g_curve == curve) return 0;

	mcl::bn::CurveParam cp;
	switch (curve) {
	case mclBn_CurveFp254BNb:
		cp = mcl::bn::CurveFp254BNb;
		break;
	case mclBn_CurveFp382_1:
		cp = mcl::bn::CurveFp382_1;
		break;
	case mclBn_CurveFp382_2:
		cp = mcl::bn::CurveFp382_2;
		break;
	case mclBn_CurveFp462:
		cp = mcl::bn::CurveFp462;
		break;
	default:
		printf("err bad curve %d\n", curve);
		return -1;
	}
	SHE::init(cp);
	g_curve = curve;
	return 0;
} catch (std::exception& e) {
	printf("err sheInit %s\n", e.what());
	return -1;
}

size_t sheSecretKeySerialize(void *buf, size_t maxBufSize, const sheSecretKey *sec)
{
	char *p = (char *)buf;
	size_t n = mclBnFr_serialize(p, maxBufSize, &sec->x);
	if (n == 0) return 0;
	return n += mclBnFr_serialize(p + n, maxBufSize - n, &sec->y);
}

size_t shePublicKeySerialize(void *buf, size_t maxBufSize, const shePublicKey *pub)
{
	char *p = (char *)buf;
	size_t n = mclBnG1_serialize(p, maxBufSize, &pub->xP);
	if (n == 0) return 0;
	return n += mclBnG2_serialize(p + n, maxBufSize - n, &pub->yQ);
}

size_t sheCipherTextG1Serialize(void *buf, size_t maxBufSize, const sheCipherTextG1 *c)
{
	char *p = (char *)buf;
	size_t n = mclBnG1_serialize(p, maxBufSize, &c->S);
	if (n == 0) return 0;
	return n += mclBnG1_serialize(p + n, maxBufSize - n, &c->T);
}

size_t sheCipherTextG2Serialize(void *buf, size_t maxBufSize, const sheCipherTextG2 *c)
{
	char *p = (char *)buf;
	size_t n = mclBnG2_serialize(p, maxBufSize, &c->S);
	if (n == 0) return 0;
	return n += mclBnG2_serialize(p + n, maxBufSize - n, &c->T);
}

size_t sheCipherTextGTSerialize(void *buf, size_t maxBufSize, const sheCipherTextGT *c)
{
	char *p = (char *)buf;
	size_t n = 0;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(c->g); i++) {
		size_t r = mclBnGT_serialize(p + n, maxBufSize - n, &c->g[i]);
		if (r == 0) return 0;
		n += r;
	}
	return n;
}

int sheSecretKeyDeserialize(sheSecretKey* sec, const void *buf, size_t bufSize)
{
	const char *p = (const char *)buf;
	if (mclBnFr_deserialize(&sec->x, p, bufSize)) return -1;
	const size_t size = Fr::getByteSize();
	return mclBnFr_deserialize(&sec->y, p + size, bufSize - size);
}

int shePublicKeyDeserialize(shePublicKey* sec, const void *buf, size_t bufSize)
{
	const char *p = (const char *)buf;
	if (mclBnG1_deserialize(&sec->xP, p, bufSize)) return -1;
	const size_t size = Fr::getByteSize();
	return mclBnG2_deserialize(&sec->yQ, p + size, bufSize - size);
}

int sheCipherTextG1Deserialize(sheCipherTextG1* c, const void *buf, size_t bufSize)
{
	const char *p = (const char *)buf;
	if (mclBnG1_deserialize(&c->S, p, bufSize)) return -1;
	const size_t size = Fr::getByteSize();
	return mclBnG1_deserialize(&c->T, p + size, bufSize - size);
}

int sheCipherTextG2Deserialize(sheCipherTextG2* c, const void *buf, size_t bufSize)
{
	const char *p = (const char *)buf;
	if (mclBnG2_deserialize(&c->S, p, bufSize)) return -1;
	const size_t size = Fr::getByteSize() * 2;
	return mclBnG2_deserialize(&c->T, p + size, bufSize - size);
}

int sheCipherTextGTDeserialize(sheCipherTextGT* c, const void *buf, size_t bufSize)
{
	const char *p = (const char *)buf;
	const size_t size = Fr::getByteSize() * 12;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(c->g); i++) {
		if (mclBnGT_deserialize(&c->g[i], p + size * i, bufSize - size * i)) return -1;
	}
	return 0;
}

int sheSecretKeySetByCSPRNG(sheSecretKey *sec)
	try
{
	cast(sec)->setByCSPRNG();
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

void sheGetPublicKey(shePublicKey *pub, const sheSecretKey *sec)
{
	cast(sec)->getPublicKey(*cast(pub));
}

static int setRangeForDLP(void (*f)(size_t, size_t), size_t hashSize, size_t tryNum)
	try
{
	f(hashSize, tryNum);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheSetRangeForDLP(size_t hashSize, size_t tryNum)
{
	return setRangeForDLP(SHE::setRangeForDLP, hashSize, tryNum);
}
int sheSetRangeForG1DLP(size_t hashSize, size_t tryNum)
{
	return setRangeForDLP(SHE::setRangeForG1DLP, hashSize, tryNum);
}
int sheSetRangeForG2DLP(size_t hashSize, size_t tryNum)
{
	return setRangeForDLP(SHE::setRangeForG2DLP, hashSize, tryNum);
}
int sheSetRangeForGTDLP(size_t hashSize, size_t tryNum)
{
	return setRangeForDLP(SHE::setRangeForGTDLP, hashSize, tryNum);
}

template<class CT>
int encT(CT *c, const shePublicKey *pub, int64_t m)
	try
{
	cast(pub)->enc(*cast(c), m);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheEncG1(sheCipherTextG1 *c, const shePublicKey *pub, int64_t m)
{
	return encT(c, pub, m);
}

int sheEncG2(sheCipherTextG2 *c, const shePublicKey *pub, int64_t m)
{
	return encT(c, pub, m);
}

int sheEncGT(sheCipherTextGT *c, const shePublicKey *pub, int64_t m)
{
	return encT(c, pub, m);
}

int sheEnc32G1(sheCipherTextG1 *c, const shePublicKey *pub, int m)
{
	return encT(c, pub, m);
}

int sheEnc32G2(sheCipherTextG2 *c, const shePublicKey *pub, int m)
{
	return encT(c, pub, m);
}

int sheEnc32GT(sheCipherTextGT *c, const shePublicKey *pub, int m)
{
	return encT(c, pub, m);
}

template<class CT>
int decT(int64_t *m, const sheSecretKey *sec, const CT *c)
	try
{
	*m = cast(sec)->dec(*cast(c));
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheDecG1(int64_t *m, const sheSecretKey *sec, const sheCipherTextG1 *c)
{
	return decT(m, sec, c);
}

int sheDecG2(int64_t *m, const sheSecretKey *sec, const sheCipherTextG2 *c)
{
	return decT(m, sec, c);
}

int sheDecGT(int64_t *m, const sheSecretKey *sec, const sheCipherTextGT *c)
{
	return decT(m, sec, c);
}

template<class CT>
int addT(CT& z, const CT& x, const CT& y)
	try
{
	CT::add(z, x, y);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheAddG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, const sheCipherTextG1 *y)
{
	return addT(*cast(z), *cast(x), *cast(y));
}

int sheAddG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, const sheCipherTextG2 *y)
{
	return addT(*cast(z), *cast(x), *cast(y));
}

int sheAddGT(sheCipherTextGT *z, const sheCipherTextGT *x, const sheCipherTextGT *y)
{
	return addT(*cast(z), *cast(x), *cast(y));
}

template<class CT>
int subT(CT& z, const CT& x, const CT& y)
	try
{
	CT::sub(z, x, y);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheSubG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, const sheCipherTextG1 *y)
{
	return subT(*cast(z), *cast(x), *cast(y));
}

int sheSubG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, const sheCipherTextG2 *y)
{
	return subT(*cast(z), *cast(x), *cast(y));
}

int sheSubGT(sheCipherTextGT *z, const sheCipherTextGT *x, const sheCipherTextGT *y)
{
	return subT(*cast(z), *cast(x), *cast(y));
}

template<class CT1, class CT2, class CT3>
int mulT(CT1& z, const CT2& x, const CT3& y)
	try
{
	CT1::mul(z, x, y);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheMulG1(sheCipherTextG1 *z, const sheCipherTextG1 *x, int64_t y)
{
	return mulT(*cast(z), *cast(x), y);
}

int sheMulG2(sheCipherTextG2 *z, const sheCipherTextG2 *x, int64_t y)
{
	return mulT(*cast(z), *cast(x), y);
}

int sheMulGT(sheCipherTextGT *z, const sheCipherTextGT *x, int64_t y)
{
	return mulT(*cast(z), *cast(x), y);
}

int sheMul(sheCipherTextGT *z, const sheCipherTextG1 *x, const sheCipherTextG2 *y)
{
	return mulT(*cast(z), *cast(x), *cast(y));
}

template<class CT>
int reRandT(CT& c, const shePublicKey *pub)
	try
{
	cast(pub)->reRand(c);
	return 0;
} catch (std::exception& e) {
	printf("err %s\n", e.what());
	return -1;
}

int sheReRandG1(sheCipherTextG1 *c, const shePublicKey *pub)
{
	return reRandT(*cast(c), pub);
}

int sheReRandG2(sheCipherTextG2 *c, const shePublicKey *pub)
{
	return reRandT(*cast(c), pub);
}

int sheReRandGT(sheCipherTextGT *c, const shePublicKey *pub)
{
	return reRandT(*cast(c), pub);
}

