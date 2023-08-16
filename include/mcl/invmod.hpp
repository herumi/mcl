#pragma once
/**
	@file
	@brief non constant time invMod by safegcd
	@author MITSUNARI Shigeo(@herumi)
	cf. The original code is https://github.com/bitcoin-core/secp256k1/blob/master/doc/safegcd_implementation.md
	It is offered under the MIT license.
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/

#include <mcl/gmp_util.hpp>
#include <mcl/bint.hpp>
#include <cybozu/bit_operation.hpp>

namespace mcl {

template<int N>
struct SintT {
	bool sign;
	Unit v[N];
};

template<int N>
void _add(SintT<N>& z, const SintT<N>& x, const Unit *y, bool ySign)
{
	if (x.sign == ySign) {
		Unit ret = mcl::bint::addT<N>(z.v, x.v, y);
		(void)ret;
		assert(ret == 0);
		z.sign = x.sign;
		return;
	}
	int r = mcl::bint::cmpT<N>(x.v, y);
	if (r >= 0) {
		mcl::bint::subT<N>(z.v, x.v, y);
		z.sign = x.sign;
		return;
	}
	mcl::bint::subT<N>(z.v, y, x.v);
	z.sign = ySign;
}

template<int N>
void set(SintT<N>& y, const Unit *x, bool sign)
{
	mcl::bint::copyT<N>(y.v, x);
	y.sign = sign;
}

template<int N>
void clear(SintT<N>& x)
{
	x.sign = false;
	mcl::bint::clearT<N>(x.v);
}

template<int N>
bool isZero(const SintT<N>& x)
{
	Unit r = x.v[0];
	for (int i = 1; i < N; i++) r |= x.v[i];
	return r == 0;
}

template<int N>
void add(SintT<N>& z, const SintT<N>& x, const SintT<N>& y)
{
	_add(z, x, y.v, y.sign);
}

template<int N>
void sub(SintT<N>& z, const SintT<N>& x, const SintT<N>& y)
{
	_add(z, x, y.v, !y.sign);
}

template<int N, typename INT>
void mulUnit(SintT<N+1>&z, const SintT<N>& x, INT y)
{
	Unit abs_y = y < 0 ? -y : y;
	z.v[N] = mcl::bint::mulUnitT<N>(z.v, x.v, abs_y);
	z.sign = x.sign ^ (y < 0);
}

template<int N>
struct InvModT {
	typedef SintT<N> Sint;
#if MCL_SIZEOF_UNIT == 4
	typedef int32_t INT;
	static const int modL = 30;
#else
	typedef int64_t INT;
	static const int modL = 62;
#endif
	static const INT modN = INT(1) << modL;
	static const INT half = modN / 2;
	static const INT MASK = modN - 1;
	Sint M;
	INT Mi;
	struct Quad {
		INT u, v, q, r;
	};
	void init(const mpz_class& mM)
	{
		toSint(M, mM);
		mpz_class inv;
		mpz_class mod = mpz_class(1) << modL;
		mcl::gmp::invMod(inv, mM, mod);
		Mi = mcl::gmp::getUnit(inv)[0] & MASK;
	}

	INT divsteps_n_matrix(Quad& t, INT eta, INT f, INT g) const
	{
		static const int tbl[] = { 15, 5, 3, 9, 7, 13, 11, 1 };
		INT u = 1, v = 0, q = 0, r = 1;
		int i = modL;
		for (;;) {
			INT zeros = g == 0 ? i : cybozu::bsf(g);
			if (i < zeros) zeros = i;
			eta -= zeros;
			i -= zeros;
			g >>= zeros;
			u <<= zeros;
			v <<= zeros;
			if (i == 0) break;
			if (eta < 0) {
				INT u0 = u;
				INT v0 = v;
				INT f0 = f;
				eta = -eta;
				f = g;
				u = q;
				v = r;
				g = -f0;
				q = -u0;
				r = -v0;
			}
			int limit = mcl::fp::min_<INT>(mcl::fp::min_<INT>(eta + 1, i), 4);
			INT w = (g * tbl[(f & 15)>>1]) & ((1<<limit)-1);
			g += w * f;
			q += w * u;
			r += w * v;
		}
		t.u = u;
		t.v = v;
		t.q = q;
		t.r = r;
		return eta;
	}

	void update_fg(Sint& f, Sint& g, const Quad& t) const
	{
		SintT<N+1> f1, f2, g1, g2;
		mulUnit(f1, f, t.u);
		mulUnit(f2, f, t.q);
		mulUnit(g1, g, t.v);
		mulUnit(g2, g, t.r);
		add(f1, f1, g1);
		add(g1, f2, g2);
		mcl::bint::shrT<N+1>(f1.v, f1.v, modL);
		mcl::bint::shrT<N+1>(g1.v, g1.v, modL);
		assert(f1.v[N] == 0);
		assert(g1.v[N] == 0);
		set(f, f1.v, f1.sign);
		set(g, g1.v, g1.sign);
	}

	void update_de(Sint& d, Sint& e, const Quad& t) const
	{
		INT md = 0;
		INT me = 0;
		if (d.sign) {
			md += t.u;
			me += t.q;
		}
		if (e.sign) {
			md += t.v;
			me += t.r;
		}
		SintT<N+1> d1, d2, e1, e2;
		// d = d * u + e * v
		// e = d * q + e * r
		mulUnit(d1, d, t.u);
		mulUnit(d2, d, t.q);
		mulUnit(e1, e, t.v);
		mulUnit(e2, e, t.r);
		add(d1, d1, e1);
		add(e1, d2, e2);
		INT di = getLow(d1) + getLow(M) * md;
		INT ei = getLow(e1) + getLow(M) * me;
		md -= Mi * di;
		me -= Mi * ei;
		md &= MASK;
		me &= MASK;
		if (md >= half) md -= modN;
		if (me >= half) me -= modN;
		// d = (d + M * md) >> modL
		// e = (e + M * me) >> modL
		mulUnit(d2, M, md);
		mulUnit(e2, M, me);
		add(d1, d1, d2);
		add(e1, e1, e2);
		mcl::bint::shrT<N+1>(d1.v, d1.v, modL);
		mcl::bint::shrT<N+1>(e1.v, e1.v, modL);
		assert(d1.v[N] == 0);
		assert(e1.v[N] == 0);
		set(d, d1.v, d1.sign);
		set(e, e1.v, e1.sign);
	}
	void normalize(Sint& v, bool minus) const
	{
		if (v.sign) {
			add(v, v, M);
		}
		if (minus) {
			sub(v, M, v);
		}
		if (v.sign) {
			add(v, v, M);
		}
	}
	template<class SINT>
	INT getLow(const SINT& x) const
	{
		INT r = x.v[0];
		if (x.sign) r = -r;
		return r;
	}
	template<class SINT>
	INT getLowMask(const SINT& x) const
	{
		INT r = getLow(x);
		return r & MASK;
	}

	void inv(Unit *py, const Unit *px) const
	{
		INT eta = -1;
		Sint f = M, g, d, e;
		set(g, px, false);

		clear(d);
		clear(e); e.v[0] = 1;
		Quad t;
		while (!isZero(g)) {
			INT fLow = getLowMask(f);
			INT gLow = getLowMask(g);
			eta = divsteps_n_matrix(t, eta, fLow, gLow);
			update_fg(f, g, t);
			update_de(d, e, t);
		}
		normalize(d, f.sign);
		mcl::bint::copyT<N>(py, d.v);
	}
	void inv(mpz_class& y, const mpz_class& x) const
	{
		Unit ux[N], uy[N];
		mcl::gmp::getArray(ux, N, x);
		inv(uy, ux);
		mcl::gmp::setArray(y, uy, N);
	}
	template<int N2>
	void toSint(SintT<N2>& y, const mpz_class& x) const
	{
		const size_t n = mcl::gmp::getUnitSize(x);
		const Unit *p = mcl::gmp::getUnit(x);
		for (size_t i = 0; i < n; i++) {
			y.v[i] = p[i];
		}
		for (size_t i = n; i < N2; i++) y.v[i] = 0;
		y.sign = x < 0;
	}
	template<int N2>
	void toMpz(mpz_class& y, const SintT<N2>& x) const
	{
		mcl::gmp::setArray(y, x.v, N2);
		if (x.sign) y = -y;
	}
};

} // mcl
