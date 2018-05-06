#include <mcl/ecdsa.h>
#include <cybozu/test.hpp>
#include <string.h>

template<class T, class Serializer, class Deserializer>
void serializeTest(const T& x, const Serializer& serialize, const Deserializer& deserialize)
{
	char buf[128];
	size_t n = serialize(buf, sizeof(buf), &x);
	CYBOZU_TEST_ASSERT(n > 0);
	T y;
	size_t m = deserialize(&y, buf, n);
	CYBOZU_TEST_EQUAL(m, n);
	CYBOZU_TEST_ASSERT(memcmp(&x, &y, n) == 0);
}

CYBOZU_TEST_AUTO(ecdsa)
{
	int ret;
	ret = ecdsaInit();
	CYBOZU_TEST_EQUAL(ret, 0);
	ecdsaSecretKey sec;
	ecdsaPublicKey pub;
	ecdsaPrecomputedPublicKey *ppub;
	ecdsaSignature sig;
	const char *msg = "hello";
	mclSize msgSize = strlen(msg);

	ret = ecdsaSecretKeySetByCSPRNG(&sec);
	CYBOZU_TEST_EQUAL(ret, 0);
	serializeTest(sec, ecdsaSecretKeySerialize, ecdsaSecretKeyDeserialize);

	ecdsaGetPublicKey(&pub, &sec);
	serializeTest(pub, ecdsaPublicKeySerialize, ecdsaPublicKeyDeserialize);
	ecdsaSign(&sig, &sec, msg, msgSize);
	serializeTest(sig, ecdsaSignatureSerialize, ecdsaSignatureDeserialize);
	CYBOZU_TEST_ASSERT(ecdsaVerify(&sig, &pub, msg, msgSize));

	ppub = ecdsaPrecomputedPublicKeyCreate();
	CYBOZU_TEST_ASSERT(ppub);
	ret = ecdsaPrecomputedPublicKeyInit(ppub, &pub);
	CYBOZU_TEST_EQUAL(ret, 0);

	CYBOZU_TEST_ASSERT(ecdsaVerifyPrecomputed(&sig, ppub, msg, msgSize));

	sig.d[0]++;
	CYBOZU_TEST_ASSERT(!ecdsaVerify(&sig, &pub, msg, msgSize));
	CYBOZU_TEST_ASSERT(!ecdsaVerifyPrecomputed(&sig, ppub, msg, msgSize));

	ecdsaPrecomputedPublicKeyDestroy(ppub);
}
