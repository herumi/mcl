#define PUT(x) std::cout << #x << "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <time.h>
#include <mcl/she.hpp>

using namespace mcl::she;
using namespace mcl::bn_current;

SecretKey g_sec;

CYBOZU_TEST_AUTO(log)
{
#if MCLBN_FP_UNIT_SIZE == 4
	const mcl::bn::CurveParam& cp = mcl::bn::CurveFp254BNb;
	puts("CurveFp254BNb");
#elif MCLBN_FP_UNIT_SIZE == 6
	const mcl::bn::CurveParam& cp = mcl::bn::CurveFp382_1;
	puts("CurveFp382_1");
#elif MCLBN_FP_UNIT_SIZE == 8
	const mcl::bn::CurveParam& cp = mcl::bn::CurveFp462;
	puts("CurveFp462");
#endif
	SHE::init(cp);
	G1 P;
	BN::hashAndMapToG1(P, "abc");
	for (int i = -5; i < 5; i++) {
		G1 iP;
		G1::mul(iP, P, i);
		CYBOZU_TEST_EQUAL(mcl::she::local::log(P, iP), i);
	}
}

CYBOZU_TEST_AUTO(HashTable)
{
	mcl::she::local::HashTable<G1> hashTbl;
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
	mcl::she::local::HashTable<GT, false> hashTbl;
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
	SHE::setRangeForDLP(1024);
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherText c;
	for (int i = -5; i < 5; i++) {
		pub.enc(c, i);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
		pub.reRand(c);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
	}
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	CipherTextG1 c1;
	CipherTextG1 c2;
	CipherTextGT ct1, ct2;
	for (int i = -5; i < 5; i++) {
		pub.enc(ct1, i);
		CYBOZU_TEST_EQUAL(sec.dec(ct1), i);
		ppub.enc(ct2, i);
		CYBOZU_TEST_EQUAL(sec.dec(ct2), i);
		ppub.enc(c1, i);
		CYBOZU_TEST_EQUAL(sec.dec(c1), i);
		ppub.enc(c2, i);
		CYBOZU_TEST_EQUAL(sec.dec(c2), i);
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

			pub.reRand(c3);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));

			CipherText::sub(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 - m2, sec.dec(c3));

			CipherText::mul(c3, c1, 5);
			CYBOZU_TEST_EQUAL(m1 * 5, sec.dec(c3));
			CipherText::mul(c3, c1, -123);
			CYBOZU_TEST_EQUAL(m1 * -123, sec.dec(c3));

			CipherText::mul(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			pub.reRand(c3);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			CipherText::mul(c3, c3, -25);
			CYBOZU_TEST_EQUAL(m1 * m2 * -25, sec.dec(c3));

			pub.enc(c1, m1, true);
			CYBOZU_TEST_EQUAL(m1, sec.dec(c1));
			pub.enc(c2, m2, true);
			CipherText::add(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));
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
		pub.convertToCipherTextGT(mc, c[i]);
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
	SHE::setRangeForDLP(100, 2);
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
		CipherTextGT ct;
		CipherTextGT::mul(ct, g1, g2);
		m = sec.dec(testIo(ct));
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

CYBOZU_TEST_AUTO(saveHash)
{
	mcl::she::local::HashTable<SHE::G1> hashTbl1, hashTbl2;
	hashTbl1.init(SHE::P_, 1234, 123);
	std::stringstream ss;
	hashTbl1.save(ss);
	hashTbl2.load(ss);
	CYBOZU_TEST_ASSERT(hashTbl1 == hashTbl2);
}

static inline void putK(double t) { printf("%.2e\n", t * 1e-3); }

template<class CT>
void decBench(const char *msg, int C, const SecretKey& sec, const PublicKey& pub)
{
	int64_t begin = 1 << 20;
	int64_t end = 1LL << 32;
	while (begin < end) {
		CT c;
		int64_t x = begin - 1;
		pub.enc(c, x);
		printf("m=%08x ", (uint32_t)x);
		CYBOZU_BENCH_C(msg, C, sec.dec, c);
		CYBOZU_TEST_EQUAL(sec.dec(c), x);
		begin *= 2;
	}
	int64_t mTbl[] = { -0x80000003ll, 0x80000000ll, 0x80000005ll };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(mTbl); i++) {
		int64_t m = mTbl[i];
		CT c;
		pub.enc(c, m);
		CYBOZU_TEST_EQUAL(sec.dec(c), m);
	}
}

CYBOZU_TEST_AUTO(hashBench)
{
	SecretKey& sec = g_sec;
	sec.setByCSPRNG();
	const int C = 500;
	const size_t hashSize = 1u << 21;

	clock_t begin = clock(), end;
	SHE::setRangeForG1DLP(hashSize, 1024);
	end = clock();
	printf("init G1 DLP %f\n", double(end - begin) / CLOCKS_PER_SEC);
	begin = end;
	SHE::setRangeForG2DLP(hashSize, 1024);
	end = clock();
	printf("init G2 DLP %f\n", double(end - begin) / CLOCKS_PER_SEC);
	begin = end;
	SHE::setRangeForGTDLP(hashSize, 1024);
	end = clock();
	printf("init GT DLP %f\n", double(end - begin) / CLOCKS_PER_SEC);

	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	puts("Kclk");
	cybozu::bench::setPutCallback(putK);
	decBench<CipherTextG1>("decG1", C, sec, pub);
	puts("");
	decBench<CipherTextG2>("decG2", C, sec, pub);
	puts("");
	decBench<CipherTextGT>("decGT", C, sec, pub);

	G1 P, P2;
	G2 Q, Q2;
	GT e, e2;
	mpz_class mr;
	{
		Fr r;
		r.setRand(mcl::she::local::g_rg);
		mr = r.getMpz();
	}
	BN::hashAndMapToG1(P, "abc");
	BN::hashAndMapToG2(Q, "abc");
	BN::pairing(e, P, Q);
	P2.clear();
	Q2.clear();
	e2 = 1;

	printf("large m\n");
	CYBOZU_BENCH_C("G1::add ", C, G1::add, P2, P2, P);
	CYBOZU_BENCH_C("G1::mul ", C, G1::mul, P, P, mr);
	CYBOZU_BENCH_C("G2::add ", C, G2::add, Q2, Q2, Q);
	CYBOZU_BENCH_C("G2::mul ", C, G2::mul, Q, Q, mr);
	CYBOZU_BENCH_C("GT::mul ", C, GT::mul, e2, e2, e);
	CYBOZU_BENCH_C("GT::pow ", C, GT::pow, e, e, mr);
	CYBOZU_BENCH_C("G1window", C, SHE::PhashTbl_.mulByWindowMethod, P2, mr);
	CYBOZU_BENCH_C("G2window", C, SHE::QhashTbl_.mulByWindowMethod, Q2, mr);
	CYBOZU_BENCH_C("GTwindow", C, SHE::ePQhashTbl_.mulByWindowMethod, e, mr);
#if 1
	typedef mcl::GroupMtoA<Fp12> AG;
	mcl::fp::WindowMethod<AG> wm;
	wm.init(static_cast<AG&>(e), Fr::getBitSize(), 10);
	for (int i = 0; i < 100; i++) {
		GT t1, t2;
		GT::pow(t1, e, i);
		wm.mul(static_cast<AG&>(t2), i);
		CYBOZU_TEST_EQUAL(t1, t2);
	}
//	CYBOZU_BENCH_C("GTwindow", C, wm.mul, static_cast<AG&>(e), mr);
#endif

	CYBOZU_BENCH_C("miller  ", C, BN::millerLoop, e, P, Q);
	CYBOZU_BENCH_C("finalExp", C, BN::finalExp, e, e);
	CYBOZU_BENCH_C("precomML", C, BN::precomputedMillerLoop, e, P, SHE::Qcoeff_);

	CipherTextG1 c1;
	CipherTextG2 c2;
	CipherTextGT ct;

	int m = int(hashSize - 1);
	printf("small m = %d\n", m);
	CYBOZU_BENCH_C("G1::mul ", C, G1::mul, P, P, m);
	CYBOZU_BENCH_C("G2::mul ", C, G2::mul, Q, Q, m);
	CYBOZU_BENCH_C("GT::pow ", C, GT::pow, e, e, m);
	CYBOZU_BENCH_C("G1window", C, SHE::PhashTbl_.mulByWindowMethod, P2, m);
	CYBOZU_BENCH_C("G2window", C, SHE::QhashTbl_.mulByWindowMethod, Q2, m);
	CYBOZU_BENCH_C("GTwindow", C, SHE::ePQhashTbl_.mulByWindowMethod, e, m);
//	CYBOZU_BENCH_C("GTwindow", C, wm.mul, static_cast<AG&>(e), m);

	CYBOZU_BENCH_C("encG1   ", C, pub.enc, c1, m);
	CYBOZU_BENCH_C("encG2   ", C, pub.enc, c2, m);
	CYBOZU_BENCH_C("encGT   ", C, pub.enc, ct, m);
	CYBOZU_BENCH_C("encG1pre", C, ppub.enc, c1, m);
	CYBOZU_BENCH_C("encG2pre", C, ppub.enc, c2, m);
	CYBOZU_BENCH_C("encGTpre", C, ppub.enc, ct, m);

	CYBOZU_BENCH_C("decG1   ", C, sec.dec, c1);
	CYBOZU_BENCH_C("decG2   ", C, sec.dec, c2);
	CYBOZU_BENCH_C("degGT   ", C, sec.dec, ct);

	CYBOZU_BENCH_C("mul     ", C, CipherTextGT::mul, ct, c1, c2);

	CYBOZU_BENCH_C("addG1   ", C, CipherTextG1::add, c1, c1, c1);
	CYBOZU_BENCH_C("addG2   ", C, CipherTextG2::add, c2, c2, c2);
	CYBOZU_BENCH_C("addGT   ", C, CipherTextGT::add, ct, ct, ct);
	CYBOZU_BENCH_C("reRandG1", C, pub.reRand, c1);
	CYBOZU_BENCH_C("reRandG2", C, pub.reRand, c2);
	CYBOZU_BENCH_C("reRandGT", C, pub.reRand, ct);
	CYBOZU_BENCH_C("reRandG1pre", C, ppub.reRand, c1);
	CYBOZU_BENCH_C("reRandG2pre", C, ppub.reRand, c2);
	CYBOZU_BENCH_C("reRandGTpre", C, ppub.reRand, ct);
	CYBOZU_BENCH_C("mulG1   ", C, CipherTextG1::mul, c1, c1, m);
	CYBOZU_BENCH_C("mulG2   ", C, CipherTextG2::mul, c2, c2, m);
	CYBOZU_BENCH_C("mulGT   ", C, CipherTextGT::mul, ct, ct, m);
}

