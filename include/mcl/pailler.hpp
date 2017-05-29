#pragma once
/**
	@file
	@brief pailler encryption
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>

namespace mcl { namespace pailler {

class PublicKey {
	size_t bitSize;
	mpz_class g;
	mpz_class n;
	mpz_class n2;
public:
	PublicKey() : bitSize(0) {}
	void init(size_t _bitSize, const mpz_class& _n)
	{
		bitSize = _bitSize;
		n = _n;
		g = 1 + _n;
		n2 = _n * _n;
	}
	template<class RG>
	void enc(mpz_class& c, const mpz_class& m, RG& rg) const
	{
		if (bitSize == 0) throw cybozu::Exception("pailler:PublicKey:not init");
		mpz_class r;
		mcl::gmp::getRand(r, bitSize, rg);
		mpz_class a, b;
		mcl::gmp::powMod(a, g, m, n2);
		mcl::gmp::powMod(b, r, n, n2);
		c = (a * b) % n2;
	}
	/*
		additive homomorphic encryption
		cz = cx + cy
	*/
	void add(mpz_class& cz, mpz_class& cx, mpz_class& cy) const
	{
		cz = (cx * cy) % n2;
	}
};

class SecretKey {
	size_t bitSize;
	mpz_class n;
	mpz_class n2;
	mpz_class lambda;
	mpz_class invLambda;
public:
	SecretKey() : bitSize(0) {}
	template<class RG>
	void init(size_t bitSize, RG& rg)
	{
		this->bitSize = bitSize;
		mpz_class p, q;
		mcl::gmp::getRandPrime(p, bitSize, rg);
		mcl::gmp::getRandPrime(q, bitSize, rg);
		lambda = (p - 1) * (q - 1);
		n = p * q;
		n2 = n * n;
		mcl::gmp::invMod(invLambda, lambda, n);
	}
	void getPublicKey(PublicKey& pub) const
	{
		pub.init(bitSize, n);
	}
	void dec(mpz_class& m, const mpz_class& c) const
	{
		mpz_class L;
		mcl::gmp::powMod(L, c, lambda, n2);
		L = ((L - 1) / n) % n;
		m = (L * invLambda) % n;
	}
};

} } // mcl::pailler
