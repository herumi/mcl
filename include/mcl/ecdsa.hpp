#pragma once
/**
	@file
	@brief ECDSA
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/fp.hpp>
#include <mcl/ec.hpp>
#include <mcl/ecparam.hpp>
#include <mcl/window_method.hpp>

namespace mcl { namespace ecdsa {

namespace local {

#ifndef MCLSHE_WIN_SIZE
	#define MCLSHE_WIN_SIZE 10
#endif
static const size_t winSize = MCLSHE_WIN_SIZE;

struct FpTag;
struct ZnTag;

} // mcl::ecdsa::local

typedef mcl::FpT<local::FpTag, 256> Fp;
typedef mcl::FpT<local::ZnTag, 256> Zn;
typedef mcl::EcT<Fp> Ec;

namespace local {

struct Param {
	mcl::EcParam ecParam;
	Ec P;
	mcl::fp::WindowMethod<Ec> Pbase;
};

inline Param& getParam()
{
	static Param p;
	return p;
}

inline void be32toZn(Zn& x, const mcl::fp::Unit *buf)
{
	const size_t n = 32;
	const unsigned char *p = (const unsigned char*)buf;
	unsigned char be[n];
	for (size_t i = 0; i < n; i++) {
		be[i] = p[n - 1 - i];
	}
	x.setArrayMaskMod(be, n);
}

/*
	y = x mod n
*/
inline void FpToZn(Zn& y, const Fp& x)
{
	fp::Block b;
	x.getBlock(b);
	y.setArrayMaskMod(b.p, b.n);
}

inline void setHashOf(Zn& x, const void *msg, size_t msgSize)
{
	mcl::fp::Unit xBuf[256 / 8 / sizeof(mcl::fp::Unit)];
	uint32_t hashSize = mcl::fp::sha256(xBuf, sizeof(xBuf), msg, msgSize);
	assert(hashSize == sizeof(xBuf));
	(void)hashSize;
	be32toZn(x, xBuf);
}

} // mcl::ecdsa::local

const local::Param& param = local::getParam();

inline void init()
{
	const mcl::EcParam& ecParam = mcl::ecparam::secp256k1;
	Zn::init(ecParam.n);
	Fp::init(ecParam.p);
	Ec::init(ecParam.a, ecParam.b);
	Zn::setIoMode(16);
	Fp::setIoMode(16);
	Ec::setIoMode(mcl::IoEcAffine);
	local::Param& p = local::getParam();
	p.ecParam = ecParam;
	p.P.set(Fp(ecParam.gx), Fp(ecParam.gy));
	p.Pbase.init(p.P, ecParam.bitSize, local::winSize);
}

typedef Zn SecretKey;
typedef Ec PublicKey;

struct PrecomputedPublicKey {
	mcl::fp::WindowMethod<Ec> pubBase_;
	void init(const PublicKey& pub)
	{
		pubBase_.init(pub, param.ecParam.bitSize, local::winSize);
	}
};

inline void getPublicKey(PublicKey& pub, const SecretKey& sec)
{
	Ec::mul(pub, param.P, sec);
}

struct Signature : public mcl::fp::Serializable<Signature> {
	Zn r, s;
	template<class InputStream>
	void load(InputStream& is, int ioMode = IoSerialize)
	{
		r.load(is, ioMode);
		s.load(is, ioMode);
	}
	template<class OutputStream>
	void save(OutputStream& os, int ioMode = IoSerialize) const
	{
		const char sep = *fp::getIoSeparator(ioMode);
		r.save(os, ioMode);
		if (sep) cybozu::writeChar(os, sep);
		s.save(os, ioMode);
	}
	friend std::istream& operator>>(std::istream& is, Signature& self)
	{
		self.load(is, fp::detectIoMode(Ec::getIoMode(), is));
		return is;
	}
	friend std::ostream& operator<<(std::ostream& os, const Signature& self)
	{
		self.save(os, fp::detectIoMode(Ec::getIoMode(), os));
		return os;
	}
};

inline void sign(Signature& sig, const SecretKey& sec, const void *msg, size_t msgSize)
{
	Zn& r = sig.r;
	Zn& s = sig.s;
	Zn z, k;
	local::setHashOf(z, msg, msgSize);
	Ec Q;
	for (;;) {
		k.setByCSPRNG();
		param.Pbase.mul(Q, k);
		if (Q.isZero()) continue;
		Q.normalize();
		local::FpToZn(r, Q.x);
		if (r.isZero()) continue;
		Zn::mul(s, r, sec);
		s += z;
		if (s.isZero()) continue;
		s /= k;
		return;
	}
}

namespace local {

inline void mulDispatch(Ec& Q, const PublicKey& pub, const Zn& y)
{
	Ec::mul(Q, pub, y);
}

inline void mulDispatch(Ec& Q, const PrecomputedPublicKey& ppub, const Zn& y)
{
	ppub.pubBase_.mul(Q, y);
}

template<class Pub>
inline bool verify(const Signature& sig, const Pub& pub, const void *msg, size_t msgSize)
{
	const Zn& r = sig.r;
	const Zn& s = sig.s;
	if (r.isZero() || s.isZero()) return false;
	Zn z, w, u1, u2;
	local::setHashOf(z, msg, msgSize);
	Zn::inv(w, s);
	Zn::mul(u1, z, w);
	Zn::mul(u2, r, w);
	Ec Q1, Q2;
	param.Pbase.mul(Q1, u1);
//	Ec::mul(Q2, pub, u2);
	local::mulDispatch(Q2, pub, u2);
	Q1 += Q2;
	if (Q1.isZero()) return false;
	Q1.normalize();
	Zn x;
	local::FpToZn(x, Q1.x);
	return r == x;
}

} // mcl::ecdsa::local

inline bool verify(const Signature& sig, const PublicKey& pub, const void *msg, size_t msgSize)
{
	return local::verify(sig, pub, msg, msgSize);
}

inline bool verify(const Signature& sig, const PrecomputedPublicKey& ppub, const void *msg, size_t msgSize)
{
	return local::verify(sig, ppub, msg, msgSize);
}

} } // mcl::ecdsa

