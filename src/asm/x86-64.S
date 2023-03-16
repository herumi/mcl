	.text
	.file	"base64.ll"
	.globl	makeNIST_P192L                  # -- Begin function makeNIST_P192L
	.p2align	4, 0x90
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_mod_NIST_P192L,@function
mcl_fpDbl_mod_NIST_P192L:               # @mcl_fpDbl_mod_NIST_P192L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	40(%rsi), %r8
	movq	24(%rsi), %r9
	movq	32(%rsi), %r10
	movq	(%rsi), %r11
	addq	%r9, %r11
	movq	8(%rsi), %r14
	adcq	%r10, %r14
	movq	16(%rsi), %rax
	adcq	%r8, %rax
	setb	%dl
	movzbl	%dl, %esi
	movq	%r8, %rbx
	shlq	$63, %rbx
	movq	%r8, %rdx
	shrq	%rdx
	shldq	$1, %rbx, %rdx
	addq	%r11, %rdx
	adcq	%r9, %r14
	adcq	%r10, %rax
	adcq	$0, %rsi
	addq	%r8, %r14
	adcq	$0, %rax
	setb	%r8b
	adcq	%rsi, %rdx
	adcq	$0, %r14
	adcq	$0, %rax
	setb	%bl
	movzbl	%bl, %r9d
	addb	$255, %r8b
	adcq	%rsi, %r14
	adcq	$0, %rax
	adcq	$0, %r9
	movq	%rdx, %rsi
	addq	$1, %rsi
	movq	%r14, %rbx
	adcq	$1, %rbx
	movq	%rax, %rcx
	adcq	$0, %rcx
	adcq	$-1, %r9
	testb	$1, %r9b
	cmovneq	%rax, %rcx
	movq	%rcx, 16(%rdi)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%r14, %rbx
	movq	%rbx, 8(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end1:
	.size	mcl_fpDbl_mod_NIST_P192L, .Lfunc_end1-mcl_fpDbl_mod_NIST_P192L
                                        # -- End function
	.globl	mcl_fp_sqr_NIST_P192L           # -- Begin function mcl_fp_sqr_NIST_P192L
	.p2align	4, 0x90
	.type	mcl_fp_sqr_NIST_P192L,@function
mcl_fp_sqr_NIST_P192L:                  # @mcl_fp_sqr_NIST_P192L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -56(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %rcx
	movq	%r11, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %r15
	addq	%rdx, %r13
	adcq	%r14, %r12
	movq	%rdi, %r10
	adcq	$0, %r10
	movq	%r11, %rax
	mulq	%rbx
	movq	%rdx, %rsi
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %r9
	movq	%rdx, %r8
	addq	%rbp, %r8
	adcq	%rcx, %r15
	movq	%rsi, %rbx
	adcq	$0, %rbx
	addq	%rbp, %r8
	adcq	%r13, %r15
	adcq	%r12, %rbx
	adcq	$0, %r10
	movq	%r11, %rax
	mulq	%r11
	addq	%r14, %rsi
	adcq	%rdi, %rax
	adcq	$0, %rdx
	addq	%rcx, %r15
	adcq	%rbx, %rsi
	adcq	%r10, %rax
	adcq	$0, %rdx
	movq	%rsi, %rdi
	addq	%r9, %rdi
	movq	%rax, %rbx
	adcq	%r8, %rbx
	movq	%rdx, %rbp
	adcq	%r15, %rbp
	setb	%cl
	movzbl	%cl, %r11d
	movq	%rdx, %rcx
	shlq	$63, %rcx
	movq	%rdx, %r10
	shrq	%r10
	shldq	$1, %rcx, %r10
	addq	%rdi, %r10
	adcq	%rsi, %rbx
	adcq	%rax, %rbp
	adcq	$0, %r11
	addq	%rdx, %rbx
	adcq	$0, %rbp
	setb	%cl
	adcq	%r11, %r10
	adcq	$0, %rbx
	adcq	$0, %rbp
	setb	%dil
	movq	%r9, -48(%rsp)
	movq	%r8, -40(%rsp)
	movq	%r15, -32(%rsp)
	movq	%rsi, -24(%rsp)
	movq	%rax, -16(%rsp)
	movq	%rdx, -8(%rsp)
	movzbl	%dil, %eax
	addb	$255, %cl
	adcq	%r11, %rbx
	adcq	$0, %rbp
	adcq	$0, %rax
	movq	%r10, %rcx
	addq	$1, %rcx
	movq	%rbx, %rdx
	adcq	$1, %rdx
	movq	%rbp, %rsi
	adcq	$0, %rsi
	adcq	$-1, %rax
	testb	$1, %al
	cmovneq	%rbx, %rdx
	movq	-56(%rsp), %rax                 # 8-byte Reload
	movq	%rdx, 8(%rax)
	cmovneq	%r10, %rcx
	movq	%rcx, (%rax)
	cmovneq	%rbp, %rsi
	movq	%rsi, 16(%rax)
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
	.p2align	4, 0x90
	.type	mcl_fp_mulNIST_P192L,@function
mcl_fp_mulNIST_P192L:                   # @mcl_fp_mulNIST_P192L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	subq	$56, %rsp
	movq	%rdi, %r14
	leaq	8(%rsp), %rdi
	callq	mcl_fpDbl_mulPre3L@PLT
	movq	48(%rsp), %rsi
	movq	32(%rsp), %r9
	movq	40(%rsp), %r8
	movq	8(%rsp), %rbx
	addq	%r9, %rbx
	movq	16(%rsp), %rax
	adcq	%r8, %rax
	movq	24(%rsp), %rdi
	adcq	%rsi, %rdi
	setb	%dl
	movzbl	%dl, %r10d
	movq	%rsi, %rcx
	shlq	$63, %rcx
	movq	%rsi, %rdx
	shrq	%rdx
	shldq	$1, %rcx, %rdx
	addq	%rbx, %rdx
	adcq	%r9, %rax
	adcq	%r8, %rdi
	adcq	$0, %r10
	addq	%rsi, %rax
	adcq	$0, %rdi
	setb	%sil
	adcq	%r10, %rdx
	adcq	$0, %rax
	adcq	$0, %rdi
	setb	%bl
	movzbl	%bl, %r8d
	addb	$255, %sil
	adcq	%r10, %rax
	adcq	$0, %rdi
	adcq	$0, %r8
	movq	%rdx, %rsi
	addq	$1, %rsi
	movq	%rax, %rbx
	adcq	$1, %rbx
	movq	%rdi, %rcx
	adcq	$0, %rcx
	adcq	$-1, %r8
	testb	$1, %r8b
	cmovneq	%rdi, %rcx
	movq	%rcx, 16(%r14)
	cmovneq	%rdx, %rsi
	movq	%rsi, (%r14)
	cmovneq	%rax, %rbx
	movq	%rbx, 8(%r14)
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end3:
	.size	mcl_fp_mulNIST_P192L, .Lfunc_end3-mcl_fp_mulNIST_P192L
                                        # -- End function
	.globl	mcl_fpDbl_mod_NIST_P521L        # -- Begin function mcl_fpDbl_mod_NIST_P521L
	.p2align	4, 0x90
	.type	mcl_fpDbl_mod_NIST_P521L,@function
mcl_fpDbl_mod_NIST_P521L:               # @mcl_fpDbl_mod_NIST_P521L
# %bb.0:
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
	movl	%ebx, %edx
	andl	$511, %edx                      # imm = 0x1FF
	addq	(%rsi), %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r12
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r10
	adcq	48(%rsi), %r9
	adcq	56(%rsi), %r8
	adcq	%r14, %rdx
	movl	%edx, %esi
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
	adcq	$0, %rdx
	movq	%r12, %rax
	andq	%r11, %rax
	andq	%r15, %rax
	andq	%r10, %rax
	andq	%r9, %rax
	andq	%r8, %rax
	andq	%rsi, %rax
	movq	%rdx, %rbx
	orq	$-512, %rbx                     # imm = 0xFE00
	andq	%rax, %rbx
	andq	%rcx, %rbx
	cmpq	$-1, %rbx
	je	.LBB4_1
# %bb.2:                                # %nonzero
	movq	%rsi, (%rdi)
	movq	%rcx, 8(%rdi)
	movq	%r12, 16(%rdi)
	movq	%r15, 24(%rdi)
	movq	%r11, 32(%rdi)
	movq	%r10, 40(%rdi)
	movq	%r9, 48(%rdi)
	movq	%r8, 56(%rdi)
	andl	$511, %edx                      # imm = 0x1FF
	movq	%rdx, 64(%rdi)
	jmp	.LBB4_3
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
.LBB4_3:                                # %common.ret
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end4:
	.size	mcl_fpDbl_mod_NIST_P521L, .Lfunc_end4-mcl_fpDbl_mod_NIST_P521L
                                        # -- End function
	.globl	mulPv192x64                     # -- Begin function mulPv192x64
	.p2align	4, 0x90
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_mulPre3L,@function
mcl_fpDbl_mulPre3L:                     # @mcl_fpDbl_mulPre3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r11
	movq	(%rsi), %r8
	movq	8(%rsi), %r10
	movq	(%rdx), %rcx
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %r12
	movq	%rax, (%rdi)
	movq	%r12, %rax
	mulq	%rcx
	movq	%rdx, %r9
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rax, %rbx
	movq	%rdx, %rcx
	movq	8(%r11), %rsi
	movq	%rsi, %rax
	mulq	%r12
	movq	%rdx, %r13
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, %r14
	movq	%rax, %r15
	movq	%rsi, %rax
	mulq	%r8
	addq	%r15, %rdx
	adcq	%rbp, %r14
	adcq	$0, %r13
	addq	-8(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	-16(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	$0, %r9
	addq	%rax, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%rdx, %rcx
	adcq	%r14, %r9
	adcq	$0, %r13
	movq	16(%r11), %rsi
	movq	%rsi, %rax
	mulq	%r12
	movq	%rdx, %rbp
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	%r10
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	%rsi, %rax
	mulq	%r8
	addq	%r10, %rdx
	adcq	%r11, %rbx
	adcq	$0, %rbp
	addq	%rcx, %rax
	movq	%rax, 16(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	adcq	%r13, %rbx
	movq	%rbx, 32(%rdi)
	adcq	$0, %rbp
	movq	%rbp, 40(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_sqrPre3L,@function
mcl_fpDbl_sqrPre3L:                     # @mcl_fpDbl_sqrPre3L
# %bb.0:
	pushq	%rbp
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
	movq	%rdx, %r11
	movq	%rax, (%rdi)
	movq	%r10, %rax
	mulq	%rsi
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, %r13
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rax, %r15
	movq	%rdx, %rsi
	addq	%rdx, %r13
	adcq	%r9, %r14
	movq	%r8, %rbx
	adcq	$0, %rbx
	movq	%r10, %rax
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, %rcx
	addq	%r15, %r11
	adcq	%rax, %rsi
	movq	%rdx, %rbp
	adcq	$0, %rbp
	addq	%r15, %r11
	movq	%r11, 8(%rdi)
	adcq	%r13, %rsi
	adcq	%r14, %rbp
	adcq	$0, %rbx
	movq	%r10, %rax
	mulq	%r10
	addq	%r9, %rcx
	adcq	%r8, %rax
	adcq	$0, %rdx
	addq	%r12, %rsi
	movq	%rsi, 16(%rdi)
	adcq	%rbp, %rcx
	movq	%rcx, 24(%rdi)
	adcq	%rbx, %rax
	movq	%rax, 32(%rdi)
	adcq	$0, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end7:
	.size	mcl_fpDbl_sqrPre3L, .Lfunc_end7-mcl_fpDbl_sqrPre3L
                                        # -- End function
	.globl	mcl_fp_mont3L                   # -- Begin function mcl_fp_mont3L
	.p2align	4, 0x90
	.type	mcl_fp_mont3L,@function
mcl_fp_mont3L:                          # @mcl_fp_mont3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %r10
	movq	(%rdx), %rdi
	movq	%rdx, %r11
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%rdi
	movq	%rax, %rbp
	movq	%rdx, %r15
	movq	(%rsi), %rbx
	movq	%rbx, -16(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r14
	movq	%r14, %rax
	movq	%r14, -72(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r8
	movq	%rax, %rsi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rax, %r12
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%rbp, %r8
	adcq	$0, %r15
	movq	-8(%rcx), %rbp
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	imulq	%rax, %rbp
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r13
	movq	%rdx, %r9
	movq	(%rcx), %rbx
	movq	%rbx, -48(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rcx
	movq	%rdx, %rsi
	movq	%rax, %rcx
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rdx, %rbp
	addq	%rcx, %rbp
	adcq	%r13, %rsi
	adcq	$0, %r9
	addq	%r12, %rax
	adcq	%rdi, %rbp
	movq	8(%r11), %rcx
	adcq	%r8, %rsi
	adcq	%r15, %r9
	setb	%r11b
	movq	%rcx, %rax
	mulq	%r10
	movq	%rdx, %r15
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	%r14
	movq	%rdx, %r13
	movq	%rax, %r8
	movq	%rcx, %rax
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	mulq	%rcx
	movq	%rax, %r12
	movq	%rdx, %rbx
	addq	%r8, %rbx
	adcq	%rdi, %r13
	adcq	$0, %r15
	addq	%rbp, %r12
	adcq	%rsi, %rbx
	movzbl	%r11b, %eax
	adcq	%r9, %r13
	adcq	%rax, %r15
	setb	-73(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rsi                 # 8-byte Reload
	imulq	%r12, %rsi
	movq	%rsi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %rsi
	movq	-64(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %r9
	movq	%r9, %rax
	mulq	%r10
	movq	%rdx, %r8
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rdx, %r10
	addq	%rdi, %rbp
	adcq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	$0, %r14
	addq	%r12, %r11
	adcq	%rbx, %rbp
	adcq	%r13, %rsi
	adcq	%r15, %r14
	movzbl	-73(%rsp), %edi                 # 1-byte Folded Reload
	adcq	$0, %rdi
	movq	%r9, %rax
	mulq	%rcx
	movq	%rax, %r9
	movq	%rdx, %rcx
	addq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r10                 # 8-byte Folded Reload
	adcq	$0, %r8
	addq	%rbp, %r9
	adcq	%rsi, %rcx
	adcq	%r14, %r10
	adcq	%rdi, %r8
	setb	%r11b
	movq	-32(%rsp), %rsi                 # 8-byte Reload
	imulq	%r9, %rsi
	movq	%rsi, %rax
	movq	-56(%rsp), %r14                 # 8-byte Reload
	mulq	%r14
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rsi, %rax
	movq	-40(%rsp), %r15                 # 8-byte Reload
	mulq	%r15
	movq	%rdx, %rbp
	movq	%rax, %rdi
	movq	%rsi, %rax
	movq	-48(%rsp), %rsi                 # 8-byte Reload
	mulq	%rsi
	addq	%rdi, %rdx
	adcq	%r12, %rbp
	adcq	$0, %rbx
	addq	%r9, %rax
	adcq	%rcx, %rdx
	adcq	%r10, %rbp
	movzbl	%r11b, %eax
	adcq	%r8, %rbx
	adcq	$0, %rax
	movq	%rdx, %rdi
	subq	%rsi, %rdi
	movq	%rbp, %rcx
	sbbq	%r15, %rcx
	movq	%rbx, %rsi
	sbbq	%r14, %rsi
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rbx, %rsi
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rsi, 16(%rax)
	cmovneq	%rdx, %rdi
	movq	%rdi, (%rax)
	cmovneq	%rbp, %rcx
	movq	%rcx, 8(%rax)
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
	.p2align	4, 0x90
	.type	mcl_fp_montNF3L,@function
mcl_fp_montNF3L:                        # @mcl_fp_montNF3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rbx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	(%rsi), %rbp
	movq	%rbp, -56(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	%rbx
	movq	%rax, %r13
	movq	%rdx, %rbx
	addq	%rsi, %rbx
	adcq	%r14, %rdi
	adcq	$0, %r15
	movq	-8(%rcx), %r14
	movq	%r14, %rbp
	imulq	%rax, %rbp
	movq	16(%rcx), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r12
	movq	%rdx, %r8
	movq	(%rcx), %rsi
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %r11
	movq	%rbp, %rax
	mulq	%r11
	movq	%r11, -32(%rsp)                 # 8-byte Spill
	movq	%rdx, %r9
	movq	%rax, %rcx
	movq	%rbp, %rax
	mulq	%rsi
	addq	%r13, %rax
	adcq	%rbx, %rcx
	adcq	%rdi, %r12
	adcq	$0, %r15
	addq	%rdx, %rcx
	movq	8(%r10), %rbx
	adcq	%r9, %r12
	adcq	%r8, %r15
	movq	%rbx, %rax
	movq	-40(%rsp), %r10                 # 8-byte Reload
	mulq	%r10
	movq	%rdx, %rsi
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r9
	movq	%rbx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbp
	movq	%rdx, %rbx
	addq	%r9, %rbx
	adcq	%r8, %r13
	adcq	$0, %rsi
	addq	%rcx, %rbp
	adcq	%r12, %rbx
	adcq	%r15, %r13
	adcq	$0, %rsi
	movq	%r14, %rcx
	imulq	%rbp, %rcx
	movq	%rcx, %rax
	movq	-24(%rsp), %rdi                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %r8
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	%r11
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%rcx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%rbx, %r12
	adcq	%r13, %r15
	adcq	$0, %rsi
	addq	%rdx, %r12
	adcq	%r9, %r15
	adcq	%r8, %rsi
	movq	-16(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rcx, %rax
	mulq	%r10
	movq	%rdx, %rbp
	movq	%rax, %r10
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%rdx, %r9
	addq	%r11, %r9
	adcq	%r10, %r8
	adcq	$0, %rbp
	addq	%r12, %rbx
	adcq	%r15, %r9
	adcq	%rsi, %r8
	adcq	$0, %rbp
	imulq	%rbx, %r14
	movq	%r14, %rax
	movq	%rdi, %r15
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %rsi
	movq	%r14, %rax
	movq	-32(%rsp), %r12                 # 8-byte Reload
	mulq	%r12
	movq	%rdx, %r11
	movq	%rax, %rcx
	movq	%r14, %rax
	movq	-48(%rsp), %rdi                 # 8-byte Reload
	mulq	%rdi
	addq	%rbx, %rax
	adcq	%r9, %rcx
	adcq	%r8, %rsi
	adcq	$0, %rbp
	addq	%rdx, %rcx
	adcq	%r11, %rsi
	adcq	%r10, %rbp
	movq	%rcx, %rax
	subq	%rdi, %rax
	movq	%rsi, %rdx
	sbbq	%r12, %rdx
	movq	%rbp, %rbx
	sbbq	%r15, %rbx
	movq	%rbx, %rdi
	sarq	$63, %rdi
	cmovsq	%rbp, %rbx
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rbx, 16(%rdi)
	cmovsq	%rcx, %rax
	movq	%rax, (%rdi)
	cmovsq	%rsi, %rdx
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
	.p2align	4, 0x90
	.type	mcl_fp_montRed3L,@function
mcl_fp_montRed3L:                       # @mcl_fp_montRed3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r8
	movq	-8(%rdx), %r14
	movq	(%rdx), %rdi
	movq	%r14, %rbp
	imulq	%r8, %rbp
	movq	16(%rdx), %r9
	movq	%r9, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r11
	movq	8(%rcx), %r10
	movq	%r10, %rax
	movq	%r10, -24(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %r15
	movq	%rax, %rbx
	movq	%rdi, %rax
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rcx
	addq	%rbx, %rcx
	adcq	%r12, %r15
	adcq	$0, %r11
	addq	%r8, %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %r11
	setb	-25(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rbx
	imulq	%rcx, %rbx
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, %r8
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	%r10, %rax
	mulq	%rbx
	movq	%rdx, %r12
	movq	%rax, %rbx
	addq	%r13, %rbx
	adcq	%rbp, %r12
	movzbl	-25(%rsp), %r13d                # 1-byte Folded Reload
	adcq	%r8, %r13
	addq	%rcx, %rdi
	adcq	%r15, %rbx
	adcq	%r11, %r12
	adcq	32(%rsi), %r13
	setb	%dil
	imulq	%rbx, %r14
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	-16(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, %r11
	movq	%rax, %r15
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rax
	mulq	%r14
	addq	%r11, %rax
	adcq	%r8, %rdx
	movzbl	%dil, %edi
	adcq	%rdi, %rbp
	addq	%rbx, %r15
	adcq	%r12, %rax
	adcq	%r13, %rdx
	adcq	40(%rsi), %rbp
	setb	%bl
	movq	%rax, %rsi
	subq	%r10, %rsi
	movq	%rdx, %rdi
	sbbq	%rcx, %rdi
	movq	%rbp, %rcx
	sbbq	%r9, %rcx
	movzbl	%bl, %ebx
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%rbp, %rcx
	movq	-8(%rsp), %rbp                  # 8-byte Reload
	movq	%rcx, 16(%rbp)
	cmovneq	%rax, %rsi
	movq	%rsi, (%rbp)
	cmovneq	%rdx, %rdi
	movq	%rdi, 8(%rbp)
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
	.p2align	4, 0x90
	.type	mcl_fp_montRedNF3L,@function
mcl_fp_montRedNF3L:                     # @mcl_fp_montRedNF3L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r8
	movq	-8(%rdx), %r14
	movq	(%rdx), %rdi
	movq	%r14, %rbp
	imulq	%r8, %rbp
	movq	16(%rdx), %r9
	movq	%r9, %rax
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %r11
	movq	8(%rcx), %r10
	movq	%r10, %rax
	mulq	%rbp
	movq	%rdx, %r15
	movq	%rax, %rbx
	movq	%rdi, %rax
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rcx
	addq	%rbx, %rcx
	adcq	%r12, %r15
	adcq	$0, %r11
	addq	%r8, %rax
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %r11
	setb	-17(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rbx
	imulq	%rcx, %rbx
	movq	%rbx, %rax
	mulq	%r9
	movq	%rdx, %r8
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	%rbx
	movq	%rdx, %r13
	movq	%rax, %rdi
	movq	%r10, %rax
	mulq	%rbx
	movq	%rdx, %r12
	movq	%rax, %rbx
	addq	%r13, %rbx
	adcq	%rbp, %r12
	movzbl	-17(%rsp), %r13d                # 1-byte Folded Reload
	adcq	%r8, %r13
	addq	%rcx, %rdi
	adcq	%r15, %rbx
	adcq	%r11, %r12
	adcq	32(%rsi), %r13
	setb	%dil
	imulq	%rbx, %r14
	movq	%r14, %rax
	mulq	%r9
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rax
	mulq	%r14
	movq	%rdx, %r11
	movq	%rax, %r15
	movq	%r10, %rax
	mulq	%r14
	addq	%r11, %rax
	adcq	%r8, %rdx
	movzbl	%dil, %edi
	adcq	%rdi, %rbp
	addq	%rbx, %r15
	adcq	%r12, %rax
	adcq	%r13, %rdx
	adcq	40(%rsi), %rbp
	movq	%rax, %rsi
	subq	%rcx, %rsi
	movq	%rdx, %rdi
	sbbq	%r10, %rdi
	movq	%rbp, %rbx
	sbbq	%r9, %rbx
	movq	%rbx, %rcx
	sarq	$63, %rcx
	cmovsq	%rbp, %rbx
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%rbx, 16(%rcx)
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
.Lfunc_end11:
	.size	mcl_fp_montRedNF3L, .Lfunc_end11-mcl_fp_montRedNF3L
                                        # -- End function
	.globl	mcl_fp_addPre3L                 # -- Begin function mcl_fp_addPre3L
	.p2align	4, 0x90
	.type	mcl_fp_addPre3L,@function
mcl_fp_addPre3L:                        # @mcl_fp_addPre3L
# %bb.0:
	movq	16(%rdx), %rax
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	movq	%rax, 16(%rdi)
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	setb	%al
	movzbl	%al, %eax
	retq
.Lfunc_end12:
	.size	mcl_fp_addPre3L, .Lfunc_end12-mcl_fp_addPre3L
                                        # -- End function
	.globl	mcl_fp_subPre3L                 # -- Begin function mcl_fp_subPre3L
	.p2align	4, 0x90
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
	.p2align	4, 0x90
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
	.p2align	4, 0x90
	.type	mcl_fp_add3L,@function
mcl_fp_add3L:                           # @mcl_fp_add3L
# %bb.0:
	movq	16(%rdx), %r10
	movq	(%rdx), %r8
	movq	8(%rdx), %r9
	addq	(%rsi), %r8
	adcq	8(%rsi), %r9
	adcq	16(%rsi), %r10
	setb	%dl
	movzbl	%dl, %r11d
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%r9, %rax
	sbbq	8(%rcx), %rax
	movq	%r10, %rdx
	sbbq	16(%rcx), %rdx
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%r10, %rdx
	movq	%rdx, 16(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%r9, %rax
	movq	%rax, 8(%rdi)
	retq
.Lfunc_end15:
	.size	mcl_fp_add3L, .Lfunc_end15-mcl_fp_add3L
                                        # -- End function
	.globl	mcl_fp_addNF3L                  # -- Begin function mcl_fp_addNF3L
	.p2align	4, 0x90
	.type	mcl_fp_addNF3L,@function
mcl_fp_addNF3L:                         # @mcl_fp_addNF3L
# %bb.0:
	movq	16(%rdx), %r10
	movq	(%rdx), %r8
	movq	8(%rdx), %r9
	addq	(%rsi), %r8
	adcq	8(%rsi), %r9
	adcq	16(%rsi), %r10
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%r9, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %rax
	sbbq	16(%rcx), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	cmovsq	%r10, %rax
	movq	%rax, 16(%rdi)
	cmovsq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r9, %rdx
	movq	%rdx, 8(%rdi)
	retq
.Lfunc_end16:
	.size	mcl_fp_addNF3L, .Lfunc_end16-mcl_fp_addNF3L
                                        # -- End function
	.globl	mcl_fp_sub3L                    # -- Begin function mcl_fp_sub3L
	.p2align	4, 0x90
	.type	mcl_fp_sub3L,@function
mcl_fp_sub3L:                           # @mcl_fp_sub3L
# %bb.0:
	xorl	%r9d, %r9d
	movq	16(%rsi), %r8
	movq	(%rsi), %rax
	movq	8(%rsi), %r10
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r10
	sbbq	16(%rdx), %r8
	movl	$0, %edx
	sbbq	%rdx, %rdx
	andl	$1, %edx
	negq	%rdx
	movl	$0, %edx
	movl	$0, %esi
	jns	.LBB17_2
# %bb.1:
	movq	16(%rcx), %r9
	movq	8(%rcx), %rdx
	movq	(%rcx), %rsi
.LBB17_2:
	addq	%rax, %rsi
	movq	%rsi, (%rdi)
	adcq	%r10, %rdx
	movq	%rdx, 8(%rdi)
	adcq	%r8, %r9
	movq	%r9, 16(%rdi)
	retq
.Lfunc_end17:
	.size	mcl_fp_sub3L, .Lfunc_end17-mcl_fp_sub3L
                                        # -- End function
	.globl	mcl_fp_subNF3L                  # -- Begin function mcl_fp_subNF3L
	.p2align	4, 0x90
	.type	mcl_fp_subNF3L,@function
mcl_fp_subNF3L:                         # @mcl_fp_subNF3L
# %bb.0:
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
.Lfunc_end18:
	.size	mcl_fp_subNF3L, .Lfunc_end18-mcl_fp_subNF3L
                                        # -- End function
	.globl	mcl_fpDbl_add3L                 # -- Begin function mcl_fpDbl_add3L
	.p2align	4, 0x90
	.type	mcl_fpDbl_add3L,@function
mcl_fpDbl_add3L:                        # @mcl_fpDbl_add3L
# %bb.0:
	movq	40(%rdx), %r10
	movq	32(%rdx), %r8
	movq	24(%rdx), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %r8
	adcq	40(%rsi), %r10
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r11, 16(%rdi)
	setb	%al
	movzbl	%al, %r11d
	movq	%r9, %rdx
	subq	(%rcx), %rdx
	movq	%r8, %rsi
	sbbq	8(%rcx), %rsi
	movq	%r10, %rax
	sbbq	16(%rcx), %rax
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%r10, %rax
	movq	%rax, 40(%rdi)
	cmovneq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, 32(%rdi)
	retq
.Lfunc_end19:
	.size	mcl_fpDbl_add3L, .Lfunc_end19-mcl_fpDbl_add3L
                                        # -- End function
	.globl	mcl_fpDbl_sub3L                 # -- Begin function mcl_fpDbl_sub3L
	.p2align	4, 0x90
	.type	mcl_fpDbl_sub3L,@function
mcl_fpDbl_sub3L:                        # @mcl_fpDbl_sub3L
# %bb.0:
	pushq	%rbx
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rax
	movq	8(%rsi), %rbx
	xorl	%esi, %esi
	subq	(%rdx), %rax
	sbbq	8(%rdx), %rbx
	sbbq	16(%rdx), %r11
	sbbq	24(%rdx), %r10
	sbbq	32(%rdx), %r9
	sbbq	40(%rdx), %r8
	movq	%rax, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%r11, 16(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	negq	%rsi
	movq	16(%rcx), %rax
	andq	%rsi, %rax
	movq	8(%rcx), %rdx
	andq	%rsi, %rdx
	andq	(%rcx), %rsi
	addq	%r10, %rsi
	movq	%rsi, 24(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 32(%rdi)
	adcq	%r8, %rax
	movq	%rax, 40(%rdi)
	popq	%rbx
	retq
.Lfunc_end20:
	.size	mcl_fpDbl_sub3L, .Lfunc_end20-mcl_fpDbl_sub3L
                                        # -- End function
	.globl	mulPv256x64                     # -- Begin function mulPv256x64
	.p2align	4, 0x90
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
	.p2align	4, 0x90
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
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r8
	movq	16(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r12
	movq	%rdx, %r9
	movq	(%rsi), %rbx
	movq	%rbx, -56(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %rbp
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, %r15
	addq	%rbp, %r15
	adcq	%r12, %r10
	adcq	%r14, %r9
	adcq	$0, %r8
	movq	-8(%rcx), %rdi
	movq	%rdi, -80(%rsp)                 # 8-byte Spill
	imulq	%rax, %rdi
	movq	24(%rcx), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r12
	movq	%rdx, %r13
	movq	16(%rcx), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, %rbx
	movq	(%rcx), %rsi
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	%rcx
	movq	%rdx, %rbp
	movq	%rax, %rcx
	movq	%rdi, %rax
	mulq	%rsi
	movq	%rdx, %rdi
	addq	%rcx, %rdi
	adcq	%r14, %rbp
	adcq	%r12, %rbx
	adcq	$0, %r13
	addq	%r11, %rax
	adcq	%r15, %rdi
	adcq	%r10, %rbp
	adcq	%r9, %rbx
	adcq	%r8, %r13
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rcx
	movq	%rcx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r9
	addq	%r15, %r9
	adcq	%r11, %rsi
	adcq	%r8, %r14
	adcq	$0, %r12
	addq	%rdi, %r10
	adcq	%rbp, %r9
	adcq	%rbx, %rsi
	adcq	%r13, %r14
	movzbl	-96(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r12
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%r10, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rbp
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%rcx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%rdi, %r11
	adcq	%rbp, %r8
	adcq	%r15, %rbx
	adcq	$0, %r13
	addq	%r10, %rax
	adcq	%r9, %r11
	adcq	%rsi, %r8
	adcq	%r14, %rbx
	adcq	%r12, %r13
	movzbl	-96(%rsp), %r14d                # 1-byte Folded Reload
	adcq	$0, %r14
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rcx
	movq	%rcx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%r15, %rbp
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	adcq	$0, %r12
	addq	%r11, %r9
	adcq	%r8, %rdi
	adcq	%rbx, %rbp
	adcq	%r13, %r10
	adcq	%r14, %r12
	setb	%r15b
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%r9, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rcx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	addq	%r14, %rcx
	adcq	%r11, %rsi
	adcq	%r8, %rbx
	adcq	$0, %r13
	addq	%r9, %rax
	adcq	%rdi, %rcx
	adcq	%rbp, %rsi
	adcq	%r10, %rbx
	adcq	%r12, %r13
	movzbl	%r15b, %r12d
	adcq	$0, %r12
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdi
	movq	%rdi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %rdi
	addq	%r15, %rdi
	adcq	%r14, %rbp
	adcq	%r11, %r9
	adcq	$0, %r8
	addq	%rcx, %r10
	adcq	%rsi, %rdi
	adcq	%rbx, %rbp
	adcq	%r13, %r9
	adcq	%r12, %r8
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %r11                 # 8-byte Reload
	imulq	%r10, %r11
	movq	%r11, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r11, %rax
	movq	-16(%rsp), %r12                 # 8-byte Reload
	mulq	%r12
	movq	%rdx, %rcx
	movq	%rax, %rbx
	movq	%r11, %rax
	movq	-32(%rsp), %r14                 # 8-byte Reload
	mulq	%r14
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	%r11, %rax
	movq	-24(%rsp), %r11                 # 8-byte Reload
	mulq	%r11
	addq	%r15, %rdx
	adcq	%rbx, %rsi
	adcq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	$0, %r13
	addq	%r10, %rax
	adcq	%rdi, %rdx
	adcq	%rbp, %rsi
	adcq	%r9, %rcx
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%r8, %r13
	adcq	$0, %rax
	movq	%rdx, %r8
	subq	%r11, %r8
	movq	%rsi, %rbx
	sbbq	%r14, %rbx
	movq	%rcx, %rbp
	sbbq	%r12, %rbp
	movq	%r13, %rdi
	sbbq	-72(%rsp), %rdi                 # 8-byte Folded Reload
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rcx, %rbp
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rbp, 16(%rax)
	cmovneq	%rsi, %rbx
	movq	%rbx, 8(%rax)
	cmovneq	%r13, %rdi
	movq	%rdi, 24(%rax)
	cmovneq	%rdx, %r8
	movq	%r8, (%rax)
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
	.p2align	4, 0x90
	.type	mcl_fp_montNF4L,@function
mcl_fp_montNF4L:                        # @mcl_fp_montNF4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r14
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rbx
	mulq	%rbx
	movq	%rax, %r10
	movq	%rdx, %r15
	movq	16(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %rbp
	movq	%rdx, %r9
	movq	(%rsi), %r13
	movq	8(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, %rsi
	movq	%r13, %rax
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %rbx
	addq	%rsi, %rbx
	adcq	%rbp, %rdi
	adcq	%r10, %r9
	adcq	$0, %r15
	movq	-8(%rcx), %rsi
	movq	%rsi, -64(%rsp)                 # 8-byte Spill
	imulq	%rax, %rsi
	movq	24(%rcx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulq	%rsi
	movq	%rax, %rbp
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	16(%rcx), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rsi
	movq	%rax, %r10
	movq	%rdx, %r12
	movq	(%rcx), %rcx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	movq	8(%r14), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulq	%rsi
	movq	%rdx, %r11
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	%rsi
	addq	%r8, %rax
	adcq	%rbx, %r14
	adcq	%rdi, %r10
	adcq	%r9, %rbp
	adcq	$0, %r15
	addq	%rdx, %r14
	adcq	%r11, %r10
	adcq	%r12, %rbp
	adcq	-16(%rsp), %r15                 # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rsi
	movq	-88(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbx
	movq	%rax, %rdi
	movq	-96(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r11
	movq	%rax, %r12
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%r13, %rax
	mulq	%rsi
	movq	%rax, %r8
	movq	%rdx, %rsi
	addq	%r9, %rsi
	adcq	%r12, %rcx
	adcq	%rdi, %r11
	adcq	$0, %rbx
	addq	%r14, %r8
	adcq	%r10, %rsi
	adcq	%rbp, %rcx
	adcq	%r15, %r11
	adcq	$0, %rbx
	movq	-64(%rsp), %rdi                 # 8-byte Reload
	imulq	%r8, %rdi
	movq	%rdi, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%rdi, %rax
	movq	-32(%rsp), %r13                 # 8-byte Reload
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%rdi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	addq	%r8, %rax
	adcq	%rsi, %rbp
	adcq	%rcx, %r14
	adcq	%r11, %r10
	adcq	$0, %rbx
	addq	%rdx, %rbp
	adcq	%r12, %r14
	adcq	%r9, %r10
	adcq	%r15, %rbx
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rdi
	movq	%rdi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r9
	movq	%rdi, %rax
	mulq	-96(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %rdi
	addq	%r12, %rdi
	adcq	%r11, %rsi
	adcq	%r9, %r15
	adcq	$0, %rcx
	addq	%rbp, %r8
	adcq	%r14, %rdi
	adcq	%r10, %rsi
	adcq	%rbx, %r15
	adcq	$0, %rcx
	movq	-64(%rsp), %rbx                 # 8-byte Reload
	imulq	%r8, %rbx
	movq	%rbx, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	%r13
	movq	%rdx, %r12
	movq	%rax, %rbp
	movq	%rbx, %rax
	movq	-40(%rsp), %r13                 # 8-byte Reload
	mulq	%r13
	addq	%r8, %rax
	adcq	%rdi, %rbp
	adcq	%rsi, %r14
	adcq	%r15, %r10
	adcq	$0, %rcx
	addq	%rdx, %rbp
	adcq	%r12, %r14
	adcq	%r11, %r10
	adcq	%r9, %rcx
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdi
	movq	%rdi, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	-96(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r11
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rax, %r8
	movq	%rdx, %rdi
	addq	%r12, %rdi
	adcq	%r11, %r9
	adcq	%rsi, %r15
	adcq	$0, %rbx
	addq	%rbp, %r8
	adcq	%r14, %rdi
	adcq	%r10, %r9
	adcq	%rcx, %r15
	adcq	$0, %rbx
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	imulq	%r8, %rcx
	movq	-80(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, %r12
	movq	-48(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rax
	mulq	%rcx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %rbp
	movq	%r13, %r11
	movq	%r13, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	-32(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%rcx
	addq	%r8, %rsi
	adcq	%rdi, %rax
	adcq	%r9, %rbp
	adcq	%r15, %r12
	adcq	$0, %rbx
	addq	%r13, %rax
	adcq	%rdx, %rbp
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rax, %r8
	subq	%r11, %r8
	movq	%rbp, %rsi
	sbbq	%r10, %rsi
	movq	%r12, %rdi
	sbbq	%r14, %rdi
	movq	%rbx, %rcx
	sbbq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	cmovsq	%r12, %rdi
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%rdi, 16(%rdx)
	cmovsq	%rbp, %rsi
	movq	%rsi, 8(%rdx)
	cmovsq	%rax, %r8
	movq	%r8, (%rdx)
	cmovsq	%rbx, %rcx
	movq	%rcx, 24(%rdx)
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
	.p2align	4, 0x90
	.type	mcl_fp_montRed4L,@function
mcl_fp_montRed4L:                       # @mcl_fp_montRed4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r10
	movq	-8(%rdx), %r14
	movq	(%rdx), %r11
	movq	%r14, %rbp
	imulq	%r10, %rbp
	movq	24(%rdx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rdx, %r15
	movq	16(%rcx), %r8
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r13
	movq	8(%rcx), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%r11, %rax
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rcx
	addq	%r12, %rcx
	adcq	%r9, %rbx
	adcq	-72(%rsp), %r13                 # 8-byte Folded Reload
	adcq	$0, %r15
	addq	%r10, %rax
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r13
	adcq	32(%rsi), %r15
	setb	-72(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rdi
	imulq	%rcx, %rdi
	movq	%rdi, %rax
	movq	-56(%rsp), %rsi                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r12
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdi
	movq	%rdx, %r8
	movq	%rax, %r9
	movq	%r11, %rax
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %rbp
	movq	%rax, %rdi
	addq	%r10, %rdi
	adcq	%r9, %rbp
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	movzbl	-72(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r12
	addq	%rcx, %r11
	adcq	%rbx, %rdi
	adcq	%r13, %rbp
	adcq	%r15, %r8
	movq	-24(%rsp), %rax                 # 8-byte Reload
	adcq	40(%rax), %r12
	setb	-72(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rcx
	imulq	%rdi, %rcx
	movq	%rcx, %rax
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-32(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %r9
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %rbx
	addq	%r11, %rbx
	adcq	-16(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	movzbl	-72(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r15
	addq	%rdi, %r9
	adcq	%rbp, %rbx
	adcq	%r8, %rcx
	adcq	%r12, %r13
	movq	-24(%rsp), %r8                  # 8-byte Reload
	adcq	48(%r8), %r15
	setb	-72(%rsp)                       # 1-byte Folded Spill
	imulq	%rbx, %r14
	movq	%r14, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, %r9
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, %r10
	movq	%rax, %rdi
	movq	%rsi, %rax
	mulq	%r14
	movq	%rdx, %r11
	movq	%rax, %r12
	movq	-48(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rax
	mulq	%r14
	addq	%r11, %rax
	adcq	%rdi, %rdx
	adcq	%r9, %r10
	movzbl	-72(%rsp), %r9d                 # 1-byte Folded Reload
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rbx, %r12
	adcq	%rcx, %rax
	adcq	%r13, %rdx
	adcq	%r15, %r10
	adcq	56(%r8), %r9
	setb	%r8b
	movq	%rax, %rsi
	subq	-40(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rdx, %rbx
	sbbq	%rbp, %rbx
	movq	%r10, %rcx
	sbbq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r9, %rbp
	sbbq	-56(%rsp), %rbp                 # 8-byte Folded Reload
	movzbl	%r8b, %edi
	sbbq	$0, %rdi
	testb	$1, %dil
	cmovneq	%r10, %rcx
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rcx, 16(%rdi)
	cmovneq	%r9, %rbp
	movq	%rbp, 24(%rdi)
	cmovneq	%rax, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%rdx, %rbx
	movq	%rbx, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_montRedNF4L,@function
mcl_fp_montRedNF4L:                     # @mcl_fp_montRedNF4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r10
	movq	-8(%rdx), %r14
	movq	(%rdx), %rdi
	movq	%rdi, -40(%rsp)                 # 8-byte Spill
	movq	%r14, %rbp
	imulq	%r10, %rbp
	movq	24(%rdx), %rax
	movq	%rax, %r11
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rdx, %r15
	movq	16(%rcx), %r8
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r13
	movq	8(%rcx), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %rbx
	movq	%rax, %r12
	movq	%rdi, %rax
	mulq	%rbp
	movq	%rdx, %rcx
	addq	%r12, %rcx
	adcq	%r9, %rbx
	adcq	-72(%rsp), %r13                 # 8-byte Folded Reload
	adcq	$0, %r15
	addq	%r10, %rax
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rcx
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r13
	adcq	32(%rsi), %r15
	setb	-72(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rdi
	imulq	%rcx, %rdi
	movq	%rdi, %rax
	mulq	%r11
	movq	%rdx, %r12
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdi
	movq	%rdx, %r8
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %r11
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	mulq	%rdi
	movq	%rdx, %rbp
	movq	%rax, %rdi
	addq	%r10, %rdi
	adcq	-56(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	movzbl	-72(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r12
	addq	%rcx, %r11
	adcq	%rbx, %rdi
	adcq	%r13, %rbp
	adcq	%r15, %r8
	movq	-16(%rsp), %rax                 # 8-byte Reload
	adcq	40(%rax), %r12
	setb	-72(%rsp)                       # 1-byte Folded Spill
	movq	%r14, %rcx
	imulq	%rdi, %rcx
	movq	%rcx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-32(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r13
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	%rcx
	movq	%rdx, %rcx
	movq	%rax, %rbx
	addq	%r11, %rbx
	adcq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	movzbl	-72(%rsp), %eax                 # 1-byte Folded Reload
	adcq	%rax, %r15
	addq	%rdi, %r9
	adcq	%rbp, %rbx
	adcq	%r8, %rcx
	adcq	%r12, %r13
	movq	-16(%rsp), %r8                  # 8-byte Reload
	adcq	48(%r8), %r15
	setb	-72(%rsp)                       # 1-byte Folded Spill
	imulq	%rbx, %r14
	movq	%r14, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, %r9
	movq	%r10, %rax
	mulq	%r14
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rax
	mulq	%r14
	movq	%rdx, %r11
	movq	%rax, %rbp
	movq	-24(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%r14
	addq	%r11, %rax
	adcq	%r10, %rdx
	adcq	%r9, %rdi
	movzbl	-72(%rsp), %r9d                 # 1-byte Folded Reload
	adcq	-64(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rbx, %rbp
	adcq	%rcx, %rax
	adcq	%r13, %rdx
	adcq	%r15, %rdi
	adcq	56(%r8), %r9
	movq	%rax, %rcx
	subq	%rsi, %rcx
	movq	%rdx, %rsi
	sbbq	%r12, %rsi
	movq	%rdi, %rbp
	sbbq	-32(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r9, %rbx
	sbbq	-48(%rsp), %rbx                 # 8-byte Folded Reload
	cmovsq	%rdi, %rbp
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rbp, 16(%rdi)
	cmovsq	%r9, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%rax, %rcx
	movq	%rcx, (%rdi)
	cmovsq	%rdx, %rsi
	movq	%rsi, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_addPre4L,@function
mcl_fp_addPre4L:                        # @mcl_fp_addPre4L
# %bb.0:
	movq	24(%rdx), %r8
	movq	16(%rdx), %rcx
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %r8
	movq	%rcx, 16(%rdi)
	movq	%r8, 24(%rdi)
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	setb	%al
	movzbl	%al, %eax
	retq
.Lfunc_end26:
	.size	mcl_fp_addPre4L, .Lfunc_end26-mcl_fp_addPre4L
                                        # -- End function
	.globl	mcl_fp_subPre4L                 # -- Begin function mcl_fp_subPre4L
	.p2align	4, 0x90
	.type	mcl_fp_subPre4L,@function
mcl_fp_subPre4L:                        # @mcl_fp_subPre4L
# %bb.0:
	movq	24(%rsi), %r8
	movq	16(%rsi), %rcx
	movq	(%rsi), %r9
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r9
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	sbbq	24(%rdx), %r8
	movq	%rcx, 16(%rdi)
	movq	%r8, 24(%rdi)
	movq	%r9, (%rdi)
	movq	%rsi, 8(%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	retq
.Lfunc_end27:
	.size	mcl_fp_subPre4L, .Lfunc_end27-mcl_fp_subPre4L
                                        # -- End function
	.globl	mcl_fp_shr1_4L                  # -- Begin function mcl_fp_shr1_4L
	.p2align	4, 0x90
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
	.p2align	4, 0x90
	.type	mcl_fp_add4L,@function
mcl_fp_add4L:                           # @mcl_fp_add4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	24(%rdx), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %r8
	movq	8(%rdx), %r10
	addq	(%rsi), %r8
	adcq	8(%rsi), %r10
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	setb	%dl
	movzbl	%dl, %r14d
	movq	%r8, %rsi
	subq	(%rcx), %rsi
	movq	%r10, %rax
	sbbq	8(%rcx), %rax
	movq	%r11, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %rdx
	sbbq	24(%rcx), %rdx
	sbbq	$0, %r14
	testb	$1, %r14b
	cmovneq	%r11, %rbx
	movq	%rbx, 16(%rdi)
	cmovneq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovneq	%r10, %rax
	movq	%rax, 8(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end29:
	.size	mcl_fp_add4L, .Lfunc_end29-mcl_fp_add4L
                                        # -- End function
	.globl	mcl_fp_addNF4L                  # -- Begin function mcl_fp_addNF4L
	.p2align	4, 0x90
	.type	mcl_fp_addNF4L,@function
mcl_fp_addNF4L:                         # @mcl_fp_addNF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rdx), %r8
	movq	16(%rdx), %r11
	movq	(%rdx), %r9
	movq	8(%rdx), %r10
	addq	(%rsi), %r9
	adcq	8(%rsi), %r10
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r8
	movq	%r9, %rsi
	subq	(%rcx), %rsi
	movq	%r10, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r11, %rax
	sbbq	16(%rcx), %rax
	movq	%r8, %rbx
	sbbq	24(%rcx), %rbx
	cmovsq	%r11, %rax
	movq	%rax, 16(%rdi)
	cmovsq	%r8, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%r9, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r10, %rdx
	movq	%rdx, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end30:
	.size	mcl_fp_addNF4L, .Lfunc_end30-mcl_fp_addNF4L
                                        # -- End function
	.globl	mcl_fp_sub4L                    # -- Begin function mcl_fp_sub4L
	.p2align	4, 0x90
	.type	mcl_fp_sub4L,@function
mcl_fp_sub4L:                           # @mcl_fp_sub4L
# %bb.0:
	pushq	%rbx
	xorl	%r10d, %r10d
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rax
	movq	8(%rsi), %r11
	subq	(%rdx), %rax
	sbbq	8(%rdx), %r11
	sbbq	16(%rdx), %r9
	sbbq	24(%rdx), %r8
	movl	$0, %edx
	sbbq	%rdx, %rdx
	andl	$1, %edx
	negq	%rdx
	movl	$0, %edx
	movl	$0, %esi
	movl	$0, %ebx
	jns	.LBB31_2
# %bb.1:
	movq	24(%rcx), %r10
	movq	16(%rcx), %rdx
	movq	8(%rcx), %rsi
	movq	(%rcx), %rbx
.LBB31_2:
	addq	%rax, %rbx
	movq	%rbx, (%rdi)
	adcq	%r11, %rsi
	movq	%rsi, 8(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r8, %r10
	movq	%r10, 24(%rdi)
	popq	%rbx
	retq
.Lfunc_end31:
	.size	mcl_fp_sub4L, .Lfunc_end31-mcl_fp_sub4L
                                        # -- End function
	.globl	mcl_fp_subNF4L                  # -- Begin function mcl_fp_subNF4L
	.p2align	4, 0x90
	.type	mcl_fp_subNF4L,@function
mcl_fp_subNF4L:                         # @mcl_fp_subNF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rsi), %r11
	movq	16(%rsi), %r8
	movq	(%rsi), %r9
	movq	8(%rsi), %r10
	subq	(%rdx), %r9
	sbbq	8(%rdx), %r10
	sbbq	16(%rdx), %r8
	sbbq	24(%rdx), %r11
	movq	%r11, %rdx
	sarq	$63, %rdx
	movq	24(%rcx), %rsi
	andq	%rdx, %rsi
	movq	16(%rcx), %rax
	andq	%rdx, %rax
	movq	8(%rcx), %rbx
	andq	%rdx, %rbx
	andq	(%rcx), %rdx
	addq	%r9, %rdx
	movq	%rdx, (%rdi)
	adcq	%r10, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r8, %rax
	movq	%rax, 16(%rdi)
	adcq	%r11, %rsi
	movq	%rsi, 24(%rdi)
	popq	%rbx
	retq
.Lfunc_end32:
	.size	mcl_fp_subNF4L, .Lfunc_end32-mcl_fp_subNF4L
                                        # -- End function
	.globl	mcl_fpDbl_add4L                 # -- Begin function mcl_fpDbl_add4L
	.p2align	4, 0x90
	.type	mcl_fpDbl_add4L,@function
mcl_fpDbl_add4L:                        # @mcl_fpDbl_add4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	56(%rdx), %r9
	movq	48(%rdx), %r11
	movq	40(%rdx), %r8
	movq	32(%rdx), %r10
	movq	24(%rdx), %rax
	movq	16(%rdx), %r14
	movq	(%rdx), %rbx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r14
	adcq	24(%rsi), %rax
	adcq	32(%rsi), %r10
	adcq	40(%rsi), %r8
	adcq	48(%rsi), %r11
	adcq	56(%rsi), %r9
	movq	%rax, 24(%rdi)
	movq	%rbx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r14, 16(%rdi)
	setb	%al
	movzbl	%al, %r14d
	movq	%r10, %rdx
	subq	(%rcx), %rdx
	movq	%r8, %rsi
	sbbq	8(%rcx), %rsi
	movq	%r11, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %rax
	sbbq	24(%rcx), %rax
	sbbq	$0, %r14
	testb	$1, %r14b
	cmovneq	%r11, %rbx
	movq	%rbx, 48(%rdi)
	cmovneq	%r9, %rax
	movq	%rax, 56(%rdi)
	cmovneq	%r10, %rdx
	movq	%rdx, 32(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, 40(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end33:
	.size	mcl_fpDbl_add4L, .Lfunc_end33-mcl_fpDbl_add4L
                                        # -- End function
	.globl	mcl_fpDbl_sub4L                 # -- Begin function mcl_fpDbl_sub4L
	.p2align	4, 0x90
	.type	mcl_fpDbl_sub4L,@function
mcl_fpDbl_sub4L:                        # @mcl_fpDbl_sub4L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	56(%rsi), %r8
	movq	48(%rsi), %r9
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %r15
	movq	16(%rsi), %r14
	movq	(%rsi), %rbx
	movq	8(%rsi), %rax
	xorl	%esi, %esi
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %rax
	sbbq	16(%rdx), %r14
	sbbq	24(%rdx), %r15
	sbbq	32(%rdx), %r11
	sbbq	40(%rdx), %r10
	sbbq	48(%rdx), %r9
	sbbq	56(%rdx), %r8
	movq	%r15, 24(%rdi)
	movq	%rbx, (%rdi)
	movq	%rax, 8(%rdi)
	movq	%r14, 16(%rdi)
	sbbq	%rsi, %rsi
	andl	$1, %esi
	negq	%rsi
	movq	24(%rcx), %rax
	andq	%rsi, %rax
	movq	16(%rcx), %rdx
	andq	%rsi, %rdx
	movq	8(%rcx), %rbx
	andq	%rsi, %rbx
	andq	(%rcx), %rsi
	addq	%r11, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r10, %rbx
	movq	%rbx, 40(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 48(%rdi)
	adcq	%r8, %rax
	movq	%rax, 56(%rdi)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end34:
	.size	mcl_fpDbl_sub4L, .Lfunc_end34-mcl_fpDbl_sub4L
                                        # -- End function
	.globl	mulPv384x64                     # -- Begin function mulPv384x64
	.p2align	4, 0x90
	.type	mulPv384x64,@function
mulPv384x64:                            # @mulPv384x64
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rcx
	movq	%rdx, %rax
	mulq	(%rsi)
	movq	%rdx, %r10
	movq	%rax, (%rdi)
	movq	%rcx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r8
	movq	%rcx, %rax
	mulq	32(%rsi)
	movq	%rdx, %r11
	movq	%rax, %r14
	movq	%rcx, %rax
	mulq	24(%rsi)
	movq	%rdx, %r12
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	16(%rsi)
	movq	%rdx, %rbx
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	8(%rsi)
	addq	%r10, %rax
	movq	%rax, 8(%rdi)
	adcq	%r13, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r15, %rbx
	movq	%rbx, 24(%rdi)
	adcq	%r14, %r12
	movq	%r12, 32(%rdi)
	adcq	%r8, %r11
	movq	%r11, 40(%rdi)
	adcq	$0, %r9
	movq	%r9, 48(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_mont6L,@function
mcl_fp_mont6L:                          # @mcl_fp_mont6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rbp
	mulq	%rbp
	movq	%rax, %r8
	movq	%rdx, %r10
	movq	32(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r11
	movq	%rdx, %r13
	movq	24(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r15
	movq	%rdx, %rdi
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r14
	movq	(%rsi), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %r12
	movq	%rax, %rsi
	movq	%rbx, %rax
	mulq	%rbp
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rdx, %rbp
	addq	%rsi, %rbp
	adcq	%r9, %r12
	adcq	%r15, %r14
	adcq	%r11, %rdi
	movq	%rdi, -88(%rsp)                 # 8-byte Spill
	adcq	%r8, %r13
	movq	%r13, -128(%rsp)                # 8-byte Spill
	adcq	$0, %r10
	movq	%r10, -112(%rsp)                # 8-byte Spill
	movq	-8(%rcx), %r8
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	imulq	%rax, %r8
	movq	40(%rcx), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdx
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdx
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%rdx, %r11
	movq	24(%rcx), %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdx
	movq	%rax, %r13
	movq	%rdx, %r15
	movq	16(%rcx), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%r8, %rax
	mulq	%rdx
	movq	%rax, %r9
	movq	%rdx, %rsi
	movq	(%rcx), %rbx
	movq	%rbx, -24(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	%r8, %rax
	mulq	%rcx
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	%r8, %rax
	mulq	%rbx
	movq	%rdx, %rcx
	addq	%r10, %rcx
	adcq	%r9, %rdi
	adcq	%r13, %rsi
	adcq	-80(%rsp), %r15                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r11                # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	-96(%rsp), %rax                 # 8-byte Folded Reload
	adcq	%rbp, %rcx
	adcq	%r12, %rdi
	adcq	%r14, %rsi
	adcq	-88(%rsp), %r15                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r11                # 8-byte Folded Reload
	adcq	-112(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-128(%rsp)                      # 1-byte Folded Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rbx
	movq	%rbx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r12
	movq	%rbx, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rbx
	addq	%r12, %rbx
	adcq	%r13, %rbp
	adcq	-104(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r10                 # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%rcx, %r9
	adcq	%rdi, %rbx
	adcq	%rsi, %rbp
	adcq	%r15, %r8
	adcq	%r11, %r14
	adcq	-120(%rsp), %r10                # 8-byte Folded Reload
	movzbl	-128(%rsp), %eax                # 1-byte Folded Reload
	adcq	%rax, %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-120(%rsp)                      # 1-byte Folded Spill
	movq	-32(%rsp), %rdi                 # 8-byte Reload
	imulq	%r9, %rdi
	movq	%rdi, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rdi, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	%rdi, %rax
	mulq	32(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %r15
	movq	%rdi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r15, %r11
	adcq	%rsi, %r12
	adcq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	movq	-88(%rsp), %rsi                 # 8-byte Reload
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r9, %rax
	adcq	%rbx, %r11
	adcq	%rbp, %r12
	adcq	%r8, %rcx
	adcq	%r14, %r13
	adcq	%r10, %rsi
	movq	%rsi, -88(%rsp)                 # 8-byte Spill
	adcq	-112(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movzbl	-120(%rsp), %ebx                # 1-byte Folded Reload
	adcq	$0, %rbx
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rsi
	movq	%rsi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r9
	movq	%rsi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %r14
	movq	%rsi, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %rbp
	movq	%rsi, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%rdx, %r8
	addq	%rbp, %r8
	adcq	%r14, %r15
	adcq	%r9, %r10
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	-112(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %rsi
	adcq	%r12, %r8
	adcq	%rcx, %r15
	adcq	%r13, %r10
	adcq	-88(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	adcq	%rbx, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	imulq	%rsi, %rcx
	movq	%rcx, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rcx, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, %r13
	movq	%rcx, %rax
	mulq	32(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r9
	movq	%rcx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	addq	%r9, %r11
	adcq	%r13, %rbp
	adcq	-80(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-104(%rsp), %rbx                # 8-byte Folded Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	-128(%rsp), %rcx                # 8-byte Reload
	adcq	$0, %rcx
	addq	%rsi, %rax
	adcq	%r8, %r11
	adcq	%r15, %rbp
	adcq	%r10, %r14
	adcq	%rdi, %rbx
	adcq	-120(%rsp), %r12                # 8-byte Folded Reload
	adcq	-112(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	movzbl	-88(%rsp), %esi                 # 1-byte Folded Reload
	adcq	$0, %rsi
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdi
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rdi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, %r10
	movq	%rdi, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, %r8
	movq	%rdi, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rdi
	addq	%r8, %rdi
	adcq	%r10, %rcx
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	-112(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r9
	adcq	%rbp, %rdi
	adcq	%r14, %rcx
	adcq	%rbx, %r15
	adcq	%r12, %r13
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	adcq	%rsi, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rsi                 # 8-byte Reload
	imulq	%r9, %rsi
	movq	%rsi, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rsi, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r14
	movq	%rsi, %rax
	mulq	32(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r11
	movq	%rsi, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r10
	addq	%r11, %r10
	adcq	%r14, %rbx
	adcq	-80(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r12                # 8-byte Folded Reload
	adcq	-96(%rsp), %r8                  # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r9, %rax
	adcq	%rdi, %r10
	adcq	%rcx, %rbx
	adcq	%r15, %rbp
	adcq	%r13, %r12
	adcq	-120(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-112(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movzbl	-88(%rsp), %r11d                # 1-byte Folded Reload
	adcq	$0, %r11
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %rcx
	movq	%rcx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r14
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rcx, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rsi
	movq	%rcx, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, %r15
	movq	%rcx, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r9
	movq	%rdx, %rcx
	addq	%r15, %rcx
	adcq	%rsi, %rdi
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	movq	-120(%rsp), %rax                # 8-byte Reload
	adcq	-88(%rsp), %rax                 # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %r9
	adcq	%rbx, %rcx
	adcq	%rbp, %rdi
	adcq	%r12, %r13
	adcq	%r8, %r14
	adcq	-128(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, -120(%rsp)                # 8-byte Spill
	adcq	%r11, %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %rbx                 # 8-byte Reload
	imulq	%r9, %rbx
	movq	%rbx, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %r15
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, %r10
	movq	%rbx, %rax
	mulq	32(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r11
	movq	%rbx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	addq	%r11, %r8
	adcq	%r10, %rsi
	adcq	-80(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r12                # 8-byte Folded Reload
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	movq	-128(%rsp), %rbx                # 8-byte Reload
	adcq	$0, %rbx
	addq	%r9, %rax
	adcq	%rcx, %r8
	adcq	%rdi, %rsi
	adcq	%r13, %rbp
	adcq	%r14, %r12
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	%r15, -120(%rsp)                # 8-byte Spill
	adcq	-112(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rbx, -128(%rsp)                # 8-byte Spill
	movzbl	-88(%rsp), %r15d                # 1-byte Folded Reload
	adcq	$0, %r15
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdi
	movq	%rdi, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rdi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rdi, %rax
	mulq	-40(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rdi, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%rdi, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r14
	movq	%rdx, %r9
	addq	%rcx, %r9
	adcq	%rbx, %r10
	adcq	-72(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r11                 # 8-byte Folded Reload
	movq	-56(%rsp), %rcx                 # 8-byte Reload
	adcq	-112(%rsp), %rcx                # 8-byte Folded Reload
	movq	-48(%rsp), %rax                 # 8-byte Reload
	adcq	$0, %rax
	addq	%r8, %r14
	adcq	%rsi, %r9
	adcq	%rbp, %r10
	adcq	%r12, %r13
	adcq	-120(%rsp), %r11                # 8-byte Folded Reload
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rcx, -56(%rsp)                 # 8-byte Spill
	adcq	%r15, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	setb	-64(%rsp)                       # 1-byte Folded Spill
	movq	-32(%rsp), %r12                 # 8-byte Reload
	imulq	%r14, %r12
	movq	%r12, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	(%rsp)                          # 8-byte Folded Reload
	movq	%rdx, %rbp
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %rcx
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	%r12, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rbx
	movq	%rax, %r15
	movq	%r12, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r8
	movq	%rax, %rdi
	movq	%r12, %rax
	movq	32(%rsp), %r12                  # 8-byte Reload
	mulq	%r12
	addq	%r8, %rax
	adcq	%r15, %rdx
	adcq	-40(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-32(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	$0, %rsi
	addq	%r14, %rdi
	adcq	%r9, %rax
	adcq	%r10, %rdx
	adcq	%r13, %rbx
	adcq	%r11, %rcx
	adcq	-56(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-48(%rsp), %rsi                 # 8-byte Folded Reload
	movzbl	-64(%rsp), %r11d                # 1-byte Folded Reload
	adcq	$0, %r11
	movq	%rax, %r8
	subq	-24(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rdx, %r9
	sbbq	%r12, %r9
	movq	%rbx, %r10
	sbbq	-16(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rcx, %r14
	sbbq	-8(%rsp), %r14                  # 8-byte Folded Reload
	movq	%rbp, %r15
	sbbq	(%rsp), %r15                    # 8-byte Folded Reload
	movq	%rsi, %rdi
	sbbq	8(%rsp), %rdi                   # 8-byte Folded Reload
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%rsi, %rdi
	movq	40(%rsp), %rsi                  # 8-byte Reload
	movq	%rdi, 40(%rsi)
	cmovneq	%rbp, %r15
	movq	%r15, 32(%rsi)
	cmovneq	%rcx, %r14
	movq	%r14, 24(%rsi)
	cmovneq	%rbx, %r10
	movq	%r10, 16(%rsi)
	cmovneq	%rdx, %r9
	movq	%r9, 8(%rsi)
	cmovneq	%rax, %r8
	movq	%r8, (%rsi)
	addq	$48, %rsp
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
	.p2align	4, 0x90
	.type	mcl_fp_montNF6L,@function
mcl_fp_montNF6L:                        # @mcl_fp_montNF6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rdi
	mulq	%rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdx, %r8
	movq	32(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r10
	movq	%rdx, %rbp
	movq	24(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r11
	movq	%rdx, %r12
	movq	16(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rdi
	movq	%rax, %r14
	movq	%rdx, %r9
	movq	(%rsi), %rbx
	movq	%rbx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	mulq	%rdi
	movq	%rdx, %r15
	movq	%rax, %rsi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rax, %r13
	movq	%rdx, %rdi
	addq	%rsi, %rdi
	adcq	%r14, %r15
	adcq	%r11, %r9
	adcq	%r10, %r12
	adcq	-64(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, -128(%rsp)                # 8-byte Spill
	adcq	$0, %r8
	movq	%r8, -112(%rsp)                 # 8-byte Spill
	movq	-8(%rcx), %rbp
	movq	%rbp, -40(%rsp)                 # 8-byte Spill
	imulq	%rax, %rbp
	movq	40(%rcx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, %rbx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	32(%rcx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r11
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	%rdx
	movq	%rax, %r14
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	16(%rcx), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulq	%rbp
	movq	%rax, %r8
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movq	(%rcx), %rsi
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	mulq	%rbp
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%rsi, %rax
	mulq	%rbp
	addq	%r13, %rax
	adcq	%rdi, %rcx
	adcq	%r15, %r8
	adcq	%r9, %r14
	adcq	%r12, %r11
	adcq	-128(%rsp), %rbx                # 8-byte Folded Reload
	movq	-112(%rsp), %rax                # 8-byte Reload
	adcq	$0, %rax
	addq	%rdx, %rcx
	adcq	%r10, %r8
	adcq	(%rsp), %r14                    # 8-byte Folded Reload
	adcq	-104(%rsp), %r11                # 8-byte Folded Reload
	adcq	-96(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, -128(%rsp)                # 8-byte Spill
	adcq	-120(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rbp
	movq	-80(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %rdi
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	-88(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r13
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %rsi
	movq	%rax, %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %rbx
	movq	%rax, %r10
	movq	16(%rsp), %rax                  # 8-byte Reload
	mulq	%rbp
	movq	%rax, %r12
	movq	%rdx, %rbp
	addq	%r10, %rbp
	adcq	%r15, %rbx
	adcq	-104(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-96(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-120(%rsp), %r13                # 8-byte Folded Reload
	adcq	$0, %rdi
	addq	%rcx, %r12
	adcq	%r8, %rbp
	adcq	%r14, %rbx
	adcq	%r11, %rsi
	adcq	-128(%rsp), %r9                 # 8-byte Folded Reload
	adcq	-112(%rsp), %r13                # 8-byte Folded Reload
	adcq	$0, %rdi
	movq	-40(%rsp), %r14                 # 8-byte Reload
	imulq	%r12, %r14
	movq	-64(%rsp), %rax                 # 8-byte Reload
	mulq	%r14
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	-8(%rsp), %rax                  # 8-byte Reload
	mulq	%r14
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %r10
	movq	%r14, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r15
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%r14
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %rcx
	movq	24(%rsp), %rax                  # 8-byte Reload
	mulq	%r14
	movq	%rdx, %r8
	movq	%rax, %r11
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%r14
	addq	%r12, %rax
	adcq	%rbp, %r11
	adcq	%rbx, %rcx
	adcq	%rsi, %r15
	adcq	%r9, %r10
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	%r13, %rsi
	adcq	$0, %rdi
	addq	%rdx, %r11
	adcq	%r8, %rcx
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-120(%rsp), %r10                # 8-byte Folded Reload
	movq	%r10, -120(%rsp)                # 8-byte Spill
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rbp
	movq	-80(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r12
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-88(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r10
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r13
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %rbx
	movq	%rax, %r14
	movq	16(%rsp), %rax                  # 8-byte Reload
	mulq	%rbp
	movq	%rax, %r9
	movq	%rdx, %r8
	addq	%r14, %r8
	adcq	(%rsp), %rbx                    # 8-byte Folded Reload
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r10                # 8-byte Folded Reload
	adcq	$0, %r12
	addq	%r11, %r9
	adcq	%rcx, %r8
	adcq	%r15, %rbx
	adcq	-120(%rsp), %r13                # 8-byte Folded Reload
	adcq	-112(%rsp), %rsi                # 8-byte Folded Reload
	adcq	%rdi, %r10
	adcq	$0, %r12
	movq	-40(%rsp), %rdi                 # 8-byte Reload
	imulq	%r9, %rdi
	movq	-64(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	-8(%rsp), %rax                  # 8-byte Reload
	mulq	%rdi
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %r14
	movq	%rdi, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r15
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %rcx
	movq	24(%rsp), %rax                  # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %r11
	movq	%rax, %rbp
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	addq	%r9, %rax
	adcq	%r8, %rbp
	adcq	%rbx, %rcx
	adcq	%r13, %r15
	adcq	%rsi, %r14
	movq	-112(%rsp), %rax                # 8-byte Reload
	adcq	%r10, %rax
	adcq	$0, %r12
	addq	%rdx, %rbp
	adcq	%r11, %rcx
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-120(%rsp), %r14                # 8-byte Folded Reload
	movq	%r14, -120(%rsp)                # 8-byte Spill
	adcq	-96(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, -112(%rsp)                # 8-byte Spill
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rbx
	movq	-80(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r14
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	-88(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	-56(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, %r10
	movq	8(%rsp), %rax                   # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rsi
	movq	%rax, %r9
	movq	16(%rsp), %rax                  # 8-byte Reload
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %rbx
	addq	%r9, %rbx
	adcq	%r10, %rsi
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-128(%rsp), %r11                # 8-byte Folded Reload
	adcq	$0, %r14
	addq	%rbp, %r8
	adcq	%rcx, %rbx
	adcq	%r15, %rsi
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %r13                # 8-byte Folded Reload
	adcq	%r12, %r11
	adcq	$0, %r14
	movq	-40(%rsp), %rbp                 # 8-byte Reload
	imulq	%r8, %rbp
	movq	%rbp, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbp, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, %r9
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	%rbp, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %r15
	movq	%rbp, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r10
	movq	%rax, %rcx
	movq	%rbp, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	addq	%r8, %rax
	adcq	%rbx, %rcx
	adcq	%rsi, %r15
	adcq	%rdi, %r12
	adcq	%r13, %r9
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	%r11, %rsi
	adcq	$0, %r14
	addq	%rdx, %rcx
	adcq	%r10, %r15
	adcq	-104(%rsp), %r12                # 8-byte Folded Reload
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	%r9, -120(%rsp)                 # 8-byte Spill
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	adcq	-128(%rsp), %r14                # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %rbx
	movq	%rbx, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r11
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rbx, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %rbp
	addq	%r13, %rbp
	adcq	(%rsp), %rsi                    # 8-byte Folded Reload
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-96(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %r9                 # 8-byte Folded Reload
	adcq	$0, %r11
	addq	%rcx, %r10
	adcq	%r15, %rbp
	adcq	%r12, %rsi
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	adcq	%r14, %r9
	adcq	$0, %r11
	movq	-40(%rsp), %rbx                 # 8-byte Reload
	imulq	%r10, %rbx
	movq	%rbx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%rbx, %rax
	mulq	-8(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	movq	%rax, %r12
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	-32(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	24(%rsp)                        # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rcx
	movq	%rbx, %rax
	mulq	-24(%rsp)                       # 8-byte Folded Reload
	addq	%r10, %rax
	adcq	%rbp, %rcx
	adcq	%rsi, %r15
	adcq	%rdi, %r14
	adcq	%r8, %r12
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	%r9, %rsi
	adcq	$0, %r11
	addq	%rdx, %rcx
	adcq	%r13, %r15
	adcq	-128(%rsp), %r14                # 8-byte Folded Reload
	movq	%r14, -128(%rsp)                # 8-byte Spill
	adcq	-120(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -120(%rsp)                # 8-byte Spill
	adcq	-104(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rbp
	movq	%rbp, %rax
	mulq	-80(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %rdi
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	-88(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rbp
	movq	%rdx, %r14
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	mulq	-48(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, %r13
	movq	%rax, %rbx
	movq	%rbp, %rax
	mulq	8(%rsp)                         # 8-byte Folded Reload
	movq	%rdx, %r12
	movq	%rax, %rsi
	movq	%rbp, %rax
	mulq	16(%rsp)                        # 8-byte Folded Reload
	movq	%rax, %r10
	movq	%rdx, %r8
	addq	%rsi, %r8
	adcq	%rbx, %r12
	adcq	-88(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-80(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-72(%rsp), %r9                  # 8-byte Folded Reload
	adcq	$0, %rdi
	addq	%rcx, %r10
	adcq	%r15, %r8
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	adcq	-120(%rsp), %r13                # 8-byte Folded Reload
	adcq	-112(%rsp), %r14                # 8-byte Folded Reload
	adcq	%r11, %r9
	movq	%r9, -80(%rsp)                  # 8-byte Spill
	adcq	$0, %rdi
	movq	-40(%rsp), %r9                  # 8-byte Reload
	imulq	%r10, %r9
	movq	-64(%rsp), %rax                 # 8-byte Reload
	mulq	%r9
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	%rax, %rcx
	movq	-8(%rsp), %rax                  # 8-byte Reload
	mulq	%r9
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rax, %rsi
	movq	%r9, %rax
	mulq	-16(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, %rbx
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%r9
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rax, %r11
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%r9
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	%rax, %rbp
	movq	24(%rsp), %r15                  # 8-byte Reload
	movq	%r15, %rax
	mulq	%r9
	addq	%r10, %r11
	adcq	%r8, %rax
	adcq	%r12, %rbp
	adcq	%r13, %rbx
	adcq	%r14, %rsi
	adcq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	$0, %rdi
	addq	-48(%rsp), %rax                 # 8-byte Folded Reload
	adcq	%rdx, %rbp
	adcq	-56(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-40(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rax, %r8
	subq	-24(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rbp, %r9
	sbbq	%r15, %r9
	movq	%rbx, %r10
	sbbq	-32(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rsi, %r11
	sbbq	-16(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rcx, %r14
	sbbq	-8(%rsp), %r14                  # 8-byte Folded Reload
	movq	%rdi, %r15
	sbbq	-64(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sarq	$63, %rdx
	cmovsq	%rdi, %r15
	movq	32(%rsp), %rdx                  # 8-byte Reload
	movq	%r15, 40(%rdx)
	cmovsq	%rcx, %r14
	movq	%r14, 32(%rdx)
	cmovsq	%rsi, %r11
	movq	%r11, 24(%rdx)
	cmovsq	%rbx, %r10
	movq	%r10, 16(%rdx)
	cmovsq	%rbp, %r9
	movq	%r9, 8(%rdx)
	cmovsq	%rax, %r8
	movq	%r8, (%rdx)
	addq	$40, %rsp
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
	.p2align	4, 0x90
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
	movq	%rdx, %rbp
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movq	(%rsi), %r12
	movq	-8(%rdx), %rbx
	movq	%rbx, -80(%rsp)                 # 8-byte Spill
	imulq	%r12, %rbx
	movq	40(%rdx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	32(%rbp), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r10
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	24(%rbp), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r14
	movq	%rdx, %rcx
	movq	16(%rbp), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r8
	movq	%rdx, %r9
	movq	(%rbp), %r15
	movq	8(%rbp), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, %rbp
	movq	%r15, %rax
	movq	%r15, -24(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r13
	addq	%rbp, %r13
	adcq	%r8, %r11
	adcq	%r14, %r9
	adcq	%r10, %rcx
	movq	-128(%rsp), %rdi                # 8-byte Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r12, %rax
	movq	%rsi, -40(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %rdi
	movq	%rdi, -128(%rsp)                # 8-byte Spill
	adcq	48(%rsi), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	imulq	%r13, %rbx
	movq	%rbx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r10
	movq	%rax, %rsi
	movq	%r15, %rax
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, %r12
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r14
	movq	%rax, %r15
	addq	%r8, %r15
	adcq	%rsi, %r14
	adcq	-56(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-96(%rsp), %rbp                 # 8-byte Folded Reload
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r13, %r12
	adcq	%r11, %r15
	adcq	%r9, %r14
	adcq	%rcx, %r10
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	56(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	imulq	%r15, %rbx
	movq	%rbx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r9
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, %r13
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rbx
	movq	%rax, %r12
	addq	%r8, %r12
	adcq	%rsi, %rbx
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r9                  # 8-byte Folded Reload
	movzbl	-112(%rsp), %eax                # 1-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r15, %r13
	adcq	%r14, %r12
	adcq	%r10, %rbx
	adcq	%rdi, %rcx
	adcq	%rbp, %r11
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-120(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%r12, %rsi
	movq	%rsi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-16(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rdi
	movq	%rax, %r13
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbp
	movq	%rax, %rsi
	addq	%r15, %rsi
	adcq	%r13, %rbp
	adcq	-56(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movzbl	-120(%rsp), %eax                # 1-byte Folded Reload
	movq	-88(%rsp), %r15                 # 8-byte Reload
	adcq	%rax, %r15
	addq	%r12, %r8
	adcq	%rbx, %rsi
	adcq	%rcx, %rbp
	adcq	%r11, %rdi
	adcq	%r9, %r14
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	72(%rax), %r15
	movq	%r15, -88(%rsp)                 # 8-byte Spill
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%rsi, %rcx
	movq	%rcx, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	mulq	%rcx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	-24(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r10
	movq	-32(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %rbx
	movq	%rax, %rcx
	addq	%r12, %rcx
	adcq	%r8, %rbx
	adcq	-8(%rsp), %r15                  # 8-byte Folded Reload
	adcq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	-104(%rsp), %rdx                # 8-byte Folded Reload
	movzbl	-96(%rsp), %eax                 # 1-byte Folded Reload
	movq	-128(%rsp), %r8                 # 8-byte Reload
	adcq	%rax, %r8
	addq	%rsi, %r10
	adcq	%rbp, %rcx
	adcq	%rdi, %rbx
	adcq	%r14, %r15
	adcq	-112(%rsp), %r11                # 8-byte Folded Reload
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %r8
	movq	%r8, -128(%rsp)                 # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rdi                 # 8-byte Reload
	imulq	%rcx, %rdi
	movq	%rdi, %rax
	mulq	-64(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r13, %rax
	mulq	%rdi
	movq	%rdx, %rsi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	mulq	%rdi
	movq	%rdx, %r12
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	%rdi
	movq	%rdx, %r10
	movq	%rax, %r8
	movq	-72(%rsp), %rax                 # 8-byte Reload
	mulq	%rdi
	movq	%rdx, %rbp
	movq	%rax, %r9
	movq	-32(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rax
	mulq	%rdi
	addq	%r10, %rax
	adcq	%r9, %rdx
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movzbl	-112(%rsp), %r9d                # 1-byte Folded Reload
	adcq	-80(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rcx, %r8
	adcq	%rbx, %rax
	adcq	%r15, %rdx
	adcq	%r11, %rbp
	adcq	-120(%rsp), %r12                # 8-byte Folded Reload
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	adcq	88(%rcx), %r9
	setb	%r8b
	movq	%rax, %r10
	subq	-24(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdx, %r11
	sbbq	%r14, %r11
	movq	%rbp, %r15
	sbbq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r12, %r14
	sbbq	%r13, %r14
	movq	%rsi, %rbx
	sbbq	-48(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r9, %rcx
	sbbq	-64(%rsp), %rcx                 # 8-byte Folded Reload
	movzbl	%r8b, %edi
	sbbq	$0, %rdi
	testb	$1, %dil
	cmovneq	%rsi, %rbx
	movq	(%rsp), %rsi                    # 8-byte Reload
	movq	%rbx, 32(%rsi)
	cmovneq	%r9, %rcx
	movq	%rcx, 40(%rsi)
	cmovneq	%rbp, %r15
	movq	%r15, 16(%rsi)
	cmovneq	%r12, %r14
	movq	%r14, 24(%rsi)
	cmovneq	%rax, %r10
	movq	%r10, (%rsi)
	cmovneq	%rdx, %r11
	movq	%r11, 8(%rsi)
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
	.p2align	4, 0x90
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
	movq	%rdx, %rbp
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movq	(%rsi), %r12
	movq	-8(%rdx), %rbx
	movq	%rbx, -80(%rsp)                 # 8-byte Spill
	imulq	%r12, %rbx
	movq	40(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	32(%rbp), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r10
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	24(%rbp), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r14
	movq	%rdx, %rcx
	movq	16(%rbp), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rax, %r15
	movq	%rdx, %r9
	movq	(%rbp), %r8
	movq	8(%rbp), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, %rbp
	movq	%r8, %rax
	movq	%r8, -16(%rsp)                  # 8-byte Spill
	mulq	%rbx
	movq	%rdx, %r13
	addq	%rbp, %r13
	adcq	%r15, %r11
	adcq	%r14, %r9
	adcq	%r10, %rcx
	movq	-128(%rsp), %rdi                # 8-byte Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r12, %rax
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %rdi
	movq	%rdi, -128(%rsp)                # 8-byte Spill
	adcq	48(%rsi), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	imulq	%r13, %rbx
	movq	%rbx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rbp
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rdi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r10
	movq	%rax, %rsi
	movq	%r8, %rax
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, %r12
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r14
	movq	%rax, %r15
	addq	%r8, %r15
	adcq	%rsi, %r14
	adcq	-64(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-96(%rsp), %rbp                 # 8-byte Folded Reload
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r13, %r12
	adcq	%r11, %r15
	adcq	%r9, %r14
	adcq	%rcx, %r10
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	56(%rax), %rdx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	imulq	%r15, %rbx
	movq	%rbx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r9
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r11
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rcx
	movq	%rax, %rsi
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %r8
	movq	%rax, %r13
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rbx
	movq	%rdx, %rbx
	movq	%rax, %r12
	addq	%r8, %r12
	adcq	%rsi, %rbx
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r9                  # 8-byte Folded Reload
	movzbl	-112(%rsp), %eax                # 1-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	%rax, %rdx
	addq	%r15, %r13
	adcq	%r14, %r12
	adcq	%r10, %rbx
	adcq	%rdi, %rcx
	adcq	%rbp, %r11
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-120(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	imulq	%r12, %rsi
	movq	%rsi, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-56(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rax
	mulq	%rsi
	movq	%rdx, %r14
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rdi
	movq	%rax, %r13
	movq	-16(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rsi
	movq	%rdx, %rbp
	movq	%rax, %rsi
	addq	%r15, %rsi
	adcq	%r13, %rbp
	adcq	-64(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movzbl	-120(%rsp), %eax                # 1-byte Folded Reload
	movq	-88(%rsp), %r15                 # 8-byte Reload
	adcq	%rax, %r15
	addq	%r12, %r8
	adcq	%rbx, %rsi
	adcq	%rcx, %rbp
	adcq	%r11, %rdi
	adcq	%r9, %r14
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	72(%rax), %r15
	movq	%r15, -88(%rsp)                 # 8-byte Spill
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	imulq	%rsi, %rcx
	movq	%rcx, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-40(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	mulq	%rcx
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	mulq	%rcx
	movq	%rdx, %r11
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %r15
	movq	%rax, %r8
	movq	-16(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rax
	mulq	%rcx
	movq	%rdx, %r12
	movq	%rax, %r10
	movq	-24(%rsp), %rax                 # 8-byte Reload
	mulq	%rcx
	movq	%rdx, %rbx
	movq	%rax, %rcx
	addq	%r12, %rcx
	adcq	%r8, %rbx
	adcq	-8(%rsp), %r15                  # 8-byte Folded Reload
	adcq	-64(%rsp), %r11                 # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	-104(%rsp), %rdx                # 8-byte Folded Reload
	movzbl	-96(%rsp), %eax                 # 1-byte Folded Reload
	movq	-128(%rsp), %r8                 # 8-byte Reload
	adcq	%rax, %r8
	addq	%rsi, %r10
	adcq	%rbp, %rcx
	adcq	%rdi, %rbx
	adcq	%r14, %r15
	adcq	-112(%rsp), %r11                # 8-byte Folded Reload
	adcq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %r8
	movq	%r8, -128(%rsp)                 # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	-80(%rsp), %r8                  # 8-byte Reload
	imulq	%rcx, %r8
	movq	%r8, %rax
	mulq	-72(%rsp)                       # 8-byte Folded Reload
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	%r13, %rax
	mulq	%r8
	movq	%rdx, %rdi
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rax                 # 8-byte Reload
	mulq	%r8
	movq	%rdx, %rsi
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	%r9, %rax
	mulq	%r8
	movq	%rdx, %r14
	movq	%rax, %r10
	movq	-48(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	mulq	%r8
	movq	%rdx, %rbp
	movq	%rax, %r9
	movq	-24(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rax
	mulq	%r8
	addq	%r14, %rax
	adcq	%r9, %rdx
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rdi                 # 8-byte Folded Reload
	movzbl	-112(%rsp), %r9d                # 1-byte Folded Reload
	adcq	-80(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rcx, %r10
	adcq	%rbx, %rax
	adcq	%r15, %rdx
	adcq	%r11, %rbp
	adcq	-120(%rsp), %rsi                # 8-byte Folded Reload
	adcq	-128(%rsp), %rdi                # 8-byte Folded Reload
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	adcq	88(%rcx), %r9
	movq	%rax, %r10
	subq	-16(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdx, %r8
	sbbq	%r12, %r8
	movq	%rbp, %r14
	sbbq	%r13, %r14
	movq	%rsi, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rdi, %r15
	sbbq	-40(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r9, %rcx
	sbbq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, %rbx
	sarq	$63, %rbx
	cmovsq	%rdi, %r15
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, 32(%rdi)
	cmovsq	%r9, %rcx
	movq	%rcx, 40(%rdi)
	cmovsq	%rbp, %r14
	movq	%r14, 16(%rdi)
	cmovsq	%rsi, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%rax, %r10
	movq	%r10, (%rdi)
	cmovsq	%rdx, %r8
	movq	%r8, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_addPre6L,@function
mcl_fp_addPre6L:                        # @mcl_fp_addPre6L
# %bb.0:
	movq	40(%rdx), %r9
	movq	32(%rdx), %rcx
	movq	24(%rdx), %r8
	movq	16(%rdx), %rax
	movq	(%rdx), %r10
	movq	8(%rdx), %rdx
	addq	(%rsi), %r10
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %rax
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %r9
	movq	%rcx, 32(%rdi)
	movq	%r9, 40(%rdi)
	movq	%rax, 16(%rdi)
	movq	%r8, 24(%rdi)
	movq	%r10, (%rdi)
	movq	%rdx, 8(%rdi)
	setb	%al
	movzbl	%al, %eax
	retq
.Lfunc_end40:
	.size	mcl_fp_addPre6L, .Lfunc_end40-mcl_fp_addPre6L
                                        # -- End function
	.globl	mcl_fp_subPre6L                 # -- Begin function mcl_fp_subPre6L
	.p2align	4, 0x90
	.type	mcl_fp_subPre6L,@function
mcl_fp_subPre6L:                        # @mcl_fp_subPre6L
# %bb.0:
	movq	40(%rsi), %r8
	movq	32(%rsi), %rcx
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	xorl	%eax, %eax
	subq	(%rdx), %r11
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %rcx
	sbbq	40(%rdx), %r8
	movq	%rcx, 32(%rdi)
	movq	%r8, 40(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_shr1_6L,@function
mcl_fp_shr1_6L:                         # @mcl_fp_shr1_6L
# %bb.0:
	movq	32(%rsi), %r10
	movq	40(%rsi), %rcx
	movq	%rcx, %rdx
	shldq	$63, %r10, %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	movq	24(%rsi), %rax
	movq	16(%rsi), %rsi
	movq	%rdx, 32(%rdi)
	shrq	%rcx
	movq	%rcx, 40(%rdi)
	shldq	$63, %rax, %r10
	shldq	$63, %rsi, %rax
	movq	%rax, 16(%rdi)
	movq	%r10, 24(%rdi)
	shrdq	$1, %r9, %r8
	movq	%r8, (%rdi)
	shldq	$63, %r9, %rsi
	movq	%rsi, 8(%rdi)
	retq
.Lfunc_end42:
	.size	mcl_fp_shr1_6L, .Lfunc_end42-mcl_fp_shr1_6L
                                        # -- End function
	.globl	mcl_fp_add6L                    # -- Begin function mcl_fp_add6L
	.p2align	4, 0x90
	.type	mcl_fp_add6L,@function
mcl_fp_add6L:                           # @mcl_fp_add6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r10
	movq	32(%rdx), %r15
	movq	24(%rdx), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %r8
	movq	8(%rdx), %r14
	addq	(%rsi), %r8
	adcq	8(%rsi), %r14
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %r15
	adcq	40(%rsi), %r10
	setb	%dl
	movzbl	%dl, %r12d
	movq	%r8, %rbx
	subq	(%rcx), %rbx
	movq	%r14, %r13
	sbbq	8(%rcx), %r13
	movq	%r11, %rax
	sbbq	16(%rcx), %rax
	movq	%r9, %rdx
	sbbq	24(%rcx), %rdx
	movq	%r15, %rsi
	sbbq	32(%rcx), %rsi
	movq	%r10, %rbp
	sbbq	40(%rcx), %rbp
	sbbq	$0, %r12
	testb	$1, %r12b
	cmovneq	%r15, %rsi
	movq	%rsi, 32(%rdi)
	cmovneq	%r10, %rbp
	movq	%rbp, 40(%rdi)
	cmovneq	%r11, %rax
	movq	%rax, 16(%rdi)
	cmovneq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	cmovneq	%r8, %rbx
	movq	%rbx, (%rdi)
	cmovneq	%r14, %r13
	movq	%r13, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_addNF6L,@function
mcl_fp_addNF6L:                         # @mcl_fp_addNF6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r10
	movq	32(%rdx), %r15
	movq	24(%rdx), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %r8
	movq	8(%rdx), %r14
	addq	(%rsi), %r8
	adcq	8(%rsi), %r14
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r9
	adcq	32(%rsi), %r15
	adcq	40(%rsi), %r10
	movq	%r8, %r13
	subq	(%rcx), %r13
	movq	%r14, %r12
	sbbq	8(%rcx), %r12
	movq	%r11, %rdx
	sbbq	16(%rcx), %rdx
	movq	%r9, %rax
	sbbq	24(%rcx), %rax
	movq	%r15, %rbx
	sbbq	32(%rcx), %rbx
	movq	%r10, %rsi
	sbbq	40(%rcx), %rsi
	movq	%rsi, %rcx
	sarq	$63, %rcx
	cmovsq	%r15, %rbx
	movq	%rbx, 32(%rdi)
	cmovsq	%r10, %rsi
	movq	%rsi, 40(%rdi)
	cmovsq	%r11, %rdx
	movq	%rdx, 16(%rdi)
	cmovsq	%r9, %rax
	movq	%rax, 24(%rdi)
	cmovsq	%r8, %r13
	movq	%r13, (%rdi)
	cmovsq	%r14, %r12
	movq	%r12, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_sub6L,@function
mcl_fp_sub6L:                           # @mcl_fp_sub6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	xorl	%r11d, %r11d
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r14
	movq	(%rsi), %r12
	movq	8(%rsi), %r15
	subq	(%rdx), %r12
	sbbq	8(%rdx), %r15
	sbbq	16(%rdx), %r14
	sbbq	24(%rdx), %r10
	sbbq	32(%rdx), %r9
	sbbq	40(%rdx), %r8
	movl	$0, %eax
	sbbq	%rax, %rax
	andl	$1, %eax
	negq	%rax
	movl	$0, %r13d
	movl	$0, %eax
	movl	$0, %esi
	movl	$0, %ebx
	movl	$0, %edx
	jns	.LBB45_2
# %bb.1:
	movq	40(%rcx), %r11
	movq	32(%rcx), %r13
	movq	24(%rcx), %rax
	movq	16(%rcx), %rsi
	movq	8(%rcx), %rbx
	movq	(%rcx), %rdx
.LBB45_2:
	addq	%r12, %rdx
	movq	%rdx, (%rdi)
	adcq	%r15, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r14, %rsi
	movq	%rsi, 16(%rdi)
	adcq	%r10, %rax
	movq	%rax, 24(%rdi)
	adcq	%r9, %r13
	movq	%r13, 32(%rdi)
	adcq	%r8, %r11
	movq	%r11, 40(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_subNF6L,@function
mcl_fp_subNF6L:                         # @mcl_fp_subNF6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r15
	movq	32(%rsi), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %r14
	subq	(%rdx), %r11
	sbbq	8(%rdx), %r14
	sbbq	16(%rdx), %r10
	sbbq	24(%rdx), %r9
	sbbq	32(%rdx), %r8
	sbbq	40(%rdx), %r15
	movq	%r15, %rbx
	sarq	$63, %rbx
	movq	%rbx, %rsi
	shldq	$1, %r15, %rsi
	andq	(%rcx), %rsi
	movq	40(%rcx), %r12
	andq	%rbx, %r12
	movq	32(%rcx), %r13
	andq	%rbx, %r13
	movq	24(%rcx), %rdx
	andq	%rbx, %rdx
	movq	16(%rcx), %rax
	andq	%rbx, %rax
	andq	8(%rcx), %rbx
	addq	%r11, %rsi
	movq	%rsi, (%rdi)
	adcq	%r14, %rbx
	movq	%rbx, 8(%rdi)
	adcq	%r10, %rax
	movq	%rax, 16(%rdi)
	adcq	%r9, %rdx
	movq	%rdx, 24(%rdi)
	adcq	%r8, %r13
	movq	%r13, 32(%rdi)
	adcq	%r15, %r12
	movq	%r12, 40(%rdi)
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
	.p2align	4, 0x90
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
	movq	80(%rdx), %r15
	movq	72(%rdx), %r9
	movq	64(%rdx), %r14
	movq	56(%rdx), %r8
	movq	48(%rdx), %r10
	movq	40(%rdx), %rax
	movq	(%rdx), %r12
	movq	8(%rdx), %r13
	addq	(%rsi), %r12
	adcq	8(%rsi), %r13
	movq	32(%rdx), %rbx
	movq	24(%rdx), %rbp
	movq	16(%rdx), %rdx
	adcq	16(%rsi), %rdx
	adcq	24(%rsi), %rbp
	adcq	32(%rsi), %rbx
	adcq	40(%rsi), %rax
	adcq	48(%rsi), %r10
	adcq	56(%rsi), %r8
	adcq	64(%rsi), %r14
	adcq	72(%rsi), %r9
	adcq	80(%rsi), %r15
	adcq	88(%rsi), %r11
	movq	%rax, 40(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%rbp, 24(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%r13, 8(%rdi)
	movq	%r12, (%rdi)
	setb	%al
	movzbl	%al, %r12d
	movq	%r10, %rsi
	subq	(%rcx), %rsi
	movq	%r8, %r13
	sbbq	8(%rcx), %r13
	movq	%r14, %rbx
	sbbq	16(%rcx), %rbx
	movq	%r9, %rbp
	sbbq	24(%rcx), %rbp
	movq	%r15, %rdx
	sbbq	32(%rcx), %rdx
	movq	%r11, %rax
	sbbq	40(%rcx), %rax
	sbbq	$0, %r12
	testb	$1, %r12b
	cmovneq	%r15, %rdx
	movq	%rdx, 80(%rdi)
	cmovneq	%r11, %rax
	movq	%rax, 88(%rdi)
	cmovneq	%r14, %rbx
	movq	%rbx, 64(%rdi)
	cmovneq	%r9, %rbp
	movq	%rbp, 72(%rdi)
	cmovneq	%r10, %rsi
	movq	%rsi, 48(%rdi)
	cmovneq	%r8, %r13
	movq	%r13, 56(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_sub6L,@function
mcl_fpDbl_sub6L:                        # @mcl_fpDbl_sub6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r10
	movq	88(%rsi), %r15
	movq	80(%rsi), %r14
	movq	72(%rsi), %r11
	movq	64(%rsi), %r9
	movq	56(%rsi), %r8
	movq	48(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rcx
	movq	8(%rsi), %r13
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	sbbq	8(%rdx), %r13
	movq	40(%rsi), %rbx
	movq	32(%rsi), %rbp
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rsi
	sbbq	16(%rdx), %rsi
	sbbq	24(%rdx), %rcx
	sbbq	32(%rdx), %rbp
	sbbq	40(%rdx), %rbx
	movq	-16(%rsp), %r12                 # 8-byte Reload
	sbbq	48(%rdx), %r12
	movq	%r12, -16(%rsp)                 # 8-byte Spill
	sbbq	56(%rdx), %r8
	sbbq	64(%rdx), %r9
	sbbq	72(%rdx), %r11
	sbbq	80(%rdx), %r14
	sbbq	88(%rdx), %r15
	movq	%rbx, 40(%rdi)
	movq	%rbp, 32(%rdi)
	movq	%rcx, 24(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%r13, 8(%rdi)
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, (%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	negq	%rax
	movq	40(%r10), %rdx
	andq	%rax, %rdx
	movq	32(%r10), %rcx
	andq	%rax, %rcx
	movq	24(%r10), %rsi
	andq	%rax, %rsi
	movq	16(%r10), %rbx
	andq	%rax, %rbx
	movq	8(%r10), %rbp
	andq	%rax, %rbp
	andq	(%r10), %rax
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 48(%rdi)
	adcq	%r8, %rbp
	movq	%rbp, 56(%rdi)
	adcq	%r9, %rbx
	movq	%rbx, 64(%rdi)
	adcq	%r11, %rsi
	movq	%rsi, 72(%rdi)
	adcq	%r14, %rcx
	movq	%rcx, 80(%rdi)
	adcq	%r15, %rdx
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
	.p2align	4, 0x90
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
	movq	%rdx, %r10
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%rbx, %rax
	mulq	48(%rsi)
	movq	%rdx, %r11
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	mulq	40(%rsi)
	movq	%rdx, %r12
	movq	%rax, %r15
	movq	%rbx, %rax
	mulq	32(%rsi)
	movq	%rdx, %rcx
	movq	%rax, %r13
	movq	%rbx, %rax
	mulq	24(%rsi)
	movq	%rdx, %rbp
	movq	%rax, %r8
	movq	%rbx, %rax
	mulq	16(%rsi)
	movq	%rdx, %r9
	movq	%rax, %r14
	movq	%rbx, %rax
	mulq	8(%rsi)
	addq	-24(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 8(%rdi)
	adcq	%r14, %rdx
	movq	%rdx, 16(%rdi)
	adcq	%r8, %r9
	movq	%r9, 24(%rdi)
	adcq	%r13, %rbp
	movq	%rbp, 32(%rdi)
	adcq	%r15, %rcx
	movq	%rcx, 40(%rdi)
	adcq	-16(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 48(%rdi)
	adcq	-8(%rsp), %r11                  # 8-byte Folded Reload
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
.Lfunc_end49:
	.size	mulPv512x64, .Lfunc_end49-mulPv512x64
                                        # -- End function
	.globl	mcl_fp_mont8L                   # -- Begin function mcl_fp_mont8L
	.p2align	4, 0x90
	.type	mcl_fp_mont8L,@function
mcl_fp_mont8L:                          # @mcl_fp_mont8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1256, %rsp                     # imm = 0x4E8
	movq	%rcx, %rbp
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	%rsi, 72(%rsp)                  # 8-byte Spill
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 80(%rsp)                  # 8-byte Spill
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1184(%rsp), %rdi
	callq	mulPv512x64@PLT
	movq	1184(%rsp), %r15
	movq	1192(%rsp), %r12
	movq	%rbx, %rdx
	imulq	%r15, %rdx
	movq	1248(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	1240(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	1232(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	1224(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	1216(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	1208(%rsp), %rbx
	movq	1200(%rsp), %r14
	leaq	1112(%rsp), %rdi
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	addq	1112(%rsp), %r15
	adcq	1120(%rsp), %r12
	adcq	1128(%rsp), %r14
	adcq	1136(%rsp), %rbx
	movq	%rbx, %r13
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	1144(%rsp), %rbp
	movq	(%rsp), %rbx                    # 8-byte Reload
	adcq	1152(%rsp), %rbx
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	1160(%rsp), %r15
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	1168(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	1176(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	setb	24(%rsp)                        # 1-byte Folded Spill
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1040(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	24(%rsp), %eax                  # 1-byte Folded Reload
	addq	1040(%rsp), %r12
	adcq	1048(%rsp), %r14
	adcq	1056(%rsp), %r13
	adcq	1064(%rsp), %rbp
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	adcq	1072(%rsp), %rbx
	movq	%rbx, (%rsp)                    # 8-byte Spill
	adcq	1080(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	1088(%rsp), %rbp
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	1096(%rsp), %rbx
	adcq	1104(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	968(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r15b, %eax
	addq	968(%rsp), %r12
	adcq	976(%rsp), %r14
	adcq	984(%rsp), %r13
	movq	16(%rsp), %r15                  # 8-byte Reload
	adcq	992(%rsp), %r15
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	1000(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movq	32(%rsp), %r12                  # 8-byte Reload
	adcq	1008(%rsp), %r12
	adcq	1016(%rsp), %rbp
	movq	%rbp, 40(%rsp)                  # 8-byte Spill
	adcq	1024(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	1032(%rsp), %rbx
	movq	%rax, %rbp
	adcq	$0, %rbp
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	16(%rax), %rdx
	leaq	896(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	896(%rsp), %r14
	adcq	904(%rsp), %r13
	movq	%r13, 32(%rsp)                  # 8-byte Spill
	adcq	912(%rsp), %r15
	movq	%r15, %r13
	movq	(%rsp), %r15                    # 8-byte Reload
	adcq	920(%rsp), %r15
	adcq	928(%rsp), %r12
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	936(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	944(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	952(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	adcq	960(%rsp), %rbp
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	setb	%bl
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	824(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%bl, %eax
	addq	824(%rsp), %r14
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	832(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	840(%rsp), %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	adcq	848(%rsp), %r15
	movq	%r15, (%rsp)                    # 8-byte Spill
	adcq	856(%rsp), %r12
	movq	40(%rsp), %r13                  # 8-byte Reload
	adcq	864(%rsp), %r13
	movq	8(%rsp), %rbp                   # 8-byte Reload
	adcq	872(%rsp), %rbp
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	880(%rsp), %rbx
	movq	48(%rsp), %r15                  # 8-byte Reload
	adcq	888(%rsp), %r15
	adcq	$0, %rax
	movq	%rax, %r14
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	24(%rax), %rdx
	leaq	752(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	752(%rsp), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	760(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	768(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	adcq	776(%rsp), %r12
	adcq	784(%rsp), %r13
	adcq	792(%rsp), %rbp
	movq	%rbp, 8(%rsp)                   # 8-byte Spill
	adcq	800(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	adcq	808(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	adcq	816(%rsp), %r14
	movq	%r14, %rbx
	setb	%r15b
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r14
	leaq	680(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r15b, %eax
	addq	680(%rsp), %r14
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	688(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rbp                    # 8-byte Reload
	adcq	696(%rsp), %rbp
	adcq	704(%rsp), %r12
	adcq	712(%rsp), %r13
	movq	8(%rsp), %r15                   # 8-byte Reload
	adcq	720(%rsp), %r15
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	728(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	736(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	adcq	744(%rsp), %rbx
	adcq	$0, %rax
	movq	%rax, %r14
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	32(%rax), %rdx
	leaq	608(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	16(%rsp), %rax                  # 8-byte Reload
	addq	608(%rsp), %rax
	adcq	616(%rsp), %rbp
	movq	%rbp, (%rsp)                    # 8-byte Spill
	adcq	624(%rsp), %r12
	adcq	632(%rsp), %r13
	adcq	640(%rsp), %r15
	movq	%r15, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %r15                  # 8-byte Reload
	adcq	648(%rsp), %r15
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	656(%rsp), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	adcq	664(%rsp), %rbx
	adcq	672(%rsp), %r14
	movq	%r14, 16(%rsp)                  # 8-byte Spill
	setb	%bpl
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r14
	leaq	536(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%bpl, %eax
	addq	536(%rsp), %r14
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	544(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	adcq	552(%rsp), %r12
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	adcq	560(%rsp), %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r13                   # 8-byte Reload
	adcq	568(%rsp), %r13
	adcq	576(%rsp), %r15
	movq	%r15, %r12
	movq	48(%rsp), %rbp                  # 8-byte Reload
	adcq	584(%rsp), %rbp
	adcq	592(%rsp), %rbx
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	600(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	%rax, %r14
	adcq	$0, %r14
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	40(%rax), %rdx
	leaq	464(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	(%rsp), %rax                    # 8-byte Reload
	addq	464(%rsp), %rax
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	472(%rsp), %r15
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	480(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	488(%rsp), %r13
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	adcq	496(%rsp), %r12
	movq	%r12, 24(%rsp)                  # 8-byte Spill
	adcq	504(%rsp), %rbp
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	adcq	512(%rsp), %rbx
	movq	%rbx, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %r13                  # 8-byte Reload
	adcq	520(%rsp), %r13
	adcq	528(%rsp), %r14
	movq	%r14, 88(%rsp)                  # 8-byte Spill
	setb	%bpl
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r14
	leaq	392(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%bpl, %eax
	addq	392(%rsp), %r14
	adcq	400(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r12                  # 8-byte Reload
	adcq	408(%rsp), %r12
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	416(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	424(%rsp), %rbp
	movq	48(%rsp), %rbx                  # 8-byte Reload
	adcq	432(%rsp), %rbx
	movq	(%rsp), %rcx                    # 8-byte Reload
	adcq	440(%rsp), %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	adcq	448(%rsp), %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %r13                  # 8-byte Reload
	adcq	456(%rsp), %r13
	adcq	$0, %rax
	movq	%rax, %r15
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	48(%rax), %rdx
	leaq	320(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	248(%rsp), %rdi
	movq	32(%rsp), %r14                  # 8-byte Reload
	addq	320(%rsp), %r14
	adcq	328(%rsp), %r12
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	336(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	344(%rsp), %rbp
	movq	%rbp, 24(%rsp)                  # 8-byte Spill
	adcq	352(%rsp), %rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rbx                    # 8-byte Reload
	adcq	360(%rsp), %rbx
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	368(%rsp), %rbp
	adcq	376(%rsp), %r13
	movq	%r13, 88(%rsp)                  # 8-byte Spill
	adcq	384(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	setb	%r12b
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movzbl	%r12b, %r12d
	addq	248(%rsp), %r14
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	256(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r13                   # 8-byte Reload
	adcq	264(%rsp), %r13
	movq	24(%rsp), %r14                  # 8-byte Reload
	adcq	272(%rsp), %r14
	movq	48(%rsp), %r15                  # 8-byte Reload
	adcq	280(%rsp), %r15
	adcq	288(%rsp), %rbx
	adcq	296(%rsp), %rbp
	movq	88(%rsp), %rax                  # 8-byte Reload
	adcq	304(%rsp), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	312(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	adcq	$0, %r12
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	56(%rax), %rdx
	leaq	176(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	40(%rsp), %rax                  # 8-byte Reload
	addq	176(%rsp), %rax
	adcq	184(%rsp), %r13
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	adcq	192(%rsp), %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	adcq	200(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	adcq	208(%rsp), %rbx
	movq	%rbx, (%rsp)                    # 8-byte Spill
	adcq	216(%rsp), %rbp
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rbx                  # 8-byte Reload
	adcq	224(%rsp), %rbx
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	232(%rsp), %r15
	adcq	240(%rsp), %r12
	setb	%r14b
	movq	80(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r13
	leaq	104(%rsp), %rdi
	movq	56(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	movzbl	%r14b, %r11d
	addq	104(%rsp), %r13
	movq	8(%rsp), %r10                   # 8-byte Reload
	adcq	112(%rsp), %r10
	movq	%r10, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %r9                   # 8-byte Reload
	adcq	120(%rsp), %r9
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rsi                  # 8-byte Reload
	adcq	128(%rsp), %rsi
	movq	(%rsp), %rax                    # 8-byte Reload
	adcq	136(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	16(%rsp), %rdi                  # 8-byte Reload
	adcq	144(%rsp), %rdi
	adcq	152(%rsp), %rbx
	movq	%rbx, %r14
	adcq	160(%rsp), %r15
	adcq	168(%rsp), %r12
	adcq	$0, %r11
	movq	%rbp, %rcx
	subq	(%rbp), %r10
	sbbq	8(%rbp), %r9
	movq	%rsi, %r8
	movq	%rsi, %r13
	sbbq	16(%rbp), %r8
	movq	%rax, %rsi
	sbbq	24(%rbp), %rsi
	movq	%rdi, %rbx
	sbbq	32(%rbp), %rbx
	movq	%r14, %rbp
	sbbq	40(%rcx), %rbp
	movq	%r15, %rax
	sbbq	48(%rcx), %rax
	movq	%rcx, %rdx
	movq	%r12, %rcx
	sbbq	56(%rdx), %rcx
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%r15, %rax
	movq	96(%rsp), %rdx                  # 8-byte Reload
	movq	%rax, 48(%rdx)
	cmovneq	%r12, %rcx
	movq	%rcx, 56(%rdx)
	cmovneq	%rdi, %rbx
	movq	%rbx, 32(%rdx)
	cmovneq	%r14, %rbp
	movq	%rbp, 40(%rdx)
	cmovneq	%r13, %r8
	movq	%r8, 16(%rdx)
	cmovneq	(%rsp), %rsi                    # 8-byte Folded Reload
	movq	%rsi, 24(%rdx)
	cmovneq	8(%rsp), %r10                   # 8-byte Folded Reload
	movq	%r10, (%rdx)
	cmovneq	24(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, 8(%rdx)
	addq	$1256, %rsp                     # imm = 0x4E8
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
	.p2align	4, 0x90
	.type	mcl_fp_montNF8L,@function
mcl_fp_montNF8L:                        # @mcl_fp_montNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1256, %rsp                     # imm = 0x4E8
	movq	%rcx, %rbp
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%rsi, 80(%rsp)                  # 8-byte Spill
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movq	-8(%rcx), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdx
	leaq	1184(%rsp), %rdi
	callq	mulPv512x64@PLT
	movq	1184(%rsp), %r15
	movq	1192(%rsp), %r12
	movq	%rbx, %rdx
	imulq	%r15, %rdx
	movq	1248(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	1240(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	1232(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	1224(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	1216(%rsp), %rbx
	movq	1208(%rsp), %r13
	movq	1200(%rsp), %r14
	leaq	1112(%rsp), %rdi
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	addq	1112(%rsp), %r15
	adcq	1120(%rsp), %r12
	adcq	1128(%rsp), %r14
	adcq	1136(%rsp), %r13
	adcq	1144(%rsp), %rbx
	movq	%rbx, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	1152(%rsp), %rbx
	movq	24(%rsp), %r15                  # 8-byte Reload
	adcq	1160(%rsp), %r15
	movq	48(%rsp), %rbp                  # 8-byte Reload
	adcq	1168(%rsp), %rbp
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	1176(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	8(%rax), %rdx
	leaq	1040(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	1104(%rsp), %rcx
	addq	1040(%rsp), %r12
	adcq	1048(%rsp), %r14
	adcq	1056(%rsp), %r13
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	1064(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	adcq	1072(%rsp), %rbx
	adcq	1080(%rsp), %r15
	movq	%r15, 24(%rsp)                  # 8-byte Spill
	adcq	1088(%rsp), %rbp
	movq	16(%rsp), %r15                  # 8-byte Reload
	adcq	1096(%rsp), %r15
	adcq	$0, %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	968(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	968(%rsp), %r12
	adcq	976(%rsp), %r14
	adcq	984(%rsp), %r13
	movq	40(%rsp), %r12                  # 8-byte Reload
	adcq	992(%rsp), %r12
	adcq	1000(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	1008(%rsp), %rbx
	adcq	1016(%rsp), %rbp
	adcq	1024(%rsp), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %r15                  # 8-byte Reload
	adcq	1032(%rsp), %r15
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	16(%rax), %rdx
	leaq	896(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	960(%rsp), %rax
	addq	896(%rsp), %r14
	adcq	904(%rsp), %r13
	adcq	912(%rsp), %r12
	movq	%r12, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	920(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	928(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	adcq	936(%rsp), %rbp
	movq	16(%rsp), %r12                  # 8-byte Reload
	adcq	944(%rsp), %r12
	adcq	952(%rsp), %r15
	adcq	$0, %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	824(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	824(%rsp), %r14
	adcq	832(%rsp), %r13
	movq	40(%rsp), %r14                  # 8-byte Reload
	adcq	840(%rsp), %r14
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	848(%rsp), %rbx
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	856(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	adcq	864(%rsp), %rbp
	adcq	872(%rsp), %r12
	adcq	880(%rsp), %r15
	movq	56(%rsp), %rax                  # 8-byte Reload
	adcq	888(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	24(%rax), %rdx
	leaq	752(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	816(%rsp), %rax
	addq	752(%rsp), %r13
	adcq	760(%rsp), %r14
	movq	%r14, 40(%rsp)                  # 8-byte Spill
	adcq	768(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	776(%rsp), %rbx
	adcq	784(%rsp), %rbp
	adcq	792(%rsp), %r12
	movq	%r12, 16(%rsp)                  # 8-byte Spill
	adcq	800(%rsp), %r15
	movq	56(%rsp), %r12                  # 8-byte Reload
	adcq	808(%rsp), %r12
	movq	%rax, %r14
	adcq	$0, %r14
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	680(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	680(%rsp), %r13
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	688(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	696(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	704(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	movq	%rbp, %r13
	adcq	712(%rsp), %r13
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	720(%rsp), %rbp
	movq	%r15, %rbx
	adcq	728(%rsp), %rbx
	movq	%r12, %r15
	adcq	736(%rsp), %r15
	adcq	744(%rsp), %r14
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	32(%rax), %rdx
	leaq	608(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	672(%rsp), %r12
	movq	40(%rsp), %rax                  # 8-byte Reload
	addq	608(%rsp), %rax
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	616(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	624(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	632(%rsp), %r13
	movq	%r13, 48(%rsp)                  # 8-byte Spill
	adcq	640(%rsp), %rbp
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	adcq	648(%rsp), %rbx
	movq	%rbx, 32(%rsp)                  # 8-byte Spill
	adcq	656(%rsp), %r15
	adcq	664(%rsp), %r14
	adcq	$0, %r12
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbp
	leaq	536(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	536(%rsp), %rbp
	movq	8(%rsp), %r13                   # 8-byte Reload
	adcq	544(%rsp), %r13
	movq	24(%rsp), %rbx                  # 8-byte Reload
	adcq	552(%rsp), %rbx
	movq	48(%rsp), %rbp                  # 8-byte Reload
	adcq	560(%rsp), %rbp
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	568(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	576(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	adcq	584(%rsp), %r15
	adcq	592(%rsp), %r14
	movq	%r14, 8(%rsp)                   # 8-byte Spill
	adcq	600(%rsp), %r12
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	40(%rax), %rdx
	leaq	464(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	528(%rsp), %r14
	addq	464(%rsp), %r13
	adcq	472(%rsp), %rbx
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	adcq	480(%rsp), %rbp
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	488(%rsp), %rbp
	movq	32(%rsp), %rbx                  # 8-byte Reload
	adcq	496(%rsp), %rbx
	adcq	504(%rsp), %r15
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	512(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	520(%rsp), %r12
	adcq	$0, %r14
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	392(%rsp), %rdi
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	392(%rsp), %r13
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	400(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	408(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	adcq	416(%rsp), %rbp
	adcq	424(%rsp), %rbx
	movq	%rbx, 32(%rsp)                  # 8-byte Spill
	adcq	432(%rsp), %r15
	movq	%r15, 56(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	440(%rsp), %rbx
	adcq	448(%rsp), %r12
	adcq	456(%rsp), %r14
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	48(%rax), %rdx
	leaq	320(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	248(%rsp), %rdi
	movq	384(%rsp), %r13
	movq	24(%rsp), %rax                  # 8-byte Reload
	addq	320(%rsp), %rax
	movq	48(%rsp), %r15                  # 8-byte Reload
	adcq	328(%rsp), %r15
	adcq	336(%rsp), %rbp
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	344(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rcx                  # 8-byte Reload
	adcq	352(%rsp), %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	adcq	360(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	adcq	368(%rsp), %r12
	adcq	376(%rsp), %r14
	adcq	$0, %r13
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	176(%rsp), %rdi
	addq	248(%rsp), %rbx
	adcq	256(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	adcq	264(%rsp), %rbp
	movq	%rbp, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rbp                  # 8-byte Reload
	adcq	272(%rsp), %rbp
	movq	56(%rsp), %rax                  # 8-byte Reload
	adcq	280(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rbx                   # 8-byte Reload
	adcq	288(%rsp), %rbx
	adcq	296(%rsp), %r12
	adcq	304(%rsp), %r14
	adcq	312(%rsp), %r13
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	56(%rax), %rdx
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	leaq	104(%rsp), %rdi
	movq	240(%rsp), %r15
	movq	48(%rsp), %rax                  # 8-byte Reload
	addq	176(%rsp), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	184(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	192(%rsp), %rbp
	movq	%rbp, 32(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rbp                  # 8-byte Reload
	adcq	200(%rsp), %rbp
	adcq	208(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	adcq	216(%rsp), %r12
	adcq	224(%rsp), %r14
	adcq	232(%rsp), %r13
	adcq	$0, %r15
	movq	72(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	movq	64(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addq	104(%rsp), %rbx
	movq	16(%rsp), %r9                   # 8-byte Reload
	adcq	112(%rsp), %r9
	movq	%r9, 16(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %r8                   # 8-byte Reload
	adcq	120(%rsp), %r8
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	movq	%rbp, %r10
	adcq	128(%rsp), %r10
	movq	8(%rsp), %r11                   # 8-byte Reload
	adcq	136(%rsp), %r11
	adcq	144(%rsp), %r12
	adcq	152(%rsp), %r14
	adcq	160(%rsp), %r13
	adcq	168(%rsp), %r15
	movq	64(%rsp), %rax                  # 8-byte Reload
	subq	(%rax), %r9
	sbbq	8(%rax), %r8
	movq	%r10, %rdx
	sbbq	16(%rax), %rdx
	movq	%r11, %rsi
	sbbq	24(%rax), %rsi
	movq	%r12, %rdi
	sbbq	32(%rax), %rdi
	movq	%r14, %rbp
	sbbq	40(%rax), %rbp
	movq	%r13, %rbx
	sbbq	48(%rax), %rbx
	movq	%rax, %rcx
	movq	%r15, %rax
	sbbq	56(%rcx), %rax
	cmovsq	%r13, %rbx
	movq	96(%rsp), %rcx                  # 8-byte Reload
	movq	%rbx, 48(%rcx)
	cmovsq	%r15, %rax
	movq	%rax, 56(%rcx)
	cmovsq	%r12, %rdi
	movq	%rdi, 32(%rcx)
	cmovsq	%r14, %rbp
	movq	%rbp, 40(%rcx)
	cmovsq	%r10, %rdx
	movq	%rdx, 16(%rcx)
	cmovsq	%r11, %rsi
	movq	%rsi, 24(%rcx)
	cmovsq	16(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, (%rcx)
	cmovsq	32(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r8, 8(%rcx)
	addq	$1256, %rsp                     # imm = 0x4E8
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
	.p2align	4, 0x90
	.type	mcl_fp_montRed8L,@function
mcl_fp_montRed8L:                       # @mcl_fp_montRed8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$744, %rsp                      # imm = 0x2E8
	movq	%rdi, 160(%rsp)                 # 8-byte Spill
	movq	56(%rdx), %rax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	movq	48(%rdx), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	%rsi, 72(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %r15
	movq	32(%rsi), %r13
	movq	24(%rsi), %rbx
	movq	16(%rsi), %r12
	movq	(%rsi), %rbp
	movq	8(%rsi), %r14
	movq	-8(%rdx), %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdx, %rsi
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	imulq	%rbp, %rdx
	leaq	672(%rsp), %rdi
	callq	mulPv512x64@PLT
	addq	672(%rsp), %rbp
	adcq	680(%rsp), %r14
	adcq	688(%rsp), %r12
	adcq	696(%rsp), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	adcq	704(%rsp), %r13
	adcq	712(%rsp), %r15
	movq	%r15, 56(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r15                  # 8-byte Reload
	adcq	720(%rsp), %r15
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	728(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rcx                  # 8-byte Reload
	movq	64(%rcx), %rax
	movq	%rcx, %rbx
	adcq	736(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	setb	%bpl
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	600(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	664(%rsp), %rax
	addb	$255, %bpl
	adcq	$0, %rax
	movq	%rax, %rdx
	addq	600(%rsp), %r14
	movq	%r12, %rax
	adcq	608(%rsp), %rax
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	616(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	624(%rsp), %r13
	movq	%r13, 88(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rcx                  # 8-byte Reload
	adcq	632(%rsp), %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	adcq	640(%rsp), %r15
	movq	32(%rsp), %r12                  # 8-byte Reload
	adcq	648(%rsp), %r12
	movq	16(%rsp), %rbp                  # 8-byte Reload
	adcq	656(%rsp), %rbp
	adcq	72(%rbx), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	setb	%bl
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r14
	leaq	528(%rsp), %rdi
	movq	80(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rsi
	callq	mulPv512x64@PLT
	movq	592(%rsp), %rax
	addb	$255, %bl
	adcq	$0, %rax
	movq	%rax, %rdx
	addq	528(%rsp), %r14
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	536(%rsp), %rax
	movq	88(%rsp), %rcx                  # 8-byte Reload
	adcq	544(%rsp), %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rbx                  # 8-byte Reload
	adcq	552(%rsp), %rbx
	adcq	560(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	adcq	568(%rsp), %r12
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	adcq	576(%rsp), %rbp
	movq	%rbp, %r15
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	584(%rsp), %rbp
	movq	72(%rsp), %rcx                  # 8-byte Reload
	adcq	80(%rcx), %rdx
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	setb	%r14b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r12
	leaq	456(%rsp), %rdi
	movq	%r13, %rsi
	callq	mulPv512x64@PLT
	movq	520(%rsp), %rax
	addb	$255, %r14b
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	456(%rsp), %r12
	movq	88(%rsp), %rax                  # 8-byte Reload
	adcq	464(%rsp), %rax
	adcq	472(%rsp), %rbx
	movq	%rbx, 56(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rdx                  # 8-byte Reload
	adcq	480(%rsp), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rdx                  # 8-byte Reload
	adcq	488(%rsp), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	adcq	496(%rsp), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	adcq	504(%rsp), %rbp
	movq	%rbp, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	512(%rsp), %rbp
	movq	72(%rsp), %rdx                  # 8-byte Reload
	adcq	88(%rdx), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	setb	%bl
	movq	64(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rdx
	imulq	%rax, %rdx
	movq	%rax, %r15
	leaq	384(%rsp), %rdi
	movq	%r13, %rsi
	callq	mulPv512x64@PLT
	movq	448(%rsp), %r14
	addb	$255, %bl
	adcq	$0, %r14
	addq	384(%rsp), %r15
	movq	56(%rsp), %rax                  # 8-byte Reload
	adcq	392(%rsp), %rax
	movq	48(%rsp), %r15                  # 8-byte Reload
	adcq	400(%rsp), %r15
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	408(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	416(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	424(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	432(%rsp), %rbp
	movq	%rbp, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	440(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	72(%rsp), %rcx                  # 8-byte Reload
	adcq	96(%rcx), %r14
	setb	%bl
	movq	%r12, %r13
	movq	%r12, %rdx
	imulq	%rax, %rdx
	movq	%rax, %rbp
	leaq	312(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	376(%rsp), %r12
	addb	$255, %bl
	adcq	$0, %r12
	addq	312(%rsp), %rbp
	movq	%r15, %rax
	adcq	320(%rsp), %rax
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	328(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	336(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	344(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	352(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	360(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	368(%rsp), %r14
	movq	72(%rsp), %rbp                  # 8-byte Reload
	adcq	104(%rbp), %r12
	setb	%r15b
	movq	%r13, %rdx
	imulq	%rax, %rdx
	movq	%rax, %rbx
	leaq	240(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	304(%rsp), %r13
	addb	$255, %r15b
	adcq	$0, %r13
	addq	240(%rsp), %rbx
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	248(%rsp), %rax
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	256(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	264(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	272(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	280(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	288(%rsp), %r14
	adcq	296(%rsp), %r12
	adcq	112(%rbp), %r13
	setb	%r15b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbx
	leaq	168(%rsp), %rdi
	movq	80(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addb	$255, %r15b
	movq	232(%rsp), %r11
	adcq	$0, %r11
	addq	168(%rsp), %rbx
	movq	16(%rsp), %r9                   # 8-byte Reload
	adcq	176(%rsp), %r9
	movq	%r9, 16(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %r10                  # 8-byte Reload
	adcq	184(%rsp), %r10
	movq	%r10, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r15                  # 8-byte Reload
	adcq	192(%rsp), %r15
	movq	8(%rsp), %rsi                   # 8-byte Reload
	adcq	200(%rsp), %rsi
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	adcq	208(%rsp), %r14
	adcq	216(%rsp), %r12
	adcq	224(%rsp), %r13
	adcq	120(%rbp), %r11
	setb	%r8b
	subq	96(%rsp), %r9                   # 8-byte Folded Reload
	sbbq	104(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r15, %rdi
	sbbq	112(%rsp), %rdi                 # 8-byte Folded Reload
	sbbq	120(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r14, %rbp
	sbbq	128(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r12, %rbx
	sbbq	136(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r13, %rcx
	sbbq	144(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r11, %rax
	sbbq	152(%rsp), %rax                 # 8-byte Folded Reload
	movzbl	%r8b, %edx
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%r13, %rcx
	movq	160(%rsp), %rdx                 # 8-byte Reload
	movq	%rcx, 48(%rdx)
	cmovneq	%r11, %rax
	movq	%rax, 56(%rdx)
	cmovneq	%r14, %rbp
	movq	%rbp, 32(%rdx)
	cmovneq	%r12, %rbx
	movq	%rbx, 40(%rdx)
	cmovneq	%r15, %rdi
	movq	%rdi, 16(%rdx)
	cmovneq	8(%rsp), %rsi                   # 8-byte Folded Reload
	movq	%rsi, 24(%rdx)
	cmovneq	16(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, (%rdx)
	cmovneq	24(%rsp), %r10                  # 8-byte Folded Reload
	movq	%r10, 8(%rdx)
	addq	$744, %rsp                      # imm = 0x2E8
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
	.p2align	4, 0x90
	.type	mcl_fp_montRedNF8L,@function
mcl_fp_montRedNF8L:                     # @mcl_fp_montRedNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$728, %rsp                      # imm = 0x2D8
	movq	%rdi, 144(%rsp)                 # 8-byte Spill
	movq	56(%rdx), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	48(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rsi, 64(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsi), %r15
	movq	40(%rsi), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %r13
	movq	24(%rsi), %r12
	movq	16(%rsi), %r14
	movq	(%rsi), %rbx
	movq	8(%rsi), %rbp
	movq	-8(%rdx), %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdx, %rsi
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	imulq	%rbx, %rdx
	leaq	656(%rsp), %rdi
	callq	mulPv512x64@PLT
	addq	656(%rsp), %rbx
	adcq	664(%rsp), %rbp
	adcq	672(%rsp), %r14
	adcq	680(%rsp), %r12
	adcq	688(%rsp), %r13
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	696(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	adcq	704(%rsp), %r15
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	712(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	64(%rax), %rax
	adcq	720(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	setb	%bl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbp, %rdx
	leaq	584(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	648(%rsp), %rax
	addb	$255, %bl
	adcq	$0, %rax
	addq	584(%rsp), %rbp
	adcq	592(%rsp), %r14
	adcq	600(%rsp), %r12
	adcq	608(%rsp), %r13
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	616(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	adcq	624(%rsp), %r15
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	632(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	640(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	64(%rsp), %r15                  # 8-byte Reload
	adcq	72(%r15), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	setb	%bl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%r14, %rdx
	leaq	512(%rsp), %rdi
	movq	72(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	movq	576(%rsp), %rax
	addb	$255, %bl
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	512(%rsp), %r14
	adcq	520(%rsp), %r12
	adcq	528(%rsp), %r13
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	536(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	544(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	552(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	560(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	568(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	adcq	80(%r15), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	setb	%bl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%r12, %rdx
	leaq	440(%rsp), %rdi
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	movq	504(%rsp), %r14
	addb	$255, %bl
	adcq	$0, %r14
	addq	440(%rsp), %r12
	adcq	448(%rsp), %r13
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	456(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	464(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	472(%rsp), %rbp
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	480(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	488(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	496(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	adcq	88(%r15), %r14
	setb	%bl
	movq	56(%rsp), %r15                  # 8-byte Reload
	movq	%r15, %rdx
	imulq	%r13, %rdx
	leaq	368(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	432(%rsp), %r12
	addb	$255, %bl
	adcq	$0, %r12
	addq	368(%rsp), %r13
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	376(%rsp), %rcx
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	384(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	adcq	392(%rsp), %rbp
	movq	%rbp, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rbp                   # 8-byte Reload
	adcq	400(%rsp), %rbp
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	408(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	adcq	416(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	adcq	424(%rsp), %r14
	movq	64(%rsp), %rax                  # 8-byte Reload
	adcq	96(%rax), %r12
	setb	%bl
	movq	%r15, %rdx
	imulq	%rcx, %rdx
	movq	%rcx, %r15
	leaq	296(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	360(%rsp), %r13
	addb	$255, %bl
	adcq	$0, %r13
	addq	296(%rsp), %r15
	movq	48(%rsp), %rax                  # 8-byte Reload
	adcq	304(%rsp), %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	312(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	320(%rsp), %rbp
	movq	%rbp, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	328(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	336(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	344(%rsp), %r14
	adcq	352(%rsp), %r12
	movq	64(%rsp), %rcx                  # 8-byte Reload
	adcq	104(%rcx), %r13
	setb	%bl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %rbp
	leaq	224(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	288(%rsp), %r15
	addb	$255, %bl
	adcq	$0, %r15
	addq	224(%rsp), %rbp
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	232(%rsp), %rbp
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	240(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	248(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	256(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	264(%rsp), %r14
	adcq	272(%rsp), %r12
	adcq	280(%rsp), %r13
	movq	64(%rsp), %rcx                  # 8-byte Reload
	adcq	112(%rcx), %r15
	setb	%bl
	movq	56(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbp, %rdx
	leaq	152(%rsp), %rdi
	movq	72(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addb	$255, %bl
	movq	216(%rsp), %r10
	adcq	$0, %r10
	addq	152(%rsp), %rbp
	movq	8(%rsp), %r9                    # 8-byte Reload
	adcq	160(%rsp), %r9
	movq	%r9, 8(%rsp)                    # 8-byte Spill
	movq	16(%rsp), %r8                   # 8-byte Reload
	adcq	168(%rsp), %r8
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	movq	40(%rsp), %r11                  # 8-byte Reload
	adcq	176(%rsp), %r11
	adcq	184(%rsp), %r14
	adcq	192(%rsp), %r12
	adcq	200(%rsp), %r13
	adcq	208(%rsp), %r15
	movq	64(%rsp), %rsi                  # 8-byte Reload
	adcq	120(%rsi), %r10
	subq	80(%rsp), %r9                   # 8-byte Folded Reload
	sbbq	88(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r11, %rsi
	sbbq	96(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%r14, %rdi
	sbbq	104(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%r12, %rbx
	sbbq	112(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r13, %rbp
	sbbq	120(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r15, %rcx
	sbbq	128(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r10, %rax
	sbbq	136(%rsp), %rax                 # 8-byte Folded Reload
	cmovsq	%r15, %rcx
	movq	144(%rsp), %rdx                 # 8-byte Reload
	movq	%rcx, 48(%rdx)
	cmovsq	%r10, %rax
	movq	%rax, 56(%rdx)
	cmovsq	%r12, %rbx
	movq	%rbx, 32(%rdx)
	cmovsq	%r13, %rbp
	movq	%rbp, 40(%rdx)
	cmovsq	%r11, %rsi
	movq	%rsi, 16(%rdx)
	cmovsq	%r14, %rdi
	movq	%rdi, 24(%rdx)
	cmovsq	8(%rsp), %r9                    # 8-byte Folded Reload
	movq	%r9, (%rdx)
	cmovsq	16(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r8, 8(%rdx)
	addq	$728, %rsp                      # imm = 0x2D8
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
	.p2align	4, 0x90
	.type	mcl_fp_addPre8L,@function
mcl_fp_addPre8L:                        # @mcl_fp_addPre8L
# %bb.0:
	pushq	%rbx
	movq	56(%rdx), %r9
	movq	48(%rdx), %rcx
	movq	40(%rdx), %r8
	movq	32(%rdx), %rax
	movq	24(%rdx), %r10
	movq	16(%rdx), %r11
	movq	(%rdx), %rbx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r10
	adcq	32(%rsi), %rax
	adcq	40(%rsi), %r8
	adcq	48(%rsi), %rcx
	adcq	56(%rsi), %r9
	movq	%rcx, 48(%rdi)
	movq	%r9, 56(%rdi)
	movq	%rax, 32(%rdi)
	movq	%r8, 40(%rdi)
	movq	%r11, 16(%rdi)
	movq	%r10, 24(%rdi)
	movq	%rbx, (%rdi)
	movq	%rdx, 8(%rdi)
	setb	%al
	movzbl	%al, %eax
	popq	%rbx
	retq
.Lfunc_end54:
	.size	mcl_fp_addPre8L, .Lfunc_end54-mcl_fp_addPre8L
                                        # -- End function
	.globl	mcl_fp_subPre8L                 # -- Begin function mcl_fp_subPre8L
	.p2align	4, 0x90
	.type	mcl_fp_subPre8L,@function
mcl_fp_subPre8L:                        # @mcl_fp_subPre8L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	56(%rsi), %r8
	movq	48(%rsi), %rcx
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
	sbbq	48(%rdx), %rcx
	sbbq	56(%rdx), %r8
	movq	%rcx, 48(%rdi)
	movq	%r8, 56(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_shr1_8L,@function
mcl_fp_shr1_8L:                         # @mcl_fp_shr1_8L
# %bb.0:
	pushq	%rbx
	movq	48(%rsi), %r10
	movq	56(%rsi), %rcx
	movq	%rcx, %rdx
	shldq	$63, %r10, %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	movq	24(%rsi), %rax
	movq	16(%rsi), %r11
	movq	40(%rsi), %rbx
	movq	32(%rsi), %rsi
	movq	%rdx, 48(%rdi)
	shrq	%rcx
	movq	%rcx, 56(%rdi)
	shldq	$63, %rbx, %r10
	shldq	$63, %rsi, %rbx
	movq	%rbx, 32(%rdi)
	movq	%r10, 40(%rdi)
	shldq	$63, %rax, %rsi
	shldq	$63, %r11, %rax
	movq	%rax, 16(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_add8L,@function
mcl_fp_add8L:                           # @mcl_fp_add8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	48(%rdx), %r9
	movq	40(%rdx), %r10
	movq	32(%rdx), %r15
	movq	24(%rdx), %r13
	movq	16(%rdx), %rbp
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	adcq	16(%rsi), %rbp
	movq	%rbp, %rbx
	movq	%rbp, -24(%rsp)                 # 8-byte Spill
	adcq	24(%rsi), %r13
	adcq	32(%rsi), %r15
	adcq	40(%rsi), %r10
	adcq	48(%rsi), %r9
	adcq	56(%rsi), %r8
	setb	-25(%rsp)                       # 1-byte Folded Spill
	movq	%rax, %rsi
	subq	(%rcx), %rsi
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %rbx
	movq	%r13, %rbp
	sbbq	24(%rcx), %rbp
	movq	%r15, %r11
	sbbq	32(%rcx), %r11
	movq	%r10, %r14
	sbbq	40(%rcx), %r14
	movq	%r9, %r12
	sbbq	48(%rcx), %r12
	movq	%r8, %rax
	sbbq	56(%rcx), %rax
	movzbl	-25(%rsp), %ecx                 # 1-byte Folded Reload
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%r8, %rax
	movq	%rax, 56(%rdi)
	cmovneq	%r9, %r12
	movq	%r12, 48(%rdi)
	cmovneq	%r10, %r14
	movq	%r14, 40(%rdi)
	cmovneq	%r15, %r11
	movq	%r11, 32(%rdi)
	cmovneq	%r13, %rbp
	movq	%rbp, 24(%rdi)
	cmovneq	-24(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, 16(%rdi)
	cmovneq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_addNF8L,@function
mcl_fp_addNF8L:                         # @mcl_fp_addNF8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	48(%rdx), %r9
	movq	40(%rdx), %r10
	movq	32(%rdx), %r11
	movq	24(%rdx), %r15
	movq	16(%rdx), %rbx
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	addq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	adcq	16(%rsi), %rbx
	movq	%rbx, -24(%rsp)                 # 8-byte Spill
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r10
	adcq	48(%rsi), %r9
	adcq	56(%rsi), %r8
	movq	%rax, %rsi
	subq	(%rcx), %rsi
	sbbq	8(%rcx), %rdx
	sbbq	16(%rcx), %rbx
	movq	%r15, %rax
	sbbq	24(%rcx), %rax
	movq	%r11, %rbp
	sbbq	32(%rcx), %rbp
	movq	%r10, %r14
	sbbq	40(%rcx), %r14
	movq	%r9, %r12
	sbbq	48(%rcx), %r12
	movq	%r8, %r13
	sbbq	56(%rcx), %r13
	cmovsq	%r8, %r13
	movq	%r13, 56(%rdi)
	cmovsq	%r9, %r12
	movq	%r12, 48(%rdi)
	cmovsq	%r10, %r14
	movq	%r14, 40(%rdi)
	cmovsq	%r11, %rbp
	movq	%rbp, 32(%rdi)
	cmovsq	%r15, %rax
	movq	%rax, 24(%rdi)
	cmovsq	-24(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, 16(%rdi)
	cmovsq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 8(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fp_sub8L,@function
mcl_fp_sub8L:                           # @mcl_fp_sub8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	56(%rsi), %rax
	movq	48(%rsi), %rbp
	movq	40(%rsi), %rbx
	movq	32(%rsi), %r14
	movq	24(%rsi), %r15
	movq	16(%rsi), %r12
	movq	(%rsi), %r11
	movq	8(%rsi), %r13
	subq	(%rdx), %r11
	sbbq	8(%rdx), %r13
	sbbq	16(%rdx), %r12
	sbbq	24(%rdx), %r15
	sbbq	32(%rdx), %r14
	sbbq	40(%rdx), %rbx
	movq	%rbx, -24(%rsp)                 # 8-byte Spill
	movl	$0, %ebx
	sbbq	48(%rdx), %rbp
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	sbbq	56(%rdx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movl	$0, %eax
	sbbq	%rax, %rax
	andl	$1, %eax
	negq	%rax
	movl	$0, %edx
	movl	$0, %eax
	movl	$0, %esi
	movl	$0, %ebp
	movl	$0, %r8d
	movl	$0, %r9d
	movl	$0, %r10d
	jns	.LBB59_2
# %bb.1:
	movq	56(%rcx), %rbx
	movq	48(%rcx), %rdx
	movq	40(%rcx), %rax
	movq	32(%rcx), %rsi
	movq	24(%rcx), %rbp
	movq	16(%rcx), %r8
	movq	8(%rcx), %r9
	movq	(%rcx), %r10
.LBB59_2:
	addq	%r11, %r10
	adcq	%r13, %r9
	movq	%r10, (%rdi)
	adcq	%r12, %r8
	movq	%r9, 8(%rdi)
	movq	%r8, 16(%rdi)
	adcq	%r15, %rbp
	movq	%rbp, 24(%rdi)
	adcq	%r14, %rsi
	movq	%rsi, 32(%rdi)
	adcq	-24(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 40(%rdi)
	adcq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 48(%rdi)
	adcq	-8(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%rbx, 56(%rdi)
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
	.p2align	4, 0x90
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
	movq	%rdi, %r9
	movq	56(%rsi), %r14
	movq	48(%rsi), %rax
	movq	40(%rsi), %rcx
	movq	32(%rsi), %rdi
	movq	24(%rsi), %r11
	movq	16(%rsi), %r15
	movq	(%rsi), %r13
	movq	8(%rsi), %r12
	subq	(%rdx), %r13
	sbbq	8(%rdx), %r12
	sbbq	16(%rdx), %r15
	sbbq	24(%rdx), %r11
	sbbq	32(%rdx), %rdi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	sbbq	40(%rdx), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	sbbq	48(%rdx), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	sbbq	56(%rdx), %r14
	movq	%r14, %rax
	sarq	$63, %rax
	movq	56(%r8), %r10
	andq	%rax, %r10
	movq	48(%r8), %rbx
	andq	%rax, %rbx
	movq	40(%r8), %rdi
	andq	%rax, %rdi
	movq	32(%r8), %rbp
	andq	%rax, %rbp
	movq	24(%r8), %rsi
	andq	%rax, %rsi
	movq	16(%r8), %rdx
	andq	%rax, %rdx
	movq	8(%r8), %rcx
	andq	%rax, %rcx
	andq	(%r8), %rax
	addq	%r13, %rax
	adcq	%r12, %rcx
	movq	%rax, (%r9)
	adcq	%r15, %rdx
	movq	%rcx, 8(%r9)
	movq	%rdx, 16(%r9)
	adcq	%r11, %rsi
	movq	%rsi, 24(%r9)
	adcq	-24(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, 32(%r9)
	adcq	-16(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdi, 40(%r9)
	adcq	-8(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%rbx, 48(%r9)
	adcq	%r14, %r10
	movq	%r10, 56(%r9)
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_add8L,@function
mcl_fpDbl_add8L:                        # @mcl_fpDbl_add8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r12
	movq	120(%rdx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	112(%rdx), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	104(%rdx), %r10
	movq	96(%rdx), %r8
	movq	88(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	80(%rdx), %rcx
	movq	72(%rdx), %r9
	movq	(%rdx), %rax
	movq	8(%rdx), %rbp
	addq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	adcq	8(%rsi), %rbp
	movq	%rbp, -24(%rsp)                 # 8-byte Spill
	movq	64(%rdx), %r13
	movq	56(%rdx), %r14
	movq	48(%rdx), %r11
	movq	40(%rdx), %r15
	movq	32(%rdx), %rbx
	movq	24(%rdx), %rbp
	movq	16(%rdx), %rdx
	adcq	16(%rsi), %rdx
	adcq	24(%rsi), %rbp
	adcq	32(%rsi), %rbx
	adcq	40(%rsi), %r15
	adcq	48(%rsi), %r11
	adcq	56(%rsi), %r14
	adcq	64(%rsi), %r13
	movq	%r13, -40(%rsp)                 # 8-byte Spill
	adcq	72(%rsi), %r9
	movq	%r9, -32(%rsp)                  # 8-byte Spill
	adcq	80(%rsi), %rcx
	movq	%rcx, -48(%rsp)                 # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	adcq	88(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	adcq	96(%rsi), %r8
	movq	%r8, -64(%rsp)                  # 8-byte Spill
	adcq	104(%rsi), %r10
	movq	%r10, -56(%rsp)                 # 8-byte Spill
	movq	-16(%rsp), %r10                 # 8-byte Reload
	adcq	112(%rsi), %r10
	movq	-80(%rsp), %r8                  # 8-byte Reload
	adcq	120(%rsi), %r8
	movq	%r14, 56(%rdi)
	movq	%r11, 48(%rdi)
	movq	%r15, 40(%rdi)
	movq	%rbx, 32(%rdi)
	movq	%rbp, 24(%rdi)
	movq	%rdx, 16(%rdi)
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 8(%rdi)
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, (%rdi)
	setb	-80(%rsp)                       # 1-byte Folded Spill
	movq	%r13, %r14
	subq	(%r12), %r14
	movq	%r9, %r15
	sbbq	8(%r12), %r15
	movq	%rcx, %rbp
	sbbq	16(%r12), %rbp
	movq	%rax, %r11
	sbbq	24(%r12), %r11
	movq	-64(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rbx
	sbbq	32(%r12), %rbx
	movq	-56(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rax
	sbbq	40(%r12), %rax
	movq	%r10, %rdx
	sbbq	48(%r12), %rdx
	movq	%r8, %rsi
	sbbq	56(%r12), %rsi
	movzbl	-80(%rsp), %ecx                 # 1-byte Folded Reload
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%r10, %rdx
	movq	%rdx, 112(%rdi)
	cmovneq	%r8, %rsi
	movq	%rsi, 120(%rdi)
	cmovneq	%r9, %rbx
	movq	%rbx, 96(%rdi)
	cmovneq	%r13, %rax
	movq	%rax, 104(%rdi)
	cmovneq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, 80(%rdi)
	cmovneq	-72(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, 88(%rdi)
	cmovneq	-40(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, 64(%rdi)
	cmovneq	-32(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, 72(%rdi)
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
	.p2align	4, 0x90
	.type	mcl_fpDbl_sub8L,@function
mcl_fpDbl_sub8L:                        # @mcl_fpDbl_sub8L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %r11
	movq	120(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	112(%rsi), %r12
	movq	104(%rsi), %r15
	movq	96(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %r13
	movq	80(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rcx
	movq	8(%rsi), %rbp
	xorl	%eax, %eax
	subq	(%rdx), %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	sbbq	8(%rdx), %rbp
	movq	%rbp, -40(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rbp
	movq	64(%rsi), %rcx
	movq	56(%rsi), %rbx
	movq	48(%rsi), %r14
	movq	40(%rsi), %r10
	movq	32(%rsi), %r9
	movq	24(%rsi), %r8
	movq	16(%rsi), %rsi
	sbbq	16(%rdx), %rsi
	sbbq	24(%rdx), %r8
	sbbq	32(%rdx), %r9
	sbbq	40(%rdx), %r10
	sbbq	48(%rdx), %r14
	sbbq	56(%rdx), %rbx
	sbbq	64(%rdx), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	sbbq	72(%rdx), %rbp
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rbp                 # 8-byte Reload
	sbbq	80(%rdx), %rbp
	movq	%rbp, -56(%rsp)                 # 8-byte Spill
	sbbq	88(%rdx), %r13
	movq	%r13, -8(%rsp)                  # 8-byte Spill
	movq	-48(%rsp), %r13                 # 8-byte Reload
	sbbq	96(%rdx), %r13
	movq	%r13, -48(%rsp)                 # 8-byte Spill
	sbbq	104(%rdx), %r15
	sbbq	112(%rdx), %r12
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	sbbq	120(%rdx), %rcx
	movq	%rcx, -64(%rsp)                 # 8-byte Spill
	movq	%rbx, 56(%rdi)
	movq	%r14, 48(%rdi)
	movq	%r10, 40(%rdi)
	movq	%r9, 32(%rdi)
	movq	%r8, 24(%rdi)
	movq	%rsi, 16(%rdi)
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 8(%rdi)
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, (%rdi)
	sbbq	%rax, %rax
	andl	$1, %eax
	negq	%rax
	movq	56(%r11), %r8
	andq	%rax, %r8
	movq	48(%r11), %r9
	andq	%rax, %r9
	movq	40(%r11), %r10
	andq	%rax, %r10
	movq	32(%r11), %rbx
	andq	%rax, %rbx
	movq	24(%r11), %rdx
	andq	%rax, %rdx
	movq	16(%r11), %rsi
	andq	%rax, %rsi
	movq	8(%r11), %rbp
	andq	%rax, %rbp
	andq	(%r11), %rax
	addq	-24(%rsp), %rax                 # 8-byte Folded Reload
	adcq	-16(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rax, 64(%rdi)
	adcq	-56(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rbp, 72(%rdi)
	movq	%rsi, 80(%rdi)
	adcq	-8(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, 88(%rdi)
	adcq	-48(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, 96(%rdi)
	adcq	%r15, %r10
	movq	%r10, 104(%rdi)
	adcq	%r12, %r9
	movq	%r9, 112(%rdi)
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r8, 120(%rdi)
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
