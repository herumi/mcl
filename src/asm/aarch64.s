	.text
	.file	"<stdin>"
	.globl	makeNIST_P192L
	.align	2
	.type	makeNIST_P192L,@function
makeNIST_P192L:                         // @makeNIST_P192L
// BB#0:
	movn	x0, #0
	orr	x1, xzr, #0xfffffffffffffffe
	movn	x2, #0
	ret
.Lfunc_end0:
	.size	makeNIST_P192L, .Lfunc_end0-makeNIST_P192L

	.globl	mcl_fpDbl_mod_NIST_P192L
	.align	2
	.type	mcl_fpDbl_mod_NIST_P192L,@function
mcl_fpDbl_mod_NIST_P192L:               // @mcl_fpDbl_mod_NIST_P192L
// BB#0:
	ldp	x8, x9, [x1, #16]
	ldp	x10, x11, [x1, #32]
	ldp	 x12, x13, [x1]
	orr	w14, wzr, #0x1
	adds	 x13, x11, x13
	adcs	x8, x8, xzr
	adcs	x15, xzr, xzr
	adds	 x12, x12, x9
	adcs	x13, x13, x10
	adcs	x8, x8, x11
	adcs	x15, x15, xzr
	adds	 x11, x12, x11
	movn	x12, #0
	adcs	x9, x13, x9
	adcs	x8, x8, x10
	adcs	x10, x15, xzr
	adds	 x11, x10, x11
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	adcs	x10, xzr, xzr
	adds	x13, x11, #1            // =1
	adcs	x14, x9, x14
	adcs	x15, x8, xzr
	adcs	x10, x10, x12
	tst	 x10, #0x1
	csel	x10, x11, x13, ne
	csel	x9, x9, x14, ne
	csel	x8, x8, x15, ne
	stp	 x10, x9, [x0]
	str	x8, [x0, #16]
	ret
.Lfunc_end1:
	.size	mcl_fpDbl_mod_NIST_P192L, .Lfunc_end1-mcl_fpDbl_mod_NIST_P192L

	.globl	mcl_fp_sqr_NIST_P192L
	.align	2
	.type	mcl_fp_sqr_NIST_P192L,@function
mcl_fp_sqr_NIST_P192L:                  // @mcl_fp_sqr_NIST_P192L
// BB#0:
	ldp	 x8, x9, [x1]
	ldr	x10, [x1, #16]
	orr	w11, wzr, #0x1
	umulh	x12, x8, x8
	mul	 x13, x9, x8
	mul	 x14, x10, x8
	umulh	x15, x9, x8
	adds	 x12, x12, x13
	umulh	x16, x10, x8
	adcs	x17, x15, x14
	adcs	x18, x16, xzr
	mul	 x1, x9, x9
	mul	 x2, x10, x9
	adds	 x15, x15, x1
	umulh	x1, x9, x9
	umulh	x9, x10, x9
	adcs	x1, x1, x2
	adcs	x3, x9, xzr
	adds	 x12, x13, x12
	adcs	x13, x15, x17
	adcs	x15, x1, x18
	movn	x17, #0
	umulh	x18, x10, x10
	mul	 x10, x10, x10
	mul	 x8, x8, x8
	adcs	x1, x3, xzr
	adds	 x16, x16, x2
	adcs	x9, x9, x10
	adcs	x10, x18, xzr
	adds	 x13, x14, x13
	adcs	x14, x16, x15
	adcs	x9, x9, x1
	adcs	x10, x10, xzr
	adds	 x12, x12, x10
	adcs	x13, x13, xzr
	adcs	x15, xzr, xzr
	adds	 x8, x8, x14
	adcs	x12, x12, x9
	adcs	x13, x13, x10
	adcs	x15, x15, xzr
	adds	 x8, x8, x10
	adcs	x10, x12, x14
	adcs	x9, x13, x9
	adcs	x12, x15, xzr
	adds	 x8, x12, x8
	adcs	x10, x12, x10
	adcs	x9, x9, xzr
	adcs	x12, xzr, xzr
	adds	x13, x8, #1             // =1
	adcs	x11, x10, x11
	adcs	x14, x9, xzr
	adcs	x12, x12, x17
	tst	 x12, #0x1
	csel	x8, x8, x13, ne
	csel	x10, x10, x11, ne
	csel	x9, x9, x14, ne
	stp	 x8, x10, [x0]
	str	x9, [x0, #16]
	ret
.Lfunc_end2:
	.size	mcl_fp_sqr_NIST_P192L, .Lfunc_end2-mcl_fp_sqr_NIST_P192L

	.globl	mcl_fp_mulNIST_P192L
	.align	2
	.type	mcl_fp_mulNIST_P192L,@function
mcl_fp_mulNIST_P192L:                   // @mcl_fp_mulNIST_P192L
// BB#0:
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16            // =16
	sub	sp, sp, #48             // =48
	mov	 x19, x0
	mov	 x0, sp
	bl	mcl_fpDbl_mulPre3L
	ldp	x9, x8, [sp, #8]
	ldp	x11, x10, [sp, #32]
	ldr	x12, [sp, #24]
	ldr	 x13, [sp]
	orr	w14, wzr, #0x1
	adds	 x9, x10, x9
	adcs	x8, x8, xzr
	adcs	x15, xzr, xzr
	adds	 x13, x13, x12
	adcs	x9, x9, x11
	adcs	x8, x8, x10
	adcs	x15, x15, xzr
	adds	 x10, x13, x10
	movn	x13, #0
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	adcs	x11, x15, xzr
	adds	 x10, x11, x10
	adcs	x9, x11, x9
	adcs	x8, x8, xzr
	adcs	x11, xzr, xzr
	adds	x12, x10, #1            // =1
	adcs	x14, x9, x14
	adcs	x15, x8, xzr
	adcs	x11, x11, x13
	tst	 x11, #0x1
	csel	x10, x10, x12, ne
	csel	x9, x9, x14, ne
	csel	x8, x8, x15, ne
	stp	 x10, x9, [x19]
	str	x8, [x19, #16]
	sub	sp, x29, #16            // =16
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
.Lfunc_end3:
	.size	mcl_fp_mulNIST_P192L, .Lfunc_end3-mcl_fp_mulNIST_P192L

	.globl	mcl_fpDbl_mod_NIST_P521L
	.align	2
	.type	mcl_fpDbl_mod_NIST_P521L,@function
mcl_fpDbl_mod_NIST_P521L:               // @mcl_fpDbl_mod_NIST_P521L
// BB#0:
	stp	x29, x30, [sp, #-16]!
	mov	 x29, sp
	ldp	x8, x9, [x1, #112]
	ldr	x10, [x1, #128]
	ldp	x11, x12, [x1, #96]
	ldp	x13, x14, [x1, #80]
	ldp	x15, x16, [x1, #64]
	ldp	x17, x18, [x1, #48]
	ldp	x2, x3, [x1, #32]
	ldp	x4, x5, [x1, #16]
	ldp	 x6, x1, [x1]
	extr	x7, x10, x9, #9
	extr	x9, x9, x8, #9
	extr	x8, x8, x12, #9
	extr	x12, x12, x11, #9
	extr	x11, x11, x14, #9
	extr	x14, x14, x13, #9
	extr	x13, x13, x16, #9
	extr	x16, x16, x15, #9
	and	x15, x15, #0x1ff
	lsr	x10, x10, #9
	adds	 x16, x16, x6
	adcs	x13, x13, x1
	adcs	x14, x14, x4
	adcs	x11, x11, x5
	adcs	x12, x12, x2
	adcs	x1, x8, x3
	adcs	x17, x9, x17
	adcs	x18, x7, x18
	adcs	x2, x10, x15
	ubfx	x8, x2, #9, #1
	adds	 x8, x8, x16
	adcs	x9, x13, xzr
	and	 x13, x9, x8
	adcs	x10, x14, xzr
	and	 x13, x13, x10
	adcs	x11, x11, xzr
	and	 x13, x13, x11
	adcs	x12, x12, xzr
	and	 x14, x13, x12
	adcs	x13, x1, xzr
	and	 x15, x14, x13
	adcs	x14, x17, xzr
	and	 x16, x15, x14
	adcs	x15, x18, xzr
	and	 x17, x16, x15
	adcs	x16, x2, xzr
	orr	x18, x16, #0xfffffffffffffe00
	and	 x17, x17, x18
	cmn	 x17, #1                // =1
	b.eq	.LBB4_2
// BB#1:                                // %nonzero
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	stp	x14, x15, [x0, #48]
	and	x8, x16, #0x1ff
	str	x8, [x0, #64]
	ldp	x29, x30, [sp], #16
	ret
.LBB4_2:                                // %zero
	mov	 w1, wzr
	movz	w2, #0x48
	bl	memset
	ldp	x29, x30, [sp], #16
	ret
.Lfunc_end4:
	.size	mcl_fpDbl_mod_NIST_P521L, .Lfunc_end4-mcl_fpDbl_mod_NIST_P521L

	.globl	mcl_fp_mulUnitPre1L
	.align	2
	.type	mcl_fp_mulUnitPre1L,@function
mcl_fp_mulUnitPre1L:                    // @mcl_fp_mulUnitPre1L
// BB#0:
	ldr	 x8, [x1]
	mul	 x9, x8, x2
	umulh	x8, x8, x2
	stp	 x9, x8, [x0]
	ret
.Lfunc_end5:
	.size	mcl_fp_mulUnitPre1L, .Lfunc_end5-mcl_fp_mulUnitPre1L

	.globl	mcl_fpDbl_mulPre1L
	.align	2
	.type	mcl_fpDbl_mulPre1L,@function
mcl_fpDbl_mulPre1L:                     // @mcl_fpDbl_mulPre1L
// BB#0:
	ldr	 x8, [x1]
	ldr	 x9, [x2]
	mul	 x10, x9, x8
	umulh	x8, x9, x8
	stp	 x10, x8, [x0]
	ret
.Lfunc_end6:
	.size	mcl_fpDbl_mulPre1L, .Lfunc_end6-mcl_fpDbl_mulPre1L

	.globl	mcl_fpDbl_sqrPre1L
	.align	2
	.type	mcl_fpDbl_sqrPre1L,@function
mcl_fpDbl_sqrPre1L:                     // @mcl_fpDbl_sqrPre1L
// BB#0:
	ldr	 x8, [x1]
	mul	 x9, x8, x8
	umulh	x8, x8, x8
	stp	 x9, x8, [x0]
	ret
.Lfunc_end7:
	.size	mcl_fpDbl_sqrPre1L, .Lfunc_end7-mcl_fpDbl_sqrPre1L

	.globl	mcl_fp_mont1L
	.align	2
	.type	mcl_fp_mont1L,@function
mcl_fp_mont1L:                          // @mcl_fp_mont1L
// BB#0:
	ldr	 x8, [x2]
	ldr	 x9, [x1]
	ldur	x10, [x3, #-8]
	ldr	 x11, [x3]
	umulh	x12, x9, x8
	mul	 x8, x9, x8
	mul	 x9, x8, x10
	umulh	x10, x9, x11
	mul	 x9, x9, x11
	cmn	 x9, x8
	adcs	x8, x10, x12
	adcs	x9, xzr, xzr
	subs	 x10, x8, x11
	sbcs	x9, x9, xzr
	tst	 x9, #0x1
	csel	x8, x8, x10, ne
	str	 x8, [x0]
	ret
.Lfunc_end8:
	.size	mcl_fp_mont1L, .Lfunc_end8-mcl_fp_mont1L

	.globl	mcl_fp_montNF1L
	.align	2
	.type	mcl_fp_montNF1L,@function
mcl_fp_montNF1L:                        // @mcl_fp_montNF1L
// BB#0:
	ldr	 x8, [x2]
	ldr	 x9, [x1]
	ldur	x10, [x3, #-8]
	ldr	 x11, [x3]
	umulh	x12, x9, x8
	mul	 x8, x9, x8
	mul	 x9, x8, x10
	umulh	x10, x9, x11
	mul	 x9, x9, x11
	cmn	 x9, x8
	adcs	x8, x10, x12
	sub	 x9, x8, x11
	cmp	 x9, #0                 // =0
	csel	x8, x8, x9, lt
	str	 x8, [x0]
	ret
.Lfunc_end9:
	.size	mcl_fp_montNF1L, .Lfunc_end9-mcl_fp_montNF1L

	.globl	mcl_fp_montRed1L
	.align	2
	.type	mcl_fp_montRed1L,@function
mcl_fp_montRed1L:                       // @mcl_fp_montRed1L
// BB#0:
	ldur	x8, [x2, #-8]
	ldp	 x9, x11, [x1]
	ldr	 x10, [x2]
	mul	 x8, x9, x8
	umulh	x12, x8, x10
	mul	 x8, x8, x10
	cmn	 x9, x8
	adcs	x8, x11, x12
	adcs	x9, xzr, xzr
	subs	 x10, x8, x10
	sbcs	x9, x9, xzr
	tst	 x9, #0x1
	csel	x8, x8, x10, ne
	str	 x8, [x0]
	ret
.Lfunc_end10:
	.size	mcl_fp_montRed1L, .Lfunc_end10-mcl_fp_montRed1L

	.globl	mcl_fp_addPre1L
	.align	2
	.type	mcl_fp_addPre1L,@function
mcl_fp_addPre1L:                        // @mcl_fp_addPre1L
// BB#0:
	ldr	 x8, [x1]
	ldr	 x9, [x2]
	adds	 x9, x9, x8
	adcs	x8, xzr, xzr
	str	 x9, [x0]
	mov	 x0, x8
	ret
.Lfunc_end11:
	.size	mcl_fp_addPre1L, .Lfunc_end11-mcl_fp_addPre1L

	.globl	mcl_fp_subPre1L
	.align	2
	.type	mcl_fp_subPre1L,@function
mcl_fp_subPre1L:                        // @mcl_fp_subPre1L
// BB#0:
	ldr	 x8, [x2]
	ldr	 x9, [x1]
	subs	 x9, x9, x8
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	 x9, [x0]
	mov	 x0, x8
	ret
.Lfunc_end12:
	.size	mcl_fp_subPre1L, .Lfunc_end12-mcl_fp_subPre1L

	.globl	mcl_fp_shr1_1L
	.align	2
	.type	mcl_fp_shr1_1L,@function
mcl_fp_shr1_1L:                         // @mcl_fp_shr1_1L
// BB#0:
	ldr	 x8, [x1]
	lsr	x8, x8, #1
	str	 x8, [x0]
	ret
.Lfunc_end13:
	.size	mcl_fp_shr1_1L, .Lfunc_end13-mcl_fp_shr1_1L

	.globl	mcl_fp_add1L
	.align	2
	.type	mcl_fp_add1L,@function
mcl_fp_add1L:                           // @mcl_fp_add1L
// BB#0:
	ldr	 x8, [x1]
	ldr	 x9, [x2]
	ldr	 x10, [x3]
	adds	 x8, x9, x8
	str	 x8, [x0]
	adcs	x9, xzr, xzr
	subs	 x8, x8, x10
	sbcs	x9, x9, xzr
	and	w9, w9, #0x1
	tbnz	w9, #0, .LBB14_2
// BB#1:                                // %nocarry
	str	 x8, [x0]
.LBB14_2:                               // %carry
	ret
.Lfunc_end14:
	.size	mcl_fp_add1L, .Lfunc_end14-mcl_fp_add1L

	.globl	mcl_fp_addNF1L
	.align	2
	.type	mcl_fp_addNF1L,@function
mcl_fp_addNF1L:                         // @mcl_fp_addNF1L
// BB#0:
	ldr	 x8, [x1]
	ldr	 x9, [x2]
	ldr	 x10, [x3]
	add	 x8, x9, x8
	sub	 x9, x8, x10
	cmp	 x9, #0                 // =0
	csel	x8, x8, x9, lt
	str	 x8, [x0]
	ret
.Lfunc_end15:
	.size	mcl_fp_addNF1L, .Lfunc_end15-mcl_fp_addNF1L

	.globl	mcl_fp_sub1L
	.align	2
	.type	mcl_fp_sub1L,@function
mcl_fp_sub1L:                           // @mcl_fp_sub1L
// BB#0:
	ldr	 x8, [x2]
	ldr	 x9, [x1]
	subs	 x8, x9, x8
	str	 x8, [x0]
	ngcs	 x9, xzr
	and	w9, w9, #0x1
	tbnz	w9, #0, .LBB16_2
// BB#1:                                // %nocarry
	ret
.LBB16_2:                               // %carry
	ldr	 x9, [x3]
	add	 x8, x9, x8
	str	 x8, [x0]
	ret
.Lfunc_end16:
	.size	mcl_fp_sub1L, .Lfunc_end16-mcl_fp_sub1L

	.globl	mcl_fp_subNF1L
	.align	2
	.type	mcl_fp_subNF1L,@function
mcl_fp_subNF1L:                         // @mcl_fp_subNF1L
// BB#0:
	ldr	 x8, [x2]
	ldr	 x9, [x1]
	ldr	 x10, [x3]
	sub	 x8, x9, x8
	and	x9, x10, x8, asr #63
	add	 x8, x9, x8
	str	 x8, [x0]
	ret
.Lfunc_end17:
	.size	mcl_fp_subNF1L, .Lfunc_end17-mcl_fp_subNF1L

	.globl	mcl_fpDbl_add1L
	.align	2
	.type	mcl_fpDbl_add1L,@function
mcl_fpDbl_add1L:                        // @mcl_fpDbl_add1L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	ldr	 x12, [x3]
	adds	 x8, x9, x8
	str	 x8, [x0]
	adcs	x8, x10, x11
	adcs	x9, xzr, xzr
	subs	 x10, x8, x12
	sbcs	x9, x9, xzr
	tst	 x9, #0x1
	csel	x8, x8, x10, ne
	str	x8, [x0, #8]
	ret
.Lfunc_end18:
	.size	mcl_fpDbl_add1L, .Lfunc_end18-mcl_fpDbl_add1L

	.globl	mcl_fpDbl_sub1L
	.align	2
	.type	mcl_fpDbl_sub1L,@function
mcl_fpDbl_sub1L:                        // @mcl_fpDbl_sub1L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	ldr	 x12, [x3]
	subs	 x8, x8, x9
	str	 x8, [x0]
	sbcs	x8, x11, x10
	ngcs	 x9, xzr
	tst	 x9, #0x1
	csel	x9, x12, xzr, ne
	add	 x8, x9, x8
	str	x8, [x0, #8]
	ret
.Lfunc_end19:
	.size	mcl_fpDbl_sub1L, .Lfunc_end19-mcl_fpDbl_sub1L

	.globl	mcl_fp_mulUnitPre2L
	.align	2
	.type	mcl_fp_mulUnitPre2L,@function
mcl_fp_mulUnitPre2L:                    // @mcl_fp_mulUnitPre2L
// BB#0:
	ldp	 x8, x9, [x1]
	mul	 x10, x8, x2
	mul	 x11, x9, x2
	umulh	x8, x8, x2
	umulh	x9, x9, x2
	adds	 x8, x8, x11
	stp	 x10, x8, [x0]
	adcs	x8, x9, xzr
	str	x8, [x0, #16]
	ret
.Lfunc_end20:
	.size	mcl_fp_mulUnitPre2L, .Lfunc_end20-mcl_fp_mulUnitPre2L

	.globl	mcl_fpDbl_mulPre2L
	.align	2
	.type	mcl_fpDbl_mulPre2L,@function
mcl_fpDbl_mulPre2L:                     // @mcl_fpDbl_mulPre2L
// BB#0:
	ldp	 x8, x11, [x2]
	ldp	 x9, x10, [x1]
	mul	 x12, x9, x8
	umulh	x13, x10, x8
	mul	 x14, x10, x8
	umulh	x8, x9, x8
	mul	 x15, x9, x11
	mul	 x16, x10, x11
	umulh	x9, x9, x11
	umulh	x10, x10, x11
	adds	 x8, x8, x14
	adcs	x11, x13, xzr
	adds	 x8, x8, x15
	stp	 x12, x8, [x0]
	adcs	x8, x11, x16
	adcs	x11, xzr, xzr
	adds	 x8, x8, x9
	str	x8, [x0, #16]
	adcs	x8, x11, x10
	str	x8, [x0, #24]
	ret
.Lfunc_end21:
	.size	mcl_fpDbl_mulPre2L, .Lfunc_end21-mcl_fpDbl_mulPre2L

	.globl	mcl_fpDbl_sqrPre2L
	.align	2
	.type	mcl_fpDbl_sqrPre2L,@function
mcl_fpDbl_sqrPre2L:                     // @mcl_fpDbl_sqrPre2L
// BB#0:
	ldp	 x8, x9, [x1]
	mul	 x10, x8, x8
	umulh	x11, x9, x8
	mul	 x12, x9, x8
	umulh	x8, x8, x8
	umulh	x13, x9, x9
	mul	 x9, x9, x9
	str	 x10, [x0]
	adds	 x8, x8, x12
	adcs	x10, x11, xzr
	adds	 x9, x11, x9
	adcs	x11, x13, xzr
	adds	 x8, x12, x8
	str	x8, [x0, #8]
	adcs	x8, x9, x10
	str	x8, [x0, #16]
	adcs	x8, x11, xzr
	str	x8, [x0, #24]
	ret
.Lfunc_end22:
	.size	mcl_fpDbl_sqrPre2L, .Lfunc_end22-mcl_fpDbl_sqrPre2L

	.globl	mcl_fp_mont2L
	.align	2
	.type	mcl_fp_mont2L,@function
mcl_fp_mont2L:                          // @mcl_fp_mont2L
// BB#0:
	ldp	 x8, x14, [x2]
	ldp	 x9, x10, [x1]
	ldur	x11, [x3, #-8]
	ldp	 x12, x13, [x3]
	umulh	x15, x10, x8
	mul	 x16, x10, x8
	umulh	x17, x9, x8
	mul	 x8, x9, x8
	umulh	x18, x14, x10
	mul	 x10, x14, x10
	umulh	x1, x14, x9
	mul	 x9, x14, x9
	adds	 x14, x17, x16
	mul	 x16, x8, x11
	adcs	x15, x15, xzr
	mul	 x17, x16, x13
	umulh	x2, x16, x12
	adds	 x17, x2, x17
	umulh	x2, x16, x13
	mul	 x16, x16, x12
	adcs	x2, x2, xzr
	cmn	 x16, x8
	adcs	x8, x17, x14
	adcs	x14, x2, x15
	adcs	x15, xzr, xzr
	adds	 x10, x1, x10
	adcs	x16, x18, xzr
	adds	 x8, x8, x9
	adcs	x9, x14, x10
	mul	 x10, x8, x11
	adcs	x11, x15, x16
	umulh	x14, x10, x13
	mul	 x15, x10, x13
	umulh	x16, x10, x12
	mul	 x10, x10, x12
	adcs	x17, xzr, xzr
	adds	 x15, x16, x15
	adcs	x14, x14, xzr
	cmn	 x10, x8
	adcs	x8, x15, x9
	adcs	x9, x14, x11
	adcs	x10, x17, xzr
	subs	 x11, x8, x12
	sbcs	x12, x9, x13
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x8, x8, x11, ne
	csel	x9, x9, x12, ne
	stp	 x8, x9, [x0]
	ret
.Lfunc_end23:
	.size	mcl_fp_mont2L, .Lfunc_end23-mcl_fp_mont2L

	.globl	mcl_fp_montNF2L
	.align	2
	.type	mcl_fp_montNF2L,@function
mcl_fp_montNF2L:                        // @mcl_fp_montNF2L
// BB#0:
	ldp	 x8, x14, [x2]
	ldp	 x9, x10, [x1]
	ldur	x11, [x3, #-8]
	ldp	 x12, x13, [x3]
	umulh	x15, x10, x8
	mul	 x16, x10, x8
	umulh	x17, x9, x8
	mul	 x8, x9, x8
	umulh	x18, x14, x10
	mul	 x10, x14, x10
	umulh	x1, x14, x9
	mul	 x9, x14, x9
	adds	 x14, x17, x16
	mul	 x16, x8, x11
	adcs	x15, x15, xzr
	mul	 x17, x16, x12
	cmn	 x17, x8
	mul	 x8, x16, x13
	umulh	x17, x16, x13
	umulh	x16, x16, x12
	adcs	x8, x8, x14
	adcs	x14, x15, xzr
	adds	 x8, x8, x16
	adcs	x14, x14, x17
	adds	 x10, x1, x10
	adcs	x15, x18, xzr
	adds	 x8, x9, x8
	adcs	x9, x10, x14
	mul	 x10, x8, x11
	adcs	x11, x15, xzr
	mul	 x14, x10, x13
	mul	 x15, x10, x12
	umulh	x16, x10, x13
	umulh	x10, x10, x12
	cmn	 x15, x8
	adcs	x8, x14, x9
	adcs	x9, x11, xzr
	adds	 x8, x8, x10
	adcs	x9, x9, x16
	subs	 x10, x8, x12
	sbcs	x11, x9, x13
	cmp	 x11, #0                // =0
	csel	x8, x8, x10, lt
	csel	x9, x9, x11, lt
	stp	 x8, x9, [x0]
	ret
.Lfunc_end24:
	.size	mcl_fp_montNF2L, .Lfunc_end24-mcl_fp_montNF2L

	.globl	mcl_fp_montRed2L
	.align	2
	.type	mcl_fp_montRed2L,@function
mcl_fp_montRed2L:                       // @mcl_fp_montRed2L
// BB#0:
	ldur	x8, [x2, #-8]
	ldp	 x9, x14, [x1]
	ldp	 x10, x11, [x2]
	ldp	x12, x13, [x1, #16]
	mul	 x15, x9, x8
	mul	 x16, x15, x11
	umulh	x17, x15, x10
	adds	 x16, x17, x16
	umulh	x17, x15, x11
	mul	 x15, x15, x10
	adcs	x17, x17, xzr
	cmn	 x9, x15
	adcs	x9, x14, x16
	adcs	x12, x12, x17
	mul	 x8, x9, x8
	adcs	x13, x13, xzr
	umulh	x14, x8, x11
	mul	 x15, x8, x11
	umulh	x16, x8, x10
	mul	 x8, x8, x10
	adcs	x17, xzr, xzr
	adds	 x15, x16, x15
	adcs	x14, x14, xzr
	cmn	 x8, x9
	adcs	x8, x15, x12
	adcs	x9, x14, x13
	adcs	x12, x17, xzr
	subs	 x10, x8, x10
	sbcs	x11, x9, x11
	sbcs	x12, x12, xzr
	tst	 x12, #0x1
	csel	x8, x8, x10, ne
	csel	x9, x9, x11, ne
	stp	 x8, x9, [x0]
	ret
.Lfunc_end25:
	.size	mcl_fp_montRed2L, .Lfunc_end25-mcl_fp_montRed2L

	.globl	mcl_fp_addPre2L
	.align	2
	.type	mcl_fp_addPre2L,@function
mcl_fp_addPre2L:                        // @mcl_fp_addPre2L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	adds	 x8, x9, x8
	str	 x8, [x0]
	adcs	x9, x10, x11
	adcs	x8, xzr, xzr
	str	x9, [x0, #8]
	mov	 x0, x8
	ret
.Lfunc_end26:
	.size	mcl_fp_addPre2L, .Lfunc_end26-mcl_fp_addPre2L

	.globl	mcl_fp_subPre2L
	.align	2
	.type	mcl_fp_subPre2L,@function
mcl_fp_subPre2L:                        // @mcl_fp_subPre2L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	subs	 x8, x8, x9
	str	 x8, [x0]
	sbcs	x9, x11, x10
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0, #8]
	mov	 x0, x8
	ret
.Lfunc_end27:
	.size	mcl_fp_subPre2L, .Lfunc_end27-mcl_fp_subPre2L

	.globl	mcl_fp_shr1_2L
	.align	2
	.type	mcl_fp_shr1_2L,@function
mcl_fp_shr1_2L:                         // @mcl_fp_shr1_2L
// BB#0:
	ldp	 x8, x9, [x1]
	extr	x8, x9, x8, #1
	lsr	x9, x9, #1
	stp	 x8, x9, [x0]
	ret
.Lfunc_end28:
	.size	mcl_fp_shr1_2L, .Lfunc_end28-mcl_fp_shr1_2L

	.globl	mcl_fp_add2L
	.align	2
	.type	mcl_fp_add2L,@function
mcl_fp_add2L:                           // @mcl_fp_add2L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	adds	 x8, x9, x8
	ldp	 x9, x12, [x3]
	adcs	x10, x10, x11
	stp	 x8, x10, [x0]
	adcs	x11, xzr, xzr
	subs	 x9, x8, x9
	sbcs	x8, x10, x12
	sbcs	x10, x11, xzr
	and	w10, w10, #0x1
	tbnz	w10, #0, .LBB29_2
// BB#1:                                // %nocarry
	stp	 x9, x8, [x0]
.LBB29_2:                               // %carry
	ret
.Lfunc_end29:
	.size	mcl_fp_add2L, .Lfunc_end29-mcl_fp_add2L

	.globl	mcl_fp_addNF2L
	.align	2
	.type	mcl_fp_addNF2L,@function
mcl_fp_addNF2L:                         // @mcl_fp_addNF2L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	 x10, x11, [x2]
	ldp	 x12, x13, [x3]
	adds	 x8, x10, x8
	adcs	x9, x11, x9
	subs	 x10, x8, x12
	sbcs	x11, x9, x13
	cmp	 x11, #0                // =0
	csel	x8, x8, x10, lt
	csel	x9, x9, x11, lt
	stp	 x8, x9, [x0]
	ret
.Lfunc_end30:
	.size	mcl_fp_addNF2L, .Lfunc_end30-mcl_fp_addNF2L

	.globl	mcl_fp_sub2L
	.align	2
	.type	mcl_fp_sub2L,@function
mcl_fp_sub2L:                           // @mcl_fp_sub2L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	subs	 x9, x8, x9
	sbcs	x8, x11, x10
	stp	 x9, x8, [x0]
	ngcs	 x10, xzr
	and	w10, w10, #0x1
	tbnz	w10, #0, .LBB31_2
// BB#1:                                // %nocarry
	ret
.LBB31_2:                               // %carry
	ldp	 x10, x11, [x3]
	adds	 x9, x10, x9
	adcs	x8, x11, x8
	stp	 x9, x8, [x0]
	ret
.Lfunc_end31:
	.size	mcl_fp_sub2L, .Lfunc_end31-mcl_fp_sub2L

	.globl	mcl_fp_subNF2L
	.align	2
	.type	mcl_fp_subNF2L,@function
mcl_fp_subNF2L:                         // @mcl_fp_subNF2L
// BB#0:
	ldp	 x8, x11, [x1]
	ldp	 x9, x10, [x2]
	subs	 x8, x8, x9
	ldp	 x9, x12, [x3]
	sbcs	x10, x11, x10
	asr	x11, x10, #63
	and	 x9, x11, x9
	and	 x11, x11, x12
	adds	 x8, x9, x8
	str	 x8, [x0]
	adcs	x8, x11, x10
	str	x8, [x0, #8]
	ret
.Lfunc_end32:
	.size	mcl_fp_subNF2L, .Lfunc_end32-mcl_fp_subNF2L

	.globl	mcl_fpDbl_add2L
	.align	2
	.type	mcl_fpDbl_add2L,@function
mcl_fpDbl_add2L:                        // @mcl_fpDbl_add2L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x15, [x1]
	ldp	 x11, x14, [x2]
	ldp	x12, x13, [x1, #16]
	adds	 x10, x11, x10
	ldp	 x11, x16, [x3]
	str	 x10, [x0]
	adcs	x10, x14, x15
	str	x10, [x0, #8]
	adcs	x8, x8, x12
	adcs	x9, x9, x13
	adcs	x10, xzr, xzr
	subs	 x11, x8, x11
	sbcs	x12, x9, x16
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x8, x8, x11, ne
	csel	x9, x9, x12, ne
	stp	x8, x9, [x0, #16]
	ret
.Lfunc_end33:
	.size	mcl_fpDbl_add2L, .Lfunc_end33-mcl_fpDbl_add2L

	.globl	mcl_fpDbl_sub2L
	.align	2
	.type	mcl_fpDbl_sub2L,@function
mcl_fpDbl_sub2L:                        // @mcl_fpDbl_sub2L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x14, [x2]
	ldp	 x11, x15, [x1]
	ldp	x12, x13, [x1, #16]
	subs	 x10, x11, x10
	ldp	 x11, x16, [x3]
	str	 x10, [x0]
	sbcs	x10, x15, x14
	str	x10, [x0, #8]
	sbcs	x8, x12, x8
	sbcs	x9, x13, x9
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x16, xzr, ne
	csel	x11, x11, xzr, ne
	adds	 x8, x11, x8
	str	x8, [x0, #16]
	adcs	x8, x10, x9
	str	x8, [x0, #24]
	ret
.Lfunc_end34:
	.size	mcl_fpDbl_sub2L, .Lfunc_end34-mcl_fpDbl_sub2L

	.globl	mcl_fp_mulUnitPre3L
	.align	2
	.type	mcl_fp_mulUnitPre3L,@function
mcl_fp_mulUnitPre3L:                    // @mcl_fp_mulUnitPre3L
// BB#0:
	ldp	 x8, x9, [x1]
	ldr	x10, [x1, #16]
	mul	 x11, x8, x2
	mul	 x12, x9, x2
	umulh	x8, x8, x2
	mul	 x13, x10, x2
	umulh	x9, x9, x2
	umulh	x10, x10, x2
	adds	 x8, x8, x12
	stp	 x11, x8, [x0]
	adcs	x8, x9, x13
	str	x8, [x0, #16]
	adcs	x8, x10, xzr
	str	x8, [x0, #24]
	ret
.Lfunc_end35:
	.size	mcl_fp_mulUnitPre3L, .Lfunc_end35-mcl_fp_mulUnitPre3L

	.globl	mcl_fpDbl_mulPre3L
	.align	2
	.type	mcl_fpDbl_mulPre3L,@function
mcl_fpDbl_mulPre3L:                     // @mcl_fpDbl_mulPre3L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	 x8, x9, [x1]
	ldp	 x10, x12, [x2]
	ldr	x11, [x1, #16]
	ldr	x13, [x2, #16]
	mul	 x14, x8, x10
	umulh	x15, x11, x10
	mul	 x16, x11, x10
	umulh	x17, x9, x10
	mul	 x18, x9, x10
	umulh	x10, x8, x10
	mul	 x1, x8, x12
	mul	 x2, x11, x12
	mul	 x3, x9, x12
	umulh	x4, x11, x12
	umulh	x5, x9, x12
	umulh	x12, x8, x12
	mul	 x6, x8, x13
	mul	 x7, x11, x13
	mul	 x19, x9, x13
	umulh	x8, x8, x13
	umulh	x9, x9, x13
	umulh	x11, x11, x13
	str	 x14, [x0]
	adds	 x10, x10, x18
	adcs	x13, x17, x16
	adcs	x14, x15, xzr
	adds	 x10, x10, x1
	str	x10, [x0, #8]
	adcs	x10, x13, x3
	adcs	x13, x14, x2
	adcs	x14, xzr, xzr
	adds	 x10, x10, x12
	adcs	x12, x13, x5
	adcs	x13, x14, x4
	adds	 x10, x10, x6
	str	x10, [x0, #16]
	adcs	x10, x12, x19
	adcs	x12, x13, x7
	adcs	x13, xzr, xzr
	adds	 x8, x10, x8
	str	x8, [x0, #24]
	adcs	x8, x12, x9
	str	x8, [x0, #32]
	adcs	x8, x13, x11
	str	x8, [x0, #40]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end36:
	.size	mcl_fpDbl_mulPre3L, .Lfunc_end36-mcl_fpDbl_mulPre3L

	.globl	mcl_fpDbl_sqrPre3L
	.align	2
	.type	mcl_fpDbl_sqrPre3L,@function
mcl_fpDbl_sqrPre3L:                     // @mcl_fpDbl_sqrPre3L
// BB#0:
	ldp	 x8, x10, [x1]
	ldr	x9, [x1, #16]
	mul	 x11, x8, x8
	umulh	x12, x9, x8
	mul	 x13, x9, x8
	umulh	x14, x10, x8
	mul	 x15, x10, x8
	umulh	x8, x8, x8
	mul	 x16, x9, x10
	str	 x11, [x0]
	adds	 x8, x8, x15
	adcs	x11, x14, x13
	adcs	x17, x12, xzr
	adds	 x8, x8, x15
	mul	 x15, x10, x10
	str	x8, [x0, #8]
	umulh	x8, x9, x10
	umulh	x10, x10, x10
	adcs	x11, x11, x15
	adcs	x15, x17, x16
	adcs	x17, xzr, xzr
	adds	 x11, x11, x14
	umulh	x14, x9, x9
	mul	 x9, x9, x9
	adcs	x10, x15, x10
	adcs	x15, x17, x8
	adds	 x12, x12, x16
	adcs	x8, x8, x9
	adcs	x9, x14, xzr
	adds	 x11, x13, x11
	adcs	x10, x12, x10
	stp	x11, x10, [x0, #16]
	adcs	x8, x8, x15
	str	x8, [x0, #32]
	adcs	x8, x9, xzr
	str	x8, [x0, #40]
	ret
.Lfunc_end37:
	.size	mcl_fpDbl_sqrPre3L, .Lfunc_end37-mcl_fpDbl_sqrPre3L

	.globl	mcl_fp_mont3L
	.align	2
	.type	mcl_fp_mont3L,@function
mcl_fp_mont3L:                          // @mcl_fp_mont3L
// BB#0:
	stp	x24, x23, [sp, #-48]!
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	ldp	 x15, x16, [x2]
	ldp	x13, x14, [x1, #8]
	ldr	 x12, [x1]
	ldur	x11, [x3, #-8]
	ldp	x9, x8, [x3, #8]
	ldr	 x10, [x3]
	ldr	x17, [x2, #16]
	umulh	x18, x14, x15
	mul	 x1, x14, x15
	umulh	x2, x13, x15
	mul	 x3, x13, x15
	umulh	x4, x12, x15
	mul	 x15, x12, x15
	umulh	x5, x16, x14
	mul	 x6, x16, x14
	umulh	x7, x16, x13
	mul	 x19, x16, x13
	umulh	x20, x16, x12
	mul	 x16, x16, x12
	umulh	x21, x17, x14
	mul	 x14, x17, x14
	adds	 x3, x4, x3
	mul	 x4, x15, x11
	adcs	x1, x2, x1
	mul	 x2, x4, x8
	mul	 x22, x4, x9
	umulh	x23, x4, x10
	adcs	x18, x18, xzr
	adds	 x22, x23, x22
	umulh	x23, x4, x9
	adcs	x2, x23, x2
	umulh	x23, x4, x8
	mul	 x4, x4, x10
	adcs	x23, x23, xzr
	cmn	 x4, x15
	umulh	x15, x17, x13
	mul	 x13, x17, x13
	umulh	x4, x17, x12
	mul	 x12, x17, x12
	adcs	x17, x22, x3
	adcs	x1, x2, x1
	adcs	x18, x23, x18
	adcs	x2, xzr, xzr
	adds	 x3, x20, x19
	adcs	x6, x7, x6
	adcs	x5, x5, xzr
	adds	 x16, x17, x16
	adcs	x17, x1, x3
	mul	 x1, x16, x11
	adcs	x18, x18, x6
	mul	 x3, x1, x8
	mul	 x6, x1, x9
	umulh	x7, x1, x10
	adcs	x2, x2, x5
	adcs	x5, xzr, xzr
	adds	 x6, x7, x6
	umulh	x7, x1, x9
	adcs	x3, x7, x3
	umulh	x7, x1, x8
	mul	 x1, x1, x10
	adcs	x7, x7, xzr
	cmn	 x1, x16
	adcs	x16, x6, x17
	adcs	x17, x3, x18
	adcs	x18, x7, x2
	adcs	x1, x5, xzr
	adds	 x13, x4, x13
	adcs	x14, x15, x14
	adcs	x15, x21, xzr
	adds	 x12, x16, x12
	adcs	x13, x17, x13
	mul	 x11, x12, x11
	adcs	x14, x18, x14
	umulh	x16, x11, x8
	mul	 x17, x11, x8
	umulh	x18, x11, x9
	mul	 x2, x11, x9
	umulh	x3, x11, x10
	mul	 x11, x11, x10
	adcs	x15, x1, x15
	adcs	x1, xzr, xzr
	adds	 x2, x3, x2
	adcs	x17, x18, x17
	adcs	x16, x16, xzr
	cmn	 x11, x12
	adcs	x11, x2, x13
	adcs	x12, x17, x14
	adcs	x13, x16, x15
	adcs	x14, x1, xzr
	subs	 x10, x11, x10
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	sbcs	x14, x14, xzr
	tst	 x14, #0x1
	csel	x10, x11, x10, ne
	csel	x9, x12, x9, ne
	csel	x8, x13, x8, ne
	stp	 x10, x9, [x0]
	str	x8, [x0, #16]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #48
	ret
.Lfunc_end38:
	.size	mcl_fp_mont3L, .Lfunc_end38-mcl_fp_mont3L

	.globl	mcl_fp_montNF3L
	.align	2
	.type	mcl_fp_montNF3L,@function
mcl_fp_montNF3L:                        // @mcl_fp_montNF3L
// BB#0:
	stp	x22, x21, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	ldp	 x14, x16, [x2]
	ldp	x15, x13, [x1, #8]
	ldr	 x12, [x1]
	ldur	x11, [x3, #-8]
	ldp	x9, x8, [x3, #8]
	ldr	 x10, [x3]
	ldr	x17, [x2, #16]
	umulh	x18, x13, x14
	mul	 x1, x13, x14
	umulh	x2, x15, x14
	mul	 x3, x15, x14
	umulh	x4, x12, x14
	mul	 x14, x12, x14
	umulh	x5, x16, x13
	mul	 x6, x16, x13
	umulh	x7, x16, x15
	mul	 x19, x16, x15
	umulh	x20, x16, x12
	mul	 x16, x16, x12
	umulh	x21, x17, x13
	mul	 x13, x17, x13
	adds	 x3, x4, x3
	mul	 x4, x14, x11
	adcs	x1, x2, x1
	mul	 x2, x4, x10
	adcs	x18, x18, xzr
	cmn	 x2, x14
	umulh	x14, x17, x15
	mul	 x15, x17, x15
	umulh	x2, x17, x12
	mul	 x12, x17, x12
	mul	 x17, x4, x9
	adcs	x17, x17, x3
	mul	 x3, x4, x8
	adcs	x1, x3, x1
	umulh	x3, x4, x10
	adcs	x18, x18, xzr
	adds	 x17, x17, x3
	umulh	x3, x4, x9
	adcs	x1, x1, x3
	umulh	x3, x4, x8
	adcs	x18, x18, x3
	adds	 x3, x20, x19
	adcs	x4, x7, x6
	adcs	x5, x5, xzr
	adds	 x16, x16, x17
	adcs	x17, x3, x1
	mul	 x1, x16, x11
	adcs	x18, x4, x18
	mul	 x3, x1, x8
	mul	 x4, x1, x10
	adcs	x5, x5, xzr
	cmn	 x4, x16
	mul	 x16, x1, x9
	umulh	x4, x1, x8
	adcs	x16, x16, x17
	umulh	x17, x1, x9
	umulh	x1, x1, x10
	adcs	x18, x3, x18
	adcs	x3, x5, xzr
	adds	 x16, x16, x1
	adcs	x17, x18, x17
	adcs	x18, x3, x4
	adds	 x15, x2, x15
	adcs	x13, x14, x13
	adcs	x14, x21, xzr
	adds	 x12, x12, x16
	adcs	x15, x15, x17
	mul	 x11, x12, x11
	adcs	x13, x13, x18
	mul	 x16, x11, x8
	mul	 x17, x11, x9
	mul	 x18, x11, x10
	umulh	x1, x11, x8
	umulh	x2, x11, x9
	umulh	x11, x11, x10
	adcs	x14, x14, xzr
	cmn	 x18, x12
	adcs	x12, x17, x15
	adcs	x13, x16, x13
	adcs	x14, x14, xzr
	adds	 x11, x12, x11
	adcs	x12, x13, x2
	adcs	x13, x14, x1
	subs	 x10, x11, x10
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	asr	x14, x8, #63
	cmp	 x14, #0                // =0
	csel	x10, x11, x10, lt
	csel	x9, x12, x9, lt
	csel	x8, x13, x8, lt
	stp	 x10, x9, [x0]
	str	x8, [x0, #16]
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #32
	ret
.Lfunc_end39:
	.size	mcl_fp_montNF3L, .Lfunc_end39-mcl_fp_montNF3L

	.globl	mcl_fp_montRed3L
	.align	2
	.type	mcl_fp_montRed3L,@function
mcl_fp_montRed3L:                       // @mcl_fp_montRed3L
// BB#0:
	ldur	x8, [x2, #-8]
	ldp	 x9, x17, [x1]
	ldp	x12, x10, [x2, #8]
	ldr	 x11, [x2]
	ldp	x13, x14, [x1, #32]
	ldp	x15, x16, [x1, #16]
	mul	 x18, x9, x8
	umulh	x1, x18, x10
	mul	 x2, x18, x10
	umulh	x3, x18, x12
	mul	 x4, x18, x12
	umulh	x5, x18, x11
	mul	 x18, x18, x11
	adds	 x4, x5, x4
	adcs	x2, x3, x2
	adcs	x1, x1, xzr
	cmn	 x9, x18
	adcs	x9, x17, x4
	adcs	x15, x15, x2
	mul	 x17, x9, x8
	adcs	x16, x16, x1
	umulh	x18, x17, x10
	mul	 x1, x17, x10
	umulh	x2, x17, x12
	mul	 x3, x17, x12
	umulh	x4, x17, x11
	mul	 x17, x17, x11
	adcs	x13, x13, xzr
	adcs	x14, x14, xzr
	adcs	x5, xzr, xzr
	adds	 x3, x4, x3
	adcs	x1, x2, x1
	adcs	x18, x18, xzr
	cmn	 x17, x9
	adcs	x9, x3, x15
	adcs	x15, x1, x16
	mul	 x8, x9, x8
	adcs	x13, x18, x13
	umulh	x16, x8, x10
	mul	 x17, x8, x10
	umulh	x18, x8, x12
	mul	 x1, x8, x12
	umulh	x2, x8, x11
	mul	 x8, x8, x11
	adcs	x14, x14, xzr
	adcs	x3, x5, xzr
	adds	 x1, x2, x1
	adcs	x17, x18, x17
	adcs	x16, x16, xzr
	cmn	 x8, x9
	adcs	x8, x1, x15
	adcs	x9, x17, x13
	adcs	x13, x16, x14
	adcs	x14, x3, xzr
	subs	 x11, x8, x11
	sbcs	x12, x9, x12
	sbcs	x10, x13, x10
	sbcs	x14, x14, xzr
	tst	 x14, #0x1
	csel	x8, x8, x11, ne
	csel	x9, x9, x12, ne
	csel	x10, x13, x10, ne
	stp	 x8, x9, [x0]
	str	x10, [x0, #16]
	ret
.Lfunc_end40:
	.size	mcl_fp_montRed3L, .Lfunc_end40-mcl_fp_montRed3L

	.globl	mcl_fp_addPre3L
	.align	2
	.type	mcl_fp_addPre3L,@function
mcl_fp_addPre3L:                        // @mcl_fp_addPre3L
// BB#0:
	ldp	x11, x8, [x2, #8]
	ldp	 x9, x12, [x1]
	ldr	 x10, [x2]
	ldr	x13, [x1, #16]
	adds	 x9, x10, x9
	str	 x9, [x0]
	adcs	x9, x11, x12
	str	x9, [x0, #8]
	adcs	x9, x8, x13
	adcs	x8, xzr, xzr
	str	x9, [x0, #16]
	mov	 x0, x8
	ret
.Lfunc_end41:
	.size	mcl_fp_addPre3L, .Lfunc_end41-mcl_fp_addPre3L

	.globl	mcl_fp_subPre3L
	.align	2
	.type	mcl_fp_subPre3L,@function
mcl_fp_subPre3L:                        // @mcl_fp_subPre3L
// BB#0:
	ldp	x11, x8, [x2, #8]
	ldp	 x9, x12, [x1]
	ldr	 x10, [x2]
	ldr	x13, [x1, #16]
	subs	 x9, x9, x10
	str	 x9, [x0]
	sbcs	x9, x12, x11
	str	x9, [x0, #8]
	sbcs	x9, x13, x8
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0, #16]
	mov	 x0, x8
	ret
.Lfunc_end42:
	.size	mcl_fp_subPre3L, .Lfunc_end42-mcl_fp_subPre3L

	.globl	mcl_fp_shr1_3L
	.align	2
	.type	mcl_fp_shr1_3L,@function
mcl_fp_shr1_3L:                         // @mcl_fp_shr1_3L
// BB#0:
	ldp	 x8, x9, [x1]
	ldr	x10, [x1, #16]
	extr	x8, x9, x8, #1
	extr	x9, x10, x9, #1
	lsr	x10, x10, #1
	stp	 x8, x9, [x0]
	str	x10, [x0, #16]
	ret
.Lfunc_end43:
	.size	mcl_fp_shr1_3L, .Lfunc_end43-mcl_fp_shr1_3L

	.globl	mcl_fp_add3L
	.align	2
	.type	mcl_fp_add3L,@function
mcl_fp_add3L:                           // @mcl_fp_add3L
// BB#0:
	ldp	x11, x8, [x2, #8]
	ldp	 x9, x12, [x1]
	ldr	 x10, [x2]
	ldr	x13, [x1, #16]
	adds	 x9, x10, x9
	adcs	x11, x11, x12
	ldr	 x10, [x3]
	ldp	x12, x14, [x3, #8]
	stp	 x9, x11, [x0]
	adcs	x8, x8, x13
	str	x8, [x0, #16]
	adcs	x13, xzr, xzr
	subs	 x10, x9, x10
	sbcs	x9, x11, x12
	sbcs	x8, x8, x14
	sbcs	x11, x13, xzr
	and	w11, w11, #0x1
	tbnz	w11, #0, .LBB44_2
// BB#1:                                // %nocarry
	stp	 x10, x9, [x0]
	str	x8, [x0, #16]
.LBB44_2:                               // %carry
	ret
.Lfunc_end44:
	.size	mcl_fp_add3L, .Lfunc_end44-mcl_fp_add3L

	.globl	mcl_fp_addNF3L
	.align	2
	.type	mcl_fp_addNF3L,@function
mcl_fp_addNF3L:                         // @mcl_fp_addNF3L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	 x10, x11, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	adds	 x8, x10, x8
	adcs	x9, x11, x9
	ldp	 x10, x11, [x3]
	ldr	x14, [x3, #16]
	adcs	x12, x13, x12
	subs	 x10, x8, x10
	sbcs	x11, x9, x11
	sbcs	x13, x12, x14
	asr	x14, x13, #63
	cmp	 x14, #0                // =0
	csel	x8, x8, x10, lt
	csel	x9, x9, x11, lt
	csel	x10, x12, x13, lt
	stp	 x8, x9, [x0]
	str	x10, [x0, #16]
	ret
.Lfunc_end45:
	.size	mcl_fp_addNF3L, .Lfunc_end45-mcl_fp_addNF3L

	.globl	mcl_fp_sub3L
	.align	2
	.type	mcl_fp_sub3L,@function
mcl_fp_sub3L:                           // @mcl_fp_sub3L
// BB#0:
	ldp	x11, x10, [x2, #8]
	ldp	 x8, x12, [x1]
	ldr	 x9, [x2]
	ldr	x13, [x1, #16]
	subs	 x8, x8, x9
	sbcs	x9, x12, x11
	stp	 x8, x9, [x0]
	sbcs	x10, x13, x10
	str	x10, [x0, #16]
	ngcs	 x11, xzr
	and	w11, w11, #0x1
	tbnz	w11, #0, .LBB46_2
// BB#1:                                // %nocarry
	ret
.LBB46_2:                               // %carry
	ldp	x13, x11, [x3, #8]
	ldr	 x12, [x3]
	adds	 x8, x12, x8
	adcs	x9, x13, x9
	adcs	x10, x11, x10
	stp	 x8, x9, [x0]
	str	x10, [x0, #16]
	ret
.Lfunc_end46:
	.size	mcl_fp_sub3L, .Lfunc_end46-mcl_fp_sub3L

	.globl	mcl_fp_subNF3L
	.align	2
	.type	mcl_fp_subNF3L,@function
mcl_fp_subNF3L:                         // @mcl_fp_subNF3L
// BB#0:
	ldp	 x8, x9, [x2]
	ldp	 x10, x11, [x1]
	ldr	x12, [x2, #16]
	ldr	x13, [x1, #16]
	subs	 x8, x10, x8
	sbcs	x9, x11, x9
	ldp	 x10, x11, [x3]
	ldr	x14, [x3, #16]
	sbcs	x12, x13, x12
	asr	x13, x12, #63
	and	 x11, x13, x11
	and	 x14, x13, x14
	extr	x13, x13, x12, #63
	and	 x10, x13, x10
	adds	 x8, x10, x8
	str	 x8, [x0]
	adcs	x8, x11, x9
	str	x8, [x0, #8]
	adcs	x8, x14, x12
	str	x8, [x0, #16]
	ret
.Lfunc_end47:
	.size	mcl_fp_subNF3L, .Lfunc_end47-mcl_fp_subNF3L

	.globl	mcl_fpDbl_add3L
	.align	2
	.type	mcl_fpDbl_add3L,@function
mcl_fpDbl_add3L:                        // @mcl_fpDbl_add3L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x15, x18, [x2]
	ldp	x16, x17, [x1, #16]
	ldp	 x14, x1, [x1]
	adds	 x14, x15, x14
	ldr	x15, [x3, #16]
	str	 x14, [x0]
	ldp	 x14, x2, [x3]
	adcs	x18, x18, x1
	adcs	x12, x12, x16
	stp	x18, x12, [x0, #8]
	adcs	x12, x13, x17
	adcs	x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, xzr, xzr
	subs	 x11, x12, x14
	sbcs	x13, x8, x2
	sbcs	x14, x9, x15
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x10, x12, x11, ne
	csel	x8, x8, x13, ne
	csel	x9, x9, x14, ne
	stp	x10, x8, [x0, #24]
	str	x9, [x0, #40]
	ret
.Lfunc_end48:
	.size	mcl_fpDbl_add3L, .Lfunc_end48-mcl_fpDbl_add3L

	.globl	mcl_fpDbl_sub3L
	.align	2
	.type	mcl_fpDbl_sub3L,@function
mcl_fpDbl_sub3L:                        // @mcl_fpDbl_sub3L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x14, x18, [x2]
	ldp	x16, x17, [x1, #16]
	ldp	 x15, x1, [x1]
	subs	 x14, x15, x14
	ldr	x15, [x3, #16]
	str	 x14, [x0]
	ldp	 x14, x2, [x3]
	sbcs	x18, x1, x18
	sbcs	x12, x16, x12
	stp	x18, x12, [x0, #8]
	sbcs	x12, x17, x13
	sbcs	x8, x10, x8
	sbcs	x9, x11, x9
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x15, xzr, ne
	csel	x11, x2, xzr, ne
	csel	x13, x14, xzr, ne
	adds	 x12, x13, x12
	adcs	x8, x11, x8
	stp	x12, x8, [x0, #24]
	adcs	x8, x10, x9
	str	x8, [x0, #40]
	ret
.Lfunc_end49:
	.size	mcl_fpDbl_sub3L, .Lfunc_end49-mcl_fpDbl_sub3L

	.globl	mcl_fp_mulUnitPre4L
	.align	2
	.type	mcl_fp_mulUnitPre4L,@function
mcl_fp_mulUnitPre4L:                    // @mcl_fp_mulUnitPre4L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	mul	 x12, x8, x2
	mul	 x13, x9, x2
	umulh	x8, x8, x2
	mul	 x14, x10, x2
	umulh	x9, x9, x2
	mul	 x15, x11, x2
	umulh	x10, x10, x2
	umulh	x11, x11, x2
	adds	 x8, x8, x13
	stp	 x12, x8, [x0]
	adcs	x8, x9, x14
	str	x8, [x0, #16]
	adcs	x8, x10, x15
	str	x8, [x0, #24]
	adcs	x8, x11, xzr
	str	x8, [x0, #32]
	ret
.Lfunc_end50:
	.size	mcl_fp_mulUnitPre4L, .Lfunc_end50-mcl_fp_mulUnitPre4L

	.globl	mcl_fpDbl_mulPre4L
	.align	2
	.type	mcl_fpDbl_mulPre4L,@function
mcl_fpDbl_mulPre4L:                     // @mcl_fpDbl_mulPre4L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #32             // =32
	ldp	 x8, x10, [x1]
	ldp	 x9, x11, [x1]
	ldp	x12, x14, [x1, #16]
	ldp	x13, x1, [x1, #16]
	ldp	 x15, x16, [x2]
	ldp	x17, x18, [x2, #16]
	mul	 x2, x8, x15
	umulh	x3, x14, x15
	mul	 x4, x14, x15
	umulh	x5, x12, x15
	mul	 x6, x12, x15
	umulh	x7, x10, x15
	mul	 x19, x10, x15
	umulh	x15, x8, x15
	mul	 x20, x8, x16
	mul	 x21, x14, x16
	mul	 x22, x12, x16
	mul	 x23, x10, x16
	umulh	x24, x14, x16
	umulh	x25, x12, x16
	umulh	x26, x10, x16
	umulh	x16, x8, x16
	mul	 x27, x8, x17
	mul	 x28, x14, x17
	mul	 x29, x12, x17
	mul	 x30, x10, x17
	umulh	x14, x14, x17
	stp	x3, x14, [sp, #16]
	umulh	x12, x12, x17
	str	x12, [sp, #8]           // 8-byte Folded Spill
	umulh	x3, x10, x17
	umulh	x14, x8, x17
	mul	 x17, x9, x18
	umulh	x12, x9, x18
	mul	 x10, x11, x18
	umulh	x11, x11, x18
	mul	 x9, x13, x18
	umulh	x13, x13, x18
	mul	 x8, x1, x18
	umulh	x18, x1, x18
	str	 x2, [x0]
	adds	 x15, x15, x19
	adcs	x1, x7, x6
	adcs	x2, x5, x4
	ldr	x4, [sp, #16]           // 8-byte Folded Reload
	adcs	x4, x4, xzr
	adds	 x15, x20, x15
	str	x15, [x0, #8]
	adcs	x15, x23, x1
	adcs	x1, x22, x2
	adcs	x2, x21, x4
	adcs	x4, xzr, xzr
	adds	 x15, x15, x16
	adcs	x16, x1, x26
	adcs	x1, x2, x25
	adcs	x2, x4, x24
	adds	 x15, x15, x27
	str	x15, [x0, #16]
	adcs	x15, x16, x30
	adcs	x16, x1, x29
	adcs	x1, x2, x28
	adcs	x2, xzr, xzr
	adds	 x14, x15, x14
	adcs	x15, x16, x3
	ldr	x16, [sp, #8]           // 8-byte Folded Reload
	adcs	x16, x1, x16
	ldr	x1, [sp, #24]           // 8-byte Folded Reload
	adcs	x1, x2, x1
	adds	 x14, x14, x17
	str	x14, [x0, #24]
	adcs	x10, x15, x10
	adcs	x9, x16, x9
	adcs	x8, x1, x8
	adcs	x14, xzr, xzr
	adds	 x10, x10, x12
	adcs	x9, x9, x11
	stp	x10, x9, [x0, #32]
	adcs	x8, x8, x13
	str	x8, [x0, #48]
	adcs	x8, x14, x18
	str	x8, [x0, #56]
	add	sp, sp, #32             // =32
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end51:
	.size	mcl_fpDbl_mulPre4L, .Lfunc_end51-mcl_fpDbl_mulPre4L

	.globl	mcl_fpDbl_sqrPre4L
	.align	2
	.type	mcl_fpDbl_sqrPre4L,@function
mcl_fpDbl_sqrPre4L:                     // @mcl_fpDbl_sqrPre4L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	 x10, x13, [x1]
	ldp	x11, x12, [x1, #16]
	ldr	x14, [x1, #16]
	mul	 x15, x10, x10
	umulh	x16, x12, x10
	mul	 x17, x12, x10
	umulh	x18, x14, x10
	mul	 x2, x14, x10
	umulh	x3, x9, x10
	mul	 x4, x9, x10
	umulh	x10, x10, x10
	str	 x15, [x0]
	adds	 x10, x10, x4
	adcs	x15, x3, x2
	adcs	x17, x18, x17
	adcs	x16, x16, xzr
	adds	 x10, x10, x4
	mul	 x4, x12, x9
	str	x10, [x0, #8]
	mul	 x10, x9, x9
	adcs	x10, x15, x10
	mul	 x15, x14, x9
	adcs	x17, x17, x15
	adcs	x16, x16, x4
	adcs	x4, xzr, xzr
	adds	 x10, x10, x3
	umulh	x3, x9, x9
	adcs	x17, x17, x3
	umulh	x3, x12, x9
	umulh	x9, x14, x9
	adcs	x16, x16, x9
	adcs	x3, x4, x3
	ldr	x1, [x1, #24]
	adds	 x10, x10, x2
	mul	 x2, x12, x14
	str	x10, [x0, #16]
	mul	 x10, x14, x14
	umulh	x12, x12, x14
	umulh	x14, x14, x14
	adcs	x15, x17, x15
	mul	 x17, x8, x1
	adcs	x10, x16, x10
	mul	 x16, x11, x1
	adcs	x2, x3, x2
	adcs	x3, xzr, xzr
	adds	 x15, x15, x18
	mul	 x18, x13, x1
	adcs	x9, x10, x9
	mul	 x10, x1, x1
	umulh	x8, x8, x1
	umulh	x13, x13, x1
	umulh	x11, x11, x1
	umulh	x1, x1, x1
	adcs	x14, x2, x14
	adcs	x12, x3, x12
	adds	 x15, x15, x17
	adcs	x9, x9, x18
	adcs	x14, x14, x16
	adcs	x10, x12, x10
	adcs	x12, xzr, xzr
	adds	 x8, x9, x8
	stp	x15, x8, [x0, #24]
	adcs	x8, x14, x13
	str	x8, [x0, #40]
	adcs	x8, x10, x11
	str	x8, [x0, #48]
	adcs	x8, x12, x1
	str	x8, [x0, #56]
	ret
.Lfunc_end52:
	.size	mcl_fpDbl_sqrPre4L, .Lfunc_end52-mcl_fpDbl_sqrPre4L

	.globl	mcl_fp_mont4L
	.align	2
	.type	mcl_fp_mont4L,@function
mcl_fp_mont4L:                          // @mcl_fp_mont4L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #16             // =16
	str	x0, [sp, #8]            // 8-byte Folded Spill
	ldp	x13, x16, [x1, #16]
	ldp	 x14, x15, [x1]
	ldur	x0, [x3, #-8]
	ldp	x9, x8, [x3, #16]
	ldp	 x11, x10, [x3]
	ldp	 x17, x18, [x2]
	ldp	x1, x2, [x2, #16]
	umulh	x3, x16, x17
	mul	 x4, x16, x17
	umulh	x5, x13, x17
	mul	 x6, x13, x17
	umulh	x7, x15, x17
	mul	 x19, x15, x17
	umulh	x20, x14, x17
	mul	 x17, x14, x17
	umulh	x21, x18, x16
	mul	 x22, x18, x16
	umulh	x23, x18, x13
	mul	 x24, x18, x13
	umulh	x25, x18, x15
	mul	 x26, x18, x15
	umulh	x27, x18, x14
	mul	 x18, x18, x14
	umulh	x28, x1, x16
	adds	 x19, x20, x19
	mul	 x20, x17, x0
	adcs	x6, x7, x6
	mul	 x7, x20, x8
	mul	 x29, x20, x9
	mul	 x30, x20, x10
	adcs	x4, x5, x4
	umulh	x5, x20, x11
	adcs	x3, x3, xzr
	adds	 x5, x5, x30
	umulh	x30, x20, x10
	adcs	x29, x30, x29
	umulh	x30, x20, x9
	adcs	x7, x30, x7
	umulh	x30, x20, x8
	mul	 x20, x20, x11
	adcs	x30, x30, xzr
	cmn	 x20, x17
	mul	 x17, x1, x16
	umulh	x20, x1, x13
	adcs	x5, x5, x19
	mul	 x19, x1, x13
	adcs	x6, x29, x6
	umulh	x29, x1, x15
	adcs	x4, x7, x4
	mul	 x7, x1, x15
	adcs	x3, x30, x3
	adcs	x30, xzr, xzr
	adds	 x26, x27, x26
	umulh	x27, x1, x14
	mul	 x1, x1, x14
	adcs	x24, x25, x24
	umulh	x25, x2, x16
	mul	 x16, x2, x16
	adcs	x22, x23, x22
	adcs	x21, x21, xzr
	adds	 x18, x5, x18
	adcs	x5, x6, x26
	mul	 x6, x18, x0
	adcs	x4, x4, x24
	mul	 x23, x6, x8
	mul	 x24, x6, x9
	mul	 x26, x6, x10
	adcs	x3, x3, x22
	umulh	x22, x6, x11
	adcs	x21, x30, x21
	adcs	x30, xzr, xzr
	adds	 x22, x22, x26
	umulh	x26, x6, x10
	adcs	x24, x26, x24
	umulh	x26, x6, x9
	adcs	x23, x26, x23
	umulh	x26, x6, x8
	mul	 x6, x6, x11
	adcs	x26, x26, xzr
	cmn	 x6, x18
	umulh	x18, x2, x13
	mul	 x13, x2, x13
	umulh	x6, x2, x15
	mul	 x15, x2, x15
	umulh	x12, x2, x14
	mul	 x14, x2, x14
	adcs	x2, x22, x5
	adcs	x4, x24, x4
	adcs	x3, x23, x3
	adcs	x5, x26, x21
	adcs	x21, x30, xzr
	adds	 x7, x27, x7
	adcs	x19, x29, x19
	adcs	x17, x20, x17
	adcs	x20, x28, xzr
	adds	 x1, x2, x1
	adcs	x2, x4, x7
	mul	 x4, x1, x0
	adcs	x3, x3, x19
	mul	 x7, x4, x8
	mul	 x19, x4, x9
	mul	 x22, x4, x10
	adcs	x17, x5, x17
	umulh	x5, x4, x11
	adcs	x20, x21, x20
	adcs	x21, xzr, xzr
	adds	 x5, x5, x22
	umulh	x22, x4, x10
	adcs	x19, x22, x19
	umulh	x22, x4, x9
	adcs	x7, x22, x7
	umulh	x22, x4, x8
	mul	 x4, x4, x11
	adcs	x22, x22, xzr
	cmn	 x4, x1
	adcs	x1, x5, x2
	adcs	x2, x19, x3
	adcs	x17, x7, x17
	adcs	x3, x22, x20
	adcs	x4, x21, xzr
	adds	 x12, x12, x15
	adcs	x13, x6, x13
	adcs	x15, x18, x16
	adcs	x16, x25, xzr
	adds	 x14, x1, x14
	adcs	x12, x2, x12
	mul	 x18, x14, x0
	adcs	x13, x17, x13
	umulh	x17, x18, x8
	mul	 x0, x18, x8
	umulh	x1, x18, x9
	mul	 x2, x18, x9
	umulh	x5, x18, x10
	mul	 x6, x18, x10
	umulh	x7, x18, x11
	mul	 x18, x18, x11
	adcs	x15, x3, x15
	adcs	x16, x4, x16
	adcs	x3, xzr, xzr
	adds	 x4, x7, x6
	adcs	x2, x5, x2
	adcs	x0, x1, x0
	adcs	x17, x17, xzr
	cmn	 x18, x14
	adcs	x12, x4, x12
	adcs	x13, x2, x13
	adcs	x14, x0, x15
	adcs	x15, x17, x16
	adcs	x16, x3, xzr
	subs	 x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	sbcs	x16, x16, xzr
	tst	 x16, #0x1
	csel	x11, x12, x11, ne
	csel	x10, x13, x10, ne
	csel	x9, x14, x9, ne
	csel	x8, x15, x8, ne
	ldr	x12, [sp, #8]           // 8-byte Folded Reload
	stp	 x11, x10, [x12]
	stp	x9, x8, [x12, #16]
	add	sp, sp, #16             // =16
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end53:
	.size	mcl_fp_mont4L, .Lfunc_end53-mcl_fp_mont4L

	.globl	mcl_fp_montNF4L
	.align	2
	.type	mcl_fp_montNF4L,@function
mcl_fp_montNF4L:                        // @mcl_fp_montNF4L
// BB#0:
	stp	x28, x27, [sp, #-80]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	ldp	x14, x15, [x1, #16]
	ldp	 x13, x16, [x1]
	ldur	x12, [x3, #-8]
	ldp	x9, x8, [x3, #16]
	ldp	 x11, x10, [x3]
	ldp	 x17, x18, [x2]
	ldp	x1, x2, [x2, #16]
	umulh	x3, x15, x17
	mul	 x4, x15, x17
	umulh	x5, x14, x17
	mul	 x6, x14, x17
	umulh	x7, x16, x17
	mul	 x19, x16, x17
	umulh	x20, x13, x17
	mul	 x17, x13, x17
	umulh	x21, x18, x15
	mul	 x22, x18, x15
	umulh	x23, x18, x14
	mul	 x24, x18, x14
	umulh	x25, x18, x16
	mul	 x26, x18, x16
	umulh	x27, x18, x13
	mul	 x18, x18, x13
	adds	 x19, x20, x19
	umulh	x20, x1, x15
	adcs	x6, x7, x6
	mul	 x7, x17, x12
	adcs	x4, x5, x4
	mul	 x5, x7, x11
	adcs	x3, x3, xzr
	cmn	 x5, x17
	mul	 x17, x1, x15
	mul	 x5, x7, x10
	adcs	x5, x5, x19
	mul	 x19, x7, x9
	adcs	x6, x19, x6
	mul	 x19, x7, x8
	adcs	x4, x19, x4
	umulh	x19, x7, x11
	adcs	x3, x3, xzr
	adds	 x5, x5, x19
	umulh	x19, x7, x10
	adcs	x6, x6, x19
	umulh	x19, x7, x9
	adcs	x4, x4, x19
	umulh	x19, x1, x14
	umulh	x7, x7, x8
	adcs	x3, x3, x7
	mul	 x7, x1, x14
	adds	 x26, x27, x26
	umulh	x27, x1, x16
	adcs	x24, x25, x24
	mul	 x25, x1, x16
	adcs	x22, x23, x22
	umulh	x23, x1, x13
	mul	 x1, x1, x13
	adcs	x21, x21, xzr
	adds	 x18, x18, x5
	umulh	x5, x2, x15
	mul	 x15, x2, x15
	adcs	x6, x26, x6
	umulh	x26, x2, x14
	mul	 x14, x2, x14
	adcs	x4, x24, x4
	mul	 x24, x18, x12
	adcs	x3, x22, x3
	mul	 x22, x24, x11
	adcs	x21, x21, xzr
	cmn	 x22, x18
	umulh	x18, x2, x16
	mul	 x16, x2, x16
	umulh	x22, x2, x13
	mul	 x13, x2, x13
	mul	 x2, x24, x10
	adcs	x2, x2, x6
	mul	 x6, x24, x9
	adcs	x4, x6, x4
	mul	 x6, x24, x8
	adcs	x3, x6, x3
	umulh	x6, x24, x11
	adcs	x21, x21, xzr
	adds	 x2, x2, x6
	umulh	x6, x24, x10
	adcs	x4, x4, x6
	umulh	x6, x24, x9
	adcs	x3, x3, x6
	umulh	x6, x24, x8
	adcs	x6, x21, x6
	adds	 x21, x23, x25
	adcs	x7, x27, x7
	adcs	x17, x19, x17
	adcs	x19, x20, xzr
	adds	 x1, x1, x2
	adcs	x2, x21, x4
	mul	 x4, x1, x12
	adcs	x3, x7, x3
	mul	 x7, x4, x8
	mul	 x20, x4, x9
	adcs	x17, x17, x6
	mul	 x6, x4, x11
	adcs	x19, x19, xzr
	cmn	 x6, x1
	mul	 x1, x4, x10
	umulh	x6, x4, x8
	adcs	x1, x1, x2
	umulh	x2, x4, x9
	adcs	x3, x20, x3
	umulh	x20, x4, x10
	umulh	x4, x4, x11
	adcs	x17, x7, x17
	adcs	x7, x19, xzr
	adds	 x1, x1, x4
	adcs	x3, x3, x20
	adcs	x17, x17, x2
	adcs	x2, x7, x6
	adds	 x16, x22, x16
	adcs	x14, x18, x14
	adcs	x15, x26, x15
	adcs	x18, x5, xzr
	adds	 x13, x13, x1
	adcs	x16, x16, x3
	mul	 x12, x13, x12
	adcs	x14, x14, x17
	mul	 x17, x12, x8
	mul	 x1, x12, x9
	mul	 x3, x12, x10
	mul	 x4, x12, x11
	umulh	x5, x12, x8
	umulh	x6, x12, x9
	umulh	x7, x12, x10
	umulh	x12, x12, x11
	adcs	x15, x15, x2
	adcs	x18, x18, xzr
	cmn	 x4, x13
	adcs	x13, x3, x16
	adcs	x14, x1, x14
	adcs	x15, x17, x15
	adcs	x16, x18, xzr
	adds	 x12, x13, x12
	adcs	x13, x14, x7
	adcs	x14, x15, x6
	adcs	x15, x16, x5
	subs	 x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	cmp	 x8, #0                 // =0
	csel	x11, x12, x11, lt
	csel	x10, x13, x10, lt
	csel	x9, x14, x9, lt
	csel	x8, x15, x8, lt
	stp	 x11, x10, [x0]
	stp	x9, x8, [x0, #16]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #80
	ret
.Lfunc_end54:
	.size	mcl_fp_montNF4L, .Lfunc_end54-mcl_fp_montNF4L

	.globl	mcl_fp_montRed4L
	.align	2
	.type	mcl_fp_montRed4L,@function
mcl_fp_montRed4L:                       // @mcl_fp_montRed4L
// BB#0:
	stp	x22, x21, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	ldur	x12, [x2, #-8]
	ldp	x9, x8, [x2, #16]
	ldp	 x11, x10, [x2]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #32]
	ldp	x18, x2, [x1, #16]
	ldp	 x13, x1, [x1]
	mul	 x3, x13, x12
	umulh	x4, x3, x8
	mul	 x5, x3, x8
	umulh	x6, x3, x9
	mul	 x7, x3, x9
	umulh	x19, x3, x10
	mul	 x20, x3, x10
	umulh	x21, x3, x11
	mul	 x3, x3, x11
	adds	 x20, x21, x20
	adcs	x7, x19, x7
	adcs	x5, x6, x5
	adcs	x4, x4, xzr
	cmn	 x13, x3
	adcs	x13, x1, x20
	adcs	x18, x18, x7
	mul	 x1, x13, x12
	adcs	x2, x2, x5
	umulh	x3, x1, x8
	mul	 x5, x1, x8
	umulh	x6, x1, x9
	mul	 x7, x1, x9
	umulh	x19, x1, x10
	mul	 x20, x1, x10
	umulh	x21, x1, x11
	mul	 x1, x1, x11
	adcs	x16, x16, x4
	adcs	x17, x17, xzr
	adcs	x14, x14, xzr
	adcs	x15, x15, xzr
	adcs	x4, xzr, xzr
	adds	 x20, x21, x20
	adcs	x7, x19, x7
	adcs	x5, x6, x5
	adcs	x3, x3, xzr
	cmn	 x1, x13
	adcs	x13, x20, x18
	adcs	x18, x7, x2
	mul	 x1, x13, x12
	adcs	x16, x5, x16
	umulh	x2, x1, x8
	mul	 x5, x1, x8
	umulh	x6, x1, x9
	mul	 x7, x1, x9
	umulh	x19, x1, x10
	mul	 x20, x1, x10
	umulh	x21, x1, x11
	mul	 x1, x1, x11
	adcs	x17, x3, x17
	adcs	x14, x14, xzr
	adcs	x15, x15, xzr
	adcs	x3, x4, xzr
	adds	 x4, x21, x20
	adcs	x7, x19, x7
	adcs	x5, x6, x5
	adcs	x2, x2, xzr
	cmn	 x1, x13
	adcs	x13, x4, x18
	adcs	x16, x7, x16
	mul	 x12, x13, x12
	adcs	x17, x5, x17
	umulh	x18, x12, x8
	mul	 x1, x12, x8
	umulh	x4, x12, x9
	mul	 x5, x12, x9
	umulh	x6, x12, x10
	mul	 x7, x12, x10
	umulh	x19, x12, x11
	mul	 x12, x12, x11
	adcs	x14, x2, x14
	adcs	x15, x15, xzr
	adcs	x2, x3, xzr
	adds	 x3, x19, x7
	adcs	x5, x6, x5
	adcs	x1, x4, x1
	adcs	x18, x18, xzr
	cmn	 x12, x13
	adcs	x12, x3, x16
	adcs	x13, x5, x17
	adcs	x14, x1, x14
	adcs	x15, x18, x15
	adcs	x16, x2, xzr
	subs	 x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	sbcs	x16, x16, xzr
	tst	 x16, #0x1
	csel	x11, x12, x11, ne
	csel	x10, x13, x10, ne
	csel	x9, x14, x9, ne
	csel	x8, x15, x8, ne
	stp	 x11, x10, [x0]
	stp	x9, x8, [x0, #16]
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #32
	ret
.Lfunc_end55:
	.size	mcl_fp_montRed4L, .Lfunc_end55-mcl_fp_montRed4L

	.globl	mcl_fp_addPre4L
	.align	2
	.type	mcl_fp_addPre4L,@function
mcl_fp_addPre4L:                        // @mcl_fp_addPre4L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x11, [x2]
	ldp	 x12, x13, [x1]
	ldp	x14, x15, [x1, #16]
	adds	 x10, x10, x12
	str	 x10, [x0]
	adcs	x10, x11, x13
	adcs	x8, x8, x14
	stp	x10, x8, [x0, #8]
	adcs	x9, x9, x15
	adcs	x8, xzr, xzr
	str	x9, [x0, #24]
	mov	 x0, x8
	ret
.Lfunc_end56:
	.size	mcl_fp_addPre4L, .Lfunc_end56-mcl_fp_addPre4L

	.globl	mcl_fp_subPre4L
	.align	2
	.type	mcl_fp_subPre4L,@function
mcl_fp_subPre4L:                        // @mcl_fp_subPre4L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x11, [x2]
	ldp	 x12, x13, [x1]
	ldp	x14, x15, [x1, #16]
	subs	 x10, x12, x10
	str	 x10, [x0]
	sbcs	x10, x13, x11
	sbcs	x8, x14, x8
	stp	x10, x8, [x0, #8]
	sbcs	x9, x15, x9
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0, #24]
	mov	 x0, x8
	ret
.Lfunc_end57:
	.size	mcl_fp_subPre4L, .Lfunc_end57-mcl_fp_subPre4L

	.globl	mcl_fp_shr1_4L
	.align	2
	.type	mcl_fp_shr1_4L,@function
mcl_fp_shr1_4L:                         // @mcl_fp_shr1_4L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	extr	x8, x9, x8, #1
	extr	x9, x10, x9, #1
	extr	x10, x11, x10, #1
	lsr	x11, x11, #1
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	ret
.Lfunc_end58:
	.size	mcl_fp_shr1_4L, .Lfunc_end58-mcl_fp_shr1_4L

	.globl	mcl_fp_add4L
	.align	2
	.type	mcl_fp_add4L,@function
mcl_fp_add4L:                           // @mcl_fp_add4L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x11, [x2]
	ldp	 x12, x13, [x1]
	ldp	x14, x15, [x1, #16]
	adds	 x10, x10, x12
	adcs	x12, x11, x13
	ldp	 x11, x13, [x3]
	stp	 x10, x12, [x0]
	adcs	x8, x8, x14
	adcs	x14, x9, x15
	stp	x8, x14, [x0, #16]
	adcs	x15, xzr, xzr
	ldp	x9, x16, [x3, #16]
	subs	 x11, x10, x11
	sbcs	x10, x12, x13
	sbcs	x9, x8, x9
	sbcs	x8, x14, x16
	sbcs	x12, x15, xzr
	and	w12, w12, #0x1
	tbnz	w12, #0, .LBB59_2
// BB#1:                                // %nocarry
	stp	 x11, x10, [x0]
	stp	x9, x8, [x0, #16]
.LBB59_2:                               // %carry
	ret
.Lfunc_end59:
	.size	mcl_fp_add4L, .Lfunc_end59-mcl_fp_add4L

	.globl	mcl_fp_addNF4L
	.align	2
	.type	mcl_fp_addNF4L,@function
mcl_fp_addNF4L:                         // @mcl_fp_addNF4L
// BB#0:
	ldp	x8, x9, [x1, #16]
	ldp	 x10, x11, [x1]
	ldp	 x12, x13, [x2]
	ldp	x14, x15, [x2, #16]
	adds	 x10, x12, x10
	adcs	x11, x13, x11
	ldp	 x12, x13, [x3]
	adcs	x8, x14, x8
	ldp	x14, x16, [x3, #16]
	adcs	x9, x15, x9
	subs	 x12, x10, x12
	sbcs	x13, x11, x13
	sbcs	x14, x8, x14
	sbcs	x15, x9, x16
	cmp	 x15, #0                // =0
	csel	x10, x10, x12, lt
	csel	x11, x11, x13, lt
	csel	x8, x8, x14, lt
	csel	x9, x9, x15, lt
	stp	 x10, x11, [x0]
	stp	x8, x9, [x0, #16]
	ret
.Lfunc_end60:
	.size	mcl_fp_addNF4L, .Lfunc_end60-mcl_fp_addNF4L

	.globl	mcl_fp_sub4L
	.align	2
	.type	mcl_fp_sub4L,@function
mcl_fp_sub4L:                           // @mcl_fp_sub4L
// BB#0:
	ldp	x10, x11, [x2, #16]
	ldp	 x8, x9, [x2]
	ldp	 x12, x13, [x1]
	ldp	x14, x15, [x1, #16]
	subs	 x8, x12, x8
	sbcs	x9, x13, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x14, x10
	sbcs	x11, x15, x11
	stp	x10, x11, [x0, #16]
	ngcs	 x12, xzr
	and	w12, w12, #0x1
	tbnz	w12, #0, .LBB61_2
// BB#1:                                // %nocarry
	ret
.LBB61_2:                               // %carry
	ldp	x12, x13, [x3, #16]
	ldp	 x14, x15, [x3]
	adds	 x8, x14, x8
	adcs	x9, x15, x9
	adcs	x10, x12, x10
	adcs	x11, x13, x11
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	ret
.Lfunc_end61:
	.size	mcl_fp_sub4L, .Lfunc_end61-mcl_fp_sub4L

	.globl	mcl_fp_subNF4L
	.align	2
	.type	mcl_fp_subNF4L,@function
mcl_fp_subNF4L:                         // @mcl_fp_subNF4L
// BB#0:
	ldp	x8, x9, [x2, #16]
	ldp	 x10, x11, [x2]
	ldp	 x12, x13, [x1]
	ldp	x14, x15, [x1, #16]
	subs	 x10, x12, x10
	sbcs	x11, x13, x11
	ldp	x12, x13, [x3, #16]
	sbcs	x8, x14, x8
	ldp	 x14, x16, [x3]
	sbcs	x9, x15, x9
	asr	x15, x9, #63
	and	 x14, x15, x14
	and	 x16, x15, x16
	and	 x12, x15, x12
	and	 x13, x15, x13
	adds	 x10, x14, x10
	str	 x10, [x0]
	adcs	x10, x16, x11
	adcs	x8, x12, x8
	stp	x10, x8, [x0, #8]
	adcs	x8, x13, x9
	str	x8, [x0, #24]
	ret
.Lfunc_end62:
	.size	mcl_fp_subNF4L, .Lfunc_end62-mcl_fp_subNF4L

	.globl	mcl_fpDbl_add4L
	.align	2
	.type	mcl_fpDbl_add4L,@function
mcl_fpDbl_add4L:                        // @mcl_fpDbl_add4L
// BB#0:
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x4, x2, [x2]
	ldp	x5, x6, [x1, #16]
	ldp	 x18, x1, [x1]
	adds	 x18, x4, x18
	str	 x18, [x0]
	ldp	x18, x4, [x3, #16]
	adcs	x1, x2, x1
	ldp	 x2, x3, [x3]
	adcs	x16, x16, x5
	stp	x1, x16, [x0, #8]
	adcs	x16, x17, x6
	str	x16, [x0, #24]
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	adcs	x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, xzr, xzr
	subs	 x11, x12, x2
	sbcs	x14, x13, x3
	sbcs	x15, x8, x18
	sbcs	x16, x9, x4
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x10, x12, x11, ne
	csel	x11, x13, x14, ne
	csel	x8, x8, x15, ne
	csel	x9, x9, x16, ne
	stp	x10, x11, [x0, #32]
	stp	x8, x9, [x0, #48]
	ret
.Lfunc_end63:
	.size	mcl_fpDbl_add4L, .Lfunc_end63-mcl_fpDbl_add4L

	.globl	mcl_fpDbl_sub4L
	.align	2
	.type	mcl_fpDbl_sub4L,@function
mcl_fpDbl_sub4L:                        // @mcl_fpDbl_sub4L
// BB#0:
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x18, x2, [x2]
	ldp	x5, x6, [x1, #16]
	ldp	 x4, x1, [x1]
	subs	 x18, x4, x18
	str	 x18, [x0]
	ldp	x18, x4, [x3, #16]
	sbcs	x1, x1, x2
	ldp	 x2, x3, [x3]
	sbcs	x16, x5, x16
	stp	x1, x16, [x0, #8]
	sbcs	x16, x6, x17
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	sbcs	x8, x10, x8
	sbcs	x9, x11, x9
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x4, xzr, ne
	csel	x11, x18, xzr, ne
	csel	x14, x3, xzr, ne
	csel	x15, x2, xzr, ne
	adds	 x12, x15, x12
	stp	x16, x12, [x0, #24]
	adcs	x12, x14, x13
	adcs	x8, x11, x8
	stp	x12, x8, [x0, #40]
	adcs	x8, x10, x9
	str	x8, [x0, #56]
	ret
.Lfunc_end64:
	.size	mcl_fpDbl_sub4L, .Lfunc_end64-mcl_fpDbl_sub4L

	.globl	mcl_fp_mulUnitPre5L
	.align	2
	.type	mcl_fp_mulUnitPre5L,@function
mcl_fp_mulUnitPre5L:                    // @mcl_fp_mulUnitPre5L
// BB#0:
	ldp	x12, x8, [x1, #24]
	ldp	 x9, x10, [x1]
	ldr	x11, [x1, #16]
	mul	 x13, x9, x2
	mul	 x14, x10, x2
	umulh	x9, x9, x2
	mul	 x15, x11, x2
	umulh	x10, x10, x2
	mul	 x16, x12, x2
	umulh	x11, x11, x2
	mul	 x17, x8, x2
	umulh	x12, x12, x2
	umulh	x8, x8, x2
	adds	 x9, x9, x14
	stp	 x13, x9, [x0]
	adcs	x9, x10, x15
	str	x9, [x0, #16]
	adcs	x9, x11, x16
	str	x9, [x0, #24]
	adcs	x9, x12, x17
	adcs	x8, x8, xzr
	stp	x9, x8, [x0, #32]
	ret
.Lfunc_end65:
	.size	mcl_fp_mulUnitPre5L, .Lfunc_end65-mcl_fp_mulUnitPre5L

	.globl	mcl_fpDbl_mulPre5L
	.align	2
	.type	mcl_fpDbl_mulPre5L,@function
mcl_fpDbl_mulPre5L:                     // @mcl_fpDbl_mulPre5L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #176            // =176
	ldp	 x8, x10, [x1]
	ldp	 x9, x15, [x1]
	ldp	x11, x12, [x1, #24]
	ldp	 x13, x14, [x2]
	ldp	x16, x18, [x1, #16]
	ldr	x17, [x1, #16]
	ldr	x3, [x1, #32]
	ldp	x4, x5, [x2, #16]
	mul	 x6, x8, x13
	str	x6, [sp, #72]           // 8-byte Folded Spill
	umulh	x6, x12, x13
	str	x6, [sp, #168]          // 8-byte Folded Spill
	mul	 x6, x12, x13
	str	x6, [sp, #152]          // 8-byte Folded Spill
	umulh	x6, x11, x13
	str	x6, [sp, #112]          // 8-byte Folded Spill
	mul	 x6, x11, x13
	str	x6, [sp, #64]           // 8-byte Folded Spill
	umulh	x6, x17, x13
	mul	 x23, x17, x13
	umulh	x24, x10, x13
	mul	 x25, x10, x13
	umulh	x7, x8, x13
	mul	 x26, x8, x14
	mul	 x13, x12, x14
	str	x13, [sp, #104]         // 8-byte Folded Spill
	mul	 x13, x11, x14
	stp	x13, x6, [sp, #40]
	mul	 x29, x17, x14
	mul	 x30, x10, x14
	umulh	x12, x12, x14
	umulh	x11, x11, x14
	str	x11, [sp, #96]          // 8-byte Folded Spill
	umulh	x11, x17, x14
	umulh	x27, x10, x14
	umulh	x20, x8, x14
	mul	 x8, x9, x4
	stp	x8, x11, [sp, #24]
	mul	 x8, x3, x4
	stp	x8, x12, [sp, #136]
	mul	 x8, x18, x4
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x8, x16, x4
	str	x8, [sp, #16]           // 8-byte Folded Spill
	mul	 x28, x15, x4
	umulh	x8, x3, x4
	str	x8, [sp, #160]          // 8-byte Folded Spill
	umulh	x8, x18, x4
	str	x8, [sp, #128]          // 8-byte Folded Spill
	umulh	x8, x16, x4
	str	x8, [sp, #80]           // 8-byte Folded Spill
	umulh	x8, x15, x4
	str	x8, [sp, #8]            // 8-byte Folded Spill
	umulh	x22, x9, x4
	mul	 x8, x3, x5
	str	x8, [sp, #120]          // 8-byte Folded Spill
	umulh	x8, x3, x5
	str	x8, [sp, #56]           // 8-byte Folded Spill
	mul	 x6, x18, x5
	umulh	x21, x18, x5
	mul	 x3, x16, x5
	umulh	x19, x16, x5
	mul	 x17, x15, x5
	umulh	x4, x15, x5
	mul	 x16, x9, x5
	umulh	x18, x9, x5
	ldr	x2, [x2, #32]
	ldp	x10, x5, [x1, #16]
	ldp	 x8, x9, [x1]
	ldr	x1, [x1, #32]
	mul	 x15, x8, x2
	umulh	x14, x8, x2
	mul	 x12, x9, x2
	umulh	x13, x9, x2
	mul	 x11, x10, x2
	umulh	x10, x10, x2
	mul	 x9, x5, x2
	umulh	x5, x5, x2
	mul	 x8, x1, x2
	umulh	x1, x1, x2
	ldr	x2, [sp, #72]           // 8-byte Folded Reload
	str	 x2, [x0]
	adds	 x2, x7, x25
	adcs	x7, x24, x23
	ldr	x23, [sp, #64]          // 8-byte Folded Reload
	ldr	x24, [sp, #48]          // 8-byte Folded Reload
	adcs	x23, x24, x23
	ldr	x24, [sp, #152]         // 8-byte Folded Reload
	ldr	x25, [sp, #112]         // 8-byte Folded Reload
	adcs	x24, x25, x24
	ldr	x25, [sp, #168]         // 8-byte Folded Reload
	adcs	x25, x25, xzr
	adds	 x2, x26, x2
	str	x2, [x0, #8]
	adcs	x2, x30, x7
	adcs	x7, x29, x23
	ldr	x23, [sp, #40]          // 8-byte Folded Reload
	adcs	x23, x23, x24
	ldr	x24, [sp, #104]         // 8-byte Folded Reload
	adcs	x24, x24, x25
	adcs	x25, xzr, xzr
	adds	 x2, x2, x20
	adcs	x7, x7, x27
	ldr	x20, [sp, #32]          // 8-byte Folded Reload
	adcs	x20, x23, x20
	ldr	x23, [sp, #96]          // 8-byte Folded Reload
	adcs	x23, x24, x23
	ldr	x24, [sp, #144]         // 8-byte Folded Reload
	adcs	x24, x25, x24
	ldr	x25, [sp, #24]          // 8-byte Folded Reload
	adds	 x2, x25, x2
	str	x2, [x0, #16]
	adcs	x2, x28, x7
	ldr	x7, [sp, #16]           // 8-byte Folded Reload
	adcs	x7, x7, x20
	ldr	x20, [sp, #88]          // 8-byte Folded Reload
	adcs	x20, x20, x23
	ldr	x23, [sp, #136]         // 8-byte Folded Reload
	adcs	x23, x23, x24
	adcs	x24, xzr, xzr
	adds	 x2, x2, x22
	ldr	x22, [sp, #8]           // 8-byte Folded Reload
	adcs	x7, x7, x22
	ldr	x22, [sp, #80]          // 8-byte Folded Reload
	adcs	x20, x20, x22
	ldr	x22, [sp, #128]         // 8-byte Folded Reload
	adcs	x22, x23, x22
	ldr	x23, [sp, #160]         // 8-byte Folded Reload
	adcs	x23, x24, x23
	adds	 x16, x16, x2
	str	x16, [x0, #24]
	adcs	x16, x17, x7
	adcs	x17, x3, x20
	adcs	x2, x6, x22
	ldr	x3, [sp, #120]          // 8-byte Folded Reload
	adcs	x3, x3, x23
	adcs	x6, xzr, xzr
	adds	 x16, x16, x18
	adcs	x17, x17, x4
	adcs	x18, x2, x19
	adcs	x2, x3, x21
	ldr	x3, [sp, #56]           // 8-byte Folded Reload
	adcs	x3, x6, x3
	adds	 x15, x15, x16
	str	x15, [x0, #32]
	adcs	x12, x12, x17
	adcs	x11, x11, x18
	adcs	x9, x9, x2
	adcs	x8, x8, x3
	adcs	x15, xzr, xzr
	adds	 x12, x12, x14
	adcs	x11, x11, x13
	stp	x12, x11, [x0, #40]
	adcs	x9, x9, x10
	adcs	x8, x8, x5
	stp	x9, x8, [x0, #56]
	adcs	x8, x15, x1
	str	x8, [x0, #72]
	add	sp, sp, #176            // =176
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end66:
	.size	mcl_fpDbl_mulPre5L, .Lfunc_end66-mcl_fpDbl_mulPre5L

	.globl	mcl_fpDbl_sqrPre5L
	.align	2
	.type	mcl_fpDbl_sqrPre5L,@function
mcl_fpDbl_sqrPre5L:                     // @mcl_fpDbl_sqrPre5L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	 x12, x15, [x1]
	ldp	x13, x14, [x1, #24]
	ldr	x16, [x1, #16]
	mul	 x17, x12, x12
	mul	 x18, x14, x12
	mul	 x2, x11, x12
	umulh	x3, x16, x12
	mul	 x4, x16, x12
	umulh	x5, x9, x12
	mul	 x6, x9, x12
	str	 x17, [x0]
	umulh	x17, x12, x12
	adds	 x17, x17, x6
	adcs	x4, x5, x4
	adcs	x2, x3, x2
	umulh	x3, x11, x12
	adcs	x18, x3, x18
	umulh	x12, x14, x12
	adcs	x12, x12, xzr
	adds	 x17, x6, x17
	ldr	 x3, [x1]
	str	x17, [x0, #8]
	mul	 x17, x9, x9
	adcs	x17, x17, x4
	mul	 x4, x16, x9
	adcs	x2, x4, x2
	mul	 x4, x11, x9
	adcs	x18, x4, x18
	mul	 x4, x14, x9
	adcs	x12, x4, x12
	adcs	x4, xzr, xzr
	adds	 x17, x17, x5
	umulh	x5, x9, x9
	adcs	x2, x2, x5
	umulh	x5, x16, x9
	adcs	x18, x18, x5
	ldr	x5, [x1, #8]
	umulh	x11, x11, x9
	adcs	x11, x12, x11
	ldr	x12, [x1, #24]
	umulh	x9, x14, x9
	adcs	x9, x4, x9
	mul	 x4, x3, x16
	adds	 x17, x4, x17
	mul	 x4, x14, x16
	str	x17, [x0, #16]
	mul	 x17, x5, x16
	adcs	x17, x17, x2
	mul	 x2, x16, x16
	adcs	x18, x2, x18
	mul	 x2, x12, x16
	adcs	x11, x2, x11
	umulh	x2, x3, x16
	adcs	x9, x4, x9
	adcs	x4, xzr, xzr
	adds	 x17, x17, x2
	umulh	x2, x5, x16
	adcs	x18, x18, x2
	umulh	x2, x16, x16
	adcs	x11, x11, x2
	umulh	x14, x14, x16
	umulh	x16, x12, x16
	adcs	x9, x9, x16
	ldr	x16, [x1, #32]
	adcs	x14, x4, x14
	mul	 x1, x3, x12
	adds	 x17, x1, x17
	mul	 x1, x16, x12
	str	x17, [x0, #24]
	mul	 x17, x5, x12
	adcs	x17, x17, x18
	mul	 x18, x10, x12
	adcs	x11, x18, x11
	mul	 x18, x12, x12
	adcs	x9, x18, x9
	umulh	x18, x16, x12
	umulh	x2, x3, x12
	adcs	x14, x1, x14
	adcs	x1, xzr, xzr
	adds	 x17, x17, x2
	umulh	x2, x10, x12
	umulh	x3, x5, x12
	umulh	x12, x12, x12
	adcs	x11, x11, x3
	mul	 x3, x8, x16
	adcs	x9, x9, x2
	mul	 x2, x13, x16
	adcs	x12, x14, x12
	mul	 x14, x10, x16
	adcs	x18, x1, x18
	mul	 x1, x15, x16
	adds	 x17, x17, x3
	mul	 x3, x16, x16
	umulh	x8, x8, x16
	umulh	x15, x15, x16
	umulh	x10, x10, x16
	umulh	x13, x13, x16
	umulh	x16, x16, x16
	str	x17, [x0, #32]
	adcs	x11, x11, x1
	adcs	x9, x9, x14
	adcs	x12, x12, x2
	adcs	x14, x18, x3
	adcs	x17, xzr, xzr
	adds	 x8, x11, x8
	str	x8, [x0, #40]
	adcs	x8, x9, x15
	str	x8, [x0, #48]
	adcs	x8, x12, x10
	str	x8, [x0, #56]
	adcs	x8, x14, x13
	str	x8, [x0, #64]
	adcs	x8, x17, x16
	str	x8, [x0, #72]
	ret
.Lfunc_end67:
	.size	mcl_fpDbl_sqrPre5L, .Lfunc_end67-mcl_fpDbl_sqrPre5L

	.globl	mcl_fp_mont5L
	.align	2
	.type	mcl_fp_mont5L,@function
mcl_fp_mont5L:                          // @mcl_fp_mont5L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #80             // =80
	str	x0, [sp, #72]           // 8-byte Folded Spill
	ldp	x16, x10, [x1, #24]
	ldp	x18, x0, [x1, #8]
	ldr	 x17, [x1]
	ldur	x9, [x3, #-8]
	str	x9, [sp, #16]           // 8-byte Folded Spill
	ldp	x11, x8, [x3, #24]
	ldp	x14, x12, [x3, #8]
	ldr	 x13, [x3]
	ldp	 x3, x1, [x2]
	ldp	x4, x5, [x2, #16]
	ldr	x2, [x2, #32]
	umulh	x6, x10, x3
	mul	 x7, x10, x3
	umulh	x19, x16, x3
	mul	 x20, x16, x3
	umulh	x21, x0, x3
	mul	 x22, x0, x3
	umulh	x23, x18, x3
	mul	 x24, x18, x3
	umulh	x25, x17, x3
	mul	 x3, x17, x3
	umulh	x26, x1, x10
	mul	 x27, x1, x10
	umulh	x28, x1, x16
	adds	 x24, x25, x24
	mul	 x25, x3, x9
	adcs	x22, x23, x22
	mul	 x23, x25, x8
	mul	 x29, x25, x11
	mul	 x30, x25, x12
	adcs	x20, x21, x20
	mul	 x21, x25, x14
	adcs	x7, x19, x7
	umulh	x19, x25, x13
	adcs	x6, x6, xzr
	adds	 x19, x19, x21
	umulh	x21, x25, x14
	adcs	x21, x21, x30
	umulh	x30, x25, x12
	adcs	x29, x30, x29
	umulh	x30, x25, x11
	adcs	x23, x30, x23
	umulh	x30, x25, x8
	mul	 x25, x25, x13
	adcs	x30, x30, xzr
	cmn	 x25, x3
	mul	 x3, x1, x16
	umulh	x25, x1, x0
	adcs	x19, x19, x24
	mul	 x24, x1, x0
	adcs	x21, x21, x22
	umulh	x22, x1, x18
	adcs	x20, x29, x20
	mul	 x29, x1, x18
	adcs	x7, x23, x7
	umulh	x23, x1, x17
	mul	 x1, x1, x17
	adcs	x6, x30, x6
	adcs	x30, xzr, xzr
	adds	 x23, x23, x29
	umulh	x29, x4, x10
	adcs	x22, x22, x24
	mul	 x24, x4, x10
	adcs	x3, x25, x3
	umulh	x25, x4, x16
	adcs	x27, x28, x27
	adcs	x26, x26, xzr
	adds	 x1, x19, x1
	adcs	x19, x21, x23
	mul	 x21, x1, x9
	adcs	x20, x20, x22
	mul	 x22, x21, x8
	mul	 x23, x21, x11
	mul	 x28, x21, x12
	adcs	x3, x7, x3
	mul	 x7, x21, x14
	adcs	x6, x6, x27
	umulh	x27, x21, x13
	adcs	x26, x30, x26
	adcs	x30, xzr, xzr
	adds	 x7, x27, x7
	umulh	x27, x21, x14
	adcs	x27, x27, x28
	umulh	x28, x21, x12
	adcs	x23, x28, x23
	umulh	x28, x21, x11
	adcs	x22, x28, x22
	umulh	x28, x21, x8
	mul	 x21, x21, x13
	adcs	x28, x28, xzr
	cmn	 x21, x1
	mul	 x1, x4, x16
	umulh	x21, x4, x0
	adcs	x7, x7, x19
	mul	 x19, x4, x0
	adcs	x20, x27, x20
	umulh	x27, x4, x18
	adcs	x3, x23, x3
	mul	 x23, x4, x18
	adcs	x6, x22, x6
	umulh	x22, x4, x17
	mul	 x4, x4, x17
	adcs	x26, x28, x26
	umulh	x15, x5, x10
	str	x15, [sp, #64]          // 8-byte Folded Spill
	adcs	x30, x30, xzr
	adds	 x22, x22, x23
	mul	 x15, x5, x10
	str	x15, [sp, #56]          // 8-byte Folded Spill
	adcs	x19, x27, x19
	umulh	x15, x5, x16
	str	x15, [sp, #40]          // 8-byte Folded Spill
	adcs	x1, x21, x1
	mul	 x15, x5, x16
	str	x15, [sp, #32]          // 8-byte Folded Spill
	adcs	x24, x25, x24
	adcs	x25, x29, xzr
	adds	 x4, x7, x4
	adcs	x7, x20, x22
	mul	 x20, x4, x9
	adcs	x3, x3, x19
	mul	 x19, x20, x8
	mul	 x22, x20, x11
	mov	 x15, x12
	mul	 x29, x20, x15
	adcs	x1, x6, x1
	mov	 x21, x14
	mul	 x6, x20, x21
	adcs	x24, x26, x24
	mov	 x9, x13
	umulh	x26, x20, x9
	adcs	x25, x30, x25
	adcs	x30, xzr, xzr
	adds	 x6, x26, x6
	umulh	x26, x20, x21
	adcs	x26, x26, x29
	umulh	x29, x20, x15
	adcs	x22, x29, x22
	umulh	x29, x20, x11
	mov	 x13, x11
	adcs	x19, x29, x19
	umulh	x29, x20, x8
	mov	 x12, x8
	mul	 x20, x20, x9
	mov	 x14, x9
	adcs	x29, x29, xzr
	cmn	 x20, x4
	umulh	x4, x5, x0
	mul	 x20, x5, x0
	umulh	x11, x5, x18
	mul	 x9, x5, x18
	umulh	x8, x5, x17
	mul	 x5, x5, x17
	umulh	x23, x2, x10
	str	x23, [sp, #48]          // 8-byte Folded Spill
	mul	 x10, x2, x10
	str	x10, [sp, #24]          // 8-byte Folded Spill
	umulh	x10, x2, x16
	str	x10, [sp, #8]           // 8-byte Folded Spill
	mul	 x28, x2, x16
	umulh	x27, x2, x0
	mul	 x23, x2, x0
	umulh	x16, x2, x18
	mul	 x18, x2, x18
	umulh	x0, x2, x17
	mul	 x17, x2, x17
	adcs	x2, x6, x7
	adcs	x3, x26, x3
	adcs	x1, x22, x1
	adcs	x6, x19, x24
	adcs	x7, x29, x25
	adcs	x19, x30, xzr
	adds	 x8, x8, x9
	adcs	x9, x11, x20
	ldr	x10, [sp, #32]          // 8-byte Folded Reload
	adcs	x10, x4, x10
	ldr	x11, [sp, #56]          // 8-byte Folded Reload
	ldr	x4, [sp, #40]           // 8-byte Folded Reload
	adcs	x4, x4, x11
	ldr	x11, [sp, #64]          // 8-byte Folded Reload
	adcs	x20, x11, xzr
	adds	 x2, x2, x5
	adcs	x8, x3, x8
	ldr	x24, [sp, #16]          // 8-byte Folded Reload
	mul	 x3, x2, x24
	adcs	x9, x1, x9
	mul	 x1, x3, x12
	mul	 x5, x3, x13
	mul	 x22, x3, x15
	adcs	x10, x6, x10
	mul	 x6, x3, x21
	adcs	x4, x7, x4
	umulh	x7, x3, x14
	adcs	x19, x19, x20
	adcs	x20, xzr, xzr
	adds	 x6, x7, x6
	umulh	x7, x3, x21
	adcs	x7, x7, x22
	umulh	x22, x3, x15
	mov	 x25, x15
	adcs	x5, x22, x5
	umulh	x22, x3, x13
	adcs	x1, x22, x1
	umulh	x22, x3, x12
	mul	 x3, x3, x14
	adcs	x22, x22, xzr
	cmn	 x3, x2
	adcs	x8, x6, x8
	adcs	x9, x7, x9
	adcs	x10, x5, x10
	adcs	x1, x1, x4
	adcs	x2, x22, x19
	adcs	x3, x20, xzr
	adds	 x11, x0, x18
	adcs	x15, x16, x23
	adcs	x16, x27, x28
	ldr	x18, [sp, #24]          // 8-byte Folded Reload
	ldr	x0, [sp, #8]            // 8-byte Folded Reload
	adcs	x18, x0, x18
	ldr	x0, [sp, #48]           // 8-byte Folded Reload
	adcs	x4, x0, xzr
	adds	 x8, x8, x17
	adcs	x9, x9, x11
	mul	 x11, x8, x24
	adcs	x10, x10, x15
	umulh	x15, x11, x12
	mul	 x17, x11, x12
	umulh	x5, x11, x13
	mul	 x6, x11, x13
	mov	 x0, x13
	mov	 x20, x25
	umulh	x7, x11, x20
	mul	 x19, x11, x20
	mov	 x23, x20
	mov	 x13, x21
	umulh	x20, x11, x13
	mul	 x21, x11, x13
	umulh	x22, x11, x14
	mul	 x11, x11, x14
	adcs	x16, x1, x16
	adcs	x18, x2, x18
	adcs	x1, x3, x4
	adcs	x2, xzr, xzr
	adds	 x3, x22, x21
	adcs	x4, x20, x19
	adcs	x6, x7, x6
	adcs	x17, x5, x17
	adcs	x15, x15, xzr
	cmn	 x11, x8
	adcs	x8, x3, x9
	adcs	x9, x4, x10
	adcs	x10, x6, x16
	adcs	x11, x17, x18
	adcs	x15, x15, x1
	adcs	x16, x2, xzr
	subs	 x1, x8, x14
	sbcs	x13, x9, x13
	sbcs	x14, x10, x23
	sbcs	x17, x11, x0
	sbcs	x18, x15, x12
	sbcs	x16, x16, xzr
	tst	 x16, #0x1
	csel	x8, x8, x1, ne
	csel	x9, x9, x13, ne
	csel	x10, x10, x14, ne
	csel	x11, x11, x17, ne
	csel	x12, x15, x18, ne
	ldr	x13, [sp, #72]          // 8-byte Folded Reload
	stp	 x8, x9, [x13]
	stp	x10, x11, [x13, #16]
	str	x12, [x13, #32]
	add	sp, sp, #80             // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end68:
	.size	mcl_fp_mont5L, .Lfunc_end68-mcl_fp_mont5L

	.globl	mcl_fp_montNF5L
	.align	2
	.type	mcl_fp_montNF5L,@function
mcl_fp_montNF5L:                        // @mcl_fp_montNF5L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #32             // =32
	str	x0, [sp, #24]           // 8-byte Folded Spill
	ldp	x16, x14, [x1, #24]
	ldp	x18, x15, [x1, #8]
	ldr	 x17, [x1]
	ldur	x13, [x3, #-8]
	ldp	x9, x8, [x3, #24]
	ldp	x11, x10, [x3, #8]
	ldr	 x12, [x3]
	ldp	 x1, x3, [x2]
	ldp	x4, x5, [x2, #16]
	ldr	x2, [x2, #32]
	umulh	x6, x14, x1
	mul	 x7, x14, x1
	umulh	x19, x16, x1
	mul	 x20, x16, x1
	umulh	x21, x15, x1
	mul	 x22, x15, x1
	umulh	x23, x18, x1
	mul	 x24, x18, x1
	umulh	x25, x17, x1
	mul	 x1, x17, x1
	umulh	x26, x3, x14
	mul	 x27, x3, x14
	umulh	x28, x3, x16
	mul	 x29, x3, x16
	umulh	x30, x3, x15
	adds	 x24, x25, x24
	mul	 x25, x3, x15
	adcs	x22, x23, x22
	umulh	x23, x3, x18
	adcs	x20, x21, x20
	mul	 x21, x1, x13
	adcs	x7, x19, x7
	mul	 x19, x21, x12
	adcs	x6, x6, xzr
	cmn	 x19, x1
	mul	 x1, x3, x18
	mul	 x19, x21, x11
	adcs	x19, x19, x24
	mul	 x24, x21, x10
	adcs	x22, x24, x22
	mul	 x24, x21, x9
	adcs	x20, x24, x20
	mul	 x24, x21, x8
	adcs	x7, x24, x7
	umulh	x24, x21, x12
	adcs	x6, x6, xzr
	adds	 x19, x19, x24
	umulh	x24, x21, x11
	adcs	x22, x22, x24
	umulh	x24, x21, x10
	adcs	x20, x20, x24
	umulh	x24, x21, x9
	adcs	x7, x7, x24
	umulh	x24, x3, x17
	mul	 x3, x3, x17
	umulh	x21, x21, x8
	adcs	x6, x6, x21
	umulh	x21, x4, x14
	adds	 x1, x24, x1
	mul	 x24, x4, x14
	adcs	x23, x23, x25
	umulh	x25, x4, x16
	adcs	x29, x30, x29
	mul	 x30, x4, x16
	adcs	x27, x28, x27
	umulh	x28, x4, x15
	adcs	x26, x26, xzr
	adds	 x3, x3, x19
	mul	 x19, x4, x15
	adcs	x1, x1, x22
	umulh	x22, x4, x18
	adcs	x20, x23, x20
	mul	 x23, x4, x18
	adcs	x7, x29, x7
	mul	 x29, x3, x13
	adcs	x6, x27, x6
	mul	 x27, x29, x12
	adcs	x26, x26, xzr
	cmn	 x27, x3
	umulh	x3, x4, x17
	mul	 x4, x4, x17
	mul	 x27, x29, x11
	adcs	x1, x27, x1
	mul	 x27, x29, x10
	adcs	x20, x27, x20
	mul	 x27, x29, x9
	adcs	x7, x27, x7
	mul	 x27, x29, x8
	adcs	x6, x27, x6
	umulh	x27, x29, x12
	adcs	x26, x26, xzr
	adds	 x1, x1, x27
	umulh	x27, x29, x11
	adcs	x20, x20, x27
	umulh	x27, x29, x10
	adcs	x7, x7, x27
	umulh	x27, x29, x9
	adcs	x6, x6, x27
	umulh	x27, x5, x14
	umulh	x29, x29, x8
	adcs	x26, x26, x29
	mul	 x29, x5, x14
	adds	 x3, x3, x23
	umulh	x23, x5, x16
	adcs	x19, x22, x19
	mul	 x22, x5, x16
	adcs	x28, x28, x30
	umulh	x30, x5, x15
	adcs	x24, x25, x24
	mul	 x25, x5, x15
	adcs	x21, x21, xzr
	adds	 x1, x4, x1
	umulh	x4, x5, x18
	adcs	x3, x3, x20
	mul	 x20, x5, x18
	adcs	x7, x19, x7
	umulh	x19, x5, x17
	mul	 x5, x5, x17
	adcs	x6, x28, x6
	mul	 x28, x1, x13
	adcs	x24, x24, x26
	mul	 x26, x28, x12
	adcs	x21, x21, xzr
	cmn	 x26, x1
	umulh	x0, x2, x14
	mul	 x14, x2, x14
	stp	x14, x0, [sp, #8]
	umulh	x26, x2, x16
	mul	 x1, x2, x16
	umulh	x0, x2, x15
	mul	 x16, x2, x15
	umulh	x15, x2, x18
	mul	 x18, x2, x18
	umulh	x14, x2, x17
	mul	 x17, x2, x17
	mul	 x2, x28, x11
	adcs	x2, x2, x3
	mul	 x3, x28, x10
	adcs	x3, x3, x7
	mul	 x7, x28, x9
	adcs	x6, x7, x6
	mul	 x7, x28, x8
	adcs	x7, x7, x24
	adcs	x21, x21, xzr
	umulh	x24, x28, x12
	adds	 x2, x2, x24
	umulh	x24, x28, x11
	adcs	x3, x3, x24
	umulh	x24, x28, x10
	adcs	x6, x6, x24
	umulh	x24, x28, x9
	adcs	x7, x7, x24
	umulh	x24, x28, x8
	adcs	x21, x21, x24
	adds	 x19, x19, x20
	adcs	x4, x4, x25
	adcs	x20, x30, x22
	adcs	x22, x23, x29
	adcs	x23, x27, xzr
	adds	 x2, x5, x2
	adcs	x3, x19, x3
	mov	 x24, x13
	mul	 x5, x2, x24
	adcs	x4, x4, x6
	mul	 x6, x5, x8
	mul	 x19, x5, x9
	adcs	x7, x20, x7
	mul	 x20, x5, x10
	adcs	x21, x22, x21
	mul	 x22, x5, x12
	adcs	x23, x23, xzr
	cmn	 x22, x2
	mul	 x2, x5, x11
	umulh	x22, x5, x8
	adcs	x2, x2, x3
	umulh	x3, x5, x9
	adcs	x4, x20, x4
	umulh	x20, x5, x10
	adcs	x7, x19, x7
	umulh	x19, x5, x11
	umulh	x5, x5, x12
	adcs	x6, x6, x21
	adcs	x21, x23, xzr
	adds	 x2, x2, x5
	adcs	x4, x4, x19
	adcs	x5, x7, x20
	adcs	x3, x6, x3
	adcs	x6, x21, x22
	adds	 x13, x14, x18
	adcs	x14, x15, x16
	adcs	x15, x0, x1
	ldp	x16, x18, [sp, #8]
	adcs	x16, x26, x16
	adcs	x18, x18, xzr
	adds	 x17, x17, x2
	adcs	x13, x13, x4
	mul	 x0, x17, x24
	adcs	x14, x14, x5
	mul	 x1, x0, x8
	mul	 x2, x0, x9
	mul	 x4, x0, x10
	mul	 x5, x0, x11
	mul	 x7, x0, x12
	umulh	x19, x0, x8
	umulh	x20, x0, x9
	umulh	x21, x0, x10
	umulh	x22, x0, x11
	umulh	x0, x0, x12
	adcs	x15, x15, x3
	adcs	x16, x16, x6
	adcs	x18, x18, xzr
	cmn	 x7, x17
	adcs	x13, x5, x13
	adcs	x14, x4, x14
	adcs	x15, x2, x15
	adcs	x16, x1, x16
	adcs	x17, x18, xzr
	adds	 x13, x13, x0
	adcs	x14, x14, x22
	adcs	x15, x15, x21
	adcs	x16, x16, x20
	adcs	x17, x17, x19
	subs	 x12, x13, x12
	sbcs	x11, x14, x11
	sbcs	x10, x15, x10
	sbcs	x9, x16, x9
	sbcs	x8, x17, x8
	asr	x18, x8, #63
	cmp	 x18, #0                // =0
	csel	x12, x13, x12, lt
	csel	x11, x14, x11, lt
	csel	x10, x15, x10, lt
	csel	x9, x16, x9, lt
	csel	x8, x17, x8, lt
	ldr	x13, [sp, #24]          // 8-byte Folded Reload
	stp	 x12, x11, [x13]
	stp	x10, x9, [x13, #16]
	str	x8, [x13, #32]
	add	sp, sp, #32             // =32
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end69:
	.size	mcl_fp_montNF5L, .Lfunc_end69-mcl_fp_montNF5L

	.globl	mcl_fp_montRed5L
	.align	2
	.type	mcl_fp_montRed5L,@function
mcl_fp_montRed5L:                       // @mcl_fp_montRed5L
// BB#0:
	stp	x26, x25, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	ldur	x13, [x2, #-8]
	ldp	x9, x8, [x2, #24]
	ldp	x11, x10, [x2, #8]
	ldr	 x12, [x2]
	ldp	x15, x16, [x1, #64]
	ldp	x17, x18, [x1, #48]
	ldp	x2, x3, [x1, #32]
	ldp	x4, x5, [x1, #16]
	ldp	 x14, x1, [x1]
	mul	 x6, x14, x13
	umulh	x7, x6, x8
	mul	 x19, x6, x8
	umulh	x20, x6, x9
	mul	 x21, x6, x9
	umulh	x22, x6, x10
	mul	 x23, x6, x10
	umulh	x24, x6, x11
	mul	 x25, x6, x11
	umulh	x26, x6, x12
	mul	 x6, x6, x12
	adds	 x25, x26, x25
	adcs	x23, x24, x23
	adcs	x21, x22, x21
	adcs	x19, x20, x19
	adcs	x7, x7, xzr
	cmn	 x14, x6
	adcs	x14, x1, x25
	adcs	x1, x4, x23
	mul	 x4, x14, x13
	adcs	x5, x5, x21
	umulh	x6, x4, x8
	mul	 x20, x4, x8
	umulh	x21, x4, x9
	mul	 x22, x4, x9
	umulh	x23, x4, x10
	mul	 x24, x4, x10
	umulh	x25, x4, x11
	mul	 x26, x4, x11
	adcs	x2, x2, x19
	umulh	x19, x4, x12
	mul	 x4, x4, x12
	adcs	x3, x3, x7
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x15, x15, xzr
	adcs	x16, x16, xzr
	adcs	x7, xzr, xzr
	adds	 x19, x19, x26
	adcs	x24, x25, x24
	adcs	x22, x23, x22
	adcs	x20, x21, x20
	adcs	x6, x6, xzr
	cmn	 x4, x14
	adcs	x14, x19, x1
	adcs	x1, x24, x5
	mul	 x4, x14, x13
	adcs	x2, x22, x2
	umulh	x5, x4, x8
	mul	 x19, x4, x8
	umulh	x21, x4, x9
	mul	 x22, x4, x9
	umulh	x23, x4, x10
	mul	 x24, x4, x10
	umulh	x25, x4, x11
	mul	 x26, x4, x11
	adcs	x3, x20, x3
	umulh	x20, x4, x12
	mul	 x4, x4, x12
	adcs	x17, x6, x17
	adcs	x18, x18, xzr
	adcs	x15, x15, xzr
	adcs	x16, x16, xzr
	adcs	x6, x7, xzr
	adds	 x7, x20, x26
	adcs	x20, x25, x24
	adcs	x22, x23, x22
	adcs	x19, x21, x19
	adcs	x5, x5, xzr
	cmn	 x4, x14
	adcs	x14, x7, x1
	adcs	x1, x20, x2
	mul	 x2, x14, x13
	adcs	x3, x22, x3
	umulh	x4, x2, x8
	mul	 x7, x2, x8
	umulh	x20, x2, x9
	mul	 x21, x2, x9
	umulh	x22, x2, x10
	mul	 x23, x2, x10
	umulh	x24, x2, x11
	mul	 x25, x2, x11
	umulh	x26, x2, x12
	mul	 x2, x2, x12
	adcs	x17, x19, x17
	adcs	x18, x5, x18
	adcs	x15, x15, xzr
	adcs	x16, x16, xzr
	adcs	x5, x6, xzr
	adds	 x6, x26, x25
	adcs	x19, x24, x23
	adcs	x21, x22, x21
	adcs	x7, x20, x7
	adcs	x4, x4, xzr
	cmn	 x2, x14
	adcs	x14, x6, x1
	adcs	x1, x19, x3
	mul	 x13, x14, x13
	adcs	x17, x21, x17
	umulh	x2, x13, x8
	mul	 x3, x13, x8
	umulh	x6, x13, x9
	mul	 x19, x13, x9
	umulh	x20, x13, x10
	mul	 x21, x13, x10
	umulh	x22, x13, x11
	mul	 x23, x13, x11
	umulh	x24, x13, x12
	mul	 x13, x13, x12
	adcs	x18, x7, x18
	adcs	x15, x4, x15
	adcs	x16, x16, xzr
	adcs	x4, x5, xzr
	adds	 x5, x24, x23
	adcs	x7, x22, x21
	adcs	x19, x20, x19
	adcs	x3, x6, x3
	adcs	x2, x2, xzr
	cmn	 x13, x14
	adcs	x13, x5, x1
	adcs	x14, x7, x17
	adcs	x17, x19, x18
	adcs	x15, x3, x15
	adcs	x16, x2, x16
	adcs	x18, x4, xzr
	subs	 x12, x13, x12
	sbcs	x11, x14, x11
	sbcs	x10, x17, x10
	sbcs	x9, x15, x9
	sbcs	x8, x16, x8
	sbcs	x18, x18, xzr
	tst	 x18, #0x1
	csel	x12, x13, x12, ne
	csel	x11, x14, x11, ne
	csel	x10, x17, x10, ne
	csel	x9, x15, x9, ne
	csel	x8, x16, x8, ne
	stp	 x12, x11, [x0]
	stp	x10, x9, [x0, #16]
	str	x8, [x0, #32]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x26, x25, [sp], #64
	ret
.Lfunc_end70:
	.size	mcl_fp_montRed5L, .Lfunc_end70-mcl_fp_montRed5L

	.globl	mcl_fp_addPre5L
	.align	2
	.type	mcl_fp_addPre5L,@function
mcl_fp_addPre5L:                        // @mcl_fp_addPre5L
// BB#0:
	ldp	x11, x8, [x2, #24]
	ldp	x17, x9, [x1, #24]
	ldp	x13, x10, [x2, #8]
	ldr	 x12, [x2]
	ldp	 x14, x15, [x1]
	ldr	x16, [x1, #16]
	adds	 x12, x12, x14
	str	 x12, [x0]
	adcs	x12, x13, x15
	adcs	x10, x10, x16
	stp	x12, x10, [x0, #8]
	adcs	x10, x11, x17
	adcs	x9, x8, x9
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #24]
	mov	 x0, x8
	ret
.Lfunc_end71:
	.size	mcl_fp_addPre5L, .Lfunc_end71-mcl_fp_addPre5L

	.globl	mcl_fp_subPre5L
	.align	2
	.type	mcl_fp_subPre5L,@function
mcl_fp_subPre5L:                        // @mcl_fp_subPre5L
// BB#0:
	ldp	x11, x8, [x2, #24]
	ldp	x17, x9, [x1, #24]
	ldp	x13, x10, [x2, #8]
	ldr	 x12, [x2]
	ldp	 x14, x15, [x1]
	ldr	x16, [x1, #16]
	subs	 x12, x14, x12
	str	 x12, [x0]
	sbcs	x12, x15, x13
	sbcs	x10, x16, x10
	stp	x12, x10, [x0, #8]
	sbcs	x10, x17, x11
	sbcs	x9, x9, x8
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #24]
	mov	 x0, x8
	ret
.Lfunc_end72:
	.size	mcl_fp_subPre5L, .Lfunc_end72-mcl_fp_subPre5L

	.globl	mcl_fp_shr1_5L
	.align	2
	.type	mcl_fp_shr1_5L,@function
mcl_fp_shr1_5L:                         // @mcl_fp_shr1_5L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldr	x12, [x1, #32]
	extr	x8, x9, x8, #1
	extr	x9, x10, x9, #1
	extr	x10, x11, x10, #1
	extr	x11, x12, x11, #1
	lsr	x12, x12, #1
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	str	x12, [x0, #32]
	ret
.Lfunc_end73:
	.size	mcl_fp_shr1_5L, .Lfunc_end73-mcl_fp_shr1_5L

	.globl	mcl_fp_add5L
	.align	2
	.type	mcl_fp_add5L,@function
mcl_fp_add5L:                           // @mcl_fp_add5L
// BB#0:
	ldp	x11, x8, [x2, #24]
	ldp	x17, x9, [x1, #24]
	ldp	x13, x10, [x2, #8]
	ldr	 x12, [x2]
	ldp	 x14, x15, [x1]
	ldr	x16, [x1, #16]
	adds	 x12, x12, x14
	ldr	x14, [x3, #32]
	adcs	x13, x13, x15
	adcs	x10, x10, x16
	ldp	 x15, x16, [x3]
	stp	 x12, x13, [x0]
	adcs	x17, x11, x17
	stp	x10, x17, [x0, #16]
	adcs	x8, x8, x9
	str	x8, [x0, #32]
	adcs	x18, xzr, xzr
	ldp	x9, x1, [x3, #16]
	subs	 x12, x12, x15
	sbcs	x11, x13, x16
	sbcs	x10, x10, x9
	sbcs	x9, x17, x1
	sbcs	x8, x8, x14
	sbcs	x13, x18, xzr
	and	w13, w13, #0x1
	tbnz	w13, #0, .LBB74_2
// BB#1:                                // %nocarry
	stp	 x12, x11, [x0]
	stp	x10, x9, [x0, #16]
	str	x8, [x0, #32]
.LBB74_2:                               // %carry
	ret
.Lfunc_end74:
	.size	mcl_fp_add5L, .Lfunc_end74-mcl_fp_add5L

	.globl	mcl_fp_addNF5L
	.align	2
	.type	mcl_fp_addNF5L,@function
mcl_fp_addNF5L:                         // @mcl_fp_addNF5L
// BB#0:
	ldp	x11, x8, [x1, #24]
	ldp	x17, x9, [x2, #24]
	ldp	x13, x10, [x1, #8]
	ldr	 x12, [x1]
	ldp	 x14, x15, [x2]
	ldr	x16, [x2, #16]
	adds	 x12, x14, x12
	ldp	x18, x14, [x3, #24]
	adcs	x13, x15, x13
	adcs	x10, x16, x10
	ldp	 x15, x16, [x3]
	adcs	x11, x17, x11
	ldr	x17, [x3, #16]
	adcs	x8, x9, x8
	subs	 x9, x12, x15
	sbcs	x15, x13, x16
	sbcs	x16, x10, x17
	sbcs	x17, x11, x18
	sbcs	x14, x8, x14
	asr	x18, x14, #63
	cmp	 x18, #0                // =0
	csel	x9, x12, x9, lt
	csel	x12, x13, x15, lt
	csel	x10, x10, x16, lt
	csel	x11, x11, x17, lt
	csel	x8, x8, x14, lt
	stp	 x9, x12, [x0]
	stp	x10, x11, [x0, #16]
	str	x8, [x0, #32]
	ret
.Lfunc_end75:
	.size	mcl_fp_addNF5L, .Lfunc_end75-mcl_fp_addNF5L

	.globl	mcl_fp_sub5L
	.align	2
	.type	mcl_fp_sub5L,@function
mcl_fp_sub5L:                           // @mcl_fp_sub5L
// BB#0:
	ldp	x11, x12, [x2, #24]
	ldp	x17, x13, [x1, #24]
	ldp	x9, x10, [x2, #8]
	ldr	 x8, [x2]
	ldp	 x14, x15, [x1]
	ldr	x16, [x1, #16]
	subs	 x8, x14, x8
	sbcs	x9, x15, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x16, x10
	sbcs	x11, x17, x11
	stp	x10, x11, [x0, #16]
	sbcs	x12, x13, x12
	str	x12, [x0, #32]
	ngcs	 x13, xzr
	and	w13, w13, #0x1
	tbnz	w13, #0, .LBB76_2
// BB#1:                                // %nocarry
	ret
.LBB76_2:                               // %carry
	ldp	x17, x13, [x3, #24]
	ldp	 x14, x15, [x3]
	ldr	x16, [x3, #16]
	adds	 x8, x14, x8
	adcs	x9, x15, x9
	adcs	x10, x16, x10
	adcs	x11, x17, x11
	adcs	x12, x13, x12
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	str	x12, [x0, #32]
	ret
.Lfunc_end76:
	.size	mcl_fp_sub5L, .Lfunc_end76-mcl_fp_sub5L

	.globl	mcl_fp_subNF5L
	.align	2
	.type	mcl_fp_subNF5L,@function
mcl_fp_subNF5L:                         // @mcl_fp_subNF5L
// BB#0:
	ldp	x11, x8, [x2, #24]
	ldp	x17, x9, [x1, #24]
	ldp	x13, x10, [x2, #8]
	ldr	 x12, [x2]
	ldp	 x14, x15, [x1]
	ldr	x16, [x1, #16]
	subs	 x12, x14, x12
	sbcs	x13, x15, x13
	ldp	x1, x14, [x3, #8]
	ldp	x15, x18, [x3, #24]
	sbcs	x10, x16, x10
	ldr	 x16, [x3]
	sbcs	x11, x17, x11
	sbcs	x8, x9, x8
	asr	x9, x8, #63
	extr	x17, x9, x8, #63
	and	 x16, x17, x16
	and	x14, x14, x9, ror #63
	and	 x15, x9, x15
	and	 x17, x9, x18
	ror	 x9, x9, #63
	and	 x9, x9, x1
	adds	 x12, x16, x12
	adcs	x9, x9, x13
	stp	 x12, x9, [x0]
	adcs	x9, x14, x10
	str	x9, [x0, #16]
	adcs	x9, x15, x11
	adcs	x8, x17, x8
	stp	x9, x8, [x0, #24]
	ret
.Lfunc_end77:
	.size	mcl_fp_subNF5L, .Lfunc_end77-mcl_fp_subNF5L

	.globl	mcl_fpDbl_add5L
	.align	2
	.type	mcl_fpDbl_add5L,@function
mcl_fpDbl_add5L:                        // @mcl_fpDbl_add5L
// BB#0:
	stp	x22, x21, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	ldp	x8, x9, [x2, #64]
	ldp	x10, x11, [x1, #64]
	ldp	x12, x13, [x2, #48]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x2, #32]
	ldp	x18, x4, [x1, #32]
	ldp	x5, x6, [x2, #16]
	ldp	 x19, x2, [x2]
	ldp	x20, x21, [x1, #16]
	ldp	 x7, x1, [x1]
	adds	 x7, x19, x7
	ldr	x19, [x3, #32]
	str	 x7, [x0]
	adcs	x1, x2, x1
	ldp	x2, x7, [x3, #16]
	str	x1, [x0, #8]
	ldp	 x1, x3, [x3]
	adcs	x5, x5, x20
	str	x5, [x0, #16]
	adcs	x5, x6, x21
	adcs	x16, x16, x18
	stp	x5, x16, [x0, #24]
	adcs	x16, x17, x4
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	adcs	x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, xzr, xzr
	subs	 x11, x16, x1
	sbcs	x14, x12, x3
	sbcs	x15, x13, x2
	sbcs	x17, x8, x7
	sbcs	x18, x9, x19
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x10, x16, x11, ne
	csel	x11, x12, x14, ne
	csel	x12, x13, x15, ne
	csel	x8, x8, x17, ne
	csel	x9, x9, x18, ne
	stp	x10, x11, [x0, #40]
	stp	x12, x8, [x0, #56]
	str	x9, [x0, #72]
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #32
	ret
.Lfunc_end78:
	.size	mcl_fpDbl_add5L, .Lfunc_end78-mcl_fpDbl_add5L

	.globl	mcl_fpDbl_sub5L
	.align	2
	.type	mcl_fpDbl_sub5L,@function
mcl_fpDbl_sub5L:                        // @mcl_fpDbl_sub5L
// BB#0:
	stp	x22, x21, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	ldp	x8, x9, [x2, #64]
	ldp	x10, x11, [x1, #64]
	ldp	x12, x13, [x2, #48]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x2, #32]
	ldp	x18, x4, [x1, #32]
	ldp	x5, x6, [x2, #16]
	ldp	 x7, x2, [x2]
	ldp	x20, x21, [x1, #16]
	ldp	 x19, x1, [x1]
	subs	 x7, x19, x7
	ldr	x19, [x3, #32]
	str	 x7, [x0]
	sbcs	x1, x1, x2
	ldp	x2, x7, [x3, #16]
	str	x1, [x0, #8]
	ldp	 x1, x3, [x3]
	sbcs	x5, x20, x5
	str	x5, [x0, #16]
	sbcs	x5, x21, x6
	sbcs	x16, x18, x16
	stp	x5, x16, [x0, #24]
	sbcs	x16, x4, x17
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	sbcs	x8, x10, x8
	sbcs	x9, x11, x9
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x19, xzr, ne
	csel	x11, x7, xzr, ne
	csel	x14, x2, xzr, ne
	csel	x15, x3, xzr, ne
	csel	x17, x1, xzr, ne
	adds	 x16, x17, x16
	adcs	x12, x15, x12
	stp	x16, x12, [x0, #40]
	adcs	x12, x14, x13
	adcs	x8, x11, x8
	stp	x12, x8, [x0, #56]
	adcs	x8, x10, x9
	str	x8, [x0, #72]
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #32
	ret
.Lfunc_end79:
	.size	mcl_fpDbl_sub5L, .Lfunc_end79-mcl_fpDbl_sub5L

	.globl	mcl_fp_mulUnitPre6L
	.align	2
	.type	mcl_fp_mulUnitPre6L,@function
mcl_fp_mulUnitPre6L:                    // @mcl_fp_mulUnitPre6L
// BB#0:
	ldp	x8, x9, [x1, #32]
	ldp	 x10, x11, [x1]
	ldp	x12, x13, [x1, #16]
	mul	 x14, x10, x2
	mul	 x15, x11, x2
	umulh	x10, x10, x2
	mul	 x16, x12, x2
	umulh	x11, x11, x2
	mul	 x17, x13, x2
	umulh	x12, x12, x2
	mul	 x18, x8, x2
	umulh	x13, x13, x2
	mul	 x1, x9, x2
	umulh	x8, x8, x2
	umulh	x9, x9, x2
	adds	 x10, x10, x15
	stp	 x14, x10, [x0]
	adcs	x10, x11, x16
	str	x10, [x0, #16]
	adcs	x10, x12, x17
	str	x10, [x0, #24]
	adcs	x10, x13, x18
	adcs	x8, x8, x1
	stp	x10, x8, [x0, #32]
	adcs	x8, x9, xzr
	str	x8, [x0, #48]
	ret
.Lfunc_end80:
	.size	mcl_fp_mulUnitPre6L, .Lfunc_end80-mcl_fp_mulUnitPre6L

	.globl	mcl_fpDbl_mulPre6L
	.align	2
	.type	mcl_fpDbl_mulPre6L,@function
mcl_fpDbl_mulPre6L:                     // @mcl_fpDbl_mulPre6L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #400            // =400
	ldp	 x8, x9, [x1]
	ldp	 x11, x13, [x1]
	ldp	x10, x17, [x1, #16]
	ldp	x12, x14, [x1, #32]
	ldp	 x15, x16, [x2]
	ldr	x3, [x1, #32]
	mul	 x30, x8, x15
	umulh	x18, x14, x15
	str	x18, [sp, #392]         // 8-byte Folded Spill
	mul	 x18, x14, x15
	str	x18, [sp, #384]         // 8-byte Folded Spill
	umulh	x18, x12, x15
	str	x18, [sp, #376]         // 8-byte Folded Spill
	mul	 x18, x12, x15
	str	x18, [sp, #360]         // 8-byte Folded Spill
	umulh	x18, x17, x15
	str	x18, [sp, #336]         // 8-byte Folded Spill
	mul	 x18, x17, x15
	str	x18, [sp, #312]         // 8-byte Folded Spill
	umulh	x18, x10, x15
	str	x18, [sp, #304]         // 8-byte Folded Spill
	mul	 x18, x10, x15
	str	x18, [sp, #272]         // 8-byte Folded Spill
	umulh	x18, x9, x15
	str	x18, [sp, #248]         // 8-byte Folded Spill
	mul	 x18, x9, x15
	umulh	x15, x8, x15
	stp	x15, x18, [sp, #216]
	mul	 x15, x8, x16
	str	x15, [sp, #280]         // 8-byte Folded Spill
	mul	 x15, x14, x16
	str	x15, [sp, #352]         // 8-byte Folded Spill
	mul	 x15, x12, x16
	str	x15, [sp, #328]         // 8-byte Folded Spill
	mul	 x15, x17, x16
	str	x15, [sp, #296]         // 8-byte Folded Spill
	mul	 x15, x10, x16
	str	x15, [sp, #264]         // 8-byte Folded Spill
	mul	 x15, x9, x16
	umulh	x14, x14, x16
	str	x14, [sp, #368]         // 8-byte Folded Spill
	umulh	x12, x12, x16
	str	x12, [sp, #344]         // 8-byte Folded Spill
	umulh	x12, x17, x16
	str	x12, [sp, #320]         // 8-byte Folded Spill
	umulh	x10, x10, x16
	str	x10, [sp, #288]         // 8-byte Folded Spill
	umulh	x9, x9, x16
	str	x9, [sp, #256]          // 8-byte Folded Spill
	umulh	x8, x8, x16
	stp	x8, x15, [sp, #232]
	ldp	x12, x8, [x2, #16]
	ldr	x9, [x1, #40]
	ldp	x15, x10, [x1, #16]
	mul	 x14, x11, x12
	str	x14, [sp, #144]         // 8-byte Folded Spill
	mul	 x14, x9, x12
	str	x14, [sp, #200]         // 8-byte Folded Spill
	mul	 x14, x3, x12
	str	x14, [sp, #176]         // 8-byte Folded Spill
	mul	 x14, x10, x12
	str	x14, [sp, #160]         // 8-byte Folded Spill
	mul	 x14, x15, x12
	str	x14, [sp, #128]         // 8-byte Folded Spill
	mul	 x14, x13, x12
	str	x14, [sp, #112]         // 8-byte Folded Spill
	umulh	x14, x9, x12
	str	x14, [sp, #208]         // 8-byte Folded Spill
	umulh	x14, x3, x12
	str	x14, [sp, #192]         // 8-byte Folded Spill
	umulh	x14, x10, x12
	str	x14, [sp, #168]         // 8-byte Folded Spill
	umulh	x14, x15, x12
	str	x14, [sp, #152]         // 8-byte Folded Spill
	umulh	x14, x13, x12
	str	x14, [sp, #120]         // 8-byte Folded Spill
	umulh	x12, x11, x12
	str	x12, [sp, #104]         // 8-byte Folded Spill
	mul	 x12, x9, x8
	str	x12, [sp, #184]         // 8-byte Folded Spill
	umulh	x9, x9, x8
	str	x9, [sp, #136]          // 8-byte Folded Spill
	mul	 x9, x3, x8
	str	x9, [sp, #80]           // 8-byte Folded Spill
	umulh	x9, x3, x8
	str	x9, [sp, #96]           // 8-byte Folded Spill
	mul	 x9, x10, x8
	str	x9, [sp, #64]           // 8-byte Folded Spill
	umulh	x9, x10, x8
	str	x9, [sp, #88]           // 8-byte Folded Spill
	mul	 x9, x15, x8
	str	x9, [sp, #48]           // 8-byte Folded Spill
	umulh	x9, x15, x8
	str	x9, [sp, #72]           // 8-byte Folded Spill
	mul	 x9, x13, x8
	str	x9, [sp, #32]           // 8-byte Folded Spill
	umulh	x9, x13, x8
	str	x9, [sp, #56]           // 8-byte Folded Spill
	mul	 x9, x11, x8
	str	x9, [sp, #24]           // 8-byte Folded Spill
	umulh	x8, x11, x8
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldp	x12, x13, [x1, #32]
	ldp	 x9, x10, [x1]
	ldp	x11, x1, [x1, #16]
	ldp	x8, x2, [x2, #32]
	mul	 x22, x9, x8
	mul	 x28, x13, x8
	mul	 x27, x12, x8
	mul	 x24, x1, x8
	mul	 x20, x11, x8
	mul	 x19, x10, x8
	umulh	x14, x13, x8
	str	x14, [sp, #16]          // 8-byte Folded Spill
	umulh	x29, x12, x8
	umulh	x26, x1, x8
	umulh	x23, x11, x8
	umulh	x21, x10, x8
	umulh	x7, x9, x8
	mul	 x25, x9, x2
	umulh	x6, x9, x2
	mul	 x4, x10, x2
	umulh	x5, x10, x2
	mul	 x18, x11, x2
	umulh	x3, x11, x2
	mul	 x16, x1, x2
	umulh	x1, x1, x2
	mul	 x15, x12, x2
	umulh	x17, x12, x2
	mul	 x14, x13, x2
	umulh	x13, x13, x2
	str	 x30, [x0]
	ldp	x9, x8, [sp, #216]
	adds	 x2, x9, x8
	ldp	x8, x30, [sp, #272]
	ldr	x9, [sp, #248]          // 8-byte Folded Reload
	adcs	x8, x9, x8
	ldp	x10, x9, [sp, #304]
	adcs	x9, x10, x9
	ldr	x10, [sp, #360]         // 8-byte Folded Reload
	ldr	x11, [sp, #336]         // 8-byte Folded Reload
	adcs	x10, x11, x10
	ldp	x12, x11, [sp, #376]
	adcs	x11, x12, x11
	ldr	x12, [sp, #392]         // 8-byte Folded Reload
	adcs	x12, x12, xzr
	adds	 x2, x30, x2
	str	x2, [x0, #8]
	ldp	x30, x2, [sp, #232]
	adcs	x8, x2, x8
	ldr	x2, [sp, #264]          // 8-byte Folded Reload
	adcs	x9, x2, x9
	ldr	x2, [sp, #296]          // 8-byte Folded Reload
	adcs	x10, x2, x10
	ldr	x2, [sp, #328]          // 8-byte Folded Reload
	adcs	x11, x2, x11
	ldr	x2, [sp, #352]          // 8-byte Folded Reload
	adcs	x12, x2, x12
	adcs	x2, xzr, xzr
	adds	 x8, x8, x30
	ldr	x30, [sp, #256]         // 8-byte Folded Reload
	adcs	x9, x9, x30
	ldr	x30, [sp, #288]         // 8-byte Folded Reload
	adcs	x10, x10, x30
	ldr	x30, [sp, #320]         // 8-byte Folded Reload
	adcs	x11, x11, x30
	ldr	x30, [sp, #344]         // 8-byte Folded Reload
	adcs	x12, x12, x30
	ldr	x30, [sp, #368]         // 8-byte Folded Reload
	adcs	x2, x2, x30
	ldr	x30, [sp, #144]         // 8-byte Folded Reload
	adds	 x8, x30, x8
	str	x8, [x0, #16]
	ldp	x30, x8, [sp, #104]
	adcs	x8, x8, x9
	ldr	x9, [sp, #128]          // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #160]         // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #176]         // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #200]         // 8-byte Folded Reload
	adcs	x12, x12, x2
	adcs	x2, xzr, xzr
	adds	 x8, x8, x30
	ldr	x30, [sp, #120]         // 8-byte Folded Reload
	adcs	x9, x9, x30
	ldr	x30, [sp, #152]         // 8-byte Folded Reload
	adcs	x10, x10, x30
	ldr	x30, [sp, #168]         // 8-byte Folded Reload
	adcs	x11, x11, x30
	ldr	x30, [sp, #192]         // 8-byte Folded Reload
	adcs	x12, x12, x30
	ldr	x30, [sp, #208]         // 8-byte Folded Reload
	adcs	x2, x2, x30
	ldr	x30, [sp, #24]          // 8-byte Folded Reload
	adds	 x8, x30, x8
	str	x8, [x0, #24]
	ldp	x8, x30, [sp, #32]
	adcs	x8, x8, x9
	ldr	x9, [sp, #48]           // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #64]          // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #80]          // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #184]         // 8-byte Folded Reload
	adcs	x12, x12, x2
	adcs	x2, xzr, xzr
	adds	 x8, x8, x30
	ldr	x30, [sp, #56]          // 8-byte Folded Reload
	adcs	x9, x9, x30
	ldr	x30, [sp, #72]          // 8-byte Folded Reload
	adcs	x10, x10, x30
	ldr	x30, [sp, #88]          // 8-byte Folded Reload
	adcs	x11, x11, x30
	ldr	x30, [sp, #96]          // 8-byte Folded Reload
	adcs	x12, x12, x30
	ldr	x30, [sp, #136]         // 8-byte Folded Reload
	adcs	x2, x2, x30
	adds	 x8, x22, x8
	str	x8, [x0, #32]
	adcs	x8, x19, x9
	adcs	x9, x20, x10
	adcs	x10, x24, x11
	adcs	x11, x27, x12
	adcs	x12, x28, x2
	adcs	x2, xzr, xzr
	adds	 x8, x8, x7
	adcs	x9, x9, x21
	adcs	x10, x10, x23
	adcs	x11, x11, x26
	adcs	x12, x12, x29
	ldr	x7, [sp, #16]           // 8-byte Folded Reload
	adcs	x2, x2, x7
	adds	 x8, x25, x8
	str	x8, [x0, #40]
	adcs	x8, x4, x9
	adcs	x9, x18, x10
	adcs	x10, x16, x11
	adcs	x11, x15, x12
	adcs	x12, x14, x2
	adcs	x14, xzr, xzr
	adds	 x8, x8, x6
	str	x8, [x0, #48]
	adcs	x8, x9, x5
	str	x8, [x0, #56]
	adcs	x8, x10, x3
	str	x8, [x0, #64]
	adcs	x8, x11, x1
	str	x8, [x0, #72]
	adcs	x8, x12, x17
	str	x8, [x0, #80]
	adcs	x8, x14, x13
	str	x8, [x0, #88]
	add	sp, sp, #400            // =400
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end81:
	.size	mcl_fpDbl_mulPre6L, .Lfunc_end81-mcl_fpDbl_mulPre6L

	.globl	mcl_fpDbl_sqrPre6L
	.align	2
	.type	mcl_fpDbl_sqrPre6L,@function
mcl_fpDbl_sqrPre6L:                     // @mcl_fpDbl_sqrPre6L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	x8, x9, [x1, #8]
	ldp	x15, x10, [x1, #32]
	ldp	 x11, x13, [x1]
	ldr	 x12, [x1]
	ldp	x17, x14, [x1, #32]
	ldr	x16, [x1, #24]
	mul	 x18, x11, x11
	umulh	x2, x10, x11
	mul	 x3, x15, x11
	mul	 x4, x16, x11
	umulh	x5, x9, x11
	mul	 x6, x9, x11
	umulh	x7, x8, x11
	mul	 x19, x8, x11
	str	 x18, [x0]
	umulh	x18, x11, x11
	adds	 x18, x18, x19
	adcs	x6, x7, x6
	adcs	x4, x5, x4
	umulh	x5, x16, x11
	adcs	x3, x5, x3
	mul	 x5, x10, x11
	umulh	x11, x15, x11
	adcs	x11, x11, x5
	adcs	x2, x2, xzr
	adds	 x18, x19, x18
	ldp	x5, x19, [x1, #16]
	str	x18, [x0, #8]
	mul	 x18, x8, x8
	adcs	x18, x18, x6
	mul	 x6, x9, x8
	adcs	x4, x6, x4
	mul	 x6, x16, x8
	adcs	x3, x6, x3
	mul	 x6, x15, x8
	adcs	x11, x6, x11
	mul	 x6, x10, x8
	adcs	x2, x6, x2
	adcs	x6, xzr, xzr
	adds	 x18, x18, x7
	ldr	x7, [x1, #32]
	umulh	x10, x10, x8
	umulh	x15, x15, x8
	umulh	x16, x16, x8
	umulh	x9, x9, x8
	umulh	x8, x8, x8
	adcs	x8, x4, x8
	adcs	x9, x3, x9
	ldp	 x3, x4, [x1]
	adcs	x11, x11, x16
	mul	 x16, x12, x5
	adcs	x15, x2, x15
	mul	 x2, x14, x5
	adcs	x10, x6, x10
	mul	 x6, x7, x5
	adds	 x16, x16, x18
	mul	 x18, x19, x5
	str	x16, [x0, #16]
	mul	 x16, x13, x5
	adcs	x8, x16, x8
	mul	 x16, x5, x5
	adcs	x9, x16, x9
	umulh	x16, x7, x5
	adcs	x11, x18, x11
	adcs	x15, x6, x15
	umulh	x6, x12, x5
	adcs	x10, x2, x10
	adcs	x2, xzr, xzr
	adds	 x8, x8, x6
	umulh	x6, x13, x5
	adcs	x9, x9, x6
	umulh	x6, x5, x5
	adcs	x11, x11, x6
	umulh	x6, x19, x5
	adcs	x15, x15, x6
	adcs	x10, x10, x16
	umulh	x5, x14, x5
	adcs	x2, x2, x5
	mul	 x5, x12, x19
	adds	 x8, x5, x8
	ldp	x16, x5, [x1, #16]
	ldr	x1, [x1, #40]
	str	x8, [x0, #24]
	mul	 x8, x13, x19
	adcs	x8, x8, x9
	mul	 x9, x14, x19
	adcs	x11, x18, x11
	mul	 x18, x19, x19
	adcs	x15, x18, x15
	mul	 x18, x7, x19
	umulh	x14, x14, x19
	umulh	x7, x7, x19
	umulh	x13, x13, x19
	umulh	x12, x12, x19
	umulh	x19, x19, x19
	adcs	x10, x18, x10
	mul	 x18, x3, x17
	adcs	x9, x9, x2
	adcs	x2, xzr, xzr
	adds	 x8, x8, x12
	mul	 x12, x1, x17
	adcs	x11, x11, x13
	mul	 x13, x5, x17
	adcs	x15, x15, x6
	mul	 x6, x16, x17
	adcs	x10, x10, x19
	mul	 x19, x4, x17
	adcs	x9, x9, x7
	mul	 x7, x17, x17
	adcs	x14, x2, x14
	umulh	x2, x1, x17
	adds	 x8, x18, x8
	umulh	x18, x5, x17
	str	x8, [x0, #32]
	umulh	x8, x16, x17
	adcs	x11, x19, x11
	umulh	x19, x4, x17
	adcs	x15, x6, x15
	umulh	x6, x3, x17
	umulh	x17, x17, x17
	adcs	x10, x13, x10
	mul	 x13, x3, x1
	adcs	x9, x7, x9
	adcs	x14, x12, x14
	adcs	x7, xzr, xzr
	adds	 x11, x11, x6
	mul	 x6, x5, x1
	adcs	x15, x15, x19
	mul	 x19, x16, x1
	adcs	x8, x10, x8
	mul	 x10, x4, x1
	adcs	x9, x9, x18
	mul	 x18, x1, x1
	umulh	x3, x3, x1
	umulh	x4, x4, x1
	umulh	x16, x16, x1
	umulh	x5, x5, x1
	umulh	x1, x1, x1
	adcs	x14, x14, x17
	adcs	x17, x7, x2
	adds	 x11, x13, x11
	str	x11, [x0, #40]
	adcs	x10, x10, x15
	adcs	x8, x19, x8
	adcs	x9, x6, x9
	adcs	x11, x12, x14
	adcs	x12, x18, x17
	adcs	x13, xzr, xzr
	adds	 x10, x10, x3
	adcs	x8, x8, x4
	stp	x10, x8, [x0, #48]
	adcs	x8, x9, x16
	str	x8, [x0, #64]
	adcs	x8, x11, x5
	str	x8, [x0, #72]
	adcs	x8, x12, x2
	str	x8, [x0, #80]
	adcs	x8, x13, x1
	str	x8, [x0, #88]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end82:
	.size	mcl_fpDbl_sqrPre6L, .Lfunc_end82-mcl_fpDbl_sqrPre6L

	.globl	mcl_fp_mont6L
	.align	2
	.type	mcl_fp_mont6L,@function
mcl_fp_mont6L:                          // @mcl_fp_mont6L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #48             // =48
	str	x0, [sp, #24]           // 8-byte Folded Spill
	ldr	 x5, [x2]
	ldp	x0, x4, [x1, #32]
	ldp	x16, x18, [x1, #16]
	ldp	 x10, x1, [x1]
	ldur	x12, [x3, #-8]
	str	x12, [sp, #40]          // 8-byte Folded Spill
	ldp	x11, x8, [x3, #32]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldp	x13, x17, [x3, #16]
	ldp	 x14, x15, [x3]
	ldr	x3, [x2, #8]
	umulh	x6, x4, x5
	mul	 x7, x4, x5
	umulh	x19, x0, x5
	mul	 x20, x0, x5
	umulh	x21, x18, x5
	mul	 x22, x18, x5
	umulh	x23, x16, x5
	mul	 x24, x16, x5
	umulh	x25, x1, x5
	mul	 x26, x1, x5
	umulh	x27, x10, x5
	mul	 x5, x10, x5
	umulh	x28, x3, x4
	adds	 x26, x27, x26
	mul	 x27, x5, x12
	adcs	x24, x25, x24
	mul	 x25, x27, x8
	mul	 x29, x27, x11
	mul	 x30, x27, x17
	adcs	x22, x23, x22
	mul	 x23, x27, x13
	adcs	x20, x21, x20
	mul	 x21, x27, x15
	adcs	x7, x19, x7
	umulh	x19, x27, x14
	adcs	x6, x6, xzr
	adds	 x19, x19, x21
	umulh	x21, x27, x15
	adcs	x21, x21, x23
	umulh	x23, x27, x13
	adcs	x23, x23, x30
	umulh	x30, x27, x17
	adcs	x29, x30, x29
	umulh	x30, x27, x11
	adcs	x25, x30, x25
	umulh	x30, x27, x8
	mul	 x27, x27, x14
	adcs	x30, x30, xzr
	cmn	 x27, x5
	mul	 x5, x3, x4
	umulh	x27, x3, x0
	adcs	x19, x19, x26
	mul	 x26, x3, x0
	adcs	x21, x21, x24
	mul	 x24, x3, x18
	adcs	x22, x23, x22
	mul	 x23, x3, x16
	adcs	x20, x29, x20
	mul	 x29, x3, x1
	adcs	x7, x25, x7
	umulh	x25, x3, x10
	adcs	x30, x30, x6
	adcs	x6, xzr, xzr
	adds	 x25, x25, x29
	umulh	x29, x3, x1
	adcs	x23, x29, x23
	umulh	x29, x3, x16
	adcs	x24, x29, x24
	umulh	x29, x3, x18
	mul	 x3, x3, x10
	adcs	x26, x29, x26
	adcs	x27, x27, x5
	adcs	x29, x28, xzr
	adds	 x3, x19, x3
	adcs	x5, x21, x25
	mul	 x21, x3, x12
	adcs	x28, x22, x23
	umulh	x22, x21, x8
	mul	 x23, x21, x8
	mul	 x25, x21, x11
	mul	 x9, x21, x17
	adcs	x19, x20, x24
	mul	 x8, x21, x13
	adcs	x20, x7, x26
	mul	 x24, x21, x15
	adcs	x30, x30, x27
	umulh	x26, x21, x14
	adcs	x6, x6, x29
	adcs	x7, xzr, xzr
	adds	 x24, x26, x24
	umulh	x26, x21, x15
	adcs	x29, x26, x8
	umulh	x8, x21, x13
	adcs	x26, x8, x9
	umulh	x8, x21, x17
	adcs	x27, x8, x25
	umulh	x8, x21, x11
	mul	 x9, x21, x14
	adcs	x8, x8, x23
	adcs	x21, x22, xzr
	cmn	 x9, x3
	ldp	x23, x3, [x2, #16]
	umulh	x9, x23, x4
	adcs	x5, x24, x5
	mul	 x22, x23, x4
	adcs	x24, x29, x28
	mul	 x25, x23, x0
	adcs	x19, x26, x19
	mul	 x26, x23, x18
	adcs	x20, x27, x20
	mul	 x27, x23, x16
	adcs	x8, x8, x30
	mul	 x28, x23, x1
	adcs	x21, x21, x6
	umulh	x6, x23, x10
	adcs	x7, x7, xzr
	adds	 x6, x6, x28
	umulh	x28, x23, x1
	adcs	x27, x28, x27
	umulh	x28, x23, x16
	adcs	x26, x28, x26
	umulh	x28, x23, x18
	adcs	x25, x28, x25
	umulh	x28, x23, x0
	mul	 x23, x23, x10
	adcs	x22, x28, x22
	adcs	x9, x9, xzr
	adds	 x23, x5, x23
	adcs	x5, x24, x6
	mul	 x29, x23, x12
	adcs	x6, x19, x27
	ldr	x12, [sp, #32]          // 8-byte Folded Reload
	mul	 x28, x29, x12
	mul	 x27, x29, x11
	mul	 x30, x29, x17
	adcs	x19, x20, x26
	mul	 x26, x29, x13
	adcs	x20, x8, x25
	mul	 x8, x29, x15
	adcs	x21, x21, x22
	umulh	x24, x29, x14
	adcs	x22, x7, x9
	adcs	x7, xzr, xzr
	adds	 x24, x24, x8
	umulh	x8, x29, x15
	adcs	x25, x8, x26
	umulh	x8, x29, x13
	adcs	x26, x8, x30
	umulh	x8, x29, x17
	adcs	x27, x8, x27
	umulh	x8, x29, x11
	adcs	x28, x8, x28
	umulh	x8, x29, x12
	mul	 x9, x29, x14
	adcs	x29, x8, xzr
	cmn	 x9, x23
	ldp	x23, x8, [x2, #32]
	umulh	x30, x3, x4
	adcs	x2, x24, x5
	mul	 x5, x3, x4
	adcs	x6, x25, x6
	mul	 x24, x3, x0
	adcs	x19, x26, x19
	mul	 x25, x3, x18
	adcs	x20, x27, x20
	mul	 x26, x3, x16
	adcs	x21, x28, x21
	mul	 x27, x3, x1
	adcs	x22, x29, x22
	mov	 x9, x10
	umulh	x28, x3, x9
	adcs	x7, x7, xzr
	adds	 x27, x28, x27
	umulh	x28, x3, x1
	adcs	x26, x28, x26
	umulh	x28, x3, x16
	adcs	x25, x28, x25
	umulh	x28, x3, x18
	adcs	x24, x28, x24
	umulh	x28, x3, x0
	mul	 x3, x3, x9
	adcs	x5, x28, x5
	adcs	x29, x30, xzr
	adds	 x2, x2, x3
	adcs	x3, x6, x27
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	mul	 x6, x2, x10
	adcs	x19, x19, x26
	mul	 x26, x6, x12
	mul	 x27, x6, x11
	mov	 x30, x17
	mul	 x28, x6, x30
	adcs	x20, x20, x25
	mul	 x25, x6, x13
	adcs	x21, x21, x24
	mov	 x17, x15
	mul	 x24, x6, x17
	adcs	x5, x22, x5
	umulh	x22, x6, x14
	adcs	x29, x7, x29
	adcs	x7, xzr, xzr
	adds	 x22, x22, x24
	umulh	x24, x6, x17
	adcs	x24, x24, x25
	umulh	x25, x6, x13
	mov	 x15, x13
	adcs	x25, x25, x28
	umulh	x28, x6, x30
	mov	 x13, x30
	adcs	x27, x28, x27
	umulh	x28, x6, x11
	adcs	x26, x28, x26
	umulh	x28, x6, x12
	mul	 x6, x6, x14
	adcs	x28, x28, xzr
	cmn	 x6, x2
	umulh	x2, x23, x4
	mul	 x6, x23, x4
	adcs	x3, x22, x3
	umulh	x22, x23, x0
	adcs	x19, x24, x19
	mul	 x24, x23, x0
	adcs	x20, x25, x20
	mul	 x25, x23, x18
	adcs	x21, x27, x21
	mul	 x27, x23, x16
	adcs	x5, x26, x5
	mul	 x26, x23, x1
	adcs	x29, x28, x29
	umulh	x28, x23, x9
	adcs	x7, x7, xzr
	adds	 x26, x28, x26
	umulh	x28, x23, x1
	adcs	x27, x28, x27
	umulh	x28, x23, x16
	adcs	x25, x28, x25
	umulh	x28, x23, x18
	mul	 x23, x23, x9
	adcs	x24, x28, x24
	umulh	x28, x8, x4
	str	x28, [sp, #16]          // 8-byte Folded Spill
	mul	 x28, x8, x4
	adcs	x6, x22, x6
	adcs	x2, x2, xzr
	adds	 x3, x3, x23
	adcs	x19, x19, x26
	mul	 x22, x3, x10
	adcs	x20, x20, x27
	mul	 x23, x22, x12
	mul	 x26, x22, x11
	mul	 x27, x22, x13
	adcs	x21, x21, x25
	mul	 x25, x22, x15
	adcs	x5, x5, x24
	mul	 x24, x22, x17
	adcs	x4, x29, x6
	umulh	x6, x22, x14
	adcs	x2, x7, x2
	adcs	x7, xzr, xzr
	adds	 x6, x6, x24
	umulh	x24, x22, x17
	adcs	x24, x24, x25
	umulh	x25, x22, x15
	adcs	x25, x25, x27
	umulh	x27, x22, x13
	adcs	x26, x27, x26
	umulh	x27, x22, x11
	adcs	x23, x27, x23
	umulh	x27, x22, x12
	mul	 x22, x22, x14
	adcs	x27, x27, xzr
	cmn	 x22, x3
	umulh	x3, x8, x0
	mul	 x0, x8, x0
	umulh	x22, x8, x18
	mul	 x18, x8, x18
	umulh	x29, x8, x16
	mul	 x16, x8, x16
	umulh	x30, x8, x1
	mul	 x1, x8, x1
	umulh	x10, x8, x9
	mul	 x8, x8, x9
	adcs	x6, x6, x19
	adcs	x19, x24, x20
	adcs	x20, x25, x21
	adcs	x5, x26, x5
	adcs	x9, x23, x4
	str	x9, [sp, #8]            // 8-byte Folded Spill
	adcs	x2, x27, x2
	adcs	x7, x7, xzr
	adds	 x9, x10, x1
	adcs	x16, x30, x16
	adcs	x18, x29, x18
	adcs	x0, x22, x0
	adcs	x1, x3, x28
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x3, x10, xzr
	adds	 x8, x6, x8
	adcs	x9, x19, x9
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	mul	 x4, x8, x10
	adcs	x16, x20, x16
	umulh	x6, x4, x12
	mul	 x19, x4, x12
	mov	 x30, x11
	umulh	x20, x4, x30
	mul	 x21, x4, x30
	umulh	x22, x4, x13
	mul	 x23, x4, x13
	mov	 x29, x13
	umulh	x24, x4, x15
	mul	 x25, x4, x15
	umulh	x26, x4, x17
	mul	 x27, x4, x17
	umulh	x28, x4, x14
	mul	 x4, x4, x14
	adcs	x18, x5, x18
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x10, x10, x0
	adcs	x0, x2, x1
	adcs	x1, x7, x3
	adcs	x2, xzr, xzr
	adds	 x3, x28, x27
	adcs	x5, x26, x25
	adcs	x7, x24, x23
	adcs	x21, x22, x21
	adcs	x19, x20, x19
	adcs	x6, x6, xzr
	cmn	 x4, x8
	adcs	x8, x3, x9
	adcs	x9, x5, x16
	adcs	x16, x7, x18
	adcs	x10, x21, x10
	adcs	x18, x19, x0
	adcs	x0, x6, x1
	adcs	x1, x2, xzr
	subs	 x13, x8, x14
	sbcs	x12, x9, x17
	sbcs	x11, x16, x15
	sbcs	x14, x10, x29
	sbcs	x15, x18, x30
	ldr	x17, [sp, #32]          // 8-byte Folded Reload
	sbcs	x17, x0, x17
	sbcs	x1, x1, xzr
	tst	 x1, #0x1
	csel	x8, x8, x13, ne
	csel	x9, x9, x12, ne
	csel	x11, x16, x11, ne
	csel	x10, x10, x14, ne
	csel	x12, x18, x15, ne
	csel	x13, x0, x17, ne
	ldr	x14, [sp, #24]          // 8-byte Folded Reload
	stp	 x8, x9, [x14]
	stp	x11, x10, [x14, #16]
	stp	x12, x13, [x14, #32]
	add	sp, sp, #48             // =48
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end83:
	.size	mcl_fp_mont6L, .Lfunc_end83-mcl_fp_mont6L

	.globl	mcl_fp_montNF6L
	.align	2
	.type	mcl_fp_montNF6L,@function
mcl_fp_montNF6L:                        // @mcl_fp_montNF6L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #112            // =112
	str	x0, [sp, #96]           // 8-byte Folded Spill
	ldp	x16, x12, [x1, #32]
	ldp	x13, x11, [x1, #16]
	ldp	 x17, x0, [x1]
	ldur	x18, [x3, #-8]
	ldr	x9, [x3, #32]
	str	x9, [sp, #104]          // 8-byte Folded Spill
	ldr	x14, [x3, #40]
	ldp	x4, x10, [x3, #16]
	ldr	 x15, [x3]
	str	x15, [sp, #8]           // 8-byte Folded Spill
	ldr	x9, [x3, #8]
	ldp	 x5, x3, [x2]
	ldp	x6, x7, [x2, #16]
	ldp	x19, x2, [x2, #32]
	umulh	x20, x12, x5
	mul	 x21, x12, x5
	umulh	x22, x16, x5
	mul	 x23, x16, x5
	umulh	x24, x11, x5
	mul	 x25, x11, x5
	mov	 x1, x13
	umulh	x26, x1, x5
	mul	 x27, x1, x5
	mov	 x13, x0
	umulh	x28, x13, x5
	mul	 x29, x13, x5
	mov	 x8, x17
	umulh	x30, x8, x5
	mul	 x5, x8, x5
	adds	 x29, x30, x29
	mul	 x30, x3, x12
	adcs	x27, x28, x27
	mul	 x28, x3, x16
	adcs	x25, x26, x25
	mul	 x26, x3, x11
	adcs	x23, x24, x23
	mul	 x24, x5, x18
	adcs	x21, x22, x21
	mul	 x22, x24, x15
	adcs	x20, x20, xzr
	cmn	 x22, x5
	mul	 x5, x3, x1
	mov	 x0, x9
	mul	 x22, x24, x0
	adcs	x22, x22, x29
	mul	 x29, x24, x4
	adcs	x17, x29, x27
	mul	 x29, x24, x10
	adcs	x25, x29, x25
	ldr	x9, [sp, #104]          // 8-byte Folded Reload
	mul	 x29, x24, x9
	adcs	x23, x29, x23
	mul	 x29, x24, x14
	adcs	x21, x29, x21
	umulh	x29, x24, x15
	adcs	x20, x20, xzr
	adds	 x22, x22, x29
	umulh	x29, x24, x0
	adcs	x15, x17, x29
	umulh	x29, x24, x4
	mov	 x17, x4
	adcs	x25, x25, x29
	umulh	x29, x24, x10
	adcs	x23, x23, x29
	umulh	x29, x24, x9
	adcs	x21, x21, x29
	mul	 x29, x3, x13
	umulh	x24, x24, x14
	adcs	x20, x20, x24
	umulh	x24, x3, x8
	adds	 x24, x24, x29
	umulh	x29, x3, x13
	adcs	x5, x29, x5
	umulh	x29, x3, x1
	adcs	x26, x29, x26
	umulh	x29, x3, x11
	adcs	x28, x29, x28
	umulh	x29, x3, x16
	adcs	x29, x29, x30
	umulh	x30, x3, x12
	mul	 x3, x3, x8
	adcs	x30, x30, xzr
	adds	 x3, x3, x22
	umulh	x22, x6, x12
	adcs	x24, x24, x15
	mul	 x27, x6, x12
	adcs	x5, x5, x25
	mul	 x25, x6, x16
	adcs	x23, x26, x23
	mul	 x26, x6, x11
	adcs	x21, x28, x21
	mul	 x28, x3, x18
	mov	 x4, x18
	adcs	x20, x29, x20
	ldr	x18, [sp, #8]           // 8-byte Folded Reload
	mul	 x29, x28, x18
	adcs	x30, x30, xzr
	cmn	 x29, x3
	mul	 x3, x6, x1
	mul	 x29, x28, x0
	adcs	x24, x29, x24
	mul	 x29, x28, x17
	adcs	x5, x29, x5
	mul	 x29, x28, x10
	adcs	x23, x29, x23
	mul	 x29, x28, x9
	adcs	x21, x29, x21
	mul	 x29, x28, x14
	adcs	x20, x29, x20
	umulh	x29, x28, x18
	adcs	x30, x30, xzr
	adds	 x24, x24, x29
	umulh	x29, x28, x0
	adcs	x5, x5, x29
	umulh	x29, x28, x17
	adcs	x23, x23, x29
	umulh	x29, x28, x10
	adcs	x21, x21, x29
	umulh	x29, x28, x9
	adcs	x20, x20, x29
	mul	 x29, x6, x13
	umulh	x28, x28, x14
	adcs	x28, x30, x28
	umulh	x30, x6, x8
	adds	 x29, x30, x29
	umulh	x30, x6, x13
	adcs	x3, x30, x3
	umulh	x30, x6, x1
	adcs	x26, x30, x26
	umulh	x30, x6, x11
	adcs	x25, x30, x25
	umulh	x30, x6, x16
	mul	 x6, x6, x8
	adcs	x27, x30, x27
	umulh	x30, x7, x12
	adcs	x22, x22, xzr
	adds	 x6, x6, x24
	mul	 x24, x7, x12
	adcs	x5, x29, x5
	umulh	x29, x7, x16
	adcs	x3, x3, x23
	mul	 x23, x7, x16
	adcs	x21, x26, x21
	mul	 x26, x7, x11
	adcs	x20, x25, x20
	mul	 x25, x6, x4
	adcs	x27, x27, x28
	mul	 x28, x25, x18
	adcs	x22, x22, xzr
	cmn	 x28, x6
	mul	 x6, x7, x1
	mul	 x28, x25, x0
	adcs	x5, x28, x5
	mul	 x28, x25, x17
	adcs	x3, x28, x3
	mul	 x28, x25, x10
	adcs	x21, x28, x21
	mul	 x28, x25, x9
	adcs	x20, x28, x20
	mul	 x28, x25, x14
	adcs	x27, x28, x27
	umulh	x28, x25, x18
	adcs	x22, x22, xzr
	adds	 x5, x5, x28
	umulh	x28, x25, x0
	adcs	x3, x3, x28
	umulh	x28, x25, x17
	adcs	x21, x21, x28
	umulh	x28, x25, x10
	adcs	x20, x20, x28
	umulh	x28, x25, x9
	adcs	x27, x27, x28
	mul	 x28, x7, x13
	umulh	x25, x25, x14
	adcs	x22, x22, x25
	umulh	x25, x7, x8
	adds	 x25, x25, x28
	umulh	x28, x7, x13
	adcs	x6, x28, x6
	umulh	x28, x7, x1
	adcs	x26, x28, x26
	umulh	x28, x7, x11
	mul	 x7, x7, x8
	adcs	x23, x28, x23
	umulh	x9, x19, x12
	str	x9, [sp, #16]           // 8-byte Folded Spill
	adcs	x24, x29, x24
	mul	 x9, x19, x12
	str	x9, [sp, #32]           // 8-byte Folded Spill
	adcs	x30, x30, xzr
	adds	 x5, x7, x5
	umulh	x7, x19, x16
	adcs	x3, x25, x3
	mul	 x25, x19, x16
	adcs	x6, x6, x21
	umulh	x21, x19, x11
	adcs	x20, x26, x20
	mul	 x26, x19, x11
	adcs	x23, x23, x27
	mul	 x27, x5, x4
	adcs	x22, x24, x22
	mul	 x24, x27, x18
	adcs	x30, x30, xzr
	cmn	 x24, x5
	mov	 x28, x1
	mul	 x5, x19, x28
	mul	 x24, x19, x13
	umulh	x1, x19, x8
	umulh	x9, x19, x13
	umulh	x15, x19, x28
	mul	 x19, x19, x8
	umulh	x29, x2, x12
	str	x29, [sp, #88]          // 8-byte Folded Spill
	mul	 x29, x2, x12
	umulh	x12, x2, x16
	str	x12, [sp, #80]          // 8-byte Folded Spill
	mul	 x12, x2, x16
	str	x12, [sp, #72]          // 8-byte Folded Spill
	umulh	x12, x2, x11
	mul	 x11, x2, x11
	stp	x11, x12, [sp, #56]
	umulh	x11, x2, x28
	str	x11, [sp, #48]          // 8-byte Folded Spill
	mul	 x11, x2, x28
	str	x11, [sp, #40]          // 8-byte Folded Spill
	umulh	x11, x2, x13
	str	x11, [sp, #24]          // 8-byte Folded Spill
	mul	 x13, x2, x13
	umulh	x16, x2, x8
	mul	 x28, x2, x8
	mul	 x2, x27, x0
	adcs	x2, x2, x3
	mul	 x3, x27, x17
	adcs	x3, x3, x6
	mul	 x6, x27, x10
	adcs	x6, x6, x20
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	mul	 x20, x27, x8
	adcs	x20, x20, x23
	mul	 x23, x27, x14
	adcs	x22, x23, x22
	adcs	x23, x30, xzr
	umulh	x30, x27, x18
	adds	 x2, x2, x30
	umulh	x30, x27, x0
	adcs	x3, x3, x30
	umulh	x30, x27, x17
	mov	 x12, x17
	adcs	x6, x6, x30
	umulh	x30, x27, x10
	adcs	x20, x20, x30
	umulh	x30, x27, x8
	mov	 x11, x8
	adcs	x22, x22, x30
	mov	 x30, x14
	umulh	x27, x27, x30
	adcs	x23, x23, x27
	adds	 x8, x1, x24
	adcs	x9, x9, x5
	adcs	x14, x15, x26
	adcs	x5, x21, x25
	ldr	x15, [sp, #32]          // 8-byte Folded Reload
	adcs	x7, x7, x15
	ldr	x15, [sp, #16]          // 8-byte Folded Reload
	adcs	x21, x15, xzr
	adds	 x2, x19, x2
	adcs	x8, x8, x3
	adcs	x9, x9, x6
	mov	 x24, x4
	mul	 x3, x2, x24
	adcs	x14, x14, x20
	mul	 x6, x3, x30
	adcs	x5, x5, x22
	mul	 x19, x3, x11
	adcs	x7, x7, x23
	mul	 x20, x3, x18
	adcs	x21, x21, xzr
	cmn	 x20, x2
	mul	 x2, x3, x10
	mul	 x20, x3, x0
	adcs	x8, x20, x8
	mul	 x20, x3, x12
	adcs	x9, x20, x9
	umulh	x20, x3, x30
	adcs	x14, x2, x14
	umulh	x2, x3, x11
	mov	 x27, x11
	adcs	x5, x19, x5
	mov	 x11, x10
	umulh	x19, x3, x11
	adcs	x6, x6, x7
	umulh	x7, x3, x18
	adcs	x21, x21, xzr
	adds	 x8, x8, x7
	umulh	x7, x3, x12
	umulh	x3, x3, x0
	adcs	x9, x9, x3
	adcs	x10, x14, x7
	adcs	x3, x5, x19
	adcs	x2, x6, x2
	adcs	x5, x21, x20
	adds	 x15, x16, x13
	ldr	x13, [sp, #40]          // 8-byte Folded Reload
	ldr	x14, [sp, #24]          // 8-byte Folded Reload
	adcs	x16, x14, x13
	ldp	x14, x13, [sp, #48]
	adcs	x17, x14, x13
	ldp	x14, x13, [sp, #64]
	adcs	x1, x14, x13
	ldr	x13, [sp, #80]          // 8-byte Folded Reload
	adcs	x4, x13, x29
	ldr	x13, [sp, #88]          // 8-byte Folded Reload
	adcs	x6, x13, xzr
	adds	 x8, x28, x8
	adcs	x9, x15, x9
	mul	 x15, x8, x24
	adcs	x10, x16, x10
	mul	 x16, x15, x30
	mul	 x14, x15, x27
	mul	 x7, x15, x11
	mul	 x19, x15, x12
	mul	 x20, x15, x0
	mul	 x21, x15, x18
	umulh	x22, x15, x30
	umulh	x23, x15, x27
	umulh	x24, x15, x11
	mov	 x28, x11
	umulh	x25, x15, x12
	umulh	x26, x15, x0
	umulh	x15, x15, x18
	adcs	x17, x17, x3
	adcs	x1, x1, x2
	adcs	x2, x4, x5
	adcs	x3, x6, xzr
	cmn	 x21, x8
	adcs	x8, x20, x9
	adcs	x9, x19, x10
	adcs	x10, x7, x17
	adcs	x17, x14, x1
	adcs	x16, x16, x2
	adcs	x11, x3, xzr
	adds	 x8, x8, x15
	adcs	x9, x9, x26
	adcs	x10, x10, x25
	adcs	x15, x17, x24
	adcs	x16, x16, x23
	adcs	x17, x11, x22
	subs	 x3, x8, x18
	sbcs	x2, x9, x0
	sbcs	x11, x10, x12
	sbcs	x14, x15, x28
	sbcs	x18, x16, x27
	sbcs	x0, x17, x30
	asr	x1, x0, #63
	cmp	 x1, #0                 // =0
	csel	x8, x8, x3, lt
	csel	x9, x9, x2, lt
	csel	x10, x10, x11, lt
	csel	x11, x15, x14, lt
	csel	x12, x16, x18, lt
	csel	x13, x17, x0, lt
	ldr	x14, [sp, #96]          // 8-byte Folded Reload
	stp	 x8, x9, [x14]
	stp	x10, x11, [x14, #16]
	stp	x12, x13, [x14, #32]
	add	sp, sp, #112            // =112
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end84:
	.size	mcl_fp_montNF6L, .Lfunc_end84-mcl_fp_montNF6L

	.globl	mcl_fp_montRed6L
	.align	2
	.type	mcl_fp_montRed6L,@function
mcl_fp_montRed6L:                       // @mcl_fp_montRed6L
// BB#0:
	stp	x26, x25, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	ldur	x14, [x2, #-8]
	ldp	x9, x8, [x2, #32]
	ldp	x11, x10, [x2, #16]
	ldp	 x13, x12, [x2]
	ldp	x16, x17, [x1, #80]
	ldp	x18, x2, [x1, #64]
	ldp	x3, x4, [x1, #48]
	ldp	x5, x6, [x1, #32]
	ldp	x7, x19, [x1, #16]
	ldp	 x15, x1, [x1]
	mul	 x20, x15, x14
	mul	 x21, x20, x8
	mul	 x22, x20, x9
	mul	 x23, x20, x10
	mul	 x24, x20, x11
	mul	 x25, x20, x12
	umulh	x26, x20, x13
	adds	 x25, x26, x25
	umulh	x26, x20, x12
	adcs	x24, x26, x24
	umulh	x26, x20, x11
	adcs	x23, x26, x23
	umulh	x26, x20, x10
	adcs	x22, x26, x22
	umulh	x26, x20, x9
	adcs	x21, x26, x21
	umulh	x26, x20, x8
	mul	 x20, x20, x13
	adcs	x26, x26, xzr
	cmn	 x15, x20
	adcs	x15, x1, x25
	adcs	x1, x7, x24
	mul	 x7, x15, x14
	adcs	x19, x19, x23
	mul	 x20, x7, x8
	mul	 x23, x7, x9
	mul	 x24, x7, x10
	mul	 x25, x7, x11
	adcs	x5, x5, x22
	mul	 x22, x7, x12
	adcs	x6, x6, x21
	umulh	x21, x7, x13
	adcs	x3, x3, x26
	adcs	x4, x4, xzr
	adcs	x18, x18, xzr
	adcs	x2, x2, xzr
	adcs	x16, x16, xzr
	adcs	x17, x17, xzr
	adcs	x26, xzr, xzr
	adds	 x21, x21, x22
	umulh	x22, x7, x12
	adcs	x22, x22, x25
	umulh	x25, x7, x11
	adcs	x24, x25, x24
	umulh	x25, x7, x10
	adcs	x23, x25, x23
	umulh	x25, x7, x9
	adcs	x20, x25, x20
	umulh	x25, x7, x8
	mul	 x7, x7, x13
	adcs	x25, x25, xzr
	cmn	 x7, x15
	adcs	x15, x21, x1
	adcs	x1, x22, x19
	mul	 x7, x15, x14
	adcs	x5, x24, x5
	mul	 x19, x7, x8
	mul	 x21, x7, x9
	mul	 x22, x7, x10
	adcs	x6, x23, x6
	mul	 x23, x7, x11
	adcs	x3, x20, x3
	mul	 x20, x7, x12
	adcs	x4, x25, x4
	umulh	x24, x7, x13
	adcs	x18, x18, xzr
	adcs	x2, x2, xzr
	adcs	x16, x16, xzr
	adcs	x17, x17, xzr
	adcs	x25, x26, xzr
	adds	 x20, x24, x20
	umulh	x24, x7, x12
	adcs	x23, x24, x23
	umulh	x24, x7, x11
	adcs	x22, x24, x22
	umulh	x24, x7, x10
	adcs	x21, x24, x21
	umulh	x24, x7, x9
	adcs	x19, x24, x19
	umulh	x24, x7, x8
	mul	 x7, x7, x13
	adcs	x24, x24, xzr
	cmn	 x7, x15
	adcs	x15, x20, x1
	adcs	x1, x23, x5
	mul	 x5, x15, x14
	adcs	x6, x22, x6
	mul	 x7, x5, x8
	mul	 x20, x5, x9
	mul	 x22, x5, x10
	adcs	x3, x21, x3
	mul	 x21, x5, x11
	adcs	x4, x19, x4
	mul	 x19, x5, x12
	adcs	x18, x24, x18
	umulh	x23, x5, x13
	adcs	x2, x2, xzr
	adcs	x16, x16, xzr
	adcs	x17, x17, xzr
	adcs	x24, x25, xzr
	adds	 x19, x23, x19
	umulh	x23, x5, x12
	adcs	x21, x23, x21
	umulh	x23, x5, x11
	adcs	x22, x23, x22
	umulh	x23, x5, x10
	adcs	x20, x23, x20
	umulh	x23, x5, x9
	adcs	x7, x23, x7
	umulh	x23, x5, x8
	mul	 x5, x5, x13
	adcs	x23, x23, xzr
	cmn	 x5, x15
	adcs	x15, x19, x1
	adcs	x1, x21, x6
	mul	 x5, x15, x14
	adcs	x3, x22, x3
	mul	 x6, x5, x8
	mul	 x19, x5, x9
	mul	 x21, x5, x10
	adcs	x4, x20, x4
	mul	 x20, x5, x11
	adcs	x18, x7, x18
	mul	 x7, x5, x12
	adcs	x2, x23, x2
	umulh	x22, x5, x13
	adcs	x16, x16, xzr
	adcs	x17, x17, xzr
	adcs	x23, x24, xzr
	adds	 x7, x22, x7
	umulh	x22, x5, x12
	adcs	x20, x22, x20
	umulh	x22, x5, x11
	adcs	x21, x22, x21
	umulh	x22, x5, x10
	adcs	x19, x22, x19
	umulh	x22, x5, x9
	adcs	x6, x22, x6
	umulh	x22, x5, x8
	mul	 x5, x5, x13
	adcs	x22, x22, xzr
	cmn	 x5, x15
	adcs	x15, x7, x1
	adcs	x1, x20, x3
	mul	 x14, x15, x14
	adcs	x3, x21, x4
	mul	 x4, x14, x8
	mul	 x5, x14, x9
	mul	 x7, x14, x10
	adcs	x18, x19, x18
	mul	 x19, x14, x11
	adcs	x2, x6, x2
	mul	 x6, x14, x12
	adcs	x16, x22, x16
	umulh	x20, x14, x13
	adcs	x17, x17, xzr
	adcs	x21, x23, xzr
	adds	 x6, x20, x6
	umulh	x20, x14, x12
	adcs	x19, x20, x19
	umulh	x20, x14, x11
	adcs	x7, x20, x7
	umulh	x20, x14, x10
	adcs	x5, x20, x5
	umulh	x20, x14, x9
	adcs	x4, x20, x4
	umulh	x20, x14, x8
	mul	 x14, x14, x13
	adcs	x20, x20, xzr
	cmn	 x14, x15
	adcs	x14, x6, x1
	adcs	x15, x19, x3
	adcs	x18, x7, x18
	adcs	x1, x5, x2
	adcs	x16, x4, x16
	adcs	x17, x20, x17
	adcs	x2, x21, xzr
	subs	 x13, x14, x13
	sbcs	x12, x15, x12
	sbcs	x11, x18, x11
	sbcs	x10, x1, x10
	sbcs	x9, x16, x9
	sbcs	x8, x17, x8
	sbcs	x2, x2, xzr
	tst	 x2, #0x1
	csel	x13, x14, x13, ne
	csel	x12, x15, x12, ne
	csel	x11, x18, x11, ne
	csel	x10, x1, x10, ne
	csel	x9, x16, x9, ne
	csel	x8, x17, x8, ne
	stp	 x13, x12, [x0]
	stp	x11, x10, [x0, #16]
	stp	x9, x8, [x0, #32]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x26, x25, [sp], #64
	ret
.Lfunc_end85:
	.size	mcl_fp_montRed6L, .Lfunc_end85-mcl_fp_montRed6L

	.globl	mcl_fp_addPre6L
	.align	2
	.type	mcl_fp_addPre6L,@function
mcl_fp_addPre6L:                        // @mcl_fp_addPre6L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x14, x15, [x2]
	ldp	 x16, x17, [x1]
	ldp	x18, x1, [x1, #16]
	adds	 x14, x14, x16
	str	 x14, [x0]
	adcs	x14, x15, x17
	adcs	x12, x12, x18
	stp	x14, x12, [x0, #8]
	adcs	x12, x13, x1
	adcs	x8, x8, x10
	stp	x12, x8, [x0, #24]
	adcs	x9, x9, x11
	adcs	x8, xzr, xzr
	str	x9, [x0, #40]
	mov	 x0, x8
	ret
.Lfunc_end86:
	.size	mcl_fp_addPre6L, .Lfunc_end86-mcl_fp_addPre6L

	.globl	mcl_fp_subPre6L
	.align	2
	.type	mcl_fp_subPre6L,@function
mcl_fp_subPre6L:                        // @mcl_fp_subPre6L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x14, x15, [x2]
	ldp	 x16, x17, [x1]
	ldp	x18, x1, [x1, #16]
	subs	 x14, x16, x14
	str	 x14, [x0]
	sbcs	x14, x17, x15
	sbcs	x12, x18, x12
	stp	x14, x12, [x0, #8]
	sbcs	x12, x1, x13
	sbcs	x8, x10, x8
	stp	x12, x8, [x0, #24]
	sbcs	x9, x11, x9
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0, #40]
	mov	 x0, x8
	ret
.Lfunc_end87:
	.size	mcl_fp_subPre6L, .Lfunc_end87-mcl_fp_subPre6L

	.globl	mcl_fp_shr1_6L
	.align	2
	.type	mcl_fp_shr1_6L,@function
mcl_fp_shr1_6L:                         // @mcl_fp_shr1_6L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	extr	x8, x9, x8, #1
	extr	x9, x10, x9, #1
	extr	x10, x11, x10, #1
	extr	x11, x12, x11, #1
	extr	x12, x13, x12, #1
	lsr	x13, x13, #1
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	ret
.Lfunc_end88:
	.size	mcl_fp_shr1_6L, .Lfunc_end88-mcl_fp_shr1_6L

	.globl	mcl_fp_add6L
	.align	2
	.type	mcl_fp_add6L,@function
mcl_fp_add6L:                           // @mcl_fp_add6L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x14, x15, [x2]
	ldp	 x16, x17, [x1]
	ldp	x18, x1, [x1, #16]
	adds	 x14, x14, x16
	adcs	x15, x15, x17
	ldp	x16, x17, [x3, #32]
	adcs	x18, x12, x18
	adcs	x1, x13, x1
	ldp	 x12, x2, [x3]
	stp	 x14, x15, [x0]
	stp	x18, x1, [x0, #16]
	adcs	x8, x8, x10
	adcs	x4, x9, x11
	stp	x8, x4, [x0, #32]
	adcs	x5, xzr, xzr
	ldp	x9, x10, [x3, #16]
	subs	 x13, x14, x12
	sbcs	x12, x15, x2
	sbcs	x11, x18, x9
	sbcs	x10, x1, x10
	sbcs	x9, x8, x16
	sbcs	x8, x4, x17
	sbcs	x14, x5, xzr
	and	w14, w14, #0x1
	tbnz	w14, #0, .LBB89_2
// BB#1:                                // %nocarry
	stp	 x13, x12, [x0]
	stp	x11, x10, [x0, #16]
	stp	x9, x8, [x0, #32]
.LBB89_2:                               // %carry
	ret
.Lfunc_end89:
	.size	mcl_fp_add6L, .Lfunc_end89-mcl_fp_add6L

	.globl	mcl_fp_addNF6L
	.align	2
	.type	mcl_fp_addNF6L,@function
mcl_fp_addNF6L:                         // @mcl_fp_addNF6L
// BB#0:
	ldp	x8, x9, [x1, #32]
	ldp	x10, x11, [x2, #32]
	ldp	x12, x13, [x1, #16]
	ldp	 x14, x15, [x1]
	ldp	 x16, x17, [x2]
	ldp	x18, x1, [x2, #16]
	adds	 x14, x16, x14
	adcs	x15, x17, x15
	ldp	x16, x17, [x3, #32]
	adcs	x12, x18, x12
	adcs	x13, x1, x13
	ldp	 x18, x1, [x3]
	adcs	x8, x10, x8
	ldp	x10, x2, [x3, #16]
	adcs	x9, x11, x9
	subs	 x11, x14, x18
	sbcs	x18, x15, x1
	sbcs	x10, x12, x10
	sbcs	x1, x13, x2
	sbcs	x16, x8, x16
	sbcs	x17, x9, x17
	asr	x2, x17, #63
	cmp	 x2, #0                 // =0
	csel	x11, x14, x11, lt
	csel	x14, x15, x18, lt
	csel	x10, x12, x10, lt
	csel	x12, x13, x1, lt
	csel	x8, x8, x16, lt
	csel	x9, x9, x17, lt
	stp	 x11, x14, [x0]
	stp	x10, x12, [x0, #16]
	stp	x8, x9, [x0, #32]
	ret
.Lfunc_end90:
	.size	mcl_fp_addNF6L, .Lfunc_end90-mcl_fp_addNF6L

	.globl	mcl_fp_sub6L
	.align	2
	.type	mcl_fp_sub6L,@function
mcl_fp_sub6L:                           // @mcl_fp_sub6L
// BB#0:
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x10, x11, [x2, #16]
	ldp	 x8, x9, [x2]
	ldp	 x16, x17, [x1]
	ldp	x18, x1, [x1, #16]
	subs	 x8, x16, x8
	sbcs	x9, x17, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x18, x10
	sbcs	x11, x1, x11
	stp	x10, x11, [x0, #16]
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	stp	x12, x13, [x0, #32]
	ngcs	 x14, xzr
	and	w14, w14, #0x1
	tbnz	w14, #0, .LBB91_2
// BB#1:                                // %nocarry
	ret
.LBB91_2:                               // %carry
	ldp	x14, x15, [x3, #32]
	ldp	 x16, x17, [x3]
	ldp	x18, x1, [x3, #16]
	adds	 x8, x16, x8
	adcs	x9, x17, x9
	adcs	x10, x18, x10
	adcs	x11, x1, x11
	adcs	x12, x14, x12
	adcs	x13, x15, x13
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	ret
.Lfunc_end91:
	.size	mcl_fp_sub6L, .Lfunc_end91-mcl_fp_sub6L

	.globl	mcl_fp_subNF6L
	.align	2
	.type	mcl_fp_subNF6L,@function
mcl_fp_subNF6L:                         // @mcl_fp_subNF6L
// BB#0:
	ldp	x8, x9, [x2, #32]
	ldp	x10, x11, [x1, #32]
	ldp	x12, x13, [x2, #16]
	ldp	 x14, x18, [x2]
	ldp	x16, x17, [x1, #16]
	ldp	 x15, x1, [x1]
	subs	 x14, x15, x14
	ldp	x15, x2, [x3, #32]
	sbcs	x18, x1, x18
	sbcs	x12, x16, x12
	ldp	x16, x1, [x3, #16]
	sbcs	x13, x17, x13
	ldp	 x17, x3, [x3]
	sbcs	x8, x10, x8
	sbcs	x9, x11, x9
	asr	x10, x9, #63
	adds	 x11, x10, x10
	and	 x16, x10, x16
	and	 x1, x10, x1
	and	 x15, x10, x15
	and	 x2, x10, x2
	adcs	x10, x10, x10
	orr	x11, x11, x9, lsr #63
	and	 x11, x11, x17
	and	 x10, x10, x3
	adds	 x11, x11, x14
	adcs	x10, x10, x18
	stp	 x11, x10, [x0]
	adcs	x10, x16, x12
	str	x10, [x0, #16]
	adcs	x10, x1, x13
	adcs	x8, x15, x8
	stp	x10, x8, [x0, #24]
	adcs	x8, x2, x9
	str	x8, [x0, #40]
	ret
.Lfunc_end92:
	.size	mcl_fp_subNF6L, .Lfunc_end92-mcl_fp_subNF6L

	.globl	mcl_fpDbl_add6L
	.align	2
	.type	mcl_fpDbl_add6L,@function
mcl_fpDbl_add6L:                        // @mcl_fpDbl_add6L
// BB#0:
	stp	x26, x25, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	ldp	x8, x9, [x2, #80]
	ldp	x10, x11, [x1, #80]
	ldp	x12, x13, [x2, #64]
	ldp	x14, x15, [x1, #64]
	ldp	x16, x17, [x2, #48]
	ldp	x18, x4, [x1, #48]
	ldp	x5, x6, [x2, #32]
	ldp	x7, x19, [x1, #32]
	ldp	x20, x21, [x2, #16]
	ldp	 x23, x2, [x2]
	ldp	x24, x25, [x1, #16]
	ldp	 x22, x1, [x1]
	adds	 x22, x23, x22
	str	 x22, [x0]
	ldp	x22, x23, [x3, #32]
	adcs	x1, x2, x1
	str	x1, [x0, #8]
	ldp	x1, x2, [x3, #16]
	adcs	x20, x20, x24
	ldp	 x24, x3, [x3]
	str	x20, [x0, #16]
	adcs	x20, x21, x25
	adcs	x5, x5, x7
	stp	x20, x5, [x0, #24]
	adcs	x5, x6, x19
	str	x5, [x0, #40]
	adcs	x16, x16, x18
	adcs	x17, x17, x4
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	adcs	x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, xzr, xzr
	subs	 x11, x16, x24
	sbcs	x14, x17, x3
	sbcs	x15, x12, x1
	sbcs	x18, x13, x2
	sbcs	x1, x8, x22
	sbcs	x2, x9, x23
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x10, x16, x11, ne
	csel	x11, x17, x14, ne
	csel	x12, x12, x15, ne
	csel	x13, x13, x18, ne
	csel	x8, x8, x1, ne
	csel	x9, x9, x2, ne
	stp	x10, x11, [x0, #48]
	stp	x12, x13, [x0, #64]
	stp	x8, x9, [x0, #80]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x26, x25, [sp], #64
	ret
.Lfunc_end93:
	.size	mcl_fpDbl_add6L, .Lfunc_end93-mcl_fpDbl_add6L

	.globl	mcl_fpDbl_sub6L
	.align	2
	.type	mcl_fpDbl_sub6L,@function
mcl_fpDbl_sub6L:                        // @mcl_fpDbl_sub6L
// BB#0:
	stp	x26, x25, [sp, #-64]!
	stp	x24, x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	ldp	x8, x9, [x2, #80]
	ldp	x10, x11, [x1, #80]
	ldp	x12, x13, [x2, #64]
	ldp	x14, x15, [x1, #64]
	ldp	x16, x17, [x2, #48]
	ldp	x18, x4, [x1, #48]
	ldp	x5, x6, [x2, #32]
	ldp	x7, x19, [x1, #32]
	ldp	x20, x21, [x2, #16]
	ldp	 x22, x2, [x2]
	ldp	x24, x25, [x1, #16]
	ldp	 x23, x1, [x1]
	subs	 x22, x23, x22
	str	 x22, [x0]
	ldp	x22, x23, [x3, #32]
	sbcs	x1, x1, x2
	str	x1, [x0, #8]
	ldp	x1, x2, [x3, #16]
	sbcs	x20, x24, x20
	ldp	 x24, x3, [x3]
	str	x20, [x0, #16]
	sbcs	x20, x25, x21
	sbcs	x5, x7, x5
	stp	x20, x5, [x0, #24]
	sbcs	x5, x19, x6
	sbcs	x16, x18, x16
	sbcs	x17, x4, x17
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	sbcs	x8, x10, x8
	sbcs	x9, x11, x9
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x23, xzr, ne
	csel	x11, x22, xzr, ne
	csel	x14, x2, xzr, ne
	csel	x15, x1, xzr, ne
	csel	x18, x3, xzr, ne
	csel	x1, x24, xzr, ne
	adds	 x16, x1, x16
	stp	x5, x16, [x0, #40]
	adcs	x16, x18, x17
	adcs	x12, x15, x12
	stp	x16, x12, [x0, #56]
	adcs	x12, x14, x13
	adcs	x8, x11, x8
	stp	x12, x8, [x0, #72]
	adcs	x8, x10, x9
	str	x8, [x0, #88]
	ldp	x20, x19, [sp, #48]
	ldp	x22, x21, [sp, #32]
	ldp	x24, x23, [sp, #16]
	ldp	x26, x25, [sp], #64
	ret
.Lfunc_end94:
	.size	mcl_fpDbl_sub6L, .Lfunc_end94-mcl_fpDbl_sub6L

	.globl	mcl_fp_mulUnitPre7L
	.align	2
	.type	mcl_fp_mulUnitPre7L,@function
mcl_fp_mulUnitPre7L:                    // @mcl_fp_mulUnitPre7L
// BB#0:
	ldp	x10, x8, [x1, #40]
	ldp	x14, x9, [x1, #24]
	ldp	 x11, x12, [x1]
	ldr	x13, [x1, #16]
	mul	 x15, x11, x2
	mul	 x16, x12, x2
	umulh	x11, x11, x2
	mul	 x17, x13, x2
	umulh	x12, x12, x2
	mul	 x18, x14, x2
	umulh	x13, x13, x2
	mul	 x1, x9, x2
	umulh	x14, x14, x2
	mul	 x3, x10, x2
	umulh	x9, x9, x2
	mul	 x4, x8, x2
	umulh	x10, x10, x2
	umulh	x8, x8, x2
	adds	 x11, x11, x16
	stp	 x15, x11, [x0]
	adcs	x11, x12, x17
	str	x11, [x0, #16]
	adcs	x11, x13, x18
	str	x11, [x0, #24]
	adcs	x11, x14, x1
	adcs	x9, x9, x3
	stp	x11, x9, [x0, #32]
	adcs	x9, x10, x4
	adcs	x8, x8, xzr
	stp	x9, x8, [x0, #48]
	ret
.Lfunc_end95:
	.size	mcl_fp_mulUnitPre7L, .Lfunc_end95-mcl_fp_mulUnitPre7L

	.globl	mcl_fpDbl_mulPre7L
	.align	2
	.type	mcl_fpDbl_mulPre7L,@function
mcl_fpDbl_mulPre7L:                     // @mcl_fpDbl_mulPre7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #624            // =624
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #24]
	ldp	x12, x13, [x1, #40]
	ldp	 x14, x15, [x2]
	ldp	x16, x18, [x1, #16]
	mul	 x17, x8, x14
	str	x17, [sp, #528]         // 8-byte Folded Spill
	umulh	x17, x13, x14
	str	x17, [sp, #616]         // 8-byte Folded Spill
	mul	 x17, x13, x14
	str	x17, [sp, #608]         // 8-byte Folded Spill
	umulh	x17, x12, x14
	str	x17, [sp, #592]         // 8-byte Folded Spill
	mul	 x17, x12, x14
	str	x17, [sp, #568]         // 8-byte Folded Spill
	umulh	x17, x11, x14
	str	x17, [sp, #552]         // 8-byte Folded Spill
	mul	 x17, x11, x14
	str	x17, [sp, #512]         // 8-byte Folded Spill
	umulh	x17, x10, x14
	str	x17, [sp, #496]         // 8-byte Folded Spill
	mul	 x17, x10, x14
	str	x17, [sp, #456]         // 8-byte Folded Spill
	umulh	x17, x16, x14
	str	x17, [sp, #424]         // 8-byte Folded Spill
	mul	 x17, x16, x14
	str	x17, [sp, #368]         // 8-byte Folded Spill
	umulh	x17, x9, x14
	str	x17, [sp, #352]         // 8-byte Folded Spill
	mul	 x17, x9, x14
	str	x17, [sp, #304]         // 8-byte Folded Spill
	umulh	x14, x8, x14
	str	x14, [sp, #272]         // 8-byte Folded Spill
	mul	 x14, x13, x15
	str	x14, [sp, #560]         // 8-byte Folded Spill
	mul	 x14, x12, x15
	str	x14, [sp, #520]         // 8-byte Folded Spill
	mul	 x14, x11, x15
	str	x14, [sp, #488]         // 8-byte Folded Spill
	mul	 x14, x10, x15
	str	x14, [sp, #448]         // 8-byte Folded Spill
	mul	 x14, x16, x15
	umulh	x13, x13, x15
	str	x13, [sp, #600]         // 8-byte Folded Spill
	umulh	x12, x12, x15
	str	x12, [sp, #576]         // 8-byte Folded Spill
	umulh	x11, x11, x15
	str	x11, [sp, #544]         // 8-byte Folded Spill
	umulh	x10, x10, x15
	str	x10, [sp, #504]         // 8-byte Folded Spill
	umulh	x10, x16, x15
	str	x10, [sp, #472]         // 8-byte Folded Spill
	mul	 x10, x9, x15
	str	x10, [sp, #208]         // 8-byte Folded Spill
	umulh	x9, x9, x15
	stp	x9, x14, [sp, #400]
	mul	 x9, x8, x15
	str	x9, [sp, #96]           // 8-byte Folded Spill
	umulh	x8, x8, x15
	str	x8, [sp, #320]          // 8-byte Folded Spill
	ldp	 x9, x11, [x1]
	ldp	x10, x17, [x2, #16]
	ldp	x12, x13, [x1, #16]
	ldp	x14, x16, [x1, #32]
	ldr	x15, [x1, #48]
	mul	 x8, x9, x10
	str	x8, [sp, #248]          // 8-byte Folded Spill
	mul	 x8, x15, x10
	str	x8, [sp, #392]          // 8-byte Folded Spill
	mul	 x8, x16, x10
	str	x8, [sp, #344]          // 8-byte Folded Spill
	mul	 x8, x14, x10
	str	x8, [sp, #296]          // 8-byte Folded Spill
	mul	 x8, x13, x10
	str	x8, [sp, #240]          // 8-byte Folded Spill
	mul	 x8, x12, x10
	str	x8, [sp, #192]          // 8-byte Folded Spill
	mul	 x8, x11, x10
	str	x8, [sp, #136]          // 8-byte Folded Spill
	umulh	x8, x15, x10
	str	x8, [sp, #440]          // 8-byte Folded Spill
	umulh	x8, x16, x10
	str	x8, [sp, #384]          // 8-byte Folded Spill
	umulh	x8, x14, x10
	str	x8, [sp, #336]          // 8-byte Folded Spill
	umulh	x8, x13, x10
	str	x8, [sp, #288]          // 8-byte Folded Spill
	umulh	x8, x12, x10
	str	x8, [sp, #232]          // 8-byte Folded Spill
	umulh	x8, x11, x10
	str	x8, [sp, #184]          // 8-byte Folded Spill
	umulh	x8, x9, x10
	str	x8, [sp, #128]          // 8-byte Folded Spill
	mul	 x8, x15, x17
	str	x8, [sp, #464]          // 8-byte Folded Spill
	umulh	x8, x15, x17
	str	x8, [sp, #584]          // 8-byte Folded Spill
	mul	 x8, x16, x17
	str	x8, [sp, #376]          // 8-byte Folded Spill
	umulh	x8, x16, x17
	str	x8, [sp, #536]          // 8-byte Folded Spill
	mul	 x8, x14, x17
	str	x8, [sp, #312]          // 8-byte Folded Spill
	umulh	x8, x14, x17
	str	x8, [sp, #480]          // 8-byte Folded Spill
	mul	 x8, x13, x17
	str	x8, [sp, #224]          // 8-byte Folded Spill
	umulh	x8, x13, x17
	str	x8, [sp, #416]          // 8-byte Folded Spill
	mul	 x8, x12, x17
	str	x8, [sp, #144]          // 8-byte Folded Spill
	umulh	x8, x12, x17
	str	x8, [sp, #328]          // 8-byte Folded Spill
	mul	 x8, x11, x17
	str	x8, [sp, #80]           // 8-byte Folded Spill
	umulh	x8, x11, x17
	str	x8, [sp, #264]          // 8-byte Folded Spill
	mul	 x28, x9, x17
	umulh	x8, x9, x17
	str	x8, [sp, #176]          // 8-byte Folded Spill
	ldp	x14, x12, [x1, #24]
	ldp	 x10, x9, [x1]
	ldr	x7, [x1, #16]
	ldp	x30, x5, [x1, #40]
	ldp	x27, x8, [x2, #32]
	ldr	x13, [x1, #48]
	mul	 x11, x10, x27
	str	x11, [sp, #48]          // 8-byte Folded Spill
	mul	 x11, x5, x27
	str	x11, [sp, #168]         // 8-byte Folded Spill
	mul	 x11, x30, x27
	str	x11, [sp, #120]         // 8-byte Folded Spill
	mul	 x11, x12, x27
	str	x11, [sp, #72]          // 8-byte Folded Spill
	mul	 x11, x14, x27
	str	x11, [sp, #40]          // 8-byte Folded Spill
	mul	 x11, x7, x27
	str	x11, [sp, #16]          // 8-byte Folded Spill
	mul	 x24, x9, x27
	umulh	x11, x5, x27
	str	x11, [sp, #216]         // 8-byte Folded Spill
	umulh	x11, x30, x27
	str	x11, [sp, #160]         // 8-byte Folded Spill
	umulh	x11, x12, x27
	str	x11, [sp, #112]         // 8-byte Folded Spill
	umulh	x11, x14, x27
	str	x11, [sp, #64]          // 8-byte Folded Spill
	umulh	x11, x7, x27
	str	x11, [sp, #32]          // 8-byte Folded Spill
	umulh	x29, x9, x27
	umulh	x23, x10, x27
	mul	 x11, x5, x8
	str	x11, [sp, #256]         // 8-byte Folded Spill
	umulh	x11, x5, x8
	str	x11, [sp, #432]         // 8-byte Folded Spill
	mul	 x11, x30, x8
	str	x11, [sp, #152]         // 8-byte Folded Spill
	umulh	x11, x30, x8
	str	x11, [sp, #360]         // 8-byte Folded Spill
	mul	 x11, x12, x8
	str	x11, [sp, #88]          // 8-byte Folded Spill
	umulh	x11, x12, x8
	str	x11, [sp, #280]         // 8-byte Folded Spill
	mul	 x11, x14, x8
	str	x11, [sp, #24]          // 8-byte Folded Spill
	umulh	x11, x14, x8
	str	x11, [sp, #200]         // 8-byte Folded Spill
	mul	 x25, x7, x8
	umulh	x11, x7, x8
	str	x11, [sp, #104]         // 8-byte Folded Spill
	mul	 x22, x9, x8
	umulh	x9, x9, x8
	str	x9, [sp, #56]           // 8-byte Folded Spill
	mul	 x20, x10, x8
	umulh	x26, x10, x8
	ldr	x10, [x2, #48]
	ldp	 x2, x8, [x1]
	ldr	x9, [x1, #16]
	ldp	x11, x1, [x1, #32]
	mul	 x27, x2, x10
	umulh	x21, x2, x10
	mul	 x5, x8, x10
	umulh	x19, x8, x10
	mul	 x3, x9, x10
	umulh	x7, x9, x10
	mul	 x2, x18, x10
	umulh	x6, x18, x10
	mul	 x17, x11, x10
	umulh	x4, x11, x10
	mul	 x16, x1, x10
	umulh	x1, x1, x10
	mul	 x15, x13, x10
	umulh	x18, x13, x10
	ldr	x8, [sp, #528]          // 8-byte Folded Reload
	str	 x8, [x0]
	ldr	x8, [sp, #304]          // 8-byte Folded Reload
	ldr	x9, [sp, #272]          // 8-byte Folded Reload
	adds	 x13, x9, x8
	ldr	x8, [sp, #368]          // 8-byte Folded Reload
	ldr	x9, [sp, #352]          // 8-byte Folded Reload
	adcs	x8, x9, x8
	ldr	x9, [sp, #456]          // 8-byte Folded Reload
	ldr	x10, [sp, #424]         // 8-byte Folded Reload
	adcs	x9, x10, x9
	ldr	x10, [sp, #512]         // 8-byte Folded Reload
	ldr	x11, [sp, #496]         // 8-byte Folded Reload
	adcs	x10, x11, x10
	ldr	x11, [sp, #568]         // 8-byte Folded Reload
	ldr	x12, [sp, #552]         // 8-byte Folded Reload
	adcs	x11, x12, x11
	ldr	x12, [sp, #608]         // 8-byte Folded Reload
	ldr	x14, [sp, #592]         // 8-byte Folded Reload
	adcs	x12, x14, x12
	ldr	x14, [sp, #616]         // 8-byte Folded Reload
	adcs	x14, x14, xzr
	ldr	x30, [sp, #96]          // 8-byte Folded Reload
	adds	 x13, x30, x13
	str	x13, [x0, #8]
	ldr	x13, [sp, #208]         // 8-byte Folded Reload
	adcs	x8, x13, x8
	ldr	x13, [sp, #408]         // 8-byte Folded Reload
	adcs	x9, x13, x9
	ldr	x13, [sp, #448]         // 8-byte Folded Reload
	adcs	x10, x13, x10
	ldr	x13, [sp, #488]         // 8-byte Folded Reload
	adcs	x11, x13, x11
	ldr	x13, [sp, #520]         // 8-byte Folded Reload
	adcs	x12, x13, x12
	ldr	x13, [sp, #560]         // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, xzr, xzr
	ldr	x30, [sp, #320]         // 8-byte Folded Reload
	adds	 x8, x8, x30
	ldr	x30, [sp, #400]         // 8-byte Folded Reload
	adcs	x9, x9, x30
	ldr	x30, [sp, #472]         // 8-byte Folded Reload
	adcs	x10, x10, x30
	ldr	x30, [sp, #504]         // 8-byte Folded Reload
	adcs	x11, x11, x30
	ldr	x30, [sp, #544]         // 8-byte Folded Reload
	adcs	x12, x12, x30
	ldr	x30, [sp, #576]         // 8-byte Folded Reload
	adcs	x13, x13, x30
	ldr	x30, [sp, #600]         // 8-byte Folded Reload
	adcs	x14, x14, x30
	ldr	x30, [sp, #248]         // 8-byte Folded Reload
	adds	 x8, x30, x8
	str	x8, [x0, #16]
	ldp	x30, x8, [sp, #128]
	adcs	x8, x8, x9
	ldr	x9, [sp, #192]          // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #240]         // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #296]         // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #344]         // 8-byte Folded Reload
	adcs	x12, x12, x13
	ldr	x13, [sp, #392]         // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, xzr, xzr
	adds	 x8, x8, x30
	ldr	x30, [sp, #184]         // 8-byte Folded Reload
	adcs	x9, x9, x30
	ldr	x30, [sp, #232]         // 8-byte Folded Reload
	adcs	x10, x10, x30
	ldr	x30, [sp, #288]         // 8-byte Folded Reload
	adcs	x11, x11, x30
	ldr	x30, [sp, #336]         // 8-byte Folded Reload
	adcs	x12, x12, x30
	ldr	x30, [sp, #384]         // 8-byte Folded Reload
	adcs	x13, x13, x30
	ldr	x30, [sp, #440]         // 8-byte Folded Reload
	adcs	x14, x14, x30
	adds	 x8, x28, x8
	str	x8, [x0, #24]
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, x9
	ldr	x9, [sp, #144]          // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #224]         // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #312]         // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #376]         // 8-byte Folded Reload
	adcs	x12, x12, x13
	ldr	x13, [sp, #464]         // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, xzr, xzr
	ldr	x28, [sp, #176]         // 8-byte Folded Reload
	adds	 x8, x8, x28
	ldr	x28, [sp, #264]         // 8-byte Folded Reload
	adcs	x9, x9, x28
	ldr	x28, [sp, #328]         // 8-byte Folded Reload
	adcs	x10, x10, x28
	ldr	x28, [sp, #416]         // 8-byte Folded Reload
	adcs	x11, x11, x28
	ldr	x28, [sp, #480]         // 8-byte Folded Reload
	adcs	x12, x12, x28
	ldr	x28, [sp, #536]         // 8-byte Folded Reload
	adcs	x13, x13, x28
	ldr	x28, [sp, #584]         // 8-byte Folded Reload
	adcs	x14, x14, x28
	ldr	x28, [sp, #48]          // 8-byte Folded Reload
	adds	 x8, x28, x8
	str	x8, [x0, #32]
	adcs	x8, x24, x9
	ldr	x9, [sp, #16]           // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #72]          // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #120]         // 8-byte Folded Reload
	adcs	x12, x12, x13
	ldr	x13, [sp, #168]         // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, xzr, xzr
	adds	 x8, x8, x23
	adcs	x9, x9, x29
	ldr	x23, [sp, #32]          // 8-byte Folded Reload
	adcs	x10, x10, x23
	ldr	x23, [sp, #64]          // 8-byte Folded Reload
	adcs	x11, x11, x23
	ldr	x23, [sp, #112]         // 8-byte Folded Reload
	adcs	x12, x12, x23
	ldr	x23, [sp, #160]         // 8-byte Folded Reload
	adcs	x13, x13, x23
	ldr	x23, [sp, #216]         // 8-byte Folded Reload
	adcs	x14, x14, x23
	adds	 x8, x20, x8
	str	x8, [x0, #40]
	adcs	x8, x22, x9
	adcs	x9, x25, x10
	ldr	x10, [sp, #24]          // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #88]          // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #152]         // 8-byte Folded Reload
	adcs	x12, x12, x13
	ldr	x13, [sp, #256]         // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, xzr, xzr
	adds	 x8, x8, x26
	ldr	x20, [sp, #56]          // 8-byte Folded Reload
	adcs	x9, x9, x20
	ldr	x20, [sp, #104]         // 8-byte Folded Reload
	adcs	x10, x10, x20
	ldr	x20, [sp, #200]         // 8-byte Folded Reload
	adcs	x11, x11, x20
	ldr	x20, [sp, #280]         // 8-byte Folded Reload
	adcs	x12, x12, x20
	ldr	x20, [sp, #360]         // 8-byte Folded Reload
	adcs	x13, x13, x20
	ldr	x20, [sp, #432]         // 8-byte Folded Reload
	adcs	x14, x14, x20
	adds	 x8, x27, x8
	str	x8, [x0, #48]
	adcs	x8, x5, x9
	adcs	x9, x3, x10
	adcs	x10, x2, x11
	adcs	x11, x17, x12
	adcs	x12, x16, x13
	adcs	x13, x15, x14
	adcs	x14, xzr, xzr
	adds	 x8, x8, x21
	str	x8, [x0, #56]
	adcs	x8, x9, x19
	str	x8, [x0, #64]
	adcs	x8, x10, x7
	str	x8, [x0, #72]
	adcs	x8, x11, x6
	str	x8, [x0, #80]
	adcs	x8, x12, x4
	str	x8, [x0, #88]
	adcs	x8, x13, x1
	str	x8, [x0, #96]
	adcs	x8, x14, x18
	str	x8, [x0, #104]
	add	sp, sp, #624            // =624
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end96:
	.size	mcl_fpDbl_mulPre7L, .Lfunc_end96-mcl_fpDbl_mulPre7L

	.globl	mcl_fpDbl_sqrPre7L
	.align	2
	.type	mcl_fpDbl_sqrPre7L,@function
mcl_fpDbl_sqrPre7L:                     // @mcl_fpDbl_sqrPre7L
// BB#0:
	stp	x24, x23, [sp, #-48]!
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	ldp	 x11, x8, [x1]
	ldp	x9, x10, [x1, #40]
	ldp	x15, x12, [x1, #16]
	ldp	x16, x3, [x1, #16]
	ldp	x13, x14, [x1, #32]
	ldp	x18, x17, [x1, #32]
	ldr	x2, [x1, #32]
	mul	 x4, x11, x11
	umulh	x5, x10, x11
	mul	 x6, x9, x11
	mul	 x7, x18, x11
	mul	 x19, x3, x11
	umulh	x20, x16, x11
	mul	 x21, x16, x11
	umulh	x22, x8, x11
	mul	 x23, x8, x11
	str	 x4, [x0]
	umulh	x4, x11, x11
	adds	 x4, x4, x23
	adcs	x21, x22, x21
	adcs	x19, x20, x19
	umulh	x20, x3, x11
	adcs	x7, x20, x7
	umulh	x20, x18, x11
	adcs	x6, x20, x6
	mul	 x20, x10, x11
	umulh	x11, x9, x11
	adcs	x20, x11, x20
	adcs	x5, x5, xzr
	adds	 x4, x23, x4
	ldp	x11, x23, [x1, #40]
	str	x4, [x0, #8]
	mul	 x4, x8, x8
	adcs	x4, x4, x21
	mul	 x21, x16, x8
	adcs	x19, x21, x19
	mul	 x21, x3, x8
	adcs	x7, x21, x7
	mul	 x21, x18, x8
	adcs	x6, x21, x6
	mul	 x21, x9, x8
	adcs	x20, x21, x20
	mul	 x21, x10, x8
	umulh	x10, x10, x8
	umulh	x9, x9, x8
	umulh	x18, x18, x8
	umulh	x3, x3, x8
	umulh	x16, x16, x8
	umulh	x8, x8, x8
	adcs	x5, x21, x5
	adcs	x21, xzr, xzr
	adds	 x4, x4, x22
	adcs	x8, x19, x8
	ldp	 x19, x22, [x1]
	adcs	x16, x7, x16
	adcs	x3, x6, x3
	ldp	x6, x7, [x1, #8]
	adcs	x18, x20, x18
	mul	 x20, x19, x15
	adcs	x9, x5, x9
	mul	 x5, x23, x15
	adcs	x10, x21, x10
	mul	 x21, x14, x15
	adds	 x4, x20, x4
	mul	 x20, x13, x15
	str	x4, [x0, #16]
	mul	 x4, x6, x15
	adcs	x8, x4, x8
	mul	 x4, x15, x15
	adcs	x16, x4, x16
	mul	 x4, x12, x15
	adcs	x3, x4, x3
	adcs	x18, x20, x18
	umulh	x20, x13, x15
	adcs	x9, x21, x9
	umulh	x21, x19, x15
	adcs	x10, x5, x10
	adcs	x5, xzr, xzr
	adds	 x8, x8, x21
	umulh	x21, x6, x15
	adcs	x16, x16, x21
	umulh	x21, x15, x15
	adcs	x3, x3, x21
	umulh	x21, x12, x15
	adcs	x18, x18, x21
	adcs	x9, x9, x20
	umulh	x20, x14, x15
	adcs	x10, x10, x20
	umulh	x15, x23, x15
	adcs	x15, x5, x15
	mul	 x5, x19, x12
	adds	 x8, x5, x8
	ldr	x5, [x1, #32]
	str	x8, [x0, #24]
	mul	 x8, x6, x12
	adcs	x8, x8, x16
	ldr	 x16, [x1]
	adcs	x3, x4, x3
	mul	 x4, x12, x12
	adcs	x18, x4, x18
	mul	 x4, x13, x12
	adcs	x9, x4, x9
	mul	 x4, x14, x12
	adcs	x10, x4, x10
	mul	 x4, x23, x12
	umulh	x19, x19, x12
	adcs	x15, x4, x15
	adcs	x4, xzr, xzr
	adds	 x8, x8, x19
	ldr	x19, [x1, #24]
	umulh	x6, x6, x12
	adcs	x3, x3, x6
	ldr	x6, [x1, #48]
	adcs	x18, x18, x21
	ldr	x20, [x1, #48]
	umulh	x21, x23, x12
	umulh	x14, x14, x12
	umulh	x13, x13, x12
	umulh	x12, x12, x12
	adcs	x9, x9, x12
	adcs	x10, x10, x13
	ldp	 x12, x13, [x1]
	adcs	x14, x15, x14
	mul	 x15, x16, x5
	adcs	x4, x4, x21
	mul	 x21, x6, x5
	adds	 x8, x15, x8
	mul	 x15, x17, x5
	str	x8, [x0, #32]
	mul	 x8, x22, x5
	adcs	x8, x8, x3
	mul	 x3, x7, x5
	adcs	x18, x3, x18
	mul	 x3, x19, x5
	adcs	x9, x3, x9
	mul	 x3, x5, x5
	adcs	x10, x3, x10
	umulh	x3, x16, x5
	adcs	x14, x15, x14
	adcs	x4, x21, x4
	adcs	x21, xzr, xzr
	adds	 x8, x8, x3
	umulh	x3, x22, x5
	adcs	x18, x18, x3
	umulh	x3, x7, x5
	adcs	x9, x9, x3
	umulh	x3, x19, x5
	adcs	x10, x10, x3
	umulh	x3, x5, x5
	adcs	x14, x14, x3
	umulh	x3, x6, x5
	umulh	x5, x17, x5
	adcs	x4, x4, x5
	adcs	x3, x21, x3
	mul	 x21, x16, x17
	adds	 x8, x21, x8
	ldp	x21, x1, [x1, #16]
	str	x8, [x0, #40]
	mul	 x8, x22, x17
	adcs	x8, x8, x18
	mul	 x18, x7, x17
	adcs	x9, x18, x9
	mul	 x18, x19, x17
	adcs	x10, x18, x10
	mul	 x18, x6, x17
	adcs	x14, x15, x14
	mul	 x15, x17, x17
	umulh	x6, x6, x17
	umulh	x19, x19, x17
	umulh	x7, x7, x17
	umulh	x22, x22, x17
	umulh	x16, x16, x17
	umulh	x17, x17, x17
	adcs	x15, x15, x4
	mul	 x4, x12, x20
	adcs	x18, x18, x3
	adcs	x3, xzr, xzr
	adds	 x8, x8, x16
	mul	 x16, x11, x20
	adcs	x9, x9, x22
	mul	 x22, x2, x20
	adcs	x10, x10, x7
	mul	 x7, x1, x20
	adcs	x14, x14, x19
	mul	 x19, x21, x20
	adcs	x15, x15, x5
	mul	 x5, x13, x20
	adcs	x17, x18, x17
	mul	 x18, x20, x20
	umulh	x12, x12, x20
	umulh	x13, x13, x20
	umulh	x21, x21, x20
	umulh	x1, x1, x20
	umulh	x2, x2, x20
	umulh	x11, x11, x20
	umulh	x20, x20, x20
	adcs	x3, x3, x6
	adds	 x8, x4, x8
	str	x8, [x0, #48]
	adcs	x8, x5, x9
	adcs	x9, x19, x10
	adcs	x10, x7, x14
	adcs	x14, x22, x15
	adcs	x15, x16, x17
	adcs	x16, x18, x3
	adcs	x17, xzr, xzr
	adds	 x8, x8, x12
	str	x8, [x0, #56]
	adcs	x8, x9, x13
	str	x8, [x0, #64]
	adcs	x8, x10, x21
	str	x8, [x0, #72]
	adcs	x8, x14, x1
	str	x8, [x0, #80]
	adcs	x8, x15, x2
	str	x8, [x0, #88]
	adcs	x8, x16, x11
	str	x8, [x0, #96]
	adcs	x8, x17, x20
	str	x8, [x0, #104]
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #48
	ret
.Lfunc_end97:
	.size	mcl_fpDbl_sqrPre7L, .Lfunc_end97-mcl_fpDbl_sqrPre7L

	.globl	mcl_fp_mont7L
	.align	2
	.type	mcl_fp_mont7L,@function
mcl_fp_mont7L:                          // @mcl_fp_mont7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #144            // =144
	str	x2, [sp, #112]          // 8-byte Folded Spill
	str	x0, [sp, #64]           // 8-byte Folded Spill
	ldr	 x6, [x2]
	ldr	x15, [x1, #48]
	str	x15, [sp, #96]          // 8-byte Folded Spill
	ldr	x0, [x1, #32]
	str	x0, [sp, #56]           // 8-byte Folded Spill
	ldr	x18, [x1, #40]
	ldp	x11, x13, [x1, #16]
	ldp	 x17, x5, [x1]
	str	x5, [sp, #88]           // 8-byte Folded Spill
	ldur	x12, [x3, #-8]
	str	x12, [sp, #128]         // 8-byte Folded Spill
	ldr	x1, [x3, #32]
	str	x1, [sp, #104]          // 8-byte Folded Spill
	ldr	x9, [x3, #40]
	str	x9, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [x3, #16]
	str	x8, [sp, #136]          // 8-byte Folded Spill
	ldr	x10, [x3, #24]
	str	x10, [sp, #120]         // 8-byte Folded Spill
	ldr	 x14, [x3]
	str	x14, [sp, #24]          // 8-byte Folded Spill
	ldr	x4, [x3, #8]
	str	x4, [sp, #72]           // 8-byte Folded Spill
	ldr	x7, [x2, #8]
	umulh	x19, x15, x6
	mul	 x20, x15, x6
	umulh	x21, x18, x6
	mul	 x22, x18, x6
	mov	 x15, x0
	umulh	x23, x15, x6
	mul	 x24, x15, x6
	mov	 x16, x13
	umulh	x25, x16, x6
	mul	 x26, x16, x6
	mov	 x13, x11
	umulh	x27, x13, x6
	mul	 x28, x13, x6
	mul	 x29, x5, x6
	mov	 x11, x17
	umulh	x30, x11, x6
	adds	 x29, x30, x29
	umulh	x30, x5, x6
	mul	 x6, x11, x6
	adcs	x28, x30, x28
	mul	 x30, x6, x12
	adcs	x26, x27, x26
	mul	 x27, x30, x10
	adcs	x24, x25, x24
	mul	 x25, x30, x8
	adcs	x22, x23, x22
	mul	 x23, x30, x4
	adcs	x20, x21, x20
	umulh	x21, x30, x14
	adcs	x19, x19, xzr
	adds	 x21, x21, x23
	umulh	x23, x30, x4
	adcs	x23, x23, x25
	umulh	x25, x30, x8
	adcs	x25, x25, x27
	mul	 x27, x30, x1
	umulh	x17, x30, x10
	adcs	x17, x17, x27
	ldr	x3, [x3, #48]
	str	x3, [sp, #48]           // 8-byte Folded Spill
	mul	 x27, x30, x9
	umulh	x0, x30, x1
	adcs	x0, x0, x27
	mul	 x27, x30, x3
	umulh	x2, x30, x9
	adcs	x2, x2, x27
	umulh	x27, x30, x3
	mul	 x30, x30, x14
	adcs	x27, x27, xzr
	cmn	 x30, x6
	adcs	x6, x21, x29
	adcs	x21, x23, x28
	mul	 x23, x7, x15
	adcs	x25, x25, x26
	mul	 x26, x7, x16
	adcs	x17, x17, x24
	mul	 x24, x7, x13
	adcs	x0, x0, x22
	mul	 x22, x7, x5
	adcs	x2, x2, x20
	umulh	x20, x7, x11
	adcs	x19, x27, x19
	adcs	x27, xzr, xzr
	adds	 x20, x20, x22
	umulh	x22, x7, x5
	adcs	x22, x22, x24
	umulh	x24, x7, x13
	mov	 x5, x13
	adcs	x24, x24, x26
	umulh	x26, x7, x16
	adcs	x23, x26, x23
	mul	 x26, x7, x18
	umulh	x28, x7, x15
	adcs	x26, x28, x26
	ldr	x15, [sp, #96]          // 8-byte Folded Reload
	mul	 x28, x7, x15
	umulh	x29, x7, x18
	adcs	x28, x29, x28
	umulh	x29, x7, x15
	mul	 x7, x7, x11
	adcs	x29, x29, xzr
	adds	 x30, x6, x7
	adcs	x6, x21, x20
	adcs	x25, x25, x22
	mul	 x22, x30, x12
	adcs	x24, x17, x24
	mul	 x17, x22, x10
	adcs	x0, x0, x23
	mul	 x23, x22, x8
	adcs	x7, x2, x26
	mul	 x2, x22, x4
	adcs	x20, x19, x28
	umulh	x26, x22, x14
	adcs	x21, x27, x29
	adcs	x19, xzr, xzr
	adds	 x2, x26, x2
	umulh	x26, x22, x4
	adcs	x23, x26, x23
	umulh	x26, x22, x8
	adcs	x17, x26, x17
	mul	 x26, x22, x1
	umulh	x27, x22, x10
	adcs	x26, x27, x26
	mul	 x27, x22, x9
	umulh	x28, x22, x1
	adcs	x27, x28, x27
	mul	 x28, x22, x3
	umulh	x29, x22, x9
	adcs	x28, x29, x28
	umulh	x29, x22, x3
	mul	 x22, x22, x14
	mov	 x10, x14
	adcs	x29, x29, xzr
	cmn	 x22, x30
	adcs	x22, x2, x6
	adcs	x23, x23, x25
	ldr	x8, [sp, #112]          // 8-byte Folded Reload
	adcs	x24, x17, x24
	ldp	x25, x17, [x8, #16]
	adcs	x0, x26, x0
	mul	 x2, x25, x16
	adcs	x6, x27, x7
	mul	 x7, x25, x5
	adcs	x20, x28, x20
	ldp	x15, x8, [sp, #88]
	mul	 x26, x25, x15
	adcs	x21, x29, x21
	mov	 x12, x11
	umulh	x27, x25, x12
	adcs	x19, x19, xzr
	adds	 x26, x27, x26
	umulh	x27, x25, x15
	adcs	x7, x27, x7
	umulh	x27, x25, x5
	mov	 x9, x5
	adcs	x2, x27, x2
	ldr	x11, [sp, #56]          // 8-byte Folded Reload
	mul	 x27, x25, x11
	umulh	x28, x25, x16
	mov	 x13, x16
	adcs	x27, x28, x27
	mul	 x28, x25, x18
	umulh	x29, x25, x11
	adcs	x28, x29, x28
	mul	 x29, x25, x8
	umulh	x30, x25, x18
	adcs	x29, x30, x29
	umulh	x30, x25, x8
	mov	 x14, x8
	mul	 x25, x25, x12
	mov	 x5, x12
	adcs	x30, x30, xzr
	adds	 x22, x22, x25
	adcs	x23, x23, x26
	adcs	x7, x24, x7
	adcs	x0, x0, x2
	ldp	x8, x12, [sp, #128]
	mul	 x2, x22, x8
	adcs	x6, x6, x27
	mul	 x24, x2, x12
	adcs	x20, x20, x28
	mul	 x25, x2, x4
	adcs	x21, x21, x29
	mov	 x1, x10
	umulh	x26, x2, x1
	adcs	x19, x19, x30
	adcs	x27, xzr, xzr
	adds	 x25, x26, x25
	umulh	x26, x2, x4
	adcs	x24, x26, x24
	ldr	x10, [sp, #120]         // 8-byte Folded Reload
	mul	 x26, x2, x10
	umulh	x28, x2, x12
	adcs	x26, x28, x26
	ldr	x12, [sp, #104]         // 8-byte Folded Reload
	mul	 x28, x2, x12
	umulh	x29, x2, x10
	adcs	x28, x29, x28
	ldr	x10, [sp, #80]          // 8-byte Folded Reload
	mul	 x29, x2, x10
	umulh	x30, x2, x12
	adcs	x29, x30, x29
	mul	 x30, x2, x3
	umulh	x12, x2, x10
	adcs	x12, x12, x30
	umulh	x30, x2, x3
	mul	 x2, x2, x1
	adcs	x30, x30, xzr
	cmn	 x2, x22
	adcs	x2, x25, x23
	adcs	x7, x24, x7
	adcs	x0, x26, x0
	mul	 x22, x17, x11
	adcs	x6, x28, x6
	mul	 x23, x17, x13
	adcs	x20, x29, x20
	mul	 x24, x17, x9
	adcs	x12, x12, x21
	mul	 x21, x17, x15
	adcs	x19, x30, x19
	umulh	x25, x17, x5
	adcs	x26, x27, xzr
	adds	 x21, x25, x21
	umulh	x25, x17, x15
	adcs	x24, x25, x24
	umulh	x25, x17, x9
	mov	 x16, x9
	adcs	x23, x25, x23
	umulh	x25, x17, x13
	adcs	x22, x25, x22
	mul	 x25, x17, x18
	umulh	x27, x17, x11
	adcs	x25, x27, x25
	mov	 x9, x14
	mul	 x27, x17, x9
	umulh	x28, x17, x18
	adcs	x27, x28, x27
	umulh	x28, x17, x9
	mul	 x17, x17, x5
	mov	 x15, x5
	adcs	x28, x28, xzr
	adds	 x17, x2, x17
	adcs	x2, x7, x21
	adcs	x0, x0, x24
	mul	 x24, x17, x8
	adcs	x29, x6, x23
	ldr	x9, [sp, #120]          // 8-byte Folded Reload
	mul	 x23, x24, x9
	adcs	x6, x20, x22
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	mul	 x22, x24, x8
	adcs	x7, x12, x25
	mul	 x12, x24, x4
	adcs	x20, x19, x27
	umulh	x25, x24, x1
	adcs	x21, x26, x28
	adcs	x19, xzr, xzr
	adds	 x12, x25, x12
	umulh	x25, x24, x4
	adcs	x25, x25, x22
	umulh	x22, x24, x8
	adcs	x26, x22, x23
	ldr	x5, [sp, #104]          // 8-byte Folded Reload
	mul	 x22, x24, x5
	umulh	x23, x24, x9
	adcs	x27, x23, x22
	mov	 x9, x10
	mul	 x22, x24, x9
	umulh	x23, x24, x5
	adcs	x28, x23, x22
	mul	 x22, x24, x3
	umulh	x23, x24, x9
	adcs	x30, x23, x22
	umulh	x22, x24, x3
	mul	 x23, x24, x1
	mov	 x3, x1
	adcs	x24, x22, xzr
	cmn	 x23, x17
	adcs	x22, x12, x2
	adcs	x23, x25, x0
	ldr	x10, [sp, #112]         // 8-byte Folded Reload
	ldp	x12, x0, [x10, #32]
	adcs	x17, x26, x29
	adcs	x2, x27, x6
	mul	 x6, x12, x13
	adcs	x7, x28, x7
	mov	 x10, x16
	mul	 x25, x12, x10
	adcs	x20, x30, x20
	ldr	x16, [sp, #88]          // 8-byte Folded Reload
	mul	 x26, x12, x16
	adcs	x21, x24, x21
	umulh	x24, x12, x15
	adcs	x1, x19, xzr
	adds	 x24, x24, x26
	umulh	x26, x12, x16
	adcs	x25, x26, x25
	umulh	x26, x12, x10
	adcs	x6, x26, x6
	mul	 x26, x12, x11
	umulh	x27, x12, x13
	adcs	x26, x27, x26
	mul	 x27, x12, x18
	umulh	x28, x12, x11
	adcs	x27, x28, x27
	mul	 x28, x12, x14
	umulh	x29, x12, x18
	adcs	x28, x29, x28
	umulh	x29, x12, x14
	mul	 x12, x12, x15
	adcs	x29, x29, xzr
	adds	 x12, x22, x12
	adcs	x22, x23, x24
	adcs	x17, x17, x25
	adcs	x2, x2, x6
	ldr	x19, [sp, #128]         // 8-byte Folded Reload
	mul	 x6, x12, x19
	adcs	x7, x7, x26
	mov	 x30, x8
	mul	 x23, x6, x30
	adcs	x20, x20, x27
	mul	 x24, x6, x4
	adcs	x21, x21, x28
	mov	 x8, x3
	umulh	x25, x6, x8
	adcs	x1, x1, x29
	adcs	x26, xzr, xzr
	adds	 x24, x25, x24
	umulh	x25, x6, x4
	adcs	x23, x25, x23
	ldr	x4, [sp, #120]          // 8-byte Folded Reload
	mul	 x25, x6, x4
	umulh	x27, x6, x30
	adcs	x25, x27, x25
	mul	 x27, x6, x5
	umulh	x28, x6, x4
	adcs	x27, x28, x27
	mov	 x3, x9
	mul	 x28, x6, x3
	umulh	x29, x6, x5
	adcs	x28, x29, x28
	ldr	x9, [sp, #48]           // 8-byte Folded Reload
	mul	 x29, x6, x9
	umulh	x30, x6, x3
	adcs	x29, x30, x29
	umulh	x30, x6, x9
	mov	 x3, x9
	mul	 x6, x6, x8
	mov	 x5, x8
	adcs	x30, x30, xzr
	cmn	 x6, x12
	adcs	x12, x24, x22
	adcs	x17, x23, x17
	adcs	x2, x25, x2
	mul	 x6, x0, x11
	adcs	x7, x27, x7
	mul	 x22, x0, x13
	adcs	x20, x28, x20
	mul	 x23, x0, x10
	adcs	x21, x29, x21
	mul	 x24, x0, x16
	adcs	x29, x30, x1
	mov	 x1, x15
	umulh	x25, x0, x1
	adcs	x26, x26, xzr
	adds	 x24, x25, x24
	umulh	x25, x0, x16
	adcs	x23, x25, x23
	umulh	x25, x0, x10
	adcs	x22, x25, x22
	umulh	x25, x0, x13
	adcs	x6, x25, x6
	mul	 x25, x0, x18
	umulh	x27, x0, x11
	adcs	x25, x27, x25
	mov	 x9, x14
	mul	 x27, x0, x9
	umulh	x28, x0, x18
	adcs	x27, x28, x27
	umulh	x28, x0, x9
	mul	 x0, x0, x1
	adcs	x28, x28, xzr
	adds	 x12, x12, x0
	adcs	x8, x17, x24
	str	x8, [sp, #40]           // 8-byte Folded Spill
	adcs	x8, x2, x23
	str	x8, [sp, #32]           // 8-byte Folded Spill
	mul	 x2, x12, x19
	adcs	x7, x7, x22
	mul	 x22, x2, x4
	adcs	x8, x20, x6
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	mul	 x20, x2, x8
	adcs	x21, x21, x25
	ldr	x9, [sp, #72]           // 8-byte Folded Reload
	mul	 x23, x2, x9
	adcs	x19, x29, x27
	mov	 x15, x5
	umulh	x24, x2, x15
	adcs	x17, x26, x28
	str	x17, [sp, #8]           // 8-byte Folded Spill
	adcs	x26, xzr, xzr
	adds	 x23, x24, x23
	umulh	x24, x2, x9
	adcs	x20, x24, x20
	umulh	x24, x2, x8
	adcs	x22, x24, x22
	ldp	x25, x8, [sp, #104]
	mul	 x24, x2, x25
	umulh	x27, x2, x4
	adcs	x6, x27, x24
	ldr	x5, [sp, #80]           // 8-byte Folded Reload
	mul	 x27, x2, x5
	umulh	x28, x2, x25
	adcs	x27, x28, x27
	mul	 x28, x2, x3
	umulh	x29, x2, x5
	adcs	x28, x29, x28
	ldr	x29, [x8, #48]
	mul	 x30, x2, x15
	umulh	x2, x2, x3
	adcs	x2, x2, xzr
	cmn	 x30, x12
	umulh	x24, x29, x14
	mul	 x30, x29, x14
	umulh	x0, x29, x18
	mul	 x18, x29, x18
	umulh	x17, x29, x11
	mul	 x15, x29, x11
	umulh	x14, x29, x13
	mul	 x13, x29, x13
	umulh	x12, x29, x10
	mul	 x11, x29, x10
	mul	 x10, x29, x16
	umulh	x9, x29, x16
	umulh	x8, x29, x1
	mul	 x29, x29, x1
	ldr	x16, [sp, #40]          // 8-byte Folded Reload
	adcs	x23, x23, x16
	ldr	x16, [sp, #32]          // 8-byte Folded Reload
	adcs	x20, x20, x16
	adcs	x7, x22, x7
	ldr	x16, [sp, #16]          // 8-byte Folded Reload
	adcs	x6, x6, x16
	adcs	x21, x27, x21
	adcs	x19, x28, x19
	ldr	x16, [sp, #8]           // 8-byte Folded Reload
	adcs	x2, x2, x16
	adcs	x22, x26, xzr
	adds	 x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, x12, x13
	adcs	x11, x14, x15
	adcs	x12, x17, x18
	adcs	x13, x0, x30
	adcs	x14, x24, xzr
	adds	 x15, x23, x29
	adcs	x8, x20, x8
	ldr	x16, [sp, #128]         // 8-byte Folded Reload
	mul	 x16, x15, x16
	adcs	x9, x7, x9
	mul	 x17, x16, x3
	mul	 x18, x16, x5
	mul	 x0, x16, x25
	adcs	x10, x6, x10
	mul	 x6, x16, x4
	adcs	x11, x21, x11
	ldr	x21, [sp, #136]         // 8-byte Folded Reload
	mul	 x7, x16, x21
	adcs	x12, x19, x12
	ldr	x23, [sp, #72]          // 8-byte Folded Reload
	mul	 x19, x16, x23
	adcs	x13, x2, x13
	ldr	x24, [sp, #24]          // 8-byte Folded Reload
	umulh	x2, x16, x24
	adcs	x14, x22, x14
	adcs	x20, xzr, xzr
	adds	 x2, x2, x19
	umulh	x19, x16, x23
	adcs	x7, x19, x7
	umulh	x19, x16, x21
	adcs	x6, x19, x6
	umulh	x19, x16, x4
	adcs	x0, x19, x0
	umulh	x19, x16, x25
	adcs	x18, x19, x18
	umulh	x19, x16, x5
	adcs	x17, x19, x17
	umulh	x19, x16, x3
	mul	 x16, x16, x24
	adcs	x19, x19, xzr
	cmn	 x16, x15
	adcs	x8, x2, x8
	adcs	x9, x7, x9
	adcs	x10, x6, x10
	adcs	x11, x0, x11
	adcs	x12, x18, x12
	adcs	x13, x17, x13
	adcs	x14, x19, x14
	adcs	x15, x20, xzr
	subs	 x16, x8, x24
	sbcs	x17, x9, x23
	sbcs	x18, x10, x21
	sbcs	x0, x11, x4
	sbcs	x1, x12, x25
	sbcs	x2, x13, x5
	sbcs	x3, x14, x3
	sbcs	x15, x15, xzr
	tst	 x15, #0x1
	csel	x8, x8, x16, ne
	csel	x9, x9, x17, ne
	csel	x10, x10, x18, ne
	csel	x11, x11, x0, ne
	csel	x12, x12, x1, ne
	csel	x13, x13, x2, ne
	csel	x14, x14, x3, ne
	ldr	x15, [sp, #64]          // 8-byte Folded Reload
	stp	 x8, x9, [x15]
	stp	x10, x11, [x15, #16]
	stp	x12, x13, [x15, #32]
	str	x14, [x15, #48]
	add	sp, sp, #144            // =144
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end98:
	.size	mcl_fp_mont7L, .Lfunc_end98-mcl_fp_mont7L

	.globl	mcl_fp_montNF7L
	.align	2
	.type	mcl_fp_montNF7L,@function
mcl_fp_montNF7L:                        // @mcl_fp_montNF7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	sub	sp, sp, #32             // =32
	stp	x0, x2, [sp, #8]
	ldr	 x7, [x2]
	ldp	x5, x16, [x1, #40]
	ldp	x6, x17, [x1, #24]
	ldr	 x4, [x1]
	ldp	x1, x18, [x1, #8]
	ldur	x8, [x3, #-8]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x15, x0, [x3, #40]
	ldp	x11, x10, [x3, #24]
	ldp	x13, x12, [x3, #8]
	ldr	 x14, [x3]
	ldr	x25, [x2, #8]
	umulh	x3, x16, x7
	mul	 x19, x16, x7
	umulh	x20, x5, x7
	mul	 x21, x5, x7
	umulh	x22, x17, x7
	mul	 x23, x17, x7
	umulh	x24, x6, x7
	mul	 x26, x6, x7
	umulh	x27, x18, x7
	mul	 x28, x18, x7
	mul	 x29, x1, x7
	umulh	x30, x4, x7
	adds	 x29, x30, x29
	umulh	x30, x1, x7
	mul	 x7, x4, x7
	adcs	x28, x30, x28
	mul	 x30, x25, x5
	adcs	x26, x27, x26
	mul	 x27, x25, x17
	adcs	x23, x24, x23
	mul	 x24, x25, x6
	adcs	x21, x22, x21
	mul	 x22, x7, x8
	adcs	x19, x20, x19
	mul	 x20, x22, x14
	adcs	x3, x3, xzr
	cmn	 x20, x7
	mul	 x9, x25, x18
	mul	 x7, x22, x13
	adcs	x7, x7, x29
	mul	 x20, x22, x12
	adcs	x20, x20, x28
	mul	 x28, x22, x11
	adcs	x26, x28, x26
	mul	 x28, x22, x10
	adcs	x23, x28, x23
	mul	 x28, x22, x15
	adcs	x21, x28, x21
	mul	 x28, x22, x0
	adcs	x19, x28, x19
	umulh	x28, x22, x14
	adcs	x29, x3, xzr
	adds	 x28, x7, x28
	umulh	x3, x22, x13
	adcs	x8, x20, x3
	umulh	x3, x22, x12
	adcs	x26, x26, x3
	umulh	x3, x22, x11
	adcs	x3, x23, x3
	umulh	x7, x22, x10
	adcs	x7, x21, x7
	umulh	x20, x22, x15
	adcs	x19, x19, x20
	mul	 x21, x25, x1
	umulh	x20, x22, x0
	adcs	x20, x29, x20
	umulh	x22, x25, x4
	adds	 x29, x22, x21
	umulh	x21, x25, x1
	adcs	x23, x21, x9
	umulh	x9, x25, x18
	adcs	x21, x9, x24
	umulh	x9, x25, x6
	adcs	x22, x9, x27
	umulh	x9, x25, x17
	adcs	x30, x9, x30
	mul	 x9, x25, x16
	umulh	x24, x25, x5
	adcs	x24, x24, x9
	umulh	x9, x25, x16
	mul	 x25, x25, x4
	adcs	x9, x9, xzr
	adds	 x27, x25, x28
	adcs	x25, x29, x8
	ldp	x28, x8, [x2, #16]
	adcs	x29, x23, x26
	adcs	x3, x21, x3
	mul	 x21, x28, x17
	adcs	x7, x22, x7
	mul	 x22, x28, x6
	adcs	x19, x30, x19
	ldr	x2, [sp, #24]           // 8-byte Folded Reload
	mul	 x23, x27, x2
	adcs	x20, x24, x20
	mul	 x24, x23, x14
	adcs	x9, x9, xzr
	cmn	 x24, x27
	mul	 x24, x28, x18
	mul	 x26, x23, x13
	adcs	x25, x26, x25
	mul	 x26, x23, x12
	adcs	x26, x26, x29
	mul	 x27, x23, x11
	adcs	x3, x27, x3
	mul	 x27, x23, x10
	adcs	x7, x27, x7
	mul	 x27, x23, x15
	adcs	x19, x27, x19
	mul	 x27, x23, x0
	adcs	x20, x27, x20
	umulh	x27, x23, x14
	adcs	x9, x9, xzr
	adds	 x25, x25, x27
	umulh	x27, x23, x13
	adcs	x26, x26, x27
	umulh	x27, x23, x12
	adcs	x3, x3, x27
	umulh	x27, x23, x11
	adcs	x7, x7, x27
	umulh	x27, x23, x10
	adcs	x19, x19, x27
	umulh	x27, x23, x15
	adcs	x20, x20, x27
	mul	 x27, x28, x1
	umulh	x23, x23, x0
	adcs	x9, x9, x23
	umulh	x23, x28, x4
	adds	 x23, x23, x27
	umulh	x27, x28, x1
	adcs	x24, x27, x24
	umulh	x27, x28, x18
	adcs	x22, x27, x22
	umulh	x27, x28, x6
	adcs	x21, x27, x21
	mul	 x27, x28, x5
	umulh	x29, x28, x17
	adcs	x27, x29, x27
	mul	 x29, x28, x16
	umulh	x30, x28, x5
	adcs	x29, x30, x29
	umulh	x30, x28, x16
	mul	 x28, x28, x4
	adcs	x30, x30, xzr
	adds	 x25, x28, x25
	adcs	x23, x23, x26
	adcs	x3, x24, x3
	mul	 x26, x8, x5
	adcs	x7, x22, x7
	mul	 x22, x8, x17
	adcs	x19, x21, x19
	mul	 x24, x8, x6
	adcs	x20, x27, x20
	mul	 x21, x25, x2
	adcs	x9, x29, x9
	mul	 x27, x21, x14
	adcs	x28, x30, xzr
	cmn	 x27, x25
	mul	 x25, x8, x18
	mul	 x27, x21, x13
	adcs	x23, x27, x23
	mul	 x27, x21, x12
	adcs	x3, x27, x3
	mul	 x27, x21, x11
	adcs	x7, x27, x7
	mul	 x27, x21, x10
	adcs	x19, x27, x19
	mul	 x27, x21, x15
	adcs	x20, x27, x20
	mul	 x27, x21, x0
	adcs	x9, x27, x9
	umulh	x27, x21, x14
	adcs	x28, x28, xzr
	adds	 x27, x23, x27
	umulh	x23, x21, x13
	adcs	x3, x3, x23
	umulh	x23, x21, x12
	adcs	x30, x7, x23
	umulh	x7, x21, x11
	adcs	x7, x19, x7
	umulh	x19, x21, x10
	adcs	x19, x20, x19
	umulh	x20, x21, x15
	adcs	x20, x9, x20
	mul	 x9, x8, x1
	umulh	x21, x21, x0
	adcs	x21, x28, x21
	umulh	x23, x8, x4
	adds	 x9, x23, x9
	umulh	x23, x8, x1
	adcs	x28, x23, x25
	umulh	x23, x8, x18
	adcs	x23, x23, x24
	umulh	x24, x8, x6
	adcs	x24, x24, x22
	umulh	x22, x8, x17
	adcs	x25, x22, x26
	mul	 x22, x8, x16
	umulh	x26, x8, x5
	adcs	x26, x26, x22
	umulh	x22, x8, x16
	mul	 x29, x8, x4
	adcs	x2, x22, xzr
	adds	 x29, x29, x27
	adcs	x27, x9, x3
	ldr	x8, [sp, #16]           // 8-byte Folded Reload
	ldp	x22, x3, [x8, #32]
	adcs	x9, x28, x30
	adcs	x7, x23, x7
	mul	 x23, x22, x17
	adcs	x19, x24, x19
	mul	 x24, x22, x6
	adcs	x20, x25, x20
	ldr	x8, [sp, #24]           // 8-byte Folded Reload
	mul	 x25, x29, x8
	adcs	x21, x26, x21
	mul	 x26, x25, x14
	adcs	x2, x2, xzr
	cmn	 x26, x29
	mul	 x26, x22, x18
	mul	 x28, x25, x13
	adcs	x27, x28, x27
	mul	 x28, x25, x12
	adcs	x9, x28, x9
	mul	 x28, x25, x11
	adcs	x7, x28, x7
	mul	 x28, x25, x10
	adcs	x19, x28, x19
	mul	 x28, x25, x15
	adcs	x20, x28, x20
	mul	 x28, x25, x0
	adcs	x21, x28, x21
	umulh	x28, x25, x14
	adcs	x2, x2, xzr
	adds	 x27, x27, x28
	umulh	x28, x25, x13
	adcs	x9, x9, x28
	umulh	x28, x25, x12
	adcs	x7, x7, x28
	umulh	x28, x25, x11
	adcs	x19, x19, x28
	umulh	x28, x25, x10
	adcs	x20, x20, x28
	umulh	x28, x25, x15
	adcs	x21, x21, x28
	mul	 x28, x22, x1
	umulh	x25, x25, x0
	adcs	x2, x2, x25
	umulh	x25, x22, x4
	adds	 x25, x25, x28
	umulh	x28, x22, x1
	adcs	x26, x28, x26
	umulh	x28, x22, x18
	adcs	x24, x28, x24
	umulh	x28, x22, x6
	adcs	x23, x28, x23
	mul	 x28, x22, x5
	umulh	x29, x22, x17
	adcs	x28, x29, x28
	mul	 x29, x22, x16
	umulh	x30, x22, x5
	adcs	x29, x30, x29
	umulh	x30, x22, x16
	mul	 x22, x22, x4
	adcs	x30, x30, xzr
	adds	 x22, x22, x27
	adcs	x9, x25, x9
	adcs	x7, x26, x7
	mul	 x25, x3, x5
	adcs	x19, x24, x19
	mul	 x24, x3, x17
	adcs	x20, x23, x20
	mul	 x23, x3, x6
	adcs	x21, x28, x21
	mul	 x26, x22, x8
	adcs	x8, x29, x2
	mul	 x27, x26, x14
	adcs	x28, x30, xzr
	cmn	 x27, x22
	mul	 x22, x3, x18
	mul	 x27, x26, x13
	adcs	x9, x27, x9
	mul	 x27, x26, x12
	adcs	x7, x27, x7
	mul	 x27, x26, x11
	adcs	x19, x27, x19
	mul	 x27, x26, x10
	adcs	x20, x27, x20
	mul	 x27, x26, x15
	adcs	x21, x27, x21
	mul	 x27, x26, x0
	adcs	x8, x27, x8
	umulh	x27, x26, x14
	adcs	x28, x28, xzr
	adds	 x9, x9, x27
	umulh	x27, x26, x13
	adcs	x7, x7, x27
	umulh	x27, x26, x12
	adcs	x19, x19, x27
	umulh	x27, x26, x11
	adcs	x20, x20, x27
	umulh	x27, x26, x10
	adcs	x21, x21, x27
	umulh	x27, x26, x15
	adcs	x8, x8, x27
	mul	 x27, x3, x1
	umulh	x26, x26, x0
	adcs	x26, x28, x26
	umulh	x28, x3, x4
	adds	 x27, x28, x27
	umulh	x28, x3, x1
	adcs	x22, x28, x22
	umulh	x28, x3, x18
	adcs	x23, x28, x23
	umulh	x28, x3, x6
	adcs	x24, x28, x24
	umulh	x28, x3, x17
	adcs	x25, x28, x25
	mul	 x28, x3, x16
	umulh	x29, x3, x5
	adcs	x28, x29, x28
	ldp	x2, x30, [sp, #16]
	ldr	x2, [x2, #48]
	umulh	x29, x3, x16
	mul	 x3, x3, x4
	adcs	x29, x29, xzr
	adds	 x9, x3, x9
	adcs	x3, x27, x7
	umulh	x7, x2, x16
	mul	 x16, x2, x16
	adcs	x19, x22, x19
	umulh	x22, x2, x5
	mul	 x5, x2, x5
	adcs	x20, x23, x20
	umulh	x23, x2, x17
	mul	 x17, x2, x17
	adcs	x21, x24, x21
	umulh	x24, x2, x6
	mul	 x6, x2, x6
	adcs	x8, x25, x8
	mul	 x25, x9, x30
	adcs	x26, x28, x26
	mul	 x27, x25, x14
	adcs	x28, x29, xzr
	cmn	 x27, x9
	umulh	x9, x2, x18
	mul	 x18, x2, x18
	umulh	x27, x2, x1
	mul	 x1, x2, x1
	umulh	x29, x2, x4
	mul	 x2, x2, x4
	mul	 x4, x25, x13
	adcs	x3, x4, x3
	mul	 x4, x25, x12
	adcs	x4, x4, x19
	mul	 x19, x25, x11
	adcs	x19, x19, x20
	mul	 x20, x25, x10
	adcs	x20, x20, x21
	mul	 x21, x25, x15
	adcs	x8, x21, x8
	mul	 x21, x25, x0
	adcs	x21, x21, x26
	adcs	x26, x28, xzr
	umulh	x28, x25, x14
	adds	 x3, x3, x28
	umulh	x28, x25, x13
	adcs	x4, x4, x28
	umulh	x28, x25, x12
	adcs	x19, x19, x28
	umulh	x28, x25, x11
	adcs	x20, x20, x28
	umulh	x28, x25, x10
	adcs	x8, x8, x28
	umulh	x28, x25, x15
	adcs	x21, x21, x28
	umulh	x25, x25, x0
	adcs	x25, x26, x25
	adds	 x1, x29, x1
	adcs	x18, x27, x18
	adcs	x9, x9, x6
	adcs	x17, x24, x17
	adcs	x5, x23, x5
	adcs	x16, x22, x16
	adcs	x6, x7, xzr
	adds	 x2, x2, x3
	adcs	x1, x1, x4
	adcs	x18, x18, x19
	adcs	x9, x9, x20
	adcs	x8, x17, x8
	adcs	x17, x5, x21
	mul	 x3, x2, x30
	adcs	x16, x16, x25
	mul	 x4, x3, x14
	adcs	x5, x6, xzr
	cmn	 x4, x2
	mul	 x2, x3, x13
	adcs	x1, x2, x1
	mul	 x2, x3, x12
	adcs	x18, x2, x18
	mul	 x2, x3, x11
	adcs	x9, x2, x9
	mul	 x2, x3, x10
	adcs	x8, x2, x8
	mul	 x2, x3, x15
	adcs	x17, x2, x17
	mul	 x2, x3, x0
	adcs	x16, x2, x16
	umulh	x2, x3, x14
	adcs	x4, x5, xzr
	adds	 x1, x1, x2
	umulh	x2, x3, x13
	adcs	x18, x18, x2
	umulh	x2, x3, x12
	adcs	x9, x9, x2
	umulh	x2, x3, x11
	adcs	x8, x8, x2
	umulh	x2, x3, x10
	adcs	x17, x17, x2
	umulh	x2, x3, x15
	adcs	x16, x16, x2
	umulh	x2, x3, x0
	adcs	x2, x4, x2
	subs	 x14, x1, x14
	sbcs	x13, x18, x13
	sbcs	x12, x9, x12
	sbcs	x11, x8, x11
	sbcs	x10, x17, x10
	sbcs	x15, x16, x15
	sbcs	x0, x2, x0
	asr	x3, x0, #63
	cmp	 x3, #0                 // =0
	csel	x14, x1, x14, lt
	csel	x13, x18, x13, lt
	csel	x9, x9, x12, lt
	csel	x8, x8, x11, lt
	csel	x10, x17, x10, lt
	csel	x11, x16, x15, lt
	csel	x12, x2, x0, lt
	ldr	x15, [sp, #8]           // 8-byte Folded Reload
	stp	 x14, x13, [x15]
	stp	x9, x8, [x15, #16]
	stp	x10, x11, [x15, #32]
	str	x12, [x15, #48]
	add	sp, sp, #32             // =32
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end99:
	.size	mcl_fp_montNF7L, .Lfunc_end99-mcl_fp_montNF7L

	.globl	mcl_fp_montRed7L
	.align	2
	.type	mcl_fp_montRed7L,@function
mcl_fp_montRed7L:                       // @mcl_fp_montRed7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	ldur	x15, [x2, #-8]
	ldp	x9, x8, [x2, #40]
	ldp	x11, x10, [x2, #24]
	ldp	x13, x12, [x2, #8]
	ldr	 x14, [x2]
	ldp	x17, x18, [x1, #96]
	ldp	x2, x3, [x1, #80]
	ldp	x4, x5, [x1, #64]
	ldp	x6, x7, [x1, #48]
	ldp	x19, x20, [x1, #32]
	ldp	x21, x22, [x1, #16]
	ldp	 x16, x1, [x1]
	mul	 x23, x16, x15
	mul	 x24, x23, x8
	mul	 x25, x23, x9
	mul	 x26, x23, x10
	mul	 x27, x23, x11
	mul	 x28, x23, x12
	mul	 x29, x23, x13
	umulh	x30, x23, x14
	adds	 x29, x30, x29
	umulh	x30, x23, x13
	adcs	x28, x30, x28
	umulh	x30, x23, x12
	adcs	x27, x30, x27
	umulh	x30, x23, x11
	adcs	x26, x30, x26
	umulh	x30, x23, x10
	adcs	x25, x30, x25
	umulh	x30, x23, x9
	adcs	x24, x30, x24
	umulh	x30, x23, x8
	mul	 x23, x23, x14
	adcs	x30, x30, xzr
	cmn	 x16, x23
	adcs	x16, x1, x29
	adcs	x1, x21, x28
	mul	 x21, x16, x15
	adcs	x22, x22, x27
	mul	 x23, x21, x8
	mul	 x27, x21, x9
	mul	 x28, x21, x10
	mul	 x29, x21, x11
	adcs	x19, x19, x26
	mul	 x26, x21, x12
	adcs	x20, x20, x25
	mul	 x25, x21, x13
	adcs	x6, x6, x24
	umulh	x24, x21, x14
	adcs	x7, x7, x30
	adcs	x4, x4, xzr
	adcs	x5, x5, xzr
	adcs	x2, x2, xzr
	adcs	x3, x3, xzr
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x30, xzr, xzr
	adds	 x24, x24, x25
	umulh	x25, x21, x13
	adcs	x25, x25, x26
	umulh	x26, x21, x12
	adcs	x26, x26, x29
	umulh	x29, x21, x11
	adcs	x28, x29, x28
	umulh	x29, x21, x10
	adcs	x27, x29, x27
	umulh	x29, x21, x9
	adcs	x23, x29, x23
	umulh	x29, x21, x8
	mul	 x21, x21, x14
	adcs	x29, x29, xzr
	cmn	 x21, x16
	adcs	x16, x24, x1
	adcs	x1, x25, x22
	mul	 x21, x16, x15
	adcs	x19, x26, x19
	mul	 x22, x21, x8
	mul	 x24, x21, x9
	mul	 x25, x21, x10
	adcs	x20, x28, x20
	mul	 x26, x21, x11
	adcs	x6, x27, x6
	mul	 x27, x21, x12
	adcs	x7, x23, x7
	mul	 x23, x21, x13
	adcs	x4, x29, x4
	umulh	x28, x21, x14
	adcs	x5, x5, xzr
	adcs	x2, x2, xzr
	adcs	x3, x3, xzr
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x29, x30, xzr
	adds	 x23, x28, x23
	umulh	x28, x21, x13
	adcs	x27, x28, x27
	umulh	x28, x21, x12
	adcs	x26, x28, x26
	umulh	x28, x21, x11
	adcs	x25, x28, x25
	umulh	x28, x21, x10
	adcs	x24, x28, x24
	umulh	x28, x21, x9
	adcs	x22, x28, x22
	umulh	x28, x21, x8
	mul	 x21, x21, x14
	adcs	x28, x28, xzr
	cmn	 x21, x16
	adcs	x16, x23, x1
	adcs	x1, x27, x19
	mul	 x19, x16, x15
	adcs	x20, x26, x20
	mul	 x21, x19, x8
	mul	 x23, x19, x9
	mul	 x26, x19, x10
	adcs	x6, x25, x6
	mul	 x25, x19, x11
	adcs	x7, x24, x7
	mul	 x24, x19, x12
	adcs	x4, x22, x4
	mul	 x22, x19, x13
	adcs	x5, x28, x5
	umulh	x27, x19, x14
	adcs	x2, x2, xzr
	adcs	x3, x3, xzr
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x28, x29, xzr
	adds	 x22, x27, x22
	umulh	x27, x19, x13
	adcs	x24, x27, x24
	umulh	x27, x19, x12
	adcs	x25, x27, x25
	umulh	x27, x19, x11
	adcs	x26, x27, x26
	umulh	x27, x19, x10
	adcs	x23, x27, x23
	umulh	x27, x19, x9
	adcs	x21, x27, x21
	umulh	x27, x19, x8
	mul	 x19, x19, x14
	adcs	x27, x27, xzr
	cmn	 x19, x16
	adcs	x16, x22, x1
	adcs	x1, x24, x20
	mul	 x19, x16, x15
	adcs	x6, x25, x6
	mul	 x20, x19, x8
	mul	 x22, x19, x9
	mul	 x24, x19, x10
	adcs	x7, x26, x7
	mul	 x25, x19, x11
	adcs	x4, x23, x4
	mul	 x23, x19, x12
	adcs	x5, x21, x5
	mul	 x21, x19, x13
	adcs	x2, x27, x2
	umulh	x26, x19, x14
	adcs	x3, x3, xzr
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x27, x28, xzr
	adds	 x21, x26, x21
	umulh	x26, x19, x13
	adcs	x23, x26, x23
	umulh	x26, x19, x12
	adcs	x25, x26, x25
	umulh	x26, x19, x11
	adcs	x24, x26, x24
	umulh	x26, x19, x10
	adcs	x22, x26, x22
	umulh	x26, x19, x9
	adcs	x20, x26, x20
	umulh	x26, x19, x8
	mul	 x19, x19, x14
	adcs	x26, x26, xzr
	cmn	 x19, x16
	adcs	x16, x21, x1
	adcs	x1, x23, x6
	mul	 x6, x16, x15
	adcs	x7, x25, x7
	mul	 x19, x6, x8
	mul	 x21, x6, x9
	mul	 x23, x6, x10
	adcs	x4, x24, x4
	mul	 x24, x6, x11
	adcs	x5, x22, x5
	mul	 x22, x6, x12
	adcs	x2, x20, x2
	mul	 x20, x6, x13
	adcs	x3, x26, x3
	umulh	x25, x6, x14
	adcs	x17, x17, xzr
	adcs	x18, x18, xzr
	adcs	x26, x27, xzr
	adds	 x20, x25, x20
	umulh	x25, x6, x13
	adcs	x22, x25, x22
	umulh	x25, x6, x12
	adcs	x24, x25, x24
	umulh	x25, x6, x11
	adcs	x23, x25, x23
	umulh	x25, x6, x10
	adcs	x21, x25, x21
	umulh	x25, x6, x9
	adcs	x19, x25, x19
	umulh	x25, x6, x8
	mul	 x6, x6, x14
	adcs	x25, x25, xzr
	cmn	 x6, x16
	adcs	x16, x20, x1
	adcs	x1, x22, x7
	mul	 x15, x16, x15
	adcs	x4, x24, x4
	mul	 x6, x15, x8
	mul	 x7, x15, x9
	mul	 x20, x15, x10
	adcs	x5, x23, x5
	mul	 x22, x15, x11
	adcs	x2, x21, x2
	mul	 x21, x15, x12
	adcs	x3, x19, x3
	mul	 x19, x15, x13
	adcs	x17, x25, x17
	umulh	x23, x15, x14
	adcs	x18, x18, xzr
	adcs	x24, x26, xzr
	adds	 x19, x23, x19
	umulh	x23, x15, x13
	adcs	x21, x23, x21
	umulh	x23, x15, x12
	adcs	x22, x23, x22
	umulh	x23, x15, x11
	adcs	x20, x23, x20
	umulh	x23, x15, x10
	adcs	x7, x23, x7
	umulh	x23, x15, x9
	adcs	x6, x23, x6
	umulh	x23, x15, x8
	mul	 x15, x15, x14
	adcs	x23, x23, xzr
	cmn	 x15, x16
	adcs	x15, x19, x1
	adcs	x16, x21, x4
	adcs	x1, x22, x5
	adcs	x2, x20, x2
	adcs	x3, x7, x3
	adcs	x17, x6, x17
	adcs	x18, x23, x18
	adcs	x4, x24, xzr
	subs	 x14, x15, x14
	sbcs	x13, x16, x13
	sbcs	x12, x1, x12
	sbcs	x11, x2, x11
	sbcs	x10, x3, x10
	sbcs	x9, x17, x9
	sbcs	x8, x18, x8
	sbcs	x4, x4, xzr
	tst	 x4, #0x1
	csel	x14, x15, x14, ne
	csel	x13, x16, x13, ne
	csel	x12, x1, x12, ne
	csel	x11, x2, x11, ne
	csel	x10, x3, x10, ne
	csel	x9, x17, x9, ne
	csel	x8, x18, x8, ne
	stp	 x14, x13, [x0]
	stp	x12, x11, [x0, #16]
	stp	x10, x9, [x0, #32]
	str	x8, [x0, #48]
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end100:
	.size	mcl_fp_montRed7L, .Lfunc_end100-mcl_fp_montRed7L

	.globl	mcl_fp_addPre7L
	.align	2
	.type	mcl_fp_addPre7L,@function
mcl_fp_addPre7L:                        // @mcl_fp_addPre7L
// BB#0:
	ldp	x11, x8, [x2, #40]
	ldp	x13, x9, [x1, #40]
	ldp	x15, x10, [x2, #24]
	ldp	x17, x14, [x2, #8]
	ldr	 x16, [x2]
	ldp	 x18, x2, [x1]
	ldr	x3, [x1, #16]
	ldp	x1, x12, [x1, #24]
	adds	 x16, x16, x18
	str	 x16, [x0]
	adcs	x16, x17, x2
	adcs	x14, x14, x3
	stp	x16, x14, [x0, #8]
	adcs	x14, x15, x1
	adcs	x10, x10, x12
	stp	x14, x10, [x0, #24]
	adcs	x10, x11, x13
	adcs	x9, x8, x9
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #40]
	mov	 x0, x8
	ret
.Lfunc_end101:
	.size	mcl_fp_addPre7L, .Lfunc_end101-mcl_fp_addPre7L

	.globl	mcl_fp_subPre7L
	.align	2
	.type	mcl_fp_subPre7L,@function
mcl_fp_subPre7L:                        // @mcl_fp_subPre7L
// BB#0:
	ldp	x11, x8, [x2, #40]
	ldp	x13, x9, [x1, #40]
	ldp	x15, x10, [x2, #24]
	ldp	x17, x14, [x2, #8]
	ldr	 x16, [x2]
	ldp	 x18, x2, [x1]
	ldr	x3, [x1, #16]
	ldp	x1, x12, [x1, #24]
	subs	 x16, x18, x16
	str	 x16, [x0]
	sbcs	x16, x2, x17
	sbcs	x14, x3, x14
	stp	x16, x14, [x0, #8]
	sbcs	x14, x1, x15
	sbcs	x10, x12, x10
	stp	x14, x10, [x0, #24]
	sbcs	x10, x13, x11
	sbcs	x9, x9, x8
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #40]
	mov	 x0, x8
	ret
.Lfunc_end102:
	.size	mcl_fp_subPre7L, .Lfunc_end102-mcl_fp_subPre7L

	.globl	mcl_fp_shr1_7L
	.align	2
	.type	mcl_fp_shr1_7L,@function
mcl_fp_shr1_7L:                         // @mcl_fp_shr1_7L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x14, x10, [x1, #40]
	ldp	x11, x12, [x1, #16]
	ldr	x13, [x1, #32]
	extr	x8, x9, x8, #1
	extr	x9, x11, x9, #1
	extr	x11, x12, x11, #1
	extr	x12, x13, x12, #1
	extr	x13, x14, x13, #1
	extr	x14, x10, x14, #1
	lsr	x10, x10, #1
	stp	 x8, x9, [x0]
	stp	x11, x12, [x0, #16]
	stp	x13, x14, [x0, #32]
	str	x10, [x0, #48]
	ret
.Lfunc_end103:
	.size	mcl_fp_shr1_7L, .Lfunc_end103-mcl_fp_shr1_7L

	.globl	mcl_fp_add7L
	.align	2
	.type	mcl_fp_add7L,@function
mcl_fp_add7L:                           // @mcl_fp_add7L
// BB#0:
	ldp	x11, x8, [x2, #40]
	ldp	x13, x9, [x1, #40]
	ldp	x15, x10, [x2, #24]
	ldp	x17, x14, [x2, #8]
	ldr	 x16, [x2]
	ldp	 x18, x2, [x1]
	ldr	x4, [x1, #16]
	ldp	x1, x12, [x1, #24]
	adds	 x16, x16, x18
	ldp	x5, x18, [x3, #40]
	adcs	x17, x17, x2
	adcs	x2, x14, x4
	ldr	x4, [x3, #32]
	adcs	x15, x15, x1
	adcs	x10, x10, x12
	ldp	 x12, x1, [x3]
	stp	 x16, x17, [x0]
	stp	x2, x15, [x0, #16]
	adcs	x6, x11, x13
	stp	x10, x6, [x0, #32]
	adcs	x8, x8, x9
	str	x8, [x0, #48]
	adcs	x7, xzr, xzr
	ldp	x9, x11, [x3, #16]
	subs	 x14, x16, x12
	sbcs	x13, x17, x1
	sbcs	x12, x2, x9
	sbcs	x11, x15, x11
	sbcs	x10, x10, x4
	sbcs	x9, x6, x5
	sbcs	x8, x8, x18
	sbcs	x15, x7, xzr
	and	w15, w15, #0x1
	tbnz	w15, #0, .LBB104_2
// BB#1:                                // %nocarry
	stp	 x14, x13, [x0]
	stp	x12, x11, [x0, #16]
	stp	x10, x9, [x0, #32]
	str	x8, [x0, #48]
.LBB104_2:                              // %carry
	ret
.Lfunc_end104:
	.size	mcl_fp_add7L, .Lfunc_end104-mcl_fp_add7L

	.globl	mcl_fp_addNF7L
	.align	2
	.type	mcl_fp_addNF7L,@function
mcl_fp_addNF7L:                         // @mcl_fp_addNF7L
// BB#0:
	ldp	x11, x8, [x1, #40]
	ldp	x13, x9, [x2, #40]
	ldp	x15, x10, [x1, #24]
	ldp	x17, x14, [x1, #8]
	ldr	 x16, [x1]
	ldp	 x18, x1, [x2]
	ldr	x4, [x2, #16]
	ldp	x2, x12, [x2, #24]
	adds	 x16, x18, x16
	adcs	x17, x1, x17
	adcs	x14, x4, x14
	ldp	x4, x18, [x3, #40]
	adcs	x15, x2, x15
	adcs	x10, x12, x10
	ldp	 x12, x2, [x3]
	adcs	x11, x13, x11
	ldr	x13, [x3, #16]
	ldp	x3, x1, [x3, #24]
	adcs	x8, x9, x8
	subs	 x9, x16, x12
	sbcs	x12, x17, x2
	sbcs	x13, x14, x13
	sbcs	x2, x15, x3
	sbcs	x1, x10, x1
	sbcs	x3, x11, x4
	sbcs	x18, x8, x18
	asr	x4, x18, #63
	cmp	 x4, #0                 // =0
	csel	x9, x16, x9, lt
	csel	x12, x17, x12, lt
	csel	x13, x14, x13, lt
	csel	x14, x15, x2, lt
	csel	x10, x10, x1, lt
	csel	x11, x11, x3, lt
	csel	x8, x8, x18, lt
	stp	 x9, x12, [x0]
	stp	x13, x14, [x0, #16]
	stp	x10, x11, [x0, #32]
	str	x8, [x0, #48]
	ret
.Lfunc_end105:
	.size	mcl_fp_addNF7L, .Lfunc_end105-mcl_fp_addNF7L

	.globl	mcl_fp_sub7L
	.align	2
	.type	mcl_fp_sub7L,@function
mcl_fp_sub7L:                           // @mcl_fp_sub7L
// BB#0:
	ldp	x13, x14, [x2, #40]
	ldp	x17, x15, [x1, #40]
	ldp	x11, x12, [x2, #24]
	ldp	x9, x10, [x2, #8]
	ldr	 x8, [x2]
	ldp	 x18, x2, [x1]
	ldr	x4, [x1, #16]
	ldp	x1, x16, [x1, #24]
	subs	 x8, x18, x8
	sbcs	x9, x2, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x4, x10
	sbcs	x11, x1, x11
	stp	x10, x11, [x0, #16]
	sbcs	x12, x16, x12
	sbcs	x13, x17, x13
	stp	x12, x13, [x0, #32]
	sbcs	x14, x15, x14
	str	x14, [x0, #48]
	ngcs	 x15, xzr
	and	w15, w15, #0x1
	tbnz	w15, #0, .LBB106_2
// BB#1:                                // %nocarry
	ret
.LBB106_2:                              // %carry
	ldp	 x16, x17, [x3]
	ldp	x18, x1, [x3, #16]
	ldr	x2, [x3, #32]
	ldp	x3, x15, [x3, #40]
	adds	 x8, x16, x8
	adcs	x9, x17, x9
	adcs	x10, x18, x10
	adcs	x11, x1, x11
	adcs	x12, x2, x12
	adcs	x13, x3, x13
	adcs	x14, x15, x14
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	str	x14, [x0, #48]
	ret
.Lfunc_end106:
	.size	mcl_fp_sub7L, .Lfunc_end106-mcl_fp_sub7L

	.globl	mcl_fp_subNF7L
	.align	2
	.type	mcl_fp_subNF7L,@function
mcl_fp_subNF7L:                         // @mcl_fp_subNF7L
// BB#0:
	ldp	x11, x8, [x2, #40]
	ldp	x13, x9, [x1, #40]
	ldp	x15, x10, [x2, #24]
	ldp	x17, x14, [x2, #8]
	ldr	 x16, [x2]
	ldp	 x18, x2, [x1]
	ldr	x4, [x1, #16]
	ldp	x1, x12, [x1, #24]
	subs	 x16, x18, x16
	sbcs	x17, x2, x17
	sbcs	x14, x4, x14
	ldp	x4, x18, [x3, #40]
	sbcs	x15, x1, x15
	sbcs	x10, x12, x10
	ldp	 x12, x1, [x3]
	sbcs	x11, x13, x11
	ldr	x13, [x3, #16]
	ldp	x3, x2, [x3, #24]
	sbcs	x8, x9, x8
	asr	x9, x8, #63
	and	 x1, x9, x1
	and	 x13, x9, x13
	and	 x3, x9, x3
	and	 x2, x9, x2
	and	 x4, x9, x4
	and	 x18, x9, x18
	extr	x9, x9, x8, #63
	and	 x9, x9, x12
	adds	 x9, x9, x16
	str	 x9, [x0]
	adcs	x9, x1, x17
	str	x9, [x0, #8]
	adcs	x9, x13, x14
	str	x9, [x0, #16]
	adcs	x9, x3, x15
	str	x9, [x0, #24]
	adcs	x9, x2, x10
	str	x9, [x0, #32]
	adcs	x9, x4, x11
	adcs	x8, x18, x8
	stp	x9, x8, [x0, #40]
	ret
.Lfunc_end107:
	.size	mcl_fp_subNF7L, .Lfunc_end107-mcl_fp_subNF7L

	.globl	mcl_fpDbl_add7L
	.align	2
	.type	mcl_fpDbl_add7L,@function
mcl_fpDbl_add7L:                        // @mcl_fpDbl_add7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	ldp	x8, x9, [x2, #96]
	ldp	x10, x11, [x1, #96]
	ldp	x12, x13, [x2, #80]
	ldp	x14, x15, [x1, #80]
	ldp	x16, x17, [x2, #64]
	ldp	x18, x4, [x1, #64]
	ldp	x5, x6, [x2, #48]
	ldp	x7, x19, [x1, #48]
	ldp	x20, x21, [x2, #32]
	ldp	x22, x23, [x1, #32]
	ldp	x24, x25, [x2, #16]
	ldp	 x27, x2, [x2]
	ldp	x28, x29, [x1, #16]
	ldp	 x26, x1, [x1]
	adds	 x26, x27, x26
	ldr	x27, [x3, #48]
	str	 x26, [x0]
	adcs	x1, x2, x1
	ldp	x2, x26, [x3, #32]
	str	x1, [x0, #8]
	adcs	x1, x24, x28
	ldp	x24, x28, [x3, #16]
	str	x1, [x0, #16]
	ldp	 x1, x3, [x3]
	adcs	x25, x25, x29
	adcs	x20, x20, x22
	stp	x25, x20, [x0, #24]
	adcs	x20, x21, x23
	adcs	x5, x5, x7
	stp	x20, x5, [x0, #40]
	adcs	x5, x6, x19
	adcs	x16, x16, x18
	adcs	x17, x17, x4
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	adcs	x8, x8, x10
	adcs	x9, x9, x11
	adcs	x10, xzr, xzr
	subs	 x11, x5, x1
	sbcs	x14, x16, x3
	sbcs	x15, x17, x24
	sbcs	x18, x12, x28
	sbcs	x1, x13, x2
	sbcs	x2, x8, x26
	sbcs	x3, x9, x27
	sbcs	x10, x10, xzr
	tst	 x10, #0x1
	csel	x10, x5, x11, ne
	csel	x11, x16, x14, ne
	csel	x14, x17, x15, ne
	csel	x12, x12, x18, ne
	csel	x13, x13, x1, ne
	csel	x8, x8, x2, ne
	csel	x9, x9, x3, ne
	stp	x10, x11, [x0, #56]
	stp	x14, x12, [x0, #72]
	stp	x13, x8, [x0, #88]
	str	x9, [x0, #104]
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end108:
	.size	mcl_fpDbl_add7L, .Lfunc_end108-mcl_fpDbl_add7L

	.globl	mcl_fpDbl_sub7L
	.align	2
	.type	mcl_fpDbl_sub7L,@function
mcl_fpDbl_sub7L:                        // @mcl_fpDbl_sub7L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	ldp	x9, x8, [x2, #96]
	ldp	x11, x10, [x1, #96]
	ldp	x12, x13, [x2, #80]
	ldp	x14, x15, [x1, #80]
	ldp	x16, x17, [x2, #64]
	ldp	x18, x4, [x1, #64]
	ldp	x5, x6, [x2, #48]
	ldp	x7, x19, [x1, #48]
	ldp	x20, x21, [x2, #32]
	ldp	x22, x23, [x1, #32]
	ldp	x24, x25, [x2, #16]
	ldp	 x26, x2, [x2]
	ldp	x28, x29, [x1, #16]
	ldp	 x27, x1, [x1]
	subs	 x26, x27, x26
	ldr	x27, [x3, #48]
	str	 x26, [x0]
	sbcs	x1, x1, x2
	ldp	x2, x26, [x3, #32]
	str	x1, [x0, #8]
	sbcs	x1, x28, x24
	ldp	x24, x28, [x3, #16]
	str	x1, [x0, #16]
	ldp	 x1, x3, [x3]
	sbcs	x25, x29, x25
	sbcs	x20, x22, x20
	stp	x25, x20, [x0, #24]
	sbcs	x20, x23, x21
	sbcs	x5, x7, x5
	stp	x20, x5, [x0, #40]
	sbcs	x5, x19, x6
	sbcs	x16, x18, x16
	sbcs	x17, x4, x17
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	sbcs	x9, x11, x9
	sbcs	x8, x10, x8
	ngcs	 x10, xzr
	tst	 x10, #0x1
	csel	x10, x27, xzr, ne
	csel	x11, x26, xzr, ne
	csel	x14, x2, xzr, ne
	csel	x15, x28, xzr, ne
	csel	x18, x24, xzr, ne
	csel	x2, x3, xzr, ne
	csel	x1, x1, xzr, ne
	adds	 x1, x1, x5
	adcs	x16, x2, x16
	stp	x1, x16, [x0, #56]
	adcs	x16, x18, x17
	adcs	x12, x15, x12
	stp	x16, x12, [x0, #72]
	adcs	x12, x14, x13
	adcs	x9, x11, x9
	stp	x12, x9, [x0, #88]
	adcs	x8, x10, x8
	str	x8, [x0, #104]
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end109:
	.size	mcl_fpDbl_sub7L, .Lfunc_end109-mcl_fpDbl_sub7L

	.align	2
	.type	.LmulPv512x64,@function
.LmulPv512x64:                          // @mulPv512x64
// BB#0:
	ldr	 x9, [x0]
	mul	 x10, x9, x1
	str	 x10, [x8]
	ldr	x10, [x0, #8]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adds	 x9, x9, x11
	str	x9, [x8, #8]
	ldr	x9, [x0, #16]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #16]
	ldr	x10, [x0, #24]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #24]
	ldr	x9, [x0, #32]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #32]
	ldr	x10, [x0, #40]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #40]
	ldr	x9, [x0, #48]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #48]
	ldr	x10, [x0, #56]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	umulh	x10, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #56]
	adcs	x9, x10, xzr
	str	x9, [x8, #64]
	ret
.Lfunc_end110:
	.size	.LmulPv512x64, .Lfunc_end110-.LmulPv512x64

	.globl	mcl_fp_mulUnitPre8L
	.align	2
	.type	mcl_fp_mulUnitPre8L,@function
mcl_fp_mulUnitPre8L:                    // @mcl_fp_mulUnitPre8L
// BB#0:
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16            // =16
	sub	sp, sp, #80             // =80
	mov	 x19, x0
	mov	 x8, sp
	mov	 x0, x1
	mov	 x1, x2
	bl	.LmulPv512x64
	ldp	x9, x8, [sp, #56]
	ldp	x11, x10, [sp, #40]
	ldp	x16, x12, [sp, #24]
	ldp	 x13, x14, [sp]
	ldr	x15, [sp, #16]
	stp	 x13, x14, [x19]
	stp	x15, x16, [x19, #16]
	stp	x12, x11, [x19, #32]
	stp	x10, x9, [x19, #48]
	str	x8, [x19, #64]
	sub	sp, x29, #16            // =16
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
.Lfunc_end111:
	.size	mcl_fp_mulUnitPre8L, .Lfunc_end111-mcl_fp_mulUnitPre8L

	.globl	mcl_fpDbl_mulPre8L
	.align	2
	.type	mcl_fpDbl_mulPre8L,@function
mcl_fpDbl_mulPre8L:                     // @mcl_fpDbl_mulPre8L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #144            // =144
	mov	 x20, x2
	mov	 x21, x1
	mov	 x19, x0
	bl	mcl_fpDbl_mulPre4L
	add	x0, x19, #64            // =64
	add	x1, x21, #32            // =32
	add	x2, x20, #32            // =32
	bl	mcl_fpDbl_mulPre4L
	ldp	x8, x9, [x20, #48]
	ldp	x10, x11, [x20, #32]
	ldp	 x12, x13, [x20]
	ldp	x14, x15, [x20, #16]
	adds	 x18, x12, x10
	str	x18, [sp, #8]           // 8-byte Folded Spill
	ldp	x10, x12, [x21, #16]
	ldp	x16, x17, [x21, #48]
	adcs	x22, x13, x11
	ldp	 x11, x13, [x21]
	adcs	x23, x14, x8
	ldp	x8, x14, [x21, #32]
	stp	x18, x22, [sp, #16]
	adcs	x21, x15, x9
	stp	x23, x21, [sp, #32]
	adcs	x24, xzr, xzr
	adds	 x25, x11, x8
	adcs	x26, x13, x14
	stp	x25, x26, [sp, #48]
	adcs	x27, x10, x16
	adcs	x28, x12, x17
	stp	x27, x28, [sp, #64]
	adcs	x20, xzr, xzr
	add	x0, sp, #80             // =80
	add	x1, sp, #48             // =48
	add	x2, sp, #16             // =16
	bl	mcl_fpDbl_mulPre4L
	cmp	 x24, #0                // =0
	csel	x8, x28, xzr, ne
	and	 x9, x24, x20
	ldp	x11, x10, [sp, #128]
	ldp	x13, x12, [sp, #112]
	ldp	x14, x15, [x19, #48]
	ldp	x16, x17, [x19, #32]
	ldp	x18, x0, [x19, #16]
	csel	x1, x27, xzr, ne
	csel	x2, x26, xzr, ne
	csel	x3, x25, xzr, ne
	cmp	 x20, #0                // =0
	ldp	 x4, x5, [x19]
	csel	x6, x21, xzr, ne
	csel	x7, x23, xzr, ne
	csel	x20, x22, xzr, ne
	ldr	x21, [sp, #8]           // 8-byte Folded Reload
	csel	x21, x21, xzr, ne
	adds	 x3, x21, x3
	adcs	x2, x20, x2
	ldp	x20, x21, [sp, #96]
	adcs	x1, x7, x1
	adcs	x8, x6, x8
	adcs	x6, xzr, xzr
	adds	 x13, x3, x13
	ldp	x3, x7, [sp, #80]
	adcs	x12, x2, x12
	adcs	x11, x1, x11
	ldp	x1, x2, [x19, #112]
	adcs	x8, x8, x10
	adcs	x9, x6, x9
	ldp	x10, x6, [x19, #96]
	subs	 x3, x3, x4
	sbcs	x4, x7, x5
	ldp	x5, x7, [x19, #80]
	sbcs	x18, x20, x18
	sbcs	x0, x21, x0
	ldp	x20, x21, [x19, #64]
	sbcs	x13, x13, x16
	sbcs	x12, x12, x17
	sbcs	x11, x11, x14
	sbcs	x8, x8, x15
	sbcs	x9, x9, xzr
	subs	 x3, x3, x20
	sbcs	x4, x4, x21
	sbcs	x18, x18, x5
	sbcs	x0, x0, x7
	sbcs	x13, x13, x10
	sbcs	x12, x12, x6
	sbcs	x11, x11, x1
	sbcs	x8, x8, x2
	sbcs	x9, x9, xzr
	adds	 x16, x16, x3
	str	x16, [x19, #32]
	adcs	x16, x17, x4
	adcs	x14, x14, x18
	stp	x16, x14, [x19, #40]
	adcs	x14, x15, x0
	adcs	x13, x20, x13
	stp	x14, x13, [x19, #56]
	adcs	x12, x21, x12
	adcs	x11, x5, x11
	stp	x12, x11, [x19, #72]
	adcs	x8, x7, x8
	str	x8, [x19, #88]
	adcs	x8, x10, x9
	str	x8, [x19, #96]
	adcs	x8, x6, xzr
	str	x8, [x19, #104]
	adcs	x8, x1, xzr
	str	x8, [x19, #112]
	adcs	x8, x2, xzr
	str	x8, [x19, #120]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end112:
	.size	mcl_fpDbl_mulPre8L, .Lfunc_end112-mcl_fpDbl_mulPre8L

	.globl	mcl_fpDbl_sqrPre8L
	.align	2
	.type	mcl_fpDbl_sqrPre8L,@function
mcl_fpDbl_sqrPre8L:                     // @mcl_fpDbl_sqrPre8L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #128            // =128
	mov	 x20, x1
	mov	 x19, x0
	mov	 x2, x20
	bl	mcl_fpDbl_mulPre4L
	add	x0, x19, #64            // =64
	add	x1, x20, #32            // =32
	mov	 x2, x1
	bl	mcl_fpDbl_mulPre4L
	ldp	x8, x9, [x20, #16]
	ldp	x10, x11, [x20, #32]
	ldp	 x12, x13, [x20]
	ldp	x14, x15, [x20, #48]
	adds	 x22, x12, x10
	adcs	x23, x13, x11
	adcs	x20, x8, x14
	adcs	x21, x9, x15
	stp	x22, x23, [sp, #32]
	stp	 x22, x23, [sp]
	stp	x20, x21, [sp, #48]
	stp	x20, x21, [sp, #16]
	adcs	x24, xzr, xzr
	add	x0, sp, #64             // =64
	add	x1, sp, #32             // =32
	mov	 x2, sp
	bl	mcl_fpDbl_mulPre4L
	ldp	x8, x9, [x19, #48]
	ldp	 x10, x11, [x19]
	ldp	x12, x13, [sp, #64]
	ldp	x14, x15, [x19, #16]
	ldp	x16, x17, [sp, #80]
	ldp	x18, x0, [x19, #32]
	subs	 x10, x12, x10
	ldp	x1, x12, [sp, #96]
	sbcs	x11, x13, x11
	sbcs	x14, x16, x14
	ldp	x13, x16, [sp, #112]
	sbcs	x15, x17, x15
	sbcs	x17, x1, x18
	ldp	x1, x2, [x19, #64]
	ldp	x3, x4, [x19, #80]
	ldp	x5, x6, [x19, #96]
	ldp	x7, x25, [x19, #112]
	lsr	x26, x21, #63
	sbcs	x12, x12, x0
	sbcs	x13, x13, x8
	sbcs	x16, x16, x9
	sbcs	x27, x24, xzr
	subs	 x10, x10, x1
	sbcs	x11, x11, x2
	sbcs	x14, x14, x3
	sbcs	x15, x15, x4
	sbcs	x17, x17, x5
	sbcs	x12, x12, x6
	sbcs	x13, x13, x7
	sbcs	x16, x16, x25
	sbcs	x27, x27, xzr
	adds	 x22, x22, x22
	adcs	x23, x23, x23
	adcs	x20, x20, x20
	adcs	x21, x21, x21
	cmp	 x24, #0                // =0
	csel	x24, x26, xzr, ne
	csel	x21, x21, xzr, ne
	csel	x20, x20, xzr, ne
	csel	x23, x23, xzr, ne
	csel	x22, x22, xzr, ne
	adds	 x17, x17, x22
	adcs	x12, x12, x23
	adcs	x13, x13, x20
	adcs	x16, x16, x21
	adcs	x20, x27, x24
	adds	 x10, x10, x18
	str	x10, [x19, #32]
	adcs	x10, x11, x0
	adcs	x8, x14, x8
	stp	x10, x8, [x19, #40]
	adcs	x8, x15, x9
	str	x8, [x19, #56]
	adcs	x8, x17, x1
	str	x8, [x19, #64]
	adcs	x8, x12, x2
	str	x8, [x19, #72]
	adcs	x8, x13, x3
	str	x8, [x19, #80]
	adcs	x8, x16, x4
	str	x8, [x19, #88]
	adcs	x8, x20, x5
	str	x8, [x19, #96]
	adcs	x8, x6, xzr
	str	x8, [x19, #104]
	adcs	x8, x7, xzr
	str	x8, [x19, #112]
	adcs	x8, x25, xzr
	str	x8, [x19, #120]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end113:
	.size	mcl_fpDbl_sqrPre8L, .Lfunc_end113-mcl_fpDbl_sqrPre8L

	.globl	mcl_fp_mont8L
	.align	2
	.type	mcl_fp_mont8L,@function
mcl_fp_mont8L:                          // @mcl_fp_mont8L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #1424           // =1424
	mov	 x20, x3
	mov	 x26, x2
	str	x26, [sp, #120]         // 8-byte Folded Spill
	ldur	x19, [x20, #-8]
	str	x19, [sp, #136]         // 8-byte Folded Spill
	ldr	 x9, [x26]
	mov	 x27, x1
	str	x27, [sp, #128]         // 8-byte Folded Spill
	str	x0, [sp, #112]          // 8-byte Folded Spill
	sub	x8, x29, #160           // =160
	mov	 x0, x27
	mov	 x1, x9
	bl	.LmulPv512x64
	ldur	x24, [x29, #-160]
	ldur	x8, [x29, #-96]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldur	x8, [x29, #-104]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldur	x8, [x29, #-112]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldur	x8, [x29, #-120]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldur	x8, [x29, #-128]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldur	x8, [x29, #-136]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldur	x8, [x29, #-144]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldur	x8, [x29, #-152]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	mul	 x1, x24, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv512x64
	ldur	x8, [x29, #-176]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldur	x8, [x29, #-184]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldur	x8, [x29, #-192]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x19, x28, [x29, #-208]
	ldp	x21, x23, [x29, #-224]
	ldp	x25, x22, [x29, #-240]
	ldr	x1, [x26, #8]
	add	x8, sp, #1184           // =1184
	mov	 x0, x27
	bl	.LmulPv512x64
	cmn	 x25, x24
	ldr	x8, [sp, #1248]
	ldr	x9, [sp, #1240]
	ldp	x10, x12, [sp, #48]
	adcs	x10, x22, x10
	ldr	x11, [sp, #1232]
	adcs	x12, x21, x12
	ldr	x13, [sp, #1224]
	ldp	x14, x16, [sp, #64]
	adcs	x14, x23, x14
	ldr	x15, [sp, #1216]
	adcs	x16, x19, x16
	ldr	x17, [sp, #1208]
	ldp	x18, x1, [sp, #80]
	adcs	x18, x28, x18
	ldr	x0, [sp, #1200]
	ldp	x2, x4, [sp, #24]
	adcs	x1, x2, x1
	ldr	x2, [sp, #1184]
	ldp	x3, x5, [sp, #96]
	adcs	x3, x4, x3
	ldr	x4, [sp, #1192]
	ldr	x6, [sp, #40]           // 8-byte Folded Reload
	adcs	x5, x6, x5
	adcs	x6, xzr, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	ldr	x22, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x22
	add	x8, sp, #1104           // =1104
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #1168]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1160]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1152]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #1144]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x25, [sp, #1136]
	ldr	x26, [sp, #1128]
	ldr	x27, [sp, #1120]
	ldr	x21, [sp, #1112]
	ldr	x28, [sp, #1104]
	ldp	x24, x23, [sp, #120]
	ldr	x1, [x24, #16]
	add	x8, sp, #1024           // =1024
	mov	 x0, x23
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldr	x8, [sp, #1088]
	ldr	x9, [sp, #1080]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldr	x11, [sp, #1072]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	ldr	x13, [sp, #1064]
	adcs	x14, x14, x26
	ldr	x15, [sp, #1056]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	ldr	x17, [sp, #1048]
	ldp	x0, x2, [sp, #8]
	adcs	x18, x18, x0
	ldr	x0, [sp, #1040]
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	adcs	x1, x1, x2
	ldr	x2, [sp, #1024]
	ldp	x5, x3, [sp, #96]
	ldp	x4, x6, [sp, #24]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1032]
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	mul	 x1, x19, x22
	add	x8, sp, #944            // =944
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #1008]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1000]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #992]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #984]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x25, [sp, #976]
	ldr	x26, [sp, #968]
	ldr	x27, [sp, #960]
	ldr	x21, [sp, #952]
	ldr	x28, [sp, #944]
	mov	 x22, x24
	ldr	x1, [x22, #24]
	add	x8, sp, #864            // =864
	mov	 x0, x23
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldr	x8, [sp, #928]
	ldr	x9, [sp, #920]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldr	x11, [sp, #912]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	ldr	x13, [sp, #904]
	adcs	x14, x14, x26
	ldr	x15, [sp, #896]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	ldr	x17, [sp, #888]
	ldp	x0, x2, [sp, #8]
	adcs	x18, x18, x0
	ldr	x0, [sp, #880]
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	adcs	x1, x1, x2
	ldr	x2, [sp, #864]
	ldp	x5, x3, [sp, #96]
	ldp	x4, x6, [sp, #24]
	adcs	x3, x3, x4
	ldr	x4, [sp, #872]
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	ldr	x23, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x23
	add	x8, sp, #784            // =784
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #848]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #840]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #832]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x24, [sp, #824]
	ldr	x25, [sp, #816]
	ldr	x26, [sp, #808]
	ldr	x27, [sp, #800]
	ldr	x21, [sp, #792]
	ldr	x28, [sp, #784]
	ldr	x1, [x22, #32]
	add	x8, sp, #704            // =704
	ldr	x22, [sp, #128]         // 8-byte Folded Reload
	mov	 x0, x22
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldr	x8, [sp, #768]
	ldr	x9, [sp, #760]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldr	x11, [sp, #752]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	ldr	x13, [sp, #744]
	adcs	x14, x14, x26
	ldr	x15, [sp, #736]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	ldr	x17, [sp, #728]
	adcs	x18, x18, x24
	ldr	x0, [sp, #720]
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #704]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #712]
	ldr	x6, [sp, #32]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	mul	 x1, x19, x23
	add	x8, sp, #624            // =624
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #688]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #680]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #672]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x24, [sp, #664]
	ldr	x25, [sp, #656]
	ldr	x26, [sp, #648]
	ldr	x27, [sp, #640]
	ldr	x21, [sp, #632]
	ldr	x28, [sp, #624]
	ldr	x23, [sp, #120]         // 8-byte Folded Reload
	ldr	x1, [x23, #40]
	add	x8, sp, #544            // =544
	mov	 x0, x22
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldr	x8, [sp, #608]
	ldr	x9, [sp, #600]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldr	x11, [sp, #592]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	ldr	x13, [sp, #584]
	adcs	x14, x14, x26
	ldr	x15, [sp, #576]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	ldr	x17, [sp, #568]
	adcs	x18, x18, x24
	ldr	x0, [sp, #560]
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #544]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #552]
	ldr	x6, [sp, #32]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	ldr	x22, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x22
	add	x8, sp, #464            // =464
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #528]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #520]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #512]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldp	x25, x24, [sp, #496]
	ldp	x27, x26, [sp, #480]
	ldp	x28, x21, [sp, #464]
	ldr	x1, [x23, #48]
	add	x8, sp, #384            // =384
	ldr	x23, [sp, #128]         // 8-byte Folded Reload
	mov	 x0, x23
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldp	x9, x8, [sp, #440]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldp	x13, x11, [sp, #424]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	adcs	x14, x14, x26
	ldp	x17, x15, [sp, #408]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	adcs	x18, x18, x24
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #384]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldp	x4, x0, [sp, #392]
	ldr	x6, [sp, #32]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x10, x12, x4
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x0
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	adcs	x8, x6, x8
	stp	x8, x9, [sp, #96]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #48]
	mul	 x1, x19, x22
	add	x8, sp, #304            // =304
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #368]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldp	x22, x8, [sp, #352]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x25, x24, [sp, #336]
	ldp	x27, x26, [sp, #320]
	ldp	x28, x21, [sp, #304]
	ldr	x8, [sp, #120]          // 8-byte Folded Reload
	ldr	x1, [x8, #56]
	add	x8, sp, #224            // =224
	mov	 x0, x23
	bl	.LmulPv512x64
	cmn	 x19, x28
	ldp	x9, x8, [sp, #280]
	ldr	x10, [sp, #40]          // 8-byte Folded Reload
	adcs	x10, x10, x21
	ldp	x13, x11, [sp, #264]
	ldp	x14, x12, [sp, #80]
	adcs	x12, x12, x27
	adcs	x14, x14, x26
	ldp	x17, x15, [sp, #248]
	ldp	x18, x16, [sp, #64]
	adcs	x16, x16, x25
	adcs	x18, x18, x24
	ldr	x1, [sp, #56]           // 8-byte Folded Reload
	adcs	x1, x1, x22
	ldr	x2, [sp, #224]
	ldp	x5, x3, [sp, #96]
	ldp	x4, x6, [sp, #24]
	adcs	x3, x3, x4
	ldp	x4, x0, [sp, #232]
	adcs	x5, x5, x6
	ldr	x6, [sp, #48]           // 8-byte Folded Reload
	adcs	x6, x6, xzr
	adds	 x19, x10, x2
	adcs	x21, x12, x4
	adcs	x22, x14, x0
	adcs	x23, x16, x17
	adcs	x24, x18, x15
	adcs	x25, x1, x13
	adcs	x10, x3, x11
	str	x10, [sp, #128]         // 8-byte Folded Spill
	adcs	x27, x5, x9
	adcs	x28, x6, x8
	adcs	x26, xzr, xzr
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	mul	 x1, x19, x8
	add	x8, sp, #144            // =144
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x15, x8, [sp, #200]
	ldp	x9, x10, [sp, #144]
	ldp	x11, x12, [sp, #160]
	cmn	 x19, x9
	ldp	x13, x9, [sp, #176]
	adcs	x10, x21, x10
	ldr	x14, [sp, #192]
	adcs	x11, x22, x11
	adcs	x12, x23, x12
	adcs	x13, x24, x13
	adcs	x9, x25, x9
	ldp	x16, x17, [x20, #48]
	ldp	x18, x0, [x20, #32]
	ldp	x1, x2, [x20, #16]
	ldp	 x3, x4, [x20]
	ldr	x5, [sp, #128]          // 8-byte Folded Reload
	adcs	x14, x5, x14
	adcs	x15, x27, x15
	adcs	x8, x28, x8
	adcs	x5, x26, xzr
	subs	 x3, x10, x3
	sbcs	x4, x11, x4
	sbcs	x1, x12, x1
	sbcs	x2, x13, x2
	sbcs	x18, x9, x18
	sbcs	x0, x14, x0
	sbcs	x16, x15, x16
	sbcs	x17, x8, x17
	sbcs	x5, x5, xzr
	tst	 x5, #0x1
	csel	x10, x10, x3, ne
	csel	x11, x11, x4, ne
	csel	x12, x12, x1, ne
	csel	x13, x13, x2, ne
	csel	x9, x9, x18, ne
	csel	x14, x14, x0, ne
	csel	x15, x15, x16, ne
	csel	x8, x8, x17, ne
	ldr	x16, [sp, #112]         // 8-byte Folded Reload
	stp	 x10, x11, [x16]
	stp	x12, x13, [x16, #16]
	stp	x9, x14, [x16, #32]
	stp	x15, x8, [x16, #48]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end114:
	.size	mcl_fp_mont8L, .Lfunc_end114-mcl_fp_mont8L

	.globl	mcl_fp_montNF8L
	.align	2
	.type	mcl_fp_montNF8L,@function
mcl_fp_montNF8L:                        // @mcl_fp_montNF8L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #1424           // =1424
	mov	 x20, x3
	mov	 x26, x2
	str	x26, [sp, #128]         // 8-byte Folded Spill
	ldur	x19, [x20, #-8]
	str	x19, [sp, #136]         // 8-byte Folded Spill
	ldr	 x9, [x26]
	mov	 x27, x1
	stp	x0, x27, [sp, #112]
	sub	x8, x29, #160           // =160
	mov	 x0, x27
	mov	 x1, x9
	bl	.LmulPv512x64
	ldur	x24, [x29, #-160]
	ldur	x8, [x29, #-96]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldur	x8, [x29, #-104]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldur	x8, [x29, #-112]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldur	x8, [x29, #-120]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldur	x8, [x29, #-128]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldur	x8, [x29, #-136]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldur	x8, [x29, #-144]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldur	x8, [x29, #-152]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	mul	 x1, x24, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv512x64
	ldur	x8, [x29, #-176]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldur	x8, [x29, #-184]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldur	x8, [x29, #-192]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x19, x28, [x29, #-208]
	ldp	x21, x23, [x29, #-224]
	ldp	x25, x22, [x29, #-240]
	ldr	x1, [x26, #8]
	add	x8, sp, #1184           // =1184
	mov	 x0, x27
	bl	.LmulPv512x64
	cmn	 x25, x24
	ldr	x8, [sp, #1248]
	ldr	x9, [sp, #1240]
	ldp	x10, x12, [sp, #48]
	adcs	x10, x22, x10
	ldr	x11, [sp, #1232]
	adcs	x12, x21, x12
	ldr	x13, [sp, #1224]
	ldp	x14, x16, [sp, #64]
	adcs	x14, x23, x14
	ldr	x15, [sp, #1216]
	adcs	x16, x19, x16
	ldr	x17, [sp, #1208]
	ldp	x18, x1, [sp, #80]
	adcs	x18, x28, x18
	ldr	x0, [sp, #1192]
	ldp	x2, x4, [sp, #24]
	adcs	x1, x2, x1
	ldr	x2, [sp, #1184]
	ldp	x3, x5, [sp, #96]
	adcs	x3, x4, x3
	ldr	x4, [sp, #1200]
	ldr	x6, [sp, #40]           // 8-byte Folded Reload
	adcs	x5, x6, x5
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x27, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x27
	add	x8, sp, #1104           // =1104
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #1168]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #1160]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1152]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1144]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x23, [sp, #1136]
	ldr	x24, [sp, #1128]
	ldr	x25, [sp, #1120]
	ldr	x21, [sp, #1112]
	ldr	x26, [sp, #1104]
	ldp	x22, x28, [sp, #120]
	ldr	x1, [x28, #16]
	add	x8, sp, #1024           // =1024
	mov	 x0, x22
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldr	x8, [sp, #1088]
	ldr	x9, [sp, #1080]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldr	x11, [sp, #1072]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	ldr	x13, [sp, #1064]
	adcs	x14, x14, x24
	ldr	x15, [sp, #1056]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	ldr	x17, [sp, #1048]
	ldp	x0, x2, [sp, #16]
	adcs	x18, x18, x0
	ldr	x0, [sp, #1032]
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x2
	ldr	x2, [sp, #1024]
	ldp	x4, x6, [sp, #32]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1040]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x27
	add	x8, sp, #944            // =944
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #1008]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #1000]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #992]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #984]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x23, [sp, #976]
	ldr	x24, [sp, #968]
	ldr	x25, [sp, #960]
	ldr	x21, [sp, #952]
	ldr	x26, [sp, #944]
	ldr	x1, [x28, #24]
	add	x8, sp, #864            // =864
	mov	 x27, x22
	mov	 x0, x27
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldr	x8, [sp, #928]
	ldr	x9, [sp, #920]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldr	x11, [sp, #912]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	ldr	x13, [sp, #904]
	adcs	x14, x14, x24
	ldr	x15, [sp, #896]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	ldr	x17, [sp, #888]
	ldp	x0, x2, [sp, #16]
	adcs	x18, x18, x0
	ldr	x0, [sp, #872]
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x2
	ldr	x2, [sp, #864]
	ldp	x4, x6, [sp, #32]
	adcs	x3, x3, x4
	ldr	x4, [sp, #880]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x28, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x28
	add	x8, sp, #784            // =784
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #848]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #840]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #832]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #824]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x23, [sp, #816]
	ldr	x24, [sp, #808]
	ldr	x25, [sp, #800]
	ldr	x21, [sp, #792]
	ldr	x26, [sp, #784]
	ldr	x22, [sp, #128]         // 8-byte Folded Reload
	ldr	x1, [x22, #32]
	add	x8, sp, #704            // =704
	mov	 x0, x27
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldr	x8, [sp, #768]
	ldr	x9, [sp, #760]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldr	x11, [sp, #752]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	ldr	x13, [sp, #744]
	adcs	x14, x14, x24
	ldr	x15, [sp, #736]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	ldr	x17, [sp, #728]
	ldp	x0, x2, [sp, #16]
	adcs	x18, x18, x0
	ldr	x0, [sp, #712]
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x2
	ldr	x2, [sp, #704]
	ldp	x4, x6, [sp, #32]
	adcs	x3, x3, x4
	ldr	x4, [sp, #720]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x28
	add	x8, sp, #624            // =624
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #688]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #680]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #672]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #664]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x23, [sp, #656]
	ldr	x24, [sp, #648]
	ldr	x25, [sp, #640]
	ldr	x21, [sp, #632]
	ldr	x26, [sp, #624]
	mov	 x27, x22
	ldr	x1, [x27, #40]
	add	x8, sp, #544            // =544
	ldr	x28, [sp, #120]         // 8-byte Folded Reload
	mov	 x0, x28
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldr	x8, [sp, #608]
	ldr	x9, [sp, #600]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldr	x11, [sp, #592]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	ldr	x13, [sp, #584]
	adcs	x14, x14, x24
	ldr	x15, [sp, #576]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	ldr	x17, [sp, #568]
	ldp	x0, x2, [sp, #16]
	adcs	x18, x18, x0
	ldr	x0, [sp, #552]
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x2
	ldr	x2, [sp, #544]
	ldp	x4, x6, [sp, #32]
	adcs	x3, x3, x4
	ldr	x4, [sp, #560]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x22, [sp, #136]         // 8-byte Folded Reload
	mul	 x1, x19, x22
	add	x8, sp, #464            // =464
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #528]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #520]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #512]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x23, x8, [sp, #496]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldp	x25, x24, [sp, #480]
	ldp	x26, x21, [sp, #464]
	ldr	x1, [x27, #48]
	add	x8, sp, #384            // =384
	mov	 x0, x28
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldp	x9, x8, [sp, #440]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldp	x13, x11, [sp, #424]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	adcs	x14, x14, x24
	ldp	x17, x15, [sp, #408]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	ldp	x0, x2, [sp, #16]
	adcs	x18, x18, x0
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x2
	ldp	x2, x0, [sp, #384]
	ldp	x4, x6, [sp, #32]
	adcs	x3, x3, x4
	ldr	x4, [sp, #400]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x10, x12, x0
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x4
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x17
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x15
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x13
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x11
	adcs	x9, x5, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x22
	add	x8, sp, #304            // =304
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x27, x8, [sp, #360]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldp	x22, x28, [sp, #344]
	ldp	x24, x23, [sp, #328]
	ldp	x21, x25, [sp, #312]
	ldr	x26, [sp, #304]
	ldp	x0, x8, [sp, #120]
	ldr	x1, [x8, #56]
	add	x8, sp, #224            // =224
	bl	.LmulPv512x64
	cmn	 x19, x26
	ldp	x9, x8, [sp, #280]
	ldp	x10, x18, [sp, #48]
	adcs	x10, x10, x21
	ldp	x13, x11, [sp, #264]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x25
	adcs	x14, x14, x24
	ldp	x17, x15, [sp, #248]
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x16, x16, x23
	adcs	x18, x18, x22
	ldp	x2, x0, [sp, #224]
	ldp	x3, x1, [sp, #96]
	adcs	x1, x1, x28
	adcs	x3, x3, x27
	ldr	x4, [sp, #240]
	ldr	x5, [sp, #88]           // 8-byte Folded Reload
	ldr	x6, [sp, #40]           // 8-byte Folded Reload
	adcs	x5, x5, x6
	adds	 x19, x10, x2
	adcs	x21, x12, x0
	adcs	x22, x14, x4
	adcs	x23, x16, x17
	adcs	x24, x18, x15
	adcs	x25, x1, x13
	adcs	x26, x3, x11
	adcs	x27, x5, x9
	adcs	x28, x8, xzr
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	mul	 x1, x19, x8
	add	x8, sp, #144            // =144
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x15, x8, [sp, #200]
	ldp	x9, x10, [sp, #144]
	ldp	x11, x12, [sp, #160]
	cmn	 x19, x9
	ldp	x13, x9, [sp, #176]
	adcs	x10, x21, x10
	ldr	x14, [sp, #192]
	adcs	x11, x22, x11
	adcs	x12, x23, x12
	adcs	x13, x24, x13
	adcs	x9, x25, x9
	ldp	x16, x17, [x20, #48]
	ldp	x18, x0, [x20, #32]
	ldp	x1, x2, [x20, #16]
	ldp	 x3, x4, [x20]
	adcs	x14, x26, x14
	adcs	x15, x27, x15
	adcs	x8, x28, x8
	subs	 x3, x10, x3
	sbcs	x4, x11, x4
	sbcs	x1, x12, x1
	sbcs	x2, x13, x2
	sbcs	x18, x9, x18
	sbcs	x0, x14, x0
	sbcs	x16, x15, x16
	sbcs	x17, x8, x17
	cmp	 x17, #0                // =0
	csel	x10, x10, x3, lt
	csel	x11, x11, x4, lt
	csel	x12, x12, x1, lt
	csel	x13, x13, x2, lt
	csel	x9, x9, x18, lt
	csel	x14, x14, x0, lt
	csel	x15, x15, x16, lt
	csel	x8, x8, x17, lt
	ldr	x16, [sp, #112]         // 8-byte Folded Reload
	stp	 x10, x11, [x16]
	stp	x12, x13, [x16, #16]
	stp	x9, x14, [x16, #32]
	stp	x15, x8, [x16, #48]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end115:
	.size	mcl_fp_montNF8L, .Lfunc_end115-mcl_fp_montNF8L

	.globl	mcl_fp_montRed8L
	.align	2
	.type	mcl_fp_montRed8L,@function
mcl_fp_montRed8L:                       // @mcl_fp_montRed8L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #800            // =800
	mov	 x20, x2
	ldur	x9, [x20, #-8]
	str	x9, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [x20, #48]
	str	x8, [sp, #144]          // 8-byte Folded Spill
	ldr	x8, [x20, #56]
	str	x8, [sp, #152]          // 8-byte Folded Spill
	ldr	x8, [x20, #32]
	str	x8, [sp, #120]          // 8-byte Folded Spill
	ldr	x8, [x20, #40]
	str	x8, [sp, #128]          // 8-byte Folded Spill
	ldr	x8, [x20, #16]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [x20, #24]
	str	x8, [sp, #112]          // 8-byte Folded Spill
	ldr	 x8, [x20]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [x20, #8]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [x1, #112]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [x1, #120]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [x1, #96]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldr	x8, [x1, #104]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [x1, #80]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [x1, #88]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	ldp	x28, x8, [x1, #64]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x22, x25, [x1, #48]
	ldp	x24, x19, [x1, #32]
	ldp	x27, x26, [x1, #16]
	ldp	 x21, x23, [x1]
	str	x0, [sp, #136]          // 8-byte Folded Spill
	mul	 x1, x21, x9
	sub	x8, x29, #160           // =160
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [x29, #-104]
	ldp	x11, x10, [x29, #-120]
	ldp	x16, x12, [x29, #-136]
	ldp	x13, x14, [x29, #-160]
	ldur	x15, [x29, #-144]
	cmn	 x21, x13
	adcs	x21, x23, x14
	adcs	x13, x27, x15
	adcs	x26, x26, x16
	adcs	x24, x24, x12
	adcs	x11, x19, x11
	stp	x11, x13, [sp, #8]
	adcs	x22, x22, x10
	adcs	x25, x25, x9
	adcs	x27, x28, x8
	ldr	x8, [sp, #24]           // 8-byte Folded Reload
	adcs	x28, x8, xzr
	ldp	x19, x8, [sp, #32]
	adcs	x23, x8, xzr
	ldr	x8, [sp, #48]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #48]           // 8-byte Folded Spill
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	adcs	x8, xzr, xzr
	str	x8, [sp, #40]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [x29, #-184]
	ldp	x11, x10, [x29, #-200]
	ldp	x16, x12, [x29, #-216]
	ldp	x13, x14, [x29, #-240]
	ldur	x15, [x29, #-224]
	cmn	 x21, x13
	ldr	x13, [sp, #16]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	adcs	x13, x26, x15
	str	x13, [sp, #24]          // 8-byte Folded Spill
	adcs	x24, x24, x16
	ldr	x13, [sp, #8]           // 8-byte Folded Reload
	adcs	x12, x13, x12
	str	x12, [sp, #16]          // 8-byte Folded Spill
	adcs	x22, x22, x11
	adcs	x25, x25, x10
	adcs	x27, x27, x9
	adcs	x28, x28, x8
	adcs	x23, x23, xzr
	ldr	x8, [sp, #48]           // 8-byte Folded Reload
	adcs	x26, x8, xzr
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #40]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #48]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #560            // =560
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #624]
	ldr	x9, [sp, #616]
	ldr	x10, [sp, #608]
	ldr	x11, [sp, #600]
	ldr	x12, [sp, #592]
	ldr	x13, [sp, #560]
	ldr	x14, [sp, #568]
	ldr	x15, [sp, #576]
	ldr	x16, [sp, #584]
	cmn	 x21, x13
	ldr	x13, [sp, #24]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	adcs	x13, x24, x15
	str	x13, [sp, #40]          // 8-byte Folded Spill
	ldr	x13, [sp, #16]          // 8-byte Folded Reload
	adcs	x13, x13, x16
	str	x13, [sp, #24]          // 8-byte Folded Spill
	adcs	x22, x22, x12
	adcs	x25, x25, x11
	adcs	x27, x27, x10
	adcs	x28, x28, x9
	adcs	x23, x23, x8
	adcs	x26, x26, xzr
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x24, x8, xzr
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #48]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #56]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #480            // =480
	mov	 x0, x20
	bl	.LmulPv512x64
	ldr	x8, [sp, #544]
	ldr	x9, [sp, #536]
	ldr	x10, [sp, #528]
	ldr	x11, [sp, #520]
	ldr	x12, [sp, #512]
	ldp	x13, x14, [sp, #480]
	ldp	x15, x16, [sp, #496]
	cmn	 x21, x13
	ldr	x13, [sp, #40]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	ldr	x13, [sp, #24]          // 8-byte Folded Reload
	adcs	x13, x13, x15
	adcs	x22, x22, x16
	adcs	x25, x25, x12
	adcs	x27, x27, x11
	adcs	x28, x28, x10
	adcs	x23, x23, x9
	adcs	x26, x26, x8
	adcs	x24, x24, xzr
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	stp	x13, x8, [sp, #48]
	mul	 x1, x21, x19
	add	x8, sp, #400            // =400
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [sp, #456]
	ldp	x11, x10, [sp, #440]
	ldp	x16, x12, [sp, #424]
	ldp	x13, x14, [sp, #400]
	ldr	x15, [sp, #416]
	cmn	 x21, x13
	ldr	x13, [sp, #48]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	adcs	x13, x22, x15
	str	x13, [sp, #48]          // 8-byte Folded Spill
	adcs	x25, x25, x16
	adcs	x27, x27, x12
	adcs	x28, x28, x11
	adcs	x23, x23, x10
	adcs	x26, x26, x9
	adcs	x24, x24, x8
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x22, x8, xzr
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #320            // =320
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [sp, #376]
	ldp	x11, x10, [sp, #360]
	ldp	x16, x12, [sp, #344]
	ldp	x13, x14, [sp, #320]
	ldr	x15, [sp, #336]
	cmn	 x21, x13
	ldr	x13, [sp, #48]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	adcs	x13, x25, x15
	adcs	x27, x27, x16
	adcs	x28, x28, x12
	adcs	x23, x23, x11
	adcs	x26, x26, x10
	adcs	x24, x24, x9
	ldr	x9, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x9, x8
	stp	x13, x8, [sp, #56]
	adcs	x22, x22, xzr
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x25, x8, xzr
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #240            // =240
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [sp, #296]
	ldp	x11, x10, [sp, #280]
	ldp	x16, x12, [sp, #264]
	ldp	x13, x14, [sp, #240]
	ldr	x15, [sp, #256]
	cmn	 x21, x13
	ldr	x13, [sp, #56]          // 8-byte Folded Reload
	adcs	x21, x13, x14
	adcs	x13, x27, x15
	adcs	x28, x28, x16
	adcs	x23, x23, x12
	adcs	x26, x26, x11
	adcs	x24, x24, x10
	ldr	x10, [sp, #64]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	stp	x9, x13, [sp, #64]
	adcs	x22, x22, x8
	adcs	x25, x25, xzr
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x27, x8, xzr
	mul	 x1, x21, x19
	add	x8, sp, #160            // =160
	mov	 x0, x20
	bl	.LmulPv512x64
	ldp	x9, x8, [sp, #216]
	ldp	x11, x10, [sp, #200]
	ldp	x16, x12, [sp, #184]
	ldp	x13, x14, [sp, #160]
	ldr	x15, [sp, #176]
	cmn	 x21, x13
	ldr	x13, [sp, #72]          // 8-byte Folded Reload
	adcs	x13, x13, x14
	adcs	x14, x28, x15
	adcs	x15, x23, x16
	adcs	x12, x26, x12
	adcs	x11, x24, x11
	ldr	x16, [sp, #64]          // 8-byte Folded Reload
	adcs	x10, x16, x10
	adcs	x9, x22, x9
	adcs	x8, x25, x8
	adcs	x16, x27, xzr
	ldp	x17, x18, [sp, #88]
	subs	 x17, x13, x17
	sbcs	x18, x14, x18
	ldp	x0, x1, [sp, #104]
	sbcs	x0, x15, x0
	sbcs	x1, x12, x1
	ldp	x2, x3, [sp, #120]
	sbcs	x2, x11, x2
	sbcs	x3, x10, x3
	ldp	x4, x5, [sp, #144]
	sbcs	x4, x9, x4
	sbcs	x5, x8, x5
	sbcs	x16, x16, xzr
	tst	 x16, #0x1
	csel	x13, x13, x17, ne
	csel	x14, x14, x18, ne
	csel	x15, x15, x0, ne
	csel	x12, x12, x1, ne
	csel	x11, x11, x2, ne
	csel	x10, x10, x3, ne
	csel	x9, x9, x4, ne
	csel	x8, x8, x5, ne
	ldr	x16, [sp, #136]         // 8-byte Folded Reload
	stp	 x13, x14, [x16]
	stp	x15, x12, [x16, #16]
	stp	x11, x10, [x16, #32]
	stp	x9, x8, [x16, #48]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end116:
	.size	mcl_fp_montRed8L, .Lfunc_end116-mcl_fp_montRed8L

	.globl	mcl_fp_addPre8L
	.align	2
	.type	mcl_fp_addPre8L,@function
mcl_fp_addPre8L:                        // @mcl_fp_addPre8L
// BB#0:
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x18, x2, [x2]
	ldp	 x3, x4, [x1]
	ldp	x5, x1, [x1, #16]
	adds	 x18, x18, x3
	str	 x18, [x0]
	adcs	x18, x2, x4
	adcs	x16, x16, x5
	stp	x18, x16, [x0, #8]
	adcs	x16, x17, x1
	adcs	x12, x12, x14
	stp	x16, x12, [x0, #24]
	adcs	x12, x13, x15
	adcs	x8, x8, x10
	stp	x12, x8, [x0, #40]
	adcs	x9, x9, x11
	adcs	x8, xzr, xzr
	str	x9, [x0, #56]
	mov	 x0, x8
	ret
.Lfunc_end117:
	.size	mcl_fp_addPre8L, .Lfunc_end117-mcl_fp_addPre8L

	.globl	mcl_fp_subPre8L
	.align	2
	.type	mcl_fp_subPre8L,@function
mcl_fp_subPre8L:                        // @mcl_fp_subPre8L
// BB#0:
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x18, x2, [x2]
	ldp	 x3, x4, [x1]
	ldp	x5, x1, [x1, #16]
	subs	 x18, x3, x18
	str	 x18, [x0]
	sbcs	x18, x4, x2
	sbcs	x16, x5, x16
	stp	x18, x16, [x0, #8]
	sbcs	x16, x1, x17
	sbcs	x12, x14, x12
	stp	x16, x12, [x0, #24]
	sbcs	x12, x15, x13
	sbcs	x8, x10, x8
	stp	x12, x8, [x0, #40]
	sbcs	x9, x11, x9
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0, #56]
	mov	 x0, x8
	ret
.Lfunc_end118:
	.size	mcl_fp_subPre8L, .Lfunc_end118-mcl_fp_subPre8L

	.globl	mcl_fp_shr1_8L
	.align	2
	.type	mcl_fp_shr1_8L,@function
mcl_fp_shr1_8L:                         // @mcl_fp_shr1_8L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x1, #16]
	ldp	x14, x15, [x1, #32]
	extr	x8, x9, x8, #1
	extr	x9, x12, x9, #1
	extr	x12, x13, x12, #1
	extr	x13, x14, x13, #1
	extr	x14, x15, x14, #1
	extr	x15, x10, x15, #1
	extr	x10, x11, x10, #1
	lsr	x11, x11, #1
	stp	 x8, x9, [x0]
	stp	x12, x13, [x0, #16]
	stp	x14, x15, [x0, #32]
	stp	x10, x11, [x0, #48]
	ret
.Lfunc_end119:
	.size	mcl_fp_shr1_8L, .Lfunc_end119-mcl_fp_shr1_8L

	.globl	mcl_fp_add8L
	.align	2
	.type	mcl_fp_add8L,@function
mcl_fp_add8L:                           // @mcl_fp_add8L
// BB#0:
	stp	x22, x21, [sp, #-32]!
	stp	x20, x19, [sp, #16]
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x18, x2, [x2]
	ldp	 x4, x5, [x1]
	ldp	x6, x1, [x1, #16]
	adds	 x18, x18, x4
	adcs	x2, x2, x5
	ldp	x4, x5, [x3, #48]
	adcs	x16, x16, x6
	adcs	x17, x17, x1
	ldp	x1, x6, [x3, #32]
	adcs	x7, x12, x14
	adcs	x19, x13, x15
	ldp	 x12, x13, [x3]
	stp	 x18, x2, [x0]
	stp	x16, x17, [x0, #16]
	stp	x7, x19, [x0, #32]
	adcs	x8, x8, x10
	adcs	x20, x9, x11
	stp	x8, x20, [x0, #48]
	adcs	x21, xzr, xzr
	ldp	x9, x10, [x3, #16]
	subs	 x15, x18, x12
	sbcs	x14, x2, x13
	sbcs	x13, x16, x9
	sbcs	x12, x17, x10
	sbcs	x11, x7, x1
	sbcs	x10, x19, x6
	sbcs	x9, x8, x4
	sbcs	x8, x20, x5
	sbcs	x16, x21, xzr
	and	w16, w16, #0x1
	tbnz	w16, #0, .LBB120_2
// BB#1:                                // %nocarry
	stp	 x15, x14, [x0]
	stp	x13, x12, [x0, #16]
	stp	x11, x10, [x0, #32]
	stp	x9, x8, [x0, #48]
.LBB120_2:                              // %carry
	ldp	x20, x19, [sp, #16]
	ldp	x22, x21, [sp], #32
	ret
.Lfunc_end120:
	.size	mcl_fp_add8L, .Lfunc_end120-mcl_fp_add8L

	.globl	mcl_fp_addNF8L
	.align	2
	.type	mcl_fp_addNF8L,@function
mcl_fp_addNF8L:                         // @mcl_fp_addNF8L
// BB#0:
	ldp	x8, x9, [x1, #48]
	ldp	x10, x11, [x2, #48]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x2, #32]
	ldp	x16, x17, [x1, #16]
	ldp	 x18, x1, [x1]
	ldp	 x4, x5, [x2]
	ldp	x6, x2, [x2, #16]
	adds	 x18, x4, x18
	adcs	x1, x5, x1
	ldp	x4, x5, [x3, #48]
	adcs	x16, x6, x16
	adcs	x17, x2, x17
	ldp	x2, x6, [x3, #32]
	adcs	x12, x14, x12
	adcs	x13, x15, x13
	ldp	 x14, x15, [x3]
	adcs	x8, x10, x8
	ldp	x10, x3, [x3, #16]
	adcs	x9, x11, x9
	subs	 x11, x18, x14
	sbcs	x14, x1, x15
	sbcs	x10, x16, x10
	sbcs	x15, x17, x3
	sbcs	x2, x12, x2
	sbcs	x3, x13, x6
	sbcs	x4, x8, x4
	sbcs	x5, x9, x5
	cmp	 x5, #0                 // =0
	csel	x11, x18, x11, lt
	csel	x14, x1, x14, lt
	csel	x10, x16, x10, lt
	csel	x15, x17, x15, lt
	csel	x12, x12, x2, lt
	csel	x13, x13, x3, lt
	csel	x8, x8, x4, lt
	csel	x9, x9, x5, lt
	stp	 x11, x14, [x0]
	stp	x10, x15, [x0, #16]
	stp	x12, x13, [x0, #32]
	stp	x8, x9, [x0, #48]
	ret
.Lfunc_end121:
	.size	mcl_fp_addNF8L, .Lfunc_end121-mcl_fp_addNF8L

	.globl	mcl_fp_sub8L
	.align	2
	.type	mcl_fp_sub8L,@function
mcl_fp_sub8L:                           // @mcl_fp_sub8L
// BB#0:
	ldp	x14, x15, [x2, #48]
	ldp	x16, x17, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x18, x4, [x1, #32]
	ldp	x10, x11, [x2, #16]
	ldp	 x8, x9, [x2]
	ldp	 x2, x5, [x1]
	ldp	x6, x1, [x1, #16]
	subs	 x8, x2, x8
	sbcs	x9, x5, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x6, x10
	sbcs	x11, x1, x11
	stp	x10, x11, [x0, #16]
	sbcs	x12, x18, x12
	sbcs	x13, x4, x13
	stp	x12, x13, [x0, #32]
	sbcs	x14, x16, x14
	sbcs	x15, x17, x15
	stp	x14, x15, [x0, #48]
	ngcs	 x16, xzr
	and	w16, w16, #0x1
	tbnz	w16, #0, .LBB122_2
// BB#1:                                // %nocarry
	ret
.LBB122_2:                              // %carry
	ldp	x16, x17, [x3, #48]
	ldp	 x18, x1, [x3]
	ldp	x2, x4, [x3, #16]
	ldp	x5, x3, [x3, #32]
	adds	 x8, x18, x8
	adcs	x9, x1, x9
	adcs	x10, x2, x10
	adcs	x11, x4, x11
	adcs	x12, x5, x12
	adcs	x13, x3, x13
	adcs	x14, x16, x14
	adcs	x15, x17, x15
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	stp	x14, x15, [x0, #48]
	ret
.Lfunc_end122:
	.size	mcl_fp_sub8L, .Lfunc_end122-mcl_fp_sub8L

	.globl	mcl_fp_subNF8L
	.align	2
	.type	mcl_fp_subNF8L,@function
mcl_fp_subNF8L:                         // @mcl_fp_subNF8L
// BB#0:
	ldp	x8, x9, [x2, #48]
	ldp	x10, x11, [x1, #48]
	ldp	x12, x13, [x2, #32]
	ldp	x14, x15, [x1, #32]
	ldp	x16, x17, [x2, #16]
	ldp	 x18, x2, [x2]
	ldp	 x4, x5, [x1]
	ldp	x6, x1, [x1, #16]
	subs	 x18, x4, x18
	sbcs	x2, x5, x2
	ldp	x4, x5, [x3, #48]
	sbcs	x16, x6, x16
	sbcs	x17, x1, x17
	ldp	x1, x6, [x3, #32]
	sbcs	x12, x14, x12
	sbcs	x13, x15, x13
	ldp	x14, x15, [x3, #16]
	sbcs	x8, x10, x8
	ldp	 x10, x3, [x3]
	sbcs	x9, x11, x9
	asr	x11, x9, #63
	and	 x10, x11, x10
	and	 x3, x11, x3
	and	 x14, x11, x14
	and	 x15, x11, x15
	and	 x1, x11, x1
	and	 x6, x11, x6
	and	 x4, x11, x4
	and	 x11, x11, x5
	adds	 x10, x10, x18
	str	 x10, [x0]
	adcs	x10, x3, x2
	str	x10, [x0, #8]
	adcs	x10, x14, x16
	str	x10, [x0, #16]
	adcs	x10, x15, x17
	str	x10, [x0, #24]
	adcs	x10, x1, x12
	str	x10, [x0, #32]
	adcs	x10, x6, x13
	adcs	x8, x4, x8
	stp	x10, x8, [x0, #40]
	adcs	x8, x11, x9
	str	x8, [x0, #56]
	ret
.Lfunc_end123:
	.size	mcl_fp_subNF8L, .Lfunc_end123-mcl_fp_subNF8L

	.globl	mcl_fpDbl_add8L
	.align	2
	.type	mcl_fpDbl_add8L,@function
mcl_fpDbl_add8L:                        // @mcl_fpDbl_add8L
// BB#0:
	ldp	x8, x9, [x2, #112]
	ldp	x10, x11, [x1, #112]
	ldp	x12, x13, [x2, #96]
	ldp	x14, x15, [x1, #96]
	ldp	 x16, x5, [x2]
	ldp	 x17, x6, [x1]
	ldp	x18, x4, [x2, #80]
	adds	 x16, x16, x17
	ldr	x17, [x1, #16]
	str	 x16, [x0]
	adcs	x16, x5, x6
	ldp	x5, x6, [x2, #16]
	str	x16, [x0, #8]
	adcs	x17, x5, x17
	ldp	x16, x5, [x1, #24]
	str	x17, [x0, #16]
	adcs	x16, x6, x16
	ldp	x17, x6, [x2, #32]
	str	x16, [x0, #24]
	adcs	x17, x17, x5
	ldp	x16, x5, [x1, #40]
	str	x17, [x0, #32]
	adcs	x16, x6, x16
	ldp	x17, x6, [x2, #48]
	str	x16, [x0, #40]
	ldr	x16, [x1, #56]
	adcs	x17, x17, x5
	ldp	x5, x2, [x2, #64]
	str	x17, [x0, #48]
	adcs	x16, x6, x16
	ldp	x17, x6, [x1, #64]
	str	x16, [x0, #56]
	ldp	x16, x1, [x1, #80]
	adcs	x17, x5, x17
	adcs	x2, x2, x6
	ldp	x5, x6, [x3, #48]
	adcs	x16, x18, x16
	adcs	x18, x4, x1
	ldp	x1, x4, [x3, #32]
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	ldp	x14, x15, [x3, #16]
	adcs	x8, x8, x10
	ldp	 x10, x3, [x3]
	adcs	x9, x9, x11
	adcs	x11, xzr, xzr
	subs	 x10, x17, x10
	sbcs	x3, x2, x3
	sbcs	x14, x16, x14
	sbcs	x15, x18, x15
	sbcs	x1, x12, x1
	sbcs	x4, x13, x4
	sbcs	x5, x8, x5
	sbcs	x6, x9, x6
	sbcs	x11, x11, xzr
	tst	 x11, #0x1
	csel	x10, x17, x10, ne
	csel	x11, x2, x3, ne
	csel	x14, x16, x14, ne
	csel	x15, x18, x15, ne
	csel	x12, x12, x1, ne
	csel	x13, x13, x4, ne
	csel	x8, x8, x5, ne
	csel	x9, x9, x6, ne
	stp	x10, x11, [x0, #64]
	stp	x14, x15, [x0, #80]
	stp	x12, x13, [x0, #96]
	stp	x8, x9, [x0, #112]
	ret
.Lfunc_end124:
	.size	mcl_fpDbl_add8L, .Lfunc_end124-mcl_fpDbl_add8L

	.globl	mcl_fpDbl_sub8L
	.align	2
	.type	mcl_fpDbl_sub8L,@function
mcl_fpDbl_sub8L:                        // @mcl_fpDbl_sub8L
// BB#0:
	ldp	x10, x8, [x2, #112]
	ldp	x11, x9, [x1, #112]
	ldp	x12, x13, [x2, #96]
	ldp	x14, x15, [x1, #96]
	ldp	 x16, x5, [x1]
	ldp	 x17, x4, [x2]
	ldr	x18, [x1, #80]
	subs	 x16, x16, x17
	ldr	x17, [x1, #16]
	str	 x16, [x0]
	sbcs	x16, x5, x4
	ldp	x4, x5, [x2, #16]
	str	x16, [x0, #8]
	sbcs	x17, x17, x4
	ldp	x16, x4, [x1, #24]
	str	x17, [x0, #16]
	sbcs	x16, x16, x5
	ldp	x17, x5, [x2, #32]
	str	x16, [x0, #24]
	sbcs	x17, x4, x17
	ldp	x16, x4, [x1, #40]
	str	x17, [x0, #32]
	sbcs	x16, x16, x5
	ldp	x17, x5, [x2, #48]
	str	x16, [x0, #40]
	sbcs	x17, x4, x17
	ldp	x16, x4, [x1, #56]
	str	x17, [x0, #48]
	sbcs	x16, x16, x5
	ldp	x17, x5, [x2, #64]
	str	x16, [x0, #56]
	ldr	x16, [x1, #72]
	sbcs	x17, x4, x17
	ldp	x4, x2, [x2, #80]
	ldr	x1, [x1, #88]
	sbcs	x16, x16, x5
	sbcs	x18, x18, x4
	ldp	x4, x5, [x3, #48]
	sbcs	x1, x1, x2
	sbcs	x12, x14, x12
	ldp	x14, x2, [x3, #32]
	sbcs	x13, x15, x13
	sbcs	x10, x11, x10
	ldp	x11, x15, [x3, #16]
	sbcs	x8, x9, x8
	ngcs	 x9, xzr
	tst	 x9, #0x1
	ldp	 x9, x3, [x3]
	csel	x5, x5, xzr, ne
	csel	x4, x4, xzr, ne
	csel	x2, x2, xzr, ne
	csel	x14, x14, xzr, ne
	csel	x15, x15, xzr, ne
	csel	x11, x11, xzr, ne
	csel	x3, x3, xzr, ne
	csel	x9, x9, xzr, ne
	adds	 x9, x9, x17
	str	x9, [x0, #64]
	adcs	x9, x3, x16
	str	x9, [x0, #72]
	adcs	x9, x11, x18
	str	x9, [x0, #80]
	adcs	x9, x15, x1
	str	x9, [x0, #88]
	adcs	x9, x14, x12
	str	x9, [x0, #96]
	adcs	x9, x2, x13
	str	x9, [x0, #104]
	adcs	x9, x4, x10
	adcs	x8, x5, x8
	stp	x9, x8, [x0, #112]
	ret
.Lfunc_end125:
	.size	mcl_fpDbl_sub8L, .Lfunc_end125-mcl_fpDbl_sub8L

	.align	2
	.type	.LmulPv576x64,@function
.LmulPv576x64:                          // @mulPv576x64
// BB#0:
	ldr	 x9, [x0]
	mul	 x10, x9, x1
	str	 x10, [x8]
	ldr	x10, [x0, #8]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adds	 x9, x9, x11
	str	x9, [x8, #8]
	ldr	x9, [x0, #16]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #16]
	ldr	x10, [x0, #24]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #24]
	ldr	x9, [x0, #32]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #32]
	ldr	x10, [x0, #40]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #40]
	ldr	x9, [x0, #48]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #48]
	ldr	x10, [x0, #56]
	umulh	x9, x9, x1
	mul	 x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #56]
	ldr	x9, [x0, #64]
	umulh	x10, x10, x1
	mul	 x11, x9, x1
	umulh	x9, x9, x1
	adcs	x10, x10, x11
	adcs	x9, x9, xzr
	stp	x10, x9, [x8, #64]
	ret
.Lfunc_end126:
	.size	.LmulPv576x64, .Lfunc_end126-.LmulPv576x64

	.globl	mcl_fp_mulUnitPre9L
	.align	2
	.type	mcl_fp_mulUnitPre9L,@function
mcl_fp_mulUnitPre9L:                    // @mcl_fp_mulUnitPre9L
// BB#0:
	stp	x20, x19, [sp, #-32]!
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16            // =16
	sub	sp, sp, #80             // =80
	mov	 x19, x0
	mov	 x8, sp
	mov	 x0, x1
	mov	 x1, x2
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #64]
	ldp	x11, x10, [sp, #48]
	ldp	x13, x12, [sp, #32]
	ldp	 x14, x15, [sp]
	ldp	x16, x17, [sp, #16]
	stp	 x14, x15, [x19]
	stp	x16, x17, [x19, #16]
	stp	x13, x12, [x19, #32]
	stp	x11, x10, [x19, #48]
	stp	x9, x8, [x19, #64]
	sub	sp, x29, #16            // =16
	ldp	x29, x30, [sp, #16]
	ldp	x20, x19, [sp], #32
	ret
.Lfunc_end127:
	.size	mcl_fp_mulUnitPre9L, .Lfunc_end127-mcl_fp_mulUnitPre9L

	.globl	mcl_fpDbl_mulPre9L
	.align	2
	.type	mcl_fpDbl_mulPre9L,@function
mcl_fpDbl_mulPre9L:                     // @mcl_fpDbl_mulPre9L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #752            // =752
	mov	 x21, x2
	ldr	 x9, [x21]
	mov	 x20, x1
	mov	 x19, x0
	sub	x8, x29, #160           // =160
	mov	 x0, x20
	mov	 x1, x9
	bl	.LmulPv576x64
	ldur	x8, [x29, #-88]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldur	x8, [x29, #-96]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldp	x25, x24, [x29, #-112]
	ldp	x27, x26, [x29, #-128]
	ldp	x22, x28, [x29, #-144]
	ldp	x8, x23, [x29, #-160]
	ldr	x1, [x21, #8]
	str	 x8, [x19]
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [x29, #-176]
	ldp	x11, x10, [x29, #-192]
	ldp	x13, x12, [x29, #-208]
	ldp	x14, x16, [x29, #-240]
	ldp	x17, x15, [x29, #-224]
	adds	 x14, x14, x23
	str	x14, [x19, #8]
	adcs	x22, x16, x22
	adcs	x23, x17, x28
	adcs	x27, x15, x27
	adcs	x26, x13, x26
	adcs	x25, x12, x25
	adcs	x24, x11, x24
	ldr	x1, [x21, #16]
	ldr	x11, [sp, #16]          // 8-byte Folded Reload
	adcs	x28, x10, x11
	ldr	x10, [sp, #24]          // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #512            // =512
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #584]
	ldr	x9, [sp, #576]
	ldr	x10, [sp, #568]
	ldr	x11, [sp, #560]
	ldr	x12, [sp, #552]
	ldr	x13, [sp, #544]
	ldr	x14, [sp, #512]
	ldr	x15, [sp, #536]
	ldr	x16, [sp, #520]
	ldr	x17, [sp, #528]
	adds	 x14, x22, x14
	str	x14, [x19, #16]
	adcs	x22, x23, x16
	adcs	x23, x27, x17
	adcs	x26, x26, x15
	adcs	x25, x25, x13
	adcs	x24, x24, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #24]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x28, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #432            // =432
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #496]
	ldp	x11, x10, [sp, #480]
	ldp	x13, x12, [sp, #464]
	ldp	x14, x16, [sp, #432]
	ldp	x17, x15, [sp, #448]
	adds	 x14, x22, x14
	str	x14, [x19, #24]
	adcs	x22, x23, x16
	adcs	x23, x26, x17
	adcs	x25, x25, x15
	adcs	x24, x24, x13
	adcs	x26, x27, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #32]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x28, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #352            // =352
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #416]
	ldp	x11, x10, [sp, #400]
	ldp	x13, x12, [sp, #384]
	ldp	x14, x16, [sp, #352]
	ldp	x17, x15, [sp, #368]
	adds	 x14, x22, x14
	str	x14, [x19, #32]
	adcs	x22, x23, x16
	adcs	x23, x25, x17
	adcs	x24, x24, x15
	adcs	x25, x26, x13
	adcs	x26, x27, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #40]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x28, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #272            // =272
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #336]
	ldp	x11, x10, [sp, #320]
	ldp	x13, x12, [sp, #304]
	ldp	x14, x16, [sp, #272]
	ldp	x17, x15, [sp, #288]
	adds	 x14, x22, x14
	str	x14, [x19, #40]
	adcs	x22, x23, x16
	adcs	x23, x24, x17
	adcs	x24, x25, x15
	adcs	x25, x26, x13
	adcs	x26, x27, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #48]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x28, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #192            // =192
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #256]
	ldp	x11, x10, [sp, #240]
	ldp	x13, x12, [sp, #224]
	ldp	x14, x16, [sp, #192]
	ldp	x17, x15, [sp, #208]
	adds	 x14, x22, x14
	str	x14, [x19, #48]
	adcs	x22, x23, x16
	adcs	x23, x24, x17
	adcs	x24, x25, x15
	adcs	x25, x26, x13
	adcs	x26, x27, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #56]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x28, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]
	add	x8, sp, #112            // =112
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #176]
	ldp	x11, x10, [sp, #160]
	ldp	x13, x12, [sp, #144]
	ldp	x14, x16, [sp, #112]
	ldp	x17, x15, [sp, #128]
	adds	 x14, x22, x14
	str	x14, [x19, #56]
	adcs	x22, x23, x16
	adcs	x23, x24, x17
	adcs	x24, x25, x15
	adcs	x25, x26, x13
	adcs	x26, x27, x12
	adcs	x27, x28, x11
	ldr	x1, [x21, #64]
	ldr	x11, [sp, #24]          // 8-byte Folded Reload
	adcs	x21, x11, x10
	ldr	x10, [sp, #16]          // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #24]           // 8-byte Folded Spill
	add	x8, sp, #32             // =32
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #96]
	ldp	x11, x10, [sp, #80]
	ldp	x13, x12, [sp, #64]
	ldp	x14, x16, [sp, #32]
	ldp	x17, x15, [sp, #48]
	adds	 x14, x22, x14
	str	x14, [x19, #64]
	adcs	x14, x23, x16
	str	x14, [x19, #72]
	adcs	x14, x24, x17
	str	x14, [x19, #80]
	adcs	x14, x25, x15
	adcs	x13, x26, x13
	stp	x14, x13, [x19, #88]
	adcs	x12, x27, x12
	adcs	x11, x21, x11
	stp	x12, x11, [x19, #104]
	adcs	x10, x28, x10
	str	x10, [x19, #120]
	ldr	x10, [sp, #24]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #128]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end128:
	.size	mcl_fpDbl_mulPre9L, .Lfunc_end128-mcl_fpDbl_mulPre9L

	.globl	mcl_fpDbl_sqrPre9L
	.align	2
	.type	mcl_fpDbl_sqrPre9L,@function
mcl_fpDbl_sqrPre9L:                     // @mcl_fpDbl_sqrPre9L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #736            // =736
	mov	 x20, x1
	ldr	 x1, [x20]
	mov	 x19, x0
	sub	x8, x29, #160           // =160
	mov	 x0, x20
	bl	.LmulPv576x64
	ldur	x8, [x29, #-88]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldp	x23, x22, [x29, #-104]
	ldp	x25, x24, [x29, #-120]
	ldp	x27, x26, [x29, #-136]
	ldp	x21, x28, [x29, #-152]
	ldur	x8, [x29, #-160]
	ldr	x1, [x20, #8]
	str	 x8, [x19]
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [x29, #-176]
	ldp	x11, x10, [x29, #-192]
	ldp	x13, x12, [x29, #-208]
	ldp	x14, x16, [x29, #-240]
	ldp	x17, x15, [x29, #-224]
	adds	 x14, x14, x21
	str	x14, [x19, #8]
	adcs	x21, x16, x28
	adcs	x27, x17, x27
	adcs	x26, x15, x26
	adcs	x25, x13, x25
	adcs	x24, x12, x24
	adcs	x23, x11, x23
	ldr	x1, [x20, #16]
	adcs	x22, x10, x22
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x9, x10
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #496            // =496
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #568]
	ldr	x9, [sp, #560]
	ldr	x10, [sp, #552]
	ldr	x11, [sp, #544]
	ldr	x12, [sp, #536]
	ldr	x13, [sp, #528]
	ldp	x14, x16, [sp, #496]
	ldr	x15, [sp, #520]
	ldr	x17, [sp, #512]
	adds	 x14, x21, x14
	str	x14, [x19, #16]
	adcs	x21, x27, x16
	adcs	x26, x26, x17
	adcs	x25, x25, x15
	adcs	x24, x24, x13
	adcs	x23, x23, x12
	adcs	x22, x22, x11
	ldr	x1, [x20, #24]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #416            // =416
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #480]
	ldp	x11, x10, [sp, #464]
	ldp	x13, x12, [sp, #448]
	ldp	x14, x16, [sp, #416]
	ldp	x17, x15, [sp, #432]
	adds	 x14, x21, x14
	str	x14, [x19, #24]
	adcs	x21, x26, x16
	adcs	x25, x25, x17
	adcs	x24, x24, x15
	adcs	x23, x23, x13
	adcs	x22, x22, x12
	adcs	x26, x27, x11
	ldr	x1, [x20, #32]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #336            // =336
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #400]
	ldp	x11, x10, [sp, #384]
	ldp	x13, x12, [sp, #368]
	ldp	x14, x16, [sp, #336]
	ldp	x17, x15, [sp, #352]
	adds	 x14, x21, x14
	str	x14, [x19, #32]
	adcs	x21, x25, x16
	adcs	x24, x24, x17
	adcs	x23, x23, x15
	adcs	x22, x22, x13
	adcs	x25, x26, x12
	adcs	x26, x27, x11
	ldr	x1, [x20, #40]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #256            // =256
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #320]
	ldp	x11, x10, [sp, #304]
	ldp	x13, x12, [sp, #288]
	ldp	x14, x16, [sp, #256]
	ldp	x17, x15, [sp, #272]
	adds	 x14, x21, x14
	str	x14, [x19, #40]
	adcs	x21, x24, x16
	adcs	x23, x23, x17
	adcs	x22, x22, x15
	adcs	x24, x25, x13
	adcs	x25, x26, x12
	adcs	x26, x27, x11
	ldr	x1, [x20, #48]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #176            // =176
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #240]
	ldp	x11, x10, [sp, #224]
	ldp	x13, x12, [sp, #208]
	ldp	x14, x16, [sp, #176]
	ldp	x17, x15, [sp, #192]
	adds	 x14, x21, x14
	str	x14, [x19, #48]
	adcs	x21, x23, x16
	adcs	x22, x22, x17
	adcs	x23, x24, x15
	adcs	x24, x25, x13
	adcs	x25, x26, x12
	adcs	x26, x27, x11
	ldr	x1, [x20, #56]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #96             // =96
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #160]
	ldp	x11, x10, [sp, #144]
	ldp	x13, x12, [sp, #128]
	ldp	x14, x16, [sp, #96]
	ldp	x17, x15, [sp, #112]
	adds	 x14, x21, x14
	str	x14, [x19, #56]
	adcs	x21, x22, x16
	adcs	x22, x23, x17
	adcs	x23, x24, x15
	adcs	x24, x25, x13
	adcs	x25, x26, x12
	adcs	x26, x27, x11
	ldr	x1, [x20, #64]
	adcs	x27, x28, x10
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x28, x10, x9
	adcs	x8, x8, xzr
	str	x8, [sp, #8]            // 8-byte Folded Spill
	add	x8, sp, #16             // =16
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #80]
	ldp	x11, x10, [sp, #64]
	ldp	x13, x12, [sp, #48]
	ldp	x14, x16, [sp, #16]
	ldp	x17, x15, [sp, #32]
	adds	 x14, x21, x14
	str	x14, [x19, #64]
	adcs	x14, x22, x16
	str	x14, [x19, #72]
	adcs	x14, x23, x17
	str	x14, [x19, #80]
	adcs	x14, x24, x15
	adcs	x13, x25, x13
	stp	x14, x13, [x19, #88]
	adcs	x12, x26, x12
	adcs	x11, x27, x11
	stp	x12, x11, [x19, #104]
	adcs	x10, x28, x10
	str	x10, [x19, #120]
	ldr	x10, [sp, #8]           // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #128]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end129:
	.size	mcl_fpDbl_sqrPre9L, .Lfunc_end129-mcl_fpDbl_sqrPre9L

	.globl	mcl_fp_mont9L
	.align	2
	.type	mcl_fp_mont9L,@function
mcl_fp_mont9L:                          // @mcl_fp_mont9L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #1600           // =1600
	mov	 x20, x3
	mov	 x28, x2
	str	x28, [sp, #136]         // 8-byte Folded Spill
	ldur	x19, [x20, #-8]
	str	x19, [sp, #144]         // 8-byte Folded Spill
	ldr	 x9, [x28]
	mov	 x23, x1
	str	x23, [sp, #152]         // 8-byte Folded Spill
	str	x0, [sp, #128]          // 8-byte Folded Spill
	sub	x8, x29, #160           // =160
	mov	 x0, x23
	mov	 x1, x9
	bl	.LmulPv576x64
	ldur	x24, [x29, #-160]
	ldur	x8, [x29, #-88]
	str	x8, [sp, #120]          // 8-byte Folded Spill
	ldur	x8, [x29, #-96]
	str	x8, [sp, #112]          // 8-byte Folded Spill
	ldur	x8, [x29, #-104]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldur	x8, [x29, #-112]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldur	x8, [x29, #-120]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldur	x8, [x29, #-128]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldur	x8, [x29, #-136]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldur	x8, [x29, #-144]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldur	x8, [x29, #-152]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	mul	 x1, x24, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv576x64
	ldur	x8, [x29, #-168]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldur	x8, [x29, #-176]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldur	x8, [x29, #-184]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldur	x8, [x29, #-192]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x21, x19, [x29, #-208]
	ldp	x26, x22, [x29, #-224]
	ldp	x27, x25, [x29, #-240]
	ldr	x1, [x28, #8]
	add	x8, sp, #1360           // =1360
	mov	 x0, x23
	bl	.LmulPv576x64
	cmn	 x27, x24
	ldr	x8, [sp, #1432]
	ldr	x9, [sp, #1424]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x25, x10
	ldr	x11, [sp, #1416]
	ldp	x12, x14, [sp, #64]
	adcs	x12, x26, x12
	ldr	x13, [sp, #1408]
	adcs	x14, x22, x14
	ldr	x15, [sp, #1400]
	ldp	x16, x18, [sp, #80]
	adcs	x16, x21, x16
	ldr	x17, [sp, #1392]
	adcs	x18, x19, x18
	ldr	x0, [sp, #1384]
	ldp	x1, x3, [sp, #96]
	ldp	x2, x4, [sp, #24]
	adcs	x1, x2, x1
	ldr	x2, [sp, #1376]
	adcs	x3, x4, x3
	ldr	x4, [sp, #1360]
	ldp	x5, x7, [sp, #112]
	ldr	x6, [sp, #40]           // 8-byte Folded Reload
	adcs	x5, x6, x5
	ldr	x6, [sp, #1368]
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x7, x19, x7
	adcs	x19, xzr, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	ldr	x24, [sp, #144]         // 8-byte Folded Reload
	mul	 x1, x21, x24
	add	x8, sp, #1280           // =1280
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1352]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #1344]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1336]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1328]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #1320]
	ldr	x27, [sp, #1312]
	ldr	x28, [sp, #1304]
	ldr	x22, [sp, #1296]
	ldr	x19, [sp, #1288]
	ldr	x23, [sp, #1280]
	ldr	x25, [sp, #136]         // 8-byte Folded Reload
	ldr	x1, [x25, #16]
	add	x8, sp, #1200           // =1200
	ldr	x0, [sp, #152]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldr	x8, [sp, #1272]
	ldr	x9, [sp, #1264]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldr	x11, [sp, #1256]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	ldr	x13, [sp, #1248]
	adcs	x14, x14, x28
	ldr	x15, [sp, #1240]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	ldr	x17, [sp, #1232]
	adcs	x18, x18, x26
	ldr	x0, [sp, #1224]
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #1216]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1200]
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldr	x6, [sp, #1208]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	mul	 x1, x21, x24
	add	x8, sp, #1120           // =1120
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1192]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #1184]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1176]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1168]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #1160]
	ldr	x27, [sp, #1152]
	ldr	x28, [sp, #1144]
	ldr	x22, [sp, #1136]
	ldr	x19, [sp, #1128]
	ldr	x23, [sp, #1120]
	ldr	x1, [x25, #24]
	add	x8, sp, #1040           // =1040
	ldr	x24, [sp, #152]         // 8-byte Folded Reload
	mov	 x0, x24
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldr	x8, [sp, #1112]
	ldr	x9, [sp, #1104]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldr	x11, [sp, #1096]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	ldr	x13, [sp, #1088]
	adcs	x14, x14, x28
	ldr	x15, [sp, #1080]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	ldr	x17, [sp, #1072]
	adcs	x18, x18, x26
	ldr	x0, [sp, #1064]
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #1056]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1040]
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldr	x6, [sp, #1048]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	ldr	x8, [sp, #144]          // 8-byte Folded Reload
	mul	 x1, x21, x8
	add	x8, sp, #960            // =960
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1032]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #1024]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1016]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1008]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #1000]
	ldr	x27, [sp, #992]
	ldr	x28, [sp, #984]
	ldr	x22, [sp, #976]
	ldr	x19, [sp, #968]
	ldr	x23, [sp, #960]
	ldr	x1, [x25, #32]
	add	x8, sp, #880            // =880
	mov	 x0, x24
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldr	x8, [sp, #952]
	ldr	x9, [sp, #944]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldr	x11, [sp, #936]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	ldr	x13, [sp, #928]
	adcs	x14, x14, x28
	ldr	x15, [sp, #920]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	ldr	x17, [sp, #912]
	adcs	x18, x18, x26
	ldr	x0, [sp, #904]
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #896]
	adcs	x3, x3, x4
	ldr	x4, [sp, #880]
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldr	x6, [sp, #888]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	ldr	x25, [sp, #144]         // 8-byte Folded Reload
	mul	 x1, x21, x25
	add	x8, sp, #800            // =800
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #872]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #864]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #856]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #848]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #840]
	ldr	x27, [sp, #832]
	ldr	x28, [sp, #824]
	ldr	x22, [sp, #816]
	ldr	x19, [sp, #808]
	ldr	x23, [sp, #800]
	ldr	x24, [sp, #136]         // 8-byte Folded Reload
	ldr	x1, [x24, #40]
	add	x8, sp, #720            // =720
	ldr	x0, [sp, #152]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldr	x8, [sp, #792]
	ldr	x9, [sp, #784]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldr	x11, [sp, #776]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	ldr	x13, [sp, #768]
	adcs	x14, x14, x28
	ldr	x15, [sp, #760]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	ldr	x17, [sp, #752]
	adcs	x18, x18, x26
	ldr	x0, [sp, #744]
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #736]
	adcs	x3, x3, x4
	ldr	x4, [sp, #720]
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldr	x6, [sp, #728]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	mul	 x1, x21, x25
	add	x8, sp, #640            // =640
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #712]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #704]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #696]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #688]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #680]
	ldr	x27, [sp, #672]
	ldr	x28, [sp, #664]
	ldr	x22, [sp, #656]
	ldr	x19, [sp, #648]
	ldr	x23, [sp, #640]
	ldr	x1, [x24, #48]
	add	x8, sp, #560            // =560
	ldr	x25, [sp, #152]         // 8-byte Folded Reload
	mov	 x0, x25
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldr	x8, [sp, #632]
	ldr	x9, [sp, #624]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldr	x11, [sp, #616]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	ldr	x13, [sp, #608]
	adcs	x14, x14, x28
	ldr	x15, [sp, #600]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	ldr	x17, [sp, #592]
	adcs	x18, x18, x26
	ldr	x0, [sp, #584]
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldr	x2, [sp, #576]
	adcs	x3, x3, x4
	ldr	x4, [sp, #560]
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldr	x6, [sp, #568]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	ldr	x24, [sp, #144]         // 8-byte Folded Reload
	mul	 x1, x21, x24
	add	x8, sp, #480            // =480
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #552]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [sp, #544]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #536]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #528]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x26, [sp, #520]
	ldr	x27, [sp, #512]
	ldp	x22, x28, [sp, #496]
	ldp	x23, x19, [sp, #480]
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	ldr	x1, [x8, #56]
	add	x8, sp, #400            // =400
	mov	 x0, x25
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldp	x9, x8, [sp, #464]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldp	x13, x11, [sp, #448]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	adcs	x14, x14, x28
	ldp	x17, x15, [sp, #432]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	adcs	x18, x18, x26
	ldp	x3, x1, [sp, #64]
	ldp	x2, x4, [sp, #16]
	adcs	x1, x1, x2
	ldp	x2, x0, [sp, #416]
	adcs	x3, x3, x4
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldp	x4, x6, [sp, #400]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x10, x12, x6
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x14, x2
	str	x10, [sp, #104]         // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #96]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #88]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	adcs	x8, x19, x8
	stp	x8, x9, [sp, #112]
	adcs	x8, xzr, xzr
	stp	x8, x10, [sp, #56]
	mul	 x1, x21, x24
	add	x8, sp, #320            // =320
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #392]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldp	x24, x8, [sp, #376]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldp	x26, x25, [sp, #360]
	ldp	x28, x27, [sp, #344]
	ldp	x19, x22, [sp, #328]
	ldr	x23, [sp, #320]
	ldr	x8, [sp, #136]          // 8-byte Folded Reload
	ldr	x1, [x8, #64]
	add	x8, sp, #240            // =240
	ldr	x0, [sp, #152]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x21, x23
	ldp	x9, x8, [sp, #304]
	ldr	x10, [sp, #48]          // 8-byte Folded Reload
	adcs	x10, x10, x19
	ldp	x13, x11, [sp, #288]
	ldp	x14, x12, [sp, #96]
	adcs	x12, x12, x22
	adcs	x14, x14, x28
	ldp	x17, x15, [sp, #272]
	ldp	x18, x16, [sp, #80]
	adcs	x16, x16, x27
	adcs	x18, x18, x26
	ldp	x2, x0, [sp, #256]
	ldp	x3, x1, [sp, #64]
	adcs	x1, x1, x25
	adcs	x3, x3, x24
	ldp	x7, x5, [sp, #112]
	ldp	x6, x19, [sp, #32]
	adcs	x5, x5, x6
	ldp	x4, x6, [sp, #240]
	adcs	x7, x7, x19
	ldr	x19, [sp, #56]          // 8-byte Folded Reload
	adcs	x19, x19, xzr
	adds	 x21, x10, x4
	adcs	x22, x12, x6
	adcs	x23, x14, x2
	adcs	x24, x16, x0
	adcs	x25, x18, x17
	adcs	x26, x1, x15
	adcs	x27, x3, x13
	adcs	x10, x5, x11
	str	x10, [sp, #152]         // 8-byte Folded Spill
	adcs	x9, x7, x9
	str	x9, [sp, #136]          // 8-byte Folded Spill
	adcs	x19, x19, x8
	adcs	x28, xzr, xzr
	ldr	x8, [sp, #144]          // 8-byte Folded Reload
	mul	 x1, x21, x8
	add	x8, sp, #160            // =160
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x16, x8, [sp, #224]
	ldp	x9, x10, [sp, #160]
	ldp	x11, x12, [sp, #176]
	cmn	 x21, x9
	ldp	x13, x9, [sp, #192]
	adcs	x10, x22, x10
	ldp	x14, x15, [sp, #208]
	adcs	x11, x23, x11
	adcs	x12, x24, x12
	adcs	x13, x25, x13
	adcs	x9, x26, x9
	adcs	x14, x27, x14
	ldp	x0, x17, [x20, #56]
	ldp	x2, x18, [x20, #40]
	ldp	x4, x1, [x20, #24]
	ldp	x6, x3, [x20, #8]
	ldr	 x5, [x20]
	ldr	x7, [sp, #152]          // 8-byte Folded Reload
	adcs	x15, x7, x15
	ldr	x7, [sp, #136]          // 8-byte Folded Reload
	adcs	x16, x7, x16
	adcs	x8, x19, x8
	adcs	x7, x28, xzr
	subs	 x5, x10, x5
	sbcs	x6, x11, x6
	sbcs	x3, x12, x3
	sbcs	x4, x13, x4
	sbcs	x1, x9, x1
	sbcs	x2, x14, x2
	sbcs	x18, x15, x18
	sbcs	x0, x16, x0
	sbcs	x17, x8, x17
	sbcs	x7, x7, xzr
	tst	 x7, #0x1
	csel	x10, x10, x5, ne
	csel	x11, x11, x6, ne
	csel	x12, x12, x3, ne
	csel	x13, x13, x4, ne
	csel	x9, x9, x1, ne
	csel	x14, x14, x2, ne
	csel	x15, x15, x18, ne
	csel	x16, x16, x0, ne
	csel	x8, x8, x17, ne
	ldr	x17, [sp, #128]         // 8-byte Folded Reload
	stp	 x10, x11, [x17]
	stp	x12, x13, [x17, #16]
	stp	x9, x14, [x17, #32]
	stp	x15, x16, [x17, #48]
	str	x8, [x17, #64]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end130:
	.size	mcl_fp_mont9L, .Lfunc_end130-mcl_fp_mont9L

	.globl	mcl_fp_montNF9L
	.align	2
	.type	mcl_fp_montNF9L,@function
mcl_fp_montNF9L:                        // @mcl_fp_montNF9L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #1584           // =1584
	mov	 x20, x3
	mov	 x28, x2
	str	x28, [sp, #120]         // 8-byte Folded Spill
	ldur	x19, [x20, #-8]
	str	x19, [sp, #128]         // 8-byte Folded Spill
	ldr	 x9, [x28]
	mov	 x23, x1
	str	x23, [sp, #136]         // 8-byte Folded Spill
	str	x0, [sp, #112]          // 8-byte Folded Spill
	sub	x8, x29, #160           // =160
	mov	 x0, x23
	mov	 x1, x9
	bl	.LmulPv576x64
	ldur	x24, [x29, #-160]
	ldur	x8, [x29, #-88]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldur	x8, [x29, #-96]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldur	x8, [x29, #-104]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldur	x8, [x29, #-112]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldur	x8, [x29, #-120]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldur	x8, [x29, #-128]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldur	x8, [x29, #-136]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldur	x8, [x29, #-144]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	ldur	x8, [x29, #-152]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	mul	 x1, x24, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv576x64
	ldur	x8, [x29, #-168]
	str	x8, [sp, #40]           // 8-byte Folded Spill
	ldur	x8, [x29, #-176]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldur	x8, [x29, #-184]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldur	x8, [x29, #-192]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldp	x21, x19, [x29, #-208]
	ldp	x26, x22, [x29, #-224]
	ldp	x27, x25, [x29, #-240]
	ldr	x1, [x28, #8]
	add	x8, sp, #1344           // =1344
	mov	 x0, x23
	bl	.LmulPv576x64
	cmn	 x27, x24
	ldr	x8, [sp, #1416]
	ldr	x9, [sp, #1408]
	ldr	x10, [sp, #32]          // 8-byte Folded Reload
	adcs	x10, x25, x10
	ldr	x11, [sp, #1400]
	ldp	x12, x14, [sp, #48]
	adcs	x12, x26, x12
	ldr	x13, [sp, #1392]
	adcs	x14, x22, x14
	ldr	x15, [sp, #1384]
	ldp	x16, x18, [sp, #64]
	adcs	x16, x21, x16
	ldr	x17, [sp, #1376]
	adcs	x18, x19, x18
	ldr	x0, [sp, #1368]
	ldp	x1, x3, [sp, #80]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x2, x1
	ldr	x2, [sp, #1352]
	adcs	x3, x4, x3
	ldr	x4, [sp, #1344]
	ldp	x5, x7, [sp, #96]
	ldr	x6, [sp, #24]           // 8-byte Folded Reload
	adcs	x5, x6, x5
	ldr	x6, [sp, #1360]
	ldr	x19, [sp, #40]          // 8-byte Folded Reload
	adcs	x7, x19, x7
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x22, [sp, #128]         // 8-byte Folded Reload
	mul	 x1, x19, x22
	add	x8, sp, #1264           // =1264
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1336]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1328]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1320]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #1312]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x24, [sp, #1304]
	ldr	x25, [sp, #1296]
	ldr	x26, [sp, #1288]
	ldr	x21, [sp, #1280]
	ldr	x27, [sp, #1272]
	ldr	x28, [sp, #1264]
	ldr	x23, [sp, #120]         // 8-byte Folded Reload
	ldr	x1, [x23, #16]
	add	x8, sp, #1184           // =1184
	ldr	x0, [sp, #136]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldr	x8, [sp, #1256]
	ldr	x9, [sp, #1248]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldr	x11, [sp, #1240]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	ldr	x13, [sp, #1232]
	adcs	x14, x14, x26
	ldr	x15, [sp, #1224]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	ldr	x17, [sp, #1216]
	adcs	x18, x18, x24
	ldr	x0, [sp, #1208]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldr	x2, [sp, #1192]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1184]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldr	x6, [sp, #1200]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x22
	add	x8, sp, #1104           // =1104
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1176]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1168]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1160]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #1152]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x24, [sp, #1144]
	ldr	x25, [sp, #1136]
	ldr	x26, [sp, #1128]
	ldr	x21, [sp, #1120]
	ldr	x27, [sp, #1112]
	ldr	x28, [sp, #1104]
	ldr	x1, [x23, #24]
	add	x8, sp, #1024           // =1024
	ldr	x22, [sp, #136]         // 8-byte Folded Reload
	mov	 x0, x22
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldr	x8, [sp, #1096]
	ldr	x9, [sp, #1088]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldr	x11, [sp, #1080]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	ldr	x13, [sp, #1072]
	adcs	x14, x14, x26
	ldr	x15, [sp, #1064]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	ldr	x17, [sp, #1056]
	adcs	x18, x18, x24
	ldr	x0, [sp, #1048]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldr	x2, [sp, #1032]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #1024]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldr	x6, [sp, #1040]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #128]          // 8-byte Folded Reload
	mul	 x1, x19, x8
	add	x8, sp, #944            // =944
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #1016]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #1008]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #1000]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #992]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x24, [sp, #984]
	ldr	x25, [sp, #976]
	ldr	x26, [sp, #968]
	ldr	x21, [sp, #960]
	ldr	x27, [sp, #952]
	ldr	x28, [sp, #944]
	ldr	x1, [x23, #32]
	add	x8, sp, #864            // =864
	mov	 x0, x22
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldr	x8, [sp, #936]
	ldr	x9, [sp, #928]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldr	x11, [sp, #920]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	ldr	x13, [sp, #912]
	adcs	x14, x14, x26
	ldr	x15, [sp, #904]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	ldr	x17, [sp, #896]
	adcs	x18, x18, x24
	ldr	x0, [sp, #888]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldr	x2, [sp, #872]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #864]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldr	x6, [sp, #880]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x23, [sp, #128]         // 8-byte Folded Reload
	mul	 x1, x19, x23
	add	x8, sp, #784            // =784
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #856]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #848]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #840]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #832]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x24, [sp, #824]
	ldr	x25, [sp, #816]
	ldr	x26, [sp, #808]
	ldr	x21, [sp, #800]
	ldr	x27, [sp, #792]
	ldr	x28, [sp, #784]
	ldr	x22, [sp, #120]         // 8-byte Folded Reload
	ldr	x1, [x22, #40]
	add	x8, sp, #704            // =704
	ldr	x0, [sp, #136]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldr	x8, [sp, #776]
	ldr	x9, [sp, #768]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldr	x11, [sp, #760]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	ldr	x13, [sp, #752]
	adcs	x14, x14, x26
	ldr	x15, [sp, #744]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	ldr	x17, [sp, #736]
	adcs	x18, x18, x24
	ldr	x0, [sp, #728]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldr	x2, [sp, #712]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #704]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldr	x6, [sp, #720]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x23
	add	x8, sp, #624            // =624
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #696]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #688]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #680]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #672]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldr	x24, [sp, #664]
	ldr	x25, [sp, #656]
	ldr	x26, [sp, #648]
	ldr	x21, [sp, #640]
	ldr	x27, [sp, #632]
	ldr	x28, [sp, #624]
	ldr	x1, [x22, #48]
	add	x8, sp, #544            // =544
	ldr	x23, [sp, #136]         // 8-byte Folded Reload
	mov	 x0, x23
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldr	x8, [sp, #616]
	ldr	x9, [sp, #608]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldr	x11, [sp, #600]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	ldr	x13, [sp, #592]
	adcs	x14, x14, x26
	ldr	x15, [sp, #584]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	ldr	x17, [sp, #576]
	adcs	x18, x18, x24
	ldr	x0, [sp, #568]
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldr	x2, [sp, #552]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldr	x4, [sp, #544]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldr	x6, [sp, #560]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x22, [sp, #128]         // 8-byte Folded Reload
	mul	 x1, x19, x22
	add	x8, sp, #464            // =464
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #536]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldr	x8, [sp, #528]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldr	x8, [sp, #520]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldr	x8, [sp, #512]
	str	x8, [sp, #8]            // 8-byte Folded Spill
	ldp	x25, x24, [sp, #496]
	ldp	x21, x26, [sp, #480]
	ldp	x28, x27, [sp, #464]
	ldr	x8, [sp, #120]          // 8-byte Folded Reload
	ldr	x1, [x8, #56]
	add	x8, sp, #384            // =384
	mov	 x0, x23
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldp	x9, x8, [sp, #448]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldp	x13, x11, [sp, #432]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	adcs	x14, x14, x26
	ldp	x17, x15, [sp, #416]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	adcs	x18, x18, x24
	ldp	x2, x4, [sp, #8]
	adcs	x1, x1, x2
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x4
	ldp	x4, x2, [sp, #384]
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldp	x6, x0, [sp, #400]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x10, x12, x2
	str	x10, [sp, #40]          // 8-byte Folded Spill
	adcs	x10, x14, x6
	str	x10, [sp, #80]          // 8-byte Folded Spill
	adcs	x10, x16, x0
	str	x10, [sp, #72]          // 8-byte Folded Spill
	adcs	x10, x18, x17
	str	x10, [sp, #64]          // 8-byte Folded Spill
	adcs	x10, x1, x15
	str	x10, [sp, #56]          // 8-byte Folded Spill
	adcs	x10, x3, x13
	str	x10, [sp, #48]          // 8-byte Folded Spill
	adcs	x10, x5, x11
	adcs	x9, x7, x9
	stp	x9, x10, [sp, #96]
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	mul	 x1, x19, x22
	add	x8, sp, #304            // =304
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #376]
	str	x8, [sp, #32]           // 8-byte Folded Spill
	ldp	x22, x8, [sp, #360]
	str	x8, [sp, #24]           // 8-byte Folded Spill
	ldp	x24, x23, [sp, #344]
	ldp	x26, x25, [sp, #328]
	ldp	x27, x21, [sp, #312]
	ldr	x28, [sp, #304]
	ldr	x8, [sp, #120]          // 8-byte Folded Reload
	ldr	x1, [x8, #64]
	add	x8, sp, #224            // =224
	ldr	x0, [sp, #136]          // 8-byte Folded Reload
	bl	.LmulPv576x64
	cmn	 x19, x28
	ldp	x9, x8, [sp, #288]
	ldp	x10, x1, [sp, #40]
	adcs	x10, x10, x27
	ldp	x13, x11, [sp, #272]
	ldp	x14, x12, [sp, #72]
	adcs	x12, x12, x21
	adcs	x14, x14, x26
	ldp	x17, x15, [sp, #256]
	ldp	x18, x16, [sp, #56]
	adcs	x16, x16, x25
	adcs	x18, x18, x24
	adcs	x1, x1, x23
	ldp	x4, x2, [sp, #224]
	ldp	x5, x3, [sp, #96]
	adcs	x3, x3, x22
	ldp	x6, x19, [sp, #24]
	adcs	x5, x5, x6
	ldp	x6, x0, [sp, #240]
	ldr	x7, [sp, #88]           // 8-byte Folded Reload
	adcs	x7, x7, x19
	adds	 x19, x10, x4
	adcs	x21, x12, x2
	adcs	x22, x14, x6
	adcs	x23, x16, x0
	adcs	x24, x18, x17
	adcs	x25, x1, x15
	adcs	x26, x3, x13
	adcs	x10, x5, x11
	str	x10, [sp, #136]         // 8-byte Folded Spill
	adcs	x28, x7, x9
	adcs	x27, x8, xzr
	ldr	x8, [sp, #128]          // 8-byte Folded Reload
	mul	 x1, x19, x8
	add	x8, sp, #144            // =144
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x16, x8, [sp, #208]
	ldp	x9, x10, [sp, #144]
	ldp	x11, x12, [sp, #160]
	cmn	 x19, x9
	ldp	x13, x9, [sp, #176]
	adcs	x10, x21, x10
	ldp	x14, x15, [sp, #192]
	adcs	x11, x22, x11
	adcs	x12, x23, x12
	adcs	x13, x24, x13
	adcs	x9, x25, x9
	adcs	x14, x26, x14
	ldp	x0, x17, [x20, #56]
	ldp	x2, x18, [x20, #40]
	ldp	x4, x1, [x20, #24]
	ldp	x6, x3, [x20, #8]
	ldr	 x5, [x20]
	ldr	x7, [sp, #136]          // 8-byte Folded Reload
	adcs	x15, x7, x15
	adcs	x16, x28, x16
	adcs	x8, x27, x8
	subs	 x5, x10, x5
	sbcs	x6, x11, x6
	sbcs	x3, x12, x3
	sbcs	x4, x13, x4
	sbcs	x1, x9, x1
	sbcs	x2, x14, x2
	sbcs	x18, x15, x18
	sbcs	x0, x16, x0
	sbcs	x17, x8, x17
	asr	x7, x17, #63
	cmp	 x7, #0                 // =0
	csel	x10, x10, x5, lt
	csel	x11, x11, x6, lt
	csel	x12, x12, x3, lt
	csel	x13, x13, x4, lt
	csel	x9, x9, x1, lt
	csel	x14, x14, x2, lt
	csel	x15, x15, x18, lt
	csel	x16, x16, x0, lt
	csel	x8, x8, x17, lt
	ldr	x17, [sp, #112]         // 8-byte Folded Reload
	stp	 x10, x11, [x17]
	stp	x12, x13, [x17, #16]
	stp	x9, x14, [x17, #32]
	stp	x15, x16, [x17, #48]
	str	x8, [x17, #64]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end131:
	.size	mcl_fp_montNF9L, .Lfunc_end131-mcl_fp_montNF9L

	.globl	mcl_fp_montRed9L
	.align	2
	.type	mcl_fp_montRed9L,@function
mcl_fp_montRed9L:                       // @mcl_fp_montRed9L
// BB#0:
	stp	x28, x27, [sp, #-96]!
	stp	x26, x25, [sp, #16]
	stp	x24, x23, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	stp	x29, x30, [sp, #80]
	add	x29, sp, #80            // =80
	sub	sp, sp, #912            // =912
	mov	 x20, x2
	ldur	x9, [x20, #-8]
	str	x9, [sp, #40]           // 8-byte Folded Spill
	ldr	x8, [x20, #64]
	str	x8, [sp, #184]          // 8-byte Folded Spill
	ldr	x8, [x20, #48]
	str	x8, [sp, #168]          // 8-byte Folded Spill
	ldr	x8, [x20, #56]
	str	x8, [sp, #176]          // 8-byte Folded Spill
	ldr	x8, [x20, #32]
	str	x8, [sp, #144]          // 8-byte Folded Spill
	ldr	x8, [x20, #40]
	str	x8, [sp, #152]          // 8-byte Folded Spill
	ldr	x8, [x20, #16]
	str	x8, [sp, #128]          // 8-byte Folded Spill
	ldr	x8, [x20, #24]
	str	x8, [sp, #136]          // 8-byte Folded Spill
	ldr	 x8, [x20]
	str	x8, [sp, #112]          // 8-byte Folded Spill
	ldr	x8, [x20, #8]
	str	x8, [sp, #120]          // 8-byte Folded Spill
	ldr	x8, [x1, #128]
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [x1, #136]
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [x1, #112]
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [x1, #120]
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [x1, #96]
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [x1, #104]
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [x1, #80]
	str	x8, [sp, #48]           // 8-byte Folded Spill
	ldr	x8, [x1, #88]
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldp	x23, x8, [x1, #64]
	str	x8, [sp, #16]           // 8-byte Folded Spill
	ldp	x25, x19, [x1, #48]
	ldp	x28, x27, [x1, #32]
	ldp	x22, x24, [x1, #16]
	ldp	 x21, x26, [x1]
	str	x0, [sp, #160]          // 8-byte Folded Spill
	mul	 x1, x21, x9
	sub	x8, x29, #160           // =160
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [x29, #-96]
	ldp	x11, x10, [x29, #-112]
	ldp	x13, x12, [x29, #-128]
	ldp	x14, x15, [x29, #-160]
	ldp	x16, x17, [x29, #-144]
	cmn	 x21, x14
	adcs	x21, x26, x15
	adcs	x14, x22, x16
	adcs	x24, x24, x17
	adcs	x26, x28, x13
	adcs	x27, x27, x12
	adcs	x25, x25, x11
	adcs	x10, x19, x10
	stp	x10, x14, [sp, #24]
	adcs	x23, x23, x9
	ldr	x9, [sp, #16]           // 8-byte Folded Reload
	adcs	x28, x9, x8
	ldr	x8, [sp, #48]           // 8-byte Folded Reload
	adcs	x22, x8, xzr
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #56]           // 8-byte Folded Spill
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	adcs	x8, xzr, xzr
	str	x8, [sp, #48]           // 8-byte Folded Spill
	ldr	x19, [sp, #40]          // 8-byte Folded Reload
	mul	 x1, x21, x19
	sub	x8, x29, #240           // =240
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [x29, #-176]
	ldp	x11, x10, [x29, #-192]
	ldp	x13, x12, [x29, #-208]
	ldp	x14, x15, [x29, #-240]
	ldp	x16, x17, [x29, #-224]
	cmn	 x21, x14
	ldr	x14, [sp, #32]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x24, x16
	adcs	x26, x26, x17
	adcs	x27, x27, x13
	adcs	x25, x25, x12
	ldr	x12, [sp, #24]          // 8-byte Folded Reload
	adcs	x11, x12, x11
	stp	x11, x14, [sp, #24]
	adcs	x23, x23, x10
	adcs	x28, x28, x9
	adcs	x22, x22, x8
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x24, x8, xzr
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #48]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #56]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #672            // =672
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #744]
	ldr	x9, [sp, #736]
	ldr	x10, [sp, #728]
	ldr	x11, [sp, #720]
	ldr	x12, [sp, #712]
	ldr	x13, [sp, #704]
	ldr	x14, [sp, #672]
	ldr	x15, [sp, #680]
	ldr	x16, [sp, #688]
	ldr	x17, [sp, #696]
	cmn	 x21, x14
	ldr	x14, [sp, #32]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x26, x16
	str	x14, [sp, #48]          // 8-byte Folded Spill
	adcs	x27, x27, x17
	adcs	x25, x25, x13
	ldr	x13, [sp, #24]          // 8-byte Folded Reload
	adcs	x12, x13, x12
	str	x12, [sp, #32]          // 8-byte Folded Spill
	adcs	x23, x23, x11
	adcs	x28, x28, x10
	adcs	x22, x22, x9
	adcs	x24, x24, x8
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x26, x8, xzr
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #56]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #64]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #592            // =592
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #664]
	ldr	x9, [sp, #656]
	ldr	x10, [sp, #648]
	ldr	x11, [sp, #640]
	ldr	x12, [sp, #632]
	ldr	x13, [sp, #624]
	ldr	x14, [sp, #592]
	ldr	x15, [sp, #600]
	ldr	x16, [sp, #608]
	ldr	x17, [sp, #616]
	cmn	 x21, x14
	ldr	x14, [sp, #48]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x27, x16
	str	x14, [sp, #56]          // 8-byte Folded Spill
	adcs	x25, x25, x17
	ldr	x14, [sp, #32]          // 8-byte Folded Reload
	adcs	x13, x14, x13
	str	x13, [sp, #48]          // 8-byte Folded Spill
	adcs	x23, x23, x12
	adcs	x28, x28, x11
	adcs	x22, x22, x10
	adcs	x24, x24, x9
	adcs	x26, x26, x8
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x27, x8, xzr
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #64]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #72]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #512            // =512
	mov	 x0, x20
	bl	.LmulPv576x64
	ldr	x8, [sp, #584]
	ldr	x9, [sp, #576]
	ldr	x10, [sp, #568]
	ldr	x11, [sp, #560]
	ldr	x12, [sp, #552]
	ldr	x13, [sp, #544]
	ldr	x14, [sp, #512]
	ldr	x15, [sp, #520]
	ldr	x16, [sp, #528]
	ldr	x17, [sp, #536]
	cmn	 x21, x14
	ldr	x14, [sp, #56]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x25, x16
	str	x14, [sp, #64]          // 8-byte Folded Spill
	ldr	x14, [sp, #48]          // 8-byte Folded Reload
	adcs	x14, x14, x17
	str	x14, [sp, #56]          // 8-byte Folded Spill
	adcs	x23, x23, x13
	adcs	x28, x28, x12
	adcs	x22, x22, x11
	adcs	x24, x24, x10
	adcs	x26, x26, x9
	adcs	x27, x27, x8
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x25, x8, xzr
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #72]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #80]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #432            // =432
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #496]
	ldp	x11, x10, [sp, #480]
	ldp	x13, x12, [sp, #464]
	ldp	x14, x15, [sp, #432]
	ldp	x16, x17, [sp, #448]
	cmn	 x21, x14
	ldr	x14, [sp, #64]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	ldr	x14, [sp, #56]          // 8-byte Folded Reload
	adcs	x14, x14, x16
	adcs	x23, x23, x17
	adcs	x28, x28, x13
	adcs	x22, x22, x12
	adcs	x24, x24, x11
	adcs	x26, x26, x10
	adcs	x27, x27, x9
	adcs	x25, x25, x8
	ldr	x8, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	stp	x14, x8, [sp, #72]
	mul	 x1, x21, x19
	add	x8, sp, #352            // =352
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #416]
	ldp	x11, x10, [sp, #400]
	ldp	x13, x12, [sp, #384]
	ldp	x14, x15, [sp, #352]
	ldp	x16, x17, [sp, #368]
	cmn	 x21, x14
	ldr	x14, [sp, #72]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x23, x16
	str	x14, [sp, #72]          // 8-byte Folded Spill
	adcs	x28, x28, x17
	adcs	x22, x22, x13
	adcs	x24, x24, x12
	adcs	x26, x26, x11
	adcs	x27, x27, x10
	adcs	x25, x25, x9
	ldr	x9, [sp, #88]           // 8-byte Folded Reload
	adcs	x8, x9, x8
	str	x8, [sp, #88]           // 8-byte Folded Spill
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x23, x8, xzr
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	ldr	x8, [sp, #80]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #96]           // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #272            // =272
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #336]
	ldp	x11, x10, [sp, #320]
	ldp	x13, x12, [sp, #304]
	ldp	x14, x15, [sp, #272]
	ldp	x16, x17, [sp, #288]
	cmn	 x21, x14
	ldr	x14, [sp, #72]          // 8-byte Folded Reload
	adcs	x21, x14, x15
	adcs	x14, x28, x16
	adcs	x22, x22, x17
	adcs	x24, x24, x13
	adcs	x26, x26, x12
	adcs	x27, x27, x11
	adcs	x25, x25, x10
	ldr	x10, [sp, #88]          // 8-byte Folded Reload
	adcs	x9, x10, x9
	stp	x14, x9, [sp, #80]
	adcs	x23, x23, x8
	ldr	x8, [sp, #104]          // 8-byte Folded Reload
	adcs	x28, x8, xzr
	ldr	x8, [sp, #96]           // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [sp, #104]          // 8-byte Folded Spill
	mul	 x1, x21, x19
	add	x8, sp, #192            // =192
	mov	 x0, x20
	bl	.LmulPv576x64
	ldp	x9, x8, [sp, #256]
	ldp	x11, x10, [sp, #240]
	ldp	x13, x12, [sp, #224]
	ldp	x14, x15, [sp, #192]
	ldp	x16, x17, [sp, #208]
	cmn	 x21, x14
	ldr	x14, [sp, #80]          // 8-byte Folded Reload
	adcs	x14, x14, x15
	adcs	x15, x22, x16
	adcs	x16, x24, x17
	adcs	x13, x26, x13
	adcs	x12, x27, x12
	adcs	x11, x25, x11
	ldr	x17, [sp, #88]          // 8-byte Folded Reload
	adcs	x10, x17, x10
	adcs	x9, x23, x9
	adcs	x8, x28, x8
	ldp	x17, x18, [sp, #104]
	adcs	x17, x17, xzr
	subs	 x18, x14, x18
	ldp	x0, x1, [sp, #120]
	sbcs	x0, x15, x0
	sbcs	x1, x16, x1
	ldp	x2, x3, [sp, #136]
	sbcs	x2, x13, x2
	sbcs	x3, x12, x3
	ldr	x4, [sp, #152]          // 8-byte Folded Reload
	sbcs	x4, x11, x4
	ldp	x5, x6, [sp, #168]
	sbcs	x5, x10, x5
	sbcs	x6, x9, x6
	ldr	x7, [sp, #184]          // 8-byte Folded Reload
	sbcs	x7, x8, x7
	sbcs	x17, x17, xzr
	tst	 x17, #0x1
	csel	x14, x14, x18, ne
	csel	x15, x15, x0, ne
	csel	x16, x16, x1, ne
	csel	x13, x13, x2, ne
	csel	x12, x12, x3, ne
	csel	x11, x11, x4, ne
	csel	x10, x10, x5, ne
	csel	x9, x9, x6, ne
	csel	x8, x8, x7, ne
	ldr	x17, [sp, #160]         // 8-byte Folded Reload
	stp	 x14, x15, [x17]
	stp	x16, x13, [x17, #16]
	stp	x12, x11, [x17, #32]
	stp	x10, x9, [x17, #48]
	str	x8, [x17, #64]
	sub	sp, x29, #80            // =80
	ldp	x29, x30, [sp, #80]
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x24, x23, [sp, #32]
	ldp	x26, x25, [sp, #16]
	ldp	x28, x27, [sp], #96
	ret
.Lfunc_end132:
	.size	mcl_fp_montRed9L, .Lfunc_end132-mcl_fp_montRed9L

	.globl	mcl_fp_addPre9L
	.align	2
	.type	mcl_fp_addPre9L,@function
mcl_fp_addPre9L:                        // @mcl_fp_addPre9L
// BB#0:
	ldp	x11, x8, [x2, #56]
	ldp	x13, x9, [x1, #56]
	ldp	x15, x10, [x2, #40]
	ldp	x17, x12, [x1, #40]
	ldp	x3, x14, [x2, #24]
	ldr	 x4, [x2]
	ldp	x2, x18, [x2, #8]
	ldp	 x5, x6, [x1]
	ldr	x7, [x1, #16]
	ldp	x1, x16, [x1, #24]
	adds	 x4, x4, x5
	adcs	x2, x2, x6
	stp	 x4, x2, [x0]
	adcs	x18, x18, x7
	str	x18, [x0, #16]
	adcs	x18, x3, x1
	adcs	x14, x14, x16
	stp	x18, x14, [x0, #24]
	adcs	x14, x15, x17
	adcs	x10, x10, x12
	stp	x14, x10, [x0, #40]
	adcs	x10, x11, x13
	adcs	x9, x8, x9
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #56]
	mov	 x0, x8
	ret
.Lfunc_end133:
	.size	mcl_fp_addPre9L, .Lfunc_end133-mcl_fp_addPre9L

	.globl	mcl_fp_subPre9L
	.align	2
	.type	mcl_fp_subPre9L,@function
mcl_fp_subPre9L:                        // @mcl_fp_subPre9L
// BB#0:
	ldp	x11, x8, [x2, #56]
	ldp	x13, x9, [x1, #56]
	ldp	x15, x10, [x2, #40]
	ldp	x17, x12, [x1, #40]
	ldp	x3, x14, [x2, #24]
	ldr	 x4, [x2]
	ldp	x2, x18, [x2, #8]
	ldp	 x5, x6, [x1]
	ldr	x7, [x1, #16]
	ldp	x1, x16, [x1, #24]
	subs	 x4, x5, x4
	sbcs	x2, x6, x2
	stp	 x4, x2, [x0]
	sbcs	x18, x7, x18
	str	x18, [x0, #16]
	sbcs	x18, x1, x3
	sbcs	x14, x16, x14
	stp	x18, x14, [x0, #24]
	sbcs	x14, x17, x15
	sbcs	x10, x12, x10
	stp	x14, x10, [x0, #40]
	sbcs	x10, x13, x11
	sbcs	x9, x9, x8
	ngcs	 x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #56]
	mov	 x0, x8
	ret
.Lfunc_end134:
	.size	mcl_fp_subPre9L, .Lfunc_end134-mcl_fp_subPre9L

	.globl	mcl_fp_shr1_9L
	.align	2
	.type	mcl_fp_shr1_9L,@function
mcl_fp_shr1_9L:                         // @mcl_fp_shr1_9L
// BB#0:
	ldp	 x8, x9, [x1]
	ldp	x12, x10, [x1, #56]
	ldp	x16, x11, [x1, #40]
	ldp	x13, x14, [x1, #16]
	ldr	x15, [x1, #32]
	extr	x8, x9, x8, #1
	extr	x9, x13, x9, #1
	extr	x13, x14, x13, #1
	extr	x14, x15, x14, #1
	extr	x15, x16, x15, #1
	extr	x16, x11, x16, #1
	extr	x11, x12, x11, #1
	extr	x12, x10, x12, #1
	lsr	x10, x10, #1
	stp	 x8, x9, [x0]
	stp	x13, x14, [x0, #16]
	stp	x15, x16, [x0, #32]
	stp	x11, x12, [x0, #48]
	str	x10, [x0, #64]
	ret
.Lfunc_end135:
	.size	mcl_fp_shr1_9L, .Lfunc_end135-mcl_fp_shr1_9L

	.globl	mcl_fp_add9L
	.align	2
	.type	mcl_fp_add9L,@function
mcl_fp_add9L:                           // @mcl_fp_add9L
// BB#0:
	stp	x24, x23, [sp, #-48]!
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	ldp	x11, x8, [x2, #56]
	ldp	x13, x9, [x1, #56]
	ldp	x15, x10, [x2, #40]
	ldp	x17, x12, [x1, #40]
	ldp	x4, x14, [x2, #24]
	ldr	 x5, [x2]
	ldp	x2, x18, [x2, #8]
	ldp	 x6, x7, [x1]
	ldr	x19, [x1, #16]
	ldp	x1, x16, [x1, #24]
	adds	 x5, x5, x6
	adcs	x2, x2, x7
	adcs	x18, x18, x19
	ldp	x21, x7, [x3, #40]
	ldp	x19, x6, [x3, #56]
	adcs	x1, x4, x1
	adcs	x4, x14, x16
	ldr	x20, [x3, #32]
	adcs	x17, x15, x17
	adcs	x10, x10, x12
	ldp	 x12, x14, [x3]
	stp	 x5, x2, [x0]
	stp	x18, x1, [x0, #16]
	stp	x4, x17, [x0, #32]
	adcs	x22, x11, x13
	stp	x10, x22, [x0, #48]
	adcs	x8, x8, x9
	str	x8, [x0, #64]
	adcs	x23, xzr, xzr
	ldp	x9, x11, [x3, #16]
	subs	 x16, x5, x12
	sbcs	x15, x2, x14
	sbcs	x14, x18, x9
	sbcs	x13, x1, x11
	sbcs	x12, x4, x20
	sbcs	x11, x17, x21
	sbcs	x10, x10, x7
	sbcs	x9, x22, x19
	sbcs	x8, x8, x6
	sbcs	x17, x23, xzr
	and	w17, w17, #0x1
	tbnz	w17, #0, .LBB136_2
// BB#1:                                // %nocarry
	stp	 x16, x15, [x0]
	stp	x14, x13, [x0, #16]
	stp	x12, x11, [x0, #32]
	stp	x10, x9, [x0, #48]
	str	x8, [x0, #64]
.LBB136_2:                              // %carry
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x24, x23, [sp], #48
	ret
.Lfunc_end136:
	.size	mcl_fp_add9L, .Lfunc_end136-mcl_fp_add9L

	.globl	mcl_fp_addNF9L
	.align	2
	.type	mcl_fp_addNF9L,@function
mcl_fp_addNF9L:                         // @mcl_fp_addNF9L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	x11, x8, [x1, #56]
	ldp	x13, x9, [x2, #56]
	ldp	x15, x10, [x1, #40]
	ldp	x17, x12, [x2, #40]
	ldp	x4, x14, [x1, #24]
	ldr	 x5, [x1]
	ldp	x1, x18, [x1, #8]
	ldp	 x6, x7, [x2]
	ldr	x19, [x2, #16]
	ldp	x2, x16, [x2, #24]
	adds	 x5, x6, x5
	adcs	x1, x7, x1
	adcs	x18, x19, x18
	ldp	x19, x6, [x3, #56]
	adcs	x2, x2, x4
	adcs	x14, x16, x14
	ldp	x4, x7, [x3, #40]
	adcs	x15, x17, x15
	adcs	x10, x12, x10
	ldp	 x12, x17, [x3]
	adcs	x11, x13, x11
	ldr	x13, [x3, #16]
	ldp	x3, x16, [x3, #24]
	adcs	x8, x9, x8
	subs	 x9, x5, x12
	sbcs	x12, x1, x17
	sbcs	x13, x18, x13
	sbcs	x17, x2, x3
	sbcs	x16, x14, x16
	sbcs	x3, x15, x4
	sbcs	x4, x10, x7
	sbcs	x7, x11, x19
	sbcs	x6, x8, x6
	asr	x19, x6, #63
	cmp	 x19, #0                // =0
	csel	x9, x5, x9, lt
	csel	x12, x1, x12, lt
	csel	x13, x18, x13, lt
	csel	x17, x2, x17, lt
	csel	x14, x14, x16, lt
	csel	x15, x15, x3, lt
	csel	x10, x10, x4, lt
	csel	x11, x11, x7, lt
	csel	x8, x8, x6, lt
	stp	 x9, x12, [x0]
	stp	x13, x17, [x0, #16]
	stp	x14, x15, [x0, #32]
	stp	x10, x11, [x0, #48]
	str	x8, [x0, #64]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end137:
	.size	mcl_fp_addNF9L, .Lfunc_end137-mcl_fp_addNF9L

	.globl	mcl_fp_sub9L
	.align	2
	.type	mcl_fp_sub9L,@function
mcl_fp_sub9L:                           // @mcl_fp_sub9L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	x15, x16, [x2, #56]
	ldp	x4, x17, [x1, #56]
	ldp	x13, x14, [x2, #40]
	ldp	x6, x18, [x1, #40]
	ldp	x11, x12, [x2, #24]
	ldp	x9, x10, [x2, #8]
	ldr	 x8, [x2]
	ldp	 x2, x7, [x1]
	ldr	x19, [x1, #16]
	ldp	x1, x5, [x1, #24]
	subs	 x8, x2, x8
	sbcs	x9, x7, x9
	stp	 x8, x9, [x0]
	sbcs	x10, x19, x10
	sbcs	x11, x1, x11
	stp	x10, x11, [x0, #16]
	sbcs	x12, x5, x12
	sbcs	x13, x6, x13
	stp	x12, x13, [x0, #32]
	sbcs	x14, x18, x14
	sbcs	x15, x4, x15
	stp	x14, x15, [x0, #48]
	sbcs	x16, x17, x16
	str	x16, [x0, #64]
	ngcs	 x17, xzr
	and	w17, w17, #0x1
	tbnz	w17, #0, .LBB138_2
// BB#1:                                // %nocarry
	ldp	x20, x19, [sp], #16
	ret
.LBB138_2:                              // %carry
	ldp	 x18, x1, [x3]
	ldp	x2, x4, [x3, #16]
	ldp	x5, x6, [x3, #32]
	adds	 x8, x18, x8
	adcs	x9, x1, x9
	ldr	x18, [x3, #48]
	ldp	x1, x17, [x3, #56]
	adcs	x10, x2, x10
	adcs	x11, x4, x11
	adcs	x12, x5, x12
	adcs	x13, x6, x13
	adcs	x14, x18, x14
	adcs	x15, x1, x15
	adcs	x16, x17, x16
	stp	 x8, x9, [x0]
	stp	x10, x11, [x0, #16]
	stp	x12, x13, [x0, #32]
	stp	x14, x15, [x0, #48]
	str	x16, [x0, #64]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end138:
	.size	mcl_fp_sub9L, .Lfunc_end138-mcl_fp_sub9L

	.globl	mcl_fp_subNF9L
	.align	2
	.type	mcl_fp_subNF9L,@function
mcl_fp_subNF9L:                         // @mcl_fp_subNF9L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	x11, x8, [x2, #56]
	ldp	x13, x9, [x1, #56]
	ldp	x15, x10, [x2, #40]
	ldp	x17, x12, [x1, #40]
	ldp	x4, x14, [x2, #24]
	ldr	 x5, [x2]
	ldp	x2, x18, [x2, #8]
	ldp	 x6, x7, [x1]
	ldr	x19, [x1, #16]
	ldp	x1, x16, [x1, #24]
	subs	 x5, x6, x5
	sbcs	x2, x7, x2
	sbcs	x18, x19, x18
	ldp	x19, x6, [x3, #56]
	sbcs	x1, x1, x4
	sbcs	x14, x16, x14
	ldp	x4, x7, [x3, #40]
	sbcs	x15, x17, x15
	sbcs	x10, x12, x10
	ldp	 x12, x17, [x3]
	sbcs	x11, x13, x11
	sbcs	x8, x9, x8
	asr	x9, x8, #63
	extr	x13, x9, x8, #63
	and	 x12, x13, x12
	ldr	x13, [x3, #16]
	ldp	x3, x16, [x3, #24]
	and	 x19, x9, x19
	and	 x6, x9, x6
	ror	 x9, x9, #63
	and	 x17, x9, x17
	and	 x13, x9, x13
	and	 x3, x9, x3
	and	 x16, x9, x16
	and	 x4, x9, x4
	and	 x9, x9, x7
	adds	 x12, x12, x5
	str	 x12, [x0]
	adcs	x12, x17, x2
	str	x12, [x0, #8]
	adcs	x12, x13, x18
	str	x12, [x0, #16]
	adcs	x12, x3, x1
	str	x12, [x0, #24]
	adcs	x12, x16, x14
	str	x12, [x0, #32]
	adcs	x12, x4, x15
	adcs	x9, x9, x10
	stp	x12, x9, [x0, #40]
	adcs	x9, x19, x11
	adcs	x8, x6, x8
	stp	x9, x8, [x0, #56]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end139:
	.size	mcl_fp_subNF9L, .Lfunc_end139-mcl_fp_subNF9L

	.globl	mcl_fpDbl_add9L
	.align	2
	.type	mcl_fpDbl_add9L,@function
mcl_fpDbl_add9L:                        // @mcl_fpDbl_add9L
// BB#0:
	stp	x20, x19, [sp, #-16]!
	ldp	x10, x8, [x2, #128]
	ldp	x11, x9, [x1, #128]
	ldp	x12, x13, [x2, #112]
	ldp	x14, x15, [x1, #112]
	ldp	x16, x17, [x2, #96]
	ldp	 x18, x4, [x2]
	ldp	 x5, x6, [x1]
	ldp	x7, x19, [x2, #16]
	adds	 x18, x18, x5
	adcs	x4, x4, x6
	ldp	x5, x6, [x1, #16]
	str	 x18, [x0]
	adcs	x18, x7, x5
	ldp	x5, x7, [x1, #96]
	str	x4, [x0, #8]
	ldr	x4, [x1, #32]
	str	x18, [x0, #16]
	adcs	x18, x19, x6
	ldp	x6, x19, [x2, #32]
	str	x18, [x0, #24]
	adcs	x4, x6, x4
	ldp	x18, x6, [x1, #40]
	str	x4, [x0, #32]
	adcs	x18, x19, x18
	ldp	x4, x19, [x2, #48]
	str	x18, [x0, #40]
	adcs	x4, x4, x6
	ldp	x18, x6, [x1, #56]
	str	x4, [x0, #48]
	adcs	x18, x19, x18
	ldp	x4, x19, [x2, #64]
	str	x18, [x0, #56]
	ldr	x18, [x1, #72]
	adcs	x4, x4, x6
	ldp	x6, x2, [x2, #80]
	str	x4, [x0, #64]
	ldp	x4, x1, [x1, #80]
	adcs	x18, x19, x18
	adcs	x4, x6, x4
	adcs	x1, x2, x1
	ldp	x6, x19, [x3, #56]
	adcs	x16, x16, x5
	adcs	x17, x17, x7
	ldp	x7, x2, [x3, #40]
	adcs	x12, x12, x14
	adcs	x13, x13, x15
	ldp	x15, x5, [x3, #24]
	adcs	x10, x10, x11
	ldr	 x11, [x3]
	ldp	x3, x14, [x3, #8]
	adcs	x8, x8, x9
	adcs	x9, xzr, xzr
	subs	 x11, x18, x11
	sbcs	x3, x4, x3
	sbcs	x14, x1, x14
	sbcs	x15, x16, x15
	sbcs	x5, x17, x5
	sbcs	x7, x12, x7
	sbcs	x2, x13, x2
	sbcs	x6, x10, x6
	sbcs	x19, x8, x19
	sbcs	x9, x9, xzr
	tst	 x9, #0x1
	csel	x9, x18, x11, ne
	csel	x11, x4, x3, ne
	csel	x14, x1, x14, ne
	csel	x15, x16, x15, ne
	csel	x16, x17, x5, ne
	csel	x12, x12, x7, ne
	csel	x13, x13, x2, ne
	csel	x10, x10, x6, ne
	csel	x8, x8, x19, ne
	stp	x9, x11, [x0, #72]
	stp	x14, x15, [x0, #88]
	stp	x16, x12, [x0, #104]
	stp	x13, x10, [x0, #120]
	str	x8, [x0, #136]
	ldp	x20, x19, [sp], #16
	ret
.Lfunc_end140:
	.size	mcl_fpDbl_add9L, .Lfunc_end140-mcl_fpDbl_add9L

	.globl	mcl_fpDbl_sub9L
	.align	2
	.type	mcl_fpDbl_sub9L,@function
mcl_fpDbl_sub9L:                        // @mcl_fpDbl_sub9L
// BB#0:
	ldp	x10, x8, [x2, #128]
	ldp	x11, x9, [x1, #128]
	ldp	x14, x12, [x2, #112]
	ldp	x15, x13, [x1, #112]
	ldp	 x16, x17, [x2]
	ldp	 x18, x4, [x1]
	ldp	x5, x6, [x2, #96]
	ldr	x7, [x1, #16]
	subs	 x16, x18, x16
	sbcs	x17, x4, x17
	ldp	x18, x4, [x2, #16]
	str	 x16, [x0]
	ldr	x16, [x1, #24]
	sbcs	x18, x7, x18
	str	x17, [x0, #8]
	ldp	x17, x7, [x2, #32]
	str	x18, [x0, #16]
	sbcs	x16, x16, x4
	ldp	x18, x4, [x1, #32]
	str	x16, [x0, #24]
	sbcs	x16, x18, x17
	ldp	x17, x18, [x2, #48]
	str	x16, [x0, #32]
	sbcs	x4, x4, x7
	ldp	x16, x7, [x1, #48]
	str	x4, [x0, #40]
	sbcs	x16, x16, x17
	ldp	x17, x4, [x2, #80]
	str	x16, [x0, #48]
	ldr	x16, [x1, #64]
	sbcs	x18, x7, x18
	ldp	x7, x2, [x2, #64]
	str	x18, [x0, #56]
	ldr	x18, [x1, #72]
	sbcs	x16, x16, x7
	str	x16, [x0, #64]
	ldp	x16, x7, [x1, #80]
	sbcs	x18, x18, x2
	ldp	x2, x1, [x1, #96]
	sbcs	x16, x16, x17
	sbcs	x4, x7, x4
	sbcs	x2, x2, x5
	ldp	x7, x17, [x3, #56]
	sbcs	x1, x1, x6
	sbcs	x14, x15, x14
	ldp	x6, x5, [x3, #40]
	sbcs	x12, x13, x12
	sbcs	x10, x11, x10
	ldp	x13, x15, [x3, #24]
	sbcs	x8, x9, x8
	ngcs	 x9, xzr
	tst	 x9, #0x1
	ldr	 x9, [x3]
	ldp	x3, x11, [x3, #8]
	csel	x17, x17, xzr, ne
	csel	x7, x7, xzr, ne
	csel	x5, x5, xzr, ne
	csel	x6, x6, xzr, ne
	csel	x15, x15, xzr, ne
	csel	x13, x13, xzr, ne
	csel	x11, x11, xzr, ne
	csel	x3, x3, xzr, ne
	csel	x9, x9, xzr, ne
	adds	 x9, x9, x18
	str	x9, [x0, #72]
	adcs	x9, x3, x16
	str	x9, [x0, #80]
	adcs	x9, x11, x4
	str	x9, [x0, #88]
	adcs	x9, x13, x2
	str	x9, [x0, #96]
	adcs	x9, x15, x1
	str	x9, [x0, #104]
	adcs	x9, x6, x14
	str	x9, [x0, #112]
	adcs	x9, x5, x12
	str	x9, [x0, #120]
	adcs	x9, x7, x10
	adcs	x8, x17, x8
	stp	x9, x8, [x0, #128]
	ret
.Lfunc_end141:
	.size	mcl_fpDbl_sub9L, .Lfunc_end141-mcl_fpDbl_sub9L


	.section	".note.GNU-stack","",@progbits
