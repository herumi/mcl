#pragma once
/**
	@file
	@brief mmap class

	@author MITSUNARI Shigeo(@herumi)
*/
#include <string>
#include <cybozu/inttype.hpp>
#ifndef CYBOZU_DONT_USE_EXCEPTION
#include <cybozu/exception.hpp>
#endif

#ifdef _WIN32
	#ifndef WIN32_LEAN_AND_MEAN
		#define WIN32_LEAN_AND_MEAN
	#endif
	#include <windows.h>
#else
	#include <sys/types.h>
	#include <sys/stat.h>
	#include <sys/mman.h>
	#include <unistd.h>
	#include <fcntl.h>
#endif

namespace cybozu {

class Mmap {
	const char *map_;
#ifdef _WIN32
	HANDLE hFile_;
	HANDLE hMap_;
	template<class T>
	void subOpen(const T& fileName)
	{
		const char *errMsg = 0;
		if (hFile_ == INVALID_HANDLE_VALUE) {
			errMsg = "CreateFile"; goto ERR_EXIT;
		}
		{
			LARGE_INTEGER size;
			if (GetFileSizeEx(hFile_, &size) == 0) {
				errMsg = "GetFileSizeEx"; goto ERR_EXIT;
			}
			size_ = size.QuadPart;
		}
		if (size_ == 0) {
			CloseHandle(hFile_); hFile_ = INVALID_HANDLE_VALUE;
			valid_ = true;
			return;
		}

		hMap_ = CreateFileMapping(hFile_, NULL, PAGE_READONLY, 0, 0, NULL);
		if (hMap_ == NULL) {
			errMsg = "CreateFileMapping"; goto ERR_EXIT;
		}

		map_ = (const char*)MapViewOfFile(hMap_, FILE_MAP_READ, 0, 0, 0);
		if (map_ == 0) {
			errMsg = "MapViewOfFile"; goto ERR_EXIT;
		}
		valid_ = true;
		return;
ERR_EXIT:
#ifndef CYBOZU_DONT_USE_EXCEPTION
		std::string reason = cybozu::ErrorNo().toString();
#endif
		if (hMap_) { CloseHandle(hMap_); hMap_ = 0; }
		if (hFile_ != INVALID_HANDLE_VALUE) { CloseHandle(hFile_); hFile_ = INVALID_HANDLE_VALUE; }
		size_ = 0;
#ifndef CYBOZU_DONT_USE_EXCEPTION
		throw cybozu::Exception("mmap") << errMsg << fileName << reason;
#else
		(void)errMsg;
		(void)fileName;
#endif
	}
#endif
	uint64_t size_;
	bool valid_;
public:
#ifdef _WIN32
	explicit Mmap(const std::string& fileName)
		: map_(0)
		, hFile_(INVALID_HANDLE_VALUE)
		, hMap_(0)
		, size_(0)
		, valid_(false)
	{
		hFile_ = CreateFileA(fileName.c_str(), GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
					OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
		subOpen(fileName);
	}
	explicit Mmap(const std::wstring& fileName)
		: map_(0)
		, hFile_(INVALID_HANDLE_VALUE)
		, hMap_(0)
		, size_(0)
		, valid_(false)
	{
		hFile_ = CreateFileW(fileName.c_str(), GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
					OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
		subOpen(fileName);
	}
#else
	explicit Mmap(const std::string& fileName)
		: map_(static_cast<const char*>(MAP_FAILED))
		, size_(0)
		, valid_(false)
	{
		const char *errMsg = 0;
		int fd = ::open(fileName.c_str(), O_RDONLY);
		if (fd == -1) {
			errMsg = "open"; goto ERR_EXIT;
		}

		{
			struct stat st;
			int ret = ::fstat(fd, &st);
			if (ret != 0) {
				errMsg = "fstat"; goto ERR_EXIT;
			}
			size_ = st.st_size;
		}
		if (size_ == 0) {
			::close(fd);
			valid_ = true;
			return;
		}

		map_ = (const char*)::mmap(NULL, size_, PROT_READ, MAP_SHARED, fd, 0);
		if (map_ == MAP_FAILED) {
			errMsg = "mmap"; goto ERR_EXIT;
		}
		::close(fd);
		valid_ = true;
		return;
	ERR_EXIT:
#ifndef CYBOZU_DONT_USE_EXCEPTION
		std::string reason = cybozu::ErrorNo().toString();
#endif
		if (fd != -1) close(fd);
		size_ = 0;
#ifndef CYBOZU_DONT_USE_EXCEPTION
		throw cybozu::Exception("mmap") << errMsg << fileName << reason;
#else
		(void)errMsg;
#endif
	}
#endif
	~Mmap()
	{
#ifdef _WIN32
		if (map_) UnmapViewOfFile(map_);
		if (hMap_) CloseHandle(hMap_);
		if (hFile_ != INVALID_HANDLE_VALUE) CloseHandle(hFile_);
#else
		if (map_ != MAP_FAILED) ::munmap(const_cast<char*>(map_), size_);
#endif
	}
	uint64_t size() const { return size_; }
	const char *get() const { return map_; }
	bool isValid() const { return valid_; }
private:
	Mmap(const Mmap &);
	void operator=(const Mmap &);
};

} // cybozu
