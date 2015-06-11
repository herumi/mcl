#pragma once
/**
	@file
	@brief window method
	@author MITSUNARI Shigeo(@herumi)
*/
#include <vector>
#include <mcl/fp.hpp>

namespace mcl { namespace fp {

/*
	get w-bit size from x[0, bitSize)
	@param x [in] data
	@param bitSize [in] data size
	@param w [in] split size < UnitBitSize
*/
template<class T>
struct ArrayIterator {
	static const size_t TbitSize = sizeof(T) * 8;
	ArrayIterator(const T *x, size_t bitSize, size_t w)
		: x(x)
		, bitSize(bitSize)
		, w(w)
		, pos(0)
		, mask((w == TbitSize ? 0 : (T(1) << w)) - 1)
	{
		assert(w <= TbitSize);
	}
	bool hasNext() const { return bitSize > 0; }
	T getNext()
	{
		if (w == TbitSize) {
			bitSize -= w;
			return *x++;
		}
		if (pos + w < TbitSize) {
			T v = (*x >> pos) & mask;
			pos += w;
			if (bitSize < w) {
				bitSize = 0;
			} else {
				bitSize -= w;
			}
			return v;
		}
		if (pos + bitSize <= TbitSize) {
			assert(bitSize <= w);
			T v = *x >> pos;
			assert((v >> bitSize) == 0);
			bitSize = 0;
			return v & mask;
		}
		assert(pos > 0);
		T v = (x[0] >> pos) | (x[1] << (TbitSize - pos));
		v &= mask;
		pos = (pos + w) - TbitSize;
		bitSize -= w;
		x++;
		return v;
	}
	const T *x;
	size_t bitSize;
	size_t w;
	size_t pos;
	T mask;
};

template<class Ec>
class WindowMethod {
public:
	typedef std::vector<Ec> EcV;
	size_t bitSize_;
	size_t winSize_;
	std::vector<EcV> tbl_;
	WindowMethod(const Ec& x, size_t bitSize, size_t winSize)
	{
		init(x, bitSize, winSize);
	}
	WindowMethod()
		: bitSize_(0)
		, winSize_(0)
	{
	}
	/*
		@param x [in] base index
		@param bitSize [in] exponent bit length
		@param winSize [in] window size
	*/
	void init(const Ec& x, size_t bitSize, size_t winSize)
	{
		bitSize_ = bitSize;
		winSize_ = winSize;
		const size_t tblNum = (bitSize + winSize - 1) / winSize;
		const size_t r = size_t(1) << winSize;
		tbl_.resize(tblNum);
		Ec t(x);
		for (size_t i = 0; i < tblNum; i++) {
			tbl_[i].resize(r);
			EcV& w = tbl_[i];
			for (size_t d = 1; d < r; d *= 2) {
				for (size_t j = 0; j < d; j++) {
					Ec::add(w[j + d], w[j], t);
				}
				Ec::dbl(t, t);
			}
		}
	}
	/*
		@param z [out] x multiplied by y
		@param y [in] exponent
	*/
	template<class tag2, size_t maxBitSize2>
	void mul(Ec& z, const FpT<tag2, maxBitSize2>& y) const
	{
		fp::Block b;
		y.getBlock(b);
		powerArray(z, b.p, b.n, false);
	}
	void mul(Ec& z, int y) const
	{
		Unit u = std::abs(y);
		powerArray(z, &u, 1, y < 0);
	}
	void mul(Ec& z, const mpz_class& y) const
	{
		powerArray(z, Gmp::getUnit(y), abs(y.get_mpz_t()->_mp_size), y < 0);
	}
	void powerArray(Ec& z, const Unit* y, size_t n, bool isNegative) const
	{
		z.clear();
		while (n > 0) {
			if (y[n - 1]) break;
			n--;
		}
		if (n == 0) return;
		if (n > tbl_.size()) throw cybozu::Exception("mcl:WindowMethod:powerArray:bad n") << n << tbl_.size();
		assert(y[n - 1]);
		const size_t bitSize = (n - 1) * UnitBitSize + cybozu::bsr<Unit>(y[n - 1]) + 1;
		size_t i = 0;
		ArrayIterator<Unit> ai(y, bitSize, winSize_);
		do {
			Unit v = ai.getNext();
			if (v) {
				Ec::add(z, z, tbl_[i][v]);
			}
			i++;
		} while (ai.hasNext());
		if (isNegative) {
			Ec::neg(z, z);
		}
	}
};

} } // mcl::fp

