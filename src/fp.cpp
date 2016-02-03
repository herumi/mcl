#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <mcl/conversion.hpp>
#ifdef MCL_USE_XBYAK
#include <mcl/fp_generator.hpp>
#endif
#include <mcl/fp_proto.hpp>

namespace mcl { namespace fp {

#ifdef MCL_USE_XBYAK
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
		z->_mp_size = (int)getNonZeroArraySize(p, n);
		z->_mp_d = (mp_limb_t*)const_cast<Unit*>(p);
	}
	static inline void set_zero(mpz_t& z, Unit *p, size_t n)
	{
		z->_mp_alloc = (int)n;
		z->_mp_size = 0;
		z->_mp_d = (mp_limb_t*)p;
	}
	static inline void fp_clearC(Unit *x)
	{
		clearArray(x, 0, N);
	}
	static inline void fp_copyC(Unit *y, const Unit *x)
	{
		copyArray(y, x, N);
	}
	static inline void fp_addC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
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
	static inline void fp_subC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
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
	// z[N * 2] <- x[N] * y[N]
	static inline void fp_mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpz_t mx, my, mz;
		set_zero(mz, z, N * 2);
		set_mpz_t(mx, x);
		set_mpz_t(my, y);
		mpz_mul(mz, mx, my);
		clearArray(z, mz->_mp_size, N * 2);
	}
	// y[N * 2] <- x[N]^2
	static inline void fp_sqrPreC(Unit *y, const Unit *x)
	{
		mpz_t mx, my;
		set_zero(my, y, N * 2);
		set_mpz_t(mx, x);
		mpz_mul(my, mx, mx);
		clearArray(y, my->_mp_size, N * 2);
	}
	// y[N] <- x[N * 2] mod p[N]
	static inline void fp_modC(Unit *y, const Unit *x, const Unit *p)
	{
		mpz_t mx, my, mp;
		set_mpz_t(mx, x, N * 2);
		set_mpz_t(my, y);
		set_mpz_t(mp, p);
		mpz_mod(my, mx, mp);
		clearArray(y, my->_mp_size, N);
	}
	static inline void fp_invOpC(Unit *y, const Unit *x, const Op& op)
	{
		mpz_class my;
		mpz_t mx, mp;
		set_mpz_t(mx, x);
		set_mpz_t(mp, op.p);
		mpz_invert(my.get_mpz_t(), mx, mp);
		Gmp::getArray(y, N, my);
	}
	/*
		inv(xR) = (1/x)R^-1 -toMont-> 1/x -toMont-> (1/x)R
	*/
	static void fp_invMontOpC(Unit *y, const Unit *x, const Op& op)
	{
		fp_invOpC(y, x, op);
		op.fp_mul(y, y, op.R3);
	}
	static inline bool fp_isZeroC(const Unit *x)
	{
		return isZeroArray(x, N);
	}
	static inline void fp_negC(Unit *y, const Unit *x, const Unit *p)
	{
		if (fp_isZeroC(x)) {
			if (x != y) fp_clearC(y);
			return;
		}
		fp_subC(y, p, x, p);
	}
};

#ifdef MCL_USE_LLVM
	#define SET_OP_LLVM(n) \
		if (mode == FP_LLVM || mode == FP_LLVM_MONT) { \
			fp_addP = mcl_fp_add ## n ##S; \
			fp_subP = mcl_fp_sub ## n ##S; \
			fp_mulPreP = mcl_fp_mulPre ## n; \
			if (n <= 256) { \
				fp_sqrPreP = mcl_fp_sqrPre ## n; \
			} \
			mont = mcl_fp_mont ## n; \
		}
#else
	#define SET_OP_LLVM(n)
#endif

#define SET_OP(n) \
		N = n / UnitBitSize; \
		fp_isZero = OpeFunc<n>::fp_isZeroC; \
		fp_clear = OpeFunc<n>::fp_clearC; \
		fp_copy = OpeFunc<n>::fp_copyC; \
		fp_negP = OpeFunc<n>::fp_negC; \
		if (useMont) { \
			fp_invOp = OpeFunc<n>::fp_invMontOpC; \
		} else { \
			fp_invOp = OpeFunc<n>::fp_invOpC; \
		} \
		fp_addP = OpeFunc<n>::fp_addC; \
		fp_subP = OpeFunc<n>::fp_subC; \
		fp_mulPreP = OpeFunc<n>::fp_mulPreC; \
		fp_sqrPreP = OpeFunc<n>::fp_sqrPreC; \
		fp_modP = OpeFunc<n>::fp_modC; \
		SET_OP_LLVM(n)

#ifdef MCL_USE_XBYAK
inline void invOpForMontC(Unit *y, const Unit *x, const Op& op)
{
	Unit r[maxOpUnitSize];
	int k = op.fp_preInv(r, x);
	/*
		xr = 2^k
		R = 2^(N * 64)
		get r2^(-k)R^2 = r 2^(N * 64 * 2 - k)
	*/
	op.fp_mul(y, r, op.invTbl.data() + k * op.N);
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
		op.fp_add(tbl - N, tbl, tbl);
		tbl -= N;
	}
}
#endif

static void initForMont(Op& op, const Unit *p, Mode mode)
{
	const size_t N = op.N;
	assert(N >= 2);
	{
		mpz_class t = 1, R;
		Gmp::getArray(op.one, N, t);
		R = (t << (N * 64)) % op.mp;
		t = (R * R) % op.mp;
		Gmp::getArray(op.R2, N, t);
		t = (R * R * R) % op.mp;
		Gmp::getArray(op.R3, N, t);
	}
	op.rp = getMontgomeryCoeff(p[0]);
	if (mode != FP_XBYAK) return;
#ifdef MCL_USE_XBYAK
	FpGenerator *fg = op.fg;
	if (fg == 0) return;
	fg->init(p, (int)N);

	op.fp_neg = Xbyak::CastTo<void2u>(fg->neg_);
	op.fp_add = Xbyak::CastTo<void3u>(fg->add_);
	op.fp_sub = Xbyak::CastTo<void3u>(fg->sub_);
	op.fp_mul = Xbyak::CastTo<void3u>(fg->mul_);
	op.fp_sqr = Xbyak::CastTo<void2u>(fg->sqr_);
	if (N <= 4) {
		op.fp_preInv = Xbyak::CastTo<int2u>(op.fg->preInv_);
		op.fp_invOp = &invOpForMontC;
		initInvTbl(op);
	}

#endif
}

void Op::init(const std::string& mstr, int base, size_t maxBitSize, Mode mode)
{
	cybozu::disable_warning_unused_variable(mode);
	bool isMinus = fp::strToMpzArray(&bitSize, p, maxBitSize, mp, mstr, base);
	if (isMinus) throw cybozu::Exception("Op:init:mstr is minus") << mstr;
	if (mp == 0) throw cybozu::Exception("Op:init:mstr is zero") << mstr;

	const size_t roundBit = (bitSize + UnitBitSize - 1) & ~(UnitBitSize - 1);
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
	if (mode == FP_AUTO && mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		fp_mul = &mcl_fp_mul_NIST_P192;
		useMont = false;
	}
#endif
	if (useMont) {
		fp::initForMont(*this, p, mode);
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
		if (isGreaterOrEqualArray(y, op.p, op.N)) throw cybozu::Exception("fp:copyAndMask:large x");
		return;
	}
	maskArray(y, op.N, op.bitSize - 1);
	assert(isLessArray(y, op.p, op.N));
}

static bool isInUint64(uint64_t *pv, const fp::Block& b)
{
	assert(fp::UnitBitSize == 32 || fp::UnitBitSize == 64);
	const size_t start = 64 / fp::UnitBitSize;
	for (size_t i = start; i < b.n; i++) {
		if (b.p[i]) return false;
	}
#if CYBOZU_OS_BIT == 32
	*pv = b.p[0] | (uint64_t(b.p[1]) << 32);
#else
	*pv = b.p[0];
#endif
	return true;
}

uint64_t getUint64(bool *pb, const fp::Block& b)
{
	uint64_t v;
	if (isInUint64(&v, b)) {
		if (pb) *pb = true;
		return v;
	}
	if (!pb) {
		std::string str;
		arrayToStr(str, b.p, b.n, 10, false);
		throw cybozu::Exception("fp::getUint64:large value") << str;
	}
	*pb = false;
	return 0;
}

int64_t getInt64(bool *pb, fp::Block& b, const fp::Op& op)
{
	bool isNegative = false;
	if (fp::isGreaterArray(b.p, op.half, op.N)) {
		op.fp_neg(b.v_, b.p);
		b.p = b.v_;
		isNegative = true;
	}
	uint64_t v;
	if (fp::isInUint64(&v, b)) {
		const uint64_t c = uint64_t(1) << 63;
		if (isNegative) {
			if (v <= c) { // include c
				if (pb) *pb = true;
				if (v == c) return int64_t(-1) << 63;
				return int64_t(-v);
			}
		} else {
			if (v < c) { // not include c
				if (pb) *pb = true;
				return int64_t(v);
			}
		}
	}
	if (!pb) {
		std::string str;
		arrayToStr(str, b.p, b.n, 10, false);
		throw cybozu::Exception("fp::getInt64:large value") << str << isNegative;
	}
	*pb = false;
	return 0;
}

void Op::initFp2(int xi_c)
{
	if (N * UnitBitSize != 256) throw cybozu::Exception("Op2:init:not support size") << N;
	this->xi_c = xi_c;
}

} } // mcl::fp

