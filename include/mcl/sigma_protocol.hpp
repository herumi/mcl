#pragma once
/**
	@file
	@brief building blocks of Schnorr-type sigma protocols
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
	@note
	This header provides only the algebraic part of the protocols:
	commit (sum of B_i k_i), response (k +- c w), recompute (sum of B_i z_i -+ c X)
	and the CDS 2-way OR proof for a bit.
	The challenge hash, the random number generator and the serialization are
	intentionally left to the caller so that each caller keeps its own wire format.
	Nothing is allocated on the heap and the outputs are written to the caller's buffers.
	C++03 compatible, no exception, no STL.

	The group G and the scalar F are template parameters (F is mcl::Fr for she and bbs).
	The scalar of a commitment may be an integer type if the base accepts it (e.g. the message of ElGamalEnc in she).
	Requirements for the group G:
	- G::mul(G& z, const G& x, const INT& k)
	- G::mulVecConstRef(G& z, const G *xVec, const Fr *yVec, size_t n) : z = sum of xVec[i] yVec[i]
	- G::sub(G& z, const G& x, const G& y)
	- G& operator+=(const G&)
	A multiplicative group (e.g. GT) is wrapped by Additive<G>.
	A base is an object which has `void mul(G& out, const INT& k) const` (out = base * k),
	e.g. MulG<G> or fp::WindowMethod<G>.
	The terms whose base is MulG<G> and whose scalar is Fr are summed by G::mulVecConstRef at once
	because a multi-scalar multiplication is faster than the sum of scalar multiplications even for n = 2 or 3.
*/
#include <stddef.h>
#include <assert.h>
#include <mcl/fr_def.hpp>
#include <mcl/array.hpp> // secureZero

namespace mcl { namespace sigma {

/*
	out = base * k
*/
template<class G>
struct MulG {
	const G& base;
	explicit MulG(const G& base) : base(base) {}
	template<class INT>
	void mul(G& out, const INT& k) const
	{
		G::mul(out, base, k);
	}
};

/*
	adapter for a base M whose mul() requires I& where I is derived from G
	e.g. fp::WindowMethod<I> of she::HashTable
*/
template<class I, class M>
struct CastMul {
	const M& m;
	explicit CastMul(const M& m) : m(m) {}
	template<class G, class INT>
	void mul(G& out, const INT& k) const
	{
		m.mul(static_cast<I&>(out), k);
	}
};

/*
	wrapper which shows a multiplicative group G as an additive group
	add = G::mul, neg = G::unitaryInv, mul = G::pow
	The layout is the same as G, so an array of G may be reinterpreted as an array of Additive<G>.
*/
template<class G>
struct Additive {
	G v;
	Additive& operator+=(const Additive& rhs)
	{
		G::mul(v, v, rhs.v);
		return *this;
	}
	Additive& operator-=(const Additive& rhs)
	{
		G t;
		G::unitaryInv(t, rhs.v);
		G::mul(v, v, t);
		return *this;
	}
	template<class INT>
	static void mul(Additive& z, const Additive& x, const INT& k)
	{
		G::pow(z.v, x.v, k);
	}
	static void neg(Additive& z, const Additive& x)
	{
		G::unitaryInv(z.v, x.v);
	}
	static void add(Additive& z, const Additive& x, const Additive& y)
	{
		G::mul(z.v, x.v, y.v);
	}
	static void sub(Additive& z, const Additive& x, const Additive& y)
	{
		G t;
		G::unitaryInv(t, y.v);
		G::mul(z.v, x.v, t);
	}
	// z = prod of xVec[i]^yVec[i] (the layout of Additive is the same as G)
	static void mulVecConstRef(Additive& z, const Additive *xVec, const Fr *yVec, size_t n)
	{
		checkLayout();
		G::powVec(z.v, &xVec[0].v, yVec, n);
	}
	bool operator==(const Additive& rhs) const { return v == rhs.v; }
	bool operator!=(const Additive& rhs) const { return !operator==(rhs); }
	// the layout must be the same as G for cast() (static assert for C++03)
	static void checkLayout()
	{
		typedef char layoutCheck[sizeof(G) == sizeof(Additive) ? 1 : -1];
		(void)sizeof(layoutCheck);
	}
	static Additive& cast(G& x) { checkLayout(); return *reinterpret_cast<Additive*>(&x); }
	static const Additive& cast(const G& x) { checkLayout(); return *reinterpret_cast<const Additive*>(&x); }
	static Additive* cast(G *x) { checkLayout(); return reinterpret_cast<Additive*>(x); }
	static const Additive* cast(const G *x) { checkLayout(); return reinterpret_cast<const Additive*>(x); }
};

/*
	sum of terms B_i k_i (at most N terms)
	A term whose base is MulG<G> and whose scalar is Fr is deferred and all of them are
	computed by one G::mulVecConstRef in get().
	The other terms (e.g. fp::WindowMethod or an integer scalar) are computed when they are added.
	The output of get() is written at the end, so it may alias an input.
*/
template<class G, size_t N>
struct Terms {
	G x[N];
	Fr y[N];
	size_t n;
	G r; // sum of the terms computed immediately (valid if hasR)
	bool hasR;
	Terms() : n(0), hasR(false) {}
	// deferred
	void add(const MulG<G>& m, const Fr& k)
	{
		assert(n < N);
		x[n] = m.base;
		y[n] = k;
		n++;
	}
	// computed now
	template<class M, class K>
	void add(const M& m, const K& k)
	{
		if (hasR) {
			G t;
			m.mul(t, k);
			r += t;
		} else {
			m.mul(r, k);
			hasR = true;
		}
	}
	// add -X c (plus = true) or X c (plus = false)
	template<class F>
	void addChallenge(const G& X, const F& c, bool plus)
	{
		if (plus) {
			F t;
			F::neg(t, c);
			add(MulG<G>(X), t);
		} else {
			add(MulG<G>(X), c);
		}
	}
	void get(G& out)
	{
		if (n == 0) {
			assert(hasR);
			out = r;
			return;
		}
		G::mulVecConstRef(out, x, y, n);
		if (hasR) out += r;
	}
};

/*
	a tuple of N bases for BitOr
	mul : out[j] = B_j * k
	add : add the term B_j * k to t
*/
template<class G, class M0>
struct Bases1 {
	static const size_t N = 1;
	const M0& m0;
	explicit Bases1(const M0& m0) : m0(m0) {}
	template<class INT>
	void mul(G out[1], const INT& k) const
	{
		m0.mul(out[0], k);
	}
	template<class T, class INT>
	void add(T& t, size_t j, const INT& k) const
	{
		assert(j == 0); (void)j;
		t.add(m0, k);
	}
};
template<class G, class M0, class M1>
struct Bases2 {
	static const size_t N = 2;
	const M0& m0;
	const M1& m1;
	Bases2(const M0& m0, const M1& m1) : m0(m0), m1(m1) {}
	template<class INT>
	void mul(G out[2], const INT& k) const
	{
		m0.mul(out[0], k);
		m1.mul(out[1], k);
	}
	template<class T, class INT>
	void add(T& t, size_t j, const INT& k) const
	{
		assert(j < 2);
		if (j == 0) {
			t.add(m0, k);
		} else {
			t.add(m1, k);
		}
	}
};
template<class G, class M0>
Bases1<G, M0> makeBases1(const M0& m0) { return Bases1<G, M0>(m0); }
template<class G, class M0, class M1>
Bases2<G, M0, M1> makeBases2(const M0& m0, const M1& m1) { return Bases2<G, M0, M1>(m0, m1); }

/*
	response of the Schnorr protocol for X = sum of B_i w_i
	z = k + c w (plus = true) or z = k - c w (plus = false)
*/
// F is deduced from z only (the others may be a class derived from F)
template<class F>
struct Identity {
	typedef F type;
};
template<class F>
void response(F& z, const typename Identity<F>::type& k, const typename Identity<F>::type& c, const typename Identity<F>::type& w, bool plus = true)
{
	F t;
	F::mul(t, c, w);
	if (plus) {
		F::add(z, k, t);
	} else {
		F::sub(z, k, t);
	}
	secureZero(&t, sizeof(t));
}

/*
	commitment R = sum of B_i k_i
*/
template<class G, class M0, class F0>
void commit1(G& R, const M0& m0, const F0& k0)
{
	m0.mul(R, k0);
}
template<class G, class M0, class F0, class M1, class F1>
void commit2(G& R, const M0& m0, const F0& k0, const M1& m1, const F1& k1)
{
	Terms<G, 2> t;
	t.add(m0, k0);
	t.add(m1, k1);
	t.get(R);
}
template<class G, class M0, class F0, class M1, class F1, class M2, class F2>
void commit3(G& R, const M0& m0, const F0& k0, const M1& m1, const F1& k1, const M2& m2, const F2& k2)
{
	Terms<G, 3> t;
	t.add(m0, k0);
	t.add(m1, k1);
	t.add(m2, k2);
	t.get(R);
}

/*
	recompute the commitment on the verifier side
	R = sum of B_i z_i - c X (plus = true) or R = sum of B_i z_i + c X (plus = false)
*/
template<class G, class M0, class F0, class F>
void recompute1(G& R, const M0& m0, const F0& z0, const G& X, const F& c, bool plus = true)
{
	Terms<G, 2> t;
	t.add(m0, z0);
	t.addChallenge(X, c, plus);
	t.get(R);
}
template<class G, class M0, class F0, class M1, class F1, class F>
void recompute2(G& R, const M0& m0, const F0& z0, const M1& m1, const F1& z1, const G& X, const F& c, bool plus = true)
{
	Terms<G, 3> t;
	t.add(m0, z0);
	t.add(m1, z1);
	t.addChallenge(X, c, plus);
	t.get(R);
}
template<class G, class M0, class F0, class M1, class F1, class M2, class F2, class F>
void recompute3(G& R, const M0& m0, const F0& z0, const M1& m1, const F1& z1, const M2& m2, const F2& z2, const G& X, const F& c, bool plus = true)
{
	Terms<G, 4> t;
	t.add(m0, z0);
	t.add(m1, z1);
	t.add(m2, z2);
	t.addChallenge(X, c, plus);
	t.get(R);
}

/*
	CDS 2-way OR proof for a bit b in {0, 1}
	The statement of the branch i is "X_j - i O_j = B_j t for all j < N" with a common witness t.
	O[j] == 0 means the zero point.
	The prover knows t for the branch b and simulates the branch 1 - b.

	prover:
		d[1-b], s[1-b] : random
		simulate(R[1-b], B, X, O, 1-b, d[1-b], s[1-b])
		k : random
		commit(R[b], B, k)
		c = Hash(..., R, ...)
		finish(d[b], s[b], c, d[1-b], k, t)
	verifier:
		recompute(R, B, X, O, d, s)
		check c == d[0] + d[1] (or d[1] == c - d[0], depends on the wire format)
*/
template<class G, class F, size_t N>
struct BitOr {
	/*
		R_j = B_j s - d (X_j - i O_j)
	*/
	template<class Bases>
	static void simulate(G R[N], const Bases& B, const G *const X[N], const G *const O[N], int i, const F& d, const F& s)
	{
		for (size_t j = 0; j < N; j++) {
			Terms<G, 2> t;
			B.add(t, j, s);
			if (i != 0 && O[j]) {
				G x;
				G::sub(x, *X[j], *O[j]);
				t.addChallenge(x, d, true);
			} else {
				t.addChallenge(*X[j], d, true);
			}
			t.get(R[j]);
		}
	}
	/*
		R_j = B_j k
	*/
	template<class Bases>
	static void commit(G R[N], const Bases& B, const F& k)
	{
		B.mul(R, k);
	}
	/*
		dReal = c - dSim
		sReal = k + dReal t
	*/
	static void finish(F& dReal, F& sReal, const F& c, const F& dSim, const F& k, const F& t)
	{
		F::sub(dReal, c, dSim);
		response(sReal, k, dReal, t);
	}
	/*
		R[i][j] = B_j s[i] - d[i] (X_j - i O_j) for i = 0, 1
	*/
	template<class Bases>
	static void recompute(G R[2][N], const Bases& B, const G *const X[N], const G *const O[N], const F d[2], const F s[2])
	{
		for (int i = 0; i < 2; i++) {
			simulate(R[i], B, X, O, i, d[i], s[i]);
		}
	}
};

} } // mcl::sigma
