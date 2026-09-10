// Minimal memset/memcpy/memmove for wasm32 (no libc)
#include <stddef.h>

// sbrk implementation using wasm memory.grow
extern unsigned char __heap_base;
static unsigned char *brk = &__heap_base;

void *sbrk(long incr) {
  unsigned char *old = brk;
  if (incr > 0) {
    // Each wasm page is 64KB
    size_t current_size = (size_t)__builtin_wasm_memory_size(0) * 65536; // lgtm[cpp/implicit-function-declaration]
    size_t needed = (size_t)(brk + incr);
    if (needed > current_size) {
      size_t pages = (needed - current_size + 65535) / 65536;
      if (__builtin_wasm_memory_grow(0, pages) == (size_t)-1) { // lgtm[cpp/implicit-function-declaration]
        return (void *)-1;
      }
    }
  }
  brk += incr;
  return old;
}

void *memset(void *s, int c, size_t n) {
  unsigned char *p = (unsigned char *)s;
  while (n--) *p++ = (unsigned char)c;
  return s;
}

void *memcpy(void *dest, const void *src, size_t n) {
  unsigned char *d = (unsigned char *)dest;
  const unsigned char *s2 = (const unsigned char *)src;
  while (n--) *d++ = *s2++;
  return dest;
}

void *memmove(void *dest, const void *src, size_t n) {
  unsigned char *d = (unsigned char *)dest;
  const unsigned char *s2 = (const unsigned char *)src;
  if (d < s2) {
    while (n--) *d++ = *s2++;
  } else {
    d += n; s2 += n;
    while (n--) *--d = *--s2;
  }
  return dest;
}

int memcmp(const void *s1, const void *s2, size_t n) {
  const unsigned char *a = (const unsigned char *)s1;
  const unsigned char *b = (const unsigned char *)s2;
  while (n--) {
    if (*a != *b) return *a - *b;
    a++; b++;
  }
  return 0;
}

size_t strlen(const char *s) {
  const char *p = s;
  while (*p) p++;
  return (size_t)(p - s);
}

int strcmp(const char *s1, const char *s2) {
  while (*s1 && *s1 == *s2) { s1++; s2++; }
  return *(unsigned char *)s1 - *(unsigned char *)s2;
}

void abort(void) {
  __builtin_trap();
}

/*
  128-bit multiplication for wasm32 (replacement of compiler-rt __multi3).
  clang lowers `mul i128` (used in mclb_modp256/384 of base32.ll) to a call to this function.
  Written with 64-bit arithmetic only so that it does not call itself.
*/
typedef unsigned long long u64;
typedef unsigned __int128 u128;

static inline u128 mul64x64(u64 x, u64 y) {
  u64 a = x >> 32, b = (unsigned)x, c = y >> 32, d = (unsigned)y;
  u64 bd = b * d, ad = a * d, bc = b * c, ac = a * c;
  u64 mid = (bd >> 32) + (unsigned)ad + (unsigned)bc;
  u64 lo = (bd & 0xffffffffULL) | (mid << 32);
  u64 hi = ac + (ad >> 32) + (bc >> 32) + (mid >> 32);
  return ((u128)hi << 64) | lo;
}

u128 __multi3(u128 x, u128 y) {
  u64 xl = (u64)x, xh = (u64)(x >> 64), yl = (u64)y, yh = (u64)(y >> 64);
  u128 r = mul64x64(xl, yl);
  u64 hi = (u64)(r >> 64) + xl * yh + xh * yl;
  return ((u128)hi << 64) | (u64)r;
}
