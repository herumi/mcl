#pragma once
/**
	@file
	@brief array iterator
	@author MITSUNARI Shigeo(@herumi)
*/
#include <assert.h>

namespace mcl { namespace fp {

/*
	get w-bit size from x[0, bitSize)
	@param x [in] data
	@param bitSize [in] data size
	@param w [in] split size < UnitBitSize
*/
template<class T>
class ArrayIterator {
	const T *x_;
	size_t bitSize_;
	const size_t w_;
	const T mask_;
	size_t pos_;
public:
	static const size_t TbitSize = sizeof(T) * 8;
	ArrayIterator(const T *x, size_t bitSize, size_t w)
		: x_(x)
		, bitSize_(bitSize)
		, w_(w)
		, mask_(makeMask(w))
		, pos_(0)
	{
		assert(w_ <= TbitSize);
	}
	static T makeMask(size_t w)
	{
		return (w == TbitSize) ? ~T(0) : (T(1) << w) - 1;
	}
	bool hasNext() const { return bitSize_ > 0; }
	T getNext(size_t w = 0)
	{
		if (w == 0) w = w_;
		assert(w <= TbitSize);
		if (w > bitSize_) {
			w = bitSize_;
		}
		if (!hasNext()) return 0;
		const T mask = w == w_ ? mask_ : makeMask(w);
		const size_t nextPos = pos_ + w;
		if (nextPos <= TbitSize) {
			T v = x_[0] >> pos_;
			if (nextPos < TbitSize) {
				pos_ = nextPos;
				v &= mask;
			} else {
				pos_ = 0;
				x_++;
			}
			bitSize_ -= w;
			return v;
		}
		T v = (x_[0] >> pos_) | (x_[1] << (TbitSize - pos_));
		v &= mask;
		pos_ = nextPos - TbitSize;
		bitSize_ -= w;
		x_++;
		return v;
	}
	// don't change iter
	bool peek1bit()
	{
		assert(hasNext());
		return (x_[0] >> pos_) & 1;
	}
	// ++iter
	void consume1bit()
	{
		assert(hasNext());
		const size_t nextPos = pos_ + 1;
		if (nextPos < TbitSize) {
			pos_ = nextPos;
		} else {
			pos_ = 0;
			x_++;
		}
		bitSize_ -= 1;
	}
};

} } // mcl::fp

