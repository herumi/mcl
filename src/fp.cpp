#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <mcl/conversion.hpp>
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

inline const char *verifyStr(bool *isMinus, int *base, const std::string& str)
{
	const char *p = str.c_str();
	if (*p == '-') {
		*isMinus = true;
		p++;
	} else {
		*isMinus = false;
	}
	if (p[0] == '0') {
		if (p[1] == 'x') {
			if (*base != 0 && *base != 16) {
				throw cybozu::Exception("fp:verifyStr:bad base") << *base << str;
			}
			*base = 16;
			p += 2;
		} else if (p[1] == 'b') {
			if (*base != 0 && *base != 2) {
				throw cybozu::Exception("fp:verifyStr:bad base") << *base << str;
			}
			*base = 2;
			p += 2;
		}
	}
	if (*base == 0) *base = 10;
	if (*p == '\0') throw cybozu::Exception("fp:verifyStr:str is empty");
	return p;
}

bool strToMpzArray(size_t *pBitSize, Unit *y, size_t maxBitSize, mpz_class& x, const std::string& str, int base)
{
	bool isMinus;
	const char *p = verifyStr(&isMinus, &base, str);
	if (!Gmp::setStr(x, p, base)) {
		throw cybozu::Exception("fp:strToMpzArray:bad format") << str;
	}
	const size_t bitSize = Gmp::getBitSize(x);
	if (bitSize > maxBitSize) throw cybozu::Exception("fp:strToMpzArray:too large str") << str << bitSize << maxBitSize;
	if (pBitSize) *pBitSize = bitSize;
	Gmp::getArray(y, (maxBitSize + UnitBitSize - 1) / UnitBitSize, x);
	return isMinus;
}

template<size_t bitSize>
struct OpeFunc {
	static const size_t N = (bitSize + UnitBitSize - 1) / UnitBitSize;
	static inline void set_mpz_t(mpz_t& z, const Unit* p, int n = (int)N)
	{
		z->_mp_alloc = n;
		z->_mp_size = getNonZeroArraySize(p, n);
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
		Gmp::getArray(z, N, mz);
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
		Gmp::getArray(z, N, mz);
	}
	static inline void mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpz_t mx, my, mz;
		set_zero(mz, z, N * 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_mul(mz, mx, my);
		Gmp::getArray(z, N * 2, mz);
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
		Gmp::getArray(y, N, my);
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
		mulPreP = mcl_fp_mulPre ## n; \
		mont = mcl_fp_mont ## n;
#else
	#define SET_OP_LLVM(n)
#endif

#define SET_OP(n) \
		N = n / UnitBitSize; \
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
	Unit r[maxOpUnitSize];
	int k = op.preInv(r, x);
	/*
		xr = 2^k
		R = 2^(N * 64)
		get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
	*/
	op.mul(y, r, op.invTbl.data() + k * op.N);
}

static void initInvTbl(Op& op)
{
	const size_t N = op.N;
	const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	op.invTbl.resize(invTblN * N);
	Unit *tbl = op.invTbl.data() + (invTblN - 1) * N;
	Unit t[maxOpUnitSize] = {};
	t[0] = 2;
	op.toMont(tbl, t);
	for (size_t i = 0; i < invTblN - 1; i++) {
		op.add(tbl - N, tbl, tbl);
		tbl -= N;
	}
}

static void initForMont(Op& op, const Unit *p)
{
	const size_t N = op.N;
	assert(N >= 2);
	mpz_class t = 1;
	Gmp::getArray(op.one, N, t);
	t = (t << (N * 64)) % op.mp;
	t = (t * t) % op.mp;
	Gmp::getArray(op.RR, N, t);
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

	initInvTbl(op);
}
#endif

void Op::init(const std::string& mstr, int base, size_t maxBitSize, Mode mode)
{
	bool isMinus = fp::strToMpzArray(&bitSize, p, maxBitSize, mp, mstr, base);
	if (isMinus) throw cybozu::Exception("Op:init:mstr is minus") << mstr;
	if (mp == 0) throw cybozu::Exception("Op:init:mstr is zero") << mstr;

	const size_t roundBit = (bitSize + UnitBitSize - 1) & ~(UnitBitSize - 1);
#ifdef MCL_USE_LLVM
	rp = getMontgomeryCoeff(p[0]);
#endif
	switch (roundBit) {
	case 32:
	case 64:
	case 96:
	case 128: SET_OP(128); break;
	case 192: SET_OP(192); break;
	case 256: SET_OP(256); break;
	case 320: SET_OP(320); break;
	case 384: SET_OP(384); break;
	case 448: SET_OP(448); break;
	case 512: SET_OP(512); break;
#if CYBOZU_OS_BIT == 64
	case 576: SET_OP(576); break;
#else
	case 160: SET_OP(160); break;
	case 224: SET_OP(224); break;
	case 288: SET_OP(288); break;
	case 352: SET_OP(352); break;
	case 416: SET_OP(416); break;
	case 480: SET_OP(480); break;
	case 544: SET_OP(544); break;
#endif
	default:
		throw cybozu::Exception("Op::init:not:support") << mstr;
	}
#ifdef MCL_USE_LLVM
	if (mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		mul = &mcl_fp_mul_NIST_P192; // slower than MontFp192
	}
#endif
	if (mode == FP_XBYAK) {
#ifdef USE_MONT_FP
		fp::initForMont(*this, p);
#endif
	}
	sq.set(mp);
}

void arrayToStr(std::string& str, const Unit *x, size_t n, int base, bool withPrefix)
{
	switch (base) {
	case 10:
		{
			mpz_class t;
			Gmp::setArray(t, x, n);
			Gmp::getStr(str, t, 10);
		}
		return;
	case 16:
		mcl::fp::toStr16(str, x, n, withPrefix);
		return;
	case 2:
		mcl::fp::toStr2(str, x, n, withPrefix);
		return;
	default:
		throw cybozu::Exception("fp:arrayToStr:bad base") << base;
	}
}

void copyAndMask(Unit *y, const void *x, size_t xByteSize, const Op& op, bool doMask)
{
	const size_t fpByteSize = sizeof(Unit) * op.N;
	if (xByteSize > fpByteSize) {
		if (!doMask) throw cybozu::Exception("fp:copyAndMask:bad size") << xByteSize << fpByteSize;
		xByteSize = fpByteSize;
	}
	memcpy(y, x, xByteSize);
	memset((char *)y + xByteSize, 0, fpByteSize - xByteSize);
	if (!doMask) {
		if (compareArray(y, op.p, op.N) >= 0) throw cybozu::Exception("fp:copyAndMask:large x");
		return;
	}
	maskArray(y, op.N, op.bitSize - 1);
	assert(compareArray(y, op.p, op.N) < 0);
}

} } // mcl::fp

