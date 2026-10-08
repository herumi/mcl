#include <mcl/bbs.hpp>
#include <cybozu/test.hpp>
#include <cybozu/sha2.hpp>
#include <set>
#include <time.h>
#include <string>
#include <vector>

const size_t maxMsgN = 32;

using namespace bbs;
using namespace mcl;

typedef std::vector<uint8_t> Bytes;
typedef std::vector<uint32_t> IntVec;

Bytes fromHex(const std::string& hex)
{
	if (hex.size() % 2) throw cybozu::Exception("fromHex:odd size") << hex.size();
	Bytes v(hex.size() / 2);
	for (size_t i = 0; i < v.size(); i++) {
		uint8_t L, H;
		if (!mcl::fp::local::hexCharToUint8(&H, hex[i * 2])) throw cybozu::Exception("fromHex:bad char") << i;
		if (!mcl::fp::local::hexCharToUint8(&L, hex[i * 2 + 1])) throw cybozu::Exception("fromHex:bad char") << i;
		v[i] = L | (H << 4);
	}
	return v;
}

std::string toHex(const void *buf, size_t n)
{
	const uint8_t *p = (const uint8_t*)buf;
	std::string s;
	for (size_t i = 0; i < n; i++) {
		char tmp[3];
		snprintf(tmp, sizeof(tmp), "%02x", p[i]);
		s += tmp;
	}
	return s;
}

std::string toHex(const Bytes& v)
{
	return toHex(v.data(), v.size());
}

template<class T>
std::string serializeToHex(const T& x)
{
	uint8_t buf[128];
	size_t n = x.serialize(buf, sizeof(buf));
	return toHex(buf, n);
}

// messages in the form of the argument of bbsSign
struct Msgs {
	Bytes data; // msg[0] || msg[1] || ...
	IntVec size;
	void add(const Bytes& m)
	{
		data.insert(data.end(), m.begin(), m.end());
		size.push_back(uint32_t(m.size()));
	}
	void addHex(const char *hex) { add(fromHex(hex)); }
	Bytes get(size_t idx) const
	{
		size_t pos = 0;
		for (size_t i = 0; i < idx; i++) pos += size[i];
		return Bytes(data.begin() + pos, data.begin() + pos + size[idx]);
	}
	// select msg[idxs[0]], msg[idxs[1]], ...
	Msgs select(const uint32_t *idxs, size_t n) const
	{
		Msgs r;
		for (size_t i = 0; i < n; i++) r.add(get(idxs[i]));
		return r;
	}
	Msgs select(const IntVec& idxs) const { return select(idxs.data(), idxs.size()); }
	const uint8_t *p() const { return data.data(); }
	const uint32_t *sizes() const { return size.data(); }
	uint32_t n() const { return uint32_t(size.size()); }
};

/*
	test vectors of BLS12-381-SHA-256 in draft-irtf-cfrg-bbs-signatures-12
*/
// 8.2 Messages
const char *g_msgHexTbl[] = {
	"9872ad089e452c7b6e283dfac2a80d58e8d0ff71cc4d5e310a1debdda4a45f02",
	"c344136d9ab02da4dd5908bbba913ae6f58c2cc844b802a6f811f5fb075f9b80",
	"7372e9daa5ed31e6cd5c825eac1b855e84476a1d94932aa348e07b73",
	"77fe97eb97a1ebe2e81e4e3597a3ee740a66e9ef2412472c",
	"496694774c5604ab1b2544eababcf0f53278ff50",
	"515ae153e22aae04ad16f759e07237b4",
	"d183ddc6e2665aa4e2f088af",
	"ac55fb33a75909ed",
	"96012096",
	"",
};
const size_t g_msgTblN = CYBOZU_NUM_OF_ARRAY(g_msgHexTbl);

// 8.4.1 Key Pair
const char *g_keyMaterialHex = "746869732d49532d6a7573742d616e2d546573742d494b4d2d746f2d67656e65726174652d246528724074232d6b6579";
const char *g_keyInfoHex = "746869732d49532d736f6d652d6b65792d6d657461646174612d746f2d62652d757365642d696e2d746573742d6b65792d67656e";
// api_id || "KEYGEN_DST_"
const char *g_keyDstHex = "4242535f424c53313233383147315f584d443a5348412d3235365f535357555f524f5f4832475f484d32535f4b455947454e5f4453545f";
const char *g_secHex = "60e55110f76883a13d030b2f6bd11883422d5abde717569fc0731f51237169fc";
const char *g_pubHex = "a820f230f6ae38503b86c70dc50b61c58a77e45c39ab25c0652bbaa8fa136f2851bd4781c9dcde39fc9d1d52c9e60268061e7d7632171d91aa8d460acee0e96f1e7c4cfb12d3ff9ab5d5dc91c277db75c845d649ef3c4f63aebc364cd55ded0c";

const char *g_headerHex = "11223344556677889900aabbccddeeff";
const char *g_phHex = "bed231d880675ed101ead304512e043ade9958dd0241ea70b4b3957fba941501";

// 8.4.4.1 Valid Single Message Signature
const char *g_sigSingleHex = "84773160b824e194073a57493dac1a20b667af70cd2352d8af241c77658da5253aa8458317cca0eae615690d55b1f27164657dcafee1d5c1973947aa70e2cfbb4c892340be5969920d0916067b4565a0";
// 8.4.4.2 Valid Multi-Message Signature
const char *g_sigMultiHex = "8339b285a4acd89dec7777c09543a43e3cc60684b0a6f8ab335da4825c96e1463e28f8c5f4fd0641d19cec5920d3a8ff4bedb6c9691454597bbd298288abed3632078557b2ace7d44caed846e1a0a1e8";
// D.2.1.1 No Header Valid Signature
const char *g_sigNoHeaderHex = "8c87e2080859a97299c148427cd2fcf390d24bea850103a9748879039262ecf4f42206f6ef767f298b6a96b424c1e86c26f8fba62212d0e05b95261c2cc0e5fdc63a32731347e810fd12e9c58355aa0d";
// D.2.1.6 Wrong Public Key Signature
const char *g_wrongPubHex = "b064bd8d1ba99503cbb7f9d7ea00bce877206a85b1750e5583dd9399828a4d20610cb937ea928d90404c239b2835ffb104220a9c66a4c9ed3b54c0cac9ea465d0429556b438ceefb59650ddf67e7a8f103677561b7ef7fe3c3357ec6b94d41c6";

// 8.4.5 Proof Fixtures
const char *g_mockSeedHex = "332e313431353932363533353839373933323338343632363433333833323739";
const char g_mockDst[] = "BBS_BLS12381G1_XMD:SHA-256_SSWU_RO_H2G_HM2S_MOCK_RANDOM_SCALARS_DST_";

Msgs getMsgs(size_t n = g_msgTblN)
{
	Msgs msgs;
	for (size_t i = 0; i < n; i++) msgs.addHex(g_msgHexTbl[i]);
	return msgs;
}

void setSecretKey(bbsSecretKey& sec, const char *hex)
{
	const Bytes v = fromHex(hex);
	CYBOZU_TEST_EQUAL(bbsDeserializeSecretKey(&sec, v.data(), v.size()), v.size());
}

void setPublicKey(bbsPublicKey& pub, const char *hex)
{
	const Bytes v = fromHex(hex);
	CYBOZU_TEST_EQUAL(bbsDeserializePublicKey(&pub, v.data(), v.size()), v.size());
}

void setSignature(bbsSignature& sig, const char *hex)
{
	const Bytes v = fromHex(hex);
	CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, v.data(), v.size()), v.size());
}

std::string toHex(const bbsSecretKey& sec)
{
	uint8_t buf[128];
	return toHex(buf, bbsSerializeSecretKey(buf, sizeof(buf), &sec));
}

std::string toHex(const bbsPublicKey& pub)
{
	uint8_t buf[128];
	return toHex(buf, bbsSerializePublicKey(buf, sizeof(buf), &pub));
}

std::string toHex(const bbsSignature& sig)
{
	uint8_t buf[128];
	return toHex(buf, bbsSerializeSignature(buf, sizeof(buf), &sig));
}

// 8.1 Mocked Random Scalars
void mockedRandomScalars(std::vector<Fr>& out, size_t count)
{
	const size_t expandLen = 48;
	const Bytes seed = fromHex(g_mockSeedHex);
	Bytes v(expandLen * count);
	mcl::fp::expand_message_xmd(v.data(), v.size(), seed.data(), seed.size(), g_mockDst, strlen(g_mockDst));
	out.resize(count);
	for (size_t i = 0; i < count; i++) {
		bool b;
		out[i].setBigEndianMod(&b, &v[expandLen * i], expandLen);
		CYBOZU_TEST_ASSERT(b);
	}
}

std::string getGeneratorsHex(size_t n)
{
	std::string s;
	const G1 *gen = bbs::local::getGenerators();
	for (size_t i = 0; i < n; i++) s += serializeToHex(gen[i]);
	return s;
}

CYBOZU_TEST_AUTO(init)
{
	// not initialized
	{
		bbsSecretKey sec;
		CYBOZU_TEST_ASSERT(!bbsInitSecretKey(&sec));
	}
	CYBOZU_TEST_ASSERT(!bbsInit(BBS_BLS12381_SHAKE256, 4));
	CYBOZU_TEST_ASSERT(!bbsInit(-1, 4));

	// extend generators
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, 4));
	const std::string gen4 = getGeneratorsHex(5);
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, 16));
	const std::string gen16 = getGeneratorsHex(17);
	CYBOZU_TEST_EQUAL(gen16.substr(0, gen4.size()), gen4);
	// a smaller maxMsgN keeps the generators
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, 2));
	CYBOZU_TEST_EQUAL(getGeneratorsHex(17), gen16);

	bbsTerm();
	bbsTerm();
	CYBOZU_TEST_ASSERT(bbs::local::getGenerators() == 0);
	{
		bbsSecretKey sec;
		CYBOZU_TEST_ASSERT(!bbsInitSecretKey(&sec));
	}

	// generators made at once are equal to the extended ones
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, 16));
	CYBOZU_TEST_EQUAL(getGeneratorsHex(17), gen16);

	CYBOZU_TEST_ASSERT(init(BBS_BLS12381_SHA256, maxMsgN));

	CYBOZU_TEST_EQUAL(bbsGetSecretKeySerializeByteSize(), 32u);
	CYBOZU_TEST_EQUAL(bbsGetPublicKeySerializeByteSize(), 96u);
	CYBOZU_TEST_EQUAL(bbsGetSignatureSerializeByteSize(), 80u);
	CYBOZU_TEST_EQUAL(bbsGetProofSize(0), 272u);
	CYBOZU_TEST_EQUAL(bbsGetProofSize(6), 464u);
	CYBOZU_TEST_EQUAL(bbsSizeofSecretKey(), sizeof(Fr));
	CYBOZU_TEST_EQUAL(bbsSizeofPublicKey(), sizeof(G2));
	CYBOZU_TEST_EQUAL(bbsSizeofSignature(), sizeof(G1) + sizeof(Fr));
}

// D.2.3 Hash to Scalar Test Vectors
CYBOZU_TEST_AUTO(spec_hashToScalar)
{
	const Bytes msg = fromHex("9872ad089e452c7b6e283dfac2a80d58e8d0ff71cc4d5e310a1debdda4a45f02");
	// api_id || "H2S_"
	const Bytes dst = fromHex("4242535f424c53313233383147315f584d443a5348412d3235365f535357555f524f5f4832475f484d32535f4832535f");
	Fr x;
	bbs::local::hashToScalar(x, msg.data(), msg.size(), dst.data(), dst.size());
	CYBOZU_TEST_EQUAL(serializeToHex(x), "0f90cbee27beb214e6545becb8404640d3612da5d6758dffeccd77ed7169807c");
}

// 8.4.1 Key Pair
CYBOZU_TEST_AUTO(spec_keyGen)
{
	const Bytes keyMaterial = fromHex(g_keyMaterialHex);
	const Bytes keyInfo = fromHex(g_keyInfoHex);
	const Bytes keyDst = fromHex(g_keyDstHex);
	bbsSecretKey sec;
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec, keyMaterial.data(), keyMaterial.size(), keyInfo.data(), keyInfo.size(), keyDst.data(), keyDst.size()));
	CYBOZU_TEST_EQUAL(toHex(sec), g_secHex);
	bbsPublicKey pub;
	CYBOZU_TEST_ASSERT(bbsGetPublicKey(&pub, &sec));
	CYBOZU_TEST_EQUAL(toHex(pub), g_pubHex);

	// the default dst is ciphersuite_id || "KEYGEN_DST_"
	bbsSecretKey sec2, sec3;
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec2, keyMaterial.data(), keyMaterial.size(), keyInfo.data(), keyInfo.size(), 0, 0));
	CYBOZU_TEST_ASSERT(!bbsIsEqualSecretKey(&sec, &sec2));
	const char defaultDst[] = "BBS_BLS12381G1_XMD:SHA-256_SSWU_RO_KEYGEN_DST_";
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec3, keyMaterial.data(), keyMaterial.size(), keyInfo.data(), keyInfo.size(), (const uint8_t*)defaultDst, strlen(defaultDst)));
	CYBOZU_TEST_ASSERT(bbsIsEqualSecretKey(&sec2, &sec3));
	// keyInfo is optional
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec3, keyMaterial.data(), keyMaterial.size(), 0, 0, 0, 0));
	CYBOZU_TEST_ASSERT(!bbsIsEqualSecretKey(&sec2, &sec3));

	// bad parameters
	CYBOZU_TEST_ASSERT(!bbsKeyGen(&sec2, keyMaterial.data(), 31, 0, 0, 0, 0));
	const Bytes large(65536);
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec2, keyMaterial.data(), keyMaterial.size(), large.data(), 65535, 0, 0));
	CYBOZU_TEST_ASSERT(!bbsKeyGen(&sec2, keyMaterial.data(), keyMaterial.size(), large.data(), 65536, 0, 0));
	CYBOZU_TEST_ASSERT(bbsKeyGen(&sec2, keyMaterial.data(), keyMaterial.size(), 0, 0, large.data(), 255));
	CYBOZU_TEST_ASSERT(!bbsKeyGen(&sec2, keyMaterial.data(), keyMaterial.size(), 0, 0, large.data(), 256));
}

// 8.4.2 Map Messages to Scalars
CYBOZU_TEST_AUTO(spec_msgToFr)
{
	const char *expectTbl[] = {
		"1cb5bb86114b34dc438a911617655a1db595abafac92f47c5001799cf624b430",
		"154249d503c093ac2df516d4bb88b510d54fd97e8d7121aede420a25d9521952",
		"0c7c4c85cdab32e6fdb0de267b16fa3212733d4e3a3f0d0f751657578b26fe22",
		"4a196deafee5c23f630156ae13be3e46e53b7e39094d22877b8cba7f14640888",
		"34c5ea4f2ba49117015a02c711bb173c11b06b3f1571b88a2952b93d0ed4cf7e",
		"4045b39b83055cd57a4d0203e1660800fabe434004dbdc8730c21ce3f0048b08",
		"064621da4377b6b1d05ecc37cf3b9dfc94b9498d7013dc5c4a82bf3bb1750743",
		"34ac9196ace0a37e147e32319ea9b3d8cc7d21870d3c3ba071246859cca49b02",
		"57eb93f417c43200e9784fa5ea5a59168d3dbc38df707a13bb597c871b2a5f74",
		"08e3afeb2b4f2b5f907924ef42856616e6f2d5f1fb373736db1cca32707a7d16",
	};
	CYBOZU_TEST_EQUAL(CYBOZU_NUM_OF_ARRAY(expectTbl), g_msgTblN);
	for (size_t i = 0; i < g_msgTblN; i++) {
		const Bytes msg = fromHex(g_msgHexTbl[i]);
		Fr x;
		bbs::local::msgToFr(x, msg.data(), msg.size());
		CYBOZU_TEST_EQUAL(serializeToHex(x), expectTbl[i]);
	}
}

// 8.4.3 Message Generators
CYBOZU_TEST_AUTO(spec_generators)
{
	// Q_1, H_1, ..., H_10
	const char *expectTbl[] = {
		"a9ec65b70a7fbe40c874c9eb041c2cb0a7af36ccec1bea48fa2ba4c2eb67ef7f9ecb17ed27d38d27cdeddff44c8137be",
		"98cd5313283aaf5db1b3ba8611fe6070d19e605de4078c38df36019fbaad0bd28dd090fd24ed27f7f4d22d5ff5dea7d4",
		"a31fbe20c5c135bcaa8d9fc4e4ac665cc6db0226f35e737507e803044093f37697a9d452490a970eea6f9ad6c3dcaa3a",
		"b479263445f4d2108965a9086f9d1fdc8cde77d14a91c856769521ad3344754cc5ce90d9bc4c696dffbc9ef1d6ad1b62",
		"ac0401766d2128d4791d922557c7b4d1ae9a9b508ce266575244a8d6f32110d7b0b7557b77604869633bb49afbe20035",
		"b95d2898370ebc542857746a316ce32fa5151c31f9b57915e308ee9d1de7db69127d919e984ea0747f5223821b596335",
		"8f19359ae6ee508157492c06765b7df09e2e5ad591115742f2de9c08572bb2845cbf03fd7e23b7f031ed9c7564e52f39",
		"abc914abe2926324b2c848e8a411a2b6df18cbe7758db8644145fefb0bf0a2d558a8c9946bd35e00c69d167aadf304c1",
		"80755b3eb0dd4249cbefd20f177cee88e0761c066b71794825c9997b551f24051c352567ba6c01e57ac75dff763eaa17",
		"82701eb98070728e1769525e73abff1783cedc364adb20c05c897a62f2ab2927f86f118dcb7819a7b218d8f3fee4bd7f",
		"a1f229540474f4d6f1134761b92b788128c7ac8dc9b0c52d59493132679673032ac7db3fb3d79b46b13c1c41ee495bca",
	};
	const G1 *gen = bbs::local::getGenerators();
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(expectTbl); i++) {
		CYBOZU_TEST_EQUAL(serializeToHex(gen[i]), expectTbl[i]);
	}
}

// 8.4.4 and D.2.1 Signature Fixtures
CYBOZU_TEST_AUTO(spec_sign)
{
	bbsSecretKey sec;
	bbsPublicKey pub;
	setSecretKey(sec, g_secHex);
	setPublicKey(pub, g_pubHex);
	const Bytes header = fromHex(g_headerHex);
	const struct {
		size_t msgN;
		bool useHeader;
		const char *sigHex;
	} tbl[] = {
		{ 1, true, g_sigSingleHex },
		{ g_msgTblN, true, g_sigMultiHex },
		{ g_msgTblN, false, g_sigNoHeaderHex },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Msgs msgs = getMsgs(tbl[i].msgN);
		const uint8_t *h = tbl[i].useHeader ? header.data() : 0;
		const size_t hSize = tbl[i].useHeader ? header.size() : 0;
		bbsSignature sig;
		CYBOZU_TEST_ASSERT(bbsSign(&sig, &sec, &pub, h, hSize, msgs.p(), msgs.sizes(), msgs.n()));
		CYBOZU_TEST_EQUAL(toHex(sig), tbl[i].sigHex);
		bbsSignature sig2;
		setSignature(sig2, tbl[i].sigHex);
		CYBOZU_TEST_ASSERT(bbsIsEqualSignature(&sig, &sig2));
		CYBOZU_TEST_ASSERT(bbsVerify(&sig2, &pub, h, hSize, msgs.p(), msgs.sizes(), msgs.n()));
	}
}

CYBOZU_TEST_AUTO(spec_invalid_sign)
{
	bbsPublicKey pub;
	setPublicKey(pub, g_pubHex);
	const Bytes header = fromHex(g_headerHex);
	bbsSignature sigSingle, sigMulti;
	setSignature(sigSingle, g_sigSingleHex);
	setSignature(sigMulti, g_sigMultiHex);
	const Msgs all = getMsgs();
	CYBOZU_TEST_ASSERT(bbsVerify(&sigMulti, &pub, header.data(), header.size(), all.p(), all.sizes(), all.n()));

	// D.2.1.2 Modified Message Signature
	{
		Msgs msgs;
		msgs.addHex("");
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigSingle, &pub, header.data(), header.size(), msgs.p(), msgs.sizes(), msgs.n()));
	}
	// D.2.1.3 Extra Unsigned Message Signature
	{
		const Msgs msgs = getMsgs(2);
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigSingle, &pub, header.data(), header.size(), msgs.p(), msgs.sizes(), msgs.n()));
	}
	// D.2.1.4 Missing Message Signature
	{
		const Msgs msgs = getMsgs(2);
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigMulti, &pub, header.data(), header.size(), msgs.p(), msgs.sizes(), msgs.n()));
	}
	// D.2.1.5 Reordered Message Signature
	{
		Msgs msgs;
		for (size_t i = 0; i < g_msgTblN; i++) msgs.addHex(g_msgHexTbl[g_msgTblN - 1 - i]);
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigMulti, &pub, header.data(), header.size(), msgs.p(), msgs.sizes(), msgs.n()));
	}
	// D.2.1.6 Wrong Public Key Signature
	{
		bbsPublicKey wrongPub;
		setPublicKey(wrongPub, g_wrongPubHex);
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigMulti, &wrongPub, header.data(), header.size(), all.p(), all.sizes(), all.n()));
	}
	// D.2.1.7 Wrong Header Signature
	{
		const Bytes wrongHeader = fromHex("ffeeddccbbaa00998877665544332211");
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigMulti, &pub, wrongHeader.data(), wrongHeader.size(), all.p(), all.sizes(), all.n()));
		CYBOZU_TEST_ASSERT(!bbsVerify(&sigMulti, &pub, 0, 0, all.p(), all.sizes(), all.n()));
	}
}

// 8.4.5 Proof Fixtures
CYBOZU_TEST_AUTO(spec_mockedRandomScalars)
{
	const char *expectTbl[] = {
		"04f8e2518993c4383957ad14eb13a023c4ad0c67d01ec86eeb902e732ed6df3f",
		"5d87c1ba64c320ad601d227a1b74188a41a100325cecf00223729863966392b1",
		"0444607600ac70482e9c983b4b063214080b9e808300aa4cc02a91b3a92858fe",
		"548cd11eae4318e88cda10b4cd31ae29d41c3a0b057196ee9cf3a69d471e4e94",
		"2264b06a08638b69b4627756a62f08e0dc4d8240c1b974c9c7db779a769892f4",
		"4d99352986a9f8978b93485d21525244b21b396cf61f1d71f7c48e3fbc970a42",
		"5ed8be91662386243a6771fbdd2c627de31a44220e8d6f745bad5d99821a4880",
		"62ff1734b939ddd87beeb37a7bbcafa0a274cbc1b07384198f0e88398272208d",
		"05c2a0af016df58e844db8944082dcaf434de1b1e2e7136ec8a99b939b716223",
		"485e2adab17b76f5334c95bf36c03ccf91cef77dcfcdc6b8a69e2090b3156663",
	};
	std::vector<Fr> rs;
	mockedRandomScalars(rs, CYBOZU_NUM_OF_ARRAY(expectTbl));
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(expectTbl); i++) {
		CYBOZU_TEST_EQUAL(serializeToHex(rs[i]), expectTbl[i]);
	}
}

CYBOZU_TEST_AUTO(spec_proof)
{
	bbsPublicKey pub;
	setPublicKey(pub, g_pubHex);
	const Bytes header = fromHex(g_headerHex);
	const Bytes ph = fromHex(g_phHex);
	const uint32_t all[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
	const uint32_t some[] = { 0, 2, 4, 6 };
	const struct {
		size_t msgN;
		bool useHeader;
		bool usePh;
		const char *sigHex;
		const uint32_t *discIdxs;
		uint32_t discN;
		const char *proofHex;
	} tbl[] = {
		// 8.4.5.1 Valid Single Message Proof
		{
			1, true, true, g_sigSingleHex, all, 1,
			"94916292a7a6bade28456c601d3af33fcf39278d6594b467e128a3f83686a104ef2b2fcf72df0215eeaf69262ffe8194a19fab31a82ddbe06908985abc4c9825788b8a1610942d12b7f5debbea8985296361206dbace7af0cc834c80f33e0aadaeea5597befbb651827b5eed5a66f1a959bb46cfd5ca1a817a14475960f69b32c54db7587b5ee3ab665fbd37b506830a49f21d592f5e634f47cee05a025a2f8f94e73a6c15f02301d1178a92873b6e8634bafe4983c3e15a663d64080678dbf29417519b78af042be2b3e1c4d08b8d520ffab008cbaaca5671a15b22c239b38e940cfeaa5e72104576a9ec4a6fad78c532381aeaa6fb56409cef56ee5c140d455feeb04426193c57086c9b6d397d9418",
		},
		// 8.4.5.2 Valid Multi-Message, All Messages Disclosed Proof
		{
			g_msgTblN, true, true, g_sigMultiHex, all, 10,
			"b1f468aec2001c4f54cb56f707c6222a43e5803a25b2253e67b2210ab2ef9eab52db2d4b379935c4823281eaf767fd37b08ce80dc65de8f9769d27099ae649ad4c9b4bd2cc23edcba52073a298087d2495e6d57aaae051ef741adf1cbce65c64a73c8c97264177a76c4a03341956d2ae45ed3438ce598d5cda4f1bf9507fecef47855480b7b30b5e4052c92a4360110c67327365763f5aa9fb85ddcbc2975449b8c03db1216ca66b310f07d0ccf12ab460cdc6003b677fed36d0a23d0818a9d4d098d44f749e91008cf50e8567ef936704c8277b7710f41ab7e6e16408ab520edc290f9801349aee7b7b4e318e6a76e028e1dea911e2e7baec6a6a174da1a22362717fbae1cd961d7bf4adce1d31c2ab",
		},
		// 8.4.5.3 Valid Multi-Message, Some Messages Disclosed Proof
		{
			g_msgTblN, true, true, g_sigMultiHex, some, 4,
			"a2ed608e8e12ed21abc2bf154e462d744a367c7f1f969bdbf784a2a134c7db2d340394223a5397a3011b1c340ebc415199462ba6f31106d8a6da8b513b37a47afe93c9b3474d0d7a354b2edc1b88818b063332df774c141f7a07c48fe50d452f897739228c88afc797916dca01e8f03bd9c5375c7a7c59996e514bb952a436afd24457658acbaba5ddac2e693ac481356918cd38025d86b28650e909defe9604a7259f44386b861608be742af7775a2e71a6070e5836f5f54dc43c60096834a5b6da295bf8f081f72b7cdf7f3b4347fb3ff19edaa9e74055c8ba46dbcb7594fb2b06633bb5324192eb9be91be0d33e453b4d3127459de59a5e2193c900816f049a02cb9127dac894418105fa1641d5a206ec9c42177af9316f433417441478276ca0303da8f941bf2e0222a43251cf5c2bf6eac1961890aa740534e519c1767e1223392a3a286b0f4d91f7f25217a7862b8fcc1810cdcfddde2a01c80fcc90b632585fec12dc4ae8fea1918e9ddeb9414623a457e88f53f545841f9d5dcb1f8e160d1560770aa79d65e2eca8edeaecb73fb7e995608b820c4a64de6313a370ba05dc25ed7c1d185192084963652f2870341bdaa4b1a37f8c06348f38a4f80c5a2650a21d59f09e8305dcd3fc3ac30e2a",
		},
		// D.2.2.1 No Header Valid Proof
		{
			g_msgTblN, false, true, g_sigNoHeaderHex, some, 4,
			"81925c2e525d9fbb0ba95b438b5a13fff5874c7c0515c193628d7d143ddc3bb487771ad73658895997a88dd5b254ed29abc019bfca62c09b8dafb37e5f09b1d380e084ec3623d071ec38d6b8602af93aa0ddbada307c9309cca86be16db53dc7ac310574f509c712bb1a181d64ea3c1ee075c018a2bc773e2480b5c033ccb9bfea5af347a88ab83746c9342ba76db3675ff70ce9006d166fd813a81b448a632216521c864594f3f92965974914992f8d1845230915b11680cf44b25886c5670904ac2d88255c8c31aea7b072e9c4eb7e4c3fdd38836ae9d2e9fa271c8d9fd42f669a9938aeeba9d8ae613bf11f489ce947616f5cbaee95511dfaa5c73d85e4ddd2f29340f821dc2fb40db3eae5f5bc08467eb195e38d7d436b63e556ea653168282a23b53d5792a107f85b1203f82aab46f6940650760e5b320261ffc0ca5f15917b51e7d2ad4bcbec94de792e229db663abff23af392a5e73ce115c27e8492ec24a0815091c69874dbd9dae2d2eed000810c748a798a78a804a39034c6e745cee455812cc982eea7105948b2cb55b82278a77237fcbec4748e2d2255af0994dd09dba8ac60515a39b24632a2c1c840c4a70506add5b2eb0be9ff66e3ea8deae666f198edfbb1391c6834e6df4f1026d",
		},
		// D.2.2.2 No Presentation Header Valid Proof
		{
			g_msgTblN, true, false, g_sigMultiHex, some, 4,
			"a2ed608e8e12ed21abc2bf154e462d744a367c7f1f969bdbf784a2a134c7db2d340394223a5397a3011b1c340ebc415199462ba6f31106d8a6da8b513b37a47afe93c9b3474d0d7a354b2edc1b88818b063332df774c141f7a07c48fe50d452f897739228c88afc797916dca01e8f03bd9c5375c7a7c59996e514bb952a436afd24457658acbaba5ddac2e693ac48135672556358e78b5398f1a547a2a98dfe16230f244ba742dea737e4f810b4d94e03ac068ef840aaadf12b2ed51d3fb774c2a0a620019fd1f39c52c6f89a0e6067e3039413a91129791b2af215a82ad2356b6bc305c1d7a828fe519619dd026eaaf07ea81cee52b21aab3e8320519bf37c2bb228a8b580f899d84327bdc5e84a66000e8bac17d2fa039bb2246c8eacc623ccd9eb26e184a96a9e3a6702e1dbafe194772394b05251f72bcd2d20f542b15b2406f899791f6f285c7b469e7c7b9624147f305c38c903273a949f6e85b9774aeeccfafa432e2cdd7c8f97d1687741ed30d725444428dd87d9884711d9a46baaf0c04b03a2a228b7033be0841880134b03b15f698756eca5f37503a0411a9586d3027a8b8b9118e95a9949b2719e85e4a669d9e4b7bb6d4544c8cc558c30d79f9c85a87e1a95611400b7c7dac5673d800",
		},
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const Msgs msgs = getMsgs(tbl[i].msgN);
		const uint8_t *h = tbl[i].useHeader ? header.data() : 0;
		const size_t hSize = tbl[i].useHeader ? header.size() : 0;
		const uint8_t *p = tbl[i].usePh ? ph.data() : 0;
		const size_t pSize = tbl[i].usePh ? ph.size() : 0;
		const uint32_t *discIdxs = tbl[i].discIdxs;
		const uint32_t discN = tbl[i].discN;
		const uint32_t undiscN = msgs.n() - discN;
		bbsSignature sig;
		setSignature(sig, tbl[i].sigHex);

		std::vector<Fr> rs;
		mockedRandomScalars(rs, 5 + undiscN);
		Bytes proof(bbsGetProofSize(undiscN));
		const PublicKey& cpub = *reinterpret_cast<const PublicKey*>(&pub);
		const Signature& csig = *reinterpret_cast<const Signature*>(&sig);
		size_t n = bbs::local::proofGenWithRandomScalars(proof.data(), proof.size(), cpub, csig, h, hSize, p, pSize, msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN, rs.data());
		CYBOZU_TEST_EQUAL(n, proof.size());
		CYBOZU_TEST_EQUAL(toHex(proof), tbl[i].proofHex);

		const Msgs discMsgs = msgs.select(discIdxs, discN);
		const Bytes expect = fromHex(tbl[i].proofHex);
		CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, expect.data(), expect.size(), h, hSize, p, pSize, discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	}
}

CYBOZU_TEST_AUTO(invalid_proof)
{
	bbsPublicKey pub;
	setPublicKey(pub, g_pubHex);
	const Bytes header = fromHex(g_headerHex);
	const Bytes ph = fromHex(g_phHex);
	const Msgs msgs = getMsgs();
	bbsSignature sig;
	setSignature(sig, g_sigMultiHex);
	const uint32_t discIdxs[] = { 0, 2, 4, 6 };
	const uint32_t discN = CYBOZU_NUM_OF_ARRAY(discIdxs);
	const uint32_t undiscN = msgs.n() - discN;
	const Msgs discMsgs = msgs.select(discIdxs, discN);

	Bytes proof(bbsGetProofSize(undiscN));
	CYBOZU_TEST_EQUAL(bbsProofGen(proof.data(), proof.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN), proof.size());
	CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));

	// random scalars are used
	{
		Bytes proof2(proof.size());
		CYBOZU_TEST_EQUAL(bbsProofGen(proof2.data(), proof2.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN), proof2.size());
		CYBOZU_TEST_ASSERT(proof != proof2);
		CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof2.data(), proof2.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
		// any part of the proofs does not coincide
		for (size_t i = 0; i < 3; i++) {
			CYBOZU_TEST_ASSERT(memcmp(&proof[48 * i], &proof2[48 * i], 48) != 0);
		}
		for (size_t i = 0; i < 4 + undiscN; i++) {
			CYBOZU_TEST_ASSERT(memcmp(&proof[144 + 32 * i], &proof2[144 + 32 * i], 32) != 0);
		}
	}
	// small buffer
	CYBOZU_TEST_EQUAL(bbsProofGen(proof.data(), proof.size() - 1, &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN), 0u);
	// wrong presentation header
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size() - 1, discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), 0, 0, discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	// wrong header
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size() - 1, ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), 0, 0, ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	// wrong public key
	{
		bbsPublicKey wrongPub;
		setPublicKey(wrongPub, g_wrongPubHex);
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&wrongPub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	}
	// wrong disclosed message
	{
		const uint32_t wrongIdxs[] = { 0, 2, 4, 7 };
		const Msgs wrongMsgs = msgs.select(wrongIdxs, discN);
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), wrongMsgs.p(), wrongMsgs.sizes(), discIdxs, discN));
		// wrong index
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), wrongIdxs, discN));
	}
	// bad indexes
	{
		const uint32_t notAscending[] = { 0, 4, 2, 6 };
		const uint32_t duplicated[] = { 0, 2, 2, 6 };
		const uint32_t outOfRange[] = { 0, 2, 4, 10 };
		const uint32_t *tbl[] = { notAscending, duplicated, outOfRange };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			Bytes tmp(proof.size());
			CYBOZU_TEST_EQUAL(bbsProofGen(tmp.data(), tmp.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), msgs.p(), msgs.sizes(), msgs.n(), tbl[i], discN), 0u);
			CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), tbl[i], discN));
		}
	}
	// the number of disclosed messages is different
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN - 1));
	// bad proof size
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size() - 1, header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), proof.size() - 32, header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), 271, header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), 0, header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	// the number of messages computed from the proof size is larger than maxMsgN
	{
		const Bytes large(bbsGetProofSize(maxMsgN));
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, large.data(), large.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	}
	// modify each byte of the proof
	for (size_t i = 0; i < proof.size(); i++) {
		Bytes tmp = proof;
		tmp[i] ^= 1;
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, tmp.data(), tmp.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	}
	// a zero scalar and a scalar which is not less than r are rejected
	{
		const Bytes r = fromHex("73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001");
		for (size_t i = 0; i < 4 + undiscN; i++) {
			Bytes tmp = proof;
			memset(&tmp[144 + 32 * i], 0, 32);
			CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, tmp.data(), tmp.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
			memcpy(&tmp[144 + 32 * i], r.data(), 32);
			CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, tmp.data(), tmp.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
		}
	}
	// the identity is rejected
	for (size_t i = 0; i < 3; i++) {
		Bytes tmp = proof;
		memset(&tmp[48 * i], 0, 48);
		tmp[48 * i] = 0xc0;
		CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, tmp.data(), tmp.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	}
}

CYBOZU_TEST_AUTO(deserialize)
{
	const Bytes zero(96);
	const Bytes r = fromHex("73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001");
	// secret key
	{
		bbsSecretKey sec;
		CYBOZU_TEST_EQUAL(bbsDeserializeSecretKey(&sec, zero.data(), 32), 0u);
		CYBOZU_TEST_EQUAL(bbsDeserializeSecretKey(&sec, r.data(), 32), 0u);
		const Bytes v = fromHex(g_secHex);
		CYBOZU_TEST_EQUAL(bbsDeserializeSecretKey(&sec, v.data(), 31), 0u);
		CYBOZU_TEST_EQUAL(bbsDeserializeSecretKey(&sec, v.data(), 32), 32u);
		CYBOZU_TEST_EQUAL(toHex(sec), g_secHex);
		uint8_t buf[32];
		CYBOZU_TEST_EQUAL(bbsSerializeSecretKey(buf, 31, &sec), 0u);
	}
	// public key
	{
		bbsPublicKey pub;
		// the identity
		Bytes id(96);
		id[0] = 0xc0;
		CYBOZU_TEST_EQUAL(bbsDeserializePublicKey(&pub, id.data(), id.size()), 0u);
		CYBOZU_TEST_EQUAL(bbsDeserializePublicKey(&pub, zero.data(), zero.size()), 0u);
		Bytes v = fromHex(g_pubHex);
		CYBOZU_TEST_EQUAL(bbsDeserializePublicKey(&pub, v.data(), 95), 0u);
		CYBOZU_TEST_EQUAL(bbsDeserializePublicKey(&pub, v.data(), 96), 96u);
		CYBOZU_TEST_EQUAL(toHex(pub), g_pubHex);
		uint8_t buf[96];
		CYBOZU_TEST_EQUAL(bbsSerializePublicKey(buf, 95, &pub), 0u);
		// not on the curve or not in G2
		int ng = 0;
		for (int i = 0; i < 16; i++) {
			Bytes tmp = v;
			tmp[95] ^= uint8_t(i + 1);
			if (bbsDeserializePublicKey(&pub, tmp.data(), tmp.size()) == 0) ng++;
		}
		CYBOZU_TEST_EQUAL(ng, 16);
	}
	// signature
	{
		bbsSignature sig;
		Bytes v = fromHex(g_sigSingleHex);
		CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, v.data(), 79), 0u);
		CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, v.data(), 80), 80u);
		CYBOZU_TEST_EQUAL(toHex(sig), g_sigSingleHex);
		uint8_t buf[80];
		CYBOZU_TEST_EQUAL(bbsSerializeSignature(buf, 79, &sig), 0u);
		// e = 0
		Bytes tmp = v;
		memset(&tmp[48], 0, 32);
		CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, tmp.data(), tmp.size()), 0u);
		// e = r
		memcpy(&tmp[48], r.data(), 32);
		CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, tmp.data(), tmp.size()), 0u);
		// A is the identity
		tmp = v;
		memset(&tmp[0], 0, 48);
		tmp[0] = 0xc0;
		CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, tmp.data(), tmp.size()), 0u);
		// A is on the curve but not in G1
		bool found = false;
		for (int x = 1; x < 100; x++) {
			Bytes pt(48);
			pt[0] = 0x80; // compressed
			pt[47] = uint8_t(x);
			G1 P;
			verifyOrderG1(false);
			const bool onCurve = P.deserialize(pt.data(), pt.size()) == pt.size();
			verifyOrderG1(true);
			if (!onCurve) continue;
			CYBOZU_TEST_ASSERT(!P.isValidOrder());
			tmp = v;
			memcpy(&tmp[0], pt.data(), 48);
			CYBOZU_TEST_EQUAL(bbsDeserializeSignature(&sig, tmp.data(), tmp.size()), 0u);
			found = true;
			break;
		}
		CYBOZU_TEST_ASSERT(found);
	}
}

CYBOZU_TEST_AUTO(sign_verify)
{
	SecretKey sec;
	CYBOZU_TEST_ASSERT(sec.init());
	PublicKey pub;
	sec.getPublicKey(pub);
	bbsSecretKey csec;
	CYBOZU_TEST_ASSERT(bbsInitSecretKey(&csec));
	bbsPublicKey cpub;
	CYBOZU_TEST_ASSERT(bbsGetPublicKey(&cpub, &csec));
	const uint32_t N = 10;
	// N + 1 messages are prepared to check a signature with an extra message
	uint32_t msgSize[N + 1];
	const uint32_t MSG_SIZE = 2;
	for (size_t i = 0; i < N + 1; i++) msgSize[i] = MSG_SIZE;
	uint8_t msgs[(N + 1)*MSG_SIZE];
	for (size_t i = 0; i < sizeof(msgs); i++) {
		msgs[i] = uint8_t(i);
	}
	const uint8_t header[] = { 'a', 'b', 'c' };

	for (uint32_t n = 0; n <= N; n++) {
		Signature sig;
		CYBOZU_TEST_ASSERT(sig.sign(sec, pub, header, sizeof(header), msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(sig.verify(pub, header, sizeof(header), msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(!sig.verify(pub, header, sizeof(header) - 1, msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(!sig.verify(pub, header, sizeof(header), msgs, msgSize, n + 1));
		if (n > 0) {
			CYBOZU_TEST_ASSERT(!sig.verify(pub, header, sizeof(header), msgs, msgSize, n - 1));
			msgs[0] ^= 1;
			CYBOZU_TEST_ASSERT(!sig.verify(pub, header, sizeof(header), msgs, msgSize, n));
			msgs[0] ^= 1;
		}

		bbsSignature csig;
		CYBOZU_TEST_ASSERT(bbsSign(&csig, &csec, &cpub, 0, 0, msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(bbsVerify(&csig, &cpub, 0, 0, msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(!bbsVerify(&csig, &cpub, header, sizeof(header), msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(!bbsVerify(&csig, &cpub, 0, 0, msgs, msgSize, n + 1));
		// the signature is deterministic
		bbsSignature csig2;
		CYBOZU_TEST_ASSERT(bbsSign(&csig2, &csec, &cpub, 0, 0, msgs, msgSize, n));
		CYBOZU_TEST_ASSERT(bbsIsEqualSignature(&csig, &csig2));
	}
}

CYBOZU_TEST_AUTO(limit)
{
	bbsSecretKey sec;
	bbsPublicKey pub;
	CYBOZU_TEST_ASSERT(bbsInitSecretKey(&sec));
	CYBOZU_TEST_ASSERT(bbsGetPublicKey(&pub, &sec));
	const uint32_t N = uint32_t(maxMsgN) + 1;
	std::vector<uint32_t> msgSize(N, 1);
	std::vector<uint8_t> msgs(N, 'x');
	bbsSignature sig;
	CYBOZU_TEST_ASSERT(!bbsSign(&sig, &sec, &pub, 0, 0, msgs.data(), msgSize.data(), N));
	CYBOZU_TEST_ASSERT(bbsSign(&sig, &sec, &pub, 0, 0, msgs.data(), msgSize.data(), N - 1));
	CYBOZU_TEST_ASSERT(bbsVerify(&sig, &pub, 0, 0, msgs.data(), msgSize.data(), N - 1));
	CYBOZU_TEST_ASSERT(!bbsVerify(&sig, &pub, 0, 0, msgs.data(), msgSize.data(), N));
	Bytes proof(bbsGetProofSize(N));
	CYBOZU_TEST_EQUAL(bbsProofGen(proof.data(), proof.size(), &pub, &sig, 0, 0, 0, 0, msgs.data(), msgSize.data(), N, 0, 0), 0u);
	// disclose nothing with maxMsgN messages
	const size_t n = bbsProofGen(proof.data(), proof.size(), &pub, &sig, 0, 0, 0, 0, msgs.data(), msgSize.data(), N - 1, 0, 0);
	CYBOZU_TEST_EQUAL(n, bbsGetProofSize(N - 1));
	CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof.data(), n, 0, 0, 0, 0, 0, 0, 0, 0));
	// reduce maxMsgN
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, uint32_t(maxMsgN) - 1));
	CYBOZU_TEST_ASSERT(!bbsVerify(&sig, &pub, 0, 0, msgs.data(), msgSize.data(), N - 1));
	CYBOZU_TEST_ASSERT(!bbsProofVerify(&pub, proof.data(), n, 0, 0, 0, 0, 0, 0, 0, 0));
	CYBOZU_TEST_ASSERT(bbsInit(BBS_BLS12381_SHA256, uint32_t(maxMsgN)));
	CYBOZU_TEST_ASSERT(bbsVerify(&sig, &pub, 0, 0, msgs.data(), msgSize.data(), N - 1));
	CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof.data(), n, 0, 0, 0, 0, 0, 0, 0, 0));
}

CYBOZU_TEST_AUTO(setJs)
{
	typedef std::set<uint32_t> IntSet;

	const size_t msgN = 10;
	const struct {
		uint32_t discN;
		uint32_t disc[msgN];
	} tbl[] = {
		{ 0, {} },
		{ 10, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 } },
		{ 1, { 0 } },
		{ 1, { 5 } },
		{ 1, { 9 } },
		{ 2, { 0, 1 } },
		{ 2, { 3, 7 } },
		{ 2, { 3, 9 } },
		{ 3, { 0, 1, 5 } },
		{ 3, { 0, 1, 9 } },
		{ 4, { 0, 2, 4, 8 } },
		{ 4, { 3, 4, 5, 6 } },
		{ 5, { 1, 3, 5, 7, 9 } },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		uint32_t js[msgN];
		for (size_t j = 0; j < msgN; j++) js[j] = uint32_t(-1);
		const uint32_t discN = tbl[i].discN;
		const uint32_t undiscN = msgN  - discN;
		bbs::local::setJs(js, undiscN, tbl[i].disc, discN);
		IntSet is;
		for (size_t j = 0; j < discN; j++) is.insert(tbl[i].disc[j]);
		CYBOZU_TEST_EQUAL(is.size(), discN);
		for (size_t j = 0; j < undiscN; j++) is.insert(js[j]);
		CYBOZU_TEST_EQUAL(is.size(), msgN);
		for (size_t j = 1; j < undiscN; j++) {
			CYBOZU_TEST_ASSERT(js[j - 1] < js[j]);
		}
		for (size_t j = undiscN; j < msgN; j++) {
			CYBOZU_TEST_EQUAL(js[j], uint32_t(-1));
		}
	}
}

void checkProof(const PublicKey& pub, const Signature& sig, const Msgs& msgs, const uint32_t *discIdxs, uint32_t discN)
{
	const uint32_t undiscN = msgs.n() - discN;
	const Msgs discMsgs = msgs.select(discIdxs, discN);
	const uint8_t header[] = { 'h', 'e', 'a', 'd' };
	const uint8_t ph[] = { 1, 2, 3, 4, 0x11, 0x22, 0x33 };

	Bytes proof(getProofSize(undiscN));
	CYBOZU_TEST_EQUAL(proofGen(proof.data(), proof.size(), pub, sig, header, sizeof(header), ph, sizeof(ph), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN), proof.size());
	CYBOZU_TEST_ASSERT(proofVerify(pub, proof.data(), proof.size(), header, sizeof(header), ph, sizeof(ph), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(!proofVerify(pub, proof.data(), proof.size(), header, sizeof(header), ph, sizeof(ph) - 1, discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
}

void ccheckProof(const bbsPublicKey *cpub, const bbsSignature *csig, const Msgs& msgs, const uint32_t *discIdxs, uint32_t discN)
{
	const uint32_t undiscN = msgs.n() - discN;
	const Msgs discMsgs = msgs.select(discIdxs, discN);
	const uint8_t ph[] = { 1, 2, 3, 4, 0x11, 0x22, 0x33 };

	// a larger buffer is allowed
	Bytes proof(bbsGetProofSize(undiscN) + 10);
	const size_t n = bbsProofGen(proof.data(), proof.size(), cpub, csig, 0, 0, ph, sizeof(ph), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN);
	CYBOZU_TEST_EQUAL(n, bbsGetProofSize(undiscN));
	CYBOZU_TEST_ASSERT(bbsProofVerify(cpub, proof.data(), n, 0, 0, ph, sizeof(ph), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	if (discN > 0) {
		// modify a disclosed message
		Msgs wrong = discMsgs;
		wrong.data[0] ^= 1;
		CYBOZU_TEST_ASSERT(!bbsProofVerify(cpub, proof.data(), n, 0, 0, ph, sizeof(ph), wrong.p(), wrong.sizes(), discIdxs, discN));
	}
}

CYBOZU_TEST_AUTO(proof)
{
	const uint32_t msgN = 10;
	Msgs msgs;
	{
		uint8_t c = 0;
		for (size_t i = 0; i < msgN; i++) {
			Bytes m(1 + ((i*15+i) % 13));
			for (size_t j = 0; j < m.size(); j++) {
				m[j] = uint8_t(c*c+123*c+21);
				c++;
			}
			msgs.add(m);
		}
	}
	const uint8_t header[] = { 'h', 'e', 'a', 'd' };

	uint32_t discIdxs[msgN];

	PublicKey pub;
	Signature sig;
	// setup public key and signature
	{
		SecretKey sec;
		CYBOZU_TEST_ASSERT(sec.init());
		sec.getPublicKey(pub);
		CYBOZU_TEST_ASSERT(sig.sign(sec, pub, header, sizeof(header), msgs.p(), msgs.sizes(), msgs.n()));
	}
	bbsPublicKey cpub;
	bbsSignature csig;
	bbsSecretKey csec;
	{
		CYBOZU_TEST_ASSERT(bbsInitSecretKey(&csec));
		CYBOZU_TEST_ASSERT(bbsGetPublicKey(&cpub, &csec));
		CYBOZU_TEST_ASSERT(bbsSign(&csig, &csec, &cpub, 0, 0, msgs.p(), msgs.sizes(), msgs.n()));
	}

	puts("disclose nothing");
	checkProof(pub, sig, msgs, 0, 0);
	ccheckProof(&cpub, &csig, msgs, 0, 0);

	// serialize/deserialize test
	{
		bbsSecretKey csec2;
		bbsPublicKey cpub2;
		bbsSignature csig2;
		char buf[1024];
		size_t n, n2;

		n = bbsSerializeSecretKey(buf, sizeof(buf), &csec);
		CYBOZU_TEST_EQUAL(n, bbsGetSecretKeySerializeByteSize());
		n2 = bbsDeserializeSecretKey(&csec2, buf, n);
		CYBOZU_TEST_EQUAL(n, n2);
		CYBOZU_TEST_ASSERT(bbsIsEqualSecretKey(&csec, &csec2));

		n = bbsSerializePublicKey(buf, sizeof(buf), &cpub);
		CYBOZU_TEST_EQUAL(n, bbsGetPublicKeySerializeByteSize());
		n2 = bbsDeserializePublicKey(&cpub2, buf, n);
		CYBOZU_TEST_EQUAL(n, n2);
		CYBOZU_TEST_ASSERT(bbsIsEqualPublicKey(&cpub, &cpub2));

		n = bbsSerializeSignature(buf, sizeof(buf), &csig);
		CYBOZU_TEST_EQUAL(n, bbsGetSignatureSerializeByteSize());
		n2 = bbsDeserializeSignature(&csig2, buf, n);
		CYBOZU_TEST_EQUAL(n, n2);
		CYBOZU_TEST_ASSERT(bbsIsEqualSignature(&csig, &csig2));
	}

	puts("disclose one");
	{
		const uint32_t discN = 1;
		for (uint32_t i = 0; i < msgN; i++) {
			discIdxs[0] = i;
			checkProof(pub, sig, msgs, discIdxs, discN);
			ccheckProof(&cpub, &csig, msgs, discIdxs, discN);
		}
	}
	puts("disclose two");
	{
		const uint32_t discN = 2;
		for (uint32_t i = 0; i < msgN; i++) {
			discIdxs[0] = i;
			for (uint32_t j = i + 1; j < msgN; j++) {
				discIdxs[1] = j;
				checkProof(pub, sig, msgs, discIdxs, discN);
				ccheckProof(&cpub, &csig, msgs, discIdxs, discN);
			}
		}
	}
	puts("disclose three");
	{
		const uint32_t discN = 3;
		for (uint32_t i = 0; i < msgN; i++) {
			discIdxs[0] = i;
			for (uint32_t j = i + 1; j < msgN; j++) {
				discIdxs[1] = j;
				for (uint32_t k = j + 1; k < msgN; k++) {
					discIdxs[2] = k;
					checkProof(pub, sig, msgs, discIdxs, discN);
					ccheckProof(&cpub, &csig, msgs, discIdxs, discN);
				}
			}
		}
	}
	puts("disclose all");
	{
		const uint32_t discN = msgN;
		for (uint32_t i = 0; i < discN; i++) discIdxs[i] = i;
		checkProof(pub, sig, msgs, discIdxs, discN);
		ccheckProof(&cpub, &csig, msgs, discIdxs, discN);
	}
}

typedef std::vector<mclBnFr> FrVec;

// scalars of the messages by messages_to_scalars of the spec
FrVec toFrVec(const Msgs& msgs)
{
	FrVec v(msgs.n());
	for (size_t i = 0; i < v.size(); i++) {
		const Bytes m = msgs.get(i);
		bbsMsgToFr(&v[i], m.data(), m.size());
	}
	return v;
}

FrVec selectFr(const FrVec& v, const uint32_t *idxs, size_t n)
{
	FrVec r(n);
	for (size_t i = 0; i < n; i++) r[i] = v[idxs[i]];
	return r;
}

// the functions for scalar messages are equivalent to the functions for octet strings
CYBOZU_TEST_AUTO(fr_api)
{
	bbsSecretKey sec;
	bbsPublicKey pub;
	setSecretKey(sec, g_secHex);
	setPublicKey(pub, g_pubHex);
	const Bytes header = fromHex(g_headerHex);
	const Bytes ph = fromHex(g_phHex);
	const Msgs msgs = getMsgs();
	const FrVec ms = toFrVec(msgs);
	const uint32_t n = msgs.n();

	bbsSignature sig;
	CYBOZU_TEST_ASSERT(bbsSignFr(&sig, &sec, &pub, header.data(), header.size(), ms.data(), n));
	CYBOZU_TEST_EQUAL(toHex(sig), g_sigMultiHex);
	CYBOZU_TEST_ASSERT(bbsVerifyFr(&sig, &pub, header.data(), header.size(), ms.data(), n));
	CYBOZU_TEST_ASSERT(bbsVerify(&sig, &pub, header.data(), header.size(), msgs.p(), msgs.sizes(), n));
	CYBOZU_TEST_ASSERT(!bbsVerifyFr(&sig, &pub, header.data(), header.size(), ms.data(), n - 1));
	CYBOZU_TEST_ASSERT(!bbsVerifyFr(&sig, &pub, 0, 0, ms.data(), n));
	{
		FrVec wrong = ms;
		bbsUint64ToFr(&wrong[3], 5);
		CYBOZU_TEST_ASSERT(!bbsVerifyFr(&sig, &pub, header.data(), header.size(), wrong.data(), n));
	}
	CYBOZU_TEST_ASSERT(!bbsSignFr(&sig, &sec, &pub, 0, 0, ms.data(), uint32_t(maxMsgN) + 1));

	const uint32_t discIdxs[] = { 0, 2, 4, 6 };
	const uint32_t discN = CYBOZU_NUM_OF_ARRAY(discIdxs);
	const Msgs discMsgs = msgs.select(discIdxs, discN);
	const FrVec discMs = selectFr(ms, discIdxs, discN);
	Bytes proof(bbsGetProofSize(n - discN));
	// Fr -> octets
	CYBOZU_TEST_EQUAL(bbsProofGenFr(proof.data(), proof.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), ms.data(), n, discIdxs, discN), proof.size());
	CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
	CYBOZU_TEST_ASSERT(bbsProofVerifyFr(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMs.data(), discIdxs, discN));
	// octets -> Fr
	CYBOZU_TEST_EQUAL(bbsProofGen(proof.data(), proof.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), msgs.p(), msgs.sizes(), n, discIdxs, discN), proof.size());
	CYBOZU_TEST_ASSERT(bbsProofVerifyFr(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMs.data(), discIdxs, discN));
	{
		FrVec wrong = discMs;
		wrong[1] = ms[1];
		CYBOZU_TEST_ASSERT(!bbsProofVerifyFr(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), wrong.data(), discIdxs, discN));
	}
	// the proof of the spec (8.4.5.3)
	const Bytes specProof = fromHex("a2ed608e8e12ed21abc2bf154e462d744a367c7f1f969bdbf784a2a134c7db2d340394223a5397a3011b1c340ebc415199462ba6f31106d8a6da8b513b37a47afe93c9b3474d0d7a354b2edc1b88818b063332df774c141f7a07c48fe50d452f897739228c88afc797916dca01e8f03bd9c5375c7a7c59996e514bb952a436afd24457658acbaba5ddac2e693ac481356918cd38025d86b28650e909defe9604a7259f44386b861608be742af7775a2e71a6070e5836f5f54dc43c60096834a5b6da295bf8f081f72b7cdf7f3b4347fb3ff19edaa9e74055c8ba46dbcb7594fb2b06633bb5324192eb9be91be0d33e453b4d3127459de59a5e2193c900816f049a02cb9127dac894418105fa1641d5a206ec9c42177af9316f433417441478276ca0303da8f941bf2e0222a43251cf5c2bf6eac1961890aa740534e519c1767e1223392a3a286b0f4d91f7f25217a7862b8fcc1810cdcfddde2a01c80fcc90b632585fec12dc4ae8fea1918e9ddeb9414623a457e88f53f545841f9d5dcb1f8e160d1560770aa79d65e2eca8edeaecb73fb7e995608b820c4a64de6313a370ba05dc25ed7c1d185192084963652f2870341bdaa4b1a37f8c06348f38a4f80c5a2650a21d59f09e8305dcd3fc3ac30e2a");
	CYBOZU_TEST_ASSERT(bbsProofVerifyFr(&pub, specProof.data(), specProof.size(), header.data(), header.size(), ph.data(), ph.size(), discMs.data(), discIdxs, discN));
}

/*
	tests of the extension (range predicates for undisclosed integer messages)
	messages : [ "abc", v[0], ..., v[intN-1], "xyz" ] where v[i] are integers (the index of v[i] is i + 1)
*/
struct PredTest {
	bbsSecretKey sec;
	bbsPublicKey pub;
	bbsSignature sig;
	FrVec ms;
	Bytes header;
	Bytes ph;
	PredTest(uint64_t m1, uint64_t m2)
	{
		const uint64_t v[] = { m1, m2 };
		init(v, 2);
	}
	PredTest(const uint64_t *v, size_t intN)
	{
		init(v, intN);
	}
	void init(const uint64_t *v, size_t intN)
	{
		ms.resize(intN + 2);
		CYBOZU_TEST_ASSERT(bbsInitSecretKey(&sec));
		CYBOZU_TEST_ASSERT(bbsGetPublicKey(&pub, &sec));
		const uint8_t abc[] = { 'a', 'b', 'c' };
		const uint8_t xyz[] = { 'x', 'y', 'z' };
		bbsMsgToFr(&ms[0], abc, sizeof(abc));
		for (size_t i = 0; i < intN; i++) {
			bbsUint64ToFr(&ms[i + 1], v[i]);
		}
		bbsMsgToFr(&ms[intN + 1], xyz, sizeof(xyz));
		header = fromHex(g_headerHex);
		ph = fromHex(g_phHex);
		CYBOZU_TEST_ASSERT(bbsSignFr(&sig, &sec, &pub, header.data(), header.size(), ms.data(), n()));
	}
	uint32_t n() const { return uint32_t(ms.size()); }
	// return an empty array if the proof can not be generated
	Bytes gen(const uint32_t *discIdxs, uint32_t discN, const bbsPredicate *preds, uint32_t predN) const
	{
		Bytes proof(bbsGetProofSize(n() - discN) + 144 * 64 * predN + 80 * predN);
		const size_t size = bbsProofGenEx(proof.data(), proof.size(), &pub, &sig, header.data(), header.size(), ph.data(), ph.size(), ms.data(), n(), discIdxs, discN, preds, predN);
		if (size > 0) {
			CYBOZU_TEST_EQUAL(size, bbsGetProofExSize(n() - discN, preds, predN));
		}
		proof.resize(size);
		return proof;
	}
	bool verify(const Bytes& proof, const uint32_t *discIdxs, uint32_t discN, const bbsPredicate *preds, uint32_t predN) const
	{
		const FrVec discMs = selectFr(ms, discIdxs, discN);
		return bbsProofVerifyEx(&pub, proof.data(), proof.size(), header.data(), header.size(), ph.data(), ph.size(), discMs.data(), discIdxs, discN, preds, predN);
	}
};

// predicate for the linear combination sum coefs[k] * msgs[idxs[k]]
bbsPredicate makeLinPred(const uint32_t *idxs, const uint32_t *coefs, uint32_t termN, uint32_t type, uint64_t bound, uint32_t bitN)
{
	bbsPredicate p;
	memset(&p, 0, sizeof(p));
	p.bound = bound;
	for (uint32_t k = 0; k < termN; k++) {
		p.idx[k] = idxs[k];
		p.coef[k] = coefs[k];
	}
	p.termN = termN;
	p.type = type;
	p.bitN = bitN;
	return p;
}

// predicate for a single message msgs[idx]
bbsPredicate makePred(uint32_t idx, uint32_t type, uint64_t bound, uint32_t bitN)
{
	const uint32_t coef = 1;
	return makeLinPred(&idx, &coef, 1, type, bound, bitN);
}

CYBOZU_TEST_AUTO(pred_range)
{
	CYBOZU_TEST_EQUAL(sizeof(bbsPredicate), 88u);
	const uint64_t M = uint64_t(-1);
	const struct {
		uint64_t m;
		uint32_t type;
		uint64_t bound;
		uint32_t bitN;
		bool ok;
	} tbl[] = {
		// 0 <= m - bound < 2^bitN
		{ 100, BBS_PRED_GE, 100, 1, true },
		{ 101, BBS_PRED_GE, 100, 1, true },
		{ 102, BBS_PRED_GE, 100, 1, false },
		{ 99, BBS_PRED_GE, 100, 1, false },
		{ 99, BBS_PRED_GE, 100, 64, false },
		{ 355, BBS_PRED_GE, 100, 8, true },
		{ 356, BBS_PRED_GE, 100, 8, false },
		{ 65535, BBS_PRED_GE, 0, 16, true },
		{ 65536, BBS_PRED_GE, 0, 16, false },
		{ 0, BBS_PRED_GE, 0, 16, true },
		{ 0, BBS_PRED_GE, 1, 16, false },
		{ M, BBS_PRED_GE, 0, 64, true },
		{ M, BBS_PRED_GE, M, 1, true },
		{ M, BBS_PRED_GE, 0, 63, false },
		{ 0, BBS_PRED_GE, 0, 64, true },
		// 0 <= bound - m < 2^bitN
		{ 100, BBS_PRED_LE, 100, 1, true },
		{ 99, BBS_PRED_LE, 100, 1, true },
		{ 98, BBS_PRED_LE, 100, 1, false },
		{ 101, BBS_PRED_LE, 100, 1, false },
		{ 101, BBS_PRED_LE, 100, 64, false },
		{ 0, BBS_PRED_LE, 255, 8, true },
		{ 0, BBS_PRED_LE, 256, 8, false },
		{ 0, BBS_PRED_LE, M, 64, true },
		{ M, BBS_PRED_LE, M, 64, true },
		{ 1, BBS_PRED_LE, M, 63, false },
		// birthday as YYYYMMDD is not later than 2008/10/01
		{ 19900415, BBS_PRED_LE, 20081001, 25, true },
		{ 20081001, BBS_PRED_LE, 20081001, 25, true },
		{ 20081002, BBS_PRED_LE, 20081001, 25, false },
	};
	const uint32_t discIdxs[] = { 0 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const PredTest t(tbl[i].m, 7);
		const bbsPredicate pred = makePred(1, tbl[i].type, tbl[i].bound, tbl[i].bitN);
		const Bytes proof = t.gen(discIdxs, 1, &pred, 1);
		CYBOZU_TEST_EQUAL(!proof.empty(), tbl[i].ok);
		if (proof.empty()) continue;
		CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(3) + 80 + 144 * tbl[i].bitN - 48);
		CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, 1, &pred, 1));
		// a different statement
		bbsPredicate wrong = pred;
		wrong.bound++;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, 1, &wrong, 1));
		wrong = pred;
		wrong.bound--;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, 1, &wrong, 1));
		wrong = pred;
		wrong.type = pred.type == BBS_PRED_GE ? BBS_PRED_LE : BBS_PRED_GE;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, 1, &wrong, 1));
		wrong = pred;
		wrong.idx[0] = 2;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, 1, &wrong, 1));
		wrong = pred;
		wrong.bitN = pred.bitN == 64 ? 63 : pred.bitN + 1;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, 1, &wrong, 1));
	}
}

CYBOZU_TEST_AUTO(pred_multi)
{
	// m1 = age, m2 = birthday
	const PredTest t(30, 19960320);
	const uint32_t discIdxs[] = { 3 };
	const uint32_t discN = 1;
	// 18 <= age <= 65 and 19000101 <= birthday <= 20081001
	const bbsPredicate preds[] = {
		makePred(1, BBS_PRED_GE, 18, 8),
		makePred(1, BBS_PRED_LE, 65, 8),
		makePred(2, BBS_PRED_GE, 19000101, 25),
		makePred(2, BBS_PRED_LE, 20081001, 25),
	};
	const uint32_t predN = CYBOZU_NUM_OF_ARRAY(preds);
	const Bytes proof = t.gen(discIdxs, discN, preds, predN);
	CYBOZU_TEST_ASSERT(!proof.empty());
	// 2 commitments and 66 bits
	CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(3) + 80 * 2 + 144 * (8 + 8 + 25 + 25) - 48 * 4);
	CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, preds, predN));
	// a subset or a different order of the predicates
	CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, preds, predN - 1));
	CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, preds + 1, predN - 1));
	{
		bbsPredicate swapped[predN];
		memcpy(swapped, preds, sizeof(preds));
		swapped[0] = preds[1];
		swapped[1] = preds[0];
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, swapped, predN));
	}
	// proofs are randomized
	{
		const Bytes proof2 = t.gen(discIdxs, discN, preds, predN);
		CYBOZU_TEST_EQUAL(proof2.size(), proof.size());
		CYBOZU_TEST_ASSERT(t.verify(proof2, discIdxs, discN, preds, predN));
		size_t same = 0;
		for (size_t i = 0; i + 32 <= proof.size(); i += 16) {
			if (memcmp(&proof[i], &proof2[i], 16) == 0) same++;
		}
		CYBOZU_TEST_EQUAL(same, 0u);
	}
	// disclose nothing
	{
		const Bytes proof2 = t.gen(0, 0, preds, predN);
		CYBOZU_TEST_ASSERT(!proof2.empty());
		CYBOZU_TEST_ASSERT(t.verify(proof2, 0, 0, preds, predN));
		CYBOZU_TEST_ASSERT(!t.verify(proof2, discIdxs, discN, preds, predN));
	}
	// one of the predicates does not hold
	{
		bbsPredicate wrong[predN];
		memcpy(wrong, preds, sizeof(preds));
		wrong[1].bound = 29;
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, wrong, predN).empty());
		wrong[1].bound = 30;
		CYBOZU_TEST_ASSERT(!t.gen(discIdxs, discN, wrong, predN).empty());
	}
	// the message of a predicate is not an integer (a hashed value)
	{
		const bbsPredicate p = makePred(0, BBS_PRED_GE, 0, 64);
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, &p, 1).empty());
	}
}

CYBOZU_TEST_AUTO(pred_invalid)
{
	const PredTest t(30, 19960320);
	const uint32_t discIdxs[] = { 0, 3 };
	const uint32_t discN = 2;
	const bbsPredicate pred = makePred(1, BBS_PRED_GE, 18, 4);
	const Bytes proof = t.gen(discIdxs, discN, &pred, 1);
	CYBOZU_TEST_ASSERT(!proof.empty());
	CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(2) + 80 + 144 * 4 - 48);
	CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, &pred, 1));
	const FrVec discMs = selectFr(t.ms, discIdxs, discN);

	// it is not a proof without predicates
	CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, 0, 0));
	CYBOZU_TEST_ASSERT(!bbsProofVerifyFr(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), t.ph.data(), t.ph.size(), discMs.data(), discIdxs, discN));
	// wrong presentation header, header, public key, disclosed message
	CYBOZU_TEST_ASSERT(!bbsProofVerifyEx(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), t.ph.data(), t.ph.size() - 1, discMs.data(), discIdxs, discN, &pred, 1));
	CYBOZU_TEST_ASSERT(!bbsProofVerifyEx(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), 0, 0, discMs.data(), discIdxs, discN, &pred, 1));
	CYBOZU_TEST_ASSERT(!bbsProofVerifyEx(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size() - 1, t.ph.data(), t.ph.size(), discMs.data(), discIdxs, discN, &pred, 1));
	{
		bbsPublicKey wrongPub;
		setPublicKey(wrongPub, g_wrongPubHex);
		CYBOZU_TEST_ASSERT(!bbsProofVerifyEx(&wrongPub, proof.data(), proof.size(), t.header.data(), t.header.size(), t.ph.data(), t.ph.size(), discMs.data(), discIdxs, discN, &pred, 1));
		FrVec wrong = discMs;
		wrong[0] = t.ms[2];
		CYBOZU_TEST_ASSERT(!bbsProofVerifyEx(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), t.ph.data(), t.ph.size(), wrong.data(), discIdxs, discN, &pred, 1));
	}
	// bad size
	{
		Bytes tmp = proof;
		tmp.pop_back();
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
		tmp = proof;
		tmp.resize(proof.size() + 32);
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
		tmp.resize(proof.size() - 32);
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
		tmp.resize(100);
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
		tmp.clear();
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
		// small buffer
		tmp.resize(proof.size() - 1);
		CYBOZU_TEST_EQUAL(bbsProofGenEx(tmp.data(), tmp.size(), &t.pub, &t.sig, t.header.data(), t.header.size(), t.ph.data(), t.ph.size(), t.ms.data(), t.n(), discIdxs, discN, &pred, 1), 0u);
	}
	// modify each byte of the proof
	for (size_t i = 0; i < proof.size(); i++) {
		Bytes tmp = proof;
		tmp[i] ^= 1;
		CYBOZU_TEST_ASSERT(!t.verify(tmp, discIdxs, discN, &pred, 1));
	}
	// invalid predicates
	{
		const bbsPredicate disclosed = makePred(0, BBS_PRED_GE, 18, 4);
		const bbsPredicate outOfRange = makePred(4, BBS_PRED_GE, 18, 4);
		const bbsPredicate bit0 = makePred(1, BBS_PRED_GE, 18, 0);
		const bbsPredicate bit65 = makePred(1, BBS_PRED_GE, 18, 65);
		const bbsPredicate badType = makePred(1, 2, 18, 4);
		bbsPredicate reserved = pred;
		reserved.reserved = 1;
		const bbsPredicate *tbl[] = { &disclosed, &outOfRange, &bit0, &bit65, &badType, &reserved };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, tbl[i], 1).empty());
			CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, tbl[i], 1));
		}
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(2, &bit0, 1), 0u);
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(2, &bit65, 1), 0u);
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(2, &badType, 1), 0u);
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(2, &reserved, 1), 0u);
		// not sorted by idx
		const bbsPredicate notSorted[] = { makePred(2, BBS_PRED_GE, 0, 32), makePred(1, BBS_PRED_GE, 18, 4) };
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(2, notSorted, 2), 0u);
		CYBOZU_TEST_ASSERT(t.gen(0, 0, notSorted, 2).empty());
		const bbsPredicate sorted[] = { notSorted[1], notSorted[0] };
		const Bytes proof2 = t.gen(0, 0, sorted, 2);
		CYBOZU_TEST_ASSERT(!proof2.empty());
		CYBOZU_TEST_ASSERT(t.verify(proof2, 0, 0, sorted, 2));
		CYBOZU_TEST_ASSERT(!t.verify(proof2, 0, 0, notSorted, 2));
	}
}

// predicates for linear combinations of undisclosed integer messages
CYBOZU_TEST_AUTO(pred_lincomb)
{
	// year, month, day, age (idx 1, 2, 3, 4). "abc" is 0 and "xyz" is 5
	const uint64_t v[] = { 1996, 3, 20, 30 };
	const PredTest t(v, CYBOZU_NUM_OF_ARRAY(v));
	const uint32_t discIdxs[] = { 0, 5 };
	const uint32_t discN = 2;
	const uint32_t undiscN = t.n() - discN;
	// the birthday is x = 512 * year + 32 * month + day, which preserves the order of the dates
	const uint32_t idxs[] = { 1, 2, 3 };
	const uint32_t coefs[] = { 512, 32, 1 };
	const uint64_t birth = 512 * 1996 + 32 * 3 + 20;
	const uint64_t bound = 512 * 2008 + 32 * 10 + 1; // 2008/10/01
	// birthday <= 2008/10/01 (18 years old or older on 2026/10/01)
	{
		bbsPredicate p = makeLinPred(idxs, coefs, 3, BBS_PRED_LE, bound, 17);
		const Bytes proof = t.gen(discIdxs, discN, &p, 1);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(undiscN) + 80 + 144 * 17 - 48);
		CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, &p, 1));
		// a different linear combination
		bbsPredicate w = p;
		w.coef[1] = 33;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, &w, 1));
		w = p;
		w.idx[2] = 4;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, &w, 1));
		w = p;
		w.termN = 2;
		w.idx[2] = 0;
		w.coef[2] = 0;
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, &w, 1));
		// the boundary
		p.bound = birth;
		CYBOZU_TEST_ASSERT(!t.gen(discIdxs, discN, &p, 1).empty());
		p.bound = birth - 1;
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, &p, 1).empty());
	}
	// birthday >= bound
	{
		bbsPredicate p = makeLinPred(idxs, coefs, 3, BBS_PRED_GE, birth, 17);
		const Bytes proof = t.gen(discIdxs, discN, &p, 1);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, &p, 1));
		p.bound = birth + 1;
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, &p, 1).empty());
	}
	// two predicates on the same linear combination share the commitment
	{
		const bbsPredicate preds[] = {
			makeLinPred(idxs, coefs, 3, BBS_PRED_GE, birth - 100, 17),
			makeLinPred(idxs, coefs, 3, BBS_PRED_LE, bound, 17),
		};
		const Bytes proof = t.gen(discIdxs, discN, preds, 2);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(undiscN) + 80 + (144 * 17 - 48) * 2);
		CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, preds, 2));
		// the same linear combination may be in any order, but the proof depends on the order
		const bbsPredicate swapped[] = { preds[1], preds[0] };
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, swapped, 2));
		const Bytes proof2 = t.gen(discIdxs, discN, swapped, 2);
		CYBOZU_TEST_ASSERT(!proof2.empty());
		CYBOZU_TEST_ASSERT(t.verify(proof2, discIdxs, discN, swapped, 2));
	}
	// different linear combinations have their own commitments. 18 <= age and birthday <= bound
	{
		const bbsPredicate preds[] = {
			makePred(4, BBS_PRED_GE, 18, 8), // termN = 1 comes first
			makeLinPred(idxs, coefs, 3, BBS_PRED_LE, bound, 17),
		};
		const Bytes proof = t.gen(discIdxs, discN, preds, 2);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(undiscN) + 80 * 2 + (144 * 8 - 48) + (144 * 17 - 48));
		CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, preds, 2));
		// not sorted
		const bbsPredicate notSorted[] = { preds[1], preds[0] };
		CYBOZU_TEST_EQUAL(bbsGetProofExSize(undiscN, notSorted, 2), 0u);
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, notSorted, 2).empty());
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, notSorted, 2));
	}
	// invalid predicates
	{
		const bbsPredicate p = makeLinPred(idxs, coefs, 3, BBS_PRED_LE, bound, 17);
		const Bytes proof = t.gen(discIdxs, discN, &p, 1);
		CYBOZU_TEST_ASSERT(!proof.empty());
		bbsPredicate termN0 = p;
		termN0.termN = 0;
		bbsPredicate termN9 = p;
		termN9.termN = BBS_PRED_MAX_TERM + 1;
		bbsPredicate coef0 = p;
		coef0.coef[0] = 0;
		bbsPredicate sameIdx = p;
		sameIdx.idx[1] = 1;
		bbsPredicate notIncreasing = p;
		notIncreasing.idx[0] = 2;
		notIncreasing.idx[1] = 1;
		bbsPredicate unusedCoef = p;
		unusedCoef.coef[3] = 1;
		bbsPredicate unusedIdx = p;
		unusedIdx.idx[3] = 1;
		const bbsPredicate *tbl[] = { &termN0, &termN9, &coef0, &sameIdx, &notIncreasing, &unusedCoef, &unusedIdx };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			CYBOZU_TEST_EQUAL(bbsGetProofExSize(undiscN, tbl[i], 1), 0u);
			CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, tbl[i], 1).empty());
			CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, tbl[i], 1));
		}
		// a term of a disclosed message or an out-of-range index
		const uint32_t disclosedIdxs[] = { 0, 1 };
		const uint32_t outOfRangeIdxs[] = { 1, 6 };
		const uint32_t coefs2[] = { 1, 1 };
		const bbsPredicate disclosed = makeLinPred(disclosedIdxs, coefs2, 2, BBS_PRED_GE, 0, 8);
		const bbsPredicate outOfRange = makeLinPred(outOfRangeIdxs, coefs2, 2, BBS_PRED_GE, 0, 8);
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, &disclosed, 1).empty());
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, &disclosed, 1));
		CYBOZU_TEST_ASSERT(t.gen(discIdxs, discN, &outOfRange, 1).empty());
		CYBOZU_TEST_ASSERT(!t.verify(proof, discIdxs, discN, &outOfRange, 1));
	}
	// the linear combination may exceed 2^64
	{
		const uint64_t M = uint64_t(-1);
		const uint64_t v2[] = { M, M };
		const PredTest t2(v2, 2);
		const uint32_t idxs2[] = { 1, 2 };
		const uint32_t coefs2[] = { 1, 1 };
		const uint32_t discIdxs2[] = { 0, 3 };
		// x = 2^65 - 2, x - M = M < 2^64
		bbsPredicate p = makeLinPred(idxs2, coefs2, 2, BBS_PRED_GE, M, 64);
		const Bytes proof = t2.gen(discIdxs2, 2, &p, 1);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_ASSERT(t2.verify(proof, discIdxs2, 2, &p, 1));
		p.bitN = 63;
		CYBOZU_TEST_ASSERT(t2.gen(discIdxs2, 2, &p, 1).empty());
		// x - 0 >= 2^64 can not be proven
		p.bound = 0;
		p.bitN = 64;
		CYBOZU_TEST_ASSERT(t2.gen(discIdxs2, 2, &p, 1).empty());
	}
	// the max number of terms with the max coefficients
	{
		uint64_t v8[BBS_PRED_MAX_TERM];
		uint32_t idxs8[BBS_PRED_MAX_TERM];
		uint32_t coefs8[BBS_PRED_MAX_TERM];
		uint64_t x = 0;
		for (size_t i = 0; i < BBS_PRED_MAX_TERM; i++) {
			v8[i] = i + 1;
			idxs8[i] = uint32_t(i + 1);
			coefs8[i] = 0xffffffff;
			x += coefs8[i] * v8[i];
		}
		const PredTest t8(v8, BBS_PRED_MAX_TERM);
		const uint32_t discIdxs8[] = { 0, BBS_PRED_MAX_TERM + 1 };
		const bbsPredicate preds[] = {
			makeLinPred(idxs8, coefs8, BBS_PRED_MAX_TERM, BBS_PRED_GE, x, 1),
			makeLinPred(idxs8, coefs8, BBS_PRED_MAX_TERM, BBS_PRED_LE, x, 1),
		};
		const Bytes proof = t8.gen(discIdxs8, 2, preds, 2);
		CYBOZU_TEST_ASSERT(!proof.empty());
		CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(BBS_PRED_MAX_TERM) + 80 + (144 * 1 - 48) * 2);
		CYBOZU_TEST_ASSERT(t8.verify(proof, discIdxs8, 2, preds, 2));
		bbsPredicate p = preds[0];
		p.bound = x + 1;
		CYBOZU_TEST_ASSERT(t8.gen(discIdxs8, 2, &p, 1).empty());
	}
}

// the first part of a proof is a proof of the spec whose presentation header is ph'
/*
	regression test which fixes the byte sequence of the extended proof
	A deterministic RNG is injected so that the key and the proof are reproducible.
	The digest must not change by refactoring the range proof.
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

CYBOZU_TEST_AUTO(pred_fixed)
{
	SplitMix64 rg(12345);
	mcl::fp::RandGen::setRandFunc(&rg, SplitMix64::read);
	const PredTest t(30, 19960320);
	const uint32_t discIdxs[] = { 3 };
	const uint32_t discN = 1;
	const bbsPredicate preds[] = {
		makePred(1, BBS_PRED_GE, 18, 8),
		makePred(1, BBS_PRED_LE, 65, 8),
		makePred(2, BBS_PRED_LE, 20081001, 25),
	};
	const uint32_t predN = CYBOZU_NUM_OF_ARRAY(preds);
	const Bytes proof = t.gen(discIdxs, discN, preds, predN);
	mcl::fp::RandGen::setRandFunc(0, 0);
	CYBOZU_TEST_ASSERT(!proof.empty());
	CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, preds, predN));
	uint8_t md[32];
	cybozu::Sha256().digest(md, sizeof(md), proof.data(), proof.size());
	CYBOZU_TEST_EQUAL(toHex(t.pub), "81469dc235325fad0a889de3d37731f7fd9b1f0bf5fe389e1b9a8ea8a68f0f18e15cef9c3b955fed50962fd6ac6e489416f11453ddec138c33cc53467c8c3eda043f7bafdaa6acf5943c3f53cde2d323050679184969928d612ea5247e48e4b3");
	CYBOZU_TEST_EQUAL(toHex(md, sizeof(md)), "491cb6e2520d4c017ce3a2bd024fe5bd80805ec9172b9dae88573d162fe149c2");
}

CYBOZU_TEST_AUTO(pred_none)
{
	const PredTest t(30, 19960320);
	const uint32_t discIdxs[] = { 0, 3 };
	const uint32_t discN = 2;
	const Bytes proof = t.gen(discIdxs, discN, 0, 0);
	CYBOZU_TEST_EQUAL(proof.size(), bbsGetProofSize(2));
	CYBOZU_TEST_ASSERT(t.verify(proof, discIdxs, discN, 0, 0));
	const FrVec discMs = selectFr(t.ms, discIdxs, discN);
	CYBOZU_TEST_ASSERT(!bbsProofVerifyFr(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), t.ph.data(), t.ph.size(), discMs.data(), discIdxs, discN));
	// ph' = "BBS_EXT_V1_" || I2OSP(0, 8) || I2OSP(0, 8) || I2OSP(phSize, 8) || ph
	const char tag[] = "BBS_EXT_V1_";
	Bytes phEx(tag, tag + strlen(tag));
	phEx.resize(phEx.size() + 8 * 3);
	phEx[phEx.size() - 1] = uint8_t(t.ph.size());
	phEx.insert(phEx.end(), t.ph.begin(), t.ph.end());
	CYBOZU_TEST_ASSERT(bbsProofVerifyFr(&t.pub, proof.data(), proof.size(), t.header.data(), t.header.size(), phEx.data(), phEx.size(), discMs.data(), discIdxs, discN));
}

CYBOZU_TEST_AUTO(pred_bench)
{
	const PredTest t(19900415, 7);
	const uint32_t discIdxs[] = { 0 };
	const uint32_t bitTbl[] = { 8, 16, 25, 32, 64 };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(bitTbl); i++) {
		// m - bound = 100
		const bbsPredicate pred = makePred(1, BBS_PRED_GE, 19900415 - 100, bitTbl[i]);
		const int N = 20;
		Bytes proof;
		clock_t begin = clock();
		for (int j = 0; j < N; j++) proof = t.gen(discIdxs, 1, &pred, 1);
		const double genMs = double(clock() - begin) / CLOCKS_PER_SEC / N * 1e3;
		CYBOZU_TEST_ASSERT(!proof.empty());
		begin = clock();
		bool ok = true;
		for (int j = 0; j < N; j++) ok = ok && t.verify(proof, discIdxs, 1, &pred, 1);
		const double verifyMs = double(clock() - begin) / CLOCKS_PER_SEC / N * 1e3;
		CYBOZU_TEST_ASSERT(ok);
		printf("bitN=%2u size=%5zd gen=%6.2f msec verify=%6.2f msec\n", bitTbl[i], proof.size(), genMs, verifyMs);
	}
	{
		// a proof without predicates for comparison
		const FrVec discMs = selectFr(t.ms, discIdxs, 1);
		Bytes proof(bbsGetProofSize(3));
		const int N = 20;
		clock_t begin = clock();
		for (int j = 0; j < N; j++) bbsProofGenFr(proof.data(), proof.size(), &t.pub, &t.sig, 0, 0, 0, 0, t.ms.data(), t.n(), discIdxs, 1);
		const double genMs = double(clock() - begin) / CLOCKS_PER_SEC / N * 1e3;
		// the signature has a header, so this proof is invalid but the cost is the same
		begin = clock();
		for (int j = 0; j < N; j++) bbsProofVerifyFr(&t.pub, proof.data(), proof.size(), 0, 0, 0, 0, discMs.data(), discIdxs, 1);
		const double verifyMs = double(clock() - begin) / CLOCKS_PER_SEC / N * 1e3;
		printf("no pred size=%5zd gen=%6.2f msec verify=%6.2f msec\n", proof.size(), genMs, verifyMs);
	}
}

/*
	fixed values to compare with the output of wasm (test/test.ts)
*/
CYBOZU_TEST_AUTO(fixed)
{
	bbsSecretKey sec;
	bbsPublicKey pub;
	bbsSignature sig;
	const char *secHex = "6528255759bb6c2c64fed04877398200f67642bddb8bfe200690db6a30487811";
	setSecretKey(sec, secHex);
	CYBOZU_TEST_ASSERT(bbsGetPublicKey(&pub, &sec));
	printf("sec=%s\n", toHex(sec).c_str());
	printf("pub=%s\n", toHex(pub).c_str());

	const char *msgTbl[] = {
		"v", "kbv", "qnmnq", "vbkvhwm", "ez", "vttv", "zemwhv", "k", "bvq", "nmnqv"
	};
	Msgs msgs;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(msgTbl); i++) {
		msgs.add(Bytes(msgTbl[i], msgTbl[i] + strlen(msgTbl[i])));
	}
	const uint8_t header[] = { 'h', 'e', 'a', 'd', 'e', 'r' };
	CYBOZU_TEST_ASSERT(bbsSign(&sig, &sec, &pub, header, sizeof(header), msgs.p(), msgs.sizes(), msgs.n()));
	printf("sig=%s\n", toHex(sig).c_str());
	// test/test.ts has the same values
	CYBOZU_TEST_EQUAL(toHex(pub), "b06e2a39e47c4fc65cf1d51dd181b793a57ebc4a3dc35bb8245c804ecc9b39effd5516c260ba463bafc1a1e002da9cba17f35c0d1b4c0518779d134cbd1b967996cc3f3de4c8e9a20c8c1db8f759439f16c995a9d25e861cb4eee282d9a2d085");
	CYBOZU_TEST_EQUAL(toHex(sig), "8db34eb67d85d70022d5875a02ea095a7035481d1bacbbf37d2e68c321b4e9165f2390bb688b642e7327fcc5ef59aae82b49108ed81da5e66818ab4e95c75dd5e896855fb2ab6e9104f7b6a05b804a50");

	const uint32_t discIdxs[] = { 1, 4, 5 };
	const uint32_t discN = CYBOZU_NUM_OF_ARRAY(discIdxs);
	const uint8_t ph[] = { 9, 0x11, 0x22 };
	Bytes proof(bbsGetProofSize(msgs.n() - discN));
	CYBOZU_TEST_EQUAL(bbsProofGen(proof.data(), proof.size(), &pub, &sig, header, sizeof(header), ph, sizeof(ph), msgs.p(), msgs.sizes(), msgs.n(), discIdxs, discN), proof.size());
	const Msgs discMsgs = msgs.select(discIdxs, discN);
	CYBOZU_TEST_ASSERT(bbsProofVerify(&pub, proof.data(), proof.size(), header, sizeof(header), ph, sizeof(ph), discMsgs.p(), discMsgs.sizes(), discIdxs, discN));
}

CYBOZU_TEST_AUTO(term)
{
	bbsTerm();
	bbsTerm();
}
