#pragma once
/**
	@file
	@brief tiny vector class
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
*/
#include <malloc.h>
#include <stddef.h>

namespace mcl {
template<class T>
class Array {
	T *p_;
	size_t n_;
	Array(const Array&);
	void operator=(const Array&);
	template<class U>
	void swap_(U& x, U& y) const
	{
		U t;
		t = x;
		x = y;
		y = t;
	}
public:
	Array() : p_(0), n_(0) {}
	~Array()
	{
		free(p_);
	}
	bool resize(size_t n)
	{
		if (n <= n_) {
			n_ = n;
			if (n == 0) {
				free(p_);
				p_ = 0;
			}
			return true;
		}
		T *q = (T*)malloc(sizeof(T) * n);
		if (q == 0) return false;
		for (size_t i = 0; i < n_; i++) {
			q[i] = p_[i];
		}
		free(p_);
		p_ = q;
		n_ = n;
		return true;
	}
	bool copy(const Array<T>& rhs)
	{
		if (this == &rhs) return true;
		if (n_ < rhs.n_) {
			clear();
			if (!resize(rhs.n_)) return false;
		}
		for (size_t i = 0; i < rhs.n_; i++) {
			p_[i] = rhs.p_[i];
		}
		n_ = rhs.n_;
		return true;
	}
	void clear()
	{
		free(p_);
		p_ = 0;
		n_ = 0;
	}
	size_t size() const { return n_; }
	void swap(Array<T>& rhs)
	{
		swap_(p_, rhs.p_);
		swap_(n_, rhs.n_);
	}
	T& operator[](size_t n) { return p_[n]; }
	const T& operator[](size_t n) const { return p_[n]; }
	T* data() { return p_; }
	const T* data() const { return p_; }
};
} // mcl

