#pragma once

namespace mcl {

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
	// z already has compressed values
	explicit Compress(Fp12& z)
		: z_(z)
		, g1_(z.getFp2()[4])
		, g2_(z.getFp2()[3])
		, g3_(z.getFp2()[2])
		, g4_(z.getFp2()[1])
		, g5_(z.getFp2()[5])
	{
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
		if (Fp::getOp().u == 1) {
			// the real part of sqrPre is (a+b)(a-b), which is small
			Fp2Dbl::addPre(T2, T2, T1);
		} else {
			// the real part of sqrPre is reduced by FpDbl::sub, which may be near pR
			Fp2Dbl::add(T2, T2, T1);
		}
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
	// max number of decompression in fixed_power
	static const size_t maxDecompressN = 8;
	/*
		the number of decompression in fixed_power
		= the number of nonzero digits of tbl except for the digit of 2^0
	*/
	template<class Vec>
	static size_t getDecompressNum(const Vec& tbl)
	{
		size_t n = 0;
		for (size_t i = 0; i + 1 < tbl.size(); i++) {
			if (tbl[i]) n++;
		}
		return n;
	}
	/*
		Exponentiation over compression for:
		z = x^e where tbl is the binary/NAF repl of e and tbl[0] is the top digit
		x is in the cyclotomic subgroup
		require getDecompressNum(tbl) <= maxDecompressN
	*/
	template<class Vec>
	static void fixed_power(Fp12& z, const Fp12& x, const Vec& tbl)
	{
		if (x.isOne()) {
			z = 1;
			return;
		}
		const size_t len = tbl.size();
		Fp12 d[maxDecompressN]; // d[i] = x^(2^k) for the i-th nonzero digit at k
		Fp2 nume[maxDecompressN], denomi[maxDecompressN];
		bool isNeg[maxDecompressN];
		size_t n = 0;
		const Fp12 *src = &x;
		size_t prev = 0;
		for (size_t k = 1; k < len; k++) {
			const int v = tbl[len - 1 - k];
			if (v == 0) continue;
			assert(n < maxDecompressN);
			Compress c(d[n], *src);
			square_n(c, int(k - prev));
			c.decompressBeforeInv(nume[n], denomi[n]);
			isNeg[n] = v < 0;
			src = &d[n];
			prev = k;
			n++;
		}
		const int v0 = len > 0 ? tbl[len - 1] : 0;
		if (n == 0) {
			if (v0 > 0) {
				z = x;
			} else if (v0 < 0) {
				Fp12::unitaryInv(z, x);
			} else {
				z = 1;
			}
			return;
		}
		// simultaneous inversion of denomi[]
		Fp2 acc[maxDecompressN];
		acc[0] = denomi[0];
		for (size_t i = 1; i < n; i++) {
			Fp2::mul(acc[i], acc[i - 1], denomi[i]);
		}
		Fp2 inv, t;
		Fp2::inv(inv, acc[n - 1]);
		for (size_t i = n - 1; ; i--) {
			if (i > 0) {
				Fp2::mul(t, inv, acc[i - 1]); // 1/denomi[i]
				inv *= denomi[i];
			} else {
				t = inv;
			}
			Compress c(d[i]);
			Fp2::mul(c.g1_, nume[i], t);
			c.decompressAfterInv();
			if (isNeg[i]) Fp6::neg(d[i].b, d[i].b); // unitaryInv
			if (i == 0) break;
		}
		for (size_t i = 1; i < n; i++) {
			d[0] *= d[i];
		}
		if (v0 > 0) {
			Fp12::mul(z, d[0], x);
		} else if (v0 < 0) {
			Fp12 conj;
			Fp12::unitaryInv(conj, x);
			Fp12::mul(z, d[0], conj);
		} else {
			z = d[0];
		}
	}
};

} // mcl

