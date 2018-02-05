#pragma once
/**
	@file
	@brief definition of Op
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/gmp_util.hpp>
#include <memory.h>

#ifndef MCL_MAX_BIT_SIZE
	#define MCL_MAX_BIT_SIZE 521
#endif
#ifdef __EMSCRIPTEN__
	#define MCL_DONT_USE_XBYAK
	#define MCL_DONT_USE_OPENSSL
#endif
#if !defined(MCL_DONT_USE_XBYAK) && (defined(_WIN64) || defined(__x86_64__)) && (MCL_SIZEOF_UNIT == 8)
	#define MCL_USE_XBYAK
#endif

#define MCL_MAX_HASH_BIT_SIZE 512

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
#include <random>
#endif

namespace mcl {

/*
	specifies available string format mode for X::setIoMode()
	// for Fp, Fp2, Fp6, Fp12
	default(0) : IoDec
	printable string(zero terminated, variable size)
	IoBin(2) | IoDec(10) | IoHex(16) | IoBinPrefix | IoHexPrefix

	byte string(not zero terminated, fixed size)
	IoArray | IoArrayRaw
	IoArray = IoSerialize

	// for Ec
	affine(0) | IoEcCompY | IoComp
	default : affine

	affine and IoEcCompY are available with ioMode for Fp
	IoSerialize ignores ioMode for Fp

	IoAuto
		dec or hex according to ios_base::fmtflags
	IoBin
		binary number([01]+)
	IoDec
		decimal number
	IoHex
		hexadecimal number([0-9a-fA-F]+)
	IoBinPrefix
		0b + <binary number>
	IoHexPrefix
		0x + <hexadecimal number>
	IoArray
		array of Unit(fixed size = Fp::getByteSize())
	IoArrayRaw
		array of Unit(fixed size = Fp::getByteSize()) without Montgomery convresion

	// for Ec::setIoMode()
	IoEcAffine(default)
	"0" ; infinity
	"1 <x> <y>" ; affine coordinate

	IoEcProj
	"4" <x> <y> <z> ; projective or jacobi coordinate

	IoEcCompY
		1-bit y prepresentation of elliptic curve
		"2 <x>" ; compressed for even y
		"3 <x>" ; compressed for odd y

	IoSerialize(fixed size = Fp::getByteSize())
		use MSB of array of x for 1-bit y for prime p where (p % 8 != 0)
		[0] ; infinity
		<x> ; for even y
		<x>|1 ; for odd y ; |1 means set MSB of x
*/
enum IoMode {
	IoAuto = 0, // dec or hex according to ios_base::fmtflags
	IoBin = 2, // binary number without prefix
	IoDec = 10, // decimal number without prefix
	IoHex = 16, // hexadecimal number without prefix
	IoArray = 32, // array of Unit(fixed size)
	IoArrayRaw = 64, // raw array of Unit without Montgomery conversion
	IoPrefix = 128, // append '0b'(bin) or '0x'(hex)
	IoBinPrefix = IoBin | IoPrefix,
	IoHexPrefix = IoHex | IoPrefix,
	IoEcAffine = 0, // affine coordinate
	IoEcCompY = 256, // 1-bit y representation of elliptic curve
	IoSerialize = 512, // use MBS for 1-bit y
	IoFixedSizeByteSeq = IoSerialize, // obsolete
	IoEcProj = 1024 // projective or jacobi coordinate
};

namespace fp {

const size_t UnitBitSize = sizeof(Unit) * 8;

const size_t maxUnitSize = (MCL_MAX_BIT_SIZE + UnitBitSize - 1) / UnitBitSize;
#define MCL_MAX_UNIT_SIZE ((MCL_MAX_BIT_SIZE + MCL_UNIT_BIT_SIZE - 1) / MCL_UNIT_BIT_SIZE)

struct FpGenerator;
struct Op;

typedef void (*void1u)(Unit*);
typedef void (*void2u)(Unit*, const Unit*);
typedef void (*void2uI)(Unit*, const Unit*, Unit);
typedef void (*void2uIu)(Unit*, const Unit*, Unit, const Unit*);
typedef void (*void2uOp)(Unit*, const Unit*, const Op&);
typedef void (*void3u)(Unit*, const Unit*, const Unit*);
typedef void (*void4u)(Unit*, const Unit*, const Unit*, const Unit*);
typedef int (*int2u)(Unit*, const Unit*);

typedef Unit (*u1uII)(Unit*, Unit, Unit);
typedef Unit (*u3u)(Unit*, const Unit*, const Unit*);

struct Block {
	const Unit *p; // pointer to original FpT.v_
	size_t n;
	Unit v_[maxUnitSize];
};

enum Mode {
	FP_AUTO,
	FP_GMP,
	FP_GMP_MONT,
	FP_LLVM,
	FP_LLVM_MONT,
	FP_XBYAK
};

enum PrimeMode {
	PM_GENERIC = 0,
	PM_NICT_P192,
	PM_NICT_P521
};

namespace local {

template<class RG>
void readWrapper(void *self, void *buf, uint32_t bufSize)
{
	reinterpret_cast<RG*>(self)->read((uint8_t*)buf, bufSize);
}

#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
template<>
void readWrapper<std::random_device>(void *self, void *buf, uint32_t bufSize)
{
	std::random_device& rg = *reinterpret_cast<std::random_device*>(self);
	uint8_t *p = reinterpret_cast<uint8_t*>(buf);
	uint32_t v;
	while (bufSize >= 4) {
		v = rg();
		memcpy(p, &v, 4);
		p += 4;
		bufSize -= 4;
	}
	if (bufSize > 0) {
		v = rg();
		memcpy(p, &v, bufSize);
	}
}
#endif
} // local
/*
	wrapper of cryptographically secure pseudo random number generator
*/
class WrapperRG {
	typedef void (*readFuncType)(void *self, void *buf, uint32_t bufSize);
	void *self_;
	readFuncType readFunc_;
public:
	WrapperRG() : self_(0), readFunc_(0) {}
	WrapperRG(void *self, readFuncType readFunc) : self_(self) , readFunc_(readFunc) {}
	template<class RG>
	WrapperRG(RG& rg)
		: self_(reinterpret_cast<void*>(&rg))
		, readFunc_(local::readWrapper<RG>)
	{
	}
	void read(void *out, size_t byteSize)
	{
		readFunc_(self_, out, byteSize);
	}
	bool isZero() const { return self_ == 0 && readFunc_ == 0; }
	void clear() { self_ = 0; readFunc_ = 0; }
	void set(void *self, void (*readFunc)(void *self,void *buf, uint32_t bufSize))
	{
		self_ = self;
		readFunc_ = readFunc;
	}
};

struct Op {
	/*
		don't change the layout of rp and p
		asm code assumes &rp + 1 == p
	*/
	Unit rp;
	Unit p[maxUnitSize];
	mpz_class mp;
	uint32_t pmod4;
	mcl::SquareRoot sq;
	FpGenerator *fg;
	Unit half[maxUnitSize]; // (p + 1) / 2
	Unit oneRep[maxUnitSize]; // 1(=inv R if Montgomery)
	/*
		for Montgomery
		one = 1
		R = (1 << (N * sizeof(Unit) * 8)) % p
		R2 = (R * R) % p
		R3 = RR^3
	*/
	Unit one[maxUnitSize];
	Unit R2[maxUnitSize];
	Unit R3[maxUnitSize];
	std::vector<Unit> invTbl;
	size_t N;
	size_t bitSize;
	bool (*fp_isZero)(const Unit*);
	void1u fp_clear;
	void2u fp_copy;
	void2u fp_shr1;
	void3u fp_neg;
	void4u fp_add;
	void4u fp_sub;
	void4u fp_mul;
	void3u fp_sqr;
	void2uOp fp_invOp;
	void2uIu fp_mulUnit; // fpN1_mod + fp_mulUnitPre

	void3u fpDbl_mulPre;
	void2u fpDbl_sqrPre;
	int2u fp_preInv;
	void2uI fp_mulUnitPre; // z[N + 1] = x[N] * y
	void3u fpN1_mod; // y[N] = x[N + 1] % p[N]

	void4u fpDbl_add;
	void4u fpDbl_sub;
	void3u fpDbl_mod;

	u3u fp_addPre; // without modulo p
	u3u fp_subPre; // without modulo p
	u3u fpDbl_addPre;
	u3u fpDbl_subPre;
	/*
		for Fp2 = F[u] / (u^2 + 1)
		x = a + bu
	*/
	int xi_a; // xi = xi_a + u
	void3u fp2_add;
	void3u fp2_sub;
	void3u fp2_mul;
	void4u fp2_mulNF;
	void2u fp2_neg;
	void2u fp2_inv;
	void2u fp2_sqr;
	void2u fp2_mul_xi;
	uint32_t (*hash)(void *out, uint32_t maxOutSize, const void *msg, uint32_t msgSize);
	WrapperRG wrapperRg;

	PrimeMode primeMode;
	bool isFullBit; // true if bitSize % uniSize == 0
	bool isMont; // true if use Montgomery
	bool isFastMod; // true if modulo is fast

	Op()
	{
		clear();
		fg = 0;
	}
	~Op()
	{
		destroyFpGenerator(fg);
	}
	void clear()
	{
		rp = 0;
		memset(p, 0, sizeof(p));
		mp = 0;
		pmod4 = 0;
		sq.clear();
		// fg is not set
		memset(half, 0, sizeof(half));
		memset(oneRep, 0, sizeof(oneRep));
		memset(one, 0, sizeof(one));
		memset(R2, 0, sizeof(R2));
		memset(R3, 0, sizeof(R3));
		invTbl.clear();
		N = 0;
		bitSize = 0;
		fp_isZero = 0;
		fp_clear = 0;
		fp_copy = 0;
		fp_shr1 = 0;
		fp_neg = 0;
		fp_add = 0;
		fp_sub = 0;
		fp_mul = 0;
		fp_sqr = 0;
		fp_invOp = 0;
		fp_mulUnit = 0;

		fpDbl_mulPre = 0;
		fpDbl_sqrPre = 0;
		fp_preInv = 0;
		fp_mulUnitPre = 0;
		fpN1_mod = 0;

		fpDbl_add = 0;
		fpDbl_sub = 0;
		fpDbl_mod = 0;

		fp_addPre = 0;
		fp_subPre = 0;
		fpDbl_addPre = 0;
		fpDbl_subPre = 0;

		xi_a = 0;
		fp2_add = 0;
		fp2_sub = 0;
		fp2_mul = 0;
		fp2_mulNF = 0;
		fp2_neg = 0;
		fp2_inv = 0;
		fp2_sqr = 0;
		fp2_mul_xi = 0;

		primeMode = PM_GENERIC;
		isFullBit = false;
		isMont = false;
		isFastMod = false;
		hash = 0;
		wrapperRg.clear();
	}
	void fromMont(Unit* y, const Unit *x) const
	{
		/*
			M(x, y) = xyR^-1
			y = M(x, 1) = xR^-1
		*/
		fp_mul(y, x, one, p);
	}
	void toMont(Unit* y, const Unit *x) const
	{
		/*
			y = M(x, R2) = xR^2 R^-1 = xR
		*/
		fp_mul(y, x, R2, p);
	}
	void init(const std::string& mstr, size_t maxBitSize, Mode mode, size_t mclMaxBitSize = MCL_MAX_BIT_SIZE);
	void initFp2(int xi_a);
	static FpGenerator* createFpGenerator();
	static void destroyFpGenerator(FpGenerator *fg);
private:
	Op(const Op&);
	void operator=(const Op&);
};

/*
	conevrt string to array according to ioMode,
*/
void strToArray(bool *pIsMinus, Unit *x, size_t xN, const std::string& str, int ioMode);

void arrayToStr(std::string& str, const Unit *x, size_t n, int ioMode);

inline const char* getIoSeparator(int ioMode)
{
	return (ioMode & (IoArray | IoArrayRaw | IoSerialize)) ? "" : " ";
}

int detectIoMode(int ioMode, const std::ios_base& ios);

inline void dump(const char *s, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		printf("%02x ", (uint8_t)s[i]);
	}
	printf("\n");
}

inline void dump(const std::string& s)
{
	dump(s.c_str(), s.size());
}

} } // mcl::fp
