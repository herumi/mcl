#include <mcl/g2_def.hpp>

namespace mcl {

Fp Fp2::u_pm1o2;
Fp2 Fp2::g[Fp2::gN];
Fp2 Fp2::g2[Fp2::gN];
Fp2 Fp2::g3[Fp2::gN];

void Fp2::mulA(Unit *pz, const Unit *px, const Unit *py)
{
	typedef Fp2DblT<Fp> Fp2Dbl;
	Fp2& z = cast(pz);
	const Fp2& x = cast(px);
	const Fp2& y = cast(py);
	Fp2Dbl d;
	Fp2Dbl::mulPre(d, x, y);
	FpDbl::mod(z.a, d.a);
	FpDbl::mod(z.b, d.b);
}

void Fp2::init(bool *pb)
{
	mcl::fp::Op& op = Fp::op_;
	uint32_t u = Fp::getOp().u;
#ifdef MCL_XBYAK_DIRECT_CALL
	if (op.fp2_addA_ == 0) {
		op.fp2_addA_ = addA;
	}
	if (op.fp2_subA_ == 0) {
		op.fp2_subA_ = subA;
	}
	if (op.fp2_negA_ == 0) {
		op.fp2_negA_ = negA;
	}
	if (op.fp2_mul2A_ == 0) {
		op.fp2_mul2A_ = mul2A;
	}
	if (op.fp2_mulA_ == 0) {
		op.fp2_mulA_ = mulA;
	}
	if (op.fp2_sqrA_ == 0) {
		if (u == 1) {
			op.fp2_sqrA_ = sqrA;
		} else if (u == 5) {
			op.fp2_sqrA_ = sqrAu5;
		} else {
			assert(0);
		}
	}
#endif
	if (op.fp2_mul_xiA_ == 0) {
		if (u == 1) {
			if (op.xi_a == 1) {
				op.fp2_mul_xiA_ = fp2_mul_xi_1_iA;
			} else {
				op.fp2_mul_xiA_ = fp2_mul_xi_a_iA;
			}
		} else {
			if (op.fp2_mul_xiA_ == 0) {
				if (op.xi_a == 0) {
					op.fp2_mul_xiA_ = fp2u_mul_xi_0_iA;
				} else {
					assert(0);
//					op.fp2_mul_xiA_ = fp2u_mul_xi_a_iA;
				}
			}
		}
	}
	FpDbl::init();
	Fp2DblT<Fp>::init();
	// call init before Fp2::pow because FpDbl is used in Fp2
	const Fp2 xi(op.xi_a, 1);
	const mpz_class& p = Fp::getOp().mp;
	Fp::pow(u_pm1o2, int(op.u), (p - 1) / 2);
	Fp2::pow(g[0], xi, (p - 1) / 6); // g = xi^((p-1)/6)
	for (size_t i = 1; i < gN; i++) {
		g[i] = g[i - 1] * g[0];
	}
	/*
		permutate [0, 1, 2, 3, 4] => [1, 3, 0, 2, 4]
		g[0] = g^2
		g[1] = g^4
		g[2] = g^1
		g[3] = g^3
		g[4] = g^5
	*/
	{
		Fp2 t = g[0];
		g[0] = g[1];
		g[1] = g[3];
		g[3] = g[2];
		g[2] = t;
	}
	for (size_t i = 0; i < gN; i++) {
		Fp2 t(g[i].a, g[i].b);
		if (Fp::getOp().pmod4 == 3) Fp::neg(t.b, t.b);
		Fp2::mul(g2[i], t, g[i]);
		g3[i] = g[i] * g2[i];
	}
	Fp6DblT<Fp>::init();
	*pb = true;
}


} // mcl
