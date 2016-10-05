#pragma once
/**
	@file
	@brief prototype of asm function
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>

namespace mcl { namespace fp {

struct Ltag;
struct Atag;

// (carry, z[N]) <- x[N] + y[N]
template<size_t N, class Tag>struct AddNC { static const u3u f; };
// (carry, z[N]) <- x[N] - y[N]
template<size_t N, class Tag>struct SubNC { static const u3u f; };
// z[N * 2] <- x[N] * y[N]
template<size_t N, class Tag>struct MulPre { static const void3u f; };
// z[N * 2] <- x[N] * x[N]
template<size_t N, class Tag>struct SqrPre { static const void2u f; };
// z[N + 1] <- x[N] * y
template<size_t N, class Tag>struct Mul_UnitPre { static const void2uI f; };
// z[N] <- x[N + 1] % p[N]
template<size_t N, class Tag>struct N1_Mod { static const void3u f; };
// z[N] <- x[N * 2] % p[N]
template<size_t N, class Tag>struct Dbl_Mod { static const void3u f; };
// z[N] <- Montgomery(x[N], y[N], p[N])
template<size_t N, class Tag>struct Mont { static const void4u f; };
// z[N] <- MontRed(xy[N], p[N])
template<size_t N, class Tag>struct MontRed { static const void3u f; };

// z[N] <- (x[N] * y[N]) % p[N]
template<size_t N, class Tag>struct Mul { static const void4u f; };
// z[N] <- (x[N] ^ 2) % p[N]
template<size_t N, class Tag>struct Sqr { static const void3u f; };

// z[N] <- Montgomery(x[N], x[N], p[N])
template<size_t N, class Tag>
struct SqrMont {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		Mont<N, Tag>::f(y, x, x, p);
	}
	static const void3u f;
};
template<size_t N, class Tag>
const void3u SqrMont<N, Tag>::f = SqrMont<N, Tag>::func;

// z[N] <- (x[N] + y[N]) % p[N]
template<size_t N, class Tag>
struct Add {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (AddNC<N, Tag>::f(z, x, y)) {
			SubNC<N, Tag>::f(z, z, p);
			return;
		}
		Unit tmp[N];
		if (SubNC<N, Tag>::f(tmp, z, p) == 0) {
			memcpy(z, tmp, sizeof(tmp));
		}
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u Add<N, Tag>::f = Add<N, Tag>::func;

// z[N] <- (x[N] - y[N]) % p[N]
template<size_t N, class Tag>
struct Sub {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (SubNC<N, Tag>::f(z, x, y)) {
			AddNC<N, Tag>::f(z, z, p);
		}
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u Sub<N, Tag>::f = Sub<N, Tag>::func;

//	z[N * 2] <- (x[N * 2] + y[N * 2]) mod p[N] << (N * UnitBitSize)
template<size_t N, class Tag>
struct DblAdd {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (AddNC<N * 2, Tag>::f(z, x, y)) {
			SubNC<N, Tag>::f(z + N, z + N, p);
			return;
		}
		Unit tmp[N];
		if (SubNC<N, Tag>::f(tmp, z + N, p) == 0) {
			memcpy(z + N, tmp, sizeof(tmp));
		}
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u DblAdd<N, Tag>::f = DblAdd<N, Tag>::func;

//	z[N * 2] <- (x[N * 2] - y[N * 2]) mod p[N] << (N * UnitBitSize)
template<size_t N, class Tag>
struct DblSub {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (SubNC<N * 2, Tag>::f(z, x, y)) {
			AddNC<N, Tag>::f(z + N, z + N, p);
		}
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u DblSub<N, Tag>::f = DblSub<N, Tag>::func;

} } // mcl::fp

#ifdef MCL_USE_LLVM

#define MCL_FP_DEF_FUNC_SUB(len, suf) \
void mcl_fp_add ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_sub ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
mcl::fp::Unit mcl_fp_addNC ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
mcl::fp::Unit mcl_fp_subNC ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_mul_UnitPre ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, mcl::fp::Unit y); \
void mcl_fpDbl_mulPre ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fpDbl_sqrPre ## len ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x); \
void mcl_fp_mont ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_montRed ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* p); \
void mcl_fpDbl_add ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fpDbl_sub ## len ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p);

#define MCL_FP_DEF_FUNC(len) \
	MCL_FP_DEF_FUNC_SUB(len, L) \
	MCL_FP_DEF_FUNC_SUB(len, A)

#define MCL_FP_DEF_FUNC_SPECIAL(suf) \
void mcl_fpDbl_mod_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */); \
void mcl_fp_mul_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* /* dummy */); \
void mcl_fp_sqr_NIST_P192 ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x, const mcl::fp::Unit* /* dummy */); \
void mcl_fpDbl_mod_NIST_P521 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */);

extern "C" {

MCL_FP_DEF_FUNC(64)
MCL_FP_DEF_FUNC(128)
MCL_FP_DEF_FUNC(192)
MCL_FP_DEF_FUNC(256)
MCL_FP_DEF_FUNC(320)
MCL_FP_DEF_FUNC(384)
MCL_FP_DEF_FUNC(448)
MCL_FP_DEF_FUNC(512)
#if CYBOZU_OS_BIT == 32
MCL_FP_DEF_FUNC(160)
MCL_FP_DEF_FUNC(224)
MCL_FP_DEF_FUNC(288)
MCL_FP_DEF_FUNC(352)
MCL_FP_DEF_FUNC(416)
MCL_FP_DEF_FUNC(480)
MCL_FP_DEF_FUNC(544)
#else
MCL_FP_DEF_FUNC(576)
MCL_FP_DEF_FUNC(640)
MCL_FP_DEF_FUNC(704)
MCL_FP_DEF_FUNC(768)
MCL_FP_DEF_FUNC(1024)
MCL_FP_DEF_FUNC(1152)
MCL_FP_DEF_FUNC(1280)
MCL_FP_DEF_FUNC(1408)
MCL_FP_DEF_FUNC(1536)
#endif

MCL_FP_DEF_FUNC_SPECIAL(L)
MCL_FP_DEF_FUNC_SPECIAL(A)

}

#undef MCL_FP_DEF_FUNC_SUB
#undef MCL_FP_DEF_FUNC

#endif

