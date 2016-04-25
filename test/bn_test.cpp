#include <cybozu/test.hpp>
#include <mcl/gmp_util.hpp>
#include <mcl/bn.hpp>
#include <mcl/ec.hpp>

typedef mcl::FpT<mcl::FpTag, 256> Fp;
typedef mcl::Fp2T<Fp> Fp2;
typedef mcl::Fp6T<Fp> Fp6;
typedef mcl::Fp12T<Fp> Fp12;
typedef mcl::EcT<Fp> G1;
typedef mcl::EcT<Fp2> G2;

typedef mcl::bn::ParamT<Fp> Param;

CYBOZU_TEST_AUTO(naive)
{
	Param param;
	param.init();
}
