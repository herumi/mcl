#pragma once
/**
	@file
	@brief optimal ate pairing over BN-curve / BLS12-curve
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/g1_def.hpp>
#include <mcl/g2_def.hpp>
#include <mcl/curve_type.hpp>
#include <assert.h>
#ifndef CYBOZU_DONT_USE_EXCEPTION
#include <vector>
#endif

#ifdef MCL_USE_OMP
#include <omp.h>
#endif

#include "compress.hpp"
#include "msm.hpp"

namespace mcl {

namespace bn {

// backward compatibility
typedef mcl::Fp Fp;
typedef mcl::Fr Fr;
typedef mcl::G1 G1;
typedef mcl::G2 G2;
typedef mcl::GT GT;
typedef mcl::Fp2 Fp2;
typedef mcl::Fp6 Fp6;
typedef mcl::Fp12 Fp12;

typedef mcl::FpDbl FpDbl;
typedef mcl::Fp2Dbl Fp2Dbl;
typedef mcl::Fp6Dbl Fp6Dbl;

inline void Frobenius(Fp2& y, const Fp2& x)
{
	Fp2::Frobenius(y, x);
}
inline void Frobenius(Fp12& y, const Fp12& x)
{
	Fp12::Frobenius(y, x);
}

// mapTo
void mapToInit(const mpz_class& cofactor, const mpz_class &z, int curveType);

namespace local {

typedef mcl::FixedArray<int8_t, 128> SignVec;

size_t getPrecomputeQcoeffSize(const SignVec& sv)
{
	size_t idx = 2 + 1;
	if (sv[1]) idx++;
	for (size_t i = 2; i < sv.size(); i++) {
		idx++;
		if (sv[i]) idx++;
	}
	return idx;
}

template<class X, class C, size_t N>
X evalPoly(const X& x, const C (&c)[N])
{
	X ret = c[N - 1];
	for (size_t i = 1; i < N; i++) {
		ret *= x;
		ret += c[N - 1 - i];
	}
	return ret;
}

enum TwistBtype {
	tb_generic,
	tb_1m1i, // 1 - 1i
	tb_1m2i // 1 - 2i
};

/*
	l = (a, b, c) => (a, b * P.y, c * P.x)
*/
inline void updateLine(Fp6& l, const G1& P)
{
#if 1
	assert(!P.isZero());
#else
	if (P.isZero()) {
		l.b.clear();
		l.c.clear();
		return;
	}
#endif
	l.b.a *= P.y;
	l.b.b *= P.y;
	l.c.a *= P.x;
	l.c.b *= P.x;
}

#include "glv.hpp"

struct Param {
	CurveParam cp;
	mpz_class z;
	mpz_class abs_z;
	bool isNegative;
	bool isBLS12;
	mpz_class p;
	mpz_class r;
	// for G2 Frobenius
	Fp2 g2;
	Fp2 g3;
	/*
		Dtype twist
		(x', y') = phi(x, y) = (x/w^2, y/w^3)
		y^2 = x^3 + b
		=> (y'w^3)^2 = (x'w^2)^3 + b
		=> y'^2 = x'^3 + b / w^6 ; w^6 = xi
		=> y'^2 = x'^3 + twist_b;
	*/
	Fp2 twist_b;
	local::TwistBtype twist_b_type;

	// Loop parameter for the Miller loop part of opt. ate pairing.
	local::SignVec siTbl;
	size_t precomputedQcoeffSize;
	bool useNAF;
	local::SignVec zReplTbl;

	// for initG1only
	G1 basePoint;

	void init(bool *pb, const mcl::CurveParam& cp, fp::Mode mode)
	{
		this->cp = cp;
		isBLS12 = (cp.curveType == MCL_BLS12_381 || cp.curveType == MCL_BLS12_377 || cp.curveType == MCL_BLS12_461);
#ifdef MCL_STATIC_CODE
		if (!isBLS12) {
			*pb = false;
			return;
		}
#endif
		gmp::setStr(pb, z, cp.z);
		if (!*pb) return;
		isNegative = z < 0;
		if (isNegative) {
			abs_z = -z;
		} else {
			abs_z = z;
		}
		if (isBLS12) {
			mpz_class z2 = z * z;
			mpz_class z4 = z2 * z2;
			r = z4 - z2 + 1;
			p = z - 1;
			p = p * p * r / 3 + z;
		} else {
			const int pCoff[] = { 1, 6, 24, 36, 36 };
			const int rCoff[] = { 1, 6, 18, 36, 36 };
			p = local::evalPoly(z, pCoff);
			assert((p % 6) == 1);
			r = local::evalPoly(z, rCoff);
		}
		Fr::init(pb, r, mode);
		if (!*pb) return;
		Fp::init(pb, cp.xi_a, p, mode, cp.u);
		if (!*pb) return;
#ifdef MCL_DUMP_JIT
		*pb = true;
		return;
#endif
		Fp2::init(pb);
		if (!*pb) return;
		const Fp2 xi(cp.xi_a, 1);
		g2 = Fp2::get_gTbl()[0];
		g3 = Fp2::get_gTbl()[3];
		if (cp.isMtype) {
			Fp2::inv(g2, g2);
			Fp2::inv(g3, g3);
		}
		if (cp.isMtype) {
			twist_b = Fp2(cp.b) * xi;
		} else {
			if (cp.b == 2 && cp.xi_a == 1) {
				twist_b = Fp2(1, -1); // shortcut
			} else {
				twist_b = Fp2(cp.b) / xi;
			}
		}
		if (twist_b == Fp2(1, -1)) {
			twist_b_type = tb_1m1i;
		} else if (twist_b == Fp2(1, -2)) {
			twist_b_type = tb_1m2i;
		} else {
			twist_b_type = tb_generic;
		}
		G1::init(0, cp.b, mcl::ec::Jacobi);
		G2::init(0, twist_b, mcl::ec::Jacobi);

		const mpz_class largest_c = isBLS12 ? abs_z : gmp::abs(z * 6 + 2);
		useNAF = gmp::getNAF(siTbl, largest_c);
		precomputedQcoeffSize = local::getPrecomputeQcoeffSize(siTbl);
		gmp::getNAF(zReplTbl, gmp::abs(z));
		if (isBLS12) {
			mapToInit(0, z, cp.curveType);
		} else {
			mapToInit(2 * p - r, z, cp.curveType);
		}
		GLV1::init(z, isBLS12, cp.curveType);
		GLV2::init(z, isBLS12);
		basePoint.clear();
		G1::setOrder(r);
		G2::setOrder(r);
		*pb = true;
	}
	void initG1only(bool *pb, const mcl::EcParam& para)
	{
		mcl::initCurve<G1>(pb, para.curveType, &basePoint);
		mapToInit(0, 0, para.curveType);
	}
#ifndef CYBOZU_DONT_USE_EXCEPTION
	void init(const mcl::CurveParam& cp, fp::Mode mode)
	{
		bool b;
		init(&b, cp, mode);
		if (!b) throw cybozu::Exception("Param:init");
	}
#endif
};

} // mcl::bn::local

static local::Param s_nonConstParam;
static const local::Param& s_param = s_nonConstParam;

const CurveParam& getCurveParam()
{
	return s_param.cp;
}

int getCurveType()
{
	return getCurveParam().curveType;
}

namespace local {

bool powVecGLV(Fp12& z, const Fp12 *xVec, const void *yVec, size_t n)
{
	typedef GroupMtoA<Fp12> AG; // as additive group
	AG& _z = static_cast<AG&>(z);
	const AG *_xVec = static_cast<const AG*>(xVec);
	return mcl::ec::mulVecGLVT<GLV2, AG, Fr>(_z, _xVec, yVec, n);
}

/*
	Faster Squaring in the Cyclotomic Subgroup of Sixth Degree Extensions
	Robert Granger, Michael Scott
*/
inline void sqrFp4(Fp2& z0, Fp2& z1, const Fp2& x0, const Fp2& x1)
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

inline void fasterSqr(Fp12& y, const Fp12& x)
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
	Fp2::mul2(y0, y0);
	y0 += t0;
	Fp2::add(y1, t1, x1);
	Fp2::mul2(y1, y1);
	y1 += t1;
	Fp2 t2, t3;
	sqrFp4(t0, t1, x2, x3);
	sqrFp4(t2, t3, x4, x5);
	Fp2::sub(y4, t0, x4);
	Fp2::mul2(y4, y4);
	y4 += t0;
	Fp2::add(y5, t1, x5);
	Fp2::mul2(y5, y5);
	y5 += t1;
	Fp2::mul_xi(t0, t3);
	Fp2::add(y2, t0, x2);
	Fp2::mul2(y2, y2);
	y2 += t0;
	Fp2::sub(y3, t2, x3);
	Fp2::mul2(y3, y3);
	y3 += t2;
#endif
}

/*
	y = x^z if z > 0
	  = unitaryInv(x^(-z)) if z < 0
*/
inline void pow_z(Fp12& y, const Fp12& x)
{
#if 1
	if (mcl::bn::getCurveType() == MCL_BN254) {
		Compress::fixed_power(y, x);
	} else {
		Fp12 orgX = x;
		y = x;
		Fp12 conj;
		conj.a = x.a;
		Fp6::neg(conj.b, x.b);
		for (size_t i = 1; i < s_param.zReplTbl.size(); i++) {
			fasterSqr(y, y);
			if (s_param.zReplTbl[i] > 0) {
				y *= orgX;
			} else if (s_param.zReplTbl[i] < 0) {
				y *= conj;
			}
		}
	}
#else
	Fp12::pow(y, x, param.abs_z);
#endif
	if (s_param.isNegative) {
		Fp12::unitaryInv(y, y);
	}
}
inline void mul_twist_b(Fp2& y, const Fp2& x)
{
	switch (s_param.twist_b_type) {
	case local::tb_1m1i:
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
	case local::tb_1m2i:
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
	case local::tb_generic:
		Fp2::mul(y, x, s_param.twist_b);
		return;
	}
}

void dblLineWithoutP(Fp6& l, G2& Q)
{
	Fp2 t0, t1, t2, t3, t4, t5;
	Fp2Dbl T0, T1;
	Fp2::sqr(t0, Q.z);
	Fp2::mul(t4, Q.x, Q.y);
	Fp2::sqr(t1, Q.y);
	Fp2::mul2(t3, t0);
	Fp2::divBy2(t4, t4);
	Fp2::add(t5, t0, t1);
	t0 += t3;
	mul_twist_b(t2, t0);
	Fp2::sqr(t0, Q.x);
	Fp2::mul2(t3, t2);
	t3 += t2;
	Fp2::sub(Q.x, t1, t3);
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
	Fp2::sub(l.a, t2, t1);
	l.c = t0;
	l.b = t3;
}

void addLineWithoutP(Fp6& l, G2& R, const G2& Q)
{
	Fp2 t1, t2, t3, t4;
	Fp2Dbl T1, T2;
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
	Fp2Dbl::mulPre(T1, t2, R.x);
	Fp2Dbl::mulPre(T2, t3, R.y);
	Fp2Dbl::sub(T2, T1, T2);
	Fp2Dbl::mod(R.y, T2);
	Fp2::mul(R.x, t1, t4);
	Fp2::mul(R.z, t3, R.z);
	Fp2::neg(l.c, t2);
	Fp2Dbl::mulPre(T1, t2, Q.x);
	Fp2Dbl::mulPre(T2, t1, Q.y);
	Fp2Dbl::sub(T1, T1, T2);
	l.b = t1;
	Fp2Dbl::mod(l.a, T1);
}
inline void dblLine(Fp6& l, G2& Q, const G1& P)
{
	dblLineWithoutP(l, Q);
	local::updateLine(l, P);
}
inline void addLine(Fp6& l, G2& R, const G2& Q, const G1& P)
{
	addLineWithoutP(l, R, Q);
	local::updateLine(l, P);
}
inline void mulFp6cb_by_G1xy(Fp6& y, const Fp6& x, const G1& P)
{
	y.a = x.a;
#if 1
	assert(!P.isZero());
#else
	if (P.isZero()) {
		y.c.clear();
		y.b.clear();
		return;
	}
#endif
	Fp2::mulFp(y.c, x.c, P.x);
	Fp2::mulFp(y.b, x.b, P.y);
}

/*
	x = a + bv + cv^2
	y = (y0, y4, y2) -> (y0, 0, y2, 0, y4, 0)
	z = xy = (a + bv + cv^2)(d + ev)
	= (ad + ce xi) + ((a + b)(d + e) - ad - be)v + (be + cd)v^2
*/
inline void Fp6mul_01(Fp6& z, const Fp6& x, const Fp2& d, const Fp2& e)
{
	const Fp2& a = x.a;
	const Fp2& b = x.b;
	const Fp2& c = x.c;
	Fp2 t0, t1;
	Fp2Dbl AD, CE, BE, CD, T;
	Fp2Dbl::mulPre(AD, a, d);
	Fp2Dbl::mulPre(CE, c, e);
	Fp2Dbl::mulPre(BE, b, e);
	Fp2Dbl::mulPre(CD, c, d);
	Fp2::add(t0, a, b);
	Fp2::add(t1, d, e);
	Fp2Dbl::mulPre(T, t0, t1);
	T -= AD;
	T -= BE;
	Fp2Dbl::mod(z.b, T);
	Fp2Dbl::mul_xi(CE, CE);
	AD += CE;
	Fp2Dbl::mod(z.a, AD);
	BE += CD;
	Fp2Dbl::mod(z.c, BE);
}
/*
	input
	z = (z0 + z1v + z2v^2) + (z3 + z4v + z5v^2)w = Z0 + Z1w
	                  0        3  4
	x = (a, b, c) -> (b, 0, 0, c, a, 0) = X0 + X1w
	X0 = b = (b, 0, 0)
	X1 = c + av = (c, a, 0)
	w^2 = v, v^3 = xi
	output
	z <- zx = (Z0X0 + Z1X1v) + ((Z0 + Z1)(X0 + X1) - Z0X0 - Z1X1)w
	Z0X0 = Z0 b
	Z1X1 = Z1 (c, a, 0)
	(Z0 + Z1)(X0 + X1) = (Z0 + Z1) (b + c, a, 0)
*/
inline void mul_403(Fp12& z, const Fp6& x)
{
	const Fp2& a = x.a;
	const Fp2& b = x.b;
	const Fp2& c = x.c;
	Fp6& z0 = z.a;
	Fp6& z1 = z.b;
	Fp6 z0x0, z1x1, t0;
	Fp2 t1;
	Fp2::add(t1, x.b, c);
	Fp6::add(t0, z0, z1);
	Fp2::mul(z0x0.a, z0.a, b);
	Fp2::mul(z0x0.b, z0.b, b);
	Fp2::mul(z0x0.c, z0.c, b);
	Fp6mul_01(z1x1, z1, c, a);
	Fp6mul_01(t0, t0, t1, a);
	Fp6::sub(z.b, t0, z0x0);
	z.b -= z1x1;
	// a + bv + cv^2 = cxi + av + bv^2
	Fp2::mul_xi(z1x1.c, z1x1.c);
	Fp2::add(z.a.a, z0x0.a, z1x1.c);
	Fp2::add(z.a.b, z0x0.b, z1x1.a);
	Fp2::add(z.a.c, z0x0.c, z1x1.b);
}
/*
	input
	z = (z0 + z1v + z2v^2) + (z3 + z4v + z5v^2)w = Z0 + Z1w
	                  0  1        4
	x = (a, b, c) -> (a, c, 0, 0, b, 0) = X0 + X1w
	X0 = (a, c, 0)
	X1 = (0, b, 0)
	w^2 = v, v^3 = xi
	output
	z <- zx = (Z0X0 + Z1X1v) + ((Z0 + Z1)(X0 + X1) - Z0X0 - Z1X1)w
	Z0X0 = Z0 (a, c, 0)
	Z1X1 = Z1 (0, b, 0) = Z1 bv
	(Z0 + Z1)(X0 + X1) = (Z0 + Z1) (a, b + c, 0)

	(a + bv + cv^2)v = c xi + av + bv^2
*/
inline void mul_041(Fp12& z, const Fp6& x)
{
	const Fp2& a = x.a;
	const Fp2& b = x.b;
	const Fp2& c = x.c;
	Fp6& z0 = z.a;
	Fp6& z1 = z.b;
	Fp6 z0x0, z1x1, t0;
	Fp2 t1;
	Fp2::mul(z1x1.a, z1.c, b);
	Fp2::mul_xi(z1x1.a, z1x1.a);
	Fp2::mul(z1x1.b, z1.a, b);
	Fp2::mul(z1x1.c, z1.b, b);
	Fp2::add(t1, x.b, c);
	Fp6::add(t0, z0, z1);
	Fp6mul_01(z0x0, z0, a, c);
	Fp6mul_01(t0, t0, a, t1);
	Fp6::sub(z.b, t0, z0x0);
	z.b -= z1x1;
	// a + bv + cv^2 = cxi + av + bv^2
	Fp2::mul_xi(z1x1.c, z1x1.c);
	Fp2::add(z.a.a, z0x0.a, z1x1.c);
	Fp2::add(z.a.b, z0x0.b, z1x1.a);
	Fp2::add(z.a.c, z0x0.c, z1x1.b);
}

void mulSparse(Fp12& z, const Fp6& x)
{
	if (getCurveParam().isMtype) {
		mul_041(z, x);
	} else {
		mul_403(z, x);
	}
}
inline void convertFp6toFp12(Fp12& y, const Fp6& x)
{
	if (getCurveParam().isMtype) {
		// (a, b, c) -> (a, c, 0, 0, b, 0)
		y.a.a = x.a;
		y.b.b = x.b;
		y.a.b = x.c;
		y.a.c.clear();
		y.b.a.clear();
		y.b.c.clear();
	} else {
		// (a, b, c) -> (b, 0, 0, c, a, 0)
		y.b.b = x.a;
		y.a.a = x.b;
		y.b.a = x.c;
		y.a.b.clear();
		y.a.c.clear();
		y.b.c.clear();
	}
}
inline void mulSparse2(Fp12& z, const Fp6& x, const Fp6& y)
{
	convertFp6toFp12(z, x);
	mulSparse(z, y);
}
inline void mapToCyclotomic(Fp12& y, const Fp12& x)
{
	Fp12 z;
	Fp12::Frobenius2(z, x); // z = x^(p^2)
	z *= x; // x^(p^2 + 1)
	Fp12::inv(y, z);
	Fp6::neg(z.b, z.b); // z^(p^6) = conjugate of z
	y *= z;
}
/*
	Implementing Pairings at the 192-bit Security Level
	D.F.Aranha, L.F.Castaneda, E.Knapp, A.Menezes, F.R.Henriquez
	Section 4
*/
inline void expHardPartBLS12(Fp12& y, const Fp12& x)
{
	/*
		Efficient Final Exponentiation via Cyclotomic Structure
		for Pairings over Families of Elliptic Curves
		https://eprint.iacr.org/2020/875.pdf p.13
		(z-1)^2 (z+p)(z^2+p^2-1)+3
	*/
	Fp12 a0, a1, a2;
	pow_z(a0, x); // z
	Fp12::unitaryInv(a1, x); // -1
	a0 *= a1; // z-1
	pow_z(a1, a0); // (z-1)^z
	Fp12::unitaryInv(a0, a0); // -(z-1)
	a0 *= a1; // (z-1)^2
	pow_z(a1, a0); // z
	Fp12::Frobenius(a0, a0); // p
	a0 *=a1; // (z-1)^2 (z+p)
	pow_z(a1, a0); // z
	pow_z(a1, a1); // z^2
	Fp12::Frobenius2(a2, a0); // p^2
	Fp12::unitaryInv(a0, a0); // -1
	a0 *= a1;
	a0 *= a2; // z^2+p^2-1
	fasterSqr(a1, x);
	a1 *= x; // x^3
	Fp12::mul(y, a0, a1);
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
inline void expHardPartBN(Fp12& y, const Fp12& x)
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
/*
	assume P is normalized
	if P == 0:
	  adjP = (0, 0, 0)
	else:
	  adjP = (P.x * 3, -P.y, 1)
	remark : returned value is NOT on a curve
*/
inline void makeAdjP(G1& adjP, const G1& P)
{
#if 1
	assert(!P.isZero());
#else
	if (P.isZero()) {
		adjP.x.clear();
		adjP.y.clear();
		adjP.z.clear();
		return;
	}
#endif
	Fp x2;
	Fp::mul2(x2, P.x);
	Fp::add(adjP.x, x2, P.x);
	Fp::neg(adjP.y, P.y);
	adjP.z = P.z;
}

} // mcl::bn::local

void finalExp(Fp12& y, const Fp12& x)
{
	using namespace local;
	if (x.isZero()) {
		y.clear();
		return;
	}
	mapToCyclotomic(y, x);
	if (s_param.isBLS12) {
		expHardPartBLS12(y, y);
	} else {
		expHardPartBN(y, y);
	}
}

void millerLoop(Fp12& f, const G1& P_, const G2& Q_)
{
	using namespace local;
	if (P_.isZero() || Q_.isZero()) {
		f = 1;
		return;
	}
	G1 P;
	G2 Q;
	G1::normalize(P, P_);
	G2::normalize(Q, Q_);
	G2 T = Q;
	G2 negQ;
	if (s_param.useNAF) {
		G2::neg(negQ, Q);
	}
	Fp6 d, e;
	G1 adjP;
	makeAdjP(adjP, P);
	dblLine(e, T, adjP);
	if (s_param.siTbl[1]) {
		if (s_param.siTbl[1] > 0) {
			addLine(d, T, Q, P);
		} else {
			addLine(d, T, negQ, P);
		}
		mulSparse2(f, d, e);
	} else {
		convertFp6toFp12(f, e);
	}
	for (size_t i = 2; i < s_param.siTbl.size(); i++) {
		dblLine(e, T, adjP);
		Fp12::sqr(f, f);
		mulSparse(f, e);
		if (s_param.siTbl[i]) {
			if (s_param.siTbl[i] > 0) {
				addLine(e, T, Q, P);
			} else {
				addLine(e, T, negQ, P);
			}
			mulSparse(f, e);
		}
	}
	if (s_param.z < 0) {
		Fp6::neg(f.b, f.b);
	}
	if (s_param.isBLS12) return;
	if (s_param.z < 0) {
		G2::neg(T, T);
	}
	Frobenius(Q, Q);
	addLine(d, T, Q, P);
	Frobenius(Q, Q);
	G2::neg(Q, Q);
	addLine(e, T, Q, P);
	Fp12 ft;
	mulSparse2(ft, d, e);
	f *= ft;
}

size_t getPrecomputedQcoeffSize()
{
	return s_param.precomputedQcoeffSize;
}

void precomputeG2(Fp6 *Qcoeff, const G2& Q_)
{
	using namespace local;
	size_t idx = 0;
	G2 Q(Q_);
	Q.normalize();
	if (Q.isZero()) {
		for (size_t i = 0; i < getPrecomputedQcoeffSize(); i++) {
			Qcoeff[i] = 1;
		}
		return;
	}
	G2 T = Q;
	G2 negQ;
	if (s_param.useNAF) {
		G2::neg(negQ, Q);
	}
	dblLineWithoutP(Qcoeff[idx++], T);
	if (s_param.siTbl[1]) {
		addLineWithoutP(Qcoeff[idx++], T, Q);
	}
	for (size_t i = 2; i < s_param.siTbl.size(); i++) {
		dblLineWithoutP(Qcoeff[idx++], T);
		if (s_param.siTbl[i]) {
			if (s_param.siTbl[i] > 0) {
				addLineWithoutP(Qcoeff[idx++], T, Q);
			} else {
				addLineWithoutP(Qcoeff[idx++], T, negQ);
			}
		}
	}
	if (s_param.z < 0) {
		G2::neg(T, T);
	}
	if (s_param.isBLS12) return;
	Frobenius(Q, Q);
	addLineWithoutP(Qcoeff[idx++], T, Q);
	Frobenius(Q, Q);
	G2::neg(Q, Q);
	addLineWithoutP(Qcoeff[idx++], T, Q);
	assert(idx == getPrecomputedQcoeffSize());
}
/*
	millerLoop(e, P, Q) is same as the following
	std::vector<Fp6> Qcoeff;
	precomputeG2(Qcoeff, Q);
	precomputedMillerLoop(e, P, Qcoeff);
*/
#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputeG2(std::vector<Fp6>& Qcoeff, const G2& Q)
{
	Qcoeff.resize(getPrecomputedQcoeffSize());
	precomputeG2(Qcoeff.data(), Q);
}
#endif

template<class Array>
void precomputeG2(bool *pb, Array& Qcoeff, const G2& Q)
{
	*pb = Qcoeff.resize(getPrecomputedQcoeffSize());
	if (!*pb) return;
	precomputeG2(Qcoeff.data(), Q);
}

void precomputedMillerLoop(Fp12& f, const G1& P_, const Fp6* Qcoeff)
{
	using namespace local;
	if (P_.isZero()) {
		f = 1;
		return;
	}
	G1 P;
	G1::normalize(P, P_);
	G1 adjP;
	makeAdjP(adjP, P);
	size_t idx = 0;
	Fp6 d, e;
	mulFp6cb_by_G1xy(e, Qcoeff[idx], adjP);
	idx++;

	if (s_param.siTbl[1]) {
		mulFp6cb_by_G1xy(d, Qcoeff[idx], P);
		idx++;
		mulSparse2(f, d, e);
	} else {
		convertFp6toFp12(f, e);
	}
	for (size_t i = 2; i < s_param.siTbl.size(); i++) {
		mulFp6cb_by_G1xy(e, Qcoeff[idx], adjP);
		idx++;
		Fp12::sqr(f, f);
		mulSparse(f, e);
		if (s_param.siTbl[i]) {
			mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
			idx++;
			mulSparse(f, e);
		}
	}
	if (s_param.z < 0) {
		Fp6::neg(f.b, f.b);
	}
	if (s_param.isBLS12) return;
	mulFp6cb_by_G1xy(d, Qcoeff[idx], P);
	idx++;
	mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
	idx++;
	Fp12 ft;
	mulSparse2(ft, d, e);
	f *= ft;
}

#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputedMillerLoop(Fp12& f, const G1& P, const std::vector<Fp6>& Qcoeff)
{
	precomputedMillerLoop(f, P, Qcoeff.data());
}
#endif

void precomputedMillerLoop2mixed(Fp12& f, const G1& P1_, const G2& Q1_, const G1& P2_, const Fp6* Q2coeff)
{
	using namespace local;
	G1 P1(P1_), P2(P2_);
	G2 Q1(Q1_);
	P1.normalize();
	P2.normalize();
	Q1.normalize();
	if (Q1.isZero()) {
		precomputedMillerLoop(f, P2_, Q2coeff);
		return;
	}
	G2 T = Q1;
	G2 negQ1;
	if (s_param.useNAF) {
		G2::neg(negQ1, Q1);
	}
	G1 adjP1, adjP2;
	makeAdjP(adjP1, P1);
	makeAdjP(adjP2, P2);
	size_t idx = 0;
	Fp6 d1, d2, e1, e2;
	dblLine(d1, T, adjP1);
	mulFp6cb_by_G1xy(d2, Q2coeff[idx], adjP2);
	idx++;

	Fp12 f1, f2;

	if (s_param.siTbl[1]) {
		addLine(e1, T, Q1, P1);
		mulSparse2(f1, d1, e1);
		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		idx++;
		mulSparse2(f2, d2, e2);
		Fp12::mul(f, f1, f2);
	} else {
		mulSparse2(f, d1, d2);
	}
	for (size_t i = 2; i < s_param.siTbl.size(); i++) {
		dblLine(e1, T, adjP1);
		mulFp6cb_by_G1xy(e2, Q2coeff[idx], adjP2);
		idx++;
		Fp12::sqr(f, f);
		mulSparse2(f1, e1, e2);
		f *= f1;
		if (s_param.siTbl[i]) {
			if (s_param.siTbl[i] > 0) {
				addLine(e1, T, Q1, P1);
			} else {
				addLine(e1, T, negQ1, P1);
			}
			mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
			idx++;
			mulSparse2(f1, e1, e2);
			f *= f1;
		}
	}
	if (s_param.z < 0) {
		G2::neg(T, T);
		Fp6::neg(f.b, f.b);
	}
	if (s_param.isBLS12) return;
	Frobenius(Q1, Q1);
	addLine(d1, T, Q1, P1);
	mulFp6cb_by_G1xy(d2, Q2coeff[idx], P2);
	idx++;
	Frobenius(Q1, Q1);
	G2::neg(Q1, Q1);
	addLine(e1, T, Q1, P1);
	mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
	idx++;
	mulSparse2(f1, d1, e1);
	mulSparse2(f2, d2, e2);
	f *= f1;
	f *= f2;
}

void precomputedMillerLoop2(Fp12& f, const G1& P1_, const Fp6* Q1coeff, const G1& P2_, const Fp6* Q2coeff)
{
	using namespace local;
	G1 P1(P1_), P2(P2_);
	P1.normalize();
	P2.normalize();
	G1 adjP1, adjP2;
	makeAdjP(adjP1, P1);
	makeAdjP(adjP2, P2);
	size_t idx = 0;
	Fp6 d1, d2, e1, e2;
	mulFp6cb_by_G1xy(d1, Q1coeff[idx], adjP1);
	mulFp6cb_by_G1xy(d2, Q2coeff[idx], adjP2);
	idx++;

	Fp12 f1, f2;
	if (s_param.siTbl[1]) {
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
		mulSparse2(f1, d1, e1);

		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		mulSparse2(f2, d2, e2);
		Fp12::mul(f, f1, f2);
		idx++;
	} else {
		mulSparse2(f, d1, d2);
	}
	for (size_t i = 2; i < s_param.siTbl.size(); i++) {
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], adjP1);
		mulFp6cb_by_G1xy(e2, Q2coeff[idx], adjP2);
		idx++;
		Fp12::sqr(f, f);
		mulSparse2(f1, e1, e2);
		f *= f1;
		if (s_param.siTbl[i]) {
			mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
			mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
			idx++;
			mulSparse2(f1, e1, e2);
			f *= f1;
		}
	}
	if (s_param.z < 0) {
		Fp6::neg(f.b, f.b);
	}
	if (s_param.isBLS12) return;
	mulFp6cb_by_G1xy(d1, Q1coeff[idx], P1);
	mulFp6cb_by_G1xy(d2, Q2coeff[idx], P2);
	idx++;
	mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
	mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
	idx++;
	mulSparse2(f1, d1, e1);
	mulSparse2(f2, d2, e2);
	f *= f1;
	f *= f2;
}
#ifndef CYBOZU_DONT_USE_EXCEPTION
void precomputedMillerLoop2(Fp12& f, const G1& P1, const std::vector<Fp6>& Q1coeff, const G1& P2, const std::vector<Fp6>& Q2coeff)
{
	precomputedMillerLoop2(f, P1, Q1coeff.data(), P2, Q2coeff.data());
}
void precomputedMillerLoop2mixed(Fp12& f, const G1& P1, const G2& Q1, const G1& P2, const std::vector<Fp6>& Q2coeff)
{
	precomputedMillerLoop2mixed(f, P1, Q1, P2, Q2coeff.data());
}
#endif

/*
	e = prod_i ML(Pvec[i], Qvec[i])
	if initF:
	  _f = e
	else:
	  _f *= e
*/
template<size_t N>
inline void millerLoopVecN(Fp12& _f, const G1* Pvec, const G2* Qvec, size_t n, bool initF)
{
	using namespace local;
	assert(n <= N);
	G1 P[N];
	G2 Q[N];
	// remove zero elements
	{
		size_t realN = 0;
		for (size_t i = 0; i < n; i++) {
			if (!Pvec[i].isZero() && !Qvec[i].isZero()) {
				G1::normalize(P[realN], Pvec[i]);
				G2::normalize(Q[realN], Qvec[i]);
				realN++;
			}
		}
		if (realN <= 0) {
			if (initF) _f = 1;
			return;
		}
		n = realN; // update n
	}
	Fp12 ff;
	Fp12& f(initF ? _f : ff);
	// all P[] and Q[] are not zero
	G2 T[N], negQ[N];
	G1 adjP[N];
	Fp6 d, e;
	for (size_t i = 0; i < n; i++) {
		T[i] = Q[i];
		if (s_param.useNAF) {
			G2::neg(negQ[i], Q[i]);
		}
		makeAdjP(adjP[i], P[i]);
		dblLine(d, T[i], adjP[i]);
		if (s_param.siTbl[1]) {
			addLine(e, T[i], Q[i], P[i]);
			if (i == 0) {
				mulSparse2(f, d, e);
			} else {
				Fp12 ft;
				mulSparse2(ft, d, e);
				f *= ft;
			}
		} else {
			if (i == 0) {
				convertFp6toFp12(f, d);
			} else {
				mulSparse(f, d);
			}
		}
	}
	for (size_t j = 2; j < s_param.siTbl.size(); j++) {
		Fp12::sqr(f, f);
		for (size_t i = 0; i < n; i++) {
			dblLine(e, T[i], adjP[i]);
			mulSparse(f, e);
			int v = s_param.siTbl[j];
			if (v) {
				if (v > 0) {
					addLine(e, T[i], Q[i], P[i]);
				} else {
					addLine(e, T[i], negQ[i], P[i]);
				}
				mulSparse(f, e);
			}
		}
	}
	if (s_param.z < 0) {
		Fp6::neg(f.b, f.b);
	}
	if (s_param.isBLS12) goto EXIT;
	for (size_t i = 0; i < n; i++) {
		if (s_param.z < 0) {
			G2::neg(T[i], T[i]);
		}
		Frobenius(Q[i], Q[i]);
		addLine(d, T[i], Q[i], P[i]);
		Frobenius(Q[i], Q[i]);
		G2::neg(Q[i], Q[i]);
		addLine(e, T[i], Q[i], P[i]);
		Fp12 ft;
		mulSparse2(ft, d, e);
		f *= ft;
	}
EXIT:
	if (!initF) _f *= f;
}

void millerLoopVec(Fp12& f, const G1* Pvec, const G2* Qvec, size_t n, bool initF = true)
{
	const size_t N = 16;
	size_t remain = fp::min_(N, n);
	millerLoopVecN<N>(f, Pvec, Qvec, remain, initF);
	for (size_t i = remain; i < n; i += N) {
		remain = fp::min_(n - i, N);
		millerLoopVecN<N>(f, Pvec + i, Qvec + i, remain, false);
	}
}

void millerLoopVecMT(Fp12& f, const G1* Pvec, const G2* Qvec, size_t n, size_t cpuN)
{
	if (n == 0) {
		f = 1;
		return;
	}
#ifdef MCL_USE_OMP
	const size_t minN = 16;
	if (cpuN == 0) {
		cpuN = omp_get_num_procs();
		if (n < minN * cpuN) {
			cpuN = (n + minN - 1) / minN;
		}
	}
	if (cpuN <= 1 || n <= cpuN) {
		millerLoopVec(f, Pvec, Qvec, n);
		return;
	}
	Fp12 *fs = (Fp12*)CYBOZU_ALLOCA(sizeof(Fp12) * cpuN);
	size_t q = n / cpuN;
	size_t r = n % cpuN;
	#pragma omp parallel for
	for (size_t i = 0; i < cpuN; i++) {
		size_t adj = q * i + fp::min_(i, r);
		millerLoopVec(fs[i], Pvec + adj, Qvec + adj, q + (i < r));
	}
	f = 1;
//	#pragma omp declare reduction(red:Fp12:omp_out *= omp_in) initializer(omp_priv = omp_orig)
//	#pragma omp parallel for reduction(red:f)
	for (size_t i = 0; i < cpuN; i++) {
		f *= fs[i];
	}
#else
	(void)cpuN;
	millerLoopVec(f, Pvec, Qvec, n);
#endif
}

bool setMapToMode(int mode);
int getMapToMode();
void mapToG1(bool *pb, G1& P, const Fp& x);
void mapToG2(bool *pb, G2& P, const Fp2& x);

#ifndef CYBOZU_DONT_USE_EXCEPTION
void mapToG1(G1& P, const Fp& x);
void mapToG2(G2& P, const Fp2& x);
#endif

void hashAndMapToG1(G1& P, const void *buf, size_t bufSize);
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize);
void hashAndMapToG1(G1& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize);
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize);
// set the default dst for G1
// return 0 if success else -1
bool setDstG1(const char *dst, size_t dstSize);
// set the default dst for G2
// return 0 if success else -1
bool setDstG2(const char *dst, size_t dstSize);

#ifndef CYBOZU_DONT_USE_STRING
void hashAndMapToG1(G1& P, const std::string& str);
void hashAndMapToG2(G2& P, const std::string& str);
#endif

void verifyOrderG1(bool doVerify)
{
	if (s_param.isBLS12) {
		G1::setOrder(doVerify ? Fr::getOp().mp : 0);
	}
}
void verifyOrderG2(bool doVerify)
{
	G2::setOrder(doVerify ? Fr::getOp().mp : 0);
}

bool isValidOrderBLS12(const G2& P)
{
	G2 T2, T3;
	Frobenius2(T2, P);
	Frobenius(T3, T2);
	G2::mulGeneric(T3, T3, s_param.z);
	T2 -= T3;
	return T2 == P;
}
bool isValidOrderBLS12(const G1& P);

// backward compatibility
using mcl::CurveParam;
static const CurveParam& CurveFp254BNb = BN254;
static const CurveParam& CurveFp382_1 = BN381_1;
static const CurveParam& CurveFp382_2 = BN381_2;
static const CurveParam& CurveFp462 = BN462;
static const CurveParam& CurveSNARK1 = BN_SNARK1;

void Frobenius(G2& D, const G2& S)
{
	Fp2::Frobenius(D.x, S.x);
	Fp2::Frobenius(D.y, S.y);
	Fp2::Frobenius(D.z, S.z);
	D.x *= s_param.g2;
	D.y *= s_param.g3;
}
void Frobenius2(G2& D, const G2& S)
{
	Frobenius(D, S);
	Frobenius(D, D);
}
void Frobenius3(G2& D, const G2& S)
{
	Frobenius(D, S);
	Frobenius(D, D);
	Frobenius(D, D);
}

using namespace mcl::bn; // backward compatibility

void init(bool *pb, const mcl::CurveParam& cp, fp::Mode mode)
{
	s_nonConstParam.init(pb, cp, mode);
	if (!*pb) return;
	G1::setMulVecGLV(mcl::ec::mulVecGLVT<local::GLV1, G1, Fr>);
	G2::setMulVecGLV(mcl::ec::mulVecGLVT<local::GLV2, G2, Fr>);
#if MCL_MSM == 1
	mcl::msm::Func func;
	func.fp = &Fp::getOp();
	func.fr = &Fr::getOp();
	func.invVecFp = mcl::invVec<mcl::bn::Fp>;
	func.normalizeVecG1 = mcl::msm::normalizeVecG1Func(mcl::ec::normalizeVec<mcl::bn::G1>);
#if (defined(__GNUC__) || defined(__clang__))  && !defined(__EMSCRIPTEN__)
	// avoid gcc wrong detection
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wcast-function-type"
#endif
	func.addG1 = mcl::msm::addG1Func((void (*)(G1&, const G1&, const G1&))G1::add);
	func.dblG1 = mcl::msm::dblG1Func((void (*)(G1&, const G1&))G1::dbl);
	func.mulG1 = mcl::msm::mulG1Func((void (*)(G1&, const G1&, const Fr&, bool))G1::mul);
	func.clearG1 = mcl::msm::clearG1Func((void (*)(G1&))G1::clear);
#if (defined(__GNUC__) || defined(__clang__)) && !defined(__EMSCRIPTEN__)
	#pragma GCC diagnostic pop
#endif
	if (sizeof(Unit) == 8 && sizeof(Fp) == sizeof(mcl::msm::FpA) && sizeof(Fr) == sizeof(mcl::msm::FrA)) {
		if (mcl::msm::initMsm(cp, &func)) {
			G1::setMulVecOpti(mcl::msm::mulVecAVX512);
			G1::setMulEachOpti(mcl::msm::mulEachAVX512);
		}
	}
#endif
	Fp12::setPowVecGLV(local::powVecGLV);
	G1::setCompressedExpression();
	G2::setCompressedExpression();
	verifyOrderG1(false);
	verifyOrderG2(false);
	if (s_param.isBLS12) {
		G1::setVerifyOrderFunc(isValidOrderBLS12);
		G2::setVerifyOrderFunc(isValidOrderBLS12);
	}
	*pb = true;
}

#ifndef CYBOZU_DONT_USE_EXCEPTION
void init(const mcl::CurveParam& cp, fp::Mode mode)
{
	bool b;
	init(&b, cp, mode);
	if (!b) throw cybozu::Exception("BN:init");
}
#endif

void initPairing(bool *pb, const mcl::CurveParam& cp, fp::Mode mode)
{
	init(pb, cp, mode);
}

#ifndef CYBOZU_DONT_USE_EXCEPTION
void initPairing(const mcl::CurveParam& cp, fp::Mode mode)
{
	bool b;
	init(&b, cp, mode);
	if (!b) throw cybozu::Exception("bn:initPairing");
}
#endif

void initG1only(bool *pb, const mcl::EcParam& para)
{
	G1::setMulVecGLV(0);
	G2::setMulVecGLV(0);
	Fp12::setPowVecGLV(0);
	s_nonConstParam.initG1only(pb, para);
	if (!*pb) return;
	G1::setCompressedExpression();
	G2::setCompressedExpression();
}

const G1& getG1basePoint()
{
	return s_param.basePoint;
}

bool isValidGT(const GT& x)
{
	GT y;
	GT::powGeneric(y, x, Fr::getOp().mp);
	return y.isOne();
}

} } // mcl::bn

