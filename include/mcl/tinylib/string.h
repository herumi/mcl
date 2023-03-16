#pragma once

#include <stdlib.h>

static inline size_t strlen(const char *s)
{
	size_t n = 0;
	while (s[n]) {
		n++;
	}
	return n;
}

static inline void *memset(void *_s, int c, size_t n)
{
	unsigned char *s = (unsigned char*)_s;
	for (size_t i = 0; i < n; i++) s[i] = (unsigned char)c;
	return _s;
}

static inline int strcmp(const char *s1, const char *s2)
{
	const unsigned char *u1 = (const unsigned char *)s1;
	const unsigned char *u2 = (const unsigned char *)s2;
	unsigned char c1, c2;
	for (;;) {
		c1 = *u1++;
		c2 = *u2++;
		if (c1 == 0) return c1 - c2;
		if (c1 != c2) break;
	}
	return c1 - c2;
}
