/*
	included by mcl/bnXXX.hpp
*/
typedef mcl::bn::BNT<Fp> BN;
typedef BN::Fp2 Fp2;
typedef BN::Fp6 Fp6;
typedef BN::Fp12 Fp12;
typedef BN::G1 G1;
typedef BN::G2 G2;
typedef BN::Fp12 GT;

inline void initPairing(const mcl::CurveParam& cp = mcl::BN254, fp::Mode mode = fp::FP_AUTO)
{
	BN::init(cp, mode);
	G1::setCompressedExpression();
	G2::setCompressedExpression();
	Fr::init(BN::param.r);
}

inline void finalExp(Fp12& y, const Fp12& x)
{
	BN::finalExp(y, x);
}

inline void hashAndMapToG1(G1& P, const void *buf, size_t bufSize)
{
	BN::hashAndMapToG1(P, buf, bufSize);
}

inline void hashAndMapToG1(G1& P, const std::string& str)
{
	BN::hashAndMapToG1(P, str);
}

inline void hashAndMapToG2(G2& P, const void *buf, size_t bufSize)
{
	BN::hashAndMapToG2(P, buf, bufSize);
}

inline void hashAndMapToG2(G2& P, const std::string& str)
{
	BN::hashAndMapToG2(P, str);
}

inline void mapToG1(G1& P, const Fp& x)
{
	BN::mapToG1(P, x);
}

inline void mapToG2(G2& P, const Fp2& x)
{
	BN::mapToG2(P, x);
}

inline void millerLoop(Fp12& f, const G1& P, const G2& Q)
{
	BN::millerLoop(f, P, Q);
}
inline void pairing(Fp12& f, const G1& P, const G2& Q)
{
	BN::pairing(f, P, Q);
}

inline void precomputeG2(std::vector<Fp6>& Qcoeff, const G2& Q)
{
	BN::precomputeG2(Qcoeff, Q);
}

inline void precomputeG2(Fp6 *Qcoeff, const G2& Q)
{
	BN::precomputeG2(Qcoeff, Q);
}

inline void precomputedMillerLoop(Fp12& f, const G1& P, const std::vector<Fp6>& Qcoeff)
{
	BN::precomputedMillerLoop(f, P, Qcoeff);
}

inline void precomputedMillerLoop(Fp12& f, const G1& P, const Fp6* Qcoeff)
{
	BN::precomputedMillerLoop(f, P, Qcoeff);
}

inline void precomputedMillerLoop2(Fp12& f, const G1& P1, const std::vector<Fp6>& Q1coeff, const G1& P2, const std::vector<Fp6>& Q2coeff)
{
	BN::precomputedMillerLoop2(f, P1, Q1coeff, P2, Q2coeff);
}

inline void precomputedMillerLoop2(Fp12& f, const G1& P1, const Fp6* Q1coeff, const G1& P2, const Fp6* Q2coeff)
{
	BN::precomputedMillerLoop2(f, P1, Q1coeff, P2, Q2coeff);
}

inline void verifyOrderG1(bool doVerify)
{
	BN::verifyOrderG1(doVerify);
}

inline void verifyOrderG2(bool doVerify)
{
	BN::verifyOrderG2(doVerify);
}

