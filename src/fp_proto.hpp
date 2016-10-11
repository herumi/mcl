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

struct Gtag; // GMP
struct Ltag; // LLVM
struct Atag; // asm

// (carry, z[N]) <- x[N] + y[N]
template<size_t N, class Tag = Gtag>
struct AddNC {
	static inline Unit func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_add_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const u3u f;
};
template<size_t N, class Tag>
const u3u AddNC<N, Tag>::f = &AddNC<N, Tag>::func;

// (carry, z[N]) <- x[N] - y[N]
template<size_t N, class Tag = Gtag>
struct SubNC {
	static inline Unit func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_sub_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const u3u f;
};

template<size_t N, class Tag>
const u3u SubNC<N, Tag>::f = &SubNC<N, Tag>::func;

// z[N * 2] <- x[N] * y[N]
template<size_t N, class Tag = Gtag>
struct MulPre {
	static inline void func(Unit *z, const Unit *x, const Unit *y)
	{
		return mpn_mul_n((mp_limb_t*)z, (const mp_limb_t*)x, (const mp_limb_t*)y, N);
	}
	static const void3u f;
};

template<size_t N, class Tag>
const void3u MulPre<N, Tag>::f = &MulPre<N, Tag>::func;

// z[N * 2] <- x[N] * x[N]
template<size_t N, class Tag = Gtag>
struct SqrPre {
	static inline void func(Unit *y, const Unit *x)
	{
		return mpn_sqr((mp_limb_t*)y, (const mp_limb_t*)x, N);
	}
	static const void2u f;
};

template<size_t N, class Tag>
const void2u SqrPre<N, Tag>::f = &SqrPre<N, Tag>::func;

// z[N + 1] <- x[N] * y
template<size_t N, class Tag = Gtag>
struct Mul_UnitPre {
	static inline void func(Unit *z, const Unit *x, Unit y)
	{
		z[N] = mpn_mul_1((mp_limb_t*)z, (const mp_limb_t*)x, N, y);
	}
	static const void2uI f;
};

template<size_t N, class Tag>
const void2uI Mul_UnitPre<N, Tag>::f = &Mul_UnitPre<N, Tag>::func;

// z[N] <- x[N + 1] % p[N]
template<size_t N, class Tag = Gtag>
struct N1_Mod {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		mp_limb_t q[2]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N + 1, (const mp_limb_t*)p, N);
	}
	static const void3u f;
};

template<size_t N, class Tag>
const void3u N1_Mod<N, Tag>::f = &N1_Mod<N, Tag>::func;

// z[N] <- x[N * 2] % p[N]
template<size_t N, class Tag = Gtag>
struct Dbl_Mod {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		mp_limb_t q[N + 1]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N * 2, (const mp_limb_t*)p, N);
	}
	static const void3u f;
};

template<size_t N, class Tag>
const void3u Dbl_Mod<N, Tag>::f = &Dbl_Mod<N, Tag>::func;

// z[N] <- MontRed(xy[N], p[N])
template<size_t N, class Tag = Gtag>
struct MontRed {
	static const void3u f;
};

// z[N] <- (x[N] + y[N]) % p[N]
template<size_t N, class Tag = Gtag>
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
template<size_t N, class Tag = Gtag>
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
template<size_t N, class Tag = Gtag>
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
template<size_t N, class Tag = Gtag>
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

// z[N] <- Montgomery(x[N], y[N], p[N])
template<size_t N, class Tag = Gtag>
struct Mont {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
#if 0
		Unit xy[N * 2];
		MulPre<N, Tag>::f(xy, x, y);
		fpDbl_modMontC(z, xy, p);
#else
		const Unit rp = p[-1];
		Unit buf[N * 2 + 2];
		Unit *c = buf;
		Mul_UnitPre<N, Tag>::f(c, x, y[0]); // x * y[0]
		Unit q = c[0] * rp;
		Unit t[N + 2];
		Mul_UnitPre<N, Tag>::f(t, p, q); // p * q
		t[N + 1] = 0; // always zero
		c[N + 1] = AddNC<N + 1, Tag>::f(c, c, t);
		c++;
		for (size_t i = 1; i < N; i++) {
			Mul_UnitPre<N, Tag>::f(t, x, y[i]);
			c[N + 1] = AddNC<N + 1, Tag>::f(c, c, t);
			q = c[0] * rp;
			Mul_UnitPre<N, Tag>::f(t, p, q);
			AddNC<N + 2, Tag>::f(c, c, t);
			c++;
		}
		if (c[N]) {
			SubNC<N, Tag>::f(z, c, p);
		} else {
			if (SubNC<N, Tag>::f(z, c, p)) {
				memcpy(z, c, N * sizeof(Unit));
			}
		}
#endif
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u Mont<N, Tag>::f = Mont<N, Tag>::func;

// z[N] <- Montgomery(x[N], x[N], p[N])
template<size_t N, class Tag = Gtag>
struct SqrMont {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
#if 0
		Unit xx[N * 2];
		SqrPre<N, Tag>::f(xx, x);
		MontRed<N, Tag>(y, xx, p);
#else
		Mont<N, Tag>::f(y, x, x, p);
#endif
	}
	static const void3u f;
};
template<size_t N, class Tag>
const void3u SqrMont<N, Tag>::f = SqrMont<N, Tag>::func;

// z[N] <- (x[N] * y[N]) % p[N]
template<size_t N, class Tag = Gtag>
struct Mul {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit xy[N * 2];
		MulPre<N, Tag>::f(xy, x, y);
		Dbl_Mod<N, Tag>::f(z, xy, p);
	}
	static const void4u f;
};
template<size_t N, class Tag>
const void4u Mul<N, Tag>::f = Mul<N, Tag>::func;

// y[N] <- (x[N] * x[N]) % p[N]
template<size_t N, class Tag = Gtag>
struct Sqr {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
		Unit xx[N * 2];
		SqrPre<N, Tag>::f(xx, x);
		Dbl_Mod<N, Tag>::f(y, xx, p);
	}
	static const void3u f;
};
template<size_t N, class Tag>
const void3u Sqr<N, Tag>::f = Sqr<N, Tag>::func;


} } // mcl::fp

#ifdef MCL_USE_LLVM

#define MCL_FP_DEF_FUNC_SUB(n, suf) \
void mcl_fp_add ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_sub ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
mcl::fp::Unit mcl_fp_addNC ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
mcl::fp::Unit mcl_fp_subNC ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fp_mul_UnitPre ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, mcl::fp::Unit y); \
void mcl_fpDbl_mulPre ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y); \
void mcl_fpDbl_sqrPre ## n ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x); \
void mcl_fp_mont ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fp_montRed ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* p); \
void mcl_fpDbl_add ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p); \
void mcl_fpDbl_sub ## n ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* p);

#define MCL_FP_DEF_FUNC(n) \
	MCL_FP_DEF_FUNC_SUB(n, L) \
	MCL_FP_DEF_FUNC_SUB(n, A)

#define MCL_FP_DEF_FUNC_SPECIAL(suf) \
void mcl_fpDbl_mod_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */); \
void mcl_fp_mul_NIST_P192 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* x, const mcl::fp::Unit* y, const mcl::fp::Unit* /* dummy */); \
void mcl_fp_sqr_NIST_P192 ## suf(mcl::fp::Unit* y, const mcl::fp::Unit* x, const mcl::fp::Unit* /* dummy */); \
void mcl_fpDbl_mod_NIST_P521 ## suf(mcl::fp::Unit* z, const mcl::fp::Unit* xy, const mcl::fp::Unit* /* dummy */);

extern "C" {

MCL_FP_DEF_FUNC(1)
MCL_FP_DEF_FUNC(2)
MCL_FP_DEF_FUNC(3)
MCL_FP_DEF_FUNC(4)
MCL_FP_DEF_FUNC(5)
MCL_FP_DEF_FUNC(6)
MCL_FP_DEF_FUNC(7)
MCL_FP_DEF_FUNC(8)
MCL_FP_DEF_FUNC(9)
#if CYBOZU_OS_BIT == 32 || MCL_MAX_OP_BIT_SIZE == 768
MCL_FP_DEF_FUNC(10)
MCL_FP_DEF_FUNC(11)
MCL_FP_DEF_FUNC(12)
#endif
#if CYBOZU_OS_BIT == 32
MCL_FP_DEF_FUNC(13)
MCL_FP_DEF_FUNC(14)
MCL_FP_DEF_FUNC(15)
MCL_FP_DEF_FUNC(16)
MCL_FP_DEF_FUNC(17)
#endif

MCL_FP_DEF_FUNC_SPECIAL(L)
MCL_FP_DEF_FUNC_SPECIAL(A)

}

#undef MCL_FP_DEF_FUNC_SUB
#undef MCL_FP_DEF_FUNC

#endif

