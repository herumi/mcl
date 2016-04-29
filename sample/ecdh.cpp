/*
	sample of Elliptic Curve Diffie-Hellman key sharing
*/
#include <iostream>
#include <fstream>
#include <cybozu/random_generator.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>

typedef mcl::FpT<> Fp;
typedef mcl::FpT<mcl::ZnTag> Zn;
typedef mcl::EcT<Fp> Ec;

int main()
{
	cybozu::RandomGenerator rg;
	/*
		system setup with a parameter secp192k1 recommended by SECG
		Ec is an elliptic curve over Fp
		the cyclic group of <P> is isomorphic to Zn
	*/
	const mcl::EcParam& para = mcl::ecparam::secp192k1;
	Zn::setModulo(para.n);
	Fp::setModulo(para.p);
	Ec::init(para.a, para.b);
	const Ec P(Fp(para.gx), Fp(para.gy));

	/*
		Alice setups a private key a and public key aP
	*/
	Zn a;
	Ec aP;

	a.setRand(rg);
	Ec::mul(aP, P, a); // aP = a * P;

	std::cout << "aP=" << aP << std::endl;

	/*
		Bob setups a private key b and public key bP
	*/
	Zn b;
	Ec bP;

	b.setRand(rg);
	Ec::mul(bP, P, b); // bP = b * P;

	std::cout << "bP=" << bP << std::endl;

	Ec abP, baP;

	// Alice uses bP(B's public key) and a(A's priavte key)
	Ec::mul(abP, bP, a); // abP = a * (bP)

	// Bob uses aP(A's public key) and b(B's private key)
	Ec::mul(baP, aP, b); // baP = b * (aP)

	if (abP == baP) {
		std::cout << "key sharing succeed:" << abP << std::endl;
	} else {
		std::cout << "ERR(not here)" << std::endl;
	}
}

