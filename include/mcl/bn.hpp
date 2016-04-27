#pragma once
/**
	@file
	@brief optimal ate pairing
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp_tower.hpp>
#include <mcl/ec.hpp>
#include <assert.h>

namespace mcl { namespace bn {

struct CurveParam {
	/*
		y^2 = x^3 + b
		i^2 = -1
		xi = xi_a + i
		v^3 = xi
		w^2 = v
	*/
	int64_t z;
	int b; // y^2 = x^3 + b
	int xi_a; // xi = xi_a + i
	bool operator==(const CurveParam& rhs) const { return z == rhs.z && b == rhs.b && xi_a == rhs.xi_a; }
	bool operator!=(const CurveParam& rhs) const { return !operator==(rhs); }
};

const CurveParam CurveSNARK1 = { 4965661367192848881, 3, 9 };
const CurveParam CurveSNARK2 = { 4965661367192848881, 82, 9 };
const CurveParam CurveFp254BNb = { -((1LL << 62) + (1LL << 55) + (1LL << 0)), 2, 1 };

template<class Vec>
void convertToBinary(Vec& v, const mpz_class& x)
{
	const size_t len = mcl::gmp::getBitSize(x);
	v.clear();
	for (size_t i = 0; i < len; i++) {
		v.push_back(mcl::gmp::testBit(x, len - 1 - i) ? 1 : 0);
	}
}

template<class Vec>
size_t getContinuousVal(const Vec& v, size_t pos, int val)
{
	while (pos >= 2) {
		if (v[pos] != val) break;
		pos--;
	}
	return pos;
}

template<class Vec>
void convertToNAF(Vec& v, const Vec& in)
{
	v = in;
	size_t pos = v.size() - 1;
	for (;;) {
		size_t p = getContinuousVal(v, pos, 0);
		if (p == 1) return;
		assert(v[p] == 1);
		size_t q = getContinuousVal(v, p, 1);
		if (q == 1) return;
		assert(v[q] == 0);
		if (p - q <= 1) {
			pos = p - 1;
			continue;
		}
		v[q] = 1;
		for (size_t i = q + 1; i < p; i++) {
			v[i] = 0;
		}
		v[p] = -1;
		pos = q;
	}
}

template<class Vec>
size_t getNumOfNonZeroElement(const Vec& v)
{
	size_t w = 0;
	for (size_t i = 0; i < v.size(); i++) {
		if (v[i]) w++;
	}
	return w;
}

/*
	compute a repl of x which has smaller Hamming weights.
	return true if naf is selected
*/
template<class Vec>
bool getGoodRepl(Vec& v, const mpz_class& x)
{
	Vec bin;
	convertToBinary(bin, x);
	Vec naf;
	convertToNAF(naf, bin);
	const size_t binW = getNumOfNonZeroElement(bin);
	const size_t nafW = getNumOfNonZeroElement(naf);
	if (nafW < binW) {
		v.swap(naf);
		return true;
	} else {
		v.swap(bin);
		return false;
	}
}

template<class Fp>
struct ParamT {
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	mpz_class z;
	mpz_class p;
	mpz_class r;
	mpz_class t; /* trace of Frobenius */
	Fp Z;
	Fp2 W2p;
	Fp2 W3p;
	static const size_t gammarN = 5;
	Fp2 gammar[gammarN];
	Fp2 gammar2[gammarN];
	Fp2 gammar3[gammarN];
	int b;
	Fp2 b_invxi; // b_invxi = b/xi of twist E' : Y^2 = X^3 + b/xi
	Fp half;

	// Loop parameter for the Miller loop part of opt. ate pairing.
	typedef std::vector<int8_t> SignVec;
	SignVec siTbl;
	bool useNAF;
	SignVec zReplTbl; // QQQ : snark

	void init(const CurveParam& cp = CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
	{
		z = cp.z;
		const int pCoff[] = { 1, 6, 24, 36, 36 };
		const int rCoff[] = { 1, 6, 18, 36, 36 };
		const int tCoff[] = { 1, 0,  6,  0,  0 };
		eval(p, z, pCoff);
		eval(r, z, rCoff);
		eval(t, z, tCoff);
		Fp::setModulo(p.get_str(), 10, mode);
		Fp2::init(cp.xi_a);
		b = cp.b; // set b before calling Fp::setModulo
		half = Fp(1) / Fp(2);
		Fp2 xi(cp.xi_a, 1);
		b_invxi = Fp2(b) / xi;
		G1::setParam(0, b);
		G2::setParam(0, b_invxi);
		power(gammar[0], xi, (p - 1) / 6);

		for (size_t i = 1; i < gammarN; i++) {
			gammar[i] = gammar[i - 1] * gammar[0];
		}

		for (size_t i = 0; i < gammarN; i++) {
			gammar2[i] = Fp2(gammar[i].a, -gammar[i].b) * gammar[i];
			gammar3[i] = gammar[i] * gammar2[i];
		}

		power(W2p, xi, (p - 1) / 3);
		power(W3p, xi, (p - 1) / 2);
		Fp2 tmp;
		Fp2::power(tmp, xi, (p * p - 1) / 6);
		assert(tmp.b.isZero());
		Fp::sqr(Z, tmp.a);

		const mpz_class largest_c = abs(6 * z + 2);
		useNAF = getGoodRepl(siTbl, largest_c);
		getGoodRepl(zReplTbl, abs(z)); // QQQ : snark
	}
	void eval(mpz_class& y, const mpz_class& x, const int c[5]) const
	{
		y = (((c[4] * x + c[3]) * x + c[2]) * x + c[1]) * x + c[0];
	}
};

template<class G>
void Frobenius(G& y, const G& x, const mpz_class& p)
{
	using namespace mcl;
	power(y.x, x.x, p);
	power(y.y, x.y, p);
	power(y.z, x.z, p);
}

template<class Fp>
struct Naive {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::Fp6T<Fp> Fp6;
	typedef mcl::Fp12T<Fp> Fp12;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	/*
		v is the line arising in the addition of Q1 and Q2 in G2 evaluated at point P in G1
	*/
	static void evalLine(Fp12& v, const G2& Q1, const G2& Q2, const G1& P)
	{
		Fp2 t;
		Q1.normalize();
		Q2.normalize();
		P.normalize();
		if (Q1.x == Q2.x) {
			t = Q1.x * Q1.x * 3 / (Q1.y + Q1.y);
		} else {
			t = (Q1.y - Q2.y) / (Q1.x - Q2.x);
		}
		t *= Fp2(P.x, 0) - Q1.x;
		t += Q1.y;
		v.clear();
		v.a.a = t;
	}
	static void optimalAtePairing(Fp12& f, const G2& Q, const G1& P, const mpz_class& u)
	{
		const mpz_class r = abs(6 * u + 2);
		const mpz_class p = (((36 * u + 36) * u + 24) * u + 6) * u + 1;
		const mpz_class n = (((36 * u + 36) * u + 18) * u + 6) * u + 1;
		G2 T = Q;
		Fp12 t;
		f = 1;
		const int c = (int)mcl::gmp::getBitSize(r);
		for (int i = c - 2; i >= 0; i--) {
			Fp12::sqr(f, f);
			evalLine(t, T, T, P);
			f *= t;
			G2::dbl(T, T);
			if (mcl::gmp::testBit(r, i)) {
				evalLine(t, T, Q, P);
				f *= t;
				T += Q;
			}
		}
		G2 Q1, Q2;
		Frobenius(Q1, Q, p);
		Frobenius(Q2, Q1, p);
		if (u < 0) {
			G2::neg(T, T);
			Fp12::inv(f, f);
		}
		evalLine(t, T, Q1, P);
		f *= t;
		T += Q1;
		evalLine(t, T, -Q2, P);
		f *= t;
		mpz_class a = p * p * p;
		a *= a;
		a *= a;
		a = (a - 1) / n;
		Fp12::power(f, f, a);
	}
};

} } // mcl::bn

