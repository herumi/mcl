#define PUT(x) std::cout << #x << "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <mcl/bgn.hpp>

using namespace mcl::bgn;
using namespace mcl::bn256;

SecretKey g_sec;

CYBOZU_TEST_AUTO(log)
{
	BGN::init();
	G1 P;
	BN::hashAndMapToG1(P, "abc");
	for (int i = -5; i < 5; i++) {
		G1 iP;
		G1::mul(iP, P, i);
		CYBOZU_TEST_EQUAL(mcl::bgn::local::log(P, iP), i);
	}
}

CYBOZU_TEST_AUTO(HashTable)
{
	mcl::bgn::local::HashTable<G1> hashTbl;
	G1 P;
	BN::hashAndMapToG1(P, "abc");
	const int maxSize = 100;
	const int tryNum = 3;
	hashTbl.init(P, maxSize, tryNum);
	for (int i = -maxSize; i <= maxSize; i++) {
		G1 xP;
		G1::mul(xP, P, i);
		CYBOZU_TEST_EQUAL(hashTbl.basicLog(xP), i);
	}
	for (int i = -maxSize * tryNum; i <= maxSize * tryNum; i++) {
		G1 xP;
		G1::mul(xP, P, i);
		CYBOZU_TEST_EQUAL(hashTbl.log(xP), i);
	}
}

CYBOZU_TEST_AUTO(GTHashTable)
{
	mcl::bgn::local::HashTable<GT, false> hashTbl;
	GT g;
	{
		G1 P;
		BN::hashAndMapToG1(P, "abc");
		G2 Q;
		BN::hashAndMapToG2(Q, "abc");
		BN::pairing(g, P, Q);
	}
	const int maxSize = 100;
	const int tryNum = 3;
	hashTbl.init(g, maxSize, tryNum);
	for (int i = -maxSize; i <= maxSize; i++) {
		GT gx;
		GT::pow(gx, g, i);
		CYBOZU_TEST_EQUAL(hashTbl.basicLog(gx), i);
	}
	for (int i = -maxSize * tryNum; i <= maxSize * tryNum; i++) {
		GT gx;
		GT::pow(gx, g, i);
		CYBOZU_TEST_EQUAL(hashTbl.log(gx), i);
	}
}

CYBOZU_TEST_AUTO(enc_dec)
{
	SecretKey& sec = g_sec;
	sec.setByCSPRNG();
	BGN::setRangeForDLP(1024);
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherText c;
	for (int i = -5; i < 5; i++) {
		pub.enc(c, i);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
		pub.rerandomize(c);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
	}
}

CYBOZU_TEST_AUTO(add_sub_mul)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	for (int m1 = -5; m1 < 5; m1++) {
		for (int m2 = -5; m2 < 5; m2++) {
			CipherText c1, c2, c3;
			pub.enc(c1, m1);
			pub.enc(c2, m2);
			CipherText::add(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));

			pub.rerandomize(c3);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));

			CipherText::sub(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 - m2, sec.dec(c3));

			CipherText::mul(c3, c1, 5);
			CYBOZU_TEST_EQUAL(m1 * 5, sec.dec(c3));
			CipherText::mul(c3, c1, -123);
			CYBOZU_TEST_EQUAL(m1 * -123, sec.dec(c3));

			CipherText::mul(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			pub.rerandomize(c3);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			CipherText::mul(c3, c3, -25);
			CYBOZU_TEST_EQUAL(m1 * m2 * -25, sec.dec(c3));
		}
	}
}

CYBOZU_TEST_AUTO(add_mul_add_sub)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	int m[8] = { 1, -2, 3, 4, -5, 6, -7, 8 };
	CipherText c[8];
	for (int i = 0; i < 8; i++) {
		pub.enc(c[i], m[i]);
		CYBOZU_TEST_EQUAL(sec.dec(c[i]), m[i]);
		CYBOZU_TEST_ASSERT(!c[i].isMultiplied());
		CipherText mc;
		pub.convertToCipherTextM(mc, c[i]);
		CYBOZU_TEST_ASSERT(mc.isMultiplied());
		CYBOZU_TEST_EQUAL(sec.dec(mc), m[i]);
	}
	int ok1 = (m[0] + m[1]) * (m[2] + m[3]);
	int ok2 = (m[4] + m[5]) * (m[6] + m[7]);
	int ok = ok1 + ok2;
	for (int i = 0; i < 4; i++) {
		c[i * 2].add(c[i * 2 + 1]);
		CYBOZU_TEST_EQUAL(sec.dec(c[i * 2]), m[i * 2] + m[i * 2 + 1]);
	}
	c[0].mul(c[2]);
	CYBOZU_TEST_EQUAL(sec.dec(c[0]), ok1);
	c[4].mul(c[6]);
	CYBOZU_TEST_EQUAL(sec.dec(c[4]), ok2);
	c[0].add(c[4]);
	CYBOZU_TEST_EQUAL(sec.dec(c[0]), ok);
	c[0].sub(c[4]);
	CYBOZU_TEST_EQUAL(sec.dec(c[0]), ok1);
}

CYBOZU_TEST_AUTO(innerProduct)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);

	cybozu::XorShift rg;
	const size_t n = 1000;
	std::vector<int> v1, v2;
	std::vector<CipherText> c1, c2;
	v1.resize(n);
	v2.resize(n);
	c1.resize(n);
	c2.resize(n);
	int innerProduct = 0;
	for (size_t i = 0; i < n; i++) {
		v1[i] = rg() % 2;
		v2[i] = rg() % 2;
		innerProduct += v1[i] * v2[i];
		pub.enc(c1[i], v1[i]);
		pub.enc(c2[i], v2[i]);
	}
	CipherText c, t;
	CipherText::mul(c, c1[0], c2[0]);
	for (size_t i = 1; i < n; i++) {
		CipherText::mul(t, c1[i], c2[i]);
		c.add(t);
	}
	CYBOZU_TEST_EQUAL(innerProduct, sec.dec(c));
}

template<class T>
T testIo(const T& x)
{
	std::stringstream ss;
	ss << x;
	T y;
	ss >> y;
	CYBOZU_TEST_EQUAL(x, y);
	return y;
}

CYBOZU_TEST_AUTO(io)
{
	BGN::setRangeForDLP(100, 2);
	int m;
	for (int i = 0; i < 2; i++) {
		if (i == 1) {
			Fp::setIoMode(mcl::IoFixedSizeByteSeq);
			G1::setIoMode(mcl::IoFixedSizeByteSeq);
		}
		SecretKey sec;
		sec.setByCSPRNG();
		testIo(sec);
		PublicKey pub;
		sec.getPublicKey(pub);
		testIo(pub);
		CipherTextG1 g1;
		pub.enc(g1, 3);
		m = sec.dec(testIo(g1));
		CYBOZU_TEST_EQUAL(m, 3);
		CipherTextG2 g2;
		pub.enc(g2, 5);
		testIo(g2);
		CipherTextA ca;
		pub.enc(ca, -4);
		m = sec.dec(testIo(ca));
		CYBOZU_TEST_EQUAL(m, -4);
		CipherTextM cm;
		CipherTextM::mul(cm, g1, g2);
		m = sec.dec(testIo(cm));
		CYBOZU_TEST_EQUAL(m, 15);
	}
}

CYBOZU_TEST_AUTO(bench)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherText c1, c2, c3;
	CYBOZU_BENCH("enc", pub.enc, c1, 5);
	pub.enc(c2, 4);
	CYBOZU_BENCH("add", c1.add, c2);
	CYBOZU_BENCH("mul", CipherText::mul, c3, c1, c2);
	pub.enc(c1, 5);
	pub.enc(c2, 4);
	c1.mul(c2);
	CYBOZU_BENCH("dec", sec.dec, c1);
	c2 = c1;
	CYBOZU_BENCH("add after mul", c1.add, c2);
}

CYBOZU_TEST_AUTO(hashBench)
{
	SecretKey& sec = g_sec;
	sec.setByCSPRNG();
	BGN::setRangeForDLP(100, 1000);
	PublicKey pub;
	sec.getPublicKey(pub);
	int x = 100;
	CipherText c1;
	pub.enc(c1, x);
	for (int i = 0; i < 20; i++) {
		int y = i * 10;
		CipherText c2;
		pub.enc(c2, y);
		c2.mul(c1);
		CYBOZU_TEST_EQUAL(sec.dec(c2), x * y);
		printf("i=%2d x * y =%5d ", i, x * y);
		CYBOZU_BENCH("dec", sec.dec, c2);
	}
}
