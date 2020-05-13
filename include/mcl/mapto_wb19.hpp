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
inline void hashToFp2old(Fp2& out, const void *msg, size_t msgSize, uint8_t ctr, const void *dst, size_t dstSize)
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

namespace local {

// y^2 = x^3 + 4(1 + i)
template<class F>
struct PointT {
	typedef F Fp;
	F x, y, z;
	static F a_;
	static F b_;
	static int specialA_;
	bool isZero() const
	{
		return z.isZero();
	}
	void clear()
	{
		x.clear();
		y.clear();
		z.clear();
	}
	bool isEqual(const PointT<F>& rhs) const
	{
		return ec::isEqualJacobi(*this, rhs);
	}
};

template<class F> F PointT<F>::a_;
template<class F> F PointT<F>::b_;
template<class F> int PointT<F>::specialA_;

} // mcl::local

template<class Fp, class Fp2, class G2>
struct MapToG2_WB19 {
	typedef local::PointT<Fp2> Point;
	mpz_class sqrtConst; // (p^2 - 9) / 16
	Fp2 Ep_a;
	Fp2 Ep_b;
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
	void init()
	{
		bool b;
		Ep_a.a = 0;
		Ep_a.b = 240;
		Ep_b.a = 1012;
		Ep_b.b = 1012;
		Point::a_.clear();
		Point::b_.a = 4;
		Point::b_.b = 4;
		Point::specialA_ = ec::Zero;
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
		xi = -2-i
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
	bool sgn0(const Fp& x) const
	{
		return x.isOdd();
	}
	bool sgn0(const Fp2& x) const
	{
		bool sign0 = sgn0(x.a);
		bool zero0 = x.a.isZero();
		bool sign1 = sgn0(x.b);
		return sign0 || (zero0 & sign1);
	}
	bool isNegSign(const Fp2& x) const
	{
		if (draftVersion_ == 7) {
			return sgn0(x);
		}
		// x.isNegative() <=> x > (p-1)/2 <=> x >= (p+1)/2
		if (x.b.isNegative()) return true;
		if (!x.b.isZero()) return false;
		if (x.a.isNegative()) return true;
		if (!x.b.isZero()) return false;
		return false;
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
		x0_num *= Ep_b;
		if (den.isZero()) {
			mul_xi(x0_den, Ep_a);
		} else {
			Fp2::mul(x0_den, -Ep_a, den);
		}
		Fp2 x0_den2, x0_den3, gx0_den, gx0_num;
		Fp2::sqr(x0_den2, x0_den);
		Fp2::mul(x0_den3, x0_den2, x0_den);
		gx0_den = x0_den3;

		Fp2::mul(gx0_num, Ep_b, gx0_den);
		Fp2 tmp, tmp1, tmp2;
		Fp2::mul(tmp, Ep_a, x0_num);
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
#if 0
	void h2_chain(G2& out, const G2& P) const
	{
		G2 t[16];
		t[0] = P;
		G2::dbl(t[1], t[0]);
		G2::add(t[4], t[1], t[0]);
		G2::add(t[2], t[4], t[1]);
		G2::add(t[3], t[2], t[1]);
		G2::add(t[11], t[3], t[1]);
		G2::add(t[9], t[11], t[1]);
		G2::add(t[10], t[9], t[1]);
		G2::add(t[5], t[10], t[1]);
		G2::add(t[7], t[5], t[1]);
		G2::add(t[15], t[7], t[1]);
		G2::add(t[13], t[15], t[1]);
		G2::add(t[6], t[13], t[1]);
		G2::add(t[14], t[6], t[1]);
		G2::add(t[12], t[14], t[1]);
		G2::add(t[8], t[12], t[1]);
		G2::dbl(t[1], t[6]);

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
			for (size_t i = 0; i < n; i++) G2::dbl(t[1], t[1]);
			G2::add(t[1], t[1], t[tbl[j].idx]);
		}
		for (size_t i = 0; i < 5; i++) G2::dbl(t[1], t[1]);
		G2::add(out, t[1], t[2]);
	}
	void mx_chain(G2& Q, const G2& P) const
	{
		G2 T;
		G2::dbl(T, P);
		const size_t tbl[] = { 2, 3, 9, 32, 16 };
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			G2::add(T, T, P);
			for (size_t j = 0; j < tbl[i]; j++) {
				G2::dbl(T, T);
			}
		}
		Q = T;
	}
#endif
	void clear_h2(G2& Q, const G2& P) const
	{
#if 1
		// 1.9Mclk can be reduced
		mcl::local::mulByCofactorBLS12fast(Q, P);
#else
		G2 T0, T1;
		h2_chain(T0, P);
		G2::dbl(T1, T0);
		G2::add(T1, T0, T1);
		mx_chain(T0, T1);
		mx_chain(T0, T0);
		G2::neg(T1, T1);
		G2::add(Q, T0, T1);
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
	void opt_swu2_map(G2& P, const Fp2& t, const Fp2 *t2 = 0) const
	{
		Point Pp;
		osswu2_help(Pp, t);
		if (t2) {
			Point P2;
			osswu2_help(P2, *t2);
			ec::addJacobi(Pp, Pp, P2);
		}
		iso3(P, Pp);
		clear_h2(P, P);
	}
	// hash-to-curve-06
	void hashToFp2(Fp2 out[2], const void *msg, size_t msgSize, const void *dst, size_t dstSize) const
	{
		uint8_t md[256];
		if (draftVersion_ == 6) {
			mcl::fp::expand_message_xmd06(md, msg, msgSize, dst, dstSize);
		} else {
			mcl::fp::expand_message_xmd(md, msg, msgSize, dst, dstSize);
		}
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
			hashToFp2old(t[0], msg, msgSize, 0, dst, dstSize);
			hashToFp2old(t[1], msg, msgSize, 1, dst, dstSize);
		} else {
			hashToFp2(t, msg, msgSize, dst, dstSize);
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

