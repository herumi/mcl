#pragma once
/**
	@file
	@brief aggregate signature
	@author MITSUNARI Shigeo(@herumi)
	see http://crypto.stanford.edu/~dabo/papers/aggreg.pdf
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cmath>
#include <vector>
#include <iosfwd>
#include <set>
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

namespace mcl { namespace aggs {

/*
	AGGregate Signature Template class
*/
template<class BN, class Fr>
struct AGGST {
	typedef typename BN::G1 G1;
	typedef typename G1::BaseFp Fp;
	typedef typename BN::G2 G2;
	typedef typename BN::Fp12 GT;

	class SecretKey;
	class PublicKey;
	class Signature;

	static G1 P_;
	static G2 Q_;
	static std::vector<bn_current::Fp6> Qcoeff_;
public:
	static void init(const mcl::CurveParam& cp = mcl::BN254)
	{
		bn_current::initPairing(cp);
		BN::hashAndMapToG1(P_, "0");
		BN::hashAndMapToG2(Q_, "0");
		BN::precomputeG2(Qcoeff_, Q_);
	}
	class Signature : public fp::Serializable<Signature> {
		G1 S_;
		friend class SecretKey;
		friend class PublicKey;
	public:
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			S_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			S_.save(os, ioMode);
		}
		friend std::istream& operator>>(std::istream& is, Signature& self)
		{
			self.load(is, fp::detectIoMode(G1::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const Signature& self)
		{
			self.save(os, fp::detectIoMode(G1::getIoMode(), os));
			return os;
		}
		bool operator==(const Signature& rhs) const
		{
			return S_ == rhs.S_;
		}
		bool operator!=(const Signature& rhs) const { return !operator==(rhs); }
		/*
			aggregate sig[0..n) and set *this
		*/
		void aggregate(const Signature *sig, size_t n)
		{
			G1 S;
			S.clear();
			for (size_t i =  0; i < n; i++) {
				S += sig[i].S_;
			}
			S_ = S;
		}
		void aggregate(const std::vector<Signature>& sig)
		{
			aggregate(sig.data(), sig.size());
		}
		/*
			aggregate verification
		*/
		bool verify(const void *const *msgVec, const size_t *sizeVec, const PublicKey *pubVec, size_t n) const
		{
			if (n == 0) return false;
			typedef std::set<Fp> FpSet;
			FpSet msgSet;
			typedef std::vector<G1> G1Vec;
			G1Vec hv(n);
			for (size_t i = 0; i < n; i++) {
				Fp h;
				h.setHashOf(msgVec[i], sizeVec[i]);
				std::pair<typename FpSet::iterator, bool> ret = msgSet.insert(h);
				if (!ret.second) throw cybozu::Exception("aggs::verify:same msg");
				BN::mapToG1(hv[i], h);
			}
			/*
				e(aggSig, xQ) = prod_i e(hv[i], pub[i].Q)
				<=> finalExp(e(-aggSig, xQ) * prod_i millerLoop(hv[i], pub[i].xQ)) == 1
			*/
			GT e1, e2;
			BN::precomputedMillerLoop(e1, -S_, Qcoeff_);
			BN::millerLoop(e2, hv[0], pubVec[0].xQ_);
			for (size_t i = 1; i < n; i++) {
				GT e;
				BN::millerLoop(e, hv[i], pubVec[i].xQ_);
				e2 *= e;
			}
			e1 *= e2;
			BN::finalExp(e1, e1);
			return e1.isOne();
		}
		bool verify(const std::vector<std::string>& msgVec, const std::vector<PublicKey>& pubVec) const
		{
			const size_t n = msgVec.size();
			if (n != pubVec.size()) throw cybozu::Exception("aggs:Signature:verify:bad size") << msgVec.size() << pubVec.size();
			if (n == 0) return false;
			std::vector<const void*> mv(n);
			std::vector<size_t> sv(n);
			for (size_t i = 0; i < n; i++) {
				mv[i] = msgVec[i].c_str();
				sv[i] = msgVec[i].size();
			}
			return verify(&mv[0], &sv[0], &pubVec[0], n);
		}
	};
	class PublicKey : public fp::Serializable<PublicKey> {
		G2 xQ_;
		friend class SecretKey;
		friend class Signature;
	public:
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			xQ_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			xQ_.save(os, ioMode);
		}
		friend std::istream& operator>>(std::istream& is, PublicKey& self)
		{
			self.load(is, fp::detectIoMode(G2::getIoMode(), is));
			return is;
		}
		friend std::ostream& operator<<(std::ostream& os, const PublicKey& self)
		{
			self.save(os, fp::detectIoMode(G2::getIoMode(), os));
			return os;
		}
		bool operator==(const PublicKey& rhs) const
		{
			return xQ_ == rhs.xQ_;
		}
		bool operator!=(const PublicKey& rhs) const { return !operator==(rhs); }
		bool verify(const Signature& sig, const void *m, size_t mSize) const
		{
			/*
				H = hash(m)
				e(S, Q) = e(H, xQ) where S = xH
				<=> e(S, Q)e(-H, xQ) = 1
				<=> finalExp(millerLoop(S, Q)e(-H, x)) = 1
			*/
			G1 H;
			BN::hashAndMapToG1(H, m,  mSize);
			G1::neg(H, H);
			GT e1, e2;
			BN::precomputedMillerLoop(e1, sig.S_, Qcoeff_);
			BN::millerLoop(e2, H, xQ_);
			e1 *= e2;
			BN::finalExp(e1, e1);
			return e1.isOne();
		}
		bool verify(const Signature& sig, const std::string& m) const
		{
			return verify(sig, m.c_str(), m.size());
		}
	};
	class SecretKey : public fp::Serializable<SecretKey> {
		Fr x_;
		friend class PublicKey;
		friend class Signature;
	public:
		template<class InputStream>
		void load(InputStream& is, int ioMode = IoSerialize)
		{
			x_.load(is, ioMode);
		}
		template<class OutputStream>
		void save(OutputStream& os, int ioMode = IoSerialize) const
		{
			x_.save(os, ioMode);
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
			return x_ == rhs.x_;
		}
		bool operator!=(const SecretKey& rhs) const { return !operator==(rhs); }
		void init()
		{
			x_.setByCSPRNG();
		}
		void getPublicKey(PublicKey& pub) const
		{
			G2::mul(pub.xQ_, Q_, x_);
		}
		void sign(Signature& sig, const void *m, size_t mSize) const
		{
			BN::hashAndMapToG1(sig.S_, m, mSize);
			G1::mul(sig.S_, sig.S_, x_);
		}
		void sign(Signature& sig, const std::string& m) const
		{
			sign(sig, m.c_str(), m.size());
		}
	};
};

template<class BN, class Fr> typename BN::G1 AGGST<BN, Fr>::P_;
template<class BN, class Fr> typename BN::G2 AGGST<BN, Fr>::Q_;
template<class BN, class Fr> std::vector<bn_current::Fp6> AGGST<BN, Fr>::Qcoeff_;

typedef AGGST<bn_current::BN, bn_current::Fr> AGGS;
typedef AGGS::SecretKey SecretKey;
typedef AGGS::PublicKey PublicKey;
typedef AGGS::Signature Signature;

} } // mcl::aggs
