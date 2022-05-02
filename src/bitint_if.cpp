#include "bitint.hpp"
#include <mcl/bitint_if.hpp>

namespace mcl {  namespace bint {

size_t divFullBit4(uint64_t *q, size_t qn, uint64_t *x, size_t xn, const uint64_t *y)
{
	return divFullBitT<FuncT<4>, 4>(q, qn, x, xn, y);
}

} } // mcl::bint
