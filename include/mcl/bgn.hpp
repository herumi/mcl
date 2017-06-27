#pragma once
/**
	@file
	@brief BGN encryption with prime-order groups
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

	David Mandell Freeman:
	Converting Pairing-Based Cryptosystems from Composite-Order Groups to Prime-Order Groups. EUROCRYPT 2010: 44-61
	http://theory.stanford.edu/~dfreeman/papers/subgroups.pdf

	BGN encryption
	http://theory.stanford.edu/~dfreeman/cs259c-f11/lectures/bgn
*/
#include <vector>
#ifdef MCL_USE_BN384
#include <mcl/bn384.hpp>
#else
#include <mcl/bn256.hpp>
#define MCL_USE_BN256
#endif

namespace mcl { namespace bgn {

namespace local {

struct KeyCount {
	uint32_t key;
	int32_t count; // power
	bool operator<(const KeyCount& rhs) const
	{
		return key < rhs.key;
	}
};

template<class G>
class EcHashTable {
	typedef std::vector<KeyCount> KeyCountVec;
	KeyCountVec kcv;
	G P;
	G nextP;
	int hashSize;
	size_t tryNum;
public:
	EcHashTable() : hashSize(0), tryNum(0) {}
	/*
		compute log_P(xP) for |x| <= hashSize * (tryNum + 1)
	*/
	void init(const G& P, int hashSize, size_t tryNum = 0)
	{
		if (hashSize == 0) throw cybozu::Exception("EcHashTable:init:zero hashSize");
		this->P = P;
		this->hashSize = hashSize;
		this->tryNum = tryNum;
		kcv.resize(hashSize);
		G xP;
		xP.clear();
		for (int i = 1; i <= hashSize; i++) {
			xP += P;
			xP.normalize();
			kcv[i - 1].key = uint32_t(*xP.x.getUnit());
			kcv[i - 1].count = xP.y.isOdd() ? i : -i;
		}
		nextP = xP;
		G::dbl(nextP, nextP);
		nextP += P; // nextP = (hasSize * 2 + 1)P
		/*
			ascending order of abs(count) for same key
		*/
		std::stable_sort(kcv.begin(), kcv.end());
	}
	/*
		log_P(xP)
		find range which has same hash of xP in kcv,
		and detect it
	*/
	int basicLog(G xP, bool *ok = 0) const
	{
		if (ok) *ok = true;
		if (xP.isZero()) return 0;
		typedef KeyCountVec::const_iterator Iter;
		KeyCount kc;
		xP.normalize();
		kc.key = uint32_t(*xP.x.getUnit());
		kc.count = 0;
		std::pair<Iter, Iter> p = std::equal_range(kcv.begin(), kcv.end(), kc);
		G Q;
		Q.clear();
		int prev = 0;
		/*
			check range which has same hash
		*/
		while (p.first != p.second) {
			int count = p.first->count;
			int abs_c = std::abs(count);
			assert(abs_c >= prev); // assume ascending order
			bool neg = count < 0;
			G T;
			G::mul(T, P, abs_c - prev);
			Q += T;
			Q.normalize();
			if (Q.x == xP.x) {
				if (Q.y.isOdd() ^ xP.y.isOdd() ^ neg) return -count;
				return count;
			}
			prev = abs_c;
			++p.first;
		}
		if (ok) {
			*ok = false;
			return 0;
		}
		throw cybozu::Exception("HashTable:basicLog:not found");
	}
	/*
		compute log_P(xP)
		call basicLog at most 2 * tryNum + 1
	*/
	int64_t log(const G& xP) const
	{
		bool ok;
		int c = basicLog(xP, &ok);
		if (ok) {
			return c;
		}
		G posP = xP, negP = xP;
		int64_t posCenter = 0;
		int64_t negCenter = 0;
		int64_t next = hashSize * 2 + 1;
		for (size_t i = 0; i < tryNum; i++) {
			posP -= nextP;
			posCenter += next;
			c = basicLog(posP, &ok);
			if (ok) {
				return posCenter + c;
			}
			negP += nextP;
			negCenter -= next;
			c = basicLog(negP, &ok);
			if (ok) {
				return negCenter + c;
			}
		}
		throw cybozu::Exception("HashTable:log:not found");
	}
};

template<class G>
int log(const G& P, const G& xP)
{
	if (xP.isZero()) return 0;
	if (xP == P) return 1;
	G negT;
	G::neg(negT, P);
	if (xP == negT) return -1;
	G T = P;
	for (int i = 2; i < 100; i++) {
		T += P;
		if (xP == T) return i;
		G::neg(negT, T);
		if (xP == negT) return -i;
	}
	throw cybozu::Exception("BGN:log:not found");
}

} // mcl::bgn::local

template<class BN, class Fr>
struct BGNT {
	typedef typename BN::G1 G1;
	typedef typename BN::G2 G2;
	typedef typename BN::Fp12 GT;

	class SecretKey;
	class PublicKey;
	class CipherText;

	static G1 P;
	static G2 Q;

	static inline void init(const mcl::bn::CurveParam& cp = mcl::bn::CurveFp254BNb)
	{
#ifdef MCL_USE_BN256
		mcl::bn256::bn256init(cp);
#endif
#ifdef MCL_USE_BN384
		mcl::bn384::bn384init(cp);
#endif
		BN::hashAndMapToG1(P, "0");
		BN::hashAndMapToG2(Q, "0");
	}

	class SecretKey {
		Fr x1, y1, z1;
		Fr x2, y2, z2;
		G1 B1; // (x1 y1 - z1) P
		G2 B2; // (x2 y2 - z2) Q
		Fr x1x2;
		GT g; // e(B1, B2)
		local::EcHashTable<G1> hashTbl;
	public:
		template<class RG>
		void setByCSPRNG(RG& rg)
		{
			x1.setRand(rg);
			y1.setRand(rg);
			z1.setRand(rg);
			x2.setRand(rg);
			y2.setRand(rg);
			z2.setRand(rg);
			G1::mul(B1, P, x1 * y1 - z1);
			G2::mul(B2, Q, x2 * y2 - z2);
			x1x2 = x1 * x2;
			BN::pairing(g, B1, B2);
		}
		void setDecodeRange(size_t hashSize)
		{
			hashTbl.init(B1, hashSize);
		}
		/*
			set (xP, yP, zP) and (xQ, yQ, zQ)
		*/
		void getPublicKey(PublicKey& pub) const
		{
			G1::mul(pub.xP, P, x1);
			G1::mul(pub.yP, P, y1);
			G1::mul(pub.zP, P, z1);
			G2::mul(pub.xQ, Q, x2);
			G2::mul(pub.yQ, Q, y2);
			G2::mul(pub.zQ, Q, z2);
		}
		// log_x(y)
		int log(const GT& x, const GT& y) const
		{
			if (y == 1) return 0;
			if (y == x) return 1;
			GT inv;
			GT::unitaryInv(inv, x);
			if (y == inv) return -1;
			GT t = x;
			for (int i = 2; i < 100; i++) {
				t *= x;
				if (y == t) return i;
				GT::unitaryInv(inv, t);
				if (y == inv) return -i;
			}
			throw cybozu::Exception("BGN:dec:log:not found");
		}
		int dec(const CipherText& c) const
		{
			if (!c.isMultiplied()) {
				/*
					S = myP + rP
					T = mzP + rxP
					R = xS - T = m(xy - z)P = mB
				*/
				G1 R1;
				G1::mul(R1, c.S1, x1);
				R1 -= c.T1;
//				int m1 = local::log(B1, R1);
				int m1 = hashTbl.log(R1);
#if 0 // for debug
				G2 R2;
				G2::mul(R2, c.S2, x2);
				R2 -= c.T2;
				int m2 = local::log(B2, R2);
				if (m1 != m2) {
					throw cybozu::Exception("bad dec") << m1 << m2;
				}
#endif
				return m1;
			}
			/*
				(s, t, u, v) := (e(S, S'), e(S, T'), e(T, S'), e(T, T'))
				s^(xx') v / (t^x u^x')
				= e(xS, x'S') e(xS, -T') e(-T, x'S') e(T, T')
				= e(xS - T, x'S' - T')
				= e(m B1, m' B2)
				= e(B1, B2)^(mm')
			*/
			GT s, t, u;
			GT::pow(s, c.g[0], x1x2);
			s *= c.g[3];
			GT::pow(t, c.g[1], x1);
			GT::pow(u, c.g[2], x2);
			t *= u;
			GT::unitaryInv(t, t);
			s *= t;
			BN::finalExp(s, s);
			return log(g, s);
		}
	};

	class PublicKey {
		G1 xP, yP, zP;
		G2 xQ, yQ, zQ;
		friend class SecretKey;
		/*
			(S, T) = (m yP + rP, m zP + r xP)
		*/
		template<class G, class RG>
		static void enc1(G& S, G& T, const G& P, const G& xP, const G& yP, const G& zP, int m, RG& rg)
		{
			Fr r;
			r.setRand(rg);
			G C;
			G::mul(S, yP, m);
			G::mul(C, P, r);
			S += C;
			G::mul(T, zP, m);
			G::mul(C, xP, r);
			T += C;
		}
	public:
		template<class RG>
		void enc(CipherText& c, int m, RG& rg) const
		{
			enc1(c.S1, c.T1, P, xP, yP, zP, m, rg);
			enc1(c.S2, c.T2, Q, xQ, yQ, zQ, m, rg);
		}
		/*
			cy = cx * Enc(1)
		*/
		template<class RG>
		void mulEnc1(CipherText& cy, const CipherText& cx, RG& rg) const
		{
			if (cx.isMultiplied()) throw cybozu::Exception("PublicKey:mulEnc1:already multiplied");
			/*
				Enc(1) = (S, T) = (yP + rP, zP + r xP)
			*/
			G1 S, T;
			Fr r;
			r.setRand(rg);
			G1::mul(S, P, r);
			S += yP;
			G1::mul(T, xP, r);
			T += zP;
			/*
				cy = cx * (S, T)
			*/
			cy.g.resize(4);
			BN::millerLoop(cy.g[0], S, cx.S2);
			BN::millerLoop(cy.g[1], S, cx.T2);
			BN::millerLoop(cy.g[2], T, cx.S2);
			BN::millerLoop(cy.g[3], T, cx.T2);
		}
		/*
			c += Enc(0)
		*/
		template<class RG>
		void rerandomize(CipherText& c, RG& rg) const
		{
			if (c.isMultiplied()) {
				/*
					add Enc(0) * Enc(0)
					(S1, T1) * (S2, T2) = (rP, rxP) * (r'Q, r'xQ)
					replace r <- rr'
					= (r P, rxP) * (Q, xQ)
				*/
				G1 S1, T1;
				Fr r;
				r.setRand(rg);
				G1::mul(S1, P, r);
				G1::mul(T1, xP, r);
				GT e;
				BN::millerLoop(e, S1, Q);
				c.g[0] *= e;
				BN::millerLoop(e, S1, xQ);
				c.g[1] *= e;
				BN::millerLoop(e, T1, Q);
				c.g[2] *= e;
				BN::millerLoop(e, T1, xQ);
				c.g[3] *= e;
			} else {
				CipherText c0;
				enc(c0, 0, rg);
				c.add(c0);
			}
		}
	};

	class CipherText {
		typedef std::vector<GT> GTVec;
		G1 S1, T1;
		G2 S2, T2;
		GTVec g;
		friend class SecretKey;
		friend class PublicKey;
	public:
		bool isMultiplied() const { return !g.empty(); }
		static inline void add(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() && y.isMultiplied()) {
				/*
					(g[i]) * (g'[i]) = (g[i] * g'[i])
				*/
				for (size_t i = 0; i < z.g.size(); i++) {
					GT::mul(z.g[i], x.g[i], y.g[i]);
				}
				return;
			}
			if (!x.isMultiplied() && !y.isMultiplied()) {
				/*
					(S, T) + (S', T') = (S + S', T + T')
				*/
				G1::add(z.S1, x.S1, y.S1);
				G1::add(z.T1, x.T1, y.T1);
				G2::add(z.S2, x.S2, y.S2);
				G2::add(z.T2, x.T2, y.T2);
				return;
			}
			throw cybozu::Exception("bgn:CipherText:add:mixed CipherText") << x.isMultiplied() << y.isMultiplied();
		}
		static inline void mul(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() || y.isMultiplied()) {
				throw cybozu::Exception("bgn:CipherText:mul:already mul");
			}
			/*
				(S1, T1) * (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
				call finalExp at once in decrypting c
			*/
			z.g.resize(4);
			BN::millerLoop(z.g[0], x.S1, y.S2);
			BN::millerLoop(z.g[1], x.S1, y.T2);
			BN::millerLoop(z.g[2], x.T1, y.S2);
			BN::millerLoop(z.g[3], x.T1, y.T2);
		}
		void add(const CipherText& c) { add(*this, *this, c); }
		void mul(const CipherText& c) { mul(*this, *this, c); }
	};
};

template<class BN, class Fr>
typename BN::G1 BGNT<BN, Fr>::P;

template<class BN, class Fr>
typename BN::G2 BGNT<BN, Fr>::Q;

} } // mcl::bgn

