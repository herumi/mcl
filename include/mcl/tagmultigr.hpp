#pragma once
/**
	@file
	@brief TagMultiGr
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <assert.h>

namespace mcl {

// default tag is for multiplicative group
template<class G>
struct TagMultiGr {
	static void square(G& z, const G& x)
	{
		G::mul(z, x, x);
	}
	static void mul(G& z, const G& x, const G& y)
	{
		G::mul(z, x, y);
	}
	static void inv(G& z, const G& x)
	{
		G::inv(z, x);
	}
	static void div(G& z, const G& x, const G& y)
	{
		G::div(z, x, y);
	}
	static void init(G& x)
	{
		x = 1;
	}
};

} // mcl

