// equivalent to stack.s
// compile without -flto

#include <stdint.h>
#include <stddef.h>

extern uint8_t *__stack_pointer __attribute__((address_space(1)));

uint8_t *stackSave(void) {
	return __stack_pointer;
}

void stackRestore(uint8_t *sp) {
	__stack_pointer = sp;
}

uint8_t *stackAlloc(size_t n) {
	uintptr_t sp = (uintptr_t)__stack_pointer;
	sp = (sp - n) & ~(uintptr_t)15;
	__stack_pointer = (uint8_t *)sp;
	return (uint8_t *)sp;
}
