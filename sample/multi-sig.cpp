#include <mcl/aggregate_sig.hpp>
using namespace mcl::aggs;

void aggregateTest(const std::vector<std::string>& msgVec)
{
        const size_t n = msgVec.size();
        std::vector<SecretKey> secVec(n);
        std::vector<PublicKey> pubVec(n);
        std::vector<Signature> sigVec(n);
        Signature aggSig;
        bool ok;
        for (size_t i = 0; i < n; i++) {
                secVec[i].init();
                secVec[i].getPublicKey(pubVec[i]);
                secVec[i].sign(sigVec[i], msgVec[i]);
                std::cout << "sign " << sigVec[i] << std::endl;
                ok = pubVec[i].verify(sigVec[i], msgVec[i]);
                std::cout << "verify " << (ok ? "ok" : "ng") << std::endl;
        }
        aggSig.aggregate(sigVec);
        std::cout << "aggregate sign " << aggSig << std::endl;
        ok = aggSig.verify(msgVec, pubVec);
        std::cout << "aggregate verify " << (ok ? "ok" : "ng") << std::endl;
}


int main(int argc, char *argv[])
{
        const std::string msgArray[] = { "abc", "12345", "xyz", "pqr", "aggregate signature" };
        const size_t n = sizeof(msgArray) / sizeof(msgArray[0]);
        AGGS::init();

        std::vector<std::string> msgVec(n);
        for (size_t i = 0; i < n; i++) {
                msgVec[i] = msgArray[i];
        }
        aggregateTest(msgVec);
}
