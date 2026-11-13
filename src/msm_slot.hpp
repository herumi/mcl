#pragma once
/*
	the slots of the work buffers of mulVec (the multi-scalar multiplication) : used by mulVecGLVlargeCore, mulVecCore and mulVecCorePar in glv.hpp

	a call of mulVec takes one slot (the first free one) and all the buffers of the call (the split scalars and the converted points of the caller,
	the context of the parallel run and the bucket tables of the threads) are taken from the buffers of the slot.
	the buffers are kept after the call and reused by the next call (a buffer is reallocated only if it is too small),
	because the first touch of the pages of a fresh malloc is a bottleneck of the parallel mulVec :
	glibc unmaps a buffer over its mmap threshold by free (and trims the top of the heap), the heap of Windows returns the pages of a block of about 1 MB or more by free,
	and both page in again by the next malloc (about 1 GB of page faults in a proof of 128k constraints of mnova, 5-15% of the time).
	the slots are taken from the first one, so only the first slot holds memory if mulVec is not called concurrently.
	a temporary slot (freed at the end of the call) is used if all the MSM_SLOT_N slots are busy.
	the kept buffers are freed by msmSlotFreeAll (mcl::ec::freeMulVecBuffer, mclBn_freeMulVecBuffer of the C API).
*/
#include <stdlib.h>
#include <string.h>
#include <cybozu/inttype.hpp>
#include <cybozu/atomic.hpp>
#if defined(__linux__)
#include <sys/mman.h> // madvise(MADV_HUGEPAGE) of mallocLarge
#endif

namespace mcl { namespace ec { namespace local {

/*
	malloc of a large buffer of mulVec (freed by free) :
	on Linux the buffer is 2 MiB aligned and madvise(MADV_HUGEPAGE) (effective if /sys/kernel/mm/transparent_hugepage/enabled is always or madvise),
	because the page faults of the first touch of a fresh mmap
	are the bottleneck of the parallel mulVec (2^20 points on 56 threads : 100 ms with 4 KiB pages, 75 ms with 2 MiB pages)
*/
inline void* mallocLarge(size_t size)
{
#if defined(__linux__) && defined(MADV_HUGEPAGE) && !defined(MCL_MSM_NO_HUGEPAGE)
	const size_t HUGE = size_t(2) << 20;
	if (size >= HUGE) {
		const size_t roundSize = (size + HUGE - 1) / HUGE * HUGE;
		void *p = 0;
		if (posix_memalign(&p, HUGE, roundSize) == 0) {
			madvise(p, roundSize, MADV_HUGEPAGE);
			return p;
		}
	}
#endif
	return malloc(size);
}

// a buffer which is kept and grows (POD : zero-initialized as a static object)
struct MsmBuf {
	void *p;
	size_t size; // the capacity in bytes
	// return a buffer of n bytes (the old one is freed if it is smaller), 0 if malloc fails (then the old one is freed)
	void* get(size_t n)
	{
		if (n <= size) return p;
		free(p);
		p = mallocLarge(n);
		size = p ? n : 0;
		return p;
	}
	void clear()
	{
		free(p);
		p = 0;
		size = 0;
	}
};

// the buffers of one call of mulVec (POD)
struct MsmSlot {
	enum {
		OUTER = 0, // mulVecGLVlargeCore : the split scalars, the converted (or copied) points
		PAR = 1, // mulVecCorePar : the converted points, the results of the tasks, the works of the threads
		WORK = 2, // the bucket tables (and the works of the batch affine addition) of the threads of mulVecCorePar or of the sequential mulVecCore
		N = 3
	};
	uint32_t inUse; // 1 if taken (set by a compare-and-exchange)
	MsmBuf buf[N];
	void clear()
	{
		for (size_t i = 0; i < N; i++) buf[i].clear();
	}
};

static const size_t MSM_SLOT_N = 8; // the max number of the concurrent calls of mulVec which keep the buffers

struct MsmSlotPool {
	MsmSlot slot[MSM_SLOT_N];
};

// the pool is a POD without a dynamic initializer, so it is usable from the static initializers of the user
inline MsmSlotPool& getMsmSlotPool()
{
	static MsmSlotPool pool;
	return pool;
}

// take the first free slot, 0 if all the slots are busy
inline MsmSlot* msmSlotAcquire()
{
	MsmSlotPool& pool = getMsmSlotPool();
	for (size_t i = 0; i < MSM_SLOT_N; i++) {
		MsmSlot& s = pool.slot[i];
		if (s.inUse == 0 && cybozu::AtomicCompareExchange<uint32_t>(&s.inUse, 1, 0) == 0) return &s;
	}
	return 0;
}

inline void msmSlotRelease(MsmSlot *s)
{
	cybozu::AtomicExchange<uint32_t>(&s->inUse, 0);
}

// free the buffers of the slots which are not in use (a slot in use is released with its buffers kept by the call)
inline void msmSlotFreeAll()
{
	MsmSlotPool& pool = getMsmSlotPool();
	for (size_t i = 0; i < MSM_SLOT_N; i++) {
		MsmSlot& s = pool.slot[i];
		if (cybozu::AtomicCompareExchange<uint32_t>(&s.inUse, 1, 0) != 0) continue;
		s.clear();
		msmSlotRelease(&s);
	}
}

/*
	the slot of a call of mulVec : the slot of the outer call if given (then nothing is done here),
	otherwise a slot taken here and released by the destructor (a temporary slot freed by the destructor if all the slots are busy)
*/
struct MsmSlotHolder {
	MsmSlot *s;
	bool owner;
	MsmSlot tmp;
	explicit MsmSlotHolder(MsmSlot *outer)
		: s(outer)
		, owner(false)
	{
		if (s) return;
		owner = true;
		s = msmSlotAcquire();
		if (s == 0) {
			memset(&tmp, 0, sizeof(tmp));
			s = &tmp;
		}
	}
	~MsmSlotHolder()
	{
		if (!owner) return;
		if (s == &tmp) {
			tmp.clear();
		} else {
			msmSlotRelease(s);
		}
	}
	// the buffer idx (MsmSlot::OUTER, ...) of n bytes, 0 if malloc fails
	void* get(int idx, size_t n) const { return s->buf[idx].get(n); }
private:
	MsmSlotHolder(const MsmSlotHolder&);
	void operator=(const MsmSlotHolder&);
};

} } } // mcl::ec::local
