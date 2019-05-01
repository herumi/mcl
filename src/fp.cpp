#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <cybozu/sha2.hpp>
#include <cybozu/endian.hpp>
#include <mcl/conversion.hpp>
#ifdef MCL_USE_XBYAK
#include "fp_generator.hpp"
#endif
#include "low_func.hpp"
#ifdef MCL_USE_LLVM
#include "proto.hpp"
#include "low_func_llvm.hpp"
#endif
#include <cybozu/itoa.hpp>
#include <mcl/randgen.hpp>

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
#endif

inline void setUnitAsLE(void *p, Unit x)
{
#if MCL_SIZEOF_UNIT == 4
	cybozu::Set32bitAsLE(p, x);
#else
	cybozu::Set64bitAsLE(p, x);
#endif
}
inline Unit getUnitAsLE(const void *p)
{
#if MCL_SIZEOF_UNIT == 4
	return cybozu::Get32bitAsLE(p);
#else
	return cybozu::Get64bitAsLE(p);
#endif
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
		assert(0);
		return 0;
	}
}

Mode StrToMode(const char *s)
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
		if (strcmp(s, tbl[i].s) == 0) return tbl[i].mode;
	}
	return FP_AUTO;
}

bool isEnableJIT()
{
#if defined(MCL_USE_XBYAK)
	/* -1:not init, 0:disable, 1:enable */
	static int status = -1;
	if (status == -1) {
#ifndef _MSC_VER
		status = 1;
		FILE *fp = fopen("/sys/fs/selinux/enforce", "rb");
		if (fp) {
			char c;
			if (fread(&c, 1, 1, fp) == 1 && c == '1') {
				status = 0;
			}
			fclose(fp);
		}
#endif
		if (status != 0) {
			MIE_ALIGN(4096) char buf[4096];
			bool ret = Xbyak::CodeArray::protect(buf, sizeof(buf), true);
			status = ret ? 1 : 0;
			if (ret) {
				Xbyak::CodeArray::protect(buf, sizeof(buf), false);
			}
		}
	}
	return status != 0;
#else
	return false;
#endif
}

uint32_t sha256(void *out, uint32_t maxOutSize, const void *msg, uint32_t msgSize)
{
	return (uint32_t)cybozu::Sha256().digest(out, maxOutSize, msg, msgSize);
}

uint32_t sha512(void *out, uint32_t maxOutSize, const void *msg, uint32_t msgSize)
{
	return (uint32_t)cybozu::Sha512().digest(out, maxOutSize, msg, msgSize);
}

#ifndef MCL_USE_VINT
static inline void set_mpz_t(mpz_t& z, const Unit* p, int n)
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
#endif

/*
	y = (1/x) mod op.p
*/
static inline void fp_invOpC(Unit *y, const Unit *x, const Op& op)
{
	const int N = (int)op.N;
	bool b = false;
#ifdef MCL_USE_VINT
	Vint vx, vy, vp;
	vx.setArray(&b, x, N);
	assert(b); (void)b;
	vp.setArray(&b, op.p, N);
	assert(b); (void)b;
	Vint::invMod(vy, vx, vp);
	vy.getArray(&b, y, N);
	assert(b); (void)b;
#else
	mpz_class my;
	mpz_t mx, mp;
	set_mpz_t(mx, x, N);
	set_mpz_t(mp, op.p, N);
	mpz_invert(my.get_mpz_t(), mx, mp);
	gmp::getArray(&b, y, N, my);
	assert(b);
#endif
}

/*
	inv(xR) = (1/x)R^-1 -toMont-> 1/x -toMont-> (1/x)R
*/
static void fp_invMontOpC(Unit *y, const Unit *x, const Op& op)
{
	fp_invOpC(y, x, op);
	op.fp_mul(y, y, op.R3, op.p);
}

/*
	large (N * 2) specification of AddPre, SubPre
*/
template<size_t N, bool enable>
struct SetFpDbl {
	static inline void exec(Op&) {}
};

template<size_t N>
struct SetFpDbl<N, true> {
	static inline void exec(Op& op)
	{
//		if (!op.isFullBit) {
			op.fpDbl_addPre = AddPre<N * 2, Ltag>::f;
			op.fpDbl_subPre = SubPre<N * 2, Ltag>::f;
//		}
	}
};

template<size_t N, class Tag, bool enableFpDbl, bool gmpIsFasterThanLLVM>
void setOp2(Op& op)
{
	op.fp_shr1 = Shr1<N, Tag>::f;
	op.fp_neg = Neg<N, Tag>::f;
	if (op.isFullBit) {
		op.fp_add = Add<N, true, Tag>::f;
		op.fp_sub = Sub<N, true, Tag>::f;
	} else {
		op.fp_add = Add<N, false, Tag>::f;
		op.fp_sub = Sub<N, false, Tag>::f;
	}
	if (op.isMont) {
		if (op.isFullBit) {
			op.fp_mul = Mont<N, true, Tag>::f;
			op.fp_sqr = SqrMont<N, true, Tag>::f;
		} else {
			op.fp_mul = Mont<N, false, Tag>::f;
			op.fp_sqr = SqrMont<N, false, Tag>::f;
		}
		op.fpDbl_mod = MontRed<N, Tag>::f;
	} else {
		op.fp_mul = Mul<N, Tag>::f;
		op.fp_sqr = Sqr<N, Tag>::f;
		op.fpDbl_mod = Dbl_Mod<N, Tag>::f;
	}
	op.fp_mulUnit = MulUnit<N, Tag>::f;
	if (!gmpIsFasterThanLLVM) {
		op.fpDbl_mulPre = MulPre<N, Tag>::f;
		op.fpDbl_sqrPre = SqrPre<N, Tag>::f;
	}
	op.fp_mulUnitPre = MulUnitPre<N, Tag>::f;
	op.fpN1_mod = N1_Mod<N, Tag>::f;
	op.fpDbl_add = DblAdd<N, Tag>::f;
	op.fpDbl_sub = DblSub<N, Tag>::f;
	op.fp_addPre = AddPre<N, Tag>::f;
	op.fp_subPre = SubPre<N, Tag>::f;
	op.fp2_mulNF = Fp2MulNF<N, Tag>::f;
	SetFpDbl<N, enableFpDbl>::exec(op);
}

template<size_t N>
void setOp(Op& op, Mode mode)
{
	// generic setup
	op.fp_isZero = isZeroC<N>;
	op.fp_clear = clearC<N>;
	op.fp_copy = copyC<N>;
	if (op.isMont) {
		op.fp_invOp = fp_invMontOpC;
	} else {
		op.fp_invOp = fp_invOpC;
	}
	setOp2<N, Gtag, true, false>(op);
#ifdef MCL_USE_LLVM
	if (mode != fp::FP_GMP && mode != fp::FP_GMP_MONT) {
#if MCL_LLVM_BMI2 == 1
		const bool gmpIsFasterThanLLVM = false;//(N == 8 && MCL_SIZEOF_UNIT == 8);
		Xbyak::util::Cpu cpu;
		if (cpu.has(Xbyak::util::Cpu::tBMI2)) {
			setOp2<N, LBMI2tag, (N * UnitBitSize <= 256), gmpIsFasterThanLLVM>(op);
		} else
#endif
		{
			setOp2<N, Ltag, (N * UnitBitSize <= 256), false>(op);
		}
	}
#else
	(void)mode;
#endif
}

#ifdef MCL_USE_XBYAK
inline void invOpForMontC(Unit *y, const Unit *x, const Op& op)
{
	Unit r[maxUnitSize];
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
	Unit t[maxUnitSize] = {};
	t[0] = 2;
	op.toMont(tbl, t);
	for (size_t i = 0; i < invTblN - 1; i++) {
		op.fp_add(tbl - N, tbl, tbl, p);
		tbl -= N;
	}
}
#endif

static bool initForMont(Op& op, const Unit *p, Mode mode)
{
	const size_t N = op.N;
	bool b;
	{
		mpz_class t = 1, R;
		gmp::getArray(&b, op.one, N, t);
		if (!b) return false;
		R = (t << (N * UnitBitSize)) % op.mp;
		t = (R * R) % op.mp;
		gmp::getArray(&b, op.R2, N, t);
		if (!b) return false;
		t = (t * R) % op.mp;
		gmp::getArray(&b, op.R3, N, t);
		if (!b) return false;
	}
	op.rp = getMontgomeryCoeff(p[0]);
	if (mode != FP_XBYAK) return true;
#ifdef MCL_USE_XBYAK
	if (op.fg == 0) op.fg = Op::createFpGenerator();
	bool useXbyak = op.fg->init(op);

	if (useXbyak && op.isMont && N <= 4) {
		op.fp_invOp = &invOpForMontC;
		initInvTbl(op);
	}
#endif
	return true;
}

bool Op::init(const mpz_class& _p, size_t maxBitSize, int _xi_a, Mode mode, size_t mclMaxBitSize)
{
	if (mclMaxBitSize != MCL_MAX_BIT_SIZE) return false;
#ifdef MCL_USE_VINT
	assert(sizeof(mcl::vint::Unit) == sizeof(Unit));
#else
	assert(sizeof(mp_limb_t) == sizeof(Unit));
#endif
	if (maxBitSize > MCL_MAX_BIT_SIZE) return false;
	if (_p <= 0) return false;
	clear();
	maxN = (maxBitSize + fp::UnitBitSize - 1) / fp::UnitBitSize;
	N = gmp::getUnitSize(_p);
	if (N > maxN) return false;
	{
		bool b;
		gmp::getArray(&b, p, N, _p);
		if (!b) return false;
	}
	mp = _p;
	bitSize = gmp::getBitSize(mp);
	pmod4 = gmp::getUnit(mp, 0) % 4;
	this->xi_a = _xi_a;
/*
	priority : MCL_USE_XBYAK > MCL_USE_LLVM > none
	Xbyak > llvm_mont > llvm > gmp_mont > gmp
*/
#ifdef MCL_USE_XBYAK
	if (mode == FP_AUTO) mode = FP_XBYAK;
	if (mode == FP_XBYAK && bitSize > 384) {
		mode = FP_AUTO;
	}
	if (!isEnableJIT()) {
		mode = FP_AUTO;
	}
#else
	if (mode == FP_XBYAK) mode = FP_AUTO;
#endif
#ifdef MCL_USE_LLVM
	if (mode == FP_AUTO) mode = FP_LLVM_MONT;
#else
	if (mode == FP_LLVM || mode == FP_LLVM_MONT) mode = FP_AUTO;
#endif
	if (mode == FP_AUTO) mode = FP_GMP_MONT;
	isMont = mode == FP_GMP_MONT || mode == FP_LLVM_MONT || mode == FP_XBYAK;
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
	isFullBit = (bitSize % UnitBitSize) == 0;

#if defined(MCL_USE_LLVM) || defined(MCL_USE_XBYAK)
	if (mode == FP_AUTO || mode == FP_LLVM || mode == FP_XBYAK) {
		const char *pStr = "0xfffffffffffffffffffffffffffffffeffffffffffffffff";
		bool b;
		mpz_class p192;
		gmp::setStr(&b, p192, pStr);
		if (b && mp == p192) {
			primeMode = PM_NIST_P192;
			isMont = false;
			isFastMod = true;
		}
	}
	if (mode == FP_AUTO || mode == FP_LLVM || mode == FP_XBYAK) {
		const char *pStr = "0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
		bool b;
		mpz_class p521;
		gmp::setStr(&b, p521, pStr);
		if (b && mp == p521) {
			primeMode = PM_NIST_P521;
			isMont = false;
			isFastMod = true;
		}
	}
#endif
#if defined(MCL_USE_VINT) && MCL_SIZEOF_UNIT == 8
	if (mode != FP_LLVM && mode != FP_XBYAK) {
		const char *secp256k1Str = "0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f";
		bool b;
		mpz_class secp256k1;
		gmp::setStr(&b, secp256k1, secp256k1Str);
		if (b && mp == secp256k1) {
			primeMode = PM_SECP256K1;
			isMont = false;
			isFastMod = true;
		}
	}
#endif
	switch (N) {
	case 1:  setOp<1>(*this, mode); break;
	case 2:  setOp<2>(*this, mode); break;
	case 3:  setOp<3>(*this, mode); break;
	case 4:  setOp<4>(*this, mode); break; // 256 if 64-bit
#if MCL_MAX_UNIT_SIZE >= 6
	case 5:  setOp<5>(*this, mode); break;
	case 6:  setOp<6>(*this, mode); break;
#endif
#if MCL_MAX_UNIT_SIZE >= 8
	case 7:  setOp<7>(*this, mode); break;
	case 8:  setOp<8>(*this, mode); break;
#endif
#if MCL_MAX_UNIT_SIZE >= 9
	case 9:  setOp<9>(*this, mode); break; // 521 if 64-bit
#endif
#if MCL_MAX_UNIT_SIZE >= 10
	case 10: setOp<10>(*this, mode); break;
#endif
#if MCL_MAX_UNIT_SIZE >= 12
	case 11: setOp<11>(*this, mode); break;
	case 12: setOp<12>(*this, mode); break; // 768 if 64-bit
#endif
#if MCL_MAX_UNIT_SIZE >= 14
	case 13: setOp<13>(*this, mode); break;
	case 14: setOp<14>(*this, mode); break;
#endif
#if MCL_MAX_UNIT_SIZE >= 16
	case 15: setOp<15>(*this, mode); break;
	case 16: setOp<16>(*this, mode); break; // 1024 if 64-bit
#endif
#if MCL_MAX_UNIT_SIZE >= 17
	case 17: setOp<17>(*this, mode); break; // 521 if 32-bit
#endif
	default:
		return false;
	}
#ifdef MCL_USE_LLVM
	if (primeMode == PM_NIST_P192) {
		fp_mul = &mcl_fp_mulNIST_P192L;
		fp_sqr = &mcl_fp_sqr_NIST_P192L;
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P192L;
	}
	if (primeMode == PM_NIST_P521) {
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P521L;
	}
#endif
#if defined(MCL_USE_VINT) && MCL_SIZEOF_UNIT == 8
	if (primeMode == PM_SECP256K1) {
		fp_mul = &mcl::vint::mcl_fp_mul_SECP256K1;
		fp_sqr = &mcl::vint::mcl_fp_sqr_SECP256K1;
		fpDbl_mod = &mcl::vint::mcl_fpDbl_mod_SECP256K1;
	}
#endif
	if (N * UnitBitSize <= 256) {
		hash = sha256;
	} else {
		hash = sha512;
	}
	{
		bool b;
		sq.set(&b, mp);
		if (!b) return false;
	}
	modp.init(mp);
	return fp::initForMont(*this, p, mode);
}

void copyUnitToByteAsLE(uint8_t *dst, const Unit *src, size_t byteSize)
{
	while (byteSize >= sizeof(Unit)) {
		setUnitAsLE(dst, *src++);
		dst += sizeof(Unit);
		byteSize -= sizeof(Unit);
	}
	if (byteSize == 0) return;
	Unit x = *src;
	while (byteSize) {
		*dst++ = static_cast<uint8_t>(x);
		x >>= 8;
		byteSize--;
	}
}

void copyByteToUnitAsLE(Unit *dst, const uint8_t *src, size_t byteSize)
{
	while (byteSize >= sizeof(Unit)) {
		*dst++ = getUnitAsLE(src);
		src += sizeof(Unit);
		byteSize -= sizeof(Unit);
	}
	if (byteSize == 0) return;
	Unit x = 0;
	for (size_t i = 0; i < byteSize; i++) {
		x |= Unit(src[i]) << (i * 8);
	}
	*dst = x;
}

#ifndef CYBOZU_DONT_USE_STRING
int detectIoMode(int ioMode, const std::ios_base& ios)
{
	if (ioMode & ~IoPrefix) return ioMode;
	// IoAuto or IoPrefix
	const std::ios_base::fmtflags f = ios.flags();
	assert(!(f & std::ios_base::oct));
	ioMode |= (f & std::ios_base::hex) ? IoHex : 0;
	if (f & std::ios_base::showbase) {
		ioMode |= IoPrefix;
	}
	return ioMode;
}
#endif

bool copyAndMask(Unit *y, const void *x, size_t xByteSize, const Op& op, MaskMode maskMode)
{
	const size_t fpByteSize = sizeof(Unit) * op.N;
	if (maskMode == Mod) {
		if (xByteSize > fpByteSize * 2) return false;
		mpz_class mx;
		bool b;
		gmp::setArray(&b, mx, (const char*)x, xByteSize);
		if (!b) return false;
#ifdef MCL_USE_VINT
		op.modp.modp(mx, mx);
#else
		mx %= op.mp;
#endif
		const Unit *pmx = gmp::getUnit(mx);
		size_t i = 0;
		for (const size_t n = gmp::getUnitSize(mx); i < n; i++) {
			y[i] = pmx[i];
		}
		for (; i < op.N; i++) {
			y[i] = 0;
		}
		return true;
	}
	if (xByteSize > fpByteSize) {
		if (maskMode == NoMask) return false;
		xByteSize = fpByteSize;
	}
	// QQQ : fixed later for big endian
	copyByteToUnitAsLE(y, (const uint8_t*)x, xByteSize);
	for (size_t i = (xByteSize + sizeof(Unit) - 1) / sizeof(Unit); i < op.N; i++) {
		y[i] = 0;
	}
	if (maskMode == mcl::fp::SmallMask || maskMode == mcl::fp::MaskAndMod) {
		maskArray(y, op.N, op.bitSize);
	}
	if (isGreaterOrEqualArray(y, op.p, op.N)) {
		switch (maskMode) {
		case mcl::fp::NoMask: return false;
		case mcl::fp::SmallMask:
			maskArray(y, op.N, op.bitSize - 1);
			break;
		case mcl::fp::MaskAndMod:
		default:
			op.fp_subPre(y, y, op.p);
			break;
		}
	}
	assert(isLessArray(y, op.p, op.N));
	return true;
}

static bool isInUint64(uint64_t *pv, const fp::Block& b)
{
	assert(fp::UnitBitSize == 32 || fp::UnitBitSize == 64);
	const size_t start = 64 / fp::UnitBitSize;
	for (size_t i = start; i < b.n; i++) {
		if (b.p[i]) return false;
	}
#if MCL_SIZEOF_UNIT == 4
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
		*pb = true;
		return v;
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
	if (fp::isGreaterOrEqualArray(b.p, op.half, op.N)) {
		op.fp_neg(b.v_, b.p, op.p);
		b.p = b.v_;
		isNegative = true;
	}
	uint64_t v;
	if (fp::isInUint64(&v, b)) {
		const uint64_t c = uint64_t(1) << 63;
		if (isNegative) {
			if (v <= c) { // include c
				*pb = true;
				// -1 << 63
				if (v == c) return int64_t(-9223372036854775807ll - 1);
				return int64_t(-v);
			}
		} else {
			if (v < c) { // not include c
				*pb = true;
				return int64_t(v);
			}
		}
	}
	*pb = false;
	return 0;
}

#ifdef _MSC_VER
	#pragma warning(pop)
#endif

} } // mcl::fp

