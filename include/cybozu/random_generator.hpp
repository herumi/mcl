#pragma once
/**
	@file
	@brief pseudrandom generator
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <cybozu/exception.hpp>
#ifdef _WIN32
#include <winsock2.h>
#include <windows.h>
#include <wincrypt.h>
#ifdef _MSC_VER
#pragma comment (lib, "advapi32.lib")
#endif
#include <cybozu/critical_section.hpp>
#else
#include <sys/types.h>
#include <fcntl.h>
#endif

namespace cybozu {

class RandomGenerator {
	RandomGenerator(const RandomGenerator&);
	void operator=(const RandomGenerator&);
public:
	uint32_t operator()()
	{
		return get32();
	}
	uint32_t get32()
	{
		uint32_t ret;
		read(&ret, 1);
		return ret;
	}
	uint64_t get64()
	{
		uint64_t ret;
		read(&ret, 1);
		return ret;
	}
#ifdef _WIN32
	RandomGenerator()
		: prov_(0)
		, pos_(bufSize)
	{
		DWORD flagTbl[] = { 0, CRYPT_NEWKEYSET };
		for (int i = 0; i < 2; i++) {
			if (CryptAcquireContext(&prov_, NULL, NULL, PROV_RSA_FULL, flagTbl[i]) != 0) return;
		}
		throw cybozu::Exception("randomgenerator");
	}
	void read_inner(void *buf, size_t byteSize)
	{
		if (CryptGenRandom(prov_, static_cast<DWORD>(byteSize), static_cast<BYTE*>(buf)) == 0) {
			throw cybozu::Exception("randomgenerator:read") << byteSize;
		}
	}
	~RandomGenerator()
	{
		if (prov_) {
			CryptReleaseContext(prov_, 0);
		}
	}
	/*
		fill buf[0..bufNum-1] with random data
		@note bufNum is not byte size
	*/
	template<class T>
	void read(T *buf, size_t bufNum)
	{
		cybozu::AutoLockCs al(cs_);
		const size_t byteSize = sizeof(T) * bufNum;
		if (byteSize > bufSize) {
			read_inner(buf, byteSize);
		} else {
			if (pos_ + byteSize > bufSize) {
				read_inner(buf_, bufSize);
				pos_ = 0;
			}
			memcpy(buf, buf_ + pos_, byteSize);
			pos_ += byteSize;
		}
	}
private:
	HCRYPTPROV prov_;
	static const size_t bufSize = 1024;
	char buf_[bufSize];
	size_t pos_;
	cybozu::CriticalSection cs_;
#else
	RandomGenerator()
		: fp_(::fopen("/dev/urandom", "rb"))
	{
		if (!fp_) throw cybozu::Exception("randomgenerator");
	}
	~RandomGenerator()
	{
		if (fp_) ::fclose(fp_);
	}
	/*
		fill buf[0..bufNum-1] with random data
		@note bufNum is not byte size
	*/
	template<class T>
	void read(T *buf, size_t bufNum)
	{
		const size_t byteSize = sizeof(T) * bufNum;
		if (::fread(buf, 1, (int)byteSize, fp_) != byteSize) {
			throw cybozu::Exception("randomgenerator:read") << byteSize;
		}
	}
#endif
private:
	FILE *fp_;
};

template<class T, class RG>
void shuffle(T* v, size_t n, RG& rg)
{
	if (n <= 1) return;
	for (size_t i = 0; i < n - 1; i++) {
		size_t r = i + size_t(rg.get64() % (n - i));
		using namespace std;
		swap(v[i], v[r]);
	}
}

template<class V, class RG>
void shuffle(V& v, RG& rg)
{
	shuffle(v.data(), v.size(), rg);
}

} // cybozu
