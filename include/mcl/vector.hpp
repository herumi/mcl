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
#include <algorithm>

namespace mcl {
template<class T>
class Vector {
	T *p_;
	size_t n_;
	Vector(const Vector&);
	void operator=(const Vector&);
public:
	Vector() : p_(0), n_(0) {}
	~Vector()
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
	bool copy(const Vector<T>& rhs)
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
	void swap(Vector<T>& rhs)
	{
		std::swap(p_, rhs.p_);
		std::swap(n_, rhs.n_);
	}
	T& operator[](size_t n) { return p_[n]; }
	const T& operator[](size_t n) const { return p_[n]; }
	T* data() { return p_; }
	const T* data() const { return p_; }
};
} // mcl

