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

template<size_t bitN>
struct OpeFunc {
	typedef fp::Unit Unit;
	static const size_t N = (bitN + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	static inline void set_mpz_t(mpz_t& z, const Unit* p, int n = (int)N)
	{
		z->_mp_alloc = n;
		int i = n;
		while (i > 0 && p[i - 1] == 0) {
			i--;
		}
		z->_mp_size = i;
		z->_mp_d = (mp_limb_t*)const_cast<Unit*>(p);
	}
	static inline void set_zero(mpz_t& z, Unit *p, size_t n)
	{
		z->_mp_alloc = (int)n;
		z->_mp_size = 0;
		z->_mp_d = (mp_limb_t*)p;
	}
	static inline void clearC(Unit *x)
	{
		local::clearArray(x, 0, N);
	}
	static inline void copyC(Unit *y, const Unit *x)
	{
		local::copyArray(y, x, N);
	}
	static inline void addC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit ret[N + 2]; // not N + 1
		mpz_t mz, mx, my, mp;
		set_zero(mz, ret, N + 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_add(mz, mx, my);
		if (mpz_cmp(mz, mp) >= 0) {
			mpz_sub(mz, mz, mp);
		}
		local::toArray(z, N, mz);
	}
	static inline void subC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit ret[N + 1];
		mpz_t mz, mx, my;
		set_zero(mz, ret, N + 1);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_sub(mz, mx, my);
		if (mpz_sgn(mz) < 0) {
			mpz_t mp;
			set_mpz_t(mp, p);
			mpz_add(mz, mz, mp);
		}
		local::toArray(z, N, mz);
	}
	static inline void mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpz_t mx, my, mz;
		set_zero(mz, z, N * 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_mul(mz, mx, my);
		local::toArray(z, N * 2, mz);
	}
	// x[N * 2] -> y[N]
	static inline void modC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_t mx, my, mp;
		set_mpz_t(mx, x, N * 2);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_mod(my, mx, mp);
		local::clearArray(y, my->_mp_size, N);
	}
	static inline void invC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_class my;
		mpz_t mx, mp;
		set_mpz_t(mx, x);
		set_mpz_t(mp, p);
		mpz_invert(my.get_mpz_t(), mx, mp);
		local::toArray(y, N, my.get_mpz_t());
	}
	static inline bool isZeroC(const Unit *x)
	{
		return local::isZeroArray(x, N);
	}
	static inline void negC(Unit *y, const Unit *x, const Unit *p)
	{
		if (isZeroC(x)) {
			if (x != y) clearC(y);
			return;
		}
		subC(y, p, x, p);
	}
};

void initOpByLLVM(Op& op, const Unit* /*p*/, size_t bitLen)
{
	assert(sizeof(mp_limb_t) == sizeof(Unit));
	const size_t UnitBitN = sizeof(Unit) * 8;

	if (bitLen <= 128) {
		op.N = 128 / UnitBitN;
		op.isZero = OpeFunc<128>::isZeroC;
		op.clear = OpeFunc<128>::clearC;
		op.copy = OpeFunc<128>::copyC;
		op.negG = OpeFunc<128>::negC;
		op.invG = OpeFunc<128>::invC;
		op.addG = OpeFunc<128>::addC;
		op.subG = OpeFunc<128>::subC;
		op.mulPreG = OpeFunc<128>::mulPreC;
		op.modG = OpeFunc<128>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add128S;
		op.subG = mcl_fp_sub128S;
		op.mulPreG = mcl_fp_mulPre128;
#endif
	} else
#if CYBOZU_OS_BIT == 32
	if (bitLen <= 160) {
		op.N = 160 / UnitBitN;
		op.isZero = OpeFunc<160>::isZeroC;
		op.clear = OpeFunc<160>::clearC;
		op.copy = OpeFunc<160>::copyC;
		op.negG = OpeFunc<160>::negC;
		op.invG = OpeFunc<160>::invC;
		op.addG = OpeFunc<160>::addC;
		op.subG = OpeFunc<160>::subC;
		op.mulPreG = OpeFunc<160>::mulPreC;
		op.modG = OpeFunc<160>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add160S;
		op.subG = mcl_fp_sub160S;
		op.mulPreG = mcl_fp_mulPre160;
#endif
	} else
#endif
	if (bitLen <= 192) {
		op.N = 192 / UnitBitN;
		op.isZero = OpeFunc<192>::isZeroC;
		op.clear = OpeFunc<192>::clearC;
		op.copy = OpeFunc<192>::copyC;
		op.negG = OpeFunc<192>::negC;
		op.invG = OpeFunc<192>::invC;
		op.addG = OpeFunc<192>::addC;
		op.subG = OpeFunc<192>::subC;
		op.mulPreG = OpeFunc<192>::mulPreC;
		op.modG = OpeFunc<192>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add192S;
		op.subG = mcl_fp_sub192S;
		op.mulPreG = mcl_fp_mulPre192;
#endif
	} else
#if CYBOZU_OS_BIT == 32
	if (bitLen <= 224) {
		op.N = 224 / UnitBitN;
		op.isZero = OpeFunc<224>::isZeroC;
		op.clear = OpeFunc<224>::clearC;
		op.copy = OpeFunc<224>::copyC;
		op.negG = OpeFunc<224>::negC;
		op.invG = OpeFunc<224>::invC;
		op.addG = OpeFunc<224>::addC;
		op.subG = OpeFunc<224>::subC;
		op.mulPreG = OpeFunc<224>::mulPreC;
		op.modG = OpeFunc<224>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add224S;
		op.subG = mcl_fp_sub224S;
		op.mulPreG = mcl_fp_mulPre224;
#endif
	} else
#endif
	if (bitLen <= 256) {
		op.N = 256 / UnitBitN;
		op.isZero = OpeFunc<256>::isZeroC;
		op.clear = OpeFunc<256>::clearC;
		op.copy = OpeFunc<256>::copyC;
		op.negG = OpeFunc<256>::negC;
		op.invG = OpeFunc<256>::invC;
		op.addG = OpeFunc<256>::addC;
		op.subG = OpeFunc<256>::subC;
		op.mulPreG = OpeFunc<256>::mulPreC;
		op.modG = OpeFunc<256>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add256S;
		op.subG = mcl_fp_sub256S;
		op.mulPreG = mcl_fp_mulPre256;
#endif
	} else
	if (bitLen <= 384) {
		op.N = 384 / UnitBitN;
		op.isZero = OpeFunc<384>::isZeroC;
		op.clear = OpeFunc<384>::clearC;
		op.copy = OpeFunc<384>::copyC;
		op.negG = OpeFunc<384>::negC;
		op.invG = OpeFunc<384>::invC;
		op.addG = OpeFunc<384>::addC;
		op.subG = OpeFunc<384>::subC;
		op.mulPreG = OpeFunc<384>::mulPreC;
		op.modG = OpeFunc<384>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add384S;
		op.subG = mcl_fp_sub384S;
		op.mulPreG = mcl_fp_mulPre384;
#endif
	} else
#if CYBOZU_OS_BIT == 64
	if (bitLen <= 576) {
		op.N = 576 / UnitBitN;
		op.isZero = OpeFunc<576>::isZeroC;
		op.clear = OpeFunc<576>::clearC;
		op.copy = OpeFunc<576>::copyC;
		op.negG = OpeFunc<576>::negC;
		op.invG = OpeFunc<576>::invC;
		op.addG = OpeFunc<576>::addC;
		op.subG = OpeFunc<576>::subC;
		op.mulPreG = OpeFunc<576>::mulPreC;
		op.modG = OpeFunc<576>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add576S;
		op.subG = mcl_fp_sub576S;
		op.mulPreG = mcl_fp_mulPre576;
#endif
	}
#else
	if (bitLen <= 544) {
		op.N = 544 / UnitBitN;
		op.isZero = OpeFunc<544>::isZeroC;
		op.clear = OpeFunc<544>::clearC;
		op.copy = OpeFunc<544>::copyC;
		op.negG = OpeFunc<544>::negC;
		op.invG = OpeFunc<544>::invC;
		op.addG = OpeFunc<544>::addC;
		op.subG = OpeFunc<544>::subC;
		op.mulPreG = OpeFunc<544>::mulPreC;
		op.modG = OpeFunc<544>::modC;
#ifdef MCL_USE_LLVM
		op.addG = mcl_fp_add544S;
		op.subG = mcl_fp_sub544S;
		op.mulPreG = mcl_fp_mulPre544;
#endif
	}
#endif

#ifdef MCL_USE_LLVM
	if (op.mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		op.mul = &mcl_fp_mul_NIST_P192; // slower than MontFp192
	}
#endif
}

} } // mcl::fp

