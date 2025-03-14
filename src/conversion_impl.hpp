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

namespace local {

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

inline bool hexToUint(Unit *px, const char *p, size_t size)
{
	assert(0 < size && size <= sizeof(Unit) * 2);
	Unit x = 0;
	for (size_t i = 0; i < size; i++) {
		uint8_t v;
		if (!hexCharToUint8(&v, p[i])) return false;
		x = x * 16 + v;
	}
	*px = x;
	return true;
}

inline bool binToUint(Unit *px, const char *p, size_t size)
{
	assert(0 < size && size <= sizeof(Unit) * 8);
	Unit x = 0;
	for (size_t i = 0; i < size; i++) {
		Unit c = static_cast<uint8_t>(p[i]);
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

/*
	x[0, xn) += y
	return 1 if overflow else 0
*/
bool hexCharToUint8(uint8_t *v, char _c)
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

} // mcl::fp::local

/*
	convert little endian x[0, xn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
	start "0x" if withPrefix
*/
size_t arrayToHex(char *buf, size_t bufSize, const Unit *x, size_t n, bool withPrefix)
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
	const Unit v = n == 0 ? 0 : x[fullN];
	const size_t topLen = cybozu::getHexLength(v);
	const size_t startPos = withPrefix ? 2 : 0;
	const size_t lenT = sizeof(Unit) * 2;
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
	buf[bufSize - return value, bufSize) is output data
	start "0b" if withPrefix
*/
size_t arrayToBin(char *buf, size_t bufSize, const Unit *x, size_t n, bool withPrefix)
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
	const Unit v = n == 0 ? 0 : x[fullN];
	const size_t topLen = cybozu::getBinLength(v);
	const size_t startPos = withPrefix ? 2 : 0;
	const size_t lenT = sizeof(Unit) * 8;
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
size_t hexToArray(Unit *x, size_t maxN, const char *buf, size_t bufSize)
{
	if (bufSize == 0) return 0;
	const size_t unitLen = sizeof(Unit) * 2;
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
size_t binToArray(Unit *x, size_t maxN, const char *buf, size_t bufSize)
{
	if (bufSize == 0) return 0;
	const size_t unitLen = sizeof(Unit) * 8;
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
	little endian t[0, tn) to buf
	return written size if success else 0
	data is buf[bufSize - retval, bufSize)
*/
size_t arrayToDec(char *buf, size_t bufSize, const Unit *x, size_t xn)
{
	Unit *t = (Unit*)CYBOZU_ALLOCA(sizeof(Unit) * xn);
	mcl::bint::copyN(t, x, xn);
	const size_t width = 9;
	const uint32_t i1e9 = 1000000000U;
	size_t pos = 0;
	for (;;) {
		Unit r = mcl::bint::divUnit(t, t, xn, i1e9);
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
size_t decToArray(Unit *x, size_t maxN, const char *buf, size_t bufSize)
{
	const size_t width = 9;
	const uint32_t i1e9 = 1000000000U;
	if (maxN == 0) return 0;
	size_t xn = 1;
	x[0] = 0;
	while (bufSize > 0) {
		size_t n = bufSize % width;
		if (n == 0) n = width;
		bool b;
		Unit v = local::decToU32(buf, n, &b);
		if (!b) return 0;
		Unit H = mcl::bint::mulUnitN(x, x, i1e9, xn);
		if (H > 0) {
			if (xn == maxN) return 0;
			x[xn++] = H;
		}
		H = mcl::bint::addUnit(x, xn, v);
		if (H > 0) {
			if (xn == maxN) return 0;
			x[xn++] = H;
		}
		buf += n;
		bufSize -= n;
	}
	return xn;
}

/*
	return retavl is written size if success else 0
	REMARK : the top of string is buf + bufSize - retval
*/
size_t arrayToStr(char *buf, size_t bufSize, const Unit *x, size_t n, int base, bool withPrefix)
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

size_t strToArray(bool *pIsMinus, Unit *x, size_t xN, const char *buf, size_t bufSize, int ioMode)
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

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
