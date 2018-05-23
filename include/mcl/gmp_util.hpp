#pragma once
#include <iostream>
/**
	@file
	@brief util function for gmp
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <assert.h>
#include <stdint.h>
#include <cybozu/exception.hpp>
#include <mcl/randgen.hpp>
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4616)
	#pragma warning(disable : 4800)
	#pragma warning(disable : 4244)
	#pragma warning(disable : 4127)
	#pragma warning(disable : 4512)
	#pragma warning(disable : 4146)
#endif
#ifdef __EMSCRIPTEN__
	#define MCL_USE_VINT
#endif
#ifdef MCL_USE_VINT
#include <mcl/vint.hpp>
typedef mcl::Vint mpz_class;
#else
#include <gmpxx.h>
#ifdef _MSC_VER
	#pragma warning(pop)
	#include <cybozu/link_mpir.hpp>
#endif
#endif

#ifndef MCL_SIZEOF_UNIT
	#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
		#define MCL_SIZEOF_UNIT 4
	#else
		#define MCL_SIZEOF_UNIT 8
	#endif
#endif

namespace mcl {

namespace fp {

#if MCL_SIZEOF_UNIT == 8
typedef uint64_t Unit;
#else
typedef uint32_t Unit;
#endif
#define MCL_UNIT_BIT_SIZE (MCL_SIZEOF_UNIT * 8)

} // mcl::fp

namespace gmp {

typedef mpz_class ImplType;

// z = [buf[n-1]:..:buf[1]:buf[0]]
// eg. buf[] = {0x12345678, 0xaabbccdd}; => z = 0xaabbccdd12345678;
template<class T>
void setArray(mpz_class& z, const T *buf, size_t n)
{
#ifdef MCL_USE_VINT
	z.setArray(buf, n);
#else
	mpz_import(z.get_mpz_t(), n, -1, sizeof(*buf), 0, 0, buf);
#endif
}
/*
	buf[0, size) = x
	buf[size, maxSize) with zero
*/
#ifndef MCL_USE_VINT
template<class T>
void getArray(T *buf, size_t maxSize, const mpz_srcptr x)
{
	const size_t bufByteSize = sizeof(T) * maxSize;
	const int xn = x->_mp_size;
	if (xn < 0) throw cybozu::Exception("gmp:getArray:x is negative");
	size_t xByteSize = sizeof(*x->_mp_d) * xn;
	if (xByteSize > bufByteSize) throw cybozu::Exception("gmp:getArray:too small") << xn << maxSize;
	memcpy(buf, x->_mp_d, xByteSize);
	memset((char*)buf + xByteSize, 0, bufByteSize - xByteSize);
}
#endif
template<class T>
void getArray(T *buf, size_t maxSize, const mpz_class& x)
{
#ifdef MCL_USE_VINT
	x.getArray(buf, maxSize);
#else
	getArray(buf, maxSize, x.get_mpz_t());
#endif
}
inline void set(mpz_class& z, uint64_t x)
{
	setArray(z, &x, 1);
}
inline bool setStr(mpz_class& z, const std::string& str, int base = 0)
{
#ifdef MCL_USE_VINT
	z.setStr(str, base);
	return true;
#else
	return z.set_str(str, base) == 0;
#endif
}
/*
	set buf with string terminated by '\0'
	return strlen(buf) if success else 0
*/
inline size_t getStr(char *buf, size_t bufSize, const mpz_class& z, int base = 10)
{
#ifdef MCL_USE_VINT
	return z.getStr(buf, bufSize, base);
#else
	std::string str = z.get_str(base);
	if (str.size() < bufSize) {
		memcpy(buf, str.c_str(), str.size() + 1);
		return str.size();
	}
	return 0;
#endif
}
inline void getStr(std::string& str, const mpz_class& z, int base = 10)
{
#ifdef MCL_USE_VINT
	str = z.getStr(base);
#else
	str = z.get_str(base);
#endif
}
inline std::string getStr(const mpz_class& z, int base = 10)
{
	std::string s;
	getStr(s, z, base);
	return s;
}
inline void add(mpz_class& z, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::add(z, x, y);
#else
	mpz_add(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
#ifndef MCL_USE_VINT
inline void add(mpz_class& z, const mpz_class& x, unsigned int y)
{
	mpz_add_ui(z.get_mpz_t(), x.get_mpz_t(), y);
}
inline void sub(mpz_class& z, const mpz_class& x, unsigned int y)
{
	mpz_sub_ui(z.get_mpz_t(), x.get_mpz_t(), y);
}
inline void mul(mpz_class& z, const mpz_class& x, unsigned int y)
{
	mpz_mul_ui(z.get_mpz_t(), x.get_mpz_t(), y);
}
inline void div(mpz_class& q, const mpz_class& x, unsigned int y)
{
	mpz_div_ui(q.get_mpz_t(), x.get_mpz_t(), y);
}
inline void mod(mpz_class& r, const mpz_class& x, unsigned int m)
{
	mpz_mod_ui(r.get_mpz_t(), x.get_mpz_t(), m);
}
inline int compare(const mpz_class& x, int y)
{
	return mpz_cmp_si(x.get_mpz_t(), y);
}
#endif
inline void sub(mpz_class& z, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::sub(z, x, y);
#else
	mpz_sub(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline void mul(mpz_class& z, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::mul(z, x, y);
#else
	mpz_mul(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline void sqr(mpz_class& z, const mpz_class& x)
{
#ifdef MCL_USE_VINT
	Vint::mul(z, x, x);
#else
	mpz_mul(z.get_mpz_t(), x.get_mpz_t(), x.get_mpz_t());
#endif
}
inline void divmod(mpz_class& q, mpz_class& r, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::divMod(&q, r, x, y);
#else
	mpz_divmod(q.get_mpz_t(), r.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline void div(mpz_class& q, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::div(q, x, y);
#else
	mpz_div(q.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline void mod(mpz_class& r, const mpz_class& x, const mpz_class& m)
{
#ifdef MCL_USE_VINT
	Vint::mod(r, x, m);
#else
	mpz_mod(r.get_mpz_t(), x.get_mpz_t(), m.get_mpz_t());
#endif
}
inline void clear(mpz_class& z)
{
#ifdef MCL_USE_VINT
	z.clear();
#else
	mpz_set_ui(z.get_mpz_t(), 0);
#endif
}
inline bool isZero(const mpz_class& z)
{
#ifdef MCL_USE_VINT
	return z.isZero();
#else
	return mpz_sgn(z.get_mpz_t()) == 0;
#endif
}
inline bool isNegative(const mpz_class& z)
{
#ifdef MCL_USE_VINT
	return z.isNegative();
#else
	return mpz_sgn(z.get_mpz_t()) < 0;
#endif
}
inline void neg(mpz_class& z, const mpz_class& x)
{
#ifdef MCL_USE_VINT
	Vint::neg(z, x);
#else
	mpz_neg(z.get_mpz_t(), x.get_mpz_t());
#endif
}
inline int compare(const mpz_class& x, const mpz_class & y)
{
#ifdef MCL_USE_VINT
	return Vint::compare(x, y);
#else
	return mpz_cmp(x.get_mpz_t(), y.get_mpz_t());
#endif
}
template<class T>
void addMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
{
	add(z, x, y);
	if (compare(z, m) >= 0) {
		sub(z, z, m);
	}
}
template<class T>
void subMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
{
	sub(z, x, y);
	if (!isNegative(z)) return;
	add(z, z, m);
}
template<class T>
void mulMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
{
	mul(z, x, y);
	mod(z, z, m);
}
inline void sqrMod(mpz_class& z, const mpz_class& x, const mpz_class& m)
{
	sqr(z, x);
	mod(z, z, m);
}
// z = x^y (y >= 0)
inline void pow(mpz_class& z, const mpz_class& x, unsigned int y)
{
#ifdef MCL_USE_VINT
	Vint::pow(z, x, y);
#else
	mpz_pow_ui(z.get_mpz_t(), x.get_mpz_t(), y);
#endif
}
// z = x^y mod m (y >=0)
inline void powMod(mpz_class& z, const mpz_class& x, const mpz_class& y, const mpz_class& m)
{
#ifdef MCL_USE_VINT
	Vint::powMod(z, x, y, m);
#else
	mpz_powm(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t(), m.get_mpz_t());
#endif
}
// z = 1/x mod m
inline void invMod(mpz_class& z, const mpz_class& x, const mpz_class& m)
{
#ifdef MCL_USE_VINT
	Vint::invMod(z, x, m);
#else
	mpz_invert(z.get_mpz_t(), x.get_mpz_t(), m.get_mpz_t());
#endif
}
// z = lcm(x, y)
inline void lcm(mpz_class& z, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::lcm(z, x, y);
#else
	mpz_lcm(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline mpz_class lcm(const mpz_class& x, const mpz_class& y)
{
	mpz_class z;
	lcm(z, x, y);
	return z;
}
// z = gcd(x, y)
inline void gcd(mpz_class& z, const mpz_class& x, const mpz_class& y)
{
#ifdef MCL_USE_VINT
	Vint::gcd(z, x, y);
#else
	mpz_gcd(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
#endif
}
inline mpz_class gcd(const mpz_class& x, const mpz_class& y)
{
	mpz_class z;
	gcd(z, x, y);
	return z;
}
/*
	assume p : odd prime
	return  1 if x^2 = a mod p for some x
	return -1 if x^2 != a mod p for any x
*/
inline int legendre(const mpz_class& a, const mpz_class& p)
{
#ifdef MCL_USE_VINT
	return Vint::jacobi(a, p);
#else
	return mpz_legendre(a.get_mpz_t(), p.get_mpz_t());
#endif
}
inline bool isPrime(const mpz_class& x)
{
#ifdef MCL_USE_VINT
	return x.isPrime(32);
#else
	return mpz_probab_prime_p(x.get_mpz_t(), 32) != 0;
#endif
}
inline size_t getBitSize(const mpz_class& x)
{
#ifdef MCL_USE_VINT
	return x.getBitSize();
#else
	return mpz_sizeinbase(x.get_mpz_t(), 2);
#endif
}
inline bool testBit(const mpz_class& x, size_t pos)
{
#ifdef MCL_USE_VINT
	return x.testBit(pos);
#else
	return mpz_tstbit(x.get_mpz_t(), pos) != 0;
#endif
}
inline void resetBit(mpz_class& x, size_t pos)
{
#ifdef MCL_USE_VINT
	x.setBit(pos, false);
#else
	mpz_clrbit(x.get_mpz_t(), pos);
#endif
}
inline void setBit(mpz_class& x, size_t pos, bool v = true)
{
#ifdef MCL_USE_VINT
	x.setBit(pos, v);
#else
	if (v) {
		mpz_setbit(x.get_mpz_t(), pos);
	} else {
		resetBit(x, pos);
	}
#endif
}
inline const fp::Unit *getUnit(const mpz_class& x)
{
#ifdef MCL_USE_VINT
	return x.getUnit();
#else
	return reinterpret_cast<const fp::Unit*>(x.get_mpz_t()->_mp_d);
#endif
}
inline fp::Unit getUnit(const mpz_class& x, size_t i)
{
	return getUnit(x)[i];
}
inline size_t getUnitSize(const mpz_class& x)
{
#ifdef MCL_USE_VINT
	return x.getUnitSize();
#else
	return std::abs(x.get_mpz_t()->_mp_size);
#endif
}
inline mpz_class abs(const mpz_class& x)
{
#ifdef MCL_USE_VINT
	return Vint::abs(x);
#else
	return ::abs(x);
#endif
}

inline void getRand(mpz_class& z, size_t bitSize, fp::RandGen rg = fp::RandGen())
{
	if (rg.isZero()) rg = fp::RandGen::get();
	assert(bitSize > 1);
	const size_t rem = bitSize & 31;
	const size_t n = (bitSize + 31) / 32;
	std::vector<uint32_t> buf(n);
	rg.read(buf.data(), n * sizeof(buf[0]));
	uint32_t v = buf[n - 1];
	if (rem == 0) {
		v |= 1U << 31;
	} else {
		v &= (1U << rem) - 1;
		v |= 1U << (rem - 1);
	}
	buf[n - 1] = v;
	setArray(z, &buf[0], n);
}

inline void getRandPrime(mpz_class& z, size_t bitSize, fp::RandGen rg = fp::RandGen(), bool setSecondBit = false, bool mustBe3mod4 = false)
{
	if (rg.isZero()) rg = fp::RandGen::get();
	assert(bitSize > 2);
	do {
		getRand(z, bitSize, rg);
		if (setSecondBit) {
			z |= mpz_class(1) << (bitSize - 2);
		}
		if (mustBe3mod4) {
			z |= 3;
		}
	} while (!(isPrime(z)));
}
inline mpz_class getQuadraticNonResidue(const mpz_class& p)
{
	mpz_class g = 2;
	while (legendre(g, p) > 0) {
		++g;
	}
	return g;
}

namespace impl {

template<class Vec>
void convertToBinary(Vec& v, const mpz_class& x)
{
	const size_t len = gmp::getBitSize(x);
	v.clear();
	for (size_t i = 0; i < len; i++) {
		v.push_back(gmp::testBit(x, len - 1 - i) ? 1 : 0);
	}
}

template<class Vec>
size_t getContinuousVal(const Vec& v, size_t pos, int val)
{
	while (pos >= 2) {
		if (v[pos] != val) break;
		pos--;
	}
	return pos;
}

template<class Vec>
void convertToNAF(Vec& v, const Vec& in)
{
	v = in;
	size_t pos = v.size() - 1;
	for (;;) {
		size_t p = getContinuousVal(v, pos, 0);
		if (p == 1) return;
		assert(v[p] == 1);
		size_t q = getContinuousVal(v, p, 1);
		if (q == 1) return;
		assert(v[q] == 0);
		if (p - q <= 1) {
			pos = p - 1;
			continue;
		}
		v[q] = 1;
		for (size_t i = q + 1; i < p; i++) {
			v[i] = 0;
		}
		v[p] = -1;
		pos = q;
	}
}

template<class Vec>
size_t getNumOfNonZeroElement(const Vec& v)
{
	size_t w = 0;
	for (size_t i = 0; i < v.size(); i++) {
		if (v[i]) w++;
	}
	return w;
}

} // impl

/*
	compute a repl of x which has smaller Hamming weights.
	return true if naf is selected
*/
template<class Vec>
bool getNAF(Vec& v, const mpz_class& x)
{
	Vec bin;
	impl::convertToBinary(bin, x);
	Vec naf;
	impl::convertToNAF(naf, bin);
	const size_t binW = impl::getNumOfNonZeroElement(bin);
	const size_t nafW = impl::getNumOfNonZeroElement(naf);
	if (nafW < binW) {
		v.swap(naf);
		return true;
	} else {
		v.swap(bin);
		return false;
	}
}

} // mcl::gmp

/*
	Tonelli-Shanks
*/
class SquareRoot {
	bool isPrime;
	mpz_class p;
	mpz_class g;
	int r;
	mpz_class q; // p - 1 = 2^r q
	mpz_class s; // s = g^q
	mpz_class q_add_1_div_2;
public:
	SquareRoot() { clear(); }
	void clear()
	{
		isPrime = false;
		p = 0;
		g = 0;
		r = 0;
		q = 0;
		s = 0;
		q_add_1_div_2 = 0;
	}
	void set(const mpz_class& _p)
	{
		p = _p;
		if (p <= 2) throw cybozu::Exception("SquareRoot:bad p") << p;
		isPrime = gmp::isPrime(p);
		if (!isPrime) return; // don't throw until get() is called
		g = gmp::getQuadraticNonResidue(p);
		// p - 1 = 2^r q, q is odd
		r = 0;
		q = p - 1;
		while ((q & 1) == 0) {
			r++;
			q /= 2;
		}
		gmp::powMod(s, g, q, p);
		q_add_1_div_2 = (q + 1) / 2;
	}
	/*
		solve x^2 = a mod p
	*/
	bool get(mpz_class& x, const mpz_class& a) const
	{
		if (!isPrime) throw cybozu::Exception("SquareRoot:get:not prime") << p;
		if (a == 0) {
			x = 0;
			return true;
		}
		if (gmp::legendre(a, p) < 0) return false;
		if (r == 1) {
			// (p + 1) / 4 = (q + 1) / 2
			gmp::powMod(x, a, q_add_1_div_2, p);
			return true;
		}
		mpz_class c = s, d;
		int e = r;
		gmp::powMod(d, a, q, p);
		gmp::powMod(x, a, q_add_1_div_2, p); // destroy a if &x == &a
		mpz_class dd;
		mpz_class b;
		while (d != 1) {
			int i = 1;
			dd = d * d; dd %= p;
			while (dd != 1) {
				dd *= dd; dd %= p;
				i++;
			}
			b = 1;
			b <<= e - i - 1;
			gmp::powMod(b, c, b, p);
			x *= b; x %= p;
			c = b * b; c %= p;
			d *= c; d %= p;
			e = i;
		}
		return true;
	}
	/*
		solve x^2 = a in Fp
	*/
	template<class Fp>
	bool get(Fp& x, const Fp& a) const
	{
		if (Fp::getOp().mp != p) throw cybozu::Exception("bad Fp") << Fp::getOp().mp << p;
		if (a == 0) {
			x = 0;
			return true;
		}
		if (gmp::legendre(a.getMpz(), p) < 0) return false;
		if (r == 1) {
			// (p + 1) / 4 = (q + 1) / 2
			Fp::pow(x, a, q_add_1_div_2);
			return true;
		}
		Fp c, d;
		c.setMpz(s);
		int e = r;
		Fp::pow(d, a, q);
		Fp::pow(x, a, q_add_1_div_2); // destroy a if &x == &a
		Fp dd;
		Fp b;
		while (!d.isOne()) {
			int i = 1;
			Fp::sqr(dd, d);
			while (!dd.isOne()) {
				dd *= dd;
				i++;
			}
			b = 1;
//			b <<= e - i - 1;
			for (int j = 0; j < e - i - 1; j++) {
				b += b;
			}
			Fp::pow(b, c, b);
			x *= b;
			Fp::sqr(c, b);
			d *= c;
			e = i;
		}
		return true;
	}
};

} // mcl
