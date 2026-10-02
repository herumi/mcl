/*
	test and bench of the raw functions of src/base64.ll for the A_ slots of Op:
	the p-generic functions (mcl_fp2_mul_u1_6L(z, x, y, p) etc., p = op.p with
	rp at p[-1], see common.gen_generic_fp / gen_generic_fp2 in src/gen.py)
	against mcl's Fp / Fr / Fp2 / Fp2Dbl (BLS12-381, BN_SNARK1 (xi_a = 9) and
	BLS12-377 (u = 5)), and the clock counts of BLS12-381.
	build: make bin/llvm_test64.exe (links lib/libmcl.a, whose base64.o is
	the production build of base64.ll)
	note: with MCL_USE_XBYAK=0 the A_ slots of Op hold these very functions,
	so mcl's Fp2 / Fp2Dbl are not an independent reference; build lib/libmcl.a
	with Xbyak (the default on x64) for that.
*/
#include <mcl/bn.hpp>
#include <cybozu/benchmark.hpp>
#include <cybozu/test.hpp>

using namespace mcl;
using namespace mcl::bn;
typedef mcl::Unit Unit;

typedef void (*GenOp3)(Unit*, const Unit*, const Unit*, const Unit*);
typedef void (*GenOp2)(Unit*, const Unit*, const Unit*);

extern "C" {
// p-generic of N units
#define DECL_GEN_FP(N) \
void mcl_fp_addNF##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp_subNF##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp_montNF##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp_neg##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp_mul2NF##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp_sqrNF##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp_montRedNF##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fpDbl_add##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fpDbl_sub##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp2_add##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp2_sub##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp2_neg##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp2_mul2_##N##L(Unit*, const Unit*, const Unit*);
#define DECL_GEN_FP2_U(N, u) \
void mcl_fp2_mul_u##u##_##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp2_sqr_u##u##_##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp2Dbl_mulPre_u##u##_##N##L(Unit*, const Unit*, const Unit*, const Unit*); \
void mcl_fp2Dbl_sqrPre_u##u##_##N##L(Unit*, const Unit*, const Unit*);
#define DECL_GEN_FP2_XI(N, u, xi) \
void mcl_fp2_mul_xi_u##u##x##xi##_##N##L(Unit*, const Unit*, const Unit*); \
void mcl_fp2Dbl_mul_xi_u##u##x##xi##_##N##L(Unit*, const Unit*, const Unit*);
DECL_GEN_FP(4)
DECL_GEN_FP(6)
DECL_GEN_FP2_U(4, 1)
DECL_GEN_FP2_U(6, 1)
DECL_GEN_FP2_U(6, 5)
DECL_GEN_FP2_XI(6, 1, 1)
DECL_GEN_FP2_XI(4, 1, 9)
DECL_GEN_FP2_XI(6, 5, 0)
}

struct GenFp {
	GenOp3 add, sub, mul;
	GenOp2 neg, mul2, sqr, mod;
	GenOp3 dblAdd, dblSub;
};
struct GenFp2 {
	GenOp3 add, sub, mul;
	GenOp2 neg, mul2, sqr, mul_xi;
	GenOp3 dblMulPre;
	GenOp2 dblSqrPre, dblMul_xi;
};
#define GEN_FP(N) { mcl_fp_addNF##N##L, mcl_fp_subNF##N##L, mcl_fp_montNF##N##L, mcl_fp_neg##N##L, mcl_fp_mul2NF##N##L, mcl_fp_sqrNF##N##L, mcl_fp_montRedNF##N##L, mcl_fpDbl_add##N##L, mcl_fpDbl_sub##N##L }
#define GEN_FP2(N, u, xi) { mcl_fp2_add##N##L, mcl_fp2_sub##N##L, mcl_fp2_mul_u##u##_##N##L, mcl_fp2_neg##N##L, mcl_fp2_mul2_##N##L, mcl_fp2_sqr_u##u##_##N##L, mcl_fp2_mul_xi_u##u##x##xi##_##N##L, mcl_fp2Dbl_mulPre_u##u##_##N##L, mcl_fp2Dbl_sqrPre_u##u##_##N##L, mcl_fp2Dbl_mul_xi_u##u##x##xi##_##N##L }

template<class T> Unit *U(T& x) { return reinterpret_cast<Unit*>(&x); }
template<class T> const Unit *U(const T& x) { return reinterpret_cast<const Unit*>(&x); }

// x < p R, i.e. the high half of the FpDbl x is < p
bool isLtPR(const FpDbl& x)
{
	const fp::Op& op = Fp::getOp();
	const Unit *v = U(x) + op.N;
	for (size_t i = op.N; i > 0; i--) {
		if (v[i - 1] < op.p[i - 1]) return true;
		if (v[i - 1] > op.p[i - 1]) return false;
	}
	return false;
}

// Fp2Dbl values are compared mod p (the representative in [0, p R) may
// differ from the one of mcl's Fp2Dbl by a multiple of p); the number of
// the exact mismatches is counted in g_dblNotEqual.
int g_dblNotEqual;
void checkDbl(const char *msg, const Fp2Dbl& d, const Fp2Dbl& e)
{
	CYBOZU_TEST_ASSERT(isLtPR(d.a));
	CYBOZU_TEST_ASSERT(isLtPR(d.b));
	CYBOZU_TEST_ASSERT(isLtPR(e.a));
	CYBOZU_TEST_ASSERT(isLtPR(e.b));
	Fp2 y1, y2;
	Fp2Dbl::mod(y1, d);
	Fp2Dbl::mod(y2, e);
	CYBOZU_TEST_EQUAL(y1, y2);
	if (y1 != y2) printf("err %s\n", msg);
	if (!(d == e)) g_dblNotEqual++;
}

// Fp or Fr: the p-generic Fp functions against T and the slots of Op
template<class T>
void testGenFp(const GenFp& g)
{
	const fp::Op& op = T::getOp();
	const Unit *p = op.p;
	const size_t N = op.N;
	for (int i = 0; i < 100; i++) {
		T x, y, z, w;
		x.setByCSPRNG();
		y.setByCSPRNG();
		if (i == 0) y = x; // x - x = 0, -0 = 0
		if (i == 1) y.clear();
		T::add(z, x, y); g.add(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		T::sub(z, x, y); g.sub(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		T::mul(z, x, y); g.mul(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		T::neg(z, y); g.neg(U(w), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		T::mul2(z, x); g.mul2(U(w), U(x), p); CYBOZU_TEST_EQUAL(z, w);
		T::sqr(z, x); g.sqr(U(w), U(x), p); CYBOZU_TEST_EQUAL(z, w);
		Unit d[2 * 16], d2[2 * 16], e[2 * 16], e2[2 * 16];
		op.fpDbl_mulPre(d, U(x), U(y));
		op.fpDbl_mulPre(d2, U(y), U(y));
		T::mul(z, x, y); g.mod(U(w), d, p); CYBOZU_TEST_EQUAL(z, w);
		op.fpDbl_add(e, d, d2, p); g.dblAdd(e2, d, d2, p); CYBOZU_TEST_EQUAL_ARRAY(e, e2, N * 2);
		op.fpDbl_sub(e, d, d2, p); g.dblSub(e2, d, d2, p); CYBOZU_TEST_EQUAL_ARRAY(e, e2, N * 2);
		// in place
		w = x; g.add(U(w), U(w), U(y), p); T::add(z, x, y); CYBOZU_TEST_EQUAL(z, w);
		w = x; g.mul(U(w), U(w), U(y), p); T::mul(z, x, y); CYBOZU_TEST_EQUAL(z, w);
		w = x; g.sqr(U(w), U(w), p); T::sqr(z, x); CYBOZU_TEST_EQUAL(z, w);
	}
}

// the p-generic Fp2 / Fp2Dbl functions against mcl's Fp2 / Fp2Dbl
void testGenFp2(const GenFp2& g)
{
	const Unit *p = Fp::getOp().p;
	g_dblNotEqual = 0;
	for (int i = 0; i < 100; i++) {
		Fp2 x, y, z, w;
		x.a.setByCSPRNG();
		x.b.setByCSPRNG();
		y.a.setByCSPRNG();
		y.b.setByCSPRNG();
		if (i == 0) y = x;
		if (i == 1) y.clear();
		Fp2::add(z, x, y); g.add(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::sub(z, x, y); g.sub(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::mul(z, x, y); g.mul(U(w), U(x), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::neg(z, y); g.neg(U(w), U(y), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::mul2(z, x); g.mul2(U(w), U(x), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::sqr(z, x); g.sqr(U(w), U(x), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2::mul_xi(z, x); g.mul_xi(U(w), U(x), p); CYBOZU_TEST_EQUAL(z, w);
		Fp2Dbl d, e;
		Fp2Dbl::mulPre(d, x, y); g.dblMulPre(U(e), U(x), U(y), p); checkDbl("mulPre", d, e);
		Fp2Dbl::sqrPre(d, x); g.dblSqrPre(U(e), U(x), p); checkDbl("sqrPre", d, e);
		Fp2Dbl::mulPre(d, x, y);
		Fp2Dbl::mul_xi(e, d); g.dblMul_xi(U(d), U(d), p); checkDbl("mul_xi", d, e);
		// in place
		w = x; g.mul(U(w), U(w), U(y), p); Fp2::mul(z, x, y); CYBOZU_TEST_EQUAL(z, w);
		w = x; g.sqr(U(w), U(w), p); Fp2::sqr(z, x); CYBOZU_TEST_EQUAL(z, w);
		w = x; g.mul_xi(U(w), U(w), p); Fp2::mul_xi(z, x); CYBOZU_TEST_EQUAL(z, w);
	}
	printf("Fp2Dbl exact mismatches against mcl : %d\n", g_dblNotEqual);
}

// clocks per call (the best of 3 runs)
template<class F>
double bench(F f)
{
	const int C = 100000;
	double best = 1e30;
	for (int k = 0; k < 3; k++) {
		CYBOZU_BENCH_C("", C, f);
		double clk = double(cybozu::bench::g_clk.getClock()) / C;
		if (clk < best) best = clk;
	}
	return best;
}

void put(const char *name, double clk)
{
	printf("%-16s %8.2f\n", name, clk);
}

// clk of the p-generic functions (in-place chains for the binary and unary ops)
template<class T>
void benchFp(const char *msg, const GenFp& g)
{
	const fp::Op& op = T::getOp();
	const Unit *p = op.p;
	T x, y;
	x.setByCSPRNG();
	y.setByCSPRNG();
	Unit *px = U(x);
	const Unit *py = U(y);
	Unit d[2 * 16];
	op.fpDbl_mulPre(d, px, py);
	Unit d2[2 * 16];
	op.fpDbl_mulPre(d2, py, py);
	printf("%s\n", msg);
	put("add", bench([&]{ g.add(px, px, py, p); }));
	put("sub", bench([&]{ g.sub(px, px, py, p); }));
	put("neg", bench([&]{ g.neg(px, px, p); }));
	put("mul2", bench([&]{ g.mul2(px, px, p); }));
	put("mul", bench([&]{ g.mul(px, px, py, p); }));
	put("sqr", bench([&]{ g.sqr(px, px, p); }));
	put("mod", bench([&]{ g.mod(px, d, p); }));
	put("dblAdd", bench([&]{ g.dblAdd(d, d, d2, p); }));
	put("dblSub", bench([&]{ g.dblSub(d, d, d2, p); }));
}

void benchFp2(const char *msg, const GenFp2& g)
{
	const Unit *p = Fp::getOp().p;
	Fp2 x, y;
	x.a.setByCSPRNG();
	x.b.setByCSPRNG();
	y.a.setByCSPRNG();
	y.b.setByCSPRNG();
	Unit *px = U(x);
	const Unit *py = U(y);
	Fp2Dbl d;
	Unit *pd = U(d);
	printf("%s\n", msg);
	put("add", bench([&]{ g.add(px, px, py, p); }));
	put("sub", bench([&]{ g.sub(px, px, py, p); }));
	put("neg", bench([&]{ g.neg(px, px, p); }));
	put("mul2", bench([&]{ g.mul2(px, px, p); }));
	put("mul", bench([&]{ g.mul(px, px, py, p); }));
	put("sqr", bench([&]{ g.sqr(px, px, p); }));
	put("mul_xi", bench([&]{ g.mul_xi(px, px, p); }));
	put("dblMulPre", bench([&]{ g.dblMulPre(pd, px, py, p); }));
	put("dblSqrPre", bench([&]{ g.dblSqrPre(pd, px, p); }));
	put("dblMul_xi", bench([&]{ g.dblMul_xi(pd, pd, p); }));
}

CYBOZU_TEST_AUTO(bls12_381)
{
	puts("BLS12-381");
	initPairing(mcl::BLS12_381);
	const GenFp gFp = GEN_FP(6);
	const GenFp gFr = GEN_FP(4);
	const GenFp2 gFp2 = GEN_FP2(6, 1, 1);
	testGenFp<Fp>(gFp);
	testGenFp<Fr>(gFr);
	testGenFp2(gFp2);
	printf("clk of the p-generic functions\n");
	benchFp<Fp>("Fp (BLS12-381)", gFp);
	benchFp<Fr>("Fr (BLS12-381)", gFr);
	benchFp2("Fp2 (BLS12-381)", gFp2);
}

CYBOZU_TEST_AUTO(bn_snark1)
{
	puts("BN_SNARK1");
	initPairing(mcl::BN_SNARK1); // u = 1, xi_a = 9
	const GenFp gFp = GEN_FP(4);
	const GenFp2 gFp2 = GEN_FP2(4, 1, 9);
	testGenFp<Fp>(gFp);
	testGenFp<Fr>(gFp);
	testGenFp2(gFp2);
}

CYBOZU_TEST_AUTO(bls12_377)
{
	puts("BLS12-377");
	initPairing(mcl::BLS12_377); // u = 5, xi_a = 0
	const GenFp gFp = GEN_FP(6);
	const GenFp gFr = GEN_FP(4);
	const GenFp2 gFp2 = GEN_FP2(6, 5, 0);
	testGenFp<Fp>(gFp);
	testGenFp<Fr>(gFr);
	testGenFp2(gFp2);
}
