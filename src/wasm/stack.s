	.globaltype	__stack_pointer, i32

	.section	.text.stackSave,"",@
	.globl	stackSave
	.type	stackSave,@function
stackSave:
	.functype	stackSave () -> (i32)
	global.get	__stack_pointer
	end_function

	.section	.text.stackAlloc,"",@
	.globl	stackAlloc
	.type	stackAlloc,@function
stackAlloc:
	.functype	stackAlloc (i32) -> (i32)
	global.get	__stack_pointer
	local.get	0
	i32.sub
	i32.const	-16
	i32.and
	local.tee	0
	global.set	__stack_pointer
	local.get	0
	end_function

	.section	.text.stackRestore,"",@
	.globl	stackRestore
	.type	stackRestore,@function
stackRestore:
	.functype	stackRestore (i32) -> ()
	local.get	0
	global.set	__stack_pointer
	end_function
