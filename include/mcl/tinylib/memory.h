#pragma once

#include <stdlib.h>

static inline void memcpy(void* _dst, const void* _src, size_t n)
{
	unsigned char *dst = (unsigned char*)_dst;
	const unsigned char *src = (const unsigned char*)_src;
	for (size_t i = 0; i < n; i++) dst[i] = src[i];
}
