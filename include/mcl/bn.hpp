#pragma once
/**
	@file
	@brief optimal ate pairing over BN-curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/pairing_util.hpp>

namespace mcl { namespace bn {

using mcl::CurveParam;
using mcl::getCurveParam;

template<class Fp>
struct MapToT {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef util::HaveFrobenius<G2> G2withF;
	Fp c1_; // sqrt(-3)
	Fp c2_; // (-1 + sqrt(-3)) / 2
	mpz_class cofactor_;
	mpz_class z_;
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
	/*
		P.-A. Fouque and M. Tibouchi,
		"Indifferentiable hashing to Barreto Naehrig curves,"
		in Proc. Int. Conf. Cryptol. Inform. Security Latin Amer., 2012, vol. 7533, pp.1-17.

		w = sqrt(-3) t / (1 + b + t^2)
		Remark: throw exception if t = 0, c1, -c1 and b = 2
	*/
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
		mulFp(w, c1_);
		w *= t;
		for (int i = 0; i < 3; i++) {
			switch (i) {
			case 0: F::mul(x, t, w); F::neg(x, x); *x.getFp0() += c2_; break;
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
		Faster Hashing to G2
		Laura Fuentes-Castaneda, Edward Knapp, Francisco Rodriguez-Henriquez
		section 6.1
		for BN
		Q = zP + Frob(3zP) + Frob^2(zP) + Frob^3(P)
		  = -(18x^3 + 12x^2 + 3x + 1)cofactor_ P
	*/
	void mulByCofactor(G2& Q, const G2& P) const
	{
#if 0
		G2::mulGeneric(Q, P, cofactor_);
#else
#if 0
		mpz_class t = -(1 + z_ * (3 + z_ * (12 + z_ * 18)));
		G2::mulGeneric(Q, P, t * cofactor_);
#else
		G2 T0, T1, T2;
		/*
			G2::mul (GLV method) can't be used because P is not on G2
		*/
		G2::mulGeneric(T0, P, z_);
		G2::dbl(T1, T0);
		T1 += T0; // 3zP
		G2withF::Frobenius(T1, T1);
		G2withF::Frobenius2(T2, T0);
		T0 += T1;
		T0 += T2;
		G2withF::Frobenius3(T2, P);
		G2::add(Q, T0, T2);
#endif
#endif
	}
	/*
		cofactor_ is for G2
	*/
	void init(const mpz_class& cofactor, const mpz_class &z)
	{
		if (!Fp::squareRoot(c1_, -3)) throw cybozu::Exception("MapToT:init:c1_");
		c2_ = (c1_ - 1) / 2;
		cofactor_ = cofactor;
		z_ = z;
	}
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
		assert(cofactor_ != 0);
		mulByCofactor(P, P);
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
		typedef util::HaveFrobenius<G2> G2withF;
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
struct ParamT : public util::CommonParamT<Fp> {
	typedef util::CommonParamT<Fp> Common;
	typedef Fp2T<Fp> Fp2;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	MapToT<Fp> mapTo;
	GLV1<Fp> glv1;
	GLV2<Fp2> glv2;

	void init(const CurveParam& cp = CurveFp254BNb, fp::Mode mode = fp::FP_AUTO)
	{
		Common::initCommonParam(cp, mode, false);
		mapTo.init(2 * this->p - this->r, this->z);
		glv1.init(this->r, this->z);
		glv2.init(this->r, this->z);
	}
};

template<class Fp>
struct BNT {
	typedef mcl::Fp2T<Fp> Fp2;
	typedef mcl::Fp6T<Fp> Fp6;
	typedef mcl::Fp12T<Fp> Fp12;
	typedef mcl::EcT<Fp> G1;
	typedef mcl::EcT<Fp2> G2;
	typedef util::HaveFrobenius<G2> G2withF;
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
		G2withF::init(param.isMtype);
		G1::setMulArrayGLV(mulArrayGLV1);
		G2::setMulArrayGLV(mulArrayGLV2);
		Fp12::setPowArrayGLV(powArrayGLV2);
	}
////////////////////////////////////////////////////////////////////////////////////
	#include "ml-fe.hpp"
/////////////////////////////////////////////////////////////
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

