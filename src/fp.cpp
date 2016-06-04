#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include "conversion.hpp"
#ifdef MCL_USE_XBYAK
#include "fp_generator.hpp"
#endif
#include "fp_proto.hpp"

#ifdef _MSC_VER
	#pragma warning(disable : 4127)
#endif

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
	if (!gmp::setStr(x, p, base)) {
		throw cybozu::Exception("fp:strToMpzArray:bad format") << str;
	}
	const size_t bitSize = gmp::getBitSize(x);
	if (bitSize > maxBitSize) throw cybozu::Exception("fp:strToMpzArray:too large str") << str << bitSize << maxBitSize;
	if (pBitSize) *pBitSize = bitSize;
	gmp::getArray(y, (maxBitSize + UnitBitSize - 1) / UnitBitSize, x);
	return isMinus;
}

template<size_t bitSize>
struct OpeFunc {
	static const size_t N = (bitSize + UnitBitSize - 1) / UnitBitSize;
	static inline void set_mpz_t(mpz_t& z, const Unit* p, int n = (int)N)
	{
		int s = n;
		while (s > 0) {
			if (p[s - 1]) break;
			s--;
		}
		z->_mp_alloc = n;
		z->_mp_size = s;
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
	static inline void fp_addPC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (mpn_add_n(z, x, y, N)) {
			mpn_sub_n(z, z, p, N);
			return;
		}
		Unit tmp[N];
		if (mpn_sub_n(tmp, z, p, N) == 0) {
			memcpy(z, tmp, sizeof(tmp));
		}
	}
	static inline void fp_subPC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (mpn_sub_n(z, x, y, N)) {
			mpn_add_n(z, z, p, N);
		}
	}
	static inline void set_pDbl(mpz_t& mp, Unit *pDbl, const Unit *p)
	{
		memset(pDbl, 0, N * sizeof(Unit));
		memcpy(pDbl + N, p, N * sizeof(Unit));
		set_mpz_t(mp, pDbl, N * 2);
	}
	/*
		z[N * 2] <- x[N * 2] + y[N * 2] mod p[N] << (N * UnitBitSize)
	*/
	static inline void fpDbl_addPC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (mpn_add_n(z, x, y, N * 2)) {
			mpn_sub_n(z + N, z + N, p, N);
			return;
		}
		Unit tmp[N];
		if (mpn_sub_n(tmp, z + N, p, N) == 0) {
			memcpy(z + N, tmp, sizeof(tmp));
		}
	}
	static inline void fpDbl_subPC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (mpn_sub_n(z, x, y, N * 2)) {
			mpn_add_n(z + N, z + N, p, N);
		}
	}
	// z[N] <- x[N] + y[N] without carry
	static inline void fp_addNCC(Unit *z, const Unit *x, const Unit *y)
	{
		mpn_add_n(z, x, y, N);
	}
	static inline void fp_subNCC(Unit *z, const Unit *x, const Unit *y)
	{
		mpn_sub_n(z, x, y, N);
	}
	// z[N + 1] <- x[N] * y
	static inline void fp_mul_UnitPreC(Unit *z, const Unit *x, Unit y)
	{
		z[N] = mpn_mul_1(z, x, N, y);
	}
	// z[N * 2] <- x[N] * y[N]
	static inline void fpDbl_mulPreC(Unit *z, const Unit *x, const Unit *y)
	{
		mpn_mul_n(z, x, y, N);
	}
	// y[N * 2] <- x[N]^2
	static inline void fpDbl_sqrPreC(Unit *y, const Unit *x)
	{
		mpn_sqr(y, x, N);
	}
	// y[N] <- x[N + 1] mod p[N]
	static inline void fpN1_modPC(Unit *y, const Unit *x, const Unit *p)
	{
		Unit q[2]; // not used
		mpn_tdiv_qr(q, y, 0, x, N + 1, p, N);
	}
	// y[N] <- x[N * 2] mod p[N]
	static inline void fpDbl_modPC(Unit *y, const Unit *x, const Unit *p)
	{
		Unit q[N + 1]; // not used
		mpn_tdiv_qr(q, y, 0, x, N * 2, p, N);
	}
	static inline void fp_invOpC(Unit *y, const Unit *x, const Op& op)
	{
		mpz_class my;
		mpz_t mx, mp;
		set_mpz_t(mx, x);
		set_mpz_t(mp, op.p);
		mpz_invert(my.get_mpz_t(), mx, mp);
		gmp::getArray(y, N, my);
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
		fp_subPC(y, p, x, p);
	}
};

#ifdef MCL_USE_LLVM
	#define SET_OP_LLVM(n) \
		if (mode == FP_LLVM || mode == FP_LLVM_MONT) { \
			fp_addP = mcl_fp_add ## n ##S; \
			fp_subP = mcl_fp_sub ## n ##S; \
			if (!isFullBit) { \
				fp_addNC = mcl_fp_addNC ## n; \
				fp_subNC = mcl_fp_subNC ## n; \
			} \
			fpDbl_mulPre = mcl_fpDbl_mulPre ## n; \
			fp_mul_UnitPre = mcl_fp_mul_UnitPre ## n; \
			if (n <= 256) { \
				fpDbl_sqrPre = mcl_fpDbl_sqrPre ## n; \
			} \
			montPU = mcl_fp_mont ## n; \
			montRedPU = mcl_fp_montRed ## n; \
		}
	#define SET_OP_DBL_LLVM(n, n2) \
		if (mode == FP_LLVM || mode == FP_LLVM_MONT) { \
			if (n <= 256) { \
				fpDbl_addP = mcl_fpDbl_add ## n; \
				fpDbl_subP = mcl_fpDbl_sub ## n; \
				if (!isFullBit) { \
					fpDbl_addNC = mcl_fp_addNC ## n2; \
					fpDbl_subNC = mcl_fp_subNC ## n2; \
				} \
			} \
		}
#else
	#define SET_OP_LLVM(n)
	#define SET_OP_DBL_LLVM(n, n2)
#endif

#define SET_OP(n) \
		N = n / UnitBitSize; \
		fp_isZero = OpeFunc<n>::fp_isZeroC; \
		fp_clear = OpeFunc<n>::fp_clearC; \
		fp_copy = OpeFunc<n>::fp_copyC; \
		fp_negP = OpeFunc<n>::fp_negC; \
		if (isMont) { \
			fp_invOp = OpeFunc<n>::fp_invMontOpC; \
		} else { \
			fp_invOp = OpeFunc<n>::fp_invOpC; \
		} \
		fp_addP = OpeFunc<n>::fp_addPC; \
		fp_subP = OpeFunc<n>::fp_subPC; \
		if (n <= 256) { \
			fpDbl_addP = OpeFunc<n>::fpDbl_addPC; \
			fpDbl_subP = OpeFunc<n>::fpDbl_subPC; \
		} \
		if (isFullBit) { \
			fp_addNC = fp_add; \
			fp_subNC = fp_sub; \
			fpDbl_addNC = fpDbl_add; \
			fpDbl_subNC = fpDbl_sub; \
		} else { \
			fp_addNC = OpeFunc<n>::fp_addNCC; \
			fp_subNC = OpeFunc<n>::fp_subNCC; \
			if (n <= 256) { \
				fpDbl_addNC = OpeFunc<n * 2>::fp_addNCC; \
				fpDbl_subNC = OpeFunc<n * 2>::fp_subNCC; \
			} \
		} \
		fp_mul_UnitPre = OpeFunc<n>::fp_mul_UnitPreC; \
		fpN1_modP = OpeFunc<n>::fpN1_modPC; \
		fpDbl_mulPre = OpeFunc<n>::fpDbl_mulPreC; \
		fpDbl_sqrPre = OpeFunc<n>::fpDbl_sqrPreC; \
		fpDbl_modP = OpeFunc<n>::fpDbl_modPC; \
		SET_OP_LLVM(n)

#ifdef MCL_USE_XBYAK
inline void invOpForMontC(Unit *y, const Unit *x, const Op& op)
{
	Unit r[maxOpUnitSize];
	int k = op.fp_preInv(r, x);
	/*
		S = UnitBitSize
		xr = 2^k
		R = 2^(N * S)
		get r2^(-k)R^2 = r 2^(N * S * 2 - k)
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
		gmp::getArray(op.one, N, t);
		R = (t << (N * UnitBitSize)) % op.mp;
		t = (R * R) % op.mp;
		gmp::getArray(op.R2, N, t);
		t = (R * R * R) % op.mp;
		gmp::getArray(op.R3, N, t);
	}
	op.rp = getMontgomeryCoeff(p[0]);
	if (mode != FP_XBYAK) return;
#ifdef MCL_USE_XBYAK
	FpGenerator *fg = op.fg;
	if (fg == 0) return;
	fg->init(op);

	if (op.isMont && N <= 4) {
		op.fp_invOp = &invOpForMontC;
		initInvTbl(op);
	}
#endif
}

void Op::init(const std::string& mstr, int base, size_t maxBitSize, Mode mode)
{
	if (maxBitSize > MCL_MAX_OP_BIT_SIZE) {
		throw cybozu::Exception("Op:init:too large maxBitSize") << maxBitSize << MCL_MAX_OP_BIT_SIZE;
	}
	cybozu::disable_warning_unused_variable(mode);
	bool isMinus = fp::strToMpzArray(&bitSize, p, maxBitSize, mp, mstr, base);
	if (isMinus) throw cybozu::Exception("Op:init:mstr is minus") << mstr;
	if (mp == 0) throw cybozu::Exception("Op:init:mstr is zero") << mstr;
	isFullBit = (bitSize % UnitBitSize) == 0;

	const size_t roundBit = (bitSize + UnitBitSize - 1) & ~(UnitBitSize - 1);
	primeMode = PM_GENERIC;
#if defined(MCL_USE_LLVM) || defined(MCL_USE_XBYAK)
	if ((mode == FP_AUTO || mode == FP_LLVM || mode == FP_XBYAK)
		&& mp == mpz_class("0xfffffffffffffffffffffffffffffffeffffffffffffffff")) {
		primeMode = PM_NICT_P192;
		isMont = false;
		isFastMod = true;
	}
	if ((mode == FP_AUTO || mode == FP_LLVM || mode == FP_XBYAK)
		&& mp == mpz_class("0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")) {
		primeMode = PM_NICT_P521;
		isMont = false;
		isFastMod = true;
	}
#endif
	switch (roundBit) {
	case 32:
	case 64:
	case 96:
	case 128: SET_OP(128); SET_OP_DBL_LLVM(128, 256); break;
	case 192: SET_OP(192); SET_OP_DBL_LLVM(192, 384); break;
	case 256: SET_OP(256); SET_OP_DBL_LLVM(256, 512); break;
	case 320: SET_OP(320); break;
	case 384: SET_OP(384); break;
	case 448: SET_OP(448); break;
	case 512: SET_OP(512); break;
#if CYBOZU_OS_BIT == 64
	case 576: SET_OP(576); break;
#else
	case 160: SET_OP(160); SET_OP_DBL_LLVM(160, 320); break;
	case 224: SET_OP(224); SET_OP_DBL_LLVM(224, 448); break;
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
	if (primeMode == PM_NICT_P192) {
		fp_mul = &mcl_fp_mul_NIST_P192;
		fp_sqr = &mcl_fp_sqr_NIST_P192;
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P192;
	}
	if (primeMode == PM_NICT_P521) {
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P521;
	}
#endif
	fp::initForMont(*this, p, mode);
	sq.set(mp);
}

void arrayToStr(std::string& str, const Unit *x, size_t n, int base, bool withPrefix)
{
	switch (base) {
	case 10:
		{
			mpz_class t;
			gmp::setArray(t, x, n);
			gmp::getStr(str, t, 10);
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

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4146)
#endif

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

#ifdef _WIN32
	#pragma warning(pop)
#endif

void Op::initFp2(int _xi_a)
{
	this->xi_a = _xi_a;
//	if (N * UnitBitSize != 256) throw cybozu::Exception("Op2:init:not support size") << N;
}

} } // mcl::fp

