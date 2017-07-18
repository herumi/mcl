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
#include <mcl/util.hpp>

#ifndef MCL_VINT_UNIT_BYTE_SIZE
	#define MCL_VINT_UNIT_BYTE_SIZE 4
#endif

namespace mcl {

namespace local {

#if MCL_VINT_UNIT_BYTE_SIZE == 8
typedef uint64_t Unit;
#elif MCL_VINT_UNIT_BYTE_SIZE == 4
typedef uint32_t Unit;
#else
	#error "define MCL_VINT_UNIT_BYTE_SIZE"
#endif

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
#if MCL_VINT_UNIT_BYTE_SIZE == 4
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
#if MCL_VINT_UNIT_BYTE_SIZE == 4
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
#if MCL_VINT_UNIT_BYTE_SIZE == 4
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
	typedef T Unit;
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
	typedef T Unit;
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
	typedef T Unit;
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
class VintT {
public:
	typedef _Buffer Buffer;
	typedef typename Buffer::Unit Unit;
	static const size_t unitBitSize = sizeof(Unit) * 8;
	static const int invalidVar = -2147483648; // abs(invalidVar) is not defined
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
	static void uadd1(VintT& z, const Buffer& x, size_t xn, Unit y)
	{
		size_t zn = xn + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = local::add1(&z.buf_[0], &x[0], xn, y);
		z.trim(zn);
	}
	static void usub1(VintT& z, const Buffer& x, size_t xn, Unit y)
	{
		size_t zn = xn;
		z.buf_.alloc(zn);
		Unit c = local::sub1(&z.buf_[0], &x[0], xn, y);
		assert(!c);
		z.trim(zn);
	}
	static void usub(VintT& z, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		assert(xn >= yn);
		z.buf_.alloc(xn);
		Unit c = local::subN(&z.buf_[0], &x[0], &y[0], yn);
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
	static void _add1(VintT& z, const VintT& x, bool xNeg, int y, bool yNeg)
	{
		assert(y >= 0);
		if ((xNeg ^ yNeg) == 0) {
			// same sign
			uadd1(z, x.buf_, x.size(), y);
			z.isNeg_ = xNeg;
			return;
		}
		if (x.size() > 1 || x.buf_[0] >= (Unit)y) {
			usub1(z, x.buf_, x.size(), y);
			z.isNeg_ = xNeg;
		} else {
			z = y - x.buf_[0];
			z.isNeg_ = yNeg;
		}
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
	struct MulMod {
		const VintT *pm;
		void operator()(VintT& z, const VintT& x, const VintT& y) const
		{
			VintT::mul(z, x, y);
			z %= *pm;
		}
	};
	struct SqrMod {
		const VintT *pm;
		void operator()(VintT& y, const VintT& x) const
		{
			VintT::sqr(y, x);
			y %= *pm;
		}
	};
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
		if (x == invalidVar) throw cybozu::Exception("VintT:operator=:invalidVar");
		isNeg_ = x < 0;
		buf_.alloc(1);
		buf_[0] = std::abs(x);
		size_ = 1;
		return *this;
	}
	void swap(VintT& rhs)
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
		noexcept
#endif
	{
		std::swap(buf_, rhs.buf_);
		std::swap(size_, rhs.size_);
		std::swap(isNeg_, rhs.isNeg_);
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
		size_t unitSize = (sizeof(S) * size + sizeof(Unit) - 1) / sizeof(Unit);
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
	void getArray(Unit *x, size_t maxSize) const
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
				VintT x;
				VintT::abs(x, *this);

				std::vector<uint32_t> t;
				while (!x.isZero()) {
					uint32_t r = divMod1(&x, x, i1e9);
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
		Unit v = buf_[n - 1];
		assert(v);
		return (n - 1) * sizeof(Unit) * 8 + 1 + cybozu::bsr<Unit>(v);
	}
	// ignore sign
	bool testBit(size_t i) const
	{
		size_t q = i / unitBitSize;
		size_t r = i % unitBitSize;
		if (q > size()) throw cybozu::Exception("Vint:testBit:large i") << q << size();
		Unit mask = Unit(1) << r;
		return (buf_[q] & mask) != 0;
	}
	void setBit(size_t i)
	{
		size_t q = i / unitBitSize;
		size_t r = i % unitBitSize;
		if (q > size()) throw cybozu::Exception("Vint:setBit:large i") << q << size();
		buf_.alloc(q + 1);
		Unit mask = Unit(1) << r;
		buf_[q] |= mask;
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
	bool isNegative() const { return !isZero() && isNeg_; }
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
		z.isNeg_ = x.isNeg_ ^ y.isNeg_;
		z.trim(zn);
	}
	static void sqr(VintT& y, const VintT& x)
	{
		mul(y, x, x);
	}
	static void add1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:add1:bad y");
		_add1(z, x, x.isNeg_, std::abs(y), y < 0);
	}
	static void sub1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:sub1:bad y");
		_add1(z, x, x.isNeg_, std::abs(y), !(y < 0));
	}
	static void mul1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:mul1:bad y");
		size_t xn = x.size();
		size_t zn = xn + 1;
		Unit absY = std::abs(y);
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = local::mul1(&z.buf_[0], &x.buf_[0], xn, absY);
		z.isNeg_ = x.isNeg_ ^ (y < 0);
		z.trim(zn);
	}
	/*
		@param q [out] q = x / y if q is not zero
		@param x [in]
		@param y [in] must be not zero
		return x % y
	*/
	static int divMod1(VintT *q, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:divMod1:bad y");
		bool xNeg = x.isNeg_;
		bool yNeg = y < 0;
		Unit absY = std::abs(y);
		size_t xn = x.size();
		int r;
		if (q) {
			q->isNeg_ = xNeg ^ yNeg;
			q->buf_.alloc(xn);
			r = local::div1(&q->buf_[0], &x.buf_[0], xn, absY);
			q->trim(xn);
		} else {
			r = local::mod1(&x.buf_[0], xn, absY);
		}
		return xNeg ? -r : r;
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
	static void div1(VintT& q, const VintT& x, int y)
	{
		divMod1(&q, x, y);
	}
	static void mod1(VintT& r, const VintT& x, int y)
	{
		bool xNeg = x.isNeg_;
		r = divMod1(0, x, y);
		r.isNeg_ = xNeg;
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
	// logical left shift (copy sign)
	static void shl(VintT& y, const VintT& x, size_t shiftBit)
	{
		size_t xn = x.size();
		size_t yn = xn + (shiftBit + unitBitSize - 1) / unitBitSize;
		y.buf_.alloc(yn);
		local::shlN(&y.buf_[0], &x.buf_[0], xn, shiftBit);
		y.isNeg_ = x.isNeg_;
		y.trim(yn);
	}
	// logical right shift (copy sign)
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
	static void neg(VintT& y, const VintT& x)
	{
		if (&y != &x) { y = x; }
		y.isNeg_ = !x.isNeg_;
	}
	static void abs(VintT& y, const VintT& x)
	{
		if (&y != &x) { y = x; }
		y.isNeg_ = false;
	}
	// accept only non-negative value
	static void orBit(VintT& z, const VintT& x, const VintT& y)
	{
		if (x.isNeg_ || y.isNeg_) throw cybozu::Exception("Vint:_or:negative value is not supported");
		const VintT *px = &x, *py = &y;
		if (x.size() < y.size()) {
			std::swap(px, py);
		}
		size_t xn = px->size();
		size_t yn = py->size();
		assert(xn >= yn);
		z.buf_.alloc(xn);
		for (size_t i = 0; i < yn; i++) {
			z.buf_[i] = x.buf_[i] | y.buf_[i];
		}
		local::copyN(&z.buf_[0] + yn, &px->buf_[0] + yn, xn - yn);
		z.trim(xn);
	}
	static void andBit(VintT& z, const VintT& x, const VintT& y)
	{
		if (x.isNeg_ || y.isNeg_) throw cybozu::Exception("Vint:_or:negative value is not supported");
		const VintT *px = &x, *py = &y;
		if (x.size() < y.size()) {
			std::swap(px, py);
		}
		size_t xn CYBOZU_UNUSED = px->size();
		size_t yn = py->size();
		assert(xn >= yn);
		z.buf_.alloc(yn);
		for (size_t i = 0; i < yn; i++) {
			z.buf_[i] = x.buf_[i] & y.buf_[i];
		}
		z.trim(yn);
	}
	static void pow(VintT& z, const VintT& x, const VintT& y)
	{
		if (y.isNeg_) throw cybozu::Exception("Vint::pow:negative y") << y;
		const VintT xx = x;
		z = 1;
		mcl::fp::powGeneric(z, x, &y.buf_[0], y.size(), mul, sqr, (void (*)(VintT&, const VintT&))0);
	}
	static void pow(VintT& z, const VintT& x, int y)
	{
		if (y < 0) throw cybozu::Exception("Vint::pow:negative y") << y;
		const VintT xx = x;
		Unit absY = std::abs(y);
		z = 1;
		mcl::fp::powGeneric(z, x, &absY, 1, mul, sqr, (void (*)(VintT&, const VintT&))0);
	}
	/*
		z = x ^ y mod m
	*/
	static void powMod(VintT& z, const VintT& x, const VintT& y, const VintT& m)
	{
		if (y.isNeg_) throw cybozu::Exception("Vint::pow:negative y") << y;
		VintT zz = 1;
		MulMod mulMod;
		SqrMod sqrMod;
		mulMod.pm = &m;
		sqrMod.pm = &m;
		zz = 1;
		mcl::fp::powGeneric(zz, x, &y.buf_[0], y.size(), mulMod, sqrMod, (void (*)(VintT&, const VintT&))0);
		z.swap(zz);
	}
	VintT& operator++() { add(*this, *this, 1); return *this; }
	VintT& operator--() { sub(*this, *this, 1); return *this; }
	VintT operator++(int) { VintT c = *this; add(*this, *this, 1); return c; }
	VintT operator--(int) { VintT c = *this; sub(*this, *this, 1); return c; }
	const Unit *getUnit() const { return &buf_[0]; }
	friend bool operator<(const VintT& x, const VintT& y) { return compare(x, y) < 0; }
	friend bool operator>=(const VintT& x, const VintT& y) { return !operator<(x, y); }
	friend bool operator>(const VintT& x, const VintT& y) { return compare(x, y) > 0; }
	friend bool operator<=(const VintT& x, const VintT& y) { return !operator>(x, y); }
	friend bool operator==(const VintT& x, const VintT& y) { return compare(x, y) == 0; }
	friend bool operator!=(const VintT& x, const VintT& y) { return !operator==(x, y); }
	VintT& operator+=(const VintT& rhs) { add(*this, *this, rhs); return *this; }
	VintT& operator-=(const VintT& rhs) { sub(*this, *this, rhs); return *this; }
	VintT& operator*=(const VintT& rhs) { mul(*this, *this, rhs); return *this; }
	VintT& operator/=(const VintT& rhs) { div(*this, *this, rhs); return *this; }
	VintT& operator%=(const VintT& rhs) { mod(*this, *this, rhs); return *this; }
	VintT& operator&=(const VintT& rhs) { andBit(*this, *this, rhs); return *this; }
	VintT& operator|=(const VintT& rhs) { orBit(*this, *this, rhs); return *this; }
	VintT& operator+=(int rhs) { add1(*this, *this, rhs); return *this; }
	VintT& operator-=(int rhs) { sub1(*this, *this, rhs); return *this; }
	VintT& operator*=(int rhs) { mul1(*this, *this, rhs); return *this; }
	VintT& operator/=(int rhs) { div1(*this, *this, rhs); return *this; }
	VintT& operator%=(int rhs) { mod1(*this, *this, rhs); return *this; }
	friend VintT operator+(const VintT& a, const VintT& b) { VintT c; add(c, a, b); return c; }
	friend VintT operator-(const VintT& a, const VintT& b) { VintT c; sub(c, a, b); return c; }
	friend VintT operator*(const VintT& a, const VintT& b) { VintT c; mul(c, a, b); return c; }
	friend VintT operator/(const VintT& a, const VintT& b) { VintT c; div(c, a, b); return c; }
	friend VintT operator%(const VintT& a, const VintT& b) { VintT c; mod(c, a, b); return c; }
	friend VintT operator&(const VintT& a, const VintT& b) { VintT c; andBit(c, a, b); return c; }
	friend VintT operator|(const VintT& a, const VintT& b) { VintT c; orBit(c, a, b); return c; }
	VintT operator-() const { VintT c; neg(c, *this); return c; }
	VintT& operator<<=(size_t n) { shl(*this, *this, n); return *this; }
	VintT& operator>>=(size_t n) { shr(*this, *this, n); return *this; }
	VintT operator<<(size_t n) const { VintT c = *this; c <<= n; return c; }
	VintT operator>>(size_t n) const { VintT c = *this; c >>= n; return c; }
};

//typedef VintT<local::VariableBuffer<mcl::local::Unit> > Vint;
//typedef VintT<local::FixedBuffer<mcl::local::Unit, 10> > Vint;
typedef VintT<local::Buffer<mcl::local::Unit> > Vint;

} // mcl

//typedef mcl::Vint mpz_class;
