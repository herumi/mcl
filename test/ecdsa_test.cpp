#define PUT(x) std::cout << #x "=" << (x) << std::endl;
#include <stdlib.h>
#include <stdio.h>
void put(const void *buf, size_t bufSize)
{
	const unsigned char* p = (const unsigned char*)buf;
	for (size_t i = 0; i < bufSize; i++) {
		printf("%02x", p[i]);
	}
	printf("\n");
}
#include <mcl/ecdsa.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

using namespace mcl::ecdsa;

typedef mcl::FixedArray<int8_t, 256 / 2 + 2> NafArray;

template<class G>
void addTbl(G& Q, const G *tbl, const NafArray& naf, size_t i)
{
	if (i >= naf.size()) return;
	int n = naf[i];
	if (n > 0) {
		Q += tbl[(n - 1) >> 1];
	} else if (n < 0) {
		Q -= tbl[(-n - 1) >> 1];
	}
}

using namespace mcl;

template<class G1>
struct GLV1 {
	Fp rw; // rw = 1 / w = (-1 - sqrt(-3)) / 2
	size_t rBitSize;
	mpz_class v0, v1;
	mpz_class B[2][2];
	mpz_class r;
private:
public:
	bool operator==(const GLV1& rhs) const
	{
		return rw == rhs.rw && rBitSize == rhs.rBitSize && v0 == rhs.v0 && v1 == rhs.v1
			&& B[0][0] == rhs.B[0][0] && B[0][1] == rhs.B[0][1] && B[1][0] == rhs.B[1][0]
			&& B[1][1] == rhs.B[1][1] && r == rhs.r;
	}
	bool operator!=(const GLV1& rhs) const { return !operator==(rhs); }
#ifndef CYBOZU_DONT_USE_STRING
	void dump(const mpz_class& x) const
	{
		printf("\"%s\",\n", mcl::gmp::getStr(x, 16).c_str());
	}
	void dump() const
	{
		printf("\"%s\",\n", rw.getStr(16).c_str());
		printf("%d,\n", (int)rBitSize);
		dump(v0);
		dump(v1);
		dump(B[0][0]); dump(B[0][1]); dump(B[1][0]); dump(B[1][1]);
		dump(r);
	}
#endif
	void init(const mpz_class& r, const mpz_class& z, bool isBLS12 = false, int curveType = -1)
	{
	}
	/*
		L = lambda = p^4
		L (x, y) = (rw x, y)
	*/
	void mulLambda(G1& Q, const G1& P) const
	{
		Fp::mul(Q.x, P.x, rw);
		Q.y = P.y;
		Q.z = P.z;
	}
	/*
		x = a + b * lambda mod r
	*/
	void split(mpz_class& a, mpz_class& b, const mpz_class& x) const
	{
		mpz_class t;
//		t = (x * v0) >> rBitSize;
//		b = (x * v1) >> rBitSize;
t = (B[1][1] * x) / r;
b = (-B[0][1] * x) / r;
		a = x - (t * B[0][0] + b * B[1][0]);
		b = - (t * B[0][1] + b * B[1][1]);
	}
	void mul(G1& Q, const G1& P, mpz_class x, bool constTime = false) const
	{
		const int w = 5;
		const size_t tblSize = 1 << (w - 2);
		NafArray naf[2];
		mpz_class u[2];
		G1 tbl[2][tblSize];
		bool b;

		x %= r;
		if (x == 0) {
			Q.clear();
			if (!constTime) return;
		}
		if (x < 0) {
			x += r;
		}
		split(u[0], u[1], x);
		gmp::getNAFwidth(&b, naf[0], u[0], w);
		assert(b); (void)b;
		gmp::getNAFwidth(&b, naf[1], u[1], w);
		assert(b); (void)b;

		tbl[0][0] = P;
		mulLambda(tbl[1][0], tbl[0][0]);
		{
			G1 P2;
			G1::dbl(P2, P);
			for (size_t i = 1; i < tblSize; i++) {
				G1::add(tbl[0][i], tbl[0][i - 1], P2);
				mulLambda(tbl[1][i], tbl[0][i]);
			}
		}
		const size_t maxBit = fp::max_(naf[0].size(), naf[1].size());
		Q.clear();
		for (size_t i = 0; i < maxBit; i++) {
			G1::dbl(Q, Q);
			addTbl(Q, tbl[0], naf[0], maxBit - 1 - i);
			addTbl(Q, tbl[1], naf[1], maxBit - 1 - i);
		}
	}
};

static GLV1<Ec> glv1;

inline void mulArrayEc(Ec& z, const Ec& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
{
	mpz_class s;
	bool b;
	mcl::gmp::setArray(&b, s, y, yn);
	assert(b);
	if (isNegative) s = -s;
	glv1.mul(z, x, s, constTime);
}

void initGLV()
{
	const mcl::ecdsa::local::Param& p = mcl::ecdsa::local::getParam();
	const mcl::EcParam& ecParam = p.ecParam;
	{
		Fp& rw = glv1.rw;
		bool b = Fp::squareRoot(rw, -3);
		assert(b);
		printf("b=%d\n", b);
		if (!b) exit(1);
		rw = -(rw + 1) / 2;
		glv1.r = ecParam.n;
		glv1.rBitSize = gmp::getBitSize(glv1.r);
		glv1.rBitSize = (glv1.rBitSize + fp::UnitBitSize - 1) & ~(fp::UnitBitSize - 1);
		gmp::setStr(glv1.B[0][0], "0x3086d221a7d46bcde86c90e49284eb15");
		gmp::setStr(glv1.B[0][1], "-0xe4437ed6010e88286f547fa90abfe4c3");
		gmp::setStr(glv1.B[1][0], "0x114ca50f7a8e2f3f657c1108d9d44cfd8");
		glv1.B[1][1] = glv1.B[0][0];
		glv1.v0 = ((-glv1.B[1][1]) << glv1.rBitSize) / glv1.r;
		glv1.v1 = ((glv1.B[1][0]) << glv1.rBitSize) / glv1.r;
	}
	PUT(p.P);
	Ec Q1, Q2;
	mpz_class L;
	gmp::setStr(L, "0x5363ad4cc05c30e0a5261c028812645a122e22ea20816678df02967c1b23bd72");
	PUT(L);
	Ec::mul(Q1, p.P, L);
	PUT(Q1);
	glv1.mulLambda(Q2, p.P);
	PUT(Q2);
	PUT(Q1 == Q2);
	// enable GLV
	Ec::setMulArrayGLV(mulArrayEc);
}


CYBOZU_TEST_AUTO(ecdsa)
{
	init();
	initGLV();
	SecretKey sec;
	PublicKey pub;
	sec.setByCSPRNG();
	getPublicKey(pub, sec);
	Signature sig;
	const std::string msg = "hello";
	sign(sig, sec, msg.c_str(), msg.size());
	CYBOZU_TEST_ASSERT(verify(sig, pub, msg.c_str(), msg.size()));
	sig.s += 1;
	CYBOZU_TEST_ASSERT(!verify(sig, pub, msg.c_str(), msg.size()));
}

CYBOZU_TEST_AUTO(value)
{
	const std::string msg = "hello";
	const char *secStr  = "83ecb3984a4f9ff03e84d5f9c0d7f888a81833643047acc58eb6431e01d9bac8";
	const char *pubxStr = "653bd02ba1367e5d4cd695b6f857d1cd90d4d8d42bc155d85377b7d2d0ed2e71";
	const char *pubyStr = "04e8f5da403ab78decec1f19e2396739ea544e2b14159beb5091b30b418b813a";
	const char *sigStr = "a598a8030da6d86c6bc7f2f5144ea549d28211ea58faa70ebf4c1e665c1fe9b5de5d79a2ba44e311d04fdca263639283965780bce9169822be9cc81756e95a24";

	SecretKey sec;
	sec.setStr(secStr, 16);
	CYBOZU_TEST_EQUAL(sec.getStr(16), secStr);
	PublicKey pub;
	getPublicKey(pub, sec);
	pub.normalize();
	Ec t(Fp(pubxStr, 16), Fp(pubyStr, 16));
	CYBOZU_TEST_EQUAL(pub, t);
	Signature sig;
	sig.r.setStr(std::string(sigStr, 64), 16);
	sig.s.setStr(std::string(sigStr + 64, 64), 16);
	PUT(sig);
	CYBOZU_TEST_ASSERT(verify(sig, pub, msg.c_str(), msg.size()));
}

CYBOZU_TEST_AUTO(bench)
{
	const std::string msg = "hello";
	SecretKey sec;
	PublicKey pub;
	PrecomputedPublicKey ppub;
	sec.setByCSPRNG();
	getPublicKey(pub, sec);
	ppub.init(pub);
	Signature sig;
	CYBOZU_BENCH_C("sign", 1000, sign, sig, sec, msg.c_str(), msg.size());
	CYBOZU_BENCH_C("pub.verify ", 1000, verify, sig, pub, msg.c_str(), msg.size());
	CYBOZU_BENCH_C("ppub.verify", 1000, verify, sig, ppub, msg.c_str(), msg.size());
}
