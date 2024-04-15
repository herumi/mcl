#include <mcl/bls12_381.hpp>

using namespace mcl::bn;
/* Notes:
 *      P is the generator of G1
 *      Q is the generator of G2
 */

void SPSEQ_KeyGen(Fr * sk, G2 pk[3], const G2& Q) {
    for (int i = 0; i < 3; i++) {       // TODO: how to get legnth of an array
	    sk[i].setRand();
	    G2::mul(pk[i], Q, sk[i]);   // public key = sQ
    }
}

struct SPSEQ_Sig {
    G1 Z, Y1;
    G2 Y2;
};

void SPSEQ_Sign(SPSEQ_Sig * sig, const Fr sk[3], G1 msg[3], const G1& P, const G2& Q) {
    Fr nu, nu_inv;
    nu.setRand();
    Fr::inv(nu_inv, nu);

    G1::mul(sig->Y1, P, nu_inv);
    G2::mul(sig->Y2, Q, nu_inv);
    
    G1::mul(sig->Z, msg[0], sk[0]);
    G1 temp;
    G1::mul(temp, msg[1], sk[1]);
    G1::add(sig->Z, sig->Z, temp);
    G1::mul(temp, msg[2], sk[2]);
    G1::add(sig->Z, sig->Z, temp);

    G1::mul(sig->Z, sig->Z, nu);
}

bool SPSEQ_Verify(SPSEQ_Sig sig, const G2 pk[3], G1 msg[3]) {
	Fp12 e[4];
    pairing(e[0], msg[0], pk[0]);
    pairing(e[1], msg[1], pk[1]);
    Fp12::mul(e[1], e[0], e[1]);
    pairing(e[2], msg[2], pk[2]);
    Fp12::mul(e[2], e[1], e[2]);

    pairing(e[3], sig.Z, sig.Y2);
	return e[2] == e[3];
}

void SPSEQ_ChangeRep(SPSEQ_Sig * new_sig, const G2 pk[3], G1 msg[3], SPSEQ_Sig old_sig, const Fr mu) {
    bool ok = SPSEQ_Verify(old_sig, pk, msg);
    if (!ok) {
        throw std::runtime_error("ChangeRep, signature verification failed.");
    }
    Fr psi, psi_inv;
    psi.setRand();
    Fr::inv(psi_inv, psi);

    G1::mul(new_sig->Y1, old_sig.Y1, psi_inv);
    G2::mul(new_sig->Y2, old_sig.Y2, psi_inv);

    Fr::mul(psi, psi, mu);
    G1::mul(new_sig->Z, old_sig.Z, psi);
}
/* ********************************************************************************** */
/*
 * NIAT
*/

struct NIAT_Token {
    G1 t[3];
    SPSEQ_Sig sigma;
};

struct NIAT_Psig_Nonce {
    SPSEQ_Sig sigma_bar;
    G1 S, T;
    std::string nonce;
};

void Hash(G1& P, const std::string& m) {
	Fp t;
	t.setHashOf(m);
	mapToG1(P, t);
}

void NIAT_KeyGen_C(Fr& sk_C, G1& pk_C, const G1& P) {
	sk_C.setRand();
	G1::mul(pk_C, P, sk_C); // pub = sQ
}

void NIAT_Issue(NIAT_Psig_Nonce * ret, Fr sk_I[3], const G1& pk_C, int b, const G1& P, const G2& Q) {
    std::string r = "random r is hardcoded for now!";
    Fr s;
    s.setRand();
    G1 S, T;
    G1::mul(S, P, s);

    G1 S_x2;
    G1::mul(S_x2, S, sk_I[1]);

    Fr exp;
    Fr::mul(exp, b, sk_I[0]);
    G1::mul(T, pk_C, exp);
    G1::add(T, T, S_x2);

    G1 msg[3];
    msg[0] = pk_C;
    Hash(msg[1], r);
    msg[2] = T;

    SPSEQ_Sig sigma_bar;
    SPSEQ_Sign(&sigma_bar, sk_I, msg, P, Q);

    ret->sigma_bar = sigma_bar;
    ret->S = S;
    ret->T = T;
    ret->nonce = r;
}

void NIAT_Obtain(NIAT_Token * token, NIAT_Psig_Nonce psig_nonce, const Fr sk_C, const G1& pk_C, G2 pk_I[3]) {
    G1 mu[3], H_r;
    Hash(H_r, psig_nonce.nonce);
    mu[0] = pk_C;
    mu[1] = H_r;
    mu[2] = psig_nonce.T;

    SPSEQ_Verify(psig_nonce.sigma_bar, pk_I, mu);
    // if fails, SPSEQ_Verify will throw an exception, no need to check.
    Fr alpha_inv;
    Fr::inv(alpha_inv, sk_C);

    G1::mul(token->t[0], H_r, alpha_inv);
    G1::mul(token->t[1], psig_nonce.T, alpha_inv);
    G1::mul(token->t[2], psig_nonce.S, alpha_inv);

    SPSEQ_ChangeRep(&(token->sigma), pk_I, mu, psig_nonce.sigma_bar, alpha_inv);
}

int NIAT_ReadBit(NIAT_Token token, Fr sk_I[3], G2 pk_I[3], const G1& P) {
    G1 msg[3];
    msg[0] = P;
    msg[1] = token.t[0];
    msg[2] = token.t[1];
    SPSEQ_Verify(token.sigma, pk_I, msg);
    // if fails, SPSEQ_Verify will throw an exception, no need to check.

    G1 lhs, rhs;
    G1::mul(rhs, P, sk_I[0]);

    Fr x2_inv;
    Fr::inv(x2_inv, sk_I[1]);
    G1::mul(lhs, token.t[2], x2_inv);
    G1::add(lhs, token.t[1], lhs);

    if (lhs == rhs) {
        return 1;
    } else {
        std::cout << "lhs  " << lhs << std::endl;
        std::cout << "rhs  " << rhs << std::endl;
    }
    return -1;
}


int main(int argc, char *argv[]) {
    std::string m = argc == 1 ? "hello mcl" : argv[1];

	// setup parameter
	initPairing(mcl::BLS12_381);
	G2 Q;   // generator g2
	mapToG2(Q, 1);
    G1 P;   // generator g1
    mapToG1(P, 1);

	// generate secret key and public key
	Fr sk[3];
	G2 pk[3];
	SPSEQ_KeyGen(sk, pk, Q);
    for (int i=0; i < 3; i++) {
        std::cout << "secret key[" << i << "] " << sk[i] << std::endl;
        std::cout << "public key[" << i << "] " << pk[i] << std::endl;
    }

    std::cout << "--------------------------------------------\n";
    // generate random message vector
    G1 msg[3];
    for (int i = 0; i < 3; i++) {
        Fr r;
        r.setRand();
	    G1::mul(msg[i], P, r);
    }
    for (int i=0; i < 3; i++) {
        std::cout << "msg[" << i << "] " << msg[i] << std::endl;
    }

    std::cout << "--------------------------------------------\n";
	// sign
	G1 sign;
    SPSEQ_Sig sig;
	SPSEQ_Sign(&sig, sk, msg, P, Q);
    std::cout << "sig Y1 " << sig.Y1 << std::endl;
    std::cout << "sig Y2 " << sig.Y2 << std::endl;
    std::cout << "sig Z  " << sig.Z << std::endl;

    std::cout << "--------------------------------------------\n";
	// verify
	bool ok = SPSEQ_Verify(sig, pk, msg);
	std::cout << "verify " << (ok ? "ok" : "ng") << std::endl;

    std::cout << "--------------------------------------------\n";
    // change rep
    SPSEQ_Sig new_sig;
    Fr mu;
    mu.setRand();
    SPSEQ_ChangeRep(&new_sig, pk, msg, sig, mu);
    // msg need to change as well
    for (int i=0; i < 3; i++) {
        G1::mul(msg[i], msg[i], mu);
    }
    std::cout << "---After change Rep" << std::endl;
    std::cout << "sig Y1 " << new_sig.Y1 << std::endl;
    std::cout << "sig Y2 " << new_sig.Y2 << std::endl;
    std::cout << "sig Z  " << new_sig.Z << std::endl;
    // verify after change rep
	bool ok2 = SPSEQ_Verify(new_sig, pk, msg);
    std::cout << "verify " << (ok2 ? "ok" : "ng") << std::endl;

    std::cout << "--------------------------------------------\n\n";
    std::cout << "--------------------NIAT--------------------\n\n";
    std::cout << "--------------------------------------------\n\n";

    Fr sk_I[3], sk_C;
	G2 pk_I[3];
    G1 pk_C;
	SPSEQ_KeyGen (sk_I, pk_I, Q);
    NIAT_KeyGen_C(sk_C, pk_C, P);

    // issue
    NIAT_Psig_Nonce psig_nonce;
    int b = 1;
    NIAT_Issue(&psig_nonce, sk_I, pk_C, b, P,Q);

    // obtain
    NIAT_Token token;
    NIAT_Obtain(&token, psig_nonce, sk_C, pk_C, pk_I);

    // redeem
    int b_star = NIAT_ReadBit(token, sk_I, pk_I, P);
    std::cout << "ReadBit correctly? " << (b==b_star ? "ok" : "ng") << std::endl;
    std::cout << "ReadBit correctly? " << (b==b_star ? "ok" : "ng") << std::endl;

    return 0;
}
