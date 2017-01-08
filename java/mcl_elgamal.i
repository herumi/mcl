%module MclElgamal

%include "std_string.i"
%include "std_except.i"


%{
#include <cybozu/random_generator.hpp>
#include <cybozu/crypto.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>
struct Param {
const mcl::EcParam *ecParam;
cybozu::RandomGenerator rg;
cybozu::crypto::Hash::Name hashName;
static inline Param& getParam()
{
	static Param p;
    return p;
}
};

#include "mcl_elgamal.hpp"
%}
%include cpointer.i
%pointer_functions(bool, p_bool);

%include "mcl_elgamal.hpp"
