#pragma once
/**
	@brief NTT (number theoretic transform) for BLS12-381
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <cybozu/inttype.hpp>

namespace mcl {

namespace local {

// sec[i] = u^i fo i = 0, 1, 2, ..., n-1
template<class T>
inline void initPowSeq(T* sec, const T& u, size_t n)
{
	if (n == 0) return;
	sec[0] = 1;
	if (n == 1) return;
	sec[1] = u;
	for (size_t i = 2; i < n; i++) {
		T::mul(sec[i], sec[i - 1], u);
	}
}

struct BitReverse {
	uint8_t tbl_[256];
	BitReverse()
	{
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl_); i++) {
			tbl_[i] = uint8_t(genericRev(i, 8));
		}
	}
	// bit reverse of x with size xBit
	static inline uint64_t genericRev(uint64_t x, size_t xBit)
	{
		uint64_t v = 0;
		for (size_t i = 0; i < xBit; i++) {
			v <<= 1;
			if (x & 1) v |= 1;
			x >>= 1;
		}
		return v;
	}
	uint64_t rev(uint64_t x, size_t xBit) const
	{
//		return genericRev(x, xBit);
		if (xBit <= 8) {
			return tbl_[x & 0xff] >> (8 - xBit);
		}
		uint64_t v = tbl_[x & 0xff];
		for (;;) {
			v <<= 8;
			x >>= 8;
			v |= uint64_t(tbl_[x & 0xff]);
			xBit -= 8;
			if (xBit <= 8) {
				return v >> (8 - xBit);
			}
		}
	}
	/*
		v[i] = v[rev(i, bitN)] for i in range(1 << bitN)
	*/
	template<class T>
	void revArray(T *v, size_t bitN) const
	{
		const size_t n = size_t(1) << bitN;
		for (size_t i = 0; i < n; i++) {
			size_t j = rev(i, bitN);
			if (i < j) {
				T tmp = v[i];
				v[i] = v[j];
				v[j] = tmp;
			}
		}
	}
};

} // mcl::local

template<class Fr>
struct Ntt {
	local::BitReverse br_;
	Fr root_; // (r-1)/(2^32)
	Fr w_;
	Fr invN_;
	bool isAllocated_;
	Fr *ws_; // [N + 1];
	size_t N_;

	Ntt()
		: isAllocated_(false)
		, ws_(0)
		, N_(0)
	{
		// 32 and 5 are for BLS12-381
#if 1
		bool b;
		root_.setStr(&b, "212d79e5b416b6f0fd56dc8d168d6c0c4024ff270b3e0941b788f500b912f1f", 16);
		assert(b); (void)b;
#else
		const Fr g = 5; // generator of Fr^*
		// e=(r-1)/(2^32)
		Vint e = (Fr::getOp().mp - 1) >> 32;
		Fr::pow(root_, g, e);
#endif
	}
	void clean()
	{
		if (isAllocated_) {
			free(ws_);
			ws_ = 0;
			isAllocated_ = false;
		}
	}
	~Ntt()
	{
		clean();
	}

	bool verifyN(size_t N) const
	{
		return N > 0 && (N & (N - 1)) == 0;
	}
	static size_t requiredByteSize(size_t N)
	{
		return sizeof(Fr) * (N + 1);
	}
	// use malloc if buffer == 0, or buffer must have requiredByteSize(N)
	bool init(size_t N, void *buffer = 0)
	{
		if (!verifyN(N)) return false;
		clean();
		if (buffer) {
			ws_ = reinterpret_cast<Fr*>(buffer);
		} else {
			ws_ = (Fr*)malloc(requiredByteSize(N));
			if (ws_ == 0) {
				return false;
			}
			isAllocated_ = true;
		}
		N_ = N;
		// w = 2^maxBitN-th root of 1
		Fr w;
		Fr::pow(w, root_, (int64_t(1) << 32) / N);
		local::initPowSeq(ws_, w, N + 1);
		Fr::inv(invN_, N);
		return true;
	}
	const Fr& getW() const { return ws_[1]; }
	const Fr& getInvW() const { return ws_[N_ - 1]; }
	const Fr *getWs() const { return ws_; }
	/*
		assume N is a power of two
		xs[i] = sum_{j=0}^{inN-1} xs[j] getW(i)^j for i = 0, ..., N-1
	*/
	template<class G>
	bool _ntt(G *xs, size_t N, const Fr *ws, bool inv) const
	{
		if (!verifyN(N)) return false;
		if (N == 1) return true;
		const size_t bitN = cybozu::bsr(N);
		br_.revArray(xs, bitN);
		size_t h = N;
		for (size_t L = 1; L < N; L *= 2) {
			h >>= 1;
			for (size_t i = 0; i < N; i += L*2) {
				size_t idx = 0;
				for (size_t j = i; j < L + i; j++) {
					G tmp;
					G::mul(tmp, xs[j + L], ws[inv ? N - idx : idx]);
					G::sub(xs[j + L], xs[j], tmp);
					G::add(xs[j], xs[j], tmp);
					idx += h;
				}
			}
		}
		if (inv) {
			for (size_t i = 0; i < N; i++) {
				G::mul(xs[i], xs[i], invN_);
			}
		}
		return true;
	}
	template<class G>
	bool ntt(G *xs, size_t N) const { return _ntt(xs, N, ws_, false); }
	template<class G>
	bool intt(G *xs, size_t N) const { return _ntt(xs, N, ws_, true); }
};

} // mcl

