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
	#pragma warning(disable : 4458)
	#ifndef NOMINMAX
		#define NOMINMAX
	#endif
	#ifndef MCL_NO_AUTOLINK
		#ifdef NDEBUG
			#pragma comment(lib, "mcl.lib")
		#else
			#pragma comment(lib, "mcld.lib")
		#endif
	#endif
#endif
#include <cybozu/hash.hpp>
#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <mcl/operator.hpp>

namespace mcl {

struct FpTag;
struct ZnTag;

namespace fp {

// copy src to dst as little endian
void copyUnitToByteAsLE(uint8_t *dst, const Unit *src, size_t byteSize);
// copy src to dst as little endian
void copyByteToUnitAsLE(Unit *dst, const uint8_t *src, size_t byteSize);
void copyAndMask(Unit *y, const void *x, size_t xByteSize, const Op& op, bool doMask);

uint64_t getUint64(bool *pb, const fp::Block& b);
int64_t getInt64(bool *pb, fp::Block& b, const fp::Op& op);

const char *ModeToStr(Mode mode);

Mode StrToMode(const std::string& s);

void dumpUnit(Unit x);
void UnitToHex(char *buf, size_t maxBufSize, Unit x);
std::string hexStrToLittleEndian(const char *buf, size_t bufSize);
std::string littleEndianToHexStr(const char *buf, size_t bufSize);

bool isEnableJIT(); // 1st call is not threadsafe

// hash msg
std::string hash(size_t bitSize, const void *msg, size_t msgSize);

} // mcl::fp

template<class tag = FpTag, size_t maxBitSize = MCL_MAX_BIT_SIZE>
class FpT : public fp::Operator<FpT<tag, maxBitSize> > {
	typedef fp::Unit Unit;
	typedef fp::Operator<FpT<tag, maxBitSize> > Operator;
public:
	static const size_t maxSize = (maxBitSize + fp::UnitBitSize - 1) / fp::UnitBitSize;
private:
	template<class tag2, size_t maxBitSize2> friend class FpT;
	Unit v_[maxSize];
	static fp::Op op_;
	static FpT<tag, maxBitSize> inv2_;
	static int ioMode_;
	template<class Fp> friend class FpDblT;
	template<class Fp> friend class Fp2T;
	template<class Fp> friend struct Fp6T;
public:
	typedef FpT<tag, maxBitSize> BaseFp;
	// return pointer to array v_[]
	const Unit *getUnit() const { return v_; }
	FpT* getFp0() { return this; }
	const FpT* getFp0() const { return this; }
	static inline size_t getUnitSize() { return op_.N; }
	static inline size_t getBitSize() { return op_.bitSize; }
	static inline size_t getByteSize() { return (op_.bitSize + 7) / 8; }
	static inline const fp::Op& getOp() { return op_; }
	void dump() const
	{
		const size_t N = op_.N;
		for (size_t i = 0; i < N; i++) {
			fp::dumpUnit(v_[N - 1 - i]);
		}
		printf("\n");
	}
	static inline void init(const mpz_class& m, fp::Mode mode = fp::FP_AUTO)
	{
		init(gmp::getStr(m), mode);
	}
	static inline void init(const std::string& mstr, fp::Mode mode = fp::FP_AUTO)
	{
		assert(maxBitSize <= MCL_MAX_BIT_SIZE);
		op_.init(mstr, maxBitSize, mode);
		{ // set oneRep
			FpT& one = *reinterpret_cast<FpT*>(op_.oneRep);
			one.clear();
			one.v_[0] = 1;
			one.toMont();
		}
		{ // set half
			mpz_class half = (op_.mp + 1) / 2;
			gmp::getArray(op_.half, op_.N, half);
		}
		inv(inv2_, 2);
	}
	static inline void getModulo(std::string& pstr)
	{
		gmp::getStr(pstr, op_.mp);
	}
	static inline bool isFullBit() { return op_.isFullBit; }
	/*
		binary patter of p
		@note the value of p is zero
	*/
	static inline const FpT& getP()
	{
		return *reinterpret_cast<const FpT*>(op_.p);
	}
	bool isOdd() const
	{
		fp::Block b;
		getBlock(b);
		return (b.p[0] & 1) == 1;
	}
	static inline bool squareRoot(FpT& y, const FpT& x)
	{
		mpz_class mx, my;
		x.getMpz(mx);
		bool b = op_.sq.get(my, mx);
		if (!b) return false;
		y.setMpz(my);
		return true;
	}
	FpT() {}
	FpT(const FpT& x)
	{
		op_.fp_copy(v_, x.v_);
	}
	FpT& operator=(const FpT& x)
	{
		op_.fp_copy(v_, x.v_);
		return *this;
	}
	void clear()
	{
		op_.fp_clear(v_);
	}
	FpT(int64_t x) { operator=(x); }
	explicit FpT(const std::string& str, int base = 0)
	{
		setStr(str, base);
	}
	FpT& operator=(int64_t x)
	{
		if (x == 1) {
			op_.fp_copy(v_, op_.oneRep);
		} else {
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
				toMont();
			}
		}
		return *this;
	}
	static inline bool isMont() { return op_.isMont; }
	/*
		convert normal value to Montgomery value
		do nothing is !isMont()
	*/
	void toMont()
	{
		if (isMont()) op_.toMont(v_, v_);
	}
	/*
		convert Montgomery value to normal value
		do nothing is !isMont()
	*/
	void fromMont()
	{
		if (isMont()) op_.fromMont(v_, v_);
	}
	std::istream& readStream(std::istream& is, int ioMode)
	{
		bool isMinus;
		fp::streamToArray(&isMinus, v_, FpT::getByteSize(), is, ioMode);
		if (fp::isGreaterOrEqualArray(v_, op_.p, op_.N)) throw cybozu::Exception("FpT:readStream:large value");
		if (!(ioMode & IoArrayRaw)) {
			if (isMinus) {
				neg(*this, *this);
			}
			toMont();
		}
		return is;
	}
	void setStr(const std::string& str, int ioMode = 0)
	{
		std::istringstream is(str);
		readStream(is, ioMode);
	}
	/*
		throw exception if x >= p
	*/
	template<class S>
	void setArray(const S *x, size_t n)
	{
		fp::copyAndMask(v_, x, sizeof(S) * n, op_, false);
		toMont();
	}
	/*
		mask inBuf with (1 << (bitLen - 1)) - 1 if x >= p
	*/
	template<class S>
	void setArrayMask(const S *inBuf, size_t n)
	{
		fp::copyAndMask(v_, inBuf, sizeof(S) * n, op_, true);
		toMont();
	}
	void getBlock(fp::Block& b) const
	{
		b.n = op_.N;
		if (isMont()) {
			op_.fromMont(b.v_, v_);
			b.p = &b.v_[0];
		} else {
			b.p = &v_[0];
		}
	}
	template<class RG>
	void setRand(RG& rg)
	{
		fp::getRandVal(v_, rg, op_.p, op_.bitSize);
		toMont();
	}
	/*
		hash msg and mask with (1 << (bitLen - 1)) - 1
	*/
	void setHashOf(const void *msg, size_t msgSize)
	{
		std::string digest = mcl::fp::hash(op_.bitSize, msg, msgSize);
		setArrayMask(digest.c_str(), digest.size());
	}
	void setHashOf(const std::string& msg)
	{
		setHashOf(msg.data(), msg.size());
	}
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable:4701)
#endif
	void getStr(std::string& str, int ioMode = 0) const
	{
		fp::Block b;
		const size_t n = getByteSize();
		const Unit *p = v_;
		if (!(ioMode & IoArrayRaw)) {
			getBlock(b);
			p = b.p;
		}
		if (ioMode & (IoArray | IoArrayRaw | IoFixedSizeByteSeq)) {
			str.resize(n);
			fp::copyUnitToByteAsLE(reinterpret_cast<uint8_t*>(&str[0]), p, str.size());
			return;
		}
		// use low 8-bit ioMode for Fp
		fp::arrayToStr(str, b.p, b.n, ioMode & 255);
	}
#ifdef _MSC_VER
	#pragma warning(pop)
#endif
	std::string getStr(int ioMode = 0) const
	{
		std::string str;
		getStr(str, ioMode);
		return str;
	}
	void getMpz(mpz_class& x) const
	{
		fp::Block b;
		getBlock(b);
		gmp::setArray(x, b.p, b.n);
	}
	mpz_class getMpz() const
	{
		mpz_class x;
		getMpz(x);
		return x;
	}
	void setMpz(const mpz_class& x)
	{
		if (x < 0) throw cybozu::Exception("Fp:setMpz:negative is not supported") << x;
		setArray(gmp::getUnit(x), gmp::getUnitSize(x));
	}
	static inline void add(FpT& z, const FpT& x, const FpT& y) { op_.fp_add(z.v_, x.v_, y.v_, op_.p); }
	static inline void sub(FpT& z, const FpT& x, const FpT& y) { op_.fp_sub(z.v_, x.v_, y.v_, op_.p); }
	static inline void addPre(FpT& z, const FpT& x, const FpT& y) { op_.fp_addPre(z.v_, x.v_, y.v_); }
	static inline void subPre(FpT& z, const FpT& x, const FpT& y) { op_.fp_subPre(z.v_, x.v_, y.v_); }
	static inline void mul(FpT& z, const FpT& x, const FpT& y) { op_.fp_mul(z.v_, x.v_, y.v_, op_.p); }
	static inline void mulUnit(FpT& z, const FpT& x, const Unit y)
	{
		if (mulSmallUnit(z, x, y)) return;
		op_.fp_mulUnit(z.v_, x.v_, y, op_.p);
	}
	static inline void inv(FpT& y, const FpT& x) { op_.fp_invOp(y.v_, x.v_, op_); }
	static inline void neg(FpT& y, const FpT& x) { op_.fp_neg(y.v_, x.v_, op_.p); }
	static inline void sqr(FpT& y, const FpT& x) { op_.fp_sqr(y.v_, x.v_, op_.p); }
	static inline void divBy2(FpT& y, const FpT& x)
	{
#if 0
		mul(y, x, inv2_);
#else
		bool odd = (x.v_[0] & 1) != 0;
		op_.fp_shr1(y.v_, x.v_);
		if (odd) {
			op_.fp_addPre(y.v_, y.v_, op_.half);
		}
#endif
	}
	static inline void divBy4(FpT& y, const FpT& x)
	{
		divBy2(y, x); // QQQ : optimize later
		divBy2(y, y);
	}
	bool isZero() const { return op_.fp_isZero(v_); }
	bool isOne() const { return fp::isEqualArray(v_, op_.oneRep, op_.N); }
	static const inline FpT& one() { return *reinterpret_cast<const FpT*>(op_.oneRep); }
	/*
		half = (p + 1) / 2
		return true if half <= x < p
		return false if 0 <= x < half
	*/
	bool isNegative() const
	{
		fp::Block b;
		getBlock(b);
		return fp::isGreaterOrEqualArray(b.p, op_.half, op_.N);
	}
	bool isValid() const
	{
		return fp::isLessArray(v_, op_.p, op_.N);
	}
	uint64_t getUint64(bool *pb = 0) const
	{
		fp::Block b;
		getBlock(b);
		return fp::getUint64(pb, b);
	}
	int64_t getInt64(bool *pb = 0) const
	{
		fp::Block b;
		getBlock(b);
		return fp::getInt64(pb, b, op_);
	}
	bool operator==(const FpT& rhs) const { return fp::isEqualArray(v_, rhs.v_, op_.N); }
	bool operator!=(const FpT& rhs) const { return !operator==(rhs); }
	friend inline std::ostream& operator<<(std::ostream& os, const FpT& self)
	{
		return os << self.getStr(fp::detectIoMode(getIoMode(), os));
	}
	friend inline std::istream& operator>>(std::istream& is, FpT& self)
	{
		return self.readStream(is, fp::detectIoMode(getIoMode(), is));
	}
	/*
		@note
		this compare functions is slow because of calling mul if isMont is true.
	*/
	static inline int compare(const FpT& x, const FpT& y)
	{
		fp::Block xb, yb;
		x.getBlock(xb);
		y.getBlock(yb);
		return fp::compareArray(xb.p, yb.p, op_.N);
	}
	bool isLess(const FpT& rhs) const
	{
		fp::Block xb, yb;
		getBlock(xb);
		rhs.getBlock(yb);
		return fp::isLessArray(xb.p, yb.p, op_.N);
	}
	bool operator<(const FpT& rhs) const { return isLess(rhs); }
	bool operator>=(const FpT& rhs) const { return !operator<(rhs); }
	bool operator>(const FpT& rhs) const { return rhs < *this; }
	bool operator<=(const FpT& rhs) const { return !operator>(rhs); }
	/*
		@note
		return unexpected order if isMont is set.
	*/
	static inline int compareRaw(const FpT& x, const FpT& y)
	{
		return fp::compareArray(x.v_, y.v_, op_.N);
	}
	bool isLessRaw(const FpT& rhs) const
	{
		return fp::isLessArray(v_, rhs.v_, op_.N);
	}
	/*
		set IoMode for operator<<(), or operator>>()
	*/
	static inline void setIoMode(int ioMode)
	{
		if (ioMode_ & ~0xff) throw cybozu::Exception("FpT:setIoMode:bad mode") << ioMode;
		ioMode_ = ioMode;
	}
	static inline int getIoMode() { return ioMode_; }
	// backward compatibility
	static inline void setModulo(const std::string& mstr, fp::Mode mode = fp::FP_AUTO)
	{
		init(mstr, mode);
	}
	static inline size_t getModBitLen() { return getBitSize(); }
};

template<class tag, size_t maxBitSize> fp::Op FpT<tag, maxBitSize>::op_;
template<class tag, size_t maxBitSize> FpT<tag, maxBitSize> FpT<tag, maxBitSize>::inv2_;
template<class tag, size_t maxBitSize> int FpT<tag, maxBitSize>::ioMode_ = IoAuto;

} // mcl

#ifdef CYBOZU_USE_BOOST
namespace mcl {

template<class tag, size_t maxBitSize>
size_t hash_value(const mcl::FpT<tag, maxBitSize>& x, size_t v = 0)
{
	return static_cast<size_t>(cybozu::hash64(x.getUnit(), x.getUnitSize(), v));
}

}
#else
namespace std { CYBOZU_NAMESPACE_TR1_BEGIN

template<class tag, size_t maxBitSize>
struct hash<mcl::FpT<tag, maxBitSize> > {
	size_t operator()(const mcl::FpT<tag, maxBitSize>& x, uint64_t v = 0) const
	{
		return static_cast<size_t>(cybozu::hash64(x.getUnit(), x.getUnitSize(), v));
	}
};

CYBOZU_NAMESPACE_TR1_END } // std::tr1
#endif

#ifdef _WIN32
	#pragma warning(pop)
#endif
