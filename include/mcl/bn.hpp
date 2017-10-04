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
const CurveParam CurveFp462 = { "0x4001fffffffffffffffffffffbfff", 5, 2 }; // 2^114 + 2^101 - 2^14 - 1 // https://eprint.iacr.org/2017/334

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
		if (t.isZero()) goto ERR_POINT;
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
		/*
			G2::mul (GLV method) can't be used because P is not on G2
		*/
		G2::mulGeneric(P, P, cofactor);
		assert(!P.isZero());
	}
};

/*
	Software implementation of Attribute-Based Encryption: Appendixes
	GLV for G1
*/
template<class Fp>
struct GLV1 {
	typedef mcl::EcT<Fp> G1;
	Fp rw; // rw = 1 / w = (-1 - sqrt(-3)) / 2
	size_t m;
	mpz_class v0, v1;
	mpz_class B[2][2];
	mpz_class r;
	void init(const mpz_class& r, const mpz_class& z)
	{
		if (!Fp::squareRoot(rw, -3)) throw cybozu::Exception("GLV1:init");
		rw = -(rw + 1) / 2;
		this->r = r;
		m = gmp::getBitSize(r);
		m = (m + fp::UnitBitSize - 1) & ~(fp::UnitBitSize - 1);// a little better size
		v0 = ((6 * z * z + 4 * z + 1) << m) / r;
		v1 = ((-2 * z - 1) << m) / r;
		B[0][0] = 6 * z * z + 2 * z;
		B[0][1] = -2 * z - 1;
		B[1][0] = -2 * z - 1;
		B[1][1] = -6 * z * z - 4 * z - 1;
	}
	/*
		lambda = 36z^4 - 1
		lambda (x, y) = (rw x, y)
	*/
	void mulLambda(G1& Q, const G1& P) const
	{
		Fp::mul(Q.x, P.x, rw);
		Q.y = P.y;
		Q.z = P.z;
	}
	/*
		lambda = 36 z^4 - 1
		x = a + b * lambda mod r
	*/
	void split(mpz_class& a, mpz_class& b, const mpz_class& x) const
	{
		mpz_class t;
		t = (x * v0) >> m;
		b = (x * v1) >> m;
		a = x - (t * B[0][0] + b * B[1][0]);
		b = - (t * B[0][1] + b * B[1][1]);
	}
	void mul(G1& Q, const G1& P, mpz_class x, bool constTime = false) const
	{
		typedef mcl::fp::Unit Unit;
		const size_t maxUnit = 512 / 2 / mcl::fp::UnitBitSize;
		const int splitN = 2;
		mpz_class u[splitN];
		G1 in[splitN];
		G1 tbl[4];
		int bitTbl[splitN]; // bit size of u[i]
		Unit w[splitN][maxUnit]; // unit array of u[i]
		int maxBit = 0; // max bit of u[i]
		int maxN = 0;
		int remainBit = 0;

		x %= r;
		if (x == 0) {
			Q.clear();
			if (constTime) goto DummyLoop;
			return;
		}
		if (x < 0) {
			x += r;
		}
		split(u[0], u[1], x);
		in[0] = P;
		mulLambda(in[1], in[0]);
		for (int i = 0; i < splitN; i++) {
			if (u[i] < 0) {
				u[i] = -u[i];
				G1::neg(in[i], in[i]);
			}
			in[i].normalize();
		}
#if 0
		G1::mulGeneric(in[0], in[0], u[0]);
		G1::mulGeneric(in[1], in[1], u[1]);
		G1::add(Q, in[0], in[1]);
		return;
#else
		tbl[0] = in[0]; // dummy
		tbl[1] = in[0];
		tbl[2] = in[1];
		G1::add(tbl[3], in[0], in[1]);
		tbl[3].normalize();
		for (int i = 0; i < splitN; i++) {
			mcl::gmp::getArray(w[i], maxUnit, u[i]);
			bitTbl[i] = (int)mcl::gmp::getBitSize(u[i]);
			maxBit = std::max(maxBit, bitTbl[i]);
		}
		assert(maxBit > 0);
		maxBit--;
		/*
			maxBit = maxN * UnitBitSize + remainBit
			0 < remainBit <= UnitBitSize
		*/
		maxN = maxBit / mcl::fp::UnitBitSize;
		remainBit = maxBit % mcl::fp::UnitBitSize;
		remainBit++;
		Q.clear();
		for (int i = maxN; i >= 0; i--) {
			for (int j = remainBit - 1; j >= 0; j--) {
				G1::dbl(Q, Q);
				uint32_t b0 = (w[0][i] >> j) & 1;
				uint32_t b1 = (w[1][i] >> j) & 1;
				uint32_t c = b1 * 2 + b0;
				if (c == 0) {
					if (constTime) tbl[0] += tbl[1];
				} else {
					Q += tbl[c];
				}
			}
			remainBit = (int)mcl::fp::UnitBitSize;
		}
#endif
	DummyLoop:
		if (!constTime) return;
		const int limitBit = (int)Fp::getBitSize() / splitN;
		G1 D = tbl[0];
		for (int i = maxBit + 1; i < limitBit; i++) {
			G1::dbl(D, D);
			D += tbl[0];
		}
	}
};

/*
	twisted Frobenius for G2
*/
template<class G2>
struct HaveFrobenius : public G2 {
	typedef typename G2::Fp Fp2;
	/*
		FrobeniusOnTwist
		p mod 6 = 1, w^6 = xi
		Frob(x', y') = phi Frob phi^-1(x', y')
		= phi Frob (x' w^2, y' w^3)
		= phi (x'^p w^2p, y'^p w^3p)
		= (F(x') w^2(p - 1), F(y') w^3(p - 1))
		= (F(x') g^2, F(y') g^3)
	*/
	static void Frobenius(G2& D, const G2& S)
	{
		Fp2::Frobenius(D.x, S.x);
		Fp2::Frobenius(D.y, S.y);
		Fp2::Frobenius(D.z, S.z);
		D.x *= Fp2::get_gTbl()[0];
		D.y *= Fp2::get_gTbl()[3];
	}
	static void Frobenius(HaveFrobenius& y, const HaveFrobenius& x)
	{
		Frobenius(static_cast<G2&>(y), static_cast<const G2&>(x));
	}
};
/*
	GLV method for G2 and GT
*/
template<class Fp2>
struct GLV2 {
	typedef typename Fp2::BaseFp Fp;
	typedef mcl::EcT<Fp2> G2;
	typedef mcl::Fp12T<Fp> Fp12;
	size_t m;
	mpz_class B[4][4];
	mpz_class r;
	mpz_class v[4];
	GLV2() : m(0) {}
	void init(const mpz_class& r, const mpz_class& z)
	{
		this->r = r;
		m = mcl::gmp::getBitSize(r);
		m = (m + mcl::fp::UnitBitSize - 1) & ~(mcl::fp::UnitBitSize - 1);// a little better size
		/*
			v[] = [1, 0, 0, 0] * B^(-1) = [2z^2+3z+1, 12z^3+8z^2+z, 6z^3+4z^2+z, -(2z+1)]
		*/
		v[0] = ((1 + z * (3 + z * 2)) << m) / r;
		v[1] = ((z * (1 + z * (8 + z * 12))) << m) / r;
		v[2] = ((z * (1 + z * (4 + z * 6))) << m) / r;
		v[3] = -((z * (1 + z * 2)) << m) / r;
		mpz_class z2p1 = z * 2 + 1;
		B[0][0] = z + 1;
		B[0][1] = z;
		B[0][2] = z;
		B[0][3] = -2 * z;
		B[1][0] = z2p1;
		B[1][1] = -z;
		B[1][2] = -(z + 1);
		B[1][3] = -z;
		B[2][0] = 2 * z;
		B[2][1] = z2p1;
		B[2][2] = z2p1;
		B[2][3] = z2p1;
		B[3][0] = z - 1;
		B[3][1] = 2 * z2p1;
		B[3][2] =  -2 * z + 1;
		B[3][3] = z - 1;
	}
	/*
		u[] = [x, 0, 0, 0] - v[] * x * B
	*/
	void split(mpz_class u[4], const mpz_class& x) const
	{
		mpz_class t[4];
		for (int i = 0; i < 4; i++) {
			t[i] = (x * v[i]) >> m;
		}
		for (int i = 0; i < 4; i++) {
			u[i] = (i == 0) ? x : 0;
			for (int j = 0; j < 4; j++) {
				u[i] -= t[j] * B[j][i];
			}
		}
	}
	template<class T>
	void mul(T& Q, const T& P, mpz_class x, bool constTime = false) const
	{
#if 0 // #ifndef NDEBUG
		{
			T R;
			T::mulGeneric(R, P, r);
			assert(R.isZero());
		}
#endif
		typedef mcl::fp::Unit Unit;
		const size_t maxUnit = 512 / 2 / mcl::fp::UnitBitSize;
		const int splitN = 4;
		mpz_class u[splitN];
		T in[splitN];
		T tbl[16];
		int bitTbl[splitN]; // bit size of u[i]
		Unit w[splitN][maxUnit]; // unit array of u[i]
		int maxBit = 0; // max bit of u[i]
		int maxN = 0;
		int remainBit = 0;

		x %= r;
		if (x == 0) {
			Q.clear();
			if (constTime) goto DummyLoop;
			return;
		}
		if (x < 0) {
			x += r;
		}
		split(u, x);
		in[0] = P;
		T::Frobenius(in[1], in[0]);
		T::Frobenius(in[2], in[1]);
		T::Frobenius(in[3], in[2]);
		for (int i = 0; i < splitN; i++) {
			if (u[i] < 0) {
				u[i] = -u[i];
				T::neg(in[i], in[i]);
			}
//			in[i].normalize(); // slow
		}
#if 0
		for (int i = 0; i < splitN; i++) {
			T::mulGeneric(in[i], in[i], u[i]);
		}
		T::add(Q, in[0], in[1]);
		Q += in[2];
		Q += in[3];
		return;
#else
		tbl[0] = in[0];
		for (size_t i = 1; i < 16; i++) {
			tbl[i].clear();
			if (i & 1) {
				tbl[i] += in[0];
			}
			if (i & 2) {
				tbl[i] += in[1];
			}
			if (i & 4) {
				tbl[i] += in[2];
			}
			if (i & 8) {
				tbl[i] += in[3];
			}
//			tbl[i].normalize();
		}
		for (int i = 0; i < splitN; i++) {
			mcl::gmp::getArray(w[i], maxUnit, u[i]);
			bitTbl[i] = (int)mcl::gmp::getBitSize(u[i]);
			maxBit = std::max(maxBit, bitTbl[i]);
		}
		maxBit--;
		/*
			maxBit = maxN * UnitBitSize + remainBit
			0 < remainBit <= UnitBitSize
		*/
		maxN = maxBit / mcl::fp::UnitBitSize;
		remainBit = maxBit % mcl::fp::UnitBitSize;
		remainBit++;
		Q.clear();
		for (int i = maxN; i >= 0; i--) {
			for (int j = remainBit - 1; j >= 0; j--) {
				T::dbl(Q, Q);
				uint32_t b0 = (w[0][i] >> j) & 1;
				uint32_t b1 = (w[1][i] >> j) & 1;
				uint32_t b2 = (w[2][i] >> j) & 1;
				uint32_t b3 = (w[3][i] >> j) & 1;
				uint32_t c = b3 * 8 + b2 * 4 + b1 * 2 + b0;
				if (c == 0) {
					if (constTime) tbl[0] += tbl[1];
				} else {
					Q += tbl[c];
				}
			}
			remainBit = (int)mcl::fp::UnitBitSize;
		}
#endif
	DummyLoop:
		if (!constTime) return;
		const int limitBit = (int)Fp::getBitSize() / splitN;
		T D = tbl[0];
		for (int i = maxBit + 1; i < limitBit; i++) {
			T::dbl(D, D);
			D += tbl[0];
		}
	}
	void mul(G2& Q, const G2& P, mpz_class x, bool constTime = false) const
	{
		typedef HaveFrobenius<G2> G2withF;
		G2withF& QQ(static_cast<G2withF&>(Q));
		const G2withF& PP(static_cast<const G2withF&>(P));
		mul(QQ, PP, x, constTime);
	}
	void pow(Fp12& z, const Fp12& x, mpz_class y, bool constTime = false) const
	{
		typedef GroupMtoA<Fp12> AG; // as additive group
		AG& _z = static_cast<AG&>(z);
		const AG& _x = static_cast<const AG&>(x);
		mul(_z, _x, y, constTime);
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
	int b;
	/*
		twist
		(x', y') = phi(x, y) = (x/w^2, y/w^3)
		y^2 = x^3 + b
		=> (y'w^3)^2 = (x'w^2)^3 + b
		=> y'^2 = x'^3 + b / w^6 ; w^6 = xi
		=> y'^2 = x'^3 + twist_b;
	*/
	Fp2 twist_b;
	enum {
		tb_generic,
		tb_1m1i,
		tb_1m2i
	} twist_b_type;
	bool is_b_div_xi_1_m1i;
	mpz_class exp_c0;
	mpz_class exp_c1;
	mpz_class exp_c2;
	MapToT<Fp> mapTo;
	GLV1<Fp> glv1;
	GLV2<Fp2> glv2;

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
		r = eval(rCoff, z);
		Fp::init(p, mode);
		Fp2::init(cp.xi_a);
		b = cp.b;
		Fp2 xi(cp.xi_a, 1);
		twist_b = Fp2(b) / xi;
		if (twist_b == Fp2(1, -1)) {
			twist_b_type = tb_1m1i;
		} else if (twist_b == Fp2(1, -2)) {
			twist_b_type = tb_1m2i;
		} else {
			twist_b_type = tb_generic;
		}
		G1::init(0, b, mcl::ec::Proj);
		G2::init(0, twist_b, mcl::ec::Proj);
		G2::setOrder(r);
		mapTo.init(2 * p - r);
		glv1.init(r, z);

		const mpz_class largest_c = gmp::abs(z * 6 + 2);
		useNAF = gmp::getNAF(siTbl, largest_c);
		precomputedQcoeffSize = getPrecomputeQcoeffSize(siTbl);
		gmp::getNAF(zReplTbl, gmp::abs(z));
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
	typedef HaveFrobenius<G2> G2withF;
	typedef mcl::FpDblT<Fp> FpDbl;
	typedef mcl::Fp2DblT<Fp> Fp2Dbl;
	typedef ParamT<Fp> Param;
	static Param param;
	static void mulArrayGLV1(G1& z, const G1& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		mpz_class s;
		mcl::gmp::setArray(s, y, yn);
		if (isNegative) s = -s;
		param.glv1.mul(z, x, s, constTime);
	}
	static void mulArrayGLV2(G2& z, const G2& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		mpz_class s;
		mcl::gmp::setArray(s, y, yn);
		if (isNegative) s = -s;
		param.glv2.mul(z, x, s, constTime);
	}
	static void powArrayGLV2(Fp12& z, const Fp12& x, const mcl::fp::Unit *y, size_t yn, bool isNegative, bool constTime)
	{
		mpz_class s;
		mcl::gmp::setArray(s, y, yn);
		if (isNegative) s = -s;
		param.glv2.pow(z, x, s, constTime);
	}
	static void init(const mcl::bn::CurveParam& cp = CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
	{
		param.init(cp, mode);
		G1::setMulArrayGLV(mulArrayGLV1);
		param.glv2.init(param.r, param.z);
		G2::setMulArrayGLV(mulArrayGLV2);
		Fp12::setPowArrayGLV(powArrayGLV2);
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
		switch (param.twist_b_type) {
		case Param::tb_1m1i:
			/*
				b / xi = 1 - 1i
				(a + bi)(1 - 1i) = (a + b) + (b - a)i
			*/
			{
				Fp t;
				Fp::add(t, x.a, x.b);
				Fp::sub(y.b, x.b, x.a);
				y.a = t;
			}
			return;
		case Param::tb_1m2i:
			/*
				b / xi = 1 - 2i
				(a + bi)(1 - 2i) = (a + 2b) + (b - 2a)i
			*/
			{
				Fp t;
				Fp::sub(t, x.b, x.a);
				t -= x.a;
				Fp::add(y.a, x.a, x.b);
				y.a += x.b;
				y.b = t;
			}
			return;
		case Param::tb_generic:
			Fp2::mul(y, x, param.twist_b);
			return;
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
	static void Fp2Dbl_mulOpt(Fp2Dbl& Z, const Fp2& x, const Fp2& y)
	{
		FpDbl D0;
		Fp s, t;
		Fp::addPre(s, x.a, x.b);
		Fp::addPre(t, y.a, y.b);
		FpDbl::mulPre(D0, x.b, y.b);
		FpDbl::mulPre(Z.a, x.a, y.a);
		FpDbl::mulPre(Z.b, s, t);
		FpDbl::subPre(Z.b, Z.b, Z.a);
		FpDbl::subPre(Z.b, Z.b, D0);
		FpDbl::sub(Z.a, Z.a, D0);
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
	// mul_024(z, z(=y), x)
	static void mul_024(Fp12& z, const Fp6& x)
	{
		Fp2& z0 = z.a.a;
		Fp2& z1 = z.a.b;
		Fp2& z2 = z.a.c;
		Fp2& z3 = z.b.a;
		Fp2& z4 = z.b.b;
		Fp2& z5 = z.b.c;
		const Fp2& x0 = x.a;
		const Fp2& x2 = x.c;
		const Fp2& x4 = x.b;
		Fp2 t0, t1, t2;
		Fp2 s0;
		Fp2Dbl T3, T4;
		Fp2Dbl D0, D2, D4;
		Fp2Dbl S1;
		Fp2Dbl_mulOpt(D0, z0, x0);
		Fp2Dbl_mulOpt(D2, z2, x2);
		Fp2Dbl_mulOpt(D4, z4, x4);
		Fp2::add(t2, z0, z4);
		Fp2::add(t1, z0, z2);
		Fp2::add(s0, z1, z3);
		s0 += z5;
		// For z.a.a = z0.
		Fp2Dbl_mulOpt(S1, z1, x2);
		Fp2Dbl::add(T3, S1, D4);
		Fp2Dbl::mul_xi(T4, T3);
		T4 += D0;
		Fp2Dbl::mod(z0, T4);
		// For z.a.b = z1.
		Fp2Dbl_mulOpt(T3, z5, x4);
		S1 += T3;
		T3 += D2;
		Fp2Dbl::mul_xi(T4, T3);
		Fp2Dbl_mulOpt(T3, z1, x0);
		S1 += T3;
		T4 += T3;
		Fp2Dbl::mod(z1, T4);
		// For z.a.c = z2.
		Fp2::add(t0, x0, x2);
		Fp2Dbl_mulOpt(T3, t1, t0);
		T3 -= D0;
		T3 -= D2;
		Fp2Dbl_mulOpt(T4, z3, x4);
		S1 += T4;
		T3 += T4;
		// z3 needs z2.
		// For z.b.a = z3.
		Fp2::add(t0, z2, z4);
		Fp2Dbl::mod(z2, T3);
		Fp2::add(t1, x2, x4);
		Fp2Dbl_mulOpt(T3, t0, t1);
		T3 -= D2;
		T3 -= D4;
		Fp2Dbl::mul_xi(T4, T3);
		Fp2Dbl_mulOpt(T3, z3, x0);
		S1 += T3;
		T4 += T3;
		Fp2Dbl::mod(z3, T4);
		// For z.b.b = z4.
		Fp2Dbl_mulOpt(T3, z5, x2);
		S1 += T3;
		Fp2Dbl::mul_xi(T4, T3);
		Fp2::add(t0, x0, x4);
		Fp2Dbl_mulOpt(T3, t2, t0);
		T3 -= D0;
		T3 -= D4;
		T4 += T3;
		Fp2Dbl::mod(z4, T4);
		// For z.b.c = z5.
		Fp2::add(t0, x0, x2);
		t0 += x4;
		Fp2Dbl_mulOpt(T3, s0, t0);
		T3 -= S1;
		Fp2Dbl::mod(z5, T3);
	}
#if 0
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
		Fp2Dbl X0Y4, X1Y4, X2Y4, X3Y2, X4Y2, X5Y2;
		Fp2Dbl::mulPre(X0Y4, x0, y4);
		Fp2Dbl::mulPre(X1Y4, x1, y4);
		Fp2Dbl::mulPre(X2Y4, x2, y4);
		Fp2Dbl::mulPre(X3Y2, x3, y2);
		Fp2Dbl::mulPre(X4Y2, x4, y2);
		Fp2Dbl::mulPre(X5Y2, x5, y2);

		Fp2 x1_add_x4;
		Fp2 x2_add_x5;
		Fp2 x0_add_x3;
		Fp2::add(x1_add_x4, x1, x4);
		Fp2::add(x2_add_x5, x2, x5);
		Fp2::add(x0_add_x3, x0, x3);
		Fp2Dbl T1, T2;
		Fp2Dbl::mulPre(T1, x1_add_x4, y2_add_y4);
		T1 -= X1Y4;
		T1 -= X4Y2;
		Fp2Dbl::mul_xi(T1, T1);
		Fp2Dbl::mulPre(T2, x0, y0);
		T1 += T2;
		Fp2Dbl::mod(z.a.a, T1);

		Fp2Dbl::mulPre(T1, x2_add_x5, y2_add_y4);
		T1 -= X2Y4;
		T1 -= X5Y2;
		Fp2Dbl::mul_xi(T1, T1);
		Fp2Dbl::mulPre(T2, x1, y0);
		Fp2Dbl::add(T1, T1, T2);
		Fp2Dbl::mod(z.a.b, T1);
		Fp2Dbl::mulPre(T1, x0_add_x3, y2_add_y4);
		T1 -= X0Y4;
		T1 -= X3Y2;
		Fp2Dbl::mulPre(T2, x2, y0);
		T1 += T2;
		Fp2Dbl::mod(z.a.c, T1);

		Fp2Dbl::add(T1, X2Y4, X4Y2);
		Fp2Dbl::mul_xi(T1, T1);
		Fp2Dbl::mulPre(T2, x3, y0);
		T1 += T2;
		Fp2Dbl::mod(z.b.a, T1);

		Fp2Dbl::mul_xi(T1, X5Y2);
		Fp2Dbl::mulPre(T2, x4, y0);
		T2 += X0Y4;
		T1 += T2;
		Fp2Dbl::mod(z.b.b, T1);

		Fp2Dbl::mulPre(T1, x5, y0);
		T1 += X3Y2;
		T1 += X1Y4;
		Fp2Dbl::mod(z.b.c, T1);
#else
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
#endif
	}
#endif
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
			if (x.isOne()) {
				z = 1;
				return;
			}
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
			Fp12::unitaryInv(y, y);
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
		Fp12::unitaryInv(b, b);
		b *= a;
		a2 *= a;
		Fp12::Frobenius2(a, a);
		a *= a2;
		a *= x;
		Fp12::unitaryInv(y, x);
		y *= b;
		Fp12::Frobenius(b, b);
		a *= b;
		Fp12::Frobenius3(y, y);
		y *= a;
	}
	static void mapToCyclotomic(Fp12& y, const Fp12& x)
	{
		Fp12 z;
		Fp12::Frobenius2(z, x); // z = x^(p^2)
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
	static void millerLoop(Fp12& f, const G1& P_, const G2& Q_)
	{
		G1 P(P_);
		G2 Q(Q_);
		P.normalize();
		Q.normalize();
		if (Q.isZero()) {
			f = 1;
			return;
		}
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
			mul_024(f, l);
			if (param.siTbl[i]) {
				if (param.siTbl[i] > 0) {
					addLine(l, T, Q, P);
				} else {
					addLine(l, T, negQ, P);
				}
				mul_024(f, l);
			}
		}
		G2 Q1, Q2;
		G2withF::Frobenius(Q1, Q);
		G2withF::Frobenius(Q2, Q1);
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
	static void precomputeG2(Fp6 *Qcoeff, const G2& Q_)
	{
		size_t idx = 0;
		G2 Q(Q_);
		Q.normalize();
		if (Q.isZero()) {
			for (size_t i = 0; i < param.precomputedQcoeffSize; i++) {
				Qcoeff[i] = 1;
			}
			return;
		}
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
		G2withF::Frobenius(Q1, Q);
		G2withF::Frobenius(Q2, Q1);
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
	static void precomputedMillerLoop(Fp12& f, const G1& P_, const Fp6* Qcoeff)
	{
		G1 P(P_);
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
			mul_024(f, l);
			if (param.siTbl[i]) {
				mulFp6cb_by_G1xy(l, Qcoeff[idx], P);
				idx++;
				mul_024(f, l);
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
	static void precomputedMillerLoop2(Fp12& f, const G1& P1_, const Fp6* Q1coeff, const G1& P2_, const Fp6* Q2coeff)
	{
		G1 P1(P1_), P2(P2_);
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
	static void hashAndMapToG1(G1& P, const void *buf, size_t bufSize)
	{
		Fp t;
		t.setHashOf(buf, bufSize);
		mapToG1(P, t);
	}
	static void hashAndMapToG2(G2& P, const void *buf, size_t bufSize)
	{
		Fp2 t;
		t.a.setHashOf(buf, bufSize);
		t.b.clear();
		mapToG2(P, t);
	}
	static void hashAndMapToG1(G1& P, const std::string& str)
	{
		hashAndMapToG1(P, str.c_str(), str.size());
	}
	static void hashAndMapToG2(G2& P, const std::string& str)
	{
		hashAndMapToG2(P, str.c_str(), str.size());
	}
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

