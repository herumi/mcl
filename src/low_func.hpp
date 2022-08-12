#pragma once
/**
	@file
	@brief generic function for each N
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <mcl/op.hpp>
#include <mcl/util.hpp>
#include <cybozu/bit_operation.hpp>

#ifdef _MSC_VER
	#pragma warning(push)
	#pragma warning(disable : 4127)
#endif

namespace mcl { namespace fp {

struct Gtag; // GMP
struct Ltag; // LLVM
struct Atag; // asm

template<class Tag> struct TagToStr { };
template<> struct TagToStr<Gtag> { static const char *f() { return "Gtag"; } };
template<> struct TagToStr<Ltag> { static const char *f() { return "Ltag"; } };
template<> struct TagToStr<Atag> { static const char *f() { return "Atag"; } };

template<size_t N>
static void shr1T(Unit *y, const Unit *x)
{
	bint::shrT<N>(y, x, 1);
}

// y[N] <- (-x[N]) % p[N]
template<size_t N>
static void negT(Unit *y, const Unit *x, const Unit *p)
{
	if (bint::isZeroT<N>(x)) {
		if (x != y) bint::clearT<N>(y);
		return;
	}
	bint::subT<N>(y, p, x);
}

// z[N + 1] <- x[N] * y
template<size_t N>
static void mulUnitPreT(Unit *z, const Unit *x, Unit y)
{
	z[N] = bint::mulUnitT<N>(z, x, y);
}

// z[N] <- x[N + 1] % p[N]
template<size_t N, class Tag = Gtag>
struct N1_Mod {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
#ifdef MCL_USE_VINT
		Unit t[N + 1];
		bint::copyN(t, x, N + 1);
		size_t n = bint::div(0, 0, t, N + 1, p, N);
		bint::copyN(y, t, n);
		bint::clearN(y + n, N - n);
#else
		mp_limb_t q[2]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N + 1, (const mp_limb_t*)p, N);
#endif
	}
	static const void3u f;
};

template<size_t N, class Tag>
const void3u N1_Mod<N, Tag>::f = N1_Mod<N, Tag>::func;

// z[N] <- (x[N] * y) % p[N]
template<size_t N, class Tag = Gtag>
struct MulUnit {
	static inline void func(Unit *z, const Unit *x, Unit y, const Unit *p)
	{
		Unit xy[N + 1];
		mulUnitPreT<N>(xy, x, y);
#if 1
		Unit len = UnitBitSize - 1 - cybozu::bsr(p[N - 1]);
		Unit v = xy[N];
		if (N > 1 && len < 3 && v < 0xff) {
			for (;;) {
				if (len == 0) {
					v = xy[N];
				} else {
					v = (xy[N] << len) | (xy[N - 1] >> (UnitBitSize - len));
				}
				if (v == 0) break;
				if (v == 1) {
					xy[N] -= bint::subT<N>(xy, xy, p);
				} else {
					Unit t[N + 1];
					mulUnitPreT<N>(t, p, v);
					bint::subT<N + 1>(xy, xy, t);
				}
			}
			for (;;) {
				if (bint::subT<N>(z, xy, p)) {
					bint::copyT<N>(z, xy);
					return;
				}
				if (bint::subT<N>(xy, z, p)) {
					return;
				}
			}
		}
#endif
		N1_Mod<N, Tag>::f(z, xy, p);
	}
	static const void2uIu f;
};

template<size_t N, class Tag>
const void2uIu MulUnit<N, Tag>::f = MulUnit<N, Tag>::func;

// z[N] <- x[N * 2] % p[N]
template<size_t N, class Tag = Gtag>
struct Dbl_Mod {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
#ifdef MCL_USE_VINT
		Unit t[N * 2];
		bint::copyN(t, x, N * 2);
		size_t n = bint::div(0, 0, t, N * 2, p, N);
		bint::copyN(y, t, n);
		bint::clearN(y + n, N - n);
#else
		mp_limb_t q[N + 1]; // not used
		mpn_tdiv_qr(q, (mp_limb_t*)y, 0, (const mp_limb_t*)x, N * 2, (const mp_limb_t*)p, N);
#endif
	}
	static const void3u f;
};

template<size_t N, class Tag>
const void3u Dbl_Mod<N, Tag>::f = Dbl_Mod<N, Tag>::func;

template<size_t N, class Tag>
struct SubIfPossible {
	static inline void f(Unit *z, const Unit *p)
	{
		Unit tmp[N - 1];
		if (bint::subT<N - 1>(tmp, z, p) == 0) {
			bint::copyT<N - 1>(z, tmp);
			z[N - 1] = 0;
		}
	}
};
template<class Tag>
struct SubIfPossible<1, Tag> {
	static inline void f(Unit *, const Unit *)
	{
	}
};


// z[N] <- (x[N] + y[N]) % p[N]
template<size_t N, bool isFullBit, class Tag = Gtag>
struct Add {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (isFullBit) {
			if (bint::addT<N>(z, x, y)) {
				bint::subT<N>(z, z, p);
				return;
			}
			Unit tmp[N];
			if (bint::subT<N>(tmp, z, p) == 0) {
				bint::copyT<N>(z, tmp);
			}
		} else {
			bint::addT<N>(z, x, y);
			Unit a = z[N - 1];
			Unit b = p[N - 1];
			if (a < b) return;
			if (a > b) {
				bint::subT<N>(z, z, p);
				return;
			}
			/* the top of z and p are same */
			SubIfPossible<N, Tag>::f(z, p);
		}
	}
	static const void4u f;
};

template<size_t N, bool isFullBit, class Tag>
const void4u Add<N, isFullBit, Tag>::f = Add<N, isFullBit, Tag>::func;

// z[N] <- (x[N] - y[N]) % p[N]
template<size_t N, bool isFullBit, class Tag = Gtag>
struct Sub {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (bint::subT<N>(z, x, y)) {
			bint::addT<N>(z, z, p);
		}
	}
	static const void4u f;
};

template<size_t N, bool isFullBit, class Tag>
const void4u Sub<N, isFullBit, Tag>::f = Sub<N, isFullBit, Tag>::func;

//	z[N * 2] <- (x[N * 2] + y[N * 2]) mod p[N] << (N * UnitBitSize)
template<size_t N, class Tag = Gtag>
struct DblAdd {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		if (bint::addT<N * 2>(z, x, y)) {
			bint::subT<N>(z + N, z + N, p);
			return;
		}
		Unit tmp[N];
		if (bint::subT<N>(tmp, z + N, p) == 0) {
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
		if (bint::subT<N * 2>(z, x, y)) {
			bint::addT<N>(z + N, z + N, p);
		}
	}
	static const void4u f;
};

template<size_t N, class Tag>
const void4u DblSub<N, Tag>::f = DblSub<N, Tag>::func;

/*
	z[N] <- montRed(xy[N * 2], p[N])
	REMARK : assume p[-1] = rp
*/
template<size_t N, bool isFullBit, class Tag = Gtag>
struct MontRed {
	static inline void func(Unit *z, const Unit *xy, const Unit *p)
	{
		const Unit rp = p[-1];
		Unit pq[N + 1];
		Unit buf[N * 2 + 1];
		bint::copyT<N - 1>(buf + N + 1, xy + N + 1);
		buf[N * 2] = 0;
		Unit q = xy[0] * rp;
		mulUnitPreT<N>(pq, p, q);
		Unit up = bint::addT<N + 1>(buf, xy, pq);
		if (up) {
			buf[N * 2] = bint::addUnit(buf + N + 1, N - 1, 1);
		}
		Unit *c = buf + 1;
		for (size_t i = 1; i < N; i++) {
			q = c[0] * rp;
			mulUnitPreT<N>(pq, p, q);
			up = bint::addT<N + 1>(c, c, pq);
			if (up) {
				bint::addUnit(c + N + 1, N - i, 1);
			}
			c++;
		}
		if (c[N]) {
			bint::subT<N>(z, c, p);
		} else {
			if (bint::subT<N>(z, c, p)) {
				memcpy(z, c, N * sizeof(Unit));
			}
		}
	}
	static const void3u f;
};

template<size_t N, bool isFullBit, class Tag>
const void3u MontRed<N, isFullBit, Tag>::f = MontRed<N, isFullBit, Tag>::func;

/*
	z[N] <- Montgomery(x[N], y[N], p[N])
	REMARK : assume p[-1] = rp
*/
template<size_t N, bool isFullBit, class Tag = Gtag>
struct Mont {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
#if MCL_MAX_BIT_SIZE == 1024 || MCL_SIZEOF_UNIT == 4 // check speed
		Unit xy[N * 2];
		bint::mulT<N>(xy, x, y);
		MontRed<N, isFullBit, Tag>::f(z, xy, p);
#else
		const Unit rp = p[-1];
		if (isFullBit) {
			Unit buf[N * 2 + 2];
			Unit *c = buf;
			mulUnitPreT<N>(c, x, y[0]); // x * y[0]
			Unit q = c[0] * rp;
			Unit t[N + 2];
			mulUnitPreT<N>(t, p, q); // p * q
			t[N + 1] = 0; // always zero
			c[N + 1] = bint::addT<N + 1>(c, c, t);
			c++;
			for (size_t i = 1; i < N; i++) {
				mulUnitPreT<N>(t, x, y[i]);
				c[N + 1] = bint::addT<N + 1>(c, c, t);
				q = c[0] * rp;
				mulUnitPreT<N>(t, p, q);
				bint::addT<N + 2>(c, c, t);
				c++;
			}
			if (c[N]) {
				bint::subT<N>(z, c, p);
			} else {
				if (bint::subT<N>(z, c, p)) {
					memcpy(z, c, N * sizeof(Unit));
				}
			}
		} else {
			/*
				R = 1 << 64
				L % 64 = 63 ; not full bit
				F = 1 << (L + 1)
				max p = (1 << L) - 1
				x, y <= p - 1
				max x * y[0], p * q <= ((1 << L) - 1)(R - 1)
				t = x * y[i] + p * q <= 2((1 << L) - 1)(R - 1) = (F - 2)(R - 1)
				t >> 64 <= (F - 2)(R - 1)/R = (F - 2) - (F - 2)/R
				t + (t >> 64) = (F - 2)R - (F - 2)/R < FR
			*/
			Unit carry;
			(void)carry;
			Unit buf[N * 2 + 1];
			Unit *c = buf;
			mulUnitPreT<N>(c, x, y[0]); // x * y[0]
			Unit q = c[0] * rp;
			Unit t[N + 1];
			mulUnitPreT<N>(t, p, q); // p * q
			carry = bint::addT<N + 1>(c, c, t);
			assert(carry == 0);
			c++;
			c[N] = 0;
			for (size_t i = 1; i < N; i++) {
				c[N + 1] = 0;
				mulUnitPreT<N>(t, x, y[i]);
				carry = bint::addT<N + 1>(c, c, t);
				assert(carry == 0);
				q = c[0] * rp;
				mulUnitPreT<N>(t, p, q);
				carry = bint::addT<N + 1>(c, c, t);
				assert(carry == 0);
				c++;
			}
			assert(c[N] == 0);
			if (bint::subT<N>(z, c, p)) {
				memcpy(z, c, N * sizeof(Unit));
			}
		}
#endif
	}
	static const void4u f;
};

template<size_t N, bool isFullBit, class Tag>
const void4u Mont<N, isFullBit, Tag>::f = Mont<N, isFullBit, Tag>::func;

// z[N] <- Montgomery(x[N], x[N], p[N])
template<size_t N, bool isFullBit, class Tag = Gtag>
struct SqrMont {
	static inline void func(Unit *y, const Unit *x, const Unit *p)
	{
#if 0 // #if MCL_MAX_BIT_SIZE == 1024 || MCL_SIZEOF_UNIT == 4 // check speed
		Unit xx[N * 2];
		bint::sqrT<N>f(xx, x);
		MontRed<N, isFullBit, Tag>::f(y, xx, p);
#else
		Mont<N, isFullBit, Tag>::f(y, x, x, p);
#endif
	}
	static const void3u f;
};
template<size_t N, bool isFullBit, class Tag>
const void3u SqrMont<N, isFullBit, Tag>::f = SqrMont<N, isFullBit, Tag>::func;

// z[N] <- (x[N] * y[N]) % p[N]
template<size_t N, class Tag = Gtag>
struct Mul {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		Unit xy[N * 2];
		bint::mulT<N>(xy, x, y);
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
		bint::sqrT<N>(xx, x);
		Dbl_Mod<N, Tag>::f(y, xx, p);
	}
	static const void3u f;
};
template<size_t N, class Tag>
const void3u Sqr<N, Tag>::f = Sqr<N, Tag>::func;

template<size_t N, class Tag = Gtag>
struct Fp2MulNF {
	static inline void func(Unit *z, const Unit *x, const Unit *y, const Unit *p)
	{
		const Unit *const a = x;
		const Unit *const b = x + N;
		const Unit *const c = y;
		const Unit *const d = y + N;
		Unit d0[N * 2];
		Unit d1[N * 2];
		Unit d2[N * 2];
		Unit s[N];
		Unit t[N];
		bint::addT<N>(s, a, b);
		bint::addT<N>(t, c, d);
		bint::mulT<N>(d0, s, t);
		bint::mulT<N>(d1, a, c);
		bint::mulT<N>(d2, b, d);
		bint::subT<N * 2>(d0, d0, d1);
		bint::subT<N * 2>(d0, d0, d2);
		MontRed<N, false, Tag>::f(z + N, d0, p);
		DblSub<N, Tag>::f(d1, d1, d2, p);
		MontRed<N, false, Tag>::f(z, d1, p);
	}
	static const void4u f;
};
template<size_t N, class Tag>
const void4u Fp2MulNF<N, Tag>::f = Fp2MulNF<N, Tag>::func;

} } // mcl::fp

#ifdef _MSC_VER
	#pragma warning(pop)
#endif
