#include <mcl/bn256.hpp>
#include <iostream>

using namespace mcl::bn256;

#define MDEBUG 0 // 1 for debug

// H1: M->Zq
// see https://github.com/herumi/mcl FAQ
template<class F>
void setHash(F& x, const void *msg, size_t msgSize)
{
    uint8_t md[32];
    mcl::fp::sha256(md, sizeof(md), msg, msgSize);
    x.setBigEndianMod(md, sizeof(md));
}


// H0: M->G2
// return P
void Hash(G1& P, const std::string& m)
{
        Fp t;
        t.setHashOf(m);
        mapToG1(P, t);
}

//SkToPk: pub = s * Q 
//rewrite pub
void KeyGen(Fr& s, G2& pub, const G2& Q)
{
        s.setRand();
        G2::mul(pub, Q, s); // pub = sQ
#if MDEBUG
        std::cout << "secret key " << s << std::endl;
        std::cout << "public key " << pub << std::endl;
#endif
}


// Hm = hash_to_point(m)
// sign = s * Hm
// rewrite sign
// https://datatracker.ietf.org/doc/html/draft-irtf-cfrg-bls-signature-04
void CoreSign(G1& sign, const Fr& s, const std::string& m)
{
        G1 Hm;
        Hash(Hm, m);
        G1::mul(sign, Hm, s); // sign = s H(m)
}

//return bool
bool CoreVerify(const G1& sign, const G2& Q, const G2& pub, const std::string& m)
{
        Fp12 e1, e2;
        G1 Hm;
        Hash(Hm, m);
        pairing(e1, sign, Q); // e1 = e(sign, Q)
#if MDEBUG
        std::cout << "e1" << e1 << std::endl;
#endif
        pairing(e2, Hm, pub); // e2 = e(Hm, sQ)
#if MDEBUG
        std::cout << "e2" << e2 << std::endl; 
#endif
        return e1 == e2;
}


// ai <- H1(public_key_i,{public_key_1 ... public_key_n})
// rewrite a
void genA(std::string allP_serialize, std::string cP_serialize, Fr& a) {
        std::string hash_tmp_s;
        hash_tmp_s = cP_serialize + allP_serialize;
        const char* ptr = (const char*)hash_tmp_s.data();
        setHash(a,ptr,hash_tmp_s.size());
} 

//{public_key_1 ... public_key_n}
//concatenation serialize public_key
//return std::string 
std::string sumP(std::vector<G2>& pubKeyVec) {
        std::string allP;
        std::string pubKey_s;

        for (size_t i = 0; i < pubKeyVec.size(); i++) {
                pubKey_s = pubKeyVec[i].getStr(mcl::IoSerialize); // serialize
                allP = allP + pubKey_s;
#if MDEBUG
                printf("pubKey_s data size %d byte\n", (int)pubKey_s.size());
                printf("allP data size %d byte\n", (int)allP.size());
#endif
        } 
        return allP;
}

//P = a1×P1 + a2×P2 + a3×P3 + + anxPn
//rewrite apk, aVec
void KAg(std::vector<G2>& pubKeyVec, G2& apk, std::vector<Fr>& aVec)
{
        const size_t n = pubKeyVec.size();
        std::string allP = sumP(pubKeyVec);
        std::string pubKey_s;
        std::vector<G2> pubKeyTmp(n);

#if MDEBUG
        std::cout << "size pubKeyVec:" << n << std::endl;
#endif

        for (size_t i = 0; i < n; i++) {
#if MDEBUG
                std::cout << "public key " << pubKeyVec[i] << std::endl;
#endif
                pubKey_s = pubKeyVec[i].getStr(mcl::IoSerialize); // serialize
#if MDEBUG
                std::cout << "pubKey_s data size "<< (int)pubKey_s.size() << " byte" << std::endl;
#endif
                genA(allP,pubKey_s,aVec[i]);
#if MDEBUG
                std::cout << "aggregate public key a[" << i << "]:" << aVec[i] << std::endl;
#endif 
                G2::mul(pubKeyTmp[i], pubKeyVec[i], aVec[i]); //aixPi
                G2::add(apk,apk,pubKeyTmp[i]);// P = 0 + a1xP1 ... + anxPn .. P+0=P
        }
}


void Sign(std::vector<Fr>& sk, std::vector<G1>& sign,  const std::string& m) {
        const size_t n = sk.size();
        for (size_t i = 0; i < n; i++) {
                CoreSign(sign[i], sk[i], m); // Si
        }
}

//S = a1×S1 + a2×S2 + a3×S3 + + anxSn
void MultiSign(std::vector<G1>& sign, G1& multisig, std::vector<Fr>& aVec) {
        const size_t n = sign.size();
        std::vector<G1> sign_new(n); // do not modify the original sign
        for (size_t i = 0; i < n; i++) {
                G1::mul(sign_new[i],sign[i],aVec[i]); // aixSi
                G1::add(multisig,multisig,sign_new[i]); // S = 0 + a1×S1 + a2×S2 + a3×S3 + + anxSn .. S+0=S
        }
}


//ref: https://eprint.iacr.org/2018/483.pdf
//ref: https://crypto.stanford.edu/~dabo/pubs/papers/BLSmultisig.html
// The modified BLS multi-signature construction
int main(int argc, char *argv[])
{
        std::string m = argc == 1 ? "hello mcl" : argv[1];
        const size_t n = 1000;

        // setup parameter
        initPairing();
        G2 Q;
        mapToG2(Q, 1); //g2
        G2 apk; 
        G1 multisig;
        mapToG2(apk, 1);
        mapToG1(multisig, 1); 
        G2::sub(apk,apk,apk); // "point at inf" by def P+0=P .. see loop in KAg()
        G1::sub(multisig,multisig,multisig); // "point at inf" by def P+0=P .. see loop in MultiSign()
#if MDEBUG
        std::cout << "apk" << apk << std::endl;
        std::cout << "multisig" << multisig << std::endl;
#endif

        bool ok;
        std::vector<Fr> sk(n); // private info
        std::vector<G2> pubKeyPoint(n); // public info
        std::vector<Fr> a(n); // public info
        std::vector<G1> sign(n);  // public info

        // generate secret key and public key
        for (size_t i = 0; i < n; i++) {
                KeyGen(sk[i], pubKeyPoint[i], Q); //private
         }
        KAg(pubKeyPoint,apk,a); // any can do it
        Sign(sk,sign,m); // only owners of private keys can do this
#if MDEBUG
        std::cout << "aggregate public key " << apk << std::endl;
#endif
        MultiSign(sign, multisig, a);
        ok = CoreVerify(multisig, Q, apk, m);
        std::cout << "verify " << (ok ? "ok" : "ng") << std::endl;
}
