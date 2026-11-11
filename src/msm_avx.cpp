/**
	@file
	@brief multi scalar multiplication with AVX-512 IFMA
	the kernel is in msm_avx_impl.hpp, included twice : for G1 (mcl::msm) and for GG (Grumpkin, mcl::msm_gg, only if MCL_FP_BIT=256)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#ifdef _MSC_VER
	// construct the static objects of this file (Fp::op_ etc.) before the user's ones (see src/fp.cpp)
	#pragma warning(disable : 4073)
	#pragma init_seg(lib)
#endif
#define MCL_DLL_EXPORT
#include <mcl/bn.hpp>
#include <stdint.h>
// the AVX-512 code generation is enabled only for the functions defined in the regions of MCL_MSM_AVX512_BEGIN / END
// (not for the whole translation unit by -mavx512f) : an inline or template function instantiated in this file (the std and mcl headers)
// is a COMDAT shared with the other objects, and the linker may pick this file's instance for the whole program,
// then the program crashes on a CPU without AVX-512 before the CPU check (e.g. std::map of cybozu::Option, FpT::save, mcl::local::invVecWork).
// (evex512 is not written in the target string : clang 18-21 enable it implicitly and clang 22 removed the feature name and ignores the whole attribute with it)
#if defined(__clang__)
	#define MCL_MSM_AVX512_BEGIN _Pragma("clang attribute push(__attribute__((target(\"avx512f,avx512ifma\"))), apply_to = function)")
	#define MCL_MSM_AVX512_END _Pragma("clang attribute pop")
#elif defined(__GNUC__)
	#define MCL_MSM_AVX512_BEGIN _Pragma("GCC push_options") _Pragma("GCC target(\"avx512f,avx512ifma\")")
	#define MCL_MSM_AVX512_END _Pragma("GCC pop_options")
#else
	#define MCL_MSM_AVX512_BEGIN
	#define MCL_MSM_AVX512_END
#endif
MCL_MSM_AVX512_BEGIN
#include "avx512.hpp"
MCL_MSM_AVX512_END
#include "msm.hpp"
#define MCL_GLV_ONLY_FUNC
#include "glv.hpp"

#define XBYAK_NO_EXCEPTION
#include "xbyak/xbyak_util.h"

#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#ifndef __clang__
#pragma GCC diagnostic ignored "-Wmaybe-uninitialized" // false positive
#pragma GCC diagnostic ignored "-Wignored-attributes" // false positive
#endif
#endif

MCL_MSM_AVX512_BEGIN

namespace {
#include "msm_avx_para.h" // MsmCurvePara, MSM_N, g_msmCurveTbl (shared by the two kernels)
} // namespace

// the kernel of G1 (mcl::msm)
#define MCL_MSM_FP mcl::Fp
#define MCL_MSM_FR mcl::Fr
#define MCL_MSM_G1 mcl::G1
#define MCL_MSM_NS msm
#define MCL_MSM_FP_BIT MCL_FP_BIT
#define MCL_MSM_FR_BIT MCL_FR_BIT
#include "msm_avx_impl.hpp"
#undef MCL_MSM_FP
#undef MCL_MSM_FR
#undef MCL_MSM_G1
#undef MCL_MSM_NS
#undef MCL_MSM_FP_BIT
#undef MCL_MSM_FR_BIT

#if MCL_USE_GRUMPKIN == 1
// the kernel of GG (Grumpkin, mcl::msm_gg) : the base field is Fr and the scalar field is Fp
#define MCL_MSM_FP mcl::Fr
#define MCL_MSM_FR mcl::Fp
#define MCL_MSM_G1 mcl::GG
#define MCL_MSM_NS msm_gg
#define MCL_MSM_FP_BIT MCL_FR_BIT
#define MCL_MSM_FR_BIT MCL_FP_BIT
#include "msm_avx_impl.hpp"
#undef MCL_MSM_FP
#undef MCL_MSM_FR
#undef MCL_MSM_G1
#undef MCL_MSM_NS
#undef MCL_MSM_FP_BIT
#undef MCL_MSM_FR_BIT

namespace mcl { namespace msm {

bool initMsmGG(int curveType, uint32_t (*splitRaw)(Unit *a, Unit *b, const Unit *x))
{
	return msm_gg::initMsm(curveType, splitRaw);
}

} } // mcl::msm
#endif

MCL_MSM_AVX512_END

#ifdef MCL_MSM_TEST
#include <cybozu/xorshift.hpp>
#include <cybozu/benchmark.hpp>

#define CYBOZU_TEST_DISABLE_AUTO_RUN
#include <cybozu/test.hpp>
#include <cybozu/option.hpp>
#define MCL_GLV_ONLY_FUNC
#include "glv.hpp"

MCL_MSM_AVX512_BEGIN

// in mcl::msm : Fp / Fr / G1 / FpM / EcM / g_rt are those of the G1 kernel (msm_avx_impl.hpp)
namespace mcl { namespace msm {

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

void dump(const FpM& x, const char *msg = nullptr, size_t pos = size_t(-1))
{
	CYBOZU_ALIGN(64) Fp T[8];
	x.getFpA((FpA*)T);
	if (msg) printf("%s\n", msg);
	for (size_t i = 0; i < 8; i++) {
		if (i == pos || pos == size_t(-1)) {
			printf("  [%zd]=%s\n", i, T[i].getStr(16).c_str());
		}
	}
}

void FpM::set(const mpz_class& x, size_t i)
{
	mpz_class r = g_mont.toMont(x);
	Unit rv[N];
	toArray<N>(rv, r);
	mcl::msm::set(v, i, rv);
}
void FpM::set(const mpz_class& x)
{
	mpz_class r = g_mont.toMont(x);
	Unit rv[N];
	toArray<N>(rv, r);
	for (size_t i = 0; i < M; i++) {
		mcl::msm::set(v, i, rv);
	}
}
mpz_class FpM::getRaw(size_t i) const
{
	Unit x[N];
	mcl::msm::get(x, v, i);
	return fromArray<N>(x);
}
mpz_class FpM::get(size_t i) const
{
	mpz_class r = getRaw(i);
	return g_mont.fromMont(r);
}

void dump(const EcM& x, bool isProj, const char *msg = nullptr, size_t pos = size_t(-1))
{
	G1 T[8];
	x.getG1A((G1A*)T, isProj);
	if (msg) printf("%s\n", msg);
	for (size_t i = 0; i < 8; i++) {
		if (i == pos || pos == size_t(-1)) {
			printf("  [%zd]=%s\n", i, T[i].getStr(16|mcl::IoEcProj).c_str());
		}
	}
}

void putA(const uint64_t a[64], const char *msg)
{
	printf("%s\n", msg);
	for (size_t i = 0; i < 8; i++) {
		for (size_t j = 0; j < 8; j++) {
			printf("%02d ", int(a[i * 8 + j]));
		}
		printf("\n");
	}
}

CYBOZU_TEST_AUTO(trans8x8)
{
	MIE_ALIGN(64) uint64_t sa[64], da[64];
	for (size_t i = 0; i < 8; i++) {
		for (size_t j = 0; j < 8; j++) {
			sa[i*8+j] = uint64_t(j + i * 10);
		}
	}
	Vec s[8], d[8];
	memcpy(s, sa, sizeof(s));
	trans8x8(d, s);
	memcpy(da, d, sizeof(d));
	for (size_t i = 0; i < 8; i++) {
		for (size_t j = 0; j < 8; j++) {
			CYBOZU_TEST_EQUAL(sa[i*8+j], da[i+j*8]);
		}
	}
}

CYBOZU_TEST_AUTO(glvParam)
{
	const char *item[] = {"d", "exact b", "cost", "MiB", "heuristic b", "cost", "MiB" };
	const size_t itemN = CYBOZU_NUM_OF_ARRAY(item);
	for (size_t i = 0; i < itemN; i++) {
		if (i > 0) putchar('|');
		printf("%s", item[i]);
	}
	printf("\n");
	for (size_t i = 0; i < itemN; i++) {
		if (i > 0) putchar('|');
		putchar('-');
	}
	printf("\n");
	for (size_t d = 9; d < 28; d++) {
		size_t n = (size_t(1) << d)/8*2; // /(#SIMD)*(GLV)
		size_t b1 = mcl::ec::glvGetTheoreticBucketSize(n);
		size_t cost1 = mcl::ec::glvCost(n, b1);
		double mem1 = (8*8*8*3) * (size_t(1) << b1) / 1024.0 / 1024;
		size_t b2 = glvGetBucketSizeAVX512(n);
		size_t cost2 = mcl::ec::glvCost(n, b2);
		double mem2 = (8*8*8*3) * (size_t(1) << b2) / 1024.0 / 1024;
		printf("%zd|%zd|%zd|%.2f|%zd|%zd(%.2fx)|%.2f(%.2fx)\n", d, b1, cost1, mem1, b2, cost2, cost2/double(cost1), mem2, mem1/mem2);
	}
}

#if 0
CYBOZU_TEST_AUTO(sqr)
{
	const size_t n = 8;
	cybozu::XorShift rg;
	Vec v[n];
	Vec z1[n], z2[n];
	for (size_t i = 0; i < n*8; i++) ((Unit*)v)[i] = rg.get32();
	for (size_t i = 0; i < n; i++) dump(v[i], "v");

	vsqr(z1, v);
	vmul(z2, v, v);
	for (size_t i = 0; i < n*2; i++) {
		printf("i=%zd eq=%s\n", i, memcmp(&z1[i], &z2[i], sizeof(Vec)) == 0 ? "o" : "x");
		dump(z1[i], "z1");
		dump(z2[i], "z2");
	}
}
#endif

// random points in the Jacobi coordinates (z != 1) and random scalars
void setParam(G1 *P, Fr *x, size_t n, cybozu::XorShift& rg)
{
	for (size_t i = 0; i < n; i++) {
		uint32_t v = rg.get32();
		hashAndMapToG1(P[i], &v, sizeof(v));
		if (P[i].z.isOne()) {
			// (x, y, 1) = (x z^2, y z^3, z) for a random z != 0, 1 (hashAndMapToG1 of BN254 returns normalized points)
			Fp z, z2;
			do {
				z.setByCSPRNG(rg);
			} while (z.isZero() || z.isOne());
			Fp::sqr(z2, z);
			P[i].x *= z2;
			P[i].y *= z2 * z;
			P[i].z = z;
		}
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
	G1A *PA = (G1A*)P;

	EcM PM, QM;
	cybozu::XorShift rg;
	setParam(P, 0, n, rg);
	PM.setG1A(PA);
	QM.setG1A(PA);
	v = PM.isEqualJacobiAll(QM);
	CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff);
	for (size_t i = 0; i < n; i++) {
		QM = PM;
		QM.x.set(1, i);
		v = PM.isEqualJacobiAll(QM);
		CYBOZU_TEST_EQUAL(cvtToInt(v), 0xff ^ (1<<i));
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("setG1A", 1000, PM.setG1A, PA);
#endif
}

void setRand(FpM& x, cybozu::XorShift& rg, mcl::Fp *t = 0)
{
	if (t == 0) t = (mcl::Fp*)CYBOZU_ALLOCA(sizeof(mcl::Fp)*N);
	for (size_t i = 0; i < N; i++) {
		t[i].setByCSPRNG(rg);
	}
	x.setFpA((const FpA*)t);
}

CYBOZU_TEST_AUTO(conv)
{
	const int C = 16;
	FpM x1;
	CYBOZU_ALIGN(64) mcl::Fp x2[8], x3[8];
	cybozu::XorShift rg;
	for (int i = 0; i < C; i++) {
		setRand(x1, rg, x2);
		x1.getFpA((FpA*)x3);
		CYBOZU_TEST_EQUAL_ARRAY(x2, x3, 8);
	}
	{
		FpM x[vN], y[vN];
		FpMA z;
		for (size_t i = 0; i < vN; i++) {
			setRand(x[i], rg);
		}
		z.setFpM(x);
		z.getFpM(y);
		for (size_t i = 0; i < vN; i++) {
			CYBOZU_TEST_ASSERT(x[i] == y[i]);
		}
	}
}

template<class T>
void forcedRead(const T& x)
{
	const uint8_t *p = (const uint8_t*)&x;
	uint8_t r = 0;
	for (size_t i = 0; i < sizeof(T); i++) {
		r += p[i];
	}
	volatile uint8_t dummy = r;
	(void)dummy;
}

// FpM::add/sub/mul/sqr (intrinsics) vs mcl::Fp
void fpmTest(const mcl::Fp x[8], const mcl::Fp y[8])
{
	CYBOZU_ALIGN(64) mcl::Fp z[8];
	FpM xm, ym, zm, wm;
	xm.setFpA((const FpA*)x);
	ym.setFpA((const FpA*)y);
	// add
	for (size_t i = 0; i < 8; i++) {
		mcl::Fp::add(z[i], x[i], y[i]);
	}
	FpM::add(zm, xm, ym);
	wm.setFpA((const FpA*)z);
	CYBOZU_TEST_ASSERT(zm == wm);
	// sub
	for (size_t i = 0; i < 8; i++) {
		mcl::Fp::sub(z[i], x[i], y[i]);
	}
	FpM::sub(zm, xm, ym);
	wm.setFpA((const FpA*)z);
	CYBOZU_TEST_ASSERT(zm == wm);
	// mul
	for (size_t i = 0; i < 8; i++) {
		mcl::Fp::mul(z[i], x[i], y[i]);
	}
	FpM::mul(zm, xm, ym);
	wm.setFpA((const FpA*)z);
	CYBOZU_TEST_ASSERT(zm == wm);
	if (zm != wm) {
		for (size_t i = 0; i < 8; i++) {
			printf("i=%zd\n", i);
			dump(zm.v[i], "ok");
			dump(wm.v[i], "ng");
		}
	}
	// sqr
	for (size_t i = 0; i < 8; i++) {
		mcl::Fp::sqr(z[i], x[i]);
	}
	FpM::sqr(zm, xm);
	wm.setFpA((const FpA*)z);
	CYBOZU_TEST_ASSERT(zm == wm);
	if (zm != wm) {
		for (size_t i = 0; i < 8; i++) {
			printf("i=%zd\n", i);
			dump(zm.v[i], "ok");
			dump(wm.v[i], "ng");
		}
	}
}

CYBOZU_TEST_AUTO(fpm)
{
	cybozu::XorShift rg;
	mcl::Fp x[8], y[8];
	for (int i = 0; i < 30; i++) {
		for (int k = 0; k < 8; k++) {
			x[k] = i*8+k;
		}
		for (int j = 0; j < 30; j++) {
			for (int k = 0; k < 8; k++) {
				y[k] = j*8+k;
			}
		}
		fpmTest(x, y);
	}
}

CYBOZU_TEST_AUTO(vaddPre)
{
	FpM x[vN], y[vN], z[vN], w[vN];
	FpMA xa, ya, za, wa;
	cybozu::XorShift rg;
	for (int i = 0; i < 10; i++) {
		// vaddPre, vsubPre
		for (size_t j = 0; j < vN; j++) {
			setRand(x[j], rg);
			setRand(y[j], rg);
			vaddPre(z[j].v, x[j].v, y[j].v);
			vsubPre(w[j].v, z[j].v, x[j].v);
			for (size_t k = 0; k < N; k++) {
				CYBOZU_TEST_ASSERT(isEqual(w[j].v[k], y[j].v[k]));
			}
			vsubPre(w[j].v, z[j].v, y[j].v);
			for (size_t k = 0; k < N; k++) {
				CYBOZU_TEST_ASSERT(isEqual(w[j].v[k], x[j].v[k]));
			}
		}
		xa.setFpM(x);
		ya.setFpM(y);
		vaddPre(za.v, xa.v, ya.v);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(z[j] == w[j]);
		}
		vsubPre<VmaskA>(za.v, za.v, ya.v);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(x[j] == w[j]);
		}
		// vadd, vsub
		for (size_t j = 0; j < vN; j++) {
			vadd(z[j].v, x[j].v, y[j].v);
			Vec u[N];
			vsub(u, z[j].v, y[j].v);
			for (size_t k = 0; k < N; k++) {
				CYBOZU_TEST_ASSERT(isEqual(x[j].v[k], u[k]));
			}
		}
		w[0].clear();
		w[1].clear();

		xa.setFpM(x);
		ya.setFpM(y);
		FpMA::add(za, xa, ya);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(z[j] == w[j]);
		}
		FpMA::sub(za, za, ya);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(x[j] == w[j]);
		}
		// vmul
		for (size_t j = 0; j < vN; j++) {
			vmul(z[j].v, x[j].v, y[j].v);
		}
		xa.setFpM(x);
		ya.setFpM(y);
		FpMA::mul(za, xa, ya);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(z[j] == w[j]);
		}
		// inv
		for (size_t j = 0; j < vN; j++) {
			FpM::inv(z[j], x[j]);
		}
		xa.setFpM(x);
		FpMA::inv(za, xa);
		za.getFpM(w);
		for (size_t j = 0; j < vN; j++) {
			CYBOZU_TEST_ASSERT(z[j] == w[j]);
		}
	}
#ifdef NDEBUG
	const int C = 10000000;
	CYBOZU_BENCH_C("vaddPre::Vec", C, vaddPre, z[0].v, z[0].v, x[0].v);
	CYBOZU_BENCH_C("vsubPre::Vec", C, vsubPre, z[0].v, z[0].v, x[0].v);
	CYBOZU_BENCH_C("vaddPre::VecA", C, vaddPre, za.v, za.v, xa.v);
	CYBOZU_BENCH_C("vsubPre::VecA", C, vsubPre<VmaskA>, za.v, za.v, xa.v);
	CYBOZU_BENCH_C("vadd::Vec", C, vadd, z[0].v, z[0].v, x[0].v);
	CYBOZU_BENCH_C("vsub::Vec", C, vsub, z[0].v, z[0].v, x[0].v);
	CYBOZU_BENCH_C("vadd::VecA", C, vadd<VmaskA>, za.v, za.v, xa.v);
	CYBOZU_BENCH_C("vsub::VecA", C, vsub<VmaskA>, za.v, za.v, xa.v);
	CYBOZU_BENCH_C("vmul::Vec", C/10, vmul, z[0].v, z[0].v, x[0].v);
	CYBOZU_BENCH_C("vmul::VecA", C/10, vmul<VmaskA>, za.v, za.v, xa.v);
	CYBOZU_BENCH_C("vsqr::Vec", C/10, vsqr, z[0].v, z[0].v);
	CYBOZU_BENCH_C("vsqr::VecA", C/10, vsqr<VmaskA>, za.v, za.v);
	CYBOZU_BENCH_C("FpM::inv", C/100, FpM::inv, z[0], z[0]);
	CYBOZU_BENCH_C("FpMA::inv", C/100, FpMA::inv, za, za);
	{
		CYBOZU_ALIGN(64) mcl::Fp vv[8*vN];
		za.getFpA((FpA*)vv);
		CYBOZU_BENCH_C("Fp::inv(8)", C/100, mcl::invVec<mcl::Fp>, vv, vv, 8*vN);
	}
	forcedRead(z);
	forcedRead(za);
#endif
}

template<class T>
void lpN(void f(T&, const T&, const T&), T *z, const T *x, const T *y, size_t n)
{
	for (size_t i = 0; i < n; i++) f(z[i], x[i], y[i]);
}

template<class E, bool mixed>
void testJacobiAdd()
{
	const size_t n = sizeof(E) / (sizeof(FpM) * 3) * M;
	CYBOZU_ALIGN(64) G1 P[n], Q[n], R[n], actual[n];
	Fr x[n];
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	setParam(Q, x, n, rg);
	for (size_t i = 0; i < n; i++) {
		switch (i % 6) {
		case 0: Q[i] = P[i]; break;
		case 1: G1::neg(Q[i], P[i]); break;
		case 2: P[i].clear(); break;
		case 3: Q[i].clear(); break;
		case 4: P[i].clear(); Q[i].clear(); break;
		}
		if (mixed) Q[i].normalize();
		G1::add(R[i], P[i], Q[i]);
	}
	E p, q, out;
	p.setG1A((G1A*)P, false);
	q.setG1A((G1A*)Q, false);
	E::template add<false, mixed>(out, p, q);
	out.getG1A((G1A*)actual, false);
	CYBOZU_TEST_EQUAL_ARRAY(actual, R, n);
	out = p;
	E::template add<false, mixed>(out, out, q);
	out.getG1A((G1A*)actual, false);
	CYBOZU_TEST_EQUAL_ARRAY(actual, R, n);
	out = q;
	E::template add<false, mixed>(out, p, out);
	out.getG1A((G1A*)actual, false);
	CYBOZU_TEST_EQUAL_ARRAY(actual, R, n);
}

CYBOZU_TEST_AUTO(jacobiAdd)
{
	testJacobiAdd<EcM, false>();
	testJacobiAdd<EcM, true>();
	testJacobiAdd<EcMA, false>();
	testJacobiAdd<EcMA, true>();
}

CYBOZU_TEST_AUTO(op)
{
	const size_t n = 8; // fixed
	G1 P[n];
	G1 Q[n];
	G1 R[n];
	G1 T[n];
	Fr x[n];
	G1A *PA = (G1A*)P;
	G1A *QA = (G1A*)Q;
	G1A *TA = (G1A*)T;

	EcM PM, QM, TM;
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	setParam(Q, x, n, rg);
	P[3].clear();
	Q[4].clear();
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_ASSERT(!P[i].z.isOne());
	}
	ec::normalizeVec(R, P, n);
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
	PM.setG1A(PA);
	EcM::dbl<true>(TM, PM);
	TM.getG1A(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1A(PA, false);
	EcM::dbl<false>(TM, PM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// test add
	// R = P + Q
	for (size_t i = 0; i < n; i++) {
		G1::add(R[i], P[i], Q[i]);
	}

	// as Proj
	PM.setG1A(PA);
	QM.setG1A(QA);
	EcM::add<true>(TM, PM, QM);
	TM.getG1A(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1A(PA, false);
	QM.setG1A(QA, false);
	EcM::add<false>(TM, PM, QM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi (mixed)
	for (size_t i = 0; i < n; i++) {
		Q[i].normalize();
	}
	QM.setG1A(QA, false);
	EcM::add<false, true>(TM, PM, QM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}
#ifdef NDEBUG
	{
		const int C = 10000;
		const size_t n = 128;
		FpM a[n], b[n];
		for (size_t i = 0; i < n; i++) {
			a[i] = PM.x;
			b[i] = PM.y;
		}
		CYBOZU_BENCH_C("FpM::add", C, FpM::add, a[0], a[0], b[0]);
		CYBOZU_BENCH_C("FpM::mul", C, FpM::mul, a[0], a[0], b[0]);
		CYBOZU_BENCH_C("FpM::sqr", C, FpM::sqr, a[0], a[0]);
		CYBOZU_BENCH_C("mulu", C, FpM::mul, a[0], a[0], g_rt.m64to52u);
		CYBOZU_BENCH_C("addn", C, lpN, FpM::add, a, a, b, n);
		CYBOZU_BENCH_C("muln", C, lpN, FpM::mul, a, a, b, n);
	}
#endif
}

CYBOZU_TEST_AUTO(opA)
{
	const size_t n = M*vN;
	G1 P[n];
	G1 Q[n];
	G1 R[n];
	G1 T[n];
	Fr x[n];
	G1A *PA = (G1A*)P;
	G1A *QA = (G1A*)Q;
	G1A *TA = (G1A*)T;

	EcMA PM, QM, TM;
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	setParam(Q, x, n, rg);
	P[3].clear();
	Q[4].clear();
	// test dbl
	// R = 2P
	for (size_t i = 0; i < n; i++) {
		G1::dbl(R[i], P[i]);
	}
	// as Proj
	PM.setG1A(PA);
	EcMA::dbl<true>(TM, PM);
	TM.getG1A(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1A(PA, false);
	EcMA::dbl<false>(TM, PM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// test add
	// R = P + Q
	for (size_t i = 0; i < n; i++) {
		G1::add(R[i], P[i], Q[i]);
	}

	// as Proj
	PM.setG1A(PA);
	QM.setG1A(QA);
	EcMA::add<true>(TM, PM, QM);
	TM.getG1A(TA);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi
	PM.setG1A(PA, false);
	QM.setG1A(QA, false);
	EcMA::add<false>(TM, PM, QM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}

	// as Jacobi (mixed)
	for (size_t i = 0; i < n; i++) {
		Q[i].normalize();
	}
	QM.setG1A(QA, false);
	EcMA::add<false, true>(TM, PM, QM);
	TM.getG1A(TA, false);
	for (size_t i = 0; i < n; i++) {
		CYBOZU_TEST_EQUAL(R[i], T[i]);
	}
	{
		EcM PM2, QM2;
		PM2.setG1A(PA);
		QM2.setG1A(QA);
		const int C = 10000;
		CYBOZU_BENCH_C("EcM::dbl", C, EcM::dbl, QM2, QM2);
		CYBOZU_BENCH_C("EcM::add", C, EcM::add, PM2, PM2, QM2);
		CYBOZU_BENCH_C("EcMA::dbl", C, EcMA::dbl, QM, QM);
		CYBOZU_BENCH_C("EcMA::add", C, EcMA::add, TM, TM, QM);
		CYBOZU_BENCH_C("EcMA::setG1A:proj", C, PM.setG1A, PA, true);
		CYBOZU_BENCH_C("EcMA::setG1A:jacobi", C, PM.setG1A, PA, false);
		CYBOZU_BENCH_C("EcMA::getG1A:proj", C, PM.getG1A, PA, true);
		CYBOZU_BENCH_C("EcMA::getG1A:jacobi", C, PM.getG1A, PA, false);
	}
}

CYBOZU_TEST_AUTO(normalizeJacobiVec)
{
	const bool isProj = false;
	const size_t N = 64;
	CYBOZU_ALIGN(64) G1 P[N], Q[N], R[N];
	EcM PP[N/8];
	for (size_t n = 8; n < N; n += 8) {
		cybozu::XorShift rg;
		setParam(P, 0, n, rg);
		P[n/2].clear();
		P[n/3].clear();
		mcl::ec::normalizeVec(Q, P, n);
		for (size_t i = 0; i < n/8; i++) {
			PP[i].setG1A((G1A*)&P[i*8], isProj);
		}
		normalizeJacobiVec<EcM>(PP, n/8);
		for (size_t i = 0; i < n/8; i++) {
			PP[i].getG1A((G1A*)&R[i*8], isProj);
		}
		CYBOZU_TEST_EQUAL_ARRAY(P, R, n);
	}
	const int C = 10000;
	CYBOZU_BENCH_C("EcM::setG1A:proj", C, PP[0].setG1A, (G1A*)P, true);
	CYBOZU_BENCH_C("EcM::setG1A:jacobi", C, PP[0].setG1A, (G1A*)P, false);
	CYBOZU_BENCH_C("EcM::getG1A:proj", C, PP[0].getG1A, (G1A*)P, true);
	CYBOZU_BENCH_C("EcM::getG1A:jacobi", C, PP[0].getG1A, (G1A*)P, false);
}

CYBOZU_TEST_AUTO(mulEach_special)
{
	const size_t n = 32;
	CYBOZU_ALIGN(64) G1 P[n], Q[n], R[n];
	Fr x[n];
	for (size_t i = 0; i < n; i++) {
		P[i].clear();
		R[i].clear();
		x[i] = 0;
	}
	mcl::hashAndMapToG1(P[0], "abc");
	x[0].setHashOf("abc", 3);
	for (size_t i = 0; i < n; i++) Q[i] = P[i];
	G1::mul(R[0], P[0], x[0]);
	G1::mulEach(Q, x, n);
	CYBOZU_TEST_EQUAL_ARRAY(R, Q, n);
	// the edge cases of the GLV split : x = a + b lambda
	const mpz_class& r = Fr::getOp().mp;
	const mpz_class L = mpz_class(1) << 128; // |a|, |b| < L
	const mpz_class tbl[] = {
		0,
		1,
		2,
		L - 1,
		L,
		L + 1,
		(r - 1) / 2,
		(r + 1) / 2,
		r - 2,
		r - 1,
	};
	cybozu::XorShift rg;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		setParam(P, x, n, rg);
		x[0].setMpz(tbl[i]);
		x[1].setMpz(r - tbl[i]);
		for (size_t k = 0; k < n; k++) {
			Q[k] = P[k];
			G1::mul(R[k], P[k], x[k]);
		}
		G1::mulEach(Q, x, n);
		CYBOZU_TEST_EQUAL_ARRAY(R, Q, n);
	}
}

void mulEachOrg(G1 *P, const Fr *x, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		G1::mul(P[i], P[i], x[i]);
	}
}

void mulVecOrg(G1& Q, G1 *P, const Fr *x, size_t n)
{
	mulEachOrg(P, x, n);
	Q = P[0];
	for (size_t i = 1; i < n; i++) {
		Q += P[i];
	}
}

CYBOZU_TEST_AUTO(mulEach)
{
	const size_t n = 1024;
	CYBOZU_ALIGN(64) G1 P[n], Q[n], R[n];
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
	CYBOZU_BENCH_C("mulEachOrg", 100, mulEachOrg, Q, x, n);
	CYBOZU_BENCH_C("mulEach", 100, G1::mulEach, Q, x, n);
#endif
}

void copyMulVec(G1& R, const G1 *_P, const Fr *x, size_t n)
{
	G1 *P = (G1*)CYBOZU_ALLOCA(sizeof(G1) * n);
	mcl::bint::copyN(P, _P, n);
	mulVecAVX512(R, P, x, n);
}

CYBOZU_TEST_AUTO(mulVec)
{
	const size_t n = 8203;
	CYBOZU_ALIGN(64) G1 P[n], Q, R;
	Fr x[n];
	cybozu::XorShift rg;
	setParam(P, x, n, rg);
	if (n > 32) P[32].clear();
	P[n/2].clear();
	Q.clear();
	for (size_t i = 0; i < n; i++) {
		G1 T;
		G1::mul(T, P[i], x[i]);
		Q += T;
	}
	G1 P2[n];
	mcl::bint::copyN(P2, P, n);
	mulVecAVX512(R, P, x, n);
//	G1::mulVec(R, P, x, n);
	CYBOZU_TEST_EQUAL(Q, R);
#ifdef NDEBUG
	G1 R2;
	CYBOZU_BENCH_C("mulVec(copy)", 30, copyMulVec, R2, P2, x, n);
	CYBOZU_BENCH_C("mulVec", 30, mulVecAVX512, R, P, x, n);
	CYBOZU_TEST_EQUAL(R, R2);
	CYBOZU_BENCH_C("mulVecOrg", 3, mulVecOrg, R2, P2, x, n);
#endif
}


void naiveMulVec(G1& Q, const G1 *P, const Fr *x, size_t n)
{
	Q.clear();
	for (size_t i = 0; i < n; i++) {
		G1 T;
		G1::mul(T, P[i], x[i]);
		Q += T;
	}
}

// G1::mulVec with the kernel of the batch affine addition (getMsmKernelAVX512)
CYBOZU_TEST_AUTO(kernel)
{
	CYBOZU_TEST_EQUAL(G1::msmKernel, getMsmKernelAVX512());
	const size_t N = 8203; // > MCL_MSM_BATCH_MIN_N / 2, not a multiple of 8
	std::vector<G1> P(N), P2(N);
	std::vector<Fr> x(N);
	cybozu::XorShift rg;
	setParam(P.data(), x.data(), N, rg);
	G1 Q, R;
	CYBOZU_TEST_ASSERT(G1::msmKernel->batchMinN > 0);
	// 40 : the gate of the bucket method (MCL_MSM_MIN_SPLIT_N = 80 split scalars), 47 .. 97 : around batchMinN (96 or 192 split scalars)
	const size_t nTbl[] = { 40, 47, 48, 49, 95, 96, 97, 128, 129, 255, 256, 257, 1000, 4096, N };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t n = nTbl[i];
		mcl::bint::copyN(P2.data(), P.data(), n);
		if (n > 32) P2[32].clear(); // zero points
		P2[n/2].clear();
		naiveMulVec(Q, P2.data(), x.data(), n);
		G1::mulVec(R, P2.data(), x.data(), n);
		CYBOZU_TEST_EQUAL(Q, R);
	}
	// all scalars are equal
	{
		for (size_t i = 0; i < N; i++) x[i] = x[0];
		mcl::bint::copyN(P2.data(), P.data(), N);
		naiveMulVec(Q, P2.data(), x.data(), N);
		G1::mulVec(R, P2.data(), x.data(), N);
		CYBOZU_TEST_EQUAL(Q, R);
	}
	// scalars in {0, 1}
	{
		for (size_t i = 0; i < N; i++) x[i] = rg.get32() & 1;
		mcl::bint::copyN(P2.data(), P.data(), N);
		naiveMulVec(Q, P2.data(), x.data(), N);
		G1::mulVec(R, P2.data(), x.data(), N);
		CYBOZU_TEST_EQUAL(Q, R);
	}
	// small scalars (many equal digits), zero points and equal points
	{
		for (size_t i = 0; i < N; i++) {
			x[i] = rg.get32() % 7;
			P2[i] = P[i];
			if (i % 5 == 1) P2[i].clear();
			if (i % 5 == 2) P2[i] = P2[i - 1];
			if (i % 5 == 3) P2[i] = P2[0];
		}
		naiveMulVec(Q, P2.data(), x.data(), N);
		G1::mulVec(R, P2.data(), x.data(), N);
		CYBOZU_TEST_EQUAL(Q, R);
	}
	// P + P (doubling) and P + (-P) (zero) in a bucket
	{
		for (size_t i = 0; i < N; i++) {
			G1::mul(P2[i], P[0], i / 3 + 3);
			x[i].setByCSPRNG();
		}
		for (size_t i = 0; i + 2 < N; i += 3) {
			x[i + 1] = x[i]; // P2[i] + P2[i+1] = 2 P2[i]
			Fr::neg(x[i + 2], x[i]); // P2[i] - P2[i+2] = 0
		}
		naiveMulVec(Q, P2.data(), x.data(), N);
		G1::mulVec(R, P2.data(), x.data(), N);
		CYBOZU_TEST_EQUAL(Q, R);
	}
}

mpz_class getGLVLambda();

// cvtBaseGLV = cvtBase of (s1 P, s2 lambda(P))
CYBOZU_TEST_AUTO(cvtBaseGLV)
{
	const mpz_class lambda = getGLVLambda();
	const ec::MsmKernel& kn = *getMsmKernelAVX512();
	CYBOZU_TEST_ASSERT(kn.cvtBaseGLV != 0);
	const size_t n = 21; // not a multiple of 8
	std::vector<G1> P(n), Q(2 * n);
	std::vector<uint8_t> neg(n);
	cybozu::XorShift rg;
	hashAndMapToG1(P[0], "abc", 3);
	for (size_t i = 1; i < n; i++) G1::add(P[i], P[i - 1], P[0]);
	G1::normalizeVec(P.data(), P.data(), n);
	P[3].clear();
	P[n - 1].clear();
	for (size_t i = 0; i < n; i++) {
		neg[i] = uint8_t(rg.get32() & 3);
		Q[i] = P[i];
		if (neg[i] & 1) G1::neg(Q[i], Q[i]);
		G1::mul(Q[n + i], P[i], lambda);
		if (neg[i] & 2) G1::neg(Q[n + i], Q[n + i]);
	}
	G1::normalizeVec(Q.data(), Q.data(), 2 * n);
	std::vector<uint8_t> base1(kn.pointSize * 2 * n + 64), base2(kn.pointSize * 2 * n + 64);
	void *b1 = (void*)(((uintptr_t)base1.data() + 63) & ~(uintptr_t)63);
	void *b2 = (void*)(((uintptr_t)base2.data() + 63) & ~(uintptr_t)63);
	kn.cvtBase(b1, Q.data(), 2 * n);
	kn.cvtBaseGLV(b2, P.data(), n, neg.data());
	CYBOZU_TEST_EQUAL(memcmp(b1, b2, kn.pointSize * 2 * n), 0);
	// the zero point stays zero even if negated
	for (size_t i = 0; i < 2 * n; i++) {
		G1 R;
		R.clear();
		kn.addToBucket(&R, b2, uint32_t(i));
		CYBOZU_TEST_EQUAL(R, Q[i]);
	}
}

// the cost of addPairsAffM per pair
CYBOZU_TEST_AUTO(kernelBench)
{
#ifdef NDEBUG
	const size_t n = 8192;
	std::vector<G1> P(n);
	cybozu::XorShift rg;
	hashAndMapToG1(P[0], "abc", 3);
	for (size_t i = 1; i < n; i++) {
		G1::add(P[i], P[i-1], P[0]);
	}
	G1::normalizeVec(P.data(), P.data(), n);
	const size_t m = n / 2;
	std::vector<uint32_t> ia(m), ib(m);
	for (size_t j = 0; j < m; j++) {
		ia[j] = uint32_t(2 * j);
		ib[j] = uint32_t(2 * j + 1) | ((rg.get32() & 1) ? mcl::ec::local::msmSign : 0);
	}
	const ec::MsmKernel& kn = *getMsmKernelAVX512();
	void *base = Xbyak::AlignedMalloc(kn.pointSize * n, 64);
	void *R = Xbyak::AlignedMalloc(kn.pointSize * m, 64);
	void *work = Xbyak::AlignedMalloc(kn.workSize, 64);
	// the cost of FpM::mul
	{
		FpM a, b;
		a = FpM::one();
		b = FpM::R2();
		CYBOZU_BENCH_C("FpM::mul", 1000, FpM::mul, a, a, b);
		CYBOZU_BENCH_C("FpM::sqr", 1000, FpM::sqr, a, a);
		CYBOZU_BENCH_C("FpM::add", 1000, FpM::add, a, a, b);
	}
	CYBOZU_BENCH_C("cvtBase", 100, kn.cvtBase, base, P.data(), n);
	CYBOZU_BENCH_C("addPairs(4096)", 100, kn.addPairs, R, base, ia.data(), ib.data(), m, work);
	CYBOZU_BENCH_C("addPairs(256)", 1000, kn.addPairs, R, base, ia.data(), ib.data(), 256, work);
	// check the result
	for (size_t j = 0; j < m; j++) {
		G1 Q;
		Q.clear();
		kn.addToBucket(&Q, R, uint32_t(j));
		G1 T = P[2 * j];
		if (ib[j] & mcl::ec::local::msmSign) T -= P[2 * j + 1]; else T += P[2 * j + 1];
		CYBOZU_TEST_EQUAL(Q, T);
	}
	Xbyak::AlignedFree(work);
	Xbyak::AlignedFree(R);
	Xbyak::AlignedFree(base);
#endif
}

void mulVecKernel(G1& Q, G1 *P, const Fr *x, size_t n, size_t b)
{
	G1::mulVec(Q, P, x, n, b);
}

void msmBench(int C, size_t db, size_t de, size_t b)
{
	printf("d = [%zd, %zd], b = %zd\n", db, de, b);
	const size_t maxN = size_t(1) << de;
	cybozu::XorShift rg;
	std::vector<G1> Pvec(maxN);
	std::vector<Fr> xVec(maxN);
	hashAndMapToG1(Pvec[0], "abc", 3);
	for (size_t i = 1; i < maxN; i++) {
		G1::add(Pvec[i], Pvec[i-1], Pvec[0]);
		xVec[i].setByCSPRNG(rg);
	}
	G1 P1;
	for (size_t d = db; d <= de; d++) {
		size_t n = size_t(1) << d;
		size_t b1 = glvGetBucketSizeAVX512(n/8);
		printf("old % 8zd % 2zd", n, b1);
		CYBOZU_BENCH_C(" ", C, mulVecAVX512, P1, Pvec.data(), xVec.data(), n, b1);
		size_t b2 = b ? b : getBucketSizeAffM(n * 2, 128, sizeof(G1));
		printf("new % 8zd % 2zd", n, b2);
		CYBOZU_BENCH_C(" ", C, mulVecKernel, P1, Pvec.data(), xVec.data(), n, b2);
	}
}

void showParams()
{
	puts("d|b|cost_b|theoretic|cost_t|cost_b/cost_t");
	for (size_t d = 7; d <= 27; d++) {
		size_t n = size_t(1) << d;
		size_t nn = n/8*2; // /#SIMD*GLV
		size_t b1 = glvGetBucketSizeAVX512(nn);
		size_t c1 = mcl::ec::glvCost(nn, b1);
		size_t b2 = mcl::ec::glvGetTheoreticBucketSize(nn);
		size_t c2 = mcl::ec::glvCost(nn, b2);
		printf("%zd|%zd|%zd|%zd|%zd|%.2f\n", d, b1, c1, b2, c2, c1/double(c2));
	}
}

// lambda of the GLV method on Fr (lambda^2 + lambda + 1 = 0 and splitRaw(lambda) = (0, 1))
mpz_class getGLVLambda()
{
	Fr s;
	CYBOZU_TEST_ASSERT(Fr::squareRoot(s, Fr(-3)));
	Fr lambda = (s - 1) / 2;
	for (int i = 0; i < 2; i++) {
		Unit a[2] = {}, b[2] = {}, x[4] = {};
		Fr::getOp().fromMont(x, lambda.getUnit());
		const uint32_t neg = g_splitRaw(a, b, x);
		if (neg == 0 && a[0] == 0 && a[1] == 0 && b[0] == 1 && b[1] == 0) {
			mpz_class ret;
			lambda.getMpz(ret);
			return ret;
		}
		lambda = -1 - lambda; // the other root
	}
	CYBOZU_TEST_ASSERT(false);
	return 0;
}

#if MCL_USE_GRUMPKIN == 1
// the kernel of GG (Grumpkin, mcl::msm_gg) registered by initGrumpkin together with the kernel of G1 (BN_SNARK1)
CYBOZU_TEST_AUTO(kernelGG)
{
	const int orgCurveType = g_rt.curveType;
	initPairing(mcl::BN_SNARK1);
	initGrumpkin();
	CYBOZU_TEST_EQUAL(G1::msmKernel, getMsmKernelAVX512());
	CYBOZU_TEST_EQUAL(GG::msmKernel, mcl::msm_gg::getMsmKernelAVX512());
	CYBOZU_TEST_ASSERT(GG::mulEachOpti == mcl::msm_gg::mulEachAVX512);
	CYBOZU_TEST_EQUAL(g_rt.curveType, MCL_BN_SNARK1); // the constants of G1 are not changed by initGrumpkin
	const size_t n = 4096 + 3;
	std::vector<GG> P(n), P2(n), P3(n);
	std::vector<mcl::Fp> x(n); // the scalar field of GG is Fp
	cybozu::XorShift rg;
	P[0] = getGGbasePoint();
	for (size_t i = 1; i < n; i++) GG::add(P[i], P[i - 1], P[0]);
	for (size_t i = 0; i < n; i++) x[i].setByCSPRNG(rg);
	P[5].clear();
	P[7] = P[8]; x[7] = x[8]; // the same point
	GG::neg(P[9], P[8]); x[9] = x[8]; // the cancellation
	const size_t nTbl[] = { 40, 47, 48, 49, 95, 96, 97, 128, 257, 1000, n };
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(nTbl); i++) {
		const size_t m = nTbl[i];
		GG Q, R;
		Q.clear();
		for (size_t j = 0; j < m; j++) {
			GG T;
			GG::mul(T, P[j], x[j]);
			Q += T;
		}
		P2 = P;
		GG::mulVec(R, P2.data(), x.data(), m);
		CYBOZU_TEST_EQUAL(Q, R);
		GG::mulVecConstRef(R, P.data(), x.data(), m);
		CYBOZU_TEST_EQUAL(Q, R);
	}
	// mulEach (mcl::msm_gg::mulEachAVX512) vs mul
	P2 = P;
	GG::mulEach(P2.data(), x.data(), n);
	for (size_t i = 0; i < n; i++) {
		GG::mul(P3[i], P[i], x[i]);
	}
	CYBOZU_TEST_EQUAL_ARRAY(P2, P3, n);
	// the kernel of G1 (BN_SNARK1) still works
	{
		const size_t m = 1000;
		std::vector<G1> Q(m);
		std::vector<Fr> y(m);
		setParam(Q.data(), y.data(), m, rg);
		G1 R1, R2;
		naiveMulVec(R1, Q.data(), y.data(), m);
		G1::mulVec(R2, Q.data(), y.data(), m);
		CYBOZU_TEST_EQUAL(R1, R2);
	}
#ifdef NDEBUG
	{
		GG R;
		for (size_t m = 1024; m <= n - 3; m *= 4) {
			printf("GG n=%zd ", m);
			CYBOZU_BENCH_C("mulVecConstRef", 10, GG::mulVecConstRef, R, P.data(), x.data(), m);
		}
	}
#endif
	initPairing(*getCurveParam(orgCurveType));
}
#endif

// G1::mulEach (mulEachAVX512) vs G1::mul on every curve of g_msmCurveTbl
CYBOZU_TEST_AUTO(mulEachCurves)
{
	const struct {
		int curveType;
		const char *name;
	} tbl[] = {
		{ MCL_BN254, "BN254" },
		{ MCL_BN_SNARK1, "BN_SNARK1" },
		{ MCL_SECP256K1, "secp256k1" },
		{ MCL_GRUMPKIN, "Grumpkin" }, // G1 as Grumpkin by initCurve<G1> (the class GG uses the second kernel)
#if MCL_FP_BIT == 384
		{ MCL_BLS12_381, "BLS12_381" },
		{ MCL_BLS12_377, "BLS12_377" },
#endif
	};
	const int orgCurveType = g_rt.curveType;
	for (size_t ti = 0; ti < CYBOZU_NUM_OF_ARRAY(tbl); ti++) {
		const int curveType = tbl[ti].curveType;
		const size_t n = 16 * 20 + 11; // 2n >= MCL_MSM_BATCH_MIN_N to use the kernel in mulVec
		CYBOZU_ALIGN(64) G1 P[n], Q[n], R[n];
		Fr x[n];
		cybozu::XorShift rg;
		if (curveType == MCL_SECP256K1 || curveType == MCL_GRUMPKIN) {
			G1 P0;
			initCurve<G1>(curveType, &P0); // no hashAndMapToG1 without initPairing
			for (size_t i = 0; i < n; i++) {
				x[i].setByCSPRNG(rg);
				G1::mul(P[i], P0, x[i]);
				x[i].setByCSPRNG(rg);
			}
		} else {
			initPairing(*getCurveParam(curveType));
			setParam(P, x, n, rg);
		}
		printf("%s mulEachOpti=%d\n", tbl[ti].name, G1::mulEachOpti != 0);
		CYBOZU_TEST_ASSERT(G1::mulEachOpti != 0);
		CYBOZU_TEST_EQUAL(g_rt.curveType, curveType);
		P[5].clear();
		P[20].clear();
		const mpz_class& r = Fr::getOp().mp;
		const mpz_class L = mpz_class(1) << 128;
		const mpz_class lambda = getGLVLambda();
		const mpz_class scalarTbl[] = {
			0, 1, 2, L - 1, L, L + 1, (r - 1) / 2, (r + 1) / 2, r - 2, r - 1,
			2 * lambda - 1, // the GLV split is (lambda - 1, 1) on BLS12 ; P == Q occurs in adding the lambda part on BLS12-377
		};
		for (size_t i = 0; i < 32; i++) x[i].setMpz(scalarTbl[i % CYBOZU_NUM_OF_ARRAY(scalarTbl)]);
		for (size_t i = 0; i < n; i++) {
			Q[i] = P[i];
			G1::mul(R[i], P[i], x[i]);
		}
		G1::mulEach(Q, x, n);
		CYBOZU_TEST_EQUAL_ARRAY(R, Q, n);
		// FpM::add/sub/mul/sqr vs mcl::Fp
		{
			CYBOZU_ALIGN(64) mcl::Fp a[8], b[8];
			for (size_t j = 0; j < 10; j++) {
				for (size_t k = 0; k < 8; k++) {
					a[k].setByCSPRNG(rg);
					b[k].setByCSPRNG(rg);
				}
				fpmTest(a, b);
			}
		}
		// mulVec (the kernel of the batch affine addition) vs naive
		{
			G1 S1, S2;
			S1.clear();
			for (size_t i = 0; i < n; i++) S1 += R[i];
			G1::mulVec(S2, P, x, n);
			CYBOZU_TEST_EQUAL(S1, S2);
		}
	}
	// restore the curve for the following benchmarks
	if (orgCurveType == MCL_SECP256K1) {
		initCurve<G1>(orgCurveType);
	} else {
		initPairing(*getCurveParam(orgCurveType));
	}
}

/*
	the cost model of the window size of the kernel (getBucketSizeAffM) vs the measured one
	measured on Xeon w9-3495X by sweeping b (misc/msm_sweep.cpp, 2026-11-04) : n (split) scalars of 128 bits of G1,
	[lo, hi] is the range of b whose time is within 8% of the best (the valley is shallow : BN254 n = 2^16 has
	the best 11 and the model 13, 7.8% slower)
*/
CYBOZU_TEST_AUTO(bucketSize)
{
	// [lo, hi] : the range of b within 8% of the measured best (misc/msm_sweep.cpp on Xeon w9-3495X, 2026-11-05, with the batched reduction)
	const size_t nTbl[] = { 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288 };
	const size_t lo8[] = { 5, 5, 5, 6, 8, 8, 8, 9, 10, 11, 12, 12, 13 }; // BLS12-381 (N = 8)
	const size_t hi8[] = { 6, 6, 8, 8, 9, 11, 11, 13, 13, 13, 15, 16, 16 };
	const size_t lo5[] = { 5, 5, 6, 6, 7, 8, 8, 9, 10, 11, 12, 14, 13 }; // BN254 (N = 5)
	const size_t hi5[] = { 6, 6, 8, 9, 10, 11, 12, 13, 13, 14, 16, 16, 16 };
	const size_t *lo = (N == 5) ? lo5 : lo8;
	const size_t *hi = (N == 5) ? hi5 : hi8;
	for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(nTbl); j++) {
		const size_t n = nTbl[j];
		const size_t b = getBucketSizeAffM(n, 128, sizeof(G1));
		const bool ok = lo[j] <= b && b <= hi[j];
		CYBOZU_TEST_ASSERT(ok);
		if (!ok) printf("n=%zd model b=%zd measured [%zd, %zd]\n", n, b, lo[j], hi[j]);
	}
}

} } // mcl::msm

MCL_MSM_AVX512_END // main runs before the CPU check, so it must not use AVX-512

int main(int argc, char *argv[])
{
	cybozu::Option opt;
	size_t db, de, d;
	size_t b;
	bool msm, show;
	int C;
	opt.appendOpt(&b, 0, "b", ": set bucket size");
	opt.appendOpt(&d, 9, "d", ": set n to 1<<d");
	opt.appendOpt(&db, 0, "db", ": set begin of d");
	opt.appendOpt(&de, 0, "de", ": set end of d");
	opt.appendOpt(&C, 10, "c", ": count of loop");
	opt.appendBoolOpt(&msm, "msm", ": msm bench");
	opt.appendBoolOpt(&show, "show", ": show params");
	opt.appendHelp("h", ": show this message");
	if (!opt.parse(argc, argv)) {
		opt.usage();
		return 1;
	}
	if (show) {
		mcl::msm::showParams();
		return 0;
	}
	if (db == 0) {
		db = d;
	}
	if (de == 0) {
		de = d;
	}
#if MCL_FP_BIT == 256
	puts("BN254");
	mcl::initPairing(mcl::BN254);
#else
	puts("BLS12_381");
	mcl::initPairing(mcl::BLS12_381);
#endif
	if (mcl::G1::msmKernel == 0) {
		if (!(mcl::bint::getCpuType() & mcl::bint::tAVX512_IFMA)) {
			puts("skip : the CPU does not support AVX-512 IFMA");
			puts("ctest:name=msm_test, module=0, total=0, ok=0, ng=0, exception=0, skipped=1");
			return 0;
		}
		puts("ERR the AVX-512 MSM is not available");
		return 1;
	}
	mcl::msm::g_mont.init(mcl::Fp::getOp().mp);
	if (msm) {
		mcl::msm::msmBench(C, db, de, b);
		return 0;
	}
	return cybozu::test::autoRun.run(argc, argv);
}
#endif
