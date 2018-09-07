#pragma once
/**
	@file
	@brief XorShift

	@author MITSUNARI Shigeo(@herumi)
	@author MITSUNARI Shigeo
*/
#include <cybozu/inttype.hpp>

namespace cybozu {

class XorShift {
	uint32_t x_, y_, z_, w_;
public:
	explicit XorShift(uint32_t x = 0, uint32_t y = 0, uint32_t z = 0, uint32_t w = 0)
	{
		init(x, y, z, w);
	}
	void init(uint32_t x = 0, uint32_t y = 0, uint32_t z = 0, uint32_t w = 0)
	{
		x_ = x ? x : 123456789;
		y_ = y ? y : 362436069;
		z_ = z ? z : 521288629;
		w_ = w ? w : 88675123;
	}
	uint32_t get32()
	{
		unsigned int t = x_ ^ (x_ << 11);
		x_ = y_; y_ = z_; z_ = w_;
		return w_ = (w_ ^ (w_ >> 19)) ^ (t ^ (t >> 8));
	}
	uint32_t operator()() { return get32(); }
	uint64_t get64()
	{
		uint32_t a = get32();
		uint32_t b = get32();
		return (uint64_t(a) << 32) | b;
	}
	template<class T>
	void read(T *x, size_t n)
	{
		const size_t size = sizeof(T) * n;
		uint8_t *p8 = static_cast<uint8_t*>(x);
		for (size_t i = 0; i < size; i++) {
			p8[i] = static_cast<uint8_t>(get32());
		}
	}
	void read(uint32_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get32();
		}
	}
	void read(uint64_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get64();
		}
	}
};

// see http://xorshift.di.unimi.it/xorshift128plus.c
class XorShift128Plus {
	uint64_t s_[2];
	static const uint64_t seed0 = 123456789;
	static const uint64_t seed1 = 987654321;
public:
	explicit XorShift128Plus(uint64_t s0 = seed0, uint64_t s1 = seed1)
	{
		init(s0, s1);
	}
	void init(uint64_t s0 = seed0, uint64_t s1 = seed1)
	{
		s_[0] = s0;
		s_[1] = s1;
	}
	uint32_t get32()
	{
		return static_cast<uint32_t>(get64());
	}
	uint64_t operator()() { return get64(); }
	uint64_t get64()
	{
		uint64_t s1 = s_[0];
		const uint64_t s0 = s_[1];
		s_[0] = s0;
		s1 ^= s1 << 23;
		s_[1] = s1 ^ s0 ^ (s1 >> 18) ^ (s0 >> 5);
		return s_[1] + s0;
	}
	template<class T>
	void read(T *x, size_t n)
	{
		const size_t size = sizeof(T) * n;
		uint8_t *p8 = static_cast<uint8_t*>(x);
		for (size_t i = 0; i < size; i++) {
			p8[i] = static_cast<uint8_t>(get32());
		}
	}
	void read(uint32_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get32();
		}
	}
	void read(uint64_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get64();
		}
	}
};

// see http://xoroshiro.di.unimi.it/xoroshiro128plus.c
class Xoroshiro128Plus {
	uint64_t s_[2];
	static const uint64_t seed0 = 123456789;
	static const uint64_t seed1 = 987654321;
	uint64_t rotl(uint64_t x, unsigned int k) const
	{
		return (x << k) | (x >> (64 - k));
	}
public:
	explicit Xoroshiro128Plus(uint64_t s0 = seed0, uint64_t s1 = seed1)
	{
		init(s0, s1);
	}
	void init(uint64_t s0 = seed0, uint64_t s1 = seed1)
	{
		s_[0] = s0;
		s_[1] = s1;
	}
	uint32_t get32()
	{
		return static_cast<uint32_t>(get64());
	}
	uint64_t operator()() { return get64(); }
	uint64_t get64()
	{
		uint64_t s0 = s_[0];
		uint64_t s1 = s_[1];
		uint64_t result = s0 + s1;
		s1 ^= s0;
		s_[0] = rotl(s0, 55) ^ s1 ^ (s1 << 14);
		s_[1] = rotl(s1, 36);
		return result;
	}
	template<class T>
	void read(T *x, size_t n)
	{
		const size_t size = sizeof(T) * n;
		uint8_t *p8 = static_cast<uint8_t*>(x);
		for (size_t i = 0; i < size; i++) {
			p8[i] = static_cast<uint8_t>(get32());
		}
	}
	void read(uint32_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get32();
		}
	}
	void read(uint64_t *x, size_t n)
	{
		for (size_t i = 0; i < n; i++) {
			x[i] = get64();
		}
	}
};

} // cybozu
