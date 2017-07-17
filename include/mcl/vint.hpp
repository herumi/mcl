#pragma once
/**
	emulate mpz_class
*/
#include <cybozu/exception.hpp>
#include <cybozu/bit_operation.hpp>
#include <cybozu/atoi.hpp>
#include <vector>
#include <iomanip>
#include <stdlib.h>
#include <assert.h>
#include <cmath>
#include <iostream>

#ifndef MIE_ZM_VUINT_BIT_LEN
	#define MIE_ZM_VUINT_BIT_LEN (64 * 9)
#endif

namespace mcl {

#ifdef MIE_USE_UNIT64
typedef uint64_t Unit;
#else
typedef uint32_t Unit;
#define MIE_USE_UNIT32
#endif

typedef struct {
	int allocSize_;
	int dataSize_;
	Unit *ptr_;
} Vint_struct;

namespace local {

inline uint64_t make64(uint32_t H, uint32_t L)
{
	return ((uint64_t)H << 32) | L;
}

inline void split64(uint32_t *H, uint32_t *L, uint64_t x)
{
	*H = uint32_t(x >> 32);
	*L = uint32_t(x);
}

/*
	[H:L] <= a * b
	@return L
*/
static inline Unit mulUnit(Unit *H, Unit a, Unit b)
{
#ifdef MIE_USE_UNIT32
	uint64_t t = uint64_t(a) * b;
	uint32_t L;
	split64(H, &L, t);
	return L;
#else
#if defined(_WIN64) && !defined(__INTEL_COMPILER)
	return _umul128(a, b, H);
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = uint128(a) * b;
	*H = uint64_t(t >> 64);
	return uint64_t(t);
#endif
#endif
}

/*
	q = [H:L] / y
	r = [H:L] % y
	return q
*/
static Unit divUnit(Unit *r, Unit H, Unit L, Unit y)
{
#ifdef MIE_USE_UNIT32
	uint64_t t = make64(H, L);
	uint32_t q = uint32_t(t / y);
	*r = Unit(t % y);
	return q;
#elif defined(_MSC_VER)
	fprintf(stderr, "not implemented divUnit\n");
	exit(1);
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = (uint128(H) << 64) | L;
	uint64_t q = uint64_t(t / y);
	*r = Unit(t % y);
	return q;
#endif
}

inline std::istream& getDigits(std::istream& is, std::string& str, bool allowNegative = false)
{
	std::ios_base::fmtflags keep = is.flags();
	size_t pos = 0;
	char c;
	while (is >> c) {
		if (('0' <= c && c <= '9') /* digits */
		  || (pos == 1 && (str[0] == '0' && c == 'x')) /* 0x.. */
		  || ('a' <= c && c <= 'f') /* lowercase hex */
		  || ('A' <= c && c <= 'F') /* uppercase hex */
		  || (allowNegative && pos == 0 && c == '-')) { /* -digits */
			str.push_back(c);
			if (pos == 0) {
				is >> std::noskipws;
			}
			pos++;
		} else {
			is.unget();
			break;
		}
	}
	is.flags(keep);
	return is;
}

template<class T>
inline void decStr2Int(T& x, const std::string& s)
{
	const size_t width = 9;
	const uint32_t d = (uint32_t)std::pow(10.0, 9);
	size_t size = s.size();
	size_t q = size / width;
	size_t r = size % width;
	const char *p = s.c_str();
	/*
		split s and compute x
		eg. 123456789012345678901234 => 123456, 789012345, 678901234
	*/
	uint32_t v;
	x = 0;
	if (r) {
		v = cybozu::atoi(p, r);
		p += r;
		x = v;
	}
	while (q) {
		v = cybozu::atoi(p, width);
		p += width;
		T::mul(x, x, d);
		T::add(x, x, v);
		q--;
	}
}

/*
	T must have compare, add, sub, mul
*/
template<class T>
struct Empty {};

template<class T, class E = Empty<T> >
struct Operator : E {
	inline friend bool operator<(const T& x, const T& y) { return T::compare(x, y) < 0; }
	inline friend bool operator>=(const T& x, const T& y) { return !operator<(x, y); }

	inline friend bool operator>(const T& x, const T& y) { return T::compare(x, y) > 0; }
	inline friend bool operator<=(const T& x, const T& y) { return !operator>(x, y); }
	inline friend bool operator==(const T& x, const T& y) { return T::compare(x, y) == 0; }
	inline friend bool operator!=(const T& x, const T& y) { return !operator==(x, y); }
	template<class N>
	inline T& operator+=(const N& rhs) { T::add(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	inline T& operator-=(const T& rhs) { T::sub(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	inline T& operator*=(const T& rhs) { T::mul(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	inline T& operator/=(const T& rhs) { T::div(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	inline T& operator%=(const T& rhs) { T::mod(static_cast<T&>(*this), static_cast<const T&>(*this), rhs); return static_cast<T&>(*this); }
	inline friend T operator+(const T& a, const T& b) { T c; T::add(c, a, b); return c; }
	inline friend T operator-(const T& a, const T& b) { T c; T::sub(c, a, b); return c; }
	inline friend T operator*(const T& a, const T& b) { T c; T::mul(c, a, b); return c; }
	inline friend T operator/(const T& a, const T& b) { T c; T::div(c, a, b); return c; }
	inline friend T operator%(const T& a, const T& b) { T c; T::mod(c, a, b); return c; }
	inline T operator-() const { T c; T::neg(c, static_cast<const T&>(*this)); return c; }
	inline T operator<<(size_t n) const { T out; T::shl(out, static_cast<const T&>(*this), n); return out; }
	inline T operator>>(size_t n) const { T out; T::shr(out, static_cast<const T&>(*this), n); return out; }

//	T& operator<<=(size_t n) { *this = *this << n; return static_cast<T&>(*this); }
//	T& operator>>=(size_t n) { *this = *this >> n; return static_cast<T&>(*this); }
	inline T& operator<<=(size_t n) { T::shl(static_cast<T&>(*this), static_cast<const T&>(*this), n); return static_cast<T&>(*this); }
	inline T& operator>>=(size_t n) { T::shr(static_cast<T&>(*this), static_cast<const T&>(*this), n); return static_cast<T&>(*this); }
};

/*
	compare x[] and y[]
	@retval positive  if x > y
	@retval 0         if x == y
	@retval negative  if x < y
*/
template<class T>
int compareNM(const T *x, size_t xn, const T *y, size_t yn)
{
	assert(xn > 0 && yn > 0);
	if (xn != yn) return xn > yn ? 1 : -1;
	for (int i = (int)xn - 1; i >= 0; i--) {
		if (x[i] != y[i]) return x[i] > y[i] ? 1 : -1;
	}
	return 0;
}

template<class T>
void clearN(T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) x[i] = 0;
}

template<class T>
void copyN(T *y, const T *x, size_t n)
{
	for (size_t i = 0; i < n; i++) y[i] = x[i];
}

/*
	z[] = x[n] + y[n]
	@note return 1 if having carry
	z may be equal to x or y
*/
template<class T>
T addN(T *z, const T *x, const T *y, size_t n)
{
	T c = 0;
	for (size_t i = 0; i < n; i++) {
		T xc = x[i] + c;
		if (xc < c) {
			// x[i] = Unit(-1) and c = 1
			z[i] = y[i];
		} else {
			xc += y[i];
			c = y[i] > xc ? 1 : 0;
			z[i] = xc;
		}
	}
	return c;
}

/*
	z[] = x[] + y
*/
template<class T>
T add1(T *z, const T *x, size_t n, T y)
{
	assert(n > 0);
	T t = x[0] + y;
	z[0] = t;
	size_t i = 0;
	if (t >= y) goto EXIT_0;
	i = 1;
	for (; i < n; i++) {
		t = x[i] + 1;
		z[i] = t;
		if (t != 0) goto EXIT_0;
	}
	return 1;
EXIT_0:
	i++;
	for (; i < n; i++) {
		z[i] = x[i];
	}
	return 0;
}

/*
	z[] = x[xn] + y[yn]
	@note size of z must be max(xn, yn) + 1
*/
template<class T>
T addNM(T *z, const T *x, size_t xn, const T *y, size_t yn)
{
	if (yn > xn) {
		std::swap(xn, yn);
		std::swap(x, y);
	}
	assert(xn >= yn);
	size_t max = xn;
	size_t min = yn;
	T c = local::addN(z, x, y, min);
	if (max > min) {
		c = local::add1(z + min, x + min, max - min, c);
	}
	return c;
}

/*
	z[] = x[n] - y[n]
	z may be equal to x or y
*/
template<class T>
T subN(T *z, const T *x, const T *y, size_t n)
{
	assert(n > 0);
	T c = 0;
	for (size_t i = 0; i < n; i++) {
		T yc = y[i] + c;
		if (yc < c) {
			// y[i] = T(-1) and c = 1
			z[i] = x[i];
		} else {
			c = x[i] < yc ? 1 : 0;
			z[i] = x[i] - yc;
		}
	}
	return c;
}

/*
	out[] = x[n] - y
*/
template<class T>
T sub1(T *z, const T *x, size_t n, T y)
{
	assert(n > 0);
#if 0
	T t = x[0];
	z[0] = t - y;
	size_t i = 0;
	if (t >= y) goto EXIT_0;
	i = 1;
	for (; i < n; i++ ){
		t = x[i];
		z[i] = t - 1;
		if (t != 0) goto EXIT_0;
	}
	return 1;
EXIT_0:
	i++;
	for (; i < n; i++) {
		z[i] = x[i];
	}
	return 0;
#else
	T c = x[0] < y ? 1 : 0;
	z[0] = x[0] - y;
	for (size_t i = 1; i < n; i++) {
		if (x[i] < c) {
			z[i] = T(-1);
		} else {
			z[i] = x[i] - c;
			c = 0;
		}
	}
	return c;
#endif
}

/*
	z[0..n) = x[0..n] * y
	return z[n]
	@note accept z == x
*/
template<class T>
T mul1(T *z, const T *x, size_t n, T y)
{
	assert(n > 0);
	T H = 0;
	for (size_t i = 0; i < n; i++) {
		T t = H;
		T L = mulUnit(&H, x[i], y);
		z[i] = t + L;
		if (z[i] < t) {
			H++;
		}
	}
	return H; // z[n]
}

/*
	T[xn * yn] = x[xn] * y[ym]
*/
template<class T>
static inline void mulNM(T *out, const T *x, size_t xn, const T *y, size_t yn)
{
	assert(xn > 0 && yn > 0);
	if (yn > xn) {
		std::swap(yn, xn);
		std::swap(x, y);
	}
	assert(xn >= yn);
	if (out == x) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * xn);
		copyN(p, x, xn);
		x = p;
	}
	if (out == y) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * yn);
		copyN(p, y, yn);
		y = p;
	}
	out[xn] = mul1(&out[0], x, xn, y[0]);
	clearN(out + xn + 1, yn - 1);

	T *t2 = (T*)CYBOZU_ALLOCA(sizeof(T) * (xn + 1));
	for (size_t i = 1; i < yn; i++) {
		t2[xn] = local::mul1(&t2[0], x, xn, y[i]);
		local::addN(&out[i], &out[i], &t2[0], xn + 1);
	}
}

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
template<class T>
T div1(T *q, const T *x, size_t n, T y)
{
	T r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		q[i] = divUnit(&r, r, x[i], y);
	}
	return r;
}
/*
	q[] = x[] / y
	@retval r = x[] % y
*/
template<class T>
T mod1(const T *x, size_t n, T y)
{
	T r = 0;
	for (int i = (int)n - 1; i >= 0; i--) {
		divUnit(&r, r, x[i], y);
	}
	return r;
}

/*
	get approximate value from x[xn - 1..]
	@param up [in] round up if true
*/
template<class T>
static inline double GetApp(const T *x, size_t xn, bool up)
{
	union di {
		double f;
		uint64_t i;
	};
	assert(xn >= 2);
	T H = x[xn - 1];
	assert(H);
	union di di;
	di.f = (double)H;
	unsigned int len = int(di.i >> 52) - 1023 + 1;
#ifdef MIE_USE_UNIT32
	uint32_t M = x[xn - 2];
	if (len >= 21) {
		di.i |= M >> (len - 21);
	} else {
		di.i |= uint64_t(M) << (21 - len);
		if (xn >= 3) {
			uint32_t L = x[xn - 3];
			di.i |= L >> (len + 11);
		}
	}
#else
	if (len < 53) {
		uint64_t L = x[xn - 2];
		di.i |= L >> (len + 11);
	} else {
		// avoid rounding in converting from uint64_t to double
		di.f = (double)(H & ~((uint64_t(1) << (len - 53)) - 1));
	}
#endif
	double t = di.f;
	if (up) {
		di.i = uint64_t(len + 1022 - 52 + 1) << 52;
		t += di.f;
	}
	return t;
}

/*
	q[] = x[xn] / y[yn] ; size of q = xn - yn + 1 if q
	r[] = x[xn] % y[yn] ; size of r = xn
*/
template<class T>
void divNM(T *q, T *r, const T *x, size_t xn, const T *y, size_t yn)
{
	assert(xn > 0 && yn > 0);
	if (x == q || x == r) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * xn);
		copyN(p, x, xn);
		x = p;
	}
	if (y == q || y == r) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * yn);
		copyN(p, y, yn);
		y = p;
	}
	if (q) {
		clearN(q, xn - yn + 1);
	}
	if (yn > xn) {
		copyN(r, x, xn);
		return;
	}
	if (yn == 1) {
		T t;
		if (q) {
			t = div1(q, x, xn, y[0]);
		} else {
			t = mod1(x, xn, y[0]);
		}
		r[0] = t;
		clearN(r + 1, xn - 1);
		return;
	}
//	assert(xn >= yn && yn >= 2);
	if (x == y) {
		assert(xn == yn);
		clearN(r, xn);
		if (q) {
			q[0] = 1;
		}
		return;
	}
	copyN(r, x, xn);
	T *t = (T*)CYBOZU_ALLOCA(sizeof(T) * (yn + 1));
	double yt = GetApp(y, yn, true);
	while (local::compareNM(r, xn, y, yn) >= 0) {
		size_t len = yn;
		double xt = GetApp(r, xn, false);
		if (local::compareNM(&r[xn - len], yn, y, yn) < 0) {
			xt *= double(1ULL << (sizeof(T) * 8 - 1)) * 2;
			len++;
		}
		T qt = T(xt / yt);
		if (qt == 0) qt = 1;
		t[yn] = local::mul1(&t[0], y, yn, qt);
		T b = local::subN(&r[xn - len], &r[xn - len], &t[0], len);
		if (b) {
			assert(!b);
		}
		if (q) q[xn - len] += qt;

		while (xn >= yn && r[xn - 1] == 0) {
			xn--;
		}
	}
}

/*
	y[] = x[] << bit
	0 < bit < sizeof(T) * 8
	accept y == x
*/
template<class T>
T shlBit(T *y, const T *x, size_t xn, size_t bit)
{
	assert(0 < bit && bit < sizeof(T) * 8);
	assert(xn > 0);
	size_t rBit = sizeof(T) * 8 - bit;
	T keep = x[xn - 1];
	T prev = keep;
	for (size_t i = xn - 1; i > 0; i--) {
		T t = x[i - 1];
		y[i] = (prev << bit) | (t >> rBit);
		prev = t;
	}
	y[0] = prev << bit;
	return keep >> rBit;
}

/*
	y[yn] = x[xn] << bit
	yn = xn + (bit + unitBitBit - 1) / unitBitSize
	accept y == x
*/
template<class T>
void shlN(T *y, const T *x, size_t xn, size_t bit)
{
	assert(xn > 0);
	const size_t unitBitSize = sizeof(T) * 8;
	size_t q = bit / unitBitSize;
	size_t r = bit % unitBitSize;
	if (r == 0) {
		// don't use copyN(y + q, x, xn); if overlaped
		for (size_t i = 0; i < xn; i++) {
			y[q + xn - 1 - i] = x[xn - 1 - i];
		}
	} else {
		y[q + xn] = shlBit(y + q, x, xn, r);
	}
	clearN(y, q);
}

/*
	y[] = x[] >> bit
	0 < bit < sizeof(T) * 8
*/
template<class T>
void shrBit(T *y, const T *x, size_t xn, size_t bit)
{
	assert(0 < bit && bit < sizeof(T) * 8);
	assert(xn > 0);
	size_t rBit = sizeof(T) * 8 - bit;
	T prev = x[0];
	for (size_t i = 1; i < xn; i++) {
		T t = x[i];
		y[i - 1] = (prev >> bit) | (t << rBit);
		prev = t;
	}
	y[xn - 1] = prev >> bit;
}
/*
	y[yn] = x[xn] >> bit
	yn = xn - bit / unitBit
*/
template<class T>
void shrN(T *y, const T *x, size_t xn, size_t bit)
{
	assert(xn > 0);
	const size_t unitBitSize = sizeof(T) * 8;
	size_t q = bit / unitBitSize;
	size_t r = bit % unitBitSize;
	if (r == 0) {
		copyN(y, x + q, xn - q);
	} else {
		shrBit(y, x + q, xn - q, r);
	}
}

template<class T>
class VariableBuffer {
	std::vector<T> v_;
public:
	typedef T value_type;
	VariableBuffer()
	{
	}
	void clear() { v_.clear(); }

	/*
		@note extended buffer may be not cleared
	*/
	void alloc(size_t n)
	{
		v_.resize(n);
	}
	void swap(VariableBuffer& rhs) { v_.swap(rhs.v_); }

	/*
		*this = rhs
		rhs may be destroyed
	*/
	size_t allocSize() const { return v_.size(); }
	const T& operator[](size_t n) const { return v_[n]; }
	T& operator[](size_t n) { return v_[n]; }
};

template<class T>
class Buffer {
	size_t allocSize_;
	T *ptr_;
public:
	typedef T value_type;
	Buffer() : allocSize_(0), ptr_(0) {}
	~Buffer()
	{
		clear();
	}
	Buffer(const Buffer& rhs)
		: allocSize_(rhs.allocSize_)
		, ptr_(0)
	{
		ptr_ = (T*)malloc(allocSize_ * sizeof(T));
		if (ptr_ == 0) throw cybozu::Exception("Buffer:malloc") << rhs.allocSize_;
		memcpy(ptr_, rhs.ptr_, allocSize_ * sizeof(T));
	}
	Buffer& operator=(const Buffer& rhs)
	{
		Buffer t(rhs);
		swap(t);
		return *this;
	}
	void swap(Buffer& rhs)
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
		noexcept
#endif
	{
		std::swap(allocSize_, rhs.allocSize_);
		std::swap(ptr_, rhs.ptr_);
	}
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
	Buffer(Buffer&& rhs) noexcept
		: allocSize_(0)
		, ptr_(0)
	{
		swap(rhs);
	}
	Buffer& operator=(Buffer&& rhs) noexcept
	{
		swap(rhs);
		return *this;
	}
#endif
	void clear()
	{
		allocSize_ = 0;
		free(ptr_);
		ptr_ = 0;
	}

	/*
		@note extended buffer may be not cleared
	*/
	void alloc(size_t n)
	{
		if (n > allocSize_) {
			T *p = (T*)malloc(n * sizeof(T));
			if (p == 0) throw cybozu::Exception("Buffer:alloc:malloc:") << n;
			copyN(p, ptr_, allocSize_);
			free(ptr_);
			ptr_ = p;
			allocSize_ = n;
		}
	}
	/*
		*this = rhs
		rhs may be destroyed
	*/
	const T& operator[](size_t n) const { return ptr_[n]; }
	T& operator[](size_t n) { return ptr_[n]; }
};

template<class T, size_t BitLen>
class FixedBuffer {
	enum {
		N = (BitLen + sizeof(T) * 8 - 1) / (sizeof(T) * 8)
	};
	T v_[N];
	size_t size_;
public:
	typedef T value_type;
	FixedBuffer()
		: size_(0)
	{
	}
	FixedBuffer(const FixedBuffer& rhs)
	{
		operator=(rhs);
	}
	FixedBuffer& operator=(const FixedBuffer& rhs)
	{
		size_ = rhs.size_;
		for (size_t i = 0; i < size_; i++) {
			v_[i] = rhs.v_[i];
		}
		return *this;
	}
	void clear() { size_ = 0; }
	void alloc(size_t n)
	{
		verify(n);
		size_ = n;
	}
	void swap(FixedBuffer& rhs)
	{
		FixedBuffer *p1 = this;
		FixedBuffer *p2 = &rhs;
		if (p1->size_ < p2->size_) {
			std::swap(p1, p2);
		}
		assert(p1->size_ >= p2->size_);
		for (size_t i = 0; i < p2->size_; i++) {
			std::swap(p1->v_[i], p2->v_[i]);
		}
		for (size_t i = p2->size_; i < p1->size_; i++) {
			p2->v_[i] = p1->v_[i];
		}
		std::swap(p1->size_, p2->size_);
	}
	// to avoid warning of gcc
	void verify(size_t n) const
	{
		if (n > N) {
			throw cybozu::Exception("verify:too large size") << n << N;
		}
	}
	const T& operator[](size_t n) const { verify(n); return v_[n]; }
	T& operator[](size_t n) { verify(n); return v_[n]; }
};

} // local

/**
	signed integer with variable length
*/
template<class _Buffer>
class VintT : public local::Operator<VintT<_Buffer> > {
public:
	typedef _Buffer Buffer;
	typedef typename Buffer::value_type value_type;
	typedef typename Buffer::value_type T;
	static const size_t unitBitSize = sizeof(T) * 8;
private:
	Buffer buf_;
	size_t size_;
	bool isNeg_;
	void trim(size_t n)
	{
		if (n == 0) throw cybozu::Exception("trim zero");
		int i = (int)n - 1;
		for (; i > 0; i--) {
			if (buf_[i]) {
				size_ = i + 1;
				return;
			}
		}
		size_ = 1;
		// zero
		if (buf_[0] == 0) {
			isNeg_ = false;
		}
	}
	static int ucompare(const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		return local::compareNM(&x[0], xn, &y[0], yn);
	}
	static void uadd(VintT& z, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		size_t zn = std::max(xn, yn) + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = local::addNM(&z.buf_[0], &x[0], xn, &y[0], yn);
		z.trim(zn);
	}
	static void uadd1(VintT& z, const Buffer& x, size_t xn, T y)
	{
		size_t zn = xn + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = local::add1(&z.buf_[0], &x[0], xn, y);
		z.trim(zn);
	}
	static void usub1(VintT& z, const Buffer& x, size_t xn, T y)
	{
		size_t zn = xn;
		z.buf_.alloc(zn);
		T c = local::sub1(&z.buf_[0], &x[0], xn, y);
		assert(!c);
		z.trim(zn);
	}
	static void umul1(VintT& z, const Buffer& x, size_t xn, T y)
	{
		size_t zn = xn + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = local::mul1(&z.buf_[0], &x[0], xn, y);
		z.trim(zn);
	}
	static void usub(VintT& z, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		assert(xn >= yn);
		z.buf_.alloc(xn);
		T c = local::subN(&z.buf_[0], &x[0], &y[0], yn);
		if (xn > yn) {
			c = local::sub1(&z.buf_[yn], &x[yn], xn - yn, c);
		}
		assert(!c);
		z.trim(xn);
	}
	static void _add(VintT& z, const VintT& x, bool xNeg, const VintT& y, bool yNeg)
	{
		if ((xNeg ^ yNeg) == 0) {
			// same sign
			uadd(z, x.buf_, x.size(), y.buf_, y.size());
			z.isNeg_ = xNeg;
			return;
		}
		int r = ucompare(x.buf_, x.size(), y.buf_, y.size());
		if (r >= 0) {
			usub(z, x.buf_, x.size(), y.buf_, y.size());
			z.isNeg_ = xNeg;
		} else {
			usub(z, y.buf_, y.size(), x.buf_, x.size());
			z.isNeg_ = yNeg;
		}
	}
	void setSize(size_t n) { size_ = n; }
	/**
		@param q [out] q = x / y
		@param x [in]
		@param y [in] must be not zero
		@return x % y
	*/
	static T udiv1(VintT *q, const Buffer& x, size_t xn, T y)
	{
		T r;
		if (q) {
			q->buf_.alloc(xn); // assume q is not destroyed if q == x
			r = local::div1(&q->buf_[0], &x[0], xn, y);
			q->trim(xn);
		} else {
			r = local::mod1(&x[0], xn, y);
		}
		return r;
	}
	/**
		@param q [out] x / y if q != 0
		@param r [out] x % y
		@retval true if y != 0
		@retavl false if y == 0
	*/
	static void udiv(VintT* q, VintT& r, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		assert(q != &r);
		size_t qn = xn - yn + 1;
		if (q) {
			q->buf_.alloc(qn);
		}
		r.buf_.alloc(xn);
		local::divNM(q ? &q->buf_[0] : 0, &r.buf_[0], &x[0], xn, &y[0], yn);
		if (q) {
			q->trim(qn);
		}
		r.trim(xn);
	}
public:
	VintT(int x = 0)
		: size_(0)
	{
		*this = x;
	}
	explicit VintT(const std::string& str)
		: size_(0)
	{
		setStr(str);
	}
	VintT& operator=(int x)
	{
		isNeg_ = x < 0;
		buf_.alloc(1);
		buf_[0] = std::abs(x);
		setSize(1);
		return *this;
	}
	/*
		set positive value
		@note assume little endian system
	*/
	template<class S>
	void setArray(const S *x, size_t size)
	{
		isNeg_ = false;
		if (size == 0) {
			clear();
			return;
		}
		size_t unitSize = (sizeof(S) * size + sizeof(T) - 1) / sizeof(T);
		buf_.alloc(unitSize);
		buf_[unitSize - 1] = 0;
		memcpy(&buf_[0], x, sizeof(S) * size);
		trim(unitSize);
	}
	/*
		get abs value
		buf_[0, size) = x
		buf_[size, maxSize) with zero
		@note assume little endian system
	*/
	void getArray(T *x, size_t maxSize) const
	{
		size_t n = size();
		if (n > maxSize) throw cybozu::Exception("Vint:getArray:small maxSize") << maxSize << n;
		local::copyN(x, &buf_[0], n);
		local::clearN(x + n, maxSize - n);
	}
	void clear() { *this = 0; }
	std::string getStr(int base = 10) const
	{
		std::ostringstream os;
		if (isNeg_) os << '-';
		switch (base) {
		case 10:
			{
				const uint32_t i1e9 = 1000000000U;
				VintT x = *this;

				std::vector<uint32_t> t;
				while (!x.isZero()) {
					uint32_t r = (uint32_t)udiv1(&x, x.buf_, x.size(), i1e9);
					t.push_back(r);
				}
				if (t.empty()) {
					return "0";
				}
				os << t[t.size() - 1];
				for (size_t i = 1, n = t.size(); i < n; i++) {
					os << std::setfill('0') << std::setw(9) << t[n - 1 - i];
				}
			}
			break;
		case 16:
			{
				os << "0x" << std::hex;
				const size_t n = size();
				os << getUnit()[n - 1];
				for (size_t i = 1; i < n; i++) {
					os << std::setfill('0') << std::setw(sizeof(Unit) * 2) << getUnit()[n - 1 - i];
				}
			}
			break;
		default:
			throw cybozu::Exception("getStr:not supported base") << base;
		}
		return os.str();
	}
	/*
		return bitLen(abs(*this))
	*/
	size_t bitLen() const
	{
		if (isZero()) return 0;
		size_t n = size();
		T v = buf_[n - 1];
		assert(v);
		return (n - 1) * sizeof(T) * 8 + 1 + cybozu::bsr<T>(v);
	}
	// ignore sign
	bool testBit(size_t i) const
	{
		size_t unit_pos = i / (sizeof(T) * 8);
		size_t bit_pos  = i % (sizeof(T) * 8);
		T mask = T(1) << bit_pos;
		return (buf_[unit_pos] & mask) != 0;
	}
	/*
		@param str [in] number string
		@note "0x..."   => base = 16
		      "0b..."   => base = 2
		      otherwise => base = 10
	*/
	void setStr(std::string str, int base = 0)
	{
		bool neg = false;
		if (!str.empty() && str[0] == '-') {
			neg = true;
			str = str.substr(1);
		}
		if (str.size() >= 2 && str[0] == '0') {
			switch (str[1]) {
			case 'x':
				if (base != 0 && base != 16) throw cybozu::Exception("bad base in setStr(str)") << base;
				base = 16;
				str = str.substr(2);
				break;
			default:
				throw cybozu::Exception("not support base in setStr(str) 0") << str[1];
			}
		}
		if (base == 0) {
			base = 10;
		}
		if (str.empty()) throw cybozu::Exception("empty string");

		switch (base) {
		case 16:
			{
				std::vector<uint32_t> x;
				while (!str.empty()) {
					size_t remain = std::min((int)str.size(), 8);
					char *endp;
					uint32_t v = strtoul(&str[str.size() - remain], &endp, 16);
					if (*endp) goto ERR;
					x.push_back(v);
					str = str.substr(0, str.size() - remain);
				}
				setArray(&x[0], x.size());
			}
			break;
		default:
		case 10:
			decStr2Int(*this, str);
			break;
		}
		if (!isZero() && neg) {
			isNeg_ = true;
		}
		return;
	ERR:
		throw std::invalid_argument(std::string("bad digit `") + str + "`");
	}
	static int compare(const VintT& x, const VintT& y)
	{
		if (x.isNeg_ ^ y.isNeg_) {
			if (x.isZero() && y.isZero()) return 0;
			return x.isNeg_ ? -1 : 1;
		} else {
			// same sign
			int c = ucompare(x.buf_, x.size(), y.buf_, y.size());
			if (x.isNeg_) {
				return -c;
			}
			return c;
		}
	}
	size_t size() const { return size_; }
	bool isZero() const { return size() == 1 && buf_[0] == 0; }
	bool isNegative() const { return isNeg_; }
	static void add(VintT& z, const VintT& x, const VintT& y)
	{
		_add(z, x, x.isNeg_, y, y.isNeg_);
	}
	static void sub(VintT& z, const VintT& x, const VintT& y)
	{
		_add(z, x, x.isNeg_, y, !y.isNeg_);
	}
	static void mul(VintT& z, const VintT& x, const VintT& y)
	{
		const size_t xn = x.size();
		const size_t yn = y.size();
		size_t zn = xn + yn;
		z.buf_.alloc(zn);
		local::mulNM(&z.buf_[0], &x.buf_[0], xn, &y.buf_[0], yn);
		z.trim(zn);
		z.isNeg_ = x.isNeg_ ^ y.isNeg_;
	}
	static void mul(VintT& z, const VintT& x, T y)
	{
		umul1(z, x.buf_, x.size(), y);
		z.isNeg_ = x.isNeg_;
	}
	/*
		@note ignore sign
	*/
	static T udiv1(VintT *q, const VintT& x, T y)
	{
		if (q) {
			q->isNeg_ = false;
			return udiv1(q, x.buf_, x.size(), y);
		} else {
			return udiv1(0, x.buf_, x.size(), y);
		}
	}
	/*
		like C
		  13 /  5 =  2 ...  3
		  13 / -5 = -2 ...  3
		 -13 /  5 = -2 ... -3
		 -13 / -5 =  2 ... -3
	*/
	static void divMod(VintT *q, VintT& r, const VintT& x, const VintT& y)
	{
		bool qsign = x.isNeg_ ^ y.isNeg_;
		udiv(q, r, x.buf_, x.size(), y.buf_, y.size());
		r.isNeg_ = x.isNeg_;
		if (q) q->isNeg_ = qsign;
	}
	static void div(VintT& q, const VintT& x, const VintT& y)
	{
		VintT r;
		divMod(&q, r, x, y);
	}
	static void mod(VintT& r, const VintT& x, const VintT& y)
	{
		divMod(0, r, x, y);
	}
	/*
		like Python
		 13 /  5 =  3 ...  2
		 13 / -5 = -3 ... -2
		-13 /  5 = -3 ...  2
		-13 / -5 =  2 ... -3
	*/
	static void quotRem(VintT *q, VintT& r, const VintT& x, const VintT& y)
	{
		VintT yy = y;
		bool qsign = x.isNeg_ ^ y.isNeg_;
		udiv(q, r, x.buf_, x.size(), y.buf_, y.size());
		r.isNeg_ = y.isNeg_;
		if (q) q->isNeg_ = qsign;
		if (!r.isZero() && qsign) {
			if (q) {
				uadd1(*q, q->buf_, q->size(), 1);
			}
			usub(r, yy.buf_, yy.size(), r.buf_, r.size());
		}
	}
	static void neg(VintT& z, const VintT& x)
	{
		if (&z != &x) { z = x; }
		z.isNeg_ = !x.isNeg_;
	}
	inline friend std::ostream& operator<<(std::ostream& os, const VintT& x)
	{
		return os << x.getStr(os.flags() & std::ios_base::hex ? 16 : 10);
	}
	inline friend std::istream& operator>>(std::istream& is, VintT& x)
	{
		std::string str;
		local::getDigits(is, str, true);
		x.setStr(str);
		return is;
	}
	// logical left shift (ignore sign)
	static void shl(VintT& y, const VintT& x, size_t shiftBit)
	{
		size_t xn = x.size();
		size_t yn = xn + (shiftBit + unitBitSize - 1) / unitBitSize;
		y.buf_.alloc(yn);
		local::shlN(&y.buf_[0], &x.buf_[0], xn, shiftBit);
		y.isNeg_ = x.isNeg_;
		y.trim(yn);
	}
	// logical right shift (ignore sign)
	static void shr(VintT& y, const VintT& x, size_t shiftBit)
	{
		size_t xn = x.size();
		if (xn * unitBitSize <= shiftBit) {
			y.clear();
			return;
		}
		size_t yn = xn - shiftBit / unitBitSize;
		y.buf_.alloc(yn);
		local::shrN(&y.buf_[0], &x.buf_[0], xn, shiftBit);
		y.isNeg_ = x.isNeg_;
		y.trim(yn);
	}
	static void abs(VintT& z, const VintT& x)
	{
		if (&z != &x) { z = x; }
		z.isNeg_ = false;
	}
	const T *getUnit() const { return &buf_[0]; }
};

namespace util {
/*
	dispatch Uint, int, size_t, and so on
*/
template<class T>
struct IntTag {
	typedef typename T::value_type value_type;
	static value_type getBlock(const T& x, size_t i)
	{
		return x.getUnit()[i];
	}
	static size_t getBlockSize(const T& x)
	{
		return x.size();
	}
};

template<>
struct IntTag<int> {
	typedef int value_type;
	static value_type getBlock(const int& x, size_t)
	{
		return x;
	}
	static size_t getBlockSize(const int&)
	{
		return 1;
	}
};
template<>
struct IntTag<size_t> {
	typedef size_t value_type;
	static value_type getBlock(const size_t& x, size_t)
	{
		return x;
	}
	static size_t getBlockSize(const size_t&)
	{
		return 1;
	}
};

} // util

/**
	return pow(x, y)
*/
template<class T, class S>
T power(const T& x, const S& y)
{
	typedef typename mcl::util::IntTag<S> Tag;
	typedef typename Tag::value_type value_type;
	T t(x);
	T out = 1;
	for (size_t i = 0, n = Tag::getBlockSize(y); i < n; i++) {
		value_type v = Tag::getBlock(y, i);
		int m = (int)sizeof(value_type) * 8;
		if (i == n - 1) {
			// avoid unused multiplication
			while (m > 0 && (v & (value_type(1) << (m - 1))) == 0) {
				m--;
			}
		}
		for (int j = 0; j < m; j++) {
			if (v & (value_type(1) << j)) {
				out *= t;
			}
			t *= t;
		}
	}
	return out;
}

//typedef VintT<local::VariableBuffer<mcl::Unit> > Vint;
//typedef VintT<local::FixedBuffer<mcl::Unit, MIE_ZM_VUINT_BIT_LEN> > Vint;
typedef VintT<local::Buffer<mcl::Unit> > Vint;

} // mcl

//typedef mcl::Vint mpz_class;
