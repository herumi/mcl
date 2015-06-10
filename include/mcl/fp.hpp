#pragma once
/**
	@file
	@brief finite field class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <iostream>
#include <sstream>
#include <vector>
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
	#ifndef NOMINMAX
		#define NOMINMAX
	#endif
#endif
#if defined(_WIN64) || defined(__x86_64__)
//	#define USE_MONT_FP
#endif
#include <cybozu/hash.hpp>
#include <mcl/op.hpp>
#include <mcl/util.hpp>

namespace mcl {

namespace fp {

struct TagDefault;

void arrayToStr(std::string& str, const Unit *x, size_t n, int base, bool withPrefix);

void strToGmp(mpz_class& x, bool *isMinus, const std::string& str, int base);

} // mcl::fp

template<class tag = fp::TagDefault, size_t maxBitN = MCL_MAX_OP_BIT_N>
class FpT {
	typedef fp::Unit Unit;
	static const size_t maxN = (maxBitN + fp::UnitBitN - 1) / fp::UnitBitN;
	static fp::Op op_;
	template<class tag2, size_t maxBitN2> friend class FpT;
	Unit v_[maxN];
public:
	// return pointer to array v_[]
	const Unit *getUnit() const { return v_; }
	size_t getUnitN() const { return op_.N; }
	void dump() const
	{
		const size_t N = op_.N;
		for (size_t i = 0; i < N; i++) {
			printf("%016llx ", (long long)v_[N - 1 - i]);
		}
		printf("\n");
	}
	static inline void setModulo(const std::string& mstr, int base = 0)
	{
		assert(maxBitN <= MCL_MAX_OP_BIT_N);
		assert(sizeof(mp_limb_t) == sizeof(Unit));
		// set default wrapper function
		op_.neg = negW;
		op_.add = addW;
		op_.sub = subW;
		op_.mul = mulW;
		op_.init(mstr, base, maxBitN);
	}
	static inline void getModulo(std::string& pstr)
	{
		Gmp::getStr(pstr, op_.mp);
	}
	static inline bool isOdd(const FpT& x)
	{
		fp::Block b;
		x.getBlock(b);
		return (b.p[0] & 1) == 1;
	}
	static inline bool squareRoot(FpT& y, const FpT& x)
	{
		mpz_class mx, my;
		x.getGmp(mx);
		bool b = op_.sq.get(my, mx);
		if (!b) return false;
		y.setGmp(my);
		return true;
	}
	FpT() {}
	FpT(const FpT& x)
	{
		op_.copy(v_, x.v_);
	}
	FpT& operator=(const FpT& x)
	{
		op_.copy(v_, x.v_);
		return *this;
	}
	void clear()
	{
		op_.clear(v_);
	}
	FpT(int64_t x) { operator=(x); }
	explicit FpT(const std::string& str, int base = 0)
	{
		setStr(str, base);
	}
	FpT& operator=(int64_t x)
	{
		clear();
		if (x) {
			int64_t y = x < 0 ? -x : x;
			if (sizeof(Unit) == 8) {
				v_[0] = y;
			} else {
				v_[0] = (uint32_t)y;
				v_[1] = (uint32_t)(y >> 32);
			}
			if (x < 0) neg(*this, *this);
			toMont(*this, *this);
		}
		return *this;
	}
	void toMont(FpT& y, const FpT& x)
	{
		if (op_.useMont) op_.toMont(y.v_, x.v_);
	}
	void fromMont(FpT& y, const FpT& x)
	{
		if (op_.useMont) op_.fromMont(y.v_, x.v_);
	}
	void setStr(const std::string& str, int base = 0)
	{
		bool isMinus;
		mpz_class x;
		fp::strToGmp(x, &isMinus, str, base);
		if (x >= op_.mp) throw cybozu::Exception("FpT:setStr:large str") << str << op_.mp;
		fp::toArray(v_, op_.N, x.get_mpz_t());
		if (isMinus) {
			neg(*this, *this);
		}
		toMont(*this, *this);
	}
	// alias of setStr
	template<class S>
	void setArray(const S *inBuf, size_t n)
	{
		const size_t byteN = sizeof(S) * n;
		const size_t fpByteN = sizeof(Unit) * op_.N;
		if (byteN > fpByteN) throw cybozu::Exception("FpT:setArray:bad n") << n << fpByteN;
		assert(byteN <= fpByteN);
		memcpy(v_, inBuf, byteN);
		memset((char *)v_ + byteN, 0, fpByteN - byteN);
		if (!isValid()) throw cybozu::Exception("FpT:setArray:large value");
		toMont(*this, *this);
	}
	template<class S>
	size_t getArray(S *outBuf, size_t n) const
	{
		const size_t byteN = sizeof(S) * n;
		const size_t fpByteN = sizeof(Unit) * op_.N;
		if (byteN < fpByteN) throw cybozu::Exception("FpT:getArray:bad n") << n << fpByteN;
		assert(byteN >= fpByteN);
		fp::Block b;
		getBlock(b);
		memcpy(outBuf, b.p, fpByteN);
		const size_t writeN = (fpByteN + sizeof(S) - 1) / sizeof(S);
		memset((char *)outBuf + fpByteN, 0, writeN * sizeof(S) - fpByteN);
		return writeN;
	}
	void getBlock(fp::Block& b) const
	{
		b.n = op_.N;
		if (op_.useMont) {
			op_.fromMont(b.v_, v_);
			b.p = &b.v_[0];
		} else {
			b.p = &v_[0];
		}
	}
	template<class RG>
	void setRand(RG& rg)
	{
		fp::getRandVal(v_, rg, op_.p, op_.bitLen);
		toMont(*this, *this);
	}
	void getStr(std::string& str, int base = 10, bool withPrefix = false) const
	{
		fp::Block b;
		getBlock(b);
		fp::arrayToStr(str, b.p, b.n, base, withPrefix);
	}
	std::string getStr(int base = 10, bool withPrefix = false) const
	{
		std::string str;
		getStr(str, base, withPrefix);
		return str;
	}
	void getGmp(mpz_class& x) const
	{
		fp::Block b;
		getBlock(b);
		Gmp::setArray(x, b.p, b.n);
	}
	mpz_class getGmp() const
	{
		mpz_class x;
		getGmp(x);
		return x;
	}
	void setGmp(const mpz_class& x)
	{
		setArray(Gmp::getBlock(x), Gmp::getBlockSize(x));
	}
	static inline void add(FpT& z, const FpT& x, const FpT& y) { op_.add(z.v_, x.v_, y.v_); }
	static inline void sub(FpT& z, const FpT& x, const FpT& y) { op_.sub(z.v_, x.v_, y.v_); }
	static inline void mul(FpT& z, const FpT& x, const FpT& y) { op_.mul(z.v_, x.v_, y.v_); }
	static inline void inv(FpT& y, const FpT& x) { op_.invOp(y.v_, x.v_, op_); }
	static inline void neg(FpT& y, const FpT& x) { op_.neg(y.v_, x.v_); }
	static inline void square(FpT& y, const FpT& x) { mul(y, x, x); }
	static inline void div(FpT& z, const FpT& x, const FpT& y)
	{
		FpT rev;
		inv(rev, y);
		mul(z, x, rev);
	}
	static inline void powerArray(FpT& z, const FpT& x, const Unit *y, size_t yn)
	{
		FpT out(1);
		fp::powerArray(out, x, y, yn, FpT::mul, FpT::square);
		z = out;
	}
	template<class tag2, size_t maxBitN2>
	static inline void power(FpT& z, const FpT& x, const FpT<tag2, maxBitN2>& y)
	{
		fp::Block b;
		y.getBlock(b);
		powerArray(z, x, b.p, b.n);
	}
	static inline void power(FpT& z, const FpT& x, int y)
	{
		if (y < 0) throw cybozu::Exception("FpT:power with negative y is not support") << y;
		const Unit u = y;
		powerArray(z, x, &u, 1);
	}
	static inline void power(FpT& z, const FpT& x, const mpz_class& y)
	{
		if (y < 0) throw cybozu::Exception("FpT:power with negative y is not support") << y;
		powerArray(z, x, Gmp::getBlock(y), Gmp::getBlockSize(x));
	}
	bool isZero() const { return op_.isZero(v_); }
	bool isValid() const
	{
		return fp::compareArray(v_, op_.p, op_.N) < 0;
	}
	static inline size_t getModBitLen() { return op_.bitLen; }
	bool operator==(const FpT& rhs) const { return fp::isEqualArray(v_, rhs.v_, op_.N); }
	bool operator!=(const FpT& rhs) const { return !operator==(rhs); }
	inline friend FpT operator+(const FpT& x, const FpT& y) { FpT z; add(z, x, y); return z; }
	inline friend FpT operator-(const FpT& x, const FpT& y) { FpT z; sub(z, x, y); return z; }
	inline friend FpT operator*(const FpT& x, const FpT& y) { FpT z; mul(z, x, y); return z; }
	inline friend FpT operator/(const FpT& x, const FpT& y) { FpT z; div(z, x, y); return z; }
	FpT& operator+=(const FpT& x) { add(*this, *this, x); return *this; }
	FpT& operator-=(const FpT& x) { sub(*this, *this, x); return *this; }
	FpT& operator*=(const FpT& x) { mul(*this, *this, x); return *this; }
	FpT& operator/=(const FpT& x) { div(*this, *this, x); return *this; }
	FpT operator-() const { FpT x; neg(x, *this); return x; }
	friend inline std::ostream& operator<<(std::ostream& os, const FpT& self)
	{
		const std::ios_base::fmtflags f = os.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator<<:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 10;
		const bool showBase = (f & std::ios_base::showbase) != 0;
		std::string str;
		self.getStr(str, base, showBase);
		return os << str;
	}
	friend inline std::istream& operator>>(std::istream& is, FpT& self)
	{
		const std::ios_base::fmtflags f = is.flags();
		if (f & std::ios_base::oct) throw cybozu::Exception("fpT:operator>>:oct is not supported");
		const int base = (f & std::ios_base::hex) ? 16 : 0;
		std::string str;
		is >> str;
		self.setStr(str, base);
		return is;
	}
	/*
		@note
		this compare functions is slow because of calling mul if useMont is true.
	*/
	static inline int compare(const FpT& x, const FpT& y)
	{
		fp::Block xb, yb;
		x.getBlock(xb);
		y.getBlock(yb);
		return fp::compareArray(xb.p, yb.p, op_.N);
	}
	/*
		@note
		return unexpected order if useMont is set.
	*/
	static inline int compareRaw(const FpT& x, const FpT& y)
	{
		return fp::compareArray(x.v_, y.v_, op_.N);
	}
	/*
		wrapper function for generic p
		add(z, x, y)
		  case 1: op_.add(z.v_, x.v_, y.v_) written by Xbyak with fixed p
		  case 2: addW(z.v_, x.v_, y.v_)
		            op_.addP(z, x, y, p) written by GMP/LLVM with generic p
	*/
	static inline void addW(Unit *z, const Unit *x, const Unit *y)
	{
		op_.addP(z, x, y, op_.p);
	}
	static inline void subW(Unit *z, const Unit *x, const Unit *y)
	{
		op_.subP(z, x, y, op_.p);
	}
	static inline void mulW(Unit *z, const Unit *x, const Unit *y)
	{
		Unit xy[maxN * 2];
		op_.mulPreP(xy, x, y);
		op_.modP(z, xy, op_.p);
	}
	static inline void negW(Unit *y, const Unit *x)
	{
		op_.negP(y, x, op_.p);
	}
private:
};

template<class tag, size_t maxBitN> fp::Op FpT<tag, maxBitN>::op_;

} // mcl

namespace std { CYBOZU_NAMESPACE_TR1_BEGIN
template<class T> struct hash;

template<class tag, size_t maxBitN>
struct hash<mcl::FpT<tag, maxBitN> > : public std::unary_function<mcl::FpT<tag, maxBitN>, size_t> {
	size_t operator()(const mcl::FpT<tag, maxBitN>& x, uint64_t v = 0) const
	{
		return static_cast<size_t>(cybozu::hash64(x.getUnit(), x.getUnitN(), v));
	}
};

CYBOZU_NAMESPACE_TR1_END } // std::tr1

#ifdef _WIN32
	#pragma warning(pop)
#endif
