#define ECDSA_DLL_EXPORT
#include <mcl/ecdsa.h>
#include <mcl/ecdsa.hpp>

using namespace mcl::ecdsa;

static SecretKey *cast(ecdsaSecretKey *p) { return reinterpret_cast<SecretKey*>(p); }
static const SecretKey *cast(const ecdsaSecretKey *p) { return reinterpret_cast<const SecretKey*>(p); }

static PublicKey *cast(ecdsaPublicKey *p) { return reinterpret_cast<PublicKey*>(p); }
static const PublicKey *cast(const ecdsaPublicKey *p) { return reinterpret_cast<const PublicKey*>(p); }

static Signature *cast(ecdsaSignature *p) { return reinterpret_cast<Signature*>(p); }
static const Signature *cast(const ecdsaSignature *p) { return reinterpret_cast<const Signature*>(p); }

static PrecomputedPublicKey *cast(ecdsaPrecomputedPublicKey *p) { return reinterpret_cast<PrecomputedPublicKey*>(p); }
static const PrecomputedPublicKey *cast(const ecdsaPrecomputedPublicKey *p) { return reinterpret_cast<const PrecomputedPublicKey*>(p); }

int ecdsaInit(void)
	try
{
	init();
	return 0;
} catch (std::exception&) {
	return -1;
}

template<class T>
mclSize serialize(void *buf, mclSize maxBufSize, const T *x)
	try
{
	return (mclSize)cast(x)->serialize(buf, maxBufSize);
} catch (std::exception&) {
	return 0;
}

mclSize ecdsaSecretKeySerialize(void *buf, mclSize maxBufSize, const ecdsaSecretKey *sec)
{
	return serialize(buf, maxBufSize, sec);
}
mclSize ecdsaPublicKeySerialize(void *buf, mclSize maxBufSize, const ecdsaPublicKey *pub)
{
	return serialize(buf, maxBufSize, pub);
}
mclSize ecdsaSignatureSerialize(void *buf, mclSize maxBufSize, const ecdsaSignature *sig)
{
	return serialize(buf, maxBufSize, sig);
}

template<class T>
mclSize deserialize(T *x, const void *buf, mclSize bufSize)
	try
{
	return (mclSize)cast(x)->deserialize(buf, bufSize);
} catch (std::exception&) {
	return 0;
}

mclSize ecdsaSecretKeyDeserialize(ecdsaSecretKey* sec, const void *buf, mclSize bufSize)
{
	return deserialize(sec, buf, bufSize);
}
mclSize ecdsaPublicKeyDeserialize(ecdsaPublicKey* pub, const void *buf, mclSize bufSize)
{
	return deserialize(pub, buf, bufSize);
}
mclSize ecdsaSignatureDeserialize(ecdsaSignature* sig, const void *buf, mclSize bufSize)
{
	return deserialize(sig, buf, bufSize);
}

//	return 0 if success
int ecdsaSecretKeySetByCSPRNG(ecdsaSecretKey *sec)
	try
{
	cast(sec)->setByCSPRNG();
	return 0;
} catch (...) {
	return -1;
}

void ecdsaGetPublicKey(ecdsaPublicKey *pub, const ecdsaSecretKey *sec)
{
	getPublicKey(*cast(pub), *cast(sec));
}

void ecdsaSign(ecdsaSignature *sig, const ecdsaSecretKey *sec, const void *m, mclSize size)
{
	sign(*cast(sig), *cast(sec), m, size);
}

int ecdsaVerify(const ecdsaSignature *sig, const ecdsaPublicKey *pub, const void *m, mclSize size)
{
	return verify(*cast(sig), *cast(pub), m, size);
}
int ecdsaVerifyPrecomputed(const ecdsaSignature *sig, const ecdsaPrecomputedPublicKey *ppub, const void *m, mclSize size)
{
	return verify(*cast(sig), *cast(ppub), m, size);
}

ecdsaPrecomputedPublicKey *ecdsaPrecomputedPublicKeyCreate()
	try
{
	return reinterpret_cast<ecdsaPrecomputedPublicKey*>(new PrecomputedPublicKey());
} catch (...) {
	return 0;
}

void ecdsaPrecomputedPublicKeyDestroy(ecdsaPrecomputedPublicKey *ppub)
{
	delete cast(ppub);
}

int ecdsaPrecomputedPublicKeyInit(ecdsaPrecomputedPublicKey *ppub, const ecdsaPublicKey *pub)
	try
{
	cast(ppub)->init(*cast(pub));
	return 0;
} catch (...) {
	return -1;
}
