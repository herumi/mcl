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

CYBOZU_TEST_AUTO(ecdsa)
{
	init();
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
