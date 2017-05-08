#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <cybozu/crypto.hpp>
#include <cybozu/endian.hpp>
#include "conversion.hpp"
#include "fp_generator.hpp"
#include "low_func.hpp"
#ifdef MCL_USE_LLVM
#include "proto.hpp"
#include "low_func_llvm.hpp"
#endif

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

inline void setUnitAsLE(void *p, Unit x)
{
#if CYBOZU_OS_BIT == 32
	cybozu::Set32bitAsLE(p, x);
#else
	cybozu::Set64bitAsLE(p, x);
#endif
}
inline Unit getUnitAsLE(const void *p)
{
#if CYBOZU_OS_BIT == 32
	return cybozu::Get32bitAsLE(p);
#else
	return cybozu::Get64bitAsLE(p);
#endif
}

const char *verifyStr(bool *isMinus, int *base, const std::string& str)
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
			if (*base == 0 || *base == 16 || *base == (16 | IoPrefix)) {
				*base = 16;
				p += 2;
			} else {
				throw cybozu::Exception("fp:verifyStr:0x conflicts with") << *base;
			}
		} else if (p[1] == 'b') {
			if (*base == 0 || *base == 2 || *base == (2 | IoPrefix)) {
				*base = 2;
				p += 2;
			} else {
				throw cybozu::Exception("fp:verifyStr:0b conflicts with") << *base;
			}
		}
	}
	if (*base == 0) *base = 10;
	if (*p == '\0') throw cybozu::Exception("fp:verifyStr:str is empty");
	return p;
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

void dumpUnit(Unit x)
{
#if CYBOZU_OS_BIT == 32
	printf("%08x", (uint32_t)x);
#else
	printf("%016llx", (unsigned long long)x);
#endif
}
void UnitToHex(char *buf, size_t maxBufSize, Unit x)
{
#if CYBOZU_OS_BIT == 32
	CYBOZU_SNPRINTF(buf, maxBufSize, "%08x", (uint32_t)x);
#else
	CYBOZU_SNPRINTF(buf, maxBufSize, "%016llx ", (unsigned long long)x);
#endif
}

bool isEnableJIT()
{
#if defined(MCL_USE_XBYAK)
	/* -1:not init, 0:disable, 1:enable */
	static int status = -1;
	if (status == -1) {
		const size_t size = 4096;
		uint8_t *p = (uint8_t*)malloc(size * 2);
		uint8_t *aligned = Xbyak::CodeArray::getAlignedAddress(p, size);
		bool ret = Xbyak::CodeArray::protect(aligned, size, true);
		status = ret ? 1 : 0;
		if (ret) {
			Xbyak::CodeArray::protect(aligned, size, false);
		}
		free(p);
	}
	return status != 0;
#else
	return false;
#endif
}

std::string hash(size_t bitSize, const char *msg, size_t msgSize)
{
	cybozu::crypto::Hash::Name name;
	if (bitSize <= 160) {
		name = cybozu::crypto::Hash::N_SHA1;
	} else if (bitSize <= 224) {
		name = cybozu::crypto::Hash::N_SHA224;
	} else if (bitSize <= 256) {
		name = cybozu::crypto::Hash::N_SHA256;
	} else if (bitSize <= 384) {
		name = cybozu::crypto::Hash::N_SHA384;
	} else {
		name = cybozu::crypto::Hash::N_SHA512;
	}
	return cybozu::crypto::Hash::digest(name, msg, msgSize);
}

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

static inline void fp_invOpC(Unit *y, const Unit *x, const Op& op)
{
	const int N = (int)op.N;
	mpz_class my;
	mpz_t mx, mp;
	set_mpz_t(mx, x, N);
	set_mpz_t(mp, op.p, N);
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

template<size_t N, class Tag, bool enableFpDbl>
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
	op.fpDbl_mulPre = MulPre<N, Tag>::f;
	op.fpDbl_sqrPre = SqrPre<N, Tag>::f;
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
	setOp2<N, Gtag, true>(op);
#ifdef MCL_USE_LLVM
	if (mode != fp::FP_GMP && mode != fp::FP_GMP_MONT) {
#if CYBOZU_HOST == CYBOZU_HOST_INTEL
		Xbyak::util::Cpu cpu;
		if (cpu.has(Xbyak::util::Cpu::tBMI2)) {
			setOp2<N, LBMI2tag, (N * UnitBitSize <= 256)>(op);
		} else
#endif
		{
			setOp2<N, Ltag, (N * UnitBitSize <= 256)>(op);
		}
	}
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
	if (op.fg == 0) op.fg = Op::createFpGenerator();
	op.fg->init(op);

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
	if (maxBitSize > MCL_MAX_BIT_SIZE) {
		throw cybozu::Exception("Op:init:too large maxBitSize") << maxBitSize << MCL_MAX_BIT_SIZE;
	}
	{ // set mp and p
		bool isMinus = false;
		int base = 0;
		const char *pstr = verifyStr(&isMinus, &base, mstr);
		if (isMinus) throw cybozu::Exception("Op:init:mstr is minus") << mstr;
		if (!gmp::setStr(mp, pstr, base)) {
			throw cybozu::Exception("Op:init:bad str") << mstr;
		}
		if (mp == 0) throw cybozu::Exception("Op:init:mstr is zero") << mstr;
	}
	gmp::getArray(p, maxOpUnitSize, mp);
	bitSize = gmp::getBitSize(mp);
/*
	priority : MCL_USE_XBYAK > MCL_USE_LLVM > none
	Xbyak > llvm_mont > llvm > gmp_mont > gmp
*/
#ifdef MCL_USE_XBYAK
	if (mode == fp::FP_AUTO) mode = fp::FP_XBYAK;
	if (mode == fp::FP_XBYAK && bitSize > 256) {
		mode = fp::FP_AUTO;
	}
	if (!fp::isEnableJIT()) {
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
#ifndef NDEBUG
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
	case 1:  setOp<1>(*this, mode); break;
	case 2:  setOp<2>(*this, mode); break;
	case 3:  setOp<3>(*this, mode); break;
	case 4:  setOp<4>(*this, mode); break; // 256 if 64-bit
#if MCL_MAX_UNIT_SIZE >= 6
	case 5:  setOp<5>(*this, mode); break;
	case 6:  setOp<6>(*this, mode); break;
#endif
#if MCL_MAX_UNIT_SIZE >= 9
	case 7:  setOp<7>(*this, mode); break;
	case 8:  setOp<8>(*this, mode); break;
	case 9:  setOp<9>(*this, mode); break; // 521 if 64-bit
#endif
#if MCL_MAX_UNIT_SIZE >= 12
	case 10: setOp<10>(*this, mode); break;
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
		throw cybozu::Exception("Op::init:not:support") << N << mstr;
	}
#ifdef MCL_USE_LLVM
	if (primeMode == PM_NICT_P192) {
		fp_mul = &mcl_fp_mulNIST_P192L;
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

void arrayToStr(std::string& str, const Unit *x, size_t n, int ioMode)
{
	int base = ioMode & ~IoPrefix;
	bool withPrefix = (ioMode & IoPrefix) != 0;
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

int detectIoMode(int ioMode, const std::ios_base& ios)
{
	if (ioMode & ~IoPrefix) return ioMode;
	// IoAuto or IoPrefix
	const std::ios_base::fmtflags f = ios.flags();
	if (f & std::ios_base::oct) throw cybozu::Exception("mcl:fp:detectIoMode:oct is not supported");
	ioMode |= (f & std::ios_base::hex) ? IoHex : 0;
	if (f & std::ios_base::showbase) {
		ioMode |= IoPrefix;
	}
	return ioMode;
}

void streamToArray(bool *pIsMinus, Unit *x, size_t byteSize, std::istream& is, int ioMode)
{
	std::string str;
	if (ioMode & (IoArray | IoArrayRaw | IoEcComp)) {
		str.resize(byteSize);
		is.read(&str[0], byteSize);
		*pIsMinus = false;
		fp::copyByteToUnitAsLE(x, reinterpret_cast<const uint8_t*>(str.c_str()), byteSize);
	} else {
		is >> str;
		// use low 8-bit ioMode for Fp
		ioMode &= 0xff;
		const char *p = verifyStr(pIsMinus, &ioMode, str);
		mpz_class mx;
		if (!gmp::setStr(mx, p, ioMode)) {
			throw cybozu::Exception("fp:streamToArray:bad format") << ioMode << str;
		}
		const size_t n = (byteSize + sizeof(Unit) - 1) / sizeof(Unit);
		gmp::getArray(x, n, mx);
	}
	if (!is) {
		throw cybozu::Exception("streamToArray:can't read") << byteSize;
	}
}

void copyAndMask(Unit *y, const void *x, size_t xByteSize, const Op& op, bool doMask)
{
	const size_t fpByteSize = sizeof(Unit) * op.N;
	if (xByteSize > fpByteSize) {
		if (!doMask) throw cybozu::Exception("fp:copyAndMask:bad size") << xByteSize << fpByteSize;
		xByteSize = fpByteSize;
	}
	// QQQ : fixed later for big endian
	copyByteToUnitAsLE(y, (const uint8_t*)x, xByteSize);
	for (size_t i = (xByteSize + sizeof(Unit) - 1) / sizeof(Unit); i < op.N; i++) {
		y[i] = 0;
	}
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
		arrayToStr(str, b.p, b.n, 10);
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
		arrayToStr(str, b.p, b.n, 10);
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

