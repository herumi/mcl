#pragma once
#include <vector>
#include <cybozu/itoa.hpp>
#include <cybozu/atoi.hpp>
#include <cybozu/bitvector.hpp>
/**
	@file
	@brief utility of Fp
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

namespace mcl { namespace fp {

#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
	typedef uint32_t BlockType;
#else
	typedef uint64_t BlockType;
#endif

template<class S>
void setBlockBit(S *buf, size_t bitLen, bool b)
{
	const size_t unitSize = sizeof(S) * 8;
	const size_t q = bitLen / unitSize;
	const size_t r = bitLen % unitSize;
	if (b) {
		buf[q] |= S(1) << r;
	} else {
		buf[q] &= ~(S(1) << r);
	}
}
template<class S>
bool getBlockBit(const S *buf, size_t bitLen)
{
	const size_t unitSize = sizeof(S) * 8;
	const size_t q = bitLen / unitSize;
	const size_t r = bitLen % unitSize;
	return (buf[q] & (S(1) << r)) != 0;
}
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

/*
	@param base [inout]
*/
inline const char *verifyStr(bool *isMinus, int *base, const std::string& str)
{
	const char *p = str.c_str();
	if (*p == '-') {
		*isMinus = true;
		p++;
	} else {
		*isMinus = false;
	}
	if (p[0] == '0') {
		if (p[1] == 'x') {
			if (*base != 0 && *base != 16) {
				throw cybozu::Exception("fp:verifyStr:bad base") << *base << str;
			}
			*base = 16;
			p += 2;
		} else if (p[1] == 'b') {
			if (*base != 0 && *base != 2) {
				throw cybozu::Exception("fp:verifyStr:bad base") << *base << str;
			}
			*base = 2;
			p += 2;
		}
	}
	if (*base == 0) *base = 10;
	if (*p == '\0') throw cybozu::Exception("fp:verifyStr:str is empty");
	return p;
}

template<class S>
size_t getRoundNum(size_t x)
{
	const size_t size = sizeof(S) * 8;
	return (x + size - 1) / size;
}

/*
	compare x[0, n) with y[0, n)
*/
template<class S>
int compareArray(const S* x, const S* y, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		const S a = x[n - 1 - i];
		const S b = y[n - 1 - i];
		if (a > b) return 1;
		if (a < b) return -1;
	}
	return 0;
}

/*
	get random value less than in[]
	n = (bitLen + sizeof(S) * 8) / (sizeof(S) * 8)
	input  in[0..n)
	output out[n..n)
	0 <= out < in
*/
template<class RG, class S>
inline void getRandVal(S *out, RG& rg, const S *in, size_t bitLen)
{
	const size_t unitBitSize = sizeof(S) * 8;
	const size_t n = getRoundNum<S>(bitLen);
	const size_t rem = bitLen & (unitBitSize - 1);
	for (;;) {
		rg.read(out, n);
		if (rem > 0) out[n - 1] &= (S(1) << rem) - 1;
		if (compareArray(out, in, n) < 0) return;
	}
}

/*
	z[] = (x[] << shift) | y
	@param z [out] z[0..n)
	@param x [in] x[0..n)
	@param n [in] length of x, z
	@param shift [in] 0 <= shift < (sizeof(S) * 8)
	@param y [in]
	@return (x[] << shift)[n]
*/
template<class S>
S shiftLeftOr(S* z, const S* x, size_t n, size_t shift, S y = 0)
{
	if (n == 0) {
		throw cybozu::Exception("fp:shiftLeftOr:bad n");
	}
	if (shift == 0) {
		for (size_t i = n - 1; i > 0; i--) {
			z[i] = x[i];
		}
		z[0] = x[0] | y;
		return 0;
	}
	const size_t unitSize = sizeof(S) * 8;
	if (shift >= unitSize) {
		throw cybozu::Exception("fp:shiftLeftOr:large shift") << shift;
	}
	const size_t rev = unitSize - shift;
	S ret = x[n - 1] >> rev;
	for (size_t i = n - 1; i > 0; i--) {
		z[i] = (x[i] << shift) | (x[i - 1] >> rev);
	}
	z[0] = (x[0] << shift) | y;
	return ret;
}
template<class S>
void shiftRight(S* z, const S* x, size_t n, size_t shift)
{
	if (n == 0) return;
	if (shift == 0) {
		for (size_t i = 0; i < n; i++) {
			z[i] = x[i];
		}
		return;
	}
	const size_t unitSize = sizeof(S) * 8;
	if (shift >= unitSize) {
		throw cybozu::Exception("fp:shiftRight:large shift") << shift;
	}
	const size_t rev = unitSize - shift;
	S prev = x[0];
	for (size_t i = 0; i < n - 1; i++) {
		S t = x[i + 1];
		z[i] = (prev >> shift) | (t << rev);
		prev = t;
	}
	z[n - 1] = prev >> shift;
}

template<class Vec, class T>
size_t splitBitVec(Vec& v, const cybozu::BitVectorT<T>& bv, size_t width)
{
	if (width > sizeof(typename Vec::value_type) * 8) {
		throw cybozu::Exception("fp:splitBitVec:bad width") << width;
	}
	const size_t q = bv.size() / width;
	const size_t r = bv.size() % width;
	for (size_t i = 0; i < q; i++) {
		v.push_back(bv.extract(i * width, width));
	}
	if (r > 0) {
		v.push_back(bv.extract(q * width, r));
	}
	return r ? r : width;
}

template<class Vec, class T>
void concatBitVec(cybozu::BitVectorT<T>& bv, const Vec& v, size_t width, size_t lastWidth)
{
	if (width > sizeof(typename Vec::value_type) * 8) {
		throw cybozu::Exception("fp:splitBitVec:bad width") << width;
	}
	bv.clear();
	for (size_t i = 0; i < v.size() - 1; i++) {
		bv.append(v[i], width);
	}
	bv.append(v[v.size() - 1], lastWidth);
}

} // mcl::fp

} // fp
