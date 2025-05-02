#include <mcl/g2_def.hpp>

namespace mcl {

Fp Fp2::u_pm1o2;
Fp2 Fp2::g[Fp2::gN];
Fp2 Fp2::g2[Fp2::gN];
Fp2 Fp2::g3[Fp2::gN];

void (*Fp6Dbl::mulPre)(Fp6Dbl&, const Fp6&, const Fp6&) = 0;//mulPreT<false>;

void Fp2::mulA(Unit *pz, const Unit *px, const Unit *py)
{
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
	Fp2Dbl::init();
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
	Fp6Dbl::init();
	*pb = true;
}

void Fp6::sqr(Fp6& y, const Fp6& x)
{
	Fp6Dbl XX;
	Fp6Dbl::sqrPre(XX, x);
	Fp6Dbl::mod(y, XX);
}
void Fp6::mul(Fp6& z, const Fp6& x, const Fp6& y)
{
	Fp6Dbl XY;
	Fp6Dbl::mulPre(XY, x, y);
	Fp6Dbl::mod(z, XY);
}
/*
	x = a + bv + cv^2, v^3 = xi
	y = 1/x = p/q where
	p = (a^2 - bc xi) + (c^2 xi - ab)v + (b^2 - ac)v^2
	q = c^3 xi^2 + b(b^2 - 3ac)xi + a^3
	  = (a^2 - bc xi)a + ((c^2 xi - ab)c + (b^2 - ac)b) xi
*/
void Fp6::inv(Fp6& y, const Fp6& x)
{
	const Fp2& a = x.a;
	const Fp2& b = x.b;
	const Fp2& c = x.c;
	Fp2Dbl aa, bb, cc, ab, bc, ac;
	Fp2Dbl::sqrPre(aa, a);
	Fp2Dbl::sqrPre(bb, b);
	Fp2Dbl::sqrPre(cc, c);
	Fp2Dbl::mulPre(ab, a, b);
	Fp2Dbl::mulPre(bc, b, c);
	Fp2Dbl::mulPre(ac, c, a);

	Fp6 p;
	Fp2Dbl T;
	Fp2Dbl::mul_xi(T, bc);
	Fp2Dbl::sub(T, aa, T); // a^2 - bc xi
	Fp2Dbl::mod(p.a, T);
	Fp2Dbl::mul_xi(T, cc);
	Fp2Dbl::sub(T, T, ab); // c^2 xi - ab
	Fp2Dbl::mod(p.b, T);
	Fp2Dbl::sub(T, bb, ac); // b^2 - ac
	Fp2Dbl::mod(p.c, T);

	Fp2Dbl T2;
	Fp2Dbl::mulPre(T, p.b, c);
	Fp2Dbl::mulPre(T2, p.c, b);
	Fp2Dbl::add(T, T, T2);
	Fp2Dbl::mul_xi(T, T);
	Fp2Dbl::mulPre(T2, p.a, a);
	Fp2Dbl::add(T, T, T2);
	Fp2 q;
	Fp2Dbl::mod(q, T);
	Fp2::inv(q, q);

	Fp2::mul(y.a, p.a, q);
	Fp2::mul(y.b, p.b, q);
	Fp2::mul(y.c, p.c, q);
}

} // mcl
