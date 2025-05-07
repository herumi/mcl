#pragma once

namespace mcl { namespace bn {

struct Compress {
	Fp12& z_;
	Fp2& g1_;
	Fp2& g2_;
	Fp2& g3_;
	Fp2& g4_;
	Fp2& g5_;
	// z is output area
	Compress(Fp12& z, const Fp12& x)
		: z_(z)
		, g1_(z.getFp2()[4])
		, g2_(z.getFp2()[3])
		, g3_(z.getFp2()[2])
		, g4_(z.getFp2()[1])
		, g5_(z.getFp2()[5])
	{
		g2_ = x.getFp2()[3];
		g3_ = x.getFp2()[2];
		g4_ = x.getFp2()[1];
		g5_ = x.getFp2()[5];
	}
	Compress(Fp12& z, const Compress& c)
		: z_(z)
		, g1_(z.getFp2()[4])
		, g2_(z.getFp2()[3])
		, g3_(z.getFp2()[2])
		, g4_(z.getFp2()[1])
		, g5_(z.getFp2()[5])
	{
		g2_ = c.g2_;
		g3_ = c.g3_;
		g4_ = c.g4_;
		g5_ = c.g5_;
	}
	void decompressBeforeInv(Fp2& nume, Fp2& denomi) const
	{
		assert(&nume != &denomi);

		if (g2_.isZero()) {
			Fp2::mul2(nume, g4_);
			nume *= g5_;
			denomi = g3_;
		} else {
			Fp2 t;
			Fp2::sqr(nume, g5_);
			Fp2::mul_xi(denomi, nume);
			Fp2::sqr(nume, g4_);
			Fp2::sub(t, nume, g3_);
			Fp2::mul2(t, t);
			t += nume;
			Fp2::add(nume, denomi, t);
			Fp2::divBy4(nume, nume);
			denomi = g2_;
		}
	}

	// output to z
	void decompressAfterInv()
	{
		Fp2& g0 = z_.getFp2()[0];
		Fp2 t0, t1;
		// Compute g0.
		Fp2::sqr(t0, g1_);
		Fp2::mul(t1, g3_, g4_);
		t0 -= t1;
		Fp2::mul2(t0, t0);
		t0 -= t1;
		Fp2::mul(t1, g2_, g5_);
		t0 += t1;
		Fp2::mul_xi(g0, t0);
		g0.a += Fp::one();
	}

public:
	void decompress() // for test
	{
		Fp2 nume, denomi;
		decompressBeforeInv(nume, denomi);
		Fp2::inv(denomi, denomi);
		g1_ = nume * denomi; // g1 is recoverd.
		decompressAfterInv();
	}
	/*
		2275clk * 186 = 423Kclk QQQ
	*/
	static void squareC(Compress& z)
	{
		Fp2 t0, t1, t2;
		Fp2Dbl T0, T1, T2, T3;
		Fp2Dbl::sqrPre(T0, z.g4_);
		Fp2Dbl::sqrPre(T1, z.g5_);
		Fp2Dbl::mul_xi(T2, T1);
		T2 += T0;
		Fp2Dbl::mod(t2, T2);
		Fp2::add(t0, z.g4_, z.g5_);
		Fp2Dbl::sqrPre(T2, t0);
		T0 += T1;
		T2 -= T0;
		Fp2Dbl::mod(t0, T2);
		Fp2::add(t1, z.g2_, z.g3_);
		Fp2Dbl::sqrPre(T3, t1);
		Fp2Dbl::sqrPre(T2, z.g2_);
		Fp2::mul_xi(t1, t0);
		z.g2_ += t1;
		Fp2::mul2(z.g2_, z.g2_);
		z.g2_ += t1;
		Fp2::sub(t1, t2, z.g3_);
		Fp2::mul2(t1, t1);
		Fp2Dbl::sqrPre(T1, z.g3_);
		Fp2::add(z.g3_, t1, t2);
		Fp2Dbl::mul_xi(T0, T1);
		T0 += T2;
		Fp2Dbl::mod(t0, T0);
		Fp2::sub(z.g4_, t0, z.g4_);
		Fp2::mul2(z.g4_, z.g4_);
		z.g4_ += t0;
		Fp2Dbl::addPre(T2, T2, T1);
		T3 -= T2;
		Fp2Dbl::mod(t0, T3);
		z.g5_ += t0;
		Fp2::mul2(z.g5_, z.g5_);
		z.g5_ += t0;
	}
	static void square_n(Compress& z, int n)
	{
		for (int i = 0; i < n; i++) {
			squareC(z);
		}
	}
	/*
		Exponentiation over compression for:
		z = x^Param::z.abs()
	*/
	static void fixed_power(Fp12& z, const Fp12& x)
	{
		if (x.isOne()) {
			z = 1;
			return;
		}
		Fp12 x_org = x;
		Fp12 d62;
		Fp2 c55nume, c55denomi, c62nume, c62denomi;
		Compress c55(z, x);
		square_n(c55, 55);
		c55.decompressBeforeInv(c55nume, c55denomi);
		Compress c62(d62, c55);
		square_n(c62, 62 - 55);
		c62.decompressBeforeInv(c62nume, c62denomi);
		Fp2 acc;
		Fp2::mul(acc, c55denomi, c62denomi);
		Fp2::inv(acc, acc);
		Fp2 t;
		Fp2::mul(t, acc, c62denomi);
		Fp2::mul(c55.g1_, c55nume, t);
		c55.decompressAfterInv();
		Fp2::mul(t, acc, c55denomi);
		Fp2::mul(c62.g1_, c62nume, t);
		c62.decompressAfterInv();
		z *= x_org;
		z *= d62;
	}
};

} } // mcl::bn

