#define PUT(x) std::cout << #x "=" << (x) << std::endl
#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>
#include <mcl/gmp_util.hpp>

#include <mcl/fp.hpp>
typedef mcl::FpT<> Fp_3;
typedef mcl::FpT<> Fp_4;
typedef mcl::FpT<> Fp_6;
typedef mcl::FpT<> Fp_9;
#include <mcl/ec.hpp>
#include <mcl/ecparam.hpp>
#include <time.h>

struct tagZn;
typedef mcl::FpT<tagZn> Zn;

template<class Fp>
struct Test {
	typedef mcl::EcT<Fp> Ec;
	const mcl::EcParam& para;
	Test(const mcl::EcParam& para)
		: para(para)
	{
		Fp::setModulo(para.p);
		Zn::setModulo(para.n);
		Ec::setParam(para.a, para.b);
//		CYBOZU_TEST_EQUAL(para.bitSize, Fp(-1).getBitSize());
	}
	void cstr() const
	{
		Ec O;
		CYBOZU_TEST_ASSERT(O.isZero());
		Ec P;
		Ec::neg(P, O);
		CYBOZU_TEST_EQUAL(P, O);
	}
	void ope() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		Zn n = 0;
		CYBOZU_TEST_ASSERT(Ec::isValid(x, y));
		Ec P(x, y), Q, R, O;
		{
			Ec::neg(Q, P);
			CYBOZU_TEST_EQUAL(Q.x, P.x);
			CYBOZU_TEST_EQUAL(Q.y, -P.y);

			R = P + Q;
			CYBOZU_TEST_ASSERT(R.isZero());

			R = P + O;
			CYBOZU_TEST_EQUAL(R, P);
			R = O + P;
			CYBOZU_TEST_EQUAL(R, P);
		}

		{
			Ec::dbl(R, P);
			Ec R2 = P + P;
			CYBOZU_TEST_EQUAL(R, R2);
			{
				Ec P2 = P;
				Ec::dbl(P2, P2);
				CYBOZU_TEST_EQUAL(P2, R2);
			}
			Ec R3L = R2 + P;
			Ec R3R = P + R2;
			CYBOZU_TEST_EQUAL(R3L, R3R);
			{
				Ec RR = R2;
				RR = RR + P;
				CYBOZU_TEST_EQUAL(RR, R3L);
				RR = R2;
				RR = P + RR;
				CYBOZU_TEST_EQUAL(RR, R3L);
				RR = P;
				RR = RR + RR;
				CYBOZU_TEST_EQUAL(RR, R2);
			}
			Ec::power(R, P, 2);
			CYBOZU_TEST_EQUAL(R, R2);
			Ec R4L = R3L + R2;
			Ec R4R = R2 + R3L;
			CYBOZU_TEST_EQUAL(R4L, R4R);
			Ec::power(R, P, 5);
			CYBOZU_TEST_EQUAL(R, R4L);
		}
		{
			R = P;
			for (int i = 0; i < 10; i++) {
				R += P;
			}
			Ec R2;
			Ec::power(R2, P, 11);
			CYBOZU_TEST_EQUAL(R, R2);
		}
		Ec::power(R, P, n - 1);
		CYBOZU_TEST_EQUAL(R, -P);
		R += P; // Ec::power(R, P, n);
		CYBOZU_TEST_ASSERT(R.isZero());
	}

	void power() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		Ec P(x, y);
		Ec Q;
		Ec R;
		for (int i = 0; i < 100; i++) {
			Ec::power(Q, P, i);
			CYBOZU_TEST_EQUAL(Q, R);
			R += P;
		}
	}

#if 0
	void neg_power() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		Ec P(x, y);
		Ec Q;
		Ec R;
		for (int i = 0; i < 100; i++) {
			Ec::power(Q, P, -i);
			CYBOZU_TEST_EQUAL(Q, R);
			R -= P;
		}
	}
#endif
	void squareRoot() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		bool odd = Fp::isOdd(y);
		Fp yy;
		Ec::getYfromX(yy, x, odd);
		CYBOZU_TEST_EQUAL(yy, y);
		Fp::neg(y, y);
		odd = Fp::isOdd(y);
		yy.clear();
		Ec::getYfromX(yy, x, odd);
		CYBOZU_TEST_EQUAL(yy, y);
	}
	void power_fp() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		Ec P(x, y);
		Ec Q;
		Ec R;
		for (int i = 0; i < 100; i++) {
			Ec::power(Q, P, Zn(i));
			CYBOZU_TEST_EQUAL(Q, R);
			R += P;
		}
	}
	void str() const
	{
		puts("test str");
		const Fp x(para.gx);
		const Fp y(para.gy);
		Ec P(x, y);
		Ec Q;
		// not compressed
		Ec::setCompressedExpression(false);
		{
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
		{
			P = -P;
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
		P.clear();
		{
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
		// compressed
		Ec::setCompressedExpression(true);
		P.set(x, y);
		{
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
		{
			P = -P;
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
		P.clear();
		{
			std::stringstream ss;
			ss << P;
			ss >> Q;
			CYBOZU_TEST_EQUAL(P, Q);
		}
	}

	template<class F>
	void test(F f, const char *msg) const
	{
		const int N = 300000;
		Fp x(para.gx);
		Fp y(para.gy);
		Ec P(x, y);
		Ec Q = P + P + P;
		clock_t begin = clock();
		for (int i = 0; i < N; i++) {
			f(Q, P, Q);
		}
		clock_t end = clock();
		printf("%s %.2fusec\n", msg, (end - begin) / double(CLOCKS_PER_SEC) / N * 1e6);
	}
	/*
		add 8.71usec -> 6.94
		sub 6.80usec -> 4.84
		dbl 9.59usec -> 7.75
		pos 2730usec -> 2153
	*/
	void bench() const
	{
		Fp x(para.gx);
		Fp y(para.gy);
		Ec P(x, y);
		Ec Q = P + P + P;
		CYBOZU_BENCH("add", Ec::add, Q, P, Q);
		CYBOZU_BENCH("sub", Ec::sub, Q, P, Q);
		CYBOZU_BENCH("dbl", Ec::dbl, P, P);
		Zn z("-3");
		CYBOZU_BENCH("pow", Ec::power, P, P, z);
	}
/*
Affine : sandy-bridge
add 3.17usec
sub 2.43usec
dbl 3.32usec
pow 905.00usec
Jacobi
add 2.34usec
sub 2.65usec
dbl 1.56usec
pow 499.00usec
*/
	void run() const
	{
		cstr();
		ope();
		power();
		power_fp();
		squareRoot();
		str();
#ifdef NDEBUG
		bench();
#endif
	}
private:
	Test(const Test&);
	void operator=(const Test&);
};

template<class Fp>
void test_sub(const mcl::EcParam *para, size_t paraNum)
{
	for (size_t i = 0; i < paraNum; i++) {
		puts(para[i].name);
		Test<Fp>(para[i]).run();
	}
}

int g_partial = -1;

CYBOZU_TEST_AUTO(all)
{
#ifdef USE_MONT_FP
	puts("use MontFp");
#else
	puts("use GMP");
#endif
	if (g_partial & (1 << 3)) {
		const struct mcl::EcParam para3[] = {
	//		mcl::ecparam::p160_1,
			mcl::ecparam::secp160k1,
			mcl::ecparam::secp192k1,
			mcl::ecparam::NIST_P192,
		};
		test_sub<Fp_3>(para3, CYBOZU_NUM_OF_ARRAY(para3));
	}

	if (g_partial & (1 << 4)) {
		const struct mcl::EcParam para4[] = {
			mcl::ecparam::secp224k1,
			mcl::ecparam::secp256k1,
			mcl::ecparam::NIST_P224,
			mcl::ecparam::NIST_P256,
		};
		test_sub<Fp_4>(para4, CYBOZU_NUM_OF_ARRAY(para4));
	}

	if (g_partial & (1 << 6)) {
		const struct mcl::EcParam para6[] = {
	//		mcl::ecparam::secp384r1,
			mcl::ecparam::NIST_P384,
		};
		test_sub<Fp_6>(para6, CYBOZU_NUM_OF_ARRAY(para6));
	}

	if (g_partial & (1 << 9)) {
		const struct mcl::EcParam para9[] = {
	//		mcl::ecparam::secp521r1,
			mcl::ecparam::NIST_P521,
		};
		test_sub<Fp_9>(para9, CYBOZU_NUM_OF_ARRAY(para9));
	}
}

int main(int argc, char *argv[])
{
	if (argc == 1) {
		g_partial = -1;
	} else {
		g_partial = 0;
		for (int i = 1; i < argc; i++) {
			g_partial |= 1 << atoi(argv[i]);
		}
	}
	return cybozu::test::autoRun.run(argc, argv);
}
