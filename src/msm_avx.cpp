/**
	@file
	@brief multi scalar multiplication with AVX-512 IFMA
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <stdint.h>
#include "avx512.hpp"

#include <mcl/ec.hpp>
#define XBYAK_NO_EXCEPTION
#include "xbyak/xbyak_util.h"

#if defined(__GNUC__)
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif

namespace {

typedef mcl::Unit Unit;
static mcl::msm::Func g_func;

static const size_t S = sizeof(Unit)*8-1; // 63
static const size_t W = 52;
static const size_t N = 8; // = ceil(384/52)
static const size_t M = sizeof(Vec) / sizeof(Unit);
#include "msm_avx_bls12_381.h"

inline Unit getMask(int w)
{
	if (w == 64) return Unit(-1);
	return (Unit(1) << w) - 1;
}

inline uint8_t cvtToInt(const Vmask& v)
{
	uint8_t r;
	memcpy(&r, &v, sizeof(r));
	return r;
}

inline void dump(const Vmask& v, const char *msg = nullptr)
{
	if (msg) printf("%s ", msg);
	uint64_t x = cvtToInt(v);
	for (size_t i = 0; i < 8; i++) {
		putchar('0' + ((x>>(7-i))&1));
	}
	putchar('\n');
}

inline void dump(const Vec& v, const char *msg = nullptr)
{
	mcl::bint::dump((const uint64_t*)&v, sizeof(v)/sizeof(uint64_t), msg);
}

// set x[j] to i-th SIMD element of v[j]
inline void set(Vec v[N], size_t i, const Unit x[N])
{
	assert(i < M);
	Unit *p = (Unit *)v;
	for (size_t j = 0; j < N; j++) {
		p[j*M+i] = x[j];
	}
}

inline void get(Unit x[N], const Vec v[N], size_t i)
{
	assert(i < M);
	const Unit *p = (const Unit *)v;
	for (size_t j = 0; j < N; j++) {
		x[j] = p[j*M+i];
	}
}

inline void cvt(Vec yN[N], const Unit x[N*M])
{
	for (size_t i = 0; i < M; i++) {
		set(yN, i, x+i*N);
	}
}

inline void cvt(Unit y[N*M], const Vec xN[N])
{
	for (size_t i = 0; i < M; i++) {
		get(y+i*N, xN, i);
	}
}

template<size_t n=N>
inline void vrawAdd(Vec *z, const Vec *x, const Vec *y)
{
	Vec t = vpaddq(x[0], y[0]);
	Vec c = vpsrlq(t, W);
	z[0] = vpandq(t, G::mask());

	for (size_t i = 1; i < n; i++) {
		t = vpaddq(x[i], y[i]);
		t = vpaddq(t, c);
		if (i == n-1) {
			z[i] = t;
			return;
		}
		c = vpsrlq(t, W);
		z[i] = vpandq(t, G::mask());
	}
}

template<size_t n=N>
inline Vmask vrawSub(Vec *z, const Vec *x, const Vec *y)
{
	Vec t = vpsubq(x[0], y[0]);
	Vec c = vpsrlq(t, S);
	z[0] = vpandq(t, G::mask());
	for (size_t i = 1; i < n; i++) {
		t = vpsubq(x[i], y[i]);
		t = vpsubq(t, c);
		c = vpsrlq(t, S);
		z[i] = vpandq(t, G::mask());
	}
	return vpcmpneqq(c, vzero());
}

#if 1
template<size_t n=N>
inline Vmask vrawNeg(Vec *z, const Vec *x)
{
	Vec zero = vzero();
	Vec t = vpsubq(zero, x[0]);
	Vec c = vpsrlq(t, S);
	z[0] = vpandq(t, G::mask());
	for (size_t i = 1; i < n; i++) {
		t = vpsubq(zero, x[i]);
		t = vpsubq(t, c);
		c = vpsrlq(t, S);
		z[i] = vpandq(t, G::mask());
	}
	return vpcmpneqq(c, zero);
}
#endif

inline void uvselect(Vec *z, const Vmask& c, const Vec *a, const Vec *b)
{
	for (size_t i = 0; i < N; i++) {
		z[i] = vselect(c, a[i], b[i]);
	}
}

inline void uvadd(Vec *z, const Vec *x, const Vec *y)
{
	Vec sN[N], tN[N];
	vrawAdd(sN, x, y);
	Vmask c = vrawSub(tN, sN, G::ap());
	uvselect(z, c, sN, tN);
}

inline void uvsub(Vec *z, const Vec *x, const Vec *y)
{
	Vec sN[N], tN[N];
	Vmask c = vrawSub(sN, x, y);
	vrawAdd(tN, sN, G::ap());
	tN[N-1] = vpandq(tN[N-1], G::mask());
	uvselect(z, c, tN, sN);
}

inline void uvneg(Vec *z, const Vec *x)
{
#if 1
	Vec tN[N];
	Vec t = vpsubq(G::ap()[0], x[0]);
	Vec c = vpsrlq(t, S);
	tN[0] = vpandq(t, G::mask());
	Vec w  = x[0];
	for (size_t i = 1; i < N; i++) {
		w = vporq(w, x[i]);
		t = vpsubq(G::ap()[i], x[i]);
		t = vpsubq(t, c);
		c = vpsrlq(t, S);
		tN[i] = vpandq(t, G::mask());
	}
	Vec zero = vzero();
	Vmask isZero = vpcmpeqq(w, zero);
	uvselect(z, isZero, x, tN);
#else
	Vec sN[N], tN[N];
	Vmask c = vrawNeg(sN, x);
	vrawAdd(tN, sN, G::ap());
	tN[N-1] = vpandq(tN[N-1], G::mask());
	uvselect(z, c, tN, sN);
#endif
}

inline void vrawMulUnitOrg(Vec *z, const Vec *x, const Vec& y)
{
	Vec L[N], H[N];
	for (size_t i = 0; i < N; i++) {
		L[i] = vmulL(x[i], y);
		H[i] = vmulH(x[i], y);
	}
	z[0] = L[0];
	for (size_t i = 1; i < N; i++) {
		z[i] = vpaddq(L[i], H[i-1]);
	}
	z[N] = H[N-1];
}

inline Vec vrawMulUnitAddOrg(Vec *z, const Vec *x, const Vec& y)
{
	Vec L[N], H[N];
	for (size_t i = 0; i < N; i++) {
		L[i] = vmulL(x[i], y);
		H[i] = vmulH(x[i], y);
	}
	z[0] = vpaddq(z[0], L[0]);
	for (size_t i = 1; i < N; i++) {
		z[i] = vpaddq(z[i], vpaddq(L[i], H[i-1]));
	}
	return H[N-1];
}

template<size_t n=N>
inline void vrawMulUnit(Vec *z, const Vec *x, const Vec& y)
{
	Vec H;
	z[0] = vmulL(x[0], y);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < n; i++) {
		z[i] = vmulL(x[i], y, H);
		H = vmulH(x[i], y);
	}
	z[n] = H;
}

template<size_t n=N>
inline Vec vrawMulUnitAdd(Vec *z, const Vec *x, const Vec& y)
{
	Vec H;
	z[0] = vmulL(x[0], y, z[0]);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < n; i++) {
		z[i] = vpaddq(vmulL(x[i], y, H), z[i]);
		H = vmulH(x[i], y);
	}
	return H;
}

template<size_t n=N>
inline void vrawMul(Vec z[n*2], const Vec x[n], const Vec y[n])
{
	vrawMulUnit<n>(z, x, y[0]);
	for (size_t i = 1; i < n; i++) {
		z[n+i] = vrawMulUnitAdd<n>(z+i, x, y[i]);
	}
}

template<size_t n=N>
inline void vrawSqr(Vec z[n*2], const Vec x[n])
{
	for (size_t i = 1; i < n; i++) {
		z[i*2-1] = vmulL(x[i], x[i-1]);
		z[i*2  ] = vmulH(x[i], x[i-1]);
	}
	for (size_t j = 2; j < n; j++) {
		for (size_t i = j; i < n; i++) {
//			z[i*2-j  ] = vpaddq(z[i*2-j  ], vmulL(x[i], x[i-j]));
//			z[i*2-j+1] = vpaddq(z[i*2-j+1], vmulH(x[i], x[i-j]));
			z[i*2-j  ] = vmulL(x[i], x[i-j], z[i*2-j  ]);
			z[i*2-j+1] = vmulH(x[i], x[i-j], z[i*2-j+1]);
		}
	}
	for (size_t i = 1; i < n*2-1; i++) {
		z[i] = vpaddq(z[i], z[i]);
	}
	z[0] = vmulL(x[0], x[0]);
	for (size_t i = 1; i < n; i++) {
//		z[i*2-1] = vpaddq(z[i*2-1], vmulH(x[i-1], x[i-1]));
//		z[i*2] = vpaddq(z[i*2], vmulL(x[i], x[i]));
		z[i*2-1] = vmulH(x[i-1], x[i-1], z[i*2-1]);
		z[i*2] = vmulL(x[i], x[i], z[i*2]);
	}
	z[n*2-1] = vmulH(x[n-1], x[n-1]);
}

// t[n] = c ? a[n] : zero
template<size_t n=N>
inline void vset(Vec *t, const Vmask& c, const Vec a[n])
{
	for (size_t i = 0; i < n; i++) {
		t[i] = vselect(c, a[i], vzero());
	}
}

inline void uvmont(Vec z[N], Vec xy[N*2])
{
	for (size_t i = 0; i < N; i++) {
		Vec q = vmulL(xy[i], G::rp());
		xy[N+i] = vpaddq(xy[N+i], vrawMulUnitAdd(xy+i, G::ap(), q));
		xy[i+1] = vpaddq(xy[i+1], vpsrlq(xy[i], W));
	}
	for (size_t i = N; i < N*2-1; i++) {
		xy[i+1] = vpaddq(xy[i+1], vpsrlq(xy[i], W));
		xy[i] = vpandq(xy[i], G::mask());
	}
	Vmask c = vrawSub(z, xy+N, G::ap());
	uvselect(z, c, xy+N, z);
}

inline void uvmul(Vec *z, const Vec *x, const Vec *y)
{
#if 0
	Vec xy[N*2];
	vrawMul(xy, x, y);
	uvmont(z, xy);
#else
	Vec t[N*2], q;
	vrawMulUnit(t, x, y[0]);
	q = vmulL(t[0], G::rp());
	t[N] = vpaddq(t[N], vrawMulUnitAdd(t, G::ap(), q));
	for (size_t i = 1; i < N; i++) {
		t[N+i] = vrawMulUnitAdd(t+i, x, y[i]);
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		q = vmulL(t[i], G::rp());
		t[N+i] = vpaddq(t[N+i], vrawMulUnitAdd(t+i, G::ap(), q));
	}
	for (size_t i = N; i < N*2; i++) {
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		t[i-1] = vpandq(t[i-1], G::mask());
	}
	Vmask c = vrawSub(z, t+N, G::ap());
	uvselect(z, c, t+N, z);
#endif
}

// slower than uvmul
inline void uvsqr(Vec *z, const Vec *x)
{
	Vec xx[N*2];
	vrawSqr<N>(xx, x);
	uvmont(z, xx);
}

// out = c ? a : b
inline void select(Unit *out, bool c, const Unit *a, const Unit *b)
{
	const Unit *o = c ? a : b;
	for (size_t i = 0; i < N; i++) {
		out[i] = o[i];
	}
}

inline Vec getUnitAt(const Vec *x, size_t xN, size_t bitPos)
{
	const size_t bitSize = 64;
	const size_t q = bitPos / bitSize;
	const size_t r = bitPos % bitSize;
	if (r == 0) return x[q];
	if (q == xN - 1) return vpsrlq(x[q], r);
	return vporq(vpsrlq(x[q], r), vpsllq(x[q+1], bitSize - r));
}

/*
	 |64   |64   |64   |64   |64    |64   |
	x|52:12|40:24|28:36|16:48|4:52:8|44:20|
    y|52|52   |52   |52   |52  |52|52  |20|
*/
inline void split52bit(Vec y[8], const Vec x[6])
{
	assert(&y != &x);
	y[0] = vpandq(x[0], G::mask());
	y[1] = vpandq(vporq(vpsrlq(x[0], 52), vpsllq(x[1], 12)), G::mask());
	y[2] = vpandq(vporq(vpsrlq(x[1], 40), vpsllq(x[2], 24)), G::mask());
	y[3] = vpandq(vporq(vpsrlq(x[2], 28), vpsllq(x[3], 36)), G::mask());
	y[4] = vpandq(vporq(vpsrlq(x[3], 16), vpsllq(x[4], 48)), G::mask());
	y[5] = vpandq(vpsrlq(x[4], 4), G::mask());
	y[6] = vpandq(vporq(vpsrlq(x[4], 56), vpsllq(x[5], 8)), G::mask());
	y[7] = vpsrlq(x[5], 44);
}

/*
	 |52|52   |52   |52   |52  |52|52  |20|
	x|52|12:40|24:28|36:16|48:4|52|8:44|20|
    y|64   |64   |64   |64   |64    |64
*/
inline void concat52bit(Vec y[6], const Vec x[8])
{
	assert(&y != &x);
	y[0] = vporq(x[0], vpsllq(x[1], 52));
	y[1] = vporq(vpsrlq(x[1], 12), vpsllq(x[2], 40));
	y[2] = vporq(vpsrlq(x[2], 24), vpsllq(x[3], 28));
	y[3] = vporq(vpsrlq(x[3], 36), vpsllq(x[4], 16));
	y[4] = vporq(vporq(vpsrlq(x[4], 48), vpsllq(x[5], 4)), vpsllq(x[6], 56));
	y[5] = vporq(vpsrlq(x[6], 8), vpsllq(x[7], 44));
}

/*
	384bit = 6U (U=64)
	G1(=6U x 3(x, y, z)) x 8 => 8Ux8x3
*/
static CYBOZU_ALIGN(64) uint64_t g_pickUpEc[8] = {
	18*0, 18*1, 18*2, 18*3, 18*4, 18*5, 18*6, 18*7,
};
static const Vec& v_pickUpEc = *(const Vec*)g_pickUpEc;
inline void cvt6Ux3x8to8Ux8x3(Vec y[8*3], const Unit x[6*3*8])
{
	for (int j = 0; j < 3; j++) {
		Vec t[6];
		for (int i = 0; i < 6; i++) {
			t[i] = vpgatherqq(v_pickUpEc, x+j*6+i);
		}
		split52bit(&y[j*8], t);
	}
}

// EcM(=8Ux8x3) => G1(=6U x 3) x 8
inline void cvt8Ux8x3to6Ux3x8(Unit y[6*3*8], const Vec x[8*3])
{
	for (size_t j = 0; j < 3; j++) {
		Vec t[6];
		concat52bit(t, x+8*j);
		for (size_t i = 0; i < 6; i++) {
#if 1
			vpscatterqq(y+j*6+i, v_pickUpEc, t[i]);
#else
			const Unit *pt = (const Unit *)t;
			for (size_t k = 0; k < 8; k++) {
				y[j*6+k*18+i] = pt[k+i*8];
			}
#endif
		}
	}
}

// Fr x 8 = U4x8 => Vec(U8) x 4
inline void cvt4Ux8to8Ux4(Vec y[4], const Unit x[4*8])
{
	const size_t w = 4;
	for (size_t j = 0; j < M; j++) {
		for (size_t i = 0; i < w; i++) {
			((Unit *)y)[i*M+j] = x[j*w+i];
		}
	}
}

static const CYBOZU_ALIGN(64) uint64_t g_pickUpFp[8] = {
	6*0, 6*1, 6*2, 6*3, 6*4, 6*5, 6*6, 6*7,
};
static const Vec& v_pickUpFp = *(const Vec*)g_pickUpFp;
// FpM(8Ux8) => Fp(=6U) x 8
inline void cvt8Ux8to6Ux8(Unit y[6*8], const Vec x[8])
{
	Vec t[6];
	concat52bit(t, x);
	for (size_t i = 0; i < 6; i++) {
		vpscatterqq(y+i, v_pickUpFp, t[i]);
	}
}
// Fp(=6U)x8 => FpM(8Ux8)
inline void cvt6Ux8to8Ux8(Vec y[8], const Unit x[6*8])
{
	Vec t[6];
	for (int i = 0; i < 6; i++) {
		t[i] = vpgatherqq(v_pickUpFp, x+i);
	}
	split52bit(y, t);
}

struct FpM {
	Vec v[N];
	static const FpM& zero() { return *(const FpM*)g_zero_; }
	static const FpM& one() { return *(const FpM*)g_R_; }
	static const FpM& R2() { return *(const FpM*)g_R2_; }
	static const FpM& rawOne() { return *(const FpM*)g_rawOne_; }
	static const FpM& m64to52() { return *(const FpM*)g_m64to52_; }
	static const FpM& m52to64() { return *(const FpM*)g_m52to64_; }
	static const FpM& rw() { return *(const FpM*)g_rw_; }
	static void add(FpM& z, const FpM& x, const FpM& y)
	{
		uvadd(z.v, x.v, y.v);
	}
	static void mul2(FpM& z, const FpM& x)
	{
		add(z, x, x);
	}
	static void sub(FpM& z, const FpM& x, const FpM& y)
	{
		uvsub(z.v, x.v, y.v);
	}
	static void neg(FpM& z, const FpM& x)
	{
		FpM::sub(z, zero(), x);
//		uvneg(z.v, x.v);
	}
	static void mul(FpM& z, const FpM& x, const FpM& y)
	{
		uvmul(z.v, x.v, y.v);
	}
	static void sqr(FpM& z, const FpM& x)
	{
//		uvsqr(z.v, x.v); // slow
		mul(z, x, x);
	}
	void toMont(FpM& x) const
	{
		mul(x, *this, R2());
	}
	void fromMont(const FpM &x)
	{
		mul(*this, x, rawOne());
	}
	void clear()
	{
		memset(this, 0, sizeof(*this));
	}
	bool operator==(const FpM& rhs) const
	{
		for (size_t i = 0; i < N; i++) {
			if (memcmp(&v[i], &rhs.v[i], sizeof(Vec)) != 0) return false;
		}
		return true;
	}
	bool operator!=(const FpM& rhs) const { return !operator==(rhs); }
	Vmask isEqualAll(const FpM& rhs) const
	{
		Vec t = vpxorq(v[0], rhs.v[0]);
		for (size_t i = 1; i < M; i++) {
			t = vporq(t, vpxorq(v[i], rhs.v[i]));
		}
		return vpcmpeqq(t, vzero());
	}
	Vmask isZero() const
	{
		Vec t = v[0];
		for (size_t i = 1; i < M; i++) {
			t = vporq(t, v[i]);
		}
		return vpcmpeqq(t, vzero());
	}
	static void pow(FpM& z, const FpM& x, const Vec *y, size_t yn)
	{
		const int w = 4;
		assert(w == 4);
		const int tblN = 1<<w;
		FpM tbl[tblN];
		tbl[0] = FpM::one();
		tbl[1] = x;
		for (size_t i = 2; i < tblN; i++) {
			mul(tbl[i], tbl[i-1], x);
		}
		const size_t bitLen = sizeof(Unit)*8;
		const size_t jn = bitLen / w;
		z = tbl[0];
		const Vec mask4 = vpbroadcastq(getMask(4));
		for (size_t i = 0; i < yn; i++) {
			const Vec& v = y[yn-1-i];
			for (size_t j = 0; j < jn; j++) {
				for (int k = 0; k < w; k++) FpM::sqr(z, z);
				Vec idx = vpandq(vpsrlq(v, bitLen-w-j*w), mask4);
				idx = vpsllq(idx, 6); // 512 B = 64 Unit
				idx = vpaddq(idx, G::offset());
				FpM t;
				for (size_t k = 0; k < N; k++) {
					t.v[k] = vpgatherqq(idx, &tbl[0].v[k]);
				}
				mul(z, z, t);
			}
		}
	}
	void setFp(const Unit *v)
	{
		Unit v8[6*8];
		for (size_t i = 0; i < 8; i++) {
			mcl::bint::copyT<6>(v8+i*6, v);
		}
		cvt6Ux8to8Ux8(this->v, v8);
		FpM::mul(*this, *this, FpM::m64to52());
	}
	void setFp(const mcl::msm::FpA v[M])
	{
		cvt6Ux8to8Ux8(this->v, v[0].v);
		FpM::mul(*this, *this, FpM::m64to52());
	}
	void getFp(mcl::msm::FpA v[M]) const
	{
		FpM t;
		FpM::mul(t, *this, FpM::m52to64());
		cvt8Ux8to6Ux8((Unit*)v, t.v);
	}
	FpM neg() const
	{
		FpM t;
		FpM::sub(t, zero(), *this);
		return t;
	}
	static void inv(FpM& z, const FpM& x)
	{
		mcl::msm::FpA v[M];
		x.getFp(v);
		g_func.invVecFp(v, v, M, M);
		z.setFp(v);
	}
	// condition set (set x if c)
	void cset(const Vmask& c, const FpM& x)
	{
		for (size_t i = 0; i < N; i++) {
			v[i] = vselect(c, x.v[i], v[i]);
		}
	}
	// return c ? a : b;
	static FpM select(const Vmask& c, const FpM& a, const FpM& b)
	{
		FpM d;
		for (size_t i = 0; i < N; i++) {
			d.v[i] = vselect(c, a.v[i], b.v[i]);
		}
		return d;
	}
#ifdef MCL_MSM_TEST
	void dump(size_t pos, const char *msg = nullptr) const;
	void set(const mpz_class& x, size_t i);
	void set(const mpz_class& x);
	mpz_class getRaw(size_t i) const;
	mpz_class get(size_t i) const;
#endif
};


template<class E, size_t n>
inline void normalizeJacobiVec(E P[n])
{
	assert(n >= 2);
	typedef typename E::Fp F;
	F tbl[n];
	tbl[0] = F::select(P[0].z.isZero(), F::one(), P[0].z);
	for (size_t i = 1; i < n; i++) {
		F t = F::select(P[i].z.isZero(), F::one(), P[i].z);
		F::mul(tbl[i], tbl[i-1], t);
	}
	F r;
	F::inv(r, tbl[n-1]);
	for (size_t i = 0; i < n; i++) {
		size_t pos = n-1-i;
		F& z = P[pos].z;
		F rz, rz2;
		if (pos == 0) {
			rz = r;
		} else {
			F::mul(rz, r, tbl[pos-1]);
			F::mul(r, r, F::select(z.isZero(), F::one(), z));
		}
		F::sqr(rz2, rz);
		F::mul(P[pos].x, P[pos].x, rz2); // xz^-2
		F::mul(rz2, rz2, rz);
		F::mul(P[pos].y, P[pos].y, rz2); // yz^-3
		z = F::select(z.isZero(), z, F::one());
	}
}

// 8M+3S+7A
// assume P.x != Q.x, P != Q
// asseume all Q are normalized
template<class E>
inline void addJacobiMixedNoCheck(E& R, const E& P, const E& Q)
{
	typedef typename E::Fp F;
	F r, U1, S1, H, H3;
	F::sqr(r, P.z);
	U1 = P.x;
	F::mul(H, Q.x, r);
	F::sub(H, H, U1);
	S1 = P.y;
	F::mul(r, r, P.z);
	F::mul(r, r, Q.y);
	F::sub(r, r, S1);
	F::mul(R.z, P.z, H);
	F::sqr(H3, H); // H^2
	F::sqr(R.y, r); // r^2
	F::mul(U1, U1, H3); // U1 H^2
	F::mul(H3, H3, H); // H^3
	F::sub(R.y, R.y, U1);
	F::sub(R.y, R.y, U1);
	F::sub(R.x, R.y, H3);
	F::sub(U1, U1, R.x);
	F::mul(U1, U1, r);
	F::mul(H3, H3, S1);
	F::sub(R.y, U1, H3);
}

// 12M+4S+7A
// P == Q or P == -Q then R = 0, so assume P != Q.
template<class E>
inline void addJacobiNoCheck(E& R, const E& P, const E& Q)
{
	typedef typename E::Fp F;
	F r, U1, S1, H, H3;
	F::sqr(r, P.z);
	F::sqr(S1, Q.z);
	F::mul(U1, P.x, S1);
	F::mul(H, Q.x, r);
	F::sub(H, H, U1);
	F::mul(S1, S1, Q.z);
	F::mul(S1, S1, P.y);
	F::mul(r, r, P.z);
	F::mul(r, r, Q.y);
	F::sub(r, r, S1);
	F::mul(R.z, P.z, Q.z);
	F::mul(R.z, R.z, H);
	F::sqr(H3, H); // H^2
	F::sqr(R.y, r); // r^2
	F::mul(U1, U1, H3); // U1 H^2
	F::mul(H3, H3, H); // H^3
	F::sub(R.y, R.y, U1);
	F::sub(R.y, R.y, U1);
	F::sub(R.x, R.y, H3);
	F::sub(U1, U1, R.x);
	F::mul(U1, U1, r);
	F::mul(H3, H3, S1);
	F::sub(R.y, U1, H3);
}

// assume a = 0
// 3M+4S+12A
template<class E>
inline void dblJacobiNoCheck(E& R, const E& P)
{
	typedef typename E::Fp F;
	F x2, y2, xy, t;
	F::sqr(x2, P.x);
	F::sqr(y2, P.y);
	F::mul(xy, P.x, y2);
	F::mul2(xy, xy);
	F::sqr(y2, y2);
	F::mul2(xy, xy); // 4xy^2
	F::mul2(t, x2);
	F::add(x2, x2, t);
	F::sqr(R.x, x2);
	F::sub(R.x, R.x, xy);
	F::sub(R.x, R.x, xy);
	F::mul(R.z, P.y, P.z);
	F::mul2(R.z, R.z);
	F::sub(R.y, xy, R.x);
	F::mul(R.y, R.y, x2);
	F::mul2(y2, y2);
	F::mul2(y2, y2);
	F::mul2(y2, y2);
	F::sub(R.y, R.y, y2);
}

struct EcM {
	typedef FpM Fp;
	static const int a_ = 0;
	static const int b_ = 4;
	static const int specialB_ = mcl::ec::local::Plus4;
	static const FpM &b3_;
	static const EcM &zeroProj_;
	static const EcM &zeroJacobi_;
	FpM x, y, z;
	template<bool isProj=true, bool mixed=false>
	static void add(EcM& z, const EcM& x, const EcM& y)
	{
		if (isProj) {
			mcl::ec::addCTProj(z, x, y);
		} else {
			EcM t;
			if (mixed) {
				addJacobiMixedNoCheck(t, x, y);
			} else {
				addJacobiNoCheck(t, x, y);
			}
			t = select(x.isZero(), y, t);
			z = select(y.isZero(), x, t);
		}
	}
	template<bool isProj=true>
	static void dbl(EcM& z, const EcM& x)
	{
		if (isProj) {
			mcl::ec::dblCTProj(z, x);
		} else {
			dblJacobiNoCheck(z, x);
		}
	}
	static EcM select(const Vmask& c, const EcM& a, const EcM& b)
	{
		EcM d;
		d.x = FpM::select(c, a.x, b.x);
		d.y = FpM::select(c, a.y, b.y);
		d.z = FpM::select(c, a.z, b.z);
		return d;
	}
	template<bool isProj=true>
	static const EcM& zero()
	{
		return isProj ? zeroProj_ : zeroJacobi_;
	}
	template<bool isProj=true>
	void clear()
	{
		*this = zero<isProj>();
	}
	void setArray(const Unit a[6*3*M])
	{
		cvt6Ux3x8to8Ux8x3(x.v, a);
	}
	void getArray(Unit a[6*3*M]) const
	{
		cvt8Ux8x3to6Ux3x8(a, x.v);
	}
	void setG1(const mcl::msm::G1A v[M], bool JacobiToProj = true)
	{
		setArray(v[0].v);
		FpM::mul(x, x, FpM::m64to52());
		FpM::mul(y, y, FpM::m64to52());
		FpM::mul(z, z, FpM::m64to52());
		if (JacobiToProj) {
			mcl::ec::JacobiToProj(*this, *this);
			y = FpM::select(z.isZero(), FpM::one(), y);
		}
	}
	void getG1(mcl::msm::G1A v[M], bool ProjToJacobi = true) const
	{
		EcM T = *this;
		if (ProjToJacobi) mcl::ec::ProjToJacobi(T, T);
		FpM::mul(T.x, T.x, FpM::m52to64());
		FpM::mul(T.y, T.y, FpM::m52to64());
		FpM::mul(T.z, T.z, FpM::m52to64());
		T.getArray(v[0].v);
	}
	void normalize()
	{
		FpM r;
		FpM::inv(r, z);
		FpM::mul(x, x, r);
		FpM::mul(y, y, r);
		z = FpM::one();
	}
	template<bool isProj=true, bool mixed=false>
	static void makeTable(EcM *tbl, size_t tblN, const EcM& P)
	{
		tbl[0].clear<isProj>();
		tbl[1] = P;
		dbl<isProj>(tbl[2], P);
		for (size_t i = 3; i < tblN; i++) {
			if (i & 1) {
				add<isProj, mixed>(tbl[i], tbl[i-1], P);
			} else {
				dbl<isProj>(tbl[i], tbl[i/2]);
			}
		}
	}
	void gather(const EcM *tbl, Vec idx)
	{
		const Vec i192 = vpbroadcastq(192);
		idx = vmulL(idx, i192, G::offset());
		for (size_t i = 0; i < N; i++) {
			x.v[i] = vpgatherqq(idx, &tbl[0].x.v[i]);
			y.v[i] = vpgatherqq(idx, &tbl[0].y.v[i]);
			z.v[i] = vpgatherqq(idx, &tbl[0].z.v[i]);
		}
	}
	void scatter(EcM *tbl, Vec idx) const
	{
		const Vec i192 = vpbroadcastq(192);
		idx = vmulL(idx, i192, G::offset());
		for (size_t i = 0; i < N; i++) {
			vpscatterqq(&tbl[0].x.v[i], idx, x.v[i]);
			vpscatterqq(&tbl[0].y.v[i], idx, y.v[i]);
			vpscatterqq(&tbl[0].z.v[i], idx, z.v[i]);
		}
	}
	static void mulLambda(EcM& Q, const EcM& P)
	{
		FpM::mul(Q.x, P.x, FpM::rw());
		Q.y = P.y;
		Q.z = P.z;
	}
	static void neg(EcM& Q, const EcM& P)
	{
		Q.x = P.x;
		FpM::neg(Q.y, P.y);
		Q.z = P.z;
	}
#if 0
	// Treat idx as an unsigned integer
	// 33.6M clk
	template<bool isProj=true, bool mixed=false>
	static void mulGLV(EcM& Q, const EcM& P, const Vec y[4])
	{
		const size_t w = 4;
		const size_t tblN = 1<<w;
		// QQQ (n=1024) isProj=T : 36.8, isProj=F&&mixed=F : 36.0, isProj=F&&mixed=T : 34.6
		Vec a[2], b[2];
		EcM tbl1[tblN], tbl2[tblN];
		makeTable<isProj, mixed>(tbl1, tblN, P);
		if (!isProj && mixed) normalizeJacobiVec<EcM, tblN-1>(tbl1+1);
		for (size_t i = 0; i < tblN; i++) {
			mulLambda(tbl2[i], tbl1[i]);
		}
		const Unit *src = (const Unit*)y;
		Unit *pa = (Unit*)a;
		Unit *pb = (Unit*)b;
		for (size_t i = 0; i < M; i++) {
			Unit buf[4] = { src[i+M*0], src[i+M*1], src[i+M*2], src[i+M*3] };
			Unit aa[2], bb[2];
			mcl::ec::local::optimizedSplitRawForBLS12_381(aa, bb, buf);
			pa[i+M*0] = aa[0]; pa[i+M*1] = aa[1];
			pb[i+M*0] = bb[0]; pb[i+M*1] = bb[1];
		}
		const size_t bitLen = 128;
		Vec mask = vpbroadcastq((1<<w)-1);
		bool first = true;
		size_t pos = bitLen;
		for (size_t i = 0; i < (bitLen + w-1)/w; i++) {
			size_t dblN = w;
			if (pos < w) {
				mask = vpbroadcastq((1<<pos)-1);
				dblN = pos;
				pos = 0;
			} else {
				pos -= w;
			}
			if (!first) for (size_t k = 0; k < dblN; k++) EcM::dbl<isProj>(Q, Q);
			EcM T;
			Vec idx;
			idx = vpandq(getUnitAt(b, 2, pos), mask);
			if (first) {
				Q.gather(tbl2, idx);
				first = false;
			} else {
				T.gather(tbl2, idx);
				add<isProj, mixed>(Q, Q, T);
			}
			idx = vpandq(getUnitAt(a, 2, pos), mask);
			T.gather(tbl1, idx);
			add<isProj, mixed>(Q, Q, T);
		}
	}
#else
//#define SIGNED_TABLE // a little slower (32.1Mclk->32.4Mclk)
	template<size_t bitLen, size_t w>
	static void makeNAFtbl(Vec *idxTbl, Vmask *negTbl, const Vec a[2])
	{
		const Vec mask = vpbroadcastq((1<<w)-1);
#ifdef SIGNED_TABLE
		(void)negTbl;
#else
		const Vec F = vpbroadcastq(1<<w);
#endif
		const Vec H = vpbroadcastq(1<<(w-1));
		const Vec one = vpbroadcastq(1);
		size_t pos = 0;
		Vec CF = vzero();
		const size_t n = (bitLen+w-1)/w;
		for (size_t i = 0; i < n; i++) {
			Vec idx = getUnitAt(a, 2, pos);
			idx = vpandq(idx, mask);
			idx = vpaddq(idx, CF);
#ifdef SIGNED_TABLE
			Vec masked = vpandq(idx, mask);
			Vmask v = vpcmpgtq(masked, H);
			idxTbl[i] = masked; //vselect(negTbl[i], vpsubq(F, masked), masked); // idx >= H ? F - idx : idx;
			CF = vpsrlq(idx, w);
			CF = vpaddq(v, CF, one);
#else
			Vec masked = vpandq(idx, mask);
			negTbl[i] = vpcmpgtq(masked, H);
			idxTbl[i] = vselect(negTbl[i], vpsubq(F, masked), masked); // idx >= H ? F - idx : idx;
			CF = vpsrlq(idx, w);
			CF = vpaddq(negTbl[i], CF, one);
#endif
			pos += w;
		}
	}
	// Treat idx as a signed integer
	// 32.4M clk
	template<bool isProj=true, bool mixed=false>
	static void mulGLV(EcM& Q, const EcM& P, const Vec y[4])
	{
		const size_t w = 5;
		const size_t halfN = (1<<(w-1))+1; // [0, 2^(w-1)]
#ifdef SIGNED_TABLE
		const size_t tblN = 1<<w;
#else
		const size_t tblN = halfN;
#endif
		Vec a[2], b[2];
		EcM tbl1[tblN], tbl2[tblN];
		makeTable<isProj, mixed>(tbl1, halfN, P);
		if (!isProj && mixed) normalizeJacobiVec<EcM, halfN-1>(tbl1+1);
		for (size_t i = 0; i < halfN; i++) {
			mulLambda(tbl2[i], tbl1[i]);
		}
#ifdef SIGNED_TABLE
		for (size_t i = halfN; i < tblN; i++) {
			EcM::neg(tbl1[i], tbl1[tblN-i]);
			EcM::neg(tbl2[i], tbl2[tblN-i]);
		}
#endif
		const Unit *src = (const Unit*)y;
		Unit *pa = (Unit*)a;
		Unit *pb = (Unit*)b;
		for (size_t i = 0; i < M; i++) {
			Unit buf[4] = { src[i+M*0], src[i+M*1], src[i+M*2], src[i+M*3] };
			Unit aa[2], bb[2];
			mcl::ec::local::optimizedSplitRawForBLS12_381(aa, bb, buf);
			pa[i+M*0] = aa[0]; pa[i+M*1] = aa[1];
			pb[i+M*0] = bb[0]; pb[i+M*1] = bb[1];
		}
		const size_t bitLen = 128;
		const size_t n = (bitLen + w-1)/w;
		Vec aTbl[n], bTbl[n];
		Vmask aNegTbl[n], bNegTbl[n];
		makeNAFtbl<bitLen, w>(aTbl, aNegTbl, a);
		makeNAFtbl<bitLen, w>(bTbl, bNegTbl, b);

		for (size_t i = 0; i < n; i++) {
			if (i > 0) for (size_t k = 0; k < w; k++) EcM::dbl<isProj>(Q, Q);
			const size_t pos = n-1-i;

			EcM T;
			Vec idx = bTbl[pos];
			T.gather(tbl2, idx);
#ifndef SIGNED_TABLE
			T.y = FpM::select(bNegTbl[pos], T.y.neg(), T.y);
#endif
			if (i == 0) {
				Q = T;
			} else {
				add<isProj, mixed>(Q, Q, T);
			}
			idx = aTbl[pos];
			T.gather(tbl1, idx);
#ifndef SIGNED_TABLE
			T.y = FpM::select(aNegTbl[pos], T.y.neg(), T.y);
#endif
			add<isProj, mixed>(Q, Q, T);
		}
	}
#endif
	void cset(const Vmask& c, const EcM& v)
	{
		x.cset(c, v.x);
		y.cset(c, v.y);
		z.cset(c, v.z);
	}
	Vmask isZero() const
	{
		return z.isZero();
	}
	Vmask isEqualJacobiAll(const EcM& rhs) const
	{
		FpM s1, s2, t1, t2;
		Vmask v1, v2;
		FpM::sqr(s1, z);
		FpM::sqr(s2, rhs.z);
		FpM::mul(t1, x, s2);
		FpM::mul(t2, rhs.x, s1);
		v1 = t1.isEqualAll(t2);
		FpM::mul(t1, y, s2);
		FpM::mul(t2, rhs.y, s1);
		FpM::mul(t1, t1, rhs.z);
		FpM::mul(t2, t2, z);
		v2 = t1.isEqualAll(t2);
		return kandb(v1, v2);
	}
#ifdef MCL_MSM_TEST
	void dump(bool isProj, size_t pos, const char *msg = nullptr) const;
#endif
};

const FpM& EcM::b3_ = *(const FpM*)g_b3_;
const EcM& EcM::zeroProj_ = *(const EcM*)g_zeroProj_;
const EcM& EcM::zeroJacobi_ = *(const EcM*)g_zeroJacobi_;

inline void reduceSum(mcl::msm::G1A& Q, const EcM& P)
{

	mcl::msm::G1A z[8];
	P.getG1(z);
	Q = z[0];
	for (int i = 1; i < 8; i++) {
		g_func.addG1(Q, Q, z[i]);
	}
}

inline void cvtFr8toVec4(Vec yv[4], const mcl::msm::FrA y[8])
{
	Unit ya[4*8];
	for (size_t i = 0; i < 8; i++) {
		g_func.fr->fromMont(ya+i*4, y[i].v);
	}
	cvt4Ux8to8Ux4(yv, ya);
}

// xVec[n], yVec[n * maxBitSize/64]
// assume xVec[] is normalized
inline void mulVecAVX512_inner(mcl::msm::G1A& P, const EcM *xVec, const Vec *yVec, size_t n, size_t maxBitSize)
{
	size_t c = mcl::ec::argminForMulVec(n);
	size_t tblN = size_t(1) << c;
	EcM *tbl = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * tblN, 64);
	const size_t yn = maxBitSize / 64;
	const size_t winN = (maxBitSize + c-1) / c;
	EcM *win = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * winN, 64);

	const Vec m = vpbroadcastq(tblN-1);
	for (size_t w = 0; w < winN; w++) {
		for (size_t i = 0; i < tblN; i++) {
			tbl[i].clear();
		}
		for (size_t i = 0; i < n; i++) {
			Vec v = getUnitAt(yVec+i*yn, yn, c*w);
			v = vpandq(v, m);
			EcM T;
			T.gather(tbl, v);
			EcM::add(T, T, xVec[i]);
			T.scatter(tbl, v);
		}
		EcM sum = tbl[tblN - 1];
		win[w] = sum;
		for (size_t i = 1; i < tblN - 1; i++) {
			EcM::add(sum, sum, tbl[tblN - 1- i]);
			EcM::add(win[w], win[w], sum);
		}
	}
	EcM T = win[winN - 1];
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < c; i++) {
			EcM::dbl(T, T);
		}
		EcM::add(T, T, win[winN - 1- w]);
	}
	reduceSum(P, T);
	Xbyak::AlignedFree(win);
	Xbyak::AlignedFree(tbl);
}

} // namespace

namespace mcl { namespace msm {

void mulVecAVX512(Unit *_P, Unit *_x, const Unit *_y, size_t n)
{
	G1A& P = *(G1A*)_P;
	mcl::msm::G1A *x = (mcl::msm::G1A*)_x;
	const mcl::msm::FrA *y = (const mcl::msm::FrA*)_y;
	const size_t n8 = n/8;
	const mcl::fp::Op *fr = g_func.fr;
#if 1
//	mcl::ec::normalizeVec(x, x, n);
	EcM *xVec = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * n8 * 2, 64);
	for (size_t i = 0; i < n8; i++) {
		xVec[i*2].setG1(x+i*8);
		EcM::mulLambda(xVec[i*2+1], xVec[i*2]);
	}
	Vec *yVec = (Vec*)Xbyak::AlignedMalloc(sizeof(Vec) * n8 * 4, 64);
	Unit *py = (Unit*)yVec;
	for (size_t i = 0; i < n8; i++) {
		for (size_t j = 0; j < 8; j++) {
			Unit ya[4];
			fr->fromMont(ya, y[i*8+j].v);
			Unit a[2], b[2];
			mcl::ec::local::optimizedSplitRawForBLS12_381(a, b, ya);
			py[j+0] = a[0];
			py[j+8] = a[1];
			py[j+16] = b[0];
			py[j+24] = b[1];
		}
		py += 32;
	}
	mulVecAVX512_inner(P, xVec, yVec, n8*2, 128);
#else
	EcM *xVec = (EcM*)Xbyak::AlignedMalloc(sizeof(EcM) * n8, 64);
	for (size_t i = 0; i < n8; i++) {
		xVec[i].setG1(x+i*8);
	}
	Vec *yVec = (Vec*)Xbyak::AlignedMalloc(sizeof(Vec) * n8 * 4, 64);
	for (size_t i = 0; i < n8; i++) {
		cvtFr8toVec4(yVec+i*4, y+i*8);
	}
	mulVecAVX512_inner(P, xVec, yVec, n8, 256);
#endif
	Xbyak::AlignedFree(yVec);
	Xbyak::AlignedFree(xVec);
	const bool constTime = false;
	for (size_t i = n8*8; i < n; i++) {
		mcl::msm::G1A Q;
		g_func.mulG1(Q, x[i], y[i], constTime);
		g_func.addG1(P, P, Q);
	}
}

void mulEachAVX512(Unit *_x, const Unit *_y, size_t n)
{
	assert(n % 8 == 0);
	const bool isProj = false;
	const bool mixed = true;
	mcl::msm::G1A *x = (mcl::msm::G1A*)_x;
	const mcl::msm::FrA *y = (const mcl::msm::FrA*)_y;
	if (!isProj && mixed) g_func.normalizeVecG1(x, x, n);
	for (size_t i = 0; i < n; i += 8) {
		EcM P;
		Vec yv[4];
		cvtFr8toVec4(yv, y+i);
		P.setG1(x+i, isProj);
		EcM::mulGLV<isProj, mixed>(P, P, yv);
		P.getG1(x+i, isProj);
	}
}

bool initMsm(const mcl::CurveParam& cp, const mcl::msm::Func *func)
{
	assert(EcM::a_ == 0);
	assert(EcM::b_ == 4);
	(void)EcM::a_; // disable unused warning
	(void)EcM::b_;

	if (cp != mcl::BLS12_381) return false;
	Xbyak::util::Cpu cpu;
	if (!cpu.has(Xbyak::util::Cpu::tAVX512_IFMA)) return false;
	g_func = *func;
	return true;
}

} } // mcl::msm

#ifdef MCL_MSM_TEST
#include <mcl/bls12_381.hpp>
#include <cybozu/test.hpp>
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

using namespace mcl::bn;

template<size_t N, int w = W>
inline void toArray(Unit x[N], const mpz_class& mx)
{
	const Unit mask = getMask(w);
	Unit tmp[N];
	bool b;
	mcl::gmp::getArray(&b, tmp, N, mx);
	assert(b); (void)b;
	for (size_t i = 0; i < N; i++) {
		x[i] = mcl::fp::getUnitAt(tmp, N, i*w) & mask;
	}
}

template<size_t N>
inline mpz_class fromArray(const Unit x[N])
{
	mpz_class mx;
	mcl::gmp::setUnit(mx, x[N-1]);
	for (size_t i = 1; i < N; i++) {
		mx <<= W;
		mcl::gmp::addUnit(mx, x[N-1-i]);
	}
	return mx;
}

class Montgomery {
	Unit v_[N];
public:
	mpz_class mp;
	mpz_class mR; // (1 << (N * 64)) % p
	mpz_class mR2; // (R * R) % p
	Unit rp; // rp * p = -1 mod M = 1 << 64
	const Unit *p;
	bool isFullBit;
	Montgomery() {}
	static Unit getLow(const mpz_class& x)
	{
		if (x == 0) return 0;
		return mcl::gmp::getUnit(x, 0) & g_mask;
	}
	void init(const mpz_class& _p)
	{
		mp = _p;
		mR = 1;
		mR = (mR << (W * N)) % mp;
		mR2 = (mR * mR) % mp;
		toArray<N>(v_, _p);
		rp = mcl::bint::getMontgomeryCoeff(v_[0], W);
		p = v_;
		isFullBit = p[N-1] >> (W-1);
	}

	mpz_class toMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, mR2);
		return y;
	}
	mpz_class fromMont(const mpz_class& x) const
	{
		mpz_class y;
		mul(y, x, 1);
		return y;
	}

	void mul(mpz_class& z, const mpz_class& x, const mpz_class& y) const
	{
		mod(z, x * y);
	}
	void mod(mpz_class& z, const mpz_class& xy) const
	{
		z = xy;
		mpz_class t;
		for (size_t i = 0; i < N; i++) {
			Unit q = (getLow(z) * rp) & g_mask;
			mcl::gmp::setUnit(t, q);
			z += mp * t;
			z >>= W;
		}
		if (z >= mp) {
			z -= mp;
		}
	}
};

static Montgomery g_mont;

void FpM::dump(size_t pos, const char *msg) const
{
	Fp T[8];
	getFp((mcl::msm::FpA*)T);
	if (msg) printf("%s\n", msg);
	printf("  [%zd]=%s\n", pos, T[pos].getStr(16).c_str());
}

void FpM::set(const mpz_class& x, size_t i)
{
	mpz_class r = g_mont.toMont(x);
	Unit rv[N];
	toArray<N>(rv, r);
	::set(v, i, rv);
}
void FpM::set(const mpz_class& x)
{
	mpz_class r = g_mont.toMont(x);
	Unit rv[N];
	toArray<N>(rv, r);
	for (size_t i = 0; i < M; i++) {
		::set(v, i, rv);
	}
}
mpz_class FpM::getRaw(size_t i) const
{
	Unit x[N];
	::get(x, v, i);
	return fromArray<N>(x);
}
mpz_class FpM::get(size_t i) const
{
	mpz_class r = getRaw(i);
	return g_mont.fromMont(r);
}

void EcM::dump(bool isProj, size_t pos, const char *msg) const
{
	G1 T[8];
	getG1((mcl::msm::G1A*)T, isProj);
	if (msg) printf("%s\n", msg);
	printf("  [%zd]=%s\n", pos, T[pos].getStr(16|mcl::IoEcProj).c_str());
//	printf("  [%zd]=%s\n", pos, T[pos].getStr(16|mcl::IoEcAffine).c_str());
}

template<size_t n=N>
inline void vrawAdd(VecA *z, const VecA *x, const VecA *y)
{
	VecA t = vpaddq(x[0], y[0]);
	VecA c = vpsrlq(t, W);
	z[0] = vpandq(t, G::mask());

	for (size_t i = 1; i < n; i++) {
		t = vpaddq(x[i], y[i]);
		t = vpaddq(t, c);
		if (i == n-1) {
			z[i] = t;
			return;
		}
		c = vpsrlq(t, W);
		z[i] = vpandq(t, G::mask());
	}
}

struct FpMA {
	VecA v[N];
};

void cvtFpM2FpMA(FpMA& y, const FpM x[vN])
{
	for (size_t i = 0; i < vN; i++) {
		for (size_t j = 0; j < N; j++) {
			y.v[j].v[i] = x[i].v[j];
		}
	}
}

void cvtFpMA2FpM(FpM y[vN], const FpMA& x)
{
	for (size_t i = 0; i < vN; i++) {
		for (size_t j = 0; j < N; j++) {
			y[i].v[j] = x.v[j].v[i];
		}
	}
}

CYBOZU_TEST_AUTO(init)
{
	initPairing(mcl::BLS12_381);
	g_mont.init(mcl::bn::Fp::getOp().mp);
}

void setParam(G1 *P, Fr *x, size_t n, cybozu::XorShift& rg)
{
	for (size_t i = 0; i < n; i++) {
		uint32_t v = rg.get32();
		hashAndMapToG1(P[i], &v, sizeof(v));
		if (x) x[i].setByCSPRNG(rg);
	}
}

CYBOZU_TEST_AUTO(cmp)
{
	const size_t n = 8;
	Vmask v;
	FpM x, y;
	x.clear();
	v = x.isEqualAll(x);
	CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff);
	for (size_t i = 0; i < n; i++) {
		y.clear();
		y.set(1, i);
		v = x.isEqualAll(y);
		CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff ^ (1<<i));
	}
	G1 P[n];
	mcl::msm::G1A *PA = (mcl::msm::G1A*)P;

	EcM PM, QM;
	cybozu::XorShift rg;
	for (size_t i = 0; i < n; i++) {
		uint32_t v = rg.get32();
		hashAndMapToG1(P[i], &v, sizeof(v));
	}
	PM.setG1(PA);
	QM.setG1(PA);
	v = PM.isEqualJacobiAll(QM);
	CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff);
	for (size_t i = 0; i < n; i++) {
		QM = PM;
		QM.x.set(1, i);
		v = PM.isEqualJacobiAll(QM);
		CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff ^ (1<<i));
	}
}

CYBOZU_TEST_AUTO(conv)
{
	const int C = 16;
	FpM x1;
	mcl::bn::Fp x2[8], x3[8];
	cybozu::XorShift rg;
	for (int i = 0; i < C; i++) {
		for (int j = 0; j < 8; j++) {
			x2[j].setByCSPRNG(rg);
		}
		x1.setFp((const mcl::msm::FpA*)x2);
		x1.getFp((mcl::msm::FpA*)x3);
		CYBOZU_TEST_EQUAL_ARRAY(x2, x3, 8);
	}
	{
		FpM x[vN], y[vN];
		FpMA z;
		for (size_t i = 0; i < vN; i++) {
			for (int j = 0; j < 8; j++) {
				x2[j].setByCSPRNG(rg);
			}
			x[i].setFp((const mcl::msm::FpA*)x2);
		}
		cvtFpM2FpMA(z, x);
		cvtFpMA2FpM(y, z);
		for (size_t i = 0; i < vN; i++) {
			CYBOZU_TEST_ASSERT(x[i] == y[i]);
		}
	}
}

template<class T>
void lpN(void f(T&, const T&, const T&), T *z, const T *x, const T *y, size_t n)
{
	for (size_t i = 0; i < n; i++) f(z[i], x[i], y[i]);
}

CYBOZU_TEST_AUTO(op)
{
	const size_t n = 8; // fixed
	G1 P[n];
	G1 Q[n];
	G1 R[n];
	G1 T[n];
	Fr x[n];
	mcl::msm::G1A *PA = (mcl::msm::G1A*)P;
	mcl::msm::G1A *QA = (mcl::msm::G1A*)Q;
	mcl::msm::G1A *RA = (mcl::msm::G1A*)R;
	mcl::msm::G1A *TA = (mcl::msm::G1A*)T;

	EcM PM, QM, TM;
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	setParam(Q, x, n, rg);
	P[3].clear();
	Q[4].clear();
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_ASSERT(!P[i].z.isOne());
	}
	g_func.normalizeVecG1(RA, PA, n);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_ASSERT(R[i].z.isOne() || R[i].z.isZero());
	}
	CYBOZU_TEST_EQUAL_ARRAY(P, R, n);

	// test dbl
	// R = 2P
	for (size_t i = 0; i < n; i++) {
		G1::dbl(R[i], P[i]);
	}
	// as Proj
	PM.setG1(PA);
	EcM::dbl<true>(TM, PM);
	TM.getG1(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1(PA, false);
	EcM::dbl<false>(TM, PM);
	TM.getG1(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// test add
	// R = P + Q
	for (size_t i = 0; i < n; i++) {
		G1::add(R[i], P[i], Q[i]);
	}

	// as Proj
	PM.setG1(PA);
	QM.setG1(QA);
	EcM::add<true>(TM, PM, QM);
	TM.getG1(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1(PA, false);
	QM.setG1(QA, false);
	EcM::add<false>(TM, PM, QM);
	TM.getG1(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi (mixed)
	for (size_t i = 0; i < n; i++) {
		Q[i].normalize();
	}
	QM.setG1(QA, false);
	EcM::add<false, true>(TM, PM, QM);
	TM.getG1(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}
#if 1
	// mulEachAVX512
	for (int mode = 0; mode < 2; mode++) {
		for (int t = 0; t < 0x1000; t += 8) {
			for (size_t i = 0; i < n; i++) {
				Q[i] = P[i];
				switch (mode) {
				case 0: x[i] = t + i; break;
				case 1: x[i].setByCSPRNG(rg); break;
				}
				G1::mul(R[i], P[i], x[i]);
			}
			mcl::msm::mulEachAVX512((Unit*)Q, (const Unit*)x, n);
			for (size_t i = 0; i < n; i++) {
				CYBOZU_TEST_EQUAL(R[i], Q[i]);
			}
		}
	}
#endif
#ifdef NDEBUG
	{
		const int C = 10000;
		const size_t n = 128;
		FpM a[n], b[n];
		for (size_t i = 0; i < n; i++) {
			a[i] = PM.x;
			b[i] = PM.y;
		}
		CYBOZU_BENCH_C("add", C, FpM::add, a[0], a[0], b[0]);
		CYBOZU_BENCH_C("mul", C, FpM::mul, a[0], a[0], b[0]);
		CYBOZU_BENCH_C("addn", C, lpN, FpM::add, a, a, b, n);
		CYBOZU_BENCH_C("muln", C, lpN, FpM::mul, a, a, b, n);
	}
#endif
}

CYBOZU_TEST_AUTO(normalizeJacobiVec)
{
	const bool isProj = false;
	const size_t n = 64;
	G1 P[n], Q[n], R[n];
	EcM PP[n/8];
	cybozu::XorShift rg;
	setParam(P, 0, n, rg);
	P[n/2].clear();
	P[n/3].clear();
	mcl::ec::normalizeVec(Q, P, n);
	for (size_t i = 0; i < n/8; i++) {
		PP[i].setG1((mcl::msm::G1A*)&P[i*8], isProj);
	}
	normalizeJacobiVec<EcM, n/8>(PP);
	for (size_t i = 0; i < n/8; i++) {
		PP[i].getG1((mcl::msm::G1A*)&R[i*8], isProj);
	}
	CYBOZU_TEST_EQUAL_ARRAY(P, R, n);
}

CYBOZU_TEST_AUTO(mulEach_special)
{
	const size_t n = 8;
	G1 P[n], Q[n], R[n];
	Fr x[n];
	for (size_t i = 0; i < n; i++) P[i].clear();
	P[0].setStr("1 13de196893df2bb5b57882ff1eec37d98966aa71b828fd25125d04ed2c75ddc55d5bc68bd797bd555f9a827387ee6b28 5d59257a0fccd5215cdeb0928296a7a4d684823db76aef279120d2d71c4b54604ec885eb554f99780231ade171979a3", 16);
	x[0].setStr("5b4b92c347ffcd8543904dd1b22a60d94b4a9c243046456b8befd41507bec5d", 16);
//	x[0].setStr("457977620305299156129707153920788267006"); // L+L
	for (size_t i = 0; i < n; i++) Q[i] = P[i];
	G1::mul(R[0], P[0], x[0]);
	G1::mulEach(Q, x, 8);
	CYBOZU_TEST_EQUAL(R[0], Q[0]);
	mpz_class L;
	mcl::gmp::setStr(L, "0xac45a4010001a40200000000ffffffff");
	mpz_class tbl[] = {
		0,
		1,
		L,
	};
	cybozu::XorShift rg;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		const mpz_class& a = tbl[i];
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
			const mpz_class& b = tbl[j];
			setParam(P, x, n, rg);
			x[0].setMpz(a * L + b);
			for (size_t k = 0; k < 8; k++) {
				Q[k] = P[k];
				G1::mul(R[k], P[k], x[k]);
			}
			G1::mulEach(Q, x, n);
			CYBOZU_TEST_EQUAL_ARRAY(R, Q, n);
		}
	}
}

CYBOZU_TEST_AUTO(mulEach)
{
	const size_t n = 1024;
	G1 P[n], Q[n], R[n];
	Fr x[n];
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	if (n > 32) P[32].clear();
	P[n/2].clear();
	for (size_t i = 0; i < n; i++) {
		Q[i] = P[i];
		G1::mul(R[i], P[i], x[i]);
	}
	G1::mulEach(Q, x, n);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], Q[i]);
		if (R[i] != Q[i]) {
			printf("P[%zd]=%s\n", i, P[i].getStr(16).c_str());
			printf("x[%zd]=%s\n", i, x[i].getStr(16).c_str());
			printf("R[%zd]=%s\n", i, R[i].getStr(16|mcl::IoEcProj).c_str());
			printf("Q[%zd]=%s\n", i, Q[i].getStr(16|mcl::IoEcProj).c_str());
		}
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("mulEach", 100, G1::mulEach, Q, x, n);
#endif
}
#endif
