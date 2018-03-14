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
				Fp2::add(nume, g4_, g4_);
				nume *= g5_;
				denomi = g3_;
			} else {
				Fp2 t;
				Fp2::sqr(nume, g5_);
				Fp2::mul_xi(denomi, nume);
				Fp2::sqr(nume, g4_);
				Fp2::sub(t, nume, g3_);
				t += t;
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
			t0 += t0;
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
			z.g2_ += z.g2_;
			z.g2_ += t1;
			Fp2::sub(t1, t2, z.g3_);
			t1 += t1;
			Fp2Dbl::sqrPre(T1, z.g3_);
			Fp2::add(z.g3_, t1, t2);
			Fp2Dbl::mul_xi(T0, T1);
			T0 += T2;
			Fp2Dbl::mod(t0, T0);
			Fp2::sub(z.g4_, t0, z.g4_);
			z.g4_ += z.g4_;
			z.g4_ += t0;
			Fp2Dbl::addPre(T2, T2, T1);
			T3 -= T2;
			Fp2Dbl::mod(t0, T3);
			z.g5_ += t0;
			z.g5_ += z.g5_;
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
			assert(param.isCurveFp254BNb);
			Fp12 x_org = x;
			Fp12 d62;
			Fp2 c55nume, c55denomi, c62nume, c62denomi;
			Compress c55(z, x);
			Compress::square_n(c55, 55);
			c55.decompressBeforeInv(c55nume, c55denomi);
			Compress c62(d62, c55);
			Compress::square_n(c62, 62 - 55);
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
	/*
		y = x^z if z > 0
		  = unitaryInv(x^(-z)) if z < 0
	*/
	static void pow_z(Fp12& y, const Fp12& x)
	{
#if 1
		if (param.isCurveFp254BNb) {
			Compress::fixed_power(y, x);
		} else {
			Fp12 orgX = x;
			y = x;
			Fp12 conj;
			conj.a = x.a;
			Fp6::neg(conj.b, x.b);
			for (size_t i = 1; i < param.zReplTbl.size(); i++) {
				fasterSqr(y, y);
				if (param.zReplTbl[i] > 0) {
					y *= orgX;
				} else if (param.zReplTbl[i] < 0) {
					y *= conj;
				}
			}
		}
#else
		Fp12::pow(y, x, param.abs_z);
#endif
		if (param.isNegative) {
			Fp12::unitaryInv(y, y);
		}
	}
	static void dblLineWithoutP(Fp6& l, G2& Q)
	{
		Fp2 t0, t1, t2, t3, t4, t5;
		Fp2Dbl T0, T1;
		Fp2::sqr(t0, Q.z);
		Fp2::mul(t4, Q.x, Q.y);
		Fp2::sqr(t1, Q.y);
		Fp2::add(t3, t0, t0);
		Fp2::divBy2(t4, t4);
		Fp2::add(t5, t0, t1);
		t0 += t3;
#if 0
		Fp2::mul_xi(t2, t0);
#else
		util::mul_b_div_xi(param, t2, t0);
#endif
		Fp2::sqr(t0, Q.x);
		Fp2::add(t3, t2, t2);
		t3 += t2;
		Fp2::sub(Q.x, t1, t3);
		t3 += t1;
		Q.x *= t4;
		Fp2::divBy2(t3, t3);
		Fp2Dbl::sqrPre(T0, t3);
		Fp2Dbl::sqrPre(T1, t2);
		Fp2Dbl::sub(T0, T0, T1);
		Fp2Dbl::add(T1, T1, T1);
		Fp2Dbl::sub(T0, T0, T1);
		Fp2::add(t3, Q.y, Q.z);
		Fp2Dbl::mod(Q.y, T0);
		Fp2::sqr(t3, t3);
		t3 -= t5;
		Fp2::mul(Q.z, t1, t3);
		Fp2::sub(l.a, t2, t1);
		l.c = t0;
		l.b = t3;
	}
	static void addLineWithoutP(Fp6& l, G2& R, const G2& Q)
	{
		Fp2 t1, t2, t3, t4;
		Fp2Dbl T1, T2;
		Fp2::mul(t1, R.z, Q.x);
		Fp2::mul(t2, R.z, Q.y);
		Fp2::sub(t1, R.x, t1);
		Fp2::sub(t2, R.y, t2);
		Fp2::sqr(t3, t1);
		Fp2::mul(R.x, t3, R.x);
		Fp2::sqr(t4, t2);
		t3 *= t1;
		t4 *= R.z;
		t4 += t3;
		t4 -= R.x;
		t4 -= R.x;
		R.x -= t4;
		Fp2Dbl::mulPre(T1, t2, R.x);
		Fp2Dbl::mulPre(T2, t3, R.y);
		Fp2Dbl::sub(T2, T1, T2);
		Fp2Dbl::mod(R.y, T2);
		Fp2::mul(R.x, t1, t4);
		Fp2::mul(R.z, t3, R.z);
		Fp2::neg(l.c, t2);
		Fp2Dbl::mulPre(T1, t2, Q.x);
		Fp2Dbl::mulPre(T2, t1, Q.y);
		Fp2Dbl::sub(T1, T1, T2);
		l.b = t1;
		Fp2Dbl::mod(l.a, T1);
	}
	static void dblLine(Fp6& l, G2& Q, const G1& P)
	{
		dblLineWithoutP(l, Q);
		util::updateLine(l, P);
	}
	static void addLine(Fp6& l, G2& R, const G2& Q, const G1& P)
	{
		addLineWithoutP(l, R, Q);
		util::updateLine(l, P);
	}
	static void mulFp6cb_by_G1xy(Fp6& y, const Fp6& x, const G1& P)
	{
		assert(P.isNormalized());
		if (&y != &x) y.a = x.a;
		Fp2::mulFp(y.c, x.c, P.x);
		Fp2::mulFp(y.b, x.b, P.y);
	}

	/*
		x = a + bv + cv^2
		y = (y0, y4, y2) -> (y0, 0, y2, 0, y4, 0)
		z = xy = (a + bv + cv^2)(d + ev)
		= (ad + ce xi) + ((a + b)(d + e) - ad - be)v + (be + cd)v^2
	*/
	static void Fp6mul_01(Fp6& z, const Fp6& x, const Fp2& d, const Fp2& e)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		Fp2 t0, t1;
		Fp2Dbl AD, CE, BE, CD, T;
		Fp2Dbl::mulPre(AD, a, d);
		Fp2Dbl::mulPre(CE, c, e);
		Fp2Dbl::mulPre(BE, b, e);
		Fp2Dbl::mulPre(CD, c, d);
		Fp2::add(t0, a, b);
		Fp2::add(t1, d, e);
		Fp2Dbl::mulPre(T, t0, t1);
		T -= AD;
		T -= BE;
		Fp2Dbl::mod(z.b, T);
		Fp2Dbl::mul_xi(CE, CE);
		AD += CE;
		Fp2Dbl::mod(z.a, AD);
		BE += CD;
		Fp2Dbl::mod(z.c, BE);
	}
	/*
		input
		z = (z0 + z1v + z2v^2) + (z3 + z4v + z5v^2)w = Z0 + Z1w
		x = (a, b, c) -> (b, 0, 0, c, a, 0) = X0 + X1w
		X0 = b = (b, 0, 0)
		X1 = c + av = (c, a, 0)
		w^2 = v, v^3 = xi
		output
		z <- zx = (Z0X0 + Z1X1v) + ((Z0 + Z1)(X0 + X1) - Z0X0 - Z1X1)w
		Z0X0 = Z0 b
		Z1X1 = Z1 (c, a, 0)
		(Z0 + Z1)(X0 + X1) = (Z0 + Z1) (b + c, a, 0)
	*/
	static void mul_025(Fp12& z, const Fp6& x)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
#if 0
		Fp6& z0 = z.a;
		Fp6& z1 = z.b;
		Fp6 z0x0, z1x1, t0;
		Fp2 t1;
		Fp2::add(t1, x.b, c);
		Fp6::add(t0, z0, z1);
		Fp2::mul(z0x0.a, z0.a, b);
		Fp2::mul(z0x0.b, z0.b, b);
		Fp2::mul(z0x0.c, z0.c, b);
		Fp6mul_01(z1x1, z1, c, a);
		Fp6mul_01(t0, t0, t1, a);
		Fp6::sub(z.b, t0, z0x0);
		z.b -= z1x1;
		// a + bv + cv^2 = cxi + av + bv^2
		Fp2::mul_xi(z1x1.c, z1x1.c);
		Fp2::add(z.a.a, z0x0.a, z1x1.c);
		Fp2::add(z.a.b, z0x0.b, z1x1.a);
		Fp2::add(z.a.c, z0x0.c, z1x1.b);
#else
		Fp2& z0 = z.a.a;
		Fp2& z1 = z.a.b;
		Fp2& z2 = z.a.c;
		Fp2& z3 = z.b.a;
		Fp2& z4 = z.b.b;
		Fp2& z5 = z.b.c;
		Fp2Dbl Z0B, Z1B, Z2B, Z3C, Z4C, Z5C;
		Fp2Dbl T0, T1, T2, T3, T4, T5;
		Fp2 bc, t;
		Fp2::addPre(bc, b, c);
		Fp2::addPre(t, z5, z2);
		Fp2Dbl::mulPre(T5, t, bc);
		Fp2Dbl::mulPre(Z5C, z5, c);
		Fp2Dbl::mulPre(Z2B, z2, b);
		Fp2Dbl::sub(T5, T5, Z5C);
		Fp2Dbl::sub(T5, T5, Z2B);
		Fp2Dbl::mulPre(T0, z1, a);
		T5 += T0;

		Fp2::addPre(t, z4, z1);
		Fp2Dbl::mulPre(T4, t, bc);
		Fp2Dbl::mulPre(Z4C, z4, c);
		Fp2Dbl::mulPre(Z1B, z1, b);
		Fp2Dbl::sub(T4, T4, Z4C);
		Fp2Dbl::sub(T4, T4, Z1B);
		Fp2Dbl::mulPre(T0, z0, a);
		T4 += T0;

		Fp2::addPre(t, z3, z0);
		Fp2Dbl::mulPre(T3, t, bc);
		Fp2Dbl::mulPre(Z3C, z3, c);
		Fp2Dbl::mulPre(Z0B, z0, b);
		Fp2Dbl::sub(T3, T3, Z3C);
		Fp2Dbl::sub(T3, T3, Z0B);
		Fp2::mul_xi(t, z2);
		Fp2Dbl::mulPre(T0, t, a);
		T3 += T0;

		Fp2Dbl::mulPre(T2, z3, a);
		T2 += Z2B;
		T2 += Z4C;

		Fp2::mul_xi(t, z5);
		Fp2Dbl::mulPre(T1, t, a);
		T1 += Z1B;
		T1 += Z3C;

		Fp2Dbl::mulPre(T0, z4, a);
		T0 += Z5C;
		Fp2Dbl::mul_xi(T0, T0);
		T0 += Z0B;

		Fp2Dbl::mod(z0, T0);
		Fp2Dbl::mod(z1, T1);
		Fp2Dbl::mod(z2, T2);
		Fp2Dbl::mod(z3, T3);
		Fp2Dbl::mod(z4, T4);
		Fp2Dbl::mod(z5, T5);
#endif
	}
	/*
		input
		z = (z0 + z1v + z2v^2) + (z3 + z4v + z5v^2)w = Z0 + Z1w
		x = (a, b, c) -> (a, c, 0, 0, b, 0) = X0 + X1w
		X0 = (a, c, 0)
		X1 = (0, b, 0)
		w^2 = v, v^3 = xi
		output
		z <- zx = (Z0X0 + Z1X1v) + ((Z0 + Z1)(X0 + X1) - Z0X0 - Z1X1)w
		Z0X0 = Z0 (a, c, 0)
		Z1X1 = Z1 (0, b, 0) = Z1 bv
		(Z0 + Z1)(X0 + X1) = (Z0 + Z1) (a, b + c, 0)

		(a + bv + cv^2)v = c xi + av + bv^2
	*/
	static void mul_014(Fp12& z, const Fp6& x)
	{
		const Fp2& a = x.a;
		const Fp2& b = x.b;
		const Fp2& c = x.c;
		Fp6& z0 = z.a;
		Fp6& z1 = z.b;
		Fp6 z0x0, z1x1, t0;
		Fp2 t1;
		Fp2::mul(z1x1.a, z1.c, b);
		Fp2::mul_xi(z1x1.a, z1x1.a);
		Fp2::mul(z1x1.b, z1.a, b);
		Fp2::mul(z1x1.c, z1.b, b);
		Fp2::add(t1, x.b, c);
		Fp6::add(t0, z0, z1);
		Fp6mul_01(z0x0, z0, a, c);
		Fp6mul_01(t0, t0, a, t1);
		Fp6::sub(z.b, t0, z0x0);
		z.b -= z1x1;
		// a + bv + cv^2 = cxi + av + bv^2
		Fp2::mul_xi(z1x1.c, z1x1.c);
		Fp2::add(z.a.a, z0x0.a, z1x1.c);
		Fp2::add(z.a.b, z0x0.b, z1x1.a);
		Fp2::add(z.a.c, z0x0.c, z1x1.b);
	}
	/*
		input
		z = (z0 + z1v + z2v^2) + (z3 + z4v + z5v^2)w
		x = (a, b, c) -> (a, 0, c, 0, b, 0)
		output
		z <- zx = (z0a + (z1c + z4b)xi) + (z1a + (z2c + z5b)xi)v + (z0c + z2a + z3b)v^2
		+ (z3a + (z2b + z4c)xi)w + (z0b + z4a + z5cxi)vw + (z1b + z3c + z5a)v^2w

		z1c + z4b = (z1 + z4)(c + b) - z1b - z4c
		z2c + z5b = (z2 + z5)(c + b) - z2b - z5c
		z0c + z3b = (z0 + z3)(c + b) - z0b - z3c
	*/
	static void mul_024(Fp12& z, const Fp6& x)
	{
#ifdef MCL_USE_BLS12
		mul_014(z, x);
		return;
#endif
		mul_025(z, x);
	}
	static void mul_024_024(Fp12& z, const Fp6& x, const Fp6& y)
	{
		util::convertFp6toFp12(z, x);
		mul_024(z, y);
	}
#if 0
	/*
		y = x^d
		d = (p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
	*/
	static void exp_d(Fp12& y, const Fp12& x)
	{
#if 1
		Fp12 t1, t2, t3;
		Fp12::Frobenius(t1, x);
		Fp12::Frobenius(t2, t1);
		Fp12::Frobenius(t3, t2);
		Fp12::pow(t1, t1, param.exp_c1);
		Fp12::pow(t2, t2, param.exp_c2);
		Fp12::pow(y, x, param.exp_c0);
		y *= t1;
		y *= t2;
		y *= t3;
#else
		const mpz_class& p = param.p;
		mpz_class p2 = p * p;
		mpz_class p4 = p2 * p2;
		Fp12::pow(y, x, (p4 - p2 + 1) / param.r);
#endif
	}
#endif
	/*
		Faster Squaring in the Cyclotomic Subgroup of Sixth Degree Extensions
		Robert Granger, Michael Scott
	*/
	static void sqrFp4(Fp2& z0, Fp2& z1, const Fp2& x0, const Fp2& x1)
	{
#if 1
		Fp2Dbl T0, T1, T2;
		Fp2Dbl::sqrPre(T0, x0);
		Fp2Dbl::sqrPre(T1, x1);
		Fp2Dbl::mul_xi(T2, T1);
		Fp2Dbl::add(T2, T2, T0);
		Fp2::add(z1, x0, x1);
		Fp2Dbl::mod(z0, T2);
		Fp2Dbl::sqrPre(T2, z1);
		Fp2Dbl::sub(T2, T2, T0);
		Fp2Dbl::sub(T2, T2, T1);
		Fp2Dbl::mod(z1, T2);
#else
		Fp2 t0, t1, t2;
		Fp2::sqr(t0, x0);
		Fp2::sqr(t1, x1);
		Fp2::mul_xi(z0, t1);
		z0 += t0;
		Fp2::add(z1, x0, x1);
		Fp2::sqr(z1, z1);
		z1 -= t0;
		z1 -= t1;
#endif
	}
	static void fasterSqr(Fp12& y, const Fp12& x)
	{
#if 0
		Fp12::sqr(y, x);
#else
		const Fp2& x0(x.a.a);
		const Fp2& x4(x.a.b);
		const Fp2& x3(x.a.c);
		const Fp2& x2(x.b.a);
		const Fp2& x1(x.b.b);
		const Fp2& x5(x.b.c);
		Fp2& y0(y.a.a);
		Fp2& y4(y.a.b);
		Fp2& y3(y.a.c);
		Fp2& y2(y.b.a);
		Fp2& y1(y.b.b);
		Fp2& y5(y.b.c);
		Fp2 t0, t1;
		sqrFp4(t0, t1, x0, x1);
		Fp2::sub(y0, t0, x0);
		y0 += y0;
		y0 += t0;
		Fp2::add(y1, t1, x1);
		y1 += y1;
		y1 += t1;
		Fp2 t2, t3;
		sqrFp4(t0, t1, x2, x3);
		sqrFp4(t2, t3, x4, x5);
		Fp2::sub(y4, t0, x4);
		y4 += y4;
		y4 += t0;
		Fp2::add(y5, t1, x5);
		y5 += y5;
		y5 += t1;
		Fp2::mul_xi(t0, t3);
		Fp2::add(y2, t0, x2);
		y2 += y2;
		y2 += t0;
		Fp2::sub(y3, t2, x3);
		y3 += y3;
		y3 += t2;
#endif
	}
	/*
		Faster Hashing to G2
		Laura Fuentes-Castaneda, Edward Knapp, Francisco Rodriguez-Henriquez
		section 4.1
		y = x^(d 2z(6z^2 + 3z + 1)) where
		p = p(z) = 36z^4 + 36z^3 + 24z^2 + 6z + 1
		r = r(z) = 36z^4 + 36z^3 + 18z^2 + 6z + 1
		d = (p^4 - p^2 + 1) / r
		d1 = d 2z(6z^2 + 3z + 1)
		= c0 + c1 p + c2 p^2 + c3 p^3

		c0 = 1 + 6z + 12z^2 + 12z^3
		c1 = 4z + 6z^2 + 12z^3
		c2 = 6z + 6z^2 + 12z^3
		c3 = -1 + 4z + 6z^2 + 12z^3
		x -> x^z -> x^2z -> x^4z -> x^6z -> x^(6z^2) -> x^(12z^2) -> x^(12z^3)
		a = x^(6z) x^(6z^2) x^(12z^3)
		b = a / (x^2z)
		x^d1 = (a x^(6z^2) x) b^p a^(p^2) (b / x)^(p^3)
	*/
	static void exp_d1(Fp12& y, const Fp12& x)
	{
		Fp12 a, b;
		Fp12 a2, a3;
		pow_z(b, x); // x^z
		fasterSqr(b, b); // x^2z
		fasterSqr(a, b); // x^4z
		a *= b; // x^6z
		pow_z(a2, a); // x^(6z^2)
		a *= a2;
		fasterSqr(a3, a2); // x^(12z^2)
		pow_z(a3, a3); // x^(12z^3)
		a *= a3;
		Fp12::unitaryInv(b, b);
		b *= a;
		a2 *= a;
		Fp12::Frobenius2(a, a);
		a *= a2;
		a *= x;
		Fp12::unitaryInv(y, x);
		y *= b;
		Fp12::Frobenius(b, b);
		a *= b;
		Fp12::Frobenius3(y, y);
		y *= a;
	}
	static void mapToCyclotomic(Fp12& y, const Fp12& x)
	{
		Fp12 z;
		Fp12::Frobenius2(z, x); // z = x^(p^2)
		z *= x; // x^(p^2 + 1)
		Fp12::inv(y, z);
		Fp6::neg(z.b, z.b); // z^(p^6) = conjugate of z
		y *= z;
	}
	/*
		y = x^((p^12 - 1) / r)
		(p^12 - 1) / r = (p^2 + 1) (p^6 - 1) (p^4 - p^2 + 1)/r
		(a + bw)^(p^6) = a - bw in Fp12
		(p^4 - p^2 + 1)/r = c0 + c1 p + c2 p^2 + p^3
	*/
	static void finalExp(Fp12& y, const Fp12& x)
	{
#if 1
		mapToCyclotomic(y, x);
#else
		const mpz_class& p = param.p;
		mpz_class p2 = p * p;
		mpz_class p4 = p2 * p2;
		Fp12::pow(y, x, p2 + 1);
		Fp12::pow(y, y, p4 * p2 - 1);
#endif
#ifdef MCL_USE_BLS12
		exp_d(y, y);
#else
		exp_d1(y, y);
#endif
	}
	/*
		remark : returned value is NOT on a curve
	*/
	static G1 makeAdjP(const G1& P)
	{
		G1 adjP;
		Fp::add(adjP.x, P.x, P.x);
		adjP.x += P.x;
		Fp::neg(adjP.y, P.y);
		adjP.z = 1;
		return adjP;
	}
	static void millerLoop(Fp12& f, const G1& P_, const G2& Q_)
	{
		G1 P(P_);
		G2 Q(Q_);
		P.normalize();
		Q.normalize();
		if (Q.isZero()) {
			f = 1;
			return;
		}
		assert(param.siTbl[1] == 1);
		G2 T = Q;
		G2 negQ;
		if (param.useNAF) {
			G2::neg(negQ, Q);
		}
		Fp6 d, e, l;
		d = e = l = 1;
		G1 adjP = makeAdjP(P);
		dblLine(d, T, adjP);
		addLine(l, T, Q, P);
		mul_024_024(f, d, l);
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			dblLine(l, T, adjP);
			Fp12::sqr(f, f);
			mul_024(f, l);
			if (param.siTbl[i]) {
				if (param.siTbl[i] > 0) {
					addLine(l, T, Q, P);
				} else {
					addLine(l, T, negQ, P);
				}
				mul_024(f, l);
			}
		}
		if (param.z < 0) {
			G2::neg(T, T);
			Fp6::neg(f.b, f.b);
		}
#ifndef MCL_USE_BLS12
		G2 Q1, Q2;
		G2withF::Frobenius(Q1, Q);
		G2withF::Frobenius(Q2, Q1);
		G2::neg(Q2, Q2);
		addLine(d, T, Q1, P);
		addLine(e, T, Q2, P);
		Fp12 ft;
		mul_024_024(ft, d, e);
		f *= ft;
#endif
	}
	static void pairing(Fp12& f, const G1& P, const G2& Q)
	{
		millerLoop(f, P, Q);
		finalExp(f, f);
	}
	/*
		millerLoop(e, P, Q) is same as the following
		std::vector<Fp6> Qcoeff;
		precomputeG2(Qcoeff, Q);
		precomputedMillerLoop(e, P, Qcoeff);
	*/
	static void precomputeG2(std::vector<Fp6>& Qcoeff, const G2& Q)
	{
		Qcoeff.resize(param.precomputedQcoeffSize);
		precomputeG2(Qcoeff.data(), Q);
	}
	/*
		allocate param.precomputedQcoeffSize elements of Fp6 for Qcoeff
	*/
	static void precomputeG2(Fp6 *Qcoeff, const G2& Q_)
	{
		size_t idx = 0;
		G2 Q(Q_);
		Q.normalize();
		if (Q.isZero()) {
			for (size_t i = 0; i < param.precomputedQcoeffSize; i++) {
				Qcoeff[i] = 1;
			}
			return;
		}
		G2 T = Q;
		G2 negQ;
		if (param.useNAF) {
			G2::neg(negQ, Q);
		}
		assert(param.siTbl[1] == 1);
		dblLineWithoutP(Qcoeff[idx++], T);
		addLineWithoutP(Qcoeff[idx++], T, Q);
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			dblLineWithoutP(Qcoeff[idx++], T);
			if (param.siTbl[i]) {
				if (param.siTbl[i] > 0) {
					addLineWithoutP(Qcoeff[idx++], T, Q);
				} else {
					addLineWithoutP(Qcoeff[idx++], T, negQ);
				}
			}
		}
		if (param.z < 0) {
			G2::neg(T, T);
		}
#ifndef MCL_USE_BLS12
		G2 Q1, Q2;
		G2withF::Frobenius(Q1, Q);
		G2withF::Frobenius(Q2, Q1);
		G2::neg(Q2, Q2);
		addLineWithoutP(Qcoeff[idx++], T, Q1);
		addLineWithoutP(Qcoeff[idx++], T, Q2);
		assert(idx == param.precomputedQcoeffSize);
#endif
	}
	static void precomputedMillerLoop(Fp12& f, const G1& P, const std::vector<Fp6>& Qcoeff)
	{
		precomputedMillerLoop(f, P, Qcoeff.data());
	}
	static void precomputedMillerLoop(Fp12& f, const G1& P_, const Fp6* Qcoeff)
	{
		G1 P(P_);
		P.normalize();
		G1 adjP = makeAdjP(P);
		size_t idx = 0;
		Fp6 d, e, l;
		mulFp6cb_by_G1xy(d, Qcoeff[idx], adjP);
		idx++;

		mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
		idx++;
		mul_024_024(f, d, e);
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			mulFp6cb_by_G1xy(l, Qcoeff[idx], adjP);
			idx++;
			Fp12::sqr(f, f);
			mul_024(f, l);
			if (param.siTbl[i]) {
				mulFp6cb_by_G1xy(l, Qcoeff[idx], P);
				idx++;
				mul_024(f, l);
			}
		}
		if (param.z < 0) {
			Fp6::neg(f.b, f.b);
		}
#ifndef MCL_USE_BLS12
		mulFp6cb_by_G1xy(d, Qcoeff[idx], P);
		idx++;
		mulFp6cb_by_G1xy(e, Qcoeff[idx], P);
		idx++;
		Fp12 ft;
		mul_024_024(ft, d, e);
		f *= ft;
#endif
	}
	/*
		f = MillerLoop(P1, Q1) x MillerLoop(P2, Q2)
	*/
	static void precomputedMillerLoop2(Fp12& f, const G1& P1, const std::vector<Fp6>& Q1coeff, const G1& P2, const std::vector<Fp6>& Q2coeff)
	{
		precomputedMillerLoop2(f, P1, Q1coeff.data(), P2, Q2coeff.data());
	}
	static void precomputedMillerLoop2(Fp12& f, const G1& P1_, const Fp6* Q1coeff, const G1& P2_, const Fp6* Q2coeff)
	{
		G1 P1(P1_), P2(P2_);
		P1.normalize();
		P2.normalize();
		G1 adjP1 = makeAdjP(P1);
		G1 adjP2 = makeAdjP(P2);
		size_t idx = 0;
		Fp6 d1, d2, e1, e2, l1, l2;
		mulFp6cb_by_G1xy(d1, Q1coeff[idx], adjP1);
		mulFp6cb_by_G1xy(d2, Q2coeff[idx], adjP2);
		idx++;

		Fp12 f1, f2;
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
		mul_024_024(f1, d1, e1);

		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		mul_024_024(f2, d2, e2);
		Fp12::mul(f, f1, f2);
		idx++;
		for (size_t i = 2; i < param.siTbl.size(); i++) {
			mulFp6cb_by_G1xy(l1, Q1coeff[idx], adjP1);
			mulFp6cb_by_G1xy(l2, Q2coeff[idx], adjP2);
			idx++;
			Fp12::sqr(f, f);
			mul_024_024(f1, l1, l2);
			f *= f1;
			if (param.siTbl[i]) {
				mulFp6cb_by_G1xy(l1, Q1coeff[idx], P1);
				mulFp6cb_by_G1xy(l2, Q2coeff[idx], P2);
				idx++;
				mul_024_024(f1, l1, l2);
				f *= f1;
			}
		}
		if (param.z < 0) {
			Fp6::neg(f.b, f.b);
		}
#ifndef MCL_USE_BLS12
		mulFp6cb_by_G1xy(d1, Q1coeff[idx], P1);
		mulFp6cb_by_G1xy(d2, Q2coeff[idx], P2);
		idx++;
		mulFp6cb_by_G1xy(e1, Q1coeff[idx], P1);
		mulFp6cb_by_G1xy(e2, Q2coeff[idx], P2);
		idx++;
		mul_024_024(f1, d1, e1);
		mul_024_024(f2, d2, e2);
		f *= f1;
		f *= f2;
#endif
	}
