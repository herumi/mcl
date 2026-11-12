#ifdef MCL_DUMP_JIT
	#define MCL_BINT_ASM 0
#endif
#ifdef _MSC_VER
	/*
		Construct the static objects of this file (Fp::op_, Fr::op_, ...) in the library
		initialization area, which runs before the user's static objects regardless of
		the link order (MSVC has no init_priority). See FpT::op_ in fp.hpp.
		src/msm_avx.cpp has the same pragma.
	*/
	#pragma warning(disable : 4073) // initializers put in library initialization area
	#pragma init_seg(lib)
#endif
#define MCL_DLL_EXPORT
#include <mcl/config.hpp>
#include <mcl/bn.h>
#include <mcl/bint.hpp>
#include "bint_impl.hpp"

#if CYBOZU_HOST == CYBOZU_HOST_INTEL

#include <string.h>

#ifdef MCL_USE_XBYAK
#define XBYAK_DISABLE_AVX512
#ifndef XBYAK_NO_EXCEPTION
	#define XBYAK_NO_EXCEPTION
#endif
#else
	#define XBYAK_ONLY_CLASS_CPU
#endif

#include "xbyak/xbyak_util.h"
#endif

namespace mcl { namespace bint {

static uint32_t detectCpuType()
{
	uint32_t type = 0;

#if CYBOZU_HOST == CYBOZU_HOST_INTEL

	using namespace Xbyak::util;
	Cpu cpu;
	if (cpu.has(Cpu::tAVX | Cpu::tBMI2 | Cpu::tADX)) {
		type |= tAVX_BMI2_ADX;
	}
	if (cpu.has(Cpu::tAVX512_IFMA)) {
		type |= tAVX512_IFMA;
	}
	const char *env = 0;
	const char *key = "MCL_CPU";
#ifdef _WIN32
	char envBuf[128];
	size_t size;
	if (getenv_s(&size, envBuf, key) == 0) {
		if (size > 0) {
			env = envBuf;
		}
	}
#else
	env = getenv(key);
#endif
	if (env) {
		if (strcmp(env, "noadx") == 0) {
			type = 0;
		} else if (strcmp(env, "noifma") == 0) {
			type &= ~tAVX512_IFMA;
		} else if (strcmp(env, "adx") == 0) {
			type |= tAVX_BMI2_ADX;
		}
	}
#endif
#if MCL_BINT_ASM_X64 == 1
	// after the MCL_CPU override, so that noadx keeps the slow asm
	if (type & tAVX_BMI2_ADX) mclb_enable_fast();
#endif
	return type;
}

// lazily detected CPU type (bitwise OR of CpuType, see include/mcl/bint.hpp)
uint32_t getCpuType()
{
	static const uint32_t type = detectCpuType();
	return type;
}

} } // mcl::bint
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
#ifndef MCL_DONT_USE_THREAD
#include <cybozu/thread.hpp>
#endif
#include <mcl/randgen.hpp>
#include "llvm_proto.hpp"

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
#endif

// define Fp, Fr, G1, GG (GG only if MCL_USE_GRUMPKIN=1)
#include <mcl/g1_def.hpp>
#if MCL_USE_GRUMPKIN == 1
#include <mcl/gg_def.hpp>
#endif
#include "fp_tower_impl.hpp"

namespace mcl {

#if defined(_MSC_VER) && !defined(MCL_DLL_IMPORT_STATIC)
// the static data members of G1 and G2 are defined only here (see EcT in ec.hpp)
#define MCL_EC_STATIC_INST(Ec, F) \
	template F Ec::a_; \
	template F Ec::b_; \
	template F Ec::b3_; \
	template int Ec::specialA_; \
	template int Ec::specialB_; \
	template int Ec::ioMode_; \
	template bool Ec::verifyOrder_; \
	template mpz_class Ec::order_; \
	template Ec::MulVecGLVFunc Ec::mulVecGLV; \
	template Ec::MulVecOptiFunc Ec::mulVecOpti; \
	template Ec::IsValidOrderFastFunc Ec::isValidOrderFast; \
	template int Ec::mode_; \
	template Ec::MulEachOptiFunc Ec::mulEachOpti; \
	template Ec::MsmKernelPtr Ec::msmKernel;
MCL_EC_STATIC_INST(EcT<Fp>, Fp)
MCL_EC_STATIC_INST(EcT<Fp2>, Fp2)
#if MCL_USE_GRUMPKIN == 1
MCL_EC_STATIC_INST(GG, Fr)
#endif
#undef MCL_EC_STATIC_INST
#endif

namespace fp {

Op* getOpPtr(int tag, size_t maxBitSize)
{
	if (tag == FpTag && maxBitSize == MCL_FP_BIT) return &Fp::getOpNonConst();
	if (tag == FrTag && maxBitSize == MCL_FR_BIT) return &Fr::getOpNonConst();
	return 0; // FpT<tag, maxBitSize> other than Fp and Fr is not supported by the DLL
}

RandGen& RandGen::get()
{
	static RandGen wrg(getDefaultRandGen());
	return wrg;
}

#ifdef MCL_USE_XBYAK
FpGenerator *createFpGenerator()
{
	return new FpGenerator();
}
void destroyFpGenerator(FpGenerator *fg)
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
	// outSize does not need to be a multiple of mdSize (RFC 9380 5.3.1)
	assert(0 < outSize && outSize <= 255 * mdSize);
	const size_t r_in_bytes = 64;
	const size_t n = (outSize + mdSize - 1) / mdSize;
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
	// buf holds the full block b_i because the last block of out may be truncated
	uint8_t buf[mdSize];
	h.digest(buf, mdSize, &dstSizeBuf, 1);
	size_t remain = outSize;
	size_t copySize = remain < mdSize ? remain : mdSize;
	memcpy(out, buf, copySize);
	remain -= copySize;
	uint8_t mdXor[mdSize];
	for (size_t i = 1; i < n; i++) {
		h.clear();
		for (size_t j = 0; j < mdSize; j++) {
			mdXor[j] = md[j] ^ buf[j];
		}
		h.update(mdXor, mdSize);
		iBuf = uint8_t(i + 1);
		h.update(&iBuf, 1);
		h.update(dst, dstSize);
		h.digest(buf, mdSize, &dstSizeBuf, 1);
		copySize = remain < mdSize ? remain : mdSize;
		memcpy(out + mdSize * i, buf, copySize);
		remain -= copySize;
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
	mcl::inv::init<N>(*reinterpret_cast<mcl::inv::InvModT<N>*>(op.im), op.p);
	op.fp_invOp = fp_invMod<N>;
	op.fp_mulUnit = op.modp.N > 0 ? mulUnitModT<N> : mulUnitModDivT<N>; // modp.init() is called before setOp()
	op.fp_shr1 = shr1T<N>;
	op.fp_neg = negT<N>;
	op.fp_mulUnitPre = mulUnitPreT<N>;
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

// the p-generic LLVM functions of base{32,64}.ll are registered to the A_ slots if MCL_DIRECT_CALL (see include/mcl/config.hpp) without Xbyak / the static code
#if defined(MCL_DIRECT_CALL) && !defined(MCL_X64_ASM)
#if MCL_FP_BIT != MCL_FP_BIT_LLVM
	#error "MCL_FP_BIT differs from MCL_FP_BIT_LLVM of src/llvm_proto.hpp (the MCL_FP_BIT of the generation of src/base{32,64}.ll); regenerate them by make update_all_asm MCL_FP_BIT=... and make header"
#endif
/*
	register the p-generic LLVM functions of base{32,64}.ll (p as the last
	argument, rp = p[-1]; common.gen_generic_fp / gen_generic_fp2 of
	src/gen.py, set_llvm_fp / set_llvm_fp2 in llvm_proto.hpp) of N = 256 /
	384 bits to the A_ slots of op (used when Xbyak is not available: non
	x64 or MCL_DONT_USE_XBYAK).
	The Fp2 functions (i^2 = -u, xi = xi_a + i of the pairing curves of
	primetbl.py; p not full bit and p < R/4) have the position of the second
	component fixed to sizeof(Fp) = MCL_FP_BIT_LLVM / 8 (the MCL_FP_BIT of
	the generation of base{32,64}.ll, checked above), so the Fp2 slots are
	set only if op.maxN matches it.
	Not for wasm: call_indirect traps on the signature mismatch of func_ptr_cast
	and the C++ Fp2 is faster there.
*/
static void setLLVMCode(Op& op)
{
	if (!op.isMont) return;
	const size_t N = op.N;
	const bool fp2Layout = op.maxN * UnitBitSize == MCL_FP_BIT_LLVM;
	if (!set_llvm_fp(op, N, op.isFullBit)) return;
	const bool nocarry = (op.p[N - 1] >> (UnitBitSize - 2)) == 0; // p < R/4
	if (fp2Layout && !op.isFullBit && nocarry) {
		set_llvm_fp2(op, N, op.u, op.xi_a); // no change if (N, u, xi_a) is not supported
	}
	// fpDbl_mulPre / fpDbl_sqrPre stay bint::get_mul(N) / get_sqr(N): they do
	// not depend on p (mclb_sqr{N} has the same anti-diagonal schedule as the
	// mcl-ff sqrPre), and the mulx asm is faster on x64 (18.6 vs 26.0 clk for N = 6)
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
	if (op.fg == 0) op.fg = fp::createFpGenerator();
	if (!op.fg->init(op)) return false;
#ifdef MCL_DUMP_JIT
	return true;
#endif
#elif defined(MCL_STATIC_CODE)
	if (mode != FP_XBYAK) return true;
	fp::setStaticCode(op);
#endif // MCL_USE_XBYAK
#elif defined(MCL_DIRECT_CALL)
	setLLVMCode(op);
#endif // MCL_X64_ASM
	return true;
}

bool Op::init(const mpz_class& _p, int _u, int _xi_a, int tag, size_t sizeofF)
{
	// The following check is performed to verify that there is no inconsistency
	// between the values of MCL_FP_BIT and MCL_FR_BIT at library compilation time and usage time.
//	printf("tag=%d sizeofF=%zd sizeof(Fp)=%zd sizeof(Fr)=%zd\n", tag, sizeofF, sizeof(Fp), sizeof(Fr));
	switch (tag) {
	case FpTag: if (sizeofF != sizeof(Fp)) return false; break;
	case FrTag: if (sizeofF != sizeof(Fr)) return false; break;
	default: break;
	}
	if (_p <= 0) return false;
	clear();
	const size_t maxBitSize = sizeofF * 8;
	maxN = roundUp(maxBitSize, UnitBitSize);
	bitSize = gmp::getBitSize(_p);
	N = roundUp(bitSize, UnitBitSize);
	if (N > maxN) return false;
	{
		bool b;
		gmp::getArray(&b, p, N, _p);
		if (!b) return false;
	}
	mp = _p;
	modp.init(mp);
	pmod4 = gmp::getUnit(mp, 0) % 4;
	this->u = _u;
	this->xi_a = _xi_a;
/*
	priority : MCL_USE_XBYAK > MCL_USE_LLVM > none
	Xbyak > llvm_mont > llvm > gmp_mont > gmp
*/
	fp::Mode mode = FP_AUTO; // will be removed later
#ifdef MCL_X64_ASM
	if (mode == FP_AUTO) mode = FP_XBYAK;
	if (mode == FP_XBYAK && bitSize > 512) {
		mode = FP_AUTO;
	}
	// the JIT and the static code use AVX/mulx/adcx/adox: use the LLVM (or C++) functions and the slow bint asm otherwise
	if ((bint::getCpuType() & bint::tAVX_BMI2_ADX) == 0) {
		mode = FP_AUTO;
	}
#ifdef MCL_USE_XBYAK
	if (!isEnableJIT()) {
		mode = FP_AUTO;
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
	if (primeMode == PM_SECP256K1) {
		fp_mul = &mcl_fp_mul_SECP256K1L;
		fp_sqr = &mcl_fp_sqr_SECP256K1L;
		fpDbl_mod = &mcl_fpDbl_mod_SECP256K1L;
	}
#else
	if (mode != FP_XBYAK && primeMode == PM_SECP256K1) {
		fp_mul = &bint::mul_SECP256K1;
		fp_sqr = &bint::sqr_SECP256K1;
		fpDbl_mod = &bint::mod_SECP256K1;
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
	return fp::initForMont(*this, p, mode);
}

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

#ifdef _MSC_VER
	#pragma warning(pop)
#endif

} } // mcl::fp

#include "mapto_wb19.hpp"
#include "map_impl.hpp"
#include "pairing_impl.hpp"
#include "bn_c_impl.hpp"

namespace mcl {

void initG1onlyGLV(int curveType)
{
	typedef GLV1T<G1> GLV1;
	if (!GLV1::useParamTbl(curveType)) return;
	G1::setMulVecGLV(mcl::ec::mulVecGLVT<GLV1, G1>);
#if MCL_MSM == 1
	if (bint::getCpuType() & bint::tAVX512_IFMA) {
		mcl::msm::initMsm(curveType, GLV1::splitRaw); // false if the curve is not in src/msm_avx_para.h
	}
#endif
}

#if MCL_USE_GRUMPKIN == 1

namespace {

GG s_ggBasePoint;

/*
	init F (Fp or Fr) with the modulus mstr if F is not initialized (op.mp == 0) ; return false if F is initialized for another modulus
*/
template<class F>
bool initFieldIfNot(bool *pb, const char *mstr)
{
	mpz_class m;
	gmp::setStr(pb, m, mstr);
	if (!*pb) return false;
	const mpz_class& cur = F::getOp().mp;
	if (cur == 0) {
		F::init(pb, m);
		return *pb;
	}
	*pb = (cur == m);
	return *pb;
}

} // anonymous namespace

void initGrumpkin(bool *pb)
{
	const EcParam& para = ecparam::grumpkin;
	s_ggBasePoint.clear();
	// the base field of GG is Fr (the r of BN_SNARK1) and the scalar field is Fp (the p of BN_SNARK1)
	if (!initFieldIfNot<Fr>(pb, para.p)) return;
	if (!initFieldIfNot<Fp>(pb, para.n)) return;
	GG::init(pb, para.a, para.b, ec::Jacobi);
	if (!*pb) return;
	{
		Fr x, y;
		x.setStr(pb, para.gx);
		if (!*pb) return;
		y.setStr(pb, para.gy);
		if (!*pb) return;
		s_ggBasePoint.set(pb, x, y);
		if (!*pb) return;
	}
	// #E = p is prime (cofactor 1), so every point on the curve is in the group : no setOrder
	typedef GLV1T<GG> GLVGG;
	*pb = GLVGG::useParamTbl(MCL_GRUMPKIN);
	if (!*pb) return;
	GG::setMulVecGLV(mcl::ec::mulVecGLVT<GLVGG, GG>);
#if MCL_MSM == 1
	if (bint::getCpuType() & bint::tAVX512_IFMA) {
		mcl::msm::initMsmGG(MCL_GRUMPKIN, GLVGG::splitRaw); // the second kernel of msm_avx.cpp (GG::setMsmKernel, GG::setMulEachOpti)
	}
#endif
}

const GG& getGGbasePoint()
{
	return s_ggBasePoint;
}

#endif // MCL_USE_GRUMPKIN == 1

// the GLV function of Fp12::pow / Fp12::powVec (see fp_tower.hpp)
static Fp12PowVecGLVFunc s_fp12PowVecGLV = 0;

void setFp12PowVecGLV(Fp12PowVecGLVFunc f)
{
	s_fp12PowVecGLV = f;
}
Fp12PowVecGLVFunc getFp12PowVecGLV()
{
	return s_fp12PowVecGLV;
}

namespace ec {

static ParallelForFunc s_parallelFor = 0;
static size_t s_parallelForMaxThreads = 1;

void setParallelFor(ParallelForFunc f, size_t maxThreads)
{
	if (f == 0 || maxThreads == 0) maxThreads = 1;
	s_parallelFor = f;
	s_parallelForMaxThreads = maxThreads;
}
ParallelForFunc getParallelFor(size_t *pMaxThreads)
{
	if (pMaxThreads) *pMaxThreads = s_parallelFor ? s_parallelForMaxThreads : 1;
	return s_parallelFor;
}

#ifdef MCL_DONT_USE_THREAD

void parallelForThreadN(ParallelForTask task, void *arg, size_t n, size_t)
{
	if (n > 0) task(0, n, 0, arg);
}
void parallelForThread(ParallelForTask task, void *arg, size_t n)
{
	if (n > 0) task(0, n, 0, arg);
}
ParallelFor getParallelForOrThread(size_t)
{
	ParallelFor par;
	par.f = s_parallelFor;
	par.maxThreads = s_parallelFor ? s_parallelForMaxThreads : 1;
	return par;
}

#else

namespace {

/*
	the n tasks are taken one by one from the shared counter *next by the threads (cybozu::AtomicAdd),
	so a slow thread (an efficiency core of a hybrid CPU) takes fewer tasks and the others do not wait for it
*/
struct ParallelForThreadArg {
	ParallelForTask task;
	void *arg;
	size_t *next; // the shared counter of the next task
	size_t n;
	size_t tid;
	cybozu::thread::ThreadHandle hdl;
	bool created; // the thread of hdl is created
};

#ifdef _WIN32
unsigned __stdcall parallelForThreadEntry(void *p)
#else
void* parallelForThreadEntry(void *p)
#endif
{
	const ParallelForThreadArg& a = *(const ParallelForThreadArg*)p;
	for (;;) {
		const size_t i = cybozu::AtomicAdd(a.next, size_t(1));
		if (i >= a.n) break;
		a.task(i, i + 1, a.tid, a.arg);
	}
	return 0;
}

} // anonymous namespace

void parallelForThreadN(ParallelForTask task, void *arg, size_t n, size_t nt)
{
	if (n == 0) return;
	if (nt > n) nt = n;
	mcl::Array<ParallelForThreadArg> args;
	if (nt > 1 && !args.resize(nt)) nt = 1;
	if (nt <= 1) {
		task(0, n, 0, arg);
		return;
	}
	size_t next = 0;
	for (size_t t = 0; t < nt; t++) {
		ParallelForThreadArg& a = args[t];
		a.task = task;
		a.arg = arg;
		a.next = &next;
		a.n = n;
		a.tid = t;
		// the caller also takes the tasks (as the thread nt - 1 or in place of a thread which could not be created)
		a.created = t + 1 < nt && cybozu::thread::Begin(a.hdl, parallelForThreadEntry, &a, 0);
		if (!a.created) parallelForThreadEntry(&a);
	}
	for (size_t t = 0; t + 1 < nt; t++) {
		if (args[t].created) cybozu::thread::Join(args[t].hdl, cybozu::thread::Infinite);
	}
}

void parallelForThread(ParallelForTask task, void *arg, size_t n)
{
	size_t nt = 1;
	getParallelFor(&nt);
	parallelForThreadN(task, arg, n, nt);
}

ParallelFor getParallelForOrThread(size_t cpuN)
{
	ParallelFor par;
	if (s_parallelFor) {
		par.f = s_parallelFor;
		par.maxThreads = s_parallelForMaxThreads;
		return par;
	}
	if (cpuN == 0) {
		int n = cybozu::GetProcessorNum();
		cpuN = n > 0 ? size_t(n) : 1;
	}
	par.f = parallelForThread;
	par.maxThreads = cpuN;
	return par;
}

#endif // MCL_DONT_USE_THREAD

const StaticMember* getStaticMember(int id)
{
	struct Table {
		StaticMember g1;
		StaticMember g2;
#if MCL_USE_GRUMPKIN == 1
		StaticMember gg;
#endif
		Table()
		{
			G1::setStaticMember(g1);
			G2::setStaticMember(g2);
#if MCL_USE_GRUMPKIN == 1
			GG::setStaticMember(gg);
#endif
		}
	};
	static const Table tbl;
	switch (id) {
	case StaticIdG1: return &tbl.g1;
	case StaticIdG2: return &tbl.g2;
#if MCL_USE_GRUMPKIN == 1
	case StaticIdGG: return &tbl.gg;
#endif
	default: return 0;
	}
}

} // mcl::ec

} // mcl
