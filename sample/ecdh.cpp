/*
	sample of Elliptic Curve Diffie-Hellman key sharing
*/
#include <iostream>
#include <fstream>
#include <cybozu/random_generator.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>

typedef mcl::FpT<mcl::FpTag> Fp;
typedef mcl::FpT<mcl::ZnTag> Zn;
typedef mcl::EcT<Fp> Ec;

int main()
{
	/*
		Ec is an elliptic curve over Fp
		the cyclic group of <P> is isomorphic to Zn
	*/
	Ec P;
	mcl::initCurve<Ec, Zn>(MCL_SECP192K1, &P);
	/*
		Alice setups a private key a and public key aP
	*/
	Zn a;
	Ec aP;

	a.setByCSPRNG();
	Ec::mul(aP, P, a); // aP = a * P;

	std::cout << "aP=" << aP << std::endl;

	/*
		Bob setups a private key b and public key bP
	*/
	Zn b;
	Ec bP;

	b.setByCSPRNG();
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

