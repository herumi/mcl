#pragma once
/**
	emulate mpz_class
*/
#include <cybozu/exception.hpp>
#include <cybozu/bit_operation.hpp>
#include <cybozu/atoi.hpp>
#include <cybozu/xorshift.hpp>
#include <vector>
#include <iomanip>
#include <stdlib.h>
#include <assert.h>
#include <cmath>
#include <iostream>
#include <mcl/util.hpp>

#ifndef MCL_SIZEOF_UNIT
	#if defined(CYBOZU_OS_BIT) && (CYBOZU_OS_BIT == 32)
		#define MCL_SIZEOF_UNIT 4
	#else
		#define MCL_SIZEOF_UNIT 8
	#endif
#endif

namespace mcl {

namespace vint {

#if MCL_SIZEOF_UNIT == 8
typedef uint64_t Unit;
#else
typedef uint32_t Unit;
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
	[H:L] <= x * y
	@return L
*/
inline uint32_t mulUnit(uint32_t *pH, uint32_t x, uint32_t y)
{
	uint64_t t = uint64_t(x) * y;
	uint32_t L;
	split64(pH, &L, t);
	return L;
}
#if MCL_SIZEOF_UNIT == 8
inline uint64_t mulUnit(uint64_t *pH, uint64_t x, uint64_t y)
{
#ifdef MCL_VINT_64BIT_PORTABLE
	uint32_t a = uint32_t(x >> 32);
	uint32_t b = uint32_t(x);
	uint32_t c = uint32_t(y >> 32);
	uint32_t d = uint32_t(y);

	uint64_t ad = uint64_t(d) * a;
	uint64_t bd = uint64_t(d) * b;
	uint64_t L = uint32_t(bd);
	ad += bd >> 32; // [ad:L]

	uint64_t ac = uint64_t(c) * a;
	uint64_t bc = uint64_t(c) * b;
	uint64_t H = uint32_t(bc);
	ac += bc >> 32; // [ac:H]
	/*
		  adL
		 acH
	*/
	uint64_t t = (ac << 32) | H;
	ac >>= 32;
	H = t + ad;
	if (H < t) {
		ac++;
	}
	/*
		ac:H:L
	*/
	L |= H << 32;
	H = (ac << 32) | uint32_t(H >> 32);
	*pH = H;
	return L;
#elif defined(_WIN64) && !defined(__INTEL_COMPILER)
	return _umul128(x, y, pH);
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = uint128(x) * y;
	*pH = uint64_t(t >> 64);
	return uint64_t(t);
#endif
}
#endif

template<class T>
size_t getRealSize(const T *x, size_t xn)
{
	int i = (int)xn - 1;
	for (; i > 0; i--) {
		if (x[i]) {
			return i + 1;
		}
	}
	return 1;
}

template<class T>
void divNM(T *q, size_t qn, T *r, const T *x, size_t xn, const T *y, size_t yn);

/*
	q = [H:L] / y
	r = [H:L] % y
	return q
*/
inline uint32_t divUnit(uint32_t *pr, uint32_t H, uint32_t L, uint32_t y)
{
	uint64_t t = make64(H, L);
	uint32_t q = uint32_t(t / y);
	*pr = uint32_t(t % y);
	return q;
}
#if MCL_SIZEOF_UNIT == 8
inline uint64_t divUnit(uint64_t *pr, uint64_t H, uint64_t L, uint64_t y)
{
#if defined(MCL_VINT_64BIT_PORTABLE)
	uint32_t px[4] = { uint32_t(L), uint32_t(L >> 32), uint32_t(H), uint32_t(H >> 32) };
	uint32_t py[2] = { uint32_t(y), uint32_t(y >> 32) };
#if 1
	size_t xn = 4;
	size_t yn = 2;
	uint32_t q[4];
	uint32_t r[2];
	size_t qn = xn - yn + 1;
	divNM(q, qn, r, px, xn, py, yn);
	*pr = make64(r[1], r[0]);
	return make64(q[1], q[0]);
#else
	size_t xn = getRealSize(px, 4);
	size_t yn = getRealSize(py, 2);
	if (yn > xn) {
		*pr = L;
		return 0;
	}
	if (xn == yn) {
		*pr = L % y;
		return L / y;
	}
	assert(xn > yn);
	uint32_t q[4];
	uint32_t r[2];
	size_t qn = xn - yn + 1;
	divNM(q, qn, r, px, xn, py, yn);
	*pr = (yn == 1) ? r[0] : make64(r[1], r[0]);
	return (qn == 1) ? q[0] : make64(q[1], q[0]);
#endif
#elif defined(_MSC_VER)
	#error "divUnit for uint64_t is not supported"
#else
	typedef __attribute__((mode(TI))) unsigned int uint128;
	uint128 t = (uint128(H) << 64) | L;
	uint64_t q = uint64_t(t / y);
	*pr = uint64_t(t % y);
	return q;
#endif
}
#endif

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
	const typename T::Unit d = (uint32_t)std::pow(10.0, 9);
	size_t size = s.size();
	size_t q = size / width;
	size_t r = size % width;
	const char *p = s.c_str();
	/*
		split s and compute x
		eg. 123456789012345678901234 => 123456, 789012345, 678901234
	*/
	typename T::Unit v;
	x = 0;
	if (r) {
		v = cybozu::atoi(p, r);
		p += r;
		x = v;
	}
	while (q) {
		v = cybozu::atoi(p, width);
		p += width;
		x *= d;
		x += v;
		q--;
	}
}

inline uint32_t bin2uint32(const char *s, size_t n)
{
	uint32_t x = 0;
	for (size_t i = 0; i < n; i++) {
		x <<= 1;
		char c = s[i];
		if (c != '0' && c != '1') throw cybozu::Exception("bin2uint32:bad char") << std::string(s, n);
		if (c == '1') {
			x |= 1;
		}
	}
	return x;
}

template<class T>
inline void binStr2Int(T& x, const std::string& s)
{
	const size_t width = 32;
	size_t size = s.size();
	size_t q = size / width;
	size_t r = size % width;

	const char *p = s.c_str();
	uint32_t v;
	x = 0;
	if (r) {
		v = bin2uint32(p, r);
		p += r;
		T::addu1(x, x, v);
	}
	while (q) {
		v = bin2uint32(p, width);
		p += width;
		x <<= width;
		T::addu1(x, x, v);
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
T addu1(T *z, const T *x, size_t n, T y)
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
	T c = vint::addN(z, x, y, min);
	if (max > min) {
		c = vint::addu1(z + min, x + min, max - min, c);
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
T subu1(T *z, const T *x, size_t n, T y)
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
T mulu1(T *z, const T *x, size_t n, T y)
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
	z[xn * yn] = x[xn] * y[ym]
*/
template<class T>
static inline void mulNM(T *z, const T *x, size_t xn, const T *y, size_t yn)
{
	assert(xn > 0 && yn > 0);
	if (yn > xn) {
		std::swap(yn, xn);
		std::swap(x, y);
	}
	assert(xn >= yn);
	if (z == x) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * xn);
		copyN(p, x, xn);
		x = p;
	}
	if (z == y) {
		T *p = (T*)CYBOZU_ALLOCA(sizeof(T) * yn);
		copyN(p, y, yn);
		y = p;
	}
	z[xn] = vint::mulu1(&z[0], x, xn, y[0]);
	clearN(z + xn + 1, yn - 1);

	T *t2 = (T*)CYBOZU_ALLOCA(sizeof(T) * (xn + 1));
	for (size_t i = 1; i < yn; i++) {
		t2[xn] = vint::mulu1(&t2[0], x, xn, y[i]);
		vint::addN(&z[i], &z[i], &t2[0], xn + 1);
	}
}
/*
	out[xn * 2] = x[xn] * x[xn]
	QQQ : optimize this
*/
template<class T>
static inline void sqrN(T *y, const T *x, size_t xn)
{
	mulNM(y, x, xn, x, xn);
}

/*
	q[] = x[] / y
	@retval r = x[] % y
	accept q == x
*/
template<class T>
T divu1(T *q, const T *x, size_t n, T y)
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
T modu1(const T *x, size_t n, T y)
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
static inline double getApprox(const T *x, size_t xn, bool up)
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
#if MCL_SIZEOF_UNIT == 4
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
	q[qn] = x[xn] / y[yn] ; qn == xn - yn + 1 if xn >= yn if q
	r[rn] = x[xn] % y[yn] ; rn = yn before getRealSiz
*/
template<class T>
void divNM(T *q, size_t qn, T *r, const T *x, size_t xn, const T *y, size_t yn)
{
	assert(xn > 0 && yn > 0);
	assert(xn < yn || (q == 0 || qn == xn - yn + 1));
	assert(q != r);
	const size_t rn = yn;
	xn = getRealSize(x, xn);
	yn = getRealSize(y, yn);
	if (yn > xn) {
		/*
			if y > x then q = 0 and r = x
		*/
		copyN(r, x, xn);
		clearN(r + xn, rn - xn);
		if (q) clearN(q, qn);
		return;
	}
	if (yn == 1) {
		T t;
		if (q) {
			if (qn > xn) {
				clearN(q + xn, qn - xn);
			}
			t = divu1(q, x, xn, y[0]);
		} else {
			t = modu1(x, xn, y[0]);
		}
		r[0] = t;
		clearN(r + 1, rn - 1);
		return;
	}
	assert(yn >= 2);
	if (x == y) {
		assert(xn == yn);
		clearN(r, rn);
		if (q) {
			q[0] = 1;
			clearN(q + 1, qn - 1);
		}
		return;
	}
	T *qq = q;
	if (q) {
		if (q == x || q == y) {
			qq = (T*)CYBOZU_ALLOCA(sizeof(T) * qn);
		}
		clearN(qq, qn);
	}
	T *rr = (T*)CYBOZU_ALLOCA(sizeof(T) * xn);
	copyN(rr, x, xn);
	T *t = (T*)CYBOZU_ALLOCA(sizeof(T) * (yn + 1));
	double yt = getApprox(y, yn, true);
	while (vint::compareNM(rr, xn, y, yn) >= 0) {
		size_t len = yn;
		double xt = getApprox(rr, xn, false);
		if (vint::compareNM(&rr[xn - len], yn, y, yn) < 0) {
			xt *= double(1ULL << (sizeof(T) * 8 - 1)) * 2;
			len++;
		}
		T qt = T(xt / yt);
		if (qt == 0) qt = 1;
		t[yn] = vint::mulu1(&t[0], y, yn, qt);
		T b = vint::subN(&rr[xn - len], &rr[xn - len], &t[0], len);
		if (b) {
			assert(!b);
		}
		if (qq) qq[xn - len] += qt;

		while (xn >= yn && rr[xn - 1] == 0) {
			xn--;
		}
	}
	copyN(r, rr, rn);
	if (q && q != qq) {
		copyN(q, qq, qn);
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

} // vint

/**
	signed integer with variable length
*/
template<class _Buffer>
class VintT {
public:
	typedef _Buffer Buffer;
	typedef typename Buffer::Unit Unit;
	static const size_t unitBitSize = sizeof(Unit) * 8;
	static const int invalidVar = -2147483647 - 1; // abs(invalidVar) is not defined
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
		return vint::compareNM(&x[0], xn, &y[0], yn);
	}
	static void uadd(VintT& z, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		size_t zn = std::max(xn, yn) + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = vint::addNM(&z.buf_[0], &x[0], xn, &y[0], yn);
		z.trim(zn);
	}
	static void uadd1(VintT& z, const Buffer& x, size_t xn, Unit y)
	{
		size_t zn = xn + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = vint::addu1(&z.buf_[0], &x[0], xn, y);
		z.trim(zn);
	}
	static void usub1(VintT& z, const Buffer& x, size_t xn, Unit y)
	{
		size_t zn = xn;
		z.buf_.alloc(zn);
		Unit c = vint::subu1(&z.buf_[0], &x[0], xn, y);
		(void)c;
		assert(!c);
		z.trim(zn);
	}
	static void usub(VintT& z, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		assert(xn >= yn);
		z.buf_.alloc(xn);
		Unit c = vint::subN(&z.buf_[0], &x[0], &y[0], yn);
		if (xn > yn) {
			c = vint::subu1(&z.buf_[yn], &x[yn], xn - yn, c);
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
	static void _adds1(VintT& z, const VintT& x, bool xNeg, int y, bool yNeg)
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
	static void _addu1(VintT& z, const VintT& x, bool xNeg, Unit y)
	{
		if (!xNeg) {
			// same sign
			uadd1(z, x.buf_, x.size(), y);
			z.isNeg_ = xNeg;
			return;
		}
		if (x.size() > 1 || x.buf_[0] >= y) {
			usub1(z, x.buf_, x.size(), y);
			z.isNeg_ = xNeg;
		} else {
			z = y - x.buf_[0];
			z.isNeg_ = false;
		}
	}
	/**
		@param q [out] x / y if q != 0
		@param r [out] x % y
	*/
	static void udiv(VintT* q, VintT& r, const Buffer& x, size_t xn, const Buffer& y, size_t yn)
	{
		assert(q != &r);
		if (xn < yn) {
			r.buf_ = x;
			r.trim(xn);
			if (q) q->clear();
			return;
		}
		size_t qn = xn - yn + 1;
		if (q) {
			q->buf_.alloc(qn);
		}
		r.buf_.alloc(yn);
		vint::divNM(q ? &q->buf_[0] : 0, qn, &r.buf_[0], &x[0], xn, &y[0], yn);
		if (q) {
			q->trim(qn);
		}
		r.trim(yn);
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
	VintT(Unit x)
		: size_(0)
	{
		*this = x;
	}
	explicit VintT(const std::string& str)
		: size_(0)
	{
		setStr(str);
	}
	VintT(const VintT& rhs)
		: buf_(rhs.buf_)
		, size_(rhs.size_)
		, isNeg_(rhs.isNeg_)
	{
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
	VintT& operator=(Unit x)
	{
		isNeg_ = false;
		buf_.alloc(1);
		buf_[0] = x;
		size_ = 1;
		return *this;
	}
	VintT& operator=(const VintT& rhs)
	{
		buf_ = rhs.buf_;
		size_ = rhs.size_;
		isNeg_ = rhs.isNeg_;
		return *this;
	}
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
	VintT(VintT&& rhs)
		: buf_(rhs.buf_)
		, size_(rhs.size_)
		, isNeg_(rhs.isNeg_)
	{
	}
	VintT& operator=(VintT&& rhs)
	{
		buf_ = std::move(rhs.buf_);
		size_ = rhs.size_;
		isNeg_ = rhs.isNeg_;
		return *this;
	}
#endif
	void swap(VintT& rhs)
#if CYBOZU_CPP_VERSION >= CYBOZU_CPP_VERSION_CPP11
		noexcept
#endif
	{
		std::swap(buf_, rhs.buf_);
		std::swap(size_, rhs.size_);
		std::swap(isNeg_, rhs.isNeg_);
	}
	void dump() const
	{
		printf("size_=%d ", (int)size_);
		for (size_t i = 0; i < size_; i++) {
#if MCL_SIZEOF_UNIT == 4
			printf("%08x", (uint32_t)buf_[size_ - 1 - i]);
#else
			printf("%016llx", (unsigned long long)buf_[size_ - 1 - i]);
#endif
		}
		printf("\n");
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
		set [0, max) randomly
	*/
	template<class RG>
	void setRand(const VintT& max, RG& rg)
	{
		if (max <= 0) throw cybozu::Exception("Vint:setRand:bad value") << max;
		size_t n = max.size();
		buf_.alloc(n);
		uint32_t *p = (uint32_t*)&buf_[0];
		for (size_t i = 0; i < n * sizeof(Unit) / sizeof(uint32_t); i++) {
			p[i] = (uint32_t)rg();
		}
		trim(n);
		*this %= max;
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
		vint::copyN(x, &buf_[0], n);
		vint::clearN(x + n, maxSize - n);
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
					uint32_t r = udivModu1(&x, x, i1e9);
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
				os << std::hex;
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
		return bitSize(abs(*this))
		@note return 1 if zero
	*/
	size_t getBitSize() const
	{
		if (isZero()) return 1;
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
	void setBit(size_t i, bool v = true)
	{
		size_t q = i / unitBitSize;
		size_t r = i % unitBitSize;
		if (q > size()) throw cybozu::Exception("Vint:setBit:large i") << q << size();
		buf_.alloc(q + 1);
		Unit mask = Unit(1) << r;
		if (v) {
			buf_[q] |= mask;
		} else {
			buf_[q] &= ~mask;
			trim(q + 1);
		}
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
		if (str.size() >= 2 && str[0] == '0' && str[1] == 'x') {
			if (base != 0 && base != 16) throw cybozu::Exception("Vint:setStr bad base 0x)") << str << base;
			base = 16;
			str = str.substr(2);
		} else if (str.size() >= 2 && str[0] == '0' && str[1] == 'x') {
			if (base != 0 && base != 2) throw cybozu::Exception("Vint:setStr bad base 0b") << str << base;
			base = 2;
			str = str.substr(2);
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
		case 2:
			binStr2Int(*this, str);
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
		throw cybozu::Exception("VintT:setStr") << str << base;
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
	static int compares1(const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:compares1:bad y");
		if (x.isNeg_ ^ (y < 0)) {
			if (x.isZero() && y == 0) return 0;
			return x.isNeg_ ? -1 : 1;
		} else {
			// same sign
			Unit y0 = std::abs(y);
			int c = vint::compareNM(&x.buf_[0], x.size(), &y0, 1);
			if (x.isNeg_) {
				return -c;
			}
			return c;
		}
	}
	size_t size() const { return size_; }
	bool isZero() const { return size() == 1 && buf_[0] == 0; }
	bool isNegative() const { return !isZero() && isNeg_; }
	uint32_t getLow32bit() const { return (uint32_t)buf_[0]; }
	bool isOdd() const { return (buf_[0] & 1) == 1; }
	bool isEven() const { return !isOdd(); }
	const Unit *getUnit() const { return &buf_[0]; }
	size_t getUnitSize() const { return size_; }
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
		vint::mulNM(&z.buf_[0], &x.buf_[0], xn, &y.buf_[0], yn);
		z.isNeg_ = x.isNeg_ ^ y.isNeg_;
		z.trim(zn);
	}
	static void sqr(VintT& y, const VintT& x)
	{
		mul(y, x, x);
	}
	static void addu1(VintT& z, const VintT& x, Unit y)
	{
		_addu1(z, x, x.isNeg_, y);
	}
	static void subu1(VintT& z, const VintT& x, Unit y)
	{
		_addu1(z, x, x.isNeg_, y);
	}
	static void mulu1(VintT& z, const VintT& x, Unit y)
	{
		size_t xn = x.size();
		size_t zn = xn + 1;
		z.buf_.alloc(zn);
		z.buf_[zn - 1] = vint::mulu1(&z.buf_[0], &x.buf_[0], xn, y);
		z.isNeg_ = x.isNeg_;
		z.trim(zn);
	}
	static void divu1(VintT& q, const VintT& x, Unit y)
	{
		udivModu1(&q, x, y);
	}
	static void modu1(VintT& r, const VintT& x, Unit y)
	{
		bool xNeg = x.isNeg_;
		r = divModu1(0, x, y);
		r.isNeg_ = xNeg;
	}
	static void adds1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:adds1:bad y");
		_adds1(z, x, x.isNeg_, std::abs(y), y < 0);
	}
	static void subs1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:subs1:bad y");
		_adds1(z, x, x.isNeg_, std::abs(y), !(y < 0));
	}
	static void muls1(VintT& z, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:muls1:bad y");
		mulu1(z, x, std::abs(y));
		z.isNeg_ ^= (y < 0);
	}
	/*
		@param q [out] q = x / y if q is not zero
		@param x [in]
		@param y [in] must be not zero
		return x % y
	*/
	static int divMods1(VintT *q, const VintT& x, int y)
	{
		if (y == invalidVar) throw cybozu::Exception("VintT:divMods1:bad y");
		bool xNeg = x.isNeg_;
		bool yNeg = y < 0;
		Unit absY = std::abs(y);
		size_t xn = x.size();
		int r;
		if (q) {
			q->isNeg_ = xNeg ^ yNeg;
			q->buf_.alloc(xn);
			r = vint::divu1(&q->buf_[0], &x.buf_[0], xn, absY);
			q->trim(xn);
		} else {
			r = vint::modu1(&x.buf_[0], xn, absY);
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
	static void divs1(VintT& q, const VintT& x, int y)
	{
		divMods1(&q, x, y);
	}
	static void mods1(VintT& r, const VintT& x, int y)
	{
		bool xNeg = x.isNeg_;
		r = divMods1(0, x, y);
		r.isNeg_ = xNeg;
	}
	static Unit udivModu1(VintT *q, const VintT& x, Unit y)
	{
		if (x.isNeg_) throw cybozu::Exception("VintT:udivu1:x is not negative") << x;
		size_t xn = x.size();
		if (q) q->buf_.alloc(xn);
		Unit r = vint::divu1(q ? &q->buf_[0] : 0, &x.buf_[0], xn, y);
		if (q) {
			q->trim(xn);
			q->isNeg_ = false;
		}
		return r;
	}
	/*
		like Python
		 13 /  5 =  2 ...  3
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
		vint::getDigits(is, str, true);
		x.setStr(str);
		return is;
	}
	// logical left shift (copy sign)
	static void shl(VintT& y, const VintT& x, size_t shiftBit)
	{
		size_t xn = x.size();
		size_t yn = xn + (shiftBit + unitBitSize - 1) / unitBitSize;
		y.buf_.alloc(yn);
		vint::shlN(&y.buf_[0], &x.buf_[0], xn, shiftBit);
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
		vint::shrN(&y.buf_[0], &x.buf_[0], xn, shiftBit);
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
	static VintT abs(const VintT& x)
	{
		VintT y = x;
		abs(y, x);
		return y;
	}
	// accept only non-negative value
	static void orBit(VintT& z, const VintT& x, const VintT& y)
	{
		if (x.isNeg_ || y.isNeg_) throw cybozu::Exception("Vint:orBit:negative value is not supported");
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
		vint::copyN(&z.buf_[0] + yn, &px->buf_[0] + yn, xn - yn);
		z.trim(xn);
	}
	static void andBit(VintT& z, const VintT& x, const VintT& y)
	{
		if (x.isNeg_ || y.isNeg_) throw cybozu::Exception("Vint:andBit:negative value is not supported");
		const VintT *px = &x, *py = &y;
		if (x.size() < y.size()) {
			std::swap(px, py);
		}
		size_t yn = py->size();
		assert(px->size() >= yn);
		z.buf_.alloc(yn);
		for (size_t i = 0; i < yn; i++) {
			z.buf_[i] = x.buf_[i] & y.buf_[i];
		}
		z.trim(yn);
	}
	static void orBitu1(VintT& z, const VintT& x, Unit y)
	{
		if (x.isNeg_) throw cybozu::Exception("Vint:orBit:negative value is not supported");
		z = x;
		z.buf_[0] |= y;
	}
	static void andBitu1(VintT& z, const VintT& x, Unit y)
	{
		if (x.isNeg_) throw cybozu::Exception("Vint:andBit:negative value is not supported");
		z.buf_.alloc(1);
		z.buf_[0] = x.buf_[0] & y;
		z.size_ = 1;
		z.isNeg_ = false;
	}
	static void pow(VintT& z, const VintT& x, const VintT& y)
	{
		if (y.isNeg_) throw cybozu::Exception("Vint::pow:negative y") << y;
		const VintT xx = x;
		z = 1;
		mcl::fp::powGeneric(z, xx, &y.buf_[0], y.size(), mul, sqr, (void (*)(VintT&, const VintT&))0);
	}
	static void pow(VintT& z, const VintT& x, int y)
	{
		if (y < 0) throw cybozu::Exception("Vint::pow:negative y") << y;
		const VintT xx = x;
		Unit absY = std::abs(y);
		z = 1;
		mcl::fp::powGeneric(z, xx, &absY, 1, mul, sqr, (void (*)(VintT&, const VintT&))0);
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
	/*
		inverse mod
		y = 1/x mod m
	*/
	static void invMod(VintT& y, const VintT& x, const VintT& m)
	{
		if (x == 1) {
			y = 1;
			return;
		}
		VintT a = 1;
		VintT t;
		VintT q;
		divMod(&q, t, m, x);
		if (t.isZero()) throw cybozu::Exception("VintT:invMod:bad m") << m;
		VintT s = x;
		VintT b = -q;

		for (;;) {
			divMod(&q, s, s, t);
			if (s.isZero()) {
				if (b.isNeg_) {
					b += m;
				}
				y = b;
				return;
			}
			a -= b * q;

			divMod(&q, t, t, s);
			if (t.isZero()) {
				if (a.isNeg_) {
					a += m;
				}
				y = a;
				return;
			}
			b -= a * q;
		}
	}
private:
	/*
		@param x [inout] x <- d
		@retval s for x = 2^s d where d is odd
	*/
	static uint32_t countTrailingZero(VintT& x)
	{
		uint32_t s = 0;
		while (x.isEven()) {
			x >>= 1;
			s++;
		}
		return s;
	}
public:
	/*
		Miller-Rabin
	*/
	template<class RG>
	static bool isPrime(const VintT& n, RG& rg, int tryNum = 32)
	{
		if (n <= 1) return false;
		if (n == 2 || n == 3) return true;
		if (n.isEven()) return false;
		const VintT nm1 = n - 1;
		VintT d = nm1;
		uint32_t r = countTrailingZero(d);
		// n - 1 = 2^r d
		VintT a, x;
		for (int i = 0; i < tryNum; i++) {
			a.setRand(n - 3, rg);
			a += 2; // a in [2, n - 2]
			powMod(x, a, d, n);
			if (x == 1 || x == nm1) {
				continue;
			}
			for (uint32_t j = 1; j < r; j++) {
				sqr(x, x);
				x %= n;
				if (x == 1) return false;
				if (x == nm1) goto NEXT_LOOP;
			}
			return false;
		NEXT_LOOP:;
		}
		return true;
	}
	template<class RG>
	bool isPrime(RG& rg, int tryNum = 32) const
	{
		return isPrime(*this, rg, tryNum);
	}
	bool isPrime(int tryNum = 32) const
	{
		cybozu::XorShift rg;
		return isPrime(rg, tryNum);
	}
	static void gcd(VintT& z, VintT x, VintT y)
	{
		VintT t;
		for (;;) {
			if (y.isZero()) {
				z = x;
				return;
			}
			t = x;
			x = y;
			mod(y, t, y);
		}
	}
	static VintT gcd(const VintT& x, const VintT& y)
	{
		VintT z;
		gcd(z, x, y);
		return z;
	}
	static void lcm(VintT& z, const VintT& x, const VintT& y)
	{
		VintT c;
		gcd(c, x, y);
		div(c, x, c);
		mul(z, c, y);
	}
	static VintT lcm(const VintT& x, const VintT& y)
	{
		VintT z;
		lcm(z, x, y);
		return z;
	}
	/*
		 1 if m is quadratic residue modulo n (i.e., there exists an x s.t. x^2 = m mod n)
		 0 if m = 0 mod n
		-1 otherwise
		@note return legendre_symbol(m, p) for m and odd prime p
	*/
	static int jacobi(VintT m, VintT n)
	{
		if (n.isEven()) throw cybozu::Exception();
		if (n == 1) return 1;
		if (m < 0 || m > n) {
			quotRem(0, m, m, n); // m = m mod n
		}
		if (m.isZero()) return 0;
		if (m == 1) return 1;
		if (gcd(m, n) != 1) return 0;

		int j = 1;
		VintT t;
		goto START;
		while (m != 1) {
			if ((m.getLow32bit() % 4) == 3 && (n.getLow32bit() % 4) == 3) {
				j = -j;
			}
			mod(t, n, m);
			n = m;
			m = t;
		START:
			int s = countTrailingZero(m);
			uint32_t nmod8 = n.getLow32bit() % 8;
			if ((s % 2) && (nmod8 == 3 || nmod8 == 5)) {
				j = -j;
			}
		}
		return j;
	}
	VintT& operator++() { add(*this, *this, 1); return *this; }
	VintT& operator--() { sub(*this, *this, 1); return *this; }
	VintT operator++(int) { VintT c = *this; add(*this, *this, 1); return c; }
	VintT operator--(int) { VintT c = *this; sub(*this, *this, 1); return c; }
	friend bool operator<(const VintT& x, const VintT& y) { return compare(x, y) < 0; }
	friend bool operator>=(const VintT& x, const VintT& y) { return !operator<(x, y); }
	friend bool operator>(const VintT& x, const VintT& y) { return compare(x, y) > 0; }
	friend bool operator<=(const VintT& x, const VintT& y) { return !operator>(x, y); }
	friend bool operator==(const VintT& x, const VintT& y) { return compare(x, y) == 0; }
	friend bool operator!=(const VintT& x, const VintT& y) { return !operator==(x, y); }

	friend bool operator<(const VintT& x, int y) { return compares1(x, y) < 0; }
	friend bool operator>=(const VintT& x, int y) { return !operator<(x, y); }
	friend bool operator>(const VintT& x, int y) { return compares1(x, y) > 0; }
	friend bool operator<=(const VintT& x, int y) { return !operator>(x, y); }
	friend bool operator==(const VintT& x, int y) { return compares1(x, y) == 0; }
	friend bool operator!=(const VintT& x, int y) { return !operator==(x, y); }

	VintT& operator+=(const VintT& rhs) { add(*this, *this, rhs); return *this; }
	VintT& operator-=(const VintT& rhs) { sub(*this, *this, rhs); return *this; }
	VintT& operator*=(const VintT& rhs) { mul(*this, *this, rhs); return *this; }
	VintT& operator/=(const VintT& rhs) { div(*this, *this, rhs); return *this; }
	VintT& operator%=(const VintT& rhs) { mod(*this, *this, rhs); return *this; }
	VintT& operator&=(const VintT& rhs) { andBit(*this, *this, rhs); return *this; }
	VintT& operator|=(const VintT& rhs) { orBit(*this, *this, rhs); return *this; }

	VintT& operator+=(int rhs) { adds1(*this, *this, rhs); return *this; }
	VintT& operator-=(int rhs) { subs1(*this, *this, rhs); return *this; }
	VintT& operator*=(int rhs) { muls1(*this, *this, rhs); return *this; }
	VintT& operator/=(int rhs) { divs1(*this, *this, rhs); return *this; }
	VintT& operator%=(int rhs) { mods1(*this, *this, rhs); return *this; }
	VintT& operator+=(Unit rhs) { addu1(*this, *this, rhs); return *this; }
	VintT& operator-=(Unit rhs) { subu1(*this, *this, rhs); return *this; }
	VintT& operator*=(Unit rhs) { mulu1(*this, *this, rhs); return *this; }
	VintT& operator/=(Unit rhs) { divu1(*this, *this, rhs); return *this; }
	VintT& operator%=(Unit rhs) { modu1(*this, *this, rhs); return *this; }

	VintT& operator&=(Unit rhs) { andBitu1(*this, *this, rhs); return *this; }
	VintT& operator|=(Unit rhs) { orBitu1(*this, *this, rhs); return *this; }

	friend VintT operator+(const VintT& a, const VintT& b) { VintT c; add(c, a, b); return c; }
	friend VintT operator-(const VintT& a, const VintT& b) { VintT c; sub(c, a, b); return c; }
	friend VintT operator*(const VintT& a, const VintT& b) { VintT c; mul(c, a, b); return c; }
	friend VintT operator/(const VintT& a, const VintT& b) { VintT c; div(c, a, b); return c; }
	friend VintT operator%(const VintT& a, const VintT& b) { VintT c; mod(c, a, b); return c; }
	friend VintT operator&(const VintT& a, const VintT& b) { VintT c; andBit(c, a, b); return c; }
	friend VintT operator|(const VintT& a, const VintT& b) { VintT c; orBit(c, a, b); return c; }

	friend VintT operator+(const VintT& a, int b) { VintT c; adds1(c, a, b); return c; }
	friend VintT operator-(const VintT& a, int b) { VintT c; subs1(c, a, b); return c; }
	friend VintT operator*(const VintT& a, int b) { VintT c; muls1(c, a, b); return c; }
	friend VintT operator/(const VintT& a, int b) { VintT c; divs1(c, a, b); return c; }
	friend VintT operator%(const VintT& a, int b) { VintT c; mods1(c, a, b); return c; }
	friend VintT operator+(const VintT& a, Unit b) { VintT c; addu1(c, a, b); return c; }
	friend VintT operator-(const VintT& a, Unit b) { VintT c; subu1(c, a, b); return c; }
	friend VintT operator*(const VintT& a, Unit b) { VintT c; mulu1(c, a, b); return c; }
	friend VintT operator/(const VintT& a, Unit b) { VintT c; divu1(c, a, b); return c; }
	friend VintT operator%(const VintT& a, Unit b) { VintT c; modu1(c, a, b); return c; }

	friend VintT operator&(const VintT& a, Unit b) { VintT c; andBitu1(c, a, b); return c; }
	friend VintT operator|(const VintT& a, Unit b) { VintT c; orBitu1(c, a, b); return c; }

	VintT operator-() const { VintT c; neg(c, *this); return c; }
	VintT& operator<<=(size_t n) { shl(*this, *this, n); return *this; }
	VintT& operator>>=(size_t n) { shr(*this, *this, n); return *this; }
	VintT operator<<(size_t n) const { VintT c = *this; c <<= n; return c; }
	VintT operator>>(size_t n) const { VintT c = *this; c >>= n; return c; }
};

//typedef VintT<vint::VariableBuffer<mcl::vint::Unit> > Vint;
#ifdef MCL_VINT_FIXED_BUFFER
typedef VintT<vint::FixedBuffer<mcl::vint::Unit, MCL_MAX_BIT_SIZE * 2> > Vint;
#else
typedef VintT<vint::Buffer<mcl::vint::Unit> > Vint;
#endif

} // mcl

//typedef mcl::Vint mpz_class;
