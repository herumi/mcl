#pragma once
/**
	@file
	@brief Lagrange Interpolation
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <vector>

namespace mcl {

/*
	recover out = f(0) by { (x, y) | x = S[i], y = f(x) = vec[i] }
	@retval 0 if succeed else -1
*/
template<class G, class F>
void LagrangeInterpolation(G& out, const F *S, const G *vec, size_t k)
{
	/*
		delta_{i,S}(0) = prod_{j != i} S[j] / (S[j] - S[i]) = a / b
		where a = prod S[j], b = S[i] * prod_{j != i} (S[j] - S[i])
	*/
	if (k < 2) throw cybozu::Exception("LagrangeInterpolation:smalll k") << k;
	std::vector<F> delta(k);
	F a = S[0];
	for (size_t i = 1; i < k; i++) {
		a *= S[i];
	}
	if (a.isZero()) throw cybozu::Exception("LagrangeInterpolation:S has zero");
	for (size_t i = 0; i < k; i++) {
		F b = S[i];
		for (size_t j = 0; j < k; j++) {
			if (j != i) {
				F v = S[j] - S[i];
				if (v.isZero()) throw cybozu::Exception("LagrangeInterpolation:same S") << i << j;
				b *= v;
			}
		}
		delta[i] = a / b;
	}

	/*
		f(0) = sum_i f(S[i]) delta_{i,S}(0)
	*/
	G r, t;
	r.clear();
	for (size_t i = 0; i < delta.size(); i++) {
		G::mul(t, vec[i], delta[i]);
		r += t;
	}
	out = r;
}

/*
	out = f(x) = c[0] + c[1] * x + c[2] * x^2 + ... + c[cSize - 1] * x^(cSize - 1)
	@retval 0 if succeed else -1
*/
template<class G, class T>
void evaluatePolynomial(G& out, const G *c, size_t cSize, const T& x)
{
	if (cSize < 2) throw cybozu::Exception("evaluatePolynomial:small cSize") << cSize;
	G y = c[cSize - 1];
	for (int i = (int)cSize - 2; i >= 0; i--) {
		G::mul(y, y, x);
		G::add(y, y, c[i]);
	}
	out = y;
}

} // mcl
