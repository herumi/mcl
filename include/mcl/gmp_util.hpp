#pragma once
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
#include <cybozu/exception.hpp>
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4616)
	#pragma warning(disable : 4800)
	#pragma warning(disable : 4244)
	#pragma warning(disable : 4127)
	#pragma warning(disable : 4512)
	#pragma warning(disable : 4146)
#endif
#include <gmpxx.h>
#include <stdint.h>
#ifdef _MSC_VER
	#pragma warning(pop)
#endif
#ifdef _MSC_VER
#if _MSC_VER == 1900
#ifdef _DEBUG
#pragma comment(lib, "14/mpird.lib")
#pragma comment(lib, "14/mpirxxd.lib")
#else
#pragma comment(lib, "14/mpir.lib")
#pragma comment(lib, "14/mpirxx.lib")
#endif
#elif _MSC_VER == 1800
#ifdef _DEBUG
#pragma comment(lib, "12/mpird.lib")
#pragma comment(lib, "12/mpirxxd.lib")
#else
#pragma comment(lib, "12/mpir.lib")
#pragma comment(lib, "12/mpirxx.lib")
#endif
#else
#ifdef _DEBUG
#pragma comment(lib, "mpird.lib")
#pragma comment(lib, "mpirxxd.lib")
#else
#pragma comment(lib, "mpir.lib")
#pragma comment(lib, "mpirxx.lib")
#endif
#endif
#endif

namespace mcl {

struct Gmp {
	typedef mpz_class ImplType;
#if CYBOZU_OS_BIT == 64
	typedef uint64_t Unit;
#else
	typedef uint32_t Unit;
#endif
	// z = [buf[n-1]:..:buf[1]:buf[0]]
	// eg. buf[] = {0x12345678, 0xaabbccdd}; => z = 0xaabbccdd12345678;
	template<class T>
	static void setArray(mpz_class& z, const T *buf, size_t n)
	{
		mpz_import(z.get_mpz_t(), n, -1, sizeof(*buf), 0, 0, buf);
	}
	/*
		return positive written size
		return 0 if failure
	*/
	template<class T>
	static size_t getArray(T *buf, size_t maxSize, const mpz_class& x)
	{
		const size_t totalSize = sizeof(T) * maxSize;
		if (getBitLen(x) > totalSize * 8) return 0;
		memset(buf, 0, sizeof(*buf) * maxSize);
		size_t size;
		mpz_export(buf, &size, -1, sizeof(T), 0, 0, x.get_mpz_t());
		// if x == 0, then size = 0 for gmp, size = 1 for mpir
		return size == 0 ? 1 : size;
	}
	static inline void set(mpz_class& z, uint64_t x)
	{
		setArray(z, &x, 1);
	}
	static inline bool setStr(mpz_class& z, const std::string& str, int base = 0)
	{
		return z.set_str(str, base) == 0;
	}
	static inline void getStr(std::string& str, const mpz_class& z, int base = 10)
	{
		str = z.get_str(base);
	}
	static inline void add(mpz_class& z, const mpz_class& x, const mpz_class& y)
	{
		mpz_add(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline void add(mpz_class& z, const mpz_class& x, unsigned int y)
	{
		mpz_add_ui(z.get_mpz_t(), x.get_mpz_t(), y);
	}
	static inline void sub(mpz_class& z, const mpz_class& x, const mpz_class& y)
	{
		mpz_sub(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline void sub(mpz_class& z, const mpz_class& x, unsigned int y)
	{
		mpz_sub_ui(z.get_mpz_t(), x.get_mpz_t(), y);
	}
	static inline void mul(mpz_class& z, const mpz_class& x, const mpz_class& y)
	{
		mpz_mul(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline void square(mpz_class& z, const mpz_class& x)
	{
		mpz_mul(z.get_mpz_t(), x.get_mpz_t(), x.get_mpz_t());
	}
	static inline void mul(mpz_class& z, const mpz_class& x, unsigned int y)
	{
		mpz_mul_ui(z.get_mpz_t(), x.get_mpz_t(), y);
	}
	static inline void divmod(mpz_class& q, mpz_class& r, const mpz_class& x, const mpz_class& y)
	{
		mpz_divmod(q.get_mpz_t(), r.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline void div(mpz_class& q, const mpz_class& x, const mpz_class& y)
	{
		mpz_div(q.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline void div(mpz_class& q, const mpz_class& x, unsigned int y)
	{
		mpz_div_ui(q.get_mpz_t(), x.get_mpz_t(), y);
	}
	static inline void mod(mpz_class& r, const mpz_class& x, const mpz_class& m)
	{
		mpz_mod(r.get_mpz_t(), x.get_mpz_t(), m.get_mpz_t());
	}
	static inline void mod(mpz_class& r, const mpz_class& x, unsigned int m)
	{
		mpz_mod_ui(r.get_mpz_t(), x.get_mpz_t(), m);
	}
	static inline void clear(mpz_class& z)
	{
		mpz_set_ui(z.get_mpz_t(), 0);
	}
	static inline bool isZero(const mpz_class& z)
	{
		return mpz_sgn(z.get_mpz_t()) == 0;
	}
	static inline bool isNegative(const mpz_class& z)
	{
		return mpz_sgn(z.get_mpz_t()) < 0;
	}
	static inline void neg(mpz_class& z, const mpz_class& x)
	{
		mpz_neg(z.get_mpz_t(), x.get_mpz_t());
	}
	static inline int compare(const mpz_class& x, const mpz_class & y)
	{
		return mpz_cmp(x.get_mpz_t(), y.get_mpz_t());
	}
	static inline int compare(const mpz_class& x, int y)
	{
		return mpz_cmp_si(x.get_mpz_t(), y);
	}
	template<class T>
	static inline void addMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
	{
		add(z, x, y);
		if (compare(z, m) >= 0) {
			sub(z, z, m);
		}
	}
	template<class T>
	static inline void subMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
	{
		sub(z, x, y);
		if (!isNegative(z)) return;
		add(z, z, m);
	}
	template<class T>
	static inline void mulMod(mpz_class& z, const mpz_class& x, const T& y, const mpz_class& m)
	{
		mul(z, x, y);
		mod(z, z, m);
	}
	static inline void squareMod(mpz_class& z, const mpz_class& x, const mpz_class& m)
	{
		square(z, x);
		mod(z, z, m);
	}
	// z = x^y (y >= 0)
	static inline void pow(mpz_class& z, const mpz_class& x, unsigned int y)
	{
		mpz_pow_ui(z.get_mpz_t(), x.get_mpz_t(), y);
	}
	// z = x^y mod m (y >=0)
	static inline void powMod(mpz_class& z, const mpz_class& x, const mpz_class& y, const mpz_class& m)
	{
		mpz_powm(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t(), m.get_mpz_t());
	}
	// z = 1/x mod m
	static inline void invMod(mpz_class& z, const mpz_class& x, const mpz_class& m)
	{
		mpz_invert(z.get_mpz_t(), x.get_mpz_t(), m.get_mpz_t());
	}
	// z = lcm(x, y)
	static inline void lcm(mpz_class& z, const mpz_class& x, const mpz_class& y)
	{
		mpz_lcm(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline mpz_class lcm(const mpz_class& x, const mpz_class& y)
	{
		mpz_class z;
		lcm(z, x, y);
		return z;
	}
	// z = gcd(x, y)
	static inline void gcd(mpz_class& z, const mpz_class& x, const mpz_class& y)
	{
		mpz_gcd(z.get_mpz_t(), x.get_mpz_t(), y.get_mpz_t());
	}
	static inline mpz_class gcd(const mpz_class& x, const mpz_class& y)
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
	static inline int legendre(const mpz_class& a, const mpz_class& p)
	{
		return mpz_legendre(a.get_mpz_t(), p.get_mpz_t());
	}
	static inline bool isPrime(const mpz_class& x)
	{
		return mpz_probab_prime_p(x.get_mpz_t(), 25) != 0;
	}
	static inline size_t getBitLen(const mpz_class& x)
	{
		return mpz_sizeinbase(x.get_mpz_t(), 2);
	}
	static inline Unit getUnit(const mpz_class& x, size_t i)
	{
		return x.get_mpz_t()->_mp_d[i];
	}
	static inline const Unit *getUnit(const mpz_class& x)
	{
		return reinterpret_cast<const Unit*>(x.get_mpz_t()->_mp_d);
	}
	static inline size_t getUnitSize(const mpz_class& x)
	{
		assert(x.get_mpz_t()->_mp_size >= 0);
		return x.get_mpz_t()->_mp_size;
	}
	template<class RG>
	static inline void getRand(mpz_class& z, size_t bitSize, RG& rg)
	{
		assert(bitSize > 1);
		const size_t rem = bitSize & 31;
		const size_t n = (bitSize + 31) / 32;
		std::vector<uint32_t> buf(n);
		rg.read(buf.data(), n);
		uint32_t v = buf[n - 1];
		if (rem == 0) {
			v |= 1U << 31;
		} else {
			v &= (1U << rem) - 1;
			v |= 1U << (rem - 1);
		}
		buf[n - 1] = v;
		Gmp::setArray(z, &buf[0], n);
	}
	template<class RG>
	static void getRandPrime(mpz_class& z, size_t bitSize, RG& rg, bool setSecondBit = false, bool mustBe3mod4 = false)
	{
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
};

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
public:
	SquareRoot() : isPrime(false) {}
	void set(const mpz_class& p)
	{
		if (p <= 2) throw cybozu::Exception("SquareRoot:bad p") << p;
		isPrime = Gmp::isPrime(p);
		if (!isPrime) return; // don't throw until get() is called
		this->p = p;
		// g is quadratic nonresidue
		g = 2;
		while (Gmp::legendre(g, p) > 0) {
			g++;
		}
		// p - 1 = 2^r q, q is odd
		r = 0;
		q = p - 1;
		while ((q & 1) == 0) {
			r++;
			q /= 2;
		}
		Gmp::powMod(s, g, q, p);
	}
	/*
		solve x^2 = a mod p
	*/
	bool get(mpz_class& x, const mpz_class& a) const
	{
		if (!isPrime) throw cybozu::Exception("SquareRoot:get:not prime") << p;
		if (Gmp::legendre(a, p) < 0) return false;
		if (r == 1) {
			Gmp::powMod(x, a, (p + 1) / 4, p);
			return true;
		}
		mpz_class c = s, d;
		int e = r;
		Gmp::powMod(d, a, q, p);
		Gmp::powMod(x, a, (q + 1) / 2, p); // destroy a if &x == &a
		while (d != 1) {
			int i = 1;
			mpz_class dd = (d * d) % p;
			while (dd != 1) {
				dd = (dd * dd) % p;
				i++;
			}
			mpz_class b = 1;
			b <<= e - i - 1;
			Gmp::powMod(b, c, b, p);
			x = (x * b) % p;
			c = (b * b) % p;
			d = (d * c) % p;
			e = i;
		}
		return true;
	}
};

} // mcl
