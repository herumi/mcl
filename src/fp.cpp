#ifdef MCL_DUMP_JIT
	#define MCL_BINT_ASM 0
#endif
#define MCL_DLL_EXPORT
#include <mcl/bint.hpp>
#include "bint_impl.hpp"
#include <mcl/op.hpp>
#include <cybozu/sha2.hpp>
#include <cybozu/endian.hpp>
#include <mcl/conversion.hpp>
#include "conversion_impl.hpp"
#include <mcl/invmod.hpp>

#ifdef MCL_STATIC_CODE
#include "fp_static_code.hpp"
#endif
#ifdef MCL_USE_XBYAK
#include "fp_generator.hpp"
#endif

#include "low_func.hpp"
#include <cybozu/itoa.hpp>
#include <mcl/randgen.hpp>
#include "llvm_proto.hpp"

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
#endif

// define Fp, Fr, G1
#include <mcl/g1_def.hpp>
#include "fp_tower_impl.hpp"

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

void expand_message_xmd(uint8_t out[], size_t outSize, const void *msg, size_t msgSize, const void *dst, size_t dstSize)
{
	const size_t mdSize = 32;
	assert((outSize % mdSize) == 0 && 0 < outSize && outSize <= 256);
	const size_t r_in_bytes = 64;
	const size_t n = outSize / mdSize;
	static const uint8_t Z_pad[r_in_bytes] = {};
	uint8_t largeDst[mdSize];
	if (dstSize > 255) {
		cybozu::Sha256 h;
		h.update("H2C-OVERSIZE-DST-", 17);
		h.digest(largeDst, mdSize, dst, dstSize);
		dst = largeDst;
		dstSize = mdSize;
	}
	/*
		Z_apd | msg | BE(outSize, 2) | BE(0, 1) | DST | BE(dstSize, 1)
	*/
	uint8_t lenBuf[2];
	uint8_t iBuf = 0;
	uint8_t dstSizeBuf = uint8_t(dstSize);
	cybozu::Set16bitAsBE(lenBuf, uint16_t(outSize));
	cybozu::Sha256 h;
	h.update(Z_pad, r_in_bytes);
	h.update(msg, msgSize);
	h.update(lenBuf, sizeof(lenBuf));
	h.update(&iBuf, 1);
	h.update(dst, dstSize);
	uint8_t md[mdSize];
	h.digest(md, mdSize, &dstSizeBuf, 1);
	h.clear();
	h.update(md, mdSize);
	iBuf = 1;
	h.update(&iBuf, 1);
	h.update(dst, dstSize);
	h.digest(out, mdSize, &dstSizeBuf, 1);
	uint8_t mdXor[mdSize];
	for (size_t i = 1; i < n; i++) {
		h.clear();
		for (size_t j = 0; j < mdSize; j++) {
			mdXor[j] = md[j] ^ out[mdSize * (i - 1) + j];
		}
		h.update(mdXor, mdSize);
		iBuf = uint8_t(i + 1);
		h.update(&iBuf, 1);
		h.update(dst, dstSize);
		h.digest(out + mdSize * i, mdSize, &dstSizeBuf, 1);
	}
}

/*
	inv(xR) = (1/x)R^-1 -toMont-> 1/x -toMont-> (1/x)R
*/
template<size_t N>
static void fp_invMod(Unit *y, const Unit *x, const Op& op)
{
	mcl::inv::exec<N>(*reinterpret_cast<const mcl::inv::InvModT<N>*>(op.im), y, x);
	if (op.isMont) op.fp_mul(y, y, op.R3, op.p);
}

// set x = y unless y = 0
template<typename T>
void setSafe(T& x, T y)
{
	if (y != 0) x = y;
}

template<size_t N, bool supportDbl>
struct SetOpt2 {
	static inline void set(Op&) { }
};

template<size_t N>
struct SetOpt2<N, true> {
	static inline void set(Op& op)
	{
		op.fpDbl_add = fpDblAddModT<N>;
		op.fpDbl_sub = fpDblSubModT<N>;
	}
};

template<size_t N>
void setOp(Op& op)
{
	// always use bint functions
	op.fp_isZero = bint::isZeroT<N, Unit>;
	op.fp_clear = bint::clearT<N>;
	op.fp_copy = bint::copyT<N>;
#if 1
	mcl::inv::init(*reinterpret_cast<mcl::inv::InvModT<N>*>(op.im), op.mp);
	op.fp_invOp = fp_invMod<N>;
#else
	op.fp_invOp = fp_invOpC;
#endif
	op.fp_mulUnit = mulUnitModT<N>;
	op.fp_shr1 = shr1T<N>;
	op.fp_neg = negT<N>;
	op.fp_mulUnitPre = mulUnitPreT<N>;
	op.mulSmallUnit = bint::SmallModP::mulUnit<N>;
	op.fp_addPre = bint::get_add(N);
	op.fp_subPre = bint::get_sub(N);
	op.fpDbl_addPre = bint::get_add(N * 2);
	op.fpDbl_subPre = bint::get_sub(N * 2);
	op.fpDbl_mulPre = bint::get_mul(N);
	op.fpDbl_sqrPre = bint::get_sqr(N);

	if (op.isFullBit) {
		op.fp_add = addModT<N>;
		op.fp_sub = subModT<N>;
		setSafe(op.fp_add, get_llvm_fp_add(N));
		setSafe(op.fp_sub, get_llvm_fp_sub(N));
	} else {
		op.fp_add = addModNFT<N>;
		op.fp_sub = subModNFT<N>;
		setSafe(op.fp_add, get_llvm_fp_addNF(N));
		setSafe(op.fp_sub, get_llvm_fp_subNF(N));
	}
	if (op.isMont) {
		if (op.isFullBit) {
			op.fp_mul = mulMontT<N>;
			op.fp_sqr = sqrMontT<N>;
			op.fpDbl_mod = modRedT<N>;
			setSafe(op.fp_mul, get_llvm_fp_mont(N));
			setSafe(op.fp_sqr, get_llvm_fp_sqrMont(N));
			setSafe(op.fpDbl_mod, get_llvm_fp_montRed(N));
		} else {
			op.fp_mul = mulMontNFT<N>;
			op.fp_sqr = sqrMontNFT<N>;
			op.fpDbl_mod = modRedNFT<N>;
			setSafe(op.fp_sqr, get_llvm_fp_sqrMontNF(N));
			setSafe(op.fp_mul, get_llvm_fp_montNF(N));
			setSafe(op.fpDbl_mod, get_llvm_fp_montRedNF(N));
		}
	} else {
		op.fp_mul = mulModT<N>;
		op.fp_sqr = sqrModT<N>;
		op.fpDbl_mod = fpDblModT<N>;
	}
	SetOpt2<N, (N * sizeof(Unit) * 8 <= 512)>::set(op);
	setSafe(op.fpDbl_add, get_llvm_fpDbl_add(N));
	setSafe(op.fpDbl_sub, get_llvm_fpDbl_sub(N));
}

#ifdef MCL_X64_ASM
inline void invOpForMontC(Unit *y, const Unit *x, const Op& op)
{
	int k = op.fp_preInv(y, x);
	/*
		S = UnitBitSize
		xr = 2^k
		if isMont:
		R = 2^(N * S)
		get r2^(-k)R^2 = r 2^(N * S * 2 - k)
		else:
		r 2^(-k)
	*/
	op.fp_mul(y, y, op.invTbl.data() + k * op.N, op.p);
}

static void initInvTbl(Op& op)
{
	const size_t N = op.N;
	const Unit *p = op.p;
	const size_t invTblN = N * sizeof(Unit) * 8 * 2;
	op.invTbl.resize(invTblN * N);
	if (op.isMont) {
		Unit t[maxUnitSize] = {};
		t[0] = 2;
		Unit *tbl = op.invTbl.data() + (invTblN - 1) * N;
		op.toMont(tbl, t);
		for (size_t i = 0; i < invTblN - 1; i++) {
			op.fp_add(tbl - N, tbl, tbl, p);
			tbl -= N;
		}
	} else {
		/*
			half = 1/2
			tbl[i] = half^(i)
		*/
		Unit *tbl = op.invTbl.data();
		memset(tbl, 0, sizeof(Unit) * N);
		tbl[0] = 1;
		mpz_class half = (op.mp + 1) >> 1;
		bool b;
		mcl::gmp::getArray(&b, tbl + N, N, half);
		assert(b); (void)b;
		for (size_t i = 2; i < invTblN; i++) {
			op.fp_mul(tbl + N * i, tbl + N * (i-1), tbl + N, p);
		}
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
	op.rp = bint::getMontgomeryCoeff(p[0]);

	(void)mode;
#ifdef MCL_X64_ASM

#ifdef MCL_USE_XBYAK
#ifndef MCL_DUMP_JIT
	if (mode != FP_XBYAK) return true;
#endif
	if (op.fg == 0) op.fg = Op::createFpGenerator();
	op.fg->init(op);
#ifdef MCL_DUMP_JIT
	return true;
#endif
#elif defined(MCL_STATIC_CODE)
	if (mode != FP_XBYAK) return true;
	fp::setStaticCode(op);
#endif // MCL_USE_XBYAK

	const int maxInvN = 4;
	if (op.fp_preInv && N <= maxInvN) {
		op.fp_invOp = &invOpForMontC;
		initInvTbl(op);
	}
#endif // MCL_X64_ASM
	return true;
}

bool Op::init(const mpz_class& _p, size_t maxBitSize, int _xi_a, Mode mode, size_t mclMaxBitSize, int _u)
{
	if (mclMaxBitSize != MCL_FP_BIT) return false;
	if (maxBitSize > MCL_FP_BIT) return false;
	if (_p <= 0) return false;
	clear();
	maxN = (maxBitSize + UnitBitSize - 1) / UnitBitSize;
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
	this->u = _u;
	this->xi_a = _xi_a;
/*
	priority : MCL_USE_XBYAK > MCL_USE_LLVM > none
	Xbyak > llvm_mont > llvm > gmp_mont > gmp
*/
#ifdef MCL_X64_ASM
	if (mode == FP_AUTO) mode = FP_XBYAK;
	if (mode == FP_XBYAK && bitSize > 512) {
		mode = FP_AUTO;
	}
#ifdef MCL_USE_XBYAK
	if (!isEnableJIT()) {
		mode = FP_AUTO;
	}
#elif defined(MCL_STATIC_CODE)
	{
		// static jit code uses avx, mulx, adox, adcx
		using namespace Xbyak::util;
		if ((mcl::bint::g_cpuType & mcl::bint::tAVX_BMI2_ADX) == 0) {
			mode = FP_AUTO;
		}
	}
#endif
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
	isFullBit = (bitSize % UnitBitSize) == 0;
	isLtQuad = bitSize <= N * UnitBitSize - 2;

#if defined(MCL_USE_LLVM) || defined(MCL_USE_XBYAK)
	if (mode == FP_AUTO || mode == FP_LLVM || mode == FP_XBYAK) {
		const struct {
			PrimeMode mode;
			const char *str;
		} tbl[] = {
			{ PM_NIST_P192, "0xfffffffffffffffffffffffffffffffeffffffffffffffff" },
#if MCL_FP_BIT >= 521
			{ PM_NIST_P521, "0x1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff" },
#endif
		};
		// use fastMode for special primes
		for (size_t i = 0; i < CYBOZU_NUM_OF_ARRAY(tbl); i++) {
			bool b;
			mpz_class target;
			gmp::setStr(&b, target, tbl[i].str);
			if (b && mp == target) {
				primeMode = tbl[i].mode;
				isMont = false;
				isFastMod = true;
				break;
			}
		}
	}
#endif
	if (mode == FP_XBYAK || mode != FP_LLVM) {
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
	switch (N) {
	case 128/(MCL_SIZEOF_UNIT * 8):  setOp<128/(MCL_SIZEOF_UNIT * 8)>(*this); break;
	case 192/(MCL_SIZEOF_UNIT * 8):  setOp<192/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#if (MCL_SIZEOF_UNIT * 8) == 32
	case 224/(MCL_SIZEOF_UNIT * 8):  setOp<224/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#endif
	case 256/(MCL_SIZEOF_UNIT * 8):  setOp<256/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#if MCL_FP_BIT >= 320
	case 320/(MCL_SIZEOF_UNIT * 8):  setOp<320/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#endif
#if MCL_FP_BIT >= 384
	case 384/(MCL_SIZEOF_UNIT * 8):  setOp<384/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#endif
#if MCL_FP_BIT >= 448
	case 448/(MCL_SIZEOF_UNIT * 8):  setOp<448/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#endif
#if MCL_FP_BIT >= 512
	case 512/(MCL_SIZEOF_UNIT * 8):  setOp<512/(MCL_SIZEOF_UNIT * 8)>(*this); break;
#endif
#if MCL_FP_BIT >= 576
	case 576/(MCL_SIZEOF_UNIT * 8):  setOp<576/(MCL_SIZEOF_UNIT * 8)>(*this); break;
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
#if MCL_FP_BIT >= 521
	if (primeMode == PM_NIST_P521) {
		fpDbl_mod = &mcl_fpDbl_mod_NIST_P521L;
	}
#endif
#endif
	if (mode != FP_XBYAK && primeMode == PM_SECP256K1) {
		fp_mul = &bint::mul_SECP256K1;
		fp_sqr = &bint::sqr_SECP256K1;
		fpDbl_mod = &bint::mod_SECP256K1;
	}
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
//	smallModp.init(mp);
	smallModP.init(p, N);
	return fp::initForMont(*this, p, mode);
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

static bool isInUint64(uint64_t *pv, const fp::Block& b)
{
	assert(UnitBitSize == 32 || UnitBitSize == 64);
	const size_t start = 64 / UnitBitSize;
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
	if (bint::cmpGeN(b.p, op.half, op.N)) {
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

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
