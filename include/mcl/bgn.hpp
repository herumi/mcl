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
#include <iosfwd>
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
		compute log_P(xP) for |x| <= hashSize * tryNum
	*/
	void init(const G& P, size_t hashSize, size_t tryNum = 0)
	{
		if (hashSize == 0) {
			kcv.clear();
			return;
		}
		if (hashSize >= 0x80000000u) throw cybozu::Exception("EcHashTable:init:hashSize is too large");
		this->P = P;
		this->hashSize = (int)hashSize;
		this->tryNum = tryNum;
		kcv.resize(hashSize);
		G xP;
		xP.clear();
		for (size_t i = 1; i <= (int)hashSize; i++) {
			xP += P;
			xP.normalize();
			kcv[i - 1].key = uint32_t(*xP.x.getUnit());
			kcv[i - 1].count = xP.y.isOdd() ? i : -1;
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
		call basicLog at most 2 * tryNum
	*/
	int log(const G& xP) const
	{
		bool ok;
		int c = basicLog(xP, &ok);
		if (ok) {
			return c;
		}
		G posP = xP, negP = xP;
		int posCenter = 0;
		int negCenter = 0;
		int next = hashSize * 2 + 1;
		for (size_t i = 1; i < tryNum; i++) {
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
		throw cybozu::Exception("EcHashTable:log:not found");
	}
};

template<class GT>
class GTHashTable {
	typedef std::vector<KeyCount> KeyCountVec;
	KeyCountVec kcv;
	GT g;
	GT nextg;
	GT nextgInv;
	int hashSize;
	size_t tryNum;
public:
	GTHashTable() : hashSize(0), tryNum(0) {}
	/*
		compute log_P(g^x) for |x| <= hashSize * tryNum
	*/
	void init(const GT& g, size_t hashSize, size_t tryNum = 0)
	{
		if (hashSize == 0) {
			kcv.clear();
			return;
		}
		if (hashSize >= 0x80000000u) throw cybozu::Exception("GTHashTable:init:hashSize is too large");
		this->g = g;
		this->hashSize = (int)hashSize;
		this->tryNum = tryNum;
		kcv.resize(hashSize);
		GT gx = 1;
		for (int i = 1; i <= (int)hashSize; i++) {
			gx *= g;
			kcv[i - 1].key = uint32_t(*gx.getFp0()->getUnit());
			kcv[i - 1].count = gx.b.a.a.isOdd() ? i : -i;
		}
		nextg = gx;
		GT::sqr(nextg, nextg);
		nextg *= g; // nextg = g^(hasSize * 2 + 1)
		GT::unitaryInv(nextgInv, nextg);
		/*
			ascending order of abs(count) for same key
		*/
		std::stable_sort(kcv.begin(), kcv.end());
	}
	/*
		log_P(g^x)
		find range which has same hash of gx in kcv,
		and detect it
	*/
	int basicLog(const GT& gx, bool *ok = 0) const
	{
		if (ok) *ok = true;
		if (gx.isOne()) return 0;
		typedef KeyCountVec::const_iterator Iter;
		KeyCount kc;
		kc.key = uint32_t(*gx.getFp0()->getUnit());
		kc.count = 0;
		std::pair<Iter, Iter> p = std::equal_range(kcv.begin(), kcv.end(), kc);
		GT Q = 1;
		int prev = 0;
		/*
			check range which has same hash
		*/
		while (p.first != p.second) {
			int count = p.first->count;
			int abs_c = std::abs(count);
			assert(abs_c >= prev); // assume ascending order
			bool neg = count < 0;
			GT T;
			GT::pow(T, g, abs_c - prev);
			Q *= T;
			if (Q.a == gx.a) {
				if (Q.b.a.a.isOdd() ^ gx.b.a.a.isOdd() ^ neg) return -count;
				return count;
			}
			prev = abs_c;
			++p.first;
		}
		if (ok) {
			*ok = false;
			return 0;
		}
		throw cybozu::Exception("GTHashTable:basicLog:not found");
	}
	/*
		compute log_P(g^x)
		call basicLog at most 2 * tryNum
	*/
	int log(const GT& gx) const
	{
		bool ok;
		int c = basicLog(gx, &ok);
		if (ok) {
			return c;
		}
		GT pos = gx, neg = gx;
		int posCenter = 0;
		int negCenter = 0;
		int next = hashSize * 2 + 1;
		for (size_t i = 1; i < tryNum; i++) {
			pos *= nextgInv;
			posCenter += next;
			c = basicLog(pos, &ok);
			if (ok) {
				return posCenter + c;
			}
			neg *= nextg;
			negCenter -= next;
			c = basicLog(neg, &ok);
			if (ok) {
				return negCenter + c;
			}
		}
		throw cybozu::Exception("GTHashTable:log:not found");
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
	// additive HE
	class CipherTextA; // = CipherTextG1 + CipherTextG2
	class CipherTextM; // multiplicative HE
	class CipherText; // CipherTextA + CipherTextM

	static G1 P;
	static G2 Q;

private:
	template<class G>
	class CipherTextAT {
		G S, T;
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextA;
		friend class CipherTextM;
	public:
		void clear()
		{
			S.clear();
			T.clear();
		}
		static inline void add(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) + (S', T') = (S + S', T + T')
			*/
			G::add(z.S, x.S, y.S);
			G::add(z.T, x.T, y.T);
		}
		static inline void sub(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) - (S', T') = (S - S', T - T')
			*/
			G::sub(z.S, x.S, y.S);
			G::sub(z.T, x.T, y.T);
		}
		static inline void neg(CipherTextAT& y, const CipherTextAT& x)
		{
			G::neg(y.S, x.S);
			G::neg(y.T, x.T);
		}
		void add(const CipherTextAT& c) { add(*this, *this, c); }
		void sub(const CipherTextAT& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			S.readStream(is, ioMode);
			T.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = S.getStr(ioMode);
			str += sep;
			str += T.getStr(ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextAT& self)
		{
			return self.readStream(is, fp::detectIoMode(G::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextAT& self)
		{
			return os << self.getStr(fp::detectIoMode(G::getIoMode(), os));
		}
		bool operator==(const CipherTextAT& rhs) const
		{
			return S == rhs.S && T == rhs.T;
		}
		bool operator!=(const CipherTextAT& rhs) const { return !operator==(rhs); }
	};
	static inline void tensorProduct(GT g[4], const G1& S1, const G1& T1, const G2& S2, const G2& T2)
	{
		/*
			(S1, T1) x (S2, T2)
		*/
		BN::millerLoop(g[0], S1, S2);
		BN::millerLoop(g[1], S1, T2);
		BN::millerLoop(g[2], T1, S2);
		BN::millerLoop(g[3], T1, T2);
	}
public:

	typedef CipherTextAT<G1> CipherTextG1;
	typedef CipherTextAT<G2> CipherTextG2;

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
		local::EcHashTable<G1> g1HashTbl;
		local::GTHashTable<GT> gtHashTbl;
		void initInner()
		{
			G1::mul(B1, P, x1 * y1 - z1);
			G2::mul(B2, Q, x2 * y2 - z2);
			x1x2 = x1 * x2;
			BN::pairing(g, B1, B2);
		}
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
			initInner();
		}
		/*
			set range for G1-DLP
		*/
		void setRangeForG1DLP(size_t hashSize, size_t tryNum = 0)
		{
			g1HashTbl.init(B1, hashSize, tryNum);
		}
		/*
			set range for GT-DLP
		*/
		void setRangeForGTDLP(size_t hashSize, size_t tryNum = 0)
		{
			gtHashTbl.init(g, hashSize, tryNum);
		}
		/*
			set range for G1/GT DLP
			decode message m for |m| <= hasSize * tryNum
			decode time = O(log(hasSize) * tryNum)
			@note if tryNum = 0 then fast but require more memory(TBD)
		*/
		void setRangeForDLP(size_t hashSize, size_t tryNum = 0)
		{
			setRangeForG1DLP(hashSize, tryNum);
			setRangeForGTDLP(hashSize, tryNum);
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
#if 0
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
#endif
		int dec(const CipherTextG1& c) const
		{
			/*
				S = myP + rP
				T = mzP + rxP
				R = xS - T = m(xy - z)P = mB
			*/
			G1 R;
			G1::mul(R, c.S, x1);
			R -= c.T;
			return g1HashTbl.log(R);
		}
		int dec(const CipherTextA& c) const
		{
			return dec(c.c1);
		}
		int dec(const CipherTextM& c) const
		{
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
			return gtHashTbl.log(s);
//			return log(g, s);
		}
		int dec(const CipherText& c) const
		{
			if (c.isMultiplied()) {
				return dec(c.m);
			} else {
				return dec(c.a);
			}
		}
		std::istream& readStream(std::istream& is, int ioMode)
		{
			x1.readStream(is, ioMode);
			y1.readStream(is, ioMode);
			z1.readStream(is, ioMode);
			x2.readStream(is, ioMode);
			y2.readStream(is, ioMode);
			z2.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = x1.getStr(ioMode);
			str += sep;
			str += y1.getStr(ioMode);
			str += sep;
			str += z1.getStr(ioMode);
			str += sep;
			str += x2.getStr(ioMode);
			str += sep;
			str += y2.getStr(ioMode);
			str += sep;
			str += z2.getStr(ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, SecretKey& self)
		{
			return self.readStream(is, fp::detectIoMode(Fr::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const SecretKey& self)
		{
			return os << self.getStr(fp::detectIoMode(Fr::getIoMode(), os));
		}
		bool operator==(const SecretKey& rhs) const
		{
			return x1 == rhs.x1 && y1 == rhs.y1 && z1 == rhs.z1
			    && x2 == rhs.x2 && y2 == rhs.y2 && z2 == rhs.z2;
		}
		bool operator!=(const SecretKey& rhs) const { return !operator==(rhs); }
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
		void enc(CipherTextG1& c, int m, RG& rg) const
		{
			enc1(c.S, c.T, P, xP, yP, zP, m, rg);
		}
		template<class RG>
		void enc(CipherTextG2& c, int m, RG& rg) const
		{
			enc1(c.S, c.T, Q, xQ, yQ, zQ, m, rg);
		}
		template<class RG>
		void enc(CipherTextA& c, int m, RG& rg) const
		{
			enc(c.c1, m, rg);
			enc(c.c2, m, rg);
		}
		template<class RG>
		void enc(CipherText& c, int m, RG& rg) const
		{
			c.isMultiplied_ = false;
			enc(c.a, m, rg);
		}
		/*
			convert from CipherTextG1 to CipherTextM
		*/
		void convertToCipherTextM(CipherTextM& cm, const CipherTextG1& c1) const
		{
			/*
				Enc(1) = (S, T) = (yQ + rQ, zQ + r xQ) = (yQ, zQ) if r = 0
				cm = c1 * (yQ, zQ)
			*/
			tensorProduct(cm.g, c1.S, c1.T, yQ, zQ);
		}
		/*
			convert from CipherTextG2 to CipherTextM
		*/
		void convertToCipherTextM(CipherTextM& cm, const CipherTextG2& c2) const
		{
			/*
				Enc(1) = (S, T) = (yP + rP, zP + r xP) = (yP, zP) if r = 0
				cm = (yP, zP) * c2
			*/
			tensorProduct(cm.g, yP, zP, c2.S, c2.T);
		}
		void convertToCipherTextM(CipherTextM& cm, const CipherTextA& ca) const
		{
			convertToCipherTextM(cm, ca.c1);
		}
		void convertToCipherTextM(CipherText& cm, const CipherText& ca) const
		{
			if (ca.isMultiplied()) throw cybozu::Exception("bgn:PublicKey:convertCipherText:already isMultiplied");
			cm.isMultiplied_ = true;
			convertToCipherTextM(cm.m, ca.a);
		}
		/*
			c += Enc(0)
		*/
		template<class RG>
		void rerandomize(CipherTextA& c, RG& rg) const
		{
			CipherTextA c0;
			enc(c0, 0, rg);
			CipherTextA::add(c, c, c0);
		}
		template<class RG>
		void rerandomize(CipherTextM& c, RG& rg) const
		{
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
		}
		template<class RG>
		void rerandomize(CipherText& c, RG& rg) const
		{
			if (c.isMultiplied()) {
				rerandomize(c.m, rg);
			} else {
				rerandomize(c.a, rg);
			}
		}
		std::istream& readStream(std::istream& is, int ioMode)
		{
			xP.readStream(is, ioMode);
			yP.readStream(is, ioMode);
			zP.readStream(is, ioMode);
			xQ.readStream(is, ioMode);
			yQ.readStream(is, ioMode);
			zQ.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = xP.getStr(ioMode);
			str += sep;
			str += yP.getStr(ioMode);
			str += sep;
			str += zP.getStr(ioMode);
			str += sep;
			str += xQ.getStr(ioMode);
			str += sep;
			str += yQ.getStr(ioMode);
			str += sep;
			str += zQ.getStr(ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, PublicKey& self)
		{
			return self.readStream(is, fp::detectIoMode(G1::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const PublicKey& self)
		{
			return os << self.getStr(fp::detectIoMode(G1::getIoMode(), os));
		}
		bool operator==(const PublicKey& rhs) const
		{
			return xP == rhs.xP && yP == rhs.yP && zP == rhs.zP
			    && xQ == rhs.xQ && yQ == rhs.yQ && zQ == rhs.zQ;
		}
		bool operator!=(const PublicKey& rhs) const { return !operator==(rhs); }
	};

	class CipherTextA {
		CipherTextG1 c1;
		CipherTextG2 c2;
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextM;
	public:
		void clear()
		{
			c1.clear();
			c2.clear();
		}
		static inline void add(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::add(z.c1, x.c1, y.c1);
			CipherTextG2::add(z.c2, x.c2, y.c2);
		}
		static inline void sub(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::sub(z.c1, x.c1, y.c1);
			CipherTextG2::sub(z.c2, x.c2, y.c2);
		}
		static inline void neg(CipherTextA& y, const CipherTextA& x)
		{
			CipherTextG1::neg(y.c1, x.c1);
			CipherTextG2::neg(y.c2, x.c2);
		}
		void add(const CipherTextA& c) { add(*this, *this, c); }
		void sub(const CipherTextA& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			c1.readStream(is, ioMode);
			c2.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = c1.getStr(ioMode);
			str += sep;
			str += c2.getStr(ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextA& self)
		{
			return self.readStream(is, fp::detectIoMode(G1::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextA& self)
		{
			return os << self.getStr(fp::detectIoMode(G1::getIoMode(), os));
		}
		bool operator==(const CipherTextA& rhs) const
		{
			return c1 == rhs.c1 && c2 == rhs.c2;
		}
		bool operator!=(const CipherTextA& rhs) const { return !operator==(rhs); }
	};

	class CipherTextM {
		GT g[4];
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextA;
	public:
		void clear()
		{
			for (int i = 0; i < 4; i++) {
				g[i].setOne();
			}
		}
		static inline void add(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
		{
			/*
				(g[i]) + (g'[i]) = (g[i] * g'[i])
			*/
			for (int i = 0; i < 4; i++) {
				GT::mul(z.g[i], x.g[i], y.g[i]);
			}
		}
		static inline void sub(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
		{
			/*
				(g[i]) - (g'[i]) = (g[i] / g'[i])
			*/
			GT t;
			for (size_t i = 0; i < 4; i++) {
				GT::unitaryInv(t, y.g[i]);
				GT::mul(z.g[i], x.g[i], t);
			}
		}
		static inline void mul(CipherTextM& z, const CipherTextG1& x, const CipherTextG2& y)
		{
			/*
				(S1, T1) * (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
				call finalExp at once in decrypting c
			*/
			tensorProduct(z.g, x.S, x.T, y.S, y.T);
		}
		static inline void mul(CipherTextM& z, const CipherTextA& x, const CipherTextA& y)
		{
			mul(z, x.c1, y.c2);
		}
		void add(const CipherTextM& c) { add(*this, *this, c); }
		void sub(const CipherTextM& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			for (size_t i = 0; i < 4; i++) {
				g[i].readStream(is, ioMode);
			}
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = g[0].getStr(ioMode);
			for (int i = 1; i < 4; i++) {
				str += sep;
				str += g[i].getStr(ioMode);
			}
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextM& self)
		{
			return self.readStream(is, fp::detectIoMode(G1::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextM& self)
		{
			return os << self.getStr(fp::detectIoMode(G1::getIoMode(), os));
		}
		bool operator==(const CipherTextM& rhs) const
		{
			for (int i = 0; i < 4; i++) {
				if (g[i] != rhs.g[i]) return false;
			}
			return true;
		}
		bool operator!=(const CipherTextM& rhs) const { return !operator==(rhs); }
	};

	class CipherText {
		bool isMultiplied_;
		CipherTextA a;
		CipherTextM m;
		friend class SecretKey;
		friend class PublicKey;
	public:
		CipherText() : isMultiplied_(false) {}
		void clearAsAdded()
		{
			isMultiplied_ = false;
			a.clear();
		}
		void clearAsMultiplied()
		{
			isMultiplied_ = true;
			m.clear();
		}
		bool isMultiplied() const { return isMultiplied_; }
		static inline void add(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() && y.isMultiplied()) {
				z.isMultiplied_ = true;
				CipherTextM::add(z.m, x.m, y.m);
				return;
			}
			if (!x.isMultiplied() && !y.isMultiplied()) {
				z.isMultiplied_ = false;
				CipherTextA::add(z.a, x.a, y.a);
				return;
			}
			throw cybozu::Exception("bgn:CipherText:add:mixed CipherText");
		}
		static inline void sub(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() && y.isMultiplied()) {
				z.isMultiplied_ = true;
				CipherTextM::sub(z.m, x.m, y.m);
				return;
			}
			if (!x.isMultiplied() && !y.isMultiplied()) {
				z.isMultiplied_ = false;
				CipherTextA::sub(z.a, x.a, y.a);
				return;
			}
			throw cybozu::Exception("bgn:CipherText:sub:mixed CipherText");
		}
		static inline void mul(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() || y.isMultiplied()) {
				throw cybozu::Exception("bgn:CipherText:mul:mixed CipherText");
			}
			z.isMultiplied_ = true;
			CipherTextM::mul(z.m, x.a, y.a);
		}
		void add(const CipherText& c) { add(*this, *this, c); }
		void sub(const CipherText& c) { sub(*this, *this, c); }
		void mul(const CipherText& c) { mul(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			is >> isMultiplied_;
			if (isMultiplied()) {
				m.readStream(is, ioMode);
			} else {
				a.readStream(is, ioMode);
			}
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = isMultiplied() ? "1" : "0";
			str += sep;
			if (isMultiplied()) {
				str += m.getStr(ioMode);
			} else {
				str += a.getStr(ioMode);
			}
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			std::istringstream is(str);
			readStream(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherText& self)
		{
			return self.readStream(is, fp::detectIoMode(G1::getIoMode(), is));
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherText& self)
		{
			return os << self.getStr(fp::detectIoMode(G1::getIoMode(), os));
		}
		bool operator==(const CipherTextM& rhs) const
		{
			if (isMultiplied() != rhs.isMultiplied()) return false;
			if (isMultiplied()) {
				return m == rhs.m;
			}
			return a == rhs.a;
		}
		bool operator!=(const CipherTextM& rhs) const { return !operator==(rhs); }
	};
};

template<class BN, class Fr>
typename BN::G1 BGNT<BN, Fr>::P;

template<class BN, class Fr>
typename BN::G2 BGNT<BN, Fr>::Q;

} } // mcl::bgn

