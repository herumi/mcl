#include <cybozu/test.hpp>
#include <mcl/window_method.hpp>
#include <mcl/ec.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>

CYBOZU_TEST_AUTO(ArrayIterator)
{
	const uint32_t in[] = { 0x12345678, 0xabcdef89, 0xaabbccdd };
	for (size_t bitSize = 1; bitSize <= 64; bitSize++) {
		for (size_t w = 1; w <= 32; w++) {

			const uint32_t mask = uint32_t((uint64_t(1) << w) - 1);
			mpz_class x;
			mcl::gmp::setArray(x, in, CYBOZU_NUM_OF_ARRAY(in));
			x &= (mpz_class(1) << bitSize) - 1;
			mcl::fp::ArrayIterator<uint32_t> ai(in, bitSize, w);
			size_t n = (bitSize + w - 1) / w;
			for (size_t j = 0; j < n; j++) {
				CYBOZU_TEST_ASSERT(ai.hasNext());
				uint32_t v = ai.getNext();
				CYBOZU_TEST_EQUAL(x & mask, v);
				x >>= w;
			}
			CYBOZU_TEST_ASSERT(!ai.hasNext());
		}
	}
}

CYBOZU_TEST_AUTO(int)
{
	typedef mcl::FpT<> Fp;
	typedef mcl::EcT<Fp> Ec;
	const struct mcl::EcParam& para = mcl::ecparam::secp192k1;
	Fp::init(para.p);
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
	pw.mul(Q, t);
	Ec::mul(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);
	t = -t;
	pw.mul(Q, t);
	Ec::mul(R, P, t);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.mul(Q, x);
	Ec::mul(R, P, x);
	CYBOZU_TEST_EQUAL(Q, R);

	pw.mul(Q, y);
	Ec::mul(R, P, y);
	CYBOZU_TEST_EQUAL(Q, R);
}
