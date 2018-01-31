void testBench(const G1& P, const G2& Q)
{
	G1 Pa;
	G2 Qa;
	Fp12 e1, e2;
	BN::pairing(e1, P, Q);
	Fp12::pow(e2, e1, 12345);
	const int C = 500;
	const int C2 = 1000;
	Fp x, y;
	x.setHashOf("abc");
	y.setHashOf("xyz");
	mpz_class z = 3;
	mpz_class a = x.getMpz();
	CYBOZU_BENCH_C("G1::mulCT     ", C, G1::mulCT, Pa, P, a);
	CYBOZU_BENCH_C("G1::mulCTsmall", C, G1::mulCT, Pa, P, z);
	CYBOZU_BENCH_C("G1::mul       ", C, G1::mul, Pa, Pa, a);
	CYBOZU_BENCH_C("G1::mulsmall  ", C, G1::mul, Pa, Pa, z);
	CYBOZU_BENCH_C("G1::add       ", C, G1::add, Pa, Pa, P);
	CYBOZU_BENCH_C("G1::dbl       ", C, G1::dbl, Pa, Pa);
	CYBOZU_BENCH_C("G2::mulCT     ", C, G2::mulCT, Qa, Q, a);
	CYBOZU_BENCH_C("G2::mulCTsmall", C, G2::mulCT, Qa, Q, z);
	CYBOZU_BENCH_C("G2::mul       ", C, G2::mul, Qa, Qa, a);
	CYBOZU_BENCH_C("G2::mulsmall  ", C, G2::mul, Qa, Qa, z);
	CYBOZU_BENCH_C("G2::add       ", C, G2::add, Qa, Qa, Q);
	CYBOZU_BENCH_C("G2::dbl       ", C, G2::dbl, Qa, Qa);
	CYBOZU_BENCH_C("GT::pow       ", C, GT::pow, e1, e1, a);
	CYBOZU_BENCH_C("GT::powGLV    ", C, BN::param.glv2.pow, e1, e1, a);
	G1 PP;
	G2 QQ;
	CYBOZU_BENCH_C("hashAndMapToG1", C, BN::hashAndMapToG1, PP, "abc", 3);
	CYBOZU_BENCH_C("hashAndMapToG2", C, BN::hashAndMapToG2, QQ, "abc", 3);
	CYBOZU_BENCH_C("Fp::add       ", C2, Fp::add, x, x, y);
	CYBOZU_BENCH_C("Fp::mul       ", C2, Fp::mul, x, x, y);
	CYBOZU_BENCH_C("Fp::sqr       ", C2, Fp::sqr, x, x);
	CYBOZU_BENCH_C("Fp::inv       ", C2, Fp::inv, x, x);

	CYBOZU_BENCH_C("GT::add       ", C2, GT::add, e1, e1, e2);
	CYBOZU_BENCH_C("GT::mul       ", C2, GT::mul, e1, e1, e2);
	CYBOZU_BENCH_C("GT::sqr       ", C2, GT::sqr, e1, e1);
	CYBOZU_BENCH_C("GT::inv       ", C2, GT::inv, e1, e1);
	CYBOZU_BENCH_C("pairing       ", C, BN::pairing, e1, P, Q);
	CYBOZU_BENCH_C("millerLoop    ", C, BN::millerLoop, e1, P, Q);
	CYBOZU_BENCH_C("finalExp      ", C, BN::finalExp, e1, e1);
	std::vector<Fp6> Qcoeff;
	BN::precomputeG2(Qcoeff, Q);
	CYBOZU_BENCH_C("precomputedML ", C, BN::precomputedMillerLoop, e2, P, Qcoeff);
}
