#pragma once
/**
	@file
	@brief SHA-256, SHA-512 class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cybozu/endian.hpp>
#ifndef CYBOZU_DONT_USE_STRING
#include <cybozu/itoa.hpp>
#include <string>
#endif
#include <memory.h>
#include <assert.h>

namespace cybozu {

namespace sha2_local {

template<class T>
T min_(T x, T y) { return x < y ? x : y;; }

#ifndef CYBOZU_DONT_USE_STRING
inline void uint32toHexStr(char *buf, const uint32_t *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		cybozu::itohex(buf + i * 8, 8, x[i], false);
	}
}

inline void uint64toHexStr(char *buf, const uint64_t *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		cybozu::itohex(buf + i * 16, 16, x[i], false);
	}
}
#endif

inline uint32_t rot32(uint32_t x, int s)
{
#ifdef _MSC_VER
	return _rotr(x, s);
#else
	return (x >> s) | (x << (32 - s));
#endif
}

inline uint64_t rot64(uint64_t x, int s)
{
#ifdef _MSC_VER
	return _rotr64(x, s);
#else
	return (x >> s) | (x << (64 - s));
#endif
}

} // cybozu::sha2_local

class Sha256 {
private:
	static const size_t blockSize_ = 64;
	static const size_t hSize_ = 8;
	uint64_t totalSize_;
	size_t roundBufSize_;
	char roundBuf_[blockSize_];
	uint32_t h_[hSize_];
	static const size_t outByteSize_ = hSize_ * sizeof(uint32_t);
	const uint32_t *k_;

	/**
		@param buf [in] buffer(64byte)
	*/
	void round(const char *buf)
	{
		using namespace sha2_local;
		uint32_t w[64];
		for (int i = 0; i < 16; i++) {
			w[i] = cybozu::Get32bitAsBE(&buf[i * 4]);
		}
		for (int i = 16 ; i < 64; i++) {
			uint32_t t = w[i - 15];
			uint32_t s0 = rot32(t, 7) ^ rot32(t, 18) ^ (t >> 3);
			t = w[i - 2];
			uint32_t s1 = rot32(t, 17) ^ rot32(t, 19) ^ (t >> 10);
			w[i] = w[i - 16] + s0 + w[i - 7] + s1;
		}
		uint32_t a = h_[0];
		uint32_t b = h_[1];
		uint32_t c = h_[2];
		uint32_t d = h_[3];
		uint32_t e = h_[4];
		uint32_t f = h_[5];
		uint32_t g = h_[6];
		uint32_t h = h_[7];
		for (int i = 0; i < 64; i++) {
			uint32_t s1 = rot32(e, 6) ^ rot32(e, 11) ^ rot32(e, 25);
			uint32_t ch = g ^ (e & (f ^ g));
			uint32_t t1 = h + s1 + ch + k_[i] + w[i];
			uint32_t s0 = rot32(a, 2) ^ rot32(a, 13) ^ rot32(a, 22);
			uint32_t maj = ((a | b) & c) | (a & b);
			uint32_t t2 = s0 + maj;
			h = g;
			g = f;
			f = e;
			e = d + t1;
			d = c;
			c = b;
			b = a;
			a = t1 + t2;
		}
		h_[0] += a;
		h_[1] += b;
		h_[2] += c;
		h_[3] += d;
		h_[4] += e;
		h_[5] += f;
		h_[6] += g;
		h_[7] += h;
		totalSize_ += 64;
	}
	/*
		final phase
	*/
	void term(const char *buf, size_t bufSize)
	{
		assert(bufSize < blockSize_);
		const uint64_t totalSize = totalSize_ + bufSize;

		uint8_t last[blockSize_];
		memcpy(last, buf, bufSize);
		memset(&last[bufSize], 0, blockSize_ - bufSize);
		last[bufSize] = uint8_t(0x80); /* top bit = 1 */
		if (bufSize >= blockSize_ - 8) {
			round(reinterpret_cast<const char*>(last));
			memset(last, 0, sizeof(last)); // clear stack
		}
		cybozu::Set32bitAsBE(&last[56], uint32_t(totalSize >> 29));
		cybozu::Set32bitAsBE(&last[60], uint32_t(totalSize * 8));
		round(reinterpret_cast<const char*>(last));
	}
public:
	Sha256()
	{
		clear();
	}
	Sha256(const void *buf, size_t bufSize)
	{
		clear();
		digest(buf, bufSize);
	}
	void clear()
	{
		static const uint32_t kTbl[] = {
			0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
			0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
			0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
			0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
			0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
			0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
			0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
			0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
		};
		k_ = kTbl;
		totalSize_ = 0;
		roundBufSize_ = 0;
		h_[0] = 0x6a09e667;
		h_[1] = 0xbb67ae85;
		h_[2] = 0x3c6ef372;
		h_[3] = 0xa54ff53a;
		h_[4] = 0x510e527f;
		h_[5] = 0x9b05688c;
		h_[6] = 0x1f83d9ab;
		h_[7] = 0x5be0cd19;
	}
	void update(const void *buf_, size_t bufSize)
	{
		const char *buf = reinterpret_cast<const char*>(buf_);
		if (bufSize == 0) return;
		if (roundBufSize_ > 0) {
			size_t size = sha2_local::min_(blockSize_ - roundBufSize_, bufSize);
			memcpy(roundBuf_ + roundBufSize_, buf, size);
			roundBufSize_ += size;
			buf += size;
			bufSize -= size;
		}
		if (roundBufSize_ == blockSize_) {
			round(roundBuf_);
			roundBufSize_ = 0;
		}
		while (bufSize >= blockSize_) {
			assert(roundBufSize_ == 0);
			round(buf);
			buf += blockSize_;
			bufSize -= blockSize_;
		}
		if (bufSize > 0) {
			assert(bufSize < blockSize_);
			assert(roundBufSize_ == 0);
			memcpy(roundBuf_, buf, bufSize);
			roundBufSize_ = bufSize;
		}
		assert(roundBufSize_ < blockSize_);
	}
	void digest(const void *buf, size_t bufSize)
	{
		update(buf, bufSize);
		term(roundBuf_, roundBufSize_);
	}
	size_t get(void *out) const
	{
		char *p = reinterpret_cast<char*>(out);
		for (size_t i = 0; i < hSize_; i++) {
			cybozu::Set32bitAsBE(&p[i * sizeof(h_[0])], h_[i]);
		}
		return outByteSize_;
	}
#ifndef CYBOZU_DONT_USE_STRING
	void update(const std::string& buf)
	{
		update(buf.c_str(), buf.size());
	}
	void digest(const std::string& str = "")
	{
		digest(str.c_str(), str.size());
	}
	std::string get() const
	{
		char out[outByteSize_];
		get(out);
		return std::string(out, sizeof(out));
	}
	std::string toHexStr() const
	{
		char buf[outByteSize_ * 2];
		sha2_local::uint32toHexStr(buf, h_, hSize_);
		return std::string(buf, sizeof(buf));
	}
#endif
};

class Sha512 {
private:
	static const size_t blockSize_ = 128;
	static const size_t hSize_ = 8;
	uint64_t totalSize_;
	size_t roundBufSize_;
	char roundBuf_[blockSize_];
	uint64_t h_[hSize_];
	static const size_t outByteSize_ = hSize_ * sizeof(uint64_t);
	const uint64_t *k_;

	template<size_t i0, size_t i1, size_t i2, size_t i3, size_t i4, size_t i5, size_t i6, size_t i7>
	void round1(uint64_t *S, const uint64_t *w, size_t i)
	{
		using namespace sha2_local;
		uint64_t& a = S[i0];
		uint64_t& b = S[i1];
		uint64_t& c = S[i2];
		uint64_t& d = S[i3];
		uint64_t& e = S[i4];
		uint64_t& f = S[i5];
		uint64_t& g = S[i6];
		uint64_t& h = S[i7];

		uint64_t s1 = rot64(e, 14) ^ rot64(e, 18) ^ rot64(e, 41);
		uint64_t ch = g ^ (e & (f ^ g));
		uint64_t t0 = h + s1 + ch + k_[i] + w[i];
		uint64_t s0 = rot64(a, 28) ^ rot64(a, 34) ^ rot64(a, 39);
		uint64_t maj = ((a | b) & c) | (a & b);
		uint64_t t1 = s0 + maj;
		d += t0;
		h = t0 + t1;
	}
	/**
		@param buf [in] buffer(64byte)
	*/
	void round(const char *buf)
	{
		using namespace sha2_local;
		uint64_t w[80];
		for (int i = 0; i < 16; i++) {
			w[i] = cybozu::Get64bitAsBE(&buf[i * 8]);
		}
		for (int i = 16 ; i < 80; i++) {
			uint64_t t = w[i - 15];
			uint64_t s0 = rot64(t, 1) ^ rot64(t, 8) ^ (t >> 7);
			t = w[i - 2];
			uint64_t s1 = rot64(t, 19) ^ rot64(t, 61) ^ (t >> 6);
			w[i] = w[i - 16] + s0 + w[i - 7] + s1;
		}
		uint64_t s[8];
		for (int i = 0; i < 8; i++) {
			s[i] = h_[i];
		}
		for (int i = 0; i < 80; i += 8) {
			round1<0, 1, 2, 3, 4, 5, 6, 7>(s, w, i + 0);
			round1<7, 0, 1, 2, 3, 4, 5, 6>(s, w, i + 1);
			round1<6, 7, 0, 1, 2, 3, 4, 5>(s, w, i + 2);
			round1<5, 6, 7, 0, 1, 2, 3, 4>(s, w, i + 3);
			round1<4, 5, 6, 7, 0, 1, 2, 3>(s, w, i + 4);
			round1<3, 4, 5, 6, 7, 0, 1, 2>(s, w, i + 5);
			round1<2, 3, 4, 5, 6, 7, 0, 1>(s, w, i + 6);
			round1<1, 2, 3, 4, 5, 6, 7, 0>(s, w, i + 7);
		}
		for (int i = 0; i < 8; i++) {
			h_[i] += s[i];
		}
		totalSize_ += blockSize_;
	}
	/*
		final phase
	*/
	void term(const char *buf, size_t bufSize)
	{
		assert(bufSize < blockSize_);
		const uint64_t totalSize = totalSize_ + bufSize;

		uint8_t last[blockSize_];
		memcpy(last, buf, bufSize);
		memset(&last[bufSize], 0, blockSize_ - bufSize);
		last[bufSize] = uint8_t(0x80); /* top bit = 1 */
		if (bufSize >= blockSize_ - 16) {
			round(reinterpret_cast<const char*>(last));
			memset(last, 0, sizeof(last)); // clear stack
		}
		cybozu::Set64bitAsBE(&last[blockSize_ - 8], totalSize * 8);
		round(reinterpret_cast<const char*>(last));
	}
public:
	Sha512()
	{
		clear();
	}
	Sha512(const void *buf, size_t bufSize)
	{
		clear();
		digest(buf, bufSize);
	}
	void clear()
	{
		static const uint64_t kTbl[] = {
		    0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL,
		    0x59f111f1b605d019ULL, 0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL, 0xd807aa98a3030242ULL, 0x12835b0145706fbeULL,
		    0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL, 0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL, 0x9bdc06a725c71235ULL,
		    0xc19bf174cf692694ULL, 0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL, 0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL,
		    0x2de92c6f592b0275ULL, 0x4a7484aa6ea6e483ULL, 0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL, 0x983e5152ee66dfabULL,
		    0xa831c66d2db43210ULL, 0xb00327c898fb213fULL, 0xbf597fc7beef0ee4ULL, 0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
		    0x06ca6351e003826fULL, 0x142929670a0e6e70ULL, 0x27b70a8546d22ffcULL, 0x2e1b21385c26c926ULL, 0x4d2c6dfc5ac42aedULL,
		    0x53380d139d95b3dfULL, 0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL, 0x81c2c92e47edaee6ULL, 0x92722c851482353bULL,
		    0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL, 0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL, 0xd192e819d6ef5218ULL,
		    0xd69906245565a910ULL, 0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL, 0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL,
		    0x2748774cdf8eeb99ULL, 0x34b0bcb5e19b48a8ULL, 0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL, 0x5b9cca4f7763e373ULL,
		    0x682e6ff3d6b2b8a3ULL, 0x748f82ee5defb2fcULL, 0x78a5636f43172f60ULL, 0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
		    0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL, 0xbef9a3f7b2c67915ULL, 0xc67178f2e372532bULL, 0xca273eceea26619cULL,
		    0xd186b8c721c0c207ULL, 0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL, 0x06f067aa72176fbaULL, 0x0a637dc5a2c898a6ULL,
		    0x113f9804bef90daeULL, 0x1b710b35131c471bULL, 0x28db77f523047d84ULL, 0x32caab7b40c72493ULL, 0x3c9ebe0a15c9bebcULL,
		    0x431d67c49c100d4cULL, 0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL, 0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL
		};
		k_ = kTbl;
		totalSize_ = 0;
		roundBufSize_ = 0;
		h_[0] = 0x6a09e667f3bcc908ull;
		h_[1] = 0xbb67ae8584caa73bull;
		h_[2] = 0x3c6ef372fe94f82bull;
		h_[3] = 0xa54ff53a5f1d36f1ull;
		h_[4] = 0x510e527fade682d1ull;
		h_[5] = 0x9b05688c2b3e6c1full;
		h_[6] = 0x1f83d9abfb41bd6bull;
		h_[7] = 0x5be0cd19137e2179ull;
	}
	void update(const void *buf_, size_t bufSize)
	{
		const char *buf = reinterpret_cast<const char*>(buf_);
		if (bufSize == 0) return;
		if (roundBufSize_ > 0) {
			size_t size = sha2_local::min_(blockSize_ - roundBufSize_, bufSize);
			memcpy(roundBuf_ + roundBufSize_, buf, size);
			roundBufSize_ += size;
			buf += size;
			bufSize -= size;
		}
		if (roundBufSize_ == blockSize_) {
			round(roundBuf_);
			roundBufSize_ = 0;
		}
		while (bufSize >= blockSize_) {
			assert(roundBufSize_ == 0);
			round(buf);
			buf += blockSize_;
			bufSize -= blockSize_;
		}
		if (bufSize > 0) {
			assert(bufSize < blockSize_);
			assert(roundBufSize_ == 0);
			memcpy(roundBuf_, buf, bufSize);
			roundBufSize_ = bufSize;
		}
		assert(roundBufSize_ < blockSize_);
	}
	void digest(const void *buf, size_t bufSize)
	{
		update(buf, bufSize);
		term(roundBuf_, roundBufSize_);
	}
	size_t get(void *out) const
	{
		char *p = reinterpret_cast<char*>(out);
		for (size_t i = 0; i < hSize_; i++) {
			cybozu::Set64bitAsBE(&p[i * sizeof(h_[0])], h_[i]);
		}
		return outByteSize_;
	}
#ifndef CYBOZU_DONT_USE_STRING
	void digest(const std::string& str = "")
	{
		digest(str.c_str(), str.size());
	}
	void update(const std::string& buf)
	{
		update(buf.c_str(), buf.size());
	}
	std::string get() const
	{
		char out[outByteSize_];
		get(out);
		return std::string(out, sizeof(out));
	}
	std::string toHexStr() const
	{
		char buf[outByteSize_ * 2];
		sha2_local::uint64toHexStr(buf, h_, hSize_);
		return std::string(buf, sizeof(buf));
	}
#endif
};

} // cybozu
