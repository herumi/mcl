#pragma once
/**
	@file
	@brief lifted-ElGamal encryption
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

	original:
	Copyright (c) 2014, National Institute of Advanced Industrial
	Science and Technology All rights reserved.
	This source file is subject to BSD 3-Clause license.
*/
#include <string>
#include <sstream>
#include <cybozu/unordered_map.hpp>
#ifndef CYBOZU_UNORDERED_MAP_STD
#include <map>
#endif
#include <cybozu/exception.hpp>
#include <mcl/window_method.hpp>

namespace mcl {

template<class _Ec, class Zn>
struct ElgamalT {
	typedef _Ec Ec;
	struct CipherText {
		Ec c1;
		Ec c2;
		/*
			(c1, c2) = (0, 0) is trivial valid ciphertext for m = 0
		*/
		void clear()
		{
			c1.clear();
			c2.clear();
		}
		/*
			add encoded message with encoded message
			input : this = Enc(m1), c = Enc(m2)
			output : this = Enc(m1 + m2)
		*/
		void add(const CipherText& c)
		{
			Ec::add(c1, c1, c.c1);
			Ec::add(c2, c2, c.c2);
		}
		/*
			mul by x
			input : this = Enc(m), x
			output : this = Enc(m x)
		*/
		template<class N>
		void mul(const N& x)
		{
			Ec::mul(c1, c1, x);
			Ec::mul(c2, c2, x);
		}
		/*
			negative encoded message
			input : this = Enc(m)
			output : this = Enc(-m)
		*/
		void neg()
		{
			Ec::neg(c1, c1);
			Ec::neg(c2, c2);
		}
		std::string getStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:CipherText:getStr");
			return os.str();
		}
		void setStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:CipherText:setStr") << str;
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
	};
	/*
		Zero Knowledge Proof
		cipher text with ZKP to ensure m = 0 or 1
	*/
	struct Zkp {
		Zn c0, c1, s0, s1;
		std::string getStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:Zkp:getStr");
			return os.str();
		}
		void setStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:Zkp:setStr") << str;
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
		size_t bitSize;
		Ec f;
		Ec g;
		Ec h;
		bool enableWindowMethod_;
		fp::WindowMethod<Ec> wm_f;
		fp::WindowMethod<Ec> wm_g;
		fp::WindowMethod<Ec> wm_h;
		template<class N>
		void mulDispatch(Ec& z, const Ec& x, const N& n, const fp::WindowMethod<Ec>& pw) const
		{
			if (enableWindowMethod_) {
				pw.mul(z, n);
			} else {
				Ec::mul(z, x, n);
			}
		}
		template<class N>
		void mulF(Ec& z, const N& n) const { mulDispatch(z, f, n, wm_f); }
		template<class N>
		void mulG(Ec& z, const N& n) const { mulDispatch(z, g, n, wm_g); }
		template<class N>
		void mulH(Ec& z, const N& n) const { mulDispatch(z, h, n, wm_h); }
	public:
		PublicKey()
			: bitSize(0)
			, enableWindowMethod_(false)
		{
		}
		void enableWindowMethod(size_t winSize = 10)
		{
			wm_f.init(f, bitSize, winSize);
			wm_g.init(g, bitSize, winSize);
			wm_h.init(h, bitSize, winSize);
			enableWindowMethod_ = true;
		}
		const Ec& getF() const { return f; }
		void init(size_t bitSize, const Ec& f, const Ec& g, const Ec& h)
		{
			this->bitSize = bitSize;
			this->f = f;
			this->g = g;
			this->h = h;
			enableWindowMethod_ = false;
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
			mulG(c.c1, u);
			mulH(c.c2, u);
			Ec t;
			mulF(t, m);
			Ec::add(c.c2, c.c2, t);
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
			mulG(c.c1, u);
			mulH(c.c2, u);
			if (m) {
				Ec::add(c.c2, c.c2, f);
				Zn r1;
				r1.setRand(rg);
				zkp.c0.setRand(rg);
				zkp.s0.setRand(rg);
				Ec R01, R02, R11, R12;
				Ec t1, t2;
				mulG(t1, zkp.s0);
				Ec::mul(t2, c.c1, zkp.c0);
				Ec::sub(R01, t1, t2);
				mulH(t1, zkp.s0);
				Ec::mul(t2, c.c2, zkp.c0);
				Ec::sub(R02, t1, t2);
				mulG(R11, r1);
				mulH(R12, r1);
				std::ostringstream os;
				os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
				hash.update(os.str());
				const std::string digest = hash.digest();
				Zn cc;
				cc.setArrayMask(digest.c_str(), digest.size());
				zkp.c1 = cc - zkp.c0;
				zkp.s1 = r1 + zkp.c1 * u;
			} else {
				Zn r0;
				r0.setRand(rg);
				zkp.c1.setRand(rg);
				zkp.s1.setRand(rg);
				Ec R01, R02, R11, R12;
				mulG(R01, r0);
				mulH(R02, r0);
				Ec t1, t2;
				mulG(t1, zkp.s1);
				Ec::mul(t2, c.c1, zkp.c1);
				Ec::sub(R11, t1, t2);
				mulH(t1, zkp.s1);
				Ec::sub(t2, c.c2, f);
				Ec::mul(t2, t2, zkp.c1);
				Ec::sub(R12, t1, t2);
				std::ostringstream os;
				os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
				hash.update(os.str());
				const std::string digest = hash.digest();
				Zn c;
				c.setArrayMask(digest.c_str(), digest.size());
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
			Ec R01, R02, R11, R12;
			Ec t1, t2;
			mulG(t1, zkp.s0);
			Ec::mul(t2, c.c1, zkp.c0);
			Ec::sub(R01, t1, t2);
			mulH(t1, zkp.s0);
			Ec::mul(t2, c.c2, zkp.c0);
			Ec::sub(R02, t1, t2);
			mulG(t1, zkp.s1);
			Ec::mul(t2, c.c1, zkp.c1);
			Ec::sub(R11, t1, t2);
			mulH(t1, zkp.s1);
			Ec::sub(t2, c.c2, f);
			Ec::mul(t2, t2, zkp.c1);
			Ec::sub(R12, t1, t2);
			std::ostringstream os;
			os << R01 << R02 << R11 << R12 << c.c1 << c.c2 << f << g << h;
			hash.update(os.str());
			const std::string digest = hash.digest();
			Zn cc;
			cc.setArrayMask(digest.c_str(), digest.size());
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
			Ec t;
			mulG(t, v);
			Ec::add(c.c1, c.c1, t);
			mulH(t, v);
			Ec::add(c.c2, c.c2, t);
		}
		/*
			add encoded message with plain message
			input : c = Enc(m1) = (c1, c2), m2
			ouput : c = Enc(m1 + m2) = (c1, c2 f^m2)
		*/
		template<class N>
		void add(CipherText& c, const N& m) const
		{
			Ec fm;
			mulF(fm, m);
			Ec::add(c.c2, c.c2, fm);
		}
		std::string getStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:PublicKey:getStr");
			return os.str();
		}
		void setStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:PublicKey:setStr") << str;
		}
		friend inline std::ostream& operator<<(std::ostream& os, const PublicKey& self)
		{
			std::ios_base::fmtflags flags = os.flags();
			os << std::dec << self.bitSize << ' ' << std::hex << self.f << ' ' << self.g << ' ' << self.h;
			os.flags(flags);
			return os;
		}
		friend inline std::istream& operator>>(std::istream& is, PublicKey& self)
		{
			std::ios_base::fmtflags flags = is.flags();
			size_t bitSize;
			Ec f, g, h;
			is >> std::dec >> bitSize >> std::hex >> f >> g >> h;
			is.flags(flags);
			self.init(bitSize, f, g, h);
			return is;
		}
	};

	class PrivateKey {
		PublicKey pub;
		Zn z;
	public:
		/*
			init
			input : f
			output : (g, h, z)
			Ec = <f>
			g in Ec
			h = g^z
		*/
		template<class RG>
		void init(const Ec& f, size_t bitSize, RG& rg)
		{
			Ec g, h;
			z.setRand(rg);
			Ec::mul(g, f, z);
			z.setRand(rg);
			Ec::mul(h, g, z);
			pub.init(bitSize, f, g, h);
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
			const Ec& f = pub.getF();
			Ec c1z;
			Ec::mul(c1z, c.c1, z);
			if (c1z == c.c2) {
				m = 0;
				return;
			}
			Ec t1(c1z);
			Ec t2(c.c2);
			for (int i = 1; i < limit; i++) {
				Ec::add(t1, t1, f);
				if (t1 == c.c2) {
					m = i;
					return;
				}
				Ec::add(t2, t2, f);
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
		void getPowerf(Ec& powfm, const CipherText& c) const
		{
			Ec c1z;
			Ec::mul(c1z, c.c1, z);
			Ec::sub(powfm, c.c2, c1z);
		}
		/*
			check whether c is encrypted zero message
		*/
		bool isZeroMessage(const CipherText& c) const
		{
			Ec c1z;
			Ec::mul(c1z, c.c1, z);
			return c.c2 == c1z;
		}
		std::string getStr() const
		{
			std::ostringstream os;
			if (!(os << (*this))) throw cybozu::Exception("ElgamalT:PrivateKey:getStr");
			return os.str();
		}
		void setStr(const std::string& str)
		{
			std::istringstream is(str);
			if (!(is >> (*this))) throw cybozu::Exception("ElgamalT:PrivateKey:setStr") << str;
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
#if (CYBOZU_CPP_VERSION > CYBOZU_CPP_VERSION_CP03)
		typedef CYBOZU_NAMESPACE_STD::unordered_map<Ec, int> Cache;
#else
		typedef std::map<Ec, int> Cache;
#endif
		Cache cache;
		void init(const Ec& f, int rangeMin, int rangeMax)
		{
			if (rangeMin > rangeMax) throw cybozu::Exception("mcl:ElgamalT:PowerCache:bad range") << rangeMin << rangeMax;
			Ec x;
			x.clear();
			cache[x] = 0;
			for (int i = 1; i <= rangeMax; i++) {
				Ec::add(x, x, f);
				cache[x] = i;
			}
			Ec nf;
			Ec::neg(nf, f);
			x.clear();
			for (int i = -1; i >= rangeMin; i--) {
				Ec::add(x, x, nf);
				cache[x] = i;
			}
		}
		/*
			return m such that f^m = g
		*/
		int getExponent(const Ec& g) const
		{
			typename Cache::const_iterator i = cache.find(g);
			if (i == cache.end()) throw cybozu::Exception("Elgamal:PowerCache:getExponent:not found") << g;
			return i->second;
		}
	};
};

} // mcl
