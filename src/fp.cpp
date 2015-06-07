#include <mcl/op.hpp>
#ifdef USE_MONT_FP
#include <mcl/fp_generator.hpp>
#endif
#include <mcl/fp_proto.hpp>

namespace mcl { namespace fp {

#ifdef USE_MONT_FP
FpGenerator *Op::createFpGenerator()
{
	return new FpGenerator();
}
void Op::destroyFpGenerator(FpGenerator *fg)
{
	delete fg;
}
#else
FpGenerator *Op::createFpGenerator()
{
	return 0;
}
void Op::destroyFpGenerator(FpGenerator *)
{
}
#endif

template<size_t bitN>
struct OpeFunc {
	static const size_t N = (bitN + UnitBitN - 1) / UnitBitN;
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
		clearArray(x, 0, N);
	}
	static inline void copyC(Unit *y, const Unit *x)
	{
		copyArray(y, x, N);
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
		toArray(z, N, mz);
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
		toArray(z, N, mz);
	}
	static inline void mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpz_t mx, my, mz;
		set_zero(mz, z, N * 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_mul(mz, mx, my);
		toArray(z, N * 2, mz);
	}
	// x[N * 2] -> y[N]
	static inline void modC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_t mx, my, mp;
		set_mpz_t(mx, x, N * 2);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_mod(my, mx, mp);
		clearArray(y, my->_mp_size, N);
	}
	static inline void invOp(Unit *y, const Unit *x, const Op& op)
	{
		mpz_class my;
		mpz_t mx, mp;
		set_mpz_t(mx, x);
		set_mpz_t(mp, op.p);
		mpz_invert(my.get_mpz_t(), mx, mp);
		toArray(y, N, my.get_mpz_t());
	}
	static inline bool isZeroC(const Unit *x)
	{
		return isZeroArray(x, N);
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

#ifdef MCL_USE_LLVM
	#define SET_OP_LLVM(n) \
		addP = mcl_fp_add ## n ##S; \
		subP = mcl_fp_sub ## n ##S; \
		mulPreP = mcl_fp_mulPre ## n;
#else
	#define SET_OP_LLVM(n)
#endif

#define SET_OP(n) \
		N = n / UnitBitN; \
		isZero = OpeFunc<n>::isZeroC; \
		clear = OpeFunc<n>::clearC; \
		copy = OpeFunc<n>::copyC; \
		negP = OpeFunc<n>::negC; \
		invOp = OpeFunc<n>::invOp; \
		addP = OpeFunc<n>::addC; \
		subP = OpeFunc<n>::subC; \
		mulPreP = OpeFunc<n>::mulPreC; \
		modP = OpeFunc<n>::modC; \
		SET_OP_LLVM(n)

#ifdef USE_MONT_FP
inline void invOpForMont(Unit *y, const Unit *x, const Op& op)
{
	Unit r[maxOpUnitN];
	int k = op.preInv(r, x);
	/*
		xr = 2^k
		R = 2^(N * 64)
		get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
	*/
	op.mul(y, r, op.invTbl.data() + k * op.N);
}
static void fromRawGmp(Unit *y, size_t n, const mpz_class& x)
{
	toArray(y, n, x.get_mpz_t());
}
static void initInvTbl(Op& op, size_t N)
{
	assert(N <= maxOpUnitN);
	const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	op.invTbl.resize(invTblN * N);
	Unit *tbl = op.invTbl.data() + (invTblN - 1) * N;
	Unit t[maxOpUnitN] = {};
	t[0] = 2;
	op.toMont(tbl, t);
	for (size_t i = 0; i < invTblN - 1; i++) {
		op.add(tbl - N, tbl, tbl);
		tbl -= N;
	}
}

static void initForMont(Op& op, const Unit *p)
{
	size_t N = (op.bitLen + sizeof(Unit) * 8 - 1) / (sizeof(Unit) * 8);
	if (N < 2) N = 2;
	mpz_class t = 1;
	fromRawGmp(op.one, N, t);
	t = (t << (N * 64)) % op.mp;
	t = (t * t) % op.mp;
	fromRawGmp(op.RR, N, t);
	FpGenerator *fg = op.fg;
	if (fg == 0) return;
	fg->init(p, (int)N);

	op.neg = Xbyak::CastTo<void2u>(fg->neg_);
	op.add = Xbyak::CastTo<void3u>(fg->add_);
	op.sub = Xbyak::CastTo<void3u>(fg->sub_);
	op.mul = Xbyak::CastTo<void3u>(fg->mul_);
	op.preInv = Xbyak::CastTo<int2u>(op.fg->preInv_);
	op.invOp = &invOpForMont;
	op.useMont = true;

	initInvTbl(op, N);
}
#endif


void Op::init(const Unit* p, size_t bitLen)
{
	assert(sizeof(mp_limb_t) == sizeof(Unit));
	const size_t UnitBitN = sizeof(Unit) * 8;

	if (bitLen <= 128) {
		SET_OP(128)
	} else
#if CYBOZU_OS_BIT == 32
	if (bitLen <= 160) {
		SET_OP(160)
	} else
#endif
	if (bitLen <= 192) {
		SET_OP(192)
	} else
#if CYBOZU_OS_BIT == 32
	if (bitLen <= 224) {
		SET_OP(224)
	} else
#endif
	if (bitLen <= 256) {
		SET_OP(256)
	} else
	if (bitLen <= 384) {
		SET_OP(384)
	} else
#if CYBOZU_OS_BIT == 64
	if (bitLen <= 576) {
		SET_OP(576)
	}
#else
	if (bitLen <= 544) {
		SET_OP(544)
	}
#endif

#ifdef MCL_USE_LLVM
	if (mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		mul = &mcl_fp_mul_NIST_P192; // slower than MontFp192
	}
#endif
#ifdef USE_MONT_FP
	fp::initForMont(*this, p);
#endif
}

} } // mcl::fp

