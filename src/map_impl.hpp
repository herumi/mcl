#pragma once


namespace mcl {

struct MapTo {
	enum {
		BNtype,
		BLS12type,
		STD_ECtype
	};
	Fp c1_; // sqrt(-3)
	Fp c2_; // (-1 + sqrt(-3)) / 2
	mpz_class z_;
	mpz_class z2_;
	mpz_class cofactor_;
	int type_;
	int curveType_;
	int mapToMode_;
	MapTo_WB19 mapTo_WB19_;
	MapTo()
		: type_(0)
		, curveType_(0)
		, mapToMode_(MCL_MAP_TO_MODE_ORIGINAL)
	{
	}

	int legendre(bool *pb, const Fp& x) const
	{
		mpz_class xx;
		x.getMpz(pb, xx);
		if (!*pb) return 0;
		return gmp::legendre(xx, Fp::getOp().mp);
	}
	int legendre(bool *pb, const Fp2& x) const
	{
		Fp y;
		Fp2::norm(y, x);
		return legendre(pb, y);
	}
	void mulFp(Fp& x, const Fp& y) const
	{
		x *= y;
	}
	void mulFp(Fp2& x, const Fp& y) const
	{
		x.a *= y;
		x.b *= y;
	}
	/*
		P.-A. Fouque and M. Tibouchi,
		"Indifferentiable hashing to Barreto Naehrig curves,"
		in Proc. Int. Conf. Cryptol. Inform. Security Latin Amer., 2012, vol. 7533, pp.1-17.

		w = sqrt(-3) t / (1 + b + t^2)
		Remark: throw exception if t = 0, c1, -c1 and b = 2
	*/
	template<class G, class F>
	bool calcBN(G& P, const F& t) const
	{
		F x, y, w;
		bool b;
		bool negative = legendre(&b, t) < 0;
		if (!b) return false;
		if (t.isZero()) return false;
		F::sqr(w, t);
		w += G::b_;
		*w.getFp0() += Fp::one();
		if (w.isZero()) return false;
		F::inv(w, w);
		mulFp(w, c1_);
		w *= t;
		for (int i = 0; i < 3; i++) {
			switch (i) {
			case 0: F::mul(x, t, w); F::neg(x, x); *x.getFp0() += c2_; break;
			case 1: F::neg(x, x); *x.getFp0() -= Fp::one(); break;
			case 2: F::sqr(x, w); F::inv(x, x); *x.getFp0() += Fp::one(); break;
			}
			G::getWeierstrass(y, x);
			if (F::squareRoot(y, y)) {
				if (negative) F::neg(y, y);
				P.set(&b, x, y, false);
				assert(b);
				return true;
			}
		}
		return false;
	}
	/*
		Faster Hashing to G2
		Laura Fuentes-Castaneda, Edward Knapp, Francisco Rodriguez-Henriquez
		section 6.1
		for BN
		Q = zP + Frob(3zP) + Frob^2(zP) + Frob^3(P)
		  = -(18x^3 + 12x^2 + 3x + 1)cofactor_ P
	*/
	void mulByCofactorBN(G2& Q, const G2& P) const
	{
		G2 T0, T1, T2;
		/*
			G2::mul (GLV method) can't be used because P is not on G2
		*/
		G2::mulGeneric(T0, P, z_);
		G2::dbl(T1, T0);
		T1 += T0; // 3zP
		Frobenius(T1, T1);
		Frobenius2(T2, T0);
		T0 += T1;
		T0 += T2;
		Frobenius3(T2, P);
		G2::add(Q, T0, T2);
	}
	/*
		#(Fp) / r = (z + 1 - t) / r = (z - 1)^2 / 3
	*/
	void mulByCofactorBLS12(G1& Q, const G1& P) const
	{
		G1::mulGeneric(Q, P, cofactor_);
	}
	/*
		Efficient hash maps to G2 on BLS curves
		Alessandro Budroni, Federico Pintore
		Q = (z(z-1)-1)P + Frob((z-1)P) + Frob^2(2P)
	*/
	void mulByCofactorBLS12fast(G2& Q, const G2& P) const
	{
		G2 T0, T1;
		G2::mulGeneric(T0, P, z_ - 1);
		G2::mulGeneric(T1, T0, z_);
		T1 -= P;
		Frobenius(T0, T0);
		T0 += T1;
		G2::dbl(T1, P);
		Frobenius2(T1, T1);
		G2::add(Q, T0, T1);
	}
	void mulByCofactorBLS12(G2& Q, const G2& P) const
	{
		mulByCofactorBLS12fast(Q, P);
	}
	/*
		cofactor_ is for G2(not used now)
	*/
	void initBN(const mpz_class& cofactor, const mpz_class &z, int curveType)
	{
		z_ = z;
		cofactor_ = cofactor;
		if (curveType == MCL_BN254) {
			const char *c1 = "252364824000000126cd890000000003cf0f0000000000060c00000000000004";
			const char *c2 = "25236482400000017080eb4000000006181800000000000cd98000000000000b";
			bool b;
			c1_.setStr(&b, c1, 16);
			c2_.setStr(&b, c2, 16);
			(void)b;
			return;
		}
		bool b = Fp::squareRoot(c1_, -3);
		assert(b);
		(void)b;
		c2_ = (c1_ - 1) / 2;
	}
	void initBLS12(const mpz_class& z, int curveType)
	{
		z_ = z;
		if (curveType == MCL_BLS12_381) {
			const char *z2 = "396c8c005555e1560000000055555555";
			const char *cofactor = "396c8c005555e1568c00aaab0000aaab";
			const char *c1 = "be32ce5fbeed9ca374d38c0ed41eefd5bb675277cdf12d11bc2fb026c41400045c03fffffffdfffd";
			const char *c2 = "5f19672fdf76ce51ba69c6076a0f77eaddb3a93be6f89688de17d813620a00022e01fffffffefffe";
			bool b;
			gmp::setStr(&b, z2_, z2, 16); assert(b); (void)b;
			gmp::setStr(&b, cofactor_, cofactor, 16); assert(b); (void)b;
			c1_.setStr(&b, c1, 16); assert(b); (void)b;
			c2_.setStr(&b, c2, 16); assert(b); (void)b;
			mapTo_WB19_.init();
			return;
		}
		z2_ = (z_ * z_ - 1) / 3;
		// cofactor for G1
		cofactor_ = (z - 1) * (z - 1) / 3;
		bool b = Fp::squareRoot(c1_, -3);
		assert(b);
		(void)b;
		c2_ = (c1_ - 1) / 2;
	}
	/*
		change mapTo function to mode
	*/
	bool setMapToMode(int mode)
	{
		if (type_ == STD_ECtype) {
			// force
			mapToMode_ = MCL_MAP_TO_MODE_TRY_AND_INC;
			return true;
		}
		switch (mode) {
		case MCL_MAP_TO_MODE_ORIGINAL:
			mapToMode_ = mode;
			return true;
		case MCL_MAP_TO_MODE_TRY_AND_INC:
			mapToMode_ = mode;
			return true;
		case MCL_MAP_TO_MODE_HASH_TO_CURVE_07:
			if (curveType_ != MCL_BLS12_381) return false;
			mapToMode_ = mode;
			return true;
		default:
			return false;
		}
	}
	/*
		if type == STD_ECtype, then cofactor, z are not used.
	*/
	void init(const mpz_class& cofactor, const mpz_class &z, int curveType)
	{
		curveType_ = curveType;
		if (0 <= curveType && curveType < MCL_EC_BEGIN) {
			type_ = (curveType == MCL_BLS12_381 || curveType == MCL_BLS12_377 || curveType == MCL_BLS12_461) ? BLS12type : BNtype;
		} else {
			type_ = STD_ECtype;
		}
		setMapToMode(MCL_MAP_TO_MODE_ORIGINAL);
		if (type_ == BNtype) {
			initBN(cofactor, z, curveType);
		} else if (type_ == BLS12type) {
			initBLS12(z, curveType);
		}
	}
	template<class G, class F>
	bool mapToEc(G& P, const F& t) const
	{
		if (mapToMode_ == MCL_MAP_TO_MODE_TRY_AND_INC) {
			ec::tryAndIncMapTo<G>(P, t);
		} else {
			if (!calcBN<G, F>(P, t)) return false;
		}
		return true;
	}
	void mulByCofactor(G1& P) const
	{
		switch (type_) {
		case BNtype:
			// no subgroup
			break;
		case BLS12type:
			mulByCofactorBLS12(P, P);
			break;
		}
		assert(P.isValid());
	}
	void mulByCofactor(G2& P) const
	{
		switch(type_) {
		case BNtype:
			mulByCofactorBN(P, P);
			break;
		case BLS12type:
			mulByCofactorBLS12(P, P);
			break;
		}
		assert(P.isValid());
	}
	bool calc(G1& P, const Fp& t) const
	{
		if (mapToMode_ == MCL_MAP_TO_MODE_HASH_TO_CURVE_07) {
			mapTo_WB19_.FpToG1(P, t);
			return true;
		}
		if (!mapToEc(P, t)) return false;
		mulByCofactor(P);
		return true;
	}
	bool calc(G2& P, const Fp2& t) const
	{
		if (mapToMode_ == MCL_MAP_TO_MODE_HASH_TO_CURVE_07) {
			mapTo_WB19_.Fp2ToG2(P, t);
			return true;
		}
		if (!mapToEc(P, t)) return false;
		mulByCofactor(P);
		return true;
	}
};

static MapTo mapTo;

void mapTo_WB19_init()
{
	mapTo.mapTo_WB19_.init();
}

void mapTo_WB19_FpToG1(G1& out, const Fp& u0, const Fp *u1 = 0)
{
	mapTo.mapTo_WB19_.FpToG1(out, u0, u1);
}

void mapTo_WB19_Fp2ToG2(G2& P, const Fp2& t, const Fp2 *t2 = 0){
	mapTo.mapTo_WB19_.Fp2ToG2(P, t, t2);
}

void mapToInit(const mpz_class& cofactor, const mpz_class &z, int curveType)
{
	mapTo.init(cofactor, z, curveType);
}

bool setMapToMode(int mode)
{
	return mapTo.setMapToMode(mode);
}

int getMapToMode()
{
	return mapTo.mapToMode_;
}

void mapToG1(bool *pb, G1& P, const Fp& x) { *pb = mapTo.calc(P, x); }
void mapToG2(bool *pb, G2& P, const Fp2& x) { *pb = mapTo.calc(P, x); }

#ifndef CYBOZU_DONT_USE_EXCEPTION
void mapToG1(G1& P, const Fp& x)
{
	bool b;
	mapToG1(&b, P, x);
	if (!b) throw cybozu::Exception("mapToG1:bad value") << x;
}
void mapToG2(G2& P, const Fp2& x)
{
	bool b;
	mapToG2(&b, P, x);
	if (!b) throw cybozu::Exception("mapToG2:bad value") << x;
}
#endif
void hashAndMapToG1(G1& P, const void *buf, size_t bufSize)
{
	int mode = getMapToMode();
	if (mode == MCL_MAP_TO_MODE_HASH_TO_CURVE_07) {
		mapTo.mapTo_WB19_.msgToG1(P, buf, bufSize);
		return;
	}
	Fp t;
	t.setHashOf(buf, bufSize);
	bool b;
	mapToG1(&b, P, t);
	// It will not happen that the hashed value is equal to special value
	assert(b);
	(void)b;
}
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize)
{
	int mode = getMapToMode();
	if (mode == MCL_MAP_TO_MODE_WB19 || mode >= MCL_MAP_TO_MODE_HASH_TO_CURVE_06) {
		mapTo.mapTo_WB19_.msgToG2(P, buf, bufSize);
		return;
	}
	Fp2 t;
	t.a.setHashOf(buf, bufSize);
	t.b.clear();
	bool b;
	mapToG2(&b, P, t);
	// It will not happen that the hashed value is equal to special value
	assert(b);
	(void)b;
}
void hashAndMapToG1(G1& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize)
{
	mapTo.mapTo_WB19_.msgToG1(P, buf, bufSize, dst, dstSize);
}
void hashAndMapToG2(G2& P, const void *buf, size_t bufSize, const char *dst, size_t dstSize)
{
	mapTo.mapTo_WB19_.msgToG2(P, buf, bufSize, dst, dstSize);
}
// set the default dst for G1
// return 0 if success else -1
bool setDstG1(const char *dst, size_t dstSize)
{
	return mapTo.mapTo_WB19_.dstG1.set(dst, dstSize);
}
// set the default dst for G2
// return 0 if success else -1
bool setDstG2(const char *dst, size_t dstSize)
{
	return mapTo.mapTo_WB19_.dstG2.set(dst, dstSize);
}
#ifndef CYBOZU_DONT_USE_STRING
void hashAndMapToG1(G1& P, const std::string& str)
{
	hashAndMapToG1(P, str.c_str(), str.size());
}
void hashAndMapToG2(G2& P, const std::string& str)
{
	hashAndMapToG2(P, str.c_str(), str.size());
}
#endif

/*
	z2 = (z^2-1)/3, c2 = (-1 + sqrt(-3))/2
	P = (x, y), T1 = (c2 x, y), T0 = (c2^2 x, y)
	z2(2 T0 - P - T1) == T1
*/
bool isValidOrderBLS12(const G1& P)
{
	G1 T0, T1;
	T1 = P;
	T1.x *= mapTo.c2_;
	T0 = T1;
	T0.x *= mapTo.c2_;
	G1::dbl(T0, T0);
	T0 -= P;
	T0 -= T1;
	G1::mulGeneric(T0, T0, mapTo.z2_);
	return T0 == T1;
}

void mulByCofactorBLS12fast(mcl::G2& Q, const mcl::G2& P)
{
	mapTo.mulByCofactorBLS12fast(Q, P);
}

} // mcl
