/**
	@file
	@brief a sample of BLS signature
	see https://github.com/herumi/bls
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

*/
#include <mcl/bn256.hpp>

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
std::random_device g_rg;
#else
#include <cybozu/random_generator.hpp>
cybozu::RandomGenerator g_rg;
#endif

using namespace mcl::bn256;

void Hash(G1& P, const std::string& m)
{
	Fp t;
	t.setMsg(m);
	BN::mapToG1(P, t);
}

int main(int argc, char *argv[])
{
	std::string m = argc == 1 ? "hello mcl" : argv[1];

	// setup parameter
	bn256init();
	G1 P(-1, 1);
	G2 Q;
	BN::mapToG2(Q, 1);

	// generate secret key and public key
	Fr s;
	s.setRand(g_rg);
	std::cout << "secret key " << s << std::endl;
	G2 pub;
	G2::mul(pub, Q, s); // pub = sQ
	std::cout << "public key " << pub << std::endl;

	// sign
	G1 sign;
	{
		G1 Hm;
		Hash(Hm, m);
		G1::mul(sign, Hm, s); // sign = s H(m)
	}
	std::cout << "msg " << m << std::endl;
	std::cout << "sign " << sign << std::endl;

	// verify
	{
		Fp12 e1, e2;
		G1 Hm;
		Hash(Hm, m);
		BN::pairing(e1, sign, Q); // e1 = e(sign, Q)
		BN::pairing(e2, Hm, pub); // e2 = e(Hm, sQ)
		std::cout << "verify " << (e1 == e2 ? "ok" : "ng") << std::endl;
	}
}
