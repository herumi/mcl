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
#include <cmath>
#include <vector>
#include <iosfwd>
#ifndef MCLBN_FP_UNIT_SIZE
	#define MCLBN_FP_UNIT_SIZE 4
#endif
#if MCLBN_FP_UNIT_SIZE == 4
#include <mcl/bn256.hpp>
namespace mcl {
namespace bn_current = mcl::bn256;
}
#elif MCLBN_FP_UNIT_SIZE == 6
#include <mcl/bn384.hpp>
namespace mcl {
namespace bn_current = mcl::bn384;
}
#elif MCLBN_FP_UNIT_SIZE == 8
#include <mcl/bn512.hpp>
namespace mcl {
namespace bn_current = mcl::bn512;
}
#else
	#error "MCLBN_FP_UNIT_SIZE must be 4, 6, or 8"
#endif

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
#else
#include <cybozu/random_generator.hpp>
#endif
#include <mcl/window_method.hpp>

namespace mcl { namespace she {

namespace local {

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
typedef std::random_device RandomDevice;
static thread_local std::random_device g_rg;
#else
static cybozu::RandomGenerator g_rg;
#endif
const size_t winSize = 10;

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
struct InterfaceForHashTable : G {
	static G& castG(InterfaceForHashTable& x) { return static_cast<G&>(x); }
	static const G& castG(const InterfaceForHashTable& x) { return static_cast<const G&>(x); }
	void clear() { clear(castG(*this)); }
	void normalize() { normalize(castG(*this)); }
	static bool isOdd(const G& P) { return P.y.isOdd(); }
	static bool isZero(const G& P) { return P.isZero(); }
	static bool isSameX(const G& P, const G& Q) { return P.x == Q.x; }
	static uint32_t getHash(const G& P) { return uint32_t(*P.x.getUnit()); }
	static void clear(G& P) { P.clear(); }
	static void normalize(G& P) { P.normalize(); }
	static void dbl(G& Q, const G& P) { G::dbl(Q, P); }
	static void neg(G& Q, const G& P) { G::neg(Q, P); }
	static void add(G& R, const G& P, const G& Q) { G::add(R, P, Q); }
	static void mul(G& Q, const G& P, int64_t x) { G::mul(Q, P, x); }
};

/*
	treat Fp12 as EC
	unitary inverse of (a, b) = (a, -b)
	then b.a.a or -b.a.a is odd
*/
template<class G>
struct InterfaceForHashTable<G, false> : G {
	static G& castG(InterfaceForHashTable& x) { return static_cast<G&>(x); }
	static const G& castG(const InterfaceForHashTable& x) { return static_cast<const G&>(x); }
	void clear() { clear(castG(*this)); }
	void normalize() { normalize(castG(*this)); }
	static bool isOdd(const G& x) { return x.b.a.a.isOdd(); }
	static bool isZero(const G& x) { return x.isOne(); }
	static bool isSameX(const G& x, const G& Q) { return x.a == Q.a; }
	static uint32_t getHash(const G& x) { return uint32_t(*x.getFp0()->getUnit()); }
	static void clear(G& x) { x = 1; }
	static void normalize(G&) { }
	static void dbl(G& y, const G& x) { G::sqr(y, x); }
	static void neg(G& Q, const G& P) { G::unitaryInv(Q, P); }
	static void add(G& z, const G& x, const G& y) { G::mul(z, x, y); }
	static void mul(G& z, const G& x, int64_t y) { G::pow(z, x, y); }
};

/*
	HashTable<EC, true> or HashTable<Fp12, false>
*/
template<class G, bool isEC = true>
class HashTable {
	typedef InterfaceForHashTable<G, isEC> I;
	typedef std::vector<KeyCount> KeyCountVec;
	KeyCountVec kcv;
	G P_;
	mcl::fp::WindowMethod<I> wm_;
	G nextP_;
	G nextNegP_;
	size_t tryNum_;
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
	void setWindowMethod()
	{
		const size_t bitSize = G::BaseFp::getBitSize();
		wm_.init(static_cast<const I&>(P_), bitSize, local::winSize);
	}
public:
	HashTable() : tryNum_(0) {}
	bool operator==(const HashTable& rhs) const
	{
		if (kcv.size() != rhs.kcv.size()) return false;
		for (size_t i = 0; i < kcv.size(); i++) {
			if (!kcv[i].isSame(rhs.kcv[i])) return false;
		}
		return P_ == rhs.P_ && nextP_ == rhs.nextP_ && tryNum_ == rhs.tryNum_;
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
		P_ = P;
		tryNum_ = tryNum;
		kcv.resize(hashSize);
		G xP;
		I::clear(xP);
		for (int i = 1; i <= (int)kcv.size(); i++) {
			I::add(xP, xP, P_);
			I::normalize(xP);
			kcv[i - 1].key = I::getHash(xP);
			kcv[i - 1].count = I::isOdd(xP) ? i : -i;
		}
		nextP_ = xP;
		I::dbl(nextP_, nextP_);
		I::add(nextP_, nextP_, P_); // nextP = (hasSize * 2 + 1)P
		I::neg(nextNegP_, nextP_); // nextNegP = -nextP
		/*
			ascending order of abs(count) for same key
		*/
		std::stable_sort(kcv.begin(), kcv.end());
		setWindowMethod();
	}
	void setTryNum(size_t tryNum)
	{
		this->tryNum_ = tryNum;
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
//			I::mul(T, P, abs_c - prev);
			mulByWindowMethod(T, abs_c - prev);
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
		int64_t next = (int64_t)kcv.size() * 2 + 1;
		for (size_t i = 1; i < tryNum_; i++) {
			I::add(posP, posP, nextNegP_);
			posCenter += next;
			c = basicLog(posP, &ok);
			if (ok) {
				return posCenter + c;
			}
			I::add(negP, negP, nextP_);
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
		saveUint64(os, tryNum_);
		os.write((const char*)&kcv[0], sizeof(kcv[0]) * kcv.size());
		os << P_.getStr(mcl::IoArray);
	}
	void load(std::istream& is)
	{
		size_t hashSize = size_t(loadUint64(is));
		kcv.resize(hashSize);
		tryNum_ = loadUint64(is);
		is.read((char*)&kcv[0], sizeof(kcv[0]) * kcv.size());
		P_.readStream(is, mcl::IoArray);
		I::mul(nextP_, P_, (hashSize * 2) + 1);
		I::neg(nextNegP_, nextP_);
		setWindowMethod();
	}
	const mcl::fp::WindowMethod<I>& getWM() const { return wm_; }
	/*
		mul(x, P, y);
	*/
	template<class T>
	void mulByWindowMethod(G& x, const T& y) const
	{
		wm_.mul(static_cast<I&>(x), y);
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

	static G1 P_;
	static G2 Q_;
	static GT ePQ_; // e(P, Q)
	static std::vector<bn_current::Fp6> Qcoeff_;
	static local::HashTable<G1> PhashTbl_;
	static mcl::fp::WindowMethod<G2> Qwm_;
	typedef local::InterfaceForHashTable<GT, false> GTasEC;
	static local::HashTable<GT, false> ePQhashTbl_;
private:
	template<class G>
	class CipherTextAT {
		G S_, T_;
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextA;
		friend class CipherTextM;
	public:
		void clear()
		{
			S_.clear();
			T_.clear();
		}
		static void add(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) + (S', T') = (S + S', T + T')
			*/
			G::add(z.S_, x.S_, y.S_);
			G::add(z.T_, x.T_, y.T_);
		}
		static void sub(CipherTextAT& z, const CipherTextAT& x, const CipherTextAT& y)
		{
			/*
				(S, T) - (S', T') = (S - S', T - T')
			*/
			G::sub(z.S_, x.S_, y.S_);
			G::sub(z.T_, x.T_, y.T_);
		}
		static void mul(CipherTextAT& z, const CipherTextAT& x, int64_t y)
		{
			G::mul(z.S_, x.S_, y);
			G::mul(z.T_, x.T_, y);
		}
		static void neg(CipherTextAT& y, const CipherTextAT& x)
		{
			G::neg(y.S_, x.S_);
			G::neg(y.T_, x.T_);
		}
		void add(const CipherTextAT& c) { add(*this, *this, c); }
		void sub(const CipherTextAT& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			S_.readStream(is, ioMode);
			T_.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = S_.getStr(ioMode);
			str += sep;
			str += T_.getStr(ioMode);
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
			return S_ == rhs.S_ && T_ == rhs.T_;
		}
		bool operator!=(const CipherTextAT& rhs) const { return !operator==(rhs); }
	};
	/*
		g1 = millerLoop(P1, Q)
		g2 = millerLoop(P2, Q)
	*/
	static void doublePairing(GT& g1, GT& g2, const G1& P1, const G1& P2, const G2& Q)
	{
#if 1
		std::vector<bn_current::Fp6> Qcoeff;
		BN::precomputeG2(Qcoeff, Q);
		BN::precomputedMillerLoop(g1, P1, Qcoeff);
		BN::finalExp(g1, g1);
		BN::precomputedMillerLoop(g2, P2, Qcoeff);
		BN::finalExp(g2, g2);
#else
		BN::pairing(g1, P1, Q);
		BN::pairing(g2, P2, Q);
#endif
	}
	static void tensorProduct(GT g[4], const G1& S1, const G1& T1, const G2& S2, const G2& T2)
	{
		/*
			(S1, T1) x (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
		*/
		doublePairing(g[0], g[2], S1, T1, S2);
		doublePairing(g[1], g[3], S1, T1, T2);
	}
public:

	typedef CipherTextAT<G1> CipherTextG1;
	typedef CipherTextAT<G2> CipherTextG2;

	static void init(const mcl::bn::CurveParam& cp = mcl::bn::CurveFp254BNb)
	{
		bn_current::initPairing(cp);
		BN::hashAndMapToG1(P_, "0");
		BN::hashAndMapToG2(Q_, "0");
		BN::pairing(ePQ_, P_, Q_);
		BN::precomputeG2(Qcoeff_, Q_);
		const size_t bitSize = Fr::getBitSize();
		Qwm_.init(Q_, bitSize, local::winSize);
	}
	/*
		set range for G1-DLP
	*/
	static void setRangeForG1DLP(size_t hashSize, size_t tryNum = 0)
	{
		PhashTbl_.init(P_, hashSize, tryNum);
	}
	/*
		set range for GT-DLP
	*/
	static void setRangeForGTDLP(size_t hashSize, size_t tryNum = 0)
	{
		ePQhashTbl_.init(ePQ_, hashSize, tryNum);
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
		Fr x_, y_;
	public:
		template<class RG>
		void setByCSPRNG(RG& rg)
		{
			x_.setRand(rg);
			y_.setRand(rg);
		}
		void setByCSPRNG() { setByCSPRNG(local::g_rg); }
		/*
			set xP and yQ
		*/
		void getPublicKey(PublicKey& pub) const
		{
			pub.set(x_, y_);
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
		int64_t dec(const CipherTextG1& c) const
		{
			/*
				S = mP + rxP
				T = rP
				R = S - xT = mP
			*/
			G1 R;
			G1::mul(R, c.T_, x_);
			G1::sub(R, c.S_, R);
			return PhashTbl_.log(R);
		}
		int64_t dec(const CipherTextA& c) const
		{
			return dec(c.c1_);
		}
		int64_t dec(const CipherTextM& c) const
		{
			/*
				(s, t, u, v) := (e(S, S'), e(S, T'), e(T, S'), e(T, T'))
				s v^(xy) / (t^y u^x) = s (v^x / t) ^ y / u^x
				= e(P, Q)^(mm')
			*/
			GT t, u, v;
			GT::unitaryInv(t, c.g_[1]);
			GT::unitaryInv(u, c.g_[2]);
			GT::pow(v, c.g_[3], x_);
			v *= t;
			GT::pow(v, v, y_);
			GT::pow(u, u, x_);
			v *= u;
			v *= c.g_[0];
			return ePQhashTbl_.log(v);
//			return log(g, v);
		}
		int64_t dec(const CipherText& c) const
		{
			if (c.isMultiplied()) {
				return dec(c.m_);
			} else {
				return dec(c.a_);
			}
		}
		std::istream& readStream(std::istream& is, int ioMode)
		{
			x_.readStream(is, ioMode);
			y_.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = x_.getStr(ioMode);
			str += sep;
			str += y_.getStr(ioMode);
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
			return x_ == rhs.x_ && y_ == rhs.y_;
		}
		bool operator!=(const SecretKey& rhs) const { return !operator==(rhs); }
	};

	class PublicKey {
		G1 xP_;
		G2 yQ_;
		friend class SecretKey;
		/*
			(S, T) = (m P + r xP, rP)
		*/
		template<class G, class RG, class I>
		static void enc1(G& S, G& T, const G& /*P*/, const G& xP, int64_t m, RG& rg, const mcl::fp::WindowMethod<I>& wm)
		{
			Fr r;
			r.setRand(rg);
//			G::mul(T, P, r);
			wm.mul(static_cast<I&>(T), r);
			G::mul(S, xP, r);
			if (m == 0) return;
			G C;
//			G::mul(C, P, m);
			wm.mul(static_cast<I&>(C), m);
			S += C;
		}
		void set(const Fr& x, const Fr& y)
		{
			G1::mul(xP_, P_, x);
			G2::mul(yQ_, Q_, y);
		}
	public:
		template<class RG>
		void enc(CipherTextG1& c, int64_t m, RG& rg) const
		{
			enc1(c.S_, c.T_, P_, xP_, m, rg, PhashTbl_.getWM());
		}
		template<class RG>
		void enc(CipherTextG2& c, int64_t m, RG& rg) const
		{
			enc1(c.S_, c.T_, Q_, yQ_, m, rg, Qwm_);
		}
		template<class RG>
		void enc(CipherTextA& c, int64_t m, RG& rg) const
		{
			enc(c.c1_, m, rg);
			enc(c.c2_, m, rg);
		}
		template<class RG>
		void enc(CipherTextM& c, int64_t m, RG& rg) const
		{
			/*
				(s, t, u, v) = ((e^x)^a (e^y)^b (e^-xy)^c e^m, e^b, e^a, e^c)
				s = e(a xP + m P, Q)e(b P - c xP, yQ)
			*/
			Fr ra, rb, rc;
			ra.setRand(rg);
			rb.setRand(rg);
			rc.setRand(rg);
			GT e;

			G1 P1, P2;
			G1::mul(P1, xP_, ra);
			if (m) {
//				G1::mul(P2, P, m);
				PhashTbl_.mulByWindowMethod(P2, m);
				P1 += P2;
			}
//			BN::millerLoop(c.g[0], P1, Q);
			BN::precomputedMillerLoop(c.g_[0], P1, Qcoeff_);
//			G1::mul(P1, P, rb);
			PhashTbl_.mulByWindowMethod(P1, rb);
			G1::mul(P2, xP_, rc);
			P1 -= P2;
			BN::millerLoop(e, P1, yQ_);
			c.g_[0] *= e;
			BN::finalExp(c.g_[0], c.g_[0]);
#if 1
			ePQhashTbl_.mulByWindowMethod(c.g_[1], rb);
			ePQhashTbl_.mulByWindowMethod(c.g_[2], ra);
			ePQhashTbl_.mulByWindowMethod(c.g_[3], rc);
#else
			GT::pow(c.g_[1], ePQ_, rb);
			GT::pow(c.g_[2], ePQ_, ra);
			GT::pow(c.g_[3], ePQ_, rc);
#endif
		}
		template<class RG>
		void enc(CipherText& c, int64_t m, RG& rg, bool multiplied = false) const
		{
			c.isMultiplied_ = multiplied;
			if (multiplied) {
				enc(c.m_, m, rg);
			} else {
				enc(c.a_, m, rg);
			}
		}
		void enc(CipherTextG1& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextG2& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextA& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextM& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherText& c, int64_t m, bool multiplied = false) const { return enc(c, m, local::g_rg, multiplied); }
		/*
			convert from CipherTextG1 to CipherTextM
		*/
		void convertToCipherTextM(CipherTextM& cm, const CipherTextG1& c1) const
		{
			/*
				Enc(1) = (S, T) = (Q + r yQ, rQ) = (Q, 0) if r = 0
				cm = c1 * (Q, 0) = (S, T) * (Q, 0) = (e(S, Q), 1, e(T, Q), 1)
			*/
//			doublePairing(cm.g_[0], cm.g_[2], c1.S, c1.T, Q);
			BN::precomputedMillerLoop(cm.g_[0], c1.S_, Qcoeff_);
			BN::finalExp(cm.g_[0], cm.g_[0]);
			BN::precomputedMillerLoop(cm.g_[2], c1.T_, Qcoeff_);
			BN::finalExp(cm.g_[2], cm.g_[2]);

			cm.g_[1] = 1;
			cm.g_[3] = 1;
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
			tensorProduct(cm.g_, P_, zero, c2.S_, c2.T_);
		}
		void convertToCipherTextM(CipherTextM& cm, const CipherTextA& ca) const
		{
			convertToCipherTextM(cm, ca.c1_);
		}
		void convertToCipherTextM(CipherText& cm, const CipherText& ca) const
		{
			if (ca.isMultiplied()) throw cybozu::Exception("she:PublicKey:convertCipherText:already isMultiplied");
			cm.isMultiplied_ = true;
			convertToCipherTextM(cm.m_, ca.a_);
		}
		/*
			c += Enc(0)
		*/
		template<class RG>
		void reRand(CipherTextG1& c, RG& rg) const
		{
			CipherTextG1 c0;
			enc(c0, 0, rg);
			CipherTextG1::add(c, c, c0);
		}
		template<class RG>
		void reRand(CipherTextG2& c, RG& rg) const
		{
			CipherTextG2 c0;
			enc(c0, 0, rg);
			CipherTextG2::add(c, c, c0);
		}
		template<class RG>
		void reRand(CipherTextA& c, RG& rg) const
		{
			CipherTextA c0;
			enc(c0, 0, rg);
			CipherTextA::add(c, c, c0);
		}
		template<class RG>
		void reRand(CipherTextM& c, RG& rg) const
		{
#if 1 // for circuit security : 3.58Mclk -> 5.4Mclk
			CipherTextM c0;
			enc(c0, 0, rg);
			CipherTextM::add(c, c, c0);
#else
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
			GT g_[4];
			tensorProduct(g_, S1, T1, yQ, Q);
			for (int i = 0; i < 4; i++) {
				c.g_[i] *= g_[i];
			}
#endif
		}
		template<class RG>
		void reRand(CipherText& c, RG& rg) const
		{
			if (c.isMultiplied()) {
				reRand(c.m_, rg);
			} else {
				reRand(c.a_, rg);
			}
		}
		void reRand(CipherTextG1& c) const { reRand(c, local::g_rg); }
		void reRand(CipherTextG2& c) const { reRand(c, local::g_rg); }
		void reRand(CipherTextA& c) const { reRand(c, local::g_rg); }
		void reRand(CipherTextM& c) const { reRand(c, local::g_rg); }
		void reRand(CipherText& c) const { reRand(c, local::g_rg); }

		std::istream& readStream(std::istream& is, int ioMode)
		{
			xP_.readStream(is, ioMode);
			yQ_.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = xP_.getStr(ioMode);
			str += sep;
			str += yQ_.getStr(ioMode);
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
			return xP_ == rhs.xP_ && yQ_ == rhs.yQ_;
		}
		bool operator!=(const PublicKey& rhs) const { return !operator==(rhs); }
	};

	class CipherTextA {
		CipherTextG1 c1_;
		CipherTextG2 c2_;
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextM;
	public:
		void clear()
		{
			c1_.clear();
			c2_.clear();
		}
		static void add(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::add(z.c1_, x.c1_, y.c1_);
			CipherTextG2::add(z.c2_, x.c2_, y.c2_);
		}
		static void sub(CipherTextA& z, const CipherTextA& x, const CipherTextA& y)
		{
			CipherTextG1::sub(z.c1_, x.c1_, y.c1_);
			CipherTextG2::sub(z.c2_, x.c2_, y.c2_);
		}
		static void mul(CipherTextA& z, const CipherTextA& x, int64_t y)
		{
			CipherTextG1::mul(z.c1_, x.c1_, y);
			CipherTextG2::mul(z.c2_, x.c2_, y);
		}
		static void neg(CipherTextA& y, const CipherTextA& x)
		{
			CipherTextG1::neg(y.c1_, x.c1_);
			CipherTextG2::neg(y.c2_, x.c2_);
		}
		void add(const CipherTextA& c) { add(*this, *this, c); }
		void sub(const CipherTextA& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			c1_.readStream(is, ioMode);
			c2_.readStream(is, ioMode);
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = c1_.getStr(ioMode);
			str += sep;
			str += c2_.getStr(ioMode);
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
			return c1_ == rhs.c1_ && c2_ == rhs.c2_;
		}
		bool operator!=(const CipherTextA& rhs) const { return !operator==(rhs); }
	};

	class CipherTextM {
		GT g_[4];
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextA;
	public:
		void clear()
		{
			for (int i = 0; i < 4; i++) {
				g_[i].setOne();
			}
		}
		static void add(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
		{
			/*
				(g[i]) + (g'[i]) = (g[i] * g'[i])
			*/
			for (int i = 0; i < 4; i++) {
				GT::mul(z.g_[i], x.g_[i], y.g_[i]);
			}
		}
		static void sub(CipherTextM& z, const CipherTextM& x, const CipherTextM& y)
		{
			/*
				(g[i]) - (g'[i]) = (g[i] / g'[i])
			*/
			GT t;
			for (size_t i = 0; i < 4; i++) {
				GT::unitaryInv(t, y.g_[i]);
				GT::mul(z.g_[i], x.g_[i], t);
			}
		}
		static void mul(CipherTextM& z, const CipherTextG1& x, const CipherTextG2& y)
		{
			/*
				(S1, T1) * (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
			*/
			tensorProduct(z.g_, x.S_, x.T_, y.S_, y.T_);
		}
		static void mul(CipherTextM& z, const CipherTextA& x, const CipherTextA& y)
		{
			mul(z, x.c1_, y.c2_);
		}
		static void mul(CipherTextM& z, const CipherTextM& x, int64_t y)
		{
			for (int i = 0; i < 4; i++) {
				GT::pow(z.g_[i], x.g_[i], y);
			}
		}
		void add(const CipherTextM& c) { add(*this, *this, c); }
		void sub(const CipherTextM& c) { sub(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			for (int i = 0; i < 4; i++) {
				g_[i].readStream(is, ioMode);
			}
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = g_[0].getStr(ioMode);
			for (int i = 1; i < 4; i++) {
				str += sep;
				str += g_[i].getStr(ioMode);
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
				if (g_[i] != rhs.g_[i]) return false;
			}
			return true;
		}
		bool operator!=(const CipherTextM& rhs) const { return !operator==(rhs); }
	};

	class CipherText {
		bool isMultiplied_;
		CipherTextA a_;
		CipherTextM m_;
		friend class SecretKey;
		friend class PublicKey;
	public:
		CipherText() : isMultiplied_(false) {}
		void clearAsAdded()
		{
			isMultiplied_ = false;
			a_.clear();
		}
		void clearAsMultiplied()
		{
			isMultiplied_ = true;
			m_.clear();
		}
		bool isMultiplied() const { return isMultiplied_; }
		static void add(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() && y.isMultiplied()) {
				z.isMultiplied_ = true;
				CipherTextM::add(z.m_, x.m_, y.m_);
				return;
			}
			if (!x.isMultiplied() && !y.isMultiplied()) {
				z.isMultiplied_ = false;
				CipherTextA::add(z.a_, x.a_, y.a_);
				return;
			}
			throw cybozu::Exception("she:CipherText:add:mixed CipherText");
		}
		static void sub(CipherText& z, const CipherText& x, const CipherText& y)
		{
			if (x.isMultiplied() && y.isMultiplied()) {
				z.isMultiplied_ = true;
				CipherTextM::sub(z.m_, x.m_, y.m_);
				return;
			}
			if (!x.isMultiplied() && !y.isMultiplied()) {
				z.isMultiplied_ = false;
				CipherTextA::sub(z.a_, x.a_, y.a_);
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
			CipherTextM::mul(z.m_, x.a_, y.a_);
		}
		static void mul(CipherText& z, const CipherText& x, int64_t y)
		{
			if (x.isMultiplied()) {
				CipherTextM::mul(z.m_, x.m_, y);
			} else {
				CipherTextA::mul(z.a_, x.a_, y);
			}
		}
		void add(const CipherText& c) { add(*this, *this, c); }
		void sub(const CipherText& c) { sub(*this, *this, c); }
		void mul(const CipherText& c) { mul(*this, *this, c); }
		std::istream& readStream(std::istream& is, int ioMode)
		{
			is >> isMultiplied_;
			if (isMultiplied()) {
				m_.readStream(is, ioMode);
			} else {
				a_.readStream(is, ioMode);
			}
			return is;
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			const char *sep = fp::getIoSeparator(ioMode);
			str = isMultiplied() ? "1" : "0";
			str += sep;
			if (isMultiplied()) {
				str += m_.getStr(ioMode);
			} else {
				str += a_.getStr(ioMode);
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
				return m_ == rhs.m_;
			}
			return a_ == rhs.a_;
		}
		bool operator!=(const CipherTextM& rhs) const { return !operator==(rhs); }
	};
};

template<class BN, class Fr> typename BN::G1 SHET<BN, Fr>::P_;
template<class BN, class Fr> typename BN::G2 SHET<BN, Fr>::Q_;
template<class BN, class Fr> typename BN::Fp12 SHET<BN, Fr>::ePQ_;
template<class BN, class Fr> std::vector<bn_current::Fp6> SHET<BN, Fr>::Qcoeff_;
template<class BN, class Fr> local::HashTable<typename BN::G1> SHET<BN, Fr>::PhashTbl_;
template<class BN, class Fr> mcl::fp::WindowMethod<typename BN::G2> SHET<BN, Fr>::Qwm_;
template<class BN, class Fr> local::HashTable<typename BN::Fp12, false> SHET<BN, Fr>::ePQhashTbl_;
typedef mcl::she::SHET<bn_current::BN, bn_current::Fr> SHE;
typedef SHE::SecretKey SecretKey;
typedef SHE::PublicKey PublicKey;
typedef SHE::CipherTextG1 CipherTextG1;
typedef SHE::CipherTextG2 CipherTextG2;
typedef SHE::CipherTextA CipherTextA;
typedef SHE::CipherTextM CipherTextM;
typedef CipherTextM CipherTextGT;
typedef SHE::CipherText CipherText;

} } // mcl::she

