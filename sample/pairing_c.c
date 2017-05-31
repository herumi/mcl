#define BN256_DEFINE_STRUCT
#define BN_MAX_FP_UNIT_SIZE 4
#include <mcl/bn.h>
#include <stdio.h>

int g_err = 0;
#define ASSERT(x) { if (!(x)) { printf("err %s:%d\n", __FILE__, __LINE__); g_err++; } }

int main()
{
	char buf[1024];
	const char *aStr = "1234567788234243234234";
	const char *bStr = "239482098243";
	BN256_init();
	BN256_Fr a, b, ab;
	BN256_G1 P, aP;
	BN256_G2 Q, bQ;
	BN256_GT e, e1, e2;
	BN256_Fr_setStr(&a, aStr);
	BN256_Fr_setStr(&b, bStr);
	BN256_Fr_mul(&ab, &a, &b);
	BN256_Fr_getStr(buf, sizeof(buf), &ab);
	printf("%s x %s = %s\n", aStr, bStr, buf);

	ASSERT(!BN256_G1_setStr(&P, "1 -1 1")); // "1 <x> <y>"
	ASSERT(!BN256_G2_hashAndMapTo(&Q, "1"));
	BN256_G1_getStr(buf, sizeof(buf), &P);
	printf("P = %s\n", buf);
	BN256_G2_getStr(buf, sizeof(buf), &Q);
	printf("Q = %s\n", buf);

	BN256_G1_mul(&aP, &P, &a);
	BN256_G2_mul(&bQ, &Q, &b);

	BN256_pairing(&e, &P, &Q);
	BN256_GT_getStr(buf, sizeof(buf), &e);
	printf("e = %s\n", buf);
	BN256_GT_pow(&e1, &e, &a);
	BN256_pairing(&e2, &aP, &Q);
	ASSERT(BN256_GT_isEqual(&e1, &e2));

	BN256_GT_pow(&e1, &e, &b);
	BN256_pairing(&e2, &P, &bQ);
	ASSERT(BN256_GT_isEqual(&e1, &e2));
	ASSERT(BN256_setErrFile("") == 0);
	if (g_err) {
		printf("err %d\n", g_err);
		return 1;
	} else {
		printf("no err\n");
		return 0;
	}
}
