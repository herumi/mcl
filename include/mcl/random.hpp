#pragma once
/**
	@file
	@brief random generator
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
#else
#include <cybozu/random_generator.hpp>
#endif

namespace mcl {

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
inline std::random_device& getRandomGenerator()
{
	static std::random_device rd;
	return rd;
}
#else

inline cybozu::RandomGenerator& getRandomGenerator()
{
	static cybozu::RandomGenerator rg;
	return rg;
}

#endif

} // mcl
