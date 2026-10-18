#pragma once
/*
	This file is for study. Not at the product level.
	BBS signature (draft-irtf-cfrg-bbs-signatures-12)
*/
#include <mcl/bls12_381.hpp>
#include <mcl/bbs.h>

namespace bbs {

/*
	cipherSuite: BBS_BLS12381_SHA256
	maxMsgN: max number of messages
	see bbsInit
*/
bool init(int cipherSuite, size_t maxMsgN);

// free the generators allocated by init
void term();

class PublicKey {
	bbsPublicKey v;
	friend class SecretKey;
public:
	const mcl::G2& get_v() const;
};

class SecretKey {
	bbsSecretKey v;
public:
	// generate a secret key by CSPRNG
	bool init();
	/*
		KeyGen of the spec
		keyMaterialSize >= 32, keyInfoSize <= 65535
		the default dst (ciphersuite_id || "KEYGEN_DST_") is used if keyDst is NULL.
	*/
	bool keyGen(const uint8_t *keyMaterial, size_t keyMaterialSize, const uint8_t *keyInfo = 0, size_t keyInfoSize = 0, const uint8_t *keyDst = 0, size_t keyDstSize = 0);
	void getPublicKey(PublicKey& pub) const;
	const mcl::Fr& get_v() const;
};

class Signature {
	bbsSignature v;
public:
	/*
		Generate signature for byte array messages
		Input:
			sec: secret key
			pub: public key
			header: optional (NULL with headerSize = 0)
			msgs: concatenated message byte array (msg[0] || msg[1] || ... || msg[msgN-1])
			msgSize: array storing size of each message (msgSize[i] is size of msg[i])
			msgN: number of messages
		Return:
			true: success
	*/
	bool sign(const SecretKey& sec, const PublicKey& pub, const uint8_t *header, size_t headerSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN);
	// sign for scalar messages (CoreSign of the spec)
	bool sign(const SecretKey& sec, const PublicKey& pub, const uint8_t *header, size_t headerSize, const mcl::Fr *msgs, size_t msgN);
	/*
		Verify signature for byte array messages
		Input:
			pub: public key
			header: optional (NULL with headerSize = 0)
			msgs: concatenated message byte array (msg[0] || msg[1] || ... || msg[msgN-1])
			msgSize: array storing size of each message (msgSize[i] is size of msg[i])
			msgN: number of messages
		Return:
			true: valid
	*/
	bool verify(const PublicKey& pub, const uint8_t *header, size_t headerSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN) const;
	// verify for scalar messages (CoreVerify of the spec)
	bool verify(const PublicKey& pub, const uint8_t *header, size_t headerSize, const mcl::Fr *msgs, size_t msgN) const;

	const mcl::G1& get_A() const;
	const mcl::Fr& get_e() const;
};

// size of a proof for undiscN undisclosed messages
size_t getProofSize(size_t undiscN);

/*
	msgN: number of all msgs
	discN: number of disclosed msgs
	discIdxs: strictly ascending order
	msgs[discIdxs[i]]: disclosed messages for i in [0, discN)
	return written size of proof if success else 0
*/
size_t proofGen(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN, const uint32_t *discIdxs, size_t discN);

bool proofVerify(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *discMsgs, const uint32_t *discMsgSize, const uint32_t *discIdxs, size_t discN);

// proofGen and proofVerify for scalar messages (CoreProofGen and CoreProofVerify of the spec)
size_t proofGen(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const mcl::Fr *msgs, size_t msgN, const uint32_t *discIdxs, size_t discN);

bool proofVerify(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const mcl::Fr *discMsgs, const uint32_t *discIdxs, size_t discN);

/*
	extension which is not defined in the spec
	proof with range predicates for linear combinations of undisclosed integer messages
	see bbsProofGenEx and bbsProofVerifyEx
*/
// size of a proof for undiscN undisclosed messages and the predicates. return 0 if preds is invalid
size_t getProofExSize(size_t undiscN, const bbsPredicate *preds, size_t predN);

size_t proofGenEx(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const mcl::Fr *msgs, size_t msgN, const uint32_t *discIdxs, size_t discN, const bbsPredicate *preds, size_t predN);

bool proofVerifyEx(const PublicKey& pub, const uint8_t *proof, size_t proofSize, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const mcl::Fr *discMsgs, const uint32_t *discIdxs, size_t discN, const bbsPredicate *preds, size_t predN);

/*
	internal functions exposed for tests
*/
namespace local {

// js[0:undiscN] = [0:msgN] - discIdxs[0:discN]
void setJs(uint32_t *js, size_t undiscN, const uint32_t *discIdxs, size_t discN);

// hash_to_scalar of the spec
void hashToScalar(mcl::Fr& out, const void *msg, size_t msgSize, const void *dst, size_t dstSize);

// messages_to_scalars of the spec for one message
void msgToFr(mcl::Fr& out, const uint8_t *msg, size_t msgSize);

// generators (Q_1, H_1, ..., H_maxMsgN) computed by init
const mcl::G1 *getGenerators();

/*
	proofGen with the given random scalars instead of CSPRNG
	rs: (r1, r2, e~, r1~, r3~, m~_1, ..., m~_U) where U = msgN - discN
	This function exists only to check the test vectors of the spec.
*/
size_t proofGenWithRandomScalars(uint8_t *proof, size_t maxProofSize, const PublicKey& pub, const Signature& sig, const uint8_t *header, size_t headerSize, const uint8_t *ph, size_t phSize, const uint8_t *msgs, const uint32_t *msgSize, size_t msgN, const uint32_t *discIdxs, size_t discN, const mcl::Fr *rs);

} // bbs::local

} // bbs
