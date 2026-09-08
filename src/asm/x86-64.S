	.file	"base64.ll"
	.text
	.globl	makeNIST_P192L                  # -- Begin function makeNIST_P192L
	.p2align	4
	.type	makeNIST_P192L,@function
makeNIST_P192L:                         # @makeNIST_P192L
# %bb.0:
	movq	$-1, %rax
	movq	$-2, %rdx
	movq	$-1, %rcx
	retq
.Lfunc_end0:
	.size	makeNIST_P192L, .Lfunc_end0-makeNIST_P192L
                                        # -- End function
	.globl	mcl_fpDbl_mod_NIST_P192L        # -- Begin function mcl_fpDbl_mod_NIST_P192L
	.p2align	4
	.type	mcl_fpDbl_mod_NIST_P192L,@function
mcl_fpDbl_mod_NIST_P192L:               # @mcl_fpDbl_mod_NIST_P192L
# %bb.0:
	pushq	%rbx
	movq	40(%rsi), %r8
	movq	24(%rsi), %r9
	movq	32(%rsi), %r10
	movq	(%rsi), %r11
	addq	%r9, %r11
	movq	8(%rsi), %rax
	adcq	%r10, %rax
	movq	16(%rsi), %rcx
	adcq	%r8, %rcx
	setb	%dl
	movzbl	%dl, %esi
	movq	%r8, %rbx
	shlq	$63, %rbx
	movq	%r8, %rdx
	shrq	%rdx
	shldq	$1, %rbx, %rdx
	addq	%r11, %rdx
	adcq	%r9, %rax
	adcq	%r10, %rcx
	adcq	$0, %rsi
	addq	%r8, %rax
	adcq	$0, %rcx
	setb	%r8b
	adcq	%rsi, %rdx
	adcq	$0, %rax
	adcq	$0, %rcx
	setb	%r9b
	movzbl	%r9b, %r9d
	addb	$255, %r8b
	adcq	%rsi, %rax
	adcq	$0, %rcx
	adcq	$0, %r9
	movq	%rdx, %rsi
	addq	$1, %rsi
	movq	%rax, %r8
	adcq	$1, %r8
	movq	%rcx, %r10
	adcq	$0, %r10
	adcq	$-1, %r9
	testb	$1, %r9b
	cmovneq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%rax, %r8
	movq	%r8, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end1:
	.size	mcl_fpDbl_mod_NIST_P192L, .Lfunc_end1-mcl_fpDbl_mod_NIST_P192L
                                        # -- End function
	.globl	mcl_fp_sqr_NIST_P192L           # -- Begin function mcl_fp_sqr_NIST_P192L
	.p2align	4
	.type	mcl_fp_sqr_NIST_P192L,@function
mcl_fp_sqr_NIST_P192L:                  # @mcl_fp_sqr_NIST_P192L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	16(%rsi), %r11
	movq	(%rsi), %r12
	movq	8(%rsi), %r13
	movq	%r11, %rax
	mulq	%r12
	movq	%rdx, %rcx
	movq	%rax, %r10
	movq	%r11, %rax
	mulq	%r13
	movq	%rdx, %rbx
	movq	%rax, %r14
	movq	%r13, %rax
	mulq	%r13
	movq	%rdx, %r15
	movq	%rax, %rsi
	movq	%r12, %rax
	mulq	%r12
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%r13, %rax
	mulq	%r12
	addq	%rax, %r8
	adcq	%rdx, %rsi
	movq	%r14, %r12
	adcq	%rcx, %r12
	setb	%bpl
	movzbl	%bpl, %r13d
	addq	%rax, %r8
	adcq	%r10, %rsi
	adcq	$0, %r12
	adcq	$0, %r13
	addq	%rdx, %rsi
	adcq	%r15, %r12
	adcq	%rbx, %r13
	movq	%r11, %rax
	mulq	%r11
	addq	%r14, %rcx
	adcq	%rbx, %rax
	adcq	$0, %rdx
	addq	%r10, %rsi
	adcq	%r12, %rcx
	adcq	%r13, %rax
	adcq	$0, %rdx
	movq	%rcx, %r15
	addq	%r9, %r15
	movq	%rax, %r11
	adcq	%r8, %r11
	movq	%rdx, %r10
	adcq	%rsi, %r10
	setb	%bl
	movzbl	%bl, %r14d
	movq	%rdx, %r12
	shlq	$63, %r12
	movq	%rdx, %rbx
	shrq	%rbx
	shldq	$1, %r12, %rbx
	addq	%r15, %rbx
	adcq	%rcx, %r11
	adcq	%rax, %r10
	adcq	$0, %r14
	addq	%rdx, %r11
	adcq	$0, %r10
	setb	%bpl
	adcq	%r14, %rbx
	adcq	$0, %r11
	adcq	$0, %r10
	setb	%r15b
	movq	%r9, -48(%rsp)
	movq	%r8, -40(%rsp)
	movq	%rsi, -32(%rsp)
	movq	%rcx, -24(%rsp)
	movq	%rax, -16(%rsp)
	movq	%rdx, -8(%rsp)
	movzbl	%r15b, %eax
	addb	$255, %bpl
	adcq	%r14, %r11
	adcq	$0, %r10
	adcq	$0, %rax
	movq	%rbx, %rcx
	addq	$1, %rcx
	movq	%r11, %rdx
	adcq	$1, %rdx
	movq	%r10, %rsi
	adcq	$0, %rsi
	adcq	$-1, %rax
	testb	$1, %al
	cmovneq	%r11, %rdx
	movq	%rdx, 8(%rdi)
	cmovneq	%rbx, %rcx
	movq	%rcx, (%rdi)
	cmovneq	%r10, %rsi
	movq	%rsi, 16(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end2:
	.size	mcl_fp_sqr_NIST_P192L, .Lfunc_end2-mcl_fp_sqr_NIST_P192L
                                        # -- End function
	.globl	mcl_fp_mulNIST_P192L            # -- Begin function mcl_fp_mulNIST_P192L
	.p2align	4
	.type	mcl_fp_mulNIST_P192L,@function
mcl_fp_mulNIST_P192L:                   # @mcl_fp_mulNIST_P192L
# %bb.0:
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, %rbx
	movq	%rsp, %rdi
	callq	mcl_fpDbl_mulPre3L@PLT
	movq	40(%rsp), %rdi
	movq	24(%rsp), %r8
	movq	32(%rsp), %r9
	movq	(%rsp), %r10
	addq	%r8, %r10
	movq	8(%rsp), %rax
	adcq	%r9, %rax
	movq	16(%rsp), %rcx
	adcq	%rdi, %rcx
	setb	%dl
	movzbl	%dl, %esi
	movq	%rdi, %r11
	shlq	$63, %r11
	movq	%rdi, %rdx
	shrq	%rdx
	shldq	$1, %r11, %rdx
	addq	%r10, %rdx
	adcq	%r8, %rax
	adcq	%r9, %rcx
	adcq	$0, %rsi
	addq	%rdi, %rax
	adcq	$0, %rcx
	setb	%dil
	adcq	%rsi, %rdx
	adcq	$0, %rax
	adcq	$0, %rcx
	setb	%r8b
	movzbl	%r8b, %r8d
	addb	$255, %dil
	adcq	%rsi, %rax
	adcq	$0, %rcx
	adcq	$0, %r8
	movq	%rdx, %rsi
	addq	$1, %rsi
	movq	%rax, %rdi
	adcq	$1, %rdi
	movq	%rcx, %r9
	adcq	$0, %r9
	adcq	$-1, %r8
	testb	$1, %r8b
	cmovneq	%rcx, %r9
	movq	%r9, 16(%rbx)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rbx)
	cmovneq	%rax, %rdi
	movq	%rdi, 8(%rbx)
	addq	$48, %rsp
	popq	%rbx
	retq
.Lfunc_end3:
	.size	mcl_fp_mulNIST_P192L, .Lfunc_end3-mcl_fp_mulNIST_P192L
                                        # -- End function
	.globl	mcl_fpDbl_mod_NIST_P521L        # -- Begin function mcl_fpDbl_mod_NIST_P521L
	.p2align	4
	.type	mcl_fpDbl_mod_NIST_P521L,@function
mcl_fpDbl_mod_NIST_P521L:               # @mcl_fpDbl_mod_NIST_P521L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	120(%rsi), %rax
	movq	128(%rsi), %r14
	movq	%r14, %rcx
	shldq	$55, %rax, %rcx
	movq	112(%rsi), %rdx
	shldq	$55, %rdx, %rax
	movq	104(%rsi), %r8
	shldq	$55, %r8, %rdx
	movq	96(%rsi), %r9
	shldq	$55, %r9, %r8
	movq	88(%rsi), %r10
	shldq	$55, %r10, %r9
	movq	80(%rsi), %r11
	shldq	$55, %r11, %r10
	movq	64(%rsi), %rbx
	movq	72(%rsi), %r15
	shldq	$55, %r15, %r11
	shrq	$9, %r14
	shldq	$55, %rbx, %r15
                                        # kill: def $ebx killed $ebx killed $rbx def $rbx
	andl	$511, %ebx                      # imm = 0x1FF
	addq	(%rsi), %r15
	adcq	8(%rsi), %r11
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %r8
	adcq	40(%rsi), %rdx
	adcq	48(%rsi), %rax
	adcq	56(%rsi), %rcx
	adcq	%r14, %rbx
	movl	%ebx, %esi
	shrl	$9, %esi
	andl	$1, %esi
	addq	%r15, %rsi
	adcq	$0, %r11
	adcq	$0, %r10
	adcq	$0, %r9
	adcq	$0, %r8
	adcq	$0, %rdx
	adcq	$0, %rax
	adcq	$0, %rcx
	adcq	$0, %rbx
	movq	%r11, %r14
	andq	%r9, %r14
	movq	%r10, %r15
	andq	%r8, %r15
	andq	%r14, %r15
	andq	%rdx, %r15
	movq	%rax, %r14
	andq	%rcx, %r14
	andq	%rsi, %r15
	andq	%r14, %r15
	movq	%rbx, %r14
	orq	$-512, %r14                     # imm = 0xFE00
	andq	%r15, %r14
	cmpq	$-1, %r14
	je	.LBB4_1
# %bb.3:                                # %nonzero
	movq	%rsi, (%rdi)
	movq	%r11, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r9, 24(%rdi)
	movq	%r8, 32(%rdi)
	movq	%rdx, 40(%rdi)
	movq	%rax, 48(%rdi)
	movq	%rcx, 56(%rdi)
	andl	$511, %ebx                      # imm = 0x1FF
	movq	%rbx, 64(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB4_1:                                # %zero
	movq	$0, 64(%rdi)
	movq	$0, 56(%rdi)
	movq	$0, 48(%rdi)
	movq	$0, 40(%rdi)
	movq	$0, 32(%rdi)
	movq	$0, 24(%rdi)
	movq	$0, 16(%rdi)
	movq	$0, 8(%rdi)
	movq	$0, (%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end4:
	.size	mcl_fpDbl_mod_NIST_P521L, .Lfunc_end4-mcl_fpDbl_mod_NIST_P521L
                                        # -- End function
	.globl	mulPv192x64                     # -- Begin function mulPv192x64
	.p2align	4
	.type	mulPv192x64,@function
mulPv192x64:                            # @mulPv192x64
# %bb.0:
	movq	%rdx, %rcx
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rdx, %r8
	movq	%rax, (%rdi)
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	8(%rsi)
	addq	%r8, %rax
	movq	%rax, 8(%rdi)
	adcq	%r10, %rdx
	movq	%rdx, 16(%rdi)
	adcq	$0, %r9
	movq	%r9, 24(%rdi)
	movq	%rdi, %rax
	retq
.Lfunc_end5:
	.size	mulPv192x64, .Lfunc_end5-mulPv192x64
                                        # -- End function
	.globl	mcl_fpDbl_mulPre3L              # -- Begin function mcl_fpDbl_mulPre3L
	.p2align	4
	.type	mcl_fpDbl_mulPre3L,@function
mcl_fpDbl_mulPre3L:                     # @mcl_fpDbl_mulPre3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r8
	movq	(%rsi), %rcx
	movq	8(%rsi), %rbx
	movq	(%rdx), %r11
	movq	%rcx, %rax
	mulq	%r11
	movq	%rdx, %r12
	movq	16(%rsi), %r10
	movq	%rax, (%rdi)
	movq	8(%r8), %r9
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	%rax, %r15
	movq	%r9, %rax
	mulq	%rbx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%rax, %rbp
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%r10, %rax
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%r11
	movq	%rdx, %r11
	addq	%r12, %rax
	adcq	%r14, %r11
	adcq	$0, %r9
	setb	%dl
	addq	%rsi, %rax
	movq	%rax, 8(%rdi)
	adcq	%rbp, %r11
	adcq	%r15, %r9
	movzbl	%dl, %r15d
	adcq	$0, %r15
	addq	%r13, %r11
	adcq	-16(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-8(%rsp), %r15                  # 8-byte Folded Reload
	movq	16(%r8), %rsi
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, %r8
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	%rbx
	movq	%rdx, %rbx
	movq	%rax, %r14
	movq	%rsi, %rax
	mulq	%rcx
	addq	%r14, %rdx
	adcq	%r10, %rbx
	adcq	$0, %r8
	addq	%r11, %rax
	movq	%rax, 16(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	adcq	%r15, %rbx
	movq	%rbx, 32(%rdi)
	adcq	$0, %r8
	movq	%r8, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end6:
	.size	mcl_fpDbl_mulPre3L, .Lfunc_end6-mcl_fpDbl_mulPre3L
                                        # -- End function
	.globl	mcl_fpDbl_sqrPre3L              # -- Begin function mcl_fpDbl_sqrPre3L
	.p2align	4
	.type	mcl_fpDbl_sqrPre3L,@function
mcl_fpDbl_sqrPre3L:                     # @mcl_fpDbl_sqrPre3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	16(%rsi), %r15
	movq	(%rsi), %r12
	movq	8(%rsi), %rsi
	movq	%r12, %rax
	mulq	%r12
	movq	%rdx, %rbx
	movq	%rax, (%rdi)
	movq	%r15, %rax
	mulq	%r12
	movq	%rdx, %rcx
	movq	%rax, %r8
	movq	%r15, %rax
	mulq	%rsi
	movq	%rdx, %r9
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	%r12
	addq	%rax, %rbx
	adcq	%rdx, %r10
	movq	%r11, %rsi
	adcq	%rcx, %rsi
	setb	%bpl
	addq	%rax, %rbx
	movq	%rbx, 8(%rdi)
	movzbl	%bpl, %ebx
	adcq	%r8, %r10
	adcq	$0, %rsi
	adcq	$0, %rbx
	addq	%rdx, %r10
	adcq	%r14, %rsi
	adcq	%r9, %rbx
	movq	%r15, %rax
	mulq	%r15
	addq	%r11, %rcx
	adcq	%r9, %rax
	adcq	$0, %rdx
	addq	%r8, %r10
	movq	%r10, 16(%rdi)
	adcq	%rsi, %rcx
	movq	%rcx, 24(%rdi)
	adcq	%rbx, %rax
	movq	%rax, 32(%rdi)
	adcq	$0, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end7:
	.size	mcl_fpDbl_sqrPre3L, .Lfunc_end7-mcl_fpDbl_sqrPre3L
                                        # -- End function
	.globl	mcl_fp_mont3L                   # -- Begin function mcl_fp_mont3L
	.p2align	4
	.type	mcl_fp_mont3L,@function
mcl_fp_mont3L:                          # @mcl_fp_mont3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdi
	movq	16(%rsi), %r11
	movq	%rdi, %rax
	mulq	%r11
	movq	%rax, %r8
	movq	%rdx, %r14
	movq	(%rsi), %r9
	movq	%r9, -40(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rdx, %r15
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	%rdi
	movq	%rax, %r13
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%r8, %r15
	adcq	$0, %r14
	movq	-8(%rcx), %r8
	movq	%r8, %rsi
	imulq	%rax, %rsi
	movq	16(%rcx), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rdx
	movq	%rax, %rbx
	movq	%rdx, %r12
	movq	(%rcx), %r10
	movq	%r10, -48(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, %rcx
	addq	%rbp, %rcx
	adcq	%rbx, %r9
	adcq	$0, %r12
	addq	%r13, %rax
	adcq	%rdi, %rcx
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rsi
	adcq	%r15, %r9
	adcq	%r14, %r12
	setb	%r10b
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %rdi
	movq	-64(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %r13
	addq	%rbx, %r13
	adcq	%rdi, %r15
	adcq	$0, %r14
	addq	%rcx, %rbp
	adcq	%r9, %r13
	movzbl	%r10b, %eax
	adcq	%r12, %r15
	adcq	%rax, %r14
	setb	-65(%rsp)                       # 1-byte Folded Spill
	movq	%r8, %rsi
	imulq	%rbp, %rsi
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r12
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rcx
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rax, %rdi
	movq	%rdx, %r9
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%r11, %rax
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	-64(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdx, %r11
	addq	%rbx, %rdi
	adcq	-16(%rsp), %r9                  # 8-byte Folded Reload
	adcq	$0, %r12
	addq	%rbp, %rcx
	adcq	%r13, %rdi
	adcq	%r15, %r9
	adcq	%r14, %r12
	movzbl	-65(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	$0, %rcx
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r14
	movq	%rdx, %rbx
	addq	-64(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	-56(%rsp), %r11                 # 8-byte Folded Reload
	adcq	$0, %r10
	addq	%rdi, %r14
	adcq	%r9, %rbx
	adcq	%r12, %r11
	adcq	%rcx, %r10
	setb	%bpl
	imulq	%r14, %r8
	movq	-24(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rax
	mulq	%r8
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	-32(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%r8
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%r8, %rax
	movq	-48(%rsp), %r8                  # 8-byte Reload
	mulq	%r8
	addq	%r9, %rdx
	adcq	%rsi, %rdi
	adcq	$0, %rcx
	addq	%r14, %rax
	adcq	%rbx, %rdx
	adcq	%r11, %rdi
	movzbl	%bpl, %eax
	adcq	%r10, %rcx
	adcq	$0, %rax
	movq	%rdx, %rsi
	subq	%r8, %rsi
	movq	%rdi, %r8
	sbbq	%r12, %r8
	movq	%rcx, %r9
	sbbq	%r15, %r9
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rdi, %r8
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%r8, 8(%rax)
	cmovneq	%rcx, %r9
	movq	%r9, 16(%rax)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end8:
	.size	mcl_fp_mont3L, .Lfunc_end8-mcl_fp_mont3L
                                        # -- End function
	.globl	mcl_fp_montNF3L                 # -- Begin function mcl_fp_montNF3L
	.p2align	4
	.type	mcl_fp_montNF3L,@function
mcl_fp_montNF3L:                        # @mcl_fp_montNF3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r12
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %r14
	movq	(%rdx), %r10
	movq	%r14, %rax
	mulq	%r10
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rdx, %r13
	movq	(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r9
	mulq	%r10
	movq	%rax, %rdi
	movq	%rdx, %rbx
	movq	-8(%rcx), %r8
	movq	%r8, -16(%rsp)                  # 8-byte Spill
	imulq	%rax, %r8
	movq	16(%rcx), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%r8
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%r9, %rax
	movq	%r9, -40(%rsp)                  # 8-byte Spill
	mulq	%r10
	movq	%rax, %r10
	movq	%rdx, %r11
	movq	(%rcx), %rcx
	movq	%rcx, -64(%rsp)                 # 8-byte Spill
	movq	8(%r12), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%r8
	movq	%rdx, %rsi
	movq	%rax, %r12
	movq	%r8, %rax
	mulq	%rcx
	addq	%rbx, %rdx
	adcq	%r11, %rsi
	adcq	%r13, %rbp
	addq	%rdi, %rax
	adcq	%r10, %r12
	adcq	-48(%rsp), %r15                 # 8-byte Folded Reload
	setb	%al
	addq	%rdx, %r12
	movq	-32(%rsp), %r11                 # 8-byte Reload
	movq	8(%r11), %rdi
	movzbl	%al, %r10d
	adcq	%rsi, %r15
	adcq	%rbp, %r10
	movq	%rdi, %rax
	mulq	%r14
	movq	%r14, %rbx
	movq	%rdx, %r14
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %r13
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rdi
	movq	%rdx, %rcx
	addq	%r9, %rcx
	adcq	%r8, %r13
	adcq	$0, %r14
	addq	%r12, %rdi
	adcq	%r15, %rcx
	adcq	%r10, %r13
	adcq	$0, %r14
	movq	-16(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %r8
	imulq	%rdi, %r8
	movq	%r8, %rax
	movq	-24(%rsp), %rbp                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%r8, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%r8, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%rcx, %r12
	adcq	%r13, %r15
	adcq	$0, %r14
	addq	%rdx, %r12
	adcq	%r10, %r15
	adcq	%r9, %r14
	movq	16(%r11), %rcx
	movq	%rcx, %rax
	mulq	%rbx
	movq	%rdx, %r10
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rdi
	addq	%rbx, %rdi
	adcq	%r8, %r11
	adcq	$0, %r10
	addq	%r12, %r9
	adcq	%r15, %rdi
	adcq	%r14, %r11
	adcq	$0, %r10
	imulq	%r9, %rsi
	movq	%rsi, %rax
	mulq	%rbp
	movq	%rdx, %r8
	movq	%rax, %rcx
	movq	%rsi, %rax
	movq	-56(%rsp), %r12                 # 8-byte Reload
	mulq	%r12
	movq	%rdx, %r14
	movq	%rax, %rbx
	movq	%rsi, %rax
	movq	-64(%rsp), %rsi                 # 8-byte Reload
	mulq	%rsi
	addq	%r9, %rax
	adcq	%rdi, %rbx
	adcq	%r11, %rcx
	adcq	$0, %r10
	addq	%rdx, %rbx
	adcq	%r14, %rcx
	adcq	%r8, %r10
	movq	%rbx, %rax
	subq	%rsi, %rax
	movq	%rcx, %rdx
	sbbq	%r12, %rdx
	movq	%r10, %rsi
	sbbq	%rbp, %rsi
	movq	%rsi, %rdi
	sarq	$63, %rdi
	cmovsq	%r10, %rsi
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rsi, 16(%rdi)
	cmovsq	%rbx, %rax
	movq	%rax, (%rdi)
	cmovsq	%rcx, %rdx
	movq	%rdx, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end9:
	.size	mcl_fp_montNF3L, .Lfunc_end9-mcl_fp_montNF3L
                                        # -- End function
	.globl	mcl_fp_montRed3L                # -- Begin function mcl_fp_montRed3L
	.p2align	4
	.type	mcl_fp_montRed3L,@function
mcl_fp_montRed3L:                       # @mcl_fp_montRed3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rcx
	movq	-8(%rdx), %r10
	movq	(%rdx), %r8
	movq	%r10, %rdi
	imulq	%rcx, %rdi
	movq	16(%rdx), %rax
	movq	%rax, %r13
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r11
	movq	8(%r9), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %rbx
	movq	%rax, %r15
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r12
	addq	%r15, %r12
	adcq	%r14, %rbx
	adcq	$0, %r11
	addq	%rcx, %rax
	adcq	8(%rsi), %r12
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r11
	setb	%r9b
	movq	%r10, %r14
	imulq	%r12, %r14
	movq	%r14, %rax
	mulq	%r13
	movq	%rdx, %rdi
	movq	%rax, %rbp
	movq	%r8, %rax
	mulq	%r14
	movq	%rdx, %rcx
	movq	%rax, %r13
	movq	-16(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %r15
	addq	%rcx, %r15
	adcq	%rbp, %r14
	movzbl	%r9b, %ebp
	adcq	%rdi, %rbp
	addq	%r12, %r13
	adcq	%rbx, %r15
	adcq	%r11, %r14
	adcq	32(%rsi), %rbp
	setb	%r9b
	imulq	%r15, %r10
	movq	%r10, %rax
	movq	-24(%rsp), %r13                 # 8-byte Reload
	mulq	%r13
	movq	%rdx, %r11
	movq	%rax, %rcx
	movq	-32(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %rbx
	movq	%r8, %rax
	mulq	%r10
	addq	%rdi, %rax
	adcq	%rcx, %rdx
	movzbl	%r9b, %ecx
	adcq	%rcx, %r11
	addq	%r15, %rbx
	adcq	%r14, %rax
	adcq	%rbp, %rdx
	adcq	40(%rsi), %r11
	setb	%cl
	movq	%rax, %rsi
	subq	%r12, %rsi
	movq	%rdx, %rdi
	sbbq	%r8, %rdi
	movq	%r11, %r8
	sbbq	%r13, %r8
	movzbl	%cl, %ecx
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%r11, %r8
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%r8, 16(%rcx)
	cmovneq	%rax, %rsi
	movq	%rsi, (%rcx)
	cmovneq	%rdx, %rdi
	movq	%rdi, 8(%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end10:
	.size	mcl_fp_montRed3L, .Lfunc_end10-mcl_fp_montRed3L
                                        # -- End function
	.globl	mcl_fp_montRedNF3L              # -- Begin function mcl_fp_montRedNF3L
	.p2align	4
	.type	mcl_fp_montRedNF3L,@function
mcl_fp_montRedNF3L:                     # @mcl_fp_montRedNF3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rcx
	movq	-8(%rdx), %r10
	movq	(%rdx), %r8
	movq	%r10, %rdi
	imulq	%rcx, %rdi
	movq	16(%rdx), %rax
	movq	%rax, %r13
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r11
	movq	8(%r9), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %rbx
	movq	%rax, %r15
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r12
	addq	%r15, %r12
	adcq	%r14, %rbx
	adcq	$0, %r11
	addq	%rcx, %rax
	adcq	8(%rsi), %r12
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r11
	setb	%r9b
	movq	%r10, %r14
	imulq	%r12, %r14
	movq	%r14, %rax
	mulq	%r13
	movq	%rdx, %rdi
	movq	%rax, %rbp
	movq	%r8, %rax
	mulq	%r14
	movq	%rdx, %rcx
	movq	%rax, %r13
	movq	-16(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %r15
	addq	%rcx, %r15
	adcq	%rbp, %r14
	movzbl	%r9b, %ebp
	adcq	%rdi, %rbp
	addq	%r12, %r13
	adcq	%rbx, %r15
	adcq	%r11, %r14
	adcq	32(%rsi), %rbp
	setb	%r9b
	imulq	%r15, %r10
	movq	%r10, %rax
	movq	-24(%rsp), %r12                 # 8-byte Reload
	mulq	%r12
	movq	%rdx, %r11
	movq	%rax, %rcx
	movq	-32(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	mulq	%r10
	movq	%rdx, %rdi
	movq	%rax, %rbx
	movq	%r8, %rax
	mulq	%r10
	addq	%rdi, %rax
	adcq	%rcx, %rdx
	movzbl	%r9b, %ecx
	adcq	%rcx, %r11
	addq	%r15, %rbx
	adcq	%r14, %rax
	adcq	%rbp, %rdx
	adcq	40(%rsi), %r11
	movq	%rax, %rcx
	subq	%r13, %rcx
	movq	%rdx, %rsi
	sbbq	%r8, %rsi
	movq	%r11, %rdi
	sbbq	%r12, %rdi
	movq	%rdi, %r8
	sarq	$63, %r8
	cmovsq	%r11, %rdi
	movq	-8(%rsp), %r8                   # 8-byte Reload
	movq	%rdi, 16(%r8)
	cmovsq	%rax, %rcx
	movq	%rcx, (%r8)
	cmovsq	%rdx, %rsi
	movq	%rsi, 8(%r8)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end11:
	.size	mcl_fp_montRedNF3L, .Lfunc_end11-mcl_fp_montRedNF3L
                                        # -- End function
	.globl	mcl_fp_addPre3L                 # -- Begin function mcl_fp_addPre3L
	.p2align	4
	.type	mcl_fp_addPre3L,@function
mcl_fp_addPre3L:                        # @mcl_fp_addPre3L
# %bb.0:
	movq	16(%rsi), %rax
	movq	(%rsi), %rcx
	movq	8(%rsi), %rsi
	movq	(%rdx), %r8
	addq	%rcx, %r8
	movq	8(%rdx), %r9
	adcq	%rsi, %r9
	movq	16(%rdx), %rdx
	adcq	%rax, %rdx
	movq	%rdx, 16(%rdi)
	movq	%r8, (%rdi)
	movq	%r9, 8(%rdi)
	xorl	%edi, %edi
	cmpq	%rcx, %r8
	sbbq	%rsi, %r9
	sbbq	%rax, %rdx
	sbbq	%rdi, %rdi
	setb	%al
	movzbl	%al, %eax
	retq
.Lfunc_end12:
	.size	mcl_fp_addPre3L, .Lfunc_end12-mcl_fp_addPre3L
                                        # -- End function
	.globl	mcl_fp_subPre3L                 # -- Begin function mcl_fp_subPre3L
	.p2align	4
	.type	mcl_fp_subPre3L,@function
mcl_fp_subPre3L:                        # @mcl_fp_subPre3L
# %bb.0:
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	movq	%rcx, 16(%rdi)
	movq	%r8, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq
.Lfunc_end13:
	.size	mcl_fp_subPre3L, .Lfunc_end13-mcl_fp_subPre3L
                                        # -- End function
	.globl	mcl_fp_shr1_3L                  # -- Begin function mcl_fp_shr1_3L
	.p2align	4
	.type	mcl_fp_shr1_3L,@function
mcl_fp_shr1_3L:                         # @mcl_fp_shr1_3L
# %bb.0:
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	%rdx, %rsi
	shrq	%rsi
	movq	%rsi, 16(%rdi)
	shrdq	$1, %rcx, %rax
	movq	%rax, (%rdi)
	shldq	$63, %rcx, %rdx
	movq	%rdx, 8(%rdi)
	retq
.Lfunc_end14:
	.size	mcl_fp_shr1_3L, .Lfunc_end14-mcl_fp_shr1_3L
                                        # -- End function
	.globl	mcl_fp_add3L                    # -- Begin function mcl_fp_add3L
	.p2align	4
	.type	mcl_fp_add3L,@function
mcl_fp_add3L:                           # @mcl_fp_add3L
# %bb.0:
	movq	16(%rdx), %rax
	movq	(%rdx), %r8
	movq	8(%rdx), %rdx
	addq	(%rsi), %r8
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	setb	%sil
	movzbl	%sil, %esi
	movq	%r8, %r9
	subq	(%rcx), %r9
	movq	%rdx, %r10
	sbbq	8(%rcx), %r10
	movq	%rax, %r11
	sbbq	16(%rcx), %r11
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%rax, %r11
	movq	%r11, 16(%rdi)
	cmovneq	%r8, %r9
	movq	%r9, (%rdi)
	cmovneq	%rdx, %r10
	movq	%r10, 8(%rdi)
	retq
.Lfunc_end15:
	.size	mcl_fp_add3L, .Lfunc_end15-mcl_fp_add3L
                                        # -- End function
	.globl	mcl_fp_addNF3L                  # -- Begin function mcl_fp_addNF3L
	.p2align	4
	.type	mcl_fp_addNF3L,@function
mcl_fp_addNF3L:                         # @mcl_fp_addNF3L
# %bb.0:
	movq	16(%rdx), %rax
	movq	(%rdx), %r8
	movq	8(%rdx), %rdx
	addq	(%rsi), %r8
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%rdx, %r9
	sbbq	8(%rcx), %r9
	movq	%rax, %r10
	sbbq	16(%rcx), %r10
	movq	%r10, %rcx
	sarq	$63, %rcx
	cmovsq	%rax, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%rdx, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end16:
	.size	mcl_fp_addNF3L, .Lfunc_end16-mcl_fp_addNF3L
                                        # -- End function
	.globl	mcl_fp_sub3L                    # -- Begin function mcl_fp_sub3L
	.p2align	4
	.type	mcl_fp_sub3L,@function
mcl_fp_sub3L:                           # @mcl_fp_sub3L
# %bb.0:
	xorl	%eax, %eax
	movq	16(%rsi), %r8
	movq	(%rsi), %r9
	movq	8(%rsi), %rsi
	subq	(%rdx), %r9
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r8
	sbbq	%rax, %rax
	movq	16(%rcx), %rdx
	andq	%rax, %rdx
	movq	8(%rcx), %r10
	andq	%rax, %r10
	andq	(%rcx), %rax
	addq	%r9, %rax
	movq	%rax, (%rdi)
	adcq	%rsi, %r10
	movq	%r10, 8(%rdi)
	adcq	%r8, %rdx
	movq	%rdx, 16(%rdi)
	retq
.Lfunc_end17:
	.size	mcl_fp_sub3L, .Lfunc_end17-mcl_fp_sub3L
                                        # -- End function
	.globl	mcl_fp_subNF3L                  # -- Begin function mcl_fp_subNF3L
	.p2align	4
	.type	mcl_fp_subNF3L,@function
mcl_fp_subNF3L:                         # @mcl_fp_subNF3L
# %bb.0:
	movq	16(%rsi), %rax
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	movq	%rdx, %r9
	shldq	$1, %rax, %r9
	andq	(%rcx), %r9
	movq	16(%rcx), %r10
	andq	%rdx, %r10
	andq	8(%rcx), %rdx
	addq	%r8, %r9
	movq	%r9, (%rdi)
	adcq	%rsi, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%rax, %r10
	movq	%r10, 16(%rdi)
	retq
.Lfunc_end18:
	.size	mcl_fp_subNF3L, .Lfunc_end18-mcl_fp_subNF3L
                                        # -- End function
	.globl	mcl_fpDbl_add3L                 # -- Begin function mcl_fpDbl_add3L
	.p2align	4
	.type	mcl_fpDbl_add3L,@function
mcl_fpDbl_add3L:                        # @mcl_fpDbl_add3L
# %bb.0:
	movq	40(%rdx), %r9
	movq	32(%rdx), %rax
	movq	24(%rdx), %r8
	movq	16(%rdx), %r10
	movq	(%rdx), %r11
	movq	8(%rdx), %rdx
	addq	(%rsi), %r11
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %rax
	adcq	40(%rsi), %r9
	movq	%r11, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	setb	%dl
	movzbl	%dl, %edx
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%rax, %r10
	sbbq	8(%rcx), %r10
	movq	%r9, %r11
	sbbq	16(%rcx), %r11
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, 24(%rdi)
	cmovneq	%rax, %r10
	movq	%r10, 32(%rdi)
	retq
.Lfunc_end19:
	.size	mcl_fpDbl_add3L, .Lfunc_end19-mcl_fpDbl_add3L
                                        # -- End function
	.globl	mcl_fpDbl_sub3L                 # -- Begin function mcl_fpDbl_sub3L
	.p2align	4
	.type	mcl_fpDbl_sub3L,@function
mcl_fpDbl_sub3L:                        # @mcl_fpDbl_sub3L
# %bb.0:
	pushq	%rbx
	movq	40(%rsi), %rax
	movq	32(%rsi), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	xorl	%ebx, %ebx
	subq	(%rdx), %r11
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %rax
	movq	%r11, (%rdi)
	movq	%rsi, 8(%rdi)
	movq	%r10, 16(%rdi)
	sbbq	%rbx, %rbx
	movq	16(%rcx), %rdx
	andq	%rbx, %rdx
	movq	8(%rcx), %rsi
	andq	%rbx, %rsi
	andq	(%rcx), %rbx
	addq	%r9, %rbx
	movq	%rbx, 24(%rdi)
	adcq	%r8, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	retq
.Lfunc_end20:
	.size	mcl_fpDbl_sub3L, .Lfunc_end20-mcl_fpDbl_sub3L
                                        # -- End function
	.globl	mulPv256x64                     # -- Begin function mulPv256x64
	.p2align	4
	.type	mulPv256x64,@function
mulPv256x64:                            # @mulPv256x64
# %bb.0:
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rdx, %r8
	movq	%rax, (%rdi)
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r11
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	8(%rsi)
	addq	%r8, %rax
	movq	%rax, 8(%rdi)
	adcq	%rbx, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r10, %r11
	movq	%r11, 24(%rdi)
	adcq	$0, %r9
	movq	%r9, 32(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	retq
.Lfunc_end21:
	.size	mulPv256x64, .Lfunc_end21-mulPv256x64
                                        # -- End function
	.globl	mcl_fp_mont4L                   # -- Begin function mcl_fp_mont4L
	.p2align	4
	.type	mcl_fp_mont4L,@function
mcl_fp_mont4L:                          # @mcl_fp_mont4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rbx
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %r13
	movq	16(%rsi), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r9
	movq	%rdx, %r11
	movq	(%rsi), %r14
	movq	%r14, -56(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%r14, %rax
	mulq	%rbx
	movq	%rax, %rsi
	movq	%rdx, %r15
	addq	%r10, %r15
	adcq	%r9, %rdi
	adcq	%r8, %r11
	adcq	$0, %r13
	movq	-8(%rcx), %r10
	movq	%r10, -80(%rsp)                 # 8-byte Spill
	imulq	%rax, %r10
	movq	24(%rcx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%r10
	movq	%rax, %r8
	movq	%rdx, %rbp
	movq	16(%rcx), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%r10
	movq	%rax, %r9
	movq	%rdx, %rbx
	movq	(%rcx), %r12
	movq	%r12, -48(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%r10
	movq	%rdx, %r14
	movq	%rax, %rcx
	movq	%r12, %rax
	mulq	%r10
	movq	%rdx, %r12
	addq	%rcx, %r12
	adcq	%r9, %r14
	adcq	%r8, %rbx
	adcq	$0, %rbp
	addq	%rsi, %rax
	adcq	%r15, %r12
	adcq	%rdi, %r14
	adcq	%r11, %rbx
	adcq	%r13, %rbp
	setb	%r10b
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rcx
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r15
	movq	%rdx, %rcx
	addq	%r9, %rcx
	adcq	%r8, %rdi
	adcq	%rsi, %r11
	adcq	$0, %r13
	addq	%r12, %r15
	adcq	%r14, %rcx
	adcq	%rbx, %rdi
	adcq	%rbp, %r11
	movzbl	%r10b, %eax
	adcq	%rax, %r13
	setb	-89(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%r15, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r12
	addq	%r10, %r12
	adcq	%r9, %r14
	adcq	%r8, %rbx
	adcq	$0, %rbp
	addq	%r15, %rax
	adcq	%rcx, %r12
	adcq	%rdi, %r14
	adcq	%r11, %rbx
	adcq	%r13, %rbp
	movzbl	-89(%rsp), %r10d                # 1-byte Folded Reload
	adcq	$0, %r10
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r15
	movq	%rdx, %rcx
	addq	%r9, %rcx
	adcq	%r8, %rdi
	adcq	%rsi, %r11
	adcq	$0, %r13
	addq	%r12, %r15
	adcq	%r14, %rcx
	adcq	%rbx, %rdi
	adcq	%rbp, %r11
	adcq	%r10, %r13
	setb	-89(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%r15, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r12
	addq	%r10, %r12
	adcq	%r9, %r14
	adcq	%r8, %rbx
	adcq	$0, %rbp
	addq	%r15, %rax
	adcq	%rcx, %r12
	adcq	%rdi, %r14
	adcq	%r11, %rbx
	adcq	%r13, %rbp
	movzbl	-89(%rsp), %r8d                 # 1-byte Folded Reload
	adcq	$0, %r8
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rcx
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%rdx, %r13
	addq	%r10, %r13
	adcq	%r9, %r15
	adcq	-88(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	$0, %r11
	addq	%r12, %rsi
	adcq	%r14, %r13
	adcq	%rbx, %r15
	adcq	%rbp, %rdi
	adcq	%r8, %r11
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %r8                  # 8-byte Reload
	imulq	%rsi, %r8
	movq	%r8, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	movq	-24(%rsp), %rbp                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%r8, %rax
	movq	-40(%rsp), %r9                  # 8-byte Reload
	mulq	%r9
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	%r8, %rax
	movq	-48(%rsp), %r8                  # 8-byte Reload
	mulq	%r8
	addq	%r10, %rdx
	adcq	%r12, %r14
	adcq	-80(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	$0, %rcx
	addq	%rsi, %rax
	adcq	%r13, %rdx
	adcq	%r15, %r14
	adcq	%rdi, %rbx
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%r11, %rcx
	adcq	$0, %rax
	movq	%rdx, %rsi
	subq	%r8, %rsi
	movq	%r14, %rdi
	sbbq	%r9, %rdi
	movq	%rbx, %r8
	sbbq	%rbp, %r8
	movq	%rcx, %r9
	sbbq	-72(%rsp), %r9                  # 8-byte Folded Reload
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rbx, %r8
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%r8, 16(%rax)
	cmovneq	%r14, %rdi
	movq	%rdi, 8(%rax)
	cmovneq	%rcx, %r9
	movq	%r9, 24(%rax)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end22:
	.size	mcl_fp_mont4L, .Lfunc_end22-mcl_fp_mont4L
                                        # -- End function
	.globl	mcl_fp_montNF4L                 # -- Begin function mcl_fp_montNF4L
	.p2align	4
	.type	mcl_fp_montNF4L,@function
mcl_fp_montNF4L:                        # @mcl_fp_montNF4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r9
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	-8(%rcx), %r8
	movq	%r8, -112(%rsp)                 # 8-byte Spill
	imulq	%rax, %r8
	movq	24(%rcx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%r8
	movq	%rax, %rbp
	movq	%rdx, %rbx
	movq	8(%rsi), %r14
	movq	16(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulq	%rdi
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rdx, %r12
	movq	16(%rcx), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%r8
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%r14, %rax
	movq	%r14, -56(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r13
	movq	%rdx, %rdi
	movq	(%rcx), %rcx
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movq	8(%r9), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%r8
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	%r8
	addq	-40(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	%rdi, %rsi
	adcq	%r12, %r15
	adcq	-32(%rsp), %rbx                 # 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%r13, %r9
	adcq	-48(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-24(%rsp), %rbp                 # 8-byte Folded Reload
	setb	%al
	addq	%rdx, %r9
	adcq	%rsi, %r11
	adcq	%r15, %rbp
	movzbl	%al, %r8d
	adcq	%rbx, %r8
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rsi
	movq	%rsi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rcx
	movq	%rsi, %rax
	mulq	-104(%rsp)                      # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	%r14
	movq	%rdx, %r14
	movq	%rax, %rbx
	movq	%rsi, %rax
	mulq	-120(%rsp)                      # 8-byte Folded Reload
	movq	%rax, %r15
	movq	%rdx, %rsi
	addq	%rbx, %rsi
	adcq	%r10, %r14
	adcq	%rcx, %rdi
	adcq	$0, %r13
	addq	%r9, %r15
	adcq	%r11, %rsi
	adcq	%rbp, %r14
	adcq	%r8, %rdi
	adcq	$0, %r13
	movq	-112(%rsp), %r12                # 8-byte Reload
	imulq	%r15, %r12
	movq	%r12, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r11
	movq	%r12, %rax
	movq	-16(%rsp), %r8                  # 8-byte Reload
	mulq	%r8
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%r12, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %rbx
	movq	%r12, %rax
	mulq	-96(%rsp)                       # 8-byte Folded Reload
	addq	%r15, %rax
	adcq	%rsi, %rbx
	adcq	%r14, %rcx
	adcq	%rdi, %r11
	adcq	$0, %r13
	addq	%rdx, %rbx
	adcq	%rbp, %rcx
	adcq	%r10, %r11
	adcq	%r9, %r13
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %r9
	movq	%r9, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r10
	movq	%r9, %rax
	mulq	-104(%rsp)                      # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%r9, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r12
	movq	%r9, %rax
	mulq	-120(%rsp)                      # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %r15
	addq	%r12, %r15
	adcq	%r14, %rsi
	adcq	%r10, %rdi
	adcq	$0, %rbp
	addq	%rbx, %r9
	adcq	%rcx, %r15
	adcq	%r11, %rsi
	adcq	%r13, %rdi
	adcq	$0, %rbp
	movq	-112(%rsp), %r12                # 8-byte Reload
	imulq	%r9, %r12
	movq	%r12, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%r12, %rax
	mulq	%r8
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%r12, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r14
	movq	%r12, %rax
	mulq	-96(%rsp)                       # 8-byte Folded Reload
	addq	%r9, %rax
	adcq	%r15, %r14
	adcq	%rsi, %rcx
	adcq	%rdi, %r11
	adcq	$0, %rbp
	addq	%rdx, %r14
	adcq	%r13, %rcx
	adcq	%r10, %r11
	adcq	%rbx, %rbp
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rsi
	movq	%rsi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	-104(%rsp)                      # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	%rsi, %rax
	mulq	-120(%rsp)                      # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rsi
	addq	%r13, %rsi
	adcq	%r12, %r15
	adcq	%r10, %rdi
	adcq	$0, %rbx
	addq	%r14, %r9
	adcq	%rcx, %rsi
	adcq	%r11, %r15
	adcq	%rbp, %rdi
	adcq	$0, %rbx
	movq	-112(%rsp), %r12                # 8-byte Reload
	imulq	%r9, %r12
	movq	%r12, %rax
	movq	-64(%rsp), %rbp                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %rcx
	movq	%r12, %rax
	mulq	%r8
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r11
	movq	%r12, %rax
	movq	-96(%rsp), %r14                 # 8-byte Reload
	mulq	%r14
	movq	%rdx, %r10
	movq	%rax, %r13
	movq	%r12, %rax
	movq	-72(%rsp), %r12                 # 8-byte Reload
	mulq	%r12
	addq	%r9, %r13
	adcq	%rsi, %rax
	adcq	%r15, %r11
	adcq	%rdi, %rcx
	adcq	$0, %rbx
	addq	%r10, %rax
	adcq	%rdx, %r11
	adcq	-120(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-112(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rax, %rdx
	subq	%r14, %rdx
	movq	%r11, %rsi
	sbbq	%r12, %rsi
	movq	%rcx, %rdi
	sbbq	%r8, %rdi
	movq	%rbx, %r8
	sbbq	%rbp, %r8
	cmovsq	%r11, %rsi
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%rsi, 8(%r9)
	cmovsq	%rcx, %rdi
	movq	%rdi, 16(%r9)
	cmovsq	%rbx, %r8
	movq	%r8, 24(%r9)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end23:
	.size	mcl_fp_montNF4L, .Lfunc_end23-mcl_fp_montNF4L
                                        # -- End function
	.globl	mcl_fp_montRed4L                # -- Begin function mcl_fp_montRed4L
	.p2align	4
	.type	mcl_fp_montRed4L,@function
mcl_fp_montRed4L:                       # @mcl_fp_montRed4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r8
	movq	-8(%rdx), %r11
	movq	(%rdx), %rbp
	movq	%r11, %rdi
	imulq	%r8, %rdi
	movq	24(%rdx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	16(%r10), %r9
	movq	%r9, %rax
	movq	%r9, -48(%rsp)                  # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	8(%r10), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %r12
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, %rdi
	addq	%r12, %rdi
	adcq	%r14, %r13
	adcq	%rcx, %r15
	adcq	$0, %rbx
	addq	%r8, %rax
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rdi
	adcq	16(%rsi), %r13
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %rbx
	setb	-65(%rsp)                       # 1-byte Folded Spill
	movq	%r11, %rcx
	imulq	%rdi, %rcx
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %rcx
	addq	%r9, %rcx
	adcq	%r8, %rbp
	adcq	-64(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-65(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r14
	addq	%rdi, %r10
	adcq	%r13, %rcx
	adcq	%r15, %rbp
	adcq	%rbx, %r12
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	40(%rax), %r14
	setb	-65(%rsp)                       # 1-byte Folded Spill
	movq	%r11, %rdi
	imulq	%rcx, %rdi
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%rdi
	movq	%rdx, %r15
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %rdi
	addq	%r10, %rdi
	adcq	-16(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r15                 # 8-byte Folded Reload
	movzbl	-65(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %rbx
	addq	%rcx, %r8
	adcq	%rbp, %rdi
	adcq	%r12, %r13
	adcq	%r14, %r15
	movq	-24(%rsp), %r14                 # 8-byte Reload
	adcq	48(%r14), %rbx
	setb	-65(%rsp)                       # 1-byte Folded Spill
	imulq	%rdi, %r11
	movq	%r11, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	-32(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	-40(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	mulq	%r11
	addq	%r10, %rax
	adcq	%rsi, %rdx
	adcq	%r8, %rcx
	movzbl	-65(%rsp), %r8d                 # 1-byte Folded Reload
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	addq	%rdi, %r12
	adcq	%r13, %rax
	adcq	%r15, %rdx
	adcq	%rbx, %rcx
	adcq	56(%r14), %r8
	setb	%sil
	movq	%rax, %rdi
	subq	%r9, %rdi
	movq	%rdx, %r9
	sbbq	%rbp, %r9
	movq	%rcx, %r10
	sbbq	-48(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r8, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movzbl	%sil, %esi
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%rcx, %r10
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%r10, 16(%rcx)
	cmovneq	%r8, %r11
	movq	%r11, 24(%rcx)
	cmovneq	%rax, %rdi
	movq	%rdi, (%rcx)
	cmovneq	%rdx, %r9
	movq	%r9, 8(%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end24:
	.size	mcl_fp_montRed4L, .Lfunc_end24-mcl_fp_montRed4L
                                        # -- End function
	.globl	mcl_fp_montRedNF4L              # -- Begin function mcl_fp_montRedNF4L
	.p2align	4
	.type	mcl_fp_montRedNF4L,@function
mcl_fp_montRedNF4L:                     # @mcl_fp_montRedNF4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r8
	movq	-8(%rdx), %r11
	movq	(%rdx), %rbp
	movq	%r11, %rdi
	imulq	%r8, %rdi
	movq	24(%rdx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %rcx
	movq	%rdx, %rbx
	movq	16(%r10), %r9
	movq	%r9, %rax
	movq	%r9, -48(%rsp)                  # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	8(%r10), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %r12
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdi
	movq	%rdx, %rdi
	addq	%r12, %rdi
	adcq	%r14, %r13
	adcq	%rcx, %r15
	adcq	$0, %rbx
	addq	%r8, %rax
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rdi
	adcq	16(%rsi), %r13
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %rbx
	setb	-65(%rsp)                       # 1-byte Folded Spill
	movq	%r11, %rcx
	imulq	%rdi, %rcx
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %rcx
	addq	%r9, %rcx
	adcq	%r8, %rbp
	adcq	-64(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-65(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r14
	addq	%rdi, %r10
	adcq	%r13, %rcx
	adcq	%r15, %rbp
	adcq	%rbx, %r12
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	40(%rax), %r14
	setb	-65(%rsp)                       # 1-byte Folded Spill
	movq	%r11, %rdi
	imulq	%rcx, %rdi
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%rdi
	movq	%rdx, %r15
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, %r13
	movq	%rax, %rdi
	addq	%r10, %rdi
	adcq	-16(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r15                 # 8-byte Folded Reload
	movzbl	-65(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %rbx
	addq	%rcx, %r8
	adcq	%rbp, %rdi
	adcq	%r12, %r13
	adcq	%r14, %r15
	movq	-24(%rsp), %r14                 # 8-byte Reload
	adcq	48(%r14), %rbx
	setb	-65(%rsp)                       # 1-byte Folded Spill
	imulq	%rdi, %r11
	movq	%r11, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	-32(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	-40(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	mulq	%r11
	addq	%r10, %rax
	adcq	%rsi, %rdx
	adcq	%r8, %rcx
	movzbl	-65(%rsp), %r8d                 # 1-byte Folded Reload
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	addq	%rdi, %r12
	adcq	%r13, %rax
	adcq	%r15, %rdx
	adcq	%rbx, %rcx
	adcq	56(%r14), %r8
	movq	%rax, %rsi
	subq	%r9, %rsi
	movq	%rdx, %rdi
	sbbq	%rbp, %rdi
	movq	%rcx, %r9
	sbbq	-48(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r8, %r10
	sbbq	-56(%rsp), %r10                 # 8-byte Folded Reload
	cmovsq	%rcx, %r9
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%r9, 16(%rcx)
	cmovsq	%r8, %r10
	movq	%r10, 24(%rcx)
	cmovsq	%rax, %rsi
	movq	%rsi, (%rcx)
	cmovsq	%rdx, %rdi
	movq	%rdi, 8(%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end25:
	.size	mcl_fp_montRedNF4L, .Lfunc_end25-mcl_fp_montRedNF4L
                                        # -- End function
	.globl	mcl_fp_addPre4L                 # -- Begin function mcl_fp_addPre4L
	.p2align	4
	.type	mcl_fp_addPre4L,@function
mcl_fp_addPre4L:                        # @mcl_fp_addPre4L
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	(%rdx), %r9
	addq	%r8, %r9
	movq	8(%rdx), %r10
	adcq	%rsi, %r10
	movq	16(%rdx), %r11
	adcq	%rcx, %r11
	movq	24(%rdx), %rdx
	adcq	%rax, %rdx
	movq	%r11, 16(%rdi)
	movq	%rdx, 24(%rdi)
	movq	%r9, (%rdi)
	movq	%r10, 8(%rdi)
	cmpq	%r8, %r9
	sbbq	%rsi, %r10
	sbbq	%rcx, %r11
	sbbq	%rax, %rdx
	setb	%al
	movzbl	%al, %eax
	retq
.Lfunc_end26:
	.size	mcl_fp_addPre4L, .Lfunc_end26-mcl_fp_addPre4L
                                        # -- End function
	.globl	mcl_fp_subPre4L                 # -- Begin function mcl_fp_subPre4L
	.p2align	4
	.type	mcl_fp_subPre4L,@function
mcl_fp_subPre4L:                        # @mcl_fp_subPre4L
# %bb.0:
	movq	24(%rsi), %rcx
	movq	16(%rsi), %r8
	movq	(%rsi), %r9
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r9
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r8
	sbbq	24(%rdx), %rcx
	movq	%r8, 16(%rdi)
	movq	%rcx, 24(%rdi)
	movq	%r9, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq
.Lfunc_end27:
	.size	mcl_fp_subPre4L, .Lfunc_end27-mcl_fp_subPre4L
                                        # -- End function
	.globl	mcl_fp_shr1_4L                  # -- Begin function mcl_fp_shr1_4L
	.p2align	4
	.type	mcl_fp_shr1_4L,@function
mcl_fp_shr1_4L:                         # @mcl_fp_shr1_4L
# %bb.0:
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	movq	%rcx, %rdx
	shldq	$63, %rax, %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	%rdx, 16(%rdi)
	shrq	%rcx
	movq	%rcx, 24(%rdi)
	shrdq	$1, %rsi, %r8
	movq	%r8, (%rdi)
	shldq	$63, %rsi, %rax
	movq	%rax, 8(%rdi)
	retq
.Lfunc_end28:
	.size	mcl_fp_shr1_4L, .Lfunc_end28-mcl_fp_shr1_4L
                                        # -- End function
	.globl	mcl_fp_add4L                    # -- Begin function mcl_fp_add4L
	.p2align	4
	.type	mcl_fp_add4L,@function
mcl_fp_add4L:                           # @mcl_fp_add4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	24(%rdx), %r9
	movq	16(%rdx), %r10
	movq	(%rdx), %r8
	movq	8(%rdx), %rax
	addq	(%rsi), %r8
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	setb	%dl
	movzbl	%dl, %edx
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%rax, %r11
	sbbq	8(%rcx), %r11
	movq	%r10, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %r14
	sbbq	24(%rcx), %r14
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%r10, %rbx
	movq	%rbx, 16(%rdi)
	cmovneq	%r9, %r14
	movq	%r14, 24(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%rax, %r11
	movq	%r11, 8(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end29:
	.size	mcl_fp_add4L, .Lfunc_end29-mcl_fp_add4L
                                        # -- End function
	.globl	mcl_fp_addNF4L                  # -- Begin function mcl_fp_addNF4L
	.p2align	4
	.type	mcl_fp_addNF4L,@function
mcl_fp_addNF4L:                         # @mcl_fp_addNF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rdx), %rax
	movq	16(%rdx), %r8
	movq	(%rdx), %r9
	movq	8(%rdx), %rdx
	addq	(%rsi), %r9
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r8
	adcq	24(%rsi), %rax
	movq	%r9, %rsi
	subq	(%rcx), %rsi
	movq	%rdx, %r10
	sbbq	8(%rcx), %r10
	movq	%r8, %r11
	sbbq	16(%rcx), %r11
	movq	%rax, %rbx
	sbbq	24(%rcx), %rbx
	cmovsq	%r8, %r11
	movq	%r11, 16(%rdi)
	cmovsq	%rax, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%r9, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%rdx, %r10
	movq	%r10, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end30:
	.size	mcl_fp_addNF4L, .Lfunc_end30-mcl_fp_addNF4L
                                        # -- End function
	.globl	mcl_fp_sub4L                    # -- Begin function mcl_fp_sub4L
	.p2align	4
	.type	mcl_fp_sub4L,@function
mcl_fp_sub4L:                           # @mcl_fp_sub4L
# %bb.0:
	pushq	%rbx
	xorl	%r9d, %r9d
	movq	24(%rsi), %rax
	movq	16(%rsi), %r8
	movq	(%rsi), %r10
	movq	8(%rsi), %rsi
	subq	(%rdx), %r10
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r8
	sbbq	24(%rdx), %rax
	sbbq	%r9, %r9
	movq	24(%rcx), %rdx
	andq	%r9, %rdx
	movq	16(%rcx), %r11
	andq	%r9, %r11
	movq	8(%rcx), %rbx
	andq	%r9, %rbx
	andq	(%rcx), %r9
	addq	%r10, %r9
	movq	%r9, (%rdi)
	adcq	%rsi, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r8, %r11
	movq	%r11, 16(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 24(%rdi)
	popq	%rbx
	retq
.Lfunc_end31:
	.size	mcl_fp_sub4L, .Lfunc_end31-mcl_fp_sub4L
                                        # -- End function
	.globl	mcl_fp_subNF4L                  # -- Begin function mcl_fp_subNF4L
	.p2align	4
	.type	mcl_fp_subNF4L,@function
mcl_fp_subNF4L:                         # @mcl_fp_subNF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rsi), %rax
	movq	16(%rsi), %r8
	movq	(%rsi), %r9
	movq	8(%rsi), %rsi
	subq	(%rdx), %r9
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r8
	sbbq	24(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	movq	24(%rcx), %r10
	andq	%rdx, %r10
	movq	16(%rcx), %r11
	andq	%rdx, %r11
	movq	8(%rcx), %rbx
	andq	%rdx, %rbx
	andq	(%rcx), %rdx
	addq	%r9, %rdx
	movq	%rdx, (%rdi)
	adcq	%rsi, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r8, %r11
	movq	%r11, 16(%rdi)
	adcq	%rax, %r10
	movq	%r10, 24(%rdi)
	popq	%rbx
	retq
.Lfunc_end32:
	.size	mcl_fp_subNF4L, .Lfunc_end32-mcl_fp_subNF4L
                                        # -- End function
	.globl	mcl_fpDbl_add4L                 # -- Begin function mcl_fpDbl_add4L
	.p2align	4
	.type	mcl_fpDbl_add4L,@function
mcl_fpDbl_add4L:                        # @mcl_fpDbl_add4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	56(%rdx), %r9
	movq	48(%rdx), %r10
	movq	40(%rdx), %rax
	movq	32(%rdx), %r8
	movq	24(%rdx), %r11
	movq	16(%rdx), %rbx
	movq	(%rdx), %r14
	movq	8(%rdx), %rdx
	addq	(%rsi), %r14
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r11
	adcq	32(%rsi), %r8
	adcq	40(%rsi), %rax
	adcq	48(%rsi), %r10
	adcq	56(%rsi), %r9
	movq	%r11, 24(%rdi)
	movq	%r14, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rbx, 16(%rdi)
	setb	%dl
	movzbl	%dl, %edx
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%rax, %r11
	sbbq	8(%rcx), %r11
	movq	%r10, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %r14
	sbbq	24(%rcx), %r14
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%r10, %rbx
	movq	%rbx, 48(%rdi)
	cmovneq	%r9, %r14
	movq	%r14, 56(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, 32(%rdi)
	cmovneq	%rax, %r11
	movq	%r11, 40(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end33:
	.size	mcl_fpDbl_add4L, .Lfunc_end33-mcl_fpDbl_add4L
                                        # -- End function
	.globl	mcl_fpDbl_sub4L                 # -- Begin function mcl_fpDbl_sub4L
	.p2align	4
	.type	mcl_fpDbl_sub4L,@function
mcl_fpDbl_sub4L:                        # @mcl_fpDbl_sub4L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	56(%rsi), %rax
	movq	48(%rsi), %r8
	movq	40(%rsi), %r9
	movq	32(%rsi), %r10
	movq	24(%rsi), %r11
	movq	16(%rsi), %rbx
	movq	(%rsi), %r14
	movq	8(%rsi), %r15
	xorl	%esi, %esi
	subq	(%rdx), %r14
	sbbq	8(%rdx), %r15
	sbbq	16(%rdx), %rbx
	sbbq	24(%rdx), %r11
	sbbq	32(%rdx), %r10
	sbbq	40(%rdx), %r9
	sbbq	48(%rdx), %r8
	sbbq	56(%rdx), %rax
	movq	%r11, 24(%rdi)
	movq	%r14, (%rdi)
	movq	%r15, 8(%rdi)
	movq	%rbx, 16(%rdi)
	sbbq	%rsi, %rsi
	movq	24(%rcx), %rdx
	andq	%rsi, %rdx
	movq	16(%rcx), %r11
	andq	%rsi, %r11
	movq	8(%rcx), %rbx
	andq	%rsi, %rbx
	andq	(%rcx), %rsi
	addq	%r10, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r9, %rbx
	movq	%rbx, 40(%rdi)
	adcq	%r8, %r11
	movq	%r11, 48(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 56(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end34:
	.size	mcl_fpDbl_sub4L, .Lfunc_end34-mcl_fpDbl_sub4L
                                        # -- End function
	.globl	mulPv384x64                     # -- Begin function mulPv384x64
	.p2align	4
	.type	mulPv384x64,@function
mulPv384x64:                            # @mulPv384x64
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r11
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rdx, %r8
	movq	%rax, (%rdi)
	movq	%r11, %rax
	mulq	40(%rsi)
	movq	%rdx, %rcx
	movq	%rax, %r10
	movq	%r11, %rax
	mulq	32(%rsi)
	movq	%rdx, %r9
	movq	%rax, %rbx
	movq	%r11, %rax
	mulq	24(%rsi)
	movq	%rdx, %r14
	movq	%rax, %r15
	movq	%r11, %rax
	mulq	16(%rsi)
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%r11, %rax
	mulq	8(%rsi)
	addq	%r8, %rax
	movq	%rax, 8(%rdi)
	adcq	%r13, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r15, %r12
	movq	%r12, 24(%rdi)
	adcq	%rbx, %r14
	movq	%r14, 32(%rdi)
	adcq	%r10, %r9
	movq	%r9, 40(%rdi)
	adcq	$0, %rcx
	movq	%rcx, 48(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end35:
	.size	mulPv384x64, .Lfunc_end35-mulPv384x64
                                        # -- End function
	.globl	mcl_fp_mont6L                   # -- Begin function mcl_fp_mont6L
	.p2align	4
	.type	mcl_fp_mont6L,@function
mcl_fp_mont6L:                          # @mcl_fp_mont6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, %r8
	movq	%rdx, %r12
	movq	32(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, %r13
	movq	24(%rsi), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %rbp
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r15
	movq	%rdx, %rbx
	movq	(%rsi), %r11
	movq	%r11, -48(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r9
	movq	%rax, %rsi
	movq	%r11, %rax
	mulq	%rdi
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rdx, %r11
	addq	%rsi, %r11
	adcq	%r15, %r9
	adcq	%r14, %rbx
	adcq	%r10, %rbp
	movq	%rbp, -96(%rsp)                 # 8-byte Spill
	adcq	%r8, %r13
	movq	%r13, -88(%rsp)                 # 8-byte Spill
	adcq	$0, %r12
	movq	%r12, -120(%rsp)                # 8-byte Spill
	movq	-8(%rcx), %r14
	movq	%r14, -32(%rsp)                 # 8-byte Spill
	imulq	%rax, %r14
	movq	40(%rcx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	mulq	%r14
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	32(%rcx), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	mulq	%r14
	movq	%rax, %r13
	movq	%rdx, %rbp
	movq	24(%rcx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	mulq	%r14
	movq	%rax, %rsi
	movq	%rdx, %r15
	movq	16(%rcx), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%r14
	movq	%rax, %rdi
	movq	%rdx, %r8
	movq	(%rcx), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	mulq	%r14
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%r12, %rax
	mulq	%r14
	movq	%rdx, %r14
	addq	%rcx, %r14
	adcq	%rdi, %r10
	adcq	%rsi, %r8
	adcq	%r13, %r15
	adcq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	-128(%rsp), %rcx                # 8-byte Reload
	adcq	$0, %rcx
	addq	-104(%rsp), %rax                # 8-byte Folded Reload
	adcq	%r11, %r14
	adcq	%r9, %r10
	adcq	%rbx, %r8
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-120(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %r11
	movq	%r11, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r11, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%rdi, %r9
	adcq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r14, %rbx
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%r15, %rsi
	adcq	%rbp, %rcx
	adcq	-128(%rsp), %r13                # 8-byte Folded Reload
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-128(%rsp)                      # 1-byte Folded Spill
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	imulq	%rbx, %rbp
	movq	%rbp, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rbp, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	%rdi, %r10
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	adcq	$0, %rdx
	addq	%rbx, %rax
	adcq	%r11, %rbp
	adcq	%r9, %r10
	adcq	%rsi, %r8
	adcq	%rcx, %r15
	adcq	%r13, %r14
	adcq	-120(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movzbl	-128(%rsp), %r13d               # 1-byte Folded Reload
	adcq	$0, %r13
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %r11
	movq	%r11, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r11, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%rdi, %r9
	adcq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	-120(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%rbp, %rbx
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%r15, %rsi
	adcq	%r14, %rcx
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	adcq	%r13, %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	imulq	%rbx, %rbp
	movq	%rbp, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rbp, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	%rdi, %r10
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	$0, %r13
	addq	%rbx, %rax
	adcq	%r11, %rbp
	adcq	%r9, %r10
	adcq	%rsi, %r8
	adcq	%rcx, %r15
	adcq	-128(%rsp), %r14                # 8-byte Folded Reload
	adcq	-120(%rsp), %r13                # 8-byte Folded Reload
	movq	%r13, -96(%rsp)                 # 8-byte Spill
	movzbl	-88(%rsp), %r13d                # 1-byte Folded Reload
	adcq	$0, %r13
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %r11
	movq	%r11, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r11, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%rdi, %r9
	adcq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	-120(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%rbp, %rbx
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%r15, %rsi
	adcq	%r14, %rcx
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	adcq	%r13, %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	imulq	%rbx, %rbp
	movq	%rbp, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rbp, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	%rdi, %r10
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	$0, %r13
	addq	%rbx, %rax
	adcq	%r11, %rbp
	adcq	%r9, %r10
	adcq	%rsi, %r8
	adcq	%rcx, %r15
	adcq	-128(%rsp), %r14                # 8-byte Folded Reload
	adcq	-120(%rsp), %r13                # 8-byte Folded Reload
	movq	%r13, -96(%rsp)                 # 8-byte Spill
	movzbl	-88(%rsp), %r13d                # 1-byte Folded Reload
	adcq	$0, %r13
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %r11
	movq	%r11, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r11, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r11, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%rdx, %r11
	addq	%r12, %r11
	adcq	%rdi, %r9
	adcq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	-120(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%rbp, %rbx
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%r15, %rsi
	adcq	%r14, %rcx
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	adcq	%r13, %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	imulq	%rbx, %rbp
	movq	%rbp, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rbp, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	addq	%r12, %rbp
	adcq	%rdi, %r10
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	adcq	$0, %r14
	addq	%rbx, %rax
	adcq	%r11, %rbp
	adcq	%r9, %r10
	adcq	%rsi, %r8
	adcq	%rcx, %r15
	adcq	-128(%rsp), %r13                # 8-byte Folded Reload
	movq	%r13, -128(%rsp)                # 8-byte Spill
	adcq	-120(%rsp), %r14                # 8-byte Folded Reload
	movq	%r14, -120(%rsp)                # 8-byte Spill
	movzbl	-88(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	$0, %rcx
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %r11
	movq	%r11, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%r11, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%r11, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r13
	movq	%rdx, %r11
	addq	%r14, %r11
	adcq	%r12, %r9
	adcq	-80(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	-72(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-64(%rsp), %rdi                 # 8-byte Folded Reload
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	adcq	$0, %rdx
	addq	%rbp, %r13
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%r15, %rbx
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	adcq	%rcx, %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	setb	-64(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	imulq	%r13, %rcx
	movq	%rcx, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %rsi
	movq	%rcx, %rax
	movq	24(%rsp), %r12                  # 8-byte Reload
	mulq	%r12
	addq	%rdi, %rax
	adcq	%rbp, %rdx
	adcq	-48(%rsp), %r15                 # 8-byte Folded Reload
	adcq	-40(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-32(%rsp), %r10                 # 8-byte Folded Reload
	adcq	$0, %r8
	addq	%r13, %rsi
	adcq	%r11, %rax
	adcq	%r9, %rdx
	adcq	%rbx, %r15
	adcq	-80(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-72(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-56(%rsp), %r8                  # 8-byte Folded Reload
	movzbl	-64(%rsp), %esi                 # 1-byte Folded Reload
	adcq	$0, %rsi
	movq	%rax, %rcx
	subq	-24(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rdx, %rdi
	sbbq	%r12, %rdi
	movq	%r15, %r9
	sbbq	-16(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r14, %r11
	sbbq	-8(%rsp), %r11                  # 8-byte Folded Reload
	movq	%r10, %rbx
	sbbq	(%rsp), %rbx                    # 8-byte Folded Reload
	movq	%r8, %r12
	sbbq	8(%rsp), %r12                   # 8-byte Folded Reload
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%r8, %r12
	movq	32(%rsp), %rsi                  # 8-byte Reload
	movq	%r12, 40(%rsi)
	cmovneq	%r10, %rbx
	movq	%rbx, 32(%rsi)
	cmovneq	%r14, %r11
	movq	%r11, 24(%rsi)
	cmovneq	%r15, %r9
	movq	%r9, 16(%rsi)
	cmovneq	%rdx, %rdi
	movq	%rdi, 8(%rsi)
	cmovneq	%rax, %rcx
	movq	%rcx, (%rsi)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end36:
	.size	mcl_fp_mont6L, .Lfunc_end36-mcl_fp_mont6L
                                        # -- End function
	.globl	mcl_fp_montNF6L                 # -- Begin function mcl_fp_montNF6L
	.p2align	4
	.type	mcl_fp_montNF6L,@function
mcl_fp_montNF6L:                        # @mcl_fp_montNF6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$80, %rsp
	movq	%rcx, %r13
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rdi, 72(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	-8(%rcx), %rcx
	movq	%rcx, -48(%rsp)                 # 8-byte Spill
	imulq	%rax, %rcx
	movq	40(%r13), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%rcx
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	32(%r13), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%rcx
	movq	%rax, %r15
	movq	%rdx, %r14
	movq	24(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	24(%r13), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulq	%rcx
	movq	%rax, %r9
	movq	%rdx, %r11
	movq	8(%rsi), %rbx
	movq	%rbx, -8(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	mulq	%rdi
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, %rbp
	movq	16(%r13), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	mulq	%rcx
	movq	%rdx, %r8
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rax, %r12
	movq	%rdx, %rdi
	movq	(%r13), %rbx
	movq	%rbx, -40(%rsp)                 # 8-byte Spill
	movq	8(%r13), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	%rcx
	addq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	%rdi, %rsi
	adcq	%rbp, %r8
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	48(%rsp), %r14                  # 8-byte Folded Reload
	movq	56(%rsp), %rdi                  # 8-byte Reload
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	addq	-120(%rsp), %rax                # 8-byte Folded Reload
	adcq	%r12, %r13
	adcq	24(%rsp), %r10                  # 8-byte Folded Reload
	adcq	40(%rsp), %r9                   # 8-byte Folded Reload
	adcq	64(%rsp), %r15                  # 8-byte Folded Reload
	movq	-128(%rsp), %rcx                # 8-byte Reload
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	setb	%al
	addq	%rdx, %r13
	adcq	%rsi, %r10
	adcq	%r8, %r9
	adcq	%r11, %r15
	adcq	%r14, %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	movzbl	%al, %r14d
	adcq	%rdi, %r14
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rdi
	movq	%rdi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rdi
	addq	%r13, %rdi
	adcq	%r10, %rbp
	adcq	%r9, %r11
	adcq	%r15, %rsi
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	adcq	%r14, %r8
	setb	%al
	addq	%rdx, %rbp
	adcq	%rcx, %r11
	adcq	%rbx, %rsi
	adcq	-120(%rsp), %r12                # 8-byte Folded Reload
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	movzbl	%al, %ecx
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-48(%rsp), %r9                  # 8-byte Reload
	imulq	%rdi, %r9
	movq	%r9, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %r15
	movq	%r9, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %r14
	movq	%r9, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %rbx
	movq	%r9, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	addq	%rdi, %rax
	adcq	%rbp, %rbx
	adcq	%r11, %r14
	adcq	%rsi, %r13
	adcq	%r12, %r15
	movq	-128(%rsp), %rax                # 8-byte Reload
	adcq	%r8, %rax
	adcq	$0, %rcx
	addq	%rdx, %rbx
	adcq	%r10, %r14
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	adcq	-112(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, -128(%rsp)                # 8-byte Spill
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r12
	movq	%rsi, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rsi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%rdx, %r9
	addq	%r8, %r9
	adcq	%r12, %rbp
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	-104(%rsp), %rax                # 8-byte Reload
	adcq	-112(%rsp), %rax                # 8-byte Folded Reload
	adcq	$0, %r10
	addq	%rbx, %rsi
	adcq	%r14, %r9
	adcq	%r13, %rbp
	adcq	%r15, %r11
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	adcq	%rcx, %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	adcq	$0, %r10
	movq	-48(%rsp), %r15                 # 8-byte Reload
	imulq	%rsi, %r15
	movq	%r15, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %rcx
	movq	%r15, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r8
	movq	%r15, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	%r15, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %r14
	movq	%r15, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%r15, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	addq	%rsi, %rax
	adcq	%r9, %rbx
	adcq	%rbp, %r14
	adcq	%r11, %r12
	adcq	%rdi, %r8
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	adcq	$0, %r10
	addq	%rdx, %rbx
	adcq	%r13, %r14
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r8                 # 8-byte Folded Reload
	movq	%r8, -128(%rsp)                 # 8-byte Spill
	adcq	-120(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-112(%rsp), %r10                # 8-byte Folded Reload
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %r9
	movq	%r9, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %r9
	addq	%rsi, %r9
	adcq	%r8, %r13
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	-112(%rsp), %rax                # 8-byte Reload
	adcq	-104(%rsp), %rax                # 8-byte Folded Reload
	adcq	$0, %r15
	addq	%rbx, %rbp
	adcq	%r14, %r9
	adcq	%r12, %r13
	adcq	-128(%rsp), %r11                # 8-byte Folded Reload
	adcq	%rcx, %rdi
	adcq	%r10, %rax
	movq	%rax, %r10
	adcq	$0, %r15
	movq	-48(%rsp), %rcx                 # 8-byte Reload
	imulq	%rbp, %rcx
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%rcx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%r9, %rbx
	adcq	%r13, %r14
	adcq	%r11, %r12
	adcq	%rdi, %r8
	adcq	%r10, %rsi
	adcq	$0, %r15
	addq	%rdx, %rbx
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-120(%rsp), %r12                # 8-byte Folded Reload
	adcq	-104(%rsp), %r8                 # 8-byte Folded Reload
	movq	%r8, -104(%rsp)                 # 8-byte Spill
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %r9
	movq	%r9, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	%r9, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %r9
	addq	%rsi, %r9
	adcq	%r8, %r13
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %r10                # 8-byte Folded Reload
	adcq	$0, %rcx
	addq	%rbx, %rbp
	adcq	%r14, %r9
	adcq	%r12, %r13
	adcq	-104(%rsp), %r11                # 8-byte Folded Reload
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	adcq	%r15, %r10
	adcq	$0, %rcx
	movq	-48(%rsp), %r15                 # 8-byte Reload
	imulq	%rbp, %r15
	movq	%r15, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	%r15, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, %r8
	movq	%r15, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, %rsi
	movq	%r15, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r14
	movq	%r15, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r15, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%r9, %rbx
	adcq	%r13, %r14
	adcq	%r11, %rsi
	adcq	%rdi, %r8
	adcq	%r10, %r12
	adcq	$0, %rcx
	addq	%rdx, %rbx
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-120(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -128(%rsp)                # 8-byte Spill
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %r9
	movq	%r9, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r13
	movq	%r9, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%r9, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rbp
	addq	%r10, %rbp
	adcq	%r13, %rdi
	adcq	-88(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-80(%rsp), %r12                 # 8-byte Folded Reload
	movq	-64(%rsp), %rax                 # 8-byte Reload
	adcq	-72(%rsp), %rax                 # 8-byte Folded Reload
	adcq	$0, %r15
	addq	%rbx, %r9
	adcq	%r14, %rbp
	adcq	%rsi, %rdi
	adcq	%r8, %r11
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	adcq	%rcx, %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	adcq	$0, %r15
	movq	-48(%rsp), %r10                 # 8-byte Reload
	imulq	%r9, %r10
	movq	%r10, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rax, %r13
	movq	%r10, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r10, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rax, %r8
	movq	%r10, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	%r10, %rax
	movq	16(%rsp), %r14                  # 8-byte Reload
	mulq	%r14
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	%r10, %rax
	movq	8(%rsp), %r10                   # 8-byte Reload
	mulq	%r10
	addq	%r9, %rcx
	adcq	%rbp, %rax
	adcq	%rdi, %rbx
	adcq	%r11, %r8
	adcq	%r12, %rsi
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	adcq	$0, %r15
	addq	-80(%rsp), %rax                 # 8-byte Folded Reload
	adcq	%rdx, %rbx
	adcq	-88(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-72(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-56(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-48(%rsp), %r15                 # 8-byte Folded Reload
	movq	%rax, %rdx
	subq	-40(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rbx, %rdi
	sbbq	%r10, %rdi
	movq	%r8, %r9
	sbbq	%r14, %r9
	movq	%rsi, %r10
	sbbq	-32(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r13, %r11
	sbbq	-24(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r15, %r14
	sbbq	-16(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, %r12
	sarq	$63, %r12
	cmovsq	%r15, %r14
	movq	72(%rsp), %r15                  # 8-byte Reload
	movq	%r14, 40(%r15)
	cmovsq	%r13, %r11
	movq	%r11, 32(%r15)
	cmovsq	%rsi, %r10
	movq	%r10, 24(%r15)
	cmovsq	%r8, %r9
	movq	%r9, 16(%r15)
	cmovsq	%rbx, %rdi
	movq	%rdi, 8(%r15)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r15)
	addq	$80, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end37:
	.size	mcl_fp_montNF6L, .Lfunc_end37-mcl_fp_montNF6L
                                        # -- End function
	.globl	mcl_fp_montRed6L                # -- Begin function mcl_fp_montRed6L
	.p2align	4
	.type	mcl_fp_montRed6L,@function
mcl_fp_montRed6L:                       # @mcl_fp_montRed6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, %r10
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movq	(%rsi), %r15
	movq	-8(%rdx), %r13
	movq	%r13, -80(%rsp)                 # 8-byte Spill
	imulq	%r15, %r13
	movq	40(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	32(%r10), %rbp
	movq	%rbp, %rax
	movq	%rbp, -48(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	24(%r10), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, %r11
	movq	%rdx, %rcx
	movq	16(%r10), %r9
	movq	%r9, %rax
	movq	%r9, -16(%rsp)                  # 8-byte Spill
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, %r8
	movq	(%r10), %r12
	movq	8(%r10), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rdx, %r10
	movq	%rax, %r14
	movq	%r12, %rax
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rdx, %r13
	addq	%r14, %r13
	adcq	%rbx, %r10
	adcq	%r11, %r8
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	-120(%rsp), %rdi                # 8-byte Reload
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	movq	-104(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r15, %rax
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %rdi
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	adcq	48(%rsi), %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	setb	-128(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %r11                 # 8-byte Reload
	imulq	%r13, %r11
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %rbp
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%r12, %rax
	mulq	%r11
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r11
	movq	%rax, %r14
	addq	%rbx, %r14
	adcq	%r15, %r11
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-96(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rbp                 # 8-byte Folded Reload
	movzbl	-128(%rsp), %eax                # 1-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r13, %r12
	adcq	%r10, %r14
	adcq	%r8, %r11
	adcq	%rcx, %r9
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	56(%rsi), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%r14, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rcx
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r8
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbx
	movq	%rax, %rsi
	addq	%r15, %rsi
	adcq	%r12, %rbx
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movzbl	-104(%rsp), %eax                # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r14, %r13
	adcq	%r11, %rsi
	adcq	%r9, %rbx
	adcq	%rdi, %r10
	adcq	%rbp, %r8
	adcq	-112(%rsp), %rcx                # 8-byte Folded Reload
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %r11
	imulq	%rsi, %r11
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %rbp
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r11
	movq	%rax, %r14
	addq	%r15, %r14
	adcq	%rbp, %r11
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-96(%rsp), %rdi                 # 8-byte Folded Reload
	movq	-104(%rsp), %r15                # 8-byte Reload
	adcq	-88(%rsp), %r15                 # 8-byte Folded Reload
	movzbl	-112(%rsp), %eax                # 1-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%rsi, %r12
	adcq	%rbx, %r14
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%rcx, %rdi
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	%r15, -104(%rsp)                # 8-byte Spill
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	72(%rax), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	%r13, %rsi
	imulq	%r14, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rax
	mulq	%rsi
	movq	%rdx, %r13
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, %rbp
	movq	-32(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rax
	mulq	%rsi
	movq	%rdx, %r12
	movq	%rax, %rcx
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbx
	movq	%rax, %rsi
	addq	%r12, %rsi
	adcq	%rbp, %rbx
	adcq	-8(%rsp), %r10                  # 8-byte Folded Reload
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	movq	-112(%rsp), %r12                # 8-byte Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r14, %rcx
	adcq	%r11, %rsi
	adcq	%r9, %rbx
	adcq	%rdi, %r10
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -112(%rsp)                # 8-byte Spill
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%rsi, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%rcx
	movq	%rdx, %r14
	movq	%rax, %rbp
	movq	-16(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	-40(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rax
	mulq	%rcx
	addq	%r14, %rax
	adcq	%r8, %rdx
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r9                 # 8-byte Folded Reload
	movzbl	-104(%rsp), %ecx                # 1-byte Folded Reload
	adcq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rsi, %rbp
	adcq	%rbx, %rax
	adcq	%r10, %rdx
	adcq	%r13, %r11
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	adcq	88(%rsi), %rcx
	setb	%r10b
	movq	%rax, %rsi
	subq	-32(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rdx, %r8
	sbbq	%r15, %r8
	movq	%r11, %rbx
	sbbq	%r12, %rbx
	movq	%rdi, %r14
	sbbq	-56(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r9, %r15
	sbbq	-48(%rsp), %r15                 # 8-byte Folded Reload
	movq	%rcx, %r12
	sbbq	-72(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	%r10b, %r10d
	sbbq	$0, %r10
	testb	$1, %r10b
	cmovneq	%r9, %r15
	movq	(%rsp), %r9                     # 8-byte Reload
	movq	%r15, 32(%r9)
	cmovneq	%rcx, %r12
	movq	%r12, 40(%r9)
	cmovneq	%r11, %rbx
	movq	%rbx, 16(%r9)
	cmovneq	%rdi, %r14
	movq	%r14, 24(%r9)
	cmovneq	%rax, %rsi
	movq	%rsi, (%r9)
	cmovneq	%rdx, %r8
	movq	%r8, 8(%r9)
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end38:
	.size	mcl_fp_montRed6L, .Lfunc_end38-mcl_fp_montRed6L
                                        # -- End function
	.globl	mcl_fp_montRedNF6L              # -- Begin function mcl_fp_montRedNF6L
	.p2align	4
	.type	mcl_fp_montRedNF6L,@function
mcl_fp_montRedNF6L:                     # @mcl_fp_montRedNF6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, %r10
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movq	(%rsi), %r15
	movq	-8(%rdx), %r13
	movq	%r13, -80(%rsp)                 # 8-byte Spill
	imulq	%r15, %r13
	movq	40(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	32(%r10), %rbp
	movq	%rbp, %rax
	movq	%rbp, -48(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	24(%r10), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rax, %r11
	movq	%rdx, %rcx
	movq	16(%r10), %r9
	movq	%r9, %rax
	movq	%r9, -16(%rsp)                  # 8-byte Spill
	mulq	%r13
	movq	%rax, %rbx
	movq	%rdx, %r8
	movq	(%r10), %r12
	movq	8(%r10), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rdx, %r10
	movq	%rax, %r14
	movq	%r12, %rax
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	mulq	%r13
	movq	%rdx, %r13
	addq	%r14, %r13
	adcq	%rbx, %r10
	adcq	%r11, %r8
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	-120(%rsp), %rdi                # 8-byte Reload
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	movq	-104(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r15, %rax
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %rdi
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	adcq	48(%rsi), %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	setb	-128(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %r11                 # 8-byte Reload
	imulq	%r13, %r11
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%r11
	movq	%rdx, %rbp
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %r15
	movq	%r12, %rax
	mulq	%r11
	movq	%rdx, %r14
	movq	%rax, %r12
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r11
	movq	%rax, %rbx
	addq	%r14, %rbx
	adcq	%r15, %r11
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-96(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rbp                 # 8-byte Folded Reload
	movzbl	-128(%rsp), %eax                # 1-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r13, %r12
	adcq	%r10, %rbx
	adcq	%r8, %r11
	adcq	%rcx, %r9
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	56(%rsi), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%rbx, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rcx
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r8
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, %r12
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r13
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %rsi
	addq	%r15, %rsi
	adcq	%r12, %r14
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movzbl	-104(%rsp), %eax                # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%rbx, %r13
	adcq	%r11, %rsi
	adcq	%r9, %r14
	adcq	%rdi, %r10
	adcq	%rbp, %r8
	adcq	-112(%rsp), %rcx                # 8-byte Folded Reload
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %r11
	imulq	%rsi, %r11
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %rbp
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r15
	movq	%rax, %r12
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%r11
	movq	%rdx, %r11
	movq	%rax, %rbx
	addq	%r15, %rbx
	adcq	%rbp, %r11
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-96(%rsp), %rdi                 # 8-byte Folded Reload
	movq	-104(%rsp), %r15                # 8-byte Reload
	adcq	-88(%rsp), %r15                 # 8-byte Folded Reload
	movzbl	-112(%rsp), %eax                # 1-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%rsi, %r12
	adcq	%r14, %rbx
	adcq	%r10, %r11
	adcq	%r8, %r9
	adcq	%rcx, %rdi
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	%r15, -104(%rsp)                # 8-byte Spill
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	72(%rax), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	%r13, %rsi
	imulq	%rbx, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rax
	mulq	%rsi
	movq	%rdx, %r13
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r10
	movq	%rax, %rbp
	movq	-32(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rax
	mulq	%rsi
	movq	%rdx, %r12
	movq	%rax, %rcx
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %rsi
	addq	%r12, %rsi
	adcq	%rbp, %r14
	adcq	-8(%rsp), %r10                  # 8-byte Folded Reload
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	movq	-112(%rsp), %r12                # 8-byte Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%rbx, %rcx
	adcq	%r11, %rsi
	adcq	%r9, %r14
	adcq	%rdi, %r10
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -112(%rsp)                # 8-byte Spill
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%rsi, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%r15, %rax
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	-16(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %r8
	movq	-40(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rax
	mulq	%rcx
	addq	%r15, %rax
	adcq	%r8, %rdx
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r9                 # 8-byte Folded Reload
	movzbl	-104(%rsp), %ecx                # 1-byte Folded Reload
	adcq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rsi, %rbp
	adcq	%r14, %rax
	adcq	%r10, %rdx
	adcq	%r13, %r11
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	adcq	88(%rsi), %rcx
	movq	%rax, %rsi
	subq	-32(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rdx, %r8
	sbbq	%rbx, %r8
	movq	%r11, %r10
	sbbq	%r12, %r10
	movq	%rdi, %rbx
	sbbq	-56(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r9, %r14
	sbbq	-48(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rcx, %r15
	sbbq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, %r12
	sarq	$63, %r12
	cmovsq	%r9, %r14
	movq	(%rsp), %r9                     # 8-byte Reload
	movq	%r14, 32(%r9)
	cmovsq	%rcx, %r15
	movq	%r15, 40(%r9)
	cmovsq	%r11, %r10
	movq	%r10, 16(%r9)
	cmovsq	%rdi, %rbx
	movq	%rbx, 24(%r9)
	cmovsq	%rax, %rsi
	movq	%rsi, (%r9)
	cmovsq	%rdx, %r8
	movq	%r8, 8(%r9)
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end39:
	.size	mcl_fp_montRedNF6L, .Lfunc_end39-mcl_fp_montRedNF6L
                                        # -- End function
	.globl	mcl_fp_addPre6L                 # -- Begin function mcl_fp_addPre6L
	.p2align	4
	.type	mcl_fp_addPre6L,@function
mcl_fp_addPre6L:                        # @mcl_fp_addPre6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %rax
	movq	32(%rsi), %rcx
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %r10
	movq	8(%rsi), %rsi
	movq	(%rdx), %r11
	addq	%r10, %r11
	movq	8(%rdx), %rbx
	adcq	%rsi, %rbx
	movq	16(%rdx), %r14
	adcq	%r9, %r14
	movq	24(%rdx), %r15
	adcq	%r8, %r15
	movq	32(%rdx), %r12
	adcq	%rcx, %r12
	movq	40(%rdx), %rdx
	adcq	%rax, %rdx
	movq	%r12, 32(%rdi)
	movq	%rdx, 40(%rdi)
	movq	%r14, 16(%rdi)
	movq	%r15, 24(%rdi)
	movq	%r11, (%rdi)
	movq	%rbx, 8(%rdi)
	xorl	%edi, %edi
	cmpq	%r10, %r11
	sbbq	%rsi, %rbx
	sbbq	%r9, %r14
	sbbq	%r8, %r15
	sbbq	%rcx, %r12
	sbbq	%rax, %rdx
	movl	$0, %eax
	sbbq	%rax, %rax
	sbbq	%rdi, %rdi
	setb	%al
	movzbl	%al, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end40:
	.size	mcl_fp_addPre6L, .Lfunc_end40-mcl_fp_addPre6L
                                        # -- End function
	.globl	mcl_fp_subPre6L                 # -- Begin function mcl_fp_subPre6L
	.p2align	4
	.type	mcl_fp_subPre6L,@function
mcl_fp_subPre6L:                        # @mcl_fp_subPre6L
# %bb.0:
	movq	40(%rsi), %rcx
	movq	32(%rsi), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r11
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %rcx
	movq	%r8, 32(%rdi)
	movq	%rcx, 40(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r9, 24(%rdi)
	movq	%r11, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq
.Lfunc_end41:
	.size	mcl_fp_subPre6L, .Lfunc_end41-mcl_fp_subPre6L
                                        # -- End function
	.globl	mcl_fp_shr1_6L                  # -- Begin function mcl_fp_shr1_6L
	.p2align	4
	.type	mcl_fp_shr1_6L,@function
mcl_fp_shr1_6L:                         # @mcl_fp_shr1_6L
# %bb.0:
	movq	32(%rsi), %rax
	movq	40(%rsi), %rcx
	movq	%rcx, %rdx
	shldq	$63, %rax, %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %rsi
	movq	%rdx, 32(%rdi)
	shrq	%rcx
	movq	%rcx, 40(%rdi)
	shldq	$63, %r10, %rax
	shldq	$63, %rsi, %r10
	movq	%r10, 16(%rdi)
	movq	%rax, 24(%rdi)
	shrdq	$1, %r9, %r8
	movq	%r8, (%rdi)
	shldq	$63, %r9, %rsi
	movq	%rsi, 8(%rdi)
	retq
.Lfunc_end42:
	.size	mcl_fp_shr1_6L, .Lfunc_end42-mcl_fp_shr1_6L
                                        # -- End function
	.globl	mcl_fp_add6L                    # -- Begin function mcl_fp_add6L
	.p2align	4
	.type	mcl_fp_add6L,@function
mcl_fp_add6L:                           # @mcl_fp_add6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r11
	movq	32(%rdx), %rbx
	movq	24(%rdx), %r9
	movq	16(%rdx), %r10
	movq	(%rdx), %r8
	movq	8(%rdx), %rax
	addq	(%rsi), %r8
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %rbx
	adcq	40(%rsi), %r11
	setb	%dl
	movzbl	%dl, %esi
	movq	%r8, %r14
	subq	(%rcx), %r14
	movq	%rax, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %r15
	sbbq	16(%rcx), %r15
	movq	%r9, %r12
	sbbq	24(%rcx), %r12
	movq	%rbx, %r13
	sbbq	32(%rcx), %r13
	movq	%r11, %rbp
	sbbq	40(%rcx), %rbp
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%rbx, %r13
	movq	%r13, 32(%rdi)
	cmovneq	%r11, %rbp
	movq	%rbp, 40(%rdi)
	cmovneq	%r10, %r15
	movq	%r15, 16(%rdi)
	cmovneq	%r9, %r12
	movq	%r12, 24(%rdi)
	cmovneq	%r8, %r14
	movq	%r14, (%rdi)
	cmovneq	%rax, %rdx
	movq	%rdx, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end43:
	.size	mcl_fp_add6L, .Lfunc_end43-mcl_fp_add6L
                                        # -- End function
	.globl	mcl_fp_addNF6L                  # -- Begin function mcl_fp_addNF6L
	.p2align	4
	.type	mcl_fp_addNF6L,@function
mcl_fp_addNF6L:                         # @mcl_fp_addNF6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r11
	movq	32(%rdx), %rbx
	movq	24(%rdx), %r9
	movq	16(%rdx), %r10
	movq	(%rdx), %r8
	movq	8(%rdx), %rax
	addq	(%rsi), %r8
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %rbx
	adcq	40(%rsi), %r11
	movq	%r8, %rdx
	subq	(%rcx), %rdx
	movq	%rax, %rsi
	sbbq	8(%rcx), %rsi
	movq	%r10, %r14
	sbbq	16(%rcx), %r14
	movq	%r9, %r15
	sbbq	24(%rcx), %r15
	movq	%rbx, %r12
	sbbq	32(%rcx), %r12
	movq	%r11, %r13
	sbbq	40(%rcx), %r13
	movq	%r13, %rcx
	sarq	$63, %rcx
	cmovsq	%rbx, %r12
	movq	%r12, 32(%rdi)
	cmovsq	%r11, %r13
	movq	%r13, 40(%rdi)
	cmovsq	%r10, %r14
	movq	%r14, 16(%rdi)
	cmovsq	%r9, %r15
	movq	%r15, 24(%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rax, %rsi
	movq	%rsi, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end44:
	.size	mcl_fp_addNF6L, .Lfunc_end44-mcl_fp_addNF6L
                                        # -- End function
	.globl	mcl_fp_sub6L                    # -- Begin function mcl_fp_sub6L
	.p2align	4
	.type	mcl_fp_sub6L,@function
mcl_fp_sub6L:                           # @mcl_fp_sub6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	xorl	%r11d, %r11d
	movq	40(%rsi), %rax
	movq	32(%rsi), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %rbx
	movq	8(%rsi), %rsi
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %rax
	sbbq	%r11, %r11
	movq	40(%rcx), %rdx
	andq	%r11, %rdx
	movq	32(%rcx), %r14
	andq	%r11, %r14
	movq	24(%rcx), %r15
	andq	%r11, %r15
	movq	16(%rcx), %r12
	andq	%r11, %r12
	movq	8(%rcx), %r13
	andq	%r11, %r13
	andq	(%rcx), %r11
	addq	%rbx, %r11
	movq	%r11, (%rdi)
	adcq	%rsi, %r13
	movq	%r13, 8(%rdi)
	adcq	%r10, %r12
	movq	%r12, 16(%rdi)
	adcq	%r9, %r15
	movq	%r15, 24(%rdi)
	adcq	%r8, %r14
	movq	%r14, 32(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end45:
	.size	mcl_fp_sub6L, .Lfunc_end45-mcl_fp_sub6L
                                        # -- End function
	.globl	mcl_fp_subNF6L                  # -- Begin function mcl_fp_subNF6L
	.p2align	4
	.type	mcl_fp_subNF6L,@function
mcl_fp_subNF6L:                         # @mcl_fp_subNF6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %rax
	movq	32(%rsi), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	subq	(%rdx), %r11
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %rax
	movq	%rax, %rbx
	sarq	$63, %rbx
	movq	%rbx, %r14
	shldq	$1, %rax, %r14
	andq	(%rcx), %r14
	movq	40(%rcx), %rdx
	andq	%rbx, %rdx
	movq	32(%rcx), %r15
	andq	%rbx, %r15
	movq	24(%rcx), %r12
	andq	%rbx, %r12
	movq	16(%rcx), %r13
	andq	%rbx, %r13
	andq	8(%rcx), %rbx
	addq	%r11, %r14
	movq	%r14, (%rdi)
	adcq	%rsi, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r10, %r13
	movq	%r13, 16(%rdi)
	adcq	%r9, %r12
	movq	%r12, 24(%rdi)
	adcq	%r8, %r15
	movq	%r15, 32(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end46:
	.size	mcl_fp_subNF6L, .Lfunc_end46-mcl_fp_subNF6L
                                        # -- End function
	.globl	mcl_fpDbl_add6L                 # -- Begin function mcl_fpDbl_add6L
	.p2align	4
	.type	mcl_fpDbl_add6L,@function
mcl_fpDbl_add6L:                        # @mcl_fpDbl_add6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	88(%rdx), %r11
	movq	80(%rdx), %rbx
	movq	72(%rdx), %r9
	movq	64(%rdx), %r10
	movq	56(%rdx), %rax
	movq	48(%rdx), %r8
	movq	40(%rdx), %r12
	movq	(%rdx), %r14
	movq	8(%rdx), %r15
	addq	(%rsi), %r14
	adcq	8(%rsi), %r15
	movq	32(%rdx), %r13
	movq	24(%rdx), %rbp
	movq	16(%rdx), %rdx
	adcq	16(%rsi), %rdx
	adcq	24(%rsi), %rbp
	adcq	32(%rsi), %r13
	adcq	40(%rsi), %r12
	adcq	48(%rsi), %r8
	adcq	56(%rsi), %rax
	adcq	64(%rsi), %r10
	adcq	72(%rsi), %r9
	adcq	80(%rsi), %rbx
	adcq	88(%rsi), %r11
	movq	%r12, 40(%rdi)
	movq	%r13, 32(%rdi)
	movq	%rbp, 24(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%r15, 8(%rdi)
	movq	%r14, (%rdi)
	setb	%dl
	movzbl	%dl, %esi
	movq	%r8, %r14
	subq	(%rcx), %r14
	movq	%rax, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %r15
	sbbq	16(%rcx), %r15
	movq	%r9, %r12
	sbbq	24(%rcx), %r12
	movq	%rbx, %r13
	sbbq	32(%rcx), %r13
	movq	%r11, %rbp
	sbbq	40(%rcx), %rbp
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%rbx, %r13
	movq	%r13, 80(%rdi)
	cmovneq	%r11, %rbp
	movq	%rbp, 88(%rdi)
	cmovneq	%r10, %r15
	movq	%r15, 64(%rdi)
	cmovneq	%r9, %r12
	movq	%r12, 72(%rdi)
	cmovneq	%r8, %r14
	movq	%r14, 48(%rdi)
	cmovneq	%rax, %rdx
	movq	%rdx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end47:
	.size	mcl_fpDbl_add6L, .Lfunc_end47-mcl_fpDbl_add6L
                                        # -- End function
	.globl	mcl_fpDbl_sub6L                 # -- Begin function mcl_fpDbl_sub6L
	.p2align	4
	.type	mcl_fpDbl_sub6L,@function
mcl_fpDbl_sub6L:                        # @mcl_fpDbl_sub6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	88(%rsi), %rbx
	movq	80(%rsi), %r11
	movq	72(%rsi), %r10
	movq	64(%rsi), %r9
	movq	56(%rsi), %rcx
	movq	48(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rax
	movq	8(%rsi), %r12
	xorl	%r14d, %r14d
	subq	(%rdx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	sbbq	8(%rdx), %r12
	movq	40(%rsi), %r13
	movq	32(%rsi), %rbp
	movq	24(%rsi), %rax
	movq	16(%rsi), %rsi
	sbbq	16(%rdx), %rsi
	sbbq	24(%rdx), %rax
	sbbq	32(%rdx), %rbp
	sbbq	40(%rdx), %r13
	movq	-16(%rsp), %r15                 # 8-byte Reload
	sbbq	48(%rdx), %r15
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	sbbq	56(%rdx), %rcx
	sbbq	64(%rdx), %r9
	sbbq	72(%rdx), %r10
	sbbq	80(%rdx), %r11
	sbbq	88(%rdx), %rbx
	movq	%r13, 40(%rdi)
	movq	%rbp, 32(%rdi)
	movq	%rax, 24(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%r12, 8(%rdi)
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rax, (%rdi)
	sbbq	%r14, %r14
	movq	40(%r8), %rdx
	andq	%r14, %rdx
	movq	32(%r8), %rax
	andq	%r14, %rax
	movq	24(%r8), %rsi
	andq	%r14, %rsi
	movq	16(%r8), %r15
	andq	%r14, %r15
	movq	8(%r8), %r12
	andq	%r14, %r12
	andq	(%r8), %r14
	addq	-16(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, 48(%rdi)
	adcq	%rcx, %r12
	movq	%r12, 56(%rdi)
	adcq	%r9, %r15
	movq	%r15, 64(%rdi)
	adcq	%r10, %rsi
	movq	%rsi, 72(%rdi)
	adcq	%r11, %rax
	movq	%rax, 80(%rdi)
	adcq	%rbx, %rdx
	movq	%rdx, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end48:
	.size	mcl_fpDbl_sub6L, .Lfunc_end48-mcl_fpDbl_sub6L
                                        # -- End function
	.globl	mulPv512x64                     # -- Begin function mulPv512x64
	.p2align	4
	.type	mulPv512x64,@function
mulPv512x64:                            # @mulPv512x64
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rbx
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%rax, (%rdi)
	movq	%rbx, %rax
	mulq	56(%rsi)
	movq	%rdx, %rcx
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	48(%rsi)
	movq	%rdx, %r8
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r14
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	32(%rsi)
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	24(%rsi)
	movq	%rdx, %rbp
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	8(%rsi)
	addq	-24(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 8(%rdi)
	adcq	%r10, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r11, %r9
	movq	%r9, 24(%rdi)
	adcq	%r13, %rbp
	movq	%rbp, 32(%rdi)
	adcq	%r15, %r12
	movq	%r12, 40(%rdi)
	adcq	-16(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, 48(%rdi)
	adcq	-8(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r8, 56(%rdi)
	adcq	$0, %rcx
	movq	%rcx, 64(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end49:
	.size	mulPv512x64, .Lfunc_end49-mulPv512x64
                                        # -- End function
	.globl	mcl_fp_mont8L                   # -- Begin function mcl_fp_mont8L
	.p2align	4
	.type	mcl_fp_mont8L,@function
mcl_fp_mont8L:                          # @mcl_fp_mont8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1400, %rsp                     # imm = 0x578
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rsi, 80(%rsp)                  # 8-byte Spill
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1312(%rsp), %rdi
	callq	mulPv512x64@PLT
	movq	1312(%rsp), %r15
	movq	1320(%rsp), %r12
	movq	%rbx, %rdx
	imulq	%r15, %rdx
	movq	1376(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	1368(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	1360(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	1352(%rsp), %rbp
	movq	1344(%rsp), %r14
	movq	1336(%rsp), %r13
	movq	1328(%rsp), %rbx
	leaq	1232(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	1232(%rsp), %r15
	adcq	1240(%rsp), %r12
	adcq	1248(%rsp), %rbx
	adcq	1256(%rsp), %r13
	adcq	1264(%rsp), %r14
	adcq	1272(%rsp), %rbp
	movq	(%rsp), %r15                    # 8-byte Reload
	adcq	1280(%rsp), %r15
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	1288(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	1296(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	setb	(%rsp)                          # 1-byte Folded Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1152(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	(%rsp), %eax                    # 1-byte Folded Reload
	addq	1152(%rsp), %r12
	adcq	1160(%rsp), %rbx
	adcq	1168(%rsp), %r13
	adcq	1176(%rsp), %r14
	adcq	1184(%rsp), %rbp
	adcq	1192(%rsp), %r15
	movq	%r15, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	1200(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r15                   # 8-byte Reload
	adcq	1208(%rsp), %r15
	adcq	1216(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	setb	8(%rsp)                         # 1-byte Folded Spill
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	1072(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	8(%rsp), %eax                   # 1-byte Folded Reload
	addq	1072(%rsp), %r12
	adcq	1080(%rsp), %rbx
	adcq	1088(%rsp), %r13
	adcq	1096(%rsp), %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	adcq	1104(%rsp), %rbp
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	1112(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	1120(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	1128(%rsp), %r15
	movq	%r15, 8(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %r14                  # 8-byte Reload
	adcq	1136(%rsp), %r14
	movq	%rax, %r12
	adcq	$0, %r12
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	16(%rax), %rdx
	leaq	992(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	992(%rsp), %rbx
	adcq	1000(%rsp), %r13
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	1008(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	adcq	1016(%rsp), %rbp
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	1024(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %r15                  # 8-byte Reload
	adcq	1032(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	1040(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	1048(%rsp), %r14
	movq	%r14, 40(%rsp)                  # 8-byte Spill
	adcq	1056(%rsp), %r12
	movq	%r12, 64(%rsp)                  # 8-byte Spill
	setb	%r12b
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbx, %rdx
	leaq	912(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r12b, %eax
	addq	912(%rsp), %rbx
	adcq	920(%rsp), %r13
	movq	24(%rsp), %r14                  # 8-byte Reload
	adcq	928(%rsp), %r14
	adcq	936(%rsp), %rbp
	movq	%rbp, 96(%rsp)                  # 8-byte Spill
	movq	(%rsp), %r12                    # 8-byte Reload
	adcq	944(%rsp), %r12
	adcq	952(%rsp), %r15
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	960(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	968(%rsp), %rbp
	movq	64(%rsp), %rbx                  # 8-byte Reload
	adcq	976(%rsp), %rbx
	adcq	$0, %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	24(%rax), %rdx
	leaq	832(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	832(%rsp), %r13
	adcq	840(%rsp), %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	movq	96(%rsp), %rax                  # 8-byte Reload
	adcq	848(%rsp), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	adcq	856(%rsp), %r12
	movq	%r12, (%rsp)                    # 8-byte Spill
	adcq	864(%rsp), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r12                   # 8-byte Reload
	adcq	872(%rsp), %r12
	movq	%rbp, %r15
	adcq	880(%rsp), %r15
	adcq	888(%rsp), %rbx
	movq	%rbx, %rbp
	movq	32(%rsp), %r14                  # 8-byte Reload
	adcq	896(%rsp), %r14
	setb	%bl
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	752(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%bl, %ecx
	addq	752(%rsp), %r13
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	760(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	96(%rsp), %rbx                  # 8-byte Reload
	adcq	768(%rsp), %rbx
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	776(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %r13                  # 8-byte Reload
	adcq	784(%rsp), %r13
	adcq	792(%rsp), %r12
	adcq	800(%rsp), %r15
	adcq	808(%rsp), %rbp
	movq	%rbp, 64(%rsp)                  # 8-byte Spill
	movq	%r14, %rbp
	adcq	816(%rsp), %rbp
	adcq	$0, %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	32(%rax), %rdx
	leaq	672(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	24(%rsp), %rcx                  # 8-byte Reload
	addq	672(%rsp), %rcx
	adcq	680(%rsp), %rbx
	movq	%rbx, 96(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	688(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	adcq	696(%rsp), %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	adcq	704(%rsp), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	adcq	712(%rsp), %r15
	movq	64(%rsp), %r14                  # 8-byte Reload
	adcq	720(%rsp), %r14
	adcq	728(%rsp), %rbp
	movq	%rbp, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rbx                  # 8-byte Reload
	adcq	736(%rsp), %rbx
	setb	%r13b
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rcx, %rdx
	movq	%rcx, %r12
	leaq	592(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r13b, %eax
	addq	592(%rsp), %r12
	movq	96(%rsp), %rbp                  # 8-byte Reload
	adcq	600(%rsp), %rbp
	movq	(%rsp), %r13                    # 8-byte Reload
	adcq	608(%rsp), %r13
	movq	16(%rsp), %r12                  # 8-byte Reload
	adcq	616(%rsp), %r12
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	624(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	632(%rsp), %r15
	adcq	640(%rsp), %r14
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %r14                  # 8-byte Reload
	adcq	648(%rsp), %r14
	adcq	656(%rsp), %rbx
	adcq	$0, %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	40(%rax), %rdx
	leaq	512(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	%rbp, %rax
	addq	512(%rsp), %rax
	adcq	520(%rsp), %r13
	movq	%r13, (%rsp)                    # 8-byte Spill
	adcq	528(%rsp), %r12
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r13                   # 8-byte Reload
	adcq	536(%rsp), %r13
	adcq	544(%rsp), %r15
	movq	64(%rsp), %rbp                  # 8-byte Reload
	adcq	552(%rsp), %rbp
	adcq	560(%rsp), %r14
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	adcq	568(%rsp), %rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	576(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	setb	%r14b
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r12
	leaq	432(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r14b, %eax
	addq	432(%rsp), %r12
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	440(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %rbx                  # 8-byte Reload
	adcq	448(%rsp), %rbx
	adcq	456(%rsp), %r13
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	adcq	464(%rsp), %r15
	adcq	472(%rsp), %rbp
	movq	32(%rsp), %r13                  # 8-byte Reload
	adcq	480(%rsp), %r13
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	488(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r12                  # 8-byte Reload
	adcq	496(%rsp), %r12
	adcq	$0, %rax
	movq	%rax, %r14
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	48(%rax), %rdx
	leaq	352(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	272(%rsp), %rdi
	movq	(%rsp), %rax                    # 8-byte Reload
	addq	352(%rsp), %rax
	adcq	360(%rsp), %rbx
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	368(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	376(%rsp), %r15
	movq	%r15, 40(%rsp)                  # 8-byte Spill
	adcq	384(%rsp), %rbp
	movq	%rbp, %r15
	adcq	392(%rsp), %r13
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rbx                  # 8-byte Reload
	adcq	400(%rsp), %rbx
	adcq	408(%rsp), %r12
	movq	%r12, 24(%rsp)                  # 8-byte Spill
	adcq	416(%rsp), %r14
	movq	%r14, (%rsp)                    # 8-byte Spill
	setb	%r13b
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbp
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r13b, %r13d
	addq	272(%rsp), %rbp
	movq	16(%rsp), %r14                  # 8-byte Reload
	adcq	280(%rsp), %r14
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	288(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %r12                  # 8-byte Reload
	adcq	296(%rsp), %r12
	movq	%r15, %rbp
	adcq	304(%rsp), %rbp
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	312(%rsp), %r15
	adcq	320(%rsp), %rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	328(%rsp), %rbx
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	336(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	adcq	$0, %r13
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	56(%rax), %rdx
	leaq	192(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	%r14, %rax
	addq	192(%rsp), %rax
	movq	8(%rsp), %r14                   # 8-byte Reload
	adcq	200(%rsp), %r14
	adcq	208(%rsp), %r12
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	adcq	216(%rsp), %rbp
	movq	%rbp, 64(%rsp)                  # 8-byte Spill
	adcq	224(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	232(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	%rbx, %r12
	adcq	240(%rsp), %r12
	movq	(%rsp), %r15                    # 8-byte Reload
	adcq	248(%rsp), %r15
	adcq	256(%rsp), %r13
	setb	%bl
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbp
	leaq	112(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%bl, %eax
	addq	112(%rsp), %rbp
	movq	%r14, %rdx
	adcq	120(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %rsi                  # 8-byte Reload
	adcq	128(%rsp), %rsi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rbp                  # 8-byte Reload
	adcq	136(%rsp), %rbp
	movq	32(%rsp), %r9                   # 8-byte Reload
	adcq	144(%rsp), %r9
	movq	%r9, 32(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rbx                  # 8-byte Reload
	adcq	152(%rsp), %rbx
	movq	%r12, %r10
	adcq	160(%rsp), %r10
	movq	%r15, %r14
	adcq	168(%rsp), %r14
	adcq	176(%rsp), %r13
	adcq	$0, %rax
	movq	56(%rsp), %r12                  # 8-byte Reload
	subq	(%r12), %rdx
	movq	%rsi, %rcx
	sbbq	8(%r12), %rcx
	movq	%rbp, %rdi
	sbbq	16(%r12), %rdi
	movq	%r9, %rsi
	sbbq	24(%r12), %rsi
	movq	%rbx, %r8
	sbbq	32(%r12), %r8
	movq	%r10, %r9
	movq	%r10, %r15
	sbbq	40(%r12), %r9
	movq	%r14, %r10
	sbbq	48(%r12), %r10
	movq	%r13, %r11
	sbbq	56(%r12), %r11
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%r14, %r10
	movq	104(%rsp), %rax                 # 8-byte Reload
	movq	%r10, 48(%rax)
	cmovneq	%r13, %r11
	movq	%r11, 56(%rax)
	cmovneq	%rbx, %r8
	movq	%r8, 32(%rax)
	cmovneq	%r15, %r9
	movq	%r9, 40(%rax)
	cmovneq	%rbp, %rdi
	movq	%rdi, 16(%rax)
	cmovneq	32(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, 24(%rax)
	cmovneq	8(%rsp), %rdx                   # 8-byte Folded Reload
	movq	%rdx, (%rax)
	cmovneq	40(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, 8(%rax)
	addq	$1400, %rsp                     # imm = 0x578
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end50:
	.size	mcl_fp_mont8L, .Lfunc_end50-mcl_fp_mont8L
                                        # -- End function
	.globl	mcl_fp_montNF8L                 # -- Begin function mcl_fp_montNF8L
	.p2align	4
	.type	mcl_fp_montNF8L,@function
mcl_fp_montNF8L:                        # @mcl_fp_montNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1384, %rsp                     # imm = 0x568
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rsi, 64(%rsp)                  # 8-byte Spill
	movq	%rdi, 88(%rsp)                  # 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 80(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1296(%rsp), %rdi
	callq	mulPv512x64@PLT
	movq	1296(%rsp), %r15
	movq	1304(%rsp), %r12
	movq	%rbx, %rdx
	imulq	%r15, %rdx
	movq	1360(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	1352(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	1344(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	1336(%rsp), %rbp
	movq	1328(%rsp), %r14
	movq	1320(%rsp), %rbx
	movq	1312(%rsp), %r13
	leaq	1216(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	1216(%rsp), %r15
	adcq	1224(%rsp), %r12
	adcq	1232(%rsp), %r13
	adcq	1240(%rsp), %rbx
	adcq	1248(%rsp), %r14
	adcq	1256(%rsp), %rbp
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	1264(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	1272(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	1280(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1136(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	1200(%rsp), %rax
	addq	1136(%rsp), %r12
	adcq	1144(%rsp), %r13
	adcq	1152(%rsp), %rbx
	adcq	1160(%rsp), %r14
	adcq	1168(%rsp), %rbp
	adcq	1176(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	1184(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	1192(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	$0, %rax
	movq	%rax, %r15
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	1056(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	1056(%rsp), %r12
	adcq	1064(%rsp), %r13
	adcq	1072(%rsp), %rbx
	adcq	1080(%rsp), %r14
	adcq	1088(%rsp), %rbp
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	1096(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r12                   # 8-byte Reload
	adcq	1104(%rsp), %r12
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	1112(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	adcq	1120(%rsp), %r15
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	16(%rax), %rdx
	leaq	976(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	1040(%rsp), %rax
	addq	976(%rsp), %r13
	adcq	984(%rsp), %rbx
	adcq	992(%rsp), %r14
	adcq	1000(%rsp), %rbp
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	1008(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	1016(%rsp), %r12
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	1024(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	1032(%rsp), %r15
	movq	%r15, 24(%rsp)                  # 8-byte Spill
	movq	%rax, %r15
	adcq	$0, %r15
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	896(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	896(%rsp), %r13
	adcq	904(%rsp), %rbx
	adcq	912(%rsp), %r14
	adcq	920(%rsp), %rbp
	movq	32(%rsp), %r13                  # 8-byte Reload
	adcq	928(%rsp), %r13
	adcq	936(%rsp), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %r12                  # 8-byte Reload
	adcq	944(%rsp), %r12
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	952(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	adcq	960(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	24(%rax), %rdx
	leaq	816(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	880(%rsp), %rcx
	addq	816(%rsp), %rbx
	adcq	824(%rsp), %r14
	adcq	832(%rsp), %rbp
	adcq	840(%rsp), %r13
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	848(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r12, %r15
	adcq	856(%rsp), %r15
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	864(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r13                  # 8-byte Reload
	adcq	872(%rsp), %r13
	adcq	$0, %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbx, %rdx
	leaq	736(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	736(%rsp), %rbx
	adcq	744(%rsp), %r14
	adcq	752(%rsp), %rbp
	movq	32(%rsp), %r12                  # 8-byte Reload
	adcq	760(%rsp), %r12
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	768(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	776(%rsp), %r15
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	784(%rsp), %rbx
	adcq	792(%rsp), %r13
	movq	%r13, 48(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r13                  # 8-byte Reload
	adcq	800(%rsp), %r13
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	32(%rax), %rdx
	leaq	656(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	720(%rsp), %rax
	addq	656(%rsp), %r14
	adcq	664(%rsp), %rbp
	adcq	672(%rsp), %r12
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r12                   # 8-byte Reload
	adcq	680(%rsp), %r12
	adcq	688(%rsp), %r15
	adcq	696(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	704(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	adcq	712(%rsp), %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	movq	%rax, %rbx
	adcq	$0, %rbx
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	576(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	576(%rsp), %r14
	adcq	584(%rsp), %rbp
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	592(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	adcq	600(%rsp), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	adcq	608(%rsp), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r12                  # 8-byte Reload
	adcq	616(%rsp), %r12
	movq	48(%rsp), %r13                  # 8-byte Reload
	adcq	624(%rsp), %r13
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	632(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	adcq	640(%rsp), %rbx
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	40(%rax), %rdx
	leaq	496(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	560(%rsp), %r14
	addq	496(%rsp), %rbp
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	504(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	512(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	520(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	adcq	528(%rsp), %r12
	movq	%r12, 24(%rsp)                  # 8-byte Spill
	adcq	536(%rsp), %r13
	movq	%r13, 48(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r13                  # 8-byte Reload
	adcq	544(%rsp), %r13
	adcq	552(%rsp), %rbx
	adcq	$0, %r14
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbp, %rdx
	leaq	416(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	416(%rsp), %rbp
	adcq	424(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r12                   # 8-byte Reload
	adcq	432(%rsp), %r12
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	440(%rsp), %rbp
	movq	24(%rsp), %r15                  # 8-byte Reload
	adcq	448(%rsp), %r15
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	456(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	adcq	464(%rsp), %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	adcq	472(%rsp), %rbx
	adcq	480(%rsp), %r14
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	48(%rax), %rdx
	leaq	336(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	256(%rsp), %rdi
	movq	400(%rsp), %r13
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	336(%rsp), %rax
	adcq	344(%rsp), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	adcq	352(%rsp), %rbp
	adcq	360(%rsp), %r15
	movq	%r15, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r12                  # 8-byte Reload
	adcq	368(%rsp), %r12
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	376(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	384(%rsp), %rbx
	adcq	392(%rsp), %r14
	adcq	$0, %r13
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r15
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	176(%rsp), %rdi
	addq	256(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	264(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	272(%rsp), %rbp
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	280(%rsp), %rbp
	adcq	288(%rsp), %r12
	movq	%r12, 48(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r12                  # 8-byte Reload
	adcq	296(%rsp), %r12
	adcq	304(%rsp), %rbx
	adcq	312(%rsp), %r14
	adcq	320(%rsp), %r13
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	56(%rax), %rdx
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	96(%rsp), %rdi
	movq	240(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	addq	176(%rsp), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	184(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	192(%rsp), %rbp
	movq	%rbp, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rbp                  # 8-byte Reload
	adcq	200(%rsp), %rbp
	adcq	208(%rsp), %r12
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	adcq	216(%rsp), %rbx
	adcq	224(%rsp), %r14
	adcq	232(%rsp), %r13
	adcq	$0, %r15
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r12
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	96(%rsp), %r12
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	104(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rdx                  # 8-byte Reload
	adcq	112(%rsp), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r12
	adcq	120(%rsp), %r12
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	128(%rsp), %rbp
	movq	%rbx, %r8
	adcq	136(%rsp), %r8
	adcq	144(%rsp), %r14
	adcq	152(%rsp), %r13
	adcq	160(%rsp), %r15
	movq	56(%rsp), %r11                  # 8-byte Reload
	subq	(%r11), %rcx
	movq	%rdx, %rax
	sbbq	8(%r11), %rax
	movq	%r12, %rdx
	sbbq	16(%r11), %rdx
	movq	%rbp, %rsi
	sbbq	24(%r11), %rsi
	movq	%r8, %rdi
	movq	%r8, %rbx
	sbbq	32(%r11), %rdi
	movq	%r14, %r8
	sbbq	40(%r11), %r8
	movq	%r13, %r9
	sbbq	48(%r11), %r9
	movq	%r15, %r10
	sbbq	56(%r11), %r10
	cmovsq	%r13, %r9
	movq	88(%rsp), %r11                  # 8-byte Reload
	movq	%r9, 48(%r11)
	cmovsq	%r15, %r10
	movq	%r10, 56(%r11)
	cmovsq	%rbx, %rdi
	movq	%rdi, 32(%r11)
	cmovsq	%r14, %r8
	movq	%r8, 40(%r11)
	cmovsq	%r12, %rdx
	movq	%rdx, 16(%r11)
	cmovsq	%rbp, %rsi
	movq	%rsi, 24(%r11)
	cmovsq	16(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, (%r11)
	cmovsq	24(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 8(%r11)
	addq	$1384, %rsp                     # imm = 0x568
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end51:
	.size	mcl_fp_montNF8L, .Lfunc_end51-mcl_fp_montNF8L
                                        # -- End function
	.globl	mcl_fp_montRed8L                # -- Begin function mcl_fp_montRed8L
	.p2align	4
	.type	mcl_fp_montRed8L,@function
mcl_fp_montRed8L:                       # @mcl_fp_montRed8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$792, %rsp                      # imm = 0x318
	movq	%rdi, 136(%rsp)                 # 8-byte Spill
	movq	56(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	48(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rbx
	movq	48(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	32(%rsi), %r15
	movq	24(%rsi), %rbp
	movq	16(%rsi), %r13
	movq	(%rsi), %r14
	movq	8(%rsi), %r12
	movq	-8(%rdx), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdx, %rsi
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	imulq	%r14, %rdx
	leaq	704(%rsp), %rdi
	callq	mulPv512x64@PLT
	addq	704(%rsp), %r14
	adcq	712(%rsp), %r12
	adcq	720(%rsp), %r13
	adcq	728(%rsp), %rbp
	adcq	736(%rsp), %r15
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	744(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	752(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	adcq	760(%rsp), %rbx
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	64(%rax), %rax
	adcq	768(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	setb	%r14b
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	624(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	688(%rsp), %rax
	addb	$255, %r14b
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	624(%rsp), %r12
	adcq	632(%rsp), %r13
	adcq	640(%rsp), %rbp
	adcq	648(%rsp), %r15
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	656(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	664(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	adcq	672(%rsp), %rbx
	movq	%rbx, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	680(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	72(%rax), %rcx
	movq	%rcx, %rbx
	setb	%r14b
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	544(%rsp), %rdi
	movq	56(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rsi
	callq	mulPv512x64@PLT
	movq	608(%rsp), %rax
	addb	$255, %r14b
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	544(%rsp), %r13
	adcq	552(%rsp), %rbp
	adcq	560(%rsp), %r15
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	568(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	576(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	584(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	592(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	600(%rsp), %rbx
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rcx, %r13
	adcq	80(%rax), %r13
	setb	%r14b
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbp, %rdx
	leaq	464(%rsp), %rdi
	movq	%r12, %rsi
	callq	mulPv512x64@PLT
	movq	528(%rsp), %rax
	addb	$255, %r14b
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	464(%rsp), %rbp
	adcq	472(%rsp), %r15
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	480(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	488(%rsp), %rbx
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	496(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	504(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	512(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	adcq	520(%rsp), %r13
	movq	%r13, 64(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rcx, %r13
	adcq	88(%rax), %r13
	setb	%r14b
	movq	48(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rdx
	imulq	%r15, %rdx
	leaq	384(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	448(%rsp), %rbp
	addb	$255, %r14b
	adcq	$0, %rbp
	addq	384(%rsp), %r15
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	392(%rsp), %rcx
	adcq	400(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r15                  # 8-byte Reload
	adcq	408(%rsp), %r15
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	416(%rsp), %rbx
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	424(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rax                  # 8-byte Reload
	adcq	432(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	adcq	440(%rsp), %r13
	movq	%r13, (%rsp)                    # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	96(%rax), %rbp
	setb	%r14b
	movq	%r12, %rdx
	imulq	%rcx, %rdx
	movq	%rcx, %r12
	leaq	304(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	368(%rsp), %r13
	addb	$255, %r14b
	adcq	$0, %r13
	addq	304(%rsp), %r12
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	312(%rsp), %rcx
	adcq	320(%rsp), %r15
	movq	%r15, 40(%rsp)                  # 8-byte Spill
	adcq	328(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %r12                  # 8-byte Reload
	adcq	336(%rsp), %r12
	movq	64(%rsp), %rax                  # 8-byte Reload
	adcq	344(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	352(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	adcq	360(%rsp), %rbp
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	104(%rax), %r13
	setb	%r14b
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%rcx, %rdx
	movq	%rcx, %r15
	leaq	224(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	288(%rsp), %rbx
	addb	$255, %r14b
	adcq	$0, %rbx
	addq	224(%rsp), %r15
	movq	40(%rsp), %r15                  # 8-byte Reload
	adcq	232(%rsp), %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	240(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	248(%rsp), %r12
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %r12                  # 8-byte Reload
	adcq	256(%rsp), %r12
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	264(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	adcq	272(%rsp), %rbp
	adcq	280(%rsp), %r13
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	112(%rax), %rbx
	setb	%r14b
	movq	48(%rsp), %rdx                  # 8-byte Reload
	imulq	%r15, %rdx
	leaq	144(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addb	$255, %r14b
	movq	208(%rsp), %rax
	adcq	$0, %rax
	addq	144(%rsp), %r15
	movq	8(%rsp), %rdx                   # 8-byte Reload
	adcq	152(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rsi                  # 8-byte Reload
	adcq	160(%rsp), %rsi
	movq	%rsi, 16(%rsp)                  # 8-byte Spill
	adcq	168(%rsp), %r12
	movq	(%rsp), %r10                    # 8-byte Reload
	adcq	176(%rsp), %r10
	adcq	184(%rsp), %rbp
	adcq	192(%rsp), %r13
	adcq	200(%rsp), %rbx
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	120(%rcx), %rax
	setb	%r8b
	movq	%rdx, %rcx
	subq	72(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rsi, %rdx
	sbbq	80(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%r12, %rdi
	movq	%r12, %r15
	sbbq	88(%rsp), %rdi                  # 8-byte Folded Reload
	movq	%r10, %rsi
	movq	%r10, %r12
	sbbq	96(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rbp, %r9
	sbbq	104(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r13, %r10
	sbbq	112(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rbx, %r11
	sbbq	120(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rax, %r14
	sbbq	128(%rsp), %r14                 # 8-byte Folded Reload
	movzbl	%r8b, %r8d
	sbbq	$0, %r8
	testb	$1, %r8b
	cmovneq	%rbx, %r11
	movq	136(%rsp), %r8                  # 8-byte Reload
	movq	%r11, 48(%r8)
	cmovneq	%rax, %r14
	movq	%r14, 56(%r8)
	cmovneq	%rbp, %r9
	movq	%r9, 32(%r8)
	cmovneq	%r13, %r10
	movq	%r10, 40(%r8)
	cmovneq	%r15, %rdi
	movq	%rdi, 16(%r8)
	cmovneq	%r12, %rsi
	movq	%rsi, 24(%r8)
	cmovneq	8(%rsp), %rcx                   # 8-byte Folded Reload
	movq	%rcx, (%r8)
	cmovneq	16(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, 8(%r8)
	addq	$792, %rsp                      # imm = 0x318
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end52:
	.size	mcl_fp_montRed8L, .Lfunc_end52-mcl_fp_montRed8L
                                        # -- End function
	.globl	mcl_fp_montRedNF8L              # -- Begin function mcl_fp_montRedNF8L
	.p2align	4
	.type	mcl_fp_montRedNF8L,@function
mcl_fp_montRedNF8L:                     # @mcl_fp_montRedNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$792, %rsp                      # imm = 0x318
	movq	%rdi, 136(%rsp)                 # 8-byte Spill
	movq	56(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	48(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rbp
	movq	32(%rsi), %r15
	movq	24(%rsi), %r12
	movq	16(%rsi), %rbx
	movq	(%rsi), %r13
	movq	8(%rsi), %r14
	movq	-8(%rdx), %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdx, %rsi
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	imulq	%r13, %rdx
	leaq	704(%rsp), %rdi
	callq	mulPv512x64@PLT
	addq	704(%rsp), %r13
	adcq	712(%rsp), %r14
	adcq	720(%rsp), %rbx
	adcq	728(%rsp), %r12
	adcq	736(%rsp), %r15
	adcq	744(%rsp), %rbp
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	752(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %r13                  # 8-byte Reload
	adcq	760(%rsp), %r13
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	64(%rax), %rax
	adcq	768(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	setb	%bpl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	624(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	688(%rsp), %rax
	addb	$255, %bpl
	adcq	$0, %rax
	addq	624(%rsp), %r14
	adcq	632(%rsp), %rbx
	adcq	640(%rsp), %r12
	adcq	648(%rsp), %r15
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	656(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	664(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	672(%rsp), %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	680(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	72(%rcx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	setb	%bpl
	movq	56(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rdx
	imulq	%rbx, %rdx
	leaq	544(%rsp), %rdi
	movq	64(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rsi
	callq	mulPv512x64@PLT
	movq	608(%rsp), %rax
	addb	$255, %bpl
	adcq	$0, %rax
	addq	544(%rsp), %rbx
	adcq	552(%rsp), %r12
	adcq	560(%rsp), %r15
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	568(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	576(%rsp), %rbx
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	584(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	592(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	600(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	80(%rcx), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	setb	%bpl
	movq	%r13, %rdx
	imulq	%r12, %rdx
	leaq	464(%rsp), %rdi
	movq	%r14, %rsi
	callq	mulPv512x64@PLT
	movq	528(%rsp), %r14
	addb	$255, %bpl
	adcq	$0, %r14
	addq	464(%rsp), %r12
	adcq	472(%rsp), %r15
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	480(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	adcq	488(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rbx                  # 8-byte Reload
	adcq	496(%rsp), %rbx
	movq	(%rsp), %r13                    # 8-byte Reload
	adcq	504(%rsp), %r13
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	512(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	520(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	88(%rax), %r14
	setb	%bpl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%r15, %rdx
	leaq	384(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	448(%rsp), %r12
	addb	$255, %bpl
	adcq	$0, %r12
	addq	384(%rsp), %r15
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	392(%rsp), %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	400(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	408(%rsp), %rbx
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	adcq	416(%rsp), %r13
	movq	%r13, (%rsp)                    # 8-byte Spill
	movq	8(%rsp), %r13                   # 8-byte Reload
	adcq	424(%rsp), %r13
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	432(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	440(%rsp), %r14
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	96(%rcx), %r12
	setb	%bpl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	leaq	304(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	368(%rsp), %r15
	addb	$255, %bpl
	adcq	$0, %r15
	addq	304(%rsp), %rbx
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	312(%rsp), %rbx
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	320(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	328(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	adcq	336(%rsp), %r13
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	344(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	352(%rsp), %r14
	adcq	360(%rsp), %r12
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	104(%rcx), %r15
	setb	%r13b
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbx, %rdx
	leaq	224(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	288(%rsp), %rbp
	addb	$255, %r13b
	adcq	$0, %rbp
	addq	224(%rsp), %rbx
	movq	16(%rsp), %rbx                  # 8-byte Reload
	adcq	232(%rsp), %rbx
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	240(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	248(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	256(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	264(%rsp), %r14
	adcq	272(%rsp), %r12
	adcq	280(%rsp), %r15
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	112(%rcx), %rbp
	setb	%r13b
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbx, %rdx
	leaq	144(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addb	$255, %r13b
	movq	208(%rsp), %rax
	adcq	$0, %rax
	addq	144(%rsp), %rbx
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	152(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	8(%rsp), %rsi                   # 8-byte Reload
	adcq	160(%rsp), %rsi
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rdi                  # 8-byte Reload
	adcq	168(%rsp), %rdi
	adcq	176(%rsp), %r14
	adcq	184(%rsp), %r12
	adcq	192(%rsp), %r15
	adcq	200(%rsp), %rbp
	movq	40(%rsp), %rdx                  # 8-byte Reload
	adcq	120(%rdx), %rax
	movq	%rcx, %rdx
	subq	72(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rsi, %rcx
	sbbq	80(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rdi, %rsi
	movq	%rdi, %rbx
	sbbq	88(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%r14, %rdi
	sbbq	96(%rsp), %rdi                  # 8-byte Folded Reload
	movq	%r12, %r8
	sbbq	104(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r15, %r9
	sbbq	112(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rbp, %r10
	sbbq	120(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rax, %r11
	sbbq	128(%rsp), %r11                 # 8-byte Folded Reload
	cmovsq	%rbp, %r10
	movq	136(%rsp), %r13                 # 8-byte Reload
	movq	%r10, 48(%r13)
	cmovsq	%rax, %r11
	movq	%r11, 56(%r13)
	cmovsq	%r12, %r8
	movq	%r8, 32(%r13)
	cmovsq	%r15, %r9
	movq	%r9, 40(%r13)
	cmovsq	%rbx, %rsi
	movq	%rsi, 16(%r13)
	cmovsq	%r14, %rdi
	movq	%rdi, 24(%r13)
	cmovsq	(%rsp), %rdx                    # 8-byte Folded Reload
	movq	%rdx, (%r13)
	cmovsq	8(%rsp), %rcx                   # 8-byte Folded Reload
	movq	%rcx, 8(%r13)
	addq	$792, %rsp                      # imm = 0x318
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end53:
	.size	mcl_fp_montRedNF8L, .Lfunc_end53-mcl_fp_montRedNF8L
                                        # -- End function
	.globl	mcl_fp_addPre8L                 # -- Begin function mcl_fp_addPre8L
	.p2align	4
	.type	mcl_fp_addPre8L,@function
mcl_fp_addPre8L:                        # @mcl_fp_addPre8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rsi), %r9
	movq	48(%rsi), %r8
	movq	40(%rsi), %rcx
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	movq	(%rdx), %rsi
	addq	%rbx, %rsi
	movq	8(%rdx), %r15
	adcq	%r14, %r15
	movq	16(%rdx), %r12
	adcq	%r11, %r12
	movq	24(%rdx), %r13
	adcq	%r10, %r13
	movq	32(%rdx), %rbp
	adcq	%rax, %rbp
	movq	40(%rdx), %rax
	adcq	%rcx, %rax
	movq	48(%rdx), %rcx
	adcq	%r8, %rcx
	movq	56(%rdx), %rdx
	adcq	%r9, %rdx
	cmpq	%rbx, %rsi
	movq	%r15, 8(%rdi)
	sbbq	%r14, %r15
	movq	%r12, 16(%rdi)
	sbbq	%r11, %r12
	movq	%r13, 24(%rdi)
	sbbq	%r10, %r13
	movq	%rbp, 32(%rdi)
	sbbq	-16(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rax, 40(%rdi)
	sbbq	-8(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rcx, 48(%rdi)
	sbbq	%r8, %rcx
	movq	%rsi, (%rdi)
	movq	%rdx, 56(%rdi)
	sbbq	%r9, %rdx
	setb	%al
	movzbl	%al, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end54:
	.size	mcl_fp_addPre8L, .Lfunc_end54-mcl_fp_addPre8L
                                        # -- End function
	.globl	mcl_fp_subPre8L                 # -- Begin function mcl_fp_subPre8L
	.p2align	4
	.type	mcl_fp_subPre8L,@function
mcl_fp_subPre8L:                        # @mcl_fp_subPre8L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	56(%rsi), %rcx
	movq	48(%rsi), %r8
	movq	40(%rsi), %r9
	movq	32(%rsi), %r10
	movq	24(%rsi), %r11
	movq	16(%rsi), %rbx
	movq	(%rsi), %r14
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r14
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rbx
	sbbq	24(%rdx), %r11
	sbbq	32(%rdx), %r10
	sbbq	40(%rdx), %r9
	sbbq	48(%rdx), %r8
	sbbq	56(%rdx), %rcx
	movq	%r8, 48(%rdi)
	movq	%rcx, 56(%rdi)
	movq	%r10, 32(%rdi)
	movq	%r9, 40(%rdi)
	movq	%rbx, 16(%rdi)
	movq	%r11, 24(%rdi)
	movq	%r14, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end55:
	.size	mcl_fp_subPre8L, .Lfunc_end55-mcl_fp_subPre8L
                                        # -- End function
	.globl	mcl_fp_shr1_8L                  # -- Begin function mcl_fp_shr1_8L
	.p2align	4
	.type	mcl_fp_shr1_8L,@function
mcl_fp_shr1_8L:                         # @mcl_fp_shr1_8L
# %bb.0:
	pushq	%rbx
	movq	48(%rsi), %rax
	movq	56(%rsi), %rcx
	movq	%rcx, %rdx
	shldq	$63, %rax, %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	40(%rsi), %rbx
	movq	32(%rsi), %rsi
	movq	%rdx, 48(%rdi)
	shrq	%rcx
	movq	%rcx, 56(%rdi)
	shldq	$63, %rbx, %rax
	shldq	$63, %rsi, %rbx
	movq	%rbx, 32(%rdi)
	movq	%rax, 40(%rdi)
	shldq	$63, %r10, %rsi
	shldq	$63, %r11, %r10
	movq	%r10, 16(%rdi)
	movq	%rsi, 24(%rdi)
	shrdq	$1, %r9, %r8
	movq	%r8, (%rdi)
	shldq	$63, %r9, %r11
	movq	%r11, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end56:
	.size	mcl_fp_shr1_8L, .Lfunc_end56-mcl_fp_shr1_8L
                                        # -- End function
	.globl	mcl_fp_add8L                    # -- Begin function mcl_fp_add8L
	.p2align	4
	.type	mcl_fp_add8L,@function
mcl_fp_add8L:                           # @mcl_fp_add8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %rax
	movq	48(%rdx), %r8
	movq	40(%rdx), %r9
	movq	32(%rdx), %rbp
	movq	24(%rdx), %r13
	movq	16(%rdx), %r11
	movq	(%rdx), %r10
	movq	8(%rdx), %rdx
	addq	(%rsi), %r10
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r11
	movq	%r11, %r12
	movq	%r11, -16(%rsp)                 # 8-byte Spill
	adcq	24(%rsi), %r13
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	adcq	32(%rsi), %rbp
	adcq	40(%rsi), %r9
	adcq	48(%rsi), %r8
	adcq	56(%rsi), %rax
	setb	-25(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %rsi
	subq	(%rcx), %rsi
	movq	%rdx, %r15
	sbbq	8(%rcx), %r15
	sbbq	16(%rcx), %r12
	sbbq	24(%rcx), %r13
	movq	%rbp, %r10
	sbbq	32(%rcx), %r10
	movq	%r9, %r11
	sbbq	40(%rcx), %r11
	movq	%r8, %rbx
	sbbq	48(%rcx), %rbx
	movq	%rax, %r14
	sbbq	56(%rcx), %r14
	movzbl	-25(%rsp), %ecx                 # 1-byte Folded Reload
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%rax, %r14
	movq	%r14, 56(%rdi)
	cmovneq	%r8, %rbx
	movq	%rbx, 48(%rdi)
	cmovneq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovneq	%rbp, %r10
	movq	%r10, 32(%rdi)
	cmovneq	-24(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r13, 24(%rdi)
	cmovneq	-16(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 16(%rdi)
	cmovneq	%rdx, %r15
	movq	%r15, 8(%rdi)
	cmovneq	-8(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, (%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end57:
	.size	mcl_fp_add8L, .Lfunc_end57-mcl_fp_add8L
                                        # -- End function
	.globl	mcl_fp_addNF8L                  # -- Begin function mcl_fp_addNF8L
	.p2align	4
	.type	mcl_fp_addNF8L,@function
mcl_fp_addNF8L:                         # @mcl_fp_addNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %rax
	movq	48(%rdx), %r8
	movq	40(%rdx), %r9
	movq	32(%rdx), %r10
	movq	24(%rdx), %r13
	movq	16(%rdx), %rbx
	movq	(%rdx), %r11
	movq	8(%rdx), %rdx
	addq	(%rsi), %r11
	movq	%r11, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rbx
	movq	%rbx, %r12
	movq	%rbx, -16(%rsp)                 # 8-byte Spill
	adcq	24(%rsi), %r13
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	adcq	32(%rsi), %r10
	adcq	40(%rsi), %r9
	adcq	48(%rsi), %r8
	adcq	56(%rsi), %rax
	movq	%r11, %rsi
	subq	(%rcx), %rsi
	movq	%rdx, %r15
	sbbq	8(%rcx), %r15
	sbbq	16(%rcx), %r12
	sbbq	24(%rcx), %r13
	movq	%r10, %rbp
	sbbq	32(%rcx), %rbp
	movq	%r9, %r11
	sbbq	40(%rcx), %r11
	movq	%r8, %rbx
	sbbq	48(%rcx), %rbx
	movq	%rax, %r14
	sbbq	56(%rcx), %r14
	cmovsq	%rax, %r14
	movq	%r14, 56(%rdi)
	cmovsq	%r8, %rbx
	movq	%rbx, 48(%rdi)
	cmovsq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovsq	%r10, %rbp
	movq	%rbp, 32(%rdi)
	cmovsq	-24(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r13, 24(%rdi)
	cmovsq	-16(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 16(%rdi)
	cmovsq	%rdx, %r15
	movq	%r15, 8(%rdi)
	cmovsq	-8(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, (%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end58:
	.size	mcl_fp_addNF8L, .Lfunc_end58-mcl_fp_addNF8L
                                        # -- End function
	.globl	mcl_fp_sub8L                    # -- Begin function mcl_fp_sub8L
	.p2align	4
	.type	mcl_fp_sub8L,@function
mcl_fp_sub8L:                           # @mcl_fp_sub8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	xorl	%ebx, %ebx
	movq	56(%rsi), %rax
	movq	48(%rsi), %rcx
	movq	40(%rsi), %r12
	movq	32(%rsi), %r10
	movq	24(%rsi), %r11
	movq	16(%rsi), %r14
	movq	(%rsi), %r15
	movq	8(%rsi), %r9
	subq	(%rdx), %r15
	sbbq	8(%rdx), %r9
	sbbq	16(%rdx), %r14
	sbbq	24(%rdx), %r11
	sbbq	32(%rdx), %r10
	sbbq	40(%rdx), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	sbbq	48(%rdx), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	sbbq	56(%rdx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	sbbq	%rbx, %rbx
	movq	56(%r8), %rsi
	andq	%rbx, %rsi
	movq	48(%r8), %r12
	andq	%rbx, %r12
	movq	40(%r8), %r13
	andq	%rbx, %r13
	movq	32(%r8), %rbp
	andq	%rbx, %rbp
	movq	24(%r8), %rdx
	andq	%rbx, %rdx
	movq	16(%r8), %rcx
	andq	%rbx, %rcx
	movq	8(%r8), %rax
	andq	%rbx, %rax
	andq	(%r8), %rbx
	addq	%r15, %rbx
	adcq	%r9, %rax
	movq	%rbx, (%rdi)
	adcq	%r14, %rcx
	movq	%rax, 8(%rdi)
	movq	%rcx, 16(%rdi)
	adcq	%r11, %rdx
	movq	%rdx, 24(%rdi)
	adcq	%r10, %rbp
	movq	%rbp, 32(%rdi)
	adcq	-24(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r13, 40(%rdi)
	adcq	-16(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 48(%rdi)
	adcq	-8(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end59:
	.size	mcl_fp_sub8L, .Lfunc_end59-mcl_fp_sub8L
                                        # -- End function
	.globl	mcl_fp_subNF8L                  # -- Begin function mcl_fp_subNF8L
	.p2align	4
	.type	mcl_fp_subNF8L,@function
mcl_fp_subNF8L:                         # @mcl_fp_subNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r8
	movq	56(%rsi), %r10
	movq	48(%rsi), %rax
	movq	40(%rsi), %rcx
	movq	32(%rsi), %r15
	movq	24(%rsi), %r11
	movq	16(%rsi), %rbx
	movq	(%rsi), %r14
	movq	8(%rsi), %r9
	subq	(%rdx), %r14
	sbbq	8(%rdx), %r9
	sbbq	16(%rdx), %rbx
	sbbq	24(%rdx), %r11
	sbbq	32(%rdx), %r15
	movq	%r15, -24(%rsp)                 # 8-byte Spill
	sbbq	40(%rdx), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	sbbq	48(%rdx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	sbbq	56(%rdx), %r10
	movq	%r10, %r13
	sarq	$63, %r13
	movq	56(%r8), %rsi
	andq	%r13, %rsi
	movq	48(%r8), %r15
	andq	%r13, %r15
	movq	40(%r8), %r12
	andq	%r13, %r12
	movq	32(%r8), %rbp
	andq	%r13, %rbp
	movq	24(%r8), %rdx
	andq	%r13, %rdx
	movq	16(%r8), %rcx
	andq	%r13, %rcx
	movq	8(%r8), %rax
	andq	%r13, %rax
	andq	(%r8), %r13
	addq	%r14, %r13
	adcq	%r9, %rax
	movq	%r13, (%rdi)
	adcq	%rbx, %rcx
	movq	%rax, 8(%rdi)
	movq	%rcx, 16(%rdi)
	adcq	%r11, %rdx
	movq	%rdx, 24(%rdi)
	adcq	-24(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, 32(%rdi)
	adcq	-16(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 40(%rdi)
	adcq	-8(%rsp), %r15                  # 8-byte Folded Reload
	movq	%r15, 48(%rdi)
	adcq	%r10, %rsi
	movq	%rsi, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end60:
	.size	mcl_fp_subNF8L, .Lfunc_end60-mcl_fp_subNF8L
                                        # -- End function
	.globl	mcl_fpDbl_add8L                 # -- Begin function mcl_fpDbl_add8L
	.p2align	4
	.type	mcl_fpDbl_add8L,@function
mcl_fpDbl_add8L:                        # @mcl_fpDbl_add8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %rbx
	movq	120(%rdx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	112(%rdx), %r12
	movq	104(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	96(%rdx), %r9
	movq	88(%rdx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	80(%rdx), %rcx
	movq	72(%rdx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rax
	movq	8(%rdx), %r8
	addq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %r8
	movq	%r8, -16(%rsp)                  # 8-byte Spill
	movq	64(%rdx), %r13
	movq	56(%rdx), %r10
	movq	48(%rdx), %r15
	movq	40(%rdx), %r8
	movq	32(%rdx), %r14
	movq	24(%rdx), %rbp
	movq	16(%rdx), %r11
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %rbp
	adcq	32(%rsi), %r14
	adcq	40(%rsi), %r8
	adcq	48(%rsi), %r15
	adcq	56(%rsi), %r10
	adcq	64(%rsi), %r13
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	movq	-64(%rsp), %rdx                 # 8-byte Reload
	adcq	72(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	adcq	80(%rsi), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	adcq	88(%rsi), %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	adcq	96(%rsi), %r9
	movq	%r9, -48(%rsp)                  # 8-byte Spill
	movq	-72(%rsp), %r9                  # 8-byte Reload
	adcq	104(%rsi), %r9
	movq	%r9, -72(%rsp)                  # 8-byte Spill
	adcq	112(%rsi), %r12
	movq	%r12, -40(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %r12                 # 8-byte Reload
	adcq	120(%rsi), %r12
	movq	%r12, -56(%rsp)                 # 8-byte Spill
	movq	%r10, 56(%rdi)
	movq	%r15, 48(%rdi)
	movq	%r8, 40(%rdi)
	movq	%r14, 32(%rdi)
	movq	%rbp, 24(%rdi)
	movq	%r11, 16(%rdi)
	movq	-16(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, 8(%rdi)
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, (%rdi)
	setb	%r15b
	movq	%r13, %rsi
	subq	(%rbx), %rsi
	movq	%rdx, %r11
	sbbq	8(%rbx), %r11
	movq	%rax, %r8
	sbbq	16(%rbx), %r8
	movq	%rcx, %rax
	sbbq	24(%rbx), %rax
	movq	-48(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %r10
	sbbq	32(%rbx), %r10
	movq	%r9, %r12
	sbbq	40(%rbx), %r12
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, %r13
	sbbq	48(%rbx), %r13
	movq	-56(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rbp
	sbbq	56(%rbx), %rbp
	movzbl	%r15b, %ecx
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%rdx, %r13
	movq	%r13, 112(%rdi)
	cmovneq	%r9, %rbp
	movq	%rbp, 120(%rdi)
	cmovneq	%r14, %r10
	movq	%r10, 96(%rdi)
	cmovneq	-72(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 104(%rdi)
	cmovneq	-32(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r8, 80(%rdi)
	cmovneq	-80(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 88(%rdi)
	cmovneq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, 64(%rdi)
	cmovneq	-64(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end61:
	.size	mcl_fpDbl_add8L, .Lfunc_end61-mcl_fpDbl_add8L
                                        # -- End function
	.globl	mcl_fpDbl_sub8L                 # -- Begin function mcl_fpDbl_sub8L
	.p2align	4
	.type	mcl_fpDbl_sub8L,@function
mcl_fpDbl_sub8L:                        # @mcl_fpDbl_sub8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	120(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	112(%rsi), %r12
	movq	104(%rsi), %r15
	movq	96(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %r13
	movq	80(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rax
	movq	8(%rsi), %r8
	xorl	%r14d, %r14d
	subq	(%rdx), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	sbbq	8(%rdx), %r8
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %rbp
	movq	64(%rsi), %rax
	movq	56(%rsi), %r11
	movq	48(%rsi), %r10
	movq	40(%rsi), %r9
	movq	32(%rsi), %r8
	movq	24(%rsi), %rbx
	movq	16(%rsi), %rsi
	sbbq	16(%rdx), %rsi
	sbbq	24(%rdx), %rbx
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %r9
	sbbq	48(%rdx), %r10
	sbbq	56(%rdx), %r11
	sbbq	64(%rdx), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	sbbq	72(%rdx), %rbp
	movq	%rbp, -8(%rsp)                  # 8-byte Spill
	movq	-48(%rsp), %rbp                 # 8-byte Reload
	sbbq	80(%rdx), %rbp
	movq	%rbp, -48(%rsp)                 # 8-byte Spill
	sbbq	88(%rdx), %r13
	movq	%r13, %rbp
	movq	-40(%rsp), %r13                 # 8-byte Reload
	sbbq	96(%rdx), %r13
	movq	%r13, -40(%rsp)                 # 8-byte Spill
	sbbq	104(%rdx), %r15
	sbbq	112(%rdx), %r12
	movq	-56(%rsp), %rax                 # 8-byte Reload
	sbbq	120(%rdx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	%r11, 56(%rdi)
	movq	%r10, 48(%rdi)
	movq	%r9, 40(%rdi)
	movq	%r8, 32(%rdi)
	movq	%rbx, 24(%rdi)
	movq	%rsi, 16(%rdi)
	movq	-32(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 8(%rdi)
	movq	-24(%rsp), %rax                 # 8-byte Reload
	movq	%rax, (%rdi)
	sbbq	%r14, %r14
	movq	56(%rcx), %rdx
	andq	%r14, %rdx
	movq	48(%rcx), %rsi
	andq	%r14, %rsi
	movq	40(%rcx), %rax
	andq	%r14, %rax
	movq	32(%rcx), %r8
	andq	%r14, %r8
	movq	24(%rcx), %r9
	andq	%r14, %r9
	movq	16(%rcx), %r10
	andq	%r14, %r10
	movq	8(%rcx), %r11
	andq	%r14, %r11
	andq	(%rcx), %r14
	addq	-16(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-8(%rsp), %r11                  # 8-byte Folded Reload
	movq	%r14, 64(%rdi)
	adcq	-48(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r11, 72(%rdi)
	movq	%r10, 80(%rdi)
	adcq	%rbp, %r9
	movq	%r9, 88(%rdi)
	adcq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r8, 96(%rdi)
	adcq	%r15, %rax
	movq	%rax, 104(%rdi)
	adcq	%r12, %rsi
	movq	%rsi, 112(%rdi)
	adcq	-56(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 120(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end62:
	.size	mcl_fpDbl_sub8L, .Lfunc_end62-mcl_fpDbl_sub8L
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
