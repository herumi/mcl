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
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movq	%rsp, %rdi
	callq	mclb_sqr3@PLT
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
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	mcl_fp_sqr_NIST_P192L, .Lfunc_end2-mcl_fp_sqr_NIST_P192L
	.cfi_endproc
                                        # -- End function
	.globl	mcl_fp_mulNIST_P192L            # -- Begin function mcl_fp_mulNIST_P192L
	.p2align	4
	.type	mcl_fp_mulNIST_P192L,@function
mcl_fp_mulNIST_P192L:                   # @mcl_fp_mulNIST_P192L
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -16
	movq	%rdi, %rbx
	movq	%rsp, %rdi
	callq	mclb_mul3@PLT
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
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	mcl_fp_mulNIST_P192L, .Lfunc_end3-mcl_fp_mulNIST_P192L
	.cfi_endproc
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
# %bb.3:                                # %L2
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
.LBB4_1:                                # %L1
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
	movq	%rdi, %rax
	mulxq	(%rsi), %rdi, %rcx
	movq	%rdi, (%rax)
	mulxq	8(%rsi), %r8, %rdi
	addq	%rcx, %r8
	movq	%r8, 8(%rax)
	mulxq	16(%rsi), %rcx, %rdx
	adcq	%rdi, %rcx
	movq	%rcx, 16(%rax)
	adcq	$0, %rdx
	movq	%rdx, 24(%rax)
	retq
.Lfunc_end5:
	.size	mulPv192x64, .Lfunc_end5-mulPv192x64
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
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rdi
	movq	%rdi, -32(%rsp)                 # 8-byte Spill
	movq	%rax, %rdx
	mulxq	%rdi, %rdi, %r15
	movq	(%rsi), %r14
	movq	8(%rsi), %rsi
	movq	%rsi, -56(%rsp)                 # 8-byte Spill
	mulxq	%rsi, %rsi, %r12
	movq	%r14, %rdx
	mulxq	%rax, %rbx, %rbp
	addq	%rsi, %rbp
	adcq	%rdi, %r12
	adcq	$0, %r15
	movq	-8(%rcx), %r9
	movq	%r9, %rdx
	imulq	%rbx, %rdx
	movq	8(%rcx), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %r8
	movq	(%rcx), %rsi
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	mulxq	%rsi, %rsi, %r13
	addq	%rax, %r13
	movq	16(%rcx), %r11
	mulxq	%r11, %rcx, %rax
	movq	%r11, -24(%rsp)                 # 8-byte Spill
	adcq	%r8, %rcx
	adcq	$0, %rax
	addq	%rbx, %rsi
	adcq	%rbp, %r13
	movq	8(%r10), %rbx
	adcq	%r12, %rcx
	adcq	%r15, %rax
	movq	-32(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rdx
	mulxq	%rbx, %r8, %r15
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rbx, %rdi, %r12
	movq	%rbx, %rdx
	mulxq	%r14, %rsi, %rbp
	setb	%dl
	addq	%rdi, %rbp
	adcq	%r8, %r12
	adcq	$0, %r15
	addq	%r13, %rsi
	adcq	%rcx, %rbp
	movzbl	%dl, %ecx
	adcq	%rax, %r12
	adcq	%rcx, %r15
	setb	%cl
	movq	%r9, %rbx
	imulq	%rsi, %rbx
	movq	%r11, %rdx
	mulxq	%rbx, %rdi, %r13
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rbx, %r8, %rax
	movq	%rbx, %rdx
	mulxq	-48(%rsp), %rdx, %rbx           # 8-byte Folded Reload
	addq	%r8, %rbx
	adcq	%rdi, %rax
	adcq	$0, %r13
	addq	%rsi, %rdx
	adcq	%rbp, %rbx
	movzbl	%cl, %edi
	adcq	%r12, %rax
	adcq	%r15, %r13
	adcq	$0, %rdi
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	movq	16(%rcx), %r8
	movq	%r10, %rdx
	mulxq	%r8, %r15, %r10
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %r12, %r11
	movq	%r8, %rdx
	mulxq	%r14, %rsi, %rcx
	addq	%r12, %rcx
	adcq	%r15, %r11
	adcq	$0, %r10
	addq	%rbx, %rsi
	adcq	%rax, %rcx
	adcq	%r13, %r11
	adcq	%rdi, %r10
	setb	%dil
	imulq	%rsi, %r9
	movq	%r9, %rdx
	movq	-48(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rbx, %rax
	movq	-40(%rsp), %r12                 # 8-byte Reload
	movq	%r12, %rdx
	mulxq	%r9, %r8, %r15
	addq	%rax, %r8
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r9, %r14, %rax
	adcq	%r15, %r14
	adcq	$0, %rax
	addq	%rsi, %rbx
	adcq	%rcx, %r8
	adcq	%r11, %r14
	movzbl	%dil, %ecx
	adcq	%r10, %rax
	adcq	$0, %rcx
	movq	%r8, %rsi
	subq	%r13, %rsi
	movq	%r14, %rdi
	sbbq	%r12, %rdi
	movq	%rax, %r9
	sbbq	%rdx, %r9
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%r14, %rdi
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	movq	%rdi, 8(%rcx)
	cmovneq	%rax, %r9
	movq	%r9, 16(%rcx)
	cmovneq	%r8, %rsi
	movq	%rsi, (%rcx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end6:
	.size	mcl_fp_mont3L, .Lfunc_end6-mcl_fp_mont3L
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
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r15
	movq	(%r10), %r13
	movq	%r10, -40(%rsp)                 # 8-byte Spill
	mulxq	%r13, %r8, %rax
	movq	-8(%rcx), %rbx
	movq	(%rcx), %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movq	%rbx, %r14
	imulq	%r8, %r14
	movq	%r14, %rdx
	mulxq	%rdi, %rdi, %rbp
	addq	%rax, %rbp
	movq	%r15, %rdx
	mulxq	%r13, %r9, %r11
	movq	8(%rcx), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%r14, %r12, %rax
	adcq	%r11, %rax
	movq	16(%rsi), %r11
	movq	16(%rcx), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	mulxq	%r14, %rcx, %rsi
	movq	%r11, %rdx
	mulxq	%r13, %r14, %r13
	adcq	%rsi, %r13
	addq	%r8, %rdi
	adcq	%r9, %r12
	adcq	%rcx, %r14
	setb	%cl
	addq	%rbp, %r12
	movq	8(%r10), %rdx
	adcq	%rax, %r14
	movzbl	%cl, %eax
	adcq	%r13, %rax
	mulxq	%r15, %rsi, %rcx
	movq	-48(%rsp), %rbp                 # 8-byte Reload
	mulxq	%rbp, %rdi, %r8
	addq	%rsi, %r8
	mulxq	%r11, %r9, %rsi
	adcq	%rcx, %r9
	adcq	$0, %rsi
	addq	%r12, %rdi
	adcq	%r14, %r8
	adcq	%rax, %r9
	adcq	$0, %rsi
	movq	%rbx, %rdx
	imulq	%rdi, %rdx
	movq	-16(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rcx, %rax
	addq	%rdi, %rcx
	movq	-24(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %rdi, %rcx
	adcq	%r8, %rdi
	movq	-32(%rsp), %r10                 # 8-byte Reload
	mulxq	%r10, %r14, %rdx
	adcq	%r9, %r14
	adcq	$0, %rsi
	addq	%rax, %rdi
	adcq	%rcx, %r14
	adcq	%rdx, %rsi
	movq	-40(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rdx
	mulxq	%r15, %rcx, %rax
	mulxq	%rbp, %r15, %r9
	addq	%rcx, %r9
	mulxq	%r11, %rcx, %r8
	adcq	%rax, %rcx
	adcq	$0, %r8
	addq	%rdi, %r15
	adcq	%r14, %r9
	adcq	%rsi, %rcx
	adcq	$0, %r8
	imulq	%r15, %rbx
	movq	%rbx, %rdx
	mulxq	%r13, %rdx, %rax
	addq	%r15, %rdx
	movq	%rbx, %rdx
	mulxq	%r10, %rdi, %rsi
	mulxq	%r12, %r11, %rdx
	adcq	%r9, %r11
	adcq	%rcx, %rdi
	adcq	$0, %r8
	addq	%rax, %r11
	adcq	%rdx, %rdi
	adcq	%rsi, %r8
	movq	%r11, %rax
	subq	%r13, %rax
	movq	%rdi, %rcx
	sbbq	%r12, %rcx
	movq	%r8, %rdx
	sbbq	%r10, %rdx
	movq	%rdx, %rsi
	sarq	$63, %rsi
	cmovsq	%r8, %rdx
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	movq	%rdx, 16(%rsi)
	cmovsq	%r11, %rax
	movq	%rax, (%rsi)
	cmovsq	%rdi, %rcx
	movq	%rcx, 8(%rsi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end7:
	.size	mcl_fp_montNF3L, .Lfunc_end7-mcl_fp_montNF3L
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
	movq	(%rsi), %r10
	movq	-8(%rdx), %r8
	movq	(%rdx), %rdi
	movq	%r8, %rbx
	imulq	%r10, %rbx
	movq	16(%rdx), %rbp
	movq	%rbp, %rdx
	mulxq	%rbx, %r14, %r11
	movq	8(%r9), %rcx
	movq	%rcx, %rdx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	mulxq	%rbx, %r15, %r12
	movq	%rdi, %rdx
	mulxq	%rbx, %rdx, %r13
	addq	%r15, %r13
	adcq	%r14, %r12
	adcq	$0, %r11
	addq	%r10, %rdx
	adcq	8(%rsi), %r13
	adcq	16(%rsi), %r12
	adcq	24(%rsi), %r11
	setb	%r9b
	movq	%r8, %r10
	imulq	%r13, %r10
	movq	%rdi, %rdx
	mulxq	%r10, %rax, %r14
	movq	%rcx, %rdx
	mulxq	%r10, %rbx, %rcx
	addq	%r14, %rbx
	movq	%r10, %rdx
	mulxq	%rbp, %r15, %r10
	adcq	%rcx, %r15
	movq	40(%rsi), %r14
	movzbl	%r9b, %ecx
	adcq	%rcx, %r10
	addq	%r13, %rax
	adcq	%r12, %rbx
	adcq	%r11, %r15
	adcq	32(%rsi), %r10
	setb	%al
	imulq	%rbx, %r8
	movq	%rdi, %rdx
	mulxq	%r8, %r11, %rcx
	addq	%rbx, %r11
	movq	-16(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rdx
	mulxq	%r8, %rsi, %r12
	adcq	%r15, %rsi
	movq	%r8, %rdx
	mulxq	%rbp, %rdx, %r13
	adcq	%r10, %rdx
	movzbl	%al, %r8d
	adcq	%r14, %r8
	addq	%rcx, %rsi
	adcq	%r12, %rdx
	adcq	%r13, %r8
	cmpq	%rbx, %r11
	movq	%rsi, %rax
	sbbq	%r15, %rax
	movq	%rdx, %rax
	sbbq	%r10, %rax
	movq	%r8, %rax
	sbbq	%r14, %rax
	setb	%al
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	movq	%rdx, %rdi
	sbbq	%r9, %rdi
	movq	%r8, %r9
	sbbq	%rbp, %r9
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%r8, %r9
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%r9, 16(%rax)
	cmovneq	%rsi, %rcx
	movq	%rcx, (%rax)
	cmovneq	%rdx, %rdi
	movq	%rdi, 8(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end8:
	.size	mcl_fp_montRed3L, .Lfunc_end8-mcl_fp_montRed3L
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
	movq	%rdx, %r8
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r10
	movq	-8(%rdx), %r9
	movq	(%rdx), %rcx
	movq	%r9, %r14
	imulq	%r10, %r14
	movq	16(%rdx), %rdi
	movq	%rdi, %rdx
	mulxq	%r14, %r15, %r11
	movq	8(%r8), %r8
	movq	%r8, %rdx
	mulxq	%r14, %r13, %rbx
	movq	%rcx, %rdx
	mulxq	%r14, %rdx, %r12
	addq	%r13, %r12
	adcq	%r15, %rbx
	adcq	$0, %r11
	addq	%r10, %rdx
	adcq	8(%rsi), %r12
	adcq	16(%rsi), %rbx
	adcq	24(%rsi), %r11
	setb	%bpl
	movq	%r9, %r10
	imulq	%r12, %r10
	movq	%rcx, %rdx
	mulxq	%r10, %r13, %r15
	movq	%r8, %rdx
	mulxq	%r10, %r14, %rax
	addq	%r15, %r14
	movq	%r10, %rdx
	mulxq	%rdi, %r10, %rdx
	adcq	%rax, %r10
	movzbl	%bpl, %r15d
	adcq	%rdx, %r15
	addq	%r12, %r13
	adcq	%rbx, %r14
	adcq	%r11, %r10
	adcq	32(%rsi), %r15
	setb	%al
	imulq	%r14, %r9
	movq	%rcx, %rdx
	mulxq	%r9, %r12, %rbx
	movq	%r8, %rdx
	mulxq	%r9, %r11, %r13
	addq	%rbx, %r11
	movq	%r9, %rdx
	mulxq	%rdi, %r9, %rdx
	adcq	%r13, %r9
	movzbl	%al, %eax
	adcq	%rdx, %rax
	addq	%r14, %r12
	adcq	%r10, %r11
	adcq	%r15, %r9
	adcq	40(%rsi), %rax
	movq	%r11, %rdx
	subq	%rcx, %rdx
	movq	%r9, %rcx
	sbbq	%r8, %rcx
	movq	%rax, %rsi
	sbbq	%rdi, %rsi
	movq	%rsi, %rdi
	sarq	$63, %rdi
	cmovsq	%rax, %rsi
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rsi, 16(%rax)
	cmovsq	%r11, %rdx
	movq	%rdx, (%rax)
	cmovsq	%r9, %rcx
	movq	%rcx, 8(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end9:
	.size	mcl_fp_montRedNF3L, .Lfunc_end9-mcl_fp_montRedNF3L
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
.Lfunc_end10:
	.size	mcl_fp_addPre3L, .Lfunc_end10-mcl_fp_addPre3L
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
.Lfunc_end11:
	.size	mcl_fp_subPre3L, .Lfunc_end11-mcl_fp_subPre3L
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
.Lfunc_end12:
	.size	mcl_fp_shr1_3L, .Lfunc_end12-mcl_fp_shr1_3L
                                        # -- End function
	.globl	mcl_fp_add3L                    # -- Begin function mcl_fp_add3L
	.p2align	4
	.type	mcl_fp_add3L,@function
mcl_fp_add3L:                           # @mcl_fp_add3L
# %bb.0:
	movq	16(%rsi), %rax
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	addq	(%rdx), %r8
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %rax
	setb	%dl
	movzbl	%dl, %edx
	movq	%r8, %r9
	subq	(%rcx), %r9
	movq	%rsi, %r10
	sbbq	8(%rcx), %r10
	movq	%rax, %r11
	sbbq	16(%rcx), %r11
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%rax, %r11
	movq	%r11, 16(%rdi)
	cmovneq	%r8, %r9
	movq	%r9, (%rdi)
	cmovneq	%rsi, %r10
	movq	%r10, 8(%rdi)
	retq
.Lfunc_end13:
	.size	mcl_fp_add3L, .Lfunc_end13-mcl_fp_add3L
                                        # -- End function
	.globl	mcl_fp_addNF3L                  # -- Begin function mcl_fp_addNF3L
	.p2align	4
	.type	mcl_fp_addNF3L,@function
mcl_fp_addNF3L:                         # @mcl_fp_addNF3L
# %bb.0:
	movq	16(%rsi), %rax
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	addq	(%rdx), %r8
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %rax
	movq	%r8, %rdx
	subq	(%rcx), %rdx
	movq	%rsi, %r9
	sbbq	8(%rcx), %r9
	movq	%rax, %r10
	sbbq	16(%rcx), %r10
	movq	%r10, %rcx
	sarq	$63, %rcx
	cmovsq	%rax, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end14:
	.size	mcl_fp_addNF3L, .Lfunc_end14-mcl_fp_addNF3L
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
.Lfunc_end15:
	.size	mcl_fp_sub3L, .Lfunc_end15-mcl_fp_sub3L
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
.Lfunc_end16:
	.size	mcl_fp_subNF3L, .Lfunc_end16-mcl_fp_subNF3L
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
.Lfunc_end17:
	.size	mcl_fpDbl_add3L, .Lfunc_end17-mcl_fpDbl_add3L
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
.Lfunc_end18:
	.size	mcl_fpDbl_sub3L, .Lfunc_end18-mcl_fpDbl_sub3L
                                        # -- End function
	.globl	mulPv256x64                     # -- Begin function mulPv256x64
	.p2align	4
	.type	mulPv256x64,@function
mulPv256x64:                            # @mulPv256x64
# %bb.0:
	movq	%rdi, %rax
	mulxq	(%rsi), %rdi, %rcx
	movq	%rdi, (%rax)
	mulxq	8(%rsi), %r8, %rdi
	addq	%rcx, %r8
	movq	%r8, 8(%rax)
	mulxq	16(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 16(%rax)
	mulxq	24(%rsi), %rdx, %rsi
	adcq	%rcx, %rdx
	movq	%rdx, 24(%rax)
	adcq	$0, %rsi
	movq	%rsi, 32(%rax)
	retq
.Lfunc_end19:
	.size	mulPv256x64, .Lfunc_end19-mulPv256x64
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
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rdi
	movq	%rdi, -80(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdi, %rdx
	mulxq	%rax, %r8, %rbp
	movq	16(%rsi), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbx, %rdi
	movq	(%rsi), %r10
	movq	%r10, -56(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rsi, %r9
	movq	%r10, %rdx
	mulxq	%rax, %r11, %r10
	addq	%rsi, %r10
	adcq	%rbx, %r9
	adcq	%r8, %rdi
	adcq	$0, %rbp
	movq	-8(%rcx), %r15
	movq	%r15, %rax
	imulq	%r11, %rax
	movq	24(%rcx), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rax, %r14, %r13
	movq	16(%rcx), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbx, %r8
	movq	(%rcx), %r12
	movq	%r12, -72(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rcx, %rsi
	movq	%r12, %rdx
	mulxq	%rax, %rdx, %rax
	addq	%rcx, %rax
	adcq	%rbx, %rsi
	adcq	%r14, %r8
	adcq	$0, %r13
	addq	%r11, %rdx
	adcq	%r10, %rax
	adcq	%r9, %rsi
	adcq	%rdi, %r8
	adcq	%rbp, %r13
	movq	-16(%rsp), %r12                 # 8-byte Reload
	movq	8(%r12), %rdx
	mulxq	-80(%rsp), %r11, %r10           # 8-byte Folded Reload
	mulxq	-48(%rsp), %rbx, %rbp           # 8-byte Folded Reload
	mulxq	-64(%rsp), %r14, %rdi           # 8-byte Folded Reload
	mulxq	-56(%rsp), %r9, %rcx            # 8-byte Folded Reload
	setb	%dl
	addq	%r14, %rcx
	adcq	%rbx, %rdi
	adcq	%r11, %rbp
	adcq	$0, %r10
	addq	%rax, %r9
	adcq	%rsi, %rcx
	adcq	%r8, %rdi
	adcq	%r13, %rbp
	movzbl	%dl, %eax
	adcq	%rax, %r10
	setb	-81(%rsp)                       # 1-byte Folded Spill
	movq	%r15, %rdx
	imulq	%r9, %rdx
	mulxq	-24(%rsp), %rbx, %r13           # 8-byte Folded Reload
	mulxq	-32(%rsp), %r14, %rsi           # 8-byte Folded Reload
	mulxq	-40(%rsp), %r11, %rax           # 8-byte Folded Reload
	mulxq	-72(%rsp), %rdx, %r8            # 8-byte Folded Reload
	addq	%r11, %r8
	adcq	%r14, %rax
	adcq	%rbx, %rsi
	adcq	$0, %r13
	addq	%r9, %rdx
	adcq	%rcx, %r8
	adcq	%rdi, %rax
	adcq	%rbp, %rsi
	adcq	%r10, %r13
	movzbl	-81(%rsp), %r11d                # 1-byte Folded Reload
	adcq	$0, %r11
	movq	16(%r12), %rdx
	mulxq	-80(%rsp), %rbx, %rcx           # 8-byte Folded Reload
	mulxq	-48(%rsp), %r14, %rdi           # 8-byte Folded Reload
	mulxq	-64(%rsp), %r12, %rbp           # 8-byte Folded Reload
	mulxq	-56(%rsp), %r10, %r9            # 8-byte Folded Reload
	addq	%r12, %r9
	adcq	%r14, %rbp
	adcq	%rbx, %rdi
	adcq	$0, %rcx
	addq	%r8, %r10
	adcq	%rax, %r9
	adcq	%rsi, %rbp
	adcq	%r13, %rdi
	adcq	%r11, %rcx
	setb	%r11b
	movq	%r15, %rdx
	imulq	%r10, %rdx
	mulxq	-24(%rsp), %rbx, %r13           # 8-byte Folded Reload
	mulxq	-32(%rsp), %r14, %rsi           # 8-byte Folded Reload
	mulxq	-40(%rsp), %r12, %r8            # 8-byte Folded Reload
	mulxq	-72(%rsp), %rdx, %rax           # 8-byte Folded Reload
	addq	%r12, %rax
	adcq	%r14, %r8
	adcq	%rbx, %rsi
	adcq	$0, %r13
	addq	%r10, %rdx
	adcq	%r9, %rax
	adcq	%rbp, %r8
	adcq	%rdi, %rsi
	adcq	%rcx, %r13
	movzbl	%r11b, %r10d
	adcq	$0, %r10
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	movq	24(%rcx), %rdx
	mulxq	-80(%rsp), %r11, %rcx           # 8-byte Folded Reload
	mulxq	-48(%rsp), %rbx, %r9            # 8-byte Folded Reload
	mulxq	-64(%rsp), %r12, %r14           # 8-byte Folded Reload
	mulxq	-56(%rsp), %rbp, %rdi           # 8-byte Folded Reload
	addq	%r12, %rdi
	adcq	%rbx, %r14
	adcq	%r11, %r9
	adcq	$0, %rcx
	addq	%rax, %rbp
	adcq	%r8, %rdi
	adcq	%rsi, %r14
	adcq	%r13, %r9
	adcq	%r10, %rcx
	setb	-80(%rsp)                       # 1-byte Folded Spill
	imulq	%rbp, %r15
	movq	%r15, %rdx
	movq	-72(%rsp), %r8                  # 8-byte Reload
	mulxq	%r8, %r11, %rax
	movq	-40(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %r10, %rsi
	addq	%rax, %r10
	movq	-32(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %rax, %rbx
	adcq	%rsi, %rax
	movq	-24(%rsp), %r15                 # 8-byte Reload
	mulxq	%r15, %rsi, %rdx
	adcq	%rbx, %rsi
	adcq	$0, %rdx
	addq	%rbp, %r11
	adcq	%rdi, %r10
	adcq	%r14, %rax
	adcq	%r9, %rsi
	movzbl	-80(%rsp), %edi                 # 1-byte Folded Reload
	adcq	%rcx, %rdx
	adcq	$0, %rdi
	movq	%r10, %rcx
	subq	%r8, %rcx
	movq	%rax, %r8
	sbbq	%r13, %r8
	movq	%rsi, %r9
	sbbq	%r12, %r9
	movq	%rdx, %r11
	sbbq	%r15, %r11
	sbbq	$0, %rdi
	testb	$1, %dil
	cmovneq	%rsi, %r9
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	movq	%r9, 16(%rsi)
	cmovneq	%rax, %r8
	movq	%r8, 8(%rsi)
	cmovneq	%rdx, %r11
	movq	%r11, 24(%rsi)
	cmovneq	%r10, %rcx
	movq	%rcx, (%rsi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end20:
	.size	mcl_fp_mont4L, .Lfunc_end20-mcl_fp_mont4L
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
	movq	%rdx, %rax
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r9
	movq	%r9, -96(%rsp)                  # 8-byte Spill
	movq	(%rax), %r8
	mulxq	%r8, %r11, %rax
	movq	-8(%rcx), %r13
	movq	%r13, -80(%rsp)                 # 8-byte Spill
	movq	(%rcx), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	imulq	%r11, %r13
	mulxq	%r13, %r10, %rdi
	addq	%rax, %rdi
	movq	%r9, %rdx
	mulxq	%r8, %rdx, %rax
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%r13, %rbp, %r9
	adcq	%rax, %r9
	movq	16(%rsi), %rbx
	movq	%rbx, %rdx
	movq	%rbx, -32(%rsp)                 # 8-byte Spill
	mulxq	%r8, %r14, %r15
	movq	16(%rcx), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	mulxq	%r13, %rax, %r12
	adcq	%r15, %r12
	movq	24(%rsi), %rsi
	movq	24(%rcx), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r13, %r13, %rcx
	movq	%rsi, %rdx
	movq	%rsi, %r15
	movq	%rsi, -40(%rsp)                 # 8-byte Spill
	mulxq	%r8, %rsi, %rdx
	adcq	%rcx, %rdx
	addq	%r11, %r10
	adcq	-24(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	%r14, %rax
	adcq	%r13, %rsi
	setb	%cl
	addq	%rdi, %rbp
	adcq	%r9, %rax
	adcq	%r12, %rsi
	movzbl	%cl, %r10d
	adcq	%rdx, %r10
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	-96(%rsp), %r8, %rcx            # 8-byte Folded Reload
	mulxq	-88(%rsp), %r11, %rdi           # 8-byte Folded Reload
	addq	%r8, %rdi
	mulxq	%rbx, %r8, %r14
	adcq	%rcx, %r8
	mulxq	%r15, %r9, %rcx
	adcq	%r14, %r9
	adcq	$0, %rcx
	addq	%rbp, %r11
	adcq	%rax, %rdi
	adcq	%rsi, %r8
	adcq	%r10, %r9
	adcq	$0, %rcx
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	imulq	%r11, %rdx
	movq	-16(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rax, %rsi
	addq	%r11, %rax
	movq	-48(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %rax, %r10
	adcq	%rdi, %rax
	movq	-56(%rsp), %rbx                 # 8-byte Reload
	mulxq	%rbx, %rdi, %r11
	adcq	%r8, %rdi
	movq	-64(%rsp), %r15                 # 8-byte Reload
	mulxq	%r15, %r8, %rdx
	adcq	%r9, %r8
	adcq	$0, %rcx
	addq	%rsi, %rax
	adcq	%r10, %rdi
	adcq	%r11, %r8
	adcq	%rdx, %rcx
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	movq	16(%rdx), %rdx
	mulxq	-96(%rsp), %r10, %rsi           # 8-byte Folded Reload
	mulxq	-88(%rsp), %r11, %r9            # 8-byte Folded Reload
	addq	%r10, %r9
	mulxq	-32(%rsp), %r10, %r14           # 8-byte Folded Reload
	adcq	%rsi, %r10
	mulxq	-40(%rsp), %rbp, %rsi           # 8-byte Folded Reload
	adcq	%r14, %rbp
	adcq	$0, %rsi
	addq	%rax, %r11
	adcq	%rdi, %r9
	adcq	%r8, %r10
	adcq	%rcx, %rbp
	adcq	$0, %rsi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	imulq	%r11, %rdx
	mulxq	%r13, %rax, %rcx
	addq	%r11, %rax
	mulxq	%r12, %rax, %r11
	adcq	%r9, %rax
	mulxq	%rbx, %rdi, %r9
	adcq	%r10, %rdi
	mulxq	%r15, %r8, %rdx
	adcq	%rbp, %r8
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r11, %rdi
	adcq	%r9, %r8
	adcq	%rdx, %rsi
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	movq	24(%rcx), %rdx
	mulxq	-96(%rsp), %r10, %rcx           # 8-byte Folded Reload
	mulxq	-88(%rsp), %r11, %r9            # 8-byte Folded Reload
	addq	%r10, %r9
	mulxq	-32(%rsp), %r10, %r12           # 8-byte Folded Reload
	adcq	%rcx, %r10
	mulxq	-40(%rsp), %r14, %rcx           # 8-byte Folded Reload
	adcq	%r12, %r14
	adcq	$0, %rcx
	addq	%rax, %r11
	adcq	%rdi, %r9
	adcq	%r8, %r10
	adcq	%rsi, %r14
	adcq	$0, %rcx
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	imulq	%r11, %rdx
	mulxq	%r13, %rax, %rsi
	addq	%r11, %rax
	movq	-48(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %rax, %rdi
	adcq	%r9, %rax
	movq	-56(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r9, %r8
	adcq	%r10, %r9
	movq	-64(%rsp), %rbx                 # 8-byte Reload
	mulxq	%rbx, %r10, %rdx
	adcq	%r14, %r10
	adcq	$0, %rcx
	addq	%rsi, %rax
	adcq	%rdi, %r9
	adcq	%r8, %r10
	adcq	%rdx, %rcx
	movq	%rax, %rdx
	subq	%r13, %rdx
	movq	%r9, %rsi
	sbbq	%r11, %rsi
	movq	%r10, %rdi
	sbbq	%r12, %rdi
	movq	%rcx, %r8
	sbbq	%rbx, %r8
	cmovsq	%r9, %rsi
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%rsi, 8(%r9)
	cmovsq	%r10, %rdi
	movq	%rdi, 16(%r9)
	cmovsq	%rcx, %r8
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
.Lfunc_end21:
	.size	mcl_fp_montNF4L, .Lfunc_end21-mcl_fp_montNF4L
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
	movq	%rdx, %r8
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	-8(%rdx), %rcx
	movq	(%rdx), %r10
	movq	%rcx, %r9
	imulq	%rax, %r9
	movq	24(%rdx), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r11, %rbx
	movq	16(%r8), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r13, %r14
	movq	8(%r8), %r8
	movq	%r8, %rdx
	movq	%r8, -24(%rsp)                  # 8-byte Spill
	mulxq	%r9, %rbp, %r15
	movq	%r10, %rdx
	mulxq	%r9, %rdx, %r12
	addq	%rbp, %r12
	adcq	%r13, %r15
	adcq	%r11, %r14
	adcq	$0, %rbx
	addq	%rax, %rdx
	adcq	8(%rsi), %r12
	adcq	16(%rsi), %r15
	adcq	24(%rsi), %r14
	adcq	32(%rsi), %rbx
	setb	-40(%rsp)                       # 1-byte Folded Spill
	movq	%rcx, %r11
	imulq	%r12, %r11
	movq	%r10, %rdx
	movq	%r10, -16(%rsp)                 # 8-byte Spill
	mulxq	%r11, %rdi, %rax
	movq	%r8, %rdx
	mulxq	%r11, %r13, %r8
	addq	%rax, %r13
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rbp, %r9
	adcq	%r8, %rbp
	movq	%r11, %rdx
	mulxq	-32(%rsp), %rax, %rdx           # 8-byte Folded Reload
	adcq	%r9, %rax
	movzbl	-40(%rsp), %r9d                 # 1-byte Folded Reload
	adcq	%rdx, %r9
	addq	%r12, %rdi
	adcq	%r15, %r13
	adcq	%r14, %rbp
	adcq	%rbx, %rax
	adcq	40(%rsi), %r9
	setb	%r12b
	movq	%rcx, %r11
	imulq	%r13, %r11
	movq	%r10, %rdx
	mulxq	%r11, %r10, %r8
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rbx, %r15
	addq	%r8, %rbx
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r14, %r8
	adcq	%r15, %r14
	movq	%r11, %rdx
	movq	-32(%rsp), %rdi                 # 8-byte Reload
	mulxq	%rdi, %r15, %rdx
	adcq	%r8, %r15
	movzbl	%r12b, %r12d
	adcq	%rdx, %r12
	addq	%r13, %r10
	movq	56(%rsi), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	adcq	%rbp, %rbx
	adcq	%rax, %r14
	adcq	%r9, %r15
	adcq	48(%rsi), %r12
	setb	%al
	imulq	%rbx, %rcx
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rcx, %r8, %r13
	addq	%rbx, %r8
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rcx, %rsi, %r10
	adcq	%r14, %rsi
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%rcx, %r11, %rbp
	adcq	%r15, %r11
	movq	%rcx, %rdx
	mulxq	%rdi, %rdx, %rcx
	adcq	%r12, %rdx
	movzbl	%al, %r9d
	movq	-40(%rsp), %rdi                 # 8-byte Reload
	adcq	%rdi, %r9
	addq	%r13, %rsi
	adcq	%r10, %r11
	adcq	%rbp, %rdx
	adcq	%rcx, %r9
	xorl	%eax, %eax
	cmpq	%rbx, %r8
	movq	%rsi, %rcx
	sbbq	%r14, %rcx
	movq	%r11, %rcx
	sbbq	%r15, %rcx
	movq	%rdx, %rcx
	sbbq	%r12, %rcx
	movq	%r9, %rcx
	sbbq	%rdi, %rcx
	movl	$0, %ecx
	sbbq	%rcx, %rcx
	movl	$0, %ecx
	sbbq	%rcx, %rcx
	sbbq	%rax, %rax
	setb	%al
	movq	%rsi, %rcx
	subq	-16(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r11, %rdi
	sbbq	-24(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdx, %r8
	sbbq	-48(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r9, %r10
	sbbq	-32(%rsp), %r10                 # 8-byte Folded Reload
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rdx, %r8
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%r8, 16(%rax)
	cmovneq	%r9, %r10
	movq	%r10, 24(%rax)
	cmovneq	%rsi, %rcx
	movq	%rcx, (%rax)
	cmovneq	%r11, %rdi
	movq	%rdi, 8(%rax)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end22:
	.size	mcl_fp_montRed4L, .Lfunc_end22-mcl_fp_montRed4L
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
	movq	%rdx, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	-8(%rdx), %r10
	movq	(%rdx), %rcx
	movq	%r10, %rdi
	imulq	%rax, %rdi
	movq	24(%rdx), %rdx
	movq	%rdx, %r8
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r11, %rbx
	movq	16(%r9), %rbp
	movq	%rbp, %rdx
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r14, %r15
	movq	8(%r9), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r12, %r13
	movq	%rcx, %rdx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdx, %rdi
	addq	%r12, %rdi
	adcq	%r14, %r13
	adcq	%r11, %r15
	adcq	$0, %rbx
	addq	%rax, %rdx
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rdi
	adcq	16(%rsi), %r13
	adcq	24(%rsi), %r15
	adcq	32(%rsi), %rbx
	setb	-57(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %r11
	imulq	%rdi, %r11
	movq	%r11, %rdx
	mulxq	%r8, %rax, %r14
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	%rbp, %rdx
	mulxq	%r11, %rsi, %r12
	movq	%rcx, %rdx
	mulxq	%r11, %rcx, %r9
	movq	-40(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rdx
	mulxq	%r11, %rax, %rbp
	addq	%r9, %rax
	adcq	%rsi, %rbp
	adcq	-56(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-57(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %r14
	addq	%rdi, %rcx
	adcq	%r13, %rax
	adcq	%r15, %rbp
	adcq	%rbx, %r12
	movq	-48(%rsp), %rcx                 # 8-byte Reload
	adcq	40(%rcx), %r14
	setb	-57(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %r11
	imulq	%rax, %r11
	movq	%r11, %rdx
	mulxq	-24(%rsp), %rcx, %rbx           # 8-byte Folded Reload
	movq	%rcx, -56(%rsp)                 # 8-byte Spill
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r9, %r15
	movq	-16(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rdx
	mulxq	%r11, %rcx, %r13
	movq	%r8, %rdx
	mulxq	%r11, %rdi, %r11
	addq	%r13, %rdi
	adcq	%r9, %r11
	adcq	-56(%rsp), %r15                 # 8-byte Folded Reload
	movzbl	-57(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %rbx
	addq	%rax, %rcx
	adcq	%rbp, %rdi
	adcq	%r12, %r11
	adcq	%r14, %r15
	movq	-48(%rsp), %rax                 # 8-byte Reload
	adcq	48(%rax), %rbx
	setb	%cl
	imulq	%rdi, %r10
	movq	%rsi, %rdx
	mulxq	%r10, %r9, %r8
	movq	-40(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	mulxq	%r10, %rax, %r12
	addq	%r8, %rax
	movq	-32(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rdx
	mulxq	%r10, %r14, %r8
	adcq	%r12, %r14
	movq	%r10, %rdx
	movq	-24(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r10, %rdx
	adcq	%r8, %r10
	movzbl	%cl, %ecx
	adcq	%rdx, %rcx
	addq	%rdi, %r9
	adcq	%r11, %rax
	adcq	%r15, %r14
	adcq	%rbx, %r10
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	adcq	56(%rdx), %rcx
	movq	%rax, %rdx
	subq	%rsi, %rdx
	movq	%r14, %rsi
	sbbq	%rbp, %rsi
	movq	%r10, %rdi
	sbbq	%r13, %rdi
	movq	%rcx, %r8
	sbbq	%r12, %r8
	cmovsq	%r10, %rdi
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%rdi, 16(%r9)
	cmovsq	%rcx, %r8
	movq	%r8, 24(%r9)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r9)
	cmovsq	%r14, %rsi
	movq	%rsi, 8(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end23:
	.size	mcl_fp_montRedNF4L, .Lfunc_end23-mcl_fp_montRedNF4L
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
.Lfunc_end24:
	.size	mcl_fp_addPre4L, .Lfunc_end24-mcl_fp_addPre4L
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
.Lfunc_end25:
	.size	mcl_fp_subPre4L, .Lfunc_end25-mcl_fp_subPre4L
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
.Lfunc_end26:
	.size	mcl_fp_shr1_4L, .Lfunc_end26-mcl_fp_shr1_4L
                                        # -- End function
	.globl	mcl_fp_add4L                    # -- Begin function mcl_fp_add4L
	.p2align	4
	.type	mcl_fp_add4L,@function
mcl_fp_add4L:                           # @mcl_fp_add4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %rax
	addq	(%rdx), %r8
	adcq	8(%rdx), %rax
	adcq	16(%rdx), %r10
	adcq	24(%rdx), %r9
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
.Lfunc_end27:
	.size	mcl_fp_add4L, .Lfunc_end27-mcl_fp_add4L
                                        # -- End function
	.globl	mcl_fp_addNF4L                  # -- Begin function mcl_fp_addNF4L
	.p2align	4
	.type	mcl_fp_addNF4L,@function
mcl_fp_addNF4L:                         # @mcl_fp_addNF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rsi), %rax
	movq	16(%rsi), %r8
	movq	(%rsi), %r9
	movq	8(%rsi), %rsi
	addq	(%rdx), %r9
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %r8
	adcq	24(%rdx), %rax
	movq	%r9, %rdx
	subq	(%rcx), %rdx
	movq	%rsi, %r10
	sbbq	8(%rcx), %r10
	movq	%r8, %r11
	sbbq	16(%rcx), %r11
	movq	%rax, %rbx
	sbbq	24(%rcx), %rbx
	cmovsq	%r8, %r11
	movq	%r11, 16(%rdi)
	cmovsq	%rax, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%r9, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rsi, %r10
	movq	%r10, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end28:
	.size	mcl_fp_addNF4L, .Lfunc_end28-mcl_fp_addNF4L
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
.Lfunc_end29:
	.size	mcl_fp_sub4L, .Lfunc_end29-mcl_fp_sub4L
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
.Lfunc_end30:
	.size	mcl_fp_subNF4L, .Lfunc_end30-mcl_fp_subNF4L
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
.Lfunc_end31:
	.size	mcl_fpDbl_add4L, .Lfunc_end31-mcl_fpDbl_add4L
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
.Lfunc_end32:
	.size	mcl_fpDbl_sub4L, .Lfunc_end32-mcl_fpDbl_sub4L
                                        # -- End function
	.globl	mulPv384x64                     # -- Begin function mulPv384x64
	.p2align	4
	.type	mulPv384x64,@function
mulPv384x64:                            # @mulPv384x64
# %bb.0:
	movq	%rdi, %rax
	mulxq	(%rsi), %rdi, %rcx
	movq	%rdi, (%rax)
	mulxq	8(%rsi), %r8, %rdi
	addq	%rcx, %r8
	movq	%r8, 8(%rax)
	mulxq	16(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 16(%rax)
	mulxq	24(%rsi), %r8, %rdi
	adcq	%rcx, %r8
	movq	%r8, 24(%rax)
	mulxq	32(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 32(%rax)
	mulxq	40(%rsi), %rdx, %rsi
	adcq	%rcx, %rdx
	movq	%rdx, 40(%rax)
	adcq	$0, %rsi
	movq	%rsi, 48(%rax)
	retq
.Lfunc_end33:
	.size	mulPv384x64, .Lfunc_end33-mulPv384x64
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
	subq	$24, %rsp
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%rdi, 16(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rdi
	movq	%rdi, -96(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rdi, %rdx
	mulxq	%rax, %r8, %r13
	movq	32(%rsi), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%rax, %r9, %r15
	movq	24(%rsi), %rdx
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	mulxq	%rax, %r10, %rdi
	movq	16(%rsi), %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	mulxq	%rax, %r14, %r11
	movq	(%rsi), %rbx
	movq	%rbx, -16(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbp, %rsi
	movq	%rbx, %rdx
	mulxq	%rax, %rax, %r12
	movq	%rax, -112(%rsp)                # 8-byte Spill
	addq	%rbp, %r12
	adcq	%r14, %rsi
	adcq	%r10, %r11
	adcq	%r9, %rdi
	adcq	%r8, %r15
	adcq	$0, %r13
	movq	%r13, -128(%rsp)                # 8-byte Spill
	movq	-8(%rcx), %r14
	movq	%r14, (%rsp)                    # 8-byte Spill
	imulq	%rax, %r14
	movq	40(%rcx), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	mulxq	%r14, %rax, %r8
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	mulxq	%r14, %rax, %rbp
	movq	8(%rcx), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	mulxq	%r14, %rbx, %r9
	movq	(%rcx), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%r14, %r13, %r10
	addq	%rbx, %r10
	adcq	%rax, %r9
	movq	24(%rcx), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	mulxq	%r14, %rax, %rbx
	adcq	%rbp, %rax
	movq	32(%rcx), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r14, %rcx, %r14
	adcq	%rbx, %rcx
	adcq	-120(%rsp), %r14                # 8-byte Folded Reload
	adcq	$0, %r8
	addq	-112(%rsp), %r13                # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	%rsi, %r9
	adcq	%r11, %rax
	adcq	%rdi, %rcx
	adcq	%r15, %r14
	adcq	-128(%rsp), %r8                 # 8-byte Folded Reload
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	movq	8(%rdx), %rdx
	mulxq	-96(%rsp), %rdi, %rsi           # 8-byte Folded Reload
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	mulxq	-72(%rsp), %rsi, %r15           # 8-byte Folded Reload
	movq	%rsi, -104(%rsp)                # 8-byte Spill
	mulxq	-80(%rsp), %rbp, %r13           # 8-byte Folded Reload
	mulxq	-24(%rsp), %rdi, %rsi           # 8-byte Folded Reload
	mulxq	-16(%rsp), %r12, %r11           # 8-byte Folded Reload
	setb	-112(%rsp)                      # 1-byte Folded Spill
	addq	%rdi, %r11
	mulxq	-8(%rsp), %rdi, %rbx            # 8-byte Folded Reload
	adcq	%rsi, %rdi
	adcq	%rbp, %rbx
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r10, %r12
	adcq	%r9, %r11
	adcq	%rax, %rdi
	adcq	%rcx, %rbx
	adcq	%r14, %r13
	adcq	%r8, %r15
	movzbl	-112(%rsp), %eax                # 1-byte Folded Reload
	adcq	%rax, %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	imulq	%r12, %rdx
	mulxq	8(%rsp), %rax, %rbp             # 8-byte Folded Reload
	movq	%rax, -120(%rsp)                # 8-byte Spill
	mulxq	-64(%rsp), %rax, %r14           # 8-byte Folded Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-40(%rsp), %rcx, %rax           # 8-byte Folded Reload
	mulxq	-48(%rsp), %r9, %r8             # 8-byte Folded Reload
	addq	%rcx, %r8
	mulxq	-32(%rsp), %rsi, %r10           # 8-byte Folded Reload
	adcq	%rax, %rsi
	mulxq	-56(%rsp), %rax, %rcx           # 8-byte Folded Reload
	adcq	%r10, %rax
	adcq	-104(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-120(%rsp), %r14                # 8-byte Folded Reload
	adcq	$0, %rbp
	addq	%r12, %r9
	adcq	%r11, %r8
	adcq	%rdi, %rsi
	adcq	%rbx, %rax
	adcq	%r13, %rcx
	adcq	%r15, %r14
	adcq	-128(%rsp), %rbp                # 8-byte Folded Reload
	movzbl	-112(%rsp), %ebx                # 1-byte Folded Reload
	adcq	$0, %rbx
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	movq	16(%rdx), %rdx
	mulxq	-96(%rsp), %r9, %rdi            # 8-byte Folded Reload
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movq	%rdi, -128(%rsp)                # 8-byte Spill
	mulxq	-72(%rsp), %rdi, %r15           # 8-byte Folded Reload
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	mulxq	-80(%rsp), %r9, %rdi            # 8-byte Folded Reload
	movq	%r9, -104(%rsp)                 # 8-byte Spill
	mulxq	-24(%rsp), %r10, %r11           # 8-byte Folded Reload
	mulxq	-16(%rsp), %r13, %r9            # 8-byte Folded Reload
	addq	%r10, %r9
	mulxq	-8(%rsp), %r12, %r10            # 8-byte Folded Reload
	adcq	%r11, %r12
	adcq	-104(%rsp), %r10                # 8-byte Folded Reload
	adcq	-120(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r8, %r13
	adcq	%rsi, %r9
	adcq	%rax, %r12
	adcq	%rcx, %r10
	adcq	%r14, %rdi
	adcq	%rbp, %r15
	adcq	%rbx, %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-120(%rsp)                      # 1-byte Folded Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	imulq	%r13, %rdx
	mulxq	8(%rsp), %rcx, %rax             # 8-byte Folded Reload
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	mulxq	-64(%rsp), %r11, %r8            # 8-byte Folded Reload
	mulxq	-40(%rsp), %r14, %rax           # 8-byte Folded Reload
	mulxq	-48(%rsp), %rcx, %rbx           # 8-byte Folded Reload
	addq	%r14, %rbx
	mulxq	-32(%rsp), %rbp, %rsi           # 8-byte Folded Reload
	adcq	%rax, %rbp
	mulxq	-56(%rsp), %rax, %r14           # 8-byte Folded Reload
	adcq	%rsi, %rax
	adcq	%r11, %r14
	adcq	-104(%rsp), %r8                 # 8-byte Folded Reload
	movq	-112(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r13, %rcx
	adcq	%r9, %rbx
	adcq	%r12, %rbp
	adcq	%r10, %rax
	adcq	%rdi, %r14
	adcq	%r15, %r8
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movzbl	-120(%rsp), %esi                # 1-byte Folded Reload
	adcq	$0, %rsi
	movq	-88(%rsp), %rcx                 # 8-byte Reload
	movq	24(%rcx), %rdx
	mulxq	-96(%rsp), %rdi, %rcx           # 8-byte Folded Reload
	movq	%rdi, -120(%rsp)                # 8-byte Spill
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	mulxq	-72(%rsp), %rcx, %r9            # 8-byte Folded Reload
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	mulxq	-80(%rsp), %r13, %rdi           # 8-byte Folded Reload
	mulxq	-24(%rsp), %r11, %rcx           # 8-byte Folded Reload
	mulxq	-16(%rsp), %r12, %r10           # 8-byte Folded Reload
	addq	%r11, %r10
	mulxq	-8(%rsp), %r15, %r11            # 8-byte Folded Reload
	adcq	%rcx, %r15
	adcq	%r13, %r11
	adcq	-104(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-128(%rsp), %rcx                # 8-byte Reload
	adcq	$0, %rcx
	addq	%rbx, %r12
	adcq	%rbp, %r10
	adcq	%rax, %r15
	adcq	%r14, %r11
	adcq	%r8, %rdi
	adcq	-112(%rsp), %r9                 # 8-byte Folded Reload
	adcq	%rsi, %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	setb	-112(%rsp)                      # 1-byte Folded Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	imulq	%r12, %rdx
	mulxq	8(%rsp), %rcx, %rax             # 8-byte Folded Reload
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	movq	%rax, -120(%rsp)                # 8-byte Spill
	mulxq	-64(%rsp), %r8, %r14            # 8-byte Folded Reload
	mulxq	-40(%rsp), %r13, %rcx           # 8-byte Folded Reload
	mulxq	-48(%rsp), %rax, %rbx           # 8-byte Folded Reload
	addq	%r13, %rbx
	mulxq	-32(%rsp), %r13, %rsi           # 8-byte Folded Reload
	adcq	%rcx, %r13
	mulxq	-56(%rsp), %rcx, %rbp           # 8-byte Folded Reload
	adcq	%rsi, %rcx
	adcq	%r8, %rbp
	adcq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	-120(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%r12, %rax
	adcq	%r10, %rbx
	adcq	%r15, %r13
	adcq	%r11, %rcx
	adcq	%rdi, %rbp
	adcq	%r9, %r14
	adcq	-128(%rsp), %rdx                # 8-byte Folded Reload
	movq	%rdx, -120(%rsp)                # 8-byte Spill
	movzbl	-112(%rsp), %edi                # 1-byte Folded Reload
	adcq	$0, %rdi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	movq	32(%rdx), %rdx
	mulxq	-96(%rsp), %rsi, %rax           # 8-byte Folded Reload
	movq	%rsi, -104(%rsp)                # 8-byte Spill
	movq	%rax, -128(%rsp)                # 8-byte Spill
	mulxq	-72(%rsp), %r11, %rax           # 8-byte Folded Reload
	movq	%rax, -112(%rsp)                # 8-byte Spill
	mulxq	-80(%rsp), %r12, %r8            # 8-byte Folded Reload
	mulxq	-24(%rsp), %r10, %rsi           # 8-byte Folded Reload
	mulxq	-16(%rsp), %rax, %r9            # 8-byte Folded Reload
	addq	%r10, %r9
	mulxq	-8(%rsp), %r15, %r10            # 8-byte Folded Reload
	adcq	%rsi, %r15
	adcq	%r12, %r10
	adcq	%r11, %r8
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	-104(%rsp), %rsi                # 8-byte Folded Reload
	movq	-128(%rsp), %rdx                # 8-byte Reload
	adcq	$0, %rdx
	addq	%rbx, %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	adcq	%r13, %r9
	adcq	%rcx, %r15
	adcq	%rbp, %r10
	adcq	%r14, %r8
	adcq	-120(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	adcq	%rdi, %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	setb	-120(%rsp)                      # 1-byte Folded Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	imulq	%rax, %rdx
	mulxq	8(%rsp), %rsi, %rcx             # 8-byte Folded Reload
	mulxq	-64(%rsp), %r14, %rdi           # 8-byte Folded Reload
	mulxq	-40(%rsp), %rbx, %r12           # 8-byte Folded Reload
	mulxq	-48(%rsp), %rbp, %r11           # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-32(%rsp), %rbx, %rax           # 8-byte Folded Reload
	adcq	%r12, %rbx
	mulxq	-56(%rsp), %r13, %r12           # 8-byte Folded Reload
	adcq	%rax, %r13
	adcq	%r14, %r12
	adcq	%rsi, %rdi
	adcq	$0, %rcx
	addq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	%r9, %r11
	adcq	%r15, %rbx
	adcq	%r10, %r13
	adcq	%r8, %r12
	adcq	-112(%rsp), %rdi                # 8-byte Folded Reload
	adcq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	movzbl	-120(%rsp), %ebp                # 1-byte Folded Reload
	adcq	$0, %rbp
	movq	-88(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdx
	mulxq	-96(%rsp), %rcx, %rax           # 8-byte Folded Reload
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	mulxq	-72(%rsp), %rax, %rsi           # 8-byte Folded Reload
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	mulxq	-80(%rsp), %rax, %r8            # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulxq	-8(%rsp), %rcx, %r9             # 8-byte Folded Reload
	mulxq	-24(%rsp), %rax, %r10           # 8-byte Folded Reload
	mulxq	-16(%rsp), %r15, %r14           # 8-byte Folded Reload
	addq	%rax, %r14
	adcq	%rcx, %r10
	adcq	-80(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-72(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	-88(%rsp), %rax                 # 8-byte Reload
	adcq	$0, %rax
	addq	%r11, %r15
	adcq	%rbx, %r14
	adcq	%r13, %r10
	adcq	%r12, %r9
	adcq	%rdi, %r8
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	adcq	%rbp, %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	imulq	%r15, %rdx
	mulxq	-48(%rsp), %r13, %rax           # 8-byte Folded Reload
	mulxq	-40(%rsp), %rcx, %r11           # 8-byte Folded Reload
	addq	%rax, %rcx
	mulxq	-32(%rsp), %rdi, %rax           # 8-byte Folded Reload
	adcq	%r11, %rdi
	mulxq	-56(%rsp), %r11, %r12           # 8-byte Folded Reload
	adcq	%rax, %r11
	mulxq	-64(%rsp), %rbx, %rax           # 8-byte Folded Reload
	adcq	%r12, %rbx
	movq	8(%rsp), %rbp                   # 8-byte Reload
	mulxq	%rbp, %rdx, %r12
	adcq	%rax, %rdx
	adcq	$0, %r12
	addq	%r15, %r13
	adcq	%r14, %rcx
	adcq	%r10, %rdi
	adcq	%r9, %r11
	adcq	%r8, %rbx
	adcq	%rsi, %rdx
	adcq	-88(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	-96(%rsp), %esi                 # 1-byte Folded Reload
	adcq	$0, %rsi
	movq	%rcx, %rax
	subq	-48(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rdi, %r8
	sbbq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r11, %r9
	sbbq	-32(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rbx, %r10
	sbbq	-56(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	-64(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r12, %r15
	sbbq	%rbp, %r15
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%r12, %r15
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movq	%r15, 40(%rsi)
	cmovneq	%rdx, %r14
	movq	%r14, 32(%rsi)
	cmovneq	%rbx, %r10
	movq	%r10, 24(%rsi)
	cmovneq	%r11, %r9
	movq	%r9, 16(%rsi)
	cmovneq	%rdi, %r8
	movq	%r8, 8(%rsi)
	cmovneq	%rcx, %rax
	movq	%rax, (%rsi)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end34:
	.size	mcl_fp_mont6L, .Lfunc_end34-mcl_fp_mont6L
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
	subq	$40, %rsp
	movq	%rdx, %rax
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rdi
	movq	%rdi, -32(%rsp)                 # 8-byte Spill
	movq	(%rax), %rbx
	mulxq	%rbx, %r8, %rax
	movq	%r8, 24(%rsp)                   # 8-byte Spill
	movq	-8(%rcx), %r13
	movq	%r13, -120(%rsp)                # 8-byte Spill
	movq	(%rcx), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	imulq	%r8, %r13
	mulxq	%r13, %rdx, %r11
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	addq	%rax, %r11
	movq	%rdi, %rdx
	mulxq	%rbx, %rdx, %rax
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	8(%rcx), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	mulxq	%r13, %rdi, %r9
	adcq	%rax, %r9
	movq	16(%rsi), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	mulxq	%rbx, %rax, %r8
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	mulxq	%r13, %rax, %r15
	adcq	%r8, %r15
	movq	24(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%rbx, %rdx, %r10
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	mulxq	%r13, %r8, %r12
	adcq	%r10, %r12
	movq	32(%rsi), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%rbx, %rdx, %r14
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%r13, %r10, %rbp
	adcq	%r14, %rbp
	movq	40(%rsi), %r14
	movq	%r14, -80(%rsp)                 # 8-byte Spill
	movq	40(%rcx), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	mulxq	%r13, %r13, %rsi
	movq	%r14, %rdx
	mulxq	%rbx, %rcx, %rdx
	adcq	%rsi, %rdx
	movq	16(%rsp), %rsi                  # 8-byte Reload
	addq	24(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	adcq	(%rsp), %rax                    # 8-byte Folded Reload
	adcq	-8(%rsp), %r8                   # 8-byte Folded Reload
	adcq	-16(%rsp), %r10                 # 8-byte Folded Reload
	adcq	%r13, %rcx
	setb	%sil
	addq	%r11, %rdi
	adcq	%r9, %rax
	adcq	%r15, %r8
	adcq	%r12, %r10
	adcq	%rbp, %rcx
	movzbl	%sil, %esi
	adcq	%rdx, %rsi
	movq	-24(%rsp), %rbp                 # 8-byte Reload
	movq	8(%rbp), %rdx
	mulxq	-88(%rsp), %r9, %r14            # 8-byte Folded Reload
	addq	%rdi, %r9
	movq	-32(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rdi, %r15
	adcq	%rax, %rdi
	mulxq	-128(%rsp), %r11, %rax          # 8-byte Folded Reload
	adcq	%r8, %r11
	mulxq	-64(%rsp), %rbx, %r8            # 8-byte Folded Reload
	adcq	%r10, %rbx
	mulxq	-72(%rsp), %r10, %r12           # 8-byte Folded Reload
	adcq	%rcx, %r10
	mulxq	-80(%rsp), %rcx, %rdx           # 8-byte Folded Reload
	adcq	%rsi, %rcx
	setb	%sil
	addq	%r14, %rdi
	adcq	%r15, %r11
	adcq	%rax, %rbx
	adcq	%r8, %r10
	adcq	%r12, %rcx
	movzbl	%sil, %esi
	adcq	%rdx, %rsi
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r9, %rdx
	mulxq	-40(%rsp), %rax, %r14           # 8-byte Folded Reload
	addq	%r9, %rax
	mulxq	-96(%rsp), %rax, %r15           # 8-byte Folded Reload
	adcq	%rdi, %rax
	mulxq	-104(%rsp), %rdi, %r12          # 8-byte Folded Reload
	adcq	%r11, %rdi
	mulxq	-112(%rsp), %r8, %r11           # 8-byte Folded Reload
	adcq	%rbx, %r8
	mulxq	-48(%rsp), %r9, %rbx            # 8-byte Folded Reload
	adcq	%r10, %r9
	mulxq	-56(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%rcx, %r10
	adcq	$0, %rsi
	addq	%r14, %rax
	adcq	%r15, %rdi
	adcq	%r12, %r8
	adcq	%r11, %r9
	adcq	%rbx, %r10
	adcq	%rdx, %rsi
	movq	16(%rbp), %rdx
	mulxq	%r13, %rbx, %rcx
	mulxq	-88(%rsp), %r13, %r11           # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-128(%rsp), %rbx, %r15          # 8-byte Folded Reload
	adcq	%rcx, %rbx
	mulxq	-64(%rsp), %r14, %rcx           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-72(%rsp), %r15, %rbp           # 8-byte Folded Reload
	adcq	%rcx, %r15
	mulxq	-80(%rsp), %r12, %rcx           # 8-byte Folded Reload
	adcq	%rbp, %r12
	adcq	$0, %rcx
	addq	%rax, %r13
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rsi, %r12
	adcq	$0, %rcx
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r13, %rdx
	mulxq	-40(%rsp), %rax, %rsi           # 8-byte Folded Reload
	addq	%r13, %rax
	mulxq	-96(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%r11, %rax
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-48(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-56(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rcx
	addq	%rsi, %rax
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rcx
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	24(%rdx), %rdx
	mulxq	-32(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	mulxq	-88(%rsp), %r13, %r11           # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-128(%rsp), %rbx, %r15          # 8-byte Folded Reload
	adcq	%rsi, %rbx
	mulxq	-64(%rsp), %r14, %rsi           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-72(%rsp), %r15, %rbp           # 8-byte Folded Reload
	adcq	%rsi, %r15
	mulxq	-80(%rsp), %r12, %rsi           # 8-byte Folded Reload
	adcq	%rbp, %r12
	adcq	$0, %rsi
	addq	%rax, %r13
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rcx, %r12
	adcq	$0, %rsi
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r13, %rdx
	mulxq	-40(%rsp), %rax, %rcx           # 8-byte Folded Reload
	addq	%r13, %rax
	mulxq	-96(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%r11, %rax
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-48(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-56(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rsi
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	movq	32(%rcx), %rdx
	mulxq	-32(%rsp), %rbx, %rcx           # 8-byte Folded Reload
	mulxq	-88(%rsp), %r13, %r11           # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-128(%rsp), %rbx, %r15          # 8-byte Folded Reload
	adcq	%rcx, %rbx
	mulxq	-64(%rsp), %r14, %rcx           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-72(%rsp), %r15, %rbp           # 8-byte Folded Reload
	adcq	%rcx, %r15
	mulxq	-80(%rsp), %r12, %rcx           # 8-byte Folded Reload
	adcq	%rbp, %r12
	adcq	$0, %rcx
	addq	%rax, %r13
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rsi, %r12
	adcq	$0, %rcx
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r13, %rdx
	mulxq	-40(%rsp), %rsi, %rax           # 8-byte Folded Reload
	addq	%r13, %rsi
	mulxq	-96(%rsp), %rsi, %r13           # 8-byte Folded Reload
	adcq	%r11, %rsi
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-48(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-56(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rcx
	addq	%rax, %rsi
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rcx
	movq	-24(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdx
	mulxq	-32(%rsp), %rbx, %rax           # 8-byte Folded Reload
	mulxq	-88(%rsp), %r13, %r11           # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-128(%rsp), %rbx, %r15          # 8-byte Folded Reload
	adcq	%rax, %rbx
	mulxq	-64(%rsp), %r14, %rax           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-72(%rsp), %r15, %rbp           # 8-byte Folded Reload
	adcq	%rax, %r15
	mulxq	-80(%rsp), %r12, %rax           # 8-byte Folded Reload
	adcq	%rbp, %r12
	adcq	$0, %rax
	addq	%rsi, %r13
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rcx, %r12
	adcq	$0, %rax
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r13, %rdx
	movq	-40(%rsp), %r10                 # 8-byte Reload
	mulxq	%r10, %rcx, %rsi
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	addq	%r13, %rcx
	mulxq	-96(%rsp), %rcx, %rsi           # 8-byte Folded Reload
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	adcq	%r11, %rcx
	mulxq	-104(%rsp), %rsi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rsi
	mulxq	-112(%rsp), %rdi, %rbx          # 8-byte Folded Reload
	adcq	%r14, %rdi
	movq	-48(%rsp), %rbp                 # 8-byte Reload
	mulxq	%rbp, %r8, %r14
	adcq	%r15, %r8
	movq	-56(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rdx, %r15
	adcq	%r12, %rdx
	adcq	$0, %rax
	addq	-120(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	adcq	%r11, %rdi
	adcq	%rbx, %r8
	adcq	%r14, %rdx
	adcq	%r15, %rax
	movq	%rcx, %r9
	subq	%r10, %r9
	movq	%rsi, %r10
	sbbq	-96(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdi, %r11
	sbbq	-104(%rsp), %r11                # 8-byte Folded Reload
	movq	%r8, %rbx
	sbbq	-112(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	%rbp, %r14
	movq	%rax, %r15
	sbbq	%r13, %r15
	movq	%r15, %r12
	sarq	$63, %r12
	cmovsq	%rax, %r15
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%r15, 40(%rax)
	cmovsq	%rdx, %r14
	movq	%r14, 32(%rax)
	cmovsq	%r8, %rbx
	movq	%rbx, 24(%rax)
	cmovsq	%rdi, %r11
	movq	%r11, 16(%rax)
	cmovsq	%rsi, %r10
	movq	%r10, 8(%rax)
	cmovsq	%rcx, %r9
	movq	%r9, (%rax)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end35:
	.size	mcl_fp_montNF6L, .Lfunc_end35-mcl_fp_montNF6L
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
	movq	%rdx, %r9
	movq	%rsi, %r11
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r10
	movq	-8(%rdx), %rdi
	movq	%rdi, -80(%rsp)                 # 8-byte Spill
	imulq	%r10, %rdi
	movq	40(%rdx), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rcx, %rax
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	32(%r9), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rax, %r12
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	24(%r9), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rbx, %r15
	movq	16(%r9), %rbp
	movq	%rbp, %rdx
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r14, %rsi
	movq	(%r9), %rax
	movq	8(%r9), %rcx
	movq	%rcx, %rdx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r13, %r8
	movq	%rax, %rdx
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdx, %r9
	addq	%r13, %r9
	adcq	%r14, %r8
	adcq	%rbx, %rsi
	adcq	-16(%rsp), %r15                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r12                 # 8-byte Folded Reload
	movq	-96(%rsp), %rdi                 # 8-byte Reload
	adcq	$0, %rdi
	addq	%r10, %rdx
	movq	%r11, -72(%rsp)                 # 8-byte Spill
	adcq	8(%r11), %r9
	adcq	16(%r11), %r8
	adcq	24(%r11), %rsi
	adcq	32(%r11), %r15
	adcq	40(%r11), %r12
	adcq	48(%r11), %rdi
	movq	%rdi, -96(%rsp)                 # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %r14                 # 8-byte Reload
	imulq	%r9, %r14
	movq	%rax, %rdx
	mulxq	%r14, %rax, %r10
	movq	%rcx, %rdx
	mulxq	%r14, %rdi, %r13
	addq	%r10, %rdi
	movq	%rbp, %rdx
	mulxq	%r14, %rbx, %r10
	adcq	%r13, %rbx
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rcx
	adcq	%r10, %r13
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rbp, %r11
	adcq	%rcx, %rbp
	movq	%r14, %rdx
	mulxq	-64(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r11, %r10
	movzbl	-88(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	%rdx, %rcx
	addq	%r9, %rax
	adcq	%r8, %rdi
	adcq	%rsi, %rbx
	adcq	%r15, %r13
	adcq	%r12, %rbp
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	movq	-72(%rsp), %rax                 # 8-byte Reload
	adcq	56(%rax), %rcx
	setb	%r15b
	movq	-80(%rsp), %r14                 # 8-byte Reload
	imulq	%rdi, %r14
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %r8
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rsi, %r9
	addq	%r8, %rsi
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %r8
	adcq	%r9, %rax
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r12, %r11
	adcq	%r8, %r12
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %r8
	adcq	%r11, %r9
	movq	%r14, %rdx
	mulxq	-64(%rsp), %r11, %rdx           # 8-byte Folded Reload
	adcq	%r8, %r11
	movzbl	%r15b, %r15d
	adcq	%rdx, %r15
	addq	%rdi, -96(%rsp)                 # 8-byte Folded Spill
	adcq	%rbx, %rsi
	adcq	%r13, %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	adcq	%rbp, %r12
	adcq	%r10, %r9
	adcq	%rcx, %r11
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	adcq	64(%rcx), %r15
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %r14                 # 8-byte Reload
	imulq	%rsi, %r14
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rdi
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rcx, %r8
	addq	%rdi, %rcx
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %rdi
	adcq	%r8, %rax
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %rbx
	adcq	%rdi, %r8
	movq	-48(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	mulxq	%r14, %r10, %rdi
	adcq	%rbx, %r10
	movq	%r14, %rdx
	mulxq	-64(%rsp), %rbx, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %rbx
	movzbl	-88(%rsp), %edi                 # 1-byte Folded Reload
	adcq	%rdx, %rdi
	addq	%rsi, %r13
	adcq	-96(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	%r12, %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	adcq	%r9, %r8
	adcq	%r11, %r10
	adcq	%r15, %rbx
	movq	-72(%rsp), %rax                 # 8-byte Reload
	adcq	72(%rax), %rdi
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-80(%rsp), %r14                 # 8-byte Reload
	imulq	%rcx, %r14
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %rax
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r15, %r11
	addq	%rax, %r15
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r12, %rax
	adcq	%r11, %r12
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %r11
	adcq	%rax, %r13
	movq	%rbp, %rdx
	mulxq	%r14, %rbp, %rsi
	adcq	%r11, %rbp
	movq	%r14, %rdx
	mulxq	-64(%rsp), %rax, %rdx           # 8-byte Folded Reload
	adcq	%rsi, %rax
	movzbl	-88(%rsp), %r11d                # 1-byte Folded Reload
	adcq	%rdx, %r11
	addq	%rcx, %r9
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	adcq	%r8, %r12
	adcq	%r10, %r13
	adcq	%rbx, %rbp
	adcq	%rdi, %rax
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	adcq	80(%rcx), %r11
	movq	88(%rcx), %rdi
	setb	%r9b
	movq	-80(%rsp), %r8                  # 8-byte Reload
	imulq	%r15, %r8
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %r10, %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	addq	%r15, %r10
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %rsi, %rcx
	movq	%rcx, -72(%rsp)                 # 8-byte Spill
	adcq	%r12, %rsi
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %r14, %rcx
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	adcq	%r13, %r14
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %rcx, %rdx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	adcq	%rbp, %rcx
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r8, %rbx, %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	%r8, %rdx
	adcq	%rax, %rbx
	mulxq	-64(%rsp), %rdx, %r8            # 8-byte Folded Reload
	adcq	%r11, %rdx
	movzbl	%r9b, %r9d
	adcq	%rdi, %r9
	addq	-80(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-72(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-96(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-88(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	%r8, %r9
	xorl	%r8d, %r8d
	cmpq	%r15, %r10
	movq	%rsi, %r10
	sbbq	%r12, %r10
	movq	%r14, %r10
	sbbq	%r13, %r10
	movq	%rcx, %r10
	sbbq	%rbp, %r10
	movq	%rbx, %r10
	sbbq	%rax, %r10
	movq	%rdx, %rax
	sbbq	%r11, %rax
	movq	%r9, %rax
	sbbq	%rdi, %rax
	sbbq	%r8, %r8
	setb	%r8b
	movq	%rsi, %rax
	subq	-40(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r14, %rdi
	sbbq	-24(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	-32(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rbx, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rdx, %r15
	sbbq	-48(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r9, %r12
	sbbq	-64(%rsp), %r12                 # 8-byte Folded Reload
	movzbl	%r8b, %r8d
	sbbq	$0, %r8
	testb	$1, %r8b
	cmovneq	%rdx, %r15
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%r15, 32(%rdx)
	cmovneq	%r9, %r12
	movq	%r12, 40(%rdx)
	cmovneq	%rcx, %r10
	movq	%r10, 16(%rdx)
	cmovneq	%rbx, %r11
	movq	%r11, 24(%rdx)
	cmovneq	%rsi, %rax
	movq	%rax, (%rdx)
	cmovneq	%r14, %rdi
	movq	%rdi, 8(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end36:
	.size	mcl_fp_montRed6L, .Lfunc_end36-mcl_fp_montRed6L
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
	movq	%rdx, %r10
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	-8(%rdx), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	imulq	%rax, %rcx
	movq	40(%rdx), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rdi, %rdx
	movq	%rdi, -88(%rsp)                 # 8-byte Spill
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	32(%r10), %rdx
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rdx, %r12
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	24(%r10), %r9
	movq	%r9, %rdx
	movq	%r9, -32(%rsp)                  # 8-byte Spill
	mulxq	%rcx, %r11, %r13
	movq	16(%r10), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %r14, %rbp
	movq	(%r10), %rdi
	movq	8(%r10), %r15
	movq	%r15, %rdx
	movq	%r15, -48(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %r10, %r8
	movq	%rdi, %rdx
	movq	%rdi, -56(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rcx, %rbx
	addq	%r10, %rbx
	adcq	%r14, %r8
	adcq	%r11, %rbp
	adcq	-16(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r12                 # 8-byte Folded Reload
	movq	-96(%rsp), %rdx                 # 8-byte Reload
	adcq	$0, %rdx
	addq	%rax, %rcx
	movq	%rsi, -40(%rsp)                 # 8-byte Spill
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r8
	adcq	24(%rsi), %rbp
	adcq	32(%rsi), %r13
	adcq	40(%rsi), %r12
	adcq	48(%rsi), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	setb	-88(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rbx, %r14
	movq	%r9, %rdx
	mulxq	%r14, %r9, %r10
	movq	%rdi, %rdx
	mulxq	%r14, %rsi, %rcx
	movq	%r15, %rdx
	mulxq	%r14, %rax, %r11
	addq	%rcx, %rax
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rcx, %rdi
	adcq	%r11, %rcx
	adcq	%r9, %rdi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %r15
	adcq	%r10, %r9
	movq	%r14, %rdx
	mulxq	-64(%rsp), %r11, %r10           # 8-byte Folded Reload
	adcq	%r15, %r11
	movzbl	-88(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %r10
	addq	%rbx, %rsi
	adcq	%r8, %rax
	adcq	%rbp, %rcx
	adcq	%r13, %rdi
	adcq	%r12, %r9
	adcq	-96(%rsp), %r11                 # 8-byte Folded Reload
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	adcq	56(%rdx), %r10
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rax, %r14
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %rbx
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rdx, %r12
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r15, %rbp
	addq	%r12, %r15
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %r12
	adcq	%rbp, %r13
	adcq	%r8, %r12
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %rsi
	adcq	%rbx, %r8
	movq	%r14, %rdx
	mulxq	-64(%rsp), %rbx, %rbp           # 8-byte Folded Reload
	adcq	%rsi, %rbx
	movzbl	-96(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %rbp
	addq	%rax, -88(%rsp)                 # 8-byte Folded Spill
	adcq	%rcx, %r15
	adcq	%rdi, %r13
	adcq	%r9, %r12
	adcq	%r11, %r8
	adcq	%r10, %rbx
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rbp
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%r15, %r14
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %r10
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %rcx
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %r11
	addq	%rcx, %rax
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rcx, %rdi
	adcq	%r11, %rcx
	adcq	%r9, %rdi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %rsi
	adcq	%r10, %r9
	movq	%r14, %rdx
	mulxq	-64(%rsp), %r11, %r10           # 8-byte Folded Reload
	adcq	%rsi, %r11
	movzbl	-96(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %r10
	addq	%r15, -88(%rsp)                 # 8-byte Folded Spill
	adcq	%r13, %rax
	adcq	%r12, %rcx
	adcq	%r8, %rdi
	adcq	%rbx, %r9
	adcq	%rbp, %r11
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	adcq	72(%rdx), %r10
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rax, %r14
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rbx
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rbp, %r8
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r15, %rsi
	addq	%r8, %r15
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %r12
	adcq	%rsi, %r8
	adcq	%r13, %r12
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rsi
	adcq	%rbx, %r13
	movq	%r14, %rdx
	mulxq	-64(%rsp), %rbx, %r14           # 8-byte Folded Reload
	adcq	%rsi, %rbx
	movzbl	-96(%rsp), %edx                 # 1-byte Folded Reload
	adcq	%rdx, %r14
	addq	%rax, %rbp
	adcq	%rcx, %r15
	adcq	%rdi, %r8
	adcq	%r9, %r12
	adcq	%r11, %r13
	adcq	%r10, %rbx
	movq	-40(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %r14
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r11                 # 8-byte Reload
	imulq	%r15, %r11
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r10, %rcx
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rax, %rdi
	addq	%rcx, %rax
	movq	-72(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rcx, %r9
	adcq	%rdi, %rcx
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rdi, %rsi
	adcq	%r9, %rdi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r9, %rbp
	adcq	%rsi, %r9
	movq	%r11, %rdx
	mulxq	-64(%rsp), %rdx, %r11           # 8-byte Folded Reload
	adcq	%rbp, %rdx
	movzbl	-96(%rsp), %esi                 # 1-byte Folded Reload
	adcq	%r11, %rsi
	addq	%r15, %r10
	adcq	%r8, %rax
	adcq	%r12, %rcx
	adcq	%r13, %rdi
	adcq	%rbx, %r9
	adcq	%r14, %rdx
	movq	-40(%rsp), %r8                  # 8-byte Reload
	adcq	88(%r8), %rsi
	movq	%rax, %r8
	subq	-56(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	-48(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdi, %r11
	sbbq	-72(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r9, %rbx
	sbbq	-32(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	-80(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rsi, %r15
	sbbq	-64(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, %r12
	sarq	$63, %r12
	cmovsq	%rdx, %r14
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%r14, 32(%rdx)
	cmovsq	%rsi, %r15
	movq	%r15, 40(%rdx)
	cmovsq	%rdi, %r11
	movq	%r11, 16(%rdx)
	cmovsq	%r9, %rbx
	movq	%rbx, 24(%rdx)
	cmovsq	%rax, %r8
	movq	%r8, (%rdx)
	cmovsq	%rcx, %r10
	movq	%r10, 8(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end37:
	.size	mcl_fp_montRedNF6L, .Lfunc_end37-mcl_fp_montRedNF6L
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
.Lfunc_end38:
	.size	mcl_fp_addPre6L, .Lfunc_end38-mcl_fp_addPre6L
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
.Lfunc_end39:
	.size	mcl_fp_subPre6L, .Lfunc_end39-mcl_fp_subPre6L
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
.Lfunc_end40:
	.size	mcl_fp_shr1_6L, .Lfunc_end40-mcl_fp_shr1_6L
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
	movq	40(%rsi), %r11
	movq	32(%rsi), %rbx
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %rax
	addq	(%rdx), %r8
	adcq	8(%rdx), %rax
	adcq	16(%rdx), %r10
	adcq	24(%rdx), %r9
	adcq	32(%rdx), %rbx
	adcq	40(%rdx), %r11
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
.Lfunc_end41:
	.size	mcl_fp_add6L, .Lfunc_end41-mcl_fp_add6L
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
	movq	40(%rsi), %r11
	movq	32(%rsi), %rbx
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r8
	movq	8(%rsi), %rax
	addq	(%rdx), %r8
	adcq	8(%rdx), %rax
	adcq	16(%rdx), %r10
	adcq	24(%rdx), %r9
	adcq	32(%rdx), %rbx
	adcq	40(%rdx), %r11
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
.Lfunc_end42:
	.size	mcl_fp_addNF6L, .Lfunc_end42-mcl_fp_addNF6L
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
.Lfunc_end43:
	.size	mcl_fp_sub6L, .Lfunc_end43-mcl_fp_sub6L
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
.Lfunc_end44:
	.size	mcl_fp_subNF6L, .Lfunc_end44-mcl_fp_subNF6L
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
.Lfunc_end45:
	.size	mcl_fpDbl_add6L, .Lfunc_end45-mcl_fpDbl_add6L
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
.Lfunc_end46:
	.size	mcl_fpDbl_sub6L, .Lfunc_end46-mcl_fpDbl_sub6L
                                        # -- End function
	.globl	mulPv512x64                     # -- Begin function mulPv512x64
	.p2align	4
	.type	mulPv512x64,@function
mulPv512x64:                            # @mulPv512x64
# %bb.0:
	movq	%rdi, %rax
	mulxq	(%rsi), %rdi, %rcx
	movq	%rdi, (%rax)
	mulxq	8(%rsi), %r8, %rdi
	addq	%rcx, %r8
	movq	%r8, 8(%rax)
	mulxq	16(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 16(%rax)
	mulxq	24(%rsi), %r8, %rdi
	adcq	%rcx, %r8
	movq	%r8, 24(%rax)
	mulxq	32(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 32(%rax)
	mulxq	40(%rsi), %r8, %rdi
	adcq	%rcx, %r8
	movq	%r8, 40(%rax)
	mulxq	48(%rsi), %r8, %rcx
	adcq	%rdi, %r8
	movq	%r8, 48(%rax)
	mulxq	56(%rsi), %rdx, %rsi
	adcq	%rcx, %rdx
	movq	%rdx, 56(%rax)
	adcq	$0, %rsi
	movq	%rsi, 64(%rax)
	retq
.Lfunc_end47:
	.size	mulPv512x64, .Lfunc_end47-mulPv512x64
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
.Lfunc_end48:
	.size	mcl_fp_mont8L, .Lfunc_end48-mcl_fp_mont8L
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
.Lfunc_end49:
	.size	mcl_fp_montNF8L, .Lfunc_end49-mcl_fp_montNF8L
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
	subq	$808, %rsp                      # imm = 0x328
	movq	%rdi, 152(%rsp)                 # 8-byte Spill
	movq	56(%rdx), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	48(%rdx), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	%rsi, 48(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rbx
	movq	24(%rsi), %r13
	movq	16(%rsi), %rbp
	movq	(%rsi), %r12
	movq	8(%rsi), %r15
	movq	-8(%rdx), %rcx
	movq	(%rdx), %rax
	movq	%rdx, %rsi
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdx
	movq	%rcx, %r14
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	imulq	%r12, %rdx
	leaq	720(%rsp), %rdi
	callq	mulPv512x64@PLT
	addq	720(%rsp), %r12
	adcq	728(%rsp), %r15
	adcq	736(%rsp), %rbp
	adcq	744(%rsp), %r13
	adcq	752(%rsp), %rbx
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	760(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	768(%rsp), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	776(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	64(%rax), %rax
	adcq	784(%rsp), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	setb	%r12b
	movq	%r14, %rdx
	imulq	%r15, %rdx
	leaq	640(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	704(%rsp), %rax
	addb	$255, %r12b
	adcq	$0, %rax
	addq	640(%rsp), %r15
	adcq	648(%rsp), %rbp
	adcq	656(%rsp), %r13
	adcq	664(%rsp), %rbx
	movq	16(%rsp), %r14                  # 8-byte Reload
	adcq	672(%rsp), %r14
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	680(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	688(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	696(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r12                  # 8-byte Reload
	adcq	72(%r12), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbp, %rdx
	leaq	560(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	movq	624(%rsp), %rax
	addb	$255, %r15b
	adcq	$0, %rax
	addq	560(%rsp), %rbp
	adcq	568(%rsp), %r13
	adcq	576(%rsp), %rbx
	adcq	584(%rsp), %r14
	movq	%r14, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r14                  # 8-byte Reload
	adcq	592(%rsp), %r14
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	600(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	608(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	616(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	80(%r12), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%r13, %rdx
	leaq	480(%rsp), %rdi
	movq	56(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	movq	544(%rsp), %rax
	addb	$255, %r15b
	adcq	$0, %rax
	addq	480(%rsp), %r13
	adcq	488(%rsp), %rbx
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	496(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	504(%rsp), %r14
	movq	8(%rsp), %r12                   # 8-byte Reload
	adcq	512(%rsp), %r12
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	520(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r13                  # 8-byte Reload
	adcq	528(%rsp), %r13
	movq	72(%rsp), %rcx                  # 8-byte Reload
	adcq	536(%rsp), %rcx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	88(%rcx), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rbx, %rdx
	leaq	400(%rsp), %rdi
	movq	%rbp, %rsi
	callq	mulPv512x64@PLT
	movq	464(%rsp), %rax
	addb	$255, %r15b
	adcq	$0, %rax
	movq	%rax, %rcx
	addq	400(%rsp), %rbx
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	408(%rsp), %rax
	adcq	416(%rsp), %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	adcq	424(%rsp), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %r12                  # 8-byte Reload
	adcq	432(%rsp), %r12
	adcq	440(%rsp), %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %rbx                  # 8-byte Reload
	adcq	448(%rsp), %rbx
	movq	80(%rsp), %rdx                  # 8-byte Reload
	adcq	456(%rsp), %rdx
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rdx                  # 8-byte Reload
	adcq	96(%rdx), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	64(%rsp), %rbp                  # 8-byte Reload
	movq	%rbp, %rdx
	imulq	%rax, %rdx
	movq	%rax, %r14
	leaq	320(%rsp), %rdi
	movq	56(%rsp), %r13                  # 8-byte Reload
	movq	%r13, %rsi
	callq	mulPv512x64@PLT
	movq	384(%rsp), %rax
	addb	$255, %r15b
	adcq	$0, %rax
	movq	%rax, %rdx
	addq	320(%rsp), %r14
	movq	24(%rsp), %rax                  # 8-byte Reload
	adcq	328(%rsp), %rax
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	336(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	344(%rsp), %r12
	movq	%r12, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	352(%rsp), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	360(%rsp), %rbx
	movq	80(%rsp), %rcx                  # 8-byte Reload
	adcq	368(%rsp), %rcx
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %r14                  # 8-byte Reload
	adcq	376(%rsp), %r14
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	104(%rcx), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	setb	%r15b
	movq	%rbp, %rdx
	imulq	%rax, %rdx
	movq	%rax, %r12
	leaq	240(%rsp), %rdi
	movq	%r13, %rsi
	callq	mulPv512x64@PLT
	movq	304(%rsp), %r13
	addb	$255, %r15b
	adcq	$0, %r13
	addq	240(%rsp), %r12
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	248(%rsp), %rax
	movq	32(%rsp), %rcx                  # 8-byte Reload
	adcq	256(%rsp), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	264(%rsp), %rbp
	adcq	272(%rsp), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	80(%rsp), %rbx                  # 8-byte Reload
	adcq	280(%rsp), %rbx
	adcq	288(%rsp), %r14
	movq	%r14, 16(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	296(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r12                  # 8-byte Reload
	adcq	112(%r12), %r13
	setb	%r15b
	movq	64(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	%rax, %r14
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	160(%rsp), %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	callq	mulPv512x64@PLT
	addb	$255, %r15b
	movq	224(%rsp), %rax
	adcq	$0, %rax
	movq	120(%r12), %r11
	movq	160(%rsp), %r12
	addq	%r14, %r12
	movq	168(%rsp), %rcx
	movq	32(%rsp), %rsi                  # 8-byte Reload
	adcq	%rsi, %rcx
	movq	%rcx, %r14
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	176(%rsp), %rcx
	movq	%rbp, %r10
	adcq	%rbp, %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	184(%rsp), %rcx
	movq	72(%rsp), %rbp                  # 8-byte Reload
	adcq	%rbp, %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	movq	192(%rsp), %rcx
	adcq	%rbx, %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	200(%rsp), %r8
	movq	16(%rsp), %rdi                  # 8-byte Reload
	adcq	%rdi, %r8
	movq	208(%rsp), %r9
	movq	24(%rsp), %rdx                  # 8-byte Reload
	adcq	%rdx, %r9
	movq	216(%rsp), %rcx
	adcq	%r13, %rcx
	adcq	%r11, %rax
	xorl	%r15d, %r15d
	cmpq	8(%rsp), %r12                   # 8-byte Folded Reload
	movq	%r14, %r12
	sbbq	%rsi, %r12
	movq	40(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, %r12
	sbbq	%r10, %r12
	movq	56(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %r12
	sbbq	%rbp, %r12
	movq	48(%rsp), %r10                  # 8-byte Reload
	movq	%r10, %r12
	sbbq	%rbx, %r12
	movq	%r8, %r12
	sbbq	%rdi, %r12
	movq	%r9, %r12
	sbbq	%rdx, %r12
	movq	%rcx, %rbx
	sbbq	%r13, %rbx
	movq	%rax, %rbx
	sbbq	%r11, %rbx
	movl	$0, %r11d
	sbbq	%r11, %r11
	movl	$0, %r11d
	sbbq	%r11, %r11
	movl	$0, %r11d
	sbbq	%r11, %r11
	movl	$0, %r11d
	sbbq	%r11, %r11
	movl	$0, %r11d
	sbbq	%r11, %r11
	movl	$0, %r11d
	sbbq	%r11, %r11
	sbbq	%r15, %r15
	setb	%bpl
	movq	64(%rsp), %rdi                  # 8-byte Reload
	movq	%rdi, %r11
	subq	88(%rsp), %r11                  # 8-byte Folded Reload
	movq	%rsi, %rbx
	sbbq	96(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%r14, %r15
	movq	%r14, %rsi
	sbbq	104(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r10, %r14
	sbbq	112(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r8, %r12
	sbbq	120(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r9, %r13
	sbbq	128(%rsp), %r13                 # 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	136(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rax, %rdx
	sbbq	144(%rsp), %rdx                 # 8-byte Folded Reload
	movzbl	%bpl, %ebp
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%rcx, %r10
	movq	152(%rsp), %rcx                 # 8-byte Reload
	movq	%r10, 48(%rcx)
	cmovneq	%rax, %rdx
	movq	%rdx, 56(%rcx)
	cmovneq	%r8, %r12
	movq	%r12, 32(%rcx)
	cmovneq	%r9, %r13
	movq	%r13, 40(%rcx)
	cmovneq	%rsi, %r15
	movq	%r15, 16(%rcx)
	cmovneq	48(%rsp), %r14                  # 8-byte Folded Reload
	movq	%r14, 24(%rcx)
	cmovneq	%rdi, %r11
	movq	%r11, (%rcx)
	cmovneq	40(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%rbx, 8(%rcx)
	addq	$808, %rsp                      # imm = 0x328
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end50:
	.size	mcl_fp_montRed8L, .Lfunc_end50-mcl_fp_montRed8L
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
.Lfunc_end51:
	.size	mcl_fp_montRedNF8L, .Lfunc_end51-mcl_fp_montRedNF8L
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
.Lfunc_end52:
	.size	mcl_fp_addPre8L, .Lfunc_end52-mcl_fp_addPre8L
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
.Lfunc_end53:
	.size	mcl_fp_subPre8L, .Lfunc_end53-mcl_fp_subPre8L
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
.Lfunc_end54:
	.size	mcl_fp_shr1_8L, .Lfunc_end54-mcl_fp_shr1_8L
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
	movq	56(%rsi), %r9
	movq	48(%rsi), %rax
	movq	40(%rsi), %rbp
	movq	32(%rsi), %r8
	movq	24(%rsi), %r12
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	addq	(%rdx), %r11
	movq	%r11, -16(%rsp)                 # 8-byte Spill
	adcq	8(%rdx), %rsi
	movq	%rsi, %r14
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	adcq	16(%rdx), %r10
	adcq	24(%rdx), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	adcq	32(%rdx), %r8
	adcq	40(%rdx), %rbp
	adcq	48(%rdx), %rax
	adcq	56(%rdx), %r9
	setb	-25(%rsp)                       # 1-byte Folded Spill
	movq	%r11, %rsi
	subq	(%rcx), %rsi
	movq	%r14, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %r13
	sbbq	16(%rcx), %r13
	sbbq	24(%rcx), %r12
	movq	%r8, %rbx
	sbbq	32(%rcx), %rbx
	movq	%rbp, %r11
	sbbq	40(%rcx), %r11
	movq	%rax, %r15
	sbbq	48(%rcx), %r15
	movq	%r9, %r14
	sbbq	56(%rcx), %r14
	movzbl	-25(%rsp), %ecx                 # 1-byte Folded Reload
	sbbq	$0, %rcx
	testb	$1, %cl
	cmovneq	%rax, %r15
	movq	%r15, 48(%rdi)
	cmovneq	%r9, %r14
	movq	%r14, 56(%rdi)
	cmovneq	%r8, %rbx
	movq	%rbx, 32(%rdi)
	cmovneq	%rbp, %r11
	movq	%r11, 40(%rdi)
	cmovneq	%r10, %r13
	movq	%r13, 16(%rdi)
	cmovneq	-24(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 24(%rdi)
	cmovneq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, (%rdi)
	cmovneq	-8(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end55:
	.size	mcl_fp_add8L, .Lfunc_end55-mcl_fp_add8L
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
	movq	56(%rsi), %r8
	movq	48(%rsi), %rax
	movq	40(%rsi), %r9
	movq	32(%rsi), %rbx
	movq	24(%rsi), %r13
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rsi
	addq	(%rdx), %r11
	movq	%r11, -16(%rsp)                 # 8-byte Spill
	adcq	8(%rdx), %rsi
	movq	%rsi, %r15
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	adcq	16(%rdx), %r10
	adcq	24(%rdx), %r13
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	adcq	32(%rdx), %rbx
	adcq	40(%rdx), %r9
	adcq	48(%rdx), %rax
	adcq	56(%rdx), %r8
	movq	%r11, %rsi
	subq	(%rcx), %rsi
	movq	%r15, %rdx
	sbbq	8(%rcx), %rdx
	movq	%r10, %r12
	sbbq	16(%rcx), %r12
	sbbq	24(%rcx), %r13
	movq	%rbx, %rbp
	sbbq	32(%rcx), %rbp
	movq	%r9, %r11
	sbbq	40(%rcx), %r11
	movq	%rax, %r15
	sbbq	48(%rcx), %r15
	movq	%r8, %r14
	sbbq	56(%rcx), %r14
	cmovsq	%rax, %r15
	movq	%r15, 48(%rdi)
	cmovsq	%r8, %r14
	movq	%r14, 56(%rdi)
	cmovsq	%rbx, %rbp
	movq	%rbp, 32(%rdi)
	cmovsq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 16(%rdi)
	cmovsq	-24(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r13, 24(%rdi)
	cmovsq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, (%rdi)
	cmovsq	-8(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end56:
	.size	mcl_fp_addNF8L, .Lfunc_end56-mcl_fp_addNF8L
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
.Lfunc_end57:
	.size	mcl_fp_sub8L, .Lfunc_end57-mcl_fp_sub8L
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
.Lfunc_end58:
	.size	mcl_fp_subNF8L, .Lfunc_end58-mcl_fp_subNF8L
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
.Lfunc_end59:
	.size	mcl_fpDbl_add8L, .Lfunc_end59-mcl_fpDbl_add8L
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
.Lfunc_end60:
	.size	mcl_fpDbl_sub8L, .Lfunc_end60-mcl_fpDbl_sub8L
                                        # -- End function
	.globl	mclb_modp256                    # -- Begin function mclb_modp256
	.p2align	4
	.type	mclb_modp256,@function
mclb_modp256:                           # @mclb_modp256
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$152, %rsp
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	cmpq	$9, %rdx
	jae	.LBB61_17
# %bb.1:                                # %L4
	cmpq	$4, %rdx
	jae	.LBB61_2
# %bb.8:                                # %L11
	testq	%rdx, %rdx
	je	.LBB61_12
# %bb.9:                                # %L12
	movq	(%rsi), %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movq	%rax, (%rcx)
	cmpq	$1, %rdx
	je	.LBB61_13
# %bb.10:                               # %L13
	movq	8(%rsi), %rax
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movq	%rax, 8(%rcx)
	cmpq	$2, %rdx
	je	.LBB61_14
# %bb.11:                               # %L14
	movq	16(%rsi), %rax
	jmp	.LBB61_15
.LBB61_2:                               # %L5
	movq	-8(%rsi,%rdx,8), %r8
	movq	(%rcx), %rdi
	movq	8(%rcx), %rax
	movq	%rdx, %r9
	movq	%r8, %rdx
	movq	%rdi, 56(%rsp)                  # 8-byte Spill
	mulxq	%rdi, %r11, %r11
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	addq	%r11, %rdx
	adcq	$0, %r14
	setb	%dl
	movzbl	%dl, %ebx
	shldq	$63, %r14, %rbx
	movq	24(%rcx), %r10
	movq	%r10, %rdx
	mulxq	%rbx, %r11, %rdx
	movb	$63, %r14b
	bzhiq	%r14, %rdx, %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	16(%rcx), %rdi
	movq	%rdi, %rdx
	mulxq	%rbx, %r14, %rax
	addq	-32(%rsi,%r9,8), %r14
	adcq	-24(%rsi,%r9,8), %r11
	movq	32(%rcx), %r12
	movq	%r12, %rdx
	mulxq	%rbx, %r13, %rbp
	adcq	-16(%rsi,%r9,8), %r13
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	40(%rcx), %rdx
	mulxq	%rbx, %r15, %rcx
	adcq	%r8, %r15
	setb	%r8b
	addq	%rax, %r11
	adcq	16(%rsp), %r13                  # 8-byte Folded Reload
	adcq	%rbp, %r15
	movzbl	%r8b, %eax
	adcq	%rcx, %rax
	subq	%rbx, %rax
	movq	%r14, %r8
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	addq	%rdi, %r8
	movq	%r9, %rcx
	movq	%r11, %rdi
	movq	%r10, 16(%rsp)                  # 8-byte Spill
	adcq	%r10, %rdi
	movq	%r13, %r9
	movq	%r12, 64(%rsp)                  # 8-byte Spill
	adcq	%r12, %r9
	movq	%r15, %rbx
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	adcq	%rdx, %rbx
	adcq	$0, %rax
	testb	$1, %al
	cmoveq	%r15, %rbx
	cmoveq	%r13, %r9
	cmoveq	%r11, %rdi
	cmoveq	%r14, %r8
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	cmpq	$4, %rcx
	je	.LBB61_7
# %bb.3:                                # %L6
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	movq	%r9, %rdx
	movq	56(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %r11
	addq	%rax, %r8
	adcq	$0, %r11
	movq	%r9, %rdx
	movq	8(%rsp), %rcx                   # 8-byte Reload
	mulxq	%rcx, %rax, %r14
	addq	%r8, %rax
	adcq	%r11, %r14
	setb	%al
	movzbl	%al, %eax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %rdx
	addq	%r14, %r8
	adcl	%eax, %edx
	shldq	$63, %r8, %rdx
	movq	72(%rsp), %r12                  # 8-byte Reload
	mulxq	%r12, %r8, %r14
	movq	16(%rsp), %r10                  # 8-byte Reload
	mulxq	%r10, %r13, %r15
	movq	%r9, 40(%rsp)                   # 8-byte Spill
	movq	%rdi, %r9
	movq	80(%rsp), %rdi                  # 8-byte Reload
	mulxq	%rdi, %rax, %r11
	addq	%r13, %r11
	movq	64(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %r13, %rbp
	adcq	%r15, %r13
	adcq	%r8, %rbp
	adcq	$0, %r14
	movq	48(%rsp), %r15                  # 8-byte Reload
	addq	-40(%rsi,%r15,8), %rax
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	%r9, %r13
	adcq	40(%rsp), %rbp                  # 8-byte Folded Reload
	adcq	%rbx, %r14
	subq	%rdx, %r14
	movq	%rax, %r8
	addq	%rdi, %r8
	movq	%r11, %rdi
	adcq	%r10, %rdi
	movq	%r13, %r9
	adcq	%rcx, %r9
	movq	%rbp, %rbx
	adcq	%r12, %rbx
	adcq	$0, %r14
	testb	$1, %r14b
	cmoveq	%rbp, %rbx
	cmoveq	%r13, %r9
	cmoveq	%r11, %rdi
	cmoveq	%rax, %r8
	cmpq	$5, %r15
	je	.LBB61_7
# %bb.4:                                # %L7
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	movq	%r9, %rdx
	movq	56(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %r11
	addq	%rax, %r8
	adcq	$0, %r11
	movq	%r9, %rdx
	movq	8(%rsp), %rcx                   # 8-byte Reload
	mulxq	%rcx, %rax, %r14
	addq	%r8, %rax
	adcq	%r11, %r14
	setb	%al
	movzbl	%al, %eax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %rdx
	addq	%r14, %r8
	adcl	%eax, %edx
	shldq	$63, %r8, %rdx
	movq	72(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %rax, %r14
	movq	16(%rsp), %r10                  # 8-byte Reload
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	mulxq	%r10, %r13, %r15
	movq	%r9, %r8
	movq	%rdi, %r9
	movq	80(%rsp), %rdi                  # 8-byte Reload
	mulxq	%rdi, %r12, %r11
	addq	%r13, %r11
	movq	64(%rsp), %rsi                  # 8-byte Reload
	mulxq	%rsi, %r13, %rbp
	adcq	%r15, %r13
	adcq	%rax, %rbp
	adcq	$0, %r14
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	48(%rsp), %r15                  # 8-byte Reload
	addq	-48(%rax,%r15,8), %r12
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	%r9, %r13
	adcq	%r8, %rbp
	adcq	%rbx, %r14
	subq	%rdx, %r14
	movq	%r12, %r8
	addq	%rdi, %r8
	movq	%r11, %rdi
	adcq	%r10, %rdi
	movq	%r13, %r9
	adcq	%rsi, %r9
	movq	%rbp, %rbx
	adcq	%rcx, %rbx
	adcq	$0, %r14
	testb	$1, %r14b
	cmoveq	%rbp, %rbx
	cmoveq	%r13, %r9
	cmoveq	%r11, %rdi
	cmoveq	%r12, %r8
	cmpq	$6, %r15
	je	.LBB61_7
# %bb.5:                                # %L8
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	movq	%r9, %rdx
	movq	56(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %r11
	addq	%rax, %r8
	adcq	$0, %r11
	movq	%r9, %rdx
	movq	8(%rsp), %rcx                   # 8-byte Reload
	mulxq	%rcx, %rax, %r14
	addq	%r8, %rax
	adcq	%r11, %r14
	setb	%al
	movzbl	%al, %eax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %rdx
	addq	%r14, %r8
	adcl	%eax, %edx
	shldq	$63, %r8, %rdx
	movq	72(%rsp), %rsi                  # 8-byte Reload
	mulxq	%rsi, %rax, %r14
	movq	16(%rsp), %r10                  # 8-byte Reload
	mulxq	%r10, %r13, %r15
	movq	%r9, %r8
	movq	%rdi, %r9
	movq	80(%rsp), %rdi                  # 8-byte Reload
	mulxq	%rdi, %r12, %r11
	addq	%r13, %r11
	movq	64(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %r13, %rbp
	adcq	%r15, %r13
	movq	40(%rsp), %r15                  # 8-byte Reload
	adcq	%rax, %rbp
	adcq	$0, %r14
	movq	48(%rsp), %rax                  # 8-byte Reload
	addq	-56(%r15,%rax,8), %r12
	adcq	32(%rsp), %r11                  # 8-byte Folded Reload
	adcq	%r9, %r13
	adcq	%r8, %rbp
	adcq	%rbx, %r14
	subq	%rdx, %r14
	movq	%r12, %r8
	addq	%rdi, %r8
	movq	%r11, %rdi
	adcq	%r10, %rdi
	movq	%r13, %r9
	adcq	%rcx, %r9
	movq	%rbp, %rbx
	adcq	%rsi, %rbx
	adcq	$0, %r14
	testb	$1, %r14b
	cmoveq	%rbp, %rbx
	cmoveq	%r13, %r9
	cmoveq	%r11, %rdi
	cmoveq	%r12, %r8
	cmpq	$7, %rax
	je	.LBB61_7
# %bb.6:                                # %L9
	movq	88(%rsp), %rsi                  # 8-byte Reload
	addq	$16, %rsi
	movq	%r15, %r14
	movq	%r8, %r15
	movq	%r9, %rdx
	movq	56(%rsp), %rcx                  # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rbx, %rdx
	mulxq	%rcx, %r8, %r10
	addq	%rax, %r8
	adcq	$0, %r10
	movq	%r9, %rdx
	movq	8(%rsp), %rcx                   # 8-byte Reload
	mulxq	%rcx, %rax, %r11
	addq	%r8, %rax
	adcq	%r10, %r11
	setb	%al
	movzbl	%al, %eax
	movq	%rbx, %rdx
	mulxq	%rcx, %rcx, %rdx
	addq	%r11, %rcx
	adcl	%eax, %edx
	shldq	$63, %rcx, %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	-64(%r14,%rax,8), %r14
	leaq	96(%rsp), %rax
	movq	%rdi, %r13
	movq	%rax, %rdi
	movq	64(%rsp), %r12                  # 8-byte Reload
	movq	%r9, %rbp
	callq	mulPv256x64@PLT
	addq	96(%rsp), %r14
	adcq	104(%rsp), %r15
	adcq	112(%rsp), %r13
	adcq	120(%rsp), %rbp
	adcq	128(%rsp), %rbx
	subq	8(%rsp), %rbx                   # 8-byte Folded Reload
	movq	80(%rsp), %r8                   # 8-byte Reload
	addq	%r14, %r8
	movq	16(%rsp), %rax                  # 8-byte Reload
	adcq	%r15, %rax
	adcq	%r13, %r12
	movq	72(%rsp), %rdx                  # 8-byte Reload
	adcq	%rbp, %rdx
	adcq	$0, %rbx
	testb	$1, %bl
	cmoveq	%rbp, %rdx
	cmoveq	%r13, %r12
	cmoveq	%r15, %rax
	cmoveq	%r14, %r8
	movq	%rax, %rdi
	movq	%r12, %r9
	movq	%rdx, %rbx
.LBB61_7:                               # %L10
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	%r8, (%rax)
	movq	%rdi, 8(%rax)
	movq	%r9, 16(%rax)
	movq	%rbx, 24(%rax)
	jmp	.LBB61_16
.LBB61_12:                              # %L15
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	$0, (%rax)
.LBB61_13:                              # %L16
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	$0, 8(%rax)
.LBB61_14:                              # %L18
	xorl	%eax, %eax
.LBB61_15:                              # %L18
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movq	%rax, 16(%rcx)
	movq	$0, 24(%rcx)
.LBB61_16:                              # %common.ret
	movl	$1, %eax
.LBB61_17:                              # %common.ret
	addq	$152, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end61:
	.size	mclb_modp256, .Lfunc_end61-mclb_modp256
                                        # -- End function
	.globl	mclb_modp384                    # -- Begin function mclb_modp384
	.p2align	4
	.type	mclb_modp384,@function
mclb_modp384:                           # @mclb_modp384
# %bb.0:
	xorl	%eax, %eax
	cmpq	$9, %rdx
	jae	.LBB62_19
# %bb.1:                                # %L20
	movq	%rdx, %r11
	cmpq	$6, %rdx
	jae	.LBB62_2
# %bb.7:                                # %L25
	testq	%r11, %r11
	je	.LBB62_13
# %bb.8:                                # %L26
	movq	(%rsi), %rax
	movq	%rax, (%rdi)
	cmpq	$1, %r11
	je	.LBB62_14
# %bb.9:                                # %L27
	movq	8(%rsi), %rax
	movq	%rax, 8(%rdi)
	cmpq	$2, %r11
	je	.LBB62_15
# %bb.10:                               # %L28
	movq	16(%rsi), %rax
	movq	%rax, 16(%rdi)
	cmpq	$3, %r11
	je	.LBB62_16
# %bb.11:                               # %L29
	movq	24(%rsi), %rax
	movq	%rax, 24(%rdi)
	cmpq	$4, %r11
	je	.LBB62_17
# %bb.12:                               # %L30
	movq	32(%rsi), %rax
	jmp	.LBB62_18
.LBB62_2:                               # %L21
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	-8(%rsi,%r11,8), %rbp
	movq	(%rcx), %rax
	movq	8(%rcx), %rdi
	movq	%rbp, %rdx
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %rax
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdx, %rdi
	addq	%rax, %rdx
	adcq	$0, %rdi
	setb	%al
	movzbl	%al, %ebx
	shldq	$63, %rdi, %rbx
	movq	24(%rcx), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%rbx, %r12, %rax
	movb	$63, %dl
	bzhiq	%rdx, %rax, %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	16(%rcx), %r15
	movq	%r15, %rdx
	movq	%rsi, %r13
	mulxq	%rbx, %rax, %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	addq	-48(%rsi,%r11,8), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	adcq	-40(%rsi,%r11,8), %r12
	movq	32(%rcx), %r14
	movq	%r14, %rdx
	mulxq	%rbx, %r9, %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	adcq	-32(%rsi,%r11,8), %r9
	movq	40(%rcx), %r8
	movq	%r8, %rdx
	mulxq	%rbx, %r10, %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	adcq	-24(%rsi,%r11,8), %r10
	movq	48(%rcx), %rdi
	movq	%rdi, %rdx
	mulxq	%rbx, %rax, %rsi
	movq	%r13, -40(%rsp)                 # 8-byte Spill
	adcq	-16(%r13,%r11,8), %rax
	movq	56(%rcx), %rcx
	movq	%rbx, %rdx
	mulxq	%rcx, %rdx, %r13
	adcq	%rbp, %rdx
	setb	%bpl
	addq	-104(%rsp), %r12                # 8-byte Folded Reload
	adcq	-96(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-72(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-80(%rsp), %rax                 # 8-byte Folded Reload
	adcq	%rsi, %rdx
	movzbl	%bpl, %esi
	adcq	%r13, %rsi
	subq	%rbx, %rsi
	movq	-88(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %r13
	movq	%r15, -96(%rsp)                 # 8-byte Spill
	addq	%r15, %r13
	movq	%r12, %rbp
	adcq	-64(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r9, %r15
	movq	%r14, -104(%rsp)                # 8-byte Spill
	adcq	%r14, %r15
	movq	%r10, %r14
	movq	%r8, -80(%rsp)                  # 8-byte Spill
	adcq	%r8, %r14
	movq	%rax, %r8
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	adcq	%rdi, %r8
	movq	%rdx, %rdi
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	adcq	%rcx, %rdi
	adcq	$0, %rsi
	testb	$1, %sil
	cmoveq	%rdx, %rdi
	movq	%r13, %rdx
	cmoveq	%rax, %r8
	cmoveq	%r10, %r14
	movq	%r14, -112(%rsp)                # 8-byte Spill
	cmoveq	%r9, %r15
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	cmoveq	%r12, %rbp
	movq	%rbp, %r14
	cmoveq	%rbx, %rdx
	cmpq	$6, %r11
	jne	.LBB62_4
# %bb.3:
	movq	-56(%rsp), %r12                 # 8-byte Reload
	movq	-112(%rsp), %rbx                # 8-byte Reload
	movq	%r8, %r15
	jmp	.LBB62_6
.LBB62_4:                               # %L22
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%r8, %rdx
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rdi, %rdx
	mulxq	%rcx, %rsi, %r9
	addq	%rax, %rsi
	adcq	$0, %r9
	movq	%r8, %rdx
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %rax, %r10
	addq	%rsi, %rax
	adcq	%r9, %r10
	setb	%al
	movzbl	%al, %eax
	movq	%rdi, %rdx
	mulxq	%rcx, %rsi, %rdx
	addq	%r10, %rsi
	adcl	%eax, %edx
	shldq	$63, %rsi, %rdx
	mulxq	-64(%rsp), %rsi, %rax           # 8-byte Folded Reload
	mulxq	-96(%rsp), %rbx, %rbp           # 8-byte Folded Reload
	addq	%rsi, %rbp
	mulxq	-104(%rsp), %r9, %rsi           # 8-byte Folded Reload
	adcq	%rax, %r9
	movq	-80(%rsp), %r15                 # 8-byte Reload
	movq	%r14, -48(%rsp)                 # 8-byte Spill
	mulxq	%r15, %r10, %r14
	adcq	%rsi, %r10
	mulxq	-72(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%r14, %rax
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %r14, %rsi
	adcq	%r13, %r14
	adcq	$0, %rsi
	movq	-40(%rsp), %r12                 # 8-byte Reload
	addq	-56(%r12,%r11,8), %rbx
	adcq	-88(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-48(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-56(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-112(%rsp), %rax                # 8-byte Folded Reload
	adcq	%r8, %r14
	adcq	%rdi, %rsi
	subq	%rdx, %rsi
	movq	%rbx, %rdx
	movq	%rbx, %r8
	addq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rbp, %r13
	adcq	-64(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r9, %r12
	adcq	-104(%rsp), %r12                # 8-byte Folded Reload
	movq	%r10, %rbx
	adcq	%r15, %rbx
	movq	%rax, %r15
	adcq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r14, %rdi
	adcq	%rcx, %rdi
	adcq	$0, %rsi
	testb	$1, %sil
	cmoveq	%r14, %rdi
	cmoveq	%rax, %r15
	cmoveq	%r10, %rbx
	cmoveq	%r9, %r12
	cmoveq	%rbp, %r13
	movq	%r13, %r14
	cmoveq	%r8, %rdx
	cmpq	$7, %r11
	je	.LBB62_6
# %bb.5:                                # %L23
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	movq	%r15, %rdx
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %rax, %rax
	movq	%rdi, %rdx
	mulxq	%rcx, %rsi, %r9
	addq	%rax, %rsi
	adcq	$0, %r9
	movq	%r15, %rdx
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %rax, %r10
	addq	%rsi, %rax
	adcq	%r9, %r10
	movq	%rdi, %rdx
	mulxq	%rcx, %rax, %rdx
	setb	%sil
	addq	%r10, %rax
	movzbl	%sil, %esi
	adcl	%esi, %edx
	shldq	$63, %rax, %rdx
	mulxq	-64(%rsp), %rsi, %rax           # 8-byte Folded Reload
	mulxq	-96(%rsp), %r9, %rcx            # 8-byte Folded Reload
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	addq	%rsi, %rcx
	movq	%rcx, -56(%rsp)                 # 8-byte Spill
	mulxq	-104(%rsp), %r9, %rsi           # 8-byte Folded Reload
	adcq	%rax, %r9
	movq	%r14, -48(%rsp)                 # 8-byte Spill
	mulxq	-80(%rsp), %r10, %r14           # 8-byte Folded Reload
	adcq	%rsi, %r10
	movq	-72(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %rax, %r13
	adcq	%r14, %rax
	movq	-16(%rsp), %r8                  # 8-byte Reload
	mulxq	%r8, %r14, %rsi
	adcq	%r13, %r14
	adcq	$0, %rsi
	movq	-112(%rsp), %rbp                # 8-byte Reload
	movq	-40(%rsp), %r13                 # 8-byte Reload
	addq	-64(%r13,%r11,8), %rbp
	movq	%rbp, -112(%rsp)                # 8-byte Spill
	movq	-56(%rsp), %rbp                 # 8-byte Reload
	adcq	-88(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-48(%rsp), %r9                  # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	%rbx, %rax
	adcq	%r15, %r14
	adcq	%rdi, %rsi
	subq	%rdx, %rsi
	movq	-112(%rsp), %rdi                # 8-byte Reload
	movq	-96(%rsp), %r11                 # 8-byte Reload
	addq	%rdi, %r11
	movq	-64(%rsp), %rdx                 # 8-byte Reload
	adcq	%rbp, %rdx
	movq	-104(%rsp), %r12                # 8-byte Reload
	adcq	%r9, %r12
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	adcq	%r10, %rbx
	adcq	%rax, %rcx
	adcq	%r14, %r8
	adcq	$0, %rsi
	testb	$1, %sil
	cmoveq	%r14, %r8
	cmoveq	%rax, %rcx
	cmoveq	%r10, %rbx
	cmoveq	%r9, %r12
	movq	%rdx, %r14
	cmoveq	%rbp, %r14
	movq	%r11, %rdx
	cmoveq	%rdi, %rdx
	movq	%rcx, %r15
	movq	%r8, %rdi
.LBB62_6:                               # %L24
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rdx, (%rax)
	movq	%r14, 8(%rax)
	movq	%r12, 16(%rax)
	movq	%rbx, 24(%rax)
	movq	%r15, 32(%rax)
	movq	%rdi, 40(%rax)
	movl	$1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB62_13:                              # %L31
	movq	$0, (%rdi)
.LBB62_14:                              # %L32
	movq	$0, 8(%rdi)
.LBB62_15:                              # %L33
	movq	$0, 16(%rdi)
.LBB62_16:                              # %L34
	movq	$0, 24(%rdi)
.LBB62_17:                              # %L36
	xorl	%eax, %eax
.LBB62_18:                              # %L36
	movq	%rax, 32(%rdi)
	movq	$0, 40(%rdi)
	movl	$1, %eax
.LBB62_19:                              # %common.ret
	retq
.Lfunc_end62:
	.size	mclb_modp384, .Lfunc_end62-mclb_modp384
                                        # -- End function
	.globl	mcl_fp_neg4L                    # -- Begin function mcl_fp_neg4L
	.p2align	4
	.type	mcl_fp_neg4L,@function
mcl_fp_neg4L:                           # @mcl_fp_neg4L
# %bb.0:
	movq	24(%rsi), %r8
	movq	(%rsi), %r10
	movq	8(%rsi), %r9
	movq	%r9, %rax
	orq	%r8, %rax
	movq	16(%rsi), %r11
	movq	%r10, %rcx
	orq	%r11, %rcx
	orq	%rax, %rcx
	je	.LBB63_1
# %bb.2:                                # %L37
	movq	24(%rdx), %rcx
	movq	16(%rdx), %rsi
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	subq	%r10, %rax
	sbbq	%r9, %rdx
	sbbq	%r11, %rsi
	sbbq	%r8, %rcx
	jmp	.LBB63_3
.LBB63_1:
	xorl	%eax, %eax
	xorl	%edx, %edx
	xorl	%esi, %esi
	xorl	%ecx, %ecx
.LBB63_3:                               # %L39
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%rcx, 24(%rdi)
	retq
.Lfunc_end63:
	.size	mcl_fp_neg4L, .Lfunc_end63-mcl_fp_neg4L
                                        # -- End function
	.globl	mcl_fp_mul2_4L                  # -- Begin function mcl_fp_mul2_4L
	.p2align	4
	.type	mcl_fp_mul2_4L,@function
mcl_fp_mul2_4L:                         # @mcl_fp_mul2_4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rcx
	movq	8(%rsi), %rax
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r9
	adcq	24(%rsi), %r8
	setb	%sil
	movzbl	%sil, %esi
	movq	%rcx, %r10
	subq	(%rdx), %r10
	movq	%rax, %r11
	sbbq	8(%rdx), %r11
	movq	%r9, %rbx
	sbbq	16(%rdx), %rbx
	movq	%r8, %r14
	sbbq	24(%rdx), %r14
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%r9, %rbx
	movq	%rbx, 16(%rdi)
	cmovneq	%r8, %r14
	movq	%r14, 24(%rdi)
	cmovneq	%rcx, %r10
	movq	%r10, (%rdi)
	cmovneq	%rax, %r11
	movq	%r11, 8(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end64:
	.size	mcl_fp_mul2_4L, .Lfunc_end64-mcl_fp_mul2_4L
                                        # -- End function
	.globl	mcl_fp_sqr4L                    # -- Begin function mcl_fp_sqr4L
	.p2align	4
	.type	mcl_fp_sqr4L,@function
mcl_fp_sqr4L:                           # @mcl_fp_sqr4L
# %bb.0:
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	jmp	mcl_fp_mont4L@PLT               # TAILCALL
.Lfunc_end65:
	.size	mcl_fp_sqr4L, .Lfunc_end65-mcl_fp_sqr4L
                                        # -- End function
	.globl	mcl_fp_mul2NF4L                 # -- Begin function mcl_fp_mul2NF4L
	.p2align	4
	.type	mcl_fp_mul2NF4L,@function
mcl_fp_mul2NF4L:                        # @mcl_fp_mul2NF4L
# %bb.0:
	pushq	%rbx
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %r9
	addq	(%rsi), %r8
	adcq	8(%rsi), %r9
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rax
	movq	%r8, %rsi
	subq	(%rdx), %rsi
	movq	%r9, %r10
	sbbq	8(%rdx), %r10
	movq	%rcx, %r11
	sbbq	16(%rdx), %r11
	movq	%rax, %rbx
	sbbq	24(%rdx), %rbx
	cmovsq	%rcx, %r11
	movq	%r11, 16(%rdi)
	cmovsq	%rax, %rbx
	movq	%rbx, 24(%rdi)
	cmovsq	%r8, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r9, %r10
	movq	%r10, 8(%rdi)
	popq	%rbx
	retq
.Lfunc_end66:
	.size	mcl_fp_mul2NF4L, .Lfunc_end66-mcl_fp_mul2NF4L
                                        # -- End function
	.globl	mcl_fp_sqrNF4L                  # -- Begin function mcl_fp_sqrNF4L
	.p2align	4
	.type	mcl_fp_sqrNF4L,@function
mcl_fp_sqrNF4L:                         # @mcl_fp_sqrNF4L
# %bb.0:
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	jmp	mcl_fp_montNF4L@PLT             # TAILCALL
.Lfunc_end67:
	.size	mcl_fp_sqrNF4L, .Lfunc_end67-mcl_fp_sqrNF4L
                                        # -- End function
	.p2align	4                               # -- Begin function mcl_fp2_mulPre4L
	.type	.Lmcl_fp2_mulPre4L,@function
.Lmcl_fp2_mulPre4L:                     # @mcl_fp2_mulPre4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r8
	movq	8(%rsi), %rcx
	movq	(%rdx), %r10
	movq	%r8, %rdx
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulxq	%r10, %rbx, %r11
	movq	16(%rsi), %rax
	movq	24(%rsi), %r9
	movq	%rbx, (%rdi)
	movq	%r9, %rdx
	mulxq	%r10, %rbx, %r14
	movq	%rcx, %rdx
	movq	%rcx, %rsi
	mulxq	%r10, %r12, %r15
	addq	%r11, %r12
	movq	%rax, %rdx
	movq	%rax, %rbp
	mulxq	%r10, %r10, %r13
	adcq	%r15, %r10
	adcq	%rbx, %r13
	adcq	$0, %r14
	setb	%bl
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	%r8, %rax, %r8
	movq	%r8, -24(%rsp)                  # 8-byte Spill
	addq	%r12, %rax
	mulxq	%rsi, %r11, %r12
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	adcq	%r10, %r11
	mulxq	%rbp, %r15, %r10
	movq	%rbp, %r8
	movq	%rbp, -8(%rsp)                  # 8-byte Spill
	adcq	%r13, %r15
	mulxq	%r9, %r13, %rdx
	adcq	%r14, %r13
	movzbl	%bl, %ebp
	adcq	$0, %rbp
	addq	-24(%rsp), %r11                 # 8-byte Folded Reload
	adcq	%r12, %r15
	movq	%rax, 8(%rdi)
	adcq	%r10, %r13
	adcq	%rdx, %rbp
	movq	16(%rcx), %rdx
	mulxq	%rsi, %r10, %r12
	mulxq	-32(%rsp), %rax, %rbx           # 8-byte Folded Reload
	addq	%r10, %rbx
	mulxq	%r8, %r14, %rcx
	adcq	%r12, %r14
	movq	%r9, %rsi
	mulxq	%r9, %r12, %r10
	adcq	%rcx, %r12
	adcq	$0, %r10
	addq	%r11, %rax
	adcq	%r15, %rbx
	movq	%rax, 16(%rdi)
	adcq	%r13, %r14
	adcq	%rbp, %r12
	adcq	$0, %r10
	movq	-40(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-16(%rsp), %rcx, %rax           # 8-byte Folded Reload
	mulxq	-32(%rsp), %r8, %r9             # 8-byte Folded Reload
	addq	%rcx, %r9
	mulxq	%rsi, %rcx, %rsi
	mulxq	-8(%rsp), %rdx, %r11            # 8-byte Folded Reload
	adcq	%rax, %rdx
	adcq	%rcx, %r11
	adcq	$0, %rsi
	addq	%rbx, %r8
	movq	%r8, 24(%rdi)
	adcq	%r14, %r9
	movq	%r9, 32(%rdi)
	adcq	%r12, %rdx
	movq	%rdx, 40(%rdi)
	adcq	%r10, %r11
	movq	%r11, 48(%rdi)
	adcq	$0, %rsi
	movq	%rsi, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end68:
	.size	.Lmcl_fp2_mulPre4L, .Lfunc_end68-.Lmcl_fp2_mulPre4L
                                        # -- End function
	.globl	mcl_fp2_add4L                   # -- Begin function mcl_fp2_add4L
	.p2align	4
	.type	mcl_fp2_add4L,@function
mcl_fp2_add4L:                          # @mcl_fp2_add4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	24(%rcx), %rax
	movq	16(%rcx), %r8
	movq	(%rcx), %r9
	movq	8(%rcx), %rcx
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	addq	(%rdx), %rbx
	adcq	8(%rdx), %r14
	adcq	16(%rdx), %r11
	adcq	24(%rdx), %r10
	movq	%rbx, %r15
	subq	%r9, %r15
	movq	%r14, %r12
	sbbq	%rcx, %r12
	movq	%r11, %r13
	sbbq	%r8, %r13
	movq	%r10, %rbp
	sbbq	%rax, %rbp
	cmovsq	%r14, %r12
	movq	%r12, 8(%rdi)
	cmovsq	%r11, %r13
	movq	%r13, 16(%rdi)
	cmovsq	%r10, %rbp
	movq	%rbp, 24(%rdi)
	cmovsq	%rbx, %r15
	movq	%r15, (%rdi)
	movq	72(%rsi), %r10
	movq	64(%rsi), %r11
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	addq	48(%rdx), %rbx
	adcq	56(%rdx), %rsi
	adcq	64(%rdx), %r11
	adcq	72(%rdx), %r10
	movq	%rbx, %rdx
	subq	%r9, %rdx
	movq	%rsi, %r9
	sbbq	%rcx, %r9
	movq	%r11, %rcx
	sbbq	%r8, %rcx
	movq	%r10, %r8
	sbbq	%rax, %r8
	cmovsq	%r11, %rcx
	movq	%rcx, 64(%rdi)
	cmovsq	%r10, %r8
	movq	%r8, 72(%rdi)
	cmovsq	%rbx, %rdx
	movq	%rdx, 48(%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end69:
	.size	mcl_fp2_add4L, .Lfunc_end69-mcl_fp2_add4L
                                        # -- End function
	.globl	mcl_fp2_sub4L                   # -- Begin function mcl_fp2_sub4L
	.p2align	4
	.type	mcl_fp2_sub4L,@function
mcl_fp2_sub4L:                          # @mcl_fp2_sub4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	(%rcx), %r10
	movq	8(%rcx), %r9
	movq	16(%rcx), %r8
	movq	24(%rcx), %rax
	movq	24(%rsi), %rcx
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %r14
	sbbq	16(%rdx), %r11
	sbbq	24(%rdx), %rcx
	movq	%rcx, %r15
	sarq	$63, %r15
	movq	%r15, %r12
	andq	%rax, %r12
	movq	%r15, %r13
	andq	%r8, %r13
	movq	%r15, %rbp
	andq	%r9, %rbp
	andq	%r10, %r15
	addq	%rbx, %r15
	adcq	%r14, %rbp
	movq	%r15, (%rdi)
	movq	%rbp, 8(%rdi)
	adcq	%r11, %r13
	movq	%r13, 16(%rdi)
	adcq	%rcx, %r12
	movq	%r12, 24(%rdi)
	movq	72(%rsi), %rcx
	movq	64(%rsi), %r11
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	subq	48(%rdx), %rbx
	sbbq	56(%rdx), %rsi
	sbbq	64(%rdx), %r11
	sbbq	72(%rdx), %rcx
	movq	%rcx, %rdx
	sarq	$63, %rdx
	andq	%rdx, %rax
	andq	%rdx, %r8
	andq	%rdx, %r9
	andq	%r10, %rdx
	addq	%rbx, %rdx
	movq	%rdx, 48(%rdi)
	adcq	%rsi, %r9
	movq	%r9, 56(%rdi)
	adcq	%r11, %r8
	movq	%r8, 64(%rdi)
	adcq	%rcx, %rax
	movq	%rax, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end70:
	.size	mcl_fp2_sub4L, .Lfunc_end70-mcl_fp2_sub4L
                                        # -- End function
	.globl	mcl_fp2_neg4L                   # -- Begin function mcl_fp2_neg4L
	.p2align	4
	.type	mcl_fp2_neg4L,@function
mcl_fp2_neg4L:                          # @mcl_fp2_neg4L
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	24(%rsi), %r9
	movq	(%rsi), %rbx
	movq	8(%rsi), %r11
	movq	%r11, %rax
	orq	%r9, %rax
	movq	16(%rsi), %r14
	movq	%rbx, %rcx
	orq	%r14, %rcx
	orq	%rax, %rcx
	je	.LBB71_1
# %bb.2:                                # %L40
	movq	24(%rdx), %rcx
	movq	16(%rdx), %r8
	movq	(%rdx), %rax
	movq	8(%rdx), %r10
	subq	%rbx, %rax
	sbbq	%r11, %r10
	sbbq	%r14, %r8
	sbbq	%r9, %rcx
	jmp	.LBB71_3
.LBB71_1:
	xorl	%eax, %eax
	xorl	%r10d, %r10d
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
.LBB71_3:                               # %L42
	movq	%rax, (%rdi)
	movq	%r10, 8(%rdi)
	movq	%r8, 16(%rdi)
	movq	%rcx, 24(%rdi)
	movq	72(%rsi), %r8
	movq	48(%rsi), %r10
	movq	56(%rsi), %r9
	movq	%r9, %rax
	orq	%r8, %rax
	movq	64(%rsi), %r11
	movq	%r10, %rcx
	orq	%r11, %rcx
	orq	%rax, %rcx
	je	.LBB71_4
# %bb.5:                                # %L43
	movq	24(%rdx), %rcx
	movq	16(%rdx), %rsi
	movq	(%rdx), %rax
	movq	8(%rdx), %rdx
	subq	%r10, %rax
	sbbq	%r9, %rdx
	sbbq	%r11, %rsi
	sbbq	%r8, %rcx
	jmp	.LBB71_6
.LBB71_4:
	xorl	%eax, %eax
	xorl	%edx, %edx
	xorl	%esi, %esi
	xorl	%ecx, %ecx
.LBB71_6:                               # %L45
	movq	%rax, 48(%rdi)
	movq	%rdx, 56(%rdi)
	movq	%rsi, 64(%rdi)
	movq	%rcx, 72(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end71:
	.size	mcl_fp2_neg4L, .Lfunc_end71-mcl_fp2_neg4L
                                        # -- End function
	.globl	mcl_fp2_mul2_4L                 # -- Begin function mcl_fp2_mul2_4L
	.p2align	4
	.type	mcl_fp2_mul2_4L,@function
mcl_fp2_mul2_4L:                        # @mcl_fp2_mul2_4L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	24(%rdx), %rax
	movq	16(%rdx), %rcx
	movq	(%rdx), %r8
	movq	8(%rdx), %rdx
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rbx
	addq	(%rsi), %r11
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	movq	%r11, %r14
	subq	%r8, %r14
	movq	%rbx, %r15
	sbbq	%rdx, %r15
	movq	%r10, %r12
	sbbq	%rcx, %r12
	movq	%r9, %r13
	sbbq	%rax, %r13
	cmovsq	%rbx, %r15
	movq	%r15, 8(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 16(%rdi)
	cmovsq	%r9, %r13
	movq	%r13, 24(%rdi)
	cmovsq	%r11, %r14
	movq	%r14, (%rdi)
	movq	72(%rsi), %r9
	movq	64(%rsi), %r10
	movq	48(%rsi), %r11
	movq	56(%rsi), %rbx
	addq	48(%rsi), %r11
	adcq	56(%rsi), %rbx
	adcq	64(%rsi), %r10
	adcq	72(%rsi), %r9
	movq	%r11, %rsi
	subq	%r8, %rsi
	movq	%rbx, %r8
	sbbq	%rdx, %r8
	movq	%r10, %rdx
	sbbq	%rcx, %rdx
	movq	%r9, %rcx
	sbbq	%rax, %rcx
	cmovsq	%r10, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r9, %rcx
	movq	%rcx, 72(%rdi)
	cmovsq	%r11, %rsi
	movq	%rsi, 48(%rdi)
	cmovsq	%rbx, %r8
	movq	%r8, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end72:
	.size	mcl_fp2_mul2_4L, .Lfunc_end72-mcl_fp2_mul2_4L
                                        # -- End function
	.globl	mcl_fp2_mul_u1_4L               # -- Begin function mcl_fp2_mul_u1_4L
	.p2align	4
	.type	mcl_fp2_mul_u1_4L,@function
mcl_fp2_mul_u1_4L:                      # @mcl_fp2_mul_u1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$344, %rsp                      # imm = 0x158
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, 144(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%rbp), %rdx
	adcq	8(%rbp), %rsi
	adcq	16(%rbp), %rcx
	adcq	24(%rbp), %rax
	movq	72(%r13), %rdi
	movq	64(%r13), %r8
	movq	48(%r13), %r9
	movq	56(%r13), %r10
	addq	(%r13), %r9
	adcq	8(%r13), %r10
	adcq	16(%r13), %r8
	adcq	24(%r13), %rdi
	movq	%r8, 232(%rsp)
	movq	%rdi, 240(%rsp)
	movq	%r9, 216(%rsp)
	movq	%r10, 224(%rsp)
	movq	%rcx, 264(%rsp)
	movq	%rax, 272(%rsp)
	movq	%rdx, 248(%rsp)
	movq	%rsi, 256(%rsp)
	leaq	152(%rsp), %rdi
	leaq	248(%rsp), %rsi
	leaq	216(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre4L
	movq	%rsp, %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre4L
	addq	$48, %rbp
	addq	$48, %r13
	leaq	280(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre4L
	movq	312(%rsp), %rdi
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %rbp
	movq	%rbp, 120(%rsp)                 # 8-byte Spill
	movq	304(%rsp), %r9
	movq	%r9, 96(%rsp)                   # 8-byte Spill
	movq	24(%rsp), %rbx
	movq	%rbx, 112(%rsp)                 # 8-byte Spill
	movq	296(%rsp), %r10
	movq	%r10, 88(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %r11
	movq	280(%rsp), %rcx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	288(%rsp), %r8
	movq	%r8, 80(%rsp)                   # 8-byte Spill
	movq	(%rsp), %r13
	movq	8(%rsp), %rdx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movq	%r13, %rsi
	addq	%rcx, %rsi
	movq	%rdx, %rcx
	adcq	%r8, %rcx
	movq	%r11, %r8
	adcq	%r10, %r8
	adcq	%r9, %rbx
	adcq	%rdi, %rbp
	movq	320(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r15
	movq	%r15, %rdi
	adcq	%rax, %rdi
	movq	328(%rsp), %r12
	movq	48(%rsp), %r14
	movq	%r14, %r9
	adcq	%r12, %r9
	movq	336(%rsp), %rdx
	movq	56(%rsp), %rax
	movq	%rax, %r10
	adcq	%rdx, %r10
	subq	%rsi, 152(%rsp)
	sbbq	%rcx, 160(%rsp)
	sbbq	%r8, 168(%rsp)
	sbbq	%rbx, 176(%rsp)
	sbbq	%rbp, 184(%rsp)
	sbbq	%rdi, 192(%rsp)
	sbbq	%r9, 200(%rsp)
	sbbq	%r10, 208(%rsp)
	subq	72(%rsp), %r13                  # 8-byte Folded Reload
	movq	128(%rsp), %rdi                 # 8-byte Reload
	sbbq	80(%rsp), %rdi                  # 8-byte Folded Reload
	sbbq	88(%rsp), %r11                  # 8-byte Folded Reload
	movq	112(%rsp), %rsi                 # 8-byte Reload
	sbbq	96(%rsp), %rsi                  # 8-byte Folded Reload
	movq	120(%rsp), %r8                  # 8-byte Reload
	sbbq	104(%rsp), %r8                  # 8-byte Folded Reload
	sbbq	64(%rsp), %r15                  # 8-byte Folded Reload
	sbbq	%r12, %r14
	sbbq	%rdx, %rax
	movq	%r11, 16(%rsp)
	movq	%rax, %rcx
	sarq	$63, %rcx
	movq	%rsi, 24(%rsp)
	movq	136(%rsp), %rbx                 # 8-byte Reload
	movq	24(%rbx), %rdx
	andq	%rcx, %rdx
	movq	%r13, (%rsp)
	movq	16(%rbx), %rsi
	andq	%rcx, %rsi
	movq	%rdi, 8(%rsp)
	movq	8(%rbx), %rdi
	andq	%rcx, %rdi
	andq	(%rbx), %rcx
	addq	%r8, %rcx
	movq	%rcx, 32(%rsp)
	adcq	%r15, %rdi
	movq	%rdi, 40(%rsp)
	adcq	%r14, %rsi
	movq	%rsi, 48(%rsp)
	adcq	%rax, %rdx
	movq	%rdx, 56(%rsp)
	movq	144(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rdi
	movq	%rsp, %rsi
	movq	%rbx, %rdx
	callq	mcl_fp_montRedNF4L@PLT
	addq	$48, %r14
	movq	%r14, %rdi
	leaq	152(%rsp), %rsi
	movq	%rbx, %rdx
	callq	mcl_fp_montRedNF4L@PLT
	addq	$344, %rsp                      # imm = 0x158
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end73:
	.size	mcl_fp2_mul_u1_4L, .Lfunc_end73-mcl_fp2_mul_u1_4L
                                        # -- End function
	.globl	mcl_fp2_sqr_u1_4L               # -- Begin function mcl_fp2_sqr_u1_4L
	.p2align	4
	.type	mcl_fp2_sqr_u1_4L,@function
mcl_fp2_sqr_u1_4L:                      # @mcl_fp2_sqr_u1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	movq	%rdx, %rbx
	movq	%rsi, %rdx
	movq	%rdi, %r14
	movq	72(%rsi), %rsi
	movq	24(%rdx), %r15
	movq	64(%rdx), %r9
	movq	16(%rdx), %r12
	movq	56(%rdx), %rax
	movq	48(%rdx), %rdi
	movq	(%rdx), %r13
	movq	8(%rdx), %rbp
	movq	%r13, %rcx
	subq	%rdi, %rcx
	movq	%rbp, %r8
	sbbq	%rax, %r8
	movq	%r12, %r10
	sbbq	%r9, %r10
	movq	%r15, %r11
	sbbq	%rsi, %r11
	addq	(%rbx), %rcx
	adcq	8(%rbx), %r8
	adcq	16(%rbx), %r10
	adcq	24(%rbx), %r11
	addq	%rdi, %r13
	adcq	%rax, %rbp
	adcq	%r9, %r12
	movq	%r12, 56(%rsp)
	adcq	%rsi, %r15
	movq	%r15, 64(%rsp)
	movq	%r13, 40(%rsp)
	movq	%rbp, 48(%rsp)
	shldq	$1, %r9, %rsi
	shldq	$1, %rax, %r9
	movq	%r9, 88(%rsp)
	movq	%rsi, 96(%rsp)
	leaq	(%rdi,%rdi), %rsi
	movq	%rsi, 72(%rsp)
	shldq	$1, %rdi, %rax
	movq	%rax, 80(%rsp)
	movq	%r10, 24(%rsp)
	movq	%r11, 32(%rsp)
	movq	%rcx, 8(%rsp)
	movq	%r8, 16(%rsp)
	leaq	48(%r14), %rdi
	leaq	72(%rsp), %rsi
	movq	%rbx, %rcx
	callq	mcl_fp_montNF4L@PLT
	leaq	40(%rsp), %rsi
	leaq	8(%rsp), %rdx
	movq	%r14, %rdi
	movq	%rbx, %rcx
	callq	mcl_fp_montNF4L@PLT
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end74:
	.size	mcl_fp2_sqr_u1_4L, .Lfunc_end74-mcl_fp2_sqr_u1_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_mulPre_u1_4L         # -- Begin function mcl_fp2Dbl_mulPre_u1_4L
	.p2align	4
	.type	mcl_fp2Dbl_mulPre_u1_4L,@function
mcl_fp2Dbl_mulPre_u1_4L:                # @mcl_fp2Dbl_mulPre_u1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%r12), %rdx
	adcq	8(%r12), %rsi
	adcq	16(%r12), %rcx
	adcq	24(%r12), %rax
	movq	72(%r15), %rdi
	movq	64(%r15), %r8
	movq	48(%r15), %r9
	movq	56(%r15), %r10
	addq	(%r15), %r9
	adcq	8(%r15), %r10
	adcq	16(%r15), %r8
	adcq	24(%r15), %rdi
	movq	%r8, 120(%rsp)
	movq	%rdi, 128(%rsp)
	movq	%r9, 104(%rsp)
	movq	%r10, 112(%rsp)
	movq	%rcx, 152(%rsp)
	movq	%rax, 160(%rsp)
	movq	%rdx, 136(%rsp)
	movq	%rsi, 144(%rsp)
	leaq	96(%rbx), %rdi
	leaq	136(%rsp), %rsi
	leaq	104(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre4L
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre4L
	addq	$48, %r12
	addq	$48, %r15
	leaq	168(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre4L
	movq	32(%rbx), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	24(%rbx), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	16(%rbx), %rsi
	movq	%rsi, 72(%rsp)                  # 8-byte Spill
	movq	(%rbx), %r15
	movq	8(%rbx), %r9
	movq	%r9, 88(%rsp)                   # 8-byte Spill
	movq	192(%rsp), %r10
	movq	%r10, 64(%rsp)                  # 8-byte Spill
	movq	184(%rsp), %r11
	movq	%r11, 56(%rsp)                  # 8-byte Spill
	movq	168(%rsp), %rdi
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	movq	176(%rsp), %r14
	movq	%r14, 48(%rsp)                  # 8-byte Spill
	movq	%r15, %rdx
	addq	%rdi, %rdx
	movq	%r9, %rdi
	adcq	%r14, %rdi
	adcq	%r11, %rsi
	movq	%rax, %r14
	adcq	%r10, %r14
	movq	200(%rsp), %r8
	movq	%r8, 24(%rsp)                   # 8-byte Spill
	movq	%rcx, %rax
	adcq	%r8, %rax
	movq	40(%rbx), %r13
	movq	208(%rsp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	%r13, %r8
	adcq	%rcx, %r8
	movq	48(%rbx), %r12
	movq	216(%rsp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	%r12, %r9
	adcq	%rcx, %r9
	movq	56(%rbx), %r11
	movq	224(%rsp), %rbp
	movq	%r11, %r10
	adcq	%rbp, %r10
	subq	%rdx, 96(%rbx)
	sbbq	%rdi, 104(%rbx)
	sbbq	%rsi, 112(%rbx)
	sbbq	%r14, 120(%rbx)
	sbbq	%rax, 128(%rbx)
	sbbq	%r8, 136(%rbx)
	sbbq	%r9, 144(%rbx)
	sbbq	%r10, 152(%rbx)
	subq	40(%rsp), %r15                  # 8-byte Folded Reload
	movq	88(%rsp), %r10                  # 8-byte Reload
	sbbq	48(%rsp), %r10                  # 8-byte Folded Reload
	movq	72(%rsp), %rcx                  # 8-byte Reload
	sbbq	56(%rsp), %rcx                  # 8-byte Folded Reload
	movq	80(%rsp), %r14                  # 8-byte Reload
	sbbq	64(%rsp), %r14                  # 8-byte Folded Reload
	movq	32(%rsp), %r9                   # 8-byte Reload
	sbbq	24(%rsp), %r9                   # 8-byte Folded Reload
	sbbq	16(%rsp), %r13                  # 8-byte Folded Reload
	sbbq	8(%rsp), %r12                   # 8-byte Folded Reload
	sbbq	%rbp, %r11
	movq	%r11, %rax
	sarq	$63, %rax
	movq	96(%rsp), %r8                   # 8-byte Reload
	movq	24(%r8), %rdx
	andq	%rax, %rdx
	movq	16(%r8), %rsi
	andq	%rax, %rsi
	movq	8(%r8), %rdi
	andq	%rax, %rdi
	andq	(%r8), %rax
	movq	%rcx, 16(%rbx)
	movq	%r10, 8(%rbx)
	movq	%r15, (%rbx)
	movq	%r14, 24(%rbx)
	addq	%r9, %rax
	movq	%rax, 32(%rbx)
	adcq	%r13, %rdi
	movq	%rdi, 40(%rbx)
	adcq	%r12, %rsi
	movq	%rsi, 48(%rbx)
	adcq	%r11, %rdx
	movq	%rdx, 56(%rbx)
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end75:
	.size	mcl_fp2Dbl_mulPre_u1_4L, .Lfunc_end75-mcl_fp2Dbl_mulPre_u1_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_sqrPre_u1_4L         # -- Begin function mcl_fp2Dbl_sqrPre_u1_4L
	.p2align	4
	.type	mcl_fp2Dbl_sqrPre_u1_4L,@function
mcl_fp2Dbl_sqrPre_u1_4L:                # @mcl_fp2Dbl_sqrPre_u1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	%rdi, 64(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %rsi
	movq	24(%rdx), %r9
	movq	64(%rdx), %r8
	movq	16(%rdx), %rbp
	movq	56(%rdx), %rcx
	movq	48(%rdx), %rdi
	movq	(%rdx), %r10
	movq	8(%rdx), %r11
	movq	%r10, %rbx
	subq	%rdi, %rbx
	movq	%rbx, 56(%rsp)                  # 8-byte Spill
	movq	%r11, %rbx
	sbbq	%rcx, %rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	movq	%rbp, %rbx
	sbbq	%r8, %rbx
	movq	%rbx, 40(%rsp)                  # 8-byte Spill
	movq	%r9, %r14
	sbbq	%rsi, %r14
	movq	%r14, %r15
	sarq	$63, %r15
	movq	24(%rax), %rbx
	andq	%r15, %rbx
	movq	16(%rax), %r12
	andq	%r15, %r12
	movq	8(%rax), %r13
	andq	%r15, %r13
	andq	(%rax), %r15
	addq	%rdi, %r10
	adcq	%rcx, %r11
	adcq	%r8, %rbp
	movq	%rbp, 88(%rsp)
	adcq	%rsi, %r9
	movq	%r9, 96(%rsp)
	movq	%r10, 72(%rsp)
	movq	%r11, 80(%rsp)
	shldq	$1, %r8, %rsi
	shldq	$1, %rcx, %r8
	movq	%r8, 24(%rsp)
	movq	%rsi, 32(%rsp)
	leaq	(%rdi,%rdi), %rax
	movq	%rax, 8(%rsp)
	shldq	$1, %rdi, %rcx
	movq	%rcx, 16(%rsp)
	movq	64(%rsp), %rbp                  # 8-byte Reload
	leaq	96(%rbp), %rdi
	leaq	8(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre4L
	addq	56(%rsp), %r15                  # 8-byte Folded Reload
	adcq	48(%rsp), %r13                  # 8-byte Folded Reload
	adcq	40(%rsp), %r12                  # 8-byte Folded Reload
	movq	%r12, 24(%rsp)
	movq	%r13, 16(%rsp)
	movq	%r15, 8(%rsp)
	adcq	%r14, %rbx
	movq	%rbx, 32(%rsp)
	leaq	72(%rsp), %rdx
	movq	%rbp, %rdi
	leaq	8(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre4L
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end76:
	.size	mcl_fp2Dbl_sqrPre_u1_4L, .Lfunc_end76-mcl_fp2Dbl_sqrPre_u1_4L
                                        # -- End function
	.globl	mcl_fp2_mul_u5_4L               # -- Begin function mcl_fp2_mul_u5_4L
	.p2align	4
	.type	mcl_fp2_mul_u5_4L,@function
mcl_fp2_mul_u5_4L:                      # @mcl_fp2_mul_u5_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$360, %rsp                      # imm = 0x168
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, 160(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%rbp), %rdx
	adcq	8(%rbp), %rsi
	adcq	16(%rbp), %rcx
	adcq	24(%rbp), %rax
	movq	72(%r13), %rdi
	movq	64(%r13), %r8
	movq	48(%r13), %r9
	movq	56(%r13), %r10
	addq	(%r13), %r9
	adcq	8(%r13), %r10
	adcq	16(%r13), %r8
	adcq	24(%r13), %rdi
	movq	%r8, 248(%rsp)
	movq	%rdi, 256(%rsp)
	movq	%r9, 232(%rsp)
	movq	%r10, 240(%rsp)
	movq	%rcx, 280(%rsp)
	movq	%rax, 288(%rsp)
	movq	%rdx, 264(%rsp)
	movq	%rsi, 272(%rsp)
	leaq	168(%rsp), %rdi
	leaq	264(%rsp), %rsi
	leaq	232(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre4L
	leaq	40(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre4L
	addq	$48, %rbp
	addq	$48, %r13
	leaq	296(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre4L
	movl	$5, %eax
	movq	312(%rsp), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdi, %rcx
	movq	320(%rsp), %rdx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rdx, %r11
	addq	%rcx, %rdx
	movq	%rdx, %r8
	adcq	$0, %r11
	movq	296(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	304(%rsp), %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	mulxq	%rax, %rdx, %rcx
	movq	%rdx, 152(%rsp)                 # 8-byte Spill
	movq	%rsi, %rdx
	mulxq	%rax, %r9, %rdx
	addq	%rcx, %r9
	movq	%r9, 128(%rsp)                  # 8-byte Spill
	adcq	%rdi, %rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 144(%rsp)                  # 8-byte Spill
	setb	%r13b
	movq	%r11, %rcx
	adcq	$0, %rcx
	movq	344(%rsp), %rbp
	movq	%rbp, %rdx
	mulxq	%rax, %rsi, %rcx
	movq	328(%rsp), %r10
	movq	%r10, %rdx
	mulxq	%rax, %rdx, %r14
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	336(%rsp), %r9
	movq	%r9, %rdx
	mulxq	%rax, %r15, %rbx
	setb	%r12b
	addq	%r14, %r15
	adcq	%rsi, %rbx
	movq	352(%rsp), %r8
	leaq	(%r8,%r8,4), %rdi
	adcq	%rcx, %rdi
	addb	$255, %r13b
	movq	16(%rsp), %r14                  # 8-byte Reload
	adcq	%r11, %r14
	movzbl	%r12b, %eax
	adcq	%r15, %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	adcq	$0, %rbx
	adcq	$0, %rdi
	movq	40(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rsi                   # 8-byte Reload
	addq	%rax, %rsi
	movq	48(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	adcq	%rax, %rdx
	movq	56(%rsp), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	24(%rsp), %rcx                  # 8-byte Reload
	adcq	%rax, %rcx
	movq	64(%rsp), %r11
	movq	%r11, 112(%rsp)                 # 8-byte Spill
	movq	120(%rsp), %rax                 # 8-byte Reload
	adcq	%r11, %rax
	movq	72(%rsp), %r13
	adcq	%r13, %r10
	movq	80(%rsp), %r15
	adcq	%r15, %r9
	movq	88(%rsp), %r12
	adcq	%r12, %rbp
	movq	96(%rsp), %r11
	adcq	%r11, %r8
	subq	%rsi, 168(%rsp)
	sbbq	%rdx, 176(%rsp)
	sbbq	%rcx, 184(%rsp)
	sbbq	%rax, 192(%rsp)
	sbbq	%r10, 200(%rsp)
	sbbq	%r9, 208(%rsp)
	sbbq	%rbp, 216(%rsp)
	sbbq	%r8, 224(%rsp)
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	(%rax), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	%r14, %rbp
	movq	%r14, %rsi
	subq	%rcx, %rbp
	movq	8(%rax), %r8
	movq	104(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, %r14
	sbbq	%r8, %r14
	movq	16(%rax), %r9
	movq	%rbx, %rcx
	sbbq	%r9, %rcx
	movq	24(%rax), %r10
	movq	%rdi, %rax
	sbbq	%r10, %rax
	cmovsq	%rdi, %rax
	cmovsq	%rbx, %rcx
	cmovsq	%rdx, %r14
	cmovsq	%rsi, %rbp
	xorl	%esi, %esi
	negq	%rbp
	movl	$0, %edi
	sbbq	%r14, %rdi
	movl	$0, %r14d
	sbbq	%rcx, %r14
	sbbq	%rax, %rsi
	movq	16(%rsp), %rdx                  # 8-byte Reload
	subq	152(%rsp), %rdx                 # 8-byte Folded Reload
	movq	8(%rsp), %rcx                   # 8-byte Reload
	sbbq	128(%rsp), %rcx                 # 8-byte Folded Reload
	movq	(%rsp), %rbx                    # 8-byte Reload
	sbbq	136(%rsp), %rbx                 # 8-byte Folded Reload
	movq	112(%rsp), %rax                 # 8-byte Reload
	sbbq	144(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rbx, 56(%rsp)
	movq	%rdx, 40(%rsp)
	movq	%rcx, 48(%rsp)
	movq	%rax, 64(%rsp)
	sbbq	$0, %r13
	sbbq	$0, %r15
	sbbq	$0, %r12
	sbbq	$0, %r11
	addq	%rbp, %r13
	adcq	%rdi, %r15
	adcq	%r14, %r12
	adcq	%rsi, %r11
	movq	%r11, %rax
	sarq	$63, %rax
	andq	%rax, %r8
	andq	%rax, %r10
	andq	%rax, %r9
	andq	24(%rsp), %rax                  # 8-byte Folded Reload
	addq	%r13, %rax
	movq	%rax, 72(%rsp)
	adcq	%r15, %r8
	movq	%r8, 80(%rsp)
	adcq	%r12, %r9
	movq	%r9, 88(%rsp)
	adcq	%r11, %r10
	movq	%r10, 96(%rsp)
	movq	160(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	leaq	40(%rsp), %rsi
	movq	32(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rdx
	callq	mcl_fp_montRedNF4L@PLT
	addq	$48, %rbx
	movq	%rbx, %rdi
	leaq	168(%rsp), %rsi
	movq	%r14, %rdx
	callq	mcl_fp_montRedNF4L@PLT
	addq	$360, %rsp                      # imm = 0x168
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end77:
	.size	mcl_fp2_mul_u5_4L, .Lfunc_end77-mcl_fp2_mul_u5_4L
                                        # -- End function
	.globl	mcl_fp2_sqr_u5_4L               # -- Begin function mcl_fp2_sqr_u5_4L
	.p2align	4
	.type	mcl_fp2_sqr_u5_4L,@function
mcl_fp2_sqr_u5_4L:                      # @mcl_fp2_sqr_u5_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$200, %rsp
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	64(%rsi), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %r9
	movq	%r9, 32(%rsp)                   # 8-byte Spill
	shldq	$1, %rax, %r9
	movq	56(%rsi), %rdi
	movq	%rdi, 16(%rsp)                  # 8-byte Spill
	shldq	$1, %rdi, %rax
	movq	%rax, %r12
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	48(%rsi), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	shldq	$1, %r8, %rdi
	movq	%rdx, %rsi
	movq	%rdx, 96(%rsp)                  # 8-byte Spill
	movq	(%rdx), %r14
	movq	8(%rdx), %rbp
	leaq	(%r8,%r8), %r11
	movq	%r11, %r10
	movq	%r11, 64(%rsp)                  # 8-byte Spill
	subq	%r14, %r10
	movq	%rdi, %rdx
	movq	%rdi, %r8
	movq	%rdi, 72(%rsp)                  # 8-byte Spill
	sbbq	%rbp, %rdx
	movq	16(%rsi), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%r12, %rdi
	sbbq	%rax, %rdi
	movq	24(%rsi), %r13
	movq	%r9, %rcx
	movq	%r9, 80(%rsp)                   # 8-byte Spill
	sbbq	%r13, %r9
	cmovsq	%r12, %rdi
	cmovsq	%rcx, %r9
	cmovsq	%r8, %rdx
	cmovsq	%r11, %r10
	shldq	$1, %rdi, %r9
	shldq	$1, %rdx, %rdi
	shldq	$1, %r10, %rdx
	addq	%r10, %r10
	movq	%r10, %rsi
	subq	%r14, %rsi
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, %rcx
	sbbq	%rbp, %rcx
	movq	%rdi, %r8
	movq	(%rsp), %r11                    # 8-byte Reload
	sbbq	%r11, %r8
	movq	%r9, %rax
	sbbq	%r13, %rax
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	cmovsq	%r9, %rax
	cmovsq	%rdi, %r8
	cmovsq	%rdx, %rcx
	cmovsq	%r10, %rsi
	addq	8(%rsp), %rsi                   # 8-byte Folded Reload
	adcq	16(%rsp), %rcx                  # 8-byte Folded Reload
	movq	48(%rsp), %r12                  # 8-byte Reload
	adcq	%r12, %r8
	adcq	32(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rsi, %rdx
	subq	%r14, %rdx
	movq	%rcx, %rdi
	sbbq	%rbp, %rdi
	movq	%rbp, 56(%rsp)                  # 8-byte Spill
	movq	%r8, %r9
	sbbq	%r11, %r9
	movq	%rax, %r10
	sbbq	%r13, %r10
	cmovsq	%rax, %r10
	cmovsq	%r8, %r9
	cmovsq	%rcx, %rdi
	cmovsq	%rsi, %rdx
	movq	(%r15), %rax
	movq	%rax, %rcx
	subq	8(%rsp), %rcx                   # 8-byte Folded Reload
	movq	8(%r15), %rsi
	movq	%rsi, %r8
	sbbq	16(%rsp), %r8                   # 8-byte Folded Reload
	movq	16(%r15), %r11
	movq	%r11, %r14
	sbbq	%r12, %r14
	movq	24(%r15), %r13
	movq	%r13, %r12
	sbbq	32(%rsp), %r12                  # 8-byte Folded Reload
	addq	24(%rsp), %rcx                  # 8-byte Folded Reload
	adcq	%rbp, %r8
	adcq	(%rsp), %r14                    # 8-byte Folded Reload
	movq	40(%rsp), %rbp                  # 8-byte Reload
	adcq	%rbp, %r12
	addq	%rax, %rdx
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 184(%rsp)
	movq	80(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 192(%rsp)
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 168(%rsp)
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 176(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%r8, 112(%rsp)
	movq	%r14, 120(%rsp)
	movq	%r12, 128(%rsp)
	movq	%rdx, 136(%rsp)
	adcq	%rsi, %rdi
	movq	%rdi, 144(%rsp)
	adcq	%r11, %r9
	movq	%r9, 152(%rsp)
	adcq	%r13, %r10
	movq	%r10, 160(%rsp)
	leaq	48(%rbx), %rdi
	leaq	168(%rsp), %rsi
	movq	%r15, %rdx
	movq	96(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rcx
	callq	mcl_fp_montNF4L@PLT
	leaq	136(%rsp), %rsi
	leaq	104(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%r14, %rcx
	callq	mcl_fp_montNF4L@PLT
	movq	64(%rbx), %rax
	movq	72(%rbx), %rcx
	shldq	$1, %rax, %rcx
	movq	56(%rbx), %rdx
	shldq	$1, %rdx, %rax
	movq	48(%rbx), %rsi
	shldq	$1, %rsi, %rdx
	addq	%rsi, %rsi
	movq	%rsi, %rdi
	movq	24(%rsp), %r14                  # 8-byte Reload
	subq	%r14, %rdi
	movq	%rdx, %r8
	movq	56(%rsp), %r15                  # 8-byte Reload
	sbbq	%r15, %r8
	movq	%rax, %r9
	movq	(%rsp), %r12                    # 8-byte Reload
	sbbq	%r12, %r9
	movq	%rcx, %r10
	movq	%rbp, %r11
	sbbq	%rbp, %r10
	cmovsq	%rcx, %r10
	cmovsq	%rax, %r9
	cmovsq	%rdx, %r8
	cmovsq	%rsi, %rdi
	movq	24(%rbx), %rax
	movq	(%rbx), %rcx
	movq	8(%rbx), %rdx
	subq	%rdi, %rcx
	movq	16(%rbx), %rsi
	sbbq	%r8, %rdx
	sbbq	%r9, %rsi
	sbbq	%r10, %rax
	movq	%rax, %rdi
	sarq	$63, %rdi
	andq	%rdi, %r11
	movq	%r12, %r10
	andq	%rdi, %r10
	movq	%r15, %r8
	andq	%rdi, %r8
	andq	%r14, %rdi
	addq	%rcx, %rdi
	movq	%rdi, (%rbx)
	adcq	%rdx, %r8
	movq	%r8, 8(%rbx)
	movq	%r10, %rcx
	adcq	%rsi, %rcx
	movq	%rcx, 16(%rbx)
	movq	%r11, %rcx
	adcq	%rax, %rcx
	movq	%rcx, 24(%rbx)
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end78:
	.size	mcl_fp2_sqr_u5_4L, .Lfunc_end78-mcl_fp2_sqr_u5_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_mulPre_u5_4L         # -- Begin function mcl_fp2Dbl_mulPre_u5_4L
	.p2align	4
	.type	mcl_fp2Dbl_mulPre_u5_4L,@function
mcl_fp2Dbl_mulPre_u5_4L:                # @mcl_fp2Dbl_mulPre_u5_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%r12), %rdx
	adcq	8(%r12), %rsi
	adcq	16(%r12), %rcx
	adcq	24(%r12), %rax
	movq	72(%r15), %rdi
	movq	64(%r15), %r8
	movq	48(%r15), %r9
	movq	56(%r15), %r10
	addq	(%r15), %r9
	adcq	8(%r15), %r10
	adcq	16(%r15), %r8
	adcq	24(%r15), %rdi
	movq	%r8, 120(%rsp)
	movq	%rdi, 128(%rsp)
	movq	%r9, 104(%rsp)
	movq	%r10, 112(%rsp)
	movq	%rcx, 152(%rsp)
	movq	%rax, 160(%rsp)
	movq	%rdx, 136(%rsp)
	movq	%rsi, 144(%rsp)
	leaq	96(%rbx), %rdi
	leaq	136(%rsp), %rsi
	leaq	104(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre4L
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre4L
	addq	$48, %r12
	addq	$48, %r15
	leaq	168(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre4L
	movl	$5, %eax
	movq	184(%rsp), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rsi, %rcx
	movq	192(%rsp), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %r13
	addq	%rcx, %rdx
	movq	%rdx, %rdi
	adcq	$0, %r13
	movq	168(%rsp), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	176(%rsp), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	mulxq	%rax, %rdx, %rcx
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	%r8, %rdx
	mulxq	%rax, %r8, %rdx
	addq	%rcx, %r8
	movq	%r8, 64(%rsp)                   # 8-byte Spill
	adcq	%rsi, %rdx
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	adcq	$0, %rdi
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	setb	%r10b
	movq	%r13, %rcx
	adcq	$0, %rcx
	movq	216(%rsp), %r12
	movq	%r12, %rdx
	mulxq	%rax, %rcx, %r11
	movq	200(%rsp), %r15
	movq	%r15, %rdx
	mulxq	%rax, %rbp, %r14
	movq	208(%rsp), %r9
	movq	%r9, %rdx
	mulxq	%rax, %rdx, %rdi
	setb	%al
	addq	%r14, %rdx
	adcq	%rcx, %rdi
	movq	224(%rsp), %r8
	leaq	(%r8,%r8,4), %rsi
	adcq	%r11, %rsi
	addb	$255, %r10b
	adcq	%r13, %rbp
	movq	%rbp, 40(%rsp)                  # 8-byte Spill
	movzbl	%al, %r14d
	adcq	%rdx, %r14
	adcq	$0, %rdi
	adcq	$0, %rsi
	movq	(%rbx), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rdx                  # 8-byte Reload
	addq	%rax, %rdx
	movq	8(%rbx), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	%rax, %rcx
	movq	16(%rbx), %r10
	movq	%r10, 8(%rsp)                   # 8-byte Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	%r10, %rax
	movq	24(%rbx), %r11
	movq	%r11, 48(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r10                  # 8-byte Reload
	adcq	%r11, %r10
	movq	32(%rbx), %r13
	adcq	%r13, %r15
	movq	40(%rbx), %rbp
	adcq	%rbp, %r9
	movq	48(%rbx), %r11
	movq	%r11, 24(%rsp)                  # 8-byte Spill
	adcq	%r11, %r12
	movq	56(%rbx), %r11
	adcq	%r11, %r8
	subq	%rdx, 96(%rbx)
	sbbq	%rcx, 104(%rbx)
	sbbq	%rax, 112(%rbx)
	sbbq	%r10, 120(%rbx)
	sbbq	%r15, 128(%rbx)
	sbbq	%r9, 136(%rbx)
	sbbq	%r12, 144(%rbx)
	sbbq	%r8, 152(%rbx)
	movq	96(%rsp), %rax                  # 8-byte Reload
	movq	24(%rax), %r12
	movq	16(%rax), %r10
	movq	(%rax), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	8(%rax), %r8
	movq	40(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, %r15
	subq	%rcx, %r15
	movq	%r14, %r9
	sbbq	%r8, %r9
	movq	%rdi, %rcx
	sbbq	%r10, %rcx
	movq	%rsi, %rax
	sbbq	%r12, %rax
	cmovsq	%rsi, %rax
	cmovsq	%rdi, %rcx
	cmovsq	%r14, %r9
	cmovsq	%rdx, %r15
	xorl	%r14d, %r14d
	negq	%r15
	movl	$0, %edi
	sbbq	%r9, %rdi
	movl	$0, %r9d
	sbbq	%rcx, %r9
	sbbq	%rax, %r14
	movq	56(%rsp), %rsi                  # 8-byte Reload
	subq	88(%rsp), %rsi                  # 8-byte Folded Reload
	movq	16(%rsp), %rdx                  # 8-byte Reload
	sbbq	64(%rsp), %rdx                  # 8-byte Folded Reload
	movq	8(%rsp), %rax                   # 8-byte Reload
	sbbq	72(%rsp), %rax                  # 8-byte Folded Reload
	movq	48(%rsp), %rcx                  # 8-byte Reload
	sbbq	80(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rax, 16(%rbx)
	movq	%rdx, 8(%rbx)
	movq	%rsi, (%rbx)
	movq	%rcx, 24(%rbx)
	sbbq	$0, %r13
	sbbq	$0, %rbp
	movq	24(%rsp), %rax                  # 8-byte Reload
	sbbq	$0, %rax
	sbbq	$0, %r11
	addq	%r15, %r13
	adcq	%rdi, %rbp
	adcq	%r9, %rax
	movq	%rax, %rcx
	adcq	%r14, %r11
	movq	%r11, %rax
	sarq	$63, %rax
	andq	%rax, %r12
	andq	%rax, %r10
	andq	%rax, %r8
	andq	32(%rsp), %rax                  # 8-byte Folded Reload
	addq	%r13, %rax
	movq	%rax, 32(%rbx)
	adcq	%rbp, %r8
	movq	%r8, 40(%rbx)
	adcq	%rcx, %r10
	movq	%r10, 48(%rbx)
	adcq	%r11, %r12
	movq	%r12, 56(%rbx)
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end79:
	.size	mcl_fp2Dbl_mulPre_u5_4L, .Lfunc_end79-mcl_fp2Dbl_mulPre_u5_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_sqrPre_u5_4L         # -- Begin function mcl_fp2Dbl_sqrPre_u5_4L
	.p2align	4
	.type	mcl_fp2Dbl_sqrPre_u5_4L,@function
mcl_fp2Dbl_sqrPre_u5_4L:                # @mcl_fp2Dbl_sqrPre_u5_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$168, %rsp
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	56(%rsi), %r14
	movq	64(%rsi), %rcx
	movq	%rcx, %rbp
	movq	%rcx, %rdi
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	shldq	$1, %r14, %rbp
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rcx
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	movq	24(%rax), %r13
	movq	%r13, 40(%rsp)                  # 8-byte Spill
	movq	16(%rax), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movq	(%rax), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rax), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %r15
	movq	%r15, 64(%rsp)                  # 8-byte Spill
	movq	%rbp, 104(%rsp)
	shldq	$1, %rdi, %r15
	movq	%r15, 112(%rsp)
	leaq	(%rax,%rax), %r12
	movq	%r12, 88(%rsp)
	shldq	$1, %rax, %r14
	movq	%r14, 96(%rsp)
	movq	16(%rsi), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	leaq	96(%rbx), %rdi
	leaq	88(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre4L
	movq	%r12, %rax
	movq	16(%rsp), %r11                  # 8-byte Reload
	subq	%r11, %rax
	movq	%r14, %rcx
	movq	8(%rsp), %r9                    # 8-byte Reload
	sbbq	%r9, %rcx
	movq	%rbp, %rdx
	movq	48(%rsp), %r10                  # 8-byte Reload
	sbbq	%r10, %rdx
	movq	%r15, %rsi
	sbbq	%r13, %rsi
	cmovsq	%r14, %rcx
	cmovsq	%rbp, %rdx
	cmovsq	%r15, %rsi
	cmovsq	%r12, %rax
	shldq	$1, %rdx, %rsi
	shldq	$1, %rcx, %rdx
	shldq	$1, %rax, %rcx
	addq	%rax, %rax
	movq	%rax, %rdi
	subq	%r11, %rdi
	movq	%rcx, %r8
	movq	%r9, %r13
	sbbq	%r9, %r8
	movq	%rdx, %r9
	movq	%r10, %r14
	sbbq	%r10, %r9
	movq	%rsi, %r10
	movq	40(%rsp), %r15                  # 8-byte Reload
	sbbq	%r15, %r10
	cmovsq	%rsi, %r10
	cmovsq	%rdx, %r9
	cmovsq	%rcx, %r8
	cmovsq	%rax, %rdi
	addq	24(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	32(%rsp), %r8                   # 8-byte Folded Reload
	adcq	56(%rsp), %r9                   # 8-byte Folded Reload
	adcq	64(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rdi, %rsi
	subq	%r11, %rsi
	movq	%r8, %rdx
	sbbq	%r13, %rdx
	movq	%r9, %rcx
	sbbq	%r14, %rcx
	movq	%r14, %r12
	movq	%r10, %rax
	sbbq	%r15, %rax
	cmovsq	%r10, %rax
	cmovsq	%r9, %rcx
	cmovsq	%r8, %rdx
	cmovsq	%rdi, %rsi
	movq	120(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %rdi
	subq	24(%rsp), %rdi                  # 8-byte Folded Reload
	movq	72(%rsp), %r8                   # 8-byte Reload
	sbbq	32(%rsp), %r8                   # 8-byte Folded Reload
	movq	128(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %r9
	sbbq	56(%rsp), %r9                   # 8-byte Folded Reload
	movq	80(%rsp), %r10                  # 8-byte Reload
	sbbq	64(%rsp), %r10                  # 8-byte Folded Reload
	movq	%r10, %r11
	sarq	$63, %r11
	movq	%r11, %r14
	andq	%r15, %r14
	movq	%r11, %r15
	andq	%r12, %r15
	movq	%r11, %r12
	andq	8(%rsp), %r12                   # 8-byte Folded Reload
	andq	16(%rsp), %r11                  # 8-byte Folded Reload
	addq	%rdi, %r11
	adcq	%r8, %r12
	adcq	%r9, %r15
	adcq	%r10, %r14
	addq	%r13, %rsi
	movq	%r11, 136(%rsp)
	movq	%r12, 144(%rsp)
	movq	%r15, 152(%rsp)
	movq	%r14, 160(%rsp)
	movq	%rsi, 88(%rsp)
	adcq	72(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, 96(%rsp)
	adcq	%rbp, %rcx
	movq	%rcx, 104(%rsp)
	adcq	80(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 112(%rsp)
	leaq	136(%rsp), %rdx
	movq	%rbx, %rdi
	leaq	88(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre4L
	movq	144(%rbx), %rcx
	movq	152(%rbx), %rax
	shldq	$1, %rcx, %rax
	movq	136(%rbx), %rdx
	shldq	$1, %rdx, %rcx
	movq	128(%rbx), %rsi
	shldq	$1, %rsi, %rdx
	movq	120(%rbx), %rdi
	shldq	$1, %rdi, %rsi
	movq	112(%rbx), %r8
	shldq	$1, %r8, %rdi
	movq	104(%rbx), %r9
	shldq	$1, %r9, %r8
	movq	96(%rbx), %r10
	shldq	$1, %r10, %r9
	addq	%r10, %r10
	xorl	%r11d, %r11d
	subq	%r10, (%rbx)
	sbbq	%r9, 8(%rbx)
	sbbq	%r8, 16(%rbx)
	sbbq	%rdi, 24(%rbx)
	movq	32(%rbx), %rdi
	movq	40(%rbx), %r8
	sbbq	%rsi, %rdi
	movq	56(%rbx), %rsi
	sbbq	%rdx, %r8
	movq	48(%rbx), %rdx
	sbbq	%rcx, %rdx
	sbbq	%rax, %rsi
	sbbq	%r11, %r11
	movq	40(%rsp), %r9                   # 8-byte Reload
	andq	%r11, %r9
	movq	48(%rsp), %rax                  # 8-byte Reload
	andq	%r11, %rax
	movq	8(%rsp), %rcx                   # 8-byte Reload
	andq	%r11, %rcx
	andq	16(%rsp), %r11                  # 8-byte Folded Reload
	addq	%rdi, %r11
	movq	%r11, 32(%rbx)
	adcq	%r8, %rcx
	movq	%rcx, 40(%rbx)
	adcq	%rdx, %rax
	movq	%rax, 48(%rbx)
	movq	%r9, %rax
	adcq	%rsi, %rax
	movq	%rax, 56(%rbx)
	addq	$168, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end80:
	.size	mcl_fp2Dbl_sqrPre_u5_4L, .Lfunc_end80-mcl_fp2Dbl_sqrPre_u5_4L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u1x1_4L          # -- Begin function mcl_fp2_mul_xi_u1x1_4L
	.p2align	4
	.type	mcl_fp2_mul_xi_u1x1_4L,@function
mcl_fp2_mul_xi_u1x1_4L:                 # @mcl_fp2_mul_xi_u1x1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	24(%rdx), %r10
	movq	16(%rdx), %r9
	movq	(%rdx), %r14
	movq	%r14, -8(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %r8
	movq	24(%rsi), %rdx
	movq	72(%rsi), %r15
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %r12
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rbx
	movq	8(%rsi), %r11
	movq	48(%rsi), %rsi
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	addq	%rbx, %rsi
	adcq	%r11, %r12
	adcq	%rax, %rcx
	movq	%r15, %rax
	adcq	%rdx, %rax
	movq	%rsi, %r13
	subq	%r14, %r13
	movq	%r12, %rbp
	sbbq	%r8, %rbp
	movq	%rcx, %r15
	sbbq	%r9, %r15
	movq	%rax, %r14
	sbbq	%r10, %r14
	cmovsq	%r12, %rbp
	cmovsq	%rax, %r14
	cmovsq	%rcx, %r15
	cmovsq	%rsi, %r13
	subq	-48(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r15, 64(%rdi)
	movq	%r14, 72(%rdi)
	movq	%r13, 48(%rdi)
	movq	%rbp, 56(%rdi)
	sbbq	-32(%rsp), %r11                 # 8-byte Folded Reload
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	sbbq	-24(%rsp), %rcx                 # 8-byte Folded Reload
	sbbq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, %rax
	sarq	$63, %rax
	andq	%rax, %r10
	andq	%rax, %r9
	andq	%rax, %r8
	andq	-8(%rsp), %rax                  # 8-byte Folded Reload
	addq	%rbx, %rax
	movq	%rax, (%rdi)
	adcq	%r11, %r8
	movq	%r8, 8(%rdi)
	adcq	%rcx, %r9
	movq	%r9, 16(%rdi)
	adcq	%rdx, %r10
	movq	%r10, 24(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end81:
	.size	mcl_fp2_mul_xi_u1x1_4L, .Lfunc_end81-mcl_fp2_mul_xi_u1x1_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u1x1_4L       # -- Begin function mcl_fp2Dbl_mul_xi_u1x1_4L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u1x1_4L,@function
mcl_fp2Dbl_mul_xi_u1x1_4L:              # @mcl_fp2Dbl_mul_xi_u1x1_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, %r9
	movq	152(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	144(%rsi), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	136(%rsi), %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	40(%rsi), %rbp
	movq	%rbp, 24(%rsp)                  # 8-byte Spill
	movq	128(%rsi), %r11
	movq	%r11, -32(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %r10
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	movq	120(%rsi), %rbx
	movq	%rbx, -56(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %r8
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	movq	112(%rsi), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %r14
	movq	%r14, -64(%rsp)                 # 8-byte Spill
	movq	104(%rsi), %r13
	movq	96(%rsi), %r12
	movq	(%rsi), %r15
	movq	%r15, -88(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	xorl	%esi, %esi
	subq	%r12, %r15
	movq	%r15, -48(%rsp)                 # 8-byte Spill
	sbbq	%r13, %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movq	%r14, %r15
	sbbq	%rdx, %r15
	movq	%r15, (%rsp)                    # 8-byte Spill
	movq	%r8, %r14
	sbbq	%rbx, %r14
	movq	%r14, 8(%rsp)                   # 8-byte Spill
	movq	%r10, %r14
	sbbq	%r11, %r14
	sbbq	-128(%rsp), %rbp                # 8-byte Folded Reload
	movq	-120(%rsp), %r10                # 8-byte Reload
	sbbq	-112(%rsp), %r10                # 8-byte Folded Reload
	movq	-104(%rsp), %r11                # 8-byte Reload
	sbbq	-96(%rsp), %r11                 # 8-byte Folded Reload
	sbbq	%rsi, %rsi
	movq	(%r9), %r15
	movq	8(%r9), %r8
	movq	%r8, -16(%rsp)                  # 8-byte Spill
	movq	16(%r9), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	24(%r9), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%rsi, %r9
	andq	%rax, %r9
	movq	%rsi, %rcx
	andq	%rdx, %rcx
	movq	%rsi, %rax
	andq	%r8, %rax
	andq	%r15, %rsi
	addq	%r14, %rsi
	adcq	%rbp, %rax
	adcq	%r10, %rcx
	adcq	%r11, %r9
	addq	-88(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-80(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r12, 96(%rdi)
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, (%rdi)
	movq	-72(%rsp), %r8                  # 8-byte Reload
	adcq	-64(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r13, 104(%rdi)
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 8(%rdi)
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	adcq	-40(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r8, 112(%rdi)
	movq	(%rsp), %r8                     # 8-byte Reload
	movq	%r8, 16(%rdi)
	movq	-32(%rsp), %r8                  # 8-byte Reload
	adcq	-8(%rsp), %r8                   # 8-byte Folded Reload
	movq	%rdx, 120(%rdi)
	movq	8(%rsp), %rdx                   # 8-byte Reload
	movq	%rdx, 24(%rdi)
	movq	%rsi, 32(%rdi)
	movq	%rax, 40(%rdi)
	movq	%rcx, 48(%rdi)
	movq	%r9, 56(%rdi)
	movq	-128(%rsp), %rsi                # 8-byte Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	movq	-112(%rsp), %rbx                # 8-byte Reload
	adcq	-120(%rsp), %rbx                # 8-byte Folded Reload
	movq	-96(%rsp), %r10                 # 8-byte Reload
	adcq	-104(%rsp), %r10                # 8-byte Folded Reload
	setb	%al
	movq	%r8, %rcx
	movq	%r8, %r11
	subq	%r15, %rcx
	movq	%rsi, %rdx
	movq	%rsi, %r9
	sbbq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rbx, %rsi
	sbbq	16(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%r10, %r8
	sbbq	32(%rsp), %r8                   # 8-byte Folded Reload
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rbx, %rsi
	movq	%rsi, 144(%rdi)
	cmovneq	%r10, %r8
	movq	%r8, 152(%rdi)
	cmovneq	%r11, %rcx
	movq	%rcx, 128(%rdi)
	cmovneq	%r9, %rdx
	movq	%rdx, 136(%rdi)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end82:
	.size	mcl_fp2Dbl_mul_xi_u1x1_4L, .Lfunc_end82-mcl_fp2Dbl_mul_xi_u1x1_4L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u1x9_4L          # -- Begin function mcl_fp2_mul_xi_u1x9_4L
	.p2align	4
	.type	mcl_fp2_mul_xi_u1x9_4L,@function
mcl_fp2_mul_xi_u1x9_4L:                 # @mcl_fp2_mul_xi_u1x9_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	64(%rsi), %rdi
	movq	72(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	%rdi, -104(%rsp)                # 8-byte Spill
	shldq	$1, %rdi, %rax
	movq	56(%rsi), %r13
	shldq	$1, %r13, %rdi
	movq	48(%rsi), %r9
	movq	%r13, %rbx
	movq	%r13, -16(%rsp)                 # 8-byte Spill
	shldq	$1, %r9, %rbx
	movq	24(%rdx), %r11
	movq	16(%rdx), %r14
	movq	(%rdx), %rbp
	movq	8(%rdx), %r12
	leaq	(%r9,%r9), %rdx
	movq	%r9, -24(%rsp)                  # 8-byte Spill
	movq	%rdx, %r10
	subq	%rbp, %r10
	movq	%rbx, %rcx
	sbbq	%r12, %rcx
	movq	%rdi, %r8
	sbbq	%r14, %r8
	movq	%rax, %r15
	sbbq	%r11, %r15
	cmovsq	%rbx, %rcx
	cmovsq	%rdi, %r8
	cmovsq	%rax, %r15
	cmovsq	%rdx, %r10
	shldq	$1, %r8, %r15
	shldq	$1, %rcx, %r8
	shldq	$1, %r10, %rcx
	addq	%r10, %r10
	movq	%r10, %rax
	subq	%rbp, %rax
	movq	%rcx, %rbx
	sbbq	%r12, %rbx
	movq	%r8, %rdx
	sbbq	%r14, %rdx
	movq	%r15, %rdi
	sbbq	%r11, %rdi
	cmovsq	%r15, %rdi
	cmovsq	%r10, %rax
	cmovsq	%rcx, %rbx
	cmovsq	%r8, %rdx
	shldq	$1, %rdx, %rdi
	shldq	$1, %rbx, %rdx
	shldq	$1, %rax, %rbx
	addq	%rax, %rax
	movq	%rax, %r8
	movq	%rbp, %rcx
	movq	%rbp, -88(%rsp)                 # 8-byte Spill
	subq	%rbp, %r8
	movq	%rbx, %r10
	sbbq	%r12, %r10
	movq	%rdx, %r15
	sbbq	%r14, %r15
	movq	%rdi, %rbp
	sbbq	%r11, %rbp
	cmovsq	%rdi, %rbp
	cmovsq	%rdx, %r15
	cmovsq	%rbx, %r10
	cmovsq	%rax, %r8
	addq	%r9, %r8
	adcq	%r13, %r10
	adcq	-104(%rsp), %r15                # 8-byte Folded Reload
	adcq	-96(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r8, %r13
	subq	%rcx, %r13
	movq	%r10, %rcx
	sbbq	%r12, %rcx
	movq	%r15, %rdi
	sbbq	%r14, %rdi
	movq	%rbp, %rax
	sbbq	%r11, %rax
	cmovsq	%rbp, %rax
	cmovsq	%r15, %rdi
	cmovsq	%r10, %rcx
	cmovsq	%r8, %r13
	movq	24(%rsi), %r9
	movq	16(%rsi), %rbx
	movq	(%rsi), %r8
	movq	%r8, -80(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %r15
	addq	%r8, %r13
	adcq	%r15, %rcx
	adcq	%rbx, %rdi
	adcq	%r9, %rax
	movq	%r9, -40(%rsp)                  # 8-byte Spill
	movq	%r13, %r8
	movq	-88(%rsp), %r10                 # 8-byte Reload
	subq	%r10, %r8
	movq	%rcx, %rsi
	sbbq	%r12, %rsi
	movq	%rdi, %rbp
	sbbq	%r14, %rbp
	movq	%rax, %rdx
	sbbq	%r11, %rdx
	cmovsq	%rax, %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	cmovsq	%rcx, %rsi
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	cmovsq	%r13, %r8
	movq	%r8, -48(%rsp)                  # 8-byte Spill
	cmovsq	%rdi, %rbp
	movq	%r9, %rax
	movq	%rbx, -56(%rsp)                 # 8-byte Spill
	shldq	$1, %rbx, %rax
	movq	%r15, -64(%rsp)                 # 8-byte Spill
	shldq	$1, %r15, %rbx
	movq	%r15, %rdi
	movq	-80(%rsp), %r9                  # 8-byte Reload
	shldq	$1, %r9, %rdi
	leaq	(%r9,%r9), %r8
	movq	%r8, %r13
	subq	%r10, %r13
	movq	%r10, %r15
	movq	%rdi, %rdx
	sbbq	%r12, %rdx
	movq	%rbx, %r10
	sbbq	%r14, %r10
	movq	%rax, %rcx
	sbbq	%r11, %rcx
	cmovsq	%rbx, %r10
	cmovsq	%rax, %rcx
	cmovsq	%r8, %r13
	cmovsq	%rdi, %rdx
	shldq	$1, %r10, %rcx
	shldq	$1, %rdx, %r10
	shldq	$1, %r13, %rdx
	addq	%r13, %r13
	movq	%r13, %rdi
	subq	%r15, %rdi
	movq	%rdx, %rsi
	sbbq	%r12, %rsi
	movq	%r10, %rax
	sbbq	%r14, %rax
	movq	%rcx, %r8
	sbbq	%r11, %r8
	cmovsq	%rcx, %r8
	cmovsq	%r13, %rdi
	cmovsq	%rdx, %rsi
	cmovsq	%r10, %rax
	shldq	$1, %rax, %r8
	shldq	$1, %rsi, %rax
	shldq	$1, %rdi, %rsi
	addq	%rdi, %rdi
	movq	%rdi, %r13
	subq	%r15, %r13
	movq	%rsi, %r10
	sbbq	%r12, %r10
	movq	%rax, %rdx
	sbbq	%r14, %rdx
	movq	%r8, %rcx
	sbbq	%r11, %rcx
	cmovsq	%r8, %rcx
	cmovsq	%rax, %rdx
	cmovsq	%rsi, %r10
	cmovsq	%rdi, %r13
	addq	%r9, %r13
	adcq	-64(%rsp), %r10                 # 8-byte Folded Reload
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rbp, 64(%rdi)
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 72(%rdi)
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 48(%rdi)
	movq	-32(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 56(%rdi)
	adcq	-56(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r13, %rbx
	subq	%r15, %rbx
	movq	%r10, %rax
	sbbq	%r12, %rax
	movq	%rdx, %r8
	sbbq	%r14, %r8
	movq	%rcx, %rsi
	sbbq	%r11, %rsi
	cmovsq	%rcx, %rsi
	cmovsq	%rdx, %r8
	cmovsq	%r10, %rax
	cmovsq	%r13, %rbx
	subq	-24(%rsp), %rbx                 # 8-byte Folded Reload
	sbbq	-16(%rsp), %rax                 # 8-byte Folded Reload
	sbbq	-104(%rsp), %r8                 # 8-byte Folded Reload
	sbbq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, %rcx
	sarq	$63, %rcx
	andq	%rcx, %r11
	andq	%rcx, %r14
	andq	%rcx, %r12
	andq	%r15, %rcx
	addq	%rbx, %rcx
	movq	%rcx, (%rdi)
	adcq	%rax, %r12
	movq	%r12, 8(%rdi)
	adcq	%r8, %r14
	movq	%r14, 16(%rdi)
	adcq	%rsi, %r11
	movq	%r11, 24(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end83:
	.size	mcl_fp2_mul_xi_u1x9_4L, .Lfunc_end83-mcl_fp2_mul_xi_u1x9_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u1x9_4L       # -- Begin function mcl_fp2Dbl_mul_xi_u1x9_4L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u1x9_4L,@function
mcl_fp2Dbl_mul_xi_u1x9_4L:              # @mcl_fp2Dbl_mul_xi_u1x9_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	movq	%rsi, %r8
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movq	48(%rsi), %rdi
	movq	56(%rsi), %rax
	movq	%rax, %rsi
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rdi, -40(%rsp)                 # 8-byte Spill
	shldq	$1, %rdi, %rsi
	movq	40(%r8), %r9
	movq	%r9, -48(%rsp)                  # 8-byte Spill
	shldq	$1, %r9, %rdi
	movq	32(%r8), %r11
	movq	%r11, -56(%rsp)                 # 8-byte Spill
	shldq	$1, %r11, %r9
	movq	24(%rdx), %r14
	movq	16(%rdx), %rbp
	movq	(%rdx), %r15
	movq	8(%rdx), %r12
	movq	24(%r8), %r13
	shldq	$1, %r13, %r11
	movq	%rax, %rbx
	shrq	$63, %rbx
	movq	%r11, %rax
	subq	%r15, %rax
	movq	%r9, %rcx
	sbbq	%r12, %rcx
	movq	%rdi, %rdx
	sbbq	%rbp, %rdx
	movq	%rsi, %r10
	sbbq	%r14, %r10
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%rsi, %r10
	cmovneq	%rdi, %rdx
	cmovneq	%r9, %rcx
	cmovneq	%r11, %rax
	leaq	(%r13,%r13), %r11
	shrdq	$63, %rax, %r11
	shrdq	$63, %rcx, %rax
	shrdq	$63, %rdx, %rcx
	shrdq	$63, %r10, %rdx
	shrq	$63, %r10
	movq	%r11, %rsi
	subq	%r15, %rsi
	movq	%r15, -128(%rsp)                # 8-byte Spill
	movq	%rax, %rdi
	movq	%r12, -120(%rsp)                # 8-byte Spill
	sbbq	%r12, %rdi
	movq	%rcx, %r9
	sbbq	%rbp, %r9
	movq	%rdx, %rbx
	sbbq	%r14, %rbx
	movq	%r14, -104(%rsp)                # 8-byte Spill
	sbbq	$0, %r10
	testb	$1, %r10b
	cmovneq	%rdx, %rbx
	cmovneq	%rcx, %r9
	cmovneq	%rax, %rdi
	cmovneq	%r11, %rsi
	leaq	(,%r13,4), %rax
	shrdq	$63, %rsi, %rax
	shrdq	$63, %rdi, %rsi
	shrdq	$63, %r9, %rdi
	shrdq	$63, %rbx, %r9
	shrq	$63, %rbx
	movq	%rax, %r10
	subq	%r15, %r10
	movq	%rsi, %rcx
	sbbq	%r12, %rcx
	movq	%rdi, %rdx
	sbbq	%rbp, %rdx
	movq	%r9, %r11
	sbbq	%r14, %r11
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%r9, %r11
	cmovneq	%rdi, %rdx
	cmovneq	%rsi, %rcx
	cmovneq	%rax, %r10
	movq	16(%r8), %rdi
	movq	%r13, 88(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	shldq	$3, %rdi, %rax
	movq	8(%r8), %rbx
	movq	%rbx, 72(%rsp)                  # 8-byte Spill
	movq	%rdi, %rsi
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	shldq	$3, %rbx, %rsi
	movq	(%r8), %r15
	movq	%r15, 64(%rsp)                  # 8-byte Spill
	movq	%rbx, %r9
	shldq	$3, %r15, %r9
	leaq	(,%r15,8), %r12
	addq	%r15, %r12
	adcq	%rbx, %r9
	movq	%r9, -80(%rsp)                  # 8-byte Spill
	adcq	%rdi, %rsi
	movq	%rsi, %r14
	adcq	%r13, %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	adcq	-56(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-48(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-40(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r11                 # 8-byte Folded Reload
	setb	%bl
	movq	%r10, %r9
	subq	-128(%rsp), %r9                 # 8-byte Folded Reload
	movq	%rcx, %rdi
	sbbq	-120(%rsp), %rdi                # 8-byte Folded Reload
	movq	%rdx, %rsi
	movq	%rbp, -112(%rsp)                # 8-byte Spill
	sbbq	%rbp, %rsi
	movq	%r11, %rax
	movq	-104(%rsp), %rbp                # 8-byte Reload
	sbbq	%rbp, %rax
	movzbl	%bl, %ebx
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%r11, %rax
	cmovneq	%rdx, %rsi
	cmovneq	%rcx, %rdi
	cmovneq	%r10, %r9
	movq	152(%r8), %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	144(%r8), %rbx
	movq	136(%r8), %r15
	movq	128(%r8), %r13
	movq	%r13, -96(%rsp)                 # 8-byte Spill
	movq	120(%r8), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	112(%r8), %r11
	movq	%r11, -8(%rsp)                  # 8-byte Spill
	movq	104(%r8), %r10
	movq	%r10, (%rsp)                    # 8-byte Spill
	movq	96(%r8), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	xorl	%ecx, %ecx
	subq	%r8, %r12
	movq	%r12, 48(%rsp)                  # 8-byte Spill
	sbbq	%r10, -80(%rsp)                 # 8-byte Folded Spill
	sbbq	%r11, %r14
	movq	%r14, 56(%rsp)                  # 8-byte Spill
	sbbq	%rdx, -72(%rsp)                 # 8-byte Folded Spill
	sbbq	%r13, %r9
	sbbq	%r15, %rdi
	movq	%r15, %r13
	movq	%rbx, %r15
	sbbq	%rbx, %rsi
	movq	-88(%rsp), %rbx                 # 8-byte Reload
	sbbq	%rbx, %rax
	sbbq	%rcx, %rcx
	movq	%rcx, %rdx
	movq	%rbp, %r12
	andq	%rbp, %rdx
	movq	%rdx, %r14
	movq	%rcx, %rdx
	movq	-112(%rsp), %rbp                # 8-byte Reload
	andq	%rbp, %rdx
	movq	%rdx, %r8
	movq	%rcx, %r11
	movq	-120(%rsp), %r10                # 8-byte Reload
	andq	%r10, %r11
	movq	-128(%rsp), %rdx                # 8-byte Reload
	andq	%rdx, %rcx
	addq	%r9, %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	adcq	%rdi, %r11
	movq	%r11, 32(%rsp)                  # 8-byte Spill
	adcq	%rsi, %r8
	movq	%r8, 16(%rsp)                   # 8-byte Spill
	adcq	%rax, %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	movq	%rbx, %rcx
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	shldq	$1, %r15, %rcx
	movq	%r15, %rdi
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	shldq	$1, %r13, %rdi
	movq	%r13, %r9
	movq	-96(%rsp), %r11                 # 8-byte Reload
	shldq	$1, %r11, %r9
	movq	-32(%rsp), %r15                 # 8-byte Reload
	shldq	$1, %r15, %r11
	movq	%rbx, %r14
	shrq	$63, %r14
	movq	%r11, %rax
	subq	%rdx, %rax
	movq	%rdx, %rbx
	movq	%r9, %rdx
	sbbq	%r10, %rdx
	movq	%r10, %r8
	movq	%rdi, %rsi
	sbbq	%rbp, %rsi
	movq	%rbp, %r13
	movq	%rcx, %r10
	movq	%r12, %rbp
	sbbq	%r12, %r10
	sbbq	$0, %r14
	testb	$1, %r14b
	cmovneq	%rcx, %r10
	cmovneq	%rdi, %rsi
	cmovneq	%r9, %rdx
	cmovneq	%r11, %rax
	movq	%r15, %r12
	leaq	(%r15,%r15), %r14
	shrdq	$63, %rax, %r14
	shrdq	$63, %rdx, %rax
	shrdq	$63, %rsi, %rdx
	shrdq	$63, %r10, %rsi
	shrq	$63, %r10
	movq	%r14, %rcx
	subq	%rbx, %rcx
	movq	%rax, %rdi
	sbbq	%r8, %rdi
	movq	%r8, %r15
	movq	%rdx, %r9
	sbbq	%r13, %r9
	movq	%r13, %r8
	movq	%rsi, %r11
	sbbq	%rbp, %r11
	sbbq	$0, %r10
	testb	$1, %r10b
	cmovneq	%rsi, %r11
	cmovneq	%rdx, %r9
	cmovneq	%rax, %rdi
	cmovneq	%r14, %rcx
	movq	%r12, %r13
	leaq	(,%r12,4), %r14
	shrdq	$63, %rcx, %r14
	shrdq	$63, %rdi, %rcx
	shrdq	$63, %r9, %rdi
	shrdq	$63, %r11, %r9
	shrq	$63, %r11
	movq	%r14, %rdx
	movq	%rbx, %r12
	subq	%rbx, %rdx
	movq	%rcx, %rax
	sbbq	%r15, %rax
	movq	%rdi, %rsi
	sbbq	%r8, %rsi
	movq	%r9, %r10
	sbbq	%rbp, %r10
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%r9, %r10
	cmovneq	%rdi, %rsi
	cmovneq	%rcx, %rax
	cmovneq	%r14, %rdx
	movq	%r13, %rcx
	movq	%r13, %rbx
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	shldq	$3, %rdi, %rcx
	movq	%rdi, %r9
	movq	(%rsp), %r8                     # 8-byte Reload
	shldq	$3, %r8, %r9
	movq	%r8, %r14
	movq	8(%rsp), %r13                   # 8-byte Reload
	shldq	$3, %r13, %r14
	leaq	(,%r13,8), %r11
	addq	%r13, %r11
	adcq	%r8, %r14
	adcq	%rdi, %r9
	adcq	%rbx, %rcx
	adcq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	adcq	-24(%rsp), %rax                 # 8-byte Folded Reload
	adcq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-88(%rsp), %r10                 # 8-byte Folded Reload
	setb	%bpl
	movq	%rdx, %r8
	subq	%r12, %r8
	movq	%rax, %rdi
	sbbq	%r15, %rdi
	movq	%rsi, %r13
	movq	-112(%rsp), %r12                # 8-byte Reload
	sbbq	%r12, %r13
	movq	%r10, %rbx
	movq	-104(%rsp), %r15                # 8-byte Reload
	sbbq	%r15, %rbx
	movzbl	%bpl, %ebp
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%r10, %rbx
	cmovneq	%rsi, %r13
	cmovneq	%rax, %rdi
	cmovneq	%rdx, %r8
	addq	64(%rsp), %r11                  # 8-byte Folded Reload
	adcq	72(%rsp), %r14                  # 8-byte Folded Reload
	movq	96(%rsp), %r10                  # 8-byte Reload
	movq	%r11, 96(%r10)
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	%rax, (%r10)
	adcq	80(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r14, 104(%r10)
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 8(%r10)
	adcq	88(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%r9, 112(%r10)
	movq	56(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 16(%r10)
	adcq	-56(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, 120(%r10)
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 24(%r10)
	movq	40(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 32(%r10)
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 40(%r10)
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 48(%r10)
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 56(%r10)
	adcq	-48(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	-40(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-64(%rsp), %rbx                 # 8-byte Folded Reload
	setb	%al
	movq	%r8, %rcx
	subq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rdi, %rdx
	sbbq	-120(%rsp), %rdx                # 8-byte Folded Reload
	movq	%r13, %rsi
	sbbq	%r12, %rsi
	movq	%rbx, %r9
	sbbq	%r15, %r9
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%r13, %rsi
	movq	%rsi, 144(%r10)
	cmovneq	%rbx, %r9
	movq	%r9, 152(%r10)
	cmovneq	%r8, %rcx
	movq	%rcx, 128(%r10)
	cmovneq	%rdi, %rdx
	movq	%rdx, 136(%r10)
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end84:
	.size	mcl_fp2Dbl_mul_xi_u1x9_4L, .Lfunc_end84-mcl_fp2Dbl_mul_xi_u1x9_4L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u5x0_4L          # -- Begin function mcl_fp2_mul_xi_u5x0_4L
	.p2align	4
	.type	mcl_fp2_mul_xi_u5x0_4L,@function
mcl_fp2_mul_xi_u5x0_4L:                 # @mcl_fp2_mul_xi_u5x0_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %rax
	movq	24(%rdx), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rbx
	movq	(%rdx), %r8
	movq	8(%rdx), %rdi
	movq	48(%rsi), %r9
	movq	56(%rsi), %r10
	movq	72(%rsi), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %r11
	movq	(%rsi), %r14
	movq	8(%rsi), %r15
	movq	24(%rsi), %r12
	movq	16(%rsi), %rsi
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%rsi, 64(%rax)
	movq	%r12, 72(%rax)
	movq	%r14, 48(%rax)
	movq	%r15, 56(%rax)
	movq	%rcx, %rax
	shldq	$1, %r11, %rax
	movq	%r11, %r12
	shldq	$1, %r10, %r12
	movq	%r10, %rbp
	shldq	$1, %r9, %rbp
	leaq	(%r9,%r9), %rcx
	movq	%rcx, %rsi
	subq	%r8, %rsi
	movq	%rbp, %r15
	sbbq	%rdi, %r15
	movq	%r12, %r13
	sbbq	%rbx, %r13
	movq	%rax, %r14
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	sbbq	%rdx, %r14
	cmovsq	%rbp, %r15
	cmovsq	%r12, %r13
	cmovsq	%rax, %r14
	cmovsq	%rcx, %rsi
	shldq	$1, %r13, %r14
	shldq	$1, %r15, %r13
	shldq	$1, %rsi, %r15
	addq	%rsi, %rsi
	movq	%rsi, %rax
	subq	%r8, %rax
	movq	%r15, %r12
	sbbq	%rdi, %r12
	movq	%r13, %rbp
	sbbq	%rbx, %rbp
	movq	%r14, %rcx
	sbbq	%rdx, %rcx
	cmovsq	%r14, %rcx
	cmovsq	%r13, %rbp
	cmovsq	%r15, %r12
	cmovsq	%rsi, %rax
	addq	%r9, %rax
	adcq	%r10, %r12
	adcq	%r11, %rbp
	adcq	-16(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rax, %r11
	subq	%r8, %r11
	movq	%r12, %r10
	sbbq	%rdi, %r10
	movq	%rbp, %r9
	sbbq	%rbx, %r9
	movq	%rcx, %rsi
	sbbq	%rdx, %rsi
	cmovsq	%rcx, %rsi
	cmovsq	%rbp, %r9
	cmovsq	%r12, %r10
	cmovsq	%rax, %r11
	xorl	%eax, %eax
	movq	%r11, %rcx
	addq	$-1, %rcx
	movq	%r10, %rcx
	adcq	$-1, %rcx
	movq	%r9, %rcx
	adcq	$-1, %rcx
	movq	%rsi, %rcx
	adcq	$-1, %rcx
	cmovsq	%rax, %rdx
	movq	%rdx, %rcx
	cmovsq	%rax, %rbx
	cmovsq	%rax, %rdi
	cmovsq	%rax, %r8
	subq	%r11, %r8
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%r8, (%rdx)
	sbbq	%r10, %rdi
	movq	%rdi, 8(%rdx)
	sbbq	%r9, %rbx
	movq	%rbx, 16(%rdx)
	movq	%rcx, %rax
	sbbq	%rsi, %rax
	movq	%rax, 24(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end85:
	.size	mcl_fp2_mul_xi_u5x0_4L, .Lfunc_end85-mcl_fp2_mul_xi_u5x0_4L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u5x0_4L       # -- Begin function mcl_fp2Dbl_mul_xi_u5x0_4L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u5x0_4L,@function
mcl_fp2Dbl_mul_xi_u5x0_4L:              # @mcl_fp2Dbl_mul_xi_u5x0_4L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r9
	movq	96(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	104(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	112(%rsi), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	(%rdx), %r10
	movq	8(%rdx), %r11
	movq	%r11, -72(%rsp)                 # 8-byte Spill
	movq	120(%rsi), %r14
	movq	128(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	136(%rsi), %r12
	movq	152(%rsi), %rbx
	movq	144(%rsi), %rbp
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	40(%rsi), %rdx
	movq	32(%rsi), %rdi
	movq	56(%rsi), %r8
	movq	48(%rsi), %r15
	movq	(%rsi), %r13
	movq	8(%rsi), %rsi
	movq	%r13, 96(%r9)
	movq	%rsi, 104(%r9)
	movq	%r15, 144(%r9)
	movq	%r8, 152(%r9)
	movq	%rdi, 128(%r9)
	movq	%rdx, 136(%r9)
	movq	%rcx, 112(%r9)
	movq	%rax, 120(%r9)
	movq	%rbx, -40(%rsp)                 # 8-byte Spill
	movq	%rbx, %rax
	movq	%rbp, %rcx
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	shldq	$1, %rbp, %rax
	movq	%r12, %rsi
	movq	%r12, -48(%rsp)                 # 8-byte Spill
	shldq	$1, %r12, %rcx
	movq	-64(%rsp), %rdi                 # 8-byte Reload
	shldq	$1, %rdi, %rsi
	shldq	$1, %r14, %rdi
	movq	%rbx, %rbp
	shrq	$63, %rbp
	movq	%rdi, %rdx
	subq	%r10, %rdx
	movq	%r10, %r12
	movq	%rsi, %r15
	sbbq	%r11, %r15
	movq	%rcx, %r8
	movq	-88(%rsp), %r10                 # 8-byte Reload
	sbbq	%r10, %r8
	movq	%rax, %r13
	movq	-80(%rsp), %r11                 # 8-byte Reload
	sbbq	%r11, %r13
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%rax, %r13
	cmovneq	%rcx, %r8
	cmovneq	%rsi, %r15
	cmovneq	%rdi, %rdx
	leaq	(%r14,%r14), %rdi
	shrdq	$63, %rdx, %rdi
	shrdq	$63, %r15, %rdx
	shrdq	$63, %r8, %r15
	shrdq	$63, %r13, %r8
	shrq	$63, %r13
	movq	%rdi, %rsi
	subq	%r12, %rsi
	movq	%r12, -56(%rsp)                 # 8-byte Spill
	movq	%rdx, %rbp
	movq	-72(%rsp), %rbx                 # 8-byte Reload
	sbbq	%rbx, %rbp
	movq	%r15, %rcx
	sbbq	%r10, %rcx
	movq	%r8, %rax
	sbbq	%r11, %rax
	sbbq	$0, %r13
	testb	$1, %r13b
	cmovneq	%r8, %rax
	cmovneq	%r15, %rcx
	cmovneq	%rdx, %rbp
	cmovneq	%rdi, %rsi
	movq	%r14, %r13
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	shldq	$2, %rdx, %r13
	movq	%rdx, %r8
	movq	-16(%rsp), %rdi                 # 8-byte Reload
	shldq	$2, %rdi, %r8
	movq	%rdi, %r15
	movq	%rdi, %r10
	movq	-8(%rsp), %r11                  # 8-byte Reload
	shldq	$2, %r11, %r15
	leaq	(,%r11,4), %rdi
	addq	%r11, %rdi
	adcq	%r10, %r15
	adcq	%rdx, %r8
	adcq	%r14, %r13
	adcq	-64(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	adcq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	adcq	-40(%rsp), %rax                 # 8-byte Folded Reload
	setb	%r10b
	movq	%rsi, %rdx
	subq	%r12, %rdx
	movq	%rbp, %r12
	sbbq	%rbx, %r12
	movq	%rcx, %r14
	sbbq	-88(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	-80(%rsp), %r11                 # 8-byte Reload
	sbbq	%r11, %rbx
	movzbl	%r10b, %r10d
	sbbq	$0, %r10
	testb	$1, %r10b
	cmovneq	%rax, %rbx
	cmovneq	%rcx, %r14
	cmovneq	%rbp, %r12
	cmovneq	%rsi, %rdx
	xorl	%eax, %eax
	negq	%rdi
	movq	%rdi, (%r9)
	movl	$0, %ecx
	sbbq	%r15, %rcx
	movq	%rcx, 8(%r9)
	movl	$0, %ecx
	sbbq	%r8, %rcx
	movq	%rcx, 16(%r9)
	movl	$0, %ecx
	sbbq	%r13, %rcx
	movq	%rcx, 24(%r9)
	movl	$0, %ecx
	sbbq	%rdx, %rcx
	movl	$0, %edx
	sbbq	%r12, %rdx
	movl	$0, %esi
	sbbq	%r14, %rsi
	movl	$0, %edi
	sbbq	%rbx, %rdi
	sbbq	%rax, %rax
	movq	%r11, %r8
	andq	%rax, %r8
	movq	-88(%rsp), %r10                 # 8-byte Reload
	andq	%rax, %r10
	movq	-72(%rsp), %r11                 # 8-byte Reload
	andq	%rax, %r11
	andq	-56(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rcx, %rax
	movq	%rax, 32(%r9)
	adcq	%rdx, %r11
	movq	%r11, 40(%r9)
	movq	%r10, %rax
	adcq	%rsi, %rax
	movq	%rax, 48(%r9)
	movq	%r8, %rax
	adcq	%rdi, %rax
	movq	%rax, 56(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end86:
	.size	mcl_fp2Dbl_mul_xi_u5x0_4L, .Lfunc_end86-mcl_fp2Dbl_mul_xi_u5x0_4L
                                        # -- End function
	.globl	mcl_fp_neg6L                    # -- Begin function mcl_fp_neg6L
	.p2align	4
	.type	mcl_fp_neg6L,@function
mcl_fp_neg6L:                           # @mcl_fp_neg6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r9
	movq	(%rsi), %r15
	movq	8(%rsi), %rbx
	movq	%rbx, %rax
	orq	%r9, %rax
	movq	24(%rsi), %r11
	orq	%r11, %rax
	movq	32(%rsi), %r14
	movq	%r15, %rcx
	orq	%r14, %rcx
	movq	16(%rsi), %r12
	orq	%r12, %rcx
	orq	%rax, %rcx
	je	.LBB87_1
# %bb.2:                                # %L46
	movq	40(%rdx), %rax
	movq	32(%rdx), %rsi
	movq	24(%rdx), %r8
	movq	16(%rdx), %r10
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	subq	%r15, %rcx
	sbbq	%rbx, %rdx
	sbbq	%r12, %r10
	sbbq	%r11, %r8
	sbbq	%r14, %rsi
	sbbq	%r9, %rax
	jmp	.LBB87_3
.LBB87_1:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%r10d, %r10d
	xorl	%r8d, %r8d
	xorl	%esi, %esi
	xorl	%eax, %eax
.LBB87_3:                               # %L48
	movq	%rcx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r10, 16(%rdi)
	movq	%r8, 24(%rdi)
	movq	%rsi, 32(%rdi)
	movq	%rax, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end87:
	.size	mcl_fp_neg6L, .Lfunc_end87-mcl_fp_neg6L
                                        # -- End function
	.globl	mcl_fp_mul2_6L                  # -- Begin function mcl_fp_mul2_6L
	.p2align	4
	.type	mcl_fp_mul2_6L,@function
mcl_fp_mul2_6L:                         # @mcl_fp_mul2_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rcx
	movq	8(%rsi), %rax
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r9
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r10
	setb	%sil
	movzbl	%sil, %ebx
	movq	%rcx, %r14
	subq	(%rdx), %r14
	movq	%rax, %rsi
	sbbq	8(%rdx), %rsi
	movq	%r9, %r15
	sbbq	16(%rdx), %r15
	movq	%r8, %r12
	sbbq	24(%rdx), %r12
	movq	%r11, %r13
	sbbq	32(%rdx), %r13
	movq	%r10, %rbp
	sbbq	40(%rdx), %rbp
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%r11, %r13
	movq	%r13, 32(%rdi)
	cmovneq	%r10, %rbp
	movq	%rbp, 40(%rdi)
	cmovneq	%r9, %r15
	movq	%r15, 16(%rdi)
	cmovneq	%r8, %r12
	movq	%r12, 24(%rdi)
	cmovneq	%rcx, %r14
	movq	%r14, (%rdi)
	cmovneq	%rax, %rsi
	movq	%rsi, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end88:
	.size	mcl_fp_mul2_6L, .Lfunc_end88-mcl_fp_mul2_6L
                                        # -- End function
	.globl	mcl_fp_sqr6L                    # -- Begin function mcl_fp_sqr6L
	.p2align	4
	.type	mcl_fp_sqr6L,@function
mcl_fp_sqr6L:                           # @mcl_fp_sqr6L
# %bb.0:
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	jmp	mcl_fp_mont6L@PLT               # TAILCALL
.Lfunc_end89:
	.size	mcl_fp_sqr6L, .Lfunc_end89-mcl_fp_sqr6L
                                        # -- End function
	.globl	mcl_fp_mul2NF6L                 # -- Begin function mcl_fp_mul2NF6L
	.p2align	4
	.type	mcl_fp_mul2NF6L,@function
mcl_fp_mul2NF6L:                        # @mcl_fp_mul2NF6L
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rcx
	movq	8(%rsi), %rax
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r9
	adcq	24(%rsi), %r8
	adcq	32(%rsi), %r11
	adcq	40(%rsi), %r10
	movq	%rcx, %rsi
	subq	(%rdx), %rsi
	movq	%rax, %rbx
	sbbq	8(%rdx), %rbx
	movq	%r9, %r14
	sbbq	16(%rdx), %r14
	movq	%r8, %r15
	sbbq	24(%rdx), %r15
	movq	%r11, %r12
	sbbq	32(%rdx), %r12
	movq	%r10, %r13
	sbbq	40(%rdx), %r13
	movq	%r13, %rdx
	sarq	$63, %rdx
	cmovsq	%r11, %r12
	movq	%r12, 32(%rdi)
	cmovsq	%r10, %r13
	movq	%r13, 40(%rdi)
	cmovsq	%r9, %r14
	movq	%r14, 16(%rdi)
	cmovsq	%r8, %r15
	movq	%r15, 24(%rdi)
	cmovsq	%rcx, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%rax, %rbx
	movq	%rbx, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end90:
	.size	mcl_fp_mul2NF6L, .Lfunc_end90-mcl_fp_mul2NF6L
                                        # -- End function
	.globl	mcl_fp_sqrNF6L                  # -- Begin function mcl_fp_sqrNF6L
	.p2align	4
	.type	mcl_fp_sqrNF6L,@function
mcl_fp_sqrNF6L:                         # @mcl_fp_sqrNF6L
# %bb.0:
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	jmp	mcl_fp_montNF6L@PLT             # TAILCALL
.Lfunc_end91:
	.size	mcl_fp_sqrNF6L, .Lfunc_end91-mcl_fp_sqrNF6L
                                        # -- End function
	.p2align	4                               # -- Begin function mcl_fp2_mulPre6L
	.type	.Lmcl_fp2_mulPre6L,@function
.Lmcl_fp2_mulPre6L:                     # @mcl_fp2_mulPre6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r10
	movq	8(%rsi), %rbp
	movq	(%rdx), %rcx
	movq	%r10, %rdx
	movq	%r10, -16(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rax, %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	16(%rsi), %r15
	movq	%r15, -64(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %r9
	movq	%r9, -56(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %r8
	movq	40(%rsi), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rax, (%rdi)
	movq	%rdi, %rsi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rdi, %r13
	movq	%r8, %rdx
	mulxq	%rcx, %rax, %rbx
	movq	%r9, %rdx
	mulxq	%rcx, %r14, %r11
	movq	%r15, %rdx
	mulxq	%rcx, %r12, %r9
	movq	%rbp, %rdx
	movq	%rbp, -40(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rcx, %r15
	addq	-112(%rsp), %rcx                # 8-byte Folded Reload
	adcq	%r12, %r15
	adcq	%r14, %r9
	adcq	%rax, %r11
	adcq	%rdi, %rbx
	adcq	$0, %r13
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rdx
	mulxq	%r10, %rdi, %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	addq	%rcx, %rdi
	movq	%rdi, 8(%rsi)
	movq	-48(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %r14, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulxq	%r8, %r12, %rsi
	movq	%rsi, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %r8                  # 8-byte Reload
	mulxq	%r8, %rdi, %rsi
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	mulxq	-64(%rsp), %rsi, %r10           # 8-byte Folded Reload
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	mulxq	%rbp, %r10, %rdx
	adcq	%r15, %r10
	adcq	%r9, %rsi
	adcq	%r11, %rdi
	adcq	%rbx, %r12
	adcq	%r13, %r14
	movzbl	-104(%rsp), %ebp                # 1-byte Folded Reload
	adcq	$0, %rbp
	addq	-88(%rsp), %r10                 # 8-byte Folded Reload
	adcq	%rdx, %rsi
	adcq	-8(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	-80(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	-72(%rsp), %r11                 # 8-byte Reload
	movq	16(%r11), %rdx
	mulxq	%rcx, %r9, %rcx
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %r15
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	mulxq	%r8, %rax, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-40(%rsp), %rcx, %rbx           # 8-byte Folded Reload
	mulxq	-16(%rsp), %rax, %r9            # 8-byte Folded Reload
	addq	%rcx, %r9
	mulxq	-64(%rsp), %rcx, %r8            # 8-byte Folded Reload
	adcq	%rbx, %rcx
	adcq	-104(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	movq	-88(%rsp), %rbx                 # 8-byte Reload
	adcq	$0, %rbx
	addq	%r10, %rax
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rax, 16(%rdx)
	adcq	%rsi, %r9
	adcq	%rdi, %rcx
	adcq	%r12, %r8
	adcq	%r14, %r13
	adcq	%rbp, %r15
	adcq	$0, %rbx
	movq	%rbx, -88(%rsp)                 # 8-byte Spill
	movq	24(%r11), %rdx
	mulxq	-48(%rsp), %rsi, %rax           # 8-byte Folded Reload
	movq	%rsi, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	mulxq	-32(%rsp), %rax, %r12           # 8-byte Folded Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-56(%rsp), %rax, %rbp           # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulxq	-40(%rsp), %rdi, %rsi           # 8-byte Folded Reload
	movq	-16(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %rax, %rbx
	addq	%rdi, %rbx
	movq	-64(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %rdi, %r10
	adcq	%rsi, %rdi
	adcq	-80(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	$0, %rsi
	addq	%r9, %rax
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rax, 24(%rdx)
	adcq	%rcx, %rbx
	adcq	%r8, %rdi
	adcq	%r13, %r10
	adcq	%r15, %rbp
	adcq	-88(%rsp), %r12                 # 8-byte Folded Reload
	adcq	$0, %rsi
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %rdx
	mulxq	-48(%rsp), %rcx, %rax           # 8-byte Folded Reload
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	mulxq	-32(%rsp), %rax, %r15           # 8-byte Folded Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-56(%rsp), %rax, %r13           # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulxq	-40(%rsp), %rsi, %r9            # 8-byte Folded Reload
	mulxq	%r14, %rax, %rcx
	addq	%rsi, %rcx
	mulxq	%r11, %rsi, %r8
	adcq	%r9, %rsi
	adcq	-80(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	movq	-88(%rsp), %r11                 # 8-byte Reload
	adcq	$0, %r11
	addq	%rbx, %rax
	movq	-24(%rsp), %r9                  # 8-byte Reload
	movq	%rax, 32(%r9)
	adcq	%rdi, %rcx
	adcq	%r10, %rsi
	adcq	%rbp, %r8
	adcq	%r12, %r13
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdx
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	mulxq	-40(%rsp), %rdi, %rax           # 8-byte Folded Reload
	mulxq	%r14, %rbp, %r10
	adcq	$0, %r11
	addq	%rdi, %r10
	mulxq	-64(%rsp), %rbx, %rdi           # 8-byte Folded Reload
	adcq	%rax, %rbx
	mulxq	-56(%rsp), %r14, %rax           # 8-byte Folded Reload
	adcq	%rdi, %r14
	mulxq	-32(%rsp), %r12, %rdi           # 8-byte Folded Reload
	adcq	%rax, %r12
	mulxq	-48(%rsp), %rax, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %rax
	adcq	$0, %rdx
	addq	%rbp, %rcx
	movq	%rcx, 40(%r9)
	adcq	%rsi, %r10
	movq	%r10, 48(%r9)
	adcq	%r8, %rbx
	movq	%rbx, 56(%r9)
	adcq	%r13, %r14
	movq	%r14, 64(%r9)
	adcq	%r15, %r12
	movq	%r12, 72(%r9)
	adcq	%r11, %rax
	movq	%rax, 80(%r9)
	adcq	$0, %rdx
	movq	%rdx, 88(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end92:
	.size	.Lmcl_fp2_mulPre6L, .Lfunc_end92-.Lmcl_fp2_mulPre6L
                                        # -- End function
	.globl	mcl_fp2_add6L                   # -- Begin function mcl_fp2_add6L
	.p2align	4
	.type	mcl_fp2_add6L,@function
mcl_fp2_add6L:                          # @mcl_fp2_add6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rcx), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	32(%rcx), %rbx
	movq	%rbx, -8(%rsp)                  # 8-byte Spill
	movq	24(%rcx), %r15
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	movq	16(%rcx), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	movq	(%rcx), %r11
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	movq	8(%rcx), %r13
	movq	%r13, -32(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %rbp
	movq	32(%rsi), %r14
	movq	24(%rsi), %r10
	movq	16(%rsi), %r8
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	addq	(%rdx), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	adcq	8(%rdx), %rcx
	adcq	16(%rdx), %r8
	adcq	24(%rdx), %r10
	adcq	32(%rdx), %r14
	adcq	40(%rdx), %rbp
	movq	%rbp, %r9
	movq	%rax, %rbp
	subq	%r11, %rbp
	movq	%rcx, %rax
	sbbq	%r13, %rax
	movq	%r8, %r13
	sbbq	%r12, %r13
	movq	%r10, %r12
	sbbq	%r15, %r12
	movq	%r14, %r15
	sbbq	%rbx, %r15
	movq	%r9, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, %rbx
	sarq	$63, %rbx
	cmovsq	%rcx, %rax
	movq	%rax, 8(%rdi)
	cmovsq	%r8, %r13
	movq	%r13, 16(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 24(%rdi)
	cmovsq	%r14, %r15
	movq	%r15, 32(%rdi)
	cmovsq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovsq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, (%rdi)
	movq	88(%rsi), %r12
	movq	80(%rsi), %r13
	movq	72(%rsi), %r14
	movq	64(%rsi), %r15
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	addq	48(%rdx), %rbx
	adcq	56(%rdx), %rsi
	adcq	64(%rdx), %r15
	adcq	72(%rdx), %r14
	adcq	80(%rdx), %r13
	adcq	88(%rdx), %r12
	movq	%rbx, %rax
	subq	-40(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rsi, %rcx
	sbbq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sbbq	-24(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r14, %r8
	sbbq	-16(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r13, %r9
	sbbq	-8(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r12, %r10
	sbbq	-56(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r10, %r11
	sarq	$63, %r11
	cmovsq	%r13, %r9
	movq	%r9, 80(%rdi)
	cmovsq	%r12, %r10
	movq	%r10, 88(%rdi)
	cmovsq	%r15, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r14, %r8
	movq	%r8, 72(%rdi)
	cmovsq	%rbx, %rax
	movq	%rax, 48(%rdi)
	cmovsq	%rsi, %rcx
	movq	%rcx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end93:
	.size	mcl_fp2_add6L, .Lfunc_end93-mcl_fp2_add6L
                                        # -- End function
	.globl	mcl_fp2_sub6L                   # -- Begin function mcl_fp2_sub6L
	.p2align	4
	.type	mcl_fp2_sub6L,@function
mcl_fp2_sub6L:                          # @mcl_fp2_sub6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r8
	movq	%rdi, %r10
	movq	16(%rcx), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	24(%rcx), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	32(%rcx), %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	40(%rcx), %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movq	(%rcx), %r9
	movq	%r9, -24(%rsp)                  # 8-byte Spill
	movq	8(%rcx), %r14
	movq	40(%rsi), %r11
	movq	32(%rsi), %rax
	movq	24(%rsi), %r15
	movq	16(%rsi), %r12
	movq	(%rsi), %rbp
	movq	8(%rsi), %r13
	subq	(%r8), %rbp
	sbbq	8(%r8), %r13
	sbbq	16(%r8), %r12
	sbbq	24(%r8), %r15
	sbbq	32(%r8), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	sbbq	40(%r8), %r11
	movq	%r11, %rbx
	sarq	$63, %rbx
	movq	%rbx, %rax
	shldq	$1, %r11, %rax
	andq	%r9, %rax
	movq	%rbx, %r9
	andq	%rdi, %r9
	movq	%rbx, %rdi
	andq	%rdx, %rdi
	movq	%rbx, %rdx
	andq	-48(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rbx, %rcx
	andq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	andq	%r14, %rbx
	addq	%rbp, %rax
	adcq	%r13, %rbx
	movq	%rax, (%r10)
	adcq	%r12, %rcx
	movq	%rbx, 8(%r10)
	adcq	%r15, %rdx
	movq	%rcx, 16(%r10)
	adcq	-32(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdx, 24(%r10)
	movq	%rdi, 32(%r10)
	adcq	%r11, %r9
	movq	%r9, 40(%r10)
	movq	88(%rsi), %rbx
	movq	80(%rsi), %rax
	movq	72(%rsi), %r15
	movq	64(%rsi), %r12
	movq	48(%rsi), %r13
	movq	56(%rsi), %rsi
	subq	48(%r8), %r13
	sbbq	56(%r8), %rsi
	sbbq	64(%r8), %r12
	sbbq	72(%r8), %r15
	sbbq	80(%r8), %rax
	sbbq	88(%r8), %rbx
	movq	%rbx, %rcx
	sarq	$63, %rcx
	movq	%rcx, %rdx
	shldq	$1, %rbx, %rdx
	andq	-24(%rsp), %rdx                 # 8-byte Folded Reload
	andq	%rcx, %r14
	movq	-16(%rsp), %rdi                 # 8-byte Reload
	andq	%rcx, %rdi
	movq	-8(%rsp), %r8                   # 8-byte Reload
	andq	%rcx, %r8
	movq	-48(%rsp), %r9                  # 8-byte Reload
	andq	%rcx, %r9
	andq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r13, %rdx
	movq	%rdx, 48(%r10)
	adcq	%rsi, %r14
	movq	%r14, 56(%r10)
	adcq	%r12, %rcx
	movq	%rcx, 64(%r10)
	movq	%r9, %rcx
	adcq	%r15, %rcx
	movq	%rcx, 72(%r10)
	movq	%r8, %rcx
	adcq	%rax, %rcx
	movq	%rcx, 80(%r10)
	movq	%rdi, %rax
	adcq	%rbx, %rax
	movq	%rax, 88(%r10)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end94:
	.size	mcl_fp2_sub6L, .Lfunc_end94-mcl_fp2_sub6L
                                        # -- End function
	.globl	mcl_fp2_neg6L                   # -- Begin function mcl_fp2_neg6L
	.p2align	4
	.type	mcl_fp2_neg6L,@function
mcl_fp2_neg6L:                          # @mcl_fp2_neg6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r10
	movq	(%rsi), %r13
	movq	8(%rsi), %r15
	movq	%r15, %rax
	orq	%r10, %rax
	movq	24(%rsi), %r14
	orq	%r14, %rax
	movq	32(%rsi), %r12
	movq	%r13, %rcx
	orq	%r12, %rcx
	movq	16(%rsi), %rbp
	orq	%rbp, %rcx
	orq	%rax, %rcx
	je	.LBB95_1
# %bb.2:                                # %L49
	movq	40(%rdx), %rax
	movq	32(%rdx), %r8
	movq	24(%rdx), %r9
	movq	16(%rdx), %r11
	movq	(%rdx), %rcx
	movq	8(%rdx), %rbx
	subq	%r13, %rcx
	sbbq	%r15, %rbx
	sbbq	%rbp, %r11
	sbbq	%r14, %r9
	sbbq	%r12, %r8
	sbbq	%r10, %rax
	jmp	.LBB95_3
.LBB95_1:
	xorl	%ecx, %ecx
	xorl	%ebx, %ebx
	xorl	%r11d, %r11d
	xorl	%r9d, %r9d
	xorl	%r8d, %r8d
	xorl	%eax, %eax
.LBB95_3:                               # %L51
	movq	%rcx, (%rdi)
	movq	%rbx, 8(%rdi)
	movq	%r11, 16(%rdi)
	movq	%r9, 24(%rdi)
	movq	%r8, 32(%rdi)
	movq	%rax, 40(%rdi)
	movq	88(%rsi), %r9
	movq	48(%rsi), %r15
	movq	56(%rsi), %rbx
	movq	%rbx, %rax
	orq	%r9, %rax
	movq	72(%rsi), %r11
	orq	%r11, %rax
	movq	80(%rsi), %r14
	movq	%r15, %rcx
	orq	%r14, %rcx
	movq	64(%rsi), %r12
	orq	%r12, %rcx
	orq	%rax, %rcx
	je	.LBB95_4
# %bb.5:                                # %L52
	movq	40(%rdx), %rax
	movq	32(%rdx), %rsi
	movq	24(%rdx), %r8
	movq	16(%rdx), %r10
	movq	(%rdx), %rcx
	movq	8(%rdx), %rdx
	subq	%r15, %rcx
	sbbq	%rbx, %rdx
	sbbq	%r12, %r10
	sbbq	%r11, %r8
	sbbq	%r14, %rsi
	sbbq	%r9, %rax
	jmp	.LBB95_6
.LBB95_4:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%r10d, %r10d
	xorl	%r8d, %r8d
	xorl	%esi, %esi
	xorl	%eax, %eax
.LBB95_6:                               # %L54
	movq	%rcx, 48(%rdi)
	movq	%rdx, 56(%rdi)
	movq	%r10, 64(%rdi)
	movq	%r8, 72(%rdi)
	movq	%rsi, 80(%rdi)
	movq	%rax, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end95:
	.size	mcl_fp2_neg6L, .Lfunc_end95-mcl_fp2_neg6L
                                        # -- End function
	.globl	mcl_fp2_mul2_6L                 # -- Begin function mcl_fp2_mul2_6L
	.p2align	4
	.type	mcl_fp2_mul2_6L,@function
mcl_fp2_mul2_6L:                        # @mcl_fp2_mul2_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rdx), %r11
	movq	%r11, -8(%rsp)                  # 8-byte Spill
	movq	32(%rdx), %r9
	movq	%r9, -16(%rsp)                  # 8-byte Spill
	movq	24(%rdx), %r14
	movq	%r14, -24(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %r15
	movq	%r15, -32(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rbp
	movq	%rbp, -48(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %r12
	movq	%r12, -40(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %r10
	movq	32(%rsi), %r8
	movq	24(%rsi), %rdx
	movq	16(%rsi), %rcx
	movq	(%rsi), %rbx
	movq	8(%rsi), %rax
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rdx
	adcq	32(%rsi), %r8
	adcq	40(%rsi), %r10
	movq	%rbx, %r13
	subq	%rbp, %r13
	movq	%rax, %rbp
	sbbq	%r12, %rbp
	movq	%rcx, %r12
	sbbq	%r15, %r12
	movq	%rdx, %r15
	sbbq	%r14, %r15
	movq	%r8, %r14
	sbbq	%r9, %r14
	movq	%r10, %r9
	sbbq	%r11, %r9
	movq	%r9, %r11
	sarq	$63, %r11
	cmovsq	%rax, %rbp
	movq	%rbp, 8(%rdi)
	cmovsq	%rcx, %r12
	movq	%r12, 16(%rdi)
	cmovsq	%rdx, %r15
	movq	%r15, 24(%rdi)
	cmovsq	%r8, %r14
	movq	%r14, 32(%rdi)
	cmovsq	%r10, %r9
	movq	%r9, 40(%rdi)
	cmovsq	%rbx, %r13
	movq	%r13, (%rdi)
	movq	88(%rsi), %r12
	movq	80(%rsi), %r13
	movq	72(%rsi), %r14
	movq	64(%rsi), %r15
	movq	48(%rsi), %rbx
	movq	56(%rsi), %r11
	addq	48(%rsi), %rbx
	adcq	56(%rsi), %r11
	adcq	64(%rsi), %r15
	adcq	72(%rsi), %r14
	adcq	80(%rsi), %r13
	adcq	88(%rsi), %r12
	movq	%rbx, %rax
	subq	-48(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r11, %rcx
	sbbq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sbbq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r14, %rsi
	sbbq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r13, %r8
	sbbq	-16(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r12, %r9
	sbbq	-8(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, %r10
	sarq	$63, %r10
	cmovsq	%r13, %r8
	movq	%r8, 80(%rdi)
	cmovsq	%r12, %r9
	movq	%r9, 88(%rdi)
	cmovsq	%r15, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r14, %rsi
	movq	%rsi, 72(%rdi)
	cmovsq	%rbx, %rax
	movq	%rax, 48(%rdi)
	cmovsq	%r11, %rcx
	movq	%rcx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end96:
	.size	mcl_fp2_mul2_6L, .Lfunc_end96-mcl_fp2_mul2_6L
                                        # -- End function
	.globl	mcl_fp2_mul_u1_6L               # -- Begin function mcl_fp2_mul_u1_6L
	.p2align	4
	.type	mcl_fp2_mul_u1_6L,@function
mcl_fp2_mul_u1_6L:                      # @mcl_fp2_mul_u1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$568, %rsp                      # imm = 0x238
	movq	%rcx, 264(%rsp)                 # 8-byte Spill
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, 272(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%rbp), %rdx
	movq	64(%rbp), %rcx
	movq	48(%rbp), %rax
	movq	56(%rbp), %r8
	addq	(%rbp), %rax
	adcq	8(%rbp), %r8
	adcq	16(%rbp), %rcx
	adcq	24(%rbp), %rdx
	adcq	32(%rbp), %rsi
	adcq	40(%rbp), %rdi
	movq	64(%r13), %r9
	movq	48(%r13), %r10
	movq	56(%r13), %r11
	addq	(%r13), %r10
	adcq	8(%r13), %r11
	adcq	16(%r13), %r9
	movq	72(%r13), %rbx
	adcq	24(%r13), %rbx
	movq	80(%r13), %r14
	adcq	32(%r13), %r14
	movq	88(%r13), %r15
	adcq	40(%r13), %r15
	movq	%r15, 416(%rsp)
	movq	%r14, 408(%rsp)
	movq	%rbx, 400(%rsp)
	movq	%r9, 392(%rsp)
	movq	%r11, 384(%rsp)
	movq	%r10, 376(%rsp)
	movq	%rdi, 464(%rsp)
	movq	%rsi, 456(%rsp)
	movq	%rdx, 448(%rsp)
	movq	%rcx, 440(%rsp)
	movq	%r8, 432(%rsp)
	movq	%rax, 424(%rsp)
	leaq	280(%rsp), %rdi
	leaq	424(%rsp), %rsi
	leaq	376(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre6L
	movq	%rsp, %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre6L
	addq	$48, %rbp
	addq	$48, %r13
	leaq	472(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre6L
	movq	504(%rsp), %rdi
	movq	%rdi, 216(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %rsi
	movq	%rsi, 224(%rsp)                 # 8-byte Spill
	movq	496(%rsp), %r8
	movq	%r8, 208(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rdx
	movq	%rdx, 232(%rsp)                 # 8-byte Spill
	movq	488(%rsp), %r9
	movq	%r9, 200(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rcx
	movq	%rcx, 240(%rsp)                 # 8-byte Spill
	movq	472(%rsp), %r11
	movq	%r11, 184(%rsp)                 # 8-byte Spill
	movq	480(%rsp), %r10
	movq	%r10, 192(%rsp)                 # 8-byte Spill
	movq	(%rsp), %r14
	movq	%r14, 256(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %rbx
	movq	%rbx, 248(%rsp)                 # 8-byte Spill
	addq	%r11, %r14
	adcq	%r10, %rbx
	movq	%rcx, %r11
	adcq	%r9, %r11
	movq	%rdx, %r10
	adcq	%r8, %r10
	movq	%rsi, %r8
	adcq	%rdi, %r8
	movq	512(%rsp), %rax
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	movq	40(%rsp), %r13
	movq	%r13, %r9
	adcq	%rax, %r9
	movq	520(%rsp), %rax
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	48(%rsp), %rdi
	movq	%rdi, 168(%rsp)                 # 8-byte Spill
	adcq	%rax, %rdi
	movq	528(%rsp), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	56(%rsp), %rsi
	movq	%rsi, 152(%rsp)                 # 8-byte Spill
	adcq	%rax, %rsi
	movq	536(%rsp), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	64(%rsp), %rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	adcq	%rax, %rdx
	movq	544(%rsp), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	72(%rsp), %rcx
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	adcq	%rax, %rcx
	movq	552(%rsp), %r15
	movq	%r15, 96(%rsp)                  # 8-byte Spill
	movq	80(%rsp), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	adcq	%r15, %rax
	movq	560(%rsp), %r12
	movq	88(%rsp), %r15
	movq	%r15, %rbp
	adcq	%r12, %rbp
	subq	%r14, 280(%rsp)
	sbbq	%rbx, 288(%rsp)
	sbbq	%r11, 296(%rsp)
	sbbq	%r10, 304(%rsp)
	sbbq	%r8, 312(%rsp)
	sbbq	%r9, 320(%rsp)
	sbbq	%rdi, 328(%rsp)
	sbbq	%rsi, 336(%rsp)
	sbbq	%rdx, 344(%rsp)
	sbbq	%rcx, 352(%rsp)
	sbbq	%rax, 360(%rsp)
	sbbq	%rbp, 368(%rsp)
	movq	256(%rsp), %r8                  # 8-byte Reload
	subq	184(%rsp), %r8                  # 8-byte Folded Reload
	movq	248(%rsp), %rdi                 # 8-byte Reload
	sbbq	192(%rsp), %rdi                 # 8-byte Folded Reload
	movq	240(%rsp), %rsi                 # 8-byte Reload
	sbbq	200(%rsp), %rsi                 # 8-byte Folded Reload
	movq	232(%rsp), %rdx                 # 8-byte Reload
	sbbq	208(%rsp), %rdx                 # 8-byte Folded Reload
	movq	224(%rsp), %rcx                 # 8-byte Reload
	sbbq	216(%rsp), %rcx                 # 8-byte Folded Reload
	sbbq	176(%rsp), %r13                 # 8-byte Folded Reload
	movq	168(%rsp), %r9                  # 8-byte Reload
	sbbq	160(%rsp), %r9                  # 8-byte Folded Reload
	movq	152(%rsp), %r10                 # 8-byte Reload
	sbbq	144(%rsp), %r10                 # 8-byte Folded Reload
	movq	136(%rsp), %r11                 # 8-byte Reload
	sbbq	128(%rsp), %r11                 # 8-byte Folded Reload
	movq	120(%rsp), %r14                 # 8-byte Reload
	sbbq	112(%rsp), %r14                 # 8-byte Folded Reload
	movq	104(%rsp), %rbp                 # 8-byte Reload
	sbbq	96(%rsp), %rbp                  # 8-byte Folded Reload
	sbbq	%r12, %r15
	movq	%r13, 40(%rsp)
	movq	%r15, %rax
	sarq	$63, %rax
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	shldq	$1, %r15, %rcx
	movq	264(%rsp), %rbx                 # 8-byte Reload
	andq	(%rbx), %rcx
	movq	%rdx, 24(%rsp)
	movq	40(%rbx), %rdx
	andq	%rax, %rdx
	movq	%rsi, 16(%rsp)
	movq	32(%rbx), %rsi
	andq	%rax, %rsi
	movq	%rdi, 8(%rsp)
	movq	24(%rbx), %rdi
	andq	%rax, %rdi
	movq	%r8, (%rsp)
	movq	16(%rbx), %r8
	andq	%rax, %r8
	andq	8(%rbx), %rax
	addq	%r9, %rcx
	adcq	%r10, %rax
	movq	%rcx, 48(%rsp)
	movq	%rax, 56(%rsp)
	adcq	%r11, %r8
	movq	%r8, 64(%rsp)
	adcq	%r14, %rdi
	movq	%rdi, 72(%rsp)
	adcq	%rbp, %rsi
	movq	%rsi, 80(%rsp)
	adcq	%r15, %rdx
	movq	%rdx, 88(%rsp)
	movq	272(%rsp), %r14                 # 8-byte Reload
	movq	%r14, %rdi
	movq	%rsp, %rsi
	movq	%rbx, %rdx
	callq	mcl_fp_montRedNF6L@PLT
	addq	$48, %r14
	movq	%r14, %rdi
	leaq	280(%rsp), %rsi
	movq	%rbx, %rdx
	callq	mcl_fp_montRedNF6L@PLT
	addq	$568, %rsp                      # imm = 0x238
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end97:
	.size	mcl_fp2_mul_u1_6L, .Lfunc_end97-mcl_fp2_mul_u1_6L
                                        # -- End function
	.globl	mcl_fp2_sqr_u1_6L               # -- Begin function mcl_fp2_sqr_u1_6L
	.p2align	4
	.type	mcl_fp2_sqr_u1_6L,@function
mcl_fp2_sqr_u1_6L:                      # @mcl_fp2_sqr_u1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	movq	%rdx, %rbp
	movq	%rsi, %rdx
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %rbx
	movq	24(%rsi), %rsi
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
	movq	64(%rdx), %r11
	movq	16(%rdx), %rdi
	movq	%rdi, 48(%rsp)                  # 8-byte Spill
	movq	56(%rdx), %r13
	movq	48(%rdx), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %r8
	movq	%r8, 40(%rsp)                   # 8-byte Spill
	subq	%rcx, %rax
	movq	%rax, %rcx
	movq	%r8, %rax
	sbbq	%r13, %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rdi, %rax
	sbbq	%r11, %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rsi, %rax
	sbbq	%rbx, %rax
	movq	80(%rdx), %rsi
	movq	32(%rdx), %r15
	movq	%r15, %r14
	sbbq	%rsi, %r14
	movq	88(%rdx), %r9
	movq	40(%rdx), %r12
	movq	%r12, %r10
	sbbq	%r9, %r10
	addq	(%rbp), %rcx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	adcq	8(%rbp), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	adcq	16(%rbp), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	adcq	24(%rbp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	adcq	32(%rbp), %r14
	adcq	40(%rbp), %r10
	movq	56(%rsp), %r8                   # 8-byte Reload
	addq	24(%rsp), %r8                   # 8-byte Folded Reload
	movq	40(%rsp), %rdi                  # 8-byte Reload
	adcq	%r13, %rdi
	movq	48(%rsp), %rcx                  # 8-byte Reload
	adcq	%r11, %rcx
	movq	32(%rsp), %rax                  # 8-byte Reload
	adcq	%rbx, %rax
	adcq	%rsi, %r15
	movq	%r15, 168(%rsp)
	adcq	%r9, %r12
	movq	%r12, 176(%rsp)
	movq	%rcx, 152(%rsp)
	movq	%rax, 160(%rsp)
	movq	%r8, 136(%rsp)
	movq	%rdi, 144(%rsp)
	shldq	$1, %rsi, %r9
	shldq	$1, %rbx, %rsi
	movq	%rsi, 216(%rsp)
	movq	%r9, 224(%rsp)
	shldq	$1, %r11, %rbx
	shldq	$1, %r13, %r11
	movq	%r11, 200(%rsp)
	movq	%rbx, 208(%rsp)
	movq	24(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rsi), %rax
	movq	%rax, 184(%rsp)
	shldq	$1, %rsi, %r13
	movq	%r13, 192(%rsp)
	movq	%r14, 120(%rsp)
	movq	%r10, 128(%rsp)
	movq	16(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 104(%rsp)
	movq	64(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 112(%rsp)
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 88(%rsp)
	movq	8(%rsp), %rax                   # 8-byte Reload
	movq	%rax, 96(%rsp)
	movq	80(%rsp), %r14                  # 8-byte Reload
	leaq	48(%r14), %rdi
	leaq	184(%rsp), %rsi
	movq	%rbp, %rcx
	callq	mcl_fp_montNF6L@PLT
	leaq	136(%rsp), %rsi
	leaq	88(%rsp), %rdx
	movq	%r14, %rdi
	movq	%rbp, %rcx
	callq	mcl_fp_montNF6L@PLT
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end98:
	.size	mcl_fp2_sqr_u1_6L, .Lfunc_end98-mcl_fp2_sqr_u1_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_mulPre_u1_6L         # -- Begin function mcl_fp2Dbl_mulPre_u1_6L
	.p2align	4
	.type	mcl_fp2Dbl_mulPre_u1_6L,@function
mcl_fp2Dbl_mulPre_u1_6L:                # @mcl_fp2Dbl_mulPre_u1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$392, %rsp                      # imm = 0x188
	movq	%rcx, 192(%rsp)                 # 8-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%r12), %rdx
	movq	64(%r12), %rcx
	movq	48(%r12), %rax
	movq	56(%r12), %r8
	addq	(%r12), %rax
	adcq	8(%r12), %r8
	adcq	16(%r12), %rcx
	adcq	24(%r12), %rdx
	adcq	32(%r12), %rsi
	adcq	40(%r12), %rdi
	movq	64(%r15), %r9
	movq	48(%r15), %r10
	movq	56(%r15), %r11
	addq	(%r15), %r10
	adcq	8(%r15), %r11
	adcq	16(%r15), %r9
	movq	72(%r15), %r14
	adcq	24(%r15), %r14
	movq	80(%r15), %r13
	adcq	32(%r15), %r13
	movq	88(%r15), %rbp
	adcq	40(%r15), %rbp
	movq	%rbp, 240(%rsp)
	movq	%r13, 232(%rsp)
	movq	%r14, 224(%rsp)
	movq	%r9, 216(%rsp)
	movq	%r11, 208(%rsp)
	movq	%r10, 200(%rsp)
	movq	%rdi, 288(%rsp)
	movq	%rsi, 280(%rsp)
	movq	%rdx, 272(%rsp)
	movq	%rcx, 264(%rsp)
	movq	%r8, 256(%rsp)
	movq	%rax, 248(%rsp)
	leaq	96(%rbx), %rdi
	leaq	248(%rsp), %rsi
	leaq	200(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre6L
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre6L
	addq	$48, %r12
	addq	$48, %r15
	leaq	296(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre6L
	movq	32(%rbx), %r11
	movq	%r11, 120(%rsp)                 # 8-byte Spill
	movq	24(%rbx), %r8
	movq	%r8, 160(%rsp)                  # 8-byte Spill
	movq	16(%rbx), %rcx
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	movq	(%rbx), %rbp
	movq	%rbp, 184(%rsp)                 # 8-byte Spill
	movq	8(%rbx), %rax
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	movq	320(%rsp), %rsi
	movq	%rsi, 152(%rsp)                 # 8-byte Spill
	movq	312(%rsp), %rdi
	movq	%rdi, 144(%rsp)                 # 8-byte Spill
	movq	296(%rsp), %r10
	movq	%r10, 128(%rsp)                 # 8-byte Spill
	movq	304(%rsp), %r9
	movq	%r9, 136(%rsp)                  # 8-byte Spill
	addq	%r10, %rbp
	movq	%rax, %r10
	adcq	%r9, %r10
	movq	%rcx, %r9
	adcq	%rdi, %r9
	adcq	%rsi, %r8
	movq	328(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r11, %rdi
	adcq	%rax, %rdi
	movq	40(%rbx), %r11
	movq	%r11, 112(%rsp)                 # 8-byte Spill
	movq	336(%rsp), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	adcq	%rax, %r11
	movq	48(%rbx), %rsi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	344(%rsp), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	adcq	%rax, %rsi
	movq	56(%rbx), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	352(%rsp), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	adcq	%rax, %rdx
	movq	64(%rbx), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	360(%rsp), %r14
	movq	%r14, 80(%rsp)                  # 8-byte Spill
	adcq	%r14, %rcx
	movq	72(%rbx), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	movq	368(%rsp), %r14
	movq	%r14, 72(%rsp)                  # 8-byte Spill
	adcq	%r14, %r15
	movq	80(%rbx), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	movq	376(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	adcq	%rax, %r12
	movq	88(%rbx), %r14
	movq	384(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%r14, %r13
	adcq	%rax, %r13
	subq	%rbp, 96(%rbx)
	sbbq	%r10, 104(%rbx)
	sbbq	%r9, 112(%rbx)
	sbbq	%r8, 120(%rbx)
	sbbq	%rdi, 128(%rbx)
	sbbq	%r11, 136(%rbx)
	sbbq	%rsi, 144(%rbx)
	sbbq	%rdx, 152(%rbx)
	sbbq	%rcx, 160(%rbx)
	sbbq	%r15, 168(%rbx)
	sbbq	%r12, 176(%rbx)
	sbbq	%r13, 184(%rbx)
	movq	184(%rsp), %rbp                 # 8-byte Reload
	subq	128(%rsp), %rbp                 # 8-byte Folded Reload
	movq	176(%rsp), %r11                 # 8-byte Reload
	sbbq	136(%rsp), %r11                 # 8-byte Folded Reload
	movq	168(%rsp), %r15                 # 8-byte Reload
	sbbq	144(%rsp), %r15                 # 8-byte Folded Reload
	movq	160(%rsp), %r12                 # 8-byte Reload
	sbbq	152(%rsp), %r12                 # 8-byte Folded Reload
	movq	120(%rsp), %r13                 # 8-byte Reload
	sbbq	64(%rsp), %r13                  # 8-byte Folded Reload
	movq	112(%rsp), %r8                  # 8-byte Reload
	sbbq	104(%rsp), %r8                  # 8-byte Folded Reload
	movq	96(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 40(%rsp)                  # 8-byte Folded Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 32(%rsp)                  # 8-byte Folded Spill
	movq	80(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 24(%rsp)                  # 8-byte Folded Spill
	movq	72(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 16(%rsp)                  # 8-byte Folded Spill
	movq	56(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 8(%rsp)                   # 8-byte Folded Spill
	sbbq	48(%rsp), %r14                  # 8-byte Folded Reload
	movq	%r14, %rcx
	sarq	$63, %rcx
	movq	%rcx, %rsi
	shldq	$1, %r14, %rsi
	movq	192(%rsp), %r10                 # 8-byte Reload
	andq	(%r10), %rsi
	movq	40(%r10), %rax
	andq	%rcx, %rax
	movq	32(%r10), %rdx
	andq	%rcx, %rdx
	movq	24(%r10), %rdi
	andq	%rcx, %rdi
	movq	16(%r10), %r9
	andq	%rcx, %r9
	andq	8(%r10), %rcx
	movq	%r8, 40(%rbx)
	movq	%r13, 32(%rbx)
	movq	%r12, 24(%rbx)
	movq	%r15, 16(%rbx)
	movq	%r11, 8(%rbx)
	movq	%rbp, (%rbx)
	addq	40(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, 48(%rbx)
	adcq	32(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, 56(%rbx)
	adcq	24(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, 64(%rbx)
	adcq	16(%rsp), %rdi                  # 8-byte Folded Reload
	movq	%rdi, 72(%rbx)
	adcq	8(%rsp), %rdx                   # 8-byte Folded Reload
	movq	%rdx, 80(%rbx)
	adcq	%r14, %rax
	movq	%rax, 88(%rbx)
	addq	$392, %rsp                      # imm = 0x188
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end99:
	.size	mcl_fp2Dbl_mulPre_u1_6L, .Lfunc_end99-mcl_fp2Dbl_mulPre_u1_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_sqrPre_u1_6L         # -- Begin function mcl_fp2Dbl_sqrPre_u1_6L
	.p2align	4
	.type	mcl_fp2Dbl_sqrPre_u1_6L,@function
mcl_fp2Dbl_sqrPre_u1_6L:                # @mcl_fp2Dbl_sqrPre_u1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$216, %rsp
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	%rdi, 160(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %r12
	movq	24(%rsi), %rdi
	movq	%rdi, 56(%rsp)                  # 8-byte Spill
	movq	64(%rsi), %r15
	movq	16(%rsi), %r8
	movq	%r8, 72(%rsp)                   # 8-byte Spill
	movq	56(%rsi), %rbp
	movq	48(%rsi), %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	movq	(%rdx), %rcx
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %r9
	movq	%r9, 64(%rsp)                   # 8-byte Spill
	subq	%rsi, %rcx
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	movq	%r9, %rcx
	sbbq	%rbp, %rcx
	movq	%rcx, 128(%rsp)                 # 8-byte Spill
	movq	%r8, %rcx
	sbbq	%r15, %rcx
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	movq	%rdi, %rcx
	sbbq	%r12, %rcx
	movq	%rcx, 152(%rsp)                 # 8-byte Spill
	movq	80(%rdx), %r8
	movq	32(%rdx), %r11
	movq	%r11, %rsi
	sbbq	%r8, %rsi
	movq	%rsi, 144(%rsp)                 # 8-byte Spill
	movq	88(%rdx), %r9
	movq	40(%rdx), %r10
	movq	%r10, %r14
	sbbq	%r9, %r14
	movq	%r14, 112(%rsp)                 # 8-byte Spill
	movq	%r14, %r13
	sarq	$63, %r13
	movq	%r13, %rbx
	shldq	$1, %r14, %rbx
	andq	(%rax), %rbx
	movq	40(%rax), %r14
	andq	%r13, %r14
	movq	%r14, 104(%rsp)                 # 8-byte Spill
	movq	32(%rax), %rcx
	andq	%r13, %rcx
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	movq	24(%rax), %rcx
	andq	%r13, %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	16(%rax), %r14
	andq	%r13, %r14
	andq	8(%rax), %r13
	movq	80(%rsp), %rdi                  # 8-byte Reload
	addq	(%rsp), %rdi                    # 8-byte Folded Reload
	movq	64(%rsp), %rsi                  # 8-byte Reload
	adcq	%rbp, %rsi
	movq	72(%rsp), %rcx                  # 8-byte Reload
	adcq	%r15, %rcx
	movq	56(%rsp), %rax                  # 8-byte Reload
	adcq	%r12, %rax
	adcq	%r8, %r11
	movq	%r11, 200(%rsp)
	adcq	%r9, %r10
	movq	%r10, 208(%rsp)
	movq	%rcx, 184(%rsp)
	movq	%rax, 192(%rsp)
	movq	%rdi, 168(%rsp)
	movq	%rsi, 176(%rsp)
	shldq	$1, %r8, %r9
	shldq	$1, %r12, %r8
	movq	%r8, 40(%rsp)
	movq	%r9, 48(%rsp)
	shldq	$1, %r15, %r12
	shldq	$1, %rbp, %r15
	movq	%r15, 24(%rsp)
	movq	%r12, 32(%rsp)
	movq	(%rsp), %rcx                    # 8-byte Reload
	leaq	(%rcx,%rcx), %rax
	movq	%rax, 8(%rsp)
	shldq	$1, %rcx, %rbp
	movq	%rbp, 16(%rsp)
	movq	160(%rsp), %r15                 # 8-byte Reload
	leaq	96(%r15), %rdi
	leaq	8(%rsp), %r12
	movq	%r12, %rsi
	callq	.Lmcl_fp2_mulPre6L
	addq	136(%rsp), %rbx                 # 8-byte Folded Reload
	adcq	128(%rsp), %r13                 # 8-byte Folded Reload
	adcq	120(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, 24(%rsp)
	movq	%r13, 16(%rsp)
	movq	%rbx, 8(%rsp)
	movq	88(%rsp), %rax                  # 8-byte Reload
	adcq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 32(%rsp)
	movq	96(%rsp), %rax                  # 8-byte Reload
	adcq	144(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 40(%rsp)
	movq	104(%rsp), %rax                 # 8-byte Reload
	adcq	112(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 48(%rsp)
	leaq	168(%rsp), %rdx
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	.Lmcl_fp2_mulPre6L
	addq	$216, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end100:
	.size	mcl_fp2Dbl_sqrPre_u1_6L, .Lfunc_end100-mcl_fp2Dbl_sqrPre_u1_6L
                                        # -- End function
	.globl	mcl_fp2_mul_u5_6L               # -- Begin function mcl_fp2_mul_u5_6L
	.p2align	4
	.type	mcl_fp2_mul_u5_6L,@function
mcl_fp2_mul_u5_6L:                      # @mcl_fp2_mul_u5_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$632, %rsp                      # imm = 0x278
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, 336(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%rbp), %rdx
	movq	64(%rbp), %rcx
	movq	48(%rbp), %rax
	movq	56(%rbp), %r8
	addq	(%rbp), %rax
	adcq	8(%rbp), %r8
	adcq	16(%rbp), %rcx
	adcq	24(%rbp), %rdx
	adcq	32(%rbp), %rsi
	adcq	40(%rbp), %rdi
	movq	80(%r13), %r9
	movq	72(%r13), %r10
	movq	64(%r13), %r11
	movq	48(%r13), %rbx
	movq	56(%r13), %r14
	addq	(%r13), %rbx
	adcq	8(%r13), %r14
	adcq	16(%r13), %r11
	adcq	24(%r13), %r10
	adcq	32(%r13), %r9
	movq	88(%r13), %r15
	adcq	40(%r13), %r15
	movq	%r15, 480(%rsp)
	movq	%r9, 472(%rsp)
	movq	%r10, 464(%rsp)
	movq	%r11, 456(%rsp)
	movq	%r14, 448(%rsp)
	movq	%rbx, 440(%rsp)
	movq	%rdi, 528(%rsp)
	movq	%rsi, 520(%rsp)
	movq	%rdx, 512(%rsp)
	movq	%rcx, 504(%rsp)
	movq	%r8, 496(%rsp)
	movq	%rax, 488(%rsp)
	leaq	344(%rsp), %rdi
	leaq	488(%rsp), %rsi
	leaq	440(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre6L
	leaq	88(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre6L
	addq	$48, %rbp
	addq	$48, %r13
	leaq	536(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	.Lmcl_fp2_mulPre6L
	movl	$5, %eax
	movq	552(%rsp), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdi, %rsi
	movq	560(%rsp), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %rcx
	addq	%rsi, %rdx
	movq	%rdx, %r8
	adcq	$0, %rcx
	movq	536(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	544(%rsp), %r9
	movq	%r9, 32(%rsp)                   # 8-byte Spill
	mulxq	%rax, %rdx, %rsi
	movq	%rdx, 328(%rsp)                 # 8-byte Spill
	movq	%r9, %rdx
	mulxq	%rax, %r9, %rdx
	addq	%rsi, %r9
	movq	%r9, 304(%rsp)                  # 8-byte Spill
	adcq	%rdi, %rdx
	movq	%rdx, 312(%rsp)                 # 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 320(%rsp)                  # 8-byte Spill
	setb	%sil
	movq	%rcx, %rdx
	adcq	$0, %rdx
	movq	584(%rsp), %rdx
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	mulxq	%rax, %r8, %rdi
	movq	592(%rsp), %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %r9
	setb	%r10b
	addq	%rdi, %rdx
	movq	%rdx, %rbx
	adcq	$0, %r9
	movq	568(%rsp), %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	mulxq	%rax, %r11, %rdi
	movq	576(%rsp), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	addq	%rdi, %rdx
	adcq	%r8, %r14
	adcq	$0, %rbx
	adcq	$0, %r9
	setb	%dil
	addb	$255, %sil
	adcq	%rcx, %r11
	movq	%r11, 296(%rsp)                 # 8-byte Spill
	movzbl	%r10b, %ecx
	adcq	%rdx, %rcx
	movq	%rcx, 288(%rsp)                 # 8-byte Spill
	adcq	$0, %r14
	movq	%r14, 272(%rsp)                 # 8-byte Spill
	adcq	$0, %rbx
	movq	%rbx, 280(%rsp)                 # 8-byte Spill
	setb	%r8b
	movq	%r9, %rcx
	adcq	$0, %rcx
	movzbl	%dil, %r10d
	adcq	$0, %r10
	movq	616(%rsp), %rdx
	movq	%rdx, %rbp
	mulxq	%rax, %rcx, %r15
	movq	600(%rsp), %rdx
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdi, %rsi
	movq	608(%rsp), %r13
	movq	%r13, %rdx
	mulxq	%rax, %r11, %rdx
	setb	%al
	addq	%rsi, %r11
	adcq	%rcx, %rdx
	movq	624(%rsp), %r12
	leaq	(%r12,%r12,4), %r14
	adcq	%r15, %r14
	addb	$255, %r8b
	adcq	%r9, %rdi
	movq	%rdi, 184(%rsp)                 # 8-byte Spill
	adcq	%r10, %r11
	movq	%r11, 192(%rsp)                 # 8-byte Spill
	movzbl	%al, %eax
	adcq	%rdx, %rax
	movq	%rax, 200(%rsp)                 # 8-byte Spill
	adcq	$0, %r14
	movq	88(%rsp), %rax
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %rbx                   # 8-byte Reload
	addq	%rax, %rbx
	movq	96(%rsp), %rax
	movq	%rax, 256(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %r11                  # 8-byte Reload
	adcq	%rax, %r11
	movq	104(%rsp), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r9                   # 8-byte Reload
	adcq	%rdx, %r9
	movq	112(%rsp), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %r8                   # 8-byte Reload
	adcq	%rdx, %r8
	movq	120(%rsp), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rdi                  # 8-byte Reload
	adcq	%rdx, %rdi
	movq	128(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rsi                  # 8-byte Reload
	adcq	%rdx, %rsi
	movq	136(%rsp), %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	72(%rsp), %r10                  # 8-byte Reload
	adcq	%rdx, %r10
	movq	144(%rsp), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %r15                  # 8-byte Reload
	adcq	%rdx, %r15
	movq	152(%rsp), %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	adcq	%rdx, %rcx
	movq	160(%rsp), %rdx
	movq	%rdx, 248(%rsp)                 # 8-byte Spill
	adcq	%rdx, %r13
	movq	168(%rsp), %rdx
	movq	%rdx, 240(%rsp)                 # 8-byte Spill
	movq	%rbp, %rax
	adcq	%rdx, %rax
	movq	176(%rsp), %rbp
	adcq	%rbp, %r12
	subq	%rbx, 344(%rsp)
	sbbq	%r11, 352(%rsp)
	sbbq	%r9, 360(%rsp)
	sbbq	%r8, 368(%rsp)
	sbbq	%rdi, 376(%rsp)
	sbbq	%rsi, 384(%rsp)
	sbbq	%r10, 392(%rsp)
	sbbq	%r15, 400(%rsp)
	sbbq	%rcx, 408(%rsp)
	sbbq	%r13, 416(%rsp)
	sbbq	%rax, 424(%rsp)
	sbbq	%r12, 432(%rsp)
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movq	(%rcx), %rsi
	movq	%rsi, 232(%rsp)                 # 8-byte Spill
	movq	272(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, %rax
	subq	%rsi, %rax
	movq	8(%rcx), %rsi
	movq	%rsi, 208(%rsp)                 # 8-byte Spill
	movq	280(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %r8
	sbbq	%rsi, %r8
	movq	16(%rcx), %rsi
	movq	%rsi, 72(%rsp)                  # 8-byte Spill
	movq	184(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %rdi
	sbbq	%rsi, %rdi
	movq	24(%rcx), %r9
	movq	%r9, 40(%rsp)                   # 8-byte Spill
	movq	192(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rsi
	sbbq	%r9, %rsi
	movq	32(%rcx), %r11
	movq	%r11, 224(%rsp)                 # 8-byte Spill
	movq	200(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %r9
	sbbq	%r11, %r9
	movq	40(%rcx), %rcx
	movq	%rcx, 216(%rsp)                 # 8-byte Spill
	movq	%r14, %r11
	sbbq	%rcx, %r11
	movq	%r11, %rcx
	sarq	$63, %rcx
	cmovsq	%r14, %r11
	cmovsq	%r13, %r9
	cmovsq	%rbx, %rsi
	cmovsq	%r15, %rdi
	cmovsq	%r10, %r8
	cmovsq	%rdx, %rax
	xorl	%r13d, %r13d
	negq	%rax
	movl	$0, %r15d
	sbbq	%r8, %r15
	movl	$0, %ecx
	sbbq	%rdi, %rcx
	movl	$0, %r10d
	sbbq	%rsi, %r10
	movl	$0, %esi
	sbbq	%r9, %rsi
	sbbq	%r11, %r13
	movq	264(%rsp), %r9                  # 8-byte Reload
	subq	328(%rsp), %r9                  # 8-byte Folded Reload
	movq	256(%rsp), %r11                 # 8-byte Reload
	sbbq	304(%rsp), %r11                 # 8-byte Folded Reload
	movq	32(%rsp), %rdx                  # 8-byte Reload
	sbbq	312(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rdx                  # 8-byte Reload
	sbbq	320(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rdx                  # 8-byte Reload
	sbbq	296(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rdx                   # 8-byte Reload
	sbbq	288(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	56(%rsp), %rbx                  # 8-byte Reload
	sbbq	$0, %rbx
	movq	48(%rsp), %r14                  # 8-byte Reload
	sbbq	$0, %r14
	movq	64(%rsp), %r8                   # 8-byte Reload
	sbbq	$0, %r8
	movq	248(%rsp), %rdi                 # 8-byte Reload
	sbbq	$0, %rdi
	movq	240(%rsp), %rdx                 # 8-byte Reload
	sbbq	$0, %rdx
	sbbq	$0, %rbp
	addq	%rax, %rbx
	adcq	%r15, %r14
	adcq	%rcx, %r8
	adcq	%r10, %rdi
	adcq	%rsi, %rdx
	adcq	%r13, %rbp
	movq	%rbp, %rax
	sarq	$63, %rax
	movq	%rax, %rcx
	shldq	$1, %rbp, %rcx
	andq	232(%rsp), %rcx                 # 8-byte Folded Reload
	movq	8(%rsp), %rsi                   # 8-byte Reload
	movq	%rsi, 128(%rsp)
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 120(%rsp)
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 112(%rsp)
	movq	32(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 104(%rsp)
	movq	%r11, 96(%rsp)
	movq	%r9, 88(%rsp)
	movq	208(%rsp), %r11                 # 8-byte Reload
	andq	%rax, %r11
	movq	216(%rsp), %r10                 # 8-byte Reload
	andq	%rax, %r10
	movq	224(%rsp), %r9                  # 8-byte Reload
	andq	%rax, %r9
	movq	40(%rsp), %rsi                  # 8-byte Reload
	andq	%rax, %rsi
	andq	72(%rsp), %rax                  # 8-byte Folded Reload
	addq	%rbx, %rcx
	adcq	%r14, %r11
	movq	%rcx, 136(%rsp)
	movq	%r11, 144(%rsp)
	adcq	%r8, %rax
	movq	%rax, 152(%rsp)
	movq	%rsi, %rax
	adcq	%rdi, %rax
	movq	%rax, 160(%rsp)
	movq	%r9, %rax
	adcq	%rdx, %rax
	movq	%rax, 168(%rsp)
	movq	%r10, %rax
	adcq	%rbp, %rax
	movq	%rax, 176(%rsp)
	movq	336(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	leaq	88(%rsp), %rsi
	movq	80(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rdx
	callq	mcl_fp_montRedNF6L@PLT
	addq	$48, %rbx
	movq	%rbx, %rdi
	leaq	344(%rsp), %rsi
	movq	%r14, %rdx
	callq	mcl_fp_montRedNF6L@PLT
	addq	$632, %rsp                      # imm = 0x278
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end101:
	.size	mcl_fp2_mul_u5_6L, .Lfunc_end101-mcl_fp2_mul_u5_6L
                                        # -- End function
	.globl	mcl_fp2_sqr_u5_6L               # -- Begin function mcl_fp2_sqr_u5_6L
	.p2align	4
	.type	mcl_fp2_sqr_u5_6L,@function
mcl_fp2_sqr_u5_6L:                      # @mcl_fp2_sqr_u5_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$312, %rsp                      # imm = 0x138
	movq	%rsi, %r13
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	movq	80(%rsi), %rbp
	movq	%rbp, 80(%rsp)                  # 8-byte Spill
	movq	88(%rsi), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	shldq	$1, %rbp, %rax
	movq	%rax, %r14
	movq	72(%rsi), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	shldq	$1, %rax, %rbp
	movq	64(%rsi), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	shldq	$1, %rcx, %rax
	movq	%rax, %r11
	movq	56(%rsi), %r9
	movq	%r9, 32(%rsp)                   # 8-byte Spill
	movq	%rcx, %rax
	shldq	$1, %r9, %rax
	movq	%rax, %rcx
	movq	48(%rsi), %rdi
	movq	%rdi, 72(%rsp)                  # 8-byte Spill
	shldq	$1, %rdi, %r9
	movq	(%rdx), %r12
	leaq	(%rdi,%rdi), %rbx
	movq	%rbx, %r10
	movq	%rbx, 128(%rsp)                 # 8-byte Spill
	subq	%r12, %r10
	movq	%r12, 64(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r9, %r15
	movq	%r9, 152(%rsp)                  # 8-byte Spill
	sbbq	%rax, %r15
	movq	16(%rdx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	%rdx, 160(%rsp)                 # 8-byte Spill
	movq	%rcx, %rsi
	movq	%rcx, %rdi
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	sbbq	%rax, %rsi
	movq	24(%rdx), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r11, %r8
	movq	%r11, %rcx
	movq	%r11, 136(%rsp)                 # 8-byte Spill
	sbbq	%rax, %r8
	movq	32(%rdx), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rbp, %r11
	movq	%rbp, 120(%rsp)                 # 8-byte Spill
	sbbq	%rax, %r11
	movq	40(%rdx), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%r14, %rdx
	movq	%r14, 112(%rsp)                 # 8-byte Spill
	sbbq	%rax, %r14
	movq	%r14, %rax
	sarq	$63, %rax
	cmovsq	%r9, %r15
	cmovsq	%rdi, %rsi
	cmovsq	%rcx, %r8
	cmovsq	%rbp, %r11
	cmovsq	%rdx, %r14
	cmovsq	%rbx, %r10
	shldq	$1, %r11, %r14
	shldq	$1, %r8, %r11
	shldq	$1, %rsi, %r8
	shldq	$1, %r15, %rsi
	shldq	$1, %r10, %r15
	addq	%r10, %r10
	movq	%r10, %rdx
	subq	%r12, %rdx
	movq	%r15, %rdi
	sbbq	8(%rsp), %rdi                   # 8-byte Folded Reload
	movq	%rsi, %r9
	sbbq	24(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r8, %rax
	sbbq	16(%rsp), %rax                  # 8-byte Folded Reload
	movq	%r11, %rbx
	sbbq	(%rsp), %rbx                    # 8-byte Folded Reload
	movq	%r14, %rcx
	sbbq	56(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, %rbp
	sarq	$63, %rbp
	cmovsq	%r14, %rcx
	cmovsq	%r11, %rbx
	cmovsq	%r8, %rax
	cmovsq	%rsi, %r9
	cmovsq	%r15, %rdi
	cmovsq	%r10, %rdx
	addq	72(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	32(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	40(%rsp), %r9                   # 8-byte Folded Reload
	adcq	48(%rsp), %rax                  # 8-byte Folded Reload
	adcq	80(%rsp), %rbx                  # 8-byte Folded Reload
	adcq	88(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rdx, %r10
	subq	64(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rdi, %r11
	sbbq	8(%rsp), %r11                   # 8-byte Folded Reload
	movq	%r9, %r15
	sbbq	24(%rsp), %r15                  # 8-byte Folded Reload
	movq	%rax, %r14
	sbbq	16(%rsp), %r14                  # 8-byte Folded Reload
	movq	%rbx, %r12
	sbbq	(%rsp), %r12                    # 8-byte Folded Reload
	movq	%rcx, %r8
	sbbq	56(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r8, %rbp
	sarq	$63, %rbp
	cmovsq	%rcx, %r8
	cmovsq	%rbx, %r12
	cmovsq	%rax, %r14
	cmovsq	%r9, %r15
	cmovsq	%rdi, %r11
	cmovsq	%rdx, %r10
	movq	(%r13), %r9
	movq	%r9, 96(%rsp)                   # 8-byte Spill
	subq	72(%rsp), %r9                   # 8-byte Folded Reload
	movq	8(%r13), %rbp
	movq	%rbp, %rbx
	sbbq	32(%rsp), %rbx                  # 8-byte Folded Reload
	movq	16(%r13), %rsi
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
	sbbq	40(%rsp), %rsi                  # 8-byte Folded Reload
	movq	24(%r13), %rdi
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	sbbq	48(%rsp), %rdi                  # 8-byte Folded Reload
	movq	32(%r13), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	sbbq	80(%rsp), %rdx                  # 8-byte Folded Reload
	movq	40(%r13), %rax
	movq	%rax, %rcx
	sbbq	88(%rsp), %rcx                  # 8-byte Folded Reload
	addq	64(%rsp), %r9                   # 8-byte Folded Reload
	adcq	8(%rsp), %rbx                   # 8-byte Folded Reload
	adcq	24(%rsp), %rsi                  # 8-byte Folded Reload
	adcq	16(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	(%rsp), %rdx                    # 8-byte Folded Reload
	adcq	56(%rsp), %rcx                  # 8-byte Folded Reload
	addq	96(%rsp), %r10                  # 8-byte Folded Reload
	adcq	%rbp, %r11
	movq	120(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 296(%rsp)
	movq	112(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 304(%rsp)
	movq	144(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 280(%rsp)
	movq	136(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 288(%rsp)
	movq	128(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 264(%rsp)
	movq	152(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, 272(%rsp)
	movq	%r9, 168(%rsp)
	movq	%rbx, 176(%rsp)
	movq	%rsi, 184(%rsp)
	movq	%rdi, 192(%rsp)
	movq	%rdx, 200(%rsp)
	movq	%rcx, 208(%rsp)
	movq	%r10, 216(%rsp)
	adcq	32(%rsp), %r15                  # 8-byte Folded Reload
	movq	%r11, 224(%rsp)
	adcq	40(%rsp), %r14                  # 8-byte Folded Reload
	movq	%r15, 232(%rsp)
	movq	%r14, 240(%rsp)
	adcq	48(%rsp), %r12                  # 8-byte Folded Reload
	movq	%r12, 248(%rsp)
	adcq	%rax, %r8
	movq	%r8, 256(%rsp)
	movq	104(%rsp), %r14                 # 8-byte Reload
	leaq	48(%r14), %rdi
	leaq	264(%rsp), %rsi
	movq	%r13, %rdx
	movq	160(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rcx
	callq	mcl_fp_montNF6L@PLT
	leaq	216(%rsp), %rsi
	leaq	168(%rsp), %rdx
	movq	%r14, %rdi
	movq	%rbx, %rcx
	callq	mcl_fp_montNF6L@PLT
	movq	80(%r14), %rax
	movq	88(%r14), %rdx
	shldq	$1, %rax, %rdx
	movq	72(%r14), %rcx
	shldq	$1, %rcx, %rax
	movq	64(%r14), %rsi
	shldq	$1, %rsi, %rcx
	movq	56(%r14), %rdi
	shldq	$1, %rdi, %rsi
	movq	48(%r14), %r11
	movq	%r14, %r12
	shldq	$1, %r11, %rdi
	addq	%r11, %r11
	movq	%r11, %rbx
	subq	64(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%rdi, %r14
	sbbq	8(%rsp), %r14                   # 8-byte Folded Reload
	movq	%rsi, %r15
	sbbq	24(%rsp), %r15                  # 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	16(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rax, %r8
	sbbq	(%rsp), %r8                     # 8-byte Folded Reload
	movq	%rdx, %r9
	movq	56(%rsp), %rbp                  # 8-byte Reload
	sbbq	%rbp, %r9
	movq	%r9, %r13
	sarq	$63, %r13
	cmovsq	%rdx, %r9
	cmovsq	%rax, %r8
	cmovsq	%rcx, %r10
	cmovsq	%rsi, %r15
	cmovsq	%rdi, %r14
	cmovsq	%r11, %rbx
	movq	(%r12), %rcx
	movq	8(%r12), %rax
	subq	%rbx, %rcx
	sbbq	%r14, %rax
	movq	16(%r12), %rdx
	sbbq	%r15, %rdx
	movq	24(%r12), %rsi
	sbbq	%r10, %rsi
	movq	32(%r12), %rdi
	sbbq	%r8, %rdi
	movq	40(%r12), %r8
	sbbq	%r9, %r8
	movq	%r8, %r9
	sarq	$63, %r9
	movq	%r9, %r10
	shldq	$1, %r8, %r10
	andq	64(%rsp), %r10                  # 8-byte Folded Reload
	movq	8(%rsp), %r11                   # 8-byte Reload
	andq	%r9, %r11
	movq	%rbp, %r15
	andq	%r9, %r15
	movq	(%rsp), %r14                    # 8-byte Reload
	andq	%r9, %r14
	movq	16(%rsp), %rbx                  # 8-byte Reload
	andq	%r9, %rbx
	andq	24(%rsp), %r9                   # 8-byte Folded Reload
	addq	%rcx, %r10
	movq	%r10, (%r12)
	movq	%r11, %rcx
	adcq	%rax, %rcx
	movq	%rcx, 8(%r12)
	adcq	%rdx, %r9
	movq	%r9, 16(%r12)
	movq	%rbx, %rax
	adcq	%rsi, %rax
	movq	%rax, 24(%r12)
	movq	%r14, %rax
	adcq	%rdi, %rax
	movq	%rax, 32(%r12)
	movq	%r15, %rax
	adcq	%r8, %rax
	movq	%rax, 40(%r12)
	addq	$312, %rsp                      # imm = 0x138
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end102:
	.size	mcl_fp2_sqr_u5_6L, .Lfunc_end102-mcl_fp2_sqr_u5_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_mulPre_u5_6L         # -- Begin function mcl_fp2Dbl_mulPre_u5_6L
	.p2align	4
	.type	mcl_fp2Dbl_mulPre_u5_6L,@function
mcl_fp2Dbl_mulPre_u5_6L:                # @mcl_fp2Dbl_mulPre_u5_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$424, %rsp                      # imm = 0x1A8
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%r12), %rdx
	movq	64(%r12), %rcx
	movq	48(%r12), %rax
	movq	56(%r12), %r8
	addq	(%r12), %rax
	adcq	8(%r12), %r8
	adcq	16(%r12), %rcx
	adcq	24(%r12), %rdx
	adcq	32(%r12), %rsi
	adcq	40(%r12), %rdi
	movq	72(%r15), %r9
	movq	64(%r15), %r10
	movq	48(%r15), %r11
	movq	56(%r15), %r14
	addq	(%r15), %r11
	adcq	8(%r15), %r14
	adcq	16(%r15), %r10
	adcq	24(%r15), %r9
	movq	80(%r15), %r13
	adcq	32(%r15), %r13
	movq	88(%r15), %rbp
	adcq	40(%r15), %rbp
	movq	%rbp, 272(%rsp)
	movq	%r13, 264(%rsp)
	movq	%r9, 256(%rsp)
	movq	%r10, 248(%rsp)
	movq	%r14, 240(%rsp)
	movq	%r11, 232(%rsp)
	movq	%rdi, 320(%rsp)
	movq	%rsi, 312(%rsp)
	movq	%rdx, 304(%rsp)
	movq	%rcx, 296(%rsp)
	movq	%r8, 288(%rsp)
	movq	%rax, 280(%rsp)
	leaq	96(%rbx), %rdi
	leaq	280(%rsp), %rsi
	leaq	232(%rsp), %rdx
	callq	.Lmcl_fp2_mulPre6L
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre6L
	addq	$48, %r12
	addq	$48, %r15
	leaq	328(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	.Lmcl_fp2_mulPre6L
	movl	$5, %eax
	movq	344(%rsp), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdi, %rsi
	movq	352(%rsp), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	mulxq	%rax, %rdx, %rcx
	addq	%rsi, %rdx
	movq	%rdx, %r8
	adcq	$0, %rcx
	movq	328(%rsp), %rdx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movq	336(%rsp), %r9
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	mulxq	%rax, %rdx, %rsi
	movq	%rdx, 224(%rsp)                 # 8-byte Spill
	movq	%r9, %rdx
	mulxq	%rax, %r9, %rdx
	addq	%rsi, %r9
	movq	%r9, 200(%rsp)                  # 8-byte Spill
	adcq	%rdi, %rdx
	movq	%rdx, 208(%rsp)                 # 8-byte Spill
	adcq	$0, %r8
	movq	%r8, 216(%rsp)                  # 8-byte Spill
	setb	%sil
	movq	%rcx, %rdx
	adcq	$0, %rdx
	movq	376(%rsp), %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	mulxq	%rax, %r10, %rdi
	movq	384(%rsp), %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %r8
	setb	%r11b
	addq	%rdi, %rdx
	movq	%rdx, %r15
	adcq	$0, %r8
	movq	360(%rsp), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	mulxq	%rax, %r9, %rdi
	movq	368(%rsp), %rdx
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	addq	%rdi, %rdx
	adcq	%r10, %r14
	adcq	$0, %r15
	adcq	$0, %r8
	setb	%dil
	addb	$255, %sil
	adcq	%rcx, %r9
	movq	%r9, 192(%rsp)                  # 8-byte Spill
	movzbl	%r11b, %ecx
	adcq	%rdx, %rcx
	movq	%rcx, 184(%rsp)                 # 8-byte Spill
	adcq	$0, %r14
	movq	%r14, 176(%rsp)                 # 8-byte Spill
	adcq	$0, %r15
	movq	%r15, 168(%rsp)                 # 8-byte Spill
	setb	%r9b
	movq	%r8, %rcx
	adcq	$0, %rcx
	movzbl	%dil, %r11d
	adcq	$0, %r11
	movq	408(%rsp), %r14
	movq	%r14, %rdx
	mulxq	%rax, %rsi, %rdi
	movq	392(%rsp), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	mulxq	%rax, %rcx, %rbp
	movq	400(%rsp), %r15
	movq	%r15, %rdx
	mulxq	%rax, %r10, %rdx
	setb	%al
	addq	%rbp, %r10
	adcq	%rsi, %rdx
	movq	416(%rsp), %r13
	leaq	(%r13,%r13,4), %r12
	adcq	%rdi, %r12
	addb	$255, %r9b
	adcq	%r8, %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	adcq	%r11, %r10
	movq	%r10, 96(%rsp)                  # 8-byte Spill
	movzbl	%al, %eax
	adcq	%rdx, %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	adcq	$0, %r12
	movq	(%rbx), %rax
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	(%rsp), %r10                    # 8-byte Reload
	addq	%rax, %r10
	movq	8(%rbx), %rax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	movq	24(%rsp), %rbp                  # 8-byte Reload
	adcq	%rax, %rbp
	movq	16(%rbx), %rdx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %r9                   # 8-byte Reload
	adcq	%rdx, %r9
	movq	24(%rbx), %rdx
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %r8                    # 8-byte Reload
	adcq	%rdx, %r8
	movq	32(%rbx), %rdx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	48(%rsp), %rdi                  # 8-byte Reload
	adcq	%rdx, %rdi
	movq	40(%rbx), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	40(%rsp), %rsi                  # 8-byte Reload
	adcq	%rax, %rsi
	movq	48(%rbx), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %rcx                  # 8-byte Reload
	adcq	%rax, %rcx
	movq	56(%rbx), %rdx
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %rax                  # 8-byte Reload
	adcq	%rdx, %rax
	movq	64(%rbx), %rdx
	movq	%rdx, 144(%rsp)                 # 8-byte Spill
	movq	32(%rsp), %r11                  # 8-byte Reload
	adcq	%rdx, %r11
	movq	72(%rbx), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	adcq	%rdx, %r15
	movq	80(%rbx), %rdx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	adcq	%rdx, %r14
	movq	88(%rbx), %rdx
	movq	%rdx, 120(%rsp)                 # 8-byte Spill
	adcq	%rdx, %r13
	subq	%r10, 96(%rbx)
	sbbq	%rbp, 104(%rbx)
	sbbq	%r9, 112(%rbx)
	sbbq	%r8, 120(%rbx)
	sbbq	%rdi, 128(%rbx)
	sbbq	%rsi, 136(%rbx)
	sbbq	%rcx, 144(%rbx)
	sbbq	%rax, 152(%rbx)
	sbbq	%r11, 160(%rbx)
	sbbq	%r15, 168(%rbx)
	sbbq	%r14, 176(%rbx)
	sbbq	%r13, 184(%rbx)
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	40(%rax), %r14
	movq	%r14, 104(%rsp)                 # 8-byte Spill
	movq	32(%rax), %r10
	movq	%r10, 136(%rsp)                 # 8-byte Spill
	movq	24(%rax), %r8
	movq	%r8, 56(%rsp)                   # 8-byte Spill
	movq	16(%rax), %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	(%rax), %rsi
	movq	%rsi, 112(%rsp)                 # 8-byte Spill
	movq	8(%rax), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	176(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdi
	subq	%rsi, %rdi
	movq	168(%rsp), %r13                 # 8-byte Reload
	movq	%r13, %r9
	sbbq	%rax, %r9
	movq	88(%rsp), %r15                  # 8-byte Reload
	movq	%r15, %rsi
	sbbq	%rcx, %rsi
	movq	96(%rsp), %r11                  # 8-byte Reload
	movq	%r11, %rcx
	sbbq	%r8, %rcx
	movq	80(%rsp), %rdx                  # 8-byte Reload
	movq	%rdx, %r8
	sbbq	%r10, %r8
	movq	%r12, %r10
	sbbq	%r14, %r10
	movq	%r10, %rax
	sarq	$63, %rax
	cmovsq	%r12, %r10
	cmovsq	%rdx, %r8
	cmovsq	%r11, %rcx
	cmovsq	%r15, %rsi
	cmovsq	%r13, %r9
	cmovsq	%rbp, %rdi
	xorl	%ebp, %ebp
	negq	%rdi
	movl	$0, %eax
	sbbq	%r9, %rax
	movl	$0, %r11d
	sbbq	%rsi, %r11
	movl	$0, %esi
	sbbq	%rcx, %rsi
	movl	$0, %ecx
	sbbq	%r8, %rcx
	sbbq	%r10, %rbp
	movq	160(%rsp), %r14                 # 8-byte Reload
	subq	224(%rsp), %r14                 # 8-byte Folded Reload
	movq	152(%rsp), %r8                  # 8-byte Reload
	sbbq	200(%rsp), %r8                  # 8-byte Folded Reload
	movq	24(%rsp), %rdx                  # 8-byte Reload
	sbbq	208(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	movq	16(%rsp), %rdx                  # 8-byte Reload
	sbbq	216(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 16(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rdx                   # 8-byte Reload
	sbbq	192(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	sbbq	184(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movq	48(%rsp), %r10                  # 8-byte Reload
	sbbq	$0, %r10
	movq	40(%rsp), %r15                  # 8-byte Reload
	sbbq	$0, %r15
	movq	144(%rsp), %r13                 # 8-byte Reload
	sbbq	$0, %r13
	movq	32(%rsp), %r9                   # 8-byte Reload
	sbbq	$0, %r9
	movq	128(%rsp), %rdx                 # 8-byte Reload
	sbbq	$0, %rdx
	movq	120(%rsp), %r12                 # 8-byte Reload
	sbbq	$0, %r12
	addq	%rdi, %r10
	movq	%r10, %rdi
	adcq	%rax, %r15
	movq	%r15, %r10
	adcq	%r11, %r13
	adcq	%rsi, %r9
	adcq	%rcx, %rdx
	movq	%r12, %rsi
	adcq	%rbp, %rsi
	movq	%rsi, %rax
	sarq	$63, %rax
	movq	%rax, %rcx
	shldq	$1, %rsi, %rcx
	movq	%rsi, %r15
	andq	112(%rsp), %rcx                 # 8-byte Folded Reload
	movq	(%rsp), %rsi                    # 8-byte Reload
	movq	%rsi, 40(%rbx)
	movq	8(%rsp), %rsi                   # 8-byte Reload
	movq	%rsi, 32(%rbx)
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 24(%rbx)
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 16(%rbx)
	movq	%r8, 8(%rbx)
	movq	%r14, (%rbx)
	movq	72(%rsp), %r12                  # 8-byte Reload
	andq	%rax, %r12
	movq	104(%rsp), %rsi                 # 8-byte Reload
	andq	%rax, %rsi
	movq	136(%rsp), %r8                  # 8-byte Reload
	andq	%rax, %r8
	movq	56(%rsp), %r14                  # 8-byte Reload
	andq	%rax, %r14
	andq	64(%rsp), %rax                  # 8-byte Folded Reload
	addq	%rdi, %rcx
	movq	%rcx, 48(%rbx)
	movq	%r12, %rcx
	adcq	%r10, %rcx
	movq	%rcx, 56(%rbx)
	adcq	%r13, %rax
	movq	%rax, 64(%rbx)
	movq	%r14, %rax
	adcq	%r9, %rax
	movq	%rax, 72(%rbx)
	movq	%r8, %rax
	adcq	%rdx, %rax
	movq	%rax, 80(%rbx)
	movq	%rsi, %rax
	adcq	%r15, %rax
	movq	%rax, 88(%rbx)
	addq	$424, %rsp                      # imm = 0x1A8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end103:
	.size	mcl_fp2Dbl_mulPre_u5_6L, .Lfunc_end103-mcl_fp2Dbl_mulPre_u5_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_sqrPre_u5_6L         # -- Begin function mcl_fp2Dbl_sqrPre_u5_6L
	.p2align	4
	.type	mcl_fp2Dbl_sqrPre_u5_6L,@function
mcl_fp2Dbl_sqrPre_u5_6L:                # @mcl_fp2Dbl_sqrPre_u5_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$280, %rsp                      # imm = 0x118
	movq	%rdx, %rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	72(%rsi), %r13
	movq	80(%rsi), %rcx
	movq	%rcx, %r8
	movq	%rcx, %rdi
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	shldq	$1, %r13, %r8
	movq	%r8, 64(%rsp)                   # 8-byte Spill
	movq	%r13, 104(%rsp)                 # 8-byte Spill
	movq	40(%rax), %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	movq	32(%rax), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	24(%rax), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	16(%rax), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movq	(%rax), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	8(%rax), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	64(%rsi), %rcx
	movq	56(%rsi), %rbp
	movq	%rbp, 88(%rsp)                  # 8-byte Spill
	movq	88(%rsi), %r14
	movq	%r14, 72(%rsp)                  # 8-byte Spill
	movq	%r8, 200(%rsp)
	shldq	$1, %rdi, %r14
	movq	%r14, 208(%rsp)
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	movq	%rcx, %r12
	shldq	$1, %rbp, %r12
	movq	%r12, 184(%rsp)
	shldq	$1, %rcx, %r13
	movq	%r13, 192(%rsp)
	movq	48(%rsi), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	leaq	(%rax,%rax), %r15
	movq	%r15, 168(%rsp)
	movq	%r15, 56(%rsp)                  # 8-byte Spill
	shldq	$1, %rax, %rbp
	movq	%rbp, 176(%rsp)
	movq	40(%rsi), %rax
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	leaq	96(%rbx), %rdi
	leaq	168(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre6L
	movq	%r15, %rax
	movq	24(%rsp), %r15                  # 8-byte Reload
	subq	%r15, %rax
	movq	%rbp, %rcx
	movq	48(%rsp), %r11                  # 8-byte Reload
	sbbq	%r11, %rcx
	movq	%r12, %rdx
	sbbq	40(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%r13, %rsi
	sbbq	16(%rsp), %rsi                  # 8-byte Folded Reload
	movq	64(%rsp), %r10                  # 8-byte Reload
	movq	%r10, %rdi
	sbbq	8(%rsp), %rdi                   # 8-byte Folded Reload
	movq	%r14, %r8
	sbbq	32(%rsp), %r8                   # 8-byte Folded Reload
	movq	%r8, %r9
	sarq	$63, %r9
	cmovsq	%rbp, %rcx
	cmovsq	%r12, %rdx
	cmovsq	%r13, %rsi
	cmovsq	%r10, %rdi
	cmovsq	%r14, %r8
	cmovsq	56(%rsp), %rax                  # 8-byte Folded Reload
	shldq	$1, %rdi, %r8
	shldq	$1, %rsi, %rdi
	shldq	$1, %rdx, %rsi
	shldq	$1, %rcx, %rdx
	shldq	$1, %rax, %rcx
	addq	%rax, %rax
	movq	%rax, %r9
	subq	%r15, %r9
	movq	%rcx, %r10
	sbbq	%r11, %r10
	movq	%rdx, %r11
	movq	40(%rsp), %rbp                  # 8-byte Reload
	sbbq	%rbp, %r11
	movq	%rsi, %r14
	sbbq	16(%rsp), %r14                  # 8-byte Folded Reload
	movq	%rdi, %r15
	sbbq	8(%rsp), %r15                   # 8-byte Folded Reload
	movq	%r8, %r12
	sbbq	32(%rsp), %r12                  # 8-byte Folded Reload
	movq	%r12, %r13
	sarq	$63, %r13
	cmovsq	%r8, %r12
	cmovsq	%rdi, %r15
	cmovsq	%rsi, %r14
	cmovsq	%rdx, %r11
	cmovsq	%rcx, %r10
	cmovsq	%rax, %r9
	addq	80(%rsp), %r9                   # 8-byte Folded Reload
	adcq	88(%rsp), %r10                  # 8-byte Folded Reload
	adcq	96(%rsp), %r11                  # 8-byte Folded Reload
	adcq	104(%rsp), %r14                 # 8-byte Folded Reload
	adcq	112(%rsp), %r15                 # 8-byte Folded Reload
	adcq	72(%rsp), %r12                  # 8-byte Folded Reload
	movq	%r9, %r8
	movq	24(%rsp), %rax                  # 8-byte Reload
	subq	%rax, %r8
	movq	%r10, %rdx
	sbbq	48(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%r11, %rax
	sbbq	%rbp, %rax
	movq	%r14, %rcx
	sbbq	16(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%r15, %rbp
	sbbq	8(%rsp), %rbp                   # 8-byte Folded Reload
	movq	%r12, %rdi
	movq	32(%rsp), %rsi                  # 8-byte Reload
	sbbq	%rsi, %rdi
	movq	%rdi, %r13
	sarq	$63, %r13
	cmovsq	%r12, %rdi
	cmovsq	%r15, %rbp
	movq	%rbp, 64(%rsp)                  # 8-byte Spill
	cmovsq	%r14, %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	cmovsq	%r11, %rax
	movq	%rax, 224(%rsp)                 # 8-byte Spill
	cmovsq	%r10, %rdx
	movq	%rdx, 216(%rsp)                 # 8-byte Spill
	cmovsq	%r9, %r8
	movq	120(%rsp), %r11                 # 8-byte Reload
	subq	80(%rsp), %r11                  # 8-byte Folded Reload
	movq	128(%rsp), %r14                 # 8-byte Reload
	sbbq	88(%rsp), %r14                  # 8-byte Folded Reload
	movq	136(%rsp), %r15                 # 8-byte Reload
	sbbq	96(%rsp), %r15                  # 8-byte Folded Reload
	movq	144(%rsp), %r12                 # 8-byte Reload
	sbbq	104(%rsp), %r12                 # 8-byte Folded Reload
	movq	152(%rsp), %r13                 # 8-byte Reload
	sbbq	112(%rsp), %r13                 # 8-byte Folded Reload
	movq	160(%rsp), %rbp                 # 8-byte Reload
	sbbq	72(%rsp), %rbp                  # 8-byte Folded Reload
	movq	%rbp, %r9
	sarq	$63, %r9
	movq	%r9, %rax
	shldq	$1, %rbp, %rax
	andq	24(%rsp), %rax                  # 8-byte Folded Reload
	movq	%r9, %r10
	andq	%rsi, %r10
	movq	%r9, %rsi
	andq	8(%rsp), %rsi                   # 8-byte Folded Reload
	movq	%r9, %rdx
	andq	16(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%r9, %rcx
	andq	40(%rsp), %rcx                  # 8-byte Folded Reload
	andq	48(%rsp), %r9                   # 8-byte Folded Reload
	addq	%r11, %rax
	adcq	%r14, %r9
	adcq	%r15, %rcx
	adcq	%r12, %rdx
	adcq	%r13, %rsi
	adcq	%rbp, %r10
	addq	120(%rsp), %r8                  # 8-byte Folded Reload
	movq	216(%rsp), %r11                 # 8-byte Reload
	adcq	128(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rax, 232(%rsp)
	movq	%r9, 240(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsi, 264(%rsp)
	movq	%r10, 272(%rsp)
	movq	%r8, 168(%rsp)
	movq	224(%rsp), %rax                 # 8-byte Reload
	adcq	136(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r11, 176(%rsp)
	movq	56(%rsp), %rcx                  # 8-byte Reload
	adcq	144(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rax, 184(%rsp)
	movq	%rcx, 192(%rsp)
	movq	64(%rsp), %rax                  # 8-byte Reload
	adcq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 200(%rsp)
	adcq	160(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdi, 208(%rsp)
	leaq	232(%rsp), %rdx
	movq	%rbx, %rdi
	leaq	168(%rsp), %rsi
	callq	.Lmcl_fp2_mulPre6L
	movq	176(%rbx), %rcx
	movq	184(%rbx), %rax
	shldq	$1, %rcx, %rax
	movq	168(%rbx), %rdx
	shldq	$1, %rdx, %rcx
	movq	160(%rbx), %rdi
	shldq	$1, %rdi, %rdx
	movq	152(%rbx), %r8
	shldq	$1, %r8, %rdi
	movq	144(%rbx), %r10
	shldq	$1, %r10, %r8
	movq	136(%rbx), %r9
	shldq	$1, %r9, %r10
	movq	128(%rbx), %r11
	shldq	$1, %r11, %r9
	movq	120(%rbx), %r14
	shldq	$1, %r14, %r11
	movq	112(%rbx), %r15
	shldq	$1, %r15, %r14
	movq	104(%rbx), %r12
	shldq	$1, %r12, %r15
	movq	96(%rbx), %r13
	shldq	$1, %r13, %r12
	addq	%r13, %r13
	xorl	%esi, %esi
	subq	%r13, (%rbx)
	sbbq	%r12, 8(%rbx)
	sbbq	%r15, 16(%rbx)
	sbbq	%r14, 24(%rbx)
	sbbq	%r11, 32(%rbx)
	sbbq	%r9, 40(%rbx)
	movq	48(%rbx), %r9
	sbbq	%r10, %r9
	movq	56(%rbx), %r10
	sbbq	%r8, %r10
	movq	64(%rbx), %r8
	sbbq	%rdi, %r8
	movq	72(%rbx), %rdi
	sbbq	%rdx, %rdi
	movq	80(%rbx), %rdx
	sbbq	%rcx, %rdx
	movq	88(%rbx), %rcx
	sbbq	%rax, %rcx
	sbbq	%rsi, %rsi
	movq	48(%rsp), %r14                  # 8-byte Reload
	andq	%rsi, %r14
	movq	24(%rsp), %r15                  # 8-byte Reload
	andq	%rsi, %r15
	movq	32(%rsp), %r12                  # 8-byte Reload
	andq	%rsi, %r12
	movq	8(%rsp), %rax                   # 8-byte Reload
	andq	%rsi, %rax
	movq	16(%rsp), %r11                  # 8-byte Reload
	andq	%rsi, %r11
	andq	40(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%r9, %r15
	movq	%r15, 48(%rbx)
	adcq	%r10, %r14
	movq	%r14, 56(%rbx)
	adcq	%r8, %rsi
	movq	%rsi, 64(%rbx)
	movq	%r11, %rsi
	adcq	%rdi, %rsi
	movq	%rsi, 72(%rbx)
	adcq	%rdx, %rax
	movq	%rax, 80(%rbx)
	movq	%r12, %rax
	adcq	%rcx, %rax
	movq	%rax, 88(%rbx)
	addq	$280, %rsp                      # imm = 0x118
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end104:
	.size	mcl_fp2Dbl_sqrPre_u5_6L, .Lfunc_end104-mcl_fp2Dbl_sqrPre_u5_6L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u1x1_6L          # -- Begin function mcl_fp2_mul_xi_u1x1_6L
	.p2align	4
	.type	mcl_fp2_mul_xi_u1x1_6L,@function
mcl_fp2_mul_xi_u1x1_6L:                 # @mcl_fp2_mul_xi_u1x1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r9
	movq	40(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	32(%rsi), %rdx
	movq	80(%rsi), %r10
	movq	24(%rsi), %r12
	movq	72(%rsi), %r11
	movq	16(%rsi), %r13
	movq	64(%rsi), %rbx
	movq	56(%rsi), %r14
	movq	(%rsi), %rcx
	movq	8(%rsi), %rbp
	movq	48(%rsi), %r15
	movq	%r15, %rax
	addq	%rcx, %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	%r14, %rsi
	adcq	%rbp, %rsi
	movq	%rsi, -56(%rsp)                 # 8-byte Spill
	movq	%rbx, %rsi
	adcq	%r13, %rsi
	movq	%rsi, -72(%rsp)                 # 8-byte Spill
	movq	%r11, %rsi
	adcq	%r12, %rsi
	movq	%rsi, -64(%rsp)                 # 8-byte Spill
	movq	%r10, %rax
	movq	%rdx, %rsi
	adcq	%rdx, %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	-104(%rsp), %r8                 # 8-byte Reload
	movq	%r8, %rax
	movq	-96(%rsp), %rdx                 # 8-byte Reload
	adcq	%rdx, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	subq	%r15, %rcx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	sbbq	%r14, %rbp
	movq	%rbp, -32(%rsp)                 # 8-byte Spill
	sbbq	%rbx, %r13
	movq	%r13, -24(%rsp)                 # 8-byte Spill
	sbbq	%r11, %r12
	movq	%r12, -16(%rsp)                 # 8-byte Spill
	sbbq	%r10, %rsi
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	sbbq	%r8, %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	%rdx, %r14
	sarq	$63, %r14
	movq	%r14, %r13
	shldq	$1, %rdx, %r13
	movq	(%r9), %rax
	andq	%rax, %r13
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	subq	%rax, %rbx
	movq	8(%r9), %rcx
	movq	-56(%rsp), %r11                 # 8-byte Reload
	sbbq	%rcx, %r11
	movq	40(%r9), %r15
	movq	32(%r9), %rbp
	movq	24(%r9), %rdx
	movq	16(%r9), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	-72(%rsp), %r9                  # 8-byte Reload
	sbbq	%rax, %r9
	movq	-64(%rsp), %r12                 # 8-byte Reload
	sbbq	%rdx, %r12
	movq	-88(%rsp), %rsi                 # 8-byte Reload
	sbbq	%rbp, %rsi
	movq	-48(%rsp), %r8                  # 8-byte Reload
	movq	%r8, %rax
	sbbq	%r15, %rax
	movq	%rax, %r10
	sarq	$63, %r10
	cmovsq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, 80(%rdi)
	cmovsq	%r8, %rax
	movq	%rax, 88(%rdi)
	cmovsq	-72(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r9, 64(%rdi)
	cmovsq	-64(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r12, 72(%rdi)
	cmovsq	-80(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, 48(%rdi)
	cmovsq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, 56(%rdi)
	andq	%r14, %rcx
	andq	%r14, %r15
	andq	%r14, %rbp
	andq	%r14, %rdx
	andq	-104(%rsp), %r14                # 8-byte Folded Reload
	addq	-40(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r13, (%rdi)
	adcq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, 8(%rdi)
	adcq	-24(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r14, 16(%rdi)
	adcq	-16(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdx, 24(%rdi)
	adcq	-8(%rsp), %rbp                  # 8-byte Folded Reload
	movq	%rbp, 32(%rdi)
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end105:
	.size	mcl_fp2_mul_xi_u1x1_6L, .Lfunc_end105-mcl_fp2_mul_xi_u1x1_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u1x1_6L       # -- Begin function mcl_fp2Dbl_mul_xi_u1x1_6L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u1x1_6L,@function
mcl_fp2Dbl_mul_xi_u1x1_6L:              # @mcl_fp2Dbl_mul_xi_u1x1_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$200, %rsp
	movq	88(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	184(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	80(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	176(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	168(%rsi), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	160(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	152(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	144(%rsi), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	40(%rsi), %rbp
	movq	%rbp, 136(%rsp)                 # 8-byte Spill
	movq	136(%rsi), %r13
	movq	%r13, 160(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %r12
	movq	%r12, 96(%rsp)                  # 8-byte Spill
	movq	128(%rsi), %r15
	movq	%r15, 128(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %r14
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	movq	120(%rsi), %rbx
	movq	%rbx, 80(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %r11
	movq	%r11, 16(%rsp)                  # 8-byte Spill
	movq	112(%rsi), %r9
	movq	%r9, 56(%rsp)                   # 8-byte Spill
	movq	104(%rsi), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movq	96(%rsi), %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	addq	%rax, %rsi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	adcq	%rcx, %r8
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	adcq	%r11, %r9
	movq	%r9, 72(%rsp)                   # 8-byte Spill
	adcq	%r14, %rbx
	movq	%rbx, 120(%rsp)                 # 8-byte Spill
	adcq	%r12, %r15
	movq	%r15, 152(%rsp)                 # 8-byte Spill
	adcq	%rbp, %r13
	movq	%r13, 168(%rsp)                 # 8-byte Spill
	movq	-112(%rsp), %r12                # 8-byte Reload
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -32(%rsp)                 # 8-byte Spill
	movq	-104(%rsp), %r15                # 8-byte Reload
	adcq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	-96(%rsp), %rsi                 # 8-byte Reload
	adcq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movq	-80(%rsp), %r8                  # 8-byte Reload
	adcq	-72(%rsp), %r8                  # 8-byte Folded Reload
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	adcq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	movq	-48(%rsp), %rbx                 # 8-byte Reload
	adcq	-40(%rsp), %rbx                 # 8-byte Folded Reload
	movq	40(%rdx), %rbp
	movq	%rbp, -24(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %r14
	movq	%r14, 24(%rsp)                  # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %r9
	movq	%r9, 176(%rsp)                  # 8-byte Spill
	movq	(%rdx), %r11
	movq	%r11, 104(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	setb	%r10b
	subq	%r11, %r12
	movq	%r15, %r13
	sbbq	%rdx, %r13
	movq	%rsi, %r11
	sbbq	%r9, %r11
	movq	%r8, %rdx
	sbbq	%rax, %rdx
	movq	%rcx, %r9
	sbbq	%r14, %r9
	movq	%rbx, %r14
	sbbq	%rbp, %r14
	movzbl	%r10b, %ebp
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%r15, %r13
	movq	%r13, 192(%rsp)                 # 8-byte Spill
	cmovneq	%rsi, %r11
	movq	%r11, 184(%rsp)                 # 8-byte Spill
	cmovneq	%r8, %rdx
	movq	%rdx, 144(%rsp)                 # 8-byte Spill
	cmovneq	%rcx, %r9
	movq	%r9, 88(%rsp)                   # 8-byte Spill
	cmovneq	%rbx, %r14
	movq	%r14, %r13
	cmovneq	-32(%rsp), %r12                 # 8-byte Folded Reload
	xorl	%edx, %edx
	movq	-8(%rsp), %rax                  # 8-byte Reload
	subq	(%rsp), %rax                    # 8-byte Folded Reload
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	sbbq	8(%rsp), %rcx                   # 8-byte Folded Reload
	movq	40(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 96(%rdi)
	movq	%rax, (%rdi)
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 104(%rdi)
	movq	16(%rsp), %rax                  # 8-byte Reload
	sbbq	56(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rcx, 8(%rdi)
	movq	72(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 112(%rdi)
	movq	64(%rsp), %rcx                  # 8-byte Reload
	sbbq	80(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rax, 16(%rdi)
	movq	120(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 120(%rdi)
	movq	96(%rsp), %r8                   # 8-byte Reload
	sbbq	128(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, 24(%rdi)
	movq	152(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 128(%rdi)
	movq	136(%rsp), %rcx                 # 8-byte Reload
	sbbq	160(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r8, 32(%rdi)
	movq	168(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 136(%rdi)
	movq	-128(%rsp), %rbp                # 8-byte Reload
	sbbq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	%rcx, 40(%rdi)
	movq	-120(%rsp), %r15                # 8-byte Reload
	sbbq	-104(%rsp), %r15                # 8-byte Folded Reload
	movq	-88(%rsp), %r11                 # 8-byte Reload
	sbbq	-96(%rsp), %r11                 # 8-byte Folded Reload
	movq	-72(%rsp), %r10                 # 8-byte Reload
	sbbq	-80(%rsp), %r10                 # 8-byte Folded Reload
	movq	-56(%rsp), %r9                  # 8-byte Reload
	sbbq	-64(%rsp), %r9                  # 8-byte Folded Reload
	movq	-40(%rsp), %r14                 # 8-byte Reload
	sbbq	-48(%rsp), %r14                 # 8-byte Folded Reload
	sbbq	%rdx, %rdx
	movq	32(%rsp), %rax                  # 8-byte Reload
	andq	%rdx, %rax
	movq	104(%rsp), %rbx                 # 8-byte Reload
	andq	%rdx, %rbx
	movq	-24(%rsp), %r8                  # 8-byte Reload
	andq	%rdx, %r8
	movq	24(%rsp), %rsi                  # 8-byte Reload
	andq	%rdx, %rsi
	movq	112(%rsp), %rcx                 # 8-byte Reload
	andq	%rdx, %rcx
	andq	176(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rbp, %rbx
	adcq	%r15, %rax
	movq	%rbx, 48(%rdi)
	adcq	%r11, %rdx
	movq	%rax, 56(%rdi)
	adcq	%r10, %rcx
	movq	%rdx, 64(%rdi)
	movq	%rcx, 72(%rdi)
	movq	%r13, 184(%rdi)
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 176(%rdi)
	movq	144(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 168(%rdi)
	movq	184(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 160(%rdi)
	movq	192(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 152(%rdi)
	movq	%r12, 144(%rdi)
	adcq	%r9, %rsi
	movq	%rsi, 80(%rdi)
	adcq	%r14, %r8
	movq	%r8, 88(%rdi)
	addq	$200, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end106:
	.size	mcl_fp2Dbl_mul_xi_u1x1_6L, .Lfunc_end106-mcl_fp2Dbl_mul_xi_u1x1_6L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u1x9_6L          # -- Begin function mcl_fp2_mul_xi_u1x9_6L
	.p2align	4
	.type	mcl_fp2_mul_xi_u1x9_6L,@function
mcl_fp2_mul_xi_u1x9_6L:                 # @mcl_fp2_mul_xi_u1x9_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
	movq	%rsi, %rbp
	movq	%rdi, 64(%rsp)                  # 8-byte Spill
	movq	80(%rsi), %r8
	movq	88(%rsi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%r8, -72(%rsp)                  # 8-byte Spill
	shldq	$1, %r8, %rax
	movq	72(%rsi), %r9
	movq	%r9, 8(%rsp)                    # 8-byte Spill
	shldq	$1, %r9, %r8
	movq	40(%rdx), %r13
	movq	32(%rdx), %rsi
	movq	%rsi, -104(%rsp)                # 8-byte Spill
	movq	24(%rdx), %rbx
	movq	%rbx, -112(%rsp)                # 8-byte Spill
	movq	16(%rdx), %r11
	movq	%r11, -128(%rsp)                # 8-byte Spill
	movq	(%rdx), %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	64(%rbp), %r10
	movq	%r10, (%rsp)                    # 8-byte Spill
	shldq	$1, %r10, %r9
	movq	56(%rbp), %r15
	movq	%r15, -8(%rsp)                  # 8-byte Spill
	shldq	$1, %r15, %r10
	movq	48(%rbp), %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	shldq	$1, %rdi, %r15
	leaq	(%rdi,%rdi), %r12
	movq	%r12, %rdi
	subq	%rcx, %rdi
	movq	%r15, %rcx
	sbbq	%rdx, %rcx
	movq	%r10, %rdx
	sbbq	%r11, %rdx
	movq	%r9, %r11
	sbbq	%rbx, %r11
	movq	%r8, %rbx
	sbbq	%rsi, %rbx
	movq	%rax, %r14
	sbbq	%r13, %r14
	movq	%r13, %rsi
	movq	%r13, -120(%rsp)                # 8-byte Spill
	movq	%r14, %r13
	sarq	$63, %r13
	cmovsq	%r15, %rcx
	cmovsq	%r10, %rdx
	cmovsq	%r9, %r11
	cmovsq	%r8, %rbx
	cmovsq	%rax, %r14
	cmovsq	%r12, %rdi
	shldq	$1, %rbx, %r14
	shldq	$1, %r11, %rbx
	shldq	$1, %rdx, %r11
	shldq	$1, %rcx, %rdx
	shldq	$1, %rdi, %rcx
	addq	%rdi, %rdi
	movq	%rdi, %rax
	subq	-88(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rcx, %r8
	sbbq	-96(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rdx, %r9
	sbbq	-128(%rsp), %r9                 # 8-byte Folded Reload
	movq	%r11, %r10
	sbbq	-112(%rsp), %r10                # 8-byte Folded Reload
	movq	%rbx, %r15
	sbbq	-104(%rsp), %r15                # 8-byte Folded Reload
	movq	%r14, %r12
	sbbq	%rsi, %r12
	movq	%r12, %r13
	sarq	$63, %r13
	cmovsq	%r11, %r10
	cmovsq	%rbx, %r15
	cmovsq	%r14, %r12
	cmovsq	%rdi, %rax
	cmovsq	%rcx, %r8
	cmovsq	%rdx, %r9
	shldq	$1, %r15, %r12
	shldq	$1, %r10, %r15
	shldq	$1, %r9, %r10
	shldq	$1, %r8, %r9
	shldq	$1, %rax, %r8
	addq	%rax, %rax
	movq	%rax, %rsi
	subq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r8, %rdx
	movq	-96(%rsp), %rcx                 # 8-byte Reload
	sbbq	%rcx, %rdx
	movq	%r9, %rdi
	sbbq	-128(%rsp), %rdi                # 8-byte Folded Reload
	movq	%r10, %r11
	sbbq	-112(%rsp), %r11                # 8-byte Folded Reload
	movq	%r15, %r14
	sbbq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	%r12, %r13
	sbbq	-120(%rsp), %r13                # 8-byte Folded Reload
	movq	%r13, %rbx
	sarq	$63, %rbx
	cmovsq	%r12, %r13
	cmovsq	%r15, %r14
	cmovsq	%r10, %r11
	cmovsq	%r9, %rdi
	cmovsq	%r8, %rdx
	cmovsq	%rax, %rsi
	addq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-8(%rsp), %rdx                  # 8-byte Folded Reload
	adcq	(%rsp), %rdi                    # 8-byte Folded Reload
	adcq	8(%rsp), %r11                   # 8-byte Folded Reload
	adcq	-72(%rsp), %r14                 # 8-byte Folded Reload
	adcq	16(%rsp), %r13                  # 8-byte Folded Reload
	movq	%rsi, %rax
	movq	-88(%rsp), %r8                  # 8-byte Reload
	subq	%r8, %rax
	movq	%rax, %r10
	movq	%rdx, %rax
	sbbq	%rcx, %rax
	movq	%rax, %r9
	movq	%rdi, %rax
	sbbq	-128(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, %r15
	movq	%r11, %rax
	sbbq	-112(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, %rbx
	movq	%r14, %rcx
	sbbq	-104(%rsp), %rcx                # 8-byte Folded Reload
	movq	%r13, %r12
	sbbq	-120(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, %rax
	sarq	$63, %rax
	cmovsq	%r13, %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	cmovsq	%r14, %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	cmovsq	%r11, %rbx
	movq	%rbx, -40(%rsp)                 # 8-byte Spill
	cmovsq	%rdi, %r15
	movq	%r15, -48(%rsp)                 # 8-byte Spill
	cmovsq	%rdx, %r9
	movq	%r9, -56(%rsp)                  # 8-byte Spill
	cmovsq	%rsi, %r10
	movq	%r10, -64(%rsp)                 # 8-byte Spill
	movq	(%rbp), %rbx
	movq	8(%rbp), %r15
	movq	16(%rbp), %r14
	movq	24(%rbp), %r10
	movq	32(%rbp), %r9
	movq	40(%rbp), %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	movq	%r9, 56(%rsp)                   # 8-byte Spill
	shldq	$1, %r9, %rcx
	movq	%r10, 48(%rsp)                  # 8-byte Spill
	shldq	$1, %r10, %r9
	movq	%r14, 40(%rsp)                  # 8-byte Spill
	shldq	$1, %r14, %r10
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	shldq	$1, %r15, %r14
	movq	%rbx, 24(%rsp)                  # 8-byte Spill
	shldq	$1, %rbx, %r15
	leaq	(%rbx,%rbx), %r13
	movq	%r13, %rdx
	subq	%r8, %rdx
	movq	%r8, %rbp
	movq	%r15, %r12
	sbbq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	%r14, %rdi
	sbbq	-128(%rsp), %rdi                # 8-byte Folded Reload
	movq	%r10, %rsi
	movq	-112(%rsp), %rbx                # 8-byte Reload
	sbbq	%rbx, %rsi
	movq	%r9, %r8
	sbbq	-104(%rsp), %r8                 # 8-byte Folded Reload
	movq	%rcx, %rax
	sbbq	-120(%rsp), %rax                # 8-byte Folded Reload
	movq	%rax, %r11
	sarq	$63, %r11
	cmovsq	%r14, %rdi
	cmovsq	%r10, %rsi
	cmovsq	%r9, %r8
	cmovsq	%rcx, %rax
	cmovsq	%r13, %rdx
	cmovsq	%r15, %r12
	shldq	$1, %r8, %rax
	shldq	$1, %rsi, %r8
	shldq	$1, %rdi, %rsi
	shldq	$1, %r12, %rdi
	shldq	$1, %rdx, %r12
	addq	%rdx, %rdx
	movq	%rdx, %r9
	subq	%rbp, %r9
	movq	%r12, %r13
	movq	-96(%rsp), %rbp                 # 8-byte Reload
	sbbq	%rbp, %r13
	movq	%rdi, %rcx
	sbbq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rsi, %r15
	sbbq	%rbx, %r15
	movq	%r8, %r14
	movq	-104(%rsp), %rbx                # 8-byte Reload
	sbbq	%rbx, %r14
	movq	%rax, %r10
	sbbq	-120(%rsp), %r10                # 8-byte Folded Reload
	movq	%r10, %r11
	sarq	$63, %r11
	cmovsq	%rsi, %r15
	cmovsq	%r8, %r14
	cmovsq	%rax, %r10
	cmovsq	%rdx, %r9
	cmovsq	%r12, %r13
	cmovsq	%rdi, %rcx
	shldq	$1, %r14, %r10
	shldq	$1, %r15, %r14
	shldq	$1, %rcx, %r15
	shldq	$1, %r13, %rcx
	shldq	$1, %r9, %r13
	addq	%r9, %r9
	movq	%r9, %r8
	subq	-88(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r13, %rdx
	sbbq	%rbp, %rdx
	movq	%rcx, %r12
	sbbq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r15, %rax
	sbbq	-112(%rsp), %rax                # 8-byte Folded Reload
	movq	%r14, %r11
	sbbq	%rbx, %r11
	movq	%r10, %rsi
	sbbq	-120(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, %rdi
	sarq	$63, %rdi
	cmovsq	%r10, %rsi
	cmovsq	%r14, %r11
	cmovsq	%r15, %rax
	cmovsq	%rcx, %r12
	cmovsq	%r13, %rdx
	cmovsq	%r9, %r8
	movq	24(%rsp), %r14                  # 8-byte Reload
	addq	%r14, -64(%rsp)                 # 8-byte Folded Spill
	movq	32(%rsp), %rbx                  # 8-byte Reload
	adcq	%rbx, -56(%rsp)                 # 8-byte Folded Spill
	movq	40(%rsp), %r10                  # 8-byte Reload
	adcq	%r10, -48(%rsp)                 # 8-byte Folded Spill
	movq	48(%rsp), %r9                   # 8-byte Reload
	adcq	%r9, -40(%rsp)                  # 8-byte Folded Spill
	movq	56(%rsp), %rdi                  # 8-byte Reload
	adcq	%rdi, -32(%rsp)                 # 8-byte Folded Spill
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	adcq	%rcx, -24(%rsp)                 # 8-byte Folded Spill
	addq	%r14, %r8
	adcq	%rbx, %rdx
	adcq	%r10, %r12
	adcq	%r9, %rax
	adcq	%rdi, %r11
	adcq	%rcx, %rsi
	movq	%r8, %r14
	subq	-88(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rdx, %r13
	sbbq	%rbp, %r13
	movq	%r12, %r15
	movq	-128(%rsp), %rbp                # 8-byte Reload
	sbbq	%rbp, %r15
	movq	%rax, %rcx
	movq	-112(%rsp), %rbx                # 8-byte Reload
	sbbq	%rbx, %rcx
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	movq	%r11, %rdi
	movq	-104(%rsp), %r9                 # 8-byte Reload
	sbbq	%r9, %rdi
	movq	%rsi, %r10
	sbbq	-120(%rsp), %r10                # 8-byte Folded Reload
	movq	%r10, %rcx
	sarq	$63, %rcx
	cmovsq	%rsi, %r10
	cmovsq	%r11, %rdi
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	cmovsq	%rax, %rcx
	cmovsq	%r12, %r15
	cmovsq	%rdx, %r13
	cmovsq	%r8, %r14
	subq	-16(%rsp), %r14                 # 8-byte Folded Reload
	sbbq	-8(%rsp), %r13                  # 8-byte Folded Reload
	sbbq	(%rsp), %r15                    # 8-byte Folded Reload
	sbbq	8(%rsp), %rcx                   # 8-byte Folded Reload
	movq	%rcx, -80(%rsp)                 # 8-byte Spill
	sbbq	-72(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	sbbq	16(%rsp), %r10                  # 8-byte Folded Reload
	movq	%r10, %rax
	sarq	$63, %rax
	movq	%rax, %rdx
	shldq	$1, %r10, %rdx
	movq	-88(%rsp), %rsi                 # 8-byte Reload
	andq	%rsi, %rdx
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	subq	%rsi, %rcx
	movq	-56(%rsp), %rsi                 # 8-byte Reload
	sbbq	-96(%rsp), %rsi                 # 8-byte Folded Reload
	movq	-48(%rsp), %r8                  # 8-byte Reload
	sbbq	%rbp, %r8
	movq	-40(%rsp), %r11                 # 8-byte Reload
	sbbq	%rbx, %r11
	movq	-32(%rsp), %rdi                 # 8-byte Reload
	movq	%rdi, %r12
	sbbq	%r9, %r12
	movq	-24(%rsp), %r9                  # 8-byte Reload
	movq	%r9, %rbp
	sbbq	-120(%rsp), %rbp                # 8-byte Folded Reload
	movq	%rbp, %rbx
	sarq	$63, %rbx
	cmovsq	%rdi, %r12
	movq	64(%rsp), %rbx                  # 8-byte Reload
	movq	%r12, 80(%rbx)
	cmovsq	%r9, %rbp
	movq	%rbp, 88(%rbx)
	cmovsq	-48(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r8, 64(%rbx)
	cmovsq	-40(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, 72(%rbx)
	cmovsq	-64(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, 48(%rbx)
	cmovsq	-56(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, 56(%rbx)
	movq	-96(%rsp), %r11                 # 8-byte Reload
	andq	%rax, %r11
	movq	-120(%rsp), %rcx                # 8-byte Reload
	andq	%rax, %rcx
	movq	-104(%rsp), %rsi                # 8-byte Reload
	andq	%rax, %rsi
	movq	-112(%rsp), %r8                 # 8-byte Reload
	andq	%rax, %r8
	andq	-128(%rsp), %rax                # 8-byte Folded Reload
	addq	%r14, %rdx
	movq	%rdx, (%rbx)
	movq	%r11, %rdx
	adcq	%r13, %rdx
	movq	%rdx, 8(%rbx)
	adcq	%r15, %rax
	movq	%rax, 16(%rbx)
	movq	%r8, %rax
	adcq	-80(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 24(%rbx)
	movq	%rsi, %rax
	adcq	-72(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 32(%rbx)
	movq	%rcx, %rax
	adcq	%r10, %rax
	movq	%rax, 40(%rbx)
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end107:
	.size	mcl_fp2_mul_xi_u1x9_6L, .Lfunc_end107-mcl_fp2_mul_xi_u1x9_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u1x9_6L       # -- Begin function mcl_fp2Dbl_mul_xi_u1x9_6L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u1x9_6L,@function
mcl_fp2Dbl_mul_xi_u1x9_6L:              # @mcl_fp2Dbl_mul_xi_u1x9_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$216, %rsp
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	movq	176(%rsi), %r8
	movq	184(%rsi), %r13
	movq	%r13, %rcx
	movq	%r13, 96(%rsp)                  # 8-byte Spill
	movq	%r8, 120(%rsp)                  # 8-byte Spill
	shldq	$1, %r8, %rcx
	movq	168(%rsi), %r11
	movq	%r11, 112(%rsp)                 # 8-byte Spill
	shldq	$1, %r11, %r8
	movq	40(%rdx), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	32(%rdx), %rbp
	movq	24(%rdx), %r10
	movq	%r10, -120(%rsp)                # 8-byte Spill
	movq	16(%rdx), %r9
	movq	%r9, -96(%rsp)                  # 8-byte Spill
	movq	(%rdx), %rdi
	movq	%rdi, -80(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %r15
	movq	%r15, -88(%rsp)                 # 8-byte Spill
	movq	160(%rsi), %rbx
	movq	%rbx, 104(%rsp)                 # 8-byte Spill
	shldq	$1, %rbx, %r11
	movq	152(%rsi), %r14
	movq	%r14, 88(%rsp)                  # 8-byte Spill
	shldq	$1, %r14, %rbx
	movq	144(%rsi), %r12
	movq	%r12, 72(%rsp)                  # 8-byte Spill
	shldq	$1, %r12, %r14
	movq	136(%rsi), %rax
	movq	%r12, %rsi
	shldq	$1, %rax, %rsi
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	shrq	$63, %r13
	movq	%rsi, %r12
	subq	%rdi, %r12
	movq	%r14, %rdx
	sbbq	%r15, %rdx
	movq	%rbx, %rdi
	sbbq	%r9, %rdi
	movq	%r11, %r9
	sbbq	%r10, %r9
	movq	%r8, %r10
	sbbq	%rbp, %r10
	movq	%rbp, -104(%rsp)                # 8-byte Spill
	movq	%rcx, %r15
	sbbq	-112(%rsp), %r15                # 8-byte Folded Reload
	sbbq	$0, %r13
	testb	$1, %r13b
	cmovneq	%rcx, %r15
	cmovneq	%r8, %r10
	cmovneq	%r11, %r9
	cmovneq	%rbx, %rdi
	cmovneq	%r14, %rdx
	cmovneq	%rsi, %r12
	leaq	(%rax,%rax), %rsi
	shrdq	$63, %r12, %rsi
	shrdq	$63, %rdx, %r12
	shrdq	$63, %rdi, %rdx
	shrdq	$63, %r9, %rdi
	shrdq	$63, %r10, %r9
	shrdq	$63, %r15, %r10
	shrq	$63, %r15
	movq	%rsi, %rcx
	movq	-80(%rsp), %r13                 # 8-byte Reload
	subq	%r13, %rcx
	movq	%r12, %r8
	sbbq	-88(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rdx, %r11
	sbbq	-96(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rdi, %rbx
	sbbq	-120(%rsp), %rbx                # 8-byte Folded Reload
	movq	%r9, %r14
	sbbq	%rbp, %r14
	movq	%r10, %rbp
	movq	-112(%rsp), %rax                # 8-byte Reload
	sbbq	%rax, %rbp
	sbbq	$0, %r15
	testb	$1, %r15b
	cmovneq	%r10, %rbp
	cmovneq	%r9, %r14
	cmovneq	%rdi, %rbx
	cmovneq	%rdx, %r11
	cmovneq	%r12, %r8
	cmovneq	%rsi, %rcx
	movq	64(%rsp), %r15                  # 8-byte Reload
	leaq	(,%r15,4), %rdx
	shrdq	$63, %rcx, %rdx
	shrdq	$63, %r8, %rcx
	shrdq	$63, %r11, %r8
	shrdq	$63, %rbx, %r11
	shrdq	$63, %r14, %rbx
	shrdq	$63, %rbp, %r14
	shrq	$63, %rbp
	movq	%rdx, %rax
	subq	%r13, %rax
	movq	%rax, %r10
	movq	%rcx, %rax
	sbbq	-88(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, %rsi
	movq	%r8, %rax
	sbbq	-96(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r11, %r12
	sbbq	-120(%rsp), %r12                # 8-byte Folded Reload
	movq	%rbx, %rdi
	sbbq	-104(%rsp), %rdi                # 8-byte Folded Reload
	movq	%r14, %r9
	sbbq	-112(%rsp), %r9                 # 8-byte Folded Reload
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%r14, %r9
	cmovneq	%rbx, %rdi
	cmovneq	%r11, %r12
	cmovneq	%r8, %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	cmovneq	%rcx, %rsi
	movq	%rsi, -72(%rsp)                 # 8-byte Spill
	cmovneq	%rdx, %r10
	movq	%r10, -56(%rsp)                 # 8-byte Spill
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	128(%rax), %r8
	movq	%r15, %r10
	shldq	$3, %r8, %r10
	movq	120(%rax), %rbx
	movq	%r8, %r11
	movq	%r8, 208(%rsp)                  # 8-byte Spill
	shldq	$3, %rbx, %r11
	movq	112(%rax), %rbp
	movq	%rbx, %r14
	movq	%rbx, 200(%rsp)                 # 8-byte Spill
	shldq	$3, %rbp, %r14
	movq	104(%rax), %rsi
	movq	%rsi, 184(%rsp)                 # 8-byte Spill
	movq	%rbp, %rcx
	movq	%rbp, 192(%rsp)                 # 8-byte Spill
	shldq	$3, %rsi, %rcx
	movq	96(%rax), %rdx
	movq	%rdx, 176(%rsp)                 # 8-byte Spill
	movq	%rsi, %rax
	shldq	$3, %rdx, %rax
	leaq	(,%rdx,8), %r13
	addq	%rdx, %r13
	movq	%r13, -40(%rsp)                 # 8-byte Spill
	adcq	%rsi, %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	adcq	%rbp, %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	adcq	%rbx, %r14
	movq	%r14, 48(%rsp)                  # 8-byte Spill
	adcq	%r8, %r11
	movq	%r11, 56(%rsp)                  # 8-byte Spill
	adcq	%r15, %r10
	movq	%r10, 32(%rsp)                  # 8-byte Spill
	movq	-56(%rsp), %rcx                 # 8-byte Reload
	adcq	72(%rsp), %rcx                  # 8-byte Folded Reload
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	adcq	88(%rsp), %rsi                  # 8-byte Folded Reload
	movq	-128(%rsp), %r11                # 8-byte Reload
	adcq	104(%rsp), %r11                 # 8-byte Folded Reload
	adcq	112(%rsp), %r12                 # 8-byte Folded Reload
	adcq	120(%rsp), %rdi                 # 8-byte Folded Reload
	adcq	96(%rsp), %r9                   # 8-byte Folded Reload
	setb	%bpl
	movq	%rcx, %rdx
	movq	%rcx, %rax
	subq	-80(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rsi, %rbx
	sbbq	-88(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r11, %r13
	sbbq	-96(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r12, %r8
	sbbq	-120(%rsp), %r8                 # 8-byte Folded Reload
	movq	%rdi, %r14
	sbbq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	%r9, %rcx
	sbbq	-112(%rsp), %rcx                # 8-byte Folded Reload
	movzbl	%bpl, %r15d
	sbbq	$0, %r15
	testb	$1, %r15b
	cmovneq	%r9, %rcx
	cmovneq	%rdi, %r14
	cmovneq	%r12, %r8
	cmovneq	%r11, %r13
	cmovneq	%rsi, %rbx
	cmovneq	%rax, %rdx
	movq	-48(%rsp), %rsi                 # 8-byte Reload
	movq	88(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	80(%rsi), %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	72(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %r10
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	48(%rsi), %r11
	movq	%r11, -24(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %rdi
	movq	%rdi, -64(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %rbp
	movq	%rbp, (%rsp)                    # 8-byte Spill
	movq	24(%rsi), %r12
	movq	%r12, 8(%rsp)                   # 8-byte Spill
	movq	16(%rsi), %r15
	movq	%r15, 16(%rsp)                  # 8-byte Spill
	movq	(%rsi), %r9
	movq	%r9, -32(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rsi
	movq	%rsi, 128(%rsp)                 # 8-byte Spill
	addq	%r9, -40(%rsp)                  # 8-byte Folded Spill
	adcq	%rsi, 40(%rsp)                  # 8-byte Folded Spill
	adcq	%r15, 24(%rsp)                  # 8-byte Folded Spill
	adcq	%r12, 48(%rsp)                  # 8-byte Folded Spill
	adcq	%rbp, 56(%rsp)                  # 8-byte Folded Spill
	adcq	%rdi, 32(%rsp)                  # 8-byte Folded Spill
	adcq	%r11, %rdx
	adcq	%rax, %rbx
	adcq	%r10, %r13
	adcq	-72(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %r14                # 8-byte Folded Reload
	adcq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	setb	%al
	movq	%rdx, %rsi
	subq	-80(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rbx, %r9
	movq	-88(%rsp), %rdi                 # 8-byte Reload
	sbbq	%rdi, %r9
	movq	%r9, %r10
	movq	%r13, %r9
	sbbq	-96(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r9, %r15
	movq	%r8, %r12
	sbbq	-120(%rsp), %r12                # 8-byte Folded Reload
	movq	%r14, %rbp
	sbbq	-104(%rsp), %rbp                # 8-byte Folded Reload
	movq	%rcx, %r11
	sbbq	-112(%rsp), %r11                # 8-byte Folded Reload
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%r14, %rbp
	movq	%rbp, 168(%rsp)                 # 8-byte Spill
	cmovneq	%rcx, %r11
	movq	%r11, 152(%rsp)                 # 8-byte Spill
	cmovneq	%rdx, %rsi
	movq	%rsi, -48(%rsp)                 # 8-byte Spill
	cmovneq	%rbx, %r10
	movq	%r10, 160(%rsp)                 # 8-byte Spill
	cmovneq	%r13, %r15
	movq	%r15, 144(%rsp)                 # 8-byte Spill
	cmovneq	%r8, %r12
	movq	%r12, 136(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rcx
	movq	-128(%rsp), %rsi                # 8-byte Reload
	shldq	$1, %rsi, %rcx
	movq	-72(%rsp), %r10                 # 8-byte Reload
	shldq	$1, %r10, %rsi
	movq	-8(%rsp), %r11                  # 8-byte Reload
	shldq	$1, %r11, %r10
	movq	-16(%rsp), %r15                 # 8-byte Reload
	shldq	$1, %r15, %r11
	movq	-24(%rsp), %r12                 # 8-byte Reload
	shldq	$1, %r12, %r15
	movq	-64(%rsp), %r9                  # 8-byte Reload
	shldq	$1, %r9, %r12
	shrq	$63, %rbp
	movq	%r12, %rax
	subq	-80(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sbbq	%rdi, %rdx
	movq	%r11, %rdi
	movq	-96(%rsp), %r13                 # 8-byte Reload
	sbbq	%r13, %rdi
	movq	%r10, %r8
	sbbq	-120(%rsp), %r8                 # 8-byte Folded Reload
	movq	%rsi, %r14
	sbbq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	%rcx, %rbx
	sbbq	-112(%rsp), %rbx                # 8-byte Folded Reload
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%rcx, %rbx
	cmovneq	%rsi, %r14
	cmovneq	%r10, %r8
	cmovneq	%r11, %rdi
	cmovneq	%r15, %rdx
	cmovneq	%r12, %rax
	leaq	(%r9,%r9), %r12
	shrdq	$63, %rax, %r12
	shrdq	$63, %rdx, %rax
	shrdq	$63, %rdi, %rdx
	shrdq	$63, %r8, %rdi
	shrdq	$63, %r14, %r8
	shrdq	$63, %rbx, %r14
	shrq	$63, %rbx
	movq	%r12, %rcx
	subq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rax, %rsi
	sbbq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rdx, %r10
	sbbq	%r13, %r10
	movq	%rdi, %r15
	sbbq	-120(%rsp), %r15                # 8-byte Folded Reload
	movq	%r8, %rbp
	sbbq	-104(%rsp), %rbp                # 8-byte Folded Reload
	movq	%r14, %r11
	movq	-112(%rsp), %r9                 # 8-byte Reload
	sbbq	%r9, %r11
	sbbq	$0, %rbx
	testb	$1, %bl
	cmovneq	%r14, %r11
	cmovneq	%r8, %rbp
	cmovneq	%rdi, %r15
	cmovneq	%rdx, %r10
	cmovneq	%rax, %rsi
	cmovneq	%r12, %rcx
	movq	-64(%rsp), %rax                 # 8-byte Reload
	leaq	(,%rax,4), %rax
	shrdq	$63, %rcx, %rax
	shrdq	$63, %rsi, %rcx
	shrdq	$63, %r10, %rsi
	shrdq	$63, %r15, %r10
	shrdq	$63, %rbp, %r15
	shrdq	$63, %r11, %rbp
	shrq	$63, %r11
	movq	%rax, %r13
	subq	-80(%rsp), %r13                 # 8-byte Folded Reload
	movq	%rcx, %r12
	sbbq	-88(%rsp), %r12                 # 8-byte Folded Reload
	movq	%rsi, %rdi
	sbbq	-96(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%r10, %r8
	sbbq	-120(%rsp), %r8                 # 8-byte Folded Reload
	movq	%r15, %rbx
	sbbq	-104(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rbp, %r14
	sbbq	%r9, %r14
	sbbq	$0, %r11
	testb	$1, %r11b
	cmovneq	%rbp, %r14
	cmovneq	%r15, %rbx
	cmovneq	%r10, %r8
	cmovneq	%rsi, %rdi
	cmovneq	%rcx, %r12
	cmovneq	%rax, %r13
	movq	-64(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	movq	(%rsp), %rcx                    # 8-byte Reload
	shldq	$3, %rcx, %rdx
	movq	8(%rsp), %r15                   # 8-byte Reload
	shldq	$3, %r15, %rcx
	movq	16(%rsp), %r11                  # 8-byte Reload
	shldq	$3, %r11, %r15
	movq	128(%rsp), %r9                  # 8-byte Reload
	shldq	$3, %r9, %r11
	movq	%r9, %rsi
	movq	-32(%rsp), %r10                 # 8-byte Reload
	shldq	$3, %r10, %rsi
	leaq	(,%r10,8), %rax
	addq	%r10, %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	adcq	%r9, %rsi
	movq	80(%rsp), %r9                   # 8-byte Reload
	movq	-40(%rsp), %r10                 # 8-byte Reload
	movq	%r10, 96(%r9)
	adcq	16(%rsp), %r11                  # 8-byte Folded Reload
	adcq	8(%rsp), %r15                   # 8-byte Folded Reload
	adcq	(%rsp), %rcx                    # 8-byte Folded Reload
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	adcq	%rbp, %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	adcq	-24(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-16(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-8(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	-72(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-128(%rsp), %rbx                # 8-byte Folded Reload
	adcq	-56(%rsp), %r14                 # 8-byte Folded Reload
	setb	%dl
	movq	%r13, %r10
	subq	-80(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r12, %r9
	sbbq	-88(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rdi, %rax
	sbbq	-96(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r8, %rcx
	sbbq	-120(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rbx, %rbp
	sbbq	-104(%rsp), %rbp                # 8-byte Folded Reload
	movq	%rbp, -128(%rsp)                # 8-byte Spill
	movq	%r14, %rbp
	sbbq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	%rbp, -72(%rsp)                 # 8-byte Spill
	movzbl	%dl, %ebp
	sbbq	$0, %rbp
	testb	$1, %bpl
	movq	-72(%rsp), %rbp                 # 8-byte Reload
	cmovneq	%r14, %rbp
	movq	-128(%rsp), %r14                # 8-byte Reload
	cmovneq	%rbx, %r14
	cmovneq	%r8, %rcx
	movq	%rcx, -128(%rsp)                # 8-byte Spill
	cmovneq	%rdi, %rax
	movq	%rax, %rbx
	cmovneq	%r12, %r9
	cmovneq	%r13, %r10
	xorl	%edx, %edx
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	subq	176(%rsp), %rcx                 # 8-byte Folded Reload
	sbbq	184(%rsp), %rsi                 # 8-byte Folded Reload
	movq	80(%rsp), %rdi                  # 8-byte Reload
	movq	%rcx, (%rdi)
	movq	40(%rsp), %r8                   # 8-byte Reload
	movq	%r8, 104(%rdi)
	sbbq	192(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rsi, 8(%rdi)
	movq	24(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 112(%rdi)
	sbbq	200(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r11, 16(%rdi)
	movq	48(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 120(%rdi)
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	sbbq	208(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r15, 24(%rdi)
	movq	56(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 128(%rdi)
	movq	-64(%rsp), %rcx                 # 8-byte Reload
	sbbq	64(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rsi, 32(%rdi)
	movq	32(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 136(%rdi)
	sbbq	72(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rcx, 40(%rdi)
	movq	%rdi, %rax
	sbbq	88(%rsp), %r9                   # 8-byte Folded Reload
	movq	%rbx, %r15
	sbbq	104(%rsp), %r15                 # 8-byte Folded Reload
	movq	-128(%rsp), %r11                # 8-byte Reload
	sbbq	112(%rsp), %r11                 # 8-byte Folded Reload
	sbbq	120(%rsp), %r14                 # 8-byte Folded Reload
	sbbq	96(%rsp), %rbp                  # 8-byte Folded Reload
	sbbq	%rdx, %rdx
	movq	-88(%rsp), %r8                  # 8-byte Reload
	andq	%rdx, %r8
	movq	-80(%rsp), %rbx                 # 8-byte Reload
	andq	%rdx, %rbx
	movq	-112(%rsp), %rcx                # 8-byte Reload
	andq	%rdx, %rcx
	movq	-104(%rsp), %rsi                # 8-byte Reload
	andq	%rdx, %rsi
	movq	-120(%rsp), %rdi                # 8-byte Reload
	andq	%rdx, %rdi
	andq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%r10, %rbx
	adcq	%r9, %r8
	movq	%rbx, 48(%rax)
	adcq	%r15, %rdx
	movq	%r8, 56(%rax)
	adcq	%r11, %rdi
	movq	%rdx, 64(%rax)
	movq	%rdi, 72(%rax)
	movq	152(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 184(%rax)
	movq	168(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 176(%rax)
	movq	136(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 168(%rax)
	movq	144(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 160(%rax)
	movq	160(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 152(%rax)
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	movq	%rdx, 144(%rax)
	movq	%rsi, %rdx
	adcq	%r14, %rdx
	movq	%rdx, 80(%rax)
	adcq	%rbp, %rcx
	movq	%rcx, 88(%rax)
	addq	$216, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end108:
	.size	mcl_fp2Dbl_mul_xi_u1x9_6L, .Lfunc_end108-mcl_fp2Dbl_mul_xi_u1x9_6L
                                        # -- End function
	.globl	mcl_fp2_mul_xi_u5x0_6L          # -- Begin function mcl_fp2_mul_xi_u5x0_6L
	.p2align	4
	.type	mcl_fp2_mul_xi_u5x0_6L,@function
mcl_fp2_mul_xi_u5x0_6L:                 # @mcl_fp2_mul_xi_u5x0_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r11
	movq	40(%rdx), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	(%rdx), %r15
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	48(%rsi), %r9
	movq	56(%rsi), %rbp
	movq	64(%rsi), %r13
	movq	72(%rsi), %r14
	movq	88(%rsi), %r10
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	movq	80(%rsi), %r12
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	40(%rsi), %rdx
	movq	32(%rsi), %rdi
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	%r8, 48(%r11)
	movq	%rsi, 56(%r11)
	movq	%rdi, 80(%r11)
	movq	%rdx, 88(%r11)
	movq	%rcx, 64(%r11)
	movq	%rax, 72(%r11)
	movq	%r12, %rsi
	movq	%r12, -16(%rsp)                 # 8-byte Spill
	shldq	$1, %r12, %r10
	movq	%r14, -24(%rsp)                 # 8-byte Spill
	shldq	$1, %r14, %rsi
	movq	%r13, %r12
	movq	%r13, -32(%rsp)                 # 8-byte Spill
	shldq	$1, %r13, %r14
	movq	%rbp, %r13
	movq	%rbp, -40(%rsp)                 # 8-byte Spill
	shldq	$1, %rbp, %r12
	movq	%r9, -48(%rsp)                  # 8-byte Spill
	shldq	$1, %r9, %r13
	leaq	(%r9,%r9), %rbx
	movq	%rbx, %rbp
	subq	%r15, %rbp
	movq	%r13, %r8
	movq	-64(%rsp), %r9                  # 8-byte Reload
	sbbq	%r9, %r8
	movq	%r12, %r15
	sbbq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r14, %rdx
	sbbq	-96(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rsi, %rdi
	sbbq	-80(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%r10, %rcx
	sbbq	-88(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, %rax
	sarq	$63, %rax
	cmovsq	%r13, %r8
	cmovsq	%r12, %r15
	cmovsq	%r14, %rdx
	cmovsq	%rsi, %rdi
	cmovsq	%r10, %rcx
	cmovsq	%rbx, %rbp
	shldq	$1, %rdi, %rcx
	shldq	$1, %rdx, %rdi
	shldq	$1, %r15, %rdx
	shldq	$1, %r8, %r15
	shldq	$1, %rbp, %r8
	addq	%rbp, %rbp
	movq	%rbp, %rax
	subq	-56(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r8, %r12
	sbbq	%r9, %r12
	movq	%r15, %r13
	movq	-72(%rsp), %rbx                 # 8-byte Reload
	sbbq	%rbx, %r13
	movq	%rdx, %r14
	sbbq	-96(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rdi, %r9
	sbbq	-80(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rcx, %rsi
	sbbq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, %r10
	sarq	$63, %r10
	cmovsq	%rcx, %rsi
	cmovsq	%rdi, %r9
	cmovsq	%rdx, %r14
	cmovsq	%r15, %r13
	cmovsq	%r8, %r12
	cmovsq	%rbp, %rax
	addq	-48(%rsp), %rax                 # 8-byte Folded Reload
	adcq	-40(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-32(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-24(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-16(%rsp), %r9                  # 8-byte Folded Reload
	adcq	-8(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rax, %rdx
	subq	-56(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r12, %rdi
	sbbq	-64(%rsp), %rdi                 # 8-byte Folded Reload
	movq	%r13, %r15
	sbbq	%rbx, %r15
	movq	%r14, %r8
	sbbq	-96(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r9, %rbp
	sbbq	-80(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rsi, %rcx
	sbbq	-88(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, %r10
	sarq	$63, %r10
	cmovsq	%rsi, %rcx
	cmovsq	%r9, %rbp
	cmovsq	%r14, %r8
	cmovsq	%r13, %r15
	cmovsq	%r12, %rdi
	cmovsq	%rax, %rdx
	movq	%rdx, %rax
	addq	$-1, %rax
	movq	%rdi, %rax
	adcq	$-1, %rax
	movq	%r15, %rax
	adcq	$-1, %rax
	movq	%r8, %rax
	adcq	$-1, %rax
	movq	%rbp, %rax
	adcq	$-1, %rax
	movq	%rcx, %rax
	adcq	$-1, %rax
	xorl	%esi, %esi
	sarq	$63, %rax
	movq	-64(%rsp), %r12                 # 8-byte Reload
	cmovsq	%rsi, %r12
	movq	-56(%rsp), %rbx                 # 8-byte Reload
	cmovsq	%rsi, %rbx
	movq	-88(%rsp), %rax                 # 8-byte Reload
	cmovsq	%rsi, %rax
	movq	-80(%rsp), %r9                  # 8-byte Reload
	cmovsq	%rsi, %r9
	movq	-96(%rsp), %r10                 # 8-byte Reload
	cmovsq	%rsi, %r10
	movq	-72(%rsp), %r14                 # 8-byte Reload
	cmovsq	%rsi, %r14
	subq	%rdx, %rbx
	movq	%rbx, (%r11)
	sbbq	%rdi, %r12
	movq	%r12, 8(%r11)
	sbbq	%r15, %r14
	movq	%r14, 16(%r11)
	sbbq	%r8, %r10
	movq	%r10, 24(%r11)
	movq	%r9, %rdx
	sbbq	%rbp, %rdx
	movq	%rdx, 32(%r11)
	sbbq	%rcx, %rax
	movq	%rax, 40(%r11)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end109:
	.size	mcl_fp2_mul_xi_u5x0_6L, .Lfunc_end109-mcl_fp2_mul_xi_u5x0_6L
                                        # -- End function
	.globl	mcl_fp2Dbl_mul_xi_u5x0_6L       # -- Begin function mcl_fp2Dbl_mul_xi_u5x0_6L
	.p2align	4
	.type	mcl_fp2Dbl_mul_xi_u5x0_6L,@function
mcl_fp2Dbl_mul_xi_u5x0_6L:              # @mcl_fp2Dbl_mul_xi_u5x0_6L
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rbp
	movq	96(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	104(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	112(%rsi), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	120(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rdx), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	32(%rdx), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	24(%rdx), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	16(%rdx), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	(%rdx), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	128(%rsi), %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	136(%rsi), %rdi
	movq	144(%rsi), %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	152(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	160(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	168(%rsi), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	184(%rsi), %r13
	movq	176(%rsi), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rax
	movq	24(%rsi), %rcx
	movq	32(%rsi), %rdx
	movq	40(%rsi), %r8
	movq	48(%rsi), %r9
	movq	56(%rsi), %r10
	movq	64(%rsi), %r11
	movq	72(%rsi), %rbx
	movq	80(%rsi), %r14
	movq	88(%rsi), %r15
	movq	(%rsi), %r12
	movq	8(%rsi), %rsi
	movq	%rsi, 104(%rbp)
	movq	%r12, 96(%rbp)
	movq	%r15, 184(%rbp)
	movq	%r14, 176(%rbp)
	movq	%rbx, 168(%rbp)
	movq	%r11, 160(%rbp)
	movq	%r10, 152(%rbp)
	movq	%r9, 144(%rbp)
	movq	%r8, 136(%rbp)
	movq	%rdx, 128(%rbp)
	movq	%rcx, 120(%rbp)
	movq	%rax, 112(%rbp)
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	movq	%r13, %rax
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	shldq	$1, %rcx, %rax
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	shldq	$1, %rdx, %rcx
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	shldq	$1, %rsi, %rdx
	movq	-48(%rsp), %r9                  # 8-byte Reload
	shldq	$1, %r9, %rsi
	movq	-128(%rsp), %r12                # 8-byte Reload
	shldq	$1, %r12, %r9
	shldq	$1, %rdi, %r12
	shrq	$63, %r13
	movq	%r12, %r10
	subq	-112(%rsp), %r10                # 8-byte Folded Reload
	movq	%r9, %r11
	sbbq	-96(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rsi, %rbx
	sbbq	-88(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	-104(%rsp), %r14                # 8-byte Folded Reload
	movq	%rcx, %r15
	sbbq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%rax, %r8
	sbbq	-80(%rsp), %r8                  # 8-byte Folded Reload
	sbbq	$0, %r13
	testb	$1, %r13b
	cmovneq	%rax, %r8
	cmovneq	%rcx, %r15
	cmovneq	%rdx, %r14
	cmovneq	%rsi, %rbx
	cmovneq	%r9, %r11
	cmovneq	%r12, %r10
	leaq	(%rdi,%rdi), %r9
	movq	%rdi, %rsi
	shrdq	$63, %r10, %r9
	shrdq	$63, %r11, %r10
	shrdq	$63, %rbx, %r11
	shrdq	$63, %r14, %rbx
	shrdq	$63, %r15, %r14
	shrdq	$63, %r8, %r15
	shrq	$63, %r8
	movq	%r9, %r12
	subq	-112(%rsp), %r12                # 8-byte Folded Reload
	movq	%r10, %rax
	sbbq	-96(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, %rcx
	movq	%r11, %rax
	sbbq	-88(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, %rdx
	movq	%rbx, %rax
	sbbq	-104(%rsp), %rax                # 8-byte Folded Reload
	movq	%r14, %r13
	sbbq	-72(%rsp), %r13                 # 8-byte Folded Reload
	movq	%r15, %rdi
	sbbq	-80(%rsp), %rdi                 # 8-byte Folded Reload
	sbbq	$0, %r8
	testb	$1, %r8b
	cmovneq	%r15, %rdi
	cmovneq	%r14, %r13
	cmovneq	%rbx, %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	cmovneq	%r11, %rdx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	cmovneq	%r10, %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	cmovneq	%r9, %r12
	movq	%rsi, %r15
	movq	%rsi, %rbx
	movq	-120(%rsp), %rsi                # 8-byte Reload
	shldq	$2, %rsi, %rbx
	movq	24(%rsp), %r8                   # 8-byte Reload
	shldq	$2, %r8, %rsi
	movq	%r8, %rdx
	movq	32(%rsp), %r9                   # 8-byte Reload
	shldq	$2, %r9, %rdx
	movq	%r9, %rcx
	movq	-64(%rsp), %r10                 # 8-byte Reload
	shldq	$2, %r10, %rcx
	movq	%r10, %r14
	movq	-56(%rsp), %r11                 # 8-byte Reload
	shldq	$2, %r11, %r14
	leaq	(,%r11,4), %rax
	addq	%r11, %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	adcq	%r10, %r14
	adcq	%r9, %rcx
	movq	%rcx, -64(%rsp)                 # 8-byte Spill
	adcq	%r8, %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	adcq	-120(%rsp), %rsi                # 8-byte Folded Reload
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	adcq	%r15, %rbx
	movq	%rbx, %rdx
	adcq	-128(%rsp), %r12                # 8-byte Folded Reload
	movq	%r12, -128(%rsp)                # 8-byte Spill
	movq	-16(%rsp), %rax                 # 8-byte Reload
	adcq	-48(%rsp), %rax                 # 8-byte Folded Reload
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	adcq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	movq	(%rsp), %rsi                    # 8-byte Reload
	adcq	-32(%rsp), %rsi                 # 8-byte Folded Reload
	adcq	-24(%rsp), %r13                 # 8-byte Folded Reload
	adcq	16(%rsp), %rdi                  # 8-byte Folded Reload
	setb	%r15b
	movq	%r12, %rbx
	subq	-112(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rax, %r12
	sbbq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	%rcx, %r11
	sbbq	-88(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rsi, %r10
	sbbq	-104(%rsp), %r10                # 8-byte Folded Reload
	movq	%r13, %r9
	sbbq	-72(%rsp), %r9                  # 8-byte Folded Reload
	movq	%rdi, %r8
	sbbq	-80(%rsp), %r8                  # 8-byte Folded Reload
	movzbl	%r15b, %r15d
	sbbq	$0, %r15
	testb	$1, %r15b
	cmovneq	%rdi, %r8
	cmovneq	%r13, %r9
	cmovneq	%rsi, %r10
	cmovneq	%rcx, %r11
	cmovneq	%rax, %r12
	cmovneq	-128(%rsp), %rbx                # 8-byte Folded Reload
	xorl	%eax, %eax
	movq	8(%rsp), %rcx                   # 8-byte Reload
	negq	%rcx
	movq	%rcx, (%rbp)
	movl	$0, %ecx
	sbbq	%r14, %rcx
	movq	%rcx, 8(%rbp)
	movl	$0, %ecx
	sbbq	-64(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, 16(%rbp)
	movl	$0, %ecx
	sbbq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%rcx, 24(%rbp)
	movl	$0, %ecx
	sbbq	-120(%rsp), %rcx                # 8-byte Folded Reload
	movq	%rcx, 32(%rbp)
	movl	$0, %ecx
	sbbq	%rdx, %rcx
	movq	%rcx, 40(%rbp)
	movl	$0, %r13d
	sbbq	%rbx, %r13
	movl	$0, %ebx
	sbbq	%r12, %rbx
	movl	$0, %r14d
	sbbq	%r11, %r14
	movl	$0, %r11d
	sbbq	%r10, %r11
	movl	$0, %edx
	sbbq	%r9, %rdx
	movl	$0, %ecx
	sbbq	%r8, %rcx
	sbbq	%rax, %rax
	movq	-96(%rsp), %r15                 # 8-byte Reload
	andq	%rax, %r15
	movq	-112(%rsp), %r12                # 8-byte Reload
	andq	%rax, %r12
	movq	-80(%rsp), %r8                  # 8-byte Reload
	andq	%rax, %r8
	movq	-72(%rsp), %r9                  # 8-byte Reload
	andq	%rax, %r9
	movq	-104(%rsp), %r10                # 8-byte Reload
	andq	%rax, %r10
	andq	-88(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r13, %r12
	movq	%r12, 48(%rbp)
	adcq	%rbx, %r15
	movq	%r15, 56(%rbp)
	adcq	%r14, %rax
	movq	%rax, 64(%rbp)
	movq	%r10, %rax
	adcq	%r11, %rax
	movq	%rax, 72(%rbp)
	movq	%r9, %rax
	adcq	%rdx, %rax
	movq	%rax, 80(%rbp)
	movq	%r8, %rax
	adcq	%rcx, %rax
	movq	%rax, 88(%rbp)
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end110:
	.size	mcl_fp2Dbl_mul_xi_u5x0_6L, .Lfunc_end110-mcl_fp2Dbl_mul_xi_u5x0_6L
                                        # -- End function
	.globl	mcl_c0_fp_add                   # -- Begin function mcl_c0_fp_add
	.p2align	4
	.type	mcl_c0_fp_add,@function
mcl_c0_fp_add:                          # @mcl_c0_fp_add
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	addq	(%rdx), %r8
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %rcx
	adcq	24(%rdx), %rax
	movq	%r8, %rdx
	subq	.Lmcl_c0_fp_p$local(%rip), %rdx
	movq	%rsi, %r9
	sbbq	.Lmcl_c0_fp_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c0_fp_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c0_fp_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end111:
	.size	mcl_c0_fp_add, .Lfunc_end111-mcl_c0_fp_add
                                        # -- End function
	.globl	mcl_c0_fp_sub                   # -- Begin function mcl_c0_fp_sub
	.p2align	4
	.type	mcl_c0_fp_sub,@function
mcl_c0_fp_sub:                          # @mcl_c0_fp_sub
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	sbbq	24(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	movq	.Lmcl_c0_fp_p$local+24(%rip), %r9
	andq	%rdx, %r9
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r10
	andq	%rdx, %r10
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r11
	andq	%rdx, %r11
	andq	.Lmcl_c0_fp_p$local(%rip), %rdx
	addq	%r8, %rdx
	movq	%rdx, (%rdi)
	adcq	%rsi, %r11
	movq	%r11, 8(%rdi)
	adcq	%rcx, %r10
	movq	%r10, 16(%rdi)
	adcq	%rax, %r9
	movq	%r9, 24(%rdi)
	retq
.Lfunc_end112:
	.size	mcl_c0_fp_sub, .Lfunc_end112-mcl_c0_fp_sub
                                        # -- End function
	.globl	mcl_c0_fp_neg                   # -- Begin function mcl_c0_fp_neg
	.p2align	4
	.type	mcl_c0_fp_neg,@function
mcl_c0_fp_neg:                          # @mcl_c0_fp_neg
# %bb.0:                                # %L57
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r9
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r10
	movq	.Lmcl_c0_fp_p$local(%rip), %r11
	subq	%r8, %r11
	sbbq	%rsi, %r10
	sbbq	%rdx, %r9
	sbbq	%rcx, %rax
	orq	%rcx, %rsi
	orq	%rdx, %r8
	xorl	%ecx, %ecx
	orq	%rsi, %r8
	cmoveq	%rcx, %r11
	movq	%r11, (%rdi)
	cmoveq	%rcx, %r10
	movq	%r10, 8(%rdi)
	cmoveq	%rcx, %r9
	movq	%r9, 16(%rdi)
	cmoveq	%rcx, %rax
	movq	%rax, 24(%rdi)
	retq
.Lfunc_end113:
	.size	mcl_c0_fp_neg, .Lfunc_end113-mcl_c0_fp_neg
                                        # -- End function
	.globl	mcl_c0_fp_mul2                  # -- Begin function mcl_c0_fp_mul2
	.p2align	4
	.type	mcl_c0_fp_mul2,@function
mcl_c0_fp_mul2:                         # @mcl_c0_fp_mul2
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %rdx
	movq	8(%rsi), %r8
	addq	(%rsi), %rdx
	adcq	8(%rsi), %r8
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rax
	movq	%rdx, %rsi
	subq	.Lmcl_c0_fp_p$local(%rip), %rsi
	movq	%r8, %r9
	sbbq	.Lmcl_c0_fp_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c0_fp_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c0_fp_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%rdx, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r8, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end114:
	.size	mcl_c0_fp_mul2, .Lfunc_end114-mcl_c0_fp_mul2
                                        # -- End function
	.globl	mcl_c0_fp_mul                   # -- Begin function mcl_c0_fp_mul
	.p2align	4
	.type	mcl_c0_fp_mul,@function
mcl_c0_fp_mul:                          # @mcl_c0_fp_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rax
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r11
	movq	(%rax), %rax
	mulxq	%rax, %r10, %rdi
	movq	.Lmcl_c0_fp_rp$local(%rip), %r9
	movq	%r9, -88(%rsp)                  # 8-byte Spill
	imulq	%r10, %r9
	movq	.Lmcl_c0_fp_p$local(%rip), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r8, %rcx
	addq	%rdi, %rcx
	movq	.Lmcl_c0_fp_p$local+8(%rip), %rdi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	movq	%r11, %rdx
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, %rdx
	mulxq	%r9, %r13, %rdi
	adcq	%r14, %rdi
	movq	16(%rsi), %rdx
	movq	%rdx, %r14
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbx, %r15
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r9, %rbp, %r12
	adcq	%r15, %r12
	movq	24(%rsi), %r15
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r9, %rsi
	movq	%r15, %rdx
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %rdx
	adcq	%rsi, %rdx
	addq	%r10, %r8
	adcq	-32(%rsp), %r13                 # 8-byte Folded Reload
	adcq	%rbx, %rbp
	adcq	%r9, %rax
	setb	%sil
	addq	%rcx, %r13
	adcq	%rdi, %rbp
	adcq	%r12, %rax
	movzbl	%sil, %r9d
	adcq	%rdx, %r9
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	%r11, %rdi, %rsi
	mulxq	-96(%rsp), %r10, %rcx           # 8-byte Folded Reload
	addq	%rdi, %rcx
	mulxq	%r14, %rdi, %rbx
	adcq	%rsi, %rdi
	mulxq	%r15, %r8, %rsi
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%r13, %r10
	adcq	%rbp, %rcx
	adcq	%rax, %rdi
	adcq	%r9, %r8
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	-16(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r9, %rax
	addq	%r10, %r9
	movq	-24(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r9, %r10
	adcq	%rcx, %r9
	movq	-64(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %rcx, %rbx
	adcq	%rdi, %rcx
	movq	-72(%rsp), %r15                 # 8-byte Reload
	mulxq	%r15, %rbp, %rdx
	adcq	%r8, %rbp
	adcq	$0, %rsi
	addq	%rax, %r9
	adcq	%r10, %rcx
	adcq	%rbx, %rbp
	adcq	%rdx, %rsi
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rdx
	mulxq	-40(%rsp), %r8, %rax            # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%r8, %rdi
	mulxq	-48(%rsp), %r8, %rbx            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%rbx, %rax
	adcq	$0, %r13
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%rsi, %rax
	adcq	$0, %r13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	mulxq	%r12, %rcx, %rsi
	addq	%r10, %rcx
	mulxq	%r11, %r9, %r10
	adcq	%rdi, %r9
	mulxq	%r14, %rcx, %rdi
	adcq	%r8, %rcx
	mulxq	%r15, %rbp, %rdx
	adcq	%rax, %rbp
	adcq	$0, %r13
	addq	%rsi, %r9
	adcq	%r10, %rcx
	adcq	%rdi, %rbp
	adcq	%rdx, %r13
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-40(%rsp), %rsi, %rax           # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%rsi, %rdi
	mulxq	-48(%rsp), %r8, %r14            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	adcq	%r14, %rbx
	adcq	$0, %rsi
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%r13, %rbx
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	%r12, %r14
	mulxq	%r12, %rax, %rcx
	addq	%r10, %rax
	movq	%r11, %r15
	mulxq	%r11, %rax, %r9
	adcq	%rdi, %rax
	movq	-64(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r10, %rdi
	adcq	%r8, %r10
	movq	-72(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r8, %rdx
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r9, %r10
	adcq	%rdi, %r8
	adcq	%rdx, %rsi
	movq	%rax, %rcx
	subq	%r14, %rcx
	movq	%r10, %rdx
	sbbq	%r15, %rdx
	movq	%r8, %rdi
	sbbq	%r12, %rdi
	movq	%rsi, %r9
	sbbq	%r11, %r9
	cmovsq	%r10, %rdx
	movq	-8(%rsp), %r10                  # 8-byte Reload
	movq	%rdx, 8(%r10)
	cmovsq	%r8, %rdi
	movq	%rdi, 16(%r10)
	cmovsq	%rsi, %r9
	movq	%r9, 24(%r10)
	cmovsq	%rax, %rcx
	movq	%rcx, (%r10)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end115:
	.size	mcl_c0_fp_mul, .Lfunc_end115-mcl_c0_fp_mul
                                        # -- End function
	.globl	mcl_c0_fp_sqr                   # -- Begin function mcl_c0_fp_sqr
	.p2align	4
	.type	mcl_c0_fp_sqr,@function
mcl_c0_fp_sqr:                          # @mcl_c0_fp_sqr
# %bb.0:
	movq	%rsi, %rdx
	jmp	mcl_c0_fp_mul@PLT               # TAILCALL
.Lfunc_end116:
	.size	mcl_c0_fp_sqr, .Lfunc_end116-mcl_c0_fp_sqr
                                        # -- End function
	.globl	mcl_c0_fpDbl_mod                # -- Begin function mcl_c0_fpDbl_mod
	.p2align	4
	.type	mcl_c0_fpDbl_mod,@function
mcl_c0_fpDbl_mod:                       # @mcl_c0_fpDbl_mod
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	.Lmcl_c0_fp_rp$local(%rip), %r10
	movq	%r10, %rdi
	imulq	%rax, %rdi
	movq	.Lmcl_c0_fp_p$local+8(%rip), %rbp
	movq	%rbp, %rdx
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r11, %rsi
	movq	.Lmcl_c0_fp_p$local(%rip), %rcx
	movq	%rcx, %rdx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r14, %rbx
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r8
	addq	%r11, %rbx
	movq	%r8, %rdx
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	mulxq	%rdi, %r12, %r11
	adcq	%rsi, %r12
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdi, %r13
	adcq	%r11, %rdi
	adcq	$0, %r13
	addq	%rax, %r14
	adcq	8(%r9), %rbx
	adcq	16(%r9), %r12
	adcq	24(%r9), %rdi
	adcq	32(%r9), %r13
	setb	%al
	movq	%r10, %r11
	imulq	%rbx, %r11
	movq	%rcx, %rdx
	mulxq	%r11, %rcx, %r15
	movq	%rbp, %rdx
	mulxq	%r11, %r14, %rbp
	addq	%r15, %r14
	movq	%r8, %rdx
	mulxq	%r11, %r15, %r8
	adcq	%rbp, %r15
	movq	%r11, %rdx
	mulxq	%rsi, %rbp, %rdx
	adcq	%r8, %rbp
	movzbl	%al, %eax
	adcq	%rdx, %rax
	addq	%rbx, %rcx
	adcq	%r12, %r14
	adcq	%rdi, %r15
	adcq	%r13, %rbp
	adcq	40(%r9), %rax
	setb	-41(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %r11
	imulq	%r14, %r11
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rdx
	mulxq	%r11, %r8, %rdi
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rbx, %r13
	addq	%rdi, %rbx
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rdi
	adcq	%r13, %r12
	movq	%r11, %rdx
	mulxq	-24(%rsp), %r11, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %r11
	movzbl	-41(%rsp), %r13d                # 1-byte Folded Reload
	adcq	%rdx, %r13
	addq	%r14, %r8
	adcq	%r15, %rbx
	adcq	%rbp, %r12
	adcq	%rax, %r11
	adcq	48(%r9), %r13
	setb	-41(%rsp)                       # 1-byte Folded Spill
	imulq	%rbx, %r10
	movq	%rcx, %rdx
	mulxq	%r10, %r8, %rdi
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	mulxq	%r10, %rax, %r14
	addq	%rdi, %rax
	movq	%rsi, %rdx
	mulxq	%r10, %rdi, %r15
	adcq	%r14, %rdi
	movq	%r10, %rdx
	movq	-24(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %r10, %rdx
	adcq	%r15, %r10
	movzbl	-41(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	%rdx, %rcx
	addq	%rbx, %r8
	adcq	%r12, %rax
	adcq	%r11, %rdi
	adcq	%r13, %r10
	adcq	56(%r9), %rcx
	movq	%rax, %rdx
	subq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdi, %rsi
	sbbq	%rbp, %rsi
	movq	%r10, %r8
	sbbq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, %r11
	sbbq	%r14, %r11
	cmovsq	%r10, %r8
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%r8, 16(%r9)
	cmovsq	%rcx, %r11
	movq	%r11, 24(%r9)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r9)
	cmovsq	%rdi, %rsi
	movq	%rsi, 8(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end117:
	.size	mcl_c0_fpDbl_mod, .Lfunc_end117-mcl_c0_fpDbl_mod
                                        # -- End function
	.p2align	4                               # -- Begin function mcl_c0_fpDbl_mulPre
	.type	.Lmcl_c0_fpDbl_mulPre,@function
.Lmcl_c0_fpDbl_mulPre:                  # @mcl_c0_fpDbl_mulPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r8
	movq	8(%rsi), %rcx
	movq	(%rdx), %r10
	movq	%r8, %rdx
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulxq	%r10, %rbx, %r11
	movq	16(%rsi), %rax
	movq	24(%rsi), %r9
	movq	%rbx, (%rdi)
	movq	%r9, %rdx
	mulxq	%r10, %rbx, %r14
	movq	%rcx, %rdx
	movq	%rcx, %rsi
	mulxq	%r10, %r12, %r15
	addq	%r11, %r12
	movq	%rax, %rdx
	movq	%rax, %rbp
	mulxq	%r10, %r10, %r13
	adcq	%r15, %r10
	adcq	%rbx, %r13
	adcq	$0, %r14
	setb	%bl
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	%r8, %rax, %r8
	movq	%r8, -24(%rsp)                  # 8-byte Spill
	addq	%r12, %rax
	mulxq	%rsi, %r11, %r12
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	adcq	%r10, %r11
	mulxq	%rbp, %r15, %r10
	movq	%rbp, %r8
	movq	%rbp, -8(%rsp)                  # 8-byte Spill
	adcq	%r13, %r15
	mulxq	%r9, %r13, %rdx
	adcq	%r14, %r13
	movzbl	%bl, %ebp
	adcq	$0, %rbp
	addq	-24(%rsp), %r11                 # 8-byte Folded Reload
	adcq	%r12, %r15
	movq	%rax, 8(%rdi)
	adcq	%r10, %r13
	adcq	%rdx, %rbp
	movq	16(%rcx), %rdx
	mulxq	%rsi, %r10, %r12
	mulxq	-32(%rsp), %rax, %rbx           # 8-byte Folded Reload
	addq	%r10, %rbx
	mulxq	%r8, %r14, %rcx
	adcq	%r12, %r14
	movq	%r9, %rsi
	mulxq	%r9, %r12, %r10
	adcq	%rcx, %r12
	adcq	$0, %r10
	addq	%r11, %rax
	adcq	%r15, %rbx
	movq	%rax, 16(%rdi)
	adcq	%r13, %r14
	adcq	%rbp, %r12
	adcq	$0, %r10
	movq	-40(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-16(%rsp), %rcx, %rax           # 8-byte Folded Reload
	mulxq	-32(%rsp), %r8, %r9             # 8-byte Folded Reload
	addq	%rcx, %r9
	mulxq	%rsi, %rcx, %rsi
	mulxq	-8(%rsp), %rdx, %r11            # 8-byte Folded Reload
	adcq	%rax, %rdx
	adcq	%rcx, %r11
	adcq	$0, %rsi
	addq	%rbx, %r8
	movq	%r8, 24(%rdi)
	adcq	%r14, %r9
	movq	%r9, 32(%rdi)
	adcq	%r12, %rdx
	movq	%rdx, 40(%rdi)
	adcq	%r10, %r11
	movq	%r11, 48(%rdi)
	adcq	$0, %rsi
	movq	%rsi, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end118:
	.size	.Lmcl_c0_fpDbl_mulPre, .Lfunc_end118-.Lmcl_c0_fpDbl_mulPre
                                        # -- End function
	.globl	mcl_c0_fpDbl_add                # -- Begin function mcl_c0_fpDbl_add
	.p2align	4
	.type	mcl_c0_fpDbl_add,@function
mcl_c0_fpDbl_add:                       # @mcl_c0_fpDbl_add
# %bb.0:
	pushq	%rbx
	movq	56(%rdx), %r8
	movq	48(%rdx), %r9
	movq	40(%rdx), %rax
	movq	32(%rdx), %rcx
	movq	24(%rdx), %r10
	movq	16(%rdx), %r11
	movq	(%rdx), %rbx
	movq	8(%rdx), %rdx
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rdx
	adcq	16(%rsi), %r11
	adcq	24(%rsi), %r10
	adcq	32(%rsi), %rcx
	adcq	40(%rsi), %rax
	adcq	48(%rsi), %r9
	adcq	56(%rsi), %r8
	movq	%r10, 24(%rdi)
	movq	%rbx, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	%r11, 16(%rdi)
	setb	%dl
	movzbl	%dl, %edx
	movq	%rcx, %rsi
	subq	.Lmcl_c0_fp_p$local(%rip), %rsi
	movq	%rax, %r10
	sbbq	.Lmcl_c0_fp_p$local+8(%rip), %r10
	movq	%r9, %r11
	sbbq	.Lmcl_c0_fp_p$local+16(%rip), %r11
	movq	%r8, %rbx
	sbbq	.Lmcl_c0_fp_p$local+24(%rip), %rbx
	sbbq	$0, %rdx
	testb	$1, %dl
	cmovneq	%r9, %r11
	movq	%r11, 48(%rdi)
	cmovneq	%r8, %rbx
	movq	%rbx, 56(%rdi)
	cmovneq	%rcx, %rsi
	movq	%rsi, 32(%rdi)
	cmovneq	%rax, %r10
	movq	%r10, 40(%rdi)
	popq	%rbx
	retq
.Lfunc_end119:
	.size	mcl_c0_fpDbl_add, .Lfunc_end119-mcl_c0_fpDbl_add
                                        # -- End function
	.globl	mcl_c0_fpDbl_sub                # -- Begin function mcl_c0_fpDbl_sub
	.p2align	4
	.type	mcl_c0_fpDbl_sub,@function
mcl_c0_fpDbl_sub:                       # @mcl_c0_fpDbl_sub
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	56(%rsi), %rax
	movq	48(%rsi), %rcx
	movq	40(%rsi), %r8
	movq	32(%rsi), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	xorl	%esi, %esi
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %r14
	sbbq	16(%rdx), %r11
	sbbq	24(%rdx), %r10
	sbbq	32(%rdx), %r9
	sbbq	40(%rdx), %r8
	sbbq	48(%rdx), %rcx
	sbbq	56(%rdx), %rax
	movq	%r10, 24(%rdi)
	movq	%rbx, (%rdi)
	movq	%r14, 8(%rdi)
	movq	%r11, 16(%rdi)
	sbbq	%rsi, %rsi
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rdx
	andq	%rsi, %rdx
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r10
	andq	%rsi, %r10
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r11
	andq	%rsi, %r11
	andq	.Lmcl_c0_fp_p$local(%rip), %rsi
	addq	%r9, %rsi
	movq	%rsi, 32(%rdi)
	adcq	%r8, %r11
	movq	%r11, 40(%rdi)
	adcq	%rcx, %r10
	movq	%r10, 48(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 56(%rdi)
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end120:
	.size	mcl_c0_fpDbl_sub, .Lfunc_end120-mcl_c0_fpDbl_sub
                                        # -- End function
	.globl	mcl_c0_fp2_add                  # -- Begin function mcl_c0_fp2_add
	.p2align	4
	.type	mcl_c0_fp2_add,@function
mcl_c0_fp2_add:                         # @mcl_c0_fp2_add
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rcx
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r8
	movq	.Lmcl_c0_fp_p$local(%rip), %r9
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	addq	(%rdx), %rbx
	adcq	8(%rdx), %r14
	adcq	16(%rdx), %r11
	adcq	24(%rdx), %r10
	movq	%rbx, %r15
	subq	%r9, %r15
	movq	%r14, %r12
	sbbq	%r8, %r12
	movq	%r11, %r13
	sbbq	%rcx, %r13
	movq	%r10, %rbp
	sbbq	%rax, %rbp
	cmovsq	%r14, %r12
	movq	%r12, 8(%rdi)
	cmovsq	%r11, %r13
	movq	%r13, 16(%rdi)
	cmovsq	%r10, %rbp
	movq	%rbp, 24(%rdi)
	cmovsq	%rbx, %r15
	movq	%r15, (%rdi)
	movq	72(%rsi), %r10
	movq	64(%rsi), %r11
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	addq	48(%rdx), %rbx
	adcq	56(%rdx), %rsi
	adcq	64(%rdx), %r11
	adcq	72(%rdx), %r10
	movq	%rbx, %rdx
	subq	%r9, %rdx
	movq	%rsi, %r9
	sbbq	%r8, %r9
	movq	%r11, %r8
	sbbq	%rcx, %r8
	movq	%r10, %rcx
	sbbq	%rax, %rcx
	cmovsq	%r11, %r8
	movq	%r8, 64(%rdi)
	cmovsq	%r10, %rcx
	movq	%rcx, 72(%rdi)
	cmovsq	%rbx, %rdx
	movq	%rdx, 48(%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end121:
	.size	mcl_c0_fp2_add, .Lfunc_end121-mcl_c0_fp2_add
                                        # -- End function
	.globl	mcl_c0_fp2_sub                  # -- Begin function mcl_c0_fp2_sub
	.p2align	4
	.type	mcl_c0_fp2_sub,@function
mcl_c0_fp2_sub:                         # @mcl_c0_fp2_sub
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	.Lmcl_c0_fp_p$local(%rip), %r9
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r8
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rcx
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	24(%rsi), %r10
	movq	16(%rsi), %r11
	movq	(%rsi), %rbx
	movq	8(%rsi), %r14
	subq	(%rdx), %rbx
	sbbq	8(%rdx), %r14
	sbbq	16(%rdx), %r11
	sbbq	24(%rdx), %r10
	movq	%r10, %r15
	sarq	$63, %r15
	movq	%r15, %r12
	andq	%rax, %r12
	movq	%r15, %r13
	andq	%rcx, %r13
	movq	%r15, %rbp
	andq	%r8, %rbp
	andq	%r9, %r15
	addq	%rbx, %r15
	adcq	%r14, %rbp
	movq	%r15, (%rdi)
	movq	%rbp, 8(%rdi)
	adcq	%r11, %r13
	movq	%r13, 16(%rdi)
	adcq	%r10, %r12
	movq	%r12, 24(%rdi)
	movq	72(%rsi), %r10
	movq	64(%rsi), %r11
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	subq	48(%rdx), %rbx
	sbbq	56(%rdx), %rsi
	sbbq	64(%rdx), %r11
	sbbq	72(%rdx), %r10
	movq	%r10, %rdx
	sarq	$63, %rdx
	andq	%rdx, %rax
	andq	%rdx, %rcx
	andq	%rdx, %r8
	andq	%r9, %rdx
	addq	%rbx, %rdx
	movq	%rdx, 48(%rdi)
	adcq	%rsi, %r8
	movq	%r8, 56(%rdi)
	adcq	%r11, %rcx
	movq	%rcx, 64(%rdi)
	adcq	%r10, %rax
	movq	%rax, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end122:
	.size	mcl_c0_fp2_sub, .Lfunc_end122-mcl_c0_fp2_sub
                                        # -- End function
	.globl	mcl_c0_fp2_neg                  # -- Begin function mcl_c0_fp2_neg
	.p2align	4
	.type	mcl_c0_fp2_neg,@function
mcl_c0_fp2_neg:                         # @mcl_c0_fp2_neg
# %bb.0:                                # %L60
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	24(%rsi), %r9
	movq	(%rsi), %r10
	movq	8(%rsi), %r11
	movq	%r11, %rbx
	orq	%r9, %rbx
	movq	16(%rsi), %r14
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rcx
	movq	.Lmcl_c0_fp_p$local+8(%rip), %rdx
	movq	.Lmcl_c0_fp_p$local(%rip), %r8
	movq	%r8, %r15
	subq	%r10, %r15
	movq	%rdx, %r12
	sbbq	%r11, %r12
	movq	%rcx, %r11
	sbbq	%r14, %r11
	movq	%rax, %r13
	sbbq	%r9, %r13
	orq	%r14, %r10
	xorl	%r9d, %r9d
	orq	%rbx, %r10
	cmoveq	%r9, %r12
	movq	%r12, 8(%rdi)
	cmoveq	%r9, %r15
	movq	%r15, (%rdi)
	cmoveq	%r9, %r11
	movq	%r11, 16(%rdi)
	cmoveq	%r9, %r13
	movq	%r13, 24(%rdi)
	movq	72(%rsi), %r10
	movq	64(%rsi), %r11
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	subq	%rbx, %r8
	sbbq	%rsi, %rdx
	sbbq	%r11, %rcx
	sbbq	%r10, %rax
	orq	%r10, %rsi
	orq	%r11, %rbx
	orq	%rsi, %rbx
	cmoveq	%r9, %r8
	movq	%r8, 48(%rdi)
	cmoveq	%r9, %rdx
	movq	%rdx, 56(%rdi)
	cmoveq	%r9, %rcx
	movq	%rcx, 64(%rdi)
	cmoveq	%r9, %rax
	movq	%rax, 72(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end123:
	.size	mcl_c0_fp2_neg, .Lfunc_end123-mcl_c0_fp2_neg
                                        # -- End function
	.globl	mcl_c0_fp2_mul2                 # -- Begin function mcl_c0_fp2_mul2
	.p2align	4
	.type	mcl_c0_fp2_mul2,@function
mcl_c0_fp2_mul2:                        # @mcl_c0_fp2_mul2
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rcx
	movq	.Lmcl_c0_fp_p$local+8(%rip), %rdx
	movq	.Lmcl_c0_fp_p$local(%rip), %r8
	movq	24(%rsi), %r9
	movq	16(%rsi), %r10
	movq	(%rsi), %r11
	movq	8(%rsi), %rbx
	addq	(%rsi), %r11
	adcq	8(%rsi), %rbx
	adcq	16(%rsi), %r10
	adcq	24(%rsi), %r9
	movq	%r11, %r14
	subq	%r8, %r14
	movq	%rbx, %r15
	sbbq	%rdx, %r15
	movq	%r10, %r12
	sbbq	%rcx, %r12
	movq	%r9, %r13
	sbbq	%rax, %r13
	cmovsq	%rbx, %r15
	movq	%r15, 8(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 16(%rdi)
	cmovsq	%r9, %r13
	movq	%r13, 24(%rdi)
	cmovsq	%r11, %r14
	movq	%r14, (%rdi)
	movq	72(%rsi), %r9
	movq	64(%rsi), %r10
	movq	48(%rsi), %r11
	movq	56(%rsi), %rbx
	addq	48(%rsi), %r11
	adcq	56(%rsi), %rbx
	adcq	64(%rsi), %r10
	adcq	72(%rsi), %r9
	movq	%r11, %rsi
	subq	%r8, %rsi
	movq	%rbx, %r8
	sbbq	%rdx, %r8
	movq	%r10, %rdx
	sbbq	%rcx, %rdx
	movq	%r9, %rcx
	sbbq	%rax, %rcx
	cmovsq	%r10, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r9, %rcx
	movq	%rcx, 72(%rdi)
	cmovsq	%r11, %rsi
	movq	%rsi, 48(%rdi)
	cmovsq	%rbx, %r8
	movq	%r8, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end124:
	.size	mcl_c0_fp2_mul2, .Lfunc_end124-mcl_c0_fp2_mul2
                                        # -- End function
	.globl	mcl_c0_fp2_mul                  # -- Begin function mcl_c0_fp2_mul
	.p2align	4
	.type	mcl_c0_fp2_mul,@function
mcl_c0_fp2_mul:                         # @mcl_c0_fp2_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$344, %rsp                      # imm = 0x158
	movq	%rdx, %r12
	movq	%rsi, %r13
	movq	%rdi, 144(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%r13), %rdx
	adcq	8(%r13), %rsi
	adcq	16(%r13), %rcx
	adcq	24(%r13), %rax
	movq	72(%r12), %rdi
	movq	64(%r12), %r8
	movq	48(%r12), %r9
	movq	56(%r12), %r10
	addq	(%r12), %r9
	adcq	8(%r12), %r10
	adcq	16(%r12), %r8
	adcq	24(%r12), %rdi
	movq	%r8, 232(%rsp)
	movq	%rdi, 240(%rsp)
	movq	%r9, 216(%rsp)
	movq	%r10, 224(%rsp)
	movq	%rcx, 264(%rsp)
	movq	%rax, 272(%rsp)
	movq	%rdx, 248(%rsp)
	movq	%rsi, 256(%rsp)
	leaq	152(%rsp), %rdi
	leaq	248(%rsp), %rsi
	leaq	216(%rsp), %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	leaq	8(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	addq	$48, %r13
	addq	$48, %r12
	leaq	280(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	movq	312(%rsp), %r8
	movq	%r8, 136(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %r15
	movq	304(%rsp), %r9
	movq	%r9, 120(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	296(%rsp), %rcx
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %r14
	movq	%r14, 104(%rsp)                 # 8-byte Spill
	movq	280(%rsp), %rdi
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	movq	288(%rsp), %rdx
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r13
	movq	%rbp, %rsi
	addq	%rdi, %rsi
	movq	%r13, %rdi
	adcq	%rdx, %rdi
	adcq	%rcx, %r14
	movq	%rax, %rdx
	adcq	%r9, %rdx
	movq	%r15, %rcx
	adcq	%r8, %rcx
	movq	320(%rsp), %rax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movq	48(%rsp), %rbx
	movq	%rbx, %r8
	adcq	%rax, %r8
	movq	328(%rsp), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	56(%rsp), %r11
	movq	%r11, %r9
	adcq	%rax, %r9
	movq	336(%rsp), %r12
	movq	64(%rsp), %rax
	movq	%rax, %r10
	adcq	%r12, %r10
	subq	%rsi, 152(%rsp)
	sbbq	%rdi, 160(%rsp)
	sbbq	%r14, 168(%rsp)
	sbbq	%rdx, 176(%rsp)
	sbbq	%rcx, 184(%rsp)
	sbbq	%r8, 192(%rsp)
	sbbq	%r9, 200(%rsp)
	sbbq	%r10, 208(%rsp)
	subq	80(%rsp), %rbp                  # 8-byte Folded Reload
	sbbq	88(%rsp), %r13                  # 8-byte Folded Reload
	movq	104(%rsp), %rsi                 # 8-byte Reload
	sbbq	96(%rsp), %rsi                  # 8-byte Folded Reload
	movq	128(%rsp), %rdi                 # 8-byte Reload
	sbbq	120(%rsp), %rdi                 # 8-byte Folded Reload
	sbbq	136(%rsp), %r15                 # 8-byte Folded Reload
	sbbq	112(%rsp), %rbx                 # 8-byte Folded Reload
	sbbq	72(%rsp), %r11                  # 8-byte Folded Reload
	sbbq	%r12, %rax
	movq	%rax, %rcx
	shrq	$61, %rcx
	andl	$-4, %ecx
	leaq	.Lmcl_c0_fp_sub_tbl$local(%rip), %rdx
	addq	(%rdx,%rcx,8), %r15
	adcq	8(%rdx,%rcx,8), %rbx
	adcq	16(%rdx,%rcx,8), %r11
	adcq	24(%rdx,%rcx,8), %rax
	movq	%rbp, 8(%rsp)
	movq	%r13, 16(%rsp)
	movq	%rsi, 24(%rsp)
	movq	%rdi, 32(%rsp)
	movq	%r15, 40(%rsp)
	movq	%rbx, 48(%rsp)
	movq	%r11, 56(%rsp)
	movq	%rax, 64(%rsp)
	movq	144(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	leaq	8(%rsp), %rsi
	callq	mcl_c0_fpDbl_mod@PLT
	addq	$48, %rbx
	movq	%rbx, %rdi
	leaq	152(%rsp), %rsi
	callq	mcl_c0_fpDbl_mod@PLT
	addq	$344, %rsp                      # imm = 0x158
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end125:
	.size	mcl_c0_fp2_mul, .Lfunc_end125-mcl_c0_fp2_mul
                                        # -- End function
	.globl	mcl_c0_fp2_sqr                  # -- Begin function mcl_c0_fp2_sqr
	.p2align	4
	.type	mcl_c0_fp2_sqr,@function
mcl_c0_fp2_sqr:                         # @mcl_c0_fp2_sqr
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$120, %rsp
	movq	%rsi, %rdx
	movq	%rdi, 16(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %rdi
	movq	24(%rsi), %rbx
	movq	%rbx, 8(%rsp)                   # 8-byte Spill
	movq	64(%rsi), %rsi
	movq	16(%rdx), %r8
	movq	%r8, (%rsp)                     # 8-byte Spill
	movq	56(%rdx), %r14
	movq	48(%rdx), %r15
	movq	(%rdx), %r12
	movq	8(%rdx), %r13
	movq	%r12, %r11
	subq	%r15, %r11
	movq	%r13, %r9
	sbbq	%r14, %r9
	sbbq	%rsi, %r8
	sbbq	%rdi, %rbx
	movq	%r14, %rbp
	shldq	$1, %r15, %rbp
	movq	%rdi, %rax
	shldq	$1, %rsi, %rax
	movq	%rsi, %rcx
	shldq	$1, %r14, %rcx
	leaq	(%r15,%r15), %r10
	addq	%r12, %r15
	movq	%rcx, 104(%rsp)
	movq	%rax, 112(%rsp)
	movq	%r10, 88(%rsp)
	movq	%rbp, 96(%rsp)
	movq	%r15, 56(%rsp)
	adcq	%r13, %r14
	movq	%r14, 64(%rsp)
	adcq	(%rsp), %rsi                    # 8-byte Folded Reload
	adcq	8(%rsp), %rdi                   # 8-byte Folded Reload
	addq	.Lmcl_c0_fp_p$local(%rip), %r11
	movq	%r11, 24(%rsp)
	movq	%rsi, 72(%rsp)
	adcq	.Lmcl_c0_fp_p$local+8(%rip), %r9
	movq	%r9, 32(%rsp)
	movq	%rdi, 80(%rsp)
	adcq	.Lmcl_c0_fp_p$local+16(%rip), %r8
	movq	%r8, 40(%rsp)
	adcq	.Lmcl_c0_fp_p$local+24(%rip), %rbx
	movq	%rbx, 48(%rsp)
	movq	16(%rsp), %rbx                  # 8-byte Reload
	leaq	48(%rbx), %rdi
	leaq	88(%rsp), %rsi
	callq	mcl_c0_fp_mul@PLT
	leaq	56(%rsp), %rsi
	leaq	24(%rsp), %rdx
	movq	%rbx, %rdi
	callq	mcl_c0_fp_mul@PLT
	addq	$120, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end126:
	.size	mcl_c0_fp2_sqr, .Lfunc_end126-mcl_c0_fp2_sqr
                                        # -- End function
	.globl	mcl_c0_fp2_mul_xi               # -- Begin function mcl_c0_fp2_mul_xi
	.p2align	4
	.type	mcl_c0_fp2_mul_xi,@function
mcl_c0_fp2_mul_xi:                      # @mcl_c0_fp2_mul_xi
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %r8
	movq	24(%rsi), %r9
	movq	72(%rsi), %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r14
	movq	8(%rsi), %r15
	movq	48(%rsi), %r12
	movq	%r12, -48(%rsp)                 # 8-byte Spill
	addq	%r14, %r12
	adcq	%r15, %rdx
	movq	%rcx, %rsi
	adcq	%rax, %rsi
	movq	%rdi, %rcx
	adcq	%r9, %rcx
	movq	.Lmcl_c0_fp_p$local(%rip), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	%r12, %r13
	subq	%rax, %r13
	movq	.Lmcl_c0_fp_p$local+8(%rip), %rdi
	movq	%rdx, %rbp
	sbbq	%rdi, %rbp
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r11
	movq	%rsi, %r10
	sbbq	%r11, %r10
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rbx
	movq	%rcx, %rax
	sbbq	%rbx, %rax
	cmovsq	%rdx, %rbp
	cmovsq	%rcx, %rax
	cmovsq	%rsi, %r10
	cmovsq	%r12, %r13
	subq	-48(%rsp), %r14                 # 8-byte Folded Reload
	movq	%r10, 64(%r8)
	movq	%rax, 72(%r8)
	movq	%r13, 48(%r8)
	movq	%rbp, 56(%r8)
	sbbq	-32(%rsp), %r15                 # 8-byte Folded Reload
	movq	-40(%rsp), %rcx                 # 8-byte Reload
	sbbq	-24(%rsp), %rcx                 # 8-byte Folded Reload
	sbbq	-16(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r9, %rax
	sarq	$63, %rax
	andq	%rax, %rbx
	andq	%rax, %r11
	andq	%rax, %rdi
	andq	-8(%rsp), %rax                  # 8-byte Folded Reload
	addq	%r14, %rax
	movq	%rax, (%r8)
	adcq	%r15, %rdi
	movq	%rdi, 8(%r8)
	adcq	%rcx, %r11
	movq	%r11, 16(%r8)
	adcq	%r9, %rbx
	movq	%rbx, 24(%r8)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end127:
	.size	mcl_c0_fp2_mul_xi, .Lfunc_end127-mcl_c0_fp2_mul_xi
                                        # -- End function
	.globl	mcl_c0_fp2Dbl_mulPre            # -- Begin function mcl_c0_fp2Dbl_mulPre
	.p2align	4
	.type	mcl_c0_fp2Dbl_mulPre,@function
mcl_c0_fp2Dbl_mulPre:                   # @mcl_c0_fp2Dbl_mulPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$216, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	72(%rsi), %rax
	movq	64(%rsi), %rcx
	movq	48(%rsi), %rdx
	movq	56(%rsi), %rsi
	addq	(%r15), %rdx
	adcq	8(%r15), %rsi
	adcq	16(%r15), %rcx
	adcq	24(%r15), %rax
	movq	72(%r14), %rdi
	movq	64(%r14), %r8
	movq	48(%r14), %r9
	movq	56(%r14), %r10
	addq	(%r14), %r9
	adcq	8(%r14), %r10
	adcq	16(%r14), %r8
	adcq	24(%r14), %rdi
	movq	%r8, 104(%rsp)
	movq	%rdi, 112(%rsp)
	movq	%r9, 88(%rsp)
	movq	%r10, 96(%rsp)
	movq	%rcx, 136(%rsp)
	movq	%rax, 144(%rsp)
	movq	%rdx, 120(%rsp)
	movq	%rsi, 128(%rsp)
	leaq	96(%rbx), %rdi
	leaq	120(%rsp), %rsi
	leaq	88(%rsp), %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	addq	$48, %r15
	addq	$48, %r14
	leaq	152(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	.Lmcl_c0_fpDbl_mulPre
	movq	32(%rbx), %r15
	movq	24(%rbx), %r14
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	movq	16(%rbx), %rdx
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movq	(%rbx), %rbp
	movq	%rbp, 80(%rsp)                  # 8-byte Spill
	movq	8(%rbx), %r10
	movq	%r10, 72(%rsp)                  # 8-byte Spill
	movq	184(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	176(%rsp), %rsi
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	168(%rsp), %rdi
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %r9
	movq	%r9, 16(%rsp)                   # 8-byte Spill
	movq	160(%rsp), %r8
	movq	%r8, 24(%rsp)                   # 8-byte Spill
	addq	%r9, %rbp
	adcq	%r8, %r10
	adcq	%rdi, %rdx
	adcq	%rsi, %r14
	movq	%r15, %rsi
	adcq	%rax, %rsi
	movq	40(%rbx), %rdi
	movq	192(%rsp), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rdi, %r8
	adcq	%rax, %r8
	movq	48(%rbx), %rcx
	movq	200(%rsp), %r13
	movq	%rcx, %r9
	adcq	%r13, %r9
	movq	56(%rbx), %r11
	movq	208(%rsp), %r12
	movq	%r11, %rax
	adcq	%r12, %rax
	subq	%rbp, 96(%rbx)
	sbbq	%r10, 104(%rbx)
	sbbq	%rdx, 112(%rbx)
	sbbq	%r14, 120(%rbx)
	sbbq	%rsi, 128(%rbx)
	sbbq	%r8, 136(%rbx)
	sbbq	%r9, 144(%rbx)
	sbbq	%rax, 152(%rbx)
	movq	80(%rsp), %rsi                  # 8-byte Reload
	subq	16(%rsp), %rsi                  # 8-byte Folded Reload
	movq	72(%rsp), %r8                   # 8-byte Reload
	sbbq	24(%rsp), %r8                   # 8-byte Folded Reload
	movq	56(%rsp), %r10                  # 8-byte Reload
	sbbq	32(%rsp), %r10                  # 8-byte Folded Reload
	movq	64(%rsp), %r9                   # 8-byte Reload
	sbbq	40(%rsp), %r9                   # 8-byte Folded Reload
	sbbq	48(%rsp), %r15                  # 8-byte Folded Reload
	sbbq	8(%rsp), %rdi                   # 8-byte Folded Reload
	sbbq	%r13, %rcx
	sbbq	%r12, %r11
	movq	%r11, %rax
	shrq	$61, %rax
	andl	$-4, %eax
	leaq	.Lmcl_c0_fp_sub_tbl$local(%rip), %rdx
	addq	(%rdx,%rax,8), %r15
	adcq	8(%rdx,%rax,8), %rdi
	adcq	16(%rdx,%rax,8), %rcx
	adcq	24(%rdx,%rax,8), %r11
	movq	%r11, 56(%rbx)
	movq	%rcx, 48(%rbx)
	movq	%r15, 32(%rbx)
	movq	%rdi, 40(%rbx)
	movq	%r10, 16(%rbx)
	movq	%r8, 8(%rbx)
	movq	%rsi, (%rbx)
	movq	%r9, 24(%rbx)
	addq	$216, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end128:
	.size	mcl_c0_fp2Dbl_mulPre, .Lfunc_end128-mcl_c0_fp2Dbl_mulPre
                                        # -- End function
	.globl	mcl_c0_fp2Dbl_sqrPre            # -- Begin function mcl_c0_fp2Dbl_sqrPre
	.p2align	4
	.type	mcl_c0_fp2Dbl_sqrPre,@function
mcl_c0_fp2Dbl_sqrPre:                   # @mcl_c0_fp2Dbl_sqrPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	movq	%rsi, %rdx
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rcx
	movq	64(%rsi), %rax
	movq	%rax, %rsi
	shldq	$1, %rcx, %rsi
	movq	24(%rdx), %rbx
	movq	16(%rdx), %r10
	movq	(%rdx), %rbp
	movq	8(%rdx), %r11
	movq	48(%rdx), %r9
	movq	72(%rdx), %r8
	movq	%rsi, 16(%rsp)
	movq	%r8, %rsi
	shldq	$1, %rax, %rsi
	movq	%rsi, 24(%rsp)
	leaq	(%r9,%r9), %rsi
	movq	%rsi, (%rsp)
	movq	%rcx, %rsi
	shldq	$1, %r9, %rsi
	movq	%rsi, 8(%rsp)
	movq	%r9, %rsi
	addq	%rbp, %rsi
	movq	%rsi, 56(%rsp)
	movq	%rcx, %rsi
	adcq	%r11, %rsi
	movq	%rsi, 64(%rsp)
	movq	%rax, %rsi
	adcq	%r10, %rsi
	movq	%rsi, 72(%rsp)
	movq	%r8, %rsi
	adcq	%rbx, %rsi
	movq	%rsi, 80(%rsp)
	subq	%r9, %rbp
	sbbq	%rcx, %r11
	movq	%r11, 40(%rsp)                  # 8-byte Spill
	sbbq	%rax, %r10
	movq	%r10, 48(%rsp)                  # 8-byte Spill
	sbbq	%r8, %rbx
	movq	%rbx, %r15
	sarq	$63, %r15
	movq	.Lmcl_c0_fp_p$local+24(%rip), %r14
	andq	%r15, %r14
	movq	.Lmcl_c0_fp_p$local+16(%rip), %r12
	andq	%r15, %r12
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r13
	andq	%r15, %r13
	andq	.Lmcl_c0_fp_p$local(%rip), %r15
	addq	$96, %rdi
	movq	%rsp, %rsi
	callq	.Lmcl_c0_fpDbl_mulPre
	addq	%rbp, %r15
	adcq	40(%rsp), %r13                  # 8-byte Folded Reload
	movq	%r13, 8(%rsp)
	movq	%r15, (%rsp)
	adcq	48(%rsp), %r12                  # 8-byte Folded Reload
	movq	%r12, 16(%rsp)
	adcq	%rbx, %r14
	movq	%r14, 24(%rsp)
	leaq	56(%rsp), %rdx
	movq	32(%rsp), %rdi                  # 8-byte Reload
	movq	%rsp, %rsi
	callq	.Lmcl_c0_fpDbl_mulPre
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end129:
	.size	mcl_c0_fp2Dbl_sqrPre, .Lfunc_end129-mcl_c0_fp2Dbl_sqrPre
                                        # -- End function
	.globl	mcl_c0_fp2Dbl_mul_xi            # -- Begin function mcl_c0_fp2Dbl_mul_xi
	.p2align	4
	.type	mcl_c0_fp2Dbl_mul_xi,@function
mcl_c0_fp2Dbl_mul_xi:                   # @mcl_c0_fp2Dbl_mul_xi
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	152(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	144(%rsi), %rax
	movq	%rax, -120(%rsp)                # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -128(%rsp)                # 8-byte Spill
	movq	136(%rsi), %r15
	movq	%r15, -8(%rsp)                  # 8-byte Spill
	movq	40(%rsi), %r14
	movq	%r14, (%rsp)                    # 8-byte Spill
	movq	128(%rsi), %r10
	movq	%r10, -56(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %r9
	movq	%r9, -40(%rsp)                  # 8-byte Spill
	movq	120(%rsi), %r8
	movq	%r8, -80(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	112(%rsi), %r13
	movq	16(%rsi), %rcx
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	movq	104(%rsi), %rbx
	movq	96(%rsi), %r11
	movq	(%rsi), %rbp
	movq	8(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	xorl	%r12d, %r12d
	movq	%rbp, %rsi
	subq	%r11, %rsi
	movq	%rsi, -72(%rsp)                 # 8-byte Spill
	sbbq	%rbx, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	sbbq	%r13, %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	sbbq	%r8, %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	%r9, %rsi
	sbbq	%r10, %rsi
	movq	%r14, %r8
	sbbq	%r15, %r8
	movq	-128(%rsp), %r9                 # 8-byte Reload
	sbbq	-120(%rsp), %r9                 # 8-byte Folded Reload
	movq	-112(%rsp), %r10                # 8-byte Reload
	sbbq	-104(%rsp), %r10                # 8-byte Folded Reload
	sbbq	%r12, %r12
	movq	.Lmcl_c0_fp_p$local+24(%rip), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r12, %rdx
	andq	%rax, %rdx
	movq	.Lmcl_c0_fp_p$local+16(%rip), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%r12, %rcx
	andq	%rax, %rcx
	movq	.Lmcl_c0_fp_p$local+8(%rip), %r14
	movq	%r12, %rax
	andq	%r14, %rax
	movq	.Lmcl_c0_fp_p$local(%rip), %r15
	andq	%r15, %r12
	addq	%rsi, %r12
	adcq	%r8, %rax
	adcq	%r9, %rcx
	adcq	%r10, %rdx
	addq	%rbp, %r11
	adcq	-96(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%r11, 96(%rdi)
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, (%rdi)
	adcq	-88(%rsp), %r13                 # 8-byte Folded Reload
	movq	%rbx, 104(%rdi)
	movq	-48(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, 8(%rdi)
	movq	-80(%rsp), %rsi                 # 8-byte Reload
	adcq	-64(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r13, 112(%rdi)
	movq	-32(%rsp), %r8                  # 8-byte Reload
	movq	%r8, 16(%rdi)
	movq	-56(%rsp), %r8                  # 8-byte Reload
	adcq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rsi, 120(%rdi)
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, 24(%rdi)
	movq	%r12, 32(%rdi)
	movq	%rax, 40(%rdi)
	movq	%rcx, 48(%rdi)
	movq	%rdx, 56(%rdi)
	movq	-8(%rsp), %rsi                  # 8-byte Reload
	adcq	(%rsp), %rsi                    # 8-byte Folded Reload
	movq	-120(%rsp), %rbx                # 8-byte Reload
	adcq	-128(%rsp), %rbx                # 8-byte Folded Reload
	movq	-104(%rsp), %r10                # 8-byte Reload
	adcq	-112(%rsp), %r10                # 8-byte Folded Reload
	setb	%al
	movq	%r8, %rcx
	movq	%r8, %r11
	subq	%r15, %rcx
	movq	%rsi, %rdx
	movq	%rsi, %r9
	sbbq	%r14, %rdx
	movq	%rbx, %rsi
	sbbq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r10, %r8
	sbbq	8(%rsp), %r8                    # 8-byte Folded Reload
	movzbl	%al, %eax
	sbbq	$0, %rax
	testb	$1, %al
	cmovneq	%rbx, %rsi
	movq	%rsi, 144(%rdi)
	cmovneq	%r10, %r8
	movq	%r8, 152(%rdi)
	cmovneq	%r11, %rcx
	movq	%rcx, 128(%rdi)
	cmovneq	%r9, %rdx
	movq	%rdx, 136(%rdi)
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end130:
	.size	mcl_c0_fp2Dbl_mul_xi, .Lfunc_end130-mcl_c0_fp2Dbl_mul_xi
                                        # -- End function
	.globl	mcl_c0_fr_add                   # -- Begin function mcl_c0_fr_add
	.p2align	4
	.type	mcl_c0_fr_add,@function
mcl_c0_fr_add:                          # @mcl_c0_fr_add
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	addq	(%rdx), %r8
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %rcx
	adcq	24(%rdx), %rax
	movq	%r8, %rdx
	subq	.Lmcl_c0_fr_p$local(%rip), %rdx
	movq	%rsi, %r9
	sbbq	.Lmcl_c0_fr_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c0_fr_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c0_fr_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end131:
	.size	mcl_c0_fr_add, .Lfunc_end131-mcl_c0_fr_add
                                        # -- End function
	.globl	mcl_c0_fr_sub                   # -- Begin function mcl_c0_fr_sub
	.p2align	4
	.type	mcl_c0_fr_sub,@function
mcl_c0_fr_sub:                          # @mcl_c0_fr_sub
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	sbbq	24(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	movq	.Lmcl_c0_fr_p$local+24(%rip), %r9
	andq	%rdx, %r9
	movq	.Lmcl_c0_fr_p$local+16(%rip), %r10
	andq	%rdx, %r10
	movq	.Lmcl_c0_fr_p$local+8(%rip), %r11
	andq	%rdx, %r11
	andq	.Lmcl_c0_fr_p$local(%rip), %rdx
	addq	%r8, %rdx
	movq	%rdx, (%rdi)
	adcq	%rsi, %r11
	movq	%r11, 8(%rdi)
	adcq	%rcx, %r10
	movq	%r10, 16(%rdi)
	adcq	%rax, %r9
	movq	%r9, 24(%rdi)
	retq
.Lfunc_end132:
	.size	mcl_c0_fr_sub, .Lfunc_end132-mcl_c0_fr_sub
                                        # -- End function
	.globl	mcl_c0_fr_neg                   # -- Begin function mcl_c0_fr_neg
	.p2align	4
	.type	mcl_c0_fr_neg,@function
mcl_c0_fr_neg:                          # @mcl_c0_fr_neg
# %bb.0:                                # %L66
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	.Lmcl_c0_fr_p$local+24(%rip), %rax
	movq	.Lmcl_c0_fr_p$local+16(%rip), %r9
	movq	.Lmcl_c0_fr_p$local+8(%rip), %r10
	movq	.Lmcl_c0_fr_p$local(%rip), %r11
	subq	%r8, %r11
	sbbq	%rsi, %r10
	sbbq	%rdx, %r9
	sbbq	%rcx, %rax
	orq	%rcx, %rsi
	orq	%rdx, %r8
	xorl	%ecx, %ecx
	orq	%rsi, %r8
	cmoveq	%rcx, %r11
	movq	%r11, (%rdi)
	cmoveq	%rcx, %r10
	movq	%r10, 8(%rdi)
	cmoveq	%rcx, %r9
	movq	%r9, 16(%rdi)
	cmoveq	%rcx, %rax
	movq	%rax, 24(%rdi)
	retq
.Lfunc_end133:
	.size	mcl_c0_fr_neg, .Lfunc_end133-mcl_c0_fr_neg
                                        # -- End function
	.globl	mcl_c0_fr_mul2                  # -- Begin function mcl_c0_fr_mul2
	.p2align	4
	.type	mcl_c0_fr_mul2,@function
mcl_c0_fr_mul2:                         # @mcl_c0_fr_mul2
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %rdx
	movq	8(%rsi), %r8
	addq	(%rsi), %rdx
	adcq	8(%rsi), %r8
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rax
	movq	%rdx, %rsi
	subq	.Lmcl_c0_fr_p$local(%rip), %rsi
	movq	%r8, %r9
	sbbq	.Lmcl_c0_fr_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c0_fr_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c0_fr_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%rdx, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r8, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end134:
	.size	mcl_c0_fr_mul2, .Lfunc_end134-mcl_c0_fr_mul2
                                        # -- End function
	.globl	mcl_c0_fr_mul                   # -- Begin function mcl_c0_fr_mul
	.p2align	4
	.type	mcl_c0_fr_mul,@function
mcl_c0_fr_mul:                          # @mcl_c0_fr_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rax
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r11
	movq	(%rax), %rax
	mulxq	%rax, %r10, %rdi
	movq	.Lmcl_c0_fr_rp$local(%rip), %r9
	movq	%r9, -88(%rsp)                  # 8-byte Spill
	imulq	%r10, %r9
	movq	.Lmcl_c0_fr_p$local(%rip), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r8, %rcx
	addq	%rdi, %rcx
	movq	.Lmcl_c0_fr_p$local+8(%rip), %rdi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	movq	%r11, %rdx
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, %rdx
	mulxq	%r9, %r13, %rdi
	adcq	%r14, %rdi
	movq	16(%rsi), %rdx
	movq	%rdx, %r14
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbx, %r15
	movq	.Lmcl_c0_fr_p$local+16(%rip), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r9, %rbp, %r12
	adcq	%r15, %r12
	movq	24(%rsi), %r15
	movq	.Lmcl_c0_fr_p$local+24(%rip), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r9, %rsi
	movq	%r15, %rdx
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %rdx
	adcq	%rsi, %rdx
	addq	%r10, %r8
	adcq	-32(%rsp), %r13                 # 8-byte Folded Reload
	adcq	%rbx, %rbp
	adcq	%r9, %rax
	setb	%sil
	addq	%rcx, %r13
	adcq	%rdi, %rbp
	adcq	%r12, %rax
	movzbl	%sil, %r9d
	adcq	%rdx, %r9
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	%r11, %rdi, %rsi
	mulxq	-96(%rsp), %r10, %rcx           # 8-byte Folded Reload
	addq	%rdi, %rcx
	mulxq	%r14, %rdi, %rbx
	adcq	%rsi, %rdi
	mulxq	%r15, %r8, %rsi
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%r13, %r10
	adcq	%rbp, %rcx
	adcq	%rax, %rdi
	adcq	%r9, %r8
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	-16(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r9, %rax
	addq	%r10, %r9
	movq	-24(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r9, %r10
	adcq	%rcx, %r9
	movq	-64(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %rcx, %rbx
	adcq	%rdi, %rcx
	movq	-72(%rsp), %r15                 # 8-byte Reload
	mulxq	%r15, %rbp, %rdx
	adcq	%r8, %rbp
	adcq	$0, %rsi
	addq	%rax, %r9
	adcq	%r10, %rcx
	adcq	%rbx, %rbp
	adcq	%rdx, %rsi
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rdx
	mulxq	-40(%rsp), %r8, %rax            # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%r8, %rdi
	mulxq	-48(%rsp), %r8, %rbx            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%rbx, %rax
	adcq	$0, %r13
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%rsi, %rax
	adcq	$0, %r13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	mulxq	%r12, %rcx, %rsi
	addq	%r10, %rcx
	mulxq	%r11, %r9, %r10
	adcq	%rdi, %r9
	mulxq	%r14, %rcx, %rdi
	adcq	%r8, %rcx
	mulxq	%r15, %rbp, %rdx
	adcq	%rax, %rbp
	adcq	$0, %r13
	addq	%rsi, %r9
	adcq	%r10, %rcx
	adcq	%rdi, %rbp
	adcq	%rdx, %r13
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-40(%rsp), %rsi, %rax           # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%rsi, %rdi
	mulxq	-48(%rsp), %r8, %r14            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	adcq	%r14, %rbx
	adcq	$0, %rsi
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%r13, %rbx
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	%r12, %r14
	mulxq	%r12, %rax, %rcx
	addq	%r10, %rax
	movq	%r11, %r15
	mulxq	%r11, %rax, %r9
	adcq	%rdi, %rax
	movq	-64(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r10, %rdi
	adcq	%r8, %r10
	movq	-72(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r8, %rdx
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r9, %r10
	adcq	%rdi, %r8
	adcq	%rdx, %rsi
	movq	%rax, %rcx
	subq	%r14, %rcx
	movq	%r10, %rdx
	sbbq	%r15, %rdx
	movq	%r8, %rdi
	sbbq	%r12, %rdi
	movq	%rsi, %r9
	sbbq	%r11, %r9
	cmovsq	%r10, %rdx
	movq	-8(%rsp), %r10                  # 8-byte Reload
	movq	%rdx, 8(%r10)
	cmovsq	%r8, %rdi
	movq	%rdi, 16(%r10)
	cmovsq	%rsi, %r9
	movq	%r9, 24(%r10)
	cmovsq	%rax, %rcx
	movq	%rcx, (%r10)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end135:
	.size	mcl_c0_fr_mul, .Lfunc_end135-mcl_c0_fr_mul
                                        # -- End function
	.globl	mcl_c0_fr_sqr                   # -- Begin function mcl_c0_fr_sqr
	.p2align	4
	.type	mcl_c0_fr_sqr,@function
mcl_c0_fr_sqr:                          # @mcl_c0_fr_sqr
# %bb.0:
	movq	%rsi, %rdx
	jmp	mcl_c0_fr_mul@PLT               # TAILCALL
.Lfunc_end136:
	.size	mcl_c0_fr_sqr, .Lfunc_end136-mcl_c0_fr_sqr
                                        # -- End function
	.globl	mcl_c0_frDbl_mod                # -- Begin function mcl_c0_frDbl_mod
	.p2align	4
	.type	mcl_c0_frDbl_mod,@function
mcl_c0_frDbl_mod:                       # @mcl_c0_frDbl_mod
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	.Lmcl_c0_fr_rp$local(%rip), %r10
	movq	%r10, %rdi
	imulq	%rax, %rdi
	movq	.Lmcl_c0_fr_p$local+8(%rip), %rbp
	movq	%rbp, %rdx
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r11, %rsi
	movq	.Lmcl_c0_fr_p$local(%rip), %rcx
	movq	%rcx, %rdx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r14, %rbx
	movq	.Lmcl_c0_fr_p$local+16(%rip), %r8
	addq	%r11, %rbx
	movq	%r8, %rdx
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	mulxq	%rdi, %r12, %r11
	adcq	%rsi, %r12
	movq	.Lmcl_c0_fr_p$local+24(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdi, %r13
	adcq	%r11, %rdi
	adcq	$0, %r13
	addq	%rax, %r14
	adcq	8(%r9), %rbx
	adcq	16(%r9), %r12
	adcq	24(%r9), %rdi
	adcq	32(%r9), %r13
	setb	%al
	movq	%r10, %r11
	imulq	%rbx, %r11
	movq	%rcx, %rdx
	mulxq	%r11, %rcx, %r15
	movq	%rbp, %rdx
	mulxq	%r11, %r14, %rbp
	addq	%r15, %r14
	movq	%r8, %rdx
	mulxq	%r11, %r15, %r8
	adcq	%rbp, %r15
	movq	%r11, %rdx
	mulxq	%rsi, %rbp, %rdx
	adcq	%r8, %rbp
	movzbl	%al, %eax
	adcq	%rdx, %rax
	addq	%rbx, %rcx
	adcq	%r12, %r14
	adcq	%rdi, %r15
	adcq	%r13, %rbp
	adcq	40(%r9), %rax
	setb	-41(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %r11
	imulq	%r14, %r11
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rdx
	mulxq	%r11, %r8, %rdi
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rbx, %r13
	addq	%rdi, %rbx
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rdi
	adcq	%r13, %r12
	movq	%r11, %rdx
	mulxq	-24(%rsp), %r11, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %r11
	movzbl	-41(%rsp), %r13d                # 1-byte Folded Reload
	adcq	%rdx, %r13
	addq	%r14, %r8
	adcq	%r15, %rbx
	adcq	%rbp, %r12
	adcq	%rax, %r11
	adcq	48(%r9), %r13
	setb	-41(%rsp)                       # 1-byte Folded Spill
	imulq	%rbx, %r10
	movq	%rcx, %rdx
	mulxq	%r10, %r8, %rdi
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	mulxq	%r10, %rax, %r14
	addq	%rdi, %rax
	movq	%rsi, %rdx
	mulxq	%r10, %rdi, %r15
	adcq	%r14, %rdi
	movq	%r10, %rdx
	movq	-24(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %r10, %rdx
	adcq	%r15, %r10
	movzbl	-41(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	%rdx, %rcx
	addq	%rbx, %r8
	adcq	%r12, %rax
	adcq	%r11, %rdi
	adcq	%r13, %r10
	adcq	56(%r9), %rcx
	movq	%rax, %rdx
	subq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdi, %rsi
	sbbq	%rbp, %rsi
	movq	%r10, %r8
	sbbq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, %r11
	sbbq	%r14, %r11
	cmovsq	%r10, %r8
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%r8, 16(%r9)
	cmovsq	%rcx, %r11
	movq	%r11, 24(%r9)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r9)
	cmovsq	%rdi, %rsi
	movq	%rsi, 8(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end137:
	.size	mcl_c0_frDbl_mod, .Lfunc_end137-mcl_c0_frDbl_mod
                                        # -- End function
	.globl	mcl_c5_fp_add                   # -- Begin function mcl_c5_fp_add
	.p2align	4
	.type	mcl_c5_fp_add,@function
mcl_c5_fp_add:                          # @mcl_c5_fp_add
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %r8
	movq	16(%rsi), %r9
	movq	(%rsi), %rcx
	movq	8(%rsi), %rax
	addq	(%rdx), %rcx
	adcq	8(%rdx), %rax
	adcq	16(%rdx), %r9
	adcq	24(%rdx), %r8
	adcq	32(%rdx), %r11
	adcq	40(%rdx), %r10
	movq	%rcx, %rdx
	subq	.Lmcl_c5_fp_p$local(%rip), %rdx
	movq	%rax, %rsi
	sbbq	.Lmcl_c5_fp_p$local+8(%rip), %rsi
	movq	%r9, %rbx
	sbbq	.Lmcl_c5_fp_p$local+16(%rip), %rbx
	movq	%r8, %r14
	sbbq	.Lmcl_c5_fp_p$local+24(%rip), %r14
	movq	%r11, %r15
	sbbq	.Lmcl_c5_fp_p$local+32(%rip), %r15
	movq	%r10, %r12
	sbbq	.Lmcl_c5_fp_p$local+40(%rip), %r12
	movq	%r12, %r13
	sarq	$63, %r13
	cmovsq	%r11, %r15
	movq	%r15, 32(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 40(%rdi)
	cmovsq	%r9, %rbx
	movq	%rbx, 16(%rdi)
	cmovsq	%r8, %r14
	movq	%r14, 24(%rdi)
	cmovsq	%rcx, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rax, %rsi
	movq	%rsi, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end138:
	.size	mcl_c5_fp_add, .Lfunc_end138-mcl_c5_fp_add
                                        # -- End function
	.globl	mcl_c5_fp_sub                   # -- Begin function mcl_c5_fp_sub
	.p2align	4
	.type	mcl_c5_fp_sub,@function
mcl_c5_fp_sub:                          # @mcl_c5_fp_sub
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
	subq	(%rdx), %r10
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %r9
	sbbq	24(%rdx), %r8
	sbbq	32(%rdx), %rcx
	sbbq	40(%rdx), %rax
	movq	%rax, %r11
	sarq	$63, %r11
	movq	%r11, %rbx
	shldq	$1, %rax, %rbx
	andq	.Lmcl_c5_fp_p$local(%rip), %rbx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rdx
	andq	%r11, %rdx
	movq	.Lmcl_c5_fp_p$local+32(%rip), %r14
	andq	%r11, %r14
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r15
	andq	%r11, %r15
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r12
	andq	%r11, %r12
	andq	.Lmcl_c5_fp_p$local+8(%rip), %r11
	addq	%r10, %rbx
	movq	%rbx, (%rdi)
	adcq	%rsi, %r11
	movq	%r11, 8(%rdi)
	adcq	%r9, %r12
	movq	%r12, 16(%rdi)
	adcq	%r8, %r15
	movq	%r15, 24(%rdi)
	adcq	%rcx, %r14
	movq	%r14, 32(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end139:
	.size	mcl_c5_fp_sub, .Lfunc_end139-mcl_c5_fp_sub
                                        # -- End function
	.globl	mcl_c5_fp_neg                   # -- Begin function mcl_c5_fp_neg
	.p2align	4
	.type	mcl_c5_fp_neg,@function
mcl_c5_fp_neg:                          # @mcl_c5_fp_neg
# %bb.0:                                # %L69
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r10
	movq	32(%rsi), %r11
	movq	24(%rsi), %rbx
	movq	16(%rsi), %r14
	movq	(%rsi), %r8
	movq	8(%rsi), %r15
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rax
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rcx
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r12
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rdx
	movq	.Lmcl_c5_fp_p$local(%rip), %r9
	subq	%r8, %r9
	sbbq	%r15, %rdx
	sbbq	%r14, %r12
	sbbq	%rbx, %rcx
	sbbq	%r11, %rax
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rsi
	sbbq	%r10, %rsi
	orq	%r10, %r15
	orq	%rbx, %r15
	orq	%r11, %r8
	orq	%r14, %r8
	xorl	%r10d, %r10d
	orq	%r15, %r8
	cmoveq	%r10, %r12
	movq	%r12, 16(%rdi)
	cmoveq	%r10, %r9
	movq	%r9, (%rdi)
	cmoveq	%r10, %rdx
	movq	%rdx, 8(%rdi)
	cmoveq	%r10, %rcx
	movq	%rcx, 24(%rdi)
	cmoveq	%r10, %rax
	movq	%rax, 32(%rdi)
	cmoveq	%r10, %rsi
	movq	%rsi, 40(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end140:
	.size	mcl_c5_fp_neg, .Lfunc_end140-mcl_c5_fp_neg
                                        # -- End function
	.globl	mcl_c5_fp_mul2                  # -- Begin function mcl_c5_fp_mul2
	.p2align	4
	.type	mcl_c5_fp_mul2,@function
mcl_c5_fp_mul2:                         # @mcl_c5_fp_mul2
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %r9
	movq	32(%rsi), %r10
	movq	24(%rsi), %rdx
	movq	16(%rsi), %r8
	movq	(%rsi), %rcx
	movq	8(%rsi), %rax
	addq	(%rsi), %rcx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %r8
	adcq	24(%rsi), %rdx
	adcq	32(%rsi), %r10
	adcq	40(%rsi), %r9
	movq	%rcx, %rsi
	subq	.Lmcl_c5_fp_p$local(%rip), %rsi
	movq	%rax, %r11
	sbbq	.Lmcl_c5_fp_p$local+8(%rip), %r11
	movq	%r8, %rbx
	sbbq	.Lmcl_c5_fp_p$local+16(%rip), %rbx
	movq	%rdx, %r14
	sbbq	.Lmcl_c5_fp_p$local+24(%rip), %r14
	movq	%r10, %r15
	sbbq	.Lmcl_c5_fp_p$local+32(%rip), %r15
	movq	%r9, %r12
	sbbq	.Lmcl_c5_fp_p$local+40(%rip), %r12
	movq	%r12, %r13
	sarq	$63, %r13
	cmovsq	%r10, %r15
	movq	%r15, 32(%rdi)
	cmovsq	%r9, %r12
	movq	%r12, 40(%rdi)
	cmovsq	%r8, %rbx
	movq	%rbx, 16(%rdi)
	cmovsq	%rdx, %r14
	movq	%r14, 24(%rdi)
	cmovsq	%rcx, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 8(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end141:
	.size	mcl_c5_fp_mul2, .Lfunc_end141-mcl_c5_fp_mul2
                                        # -- End function
	.globl	mcl_c5_fp_mul                   # -- Begin function mcl_c5_fp_mul
	.p2align	4
	.type	mcl_c5_fp_mul,@function
mcl_c5_fp_mul:                          # @mcl_c5_fp_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdx, %rax
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -128(%rsp)                # 8-byte Spill
	movq	8(%rsi), %rdi
	movq	%rdi, -56(%rsp)                 # 8-byte Spill
	movq	(%rax), %r11
	mulxq	%r11, %rcx, %rax
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	.Lmcl_c5_fp_rp$local(%rip), %r12
	movq	%r12, -120(%rsp)                # 8-byte Spill
	imulq	%rcx, %r12
	movq	.Lmcl_c5_fp_p$local(%rip), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%r12, %r14, %r10
	addq	%rax, %r10
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rcx
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movq	%rdi, %rdx
	mulxq	%r11, %rdx, %rax
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	movq	%rcx, %rdx
	mulxq	%r12, %rcx, %r8
	adcq	%rax, %r8
	movq	16(%rsi), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r11, %rax, %rdi
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+16(%rip), %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	mulxq	%r12, %rax, %rbx
	adcq	%rdi, %rbx
	movq	24(%rsi), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%r11, %rdx, %r9
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	mulxq	%r12, %rdi, %rbp
	adcq	%r9, %rbp
	movq	32(%rsi), %rdx
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	mulxq	%r11, %rdx, %r15
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	mulxq	%r12, %r9, %r13
	adcq	%r15, %r13
	movq	40(%rsi), %rsi
	movq	%rsi, -88(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rdx
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	mulxq	%r12, %r12, %r15
	movq	%rsi, %rdx
	mulxq	%r11, %rsi, %rdx
	adcq	%r15, %rdx
	addq	16(%rsp), %r14                  # 8-byte Folded Reload
	adcq	8(%rsp), %rcx                   # 8-byte Folded Reload
	adcq	(%rsp), %rax                    # 8-byte Folded Reload
	adcq	-8(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	-16(%rsp), %r9                  # 8-byte Folded Reload
	adcq	%r12, %rsi
	setb	%r11b
	addq	%r10, %rcx
	adcq	%r8, %rax
	adcq	%rbx, %rdi
	adcq	%rbp, %r9
	adcq	%r13, %rsi
	movzbl	%r11b, %r15d
	adcq	%rdx, %r15
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	movq	8(%rdx), %rdx
	mulxq	-128(%rsp), %r8, %r12           # 8-byte Folded Reload
	addq	%rcx, %r8
	mulxq	-56(%rsp), %r10, %rcx           # 8-byte Folded Reload
	adcq	%rax, %r10
	mulxq	-64(%rsp), %r11, %rax           # 8-byte Folded Reload
	adcq	%rdi, %r11
	mulxq	-72(%rsp), %rbx, %rdi           # 8-byte Folded Reload
	adcq	%r9, %rbx
	mulxq	-80(%rsp), %r14, %r9            # 8-byte Folded Reload
	adcq	%rsi, %r14
	mulxq	-88(%rsp), %rsi, %rdx           # 8-byte Folded Reload
	adcq	%r15, %rsi
	setb	%bpl
	addq	%r12, %r10
	adcq	%rcx, %r11
	adcq	%rax, %rbx
	adcq	%rdi, %r14
	adcq	%r9, %rsi
	movzbl	%bpl, %eax
	adcq	%rdx, %rax
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%r8, %rdx
	mulxq	-24(%rsp), %rcx, %r15           # 8-byte Folded Reload
	addq	%r8, %rcx
	mulxq	-96(%rsp), %rcx, %r12           # 8-byte Folded Reload
	adcq	%r10, %rcx
	mulxq	-104(%rsp), %rdi, %r13          # 8-byte Folded Reload
	adcq	%r11, %rdi
	mulxq	-112(%rsp), %r8, %r11           # 8-byte Folded Reload
	adcq	%rbx, %r8
	mulxq	-32(%rsp), %r9, %rbx            # 8-byte Folded Reload
	adcq	%r14, %r9
	mulxq	-40(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%rsi, %r10
	adcq	$0, %rax
	addq	%r15, %rcx
	adcq	%r12, %rdi
	adcq	%r13, %r8
	adcq	%r11, %r9
	adcq	%rbx, %r10
	adcq	%rdx, %rax
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	movq	16(%rdx), %rdx
	mulxq	-56(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	mulxq	-128(%rsp), %rbp, %r11          # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-64(%rsp), %rbx, %r15           # 8-byte Folded Reload
	adcq	%rsi, %rbx
	mulxq	-72(%rsp), %r14, %rsi           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-80(%rsp), %r15, %r13           # 8-byte Folded Reload
	adcq	%rsi, %r15
	mulxq	-88(%rsp), %r12, %rsi           # 8-byte Folded Reload
	adcq	%r13, %r12
	adcq	$0, %rsi
	addq	%rcx, %rbp
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rax, %r12
	adcq	$0, %rsi
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%rbp, %rdx
	mulxq	-24(%rsp), %rcx, %rax           # 8-byte Folded Reload
	addq	%rbp, %rcx
	mulxq	-96(%rsp), %rcx, %r13           # 8-byte Folded Reload
	adcq	%r11, %rcx
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-32(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-40(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rsi
	addq	%rax, %rcx
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rsi
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-56(%rsp), %rbx, %rax           # 8-byte Folded Reload
	mulxq	-128(%rsp), %rbp, %r11          # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-64(%rsp), %rbx, %r15           # 8-byte Folded Reload
	adcq	%rax, %rbx
	mulxq	-72(%rsp), %r14, %rax           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-80(%rsp), %r15, %r13           # 8-byte Folded Reload
	adcq	%rax, %r15
	mulxq	-88(%rsp), %r12, %rax           # 8-byte Folded Reload
	adcq	%r13, %r12
	adcq	$0, %rax
	addq	%rcx, %rbp
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rsi, %r12
	adcq	$0, %rax
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%rbp, %rdx
	mulxq	-24(%rsp), %rcx, %rsi           # 8-byte Folded Reload
	addq	%rbp, %rcx
	mulxq	-96(%rsp), %rcx, %r13           # 8-byte Folded Reload
	adcq	%r11, %rcx
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-32(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-40(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rax
	addq	%rsi, %rcx
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rax
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	movq	32(%rdx), %rdx
	mulxq	-56(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	mulxq	-128(%rsp), %rbp, %r11          # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-64(%rsp), %rbx, %r15           # 8-byte Folded Reload
	adcq	%rsi, %rbx
	mulxq	-72(%rsp), %r14, %rsi           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-80(%rsp), %r15, %r13           # 8-byte Folded Reload
	adcq	%rsi, %r15
	mulxq	-88(%rsp), %r12, %rsi           # 8-byte Folded Reload
	adcq	%r13, %r12
	adcq	$0, %rsi
	addq	%rcx, %rbp
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rax, %r12
	adcq	$0, %rsi
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%rbp, %rdx
	mulxq	-24(%rsp), %rcx, %rax           # 8-byte Folded Reload
	addq	%rbp, %rcx
	mulxq	-96(%rsp), %rcx, %r13           # 8-byte Folded Reload
	adcq	%r11, %rcx
	mulxq	-104(%rsp), %rdi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rdi
	mulxq	-112(%rsp), %r8, %rbx           # 8-byte Folded Reload
	adcq	%r14, %r8
	mulxq	-32(%rsp), %r9, %r14            # 8-byte Folded Reload
	adcq	%r15, %r9
	mulxq	-40(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r12, %r10
	adcq	$0, %rsi
	addq	%rax, %rcx
	adcq	%r13, %rdi
	adcq	%r11, %r8
	adcq	%rbx, %r9
	adcq	%r14, %r10
	adcq	%rdx, %rsi
	movq	-48(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdx
	mulxq	-56(%rsp), %rbx, %rax           # 8-byte Folded Reload
	mulxq	-128(%rsp), %rbp, %r11          # 8-byte Folded Reload
	addq	%rbx, %r11
	mulxq	-64(%rsp), %rbx, %r15           # 8-byte Folded Reload
	adcq	%rax, %rbx
	mulxq	-72(%rsp), %r14, %rax           # 8-byte Folded Reload
	adcq	%r15, %r14
	mulxq	-80(%rsp), %r15, %r13           # 8-byte Folded Reload
	adcq	%rax, %r15
	mulxq	-88(%rsp), %r12, %rax           # 8-byte Folded Reload
	adcq	%r13, %r12
	adcq	$0, %rax
	addq	%rcx, %rbp
	adcq	%rdi, %r11
	adcq	%r8, %rbx
	adcq	%r9, %r14
	adcq	%r10, %r15
	adcq	%rsi, %r12
	adcq	$0, %rax
	movq	-120(%rsp), %rdx                # 8-byte Reload
	imulq	%rbp, %rdx
	movq	-24(%rsp), %r10                 # 8-byte Reload
	mulxq	%r10, %rcx, %rsi
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	addq	%rbp, %rcx
	mulxq	-96(%rsp), %rcx, %rsi           # 8-byte Folded Reload
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	adcq	%r11, %rcx
	mulxq	-104(%rsp), %rsi, %r11          # 8-byte Folded Reload
	adcq	%rbx, %rsi
	mulxq	-112(%rsp), %rdi, %rbx          # 8-byte Folded Reload
	adcq	%r14, %rdi
	movq	-32(%rsp), %rbp                 # 8-byte Reload
	mulxq	%rbp, %r8, %r14
	adcq	%r15, %r8
	movq	-40(%rsp), %r13                 # 8-byte Reload
	mulxq	%r13, %rdx, %r15
	adcq	%r12, %rdx
	adcq	$0, %rax
	addq	-120(%rsp), %rcx                # 8-byte Folded Reload
	adcq	-128(%rsp), %rsi                # 8-byte Folded Reload
	adcq	%r11, %rdi
	adcq	%rbx, %r8
	adcq	%r14, %rdx
	adcq	%r15, %rax
	movq	%rcx, %r9
	subq	%r10, %r9
	movq	%rsi, %r10
	sbbq	-96(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdi, %r11
	sbbq	-104(%rsp), %r11                # 8-byte Folded Reload
	movq	%r8, %rbx
	sbbq	-112(%rsp), %rbx                # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	%rbp, %r14
	movq	%rax, %r15
	sbbq	%r13, %r15
	movq	%r15, %r12
	sarq	$63, %r12
	cmovsq	%rax, %r15
	movq	24(%rsp), %rax                  # 8-byte Reload
	movq	%r15, 40(%rax)
	cmovsq	%rdx, %r14
	movq	%r14, 32(%rax)
	cmovsq	%r8, %rbx
	movq	%rbx, 24(%rax)
	cmovsq	%rdi, %r11
	movq	%r11, 16(%rax)
	cmovsq	%rsi, %r10
	movq	%r10, 8(%rax)
	cmovsq	%rcx, %r9
	movq	%r9, (%rax)
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end142:
	.size	mcl_c5_fp_mul, .Lfunc_end142-mcl_c5_fp_mul
                                        # -- End function
	.globl	mcl_c5_fp_sqr                   # -- Begin function mcl_c5_fp_sqr
	.p2align	4
	.type	mcl_c5_fp_sqr,@function
mcl_c5_fp_sqr:                          # @mcl_c5_fp_sqr
# %bb.0:
	movq	%rsi, %rdx
	jmp	mcl_c5_fp_mul@PLT               # TAILCALL
.Lfunc_end143:
	.size	mcl_c5_fp_sqr, .Lfunc_end143-mcl_c5_fp_sqr
                                        # -- End function
	.globl	mcl_c5_fpDbl_mod                # -- Begin function mcl_c5_fpDbl_mod
	.p2align	4
	.type	mcl_c5_fpDbl_mod,@function
mcl_c5_fpDbl_mod:                       # @mcl_c5_fpDbl_mod
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rsi
	movq	.Lmcl_c5_fp_rp$local(%rip), %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	imulq	%rsi, %rcx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rdx, %rax
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rdx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rax, %r12
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rdx
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %r10, %r13
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r15
	movq	%r15, %rdx
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %r11, %rbp
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rdi
	movq	%rdi, %rdx
	movq	%rdi, -40(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %r14, %r8
	movq	.Lmcl_c5_fp_p$local(%rip), %rax
	movq	%rax, %rdx
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rcx, %rbx
	addq	%r14, %rbx
	adcq	%r11, %r8
	adcq	%r10, %rbp
	adcq	-16(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-64(%rsp), %r12                 # 8-byte Folded Reload
	movq	-96(%rsp), %rdx                 # 8-byte Reload
	adcq	$0, %rdx
	addq	%rsi, %rcx
	movq	%r9, -32(%rsp)                  # 8-byte Spill
	adcq	8(%r9), %rbx
	adcq	16(%r9), %r8
	adcq	24(%r9), %rbp
	adcq	32(%r9), %r13
	adcq	40(%r9), %r12
	adcq	48(%r9), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	setb	-64(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rbx, %r14
	movq	%rax, %rdx
	mulxq	%r14, %rsi, %rcx
	movq	%rdi, %rdx
	mulxq	%r14, %rax, %r9
	addq	%rcx, %rax
	movq	%r15, %rdx
	mulxq	%r14, %rdi, %r10
	adcq	%r9, %rdi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rcx, %r11
	adcq	%r10, %rcx
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %r15
	adcq	%r11, %r9
	movq	%r14, %rdx
	mulxq	-72(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%r15, %r10
	movzbl	-64(%rsp), %r11d                # 1-byte Folded Reload
	adcq	%rdx, %r11
	addq	%rbx, %rsi
	adcq	%r8, %rax
	adcq	%rbp, %rdi
	adcq	%r13, %rcx
	adcq	%r12, %r9
	adcq	-96(%rsp), %r10                 # 8-byte Folded Reload
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	adcq	56(%rdx), %r11
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rax, %r14
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rsi, %r8
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r15, %r13
	addq	%r8, %r15
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r12, %r8
	adcq	%r13, %r12
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rbp
	adcq	%r8, %r13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %rbx
	adcq	%rbp, %r8
	movq	%r14, %rdx
	mulxq	-72(%rsp), %rbp, %rdx           # 8-byte Folded Reload
	adcq	%rbx, %rbp
	movzbl	-96(%rsp), %ebx                 # 1-byte Folded Reload
	adcq	%rdx, %rbx
	addq	%rax, %rsi
	adcq	%rdi, %r15
	adcq	%rcx, %r12
	adcq	%r9, %r13
	adcq	%r10, %r8
	adcq	%r11, %rbp
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	64(%rax), %rbx
	setb	-64(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%r15, %r14
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %rcx
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rax, %r9
	addq	%rcx, %rax
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rdi, %r10
	adcq	%r9, %rdi
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rcx, %r11
	adcq	%r10, %rcx
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r9, %rsi
	adcq	%r11, %r9
	movq	%r14, %rdx
	mulxq	-72(%rsp), %r10, %rdx           # 8-byte Folded Reload
	adcq	%rsi, %r10
	movzbl	-64(%rsp), %r11d                # 1-byte Folded Reload
	adcq	%rdx, %r11
	addq	%r15, -96(%rsp)                 # 8-byte Folded Spill
	adcq	%r12, %rax
	adcq	%r13, %rdi
	adcq	%r8, %rcx
	adcq	%rbp, %r9
	adcq	%rbx, %r10
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	adcq	72(%rdx), %r11
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r14                 # 8-byte Reload
	imulq	%rax, %r14
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %rbp, %r8
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r15, %rbx
	addq	%r8, %r15
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r12, %r8
	adcq	%rbx, %r12
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r13, %rbx
	adcq	%r8, %r13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r14, %r8, %rsi
	adcq	%rbx, %r8
	movq	%r14, %rdx
	mulxq	-72(%rsp), %r14, %rdx           # 8-byte Folded Reload
	adcq	%rsi, %r14
	movzbl	-96(%rsp), %ebx                 # 1-byte Folded Reload
	adcq	%rdx, %rbx
	addq	%rax, %rbp
	adcq	%rdi, %r15
	adcq	%rcx, %r12
	adcq	%r9, %r13
	adcq	%r10, %r8
	adcq	%r11, %r14
	movq	-32(%rsp), %rax                 # 8-byte Reload
	adcq	80(%rax), %rbx
	setb	-96(%rsp)                       # 1-byte Folded Spill
	movq	-24(%rsp), %r11                 # 8-byte Reload
	imulq	%r15, %r11
	movq	-48(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r10, %rcx
	movq	-40(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rax, %rdi
	addq	%rcx, %rax
	movq	-56(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rcx, %r9
	adcq	%rdi, %rcx
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rdi, %rsi
	adcq	%r9, %rdi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %r9, %rbp
	adcq	%rsi, %r9
	movq	%r11, %rdx
	mulxq	-72(%rsp), %rdx, %r11           # 8-byte Folded Reload
	adcq	%rbp, %rdx
	movzbl	-96(%rsp), %esi                 # 1-byte Folded Reload
	adcq	%r11, %rsi
	addq	%r15, %r10
	adcq	%r12, %rax
	adcq	%r13, %rcx
	adcq	%r8, %rdi
	adcq	%r14, %r9
	adcq	%rbx, %rdx
	movq	-32(%rsp), %r8                  # 8-byte Reload
	adcq	88(%r8), %rsi
	movq	%rax, %r8
	subq	-48(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, %r10
	sbbq	-40(%rsp), %r10                 # 8-byte Folded Reload
	movq	%rdi, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r9, %rbx
	sbbq	-80(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rdx, %r14
	sbbq	-88(%rsp), %r14                 # 8-byte Folded Reload
	movq	%rsi, %r15
	sbbq	-72(%rsp), %r15                 # 8-byte Folded Reload
	movq	%r15, %r12
	sarq	$63, %r12
	cmovsq	%rdx, %r14
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	%r14, 32(%rdx)
	cmovsq	%rsi, %r15
	movq	%r15, 40(%rdx)
	cmovsq	%rdi, %r11
	movq	%r11, 16(%rdx)
	cmovsq	%r9, %rbx
	movq	%rbx, 24(%rdx)
	cmovsq	%rax, %r8
	movq	%r8, (%rdx)
	cmovsq	%rcx, %r10
	movq	%r10, 8(%rdx)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end144:
	.size	mcl_c5_fpDbl_mod, .Lfunc_end144-mcl_c5_fpDbl_mod
                                        # -- End function
	.p2align	4                               # -- Begin function mcl_c5_fpDbl_mulPre
	.type	.Lmcl_c5_fpDbl_mulPre,@function
.Lmcl_c5_fpDbl_mulPre:                  # @mcl_c5_fpDbl_mulPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r10
	movq	8(%rsi), %rbp
	movq	(%rdx), %rcx
	movq	%r10, %rdx
	movq	%r10, -16(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rax, %rdx
	movq	%rdx, -112(%rsp)                # 8-byte Spill
	movq	16(%rsi), %r15
	movq	%r15, -64(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %r9
	movq	%r9, -56(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %r8
	movq	40(%rsi), %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movq	%rax, (%rdi)
	movq	%rdi, %rsi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rdi, %r13
	movq	%r8, %rdx
	mulxq	%rcx, %rax, %rbx
	movq	%r9, %rdx
	mulxq	%rcx, %r14, %r11
	movq	%r15, %rdx
	mulxq	%rcx, %r12, %r9
	movq	%rbp, %rdx
	movq	%rbp, -40(%rsp)                 # 8-byte Spill
	mulxq	%rcx, %rcx, %r15
	addq	-112(%rsp), %rcx                # 8-byte Folded Reload
	adcq	%r12, %r15
	adcq	%r14, %r9
	adcq	%rax, %r11
	adcq	%rdi, %rbx
	adcq	$0, %r13
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	8(%rax), %rdx
	mulxq	%r10, %rdi, %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	setb	-104(%rsp)                      # 1-byte Folded Spill
	addq	%rcx, %rdi
	movq	%rdi, 8(%rsi)
	movq	-48(%rsp), %rcx                 # 8-byte Reload
	mulxq	%rcx, %r14, %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	%r8, %rax
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	mulxq	%r8, %r12, %rsi
	movq	%rsi, -96(%rsp)                 # 8-byte Spill
	movq	-56(%rsp), %r8                  # 8-byte Reload
	mulxq	%r8, %rdi, %rsi
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	mulxq	-64(%rsp), %rsi, %r10           # 8-byte Folded Reload
	movq	%r10, -8(%rsp)                  # 8-byte Spill
	mulxq	%rbp, %r10, %rdx
	adcq	%r15, %r10
	adcq	%r9, %rsi
	adcq	%r11, %rdi
	adcq	%rbx, %r12
	adcq	%r13, %r14
	movzbl	-104(%rsp), %ebp                # 1-byte Folded Reload
	adcq	$0, %rbp
	addq	-88(%rsp), %r10                 # 8-byte Folded Reload
	adcq	%rdx, %rsi
	adcq	-8(%rsp), %rdi                  # 8-byte Folded Reload
	adcq	-80(%rsp), %r12                 # 8-byte Folded Reload
	adcq	-96(%rsp), %r14                 # 8-byte Folded Reload
	adcq	-112(%rsp), %rbp                # 8-byte Folded Reload
	movq	-72(%rsp), %r11                 # 8-byte Reload
	movq	16(%r11), %rdx
	mulxq	%rcx, %r9, %rcx
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movq	%rcx, -88(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %r15
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	mulxq	%r8, %rax, %r13
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-40(%rsp), %rcx, %rbx           # 8-byte Folded Reload
	mulxq	-16(%rsp), %rax, %r9            # 8-byte Folded Reload
	addq	%rcx, %r9
	mulxq	-64(%rsp), %rcx, %r8            # 8-byte Folded Reload
	adcq	%rbx, %rcx
	adcq	-104(%rsp), %r8                 # 8-byte Folded Reload
	adcq	-96(%rsp), %r13                 # 8-byte Folded Reload
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	movq	-88(%rsp), %rbx                 # 8-byte Reload
	adcq	$0, %rbx
	addq	%r10, %rax
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rax, 16(%rdx)
	adcq	%rsi, %r9
	adcq	%rdi, %rcx
	adcq	%r12, %r8
	adcq	%r14, %r13
	adcq	%rbp, %r15
	adcq	$0, %rbx
	movq	%rbx, -88(%rsp)                 # 8-byte Spill
	movq	24(%r11), %rdx
	mulxq	-48(%rsp), %rsi, %rax           # 8-byte Folded Reload
	movq	%rsi, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -112(%rsp)                # 8-byte Spill
	mulxq	-32(%rsp), %rax, %r12           # 8-byte Folded Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-56(%rsp), %rax, %rbp           # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulxq	-40(%rsp), %rdi, %rsi           # 8-byte Folded Reload
	movq	-16(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %rax, %rbx
	addq	%rdi, %rbx
	movq	-64(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %rdi, %r10
	adcq	%rsi, %rdi
	adcq	-80(%rsp), %r10                 # 8-byte Folded Reload
	adcq	-104(%rsp), %rbp                # 8-byte Folded Reload
	adcq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	-112(%rsp), %rsi                # 8-byte Reload
	adcq	$0, %rsi
	addq	%r9, %rax
	movq	-24(%rsp), %rdx                 # 8-byte Reload
	movq	%rax, 24(%rdx)
	adcq	%rcx, %rbx
	adcq	%r8, %rdi
	adcq	%r13, %r10
	adcq	%r15, %rbp
	adcq	-88(%rsp), %r12                 # 8-byte Folded Reload
	adcq	$0, %rsi
	movq	%rsi, -112(%rsp)                # 8-byte Spill
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	32(%rax), %rdx
	mulxq	-48(%rsp), %rcx, %rax           # 8-byte Folded Reload
	movq	%rcx, -96(%rsp)                 # 8-byte Spill
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	mulxq	-32(%rsp), %rax, %r15           # 8-byte Folded Reload
	movq	%rax, -104(%rsp)                # 8-byte Spill
	mulxq	-56(%rsp), %rax, %r13           # 8-byte Folded Reload
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	mulxq	-40(%rsp), %rsi, %r9            # 8-byte Folded Reload
	mulxq	%r14, %rax, %rcx
	addq	%rsi, %rcx
	mulxq	%r11, %rsi, %r8
	adcq	%r9, %rsi
	adcq	-80(%rsp), %r8                  # 8-byte Folded Reload
	adcq	-104(%rsp), %r13                # 8-byte Folded Reload
	adcq	-96(%rsp), %r15                 # 8-byte Folded Reload
	movq	-88(%rsp), %r11                 # 8-byte Reload
	adcq	$0, %r11
	addq	%rbx, %rax
	movq	-24(%rsp), %r9                  # 8-byte Reload
	movq	%rax, 32(%r9)
	adcq	%rdi, %rcx
	adcq	%r10, %rsi
	adcq	%rbp, %r8
	adcq	%r12, %r13
	movq	-72(%rsp), %rax                 # 8-byte Reload
	movq	40(%rax), %rdx
	adcq	-112(%rsp), %r15                # 8-byte Folded Reload
	mulxq	-40(%rsp), %rdi, %rax           # 8-byte Folded Reload
	mulxq	%r14, %rbp, %r10
	adcq	$0, %r11
	addq	%rdi, %r10
	mulxq	-64(%rsp), %rbx, %rdi           # 8-byte Folded Reload
	adcq	%rax, %rbx
	mulxq	-56(%rsp), %r14, %rax           # 8-byte Folded Reload
	adcq	%rdi, %r14
	mulxq	-32(%rsp), %r12, %rdi           # 8-byte Folded Reload
	adcq	%rax, %r12
	mulxq	-48(%rsp), %rax, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %rax
	adcq	$0, %rdx
	addq	%rbp, %rcx
	movq	%rcx, 40(%r9)
	adcq	%rsi, %r10
	movq	%r10, 48(%r9)
	adcq	%r8, %rbx
	movq	%rbx, 56(%r9)
	adcq	%r13, %r14
	movq	%r14, 64(%r9)
	adcq	%r15, %r12
	movq	%r12, 72(%r9)
	adcq	%r11, %rax
	movq	%rax, 80(%r9)
	adcq	$0, %rdx
	movq	%rdx, 88(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end145:
	.size	.Lmcl_c5_fpDbl_mulPre, .Lfunc_end145-.Lmcl_c5_fpDbl_mulPre
                                        # -- End function
	.globl	mcl_c5_fpDbl_add                # -- Begin function mcl_c5_fpDbl_add
	.p2align	4
	.type	mcl_c5_fpDbl_add,@function
mcl_c5_fpDbl_add:                       # @mcl_c5_fpDbl_add
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	88(%rdx), %r10
	movq	80(%rdx), %r11
	movq	72(%rdx), %r8
	movq	64(%rdx), %r9
	movq	56(%rdx), %rax
	movq	48(%rdx), %rcx
	movq	40(%rdx), %r15
	movq	(%rdx), %rbx
	movq	8(%rdx), %r14
	addq	(%rsi), %rbx
	adcq	8(%rsi), %r14
	movq	32(%rdx), %r12
	movq	24(%rdx), %r13
	movq	16(%rdx), %rdx
	adcq	16(%rsi), %rdx
	adcq	24(%rsi), %r13
	adcq	32(%rsi), %r12
	adcq	40(%rsi), %r15
	adcq	48(%rsi), %rcx
	adcq	56(%rsi), %rax
	adcq	64(%rsi), %r9
	adcq	72(%rsi), %r8
	adcq	80(%rsi), %r11
	adcq	88(%rsi), %r10
	movq	%r15, 40(%rdi)
	movq	%r12, 32(%rdi)
	movq	%r13, 24(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%r14, 8(%rdi)
	movq	%rbx, (%rdi)
	setb	%dl
	movzbl	%dl, %esi
	movq	%rcx, %rbx
	subq	.Lmcl_c5_fp_p$local(%rip), %rbx
	movq	%rax, %rdx
	sbbq	.Lmcl_c5_fp_p$local+8(%rip), %rdx
	movq	%r9, %r14
	sbbq	.Lmcl_c5_fp_p$local+16(%rip), %r14
	movq	%r8, %r15
	sbbq	.Lmcl_c5_fp_p$local+24(%rip), %r15
	movq	%r11, %r12
	sbbq	.Lmcl_c5_fp_p$local+32(%rip), %r12
	movq	%r10, %r13
	sbbq	.Lmcl_c5_fp_p$local+40(%rip), %r13
	sbbq	$0, %rsi
	testb	$1, %sil
	cmovneq	%r11, %r12
	movq	%r12, 80(%rdi)
	cmovneq	%r10, %r13
	movq	%r13, 88(%rdi)
	cmovneq	%r9, %r14
	movq	%r14, 64(%rdi)
	cmovneq	%r8, %r15
	movq	%r15, 72(%rdi)
	cmovneq	%rcx, %rbx
	movq	%rbx, 48(%rdi)
	cmovneq	%rax, %rdx
	movq	%rdx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end146:
	.size	mcl_c5_fpDbl_add, .Lfunc_end146-mcl_c5_fpDbl_add
                                        # -- End function
	.globl	mcl_c5_fpDbl_sub                # -- Begin function mcl_c5_fpDbl_sub
	.p2align	4
	.type	mcl_c5_fpDbl_sub,@function
mcl_c5_fpDbl_sub:                       # @mcl_c5_fpDbl_sub
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	88(%rsi), %rax
	movq	80(%rsi), %rcx
	movq	72(%rsi), %r8
	movq	64(%rsi), %r9
	movq	56(%rsi), %r10
	movq	48(%rsi), %r11
	movq	(%rsi), %r14
	movq	8(%rsi), %r15
	xorl	%ebx, %ebx
	subq	(%rdx), %r14
	sbbq	8(%rdx), %r15
	movq	40(%rsi), %r12
	movq	32(%rsi), %r13
	movq	24(%rsi), %rbp
	movq	16(%rsi), %rsi
	sbbq	16(%rdx), %rsi
	sbbq	24(%rdx), %rbp
	sbbq	32(%rdx), %r13
	sbbq	40(%rdx), %r12
	sbbq	48(%rdx), %r11
	sbbq	56(%rdx), %r10
	sbbq	64(%rdx), %r9
	sbbq	72(%rdx), %r8
	sbbq	80(%rdx), %rcx
	sbbq	88(%rdx), %rax
	movq	%r12, 40(%rdi)
	movq	%r13, 32(%rdi)
	movq	%rbp, 24(%rdi)
	movq	%rsi, 16(%rdi)
	movq	%r15, 8(%rdi)
	movq	%r14, (%rdi)
	sbbq	%rbx, %rbx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rdx
	andq	%rbx, %rdx
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rsi
	andq	%rbx, %rsi
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r14
	andq	%rbx, %r14
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r15
	andq	%rbx, %r15
	movq	.Lmcl_c5_fp_p$local+8(%rip), %r12
	andq	%rbx, %r12
	andq	.Lmcl_c5_fp_p$local(%rip), %rbx
	addq	%r11, %rbx
	movq	%rbx, 48(%rdi)
	adcq	%r10, %r12
	movq	%r12, 56(%rdi)
	adcq	%r9, %r15
	movq	%r15, 64(%rdi)
	adcq	%r8, %r14
	movq	%r14, 72(%rdi)
	adcq	%rcx, %rsi
	movq	%rsi, 80(%rdi)
	adcq	%rax, %rdx
	movq	%rdx, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end147:
	.size	mcl_c5_fpDbl_sub, .Lfunc_end147-mcl_c5_fpDbl_sub
                                        # -- End function
	.globl	mcl_c5_fp2_add                  # -- Begin function mcl_c5_fp2_add
	.p2align	4
	.type	mcl_c5_fp2_add,@function
mcl_c5_fp2_add:                         # @mcl_c5_fp2_add
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rbx
	movq	%rbx, -8(%rsp)                  # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r15
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+8(%rip), %r13
	movq	%r13, -32(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local(%rip), %r11
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %rbp
	movq	32(%rsi), %r14
	movq	24(%rsi), %r10
	movq	16(%rsi), %r8
	movq	(%rsi), %rax
	movq	8(%rsi), %rcx
	addq	(%rdx), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	adcq	8(%rdx), %rcx
	adcq	16(%rdx), %r8
	adcq	24(%rdx), %r10
	adcq	32(%rdx), %r14
	adcq	40(%rdx), %rbp
	movq	%rbp, %r9
	movq	%rax, %rbp
	subq	%r11, %rbp
	movq	%rcx, %rax
	sbbq	%r13, %rax
	movq	%r8, %r13
	sbbq	%r12, %r13
	movq	%r10, %r12
	sbbq	%r15, %r12
	movq	%r14, %r15
	sbbq	%rbx, %r15
	movq	%r9, %r11
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, %rbx
	sarq	$63, %rbx
	cmovsq	%rcx, %rax
	movq	%rax, 8(%rdi)
	cmovsq	%r8, %r13
	movq	%r13, 16(%rdi)
	cmovsq	%r10, %r12
	movq	%r12, 24(%rdi)
	cmovsq	%r14, %r15
	movq	%r15, 32(%rdi)
	cmovsq	%r9, %r11
	movq	%r11, 40(%rdi)
	cmovsq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%rbp, (%rdi)
	movq	88(%rsi), %r12
	movq	80(%rsi), %r13
	movq	72(%rsi), %r14
	movq	64(%rsi), %r15
	movq	48(%rsi), %rbx
	movq	56(%rsi), %rsi
	addq	48(%rdx), %rbx
	adcq	56(%rdx), %rsi
	adcq	64(%rdx), %r15
	adcq	72(%rdx), %r14
	adcq	80(%rdx), %r13
	adcq	88(%rdx), %r12
	movq	%rbx, %rax
	subq	-40(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rsi, %rcx
	sbbq	-32(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sbbq	-24(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r14, %r8
	sbbq	-16(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r13, %r9
	sbbq	-8(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r12, %r10
	sbbq	-56(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r10, %r11
	sarq	$63, %r11
	cmovsq	%r13, %r9
	movq	%r9, 80(%rdi)
	cmovsq	%r12, %r10
	movq	%r10, 88(%rdi)
	cmovsq	%r15, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r14, %r8
	movq	%r8, 72(%rdi)
	cmovsq	%rbx, %rax
	movq	%rax, 48(%rdi)
	cmovsq	%rsi, %rcx
	movq	%rcx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end148:
	.size	mcl_c5_fp2_add, .Lfunc_end148-mcl_c5_fp2_add
                                        # -- End function
	.globl	mcl_c5_fp2_sub                  # -- Begin function mcl_c5_fp2_sub
	.p2align	4
	.type	mcl_c5_fp2_sub,@function
mcl_c5_fp2_sub:                         # @mcl_c5_fp2_sub
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r8
	movq	%rdi, %r10
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+16(%rip), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rdx
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+40(%rip), %rdi
	movq	%rdi, -32(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local(%rip), %r9
	movq	%r9, -8(%rsp)                   # 8-byte Spill
	movq	40(%rsi), %r11
	movq	32(%rsi), %r14
	movq	24(%rsi), %r15
	movq	16(%rsi), %r12
	movq	(%rsi), %rbp
	movq	8(%rsi), %r13
	subq	(%r8), %rbp
	sbbq	8(%r8), %r13
	sbbq	16(%r8), %r12
	sbbq	24(%r8), %r15
	sbbq	32(%r8), %r14
	sbbq	40(%r8), %r11
	movq	%r11, %rbx
	sarq	$63, %rbx
	movq	%rbx, %rax
	shldq	$1, %r11, %rax
	andq	%r9, %rax
	movq	%rbx, %r9
	andq	%rdi, %r9
	movq	%rbx, %rdi
	andq	%rdx, %rdi
	movq	%rbx, %rdx
	andq	%rcx, %rdx
	movq	%rbx, %rcx
	andq	-48(%rsp), %rcx                 # 8-byte Folded Reload
	andq	-40(%rsp), %rbx                 # 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%r13, %rbx
	movq	%rax, (%r10)
	adcq	%r12, %rcx
	movq	%rbx, 8(%r10)
	adcq	%r15, %rdx
	movq	%rcx, 16(%r10)
	adcq	%r14, %rdi
	movq	%rdx, 24(%r10)
	movq	%rdi, 32(%r10)
	adcq	%r11, %r9
	movq	%r9, 40(%r10)
	movq	88(%rsi), %rbx
	movq	80(%rsi), %r14
	movq	72(%rsi), %r15
	movq	64(%rsi), %r12
	movq	48(%rsi), %r13
	movq	56(%rsi), %rsi
	subq	48(%r8), %r13
	sbbq	56(%r8), %rsi
	sbbq	64(%r8), %r12
	sbbq	72(%r8), %r15
	sbbq	80(%r8), %r14
	sbbq	88(%r8), %rbx
	movq	%rbx, %rax
	sarq	$63, %rax
	movq	%rax, %rcx
	shldq	$1, %rbx, %rcx
	andq	-8(%rsp), %rcx                  # 8-byte Folded Reload
	movq	-32(%rsp), %rdx                 # 8-byte Reload
	andq	%rax, %rdx
	movq	-24(%rsp), %rdi                 # 8-byte Reload
	andq	%rax, %rdi
	movq	-16(%rsp), %r8                  # 8-byte Reload
	andq	%rax, %r8
	movq	-48(%rsp), %r9                  # 8-byte Reload
	andq	%rax, %r9
	andq	-40(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r13, %rcx
	movq	%rcx, 48(%r10)
	adcq	%rsi, %rax
	movq	%rax, 56(%r10)
	movq	%r9, %rax
	adcq	%r12, %rax
	movq	%rax, 64(%r10)
	movq	%r8, %rax
	adcq	%r15, %rax
	movq	%rax, 72(%r10)
	movq	%rdi, %rax
	adcq	%r14, %rax
	movq	%rax, 80(%r10)
	movq	%rdx, %rax
	adcq	%rbx, %rax
	movq	%rax, 88(%r10)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end149:
	.size	mcl_c5_fp2_sub, .Lfunc_end149-mcl_c5_fp2_sub
                                        # -- End function
	.globl	mcl_c5_fp2_neg                  # -- Begin function mcl_c5_fp2_neg
	.p2align	4
	.type	mcl_c5_fp2_neg,@function
mcl_c5_fp2_neg:                         # @mcl_c5_fp2_neg
# %bb.0:                                # %L72
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	40(%rsi), %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	(%rsi), %rcx
	movq	8(%rsi), %r8
	movq	%r8, %rax
	orq	%rdx, %rax
	movq	24(%rsi), %r9
	orq	%r9, %rax
	movq	32(%rsi), %rbp
	movq	%rcx, %rdx
	orq	%rbp, %rdx
	movq	16(%rsi), %r12
	orq	%r12, %rdx
	movq	.Lmcl_c5_fp_p$local+8(%rip), %r10
	movq	%r10, -24(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local(%rip), %r14
	movq	%r14, %r11
	subq	%rcx, %r11
	movq	%r11, %rcx
	sbbq	%r8, %r10
	movq	%r10, %r8
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r11
	movq	%r11, %r15
	sbbq	%r12, %r15
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r10
	movq	%r10, %r12
	sbbq	%r9, %r12
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rbx
	movq	%rbx, %r13
	sbbq	%rbp, %r13
	movq	.Lmcl_c5_fp_p$local+40(%rip), %r9
	movq	%r9, %rbp
	sbbq	-32(%rsp), %rbp                 # 8-byte Folded Reload
	orq	%rax, %rdx
	movl	$0, %eax
	cmoveq	%rax, %r8
	movq	%r8, -32(%rsp)                  # 8-byte Spill
	cmoveq	%rax, %r15
	cmoveq	%rax, %rcx
	movq	%rcx, -8(%rsp)                  # 8-byte Spill
	cmoveq	%rax, %r12
	cmoveq	%rax, %r13
	cmoveq	%rax, %rbp
	movq	88(%rsi), %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %rcx
	movq	%rcx, %rdx
	orq	%rax, %rdx
	movq	48(%rsi), %rax
	subq	%rax, %r14
	sbbq	%rcx, -24(%rsp)                 # 8-byte Folded Spill
	movq	80(%rsi), %r8
	movq	72(%rsi), %rcx
	movq	64(%rsi), %rsi
	sbbq	%rsi, %r11
	sbbq	%rcx, %r10
	sbbq	%r8, %rbx
	sbbq	-16(%rsp), %r9                  # 8-byte Folded Reload
	orq	%rcx, %rdx
	orq	%r8, %rax
	orq	%rsi, %rax
	orq	%rdx, %rax
	movq	-32(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 8(%rdi)
	movq	%r15, 16(%rdi)
	movq	-8(%rsp), %rax                  # 8-byte Reload
	movq	%rax, (%rdi)
	movq	%r12, 24(%rdi)
	movq	%r13, 32(%rdi)
	movq	%rbp, 40(%rdi)
	movl	$0, %ecx
	cmoveq	%rcx, %r11
	movq	%r11, 64(%rdi)
	cmoveq	%rcx, %r14
	movq	%r14, 48(%rdi)
	movq	-24(%rsp), %rax                 # 8-byte Reload
	cmoveq	%rcx, %rax
	movq	%rax, 56(%rdi)
	cmoveq	%rcx, %r10
	movq	%r10, 72(%rdi)
	cmoveq	%rcx, %rbx
	movl	$0, %eax
	movq	%rbx, 80(%rdi)
	cmoveq	%rax, %r9
	movq	%r9, 88(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end150:
	.size	mcl_c5_fp2_neg, .Lfunc_end150-mcl_c5_fp2_neg
                                        # -- End function
	.globl	mcl_c5_fp2_mul2                 # -- Begin function mcl_c5_fp2_mul2
	.p2align	4
	.type	mcl_c5_fp2_mul2,@function
mcl_c5_fp2_mul2:                        # @mcl_c5_fp2_mul2
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %r11
	movq	%r11, -8(%rsp)                  # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+32(%rip), %r9
	movq	%r9, -16(%rsp)                  # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r14
	movq	%r14, -24(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+16(%rip), %r15
	movq	%r15, -32(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+8(%rip), %r12
	movq	%r12, -40(%rsp)                 # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local(%rip), %rbp
	movq	%rbp, -48(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %r10
	movq	32(%rsi), %r8
	movq	24(%rsi), %rdx
	movq	16(%rsi), %rcx
	movq	(%rsi), %rbx
	movq	8(%rsi), %rax
	addq	(%rsi), %rbx
	adcq	8(%rsi), %rax
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rdx
	adcq	32(%rsi), %r8
	adcq	40(%rsi), %r10
	movq	%rbx, %r13
	subq	%rbp, %r13
	movq	%rax, %rbp
	sbbq	%r12, %rbp
	movq	%rcx, %r12
	sbbq	%r15, %r12
	movq	%rdx, %r15
	sbbq	%r14, %r15
	movq	%r8, %r14
	sbbq	%r9, %r14
	movq	%r10, %r9
	sbbq	%r11, %r9
	movq	%r9, %r11
	sarq	$63, %r11
	cmovsq	%rax, %rbp
	movq	%rbp, 8(%rdi)
	cmovsq	%rcx, %r12
	movq	%r12, 16(%rdi)
	cmovsq	%rdx, %r15
	movq	%r15, 24(%rdi)
	cmovsq	%r8, %r14
	movq	%r14, 32(%rdi)
	cmovsq	%r10, %r9
	movq	%r9, 40(%rdi)
	cmovsq	%rbx, %r13
	movq	%r13, (%rdi)
	movq	88(%rsi), %r12
	movq	80(%rsi), %r13
	movq	72(%rsi), %r14
	movq	64(%rsi), %r15
	movq	48(%rsi), %rbx
	movq	56(%rsi), %r11
	addq	48(%rsi), %rbx
	adcq	56(%rsi), %r11
	adcq	64(%rsi), %r15
	adcq	72(%rsi), %r14
	adcq	80(%rsi), %r13
	adcq	88(%rsi), %r12
	movq	%rbx, %rax
	subq	-48(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r11, %rcx
	sbbq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r15, %rdx
	sbbq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%r14, %rsi
	sbbq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r13, %r8
	sbbq	-16(%rsp), %r8                  # 8-byte Folded Reload
	movq	%r12, %r9
	sbbq	-8(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r9, %r10
	sarq	$63, %r10
	cmovsq	%r13, %r8
	movq	%r8, 80(%rdi)
	cmovsq	%r12, %r9
	movq	%r9, 88(%rdi)
	cmovsq	%r15, %rdx
	movq	%rdx, 64(%rdi)
	cmovsq	%r14, %rsi
	movq	%rsi, 72(%rdi)
	cmovsq	%rbx, %rax
	movq	%rax, 48(%rdi)
	cmovsq	%r11, %rcx
	movq	%rcx, 56(%rdi)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end151:
	.size	mcl_c5_fp2_mul2, .Lfunc_end151-mcl_c5_fp2_mul2
                                        # -- End function
	.globl	mcl_c5_fp2_mul                  # -- Begin function mcl_c5_fp2_mul
	.p2align	4
	.type	mcl_c5_fp2_mul,@function
mcl_c5_fp2_mul:                         # @mcl_c5_fp2_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$568, %rsp                      # imm = 0x238
	movq	%rdx, %r12
	movq	%rsi, %r13
	movq	%rdi, 272(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%r13), %rdx
	movq	64(%r13), %rcx
	movq	48(%r13), %rax
	movq	56(%r13), %r8
	addq	(%r13), %rax
	adcq	8(%r13), %r8
	adcq	16(%r13), %rcx
	adcq	24(%r13), %rdx
	adcq	32(%r13), %rsi
	adcq	40(%r13), %rdi
	movq	64(%r12), %r9
	movq	48(%r12), %r10
	movq	56(%r12), %r11
	addq	(%r12), %r10
	adcq	8(%r12), %r11
	adcq	16(%r12), %r9
	movq	72(%r12), %rbx
	adcq	24(%r12), %rbx
	movq	80(%r12), %r14
	adcq	32(%r12), %r14
	movq	88(%r12), %r15
	adcq	40(%r12), %r15
	movq	%r15, 416(%rsp)
	movq	%r14, 408(%rsp)
	movq	%rbx, 400(%rsp)
	movq	%r9, 392(%rsp)
	movq	%r11, 384(%rsp)
	movq	%r10, 376(%rsp)
	movq	%rdi, 464(%rsp)
	movq	%rsi, 456(%rsp)
	movq	%rdx, 448(%rsp)
	movq	%rcx, 440(%rsp)
	movq	%r8, 432(%rsp)
	movq	%rax, 424(%rsp)
	leaq	280(%rsp), %rdi
	leaq	424(%rsp), %rsi
	leaq	376(%rsp), %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	movq	%rsp, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	addq	$48, %r13
	addq	$48, %r12
	leaq	472(%rsp), %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	movq	504(%rsp), %r9
	movq	%r9, 256(%rsp)                  # 8-byte Spill
	movq	32(%rsp), %rax
	movq	%rax, 264(%rsp)                 # 8-byte Spill
	movq	496(%rsp), %r10
	movq	%r10, 232(%rsp)                 # 8-byte Spill
	movq	24(%rsp), %rcx
	movq	%rcx, 248(%rsp)                 # 8-byte Spill
	movq	488(%rsp), %r11
	movq	%r11, 200(%rsp)                 # 8-byte Spill
	movq	16(%rsp), %rdx
	movq	%rdx, 216(%rsp)                 # 8-byte Spill
	movq	472(%rsp), %r8
	movq	%r8, 152(%rsp)                  # 8-byte Spill
	movq	480(%rsp), %rdi
	movq	%rdi, 160(%rsp)                 # 8-byte Spill
	movq	(%rsp), %r15
	movq	%r15, 184(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %rbx
	movq	%rbx, 176(%rsp)                 # 8-byte Spill
	addq	%r8, %r15
	adcq	%rdi, %rbx
	movq	%rdx, %rdi
	adcq	%r11, %rdi
	movq	%rcx, %rdx
	adcq	%r10, %rdx
	movq	%rax, %rcx
	adcq	%r9, %rcx
	movq	512(%rsp), %rax
	movq	%rax, 224(%rsp)                 # 8-byte Spill
	movq	40(%rsp), %r14
	movq	%r14, 240(%rsp)                 # 8-byte Spill
	adcq	%rax, %r14
	movq	520(%rsp), %rax
	movq	%rax, 192(%rsp)                 # 8-byte Spill
	movq	48(%rsp), %r9
	movq	%r9, 208(%rsp)                  # 8-byte Spill
	adcq	%rax, %r9
	movq	528(%rsp), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	56(%rsp), %r10
	movq	%r10, 168(%rsp)                 # 8-byte Spill
	adcq	%rax, %r10
	movq	536(%rsp), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movq	64(%rsp), %r11
	movq	%r11, 136(%rsp)                 # 8-byte Spill
	adcq	%rax, %r11
	movq	544(%rsp), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movq	72(%rsp), %r12
	movq	%r12, 112(%rsp)                 # 8-byte Spill
	adcq	%rax, %r12
	movq	552(%rsp), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	movq	80(%rsp), %r8
	movq	%r8, %r13
	adcq	%rax, %r13
	movq	560(%rsp), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rsi
	movq	%rsi, %rbp
	adcq	%rax, %rbp
	subq	%r15, 280(%rsp)
	sbbq	%rbx, 288(%rsp)
	sbbq	%rdi, 296(%rsp)
	sbbq	%rdx, 304(%rsp)
	sbbq	%rcx, 312(%rsp)
	sbbq	%r14, 320(%rsp)
	sbbq	%r9, 328(%rsp)
	sbbq	%r10, 336(%rsp)
	sbbq	%r11, 344(%rsp)
	sbbq	%r12, 352(%rsp)
	sbbq	%r13, 360(%rsp)
	sbbq	%rbp, 368(%rsp)
	movq	184(%rsp), %rax                 # 8-byte Reload
	subq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	176(%rsp), %rdi                 # 8-byte Reload
	sbbq	160(%rsp), %rdi                 # 8-byte Folded Reload
	movq	216(%rsp), %r9                  # 8-byte Reload
	sbbq	200(%rsp), %r9                  # 8-byte Folded Reload
	movq	248(%rsp), %r10                 # 8-byte Reload
	sbbq	232(%rsp), %r10                 # 8-byte Folded Reload
	movq	264(%rsp), %r11                 # 8-byte Reload
	sbbq	256(%rsp), %r11                 # 8-byte Folded Reload
	movq	240(%rsp), %rbx                 # 8-byte Reload
	sbbq	224(%rsp), %rbx                 # 8-byte Folded Reload
	movq	208(%rsp), %r14                 # 8-byte Reload
	sbbq	192(%rsp), %r14                 # 8-byte Folded Reload
	movq	168(%rsp), %r12                 # 8-byte Reload
	sbbq	144(%rsp), %r12                 # 8-byte Folded Reload
	movq	136(%rsp), %r13                 # 8-byte Reload
	sbbq	128(%rsp), %r13                 # 8-byte Folded Reload
	movq	112(%rsp), %r15                 # 8-byte Reload
	sbbq	120(%rsp), %r15                 # 8-byte Folded Reload
	sbbq	104(%rsp), %r8                  # 8-byte Folded Reload
	sbbq	96(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%rsi, %rcx
	shrq	$60, %rcx
	andl	$-8, %ecx
	leaq	.Lmcl_c5_fp_sub_tbl$local(%rip), %rdx
	addq	(%rdx,%rcx,8), %r14
	adcq	8(%rdx,%rcx,8), %r12
	adcq	16(%rdx,%rcx,8), %r13
	adcq	24(%rdx,%rcx,8), %r15
	adcq	32(%rdx,%rcx,8), %r8
	adcq	40(%rdx,%rcx,8), %rsi
	movq	%rax, (%rsp)
	movq	%rdi, 8(%rsp)
	movq	%r9, 16(%rsp)
	movq	%r10, 24(%rsp)
	movq	%r11, 32(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%r14, 48(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	movq	%r15, 72(%rsp)
	movq	%r8, 80(%rsp)
	movq	%rsi, 88(%rsp)
	movq	272(%rsp), %rbx                 # 8-byte Reload
	movq	%rbx, %rdi
	movq	%rsp, %rsi
	callq	mcl_c5_fpDbl_mod@PLT
	addq	$48, %rbx
	movq	%rbx, %rdi
	leaq	280(%rsp), %rsi
	callq	mcl_c5_fpDbl_mod@PLT
	addq	$568, %rsp                      # imm = 0x238
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end152:
	.size	mcl_c5_fp2_mul, .Lfunc_end152-mcl_c5_fp2_mul
                                        # -- End function
	.globl	mcl_c5_fp2_sqr                  # -- Begin function mcl_c5_fp2_sqr
	.p2align	4
	.type	mcl_c5_fp2_sqr,@function
mcl_c5_fp2_sqr:                         # @mcl_c5_fp2_sqr
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$248, %rsp
	movq	%rsi, %rdx
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movq	80(%rsi), %r15
	movq	%r15, 8(%rsp)                   # 8-byte Spill
	movq	72(%rsi), %r9
	movq	24(%rsi), %rcx
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	movq	64(%rsi), %r8
	movq	16(%rsi), %rbx
	movq	%rbx, 56(%rsp)                  # 8-byte Spill
	movq	56(%rsi), %rbp
	movq	48(%rsi), %rax
	movq	(%rsi), %r12
	movq	%r12, 24(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %r14
	movq	%r14, 32(%rsp)                  # 8-byte Spill
	subq	%rax, %r12
	sbbq	%rbp, %r14
	sbbq	%r8, %rbx
	sbbq	%r9, %rcx
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	sbbq	%r15, %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	movq	88(%rsi), %r10
	movq	40(%rsi), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	sbbq	%r10, %rcx
	movq	%rcx, 72(%rsp)                  # 8-byte Spill
	movq	%rbp, %rcx
	shldq	$1, %rax, %rcx
	movq	%r9, %rdi
	shldq	$1, %r8, %rdi
	movq	%r8, %rsi
	shldq	$1, %rbp, %rsi
	movq	%r10, %r11
	shldq	$1, %r15, %r11
	shldq	$1, %r9, %r15
	leaq	(%rax,%rax), %r13
	movq	%r13, 16(%rsp)                  # 8-byte Spill
	addq	24(%rsp), %rax                  # 8-byte Folded Reload
	adcq	32(%rsp), %rbp                  # 8-byte Folded Reload
	movq	%r15, 232(%rsp)
	movq	%r11, 240(%rsp)
	movq	%rsi, 216(%rsp)
	movq	%rdi, 224(%rsp)
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 200(%rsp)
	movq	%rcx, 208(%rsp)
	movq	%rax, 152(%rsp)
	adcq	56(%rsp), %r8                   # 8-byte Folded Reload
	movq	%rbp, 160(%rsp)
	adcq	64(%rsp), %r9                   # 8-byte Folded Reload
	movq	8(%rsp), %rax                   # 8-byte Reload
	adcq	48(%rsp), %rax                  # 8-byte Folded Reload
	adcq	40(%rsp), %r10                  # 8-byte Folded Reload
	addq	.Lmcl_c5_fp_p$local(%rip), %r12
	movq	%r12, 104(%rsp)
	movq	%r8, 168(%rsp)
	adcq	.Lmcl_c5_fp_p$local+8(%rip), %r14
	movq	%r14, 112(%rsp)
	movq	%r9, 176(%rsp)
	adcq	.Lmcl_c5_fp_p$local+16(%rip), %rbx
	movq	%rbx, 120(%rsp)
	movq	%rax, 184(%rsp)
	movq	80(%rsp), %rax                  # 8-byte Reload
	adcq	.Lmcl_c5_fp_p$local+24(%rip), %rax
	movq	%rax, 128(%rsp)
	movq	%r10, 192(%rsp)
	movq	88(%rsp), %rax                  # 8-byte Reload
	adcq	.Lmcl_c5_fp_p$local+32(%rip), %rax
	movq	%rax, 136(%rsp)
	movq	72(%rsp), %rax                  # 8-byte Reload
	adcq	.Lmcl_c5_fp_p$local+40(%rip), %rax
	movq	%rax, 144(%rsp)
	movq	96(%rsp), %rbx                  # 8-byte Reload
	leaq	48(%rbx), %rdi
	leaq	200(%rsp), %rsi
	callq	mcl_c5_fp_mul@PLT
	leaq	152(%rsp), %rsi
	leaq	104(%rsp), %rdx
	movq	%rbx, %rdi
	callq	mcl_c5_fp_mul@PLT
	addq	$248, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end153:
	.size	mcl_c5_fp2_sqr, .Lfunc_end153-mcl_c5_fp2_sqr
                                        # -- End function
	.globl	mcl_c5_fp2_mul_xi               # -- Begin function mcl_c5_fp2_mul_xi
	.p2align	4
	.type	mcl_c5_fp2_mul_xi,@function
mcl_c5_fp2_mul_xi:                      # @mcl_c5_fp2_mul_xi
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	40(%rsi), %r10
	movq	%r10, -64(%rsp)                 # 8-byte Spill
	movq	88(%rsi), %rbx
	movq	%rbx, -8(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	80(%rsi), %r11
	movq	%r11, -16(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %rcx
	movq	%rcx, -48(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %r12
	movq	%r12, -24(%rsp)                 # 8-byte Spill
	movq	16(%rsi), %rdx
	movq	%rdx, -56(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %r15
	movq	%r15, -32(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %r14
	movq	%r14, -80(%rsp)                 # 8-byte Spill
	movq	(%rsi), %r9
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r8
	movq	%r8, -104(%rsp)                 # 8-byte Spill
	movq	48(%rsi), %rsi
	movq	%rsi, -88(%rsp)                 # 8-byte Spill
	addq	%r9, %rsi
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	adcq	%r8, %r14
	adcq	%rdx, %r15
	movq	%r12, %r8
	adcq	%rcx, %r8
	movq	%r11, %r12
	adcq	%rax, %r12
	movq	%rbx, %r11
	adcq	%r10, %r11
	movq	.Lmcl_c5_fp_p$local(%rip), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rsi, %rcx
	subq	%rax, %rcx
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rdx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movq	%r14, %rax
	sbbq	%rdx, %rax
	movq	.Lmcl_c5_fp_p$local+16(%rip), %rbp
	movq	%r15, %r9
	sbbq	%rbp, %r9
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rsi
	movq	%rsi, -96(%rsp)                 # 8-byte Spill
	movq	%r8, %rdx
	sbbq	%rsi, %rdx
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rsi
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	movq	%r12, %rbx
	sbbq	%rsi, %rbx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %r13
	movq	%r11, %r10
	sbbq	%r13, %r10
	movq	%r10, %rsi
	sarq	$63, %rsi
	cmovsq	%r14, %rax
	cmovsq	%r8, %rdx
	cmovsq	%r15, %r9
	cmovsq	%r11, %r10
	cmovsq	%r12, %rbx
	cmovsq	-128(%rsp), %rcx                # 8-byte Folded Reload
	movq	-112(%rsp), %r14                # 8-byte Reload
	subq	-88(%rsp), %r14                 # 8-byte Folded Reload
	movq	-104(%rsp), %r11                # 8-byte Reload
	sbbq	-80(%rsp), %r11                 # 8-byte Folded Reload
	movq	%rbx, 80(%rdi)
	movq	%r10, 88(%rdi)
	movq	%r9, 64(%rdi)
	movq	%rdx, 72(%rdi)
	movq	%rcx, 48(%rdi)
	movq	%rax, 56(%rdi)
	movq	-56(%rsp), %r9                  # 8-byte Reload
	sbbq	-32(%rsp), %r9                  # 8-byte Folded Reload
	movq	-48(%rsp), %r8                  # 8-byte Reload
	sbbq	-24(%rsp), %r8                  # 8-byte Folded Reload
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	sbbq	-16(%rsp), %rsi                 # 8-byte Folded Reload
	movq	-64(%rsp), %rdx                 # 8-byte Reload
	sbbq	-8(%rsp), %rdx                  # 8-byte Folded Reload
	movq	%rdx, %rax
	sarq	$63, %rax
	movq	%rax, %rcx
	shldq	$1, %rdx, %rcx
	andq	-72(%rsp), %rcx                 # 8-byte Folded Reload
	andq	%rax, %r13
	movq	-120(%rsp), %rbx                # 8-byte Reload
	andq	%rax, %rbx
	movq	-96(%rsp), %r10                 # 8-byte Reload
	andq	%rax, %r10
	andq	%rax, %rbp
	andq	(%rsp), %rax                    # 8-byte Folded Reload
	addq	%r14, %rcx
	movq	%rcx, (%rdi)
	adcq	%r11, %rax
	movq	%rax, 8(%rdi)
	adcq	%r9, %rbp
	movq	%rbp, 16(%rdi)
	movq	%r10, %rax
	adcq	%r8, %rax
	movq	%rax, 24(%rdi)
	movq	%rbx, %rax
	adcq	%rsi, %rax
	movq	%rax, 32(%rdi)
	adcq	%rdx, %r13
	movq	%r13, 40(%rdi)
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end154:
	.size	mcl_c5_fp2_mul_xi, .Lfunc_end154-mcl_c5_fp2_mul_xi
                                        # -- End function
	.globl	mcl_c5_fp2Dbl_mulPre            # -- Begin function mcl_c5_fp2Dbl_mulPre
	.p2align	4
	.type	mcl_c5_fp2Dbl_mulPre,@function
mcl_c5_fp2Dbl_mulPre:                   # @mcl_c5_fp2Dbl_mulPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$376, %rsp                      # imm = 0x178
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	88(%rsi), %rdi
	movq	80(%rsi), %rsi
	movq	72(%r15), %rdx
	movq	64(%r15), %rcx
	movq	48(%r15), %rax
	movq	56(%r15), %r8
	addq	(%r15), %rax
	adcq	8(%r15), %r8
	adcq	16(%r15), %rcx
	adcq	24(%r15), %rdx
	adcq	32(%r15), %rsi
	adcq	40(%r15), %rdi
	movq	64(%r14), %r9
	movq	48(%r14), %r10
	movq	56(%r14), %r11
	addq	(%r14), %r10
	adcq	8(%r14), %r11
	adcq	16(%r14), %r9
	movq	72(%r14), %r12
	adcq	24(%r14), %r12
	movq	80(%r14), %r13
	adcq	32(%r14), %r13
	movq	88(%r14), %rbp
	adcq	40(%r14), %rbp
	movq	%rbp, 224(%rsp)
	movq	%r13, 216(%rsp)
	movq	%r12, 208(%rsp)
	movq	%r9, 200(%rsp)
	movq	%r11, 192(%rsp)
	movq	%r10, 184(%rsp)
	movq	%rdi, 272(%rsp)
	movq	%rsi, 264(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%r8, 240(%rsp)
	movq	%rax, 232(%rsp)
	leaq	96(%rbx), %rdi
	leaq	232(%rsp), %rsi
	leaq	184(%rsp), %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	addq	$48, %r15
	addq	$48, %r14
	leaq	280(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	.Lmcl_c5_fpDbl_mulPre
	movq	32(%rbx), %r12
	movq	%r12, 144(%rsp)                 # 8-byte Spill
	movq	24(%rbx), %r13
	movq	%r13, 152(%rsp)                 # 8-byte Spill
	movq	16(%rbx), %rcx
	movq	%rcx, 160(%rsp)                 # 8-byte Spill
	movq	(%rbx), %rax
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	movq	8(%rbx), %rdi
	movq	%rdi, 168(%rsp)                 # 8-byte Spill
	movq	312(%rsp), %rdx
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	movq	304(%rsp), %rsi
	movq	%rsi, 128(%rsp)                 # 8-byte Spill
	movq	296(%rsp), %r8
	movq	%r8, 120(%rsp)                  # 8-byte Spill
	movq	280(%rsp), %r10
	movq	%r10, 104(%rsp)                 # 8-byte Spill
	movq	288(%rsp), %r9
	movq	%r9, 112(%rsp)                  # 8-byte Spill
	addq	%r10, %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	adcq	%r9, %rdi
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	adcq	%r8, %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	adcq	%rsi, %r13
	movq	%r13, (%rsp)                    # 8-byte Spill
	movq	%r12, %r13
	adcq	%rdx, %r13
	movq	40(%rbx), %rdi
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movq	320(%rsp), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	adcq	%rax, %rdi
	movq	48(%rbx), %r9
	movq	%r9, 80(%rsp)                   # 8-byte Spill
	movq	328(%rsp), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	adcq	%rax, %r9
	movq	56(%rbx), %r12
	movq	336(%rsp), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	movq	%r12, %r10
	adcq	%rax, %r10
	movq	64(%rbx), %r8
	movq	344(%rsp), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	movq	%r8, %r11
	adcq	%rax, %r11
	movq	72(%rbx), %rdx
	movq	352(%rsp), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movq	%rdx, %r14
	adcq	%rax, %r14
	movq	80(%rbx), %rsi
	movq	360(%rsp), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	%rsi, %r15
	adcq	%rax, %r15
	movq	88(%rbx), %rcx
	movq	368(%rsp), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	movq	%rcx, %rbp
	adcq	%rax, %rbp
	movq	32(%rsp), %rax                  # 8-byte Reload
	subq	%rax, 96(%rbx)
	movq	24(%rsp), %rax                  # 8-byte Reload
	sbbq	%rax, 104(%rbx)
	movq	8(%rsp), %rax                   # 8-byte Reload
	sbbq	%rax, 112(%rbx)
	movq	(%rsp), %rax                    # 8-byte Reload
	sbbq	%rax, 120(%rbx)
	sbbq	%r13, 128(%rbx)
	sbbq	%rdi, 136(%rbx)
	sbbq	%r9, 144(%rbx)
	sbbq	%r10, 152(%rbx)
	sbbq	%r11, 160(%rbx)
	sbbq	%r14, 168(%rbx)
	sbbq	%r15, 176(%rbx)
	sbbq	%rbp, 184(%rbx)
	movq	176(%rsp), %r10                 # 8-byte Reload
	subq	104(%rsp), %r10                 # 8-byte Folded Reload
	movq	168(%rsp), %r11                 # 8-byte Reload
	sbbq	112(%rsp), %r11                 # 8-byte Folded Reload
	movq	160(%rsp), %r14                 # 8-byte Reload
	sbbq	120(%rsp), %r14                 # 8-byte Folded Reload
	movq	152(%rsp), %r15                 # 8-byte Reload
	sbbq	128(%rsp), %r15                 # 8-byte Folded Reload
	movq	144(%rsp), %rax                 # 8-byte Reload
	sbbq	136(%rsp), %rax                 # 8-byte Folded Reload
	movq	96(%rsp), %r13                  # 8-byte Reload
	sbbq	88(%rsp), %r13                  # 8-byte Folded Reload
	movq	80(%rsp), %rbp                  # 8-byte Reload
	sbbq	72(%rsp), %rbp                  # 8-byte Folded Reload
	sbbq	64(%rsp), %r12                  # 8-byte Folded Reload
	sbbq	56(%rsp), %r8                   # 8-byte Folded Reload
	sbbq	48(%rsp), %rdx                  # 8-byte Folded Reload
	sbbq	40(%rsp), %rsi                  # 8-byte Folded Reload
	sbbq	16(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, %rdi
	shrq	$60, %rdi
	andl	$-8, %edi
	leaq	.Lmcl_c5_fp_sub_tbl$local(%rip), %r9
	addq	(%r9,%rdi,8), %rbp
	adcq	8(%r9,%rdi,8), %r12
	adcq	16(%r9,%rdi,8), %r8
	adcq	24(%r9,%rdi,8), %rdx
	adcq	32(%r9,%rdi,8), %rsi
	adcq	40(%r9,%rdi,8), %rcx
	movq	%rcx, 88(%rbx)
	movq	%rdx, 72(%rbx)
	movq	%r8, 64(%rbx)
	movq	%r12, 56(%rbx)
	movq	%rbp, 48(%rbx)
	movq	%rsi, 80(%rbx)
	movq	%r13, 40(%rbx)
	movq	%rax, 32(%rbx)
	movq	%r15, 24(%rbx)
	movq	%r14, 16(%rbx)
	movq	%r11, 8(%rbx)
	movq	%r10, (%rbx)
	addq	$376, %rsp                      # imm = 0x178
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end155:
	.size	mcl_c5_fp2Dbl_mulPre, .Lfunc_end155-mcl_c5_fp2Dbl_mulPre
                                        # -- End function
	.globl	mcl_c5_fp2Dbl_sqrPre            # -- Begin function mcl_c5_fp2Dbl_sqrPre
	.p2align	4
	.type	mcl_c5_fp2Dbl_sqrPre,@function
mcl_c5_fp2Dbl_sqrPre:                   # @mcl_c5_fp2Dbl_sqrPre
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$152, %rsp
	movq	%rsi, %rdx
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	movq	32(%rsi), %rdi
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	72(%rsi), %r13
	movq	16(%rsi), %rcx
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	movq	64(%rsi), %r9
	movq	56(%rsi), %rsi
	movq	(%rdx), %r10
	movq	8(%rdx), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	movq	48(%rdx), %r11
	movq	%r11, %r15
	addq	%r10, %r15
	movq	%rsi, %r14
	adcq	%r8, %r14
	movq	%r9, %rbx
	adcq	%rcx, %rbx
	movq	%r13, %r8
	adcq	%rax, %r8
	movq	80(%rdx), %rax
	movq	%rax, %rcx
	adcq	%rdi, %rcx
	movq	40(%rdx), %rdi
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movq	88(%rdx), %rbp
	movq	%rbp, %r12
	adcq	%rdi, %r12
	movq	%rax, %rdi
	shldq	$1, %r13, %rdi
	movq	%rdi, 80(%rsp)
	movq	%rbp, %rdi
	shldq	$1, %rax, %rdi
	movq	%rdi, 88(%rsp)
	movq	%r9, %rdi
	shldq	$1, %rsi, %rdi
	movq	%rdi, 64(%rsp)
	movq	%r13, %rdi
	shldq	$1, %r9, %rdi
	movq	%rdi, 72(%rsp)
	movq	%rsi, %rdi
	shldq	$1, %r11, %rdi
	subq	%r11, %r10
	movq	%r10, 96(%rsp)                  # 8-byte Spill
	leaq	(%r11,%r11), %r11
	movq	%r11, 48(%rsp)
	movq	%rdi, 56(%rsp)
	movq	%r15, 104(%rsp)
	movq	%r14, 112(%rsp)
	movq	%rbx, 120(%rsp)
	movq	%r8, 128(%rsp)
	movq	%rcx, 136(%rsp)
	movq	%r12, 144(%rsp)
	sbbq	%rsi, 8(%rsp)                   # 8-byte Folded Spill
	sbbq	%r9, 16(%rsp)                   # 8-byte Folded Spill
	sbbq	%r13, 24(%rsp)                  # 8-byte Folded Spill
	sbbq	%rax, 32(%rsp)                  # 8-byte Folded Spill
	movq	(%rsp), %rax                    # 8-byte Reload
	sbbq	%rbp, %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movq	%rax, %r12
	sarq	$63, %r12
	movq	%r12, %r13
	shldq	$1, %rax, %r13
	andq	.Lmcl_c5_fp_p$local(%rip), %r13
	movq	.Lmcl_c5_fp_p$local+40(%rip), %r14
	andq	%r12, %r14
	movq	.Lmcl_c5_fp_p$local+32(%rip), %r15
	andq	%r12, %r15
	movq	.Lmcl_c5_fp_p$local+24(%rip), %rbp
	andq	%r12, %rbp
	movq	.Lmcl_c5_fp_p$local+16(%rip), %rbx
	andq	%r12, %rbx
	andq	.Lmcl_c5_fp_p$local+8(%rip), %r12
	movq	40(%rsp), %rax                  # 8-byte Reload
	leaq	96(%rax), %rdi
	leaq	48(%rsp), %rsi
	callq	.Lmcl_c5_fpDbl_mulPre
	addq	96(%rsp), %r13                  # 8-byte Folded Reload
	adcq	8(%rsp), %r12                   # 8-byte Folded Reload
	movq	%r12, 56(%rsp)
	movq	%r13, 48(%rsp)
	adcq	16(%rsp), %rbx                  # 8-byte Folded Reload
	movq	%rbx, 64(%rsp)
	adcq	24(%rsp), %rbp                  # 8-byte Folded Reload
	movq	%rbp, 72(%rsp)
	adcq	32(%rsp), %r15                  # 8-byte Folded Reload
	movq	%r15, 80(%rsp)
	adcq	(%rsp), %r14                    # 8-byte Folded Reload
	movq	%r14, 88(%rsp)
	leaq	104(%rsp), %rdx
	movq	40(%rsp), %rdi                  # 8-byte Reload
	leaq	48(%rsp), %rsi
	callq	.Lmcl_c5_fpDbl_mulPre
	addq	$152, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end156:
	.size	mcl_c5_fp2Dbl_sqrPre, .Lfunc_end156-mcl_c5_fp2Dbl_sqrPre
                                        # -- End function
	.globl	mcl_c5_fp2Dbl_mul_xi            # -- Begin function mcl_c5_fp2Dbl_mul_xi
	.p2align	4
	.type	mcl_c5_fp2Dbl_mul_xi,@function
mcl_c5_fp2Dbl_mul_xi:                   # @mcl_c5_fp2Dbl_mul_xi
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$176, %rsp
	movq	88(%rsi), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movq	184(%rsi), %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	80(%rsi), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	176(%rsi), %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movq	72(%rsi), %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	168(%rsi), %rax
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	64(%rsi), %rax
	movq	%rax, -80(%rsp)                 # 8-byte Spill
	movq	160(%rsi), %rax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movq	56(%rsi), %rax
	movq	%rax, -104(%rsp)                # 8-byte Spill
	movq	152(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movq	48(%rsi), %rax
	movq	%rax, -112(%rsp)                # 8-byte Spill
	movq	144(%rsi), %rbp
	movq	%rbp, 160(%rsp)                 # 8-byte Spill
	movq	40(%rsi), %r13
	movq	%r13, 120(%rsp)                 # 8-byte Spill
	movq	136(%rsi), %r12
	movq	%r12, 136(%rsp)                 # 8-byte Spill
	movq	32(%rsi), %r15
	movq	%r15, 88(%rsp)                  # 8-byte Spill
	movq	128(%rsi), %r14
	movq	%r14, 104(%rsp)                 # 8-byte Spill
	movq	24(%rsi), %rbx
	movq	%rbx, 48(%rsp)                  # 8-byte Spill
	movq	120(%rsi), %r11
	movq	%r11, 80(%rsp)                  # 8-byte Spill
	movq	16(%rsi), %r10
	movq	%r10, 16(%rsp)                  # 8-byte Spill
	movq	112(%rsi), %r9
	movq	%r9, 40(%rsp)                   # 8-byte Spill
	movq	104(%rsi), %r8
	movq	%r8, 8(%rsp)                    # 8-byte Spill
	movq	(%rsi), %rax
	movq	%rax, -8(%rsp)                  # 8-byte Spill
	movq	8(%rsi), %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movq	96(%rsi), %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	addq	%rax, %rsi
	movq	%rsi, 24(%rsp)                  # 8-byte Spill
	adcq	%rcx, %r8
	movq	%r8, 32(%rsp)                   # 8-byte Spill
	adcq	%r10, %r9
	movq	%r9, 64(%rsp)                   # 8-byte Spill
	adcq	%rbx, %r11
	movq	%r11, 96(%rsp)                  # 8-byte Spill
	adcq	%r15, %r14
	movq	%r14, 128(%rsp)                 # 8-byte Spill
	adcq	%r13, %r12
	movq	%r12, 152(%rsp)                 # 8-byte Spill
	movq	%rbp, %r8
	adcq	-112(%rsp), %r8                 # 8-byte Folded Reload
	movq	-96(%rsp), %r12                 # 8-byte Reload
	adcq	-104(%rsp), %r12                # 8-byte Folded Reload
	movq	-88(%rsp), %r14                 # 8-byte Reload
	adcq	-80(%rsp), %r14                 # 8-byte Folded Reload
	movq	-72(%rsp), %rbx                 # 8-byte Reload
	adcq	-64(%rsp), %rbx                 # 8-byte Folded Reload
	movq	-56(%rsp), %r11                 # 8-byte Reload
	adcq	-48(%rsp), %r11                 # 8-byte Folded Reload
	movq	-40(%rsp), %r10                 # 8-byte Reload
	adcq	-32(%rsp), %r10                 # 8-byte Folded Reload
	setb	-128(%rsp)                      # 1-byte Folded Spill
	movq	.Lmcl_c5_fp_p$local(%rip), %rax
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	movq	%r8, %rcx
	subq	%rax, %rcx
	movq	%rcx, -120(%rsp)                # 8-byte Spill
	movq	.Lmcl_c5_fp_p$local+8(%rip), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	%r12, %rsi
	sbbq	%rax, %rsi
	movq	.Lmcl_c5_fp_p$local+16(%rip), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movq	%r14, %rcx
	sbbq	%rax, %rcx
	movq	.Lmcl_c5_fp_p$local+24(%rip), %r9
	movq	%rbx, %r15
	sbbq	%r9, %r15
	movq	.Lmcl_c5_fp_p$local+32(%rip), %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	movq	%r11, %rdx
	sbbq	%rax, %rdx
	movq	.Lmcl_c5_fp_p$local+40(%rip), %r13
	movq	%r10, %rax
	sbbq	%r13, %rax
	movzbl	-128(%rsp), %ebp                # 1-byte Folded Reload
	sbbq	$0, %rbp
	testb	$1, %bpl
	cmovneq	%r12, %rsi
	movq	%rsi, -128(%rsp)                # 8-byte Spill
	cmovneq	%r14, %rcx
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	cmovneq	%rbx, %r15
	movq	%r15, 56(%rsp)                  # 8-byte Spill
	cmovneq	%r11, %rdx
	movq	%rdx, %r15
	cmovneq	%r10, %rax
	movq	%rax, %rdx
	movq	-120(%rsp), %r10                # 8-byte Reload
	cmovneq	%r8, %r10
	movq	%r10, -120(%rsp)                # 8-byte Spill
	xorl	%eax, %eax
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	subq	(%rsp), %rcx                    # 8-byte Folded Reload
	movq	-16(%rsp), %rsi                 # 8-byte Reload
	sbbq	8(%rsp), %rsi                   # 8-byte Folded Reload
	movq	24(%rsp), %r8                   # 8-byte Reload
	movq	%r8, 96(%rdi)
	movq	%rcx, (%rdi)
	movq	32(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 104(%rdi)
	movq	16(%rsp), %rcx                  # 8-byte Reload
	sbbq	40(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rsi, 8(%rdi)
	movq	64(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 112(%rdi)
	movq	48(%rsp), %r10                  # 8-byte Reload
	sbbq	80(%rsp), %r10                  # 8-byte Folded Reload
	movq	%rcx, 16(%rdi)
	movq	96(%rsp), %rcx                  # 8-byte Reload
	movq	%rcx, 120(%rdi)
	movq	88(%rsp), %r11                  # 8-byte Reload
	sbbq	104(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r10, 24(%rdi)
	movq	128(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 128(%rdi)
	movq	120(%rsp), %r10                 # 8-byte Reload
	sbbq	136(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r11, 32(%rdi)
	movq	152(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 136(%rdi)
	movq	-112(%rsp), %rbp                # 8-byte Reload
	sbbq	160(%rsp), %rbp                 # 8-byte Folded Reload
	movq	%r10, 40(%rdi)
	movq	-104(%rsp), %r12                # 8-byte Reload
	sbbq	-96(%rsp), %r12                 # 8-byte Folded Reload
	movq	-80(%rsp), %r14                 # 8-byte Reload
	sbbq	-88(%rsp), %r14                 # 8-byte Folded Reload
	movq	-64(%rsp), %rbx                 # 8-byte Reload
	sbbq	-72(%rsp), %rbx                 # 8-byte Folded Reload
	movq	-48(%rsp), %r11                 # 8-byte Reload
	sbbq	-56(%rsp), %r11                 # 8-byte Folded Reload
	movq	-32(%rsp), %r10                 # 8-byte Reload
	sbbq	-40(%rsp), %r10                 # 8-byte Folded Reload
	sbbq	%rax, %rax
	andq	%rax, %r13
	movq	-24(%rsp), %rcx                 # 8-byte Reload
	andq	%rax, %rcx
	andq	%rax, %r9
	movq	72(%rsp), %r8                   # 8-byte Reload
	andq	%rax, %r8
	movq	144(%rsp), %rsi                 # 8-byte Reload
	andq	%rax, %rsi
	andq	168(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rbp, %rax
	adcq	%r12, %rsi
	movq	%rax, 48(%rdi)
	adcq	%r14, %r8
	movq	%rsi, 56(%rdi)
	adcq	%rbx, %r9
	movq	%r8, 64(%rdi)
	movq	%r9, 72(%rdi)
	movq	%rdx, 184(%rdi)
	movq	%r15, 176(%rdi)
	movq	56(%rsp), %rax                  # 8-byte Reload
	movq	%rax, 168(%rdi)
	movq	112(%rsp), %rax                 # 8-byte Reload
	movq	%rax, 160(%rdi)
	movq	-128(%rsp), %rax                # 8-byte Reload
	movq	%rax, 152(%rdi)
	movq	-120(%rsp), %rax                # 8-byte Reload
	movq	%rax, 144(%rdi)
	adcq	%r11, %rcx
	movq	%rcx, 80(%rdi)
	adcq	%r10, %r13
	movq	%r13, 88(%rdi)
	addq	$176, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end157:
	.size	mcl_c5_fp2Dbl_mul_xi, .Lfunc_end157-mcl_c5_fp2Dbl_mul_xi
                                        # -- End function
	.globl	mcl_c5_fr_add                   # -- Begin function mcl_c5_fr_add
	.p2align	4
	.type	mcl_c5_fr_add,@function
mcl_c5_fr_add:                          # @mcl_c5_fr_add
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	addq	(%rdx), %r8
	adcq	8(%rdx), %rsi
	adcq	16(%rdx), %rcx
	adcq	24(%rdx), %rax
	movq	%r8, %rdx
	subq	.Lmcl_c5_fr_p$local(%rip), %rdx
	movq	%rsi, %r9
	sbbq	.Lmcl_c5_fr_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c5_fr_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c5_fr_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%r8, %rdx
	movq	%rdx, (%rdi)
	cmovsq	%rsi, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end158:
	.size	mcl_c5_fr_add, .Lfunc_end158-mcl_c5_fr_add
                                        # -- End function
	.globl	mcl_c5_fr_sub                   # -- Begin function mcl_c5_fr_sub
	.p2align	4
	.type	mcl_c5_fr_sub,@function
mcl_c5_fr_sub:                          # @mcl_c5_fr_sub
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	subq	(%rdx), %r8
	sbbq	8(%rdx), %rsi
	sbbq	16(%rdx), %rcx
	sbbq	24(%rdx), %rax
	movq	%rax, %rdx
	sarq	$63, %rdx
	movq	.Lmcl_c5_fr_p$local+24(%rip), %r9
	andq	%rdx, %r9
	movq	.Lmcl_c5_fr_p$local+16(%rip), %r10
	andq	%rdx, %r10
	movq	.Lmcl_c5_fr_p$local+8(%rip), %r11
	andq	%rdx, %r11
	andq	.Lmcl_c5_fr_p$local(%rip), %rdx
	addq	%r8, %rdx
	movq	%rdx, (%rdi)
	adcq	%rsi, %r11
	movq	%r11, 8(%rdi)
	adcq	%rcx, %r10
	movq	%r10, 16(%rdi)
	adcq	%rax, %r9
	movq	%r9, 24(%rdi)
	retq
.Lfunc_end159:
	.size	mcl_c5_fr_sub, .Lfunc_end159-mcl_c5_fr_sub
                                        # -- End function
	.globl	mcl_c5_fr_neg                   # -- Begin function mcl_c5_fr_neg
	.p2align	4
	.type	mcl_c5_fr_neg,@function
mcl_c5_fr_neg:                          # @mcl_c5_fr_neg
# %bb.0:                                # %L78
	movq	24(%rsi), %rcx
	movq	16(%rsi), %rdx
	movq	(%rsi), %r8
	movq	8(%rsi), %rsi
	movq	.Lmcl_c5_fr_p$local+24(%rip), %rax
	movq	.Lmcl_c5_fr_p$local+16(%rip), %r9
	movq	.Lmcl_c5_fr_p$local+8(%rip), %r10
	movq	.Lmcl_c5_fr_p$local(%rip), %r11
	subq	%r8, %r11
	sbbq	%rsi, %r10
	sbbq	%rdx, %r9
	sbbq	%rcx, %rax
	orq	%rcx, %rsi
	orq	%rdx, %r8
	xorl	%ecx, %ecx
	orq	%rsi, %r8
	cmoveq	%rcx, %r11
	movq	%r11, (%rdi)
	cmoveq	%rcx, %r10
	movq	%r10, 8(%rdi)
	cmoveq	%rcx, %r9
	movq	%r9, 16(%rdi)
	cmoveq	%rcx, %rax
	movq	%rax, 24(%rdi)
	retq
.Lfunc_end160:
	.size	mcl_c5_fr_neg, .Lfunc_end160-mcl_c5_fr_neg
                                        # -- End function
	.globl	mcl_c5_fr_mul2                  # -- Begin function mcl_c5_fr_mul2
	.p2align	4
	.type	mcl_c5_fr_mul2,@function
mcl_c5_fr_mul2:                         # @mcl_c5_fr_mul2
# %bb.0:
	movq	24(%rsi), %rax
	movq	16(%rsi), %rcx
	movq	(%rsi), %rdx
	movq	8(%rsi), %r8
	addq	(%rsi), %rdx
	adcq	8(%rsi), %r8
	adcq	16(%rsi), %rcx
	adcq	24(%rsi), %rax
	movq	%rdx, %rsi
	subq	.Lmcl_c5_fr_p$local(%rip), %rsi
	movq	%r8, %r9
	sbbq	.Lmcl_c5_fr_p$local+8(%rip), %r9
	movq	%rcx, %r10
	sbbq	.Lmcl_c5_fr_p$local+16(%rip), %r10
	movq	%rax, %r11
	sbbq	.Lmcl_c5_fr_p$local+24(%rip), %r11
	cmovsq	%rcx, %r10
	movq	%r10, 16(%rdi)
	cmovsq	%rax, %r11
	movq	%r11, 24(%rdi)
	cmovsq	%rdx, %rsi
	movq	%rsi, (%rdi)
	cmovsq	%r8, %r9
	movq	%r9, 8(%rdi)
	retq
.Lfunc_end161:
	.size	mcl_c5_fr_mul2, .Lfunc_end161-mcl_c5_fr_mul2
                                        # -- End function
	.globl	mcl_c5_fr_mul                   # -- Begin function mcl_c5_fr_mul
	.p2align	4
	.type	mcl_c5_fr_mul,@function
mcl_c5_fr_mul:                          # @mcl_c5_fr_mul
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rax
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	movq	8(%rsi), %r11
	movq	(%rax), %rax
	mulxq	%rax, %r10, %rdi
	movq	.Lmcl_c5_fr_rp$local(%rip), %r9
	movq	%r9, -88(%rsp)                  # 8-byte Spill
	imulq	%r10, %r9
	movq	.Lmcl_c5_fr_p$local(%rip), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r8, %rcx
	addq	%rdi, %rcx
	movq	.Lmcl_c5_fr_p$local+8(%rip), %rdi
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	movq	%r11, %rdx
	movq	%r11, -40(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rdx, %r14
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movq	%rdi, %rdx
	mulxq	%r9, %r13, %rdi
	adcq	%r14, %rdi
	movq	16(%rsi), %rdx
	movq	%rdx, %r14
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rbx, %r15
	movq	.Lmcl_c5_fr_p$local+16(%rip), %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	mulxq	%r9, %rbp, %r12
	adcq	%r15, %r12
	movq	24(%rsi), %r15
	movq	.Lmcl_c5_fr_p$local+24(%rip), %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	mulxq	%r9, %r9, %rsi
	movq	%r15, %rdx
	movq	%r15, -56(%rsp)                 # 8-byte Spill
	mulxq	%rax, %rax, %rdx
	adcq	%rsi, %rdx
	addq	%r10, %r8
	adcq	-32(%rsp), %r13                 # 8-byte Folded Reload
	adcq	%rbx, %rbp
	adcq	%r9, %rax
	setb	%sil
	addq	%rcx, %r13
	adcq	%rdi, %rbp
	adcq	%r12, %rax
	movzbl	%sil, %r9d
	adcq	%rdx, %r9
	movq	-80(%rsp), %rcx                 # 8-byte Reload
	movq	8(%rcx), %rdx
	mulxq	%r11, %rdi, %rsi
	mulxq	-96(%rsp), %r10, %rcx           # 8-byte Folded Reload
	addq	%rdi, %rcx
	mulxq	%r14, %rdi, %rbx
	adcq	%rsi, %rdi
	mulxq	%r15, %r8, %rsi
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%r13, %r10
	adcq	%rbp, %rcx
	adcq	%rax, %rdi
	adcq	%r9, %r8
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	-16(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r9, %rax
	addq	%r10, %r9
	movq	-24(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r9, %r10
	adcq	%rcx, %r9
	movq	-64(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %rcx, %rbx
	adcq	%rdi, %rcx
	movq	-72(%rsp), %r15                 # 8-byte Reload
	mulxq	%r15, %rbp, %rdx
	adcq	%r8, %rbp
	adcq	$0, %rsi
	addq	%rax, %r9
	adcq	%r10, %rcx
	adcq	%rbx, %rbp
	adcq	%rdx, %rsi
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	16(%rax), %rdx
	mulxq	-40(%rsp), %r8, %rax            # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%r8, %rdi
	mulxq	-48(%rsp), %r8, %rbx            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rax, %r13           # 8-byte Folded Reload
	adcq	%rbx, %rax
	adcq	$0, %r13
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%rsi, %rax
	adcq	$0, %r13
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	mulxq	%r12, %rcx, %rsi
	addq	%r10, %rcx
	mulxq	%r11, %r9, %r10
	adcq	%rdi, %r9
	mulxq	%r14, %rcx, %rdi
	adcq	%r8, %rcx
	mulxq	%r15, %rbp, %rdx
	adcq	%rax, %rbp
	adcq	$0, %r13
	addq	%rsi, %r9
	adcq	%r10, %rcx
	adcq	%rdi, %rbp
	adcq	%rdx, %r13
	movq	-80(%rsp), %rax                 # 8-byte Reload
	movq	24(%rax), %rdx
	mulxq	-40(%rsp), %rsi, %rax           # 8-byte Folded Reload
	mulxq	-96(%rsp), %r10, %rdi           # 8-byte Folded Reload
	addq	%rsi, %rdi
	mulxq	-48(%rsp), %r8, %r14            # 8-byte Folded Reload
	adcq	%rax, %r8
	mulxq	-56(%rsp), %rbx, %rsi           # 8-byte Folded Reload
	adcq	%r14, %rbx
	adcq	$0, %rsi
	addq	%r9, %r10
	adcq	%rcx, %rdi
	adcq	%rbp, %r8
	adcq	%r13, %rbx
	adcq	$0, %rsi
	movq	-88(%rsp), %rdx                 # 8-byte Reload
	imulq	%r10, %rdx
	movq	%r12, %r14
	mulxq	%r12, %rax, %rcx
	addq	%r10, %rax
	movq	%r11, %r15
	mulxq	%r11, %rax, %r9
	adcq	%rdi, %rax
	movq	-64(%rsp), %r12                 # 8-byte Reload
	mulxq	%r12, %r10, %rdi
	adcq	%r8, %r10
	movq	-72(%rsp), %r11                 # 8-byte Reload
	mulxq	%r11, %r8, %rdx
	adcq	%rbx, %r8
	adcq	$0, %rsi
	addq	%rcx, %rax
	adcq	%r9, %r10
	adcq	%rdi, %r8
	adcq	%rdx, %rsi
	movq	%rax, %rcx
	subq	%r14, %rcx
	movq	%r10, %rdx
	sbbq	%r15, %rdx
	movq	%r8, %rdi
	sbbq	%r12, %rdi
	movq	%rsi, %r9
	sbbq	%r11, %r9
	cmovsq	%r10, %rdx
	movq	-8(%rsp), %r10                  # 8-byte Reload
	movq	%rdx, 8(%r10)
	cmovsq	%r8, %rdi
	movq	%rdi, 16(%r10)
	cmovsq	%rsi, %r9
	movq	%r9, 24(%r10)
	cmovsq	%rax, %rcx
	movq	%rcx, (%r10)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end162:
	.size	mcl_c5_fr_mul, .Lfunc_end162-mcl_c5_fr_mul
                                        # -- End function
	.globl	mcl_c5_fr_sqr                   # -- Begin function mcl_c5_fr_sqr
	.p2align	4
	.type	mcl_c5_fr_sqr,@function
mcl_c5_fr_sqr:                          # @mcl_c5_fr_sqr
# %bb.0:
	movq	%rsi, %rdx
	jmp	mcl_c5_fr_mul@PLT               # TAILCALL
.Lfunc_end163:
	.size	mcl_c5_fr_sqr, .Lfunc_end163-mcl_c5_fr_sqr
                                        # -- End function
	.globl	mcl_c5_frDbl_mod                # -- Begin function mcl_c5_frDbl_mod
	.p2align	4
	.type	mcl_c5_frDbl_mod,@function
mcl_c5_frDbl_mod:                       # @mcl_c5_frDbl_mod
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r9
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movq	(%rsi), %rax
	movq	.Lmcl_c5_fr_rp$local(%rip), %r10
	movq	%r10, %rdi
	imulq	%rax, %rdi
	movq	.Lmcl_c5_fr_p$local+8(%rip), %rbp
	movq	%rbp, %rdx
	movq	%rbp, -16(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r11, %rsi
	movq	.Lmcl_c5_fr_p$local(%rip), %rcx
	movq	%rcx, %rdx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %r14, %rbx
	movq	.Lmcl_c5_fr_p$local+16(%rip), %r8
	addq	%r11, %rbx
	movq	%r8, %rdx
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	mulxq	%rdi, %r12, %r11
	adcq	%rsi, %r12
	movq	.Lmcl_c5_fr_p$local+24(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	mulxq	%rdi, %rdi, %r13
	adcq	%r11, %rdi
	adcq	$0, %r13
	addq	%rax, %r14
	adcq	8(%r9), %rbx
	adcq	16(%r9), %r12
	adcq	24(%r9), %rdi
	adcq	32(%r9), %r13
	setb	%al
	movq	%r10, %r11
	imulq	%rbx, %r11
	movq	%rcx, %rdx
	mulxq	%r11, %rcx, %r15
	movq	%rbp, %rdx
	mulxq	%r11, %r14, %rbp
	addq	%r15, %r14
	movq	%r8, %rdx
	mulxq	%r11, %r15, %r8
	adcq	%rbp, %r15
	movq	%r11, %rdx
	mulxq	%rsi, %rbp, %rdx
	adcq	%r8, %rbp
	movzbl	%al, %eax
	adcq	%rdx, %rax
	addq	%rbx, %rcx
	adcq	%r12, %r14
	adcq	%rdi, %r15
	adcq	%r13, %rbp
	adcq	40(%r9), %rax
	setb	-41(%rsp)                       # 1-byte Folded Spill
	movq	%r10, %r11
	imulq	%r14, %r11
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rdx
	mulxq	%r11, %r8, %rdi
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	mulxq	%r11, %rbx, %r13
	addq	%rdi, %rbx
	movq	-40(%rsp), %rsi                 # 8-byte Reload
	movq	%rsi, %rdx
	mulxq	%r11, %r12, %rdi
	adcq	%r13, %r12
	movq	%r11, %rdx
	mulxq	-24(%rsp), %r11, %rdx           # 8-byte Folded Reload
	adcq	%rdi, %r11
	movzbl	-41(%rsp), %r13d                # 1-byte Folded Reload
	adcq	%rdx, %r13
	addq	%r14, %r8
	adcq	%r15, %rbx
	adcq	%rbp, %r12
	adcq	%rax, %r11
	adcq	48(%r9), %r13
	setb	-41(%rsp)                       # 1-byte Folded Spill
	imulq	%rbx, %r10
	movq	%rcx, %rdx
	mulxq	%r10, %r8, %rdi
	movq	-16(%rsp), %rbp                 # 8-byte Reload
	movq	%rbp, %rdx
	mulxq	%r10, %rax, %r14
	addq	%rdi, %rax
	movq	%rsi, %rdx
	mulxq	%r10, %rdi, %r15
	adcq	%r14, %rdi
	movq	%r10, %rdx
	movq	-24(%rsp), %r14                 # 8-byte Reload
	mulxq	%r14, %r10, %rdx
	adcq	%r15, %r10
	movzbl	-41(%rsp), %ecx                 # 1-byte Folded Reload
	adcq	%rdx, %rcx
	addq	%rbx, %r8
	adcq	%r12, %rax
	adcq	%r11, %rdi
	adcq	%r13, %r10
	adcq	56(%r9), %rcx
	movq	%rax, %rdx
	subq	-32(%rsp), %rdx                 # 8-byte Folded Reload
	movq	%rdi, %rsi
	sbbq	%rbp, %rsi
	movq	%r10, %r8
	sbbq	-40(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rcx, %r11
	sbbq	%r14, %r11
	cmovsq	%r10, %r8
	movq	-8(%rsp), %r9                   # 8-byte Reload
	movq	%r8, 16(%r9)
	cmovsq	%rcx, %r11
	movq	%r11, 24(%r9)
	cmovsq	%rax, %rdx
	movq	%rdx, (%r9)
	cmovsq	%rdi, %rsi
	movq	%rsi, 8(%r9)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end164:
	.size	mcl_c5_frDbl_mod, .Lfunc_end164-mcl_c5_frDbl_mod
                                        # -- End function
	.type	mcl_c0_fp_p,@object             # @mcl_c0_fp_p
	.data
	.globl	mcl_c0_fp_p
	.p2align	4, 0x0
mcl_c0_fp_p:
.Lmcl_c0_fp_p$local:
	.quad	-6413125869375586285
	.quad	6998875295910461459
	.quad	-5029309671714848760
	.quad	2676093114170474497
	.size	mcl_c0_fp_p, 32

	.type	mcl_c0_fp_rp,@object            # @mcl_c0_fp_rp
	.globl	mcl_c0_fp_rp
	.p2align	3, 0x0
mcl_c0_fp_rp:
.Lmcl_c0_fp_rp$local:
	.quad	595423277050246629              # 0x8435e50d79435e5
	.size	mcl_c0_fp_rp, 8

	.type	mcl_c0_fp_sub_tbl,@object       # @mcl_c0_fp_sub_tbl
	.globl	mcl_c0_fp_sub_tbl
	.p2align	6, 0x0
mcl_c0_fp_sub_tbl:
.Lmcl_c0_fp_sub_tbl$local:
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	-6413125869375586285            # 0xa700000000000013
	.quad	6998875295910461459             # 0x6121000000000013
	.quad	-5029309671714848760            # 0xba344d8000000008
	.quad	2676093114170474497             # 0x2523648240000001
	.size	mcl_c0_fp_sub_tbl, 64

	.type	mcl_c0_fr_p,@object             # @mcl_c0_fr_p
	.globl	mcl_c0_fr_p
	.p2align	4, 0x0
mcl_c0_fr_p:
.Lmcl_c0_fr_p$local:
	.quad	-6845471433603153907
	.quad	-27162335252578288
	.quad	-5029309671714848761
	.quad	2676093114170474497
	.size	mcl_c0_fr_p, 32

	.type	mcl_c0_fr_rp,@object            # @mcl_c0_fr_rp
	.globl	mcl_c0_fr_rp
	.p2align	3, 0x0
mcl_c0_fr_rp:
.Lmcl_c0_fr_rp$local:
	.quad	-1568638393287200453            # 0xea3b13b13b13b13b
	.size	mcl_c0_fr_rp, 8

	.type	mcl_c5_fp_p,@object             # @mcl_c5_fp_p
	.globl	mcl_c5_fp_p
	.p2align	4, 0x0
mcl_c5_fp_p:
.Lmcl_c5_fp_p$local:
	.quad	-5044313057631688021
	.quad	2210141511517208575
	.quad	7435674573564081700
	.quad	7239337960414712511
	.quad	5412103778470702295
	.quad	1873798617647539866
	.size	mcl_c5_fp_p, 48

	.type	mcl_c5_fp_rp,@object            # @mcl_c5_fp_rp
	.globl	mcl_c5_fp_rp
	.p2align	3, 0x0
mcl_c5_fp_rp:
.Lmcl_c5_fp_rp$local:
	.quad	-8506173809081122819            # 0x89f3fffcfffcfffd
	.size	mcl_c5_fp_rp, 8

	.type	mcl_c5_fp_sub_tbl,@object       # @mcl_c5_fp_sub_tbl
	.globl	mcl_c5_fp_sub_tbl
	.p2align	6, 0x0
mcl_c5_fp_sub_tbl:
.Lmcl_c5_fp_sub_tbl$local:
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	-5044313057631688021            # 0xb9feffffffffaaab
	.quad	2210141511517208575             # 0x1eabfffeb153ffff
	.quad	7435674573564081700             # 0x6730d2a0f6b0f624
	.quad	7239337960414712511             # 0x64774b84f38512bf
	.quad	5412103778470702295             # 0x4b1ba7b6434bacd7
	.quad	1873798617647539866             # 0x1a0111ea397fe69a
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.size	mcl_c5_fp_sub_tbl, 128

	.type	mcl_c5_fr_p,@object             # @mcl_c5_fr_p
	.globl	mcl_c5_fr_p
	.p2align	4, 0x0
mcl_c5_fr_p:
.Lmcl_c5_fr_p$local:
	.quad	-4294967295
	.quad	6034159408538082302
	.quad	3691218898639771653
	.quad	8353516859464449352
	.size	mcl_c5_fr_p, 32

	.type	mcl_c5_fr_rp,@object            # @mcl_c5_fr_rp
	.globl	mcl_c5_fr_rp
	.p2align	3, 0x0
mcl_c5_fr_rp:
.Lmcl_c5_fr_rp$local:
	.quad	-4294967297                     # 0xfffffffeffffffff
	.size	mcl_c5_fr_rp, 8

	.section	".note.GNU-stack","",@progbits
