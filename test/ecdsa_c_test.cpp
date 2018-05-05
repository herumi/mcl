#include <mcl/ecdsa.h>
#include <cybozu/test.hpp>
#include <string.h>

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

	ecdsaGetPublicKey(&pub, &sec);
	ecdsaSign(&sig, &sec, msg, msgSize);
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
