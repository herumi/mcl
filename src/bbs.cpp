/*
	BBS signature (draft-irtf-cfrg-bbs-signatures-12)
	ciphersuite : BLS12-381-SHA-256
*/
#define CYBOZU_DONT_USE_OPENSSL
#include <mcl/bls12_381.hpp>
#include <mcl/array.hpp>
#include <mcl/sigma_protocol.hpp>
#include <cybozu/endian.hpp>
#include <stdlib.h>
#include <string.h>
#include <mcl/bbs.hpp>
#include <mcl/bbs.h>
#include "cast.hpp"

using namespace mcl;
using namespace bbs;

static const size_t FR_SIZE = 32; // octet_scalar_length
static const size_t G1_SIZE = 48; // octet_point_length
static const size_t G2_SIZE = 96;
static const size_t EXPAND_LEN = 48; // expand_len
static const size_t MAX_DST_SIZE = 255;
static const size_t MAX_KEY_INFO_SIZE = 65535;
static const size_t MIN_KEY_MATERIAL_SIZE = 32;
// Abar, Bbar, D, e^, r1^, r3^, c
static const size_t FIXED_PROOF_SIZE = G1_SIZE * 3 + FR_SIZE * 4;
// r1, r2, e~, r1~, r3~
static const size_t FIXED_RANDOM_SCALAR_N = 5;

#define BBS_CIPHERSUITE_ID "BBS_BLS12381G1_XMD:SHA-256_SSWU_RO_"
// api_id = ciphersuite_id || "H2G_HM2S_"
#define BBS_API_ID BBS_CIPHERSUITE_ID "H2G_HM2S_"

struct Str {
	const char *p;
	size_t size;
};
#define BBS_STR(s) { s, sizeof(s) - 1 }

static const Str s_apiId = BBS_STR(BBS_API_ID);
static const Str s_keyGenDst = BBS_STR(BBS_CIPHERSUITE_ID "KEYGEN_DST_");
static const Str s_h2sDst = BBS_STR(BBS_API_ID "H2S_");
static const Str s_mapDst = BBS_STR(BBS_API_ID "MAP_MSG_TO_SCALAR_AS_HASH_");
// api_id of the generators (Y_0, Y_1) for the commitments of the extension
static const Str s_comDisApiId = BBS_STR("COM_DIS_" BBS_API_ID);
// prefix of the extended presentation header
static const Str s_extTag = BBS_STR("BBS_EXT_V1_");
static const size_t MAX_PRED_BIT = 64;
static const size_t MAX_PRED_N = 4096;

// P1 of BLS12-381-SHA-256
static const char s_P1Hex[] = "a8ce256102840821a3e94ea9025e4662b205762f9776b3a766c872b948f1fd225e7c59698588e70d11406d161b4e28c9";
// the base point of G2 of BLS12-381
static const char s_BP2Hex[] = "93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8";

static int s_cipherSuite = -1;
static size_t s_maxMsgN;
// s_gen[0] = Q_1, s_gen[1 + i] = H_(i+1). All points are normalized.
static G1 *s_gen;
// the number of the computed generators
static size_t s_genN;
// the intermediate value v of create_generators to extend s_gen
static uint8_t s_genV[EXPAND_LEN];
static G1 s_P1;
static G2 s_BP2;
// (Y_0, Y_1) = create_generators(2, "COM_DIS_" || api_id). Both points are normalized.
static G1 s_Y[2];

inline SecretKey *cast(bbsSecretKey *p) { return reinterpret_cast<SecretKey*>(p); }
inline const SecretKey *cast(const bbsSecretKey *p) { return reinterpret_cast<const SecretKey*>(p); }
inline PublicKey *cast(bbsPublicKey *p) { return reinterpret_cast<PublicKey*>(p); }
inline const PublicKey *cast(const bbsPublicKey *p) { return reinterpret_cast<const PublicKey*>(p); }
inline Signature *cast(bbsSignature *p) { return reinterpret_cast<Signature*>(p); }
inline const Signature *cast(const bbsSignature *p) { return reinterpret_cast<const Signature*>(p); }

// octet string builder
struct Octets {
	// the buffer may hold secret data, so it is cleared before it is released
	Array<uint8_t, true> buf_;
	size_t pos_;
	Octets() : pos_(0) {}
	// allocate maxSize bytes
	bool init(size_t maxSize)
	{
		pos_ = 0;
		return buf_.resize(maxSize);
	}
	const uint8_t *data() const { return buf_.data(); }
	size_t size() const { return pos_; }
	void put(const void *p, size_t n)
	{
		assert(pos_ + n <= buf_.size());
		if (n == 0) return;
		memcpy(buf_.data() + pos_, p, n);
		pos_ += n;
	}
	// I2OSP(v, 8)
	void putInt(uint64_t v)
	{
		uint8_t a[8];
		cybozu::Set64bitAsBE(a, v);
		put(a, sizeof(a));
	}
	template<class T>
	void putT(const T& x, size_t size)
	{
		assert(pos_ + size <= buf_.size());
		size_t n = x.serialize(buf_.data() + pos_, size);
		assert(n == size); (void)n;
		pos_ += size;
	}
	void put(const Fr& x) { putT(x, FR_SIZE); }
	void put(const G1& x) { putT(x, G1_SIZE); }
	void put(const G2& x) { putT(x, G2_SIZE); }
};

inline bool isInitialized()
{
	return s_gen != 0;
}

inline bool isValidMsgN(size_t msgN)
{
	return isInitialized() && msgN <= s_maxMsgN;
}

// x = OS2IP(get_random(expand_len)) mod r. retry if x is zero.
static bool setRandomScalar(Fr& x)
{
	uint8_t buf[EXPAND_LEN];
	for (int i = 0; i < 16; i++) {
		bool b;
		fp::RandGen::get().read(&b, buf, sizeof(buf));
		if (!b) return false;
		x.setBigEndianMod(&b, buf, sizeof(buf));
		secureZero(buf, sizeof(buf));
		if (!b) return false;
		if (!x.isZero()) return true;
	}
	return false;
}

// out = a || b. return the size of out or 0 if it is larger than MAX_DST_SIZE
template<size_t N>
size_t concatStr(char out[MAX_DST_SIZE], const Str& a, const char (&b)[N])
{
	const size_t bSize = N - 1;
	if (a.size + bSize > MAX_DST_SIZE) return 0;
	memcpy(out, a.p, a.size);
	memcpy(out + a.size, b, bSize);
	return a.size + bSize;
}

/*
	create_generators of the spec
	compute gen[begin], ..., gen[end - 1] for apiId
	v is the intermediate value of the spec. It is initialized if begin is zero.
*/
static bool createGenerators(G1 *gen, size_t begin, size_t end, uint8_t v[EXPAND_LEN], const Str& apiId)
{
	char seedDst[MAX_DST_SIZE];
	char generatorDst[MAX_DST_SIZE];
	char generatorSeed[MAX_DST_SIZE];
	const size_t seedDstSize = concatStr(seedDst, apiId, "SIG_GENERATOR_SEED_");
	const size_t generatorDstSize = concatStr(generatorDst, apiId, "SIG_GENERATOR_DST_");
	const size_t generatorSeedSize = concatStr(generatorSeed, apiId, "MESSAGE_GENERATOR_SEED");
	if (seedDstSize == 0 || generatorDstSize == 0 || generatorSeedSize == 0) return false;
	if (begin == 0) {
		fp::expand_message_xmd(v, EXPAND_LEN, generatorSeed, generatorSeedSize, seedDst, seedDstSize);
	}
	for (size_t i = begin; i < end; i++) {
		// v = expand_message(v || I2OSP(i + 1, 8), seed_dst, expand_len)
		uint8_t buf[EXPAND_LEN + 8];
		memcpy(buf, v, EXPAND_LEN);
		cybozu::Set64bitAsBE(buf + EXPAND_LEN, uint64_t(i + 1));
		fp::expand_message_xmd(v, EXPAND_LEN, buf, sizeof(buf), seedDst, seedDstSize);
		hashAndMapToG1(gen[i], v, EXPAND_LEN, generatorDst, generatorDstSize);
		gen[i].normalize();
	}
	return true;
}

// extend s_gen to n generators
static bool extendGenerators(size_t n)
{
	if (n <= s_genN) return true;
	G1 *p = (G1*)realloc((void*)s_gen, sizeof(G1) * n);
	if (p == 0) return false;
	s_gen = p;
	if (!createGenerators(s_gen, s_genN, n, s_genV, s_apiId)) return false;
	s_genN = n;
	return true;
}

// messages_to_scalars of the spec
// x: Fr array of size msgN.
// msgs: concatenation of all msg[i]. The size is a sum of msgSize[i].
// msgSize: array of size msgN. msgSize[i] is the size of msg[i].
inline void msgsToFr(Fr *x, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN)
{
	for (size_t i = 0; i < msgN; i++) {
		bbs::local::msgToFr(x[i], msgs, msgSize[i]);
		msgs += msgSize[i];
	}
}

/*
	calculate_domain of the spec
	domain = hash_to_scalar(PK || L || Q_1 || H_1 || ... || H_L || api_id || I2OSP(headerSize, 8) || header)
*/
static bool calcDomain(Fr& domain, const G2& pk, size_t L, const uint8_t *header, size_t headerSize)
{
	Octets os;
	if (!os.init(G2_SIZE + 8 + G1_SIZE * (L + 1) + s_apiId.size + 8 + headerSize)) return false;
	os.put(pk);
	os.putInt(L);
	for (size_t i = 0; i < L + 1; i++) {
		os.put(s_gen[i]);
	}
	os.put(s_apiId.p, s_apiId.size);
	os.putInt(headerSize);
	os.put(header, headerSize);
	bbs::local::hashToScalar(domain, os.data(), os.size(), s_h2sDst.p, s_h2sDst.size);
	return true;
}

// B = P1 + Q_1 * v[0] + H_1 * v[1] + ... + H_L * v[L]
// v[0] is domain and v[1 + i] is the scalar of msg[i]
inline void calcB(G1& B, const Fr *v, size_t L)
{
	G1::mulVec(B, s_gen, v, L + 1);
	B += s_P1;
}

// true if all discIdxs[i] < discIdxs[i+1] < msgN
inline bool isValidDiscIdx(size_t msgN, const uint32_t *discIdxs, size_t discN)
{
	if (discN == 0) return true;
	if (discIdxs[0] >= msgN) return false;
	for (size_t i = 1; i < discN; i++) {
		if (!(discIdxs[i - 1] < discIdxs[i]) || discIdxs[i] >= msgN) return false;
	}
	return true;
}

// return e(P1, Q1) * e(P2, Q2) == 1
inline bool isPairingProductOne(const G1& P1, const G2& Q1, const G1& P2, const G2& Q2)
{
	G1 v1[2] = { P1, P2 };
	G2 v2[2] = { Q1, Q2 };
	GT out;
	millerLoopVec(out, v1, v2, 2);
	finalExp(out, out);
	return out.isOne();
}

/*
	ProofChallengeCalculate of the spec
	c = hash_to_scalar(serialize(R, i1, msg_i1, ..., iR, msg_iR, Abar, Bbar, D, T1, T2, domain) || I2OSP(phSize, 8) || ph)
	msgs is the array of the disclosed messages if isDisclosed else the array of all messages
*/
static bool calcChallenge(Fr& c, const G1& Abar, const G1& Bbar, const G1& D, const G1& T1, const G1& T2, const Fr& domain, const uint32_t *discIdxs, size_t discN, const Fr *msgs, bool isDisclosed, const uint8_t *ph, size_t phSize)
{
	Octets os;
	if (!os.init(8 + (8 + FR_SIZE) * discN + G1_SIZE * 5 + FR_SIZE + 8 + phSize)) return false;
	os.putInt(discN);
	for (size_t i = 0; i < discN; i++) {
		os.putInt(discIdxs[i]);
		os.put(isDisclosed ? msgs[i] : msgs[discIdxs[i]]);
	}
	os.put(Abar);
	os.put(Bbar);
	os.put(D);
	os.put(T1);
	os.put(T2);
	os.put(domain);
	os.putInt(phSize);
	os.put(ph, phSize);
	bbs::local::hashToScalar(c, os.data(), os.size(), s_h2sDst.p, s_h2sDst.size);
	return true;
}

// out += sum_{i=0}^{n-1} H_(selectedIdx[i]+1) * v[i]
static bool addSelectedMulVec(G1& out, const uint32_t *selectedIdx, size_t n, const Fr *v)
{
	if (n == 0) return true;
	Array<G1> H;
	if (!H.resize(n)) return false;
	for (size_t i = 0; i < n; i++) H[i] = s_gen[1 + selectedIdx[i]];
	G1 T;
	G1::mulVec(T, H.data(), v, n);
	out += T;
	return true;
}

// deserialize a point of G1 which is not the identity
inline bool getG1(G1& P, const uint8_t *buf)
{
	return P.deserialize(buf, G1_SIZE) == G1_SIZE && !P.isZero();
}

// deserialize a scalar in [1, r-1]
inline bool getFr(Fr& x, const uint8_t *buf)
{
	return x.deserialize(buf, FR_SIZE) == FR_SIZE && !x.isZero();
}

// fill rs[0..n) with random scalars
static bool setRandomScalars(Array<Fr, true>& rs, size_t n)
{
	if (!rs.resize(n)) return false;
	for (size_t i = 0; i < n; i++) {
		if (!setRandomScalar(rs[i])) return false;
	}
	return true;
}

/*
	CoreSign of the spec
	domain = calculate_domain(PK, Q_1, (H_1, ..., H_L), header, api_id)
	e = hash_to_scalar(serialize((SK, msg_1, ..., msg_L, domain)))
	B = P1 + Q_1 * domain + H_1 * msg_1 + ... + H_L * msg_L
	A = B * (1 / (SK + e))
	return (A, e)
*/
static bool coreSign(G1& A, Fr& e, const Fr& sk, const G2& W, const uint8_t *header, size_t headerSize, const Fr *msgs, size_t L)
{
	if (!isValidMsgN(L)) return false;
	if (sk.isZero()) return false;

	// x[0] = domain, x[1 + i] = msgs[i]
	Array<Fr, true> x;
	if (!x.resize(L + 1)) return false;
	for (size_t i = 0; i < L; i++) x[1 + i] = msgs[i];
	if (!calcDomain(x[0], W, L, header, headerSize)) return false;

	{
		Octets os;
		if (!os.init(FR_SIZE * (L + 2))) return false;
		os.put(sk);
		for (size_t i = 0; i < L; i++) {
			os.put(x[1 + i]);
		}
		os.put(x[0]);
		bbs::local::hashToScalar(e, os.data(), os.size(), s_h2sDst.p, s_h2sDst.size);
	}
	if (e.isZero()) return false;
	G1 B;
	calcB(B, x.data(), L);
	Fr t;
	Fr::add(t, sk, e);
	if (t.isZero()) return false;
	Fr::inv(t, t);
	G1::mulCT(A, B, t);
	secureZero(&t, sizeof(t));
	return !A.isZero();
}

/*
	CoreVerify of the spec
	B = P1 + Q_1 * domain + H_1 * msg_1 + ... + H_L * msg_L
	e(A, W) * e(A * e - B, BP2) == 1
*/
static bool coreVerify(const G1& A, const Fr& e, const G2& W, const uint8_t *header, size_t headerSize, const Fr *msgs, size_t L)
{
	if (!isValidMsgN(L)) return false;
	if (A.isZero() || e.isZero() || W.isZero()) return false;

	// x[0] = domain, x[1 + i] = msgs[i]
	Array<Fr> x;
	if (!x.resize(L + 1)) return false;
	for (size_t i = 0; i < L; i++) x[1 + i] = msgs[i];
	if (!calcDomain(x[0], W, L, header, headerSize)) return false;

	G1 B;
	calcB(B, x.data(), L);
	G1 T;
	G1::mul(T, A, e);
	T -= B;
	return isPairingProductOne(A, W, T, s_BP2);
}

/*
	CoreProofGen of the spec
	(r1, r2, e~, r1~, r3~, m~_1, ..., m~_U) = rs
*/
static size_t coreProofGen(uint8_t *proof, size_t maxProofSize, const G2& W, const G1& A, const Fr& e, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *msgs, size_t L, const uint32_t *discIdxs, size_t discN, const Fr *rs)
{
	if (!isValidMsgN(L)) return 0;
	if (discN > L) return 0;
	const size_t U = L - discN;
	const size_t proofSize = getProofSize(U);
	if (maxProofSize < proofSize) return 0;
	if (!isValidDiscIdx(L, discIdxs, discN)) return 0;
	if (A.isZero() || e.isZero() || W.isZero()) return 0;

	const Fr& r1 = rs[0];
	const Fr& r2 = rs[1];
	const Fr& e_tilde = rs[2];
	const Fr& r1_tilde = rs[3];
	const Fr& r3_tilde = rs[4];
	const Fr *m_tilde = rs + FIXED_RANDOM_SCALAR_N;
	if (r1.isZero() || r2.isZero()) return 0;

	// v[0] = domain, v[1 + i] = msgs[i]
	// the scalars of the undisclosed messages are secret
	Array<Fr, true> v;
	Array<uint32_t> js;
	if (!v.resize(L + 1) || !js.resize(U)) return 0;
	for (size_t i = 0; i < L; i++) v[1 + i] = msgs[i];
	if (!calcDomain(v[0], W, L, header, headerSize)) return 0;
	const Fr& domain = v[0];
	const Fr *m = v.data() + 1;
	bbs::local::setJs(js.data(), U, discIdxs, discN);

	// ProofInit
	G1 B;
	calcB(B, v.data(), L);
	G1 D = B * r2;
	G1 Abar = A * (r1 * r2);
	G1 Bbar = D * r1 - Abar * e;
	G1 T1 = Abar * e_tilde + D * r1_tilde;
	G1 T2 = D * r3_tilde;
	if (!addSelectedMulVec(T2, js.data(), U, m_tilde)) return 0;

	Fr c;
	if (!calcChallenge(c, Abar, Bbar, D, T1, T2, domain, discIdxs, discN, m, false, ph, phSize)) return 0;

	// ProofFinalize
	Fr r3;
	Fr::inv(r3, r2);
	const Fr e_hat = e_tilde + e * c;
	const Fr r1_hat = r1_tilde - r1 * c;
	const Fr r3_hat = r3_tilde - r3 * c;

	// proof = (Abar, Bbar, D, e^, r1^, r3^, m^_1, ..., m^_U, c)
	uint8_t *p = proof;
	const G1 *G1tbl[] = { &Abar, &Bbar, &D };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(G1tbl); i++) {
		if (G1tbl[i]->serialize(p, G1_SIZE) != G1_SIZE) return 0;
		p += G1_SIZE;
	}
	const Fr *Frtbl[] = { &e_hat, &r1_hat, &r3_hat };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(Frtbl); i++) {
		if (Frtbl[i]->serialize(p, FR_SIZE) != FR_SIZE) return 0;
		p += FR_SIZE;
	}
	for (size_t i = 0; i < U; i++) {
		const Fr m_hat = m_tilde[i] + m[js[i]] * c;
		if (m_hat.serialize(p, FR_SIZE) != FR_SIZE) return 0;
		p += FR_SIZE;
	}
	if (c.serialize(p, FR_SIZE) != FR_SIZE) return 0;
	return proofSize;
}

/*
	CoreProofVerify of the spec
	(Abar, Bbar, D, e^, r1^, r3^, (m^_1, ..., m^_U), c) = proof
	T1 = Bbar * c + Abar * e^ + D * r1^
	Bv = P1 + Q_1 * domain + sum_{i in disclosed} H_i * msg_i
	T2 = Bv * c + D * r3^ + sum_{j in undisclosed} H_j * m^_j
	c == challenge and e(Abar, W) * e(Bbar, -BP2) == 1
*/
static bool coreProofVerify(const G2& W, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *discMsgs, const uint32_t *discIdxs, size_t discN)
{
	if (!isInitialized()) return false;
	if (proofSize < FIXED_PROOF_SIZE) return false;
	if ((proofSize - FIXED_PROOF_SIZE) % FR_SIZE) return false;
	const size_t U = (proofSize - FIXED_PROOF_SIZE) / FR_SIZE;
	const size_t R = discN;
	// L = U + R <= s_maxMsgN
	if (U > s_maxMsgN || R > s_maxMsgN - U) return false;
	const size_t L = U + R;
	if (!isValidDiscIdx(L, discIdxs, R)) return false;
	if (W.isZero()) return false;

	// octets_to_proof
	G1 Abar, Bbar, D;
	Fr e_hat, r1_hat, r3_hat, c;
	Array<Fr> m_hat;
	if (!m_hat.resize(U)) return false;
	const uint8_t *p = proof;
	G1 *G1tbl[] = { &Abar, &Bbar, &D };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(G1tbl); i++) {
		if (!getG1(*G1tbl[i], p)) return false;
		p += G1_SIZE;
	}
	Fr *Frtbl[] = { &e_hat, &r1_hat, &r3_hat };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(Frtbl); i++) {
		if (!getFr(*Frtbl[i], p)) return false;
		p += FR_SIZE;
	}
	for (size_t i = 0; i < U; i++) {
		if (!getFr(m_hat[i], p)) return false;
		p += FR_SIZE;
	}
	if (!getFr(c, p)) return false;

	Fr domain;
	Array<uint32_t> js;
	if (!js.resize(U)) return false;
	if (!calcDomain(domain, W, L, header, headerSize)) return false;
	bbs::local::setJs(js.data(), U, discIdxs, R);

	// ProofVerifyInit
	G1 T1 = Bbar * c + Abar * e_hat + D * r1_hat;
	G1 Bv = s_P1 + s_gen[0] * domain;
	if (!addSelectedMulVec(Bv, discIdxs, R, discMsgs)) return false;
	G1 T2 = Bv * c + D * r3_hat;
	if (!addSelectedMulVec(T2, js.data(), U, m_hat.data())) return false;

	Fr c2;
	if (!calcChallenge(c2, Abar, Bbar, D, T1, T2, domain, discIdxs, R, discMsgs, true, ph, phSize)) return false;
	if (c2 != c) return false;
	// e(Abar, W) * e(Bbar, -BP2) = e(Abar, W) * e(-Bbar, BP2)
	G1 negBbar;
	G1::neg(negBbar, Bbar);
	return isPairingProductOne(Abar, W, negBbar, s_BP2);
}

/*
	extension which is not defined in the spec
	proof with range predicates for undisclosed integer messages
*/
inline void setUint64(Fr& x, uint64_t v)
{
	bool b;
	x.setArray(&b, &v, 1);
	assert(b); (void)b;
}

/*
	check the predicates
	- sorted by idx in ascending order
	- type is BBS_PRED_GE or BBS_PRED_LE, 1 <= bitN <= MAX_PRED_BIT and reserved is 0
	*pK : the number of the distinct idx
	*pBitN : the sum of bitN
*/
static bool checkPreds(size_t *pK, size_t *pBitN, const bbsPredicate *preds, size_t predN)
{
	if (predN > MAX_PRED_N) return false;
	size_t K = 0;
	size_t bitN = 0;
	for (size_t i = 0; i < predN; i++) {
		const bbsPredicate& p = preds[i];
		if (p.type != BBS_PRED_GE && p.type != BBS_PRED_LE) return false;
		if (p.bitN == 0 || p.bitN > MAX_PRED_BIT) return false;
		if (p.reserved != 0) return false;
		if (i == 0 || preds[i - 1].idx != p.idx) {
			if (i > 0 && preds[i - 1].idx > p.idx) return false;
			K++;
		}
		bitN += p.bitN;
	}
	*pK = K;
	*pBitN = bitN;
	return true;
}

/*
	size of the extended part of a proof
	(C, s^) for each commitment
	(E_1, ..., E_(n-1)) and (c_0, z_0, z_1) for each bit for each predicate of n bits
*/
inline size_t getExtSize(size_t K, size_t bitN, size_t predN)
{
	return (G1_SIZE + FR_SIZE) * K + G1_SIZE * (bitN - predN) + FR_SIZE * 3 * bitN;
}

// return the position of idx in the sorted array js[0..n) or n if not found
static size_t findIdx(const uint32_t *js, size_t n, uint32_t idx)
{
	size_t lo = 0;
	size_t hi = n;
	while (lo < hi) {
		const size_t mid = lo + (hi - lo) / 2;
		if (js[mid] < idx) {
			lo = mid + 1;
		} else {
			hi = mid;
		}
	}
	return (lo < n && js[lo] == idx) ? lo : n;
}

/*
	public values and the first messages of the sigma protocols of the extension
	They are bound to the challenge of the BBS proof through the presentation header.
*/
struct ExtTranscript {
	Array<uint32_t> cidx; // idx of the committed messages
	Array<G1> C; // C = Y_0 * s + Y_1 * m
	Array<G1> Ct; // C~ = Y_0 * s~ + Y_1 * m~
	// for all bits of all predicates
	Array<G1> E; // E = Y_0 * t + Y_1 * bit
	Array<G1> a0; // the first message of the OR-proof for bit = 0
	Array<G1> a1; // the first message of the OR-proof for bit = 1
	bool init(size_t K, size_t bitN)
	{
		return cidx.resize(K) && C.resize(K) && Ct.resize(K) && E.resize(bitN) && a0.resize(bitN) && a1.resize(bitN);
	}
	/*
		ph' = tag || K || (idx, C, C~) * K || predN || (idx, type, bound, bitN, E * bitN, (a0, a1) * bitN) * predN || I2OSP(phSize, 8) || ph
	*/
	bool makePh(Octets& os, const bbsPredicate *preds, size_t predN, const uint8_t *ph, size_t phSize) const
	{
		const size_t K = cidx.size();
		const size_t bitN = E.size();
		if (!os.init(s_extTag.size + 8 + (8 + G1_SIZE * 2) * K + 8 + 8 * 4 * predN + G1_SIZE * 3 * bitN + 8 + phSize)) return false;
		os.put(s_extTag.p, s_extTag.size);
		os.putInt(K);
		for (size_t i = 0; i < K; i++) {
			os.putInt(cidx[i]);
			os.put(C[i]);
			os.put(Ct[i]);
		}
		os.putInt(predN);
		size_t pos = 0;
		for (size_t i = 0; i < predN; i++) {
			const bbsPredicate& p = preds[i];
			os.putInt(p.idx);
			os.putInt(p.type);
			os.putInt(p.bound);
			os.putInt(p.bitN);
			for (size_t j = 0; j < p.bitN; j++) {
				os.put(E[pos + j]);
			}
			for (size_t j = 0; j < p.bitN; j++) {
				os.put(a0[pos + j]);
				os.put(a1[pos + j]);
			}
			pos += p.bitN;
		}
		os.putInt(phSize);
		os.put(ph, phSize);
		return true;
	}
};

// Cw = C - Y_1 * bound if GE, Y_1 * bound - C if LE
// Cw is a commitment to w = m - bound or bound - m
inline void calcCw(G1& Cw, const G1& C, const bbsPredicate& p)
{
	Fr bound;
	setUint64(bound, p.bound);
	G1 T;
	G1::mul(T, s_Y[1], bound);
	if (p.type == BBS_PRED_GE) {
		G1::sub(Cw, C, T);
	} else {
		G1::sub(Cw, T, C);
	}
}

namespace bbs {

namespace local {

void setJs(uint32_t *js, size_t undiscN, const uint32_t *discIdxs, size_t discN)
{
	const size_t msgN = undiscN + discN;
	uint32_t v = 0;
	size_t dPos = 0;
	size_t next = dPos < discN ? discIdxs[dPos++]: msgN;

	size_t jPos = 0;
	while (jPos < undiscN) {
		if (v < next) {
			js[jPos++] = v;
		} else {
			next = dPos < discN ? discIdxs[dPos++]: msgN;
		}
		v++;
	}
}

void hashToScalar(Fr& out, const void *msg, size_t msgSize, const void *dst, size_t dstSize)
{
	uint8_t md[EXPAND_LEN];
	fp::expand_message_xmd(md, sizeof(md), msg, msgSize, dst, dstSize);
	bool b;
	out.setBigEndianMod(&b, md, sizeof(md));
	assert(b); (void)b;
	secureZero(md, sizeof(md));
}

void msgToFr(Fr& out, const uint8_t *msg, size_t msgSize)
{
	hashToScalar(out, msg, msgSize, s_mapDst.p, s_mapDst.size);
}

const G1 *getGenerators()
{
	return s_gen;
}

size_t proofGenWithRandomScalars(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN, const uint32_t *discIdxs, size_t discN, const Fr *rs)
{
	if (!isValidMsgN(msgN)) return 0;
	Array<Fr, true> x;
	if (!x.resize(msgN)) return 0;
	msgsToFr(x.data(), msgs, msgSize, msgN);
	return coreProofGen(proof, maxProofSize, pub.get_v(), sig.get_A(), sig.get_e(), header, headerSize, ph, phSize, x.data(), msgN, discIdxs, discN, rs);
}

} // bbs::local

bool init(int cipherSuite, size_t maxMsgN)
{
	if (cipherSuite != BBS_BLS12381_SHA256) return false;
	if (maxMsgN >= 0xffffffff) return false;
	if (s_cipherSuite != cipherSuite) {
		term();
		bool b;
		initPairing(&b, BLS12_381);
		if (!b) return false;
		Fp::setETHserialization(true);
		Fr::setETHserialization(true);
		setMapToMode(MCL_MAP_TO_MODE_HASH_TO_CURVE);
		verifyOrderG1(true);
		verifyOrderG2(true);
		s_P1.setStr(&b, s_P1Hex, IoSerializeHexStr);
		if (!b) return false;
		s_BP2.setStr(&b, s_BP2Hex, IoSerializeHexStr);
		if (!b) return false;
		uint8_t v[EXPAND_LEN];
		if (!createGenerators(s_Y, 0, 2, v, s_comDisApiId)) return false;
		s_cipherSuite = cipherSuite;
	}
	if (!extendGenerators(maxMsgN + 1)) return false;
	s_maxMsgN = maxMsgN;
	return true;
}

void term()
{
	free(s_gen);
	s_gen = 0;
	s_genN = 0;
	s_maxMsgN = 0;
	s_cipherSuite = -1;
}

bool SecretKey::init()
{
	if (!isInitialized()) return false;
	return setRandomScalar(*cast(&v.v));
}

/*
	KeyGen of the spec
	SK = hash_to_scalar(key_material || I2OSP(length(key_info), 2) || key_info, key_dst)
*/
bool SecretKey::keyGen(const uint8_t *keyMaterial, size_t keyMaterialSize, const uint8_t *keyInfo, size_t keyInfoSize, const uint8_t *keyDst, size_t keyDstSize)
{
	if (!isInitialized()) return false;
	if (keyMaterialSize < MIN_KEY_MATERIAL_SIZE) return false;
	if (keyInfoSize > MAX_KEY_INFO_SIZE) return false;
	if (keyDst == 0) {
		keyDst = (const uint8_t*)s_keyGenDst.p;
		keyDstSize = s_keyGenDst.size;
	}
	if (keyDstSize > MAX_DST_SIZE) return false;
	Octets os;
	if (!os.init(keyMaterialSize + 2 + keyInfoSize)) return false;
	os.put(keyMaterial, keyMaterialSize);
	uint8_t lenBuf[2];
	cybozu::Set16bitAsBE(lenBuf, uint16_t(keyInfoSize));
	os.put(lenBuf, sizeof(lenBuf));
	os.put(keyInfo, keyInfoSize);
	Fr& x = *cast(&v.v);
	bbs::local::hashToScalar(x, os.data(), os.size(), keyDst, keyDstSize);
	return !x.isZero();
}

void SecretKey::getPublicKey(PublicKey& pub) const
{
	G2::mulCT(*cast(&pub.v.v), s_BP2, *cast(&v.v));
}

const Fr& SecretKey::get_v() const
{
	return *cast(&v.v);
}

const G2& PublicKey::get_v() const
{
	return *cast(&v.v);
}

const G1& Signature::get_A() const
{
	return *cast(&v.A);
}

const Fr& Signature::get_e() const
{
	return *cast(&v.e);
}

bool Signature::sign(const SecretKey& sec, const PublicKey& pub, const uint8_t *header, size_t headerSize, const Fr *msgs, size_t msgN)
{
	G1 A;
	Fr e;
	if (!coreSign(A, e, sec.get_v(), pub.get_v(), header, headerSize, msgs, msgN)) return false;
	*cast(&v.A) = A;
	*cast(&v.e) = e;
	return true;
}

bool Signature::sign(const SecretKey& sec, const PublicKey& pub, const uint8_t *header, size_t headerSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN)
{
	if (!isValidMsgN(msgN)) return false;
	Array<Fr, true> x;
	if (!x.resize(msgN)) return false;
	msgsToFr(x.data(), msgs, msgSize, msgN);
	return sign(sec, pub, header, headerSize, x.data(), msgN);
}

bool Signature::verify(const PublicKey& pub, const uint8_t *header, size_t headerSize, const Fr *msgs, size_t msgN) const
{
	return coreVerify(get_A(), get_e(), pub.get_v(), header, headerSize, msgs, msgN);
}

bool Signature::verify(const PublicKey& pub, const uint8_t *header, size_t headerSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN) const
{
	if (!isValidMsgN(msgN)) return false;
	Array<Fr> x;
	if (!x.resize(msgN)) return false;
	msgsToFr(x.data(), msgs, msgSize, msgN);
	return verify(pub, header, headerSize, x.data(), msgN);
}

size_t getProofSize(size_t undiscN)
{
	return FIXED_PROOF_SIZE + FR_SIZE * undiscN;
}

size_t proofGen(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *msgs, size_t msgN, const uint32_t *discIdxs, size_t discN)
{
	if (!isValidMsgN(msgN)) return 0;
	if (discN > msgN) return 0;
	// calculate_random_scalars(5 + U)
	Array<Fr, true> rs;
	if (!setRandomScalars(rs, FIXED_RANDOM_SCALAR_N + (msgN - discN))) return 0;
	return coreProofGen(proof, maxProofSize, pub.get_v(), sig.get_A(), sig.get_e(), header, headerSize, ph, phSize, msgs, msgN, discIdxs, discN, rs.data());
}

size_t proofGen(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN, const uint32_t *discIdxs, size_t discN)
{
	if (!isValidMsgN(msgN)) return 0;
	Array<Fr, true> x;
	if (!x.resize(msgN)) return 0;
	msgsToFr(x.data(), msgs, msgSize, msgN);
	return proofGen(proof, maxProofSize, pub, sig, header, headerSize, ph, phSize, x.data(), msgN, discIdxs, discN);
}

bool proofVerify(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *discMsgs, const uint32_t *discIdxs, size_t discN)
{
	return coreProofVerify(pub.get_v(), proof, proofSize, header, headerSize, ph, phSize, discMsgs, discIdxs, discN);
}

bool proofVerify(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *discMsgs, const uint32_t *discMsgSize, const uint32_t *discIdxs, size_t discN)
{
	if (!isValidMsgN(discN)) return false;
	Array<Fr> x;
	if (!x.resize(discN)) return false;
	msgsToFr(x.data(), discMsgs, discMsgSize, discN);
	return proofVerify(pub, proof, proofSize, header, headerSize, ph, phSize, x.data(), discIdxs, discN);
}

size_t getProofExSize(size_t undiscN, const bbsPredicate *preds, size_t predN)
{
	size_t K, bitN;
	if (!checkPreds(&K, &bitN, preds, predN)) return 0;
	return getProofSize(undiscN) + getExtSize(K, bitN, predN);
}

/*
	the proof is
	(BBS proof with ph') || (C, s^) * K || ((E_1, ..., E_(n-1)), (c_0, z_0, z_1) * n) for each predicate
	see ExtTranscript::makePh for ph'
*/
size_t proofGenEx(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *msgs, size_t msgN, const uint32_t *discIdxs, size_t discN, const bbsPredicate *preds, size_t predN)
{
	if (!isValidMsgN(msgN)) return 0;
	if (discN > msgN) return 0;
	const size_t L = msgN;
	const size_t U = L - discN;
	size_t K, bitN;
	if (!checkPreds(&K, &bitN, preds, predN)) return 0;
	const size_t baseSize = getProofSize(U);
	const size_t proofSize = baseSize + getExtSize(K, bitN, predN);
	if (maxProofSize < proofSize) return 0;
	if (!isValidDiscIdx(L, discIdxs, discN)) return 0;
	Array<uint32_t> js;
	if (!js.resize(U)) return 0;
	local::setJs(js.data(), U, discIdxs, discN);

	ExtTranscript tr;
	if (!tr.init(K, bitN)) return 0;
	// random scalars of the BBS proof. m~ is shared with the commitments
	Array<Fr, true> rs;
	if (!setRandomScalars(rs, FIXED_RANDOM_SCALAR_N + U)) return 0;
	const Fr *m_tilde = rs.data() + FIXED_RANDOM_SCALAR_N;
	// s[k] and s~[k] for the k-th commitment
	Array<Fr, true> s, s_tilde;
	if (!setRandomScalars(s, K) || !setRandomScalars(s_tilde, K)) return 0;
	/*
		secrets for each bit
		bt : E = Y_0 * bt + Y_1 * bit
		bk : the random value of the real branch of the OR-proof
		bc, bz : the challenge and the response of the simulated branch
	*/
	Array<Fr, true> bt, bk, bc, bz;
	Array<uint8_t, true> bits;
	if (!bt.resize(bitN) || !setRandomScalars(bk, bitN) || !setRandomScalars(bc, bitN) || !setRandomScalars(bz, bitN) || !bits.resize(bitN)) return 0;
	// 2-way OR proof for each bit : E - bit * Y_1 = Y_0 * bt
	typedef sigma::BitOr<G1, Fr, 1> Or;
	const sigma::MulG<G1> Y0mul(s_Y[0]);
	const sigma::Bases1<G1, sigma::MulG<G1> > B(Y0mul);
	const G1 *const O[1] = { &s_Y[1] };

	size_t k = 0;
	size_t pos = 0;
	for (size_t i = 0; i < predN; i++) {
		const bbsPredicate& p = preds[i];
		if (i == 0 || preds[i - 1].idx != p.idx) {
			// a new commitment
			if (i > 0) k++;
			const size_t rank = findIdx(js.data(), U, p.idx);
			if (rank == U) return 0; // not an undisclosed message
			tr.cidx[k] = p.idx;
			tr.C[k] = s_Y[0] * s[k] + s_Y[1] * msgs[p.idx];
			tr.Ct[k] = s_Y[0] * s_tilde[k] + s_Y[1] * m_tilde[rank];
		}
		// w = m - bound or bound - m must be in [0, 2^n). sw is the random value of Cw
		const size_t n = p.bitN;
		Fr bound, w, sw;
		setUint64(bound, p.bound);
		if (p.type == BBS_PRED_GE) {
			w = msgs[p.idx] - bound;
			sw = s[k];
		} else {
			w = bound - msgs[p.idx];
			Fr::neg(sw, s[k]);
		}
		bool b;
		const uint64_t wv = w.getUint64(&b);
		secureZero(&w, sizeof(w));
		if (!b) return 0;
		if (n < 64 && (wv >> n) != 0) return 0;
		// sw = sum_{j=0}^{n-1} 2^j bt[j]
		{
			Fr sum, pow2;
			sum = 0;
			pow2 = 1;
			for (size_t j = 1; j < n; j++) {
				if (!setRandomScalar(bt[pos + j])) return 0;
				pow2 += pow2;
				sum += pow2 * bt[pos + j];
			}
			bt[pos] = sw - sum;
			secureZero(&sum, sizeof(sum));
		}
		secureZero(&sw, sizeof(sw));
		for (size_t j = 0; j < n; j++) {
			const size_t q = pos + j;
			const uint8_t bit = uint8_t((wv >> j) & 1);
			bits[q] = bit;
			G1& E = tr.E[q];
			G1::mul(E, s_Y[0], bt[q]);
			if (bit) E += s_Y[1];
			const G1 *const X[1] = { &E };
			G1 *const a[2] = { &tr.a0[q], &tr.a1[q] };
			// simulated branch for 1 - bit : a = Y_0 * bz - (E - Y_1 * (1 - bit)) * bc
			Or::simulate(a[1 - bit], B, X, O, 1 - bit, bc[q], bz[q]);
			// real branch : a = Y_0 * bk
			Or::commit(a[bit], B, bk[q]);
		}
		pos += n;
	}

	Octets phEx;
	if (!tr.makePh(phEx, preds, predN, ph, phSize)) return 0;
	if (coreProofGen(proof, baseSize, pub.get_v(), sig.get_A(), sig.get_e(), header, headerSize, phEx.data(), phEx.size(), msgs, L, discIdxs, discN, rs.data()) != baseSize) return 0;
	// the challenge is the last scalar of the BBS proof
	Fr c;
	if (!getFr(c, proof + baseSize - FR_SIZE)) return 0;

	uint8_t *out = proof + baseSize;
	for (size_t i = 0; i < K; i++) {
		if (tr.C[i].serialize(out, G1_SIZE) != G1_SIZE) return 0;
		out += G1_SIZE;
		const Fr s_hat = s_tilde[i] + c * s[i];
		if (s_hat.serialize(out, FR_SIZE) != FR_SIZE) return 0;
		out += FR_SIZE;
	}
	pos = 0;
	for (size_t i = 0; i < predN; i++) {
		const size_t n = preds[i].bitN;
		for (size_t j = 1; j < n; j++) {
			if (tr.E[pos + j].serialize(out, G1_SIZE) != G1_SIZE) return 0;
			out += G1_SIZE;
		}
		for (size_t j = 0; j < n; j++) {
			const size_t q = pos + j;
			// the challenge of the real branch is cr = c - bc and the response is zr = bk + cr * bt
			Fr cr, zr;
			Or::finish(cr, zr, c, bc[q], bk[q], bt[q]);
			const Fr *v[3]; // c_0, z_0, z_1
			if (bits[q] == 0) {
				v[0] = &cr;
				v[1] = &zr;
				v[2] = &bz[q];
			} else {
				v[0] = &bc[q];
				v[1] = &bz[q];
				v[2] = &zr;
			}
			for (size_t l = 0; l < 3; l++) {
				if (v[l]->serialize(out, FR_SIZE) != FR_SIZE) return 0;
				out += FR_SIZE;
			}
		}
		pos += n;
	}
	return proofSize;
}

bool proofVerifyEx(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const Fr *discMsgs, const uint32_t *discIdxs, size_t discN, const bbsPredicate *preds, size_t predN)
{
	if (!isInitialized()) return false;
	size_t K, bitN;
	if (!checkPreds(&K, &bitN, preds, predN)) return false;
	const size_t extSize = getExtSize(K, bitN, predN);
	if (proofSize < FIXED_PROOF_SIZE || proofSize - FIXED_PROOF_SIZE < extSize) return false;
	const size_t baseSize = proofSize - extSize;
	if ((baseSize - FIXED_PROOF_SIZE) % FR_SIZE) return false;
	const size_t U = (baseSize - FIXED_PROOF_SIZE) / FR_SIZE;
	const size_t R = discN;
	if (U > s_maxMsgN || R > s_maxMsgN - U) return false;
	const size_t L = U + R;
	if (!isValidDiscIdx(L, discIdxs, R)) return false;
	Array<uint32_t> js;
	if (!js.resize(U)) return false;
	local::setJs(js.data(), U, discIdxs, R);

	// the challenge and the responses m^ of the BBS proof
	Fr c;
	if (!getFr(c, proof + baseSize - FR_SIZE)) return false;
	const uint8_t *const m_hat_top = proof + G1_SIZE * 3 + FR_SIZE * 3;

	ExtTranscript tr;
	if (!tr.init(K, bitN)) return false;
	const uint8_t *in = proof + baseSize;
	// C~ = Y_0 * s^ + Y_1 * m^ - C * c
	{
		size_t k = 0;
		for (size_t i = 0; i < predN; i++) {
			const bbsPredicate& p = preds[i];
			if (i > 0 && preds[i - 1].idx == p.idx) continue;
			const size_t rank = findIdx(js.data(), U, p.idx);
			if (rank == U) return false; // not an undisclosed message
			Fr s_hat, m_hat;
			if (!getG1(tr.C[k], in)) return false;
			in += G1_SIZE;
			if (s_hat.deserialize(in, FR_SIZE) != FR_SIZE) return false;
			in += FR_SIZE;
			if (!getFr(m_hat, m_hat_top + FR_SIZE * rank)) return false;
			tr.cidx[k] = p.idx;
			tr.Ct[k] = s_Y[0] * s_hat + s_Y[1] * m_hat - tr.C[k] * c;
			k++;
		}
	}
	{
		size_t k = 0;
		size_t pos = 0;
		for (size_t i = 0; i < predN; i++) {
			const bbsPredicate& p = preds[i];
			if (i > 0 && preds[i - 1].idx != p.idx) k++;
			const size_t n = p.bitN;
			// E_0 = Cw - sum_{j=1}^{n-1} 2^j E_j
			G1 acc;
			acc.clear();
			for (size_t j = 1; j < n; j++) {
				if (!getG1(tr.E[pos + j], in)) return false;
				in += G1_SIZE;
			}
			for (size_t j = n - 1; j >= 1; j--) {
				acc += tr.E[pos + j];
				G1::dbl(acc, acc);
			}
			G1 Cw;
			calcCw(Cw, tr.C[k], p);
			G1::sub(tr.E[pos], Cw, acc);
			// a_0 = Y_0 * z_0 - E * c_0, a_1 = Y_0 * z_1 - (E - Y_1) * c_1 where c_1 = c - c_0
			typedef sigma::BitOr<G1, Fr, 1> Or;
			const sigma::MulG<G1> Y0mul(s_Y[0]);
			const sigma::Bases1<G1, sigma::MulG<G1> > B(Y0mul);
			const G1 *const O[1] = { &s_Y[1] };
			for (size_t j = 0; j < n; j++) {
				const size_t q = pos + j;
				Fr d[2], s[2]; // (c_0, c_1), (z_0, z_1)
				Fr *v[3] = { &d[0], &s[0], &s[1] };
				for (size_t l = 0; l < 3; l++) {
					if (v[l]->deserialize(in, FR_SIZE) != FR_SIZE) return false;
					in += FR_SIZE;
				}
				Fr::sub(d[1], c, d[0]);
				const G1 *const X[1] = { &tr.E[q] };
				G1 R[2][1];
				Or::recompute(R, B, X, O, d, s);
				tr.a0[q] = R[0][0];
				tr.a1[q] = R[1][0];
			}
			pos += n;
		}
	}
	Octets phEx;
	if (!tr.makePh(phEx, preds, predN, ph, phSize)) return false;
	// the challenge recomputed with ph' must be equal to c
	return coreProofVerify(pub.get_v(), proof, baseSize, header, headerSize, phEx.data(), phEx.size(), discMsgs, discIdxs, discN);
}

} // bbs

mclSize bbsSizeofSecretKey() { return sizeof(bbsSecretKey); }
mclSize bbsSizeofPublicKey() { return sizeof(bbsPublicKey); }
mclSize bbsSizeofSignature() { return sizeof(bbsSignature); }

mclSize bbsGetSecretKeySerializeByteSize() { return FR_SIZE; }
mclSize bbsGetPublicKeySerializeByteSize() { return G2_SIZE; }
mclSize bbsGetSignatureSerializeByteSize() { return G1_SIZE + FR_SIZE; }
mclSize bbsGetProofSize(uint32_t undiscN) { return bbs::getProofSize(undiscN); }

mclSize bbsDeserializeSecretKey(bbsSecretKey *x, const void *buf, mclSize bufSize)
{
	if (bufSize < FR_SIZE) return 0;
	Fr& v = *cast(&x->v);
	if (v.deserialize(buf, FR_SIZE) != FR_SIZE || v.isZero()) return 0;
	return FR_SIZE;
}

// octets_to_pubkey of the spec
mclSize bbsDeserializePublicKey(bbsPublicKey *x, const void *buf, mclSize bufSize)
{
	if (bufSize < G2_SIZE) return 0;
	G2& v = *cast(&x->v);
	if (v.deserialize(buf, G2_SIZE) != G2_SIZE || v.isZero()) return 0;
	return G2_SIZE;
}

// octets_to_signature of the spec
mclSize bbsDeserializeSignature(bbsSignature *x, const void *buf, mclSize bufSize)
{
	if (bufSize < G1_SIZE + FR_SIZE) return 0;
	const uint8_t *p = (const uint8_t*)buf;
	if (!getG1(*cast(&x->A), p)) return 0;
	if (!getFr(*cast(&x->e), p + G1_SIZE)) return 0;
	return G1_SIZE + FR_SIZE;
}

mclSize bbsSerializeSecretKey(void *buf, mclSize maxBufSize, const bbsSecretKey *x)
{
	return cast(&x->v)->serialize(buf, maxBufSize);
}

mclSize bbsSerializePublicKey(void *buf, mclSize maxBufSize, const bbsPublicKey *x)
{
	return cast(&x->v)->serialize(buf, maxBufSize);
}

// signature_to_octets of the spec
mclSize bbsSerializeSignature(void *buf, mclSize maxBufSize, const bbsSignature *x)
{
	if (maxBufSize < G1_SIZE + FR_SIZE) return 0;
	uint8_t *p = (uint8_t*)buf;
	if (cast(&x->A)->serialize(p, G1_SIZE) != G1_SIZE) return 0;
	if (cast(&x->e)->serialize(p + G1_SIZE, FR_SIZE) != FR_SIZE) return 0;
	return G1_SIZE + FR_SIZE;
}

bool bbsIsEqualSecretKey(const bbsSecretKey *lhs, const bbsSecretKey *rhs)
{
	return *cast(&lhs->v) == *cast(&rhs->v);
}

bool bbsIsEqualPublicKey(const bbsPublicKey *lhs, const bbsPublicKey *rhs)
{
	return *cast(&lhs->v) == *cast(&rhs->v);
}

bool bbsIsEqualSignature(const bbsSignature *lhs, const bbsSignature *rhs)
{
	return *cast(&lhs->A) == *cast(&rhs->A) && *cast(&lhs->e) == *cast(&rhs->e);
}

bool bbsInit(int cipherSuite, uint32_t maxMsgN)
{
	return bbs::init(cipherSuite, maxMsgN);
}

void bbsTerm()
{
	bbs::term();
}

bool bbsKeyGen(bbsSecretKey *sec, const uint8_t *keyMaterial, mclSize keyMaterialSize, const uint8_t *keyInfo, mclSize keyInfoSize, const uint8_t *keyDst, mclSize keyDstSize)
{
	return cast(sec)->keyGen(keyMaterial, keyMaterialSize, keyInfo, keyInfoSize, keyDst, keyDstSize);
}

bool bbsInitSecretKey(bbsSecretKey *sec)
{
	return cast(sec)->init();
}

bool bbsGetPublicKey(bbsPublicKey *pub, const bbsSecretKey *sec)
{
	if (!isInitialized()) return false;
	cast(sec)->getPublicKey(*cast(pub));
	return true;
}

bool bbsSign(bbsSignature *sig, const bbsSecretKey *sec, const bbsPublicKey *pub, const uint8_t *header, mclSize headerSize, const uint8_t *msgs, const uint32_t *msgSize, uint32_t msgN)
{
	return cast(sig)->sign(*cast(sec), *cast(pub), header, headerSize, msgs, msgSize, msgN);
}

bool bbsVerify(const bbsSignature *sig, const bbsPublicKey *pub, const uint8_t *header, mclSize headerSize, const uint8_t *msgs, const uint32_t *msgSize, uint32_t msgN)
{
	return cast(sig)->verify(*cast(pub), header, headerSize, msgs, msgSize, msgN);
}

mclSize bbsProofGen(uint8_t *proof, mclSize maxProofSize, const bbsPublicKey *pub, const bbsSignature *sig, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const uint8_t *msgs, const uint32_t *msgSize, uint32_t msgN, const uint32_t *discIdxs, uint32_t discN)
{
	return bbs::proofGen(proof, maxProofSize, *cast(pub), *cast(sig), header, headerSize, ph, phSize, msgs, msgSize, msgN, discIdxs, discN);
}

bool bbsProofVerify(const bbsPublicKey *pub, const uint8_t *proof, mclSize proofSize, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const uint8_t *discMsgs, const uint32_t *discMsgSize, const uint32_t *discIdxs, uint32_t discN)
{
	return bbs::proofVerify(*cast(pub), proof, proofSize, header, headerSize, ph, phSize, discMsgs, discMsgSize, discIdxs, discN);
}

void bbsMsgToFr(mclBnFr *x, const uint8_t *msg, mclSize msgSize)
{
	bbs::local::msgToFr(*cast(x), msg, msgSize);
}

void bbsUint64ToFr(mclBnFr *x, uint64_t v)
{
	setUint64(*cast(x), v);
}

bool bbsSignFr(bbsSignature *sig, const bbsSecretKey *sec, const bbsPublicKey *pub, const uint8_t *header, mclSize headerSize, const mclBnFr *msgs, uint32_t msgN)
{
	return cast(sig)->sign(*cast(sec), *cast(pub), header, headerSize, cast(msgs), msgN);
}

bool bbsVerifyFr(const bbsSignature *sig, const bbsPublicKey *pub, const uint8_t *header, mclSize headerSize, const mclBnFr *msgs, uint32_t msgN)
{
	return cast(sig)->verify(*cast(pub), header, headerSize, cast(msgs), msgN);
}

mclSize bbsProofGenFr(uint8_t *proof, mclSize maxProofSize, const bbsPublicKey *pub, const bbsSignature *sig, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const mclBnFr *msgs, uint32_t msgN, const uint32_t *discIdxs, uint32_t discN)
{
	return bbs::proofGen(proof, maxProofSize, *cast(pub), *cast(sig), header, headerSize, ph, phSize, cast(msgs), msgN, discIdxs, discN);
}

bool bbsProofVerifyFr(const bbsPublicKey *pub, const uint8_t *proof, mclSize proofSize, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const mclBnFr *discMsgs, const uint32_t *discIdxs, uint32_t discN)
{
	return bbs::proofVerify(*cast(pub), proof, proofSize, header, headerSize, ph, phSize, cast(discMsgs), discIdxs, discN);
}

mclSize bbsGetProofExSize(uint32_t undiscN, const bbsPredicate *preds, uint32_t predN)
{
	return bbs::getProofExSize(undiscN, preds, predN);
}

mclSize bbsProofGenEx(uint8_t *proof, mclSize maxProofSize, const bbsPublicKey *pub, const bbsSignature *sig, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const mclBnFr *msgs, uint32_t msgN, const uint32_t *discIdxs, uint32_t discN, const bbsPredicate *preds, uint32_t predN)
{
	return bbs::proofGenEx(proof, maxProofSize, *cast(pub), *cast(sig), header, headerSize, ph, phSize, cast(msgs), msgN, discIdxs, discN, preds, predN);
}

bool bbsProofVerifyEx(const bbsPublicKey *pub, const uint8_t *proof, mclSize proofSize, const uint8_t *header, mclSize headerSize, const uint8_t *ph, mclSize phSize, const mclBnFr *discMsgs, const uint32_t *discIdxs, uint32_t discN, const bbsPredicate *preds, uint32_t predN)
{
	return bbs::proofVerifyEx(*cast(pub), proof, proofSize, header, headerSize, ph, phSize, cast(discMsgs), discIdxs, discN, preds, predN);
}
