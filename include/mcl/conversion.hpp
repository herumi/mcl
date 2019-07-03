#pragma once
#include <cybozu/itoa.hpp>
#include <cybozu/stream.hpp>
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
	q = x[] / x
	@retval r = x[] % x
	@note accept q == x
*/
inline uint32_t divU32(uint32_t *q, const uint32_t *x, size_t xn, uint32_t y)
{
	if (xn == 0) return 0;
	uint32_t r = 0;
	for (int i = (int)xn - 1; i >= 0; i--) {
		uint64_t t = (uint64_t(r) << 32) | x[i];
		q[i] = uint32_t(t / y);
		r = uint32_t(t % y);
	}
	return r;
}

/*
	z[0, xn) = x[0, xn) * y
	return z[xn]
	@note accept z == x
*/
inline uint32_t mulU32(uint32_t *z, const uint32_t *x, size_t xn, uint32_t y)
{
	uint32_t H = 0;
	for (size_t i = 0; i < xn; i++) {
		uint32_t t = H;
		uint64_t v = uint64_t(x[i]) * y;
		uint32_t L = uint32_t(v);
		H = uint32_t(v >> 32);
		z[i] = t + L;
		if (z[i] < t) {
			H++;
		}
	}
	return H;
}

/*
	x[0, xn) += y
	return 1 if overflow else 0
*/
inline uint32_t addU32(uint32_t *x, size_t xn, uint32_t y)
{
	uint32_t t = x[0] + y;
	x[0] = t;
	if (t >= y) return 0;
	for (size_t i = 1; i < xn; i++) {
		t = x[i] + 1;
		x[i] = t;
		if (t != 0) return 0;
	}
	return 1;
}

inline uint32_t decToU32(const char *p, size_t size, bool *pb)
{
	assert(0 < size && size <= 9);
	uint32_t x = 0;
	for (size_t i = 0; i < size; i++) {
		char c = p[i];
		if (c < '0' || c > '9') {
			*pb = false;
			return 0;
		}
		x = x * 10 + uint32_t(c - '0');
	}
	*pb = true;
	return x;
}

inline bool hexCharToUint8(uint8_t *v, char _c)
{
	uint32_t c = uint8_t(_c); // cast is necessary
	if (c - '0' <= '9' - '0') {
		c = c - '0';
	} else if (c - 'a' <= 'f' - 'a') {
		c = (c - 'a') + 10;
	} else if (c - 'A' <= 'F' - 'A') {
		c = (c - 'A') + 10;
	} else {
		return false;
	}
	*v = uint8_t(c);
	return true;
}

template<class UT>
bool hexToUint(UT *px, const char *p, size_t size)
{
	assert(0 < size && size <= sizeof(UT) * 2);
	UT x = 0;
	for (size_t i = 0; i < size; i++) {
		uint8_t v;
		if (!hexCharToUint8(&v, p[i])) return false;
		x = x * 16 + v;
	}
	*px = x;
	return true;
}

template<class UT>
bool binToUint(UT *px, const char *p, size_t size)
{
	assert(0 < size && size <= sizeof(UT) * 8);
	UT x = 0;
	for (size_t i = 0; i < size; i++) {
		UT c = static_cast<uint8_t>(p[i]);
		if (c == '0') {
			x = x * 2;
		} else if (c == '1') {
			x = x * 2 + 1;
		} else {
			return false;
		}
	}
	*px = x;
	return true;
}

inline bool parsePrefix(size_t *readSize, bool *isMinus, int *base, const char *buf, size_t bufSize)
{
	if (bufSize == 0) return false;
	size_t pos = 0;
	if (*buf == '-') {
		if (bufSize == 1) return false;
		*isMinus = true;
		buf++;
		pos++;
	} else {
		*isMinus = false;
	}
	if (buf[0] == '0') {
		if (bufSize > 1 && buf[1] == 'x') {
			if (*base == 0 || *base == 16) {
				*base = 16;
				pos += 2;
			} else {
				return false;
			}
		} else if (bufSize > 1 && buf[1] == 'b') {
			if (*base == 0 || *base == 2) {
				*base = 2;
				pos += 2;
			}
		}
	}
	if (*base == 0) *base = 10;
	if (pos == bufSize) return false;
	*readSize = pos;
	return true;
}

} // mcl::fp::local

/*
	convert little endian x[0, xn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
	start "0x" if withPrefix
*/
template<class T>
size_t arrayToHex(char *buf, size_t bufSize, const T *x, size_t n, bool withPrefix = false)
{
	size_t fullN = 0;
	if (n > 1) {
		size_t pos = n - 1;
		while (pos > 0) {
			if (x[pos]) break;
			pos--;
		}
		if (pos > 0) fullN = pos;
	}
	const T v = n == 0 ? 0 : x[fullN];
	const size_t topLen = cybozu::getHexLength(v);
	const size_t startPos = withPrefix ? 2 : 0;
	const size_t lenT = sizeof(T) * 2;
	const size_t totalSize = startPos + fullN * lenT + topLen;
	if (totalSize > bufSize) return 0;
	char *const top = buf + bufSize - totalSize;
	if (withPrefix) {
		top[0] = '0';
		top[1] = 'x';
	}
	cybozu::itohex(&top[startPos], topLen, v, false);
	for (size_t i = 0; i < fullN; i++) {
		cybozu::itohex(&top[startPos + topLen + i * lenT], lenT, x[fullN - 1 - i], false);
	}
	return totalSize;
}

/*
	convert little endian x[0, xn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
	start "0b" if withPrefix
*/
template<class T>
size_t arrayToBin(char *buf, size_t bufSize, const T *x, size_t n, bool withPrefix)
{
	size_t fullN = 0;
	if (n > 1) {
		size_t pos = n - 1;
		while (pos > 0) {
			if (x[pos]) break;
			pos--;
		}
		if (pos > 0) fullN = pos;
	}
	const T v = n == 0 ? 0 : x[fullN];
	const size_t topLen = cybozu::getBinLength(v);
	const size_t startPos = withPrefix ? 2 : 0;
	const size_t lenT = sizeof(T) * 8;
	const size_t totalSize = startPos + fullN * lenT + topLen;
	if (totalSize > bufSize) return 0;
	char *const top = buf + bufSize - totalSize;
	if (withPrefix) {
		top[0] = '0';
		top[1] = 'b';
	}
	cybozu::itobin(&top[startPos], topLen, v);
	for (size_t i = 0; i < fullN; i++) {
		cybozu::itobin(&top[startPos + topLen + i * lenT], lenT, x[fullN - 1 - i]);
	}
	return totalSize;
}

/*
	convert hex string to x[0..xn)
	hex string = [0-9a-fA-F]+
*/
template<class UT>
inline size_t hexToArray(UT *x, size_t maxN, const char *buf, size_t bufSize)
{
	if (bufSize == 0) return 0;
	const size_t unitLen = sizeof(UT) * 2;
	const size_t q = bufSize / unitLen;
	const size_t r = bufSize % unitLen;
	const size_t requireSize = q + (r ? 1 : 0);
	if (maxN < requireSize) return 0;
	for (size_t i = 0; i < q; i++) {
		if (!local::hexToUint(&x[i], &buf[r + (q - 1 - i) * unitLen], unitLen)) return 0;
	}
	if (r) {
		if (!local::hexToUint(&x[q], buf, r)) return 0;
	}
	return requireSize;
}
/*
	convert bin string to x[0..xn)
	bin string = [01]+
*/
template<class UT>
inline size_t binToArray(UT *x, size_t maxN, const char *buf, size_t bufSize)
{
	if (bufSize == 0) return 0;
	const size_t unitLen = sizeof(UT) * 8;
	const size_t q = bufSize / unitLen;
	const size_t r = bufSize % unitLen;
	const size_t requireSize = q + (r ? 1 : 0);
	if (maxN < requireSize) return 0;
	for (size_t i = 0; i < q; i++) {
		if (!local::binToUint(&x[i], &buf[r + (q - 1 - i) * unitLen], unitLen)) return 0;
	}
	if (r) {
		if (!local::binToUint(&x[q], buf, r)) return 0;
	}
	return requireSize;
}

/*
	little endian x[0, xn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
*/
template<class UT>
inline size_t arrayToDec(char *buf, size_t bufSize, const UT *x, size_t xn)
{
	const size_t maxN = 64;
	uint32_t t[maxN];
	if (sizeof(UT) == 8) {
		xn *= 2;
	}
	if (xn > maxN) return 0;
	memcpy(t, x, xn * sizeof(t[0]));

	const size_t width = 9;
	const uint32_t i1e9 = 1000000000U;
	size_t pos = 0;
	for (;;) {
		uint32_t r = local::divU32(t, t, xn, i1e9);
		while (xn > 0 && t[xn - 1] == 0) xn--;
		size_t len = cybozu::itoa_local::uintToDec(buf, bufSize - pos, r);
		if (len == 0) return 0;
		assert(0 < len && len <= width);
		if (xn == 0) return pos + len;
		// fill (width - len) '0'
		for (size_t j = 0; j < width - len; j++) {
			buf[bufSize - pos - width + j] = '0';
		}
		pos += width;
	}
}

/*
	convert buf[0, bufSize) to x[0, num)
	return written num if success else 0
*/
template<class UT>
inline size_t decToArray(UT *_x, size_t maxN, const char *buf, size_t bufSize)
{
	assert(sizeof(UT) == 4 || sizeof(UT) == 8);
	const size_t width = 9;
	const uint32_t i1e9 = 1000000000U;
	if (maxN == 0) return 0;
	if (sizeof(UT) == 8) {
		maxN *= 2;
	}
	uint32_t *x = reinterpret_cast<uint32_t*>(_x);
	size_t xn = 1;
	x[0] = 0;
	while (bufSize > 0) {
		size_t n = bufSize % width;
		if (n == 0) n = width;
		bool b;
		uint32_t v = local::decToU32(buf, n, &b);
		if (!b) return 0;
		uint32_t H = local::mulU32(x, x, xn, i1e9);
		if (H > 0) {
			if (xn == maxN) return 0;
			x[xn++] = H;
		}
		H = local::addU32(x, xn, v);
		if (H > 0) {
			if (xn == maxN) return 0;
			x[xn++] = H;
		}
		buf += n;
		bufSize -= n;
	}
	if (sizeof(UT) == 8 && (xn & 1)) {
		x[xn++] = 0;
	}
	return xn / (sizeof(UT) / 4);
}

/*
	return retavl is written size if success else 0
	REMARK : the top of string is buf + bufSize - retval
*/
template<class UT>
size_t arrayToStr(char *buf, size_t bufSize, const UT *x, size_t n, int base, bool withPrefix)
{
	switch (base) {
	case 0:
	case 10:
		return arrayToDec(buf, bufSize, x, n);
	case 16:
		return arrayToHex(buf, bufSize, x, n, withPrefix);
	case 2:
		return arrayToBin(buf, bufSize, x, n, withPrefix);
	default:
		return 0;
	}
}

template<class UT>
size_t strToArray(bool *pIsMinus, UT *x, size_t xN, const char *buf, size_t bufSize, int ioMode)
{
	ioMode &= 31;
	size_t readSize;
	if (!local::parsePrefix(&readSize, pIsMinus, &ioMode, buf, bufSize)) return 0;
	switch (ioMode) {
	case 10:
		return decToArray(x, xN, buf + readSize, bufSize - readSize);
	case 16:
		return hexToArray(x, xN, buf + readSize, bufSize - readSize);
	case 2:
		return binToArray(x, xN, buf + readSize, bufSize - readSize);
	default:
		return 0;
	}
}

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
