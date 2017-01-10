%module Bn256

%include "std_string.i"
%include "std_except.i"


%{
#include <cybozu/random_generator.hpp>
#include <cybozu/crypto.hpp>
#include <mcl/bn256.hpp>
struct Param {
	cybozu::RandomGenerator rg;
	mcl::bn::MapTo<mcl::bn256::Fp> mapTo;
	static inline Param& getParam()
	{
		static Param p;
	    return p;
	}
};
static void mapToG1(mcl::bn256::G1& P, const mcl::bn256::Fp& t)
{
	static mcl::bn::MapTo<mcl::bn256::Fp> mapTo;
	mapTo.calcG1(P, t);
}

static void HashAndMapToG1(mcl::bn256::G1& P, const std::string& m)
{
	std::string digest = cybozu::crypto::Hash::digest(cybozu::crypto::Hash::N_SHA256, m);
	mcl::bn256::Fp t;
	t.setArrayMask(digest.c_str(), digest.size());
	mapToG1(P, t);
}

#include "bn256_impl.hpp"
%}

%include "bn256_impl.hpp"
