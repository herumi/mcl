#include <cybozu/test.hpp>
#include <mcl/aggregate_sig.hpp>

using namespace mcl::bn_current;
using namespace mcl::aggs;

CYBOZU_TEST_AUTO(init)
{
	AGGS::init();
	SecretKey sec;
	sec.init();
	PublicKey pub;
	sec.getPublicKey(pub);
	const std::string m = "abc";
	Signature sig;
	sec.sign(sig, m);
	CYBOZU_TEST_ASSERT(pub.verify(sig, m));
}

CYBOZU_TEST_AUTO(aggregate)
{
	const std::string msgArray[] = { "abc", "12345", "xyz", "pqr", "aggregate signature" };
	const size_t n = sizeof(msgArray) / sizeof(msgArray[0]);
	std::vector<std::string> msgVec(n);
	for (size_t i = 0; i < n; i++) {
		msgVec[i] = msgArray[i];
	}
	std::vector<SecretKey> secVec(n);
	std::vector<PublicKey> pubVec(n);
	std::vector<Signature> sigVec(n);
	Signature aggSig;
	for (size_t i = 0; i < n; i++) {
		secVec[i].init();
		secVec[i].getPublicKey(pubVec[i]);
		secVec[i].sign(sigVec[i], msgVec[i]);
		CYBOZU_TEST_ASSERT(pubVec[i].verify(sigVec[i], msgVec[i]));
	}
	aggSig.aggregate(sigVec);
	CYBOZU_TEST_ASSERT(aggSig.verify(msgVec, pubVec));
}
