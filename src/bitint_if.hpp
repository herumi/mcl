#pragma once
/*
	interface of bitint
*/
#include <mcl/config.hpp>

namespace mcl {  namespace bint {

size_t divFullBit256(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y);

} } // mcl::bint

