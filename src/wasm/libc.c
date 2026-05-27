// Minimal memset/memcpy/memmove for wasm32 (no libc)
#include <stddef.h>

// sbrk implementation using wasm memory.grow
extern unsigned char __heap_base;
static unsigned char *brk = &__heap_base;

void *sbrk(long incr) {
  unsigned char *old = brk;
  if (incr > 0) {
    // Each wasm page is 64KB
    size_t current_size = (size_t)__builtin_wasm_memory_size(0) * 65536;
    size_t needed = (size_t)(brk + incr);
    if (needed > current_size) {
      size_t pages = (needed - current_size + 65535) / 65536;
      if (__builtin_wasm_memory_grow(0, pages) == (size_t)-1) {
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
