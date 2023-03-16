#pragma once
#ifndef MCL_SIZEOF_UNIT
	#error "include mcl/config.hpp at first"
#endif

static inline void *malloc(size_t size)
{
	(void)size;
	return 0;
}
static inline void free(void *ptr)
{
	(void)ptr;
}
