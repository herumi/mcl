#include <mcl/bls12_381.hpp>
#include <mcl/ntt.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>

using namespace mcl::bls12;
using namespace mcl;

template<class T>
std::string sub(const T& x)
{
	std::string s = x.getStr();
	return s;
	const size_t N = 3;
	size_t n = s.size();
	if (n < N * 2) return s;
	return s.substr(0, N) + "..." + s.substr(s.size() - N, N-1);
}

/*
	out[i] = sum_{j=0}^{t-1} in[j] ws[i]^j  for i = 0, ..., n-1
*/
template<class G>
void nttNaive(G *out, const G *in, size_t n, const Fr *ws)
{
	for (size_t i = 0; i < n; i++) {
		Fr t = ws[i];
		G y = in[0];
		for (size_t j = 1; j < n; j++) {
			y += in[j] * t;
			t *= ws[i];
		}
		out[i] = y;
	}
}

CYBOZU_TEST_AUTO(bitRev)
{
	mcl::local::BitReverse br;
	const int tbl[] = {
		0, 16, 8, 24, 4, 20, 12, 28, 2, 18, 10, 26, 6, 22, 14, 30, 1, 17, 9, 25
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		CYBOZU_TEST_EQUAL(br.rev(i, 5), tbl[i]);
	}
	cybozu::XorShift rg;
	for (size_t bitLen = 1; bitLen < 64; bitLen++) {
		for (size_t i = 0; i < 10; i++) {
			uint64_t x = rg.get64();
			uint64_t a = br.genericRev(x, bitLen);
			uint64_t b = br.rev(x, bitLen);
			CYBOZU_TEST_EQUAL(a, b);
		}
	}
}

template<class T>
void copy(T *out, const T *in, size_t n)
{
	for (size_t i = 0; i < n; i++) out[i] = in[i];
}

const size_t maxBitN = 8;

template<class NTT, class G>
void test_sub(NTT& ntt, const G *in, size_t bitN)
{
	const size_t maxN = 1 << maxBitN;
	const size_t n = size_t(1) << bitN;
	ntt.init(n);
	G out[maxN], out2[maxN];
	printf("n=%zd\n", n);

	copy(out, in, n);
	ntt.ntt(out, n);

#if 0
	// compare ntt and naieve
	nttNaive(out2, in, n, ntt.getWs());
	CYBOZU_TEST_EQUAL_ARRAY(out, out2, n);
#endif

	// check intt(ntt(in)) == in
	copy(out2, out, n);
	ntt.intt(out2, n);
	CYBOZU_TEST_EQUAL_ARRAY(out2, in, n);
}

template<class NTT, class G>
void test(NTT& ntt, const G *in, size_t maxBitN)
{
#if 0
	(void)maxBitN;
	test_sub<NTT, G>(ntt, in, 4);
#else
	for (size_t bitN = 1; bitN <= maxBitN; bitN++) {
		test_sub<NTT, G>(ntt, in, bitN);
	}
#endif
}

CYBOZU_TEST_AUTO(generic)
{
	const size_t maxN = 1 << maxBitN;

	initPairing(mcl::BLS12_381);
	Fr inFr[maxN];
	G1 inG1[maxN];
	cybozu::XorShift rg;

	// set random values
	for (size_t i = 0; i < maxN; i++) {
		inFr[i].setByCSPRNG(rg);
		inFr[i] = (i+1)*7;
		char v[2] = { char(i / 256), char(i % 256) };
		hashAndMapToG1(inG1[i], v, 2);
	}
	typedef mcl::NTT<Fr> NTT;
	NTT ntt;

	puts("Fr");
	test<NTT, Fr>(ntt, inFr, maxBitN);
	puts("G1");
	test<NTT, G1>(ntt, inG1, maxBitN);
}
