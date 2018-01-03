#pragma once
/**
	@file
	@brief somewhat homomorphic encryption with one-time multiplication, based on prime-order pairings
	@author MITSUNARI Shigeo(@herumi)
	see https://github.com/herumi/mcl/blob/master/misc/she/she.pdf
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
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
#include <cybozu/endian.hpp>

namespace mcl { namespace she {

namespace local {

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
typedef std::random_device RandomDevice;
static thread_local std::random_device g_rg;
#else
static cybozu::RandomGenerator g_rg;
#endif
#ifndef MCLSHE_WIN_SIZE
	#define MCLSHE_WIN_SIZE 10
#endif
const size_t winSize = MCLSHE_WIN_SIZE;

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
	template<class INT>
	static void mul(G& Q, const G& P, const INT& x) { G::mul(Q, P, x); }
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
	template<class INT>
	static void mul(G& z, const G& x, const INT& y) { G::pow(z, x, y); }
};

template<class G>
char GtoChar();
template<>char GtoChar<bn_current::G1>() { return '1'; }
template<>char GtoChar<bn_current::G2>() { return '2'; }
template<>char GtoChar<bn_current::GT>() { return 'T'; }

/*
	HashTable<EC, true> or HashTable<Fp12, false>
*/
template<class G, bool isEC = true>
class HashTable {
	static const size_t defaultTryNum = 1024;
	typedef InterfaceForHashTable<G, isEC> I;
	typedef std::vector<KeyCount> KeyCountVec;
	KeyCountVec kcv_;
	G P_;
	mcl::fp::WindowMethod<I> wm_;
	G nextP_;
	G nextNegP_;
	size_t tryNum_;
	void setWindowMethod()
	{
		const size_t bitSize = G::BaseFp::BaseFp::getBitSize();
		wm_.init(static_cast<const I&>(P_), bitSize, local::winSize);
	}
public:
	HashTable() : tryNum_(defaultTryNum) {}
	bool operator==(const HashTable& rhs) const
	{
		if (kcv_.size() != rhs.kcv_.size()) return false;
		for (size_t i = 0; i < kcv_.size(); i++) {
			if (!kcv_[i].isSame(rhs.kcv_[i])) return false;
		}
		return P_ == rhs.P_ && nextP_ == rhs.nextP_;
	}
	bool operator!=(const HashTable& rhs) const { return !operator==(rhs); }
	/*
		compute log_P(xP) for |x| <= hashSize * tryNum
	*/
	void init(const G& P, size_t hashSize, size_t tryNum = defaultTryNum)
	{
		if (hashSize == 0) {
			kcv_.clear();
			return;
		}
		if (hashSize >= 0x80000000u) throw cybozu::Exception("HashTable:init:hashSize is too large");
		P_ = P;
		tryNum_ = tryNum;
		kcv_.resize(hashSize);
		G xP;
		I::clear(xP);
		for (int i = 1; i <= (int)kcv_.size(); i++) {
			I::add(xP, xP, P_);
			I::normalize(xP);
			kcv_[i - 1].key = I::getHash(xP);
			kcv_[i - 1].count = I::isOdd(xP) ? i : -i;
		}
		nextP_ = xP;
		I::dbl(nextP_, nextP_);
		I::add(nextP_, nextP_, P_); // nextP = (hasSize * 2 + 1)P
		I::neg(nextNegP_, nextP_); // nextNegP = -nextP
		/*
			ascending order of abs(count) for same key
		*/
		std::stable_sort(kcv_.begin(), kcv_.end());
		setWindowMethod();
	}
	void setTryNum(size_t tryNum)
	{
		this->tryNum_ = tryNum;
	}
	/*
		log_P(xP)
		find range which has same hash of xP in kcv_,
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
		std::pair<Iter, Iter> p = std::equal_range(kcv_.begin(), kcv_.end(), kc);
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
		int64_t next = (int64_t)kcv_.size() * 2 + 1;
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
	/*
		remark
		tryNum is not saved.
	*/
	template<class OutputStream>
	void save(OutputStream& os) const
	{
		cybozu::save(os, bn_current::BN::param.curveType);
		cybozu::writeChar(os, GtoChar<G>());
		cybozu::save(os, kcv_.size());
		cybozu::write(os, &kcv_[0], sizeof(kcv_[0]) * kcv_.size());
		P_.save(os);
	}
	/*
		remark
		tryNum is set defaultTryNum
	*/
	template<class InputStream>
	void load(InputStream& is, size_t tryNum = defaultTryNum)
	{
		int curveType;
		cybozu::load(curveType, is);
		if (curveType != bn_current::BN::param.curveType) throw cybozu::Exception("HashTable:bad curveType") << curveType;
		char c = 0;
		if (!cybozu::readChar(&c, is) || c != GtoChar<G>()) throw cybozu::Exception("HashTable:bad c") << (int)c;
		size_t kcvSize;
		cybozu::load(kcvSize, is);
		kcv_.resize(kcvSize);
		cybozu::read(&kcv_[0], sizeof(kcv_[0]) * kcvSize, is);
		P_.load(is);
		I::mul(nextP_, P_, (kcvSize * 2) + 1);
		I::neg(nextNegP_, nextP_);
		setWindowMethod();
		tryNum_ = tryNum;
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
	class PrecomputedPublicKey;
	// additive HE
	class CipherTextA; // = CipherTextG1 + CipherTextG2
	class CipherTextGT; // multiplicative HE
	class CipherText; // CipherTextA + CipherTextGT

	static G1 P_;
	static G2 Q_;
	static GT ePQ_; // e(P, Q)
	static std::vector<bn_current::Fp6> Qcoeff_;
	static local::HashTable<G1> PhashTbl_;
	static local::HashTable<G2> QhashTbl_;
	static mcl::fp::WindowMethod<G2> Qwm_;
	typedef local::InterfaceForHashTable<GT, false> GTasEC;
	static local::HashTable<GT, false> ePQhashTbl_;
private:
	template<class G>
	class CipherTextAT {
		G S_, T_;
		friend class SecretKey;
		friend class PublicKey;
		friend class PrecomputedPublicKey;
		friend class CipherTextA;
		friend class CipherTextGT;
		bool isZero(const Fr& x) const
		{
			G xT;
			G::mul(xT, T_, x);
			return S_ == xT;
		}
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
		// INT = int64_t or Fr
		template<class INT>
		static void mul(CipherTextAT& z, const CipherTextAT& x, const INT& y)
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
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			S_.load(is, ioMode);
			T_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			const char sep = *fp::getIoSeparator(ioMode);
			S_.save(os, ioMode);
			if (sep) cybozu::writeChar(os, sep);
			T_.save(os, ioMode);
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextAT& self)
		{
			self.load(is, fp::detectIoMode(G::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextAT& self)
		{
			self.save(os, fp::detectIoMode(G::getIoMode(), os));
			return os;
		}
		bool operator==(const CipherTextAT& rhs) const
		{
			return S_ == rhs.S_ && T_ == rhs.T_;
		}
		bool operator!=(const CipherTextAT& rhs) const { return !operator==(rhs); }
		size_t serialize(void *buf, size_t maxBufSize) const
		{
			cybozu::MemoryOutputStream os(buf, maxBufSize);
			save(os);
			return os.getPos();
		}
		size_t deserialize(const void *buf, size_t bufSize)
		{
			cybozu::MemoryInputStream is(buf, bufSize);
			load(is);
			return is.getPos();
		}
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
	static void finalExp4(GT out[4], const GT in[4])
	{
		for (int i =  0; i < 4; i++) {
			BN::finalExp(out[i], in[i]);
		}
	}
	static void tensorProductML(GT g[4], const G1& S1, const G1& T1, const G2& S2, const G2& T2)
	{
		/*
			(S1, T1) x (S2, T2) = (ML(S1, S2), ML(S1, T2), ML(T1, S2), ML(T1, T2))
		*/
		doubleMillerLoop(g[0], g[2], S1, T1, S2);
		doubleMillerLoop(g[1], g[3], S1, T1, T2);
	}
	static void tensorProduct(GT g[4], const G1& S1, const G1& T1, const G2& S2, const G2& T2)
	{
		/*
			(S1, T1) x (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
		*/
		tensorProductML(g,S1, T1, S2,T2);
		finalExp4(g, g);
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
	}
	/*
		set range for G1-DLP
	*/
	static void setRangeForG1DLP(size_t hashSize, size_t tryNum = 0)
	{
		PhashTbl_.init(P_, hashSize, tryNum);
	}
	/*
		set range for G2-DLP
	*/
	static void setRangeForG2DLP(size_t hashSize, size_t tryNum = 0)
	{
		QhashTbl_.init(Q_, hashSize, tryNum);
	}
	/*
		set range for GT-DLP
	*/
	static void setRangeForGTDLP(size_t hashSize, size_t tryNum = 0)
	{
		ePQhashTbl_.init(ePQ_, hashSize, tryNum);
	}
	/*
		set range for G1/G2/GT DLP
		decode message m for |m| <= hasSize * tryNum
		decode time = O(log(hasSize) * tryNum)
		@note if tryNum = 0 then fast but require more memory(TBD)
	*/
	static void setRangeForDLP(size_t hashSize, size_t tryNum = 0)
	{
		setRangeForG1DLP(hashSize, tryNum);
		setRangeForG2DLP(hashSize, tryNum);
		setRangeForGTDLP(hashSize, tryNum);
	}

	/*
		only one element is necessary for each G1 and G2.
		this is better than David Mandell Freeman's algorithm
	*/
	class SecretKey {
		Fr x_, y_;
		void getPowOfePQ(GT& v, const CipherTextGT& c) const
		{
			/*
				(s, t, u, v) := (e(S, S'), e(S, T'), e(T, S'), e(T, T'))
				s v^(xy) / (t^y u^x) = s (v^x / t) ^ y / u^x
				= e(P, Q)^(mm')
			*/
			GT t, u;
			GT::unitaryInv(t, c.g_[1]);
			GT::unitaryInv(u, c.g_[2]);
			GT::pow(v, c.g_[3], x_);
			v *= t;
			GT::pow(v, v, y_);
			GT::pow(u, u, x_);
			v *= u;
			v *= c.g_[0];
		}
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
		int64_t dec(const CipherTextG2& c) const
		{
			G2 R;
			G2::mul(R, c.T_, y_);
			G2::sub(R, c.S_, R);
			return QhashTbl_.log(R);
		}
		int64_t dec(const CipherTextA& c) const
		{
			return dec(c.c1_);
		}
		int64_t dec(const CipherTextGT& c) const
		{
			GT v;
			getPowOfePQ(v, c);
			return ePQhashTbl_.log(v);
//			return log(g, v);
		}
		int64_t decViaGT(const CipherTextG1& c) const
		{
			G1 R;
			G1::mul(R, c.T_, x_);
			G1::sub(R, c.S_, R);
			GT v;
			BN::pairing(v, R, Q_);
			return ePQhashTbl_.log(v);
		}
		int64_t decViaGT(const CipherTextG2& c) const
		{
			G2 R;
			G2::mul(R, c.T_, y_);
			G2::sub(R, c.S_, R);
			GT v;
			BN::pairing(v, P_, R);
			return ePQhashTbl_.log(v);
		}
		int64_t dec(const CipherText& c) const
		{
			if (c.isMultiplied()) {
				return dec(c.m_);
			} else {
				return dec(c.a_);
			}
		}
		bool isZero(const CipherTextG1& c) const
		{
			return c.isZero(x_);
		}
		bool isZero(const CipherTextG2& c) const
		{
			return c.isZero(y_);
		}
		bool isZero(const CipherTextA& c) const
		{
			return c.c1_.isZero(x_);
		}
		bool isZero(const CipherTextGT& c) const
		{
			GT v;
			getPowOfePQ(v, c);
			return v.isOne();
		}
		bool isZero(const CipherText& c) const
		{
			if (c.isMultiplied()) {
				return isZero(c.m_);
			} else {
				return isZero(c.a_);
			}
		}
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			x_.load(is, ioMode);
			y_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			const char sep = *fp::getIoSeparator(ioMode);
			x_.save(os, ioMode);
			if (sep) cybozu::writeChar(os, sep);
			y_.save(os, ioMode);
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, SecretKey& self)
		{
			self.load(is, fp::detectIoMode(Fr::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const SecretKey& self)
		{
			self.save(os, fp::detectIoMode(Fr::getIoMode(), os));
			return os;
		}
		bool operator==(const SecretKey& rhs) const
		{
			return x_ == rhs.x_ && y_ == rhs.y_;
		}
		bool operator!=(const SecretKey& rhs) const { return !operator==(rhs); }
		size_t serialize(void *buf, size_t maxBufSize) const
		{
			cybozu::MemoryOutputStream os(buf, maxBufSize);
			save(os);
			return os.getPos();
		}
		size_t deserialize(const void *buf, size_t bufSize)
		{
			cybozu::MemoryInputStream is(buf, bufSize);
			load(is);
			return is.getPos();
		}
	};

	class PublicKey {
		G1 xP_;
		G2 yQ_;
		friend class SecretKey;
		friend class PrecomputedPublicKey;
		/*
			(S, T) = (m P + r xP, rP)
		*/
		template<class G, class INT, class RG, class I>
		static void enc1(G& S, G& T, const G& /*P*/, const G& xP, const INT& m, RG& rg, const mcl::fp::WindowMethod<I>& wm)
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
		/*
			you can use INT as int64_t and Fr,
			but the return type of dec() is int64_t.
		*/
		template<class INT, class RG>
		void enc(CipherTextG1& c, const INT& m, RG& rg) const
		{
			enc1(c.S_, c.T_, P_, xP_, m, rg, PhashTbl_.getWM());
		}
		template<class INT, class RG>
		void enc(CipherTextG2& c, const INT& m, RG& rg) const
		{
			enc1(c.S_, c.T_, Q_, yQ_, m, rg, QhashTbl_.getWM());
		}
		template<class INT, class RG>
		void enc(CipherTextA& c, const INT& m, RG& rg) const
		{
			enc(c.c1_, m, rg);
			enc(c.c2_, m, rg);
		}
		template<class INT, class RG>
		void enc(CipherTextGT& c, const INT& m, RG& rg) const
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
		template<class INT, class RG>
		void enc(CipherText& c, const INT& m, RG& rg, bool multiplied = false) const
		{
			c.isMultiplied_ = multiplied;
			if (multiplied) {
				enc(c.m_, m, rg);
			} else {
				enc(c.a_, m, rg);
			}
		}
		template<class INT>
		void enc(CipherTextG1& c, const INT& m) const { return enc(c, m, local::g_rg); }
		template<class INT>
		void enc(CipherTextG2& c, const INT& m) const { return enc(c, m, local::g_rg); }
		template<class INT>
		void enc(CipherTextA& c, const INT& m) const { return enc(c, m, local::g_rg); }
		template<class INT>
		void enc(CipherTextGT& c, const INT& m) const { return enc(c, m, local::g_rg); }
		template<class INT>
		void enc(CipherText& c, const INT& m, bool multiplied = false) const { return enc(c, m, local::g_rg, multiplied); }
		/*
			convert from CipherTextG1 to CipherTextGT
		*/
		void convert(CipherTextGT& cm, const CipherTextG1& c1) const
		{
			/*
				Enc(1) = (S, T) = (Q + r yQ, rQ) = (Q, 0) if r = 0
				cm = c1 * (Q, 0) = (S, T) * (Q, 0) = (e(S, Q), 1, e(T, Q), 1)
			*/
			BN::precomputedMillerLoop(cm.g_[0], c1.S_, Qcoeff_);
			BN::finalExp(cm.g_[0], cm.g_[0]);
			BN::precomputedMillerLoop(cm.g_[2], c1.T_, Qcoeff_);
			BN::finalExp(cm.g_[2], cm.g_[2]);

			cm.g_[1] = 1;
			cm.g_[3] = 1;
		}
		/*
			convert from CipherTextG2 to CipherTextGT
		*/
		void convert(CipherTextGT& cm, const CipherTextG2& c2) const
		{
			/*
				Enc(1) = (S, T) = (P + r xP, rP) = (P, 0) if r = 0
				cm = (P, 0) * c2 = (e(P, S), e(P, T), 1, 1)
			*/
			G1 zero; zero.clear();
			tensorProduct(cm.g_, P_, zero, c2.S_, c2.T_);
		}
		void convert(CipherTextGT& cm, const CipherTextA& ca) const
		{
			convert(cm, ca.c1_);
		}
		void convert(CipherText& cm, const CipherText& ca) const
		{
			if (ca.isMultiplied()) throw cybozu::Exception("she:PublicKey:convertCipherText:already isMultiplied");
			cm.isMultiplied_ = true;
			convert(cm.m_, ca.a_);
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
		void reRand(CipherTextGT& c, RG& rg) const
		{
#if 1 // for circuit security : 3.58Mclk -> 5.4Mclk
			CipherTextGT c0;
			enc(c0, 0, rg);
			CipherTextGT::add(c, c, c0);
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
		void reRand(CipherTextGT& c) const { reRand(c, local::g_rg); }
		void reRand(CipherText& c) const { reRand(c, local::g_rg); }

		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			xP_.load(is, ioMode);
			yQ_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			const char sep = *fp::getIoSeparator(ioMode);
			xP_.save(os, ioMode);
			if (sep) cybozu::writeChar(os, sep);
			yQ_.save(os, ioMode);
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, PublicKey& self)
		{
			self.load(is, fp::detectIoMode(G1::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const PublicKey& self)
		{
			self.save(os, fp::detectIoMode(G1::getIoMode(), os));
			return os;
		}
		bool operator==(const PublicKey& rhs) const
		{
			return xP_ == rhs.xP_ && yQ_ == rhs.yQ_;
		}
		bool operator!=(const PublicKey& rhs) const { return !operator==(rhs); }
		size_t serialize(void *buf, size_t maxBufSize) const
		{
			cybozu::MemoryOutputStream os(buf, maxBufSize);
			save(os);
			return os.getPos();
		}
		size_t deserialize(const void *buf, size_t bufSize)
		{
			cybozu::MemoryInputStream is(buf, bufSize);
			load(is);
			return is.getPos();
		}
	};

	class PrecomputedPublicKey {
		typedef local::InterfaceForHashTable<GT, false> GTasEC;
		typedef mcl::fp::WindowMethod<GTasEC> GTwin;
		GT exPQ_;
		GT eyPQ_;
		GT exyPQ_;
		GTwin exPQwm_;
		GTwin eyPQwm_;
		GTwin exyPQwm_;
		mcl::fp::WindowMethod<G1> xPwm_;
		mcl::fp::WindowMethod<G2> yQwm_;
		template<class T>
		void mulByWindowMethod(GT& x, const GTwin& wm, const T& y) const
		{
			wm.mul(static_cast<GTasEC&>(x), y);
		}
	public:
		void init(const PublicKey& pub)
		{
			BN::pairing(exPQ_, pub.xP_, Q_);
			BN::pairing(eyPQ_, P_, pub.yQ_);
			BN::pairing(exyPQ_, pub.xP_, pub.yQ_);
			const size_t bitSize = Fr::getBitSize();
			exPQwm_.init(static_cast<const GTasEC&>(exPQ_), bitSize, local::winSize);
			eyPQwm_.init(static_cast<const GTasEC&>(eyPQ_), bitSize, local::winSize);
			exyPQwm_.init(static_cast<const GTasEC&>(exyPQ_), bitSize, local::winSize);
			xPwm_.init(pub.xP_, bitSize, local::winSize);
			yQwm_.init(pub.yQ_, bitSize, local::winSize);
		}
		/*
			(S, T) = (m P + r xP, rP)
		*/
		template<class G, class RG, class I>
		void enc1(G& S, G& T, int64_t m, RG& rg, const mcl::fp::WindowMethod<I>& Pwm, const mcl::fp::WindowMethod<G>& xPwm) const
		{
			Fr r;
			r.setRand(rg);
			Pwm.mul(static_cast<I&>(T), r);
			xPwm.mul(S, r);
			if (m == 0) return;
			G C;
			Pwm.mul(static_cast<I&>(C), m);
			S += C;
		}
		template<class RG>
		void enc(CipherTextG1& c, int64_t m, RG& rg) const
		{
			enc1(c.S_, c.T_, m, rg, PhashTbl_.getWM(), xPwm_);
		}
		template<class RG>
		void enc(CipherTextG2& c, int64_t m, RG& rg) const
		{
			enc1(c.S_, c.T_, m, rg, QhashTbl_.getWM(), yQwm_);
		}
		template<class RG>
		void enc(CipherTextGT& c, int64_t m, RG& rg) const
		{
			/*
				(s, t, u, v) = (e^m e^(xya), (e^x)^b, (e^y)^c, e^(b + c - a))
			*/
			Fr ra, rb, rc;
			ra.setRand(rg);
			rb.setRand(rg);
			rc.setRand(rg);
			GT t;
			ePQhashTbl_.mulByWindowMethod(c.g_[0], m); // e^m
			mulByWindowMethod(t, exyPQwm_, ra); // (e^xy)^a
			c.g_[0] *= t;
			mulByWindowMethod(c.g_[1], exPQwm_, rb); // (e^x)^b
			mulByWindowMethod(c.g_[2], eyPQwm_, rc); // (e^y)^c
			rb = rb + rc - ra;
			ePQhashTbl_.mulByWindowMethod(c.g_[3], rb);
		}
		template<class CT, class RG>
		void reRandT(CT& c, RG& rg) const
		{
			CT c0;
			enc(c0, 0, rg);
			CT::add(c, c, c0);
		}
		template<class RG> void reRand(CipherTextG1& c, RG& rg) const { reRandT(c, rg); }
		template<class RG> void reRand(CipherTextG2& c, RG& rg) const { reRandT(c, rg); }
		template<class RG> void reRand(CipherTextGT& c, RG& rg) const { reRandT(c, rg); }
		void enc(CipherTextG1& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextG2& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void enc(CipherTextGT& c, int64_t m) const { return enc(c, m, local::g_rg); }
		void reRand(CipherTextG1& c) const { reRand(c, local::g_rg); }
		void reRand(CipherTextG2& c) const { reRand(c, local::g_rg); }
		void reRand(CipherTextGT& c) const { reRand(c, local::g_rg); }
	};

	class CipherTextA {
		CipherTextG1 c1_;
		CipherTextG2 c2_;
		friend class SecretKey;
		friend class PublicKey;
		friend class CipherTextGT;
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
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			c1_.load(is, ioMode);
			c2_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			const char sep = *fp::getIoSeparator(ioMode);
			c1_.save(os, ioMode);
			if (sep) cybozu::writeChar(os, sep);
			c2_.save(os, ioMode);
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextA& self)
		{
			self.load(is, fp::detectIoMode(G1::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextA& self)
		{
			self.save(os, fp::detectIoMode(G1::getIoMode(), os));
			return os;
		}
		bool operator==(const CipherTextA& rhs) const
		{
			return c1_ == rhs.c1_ && c2_ == rhs.c2_;
		}
		bool operator!=(const CipherTextA& rhs) const { return !operator==(rhs); }
	};

	class CipherTextGT {
		GT g_[4];
		friend class SecretKey;
		friend class PublicKey;
		friend class PrecomputedPublicKey;
		friend class CipherTextA;
	public:
		void clear()
		{
			for (int i = 0; i < 4; i++) {
				g_[i].setOne();
			}
		}
		static void add(CipherTextGT& z, const CipherTextGT& x, const CipherTextGT& y)
		{
			/*
				(g[i]) + (g'[i]) = (g[i] * g'[i])
			*/
			for (int i = 0; i < 4; i++) {
				GT::mul(z.g_[i], x.g_[i], y.g_[i]);
			}
		}
		static void sub(CipherTextGT& z, const CipherTextGT& x, const CipherTextGT& y)
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
		static void mulML(CipherTextGT& z, const CipherTextG1& x, const CipherTextG2& y)
		{
			/*
				(S1, T1) * (S2, T2) = (ML(S1, S2), ML(S1, T2), ML(T1, S2), ML(T1, T2))
			*/
			tensorProductML(z.g_, x.S_, x.T_, y.S_, y.T_);
		}
		static void finalExp(CipherTextGT& y, const CipherTextGT& x)
		{
			finalExp4(y.g_, x.g_);
		}
		/*
			mul(x, y) = mulML(x, y) + finalExp
			mul(c11, c12) + mul(c21, c22)
			= finalExp(mulML(c11, c12) + mulML(c21, c22)),
			then one finalExp can be reduced
		*/
		static void mul(CipherTextGT& z, const CipherTextG1& x, const CipherTextG2& y)
		{
			/*
				(S1, T1) * (S2, T2) = (e(S1, S2), e(S1, T2), e(T1, S2), e(T1, T2))
			*/
			mulML(z, x, y);
			finalExp(z, z);
		}
		static void mul(CipherTextGT& z, const CipherTextA& x, const CipherTextA& y)
		{
			mul(z, x.c1_, y.c2_);
		}
		static void mul(CipherTextGT& z, const CipherTextGT& x, int64_t y)
		{
			for (int i = 0; i < 4; i++) {
				GT::pow(z.g_[i], x.g_[i], y);
			}
		}
		void add(const CipherTextGT& c) { add(*this, *this, c); }
		void sub(const CipherTextGT& c) { sub(*this, *this, c); }
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			for (int i = 0; i < 4; i++) {
				g_[i].load(is, ioMode);
			}
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			const char sep = *fp::getIoSeparator(ioMode);
			g_[0].save(os, ioMode);
			for (int i = 1; i < 4; i++) {
				if (sep) cybozu::writeChar(os, sep);
				g_[i].save(os, ioMode);
			}
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherTextGT& self)
		{
			self.load(is, fp::detectIoMode(G1::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherTextGT& self)
		{
			self.save(os, fp::detectIoMode(G1::getIoMode(), os));
			return os;
		}
		bool operator==(const CipherTextGT& rhs) const
		{
			for (int i = 0; i < 4; i++) {
				if (g_[i] != rhs.g_[i]) return false;
			}
			return true;
		}
		bool operator!=(const CipherTextGT& rhs) const { return !operator==(rhs); }
		size_t serialize(void *buf, size_t maxBufSize) const
		{
			cybozu::MemoryOutputStream os(buf, maxBufSize);
			save(os);
			return os.getPos();
		}
		size_t deserialize(const void *buf, size_t bufSize)
		{
			cybozu::MemoryInputStream is(buf, bufSize);
			load(is);
			return is.getPos();
		}
	};

	class CipherText {
		bool isMultiplied_;
		CipherTextA a_;
		CipherTextGT m_;
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
				CipherTextGT::add(z.m_, x.m_, y.m_);
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
				CipherTextGT::sub(z.m_, x.m_, y.m_);
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
			CipherTextGT::mul(z.m_, x.a_, y.a_);
		}
		static void mul(CipherText& z, const CipherText& x, int64_t y)
		{
			if (x.isMultiplied()) {
				CipherTextGT::mul(z.m_, x.m_, y);
			} else {
				CipherTextA::mul(z.a_, x.a_, y);
			}
		}
		void add(const CipherText& c) { add(*this, *this, c); }
		void sub(const CipherText& c) { sub(*this, *this, c); }
		void mul(const CipherText& c) { mul(*this, *this, c); }
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			cybozu::load(isMultiplied_, is);
			if (isMultiplied()) {
				m_.load(is, ioMode);
			} else {
				a_.load(is, ioMode);
			}
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			cybozu::save(os, isMultiplied_);
			if (isMultiplied()) {
				m_.save(os, ioMode);
			} else {
				a_.save(os, ioMode);
			}
		}
		void getStr(std::string& str, int ioMode = 0) const
		{
			str.clear();
			cybozu::StringOutputStream os(str);
			save(os, ioMode);
		}
		void setStr(const std::string& str, int ioMode = 0)
		{
			cybozu::StringInputStream is(str);
			load(is, ioMode);
		}
		std::string getStr(int ioMode = 0) const
		{
			std::string str;
			getStr(str, ioMode);
			return str;
		}
		friend std::istream& operator>>(std::istream& is, CipherText& self)
		{
			self.load(is, fp::detectIoMode(G1::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const CipherText& self)
		{
			self.save(os, fp::detectIoMode(G1::getIoMode(), os));
			return os;
		}
		bool operator==(const CipherTextGT& rhs) const
		{
			if (isMultiplied() != rhs.isMultiplied()) return false;
			if (isMultiplied()) {
				return m_ == rhs.m_;
			}
			return a_ == rhs.a_;
		}
		bool operator!=(const CipherTextGT& rhs) const { return !operator==(rhs); }
	};
};

template<class BN, class Fr> typename BN::G1 SHET<BN, Fr>::P_;
template<class BN, class Fr> typename BN::G2 SHET<BN, Fr>::Q_;
template<class BN, class Fr> typename BN::Fp12 SHET<BN, Fr>::ePQ_;
template<class BN, class Fr> std::vector<bn_current::Fp6> SHET<BN, Fr>::Qcoeff_;
template<class BN, class Fr> local::HashTable<typename BN::G1> SHET<BN, Fr>::PhashTbl_;
template<class BN, class Fr> local::HashTable<typename BN::G2> SHET<BN, Fr>::QhashTbl_;
template<class BN, class Fr> local::HashTable<typename BN::Fp12, false> SHET<BN, Fr>::ePQhashTbl_;
typedef mcl::she::SHET<bn_current::BN, bn_current::Fr> SHE;
typedef SHE::SecretKey SecretKey;
typedef SHE::PublicKey PublicKey;
typedef SHE::PrecomputedPublicKey PrecomputedPublicKey;
typedef SHE::CipherTextG1 CipherTextG1;
typedef SHE::CipherTextG2 CipherTextG2;
typedef SHE::CipherTextGT CipherTextGT;
typedef SHE::CipherTextA CipherTextA;
typedef CipherTextGT CipherTextGM; // old class
typedef SHE::CipherText CipherText;

} } // mcl::she

