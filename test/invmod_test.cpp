#include <mcl/invmod.hpp>
#include <cybozu/test.hpp>
#include <cybozu/benchmark.hpp>

#include <cybozu/xorshift.hpp>

// wide : f, g, d, e in N + 1 units (always valid) or N units (M < 2^(UnitBitSize N - 2) only)
template<int N>
void testSub(const mpz_class& M, bool wide)
{
	printf("wide=%d\n", wide);
	mcl::inv::InvModT<N> im;
	CYBOZU_TEST_ASSERT(mcl::inv::init(im, M));
	CYBOZU_TEST_ASSERT(wide || !im.wide);
	im.wide = wide;
	mpz_class x, y, z;
	x = 0;
	mcl::inv::exec(im, z, x);
	CYBOZU_TEST_EQUAL(z, 0);
	x = 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x++;
	}
	x = M - 1;
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x--;
	}
	for (int i = 0; i < 10000; i++) {
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x = y + 1;
	}
	// random x in [0, M)
	cybozu::XorShift rg;
	for (int i = 0; i < 10000; i++) {
		mcl::Unit v[N];
		for (int j = 0; j < N; j++) v[j] = (mcl::Unit)rg.get64();
		mcl::gmp::setArray(x, v, N);
		x %= M;
		if (x == 0) continue;
		mcl::gmp::invMod(y, x, M);
		mcl::inv::exec(im, z, x);
		CYBOZU_TEST_EQUAL(y, z);
	}
	typedef mcl::Unit Unit;
	const Unit ff = Unit(-1);
	const Unit _80 = Unit(1) << (MCL_UNIT_BIT_SIZE-1);
	const Unit tbl[] = {
		ff, ff >> 1, _80, _80-1,
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		for (size_t j = 0; j < CYBOZU_NUM_OF_ARRAY(tbl); j++) {
			Unit v[2] = { tbl[i], tbl[j] };
			mcl::gmp::setArray(x, v, 2);
			if (x == 0) continue;
			mcl::gmp::invMod(y, x, M);
			mcl::inv::exec(im, z, x);
			CYBOZU_TEST_EQUAL(y, z);
		}
	}
#ifdef NDEBUG
	const char *msg = wide ? "invMod(N+1)" : "invMod(N)  ";
	CYBOZU_BENCH_C(msg, 1000, x++;mcl::inv::exec, im, x, x);
#endif
}

#if MCL_SIZEOF_UNIT == 8
	#if defined(__SIZEOF_INT128__) || defined(_MSC_VER)
		#define MCL_INVMOD_TEST_SL
	#endif
#else
	#define MCL_INVMOD_TEST_SL
#endif
#ifdef MCL_INVMOD_TEST_SL
#ifdef _MSC_VER
#include <intrin.h>
#endif
/*
	signed-limb (libsecp256k1 style) version for comparison with inv::twos
	f, g, d, e are L limbs of LB bits (LB = 62 with int64_t limbs for 64-bit
	units as secp256k1_modinv64_signed62, LB = 30 with int32_t limbs for 32-bit
	units as secp256k1_modinv32_signed30); the low limbs are in [0, 2^LB) and
	the top limb is signed, L = ceil((UnitBitSize N + 2) / LB) (5 for 256-bit /
	7 for 384-bit with LB = 62, 9 / 13 with LB = 30). The updates accumulate the
	limb products in a 2-unit accumulator (__int128 or {lo, hi}, or int64_t for
	LB = 30; cf. secp256k1_modinv{64,32}_update_{fg,de}_{62,30}); the 2-bit
	headroom means no carry chain and no sign correction, and -2M < d, e < M
	always fits (no wide switch). The fixed length L is used (the var version
	of libsecp256k1 shrinks the length of f, g as they shrink). divsteps and
	the md choice are the same as inv::twos, so the values of f, g, d, e agree.
*/
namespace sl {

typedef mcl::Unit Unit;
static const int unitBits = MCL_UNIT_BIT_SIZE;

#if MCL_SIZEOF_UNIT == 8
static const int LB = 62;
typedef int64_t Limb;
/*
	128-bit signed accumulator of the limb products. Only mul, accumulate,
	the low 64 bits and >> 62 are needed. Native __int128 if available
	(gcc/clang), otherwise a {lo, hi} struct with the 64x64 -> 128 multiply
	intrinsic of MSVC (_mul128 on x64, __mulh on ARM64) as libsecp256k1's
	int128_struct_impl.h. MCL_S62_STRUCT_I128 forces the struct version (to
	test it with gcc/clang).
*/
#if defined(__SIZEOF_INT128__) && !defined(MCL_S62_STRUCT_I128)
typedef __int128 Acc;
inline Acc mulAcc(Limb a, Limb b) { return (Acc)a * b; }
inline void accumMul(Acc& c, Limb a, Limb b) { c += (Acc)a * b; }
inline void shrLB(Acc& c) { c >>= LB; }
inline Limb lowLimb(const Acc& c) { return (Limb)c; }
#else
struct Acc {
	uint64_t lo;
	int64_t hi;
};
// [*hi:return] = a * b (signed)
inline uint64_t mulLoHi(int64_t a, int64_t b, int64_t *hi)
{
#if defined(_MSC_VER) && defined(_M_X64)
	return (uint64_t)_mul128(a, b, hi);
#elif defined(_MSC_VER) && defined(_M_ARM64)
	*hi = __mulh(a, b);
	return (uint64_t)a * (uint64_t)b;
#elif defined(__SIZEOF_INT128__)
	// for testing the struct version with gcc/clang
	__int128 t = (__int128)a * b;
	*hi = (int64_t)(t >> 64);
	return (uint64_t)t;
#else
	#error "no 64x64 -> 128 multiply"
#endif
}
inline Acc mulAcc(Limb a, Limb b)
{
	Acc c;
	c.lo = mulLoHi(a, b, &c.hi);
	return c;
}
inline void accumMul(Acc& c, Limb a, Limb b)
{
	int64_t hi;
	uint64_t lo = mulLoHi(a, b, &hi);
	c.lo += lo;
	c.hi = (int64_t)((uint64_t)c.hi + (uint64_t)hi + (c.lo < lo));
}
// arithmetic shift
inline void shrLB(Acc& c)
{
	c.lo = (c.lo >> LB) | ((uint64_t)c.hi << (64 - LB));
	c.hi >>= LB;
}
inline Limb lowLimb(const Acc& c) { return (Limb)c.lo; }
#endif
#else // MCL_SIZEOF_UNIT == 4
static const int LB = 30;
typedef int32_t Limb;
// |a| <= 2^30 and |b| < 2^31, so three products and a carry fit in int64_t
typedef int64_t Acc;
inline Acc mulAcc(Limb a, Limb b) { return (Acc)a * b; }
inline void accumMul(Acc& c, Limb a, Limb b) { c += (Acc)a * b; }
inline void shrLB(Acc& c) { c >>= LB; }
inline Limb lowLimb(const Acc& c) { return (Limb)c; }
#endif

static const int limbBits = sizeof(Limb) * 8;
static const Limb MASK_L = (Limb)(((Unit)1 << LB) - 1);
template<int L>
struct SL {
	Limb v[L];
};
template<int N>
struct Inv {
	static const int L = (unitBits * N + LB + 1) / LB; // ceil((unitBits N + 2) / LB)
	SL<L> M;
	Unit Mi; // M^-1 mod 2^LB
};

// x[N] (nonnegative units) -> signed limbs
template<int N, int L>
void toSL(SL<L>& y, const Unit *x)
{
	for (int i = 0; i < L; i++) {
		int bit = LB * i;
		int idx = bit / unitBits, off = bit % unitBits;
		Unit lo = idx < N ? x[idx] >> off : 0;
		Unit hi = (off > unitBits - LB && idx + 1 < N) ? x[idx + 1] << (unitBits - off) : 0;
		y.v[i] = (Limb)((lo | hi) & (Unit)MASK_L);
	}
}

// normalized nonnegative signed limbs (< 2^(unitBits N)) -> x[N]
template<int N, int L>
void fromSL(Unit *x, const SL<L>& y)
{
	for (int i = 0; i < N; i++) x[i] = 0;
	for (int i = 0; i < L; i++) {
		int bit = LB * i;
		int idx = bit / unitBits, off = bit % unitBits;
		Unit v = (Unit)y.v[i];
		if (idx < N) x[idx] |= v << off;
		if (off > unitBits - LB && idx + 1 < N) x[idx + 1] |= v >> (unitBits - off);
	}
}

template<int L>
bool isZero(const SL<L>& x)
{
	Limb r = 0;
	for (int i = 0; i < L; i++) r |= x.v[i];
	return r == 0;
}

template<int L>
void update_fg(SL<L>& f, SL<L>& g, const mcl::inv::Quad& t)
{
	const Limb u = (Limb)t.u, v = (Limb)t.v, q = (Limb)t.q, r = (Limb)t.r;
	Limb fi = f.v[0], gi = g.v[0];
	Acc cf = mulAcc(u, fi); accumMul(cf, v, gi);
	Acc cg = mulAcc(q, fi); accumMul(cg, r, gi);
	// the low LB bits are zero
	shrLB(cf);
	shrLB(cg);
	for (int i = 1; i < L; i++) {
		fi = f.v[i];
		gi = g.v[i];
		accumMul(cf, u, fi); accumMul(cf, v, gi);
		accumMul(cg, q, fi); accumMul(cg, r, gi);
		f.v[i - 1] = lowLimb(cf) & MASK_L; shrLB(cf);
		g.v[i - 1] = lowLimb(cg) & MASK_L; shrLB(cg);
	}
	f.v[L - 1] = lowLimb(cf);
	g.v[L - 1] = lowLimb(cg);
}

template<int L>
void update_de(const SL<L>& M, Unit Mi, SL<L>& d, SL<L>& e, const mcl::inv::Quad& t)
{
	const Limb u = (Limb)t.u, v = (Limb)t.v, q = (Limb)t.q, r = (Limb)t.r;
	const Limb d0 = d.v[0], e0 = e.v[0];
	const Limb sd = d.v[L - 1] >> (limbBits - 1);
	const Limb se = e.v[L - 1] >> (limbBits - 1);
	Limb md = (u & sd) + (v & se);
	Limb me = (q & sd) + (r & se);
	Acc cd = mulAcc(u, d0); accumMul(cd, v, e0);
	Acc ce = mulAcc(q, d0); accumMul(ce, r, e0);
	md -= (Limb)((Mi * (Unit)lowLimb(cd) + (Unit)md) & (Unit)MASK_L);
	me -= (Limb)((Mi * (Unit)lowLimb(ce) + (Unit)me) & (Unit)MASK_L);
	accumMul(cd, M.v[0], md);
	accumMul(ce, M.v[0], me);
	shrLB(cd);
	shrLB(ce);
	for (int i = 1; i < L; i++) {
		accumMul(cd, u, d.v[i]); accumMul(cd, v, e.v[i]); accumMul(cd, M.v[i], md);
		accumMul(ce, q, d.v[i]); accumMul(ce, r, e.v[i]); accumMul(ce, M.v[i], me);
		d.v[i - 1] = lowLimb(cd) & MASK_L; shrLB(cd);
		e.v[i - 1] = lowLimb(ce) & MASK_L; shrLB(ce);
	}
	d.v[L - 1] = lowLimb(cd);
	e.v[L - 1] = lowLimb(ce);
}

// r in (-2M, M) -> [0, M), negated if sign < 0 (secp256k1_modinv64_normalize_62)
template<int L>
void normalize(SL<L>& r, Limb sign, const SL<L>& M)
{
	Limb cond = r.v[L - 1] >> (limbBits - 1);
	for (int i = 0; i < L; i++) r.v[i] += M.v[i] & cond;
	cond = sign >> (limbBits - 1);
	for (int i = 0; i < L; i++) r.v[i] = (r.v[i] ^ cond) - cond;
	for (int i = 0; i < L - 1; i++) {
		r.v[i + 1] += r.v[i] >> LB;
		r.v[i] &= MASK_L;
	}
	cond = r.v[L - 1] >> (limbBits - 1);
	for (int i = 0; i < L; i++) r.v[i] += M.v[i] & cond;
	for (int i = 0; i < L - 1; i++) {
		r.v[i + 1] += r.v[i] >> LB;
		r.v[i] &= MASK_L;
	}
}

template<int N>
void init(Inv<N>& im2, const mcl::inv::InvModT<N>& im)
{
	toSL<N, Inv<N>::L>(im2.M, im.M);
	im2.Mi = im.Mi;
}

template<int N>
void exec(const Inv<N>& im, Unit *y, const Unit *x)
{
	using namespace mcl::inv;
	const int L = Inv<N>::L;
	Sint eta = -1;
	SL<L> f = im.M, g, d, e;
	toSL<N, L>(g, x);
	memset(&d, 0, sizeof(d));
	memset(&e, 0, sizeof(e));
	e.v[0] = 1;
	Quad t;
	while (!isZero(g)) {
		eta = divsteps_n_matrix(t, eta, (Unit)f.v[0], (Unit)g.v[0]);
		update_fg<L>(f, g, t);
		update_de<L>(im.M, im.Mi, d, e, t);
	}
	normalize<L>(d, f.v[L - 1], im.M);
	fromSL<N, L>(y, d);
}

template<int N>
void exec(const Inv<N>& im, mpz_class& y, const mpz_class& x)
{
	Unit ux[N], uy[N];
	mcl::gmp::getArray(ux, N, x);
	exec<N>(im, uy, ux);
	mcl::gmp::setArray(y, uy, N);
}

} // sl

// the signed-limb version against gmp and inv::exec
template<int N>
void testSL(const mpz_class& M)
{
	mcl::inv::InvModT<N> im;
	CYBOZU_TEST_ASSERT(mcl::inv::init(im, M));
	sl::Inv<N> im2;
	sl::init(im2, im);
	mpz_class x, y, z, w;
	cybozu::XorShift rg;
	for (int i = 0; i < 10000; i++) {
		mcl::Unit v[N];
		for (int j = 0; j < N; j++) v[j] = (mcl::Unit)rg.get64();
		mcl::gmp::setArray(x, v, N);
		x %= M;
		if (x == 0) continue;
		mcl::gmp::invMod(y, x, M);
		sl::exec(im2, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		mcl::inv::exec(im, w, x);
		CYBOZU_TEST_EQUAL(w, z);
	}
	x = 1;
	for (int i = 0; i < 1000; i++) {
		mcl::gmp::invMod(y, x, M);
		sl::exec(im2, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x = y + 1;
	}
	x = M - 1;
	for (int i = 0; i < 1000; i++) {
		mcl::gmp::invMod(y, x, M);
		sl::exec(im2, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x--;
	}
#ifdef NDEBUG
	const char *msg = sl::LB == 62 ? "invMod(s62)" : "invMod(s30)";
	CYBOZU_BENCH_C(msg, 1000, x++;sl::exec, im2, x, x);
#endif
}
#endif

template<int N>
void test(const char *Mstr)
{
	printf("p=%s\n", Mstr);
	mpz_class M;
	mcl::gmp::setStr(M, Mstr, 16);
	mcl::inv::InvModT<N> im;
	CYBOZU_TEST_ASSERT(mcl::inv::init(im, M));
	if (!im.wide) testSub<N>(M, false);
	testSub<N>(M, true);
#ifdef MCL_INVMOD_TEST_SL
	testSL<N>(M);
#endif
}

CYBOZU_TEST_AUTO(modinv)
{
	const char *tbl6[] = {
		"1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab",
	};
	const char *tbl4[] = {
		"fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f",
		"73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001",
		"2523648240000001ba344d8000000007ff9f800000000010a10000000000000d",
		"2523648240000001ba344d80000000086121000000000013a700000000000013",
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl4); i++) {
		test<4 * 8 / MCL_SIZEOF_UNIT>(tbl4[i]); // N = 4 (64-bit units) or 8 (32-bit units)
	}
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		test<6 * 8 / MCL_SIZEOF_UNIT>(tbl6[i]); // N = 6 or 12
	}
}
