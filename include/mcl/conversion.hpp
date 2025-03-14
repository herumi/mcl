#pragma once
#include <cybozu/itoa.hpp>
#include <cybozu/stream.hpp>
#include <mcl/config.hpp>
/**
	@file
	@brief convertion bin/dec/hex <=> array
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
#endif

namespace mcl { namespace fp {

/*
	treat src[] as a little endian and set dst[]
	fill remain of dst if sizeof(D) * dstN > sizeof(S) * srcN
	return false if sizeof(D) * dstN < sizeof(S) * srcN
*/
template<class D, class S>
bool convertArrayAsLE(D *dst, size_t dstN, const S *src, size_t srcN)
{
	char assert_D_is_unsigned[D(-1) < 0 ? -1 : 1];
	char assert_S_is_unsigned[S(-1) < 0 ? -1 : 1];
	(void)assert_D_is_unsigned;
	(void)assert_S_is_unsigned;
	if (sizeof(D) * dstN < sizeof(S) * srcN) return false;
	size_t pos = 0;
	if (sizeof(D) < sizeof(S)) {
		for (size_t i = 0; i < srcN; i++) {
			S s = src[i];
			for (size_t j = 0; j < sizeof(S); j += sizeof(D)) {
				dst[pos++] = D(s);
				s >>= sizeof(D) * 8;
			}
		}
		for (; pos < dstN; pos++) {
			dst[pos] = 0;
		}
	} else {
		for (size_t i = 0; i < dstN; i++) {
			D u = 0;
			for (size_t j = 0; j < sizeof(D); j += sizeof(S)) {
				S s = (pos < srcN) ? src[pos++] : 0;
				u |= D(s) << (j * 8);
			}
			dst[i] = u;
		}
	}
	return true;
}

namespace local {

inline bool isSpace(char c)
{
	return c == ' ' || c == '\t' || c == '\r' || c == '\n';
}
template<class InputStream>
bool skipSpace(char *c, InputStream& is)
{
	for (;;) {
		if (!cybozu::readChar(c,  is)) return false;
		if (!isSpace(*c)) return true;
	}
}

#ifndef CYBOZU_DONT_USE_STRING
template<class InputStream>
void loadWord(std::string& s, InputStream& is)
{
	s.clear();
	char c;
	if (!skipSpace(&c, is)) return;
	s = c;
	for (;;) {
		if (!cybozu::readChar(&c,  is)) return;
		if (isSpace(c)) break;
		s += c;
	}
}
#endif

template<class InputStream>
size_t loadWord(char *buf, size_t bufSize, InputStream& is)
{
	if (bufSize == 0) return 0;
	char c;
	if (!skipSpace(&c, is)) return 0;
	size_t pos = 0;
	buf[pos++] = c;
	for (;;) {
		if (!cybozu::readChar(&c, is)) break;
		if (isSpace(c)) break;
		if (pos == bufSize) return 0;
		buf[pos++] = c;
	}
	return pos;
}


/*
	x[0, xn) += y
	return 1 if overflow else 0
*/
bool hexCharToUint8(uint8_t *v, char _c);

} // mcl::fp::local

/*
	convert little endian x[0, xn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
	start "0x" if withPrefix
*/
size_t arrayToHex(char *buf, size_t bufSize, const Unit *x, size_t n, bool withPrefix = false);

/*
	convert little endian x[0, xn) to buf
	return written size if success else 0
	buf[bufSize - return value, bufSize) is output data
	start "0b" if withPrefix
*/
size_t arrayToBin(char *buf, size_t bufSize, const Unit *x, size_t n, bool withPrefix);

/*
	convert hex string to x[0..xn)
	hex string = [0-9a-fA-F]+
*/
size_t hexToArray(Unit *x, size_t maxN, const char *buf, size_t bufSize);
/*
	convert bin string to x[0..xn)
	bin string = [01]+
*/
size_t binToArray(Unit *x, size_t maxN, const char *buf, size_t bufSize);

/*
	little endian t[0, tn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
*/
size_t arrayToDec(char *buf, size_t bufSize, const uint32_t *x, size_t xn);

size_t arrayToDec(char *buf, size_t bufSize, const uint64_t *x, size_t xn);

/*
	convert buf[0, bufSize) to x[0, num)
	return written num if success else 0
*/
size_t decToArray(uint32_t *x, size_t maxN, const char *buf, size_t bufSize);

size_t decToArray(uint64_t *x, size_t maxN, const char *buf, size_t bufSize);

/*
	return retavl is written size if success else 0
	REMARK : the top of string is buf + bufSize - retval
*/
size_t arrayToStr(char *buf, size_t bufSize, const Unit *x, size_t n, int base, bool withPrefix);

size_t strToArray(bool *pIsMinus, Unit *x, size_t xN, const char *buf, size_t bufSize, int ioMode);

/*
	convert src[0, n) to (n * 2) byte hex string and write it to os
	return true if success else flase
*/
template<class OutputStream>
void writeHexStr(bool *pb, OutputStream& os, const void *src, size_t n)
{
	const uint8_t *p = (const uint8_t *)src;
	for (size_t i = 0; i < n; i++) {
		char hex[2];
		cybozu::itohex(hex, sizeof(hex), p[i], false);
		cybozu::write(pb, os, hex, sizeof(hex));
		if (!*pb) return;
	}
	*pb = true;
}
/*
	read hex string from is and convert it to byte array
	return written buffer size
*/
template<class InputStream>
inline size_t readHexStr(void *buf, size_t n, InputStream& is)
{
	bool b;
	uint8_t *dst = (uint8_t *)buf;
	for (size_t i = 0; i < n; i++) {
		uint8_t L, H;
		char c[2];
		if (cybozu::readSome(c, sizeof(c), is) != sizeof(c)) return i;
		b = local::hexCharToUint8(&H, c[0]);
		if (!b) return i;
		b = local::hexCharToUint8(&L, c[1]);
		if (!b) return i;
		dst[i] = (H << 4) | L;
	}
	return n;
}

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
