#include <mcl/she.h>
#include <cybozu/test.hpp>

const size_t hashSize = 1 << 10;
const size_t tryNum = 1024;

CYBOZU_TEST_AUTO(init)
{
	int curve;
#if MCLBN_FP_UNIT_SIZE == 4
	curve = mclBn_CurveFp254BNb;
#elif MCLBN_FP_UNIT_SIZE == 6
	curve = mclBn_CurveFp382_1;
#elif MCLBN_FP_UNIT_SIZE == 8
	curve = mclBn_CurveFp462;
#endif
	int ret;
	ret = sheInit(curve, MCLBN_FP_UNIT_SIZE);
	CYBOZU_TEST_EQUAL(ret, 0);
	ret = sheSetRangeForDLP(hashSize, tryNum);
	CYBOZU_TEST_EQUAL(ret, 0);
}

int64_t toInt(const uint32_t m[2])
{
	return m[0] + (int64_t(m[1]) << 32);
}

CYBOZU_TEST_AUTO(encDec)
{
	sheSecretKey sec;
	sheSecretKeySetByCSPRNG(&sec);
	shePublicKey pub;
	sheGetPublicKey(&pub, &sec);

	int64_t m = 123;
	sheCipherTextG1 c1;
	sheCipherTextGT ct;
	sheEncG1(&c1, &pub, m);
	sheEncGT(&ct, &pub, m);

	uint32_t dec[2];
	CYBOZU_TEST_EQUAL(sheDecG1(dec, &sec, &c1), 0);
	CYBOZU_TEST_EQUAL(toInt(dec), m);
	CYBOZU_TEST_EQUAL(sheDecGT(dec, &sec, &ct), 0);
	CYBOZU_TEST_EQUAL(toInt(dec), m);
}

CYBOZU_TEST_AUTO(addMul)
{
	sheSecretKey sec;
	sheSecretKeySetByCSPRNG(&sec);
	shePublicKey pub;
	sheGetPublicKey(&pub, &sec);

	int64_t m1 = 12;
	int64_t m2 = -9;
	sheCipherTextG1 c1;
	sheCipherTextG2 c2;
	sheCipherTextGT ct;
	sheEncG1(&c1, &pub, m1);
	sheEncG2(&c2, &pub, m2);
	sheMul(&ct, &c1, &c2);

	uint32_t dec[2];
	CYBOZU_TEST_EQUAL(sheDecGT(dec, &sec, &ct), 0);
	CYBOZU_TEST_EQUAL(toInt(dec), m1 * m2);
}

CYBOZU_TEST_AUTO(allOp)
{
	sheSecretKey sec;
	sheSecretKeySetByCSPRNG(&sec);
	shePublicKey pub;
	sheGetPublicKey(&pub, &sec);

	int64_t m1 = 12;
	int64_t m2 = -9;
	int64_t m3 = 12;
	int64_t m4 = -9;
	sheCipherTextG1 c11, c12;
	sheCipherTextG2 c21, c22;
	sheCipherTextGT ct;
	sheEncG1(&c11, &pub, m1);
	sheEncG1(&c12, &pub, m2);
	sheSubG1(&c11, &c11, &c12); // m1 - m2
	sheMulG1(&c11, &c11, 4); // 4 * (m1 - m2)

	sheEncG2(&c21, &pub, m3);
	sheEncG2(&c22, &pub, m4);
	sheSubG2(&c21, &c21, &c22); // m3 - m4
	sheMulG2(&c21, &c21, -5); // -5 * (m3 - m4)
	sheMul(&ct, &c11, &c21); // -20 * (m1 - m2) * (m3 - m4)
	sheAddGT(&ct, &ct, &ct); // -40 * (m1 - m2) * (m3 - m4)
	sheMulGT(&ct, &ct, -4); // 160 * (m1 - m2) * (m3 - m4)

	int64_t t = 160 * (m1 - m2) * (m3 - m4);
	uint32_t dec[2];
	CYBOZU_TEST_EQUAL(sheDecGT(dec, &sec, &ct), 0);
	CYBOZU_TEST_EQUAL(toInt(dec), t);
}

CYBOZU_TEST_AUTO(rerand)
{
	sheSecretKey sec;
	sheSecretKeySetByCSPRNG(&sec);
	shePublicKey pub;
	sheGetPublicKey(&pub, &sec);

	int64_t m1 = 12;
	int64_t m2 = -9;
	int64_t m3 = 12;
	sheCipherTextG1 c1;
	sheCipherTextG2 c2;
	sheCipherTextGT ct1, ct2;
	sheEncG1(&c1, &pub, m1);
	sheReRandG1(&c1, &pub);

	sheEncG2(&c2, &pub, m2);
	sheReRandG2(&c2, &pub);

	sheEncGT(&ct1, &pub, m3);
	sheReRandGT(&ct1, &pub);

	sheMul(&ct2, &c1, &c2);
	sheReRandGT(&ct2, &pub);
	sheAddGT(&ct1, &ct1, &ct2);

	uint32_t dec[2];
	CYBOZU_TEST_EQUAL(sheDecGT(dec, &sec, &ct1), 0);
	CYBOZU_TEST_EQUAL(toInt(dec), m1 * m2 + m3);
}

CYBOZU_TEST_AUTO(serialize)
{
	sheSecretKey sec1, sec2;
	sheSecretKeySetByCSPRNG(&sec1);
	shePublicKey pub1, pub2;
	sheGetPublicKey(&pub1, &sec1);

	char buf1[2048], buf2[2048];
	size_t n1, n2;
	size_t r, size;
	const size_t sizeofFr = mclBn_getOpUnitSize() * 8;

	size = sizeofFr * 2;
	n1 = sheSecretKeySerialize(buf1, sizeof(buf1), &sec1);
	CYBOZU_TEST_EQUAL(n1, size);
	r = sheSecretKeyDeserialize(&sec2, buf1, n1);
	CYBOZU_TEST_ASSERT(r == 0);
	n2 = sheSecretKeySerialize(buf2, sizeof(buf2), &sec2);
	CYBOZU_TEST_EQUAL(n2, size);
	CYBOZU_TEST_EQUAL_ARRAY(buf1, buf2, n2);

	size = sizeofFr * 3;
	n1 = shePublicKeySerialize(buf1, sizeof(buf1), &pub1);
	CYBOZU_TEST_EQUAL(n1, size);
	r = shePublicKeyDeserialize(&pub2, buf1, n1);
	CYBOZU_TEST_ASSERT(r == 0);
	n2 = shePublicKeySerialize(buf2, sizeof(buf2), &pub2);
	CYBOZU_TEST_EQUAL(n2, size);
	CYBOZU_TEST_EQUAL_ARRAY(buf1, buf2, n2);

	int m = 123;
	sheCipherTextG1 c11, c12;
	sheCipherTextG2 c21, c22;
	sheCipherTextGT ct1, ct2;
	sheEncG1(&c11, &pub2, m);
	sheEncG2(&c21, &pub2, m);
	sheEncGT(&ct1, &pub2, m);

	size = sizeofFr * 2;
	n1 = sheCipherTextG1Serialize(buf1, sizeof(buf1), &c11);
	CYBOZU_TEST_EQUAL(n1, size);
	r = sheCipherTextG1Deserialize(&c12, buf1, n1);
	CYBOZU_TEST_ASSERT(r == 0);
	n2 = sheCipherTextG1Serialize(buf2, sizeof(buf2), &c12);
	CYBOZU_TEST_EQUAL(n2, size);
	CYBOZU_TEST_EQUAL_ARRAY(buf1, buf2, n2);

	size = sizeofFr * 4;
	n1 = sheCipherTextG2Serialize(buf1, sizeof(buf1), &c21);
	CYBOZU_TEST_EQUAL(n1, size);
	r = sheCipherTextG2Deserialize(&c22, buf1, n1);
	CYBOZU_TEST_ASSERT(r == 0);
	n2 = sheCipherTextG2Serialize(buf2, sizeof(buf2), &c22);
	CYBOZU_TEST_EQUAL(n2, size);
	CYBOZU_TEST_EQUAL_ARRAY(buf1, buf2, n2);

	size = sizeofFr * 12 * 4;
	n1 = sheCipherTextGTSerialize(buf1, sizeof(buf1), &ct1);
	CYBOZU_TEST_EQUAL(n1, size);
	r = sheCipherTextGTDeserialize(&ct2, buf1, n1);
	CYBOZU_TEST_ASSERT(r == 0);
	n2 = sheCipherTextGTSerialize(buf2, sizeof(buf2), &ct2);
	CYBOZU_TEST_EQUAL(n2, size);
	CYBOZU_TEST_EQUAL_ARRAY(buf1, buf2, n2);
}
