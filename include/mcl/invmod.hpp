#include <cybozu/bit_operation.hpp>
#include <mcl/gmp_util.hpp>
#include <mcl/util.hpp>
#include <mcl/bint.hpp>

template<int N>
struct SintT {
	typedef mcl::Unit Unit;
	bool sign;
	Unit v[N];
	static inline bool _add(Unit *z, const SintT& x, const Unit *y, bool ySign)
	{
		if (x.sign == ySign) {
			Unit ret = mcl::bint::addT<N>(z, x.v, y);
			(void)ret;
			assert(ret == 0);
			return x.sign;
		}
		int r = mcl::bint::cmpT<N>(x.v, y);
		if (r >= 0) {
			mcl::bint::subT<N>(z, x.v, y);
			return x.sign;
		}
		mcl::bint::subT<N>(z, y, x.v);
		return ySign;
	}
	static inline bool add(Unit *z, const SintT& x, const SintT& y)
	{
		return _add(z, x, y.v, y.sign);
	}
	static inline bool sub(Unit *z, const SintT& x, const SintT& y)
	{
		return _add(z, x, y.v, !y.sign);
	}
	template<typename INT>
	static inline bool mulUnit(Unit (&z)[N+1], const SintT& x, INT y)
	{
		INT abs_y = y < 0 ? -y : y;
		z[N] = mcl::bint::mulUnitT<N>(z, x.v, abs_y);
		return x.sign ^ (y < 0);
	}
	void clear()
	{
		sign = false;
		mcl::bint::clearT<N>(v);
	}
	void dump() const
	{
		mcl::bint::dump(v, N, "Sint");
	}
	void set(const Unit *x, bool sign)
	{
		for (int i = 0; i < N; i++) v[i] = x[i];
		this->sign = sign;
	}
	bool isZero() const
	{
		Unit r = v[0];
		for (int i = 1; i < N; i++) r |= v[i];
		return r == 0;
	}
	template<typename INT>
	INT getLow() const
	{
		INT r = v[0];
		return sign ? -r : r;
	}
};

template<typename Unit, int N, typename INT>
struct InvModT {
	typedef SintT<N> Sint;
	static const int modL = 62;
	static const INT MASK = (INT(1) << modL) - 1;
	Sint M;
	INT invM;
	struct Tmp {
		INT u, v, q, r;
	};

	INT divsteps_n_matrix(Tmp& t, INT eta, INT f, INT g) const
	{
		static const int tbl[] = { 15, 5, 3, 9, 7, 13, 11, 1 };
		INT u = 1, v = 0, q = 0, r = 1;
		int i = modL;
		for (;;) {
			INT zeros = mcl::fp::min_<int>(i, cybozu::bsf(g));
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

	template<int N2>
	void toMpz(mpz_class& y, const SintT<N2>& x) const
	{
		mcl::gmp::setArray(y, x.v, N);
		if (x.sign) y = -y;
	}
	template<int N2>
	void toSint(SintT<N2>& y, const mpz_class& x) const
	{
		if (x > 0) {
			mcl::gmp::getArray(y.v, N, x);
			y.sign = false;
		} else {
			mcl::gmp::getArray(y.v, N, -x);
			y.sign = true;
		}
	}
	template<int N2>
	INT getMod2powN(const SintT<N2>& x) const
	{
		INT r = x.v[0];
		if (x.sign) r = -r;
		return r & MASK;
	}
	void update_fg(Sint& f, Sint& g, const Tmp& t) const
	{
		SintT<N+1> f1, f2, g1, g2;
		f1.sign = SintT<N>::mulUnit(f1.v, f, t.u);
		f2.sign = SintT<N>::mulUnit(f2.v, f, t.q);
		g1.sign = SintT<N>::mulUnit(g1.v, g, t.v);
		g2.sign = SintT<N>::mulUnit(g2.v, g, t.r);
		f1.sign = SintT<N+1>::add(f1.v, f1, g1);
		g1.sign = SintT<N+1>::add(g1.v, f2, g2);
		mcl::bint::shrT<N+1>(f1.v, f1.v, modL);
		mcl::bint::shrT<N+1>(g1.v, g1.v, modL);
		f.set(f1.v, f1.sign);
		g.set(g1.v, g1.sign);
	}

	void update_de(Sint& d, Sint& e, const Tmp& t) const
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
		d1.sign = SintT<N>::mulUnit(d1.v, d, t.u);
		d2.sign = SintT<N>::mulUnit(d2.v, d, t.q);
		e1.sign = SintT<N>::mulUnit(e1.v, e, t.v);
		e2.sign = SintT<N>::mulUnit(e2.v, e, t.r);
		d1.sign = SintT<N+1>::add(d1.v, d1, e1);
		e1.sign = SintT<N+1>::add(e1.v, d2, e2);
		INT di = d1.template getLow<INT>() + M.template getLow<INT>() * md;
		INT ei = e1.template getLow<INT>() + M.template getLow<INT>() * me;
		md -= (invM * di) & MASK;
		me -= (invM * ei) & MASK;
		// d = (d + M * md) >> modL
		// e = (e + M * me) >> modL
		d2.sign = SintT<N>::mulUnit(d2.v, M, md);
		e2.sign = SintT<N>::mulUnit(e2.v, M, me);
		d1.sign = SintT<N+1>::add(d1.v, d1, d2);
		e1.sign = SintT<N+1>::add(e1.v, e1, e2);
		mcl::bint::shrT<N+1>(d1.v, d1.v, modL);
		mcl::bint::shrT<N+1>(e1.v, e1.v, modL);
		d.set(d1.v, d1.sign);
		e.set(e1.v, e1.sign);
	}
	void normalize(Sint& v, bool minus) const
	{
		if (v.sign) {
			v.sign = Sint::add(v.v, v, M);
		}
		if (minus) {
			v.sign = Sint::sub(v.v, M, v);
		}
		if (v.sign) {
			v.sign = Sint::add(v.v, v, M);
		}
	}

	void inv(mpz_class& y, const mpz_class& x) const
	{
		INT eta = -1;
		SintT<N> f = M, g;
		toSint(g, x);
		
		Sint d, e;
		d.clear();
		e.clear();
		e.v[0] = 1;
		Tmp t;
		while (!g.isZero()) {
			INT sfLow = f.template getLow<INT>() & MASK;
			INT sgLow = g.template getLow<INT>() & MASK;
			eta = divsteps_n_matrix(t, eta, sfLow, sgLow);
			update_fg(f, g, t);
			update_de(d, e, t);
		}
		normalize(d, f.sign);
		toMpz(y, d);
	}
	void init(const mpz_class& mM)
	{
		toSint(M, mM);
		mpz_class inv;
		mpz_class mod = mpz_class(1) << modL;
		mcl::gmp::invMod(inv, mM, mod);
		invM = mcl::gmp::getUnit(inv)[0];
		printf("invM=%lld\n", (long long)invM);
	}
};
