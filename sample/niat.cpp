#include <mcl/bls12_381.hpp>

using namespace mcl::bn;

G1 P;   // generator g1 of G1
G2 Q;   // generator g2 of G2

struct eqsig {
    G1 Z, Y1;
    G2 Y2;
};

struct niat_token {
    G1 tag[3];
    eqsig sig;
};

struct nizkpf
{
    Fr c0, c1, as, a0, a1, a2;
};

struct niat_psig {
    eqsig sig;
    G1 S, T;
    nizkpf pi;
    std::string r;
};

void EQKeyGen(Fr *sk, G2 pk[3]) {
    for (int i = 0; i < 3; i++) {
        sk[i].setRand();
        G2::mul(pk[i], Q, sk[i]);
    }
}

void HashtoG1(G1& X, const std::string& x) {
    Fp tmp;
    tmp.setHashOf(x);
    mapToG1(X, tmp);
}

void EQSign(eqsig *s, G1 m[3], const Fr sk[3]) {
    Fr nu, nu_inv;
    G1 tmp;
    nu.setRand();
    Fr::inv(nu_inv, nu);

    G1::mul(s->Y1, P, nu_inv);   // Y1 = g1^(1/r)
    G2::mul(s->Y2, Q, nu_inv);   // Y2 = g2^(1/r)

    G1::mul(s->Z, m[0], sk[0]); // Z = (m1^x1 * m2^x2 * m3^x3)^nu
    G1::mul(tmp, m[1], sk[1]);
    G1::add(s->Z, s->Z, tmp);
    G1::mul(tmp, m[2], sk[2]);
    G1::add(s->Z, s->Z, tmp);
    G1::mul(s->Z, s->Z, nu);
}

bool EQVerify(const G2 pk[3], G1 m[3], eqsig s) {
    Fp12 e[4];
    pairing(e[0], m[0], pk[0]);
    pairing(e[1], m[1], pk[1]);
    Fp12::mul(e[1], e[0], e[1]);
    pairing(e[2], m[2], pk[2]);
    Fp12::mul(e[2], e[1], e[2]);
    pairing(e[3], s.Z, s.Y2);
    return (e[2] == e[3]); // e(m1, pk1) * e(m2, pk2) * e(m3, pk3) = e(Z, Y2)
}

void EQChRep(eqsig *s_, G1 m[3], eqsig s, const Fr mu, const G2 pk[3]) {
    bool ok = EQVerify(pk, m, s);
    if (!ok) {
        throw std::runtime_error("EQChRep: cannot verify signature.");
    }

    Fr psi, psi_inv;
    psi.setRand();
    Fr::inv(psi_inv, psi);

    G1::mul(s_->Y1, s.Y1, psi_inv);     //Y1' = Y1^(1/psi)}
    G2::mul(s_->Y2, s.Y2, psi_inv);     //Y2' = Y2^(1/psi)}

    Fr::mul(psi, psi, mu);
    G1::mul(s_->Z, s.Z, psi);          // Z' = Z^(mu * psi)
}

void NIZKProve(const G1 pkC, const G2 pkI[3], niat_psig *psig, Fr skI[3], Fr s, int b){
    G2 W0, W1;
    W0 = pkI[1];
    G2::add(W1, pkI[0], pkI[1]);

    if (b == 0) {
        Fr rs, r0, c1, a1, a2;
        rs.setRand(); r0.setRand();
        c1.setRand(); a1.setRand(); a2.setRand();

        G1 Rs, R1, R3, tmp1; G2 R2, R4, tmp2;
        Fr minusc1;
        Fr::neg(minusc1, c1);

        G1::mul(Rs, P, rs);

        G1::mul(R1, psig->S, r0);

        G2::mul(R2, Q, r0);

        G1::mul(R3, pkC, a1);
        G1::mul(tmp1, psig->S, a2);
        G1::add(R3, R3, tmp1);
        G1::mul(tmp1, psig->T, minusc1);
        G1::add(R3, R3, tmp1);

        G2::mul(R4, Q, a1);
        G2::mul(tmp2, Q, a2);
        G2::add(R4, R4, tmp2);
        G2::mul(tmp2, W1, minusc1);
        G2::add(R4, R4, tmp2);

        std::string cstr =  "<beg> P: " + P.getStr() + "\n Q: " + Q.getStr() + 
                        "\n pkC: " + pkC.getStr() + "\n S: " + psig->S.getStr() +
                        "\n T: " + psig->T.getStr() + "\n W0: " + W0.getStr() + 
                        "\n W1: " + W1.getStr() + "\n Rs: " + Rs.getStr() + 
                        "\n R1: " + R1.getStr() + "\n R2: " + R2.getStr() + 
                        "\n R3: " + R3.getStr() + "\n R4: " + R4.getStr() + 
                        "<end>";
        Fr c;
        c.setHashOf(cstr);
        
        Fr as, c0, a0, tmp;
        Fr::mul(tmp, c, s);
        Fr::add(as, rs, tmp);       // as = rs + c * s
        Fr::add(c0, c, minusc1);    // c0 = c - c1
        Fr::mul(tmp, c0, skI[1]);
        Fr::add(a0, r0, tmp);       // a0 = r0 + c0 * x2

        psig->pi.c0 = c0;
        psig->pi.c1 = c1;
        psig->pi.as = as;
        psig->pi.a0 = a0;
        psig->pi.a1 = a1;
        psig->pi.a2 = a2;

    }
    else if (b == 1) {
        Fr rs, r1, r2, c0, a0;
        rs.setRand(); r1.setRand();
        r2.setRand(); c0.setRand(); a0.setRand();

        G1 Rs, R1, R3, tmp1; G2 R2, R4, tmp2;
        Fr minusc0;
        Fr::neg(minusc0, c0);

        G1::mul(Rs, P, rs);

        G1::mul(R1, psig->S, a0);
        G1::mul(tmp1, psig->T, minusc0);
        G1::add(R1, R1, tmp1);

        G2::mul(R2, Q, a0);
        G2::mul(tmp2, W0, minusc0);
        G2::add(R2, R2, tmp2);

        G1::mul(R3, pkC, r1);
        G1::mul(tmp1, psig->S, r2);
        G1::add(R3, R3, tmp1);

        G2::mul(R4, Q, r1);
        G2::mul(tmp2, Q, r2);
        G2::add(R4, R4, tmp2);

        std::string cstr =  "<beg> P: " + P.getStr() + "\n Q: " + Q.getStr() + 
                        "\n pkC: " + pkC.getStr() + "\n S: " + psig->S.getStr() +
                        "\n T: " + psig->T.getStr() + "\n W0: " + W0.getStr() + 
                        "\n W1: " + W1.getStr() + "\n Rs: " + Rs.getStr() + 
                        "\n R1: " + R1.getStr() + "\n R2: " + R2.getStr() + 
                        "\n R3: " + R3.getStr() + "\n R4: " + R4.getStr() + 
                        "<end>";
        Fr c;
        c.setHashOf(cstr);

        Fr as, c1, a1, a2, tmp;
        Fr::mul(tmp, c, s);
        Fr::add(as, rs, tmp);
        Fr::add(c1, c, minusc0);
        Fr::mul(tmp, c1, skI[0]);
        Fr::add(a1, r1, tmp);
        Fr::mul(tmp, c1, skI[1]);
        Fr::add(a2, r2, tmp);

        psig->pi.c0 = c0;
        psig->pi.c1 = c1;
        psig->pi.as = as;
        psig->pi.a0 = a0;
        psig->pi.a1 = a1;
        psig->pi.a2 = a2;
    }
}

bool NIZKVerify(const G1 pkC, const G2 pkI[3], niat_psig psig){
    G1 Rs, R1, R3, tmp1; G2 W0, W1, R2, R4, tmp2;
    W0 = pkI[1];
    G2::add(W1, pkI[0], pkI[1]);

    Fr c, minusc, minusc0, minusc1;
    
    Fr::add(c, psig.pi.c0, psig.pi.c1);
    Fr::neg(minusc, c);
    G1::mul(Rs, P, psig.pi.as);
    G1::mul(tmp1, psig.S, minusc);
    G1::add(Rs, Rs, tmp1);
    
    Fr::neg(minusc0, psig.pi.c0);
    G1::mul(R1, psig.S, psig.pi.a0);
    G1::mul(tmp1, psig.T, minusc0);
    G1::add(R1, R1, tmp1);
    
    G2::mul(R2, Q, psig.pi.a0);
    G2::mul(tmp2, W0, minusc0);
    G2::add(R2, R2, tmp2);

    Fr::neg(minusc1, psig.pi.c1);
    G1::mul(R3, pkC, psig.pi.a1);
    G1::mul(tmp1, psig.S, psig.pi.a2);
    G1::add(R3, R3, tmp1);
    G1::mul(tmp1, psig.T, minusc1);
    G1::add(R3, R3, tmp1);

    G2::mul(R4, Q, psig.pi.a1);
    G2::mul(tmp2, Q, psig.pi.a2);
    G2::add(R4, R4, tmp2);
    G2::mul(tmp2, W1, minusc1);
    G2::add(R4, R4, tmp2);

    std::string cstr =  "<beg> P: " + P.getStr() + "\n Q: " + Q.getStr() + 
                        "\n pkC: " + pkC.getStr() + "\n S: " + psig.S.getStr() +
                        "\n T: " + psig.T.getStr() + "\n W0: " + W0.getStr() + 
                        "\n W1: " + W1.getStr() + "\n Rs: " + Rs.getStr() + 
                        "\n R1: " + R1.getStr() + "\n R2: " + R2.getStr() + 
                        "\n R3: " + R3.getStr() + "\n R4: " + R4.getStr() + 
                        "<end>";
    Fr c_;
    c_.setHashOf(cstr);

    return (c == c_);
}


void NIATClientKeyGen(Fr& skC, G1& pkC) {
    skC.setRand();
    G1::mul(pkC, P, skC);
}

void NIATIssue(G2 pkI[3], niat_psig *psig, Fr skI[3], const G1& pkC, int b) {
    psig->r = "random r is hardcoded for now!";
    Fr s;
    s.setRand();
    G1::mul(psig->S, P, s); // S = g1^s

    G1 x2S;
    G1::mul(x2S, psig->S, skI[1]);
    
    // T = pkC^(b * x1) * S^(x2)
    if (b == 0) {
        psig->T = x2S;
    }
    else if (b == 1) {
        G1::mul(psig->T, pkC, skI[0]);
        G1::add(psig->T, psig->T, x2S);
    }

    G1 m[3];
    m[0] = pkC;
    HashtoG1(m[1], psig->r);
    m[2] = psig->T;

    eqsig sig_;
    EQSign(&sig_, m, skI);
    psig->sig = sig_;

    NIZKProve(pkC, pkI, psig, skI, s, b);
}

void NIATObtain(niat_token *t, const Fr skC, const G1& pkC, G2 pkI[3], niat_psig psig) {
    G1 m[3], Hr;
    HashtoG1(Hr, psig.r);
    m[0] = pkC;
    m[1] = Hr;
    m[2] = psig.T;

    if (!EQVerify(pkI, m, psig.sig) || ! NIZKVerify(pkC, pkI, psig)) {
        throw std::runtime_error("NIATObtain: cannot verify presignature.");
    }

    Fr alpha_inv;
    Fr::inv(alpha_inv, skC);

    G1::mul(t->tag[0], Hr, alpha_inv);
    G1::mul(t->tag[1], psig.T, alpha_inv);
    G1::mul(t->tag[2], psig.S, alpha_inv);

    eqsig sig;
    EQChRep(&sig, m, psig.sig, alpha_inv, pkI);
    t->sig = sig;
}

int NIATReadBit(Fr skI[3], G2 pkI[3], niat_token t) {
    if (EQVerify(pkI, t.tag, t.sig)) { return -1; }

    G1 lhs, rhs;
    G1::mul(rhs, P, skI[0]);

    Fr minusx2;
    Fr::neg(minusx2, skI[1]);
    G1::mul(lhs, t.tag[2], minusx2);
    G1::add(lhs, t.tag[1], lhs);

    if (lhs == rhs) { return 1; }
    else if (lhs.isZero()) { return 0; }
    return -1;
}


int main() {
    // setup global parameters
    initPairing(mcl::BLS12_381);
    mapToG1(P, 1);
    mapToG2(Q, 1);

    // key genereartion
    Fr skI[3], skC;
    G1 pkC;
    G2 pkI[3];
    EQKeyGen(skI, pkI); // is also Issuer KeyGen
    NIATClientKeyGen(skC, pkC);

    for (int b = 0; b <= 1; b++) {
        niat_psig psig;
        NIATIssue(pkI, &psig, skI, pkC, b);     // issue

        niat_token t;
        NIATObtain(&t, skC, pkC, pkI, psig);    // obtain

        int b_ = NIATReadBit(skI, pkI, t);      // redeem
        std::cout << "ReadBit for b = " << b << ": " << (b == b_ ? "ok" : "er") << std::endl;
    }

    return 0;
}
