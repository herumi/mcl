#pragma once

/*
	Software implementation of Attribute-Based Encryption: Appendixes
	GLV for G1 on BN/BLS12
*/
struct GLV1 : mcl::GLV1T<G1> {
	static bool usePrecomputedTable(int curveType)
	{
		if (curveType < 0) return false;
		const struct Tbl {
			int curveType;
			const char *rw;
			size_t rBitSize;
			const char *v0, *v1;
			const char *B[2][2];
		} tbl[] = {
			{
				MCL_BN254,
				"49b36240000000024909000000000006cd80000000000007",
				256,
				"2a01fab7e04a017b9c0eb31ff36bf3357",
				"37937ca688a6b4904",
				{
					{
						"61818000000000028500000000000004",
						"8100000000000001",
					},
					{
						"8100000000000001",
						"-61818000000000020400000000000003",
					},
				},
			},
		};
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			if (tbl[i].curveType != curveType) continue;
			bool b;
			rw.setStr(&b, tbl[i].rw, 16); if (!b) continue;
			rBitSize = tbl[i].rBitSize;
			gmp::setStr(&b, v0, tbl[i].v0, 16); if (!b) continue;
			gmp::setStr(&b, v1, tbl[i].v1, 16); if (!b) continue;
			gmp::setStr(&b, B[0][0], tbl[i].B[0][0], 16); if (!b) continue;
			gmp::setStr(&b, B[0][1], tbl[i].B[0][1], 16); if (!b) continue;
			gmp::setStr(&b, B[1][0], tbl[i].B[1][0], 16); if (!b) continue;
			gmp::setStr(&b, B[1][1], tbl[i].B[1][1], 16); if (!b) continue;
			return true;
		}
		return false;
	}
	static void init(const mpz_class& z, bool isBLS12, int curveType)
	{
		optimizedSplit = 0;
		if (usePrecomputedTable(curveType)) return;
		bool b = Fp::squareRoot(rw, -3);
		assert(b);
		(void)b;
		rw = -(rw + 1) / 2;
		rBitSize = Fr::getOp().bitSize;
		if (isBLS12) {
			/*
				BLS12
				L = z^4
				(-z^2+1) + L = 0
				1 + z^2 L = 0
			*/
			// only B[0][0] and v0 are used
			const mpz_class& r = Fr::getOp().mp;
			B[0][0] = z * z - 1; // L
			v0 = (B[0][0] << rBitSize) / r;
			if (curveType == BLS12_381.curveType) {
				optimizedSplit = optimizedSplitForBLS12_381;
			} else
#if 1
			if (curveType == BLS12_377.curveType) {
				optimizedSplit = optimizedSplitForBLS12_377;
			} else
#endif
			{
				optimizedSplit = splitForBLS12;
			}
		} else {
			/*
				BN
				L = 36z^4 - 1
				(6z^2+2z) - (2z+1)   L = 0
				(-2z-1) - (6z^2+4z+1)L = 0
			*/
			B[0][0] = 6 * z * z + 2 * z;
			B[0][1] = -2 * z - 1;
			B[1][0] = -2 * z - 1;
			B[1][1] = -6 * z * z - 4 * z - 1;
			// [v0 v1] = [r 0] * B^(-1)
			const mpz_class& r = Fr::getOp().mp;
			v0 = ((-B[1][1]) << rBitSize) / r;
			v1 = ((B[1][0]) << rBitSize) / r;
		}
	}
	// x = (a + b L) mod r
	static inline void splitForBLS12(mpz_class u[2], const mpz_class& x)
	{
		mpz_class& a = u[0];
		mpz_class& b = u[1];
		mpz_class t;
		b = (x * v0) >> rBitSize;
		a = x - b * B[0][0];
	}
	static inline void optimizedSplitForBLS12_381(mpz_class u[2], const mpz_class& x)
	{
		static const size_t n = 128 / mcl::UnitBitSize;
		Unit xa[n*2], a[n], b[n];
		bool dummy;
		mcl::gmp::getArray(&dummy, xa, n*2, x);
		assert(dummy);
		ec::local::optimizedSplitRawForBLS12_381(a, b, xa);
		gmp::setArray(&dummy, u[0], a, n);
		gmp::setArray(&dummy, u[1], b, n);
		assert(dummy);
		(void)dummy;
	}
	static inline void optimizedSplitForBLS12_377(mpz_class u[2], const mpz_class& x)
	{
		static const size_t n = 128 / mcl::UnitBitSize;
		Unit xa[n*2], a[n], b[n];
		bool dummy;
		mcl::gmp::getArray(&dummy, xa, n*2, x);
		assert(dummy);
		ec::local::optimizedSplitRawForBLS12_377(a, b, xa);
		gmp::setArray(&dummy, u[0], a, n);
		gmp::setArray(&dummy, u[1], b, n);
		assert(dummy);
		(void)dummy;
	}
};

/*
	GLV method for G2 and GT on BN/BLS12
*/
struct GLV2 {
	static const int splitN = 4;
	static size_t rBitSize;
	static mpz_class B[4][4];
	static mpz_class v[4];
	static mpz_class z;
	static mpz_class abs_z;
	static bool isBLS12;
	static void init(const mpz_class& z, bool isBLS12 = false)
	{
		const mpz_class& r = Fr::getOp().mp;
		GLV2::z = z;
		GLV2::abs_z = z < 0 ? -z : z;
		GLV2::isBLS12 = isBLS12;
		rBitSize = Fr::getOp().bitSize;
		rBitSize = (rBitSize + mcl::UnitBitSize - 1) & ~(mcl::UnitBitSize - 1);// a little better size
		mpz_class z2p1 = z * 2 + 1;
		B[0][0] = z + 1;
		B[0][1] = z;
		B[0][2] = z;
		B[0][3] = -2 * z;
		B[1][0] = z2p1;
		B[1][1] = -z;
		B[1][2] = -(z + 1);
		B[1][3] = -z;
		B[2][0] = 2 * z;
		B[2][1] = z2p1;
		B[2][2] = z2p1;
		B[2][3] = z2p1;
		B[3][0] = z - 1;
		B[3][1] = 2 * z2p1;
		B[3][2] =  -2 * z + 1;
		B[3][3] = z - 1;
		/*
			v[] = [r 0 0 0] * B^(-1) = [2z^2+3z+1, 12z^3+8z^2+z, 6z^3+4z^2+z, -(2z+1)]
		*/
		const char *zBN254 = "-4080000000000001";
		mpz_class t;
		bool b;
		mcl::gmp::setStr(&b, t, zBN254, 16);
		assert(b);
		(void)b;
		if (z == t) {
			static const char *vTblBN254[] = {
				"e00a8e7f56e007e5b09fe7fdf43ba998",
				"-152aff56a8054abf9da75db2da3d6885101e5fd3997d41cb1",
				"-a957fab5402a55fced3aed96d1eb44295f40f136ee84e09b",
				"-e00a8e7f56e007e929d7b2667ea6f29c",
			};
			for (int i = 0; i < 4; i++) {
				mcl::gmp::setStr(&b, v[i], vTblBN254[i], 16);
				assert(b);
				(void)b;
			}
		} else {
			v[0] = ((1 + z * (3 + z * 2)) << rBitSize) / r;
			v[1] = ((z * (1 + z * (8 + z * 12))) << rBitSize) / r;
			v[2] = ((z * (1 + z * (4 + z * 6))) << rBitSize) / r;
			v[3] = -((z * (1 + z * 2)) << rBitSize) / r;
		}
	}
	/*
		u[] = [x, 0, 0, 0] - v[] * x * B
	*/
	static void split(mpz_class u[4], mpz_class& x)
	{
		Fr::getOp().modp.modp(x, x);
		if (isBLS12) {
			/*
				Frob(P) = zP
				x = u[0] + u[1] z + u[2] z^2 + u[3] z^3
			*/
			bool isNeg = false;
			mpz_class t = x;
			if (t < 0) {
				t = -t;
				isNeg = true;
			}
			for (int i = 0; i < 4; i++) {
				// t = t / abs_z, u[i] = t % abs_z
				mcl::gmp::divmod(t, u[i], t, abs_z);
				if (((z < 0) && (i & 1)) ^ isNeg) {
					u[i] = -u[i];
				}
			}
			return;
		}
		// BN
		mpz_class t[4];
		for (int i = 0; i < 4; i++) {
			t[i] = (x * v[i]) >> rBitSize;
		}
		for (int i = 0; i < 4; i++) {
			u[i] = (i == 0) ? x : 0;
			for (int j = 0; j < 4; j++) {
				u[i] -= t[j] * B[j][i];
			}
		}
	}
	template<class T>
	static void mulLambda(T& Q, const T& P)
	{
		Frobenius(Q, P);
	}
};

size_t GLV2::rBitSize = 0;
mpz_class GLV2::B[4][4];
mpz_class GLV2::v[4];
mpz_class GLV2::z;
mpz_class GLV2::abs_z;
bool GLV2::isBLS12 = false;

