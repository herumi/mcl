#include <cybozu/test.hpp>
#include <mcl/window_method.hpp>
#include <mcl/ec.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>

CYBOZU_TEST_AUTO(ArrayIterator)
{
	const uint32_t in[2] = { 0x12345678, 0xabcdef89 };
	const size_t bitLen = 64;
	for (size_t w = 1; w <= 32; w++) {
		const uint32_t mask = uint32_t((uint64_t(1) << w) - 1);
		mpz_class x;
		mcl::Gmp::setArray(x, in, 2);
		mcl::fp::ArrayIterator<uint32_t> ai(in, bitLen, w);
		size_t n = (bitLen + w - 1) / w;
		for (size_t j = 0; j < n; j++) {
			CYBOZU_TEST_ASSERT(ai.hasNext());
			uint32_t v = ai.getNext();
			CYBOZU_TEST_EQUAL(v, x & mask);
			x >>= w;
		}
		CYBOZU_TEST_ASSERT(!ai.hasNext());
	}
}

CYBOZU_TEST_AUTO(int)
{
	typedef mcl::FpT<> Fp;
	typedef mcl::EcT<Fp> Ec;
	const struct mcl::EcParam& para = mcl::ecparam::secp192k1;
	Fp::setModulo(para.p);
	Ec::setParam(para.a, para.b);
	const Fp x(para.gx);
	const Fp y(para.gy);
	const Ec P(x, y);

	typedef mcl::fp::WindowMethod<Ec> PW;
	const size_t bitLen = 16;
	Ec Q, R;

	for (size_t winSize = 2; winSize <= bitLen; winSize += 3) {
		PW pw(P, bitLen, winSize);
		for (int i = 0; i < (1 << bitLen); i++) {
			pw.power(Q, i);
			Ec::power(R, P, i);
			CYBOZU_TEST_EQUAL(Q, R);
		}
	}
	PW pw(P, para.bitLen, 10);
	pw.power(Q, -12345);
	Ec::power(R, P, -12345);
	CYBOZU_TEST_EQUAL(Q, R);
	mpz_class t(para.gx);
	pw.power(Q, t);
	Ec::power(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);
	t = -t;
	pw.power(Q, t);
	Ec::power(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.power(Q, x);
	Ec::power(R, P, x);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.power(Q, y);
	Ec::power(R, P, y);
	CYBOZU_TEST_EQUAL(Q, R);
}
