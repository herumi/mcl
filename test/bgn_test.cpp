#define PUT(x) std::cout << #x << "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/random_generator.hpp>
#include <mcl/bn256.hpp>
#include <mcl/bgn.hpp>

cybozu::RandomGenerator rg;

typedef mcl::bgn::BGNT<mcl::bn256::BN, mcl::bn256::Fr> BGN;
typedef BGN::SecretKey SecretKey;
typedef BGN::PublicKey PublicKey;
typedef BGN::CipherText CipherText;

using namespace mcl::bgn;

CYBOZU_TEST_AUTO(logG)
{
	BGN::init();
	using namespace mcl::bn256;
	G1 P;
	BN::hashAndMapToG1(P, "abc");
	for (int i = -5; i < 5; i++) {
		G1 iP;
		G1::mul(iP, P, i);
		CYBOZU_TEST_EQUAL(mcl::bgn::local::logG(P, iP), i);
	}
}

CYBOZU_TEST_AUTO(enc_dec)
{
	SecretKey sec;
	sec.setRand(rg);
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherText c;
	for (int i = -5; i < 5; i++) {
		pub.enc(c, i, rg);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
		pub.rerandomize(c, rg);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
	}
}

CYBOZU_TEST_AUTO(add_mul)
{
	SecretKey sec;
	sec.setRand(rg);
	PublicKey pub;
	sec.getPublicKey(pub);
	for (int m1 = -5; m1 < 5; m1++) {
		for (int m2 = -5; m2 < 5; m2++) {
			CipherText c1, c2, c3;
			pub.enc(c1, m1, rg);
			pub.enc(c2, m2, rg);
			CipherText::add(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));
			pub.rerandomize(c3, rg);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));
			CipherText::mul(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));
			pub.rerandomize(c3, rg);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));
		}
	}
}

CYBOZU_TEST_AUTO(add_mul_add)
{
	SecretKey sec;
	sec.setRand(rg);
	PublicKey pub;
	sec.getPublicKey(pub);
	int m[8] = { 1, -2, 3, 4, -5, 6, -7, 8 };
	CipherText c[8];
	for (int i = 0; i < 8; i++) {
		pub.enc(c[i], m[i], rg);
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
}
