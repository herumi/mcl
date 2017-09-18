#pragma once
/**
	@file
	@brief somewhat homomorphic encryption with one-time multiplication, based on prime-order pairings
	@author MITSUNARI Shigeo(@herumi)
	see https://github.com/herumi/mcl/blob/master/misc/she/she.pdf
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

	David Mandell Freeman:
	Converting Pairing-Based Cryptosystems from Composite-Order Groups to Prime-Order Groups. EUROCRYPT 2010: 44-61
	http://theory.stanford.edu/~dfreeman/papers/subgroups.pdf
	this algorithm reduces public key size compared to the paper by Sakai's idea.

	BGN encryption
	http://theory.stanford.edu/~dfreeman/cs259c-f11/lectures/bgn
*/
#include <vector>
#include <iosfwd>
#if !defined(MCL_USE_BN256) && !defined(MCL_USE_BN384) && !defined(MCL_USE_BN512)
	#define MCL_USE_BN256
#endif
#ifdef MCL_USE_BN256
#include <mcl/bn256.hpp>
namespace bn_current = mcl::bn256;
#endif
#ifdef MCL_USE_BN384
#include <mcl/bn384.hpp>
namespace bn_current = mcl::bn384;
#endif
#ifdef MCL_USE_BN512
#include <mcl/bn512.hpp>
namespace bn_current = mcl::bn512;
#endif

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
#else
#include <cybozu/random_generator.hpp>
#endif

namespace mcl { namespace she {

namespace local {

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
typedef std::random_device RandomDevice;
static thread_local std::random_device g_rg;
#else
static cybozu::RandomGenerator g_rg;
#endif

struct KeyCount {
	uint32_t key;
	int32_t count; // power
	bool operator<(const KeyCount& rhs) const
	{
		return key < rhs.key;
	}
	bool isSame(const KeyCount& rhs) const
	{
		return key == rhs.key && count == rhs.count;
	}
};

template<class G, bool = true>
struct InterfaceForHashTable {
	static bool isOdd(const G& P) { return P.y.isOdd(); }
	static bool isZero(const G& P) { return P.isZero(); }
	static bool isSameX(const G& P, const G& Q) { return P.x == Q.x; }
	static uint32_t getHash(const G& P) { return uint32_t(*P.x.getUnit()); }
	static void clear(G& P) { P.clear(); }
	static void normalize(G& P) { P.normalize(); }
	static void dbl(G& Q, const G& P) { G::dbl(Q, P); }
	static void neg(G& Q, const G& P) { G::neg(Q, P); }
	static void add(G& R, const G& P, const G& Q) { G::add(R, P, Q); }
	static void mul(G& Q, const G& P, int x) { G::mul(Q, P, x); }
};

/*
	treat Fp12 as EC
	unitary inverse of (a, b) = (a, -b)
	then b.a.a or -b.a.a is odd
*/
template<class G>
struct InterfaceForHashTable<G, false> {
	static bool isOdd(const G& x) { return x.b.a.a.isOdd(); }
	static bool isZero(const G& x) { return x.isOne(); }
	static bool isSameX(const G& x, const G& Q) { return x.a == Q.a; }
	static uint32_t getHash(const G& x) { return uint32_t(*x.getFp0()->getUnit()); }
	static void clear(G& x) { x = 1; }
	static void normalize(G&) { }
	static void dbl(G& y, const G& x) { G::sqr(y, x); }
	static void neg(G& Q, const G& P) { G::unitaryInv(Q, P); }
	static void add(G& z, const G& x, const G& y) { G::mul(z, x, y); }
	static void mul(G& z, const G& x, int y) { G::pow(z, x, y); }
};

/*
	HashTable<EC, true> or HashTable<Fp12, false>
*/
template<class G, bool isEC = true>
class HashTable {
	typedef InterfaceForHashTable<G, isEC> I;
	typedef std::vector<KeyCount> KeyCountVec;
	KeyCountVec kcv;
	G P;
	G nextP;
	G nextNegP;
	size_t tryNum;
	union ic {
		uint64_t i;
		char c[8];
	};
	static void saveUint64(std::ostream& os, uint64_t v)
	{
		ic ic;
		ic.i = v;
		os.write(ic.c, sizeof(ic));
	}
	static uint64_t loadUint64(std::istream& is)
	{
		ic ic;
		is.read(ic.c, sizeof(ic));
		return ic.i;
	}
public:
	HashTable() : tryNum(0) {}
	bool operator==(const HashTable& rhs) const
	{
		if (kcv.size() != rhs.kcv.size()) return false;
		for (size_t i = 0; i < kcv.size(); i++) {
			if (!kcv[i].isSame(rhs.kcv[i])) return false;
		}
		return P == rhs.P && nextP == rhs.nextP && tryNum == rhs.tryNum;
	}
	bool operator!=(const HashTable& rhs) const { return !operator==(rhs); }
	/*
		compute log_P(xP) for |x| <= hashSize * tryNum
	*/
	void init(const G& P, size_t hashSize, size_t tryNum = 0)
	{
		if (hashSize == 0) {
			kcv.clear();
			return;
		}
		if (hashSize >= 0x80000000u) throw cybozu::Exception("HashTable:init:hashSize is too large");
		this->P = P;
		this->tryNum = tryNum;
		kcv.resize(hashSize);
		G xP;
		I::clear(xP);
		for (int i = 1; i <= (int)kcv.size(); i++) {
			I::add(xP, xP, P);
			I::normalize(xP);
			kcv[i - 1].key = I::getHash(xP);
			kcv[i - 1].count = I::isOdd(xP) ? i : -i;
		}
		nextP = xP;
		I::dbl(nextP, nextP);
		I::add(nextP, nextP, P); // nextP = (hasSize * 2 + 1)P
		I::neg(nextNegP, nextP); // nextNegP = -nextP
		/*
			ascending order of abs(count) for same key
		*/
		std::stable_sort(kcv.begin(), kcv.end());
	}
	void setTryNum(size_t tryNum)
	{
		this->tryNum = tryNum;
	}
	/*
		log_P(xP)
		find range which has same hash of xP in kcv,
		and detect it
	*/
	int basicLog(G xP, bool *ok = 0) const
	{
		if (ok) *ok = true;
		if (I::isZero(xP)) return 0;
		typedef KeyCountVec::const_iterator Iter;
		KeyCount kc;
		I::normalize(xP);
		kc.key = I::getHash(xP);
		kc.count = 0;
		std::pair<Iter, Iter> p = std::equal_range(kcv.begin(), kcv.end(), kc);
		G Q;
		I::clear(Q);
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
			I::mul(T, P, abs_c - prev);
			I::add(Q, Q, T);
			I::normalize(Q);
			if (I::isSameX(Q, xP)) {
				bool QisOdd = I::isOdd(Q);
				bool xPisOdd = I::isOdd(xP);
				if (QisOdd ^ xPisOdd ^ neg) return -count;
				if (QisOdd ^ xPisOdd ^ neg) return -count;
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
		int next = (int)kcv.size() * 2 + 1;
		for (size_t i = 1; i < tryNum; i++) {
			I::add(posP, posP, nextNegP);
			posCenter += next;
			c = basicLog(posP, &ok);
			if (ok) {
				return posCenter + c;
			}
			I::add(negP, negP, nextP);
			negCenter -= next;
			c = basicLog(negP, &ok);
			if (ok) {
				return negCenter + c;
			}
		}
		throw cybozu::Exception("HashTable:log:not found");
	}
	void save(std::ostream& os) const
	{
		saveUint64(os, kcv.size());
		saveUint64(os, tryNum);
		os.write((const char*)&kcv[0], sizeof(kcv[0]) * kcv.size());
		os << P.getStr(mcl::IoArray);
	}
	void load(std::istream& is)
	{
		size_t hashSize = size_t(loadUint64(is));
		kcv.resize(hashSize);
		tryNum = loadUint64(is);
		is.read((char*)&kcv[0], sizeof(kcv[0]) * kcv.size());
		P.readStream(is, mcl::IoArray);
		I::mul(nextP, P, (hashSize * 2) + 1);
		I::neg(nextNegP, nextP);
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
	throw cybozu::Exception("she:log:not found");
}

} // mcl::she::local

template<class BN, class Fr>
struct SHET {
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
	static GT ePQ; // e(P, Q)
	static local::HashTable<G1> g1HashTbl;
	static local::HashTable<GT, false> gtHashTbl;
//	static local::GTHashTable<GT> gtHashTbl;
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
		static void add(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) + (S', T') = (S + S', T + T')
			*/
			G::add(z.S, x.S, y.S);
			G::add(z.T, x.T, y.T);
		}
		static void sub(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) - (S', T') = (S - S', T - T')
			*/
			G::sub(z.S, x.S, y.S);
			G::sub(z.T, x.T, y.T);
		}
		static void mul(CipherTextAT& z, const CipherTextAT& x, int y)
		{
			G::mul(z.S, x.S, y);
			G::mul(z.T, x.T, y);
		}
		static void neg(CipherTextAT& y, const CipherTextAT& x)
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
	/*
		g1 = millerLoop(P1, Q)
		g2 = millerLoop(P2, Q)
	*/
	static void doubleMillerLoop(GT& g1, GT& g2, const G1& P1, const G1& P2, const G2& Q)
	{
#if 1
		std::vector<bn_current::Fp6> Qcoeff;
		BN::precomputeG2(Qcoeff, Q);
		BN::precomputedMillerLoop(g1, P1, Qcoeff);
		BN::precomputedMillerLoop(g2, P2, Qcoeff);
#else
		BN::millerLoop(g1, P1, Q);
		BN::millerLoop(g2, P2, Q);
#endif
	}
	static void tensorProduct(GT g[4], const G1& S1, const G1& T1, const G2& S2, const G2& T2)
	{
		/*
			(S1, T1) x (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
		*/
		doubleMillerLoop(g[0], g[2], S1, T1, S2);
		doubleMillerLoop(g[1], g[3], S1, T1, T2);
	}
public:

	typedef CipherTextAT<G1> CipherTextG1;
	typedef CipherTextAT<G2> CipherTextG2;

	static void init(const mcl::bn::CurveParam& cp = mcl::bn::CurveFp254BNb)
	{
		bn_current::initPairing(cp);
		BN::hashAndMapToG1(P, "0");
		BN::hashAndMapToG2(Q, "0");
		BN::pairing(ePQ, P, Q);
	}
	/*
		set range for G1-DLP
	*/
	static void setRangeForG1DLP(size_t hashSize, size_t tryNum = 0)
	{
		g1HashTbl.init(P, hashSize, tryNum);
	}
	/*
		set range for GT-DLP
	*/
	static void setRangeForGTDLP(size_t hashSize, size_t tryNum = 0)
	{
		gtHashTbl.init(ePQ, hashSize, tryNum);
	}
	/*
		set range for G1/GT DLP
		decode message m for |m| <= hasSize * tryNum
		decode time = O(log(hasSize) * tryNum)
		@note if tryNum = 0 then fast but require more memory(TBD)
	*/
	static void setRangeForDLP(size_t hashSize, size_t tryNum = 0)
	{
		setRangeForG1DLP(hashSize, tryNum);
		setRangeForGTDLP(hashSize, tryNum);
	}

	/*
		only one element is necessary for each G1 and G2.
		this is better than David Mandell Freeman's algorithm
	*/
	class SecretKey {
		Fr x, y;
	public:
		template<class RG>
		void setByCSPRNG(RG& rg)
		{
			x.setRand(rg);
			y.setRand(rg);
		}
		void setByCSPRNG() { setByCSPRNG(local::g_rg); }
		/*
			set xP and yQ
		*/
		void getPublicKey(PublicKey& pub) const
		{
			G1::mul(pub.xP, P, x);
			G2::mul(pub.yQ, Q, y);
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
			throw cybozu::Exception("she:dec:log:not found");
		}
#endif
		int dec(const CipherTextG1& c) const
		{
			/*
				S = mP + rxP
				T = rP
				R = S - xT = mP
			*/
			G1 R;
			G1::mul(R, c.T, x);
			G1::sub(R, c.S, R);
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
				s v^(xy) / (t^y u^x) = s (v^x / t) ^ y / u^x
				= e(P, Q)^(mm')
			*/
			GT t, u, v;
			GT::unitaryInv(t, c.g[1]);
			GT::unitaryInv(u, c.g[2]);
			GT::pow(v, c.g[3], x);
			v *= t;
			GT::pow(v, v, y);
			GT::pow(u, u, x);
			v *= u;
			v *= c.g[0];
			BN::finalExp(v, v);
			return gtHashTbl.log(v);
//			return log(g, v);
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
			x.readStream(is, ioMode);
			y.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = x.getStr(ioMode);
			str += sep;
			str += y.getStr(ioMode);
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
			return x == rhs.x && y == rhs.y;
		}
		bool operator!=(const SecretKey& rhs) const { return !operator==(rhs); }
	};

	class PublicKey {
		G1 xP;
		G2 yQ;
		friend class SecretKey;
		/*
			(S, T) = (m P + r xP, rP)
		*/
		template<class G, class RG>
		static void enc1(G& S, G& T, const G& P, const G& xP, int m, RG& rg)
		{
			Fr r;
			r.setRand(rg);
			G C;
			G::mul(T, P, r);
			G::mul(S, P, m);
			G::mul(C, xP, r);
			S += C;
		}
	public:
		template<class RG>
		void enc(CipherTextG1& c, int m, RG& rg) const
		{
			enc1(c.S, c.T, P, xP, m, rg);
		}
		template<class RG>
		void enc(CipherTextG2& c, int m, RG& rg) const
		{
			enc1(c.S, c.T, Q, yQ, m, rg);
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
		void enc(CipherTextG1& c, int m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextG2& c, int m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextA& c, int m) const { return enc(c, m, local::g_rg); }
		void enc(CipherText& c, int m) const { return enc(c, m, local::g_rg); }
		/*
			convert from CipherTextG1 to CipherTextM
		*/
		void convertToCipherTextM(CipherTextM& cm, const CipherTextG1& c1) const
		{
			/*
				Enc(1) = (S, T) = (Q + r yQ, rQ) = (Q, 0) if r = 0
				cm = c1 * (Q, 0) = (S, T) * (Q, 0) = (e(S, Q), 1, e(T, Q), 1)
			*/
			doubleMillerLoop(cm.g[0], cm.g[2], c1.S, c1.T, Q);
			cm.g[1] = 1;
			cm.g[3] = 1;
		}
		/*
			convert from CipherTextG2 to CipherTextM
		*/
		void convertToCipherTextM(CipherTextM& cm, const CipherTextG2& c2) const
		{
			/*
				Enc(1) = (S, T) = (P + r xP, rP) = (P, 0) if r = 0
				cm = (P, 0) * c2
			*/
			G1 zero; zero.clear();
			tensorProduct(cm.g, P, zero, c2.S, c2.T);
		}
		void convertToCipherTextM(CipherTextM& cm, const CipherTextA& ca) const
		{
			convertToCipherTextM(cm, ca.c1);
		}
		void convertToCipherTextM(CipherText& cm, const CipherText& ca) const
		{
			if (ca.isMultiplied()) throw cybozu::Exception("she:PublicKey:convertCipherText:already isMultiplied");
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
				(S1, T1) * (S2, T2) = (rxP, rP) * (r'yQ, r'Q)
				replace r <- rr', r' <- 1
				= (r xP, rP) * (yQ, Q)
			*/
			G1 S1, T1;
			Fr r;
			r.setRand(rg);
			G1::mul(S1, xP, r);
			G1::mul(T1, P, r);
			GT g[4];
			tensorProduct(g, S1, T1, yQ, Q);
			for (int i = 0; i < 4; i++) {
				c.g[i] *= g[i];
			}
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
		void rerandomize(CipherTextA& c) const { rerandomize(c, local::g_rg); }
		void rerandomize(CipherTextM& c) const { rerandomize(c, local::g_rg); }
		void rerandomize(CipherText& c) const { rerandomize(c, local::g_rg); }

		std::istream& readStream(std::istream& is, int ioMode)
		{
			xP.readStream(is, ioMode);
			yQ.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = xP.getStr(ioMode);
			str += sep;
			str += yQ.getStr(ioMode);
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
			return xP == rhs.xP && yQ == rhs.yQ;
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
		static void add(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::add(z.c1, x.c1, y.c1);
			CipherTextG2::add(z.c2, x.c2, y.c2);
		}
		static void sub(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::sub(z.c1, x.c1, y.c1);
			CipherTextG2::sub(z.c2, x.c2, y.c2);
		}
		static void mul(CipherTextA& z, const CipherTextA& x, int y)
		{
			CipherTextG1::mul(z.c1, x.c1, y);
			CipherTextG2::mul(z.c2, x.c2, y);
		}
		static void neg(CipherTextA& y, const CipherTextA& x)
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
		static void add(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
		{
			/*
				(g[i]) + (g'[i]) = (g[i] * g'[i])
			*/
			for (int i = 0; i < 4; i++) {
				GT::mul(z.g[i], x.g[i], y.g[i]);
			}
		}
		static void sub(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
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
		static void mul(CipherTextM& z, const CipherTextG1& x, const CipherTextG2& y)
		{
			/*
				(S1, T1) * (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
				call finalExp at once in decrypting c
			*/
			tensorProduct(z.g, x.S, x.T, y.S, y.T);
		}
		static void mul(CipherTextM& z, const CipherTextA& x, const CipherTextA& y)
		{
			mul(z, x.c1, y.c2);
		}
		static void mul(CipherTextM& z, const CipherTextM& x, int y)
		{
			for (int i = 0; i < 4; i++) {
				GT::pow(z.g[i], x.g[i], y);
			}
		}
		void add(const CipherTextM& c) { add(*this, *this, c); }
		void sub(const CipherTextM& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			for (int i = 0; i < 4; i++) {
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
		static void add(CipherText& z, const CipherText& x, const CipherText& y)
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
			throw cybozu::Exception("she:CipherText:add:mixed CipherText");
		}
		static void sub(CipherText& z, const CipherText& x, const CipherText& y)
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
			throw cybozu::Exception("she:CipherText:sub:mixed CipherText");
		}
		static void mul(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() || y.isMultiplied()) {
				throw cybozu::Exception("she:CipherText:mul:mixed CipherText");
			}
			z.isMultiplied_ = true;
			CipherTextM::mul(z.m, x.a, y.a);
		}
		static void mul(CipherText& z, const CipherText& x, int y)
		{
			if (x.isMultiplied()) {
				CipherTextM::mul(z.m, x.m, y);
			} else {
				CipherTextA::mul(z.a, x.a, y);
			}
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

template<class BN, class Fr> typename BN::G1 SHET<BN, Fr>::P;
template<class BN, class Fr> typename BN::G2 SHET<BN, Fr>::Q;
template<class BN, class Fr> typename BN::Fp12 SHET<BN, Fr>::ePQ;
template<class BN, class Fr> local::HashTable<typename BN::G1> SHET<BN, Fr>::g1HashTbl;
template<class BN, class Fr> local::HashTable<typename BN::Fp12, false> SHET<BN, Fr>::gtHashTbl;
typedef mcl::she::SHET<bn_current::BN, bn_current::Fr> SHE;
typedef SHE::SecretKey SecretKey;
typedef SHE::PublicKey PublicKey;
typedef SHE::CipherTextG1 CipherTextG1;
typedef SHE::CipherTextG2 CipherTextG2;
typedef SHE::CipherTextA CipherTextA;
typedef SHE::CipherTextM CipherTextM;
typedef SHE::CipherText CipherText;

} } // mcl::she

