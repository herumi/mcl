#pragma once
/**
	@file
	@brief power window method
	@author MITSUNARI Shigeo(@herumi)
	@note
	Copyright (c) 2014, National Institute of Advanced Industrial
	Science and Technology All rights reserved.
	This source file is subject to BSD 3-Clause license.
*/
#include <vector>
#include <cybozu/exception.hpp>

namespace mcl {

template<class Ec>
class PowerWindow {
public:
	typedef TagMultiGr<Ec> TagG;
	typedef std::vector<Ec> EcV;
	typedef std::vector<EcV> EcVV;
	size_t bitLen_;
	size_t winSize_;
	EcVV tbl_;
	PowerWindow(const Ec& x, size_t bitLen, size_t winSize)
	{
		init(x, bitLen, winSize);
	}
	PowerWindow()
		: bitLen_(0)
		, winSize_(0)
	{
	}
	/*
		@param x [in] base index
		@param bitLen [in] exponent bit length
		@param winSize [in] window size
	*/
	void init(const Ec& x, size_t bitLen, size_t winSize)
	{
		bitLen_ = bitLen;
		winSize_ = winSize;
		const size_t tblNum = (bitLen + winSize) / winSize;
		const size_t r = size_t(1) << winSize;
		// alloc table
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
		@param z [out] x^y
		@param y [in] exponent
	*/
	template<class F>
	void power(Ec& z, const F& _y) const
	{
		typedef power_impl::TagInt<F> TagI;
		typedef typename TagI::BlockType BlockType;
		const Ec& x = tbl_[0][1];
		if (_y == 0) {
			TagG::init(z);
			return;
		}
		if (_y == 1) {
			z = x;
			return;
		}
		const bool isNegative = _y < 0;
		F y = isNegative ? -_y : _y;
		Ec out;
		TagG::init(out);
		const BlockType mask = (BlockType(1) << winSize_) - 1;
		size_t i = 0;
		while (y > 0) {
			BlockType v = TagI::getBlock(y, 0) & mask;
			assert(i < tbl_.size());
			if (i >= tbl_.size()) throw cybozu::Exception("mcl:PowerWindow:power:bad value") << _y << i << tbl_.size();
			Ec::add(out, out, tbl_[i][v]);
			TagI::shr(y, winSize_);
			i++;
		}
		z = out;
		if (isNegative) {
			Ec::neg(z, z);
		}
	}
	template<class F>
	void powerArray(Ec& z, const Unit* y, size_t yn) const
	{
		typedef power_impl::TagInt<F> TagI;
		typedef typename TagI::BlockType BlockType;
		const Ec& x = tbl_[0][1];
		if (_y == 0) {
			TagG::init(z);
			return;
		}
		if (_y == 1) {
			z = x;
			return;
		}
		const bool isNegative = _y < 0;
		F y = isNegative ? -_y : _y;
		Ec out;
		TagG::init(out);
		const BlockType mask = (BlockType(1) << winSize_) - 1;
		size_t i = 0;
		while (y > 0) {
			BlockType v = TagI::getBlock(y, 0) & mask;
			assert(i < tbl_.size());
			if (i >= tbl_.size()) throw cybozu::Exception("mcl:PowerWindow:power:bad value") << _y << i << tbl_.size();
			Ec::add(out, out, tbl_[i][v]);
			TagI::shr(y, winSize_);
			i++;
		}
		z = out;
		if (isNegative) {
			Ec::neg(z, z);
		}
	}
};

} // mcl
