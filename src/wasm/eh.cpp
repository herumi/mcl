/*
	minimal C++ exception handling runtime for wasm32 with -fwasm-exceptions
	- all catch clauses must be catch (...); typed catch requires a personality
	  routine and LSDA parsing, which this runtime does not provide
	- nested exceptions and rethrow are not supported
	compile this file with -fwasm-exceptions
*/
extern "C" void* malloc(unsigned long);
extern "C" void free(void*);

// referenced by typeinfo emitted for thrown types; never dereferenced
// because no type matching is done
namespace __cxxabiv1 {
class __class_type_info {
public:
	virtual ~__class_type_info();
};
__class_type_info::~__class_type_info() {}
class __si_class_type_info {
public:
	virtual ~__si_class_type_info();
};
__si_class_type_info::~__si_class_type_info() {}
}

namespace std {
void terminate() { __builtin_trap(); }
}

void* operator new(unsigned long size)
{
	void* p = malloc(size);
	if (p == 0) __builtin_trap();
	return p;
}
void* operator new[](unsigned long size) { return operator new(size); }
void operator delete(void* p) noexcept { free(p); }
void operator delete(void* p, unsigned long) noexcept { free(p); }
void operator delete[](void* p) noexcept { free(p); }
void operator delete[](void* p, unsigned long) noexcept { free(p); }

extern "C" {

static void* g_exn;
static void (*g_dtor)(void*);

void* __cxa_allocate_exception(unsigned long size)
{
	return malloc(size);
}

void __cxa_free_exception(void* p)
{
	free(p);
}

void __cxa_throw(void* thrown, void*, void (*dtor)(void*))
{
	g_exn = thrown;
	g_dtor = dtor;
	__builtin_wasm_throw(0, thrown);
}

void* __cxa_begin_catch(void* p)
{
	return p;
}

void __cxa_end_catch()
{
	if (g_dtor) g_dtor(g_exn);
	free(g_exn);
	g_exn = 0;
	g_dtor = 0;
}

void __cxa_rethrow()
{
	__builtin_trap();
}

// registration of global dtors ; never called because the instance has no exit
int __cxa_atexit(void (*)(void*), void*, void*)
{
	return 0;
}

}
