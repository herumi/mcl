#pragma once
/**
	@file
	@brief functions for T[]
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>
#include <cybozu/bit_operation.hpp>

namespace mcl { namespace fp {

/*
	get pp such that p * pp = -1 mod M,
	where p is prime and M = 1 << 64(or 32).
	@param pLow [in] p mod M
*/
template<class T>
T getMontgomeryCoeff(T pLow)
{
	T ret = 0;
	T t = 0;
	T x = 1;
	for (size_t i = 0; i < sizeof(T) * 8; i++) {
		if ((t & 1) == 0) {
			t += pLow;
			ret += x;
		}
		t >>= 1;
		x <<= 1;
	}
	return ret;
}

template<class T>
int compareArray(const T* x, const T* y, size_t n)
{
	for (size_t i = n - 1; i != size_t(-1); i--) {
		if (x[i] < y[i]) return -1;
		if (x[i] > y[i]) return 1;
	}
	return 0;
}

template<class T>
bool isEqualArray(const T* x, const T* y, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i] != y[i]) return false;
	}
	return true;
}

template<class T>
bool isZeroArray(const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (x[i]) return false;
	}
	return true;
}

template<class T>
void clearArray(T *x, size_t begin, size_t end)
{
	for (size_t i = begin; i < end; i++) x[i] = 0;
}

template<class T>
void copyArray(T *y, const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

template<class T>
void toArray(T *y, size_t yn, const mpz_srcptr x)
{
	const int xn = x->_mp_size;
	assert(xn >= 0);
	const T* xp = (const T*)x->_mp_d;
	assert(xn <= (int)yn);
	copyArray(y, xp, xn);
	clearArray(y, xn, yn);
}

template<class T>
void toArray(T *y, size_t yn, const mpz_class& x)
{
	toArray(y, yn, x.get_mpz_t());
}

/*
	get random value less than in[]
	n = (bitSize + sizeof(T) * 8) / (sizeof(T) * 8)
	input  in[0..n)
	output out[n..n)
	0 <= out < in
*/
template<class RG, class T>
void getRandVal(T *out, RG& rg, const T *in, size_t bitSize)
{
	const size_t TbitSize = sizeof(T) * 8;
	const size_t n = (bitSize + TbitSize - 1) / TbitSize;
	const size_t rem = bitSize & (TbitSize - 1);
	for (;;) {
		rg.read(out, n);
		if (rem > 0) out[n - 1] &= (T(1) << rem) - 1;
		if (compareArray(out, in, n) < 0) return;
	}
}

/*
	@param out [inout] : set element of G ; out = x^y[]
	@param x [in]
	@param y [in]
	@param n [in] size of y[]
*/
template<class G, class T>
void powerGeneric(G& out, const G& x, const T *y, size_t n, void mul(G&, const G&, const G&) , void square(G&, const G&)){
	G t(x);
	while (n > 0) {
		if (y[n - 1]) break;
		n--;
	}
	for (size_t i = 0; i < n; i++) {
		T v = y[i];
		int m = (int)sizeof(T) * 8;
		if (i == n - 1) {
			assert(v);
			m = cybozu::bsr<T>(v) + 1;
		}
		for (int j = 0; j < m; j++) {
			if (v & (T(1) << j)) {
				mul(out, out, t);
			}
			square(t, t);
		}
	}
}

} } // mcl::fp

