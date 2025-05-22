#include <cybozu/test.hpp>
#include <mcl/window_method.hpp>
#include <mcl/ecparam.hpp>
#include <mcl/g1_def.hpp>

using namespace mcl;
typedef G1 Ec;

CYBOZU_TEST_AUTO(int)
{
	const struct mcl::EcParam& para = mcl::ecparam::secp192k1;
	Fp::init(para.p);
	Fr::init(para.n);
	Ec::init(para.a, para.b);
	const Fp x(para.gx);
	const Fp y(para.gy);
	const Ec P(x, y);

	typedef mcl::fp::WindowMethod<Ec> PW;
	const size_t bitSize = 13;
	Ec Q, R;

	for (size_t winSize = 10; winSize <= bitSize; winSize++) {
		PW pw(P, bitSize, winSize);
		for (int i = 0; i < (1 << bitSize); i++) {
			pw.mul(Q, i);
			Ec::mul(R, P, i);
			CYBOZU_TEST_EQUAL(Q, R);
		}
	}
	PW pw(P, para.bitSize, 10);
	pw.mul(Q, -12345);
	Ec::mul(R, P, -12345);
	CYBOZU_TEST_EQUAL(Q, R);
	mpz_class t(para.gx);
	Fr r;
	r.setMpz(t);
	pw.mul(Q, t);
	Ec::mul(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);
	t = -t;
	pw.mul(Q, t);
	Ec::mul(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.mul(Q, r);
	Ec::mul(R, P, r);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.mul(Q, r);
	Ec::mul(R, P, r);
	CYBOZU_TEST_EQUAL(Q, R);
}
