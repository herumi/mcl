#pragma once
/**
	@file
	@brief Fp with montgomery(EXPERIMENTAL IMPLEMENTAION)
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause

	@note this class should be merged to FpT
*/
#include <sstream>
#include <vector>
#include <mcl/gmp_util.hpp>
#include <mcl/fp.hpp>
#include <mcl/fp_generator.hpp>

namespace mcl {

template<size_t N, class tag = fp_local::TagDefault>
class MontFpT : public ope::addsub<MontFpT<N, tag>,
	ope::mulable<MontFpT<N, tag>,
	ope::invertible<MontFpT<N, tag>,
	ope::hasNegative<MontFpT<N, tag>,
	ope::hasIO<MontFpT<N, tag> > > > > > {

	static mpz_class pOrg_;
	static mcl::SquareRoot sq_;
	static MontFpT p_;
	static MontFpT one_;
	static MontFpT R_; // (1 << (N * 64)) % p
	static MontFpT RR_; // (R * R) % p
	static MontFpT invTbl_[N * 64 * 2];
	static size_t modBitLen_;
public:
	static FpGenerator fg_;
private:
	uint64_t v_[N];
	void fromRawGmp(const mpz_class& x)
	{
		if (Gmp::getRaw(v_, N, x) == 0) {
			throw cybozu::Exception("MontFpT:fromRawGmp") << x;
		}
	}
	template<class S>
	void setMaskMod(std::vector<S>& buf)
	{
		assert(buf.size() * sizeof(S) * 8 <= modBitLen_);
		assert(!buf.empty());
		fp::maskBuffer(&buf[0], buf.size(), modBitLen_);
		memcpy(v_, &buf[0], buf.size() * sizeof(S));
		if (compare(*this, p_) >= 0) {
			subNc(v_, v_, p_.v_);
		}
		assert(compare(*this, p_) < 0);
	}
	static void initInvTbl(MontFpT *invTbl)
	{
		MontFpT t(2);
		const int n = N * 64 * 2;
		for (int i = 0; i < n; i++) {
			invTbl[n - 1 - i] = t;
			t += t;
		}
	}
	typedef void (*void3op)(MontFpT&, const MontFpT&, const MontFpT&);
	typedef bool (*bool3op)(MontFpT&, const MontFpT&, const MontFpT&);
	typedef void (*void2op)(MontFpT&, const MontFpT&);
	typedef int (*int2op)(MontFpT&, const MontFpT&);
public:
	static const size_t BlockSize = N;
	typedef uint64_t BlockType;
	MontFpT() {}
	MontFpT(int x) { operator=(x); }
	MontFpT(uint64_t x) { operator=(x); }
	explicit MontFpT(const std::string& str, int base = 0)
	{
		fromStr(str, base);
	}
	MontFpT& operator=(int x)
	{
		if (x == 0) {
			clear();
		} else {
			v_[0] = abs(x);
			for (size_t i = 1; i < N; i++) v_[i] = 0;
			mul(*this, *this, RR_);
			if (x < 0) {
				neg(*this, *this);
			}
		}
		return *this;
	}
	MontFpT& operator=(uint64_t x)
	{
		v_[0] = x;
		for (size_t i = 1; i < N; i++) v_[i] = 0;
		mul(*this, *this, RR_);
		return *this;
	}
	void fromStr(const std::string& str, int base = 0)
	{
		bool isMinus;
		const char *p = fp::verifyStr(&isMinus, &base, str);

		if (base == 16) {
			MontFpT t;
			mcl::fp::fromStr16(t.v_, N, p, str.size() - (p - str.c_str()));
			if (compare(t, p_) >= 0) throw cybozu::Exception("fp:MontFpT:str is too large") << str;
			mul(*this, t, RR_);
		} else {
			mpz_class t;
			if (!Gmp::fromStr(t, p, base)) {
				throw cybozu::Exception("fp:MontFpT:fromStr") << str;
			}
			toMont(*this, t);
		}
		if (isMinus) {
			neg(*this, *this);
		}
	}
	void put() const
	{
		for (int i = N - 1; i >= 0; i--) {
			printf("%016llx ", v_[i]);
		}
		printf("\n");
	}
	void set(const std::string& str, int base = 0) { fromStr(str, base); }
	void toStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		if (isZero()) {
			str = "0";
			return;
		}
		if (base == 16 || base == 2) {
			MontFpT t;
			mul(t, *this, one_);
			if (base == 16) {
				mcl::fp::toStr16(str, t.v_, N, withPrefix);
			} else {
				mcl::fp::toStr2(str, t.v_, N, withPrefix);
			}
			return;
		}
		if (base != 10) throw cybozu::Exception("fp:MontFpT:toStr:bad base") << base;
		// QQQ : remove conversion to gmp
		mpz_class t;
		fromMont(t, *this);
		Gmp::toStr(str, t, base);
	}
	std::string toStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		toStr(str, base, withPrefix);
		return str;
	}
	void clear()
	{
		for (size_t i = 0; i < N; i++) v_[i] = 0;
	}
	template<class RG>
	void setRand(RG& rg)
	{
		fp::getRandVal(v_, rg, p_.v_, modBitLen_);
	}
	template<class S>
	void setRaw(const S *inBuf, size_t n)
	{
		n = std::min(n, fp::getRoundNum<S>(modBitLen_));
		if (n == 0) {
			clear();
			return;
		}
		std::vector<S> buf(inBuf, inBuf + n);
		setMaskMod(buf);
	}
	static inline void setModulo(const std::string& pstr, int base = 0)
	{
		bool isMinus;
		const char *p = fp::verifyStr(&isMinus, &base, pstr);
		if (isMinus) throw cybozu::Exception("MontFp:setModulo:mstr is not pinus") << pstr;
		if (!Gmp::fromStr(pOrg_, p, base)) {
			throw cybozu::Exception("fp:MontFpT:setModulo") << pstr << base;
		}
		modBitLen_ = Gmp::getBitLen(pOrg_);
		if (fp::getRoundNum<uint64_t>(modBitLen_) > N) {
			throw cybozu::Exception("MontFp:setModulo:bad prime length") << pstr;
		}
		p_.fromRawGmp(pOrg_);
		sq_.set(pOrg_);

		mpz_class t = 1;
		one_.fromRawGmp(t);
		t = (t << (N * 64)) % pOrg_;
		R_.fromRawGmp(t);
		t = (t * t) % pOrg_;
		RR_.fromRawGmp(t);
		fg_.init(p_.v_, N);
		add = Xbyak::CastTo<void3op>(fg_.add_);
		sub = Xbyak::CastTo<void3op>(fg_.sub_);
		mul = Xbyak::CastTo<void3op>(fg_.mul_);
		square = Xbyak::CastTo<void2op>(fg_.sqr_);
		if (square == 0) square = squareC;
		neg = Xbyak::CastTo<void2op>(fg_.neg_);
		shr1 = Xbyak::CastTo<void2op>(fg_.shr1_);
		addNc = Xbyak::CastTo<bool3op>(fg_.addNc_);
		subNc = Xbyak::CastTo<bool3op>(fg_.subNc_);
		preInv = Xbyak::CastTo<int2op>(fg_.preInv_);
		initInvTbl(invTbl_);
	}
	static inline void getModulo(std::string& pstr)
	{
		Gmp::toStr(pstr, pOrg_);
	}
	static inline bool isYodd(const MontFpT& y)
	{
#if 0
		return (y.v_[0] & 1) == 1;
#else
		MontFpT t; // QQQ : is necessary?
		mul(t, y, one_);
		return (t.v_[0] & 1) == 1;
#endif
	}
	static inline bool squareRoot(MontFpT& y, const MontFpT& x)
	{
		mpz_class t;
		fromMont(t, x);
		if (!sq_.get(t, t)) return false;
		toMont(y, t);
		return true;
	}
	static inline void fromMont(mpz_class& z, const MontFpT& x)
	{
		MontFpT t;
		mul(t, x, one_);
		Gmp::setRaw(z, t.v_, N);
	}
	static inline void toMont(MontFpT& z, const mpz_class& x)
	{
		if (x >= pOrg_) throw cybozu::Exception("fp:MontFpT:toMont:large x") << x;
		MontFpT t;
		t.fromRawGmp(x);
		mul(z, t, RR_);
	}
	static void3op add;
	static void3op sub;
	static void3op mul;
	static void2op square;
	static void2op neg;
	static void2op shr1;
	static bool3op addNc;
	static bool3op subNc;
	static int2op preInv;
	static inline void squareC(MontFpT& z, const MontFpT& x)
	{
		mul(z, x, x);
	}
	static inline int preInvC(MontFpT& r, const MontFpT& x)
	{
		MontFpT u, v, s;
		u = p_;
		v = x;
		r.clear();
		s.clear(); s.v_[0] = 1; // s is real 1
		int k = 0;
		// u, v : Pack, r, s : mem
		bool rTop = false;
	LP:
		if (v.isZero()) goto EXIT;
		if ((u.v_[0] & 1) == 0) {
			goto U_EVEN;
		}
		if ((v.v_[0] & 1) == 0) {
			goto V_EVEN;
		}
		if (compare(v, u) < 0) {
			goto V_LT_U;
		}
		subNc(v, v, u); // sub_rr
		addNc(s, s, r); // add_mm
	V_EVEN:
		shr1(v, v); // shr1_r
		rTop = addNc(r, r, r); // twice_m
		k++;
		goto LP;
	V_LT_U:
		subNc(u, u, v); // sub_rr
		rTop = addNc(r, r, s); // add_mm
	U_EVEN:
		shr1(u, u); // shr1_r
		addNc(s, s, s); // twice_m
		k++;
		goto LP;
	EXIT:;
		if (rTop) subNc(r, r, p_);
		if (subNc(r, p_, r)) {
			addNc(r, r, p_);
		}
		return k;
	}
	static inline void inv(MontFpT& z, const MontFpT& x)
	{
#if 1
		MontFpT r;
#if 1
		int k = preInv(r, x);
#else
		MontFpT s;
		int h = preInvC(s, x);
		int k = preInv(r, x);
		if (r != s || k != h) {
			std::cout << std::hex;
			PUT(x);
			PUT(r);
			PUT(s);
			printf("k=%d, h=%d\n", k, h);
			exit(1);
		}
#endif
		/*
			xr = 2^k
			R = 2^(N * 64)
			get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
		*/
		mul(z, r, invTbl_[k]);
#else
		mpz_class t;
		fromMont(t, x);
		Gmp::invMod(t, t, pOrg_);
		toMont(z, t);
#endif
	}
	static inline void div(MontFpT& z, const MontFpT& x, const MontFpT& y)
	{
		MontFpT ry;
		inv(ry, y);
		mul(z, x, ry);
	}
#if 0
	static inline BlockType getBlock(const MontFpT& x, size_t i)
	{
		return Gmp::getBlock(x.v, i);
	}
	static inline const BlockType *getBlock(const MontFpT& x)
	{
		return Gmp::getBlock(x.v);
	}
	static inline size_t getBlockSize(const MontFpT& x)
	{
		return Gmp::getBlockSize(x.v);
	}
	static inline void shr(MontFpT& z, const MontFpT& x, size_t n)
	{
		z.v = x.v >> n;
	}
#endif
	/*
		append to bv(not clear bv)
	*/
	void appendToBitVec(cybozu::BitVector& bv) const
	{
		MontFpT t;
		MontFpT::mul(t, *this, MontFpT::one_);
		bv.append(t.v_, modBitLen_);
	}
	void fromBitVec(const cybozu::BitVector& bv)
	{
		const size_t bitLen = bv.size();
		if (bitLen != modBitLen_) throw cybozu::Exception("MontFp:fromBitVec:bad size") << bitLen << modBitLen_;
		const size_t blockN = cybozu::RoundupBit<BlockType>(bitLen);
		const MontFpT* src;
		MontFpT t;
		if (blockN == N) {
			src = (const MontFpT*)bv.getBlock();
		} else {
			cybozu::CopyBit(t.v_, bv.getBlock(), bitLen);
			for (size_t i = blockN; i < N; i++) t.v_[i] = 0;
			src = &t;
		}
		mul(*this, *src, RR_);
		if (compare(*this, p_) >= 0) {
			throw cybozu::Exception("MontFpT:fromBitVec:large x") << *this << p_;
		}
	}
	static inline size_t getBitVecSize() { return modBitLen_; }
	static inline int compare(const MontFpT& x, const MontFpT& y)
	{
		return fp::compareArray(x.v_, y.v_, N);
	}
	static inline bool isZero(const MontFpT& x)
	{
		if (x.v_[0]) return false;
		uint64_t r = 0;
		for (size_t i = 1; i < N; i++) {
			r |= x.v_[i];
		}
		return r == 0;
	}
	bool isZero() const { return isZero(*this); }
	template<class Z>
	static void power(MontFpT& z, const MontFpT& x, const Z& y)
	{
		power_impl::power(z, x, y);
	}
	const uint64_t* getInnerValue() const { return v_; }
	bool operator==(const MontFpT& rhs) const { return compare(*this, rhs) == 0; }
	bool operator!=(const MontFpT& rhs) const { return compare(*this, rhs) != 0; }
	static inline size_t getModBitLen() { return modBitLen_; }
	static inline uint64_t cvtInt(const MontFpT& x, bool *err = 0)
	{
		MontFpT t;
		mul(t, x, one_);
		for (size_t i = 1; i < N; i++) {
			if (t.v_[i]) {
				if (err) {
					*err = true;
					return 0;
				} else {
					throw cybozu::Exception("MontFp:cvtInt:too large") << x;
				}
			}
		}
		if (err) *err = false;
		return t.v_[0];
	}
	uint64_t cvtInt(bool *err = 0) const { return cvtInt(*this, err); }
};

template<size_t N, class tag>mpz_class MontFpT<N, tag>::pOrg_;
template<size_t N, class tag>mcl::SquareRoot MontFpT<N, tag>::sq_;
template<size_t N, class tag>MontFpT<N, tag> MontFpT<N, tag>::p_;
template<size_t N, class tag>MontFpT<N, tag> MontFpT<N, tag>::one_;
template<size_t N, class tag>MontFpT<N, tag> MontFpT<N, tag>::R_;
template<size_t N, class tag>MontFpT<N, tag> MontFpT<N, tag>::RR_;
template<size_t N, class tag>MontFpT<N, tag> MontFpT<N, tag>::invTbl_[N * 64 * 2];
template<size_t N, class tag>FpGenerator MontFpT<N, tag>::fg_;
template<size_t N, class tag>size_t MontFpT<N, tag>::modBitLen_;

template<size_t N, class tag>typename MontFpT<N, tag>::void3op MontFpT<N, tag>::add;
template<size_t N, class tag>typename MontFpT<N, tag>::void3op MontFpT<N, tag>::sub;
template<size_t N, class tag>typename MontFpT<N, tag>::void3op MontFpT<N, tag>::mul;
template<size_t N, class tag>typename MontFpT<N, tag>::void2op MontFpT<N, tag>::square;
template<size_t N, class tag>typename MontFpT<N, tag>::void2op MontFpT<N, tag>::neg;
template<size_t N, class tag>typename MontFpT<N, tag>::void2op MontFpT<N, tag>::shr1;
template<size_t N, class tag>typename MontFpT<N, tag>::bool3op MontFpT<N, tag>::addNc;
template<size_t N, class tag>typename MontFpT<N, tag>::bool3op MontFpT<N, tag>::subNc;
template<size_t N, class tag>typename MontFpT<N, tag>::int2op MontFpT<N, tag>::preInv;

} // mcl

namespace std { CYBOZU_NAMESPACE_TR1_BEGIN
template<class T> struct hash;

template<size_t N, class tag>
struct hash<mcl::MontFpT<N, tag> > {
	size_t operator()(const mcl::MontFpT<N, tag>& x, uint64_t v = 0) const
	{
		return static_cast<size_t>(cybozu::hash64(x.getInnerValue(), N, v));
	}
};

CYBOZU_NAMESPACE_TR1_END } // std::tr1
