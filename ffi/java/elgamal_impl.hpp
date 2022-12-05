#pragma once
//#define MCL_MAX_BIT_SIZE 521
#include <iostream>
#include <fstream>
#include <cybozu/random_generator.hpp>
#include <cybozu/crypto.hpp>
#include <mcl/fp.hpp>
#include <mcl/ecparam.hpp>
#include <mcl/elgamal.hpp>

typedef mcl::FpT<mcl::FpTag> Fp;
typedef mcl::FpT<mcl::ZnTag> Zn;
typedef mcl::EcT<Fp> Ec;
typedef mcl::ElgamalT<Ec, Zn> Elgamal;

#if defined(__GNUC__) && !defined(__EMSCRIPTEN__) && !defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated"
#endif

#if __cplusplus >= 201703
	#define _MCL_THROW noexcept(false)
#else
	#define _MCL_THROW throw(std::exception)
#endif

/*
	init system
	@param param [in] string such as "ecParamName hashName"
	@note NOT thread safe because setting global parameters of elliptic curve
	ex1) "secp192k1 sha256" // 192bit security + sha256
	ex2) "secp160k1 sha1" // 160bit security + sha1
	hashName : sha1 sha224 sha256 sha384 sha512
*/
void SystemInit(const std::string& param) _MCL_THROW
{
	std::istringstream iss(param);
	std::string ecParamStr;
	std::string hashNameStr;
	if (iss >> ecParamStr >> hashNameStr) {
		Param& p = Param::getParam();
		p.ecParam = mcl::getEcParam(ecParamStr);
		if (p.ecParam) {
			mcl::initCurve<Ec, Zn>(p.ecParam->curveType);
			p.hashName = cybozu::crypto::Hash::getName(hashNameStr);
			return;
		}
	}
	throw cybozu::Exception("SystemInit:bad param") << param;
}

class CipherText {
	Elgamal::CipherText self_;
	friend class PublicKey;
	friend class PrivateKey;
public:
	std::string toStr() const _MCL_THROW { return self_.toStr(); }
	std::string toString() const _MCL_THROW { return toStr(); }
	void fromStr(const std::string& str) _MCL_THROW { self_.fromStr(str); }

	void add(const CipherText& c) _MCL_THROW { self_.add(c.self_); }
	void mul(int m) _MCL_THROW
	{
		self_.mul(m);
	}
	void mul(const std::string& str) _MCL_THROW
	{
		Zn zn(str);
		self_.mul(zn);
	}
};

class PublicKey {
	Elgamal::PublicKey self_;
	friend class PrivateKey;
public:
	std::string toStr() const _MCL_THROW { return self_.toStr(); }
	std::string toString() const _MCL_THROW { return toStr(); }
	void fromStr(const std::string& str) _MCL_THROW { self_.fromStr(str); }

	void save(const std::string& fileName) const _MCL_THROW
	{
		std::ofstream ofs(fileName.c_str(), std::ios::binary);
		if (!(ofs << self_)) throw cybozu::Exception("PublicKey:save") << fileName;
	}
	void load(const std::string& fileName) _MCL_THROW
	{
		std::ifstream ifs(fileName.c_str(), std::ios::binary);
		if (!(ifs >> self_)) throw cybozu::Exception("PublicKey:load") << fileName;
	}
	void enc(CipherText& c, int m) const _MCL_THROW
	{
		self_.enc(c.self_, m, Param::getParam().rg);
	}
	void enc(CipherText& c, const std::string& str) const _MCL_THROW
	{
		Zn zn(str);
		self_.enc(c.self_, zn, Param::getParam().rg);
	}
	void rerandomize(CipherText& c) const _MCL_THROW
	{
		self_.rerandomize(c.self_, Param::getParam().rg);
	}
	void add(CipherText& c, int m) const _MCL_THROW
	{
		self_.add(c.self_, m);
	}
	void add(CipherText& c, const std::string& str) const _MCL_THROW
	{
		Zn zn(str);
		self_.add(c.self_, zn);
	}
};

class PrivateKey {
	Elgamal::PrivateKey self_;
public:
	std::string toStr() const _MCL_THROW { return self_.toStr(); }
	std::string toString() const _MCL_THROW { return toStr(); }
	void fromStr(const std::string& str) _MCL_THROW { self_.fromStr(str); }

	void save(const std::string& fileName) const _MCL_THROW
	{
		std::ofstream ofs(fileName.c_str(), std::ios::binary);
		if (!(ofs << self_)) throw cybozu::Exception("PrivateKey:save") << fileName;
	}
	void load(const std::string& fileName) _MCL_THROW
	{
		std::ifstream ifs(fileName.c_str(), std::ios::binary);
		if (!(ifs >> self_)) throw cybozu::Exception("PrivateKey:load") << fileName;
	}
	void init() _MCL_THROW
	{
		Param& p = Param::getParam();
		const Fp x0(p.ecParam->gx);
		const Fp y0(p.ecParam->gy);
		Ec P(x0, y0);
		self_.init(P, Zn::getBitSize(), p.rg);
	}
	PublicKey getPublicKey() const _MCL_THROW
	{
		PublicKey ret;
		ret.self_ = self_.getPublicKey();
		return ret;
	}
	int dec(const CipherText& c, bool *b = 0) const _MCL_THROW
	{
		return self_.dec(c.self_, b);
	}
	void setCache(int rangeMin, int rangeMax) _MCL_THROW
	{
		self_.setCache(rangeMin, rangeMax);
	}
	void clearCache() _MCL_THROW
	{
		self_.clearCache();
	}
};

#if defined(__GNUC__) && !defined(__EMSCRIPTEN__) && !defined(__clang__)
#pragma GCC diagnostic pop
#endif
