#include <mcl/fp_base.hpp>

namespace mcl { namespace fp {
//void setOp(mcl::fp::Op& op, const Unit* p, size_t pBitLen)
void setOp(mcl::fp::Op&, const Unit*, size_t)
{
#if 0
#ifdef USE_MONT_FP
	if (pBitLen <= 128) {  op = fp::MontFp<tag, 128>::init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 160) { static fp::MontFp<tag, 160> f; op = f.init(p); }
#endif
	else if (pBitLen <= 192) { static fp::MontFp<tag, 192> f; op = f.init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 224) { static fp::MontFp<tag, 224> f; op = f.init(p); }
#endif
	else if (pBitLen <= 256) { static fp::MontFp<tag, 256> f; op = f.init(p); }
	else if (pBitLen <= 384) { static fp::MontFp<tag, 384> f; op = f.init(p); }
	else if (pBitLen <= 448) { static fp::MontFp<tag, 448> f; op = f.init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 544) { static fp::MontFp<tag, 544> f; op = f.init(p); }
#else
	else if (pBitLen <= 576) { static fp::MontFp<tag, 576> f; op = f.init(p); }
#endif
	else { static fp::MontFp<tag, maxBitN> f; op = f.init(p); }
#else
	if (pBitLen <= 128) {  op = fp::FixedFp<tag, 128>::init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 160) { static fp::FixedFp<tag, 160> f; op = f.init(p); }
#endif
	else if (pBitLen <= 192) { static fp::FixedFp<tag, 192> f; op = f.init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 224) { static fp::FixedFp<tag, 224> f; op = f.init(p); }
#endif
	else if (pBitLen <= 256) { static fp::FixedFp<tag, 256> f; op = f.init(p); }
	else if (pBitLen <= 384) { static fp::FixedFp<tag, 384> f; op = f.init(p); }
	else if (pBitLen <= 448) { static fp::FixedFp<tag, 448> f; op = f.init(p); }
#if CYBOZU_OS_BIT == 32
	else if (pBitLen <= 544) { static fp::FixedFp<tag, 544> f; op = f.init(p); }
#else
	else if (pBitLen <= 576) { static fp::FixedFp<tag, 576> f; op = f.init(p); }
#endif
	else { static fp::FixedFp<tag, maxBitN> f; op = f.init(p); }
#endif
	assert(op.N <= maxUnitN);
#endif
}

} } // mcl::fp

