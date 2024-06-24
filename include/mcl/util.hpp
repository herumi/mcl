#pragma once
/**
	@file
	@brief functions for T[]
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cybozu/bit_operation.hpp>

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4456)
	#pragma warning(disable : 4459)
#endif

namespace mcl { namespace fp {

// some environments do not have utility
inline uint32_t abs_(int32_t x)
{
	if (x >= 0) return uint32_t(x);
	// avoid undefined behavior
	if (x == -2147483647 - 1) return 2147483648u;
	return uint32_t(-x);
}

inline uint64_t abs_(int64_t x)
{
	if (x >= 0) return uint64_t(x);
	// avoid undefined behavior
	if (x == -9223372036854775807ll - 1) return 9223372036854775808ull;
	return uint64_t(-x);
}

template<class T>
T min_(T x, T y) { return x < y ? x : y; }

template<class T>
T max_(T x, T y) { return x < y ? y : x; }

template<class T>
void swap_(T& x, T& y)
{
	T t;
	t = x;
	x = y;
	y = t;
}

// return T(x[0:xN] >> bitPos) if bitPos < sizeof(T) * xN else 0
template<class T>
T getUnitAt(const T *x, size_t xN, size_t bitPos)
{
	const size_t TbitSize = sizeof(T) * 8;
	if (bitPos >= TbitSize * xN) return 0;
	const size_t q = bitPos / TbitSize;
	const size_t r = bitPos % TbitSize;
	if (r == 0) return x[q];
	if (q == xN - 1) return x[q] >> r;
	return (x[q] >> r) | (x[q + 1] << (TbitSize - r));
}

template<class T>
size_t getBitSize(const T *x, size_t n)
{
	while (n > 0 && (x[n - 1] == 0)) {
		n--;
	}
	if (n == 0) {
		return 0;
	}
	return (n - 1) * sizeof(T) * 8 + 1 + cybozu::bsr<T>(x[n - 1]);
}

template<class T>
class BitIterator {
	const T *x_;
	size_t bitPos_;
	size_t bitSize_;
	size_t w_;
	T mask_;
	static const size_t TbitSize = sizeof(T) * 8;
public:
	explicit BitIterator(const T *x = 0, size_t n = 0)
	{
		init(x, n);
	}
	void init(const T *x, size_t n)
	{
		x_ = x;
		bitPos_ = 0;
		bitSize_ = mcl::fp::getBitSize(x, n);
	}
	size_t getBitSize() const { return bitSize_; }
	bool hasNext() const { return bitPos_ < bitSize_; }
	T getNext(size_t w)
	{
		assert(0 < w && w <= TbitSize);
		if (!hasNext()) return 0;
		const size_t q = bitPos_ / TbitSize;
		const size_t r = bitPos_ % TbitSize;
		const size_t remain = bitSize_ - bitPos_;
		if (w > remain) w = remain;
		T v = x_[q] >> r;
#if defined(__GNUC__) && !defined(__EMSCRIPTEN__) && !defined(__clang__)
	// avoid gcc wrong detection
	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Warray-bounds"
#endif
		if (r + w > TbitSize) {
			v |= x_[q + 1] << (TbitSize - r);
		}
#if defined(__GNUC__) && !defined(__EMSCRIPTEN__) && !defined(__clang__)
	#pragma GCC diagnostic pop
#endif
		bitPos_ += w;
		return v & mask(w);
	}
	// whethere next bit is 1 or 0 (bitPos is not moved)
	bool peekBit() const
	{
//		assert(hasNext());
		if (!hasNext()) return 0;
		const size_t q = bitPos_ / TbitSize;
		const size_t r = bitPos_ % TbitSize;
		return (x_[q] >> r) & 1;
	}
	void skipBit()
	{
		assert(hasNext());
		bitPos_++;
	}
	T mask(size_t w) const
	{
		assert(w <= TbitSize);
		return (w == TbitSize ? T(0) : (T(1) << w)) - 1;
	}
};

/*
	shortcut of multiplication by Unit
*/
template<class T, class U>
bool mulSmallUnit(T& z, const T& x, U y)
{
	switch (y) {
	case 0: z.clear(); break;
	case 1: z = x; break;
	case 2: T::add(z, x, x); break;
	case 3: { T t; T::add(t, x, x); T::add(z, t, x); break; }
	case 4: T::add(z, x, x); T::add(z, z, z); break;
	case 5: { T t; T::add(t, x, x); T::add(t, t, t); T::add(z, t, x); break; }
	case 6: { T t; T::add(t, x, x); T::add(t, t, x); T::add(z, t, t); break; }
	case 7: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, t); T::sub(z, t, x); break; }
	case 8: T::add(z, x, x); T::add(z, z, z); T::add(z, z, z); break;
	// slower than SmallModP
#if 0
	case 9: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, t); T::add(z, t, x); break; }
	case 10: { T t; T::add(t, x, x); T::add(t, t, t); T::add(t, t, x); T::add(z, t, t); break; }
	case 11: { T t; T::add(t, x, x); T::add(t, t, x); T::add(t, t, t); T::add(t, t, t); T::sub(z, t, x); break; }
	case 12: { T t; T::add(t, x, x); T::add(t, t, t); T::add(z, t, t); T::add(z, z, t); break; }
#endif
	default:
		return false;
	}
	return true;
}

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
