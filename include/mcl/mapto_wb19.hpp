#pragma once
/**
	@file
	@brief map to G2 on BLS12-381 (must be included from mcl/bn.hpp)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
	ref. https://eprint.iacr.org/2019/403 , https://github.com/algorand/bls_sigs_ref
*/
namespace mcl {

// ctr = 0 or 1 or 2
template<class Fp2>
inline void hashToFp2(Fp2& out, const void *msg, size_t msgSize, uint8_t ctr, const void *dst, size_t dstSize)
{
	const bool addZeroByte = true; // append zero byte to msg
	assert(ctr <= 2);
	const size_t degree = 2;
	uint8_t msg_prime[32];
	// add '\0' at the end of dst
	// see. 5.3. Implementation of https://datatracker.ietf.org/doc/draft-irtf-cfrg-hash-to-curve
	if (addZeroByte) {
		fp::hkdf_extract_addZeroByte(msg_prime, reinterpret_cast<const uint8_t*>(dst), dstSize, reinterpret_cast<const uint8_t*>(msg), msgSize);
	} else {
		fp::hkdf_extract(msg_prime, reinterpret_cast<const uint8_t*>(dst), dstSize, reinterpret_cast<const uint8_t*>(msg), msgSize);
	}
	char info_pfx[] = "H2C000";
	info_pfx[3] = ctr;
	for (size_t i = 0; i < degree; i++) {
		info_pfx[4] = char(i + 1);
		uint8_t t[64];
		fp::hkdf_expand(t, msg_prime, info_pfx);
		fp::local::byteSwap(t, 64);
		bool b;
		out.getFp0()[i].setArrayMod(&b, t, 64);
		assert(b); (void)b;
	}
}

template<class Fp, class Fp2, class G2>
struct MapToG2_WB19 {
	Fp2 xi;
	Fp2 Ell2p_a;
	Fp2 Ell2p_b;
	Fp half;
	mpz_class sqrtConst; // (p^2 - 9) / 16
	Fp2 root4[4];
	Fp2 etas[4];
	Fp2 xnum[4];
	Fp2 xden[3];
	Fp2 ynum[4];
	Fp2 yden[4];
	int draftVersion_;
	void setDraftVersion(int version)
	{
		draftVersion_ = version;
	}
	struct Point {
		Fp2 x, y, z;
		bool isZero() const
		{
			return z.isZero();
		}
	};
	// should be merged into ec.hpp
	template<class G>
	void neg(G& Q, const G& P) const
	{
		Q.x = P.x;
		Fp2::neg(Q.y, P.y);
		Q.z = P.z;
	}
	// Jacobi
	template<class G>
	void add(G& R, const G& P, const G& Q) const
	{
		if (P.isZero()) {
			R = Q;
			return;
		}
		if (Q.isZero()) {
			R = Q;
			return;
		}
		Fp2 Z1Z1, Z2Z2, U1, U2, S1, S2;
		Fp2::sqr(Z1Z1, P.z);
		Fp2::sqr(Z2Z2, Q.z);
		Fp2::mul(U1, P.x, Z2Z2);
		Fp2::mul(U2, Q.x, Z1Z1);
		Fp2::mul(S1, P.y, Q.z);
		S1 *= Z2Z2;
		Fp2::mul(S2, Q.y, P.z);
		S2 *= Z1Z1;
		if (U1 == U2 && S1 == S2) {
			dbl(R, P);
			return;
		}
		Fp2 H, I, J, rr, V;
		Fp2::sub(H, U2, U1);
		Fp2::add(I, H, H);
		Fp2::sqr(I, I);
		Fp2::mul(J, H, I);
		Fp2::sub(rr, S2, S1);
		rr += rr;
		Fp2::mul(V, U1, I);
		Fp2::mul(R.z, P.z, Q.z);
		R.z *= H;
		if (R.z.isZero()) {
			R.x.clear();
			R.y.clear();
			return;
		}
		R.z += R.z;
		Fp2::sqr(R.x, rr);
		R.x -= J;
		R.x -= V;
		R.x -= V;
		Fp2::sub(R.y, V, R.x);
		R.y *= rr;
		S1 *= J;
		R.y -= S1;
		R.y -= S1;
	}
	template<class G>
	void dbl(G& Q, const G& P) const
	{
		Fp2 A, B, C, D, E, F;
		Fp2::sqr(A, P.x);
		Fp2::sqr(B, P.y);
		Fp2::sqr(C, B);
		Fp2::add(D, P.x, B);
		Fp2::sqr(D, D);
		D -= A;
		D -= C;
		D += D;
		Fp2::add(E, A, A);
		E += A;
		Fp2::sqr(F, E);
		Fp2::sub(Q.x, F, D);
		Q.x -= D;
		Fp2::mul(Q.z, P.y, P.z);
		if (Q.z.isZero()) {
			Q.x.clear();
			Q.y.clear();
			return;
		}
		Q.z += Q.z;
		Fp2::sub(Q.y, D, Q.x);
		Q.y *= E;
		C += C;
		C += C;
		C += C;
		Q.y -= C;
	}
	// P is on y^2 = x^3 + Ell2p_a x + Ell2p_b
	bool isValidPoint(const Point& P) const
	{
		Fp2 y2, x2, z2, z4, t;
		Fp2::sqr(x2, P.x);
		Fp2::sqr(y2, P.y);
		Fp2::sqr(z2, P.z);
		Fp2::sqr(z4, z2);
		Fp2::mul(t, z4, Ell2p_a);
		t += x2;
		t *= P.x;
		z4 *= z2;
		z4 *= Ell2p_b;
		t += z4;
		return y2 == t;
	}
	void init()
	{
		bool b;
		xi.a = -2;
		xi.b = -1;
		Ell2p_a.a = 0;
		Ell2p_a.b = 240;
		Ell2p_b.a = 1012;
		Ell2p_b.b = 1012;
		half = -1;
		half /= 2;
		sqrtConst = Fp::getOp().mp;
		sqrtConst *= sqrtConst;
		sqrtConst -= 9;
		sqrtConst /= 16;
		const char *rv1Str = "0x6af0e0437ff400b6831e36d6bd17ffe48395dabc2d3435e77f76e17009241c5ee67992f72ec05f4c81084fbede3cc09";
		root4[0].a = 1;
		root4[0].b.clear();
		root4[1].a.clear();
		root4[1].b = 1;
		root4[2].a.setStr(&b, rv1Str);
		assert(b); (void)b;
		root4[2].b = root4[2].a;
		root4[3].a = root4[2].a;
		Fp::neg(root4[3].b, root4[3].a);
		const char *ev1Str = "0x699be3b8c6870965e5bf892ad5d2cc7b0e85a117402dfd83b7f4a947e02d978498255a2aaec0ac627b5afbdf1bf1c90";
		const char *ev2Str = "0x8157cd83046453f5dd0972b6e3949e4288020b5b8a9cc99ca07e27089a2ce2436d965026adad3ef7baba37f2183e9b5";
		const char *ev3Str = "0xab1c2ffdd6c253ca155231eb3e71ba044fd562f6f72bc5bad5ec46a0b7a3b0247cf08ce6c6317f40edbc653a72dee17";
		const char *ev4Str = "0xaa404866706722864480885d68ad0ccac1967c7544b447873cc37e0181271e006df72162a3d3e0287bf597fbf7f8fc1";
		Fp& ev1 = etas[0].a;
		Fp& ev2 = etas[0].b;
		Fp& ev3 = etas[2].a;
		Fp& ev4 = etas[2].b;
		ev1.setStr(&b, ev1Str);
		assert(b); (void)b;
		ev2.setStr(&b, ev2Str);
		assert(b); (void)b;
		Fp::neg(etas[1].a, ev2);
		etas[1].b = ev1;
		ev3.setStr(&b, ev3Str);
		assert(b); (void)b;
		ev4.setStr(&b, ev4Str);
		assert(b); (void)b;
		Fp::neg(etas[3].a, ev4);
		etas[3].b = ev3;
		init_iso();
		draftVersion_ = 5;
	}
	void init_iso()
	{
		const char *tbl[] = {
			"0x5c759507e8e333ebb5b7a9a47d7ed8532c52d39fd3a042a88b58423c50ae15d5c2638e343d9c71c6238aaaaaaaa97d6",
			"0x11560bf17baa99bc32126fced787c88f984f87adf7ae0c7f9a208c6b4f20a4181472aaa9cb8d555526a9ffffffffc71a",
			"0x11560bf17baa99bc32126fced787c88f984f87adf7ae0c7f9a208c6b4f20a4181472aaa9cb8d555526a9ffffffffc71e",
			"0x8ab05f8bdd54cde190937e76bc3e447cc27c3d6fbd7063fcd104635a790520c0a395554e5c6aaaa9354ffffffffe38d",
			"0x171d6541fa38ccfaed6dea691f5fb614cb14b4e7f4e810aa22d6108f142b85757098e38d0f671c7188e2aaaaaaaa5ed1",
			"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaa63",
			"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaa9f",
			"0x1530477c7ab4113b59a4c18b076d11930f7da5d4a07f649bf54439d87d27e500fc8c25ebf8c92f6812cfc71c71c6d706",
			"0x5c759507e8e333ebb5b7a9a47d7ed8532c52d39fd3a042a88b58423c50ae15d5c2638e343d9c71c6238aaaaaaaa97be",
			"0x11560bf17baa99bc32126fced787c88f984f87adf7ae0c7f9a208c6b4f20a4181472aaa9cb8d555526a9ffffffffc71c",
			"0x8ab05f8bdd54cde190937e76bc3e447cc27c3d6fbd7063fcd104635a790520c0a395554e5c6aaaa9354ffffffffe38f",
			"0x124c9ad43b6cf79bfbf7043de3811ad0761b0f37a1e26286b0e977c69aa274524e79097a56dc4bd9e1b371c71c718b10",
			"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffa8fb",
			"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffa9d3",
			"0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaa99",
		};
		bool b;
		xnum[0].a.setStr(&b, tbl[0]); assert(b); (void)b;
		xnum[0].b = xnum[0].a;
		xnum[1].a.clear();
		xnum[1].b.setStr(&b, tbl[1]); assert(b); (void)b;
		xnum[2].a.setStr(&b, tbl[2]); assert(b); (void)b;
		xnum[2].b.setStr(&b, tbl[3]); assert(b); (void)b;
		xnum[3].a.setStr(&b, tbl[4]); assert(b); (void)b;
		xnum[3].b.clear();
		xden[0].a.clear();
		xden[0].b.setStr(&b, tbl[5]); assert(b); (void)b;
		xden[1].a = 0xc;
		xden[1].b.setStr(&b, tbl[6]); assert(b); (void)b;
		xden[2].a = 1;
		xden[2].b = 0;
		ynum[0].a.setStr(&b, tbl[7]); assert(b); (void)b;
		ynum[0].b = ynum[0].a;
		ynum[1].a.clear();
		ynum[1].b.setStr(&b, tbl[8]); assert(b); (void)b;
		ynum[2].a.setStr(&b, tbl[9]); assert(b); (void)b;
		ynum[2].b.setStr(&b, tbl[10]); assert(b); (void)b;
		ynum[3].a.setStr(&b, tbl[11]); assert(b); (void)b;
		ynum[3].b.clear();
		yden[0].a.setStr(&b, tbl[12]); assert(b); (void)b;
		yden[0].b = yden[0].a;
		yden[1].a.clear();
		yden[1].b.setStr(&b, tbl[13]); assert(b); (void)b;
		yden[2].a = 0x12;
		yden[2].b.setStr(&b, tbl[14]); assert(b); (void)b;
		yden[3].a = 1;
		yden[3].b.clear();
	}
	template<size_t N>
	void evalPoly(Fp2& y, const Fp2& x, const Fp2 *zpows, const Fp2 (&cof)[N]) const
	{
		y = cof[N - 1]; // always zpows[0] = 1
		for (size_t i = 1; i < N; i++) {
			y *= x;
			Fp2 t;
			Fp2::mul(t, zpows[i - 1], cof[N - 1 - i]);
			y += t;
		}
	}
	// refer (xnum, xden, ynum, yden)
	void iso3(G2& Q, const Point& P) const
	{
		Fp2 zpows[3];
		Fp2::sqr(zpows[0], P.z);
		Fp2::sqr(zpows[1], zpows[0]);
		Fp2::mul(zpows[2], zpows[1], zpows[0]);
		Fp2 mapvals[4];
		evalPoly(mapvals[0], P.x, zpows, xnum);
		evalPoly(mapvals[1], P.x, zpows, xden);
		evalPoly(mapvals[2], P.x, zpows, ynum);
		evalPoly(mapvals[3], P.x, zpows, yden);
		mapvals[1] *= zpows[0];
		mapvals[2] *= P.y;
		mapvals[3] *= zpows[0];
		mapvals[3] *= P.z;
		Fp2::mul(Q.z, mapvals[1], mapvals[3]);
		Fp2::mul(Q.x, mapvals[0], mapvals[3]);
		Q.x *= Q.z;
		Fp2 t;
		Fp2::sqr(t, Q.z);
		Fp2::mul(Q.y, mapvals[2], mapvals[1]);
		Q.y *= t;
	}
	/*
		(a+bi)*(-2-i) = (b-2a)-(a+2b)i
	*/
	void mul_xi(Fp2& y, const Fp2& x) const
	{
		Fp t;
		Fp::sub(t, x.b, x.a);
		t -= x.a;
		Fp::add(y.b, x.b, x.b);
		y.b += x.a;
		Fp::neg(y.b, y.b);
		y.a = t;
	}
	bool isNegSign(const Fp2& x) const
	{
		if (x.b > half) return true;
		if (!x.b.isZero()) return false;
		if (x.a > half) return true;
		if (!x.b.isZero()) return false;
		return false;
	}
	/*
		z = sqrt(u/v) = (uv^7) (uv^15)^((p^2-9)/16) * root4
		return true if found
	*/
	bool sqr_div(Fp2& z, const Fp2& u, const Fp2& v) const
	{
		Fp2 gamma, t1, t2;
		Fp2::sqr(gamma, v); // v^2
		Fp2::sqr(t2, gamma); // v^4
		Fp2::mul(t1, u, v); // uv
		t1 *= gamma; // uv^3
		t1 *= t2; // uv^7
		Fp2::sqr(t2, t2); // v^8
		t2 *= t1;
		Fp2::pow(gamma, t2, sqrtConst);
		gamma *= t1;
		Fp2 candi;
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(root4); i++) {
			Fp2::mul(candi, gamma, root4[i]);
			Fp2::sqr(t1, candi);
			t1 *= v;
			if (t1 == u) {
				z = candi;
				return true;
			}
		}
		z = gamma;
		return false;
	}
	// https://github.com/ethereum/py_ecc
	void py_ecc_optimized_swu_G2(Point& P, const Fp2& t) const
	{
		Fp2 t2, t2xi, t2xi2;
		Fp2::sqr(t2, t);
		mul_xi(t2xi, t2);
		Fp2::sqr(t2xi2, t2xi);
		Fp2 nume, deno;
		// (t^2 * xi)^2 + (t^2 * xi)
		Fp2::add(deno, t2xi2, t2xi);
		Fp2::add(nume, deno, 1);
		nume *= Ell2p_b;
		if (deno.isZero()) {
			Fp2::mul(deno, Ell2p_a, xi);
		} else {
			deno *= -Ell2p_a;
		}
		Fp2 u, v;
		{
			Fp2 deno2, tmp, tmp1, tmp2;
			Fp2::sqr(deno2, deno);
			Fp2::mul(v, deno2, deno);

			Fp2::mul(u, Ell2p_b, v);
			Fp2::mul(tmp, Ell2p_a, nume);
			tmp *= deno2;
			u += tmp;
			Fp2::sqr(tmp, nume);
			tmp *= nume;
			u += tmp;
		}
		Fp2 candi;
		bool success = sqr_div(candi, u, v);
		P.y = candi;
		candi *= t2;
		candi *= t;
		u *= t2xi2;
		u *= t2xi;
		bool success2 = false;
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(etas); i++) {
			Fp2 t1;
			Fp2::mul(t1, etas[i], candi);
			Fp2::sqr(t2, t1);
			t2 *= v;
			if (t2 == u && !success && !success2) {
				P.y = t1;
				success2 = true;
			}
		}
		assert(success || success2);
		if (!success) {
			nume *= t2xi;
		}
		if (isNegSign(t) != isNegSign(P.y)) {
			Fp2::neg(P.y, P.y);
		}
		P.y *= deno;
		P.x = nume;
		P.z = deno;
	}
	// Proj
	void py_ecc_iso_map_G2(G2& Q, const Point& P) const
	{
		Fp2 zpows[3];
		zpows[0] = P.z;
		Fp2::sqr(zpows[1], zpows[0]);
		Fp2::mul(zpows[2], zpows[1], zpows[0]);
		Fp2 mapvals[4];
		evalPoly(mapvals[0], P.x, zpows, xnum);
		evalPoly(mapvals[1], P.x, zpows, xden);
		evalPoly(mapvals[2], P.x, zpows, ynum);
		evalPoly(mapvals[3], P.x, zpows, yden);
		mapvals[1] *= P.z;
		mapvals[2] *= P.y;
		mapvals[3] *= P.z;
		Fp2::mul(Q.z, mapvals[1], mapvals[3]);
		Fp2::mul(Q.x, mapvals[0], mapvals[3]);
		Fp2::mul(Q.y, mapvals[1], mapvals[2]);
	}
	/*
		in : Jacobi [X:Y:Z]
		out : Proj [A:B:C]
		[X:Y:Z] as Jacobi
		= (X/Z^2, Y/Z^3) as Affine
		= [X/Z^2:Y/Z^3:1] as Proj
		= [XZ:Y:Z^3] as Proj
	*/
	void toProj(G2& out, const G2& in) const
	{
		Fp2 z2;
		Fp2::sqr(z2, in.z);
		Fp2::mul(out.x, in.x, in.z);
		out.y = in.y;
		Fp2::mul(out.z, in.z, z2);
	}
	/*
		in : Proj [X:Y:Z]
		out : Jacobi [A:B:C]
		[X:Y:Z] as Proj
		= (X/Z, Y/Z) as Affine
		= [X/Z:Y/Z:1] as Jacobi
		= [XZ:YZ^2:Z] as Jacobi
	*/
	void toJacobi(G2& out, const G2& in) const
	{
		Fp2 z2;
		Fp2::sqr(z2, in.z);
		Fp2::mul(out.x, in.x, in.z);
		Fp2::mul(out.y, in.y, z2);
		out.z = in.z;
	}
	// Proj
	void py_ecc_map_to_curve_G2(G2& out, const Fp2& t) const
	{
		Point P;
		py_ecc_optimized_swu_G2(P, t);
		py_ecc_iso_map_G2(out, P);
	}
	// https://github.com/algorand/bls_sigs_ref
	void osswu2_help(Point& P, const Fp2& t) const
	{
		Fp2 t2, t2xi;
		Fp2::sqr(t2, t);
		Fp2 den, den2;
		mul_xi(t2xi, t2);
		den = t2xi;
		Fp2::sqr(den2, den);
		// (t^2 * xi)^2 + (t^2 * xi)
		den += den2;
		Fp2 x0_num, x0_den;
		Fp2::add(x0_num, den, 1);
		x0_num *= Ell2p_b;
		if (den.isZero()) {
			Fp2::mul(x0_den, Ell2p_a, xi);
		} else {
			Fp2::mul(x0_den, -Ell2p_a, den);
		}
		Fp2 x0_den2, x0_den3, gx0_den, gx0_num;
		Fp2::sqr(x0_den2, x0_den);
		Fp2::mul(x0_den3, x0_den2, x0_den);
		gx0_den = x0_den3;

		Fp2::mul(gx0_num, Ell2p_b, gx0_den);
		Fp2 tmp, tmp1, tmp2;
		Fp2::mul(tmp, Ell2p_a, x0_num);
		tmp *= x0_den2;
		gx0_num += tmp;
		Fp2::sqr(tmp, x0_num);
		tmp *= x0_num;
		gx0_num += tmp;

		Fp2::sqr(tmp1, gx0_den); // x^2
		Fp2::sqr(tmp2, tmp1); // x^4
		tmp1 *= tmp2;
		tmp1 *= gx0_den; // x^7
		Fp2::mul(tmp2, gx0_num, tmp1);
		tmp1 *= tmp2;
		tmp1 *= gx0_den;
		Fp2 candi;
		Fp2::pow(candi, tmp1, sqrtConst);
		candi *= tmp2;
		bool isNegT = isNegSign(t);
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(root4); i++) {
			Fp2::mul(P.y, candi, root4[i]);
			Fp2::sqr(tmp, P.y);
			tmp *= gx0_den;
			if (tmp == gx0_num) {
				if (isNegSign(P.y) != isNegT) {
					Fp2::neg(P.y, P.y);
				}
				Fp2::mul(P.x, x0_num, x0_den);
				P.y *= x0_den3;
				P.z = x0_den;
				return;
			}
		}
		Fp2 x1_num, x1_den, gx1_num, gx1_den;
		Fp2::mul(x1_num, t2xi, x0_num);
		x1_den = x0_den;
		Fp2::mul(gx1_num, den2, t2xi);
		gx1_num *= gx0_num;
		gx1_den = gx0_den;
		candi *= t2;
		candi *= t;
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(etas); i++) {
			Fp2::mul(P.y, candi, etas[i]);
			Fp2::sqr(tmp, P.y);
			tmp *= gx1_den;
			if (tmp == gx1_num) {
				if (isNegSign(P.y) != isNegT) {
					Fp2::neg(P.y, P.y);
				}
				Fp2::mul(P.x, x1_num, x1_den);
				Fp2::sqr(tmp, x1_den);
				P.y *= tmp;
				P.y *= x1_den;
				P.z = x1_den;
				return;
			}
		}
		assert(0);
	}
	void h2_chain(G2& out, const G2& P) const
	{
		G2 t[16];
		t[0] = P;
		dbl(t[1], t[0]);
		add(t[4], t[1], t[0]);
		add(t[2], t[4], t[1]);
		add(t[3], t[2], t[1]);
		add(t[11], t[3], t[1]);
		add(t[9], t[11], t[1]);
		add(t[10], t[9], t[1]);
		add(t[5], t[10], t[1]);
		add(t[7], t[5], t[1]);
		add(t[15], t[7], t[1]);
		add(t[13], t[15], t[1]);
		add(t[6], t[13], t[1]);
		add(t[14], t[6], t[1]);
		add(t[12], t[14], t[1]);
		add(t[8], t[12], t[1]);
		dbl(t[1], t[6]);

		const struct {
			uint32_t n;
			uint32_t idx;
		} tbl[] = {
			{ 5, 13 }, { 2, 0 }, { 9, 8 }, { 5, 11 }, { 6, 13 }, { 8, 2 }, { 5, 3 },
			{ 5, 3 }, { 4, 5 }, { 4, 0 }, { 8, 11 }, { 8, 8 }, { 4, 2 }, { 9, 5 },
			{ 6, 11 }, { 2, 0 }, { 9, 8 }, { 5, 13 }, { 4, 0 }, { 11, 9 }, { 7, 12 },
			{ 7, 7 }, { 5, 12 }, { 5, 14 }, { 8, 13 }, { 6, 3 }, { 5, 0 }, { 8, 9 },
			{ 6, 13 }, { 4, 10 }, { 4, 2 }, { 6, 10 }, { 6, 2 }, { 4, 0 }, { 10, 9 },
			{ 6, 14 }, { 4, 3 }, { 6, 9 }, { 6, 15 }, { 5, 8 }, { 5, 12 }, { 4, 5 },
			{ 6, 15 }, { 6, 2 }, { 7, 5 }, { 6, 3 }, { 6, 9 }, { 6, 15 }, { 6, 14 },
			{ 5, 8 }, { 10, 6 }, { 5, 5 }, { 3, 0 }, { 9, 13 }, { 7, 12 }, { 4, 5 },
			{ 6, 2 }, { 6, 11 }, { 4, 10 }, { 4, 4 }, { 6, 10 }, { 7, 7 }, { 3, 2 },
			{ 4, 3 }, { 8, 9 }, { 8, 9 }, { 6, 8 }, { 5, 7 }, { 5, 6 }, { 6, 5 },
			{ 6, 4 }, { 5, 5 }, { 6, 4 }, { 6, 3 }, { 6, 4 }, { 6, 5 }, { 6, 3 },
			{ 7, 3 }, { 6, 3 }, { 5, 4 }, { 6, 3 }, { 6, 3 }, { 3, 0 }, { 6, 3 },
			{ 6, 3 },
		};
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
			const uint32_t n = tbl[j].n;
			for (size_t i = 0; i < n; i++) dbl(t[1], t[1]);
			add(t[1], t[1], t[tbl[j].idx]);
		}
		for (size_t i = 0; i < 5; i++) dbl(t[1], t[1]);
		add(out, t[1], t[2]);
	}
	void mx_chain(G2& Q, const G2& P) const
	{
		G2 T;
		dbl(T, P);
		const size_t tbl[] = { 2, 3, 9, 32, 16 };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			add(T, T, P);
			for (size_t j = 0; j < tbl[i]; j++) {
				dbl(T, T);
			}
		}
		Q = T;
	}
	void clear_h2(G2& Q, const G2& P) const
	{
#if 0
		mcl::bn::BN::param.mapTo.mulByCofactorBLS12fast(Q, P);
#else
		G2 work, work2;
		h2_chain(work, P);
		dbl(work2, work);
		add(work2, work, work2);
		mx_chain(work, work2);
		mx_chain(work, work);
		neg(work2, work2);
		add(Q, work, work2);
#endif
	}
	template<class T>
	void put(const T& P) const
	{
		const int base = 10;
		printf("x=%s\n", P.x.getStr(base).c_str());
		printf("y=%s\n", P.y.getStr(base).c_str());
		printf("z=%s\n", P.z.getStr(base).c_str());
	}
	bool normalizeJacobi(Point& out, const Point& in) const
	{
		if (in.z.isZero()) return false;
		Fp2 t;
		Fp2::inv(t, in.z);
		Fp2::mul(out.y, in.y, t);
		Fp2::sqr(t, t);
		Fp2::mul(out.x, in.x, t);
		out.y *= t;
		out.z = 1;
		return true;
	}
	void opt_swu2_map(G2& P, const Fp2& t, const Fp2 *t2 = 0) const
	{
		Point Pp;
		osswu2_help(Pp, t);
		if (t2) {
			Point P2;
			osswu2_help(P2, *t2);
			add(Pp, Pp, P2);
		}
		iso3(P, Pp);
		clear_h2(P, P);
	}
	void py_ecc_hash_to_G2(G2& out, const void *msg, size_t msgSize, const void *dst, size_t dstSize) const
	{
		Fp2 t1, t2;
		hashToFp2(t1, msg, msgSize, 0, dst, dstSize);
		hashToFp2(t2, msg, msgSize, 1, dst, dstSize);
		G2 P1, P2;
		py_ecc_map_to_curve_G2(P1, t1);
		py_ecc_map_to_curve_G2(P2, t2);
		toJacobi(P1, P1);
		toJacobi(P2, P2);
		P1 += P2;
		clear_h2(out, P1);
	}
	// hash-to-curve-06
	void hashToFp2v6(Fp2 out[2], const void *msg, size_t msgSize, const void *dst, size_t dstSize) const
	{
		uint8_t md[256];
		mcl::fp::expand_message_xmd(md, msg, msgSize, dst, dstSize);
		Fp *x = out[0].getFp0();
		for (size_t i = 0; i < 4; i++) {
			uint8_t *p = &md[64 * i];
			fp::local::byteSwap(p, 64);
			bool b;
			x[i].setArrayMod(&b, p, 64);
			assert(b); (void)b;
		}
	}
	void map2curve_osswu2(G2& out, const void *msg, size_t msgSize, const void *dst, size_t dstSize) const
	{
		Fp2 t[2];
		if (draftVersion_ == 5) {
			hashToFp2(t[0], msg, msgSize, 0, dst, dstSize);
			hashToFp2(t[1], msg, msgSize, 1, dst, dstSize);
		} else {
			hashToFp2v6(t, msg, msgSize, dst, dstSize);
		}
		opt_swu2_map(out, t[0], &t[1]);
	}
	void msgToG2(G2& out, const void *msg, size_t msgSize) const
	{
		const char *dst;
		if (draftVersion_ == 5) {
			dst = "BLS_SIG_BLS12381G2-SHA256-SSWU-RO-_POP_";
		} else {
			dst = "BLS_SIG_BLS12381G2_XMD:SHA-256_SSWU_RO_POP_";
		}
		map2curve_osswu2(out, msg, msgSize, dst, strlen(dst));
	}
};

} // mcl

