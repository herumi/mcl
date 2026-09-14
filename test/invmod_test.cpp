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
	mcl::inv::init(im, M);
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

#if MCL_SIZEOF_UNIT == 8 && (defined(__SIZEOF_INT128__) || defined(_MSC_VER))
#ifdef _MSC_VER
#include <intrin.h>
#endif
/*
	signed62 (libsecp256k1 style) version for comparison with inv::twos
	f, g, d, e are L limbs of 62 bits (int64_t; the low limbs in [0, 2^62) and
	the top limb signed) with L = ceil((64N + 2) / 62) (5 for 256-bit, 7 for
	384-bit) as secp256k1_modinv64_signed62. The updates accumulate the limb
	products in __int128 (cf. secp256k1_modinv64_update_{fg,de}_62); the 2-bit
	headroom means no carry chain and no sign correction, and -2M < d, e < M
	always fits (no wide switch). The fixed length L is used (the var version
	of libsecp256k1 shrinks the length of f, g as they shrink). divsteps and
	the md choice are the same as inv::twos, so the values of f, g, d, e agree.
*/
namespace s62 {

typedef mcl::Unit Unit;

/*
	128-bit signed accumulator of the limb products. Only mul, accumulate,
	the low 64 bits and >> 62 are needed. Native __int128 if available
	(gcc/clang), otherwise a {lo, hi} struct with the 64x64 -> 128 multiply
	intrinsic of MSVC (_mul128 on x64, __mulh on ARM64) as libsecp256k1's
	int128_struct_impl.h. MCL_S62_STRUCT_I128 forces the struct version (to
	test it with gcc/clang).
*/
#if defined(__SIZEOF_INT128__) && !defined(MCL_S62_STRUCT_I128)
typedef __int128 I128;
inline I128 mul128(int64_t a, int64_t b) { return (I128)a * b; }
inline void accumMul(I128& c, int64_t a, int64_t b) { c += (I128)a * b; }
inline void shr62(I128& c) { c >>= 62; }
inline int64_t low64(const I128& c) { return (int64_t)c; }
#else
struct I128 {
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
inline I128 mul128(int64_t a, int64_t b)
{
	I128 c;
	c.lo = mulLoHi(a, b, &c.hi);
	return c;
}
inline void accumMul(I128& c, int64_t a, int64_t b)
{
	int64_t hi;
	uint64_t lo = mulLoHi(a, b, &hi);
	c.lo += lo;
	c.hi = (int64_t)((uint64_t)c.hi + (uint64_t)hi + (c.lo < lo));
}
// arithmetic shift
inline void shr62(I128& c)
{
	c.lo = (c.lo >> 62) | ((uint64_t)c.hi << 2);
	c.hi >>= 62;
}
inline int64_t low64(const I128& c) { return (int64_t)c.lo; }
#endif

static const int64_t M62 = (int64_t)(UINT64_MAX >> 2);
template<int L>
struct S62 {
	int64_t v[L];
};
template<int N>
struct Inv62 {
	static const int L = (64 * N + 63) / 62;
	S62<L> M;
	uint64_t Mi; // M^-1 mod 2^62
};

// x[N] (nonnegative 64-bit units) -> signed62
template<int N, int L>
void toS62(S62<L>& y, const uint64_t *x)
{
	for (int i = 0; i < L; i++) {
		int bit = 62 * i;
		int idx = bit / 64, off = bit % 64;
		uint64_t lo = idx < N ? x[idx] >> off : 0;
		uint64_t hi = (off > 2 && idx + 1 < N) ? x[idx + 1] << (64 - off) : 0;
		y.v[i] = (int64_t)((lo | hi) & (uint64_t)M62);
	}
}

// normalized nonnegative signed62 (< 2^(64N)) -> x[N]
template<int N, int L>
void fromS62(uint64_t *x, const S62<L>& y)
{
	for (int i = 0; i < N; i++) x[i] = 0;
	for (int i = 0; i < L; i++) {
		int bit = 62 * i;
		int idx = bit / 64, off = bit % 64;
		uint64_t v = (uint64_t)y.v[i];
		if (idx < N) x[idx] |= v << off;
		if (off > 2 && idx + 1 < N) x[idx + 1] |= v >> (64 - off);
	}
}

template<int L>
bool isZero(const S62<L>& x)
{
	int64_t r = 0;
	for (int i = 0; i < L; i++) r |= x.v[i];
	return r == 0;
}

template<int L>
void update_fg(S62<L>& f, S62<L>& g, const mcl::inv::Quad& t)
{
	const int64_t u = (int64_t)t.u, v = (int64_t)t.v, q = (int64_t)t.q, r = (int64_t)t.r;
	int64_t fi = f.v[0], gi = g.v[0];
	I128 cf = mul128(u, fi); accumMul(cf, v, gi);
	I128 cg = mul128(q, fi); accumMul(cg, r, gi);
	// the low 62 bits are zero
	shr62(cf);
	shr62(cg);
	for (int i = 1; i < L; i++) {
		fi = f.v[i];
		gi = g.v[i];
		accumMul(cf, u, fi); accumMul(cf, v, gi);
		accumMul(cg, q, fi); accumMul(cg, r, gi);
		f.v[i - 1] = low64(cf) & M62; shr62(cf);
		g.v[i - 1] = low64(cg) & M62; shr62(cg);
	}
	f.v[L - 1] = low64(cf);
	g.v[L - 1] = low64(cg);
}

template<int L>
void update_de(const S62<L>& M, uint64_t Mi, S62<L>& d, S62<L>& e, const mcl::inv::Quad& t)
{
	const int64_t u = (int64_t)t.u, v = (int64_t)t.v, q = (int64_t)t.q, r = (int64_t)t.r;
	const int64_t d0 = d.v[0], e0 = e.v[0];
	const int64_t sd = d.v[L - 1] >> 63;
	const int64_t se = e.v[L - 1] >> 63;
	int64_t md = (u & sd) + (v & se);
	int64_t me = (q & sd) + (r & se);
	I128 cd = mul128(u, d0); accumMul(cd, v, e0);
	I128 ce = mul128(q, d0); accumMul(ce, r, e0);
	md -= (int64_t)((Mi * (uint64_t)low64(cd) + (uint64_t)md) & (uint64_t)M62);
	me -= (int64_t)((Mi * (uint64_t)low64(ce) + (uint64_t)me) & (uint64_t)M62);
	accumMul(cd, M.v[0], md);
	accumMul(ce, M.v[0], me);
	shr62(cd);
	shr62(ce);
	for (int i = 1; i < L; i++) {
		accumMul(cd, u, d.v[i]); accumMul(cd, v, e.v[i]); accumMul(cd, M.v[i], md);
		accumMul(ce, q, d.v[i]); accumMul(ce, r, e.v[i]); accumMul(ce, M.v[i], me);
		d.v[i - 1] = low64(cd) & M62; shr62(cd);
		e.v[i - 1] = low64(ce) & M62; shr62(ce);
	}
	d.v[L - 1] = low64(cd);
	e.v[L - 1] = low64(ce);
}

// r in (-2M, M) -> [0, M), negated if sign < 0 (secp256k1_modinv64_normalize_62)
template<int L>
void normalize(S62<L>& r, int64_t sign, const S62<L>& M)
{
	int64_t cond = r.v[L - 1] >> 63;
	for (int i = 0; i < L; i++) r.v[i] += M.v[i] & cond;
	cond = sign >> 63;
	for (int i = 0; i < L; i++) r.v[i] = (r.v[i] ^ cond) - cond;
	for (int i = 0; i < L - 1; i++) {
		r.v[i + 1] += r.v[i] >> 62;
		r.v[i] &= M62;
	}
	cond = r.v[L - 1] >> 63;
	for (int i = 0; i < L; i++) r.v[i] += M.v[i] & cond;
	for (int i = 0; i < L - 1; i++) {
		r.v[i + 1] += r.v[i] >> 62;
		r.v[i] &= M62;
	}
}

template<int N>
void init(Inv62<N>& im62, const mcl::inv::InvModT<N>& im)
{
	toS62<N, Inv62<N>::L>(im62.M, im.M);
	im62.Mi = im.Mi;
}

template<int N>
void exec(const Inv62<N>& im, uint64_t *y, const uint64_t *x)
{
	using namespace mcl::inv;
	const int L = Inv62<N>::L;
	INT eta = -1;
	S62<L> f = im.M, g, d, e;
	toS62<N, L>(g, x);
	memset(&d, 0, sizeof(d));
	memset(&e, 0, sizeof(e));
	e.v[0] = 1;
	Quad t;
	while (!isZero(g)) {
		eta = divsteps_n_matrix(t, eta, (uint64_t)f.v[0], (uint64_t)g.v[0]);
		update_fg<L>(f, g, t);
		update_de<L>(im.M, im.Mi, d, e, t);
	}
	normalize<L>(d, f.v[L - 1], im.M);
	fromS62<N, L>(y, d);
}

template<int N>
void exec(const Inv62<N>& im, mpz_class& y, const mpz_class& x)
{
	Unit ux[N], uy[N];
	mcl::gmp::getArray(ux, N, x);
	exec<N>(im, uy, ux);
	mcl::gmp::setArray(y, uy, N);
}

} // s62

// the signed62 version against gmp and inv::exec
template<int N>
void testS62(const mpz_class& M)
{
	mcl::inv::InvModT<N> im;
	mcl::inv::init(im, M);
	s62::Inv62<N> im62;
	s62::init(im62, im);
	mpz_class x, y, z, w;
	cybozu::XorShift rg;
	for (int i = 0; i < 10000; i++) {
		mcl::Unit v[N];
		for (int j = 0; j < N; j++) v[j] = (mcl::Unit)rg.get64();
		mcl::gmp::setArray(x, v, N);
		x %= M;
		if (x == 0) continue;
		mcl::gmp::invMod(y, x, M);
		s62::exec(im62, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		mcl::inv::exec(im, w, x);
		CYBOZU_TEST_EQUAL(w, z);
	}
	x = 1;
	for (int i = 0; i < 1000; i++) {
		mcl::gmp::invMod(y, x, M);
		s62::exec(im62, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x = y + 1;
	}
	x = M - 1;
	for (int i = 0; i < 1000; i++) {
		mcl::gmp::invMod(y, x, M);
		s62::exec(im62, z, x);
		CYBOZU_TEST_EQUAL(y, z);
		x--;
	}
#ifdef NDEBUG
	CYBOZU_BENCH_C("invMod(s62)", 1000, x++;s62::exec, im62, x, x);
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
	mcl::inv::init(im, M);
	if (!im.wide) testSub<N>(M, false);
	testSub<N>(M, true);
#if MCL_SIZEOF_UNIT == 8 && (defined(__SIZEOF_INT128__) || defined(_MSC_VER))
	testS62<N>(M);
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
		test<4>(tbl4[i]);
	}
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl6); i++) {
		test<6>(tbl6[i]);
	}
}
