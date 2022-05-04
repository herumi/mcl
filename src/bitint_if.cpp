#include "bitint.hpp"
#include <mcl/bitint_if.hpp>

namespace mcl {  namespace bint {

size_t divFullBit4(Unit *q, size_t qn, Unit *x, size_t xn, const Unit *y)
{
	return divFullBitT<4>(q, qn, x, xn, y);
}

} } // mcl::bint
