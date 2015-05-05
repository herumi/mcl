#pragma once
/**
	@file
	@brief power
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <assert.h>
#include <cybozu/bit_operation.hpp>
#include <mcl/tagmultigr.hpp>
#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4616)
	#pragma warning(disable : 4800)
	#pragma warning(disable : 4244)
	#pragma warning(disable : 4127)
	#pragma warning(disable : 4512)
	#pragma warning(disable : 4146)
#endif
#include <gmpxx.h>
#ifdef _MSC_VER
	#pragma warning(pop)
#endif

namespace mcl {

namespace power_impl {

template<class F>
struct TagInt {
	typedef typename F::BlockType BlockType;
	static size_t getBlockSize(const F& x)
	{
		return F::getBlockSize(x);
	}
	static BlockType getBlock(const F& x, size_t i)
	{
		return F::getBlock(x, i);
	}
	static const BlockType* getBlock(const F& x)
	{
		return F::getBlock(x);
	}
	static size_t getBitLen(const F& x)
	{
		return F::getBitLen(x);
	}
	static void shr(F& x, size_t n)
	{
		F::shr(x, x, n);
	}
};

template<>
struct TagInt<int> {
	typedef int BlockType;
	static int getBlockSize(int)
	{
		return 1;
	}
	static BlockType getBlock(int x, size_t i)
	{
		assert(i == 0);
		cybozu::disable_warning_unused_variable(i);
		return x;
	}
	static const BlockType* getBlock(const int& x)
	{
		return &x;
	}
	static size_t getBitLen(int x)
	{
		return x == 0 ? 1 : cybozu::bsr(x) + 1;
	}
	static void shr(int& x, size_t n)
	{
		x >>= n;
	}
};

template<>
struct TagInt<size_t> {
	typedef size_t BlockType;
	static size_t getBlockSize(size_t)
	{
		return 1;
	}
	static BlockType getBlock(size_t x, size_t i)
	{
		assert(i == 0);
		cybozu::disable_warning_unused_variable(i);
		return x;
	}
	static const BlockType* getBlock(const size_t& x)
	{
		return &x;
	}
	static size_t getBitLen(size_t x)
	{
		return x == 0 ? 1 : cybozu::bsr<size_t>(x) + 1;
	}
	static void shr(size_t& x, size_t n)
	{
		x >>= n;
	}
};

template<>
struct TagInt<mpz_class> {
	typedef mp_limb_t BlockType;
	static size_t getBlockSize(const mpz_class& x)
	{
		return x.get_mpz_t()->_mp_size;
	}
	static BlockType getBlock(const mpz_class& x, size_t i)
	{
		return x.get_mpz_t()->_mp_d[i];
	}
	static const BlockType* getBlock(const mpz_class& x)
	{
		return x.get_mpz_t()->_mp_d;
	}
	static size_t getBitLen(const mpz_class& x)
	{
		return mpz_sizeinbase(x.get_mpz_t(), 2);
	}
	static void shr(mpz_class& x, size_t n)
	{
		x >>= n;
	}
};

template<class G, class BlockType>
void powerArray(G& z, const G& x, const BlockType *y, size_t n)
{
	typedef TagMultiGr<G> TagG;
	G out;
	TagG::init(out);
	G t(x);
	for (size_t i = 0; i < n; i++) {
		BlockType v = y[i];
		int m = (int)sizeof(BlockType) * 8;
		if (i == n - 1) {
			// avoid unused multiplication
			while (m > 0 && (v & (BlockType(1) << (m - 1))) == 0) {
				m--;
			}
		}
		for (int j = 0; j < m; j++) {
			if (v & (BlockType(1) << j)) {
				TagG::mul(out, out, t);
			}
			TagG::square(t, t);
		}
	}
	z = out;
}

template<class G, class F>
void power(G& z, const G& x, const F& _y)
{
	typedef TagMultiGr<G> TagG;
	typedef power_impl::TagInt<F> TagI;
	if (_y == 0) {
		TagG::init(z);
		return;
	}
	if (_y == 1) {
		z = x;
		return;
	}
	bool isNegative = _y < 0;
	const F& y = isNegative ? -_y : _y;
	powerArray(z, x, TagI::getBlock(y), TagI::getBlockSize(y));
	if (isNegative) {
		TagG::inv(z, z);
	}
}

} } // mcl::power_impl
