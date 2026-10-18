#define PUT(x) std::cout << #x << "=" << (x) << std::endl;
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/xorshift.hpp>
#include <fstream>
#include <time.h>
#include <mcl/she.hpp>
#include <mcl/ecparam.hpp> // for secp192k1

using namespace mcl::she;

SecretKey g_sec;

CYBOZU_TEST_AUTO(log)
{
printf("MCL_FP_BIT=%d MCL_FR_BIT=%d\n", MCL_FP_BIT, MCL_FR_BIT);
#if MCL_FP_BIT == 256
	const mcl::CurveParam& cp = mcl::BN254;
	puts("BN254");
#elif MCL_FP_BIT == 384 && MCL_FR_BIT == 256
	const mcl::CurveParam& cp = mcl::BLS12_381;
	puts("BLS12_381");
#elif MCL_FP_BIT == 384 && MCL_FR_BIT == 384
	const mcl::CurveParam& cp = mcl::BN381_1;
	puts("BN381_1");
#endif
	init(cp);
	G1 P;
	hashAndMapToG1(P, "abc");
	for (int i = -5; i < 5; i++) {
		G1 iP;
		G1::mul(iP, P, i);
		CYBOZU_TEST_EQUAL(mcl::she::local::log(P, iP), i);
	}
}

#ifdef NDEBUG
CYBOZU_TEST_AUTO(window)
{
	const int C = 500;
	G1 P, P2;
	G2 Q, Q2;
	GT e, e2;
	mpz_class mr;
	{
		Fr r;
		r.setRand();
		mr = r.getMpz();
	}
	hashAndMapToG1(P, "abc");
	hashAndMapToG2(Q, "abc");
	pairing(e, P, Q);
	P2.clear();
	Q2.clear();
	e2 = 1;

	printf("large m\n");
	CYBOZU_BENCH_C("G1window", C, SHE::PhashTbl_.mulByWindowMethod, P2, mr);
	CYBOZU_BENCH_C("G2window", C, SHE::QhashTbl_.mulByWindowMethod, Q2, mr);
	CYBOZU_BENCH_C("GTwindow", C, SHE::ePQhashTbl_.mulByWindowMethod, e, mr);
}
#endif

CYBOZU_TEST_AUTO(ZkpSet)
{
//	cybozu::XorShift rg;
//	mcl::fp::RandGen::setRandGen(rg);
	const int mVec[] = { -7, 0, 1, 3, 5, 11, 23 };
	const size_t mSizeMax = CYBOZU_NUM_OF_ARRAY(mVec);
	Fr zkp[mSizeMax * 2];

	SecretKey sec;
	sec.setByCSPRNG();
	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);

	for (size_t mSize = 1; mSize <= mSizeMax; mSize++) {
		CipherTextG1 c;
		pub.encWithZkpSet(c, zkp, mVec[0], mVec, mSize);
		CYBOZU_TEST_ASSERT(pub.verify(c, zkp, mVec, mSize));
		CYBOZU_TEST_ASSERT(!pub.verify(c, zkp, mVec, mSize - 1));
		zkp[0] += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c, zkp, mVec, mSize));

		ppub.encWithZkpSet(c, zkp, mVec[0], mVec, mSize);
		CYBOZU_TEST_ASSERT(ppub.verify(c, zkp, mVec, mSize));
		CYBOZU_TEST_ASSERT(!ppub.verify(c, zkp, mVec, mSize - 1));
		zkp[0] += 1;
		CYBOZU_TEST_ASSERT(!ppub.verify(c, zkp, mVec, mSize));
	}
}

//#define PAPER
#ifdef PAPER
double clk2msec(const cybozu::CpuClock& clk, int n)
{
	const double rate = (1 / 3.4e9) * 1.e3; // 3.4GHz
	return clk.getClock() / (double)clk.getCount() / n * rate;
}

CYBOZU_TEST_AUTO(bench2)
{
#ifndef NDEBUG
	puts("skip bench2 in debug");
	return;
#endif
	puts("msec");
	setTryNum(1 << 16);
	useDecG1ViaGT(true);
	useDecG2ViaGT(true);
#if 0
	setRangeForDLP(1 << 21);
#else
	{
		const char *tblName = "../she-dlp-table/she-dlp-0-20-gt.bin";
		std::ifstream ifs(tblName, std::ios::binary);
		getHashTableGT().load(ifs);
	}
#endif
	SecretKey sec;
	sec.setByCSPRNG();
	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	const int C = 500;
	double t1, t2;
	int64_t m = (1ll << 31) - 12345;
	CipherTextG1 c1, d1;
	CipherTextG2 c2, d2;
	CipherTextGT ct, dt;
	CYBOZU_BENCH_C("", C, ppub.enc, c1, m);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	CYBOZU_TEST_EQUAL(sec.dec(c1), m);

	CYBOZU_BENCH_C("", C, ppub.enc, c2, m);
	t2 = clk2msec(cybozu::bench::g_clk, C);
	CYBOZU_TEST_EQUAL(sec.dec(c2), m);
	printf("Enc G1 %.2e\n", t1);
	printf("Enc G2 %.2e\n", t2);
	printf("Enc L1(G1+G2) %.2e\n", t1 + t2);

	CYBOZU_BENCH_C("", C, ppub.enc, ct, m);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	CYBOZU_TEST_EQUAL(sec.dec(ct), m);
	printf("Enc L2 %.2e\n", t1);

	CYBOZU_BENCH_C("", C, sec.dec, c1);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("Dec L1 %.2e\n", t1);

	CYBOZU_BENCH_C("", C, sec.dec, ct);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("Dec L2 %.2e\n", t1);

	pub.enc(ct, 1234);
	CYBOZU_BENCH_C("", C, sec.dec, ct);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("Dec L2(small) %.2e\n", t1);

	CYBOZU_BENCH_C("", C, add, d1, d1, c1);
	t1 = clk2msec(cybozu::bench::g_clk, C);

	CYBOZU_BENCH_C("", C, add, d2, d2, c2);
	t2 = clk2msec(cybozu::bench::g_clk, C);
	printf("Add G1 %.2e\n", t1);
	printf("Add G2 %.2e\n", t2);
	printf("Add L1(G1+G2) %.2e\n", t1 + t2);

	CYBOZU_BENCH_C("", C, add, dt, dt, ct);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("Add L2 %.2e\n", t1);

	CYBOZU_BENCH_C("", C, mul, ct, c1, c2);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("Mul   %.2e\n", t1);

	CYBOZU_BENCH_C("", C, ppub.reRand, c1);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	CYBOZU_BENCH_C("", C, ppub.reRand, c2);
	t2 = clk2msec(cybozu::bench::g_clk, C);
	printf("ReRand G1 %.2e\n", t1);
	printf("ReRand G2 %.2e\n", t2);
	printf("ReRand L1(G1+G2) %.2e\n", t1 + t2);

	CYBOZU_BENCH_C("", C, ppub.reRand, ct);
	t1 = clk2msec(cybozu::bench::g_clk, C);
	printf("ReRand L2 %.2e\n", t1);
}
#endif

template<class G, class HashTbl>
void GAHashTableTest(int maxSize, int tryNum, const G& P, const HashTbl& hashTbl)
{
	for (int i = -maxSize; i <= maxSize; i++) {
		G xP;
		G::mul(xP, P, i);
		CYBOZU_TEST_EQUAL(hashTbl.basicLog(xP), i);
	}
	for (int i = -maxSize * tryNum; i <= maxSize * tryNum; i++) {
		G xP;
		G::mul(xP, P, i);
		CYBOZU_TEST_EQUAL(hashTbl.log(xP), i);
	}
}

template<class G>
void HashTableTest(const G& P)
{
	mcl::she::local::HashTable<G> hashTbl, hashTbl2;
	const int maxSize = 100;
	const int tryNum = 9;
	hashTbl.init(P, maxSize, tryNum);
	GAHashTableTest(maxSize, tryNum, P, hashTbl);
	std::stringstream ss;
	hashTbl.save(ss);
	hashTbl2.load(ss);
	hashTbl2.setTryNum(tryNum);
	GAHashTableTest(maxSize, tryNum, P, hashTbl2);
}

CYBOZU_TEST_AUTO(HashTable)
{
	G1 P;
	hashAndMapToG1(P, "abc");
	G2 Q;
	hashAndMapToG2(Q, "abc");
	HashTableTest(P);
	HashTableTest(Q);
}

template<class HashTbl>
void GTHashTableTest(int maxSize, int tryNum, const GT& g, const HashTbl& hashTbl)
{
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

CYBOZU_TEST_AUTO(GTHashTable)
{
	mcl::she::local::HashTable<GT, false> hashTbl, hashTbl2;
	GT g;
	{
		G1 P;
		hashAndMapToG1(P, "abc");
		G2 Q;
		hashAndMapToG2(Q, "abc");
		pairing(g, P, Q);
	}
	const int maxSize = 100;
	const int tryNum = 3;
	hashTbl.init(g, maxSize, tryNum);
	GTHashTableTest(maxSize, tryNum, g, hashTbl);
	std::stringstream ss;
	hashTbl.save(ss);
	hashTbl2.load(ss);
	hashTbl2.setTryNum(tryNum);
	GTHashTableTest(maxSize, tryNum, g, hashTbl2);
}

CYBOZU_TEST_AUTO(enc_dec)
{
	SecretKey& sec = g_sec;
	sec.setByCSPRNG();
	setRangeForDLP(1024);
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherText c;
	for (int i = -50; i < 50; i++) {
		pub.enc(c, i);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
		pub.reRand(c);
		CYBOZU_TEST_EQUAL(sec.dec(c), i);
	}
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	CipherTextG1 c1;
	CipherTextG2 c2;
	CipherTextGT ct1, ct2;
	for (int i = -50; i < 50; i++) {
		pub.enc(ct1, i);
		CYBOZU_TEST_EQUAL(sec.dec(ct1), i);
		CYBOZU_TEST_EQUAL(sec.isZero(ct1), i == 0);
		ppub.enc(ct2, i);
		CYBOZU_TEST_EQUAL(sec.dec(ct2), i);
		ppub.enc(c1, i);
		CYBOZU_TEST_EQUAL(sec.dec(c1), i);
		CYBOZU_TEST_EQUAL(sec.decViaGT(c1), i);
		CYBOZU_TEST_EQUAL(sec.isZero(c1), i == 0);
		ct1.clear();
		pub.convert(ct1, c1);
		CYBOZU_TEST_EQUAL(sec.dec(ct1), i);
		ppub.enc(c2, i);
		CYBOZU_TEST_EQUAL(sec.dec(c2), i);
		CYBOZU_TEST_EQUAL(sec.decViaGT(c2), i);
		CYBOZU_TEST_EQUAL(sec.isZero(c2), i == 0);
		ct1.clear();
		pub.convert(ct1, c2);
		CYBOZU_TEST_EQUAL(sec.dec(ct1), i);
		pub.enc(c, i);
		CYBOZU_TEST_EQUAL(sec.isZero(c), i == 0);
	}
}

void normalizeCipher1(const CipherTextG1 *c1, size_t n)
{
	G1 cc;
	for (size_t i = 0; i < n; i++) {
		G1::normalize(cc, c1[i].getS());
		G1::normalize(cc, c1[i].getT());
	}
}

void normalizeCipher2(const CipherTextG1 *c1, size_t n)
{
	CipherTextG1 *cc = (CipherTextG1*)CYBOZU_ALLOCA(sizeof(CipherTextG1) * n);
	for (size_t i = 0; i < n; i++) {
		cc[i] = c1[i];
	}
	normalizeVec(cc, n);
}

CYBOZU_TEST_AUTO(normalizeVec)
{
	const size_t N = 32;
	SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherTextG1 c1[N];
	CipherTextG2 c2[N];
	for (size_t i = 0; i < N; i++) {
		pub.enc(c1[i], i);
		pub.enc(c2[i], i);
		CYBOZU_TEST_ASSERT(!c1[i].getS().z.isOne());
		CYBOZU_TEST_ASSERT(!c1[i].getT().z.isOne());
		CYBOZU_TEST_ASSERT(!c2[i].getS().z.isOne());
		CYBOZU_TEST_ASSERT(!c2[i].getT().z.isOne());
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("normalize one", 100, normalizeCipher1, c1, N);
	CYBOZU_BENCH_C("normalizeVec", 100, normalizeCipher2, c1, N);
#endif
	normalizeVec(c1, N);
	normalizeVec(c2, N);
	for (size_t i = 0; i < N; i++) {
		CYBOZU_TEST_ASSERT(c1[i].getS().z.isOne());
		CYBOZU_TEST_ASSERT(c1[i].getT().z.isOne());
		CYBOZU_TEST_ASSERT(c2[i].getS().z.isOne());
		CYBOZU_TEST_ASSERT(c2[i].getT().z.isOne());
		CYBOZU_TEST_EQUAL(sec.dec(c1[i]), (int)i);
		CYBOZU_TEST_EQUAL(sec.dec(c2[i]), (int)i);
	}
	// G1
	{
		std::string s;
		cybozu::StringOutputStream os(s);
		serializeVecToAffine(os, c1, N);
		CipherTextG1 cc[N];
		cybozu::StringInputStream is(s);
		deserializeVecFromAffine(cc, N, is);
		for (size_t i = 0; i < N; i++) {
			CYBOZU_TEST_EQUAL(sec.dec(cc[i]), (int)i);
		}
	}
	// G2
	{
		std::string s;
		cybozu::StringOutputStream os(s);
		serializeVecToAffine(os, c2, N);
		CipherTextG2 cc[N];
		cybozu::StringInputStream is(s);
		deserializeVecFromAffine(cc, N, is);
		for (size_t i = 0; i < N; i++) {
			CYBOZU_TEST_EQUAL(sec.dec(cc[i]), (int)i);
		}
	}
}

template<class CT, class PK>
void ZkpBinTest(const SecretKey& sec, const PK& pub)
{
	CT c;
	ZkpBin zkp;
	for (int m = 0; m < 2; m++) {
		pub.encWithZkpBin(c, zkp, m);
		CYBOZU_TEST_EQUAL(sec.dec(c), m);
		CYBOZU_TEST_ASSERT(pub.verify(c, zkp));
		zkp.d_[0] += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c, zkp));
	}
	CYBOZU_TEST_EXCEPTION(pub.encWithZkpBin(c, zkp, 2), cybozu::Exception);
}
CYBOZU_TEST_AUTO(ZkpBin)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	ZkpBinTest<CipherTextG1>(sec, pub);
	ZkpBinTest<CipherTextG2>(sec, pub);

	PrecomputedPublicKey ppub;
	ppub.init(pub);
	ZkpBinTest<CipherTextG1>(sec, ppub);
	ZkpBinTest<CipherTextG2>(sec, ppub);
}

template<class PubT>
void ZkpEqTest(const SecretKey& sec, const PubT& pub)
{
	CipherTextG1 c1;
	CipherTextG2 c2;
	ZkpEq zkp;
	for (int m = -50; m < 50; m++) {
		pub.encWithZkpEq(c1, c2, zkp, m);
		CYBOZU_TEST_EQUAL(sec.dec(c1), m);
		CYBOZU_TEST_EQUAL(sec.dec(c2), m);
		CYBOZU_TEST_ASSERT(pub.verify(c1, c2, zkp));
		zkp.d_[0] += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c1, c2, zkp));
	}
}

CYBOZU_TEST_AUTO(ZkpEq)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	ZkpEqTest(sec, pub);
	ZkpEqTest(sec, ppub);
}

template<class PK>
void ZkpBinEqTest(const SecretKey& sec, const PK& pub)
{
	CipherTextG1 c1;
	CipherTextG2 c2;
	ZkpBinEq zkp;
	for (int m = 0; m < 2; m++) {
		pub.encWithZkpBinEq(c1, c2, zkp, m);
		CYBOZU_TEST_EQUAL(sec.dec(c1), m);
		CYBOZU_TEST_EQUAL(sec.dec(c2), m);
		CYBOZU_TEST_ASSERT(pub.verify(c1, c2, zkp));
		zkp.d_[0] += 1;
		CYBOZU_TEST_ASSERT(!pub.verify(c1, c2, zkp));
	}
	CYBOZU_TEST_EXCEPTION(pub.encWithZkpBinEq(c1, c2, zkp, 2), cybozu::Exception);
}

CYBOZU_TEST_AUTO(ZkpBinEq)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	ZkpBinEqTest(sec, pub);

	PrecomputedPublicKey ppub;
	ppub.init(pub);
	ZkpBinEqTest(sec, ppub);
}

CYBOZU_TEST_AUTO(ZkpDecG1)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	CipherTextG1 c;
	int m = 123;
	pub.enc(c, m);
	ZkpDec zkp;
	CYBOZU_TEST_EQUAL(sec.decWithZkpDec(zkp, c, pub), m);
	CYBOZU_TEST_ASSERT(pub.verify(c, m, zkp));
	CYBOZU_TEST_ASSERT(!pub.verify(c, m + 1, zkp));
	CipherTextG1 c2;
	pub.enc(c2, m);
	CYBOZU_TEST_ASSERT(!pub.verify(c2, m, zkp));
	zkp.d_[0] += 1;
	CYBOZU_TEST_ASSERT(!pub.verify(c, m, zkp));
}

CYBOZU_TEST_AUTO(ZkpDecGT)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	AuxiliaryForZkpDecGT aux;
	pub.getAuxiliaryForZkpDecGT(aux);
	CipherTextGT c;
	int m = 123;
	pub.enc(c, m);
	ZkpDecGT zkp;
	CYBOZU_TEST_EQUAL(sec.decWithZkpDec(zkp, c, aux), m);
	CYBOZU_TEST_ASSERT(aux.verify(c, m, zkp));
	CYBOZU_TEST_ASSERT(!aux.verify(c, m + 1, zkp));
	CipherTextGT c2;
	pub.enc(c2, m);
	CYBOZU_TEST_ASSERT(!aux.verify(c2, m, zkp));
	zkp.d_[0] += 1;
	CYBOZU_TEST_ASSERT(!aux.verify(c, m, zkp));
}

/*
	regression test which fixes the byte sequences of the ZKPs
	A deterministic RNG is injected so that the ciphertexts and the proofs are reproducible.
	The digests must not change by refactoring the prover/verifier.
*/
struct SplitMix64 {
	uint64_t s_;
	explicit SplitMix64(uint64_t seed) : s_(seed) {}
	uint64_t next()
	{
		uint64_t z = (s_ += 0x9e3779b97f4a7c15ull);
		z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ull;
		z = (z ^ (z >> 27)) * 0x94d049bb133111ebull;
		return z ^ (z >> 31);
	}
	static uint32_t read(void *self, void *buf, uint32_t n)
	{
		SplitMix64& rg = *reinterpret_cast<SplitMix64*>(self);
		uint8_t *p = reinterpret_cast<uint8_t*>(buf);
		uint64_t v = 0;
		for (uint32_t i = 0; i < n; i++) {
			if ((i % 8) == 0) v = rg.next();
			p[i] = uint8_t(v >> (8 * (i % 8)));
		}
		return n;
	}
};

struct ZkpDigest {
	cybozu::Sha256 h_;
	template<class T>
	ZkpDigest& operator<<(const T& x)
	{
		const std::string s = x.serializeToHexStr();
		h_.update(s.c_str(), s.size());
		return *this;
	}
	std::string get()
	{
		uint8_t md[32];
		h_.digest(md, sizeof(md), 0, 0);
		std::string s;
		for (size_t i = 0; i < sizeof(md); i++) {
			char buf[3];
			snprintf(buf, sizeof(buf), "%02x", md[i]);
			s += buf;
		}
		return s;
	}
};

CYBOZU_TEST_AUTO(zkpVector)
{
#if MCL_FP_BIT == 256
	const char *const expected[] = {
		"c364b78b708a6ce4f922f68d8d48d3cb408ec11d715857e934ce8eb14059d7e1",
		"9cd4171b01138dbb71f161b63e1f6ebbe90f3279eadc115f83b34d2c2fb254db",
		"13741b959ac5f0d645b0b6416dcdd18481bb60e7af837c433a2ad889cb6a742e",
		"ebb95ad0de4b72313aba74b0da38053c3f638618e5167814e4c61f620c40ebfa",
		"b9f93c334e0d6ef57b0d9b31e7d4dea04147fc8e26b97bbaa870cf7559ac90e4",
		"cdcbdf1b6ca732162ea79027cd961b4dd4a6ffcb4e12fed9be9776b2834b5768",
		"e6adfed1120423933e3231bf337bd267a4d3c3e8c52e68afb95b63a8e7af36ae",
		"6e9a8d36a3eba71323dfe63180cfd01c2604f3960d394ec4f14537037492c5c5",
		"1fc0017e57a3a3b11dd201ab0e32c70a400a87e4bd42c6c588dcc03a2cc4e607",
		"296326e3c1c4088753c1fc34617937741a1888f288c11a31953fee26740c89ba",
		"466488da9d503e14f7003663ba08a97d1166f434c7286f4265535709a0886988",
		"9f0c0cfc145ad49e17bb992e90c2debbfe4bebb006d61e422fe0b7c9703dd02b",
		"0bc99e2bc91e730597a1c8e6fee837b6af8484a14d8c0b8317acc0f44882654b",
		"2321f2702512cdc5485221162c3f4e022dc491fa17f0aa0f703e66b2d527de72",
		"361109e1bf591c47f0e8cd5e8918522e91f4040861eedd3fd0f487ec12f6cc62",
		"ce93559dea5f4c77efd948897ef1b7e3ac8d5338d999641c5a44df272f83f9ee",
		"325af796070d145b286c92a651e8c95a3673b1bb920085a81cdb3d6599e41d17",
	};
#elif MCL_FP_BIT == 384 && MCL_FR_BIT == 256
	const char *const expected[] = {
		"44a292dc20d2fc656780acb1a3a0b969a9ed32cd474d2a4e2baf6463a948cf02",
		"ecab89397e7f74c338b0fff9fec5d9e6dbe904a5a9cf6f21a009a5a14459294f",
		"d37b8c42062a351dd801a595f6893561996cfd22908b73f72a2e0431deecbc0f",
		"04318d9ab828cadbfcdd17a87310e811a229b33e1c0f307221e6b2e4a9495fbd",
		"9f6336af915693623cb94b6f7d962557c45152782e98babd9e018501ab70b5b8",
		"d3be3952d54b093ede1251392bf96f80282bf4ea6a4f575d71def996313e9512",
		"83dd07cb437608ea80163054df3b27c21bcf2af99bec76777aeb061d7dbec835",
		"5d6c1013f6947dd6f38daad8a12d707cff26778bc185072c064db617419ac594",
		"34ab06584e5c3b2de0c92d1bfa31460801f267dccc6e4ba25921ffc300b3c6af",
		"5567bc8b2b83314371e297d40f18405ade0b371e93f34605f86849f2fe3492a2",
		"917b58bc067c1ee19b300ba1090e77ecb0639c8626c42cc2f76bb30d2adb273b",
		"2ecd46772884d739103fbc6061489d2f6e454d8d0299d0fad154ceef7f99033a",
		"b15198dc0b461a3902c66af07ca931369394f40081f229e5165ad7d99ae1f9bf",
		"73c804fa9eff596c618b820bd7c0f083e318ddbe19d35c32303fb4b67787ba7c",
		"05fffb39d5816d48aa2d306cd826f415ef55aa14994c65398177a267c509d096",
		"a2901330e4e4954ec1252d33b0aa27335617a99b12635bc89957f8816f5561a2",
		"32651a592cbbc61c80551a4f55dbe057dca5114c47288363868d7dd10e6402de",
	};
#else
	const char *const expected[] = { 0 };
#endif
	const size_t expectedN = sizeof(expected) / sizeof(expected[0]);
	std::vector<std::string> digests;

	SplitMix64 rg(0);
	mcl::fp::RandGen::setRandFunc(&rg, SplitMix64::read);
	uint64_t seed = 1;
	// reseed before each case so that the cases are independent of each other
#define ZKP_VEC_RESEED() rg = SplitMix64(seed++)

	ZKP_VEC_RESEED();
	SecretKey sec;
	sec.setByCSPRNG();
	{
		ZkpDigest dg;
		dg << sec;
		digests.push_back(dg.get());
	}
	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	AuxiliaryForZkpDecGT aux;
	pub.getAuxiliaryForZkpDecGT(aux);

	for (int ppubFlag = 0; ppubFlag < 2; ppubFlag++) {
		for (int m = 0; m < 2; m++) {
			ZKP_VEC_RESEED();
			CipherTextG1 c;
			ZkpBin zkp;
			if (ppubFlag) ppub.encWithZkpBin(c, zkp, m); else pub.encWithZkpBin(c, zkp, m);
			CYBOZU_TEST_EQUAL(sec.dec(c), m);
			CYBOZU_TEST_ASSERT(pub.verify(c, zkp));
			CYBOZU_TEST_ASSERT(ppub.verify(c, zkp));
			ZkpDigest dg;
			dg << c << zkp;
			digests.push_back(dg.get());
		}
		for (int m = 0; m < 2; m++) {
			ZKP_VEC_RESEED();
			CipherTextG2 c;
			ZkpBin zkp;
			if (ppubFlag) ppub.encWithZkpBin(c, zkp, m); else pub.encWithZkpBin(c, zkp, m);
			CYBOZU_TEST_EQUAL(sec.dec(c), m);
			CYBOZU_TEST_ASSERT(pub.verify(c, zkp));
			CYBOZU_TEST_ASSERT(ppub.verify(c, zkp));
			ZkpDigest dg;
			dg << c << zkp;
			digests.push_back(dg.get());
		}
		{
			ZKP_VEC_RESEED();
			CipherTextG1 c1;
			CipherTextG2 c2;
			ZkpEq zkp;
			const int m = -37;
			if (ppubFlag) ppub.encWithZkpEq(c1, c2, zkp, m); else pub.encWithZkpEq(c1, c2, zkp, m);
			CYBOZU_TEST_EQUAL(sec.dec(c1), m);
			CYBOZU_TEST_EQUAL(sec.dec(c2), m);
			CYBOZU_TEST_ASSERT(pub.verify(c1, c2, zkp));
			CYBOZU_TEST_ASSERT(ppub.verify(c1, c2, zkp));
			ZkpDigest dg;
			dg << c1 << c2 << zkp;
			digests.push_back(dg.get());
		}
		for (int m = 0; m < 2; m++) {
			ZKP_VEC_RESEED();
			CipherTextG1 c1;
			CipherTextG2 c2;
			ZkpBinEq zkp;
			if (ppubFlag) ppub.encWithZkpBinEq(c1, c2, zkp, m); else pub.encWithZkpBinEq(c1, c2, zkp, m);
			CYBOZU_TEST_EQUAL(sec.dec(c1), m);
			CYBOZU_TEST_EQUAL(sec.dec(c2), m);
			CYBOZU_TEST_ASSERT(pub.verify(c1, c2, zkp));
			CYBOZU_TEST_ASSERT(ppub.verify(c1, c2, zkp));
			ZkpDigest dg;
			dg << c1 << c2 << zkp;
			digests.push_back(dg.get());
		}
	}
	{
		ZKP_VEC_RESEED();
		CipherTextG1 c;
		const int m = 123;
		pub.enc(c, m);
		ZkpDec zkp;
		CYBOZU_TEST_EQUAL(sec.decWithZkpDec(zkp, c, pub), m);
		CYBOZU_TEST_ASSERT(pub.verify(c, m, zkp));
		ZkpDigest dg;
		dg << c << zkp;
		digests.push_back(dg.get());
	}
	{
		ZKP_VEC_RESEED();
		CipherTextGT c;
		const int m = 123;
		pub.enc(c, m);
		ZkpDecGT zkp;
		CYBOZU_TEST_EQUAL(sec.decWithZkpDec(zkp, c, aux), m);
		CYBOZU_TEST_ASSERT(aux.verify(c, m, zkp));
		ZkpDigest dg;
		dg << c << zkp;
		digests.push_back(dg.get());
	}
#undef ZKP_VEC_RESEED
	mcl::fp::RandGen::setRandFunc(0, 0);

	if (expectedN == 0 || expected[0] == 0) {
		// no vectors for this curve: print them to be pasted
		for (size_t i = 0; i < digests.size(); i++) {
			printf("\t\t\"%s\",\n", digests[i].c_str());
		}
		return;
	}
	CYBOZU_TEST_EQUAL(digests.size(), expectedN);
	for (size_t i = 0; i < digests.size() && i < expectedN; i++) {
		CYBOZU_TEST_EQUAL(digests[i], expected[i]);
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
			add(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));

			pub.reRand(c3);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));

			sub(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 - m2, sec.dec(c3));

			mul(c3, c1, 5);
			CYBOZU_TEST_EQUAL(m1 * 5, sec.dec(c3));
			mul(c3, c1, -123);
			CYBOZU_TEST_EQUAL(m1 * -123, sec.dec(c3));

			mul(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			pub.reRand(c3);
			CYBOZU_TEST_EQUAL(m1 * m2, sec.dec(c3));

			CipherText::mul(c3, c3, -25);
			CYBOZU_TEST_EQUAL(m1 * m2 * -25, sec.dec(c3));

			pub.enc(c1, m1, true);
			CYBOZU_TEST_EQUAL(m1, sec.dec(c1));
			pub.enc(c2, m2, true);
			add(c3, c1, c2);
			CYBOZU_TEST_EQUAL(m1 + m2, sec.dec(c3));
		}
	}
}

CYBOZU_TEST_AUTO(largeEnc)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);

	Fr x;
	x.setRand();
	CipherTextG1 c1, c2;
	pub.enc(c1, x);
	const int64_t m = 123;
	pub.enc(c2, x + m);
	sub(c1, c1, c2);
	CYBOZU_TEST_EQUAL(sec.dec(c1), -m);

	pub.enc(c1, 0);
	mul(c1, c1, x);
	CYBOZU_TEST_ASSERT(sec.isZero(c1));
	pub.enc(c1, 1);
	mul(c1, c1, x);
	CYBOZU_TEST_ASSERT(!sec.isZero(c1));
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
		pub.convert(mc, c[i]);
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

CYBOZU_TEST_AUTO(finalExp)
{
	const SecretKey& sec = g_sec;
	PublicKey pub;
	sec.getPublicKey(pub);
	const int64_t m11 = 5;
	const int64_t m12 = 3;
	const int64_t m21 = -2;
	const int64_t m22 = 9;
	CipherTextG1 c11, c12;
	CipherTextG2 c21, c22;
	CipherTextGT ct1, ct2, ct;
	pub.enc(c11, m11);
	pub.enc(c12, m12);
	pub.enc(c21, m21);
	pub.enc(c22, m22);
	CipherTextGT::mulML(ct1, c11, c21);
	CipherTextGT::finalExp(ct, ct1);
	CYBOZU_TEST_EQUAL(sec.dec(ct), m11 * m21);
	CipherTextGT::mulML(ct2, c12, c22);
	CipherTextGT::finalExp(ct, ct2);
	CYBOZU_TEST_EQUAL(sec.dec(ct), m12 * m22);
	CipherTextGT::add(ct1, ct1, ct2);
	CipherTextGT::finalExp(ct1, ct1);
	CYBOZU_TEST_EQUAL(sec.dec(ct1), (m11 * m21) + (m12 * m22));
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
	setRangeForDLP(100);
	int64_t m;
	for (int i = 0; i < 2; i++) {
		if (i == 1) {
			Fp::setIoMode(mcl::IoSerialize);
			G1::setIoMode(mcl::IoSerialize);
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

#if !defined(PAPER) && defined(NDEBUG)
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
#endif

CYBOZU_TEST_AUTO(saveHash)
{
	mcl::she::local::HashTable<G1> hashTbl1, hashTbl2;
	hashTbl1.init(SHE::P_, 1234, 123);
	std::stringstream ss;
	hashTbl1.save(ss);
	hashTbl2.load(ss);
	CYBOZU_TEST_ASSERT(hashTbl1 == hashTbl2);
}

template<class CT>
void decBench(const char *msg, int C, const SecretKey& sec, const PublicKey& pub, int64_t (SecretKey::*dec)(const CT& c, bool *pok) const = &SecretKey::dec)
{
	int64_t begin = 1 << 20;
	int64_t end = 1LL << 32;
	while (begin < end) {
		CT c;
		int64_t x = begin - 1;
		pub.enc(c, x);
		printf("m=%08x ", (uint32_t)x);
		CYBOZU_BENCH_C(msg, C, (sec.*dec), c, 0);
		CYBOZU_TEST_EQUAL((sec.*dec)(c, 0), x);
		begin *= 2;
	}
	int64_t mTbl[] = { -0x80000003ll, 0x80000000ll, 0x80000005ll };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(mTbl); i++) {
		int64_t m = mTbl[i];
		CT c;
		pub.enc(c, m);
		CYBOZU_TEST_EQUAL((sec.*dec)(c, 0), m);
	}
}

#if 0 // !defined(PAPER) && defined(NDEBUG)
static inline void putK(double t) { printf("%.2e\n", t * 1e-3); }
CYBOZU_TEST_AUTO(hashBench)
{
	setTryNum(1024);
	SecretKey& sec = g_sec;
	sec.setByCSPRNG();
	const int C = 500;
	const size_t hashSize = 1u << 21;

	clock_t begin = clock(), end;
	setRangeForG1DLP(hashSize);
	end = clock();
	printf("init G1 DLP %f\n", double(end - begin) / CLOCKS_PER_SEC);
	begin = end;
	setRangeForG2DLP(hashSize);
	end = clock();
	printf("init G2 DLP %f\n", double(end - begin) / CLOCKS_PER_SEC);
	begin = end;
	setRangeForGTDLP(hashSize);
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
	puts("");
	decBench<CipherTextG1>("decG1ViaGT", C, sec, pub, &SecretKey::decViaGT);
	puts("");
	decBench<CipherTextG2>("decG2ViaGT", C, sec, pub, &SecretKey::decViaGT);

	G1 P, P2;
	G2 Q, Q2;
	GT e, e2;
	mpz_class mr;
	{
		Fr r;
		r.setRand();
		mr = r.getMpz();
	}
	hashAndMapToG1(P, "abc");
	hashAndMapToG2(Q, "abc");
	pairing(e, P, Q);
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

	CYBOZU_BENCH_C("miller  ", C, millerLoop, e, P, Q);
	CYBOZU_BENCH_C("finalExp", C, finalExp, e, e);
	CYBOZU_BENCH_C("precomML", C, precomputedMillerLoop, e, P, SHE::Qcoeff_);

	CipherTextG1 c1, c11;
	CipherTextG2 c2, c21;
	CipherTextGT ct, ct1;

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

	CYBOZU_BENCH_C("CT:mul  ", C, CipherTextGT::mul, ct, c1, c2);
	CYBOZU_BENCH_C("CT:mulML", C, CipherTextGT::mulML, ct, c1, c2);
	CYBOZU_BENCH_C("CT:finalExp", C, CipherTextGT::finalExp, ct, ct);

	c11 = c1;
	c21 = c2;
	ct1 = ct;
	CYBOZU_BENCH_C("addG1   ", C, CipherTextG1::add, c1, c1, c11);
	CYBOZU_BENCH_C("addG2   ", C, CipherTextG2::add, c2, c2, c21);
	CYBOZU_BENCH_C("addGT   ", C, CipherTextGT::add, ct, ct, ct1);
	CYBOZU_BENCH_C("reRandG1", C, pub.reRand, c1);
	CYBOZU_BENCH_C("reRandG2", C, pub.reRand, c2);
	CYBOZU_BENCH_C("reRandGT", C, pub.reRand, ct);
	CYBOZU_BENCH_C("reRandG1pre", C, ppub.reRand, c1);
	CYBOZU_BENCH_C("reRandG2pre", C, ppub.reRand, c2);
	CYBOZU_BENCH_C("reRandGTpre", C, ppub.reRand, ct);
	CYBOZU_BENCH_C("mulG1   ", C, CipherTextG1::mul, c1, c1, m);
	CYBOZU_BENCH_C("mulG2   ", C, CipherTextG2::mul, c2, c2, m);
	CYBOZU_BENCH_C("mulGT   ", C, CipherTextGT::mul, ct, ct, m);

	CYBOZU_BENCH_C("convG1toGT", C, pub.convert, ct, c1);
	CYBOZU_BENCH_C("convG2toGT", C, pub.convert, ct, c2);
}
#endif

CYBOZU_TEST_AUTO(liftedElGamal)
{
	const size_t hashSize = 1024;
	const mcl::EcParam& param = mcl::ecparam::secp256k1;
	initG1only(param, hashSize);
	const size_t byteSize = (param.bitSize + 7) / 8;
	SecretKey sec;
	sec.setByCSPRNG();
	PublicKey pub;
	sec.getPublicKey(pub);
	PrecomputedPublicKey ppub;
	ppub.init(pub);
	CipherTextG1 c1, c2, c3;
	int m1 = 12, m2 = 34;
	pub.enc(c1, m1);
	pub.enc(c2, m2);
	CYBOZU_TEST_EQUAL(sec.dec(c1), m1);
	CYBOZU_TEST_EQUAL(sec.dec(c2), m2);
	add(c3, c1, c2);
	CYBOZU_TEST_EQUAL(sec.dec(c3), m1 + m2);
	neg(c1, c2);
	CYBOZU_TEST_EQUAL(sec.dec(c1), -m2);
	mul(c1, c2, m1);
	CYBOZU_TEST_EQUAL(sec.dec(c1), m2 * m1);

	char buf[1024];
	size_t n = sec.serialize(buf, sizeof(buf));
	CYBOZU_TEST_EQUAL(n, byteSize);
	SecretKey sec2;
	n = sec2.deserialize(buf, n);
	CYBOZU_TEST_EQUAL(n, byteSize);
	CYBOZU_TEST_EQUAL(sec, sec2);

	n = pub.serialize(buf, sizeof(buf));
	CYBOZU_TEST_EQUAL(n, byteSize + 1); // +1 is for sign of y
	CYBOZU_TEST_EQUAL(n, G1::getSerializedByteSize());
	PublicKey pub2;
	n = pub2.deserialize(buf, n);
	CYBOZU_TEST_EQUAL(n, byteSize + 1);
	CYBOZU_TEST_EQUAL(pub, pub2);

	PublicKey pub3;
	sec2.getPublicKey(pub3);
	CYBOZU_TEST_EQUAL(pub, pub3);
	const int C = 500;
	CYBOZU_BENCH_C("enc", C, pub.enc, c1, 5);
	CYBOZU_BENCH_C("enc", C, ppub.enc, c2, 5);
	CYBOZU_TEST_EQUAL(sec.dec(c1), sec.dec(c2));
	CYBOZU_BENCH_C("add", C, add, c1, c1, c2);
	Fr r;
	r.setByCSPRNG();
	CYBOZU_BENCH_C("mul", C, mul, c1, c1, r);
	CYBOZU_BENCH_C("isZero", C, sec.isZero, c1);
}
