#pragma once
/**
	@file
	@brief detect Intel CPU features
	@author MITSUNARI Shigeo(@herumi)
	@license modified new BSD license
	http://opensource.org/licenses/BSD-3-Clause
	This code is extracted from xbyak_util.h for compiling without xbyak
*/

#include <stdint.h>
#if defined(__i386__) || defined(__x86_64__) || defined(_M_IX86) || defined(_M_X64)
	#define MCL_INTEL_CPU_SPECIFIC
#endif

#ifdef MCL_INTEL_CPU_SPECIFIC
#ifdef _MSC_VER
	#include <intrin.h> // for __cpuid
#else
	#ifndef __GNUC_PREREQ
		#define __GNUC_PREREQ(major, minor) ((((__GNUC__) << 16) + (__GNUC_MINOR__)) >= (((major) << 16) + (minor)))
	#endif
	#if __GNUC_PREREQ(4, 3) && !defined(__APPLE__)
		#include <cpuid.h>
	#else
		#ifndef __cpuid
			#define __cpuid(eaxIn, a, b, c, d) __asm__ __volatile__("cpuid\n" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "0"(eaxIn))
			#define __cpuid_count(eaxIn, ecxIn, a, b, c, d) __asm__ __volatile__("cpuid\n" : "=a"(a), "=b"(b), "=c"(c), "=d"(d) : "0"(eaxIn), "2"(ecxIn))
		#endif
	#endif
#endif
#endif

namespace mcl { namespace util {

/**
	CPU detection class
*/
class Cpu {
	uint64_t type_;
public:
	/*
		data[] = { eax, ebx, ecx, edx }
	*/
	static inline void getCpuid(unsigned int eaxIn, unsigned int data[4])
	{
#ifdef MCL_INTEL_CPU_SPECIFIC
	#ifdef _MSC_VER
		__cpuid(reinterpret_cast<int*>(data), eaxIn);
	#else
		__cpuid(eaxIn, data[0], data[1], data[2], data[3]);
	#endif
#else
		(void)eaxIn;
		(void)data;
#endif
	}
	static inline void getCpuidEx(unsigned int eaxIn, unsigned int ecxIn, unsigned int data[4])
	{
#ifdef MCL_INTEL_CPU_SPECIFIC
	#ifdef _MSC_VER
		__cpuidex(reinterpret_cast<int*>(data), eaxIn, ecxIn);
	#else
		__cpuid_count(eaxIn, ecxIn, data[0], data[1], data[2], data[3]);
	#endif
#else
		(void)eaxIn;
		(void)ecxIn;
		(void)data;
#endif
	}
	typedef uint64_t Type;
	static const Type NONE = 0;
	static const Type tBMI2 = 1 << 22; // bzhi, mulx, pdep, pext, rorx, sarx, shlx, shrx
	Cpu()
		: type_(NONE)
	{
		unsigned int data[4] = {};
		const unsigned int& EAX = data[0];
		const unsigned int& EBX = data[1];
		getCpuid(0, data);
		const unsigned int maxNum = EAX;
		if (maxNum >= 7) {
			getCpuidEx(7, 0, data);
			if (EBX & (1U << 8)) type_ |= tBMI2;
		}
	}
	bool has(Type type) const
	{
		return (type & type_) != 0;
	}
};

} } // mcl::util

