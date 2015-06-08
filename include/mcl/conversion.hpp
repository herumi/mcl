#pragma once
#include <vector>
#include <cybozu/itoa.hpp>
#include <cybozu/atoi.hpp>
#include <mcl/util.hpp>
/**
	@file
	@brief convertion from T[] to str2, str16
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

namespace mcl { namespace fp {

/*
	convert x[0..n) to hex string
	start "0x" if withPrefix
*/
template<class T>
void toStr16(std::string& str, const T *x, size_t n, bool withPrefix = false)
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
	str.resize(startPos + fullN * lenT + topLen);
	if (withPrefix) {
		str[0] = '0';
		str[1] = 'x';
	}
	cybozu::itohex(&str[startPos], topLen, v, false);
	for (size_t i = 0; i < fullN; i++) {
		cybozu::itohex(&str[startPos + topLen + i * lenT], lenT, x[fullN - 1 - i], false);
	}
}

/*
	convert x[0..n) to bin string
	start "0b" if withPrefix
*/
template<class T>
void toStr2(std::string& str, const T *x, size_t n, bool withPrefix)
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
	str.resize(startPos + fullN * lenT + topLen);
	if (withPrefix) {
		str[0] = '0';
		str[1] = 'b';
	}
	cybozu::itobin(&str[startPos], topLen, v);
	for (size_t i = 0; i < fullN; i++) {
		cybozu::itobin(&str[startPos + topLen + i * lenT], lenT, x[fullN - 1 - i]);
	}
}

/*
	convert hex string to x[0..xn)
	hex string = [0-9a-fA-F]+
*/
template<class T>
void fromStr16(T *x, size_t xn, const char *str, size_t strLen)
{
	if (strLen == 0) throw cybozu::Exception("fp:fromStr16:strLen is zero");
	const size_t unitLen = sizeof(T) * 2;
	const size_t q = strLen / unitLen;
	const size_t r = strLen % unitLen;
	const size_t requireSize = q + (r ? 1 : 0);
	if (xn < requireSize) throw cybozu::Exception("fp:fromStr16:short size") << xn << requireSize;
	for (size_t i = 0; i < q; i++) {
		bool b;
		x[i] = cybozu::hextoi(&b, &str[r + (q - 1 - i) * unitLen], unitLen);
		if (!b) throw cybozu::Exception("fp:fromStr16:bad char") << cybozu::exception::makeString(str, strLen);
	}
	if (r) {
		bool b;
		x[q] = cybozu::hextoi(&b, str, r);
		if (!b) throw cybozu::Exception("fp:fromStr16:bad char") << cybozu::exception::makeString(str, strLen);
	}
	for (size_t i = requireSize; i < xn; i++) x[i] = 0;
}


} } // mcl::fp
