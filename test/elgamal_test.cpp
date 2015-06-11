#include <cybozu/test.hpp>
#include <mcl/fp.hpp>
#include <mcl/gmp_util.hpp>
#include <mcl/elgamal.hpp>
#include <cybozu/random_generator.hpp>
#if defined(_WIN64) || defined(__x86_64__)
	#define USE_MONT_FP
#endif
#include <mcl/ecparam.hpp>
#include <cybozu/crypto.hpp>

struct TagZn;
typedef mcl::FpT<> Fp;
typedef mcl::FpT<TagZn> Zn;
typedef mcl::EcT<Fp> Ec;
typedef mcl::ElgamalT<Ec, Zn> ElgamalEc;

const mcl::EcParam& para = mcl::ecparam::secp192k1;
cybozu::RandomGenerator rg;

CYBOZU_TEST_AUTO(testEc)
{
	Fp::setModulo(para.p);
	Zn::setModulo(para.n);
	Ec::setParam(para.a, para.b);
	const Fp x0(para.gx);
	const Fp y0(para.gy);
	const size_t bitSize = Zn(-1).getBitSize();
	const Ec P(x0, y0);
	/*
		Zn = <P>
	*/
	ElgamalEc::PrivateKey prv;
	prv.init(P, bitSize, rg);
	const ElgamalEc::PublicKey& pub = prv.getPublicKey();

	const int m1 = 12345;
	const int m2 = 17655;
	ElgamalEc::CipherText c1, c2;
	pub.enc(c1, m1, rg);
	pub.enc(c2, m2, rg);
	Zn dec1, dec2;
	prv.dec(dec1, c1);
	prv.dec(dec2, c2);
	// dec(enc) = id
	CYBOZU_TEST_EQUAL(dec1, m1);
	CYBOZU_TEST_EQUAL(dec2, m2);
	// iostream
	{
		ElgamalEc::PublicKey pub2;
		ElgamalEc::PrivateKey prv2;
		ElgamalEc::CipherText cc1, cc2;
		{
			std::stringstream ss;
			ss << prv;
			ss >> prv2;
		}
		Zn d;
		prv2.dec(d, c1);
		CYBOZU_TEST_EQUAL(d, m1);
		{
			std::stringstream ss;
			ss << c1;
			ss >> cc1;
		}
		d = 0;
		prv2.dec(d, cc1);
		CYBOZU_TEST_EQUAL(d, m1);
		{
			std::stringstream ss;
			ss << pub;
			ss >> pub2;
		}
		pub2.enc(cc2, m2, rg);
		prv.dec(d, cc2);
		CYBOZU_TEST_EQUAL(d, m2);
	}
	// enc(m1) enc(m2) = enc(m1 + m2)
	c1.add(c2);
	prv.dec(dec1, c1);
	CYBOZU_TEST_EQUAL(dec1, m1 + m2);
	// enc(m1) x = enc(m1 + x)
	const int x = 555;
	pub.add(c1, x);
	prv.dec(dec1, c1);
	CYBOZU_TEST_EQUAL(dec1, m1 + m2 + x);
	// rerandomize
	c1 = c2;
	pub.rerandomize(c1, rg);
	// verify c1 != c2
	CYBOZU_TEST_ASSERT(c1.c1 != c2.c1);
	CYBOZU_TEST_ASSERT(c1.c2 != c2.c2);
	prv.dec(dec1, c1);
	// dec(c1) = dec(c2)
	CYBOZU_TEST_EQUAL(dec1, m2);

	// check neg
	{
		ElgamalEc::CipherText c;
		Zn m = 1234;
		pub.enc(c, m, rg);
		c.neg();
		Zn dec;
		prv.dec(dec, c);
		CYBOZU_TEST_EQUAL(dec, -m);
	}
	// check mul
	{
		ElgamalEc::CipherText c;
		Zn m = 123;
		int x = 111;
		pub.enc(c, m, rg);
		Zn dec;
		prv.dec(dec, c);
		c.mul(x);
		prv.dec(dec, c);
		m *= x;
		CYBOZU_TEST_EQUAL(dec, m);
	}

	// check negative value
	for (int i = -10; i < 10; i++) {
		ElgamalEc::CipherText c;
		const Zn mm = i;
		pub.enc(c, mm, rg);
		Zn dec;
		prv.dec(dec, c, 1000);
		CYBOZU_TEST_EQUAL(dec, mm);
	}

	// isZeroMessage
	for (int m = 0; m < 10; m++) {
		ElgamalEc::CipherText c0;
		pub.enc(c0, m, rg);
		if (m == 0) {
			CYBOZU_TEST_ASSERT(prv.isZeroMessage(c0));
		} else {
			CYBOZU_TEST_ASSERT(!prv.isZeroMessage(c0));
		}
	}
	// zkp
	{
		ElgamalEc::Zkp zkp;
		ElgamalEc::CipherText c;
//		cybozu::Sha1 hash;
		cybozu::crypto::Hash hash(cybozu::crypto::Hash::N_SHA256);
		pub.encWithZkp(c, zkp, 0, hash, rg);
		CYBOZU_TEST_ASSERT(pub.verify(c, zkp, hash));
		zkp.s0 += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c, zkp, hash));
		pub.encWithZkp(c, zkp, 1, hash, rg);
		CYBOZU_TEST_ASSERT(pub.verify(c, zkp, hash));
		zkp.s0 += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c, zkp, hash));
		CYBOZU_TEST_EXCEPTION_MESSAGE(pub.encWithZkp(c, zkp, 2, hash, rg), cybozu::Exception, "encWithZkp");
	}
}
