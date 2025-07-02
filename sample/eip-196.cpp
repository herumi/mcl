#include <mcl/bn.h>
#include <stdio.h>
#include <string.h>
/**
	@file
	@brief EIP-196 serialization sample
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

void dump(const char *msg, const void *buf, size_t bufSize)
{
	if (msg) printf("%s ", msg);
	printf("size=%zd ", bufSize);
	const uint8_t *src = (const uint8_t *)buf;
	for (size_t i = 0; i < bufSize; i++) {
		printf("%02x", src[i]);
	}
	printf("\n");
}

static const int g_ioModo = MCLBN_IO_SERIALIZE | MCLBN_IO_BIG_ENDIAN;

bool isAllZero(const char *buf, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (buf[i]) return false;
	}
	return true;
}

// serialize Fp as 32 byte big-endian number.
bool Fp_serialize(char buf[32], const mclBnFp *x)
{
	size_t n = mclBnFp_getStr(buf, 32, x, g_ioModo);
	return n == 32;
}

// deserialize Fp from 32 byte big-endian number.
bool Fp_deserialize(mclBnFp *x, const char buf[32])
{
	int n = mclBnFp_setStr(x, buf, 32, g_ioModo);
	return n == 0;
}

// Serialize P.x|P.y.
// Set _buf to all zeros if P == 0.
bool G1_serialize(char buf[64], mclBnG1 *P)
{
	if (mclBnG1_isZero(P)) {
		memset(buf, 0, 64);
		return true;
	}
	mclBnG1_normalize(P, P);
	return Fp_serialize(buf, &P->x) && Fp_serialize(buf + 32, &P->y);
}

bool G1_deserialize(mclBnG1 *P, const char buf[64])
{
	const size_t N = 64;
	if (isAllZero(buf, N)) {
		mclBnG1_clear(P);
		return true;
	}
	if (!Fp_deserialize(&P->x, buf) || !Fp_deserialize(&P->y, buf + 32)) {
		return false;
	}
	mclBnFp_setInt32(&P->z, 1);
	return mclBnG1_isValid(P);
}

// x = d[0] + d[1] * i
// serialize d[1]|d[0]
bool Fp2_serialize(char buf[64], const mclBnFp2 *x)
{
	return Fp_serialize(buf, &x->d[1]) && Fp_serialize(buf + 32, &x->d[0]);
}

bool Fp2_deserialize(mclBnFp2 *x, const char buf[64])
{
	return Fp_deserialize(&x->d[1], buf) && Fp_deserialize(&x->d[0], buf + 32);
}

bool G2_serialize(char buf[128], mclBnG2 *P)
{
	if (mclBnG2_isZero(P)) {
		memset(buf, 0, 128);
		return true;
	}
	mclBnG2_normalize(P, P);
	return Fp2_serialize(buf, &P->x) && Fp2_serialize(buf + 64, &P->y);
}

bool G2_deserialize(mclBnG2 *P, const char buf[128])
{
	const size_t N = 128;
	if (isAllZero(buf, N)) {
		mclBnG2_clear(P);
		return true;
	}
	if (!Fp2_deserialize(&P->x, buf) || !Fp2_deserialize(&P->y, buf + 64)) {
		return false;
	}
	mclBnFp_setInt32(&P->z.d[0], 1);
	mclBnFp_clear(&P->z.d[1]);
	return mclBnG2_isValid(P);
}

int main()
{
	char buf[128];
	mclSize n = 0;
	int ret = 0;
	mclBnG1 P1;
	mclBnG2 P2;

	// alt_bn128
	ret = mclBn_init(MCL_BN_SNARK1, MCLBN_COMPILED_TIME_VAR);
	if (ret != 0) {
		printf("err ret=%d\n", ret);
		return 1;
	}
	// verify the order of G1 and G2 when isValid() is called.
	mclBn_verifyOrderG1(1);
	mclBn_verifyOrderG2(1);

	// G1 is defined over Fp
	n = mclBn_getFieldOrder(buf, sizeof(buf));
	if (n == 0) {
		puts("err mclBn_getFieldOrder");
		return 1;
	}
	printf("field order p=%s\n", buf);

	// order of G1/G2
	n = mclBn_getCurveOrder(buf, sizeof(buf));
	if (n == 0) {
		puts("err mclBn_getCurveOrder");
		return 1;
	}
	printf("group order r=%s\n", buf);

	// set P1 = (1, 2)
	{
		const char *P1str = "1 1 2"; // the format is "1 <x> <y>". '1' means affine coordinate. see api.md
		ret = mclBnG1_setStr(&P1, P1str, strlen(P1str), 0);
		if (ret) {
			printf("err mclBnG1_setStr %d\n", ret);
			return 1;
		}
	}
	// test of G1 serialization and deserialization
	{
		if (!G1_serialize(buf, &P1)) {
			puts("err G1_serialize");
			return 1;
		}
		dump("P1", buf, 64);
		mclBnG1 T1;
		mclBnG1_dbl(&T1, &P1);
		if (!G1_serialize(buf, &T1)) {
			puts("err G1_serialize");
			return 1;
		}
		dump("T1", buf, 64);
		mclBnG1 T2;
		if (!G1_deserialize(&T2, buf)) {
			puts("err G1_deserialize");
			return 1;
		}
		if (!mclBnG1_isEqual(&T1, &T2)) {
			puts("err T1 != T2");
			return 1;
		}
	}

	// set P2
	{
		// the format of (x, y) is "1 <x0> <x1 <y0> <y1>" where <x>=<x0> + <x1> * i and <y>=<y0> + <y1> * i.
		const char *P2str = "1 10857046999023057135944570762232829481370756359578518086990519993285655852781 11559732032986387107991004021392285783925812861821192530917403151452391805634 8495653923123431417604973247489272438418190587263600148770280649306958101930 4082367875863433681332203403145435568316851327593401208105741076214120093531";
		ret = mclBnG2_setStr(&P2, P2str, strlen(P2str), 0);
		if (ret) {
			printf("err mclBnG2_setStr %d\n", ret);
			return 1;
		}
	}

	// test of G2 serialization and deserialization
	{
		if (!G2_serialize(buf, &P2)) {
			puts("err G2_serialize");
			return 1;
		}
		dump("P2", buf, 128);
		mclBnG2 T1;
		mclBnG2_normalize(&T1, &P2);
		if (!G2_serialize(buf, &T1)) {
			puts("err G2_serialize");
			return 1;
		}
		dump("T1", buf, 128);
		mclBnG2 T2;
		if (!G2_deserialize(&T2, buf)) {
			puts("err G2_deserialize");
			return 1;
		}
		if (!mclBnG2_isValid(&T2)) {
			puts("err T2 is not valid");
			return 1;
		}
		if (!mclBnG2_isEqual(&T1, &T2)) {
			puts("err T1 != T2");
			return 1;
		}
	}
	return 0;
}
