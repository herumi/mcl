#pragma once
/**
	@file
	@brief lifted-ElGamal encryption
	Copyright (c) 2014, National Institute of Advanced Industrial
	Science and Technology All rights reserved.
	This source file is subject to BSD 3-Clause license.
*/
#include <string>
#include <sstream>
#include <cybozu/unordered_map.hpp>
#include <cybozu/bitvector.hpp>
#ifndef CYBOZU_UNORDERED_MAP_STD
#include <map>
#endif
#include <cybozu/exception.hpp>
#include <mcl/tagmultigr.hpp>
#include <mcl/power_window.hpp>

namespace mcl {

template<class _G, class Zn>
struct ElgamalT {
	typedef _G G;
	typedef TagMultiGr<G> TagG;
	struct CipherText {
		typedef _G G;
		G c1;
		G c2;
		/*
			(c1, c2) = (0, 0) is trivial valid ciphertext for m = 0
		*/
		void clear()
		{
			TagG::init(c1);
			TagG::init(c2);
		}
		/*
			add encoded message with encoded message
			input : this = Enc(m1), c = Enc(m2)
			output : this = Enc(m1 + m2)
		*/
		void add(const CipherText& c)
		{
			TagG::mul(c1, c1, c.c1);
			TagG::mul(c2, c2, c.c2);
		}
		/*
			mul by x
			input : this = Enc(m), x
			output : this = Enc(m x)
		*/
		template<class N>
		void mul(const N& x)
		{
			G::power(c1, c1, x);
			G::power(c2, c2, x);
		}
		/*
			negative encoded message
			input : this = Enc(m)
			output : this = Enc(-m)
		*/
		void neg()
		{
			TagG::inv(c1, c1);
			TagG::inv(c2, c2);
		}
		std::string toStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:CipherText:toStr");
			return os.str();
		}
		void fromStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:CipherText:fromStr") << str;
		}
		friend inline std::ostream& operator<<(std::ostream& os, const CipherText& self)
		{
			std::ios_base::fmtflags flags = os.flags();
			os << std::hex << self.c1 << ' ' << self.c2;
			os.flags(flags);
			return os;
		}
		friend inline std::istream& operator>>(std::istream& is, CipherText& self)
		{
			std::ios_base::fmtflags flags = is.flags();
			is >> std::hex >> self.c1 >> self.c2;
			is.flags(flags);
			return is;
		}
		void appendToBitVec(cybozu::BitVector& bv) const
		{
			c1.appendToBitVec(bv);
			c2.appendToBitVec(bv);
		}
		void fromBitVec(const cybozu::BitVector& bv)
		{
			size_t bitLen = G::getBitVecSize();
			cybozu::BitVector t;
			bv.extract(t, 0, bitLen);
			c1.fromBitVec(t);
			bv.extract(t, bitLen, bitLen);
			c2.fromBitVec(t);
		}
		static inline size_t getBitVecSize()
		{
			return G::getBitVecSize() * 2;
		}
	};
	/*
		Zero Knowledge Proof
		cipher text with ZKP to ensure m = 0 or 1
	*/
	struct Zkp {
		typedef _G G;
		Zn c0, c1, s0, s1;
		std::string toStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:Zkp:toStr");
			return os.str();
		}
		void fromStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:Zkp:fromStr") << str;
		}
		friend inline std::ostream& operator<<(std::ostream& os, const Zkp& self)
		{
			std::ios_base::fmtflags flags = os.flags();
			os << std::hex << self.c0 << ' ' << self.c1 << ' ' << self.s0 << ' ' << self.s1;
			os.flags(flags);
			return os;
		}
		friend inline std::istream& operator>>(std::istream& is, Zkp& self)
		{
			std::ios_base::fmtflags flags = is.flags();
			is >> std::hex >> self.c0 >> self.c1 >> self.s0 >> self.s1;
			is.flags(flags);
			return is;
		}
	};

	class PublicKey {
		typedef _G G;
		size_t bitLen;
		G f;
		G g;
		G h;
		bool enablePowerWindow_;
		mcl::WindowMethod<G> powf;
		mcl::WindowMethod<G> powg;
		mcl::WindowMethod<G> powh;
		template<class N>
		void powerSub(G& z, const G& x, const N& n, const mcl::WindowMethod<G>& pw) const
		{
			if (enablePowerWindow_) {
				pw.power(z, n);
			} else {
				G::power(z, x, n);
			}
		}
		template<class N>
		void powerF(G& z, const N& n) const { powerSub(z, f, n, powf); }
		template<class N>
		void powerG(G& z, const N& n) const { powerSub(z, g, n, powg); }
		template<class N>
		void powerH(G& z, const N& n) const { powerSub(z, h, n, powh); }
	public:
		PublicKey()
			: bitLen(0)
			, enablePowerWindow_(false)
		{
		}
		void enablePowerWindow(size_t winSize = 10)
		{
			powf.init(f, bitLen, winSize);
			powg.init(g, bitLen, winSize);
			powh.init(h, bitLen, winSize);
			enablePowerWindow_ = true;
		}
		const G& getF() const { return f; }
		void init(size_t bitLen, const G& f, const G& g, const G& h)
		{
			this->bitLen = bitLen;
			this->f = f;
			this->g = g;
			this->h = h;
			enablePowerWindow_ = false;
		}
		/*
			encode message
			input : m
			output : c = (c1, c2) = (g^u, h^u f^m)
		*/
		template<class RG>
		void enc(CipherText& c, const Zn& m, RG& rg) const
		{
			Zn u;
			u.setRand(rg);
			powerG(c.c1, u);
			powerH(c.c2, u);
			G t;
			powerF(t, m);
			TagG::mul(c.c2, c.c2, t);
		}
		/*
			encode message
			input : m = 0 or 1
			output : c (c1, c2), zkp
		*/
		template<class RG, class Hash>
		void encWithZkp(CipherText& c, Zkp& zkp, int m, Hash& hash, RG& rg) const
		{
			if (m != 0 && m != 1) {
				throw cybozu::Exception("elgamal:PublicKey:encWithZkp") << m;
			}
			Zn u;
			u.setRand(rg);
			powerG(c.c1, u);
			powerH(c.c2, u);
			if (m) {
				TagG::mul(c.c2, c.c2, f);
				Zn r1;
				r1.setRand(rg);
				zkp.c0.setRand(rg);
				zkp.s0.setRand(rg);
				G R01, R02, R11, R12;
				G t1, t2;
				powerG(t1, zkp.s0);
				G::power(t2, c.c1, zkp.c0);
				TagG::div(R01, t1, t2);
				powerH(t1, zkp.s0);
				G::power(t2, c.c2, zkp.c0);
				TagG::div(R02, t1, t2);
				powerG(R11, r1);
				powerH(R12, r1);
				std::ostringstream os;
				os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
				hash.update(os.str());
				const std::string digest = hash.digest();
				Zn cc;
				cc.setRaw(digest.c_str(), digest.size());
				zkp.c1 = cc - zkp.c0;
				zkp.s1 = r1 + zkp.c1 * u;
			} else {
				Zn r0;
				r0.setRand(rg);
				zkp.c1.setRand(rg);
				zkp.s1.setRand(rg);
				G R01, R02, R11, R12;
				powerG(R01, r0);
				powerH(R02, r0);
				G t1, t2;
				powerG(t1, zkp.s1);
				G::power(t2, c.c1, zkp.c1);
				TagG::div(R11, t1, t2);
				powerH(t1, zkp.s1);
				TagG::div(t2, c.c2, f);
				G::power(t2, t2, zkp.c1);
				TagG::div(R12, t1, t2);
				std::ostringstream os;
				os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
				hash.update(os.str());
				const std::string digest = hash.digest();
				Zn c;
				c.setRaw(digest.c_str(), digest.size());
				zkp.c0 = c - zkp.c1;
				zkp.s0 = r0 + zkp.c0 * u;
			}
		}
		/*
			verify cipher text with ZKP
		*/
		template<class Hash>
		bool verify(const CipherText& c, const Zkp& zkp, Hash& hash) const
		{
			G R01, R02, R11, R12;
			G t1, t2;
			powerG(t1, zkp.s0);
			G::power(t2, c.c1, zkp.c0);
			TagG::div(R01, t1, t2);
			powerH(t1, zkp.s0);
			G::power(t2, c.c2, zkp.c0);
			TagG::div(R02, t1, t2);
			powerG(t1, zkp.s1);
			G::power(t2, c.c1, zkp.c1);
			TagG::div(R11, t1, t2);
			powerH(t1, zkp.s1);
			TagG::div(t2, c.c2, f);
			G::power(t2, t2, zkp.c1);
			TagG::div(R12, t1, t2);
			std::ostringstream os;
			os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
			hash.update(os.str());
			const std::string digest = hash.digest();
			Zn cc;
			cc.setRaw(digest.c_str(), digest.size());
			return cc == zkp.c0 + zkp.c1;
		}
		/*
			rerandomize encoded message
			input : c = (c1, c2)
			output : c = (c1 g^v, c2 h^v)
		*/
		template<class RG>
		void rerandomize(CipherText& c, RG& rg) const
		{
			Zn v;
			v.setRand(rg);
			G t;
			powerG(t, v);
			TagG::mul(c.c1, c.c1, t);
			powerH(t, v);
			TagG::mul(c.c2, c.c2, t);
		}
		/*
			add encoded message with plain message
			input : c = Enc(m1) = (c1, c2), m2
			ouput : c = Enc(m1 + m2) = (c1, c2 f^m2)
		*/
		template<class N>
		void add(CipherText& c, const N& m) const
		{
			G fm;
			powerF(fm, m);
			TagG::mul(c.c2, c.c2, fm);
		}
		std::string toStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:PublicKey:toStr");
			return os.str();
		}
		void fromStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:PublicKey:fromStr") << str;
		}
		friend inline std::ostream& operator<<(std::ostream& os, const PublicKey& self)
		{
			std::ios_base::fmtflags flags = os.flags();
			os << std::dec << self.bitLen << ' ' << std::hex << self.f << ' ' << self.g << ' ' << self.h;
			os.flags(flags);
			return os;
		}
		friend inline std::istream& operator>>(std::istream& is, PublicKey& self)
		{
			std::ios_base::fmtflags flags = is.flags();
			size_t bitLen;
			G f, g, h;
			is >> std::dec >> bitLen >> std::hex >> f >> g >> h;
			is.flags(flags);
			self.init(bitLen, f, g, h);
			return is;
		}
	};

	class PrivateKey {
		PublicKey pub;
		Zn z;
	public:
		typedef _G G;
		/*
			init
			input : f
			output : (g, h, z)
			G = <f>
			g in G
			h = g^z
		*/
		template<class RG>
		void init(const G& f, size_t bitLen, RG& rg)
		{
			G g, h;
			z.setRand(rg);
			G::power(g, f, z);
			z.setRand(rg);
			G::power(h, g, z);
			pub.init(bitLen, f, g, h);
		}
		const PublicKey& getPublicKey() const { return pub; }
		/*
			decode message
			input : c = (c1, c2)
			output : m
			M = c2 / c1^z
			find m such that M = f^m and |m| < limit
			@memo 7sec@core i3 for m = 1e6
		*/
		void dec(Zn& m, const CipherText& c, int limit = 100000) const
		{
			const G& f = pub.getF();
			G c1z;
			G::power(c1z, c.c1, z);
			if (c1z == c.c2) {
				m = 0;
				return;
			}
			G t1(c1z);
			G t2(c.c2);
			for (int i = 1; i < limit; i++) {
				TagG::mul(t1, t1, f);
				if (t1 == c.c2) {
					m = i;
					return;
				}
				TagG::mul(t2, t2, f);
				if (t2 == c1z) {
					m = -i;
					return;
				}
			}
			throw cybozu::Exception("elgamal:PrivateKey:dec:overflow");
		}
		/*
			powfm = c2 / c1^z = f^m
		*/
		void getPowerf(G& powfm, const CipherText& c) const
		{
			G c1z;
			G::power(c1z, c.c1, z);
			TagG::div(powfm, c.c2, c1z);
		}
		/*
			check whether c is encrypted zero message
		*/
		bool isZeroMessage(const CipherText& c) const
		{
			G c1z;
			G::power(c1z, c.c1, z);
			return c.c2 == c1z;
		}
		std::string toStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:PrivateKey:toStr");
			return os.str();
		}
		void fromStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:PrivateKey:fromStr") << str;
		}
		friend inline std::ostream& operator<<(std::ostream& os, const PrivateKey& self)
		{
			std::ios_base::fmtflags flags = os.flags();
			os << self.pub << ' ' << std::hex << self.z;
			os.flags(flags);
			return os;
		}
		friend inline std::istream& operator>>(std::istream& is, PrivateKey& self)
		{
			std::ios_base::fmtflags flags = is.flags();
			is >> self.pub  >> std::hex >> self.z;
			is.flags(flags);
			return is;
		}
	};
	/*
		create table f^i for i in [rangeMin, rangeMax]
	*/
	struct PowerCache {
		typedef _G G;
#if (CYBOZU_CPP_VERSION > CYBOZU_CPP_VERSION_CP03)
		typedef CYBOZU_NAMESPACE_STD::unordered_map<G, int> Cache;
#else
		typedef std::map<G, int> Cache;
#endif
		Cache cache;
		void init(const G& f, int rangeMin, int rangeMax)
		{
			if (rangeMin > rangeMax) throw cybozu::Exception("mcl:ElgamalT:PowerCache:bad range") << rangeMin << rangeMax;
			G x;
			x.clear();
			cache[x] = 0;
			for (int i = 1; i <= rangeMax; i++) {
				TagG::mul(x, x, f);
				cache[x] = i;
			}
			G nf;
			TagG::inv(nf, f);
			x.clear();
			for (int i = -1; i >= rangeMin; i--) {
				TagG::mul(x, x, nf);
				cache[x] = i;
			}
		}
		/*
			return m such that f^m = g
		*/
		int getExponent(const G& g) const
		{
			typename Cache::const_iterator i = cache.find(g);
			if (i == cache.end()) throw cybozu::Exception("Elgamal:PowerCache:getExponent:not found") << g;
			return i->second;
		}
	};
};

} // mcl
