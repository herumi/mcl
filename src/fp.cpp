#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include "conversion.hpp"
#ifdef MCL_USE_XBYAK
#include "fp_generator.hpp"
#endif
#include "fp_proto.hpp"
#include "low_gmp.hpp"

#ifdef _MSC_VER
	#pragma warning(disable : 4127)
#endif

namespace mcl {

namespace fp {

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

/*
	use prefix if base conflicts with prefix
*/
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
			*base = 16;
			p += 2;
		} else if (p[1] == 'b') {
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

const char *ModeToStr(Mode mode)
{
	switch (mode) {
	case FP_AUTO: return "auto";
	case FP_GMP: return "gmp";
	case FP_GMP_MONT: return "gmp_mont";
	case FP_LLVM: return "llvm";
	case FP_LLVM_MONT: return "llvm_mont";
	case FP_XBYAK: return "xbyak";
	default:
		throw cybozu::Exception("ModeToStr") << mode;
	}
}

Mode StrToMode(const std::string& s)
{
	static const struct {
		const char *s;
		Mode mode;
	} tbl[] = {
		{ "auto", FP_AUTO },
		{ "gmp", FP_GMP },
		{ "gmp_mont", FP_GMP_MONT },
		{ "llvm", FP_LLVM },
		{ "llvm_mont", FP_LLVM_MONT },
		{ "xbyak", FP_XBYAK },
	};
	for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
		if (s == tbl[i].s) return tbl[i].mode;
	}
	throw cybozu::Exception("StrToMode") << s;
}

#ifdef MCL_USE_LLVM

#define MCL_DEF_LLVM_FUNC(bit) \
template<>const u3u AddNC<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_addNC ## bit ## L; \
template<>const u3u SubNC<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_subNC ## bit ## L; \
template<>const void3u MulPre<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fpDbl_mulPre ## bit ## L; \
template<>const void2u SqrPre<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fpDbl_sqrPre ## bit ## L; \
template<>const void2uI Mul_UnitPre<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_mul_UnitPre ## bit ## L; \
template<>const void4u Add<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_add ## bit ## L; \
template<>const void4u Sub<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_sub ## bit ## L; \
template<>const void4u Mont<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_mont ## bit ## L; \
template<>const void3u MontRed<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fp_montRed ## bit ## L; \
template<>const void4u DblAdd<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fpDbl_add ## bit ## L; \
template<>const void4u DblSub<bit / mcl::fp::UnitBitSize, Ltag>::f = &mcl_fpDbl_sub ## bit ## L; \

template<size_t N>
struct Mul<N, Ltag> {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit xy[N * 2];
		MulPre<N, Ltag>::f(xy, x, y);
		Dbl_Mod<N, Gtag>::f(z, xy, p);
	}
	static const void4u f;
};

template<size_t N>
const void4u Mul<N, Ltag>::f = Mul<N, Ltag>::func;

template<size_t N>
struct Sqr<N, Ltag> {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		Unit xx[N * 2];
		SqrPre<N, Ltag>::f(xx, x);
		Dbl_Mod<N, Gtag>::f(y, xx, p);
	}
	static const void3u f;
};

template<size_t N>
const void3u Sqr<N, Ltag>::f = Sqr<N, Ltag>::func;

MCL_DEF_LLVM_FUNC(64)
MCL_DEF_LLVM_FUNC(128)
MCL_DEF_LLVM_FUNC(192)
MCL_DEF_LLVM_FUNC(256)
MCL_DEF_LLVM_FUNC(320)
MCL_DEF_LLVM_FUNC(384)
MCL_DEF_LLVM_FUNC(448)
MCL_DEF_LLVM_FUNC(512)
#if CYBOZU_OS_BIT == 32
MCL_DEF_LLVM_FUNC(32)
MCL_DEF_LLVM_FUNC(96)
MCL_DEF_LLVM_FUNC(160)
MCL_DEF_LLVM_FUNC(224)
MCL_DEF_LLVM_FUNC(288)
MCL_DEF_LLVM_FUNC(352)
MCL_DEF_LLVM_FUNC(416)
MCL_DEF_LLVM_FUNC(480)
MCL_DEF_LLVM_FUNC(544)
#else
MCL_DEF_LLVM_FUNC(576)
#endif

#endif

template<size_t N>
struct OpeFunc {
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
	// z[N] <- mont(x[N], y[N])
	static inline void fp_mulMontC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
#if 0
		Unit xy[N * 2];
		MulPre<N, Gtag>::f(xy, x, y);
		fpDbl_modMontC(z, xy, p);
#else
		const Unit rp = p[-1];
		Unit buf[N * 2 + 2];
		Unit *c = buf;
		Mul_UnitPre<N, Gtag>::f(c, x, y[0]); // x * y[0]
		Unit q = c[0] * rp;
		Unit t[N + 2];
		Mul_UnitPre<N, Gtag>::f(t, p, q); // p * q
		t[N + 1] = 0; // always zero
		c[N + 1] = AddNC<N + 1, Gtag>::f(c, c, t);
		c++;
		for (size_t i = 1; i < N; i++) {
			Mul_UnitPre<N, Gtag>::f(t, x, y[i]);
			c[N + 1] = AddNC<N + 1, Gtag>::f(c, c, t);
			q = c[0] * rp;
			Mul_UnitPre<N, Gtag>::f(t, p, q);
			AddNC<N + 2, Gtag>::f(c, c, t);
			c++;
		}
		if (c[N]) {
			SubNC<N, Gtag>::f(z, c, p);
		} else {
			if (SubNC<N, Gtag>::f(z, c, p)) {
				memcpy(z, c, N * sizeof(Unit));
			}
		}
#endif
	}
	/*
		z[N] <- montRed(xy[N * 2])
		REMARK : assume p[-1] = rp
	*/
	static inline void fpDbl_modMontC(Unit *z, const Unit *xy, const Unit *p)
	{
		const Unit rp = p[-1];
		Unit t[N * 2];
		Unit buf[N * 2 + 1];
		clearArray(t, N + 1, N * 2);
		Unit *c = buf;
		Unit q = xy[0] * rp;
		Mul_UnitPre<N, Gtag>::f(t, p, q);
		buf[N * 2] = AddNC<N * 2, Gtag>::f(buf, xy, t);
		c++;
		for (size_t i = 1; i < N; i++) {
			q = c[0] * rp;
			Mul_UnitPre<N, Gtag>::f(t, p, q);
			// QQQ
			mpn_add_n((mp_limb_t*)c, (const mp_limb_t*)c, (const mp_limb_t*)t, N * 2 + 1 - i);
			c++;
		}
		if (c[N]) {
			SubNC<N, Gtag>::f(z, c, p);
		} else {
			if (SubNC<N, Gtag>::f(z, c, p)) {
				memcpy(z, c, N * sizeof(Unit));
			}
		}
	}
	static inline void fp_mul_UnitC(Unit *z, const Unit *x, Unit y, const Unit *p)
	{
		Unit xy[N + 1];
		Mul_UnitPre<N, Gtag>::f(xy, x, y);
		N1_Mod<N, Gtag>::f(z, xy, p);
	}
	static inline void fp_mulC(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit xy[N * 2];
		MulPre<N, Gtag>::f(xy, x, y);
		Dbl_Mod<N, Gtag>::f(z, xy, p);
	}
	static inline void fp_sqrC(Unit *y, const Unit *x, const Unit *p)
	{
		Unit xx[N * 2];
		SqrPre<N, Gtag>::f(xx, x);
		Dbl_Mod<N, Gtag>::f(y, xx, p);
	}
	static inline void fp_sqrMontC(Unit *y, const Unit *x, const Unit *p)
	{
		Unit xx[N * 2];
		SqrPre<N, Gtag>::f(xx, x);
		fpDbl_modMontC(y, xx, p);
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
		op.fp_mul(y, y, op.R3, op.p);
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
		SubNC<N, Gtag>::f(y, p, x);
	}
};

template<size_t N, bool enable>
struct SetOpLLVM2 {
	static inline void set(Op&, Mode) {}
};

template<size_t N>
struct SetOpLLVM2<N, true> {
	static inline void set(Op& op, Mode mode)
	{
		if (mode != FP_LLVM && mode != FP_LLVM_MONT) return;
		if (!op.isFullBit) {
			op.fpDbl_addNC = AddNC<N * 2, Ltag>::f;
			op.fpDbl_subNC = SubNC<N * 2, Ltag>::f;
		}
	}
};

template<size_t N>
void setOpLLVM(Op& op, Mode mode)
{
	if (mode != FP_LLVM && mode != FP_LLVM_MONT) return;
	op.fp_add = Add<N, Ltag>::f;
	op.fp_sub = Sub<N, Ltag>::f;
	op.fpDbl_add = DblAdd<N, Ltag>::f;
	op.fpDbl_sub = DblSub<N, Ltag>::f;
	if (mode == FP_LLVM_MONT) {
		op.fp_mul = Mont<N, Ltag>::f;
		op.fp_sqr = SqrMont<N, Ltag>::f;
		op.fpDbl_mod = MontRed<N, Ltag>::f;
	} else {
		op.fp_mul = Mul<N, Ltag>::f;
		op.fp_sqr = Sqr<N, Ltag>::f;
	}
	op.fpDbl_mulPre = MulPre<N, Ltag>::f;
	op.fpDbl_sqrPre = SqrPre<N, Ltag>::f;
	op.fp_mul_UnitPre = Mul_UnitPre<N, Ltag>::f;
	if (!op.isFullBit) {
		op.fp_addNC = AddNC<N, Ltag>::f;
		op.fp_subNC = SubNC<N, Ltag>::f;
	}
}

template<size_t N>
void setOp(Op& op, Mode mode)
{
	op.fp_isZero = OpeFunc<N>::fp_isZeroC;
	op.fp_clear = OpeFunc<N>::fp_clearC;
	op.fp_copy = OpeFunc<N>::fp_copyC;
	op.fp_neg = OpeFunc<N>::fp_negC;
	op.fp_add = Add<N, Gtag>::f;
	op.fp_sub = Sub<N, Gtag>::f;
	if (op.isMont) {
		op.fp_mul = OpeFunc<N>::fp_mulMontC;
		op.fp_sqr = OpeFunc<N>::fp_sqrMontC;
		op.fp_invOp = OpeFunc<N>::fp_invMontOpC;
		op.fpDbl_mod = OpeFunc<N>::fpDbl_modMontC;
	} else {
		op.fp_mul = OpeFunc<N>::fp_mulC;
		op.fp_sqr = OpeFunc<N>::fp_sqrC;
		op.fp_invOp = OpeFunc<N>::fp_invOpC;
		op.fpDbl_mod = Dbl_Mod<N, Gtag>::f;
	}
	op.fp_mul_Unit = OpeFunc<N>::fp_mul_UnitC;
	op.fpDbl_mulPre = MulPre<N, Gtag>::f;
	op.fpDbl_sqrPre = SqrPre<N, Gtag>::f;
	op.fp_mul_UnitPre = Mul_UnitPre<N, Gtag>::f;
	op.fpN1_mod = N1_Mod<N, Gtag>::f;
	op.fpDbl_add = DblAdd<N, Gtag>::f;
	op.fpDbl_sub = DblSub<N, Gtag>::f;
	if (!op.isFullBit) {
		op.fp_addNC = AddNC<N, Gtag>::f;
		op.fp_subNC = SubNC<N, Gtag>::f;
		op.fpDbl_addNC = AddNC<N * 2, Gtag>::f;
		op.fpDbl_subNC = SubNC<N * 2, Gtag>::f;
	}
#ifdef MCL_USE_LLVM
	setOpLLVM<N>(op, mode);
	SetOpLLVM2<N, (N * UnitBitSize <= 256)>::set(op, mode);
#else
	(void)mode;
#endif
}

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
	op.fp_mul(y, r, op.invTbl.data() + k * op.N, op.p);
}

static void initInvTbl(Op& op)
{
	const size_t N = op.N;
	const Unit *p = op.p;
	const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	op.invTbl.resize(invTblN * N);
	Unit *tbl = op.invTbl.data() + (invTblN - 1) * N;
	Unit t[maxOpUnitSize] = {};
	t[0] = 2;
	op.toMont(tbl, t);
	for (size_t i = 0; i < invTblN - 1; i++) {
		op.fp_add(tbl - N, tbl, tbl, p);
		tbl -= N;
	}
}
#endif

static void initForMont(Op& op, const Unit *p, Mode mode)
{
	const size_t N = op.N;
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

void Op::init(const std::string& mstr, size_t maxBitSize, Mode mode)
{
	assert(sizeof(mp_limb_t) == sizeof(Unit));
	clear();
/*
	priority : MCL_USE_XBYAK > MCL_USE_LLVM > none
	Xbyak > llvm_mont > llvm > gmp_mont > gmp
*/
#ifdef MCL_USE_XBYAK
	if (mode == fp::FP_AUTO) mode = fp::FP_XBYAK;
	if (mode == fp::FP_XBYAK && maxBitSize > 521) {
		mode = fp::FP_AUTO;
	}
#else
	if (mode == fp::FP_XBYAK) mode = fp::FP_AUTO;
#endif
#ifdef MCL_USE_LLVM
	if (mode == fp::FP_AUTO) mode = fp::FP_LLVM_MONT;
#else
	if (mode == fp::FP_LLVM || mode == fp::FP_LLVM_MONT) mode = fp::FP_AUTO;
#endif
	isMont = mode == fp::FP_GMP_MONT || mode == fp::FP_LLVM_MONT || mode == fp::FP_XBYAK;
#if 0
	fprintf(stderr, "mode=%s, isMont=%d, maxBitSize=%d"
#ifdef MCL_USE_XBYAK
		" MCL_USE_XBYAK"
#endif
#ifdef MCL_USE_LLVM
		" MCL_USE_LLVM"
#endif
	"\n", ModeToStr(mode), isMont, (int)maxBitSize);
#endif
	if (maxBitSize > MCL_MAX_OP_BIT_SIZE) {
		throw cybozu::Exception("Op:init:too large maxBitSize") << maxBitSize << MCL_MAX_OP_BIT_SIZE;
	}
	bool isMinus = fp::strToMpzArray(&bitSize, p, maxBitSize, mp, mstr, 0);
	if (isMinus) throw cybozu::Exception("Op:init:mstr is minus") << mstr;
	if (mp == 0) throw cybozu::Exception("Op:init:mstr is zero") << mstr;
	isFullBit = (bitSize % UnitBitSize) == 0;

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
	N = (bitSize + UnitBitSize - 1) / UnitBitSize;
	switch (N) {
	case 1:  setOp<1>(*this, mode);  break;
	case 2:  setOp<2>(*this, mode);  break;
	case 3:  setOp<3>(*this, mode);  break;
	case 4:  setOp<4>(*this, mode);  break; // 256 if 64-bit
	case 5:  setOp<5>(*this, mode);  break;
	case 6:  setOp<6>(*this, mode);  break;
	case 7:  setOp<7>(*this, mode);  break;
	case 8:  setOp<8>(*this, mode);  break;
	case 9:  setOp<9>(*this, mode);  break; // 576 if 64-bit
#if CYBOZU_OS_BIT == 32 || MCL_MAX_OP_BIT_SIZE == 768
	case 10:  setOp<10>(*this, mode);  break;
	case 11:  setOp<11>(*this, mode);  break;
	case 12:  setOp<12>(*this, mode);  break; // 768 if 64-bit
#endif
#if CYBOZU_OS_BIT == 32
	case 13:  setOp<13>(*this, mode);  break;
	case 14:  setOp<14>(*this, mode);  break;
	case 15:  setOp<15>(*this, mode);  break;
	case 16:  setOp<16>(*this, mode);  break;
	case 17:  setOp<17>(*this, mode);  break; // 544 if 32-bit
#endif
	default:
		throw cybozu::Exception("Op::init:not:support") << N << mstr;
	}
#ifdef MCL_USE_LLVM
	if (primeMode == PM_NICT_P192) {
		fp_mul = &mcl_fp_mul_NIST_P192L;
		fp_sqr = &mcl_fp_sqr_NIST_P192L;
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P192L;
	}
	if (primeMode == PM_NICT_P521) {
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P521L;
	}
#endif
	fp::initForMont(*this, p, mode);
	sq.set(mp);
}

void arrayToStr(std::string& str, const Unit *x, size_t n, int base, bool withPrefix)
{
	switch (base) {
	case 0:
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
		op.fp_neg(b.v_, b.p, op.p);
		b.p = b.v_;
		isNegative = true;
	}
	uint64_t v;
	if (fp::isInUint64(&v, b)) {
		const uint64_t c = uint64_t(1) << 63;
		if (isNegative) {
			if (v <= c) { // include c
				if (pb) *pb = true;
				// -1 << 63
				if (v == c) return int64_t(-9223372036854775807ll - 1);
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

