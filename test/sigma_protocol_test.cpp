#include <cybozu/test.hpp>
#include <mcl/bn.hpp>
#include <mcl/sigma_protocol.hpp>
#include <mcl/window_method.hpp>

using namespace mcl;
using namespace mcl::bn;

typedef sigma::MulG<G1> MulG1;
typedef sigma::MulG<G2> MulG2;
typedef sigma::Additive<GT> AGT;
typedef sigma::MulG<AGT> MulAGT;

std::ostream& operator<<(std::ostream& os, const AGT& x) { return os << x.v; }

G1 g_P;
G2 g_Q;
GT g_e;

CYBOZU_TEST_AUTO(init)
{
#if MCL_FP_BIT == 256
	initPairing(mcl::BN254);
#elif MCL_FP_BIT == 384 && MCL_FR_BIT == 256
	initPairing(mcl::BLS12_381);
#else
	initPairing(mcl::BN381_1);
#endif
	hashAndMapToG1(g_P, "P");
	hashAndMapToG2(g_Q, "Q");
	pairing(g_e, g_P, g_Q);
}

// z = k + c w (plus) or k - c w, R = B z - c X (plus) or B z + c X must be equal to B k
template<class G>
void responseTest(const G& P)
{
	const sigma::MulG<G> B(P);
	for (int i = 0; i < 2; i++) {
		const bool plus = i == 0;
		Fr k, c, w, z;
		k.setByCSPRNG();
		c.setByCSPRNG();
		w.setByCSPRNG();
		G X, R, Rk;
		G::mul(X, P, w);
		sigma::response(z, k, c, w, plus);
		Fr t = plus ? k + c * w : k - c * w;
		CYBOZU_TEST_EQUAL(z, t);
		sigma::recompute1(R, B, z, X, c, plus);
		sigma::commit1(Rk, B, k);
		CYBOZU_TEST_EQUAL(R, Rk);
		z += 1;
		sigma::recompute1(R, B, z, X, c, plus);
		CYBOZU_TEST_ASSERT(R != Rk);
	}
}

CYBOZU_TEST_AUTO(response)
{
	responseTest(g_P);
	responseTest(g_Q);
	responseTest(AGT::cast(g_e));
}

// X = B0 w0 + B1 w1 (Pedersen commitment) and X = B0 w0 + B1 w1 + B2 w2
template<class G>
void commitTest(const G& P)
{
	G P1, P2;
	G::mul(P1, P, 3);
	G::mul(P2, P, 7);
	const sigma::MulG<G> B0(P), B1(P1), B2(P2);
	Fr w[3], k[3], z[3], c;
	for (int i = 0; i < 3; i++) {
		w[i].setByCSPRNG();
		k[i].setByCSPRNG();
	}
	c.setByCSPRNG();
	{
		G X, R, R2, t;
		G::mul(X, P, w[0]);
		G::mul(t, P1, w[1]);
		X += t;
		sigma::commit2(R, B0, w[0], B1, w[1]);
		CYBOZU_TEST_EQUAL(R, X);
		sigma::commit2(R, B0, k[0], B1, k[1]);
		sigma::response(z[0], k[0], c, w[0]);
		sigma::response(z[1], k[1], c, w[1]);
		sigma::recompute2(R2, B0, z[0], B1, z[1], X, c);
		CYBOZU_TEST_EQUAL(R, R2);
	}
	{
		G X, R, R2, t;
		G::mul(X, P, w[0]);
		G::mul(t, P1, w[1]);
		X += t;
		G::mul(t, P2, w[2]);
		X += t;
		sigma::commit3(R, B0, w[0], B1, w[1], B2, w[2]);
		CYBOZU_TEST_EQUAL(R, X);
		sigma::commit3(R, B0, k[0], B1, k[1], B2, k[2]);
		for (int i = 0; i < 3; i++) {
			sigma::response(z[i], k[i], c, w[i]);
		}
		sigma::recompute3(R2, B0, z[0], B1, z[1], B2, z[2], X, c);
		CYBOZU_TEST_EQUAL(R, R2);
		z[2] += 1;
		sigma::recompute3(R2, B0, z[0], B1, z[1], B2, z[2], X, c);
		CYBOZU_TEST_ASSERT(R != R2);
	}
}

CYBOZU_TEST_AUTO(commit)
{
	commitTest(g_P);
	commitTest(g_Q);
	commitTest(AGT::cast(g_e));
}

// Additive<GT> must agree with the direct computation by GT::pow and GT::mul
CYBOZU_TEST_AUTO(additiveGT)
{
	CYBOZU_TEST_EQUAL(sizeof(AGT), sizeof(GT));
	GT e1, e2;
	Fr a, b, c;
	a.setByCSPRNG();
	b.setByCSPRNG();
	c.setByCSPRNG();
	GT::pow(e1, g_e, a);
	GT::pow(e2, g_e, b);
	const MulAGT B0(AGT::cast(e1)), B1(AGT::cast(e2));
	AGT R;
	sigma::commit2(R, B0, c, B1, a);
	GT X, t;
	GT::pow(X, e1, c);
	GT::pow(t, e2, a);
	X *= t;
	CYBOZU_TEST_EQUAL(R.v, X);
	// recompute1 with plus = true : R = B0 z - c X
	sigma::recompute1(R, B0, a, AGT::cast(X), c);
	GT::pow(t, e1, a);
	GT::pow(X, X, c);
	GT::unitaryInv(X, X);
	t *= X;
	CYBOZU_TEST_EQUAL(R.v, t);
}

/*
	2-way OR proof for a bit with N equations
	she ZkpBin : N = 2, B = (P, xP), X = (T, S), O = (0, P)
	bbs bit : N = 1, B = (Y0), X = (E), O = (Y1)
*/
template<class G, size_t N, class Bases>
void bitOrTest(const Bases& B, const G *const X[N], const G *const O[N], int bit, const Fr& t)
{
	typedef sigma::BitOr<G, Fr, N> Or;
	Fr d[2], s[2], k, c;
	d[1-bit].setByCSPRNG();
	s[1-bit].setByCSPRNG();
	k.setByCSPRNG();
	c.setByCSPRNG();
	G R[2][N];
	Or::simulate(R[1-bit], B, X, O, 1-bit, d[1-bit], s[1-bit]);
	Or::commit(R[bit], B, k);
	Or::finish(d[bit], s[bit], c, d[1-bit], k, t);
	CYBOZU_TEST_EQUAL(d[0] + d[1], c);
	G R2[2][N];
	Or::recompute(R2, B, X, O, d, s);
	for (int i = 0; i < 2; i++) {
		for (size_t j = 0; j < N; j++) {
			CYBOZU_TEST_EQUAL(R[i][j], R2[i][j]);
		}
	}
	// tamper
	Fr d2[2] = { d[0], d[1] };
	d2[bit] += 1;
	Or::recompute(R2, B, X, O, d2, s);
	CYBOZU_TEST_ASSERT(R[bit][0] != R2[bit][0]);
	Fr s2[2] = { s[0], s[1] };
	s2[1-bit] += 1;
	Or::recompute(R2, B, X, O, d, s2);
	CYBOZU_TEST_ASSERT(R[1-bit][0] != R2[1-bit][0]);
	// a wrong witness
	Fr t2 = t + 1;
	Or::finish(d[bit], s[bit], c, d[1-bit], k, t2);
	Or::recompute(R2, B, X, O, d, s);
	CYBOZU_TEST_ASSERT(R[bit][0] != R2[bit][0]);
}

template<class G>
void bitOr1Test(const G& Y0, const G& Y1)
{
	for (int bit = 0; bit < 2; bit++) {
		Fr t;
		t.setByCSPRNG();
		G E;
		G::mul(E, Y0, t);
		if (bit) E += Y1;
		const sigma::MulG<G> B0(Y0);
		const sigma::Bases1<G, sigma::MulG<G> > B = sigma::makeBases1<G>(B0);
		const G *X[1] = { &E };
		const G *O[1] = { &Y1 };
		bitOrTest<G, 1>(B, X, O, bit, t);
		// a wrong statement
		G E2 = E;
		E2 += Y0;
		const G *X2[1] = { &E2 };
		typedef sigma::BitOr<G, Fr, 1> Or;
		Fr d[2], s[2], k, c;
		d[1-bit].setByCSPRNG();
		s[1-bit].setByCSPRNG();
		k.setByCSPRNG();
		c.setByCSPRNG();
		G R[2][1], R2[2][1];
		Or::simulate(R[1-bit], B, X, O, 1-bit, d[1-bit], s[1-bit]);
		Or::commit(R[bit], B, k);
		Or::finish(d[bit], s[bit], c, d[1-bit], k, t);
		Or::recompute(R2, B, X2, O, d, s);
		CYBOZU_TEST_ASSERT(R[0][0] != R2[0][0] || R[1][0] != R2[1][0]);
	}
}

template<class G, class M0, class M1>
void bitOr2Test(const G& P, const M0& Pmul, const G& xP, const M1& xPmul)
{
	for (int bit = 0; bit < 2; bit++) {
		// (S, T) = (bit P + r xP, r P)
		Fr r;
		r.setByCSPRNG();
		G S, T;
		G::mul(T, P, r);
		G::mul(S, xP, r);
		if (bit) S += P;
		const sigma::Bases2<G, M0, M1> B = sigma::makeBases2<G>(Pmul, xPmul);
		const G *X[2] = { &T, &S };
		const G *O[2] = { 0, &P };
		bitOrTest<G, 2>(B, X, O, bit, r);
	}
}

CYBOZU_TEST_AUTO(bitOr)
{
	G1 P1, P2;
	G1::mul(P1, g_P, 5);
	G1::mul(P2, g_P, 11);
	bitOr1Test(P1, P2);
	G2 Q1, Q2;
	G2::mul(Q1, g_Q, 5);
	G2::mul(Q2, g_Q, 11);
	bitOr1Test(Q1, Q2);
	{
		const sigma::MulG<G1> Pmul(g_P), xPmul(P1);
		bitOr2Test(g_P, Pmul, P1, xPmul);
	}
	{
		const sigma::MulG<G2> Qmul(g_Q), yQmul(Q1);
		bitOr2Test(g_Q, Qmul, Q1, yQmul);
	}
}

// the result does not depend on how the base is multiplied
struct DerivedG1 : G1 {
};

CYBOZU_TEST_AUTO(windowMethod)
{
	const size_t bitSize = Fr::getBitSize();
	G1 xP;
	G1::mul(xP, g_P, 7);
	fp::WindowMethod<G1> Pwm, xPwm;
	Pwm.init(g_P, bitSize, 8);
	xPwm.init(xP, bitSize, 8);
	const sigma::MulG<G1> Pmul(g_P), xPmul(xP);
	Fr k0, k1;
	k0.setByCSPRNG();
	k1.setByCSPRNG();
	G1 R1, R2;
	sigma::commit2(R1, Pmul, k0, xPmul, k1);
	sigma::commit2(R2, Pwm, k0, xPwm, k1);
	CYBOZU_TEST_EQUAL(R1, R2);
	sigma::commit2(R2, Pwm, k0, xPmul, k1);
	CYBOZU_TEST_EQUAL(R1, R2);
	// WindowMethod<I> with I derived from G1 via CastMul
	fp::WindowMethod<DerivedG1> Pwm2;
	Pwm2.init(static_cast<const DerivedG1&>(g_P), bitSize, 8);
	const sigma::CastMul<DerivedG1, fp::WindowMethod<DerivedG1> > Pcast(Pwm2);
	sigma::commit2(R2, Pcast, k0, xPmul, k1);
	CYBOZU_TEST_EQUAL(R1, R2);
	bitOr2Test(g_P, Pwm, xP, xPmul);
	bitOr2Test(g_P, Pcast, xP, xPwm);
}
