#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

struct FpTag;
typedef mcl::FpT<FpTag, 384> Fp;

void put(const void *buf, size_t bufSize)
{
	const unsigned char* p = (const unsigned char*)buf;
	for (size_t i = 0; i < bufSize; i++) {
		printf("%02x", p[i]);
	}
	printf("\n");
}

static int ccc_mul;
static int ccc_sqr;

template<class F, typename T>
void powC(F& z, const F& x, const T *yTbl, size_t yn)
{
	const size_t w = 4;
	const size_t N = 1 << w;
	uint8_t idxTbl[256/w];
	mcl::fp::ArrayIterator<T> iter(yTbl, sizeof(T) * 8 * yn, w);
	size_t idxN = 0;
	while (iter.hasNext()) {
		assert(idxN < sizeof(idxTbl));
		idxTbl[idxN++] = iter.getNext();
	}
	assert(idxN > 0);
	F tbl[N];
	tbl[1] = x;
	for (size_t i = 2; i < N; i++) {
		tbl[i] = tbl[i-1] * x;
ccc_mul++;
	}
	z = tbl[idxTbl[idxN - 1]];
	for (size_t i = 1; i < idxN; i++) {
		for (size_t j = 0; j < w; j++) {
			F::sqr(z, z);
ccc_sqr++;
		}
		uint32_t idx = idxTbl[idxN - 1 - i];
		if (idx) {
			z *= tbl[idx];
ccc_mul++;
		}
	}
}

inline size_t getBinary(uint8_t *bin, size_t maxBinN, mpz_class x, size_t w)
{
	if (w == 0 || w >= 8) return 0;
	size_t binN = 0;
	size_t zeroNum = 0;
	const size_t maskW = (1u << w) - 1;
	using namespace mcl::gmp;
	while (!isZero(x)) {
		size_t z = getLowerZeroBitNum(x);
		if (z) {
			x >>= z;
			zeroNum += z;
		}
		for (size_t i = 0; i < zeroNum; i++) {
			if (binN == maxBinN) return 0;
			bin[binN++] = 0;
		}
		int v = getUnit(x)[0] & maskW;
		x >>= w;
		if (binN == maxBinN) return 0;
		bin[binN++] = v;
		zeroNum = w - 1;
	}
	return binN;
}

template<class F, size_t w = 5>
void pow3(F& z, const F& x, const mpz_class& y)
{
	assert(y >= 0);
	assert(w > 0);
	if (y == 0) {
		z = 1;
		return;
	}
	const size_t tblSize = 1 << (w - 1);
	uint8_t bin[sizeof(F) * 8];
	F tbl[tblSize];
	mpz_class u;
	size_t binN = getBinary(bin, sizeof(bin), y, w);

	F x2;
	F::sqr(x2, x);
ccc_sqr++;
	tbl[0] = x;
	for (size_t i = 1; i < tblSize; i++) {
		F::mul(tbl[i], tbl[i - 1], x2);
ccc_mul++;
	}
	z = 1;
	for (size_t i = 0; i < binN; i++) {
		const size_t bit = binN - 1 - i;
		F::sqr(z, z);
ccc_sqr++;
		uint8_t n = bin[bit];
		if (n > 0) {
			z *= tbl[(n - 1) >> 1];
ccc_mul++;
		}
	}
}

template<class T>
void pow2(T& z, const T& x, const mpz_class& y)
{
	powC(z, x, mcl::gmp::getUnit(y), mcl::gmp::getUnitSize(y));
}

template<class T, class F>
void pow2(T& z, const T& x, const F& y_)
{
	mpz_class y = y_.getMpz();
	powC(z, x, mcl::gmp::getUnit(y), mcl::gmp::getUnitSize(y));
}

template<class T, class F>
void pow3(T& z, const T& x, const F& y_)
{
	mpz_class y = y_.getMpz();
	pow3(z, x, y);
}

void bench(const char *name, const char *pStr)
{
	printf("bench name=%s\n", name);
	Fp::init(pStr);
	const int C = 10000;
	cybozu::XorShift rg;
	Fp x, y;
	for (int i = 0; i < 100; i++) {
		x.setByCSPRNG(rg);
		y.setByCSPRNG(rg);
		Fp t1, t2;
		Fp::pow(t1, x, y);
		pow3(t2, x, y.getMpz());
		CYBOZU_TEST_EQUAL(t1, t2);
	}
	CYBOZU_BENCH_C("Fp::add", C, Fp::add, x, x, y);
	CYBOZU_BENCH_C("Fp::sub", C, Fp::sub, x, x, y);
	CYBOZU_BENCH_C("Fp::mul", C, Fp::mul, x, x, y);
	CYBOZU_BENCH_C("Fp::sqr", C, Fp::sqr, x, x);
	CYBOZU_BENCH_C("Fp::inv", C, Fp::inv, x, x);
	CYBOZU_BENCH_C("Fp::pow", C, Fp::pow, x, x, x);
ccc_mul=0;
ccc_sqr=0;
	CYBOZU_BENCH_C("pow2", C, pow2, x, x, x);
printf("mul=%d sqr=%d\n", ccc_mul, ccc_sqr);
ccc_mul=0;
ccc_sqr=0;
	CYBOZU_BENCH_C("pow3", C, pow3, x, x, x);
printf("mul=%d sqr=%d\n", ccc_mul, ccc_sqr);
}

CYBOZU_TEST_AUTO(main)
{
	const struct {
		const char *name;
		const char *pStr;
	} tbl[] = {
		{ "secp256k1p", mcl::ecparam::secp256k1.p },
		{ "secp256k1r", mcl::ecparam::secp256k1.n },
		{ "bn254r", "0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d" },
		{ "bn254p", "0x2523648240000001ba344d80000000086121000000000013a700000000000013" },
		{ "bls12_381p", "0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001" },
		{ "bls12_381r", "0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab" },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		bench(tbl[i].name, tbl[i].pStr);
	}
}

