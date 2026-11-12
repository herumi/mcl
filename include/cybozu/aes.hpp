#pragma once
/**
	@file
	@brief AES-CBC/CTR/ECB cipher
	@author MITSUNARI Shigeo(@herumi)

	If CYBOZU_DONT_USE_EXCEPTION is defined then no exception is thrown :
	use Cipher::isValid() after the constructor and Cipher::setup(bool *pb, ...).
*/

#include <string>
#ifndef CYBOZU_DONT_USE_EXCEPTION
#include <cybozu/exception.hpp>
#endif
#include <cybozu/inttype.hpp>
#include <cybozu/endian.hpp>

// define CYBOZU_USE_WIN_BCRYPT=1 to use Windows bcrypt even on x86/x64
#if CYBOZU_HOST == CYBOZU_HOST_INTEL && CYBOZU_USE_WIN_BCRYPT != 1
	#define CYBOZU_AES_NI
#endif
#ifdef CYBOZU_AES_NI
	#include <wmmintrin.h>
	#include <string.h> // memcpy
	#ifdef __GNUC__
		#define CYBOZU_AES_NI_TARGET __attribute__((target("aes,sse2")))
	#else
		#define CYBOZU_AES_NI_TARGET
	#endif
#endif

#ifdef __APPLE__
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	#ifndef CYBOZU_USE_APPLE_COMMONCRYPTO
		#define CYBOZU_USE_APPLE_COMMONCRYPTO 1
	#endif
#endif
#if CYBOZU_USE_APPLE_COMMONCRYPTO == 1
	#include <CommonCrypto/CommonCryptor.h>
#endif
/*
	use Windows CNG(bcrypt) if AES-NI is not available (e.g. ARM64 Windows)
	so that OpenSSL is not necessary
*/
#if !defined(CYBOZU_AES_NI) && defined(_WIN32) && !defined(CYBOZU_USE_WIN_BCRYPT)
	#define CYBOZU_USE_WIN_BCRYPT 1
#endif
#if CYBOZU_USE_WIN_BCRYPT == 1
	#ifndef WIN32_LEAN_AND_MEAN
		#define WIN32_LEAN_AND_MEAN
	#endif
	#include <windows.h>
	#include <bcrypt.h>
	#include <string.h> // memcpy
	#include <vector>
	#ifdef _MSC_VER
		#pragma comment(lib, "bcrypt.lib")
	#endif
#endif
#if !defined(CYBOZU_AES_NI) && CYBOZU_USE_WIN_BCRYPT != 1 && CYBOZU_USE_APPLE_COMMONCRYPTO != 1
	#include <openssl/evp.h>
#ifdef _MSC_VER
	#include <cybozu/link_libeay32.hpp>
#endif
#endif

namespace cybozu {

namespace crypto {

#ifdef CYBOZU_AES_NI
namespace local {

/*
	AES-CBC/CTR/ECB by AES-NI intrinsics
	update/finalize have the same semantics as EVP_CipherUpdate/EVP_CipherFinal_ex without padding
*/
class AesNi {
public:
	enum Mode {
		M_CBC,
		M_CTR,
		M_ECB
	};
	// the reason of the failure of setupNoThrow
	enum Err {
		E_OK,
		E_KEY_LEN,
		E_IV_LEN,
		E_KEY_SIZE
	};
private:
	static const int maxRoundNum = 14;
	static const size_t blockSize = 16;
	__m128i key_[maxRoundNum + 1];
	__m128i iv_; // for CBC
	uint8_t buf_[blockSize]; // partial block for CBC/ECB
	uint8_t ctr_[blockSize]; // big endian counter for CTR
	uint8_t ks_[blockSize]; // keystream for CTR
	size_t bufSize_;
	size_t ksPos_;
	size_t keySize_;
	int roundNum_;
	Mode mode_;
	bool encMode_;
	CYBOZU_AES_NI_TARGET
	static inline __m128i nextKey(__m128i key, __m128i t)
	{
		key = _mm_xor_si128(key, _mm_slli_si128(key, 4));
		key = _mm_xor_si128(key, _mm_slli_si128(key, 4));
		key = _mm_xor_si128(key, _mm_slli_si128(key, 4));
		return _mm_xor_si128(key, t);
	}
	CYBOZU_AES_NI_TARGET
	void expandKey128(const uint8_t *key)
	{
		key_[0] = _mm_loadu_si128(cybozu::cast<const __m128i*>(key));
#define CYBOZU_CRYPTO_AES128_KEY(i, rcon) key_[i] = nextKey(key_[i - 1], _mm_shuffle_epi32(_mm_aeskeygenassist_si128(key_[i - 1], rcon), 0xff))
		CYBOZU_CRYPTO_AES128_KEY(1, 0x01);
		CYBOZU_CRYPTO_AES128_KEY(2, 0x02);
		CYBOZU_CRYPTO_AES128_KEY(3, 0x04);
		CYBOZU_CRYPTO_AES128_KEY(4, 0x08);
		CYBOZU_CRYPTO_AES128_KEY(5, 0x10);
		CYBOZU_CRYPTO_AES128_KEY(6, 0x20);
		CYBOZU_CRYPTO_AES128_KEY(7, 0x40);
		CYBOZU_CRYPTO_AES128_KEY(8, 0x80);
		CYBOZU_CRYPTO_AES128_KEY(9, 0x1b);
		CYBOZU_CRYPTO_AES128_KEY(10, 0x36);
#undef CYBOZU_CRYPTO_AES128_KEY
	}
	CYBOZU_AES_NI_TARGET
	static inline void assist192(__m128i *t1, __m128i *t3, __m128i keygen)
	{
		*t1 = nextKey(*t1, _mm_shuffle_epi32(keygen, 0x55));
		*t3 = _mm_xor_si128(*t3, _mm_slli_si128(*t3, 4));
		*t3 = _mm_xor_si128(*t3, _mm_shuffle_epi32(*t1, 0xff));
	}
	CYBOZU_AES_NI_TARGET
	void expandKey192(const uint8_t *key)
	{
		__m128i t1 = _mm_loadu_si128(cybozu::cast<const __m128i*>(key));
		__m128i t3 = _mm_loadl_epi64(cybozu::cast<const __m128i*>(key + 16));
		key_[0] = t1;
		key_[1] = t3;
		/*
			each group generates key_[i](upper half), key_[i+1], key_[i+2] and
			the lower half of key_[i+3] (completed by the next group)
		*/
#define CYBOZU_CRYPTO_AES192_KEY(i, rcon1, rcon2) \
		assist192(&t1, &t3, _mm_aeskeygenassist_si128(t3, rcon1)); \
		key_[i] = _mm_castpd_si128(_mm_shuffle_pd(_mm_castsi128_pd(key_[i]), _mm_castsi128_pd(t1), 0)); \
		key_[i + 1] = _mm_castpd_si128(_mm_shuffle_pd(_mm_castsi128_pd(t1), _mm_castsi128_pd(t3), 1)); \
		assist192(&t1, &t3, _mm_aeskeygenassist_si128(t3, rcon2)); \
		key_[i + 2] = t1; \
		key_[i + 3] = t3
		CYBOZU_CRYPTO_AES192_KEY(1, 0x01, 0x02);
		CYBOZU_CRYPTO_AES192_KEY(4, 0x04, 0x08);
		CYBOZU_CRYPTO_AES192_KEY(7, 0x10, 0x20);
		CYBOZU_CRYPTO_AES192_KEY(10, 0x40, 0x80); // key_[13] is not used
#undef CYBOZU_CRYPTO_AES192_KEY
	}
	CYBOZU_AES_NI_TARGET
	void expandKey256(const uint8_t *key)
	{
		key_[0] = _mm_loadu_si128(cybozu::cast<const __m128i*>(key));
		key_[1] = _mm_loadu_si128(cybozu::cast<const __m128i*>(key + 16));
#define CYBOZU_CRYPTO_AES256_KEY(i, rcon) \
		key_[i] = nextKey(key_[i - 2], _mm_shuffle_epi32(_mm_aeskeygenassist_si128(key_[i - 1], rcon), 0xff)); \
		key_[i + 1] = nextKey(key_[i - 1], _mm_shuffle_epi32(_mm_aeskeygenassist_si128(key_[i], 0x00), 0xaa))
		CYBOZU_CRYPTO_AES256_KEY(2, 0x01);
		CYBOZU_CRYPTO_AES256_KEY(4, 0x02);
		CYBOZU_CRYPTO_AES256_KEY(6, 0x04);
		CYBOZU_CRYPTO_AES256_KEY(8, 0x08);
		CYBOZU_CRYPTO_AES256_KEY(10, 0x10);
		CYBOZU_CRYPTO_AES256_KEY(12, 0x20);
#undef CYBOZU_CRYPTO_AES256_KEY
		key_[14] = nextKey(key_[12], _mm_shuffle_epi32(_mm_aeskeygenassist_si128(key_[13], 0x40), 0xff));
	}
	// convert encryption keys to equivalent inverse cipher keys for aesdec
	CYBOZU_AES_NI_TARGET
	void convertDecKey()
	{
		__m128i t = key_[0];
		key_[0] = key_[roundNum_];
		key_[roundNum_] = t;
		int i = 1;
		int j = roundNum_ - 1;
		while (i < j) {
			t = _mm_aesimc_si128(key_[i]);
			key_[i] = _mm_aesimc_si128(key_[j]);
			key_[j] = t;
			i++;
			j--;
		}
		key_[i] = _mm_aesimc_si128(key_[i]); // i == j because roundNum_ is even
	}
	CYBOZU_AES_NI_TARGET
	__m128i encryptBlock(__m128i m) const
	{
		m = _mm_xor_si128(m, key_[0]);
		for (int i = 1; i < roundNum_; i++) {
			m = _mm_aesenc_si128(m, key_[i]);
		}
		return _mm_aesenclast_si128(m, key_[roundNum_]);
	}
	CYBOZU_AES_NI_TARGET
	__m128i decryptBlock(__m128i m) const
	{
		m = _mm_xor_si128(m, key_[0]);
		for (int i = 1; i < roundNum_; i++) {
			m = _mm_aesdec_si128(m, key_[i]);
		}
		return _mm_aesdeclast_si128(m, key_[roundNum_]);
	}
	CYBOZU_AES_NI_TARGET
	void processBlocks(uint8_t *out, const uint8_t *in, size_t blockNum)
	{
		if (mode_ == M_ECB) {
			for (size_t i = 0; i < blockNum; i++) {
				__m128i m = _mm_loadu_si128(cybozu::cast<const __m128i*>(in) + i);
				m = encMode_ ? encryptBlock(m) : decryptBlock(m);
				_mm_storeu_si128(cybozu::cast<__m128i*>(out) + i, m);
			}
			return;
		}
		__m128i iv = iv_;
		if (encMode_) {
			for (size_t i = 0; i < blockNum; i++) {
				iv = encryptBlock(_mm_xor_si128(_mm_loadu_si128(cybozu::cast<const __m128i*>(in) + i), iv));
				_mm_storeu_si128(cybozu::cast<__m128i*>(out) + i, iv);
			}
		} else {
			for (size_t i = 0; i < blockNum; i++) {
				__m128i c = _mm_loadu_si128(cybozu::cast<const __m128i*>(in) + i);
				_mm_storeu_si128(cybozu::cast<__m128i*>(out) + i, _mm_xor_si128(decryptBlock(c), iv));
				iv = c;
			}
		}
		iv_ = iv;
	}
	void incCtr()
	{
		for (int i = (int)blockSize - 1; i >= 0; i--) {
			if (++ctr_[i] != 0) break;
		}
	}
	CYBOZU_AES_NI_TARGET
	void generateKeyStream()
	{
		const __m128i ks = encryptBlock(_mm_loadu_si128(cybozu::cast<const __m128i*>(ctr_)));
		_mm_storeu_si128(cybozu::cast<__m128i*>(ks_), ks);
		incCtr();
	}
	/*
		the blocks are independent in CTR mode, so parallelN blocks are encrypted at once
		(the rounds of AES-NI of the blocks overlap in the pipeline of the CPU)
	*/
	CYBOZU_AES_NI_TARGET
	void processCtrBlocks(uint8_t *out, const uint8_t *in, size_t blockNum)
	{
		const size_t parallelN = 8;
		if (blockNum >= parallelN) {
			// the counter is a 128-bit big endian integer (hi:lo)
			uint64_t hi = cybozu::Get64bitAsBE(ctr_);
			uint64_t lo = cybozu::Get64bitAsBE(ctr_ + 8);
			do {
				__m128i m[parallelN];
				for (size_t i = 0; i < parallelN; i++) {
					const uint64_t l = lo + i;
					const uint64_t h = hi + (l < lo ? 1 : 0);
					// the first 8 bytes are hi and the last 8 bytes are lo
					const __m128i c = _mm_set_epi64x((long long)cybozu::byteSwap(l), (long long)cybozu::byteSwap(h));
					m[i] = _mm_xor_si128(c, key_[0]);
				}
				for (int r = 1; r < roundNum_; r++) {
					const __m128i k = key_[r];
					for (size_t i = 0; i < parallelN; i++) {
						m[i] = _mm_aesenc_si128(m[i], k);
					}
				}
				const __m128i k = key_[roundNum_];
				for (size_t i = 0; i < parallelN; i++) {
					const __m128i ks = _mm_aesenclast_si128(m[i], k);
					_mm_storeu_si128(cybozu::cast<__m128i*>(out) + i, _mm_xor_si128(_mm_loadu_si128(cybozu::cast<const __m128i*>(in) + i), ks));
				}
				const uint64_t l = lo + parallelN;
				if (l < lo) hi++;
				lo = l;
				out += parallelN * blockSize;
				in += parallelN * blockSize;
				blockNum -= parallelN;
			} while (blockNum >= parallelN);
			cybozu::Set64bitAsBE(ctr_, hi);
			cybozu::Set64bitAsBE(ctr_ + 8, lo);
		}
		for (size_t i = 0; i < blockNum; i++) {
			const __m128i ks = encryptBlock(_mm_loadu_si128(cybozu::cast<const __m128i*>(ctr_)));
			incCtr();
			_mm_storeu_si128(cybozu::cast<__m128i*>(out) + i, _mm_xor_si128(_mm_loadu_si128(cybozu::cast<const __m128i*>(in) + i), ks));
		}
	}
	int updateCtr(uint8_t *out, const uint8_t *in, size_t inSize)
	{
		size_t remain = inSize;
		// use the rest of the previous keystream
		while (remain > 0 && ksPos_ < blockSize) {
			*out++ = *in++ ^ ks_[ksPos_++];
			remain--;
		}
		const size_t blockNum = remain / blockSize;
		if (blockNum > 0) {
			processCtrBlocks(out, in, blockNum);
			out += blockNum * blockSize;
			in += blockNum * blockSize;
			remain -= blockNum * blockSize;
		}
		if (remain > 0) {
			generateKeyStream();
			ksPos_ = 0;
			while (remain > 0) {
				*out++ = *in++ ^ ks_[ksPos_++];
				remain--;
			}
		}
		return (int)inSize;
	}
public:
	AesNi()
		: bufSize_(0)
		, ksPos_(0)
		, keySize_(0)
		, roundNum_(0)
		, mode_(M_CBC)
		, encMode_(false)
	{
	}
	void init(size_t keySize, Mode mode)
	{
		keySize_ = keySize;
		mode_ = mode;
	}
	/*
		setup without exceptions
		iv is not used for ECB
		if it fails then the object is not usable (update returns -1) until the next successful setup
	*/
	CYBOZU_AES_NI_TARGET
	Err setupNoThrow(bool encMode, const uint8_t *key, size_t keySize, const uint8_t *iv, size_t ivSize)
	{
		roundNum_ = 0;
		bufSize_ = 0;
		ksPos_ = blockSize;
		const Mode mode = mode_;
		if (keySize != keySize_) return E_KEY_LEN;
		if (mode != M_ECB) {
			// iv may be null only for ECB
			if (iv == 0 || ivSize < blockSize) return E_IV_LEN;
			if (mode == M_CBC) {
				iv_ = _mm_loadu_si128(cybozu::cast<const __m128i*>(iv));
			} else {
				memcpy(ctr_, iv, blockSize);
			}
		}
		encMode_ = encMode;
		switch (keySize_) {
		case 16: expandKey128(key); roundNum_ = 10; break;
		case 24: expandKey192(key); roundNum_ = 12; break;
		case 32: expandKey256(key); roundNum_ = 14; break;
		default:
			return E_KEY_SIZE;
		}
		// CTR uses only the encryption
		if (mode != M_CTR && !encMode_) convertDecKey();
		return E_OK;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	void setup(bool encMode, const std::string& key, const std::string& iv)
	{
		switch (setupNoThrow(encMode, cybozu::cast<const uint8_t*>(key.data()), key.size(), cybozu::cast<const uint8_t*>(iv.data()), iv.size())) {
		case E_OK:
			return;
		case E_KEY_LEN:
			throw cybozu::Exception("crypto:AesNi:setup:keyLen") << key.size() << keySize_;
		case E_IV_LEN:
			throw cybozu::Exception("crypto:AesNi:setup:ivLen") << iv.size() << ">=" << (int)blockSize;
		default:
			throw cybozu::Exception("crypto:AesNi:setup:keySize") << keySize_;
		}
	}
#endif
	int update(uint8_t *out, const uint8_t *in, int inSize)
	{
		if (inSize < 0 || roundNum_ == 0) return -1;
		if (mode_ == M_CTR) return updateCtr(out, in, (size_t)inSize);
		int outSize = 0;
		size_t remain = (size_t)inSize;
		if (bufSize_ > 0) {
			size_t n = blockSize - bufSize_;
			if (n > remain) n = remain;
			memcpy(buf_ + bufSize_, in, n);
			bufSize_ += n;
			in += n;
			remain -= n;
			if (bufSize_ < blockSize) return 0;
			processBlocks(out, buf_, 1);
			out += blockSize;
			outSize += (int)blockSize;
			bufSize_ = 0;
		}
		const size_t blockNum = remain / blockSize;
		if (blockNum > 0) {
			processBlocks(out, in, blockNum);
			in += blockNum * blockSize;
			outSize += (int)(blockNum * blockSize);
			remain -= blockNum * blockSize;
		}
		if (remain > 0) {
			memcpy(buf_, in, remain);
			bufSize_ = remain;
		}
		return outSize;
	}
	int finalize() const
	{
		if (roundNum_ == 0) return -1;
		if (mode_ == M_CTR) return 0;
		return bufSize_ == 0 ? 0 : -1;
	}
};

} // cybozu::crypto::local
#endif // CYBOZU_AES_NI

#if CYBOZU_USE_WIN_BCRYPT == 1
namespace local {

/*
	AES-CBC/CTR/ECB by Windows CNG(bcrypt)
	update/finalize have the same semantics as EVP_CipherUpdate/EVP_CipherFinal_ex without padding
	CNG has no CTR mode, so it is built on ECB encryption of the counter block
*/
class BCryptAes {
public:
	enum Mode {
		M_CBC,
		M_CTR,
		M_ECB
	};
	// the reason of the failure of setupNoThrow
	enum Err {
		E_OK,
		E_KEY_LEN,
		E_IV_LEN,
		E_KEY_SIZE,
		E_OPEN_ALG,
		E_CHAINING_MODE,
		E_OBJECT_LENGTH,
		E_GENERATE_KEY
	};
private:
	static const size_t blockSize = 16;
	static const size_t maxBlockNum = 16; // the number of counter blocks encrypted at once
	BCRYPT_ALG_HANDLE hAlg_;
	BCRYPT_KEY_HANDLE hKey_;
	std::vector<uint8_t> keyObj_; // work area of hKey_ ; must be alive while hKey_ is used
	uint8_t iv_[blockSize]; // for CBC ; updated by BCryptEncrypt/BCryptDecrypt
	uint8_t buf_[blockSize]; // partial block for CBC/ECB
	uint8_t ctr_[blockSize]; // big endian counter for CTR
	uint8_t ks_[blockSize]; // keystream for CTR
	size_t bufSize_;
	size_t ksPos_;
	size_t keySize_;
	Mode mode_;
	bool encMode_;
	BCryptAes(const BCryptAes&);
	void operator=(const BCryptAes&);
	void destroyKey()
	{
		if (hKey_) {
			BCryptDestroyKey(hKey_);
			hKey_ = 0;
		}
	}
	void closeAlg()
	{
		if (hAlg_) {
			BCryptCloseAlgorithmProvider(hAlg_, 0);
			hAlg_ = 0;
		}
	}
	// *pStatus is the status of the failed function
	Err openAlg(NTSTATUS *pStatus)
	{
		if (hAlg_) return E_OK;
		NTSTATUS status = BCryptOpenAlgorithmProvider(&hAlg_, BCRYPT_AES_ALGORITHM, NULL, 0);
		if (!BCRYPT_SUCCESS(status)) {
			hAlg_ = 0;
			*pStatus = status;
			return E_OPEN_ALG;
		}
		if (mode_ == M_CBC) {
			status = BCryptSetProperty(hAlg_, BCRYPT_CHAINING_MODE, (PUCHAR)BCRYPT_CHAIN_MODE_CBC, sizeof(BCRYPT_CHAIN_MODE_CBC), 0);
		} else {
			// M_ECB and M_CTR(encrypt the counter block by ECB)
			status = BCryptSetProperty(hAlg_, BCRYPT_CHAINING_MODE, (PUCHAR)BCRYPT_CHAIN_MODE_ECB, sizeof(BCRYPT_CHAIN_MODE_ECB), 0);
		}
		if (!BCRYPT_SUCCESS(status)) {
			closeAlg(); // not to reuse the half-initialized provider
			*pStatus = status;
			return E_CHAINING_MODE;
		}
		DWORD objSize = 0;
		DWORD writeSize = 0;
		status = BCryptGetProperty(hAlg_, BCRYPT_OBJECT_LENGTH, (PUCHAR)&objSize, sizeof(objSize), &writeSize, 0);
		if (!BCRYPT_SUCCESS(status)) {
			closeAlg();
			*pStatus = status;
			return E_OBJECT_LENGTH;
		}
		keyObj_.resize(objSize);
		return E_OK;
	}
	/*
		encrypt/decrypt size bytes ; size must be a multiple of blockSize
		iv is updated by CNG if it is not zero
	*/
	bool crypt(uint8_t *out, const uint8_t *in, size_t size, bool encMode, uint8_t *iv)
	{
		if (hKey_ == 0) return false;
		const ULONG inSize = (ULONG)size;
		const ULONG ivSize = iv ? (ULONG)blockSize : 0;
		ULONG writeSize = 0;
		NTSTATUS status;
		if (encMode) {
			status = BCryptEncrypt(hKey_, (PUCHAR)in, inSize, NULL, iv, ivSize, out, inSize, &writeSize, 0);
		} else {
			status = BCryptDecrypt(hKey_, (PUCHAR)in, inSize, NULL, iv, ivSize, out, inSize, &writeSize, 0);
		}
		return BCRYPT_SUCCESS(status) && writeSize == inSize;
	}
	bool processBlocks(uint8_t *out, const uint8_t *in, size_t blockNum)
	{
		return crypt(out, in, blockNum * blockSize, encMode_, mode_ == M_CBC ? iv_ : 0);
	}
	void incCtr()
	{
		for (int i = (int)blockSize - 1; i >= 0; i--) {
			if (++ctr_[i] != 0) break;
		}
	}
	bool generateKeyStream()
	{
		if (!crypt(ks_, ctr_, blockSize, true, 0)) return false;
		incCtr();
		return true;
	}
	bool processCtrBlocks(uint8_t *out, const uint8_t *in, size_t blockNum)
	{
		uint8_t ctrBuf[blockSize * maxBlockNum];
		uint8_t ksBuf[blockSize * maxBlockNum];
		while (blockNum > 0) {
			const size_t n = blockNum < maxBlockNum ? blockNum : maxBlockNum;
			for (size_t i = 0; i < n; i++) {
				memcpy(ctrBuf + i * blockSize, ctr_, blockSize);
				incCtr();
			}
			const size_t size = n * blockSize;
			if (!crypt(ksBuf, ctrBuf, size, true, 0)) return false;
			for (size_t i = 0; i < size; i++) {
				out[i] = in[i] ^ ksBuf[i];
			}
			out += size;
			in += size;
			blockNum -= n;
		}
		return true;
	}
	int updateCtr(uint8_t *out, const uint8_t *in, size_t inSize)
	{
		size_t remain = inSize;
		// use the rest of the previous keystream
		while (remain > 0 && ksPos_ < blockSize) {
			*out++ = *in++ ^ ks_[ksPos_++];
			remain--;
		}
		const size_t blockNum = remain / blockSize;
		if (blockNum > 0) {
			if (!processCtrBlocks(out, in, blockNum)) return -1;
			out += blockNum * blockSize;
			in += blockNum * blockSize;
			remain -= blockNum * blockSize;
		}
		if (remain > 0) {
			if (!generateKeyStream()) return -1;
			ksPos_ = 0;
			while (remain > 0) {
				*out++ = *in++ ^ ks_[ksPos_++];
				remain--;
			}
		}
		return (int)inSize;
	}
public:
	BCryptAes()
		: hAlg_(0)
		, hKey_(0)
		, bufSize_(0)
		, ksPos_(0)
		, keySize_(0)
		, mode_(M_CBC)
		, encMode_(false)
	{
	}
	~BCryptAes()
	{
		destroyKey();
		closeAlg();
	}
	void init(size_t keySize, Mode mode)
	{
		keySize_ = keySize;
		mode_ = mode;
	}
	/*
		setup without exceptions
		iv is not used for ECB
		*pStatus is the status of the failed function of CNG
		if it fails then the object is not usable (update returns -1) until the next successful setup
	*/
	Err setupNoThrow(bool encMode, const uint8_t *key, size_t keySize, const uint8_t *iv, size_t ivSize, NTSTATUS *pStatus)
	{
		*pStatus = 0;
		destroyKey();
		bufSize_ = 0;
		ksPos_ = blockSize;
		const Mode mode = mode_;
		if (keySize != keySize_) return E_KEY_LEN;
		if (mode != M_ECB) {
			// iv may be null only for ECB
			if (iv == 0 || ivSize < blockSize) return E_IV_LEN;
			memcpy(mode == M_CBC ? iv_ : ctr_, iv, blockSize);
		}
		switch (keySize_) {
		case 16:
		case 24:
		case 32:
			break;
		default:
			return E_KEY_SIZE;
		}
		encMode_ = encMode;
		const Err err = openAlg(pStatus);
		if (err != E_OK) return err;
		const NTSTATUS status = BCryptGenerateSymmetricKey(hAlg_, &hKey_, keyObj_.empty() ? 0 : &keyObj_[0], (ULONG)keyObj_.size(), (PUCHAR)key, (ULONG)keySize, 0);
		if (!BCRYPT_SUCCESS(status)) {
			hKey_ = 0;
			*pStatus = status;
			return E_GENERATE_KEY;
		}
		return E_OK;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	void setup(bool encMode, const std::string& key, const std::string& iv)
	{
		NTSTATUS status = 0;
		switch (setupNoThrow(encMode, cybozu::cast<const uint8_t*>(key.data()), key.size(), cybozu::cast<const uint8_t*>(iv.data()), iv.size(), &status)) {
		case E_OK:
			return;
		case E_KEY_LEN:
			throw cybozu::Exception("crypto:BCryptAes:setup:keyLen") << key.size() << keySize_;
		case E_IV_LEN:
			throw cybozu::Exception("crypto:BCryptAes:setup:ivLen") << iv.size() << ">=" << (int)blockSize;
		case E_KEY_SIZE:
			throw cybozu::Exception("crypto:BCryptAes:setup:keySize") << keySize_;
		case E_OPEN_ALG:
			throw cybozu::Exception("crypto:BCryptAes:BCryptOpenAlgorithmProvider") << (int)status;
		case E_CHAINING_MODE:
			throw cybozu::Exception("crypto:BCryptAes:BCryptSetProperty:chainingMode") << (int)status;
		case E_OBJECT_LENGTH:
			throw cybozu::Exception("crypto:BCryptAes:BCryptGetProperty:objectLength") << (int)status;
		default:
			throw cybozu::Exception("crypto:BCryptAes:setup:BCryptGenerateSymmetricKey") << (int)status;
		}
	}
#endif
	int update(uint8_t *out, const uint8_t *in, int inSize)
	{
		if (inSize < 0 || hKey_ == 0) return -1;
		if (mode_ == M_CTR) return updateCtr(out, in, (size_t)inSize);
		int outSize = 0;
		size_t remain = (size_t)inSize;
		if (bufSize_ > 0) {
			size_t n = blockSize - bufSize_;
			if (n > remain) n = remain;
			memcpy(buf_ + bufSize_, in, n);
			bufSize_ += n;
			in += n;
			remain -= n;
			if (bufSize_ < blockSize) return 0;
			if (!processBlocks(out, buf_, 1)) return -1;
			out += blockSize;
			outSize += (int)blockSize;
			bufSize_ = 0;
		}
		const size_t blockNum = remain / blockSize;
		if (blockNum > 0) {
			if (!processBlocks(out, in, blockNum)) return -1;
			in += blockNum * blockSize;
			outSize += (int)(blockNum * blockSize);
			remain -= blockNum * blockSize;
		}
		if (remain > 0) {
			memcpy(buf_, in, remain);
			bufSize_ = remain;
		}
		return outSize;
	}
	int finalize() const
	{
		if (hKey_ == 0) return -1;
		if (mode_ == M_CTR) return 0;
		return bufSize_ == 0 ? 0 : -1;
	}
};

} // cybozu::crypto::local
#endif // CYBOZU_USE_WIN_BCRYPT

class Cipher {
public:
	enum Name {
		N_AES128_CBC,
		N_AES192_CBC,
		N_AES256_CBC,
		N_AES128_CTR,
		N_AES192_CTR,
		N_AES256_CTR,
		N_AES128_ECB, // be carefull to use
		N_AES192_ECB, // be carefull to use
		N_AES256_ECB, // be carefull to use
	};
	enum Mode {
		Decoding,
		Encoding
	};

private:
	bool valid_; // false if the constructor fails
	bool ready_; // true after a successful setup
#ifdef CYBOZU_AES_NI
	typedef local::AesNi AesImpl;
	AesImpl aes_;
#elif CYBOZU_USE_WIN_BCRYPT == 1
	typedef local::BCryptAes AesImpl;
	AesImpl aes_;
#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
	Name name_;
	CCCryptorRef ctx_;
#else
	const EVP_CIPHER *cipher_;
	EVP_CIPHER_CTX *ctx_;
#endif
	// the reason of the failure of setupNoThrow
	enum Err {
		E_OK,
		E_INVALID, // the constructor failed
		E_PADDING,
		E_KEY_LEN,
		E_IV_LEN,
		E_INIT,
		E_SET_PADDING
	};
	/*
		setup without exceptions
		*pStatus is the status of the failed function of the library
	*/
	Err setupNoThrow(Mode mode, const uint8_t *key, size_t keySize, const uint8_t *iv, size_t ivSize, bool padding, int *pStatus)
	{
		ready_ = false;
		*pStatus = 0;
		if (!valid_) return E_INVALID;
	#ifdef CYBOZU_AES_NI
		if (padding) return E_PADDING;
		switch (aes_.setupNoThrow(mode == Encoding, key, keySize, iv, ivSize)) {
		case AesImpl::E_OK: break;
		case AesImpl::E_KEY_LEN: return E_KEY_LEN;
		case AesImpl::E_IV_LEN: return E_IV_LEN;
		default: return E_INIT;
		}
	#elif CYBOZU_USE_WIN_BCRYPT == 1
		if (padding) return E_PADDING;
		NTSTATUS status = 0;
		const AesImpl::Err err = aes_.setupNoThrow(mode == Encoding, key, keySize, iv, ivSize, &status);
		*pStatus = (int)status;
		switch (err) {
		case AesImpl::E_OK: break;
		case AesImpl::E_KEY_LEN: return E_KEY_LEN;
		case AesImpl::E_IV_LEN: return E_IV_LEN;
		default: return E_INIT;
		}
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		if (keySize != getSize(name_) / 8) return E_KEY_LEN;
		const bool isCtr = name_ == N_AES128_CTR || name_ == N_AES192_CTR || name_ == N_AES256_CTR;
		const bool isEcb = name_ == N_AES128_ECB || name_ == N_AES192_ECB || name_ == N_AES256_ECB;
		if (!isEcb && (iv == 0 || ivSize < kCCBlockSizeAES128)) return E_IV_LEN;
		if (ctx_) {
			CCCryptorRelease(ctx_);
			ctx_ = 0;
		}
		CCCryptorStatus status;
		if (isCtr) {
			status = CCCryptorCreateWithMode(mode == Encoding ? kCCEncrypt : kCCDecrypt,
				kCCModeCTR, kCCAlgorithmAES128, ccNoPadding, iv, key, keySize, 0, 0, 0,
				kCCModeOptionCTR_BE, &ctx_);
		} else {
			CCOptions options = isEcb ? kCCOptionECBMode : 0;
			if (padding) options |= kCCOptionPKCS7Padding;
			const void *ivPtr = isEcb ? 0 : iv;
			status = CCCryptorCreate(mode == Encoding ? kCCEncrypt : kCCDecrypt,
				kCCAlgorithmAES128, options, key, keySize, ivPtr, &ctx_);
		}
		if (status != kCCSuccess) {
			ctx_ = 0;
			*pStatus = (int)status;
			return E_INIT;
		}
	#else
		(void)ivSize; // the length of iv is not checked
		if (keySize != static_cast<size_t>(EVP_CIPHER_key_length(cipher_))) return E_KEY_LEN;
		int ret = EVP_CipherInit_ex(ctx_, cipher_, NULL, key, iv, mode == Encoding ? 1 : 0);
		if (ret != 1) {
			*pStatus = ret;
			return E_INIT;
		}
		ret = EVP_CIPHER_CTX_set_padding(ctx_, padding ? 1 : 0);
		if (ret != 1) {
			*pStatus = ret;
			return E_SET_PADDING;
		}
	#endif
		ready_ = true;
		return E_OK;
	}

public:
	// return 0 if name is invalid and CYBOZU_DONT_USE_EXCEPTION is defined
	static inline size_t getSize(Name name)
	{
		switch (name) {
		case N_AES128_CBC: return 128;
		case N_AES192_CBC: return 192;
		case N_AES256_CBC: return 256;
		case N_AES128_CTR: return 128;
		case N_AES192_CTR: return 192;
		case N_AES256_CTR: return 256;
		case N_AES128_ECB: return 128;
		case N_AES192_ECB: return 192;
		case N_AES256_ECB: return 256;
		default:
	#ifndef CYBOZU_DONT_USE_EXCEPTION
			throw cybozu::Exception("crypto:Cipher:getSize") << name;
	#else
			return 0;
	#endif
		}
	}
	/*
		if CYBOZU_DONT_USE_EXCEPTION is defined then check isValid() after the constructor
	*/
	explicit Cipher(Name name = N_AES128_CBC)
		: valid_(true)
		, ready_(false)
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		, name_(name)
		, ctx_(0)
	#else
		, cipher_(0)
		, ctx_(0)
	#endif
	{
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
		AesImpl::Mode mode;
		switch (name) {
		case N_AES128_CBC:
		case N_AES192_CBC:
		case N_AES256_CBC: mode = AesImpl::M_CBC; break;
		case N_AES128_CTR:
		case N_AES192_CTR:
		case N_AES256_CTR: mode = AesImpl::M_CTR; break;
		case N_AES128_ECB:
		case N_AES192_ECB:
		case N_AES256_ECB: mode = AesImpl::M_ECB; break;
		default:
			invalidName(name);
			return;
		}
		aes_.init(getSize(name) / 8, mode);
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		switch (name_) {
		case N_AES128_CBC:
		case N_AES192_CBC:
		case N_AES256_CBC:
		case N_AES128_CTR:
		case N_AES192_CTR:
		case N_AES256_CTR:
		case N_AES128_ECB:
		case N_AES192_ECB:
		case N_AES256_ECB:
			break;
		default:
			invalidName(name);
			return;
		}
	#else
		ctx_ = EVP_CIPHER_CTX_new();
		if (ctx_ == 0) {
	#ifndef CYBOZU_DONT_USE_EXCEPTION
			throw cybozu::Exception("crypto:Cipher:EVP_CIPHER_CTX_new");
	#else
			valid_ = false;
			return;
	#endif
		}
		switch (name) {
		case N_AES128_CBC: cipher_ = EVP_aes_128_cbc(); break;
		case N_AES192_CBC: cipher_ = EVP_aes_192_cbc(); break;
		case N_AES256_CBC: cipher_ = EVP_aes_256_cbc(); break;
		case N_AES128_CTR: cipher_ = EVP_aes_128_ctr(); break;
		case N_AES192_CTR: cipher_ = EVP_aes_192_ctr(); break;
		case N_AES256_CTR: cipher_ = EVP_aes_256_ctr(); break;
		case N_AES128_ECB: cipher_ = EVP_aes_128_ecb(); break;
		case N_AES192_ECB: cipher_ = EVP_aes_192_ecb(); break;
		case N_AES256_ECB: cipher_ = EVP_aes_256_ecb(); break;
		default:
			invalidName(name);
			return;
		}
	#endif
	}
	~Cipher()
	{
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
		// nothing to do
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		if (ctx_) CCCryptorRelease(ctx_);
	#else
		if (ctx_) EVP_CIPHER_CTX_free(ctx_);
	#endif
	}
	// false if the constructor failed (only if CYBOZU_DONT_USE_EXCEPTION is defined ; otherwise the constructor throws)
	bool isValid() const { return valid_; }
	/*
		setup without exceptions : *pb = true if success
		key[keySize] : the key (16, 24 or 32 bytes according to the name)
		iv[ivSize] : the iv of CBC or the initial counter block (big endian) of CTR (at least 16 bytes ; not used for ECB)
		@note don't use padding = true
	*/
	void setup(bool *pb, Mode mode, const void *key, size_t keySize, const void *iv, size_t ivSize, bool padding = false)
	{
		int status;
		*pb = setupNoThrow(mode, cybozu::cast<const uint8_t*>(key), keySize, cybozu::cast<const uint8_t*>(iv), ivSize, padding, &status) == E_OK;
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	/*
		@note don't use padding = true
	*/
	void setup(Mode mode, const std::string& key, const std::string& iv, bool padding = false)
	{
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
		ready_ = false;
		if (padding) {
			throw cybozu::Exception("crypto:Cipher:setup:padding is not supported");
		}
		aes_.setup(mode == Encoding, key, iv);
		ready_ = true;
	#else
		int status = 0;
		const Err err = setupNoThrow(mode, cybozu::cast<const uint8_t*>(key.c_str()), key.size(), cybozu::cast<const uint8_t*>(iv.c_str()), iv.size(), padding, &status);
		switch (err) {
		case E_OK:
			return;
		case E_KEY_LEN:
	#if CYBOZU_USE_APPLE_COMMONCRYPTO == 1
			throw cybozu::Exception("crypto:Cipher:setup:keyLen") << key.size() << getSize(name_) / 8;
	#else
			throw cybozu::Exception("crypto:Cipher:setup:keyLen") << key.size() << EVP_CIPHER_key_length(cipher_);
	#endif
		case E_IV_LEN:
			throw cybozu::Exception("crypto:Cipher:setup:ivLen") << iv.size() << ">=" << 16;
	#if CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		default:
			throw cybozu::Exception("crypto:Cipher:setup:CCCryptorCreate") << status;
	#else
		case E_SET_PADDING:
			throw cybozu::Exception("crypto:Cipher:setup:EVP_CIPHER_CTX_set_padding") << status;
		default:
			throw cybozu::Exception("crypto:Cipher:setup:EVP_CipherInit_ex") << status;
	#endif
		}
	#endif
	}
#endif
	/*
		the size of outBuf must be larger than inBufSize + blockSize
		@retval positive or 0 : writeSize(+blockSize)
		@retval -1 : error (including the case that setup is not called or failed)
	*/
	int update(char *outBuf, const char *inBuf, int inBufSize)
	{
		if (!ready_) return -1;
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
		return aes_.update(cybozu::cast<uint8_t*>(outBuf), cybozu::cast<const uint8_t*>(inBuf), inBufSize);
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		if (ctx_ == 0) return -1;
		size_t outLen = 0;
		const CCCryptorStatus status = CCCryptorUpdate(ctx_, inBuf, static_cast<size_t>(inBufSize), outBuf,
			static_cast<size_t>(inBufSize + kCCBlockSizeAES128), &outLen);
		if (status != kCCSuccess) return -1;
		return static_cast<int>(outLen);
	#else
		int outLen = 0;
		int ret = EVP_CipherUpdate(ctx_, cybozu::cast<uint8_t*>(outBuf), &outLen, cybozu::cast<const uint8_t*>(inBuf), inBufSize);
		if (ret != 1) return -1;
		return outLen;
	#endif
	}
	/*
		return -1 if padding
		@note don't use
	*/
	int finalize(char *outBuf)
	{
		if (!ready_) return -1;
	#if defined(CYBOZU_AES_NI) || CYBOZU_USE_WIN_BCRYPT == 1
		(void)outBuf; // no output because padding is not supported
		return aes_.finalize();
	#elif CYBOZU_USE_APPLE_COMMONCRYPTO == 1
		if (ctx_ == 0) return -1;
		size_t outLen = 0;
		const CCCryptorStatus status = CCCryptorFinal(ctx_, outBuf, kCCBlockSizeAES128, &outLen);
		if (status != kCCSuccess) return -1;
		return static_cast<int>(outLen);
	#else
		int outLen = 0;
		int ret = EVP_CipherFinal_ex(ctx_, cybozu::cast<uint8_t*>(outBuf), &outLen);
		if (ret != 1) return -1;
		return outLen;
	#endif
	}
private:
	// called by the constructor for an invalid name
	void invalidName(Name name)
	{
	#ifndef CYBOZU_DONT_USE_EXCEPTION
		throw cybozu::Exception("crypto:Cipher:Cipher:name") << (int)name;
	#else
		(void)name;
		valid_ = false;
	#endif
	}
};

} }	// cybozu::crypto

#ifdef __APPLE__
	#pragma GCC diagnostic pop
#endif
