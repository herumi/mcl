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
	const char *z;
	int b; // y^2 = x^3 + b
	int xi_a; // xi = xi_a + i
	bool operator==(const CurveParam& rhs) const { return z == rhs.z && b == rhs.b && xi_a == rhs.xi_a; }
	bool operator!=(const CurveParam& rhs) const { return !operator==(rhs); }
};

const CurveParam CurveSNARK1 = { "4965661367192848881", 3, 9 };
//const CurveParam CurveSNARK2 = { "4965661367192848881", 82, 9 };
const CurveParam CurveFp254BNb = { "-0x4080000000000001", 2, 1 }; // -(2^62 + 2^55 + 1)
// provisional(experimental) param with maxBitSize = 384
const CurveParam CurveFp382_1 = { "-0x400011000000000000000001", 2, 1 }; // -(2^94 + 2^76 + 2^72 + 1) // A Family of Implementation-Friendly BN Elliptic Curves
const CurveParam CurveFp382_2 = { "-0x400040090001000000000001", 2, 1 }; // -(2^94 + 2^78 + 2^67 + 2^64 + 2^48 + 1) // used in relic-toolkit

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
struct MapToT {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	Fp c1; // sqrt(-3)
	Fp c2; // (-1 + sqrt(-3)) / 2
	mpz_class cofactor;
	int legendre(const Fp& x) const
	{
		return gmp::legendre(x.getMpz(), Fp::getOp().mp);
	}
	int legendre(const Fp2& x) const
	{
		Fp y;
		Fp2::norm(y, x);
		return legendre(y);
	}
	void mulFp(Fp& x, const Fp& y) const
	{
		x *= y;
	}
	void mulFp(Fp2& x, const Fp& y) const
	{
		x.a *= y;
		x.b *= y;
	}
	template<class G, class F>
	void calc(G& P, const F& t) const
	{
		F x, y, w;
		bool negative = legendre(t) < 0;
		F::sqr(w, t);
		w += G::b_;
		*w.getFp0() += Fp::one();
		if (w.isZero()) goto ERR_POINT;
		F::inv(w, w);
		mulFp(w, c1);
		w *= t;
		for (int i = 0; i < 3; i++) {
			switch (i) {
			case 0: F::mul(x, t, w); F::neg(x, x); *x.getFp0() += c2; break;
			case 1: F::neg(x, x); *x.getFp0() -= Fp::one(); break;
			case 2: F::sqr(x, w); F::inv(x, x); *x.getFp0() += Fp::one(); break;
			}
			G::getWeierstrass(y, x);
			if (F::squareRoot(y, y)) {
				if (negative) F::neg(y, y);
				P.set(x, y, false);
				return;
			}
		}
	ERR_POINT:
		throw cybozu::Exception("MapToT:calc:bad") << t;
	}
	/*
		cofactor is for G2
	*/
	void init(const mpz_class& cofactor)
	{
		if (!Fp::squareRoot(c1, -3)) throw cybozu::Exception("MapToT:init:c1");
		c2 = (c1 - 1) / 2;
		this->cofactor = cofactor;
	}
	/*
		P.-A. Fouque and M. Tibouchi,
		"Indifferentiable hashing to Barreto Naehrig curves," in Proc. Int. Conf. Cryptol. Inform. Security Latin Amer., 2012, vol. 7533, pp.1-17.

		w = sqrt(-3) t / (1 + b + t^2)
		Remark: throw exception if t = 0, c1, -c1 and b = 2
	*/
	void calcG1(G1& P, const Fp& t) const
	{
		calc<G1, Fp>(P, t);
		assert(P.isValid());
	}
	/*
		get the element in G2 by multiplying the cofactor
	*/
	void calcG2(G2& P, const Fp2& t) const
	{
		calc<G2, Fp2>(P, t);
		assert(cofactor != 0);
		G2::mul(P, P, cofactor);
		assert(!P.isZero());
	}
};

/*
	Skew Frobenius Map and Efficient Scalar Multiplication for Pairing-Based Cryptography
	Y. Sakemi, Y. Nogami, K. Okeya, H. Kato, Y. Morikawa
*/
template<class Fp>
struct GLV {
	typedef mcl::EcT<Fp> G1;
	Fp w; // (-1 + sqrt(-3)) / 2
	mpz_class r;
	mpz_class z;
	bool isNegative;
	mpz_class v; // 6z^2 + 4z + 1 > 0
	mpz_class c; // 2z + 1
	void init(const mpz_class& r, const mpz_class& z, bool isNegative)
	{
		if (!Fp::squareRoot(w, -3)) throw cybozu::Exception("GLV:init");
		w = (w - 1) / 2;
		this->r = r;
		this->z = z;
		this->isNegative = isNegative;
		v = 1 + z * (4 + z * 6);
		c = 2 * z + 1;
	}
	/*
		(p^2 mod r) (x, y) = (wx, -y)
	*/
	void mulP2(G1& Q, const G1& P) const
	{
		Fp::mul(Q.x, P.x, w);
		Fp::neg(Q.y, P.y);
		Q.z = P.z;
	}
	/*
		s = ap^2 + b mod r
		assume(s < r);
	*/
	void getAB(mpz_class& a, mpz_class& b, const mpz_class& s) const
	{
		assert(0 < s && s < r);
		/*
			s = s1 * v + s2                  // s1 = s / v, s2 = s % v
			= s1 * c * p^2 + s2              // vP = cp^2 P
			= (s3 * v + s4) * p^2 + s2       // s3 = (s1 * c) / v, s4 = (s1 * c) % v
			= (s3 * c * p^2 + s4) * p^2 + s2
			= (s3 * c) * p^4 + s4 * p^2 + s2 // s5 = s3 * c, p^4 = p^2 - 1
			= s5 * (p^2 - 1) + s4 * p^2 + s2
			= (s4 + s5) * p^2 + (s2 - s5)
		*/
		mpz_class t;
		mcl::gmp::divmod(a, t, s, v); // a = t / v, t = t % v
		a *= c;
		mcl::gmp::divmod(b, a, a, v); // b = a / v, a = a % v
		b *= c;
		a += b;
		b = t - b;
	}
	void mul(G1& Q, G1 P, mpz_class x, bool constTime = false) const
	{
		x %= r;
		if (x == 0) {
			Q.clear();
			return;
		}
		if (x < 0) {
//			G1::neg(P, P);
//			x = -x;
			x += r;
		}
		mpz_class a, b;
		getAB(a, b, x);
		// Q = (ap^2 + b)P
		G1 A;
		mulP2(A, P);
		if (b < 0) {
			b = -b;
			G1::neg(P, P);
		}
		assert(a >= 0);
		assert(b >= 0);
#if 0
		G1::mul(A, A, a);
		G1 B;
		G1::mul(B, P, b);
		G1::add(Q, A, B);
		return;
#endif
#if 0 // slow
		size_t nA = mcl::gmp::getBitSize(a);
		size_t nB = mcl::gmp::getBitSize(b);
		size_t n = std::max(nA, nB);
		assert(n > 0);
		G1 tbl[16];
		tbl[0].clear();
		tbl[1] = A;
		G1::dbl(tbl[2], tbl[1]);
		G1::add(tbl[3], tbl[2], tbl[1]);
		for (int i = 1; i < 4; i++) {
			for (int j = 0; j < 4; j++) {
				G1::add(tbl[i * 4 + j], tbl[(i - 1) * 4 + j], P);
			}
		}
		for (int i = 1; i < 16; i++) {
			tbl[i].normalize();
		}
		if (n & 1) {
			n--;
			bool ai = mcl::gmp::testBit(a, n);
			bool bi = mcl::gmp::testBit(b, n);
			unsigned int idx = bi * 4 + ai;
			Q = tbl[idx];
			if (n == 0) return;
		} else {
			Q.clear();
		}
		for (int i = (int)n - 2; i >= 0; i -= 2) {
			G1::dbl(Q, Q);
			G1::dbl(Q, Q);
			bool a0 = mcl::gmp::testBit(a, i + 0);
			bool a1 = mcl::gmp::testBit(a, i + 1);
			bool b0 = mcl::gmp::testBit(b, i + 0);
			bool b1 = mcl::gmp::testBit(b, i + 1);
			unsigned int c = b1 * 8 + b0 * 4 + a1 * 2 + a0;
			if (c > 0) {
				Q += tbl[c];
			}
		}
#else
		A.normalize();
		P.normalize();
		G1 tbl[4] = { A, A, P, A + P }; // tbl[0] : dummy
		tbl[3].normalize();
		typedef mcl::fp::Unit Unit;
		const int aN = (int)mcl::gmp::getUnitSize(a);
		const int bN = (int)mcl::gmp::getUnitSize(b);
		const Unit *pa = mcl::gmp::getUnit(a);
		const Unit *pb = mcl::gmp::getUnit(b);
		const int maxN = std::max(aN, bN);
		assert(maxN > 0);
		int ma = -1, mb = -1;
		if (aN == maxN) {
			ma = cybozu::bsr<Unit>(pa[maxN - 1]);
		}
		if (bN == maxN) {
			mb = cybozu::bsr<Unit>(pb[maxN - 1]);
		}
		int m = ma;
		if (ma > mb) {
			Q = tbl[1];
		} else if (ma < mb) {
			Q = tbl[2];
			m = mb;
		} else {
			assert(ma == mb);
			Q = tbl[3];
		}
		G1 *pTbl[] = { &tbl[0], &Q, &Q, &Q };
		for (int i = maxN - 1; i >= 0; i--) {
			Unit va = i < aN ? pa[i] : 0;
			Unit vb = i < bN ? pb[i] : 0;
			for (int j = m - 1; j >= 0; j -= 1) {
				G1::dbl(Q, Q);
				Unit ai = (va >> j) & 1;
				Unit bi = (vb >> j) & 1;
				Unit c = bi * 2 + ai;
				if (constTime) {
					*pTbl[c] += tbl[c];
				} else if (c > 0) {
					Q += tbl[c];
				}
			}
			m = (int)sizeof(Unit) * 8;
		}
#endif
	}
};

template<class Fp>
struct ParamT {
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	bool isCurveFp254BNb;
	mpz_class z;
	mpz_class abs_z;
	bool isNegative;
	mpz_class p;
	mpz_class r;
	uint32_t pmod4;
	Fp Z;
	static const size_t gN = 5;
	Fp2 g[gN]; // g[0] = xi^((p - 1) / 6), g[i] = g[i]^(i + 1)
	Fp2 g2[gN];
	Fp2 g3[gN];
	int b;
	/*
		twist
		(x', y') = phi(x, y) = (x/w^2, y/w^3)
		y^2 = x^3 + b
		=> (y'w^3)^2 = (x'w^2)^3 + b
		=> y'^2 = x'^3 + b / w^6 ; w^6 = xi
		=> y'^2 = x'^3 + b_div_xi;
	*/
	Fp2 b_div_xi;
	bool is_b_div_xi_1_m1i;
	mpz_class exp_c0;
	mpz_class exp_c1;
	mpz_class exp_c2;
	MapToT<Fp> mapTo;
	GLV<Fp> glv;

	// Loop parameter for the Miller loop part of opt. ate pairing.
	typedef std::vector<int8_t> SignVec;
	SignVec siTbl;
	size_t precomputedQcoeffSize;
	bool useNAF;
	SignVec zReplTbl;

	void init(const CurveParam& cp = CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
	{
		isCurveFp254BNb = cp == CurveFp254BNb;
		z = mpz_class(cp.z);
		isNegative = z < 0;
		if (isNegative) {
			abs_z = -z;
		} else {
			abs_z = z;
		}
		const int pCoff[] = { 1, 6, 24, 36, 36 };
		const int rCoff[] = { 1, 6, 18, 36, 36 };
		p = eval(pCoff, z);
		assert((p % 6) == 1);
		pmod4 = mcl::gmp::getUnit(p, 0) % 4;
		r = eval(rCoff, z);
		Fp::init(p.get_str(), mode);
		Fp2::init(cp.xi_a);
		b = cp.b;
		Fp2 xi(cp.xi_a, 1);
		b_div_xi = Fp2(b) / xi;
		is_b_div_xi_1_m1i =  b_div_xi == Fp2(1, -1);
		G1::init(0, b, mcl::ec::Proj);
		G2::init(0, b_div_xi, mcl::ec::Proj);
		G2::setOrder(r);
		mapTo.init(2 * p - r);
		glv.init(r, z, isNegative);

		Fp2::pow(g[0], xi, (p - 1) / 6); // g = xi^((p-1)/6)
		for (size_t i = 1; i < gN; i++) {
			g[i] = g[i - 1] * g[0];
		}
		/*
			permutate [0, 1, 2, 3, 4] => [1, 3, 0, 2, 4]
			g[0] = g^2
			g[1] = g^4
			g[2] = g^1
			g[3] = g^3
			g[4] = g^5
		*/
		{
			Fp2 t = g[0];
			g[0] = g[1];
			g[1] = g[3];
			g[3] = g[2];
			g[2] = t;
		}
		for (size_t i = 0; i < gN; i++) {
			Fp2 t(g[i].a, g[i].b);
			if (pmod4 == 3) Fp::neg(t.b, t.b);
			Fp2::mul(g2[i], t, g[i]);
			g3[i] = g[i] * g2[i];
		}
		Fp2 tmp;
		Fp2::pow(tmp, xi, (p * p - 1) / 6);
		assert(tmp.b.isZero());
		Fp::sqr(Z, tmp.a);

		const mpz_class largest_c = abs(6 * z + 2);
		useNAF = getGoodRepl(siTbl, largest_c);
		precomputedQcoeffSize = getPrecomputeQcoeffSize(siTbl);
		getGoodRepl(zReplTbl, abs(z));
		exp_c0 = -2 + z * (-18 + z * (-30 - 36 *z));
		exp_c1 = 1 + z * (-12 + z * (-18 - 36 * z));
		exp_c2 = 6 * z * z + 1;
	}
	mpz_class eval(const int c[5], const mpz_class& x) const
	{
		return (((c[4] * x + c[3]) * x + c[2]) * x + c[1]) * x + c[0];
	}
	size_t getPrecomputeQcoeffSize(const SignVec& sv) const
	{
		size_t idx = 2 + 2;
		for (size_t i = 2; i < sv.size(); i++) {
			idx++;
			if (sv[i]) idx++;
		}
		return idx;
	}
};

template<class Fp>
struct BNT {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::Fp6T<Fp> Fp6;
	typedef mcl::Fp12T<Fp> Fp12;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef mcl::Fp2DblT<Fp> Fp2Dbl;
	typedef ParamT<Fp> Param;
	static Param param;
	static void mulArrayGLV(G1& z, const G1& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		mpz_class s;
		mcl::gmp::setArray(s, y, yn);
		if (isNegative) s = -s;
		param.glv.mul(z, x, s, constTime);
	}
	static void init(const mcl::bn::CurveParam& cp = CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
	{
		param.init(cp, mode);
		G1::setMulArrayGLV(mulArrayGLV);
	}
	/*
		Frobenius
		i^2 = -1
		(a + bi)^p = a + bi^p in Fp
		= a + bi if p = 1 mod 4
		= a - bi if p = 3 mod 4

		g = xi^(p - 1) / 6
		v^3 = xi in Fp2
		v^p = ((v^6) ^ (p-1)/6) v = g^2 v
		v^2p = g^4 v^2
		(a + bv + cv^2)^p in Fp6
		= F(a) + F(b)g^2 v + F(c) g^4 v^2

		w^p = ((w^6) ^ (p-1)/6) w = g w
		((a + bv + cv^2)w)^p in Fp12
		= (F(a) g + F(b) g^3 v + F(c) g^5 v^2)w
	*/
	static void Frobenius(Fp2& y, const Fp2& x)
	{
		if (param.pmod4 == 1) {
			if (&y != &x) {
				y = x;
			}
		} else {
			if (&y != &x) {
				y.a = x.a;
			}
			Fp::neg(y.b, x.b);
		}
	}
	static void Frobenius(Fp12& y, const Fp12& x)
	{
		for (int i = 0; i < 6; i++) {
			Frobenius(y.getFp2()[i], x.getFp2()[i]);
		}
		for (int i = 1; i < 6; i++) {
			y.getFp2()[i] *= param.g[i - 1];
		}
	}
	static  void Frobenius2(Fp12& y, const Fp12& x)
	{
#if 0
		Frobenius(y, x);
		Frobenius(y, y);
#else
		y.getFp2()[0] = x.getFp2()[0];
		if (param.pmod4 == 1) {
			for (int i = 1; i < 6; i++) {
				Fp2::mul(y.getFp2()[i], x.getFp2()[i], param.g2[i]);
			}
		} else {
			for (int i = 1; i < 6; i++) {
				Fp2::mulFp(y.getFp2()[i], x.getFp2()[i], param.g2[i - 1].a);
			}
		}
#endif
	}
	static void Frobenius3(Fp12& y, const Fp12& x)
	{
#if 0
		Frobenius(y, x);
		Frobenius(y, y);
		Frobenius(y, y);
#else
		Frobenius(y.getFp2()[0], x.getFp2()[0]);
		for (int i = 1; i < 6; i++) {
			Frobenius(y.getFp2()[i], x.getFp2()[i]);
			y.getFp2()[i] *= param.g3[i - 1];
		}
#endif
	}
	/*
		p mod 6 = 1, w^6 = xi
		Frob(x', y') = phi Frob phi^-1(x', y')
		= phi Frob (x' w^2, y' w^3)
		= phi (x'^p w^2p, y'^p w^3p)
		= (F(x') w^2(p - 1), F(y') w^3(p - 1))
		= (F(x') g^2, F(y') g^3)
	*/
	static void FrobeniusOnTwist(G2& D, const G2& S)
	{
		assert(S.isNormalized());
		Frobenius(D.x, S.x);
		Frobenius(D.y, S.y);
		D.z = S.z;
		D.x *= param.g[0];
		D.y *= param.g[3];
	}
	/*
		l = (a, b, c) => (a, b * P.y, c * P.x)
	*/
	static void updateLine(Fp6& l, const G1& P)
	{
		l.b.a *= P.y;
		l.b.b *= P.y;
		l.c.a *= P.x;
		l.c.b *= P.x;
	}
	static void mul_b_div_xi(Fp2& y, const Fp2& x)
	{
		if (param.is_b_div_xi_1_m1i) {
			/*
				b / xi = 1 - 1i
				(a + bi)(1 - 1i) = (a + b) + (b - a)i
			*/
			Fp t;
			Fp::add(t, x.a, x.b);
			Fp::sub(y.b, x.b, x.a);
			y.a = t;
		} else {
			Fp2::mul(y, x, param.b_div_xi);
		}
	}
	static void dblLineWithoutP(Fp6& l, G2& Q)
	{
		// 3K x 129
		Fp2 t0, t1, t2, t3, t4, t5;
		Fp2Dbl T0, T1;
		Fp2::sqr(t0, Q.z);
		Fp2::mul(t4, Q.x, Q.y);
		Fp2::sqr(t1, Q.y);
		Fp2::add(t3, t0, t0);
		Fp2::divBy2(t4, t4);
		Fp2::add(t5, t0, t1);
		t0 += t3;
		mul_b_div_xi(t2, t0);
		Fp2::sqr(t0, Q.x);
		Fp2::add(t3, t2, t2);
		t3 += t2;
		Fp2::add(l.c, t0, t0);
		Fp2::sub(Q.x, t1, t3);
		Fp2::add(l.c, l.c, t0);
		t3 += t1;
		Q.x *= t4;
		Fp2::divBy2(t3, t3);
		Fp2Dbl::sqrPre(T0, t3);
		Fp2Dbl::sqrPre(T1, t2);
		Fp2Dbl::sub(T0, T0, T1);
		Fp2Dbl::add(T1, T1, T1);
		Fp2Dbl::sub(T0, T0, T1);
		Fp2::add(t3, Q.y, Q.z);
		Fp2Dbl::mod(Q.y, T0);
		Fp2::sqr(t3, t3);
		t3 -= t5;
		Fp2::mul(Q.z, t1, t3);
		t2 -= t1;
		Fp2::mul_xi(l.a, t2);
		Fp2::neg(l.b, t3);
	}
	static void mulOpt1(Fp2& z, const Fp2& x, const Fp2& y)
	{
		Fp d0;
		Fp s, t;
		Fp::add(s, x.a, x.b);
		Fp::add(t, y.a, y.b);
		Fp::mul(d0, x.b, y.b);
		Fp::mul(z.a, x.a, y.a);
		Fp::mul(z.b, s, t);
		z.b -= z.a;
		z.b -= d0;
		z.a -= d0;
	}
	static void addLineWithoutP(Fp6& l, G2& R, const G2& Q)
	{
		// 4Kclk x 30
#if 1
		Fp2 theta;
		Fp2::mul(theta, Q.y, R.z);
		Fp2::sub(theta, R.y, theta);
		Fp2::mul(l.b, Q.x, R.z);
		Fp2::sub(l.b, R.x, l.b);
		Fp2 lambda2;
		Fp2::sqr(lambda2, l.b);
		Fp2 t1, t2, t3, t4;
		Fp2 t;
		Fp2::mul(t1, R.x, lambda2);
		Fp2::add(t2, t1, t1); // 2 R.x lambda^2
		Fp2::mul(t3, lambda2, l.b); // lambda^3
		Fp2::sqr(t4, theta);
		t4 *= R.z; // t4 = R.z theta^2
		Fp2::add(R.x, t3, t4);
		R.x -= t2;
		R.x *= l.b;
		Fp2::mul(t, R.y, t3);
		Fp2::add(R.y, t1, t2);
		R.y -= t3;
		R.y -= t4;
		R.y *= theta;
		R.y -= t;
		Fp2::mul(R.z, R.z, t3);
		Fp2::mul(l.a, theta, Q.x);
		Fp2::mul(t, l.b, Q.y);
		l.a -= t;
		Fp2::mul_xi(l.a, l.a);
		Fp2::neg(l.c, theta);
#else
		Fp2 t1, t2, t3, t4, T1, T2;
		Fp2::mul(t1, R.z, Q.x);
		Fp2::mul(t2, R.z, Q.y);
		Fp2::sub(t1, R.x, t1);
		Fp2::sub(t2, R.y, t2);
		Fp2::sqr(t3, t1);
		Fp2::mul(R.x, t3, R.x);
		Fp2::sqr(t4, t2);
		t3 *= t1;
		t4 *= R.z;
		t4 += t3;
		t4 -= R.x;
		t4 -= R.x;
		R.x -= t4;
		mulOpt1(T1, t2, R.x);
		mulOpt1(T2, t3, R.y);
		Fp2::sub(R.y, T1, T2);
		Fp2::mul(R.x, t1, t4);
		Fp2::mul(R.z, t3, R.z);
		Fp2::neg(l.c, t2);
		mulOpt1(T1, t2, Q.x);
		mulOpt1(T2, t1, Q.y);
		Fp2::sub(t2, T1, T2);
		Fp2::mul_xi(l.a, t2);
		l.b = t1;
#endif
	}
	static void dblLine(Fp6& l, G2& Q, const G1& P)
	{
		dblLineWithoutP(l, Q);
		updateLine(l, P);
	}
	static void addLine(Fp6& l, G2& R, const G2& Q, const G1& P)
	{
		addLineWithoutP(l, R, Q);
		updateLine(l, P);
	}
	static void mulFp6cb_by_G1xy(Fp6& y, const Fp6& x, const G1& P)
	{
		assert(P.isNormalized());
		if (&y != &x) y.a = x.a;
		Fp2::mulFp(y.c, x.c, P.x);
		Fp2::mulFp(y.b, x.b, P.y);
	}

	static void convertFp6toFp12(Fp12& y, const Fp6& x)
	{
		y.clear();
		y.a.a = x.a;
		y.a.c = x.c;
		y.b.b = x.b;
	}
	/*
		x = (x0 + x1 + x2^2) + (x3 + x4v + x5v^2)w
		y = (y0, y4, y2) -> (y0, 0, y2, 0, y4, 0)
		z = xy = (x0y0 + (x1y2 + x4y4)xi) + (x1y0 + (x2y2 + x5y4)xi)v + (x0y2 + x2y0 + x3y4)v^2
		+ (x3y0 + (x2y4 + x4y2)xi)w + (x0y4 + x4y0 + x5y2xi)vw + (x1y4 + x3y2 + x5y0)v^2w

		x1y2 + x4y4 = (x1 + x4)(y2 + y4) - x1y4 - x4y2
		x2y2 + x5y4 = (x2 + x5)(y2 + y4) - x2y4 - x5y2
		x0y2 + x3y4 = (x0 + x3)(y2 + y4) - x0y4 - x3y2
	*/
	static void mul_024(Fp12& z, const Fp12&x, const Fp6& y)
	{
#if 1
		const Fp2 x0 = x.a.a;
		const Fp2 x1 = x.a.b;
		const Fp2 x2 = x.a.c;
		const Fp2 x3 = x.b.a;
		const Fp2 x4 = x.b.b;
		const Fp2 x5 = x.b.c;
		const Fp2& y0 = y.a;
		const Fp2& y2 = y.c;
		const Fp2& y4 = y.b;
		Fp2 y2_add_y4;
		Fp2::add(y2_add_y4, y2, y4);
		Fp2 x0y4, x1y4, x2y4, x3y2, x4y2, x5y2;
		Fp2::mul(x0y4, x0, y4);
		Fp2::mul(x1y4, x1, y4);
		Fp2::mul(x2y4, x2, y4);
		Fp2::mul(x3y2, x3, y2);
		Fp2::mul(x4y2, x4, y2);
		Fp2::mul(x5y2, x5, y2);

		Fp2 x1_add_x4;
		Fp2 x2_add_x5;
		Fp2 x0_add_x3;
		Fp2::add(x1_add_x4, x1, x4);
		Fp2::add(x2_add_x5, x2, x5);
		Fp2::add(x0_add_x3, x0, x3);
		Fp2 t1, t2;
		Fp2::mul(t1, x1_add_x4, y2_add_y4);
		t1 -= x1y4;
		t1 -= x4y2;
		Fp2::mul_xi(t1, t1);
		Fp2::mul(t2, x0, y0);
		Fp2::add(z.a.a, t1, t2);

		Fp2::mul(t1, x2_add_x5, y2_add_y4);
		t1 -= x2y4;
		t1 -= x5y2;
		Fp2::mul_xi(t1, t1);
		Fp2::mul(t2, x1, y0);
		Fp2::add(z.a.b, t1, t2);
		Fp2::mul(t1, x0_add_x3, y2_add_y4);
		t1 -= x0y4;
		t1 -= x3y2;
		Fp2::mul(t2, x2, y0);
		Fp2::add(z.a.c, t1, t2);

		Fp2::add(t1, x2y4, x4y2);
		Fp2::mul_xi(t1, t1);
		Fp2::mul(t2, x3, y0);
		Fp2::add(z.b.a, t1, t2);

		Fp2::mul_xi(t1, x5y2);
		Fp2::mul(z.b.b, x4, y0);
		z.b.b += x0y4;
		z.b.b += t1;

		Fp2::mul(z.b.c, x5, y0);
		z.b.c += x3y2;
		z.b.c += x1y4;
#else
		Fp12 t;
		convertFp6toFp12(t, y);
		Fp12::mul(z, x, t);
#endif
	}
	static void mul_024_024(Fp12& z, const Fp6& x, const Fp6& y)
	{
		Fp12 x2, y2;
		convertFp6toFp12(x2, x);
		convertFp6toFp12(y2, y);
		Fp12::mul(z, x2, y2);
	}
	/*
		y = x^d
		d = (p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
	*/
	static void exp_d(Fp12& y, const Fp12& x)
	{
#if 1
		Fp12 t1, t2, t3;
		Frobenius(t1, x);
		Frobenius(t2, t1);
		Frobenius(t3, t2);
		Fp12::pow(t1, t1, param.exp_c1);
		Fp12::pow(t2, t2, param.exp_c2);
		Fp12::pow(y, x, param.exp_c0);
		y *= t1;
		y *= t2;
		y *= t3;
#else
		const mpz_class& p = param.p;
		mpz_class p2 = p * p;
		mpz_class p4 = p2 * p2;
		Fp12::pow(y, x, (p4 - p2 + 1) / param.r);
#endif
	}
	/*
		y = 1 / x = conjugate of x if |x| = 1
	*/
	static void unitaryInv(Fp12& y, const Fp12& x)
	{
		y.a = x.a;
		Fp6::neg(y.b, x.b);
	}
	/*
		Faster Squaring in the Cyclotomic Subgroup of Sixth Degree Extensions
		Robert Granger, Michael Scott
	*/
	static void sqrFp4(Fp2& z0, Fp2& z1, const Fp2& x0, const Fp2& x1)
	{
#if 1
		Fp2Dbl T0, T1, T2;
		Fp2Dbl::sqrPre(T0, x0);
		Fp2Dbl::sqrPre(T1, x1);
		Fp2Dbl::mul_xi(T2, T1);
		Fp2Dbl::add(T2, T2, T0);
		Fp2::add(z1, x0, x1);
		Fp2Dbl::mod(z0, T2);
		Fp2Dbl::sqrPre(T2, z1);
		Fp2Dbl::sub(T2, T2, T0);
		Fp2Dbl::sub(T2, T2, T1);
		Fp2Dbl::mod(z1, T2);
#else
		Fp2 t0, t1, t2;
		Fp2::sqr(t0, x0);
		Fp2::sqr(t1, x1);
		Fp2::mul_xi(z0, t1);
		z0 += t0;
		Fp2::add(z1, x0, x1);
		Fp2::sqr(z1, z1);
		z1 -= t0;
		z1 -= t1;
#endif
	}
	static void fasterSqr(Fp12& y, const Fp12& x)
	{
#if 0
		Fp12::sqr(y, x);
#else
		const Fp2& x0(x.a.a);
		const Fp2& x4(x.a.b);
		const Fp2& x3(x.a.c);
		const Fp2& x2(x.b.a);
		const Fp2& x1(x.b.b);
		const Fp2& x5(x.b.c);
		Fp2& y0(y.a.a);
		Fp2& y4(y.a.b);
		Fp2& y3(y.a.c);
		Fp2& y2(y.b.a);
		Fp2& y1(y.b.b);
		Fp2& y5(y.b.c);
		Fp2 t0, t1;
		sqrFp4(t0, t1, x0, x1);
		Fp2::sub(y0, t0, x0);
		y0 += y0;
		y0 += t0;
		Fp2::add(y1, t1, x1);
		y1 += y1;
		y1 += t1;
		Fp2 t2, t3;
		sqrFp4(t0, t1, x2, x3);
		sqrFp4(t2, t3, x4, x5);
		Fp2::sub(y4, t0, x4);
		y4 += y4;
		y4 += t0;
		Fp2::add(y5, t1, x5);
		y5 += y5;
		y5 += t1;
		Fp2::mul_xi(t0, t3);
		Fp2::add(y2, t0, x2);
		y2 += y2;
		y2 += t0;
		Fp2::sub(y3, t2, x3);
		y3 += y3;
		y3 += t2;
#endif
	}
	struct Compress {
		Fp12& z_;
		Fp2& g1_;
		Fp2& g2_;
		Fp2& g3_;
		Fp2& g4_;
		Fp2& g5_;
		// z is output area
		Compress(Fp12& z, const Fp12& x)
			: z_(z)
			, g1_(z.getFp2()[4])
			, g2_(z.getFp2()[3])
			, g3_(z.getFp2()[2])
			, g4_(z.getFp2()[1])
			, g5_(z.getFp2()[5])
		{
			g2_ = x.getFp2()[3];
			g3_ = x.getFp2()[2];
			g4_ = x.getFp2()[1];
			g5_ = x.getFp2()[5];
		}
		Compress(Fp12& z, const Compress& c)
			: z_(z)
			, g1_(z.getFp2()[4])
			, g2_(z.getFp2()[3])
			, g3_(z.getFp2()[2])
			, g4_(z.getFp2()[1])
			, g5_(z.getFp2()[5])
		{
			g2_ = c.g2_;
			g3_ = c.g3_;
			g4_ = c.g4_;
			g5_ = c.g5_;
		}
		void decompressBeforeInv(Fp2& nume, Fp2& denomi) const
		{
			assert(&nume != &denomi);

			if (g2_.isZero()) {
				Fp2::add(nume, g4_, g4_);
				nume *= g5_;
				denomi = g3_;
			} else {
				Fp2 t;
				Fp2::sqr(nume, g5_);
				Fp2::mul_xi(denomi, nume);
				Fp2::sqr(nume, g4_);
				Fp2::sub(t, nume, g3_);
				t += t;
				t += nume;
				Fp2::add(nume, denomi, t);
				Fp2::divBy4(nume, nume);
				denomi = g2_;
			}
		}

		// output to z
		void decompressAfterInv()
		{
			Fp2& g0 = z_.getFp2()[0];
			Fp2 t0, t1;
			// Compute g0.
			Fp2::sqr(t0, g1_);
			Fp2::mul(t1, g3_, g4_);
			t0 -= t1;
			t0 += t0;
			t0 -= t1;
			Fp2::mul(t1, g2_, g5_);
			t0 += t1;
			Fp2::mul_xi(g0, t0);
			g0.a += Fp::one();
		}

	public:
		void decompress() // for test
		{
			Fp2 nume, denomi;
			decompressBeforeInv(nume, denomi);
			Fp2::inv(denomi, denomi);
			g1_ = nume * denomi; // g1 is recoverd.
			decompressAfterInv();
		}
		/*
			2275clk * 186 = 423Kclk QQQ
		*/
		static void squareC(Compress& z)
		{
			Fp2 t0, t1, t2;
			Fp2Dbl T0, T1, T2, T3;
			Fp2Dbl::sqrPre(T0, z.g4_);
			Fp2Dbl::sqrPre(T1, z.g5_);
			Fp2Dbl::mul_xi(T2, T1);
			T2 += T0;
			Fp2Dbl::mod(t2, T2);
			Fp2::add(t0, z.g4_, z.g5_);
			Fp2Dbl::sqrPre(T2, t0);
			T0 += T1;
			T2 -= T0;
			Fp2Dbl::mod(t0, T2);
			Fp2::add(t1, z.g2_, z.g3_);
			Fp2Dbl::sqrPre(T3, t1);
			Fp2Dbl::sqrPre(T2, z.g2_);
			Fp2::mul_xi(t1, t0);
			z.g2_ += t1;
			z.g2_ += z.g2_;
			z.g2_ += t1;
			Fp2::sub(t1, t2, z.g3_);
			t1 += t1;
			Fp2Dbl::sqrPre(T1, z.g3_);
			Fp2::add(z.g3_, t1, t2);
			Fp2Dbl::mul_xi(T0, T1);
			T0 += T2;
			Fp2Dbl::mod(t0, T0);
			Fp2::sub(z.g4_, t0, z.g4_);
			z.g4_ += z.g4_;
			z.g4_ += t0;
			Fp2Dbl::addPre(T2, T2, T1);
			T3 -= T2;
			Fp2Dbl::mod(t0, T3);
			z.g5_ += t0;
			z.g5_ += z.g5_;
			z.g5_ += t0;
		}
		static void square_n(Compress& z, int n)
		{
			for (int i = 0; i < n; i++) {
				squareC(z);
			}
		}
		/*
			Exponentiation over compression for:
			z = x^Param::z.abs()
		*/
		static void fixed_power(Fp12& z, const Fp12& x)
		{
			assert(param.isCurveFp254BNb);
			Fp12 x_org = x;
			Fp12 d62;
			Fp2 c55nume, c55denomi, c62nume, c62denomi;
			Compress c55(z, x);
			Compress::square_n(c55, 55);
			c55.decompressBeforeInv(c55nume, c55denomi);
			Compress c62(d62, c55);
			Compress::square_n(c62, 62 - 55);
			c62.decompressBeforeInv(c62nume, c62denomi);
			Fp2 acc;
			Fp2::mul(acc, c55denomi, c62denomi);
			Fp2::inv(acc, acc);
			Fp2 t;
			Fp2::mul(t, acc, c62denomi);
			Fp2::mul(c55.g1_, c55nume, t);
			c55.decompressAfterInv();
			Fp2::mul(t, acc, c55denomi);
			Fp2::mul(c62.g1_, c62nume, t);
			c62.decompressAfterInv();
			z *= x_org;
			z *= d62;
		}
	};
	/*
		y = x^z if z > 0
		  = unitaryInv(x^(-z)) if z < 0
	*/
	static void pow_z(Fp12& y, const Fp12& x)
	{
#if 1
		if (param.isCurveFp254BNb) {
			Compress::fixed_power(y, x);
		} else {
			Fp12 orgX = x;
			y = x;
			Fp12 conj;
			conj.a = x.a;
			Fp6::neg(conj.b, x.b);
			for (size_t i = 1; i < param.zReplTbl.size(); i++) {
				fasterSqr(y, y);
				if (param.zReplTbl[i] > 0) {
					y *= orgX;
				} else if (param.zReplTbl[i] < 0) {
					y *= conj;
				}
			}
		}
#else
		Fp12::pow(y, x, param.abs_z);
#endif
		if (param.isNegative) {
			unitaryInv(y, y);
		}
	}
	/*
		Faster Hashing to G2
		Laura Fuentes-Castaneda, Edward Knapp, Francisco Rodriguez-Henriquez
		section 4.1
		y = x^(d 2z(6z^2 + 3z + 1)) where
		p = p(z) = 36z^4 + 36z^3 + 24z^2 + 6z + 1
		r = r(z) = 36z^4 + 36z^3 + 18z^2 + 6z + 1
		d = (p^4 - p^2 + 1) / r
		d1 = d 2z(6z^2 + 3z + 1)
		= c0 + c1 p + c2 p^2 + c3 p^3

		c0 = 1 + 6z + 12z^2 + 12z^3
		c1 = 4z + 6z^2 + 12z^3
		c2 = 6z + 6z^2 + 12z^3
		c3 = -1 + 4z + 6z^2 + 12z^3
		x -> x^z -> x^2z -> x^4z -> x^6z -> x^(6z^2) -> x^(12z^2) -> x^(12z^3)
		a = x^(6z) x^(6z^2) x^(12z^3)
		b = a / (x^2z)
		x^d1 = (a x^(6z^2) x) b^p a^(p^2) (b / x)^(p^3)
	*/
	static void exp_d1(Fp12& y, const Fp12& x)
	{
		Fp12 a, b;
		Fp12 a2, a3;
		pow_z(b, x); // x^z
		fasterSqr(b, b); // x^2z
		fasterSqr(a, b); // x^4z
		a *= b; // x^6z
		pow_z(a2, a); // x^(6z^2)
		a *= a2;
		fasterSqr(a3, a2); // x^(12z^2)
		pow_z(a3, a3); // x^(12z^3)
		a *= a3;
		unitaryInv(b, b);
		b *= a;
		a2 *= a;
		Frobenius2(a, a);
		a *= a2;
		a *= x;
		unitaryInv(y, x);
		y *= b;
		Frobenius(b, b);
		a *= b;
		Frobenius3(y, y);
		y *= a;
	}
	static void mapToCyclotomic(Fp12& y, const Fp12& x)
	{
		Fp12 z;
		Frobenius2(z, x); // z = x^(p^2)
		z *= x; // x^(p^2 + 1)
		Fp12::inv(y, z);
		Fp6::neg(z.b, z.b); // z^(p^6) = conjugate of z
		y *= z;
	}
	/*
		y = x^((p^12 - 1) / r)
		(p^12 - 1) / r = (p^2 + 1) (p^6 - 1) (p^4 - p^2 + 1)/r
		(a + bw)^(p^6) = a - bw in Fp12
		(p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
	*/
	static void finalExp(Fp12& y, const Fp12& x)
	{
#if 1
		mapToCyclotomic(y, x);
#else
		const mpz_class& p = param.p;
		mpz_class p2 = p * p;
		mpz_class p4 = p2 * p2;
		Fp12::pow(y, x, p2 + 1);
		Fp12::pow(y, y, p4 * p2 - 1);
#endif
		exp_d1(y, y);
	}
	static void millerLoop(Fp12& f, const G1& P, const G2& Q)
	{
		P.normalize();
		Q.normalize();
		G2 T = Q;
		G2 negQ;
		if (param.useNAF) {
			G2::neg(negQ, Q);
		}
		Fp6 d;
		dblLine(d, T, P);
		Fp6 e;
		assert(param.siTbl[1] == 1);
		addLine(e, T, Q, P);
		mul_024_024(f, d, e);
		Fp6 l;
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			dblLine(l, T, P);
			Fp12::sqr(f, f);
			mul_024(f, f, l);
			if (param.siTbl[i]) {
				if (param.siTbl[i] > 0) {
					addLine(l, T, Q, P);
				} else {
					addLine(l, T, negQ, P);
				}
				mul_024(f, f, l);
			}
		}
		G2 Q1, Q2;
		FrobeniusOnTwist(Q1, Q);
		FrobeniusOnTwist(Q2, Q1);
		G2::neg(Q2, Q2);
		if (param.z < 0) {
			G2::neg(T, T);
			Fp6::neg(f.b, f.b);
		}
		addLine(d, T, Q1, P);
		addLine(e, T, Q2, P);
		Fp12 ft;
		mul_024_024(ft, d, e);
		f *= ft;
	}
	static void pairing(Fp12& f, const G1& P, const G2& Q)
	{
		millerLoop(f, P, Q);
		finalExp(f, f);
	}
	/*
		millerLoop(e, P, Q) is same as the following
		std::vector<Fp6> Qcoeff;
		precomputeG2(Qcoeff, Q);
		precomputedMillerLoop(e, P, Qcoeff);
	*/
	static void precomputeG2(std::vector<Fp6>& Qcoeff, const G2& Q)
	{
		Qcoeff.resize(param.precomputedQcoeffSize);
		precomputeG2(Qcoeff.data(), Q);
	}
	/*
		allocate param.precomputedQcoeffSize elements of Fp6 for Qcoeff
	*/
	static void precomputeG2(Fp6 *Qcoeff, const G2& Q)
	{
		size_t idx = 0;
		Q.normalize();
		G2 T = Q;
		G2 negQ;
		if (param.useNAF) {
			G2::neg(negQ, Q);
		}
		assert(param.siTbl[1] == 1);
		dblLineWithoutP(Qcoeff[idx++], T);
		addLineWithoutP(Qcoeff[idx++], T, Q);
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			dblLineWithoutP(Qcoeff[idx++], T);
			if (param.siTbl[i]) {
				if (param.siTbl[i] > 0) {
					addLineWithoutP(Qcoeff[idx++], T, Q);
				} else {
					addLineWithoutP(Qcoeff[idx++], T, negQ);
				}
			}
		}
		G2 Q1, Q2;
		FrobeniusOnTwist(Q1, Q);
		FrobeniusOnTwist(Q2, Q1);
		G2::neg(Q2, Q2);
		if (param.z < 0) {
			G2::neg(T, T);
		}
		addLineWithoutP(Qcoeff[idx++], T, Q1);
		addLineWithoutP(Qcoeff[idx++], T, Q2);
		assert(idx == param.precomputedQcoeffSize);
	}
	static void precomputedMillerLoop(Fp12& f, const G1& P, const std::vector<Fp6>& Qcoeff)
	{
		precomputedMillerLoop(f, P, Qcoeff.data());
	}
	static void precomputedMillerLoop(Fp12& f, const G1& P, const Fp6* Qcoeff)
	{
		P.normalize();
		size_t idx = 0;
		Fp6 d, e;
		mulFp6cb_by_G1xy(d, Qcoeff[idx], P);
		idx++;

		mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
		idx++;
		mul_024_024(f, d, e);
		Fp6 l;
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			mulFp6cb_by_G1xy(l, Qcoeff[idx], P);
			idx++;
			Fp12::sqr(f, f);
			mul_024(f, f, l);
			if (param.siTbl[i]) {
				mulFp6cb_by_G1xy(l, Qcoeff[idx], P);
				idx++;
				mul_024(f, f, l);
			}
		}
		if (param.z < 0) {
			Fp6::neg(f.b, f.b);
		}
		mulFp6cb_by_G1xy(d, Qcoeff[idx], P);
		idx++;
		mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
		idx++;
		Fp12 ft;
		mul_024_024(ft, d, e);
		f *= ft;
	}
	/*
		f = MillerLoop(P1, Q1) x MillerLoop(P2, Q2)
	*/
	static void precomputedMillerLoop2(Fp12& f, const G1& P1, const std::vector<Fp6>& Q1coeff, const G1& P2, const std::vector<Fp6>& Q2coeff)
	{
		precomputedMillerLoop2(f, P1, Q1coeff.data(), P2, Q2coeff.data());
	}
	static void precomputedMillerLoop2(Fp12& f, const G1& P1, const Fp6* Q1coeff, const G1& P2, const Fp6* Q2coeff)
	{
		P1.normalize();
		P2.normalize();
		size_t idx = 0;
		Fp6 d1, d2;
		mulFp6cb_by_G1xy(d1, Q1coeff[idx], P1);
		mulFp6cb_by_G1xy(d2, Q2coeff[idx], P2);
		idx++;

		Fp6 e1, e2;
		Fp12 f1, f2;
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
		mul_024_024(f1, d1, e1);

		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		mul_024_024(f2, d2, e2);
		Fp12::mul(f, f1, f2);
		idx++;
		Fp6 l1, l2;
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			mulFp6cb_by_G1xy(l1, Q1coeff[idx], P1);
			mulFp6cb_by_G1xy(l2, Q2coeff[idx], P2);
			idx++;
			Fp12::sqr(f, f);
			mul_024_024(f1, l1, l2);
			f *= f1;
			if (param.siTbl[i]) {
				mulFp6cb_by_G1xy(l1, Q1coeff[idx], P1);
				mulFp6cb_by_G1xy(l2, Q2coeff[idx], P2);
				idx++;
				mul_024_024(f1, l1, l2);
				f *= f1;
			}
		}
		if (param.z < 0) {
			Fp6::neg(f.b, f.b);
		}
		mulFp6cb_by_G1xy(d1, Q1coeff[idx], P1);
		mulFp6cb_by_G1xy(d2, Q2coeff[idx], P2);
		idx++;
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		idx++;
		mul_024_024(f1, d1, e1);
		mul_024_024(f2, d2, e2);
		f *= f1;
		f *= f2;
	}
	static void mapToG1(G1& P, const Fp& x) { param.mapTo.calcG1(P, x); }
	static void mapToG2(G2& P, const Fp2& x) { param.mapTo.calcG2(P, x); }
#if 1 // duplicated later
	// old order of P and Q
	static void pairing(Fp12& f, const G2& Q, const G1& P)
	{
		pairing(f, P, Q);
	}
#endif
};

template<class Fp>
ParamT<Fp> BNT<Fp>::param;

} } // mcl::bn

