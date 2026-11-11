/**
	@file
	@brief the kernel of the multi scalar multiplication with AVX-512 IFMA (included by src/msm_avx.cpp)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

	This file is included twice by msm_avx.cpp : for G1 (the base field Fp, the scalar field Fr) and
	for GG (Grumpkin : the base field Fr, the scalar field Fp, only if MCL_FP_BIT=256).
	The runtime constants of the curve (g_rt) are the static globals of each namespace, so the two kernels
	can be registered at the same time (G1 of BN_SNARK1 and GG for the 2-cycle).
	MCL_MSM_FP : the base field (mcl::Fp / mcl::Fr), MCL_MSM_FR : the scalar field (mcl::Fr / mcl::Fp),
	MCL_MSM_G1 : the group (mcl::G1 / mcl::GG), MCL_MSM_NS : the namespace in mcl (msm / msm_gg),
	MCL_MSM_FP_BIT / MCL_MSM_FR_BIT : the max bit size of the base / scalar field (MCL_FP_BIT / MCL_FR_BIT or the swap)
	The MsmCurvePara table (msm_avx_para.h) is shared.
*/
#if !defined(MCL_MSM_FP) || !defined(MCL_MSM_FR) || !defined(MCL_MSM_G1) || !defined(MCL_MSM_NS) || !defined(MCL_MSM_FP_BIT) || !defined(MCL_MSM_FR_BIT)
	#error "msm_avx_impl.hpp must be included by msm_avx.cpp with the MCL_MSM_* macros"
#endif

namespace mcl { namespace MCL_MSM_NS {

namespace {

typedef MCL_MSM_FP Fp; // the base field
typedef MCL_MSM_FR Fr; // the scalar field
typedef MCL_MSM_G1 G1; // the group

// the fixed-width GLV split of G1 (set by initMsm, see GLV1T::splitRaw in src/glv.hpp)
typedef uint32_t (*SplitRawFunc)(Unit *a, Unit *b, const Unit *x);
static SplitRawFunc g_splitRaw;

static const size_t S = sizeof(Unit)*8-1; // 63
static const size_t W = 52;
static const size_t M = sizeof(Vec) / sizeof(Unit); // the number of lanes (8)
static const size_t N = MSM_N; // the number of 52-bit limbs of FpM (= ceil(MCL_FP_BIT / 52), 5 or 8)
static const size_t unitN = MCL_MSM_FP_BIT / 64; // the number of 64-bit limbs of Fp (the max size, Fp::getOp().N <= unitN)
static const uint64_t g_mask = (uint64_t(1) << W) - 1;
static const CYBOZU_ALIGN(64) uint64_t g_offset_[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 };

// the raw data of Fr, Fp and G1
struct FrA {
	uint64_t v[MCL_MSM_FR_BIT / 64];
};

struct FpA {
	uint64_t v[unitN];
};

struct G1A {
	uint64_t v[unitN*3];
};

/*
	the constants of the current curve expanded to the SIMD lanes (set by initMsm from g_msmCurveTbl)
	the A versions (VecA) have vN * M lanes
*/
struct RtPara {
	uint64_t mask[M];
	uint64_t rp[M];
	uint64_t ap[N*M];
	uint64_t zero[N*M];
	uint64_t R[N*M];
	uint64_t R2[N*M];
	uint64_t rawOne[N*M];
	uint64_t m64to52[N*M];
	uint64_t m52to64[N*M];
	uint64_t rw[N*M];
	uint64_t b3[N*M];
	uint64_t zeroJacobi[3*N*M]; // (0, 0, 0)
	uint64_t zeroProj[3*N*M]; // (0, 1, 0)
	uint64_t zeroA[N*M*vN];
	uint64_t RA[N*M*vN];
	uint64_t R2A[N*M*vN];
	uint64_t rawOneA[N*M*vN];
	uint64_t m64to52A[N*M*vN];
	uint64_t m52to64A[N*M*vN];
	uint64_t rwA[N*M*vN];
	uint64_t b3A[N*M*vN];
	uint64_t zeroJacobiA[3*N*M*vN];
	uint64_t zeroProjA[3*N*M*vN];
	uint64_t m64to52u[N]; // for FpM::mul(z, x, const uint64_t*) (broadcast)
	uint64_t m52to64u[N];
	uint64_t m52to64s[unitN]; // for Fp::mul (the Montgomery form of Fp, or R52^-1 if Fp is not in the Montgomery form)
	size_t pN; // Fp::getOp().N
	int curveType;
	int specialB; // ec::local::Plus1 / Plus4 / GenericB by the b of the curve (EcMT::specialB_)
};
static CYBOZU_ALIGN(64) RtPara g_rt;

struct G {
	static const Vec& mask() { return *(const Vec*)g_rt.mask; }
	static const Vec& rp() { return *(const Vec*)g_rt.rp; }
	static const Vec* ap() { return (const Vec*)g_rt.ap; }
};

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

inline uint16_t cvtToInt(const VmaskA& v)
{
	uint16_t r = 0;
	for (size_t i = 0; i < vN; i++) r |= uint16_t(cvtToInt(v.v[i])) << (8 * i);
	return r;
}

inline bool isEqual(const Vec& a, const Vec& b)
{
	return memcmp(&a, &b, sizeof(a)) == 0;
}

inline bool isEqual(const VecA& a, const VecA& b)
{
	return memcmp(&a, &b, sizeof(a)) == 0;
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

inline void dump(const VecA& v, const char *msg = nullptr)
{
	if (msg) printf("%s\n", msg);
	for (size_t i = 0; i < 2; i++) {
		printf("%zd ", i);
		dump(v.v[i]);
	}
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

/*
	d[] = transpose(s[]), destroy s[]
	s = [a7, a6, a5, a4, a3, a2, a1, a0]
	    [b7, b6, b5, b4, b3, b2, b1, b0]
	    [c7, c6, c5, c4, c3, c2, c1, c0]
	    ....
*/
template<bool out8=true>
inline void trans8x8(Vec d[8], Vec s[8])
{
	d[0] = vpunpcklqdq(s[0], s[1]);
	d[1] = vpunpckhqdq(s[0], s[1]);
	d[2] = vpunpcklqdq(s[2], s[3]);
	d[3] = vpunpckhqdq(s[2], s[3]);
	d[4] = vpunpcklqdq(s[4], s[5]);
	d[5] = vpunpckhqdq(s[4], s[5]);
	d[6] = vpunpcklqdq(s[6], s[7]);
	d[7] = vpunpckhqdq(s[6], s[7]);

	s[0] = vshuffi64x2<0x44>(d[0], d[2]);
	s[1] = vshuffi64x2<0x44>(d[1], d[3]);
	s[2] = vshuffi64x2<0x44>(d[4], d[6]);
	s[3] = vshuffi64x2<0x44>(d[5], d[7]);
	s[4] = vshuffi64x2<0xee>(d[0], d[2]);
	s[5] = vshuffi64x2<0xee>(d[1], d[3]);
	s[6] = vshuffi64x2<0xee>(d[4], d[6]);
	s[7] = vshuffi64x2<0xee>(d[5], d[7]);

	d[0] = vshuffi64x2<0x88>(s[0], s[2]);
	d[1] = vshuffi64x2<0x88>(s[1], s[3]);
	d[2] = vshuffi64x2<0xdd>(s[0], s[2]);
	d[3] = vshuffi64x2<0xdd>(s[1], s[3]);
	d[4] = vshuffi64x2<0x88>(s[4], s[6]);
	d[5] = vshuffi64x2<0x88>(s[5], s[7]);
	if (out8) {
		d[6] = vshuffi64x2<0xdd>(s[4], s[6]);
		d[7] = vshuffi64x2<0xdd>(s[5], s[7]);
	}
}

template<class V, class U>
inline void vaddPre(V *z, const V *x, const U *y)
{
	V t = vpaddq(x[0], y[0]);
	V c = vpsrlq(t, W);
	z[0] = vpandq(t, G::mask());

	for (size_t i = 1; i < N; i++) {
		t = vpaddq(x[i], y[i]);
		t = vpaddq(t, c);
		if (i == N-1) {
			z[i] = t;
			return;
		}
		c = vpsrlq(t, W);
		z[i] = vpandq(t, G::mask());
	}
}

template<class VM=Vmask, class V, class U>
inline VM vsubPre(V *z, const V *x, const U *y)
{
	V t = vpsubq(x[0], y[0]);
	V c = vpsrlq(t, S);
	z[0] = vpandq(t, G::mask());
	for (size_t i = 1; i < N; i++) {
		t = vpsubq(x[i], y[i]);
		t = vpsubq(t, c);
		c = vpsrlq(t, S);
		z[i] = vpandq(t, G::mask());
	}
	return vpcmpneqq(c, vzero());
}

template<class VM=Vmask, class V>
inline void uvselect(V *z, const VM& c, const V *a, const V *b)
{
	for (size_t i = 0; i < N; i++) {
		z[i] = vselect(c, a[i], b[i]);
	}
}

template<class VM=Vmask, class V>
inline void vadd(V *z, const V *x, const V *y)
{
	V sN[N], tN[N];
	vaddPre(sN, x, y);
	VM c = vsubPre<VM>(tN, sN, G::ap());
	uvselect(z, c, sN, tN);
}

template<class VM=Vmask, class V>
inline void vsub(V *z, const V *x, const V *y)
{
	V sN[N], tN[N];
	VM c = vsubPre<VM>(sN, x, y);
	vaddPre(tN, sN, G::ap());
	tN[N-1] = vpandq(tN[N-1], G::mask());
	uvselect(z, c, tN, sN);
}

template<class V>
inline void vmulUnit(V *z, const V *x, const V& y)
{
	V H;
	z[0] = vmulL(x[0], y);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < N; i++) {
		z[i] = vmulL(x[i], y, H);
		H = vmulH(x[i], y);
	}
	z[N] = H;
}

template<class V, class U>
inline V vmulUnitAdd(V *z, const U *x, const V& y)
{
	V H;
#if 1
	V v = x[0];
	z[0] = vmulL(v, y, z[0]);
	H = vmulH(v, y, z[1]);
	for (size_t i = 1; i < N-1; i++) {
		v = x[i];
		z[i] = vmulL(v, y, H);
		H = vmulH(v, y, z[i+1]);
	}
	v = x[N-1];
	z[N-1] = vmulL(v, y, H);
	H = vmulH(v, y);
	return H;
#else
	z[0] = vmulL(x[0], y, z[0]);
	H = vmulH(x[0], y);
	for (size_t i = 1; i < N; i++) {
		z[i] = vpaddq(vmulL(x[i], y, H), z[i]);
		H = vmulH(x[i], y);
	}
	return H;
#endif
}

template<class V>
inline void vmulPre(V z[N*2], const V x[N], const V y[N])
{
	vmulUnit(z, x, y[0]);
	for (size_t i = 1; i < N; i++) {
		z[N+i] = vmulUnitAdd(z+i, x, y[i]);
	}
}

// t[N] = c ? a[N] : zero
template<class VM, class V>
inline void vset(V *t, const VM& c, const V a[N])
{
	for (size_t i = 0; i < N; i++) {
		t[i] = vselect(c, a[i], vzero());
	}
}

template<class VM=Vmask, class V>
inline void vmont(V z[N], V xy[N*2])
{
	for (size_t i = 0; i < N; i++) {
		V q = vmulL(xy[i], G::rp());
		xy[N+i] = vpaddq(xy[N+i], vmulUnitAdd(xy+i, G::ap(), q));
		xy[i+1] = vpaddq(xy[i+1], vpsrlq(xy[i], W));
	}
	for (size_t i = N; i < N*2-1; i++) {
		xy[i+1] = vpaddq(xy[i+1], vpsrlq(xy[i], W));
		xy[i] = vpandq(xy[i], G::mask());
	}
	VM c = vsubPre(z, xy+N, G::ap());
	uvselect(z, c, xy+N, z);
}

template<class V, class U = V>
inline V broadcast(const U& v);

template<>
inline Vec broadcast(const Vec& v) { return v; }
template<>
inline VecA broadcast(const VecA& v) { return v; }
template<>
inline Vec broadcast(const uint64_t& v) { return vpbroadcastq(v); }
template<>
inline VecA broadcast(const uint64_t& v)
{
	VecA r;
	r.v[0] = broadcast<Vec>(v);
	r.v[1] = broadcast<Vec>(v);
	return r;
}

template<class VM=Vmask, class V, typename U>
inline void vmul(V *z, const V *x, const U *y)
{
#if 0
	V xy[N*2];
	vmulPre(xy, x, y);
	vmont(z, xy);
#else
	V t[N*2], q;
	vmulUnit(t, x, broadcast<V>(y[0]));
	q = vmulL(t[0], G::rp());
	t[N] = vpaddq(t[N], vmulUnitAdd(t, G::ap(), q));
	for (size_t i = 1; i < N; i++) {
		t[N+i] = vmulUnitAdd(t+i, x, broadcast<V>(y[i]));
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		q = vmulL(t[i], G::rp());
		t[N+i] = vpaddq(t[N+i], vmulUnitAdd(t+i, G::ap(), q));
	}
	for (size_t i = N; i < N*2; i++) {
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		t[i-1] = vpandq(t[i-1], G::mask());
	}
	VM c = vsubPre<VM>(z, t+N, G::ap());
	uvselect(z, c, t+N, z);
#endif
}

template<class VM=Vmask, class V>
inline void vsqr(V *z, const V *x)
{
#if 0
	V t[N*2];
	vmulUnit(t, x, x[0]);
	V q = vmulL(t[0], G::rp());
	t[N] = vpaddq(t[N], vmulUnitAdd(t, G::ap(), q));
	for (size_t i = 1; i < N; i++) {
		t[N+i] = vmulUnitAdd(t+i, x, x[i]);
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		q = vmulL(t[i], G::rp());
		t[N+i] = vpaddq(t[N+i], vmulUnitAdd(t+i, G::ap(), q));
	}
#else
	V t[N*2];
	t[0] = vmulL(x[0], x[0]);
	for (size_t i = 1; i < N; i++) {
		t[i*2-1] = vmulL(x[i], x[i-1]);
		t[i*2  ] = vmulH(x[i], x[i-1]);
	}
	for (size_t i = 2; i < N; i++) {
		for (size_t j = i; j < N; j++) {
			t[j*2-i  ] = vmulL(x[j], x[j-i], t[j*2-i  ]);
			t[j*2-i+1] = vmulH(x[j], x[j-i], t[j*2-i+1]);
		}
	}
	for (size_t i = 1; i < N*2-1; i++) {
		t[i] = vpaddq(t[i], t[i]);
	}
	for (size_t i = 1; i < N; i++) {
		t[i*2-1] = vmulH(x[i-1], x[i-1], t[i*2-1]);
		t[i*2] = vmulL(x[i], x[i], t[i*2]);
	}
	t[N*2-1] = vmulH(x[N-1], x[N-1]);

	for (size_t i = 0; i < N; i++) {
		if (i > 0) t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		V q = vmulL(t[i], G::rp());
		t[N+i] = vpaddq(t[N+i], vmulUnitAdd(t+i, G::ap(), q));
	}
#endif
	for (size_t i = N; i < N*2; i++) {
		t[i] = vpaddq(t[i], vpsrlq(t[i-1], W));
		t[i-1] = vpandq(t[i-1], G::mask());
	}
	VM c = vsubPre<VM>(z, t+N, G::ap());
	uvselect(z, c, t+N, z);
}

template<class V>
inline V getUnitAt(const V *x, size_t xN, size_t bitPos)
{
	const size_t bitSize = 64;
	const size_t q = bitPos / bitSize;
	const size_t r = bitPos % bitSize;
	if (r == 0) return x[q];
	if (q == xN - 1) return vpsrlq(x[q], r);
	return vporq(vpsrlq(x[q], r), vpsllq(x[q+1], bitSize - r));
}

/*
	y[N] (52-bit limbs) = x[unitN] (64-bit limbs)
	e.g. unitN = 6, N = 8 :
	 |64   |64   |64   |64   |64    |64   |
	x|52:12|40:24|28:36|16:48|4:52:8|44:20|
	y|52|52   |52   |52   |52  |52|52  |20|
	the loops are unrolled with constant shifts (N and unitN are constants)
*/
template<class V>
inline void split52bit(V y[N], const V x[unitN])
{
	assert(&y != &x);
	const Vec m = vpbroadcastq(g_mask);
	for (size_t i = 0; i < N; i++) {
		const size_t bit = W * i;
		const size_t w = bit / 64;
		const size_t s = bit % 64;
		V t = (s == 0) ? x[w] : vpsrlq(x[w], s);
		if (s + W > 64 && w + 1 < unitN) {
			// and(or(A, B), C) = 0xA8
			y[i] = vpternlogq<0xA8>(t, vpsllq(x[w+1], 64 - s), m);
		} else if (i < N - 1) {
			y[i] = vpandq(t, m);
		} else {
			y[i] = t; // the top limb has at most 52 bits
		}
	}
}

/*
	y[unitN] (64-bit limbs) = x[N] (52-bit limbs)
	e.g. unitN = 6, N = 8 :
	 |52|52   |52   |52   |52  |52|52  |20|
	x|52|12:40|24:28|36:16|48:4|52|8:44|20|
	y|64   |64   |64   |64   |64    |64
*/
template<class V>
inline void concat52bit(V y[unitN], const V x[N])
{
	assert(&y != &x);
	for (size_t w = 0; w < unitN; w++) {
		V t = vzero<V>();
		bool first = true;
		for (size_t i = 0; i < N; i++) {
			const size_t lo = W * i; // the limb i has the bits [lo, lo + W)
			if (lo + W <= 64 * w || lo >= 64 * (w + 1)) continue;
			V u = (lo >= 64 * w) ? vpsllq(x[i], lo - 64 * w) : vpsrlq(x[i], 64 * w - lo);
			if (lo == 64 * w) u = x[i];
			t = first ? u : vporq(t, u);
			first = false;
		}
		y[w] = t;
	}
}

// the scalar version of concat52bit for one point
inline void concat52bitScalar(Unit y[unitN], const Unit x[N])
{
	for (size_t w = 0; w < unitN; w++) {
		Unit t = 0;
		for (size_t i = 0; i < N; i++) {
			const size_t lo = W * i;
			if (lo + W <= 64 * w || lo >= 64 * (w + 1)) continue;
			t |= (lo >= 64 * w) ? x[i] << (lo - 64 * w) : x[i] >> (64 * w - lo);
		}
		y[w] = t;
	}
}

/*
	G1 (= unitN U x 3 (x, y, z)) x 8 => N U x 8 x 3
	the index table of vpgatherqq : the i-th lane picks up the i-th G1 (or Fp)
*/
template<size_t stride>
struct PickUp {
	static const Vec& get()
	{
		static const CYBOZU_ALIGN(64) uint64_t tbl[M] = {
			stride*0, stride*1, stride*2, stride*3, stride*4, stride*5, stride*6, stride*7,
		};
		return *(const Vec*)tbl;
	}
};
inline const Vec& pickUpEc() { return PickUp<unitN*3>::get(); }
inline const Vec& pickUpFp() { return PickUp<unitN>::get(); }

/*
	gather the i-th 64-bit limb of the 8 elements (stride Units each) from x into t[i] for i < unitN
	the limbs of Fp beyond Fp::getOp().N may be garbage (Fp does not clear them), so they are set to zero
*/
inline void gatherFpx8(Vec t[unitN], const Unit *x, const Vec& idx)
{
	for (size_t i = 0; i < unitN; i++) {
		t[i] = (i < g_rt.pN) ? vpgatherqq(idx, x+i) : vzero();
	}
}

// convert G1.x (, y or z) to Vec
inline void cvtFromG1Ax(Vec *y, const Unit *x)
{
	Vec t[unitN];
	gatherFpx8(t, x, pickUpEc());
	split52bit(y, t);
}

// convert G1.x (, y or z) to VecA
inline void cvtFromG1Ax(VecA *y, const Unit *x)
{
	VecA t[unitN];
	assert(vN == 2);
	Vec t0[unitN], t1[unitN];
	gatherFpx8(t0, x, pickUpEc());
	gatherFpx8(t1, x+unitN*3*M, pickUpEc());
	for (size_t i = 0; i < unitN; i++) {
		t[i].v[0] = t0[i];
		t[i].v[1] = t1[i];
	}
	split52bit(y, t);
}

// EcM(=N U x 8 x 3) => G1(= unitN U x 3) x 8
// convert Vec to G1.x
inline void cvtToG1Ax(Unit *y, const Vec *x)
{
	Vec t[unitN];
	concat52bit(t, x);
	for (size_t i = 0; i < unitN; i++) {
		vpscatterqq(y+i, pickUpEc(), t[i]);
	}
}

inline void cvtToG1Ax(Unit *y, const VecA *x)
{
	VecA t[unitN];
	concat52bit(t, x);
	for (size_t i = 0; i < unitN; i++) {
		vpscatterqq(y+i, pickUpEc(), t[i].v[0]);
		vpscatterqq(y+i+unitN*3*M, pickUpEc(), t[i].v[1]);
	}
}

// FpM(N U x 8) => Fp(= unitN U) x 8
inline void cvtFpMToFpAx(Unit y[unitN*M], const Vec x[N])
{
	Vec t[unitN];
	concat52bit(t, x);
	for (size_t i = 0; i < unitN; i++) {
		vpscatterqq(y+i, pickUpFp(), t[i]);
	}
}
// Fp(= unitN U) x 8 => FpM(N U x 8)
inline void cvtFpAxToFpM(Vec y[N], const Unit x[unitN*M])
{
	Vec t[unitN];
	gatherFpx8(t, x, pickUpFp());
	split52bit(y, t);
}

template<class T, class _VM=Vmask, class _V=Vec>
struct FpMT {
	typedef _VM VM;
	typedef _V V;
	V v[N];
	static void add(T& z, const T& x, const T& y)
	{
		vadd<VM>(z.v, x.v, y.v);
	}
	static void mul2(T& z, const T& x)
	{
		add(z, x, x);
	}
	static void sub(T& z, const T& x, const T& y)
	{
		vsub<VM>(z.v, x.v, y.v);
	}
	static void neg(T& z, const T& x)
	{
		T::sub(z, T::zero(), x);
	}
	T neg() const
	{
		T t;
		T::sub(t, T::zero(), static_cast<const T&>(*this));
		return t;
	}
	static void mul(T& z, const T& x, const T& y)
	{
		vmul<VM>(z.v, x.v, y.v);
	}
	static void mul(T& z, const T& x, const uint64_t y[N])
	{
		vmul<VM>(z.v, x.v, y);
	}
	static void sqr(T& z, const T& x)
	{
		vsqr<VM>(z.v, x.v);
//		mul(z, x, x);
	}
	void toMont(T& x) const
	{
		mul(x, *this, T::R2());
	}
	void fromMont(const T &x)
	{
		mul(*this, x, T::rawOne());
	}
	void clear()
	{
		memset(this, 0, sizeof(*this));
	}
	bool operator==(const T& rhs) const
	{
		return memcmp(this, &rhs, sizeof(rhs)) == 0;
	}
	bool operator!=(const T& rhs) const { return !operator==(rhs); }
	VM isEqualAll(const T& rhs) const
	{
		V t = vpxorq(v[0], rhs.v[0]);
		for (size_t i = 1; i < N; i++) {
			t = vporq(t, vpxorq(v[i], rhs.v[i]));
		}
		return vpcmpeqq(t, vzero());
	}
	VM isZero() const
	{
		V t = v[0];
		for (size_t i = 1; i < N; i++) {
			t = vporq(t, v[i]);
		}
		return vpcmpeqq(t, vzero());
	}
	VM isOne() const
	{
		return isEqualAll(T::one());
	}
	T& operator*=(const T& rhs)
	{
		T& self = static_cast<T&>(*this);
		mul(self, self, rhs);
		return self;
	}
	static void pow(T& z, const T& x, const V *y, size_t yn)
	{
		const int w = 4;
		assert(w == 4);
		const int tblN = 1<<w;
		T tbl[tblN];
		tbl[0] = T::one();
		tbl[1] = x;
		for (size_t i = 2; i < tblN; i++) {
			mul(tbl[i], tbl[i-1], x);
		}
		const size_t bitLen = sizeof(Unit)*8;
		const size_t jn = bitLen / w;
		z = tbl[0];
		const Vec mask4 = vpbroadcastq(getMask(w));
		for (size_t i = 0; i < yn; i++) {
			const Vec& v = y[yn-1-i];
			for (size_t j = 0; j < jn; j++) {
				for (int k = 0; k < w; k++) T::sqr(z, z);
				Vec idx = vpandq(vpsrlq(v, bitLen-w-j*w), mask4);
				idx = vmulL(idx, vpbroadcastq(sizeof(T) / 8), T::offset()); // the stride of tbl[] in Unit
				T t;
				for (size_t k = 0; k < N; k++) {
					t.v[k] = vpgatherqq(idx, &tbl[0].v[k]);
				}
				mul(z, z, t);
			}
		}
	}
	// condition set (set x if c)
	void cset(const VM& c, const T& x)
	{
		for (size_t i = 0; i < N; i++) {
			v[i] = vselect(c, x.v[i], v[i]);
		}
	}
	// return c ? a : b;
	static T select(const VM& c, const T& a, const T& b)
	{
#if 0 // faster on gcc, same on clang
		const V mask = ::vselect(c, broadcast(uint64_t(-1)), broadcast(0));
		T d;
		for (size_t i = 0; i < N; i++) {
			d.v[i] = vporq(vpandq(mask, a.v[i]), vpandnq(mask, b.v[i]));
		}
		return d;
#else
		T d;
		for (size_t i = 0; i < N; i++) {
			d.v[i] = vselect(c, a.v[i], b.v[i]);
		}
		return d;
#endif
	}
};

struct FpM : FpMT<FpM, Vmask, Vec> {
	static const Vec& offset() { return *(const Vec*)g_offset_; }
	static const FpM& zero() { return *(const FpM*)g_rt.zero; }
	static const FpM& one() { return *(const FpM*)g_rt.R; }
	static const FpM& R2() { return *(const FpM*)g_rt.R2; }
	static const FpM& rawOne() { return *(const FpM*)g_rt.rawOne; }
	static const FpM& m64to52() { return *(const FpM*)g_rt.m64to52; }
	static const FpM& m52to64() { return *(const FpM*)g_rt.m52to64; }
	static const FpM& rw() { return *(const FpM*)g_rt.rw; }
	void setFpA(const FpA v[M])
	{
		cvtFpAxToFpM(this->v, v[0].v);
		FpM::mul(*this, *this, g_rt.m64to52u);
	}
	void getFpA(FpA v[M]) const
	{
		FpM t;
		FpM::mul(t, *this, g_rt.m52to64u);
		cvtFpMToFpAx((Unit*)v, t.v);
	}
	static void inv(FpM& z, const FpM& x)
	{
		CYBOZU_ALIGN(64) FpA v[M];
		Fp* vv = (Fp*)v;
		x.getFpA(v);
		mcl::invVec<Fp>(vv, vv, M, M);
		z.setFpA(v);
	}
#ifdef MCL_MSM_TEST
	void set(const mpz_class& x, size_t i);
	void set(const mpz_class& x);
	mpz_class getRaw(size_t i) const;
	mpz_class get(size_t i) const;
#endif
};

/*
	the SIMD kernel of the batch affine addition of G1::mulVec (ec::MsmKernel, see mulVecUpdateTableBatch in src/glv.hpp)
	AffM : a point in the layout of the kernel. x and y are N limbs of W bits in the Montgomery form of FpM (R = 2^(W N)).
	The zero point is represented by y = 0 (the group has a prime order, so no point has y = 0).
	A point of order 2 (y = 0) outside G1 such as (-1, 0) of BLS12-377 (the cofactor of E(Fp) is even ; it can be passed only if verifyOrderG1(false))
	is treated as the zero point by this kernel (the generic path of src/glv.hpp handles it correctly).
	addPairs processes 8 pairs at once : the points of the 8 lanes are loaded as 8 Vec (one point per Vec),
	transposed to FpM (one limb per Vec) by trans8x8, the formula is computed by FpM with the masks of the lanes
	(zero, doubling, A = -B) and the result is transposed back. The denominators of lambda of all the pairs
	are inverted at once by the Montgomery trick over FpM (one FpM::inv per MCL_MSM_KERNEL_SUB groups).
	cost : 5M + 2S + 1 inv/(8 MCL_MSM_KERNEL_SUB) per 8 pairs (+ the transposes)
*/
struct AffM {
	Unit x[N];
	Unit y[N];
};

#ifndef MCL_MSM_KERNEL_SUB
	// the number of groups (8 pairs each) sharing one FpM::inv
	#define MCL_MSM_KERNEL_SUB 256
#endif

// the work area of addPairsAffM
struct AffMWork {
	static const size_t SUB = MCL_MSM_KERNEL_SUB;
	FpM d[SUB]; // the denominator of lambda, then its inverse
	FpM num[SUB]; // the numerator of lambda
	FpM ax[SUB]; // A.x (the x of the output if the lane is skipped)
	FpM ay[SUB]; // A.y (the y of the output if the lane is skipped, 0 if the output is zero)
	FpM bx[SUB]; // B.x
	FpM prod[SUB]; // the work of the Montgomery trick
	uint8_t skip[SUB]; // the lanes whose output is (ax, ay)
};

static CYBOZU_ALIGN(64) const AffM g_zeroAffM = { { 0 }, { 0 } };

// return the point of the index i (the zero point if i == msmNone)
inline const AffM* getAffM(const AffM *base, uint32_t i)
{
	return i == mcl::ec::local::msmNone ? &g_zeroAffM : base + (i & mcl::ec::local::msmIdxMask);
}

#ifndef MCL_MSM_PREFETCH_DIST
	// the distance (in pairs) of the software prefetch of addPairsAffM (0 : no prefetch ; the same name as in src/glv.hpp for the generic kernel, which is not visible here)
	#define MCL_MSM_PREFETCH_DIST 32
#endif
// the distance in groups of 8 pairs
#define MSM_PREFETCH_GROUPS ((MCL_MSM_PREFETCH_DIST + 7) / 8)
// prefetch the point (sizeof(AffM) = 2 N * 8 bytes : one or two cache lines)
inline void prefetchAffM(const AffM *p)
{
	prefetchT0(p);
	if (sizeof(AffM) > 64) prefetchT0((const char*)p + 64);
}

// load the N limbs of a coordinate of AffM (64-byte aligned if N == 8)
inline Vec loadLimbs(const Unit *p)
{
	if (N == 8) return vmovdqa64(p);
	return vmovdqu64(Vmask((1 << N) - 1), p);
}
inline void storeLimbs(Unit *p, const Vec& v)
{
	if (N == 8) {
		vmovdqa64(p, v);
	} else {
		vmovdqu64(p, Vmask((1 << N) - 1), v);
	}
}

// (x, y) = the 8 points base[idx[j]] transposed to FpM (the limbs i >= N of s[] are ignored)
inline void loadAffM(FpM& x, FpM& y, const AffM *base, const uint32_t idx[8])
{
	const AffM *P[8];
	Vec s[8];
	for (size_t j = 0; j < 8; j++) P[j] = getAffM(base, idx[j]);
	for (size_t j = 0; j < 8; j++) s[j] = loadLimbs(P[j]->x);
	Vec d[8];
	trans8x8(d, s);
	for (size_t i = 0; i < N; i++) x.v[i] = d[i];
	for (size_t j = 0; j < 8; j++) s[j] = loadLimbs(P[j]->y);
	trans8x8(d, s);
	for (size_t i = 0; i < N; i++) y.v[i] = d[i];
}

// R[j] = (x, y) of the lane j for j in [0, m) (m <= 8)
inline void storeAffM(AffM *R, const FpM& x, const FpM& y, size_t m)
{
	Vec s[8], d[8];
	for (size_t i = 0; i < N; i++) s[i] = x.v[i];
	for (size_t i = N; i < 8; i++) s[i] = vzero();
	trans8x8(d, s);
	for (size_t j = 0; j < m; j++) storeLimbs(R[j].x, d[j]);
	for (size_t i = 0; i < N; i++) s[i] = y.v[i];
	for (size_t i = N; i < 8; i++) s[i] = vzero();
	trans8x8(d, s);
	for (size_t j = 0; j < m; j++) storeLimbs(R[j].y, d[j]);
}

// (X, Y) = the affine coordinates of src[j] (affine or zero) for j in [0, m) (m <= 8), Y = 0 for the zero point (the other lanes are undefined)
inline void loadAffx8(FpM& X, FpM& Y, const G1 *src, size_t m)
{
	G1 tmp[8];
	if (m < 8) {
		for (size_t j = 0; j < 8; j++) {
			if (j < m) tmp[j] = src[j]; else tmp[j].clear();
		}
		src = tmp;
	}
	const Unit *p = (const Unit*)src;
	cvtFromG1Ax(X.v, p);
	cvtFromG1Ax(Y.v, p + unitN);
	FpM::mul(X, X, g_rt.m64to52u);
	FpM::mul(Y, Y, g_rt.m64to52u);
	uint8_t nz = 0; // the lanes of the non-zero points
	for (size_t j = 0; j < 8; j++) {
		if (!src[j].z.isZero()) nz |= uint8_t(1 << j);
	}
	Y = FpM::select(Vmask(nz), Y, FpM::zero());
}

// dst[i] = xVec[i] (affine or zero) for i in [0, n)
void cvtBaseAffM(void *dst, const void *xVec, size_t n)
{
	AffM *d = (AffM*)dst;
	const G1 *x = (const G1*)xVec;
	for (size_t i = 0; i < n; i += 8) {
		const size_t m = (n - i < 8) ? n - i : 8;
		FpM X, Y;
		loadAffx8(X, Y, x + i, m);
		storeAffM(d + i, X, Y, m);
	}
}

/*
	dst[i] = s(neg[i] & 1) xVec[i], dst[n + i] = s(neg[i] & 2) lambda(xVec[i]) for i in [0, n), see ec::MsmKernel::cvtBaseGLV
	the copy of xVec (2 n G1), mulLambda and the negations of mulVecGLVlarge are fused into the conversion (one FpM::mul per 8 points for lambda)
*/
void cvtBaseGLVAffM(void *dst, const void *xVec, size_t n, const uint8_t *neg)
{
	AffM *d = (AffM*)dst;
	const G1 *x = (const G1*)xVec;
	const FpM& rw = FpM::rw();
	for (size_t i = 0; i < n; i += 8) {
		const size_t m = (n - i < 8) ? n - i : 8;
		FpM X, Y;
		loadAffx8(X, Y, x + i, m);
		uint8_t neg1 = 0, neg2 = 0; // the lanes to negate
		for (size_t j = 0; j < m; j++) {
			if (neg[i + j] & 1) neg1 |= uint8_t(1 << j);
			if (neg[i + j] & 2) neg2 |= uint8_t(1 << j);
		}
		FpM negY;
		FpM::neg(negY, Y); // the zero point (Y = 0) stays zero
		FpM X2, Y1, Y2;
		Y1 = FpM::select(Vmask(neg1), negY, Y);
		Y2 = FpM::select(Vmask(neg2), negY, Y);
		FpM::mul(X2, X, rw);
		storeAffM(d + i, X, Y1, m);
		storeAffM(d + n + i, X2, Y2, m);
	}
}

/*
	R[j] = P(ia[j]) + P(ib[j]) for j in [0, m), see addAffineBatch in src/glv.hpp
	all the inputs of a sub-block of 8 MCL_MSM_KERNEL_SUB pairs are read before its outputs are written
*/
void addPairsAffM(void *_R, const void *_base, const uint32_t *ia, const uint32_t *ib, size_t m, void *_work)
{
	using namespace mcl::ec::local;
	AffM *R = (AffM*)_R;
	const AffM *base = (const AffM*)_base;
	AffMWork& wk = *(AffMWork*)_work;
	const size_t SUB = AffMWork::SUB;
	const FpM& one = FpM::one();
	const FpM& zero = FpM::zero();
	for (size_t j0 = 0; j0 < m; j0 += SUB * 8) {
		const size_t mm = (m - j0 < SUB * 8) ? m - j0 : SUB * 8; // the number of pairs of this sub-block
		const size_t gn = (mm + 7) / 8; // the number of groups
		// pass 1 : classify the lanes and compute d and num
		for (size_t g = 0; g < gn; g++) {
			const size_t j = j0 + g * 8;
			const uint32_t *pa = ia + j;
			const uint32_t *pb = ib + j;
			/*
				software prefetch of the points of the group g + MSM_PREFETCH_GROUPS
				(the reads of base at the level 0 are random and the base of 2^19 points or more exceeds the L3 cache)
			*/
			if (MSM_PREFETCH_GROUPS > 0 && j + 8 * (MSM_PREFETCH_GROUPS + 1) <= m) {
				const uint32_t *qa = pa + 8 * MSM_PREFETCH_GROUPS;
				const uint32_t *qb = pb + 8 * MSM_PREFETCH_GROUPS;
				for (size_t k = 0; k < 8; k++) {
					prefetchAffM(getAffM(base, qa[k]));
					prefetchAffM(getAffM(base, qb[k]));
				}
			}
			uint32_t ta[8], tb[8];
			if (j + 8 > m) {
				// the last group has less than 8 pairs
				for (size_t k = 0; k < 8; k++) {
					ta[k] = (j + k < m) ? ia[j + k] : msmNone;
					tb[k] = (j + k < m) ? ib[j + k] : msmNone;
				}
				pa = ta;
				pb = tb;
			}
			FpM Ax, Ay, Bx, By;
			loadAffM(Ax, Ay, base, pa);
			loadAffM(Bx, By, base, pb);
			// negate y of the lanes with the sign bit (-0 = 0 for the zero point)
			uint8_t sa = 0, sb = 0;
			for (size_t k = 0; k < 8; k++) {
				sa |= uint8_t((pa[k] >> 31) << k);
				sb |= uint8_t((pb[k] >> 31) << k);
			}
			Ay = FpM::select(Vmask(sa), Ay.neg(), Ay);
			By = FpM::select(Vmask(sb), By.neg(), By);
			const Vmask zA = Ay.isZero();
			const Vmask zB = By.isZero();
			const Vmask eqX = Ax.isEqualAll(Bx);
			const Vmask eqY = Ay.isEqualAll(By);
			const Vmask nz = knotb(korb(zA, zB));
			const Vmask dbl = kandb(kandb(eqX, eqY), nz); // A = B
			const Vmask out0 = kandb(kandnb(eqY, eqX), nz); // A = -B
			const Vmask skip = korb(korb(zA, zB), out0);
			FpM d, num, t;
			FpM::sub(d, Bx, Ax);
			FpM::sub(num, By, Ay);
			if (cvtToInt(dbl)) {
				// doubling : lambda = 3 x^2 / (2 y) (a = 0), rare for random inputs so skip it if no lane needs it
				FpM t3;
				FpM::mul2(t, Ay);
				d = FpM::select(dbl, t, d);
				FpM::sqr(t, Ax);
				FpM::mul2(t3, t);
				FpM::add(t3, t3, t);
				num = FpM::select(dbl, t3, num);
			}
			d = FpM::select(skip, one, d);
			// the output of the skipped lanes : B if A = 0, A otherwise (y = 0 if A + B = 0)
			wk.ax[g] = FpM::select(zA, Bx, Ax);
			t = FpM::select(zA, By, Ay);
			wk.ay[g] = FpM::select(out0, zero, t);
			wk.bx[g] = Bx;
			wk.d[g] = d;
			wk.num[g] = num;
			wk.skip[g] = cvtToInt(skip);
		}
		// d[g] = 1/d[g] (d[g] != 0)
		mcl::local::invVecWork<false>(wk.d, wk.d, gn, wk.prod);
		// pass 2 : R = A + B
		for (size_t g = 0; g < gn; g++) {
			const size_t j = j0 + g * 8;
			const FpM& Ax = wk.ax[g];
			const FpM& Ay = wk.ay[g];
			FpM lambda, x3, y3;
			FpM::mul(lambda, wk.num[g], wk.d[g]);
			FpM::sqr(x3, lambda);
			FpM::sub(x3, x3, Ax);
			FpM::sub(x3, x3, wk.bx[g]); // = lambda^2 - 2 A.x if doubling
			FpM::sub(y3, Ax, x3);
			FpM::mul(y3, y3, lambda);
			FpM::sub(y3, y3, Ay); // y3 = lambda (x1 - x3) - y1
			const Vmask skip = Vmask(wk.skip[g]);
			x3 = FpM::select(skip, Ax, x3);
			y3 = FpM::select(skip, Ay, y3);
			storeAffM(R + j, x3, y3, (m - j < 8) ? m - j : 8);
		}
	}
}

/*
	convert a coordinate of AffM (the Montgomery form of FpM, a R52 mod p < p) to Fp (a R64 mod p)
	by Fp::mul with R64 / R52 (whose Montgomery form is g_rt.m52to64s)
*/
inline void cvtAffMtoFp(Fp& y, const Unit x[N])
{
	Unit t[unitN];
	concat52bitScalar(t, x);
	const mcl::fp::Op& op = Fp::getOp();
	op.fp_mul((Unit*)&y, t, g_rt.m52to64s, op.p);
}

/*
	the window size for n (split) scalars of mulVec with the kernel (see glvGetBucketSizeByCost in src/glv.hpp)
	the weights of the cost model fitted on Xeon w9-3495X with BLS12-381 G1 (N = 8) and BN254 G1 (N = 5) :
	the pair addition is much cheaper than the generic one, so the bucket reduction (r) and the fixed cost of a window
	(cvtBase, the sort and the inversions, c0) are relatively expensive and b is smaller than the generic one.
	the batched reduction (B >= MCL_MSM_REDUCE_MIN_B, r2 and m2 refitted on 2026-11-05 with r fixed) makes b larger by 1 or 2 for n >= 2^11.
	the model is within 6.4% (N = 8) / 4.1% (N = 5) of the measured best for n in [2^7, 2^19] split scalars (the valley is shallow, see CYBOZU_TEST_AUTO(bucketSize))
*/
size_t getBucketSizeAffM(size_t n, size_t maxBitSize, size_t pointSize)
{
	static const mcl::ec::MsmCostParam prm8 = { 498, 8410, 141, 1342 }; // r = 7.78, c0 = 131, r2 = 2.2, m2 = 21
	static const mcl::ec::MsmCostParam prm5 = { 291, 4601, 143, 694 }; // r = 4.55, c0 = 72, r2 = 2.2, m2 = 10.8
	// the bucket table is bounded by 2 MiB (L2 of x64) : the addition of the kernel is fast, so the cache misses of tbl[k] beyond L2 are
	// relatively expensive (b = 16 is 6-19% slower than b = 13 at 2^19 split scalars on Xeon w9-3495X, while the generic path prefers b = 16 there)
	const size_t maxTblBytes = size_t(2) << 20;
	return mcl::ec::glvGetBucketSizeByCost(n, maxBitSize, pointSize, (N == 5) ? prm5 : prm8, maxTblBytes);
}

// tbl (+)= P(i), see msmAddToBucket in src/glv.hpp
void addToBucketAffM(void *_tbl, const void *_base, uint32_t i)
{
	using namespace mcl::ec::local;
	G1& tbl = *(G1*)_tbl;
	const AffM& P = ((const AffM*)_base)[i & msmIdxMask];
	Unit y = 0;
	for (size_t k = 0; k < N; k++) y |= P.y[k];
	if (y == 0) return; // the zero point
	G1 Q;
	cvtAffMtoFp(Q.x, P.x);
	cvtAffMtoFp(Q.y, P.y);
	Q.z = 1;
	if (tbl.isZero()) {
		tbl = Q;
		if (i & msmSign) G1::neg(tbl, tbl);
	} else if (i & msmSign) {
		tbl -= Q;
	} else {
		tbl += Q;
	}
}

// set y = 1 if isProj
template<class E>
inline void normalizeJacobiVec(E *P, size_t n, bool isProj = false)
{
	typedef typename E::Fp F;
	bool alocated = false;
	F *tbl = 0;
#if 0
	if (sizeof(F) * n < 1024 * 1024) {
		tbl = (F*)CYBOZU_ALIGNED_ALLOCA(sizeof(F) * n, 64);
	} else
#endif
	{
		tbl = (F*)Xbyak::AlignedMalloc(sizeof(F) * n, 64);
		alocated = true;
	}
	tbl[0] = F::select(P[0].z.isZero(), F::one(), P[0].z);
	for (size_t i = 1; i < n; i++) {
		F t = F::select(P[i].z.isZero(), F::one(), P[i].z);
		F::mul(tbl[i], tbl[i-1], t);
	}
	CYBOZU_ALIGN(64) F r;
	F::inv(r, tbl[n-1]);
	for (size_t i = 0; i < n; i++) {
		size_t pos = n-1-i;
		F& z = P[pos].z;
		const typename E::VM zIsZero = z.isZero();
		F rz, rz2;
		if (pos == 0) {
			rz = r;
		} else {
			F::mul(rz, r, tbl[pos-1]);
			F::mul(r, r, F::select(zIsZero, F::one(), z));
		}
		F::sqr(rz2, rz);
		F::mul(P[pos].x, P[pos].x, rz2); // xz^-2
		F::mul(rz2, rz2, rz);
		F::mul(P[pos].y, P[pos].y, rz2); // yz^-3
		z = F::select(zIsZero, z, F::one());
		if (isProj) P[pos].y = F::select(zIsZero, F::one(), P[pos].y);
	}
	if (alocated) {
		Xbyak::AlignedFree(tbl);
	}
}

// 8M+3S+7A
// assume all Q are normalized; return the lanes requiring doubling
template<class E>
inline typename E::VM addJacobiMixedNoCheck(E& R, const E& P, const E& Q)
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
	return kandb(H.isZero(), r.isZero());
}

// 12M+4S+7A
// return the lanes requiring doubling
template<class E>
inline typename E::VM addJacobiNoCheck(E& R, const E& P, const E& Q)
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
	return kandb(H.isZero(), r.isZero());
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

template<class T, class F>
struct EcMT {
	typedef F Fp;
	typedef typename F::V V;
	typedef typename F::VM VM;
	F x, y, z;
	static const int a_ = 0;
	static const int& specialB_; // = g_rt.specialB (set by initMsm). ec::addCTProj / dblCTProj use b3_ if GenericB
	static T select(const VM& c, const T& a, const T& b)
	{
		T d;
		d.x = F::select(c, a.x, b.x);
		d.y = F::select(c, a.y, b.y);
		d.z = F::select(c, a.z, b.z);
		return d;
	}
	template<bool isProj=true, bool mixed=false>
	static void add(T& z, const T& x, const T& y)
	{
		if (isProj) {
			if (mixed) {
				T t;
				mcl::ec::addCTProj(t, x, y, mixed);
				z = select(y.isZero(), x, t);
			} else {
				mcl::ec::addCTProj(z, x, y);
			}
		} else {
			T t;
			VM same;
			if (mixed) {
				same = addJacobiMixedNoCheck(t, x, y);
			} else {
				same = addJacobiNoCheck(t, x, y);
			}
			same = kandnb(korb(x.isZero(), y.isZero()), same);
			if (cvtToInt(same)) {
				T doubled;
				dblJacobiNoCheck(doubled, x);
				t = select(same, doubled, t);
			}
			t = select(x.isZero(), y, t);
			z = select(y.isZero(), x, t);
		}
	}
	template<bool isProj=true>
	static void dbl(T& z, const T& x)
	{
		if (isProj) {
			mcl::ec::dblCTProj(z, x);
		} else {
			dblJacobiNoCheck(z, x);
		}
	}
	template<bool isProj=true>
	static const T& zero()
	{
		return isProj ? T::zeroProj_ : T::zeroJacobi_;
	}
	template<bool isProj=true>
	void clear()
	{
		*this = zero<isProj>();
	}
	void normalize()
	{
		// assume !isZero()
		F r;
		F::inv(r, z);
		F::mul(x, x, r);
		F::mul(y, y, r);
		z = F::one();
	}
	template<bool isProj=true, bool mixed=false>
	static void makeTable(T *tbl, size_t tblN, const T& P)
	{
		tbl[0].template clear<isProj>();
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
	void gather(const T *tbl, V idx)
	{
		const Vec factor = vpbroadcastq(sizeof(T) / 8); // the stride of tbl[] in Unit
		idx = vmulL(idx, factor, F::offset());
		for (size_t i = 0; i < N; i++) {
			x.v[i] = vpgatherqq(idx, &tbl[0].x.v[i]);
			y.v[i] = vpgatherqq(idx, &tbl[0].y.v[i]);
			z.v[i] = vpgatherqq(idx, &tbl[0].z.v[i]);
		}
	}
	void scatter(T *tbl, V idx) const
	{
		const Vec factor = vpbroadcastq(sizeof(T) / 8); // the stride of tbl[] in Unit
		idx = vmulL(idx, factor, F::offset());
		for (size_t i = 0; i < N; i++) {
			vpscatterqq(&tbl[0].x.v[i], idx, x.v[i]);
			vpscatterqq(&tbl[0].y.v[i], idx, y.v[i]);
			vpscatterqq(&tbl[0].z.v[i], idx, z.v[i]);
		}
	}
	static void mulLambda(T& Q, const T& P)
	{
		F::mul(Q.x, P.x, F::rw());
		Q.y = P.y;
		Q.z = P.z;
	}
	static void neg(T& Q, const T& P)
	{
		Q.x = P.x;
		F::neg(Q.y, P.y);
		Q.z = P.z;
	}
	void cset(const VM& c, const T& v)
	{
		x.cset(c, v.x);
		y.cset(c, v.y);
		z.cset(c, v.z);
	}
	VM isZero() const
	{
		return z.isZero();
	}
	VM isEqualJacobiAll(const T& rhs) const
	{
		F s1, s2, t1, t2;
		VM v1, v2;
		F::sqr(s1, z);
		F::sqr(s2, rhs.z);
		F::mul(t1, x, s2);
		F::mul(t2, rhs.x, s1);
		v1 = t1.isEqualAll(t2);
		F::mul(t1, y, s2);
		F::mul(t2, rhs.y, s1);
		F::mul(t1, t1, rhs.z);
		F::mul(t2, t2, z);
		v2 = t1.isEqualAll(t2);
		return kandb(v1, v2);
	}
	template<size_t bitLen, size_t w>
	static void makeNAFtbl(V *idxTbl, VM *negTbl, const V a[2])
	{
		const Vec mask = vpbroadcastq((1<<w)-1);
		const Vec Fu = vpbroadcastq(1<<w);
		const Vec H = vpbroadcastq(1<<(w-1));
		const Vec one = vpbroadcastq(1);
		size_t pos = 0;
		V CF = vzero<V>();
		const size_t n = (bitLen+w-1)/w;
		for (size_t i = 0; i < n; i++) {
			V idx = getUnitAt(a, 2, pos);
			idx = vpandq(idx, mask);
			idx = vpaddq(idx, CF);
			V masked = vpandq(idx, mask);
			negTbl[i] = vpcmpgtq(masked, H);
			idxTbl[i] = vselect(negTbl[i], vpsubq(Fu, masked), masked); // idx >= H ? F - idx : idx;
			CF = vpsrlq(idx, w);
			CF = vpaddq(negTbl[i], CF, one);
			pos += w;
		}
	}
	template<bool isProj=true, bool mixed=false>
	static void mulGLV(T *Q, const T *P, const FrA *y, size_t n)
	{
		assert(n > 0);
		const size_t m = sizeof(V)/8;
		const size_t w = 5;
		const size_t tblN = (1<<(w-1))+1; // [0, 2^(w-1)]

#ifdef __GNUC__
#ifdef __clang__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wvla-cxx-extension"
#endif
		CYBOZU_ALIGN(64) T tbl1s[tblN*n];
#ifdef __clang__
#pragma GCC diagnostic pop
#endif
#else
		T *tbl1s = (T*)CYBOZU_ALIGNED_ALLOCA(sizeof(T)*tblN*n, 64);
#endif
		for (size_t k = 0; k < n; k++) {
			makeTable<isProj, mixed>(tbl1s + tblN*k, tblN, P[k]);
		}
		if (!isProj && mixed) normalizeJacobiVec<T>(tbl1s+1, tblN*n-1);

		const mcl::fp::Op& fr = Fr::getOp();
		for (size_t k = 0; k < n; k++) {
			const T *tbl1 = &tbl1s[tblN*k];
			T tbl2[tblN];
			for (size_t i = 0; i < tblN; i++) {
				mulLambda(tbl2[i], tbl1[i]);
			}
			V a[2], b[2];
			Unit *pa = (Unit*)a;
			Unit *pb = (Unit*)b;
			V negA, negB; // 1 if a (b) of the lane is negative
			Unit *pna = (Unit*)&negA;
			Unit *pnb = (Unit*)&negB;
			for (size_t i = 0; i < m; i++) {
				Unit buf[4];
				fr.fromMont(buf, y[k*m+i].v);
				Unit aa[2], bb[2];
				const uint32_t neg = g_splitRaw(aa, bb, buf); // y = a + b lambda, |a|, |b| < 2^128
				pa[i+m*0] = aa[0]; pa[i+m*1] = aa[1];
				pb[i+m*0] = bb[0]; pb[i+m*1] = bb[1];
				pna[i] = neg & 1;
				pnb[i] = (neg >> 1) & 1;
			}
			const size_t bitLen = 128;
			const size_t nw = (bitLen + w-1)/w;
			V aTbl[nw], bTbl[nw];
			VM aNegTbl[nw], bNegTbl[nw];
			makeNAFtbl<bitLen, w>(aTbl, aNegTbl, a);
			makeNAFtbl<bitLen, w>(bTbl, bNegTbl, b);
			// negate all the digits of the lanes whose a (b) is negative
			const VM laneNegA = vpcmpneqq(negA, vzero<V>());
			const VM laneNegB = vpcmpneqq(negB, vzero<V>());
			for (size_t i = 0; i < nw; i++) {
				aNegTbl[i] = kxorb(aNegTbl[i], laneNegA);
				bNegTbl[i] = kxorb(bNegTbl[i], laneNegB);
			}

			for (size_t i = 0; i < nw; i++) {
				if (i > 0) for (size_t j = 0; j < w; j++) T::template dbl<isProj>(Q[k], Q[k]);
				const size_t pos = nw-1-i;

				T t;
				V idx = bTbl[pos];
				t.gather(tbl2, idx);
				t.y = F::select(bNegTbl[pos], t.y.neg(), t.y);
				if (i == 0) {
					Q[k] = t;
				} else {
					add<isProj, mixed>(Q[k], Q[k], t);
				}
				idx = aTbl[pos];
				t.gather(tbl1, idx);
				t.y = F::select(aNegTbl[pos], t.y.neg(), t.y);
				add<isProj, mixed>(Q[k], Q[k], t);
			}
		}
	}
};

template<class T, class F> const int& EcMT<T, F>::specialB_ = g_rt.specialB;

struct EcM : EcMT<EcM, FpM> {
	static const FpM &b3_;
	static const EcM &zeroProj_;
	static const EcM &zeroJacobi_;
	template<bool isNormalized = false>
	void setG1A(const G1A v[M], bool JacobiToProj = true)
	{
		cvtFromG1Ax(x.v, v[0].v+0*unitN);
		cvtFromG1Ax(y.v, v[0].v+1*unitN);
		cvtFromG1Ax(z.v, v[0].v+2*unitN);

		FpM::mul(x, x, g_rt.m64to52u);
		FpM::mul(y, y, g_rt.m64to52u);
		FpM::mul(z, z, g_rt.m64to52u);

		if (JacobiToProj) {
			if (!isNormalized) mcl::ec::JacobiToProj(*this, *this);
			y = FpM::select(z.isZero(), FpM::one(), y);
		}
	}
	void getG1A(G1A v[M], bool ProjToJacobi = true) const
	{
		EcM T = *this;
		if (ProjToJacobi) mcl::ec::ProjToJacobi(T, T);

		FpM::mul(T.x, T.x, g_rt.m52to64u);
		FpM::mul(T.y, T.y, g_rt.m52to64u);
		FpM::mul(T.z, T.z, g_rt.m52to64u);

		cvtToG1Ax(v[0].v+0*unitN, T.x.v);
		cvtToG1Ax(v[0].v+1*unitN, T.y.v);
		cvtToG1Ax(v[0].v+2*unitN, T.z.v);
	}
};

const FpM& EcM::b3_ = *(const FpM*)g_rt.b3;
const EcM& EcM::zeroProj_ = *(const EcM*)g_rt.zeroProj;
const EcM& EcM::zeroJacobi_ = *(const EcM*)g_rt.zeroJacobi;

template<class G>
inline void reduceSum(G1A& Q, const G& P)
{
	const size_t m = sizeof(P)/sizeof(EcM)*8;
	G1A z[m];
	P.getG1A(z);
	Q = z[0];
	for (size_t i = 1; i < m; i++) {
		G1::add((G1&)Q, (const G1&)Q, (const G1&)z[i]);
	}
}

template<class G, class V, bool mixed=false>
void mulVecUpdateTable(G& win, G *tbl, size_t tblN, const G *xVec, const V *yVec, size_t yn, size_t pos, size_t n, bool first)
{
	const bool isProj = true;
	const Vec m = vpbroadcastq(tblN-1);
	for (size_t i = 0; i < tblN; i++) {
		tbl[i].clear();
	}
	for (size_t i = 0; i < n; i++) {
		V v = getUnitAt(yVec+i*yn, yn, pos);
		v = vpandq(v, m);
		G T;
		T.gather(tbl, v);
		G::template add<isProj, mixed>(T, T, xVec[i]);
		T.scatter(tbl, v);
	}
	G sum = tbl[tblN - 1];
	if (first) {
		win = sum;
	} else {
		G::add(win, win, sum);
	}
	for (size_t i = 1; i < tblN - 1; i++) {
		G::add(sum, sum, tbl[tblN - 1- i]);
		G::add(win, win, sum);
	}
}

inline size_t glvGetBucketSizeAVX512(size_t n)
{
	size_t log2n = mcl::ec::ilog2(n);
	const size_t tblMin = 6;
	if (log2n < tblMin) return 2;
	// n >= 2^tblMin
	static const size_t tbl[] = {
	// elem num 2^a i          : a= 16  17  18  19  20  21
	// simd elem num 2^b=2^a/4 : b= 14  15  16  17  18  19
		3, 4, 5, 5, 6, 7, 8, 8, 10, 10, 10, 10, 10, 13, 15, 15, 16, 16, 16, 16, 16
		                                      //13 (almost same)
	};
	if (log2n >= CYBOZU_NUM_OF_ARRAY(tbl)) return 16;
	size_t ret = tbl[log2n - tblMin];
	return ret;
}
// xVec[n], yVec[n * maxBitSize/64]
template<class G=EcM, class V=Vec, bool mixed = false>
inline void mulVecAVX512_inner(G1A& P, const G *xVec, const V *yVec, size_t n, size_t maxBitSize, size_t b)
{
	if (b == 0) b = glvGetBucketSizeAVX512(n);
	size_t tblN = size_t(1) << b;
	G *tbl = (G*)Xbyak::AlignedMalloc(sizeof(G) * tblN, 64);
	const size_t yn = maxBitSize / 64;
	const size_t winN = (maxBitSize + b-1) / b;

	G T;
	mulVecUpdateTable<G, V, mixed>(T, tbl, tblN, xVec, yVec, yn, b*(winN-1), n, true);
	for (size_t w = 1; w < winN; w++) {
		for (size_t i = 0; i < b; i++) {
			G::dbl(T, T);
		}
		mulVecUpdateTable<G, V, mixed>(T, tbl, tblN, xVec, yVec, yn, b*(winN-1-w), n, false);
	}
	reduceSum(P, T);
	Xbyak::AlignedFree(tbl);
}

struct FpMA : FpMT<FpMA, VmaskA, VecA> {
	static const VecA& offset() { return *(const VecA*)g_offset_; }
	static const FpMA& zero() { return *(const FpMA*)g_rt.zeroA; }
	static const FpMA& one() { return *(const FpMA*)g_rt.RA; }
	static const FpMA& R2() { return *(const FpMA*)g_rt.R2A; }
	static const FpMA& rawOne() { return *(const FpMA*)g_rt.rawOneA; }
	static const FpMA& m64to52() { return *(const FpMA*)g_rt.m64to52A; }
	static const FpMA& m52to64() { return *(const FpMA*)g_rt.m52to64A; }
	static const FpMA& rw() { return *(const FpMA*)g_rt.rwA; }
	void setFpA(const FpA v[M*vN])
	{
		FpM t[vN];
		for (size_t i = 0; i < vN; i++) {
			t[i].setFpA(v+M*i);
		}
		setFpM(t);
	}
	void getFpA(FpA v[M*vN]) const
	{
		FpM t[vN];
		getFpM(t);
		for (size_t i = 0; i < vN; i++) {
			t[i].getFpA(v+M*i);
		}
	}
	static void inv(FpMA& z, const FpMA& x)
	{
		CYBOZU_ALIGN(64) FpA v[M*vN];
		Fp* vv = (Fp*)v;
		x.getFpA(v);
		mcl::invVec<Fp>(vv, vv, M*vN, M*vN);
		z.setFpA(v);
	}
	void setFpM(const FpM x[vN])
	{
		for (size_t i = 0; i < vN; i++) {
			for (size_t j = 0; j < N; j++) {
				v[j].v[i] = x[i].v[j];
			}
		}
	}
	void getFpM(FpM y[vN]) const
	{
		for (size_t i = 0; i < vN; i++) {
			for (size_t j = 0; j < N; j++) {
				y[i].v[j] = v[j].v[i];
			}
		}
	}
};

void cvtFpM2FpMA(FpMA& z, const FpM& x, const FpM& y)
{
	assert(vN == 2);
	for (size_t i = 0; i < N; i++) {
		z.v[i].v[0] = x.v[i];
		z.v[i].v[1] = y.v[i];
	}
}

void cvtFpMA2FpM(FpM& a, FpM& b, const FpMA& c)
{
	assert(vN == 2);
	for (size_t i = 0; i < N; i++) {
		a.v[i] = c.v[i].v[0];
		b.v[i] = c.v[i].v[1];
	}
}

struct EcMA : EcMT<EcMA, FpMA> {
	static const FpMA &b3_;
	static const EcMA &zeroProj_;
	static const EcMA &zeroJacobi_;
	void setEcM(const EcM P[vN])
	{
		cvtFpM2FpMA(x, P[0].x, P[1].x);
		cvtFpM2FpMA(y, P[0].y, P[1].y);
		cvtFpM2FpMA(z, P[0].z, P[1].z);
	}
	void getEcM(EcM P[vN]) const
	{
		cvtFpMA2FpM(P[0].x, P[1].x, x);
		cvtFpMA2FpM(P[0].y, P[1].y, y);
		cvtFpMA2FpM(P[0].z, P[1].z, z);
	}

	template<bool isNormalized = false>
	void setG1A(const G1A v[M*vN], bool JacobiToProj = true)
	{
#if 1
		assert(vN == 2);

		cvtFromG1Ax(x.v, v[0].v+0*unitN);
		cvtFromG1Ax(y.v, v[0].v+1*unitN);
		cvtFromG1Ax(z.v, v[0].v+2*unitN);

		FpMA::mul(x, x, g_rt.m64to52u);
		FpMA::mul(y, y, g_rt.m64to52u);
		FpMA::mul(z, z, g_rt.m64to52u);

		if (JacobiToProj) {
			// Jacobi = Proj if normalized
			if (!isNormalized) mcl::ec::JacobiToProj(*this, *this);
			y = FpMA::select(z.isZero(), FpMA::one(), y);
		}
#else
		EcM P[vN];
		for (size_t i = 0; i < vN; i++) {
			P[i].setG1A(v+i*M, JacobiToProj);
		}
		setEcM(P);
#endif
	}
	void getG1A(G1A v[M*vN], bool ProjToJacobi = true) const
	{
#if 1
		EcMA T = *this;
		if (ProjToJacobi) mcl::ec::ProjToJacobi(T, T);

		FpMA::mul(T.x, T.x, g_rt.m52to64u);
		FpMA::mul(T.y, T.y, g_rt.m52to64u);
		FpMA::mul(T.z, T.z, g_rt.m52to64u);

		cvtToG1Ax(v[0].v+0*unitN, T.x.v);
		cvtToG1Ax(v[0].v+1*unitN, T.y.v);
		cvtToG1Ax(v[0].v+2*unitN, T.z.v);
#else
		EcM P[vN];
		getEcM(P);
		for (size_t i = 0; i < vN; i++) {
			P[i].getG1A(v+i*M, ProjToJacobi);
		}
#endif
	}
};

const FpMA& EcMA::b3_ = *(const FpMA*)g_rt.b3A;
const EcMA& EcMA::zeroProj_ = *(const EcMA*)g_rt.zeroProjA;
const EcMA& EcMA::zeroJacobi_ = *(const EcMA*)g_rt.zeroJacobiA;

#ifdef MCL_MSM_TEST
/*
	the old MSM where each SIMD lane has its own buckets (replaced by the kernel of the batch affine addition), without GLV
*/

template<class G=EcM, class V=Vec>
void mulVecAVX512T(G1& _P, G1 *_x, const Fr *_y, size_t n, size_t bucket = 0)
{
	G1A& P = *(G1A*)&_P;
	G1A *x = (G1A*)_x;
	const FrA *y = (const FrA*)_y;
	const size_t m = sizeof(V)/8;
	const size_t d = n/m;
	const size_t e = 1;
	const bool mixed = true;
	if (mixed) {
// 		ec::normalizeVec<G1>(x, x, n);
	}

	G *xVec = (G*)Xbyak::AlignedMalloc(sizeof(G) * d * e, 64);
	V *yVec = (V*)Xbyak::AlignedMalloc(sizeof(V) * d * 4, 64);

	for (size_t i = 0; i < d; i++) {
		xVec[i].template setG1A<mixed>(x+i*m);
	}
	normalizeJacobiVec(xVec, d, true);
	const mcl::fp::Op& fr = Fr::getOp();
	Unit *const py = (Unit*)yVec;
	for (size_t i = 0; i < d; i++) {
		for (size_t j = 0; j < m; j++) {
			Unit ya[4];
			fr.fromMont(ya, y[i*m+j].v);
			for (size_t k = 0; k < 4; k++) {
				py[(i*4+k)*m+j] = ya[k];
			}
		}
	}
	mulVecAVX512_inner<G, V, mixed>(P, xVec, yVec, d * e, 256 / e, bucket);

	Xbyak::AlignedFree(yVec);
	Xbyak::AlignedFree(xVec);

	for (size_t i = d*m; i < n; i++) {
		G1A Q;
		G1::mul((G1&)Q, (const G1&)x[i], (const Fr&)y[i]);
		G1::add((G1&)P, (const G1&)P, (const G1&)Q);
	}
}
#endif // MCL_MSM_TEST

} // namespace


/*
	the threshold of the batch affine addition (the number of the split scalars) of this kernel.
	measured on Xeon w9-3495X (the batch affine addition by the kernel vs the Jacobi mixed addition by Fp, the best window size for each) :
	the batch wins from about 90 (BLS12-381, N = 8), 80 (BN254, N = 5) and 170 (BN254 with the N = 8 kernel of the MCL_FP_BIT = 384 build,
	where the Jacobi mixed addition of the 4-limb Fp is cheap but an addition of the kernel costs the same as for BLS12-381) split scalars.
*/
size_t getBatchMinNAffM()
{
	return (N == 8 && g_rt.pN <= 4) ? 192 : 96;
}

const ec::MsmKernel* getMsmKernelAVX512()
{
	static ec::MsmKernel kn = { sizeof(AffM), sizeof(AffMWork), cvtBaseAffM, addPairsAffM, addToBucketAffM, getBucketSizeAffM, 0, cvtBaseGLVAffM };
	kn.batchMinN = getBatchMinNAffM(); // depends on the current curve (g_rt.pN)
	return &kn;
}

#ifdef MCL_MSM_TEST
void mulVecAVX512(G1& P, G1 *x, const Fr *y, size_t n, size_t b = 0)
{
	mulVecAVX512T<EcM, Vec>(P, x, y, n, b);
//	mulVecAVX512T<EcMA, VecA>(P, x, y, n, b); // slower
}
#endif

void mulEachAVX512(G1 *_x, const Fr *_y, size_t n)
{
#if 1
	typedef EcMA V;
#else
	typedef EcM V;
#endif
	const size_t m = sizeof(V)/(sizeof(FpM)*3)*8;
	assert(n % m == 0);
	const size_t d = n / m;
	const bool isProj = false;
	const bool mixed = true;
	G1A *x = (G1A*)_x;
	const FrA *y = (const FrA*)_y;
	if (!isProj && mixed) ec::normalizeVec((G1*)x, (G1*)x, n);
	const size_t u = 4;
	const size_t q = d / u;
	const size_t remain = d % u;
	V P[u];
	for (size_t i = 0; i < q; i++) {
		for (size_t k = 0; k < u; k++) {
			P[k].setG1A(x+k*m, isProj);
		}
		V::mulGLV<isProj, mixed>(P, P, y, u);
		for (size_t k = 0; k < u; k++) {
			P[k].getG1A(x+k*m, isProj);
		}
		x += m*u;
		y += m*u;
	}
	if (remain == 0) return;
	for (size_t k = 0; k < remain; k++) {
		P[k].setG1A(x+k*m, isProj);
	}
	V::mulGLV<isProj, mixed>(P, P, y, remain);
	for (size_t k = 0; k < remain; k++) {
		P[k].getG1A(x+k*m, isProj);
	}
}

/*
	set the constants of the current curve (Fp::getOp().p) from g_msmCurveTbl and register
	the kernel of the batch affine addition (G1::setMsmKernel) and mulEachAVX512 (Jacobian, a = 0)
	return false if the curve is not supported (AVX-512 IFMA is required)
*/
bool initMsm(int curveType, uint32_t (*splitRaw)(Unit *a, Unit *b, const Unit *x))
{
	(void)EcM::a_; // disable unused warning
	(void)EcM::b3_;
	(void)EcM::zeroProj_;
	(void)EcM::zeroJacobi_;
	(void)EcMA::a_;
	(void)EcMA::b3_;
	(void)EcMA::zeroProj_;
	(void)EcMA::zeroJacobi_;
	if (splitRaw == 0) return false;
	const mcl::fp::Op& op = Fp::getOp();
	if (op.N > unitN) return false;
	const MsmCurvePara *para = 0;
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(g_msmCurveTbl); i++) {
		const MsmCurvePara& t = g_msmCurveTbl[i];
		if (t.curveType != curveType || t.pN != op.N) continue;
		bool eq = true;
		for (size_t j = 0; j < op.N; j++) {
			if (t.p[j] != op.p[j]) eq = false;
		}
		if (eq) {
			para = &t;
			break;
		}
	}
	if (para == 0) return false;
	/*
		Fp of secp256k1 is not in the Montgomery form (PM_SECP256K1 of fp.cpp), then
		x -> x R52 by FpM::mul(x, R52^2), x R52 -> x by FpM::mul(x, 1) and Fp::mul(x, R52^-1)
	*/
	const uint64_t *m64to52 = op.isMont ? para->m64to52 : para->R2;
	const uint64_t *m52to64 = op.isMont ? para->m52to64 : para->rawOne;
	const uint64_t *m52to64s = op.isMont ? para->m52to64s : para->invR52;
	// expand the constants to the lanes
	for (size_t j = 0; j < M; j++) {
		g_rt.mask[j] = g_mask;
		g_rt.rp[j] = para->rp;
	}
	struct Local {
		static void expand(uint64_t *dst, const uint64_t *src, size_t lanes)
		{
			for (size_t i = 0; i < N; i++) {
				for (size_t j = 0; j < lanes; j++) {
					dst[i * lanes + j] = src[i];
				}
			}
		}
	};
	const uint64_t zero[8] = {};
	Local::expand(g_rt.ap, para->ap, M);
	Local::expand(g_rt.zero, zero, M);
	Local::expand(g_rt.R, para->R, M);
	Local::expand(g_rt.R2, para->R2, M);
	Local::expand(g_rt.rawOne, para->rawOne, M);
	Local::expand(g_rt.m64to52, m64to52, M);
	Local::expand(g_rt.m52to64, m52to64, M);
	Local::expand(g_rt.rw, para->rw, M);
	Local::expand(g_rt.b3, para->b3, M);
	Local::expand(g_rt.zeroJacobi, zero, M);
	Local::expand(g_rt.zeroJacobi + N*M, zero, M);
	Local::expand(g_rt.zeroJacobi + 2*N*M, zero, M);
	Local::expand(g_rt.zeroProj, zero, M);
	Local::expand(g_rt.zeroProj + N*M, para->R, M); // (0, 1, 0)
	Local::expand(g_rt.zeroProj + 2*N*M, zero, M);
	Local::expand(g_rt.zeroA, zero, M*vN);
	Local::expand(g_rt.RA, para->R, M*vN);
	Local::expand(g_rt.R2A, para->R2, M*vN);
	Local::expand(g_rt.rawOneA, para->rawOne, M*vN);
	Local::expand(g_rt.m64to52A, m64to52, M*vN);
	Local::expand(g_rt.m52to64A, m52to64, M*vN);
	Local::expand(g_rt.rwA, para->rw, M*vN);
	Local::expand(g_rt.b3A, para->b3, M*vN);
	Local::expand(g_rt.zeroJacobiA, zero, M*vN);
	Local::expand(g_rt.zeroJacobiA + N*M*vN, zero, M*vN);
	Local::expand(g_rt.zeroJacobiA + 2*N*M*vN, zero, M*vN);
	Local::expand(g_rt.zeroProjA, zero, M*vN);
	Local::expand(g_rt.zeroProjA + N*M*vN, para->R, M*vN);
	Local::expand(g_rt.zeroProjA + 2*N*M*vN, zero, M*vN);
	for (size_t i = 0; i < N; i++) {
		g_rt.m64to52u[i] = m64to52[i];
		g_rt.m52to64u[i] = m52to64[i];
	}
	for (size_t i = 0; i < unitN; i++) {
		g_rt.m52to64s[i] = m52to64s[i];
	}
	g_rt.pN = op.N;
	g_rt.curveType = curveType;
	switch (para->b) {
	case 1: g_rt.specialB = mcl::ec::local::Plus1; break;
	case 4: g_rt.specialB = mcl::ec::local::Plus4; break;
	default: g_rt.specialB = mcl::ec::local::GenericB; break;
	}
	g_splitRaw = splitRaw;
	G1::setMsmKernel(getMsmKernelAVX512());
	// mulEachAVX512 returns Jacobian coordinates and assumes a = 0.
	if (G1::a_.isZero() && G1::getMode() == ec::Jacobi) {
		G1::setMulEachOpti(mulEachAVX512);
	}
	return true;
}


} } // mcl::MCL_MSM_NS
