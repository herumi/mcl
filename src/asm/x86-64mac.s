	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	_makeNIST_P192L
	.p2align	4, 0x90
_makeNIST_P192L:                        ## @makeNIST_P192L
## BB#0:
	movq	$-1, %rax
	movq	$-2, %rdx
	movq	$-1, %rcx
	retq

	.globl	_mcl_fpDbl_mod_NIST_P192L
	.p2align	4, 0x90
_mcl_fpDbl_mod_NIST_P192L:              ## @mcl_fpDbl_mod_NIST_P192L
## BB#0:
	pushq	%r14
	pushq	%rbx
	movq	16(%rsi), %r10
	movq	24(%rsi), %r8
	movq	40(%rsi), %r9
	movq	8(%rsi), %rax
	addq	%r9, %rax
	adcq	$0, %r10
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	movq	32(%rsi), %r11
	movq	(%rsi), %r14
	addq	%r8, %r14
	adcq	%r11, %rax
	adcq	%r9, %r10
	adcq	$0, %rcx
	addq	%r9, %r14
	adcq	%r8, %rax
	adcq	%r11, %r10
	adcq	$0, %rcx
	addq	%rcx, %r14
	adcq	%rax, %rcx
	adcq	$0, %r10
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%r14, %rsi
	addq	$1, %rsi
	movq	%rcx, %rdx
	adcq	$1, %rdx
	movq	%r10, %rbx
	adcq	$0, %rbx
	adcq	$-1, %rax
	andl	$1, %eax
	cmovneq	%r14, %rsi
	movq	%rsi, (%rdi)
	testb	%al, %al
	cmovneq	%rcx, %rdx
	movq	%rdx, 8(%rdi)
	cmovneq	%r10, %rbx
	movq	%rbx, 16(%rdi)
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fp_sqr_NIST_P192L
	.p2align	4, 0x90
_mcl_fp_sqr_NIST_P192L:                 ## @mcl_fp_sqr_NIST_P192L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %rcx
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	%rbx
	movq	%rax, %r13
	movq	%rdx, %rcx
	addq	%rcx, %r12
	adcq	%r14, %r15
	movq	%rdi, %r10
	adcq	$0, %r10
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %r9
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %rsi
	addq	%r13, %rsi
	adcq	%rbp, %rcx
	movq	%r9, %rbx
	adcq	$0, %rbx
	addq	%r13, %rsi
	adcq	%r12, %rcx
	adcq	%r15, %rbx
	adcq	$0, %r10
	movq	%r11, %rax
	mulq	%r11
	addq	%r14, %r9
	adcq	%rdi, %rax
	adcq	$0, %rdx
	addq	%rbp, %rcx
	adcq	%rbx, %r9
	adcq	%r10, %rax
	adcq	$0, %rdx
	addq	%rdx, %rsi
	adcq	$0, %rcx
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	addq	%r9, %r8
	adcq	%rax, %rsi
	adcq	%rdx, %rcx
	adcq	$0, %rbp
	addq	%rdx, %r8
	adcq	%r9, %rsi
	adcq	%rax, %rcx
	adcq	$0, %rbp
	addq	%rbp, %r8
	adcq	%rsi, %rbp
	adcq	$0, %rcx
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%r8, %rdx
	addq	$1, %rdx
	movq	%rbp, %rsi
	adcq	$1, %rsi
	movq	%rcx, %rdi
	adcq	$0, %rdi
	adcq	$-1, %rax
	andl	$1, %eax
	cmovneq	%r8, %rdx
	movq	-8(%rsp), %rbx          ## 8-byte Reload
	movq	%rdx, (%rbx)
	testb	%al, %al
	cmovneq	%rbp, %rsi
	movq	%rsi, 8(%rbx)
	cmovneq	%rcx, %rdi
	movq	%rdi, 16(%rbx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mulNIST_P192L
	.p2align	4, 0x90
_mcl_fp_mulNIST_P192L:                  ## @mcl_fp_mulNIST_P192L
## BB#0:
	pushq	%r14
	pushq	%rbx
	subq	$56, %rsp
	movq	%rdi, %r14
	leaq	8(%rsp), %rdi
	callq	_mcl_fpDbl_mulPre3L
	movq	24(%rsp), %r9
	movq	32(%rsp), %r8
	movq	48(%rsp), %rdi
	movq	16(%rsp), %rbx
	addq	%rdi, %rbx
	adcq	$0, %r9
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	movq	40(%rsp), %rsi
	movq	8(%rsp), %rdx
	addq	%r8, %rdx
	adcq	%rsi, %rbx
	adcq	%rdi, %r9
	adcq	$0, %rcx
	addq	%rdi, %rdx
	adcq	%r8, %rbx
	adcq	%rsi, %r9
	adcq	$0, %rcx
	addq	%rcx, %rdx
	adcq	%rbx, %rcx
	adcq	$0, %r9
	sbbq	%rsi, %rsi
	andl	$1, %esi
	movq	%rdx, %rdi
	addq	$1, %rdi
	movq	%rcx, %rbx
	adcq	$1, %rbx
	movq	%r9, %rax
	adcq	$0, %rax
	adcq	$-1, %rsi
	andl	$1, %esi
	cmovneq	%rdx, %rdi
	movq	%rdi, (%r14)
	testb	%sil, %sil
	cmovneq	%rcx, %rbx
	movq	%rbx, 8(%r14)
	cmovneq	%r9, %rax
	movq	%rax, 16(%r14)
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fpDbl_mod_NIST_P521L
	.p2align	4, 0x90
_mcl_fpDbl_mod_NIST_P521L:              ## @mcl_fpDbl_mod_NIST_P521L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	120(%rsi), %r9
	movq	128(%rsi), %r14
	movq	%r14, %r8
	shldq	$55, %r9, %r8
	movq	112(%rsi), %r10
	shldq	$55, %r10, %r9
	movq	104(%rsi), %r11
	shldq	$55, %r11, %r10
	movq	96(%rsi), %r15
	shldq	$55, %r15, %r11
	movq	88(%rsi), %r12
	shldq	$55, %r12, %r15
	movq	80(%rsi), %rcx
	shldq	$55, %rcx, %r12
	movq	64(%rsi), %rbx
	movq	72(%rsi), %rax
	shldq	$55, %rax, %rcx
	shrq	$9, %r14
	shldq	$55, %rbx, %rax
                                        ## kill: %EBX<def> %EBX<kill> %RBX<kill> %RBX<def>
	andl	$511, %ebx              ## imm = 0x1FF
	addq	(%rsi), %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r12
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r10
	adcq	48(%rsi), %r9
	adcq	56(%rsi), %r8
	adcq	%r14, %rbx
	movl	%ebx, %esi
	shrl	$9, %esi
	andl	$1, %esi
	addq	%rax, %rsi
	adcq	$0, %rcx
	adcq	$0, %r12
	adcq	$0, %r15
	adcq	$0, %r11
	adcq	$0, %r10
	adcq	$0, %r9
	adcq	$0, %r8
	adcq	$0, %rbx
	movq	%rsi, %rax
	andq	%r12, %rax
	andq	%r15, %rax
	andq	%r11, %rax
	andq	%r10, %rax
	andq	%r9, %rax
	andq	%r8, %rax
	movq	%rbx, %rdx
	orq	$-512, %rdx             ## imm = 0xFE00
	andq	%rax, %rdx
	andq	%rcx, %rdx
	cmpq	$-1, %rdx
	je	LBB4_1
## BB#3:                                ## %nonzero
	movq	%rsi, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%r12, 16(%rdi)
	movq	%r15, 24(%rdi)
	movq	%r11, 32(%rdi)
	movq	%r10, 40(%rdi)
	movq	%r9, 48(%rdi)
	movq	%r8, 56(%rdi)
	andl	$511, %ebx              ## imm = 0x1FF
	movq	%rbx, 64(%rdi)
	jmp	LBB4_2
LBB4_1:                                 ## %zero
	movq	$0, 64(%rdi)
	movq	$0, 56(%rdi)
	movq	$0, 48(%rdi)
	movq	$0, 40(%rdi)
	movq	$0, 32(%rdi)
	movq	$0, 24(%rdi)
	movq	$0, 16(%rdi)
	movq	$0, 8(%rdi)
	movq	$0, (%rdi)
LBB4_2:                                 ## %zero
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_mulUnitPre1L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre1L:                   ## @mcl_fp_mulUnitPre1L
## BB#0:
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	retq

	.globl	_mcl_fpDbl_mulPre1L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre1L:                    ## @mcl_fpDbl_mulPre1L
## BB#0:
	movq	(%rdx), %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	retq

	.globl	_mcl_fpDbl_sqrPre1L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre1L:                    ## @mcl_fpDbl_sqrPre1L
## BB#0:
	movq	(%rsi), %rax
	mulq	%rax
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	retq

	.globl	_mcl_fp_mont1L
	.p2align	4, 0x90
_mcl_fp_mont1L:                         ## @mcl_fp_mont1L
## BB#0:
	movq	(%rsi), %rax
	mulq	(%rdx)
	movq	%rax, %rsi
	movq	%rdx, %r8
	movq	-8(%rcx), %rax
	imulq	%rsi, %rax
	movq	(%rcx), %rcx
	mulq	%rcx
	addq	%rsi, %rax
	adcq	%r8, %rdx
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rdx, %rsi
	subq	%rcx, %rsi
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rdi)
	retq

	.globl	_mcl_fp_montNF1L
	.p2align	4, 0x90
_mcl_fp_montNF1L:                       ## @mcl_fp_montNF1L
## BB#0:
	movq	(%rsi), %rax
	mulq	(%rdx)
	movq	%rax, %rsi
	movq	%rdx, %r8
	movq	-8(%rcx), %rax
	imulq	%rsi, %rax
	movq	(%rcx), %rcx
	mulq	%rcx
	addq	%rsi, %rax
	adcq	%r8, %rdx
	movq	%rdx, %rax
	subq	%rcx, %rax
	cmovsq	%rdx, %rax
	movq	%rax, (%rdi)
	retq

	.globl	_mcl_fp_montRed1L
	.p2align	4, 0x90
_mcl_fp_montRed1L:                      ## @mcl_fp_montRed1L
## BB#0:
	movq	(%rsi), %rcx
	movq	-8(%rdx), %rax
	imulq	%rcx, %rax
	movq	(%rdx), %r8
	mulq	%r8
	addq	%rcx, %rax
	adcq	8(%rsi), %rdx
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rdx, %rcx
	subq	%r8, %rcx
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rdx, %rcx
	movq	%rcx, (%rdi)
	retq

	.globl	_mcl_fp_addPre1L
	.p2align	4, 0x90
_mcl_fp_addPre1L:                       ## @mcl_fp_addPre1L
## BB#0:
	movq	(%rdx), %rax
	addq	(%rsi), %rax
	movq	%rax, (%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_subPre1L
	.p2align	4, 0x90
_mcl_fp_subPre1L:                       ## @mcl_fp_subPre1L
## BB#0:
	movq	(%rsi), %rcx
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	movq	%rcx, (%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_shr1_1L
	.p2align	4, 0x90
_mcl_fp_shr1_1L:                        ## @mcl_fp_shr1_1L
## BB#0:
	movq	(%rsi), %rax
	shrq	%rax
	movq	%rax, (%rdi)
	retq

	.globl	_mcl_fp_add1L
	.p2align	4, 0x90
_mcl_fp_add1L:                          ## @mcl_fp_add1L
## BB#0:
	movq	(%rdx), %rax
	addq	(%rsi), %rax
	movq	%rax, (%rdi)
	sbbq	%rdx, %rdx
	andl	$1, %edx
	subq	(%rcx), %rax
	sbbq	$0, %rdx
	testb	$1, %dl
	jne	LBB14_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
LBB14_2:                                ## %carry
	retq

	.globl	_mcl_fp_addNF1L
	.p2align	4, 0x90
_mcl_fp_addNF1L:                        ## @mcl_fp_addNF1L
## BB#0:
	movq	(%rdx), %rax
	addq	(%rsi), %rax
	movq	%rax, %rdx
	subq	(%rcx), %rdx
	cmovsq	%rax, %rdx
	movq	%rdx, (%rdi)
	retq

	.globl	_mcl_fp_sub1L
	.p2align	4, 0x90
_mcl_fp_sub1L:                          ## @mcl_fp_sub1L
## BB#0:
	movq	(%rsi), %rax
	xorl	%esi, %esi
	subq	(%rdx), %rax
	movq	%rax, (%rdi)
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB16_2
## BB#1:                                ## %nocarry
	retq
LBB16_2:                                ## %carry
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	retq

	.globl	_mcl_fp_subNF1L
	.p2align	4, 0x90
_mcl_fp_subNF1L:                        ## @mcl_fp_subNF1L
## BB#0:
	movq	(%rsi), %rax
	subq	(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	andq	(%rcx), %rdx
	addq	%rax, %rdx
	movq	%rdx, (%rdi)
	retq

	.globl	_mcl_fpDbl_add1L
	.p2align	4, 0x90
_mcl_fpDbl_add1L:                       ## @mcl_fpDbl_add1L
## BB#0:
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	movq	%rax, (%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rdx, %rsi
	subq	(%rcx), %rsi
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rdx, %rsi
	movq	%rsi, 8(%rdi)
	retq

	.globl	_mcl_fpDbl_sub1L
	.p2align	4, 0x90
_mcl_fpDbl_sub1L:                       ## @mcl_fpDbl_sub1L
## BB#0:
	movq	(%rsi), %rax
	movq	8(%rsi), %r8
	xorl	%esi, %esi
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r8
	movq	%rax, (%rdi)
	movl	$0, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	(%rcx), %rsi
	addq	%r8, %rsi
	movq	%rsi, 8(%rdi)
	retq

	.globl	_mcl_fp_mulUnitPre2L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre2L:                   ## @mcl_fp_mulUnitPre2L
## BB#0:
	movq	%rdx, %r8
	movq	%r8, %rax
	mulq	8(%rsi)
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%r8, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	adcq	$0, %rcx
	movq	%rcx, 16(%rdi)
	retq

	.globl	_mcl_fpDbl_mulPre2L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre2L:                    ## @mcl_fpDbl_mulPre2L
## BB#0:
	pushq	%r14
	pushq	%rbx
	movq	%rdx, %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %r11
	movq	(%r10), %rcx
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %r14
	movq	%rax, %rsi
	addq	%r9, %rsi
	adcq	$0, %r14
	movq	8(%r10), %rbx
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %r9
	movq	%rax, %rcx
	movq	%r8, %rax
	mulq	%rbx
	addq	%rsi, %rax
	movq	%rax, 8(%rdi)
	adcq	%r14, %rcx
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rdx, %rcx
	movq	%rcx, 16(%rdi)
	adcq	%r9, %rax
	movq	%rax, 24(%rdi)
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fpDbl_sqrPre2L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre2L:                    ## @mcl_fpDbl_sqrPre2L
## BB#0:
	movq	(%rsi), %rcx
	movq	8(%rsi), %r8
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, (%rdi)
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %r10
	addq	%r10, %rsi
	movq	%r9, %rcx
	adcq	$0, %rcx
	movq	%r8, %rax
	mulq	%r8
	addq	%r10, %rsi
	movq	%rsi, 8(%rdi)
	adcq	%rcx, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%r9, %rax
	movq	%rax, 16(%rdi)
	adcq	%rdx, %rcx
	movq	%rcx, 24(%rdi)
	retq

	.globl	_mcl_fp_mont2L
	.p2align	4, 0x90
_mcl_fp_mont2L:                         ## @mcl_fp_mont2L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	(%rsi), %r8
	movq	8(%rsi), %r11
	movq	(%rdx), %rsi
	movq	8(%rdx), %r9
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%r8, %rax
	mulq	%rsi
	movq	%rax, %r14
	movq	%rdx, %r13
	addq	%r10, %r13
	adcq	$0, %r15
	movq	-8(%rcx), %r10
	movq	(%rcx), %rbp
	movq	%r14, %rsi
	imulq	%r10, %rsi
	movq	8(%rcx), %rdi
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, %rbx
	addq	%r12, %rbx
	adcq	$0, %rcx
	addq	%r14, %rax
	adcq	%r13, %rbx
	adcq	%r15, %rcx
	sbbq	%r15, %r15
	andl	$1, %r15d
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %r14
	movq	%rax, %r11
	movq	%r9, %rax
	mulq	%r8
	movq	%rax, %r8
	movq	%rdx, %rsi
	addq	%r11, %rsi
	adcq	$0, %r14
	addq	%rbx, %r8
	adcq	%rcx, %rsi
	adcq	%r15, %r14
	sbbq	%rbx, %rbx
	andl	$1, %ebx
	imulq	%r8, %r10
	movq	%r10, %rax
	mulq	%rdi
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%r10, %rax
	mulq	%rbp
	addq	%r9, %rdx
	adcq	$0, %rcx
	addq	%r8, %rax
	adcq	%rsi, %rdx
	adcq	%r14, %rcx
	adcq	$0, %rbx
	movq	%rdx, %rax
	subq	%rbp, %rax
	movq	%rcx, %rsi
	sbbq	%rdi, %rsi
	sbbq	$0, %rbx
	andl	$1, %ebx
	cmovneq	%rcx, %rsi
	testb	%bl, %bl
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rcx          ## 8-byte Reload
	movq	%rax, (%rcx)
	movq	%rsi, 8(%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF2L
	.p2align	4, 0x90
_mcl_fp_montNF2L:                       ## @mcl_fp_montNF2L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	(%rsi), %r8
	movq	8(%rsi), %r11
	movq	(%rdx), %rbp
	movq	8(%rdx), %r9
	movq	%r8, %rax
	mulq	%rbp
	movq	%rax, %rsi
	movq	%rdx, %r14
	movq	-8(%rcx), %r10
	movq	(%rcx), %r15
	movq	%rsi, %rbx
	imulq	%r10, %rbx
	movq	8(%rcx), %rdi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, %rcx
	movq	%rax, %rbp
	addq	%r14, %rbp
	adcq	$0, %rcx
	addq	%rsi, %rbx
	adcq	%r13, %rbp
	adcq	$0, %rcx
	addq	%r12, %rbp
	adcq	-16(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, %r11
	movq	%r9, %rax
	mulq	%r8
	movq	%rax, %r8
	movq	%rdx, %rbx
	addq	%r11, %rbx
	adcq	$0, %rsi
	addq	%rbp, %r8
	adcq	%rcx, %rbx
	adcq	$0, %rsi
	imulq	%r8, %r10
	movq	%r10, %rax
	mulq	%rdi
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%r10, %rax
	mulq	%r15
	addq	%r8, %rax
	adcq	%rbx, %rbp
	adcq	$0, %rsi
	addq	%rdx, %rbp
	adcq	%rcx, %rsi
	movq	%rbp, %rax
	subq	%r15, %rax
	movq	%rsi, %rcx
	sbbq	%rdi, %rcx
	cmovsq	%rbp, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovsq	%rsi, %rcx
	movq	%rcx, 8(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed2L
	.p2align	4, 0x90
_mcl_fp_montRed2L:                      ## @mcl_fp_montRed2L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	-8(%rdx), %r9
	movq	(%rdx), %r11
	movq	(%rsi), %rbx
	movq	%rbx, %rcx
	imulq	%r9, %rcx
	movq	8(%rdx), %r14
	movq	%rcx, %rax
	mulq	%r14
	movq	%rdx, %r8
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	%r11
	movq	%rdx, %rcx
	addq	%r10, %rcx
	adcq	$0, %r8
	movq	24(%rsi), %r15
	addq	%rbx, %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r8
	adcq	$0, %r15
	sbbq	%rbx, %rbx
	andl	$1, %ebx
	imulq	%rcx, %r9
	movq	%r9, %rax
	mulq	%r14
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%r9, %rax
	mulq	%r11
	addq	%r10, %rdx
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r8, %rdx
	adcq	%r15, %rsi
	adcq	$0, %rbx
	movq	%rdx, %rax
	subq	%r11, %rax
	movq	%rsi, %rcx
	sbbq	%r14, %rcx
	sbbq	$0, %rbx
	andl	$1, %ebx
	cmovneq	%rsi, %rcx
	testb	%bl, %bl
	cmovneq	%rdx, %rax
	movq	%rax, (%rdi)
	movq	%rcx, 8(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_addPre2L
	.p2align	4, 0x90
_mcl_fp_addPre2L:                       ## @mcl_fp_addPre2L
## BB#0:
	movq	(%rdx), %rax
	movq	8(%rdx), %rcx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rcx
	movq	%rax, (%rdi)
	movq	%rcx, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_subPre2L
	.p2align	4, 0x90
_mcl_fp_subPre2L:                       ## @mcl_fp_subPre2L
## BB#0:
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	sbbq	8(%rdx), %rsi
	movq	%rcx, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_shr1_2L
	.p2align	4, 0x90
_mcl_fp_shr1_2L:                        ## @mcl_fp_shr1_2L
## BB#0:
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	shrdq	$1, %rcx, %rax
	movq	%rax, (%rdi)
	shrq	%rcx
	movq	%rcx, 8(%rdi)
	retq

	.globl	_mcl_fp_add2L
	.p2align	4, 0x90
_mcl_fp_add2L:                          ## @mcl_fp_add2L
## BB#0:
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %rax
	sbbq	8(%rcx), %rdx
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB29_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
LBB29_2:                                ## %carry
	retq

	.globl	_mcl_fp_addNF2L
	.p2align	4, 0x90
_mcl_fp_addNF2L:                        ## @mcl_fp_addNF2L
## BB#0:
	movq	(%rdx), %rax
	movq	8(%rdx), %r8
	addq	(%rsi), %rax
	adcq	8(%rsi), %r8
	movq	%rax, %rsi
	subq	(%rcx), %rsi
	movq	%r8, %rdx
	sbbq	8(%rcx), %rdx
	testq	%rdx, %rdx
	cmovsq	%rax, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, 8(%rdi)
	retq

	.globl	_mcl_fp_sub2L
	.p2align	4, 0x90
_mcl_fp_sub2L:                          ## @mcl_fp_sub2L
## BB#0:
	movq	(%rsi), %rax
	movq	8(%rsi), %r8
	xorl	%esi, %esi
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r8
	movq	%rax, (%rdi)
	movq	%r8, 8(%rdi)
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB31_2
## BB#1:                                ## %nocarry
	retq
LBB31_2:                                ## %carry
	movq	8(%rcx), %rdx
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%r8, %rdx
	movq	%rdx, 8(%rdi)
	retq

	.globl	_mcl_fp_subNF2L
	.p2align	4, 0x90
_mcl_fp_subNF2L:                        ## @mcl_fp_subNF2L
## BB#0:
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	movq	%rsi, %rdx
	sarq	$63, %rdx
	movq	8(%rcx), %rax
	andq	%rdx, %rax
	andq	(%rcx), %rdx
	addq	%r8, %rdx
	movq	%rdx, (%rdi)
	adcq	%rsi, %rax
	movq	%rax, 8(%rdi)
	retq

	.globl	_mcl_fpDbl_add2L
	.p2align	4, 0x90
_mcl_fpDbl_add2L:                       ## @mcl_fpDbl_add2L
## BB#0:
	movq	24(%rdx), %r8
	movq	24(%rsi), %r9
	movq	16(%rdx), %r10
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r10
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	adcq	%r8, %r9
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%r10, %rdx
	subq	(%rcx), %rdx
	movq	%r9, %rsi
	sbbq	8(%rcx), %rsi
	sbbq	$0, %rax
	andl	$1, %eax
	cmovneq	%r10, %rdx
	movq	%rdx, 16(%rdi)
	testb	%al, %al
	cmovneq	%r9, %rsi
	movq	%rsi, 24(%rdi)
	retq

	.globl	_mcl_fpDbl_sub2L
	.p2align	4, 0x90
_mcl_fpDbl_sub2L:                       ## @mcl_fpDbl_sub2L
## BB#0:
	movq	24(%rdx), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r11
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	movq	%r11, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%r8, %r9
	movl	$0, %edx
	sbbq	$0, %rdx
	andl	$1, %edx
	movq	(%rcx), %rsi
	cmoveq	%rax, %rsi
	testb	%dl, %dl
	cmovneq	8(%rcx), %rax
	addq	%r10, %rsi
	movq	%rsi, 16(%rdi)
	adcq	%r9, %rax
	movq	%rax, 24(%rdi)
	retq

	.globl	_mcl_fp_mulUnitPre3L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre3L:                   ## @mcl_fp_mulUnitPre3L
## BB#0:
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%r11, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r9, %r10
	movq	%r10, 16(%rdi)
	adcq	$0, %r8
	movq	%r8, 24(%rdi)
	retq

	.globl	_mcl_fpDbl_mulPre3L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre3L:                    ## @mcl_fpDbl_mulPre3L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	movq	(%r10), %rbx
	movq	%r8, %rax
	mulq	%rbx
	movq	%rdx, %rcx
	movq	16(%rsi), %r11
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %r14
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%rbx
	movq	%rdx, %r15
	movq	%rax, %rbx
	addq	%rcx, %rbx
	adcq	%rsi, %r15
	adcq	$0, %r14
	movq	8(%r10), %rcx
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%r8, %rax
	mulq	%rcx
	addq	%rbx, %rax
	movq	%rax, 8(%rdi)
	adcq	%r15, %rsi
	adcq	%r14, %rbp
	sbbq	%r14, %r14
	andl	$1, %r14d
	addq	%rdx, %rsi
	adcq	%r13, %rbp
	adcq	%r12, %r14
	movq	16(%r10), %r15
	movq	%r11, %rax
	mulq	%r15
	movq	%rdx, %r10
	movq	%rax, %rbx
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %r9
	movq	%rax, %rcx
	movq	%r8, %rax
	mulq	%r15
	addq	%rsi, %rax
	movq	%rax, 16(%rdi)
	adcq	%rbp, %rcx
	adcq	%r14, %rbx
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rdx, %rcx
	movq	%rcx, 24(%rdi)
	adcq	%r9, %rbx
	movq	%rbx, 32(%rdi)
	adcq	%r10, %rax
	movq	%rax, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre3L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre3L:                    ## @mcl_fpDbl_sqrPre3L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	16(%rsi), %r10
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %rbx
	movq	%rax, (%rdi)
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %r14
	movq	%rax, %r12
	addq	%r12, %rbx
	movq	%r14, %r13
	adcq	%r11, %r13
	movq	%r8, %rcx
	adcq	$0, %rcx
	movq	%r10, %rax
	mulq	%rsi
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%rsi, %rax
	mulq	%rsi
	movq	%rax, %rsi
	addq	%r12, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r13, %rsi
	adcq	%r15, %rcx
	sbbq	%rbx, %rbx
	andl	$1, %ebx
	addq	%r14, %rsi
	adcq	%rdx, %rcx
	adcq	%r9, %rbx
	movq	%r10, %rax
	mulq	%r10
	addq	%r11, %rsi
	movq	%rsi, 16(%rdi)
	adcq	%r15, %rcx
	adcq	%rbx, %rax
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	%r8, %rcx
	movq	%rcx, 24(%rdi)
	adcq	%r9, %rax
	movq	%rax, 32(%rdi)
	adcq	%rdx, %rsi
	movq	%rsi, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_mont3L
	.p2align	4, 0x90
_mcl_fp_mont3L:                         ## @mcl_fp_mont3L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	16(%rsi), %r10
	movq	(%rdx), %rdi
	movq	%rdx, %r11
	movq	%r11, -16(%rsp)         ## 8-byte Spill
	movq	%r10, %rax
	movq	%r10, -24(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %rbx
	movq	%rdx, %r15
	movq	(%rsi), %rbp
	movq	%rbp, -64(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r12
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, %r13
	addq	%rsi, %r13
	adcq	%rbx, %r12
	adcq	$0, %r15
	movq	-8(%rcx), %r14
	movq	%r8, %rbp
	imulq	%r14, %rbp
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r9
	movq	%rdx, %rbx
	movq	(%rcx), %rdi
	movq	%rdi, -40(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -48(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, %rcx
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, %rbp
	addq	%rcx, %rbp
	adcq	%r9, %rsi
	adcq	$0, %rbx
	addq	%r8, %rax
	adcq	%r13, %rbp
	movq	8(%r11), %rcx
	adcq	%r12, %rsi
	adcq	%r15, %rbx
	sbbq	%rdi, %rdi
	andl	$1, %edi
	movq	%rcx, %rax
	mulq	%r10
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	%rcx, %rax
	movq	-32(%rsp), %r10         ## 8-byte Reload
	mulq	%r10
	movq	%rdx, %r12
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r13
	movq	%rdx, %rcx
	addq	%r9, %rcx
	adcq	%r8, %r12
	adcq	$0, %r15
	addq	%rbp, %r13
	adcq	%rsi, %rcx
	adcq	%rbx, %r12
	adcq	%rdi, %r15
	sbbq	%r11, %r11
	andl	$1, %r11d
	movq	%r13, %rdi
	imulq	%r14, %rdi
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	addq	%r9, %rbp
	adcq	%r8, %rsi
	adcq	$0, %rbx
	addq	%r13, %rax
	adcq	%rcx, %rbp
	adcq	%r12, %rsi
	adcq	%r15, %rbx
	adcq	$0, %r11
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	%r10
	movq	%rdx, %r10
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rcx
	addq	%rdi, %rcx
	adcq	%r15, %r10
	adcq	$0, %r8
	addq	%rbp, %r9
	adcq	%rsi, %rcx
	adcq	%rbx, %r10
	adcq	%r11, %r8
	sbbq	%rdi, %rdi
	andl	$1, %edi
	imulq	%r9, %r14
	movq	%r14, %rax
	movq	-56(%rsp), %r15         ## 8-byte Reload
	mulq	%r15
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%r14, %rax
	movq	-48(%rsp), %r12         ## 8-byte Reload
	mulq	%r12
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%r14, %rax
	movq	-40(%rsp), %rbp         ## 8-byte Reload
	mulq	%rbp
	addq	%r13, %rdx
	adcq	%r11, %rsi
	adcq	$0, %rbx
	addq	%r9, %rax
	adcq	%rcx, %rdx
	adcq	%r10, %rsi
	adcq	%r8, %rbx
	adcq	$0, %rdi
	movq	%rdx, %rax
	subq	%rbp, %rax
	movq	%rsi, %rcx
	sbbq	%r12, %rcx
	movq	%rbx, %rbp
	sbbq	%r15, %rbp
	sbbq	$0, %rdi
	andl	$1, %edi
	cmovneq	%rbx, %rbp
	testb	%dil, %dil
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rsi, %rcx
	movq	%rcx, 8(%rdx)
	movq	%rbp, 16(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF3L
	.p2align	4, 0x90
_mcl_fp_montNF3L:                       ## @mcl_fp_montNF3L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	16(%rsi), %r11
	movq	(%r10), %rbp
	movq	%r10, -16(%rsp)         ## 8-byte Spill
	movq	%r11, %rax
	movq	%r11, -24(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	(%rsi), %rbx
	movq	%rbx, -48(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rdi
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%rdx, %rbp
	addq	%r8, %rbp
	adcq	%r14, %rdi
	adcq	$0, %r15
	movq	-8(%rcx), %r14
	movq	%r13, %rbx
	imulq	%r14, %rbx
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r12
	movq	%rdx, %r8
	movq	(%rcx), %rsi
	movq	%rsi, -32(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -40(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	%rsi
	addq	%r13, %rax
	adcq	%rbp, %rcx
	adcq	%rdi, %r12
	adcq	$0, %r15
	addq	%rdx, %rcx
	movq	8(%r10), %rbp
	adcq	%r9, %r12
	adcq	%r8, %r15
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rbp, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r9
	movq	%rbp, %rax
	movq	-48(%rsp), %r10         ## 8-byte Reload
	mulq	%r10
	movq	%rax, %r13
	movq	%rdx, %rbp
	addq	%r9, %rbp
	adcq	%r8, %rbx
	adcq	$0, %rsi
	addq	%rcx, %r13
	adcq	%r12, %rbp
	adcq	%r15, %rbx
	adcq	$0, %rsi
	movq	%r13, %rcx
	imulq	%r14, %rcx
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r15
	movq	%rcx, %rax
	movq	-40(%rsp), %rdi         ## 8-byte Reload
	mulq	%rdi
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%rcx, %rax
	movq	-32(%rsp), %r11         ## 8-byte Reload
	mulq	%r11
	addq	%r13, %rax
	adcq	%rbp, %r12
	adcq	%rbx, %r15
	adcq	$0, %rsi
	addq	%rdx, %r12
	adcq	%r9, %r15
	adcq	%r8, %rsi
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rbx
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %rbx
	addq	%r9, %rbx
	adcq	%r8, %rcx
	adcq	$0, %rbp
	addq	%r12, %r10
	adcq	%r15, %rbx
	adcq	%rsi, %rcx
	adcq	$0, %rbp
	imulq	%r10, %r14
	movq	%r14, %rax
	movq	-56(%rsp), %r15         ## 8-byte Reload
	mulq	%r15
	movq	%rdx, %r8
	movq	%rax, %rsi
	movq	%r14, %rax
	movq	%rdi, %r12
	mulq	%r12
	movq	%rdx, %r9
	movq	%rax, %rdi
	movq	%r14, %rax
	mulq	%r11
	addq	%r10, %rax
	adcq	%rbx, %rdi
	adcq	%rcx, %rsi
	adcq	$0, %rbp
	addq	%rdx, %rdi
	adcq	%r9, %rsi
	adcq	%r8, %rbp
	movq	%rdi, %rax
	subq	%r11, %rax
	movq	%rsi, %rcx
	sbbq	%r12, %rcx
	movq	%rbp, %rbx
	sbbq	%r15, %rbx
	movq	%rbx, %rdx
	sarq	$63, %rdx
	cmovsq	%rdi, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovsq	%rsi, %rcx
	movq	%rcx, 8(%rdx)
	cmovsq	%rbp, %rbx
	movq	%rbx, 16(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed3L
	.p2align	4, 0x90
_mcl_fp_montRed3L:                      ## @mcl_fp_montRed3L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	-8(%rcx), %r9
	movq	(%rcx), %rdi
	movq	(%rsi), %r15
	movq	%r15, %rbx
	imulq	%r9, %rbx
	movq	16(%rcx), %rbp
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rbp, -24(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	%rdx, %r8
	movq	8(%rcx), %rcx
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rcx, %r12
	movq	%r12, -32(%rsp)         ## 8-byte Spill
	movq	%rdx, %r10
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdi, %rbx
	movq	%rbx, -16(%rsp)         ## 8-byte Spill
	movq	%rdx, %rcx
	addq	%r14, %rcx
	adcq	%r11, %r10
	adcq	$0, %r8
	movq	40(%rsi), %rdi
	movq	32(%rsi), %r13
	addq	%r15, %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r8
	adcq	$0, %r13
	adcq	$0, %rdi
	sbbq	%r15, %r15
	andl	$1, %r15d
	movq	%rcx, %rsi
	imulq	%r9, %rsi
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, %r11
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	%r12
	movq	%rdx, %r14
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rdx, %rbx
	addq	%r12, %rbx
	adcq	%rbp, %r14
	adcq	$0, %r11
	addq	%rcx, %rax
	adcq	%r10, %rbx
	adcq	%r8, %r14
	adcq	%r13, %r11
	adcq	$0, %rdi
	adcq	$0, %r15
	imulq	%rbx, %r9
	movq	%r9, %rax
	movq	-24(%rsp), %r12         ## 8-byte Reload
	mulq	%r12
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%r9, %rax
	movq	-32(%rsp), %r13         ## 8-byte Reload
	mulq	%r13
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%r9, %rax
	movq	-16(%rsp), %rcx         ## 8-byte Reload
	mulq	%rcx
	addq	%r10, %rdx
	adcq	%r8, %rsi
	adcq	$0, %rbp
	addq	%rbx, %rax
	adcq	%r14, %rdx
	adcq	%r11, %rsi
	adcq	%rdi, %rbp
	adcq	$0, %r15
	movq	%rdx, %rax
	subq	%rcx, %rax
	movq	%rsi, %rdi
	sbbq	%r13, %rdi
	movq	%rbp, %rcx
	sbbq	%r12, %rcx
	sbbq	$0, %r15
	andl	$1, %r15d
	cmovneq	%rbp, %rcx
	testb	%r15b, %r15b
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rsi, %rdi
	movq	%rdi, 8(%rdx)
	movq	%rcx, 16(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre3L
	.p2align	4, 0x90
_mcl_fp_addPre3L:                       ## @mcl_fp_addPre3L
## BB#0:
	movq	16(%rdx), %rax
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rax, 16(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_subPre3L
	.p2align	4, 0x90
_mcl_fp_subPre3L:                       ## @mcl_fp_subPre3L
## BB#0:
	movq	16(%rsi), %r8
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r8
	movq	%rcx, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r8, 16(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_shr1_3L
	.p2align	4, 0x90
_mcl_fp_shr1_3L:                        ## @mcl_fp_shr1_3L
## BB#0:
	movq	16(%rsi), %rax
	movq	(%rsi), %rcx
	movq	8(%rsi), %rdx
	shrdq	$1, %rdx, %rcx
	movq	%rcx, (%rdi)
	shrdq	$1, %rax, %rdx
	movq	%rdx, 8(%rdi)
	shrq	%rax
	movq	%rax, 16(%rdi)
	retq

	.globl	_mcl_fp_add3L
	.p2align	4, 0x90
_mcl_fp_add3L:                          ## @mcl_fp_add3L
## BB#0:
	movq	16(%rdx), %r8
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r8
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r8, 16(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %rax
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %r8
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB44_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r8, 16(%rdi)
LBB44_2:                                ## %carry
	retq

	.globl	_mcl_fp_addNF3L
	.p2align	4, 0x90
_mcl_fp_addNF3L:                        ## @mcl_fp_addNF3L
## BB#0:
	movq	16(%rdx), %r8
	movq	(%rdx), %r10
	movq	8(%rdx), %r9
	addq	(%rsi), %r10
	adcq	8(%rsi), %r9
	adcq	16(%rsi), %r8
	movq	%r10, %rsi
	subq	(%rcx), %rsi
	movq	%r9, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r8, %rax
	sbbq	16(%rcx), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	cmovsq	%r10, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	cmovsq	%r8, %rax
	movq	%rax, 16(%rdi)
	retq

	.globl	_mcl_fp_sub3L
	.p2align	4, 0x90
_mcl_fp_sub3L:                          ## @mcl_fp_sub3L
## BB#0:
	movq	16(%rsi), %r8
	movq	(%rsi), %rax
	movq	8(%rsi), %r9
	xorl	%esi, %esi
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r9
	sbbq	16(%rdx), %r8
	movq	%rax, (%rdi)
	movq	%r9, 8(%rdi)
	movq	%r8, 16(%rdi)
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB46_2
## BB#1:                                ## %nocarry
	retq
LBB46_2:                                ## %carry
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rsi
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r8, %rsi
	movq	%rsi, 16(%rdi)
	retq

	.globl	_mcl_fp_subNF3L
	.p2align	4, 0x90
_mcl_fp_subNF3L:                        ## @mcl_fp_subNF3L
## BB#0:
	movq	16(%rsi), %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	subq	(%rdx), %r8
	sbbq	8(%rdx), %r9
	sbbq	16(%rdx), %r10
	movq	%r10, %rdx
	sarq	$63, %rdx
	movq	%rdx, %rsi
	shldq	$1, %r10, %rsi
	andq	(%rcx), %rsi
	movq	16(%rcx), %rax
	andq	%rdx, %rax
	andq	8(%rcx), %rdx
	addq	%r8, %rsi
	movq	%rsi, (%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r10, %rax
	movq	%rax, 16(%rdi)
	retq

	.globl	_mcl_fpDbl_add3L
	.p2align	4, 0x90
_mcl_fpDbl_add3L:                       ## @mcl_fpDbl_add3L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	40(%rdx), %r10
	movq	40(%rsi), %r8
	movq	32(%rdx), %r11
	movq	24(%rdx), %r14
	movq	24(%rsi), %r15
	movq	32(%rsi), %r9
	movq	16(%rdx), %rbx
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rbx, 16(%rdi)
	adcq	%r14, %r15
	adcq	%r11, %r9
	adcq	%r10, %r8
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%r15, %rdx
	subq	(%rcx), %rdx
	movq	%r9, %rsi
	sbbq	8(%rcx), %rsi
	movq	%r8, %rbx
	sbbq	16(%rcx), %rbx
	sbbq	$0, %rax
	andl	$1, %eax
	cmovneq	%r15, %rdx
	movq	%rdx, 24(%rdi)
	testb	%al, %al
	cmovneq	%r9, %rsi
	movq	%rsi, 32(%rdi)
	cmovneq	%r8, %rbx
	movq	%rbx, 40(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fpDbl_sub3L
	.p2align	4, 0x90
_mcl_fpDbl_sub3L:                       ## @mcl_fpDbl_sub3L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r10
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %r11
	movq	16(%rsi), %r14
	movq	(%rsi), %rbx
	movq	8(%rsi), %rax
	xorl	%esi, %esi
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %rax
	movq	24(%rdx), %r15
	movq	32(%rdx), %r12
	sbbq	16(%rdx), %r14
	movq	%rbx, (%rdi)
	movq	%rax, 8(%rdi)
	movq	%r14, 16(%rdi)
	sbbq	%r15, %r11
	sbbq	%r12, %r9
	sbbq	%r10, %r8
	movl	$0, %eax
	sbbq	$0, %rax
	andl	$1, %eax
	movq	(%rcx), %rdx
	cmoveq	%rsi, %rdx
	testb	%al, %al
	movq	16(%rcx), %rax
	cmoveq	%rsi, %rax
	cmovneq	8(%rcx), %rsi
	addq	%r11, %rdx
	movq	%rdx, 24(%rdi)
	adcq	%r9, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r8, %rax
	movq	%rax, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_mulUnitPre4L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre4L:                   ## @mcl_fp_mulUnitPre4L
## BB#0:
	pushq	%r14
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%r14, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r11, %rbx
	movq	%rbx, 16(%rdi)
	adcq	%r9, %r10
	movq	%r10, 24(%rdi)
	adcq	$0, %r8
	movq	%r8, 32(%rdi)
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fpDbl_mulPre4L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre4L:                    ## @mcl_fpDbl_mulPre4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %r8
	movq	%r8, -56(%rsp)          ## 8-byte Spill
	movq	(%rdx), %rbx
	movq	%rdx, %rbp
	mulq	%rbx
	movq	%rdx, %r15
	movq	16(%rsi), %rcx
	movq	24(%rsi), %r11
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %r12
	movq	%rax, %r14
	movq	%rcx, %rax
	movq	%rcx, -16(%rsp)         ## 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r10
	movq	%rax, %r9
	movq	%r8, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %r8
	addq	%r15, %r8
	adcq	%r9, %r13
	adcq	%r14, %r10
	adcq	$0, %r12
	movq	%rbp, %r9
	movq	%r9, -8(%rsp)           ## 8-byte Spill
	movq	8(%r9), %rbp
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	%rbp
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, %rcx
	movq	-56(%rsp), %r14         ## 8-byte Reload
	movq	%r14, %rax
	mulq	%rbp
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	addq	%r8, %rax
	movq	%rax, 8(%rdi)
	adcq	%r13, %rbx
	adcq	%r10, %rcx
	adcq	%r12, %r15
	sbbq	%r13, %r13
	movq	16(%r9), %rbp
	movq	%r14, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r14
	andl	$1, %r13d
	addq	-48(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-40(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	-32(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-24(%rsp), %r13         ## 8-byte Folded Reload
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	-16(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	addq	%rbx, %rax
	movq	%rax, 16(%rdi)
	adcq	%r12, %rcx
	adcq	%r15, %r10
	adcq	%r13, %r11
	sbbq	%r13, %r13
	andl	$1, %r13d
	addq	%rdx, %rcx
	adcq	%r14, %r10
	adcq	%r9, %r11
	adcq	%r8, %r13
	movq	-8(%rsp), %rax          ## 8-byte Reload
	movq	24(%rax), %rbx
	movq	%rbx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	8(%rsi)
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	(%rsi)
	addq	%rcx, %rax
	movq	%rax, 24(%rdi)
	adcq	%r10, %rbp
	adcq	%r11, %r12
	adcq	%r13, %r14
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rdx, %rbp
	movq	%rbp, 32(%rdi)
	adcq	%r15, %r12
	movq	%r12, 40(%rdi)
	adcq	%r9, %r14
	movq	%r14, 48(%rdi)
	adcq	%r8, %rax
	movq	%rax, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre4L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre4L:                    ## @mcl_fpDbl_sqrPre4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r10
	movq	16(%r10), %r9
	movq	24(%r10), %r11
	movq	(%r10), %r15
	movq	8(%r10), %r8
	movq	%r15, %rax
	mulq	%r15
	movq	%rdx, %rbp
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	%r8
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%r9, %rax
	mulq	%r8
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	%r11, %rax
	mulq	%r15
	movq	%rdx, %rbx
	movq	%rax, %rcx
	movq	%r9, %rax
	mulq	%r15
	movq	%rdx, %rsi
	movq	%rsi, -16(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	%r8, %rax
	mulq	%r8
	movq	%rdx, %r13
	movq	%rax, %r14
	movq	%r8, %rax
	mulq	%r15
	addq	%rax, %rbp
	movq	%rdx, %r8
	adcq	%r12, %r8
	adcq	%rsi, %rcx
	adcq	$0, %rbx
	addq	%rax, %rbp
	movq	%rbp, 8(%rdi)
	adcq	%r14, %r8
	movq	-40(%rsp), %rsi         ## 8-byte Reload
	adcq	%rsi, %rcx
	adcq	-32(%rsp), %rbx         ## 8-byte Folded Reload
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	addq	%rdx, %r8
	adcq	%r13, %rcx
	movq	-24(%rsp), %r15         ## 8-byte Reload
	adcq	%r15, %rbx
	adcq	-8(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%r11, %rax
	mulq	%r9
	movq	%rdx, %r14
	movq	%rax, %r11
	movq	%r9, %rax
	mulq	%r9
	movq	%rax, %r9
	addq	%r12, %r8
	movq	%r8, 16(%rdi)
	adcq	%rsi, %rcx
	adcq	%rbx, %r9
	adcq	%rbp, %r11
	sbbq	%r12, %r12
	andl	$1, %r12d
	addq	-16(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	%r15, %r9
	adcq	%rdx, %r11
	adcq	%r14, %r12
	movq	24(%r10), %rbp
	movq	%rbp, %rax
	mulq	16(%r10)
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	8(%r10)
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	(%r10)
	movq	%rdx, %r15
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rbp
	addq	%rcx, %rsi
	movq	%rsi, 24(%rdi)
	adcq	%r9, %rbx
	adcq	%r11, %r14
	adcq	%r12, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%r15, %rbx
	movq	%rbx, 32(%rdi)
	adcq	%r13, %r14
	movq	%r14, 40(%rdi)
	adcq	%r8, %rax
	movq	%rax, 48(%rdi)
	adcq	%rdx, %rcx
	movq	%rcx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont4L
	.p2align	4, 0x90
_mcl_fp_mont4L:                         ## @mcl_fp_mont4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rbp
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r8
	movq	16(%rsi), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rax, %rbx
	movq	%rdx, %r11
	movq	(%rsi), %rdi
	movq	%rdi, -56(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rdx, %r12
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%rdx, %r15
	addq	%rsi, %r15
	adcq	%rbx, %r12
	adcq	%r9, %r11
	adcq	$0, %r8
	movq	-8(%rcx), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r13, %rsi
	imulq	%rax, %rsi
	movq	24(%rcx), %rdx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r10
	movq	%rdx, %r9
	movq	16(%rcx), %rdx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, %rbx
	movq	(%rcx), %rbp
	movq	%rbp, -24(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -32(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, %rcx
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, %rsi
	addq	%rcx, %rsi
	adcq	%r14, %rdi
	adcq	%r10, %rbx
	adcq	$0, %r9
	addq	%r13, %rax
	adcq	%r15, %rsi
	adcq	%r12, %rdi
	adcq	%r11, %rbx
	adcq	%r8, %r9
	sbbq	%r15, %r15
	andl	$1, %r15d
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rbp
	movq	%rbp, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r10
	movq	%rbp, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %rbp
	addq	%r14, %rbp
	adcq	%r11, %rcx
	adcq	%r10, %r13
	adcq	$0, %r12
	addq	%rsi, %r8
	adcq	%rdi, %rbp
	adcq	%rbx, %rcx
	adcq	%r9, %r13
	adcq	%r15, %r12
	sbbq	%r15, %r15
	andl	$1, %r15d
	movq	%r8, %rsi
	imulq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	addq	%r14, %rsi
	adcq	%r11, %rdi
	adcq	%r10, %rbx
	adcq	$0, %r9
	addq	%r8, %rax
	adcq	%rbp, %rsi
	adcq	%rcx, %rdi
	adcq	%r13, %rbx
	adcq	%r12, %r9
	adcq	$0, %r15
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rbp
	movq	%rbp, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r10
	movq	%rbp, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %r8
	addq	%r14, %r8
	adcq	%r11, %rcx
	adcq	%r10, %r13
	adcq	$0, %r12
	addq	%rsi, %rbp
	adcq	%rdi, %r8
	adcq	%rbx, %rcx
	adcq	%r9, %r13
	adcq	%r15, %r12
	sbbq	%r14, %r14
	movq	%rbp, %rsi
	imulq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	andl	$1, %r14d
	addq	%r15, %r11
	adcq	%r10, %r9
	adcq	-16(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	$0, %rdi
	addq	%rbp, %rax
	adcq	%r8, %r11
	adcq	%rcx, %r9
	adcq	%r13, %rbx
	adcq	%r12, %rdi
	adcq	$0, %r14
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rcx
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %rbp
	addq	%r13, %rbp
	adcq	%r15, %rsi
	adcq	-96(%rsp), %r12         ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	%r11, %r10
	adcq	%r9, %rbp
	adcq	%rbx, %rsi
	adcq	%rdi, %r12
	adcq	%r14, %r8
	sbbq	%rdi, %rdi
	andl	$1, %edi
	movq	-88(%rsp), %rcx         ## 8-byte Reload
	imulq	%r10, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %rbx
	movq	%rcx, %rax
	movq	%rcx, %r9
	movq	-32(%rsp), %r11         ## 8-byte Reload
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%r9, %rax
	movq	-24(%rsp), %r9          ## 8-byte Reload
	mulq	%r9
	addq	%r14, %rdx
	adcq	%rbx, %rcx
	adcq	-88(%rsp), %r15         ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%r10, %rax
	adcq	%rbp, %rdx
	adcq	%rsi, %rcx
	adcq	%r12, %r15
	adcq	%r8, %r13
	adcq	$0, %rdi
	movq	%rdx, %rax
	subq	%r9, %rax
	movq	%rcx, %rsi
	sbbq	%r11, %rsi
	movq	%r15, %rbp
	sbbq	-80(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%r13, %rbx
	sbbq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	sbbq	$0, %rdi
	andl	$1, %edi
	cmovneq	%r13, %rbx
	testb	%dil, %dil
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rcx, %rsi
	movq	%rsi, 8(%rdx)
	cmovneq	%r15, %rbp
	movq	%rbp, 16(%rdx)
	movq	%rbx, 24(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF4L
	.p2align	4, 0x90
_mcl_fp_montNF4L:                       ## @mcl_fp_montNF4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r15
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	(%r15), %rdi
	movq	%r15, -24(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, %r12
	movq	16(%rsi), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r10
	movq	(%rsi), %rbp
	movq	%rbp, -56(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %rbx
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, %r9
	addq	%rsi, %r9
	adcq	%r14, %rbx
	adcq	%r8, %r10
	adcq	$0, %r12
	movq	-8(%rcx), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%r11, %rsi
	imulq	%rax, %rsi
	movq	24(%rcx), %rdx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r13
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r8
	movq	%rdx, %r14
	movq	(%rcx), %rdi
	movq	%rdi, -72(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -32(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	%rdi
	addq	%r11, %rax
	adcq	%r9, %rbp
	adcq	%rbx, %r8
	adcq	%r10, %r13
	adcq	$0, %r12
	addq	%rdx, %rbp
	adcq	%rcx, %r8
	adcq	%r14, %r13
	adcq	-16(%rsp), %r12         ## 8-byte Folded Reload
	movq	8(%r15), %rdi
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %rdi
	movq	%rdx, %r9
	addq	%r14, %r9
	adcq	%r11, %rcx
	adcq	%rsi, %r10
	adcq	$0, %rbx
	addq	%rbp, %rdi
	adcq	%r8, %r9
	adcq	%r13, %rcx
	adcq	%r12, %r10
	adcq	$0, %rbx
	movq	%rdi, %rsi
	imulq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r13
	movq	%rsi, %rax
	movq	-32(%rsp), %r15         ## 8-byte Reload
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%r9, %rbp
	adcq	%rcx, %r13
	adcq	%r10, %r12
	adcq	$0, %rbx
	addq	%rdx, %rbp
	adcq	%r14, %r13
	adcq	%r11, %r12
	adcq	%r8, %rbx
	movq	-24(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rdi
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rdi
	addq	%r14, %rdi
	adcq	%r11, %rcx
	adcq	%r10, %r8
	adcq	$0, %rsi
	addq	%rbp, %r9
	adcq	%r13, %rdi
	adcq	%r12, %rcx
	adcq	%rbx, %r8
	adcq	$0, %rsi
	movq	%r9, %rbx
	imulq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	%r15
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	addq	%r9, %rax
	adcq	%rdi, %rbp
	adcq	%rcx, %r13
	adcq	%r8, %r12
	adcq	$0, %rsi
	addq	%rdx, %rbp
	adcq	%r14, %r13
	adcq	%r11, %r12
	adcq	%r10, %rsi
	movq	-24(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rdi
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rcx
	movq	%rdi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rdi
	addq	%r14, %rdi
	adcq	%r11, %r10
	adcq	%rcx, %r8
	adcq	$0, %rbx
	addq	%rbp, %r9
	adcq	%r13, %rdi
	adcq	%r12, %r10
	adcq	%rsi, %r8
	adcq	$0, %rbx
	movq	-80(%rsp), %rcx         ## 8-byte Reload
	imulq	%r9, %rcx
	movq	%rcx, %rax
	movq	-40(%rsp), %r12         ## 8-byte Reload
	mulq	%r12
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r13
	movq	%rcx, %rax
	movq	-48(%rsp), %r11         ## 8-byte Reload
	mulq	%r11
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%rcx, %rax
	movq	%rcx, %r15
	movq	-72(%rsp), %rsi         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %rcx
	movq	%r15, %rax
	movq	-32(%rsp), %r15         ## 8-byte Reload
	mulq	%r15
	addq	%r9, %rcx
	adcq	%rdi, %rax
	adcq	%r10, %rbp
	adcq	%r8, %r13
	adcq	$0, %rbx
	addq	%r14, %rax
	adcq	%rdx, %rbp
	adcq	-96(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rax, %rcx
	subq	%rsi, %rcx
	movq	%rbp, %rdx
	sbbq	%r15, %rdx
	movq	%r13, %rdi
	sbbq	%r11, %rdi
	movq	%rbx, %rsi
	sbbq	%r12, %rsi
	cmovsq	%rax, %rcx
	movq	-8(%rsp), %rax          ## 8-byte Reload
	movq	%rcx, (%rax)
	cmovsq	%rbp, %rdx
	movq	%rdx, 8(%rax)
	cmovsq	%r13, %rdi
	movq	%rdi, 16(%rax)
	cmovsq	%rbx, %rsi
	movq	%rsi, 24(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed4L
	.p2align	4, 0x90
_mcl_fp_montRed4L:                      ## @mcl_fp_montRed4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	-8(%rcx), %rax
	movq	(%rcx), %rdi
	movq	%rdi, -32(%rsp)         ## 8-byte Spill
	movq	(%rsi), %r12
	movq	%r12, %rbx
	imulq	%rax, %rbx
	movq	%rax, %r9
	movq	%r9, -64(%rsp)          ## 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r11
	movq	%rdx, %r8
	movq	16(%rcx), %rbp
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rbp, %r13
	movq	%r13, -24(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	%rdx, %r10
	movq	8(%rcx), %rcx
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rcx, %rbp
	movq	%rbp, -16(%rsp)         ## 8-byte Spill
	movq	%rdx, %r15
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, %rbx
	addq	%rcx, %rbx
	adcq	%r14, %r15
	adcq	%r11, %r10
	adcq	$0, %r8
	movq	56(%rsi), %rcx
	movq	48(%rsi), %rdx
	addq	%r12, %rax
	movq	40(%rsi), %rax
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %r10
	adcq	32(%rsi), %r8
	adcq	$0, %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	adcq	$0, %rdx
	movq	%rdx, %r12
	adcq	$0, %rcx
	movq	%rcx, -72(%rsp)         ## 8-byte Spill
	sbbq	%rdi, %rdi
	andl	$1, %edi
	movq	%rbx, %rsi
	imulq	%r9, %rsi
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%r13
	movq	%rdx, %r14
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%rsi, %rax
	movq	-32(%rsp), %r13         ## 8-byte Reload
	mulq	%r13
	movq	%rdx, %rsi
	addq	%rbp, %rsi
	adcq	%r9, %rcx
	adcq	-56(%rsp), %r14         ## 8-byte Folded Reload
	adcq	$0, %r11
	addq	%rbx, %rax
	adcq	%r15, %rsi
	adcq	%r10, %rcx
	adcq	%r8, %r14
	adcq	-48(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, %r12
	movq	%r12, -48(%rsp)         ## 8-byte Spill
	movq	-72(%rsp), %rbp         ## 8-byte Reload
	adcq	$0, %rbp
	adcq	$0, %rdi
	movq	%rsi, %rbx
	imulq	-64(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	movq	-40(%rsp), %r12         ## 8-byte Reload
	mulq	%r12
	movq	%rdx, %r8
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %rbx
	addq	%r9, %rbx
	adcq	-56(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r10         ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	%rsi, %rax
	adcq	%rcx, %rbx
	adcq	%r14, %r15
	adcq	%r11, %r10
	adcq	-48(%rsp), %r8          ## 8-byte Folded Reload
	adcq	$0, %rbp
	movq	%rbp, -72(%rsp)         ## 8-byte Spill
	adcq	$0, %rdi
	movq	-64(%rsp), %rcx         ## 8-byte Reload
	imulq	%rbx, %rcx
	movq	%rcx, %rax
	mulq	%r12
	movq	%rdx, %r13
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	movq	-24(%rsp), %r14         ## 8-byte Reload
	mulq	%r14
	movq	%rdx, %r11
	movq	%rax, %r12
	movq	%rcx, %rax
	movq	%rcx, %r9
	movq	-16(%rsp), %rsi         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbp
	movq	%rax, %rcx
	movq	%r9, %rax
	movq	-32(%rsp), %r9          ## 8-byte Reload
	mulq	%r9
	addq	%rcx, %rdx
	adcq	%r12, %rbp
	adcq	-64(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%rbx, %rax
	adcq	%r15, %rdx
	adcq	%r10, %rbp
	adcq	%r8, %r11
	adcq	-72(%rsp), %r13         ## 8-byte Folded Reload
	adcq	$0, %rdi
	movq	%rdx, %rax
	subq	%r9, %rax
	movq	%rbp, %rcx
	sbbq	%rsi, %rcx
	movq	%r11, %rbx
	sbbq	%r14, %rbx
	movq	%r13, %rsi
	sbbq	-40(%rsp), %rsi         ## 8-byte Folded Reload
	sbbq	$0, %rdi
	andl	$1, %edi
	cmovneq	%r13, %rsi
	testb	%dil, %dil
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rbp, %rcx
	movq	%rcx, 8(%rdx)
	cmovneq	%r11, %rbx
	movq	%rbx, 16(%rdx)
	movq	%rsi, 24(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre4L
	.p2align	4, 0x90
_mcl_fp_addPre4L:                       ## @mcl_fp_addPre4L
## BB#0:
	movq	24(%rdx), %r8
	movq	24(%rsi), %r9
	movq	16(%rdx), %rax
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rax, 16(%rdi)
	adcq	%r8, %r9
	movq	%r9, 24(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_subPre4L
	.p2align	4, 0x90
_mcl_fp_subPre4L:                       ## @mcl_fp_subPre4L
## BB#0:
	movq	24(%rdx), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	movq	%rcx, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r10, 16(%rdi)
	sbbq	%r8, %r9
	movq	%r9, 24(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_shr1_4L
	.p2align	4, 0x90
_mcl_fp_shr1_4L:                        ## @mcl_fp_shr1_4L
## BB#0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %rdx
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rdx
	movq	%rdx, (%rdi)
	shrdq	$1, %rcx, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rax, %rcx
	movq	%rcx, 16(%rdi)
	shrq	%rax
	movq	%rax, 24(%rdi)
	retq

	.globl	_mcl_fp_add4L
	.p2align	4, 0x90
_mcl_fp_add4L:                          ## @mcl_fp_add4L
## BB#0:
	movq	24(%rdx), %r10
	movq	24(%rsi), %r8
	movq	16(%rdx), %r9
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r9
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r9, 16(%rdi)
	adcq	%r10, %r8
	movq	%r8, 24(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %rax
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %r9
	sbbq	24(%rcx), %r8
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB59_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r9, 16(%rdi)
	movq	%r8, 24(%rdi)
LBB59_2:                                ## %carry
	retq

	.globl	_mcl_fp_addNF4L
	.p2align	4, 0x90
_mcl_fp_addNF4L:                        ## @mcl_fp_addNF4L
## BB#0:
	pushq	%rbx
	movq	24(%rdx), %r8
	movq	16(%rdx), %r9
	movq	(%rdx), %r11
	movq	8(%rdx), %r10
	addq	(%rsi), %r11
	adcq	8(%rsi), %r10
	adcq	16(%rsi), %r9
	adcq	24(%rsi), %r8
	movq	%r11, %rsi
	subq	(%rcx), %rsi
	movq	%r10, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r9, %rax
	sbbq	16(%rcx), %rax
	movq	%r8, %rbx
	sbbq	24(%rcx), %rbx
	testq	%rbx, %rbx
	cmovsq	%r11, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r10, %rdx
	movq	%rdx, 8(%rdi)
	cmovsq	%r9, %rax
	movq	%rax, 16(%rdi)
	cmovsq	%r8, %rbx
	movq	%rbx, 24(%rdi)
	popq	%rbx
	retq

	.globl	_mcl_fp_sub4L
	.p2align	4, 0x90
_mcl_fp_sub4L:                          ## @mcl_fp_sub4L
## BB#0:
	movq	24(%rdx), %r10
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rax
	movq	8(%rsi), %r11
	xorl	%esi, %esi
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r11
	sbbq	16(%rdx), %r9
	movq	%rax, (%rdi)
	movq	%r11, 8(%rdi)
	movq	%r9, 16(%rdi)
	sbbq	%r10, %r8
	movq	%r8, 24(%rdi)
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB61_2
## BB#1:                                ## %nocarry
	retq
LBB61_2:                                ## %carry
	movq	24(%rcx), %r10
	movq	8(%rcx), %rsi
	movq	16(%rcx), %rdx
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%r11, %rsi
	movq	%rsi, 8(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r8, %r10
	movq	%r10, 24(%rdi)
	retq

	.globl	_mcl_fp_subNF4L
	.p2align	4, 0x90
_mcl_fp_subNF4L:                        ## @mcl_fp_subNF4L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movdqu	(%rdx), %xmm0
	movdqu	16(%rdx), %xmm1
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %r8
	movdqu	(%rsi), %xmm2
	movdqu	16(%rsi), %xmm3
	pshufd	$78, %xmm3, %xmm4       ## xmm4 = xmm3[2,3,0,1]
	movd	%xmm4, %r15
	movd	%xmm1, %r9
	movd	%xmm3, %r11
	pshufd	$78, %xmm0, %xmm1       ## xmm1 = xmm0[2,3,0,1]
	movd	%xmm1, %r10
	pshufd	$78, %xmm2, %xmm1       ## xmm1 = xmm2[2,3,0,1]
	movd	%xmm1, %r14
	movd	%xmm0, %rdx
	movd	%xmm2, %r12
	subq	%rdx, %r12
	sbbq	%r10, %r14
	sbbq	%r9, %r11
	sbbq	%r8, %r15
	movq	%r15, %rdx
	sarq	$63, %rdx
	movq	24(%rcx), %rsi
	andq	%rdx, %rsi
	movq	16(%rcx), %rax
	andq	%rdx, %rax
	movq	8(%rcx), %rbx
	andq	%rdx, %rbx
	andq	(%rcx), %rdx
	addq	%r12, %rdx
	movq	%rdx, (%rdi)
	adcq	%r14, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r11, %rax
	movq	%rax, 16(%rdi)
	adcq	%r15, %rsi
	movq	%rsi, 24(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fpDbl_add4L
	.p2align	4, 0x90
_mcl_fpDbl_add4L:                       ## @mcl_fpDbl_add4L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r9
	movq	56(%rsi), %r8
	movq	48(%rdx), %r10
	movq	48(%rsi), %r12
	movq	40(%rdx), %r11
	movq	32(%rdx), %r14
	movq	24(%rdx), %r15
	movq	16(%rdx), %rbx
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	movq	40(%rsi), %r13
	movq	24(%rsi), %rbp
	movq	32(%rsi), %rsi
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rbx, 16(%rdi)
	adcq	%r15, %rbp
	movq	%rbp, 24(%rdi)
	adcq	%r14, %rsi
	adcq	%r11, %r13
	adcq	%r10, %r12
	adcq	%r9, %r8
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rsi, %rdx
	subq	(%rcx), %rdx
	movq	%r13, %rbp
	sbbq	8(%rcx), %rbp
	movq	%r12, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r8, %r9
	sbbq	24(%rcx), %r9
	sbbq	$0, %rax
	andl	$1, %eax
	cmovneq	%rsi, %rdx
	movq	%rdx, 32(%rdi)
	testb	%al, %al
	cmovneq	%r13, %rbp
	movq	%rbp, 40(%rdi)
	cmovneq	%r12, %rbx
	movq	%rbx, 48(%rdi)
	cmovneq	%r8, %r9
	movq	%r9, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub4L
	.p2align	4, 0x90
_mcl_fpDbl_sub4L:                       ## @mcl_fpDbl_sub4L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r9
	movq	56(%rsi), %r8
	movq	48(%rdx), %r10
	movq	24(%rdx), %r11
	movq	(%rsi), %rbx
	xorl	%eax, %eax
	subq	(%rdx), %rbx
	movq	%rbx, (%rdi)
	movq	8(%rsi), %rbx
	sbbq	8(%rdx), %rbx
	movq	%rbx, 8(%rdi)
	movq	16(%rsi), %rbx
	sbbq	16(%rdx), %rbx
	movq	%rbx, 16(%rdi)
	movq	24(%rsi), %rbx
	sbbq	%r11, %rbx
	movq	40(%rdx), %r11
	movq	32(%rdx), %rdx
	movq	%rbx, 24(%rdi)
	movq	32(%rsi), %r12
	sbbq	%rdx, %r12
	movq	48(%rsi), %r14
	movq	40(%rsi), %r15
	sbbq	%r11, %r15
	sbbq	%r10, %r14
	sbbq	%r9, %r8
	movl	$0, %edx
	sbbq	$0, %rdx
	andl	$1, %edx
	movq	(%rcx), %rsi
	cmoveq	%rax, %rsi
	testb	%dl, %dl
	movq	16(%rcx), %rdx
	cmoveq	%rax, %rdx
	movq	24(%rcx), %rbx
	cmoveq	%rax, %rbx
	cmovneq	8(%rcx), %rax
	addq	%r12, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r15, %rax
	movq	%rax, 40(%rdi)
	adcq	%r14, %rdx
	movq	%rdx, 48(%rdi)
	adcq	%r8, %rbx
	movq	%rbx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_mulUnitPre5L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre5L:                   ## @mcl_fp_mulUnitPre5L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	32(%rsi)
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r15
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%r12, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r14, %rbx
	movq	%rbx, 16(%rdi)
	adcq	%r11, %r15
	movq	%r15, 24(%rdi)
	adcq	%r9, %r10
	movq	%r10, 32(%rdi)
	adcq	$0, %r8
	movq	%r8, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fpDbl_mulPre5L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre5L:                    ## @mcl_fpDbl_mulPre5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rsi, %r9
	movq	%rdi, -48(%rsp)         ## 8-byte Spill
	movq	(%r9), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rbp
	mulq	%rbp
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	16(%r9), %r13
	movq	24(%r9), %r15
	movq	32(%r9), %rbx
	movq	%rax, (%rdi)
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rdx, %r11
	movq	%rax, %r10
	movq	%r15, %rax
	mulq	%rbp
	movq	%rdx, %r14
	movq	%rax, %rdi
	movq	%r13, %rax
	mulq	%rbp
	movq	%rax, %rsi
	movq	%rdx, %rcx
	movq	8(%r9), %r8
	movq	%r8, %rax
	mulq	%rbp
	movq	%rdx, %rbp
	movq	%rax, %r12
	addq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	%rsi, %rbp
	adcq	%rdi, %rcx
	adcq	%r10, %r14
	adcq	$0, %r11
	movq	-72(%rsp), %r10         ## 8-byte Reload
	movq	8(%r10), %rdi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %rsi
	movq	%r15, %rax
	mulq	%rdi
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%r13, %rax
	mulq	%rdi
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, %r13
	movq	%r8, %rax
	mulq	%rdi
	movq	%rdx, %r8
	movq	%rax, %rbx
	movq	-80(%rsp), %rax         ## 8-byte Reload
	mulq	%rdi
	addq	%r12, %rax
	movq	-48(%rsp), %rdi         ## 8-byte Reload
	movq	%rax, 8(%rdi)
	adcq	%rbp, %rbx
	adcq	%rcx, %r13
	adcq	%r14, %r15
	adcq	%r11, %rsi
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%rdx, %rbx
	adcq	%r8, %r13
	adcq	-56(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-96(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	movq	32(%r9), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	16(%r10), %r12
	mulq	%r12
	movq	%rax, %r11
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	24(%r9), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%r12
	movq	%rax, %r10
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	16(%r9), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%r12
	movq	%rax, %r8
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	8(%r9), %rdi
	movq	%rdi, %rax
	mulq	%r12
	movq	%rax, %rbp
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	(%r9), %r14
	movq	%r14, %rax
	mulq	%r12
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	addq	%rbx, %rax
	movq	-48(%rsp), %rbx         ## 8-byte Reload
	movq	%rax, 16(%rbx)
	adcq	%r13, %rbp
	adcq	%r15, %r8
	adcq	%rsi, %r10
	adcq	%rcx, %r11
	sbbq	%rsi, %rsi
	movq	-72(%rsp), %r12         ## 8-byte Reload
	movq	24(%r12), %rcx
	movq	-96(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rax, %r15
	movq	%r14, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	-32(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	andl	$1, %esi
	addq	-40(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-16(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-56(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	addq	%rdi, %rbp
	movq	%rbp, 24(%rbx)
	adcq	%r15, %r8
	adcq	%rax, %r10
	adcq	%r14, %r11
	adcq	-24(%rsp), %rsi         ## 8-byte Folded Reload
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%r13, %r8
	adcq	-8(%rsp), %r10          ## 8-byte Folded Reload
	adcq	%rdx, %r11
	adcq	-64(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-96(%rsp), %rcx         ## 8-byte Folded Reload
	movq	32(%r12), %rdi
	movq	%rdi, %rax
	mulq	32(%r9)
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	24(%r9)
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r13
	movq	%rdi, %rax
	mulq	16(%r9)
	movq	%rdx, %r14
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	8(%r9)
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	(%r9)
	addq	%r8, %rax
	movq	-48(%rsp), %rdi         ## 8-byte Reload
	movq	%rax, 32(%rdi)
	adcq	%r10, %rbp
	adcq	%r11, %rbx
	adcq	%rsi, %r13
	adcq	%rcx, %r15
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rdx, %rbp
	movq	%rbp, 40(%rdi)
	adcq	%r12, %rbx
	movq	%rbx, 48(%rdi)
	adcq	%r14, %r13
	movq	%r13, 56(%rdi)
	adcq	-80(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, 64(%rdi)
	adcq	-72(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre5L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre5L:                    ## @mcl_fpDbl_sqrPre5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	32(%rsi), %r11
	movq	(%rsi), %rbp
	movq	8(%rsi), %r13
	movq	%r11, %rax
	mulq	%r13
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	24(%rsi), %rbx
	movq	%rbx, %rax
	mulq	%r13
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %rcx
	movq	%rcx, %rax
	mulq	%r13
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%r11, %rax
	mulq	%rbp
	movq	%rdx, %r8
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	%rbp
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%r13, %rax
	mulq	%r13
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rax, %r14
	movq	%r13, %rax
	mulq	%rbp
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rdi, -24(%rsp)         ## 8-byte Spill
	movq	%rax, (%rdi)
	addq	%rbx, %rdx
	adcq	%r13, %r12
	adcq	%r15, %r10
	adcq	-16(%rsp), %r9          ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	%rbx, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r14, %r12
	adcq	-32(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-64(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-56(%rsp), %r8          ## 8-byte Folded Reload
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	addq	%r13, %r12
	adcq	-8(%rsp), %r10          ## 8-byte Folded Reload
	adcq	-48(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-72(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-40(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%r11, %rax
	mulq	%rcx
	movq	%rax, %r11
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	24(%rsi), %rbx
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rax, %r14
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r15
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rax, %r13
	addq	%r12, %rdi
	movq	-24(%rsp), %r12         ## 8-byte Reload
	movq	%rdi, 16(%r12)
	adcq	%r10, %r15
	adcq	%r9, %r13
	adcq	%r8, %r14
	adcq	%rbp, %r11
	sbbq	%rdi, %rdi
	andl	$1, %edi
	addq	-32(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-64(%rsp), %r13         ## 8-byte Folded Reload
	adcq	%rdx, %r14
	adcq	-72(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-40(%rsp), %rdi         ## 8-byte Folded Reload
	movq	-56(%rsp), %rax         ## 8-byte Reload
	mulq	%rbx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %r8
	movq	-48(%rsp), %rax         ## 8-byte Reload
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	32(%rsi), %rcx
	movq	%rcx, %rax
	mulq	%rbx
	movq	%rax, %r9
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	mulq	%rbx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rbx
	addq	%r15, %rbp
	movq	%rbp, 24(%r12)
	adcq	%r13, %r8
	adcq	%r14, %r10
	adcq	%r11, %rbx
	adcq	%rdi, %r9
	sbbq	%r12, %r12
	andl	$1, %r12d
	addq	-56(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-72(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-64(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	%rdx, %r9
	adcq	-48(%rsp), %r12         ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %r14
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	-40(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	addq	%r8, %rsi
	movq	-24(%rsp), %r8          ## 8-byte Reload
	movq	%rsi, 32(%r8)
	adcq	%r10, %rdi
	adcq	%rbx, %rax
	adcq	%r9, %rbp
	adcq	%r12, %r11
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%r13, %rdi
	movq	%r8, %rsi
	movq	%rdi, 40(%rsi)
	adcq	%r14, %rax
	movq	%rax, 48(%rsi)
	adcq	%rdx, %rbp
	movq	%rbp, 56(%rsi)
	adcq	-72(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r11, 64(%rsi)
	adcq	%r15, %rcx
	movq	%rcx, 72(%rsi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont5L
	.p2align	4, 0x90
_mcl_fp_mont5L:                         ## @mcl_fp_mont5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, (%rsp)            ## 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, %r15
	movq	24(%rsi), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, %rbx
	movq	16(%rsi), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, %r14
	movq	(%rsi), %rbp
	movq	%rbp, -24(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r12
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdx, %r9
	addq	%rsi, %r9
	adcq	%r11, %r12
	adcq	%r10, %r14
	adcq	%r8, %rbx
	movq	%rbx, -120(%rsp)        ## 8-byte Spill
	adcq	$0, %r15
	movq	%r15, -112(%rsp)        ## 8-byte Spill
	movq	-8(%rcx), %rdx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	imulq	%rdx, %rbp
	movq	32(%rcx), %rdx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, %r8
	movq	24(%rcx), %rdx
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r13
	movq	%rdx, %rsi
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r11
	movq	%rdx, %rbx
	movq	(%rcx), %rdi
	movq	%rdi, -16(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -64(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %r10
	movq	%rax, %r15
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, %rcx
	addq	%r15, %rcx
	adcq	%r11, %r10
	adcq	%r13, %rbx
	adcq	-8(%rsp), %rsi          ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	-128(%rsp), %rax        ## 8-byte Folded Reload
	adcq	%r9, %rcx
	adcq	%r12, %r10
	adcq	%r14, %rbx
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r8         ## 8-byte Folded Reload
	sbbq	%r15, %r15
	andl	$1, %r15d
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rdi
	movq	%rdi, %rax
	mulq	-104(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %rdi
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	-128(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-120(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%rcx, %rdi
	adcq	%r10, %r11
	adcq	%rbx, %r9
	adcq	%rsi, %rbp
	adcq	%r8, %r14
	adcq	%r15, %r13
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rdi, %rbx
	imulq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	addq	%r12, %rbx
	adcq	%r15, %rcx
	adcq	-128(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r8         ## 8-byte Folded Reload
	adcq	$0, %r10
	addq	%rdi, %rax
	adcq	%r11, %rbx
	adcq	%r9, %rcx
	adcq	%rbp, %rsi
	adcq	%r14, %r8
	adcq	%r13, %r10
	adcq	$0, -112(%rsp)          ## 8-byte Folded Spill
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rbp
	movq	%rbp, %rax
	mulq	-104(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r15
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	%r14, %rdi
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%rbx, %r15
	adcq	%rcx, %rbp
	adcq	%rsi, %rdi
	adcq	%r8, %r11
	adcq	%r10, %r9
	adcq	-112(%rsp), %r13        ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%r15, %rsi
	imulq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	addq	%r8, %r12
	adcq	-8(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	-128(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r14        ## 8-byte Folded Reload
	adcq	$0, %r10
	addq	%r15, %rax
	adcq	%rbp, %r12
	adcq	%rdi, %rbx
	adcq	%r11, %rcx
	adcq	%r9, %r14
	adcq	%r13, %r10
	adcq	$0, -112(%rsp)          ## 8-byte Folded Spill
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rsi
	movq	%rsi, %rax
	mulq	-104(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r13
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r11
	movq	%rdx, %rsi
	addq	%r13, %rsi
	adcq	%r15, %rdi
	adcq	-128(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	%r12, %r11
	adcq	%rbx, %rsi
	adcq	%rcx, %rdi
	adcq	%r14, %rbp
	adcq	%r10, %r9
	adcq	-112(%rsp), %r8         ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%r11, %rbx
	imulq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	addq	%r12, %rbx
	adcq	%r14, %rcx
	adcq	-128(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r10        ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%r11, %rax
	adcq	%rsi, %rbx
	adcq	%rdi, %rcx
	adcq	%rbp, %r15
	adcq	%r9, %r10
	adcq	%r8, %r13
	movq	-112(%rsp), %r8         ## 8-byte Reload
	adcq	$0, %r8
	movq	-96(%rsp), %rax         ## 8-byte Reload
	movq	32(%rax), %rsi
	movq	%rsi, %rax
	mulq	-104(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r14
	movq	%rdx, %rbp
	addq	%rdi, %rbp
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r9         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rbx, %r14
	adcq	%rcx, %rbp
	adcq	%r15, %r12
	adcq	%r10, %r11
	adcq	%r13, %r9
	adcq	%r8, %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rcx, %rcx
	movq	-72(%rsp), %rdi         ## 8-byte Reload
	imulq	%r14, %rdi
	movq	%rdi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%rdi, %rax
	movq	%rdi, %r15
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%r15, %rax
	movq	-16(%rsp), %r15         ## 8-byte Reload
	mulq	%r15
	addq	%r10, %rdx
	adcq	%r13, %rdi
	adcq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	$0, %r8
	andl	$1, %ecx
	addq	%r14, %rax
	adcq	%rbp, %rdx
	adcq	%r12, %rdi
	adcq	%r11, %rsi
	adcq	%r9, %rbx
	adcq	-96(%rsp), %r8          ## 8-byte Folded Reload
	adcq	$0, %rcx
	movq	%rdx, %rax
	subq	%r15, %rax
	movq	%rdi, %rbp
	sbbq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rsi, %r9
	sbbq	-56(%rsp), %r9          ## 8-byte Folded Reload
	movq	%rbx, %r10
	sbbq	-48(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r8, %r11
	sbbq	-40(%rsp), %r11         ## 8-byte Folded Reload
	sbbq	$0, %rcx
	andl	$1, %ecx
	cmovneq	%rbx, %r10
	testb	%cl, %cl
	cmovneq	%rdx, %rax
	movq	(%rsp), %rcx            ## 8-byte Reload
	movq	%rax, (%rcx)
	cmovneq	%rdi, %rbp
	movq	%rbp, 8(%rcx)
	cmovneq	%rsi, %r9
	movq	%r9, 16(%rcx)
	movq	%r10, 24(%rcx)
	cmovneq	%r8, %r11
	movq	%r11, 32(%rcx)
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF5L
	.p2align	4, 0x90
_mcl_fp_montNF5L:                       ## @mcl_fp_montNF5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	(%rdx), %rbp
	mulq	%rbp
	movq	%rax, %r8
	movq	%rdx, %r13
	movq	24(%rsi), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rax, %r10
	movq	%rdx, %r11
	movq	16(%rsi), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rax, %r15
	movq	%rdx, %r9
	movq	(%rsi), %rdi
	movq	%rdi, -48(%rsp)         ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	mulq	%rbp
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	%rbp
	movq	%rax, %r14
	movq	%rdx, %rbp
	addq	%rbx, %rbp
	adcq	%r15, %r12
	adcq	%r10, %r9
	adcq	%r8, %r11
	adcq	$0, %r13
	movq	-8(%rcx), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r14, %rsi
	imulq	%rax, %rsi
	movq	32(%rcx), %rdx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r10
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %rbx
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %r8
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	(%rcx), %rdi
	movq	%rdi, -40(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -24(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %rcx
	movq	%rsi, %rax
	mulq	%rdi
	addq	%r14, %rax
	adcq	%rbp, %rcx
	adcq	%r12, %r8
	adcq	%r9, %rbx
	adcq	%r11, %r10
	adcq	$0, %r13
	addq	%rdx, %rcx
	adcq	%r15, %r8
	adcq	-16(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-128(%rsp), %r10        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r13        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	movq	8(%rax), %rsi
	movq	%rsi, %rax
	mulq	-112(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r14
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%rdx, %r15
	addq	%r14, %r15
	adcq	%rdi, %r11
	adcq	-128(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-120(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	$0, %r12
	addq	%rcx, %rsi
	adcq	%r8, %r15
	adcq	%rbx, %r11
	adcq	%r10, %r9
	adcq	%r13, %rbp
	adcq	$0, %r12
	movq	%rsi, %rdi
	imulq	-88(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%rdi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	%r15, %r10
	adcq	%r11, %r14
	adcq	%r9, %r8
	adcq	%rbp, %r13
	adcq	$0, %r12
	addq	%rdx, %r10
	adcq	%rbx, %r14
	adcq	%rcx, %r8
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, %rax
	mulq	-112(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r11
	movq	%rdx, %rsi
	addq	%rbp, %rsi
	adcq	%rbx, %rcx
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r15
	addq	%r10, %r11
	adcq	%r14, %rsi
	adcq	%r8, %rcx
	adcq	%r13, %rdi
	adcq	%r12, %r9
	adcq	$0, %r15
	movq	%r11, %rbx
	imulq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	addq	%r11, %rax
	adcq	%rsi, %rbp
	adcq	%rcx, %r10
	adcq	%rdi, %r8
	adcq	%r9, %r13
	adcq	$0, %r15
	addq	%rdx, %rbp
	adcq	%r12, %r10
	adcq	%r14, %r8
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r15        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	movq	24(%rax), %rsi
	movq	%rsi, %rax
	mulq	-112(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r14
	movq	%rdx, %rsi
	addq	%r12, %rsi
	adcq	%rbx, %rcx
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r11
	addq	%rbp, %r14
	adcq	%r10, %rsi
	adcq	%r8, %rcx
	adcq	%r13, %rdi
	adcq	%r15, %r9
	adcq	$0, %r11
	movq	%r14, %rbx
	imulq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	addq	%r14, %rax
	adcq	%rsi, %rbp
	adcq	%rcx, %r10
	adcq	%rdi, %r8
	adcq	%r9, %r13
	adcq	$0, %r11
	addq	%rdx, %rbp
	adcq	%r12, %r10
	adcq	%r15, %r8
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r11        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	movq	32(%rax), %rcx
	movq	%rcx, %rax
	mulq	-112(%rsp)              ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-96(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rax, %r12
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	-96(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-104(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %rbx
	addq	%rbp, %r12
	adcq	%r10, %rdi
	adcq	%r8, %r15
	adcq	%r13, %r14
	adcq	%r11, %r9
	adcq	$0, %rbx
	movq	-88(%rsp), %r8          ## 8-byte Reload
	imulq	%r12, %r8
	movq	%r8, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %rcx
	movq	%r8, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %rbp
	movq	%r8, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %rsi
	movq	%r8, %rax
	movq	%r8, %r13
	movq	-40(%rsp), %r10         ## 8-byte Reload
	mulq	%r10
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	%r13, %rax
	movq	-24(%rsp), %r13         ## 8-byte Reload
	mulq	%r13
	addq	%r12, %r8
	adcq	%rdi, %rax
	adcq	%r15, %rsi
	adcq	%r14, %rbp
	adcq	%r9, %rcx
	adcq	$0, %rbx
	addq	%r11, %rax
	adcq	%rdx, %rsi
	adcq	-112(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rax, %r11
	subq	%r10, %r11
	movq	%rsi, %r10
	sbbq	%r13, %r10
	movq	%rbp, %r8
	sbbq	-80(%rsp), %r8          ## 8-byte Folded Reload
	movq	%rcx, %r9
	sbbq	-72(%rsp), %r9          ## 8-byte Folded Reload
	movq	%rbx, %rdx
	sbbq	-64(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, %rdi
	sarq	$63, %rdi
	cmovsq	%rax, %r11
	movq	-8(%rsp), %rax          ## 8-byte Reload
	movq	%r11, (%rax)
	cmovsq	%rsi, %r10
	movq	%r10, 8(%rax)
	cmovsq	%rbp, %r8
	movq	%r8, 16(%rax)
	cmovsq	%rcx, %r9
	movq	%r9, 24(%rax)
	cmovsq	%rbx, %rdx
	movq	%rdx, 32(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed5L
	.p2align	4, 0x90
_mcl_fp_montRed5L:                      ## @mcl_fp_montRed5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	-8(%rcx), %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	(%rsi), %r9
	movq	%r9, %rdi
	imulq	%rax, %rdi
	movq	32(%rcx), %rdx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r8
	movq	%rdx, %r13
	movq	24(%rcx), %rdx
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r11
	movq	%rdx, %r10
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	(%rcx), %rbp
	movq	%rbp, -40(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	%rbp
	movq	%rdx, %rcx
	addq	%rbx, %rcx
	adcq	%r14, %r12
	adcq	%r11, %r15
	adcq	%r8, %r10
	adcq	$0, %r13
	addq	%r9, %rax
	movq	72(%rsi), %rax
	movq	64(%rsi), %rdx
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r12
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %r10
	adcq	40(%rsi), %r13
	movq	%r13, -112(%rsp)        ## 8-byte Spill
	movq	56(%rsi), %rdi
	movq	48(%rsi), %rsi
	adcq	$0, %rsi
	movq	%rsi, -24(%rsp)         ## 8-byte Spill
	adcq	$0, %rdi
	movq	%rdi, -64(%rsp)         ## 8-byte Spill
	adcq	$0, %rdx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	sbbq	%r8, %r8
	andl	$1, %r8d
	movq	%rcx, %rsi
	movq	-104(%rsp), %r9         ## 8-byte Reload
	imulq	%r9, %rsi
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	addq	%rbp, %rsi
	adcq	%rdi, %rbx
	adcq	-16(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-32(%rsp), %r14         ## 8-byte Folded Reload
	adcq	$0, %r11
	addq	%rcx, %rax
	adcq	%r12, %rsi
	adcq	%r15, %rbx
	adcq	%r10, %r13
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-24(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -96(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %r8
	movq	%rsi, %rcx
	imulq	%r9, %rcx
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	movq	-56(%rsp), %r9          ## 8-byte Reload
	mulq	%r9
	movq	%rdx, %r15
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	addq	%rdi, %rcx
	adcq	-32(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-24(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-112(%rsp), %r10        ## 8-byte Folded Reload
	adcq	$0, %rbp
	addq	%rsi, %rax
	adcq	%rbx, %rcx
	adcq	%r13, %r12
	adcq	%r14, %r15
	adcq	%r11, %r10
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	$0, -96(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %r8
	movq	%rcx, %rsi
	imulq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%r9
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	addq	%rdi, %rsi
	adcq	%rbx, %r9
	adcq	-112(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-64(%rsp), %r14         ## 8-byte Folded Reload
	adcq	$0, %r11
	addq	%rcx, %rax
	adcq	%r12, %rsi
	adcq	%r15, %r9
	adcq	%r10, %r13
	adcq	%rbp, %r14
	adcq	-96(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %r8
	movq	-104(%rsp), %rdi        ## 8-byte Reload
	imulq	%rsi, %rdi
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r15
	movq	%rdi, %rax
	movq	%rdi, %r10
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r12
	movq	%r10, %rax
	movq	-40(%rsp), %r10         ## 8-byte Reload
	mulq	%r10
	addq	%r12, %rdx
	adcq	%r15, %rdi
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	$0, %rbp
	addq	%rsi, %rax
	adcq	%r9, %rdx
	adcq	%r13, %rdi
	adcq	%r14, %rbx
	adcq	%r11, %rcx
	adcq	-48(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	$0, %r8
	movq	%rdx, %rax
	subq	%r10, %rax
	movq	%rdi, %rsi
	sbbq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rbx, %r9
	sbbq	-56(%rsp), %r9          ## 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	-88(%rsp), %r10         ## 8-byte Folded Reload
	movq	%rbp, %r11
	sbbq	-80(%rsp), %r11         ## 8-byte Folded Reload
	sbbq	$0, %r8
	andl	$1, %r8d
	cmovneq	%rbp, %r11
	testb	%r8b, %r8b
	cmovneq	%rdx, %rax
	movq	-8(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rdi, %rsi
	movq	%rsi, 8(%rdx)
	cmovneq	%rbx, %r9
	movq	%r9, 16(%rdx)
	cmovneq	%rcx, %r10
	movq	%r10, 24(%rdx)
	movq	%r11, 32(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre5L
	.p2align	4, 0x90
_mcl_fp_addPre5L:                       ## @mcl_fp_addPre5L
## BB#0:
	movq	32(%rdx), %r8
	movq	24(%rdx), %r9
	movq	24(%rsi), %r11
	movq	32(%rsi), %r10
	movq	16(%rdx), %rcx
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rcx
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rcx, 16(%rdi)
	adcq	%r9, %r11
	movq	%r11, 24(%rdi)
	adcq	%r8, %r10
	movq	%r10, 32(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_subPre5L
	.p2align	4, 0x90
_mcl_fp_subPre5L:                       ## @mcl_fp_subPre5L
## BB#0:
	pushq	%rbx
	movq	32(%rsi), %r10
	movq	24(%rdx), %r8
	movq	32(%rdx), %r9
	movq	24(%rsi), %r11
	movq	16(%rsi), %rcx
	movq	(%rsi), %rbx
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	movq	%rbx, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%rcx, 16(%rdi)
	sbbq	%r8, %r11
	movq	%r11, 24(%rdi)
	sbbq	%r9, %r10
	movq	%r10, 32(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	popq	%rbx
	retq

	.globl	_mcl_fp_shr1_5L
	.p2align	4, 0x90
_mcl_fp_shr1_5L:                        ## @mcl_fp_shr1_5L
## BB#0:
	movq	32(%rsi), %r8
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	(%rsi), %rax
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rax
	movq	%rax, (%rdi)
	shrdq	$1, %rdx, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rcx, %rdx
	movq	%rdx, 16(%rdi)
	shrdq	$1, %r8, %rcx
	movq	%rcx, 24(%rdi)
	shrq	%r8
	movq	%r8, 32(%rdi)
	retq

	.globl	_mcl_fp_add5L
	.p2align	4, 0x90
_mcl_fp_add5L:                          ## @mcl_fp_add5L
## BB#0:
	pushq	%rbx
	movq	32(%rdx), %r11
	movq	24(%rdx), %rbx
	movq	24(%rsi), %r9
	movq	32(%rsi), %r8
	movq	16(%rdx), %r10
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r10
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	adcq	%rbx, %r9
	movq	%r9, 24(%rdi)
	adcq	%r11, %r8
	movq	%r8, 32(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %rax
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %r10
	sbbq	24(%rcx), %r9
	sbbq	32(%rcx), %r8
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB74_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r9, 24(%rdi)
	movq	%r8, 32(%rdi)
LBB74_2:                                ## %carry
	popq	%rbx
	retq

	.globl	_mcl_fp_addNF5L
	.p2align	4, 0x90
_mcl_fp_addNF5L:                        ## @mcl_fp_addNF5L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	32(%rdx), %r8
	movq	24(%rdx), %r9
	movq	16(%rdx), %r10
	movq	(%rdx), %r14
	movq	8(%rdx), %r11
	addq	(%rsi), %r14
	adcq	8(%rsi), %r11
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %r8
	movq	%r14, %rsi
	subq	(%rcx), %rsi
	movq	%r11, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %r15
	sbbq	24(%rcx), %r15
	movq	%r8, %rax
	sbbq	32(%rcx), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	cmovsq	%r14, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r11, %rdx
	movq	%rdx, 8(%rdi)
	cmovsq	%r10, %rbx
	movq	%rbx, 16(%rdi)
	cmovsq	%r9, %r15
	movq	%r15, 24(%rdi)
	cmovsq	%r8, %rax
	movq	%rax, 32(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_sub5L
	.p2align	4, 0x90
_mcl_fp_sub5L:                          ## @mcl_fp_sub5L
## BB#0:
	pushq	%r14
	pushq	%rbx
	movq	32(%rsi), %r8
	movq	24(%rdx), %r11
	movq	32(%rdx), %r14
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %rax
	movq	8(%rsi), %rsi
	xorl	%ebx, %ebx
	subq	(%rdx), %rax
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	movq	%rax, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r10, 16(%rdi)
	sbbq	%r11, %r9
	movq	%r9, 24(%rdi)
	sbbq	%r14, %r8
	movq	%r8, 32(%rdi)
	sbbq	$0, %rbx
	testb	$1, %bl
	je	LBB76_2
## BB#1:                                ## %carry
	movq	32(%rcx), %r11
	movq	24(%rcx), %r14
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rbx
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%rsi, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r10, %rbx
	movq	%rbx, 16(%rdi)
	adcq	%r9, %r14
	movq	%r14, 24(%rdi)
	adcq	%r8, %r11
	movq	%r11, 32(%rdi)
LBB76_2:                                ## %nocarry
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fp_subNF5L
	.p2align	4, 0x90
_mcl_fp_subNF5L:                        ## @mcl_fp_subNF5L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	32(%rsi), %r13
	movdqu	(%rdx), %xmm0
	movdqu	16(%rdx), %xmm1
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %r10
	movdqu	(%rsi), %xmm2
	movdqu	16(%rsi), %xmm3
	pshufd	$78, %xmm3, %xmm4       ## xmm4 = xmm3[2,3,0,1]
	movd	%xmm4, %r8
	movd	%xmm1, %r11
	movd	%xmm3, %r9
	pshufd	$78, %xmm0, %xmm1       ## xmm1 = xmm0[2,3,0,1]
	movd	%xmm1, %r14
	pshufd	$78, %xmm2, %xmm1       ## xmm1 = xmm2[2,3,0,1]
	movd	%xmm1, %r15
	movd	%xmm0, %rbx
	movd	%xmm2, %r12
	subq	%rbx, %r12
	sbbq	%r14, %r15
	sbbq	%r11, %r9
	sbbq	%r10, %r8
	sbbq	32(%rdx), %r13
	movq	%r13, %rdx
	sarq	$63, %rdx
	movq	%rdx, %rbx
	shldq	$1, %r13, %rbx
	movq	8(%rcx), %rsi
	andq	%rbx, %rsi
	andq	(%rcx), %rbx
	movq	32(%rcx), %r10
	andq	%rdx, %r10
	movq	24(%rcx), %rax
	andq	%rdx, %rax
	rolq	%rdx
	andq	16(%rcx), %rdx
	addq	%r12, %rbx
	movq	%rbx, (%rdi)
	adcq	%r15, %rsi
	movq	%rsi, 8(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r8, %rax
	movq	%rax, 24(%rdi)
	adcq	%r13, %r10
	movq	%r10, 32(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fpDbl_add5L
	.p2align	4, 0x90
_mcl_fpDbl_add5L:                       ## @mcl_fpDbl_add5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	72(%rdx), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	64(%rdx), %r11
	movq	56(%rdx), %r14
	movq	48(%rdx), %r15
	movq	24(%rsi), %rbp
	movq	32(%rsi), %r13
	movq	16(%rdx), %r12
	movq	(%rdx), %rbx
	movq	8(%rdx), %rax
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r12
	adcq	24(%rdx), %rbp
	adcq	32(%rdx), %r13
	movq	40(%rdx), %r9
	movq	%rbx, (%rdi)
	movq	72(%rsi), %r8
	movq	%rax, 8(%rdi)
	movq	64(%rsi), %r10
	movq	%r12, 16(%rdi)
	movq	56(%rsi), %r12
	movq	%rbp, 24(%rdi)
	movq	48(%rsi), %rbp
	movq	40(%rsi), %rbx
	movq	%r13, 32(%rdi)
	adcq	%r9, %rbx
	adcq	%r15, %rbp
	adcq	%r14, %r12
	adcq	%r11, %r10
	adcq	-8(%rsp), %r8           ## 8-byte Folded Reload
	sbbq	%rsi, %rsi
	andl	$1, %esi
	movq	%rbx, %rax
	subq	(%rcx), %rax
	movq	%rbp, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r12, %r9
	sbbq	16(%rcx), %r9
	movq	%r10, %r11
	sbbq	24(%rcx), %r11
	movq	%r8, %r14
	sbbq	32(%rcx), %r14
	sbbq	$0, %rsi
	andl	$1, %esi
	cmovneq	%rbx, %rax
	movq	%rax, 40(%rdi)
	testb	%sil, %sil
	cmovneq	%rbp, %rdx
	movq	%rdx, 48(%rdi)
	cmovneq	%r12, %r9
	movq	%r9, 56(%rdi)
	cmovneq	%r10, %r11
	movq	%r11, 64(%rdi)
	cmovneq	%r8, %r14
	movq	%r14, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub5L
	.p2align	4, 0x90
_mcl_fpDbl_sub5L:                       ## @mcl_fpDbl_sub5L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	72(%rdx), %r9
	movq	64(%rdx), %r10
	movq	56(%rdx), %r14
	movq	16(%rsi), %r8
	movq	(%rsi), %r15
	movq	8(%rsi), %r11
	xorl	%eax, %eax
	subq	(%rdx), %r15
	sbbq	8(%rdx), %r11
	sbbq	16(%rdx), %r8
	movq	24(%rsi), %r12
	sbbq	24(%rdx), %r12
	movq	%r15, (%rdi)
	movq	32(%rsi), %rbx
	sbbq	32(%rdx), %rbx
	movq	%r11, 8(%rdi)
	movq	48(%rdx), %r15
	movq	40(%rdx), %rdx
	movq	%r8, 16(%rdi)
	movq	72(%rsi), %r8
	movq	%r12, 24(%rdi)
	movq	64(%rsi), %r11
	movq	%rbx, 32(%rdi)
	movq	40(%rsi), %rbp
	sbbq	%rdx, %rbp
	movq	56(%rsi), %r12
	movq	48(%rsi), %r13
	sbbq	%r15, %r13
	sbbq	%r14, %r12
	sbbq	%r10, %r11
	sbbq	%r9, %r8
	movl	$0, %edx
	sbbq	$0, %rdx
	andl	$1, %edx
	movq	(%rcx), %rsi
	cmoveq	%rax, %rsi
	testb	%dl, %dl
	movq	16(%rcx), %rdx
	cmoveq	%rax, %rdx
	movq	8(%rcx), %rbx
	cmoveq	%rax, %rbx
	movq	32(%rcx), %r9
	cmoveq	%rax, %r9
	cmovneq	24(%rcx), %rax
	addq	%rbp, %rsi
	movq	%rsi, 40(%rdi)
	adcq	%r13, %rbx
	movq	%rbx, 48(%rdi)
	adcq	%r12, %rdx
	movq	%rdx, 56(%rdi)
	adcq	%r11, %rax
	movq	%rax, 64(%rdi)
	adcq	%r8, %r9
	movq	%r9, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mulUnitPre6L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre6L:                   ## @mcl_fp_mulUnitPre6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	32(%rsi)
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r15
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r13
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%rbp, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r12, %rbx
	movq	%rbx, 16(%rdi)
	adcq	%r14, %r13
	movq	%r13, 24(%rdi)
	adcq	%r11, %r15
	movq	%r15, 32(%rdi)
	adcq	%r8, %r10
	movq	%r10, 40(%rdi)
	adcq	$0, %r9
	movq	%r9, 48(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_mulPre6L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre6L:                    ## @mcl_fpDbl_mulPre6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rsi, %r12
	movq	%rdi, -16(%rsp)         ## 8-byte Spill
	movq	(%r12), %rax
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rsi
	mulq	%rsi
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	24(%r12), %rbp
	movq	%rbp, -104(%rsp)        ## 8-byte Spill
	movq	32(%r12), %rbx
	movq	40(%r12), %r11
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rsi
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rsi
	movq	%rax, %r9
	movq	%rdx, %rdi
	movq	16(%r12), %r8
	movq	%r8, %rax
	mulq	%rsi
	movq	%rax, %r14
	movq	%rdx, %rbp
	movq	8(%r12), %r10
	movq	%r10, %rax
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r13
	addq	-88(%rsp), %r13         ## 8-byte Folded Reload
	adcq	%r14, %r15
	adcq	%r9, %rbp
	adcq	-112(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -112(%rsp)        ## 8-byte Spill
	movq	-120(%rsp), %rsi        ## 8-byte Reload
	adcq	$0, %rsi
	movq	-64(%rsp), %r9          ## 8-byte Reload
	movq	8(%r9), %rcx
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	-104(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r14
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r8
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r10
	movq	%rax, %rbx
	movq	-72(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	addq	%r13, %rax
	movq	-16(%rsp), %r13         ## 8-byte Reload
	movq	%rax, 8(%r13)
	adcq	%r15, %rbx
	adcq	%rbp, %r8
	adcq	%rdi, %r14
	adcq	-112(%rsp), %r11        ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	%rsi, %rax
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	%rdx, %rbx
	adcq	%r10, %r8
	adcq	-80(%rsp), %r14         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	movq	40(%r12), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	16(%r9), %rcx
	mulq	%rcx
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	32(%r12), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r10
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	24(%r12), %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r9
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	16(%r12), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %rbp
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	8(%r12), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %rdi
	movq	%rdx, %r15
	movq	(%r12), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	mulq	%rcx
	addq	%rbx, %rax
	movq	%rax, 16(%r13)
	adcq	%r8, %rdi
	adcq	%r14, %rbp
	adcq	%r11, %r9
	adcq	-120(%rsp), %r10        ## 8-byte Folded Reload
	movq	-72(%rsp), %rax         ## 8-byte Reload
	adcq	%rsi, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%rdx, %rdi
	adcq	%r15, %rbp
	adcq	-56(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-48(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-40(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	adcq	-112(%rsp), %rcx        ## 8-byte Folded Reload
	movq	-64(%rsp), %rbx         ## 8-byte Reload
	movq	24(%rbx), %rsi
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	-96(%rsp), %rax         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	-104(%rsp), %rax        ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r15
	movq	-80(%rsp), %rax         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	-32(%rsp), %rax         ## 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	-24(%rsp), %rax         ## 8-byte Reload
	mulq	%rsi
	addq	%rdi, %rax
	movq	-16(%rsp), %rsi         ## 8-byte Reload
	movq	%rax, 24(%rsi)
	adcq	%rbp, %r11
	adcq	%r9, %r13
	adcq	%r10, %r15
	adcq	-72(%rsp), %r14         ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	%rcx, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%rdx, %r11
	adcq	%r8, %r13
	adcq	-112(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-104(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	movq	40(%r12), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	32(%rbx), %rdi
	mulq	%rdi
	movq	%rax, %r9
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	32(%r12), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	24(%r12), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	16(%r12), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %rbx
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	(%r12), %rbp
	movq	8(%r12), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	addq	%r11, %rax
	movq	%rax, 32(%rsi)
	adcq	%r13, %r12
	adcq	%r15, %rbx
	adcq	%r14, %r8
	adcq	-120(%rsp), %r10        ## 8-byte Folded Reload
	adcq	%rcx, %r9
	movq	-64(%rsp), %rax         ## 8-byte Reload
	movq	40(%rax), %rcx
	sbbq	%rsi, %rsi
	movq	-80(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r15
	movq	-8(%rsp), %rax          ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %rdi
	movq	-32(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, %r14
	movq	-40(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	andl	$1, %esi
	addq	-48(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-112(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-104(%rsp), %r8         ## 8-byte Folded Reload
	adcq	-96(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	addq	%rdi, %r12
	movq	-16(%rsp), %rcx         ## 8-byte Reload
	movq	%r12, 40(%rcx)
	adcq	%r11, %rbx
	adcq	%rax, %r8
	adcq	%r14, %r10
	adcq	%r15, %r9
	adcq	-24(%rsp), %rsi         ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rbp, %rbx
	movq	%rbx, 48(%rcx)
	adcq	-80(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, 56(%rcx)
	adcq	%rdx, %r10
	movq	%r10, 64(%rcx)
	adcq	%r13, %r9
	movq	%r9, 72(%rcx)
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	movq	%rsi, 80(%rcx)
	adcq	-64(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 88(%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre6L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre6L:                    ## @mcl_fpDbl_sqrPre6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -48(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %r8
	movq	%r8, -120(%rsp)         ## 8-byte Spill
	movq	24(%rsi), %r11
	movq	%r11, -112(%rsp)        ## 8-byte Spill
	movq	32(%rsi), %r12
	movq	40(%rsi), %r9
	movq	(%rsi), %rcx
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, (%rdi)
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %rbx
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%r12, %rax
	mulq	%rcx
	movq	%rdx, %r10
	movq	%rax, %r13
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, %r15
	movq	%r8, %rax
	mulq	%rcx
	movq	%rax, %r11
	movq	%rdx, %r14
	movq	8(%rsi), %r8
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, %rcx
	addq	%rcx, %rbp
	adcq	%rdx, %r11
	adcq	%r15, %r14
	adcq	%r13, %rdi
	adcq	-128(%rsp), %r10        ## 8-byte Folded Reload
	adcq	$0, %rbx
	movq	%rbx, -72(%rsp)         ## 8-byte Spill
	movq	%r9, %rax
	mulq	%r8
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%r12, %rax
	mulq	%r8
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %r9
	movq	-112(%rsp), %rax        ## 8-byte Reload
	mulq	%r8
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %r15
	movq	-120(%rsp), %rax        ## 8-byte Reload
	mulq	%r8
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r12
	movq	%r8, %rax
	mulq	%r8
	movq	%rax, %rbx
	addq	%rcx, %rbp
	movq	-48(%rsp), %rax         ## 8-byte Reload
	movq	%rbp, 8(%rax)
	adcq	%r11, %rbx
	adcq	%r14, %r12
	adcq	%rdi, %r15
	adcq	%r10, %r9
	movq	%r13, %rax
	adcq	-72(%rsp), %rax         ## 8-byte Folded Reload
	sbbq	%r13, %r13
	andl	$1, %r13d
	addq	-56(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	%rdx, %r12
	adcq	-120(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-64(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	movq	40(%rsi), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %rdi
	mulq	%rdi
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	24(%rsi), %rbp
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, %r8
	movq	%r8, -24(%rsp)          ## 8-byte Spill
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, %rcx
	addq	%rbx, %r14
	movq	-48(%rsp), %rax         ## 8-byte Reload
	movq	%r14, 16(%rax)
	adcq	%r12, %r10
	adcq	%r15, %rcx
	adcq	%r8, %r9
	adcq	-88(%rsp), %r11         ## 8-byte Folded Reload
	movq	-96(%rsp), %r8          ## 8-byte Reload
	adcq	%r13, %r8
	sbbq	%rdi, %rdi
	andl	$1, %edi
	addq	-104(%rsp), %r10        ## 8-byte Folded Reload
	adcq	-32(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	%rdx, %r9
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-80(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdi        ## 8-byte Folded Reload
	movq	-56(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	-120(%rsp), %rax        ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	-72(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %r13
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	addq	%r10, %rbx
	movq	-48(%rsp), %rax         ## 8-byte Reload
	movq	%rbx, 24(%rax)
	adcq	%rcx, %r14
	adcq	-24(%rsp), %r9          ## 8-byte Folded Reload
	adcq	%r11, %r13
	adcq	%r8, %r15
	adcq	%rdi, %r12
	sbbq	%rcx, %rcx
	movq	8(%rsi), %rbp
	movq	40(%rsi), %rbx
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	(%rsi), %rdi
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	32(%rsi), %r10
	movq	%rbp, %rax
	mulq	%r10
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	andl	$1, %ecx
	addq	-40(%rsp), %r14         ## 8-byte Folded Reload
	adcq	-96(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-104(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	movq	24(%rsi), %rdi
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%r10
	movq	%rax, %rbp
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %rsi
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, %r11
	movq	%rax, %rsi
	movq	%rbx, %rax
	mulq	%r10
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	%r10, %rax
	mulq	%r10
	movq	%rdx, %r8
	addq	-8(%rsp), %r14          ## 8-byte Folded Reload
	movq	-48(%rsp), %rdx         ## 8-byte Reload
	movq	%r14, 32(%rdx)
	adcq	-32(%rsp), %r9          ## 8-byte Folded Reload
	adcq	%r13, %rsi
	adcq	%r15, %rbp
	adcq	%r12, %rax
	adcq	%rdi, %rcx
	sbbq	%r10, %r10
	andl	$1, %r10d
	addq	-24(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	%r11, %rbp
	adcq	-40(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%r8, %rcx
	movq	-16(%rsp), %r8          ## 8-byte Reload
	adcq	%r8, %r10
	addq	-72(%rsp), %r9          ## 8-byte Folded Reload
	movq	%r9, 40(%rdx)
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%rdi, %rcx
	adcq	%rbx, %r10
	sbbq	%rdi, %rdi
	andl	$1, %edi
	addq	-64(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, 48(%rdx)
	adcq	-56(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, 56(%rdx)
	adcq	-80(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 64(%rdx)
	adcq	-128(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, 72(%rdx)
	adcq	%r8, %r10
	movq	%r10, 80(%rdx)
	adcq	-88(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, 88(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont6L
	.p2align	4, 0x90
_mcl_fp_mont6L:                         ## @mcl_fp_mont6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rdi, 40(%rsp)          ## 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, %r11
	movq	32(%rsi), %rax
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	24(%rsi), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, %rbx
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r9
	movq	%rdx, %r12
	movq	(%rsi), %rbp
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%r9, %r13
	adcq	%r8, %r12
	adcq	%r14, %rbx
	movq	%rbx, -88(%rsp)         ## 8-byte Spill
	adcq	%r10, %r15
	movq	%r15, -120(%rsp)        ## 8-byte Spill
	adcq	$0, %r11
	movq	%r11, -112(%rsp)        ## 8-byte Spill
	movq	-8(%rcx), %rdx
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	imulq	%rdx, %rbx
	movq	40(%rcx), %rdx
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r9
	movq	%rdx, %r14
	movq	24(%rcx), %rdx
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r8
	movq	%rdx, %r15
	movq	16(%rcx), %rdx
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r10
	movq	%rdx, %r11
	movq	(%rcx), %rsi
	movq	%rsi, -24(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -16(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	%rsi
	movq	%rdx, %rbx
	addq	%rcx, %rbx
	adcq	%r10, %rbp
	adcq	%r8, %r11
	adcq	%r9, %r15
	adcq	-104(%rsp), %r14        ## 8-byte Folded Reload
	movq	-128(%rsp), %rcx        ## 8-byte Reload
	adcq	$0, %rcx
	addq	-96(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%rdi, %rbx
	adcq	%r13, %rbp
	adcq	%r12, %r11
	adcq	-88(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-120(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	sbbq	%rsi, %rsi
	andl	$1, %esi
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rdi
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r12
	movq	%rdx, %rdi
	addq	%r10, %rdi
	adcq	%r9, %rcx
	adcq	-104(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r8          ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	-88(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rbx, %r12
	adcq	%rbp, %rdi
	adcq	%r11, %rcx
	adcq	%r15, %r13
	adcq	%r14, %r8
	adcq	-128(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	%rsi, %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r12, %rbx
	imulq	-32(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	addq	%r11, %r9
	adcq	%r10, %rbp
	adcq	-48(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r14         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r12, %rax
	adcq	%rdi, %r9
	adcq	%rcx, %rbp
	adcq	%r13, %rsi
	adcq	%r8, %r15
	adcq	-120(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, -88(%rsp)           ## 8-byte Folded Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r13
	movq	%rdx, %rcx
	addq	%r10, %rcx
	adcq	%r8, %rbx
	adcq	%rdi, %r12
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%r9, %r13
	adcq	%rbp, %rcx
	adcq	%rsi, %rbx
	adcq	%r15, %r12
	adcq	%r14, %r11
	adcq	-128(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r13, %rdi
	imulq	-32(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	addq	%r10, %r8
	adcq	%r15, %rbp
	adcq	-48(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-96(%rsp), %r14         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r13, %rax
	adcq	%rcx, %r8
	adcq	%rbx, %rbp
	adcq	%r12, %rsi
	adcq	%r11, %r9
	adcq	-120(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, -88(%rsp)           ## 8-byte Folded Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r13
	movq	%rdx, %rcx
	addq	%r12, %rcx
	adcq	%r10, %rbx
	adcq	%rdi, %r15
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%r8, %r13
	adcq	%rbp, %rcx
	adcq	%rsi, %rbx
	adcq	%r9, %r15
	adcq	%r14, %r11
	adcq	-128(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r13, %rsi
	imulq	-32(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	addq	%r9, %rsi
	adcq	%r8, %r12
	adcq	%r10, %r14
	adcq	-104(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rbp         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r13, %rax
	adcq	%rcx, %rsi
	adcq	%rbx, %r12
	adcq	%r15, %r14
	adcq	%r11, %rdi
	adcq	-120(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, -88(%rsp)           ## 8-byte Folded Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	32(%rax), %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %r13
	addq	%r9, %r13
	adcq	%r11, %r15
	adcq	-48(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	movq	-120(%rsp), %rcx        ## 8-byte Reload
	adcq	-96(%rsp), %rcx         ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rsi, %r8
	adcq	%r12, %r13
	adcq	%r14, %r15
	adcq	%rdi, %r10
	adcq	%rbp, %rbx
	adcq	-128(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%r8, %rcx
	imulq	-32(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	addq	%r12, %r14
	adcq	%rdi, %rbp
	adcq	-48(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r9          ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r8, %rax
	adcq	%r13, %r14
	adcq	%r15, %rbp
	adcq	%r10, %rsi
	adcq	%rbx, %r11
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	movq	%r9, -120(%rsp)         ## 8-byte Spill
	adcq	-112(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	-88(%rsp), %rdi         ## 8-byte Reload
	adcq	$0, %rdi
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	40(%rax), %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r15
	movq	%rdx, %r8
	addq	%r9, %r8
	adcq	%rbx, %r10
	adcq	-80(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r12         ## 8-byte Folded Reload
	movq	-64(%rsp), %rax         ## 8-byte Reload
	adcq	-112(%rsp), %rax        ## 8-byte Folded Reload
	movq	-56(%rsp), %rdx         ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r14, %r15
	adcq	%rbp, %r8
	adcq	%rsi, %r10
	adcq	%r11, %r13
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	movq	%r12, -72(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	adcq	%rdi, %rdx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	sbbq	%rcx, %rcx
	movq	-32(%rsp), %rdi         ## 8-byte Reload
	imulq	%r15, %rdi
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	andl	$1, %ecx
	addq	%r14, %rax
	adcq	%r11, %rdx
	adcq	-40(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-32(%rsp), %r12         ## 8-byte Folded Reload
	adcq	$0, %rbp
	addq	%r15, %r9
	adcq	%r8, %rax
	adcq	%r10, %rdx
	adcq	%r13, %rbx
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-64(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-56(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	$0, %rcx
	movq	%rax, %r8
	subq	-24(%rsp), %r8          ## 8-byte Folded Reload
	movq	%rdx, %r9
	sbbq	-16(%rsp), %r9          ## 8-byte Folded Reload
	movq	%rbx, %r10
	sbbq	-8(%rsp), %r10          ## 8-byte Folded Reload
	movq	%rsi, %r11
	sbbq	(%rsp), %r11            ## 8-byte Folded Reload
	movq	%r12, %r14
	sbbq	8(%rsp), %r14           ## 8-byte Folded Reload
	movq	%rbp, %r15
	sbbq	16(%rsp), %r15          ## 8-byte Folded Reload
	sbbq	$0, %rcx
	andl	$1, %ecx
	cmovneq	%rsi, %r11
	testb	%cl, %cl
	cmovneq	%rax, %r8
	movq	40(%rsp), %rax          ## 8-byte Reload
	movq	%r8, (%rax)
	cmovneq	%rdx, %r9
	movq	%r9, 8(%rax)
	cmovneq	%rbx, %r10
	movq	%r10, 16(%rax)
	movq	%r11, 24(%rax)
	cmovneq	%r12, %r14
	movq	%r14, 32(%rax)
	cmovneq	%rbp, %r15
	movq	%r15, 40(%rax)
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF6L
	.p2align	4, 0x90
_mcl_fp_montNF6L:                       ## @mcl_fp_montNF6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, 32(%rsp)          ## 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rdx, %r12
	movq	32(%rsi), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r10
	movq	24(%rsi), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r15
	movq	%rdx, %r9
	movq	16(%rsi), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, %r8
	movq	(%rsi), %rbx
	movq	%rbx, 8(%rsp)           ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %rbp
	movq	%rax, %rsi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rax, %r13
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%r11, %rbp
	adcq	%r15, %r8
	adcq	%r14, %r9
	adcq	-64(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r10, -128(%rsp)        ## 8-byte Spill
	adcq	$0, %r12
	movq	%r12, -112(%rsp)        ## 8-byte Spill
	movq	-8(%rcx), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%r13, %rbx
	imulq	%rax, %rbx
	movq	40(%rcx), %rdx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r15
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r12
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rdx
	movq	%rax, %r10
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	(%rcx), %rsi
	movq	%rsi, -32(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	movq	%rbx, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	%rsi
	addq	%r13, %rax
	adcq	%rdi, %rcx
	adcq	%rbp, %r10
	adcq	%r8, %r12
	adcq	%r9, %r15
	adcq	-128(%rsp), %r14        ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rcx
	adcq	%r11, %r10
	adcq	-8(%rsp), %r12          ## 8-byte Folded Reload
	adcq	-104(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r14         ## 8-byte Folded Reload
	movq	%r14, -128(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	-72(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rdi
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rax, %rdi
	movq	%rdx, %rbp
	addq	%r11, %rbp
	adcq	%r14, %rbx
	adcq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r8
	addq	%rcx, %rdi
	adcq	%r10, %rbp
	adcq	%r12, %rbx
	adcq	%r15, %rsi
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r8
	movq	%rdi, %r11
	imulq	-48(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r11, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%r11, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%r11, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %rcx
	movq	%r11, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r10
	movq	%r11, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r14
	movq	%r11, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%rbp, %r14
	adcq	%rbx, %r10
	adcq	%rsi, %rcx
	adcq	%r13, %r15
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	%r9, %rax
	adcq	$0, %r8
	addq	%rdx, %r14
	adcq	%r12, %r10
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r15        ## 8-byte Folded Reload
	movq	%r15, -120(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	adcq	-128(%rsp), %r8         ## 8-byte Folded Reload
	movq	-72(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rdi
	movq	%rdi, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %rbx
	addq	%r9, %rbx
	adcq	-8(%rsp), %rsi          ## 8-byte Folded Reload
	adcq	-104(%rsp), %r12        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-128(%rsp), %r15        ## 8-byte Folded Reload
	adcq	$0, %r13
	addq	%r14, %rbp
	adcq	%r10, %rbx
	adcq	%rcx, %rsi
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r11        ## 8-byte Folded Reload
	adcq	%r8, %r15
	adcq	$0, %r13
	movq	%rbp, %rcx
	imulq	-48(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%rbx, %rdi
	adcq	%rsi, %r14
	adcq	%r12, %r10
	adcq	%r11, %r9
	movq	-112(%rsp), %rax        ## 8-byte Reload
	adcq	%r15, %rax
	adcq	$0, %r13
	addq	%rdx, %rdi
	adcq	%r8, %r14
	adcq	-104(%rsp), %r10        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %r13        ## 8-byte Folded Reload
	movq	-72(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rbp
	movq	%rbp, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-128(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r11        ## 8-byte Folded Reload
	adcq	$0, %r15
	addq	%rdi, %r8
	adcq	%r14, %rbp
	adcq	%r10, %rbx
	adcq	%r9, %rsi
	adcq	-112(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	%r13, %r11
	adcq	$0, %r15
	movq	%r8, %r14
	imulq	-48(%rsp), %r14         ## 8-byte Folded Reload
	movq	%r14, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r9
	movq	%r14, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%r14, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r10
	movq	%r14, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	%r14, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %rdi
	movq	%r14, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	addq	%r8, %rax
	adcq	%rbp, %rdi
	adcq	%rbx, %r12
	adcq	%rsi, %r10
	adcq	%rcx, %r13
	adcq	%r11, %r9
	adcq	$0, %r15
	addq	%rdx, %rdi
	adcq	-104(%rsp), %r12        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-120(%rsp), %r13        ## 8-byte Folded Reload
	movq	%r13, -120(%rsp)        ## 8-byte Spill
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	movq	%r9, -112(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %r15        ## 8-byte Folded Reload
	movq	-72(%rsp), %rax         ## 8-byte Reload
	movq	32(%rax), %rcx
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rax, %r11
	movq	%rdx, %rbp
	addq	%r13, %rbp
	adcq	-8(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-128(%rsp), %r9         ## 8-byte Folded Reload
	adcq	$0, %r14
	addq	%rdi, %r11
	adcq	%r12, %rbp
	adcq	%r10, %rbx
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r8         ## 8-byte Folded Reload
	adcq	%r15, %r9
	adcq	$0, %r14
	movq	%r11, %rcx
	imulq	-48(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	addq	%r11, %rax
	adcq	%rbp, %rdi
	adcq	%rbx, %r15
	adcq	%rsi, %r10
	adcq	%r8, %r12
	movq	-112(%rsp), %rcx        ## 8-byte Reload
	adcq	%r9, %rcx
	adcq	$0, %r14
	addq	%rdx, %rdi
	adcq	%r13, %r15
	adcq	-128(%rsp), %r10        ## 8-byte Folded Reload
	movq	%r10, -128(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	movq	%r12, -120(%rsp)        ## 8-byte Spill
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, -112(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %r14         ## 8-byte Folded Reload
	movq	-72(%rsp), %rax         ## 8-byte Reload
	movq	40(%rax), %rcx
	movq	%rcx, %rax
	mulq	-80(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-88(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %r8
	addq	%rsi, %r8
	adcq	%rbp, %r10
	adcq	-88(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, %rbx
	addq	%rdi, %r9
	adcq	%r15, %r8
	adcq	-128(%rsp), %r10        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r12        ## 8-byte Folded Reload
	adcq	%r14, %r11
	adcq	$0, %rbx
	movq	-48(%rsp), %rcx         ## 8-byte Reload
	imulq	%r9, %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	%rcx, %rax
	movq	%rcx, %r15
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, %rcx
	movq	%r15, %rax
	movq	24(%rsp), %r15          ## 8-byte Reload
	mulq	%r15
	addq	%r9, %r14
	adcq	%r8, %rax
	adcq	%r10, %rcx
	adcq	%r13, %rbp
	adcq	%r12, %rdi
	adcq	%r11, %rsi
	adcq	$0, %rbx
	addq	-88(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%rdx, %rcx
	adcq	-56(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-48(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rax, %r14
	subq	-32(%rsp), %r14         ## 8-byte Folded Reload
	movq	%rcx, %r8
	sbbq	%r15, %r8
	movq	%rbp, %r9
	sbbq	-40(%rsp), %r9          ## 8-byte Folded Reload
	movq	%rdi, %r10
	sbbq	-24(%rsp), %r10         ## 8-byte Folded Reload
	movq	%rsi, %r11
	sbbq	-16(%rsp), %r11         ## 8-byte Folded Reload
	movq	%rbx, %r15
	sbbq	-64(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, %rdx
	sarq	$63, %rdx
	cmovsq	%rax, %r14
	movq	32(%rsp), %rax          ## 8-byte Reload
	movq	%r14, (%rax)
	cmovsq	%rcx, %r8
	movq	%r8, 8(%rax)
	cmovsq	%rbp, %r9
	movq	%r9, 16(%rax)
	cmovsq	%rdi, %r10
	movq	%r10, 24(%rax)
	cmovsq	%rsi, %r11
	movq	%r11, 32(%rax)
	cmovsq	%rbx, %r15
	movq	%r15, 40(%rax)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed6L
	.p2align	4, 0x90
_mcl_fp_montRed6L:                      ## @mcl_fp_montRed6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdx, %rbp
	movq	%rdi, 16(%rsp)          ## 8-byte Spill
	movq	-8(%rbp), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	(%rsi), %r10
	movq	%r10, %rdi
	imulq	%rax, %rdi
	movq	40(%rbp), %rcx
	movq	%rcx, -24(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rax, %r14
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	32(%rbp), %rcx
	movq	%rcx, -40(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rax, %r15
	movq	%rdx, %r9
	movq	24(%rbp), %rcx
	movq	%rcx, -48(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, %r11
	movq	16(%rbp), %rcx
	movq	%rcx, -56(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rax, %rcx
	movq	%rdx, %r13
	movq	(%rbp), %rbx
	movq	8(%rbp), %rdx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rdx, %r8
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rbx, %rdi
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, %rbx
	addq	%rbp, %rbx
	adcq	%rcx, %r8
	adcq	%r12, %r13
	adcq	%r15, %r11
	adcq	%r14, %r9
	movq	-128(%rsp), %rcx        ## 8-byte Reload
	adcq	$0, %rcx
	addq	%r10, %rax
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r8
	adcq	24(%rsi), %r13
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r9
	movq	%r9, -120(%rsp)         ## 8-byte Spill
	adcq	48(%rsi), %rcx
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	movq	88(%rsi), %rax
	movq	80(%rsi), %rcx
	movq	72(%rsi), %rdx
	movq	64(%rsi), %rbp
	movq	56(%rsi), %rsi
	adcq	$0, %rsi
	movq	%rsi, -104(%rsp)        ## 8-byte Spill
	adcq	$0, %rbp
	movq	%rbp, -72(%rsp)         ## 8-byte Spill
	adcq	$0, %rdx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	adcq	$0, %rcx
	movq	%rcx, -64(%rsp)         ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	sbbq	%r14, %r14
	andl	$1, %r14d
	movq	%rbx, %rsi
	imulq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, %rdi
	addq	%r9, %rdi
	adcq	%r10, %rbp
	adcq	8(%rsp), %rcx           ## 8-byte Folded Reload
	adcq	(%rsp), %r12            ## 8-byte Folded Reload
	adcq	-32(%rsp), %r15         ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%rbx, %rax
	adcq	%r8, %rdi
	adcq	%r13, %rbp
	adcq	%r11, %rcx
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	adcq	-128(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	$0, -72(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -96(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -88(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %r14
	movq	%rdi, %rbx
	imulq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r10
	addq	%r11, %r10
	adcq	%r9, %r8
	adcq	(%rsp), %rsi            ## 8-byte Folded Reload
	adcq	-32(%rsp), %r13         ## 8-byte Folded Reload
	movq	-120(%rsp), %rbx        ## 8-byte Reload
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%rdi, %rax
	adcq	%rbp, %r10
	adcq	%rcx, %r8
	adcq	%r12, %rsi
	adcq	%r15, %r13
	adcq	-112(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -120(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, -96(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -88(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %r14
	movq	%r10, %rcx
	imulq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, %rax
	movq	-24(%rsp), %rbp         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	addq	%r9, %rcx
	adcq	%rbx, %rdi
	adcq	-32(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-72(%rsp), %r11         ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %rax
	adcq	%r8, %rcx
	adcq	%rsi, %rdi
	adcq	%r13, %r12
	adcq	-120(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	movq	-88(%rsp), %r8          ## 8-byte Reload
	adcq	$0, %r8
	adcq	$0, %r14
	movq	%rcx, %rsi
	imulq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	addq	%r10, %rbx
	adcq	%rbp, %r9
	adcq	-104(%rsp), %r13        ## 8-byte Folded Reload
	movq	-120(%rsp), %rbp        ## 8-byte Reload
	adcq	-72(%rsp), %rbp         ## 8-byte Folded Reload
	movq	-128(%rsp), %rsi        ## 8-byte Reload
	adcq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	movq	-96(%rsp), %rdx         ## 8-byte Reload
	adcq	$0, %rdx
	addq	%rcx, %rax
	adcq	%rdi, %rbx
	adcq	%r12, %r9
	adcq	%r15, %r13
	adcq	%r11, %rbp
	movq	%rbp, -120(%rsp)        ## 8-byte Spill
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	movq	%rsi, -128(%rsp)        ## 8-byte Spill
	adcq	-64(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, -88(%rsp)          ## 8-byte Spill
	adcq	$0, %r14
	movq	-80(%rsp), %r8          ## 8-byte Reload
	imulq	%rbx, %r8
	movq	%r8, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%r8, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%r8, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%r8, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%r8, %rax
	movq	-16(%rsp), %r12         ## 8-byte Reload
	mulq	%r12
	movq	%rdx, %rcx
	movq	%rax, %r15
	movq	%r8, %rax
	movq	-8(%rsp), %r8           ## 8-byte Reload
	mulq	%r8
	addq	%r15, %rdx
	adcq	%r10, %rcx
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-64(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r11         ## 8-byte Folded Reload
	adcq	$0, %rbp
	addq	%rbx, %rax
	adcq	%r9, %rdx
	adcq	%r13, %rcx
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-88(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	$0, %r14
	movq	%rdx, %rax
	subq	%r8, %rax
	movq	%rcx, %rbx
	sbbq	%r12, %rbx
	movq	%rsi, %r8
	sbbq	-56(%rsp), %r8          ## 8-byte Folded Reload
	movq	%rdi, %r9
	sbbq	-48(%rsp), %r9          ## 8-byte Folded Reload
	movq	%r11, %r10
	sbbq	-40(%rsp), %r10         ## 8-byte Folded Reload
	movq	%rbp, %r15
	sbbq	-24(%rsp), %r15         ## 8-byte Folded Reload
	sbbq	$0, %r14
	andl	$1, %r14d
	cmovneq	%rbp, %r15
	testb	%r14b, %r14b
	cmovneq	%rdx, %rax
	movq	16(%rsp), %rdx          ## 8-byte Reload
	movq	%rax, (%rdx)
	cmovneq	%rcx, %rbx
	movq	%rbx, 8(%rdx)
	cmovneq	%rsi, %r8
	movq	%r8, 16(%rdx)
	cmovneq	%rdi, %r9
	movq	%r9, 24(%rdx)
	cmovneq	%r11, %r10
	movq	%r10, 32(%rdx)
	movq	%r15, 40(%rdx)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre6L
	.p2align	4, 0x90
_mcl_fp_addPre6L:                       ## @mcl_fp_addPre6L
## BB#0:
	pushq	%r14
	pushq	%rbx
	movq	40(%rdx), %r8
	movq	40(%rsi), %r11
	movq	32(%rdx), %r9
	movq	24(%rdx), %r10
	movq	24(%rsi), %rax
	movq	32(%rsi), %r14
	movq	16(%rdx), %rbx
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rbx, 16(%rdi)
	adcq	%r10, %rax
	movq	%rax, 24(%rdi)
	adcq	%r9, %r14
	movq	%r14, 32(%rdi)
	adcq	%r8, %r11
	movq	%r11, 40(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fp_subPre6L
	.p2align	4, 0x90
_mcl_fp_subPre6L:                       ## @mcl_fp_subPre6L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	40(%rdx), %r8
	movq	40(%rsi), %r9
	movq	32(%rsi), %r10
	movq	24(%rsi), %r11
	movq	16(%rsi), %rcx
	movq	(%rsi), %rbx
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %rsi
	movq	24(%rdx), %r14
	movq	32(%rdx), %r15
	sbbq	16(%rdx), %rcx
	movq	%rbx, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%rcx, 16(%rdi)
	sbbq	%r14, %r11
	movq	%r11, 24(%rdi)
	sbbq	%r15, %r10
	movq	%r10, 32(%rdi)
	sbbq	%r8, %r9
	movq	%r9, 40(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_shr1_6L
	.p2align	4, 0x90
_mcl_fp_shr1_6L:                        ## @mcl_fp_shr1_6L
## BB#0:
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %rdx
	movq	16(%rsi), %rax
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rcx
	movq	%rcx, (%rdi)
	shrdq	$1, %rax, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rdx, %rax
	movq	%rax, 16(%rdi)
	shrdq	$1, %r9, %rdx
	movq	%rdx, 24(%rdi)
	shrdq	$1, %r8, %r9
	movq	%r9, 32(%rdi)
	shrq	%r8
	movq	%r8, 40(%rdi)
	retq

	.globl	_mcl_fp_add6L
	.p2align	4, 0x90
_mcl_fp_add6L:                          ## @mcl_fp_add6L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	40(%rdx), %r14
	movq	40(%rsi), %r8
	movq	32(%rdx), %r15
	movq	24(%rdx), %rbx
	movq	24(%rsi), %r10
	movq	32(%rsi), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r11
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r11, 16(%rdi)
	adcq	%rbx, %r10
	movq	%r10, 24(%rdi)
	adcq	%r15, %r9
	movq	%r9, 32(%rdi)
	adcq	%r14, %r8
	movq	%r8, 40(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %rax
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %r11
	sbbq	24(%rcx), %r10
	sbbq	32(%rcx), %r9
	sbbq	40(%rcx), %r8
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB89_2
## BB#1:                                ## %nocarry
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r11, 16(%rdi)
	movq	%r10, 24(%rdi)
	movq	%r9, 32(%rdi)
	movq	%r8, 40(%rdi)
LBB89_2:                                ## %carry
	popq	%rbx
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_addNF6L
	.p2align	4, 0x90
_mcl_fp_addNF6L:                        ## @mcl_fp_addNF6L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r8
	movq	32(%rdx), %r9
	movq	24(%rdx), %r10
	movq	16(%rdx), %r11
	movq	(%rdx), %r15
	movq	8(%rdx), %r14
	addq	(%rsi), %r15
	adcq	8(%rsi), %r14
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r10
	adcq	32(%rsi), %r9
	adcq	40(%rsi), %r8
	movq	%r15, %rsi
	subq	(%rcx), %rsi
	movq	%r14, %rbx
	sbbq	8(%rcx), %rbx
	movq	%r11, %rdx
	sbbq	16(%rcx), %rdx
	movq	%r10, %r13
	sbbq	24(%rcx), %r13
	movq	%r9, %r12
	sbbq	32(%rcx), %r12
	movq	%r8, %rax
	sbbq	40(%rcx), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	cmovsq	%r15, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r14, %rbx
	movq	%rbx, 8(%rdi)
	cmovsq	%r11, %rdx
	movq	%rdx, 16(%rdi)
	cmovsq	%r10, %r13
	movq	%r13, 24(%rdi)
	cmovsq	%r9, %r12
	movq	%r12, 32(%rdi)
	cmovsq	%r8, %rax
	movq	%rax, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_sub6L
	.p2align	4, 0x90
_mcl_fp_sub6L:                          ## @mcl_fp_sub6L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r14
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rax
	movq	8(%rsi), %rsi
	xorl	%ebx, %ebx
	subq	(%rdx), %rax
	sbbq	8(%rdx), %rsi
	movq	24(%rdx), %r15
	movq	32(%rdx), %r12
	sbbq	16(%rdx), %r11
	movq	%rax, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r11, 16(%rdi)
	sbbq	%r15, %r10
	movq	%r10, 24(%rdi)
	sbbq	%r12, %r9
	movq	%r9, 32(%rdi)
	sbbq	%r14, %r8
	movq	%r8, 40(%rdi)
	sbbq	$0, %rbx
	testb	$1, %bl
	je	LBB91_2
## BB#1:                                ## %carry
	movq	40(%rcx), %r14
	movq	32(%rcx), %r15
	movq	24(%rcx), %r12
	movq	8(%rcx), %rbx
	movq	16(%rcx), %rdx
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%rsi, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r11, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r10, %r12
	movq	%r12, 24(%rdi)
	adcq	%r9, %r15
	movq	%r15, 32(%rdi)
	adcq	%r8, %r14
	movq	%r14, 40(%rdi)
LBB91_2:                                ## %nocarry
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_subNF6L
	.p2align	4, 0x90
_mcl_fp_subNF6L:                        ## @mcl_fp_subNF6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movdqu	(%rdx), %xmm0
	movdqu	16(%rdx), %xmm1
	movdqu	32(%rdx), %xmm2
	pshufd	$78, %xmm2, %xmm3       ## xmm3 = xmm2[2,3,0,1]
	movd	%xmm3, %r11
	movdqu	(%rsi), %xmm3
	movdqu	16(%rsi), %xmm4
	movdqu	32(%rsi), %xmm5
	pshufd	$78, %xmm5, %xmm6       ## xmm6 = xmm5[2,3,0,1]
	movd	%xmm6, %rax
	movd	%xmm2, %r14
	movd	%xmm5, %r8
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %r15
	pshufd	$78, %xmm4, %xmm2       ## xmm2 = xmm4[2,3,0,1]
	movd	%xmm2, %r9
	movd	%xmm1, %r12
	movd	%xmm4, %r10
	pshufd	$78, %xmm0, %xmm1       ## xmm1 = xmm0[2,3,0,1]
	movd	%xmm1, %rbx
	pshufd	$78, %xmm3, %xmm1       ## xmm1 = xmm3[2,3,0,1]
	movd	%xmm1, %r13
	movd	%xmm0, %rsi
	movd	%xmm3, %rbp
	subq	%rsi, %rbp
	sbbq	%rbx, %r13
	sbbq	%r12, %r10
	sbbq	%r15, %r9
	sbbq	%r14, %r8
	sbbq	%r11, %rax
	movq	%rax, %rsi
	sarq	$63, %rsi
	movq	%rsi, %rbx
	shldq	$1, %rax, %rbx
	andq	(%rcx), %rbx
	movq	40(%rcx), %r11
	andq	%rsi, %r11
	movq	32(%rcx), %r14
	andq	%rsi, %r14
	movq	24(%rcx), %r15
	andq	%rsi, %r15
	movq	16(%rcx), %rdx
	andq	%rsi, %rdx
	rolq	%rsi
	andq	8(%rcx), %rsi
	addq	%rbp, %rbx
	movq	%rbx, (%rdi)
	adcq	%r13, %rsi
	movq	%rsi, 8(%rdi)
	adcq	%r10, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r9, %r15
	movq	%r15, 24(%rdi)
	adcq	%r8, %r14
	movq	%r14, 32(%rdi)
	adcq	%rax, %r11
	movq	%r11, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_add6L
	.p2align	4, 0x90
_mcl_fpDbl_add6L:                       ## @mcl_fpDbl_add6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	88(%rdx), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	80(%rdx), %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	72(%rdx), %r14
	movq	64(%rdx), %r15
	movq	24(%rsi), %rbp
	movq	32(%rsi), %r13
	movq	16(%rdx), %r12
	movq	(%rdx), %rbx
	movq	8(%rdx), %rax
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r12
	adcq	24(%rdx), %rbp
	adcq	32(%rdx), %r13
	movq	56(%rdx), %r11
	movq	48(%rdx), %r9
	movq	40(%rdx), %rdx
	movq	%rbx, (%rdi)
	movq	88(%rsi), %r8
	movq	%rax, 8(%rdi)
	movq	80(%rsi), %r10
	movq	%r12, 16(%rdi)
	movq	72(%rsi), %r12
	movq	%rbp, 24(%rdi)
	movq	40(%rsi), %rax
	adcq	%rdx, %rax
	movq	64(%rsi), %rdx
	movq	%r13, 32(%rdi)
	movq	56(%rsi), %r13
	movq	48(%rsi), %rbp
	adcq	%r9, %rbp
	movq	%rax, 40(%rdi)
	adcq	%r11, %r13
	adcq	%r15, %rdx
	adcq	%r14, %r12
	adcq	-16(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-8(%rsp), %r8           ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rbp, %rsi
	subq	(%rcx), %rsi
	movq	%r13, %rbx
	sbbq	8(%rcx), %rbx
	movq	%rdx, %r9
	sbbq	16(%rcx), %r9
	movq	%r12, %r11
	sbbq	24(%rcx), %r11
	movq	%r10, %r14
	sbbq	32(%rcx), %r14
	movq	%r8, %r15
	sbbq	40(%rcx), %r15
	sbbq	$0, %rax
	andl	$1, %eax
	cmovneq	%rbp, %rsi
	movq	%rsi, 48(%rdi)
	testb	%al, %al
	cmovneq	%r13, %rbx
	movq	%rbx, 56(%rdi)
	cmovneq	%rdx, %r9
	movq	%r9, 64(%rdi)
	cmovneq	%r12, %r11
	movq	%r11, 72(%rdi)
	cmovneq	%r10, %r14
	movq	%r14, 80(%rdi)
	cmovneq	%r8, %r15
	movq	%r15, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub6L
	.p2align	4, 0x90
_mcl_fpDbl_sub6L:                       ## @mcl_fpDbl_sub6L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	88(%rdx), %r9
	movq	80(%rdx), %r10
	movq	72(%rdx), %r14
	movq	16(%rsi), %r8
	movq	(%rsi), %r15
	movq	8(%rsi), %r11
	xorl	%eax, %eax
	subq	(%rdx), %r15
	sbbq	8(%rdx), %r11
	sbbq	16(%rdx), %r8
	movq	24(%rsi), %rbx
	sbbq	24(%rdx), %rbx
	movq	32(%rsi), %r12
	sbbq	32(%rdx), %r12
	movq	64(%rdx), %r13
	movq	%r15, (%rdi)
	movq	56(%rdx), %rbp
	movq	%r11, 8(%rdi)
	movq	48(%rdx), %r15
	movq	40(%rdx), %rdx
	movq	%r8, 16(%rdi)
	movq	88(%rsi), %r8
	movq	%rbx, 24(%rdi)
	movq	40(%rsi), %rbx
	sbbq	%rdx, %rbx
	movq	80(%rsi), %r11
	movq	%r12, 32(%rdi)
	movq	48(%rsi), %rdx
	sbbq	%r15, %rdx
	movq	72(%rsi), %r15
	movq	%rbx, 40(%rdi)
	movq	64(%rsi), %r12
	movq	56(%rsi), %rsi
	sbbq	%rbp, %rsi
	sbbq	%r13, %r12
	sbbq	%r14, %r15
	sbbq	%r10, %r11
	sbbq	%r9, %r8
	movl	$0, %ebp
	sbbq	$0, %rbp
	andl	$1, %ebp
	movq	(%rcx), %r14
	cmoveq	%rax, %r14
	testb	%bpl, %bpl
	movq	16(%rcx), %r9
	cmoveq	%rax, %r9
	movq	8(%rcx), %rbp
	cmoveq	%rax, %rbp
	movq	40(%rcx), %r10
	cmoveq	%rax, %r10
	movq	32(%rcx), %rbx
	cmoveq	%rax, %rbx
	cmovneq	24(%rcx), %rax
	addq	%rdx, %r14
	movq	%r14, 48(%rdi)
	adcq	%rsi, %rbp
	movq	%rbp, 56(%rdi)
	adcq	%r12, %r9
	movq	%r9, 64(%rdi)
	adcq	%r15, %rax
	movq	%rax, 72(%rdi)
	adcq	%r11, %rbx
	movq	%rbx, 80(%rdi)
	adcq	%r8, %r10
	movq	%r10, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mulUnitPre7L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre7L:                   ## @mcl_fp_mulUnitPre7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	48(%rsi)
	movq	%rdx, %r10
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r11
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	32(%rsi)
	movq	%rdx, %r15
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r13
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	8(%rsi)
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rax, (%rdi)
	addq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%rbp, %r8
	movq	%r8, 16(%rdi)
	adcq	%r12, %rbx
	movq	%rbx, 24(%rdi)
	adcq	%r14, %r13
	movq	%r13, 32(%rdi)
	adcq	-16(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, 40(%rdi)
	adcq	-8(%rsp), %r11          ## 8-byte Folded Reload
	movq	%r11, 48(%rdi)
	adcq	$0, %r10
	movq	%r10, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_mulPre7L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre7L:                    ## @mcl_fpDbl_mulPre7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rsi, %r9
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	(%r9), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rsi
	mulq	%rsi
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	32(%r9), %rbp
	movq	%rbp, -88(%rsp)         ## 8-byte Spill
	movq	40(%r9), %rcx
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	movq	48(%r9), %r14
	movq	%rax, (%rdi)
	movq	%r14, %rax
	mulq	%rsi
	movq	%rdx, %rdi
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	%rsi
	movq	%rdx, %rcx
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rsi
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdx, %rbp
	movq	24(%r9), %r8
	movq	%r8, %rax
	mulq	%rsi
	movq	%rax, %r15
	movq	%rdx, %rbx
	movq	16(%r9), %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	mulq	%rsi
	movq	%rax, %r13
	movq	%rdx, %r12
	movq	8(%r9), %r11
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, %rsi
	movq	%rax, %r10
	addq	-120(%rsp), %r10        ## 8-byte Folded Reload
	adcq	%r13, %rsi
	adcq	%r15, %r12
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, -72(%rsp)         ## 8-byte Spill
	adcq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -104(%rsp)        ## 8-byte Spill
	adcq	$0, %rdi
	movq	%rdi, -96(%rsp)         ## 8-byte Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rcx
	movq	%r14, %rax
	mulq	%rcx
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	-128(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	-112(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %rbp
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %rdi
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	addq	%r10, %rax
	movq	-8(%rsp), %r10          ## 8-byte Reload
	movq	%rax, 8(%r10)
	adcq	%rsi, %rdi
	adcq	%r12, %rbp
	adcq	%rbx, %r14
	adcq	-72(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r13        ## 8-byte Folded Reload
	movq	-80(%rsp), %rax         ## 8-byte Reload
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	%rdx, %rdi
	adcq	%r11, %rbp
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	adcq	%r8, %r15
	adcq	-88(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	movq	48(%r9), %rdx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rdx, %rax
	mulq	%rcx
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	40(%r9), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	32(%r9), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	24(%r9), %rax
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %rbx
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	16(%r9), %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r8
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	8(%r9), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r11
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	(%r9), %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	mulq	%rcx
	addq	%rdi, %rax
	movq	%rax, 16(%r10)
	adcq	%rbp, %r11
	adcq	%r14, %r8
	adcq	%r15, %rbx
	adcq	%r13, %r12
	movq	-128(%rsp), %rdi        ## 8-byte Reload
	adcq	-80(%rsp), %rdi         ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	%rsi, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%rdx, %r11
	adcq	(%rsp), %r8             ## 8-byte Folded Reload
	adcq	8(%rsp), %rbx           ## 8-byte Folded Reload
	adcq	-48(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-40(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, -128(%rsp)        ## 8-byte Spill
	adcq	-32(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rbp
	movq	-64(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	-96(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %r13
	movq	-72(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	-112(%rsp), %rax        ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %rdi
	movq	-24(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	-16(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	addq	%r11, %rax
	movq	-8(%rsp), %rsi          ## 8-byte Reload
	movq	%rax, 24(%rsi)
	adcq	%r8, %r10
	adcq	%rbx, %rdi
	adcq	%r12, %r15
	adcq	-128(%rsp), %r13        ## 8-byte Folded Reload
	movq	-64(%rsp), %rbp         ## 8-byte Reload
	adcq	-120(%rsp), %rbp        ## 8-byte Folded Reload
	movq	-80(%rsp), %rax         ## 8-byte Reload
	adcq	%rcx, %rax
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	%rdx, %r10
	adcq	%r14, %rdi
	adcq	-112(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-72(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-96(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, -64(%rsp)         ## 8-byte Spill
	adcq	-88(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	adcq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	movq	48(%r9), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	-56(%rsp), %rbx         ## 8-byte Reload
	movq	32(%rbx), %rcx
	mulq	%rcx
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	40(%r9), %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	32(%r9), %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	24(%r9), %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %rbp
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	16(%r9), %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r14
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	8(%r9), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rcx
	movq	%rax, %r11
	movq	%rdx, %r8
	movq	(%r9), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	mulq	%rcx
	addq	%r10, %rax
	movq	-8(%rsp), %rcx          ## 8-byte Reload
	movq	%rax, 32(%rcx)
	adcq	%rdi, %r11
	adcq	%r15, %r14
	adcq	%r13, %rbp
	adcq	-64(%rsp), %r12         ## 8-byte Folded Reload
	movq	-128(%rsp), %rcx        ## 8-byte Reload
	adcq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	%rsi, %rax
	sbbq	%r13, %r13
	andl	$1, %r13d
	addq	%rdx, %r11
	adcq	%r8, %r14
	adcq	(%rsp), %rbp            ## 8-byte Folded Reload
	adcq	8(%rsp), %r12           ## 8-byte Folded Reload
	adcq	-48(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	adcq	-40(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %r13         ## 8-byte Folded Reload
	movq	40(%rbx), %rcx
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	-96(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %r10
	movq	-104(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	-112(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	-16(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, %rsi
	movq	-32(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rax, %r8
	movq	-24(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	addq	%r11, %rax
	movq	-8(%rsp), %rcx          ## 8-byte Reload
	movq	%rax, 40(%rcx)
	adcq	%r14, %r8
	adcq	%rbp, %rsi
	adcq	%r12, %rbx
	adcq	-128(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-120(%rsp), %r10        ## 8-byte Folded Reload
	adcq	%r13, %rdi
	movq	-56(%rsp), %rax         ## 8-byte Reload
	movq	48(%rax), %r11
	sbbq	%rcx, %rcx
	movq	%r11, %rax
	mulq	48(%r9)
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%r11, %rax
	mulq	40(%r9)
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%r11, %rax
	mulq	32(%r9)
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r13
	movq	%r11, %rax
	mulq	24(%r9)
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%r11, %rax
	mulq	16(%r9)
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	%r11, %rax
	mulq	8(%r9)
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	(%r9)
	andl	$1, %ecx
	addq	-40(%rsp), %r8          ## 8-byte Folded Reload
	adcq	-16(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-64(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	addq	%rax, %r8
	movq	-8(%rsp), %r9           ## 8-byte Reload
	movq	%r8, 48(%r9)
	adcq	%r12, %rsi
	adcq	%r14, %rbx
	adcq	%rbp, %r15
	adcq	%r13, %r10
	adcq	-32(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	-112(%rsp), %rcx        ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	addq	%rdx, %rsi
	adcq	-48(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%r9, %rdx
	movq	%rsi, 56(%rdx)
	movq	%rbx, 64(%rdx)
	adcq	-24(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, 72(%rdx)
	adcq	-72(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r10, 80(%rdx)
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	movq	%rdi, 88(%rdx)
	adcq	-120(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, 96(%rdx)
	adcq	-56(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 104(%rdx)
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre7L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre7L:                    ## @mcl_fpDbl_sqrPre7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rsi, %r9
	movq	%rdi, -24(%rsp)         ## 8-byte Spill
	movq	24(%r9), %r10
	movq	%r10, -128(%rsp)        ## 8-byte Spill
	movq	32(%r9), %r14
	movq	%r14, -88(%rsp)         ## 8-byte Spill
	movq	40(%r9), %rsi
	movq	%rsi, -80(%rsp)         ## 8-byte Spill
	movq	48(%r9), %rbp
	movq	%rbp, -120(%rsp)        ## 8-byte Spill
	movq	(%r9), %rbx
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rdx, %rcx
	movq	%rax, (%rdi)
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%r14, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%r10, %rax
	mulq	%rbx
	movq	%rax, %r14
	movq	%rdx, %rdi
	movq	16(%r9), %r15
	movq	%r15, %rax
	mulq	%rbx
	movq	%rax, %r10
	movq	%rdx, %r12
	movq	8(%r9), %rbp
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	addq	%rax, %rcx
	adcq	%rdx, %r10
	adcq	%r14, %r12
	adcq	%rsi, %rdi
	adcq	-104(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, -104(%rsp)         ## 8-byte Spill
	adcq	$0, %r11
	movq	%r11, -96(%rsp)         ## 8-byte Spill
	movq	-120(%rsp), %rax        ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	-80(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %rsi
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	-128(%rsp), %rax        ## 8-byte Reload
	mulq	%rbp
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r14
	movq	%r15, %rax
	mulq	%rbp
	movq	%rdx, %r15
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%rbp
	movq	%rax, %rbp
	addq	-72(%rsp), %rcx         ## 8-byte Folded Reload
	movq	-24(%rsp), %rax         ## 8-byte Reload
	movq	%rcx, 8(%rax)
	adcq	%r10, %rbp
	adcq	%r12, %rbx
	adcq	%rdi, %r14
	adcq	%r13, %r11
	movq	%rsi, %rax
	adcq	-104(%rsp), %rax        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r8          ## 8-byte Folded Reload
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	-112(%rsp), %rbp        ## 8-byte Folded Reload
	adcq	%rdx, %rbx
	adcq	%r15, %r14
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-88(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	adcq	-80(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, -40(%rsp)          ## 8-byte Spill
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	movq	48(%r9), %rax
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	16(%r9), %rdi
	mulq	%rdi
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	40(%r9), %rax
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	32(%r9), %rax
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r13
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	24(%r9), %rcx
	movq	%rcx, %rax
	mulq	%rdi
	movq	%rax, %r10
	movq	%r10, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, %r12
	movq	%r12, -72(%rsp)         ## 8-byte Spill
	movq	8(%r9), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r15
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	(%r9), %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, %rdi
	addq	%rbp, %r8
	movq	-24(%rsp), %rax         ## 8-byte Reload
	movq	%r8, 16(%rax)
	adcq	%rbx, %r15
	adcq	%r14, %rdi
	adcq	%r10, %r11
	adcq	-48(%rsp), %r13         ## 8-byte Folded Reload
	movq	-56(%rsp), %r10         ## 8-byte Reload
	adcq	-40(%rsp), %r10         ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	%rsi, %rax
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	addq	-16(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-64(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	%rdx, %r11
	adcq	%r12, %r13
	adcq	-32(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rbp         ## 8-byte Folded Reload
	movq	-112(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r14
	movq	-80(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	-88(%rsp), %rax         ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rax, %r8
	movq	(%rsp), %rax            ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	-104(%rsp), %rax        ## 8-byte Reload
	mulq	%rcx
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	addq	%r15, %rbx
	movq	-24(%rsp), %rcx         ## 8-byte Reload
	movq	%rbx, 24(%rcx)
	adcq	%rdi, %r12
	adcq	-8(%rsp), %r11          ## 8-byte Folded Reload
	adcq	%r13, %rax
	movq	%rax, %r15
	movq	%r8, %rsi
	adcq	%r10, %rsi
	movq	-112(%rsp), %rbx        ## 8-byte Reload
	adcq	-120(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	%rbp, %r14
	sbbq	%r8, %r8
	movq	8(%r9), %rcx
	movq	40(%r9), %r13
	movq	%rcx, %rax
	mulq	%r13
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	(%r9), %rbp
	movq	%rbp, %rax
	mulq	%r13
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	32(%r9), %rdi
	movq	%rcx, %rax
	mulq	%rdi
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, %rbp
	movq	%rdx, (%rsp)            ## 8-byte Spill
	andl	$1, %r8d
	addq	-64(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-48(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, -64(%rsp)         ## 8-byte Spill
	adcq	-56(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, -56(%rsp)         ## 8-byte Spill
	adcq	-40(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, -112(%rsp)        ## 8-byte Spill
	adcq	-32(%rsp), %r14         ## 8-byte Folded Reload
	adcq	-128(%rsp), %r8         ## 8-byte Folded Reload
	movq	48(%r9), %rax
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %rcx
	movq	%r13, %rax
	mulq	%rdi
	movq	%rax, %rsi
	movq	%rsi, -48(%rsp)         ## 8-byte Spill
	movq	%rdx, %rbx
	movq	24(%r9), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r15
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	16(%r9), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	%rdi
	movq	%rax, %rdi
	addq	%rbp, %r12
	movq	-24(%rsp), %rbp         ## 8-byte Reload
	movq	%r12, 32(%rbp)
	adcq	-8(%rsp), %r11          ## 8-byte Folded Reload
	adcq	-64(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-56(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	%rsi, %r14
	adcq	%r8, %rcx
	sbbq	%rsi, %rsi
	andl	$1, %esi
	addq	(%rsp), %r11            ## 8-byte Folded Reload
	adcq	-120(%rsp), %r10        ## 8-byte Folded Reload
	adcq	8(%rsp), %r15           ## 8-byte Folded Reload
	adcq	-16(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	%rdx, %r14
	adcq	%rbx, %rcx
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	movq	-128(%rsp), %rax        ## 8-byte Reload
	mulq	%r13
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	-32(%rsp), %rax         ## 8-byte Reload
	mulq	%r13
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	-40(%rsp), %rax         ## 8-byte Reload
	mulq	%r13
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	%r13, %rax
	mulq	%r13
	movq	%rax, %r13
	addq	-104(%rsp), %r11        ## 8-byte Folded Reload
	movq	%r11, 40(%rbp)
	adcq	-96(%rsp), %r10         ## 8-byte Folded Reload
	adcq	%r15, %r12
	adcq	%rdi, %r8
	movq	%r14, %rax
	adcq	-48(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%rcx, %r13
	movq	-120(%rsp), %rcx        ## 8-byte Reload
	adcq	%rsi, %rcx
	sbbq	%r14, %r14
	andl	$1, %r14d
	addq	-88(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, -104(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	adcq	%rbx, %r13
	adcq	%rdx, %rcx
	movq	%rcx, -120(%rsp)        ## 8-byte Spill
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	movq	48(%r9), %rcx
	movq	%rcx, %rax
	mulq	40(%r9)
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	32(%r9)
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	24(%r9)
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	16(%r9)
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	8(%r9)
	movq	%rdx, %r15
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	(%r9)
	movq	%rdx, %r9
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	%rcx
	addq	%r10, %rsi
	movq	-24(%rsp), %r10         ## 8-byte Reload
	movq	%rsi, 48(%r10)
	adcq	%r12, %rdi
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-96(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	%r13, %rbx
	adcq	-120(%rsp), %r8         ## 8-byte Folded Reload
	adcq	%r14, %rax
	sbbq	%rcx, %rcx
	andl	$1, %ecx
	addq	%r9, %rdi
	adcq	%r15, %r11
	movq	%r10, %rsi
	movq	%rdi, 56(%rsi)
	movq	%r11, 64(%rsi)
	adcq	-128(%rsp), %rbp        ## 8-byte Folded Reload
	movq	%rbp, 72(%rsi)
	adcq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, 80(%rsi)
	adcq	-80(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, 88(%rsi)
	adcq	-112(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, 96(%rsi)
	adcq	%rdx, %rcx
	movq	%rcx, 104(%rsi)
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont7L
	.p2align	4, 0x90
_mcl_fp_mont7L:                         ## @mcl_fp_mont7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rdi, 80(%rsp)          ## 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	%rdx, %r12
	movq	40(%rsi), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	%rdx, %r8
	movq	32(%rsi), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, %r9
	movq	24(%rsi), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r11
	movq	16(%rsi), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	mulq	%rdi
	movq	%rax, %r15
	movq	%rdx, %rbx
	movq	(%rsi), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdx, %r10
	addq	%rsi, %r10
	adcq	%r15, %r13
	adcq	%r14, %rbx
	movq	%rbx, -72(%rsp)         ## 8-byte Spill
	adcq	-8(%rsp), %r11          ## 8-byte Folded Reload
	movq	%r11, -56(%rsp)         ## 8-byte Spill
	adcq	(%rsp), %r9             ## 8-byte Folded Reload
	movq	%r9, -112(%rsp)         ## 8-byte Spill
	adcq	8(%rsp), %r8            ## 8-byte Folded Reload
	movq	%r8, -104(%rsp)         ## 8-byte Spill
	adcq	$0, %r12
	movq	%r12, -96(%rsp)         ## 8-byte Spill
	movq	-8(%rcx), %rdx
	movq	%rdx, 40(%rsp)          ## 8-byte Spill
	movq	%rax, %rdi
	imulq	%rdx, %rdi
	movq	48(%rcx), %rdx
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	40(%rcx), %rdx
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, %r9
	movq	24(%rcx), %rdx
	movq	%rdx, 64(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r8
	movq	%rdx, %rbx
	movq	16(%rcx), %rdx
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r15
	movq	%rdx, %rbp
	movq	(%rcx), %rsi
	movq	%rsi, 48(%rsp)          ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	%rsi
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%r15, %rcx
	adcq	%r8, %rbp
	adcq	%r14, %rbx
	adcq	-64(%rsp), %r9          ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	-88(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-120(%rsp), %rdi        ## 8-byte Reload
	adcq	$0, %rdi
	addq	-80(%rsp), %rax         ## 8-byte Folded Reload
	adcq	%r10, %r11
	adcq	%r13, %rcx
	adcq	-72(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-56(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	movq	%r9, -56(%rsp)          ## 8-byte Spill
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, -120(%rsp)        ## 8-byte Spill
	sbbq	%rsi, %rsi
	andl	$1, %esi
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rdi
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %r14
	addq	%r9, %r14
	adcq	%r12, %r13
	adcq	-64(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r10         ## 8-byte Folded Reload
	movq	-112(%rsp), %rdi        ## 8-byte Reload
	adcq	-80(%rsp), %rdi         ## 8-byte Folded Reload
	movq	-104(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r8
	adcq	%rcx, %r14
	adcq	%rbp, %r13
	adcq	%rbx, %r15
	adcq	-56(%rsp), %r10         ## 8-byte Folded Reload
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	movq	%rdi, -112(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	adcq	%rsi, %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%r8, %rcx
	imulq	40(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	72(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	addq	%rbp, %rcx
	adcq	%rdi, %rsi
	adcq	%rbx, %r9
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r11         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdi        ## 8-byte Reload
	adcq	-72(%rsp), %rdi         ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r8, %rax
	adcq	%r14, %rcx
	adcq	%r13, %rsi
	adcq	%r15, %r9
	adcq	%r10, %r12
	adcq	-112(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rdi        ## 8-byte Folded Reload
	movq	%rdi, -128(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	$0, -56(%rsp)           ## 8-byte Folded Spill
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rbx
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r14
	movq	%rdx, %r10
	addq	%r15, %r10
	adcq	%r8, %rdi
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r13         ## 8-byte Folded Reload
	movq	-112(%rsp), %rbx        ## 8-byte Reload
	adcq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-104(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rcx, %r14
	adcq	%rsi, %r10
	adcq	%r9, %rdi
	adcq	%r12, %rbp
	adcq	%r11, %r13
	adcq	-128(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -112(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	adcq	-56(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%r14, %rbx
	imulq	40(%rsp), %rbx          ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	72(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%r15, %r8
	adcq	-64(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r9          ## 8-byte Folded Reload
	movq	-128(%rsp), %rbx        ## 8-byte Reload
	adcq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r14, %rax
	adcq	%r10, %r11
	adcq	%rdi, %r8
	adcq	%rbp, %rsi
	adcq	%r13, %rcx
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -128(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	$0, -56(%rsp)           ## 8-byte Folded Spill
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rbx
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r13
	addq	%r15, %r13
	adcq	%r14, %rdi
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	movq	-112(%rsp), %rbx        ## 8-byte Reload
	adcq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-104(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r10
	adcq	%r8, %r13
	adcq	%rsi, %rdi
	adcq	%rcx, %rbp
	adcq	%r9, %r12
	adcq	-128(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -112(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	adcq	-56(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%r10, %rbx
	imulq	40(%rsp), %rbx          ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	72(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r15, %r11
	adcq	%r14, %r8
	adcq	-64(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r9          ## 8-byte Folded Reload
	movq	-128(%rsp), %rbx        ## 8-byte Reload
	adcq	-72(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-120(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %rax
	adcq	%r13, %r11
	adcq	%rdi, %r8
	adcq	%rbp, %rsi
	adcq	%r12, %rcx
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-104(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -128(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	adcq	$0, -56(%rsp)           ## 8-byte Folded Spill
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	32(%rax), %rbx
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r12
	addq	%r14, %r12
	adcq	%r13, %rdi
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r15         ## 8-byte Folded Reload
	movq	-112(%rsp), %rbx        ## 8-byte Reload
	adcq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-104(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r10
	adcq	%r8, %r12
	adcq	%rsi, %rdi
	adcq	%rcx, %rbp
	adcq	%r9, %r15
	adcq	-128(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -112(%rsp)        ## 8-byte Spill
	adcq	-120(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	adcq	-56(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%r10, %rcx
	imulq	40(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	72(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r8, %r11
	adcq	%r14, %rbx
	adcq	-64(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-80(%rsp), %r13         ## 8-byte Folded Reload
	movq	-56(%rsp), %rdx         ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-128(%rsp), %rcx        ## 8-byte Reload
	adcq	$0, %rcx
	addq	%r10, %rax
	adcq	%r12, %r11
	adcq	%rdi, %rbx
	adcq	%rbp, %rsi
	adcq	%r15, %r9
	adcq	-112(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	adcq	-96(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	movq	-120(%rsp), %r15        ## 8-byte Reload
	adcq	$0, %r15
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	40(%rax), %rcx
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r8
	addq	%r14, %r8
	adcq	%r12, %rdi
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	movq	-120(%rsp), %r14        ## 8-byte Reload
	adcq	-88(%rsp), %r14         ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	-80(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-104(%rsp), %rcx        ## 8-byte Reload
	adcq	-72(%rsp), %rcx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r10
	adcq	%rbx, %r8
	adcq	%rsi, %rdi
	adcq	%r9, %rbp
	adcq	%r13, %r14
	movq	%r14, -120(%rsp)        ## 8-byte Spill
	adcq	-56(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	-128(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, -104(%rsp)        ## 8-byte Spill
	adcq	%r15, %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%r10, %rcx
	imulq	40(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	72(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r9, %r11
	adcq	%r13, %rbx
	adcq	-64(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r14         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %rax
	adcq	%r8, %r11
	adcq	%rdi, %rbx
	adcq	%rbp, %r15
	adcq	-120(%rsp), %r12        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	movq	%rsi, -112(%rsp)        ## 8-byte Spill
	adcq	-104(%rsp), %r14        ## 8-byte Folded Reload
	movq	%r14, -104(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	-56(%rsp), %r8          ## 8-byte Reload
	adcq	$0, %r8
	movq	-16(%rsp), %rax         ## 8-byte Reload
	movq	48(%rax), %rcx
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%rdx, %r10
	addq	%rbp, %r10
	adcq	%rdi, %r14
	adcq	-48(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-40(%rsp), %r9          ## 8-byte Folded Reload
	movq	-32(%rsp), %rcx         ## 8-byte Reload
	adcq	-120(%rsp), %rcx        ## 8-byte Folded Reload
	movq	-24(%rsp), %rax         ## 8-byte Reload
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	-16(%rsp), %rdi         ## 8-byte Reload
	adcq	$0, %rdi
	addq	%r11, %rsi
	movq	%rsi, -48(%rsp)         ## 8-byte Spill
	adcq	%rbx, %r10
	adcq	%r15, %r14
	adcq	%r12, %r13
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	movq	%r9, -40(%rsp)          ## 8-byte Spill
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	movq	%rcx, -32(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	adcq	%r8, %rdi
	movq	%rdi, -16(%rsp)         ## 8-byte Spill
	sbbq	%rcx, %rcx
	movq	40(%rsp), %r8           ## 8-byte Reload
	imulq	%rsi, %r8
	movq	%r8, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	%r8, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	%r8, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	%r8, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	%r8, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r11
	movq	%r8, %rax
	movq	%r8, %r12
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	%r12, %rax
	movq	72(%rsp), %r12          ## 8-byte Reload
	mulq	%r12
	andl	$1, %ecx
	addq	%r15, %rax
	adcq	%r11, %rdx
	adcq	16(%rsp), %rbp          ## 8-byte Folded Reload
	adcq	24(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	32(%rsp), %rsi          ## 8-byte Folded Reload
	adcq	40(%rsp), %r9           ## 8-byte Folded Reload
	adcq	$0, %rdi
	addq	-48(%rsp), %r8          ## 8-byte Folded Reload
	adcq	%r10, %rax
	adcq	%r14, %rdx
	adcq	%r13, %rbp
	adcq	-40(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-32(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-24(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-16(%rsp), %rdi         ## 8-byte Folded Reload
	adcq	$0, %rcx
	movq	%rax, %r8
	subq	48(%rsp), %r8           ## 8-byte Folded Reload
	movq	%rdx, %r10
	sbbq	%r12, %r10
	movq	%rbp, %r11
	sbbq	56(%rsp), %r11          ## 8-byte Folded Reload
	movq	%rbx, %r14
	sbbq	64(%rsp), %r14          ## 8-byte Folded Reload
	movq	%rsi, %r15
	sbbq	-8(%rsp), %r15          ## 8-byte Folded Reload
	movq	%r9, %r12
	sbbq	(%rsp), %r12            ## 8-byte Folded Reload
	movq	%rdi, %r13
	sbbq	8(%rsp), %r13           ## 8-byte Folded Reload
	sbbq	$0, %rcx
	andl	$1, %ecx
	cmovneq	%rdi, %r13
	testb	%cl, %cl
	cmovneq	%rax, %r8
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	%r8, (%rax)
	cmovneq	%rdx, %r10
	movq	%r10, 8(%rax)
	cmovneq	%rbp, %r11
	movq	%r11, 16(%rax)
	cmovneq	%rbx, %r14
	movq	%r14, 24(%rax)
	cmovneq	%rsi, %r15
	movq	%r15, 32(%rax)
	cmovneq	%r9, %r12
	movq	%r12, 40(%rax)
	movq	%r13, 48(%rax)
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF7L
	.p2align	4, 0x90
_mcl_fp_montNF7L:                       ## @mcl_fp_montNF7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$80, %rsp
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rdi, 72(%rsp)          ## 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	(%rdx), %rbx
	mulq	%rbx
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rdx, %r12
	movq	40(%rsi), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	mulq	%rbx
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	%rdx, %r8
	movq	32(%rsi), %rax
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	mulq	%rbx
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	%rdx, %rbp
	movq	24(%rsi), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	mulq	%rbx
	movq	%rax, %r10
	movq	%rdx, %r15
	movq	16(%rsi), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	mulq	%rbx
	movq	%rax, %r9
	movq	%rdx, %r14
	movq	(%rsi), %rdi
	movq	%rdi, -8(%rsp)          ## 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rdx, %rsi
	addq	%r11, %rsi
	adcq	%r9, %r13
	adcq	%r10, %r14
	adcq	-32(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-24(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, -128(%rsp)        ## 8-byte Spill
	adcq	-16(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, -120(%rsp)         ## 8-byte Spill
	adcq	$0, %r12
	movq	%r12, -104(%rsp)        ## 8-byte Spill
	movq	-8(%rcx), %rdx
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	movq	%rax, %r10
	movq	%rax, %r8
	imulq	%rdx, %r10
	movq	48(%rcx), %rdx
	movq	%rdx, 32(%rsp)          ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rdx
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	40(%rcx), %rdx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rdx
	movq	%rax, %r11
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rdx
	movq	%rax, %rbp
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rdx
	movq	%rax, %r12
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rdx
	movq	%rax, %rbx
	movq	%rdx, 24(%rsp)          ## 8-byte Spill
	movq	(%rcx), %rdi
	movq	%rdi, 40(%rsp)          ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %rcx
	movq	%r10, %rax
	mulq	%rdi
	addq	%r8, %rax
	adcq	%rsi, %rcx
	adcq	%r13, %rbx
	adcq	%r14, %r12
	adcq	%r15, %rbp
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	movq	-112(%rsp), %rdi        ## 8-byte Reload
	adcq	-120(%rsp), %rdi        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rcx
	adcq	%r9, %rbx
	adcq	24(%rsp), %r12          ## 8-byte Folded Reload
	adcq	-88(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r11, -120(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, -112(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	8(%rax), %rsi
	movq	%rsi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	%rsi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r15
	addq	%r11, %r15
	adcq	%rdi, %r8
	adcq	24(%rsp), %r9           ## 8-byte Folded Reload
	adcq	-88(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r14         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rcx, %r10
	adcq	%rbx, %r15
	adcq	%r12, %r8
	adcq	%rbp, %r9
	adcq	-120(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r14        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%r10, %rsi
	imulq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	movq	%rsi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%r15, %rbp
	adcq	%r8, %r12
	adcq	%r9, %r11
	adcq	%r13, %rbx
	movq	-120(%rsp), %r8         ## 8-byte Reload
	adcq	%r14, %r8
	movq	-112(%rsp), %rsi        ## 8-byte Reload
	adcq	-128(%rsp), %rsi        ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rbp
	adcq	%rdi, %r12
	adcq	%rcx, %r11
	adcq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, -120(%rsp)         ## 8-byte Spill
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, -112(%rsp)        ## 8-byte Spill
	adcq	-104(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	16(%rax), %rdi
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -104(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r13
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r15
	addq	%r13, %r15
	adcq	%r14, %rcx
	adcq	24(%rsp), %r8           ## 8-byte Folded Reload
	adcq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r9          ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	-72(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rbp, %r10
	adcq	%r12, %r15
	adcq	%r11, %rcx
	adcq	%rbx, %r8
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r9         ## 8-byte Folded Reload
	adcq	-96(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%r10, %rdi
	imulq	16(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%r15, %rbx
	adcq	%rcx, %rbp
	adcq	%r8, %r12
	adcq	%rsi, %r11
	movq	-112(%rsp), %rcx        ## 8-byte Reload
	adcq	%r9, %rcx
	movq	-96(%rsp), %rsi         ## 8-byte Reload
	adcq	-128(%rsp), %rsi        ## 8-byte Folded Reload
	movq	-104(%rsp), %rax        ## 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rbx
	adcq	%r14, %rbp
	adcq	%r13, %r12
	adcq	-120(%rsp), %r11        ## 8-byte Folded Reload
	movq	%r11, -120(%rsp)        ## 8-byte Spill
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -112(%rsp)        ## 8-byte Spill
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, -96(%rsp)         ## 8-byte Spill
	adcq	-72(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	24(%rax), %rdi
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r13
	movq	%rdi, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %rdi
	addq	%r14, %rdi
	adcq	%r13, %r8
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-128(%rsp), %r11        ## 8-byte Folded Reload
	adcq	$0, %r9
	addq	%rbx, %r10
	adcq	%rbp, %rdi
	adcq	%r12, %r8
	adcq	-120(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r11        ## 8-byte Folded Reload
	movq	%r11, -112(%rsp)        ## 8-byte Spill
	adcq	$0, %r9
	movq	%r10, %rbp
	imulq	16(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r11
	movq	%rbp, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%rdi, %rbx
	adcq	%r8, %r11
	adcq	%rcx, %r12
	adcq	%rsi, %r14
	movq	-104(%rsp), %rcx        ## 8-byte Reload
	adcq	%r15, %rcx
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	-112(%rsp), %rax        ## 8-byte Folded Reload
	adcq	$0, %r9
	addq	%rdx, %rbx
	adcq	%r13, %r11
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r14         ## 8-byte Folded Reload
	movq	%r14, -112(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -104(%rsp)        ## 8-byte Spill
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	adcq	-120(%rsp), %r9         ## 8-byte Folded Reload
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	32(%rax), %rdi
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %rdi
	movq	%rdx, %r13
	addq	%r14, %r13
	adcq	%rbp, %r8
	adcq	-88(%rsp), %rcx         ## 8-byte Folded Reload
	adcq	-80(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r10         ## 8-byte Folded Reload
	movq	-120(%rsp), %rax        ## 8-byte Reload
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	adcq	$0, %r15
	addq	%rbx, %rdi
	adcq	%r11, %r13
	adcq	%r12, %r8
	adcq	-112(%rsp), %rcx        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-96(%rsp), %r10         ## 8-byte Folded Reload
	adcq	%r9, %rax
	movq	%rax, -120(%rsp)        ## 8-byte Spill
	adcq	$0, %r15
	movq	%rdi, %rbp
	imulq	16(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r9
	movq	%rbp, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%r13, %rbx
	adcq	%r8, %r14
	adcq	%rcx, %r12
	adcq	%rsi, %r9
	movq	-112(%rsp), %rcx        ## 8-byte Reload
	adcq	%r10, %rcx
	movq	-104(%rsp), %rax        ## 8-byte Reload
	adcq	-120(%rsp), %rax        ## 8-byte Folded Reload
	adcq	$0, %r15
	addq	%rdx, %rbx
	adcq	%r11, %r14
	adcq	-88(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-128(%rsp), %r9         ## 8-byte Folded Reload
	movq	%r9, -128(%rsp)         ## 8-byte Spill
	adcq	-80(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -112(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	adcq	-96(%rsp), %r15         ## 8-byte Folded Reload
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	40(%rax), %rbp
	movq	%rbp, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %rcx
	movq	%rbp, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rbp, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r11
	movq	%rdx, %r10
	addq	%r9, %r10
	adcq	%rcx, %r8
	adcq	24(%rsp), %rdi          ## 8-byte Folded Reload
	adcq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-80(%rsp), %r13         ## 8-byte Folded Reload
	movq	-120(%rsp), %rcx        ## 8-byte Reload
	adcq	-72(%rsp), %rcx         ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rbx, %r11
	adcq	%r14, %r10
	adcq	%r12, %r8
	adcq	-128(%rsp), %rdi        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-104(%rsp), %r13        ## 8-byte Folded Reload
	adcq	%r15, %rcx
	movq	%rcx, -120(%rsp)        ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%r11, %rbx
	imulq	16(%rsp), %rbx          ## 8-byte Folded Reload
	movq	%rbx, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	movq	%rax, -112(%rsp)        ## 8-byte Spill
	movq	%rbx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	addq	%r11, %rax
	adcq	%r10, %rcx
	adcq	%r8, %rbp
	adcq	%rdi, %r15
	adcq	%rsi, %r9
	movq	-112(%rsp), %rbx        ## 8-byte Reload
	adcq	%r13, %rbx
	movq	-104(%rsp), %rsi        ## 8-byte Reload
	adcq	-120(%rsp), %rsi        ## 8-byte Folded Reload
	movq	-96(%rsp), %rax         ## 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rcx
	adcq	%r12, %rbp
	adcq	%r14, %r15
	adcq	-88(%rsp), %r9          ## 8-byte Folded Reload
	movq	%r9, -120(%rsp)         ## 8-byte Spill
	adcq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, -112(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, -104(%rsp)        ## 8-byte Spill
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	-40(%rsp), %rax         ## 8-byte Reload
	movq	48(%rax), %rdi
	movq	%rdi, %rax
	mulq	-48(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-56(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	movq	%rax, -64(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	64(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	-8(%rsp)                ## 8-byte Folded Reload
	movq	%rax, %r12
	movq	%rdx, %r8
	addq	%rsi, %r8
	adcq	%rbx, %r10
	adcq	%r9, %r11
	adcq	-64(%rsp), %r13         ## 8-byte Folded Reload
	movq	-48(%rsp), %rdx         ## 8-byte Reload
	adcq	-56(%rsp), %rdx         ## 8-byte Folded Reload
	movq	-40(%rsp), %rax         ## 8-byte Reload
	adcq	-128(%rsp), %rax        ## 8-byte Folded Reload
	adcq	$0, %r14
	addq	%rcx, %r12
	adcq	%rbp, %r8
	adcq	%r15, %r10
	adcq	-120(%rsp), %r11        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r13        ## 8-byte Folded Reload
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -48(%rsp)         ## 8-byte Spill
	adcq	-96(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	adcq	$0, %r14
	movq	16(%rsp), %rdi          ## 8-byte Reload
	imulq	%r12, %rdi
	movq	%rdi, %rax
	mulq	32(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -56(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%rax, %rcx
	movq	%rdi, %rax
	mulq	40(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	56(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -8(%rsp)          ## 8-byte Spill
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	48(%rsp)                ## 8-byte Folded Reload
	addq	%r12, %r15
	adcq	%r8, %rax
	adcq	%r10, %rbx
	adcq	%r11, %rcx
	adcq	%r13, %rsi
	adcq	-48(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-40(%rsp), %r9          ## 8-byte Folded Reload
	adcq	$0, %r14
	addq	(%rsp), %rax            ## 8-byte Folded Reload
	adcq	%rdx, %rbx
	adcq	-8(%rsp), %rcx          ## 8-byte Folded Reload
	adcq	8(%rsp), %rsi           ## 8-byte Folded Reload
	adcq	-64(%rsp), %rbp         ## 8-byte Folded Reload
	adcq	-56(%rsp), %r9          ## 8-byte Folded Reload
	adcq	16(%rsp), %r14          ## 8-byte Folded Reload
	movq	%rax, %r13
	subq	40(%rsp), %r13          ## 8-byte Folded Reload
	movq	%rbx, %r12
	sbbq	48(%rsp), %r12          ## 8-byte Folded Reload
	movq	%rcx, %r8
	sbbq	56(%rsp), %r8           ## 8-byte Folded Reload
	movq	%rsi, %r10
	sbbq	-32(%rsp), %r10         ## 8-byte Folded Reload
	movq	%rbp, %r11
	sbbq	-24(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r9, %r15
	sbbq	-16(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r14, %rdx
	sbbq	32(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, %rdi
	sarq	$63, %rdi
	cmovsq	%rax, %r13
	movq	72(%rsp), %rax          ## 8-byte Reload
	movq	%r13, (%rax)
	cmovsq	%rbx, %r12
	movq	%r12, 8(%rax)
	cmovsq	%rcx, %r8
	movq	%r8, 16(%rax)
	cmovsq	%rsi, %r10
	movq	%r10, 24(%rax)
	cmovsq	%rbp, %r11
	movq	%r11, 32(%rax)
	cmovsq	%r9, %r15
	movq	%r15, 40(%rax)
	cmovsq	%r14, %rdx
	movq	%rdx, 48(%rax)
	addq	$80, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed7L
	.p2align	4, 0x90
_mcl_fp_montRed7L:                      ## @mcl_fp_montRed7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
	movq	%rdx, %rcx
	movq	%rdi, 64(%rsp)          ## 8-byte Spill
	movq	-8(%rcx), %rax
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	(%rsi), %rbp
	movq	%rbp, -48(%rsp)         ## 8-byte Spill
	imulq	%rax, %rbp
	movq	48(%rcx), %rdx
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	40(%rcx), %rdx
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rdx, %r15
	movq	32(%rcx), %rdx
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, %r11
	movq	24(%rcx), %rdx
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r13
	movq	%rdx, %r10
	movq	16(%rcx), %rdx
	movq	%rdx, -16(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r9
	movq	%rdx, %r12
	movq	(%rcx), %rdi
	movq	%rdi, 24(%rsp)          ## 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -24(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, %r8
	addq	%rbx, %r8
	adcq	%r9, %rcx
	adcq	%r13, %r12
	adcq	%r14, %r10
	adcq	-72(%rsp), %r11         ## 8-byte Folded Reload
	adcq	-104(%rsp), %r15        ## 8-byte Folded Reload
	movq	-128(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	-48(%rsp), %rax         ## 8-byte Folded Reload
	adcq	8(%rsi), %r8
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %r12
	adcq	32(%rsi), %r10
	movq	%r10, 40(%rsp)          ## 8-byte Spill
	adcq	40(%rsi), %r11
	movq	%r11, -40(%rsp)         ## 8-byte Spill
	adcq	48(%rsi), %r15
	movq	%r15, -96(%rsp)         ## 8-byte Spill
	adcq	56(%rsi), %rdx
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	104(%rsi), %rax
	movq	96(%rsi), %rdx
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rbp
	movq	72(%rsi), %rbx
	movq	64(%rsi), %r9
	adcq	$0, %r9
	adcq	$0, %rbx
	movq	%rbx, -8(%rsp)          ## 8-byte Spill
	adcq	$0, %rbp
	movq	%rbp, -80(%rsp)         ## 8-byte Spill
	adcq	$0, %rdi
	movq	%rdi, -64(%rsp)         ## 8-byte Spill
	adcq	$0, %rdx
	movq	%rdx, -72(%rsp)         ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	%r8, %rdi
	imulq	-56(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	movq	16(%rsp), %r13          ## 8-byte Reload
	mulq	%r13
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, 56(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r14
	addq	%r15, %r14
	adcq	%rsi, %r11
	adcq	%r10, %rbp
	adcq	56(%rsp), %rbx          ## 8-byte Folded Reload
	movq	-88(%rsp), %rdi         ## 8-byte Reload
	adcq	48(%rsp), %rdi          ## 8-byte Folded Reload
	movq	-120(%rsp), %rsi        ## 8-byte Reload
	adcq	32(%rsp), %rsi          ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r8, %rax
	adcq	%rcx, %r14
	adcq	%r12, %r11
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	adcq	-40(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-96(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, -88(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %rsi        ## 8-byte Folded Reload
	movq	%rsi, -120(%rsp)        ## 8-byte Spill
	adcq	%r9, %rdx
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	$0, -8(%rsp)            ## 8-byte Folded Spill
	adcq	$0, -80(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -72(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -104(%rsp)          ## 8-byte Folded Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	movq	%r14, %rcx
	imulq	-56(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	movq	8(%rsp), %r15           ## 8-byte Reload
	mulq	%r15
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	mulq	%r13
	movq	%rdx, -40(%rsp)         ## 8-byte Spill
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r10
	addq	%r13, %r10
	adcq	%r12, %r9
	adcq	%r8, %rdi
	adcq	48(%rsp), %rsi          ## 8-byte Folded Reload
	movq	-40(%rsp), %r8          ## 8-byte Reload
	adcq	32(%rsp), %r8           ## 8-byte Folded Reload
	movq	-96(%rsp), %rdx         ## 8-byte Reload
	adcq	40(%rsp), %rdx          ## 8-byte Folded Reload
	movq	-128(%rsp), %rcx        ## 8-byte Reload
	adcq	$0, %rcx
	addq	%r14, %rax
	adcq	%r11, %r10
	adcq	%rbp, %r9
	adcq	%rbx, %rdi
	adcq	-88(%rsp), %rsi         ## 8-byte Folded Reload
	adcq	-120(%rsp), %r8         ## 8-byte Folded Reload
	movq	%r8, -40(%rsp)          ## 8-byte Spill
	adcq	-112(%rsp), %rdx        ## 8-byte Folded Reload
	movq	%rdx, -96(%rsp)         ## 8-byte Spill
	adcq	-8(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, -128(%rsp)        ## 8-byte Spill
	adcq	$0, -80(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -72(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -104(%rsp)          ## 8-byte Folded Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	movq	%r10, %rbp
	imulq	-56(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, %rax
	movq	(%rsp), %r8             ## 8-byte Reload
	mulq	%r8
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	%r15
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -88(%rsp)         ## 8-byte Spill
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%rbp, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r14
	movq	%rbp, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r15
	movq	%rbp, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r15, %r11
	adcq	%r14, %rbx
	adcq	%r13, %rcx
	adcq	32(%rsp), %r12          ## 8-byte Folded Reload
	movq	-88(%rsp), %r14         ## 8-byte Reload
	adcq	40(%rsp), %r14          ## 8-byte Folded Reload
	movq	-120(%rsp), %rbp        ## 8-byte Reload
	adcq	-8(%rsp), %rbp          ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %rax
	adcq	%r9, %r11
	adcq	%rdi, %rbx
	adcq	%rsi, %rcx
	adcq	-40(%rsp), %r12         ## 8-byte Folded Reload
	adcq	-96(%rsp), %r14         ## 8-byte Folded Reload
	movq	%r14, -88(%rsp)         ## 8-byte Spill
	adcq	-128(%rsp), %rbp        ## 8-byte Folded Reload
	movq	%rbp, -120(%rsp)        ## 8-byte Spill
	adcq	-80(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	$0, -64(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -72(%rsp)           ## 8-byte Folded Spill
	adcq	$0, -104(%rsp)          ## 8-byte Folded Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	movq	%r11, %rdi
	imulq	-56(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	%r8
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -128(%rsp)        ## 8-byte Spill
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r9
	addq	%r8, %r9
	adcq	%r10, %rbp
	adcq	%r14, %rsi
	adcq	-8(%rsp), %r13          ## 8-byte Folded Reload
	adcq	-40(%rsp), %r15         ## 8-byte Folded Reload
	movq	-128(%rsp), %rdi        ## 8-byte Reload
	adcq	-96(%rsp), %rdi         ## 8-byte Folded Reload
	movq	-80(%rsp), %rdx         ## 8-byte Reload
	adcq	$0, %rdx
	addq	%r11, %rax
	adcq	%rbx, %r9
	adcq	%rcx, %rbp
	adcq	%r12, %rsi
	adcq	-88(%rsp), %r13         ## 8-byte Folded Reload
	adcq	-120(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-112(%rsp), %rdi        ## 8-byte Folded Reload
	movq	%rdi, -128(%rsp)        ## 8-byte Spill
	adcq	-64(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -80(%rsp)         ## 8-byte Spill
	adcq	$0, -72(%rsp)           ## 8-byte Folded Spill
	movq	-104(%rsp), %r14        ## 8-byte Reload
	adcq	$0, %r14
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	movq	%r9, %rdi
	imulq	-56(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, -64(%rsp)         ## 8-byte Spill
	movq	%rax, -104(%rsp)        ## 8-byte Spill
	movq	%rdi, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	movq	%rax, -88(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, -120(%rsp)        ## 8-byte Spill
	movq	%rax, -96(%rsp)         ## 8-byte Spill
	movq	%rdi, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rcx
	movq	%rdi, %rax
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	24(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %rdi
	addq	%r8, %rdi
	adcq	%rcx, %r10
	adcq	%rbx, %r11
	adcq	-96(%rsp), %r12         ## 8-byte Folded Reload
	movq	-120(%rsp), %rbx        ## 8-byte Reload
	adcq	-88(%rsp), %rbx         ## 8-byte Folded Reload
	movq	-112(%rsp), %rdx        ## 8-byte Reload
	adcq	-104(%rsp), %rdx        ## 8-byte Folded Reload
	movq	-64(%rsp), %rcx         ## 8-byte Reload
	adcq	$0, %rcx
	addq	%r9, %rax
	adcq	%rbp, %rdi
	adcq	%rsi, %r10
	adcq	%r13, %r11
	adcq	%r15, %r12
	adcq	-128(%rsp), %rbx        ## 8-byte Folded Reload
	movq	%rbx, -120(%rsp)        ## 8-byte Spill
	adcq	-80(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -112(%rsp)        ## 8-byte Spill
	adcq	-72(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -64(%rsp)         ## 8-byte Spill
	adcq	$0, %r14
	movq	%r14, -104(%rsp)        ## 8-byte Spill
	adcq	$0, -48(%rsp)           ## 8-byte Folded Spill
	movq	-56(%rsp), %rbp         ## 8-byte Reload
	imulq	%rdi, %rbp
	movq	%rbp, %rax
	mulq	(%rsp)                  ## 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -56(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	8(%rsp)                 ## 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -72(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	16(%rsp)                ## 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -80(%rsp)         ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-32(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -128(%rsp)        ## 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%rbp, %rax
	movq	%rbp, %r14
	mulq	-24(%rsp)               ## 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%r14, %rax
	movq	24(%rsp), %r14          ## 8-byte Reload
	mulq	%r14
	addq	%r8, %rdx
	adcq	%r13, %rbp
	adcq	-128(%rsp), %rsi        ## 8-byte Folded Reload
	adcq	-80(%rsp), %rbx         ## 8-byte Folded Reload
	adcq	-72(%rsp), %r15         ## 8-byte Folded Reload
	adcq	-56(%rsp), %r9          ## 8-byte Folded Reload
	adcq	$0, %rcx
	addq	%rdi, %rax
	adcq	%r10, %rdx
	adcq	%r11, %rbp
	adcq	%r12, %rsi
	adcq	-120(%rsp), %rbx        ## 8-byte Folded Reload
	adcq	-112(%rsp), %r15        ## 8-byte Folded Reload
	adcq	-64(%rsp), %r9          ## 8-byte Folded Reload
	adcq	-104(%rsp), %rcx        ## 8-byte Folded Reload
	movq	-48(%rsp), %rdi         ## 8-byte Reload
	adcq	$0, %rdi
	movq	%rdx, %rax
	subq	%r14, %rax
	movq	%rbp, %r13
	sbbq	-24(%rsp), %r13         ## 8-byte Folded Reload
	movq	%rsi, %r8
	sbbq	-16(%rsp), %r8          ## 8-byte Folded Reload
	movq	%rbx, %r10
	sbbq	-32(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r15, %r11
	sbbq	16(%rsp), %r11          ## 8-byte Folded Reload
	movq	%r9, %r14
	sbbq	8(%rsp), %r14           ## 8-byte Folded Reload
	movq	%rcx, %r12
	sbbq	(%rsp), %r12            ## 8-byte Folded Reload
	sbbq	$0, %rdi
	andl	$1, %edi
	cmovneq	%rcx, %r12
	testb	%dil, %dil
	cmovneq	%rdx, %rax
	movq	64(%rsp), %rcx          ## 8-byte Reload
	movq	%rax, (%rcx)
	cmovneq	%rbp, %r13
	movq	%r13, 8(%rcx)
	cmovneq	%rsi, %r8
	movq	%r8, 16(%rcx)
	cmovneq	%rbx, %r10
	movq	%r10, 24(%rcx)
	cmovneq	%r15, %r11
	movq	%r11, 32(%rcx)
	cmovneq	%r9, %r14
	movq	%r14, 40(%rcx)
	movq	%r12, 48(%rcx)
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre7L
	.p2align	4, 0x90
_mcl_fp_addPre7L:                       ## @mcl_fp_addPre7L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	48(%rdx), %r8
	movq	48(%rsi), %r14
	movq	40(%rdx), %r9
	movq	40(%rsi), %r15
	movq	32(%rdx), %r10
	movq	24(%rdx), %r11
	movq	16(%rdx), %r12
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	movq	24(%rsi), %rax
	movq	32(%rsi), %rbx
	adcq	16(%rsi), %r12
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r12, 16(%rdi)
	adcq	%r11, %rax
	movq	%rax, 24(%rdi)
	adcq	%r10, %rbx
	movq	%rbx, 32(%rdi)
	adcq	%r9, %r15
	movq	%r15, 40(%rdi)
	adcq	%r8, %r14
	movq	%r14, 48(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_subPre7L
	.p2align	4, 0x90
_mcl_fp_subPre7L:                       ## @mcl_fp_subPre7L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	48(%rdx), %r8
	movq	48(%rsi), %r10
	movq	40(%rdx), %r9
	movq	40(%rsi), %r15
	movq	24(%rdx), %r11
	movq	32(%rdx), %r14
	movq	(%rsi), %rbx
	movq	8(%rsi), %r12
	xorl	%eax, %eax
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %r12
	movq	16(%rsi), %rcx
	sbbq	16(%rdx), %rcx
	movq	32(%rsi), %rdx
	movq	24(%rsi), %rsi
	movq	%rbx, (%rdi)
	movq	%r12, 8(%rdi)
	movq	%rcx, 16(%rdi)
	sbbq	%r11, %rsi
	movq	%rsi, 24(%rdi)
	sbbq	%r14, %rdx
	movq	%rdx, 32(%rdi)
	sbbq	%r9, %r15
	movq	%r15, 40(%rdi)
	sbbq	%r8, %r10
	movq	%r10, 48(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_shr1_7L
	.p2align	4, 0x90
_mcl_fp_shr1_7L:                        ## @mcl_fp_shr1_7L
## BB#0:
	movq	48(%rsi), %r8
	movq	40(%rsi), %r9
	movq	32(%rsi), %r10
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %rdx
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rdx
	movq	%rdx, (%rdi)
	shrdq	$1, %rcx, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rax, %rcx
	movq	%rcx, 16(%rdi)
	shrdq	$1, %r10, %rax
	movq	%rax, 24(%rdi)
	shrdq	$1, %r9, %r10
	movq	%r10, 32(%rdi)
	shrdq	$1, %r8, %r9
	movq	%r9, 40(%rdi)
	shrq	%r8
	movq	%r8, 48(%rdi)
	retq

	.globl	_mcl_fp_add7L
	.p2align	4, 0x90
_mcl_fp_add7L:                          ## @mcl_fp_add7L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	48(%rdx), %r14
	movq	48(%rsi), %r8
	movq	40(%rdx), %r15
	movq	40(%rsi), %r9
	movq	32(%rdx), %r12
	movq	24(%rdx), %r13
	movq	16(%rdx), %r10
	movq	(%rdx), %r11
	movq	8(%rdx), %rdx
	addq	(%rsi), %r11
	adcq	8(%rsi), %rdx
	movq	24(%rsi), %rax
	movq	32(%rsi), %rbx
	adcq	16(%rsi), %r10
	movq	%r11, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	adcq	%r13, %rax
	movq	%rax, 24(%rdi)
	adcq	%r12, %rbx
	movq	%rbx, 32(%rdi)
	adcq	%r15, %r9
	movq	%r9, 40(%rdi)
	adcq	%r14, %r8
	movq	%r8, 48(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	subq	(%rcx), %r11
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %r10
	sbbq	24(%rcx), %rax
	sbbq	32(%rcx), %rbx
	sbbq	40(%rcx), %r9
	sbbq	48(%rcx), %r8
	sbbq	$0, %rsi
	testb	$1, %sil
	jne	LBB104_2
## BB#1:                                ## %nocarry
	movq	%r11, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%r9, 40(%rdi)
	movq	%r8, 48(%rdi)
LBB104_2:                               ## %carry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_addNF7L
	.p2align	4, 0x90
_mcl_fp_addNF7L:                        ## @mcl_fp_addNF7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	48(%rdx), %r9
	movq	40(%rdx), %rbp
	movq	32(%rdx), %r10
	movq	24(%rdx), %r11
	movq	16(%rdx), %r14
	movq	(%rdx), %r12
	movq	8(%rdx), %r15
	addq	(%rsi), %r12
	adcq	8(%rsi), %r15
	adcq	16(%rsi), %r14
	adcq	24(%rsi), %r11
	adcq	32(%rsi), %r10
	adcq	40(%rsi), %rbp
	movq	%rbp, -8(%rsp)          ## 8-byte Spill
	adcq	48(%rsi), %r9
	movq	%r12, %rsi
	subq	(%rcx), %rsi
	movq	%r15, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r14, %rax
	sbbq	16(%rcx), %rax
	movq	%r11, %rbx
	sbbq	24(%rcx), %rbx
	movq	%r10, %r13
	sbbq	32(%rcx), %r13
	sbbq	40(%rcx), %rbp
	movq	%r9, %r8
	sbbq	48(%rcx), %r8
	movq	%r8, %rcx
	sarq	$63, %rcx
	cmovsq	%r12, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r15, %rdx
	movq	%rdx, 8(%rdi)
	cmovsq	%r14, %rax
	movq	%rax, 16(%rdi)
	cmovsq	%r11, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%r10, %r13
	movq	%r13, 32(%rdi)
	cmovsq	-8(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 40(%rdi)
	cmovsq	%r9, %r8
	movq	%r8, 48(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_sub7L
	.p2align	4, 0x90
_mcl_fp_sub7L:                          ## @mcl_fp_sub7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	48(%rdx), %r14
	movq	48(%rsi), %r8
	movq	40(%rdx), %r15
	movq	40(%rsi), %r9
	movq	32(%rdx), %r12
	movq	(%rsi), %rax
	movq	8(%rsi), %r11
	xorl	%ebx, %ebx
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r11
	movq	16(%rsi), %r13
	sbbq	16(%rdx), %r13
	movq	32(%rsi), %r10
	movq	24(%rsi), %rsi
	sbbq	24(%rdx), %rsi
	movq	%rax, (%rdi)
	movq	%r11, 8(%rdi)
	movq	%r13, 16(%rdi)
	movq	%rsi, 24(%rdi)
	sbbq	%r12, %r10
	movq	%r10, 32(%rdi)
	sbbq	%r15, %r9
	movq	%r9, 40(%rdi)
	sbbq	%r14, %r8
	movq	%r8, 48(%rdi)
	sbbq	$0, %rbx
	testb	$1, %bl
	je	LBB106_2
## BB#1:                                ## %carry
	movq	48(%rcx), %r14
	movq	40(%rcx), %r15
	movq	32(%rcx), %r12
	movq	24(%rcx), %rbx
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rbp
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	adcq	%r11, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r13, %rbp
	movq	%rbp, 16(%rdi)
	adcq	%rsi, %rbx
	movq	%rbx, 24(%rdi)
	adcq	%r10, %r12
	movq	%r12, 32(%rdi)
	adcq	%r9, %r15
	movq	%r15, 40(%rdi)
	adcq	%r8, %r14
	movq	%r14, 48(%rdi)
LBB106_2:                               ## %nocarry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_subNF7L
	.p2align	4, 0x90
_mcl_fp_subNF7L:                        ## @mcl_fp_subNF7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	48(%rsi), %r11
	movdqu	(%rdx), %xmm0
	movdqu	16(%rdx), %xmm1
	movdqu	32(%rdx), %xmm2
	pshufd	$78, %xmm2, %xmm3       ## xmm3 = xmm2[2,3,0,1]
	movd	%xmm3, %r14
	movdqu	(%rsi), %xmm3
	movdqu	16(%rsi), %xmm4
	movdqu	32(%rsi), %xmm5
	pshufd	$78, %xmm5, %xmm6       ## xmm6 = xmm5[2,3,0,1]
	movd	%xmm6, %rcx
	movd	%xmm2, %r15
	movd	%xmm5, %r9
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %r12
	pshufd	$78, %xmm4, %xmm2       ## xmm2 = xmm4[2,3,0,1]
	movd	%xmm2, %r10
	movd	%xmm1, %r13
	pshufd	$78, %xmm0, %xmm1       ## xmm1 = xmm0[2,3,0,1]
	movd	%xmm1, %rax
	pshufd	$78, %xmm3, %xmm1       ## xmm1 = xmm3[2,3,0,1]
	movd	%xmm0, %rbx
	movd	%xmm3, %rsi
	subq	%rbx, %rsi
	movd	%xmm1, %rbx
	sbbq	%rax, %rbx
	movd	%xmm4, %rbp
	sbbq	%r13, %rbp
	sbbq	%r12, %r10
	sbbq	%r15, %r9
	sbbq	%r14, %rcx
	movq	%rcx, -8(%rsp)          ## 8-byte Spill
	sbbq	48(%rdx), %r11
	movq	%r11, %rax
	sarq	$63, %rax
	movq	%rax, %rdx
	shldq	$1, %r11, %rdx
	andq	(%r8), %rdx
	movq	48(%r8), %r14
	andq	%rax, %r14
	movq	40(%r8), %r15
	andq	%rax, %r15
	movq	32(%r8), %r12
	andq	%rax, %r12
	movq	24(%r8), %r13
	andq	%rax, %r13
	movq	16(%r8), %rcx
	andq	%rax, %rcx
	andq	8(%r8), %rax
	addq	%rsi, %rdx
	adcq	%rbx, %rax
	movq	%rdx, (%rdi)
	movq	%rax, 8(%rdi)
	adcq	%rbp, %rcx
	movq	%rcx, 16(%rdi)
	adcq	%r10, %r13
	movq	%r13, 24(%rdi)
	adcq	%r9, %r12
	movq	%r12, 32(%rdi)
	adcq	-8(%rsp), %r15          ## 8-byte Folded Reload
	movq	%r15, 40(%rdi)
	adcq	%r11, %r14
	movq	%r14, 48(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_add7L
	.p2align	4, 0x90
_mcl_fpDbl_add7L:                       ## @mcl_fpDbl_add7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	104(%rdx), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	96(%rdx), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	88(%rdx), %r11
	movq	80(%rdx), %r14
	movq	24(%rsi), %r15
	movq	32(%rsi), %r12
	movq	16(%rdx), %r9
	movq	(%rdx), %rax
	movq	8(%rdx), %rbx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r9
	adcq	24(%rdx), %r15
	adcq	32(%rdx), %r12
	movq	72(%rdx), %r13
	movq	64(%rdx), %rbp
	movq	%rax, (%rdi)
	movq	56(%rdx), %r10
	movq	%rbx, 8(%rdi)
	movq	48(%rdx), %rcx
	movq	40(%rdx), %rdx
	movq	%r9, 16(%rdi)
	movq	104(%rsi), %r9
	movq	%r15, 24(%rdi)
	movq	40(%rsi), %rbx
	adcq	%rdx, %rbx
	movq	96(%rsi), %r15
	movq	%r12, 32(%rdi)
	movq	48(%rsi), %rdx
	adcq	%rcx, %rdx
	movq	88(%rsi), %rax
	movq	%rbx, 40(%rdi)
	movq	56(%rsi), %rcx
	adcq	%r10, %rcx
	movq	80(%rsi), %r12
	movq	%rdx, 48(%rdi)
	movq	72(%rsi), %rdx
	movq	64(%rsi), %rsi
	adcq	%rbp, %rsi
	adcq	%r13, %rdx
	adcq	%r14, %r12
	adcq	%r11, %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	adcq	-24(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, -24(%rsp)         ## 8-byte Spill
	adcq	-8(%rsp), %r9           ## 8-byte Folded Reload
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	movq	%rcx, %rbx
	subq	(%r8), %rbx
	movq	%rsi, %r10
	sbbq	8(%r8), %r10
	movq	%rdx, %r11
	sbbq	16(%r8), %r11
	movq	%r12, %r14
	sbbq	24(%r8), %r14
	movq	-16(%rsp), %r13         ## 8-byte Reload
	sbbq	32(%r8), %r13
	sbbq	40(%r8), %r15
	movq	%r9, %rax
	sbbq	48(%r8), %rax
	sbbq	$0, %rbp
	andl	$1, %ebp
	cmovneq	%rcx, %rbx
	movq	%rbx, 56(%rdi)
	testb	%bpl, %bpl
	cmovneq	%rsi, %r10
	movq	%r10, 64(%rdi)
	cmovneq	%rdx, %r11
	movq	%r11, 72(%rdi)
	cmovneq	%r12, %r14
	movq	%r14, 80(%rdi)
	cmovneq	-16(%rsp), %r13         ## 8-byte Folded Reload
	movq	%r13, 88(%rdi)
	cmovneq	-24(%rsp), %r15         ## 8-byte Folded Reload
	movq	%r15, 96(%rdi)
	cmovneq	%r9, %rax
	movq	%rax, 104(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub7L
	.p2align	4, 0x90
_mcl_fpDbl_sub7L:                       ## @mcl_fpDbl_sub7L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	104(%rdx), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	96(%rdx), %r10
	movq	88(%rdx), %r14
	movq	16(%rsi), %rax
	movq	(%rsi), %r15
	movq	8(%rsi), %r11
	xorl	%ecx, %ecx
	subq	(%rdx), %r15
	sbbq	8(%rdx), %r11
	sbbq	16(%rdx), %rax
	movq	24(%rsi), %rbx
	sbbq	24(%rdx), %rbx
	movq	32(%rsi), %r12
	sbbq	32(%rdx), %r12
	movq	80(%rdx), %r13
	movq	72(%rdx), %rbp
	movq	%r15, (%rdi)
	movq	64(%rdx), %r9
	movq	%r11, 8(%rdi)
	movq	56(%rdx), %r15
	movq	%rax, 16(%rdi)
	movq	48(%rdx), %r11
	movq	40(%rdx), %rdx
	movq	%rbx, 24(%rdi)
	movq	40(%rsi), %rbx
	sbbq	%rdx, %rbx
	movq	104(%rsi), %rax
	movq	%r12, 32(%rdi)
	movq	48(%rsi), %r12
	sbbq	%r11, %r12
	movq	96(%rsi), %r11
	movq	%rbx, 40(%rdi)
	movq	56(%rsi), %rdx
	sbbq	%r15, %rdx
	movq	88(%rsi), %r15
	movq	%r12, 48(%rdi)
	movq	64(%rsi), %rbx
	sbbq	%r9, %rbx
	movq	80(%rsi), %r12
	movq	72(%rsi), %r9
	sbbq	%rbp, %r9
	sbbq	%r13, %r12
	sbbq	%r14, %r15
	sbbq	%r10, %r11
	sbbq	-8(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movl	$0, %ebp
	sbbq	$0, %rbp
	andl	$1, %ebp
	movq	(%r8), %r10
	cmoveq	%rcx, %r10
	testb	%bpl, %bpl
	movq	16(%r8), %rbp
	cmoveq	%rcx, %rbp
	movq	8(%r8), %rsi
	cmoveq	%rcx, %rsi
	movq	48(%r8), %r14
	cmoveq	%rcx, %r14
	movq	40(%r8), %r13
	cmoveq	%rcx, %r13
	movq	32(%r8), %rax
	cmoveq	%rcx, %rax
	cmovneq	24(%r8), %rcx
	addq	%rdx, %r10
	adcq	%rbx, %rsi
	movq	%r10, 56(%rdi)
	movq	%rsi, 64(%rdi)
	adcq	%r9, %rbp
	movq	%rbp, 72(%rdi)
	adcq	%r12, %rcx
	movq	%rcx, 80(%rdi)
	adcq	%r15, %rax
	movq	%rax, 88(%rdi)
	adcq	%r11, %r13
	movq	%r13, 96(%rdi)
	adcq	-8(%rsp), %r14          ## 8-byte Folded Reload
	movq	%r14, 104(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.p2align	4, 0x90
l_mulPv512x64:                          ## @mulPv512x64
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rcx, %rax
	mulq	(%rsi)
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movq	%rax, (%rdi)
	movq	%rcx, %rax
	mulq	56(%rsi)
	movq	%rdx, %r10
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rcx, %rax
	mulq	48(%rsi)
	movq	%rdx, %r11
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rcx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r12
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	32(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	8(%rsi)
	addq	-24(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 8(%rdi)
	adcq	%r14, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r8, %r9
	movq	%r9, 24(%rdi)
	adcq	%r13, %rbp
	movq	%rbp, 32(%rdi)
	adcq	%r15, %rbx
	movq	%rbx, 40(%rdi)
	adcq	-16(%rsp), %r12         ## 8-byte Folded Reload
	movq	%r12, 48(%rdi)
	adcq	-8(%rsp), %r11          ## 8-byte Folded Reload
	movq	%r11, 56(%rdi)
	adcq	$0, %r10
	movq	%r10, 64(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mulUnitPre8L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre8L:                   ## @mcl_fp_mulUnitPre8L
## BB#0:
	pushq	%rbx
	subq	$80, %rsp
	movq	%rdi, %rbx
	leaq	8(%rsp), %rdi
	callq	l_mulPv512x64
	movq	72(%rsp), %r8
	movq	64(%rsp), %r9
	movq	56(%rsp), %r10
	movq	48(%rsp), %r11
	movq	40(%rsp), %rdi
	movq	32(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rsi
	movq	%rdx, (%rbx)
	movq	%rsi, 8(%rbx)
	movq	%rcx, 16(%rbx)
	movq	%rax, 24(%rbx)
	movq	%rdi, 32(%rbx)
	movq	%r11, 40(%rbx)
	movq	%r10, 48(%rbx)
	movq	%r9, 56(%rbx)
	movq	%r8, 64(%rbx)
	addq	$80, %rsp
	popq	%rbx
	retq

	.globl	_mcl_fpDbl_mulPre8L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre8L:                    ## @mcl_fpDbl_mulPre8L
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$200, %rsp
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
	callq	_mcl_fpDbl_mulPre4L
	leaq	64(%r14), %rdi
	leaq	32(%rbx), %rsi
	leaq	32(%r15), %rdx
	callq	_mcl_fpDbl_mulPre4L
	movq	56(%rbx), %r10
	movq	48(%rbx), %rdx
	movq	(%rbx), %rsi
	movq	8(%rbx), %rdi
	addq	32(%rbx), %rsi
	adcq	40(%rbx), %rdi
	adcq	16(%rbx), %rdx
	adcq	24(%rbx), %r10
	pushfq
	popq	%r8
	xorl	%r9d, %r9d
	movq	56(%r15), %rcx
	movq	48(%r15), %r13
	movq	(%r15), %r12
	movq	8(%r15), %rbx
	addq	32(%r15), %r12
	adcq	40(%r15), %rbx
	adcq	16(%r15), %r13
	adcq	24(%r15), %rcx
	movl	$0, %eax
	cmovbq	%r10, %rax
	movq	%rax, -88(%rbp)         ## 8-byte Spill
	movl	$0, %eax
	cmovbq	%rdx, %rax
	movq	%rax, -80(%rbp)         ## 8-byte Spill
	movl	$0, %eax
	cmovbq	%rdi, %rax
	movq	%rax, -72(%rbp)         ## 8-byte Spill
	movl	$0, %eax
	cmovbq	%rsi, %rax
	movq	%rax, -64(%rbp)         ## 8-byte Spill
	sbbq	%r15, %r15
	movq	%rsi, -168(%rbp)
	movq	%rdi, -160(%rbp)
	movq	%rdx, -152(%rbp)
	movq	%r10, -144(%rbp)
	movq	%r12, -136(%rbp)
	movq	%rbx, -128(%rbp)
	movq	%r13, -120(%rbp)
	movq	%rcx, -112(%rbp)
	pushq	%r8
	popfq
	cmovaeq	%r9, %rcx
	movq	%rcx, -48(%rbp)         ## 8-byte Spill
	cmovaeq	%r9, %r13
	cmovaeq	%r9, %rbx
	cmovaeq	%r9, %r12
	sbbq	%rax, %rax
	movq	%rax, -56(%rbp)         ## 8-byte Spill
	leaq	-232(%rbp), %rdi
	leaq	-168(%rbp), %rsi
	leaq	-136(%rbp), %rdx
	callq	_mcl_fpDbl_mulPre4L
	addq	-64(%rbp), %r12         ## 8-byte Folded Reload
	adcq	-72(%rbp), %rbx         ## 8-byte Folded Reload
	adcq	-80(%rbp), %r13         ## 8-byte Folded Reload
	movq	-48(%rbp), %r10         ## 8-byte Reload
	adcq	-88(%rbp), %r10         ## 8-byte Folded Reload
	sbbq	%rax, %rax
	andl	$1, %eax
	movq	-56(%rbp), %rdx         ## 8-byte Reload
	andl	%edx, %r15d
	andl	$1, %r15d
	addq	-200(%rbp), %r12
	adcq	-192(%rbp), %rbx
	adcq	-184(%rbp), %r13
	adcq	-176(%rbp), %r10
	adcq	%rax, %r15
	movq	-208(%rbp), %rax
	movq	-216(%rbp), %rcx
	movq	-232(%rbp), %rsi
	movq	-224(%rbp), %rdx
	subq	(%r14), %rsi
	sbbq	8(%r14), %rdx
	sbbq	16(%r14), %rcx
	sbbq	24(%r14), %rax
	movq	32(%r14), %rdi
	movq	%rdi, -80(%rbp)         ## 8-byte Spill
	movq	40(%r14), %r8
	movq	%r8, -88(%rbp)          ## 8-byte Spill
	sbbq	%rdi, %r12
	sbbq	%r8, %rbx
	movq	48(%r14), %rdi
	movq	%rdi, -72(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %r13
	movq	56(%r14), %rdi
	movq	%rdi, -64(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %r10
	sbbq	$0, %r15
	movq	64(%r14), %r11
	subq	%r11, %rsi
	movq	72(%r14), %rdi
	movq	%rdi, -56(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %rdx
	movq	80(%r14), %rdi
	movq	%rdi, -48(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %rcx
	movq	88(%r14), %rdi
	movq	%rdi, -104(%rbp)        ## 8-byte Spill
	sbbq	%rdi, %rax
	movq	96(%r14), %rdi
	movq	%rdi, -96(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %r12
	movq	104(%r14), %rdi
	sbbq	%rdi, %rbx
	movq	112(%r14), %r8
	sbbq	%r8, %r13
	movq	120(%r14), %r9
	sbbq	%r9, %r10
	sbbq	$0, %r15
	addq	-80(%rbp), %rsi         ## 8-byte Folded Reload
	adcq	-88(%rbp), %rdx         ## 8-byte Folded Reload
	movq	%rsi, 32(%r14)
	adcq	-72(%rbp), %rcx         ## 8-byte Folded Reload
	movq	%rdx, 40(%r14)
	adcq	-64(%rbp), %rax         ## 8-byte Folded Reload
	movq	%rcx, 48(%r14)
	adcq	%r11, %r12
	movq	%rax, 56(%r14)
	movq	%r12, 64(%r14)
	adcq	-56(%rbp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, 72(%r14)
	adcq	-48(%rbp), %r13         ## 8-byte Folded Reload
	movq	%r13, 80(%r14)
	adcq	-104(%rbp), %r10        ## 8-byte Folded Reload
	movq	%r10, 88(%r14)
	adcq	-96(%rbp), %r15         ## 8-byte Folded Reload
	movq	%r15, 96(%r14)
	adcq	$0, %rdi
	movq	%rdi, 104(%r14)
	adcq	$0, %r8
	movq	%r8, 112(%r14)
	adcq	$0, %r9
	movq	%r9, 120(%r14)
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre8L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre8L:                    ## @mcl_fpDbl_sqrPre8L
## BB#0:
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$200, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rbx, %rdx
	callq	_mcl_fpDbl_mulPre4L
	leaq	64(%r14), %rdi
	leaq	32(%rbx), %rsi
	movq	%rsi, %rdx
	callq	_mcl_fpDbl_mulPre4L
	movq	56(%rbx), %r15
	movq	48(%rbx), %rax
	movq	(%rbx), %rcx
	movq	8(%rbx), %rdx
	addq	32(%rbx), %rcx
	adcq	40(%rbx), %rdx
	adcq	16(%rbx), %rax
	adcq	24(%rbx), %r15
	pushfq
	popq	%r8
	pushfq
	popq	%r9
	pushfq
	popq	%r10
	pushfq
	popq	%rdi
	pushfq
	popq	%rbx
	sbbq	%rsi, %rsi
	movq	%rsi, -56(%rbp)         ## 8-byte Spill
	leaq	(%rcx,%rcx), %rsi
	xorl	%r11d, %r11d
	pushq	%rbx
	popfq
	cmovaeq	%r11, %rsi
	movq	%rsi, -48(%rbp)         ## 8-byte Spill
	movq	%rdx, %r13
	shldq	$1, %rcx, %r13
	pushq	%rdi
	popfq
	cmovaeq	%r11, %r13
	movq	%rax, %r12
	shldq	$1, %rdx, %r12
	pushq	%r10
	popfq
	cmovaeq	%r11, %r12
	movq	%r15, %rbx
	movq	%rcx, -168(%rbp)
	movq	%rdx, -160(%rbp)
	movq	%rax, -152(%rbp)
	movq	%r15, -144(%rbp)
	movq	%rcx, -136(%rbp)
	movq	%rdx, -128(%rbp)
	movq	%rax, -120(%rbp)
	movq	%r15, -112(%rbp)
	shldq	$1, %rax, %r15
	pushq	%r9
	popfq
	cmovaeq	%r11, %r15
	shrq	$63, %rbx
	pushq	%r8
	popfq
	cmovaeq	%r11, %rbx
	leaq	-232(%rbp), %rdi
	leaq	-168(%rbp), %rsi
	leaq	-136(%rbp), %rdx
	callq	_mcl_fpDbl_mulPre4L
	movq	-56(%rbp), %rax         ## 8-byte Reload
	andl	$1, %eax
	movq	-48(%rbp), %r10         ## 8-byte Reload
	addq	-200(%rbp), %r10
	adcq	-192(%rbp), %r13
	adcq	-184(%rbp), %r12
	adcq	-176(%rbp), %r15
	adcq	%rbx, %rax
	movq	%rax, %rbx
	movq	-208(%rbp), %rax
	movq	-216(%rbp), %rcx
	movq	-232(%rbp), %rsi
	movq	-224(%rbp), %rdx
	subq	(%r14), %rsi
	sbbq	8(%r14), %rdx
	sbbq	16(%r14), %rcx
	sbbq	24(%r14), %rax
	movq	32(%r14), %r9
	movq	%r9, -56(%rbp)          ## 8-byte Spill
	movq	40(%r14), %r8
	movq	%r8, -48(%rbp)          ## 8-byte Spill
	sbbq	%r9, %r10
	sbbq	%r8, %r13
	movq	48(%r14), %rdi
	movq	%rdi, -104(%rbp)        ## 8-byte Spill
	sbbq	%rdi, %r12
	movq	56(%r14), %rdi
	movq	%rdi, -96(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %r15
	sbbq	$0, %rbx
	movq	64(%r14), %r11
	subq	%r11, %rsi
	movq	72(%r14), %rdi
	movq	%rdi, -88(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %rdx
	movq	80(%r14), %rdi
	movq	%rdi, -80(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %rcx
	movq	88(%r14), %rdi
	movq	%rdi, -72(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %rax
	movq	96(%r14), %rdi
	movq	%rdi, -64(%rbp)         ## 8-byte Spill
	sbbq	%rdi, %r10
	movq	104(%r14), %rdi
	sbbq	%rdi, %r13
	movq	112(%r14), %r8
	sbbq	%r8, %r12
	movq	120(%r14), %r9
	sbbq	%r9, %r15
	sbbq	$0, %rbx
	addq	-56(%rbp), %rsi         ## 8-byte Folded Reload
	adcq	-48(%rbp), %rdx         ## 8-byte Folded Reload
	movq	%rsi, 32(%r14)
	adcq	-104(%rbp), %rcx        ## 8-byte Folded Reload
	movq	%rdx, 40(%r14)
	adcq	-96(%rbp), %rax         ## 8-byte Folded Reload
	movq	%rcx, 48(%r14)
	adcq	%r11, %r10
	movq	%rax, 56(%r14)
	movq	%r10, 64(%r14)
	adcq	-88(%rbp), %r13         ## 8-byte Folded Reload
	movq	%r13, 72(%r14)
	adcq	-80(%rbp), %r12         ## 8-byte Folded Reload
	movq	%r12, 80(%r14)
	adcq	-72(%rbp), %r15         ## 8-byte Folded Reload
	movq	%r15, 88(%r14)
	movq	%rbx, %rax
	adcq	-64(%rbp), %rax         ## 8-byte Folded Reload
	movq	%rax, 96(%r14)
	adcq	$0, %rdi
	movq	%rdi, 104(%r14)
	adcq	$0, %r8
	movq	%r8, 112(%r14)
	adcq	$0, %r9
	movq	%r9, 120(%r14)
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont8L
	.p2align	4, 0x90
_mcl_fp_mont8L:                         ## @mcl_fp_mont8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1256, %rsp             ## imm = 0x4E8
	movq	%rcx, %r13
	movq	%rdx, 64(%rsp)          ## 8-byte Spill
	movq	%rsi, 72(%rsp)          ## 8-byte Spill
	movq	%rdi, 96(%rsp)          ## 8-byte Spill
	movq	-8(%r13), %rbx
	movq	%rbx, 80(%rsp)          ## 8-byte Spill
	movq	%r13, 56(%rsp)          ## 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1184(%rsp), %rdi
	callq	l_mulPv512x64
	movq	1184(%rsp), %r15
	movq	1192(%rsp), %r14
	movq	%r15, %rdx
	imulq	%rbx, %rdx
	movq	1248(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	1240(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	1232(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	1224(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	1216(%rsp), %r12
	movq	1208(%rsp), %rbx
	movq	1200(%rsp), %rbp
	leaq	1112(%rsp), %rdi
	movq	%r13, %rsi
	callq	l_mulPv512x64
	addq	1112(%rsp), %r15
	adcq	1120(%rsp), %r14
	adcq	1128(%rsp), %rbp
	movq	%rbp, 88(%rsp)          ## 8-byte Spill
	adcq	1136(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	adcq	1144(%rsp), %r12
	movq	%r12, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	1152(%rsp), %r13
	movq	(%rsp), %rbx            ## 8-byte Reload
	adcq	1160(%rsp), %rbx
	movq	40(%rsp), %rbp          ## 8-byte Reload
	adcq	1168(%rsp), %rbp
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	1176(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	sbbq	%r15, %r15
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1040(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %r15d
	addq	1040(%rsp), %r14
	movq	88(%rsp), %rax          ## 8-byte Reload
	adcq	1048(%rsp), %rax
	movq	%rax, 88(%rsp)          ## 8-byte Spill
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	1056(%rsp), %rax
	movq	%rax, %r12
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	1064(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	adcq	1072(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	adcq	1080(%rsp), %rbx
	movq	%rbx, (%rsp)            ## 8-byte Spill
	adcq	1088(%rsp), %rbp
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	1096(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	1104(%rsp), %r15
	movq	%r15, 48(%rsp)          ## 8-byte Spill
	sbbq	%r15, %r15
	movq	%r14, %rdx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	968(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %r15d
	addq	968(%rsp), %r14
	movq	88(%rsp), %r13          ## 8-byte Reload
	adcq	976(%rsp), %r13
	adcq	984(%rsp), %r12
	movq	%r12, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	992(%rsp), %r14
	movq	16(%rsp), %rbx          ## 8-byte Reload
	adcq	1000(%rsp), %rbx
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	1008(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	adcq	1016(%rsp), %rbp
	movq	%rbp, %r12
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	1024(%rsp), %rbp
	movq	48(%rsp), %rax          ## 8-byte Reload
	adcq	1032(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	adcq	$0, %r15
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	16(%rax), %rdx
	leaq	896(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	%r13, %rcx
	addq	896(%rsp), %rcx
	movq	32(%rsp), %r13          ## 8-byte Reload
	adcq	904(%rsp), %r13
	adcq	912(%rsp), %r14
	adcq	920(%rsp), %rbx
	movq	%rbx, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	928(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	adcq	936(%rsp), %r12
	movq	%r12, 40(%rsp)          ## 8-byte Spill
	adcq	944(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	952(%rsp), %r12
	adcq	960(%rsp), %r15
	sbbq	%rbx, %rbx
	movq	%rcx, %rdx
	movq	%rcx, %rbp
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	824(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %ebx
	addq	824(%rsp), %rbp
	adcq	832(%rsp), %r13
	movq	%r13, 32(%rsp)          ## 8-byte Spill
	adcq	840(%rsp), %r14
	movq	%r14, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	848(%rsp), %r13
	movq	(%rsp), %rbp            ## 8-byte Reload
	adcq	856(%rsp), %rbp
	movq	40(%rsp), %r14          ## 8-byte Reload
	adcq	864(%rsp), %r14
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	872(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	880(%rsp), %r12
	adcq	888(%rsp), %r15
	adcq	$0, %rbx
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	24(%rax), %rdx
	leaq	752(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	32(%rsp), %rax          ## 8-byte Reload
	addq	752(%rsp), %rax
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	760(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	adcq	768(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	adcq	776(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	adcq	784(%rsp), %r14
	movq	%r14, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	792(%rsp), %rbp
	adcq	800(%rsp), %r12
	adcq	808(%rsp), %r15
	adcq	816(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	sbbq	%r13, %r13
	movq	%rax, %rdx
	movq	%rax, %rbx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	680(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	%r13, %rax
	andl	$1, %eax
	addq	680(%rsp), %rbx
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	688(%rsp), %r14
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	696(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	704(%rsp), %r13
	movq	40(%rsp), %rbx          ## 8-byte Reload
	adcq	712(%rsp), %rbx
	adcq	720(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	%r12, %rbp
	adcq	728(%rsp), %rbp
	adcq	736(%rsp), %r15
	movq	32(%rsp), %r12          ## 8-byte Reload
	adcq	744(%rsp), %r12
	adcq	$0, %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	32(%rax), %rdx
	leaq	608(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	%r14, %rax
	addq	608(%rsp), %rax
	movq	16(%rsp), %r14          ## 8-byte Reload
	adcq	616(%rsp), %r14
	adcq	624(%rsp), %r13
	movq	%r13, (%rsp)            ## 8-byte Spill
	adcq	632(%rsp), %rbx
	movq	%rbx, %r13
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	640(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	648(%rsp), %rbp
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	656(%rsp), %r15
	adcq	664(%rsp), %r12
	movq	%r12, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	672(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	sbbq	%rbp, %rbp
	movq	%rax, %rdx
	movq	%rax, %rbx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	536(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	%rbp, %rax
	andl	$1, %eax
	addq	536(%rsp), %rbx
	adcq	544(%rsp), %r14
	movq	%r14, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rbx            ## 8-byte Reload
	adcq	552(%rsp), %rbx
	adcq	560(%rsp), %r13
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	568(%rsp), %rbp
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	576(%rsp), %r12
	adcq	584(%rsp), %r15
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	592(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	600(%rsp), %r14
	adcq	$0, %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	40(%rax), %rdx
	leaq	464(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	16(%rsp), %rax          ## 8-byte Reload
	addq	464(%rsp), %rax
	adcq	472(%rsp), %rbx
	adcq	480(%rsp), %r13
	movq	%r13, 40(%rsp)          ## 8-byte Spill
	adcq	488(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	adcq	496(%rsp), %r12
	adcq	504(%rsp), %r15
	movq	%r15, 16(%rsp)          ## 8-byte Spill
	movq	32(%rsp), %r15          ## 8-byte Reload
	adcq	512(%rsp), %r15
	adcq	520(%rsp), %r14
	movq	%r14, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	528(%rsp), %r14
	sbbq	%r13, %r13
	movq	%rax, %rdx
	movq	%rax, %rbp
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	392(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	%r13, %rax
	andl	$1, %eax
	addq	392(%rsp), %rbp
	adcq	400(%rsp), %rbx
	movq	%rbx, (%rsp)            ## 8-byte Spill
	movq	40(%rsp), %rbp          ## 8-byte Reload
	adcq	408(%rsp), %rbp
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	416(%rsp), %rbx
	adcq	424(%rsp), %r12
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	432(%rsp), %r13
	adcq	440(%rsp), %r15
	movq	%r15, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r15           ## 8-byte Reload
	adcq	448(%rsp), %r15
	adcq	456(%rsp), %r14
	adcq	$0, %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	48(%rax), %rdx
	leaq	320(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	(%rsp), %rax            ## 8-byte Reload
	addq	320(%rsp), %rax
	adcq	328(%rsp), %rbp
	movq	%rbp, 40(%rsp)          ## 8-byte Spill
	adcq	336(%rsp), %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	movq	%r12, %rbp
	adcq	344(%rsp), %rbp
	adcq	352(%rsp), %r13
	movq	32(%rsp), %r12          ## 8-byte Reload
	adcq	360(%rsp), %r12
	adcq	368(%rsp), %r15
	movq	%r15, 8(%rsp)           ## 8-byte Spill
	adcq	376(%rsp), %r14
	movq	%r14, (%rsp)            ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	384(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	sbbq	%r15, %r15
	movq	%rax, %rdx
	movq	%rax, %rbx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	248(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %r15d
	addq	248(%rsp), %rbx
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	256(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %r14          ## 8-byte Reload
	adcq	264(%rsp), %r14
	adcq	272(%rsp), %rbp
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	movq	%r13, %rbx
	adcq	280(%rsp), %rbx
	movq	%r12, %rbp
	adcq	288(%rsp), %rbp
	movq	8(%rsp), %r13           ## 8-byte Reload
	adcq	296(%rsp), %r13
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	304(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	312(%rsp), %r12
	adcq	$0, %r15
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	56(%rax), %rdx
	leaq	176(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	40(%rsp), %rax          ## 8-byte Reload
	addq	176(%rsp), %rax
	adcq	184(%rsp), %r14
	movq	%r14, 24(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rcx          ## 8-byte Reload
	adcq	192(%rsp), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	adcq	200(%rsp), %rbx
	movq	%rbx, 16(%rsp)          ## 8-byte Spill
	adcq	208(%rsp), %rbp
	adcq	216(%rsp), %r13
	movq	%r13, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	224(%rsp), %r14
	adcq	232(%rsp), %r12
	adcq	240(%rsp), %r15
	sbbq	%rbx, %rbx
	movq	80(%rsp), %rdx          ## 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r13
	leaq	104(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %ebx
	addq	104(%rsp), %r13
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	112(%rsp), %rcx
	movq	48(%rsp), %rdx          ## 8-byte Reload
	adcq	120(%rsp), %rdx
	movq	16(%rsp), %rsi          ## 8-byte Reload
	adcq	128(%rsp), %rsi
	movq	%rbp, %rdi
	adcq	136(%rsp), %rdi
	movq	%rdi, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r8            ## 8-byte Reload
	adcq	144(%rsp), %r8
	movq	%r8, 8(%rsp)            ## 8-byte Spill
	movq	%r14, %r9
	adcq	152(%rsp), %r9
	movq	%r9, (%rsp)             ## 8-byte Spill
	adcq	160(%rsp), %r12
	adcq	168(%rsp), %r15
	adcq	$0, %rbx
	movq	%rcx, %rax
	movq	%rcx, %r11
	movq	56(%rsp), %rbp          ## 8-byte Reload
	subq	(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rdx, %r14
	sbbq	8(%rbp), %rcx
	movq	%rsi, %rdx
	movq	%rsi, %r13
	sbbq	16(%rbp), %rdx
	movq	%rdi, %rsi
	sbbq	24(%rbp), %rsi
	movq	%r8, %rdi
	sbbq	32(%rbp), %rdi
	movq	%r9, %r10
	sbbq	40(%rbp), %r10
	movq	%r12, %r8
	sbbq	48(%rbp), %r8
	movq	%r15, %r9
	sbbq	56(%rbp), %r9
	sbbq	$0, %rbx
	andl	$1, %ebx
	cmovneq	%r15, %r9
	testb	%bl, %bl
	cmovneq	%r11, %rax
	movq	96(%rsp), %rbx          ## 8-byte Reload
	movq	%rax, (%rbx)
	cmovneq	%r14, %rcx
	movq	%rcx, 8(%rbx)
	cmovneq	%r13, %rdx
	movq	%rdx, 16(%rbx)
	cmovneq	32(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 24(%rbx)
	cmovneq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 32(%rbx)
	cmovneq	(%rsp), %r10            ## 8-byte Folded Reload
	movq	%r10, 40(%rbx)
	cmovneq	%r12, %r8
	movq	%r8, 48(%rbx)
	movq	%r9, 56(%rbx)
	addq	$1256, %rsp             ## imm = 0x4E8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF8L
	.p2align	4, 0x90
_mcl_fp_montNF8L:                       ## @mcl_fp_montNF8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1240, %rsp             ## imm = 0x4D8
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	%rdx, 48(%rsp)          ## 8-byte Spill
	movq	%rsi, 56(%rsp)          ## 8-byte Spill
	movq	%rdi, 80(%rsp)          ## 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 64(%rsp)          ## 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1168(%rsp), %rdi
	callq	l_mulPv512x64
	movq	1168(%rsp), %r15
	movq	1176(%rsp), %r12
	movq	%r15, %rdx
	imulq	%rbx, %rdx
	movq	1232(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	1224(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	1216(%rsp), %r13
	movq	1208(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	1200(%rsp), %r14
	movq	1192(%rsp), %rbp
	movq	1184(%rsp), %rbx
	leaq	1096(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	1096(%rsp), %r15
	adcq	1104(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	adcq	1112(%rsp), %rbx
	adcq	1120(%rsp), %rbp
	adcq	1128(%rsp), %r14
	movq	%r14, %r12
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	1136(%rsp), %r14
	adcq	1144(%rsp), %r13
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	1152(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	1160(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1024(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	1088(%rsp), %r15
	movq	16(%rsp), %rax          ## 8-byte Reload
	addq	1024(%rsp), %rax
	adcq	1032(%rsp), %rbx
	movq	%rbx, 72(%rsp)          ## 8-byte Spill
	movq	%rbp, %rbx
	adcq	1040(%rsp), %rbx
	adcq	1048(%rsp), %r12
	adcq	1056(%rsp), %r14
	movq	%r14, 8(%rsp)           ## 8-byte Spill
	movq	%r13, %rbp
	adcq	1064(%rsp), %rbp
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	1072(%rsp), %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %r14          ## 8-byte Reload
	adcq	1080(%rsp), %r14
	adcq	$0, %r15
	movq	%rax, %rdx
	movq	%rax, %r13
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	952(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	952(%rsp), %r13
	movq	72(%rsp), %rax          ## 8-byte Reload
	adcq	960(%rsp), %rax
	movq	%rax, 72(%rsp)          ## 8-byte Spill
	adcq	968(%rsp), %rbx
	movq	%rbx, 16(%rsp)          ## 8-byte Spill
	movq	%r12, %rbx
	adcq	976(%rsp), %rbx
	movq	8(%rsp), %r12           ## 8-byte Reload
	adcq	984(%rsp), %r12
	adcq	992(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	1000(%rsp), %r13
	movq	%r14, %rbp
	adcq	1008(%rsp), %rbp
	adcq	1016(%rsp), %r15
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	16(%rax), %rdx
	leaq	880(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	944(%rsp), %r14
	movq	72(%rsp), %rax          ## 8-byte Reload
	addq	880(%rsp), %rax
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	888(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	896(%rsp), %rbx
	adcq	904(%rsp), %r12
	movq	%r12, 8(%rsp)           ## 8-byte Spill
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	912(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	920(%rsp), %r13
	movq	%r13, (%rsp)            ## 8-byte Spill
	adcq	928(%rsp), %rbp
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	936(%rsp), %r15
	adcq	$0, %r14
	movq	%rax, %rdx
	movq	%rax, %rbp
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	808(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	808(%rsp), %rbp
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	816(%rsp), %r13
	movq	%rbx, %r12
	adcq	824(%rsp), %r12
	movq	8(%rsp), %rbx           ## 8-byte Reload
	adcq	832(%rsp), %rbx
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	840(%rsp), %rbp
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	848(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	856(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	adcq	864(%rsp), %r15
	adcq	872(%rsp), %r14
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	24(%rax), %rdx
	leaq	736(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	800(%rsp), %rax
	movq	%r13, %rcx
	addq	736(%rsp), %rcx
	adcq	744(%rsp), %r12
	movq	%r12, 24(%rsp)          ## 8-byte Spill
	adcq	752(%rsp), %rbx
	movq	%rbx, 8(%rsp)           ## 8-byte Spill
	adcq	760(%rsp), %rbp
	movq	%rbp, %r13
	movq	(%rsp), %rbp            ## 8-byte Reload
	adcq	768(%rsp), %rbp
	movq	32(%rsp), %rbx          ## 8-byte Reload
	adcq	776(%rsp), %rbx
	adcq	784(%rsp), %r15
	adcq	792(%rsp), %r14
	adcq	$0, %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	%rcx, %rdx
	movq	%rcx, %r12
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	664(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	664(%rsp), %r12
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	672(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	680(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	adcq	688(%rsp), %r13
	adcq	696(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	adcq	704(%rsp), %rbx
	adcq	712(%rsp), %r15
	adcq	720(%rsp), %r14
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	728(%rsp), %r12
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	32(%rax), %rdx
	leaq	592(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	656(%rsp), %rcx
	movq	24(%rsp), %rax          ## 8-byte Reload
	addq	592(%rsp), %rax
	movq	8(%rsp), %rbp           ## 8-byte Reload
	adcq	600(%rsp), %rbp
	adcq	608(%rsp), %r13
	movq	%r13, 24(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	616(%rsp), %r13
	adcq	624(%rsp), %rbx
	adcq	632(%rsp), %r15
	adcq	640(%rsp), %r14
	adcq	648(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, %r12
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	520(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	520(%rsp), %r12
	adcq	528(%rsp), %rbp
	movq	%rbp, 8(%rsp)           ## 8-byte Spill
	movq	24(%rsp), %r12          ## 8-byte Reload
	adcq	536(%rsp), %r12
	movq	%r13, %rbp
	adcq	544(%rsp), %rbp
	adcq	552(%rsp), %rbx
	adcq	560(%rsp), %r15
	adcq	568(%rsp), %r14
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	576(%rsp), %r13
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	584(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	40(%rax), %rdx
	leaq	448(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	512(%rsp), %rcx
	movq	8(%rsp), %rax           ## 8-byte Reload
	addq	448(%rsp), %rax
	adcq	456(%rsp), %r12
	movq	%r12, 24(%rsp)          ## 8-byte Spill
	adcq	464(%rsp), %rbp
	adcq	472(%rsp), %rbx
	adcq	480(%rsp), %r15
	adcq	488(%rsp), %r14
	adcq	496(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	504(%rsp), %r13
	adcq	$0, %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, %r12
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	376(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	376(%rsp), %r12
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	384(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	392(%rsp), %rbp
	adcq	400(%rsp), %rbx
	adcq	408(%rsp), %r15
	adcq	416(%rsp), %r14
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	424(%rsp), %r12
	adcq	432(%rsp), %r13
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	440(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	48(%rax), %rdx
	leaq	304(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	368(%rsp), %rcx
	movq	24(%rsp), %rax          ## 8-byte Reload
	addq	304(%rsp), %rax
	adcq	312(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	adcq	320(%rsp), %rbx
	adcq	328(%rsp), %r15
	adcq	336(%rsp), %r14
	adcq	344(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	adcq	352(%rsp), %r13
	movq	8(%rsp), %rbp           ## 8-byte Reload
	adcq	360(%rsp), %rbp
	adcq	$0, %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, %r12
	imulq	64(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	232(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	232(%rsp), %r12
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	240(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	adcq	248(%rsp), %rbx
	adcq	256(%rsp), %r15
	adcq	264(%rsp), %r14
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	272(%rsp), %r12
	adcq	280(%rsp), %r13
	adcq	288(%rsp), %rbp
	movq	%rbp, 8(%rsp)           ## 8-byte Spill
	movq	32(%rsp), %rbp          ## 8-byte Reload
	adcq	296(%rsp), %rbp
	movq	48(%rsp), %rax          ## 8-byte Reload
	movq	56(%rax), %rdx
	leaq	160(%rsp), %rdi
	movq	56(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	movq	224(%rsp), %rcx
	movq	(%rsp), %rax            ## 8-byte Reload
	addq	160(%rsp), %rax
	adcq	168(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	adcq	176(%rsp), %r15
	adcq	184(%rsp), %r14
	adcq	192(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	adcq	200(%rsp), %r13
	movq	8(%rsp), %rbx           ## 8-byte Reload
	adcq	208(%rsp), %rbx
	adcq	216(%rsp), %rbp
	movq	%rbp, %r12
	adcq	$0, %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	64(%rsp), %rdx          ## 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbp
	leaq	88(%rsp), %rdi
	movq	40(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	88(%rsp), %rbp
	movq	32(%rsp), %r11          ## 8-byte Reload
	adcq	96(%rsp), %r11
	adcq	104(%rsp), %r15
	adcq	112(%rsp), %r14
	movq	16(%rsp), %rsi          ## 8-byte Reload
	adcq	120(%rsp), %rsi
	movq	%rsi, 16(%rsp)          ## 8-byte Spill
	adcq	128(%rsp), %r13
	adcq	136(%rsp), %rbx
	movq	%rbx, 8(%rsp)           ## 8-byte Spill
	adcq	144(%rsp), %r12
	movq	(%rsp), %r8             ## 8-byte Reload
	adcq	152(%rsp), %r8
	movq	%r11, %rax
	movq	40(%rsp), %rbp          ## 8-byte Reload
	subq	(%rbp), %rax
	movq	%r15, %rcx
	sbbq	8(%rbp), %rcx
	movq	%r14, %rdx
	sbbq	16(%rbp), %rdx
	sbbq	24(%rbp), %rsi
	movq	%r13, %rdi
	sbbq	32(%rbp), %rdi
	movq	%rbx, %r9
	sbbq	40(%rbp), %r9
	movq	%r12, %r10
	sbbq	48(%rbp), %r10
	movq	%rbp, %rbx
	movq	%r8, %rbp
	sbbq	56(%rbx), %rbp
	testq	%rbp, %rbp
	cmovsq	%r11, %rax
	movq	80(%rsp), %rbx          ## 8-byte Reload
	movq	%rax, (%rbx)
	cmovsq	%r15, %rcx
	movq	%rcx, 8(%rbx)
	cmovsq	%r14, %rdx
	movq	%rdx, 16(%rbx)
	cmovsq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 24(%rbx)
	cmovsq	%r13, %rdi
	movq	%rdi, 32(%rbx)
	cmovsq	8(%rsp), %r9            ## 8-byte Folded Reload
	movq	%r9, 40(%rbx)
	cmovsq	%r12, %r10
	movq	%r10, 48(%rbx)
	cmovsq	%r8, %rbp
	movq	%rbp, 56(%rbx)
	addq	$1240, %rsp             ## imm = 0x4D8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed8L
	.p2align	4, 0x90
_mcl_fp_montRed8L:                      ## @mcl_fp_montRed8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$776, %rsp              ## imm = 0x308
	movq	%rdx, %rax
	movq	%rdi, 192(%rsp)         ## 8-byte Spill
	movq	-8(%rax), %rcx
	movq	%rcx, 104(%rsp)         ## 8-byte Spill
	movq	(%rsi), %r15
	movq	8(%rsi), %rdx
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	%r15, %rdx
	imulq	%rcx, %rdx
	movq	120(%rsi), %rcx
	movq	%rcx, 112(%rsp)         ## 8-byte Spill
	movq	112(%rsi), %rcx
	movq	%rcx, 56(%rsp)          ## 8-byte Spill
	movq	104(%rsi), %rcx
	movq	%rcx, 96(%rsp)          ## 8-byte Spill
	movq	96(%rsi), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	88(%rsi), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	movq	80(%rsi), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	72(%rsi), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	64(%rsi), %r13
	movq	56(%rsi), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	movq	48(%rsi), %r14
	movq	40(%rsi), %rcx
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	movq	32(%rsi), %r12
	movq	24(%rsi), %rbx
	movq	16(%rsi), %rbp
	movq	%rax, %rcx
	movq	(%rcx), %rax
	movq	%rax, 136(%rsp)         ## 8-byte Spill
	movq	56(%rcx), %rax
	movq	%rax, 184(%rsp)         ## 8-byte Spill
	movq	48(%rcx), %rax
	movq	%rax, 176(%rsp)         ## 8-byte Spill
	movq	40(%rcx), %rax
	movq	%rax, 168(%rsp)         ## 8-byte Spill
	movq	32(%rcx), %rax
	movq	%rax, 160(%rsp)         ## 8-byte Spill
	movq	24(%rcx), %rax
	movq	%rax, 152(%rsp)         ## 8-byte Spill
	movq	16(%rcx), %rax
	movq	%rax, 144(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rax
	movq	%rax, 128(%rsp)         ## 8-byte Spill
	movq	%rcx, %rsi
	movq	%rsi, 88(%rsp)          ## 8-byte Spill
	leaq	704(%rsp), %rdi
	callq	l_mulPv512x64
	addq	704(%rsp), %r15
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	712(%rsp), %rcx
	adcq	720(%rsp), %rbp
	movq	%rbp, 80(%rsp)          ## 8-byte Spill
	adcq	728(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	adcq	736(%rsp), %r12
	movq	%r12, 120(%rsp)         ## 8-byte Spill
	movq	72(%rsp), %rax          ## 8-byte Reload
	adcq	744(%rsp), %rax
	movq	%rax, 72(%rsp)          ## 8-byte Spill
	adcq	752(%rsp), %r14
	movq	%r14, %r12
	movq	64(%rsp), %rax          ## 8-byte Reload
	adcq	760(%rsp), %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	adcq	768(%rsp), %r13
	movq	%r13, 8(%rsp)           ## 8-byte Spill
	adcq	$0, 16(%rsp)            ## 8-byte Folded Spill
	movq	40(%rsp), %r15          ## 8-byte Reload
	adcq	$0, %r15
	adcq	$0, 24(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 48(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 96(%rsp)            ## 8-byte Folded Spill
	movq	56(%rsp), %r13          ## 8-byte Reload
	adcq	$0, %r13
	movq	112(%rsp), %r14         ## 8-byte Reload
	adcq	$0, %r14
	sbbq	%rbx, %rbx
	movq	%rcx, %rbp
	movq	%rbp, %rdx
	imulq	104(%rsp), %rdx         ## 8-byte Folded Reload
	leaq	632(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	andl	$1, %ebx
	movq	%rbx, %rax
	addq	632(%rsp), %rbp
	movq	80(%rsp), %rsi          ## 8-byte Reload
	adcq	640(%rsp), %rsi
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	648(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	120(%rsp), %rcx         ## 8-byte Reload
	adcq	656(%rsp), %rcx
	movq	%rcx, 120(%rsp)         ## 8-byte Spill
	movq	72(%rsp), %rcx          ## 8-byte Reload
	adcq	664(%rsp), %rcx
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	adcq	672(%rsp), %r12
	movq	64(%rsp), %rcx          ## 8-byte Reload
	adcq	680(%rsp), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	688(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	696(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %r15
	movq	%r15, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	$0, %rbx
	movq	48(%rsp), %r15          ## 8-byte Reload
	adcq	$0, %r15
	adcq	$0, 96(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %r13
	movq	%r13, 56(%rsp)          ## 8-byte Spill
	adcq	$0, %r14
	movq	%r14, 112(%rsp)         ## 8-byte Spill
	movq	%rax, %rbp
	adcq	$0, %rbp
	movq	%rsi, %rdx
	movq	%rsi, %r14
	imulq	104(%rsp), %rdx         ## 8-byte Folded Reload
	leaq	560(%rsp), %rdi
	movq	88(%rsp), %r13          ## 8-byte Reload
	movq	%r13, %rsi
	callq	l_mulPv512x64
	addq	560(%rsp), %r14
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	568(%rsp), %rcx
	movq	120(%rsp), %rax         ## 8-byte Reload
	adcq	576(%rsp), %rax
	movq	%rax, 120(%rsp)         ## 8-byte Spill
	movq	72(%rsp), %rax          ## 8-byte Reload
	adcq	584(%rsp), %rax
	movq	%rax, 72(%rsp)          ## 8-byte Spill
	adcq	592(%rsp), %r12
	movq	%r12, 32(%rsp)          ## 8-byte Spill
	movq	64(%rsp), %r14          ## 8-byte Reload
	adcq	600(%rsp), %r14
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	608(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rax          ## 8-byte Reload
	adcq	616(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	624(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	$0, %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r15
	movq	%r15, 48(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rbx          ## 8-byte Reload
	adcq	$0, %rbx
	movq	56(%rsp), %r15          ## 8-byte Reload
	adcq	$0, %r15
	adcq	$0, 112(%rsp)           ## 8-byte Folded Spill
	adcq	$0, %rbp
	movq	%rbp, 80(%rsp)          ## 8-byte Spill
	movq	%rcx, %rbp
	movq	%rbp, %rdx
	movq	104(%rsp), %r12         ## 8-byte Reload
	imulq	%r12, %rdx
	leaq	488(%rsp), %rdi
	movq	%r13, %rsi
	callq	l_mulPv512x64
	addq	488(%rsp), %rbp
	movq	120(%rsp), %rax         ## 8-byte Reload
	adcq	496(%rsp), %rax
	movq	72(%rsp), %rbp          ## 8-byte Reload
	adcq	504(%rsp), %rbp
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	512(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	adcq	520(%rsp), %r14
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	528(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	536(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %r13          ## 8-byte Reload
	adcq	544(%rsp), %r13
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	552(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, 48(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %rbx
	movq	%rbx, 96(%rsp)          ## 8-byte Spill
	movq	%r15, %rbx
	adcq	$0, %rbx
	adcq	$0, 112(%rsp)           ## 8-byte Folded Spill
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	movq	%rax, %rdx
	movq	%rax, %r15
	imulq	%r12, %rdx
	leaq	416(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	416(%rsp), %r15
	adcq	424(%rsp), %rbp
	movq	%rbp, %rax
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	432(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	%r14, %r12
	adcq	440(%rsp), %r12
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	448(%rsp), %r14
	movq	16(%rsp), %rbp          ## 8-byte Reload
	adcq	456(%rsp), %rbp
	adcq	464(%rsp), %r13
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	472(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rcx          ## 8-byte Reload
	adcq	480(%rsp), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	adcq	$0, 96(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %rbx
	movq	%rbx, 56(%rsp)          ## 8-byte Spill
	movq	112(%rsp), %r15         ## 8-byte Reload
	adcq	$0, %r15
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	movq	%rax, %rbx
	movq	%rbx, %rdx
	imulq	104(%rsp), %rdx         ## 8-byte Folded Reload
	leaq	344(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	344(%rsp), %rbx
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	352(%rsp), %rax
	adcq	360(%rsp), %r12
	movq	%r12, 64(%rsp)          ## 8-byte Spill
	adcq	368(%rsp), %r14
	movq	%r14, 8(%rsp)           ## 8-byte Spill
	adcq	376(%rsp), %rbp
	movq	%rbp, 16(%rsp)          ## 8-byte Spill
	adcq	384(%rsp), %r13
	movq	%r13, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %r13          ## 8-byte Reload
	adcq	392(%rsp), %r13
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	400(%rsp), %r12
	movq	96(%rsp), %r14          ## 8-byte Reload
	adcq	408(%rsp), %r14
	movq	56(%rsp), %rbp          ## 8-byte Reload
	adcq	$0, %rbp
	movq	%r15, %rbx
	adcq	$0, %rbx
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	movq	%rax, %rdx
	movq	%rax, %r15
	imulq	104(%rsp), %rdx         ## 8-byte Folded Reload
	leaq	272(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	272(%rsp), %r15
	movq	64(%rsp), %rcx          ## 8-byte Reload
	adcq	280(%rsp), %rcx
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	288(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rax          ## 8-byte Reload
	adcq	296(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	304(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	312(%rsp), %r13
	movq	%r13, 24(%rsp)          ## 8-byte Spill
	adcq	320(%rsp), %r12
	movq	%r12, 48(%rsp)          ## 8-byte Spill
	adcq	328(%rsp), %r14
	movq	%r14, %r13
	adcq	336(%rsp), %rbp
	movq	%rbp, %r12
	adcq	$0, %rbx
	movq	%rbx, %r14
	movq	80(%rsp), %r15          ## 8-byte Reload
	adcq	$0, %r15
	movq	104(%rsp), %rdx         ## 8-byte Reload
	movq	%rcx, %rbx
	imulq	%rbx, %rdx
	leaq	200(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv512x64
	addq	200(%rsp), %rbx
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	208(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %r8           ## 8-byte Reload
	adcq	216(%rsp), %r8
	movq	%r8, 16(%rsp)           ## 8-byte Spill
	movq	40(%rsp), %rdx          ## 8-byte Reload
	adcq	224(%rsp), %rdx
	movq	24(%rsp), %rsi          ## 8-byte Reload
	adcq	232(%rsp), %rsi
	movq	48(%rsp), %rdi          ## 8-byte Reload
	adcq	240(%rsp), %rdi
	movq	%r13, %rbp
	adcq	248(%rsp), %rbp
	movq	%r12, %rbx
	adcq	256(%rsp), %rbx
	movq	%rbx, 56(%rsp)          ## 8-byte Spill
	movq	%r14, %r9
	adcq	264(%rsp), %r9
	adcq	$0, %r15
	movq	%r15, %r10
	subq	136(%rsp), %rax         ## 8-byte Folded Reload
	movq	%r8, %rcx
	sbbq	128(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rdx, %r13
	sbbq	144(%rsp), %r13         ## 8-byte Folded Reload
	movq	%rsi, %r12
	sbbq	152(%rsp), %r12         ## 8-byte Folded Reload
	movq	%rdi, %r14
	sbbq	160(%rsp), %r14         ## 8-byte Folded Reload
	movq	%rbp, %r11
	sbbq	168(%rsp), %r11         ## 8-byte Folded Reload
	movq	%rbx, %r8
	sbbq	176(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r9, %r15
	sbbq	184(%rsp), %r9          ## 8-byte Folded Reload
	sbbq	$0, %r10
	andl	$1, %r10d
	cmovneq	%r15, %r9
	testb	%r10b, %r10b
	cmovneq	8(%rsp), %rax           ## 8-byte Folded Reload
	movq	192(%rsp), %rbx         ## 8-byte Reload
	movq	%rax, (%rbx)
	cmovneq	16(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 8(%rbx)
	cmovneq	%rdx, %r13
	movq	%r13, 16(%rbx)
	cmovneq	%rsi, %r12
	movq	%r12, 24(%rbx)
	cmovneq	%rdi, %r14
	movq	%r14, 32(%rbx)
	cmovneq	%rbp, %r11
	movq	%r11, 40(%rbx)
	cmovneq	56(%rsp), %r8           ## 8-byte Folded Reload
	movq	%r8, 48(%rbx)
	movq	%r9, 56(%rbx)
	addq	$776, %rsp              ## imm = 0x308
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre8L
	.p2align	4, 0x90
_mcl_fp_addPre8L:                       ## @mcl_fp_addPre8L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	56(%rsi), %r15
	movq	48(%rdx), %r9
	movq	48(%rsi), %r12
	movq	40(%rdx), %r10
	movq	32(%rdx), %r11
	movq	24(%rdx), %r14
	movq	16(%rdx), %rbx
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	movq	40(%rsi), %r13
	movq	24(%rsi), %rax
	movq	32(%rsi), %rsi
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rbx, 16(%rdi)
	adcq	%r14, %rax
	movq	%rax, 24(%rdi)
	adcq	%r11, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r10, %r13
	movq	%r13, 40(%rdi)
	adcq	%r9, %r12
	movq	%r12, 48(%rdi)
	adcq	%r8, %r15
	movq	%r15, 56(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_subPre8L
	.p2align	4, 0x90
_mcl_fp_subPre8L:                       ## @mcl_fp_subPre8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	56(%rsi), %r15
	movq	48(%rdx), %r9
	movq	40(%rdx), %r10
	movq	24(%rdx), %r11
	movq	32(%rdx), %r14
	movq	(%rsi), %rbx
	movq	8(%rsi), %r12
	xorl	%eax, %eax
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %r12
	movq	16(%rsi), %rcx
	sbbq	16(%rdx), %rcx
	movq	48(%rsi), %r13
	movq	40(%rsi), %rdx
	movq	32(%rsi), %rbp
	movq	24(%rsi), %rsi
	movq	%rbx, (%rdi)
	movq	%r12, 8(%rdi)
	movq	%rcx, 16(%rdi)
	sbbq	%r11, %rsi
	movq	%rsi, 24(%rdi)
	sbbq	%r14, %rbp
	movq	%rbp, 32(%rdi)
	sbbq	%r10, %rdx
	movq	%rdx, 40(%rdi)
	sbbq	%r9, %r13
	movq	%r13, 48(%rdi)
	sbbq	%r8, %r15
	movq	%r15, 56(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_shr1_8L
	.p2align	4, 0x90
_mcl_fp_shr1_8L:                        ## @mcl_fp_shr1_8L
## BB#0:
	movq	56(%rsi), %r8
	movq	48(%rsi), %r9
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	(%rsi), %rax
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rax
	movq	%rax, (%rdi)
	shrdq	$1, %rdx, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rcx, %rdx
	movq	%rdx, 16(%rdi)
	shrdq	$1, %r11, %rcx
	movq	%rcx, 24(%rdi)
	shrdq	$1, %r10, %r11
	movq	%r11, 32(%rdi)
	shrdq	$1, %r9, %r10
	movq	%r10, 40(%rdi)
	shrdq	$1, %r8, %r9
	movq	%r9, 48(%rdi)
	shrq	%r8
	movq	%r8, 56(%rdi)
	retq

	.globl	_mcl_fp_add8L
	.p2align	4, 0x90
_mcl_fp_add8L:                          ## @mcl_fp_add8L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r15
	movq	56(%rsi), %r8
	movq	48(%rdx), %r12
	movq	48(%rsi), %r9
	movq	40(%rsi), %r13
	movq	24(%rsi), %r11
	movq	32(%rsi), %r10
	movq	(%rdx), %r14
	movq	8(%rdx), %rbx
	addq	(%rsi), %r14
	adcq	8(%rsi), %rbx
	movq	16(%rdx), %rax
	adcq	16(%rsi), %rax
	adcq	24(%rdx), %r11
	movq	40(%rdx), %rsi
	adcq	32(%rdx), %r10
	movq	%r14, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r11, 24(%rdi)
	movq	%r10, 32(%rdi)
	adcq	%r13, %rsi
	movq	%rsi, 40(%rdi)
	adcq	%r12, %r9
	movq	%r9, 48(%rdi)
	adcq	%r15, %r8
	movq	%r8, 56(%rdi)
	sbbq	%rdx, %rdx
	andl	$1, %edx
	subq	(%rcx), %r14
	sbbq	8(%rcx), %rbx
	sbbq	16(%rcx), %rax
	sbbq	24(%rcx), %r11
	sbbq	32(%rcx), %r10
	sbbq	40(%rcx), %rsi
	sbbq	48(%rcx), %r9
	sbbq	56(%rcx), %r8
	sbbq	$0, %rdx
	testb	$1, %dl
	jne	LBB120_2
## BB#1:                                ## %nocarry
	movq	%r14, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r11, 24(%rdi)
	movq	%r10, 32(%rdi)
	movq	%rsi, 40(%rdi)
	movq	%r9, 48(%rdi)
	movq	%r8, 56(%rdi)
LBB120_2:                               ## %carry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_addNF8L
	.p2align	4, 0x90
_mcl_fp_addNF8L:                        ## @mcl_fp_addNF8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	48(%rdx), %rbp
	movq	40(%rdx), %rbx
	movq	32(%rdx), %rax
	movq	24(%rdx), %r11
	movq	16(%rdx), %r15
	movq	(%rdx), %r13
	movq	8(%rdx), %r12
	addq	(%rsi), %r13
	adcq	8(%rsi), %r12
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %r11
	adcq	32(%rsi), %rax
	movq	%rax, %r10
	movq	%r10, -24(%rsp)         ## 8-byte Spill
	adcq	40(%rsi), %rbx
	movq	%rbx, %r9
	movq	%r9, -16(%rsp)          ## 8-byte Spill
	adcq	48(%rsi), %rbp
	movq	%rbp, %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	adcq	56(%rsi), %r8
	movq	%r13, %rsi
	subq	(%rcx), %rsi
	movq	%r12, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r15, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r11, %r14
	sbbq	24(%rcx), %r14
	movq	%r10, %rbp
	sbbq	32(%rcx), %rbp
	movq	%r9, %r10
	sbbq	40(%rcx), %r10
	movq	%rax, %r9
	sbbq	48(%rcx), %r9
	movq	%r8, %rax
	sbbq	56(%rcx), %rax
	testq	%rax, %rax
	cmovsq	%r13, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r12, %rdx
	movq	%rdx, 8(%rdi)
	cmovsq	%r15, %rbx
	movq	%rbx, 16(%rdi)
	cmovsq	%r11, %r14
	movq	%r14, 24(%rdi)
	cmovsq	-24(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, 32(%rdi)
	cmovsq	-16(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r10, 40(%rdi)
	cmovsq	-8(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 48(%rdi)
	cmovsq	%r8, %rax
	movq	%rax, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_sub8L
	.p2align	4, 0x90
_mcl_fp_sub8L:                          ## @mcl_fp_sub8L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r12
	movq	56(%rsi), %r8
	movq	48(%rdx), %r13
	movq	(%rsi), %rax
	movq	8(%rsi), %r10
	xorl	%ebx, %ebx
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r10
	movq	16(%rsi), %r11
	sbbq	16(%rdx), %r11
	movq	24(%rsi), %r15
	sbbq	24(%rdx), %r15
	movq	32(%rsi), %r14
	sbbq	32(%rdx), %r14
	movq	48(%rsi), %r9
	movq	40(%rsi), %rsi
	sbbq	40(%rdx), %rsi
	movq	%rax, (%rdi)
	movq	%r10, 8(%rdi)
	movq	%r11, 16(%rdi)
	movq	%r15, 24(%rdi)
	movq	%r14, 32(%rdi)
	movq	%rsi, 40(%rdi)
	sbbq	%r13, %r9
	movq	%r9, 48(%rdi)
	sbbq	%r12, %r8
	movq	%r8, 56(%rdi)
	sbbq	$0, %rbx
	testb	$1, %bl
	je	LBB122_2
## BB#1:                                ## %carry
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	movq	8(%rcx), %rax
	adcq	%r10, %rax
	movq	%rax, 8(%rdi)
	movq	16(%rcx), %rax
	adcq	%r11, %rax
	movq	%rax, 16(%rdi)
	movq	24(%rcx), %rax
	adcq	%r15, %rax
	movq	%rax, 24(%rdi)
	movq	32(%rcx), %rax
	adcq	%r14, %rax
	movq	%rax, 32(%rdi)
	movq	40(%rcx), %rax
	adcq	%rsi, %rax
	movq	%rax, 40(%rdi)
	movq	48(%rcx), %rax
	adcq	%r9, %rax
	movq	%rax, 48(%rdi)
	movq	56(%rcx), %rax
	adcq	%r8, %rax
	movq	%rax, 56(%rdi)
LBB122_2:                               ## %nocarry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_subNF8L
	.p2align	4, 0x90
_mcl_fp_subNF8L:                        ## @mcl_fp_subNF8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	%rdi, %r9
	movdqu	(%rdx), %xmm0
	movdqu	16(%rdx), %xmm1
	movdqu	32(%rdx), %xmm2
	movdqu	48(%rdx), %xmm3
	pshufd	$78, %xmm3, %xmm4       ## xmm4 = xmm3[2,3,0,1]
	movd	%xmm4, %r12
	movdqu	(%rsi), %xmm4
	movdqu	16(%rsi), %xmm5
	movdqu	32(%rsi), %xmm8
	movdqu	48(%rsi), %xmm7
	pshufd	$78, %xmm7, %xmm6       ## xmm6 = xmm7[2,3,0,1]
	movd	%xmm6, %rcx
	movd	%xmm3, %r13
	movd	%xmm7, %rdi
	pshufd	$78, %xmm2, %xmm3       ## xmm3 = xmm2[2,3,0,1]
	movd	%xmm3, %rbp
	pshufd	$78, %xmm8, %xmm3       ## xmm3 = xmm8[2,3,0,1]
	movd	%xmm3, %rdx
	movd	%xmm2, %rsi
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %r11
	pshufd	$78, %xmm5, %xmm2       ## xmm2 = xmm5[2,3,0,1]
	movd	%xmm1, %r15
	pshufd	$78, %xmm0, %xmm1       ## xmm1 = xmm0[2,3,0,1]
	movd	%xmm1, %rbx
	pshufd	$78, %xmm4, %xmm1       ## xmm1 = xmm4[2,3,0,1]
	movd	%xmm0, %rax
	movd	%xmm4, %r14
	subq	%rax, %r14
	movd	%xmm1, %r10
	sbbq	%rbx, %r10
	movd	%xmm5, %rbx
	sbbq	%r15, %rbx
	movd	%xmm2, %r15
	sbbq	%r11, %r15
	movd	%xmm8, %r11
	sbbq	%rsi, %r11
	sbbq	%rbp, %rdx
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	sbbq	%r13, %rdi
	movq	%rdi, -16(%rsp)         ## 8-byte Spill
	sbbq	%r12, %rcx
	movq	%rcx, -8(%rsp)          ## 8-byte Spill
	movq	%rcx, %rbp
	sarq	$63, %rbp
	movq	56(%r8), %r12
	andq	%rbp, %r12
	movq	48(%r8), %r13
	andq	%rbp, %r13
	movq	40(%r8), %rdi
	andq	%rbp, %rdi
	movq	32(%r8), %rsi
	andq	%rbp, %rsi
	movq	24(%r8), %rdx
	andq	%rbp, %rdx
	movq	16(%r8), %rcx
	andq	%rbp, %rcx
	movq	8(%r8), %rax
	andq	%rbp, %rax
	andq	(%r8), %rbp
	addq	%r14, %rbp
	adcq	%r10, %rax
	movq	%rbp, (%r9)
	adcq	%rbx, %rcx
	movq	%rax, 8(%r9)
	movq	%rcx, 16(%r9)
	adcq	%r15, %rdx
	movq	%rdx, 24(%r9)
	adcq	%r11, %rsi
	movq	%rsi, 32(%r9)
	adcq	-24(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%rdi, 40(%r9)
	adcq	-16(%rsp), %r13         ## 8-byte Folded Reload
	movq	%r13, 48(%r9)
	adcq	-8(%rsp), %r12          ## 8-byte Folded Reload
	movq	%r12, 56(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_add8L
	.p2align	4, 0x90
_mcl_fpDbl_add8L:                       ## @mcl_fpDbl_add8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	120(%rdx), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	112(%rdx), %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	104(%rdx), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	96(%rdx), %r14
	movq	24(%rsi), %r15
	movq	32(%rsi), %r11
	movq	16(%rdx), %r12
	movq	(%rdx), %rbx
	movq	8(%rdx), %rax
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r12
	adcq	24(%rdx), %r15
	adcq	32(%rdx), %r11
	movq	88(%rdx), %rbp
	movq	80(%rdx), %r13
	movq	%rbx, (%rdi)
	movq	72(%rdx), %r10
	movq	%rax, 8(%rdi)
	movq	64(%rdx), %r9
	movq	%r12, 16(%rdi)
	movq	40(%rdx), %r12
	movq	%r15, 24(%rdi)
	movq	40(%rsi), %rbx
	adcq	%r12, %rbx
	movq	56(%rdx), %r15
	movq	48(%rdx), %r12
	movq	%r11, 32(%rdi)
	movq	48(%rsi), %rdx
	adcq	%r12, %rdx
	movq	120(%rsi), %r12
	movq	%rbx, 40(%rdi)
	movq	56(%rsi), %rax
	adcq	%r15, %rax
	movq	112(%rsi), %rcx
	movq	%rdx, 48(%rdi)
	movq	64(%rsi), %rbx
	adcq	%r9, %rbx
	movq	104(%rsi), %rdx
	movq	%rax, 56(%rdi)
	movq	72(%rsi), %r9
	adcq	%r10, %r9
	movq	80(%rsi), %r11
	adcq	%r13, %r11
	movq	96(%rsi), %rax
	movq	88(%rsi), %r15
	adcq	%rbp, %r15
	adcq	%r14, %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rdx, %rax
	adcq	-24(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	adcq	-16(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -16(%rsp)         ## 8-byte Spill
	adcq	-32(%rsp), %r12         ## 8-byte Folded Reload
	movq	%r12, -32(%rsp)         ## 8-byte Spill
	sbbq	%rbp, %rbp
	andl	$1, %ebp
	movq	%rbx, %rsi
	subq	(%r8), %rsi
	movq	%r9, %rdx
	sbbq	8(%r8), %rdx
	movq	%r11, %r10
	sbbq	16(%r8), %r10
	movq	%r15, %r14
	sbbq	24(%r8), %r14
	movq	-8(%rsp), %r13          ## 8-byte Reload
	sbbq	32(%r8), %r13
	movq	%rax, %r12
	sbbq	40(%r8), %r12
	movq	%rcx, %rax
	sbbq	48(%r8), %rax
	movq	-32(%rsp), %rcx         ## 8-byte Reload
	sbbq	56(%r8), %rcx
	sbbq	$0, %rbp
	andl	$1, %ebp
	cmovneq	%rbx, %rsi
	movq	%rsi, 64(%rdi)
	testb	%bpl, %bpl
	cmovneq	%r9, %rdx
	movq	%rdx, 72(%rdi)
	cmovneq	%r11, %r10
	movq	%r10, 80(%rdi)
	cmovneq	%r15, %r14
	movq	%r14, 88(%rdi)
	cmovneq	-8(%rsp), %r13          ## 8-byte Folded Reload
	movq	%r13, 96(%rdi)
	cmovneq	-24(%rsp), %r12         ## 8-byte Folded Reload
	movq	%r12, 104(%rdi)
	cmovneq	-16(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 112(%rdi)
	cmovneq	-32(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, 120(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub8L
	.p2align	4, 0x90
_mcl_fpDbl_sub8L:                       ## @mcl_fpDbl_sub8L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r15
	movq	120(%rdx), %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	112(%rdx), %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	104(%rdx), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %r9
	movq	(%rsi), %r12
	movq	8(%rsi), %r14
	xorl	%r8d, %r8d
	subq	(%rdx), %r12
	sbbq	8(%rdx), %r14
	sbbq	16(%rdx), %r9
	movq	24(%rsi), %rbx
	sbbq	24(%rdx), %rbx
	movq	32(%rsi), %r13
	sbbq	32(%rdx), %r13
	movq	96(%rdx), %rbp
	movq	88(%rdx), %r11
	movq	%r12, (%rdi)
	movq	80(%rdx), %r12
	movq	%r14, 8(%rdi)
	movq	72(%rdx), %r10
	movq	%r9, 16(%rdi)
	movq	40(%rdx), %r9
	movq	%rbx, 24(%rdi)
	movq	40(%rsi), %rbx
	sbbq	%r9, %rbx
	movq	48(%rdx), %r9
	movq	%r13, 32(%rdi)
	movq	48(%rsi), %r14
	sbbq	%r9, %r14
	movq	64(%rdx), %r13
	movq	56(%rdx), %r9
	movq	%rbx, 40(%rdi)
	movq	56(%rsi), %rdx
	sbbq	%r9, %rdx
	movq	120(%rsi), %rcx
	movq	%r14, 48(%rdi)
	movq	64(%rsi), %rbx
	sbbq	%r13, %rbx
	movq	112(%rsi), %rax
	movq	%rdx, 56(%rdi)
	movq	72(%rsi), %r9
	sbbq	%r10, %r9
	movq	80(%rsi), %r13
	sbbq	%r12, %r13
	movq	88(%rsi), %r12
	sbbq	%r11, %r12
	movq	104(%rsi), %rdx
	movq	96(%rsi), %r14
	sbbq	%rbp, %r14
	sbbq	-24(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	sbbq	-16(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	sbbq	-8(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, -8(%rsp)          ## 8-byte Spill
	movl	$0, %ebp
	sbbq	$0, %rbp
	andl	$1, %ebp
	movq	(%r15), %r11
	cmoveq	%r8, %r11
	testb	%bpl, %bpl
	movq	16(%r15), %rbp
	cmoveq	%r8, %rbp
	movq	8(%r15), %rsi
	cmoveq	%r8, %rsi
	movq	56(%r15), %r10
	cmoveq	%r8, %r10
	movq	48(%r15), %rdx
	cmoveq	%r8, %rdx
	movq	40(%r15), %rcx
	cmoveq	%r8, %rcx
	movq	32(%r15), %rax
	cmoveq	%r8, %rax
	cmovneq	24(%r15), %r8
	addq	%rbx, %r11
	adcq	%r9, %rsi
	movq	%r11, 64(%rdi)
	adcq	%r13, %rbp
	movq	%rsi, 72(%rdi)
	movq	%rbp, 80(%rdi)
	adcq	%r12, %r8
	movq	%r8, 88(%rdi)
	adcq	%r14, %rax
	movq	%rax, 96(%rdi)
	adcq	-24(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, 104(%rdi)
	adcq	-16(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, 112(%rdi)
	adcq	-8(%rsp), %r10          ## 8-byte Folded Reload
	movq	%r10, 120(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.p2align	4, 0x90
l_mulPv576x64:                          ## @mulPv576x64
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rbx
	movq	%rbx, %rax
	mulq	(%rsi)
	movq	%rdx, -32(%rsp)         ## 8-byte Spill
	movq	%rax, (%rdi)
	movq	%rbx, %rax
	mulq	64(%rsi)
	movq	%rdx, %r10
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	%rbx, %rax
	mulq	56(%rsi)
	movq	%rdx, %r14
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	48(%rsi)
	movq	%rdx, %r12
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	40(%rsi)
	movq	%rdx, %rcx
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	%rbx, %rax
	mulq	32(%rsi)
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	8(%rsi)
	addq	-32(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 8(%rdi)
	adcq	%r13, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r11, %r15
	movq	%r15, 24(%rdi)
	adcq	%r8, %r9
	movq	%r9, 32(%rdi)
	adcq	-40(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, 40(%rdi)
	adcq	-24(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, 48(%rdi)
	adcq	-16(%rsp), %r12         ## 8-byte Folded Reload
	movq	%r12, 56(%rdi)
	adcq	-8(%rsp), %r14          ## 8-byte Folded Reload
	movq	%r14, 64(%rdi)
	adcq	$0, %r10
	movq	%r10, 72(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mulUnitPre9L
	.p2align	4, 0x90
_mcl_fp_mulUnitPre9L:                   ## @mcl_fp_mulUnitPre9L
## BB#0:
	pushq	%r14
	pushq	%rbx
	subq	$88, %rsp
	movq	%rdi, %rbx
	leaq	8(%rsp), %rdi
	callq	l_mulPv576x64
	movq	80(%rsp), %r8
	movq	72(%rsp), %r9
	movq	64(%rsp), %r10
	movq	56(%rsp), %r11
	movq	48(%rsp), %r14
	movq	40(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
	movq	%rsi, (%rbx)
	movq	%rdi, 8(%rbx)
	movq	%rdx, 16(%rbx)
	movq	%rcx, 24(%rbx)
	movq	%rax, 32(%rbx)
	movq	%r14, 40(%rbx)
	movq	%r11, 48(%rbx)
	movq	%r10, 56(%rbx)
	movq	%r9, 64(%rbx)
	movq	%r8, 72(%rbx)
	addq	$88, %rsp
	popq	%rbx
	popq	%r14
	retq

	.globl	_mcl_fpDbl_mulPre9L
	.p2align	4, 0x90
_mcl_fpDbl_mulPre9L:                    ## @mcl_fpDbl_mulPre9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$808, %rsp              ## imm = 0x328
	movq	%rdx, %rax
	movq	%rdi, %r12
	movq	(%rax), %rdx
	movq	%rax, %rbx
	movq	%rbx, 80(%rsp)          ## 8-byte Spill
	leaq	728(%rsp), %rdi
	movq	%rsi, %rbp
	movq	%rbp, 72(%rsp)          ## 8-byte Spill
	callq	l_mulPv576x64
	movq	800(%rsp), %r13
	movq	792(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	784(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	776(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	768(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	760(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	752(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	744(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	728(%rsp), %rax
	movq	736(%rsp), %r14
	movq	%rax, (%r12)
	movq	%r12, 64(%rsp)          ## 8-byte Spill
	movq	8(%rbx), %rdx
	leaq	648(%rsp), %rdi
	movq	%rbp, %rsi
	callq	l_mulPv576x64
	movq	720(%rsp), %r8
	movq	712(%rsp), %rcx
	movq	704(%rsp), %rdx
	movq	696(%rsp), %rsi
	movq	688(%rsp), %rdi
	movq	680(%rsp), %rbp
	addq	648(%rsp), %r14
	movq	672(%rsp), %rax
	movq	656(%rsp), %rbx
	movq	664(%rsp), %r15
	movq	%r14, 8(%r12)
	adcq	24(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	32(%rsp), %r15          ## 8-byte Folded Reload
	adcq	40(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, %r14
	adcq	(%rsp), %rbp            ## 8-byte Folded Reload
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 32(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 40(%rsp)          ## 8-byte Spill
	adcq	48(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, (%rsp)            ## 8-byte Spill
	adcq	%r13, %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 16(%rsp)           ## 8-byte Spill
	movq	80(%rsp), %r13          ## 8-byte Reload
	movq	16(%r13), %rdx
	leaq	568(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	640(%rsp), %r8
	movq	632(%rsp), %r9
	movq	624(%rsp), %r10
	movq	616(%rsp), %rdi
	movq	608(%rsp), %rbp
	movq	600(%rsp), %rcx
	addq	568(%rsp), %rbx
	movq	592(%rsp), %rdx
	movq	576(%rsp), %r12
	movq	584(%rsp), %rsi
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	%rbx, 16(%rax)
	adcq	%r15, %r12
	adcq	%r14, %rsi
	movq	%rsi, 48(%rsp)          ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	(%rsp), %rdi            ## 8-byte Folded Reload
	movq	%rdi, 40(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %r10           ## 8-byte Folded Reload
	movq	%r10, (%rsp)            ## 8-byte Spill
	adcq	16(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 8(%rsp)            ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 16(%rsp)           ## 8-byte Spill
	movq	24(%r13), %rdx
	leaq	488(%rsp), %rdi
	movq	72(%rsp), %r15          ## 8-byte Reload
	movq	%r15, %rsi
	callq	l_mulPv576x64
	movq	560(%rsp), %r8
	movq	552(%rsp), %rcx
	movq	544(%rsp), %rdx
	movq	536(%rsp), %rsi
	movq	528(%rsp), %rdi
	movq	520(%rsp), %rbp
	addq	488(%rsp), %r12
	movq	512(%rsp), %rax
	movq	496(%rsp), %rbx
	movq	504(%rsp), %r13
	movq	64(%rsp), %r14          ## 8-byte Reload
	movq	%r12, 24(%r14)
	adcq	48(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	56(%rsp), %r13          ## 8-byte Folded Reload
	adcq	24(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	40(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, 40(%rsp)          ## 8-byte Spill
	adcq	(%rsp), %rsi            ## 8-byte Folded Reload
	movq	%rsi, (%rsp)            ## 8-byte Spill
	adcq	8(%rsp), %rdx           ## 8-byte Folded Reload
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	adcq	16(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 48(%rsp)           ## 8-byte Spill
	movq	80(%rsp), %r12          ## 8-byte Reload
	movq	32(%r12), %rdx
	leaq	408(%rsp), %rdi
	movq	%r15, %rsi
	callq	l_mulPv576x64
	movq	480(%rsp), %r8
	movq	472(%rsp), %r9
	movq	464(%rsp), %rdx
	movq	456(%rsp), %rsi
	movq	448(%rsp), %rdi
	movq	440(%rsp), %rbp
	addq	408(%rsp), %rbx
	movq	432(%rsp), %rax
	movq	416(%rsp), %r15
	movq	424(%rsp), %rcx
	movq	%rbx, 32(%r14)
	adcq	%r13, %r15
	adcq	24(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 56(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	(%rsp), %rdi            ## 8-byte Folded Reload
	movq	%rdi, 40(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rsi           ## 8-byte Folded Reload
	movq	%rsi, (%rsp)            ## 8-byte Spill
	adcq	16(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	adcq	48(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 16(%rsp)           ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 48(%rsp)           ## 8-byte Spill
	movq	%r12, %r14
	movq	40(%r14), %rdx
	leaq	328(%rsp), %rdi
	movq	72(%rsp), %r13          ## 8-byte Reload
	movq	%r13, %rsi
	callq	l_mulPv576x64
	movq	400(%rsp), %r8
	movq	392(%rsp), %r9
	movq	384(%rsp), %rsi
	movq	376(%rsp), %rdi
	movq	368(%rsp), %rbx
	movq	360(%rsp), %rbp
	addq	328(%rsp), %r15
	movq	352(%rsp), %rcx
	movq	336(%rsp), %r12
	movq	344(%rsp), %rdx
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	%r15, 40(%rax)
	adcq	56(%rsp), %r12          ## 8-byte Folded Reload
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	(%rsp), %rbx            ## 8-byte Folded Reload
	movq	%rbx, 40(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, (%rsp)            ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	48(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 16(%rsp)           ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 48(%rsp)           ## 8-byte Spill
	movq	48(%r14), %rdx
	leaq	248(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r13, %r15
	callq	l_mulPv576x64
	movq	320(%rsp), %r8
	movq	312(%rsp), %r9
	movq	304(%rsp), %rsi
	movq	296(%rsp), %rdi
	movq	288(%rsp), %rbx
	movq	280(%rsp), %rbp
	addq	248(%rsp), %r12
	movq	272(%rsp), %rcx
	movq	256(%rsp), %r13
	movq	264(%rsp), %rdx
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	%r12, 48(%rax)
	adcq	56(%rsp), %r13          ## 8-byte Folded Reload
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	(%rsp), %rbx            ## 8-byte Folded Reload
	movq	%rbx, 40(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, (%rsp)            ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	48(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 16(%rsp)           ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 48(%rsp)           ## 8-byte Spill
	movq	56(%r14), %rdx
	leaq	168(%rsp), %rdi
	movq	%r15, %rsi
	callq	l_mulPv576x64
	movq	240(%rsp), %rcx
	movq	232(%rsp), %rdx
	movq	224(%rsp), %rsi
	movq	216(%rsp), %rdi
	movq	208(%rsp), %rbx
	addq	168(%rsp), %r13
	movq	200(%rsp), %r12
	movq	192(%rsp), %rbp
	movq	176(%rsp), %r14
	movq	184(%rsp), %r15
	movq	64(%rsp), %rax          ## 8-byte Reload
	movq	%r13, 56(%rax)
	adcq	56(%rsp), %r14          ## 8-byte Folded Reload
	adcq	24(%rsp), %r15          ## 8-byte Folded Reload
	adcq	32(%rsp), %rbp          ## 8-byte Folded Reload
	adcq	40(%rsp), %r12          ## 8-byte Folded Reload
	adcq	(%rsp), %rbx            ## 8-byte Folded Reload
	movq	%rbx, %r13
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, (%rsp)            ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	48(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	64(%rax), %rdx
	leaq	88(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	88(%rsp), %r14
	adcq	96(%rsp), %r15
	movq	160(%rsp), %r8
	adcq	104(%rsp), %rbp
	movq	152(%rsp), %r9
	movq	144(%rsp), %rdx
	movq	136(%rsp), %rsi
	movq	128(%rsp), %rdi
	movq	120(%rsp), %rbx
	movq	112(%rsp), %rax
	movq	64(%rsp), %rcx          ## 8-byte Reload
	movq	%r14, 64(%rcx)
	movq	%r15, 72(%rcx)
	adcq	%r12, %rax
	movq	%rbp, 80(%rcx)
	movq	%rax, 88(%rcx)
	adcq	%r13, %rbx
	movq	%rbx, 96(%rcx)
	adcq	(%rsp), %rdi            ## 8-byte Folded Reload
	movq	%rdi, 104(%rcx)
	adcq	8(%rsp), %rsi           ## 8-byte Folded Reload
	movq	%rsi, 112(%rcx)
	adcq	16(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 120(%rcx)
	adcq	48(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 128(%rcx)
	adcq	$0, %r8
	movq	%r8, 136(%rcx)
	addq	$808, %rsp              ## imm = 0x328
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sqrPre9L
	.p2align	4, 0x90
_mcl_fpDbl_sqrPre9L:                    ## @mcl_fpDbl_sqrPre9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$808, %rsp              ## imm = 0x328
	movq	%rsi, %r15
	movq	%rdi, %r14
	movq	(%r15), %rdx
	leaq	728(%rsp), %rdi
	callq	l_mulPv576x64
	movq	800(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	792(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	784(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	776(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	768(%rsp), %rax
	movq	%rax, 56(%rsp)          ## 8-byte Spill
	movq	760(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	752(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	744(%rsp), %rax
	movq	%rax, 80(%rsp)          ## 8-byte Spill
	movq	728(%rsp), %rax
	movq	736(%rsp), %r12
	movq	%rax, (%r14)
	movq	%r14, 72(%rsp)          ## 8-byte Spill
	movq	8(%r15), %rdx
	leaq	648(%rsp), %rdi
	movq	%r15, %rsi
	callq	l_mulPv576x64
	movq	720(%rsp), %r8
	movq	712(%rsp), %rcx
	movq	704(%rsp), %rdx
	movq	696(%rsp), %rsi
	movq	688(%rsp), %rdi
	movq	680(%rsp), %rbp
	addq	648(%rsp), %r12
	movq	672(%rsp), %rax
	movq	656(%rsp), %rbx
	movq	664(%rsp), %r13
	movq	%r12, 8(%r14)
	adcq	80(%rsp), %rbx          ## 8-byte Folded Reload
	adcq	40(%rsp), %r13          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	%r15, 64(%rsp)          ## 8-byte Spill
	movq	16(%r15), %rdx
	leaq	568(%rsp), %rdi
	movq	%r15, %rsi
	callq	l_mulPv576x64
	movq	640(%rsp), %r8
	movq	632(%rsp), %rcx
	movq	624(%rsp), %rdx
	movq	616(%rsp), %rsi
	movq	608(%rsp), %rdi
	movq	600(%rsp), %rbp
	addq	568(%rsp), %rbx
	movq	592(%rsp), %rax
	movq	576(%rsp), %r14
	movq	584(%rsp), %r12
	movq	72(%rsp), %r15          ## 8-byte Reload
	movq	%rbx, 16(%r15)
	adcq	%r13, %r14
	adcq	40(%rsp), %r12          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	24(%rsi), %rdx
	leaq	488(%rsp), %rdi
	callq	l_mulPv576x64
	movq	560(%rsp), %r8
	movq	552(%rsp), %rcx
	movq	544(%rsp), %rdx
	movq	536(%rsp), %rsi
	movq	528(%rsp), %rdi
	movq	520(%rsp), %rbp
	addq	488(%rsp), %r14
	movq	512(%rsp), %rax
	movq	496(%rsp), %rbx
	movq	504(%rsp), %r13
	movq	%r14, 24(%r15)
	adcq	%r12, %rbx
	adcq	40(%rsp), %r13          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	32(%rsi), %rdx
	leaq	408(%rsp), %rdi
	callq	l_mulPv576x64
	movq	480(%rsp), %r8
	movq	472(%rsp), %rcx
	movq	464(%rsp), %rdx
	movq	456(%rsp), %rsi
	movq	448(%rsp), %rdi
	movq	440(%rsp), %rbp
	addq	408(%rsp), %rbx
	movq	432(%rsp), %rax
	movq	416(%rsp), %r14
	movq	424(%rsp), %r12
	movq	%rbx, 32(%r15)
	adcq	%r13, %r14
	adcq	40(%rsp), %r12          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	40(%rsi), %rdx
	leaq	328(%rsp), %rdi
	callq	l_mulPv576x64
	movq	400(%rsp), %r8
	movq	392(%rsp), %rcx
	movq	384(%rsp), %rdx
	movq	376(%rsp), %rsi
	movq	368(%rsp), %rdi
	movq	360(%rsp), %rbp
	addq	328(%rsp), %r14
	movq	352(%rsp), %rax
	movq	336(%rsp), %rbx
	movq	344(%rsp), %r13
	movq	%r14, 40(%r15)
	adcq	%r12, %rbx
	adcq	40(%rsp), %r13          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	48(%rsi), %rdx
	leaq	248(%rsp), %rdi
	callq	l_mulPv576x64
	movq	320(%rsp), %r8
	movq	312(%rsp), %rcx
	movq	304(%rsp), %rdx
	movq	296(%rsp), %rsi
	movq	288(%rsp), %rdi
	movq	280(%rsp), %rbp
	addq	248(%rsp), %rbx
	movq	272(%rsp), %rax
	movq	256(%rsp), %r12
	movq	264(%rsp), %r14
	movq	%rbx, 48(%r15)
	adcq	%r13, %r12
	adcq	40(%rsp), %r14          ## 8-byte Folded Reload
	adcq	48(%rsp), %rax          ## 8-byte Folded Reload
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	56(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 56(%rsp)          ## 8-byte Spill
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	56(%rsi), %rdx
	leaq	168(%rsp), %rdi
	callq	l_mulPv576x64
	movq	240(%rsp), %r8
	movq	232(%rsp), %rdx
	movq	224(%rsp), %rsi
	movq	216(%rsp), %rdi
	movq	208(%rsp), %rbx
	movq	200(%rsp), %rcx
	addq	168(%rsp), %r12
	movq	192(%rsp), %r15
	movq	176(%rsp), %r13
	movq	184(%rsp), %rbp
	movq	72(%rsp), %rax          ## 8-byte Reload
	movq	%r12, 56(%rax)
	adcq	%r14, %r13
	adcq	40(%rsp), %rbp          ## 8-byte Folded Reload
	adcq	48(%rsp), %r15          ## 8-byte Folded Reload
	adcq	56(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, %r12
	adcq	8(%rsp), %rbx           ## 8-byte Folded Reload
	movq	%rbx, %r14
	adcq	16(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, 8(%rsp)           ## 8-byte Spill
	adcq	24(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 16(%rsp)          ## 8-byte Spill
	adcq	32(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 32(%rsp)           ## 8-byte Spill
	movq	64(%rsp), %rsi          ## 8-byte Reload
	movq	64(%rsi), %rdx
	leaq	88(%rsp), %rdi
	callq	l_mulPv576x64
	addq	88(%rsp), %r13
	adcq	96(%rsp), %rbp
	movq	160(%rsp), %r8
	adcq	104(%rsp), %r15
	movq	152(%rsp), %r9
	movq	144(%rsp), %rdx
	movq	136(%rsp), %rsi
	movq	128(%rsp), %rdi
	movq	120(%rsp), %rbx
	movq	112(%rsp), %rax
	movq	72(%rsp), %rcx          ## 8-byte Reload
	movq	%r13, 64(%rcx)
	movq	%rbp, 72(%rcx)
	adcq	%r12, %rax
	movq	%r15, 80(%rcx)
	movq	%rax, 88(%rcx)
	adcq	%r14, %rbx
	movq	%rbx, 96(%rcx)
	adcq	8(%rsp), %rdi           ## 8-byte Folded Reload
	movq	%rdi, 104(%rcx)
	adcq	16(%rsp), %rsi          ## 8-byte Folded Reload
	movq	%rsi, 112(%rcx)
	adcq	24(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 120(%rcx)
	adcq	32(%rsp), %r9           ## 8-byte Folded Reload
	movq	%r9, 128(%rcx)
	adcq	$0, %r8
	movq	%r8, 136(%rcx)
	addq	$808, %rsp              ## imm = 0x328
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_mont9L
	.p2align	4, 0x90
_mcl_fp_mont9L:                         ## @mcl_fp_mont9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1560, %rsp             ## imm = 0x618
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	movq	%rdx, 96(%rsp)          ## 8-byte Spill
	movq	%rsi, 88(%rsp)          ## 8-byte Spill
	movq	%rdi, 112(%rsp)         ## 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 80(%rsp)          ## 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1480(%rsp), %rdi
	callq	l_mulPv576x64
	movq	1480(%rsp), %r14
	movq	1488(%rsp), %r15
	movq	%r14, %rdx
	imulq	%rbx, %rdx
	movq	1552(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	1544(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	1536(%rsp), %rax
	movq	%rax, 56(%rsp)          ## 8-byte Spill
	movq	1528(%rsp), %r12
	movq	1520(%rsp), %r13
	movq	1512(%rsp), %rbx
	movq	1504(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	1496(%rsp), %rbp
	leaq	1400(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	1400(%rsp), %r14
	adcq	1408(%rsp), %r15
	adcq	1416(%rsp), %rbp
	movq	%rbp, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	1424(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	adcq	1432(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	adcq	1440(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	adcq	1448(%rsp), %r12
	movq	%r12, 48(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %rbx          ## 8-byte Reload
	adcq	1456(%rsp), %rbx
	movq	40(%rsp), %r14          ## 8-byte Reload
	adcq	1464(%rsp), %r14
	movq	24(%rsp), %r13          ## 8-byte Reload
	adcq	1472(%rsp), %r13
	sbbq	%rbp, %rbp
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1320(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %ebp
	addq	1320(%rsp), %r15
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	1328(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	1336(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %r12          ## 8-byte Reload
	adcq	1344(%rsp), %r12
	movq	16(%rsp), %rax          ## 8-byte Reload
	adcq	1352(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rax          ## 8-byte Reload
	adcq	1360(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	adcq	1368(%rsp), %rbx
	adcq	1376(%rsp), %r14
	movq	%r14, 40(%rsp)          ## 8-byte Spill
	adcq	1384(%rsp), %r13
	movq	%r13, 24(%rsp)          ## 8-byte Spill
	adcq	1392(%rsp), %rbp
	sbbq	%r14, %r14
	movq	%r15, %rdx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	1240(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	%r14, %rax
	andl	$1, %eax
	addq	1240(%rsp), %r15
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	1248(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	1256(%rsp), %r14
	adcq	1264(%rsp), %r12
	movq	%r12, 32(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	1272(%rsp), %r12
	movq	48(%rsp), %r13          ## 8-byte Reload
	adcq	1280(%rsp), %r13
	adcq	1288(%rsp), %rbx
	movq	%rbx, 56(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %r15          ## 8-byte Reload
	adcq	1296(%rsp), %r15
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	1304(%rsp), %rbx
	adcq	1312(%rsp), %rbp
	adcq	$0, %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	16(%rax), %rdx
	leaq	1160(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	8(%rsp), %rax           ## 8-byte Reload
	addq	1160(%rsp), %rax
	adcq	1168(%rsp), %r14
	movq	%r14, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %r14          ## 8-byte Reload
	adcq	1176(%rsp), %r14
	adcq	1184(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	movq	%r13, %r12
	adcq	1192(%rsp), %r12
	movq	56(%rsp), %rcx          ## 8-byte Reload
	adcq	1200(%rsp), %rcx
	movq	%rcx, 56(%rsp)          ## 8-byte Spill
	adcq	1208(%rsp), %r15
	movq	%r15, %r13
	adcq	1216(%rsp), %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	adcq	1224(%rsp), %rbp
	movq	64(%rsp), %rcx          ## 8-byte Reload
	adcq	1232(%rsp), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	sbbq	%r15, %r15
	movq	%rax, %rdx
	movq	%rax, %rbx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	1080(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	%r15, %rax
	andl	$1, %eax
	addq	1080(%rsp), %rbx
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	1088(%rsp), %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	%r14, %r15
	adcq	1096(%rsp), %r15
	movq	16(%rsp), %r14          ## 8-byte Reload
	adcq	1104(%rsp), %r14
	movq	%r12, %rbx
	adcq	1112(%rsp), %rbx
	movq	56(%rsp), %rcx          ## 8-byte Reload
	adcq	1120(%rsp), %rcx
	movq	%rcx, 56(%rsp)          ## 8-byte Spill
	adcq	1128(%rsp), %r13
	movq	%r13, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %r13          ## 8-byte Reload
	adcq	1136(%rsp), %r13
	adcq	1144(%rsp), %rbp
	movq	64(%rsp), %r12          ## 8-byte Reload
	adcq	1152(%rsp), %r12
	adcq	$0, %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	24(%rax), %rdx
	leaq	1000(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	(%rsp), %rax            ## 8-byte Reload
	addq	1000(%rsp), %rax
	adcq	1008(%rsp), %r15
	movq	%r15, 32(%rsp)          ## 8-byte Spill
	adcq	1016(%rsp), %r14
	movq	%r14, %r15
	adcq	1024(%rsp), %rbx
	movq	%rbx, 48(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %r14          ## 8-byte Reload
	adcq	1032(%rsp), %r14
	movq	40(%rsp), %rcx          ## 8-byte Reload
	adcq	1040(%rsp), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	adcq	1048(%rsp), %r13
	movq	%r13, 24(%rsp)          ## 8-byte Spill
	adcq	1056(%rsp), %rbp
	adcq	1064(%rsp), %r12
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	1072(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	sbbq	%rbx, %rbx
	movq	%rax, %rdx
	movq	%rax, %r13
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	920(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %ebx
	movq	%rbx, %rax
	addq	920(%rsp), %r13
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	928(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	adcq	936(%rsp), %r15
	movq	%r15, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %r15          ## 8-byte Reload
	adcq	944(%rsp), %r15
	movq	%r14, %r13
	adcq	952(%rsp), %r13
	movq	40(%rsp), %r14          ## 8-byte Reload
	adcq	960(%rsp), %r14
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	968(%rsp), %rbx
	adcq	976(%rsp), %rbp
	adcq	984(%rsp), %r12
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	992(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	32(%rax), %rdx
	leaq	840(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	32(%rsp), %rax          ## 8-byte Reload
	addq	840(%rsp), %rax
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	848(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	856(%rsp), %r15
	adcq	864(%rsp), %r13
	movq	%r13, 56(%rsp)          ## 8-byte Spill
	adcq	872(%rsp), %r14
	movq	%r14, 40(%rsp)          ## 8-byte Spill
	adcq	880(%rsp), %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	adcq	888(%rsp), %rbp
	adcq	896(%rsp), %r12
	movq	8(%rsp), %r13           ## 8-byte Reload
	adcq	904(%rsp), %r13
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	912(%rsp), %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	sbbq	%rbx, %rbx
	movq	%rax, %rdx
	movq	%rax, %r14
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	760(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %ebx
	movq	%rbx, %rax
	addq	760(%rsp), %r14
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	768(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	776(%rsp), %r15
	movq	56(%rsp), %r14          ## 8-byte Reload
	adcq	784(%rsp), %r14
	movq	40(%rsp), %rcx          ## 8-byte Reload
	adcq	792(%rsp), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	800(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	808(%rsp), %rbp
	movq	%r12, %rbx
	adcq	816(%rsp), %rbx
	movq	%r13, %r12
	adcq	824(%rsp), %r12
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	832(%rsp), %r13
	adcq	$0, %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	40(%rax), %rdx
	leaq	680(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	16(%rsp), %rax          ## 8-byte Reload
	addq	680(%rsp), %rax
	adcq	688(%rsp), %r15
	movq	%r15, 48(%rsp)          ## 8-byte Spill
	adcq	696(%rsp), %r14
	movq	%r14, 56(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rcx          ## 8-byte Reload
	adcq	704(%rsp), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %r15          ## 8-byte Reload
	adcq	712(%rsp), %r15
	adcq	720(%rsp), %rbp
	adcq	728(%rsp), %rbx
	movq	%rbx, 64(%rsp)          ## 8-byte Spill
	adcq	736(%rsp), %r12
	movq	%r12, 8(%rsp)           ## 8-byte Spill
	adcq	744(%rsp), %r13
	movq	%r13, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %r13          ## 8-byte Reload
	adcq	752(%rsp), %r13
	sbbq	%r14, %r14
	movq	%rax, %rdx
	movq	%rax, %rbx
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	600(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %r14d
	addq	600(%rsp), %rbx
	movq	48(%rsp), %rax          ## 8-byte Reload
	adcq	608(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %rax          ## 8-byte Reload
	adcq	616(%rsp), %rax
	movq	%rax, 56(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rbx          ## 8-byte Reload
	adcq	624(%rsp), %rbx
	adcq	632(%rsp), %r15
	movq	%r15, 24(%rsp)          ## 8-byte Spill
	adcq	640(%rsp), %rbp
	movq	64(%rsp), %r12          ## 8-byte Reload
	adcq	648(%rsp), %r12
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	656(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %r15            ## 8-byte Reload
	adcq	664(%rsp), %r15
	adcq	672(%rsp), %r13
	adcq	$0, %r14
	movq	%r14, 16(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	48(%rax), %rdx
	leaq	520(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	48(%rsp), %rax          ## 8-byte Reload
	addq	520(%rsp), %rax
	movq	56(%rsp), %r14          ## 8-byte Reload
	adcq	528(%rsp), %r14
	adcq	536(%rsp), %rbx
	movq	%rbx, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	544(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	552(%rsp), %rbp
	adcq	560(%rsp), %r12
	movq	%r12, 64(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r12           ## 8-byte Reload
	adcq	568(%rsp), %r12
	adcq	576(%rsp), %r15
	movq	%r15, (%rsp)            ## 8-byte Spill
	adcq	584(%rsp), %r13
	movq	%r13, 32(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %r15          ## 8-byte Reload
	adcq	592(%rsp), %r15
	sbbq	%rbx, %rbx
	movq	%rax, %rdx
	movq	%rax, %r13
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	440(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %ebx
	movq	%rbx, %rax
	addq	440(%rsp), %r13
	adcq	448(%rsp), %r14
	movq	%r14, 56(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %r14          ## 8-byte Reload
	adcq	456(%rsp), %r14
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	464(%rsp), %rbx
	adcq	472(%rsp), %rbp
	movq	%rbp, 104(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %rcx          ## 8-byte Reload
	adcq	480(%rsp), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	adcq	488(%rsp), %r12
	movq	%r12, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %rbp            ## 8-byte Reload
	adcq	496(%rsp), %rbp
	movq	32(%rsp), %r12          ## 8-byte Reload
	adcq	504(%rsp), %r12
	adcq	512(%rsp), %r15
	movq	%r15, %r13
	adcq	$0, %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	56(%rax), %rdx
	leaq	360(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	56(%rsp), %rax          ## 8-byte Reload
	addq	360(%rsp), %rax
	adcq	368(%rsp), %r14
	adcq	376(%rsp), %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	movq	104(%rsp), %rcx         ## 8-byte Reload
	adcq	384(%rsp), %rcx
	movq	%rcx, 104(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %rbx          ## 8-byte Reload
	adcq	392(%rsp), %rbx
	movq	8(%rsp), %r15           ## 8-byte Reload
	adcq	400(%rsp), %r15
	adcq	408(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	adcq	416(%rsp), %r12
	movq	%r12, %rbp
	adcq	424(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rcx          ## 8-byte Reload
	adcq	432(%rsp), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	sbbq	%r13, %r13
	movq	%rax, %rdx
	movq	%rax, %r12
	imulq	80(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	280(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %r13d
	addq	280(%rsp), %r12
	adcq	288(%rsp), %r14
	movq	%r14, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	296(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	104(%rsp), %r14         ## 8-byte Reload
	adcq	304(%rsp), %r14
	adcq	312(%rsp), %rbx
	movq	%rbx, 64(%rsp)          ## 8-byte Spill
	adcq	320(%rsp), %r15
	movq	%r15, 8(%rsp)           ## 8-byte Spill
	movq	(%rsp), %rbx            ## 8-byte Reload
	adcq	328(%rsp), %rbx
	adcq	336(%rsp), %rbp
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %r12          ## 8-byte Reload
	adcq	344(%rsp), %r12
	movq	48(%rsp), %rbp          ## 8-byte Reload
	adcq	352(%rsp), %rbp
	adcq	$0, %r13
	movq	96(%rsp), %rax          ## 8-byte Reload
	movq	64(%rax), %rdx
	leaq	200(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	40(%rsp), %rax          ## 8-byte Reload
	addq	200(%rsp), %rax
	movq	24(%rsp), %r15          ## 8-byte Reload
	adcq	208(%rsp), %r15
	adcq	216(%rsp), %r14
	movq	%r14, 104(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %r14          ## 8-byte Reload
	adcq	224(%rsp), %r14
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	232(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	adcq	240(%rsp), %rbx
	movq	%rbx, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	248(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	adcq	256(%rsp), %r12
	movq	%r12, 16(%rsp)          ## 8-byte Spill
	adcq	264(%rsp), %rbp
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	272(%rsp), %r13
	sbbq	%rbx, %rbx
	movq	80(%rsp), %rdx          ## 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r12
	leaq	120(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %ebx
	addq	120(%rsp), %r12
	adcq	128(%rsp), %r15
	movq	104(%rsp), %rbp         ## 8-byte Reload
	adcq	136(%rsp), %rbp
	movq	%r14, %rcx
	adcq	144(%rsp), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r8            ## 8-byte Reload
	adcq	152(%rsp), %r8
	movq	%r8, 8(%rsp)            ## 8-byte Spill
	movq	(%rsp), %r9             ## 8-byte Reload
	adcq	160(%rsp), %r9
	movq	%r9, (%rsp)             ## 8-byte Spill
	movq	32(%rsp), %r10          ## 8-byte Reload
	adcq	168(%rsp), %r10
	movq	%r10, 32(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %rdi          ## 8-byte Reload
	adcq	176(%rsp), %rdi
	movq	%rdi, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %r14          ## 8-byte Reload
	adcq	184(%rsp), %r14
	adcq	192(%rsp), %r13
	adcq	$0, %rbx
	movq	%r15, %rsi
	movq	%r15, %r12
	movq	72(%rsp), %rdx          ## 8-byte Reload
	subq	(%rdx), %rsi
	movq	%rbp, %rax
	movq	%rbp, %r15
	sbbq	8(%rdx), %rax
	movq	%rcx, %rbp
	sbbq	16(%rdx), %rbp
	movq	%r8, %rcx
	sbbq	24(%rdx), %rcx
	movq	%r9, %r8
	sbbq	32(%rdx), %r8
	movq	%r10, %r11
	sbbq	40(%rdx), %r11
	movq	%rdi, %r10
	sbbq	48(%rdx), %r10
	movq	%r14, %rdi
	sbbq	56(%rdx), %rdi
	movq	%r13, %r9
	sbbq	64(%rdx), %r9
	sbbq	$0, %rbx
	andl	$1, %ebx
	cmovneq	%r13, %r9
	testb	%bl, %bl
	cmovneq	%r12, %rsi
	movq	112(%rsp), %rbx         ## 8-byte Reload
	movq	%rsi, (%rbx)
	cmovneq	%r15, %rax
	movq	%rax, 8(%rbx)
	cmovneq	64(%rsp), %rbp          ## 8-byte Folded Reload
	movq	%rbp, 16(%rbx)
	cmovneq	8(%rsp), %rcx           ## 8-byte Folded Reload
	movq	%rcx, 24(%rbx)
	cmovneq	(%rsp), %r8             ## 8-byte Folded Reload
	movq	%r8, 32(%rbx)
	cmovneq	32(%rsp), %r11          ## 8-byte Folded Reload
	movq	%r11, 40(%rbx)
	cmovneq	16(%rsp), %r10          ## 8-byte Folded Reload
	movq	%r10, 48(%rbx)
	cmovneq	%r14, %rdi
	movq	%rdi, 56(%rbx)
	movq	%r9, 64(%rbx)
	addq	$1560, %rsp             ## imm = 0x618
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montNF9L
	.p2align	4, 0x90
_mcl_fp_montNF9L:                       ## @mcl_fp_montNF9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1560, %rsp             ## imm = 0x618
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	movq	%rdx, 80(%rsp)          ## 8-byte Spill
	movq	%rsi, 88(%rsp)          ## 8-byte Spill
	movq	%rdi, 112(%rsp)         ## 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 96(%rsp)          ## 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1480(%rsp), %rdi
	callq	l_mulPv576x64
	movq	1480(%rsp), %r12
	movq	1488(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	%r12, %rdx
	imulq	%rbx, %rdx
	movq	1552(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	movq	1544(%rsp), %r13
	movq	1536(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	movq	1528(%rsp), %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	movq	1520(%rsp), %r14
	movq	1512(%rsp), %r15
	movq	1504(%rsp), %rbx
	movq	1496(%rsp), %rbp
	leaq	1400(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	1400(%rsp), %r12
	movq	16(%rsp), %rax          ## 8-byte Reload
	adcq	1408(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	adcq	1416(%rsp), %rbp
	movq	%rbp, 104(%rsp)         ## 8-byte Spill
	adcq	1424(%rsp), %rbx
	movq	%rbx, (%rsp)            ## 8-byte Spill
	adcq	1432(%rsp), %r15
	movq	%r15, 8(%rsp)           ## 8-byte Spill
	adcq	1440(%rsp), %r14
	movq	%r14, 32(%rsp)          ## 8-byte Spill
	movq	64(%rsp), %rbx          ## 8-byte Reload
	adcq	1448(%rsp), %rbx
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	1456(%rsp), %r12
	adcq	1464(%rsp), %r13
	movq	%r13, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	1472(%rsp), %rbp
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1320(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	1392(%rsp), %rax
	movq	16(%rsp), %rcx          ## 8-byte Reload
	addq	1320(%rsp), %rcx
	movq	104(%rsp), %r15         ## 8-byte Reload
	adcq	1328(%rsp), %r15
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	1336(%rsp), %r14
	movq	8(%rsp), %rdx           ## 8-byte Reload
	adcq	1344(%rsp), %rdx
	movq	%rdx, 8(%rsp)           ## 8-byte Spill
	movq	32(%rsp), %r13          ## 8-byte Reload
	adcq	1352(%rsp), %r13
	adcq	1360(%rsp), %rbx
	movq	%rbx, 64(%rsp)          ## 8-byte Spill
	adcq	1368(%rsp), %r12
	movq	%r12, 48(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rdx          ## 8-byte Reload
	adcq	1376(%rsp), %rdx
	movq	%rdx, 40(%rsp)          ## 8-byte Spill
	adcq	1384(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, %rbp
	movq	%rcx, %rdx
	movq	%rcx, %rbx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	1240(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	1240(%rsp), %rbx
	adcq	1248(%rsp), %r15
	movq	%r15, 104(%rsp)         ## 8-byte Spill
	adcq	1256(%rsp), %r14
	movq	%r14, (%rsp)            ## 8-byte Spill
	movq	8(%rsp), %r12           ## 8-byte Reload
	adcq	1264(%rsp), %r12
	adcq	1272(%rsp), %r13
	movq	%r13, %r14
	movq	64(%rsp), %r13          ## 8-byte Reload
	adcq	1280(%rsp), %r13
	movq	48(%rsp), %rbx          ## 8-byte Reload
	adcq	1288(%rsp), %rbx
	movq	40(%rsp), %r15          ## 8-byte Reload
	adcq	1296(%rsp), %r15
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	1304(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	1312(%rsp), %rbp
	movq	%rbp, 56(%rsp)          ## 8-byte Spill
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	16(%rax), %rdx
	leaq	1160(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	1232(%rsp), %rax
	movq	104(%rsp), %rcx         ## 8-byte Reload
	addq	1160(%rsp), %rcx
	movq	(%rsp), %rbp            ## 8-byte Reload
	adcq	1168(%rsp), %rbp
	adcq	1176(%rsp), %r12
	movq	%r12, 8(%rsp)           ## 8-byte Spill
	adcq	1184(%rsp), %r14
	adcq	1192(%rsp), %r13
	movq	%r13, %r12
	adcq	1200(%rsp), %rbx
	movq	%rbx, 48(%rsp)          ## 8-byte Spill
	adcq	1208(%rsp), %r15
	movq	%r15, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rbx          ## 8-byte Reload
	adcq	1216(%rsp), %rbx
	movq	56(%rsp), %rdx          ## 8-byte Reload
	adcq	1224(%rsp), %rdx
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	movq	%rax, %r15
	adcq	$0, %r15
	movq	%rcx, %rdx
	movq	%rcx, %r13
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	1080(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	1080(%rsp), %r13
	adcq	1088(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	movq	8(%rsp), %r13           ## 8-byte Reload
	adcq	1096(%rsp), %r13
	adcq	1104(%rsp), %r14
	adcq	1112(%rsp), %r12
	movq	%r12, 64(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	1120(%rsp), %r12
	movq	40(%rsp), %rbp          ## 8-byte Reload
	adcq	1128(%rsp), %rbp
	adcq	1136(%rsp), %rbx
	movq	%rbx, 24(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %rbx          ## 8-byte Reload
	adcq	1144(%rsp), %rbx
	adcq	1152(%rsp), %r15
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	24(%rax), %rdx
	leaq	1000(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	1072(%rsp), %rax
	movq	(%rsp), %rcx            ## 8-byte Reload
	addq	1000(%rsp), %rcx
	adcq	1008(%rsp), %r13
	movq	%r13, 8(%rsp)           ## 8-byte Spill
	adcq	1016(%rsp), %r14
	movq	%r14, 32(%rsp)          ## 8-byte Spill
	movq	64(%rsp), %r14          ## 8-byte Reload
	adcq	1024(%rsp), %r14
	adcq	1032(%rsp), %r12
	adcq	1040(%rsp), %rbp
	movq	%rbp, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %r13          ## 8-byte Reload
	adcq	1048(%rsp), %r13
	adcq	1056(%rsp), %rbx
	movq	%rbx, 56(%rsp)          ## 8-byte Spill
	adcq	1064(%rsp), %r15
	movq	%r15, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	%rcx, %rdx
	movq	%rcx, %rbx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	920(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	920(%rsp), %rbx
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	928(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	movq	32(%rsp), %rbp          ## 8-byte Reload
	adcq	936(%rsp), %rbp
	movq	%r14, %rbx
	adcq	944(%rsp), %rbx
	adcq	952(%rsp), %r12
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	960(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	968(%rsp), %r13
	movq	%r13, %r15
	movq	56(%rsp), %r13          ## 8-byte Reload
	adcq	976(%rsp), %r13
	movq	16(%rsp), %r14          ## 8-byte Reload
	adcq	984(%rsp), %r14
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	992(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	32(%rax), %rdx
	leaq	840(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	912(%rsp), %rax
	movq	8(%rsp), %rcx           ## 8-byte Reload
	addq	840(%rsp), %rcx
	adcq	848(%rsp), %rbp
	movq	%rbp, 32(%rsp)          ## 8-byte Spill
	adcq	856(%rsp), %rbx
	movq	%rbx, 64(%rsp)          ## 8-byte Spill
	adcq	864(%rsp), %r12
	movq	40(%rsp), %rbp          ## 8-byte Reload
	adcq	872(%rsp), %rbp
	adcq	880(%rsp), %r15
	movq	%r15, 24(%rsp)          ## 8-byte Spill
	adcq	888(%rsp), %r13
	adcq	896(%rsp), %r14
	movq	%r14, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rdx            ## 8-byte Reload
	adcq	904(%rsp), %rdx
	movq	%rdx, (%rsp)            ## 8-byte Spill
	adcq	$0, %rax
	movq	%rax, %r14
	movq	%rcx, %rdx
	movq	%rcx, %rbx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	760(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	760(%rsp), %rbx
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	768(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	64(%rsp), %r15          ## 8-byte Reload
	adcq	776(%rsp), %r15
	adcq	784(%rsp), %r12
	movq	%r12, 48(%rsp)          ## 8-byte Spill
	movq	%rbp, %rbx
	adcq	792(%rsp), %rbx
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	800(%rsp), %rbp
	adcq	808(%rsp), %r13
	movq	16(%rsp), %rax          ## 8-byte Reload
	adcq	816(%rsp), %rax
	movq	%rax, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r12            ## 8-byte Reload
	adcq	824(%rsp), %r12
	adcq	832(%rsp), %r14
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	40(%rax), %rdx
	leaq	680(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	752(%rsp), %rcx
	movq	32(%rsp), %rax          ## 8-byte Reload
	addq	680(%rsp), %rax
	adcq	688(%rsp), %r15
	movq	%r15, 64(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rdx          ## 8-byte Reload
	adcq	696(%rsp), %rdx
	movq	%rdx, 48(%rsp)          ## 8-byte Spill
	adcq	704(%rsp), %rbx
	movq	%rbx, 40(%rsp)          ## 8-byte Spill
	adcq	712(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	adcq	720(%rsp), %r13
	movq	%r13, %r15
	movq	16(%rsp), %rbx          ## 8-byte Reload
	adcq	728(%rsp), %rbx
	adcq	736(%rsp), %r12
	movq	%r12, (%rsp)            ## 8-byte Spill
	adcq	744(%rsp), %r14
	movq	%r14, 32(%rsp)          ## 8-byte Spill
	adcq	$0, %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, %r13
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	600(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	600(%rsp), %r13
	movq	64(%rsp), %r13          ## 8-byte Reload
	adcq	608(%rsp), %r13
	movq	48(%rsp), %r12          ## 8-byte Reload
	adcq	616(%rsp), %r12
	movq	40(%rsp), %rbp          ## 8-byte Reload
	adcq	624(%rsp), %rbp
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	632(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	640(%rsp), %r15
	movq	%r15, 56(%rsp)          ## 8-byte Spill
	adcq	648(%rsp), %rbx
	movq	%rbx, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	656(%rsp), %r14
	movq	32(%rsp), %rbx          ## 8-byte Reload
	adcq	664(%rsp), %rbx
	movq	8(%rsp), %r15           ## 8-byte Reload
	adcq	672(%rsp), %r15
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	48(%rax), %rdx
	leaq	520(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	592(%rsp), %rcx
	movq	%r13, %rax
	addq	520(%rsp), %rax
	adcq	528(%rsp), %r12
	movq	%r12, 48(%rsp)          ## 8-byte Spill
	movq	%rbp, %r12
	adcq	536(%rsp), %r12
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	544(%rsp), %rbp
	movq	56(%rsp), %rdx          ## 8-byte Reload
	adcq	552(%rsp), %rdx
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %rdx          ## 8-byte Reload
	adcq	560(%rsp), %rdx
	movq	%rdx, 16(%rsp)          ## 8-byte Spill
	adcq	568(%rsp), %r14
	movq	%r14, (%rsp)            ## 8-byte Spill
	adcq	576(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	adcq	584(%rsp), %r15
	movq	%r15, 8(%rsp)           ## 8-byte Spill
	adcq	$0, %rcx
	movq	%rcx, %r13
	movq	%rax, %rdx
	movq	%rax, %r14
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	440(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	440(%rsp), %r14
	movq	48(%rsp), %rax          ## 8-byte Reload
	adcq	448(%rsp), %rax
	movq	%rax, 48(%rsp)          ## 8-byte Spill
	adcq	456(%rsp), %r12
	adcq	464(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %r14          ## 8-byte Reload
	adcq	472(%rsp), %r14
	movq	16(%rsp), %r15          ## 8-byte Reload
	adcq	480(%rsp), %r15
	movq	(%rsp), %rbp            ## 8-byte Reload
	adcq	488(%rsp), %rbp
	movq	32(%rsp), %rbx          ## 8-byte Reload
	adcq	496(%rsp), %rbx
	movq	8(%rsp), %rax           ## 8-byte Reload
	adcq	504(%rsp), %rax
	movq	%rax, 8(%rsp)           ## 8-byte Spill
	adcq	512(%rsp), %r13
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	56(%rax), %rdx
	leaq	360(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	432(%rsp), %rcx
	movq	48(%rsp), %rax          ## 8-byte Reload
	addq	360(%rsp), %rax
	adcq	368(%rsp), %r12
	movq	%r12, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rdx          ## 8-byte Reload
	adcq	376(%rsp), %rdx
	movq	%rdx, 24(%rsp)          ## 8-byte Spill
	adcq	384(%rsp), %r14
	movq	%r14, 56(%rsp)          ## 8-byte Spill
	adcq	392(%rsp), %r15
	movq	%r15, 16(%rsp)          ## 8-byte Spill
	adcq	400(%rsp), %rbp
	movq	%rbp, (%rsp)            ## 8-byte Spill
	adcq	408(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r14           ## 8-byte Reload
	adcq	416(%rsp), %r14
	adcq	424(%rsp), %r13
	movq	%r13, %r15
	adcq	$0, %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	%rax, %rdx
	movq	%rax, %r12
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	280(%rsp), %rdi
	movq	72(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	addq	280(%rsp), %r12
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	288(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	296(%rsp), %rbp
	movq	56(%rsp), %rax          ## 8-byte Reload
	adcq	304(%rsp), %rax
	movq	%rax, 56(%rsp)          ## 8-byte Spill
	movq	16(%rsp), %r13          ## 8-byte Reload
	adcq	312(%rsp), %r13
	movq	(%rsp), %r12            ## 8-byte Reload
	adcq	320(%rsp), %r12
	movq	32(%rsp), %rbx          ## 8-byte Reload
	adcq	328(%rsp), %rbx
	adcq	336(%rsp), %r14
	movq	%r14, 8(%rsp)           ## 8-byte Spill
	adcq	344(%rsp), %r15
	movq	%r15, 64(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %r14          ## 8-byte Reload
	adcq	352(%rsp), %r14
	movq	80(%rsp), %rax          ## 8-byte Reload
	movq	64(%rax), %rdx
	leaq	200(%rsp), %rdi
	movq	88(%rsp), %rsi          ## 8-byte Reload
	callq	l_mulPv576x64
	movq	272(%rsp), %rcx
	movq	40(%rsp), %rax          ## 8-byte Reload
	addq	200(%rsp), %rax
	adcq	208(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	56(%rsp), %rbp          ## 8-byte Reload
	adcq	216(%rsp), %rbp
	adcq	224(%rsp), %r13
	movq	%r13, 16(%rsp)          ## 8-byte Spill
	adcq	232(%rsp), %r12
	movq	%r12, (%rsp)            ## 8-byte Spill
	adcq	240(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r15           ## 8-byte Reload
	adcq	248(%rsp), %r15
	movq	64(%rsp), %r12          ## 8-byte Reload
	adcq	256(%rsp), %r12
	adcq	264(%rsp), %r14
	adcq	$0, %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	96(%rsp), %rdx          ## 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	leaq	120(%rsp), %rdi
	movq	72(%rsp), %r13          ## 8-byte Reload
	movq	%r13, %rsi
	callq	l_mulPv576x64
	addq	120(%rsp), %rbx
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	128(%rsp), %rcx
	movq	%rbp, %rdx
	adcq	136(%rsp), %rdx
	movq	16(%rsp), %rsi          ## 8-byte Reload
	adcq	144(%rsp), %rsi
	movq	%rsi, 16(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rdi            ## 8-byte Reload
	adcq	152(%rsp), %rdi
	movq	%rdi, (%rsp)            ## 8-byte Spill
	movq	32(%rsp), %rbx          ## 8-byte Reload
	adcq	160(%rsp), %rbx
	movq	%rbx, 32(%rsp)          ## 8-byte Spill
	movq	%r15, %r8
	adcq	168(%rsp), %r8
	movq	%r8, 8(%rsp)            ## 8-byte Spill
	movq	%r12, %r15
	adcq	176(%rsp), %r15
	adcq	184(%rsp), %r14
	movq	40(%rsp), %r9           ## 8-byte Reload
	adcq	192(%rsp), %r9
	movq	%rcx, %rax
	movq	%rcx, %r11
	movq	%r13, %rbp
	subq	(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rdx, %r12
	sbbq	8(%rbp), %rcx
	movq	%rsi, %rdx
	sbbq	16(%rbp), %rdx
	movq	%rdi, %rsi
	sbbq	24(%rbp), %rsi
	movq	%rbx, %rdi
	sbbq	32(%rbp), %rdi
	movq	%r8, %r10
	sbbq	40(%rbp), %r10
	movq	%r15, %r13
	sbbq	48(%rbp), %r13
	movq	%r14, %r8
	sbbq	56(%rbp), %r8
	movq	%rbp, %rbx
	movq	%r9, %rbp
	sbbq	64(%rbx), %rbp
	movq	%rbp, %rbx
	sarq	$63, %rbx
	cmovsq	%r11, %rax
	movq	112(%rsp), %rbx         ## 8-byte Reload
	movq	%rax, (%rbx)
	cmovsq	%r12, %rcx
	movq	%rcx, 8(%rbx)
	cmovsq	16(%rsp), %rdx          ## 8-byte Folded Reload
	movq	%rdx, 16(%rbx)
	cmovsq	(%rsp), %rsi            ## 8-byte Folded Reload
	movq	%rsi, 24(%rbx)
	cmovsq	32(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, 32(%rbx)
	cmovsq	8(%rsp), %r10           ## 8-byte Folded Reload
	movq	%r10, 40(%rbx)
	cmovsq	%r15, %r13
	movq	%r13, 48(%rbx)
	cmovsq	%r14, %r8
	movq	%r8, 56(%rbx)
	cmovsq	%r9, %rbp
	movq	%rbp, 64(%rbx)
	addq	$1560, %rsp             ## imm = 0x618
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_montRed9L
	.p2align	4, 0x90
_mcl_fp_montRed9L:                      ## @mcl_fp_montRed9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$936, %rsp              ## imm = 0x3A8
	movq	%rdx, %rax
	movq	%rdi, 208(%rsp)         ## 8-byte Spill
	movq	-8(%rax), %rcx
	movq	%rcx, 96(%rsp)          ## 8-byte Spill
	movq	(%rsi), %r14
	movq	8(%rsi), %rdx
	movq	%rdx, (%rsp)            ## 8-byte Spill
	movq	%r14, %rdx
	imulq	%rcx, %rdx
	movq	136(%rsi), %rcx
	movq	%rcx, 88(%rsp)          ## 8-byte Spill
	movq	128(%rsi), %rcx
	movq	%rcx, 56(%rsp)          ## 8-byte Spill
	movq	120(%rsi), %rcx
	movq	%rcx, 80(%rsp)          ## 8-byte Spill
	movq	112(%rsi), %rcx
	movq	%rcx, 72(%rsp)          ## 8-byte Spill
	movq	104(%rsi), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	96(%rsi), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	88(%rsi), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	80(%rsi), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	movq	72(%rsi), %r12
	movq	64(%rsi), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	56(%rsi), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	48(%rsi), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	movq	40(%rsi), %rbp
	movq	32(%rsi), %rbx
	movq	24(%rsi), %r13
	movq	16(%rsi), %r15
	movq	%rax, %rcx
	movq	(%rcx), %rax
	movq	%rax, 144(%rsp)         ## 8-byte Spill
	movq	64(%rcx), %rax
	movq	%rax, 200(%rsp)         ## 8-byte Spill
	movq	56(%rcx), %rax
	movq	%rax, 192(%rsp)         ## 8-byte Spill
	movq	48(%rcx), %rax
	movq	%rax, 184(%rsp)         ## 8-byte Spill
	movq	40(%rcx), %rax
	movq	%rax, 176(%rsp)         ## 8-byte Spill
	movq	32(%rcx), %rax
	movq	%rax, 168(%rsp)         ## 8-byte Spill
	movq	24(%rcx), %rax
	movq	%rax, 160(%rsp)         ## 8-byte Spill
	movq	16(%rcx), %rax
	movq	%rax, 152(%rsp)         ## 8-byte Spill
	movq	8(%rcx), %rax
	movq	%rax, 136(%rsp)         ## 8-byte Spill
	movq	%rcx, %rsi
	movq	%rsi, 104(%rsp)         ## 8-byte Spill
	leaq	856(%rsp), %rdi
	callq	l_mulPv576x64
	addq	856(%rsp), %r14
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	864(%rsp), %rcx
	adcq	872(%rsp), %r15
	adcq	880(%rsp), %r13
	adcq	888(%rsp), %rbx
	movq	%rbx, 120(%rsp)         ## 8-byte Spill
	adcq	896(%rsp), %rbp
	movq	%rbp, 112(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %rax          ## 8-byte Reload
	adcq	904(%rsp), %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	912(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	920(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	adcq	928(%rsp), %r12
	movq	%r12, (%rsp)            ## 8-byte Spill
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	$0, %rbp
	adcq	$0, 8(%rsp)             ## 8-byte Folded Spill
	adcq	$0, 16(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 48(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 72(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 56(%rsp)            ## 8-byte Folded Spill
	movq	88(%rsp), %r14          ## 8-byte Reload
	adcq	$0, %r14
	sbbq	%r12, %r12
	movq	%rcx, %rdx
	movq	%rcx, %rbx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	776(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	andl	$1, %r12d
	addq	776(%rsp), %rbx
	adcq	784(%rsp), %r15
	adcq	792(%rsp), %r13
	movq	%r13, 128(%rsp)         ## 8-byte Spill
	movq	120(%rsp), %rax         ## 8-byte Reload
	adcq	800(%rsp), %rax
	movq	%rax, 120(%rsp)         ## 8-byte Spill
	movq	112(%rsp), %rax         ## 8-byte Reload
	adcq	808(%rsp), %rax
	movq	%rax, 112(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %rax          ## 8-byte Reload
	adcq	816(%rsp), %rax
	movq	%rax, 64(%rsp)          ## 8-byte Spill
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	824(%rsp), %rax
	movq	%rax, 32(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	832(%rsp), %rax
	movq	%rax, 40(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	840(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	adcq	848(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r13           ## 8-byte Reload
	adcq	$0, %r13
	adcq	$0, 16(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 48(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 72(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	movq	56(%rsp), %rbx          ## 8-byte Reload
	adcq	$0, %rbx
	adcq	$0, %r14
	movq	%r14, 88(%rsp)          ## 8-byte Spill
	adcq	$0, %r12
	movq	%r15, %rdx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	696(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	696(%rsp), %r15
	movq	128(%rsp), %rcx         ## 8-byte Reload
	adcq	704(%rsp), %rcx
	movq	120(%rsp), %rax         ## 8-byte Reload
	adcq	712(%rsp), %rax
	movq	%rax, 120(%rsp)         ## 8-byte Spill
	movq	112(%rsp), %rax         ## 8-byte Reload
	adcq	720(%rsp), %rax
	movq	%rax, 112(%rsp)         ## 8-byte Spill
	movq	64(%rsp), %rbp          ## 8-byte Reload
	adcq	728(%rsp), %rbp
	movq	32(%rsp), %r14          ## 8-byte Reload
	adcq	736(%rsp), %r14
	movq	40(%rsp), %r15          ## 8-byte Reload
	adcq	744(%rsp), %r15
	movq	(%rsp), %rax            ## 8-byte Reload
	adcq	752(%rsp), %rax
	movq	%rax, (%rsp)            ## 8-byte Spill
	movq	24(%rsp), %rax          ## 8-byte Reload
	adcq	760(%rsp), %rax
	movq	%rax, 24(%rsp)          ## 8-byte Spill
	adcq	768(%rsp), %r13
	movq	%r13, 8(%rsp)           ## 8-byte Spill
	adcq	$0, 16(%rsp)            ## 8-byte Folded Spill
	movq	48(%rsp), %r13          ## 8-byte Reload
	adcq	$0, %r13
	adcq	$0, 72(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %rbx
	movq	%rbx, 56(%rsp)          ## 8-byte Spill
	adcq	$0, 88(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %r12
	movq	%rcx, %rbx
	movq	%rbx, %rdx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	616(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	616(%rsp), %rbx
	movq	120(%rsp), %rax         ## 8-byte Reload
	adcq	624(%rsp), %rax
	movq	112(%rsp), %rcx         ## 8-byte Reload
	adcq	632(%rsp), %rcx
	movq	%rcx, 112(%rsp)         ## 8-byte Spill
	adcq	640(%rsp), %rbp
	movq	%rbp, 64(%rsp)          ## 8-byte Spill
	adcq	648(%rsp), %r14
	movq	%r14, 32(%rsp)          ## 8-byte Spill
	adcq	656(%rsp), %r15
	movq	(%rsp), %r14            ## 8-byte Reload
	adcq	664(%rsp), %r14
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	672(%rsp), %rbp
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	680(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	688(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	adcq	$0, %r13
	movq	%r13, 48(%rsp)          ## 8-byte Spill
	adcq	$0, 72(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 56(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 88(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %r12
	movq	%rax, %rbx
	movq	%rbx, %rdx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	536(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	536(%rsp), %rbx
	movq	112(%rsp), %rax         ## 8-byte Reload
	adcq	544(%rsp), %rax
	movq	64(%rsp), %rcx          ## 8-byte Reload
	adcq	552(%rsp), %rcx
	movq	%rcx, 64(%rsp)          ## 8-byte Spill
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	560(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	adcq	568(%rsp), %r15
	movq	%r15, 40(%rsp)          ## 8-byte Spill
	adcq	576(%rsp), %r14
	movq	%r14, (%rsp)            ## 8-byte Spill
	adcq	584(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r13           ## 8-byte Reload
	adcq	592(%rsp), %r13
	movq	16(%rsp), %r15          ## 8-byte Reload
	adcq	600(%rsp), %r15
	movq	48(%rsp), %rbp          ## 8-byte Reload
	adcq	608(%rsp), %rbp
	movq	72(%rsp), %rbx          ## 8-byte Reload
	adcq	$0, %rbx
	adcq	$0, 80(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 56(%rsp)            ## 8-byte Folded Spill
	adcq	$0, 88(%rsp)            ## 8-byte Folded Spill
	adcq	$0, %r12
	movq	%rax, %rdx
	movq	%rax, %r14
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	456(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	456(%rsp), %r14
	movq	64(%rsp), %rax          ## 8-byte Reload
	adcq	464(%rsp), %rax
	movq	32(%rsp), %rcx          ## 8-byte Reload
	adcq	472(%rsp), %rcx
	movq	%rcx, 32(%rsp)          ## 8-byte Spill
	movq	40(%rsp), %rcx          ## 8-byte Reload
	adcq	480(%rsp), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	488(%rsp), %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	24(%rsp), %rcx          ## 8-byte Reload
	adcq	496(%rsp), %rcx
	movq	%rcx, 24(%rsp)          ## 8-byte Spill
	adcq	504(%rsp), %r13
	movq	%r13, 8(%rsp)           ## 8-byte Spill
	adcq	512(%rsp), %r15
	movq	%r15, 16(%rsp)          ## 8-byte Spill
	adcq	520(%rsp), %rbp
	movq	%rbp, 48(%rsp)          ## 8-byte Spill
	adcq	528(%rsp), %rbx
	movq	%rbx, 72(%rsp)          ## 8-byte Spill
	movq	80(%rsp), %r14          ## 8-byte Reload
	adcq	$0, %r14
	movq	56(%rsp), %r13          ## 8-byte Reload
	adcq	$0, %r13
	movq	88(%rsp), %rbx          ## 8-byte Reload
	adcq	$0, %rbx
	adcq	$0, %r12
	movq	%rax, %rdx
	movq	%rax, %r15
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	376(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	376(%rsp), %r15
	movq	32(%rsp), %rax          ## 8-byte Reload
	adcq	384(%rsp), %rax
	movq	40(%rsp), %rcx          ## 8-byte Reload
	adcq	392(%rsp), %rcx
	movq	%rcx, 40(%rsp)          ## 8-byte Spill
	movq	(%rsp), %rcx            ## 8-byte Reload
	adcq	400(%rsp), %rcx
	movq	%rcx, (%rsp)            ## 8-byte Spill
	movq	24(%rsp), %rbp          ## 8-byte Reload
	adcq	408(%rsp), %rbp
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	416(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	424(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rcx          ## 8-byte Reload
	adcq	432(%rsp), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	movq	72(%rsp), %r15          ## 8-byte Reload
	adcq	440(%rsp), %r15
	adcq	448(%rsp), %r14
	movq	%r14, 80(%rsp)          ## 8-byte Spill
	adcq	$0, %r13
	movq	%r13, %r14
	adcq	$0, %rbx
	movq	%rbx, 88(%rsp)          ## 8-byte Spill
	adcq	$0, %r12
	movq	%rax, %rbx
	movq	%rbx, %rdx
	imulq	96(%rsp), %rdx          ## 8-byte Folded Reload
	leaq	296(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	296(%rsp), %rbx
	movq	40(%rsp), %rax          ## 8-byte Reload
	adcq	304(%rsp), %rax
	movq	(%rsp), %r13            ## 8-byte Reload
	adcq	312(%rsp), %r13
	adcq	320(%rsp), %rbp
	movq	8(%rsp), %rcx           ## 8-byte Reload
	adcq	328(%rsp), %rcx
	movq	%rcx, 8(%rsp)           ## 8-byte Spill
	movq	16(%rsp), %rcx          ## 8-byte Reload
	adcq	336(%rsp), %rcx
	movq	%rcx, 16(%rsp)          ## 8-byte Spill
	movq	48(%rsp), %rcx          ## 8-byte Reload
	adcq	344(%rsp), %rcx
	movq	%rcx, 48(%rsp)          ## 8-byte Spill
	adcq	352(%rsp), %r15
	movq	%r15, 72(%rsp)          ## 8-byte Spill
	movq	80(%rsp), %r15          ## 8-byte Reload
	adcq	360(%rsp), %r15
	adcq	368(%rsp), %r14
	movq	%r14, 56(%rsp)          ## 8-byte Spill
	movq	88(%rsp), %r14          ## 8-byte Reload
	adcq	$0, %r14
	adcq	$0, %r12
	movq	96(%rsp), %rdx          ## 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	leaq	216(%rsp), %rdi
	movq	104(%rsp), %rsi         ## 8-byte Reload
	callq	l_mulPv576x64
	addq	216(%rsp), %rbx
	movq	%r13, %rsi
	adcq	224(%rsp), %rsi
	movq	%rsi, (%rsp)            ## 8-byte Spill
	adcq	232(%rsp), %rbp
	movq	%rbp, 24(%rsp)          ## 8-byte Spill
	movq	8(%rsp), %r9            ## 8-byte Reload
	adcq	240(%rsp), %r9
	movq	%r9, 8(%rsp)            ## 8-byte Spill
	movq	16(%rsp), %r8           ## 8-byte Reload
	adcq	248(%rsp), %r8
	movq	%r8, 16(%rsp)           ## 8-byte Spill
	movq	48(%rsp), %rbx          ## 8-byte Reload
	adcq	256(%rsp), %rbx
	movq	72(%rsp), %rax          ## 8-byte Reload
	adcq	264(%rsp), %rax
	movq	%r15, %rcx
	adcq	272(%rsp), %rcx
	movq	56(%rsp), %rdx          ## 8-byte Reload
	adcq	280(%rsp), %rdx
	movq	%rdx, 56(%rsp)          ## 8-byte Spill
	adcq	288(%rsp), %r14
	movq	%r14, %r11
	adcq	$0, %r12
	subq	144(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rbp, %rdi
	sbbq	136(%rsp), %rdi         ## 8-byte Folded Reload
	movq	%r9, %rbp
	sbbq	152(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%r8, %r13
	sbbq	160(%rsp), %r13         ## 8-byte Folded Reload
	movq	%rbx, %r15
	sbbq	168(%rsp), %r15         ## 8-byte Folded Reload
	movq	%rax, %r14
	sbbq	176(%rsp), %r14         ## 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	184(%rsp), %r10         ## 8-byte Folded Reload
	movq	%rdx, %r8
	sbbq	192(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r11, %r9
	sbbq	200(%rsp), %r9          ## 8-byte Folded Reload
	sbbq	$0, %r12
	andl	$1, %r12d
	cmovneq	%r11, %r9
	testb	%r12b, %r12b
	cmovneq	(%rsp), %rsi            ## 8-byte Folded Reload
	movq	208(%rsp), %rdx         ## 8-byte Reload
	movq	%rsi, (%rdx)
	cmovneq	24(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, 8(%rdx)
	cmovneq	8(%rsp), %rbp           ## 8-byte Folded Reload
	movq	%rbp, 16(%rdx)
	cmovneq	16(%rsp), %r13          ## 8-byte Folded Reload
	movq	%r13, 24(%rdx)
	cmovneq	%rbx, %r15
	movq	%r15, 32(%rdx)
	cmovneq	%rax, %r14
	movq	%r14, 40(%rdx)
	cmovneq	%rcx, %r10
	movq	%r10, 48(%rdx)
	cmovneq	56(%rsp), %r8           ## 8-byte Folded Reload
	movq	%r8, 56(%rdx)
	movq	%r9, 64(%rdx)
	addq	$936, %rsp              ## imm = 0x3A8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_addPre9L
	.p2align	4, 0x90
_mcl_fp_addPre9L:                       ## @mcl_fp_addPre9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	64(%rdx), %r8
	movq	64(%rsi), %r15
	movq	56(%rsi), %r9
	movq	48(%rsi), %r10
	movq	40(%rsi), %r11
	movq	24(%rsi), %r12
	movq	32(%rsi), %r14
	movq	(%rdx), %rbx
	movq	8(%rdx), %rcx
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rcx
	movq	16(%rdx), %rax
	adcq	16(%rsi), %rax
	adcq	24(%rdx), %r12
	movq	56(%rdx), %r13
	movq	48(%rdx), %rsi
	movq	40(%rdx), %rbp
	movq	32(%rdx), %rdx
	movq	%rbx, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r12, 24(%rdi)
	adcq	%r14, %rdx
	movq	%rdx, 32(%rdi)
	adcq	%r11, %rbp
	movq	%rbp, 40(%rdi)
	adcq	%r10, %rsi
	movq	%rsi, 48(%rdi)
	adcq	%r9, %r13
	movq	%r13, 56(%rdi)
	adcq	%r8, %r15
	movq	%r15, 64(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_subPre9L
	.p2align	4, 0x90
_mcl_fp_subPre9L:                       ## @mcl_fp_subPre9L
## BB#0:
	movq	32(%rdx), %r8
	movq	(%rsi), %rcx
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	movq	%rcx, (%rdi)
	movq	8(%rsi), %rcx
	sbbq	8(%rdx), %rcx
	movq	%rcx, 8(%rdi)
	movq	16(%rsi), %rcx
	sbbq	16(%rdx), %rcx
	movq	%rcx, 16(%rdi)
	movq	24(%rsi), %rcx
	sbbq	24(%rdx), %rcx
	movq	%rcx, 24(%rdi)
	movq	32(%rsi), %rcx
	sbbq	%r8, %rcx
	movq	40(%rdx), %r8
	movq	%rcx, 32(%rdi)
	movq	40(%rsi), %rcx
	sbbq	%r8, %rcx
	movq	48(%rdx), %r8
	movq	%rcx, 40(%rdi)
	movq	48(%rsi), %rcx
	sbbq	%r8, %rcx
	movq	56(%rdx), %r8
	movq	%rcx, 48(%rdi)
	movq	56(%rsi), %rcx
	sbbq	%r8, %rcx
	movq	%rcx, 56(%rdi)
	movq	64(%rdx), %rcx
	movq	64(%rsi), %rdx
	sbbq	%rcx, %rdx
	movq	%rdx, 64(%rdi)
	sbbq	$0, %rax
	andl	$1, %eax
	retq

	.globl	_mcl_fp_shr1_9L
	.p2align	4, 0x90
_mcl_fp_shr1_9L:                        ## @mcl_fp_shr1_9L
## BB#0:
	pushq	%rbx
	movq	64(%rsi), %r8
	movq	56(%rsi), %r9
	movq	48(%rsi), %r10
	movq	40(%rsi), %r11
	movq	32(%rsi), %rcx
	movq	24(%rsi), %rdx
	movq	16(%rsi), %rax
	movq	(%rsi), %rbx
	movq	8(%rsi), %rsi
	shrdq	$1, %rsi, %rbx
	movq	%rbx, (%rdi)
	shrdq	$1, %rax, %rsi
	movq	%rsi, 8(%rdi)
	shrdq	$1, %rdx, %rax
	movq	%rax, 16(%rdi)
	shrdq	$1, %rcx, %rdx
	movq	%rdx, 24(%rdi)
	shrdq	$1, %r11, %rcx
	movq	%rcx, 32(%rdi)
	shrdq	$1, %r10, %r11
	movq	%r11, 40(%rdi)
	shrdq	$1, %r9, %r10
	movq	%r10, 48(%rdi)
	shrdq	$1, %r8, %r9
	movq	%r9, 56(%rdi)
	shrq	%r8
	movq	%r8, 64(%rdi)
	popq	%rbx
	retq

	.globl	_mcl_fp_add9L
	.p2align	4, 0x90
_mcl_fp_add9L:                          ## @mcl_fp_add9L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	64(%rdx), %r12
	movq	64(%rsi), %r8
	movq	56(%rsi), %r13
	movq	48(%rsi), %r9
	movq	40(%rsi), %r10
	movq	24(%rsi), %r14
	movq	32(%rsi), %r11
	movq	(%rdx), %rbx
	movq	8(%rdx), %r15
	addq	(%rsi), %rbx
	adcq	8(%rsi), %r15
	movq	16(%rdx), %rax
	adcq	16(%rsi), %rax
	adcq	24(%rdx), %r14
	adcq	32(%rdx), %r11
	adcq	40(%rdx), %r10
	movq	56(%rdx), %rsi
	adcq	48(%rdx), %r9
	movq	%rbx, (%rdi)
	movq	%r15, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r14, 24(%rdi)
	movq	%r11, 32(%rdi)
	movq	%r10, 40(%rdi)
	movq	%r9, 48(%rdi)
	adcq	%r13, %rsi
	movq	%rsi, 56(%rdi)
	adcq	%r12, %r8
	movq	%r8, 64(%rdi)
	sbbq	%rdx, %rdx
	andl	$1, %edx
	subq	(%rcx), %rbx
	sbbq	8(%rcx), %r15
	sbbq	16(%rcx), %rax
	sbbq	24(%rcx), %r14
	sbbq	32(%rcx), %r11
	sbbq	40(%rcx), %r10
	sbbq	48(%rcx), %r9
	sbbq	56(%rcx), %rsi
	sbbq	64(%rcx), %r8
	sbbq	$0, %rdx
	testb	$1, %dl
	jne	LBB136_2
## BB#1:                                ## %nocarry
	movq	%rbx, (%rdi)
	movq	%r15, 8(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r14, 24(%rdi)
	movq	%r11, 32(%rdi)
	movq	%r10, 40(%rdi)
	movq	%r9, 48(%rdi)
	movq	%rsi, 56(%rdi)
	movq	%r8, 64(%rdi)
LBB136_2:                               ## %carry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_addNF9L
	.p2align	4, 0x90
_mcl_fp_addNF9L:                        ## @mcl_fp_addNF9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r8
	movq	64(%rdx), %r10
	movq	56(%rdx), %r11
	movq	48(%rdx), %r9
	movq	40(%rdx), %rax
	movq	32(%rdx), %rdi
	movq	24(%rdx), %rbp
	movq	16(%rdx), %r15
	movq	(%rdx), %rbx
	movq	8(%rdx), %r13
	addq	(%rsi), %rbx
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %rbp
	movq	%rbp, -24(%rsp)         ## 8-byte Spill
	adcq	32(%rsi), %rdi
	movq	%rdi, -40(%rsp)         ## 8-byte Spill
	adcq	40(%rsi), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	adcq	48(%rsi), %r9
	movq	%r9, %rdi
	movq	%rdi, -16(%rsp)         ## 8-byte Spill
	adcq	56(%rsi), %r11
	movq	%r11, %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	adcq	64(%rsi), %r10
	movq	%r10, %r9
	movq	%rbx, %rsi
	subq	(%rcx), %rsi
	movq	%r13, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r15, %r12
	sbbq	16(%rcx), %r12
	sbbq	24(%rcx), %rbp
	movq	-40(%rsp), %r14         ## 8-byte Reload
	sbbq	32(%rcx), %r14
	movq	-32(%rsp), %r11         ## 8-byte Reload
	sbbq	40(%rcx), %r11
	movq	%rdi, %r10
	sbbq	48(%rcx), %r10
	movq	%rax, %rdi
	sbbq	56(%rcx), %rdi
	movq	%r9, %rax
	sbbq	64(%rcx), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	cmovsq	%rbx, %rsi
	movq	%rsi, (%r8)
	cmovsq	%r13, %rdx
	movq	%rdx, 8(%r8)
	cmovsq	%r15, %r12
	movq	%r12, 16(%r8)
	cmovsq	-24(%rsp), %rbp         ## 8-byte Folded Reload
	movq	%rbp, 24(%r8)
	cmovsq	-40(%rsp), %r14         ## 8-byte Folded Reload
	movq	%r14, 32(%r8)
	cmovsq	-32(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r11, 40(%r8)
	cmovsq	-16(%rsp), %r10         ## 8-byte Folded Reload
	movq	%r10, 48(%r8)
	cmovsq	-8(%rsp), %rdi          ## 8-byte Folded Reload
	movq	%rdi, 56(%r8)
	cmovsq	%r9, %rax
	movq	%rax, 64(%r8)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fp_sub9L
	.p2align	4, 0x90
_mcl_fp_sub9L:                          ## @mcl_fp_sub9L
## BB#0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	64(%rdx), %r13
	movq	(%rsi), %rax
	movq	8(%rsi), %r9
	xorl	%ebx, %ebx
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r9
	movq	16(%rsi), %r10
	sbbq	16(%rdx), %r10
	movq	24(%rsi), %r11
	sbbq	24(%rdx), %r11
	movq	32(%rsi), %r12
	sbbq	32(%rdx), %r12
	movq	40(%rsi), %r14
	sbbq	40(%rdx), %r14
	movq	48(%rsi), %r15
	sbbq	48(%rdx), %r15
	movq	64(%rsi), %r8
	movq	56(%rsi), %rsi
	sbbq	56(%rdx), %rsi
	movq	%rax, (%rdi)
	movq	%r9, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r11, 24(%rdi)
	movq	%r12, 32(%rdi)
	movq	%r14, 40(%rdi)
	movq	%r15, 48(%rdi)
	movq	%rsi, 56(%rdi)
	sbbq	%r13, %r8
	movq	%r8, 64(%rdi)
	sbbq	$0, %rbx
	testb	$1, %bl
	je	LBB138_2
## BB#1:                                ## %carry
	addq	(%rcx), %rax
	movq	%rax, (%rdi)
	movq	8(%rcx), %rax
	adcq	%r9, %rax
	movq	%rax, 8(%rdi)
	movq	16(%rcx), %rax
	adcq	%r10, %rax
	movq	%rax, 16(%rdi)
	movq	24(%rcx), %rax
	adcq	%r11, %rax
	movq	%rax, 24(%rdi)
	movq	32(%rcx), %rax
	adcq	%r12, %rax
	movq	%rax, 32(%rdi)
	movq	40(%rcx), %rax
	adcq	%r14, %rax
	movq	%rax, 40(%rdi)
	movq	48(%rcx), %rax
	adcq	%r15, %rax
	movq	%rax, 48(%rdi)
	movq	56(%rcx), %rax
	adcq	%rsi, %rax
	movq	%rax, 56(%rdi)
	movq	64(%rcx), %rax
	adcq	%r8, %rax
	movq	%rax, 64(%rdi)
LBB138_2:                               ## %nocarry
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq

	.globl	_mcl_fp_subNF9L
	.p2align	4, 0x90
_mcl_fp_subNF9L:                        ## @mcl_fp_subNF9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r11
	movq	%rdi, %rbx
	movq	64(%rsi), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movdqu	(%rdx), %xmm1
	movdqu	16(%rdx), %xmm2
	movdqu	32(%rdx), %xmm3
	movdqu	48(%rdx), %xmm4
	pshufd	$78, %xmm4, %xmm0       ## xmm0 = xmm4[2,3,0,1]
	movd	%xmm0, %r12
	movdqu	(%rsi), %xmm5
	movdqu	16(%rsi), %xmm6
	movdqu	32(%rsi), %xmm7
	movdqu	48(%rsi), %xmm8
	pshufd	$78, %xmm8, %xmm0       ## xmm0 = xmm8[2,3,0,1]
	movd	%xmm0, %rax
	movd	%xmm4, %r10
	pshufd	$78, %xmm3, %xmm0       ## xmm0 = xmm3[2,3,0,1]
	movd	%xmm0, %r9
	pshufd	$78, %xmm7, %xmm0       ## xmm0 = xmm7[2,3,0,1]
	movd	%xmm3, %r8
	pshufd	$78, %xmm2, %xmm3       ## xmm3 = xmm2[2,3,0,1]
	movd	%xmm3, %rcx
	pshufd	$78, %xmm6, %xmm3       ## xmm3 = xmm6[2,3,0,1]
	movd	%xmm2, %rbp
	pshufd	$78, %xmm1, %xmm2       ## xmm2 = xmm1[2,3,0,1]
	movd	%xmm2, %rsi
	pshufd	$78, %xmm5, %xmm2       ## xmm2 = xmm5[2,3,0,1]
	movd	%xmm1, %rdi
	movd	%xmm5, %r15
	subq	%rdi, %r15
	movd	%xmm2, %r14
	sbbq	%rsi, %r14
	movd	%xmm6, %r13
	sbbq	%rbp, %r13
	movd	%xmm3, %rbp
	sbbq	%rcx, %rbp
	movd	%xmm7, %rcx
	sbbq	%r8, %rcx
	movq	%rcx, -16(%rsp)         ## 8-byte Spill
	movd	%xmm0, %rcx
	sbbq	%r9, %rcx
	movq	%rcx, -24(%rsp)         ## 8-byte Spill
	movd	%xmm8, %rcx
	sbbq	%r10, %rcx
	movq	%rcx, -32(%rsp)         ## 8-byte Spill
	sbbq	%r12, %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	-40(%rsp), %rsi         ## 8-byte Reload
	sbbq	64(%rdx), %rsi
	movq	%rsi, -40(%rsp)         ## 8-byte Spill
	movq	%rsi, %rax
	sarq	$63, %rax
	movq	%rax, %rcx
	shldq	$1, %rsi, %rcx
	movq	24(%r11), %r9
	andq	%rcx, %r9
	movq	8(%r11), %rdi
	andq	%rcx, %rdi
	andq	(%r11), %rcx
	movq	64(%r11), %r12
	andq	%rax, %r12
	movq	56(%r11), %r10
	andq	%rax, %r10
	rolq	%rax
	movq	48(%r11), %r8
	andq	%rax, %r8
	movq	40(%r11), %rsi
	andq	%rax, %rsi
	movq	32(%r11), %rdx
	andq	%rax, %rdx
	andq	16(%r11), %rax
	addq	%r15, %rcx
	adcq	%r14, %rdi
	movq	%rcx, (%rbx)
	adcq	%r13, %rax
	movq	%rdi, 8(%rbx)
	adcq	%rbp, %r9
	movq	%rax, 16(%rbx)
	movq	%r9, 24(%rbx)
	adcq	-16(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, 32(%rbx)
	adcq	-24(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, 40(%rbx)
	adcq	-32(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, 48(%rbx)
	adcq	-8(%rsp), %r10          ## 8-byte Folded Reload
	movq	%r10, 56(%rbx)
	adcq	-40(%rsp), %r12         ## 8-byte Folded Reload
	movq	%r12, 64(%rbx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_add9L
	.p2align	4, 0x90
_mcl_fpDbl_add9L:                       ## @mcl_fpDbl_add9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r15
	movq	136(%rdx), %rax
	movq	%rax, -48(%rsp)         ## 8-byte Spill
	movq	128(%rdx), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	120(%rdx), %r10
	movq	112(%rdx), %r11
	movq	24(%rsi), %rcx
	movq	32(%rsi), %r14
	movq	16(%rdx), %rbp
	movq	(%rdx), %rax
	movq	8(%rdx), %rbx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %rbp
	adcq	24(%rdx), %rcx
	adcq	32(%rdx), %r14
	movq	104(%rdx), %r9
	movq	96(%rdx), %r13
	movq	%rax, (%rdi)
	movq	88(%rdx), %r8
	movq	%rbx, 8(%rdi)
	movq	80(%rdx), %r12
	movq	%rbp, 16(%rdi)
	movq	40(%rdx), %rax
	movq	%rcx, 24(%rdi)
	movq	40(%rsi), %rbp
	adcq	%rax, %rbp
	movq	48(%rdx), %rcx
	movq	%r14, 32(%rdi)
	movq	48(%rsi), %rax
	adcq	%rcx, %rax
	movq	56(%rdx), %r14
	movq	%rbp, 40(%rdi)
	movq	56(%rsi), %rbp
	adcq	%r14, %rbp
	movq	72(%rdx), %rcx
	movq	64(%rdx), %rdx
	movq	%rax, 48(%rdi)
	movq	64(%rsi), %rax
	adcq	%rdx, %rax
	movq	136(%rsi), %rbx
	movq	%rbp, 56(%rdi)
	movq	72(%rsi), %rbp
	adcq	%rcx, %rbp
	movq	128(%rsi), %rcx
	movq	%rax, 64(%rdi)
	movq	80(%rsi), %rdx
	adcq	%r12, %rdx
	movq	88(%rsi), %r12
	adcq	%r8, %r12
	movq	96(%rsi), %r14
	adcq	%r13, %r14
	movq	%r14, -8(%rsp)          ## 8-byte Spill
	movq	104(%rsi), %rax
	adcq	%r9, %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	120(%rsi), %rax
	movq	112(%rsi), %rsi
	adcq	%r11, %rsi
	movq	%rsi, -24(%rsp)         ## 8-byte Spill
	adcq	%r10, %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	adcq	-40(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -40(%rsp)         ## 8-byte Spill
	adcq	-48(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, -48(%rsp)         ## 8-byte Spill
	sbbq	%r9, %r9
	andl	$1, %r9d
	movq	%rbp, %r10
	subq	(%r15), %r10
	movq	%rdx, %r11
	sbbq	8(%r15), %r11
	movq	%r12, %rbx
	sbbq	16(%r15), %rbx
	sbbq	24(%r15), %r14
	movq	-32(%rsp), %r13         ## 8-byte Reload
	sbbq	32(%r15), %r13
	movq	-24(%rsp), %rsi         ## 8-byte Reload
	sbbq	40(%r15), %rsi
	movq	-16(%rsp), %rax         ## 8-byte Reload
	sbbq	48(%r15), %rax
	sbbq	56(%r15), %rcx
	movq	-48(%rsp), %r8          ## 8-byte Reload
	sbbq	64(%r15), %r8
	sbbq	$0, %r9
	andl	$1, %r9d
	cmovneq	%rbp, %r10
	movq	%r10, 72(%rdi)
	testb	%r9b, %r9b
	cmovneq	%rdx, %r11
	movq	%r11, 80(%rdi)
	cmovneq	%r12, %rbx
	movq	%rbx, 88(%rdi)
	cmovneq	-8(%rsp), %r14          ## 8-byte Folded Reload
	movq	%r14, 96(%rdi)
	cmovneq	-32(%rsp), %r13         ## 8-byte Folded Reload
	movq	%r13, 104(%rdi)
	cmovneq	-24(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, 112(%rdi)
	cmovneq	-16(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 120(%rdi)
	cmovneq	-40(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, 128(%rdi)
	cmovneq	-48(%rsp), %r8          ## 8-byte Folded Reload
	movq	%r8, 136(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq

	.globl	_mcl_fpDbl_sub9L
	.p2align	4, 0x90
_mcl_fpDbl_sub9L:                       ## @mcl_fpDbl_sub9L
## BB#0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r14
	movq	136(%rdx), %rax
	movq	%rax, -24(%rsp)         ## 8-byte Spill
	movq	128(%rdx), %rax
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	movq	120(%rdx), %rax
	movq	%rax, -40(%rsp)         ## 8-byte Spill
	movq	16(%rsi), %r11
	movq	(%rsi), %r12
	movq	8(%rsi), %r13
	xorl	%r9d, %r9d
	subq	(%rdx), %r12
	sbbq	8(%rdx), %r13
	sbbq	16(%rdx), %r11
	movq	24(%rsi), %rbx
	sbbq	24(%rdx), %rbx
	movq	32(%rsi), %rbp
	sbbq	32(%rdx), %rbp
	movq	112(%rdx), %r10
	movq	104(%rdx), %rcx
	movq	%r12, (%rdi)
	movq	96(%rdx), %rax
	movq	%r13, 8(%rdi)
	movq	88(%rdx), %r13
	movq	%r11, 16(%rdi)
	movq	40(%rdx), %r11
	movq	%rbx, 24(%rdi)
	movq	40(%rsi), %rbx
	sbbq	%r11, %rbx
	movq	48(%rdx), %r11
	movq	%rbp, 32(%rdi)
	movq	48(%rsi), %rbp
	sbbq	%r11, %rbp
	movq	56(%rdx), %r11
	movq	%rbx, 40(%rdi)
	movq	56(%rsi), %rbx
	sbbq	%r11, %rbx
	movq	64(%rdx), %r11
	movq	%rbp, 48(%rdi)
	movq	64(%rsi), %rbp
	sbbq	%r11, %rbp
	movq	80(%rdx), %r8
	movq	72(%rdx), %r11
	movq	%rbx, 56(%rdi)
	movq	72(%rsi), %r15
	sbbq	%r11, %r15
	movq	136(%rsi), %rdx
	movq	%rbp, 64(%rdi)
	movq	80(%rsi), %rbp
	sbbq	%r8, %rbp
	movq	88(%rsi), %r12
	sbbq	%r13, %r12
	movq	96(%rsi), %r13
	sbbq	%rax, %r13
	movq	104(%rsi), %rax
	sbbq	%rcx, %rax
	movq	%rax, -16(%rsp)         ## 8-byte Spill
	movq	112(%rsi), %rax
	sbbq	%r10, %rax
	movq	%rax, -8(%rsp)          ## 8-byte Spill
	movq	128(%rsi), %rax
	movq	120(%rsi), %rcx
	sbbq	-40(%rsp), %rcx         ## 8-byte Folded Reload
	movq	%rcx, -40(%rsp)         ## 8-byte Spill
	sbbq	-32(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, -32(%rsp)         ## 8-byte Spill
	sbbq	-24(%rsp), %rdx         ## 8-byte Folded Reload
	movq	%rdx, -24(%rsp)         ## 8-byte Spill
	movl	$0, %r8d
	sbbq	$0, %r8
	andl	$1, %r8d
	movq	(%r14), %r10
	cmoveq	%r9, %r10
	testb	%r8b, %r8b
	movq	16(%r14), %r8
	cmoveq	%r9, %r8
	movq	8(%r14), %rdx
	cmoveq	%r9, %rdx
	movq	64(%r14), %rbx
	cmoveq	%r9, %rbx
	movq	56(%r14), %r11
	cmoveq	%r9, %r11
	movq	48(%r14), %rsi
	cmoveq	%r9, %rsi
	movq	40(%r14), %rcx
	cmoveq	%r9, %rcx
	movq	32(%r14), %rax
	cmoveq	%r9, %rax
	cmovneq	24(%r14), %r9
	addq	%r15, %r10
	adcq	%rbp, %rdx
	movq	%r10, 72(%rdi)
	adcq	%r12, %r8
	movq	%rdx, 80(%rdi)
	adcq	%r13, %r9
	movq	%r8, 88(%rdi)
	movq	%r9, 96(%rdi)
	adcq	-16(%rsp), %rax         ## 8-byte Folded Reload
	movq	%rax, 104(%rdi)
	adcq	-8(%rsp), %rcx          ## 8-byte Folded Reload
	movq	%rcx, 112(%rdi)
	adcq	-40(%rsp), %rsi         ## 8-byte Folded Reload
	movq	%rsi, 120(%rdi)
	adcq	-32(%rsp), %r11         ## 8-byte Folded Reload
	movq	%r11, 128(%rdi)
	adcq	-24(%rsp), %rbx         ## 8-byte Folded Reload
	movq	%rbx, 136(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq


.subsections_via_symbols
