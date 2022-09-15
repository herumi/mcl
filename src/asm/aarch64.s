	.text
	.file	"base64.ll"
	.globl	makeNIST_P192L                  // -- Begin function makeNIST_P192L
	.p2align	2
	.type	makeNIST_P192L,@function
makeNIST_P192L:                         // @makeNIST_P192L
// %bb.0:
	mov	x0, #-1
	mov	x1, #-2
	mov	x2, #-1
	ret
.Lfunc_end0:
	.size	makeNIST_P192L, .Lfunc_end0-makeNIST_P192L
                                        // -- End function
	.globl	mcl_fpDbl_mod_NIST_P192L        // -- Begin function mcl_fpDbl_mod_NIST_P192L
	.p2align	2
	.type	mcl_fpDbl_mod_NIST_P192L,@function
mcl_fpDbl_mod_NIST_P192L:               // @mcl_fpDbl_mod_NIST_P192L
// %bb.0:
	movi	v0.2d, #0000000000000000
	ldp	x9, x8, [x1, #8]
	ldp	x12, x10, [x1, #32]
	mov	x11, v0.d[1]
	ldr	d0, [x1]
	ldr	x13, [x1, #24]
	adds	x14, x10, x9
	adcs	x8, x8, xzr
	mov	v0.d[1], x9
	fmov	x9, d0
	adcs	x15, x11, xzr
	adds	x9, x9, x13
	adcs	x14, x14, x12
	adcs	x8, x8, x10
	adcs	x15, x15, xzr
	adds	x9, x9, x10
	adcs	x13, x14, x13
	adcs	x8, x8, x12
	adcs	x11, x15, x11
	adds	x9, x9, x11
	adcs	x12, x13, xzr
	adcs	x8, x8, xzr
	adcs	x13, xzr, xzr
	adds	x11, x12, x11
	adcs	x8, x8, xzr
	adcs	x12, x13, xzr
	mov	w10, #1
	adds	x13, x9, #1                     // =1
	adcs	x10, x11, x10
	mov	x14, #-1
	adcs	x15, x8, xzr
	adcs	x12, x12, x14
	tst	x12, #0x1
	csel	x8, x15, x8, eq
	csel	x10, x10, x11, eq
	csel	x9, x13, x9, eq
	stp	x10, x8, [x0, #8]
	str	x9, [x0]
	ret
.Lfunc_end1:
	.size	mcl_fpDbl_mod_NIST_P192L, .Lfunc_end1-mcl_fpDbl_mod_NIST_P192L
                                        // -- End function
	.globl	mcl_fp_sqr_NIST_P192L           // -- Begin function mcl_fp_sqr_NIST_P192L
	.p2align	2
	.type	mcl_fp_sqr_NIST_P192L,@function
mcl_fp_sqr_NIST_P192L:                  // @mcl_fp_sqr_NIST_P192L
// %bb.0:
	ldr	q0, [x1]
	ldr	x8, [x1, #16]
	mov	x12, v0.d[1]
	fmov	x11, d0
	umulh	x13, x11, x11
	mul	x15, x12, x11
	mul	x9, x8, x11
	umulh	x14, x12, x11
	adds	x13, x13, x15
	umulh	x10, x8, x11
	fmov	d0, x15
	adcs	x15, x14, x9
	umulh	x16, x8, x12
	mul	x17, x8, x12
	umulh	x18, x12, x12
	mul	x12, x12, x12
	adcs	x1, x10, xzr
	adds	x12, x14, x12
	fmov	d1, x15
	adcs	x14, x18, x17
	mov	v0.d[1], x12
	mov	v1.d[1], x1
	adcs	x15, x16, xzr
	fmov	d2, x14
	fmov	x18, d0
	mov	v2.d[1], x15
	fmov	x14, d1
	adds	x13, x18, x13
	fmov	x2, d2
	fmov	d0, x17
	adcs	x12, x12, x14
	mov	v0.d[1], x16
	adcs	x1, x2, x1
	fmov	x2, d0
	adcs	x15, x15, xzr
	umulh	x14, x8, x8
	mul	x8, x8, x8
	adds	x10, x10, x2
	adcs	x8, x16, x8
	adcs	x14, x14, xzr
	adds	x9, x9, x12
	adcs	x10, x10, x1
	adcs	x8, x8, x15
	adcs	x12, x14, xzr
	adds	x13, x12, x13
	adcs	x9, x9, xzr
	mul	x11, x11, x11
	adcs	x14, xzr, xzr
	adds	x11, x11, x10
	adcs	x13, x13, x8
	adcs	x9, x9, x12
	adcs	x14, x14, xzr
	adds	x11, x11, x12
	adcs	x10, x13, x10
	adcs	x8, x9, x8
	adcs	x9, x14, xzr
	adds	x11, x11, x9
	adcs	x10, x10, xzr
	adcs	x8, x8, xzr
	adcs	x12, xzr, xzr
	adds	x9, x10, x9
	adcs	x8, x8, xzr
	adcs	x10, x12, xzr
	mov	w17, #1
	adds	x12, x11, #1                    // =1
	adcs	x13, x9, x17
	mov	x18, #-1
	adcs	x14, x8, xzr
	adcs	x10, x10, x18
	tst	x10, #0x1
	csel	x8, x14, x8, eq
	csel	x9, x13, x9, eq
	csel	x10, x12, x11, eq
	stp	x9, x8, [x0, #8]
	str	x10, [x0]
	ret
.Lfunc_end2:
	.size	mcl_fp_sqr_NIST_P192L, .Lfunc_end2-mcl_fp_sqr_NIST_P192L
                                        // -- End function
	.globl	mcl_fp_mulNIST_P192L            // -- Begin function mcl_fp_mulNIST_P192L
	.p2align	2
	.type	mcl_fp_mulNIST_P192L,@function
mcl_fp_mulNIST_P192L:                   // @mcl_fp_mulNIST_P192L
// %bb.0:
	sub	sp, sp, #64                     // =64
	stp	x30, x19, [sp, #48]             // 16-byte Folded Spill
	mov	x19, x0
	mov	x0, sp
	bl	mcl_fpDbl_mulPre3L
	ldp	x8, x11, [sp, #8]
	ldp	x10, x9, [sp, #32]
	ldr	x12, [sp, #24]
	ldr	x13, [sp]
	movi	v0.2d, #0000000000000000
	adds	x8, x9, x8
	mov	x14, v0.d[1]
	adcs	x11, x11, xzr
	adcs	x15, x14, xzr
	adds	x13, x13, x12
	adcs	x8, x8, x10
	adcs	x11, x11, x9
	adcs	x15, x15, xzr
	adds	x9, x13, x9
	adcs	x8, x8, x12
	adcs	x10, x11, x10
	adcs	x11, x15, x14
	adds	x9, x9, x11
	adcs	x8, x8, xzr
	adcs	x10, x10, xzr
	adcs	x14, xzr, xzr
	adds	x8, x8, x11
	adcs	x10, x10, xzr
	adcs	x11, x14, xzr
	mov	w13, #1
	adds	x14, x9, #1                     // =1
	adcs	x13, x8, x13
	mov	x12, #-1
	adcs	x15, x10, xzr
	adcs	x11, x11, x12
	tst	x11, #0x1
	csel	x10, x15, x10, eq
	csel	x8, x13, x8, eq
	csel	x9, x14, x9, eq
	stp	x8, x10, [x19, #8]
	str	x9, [x19]
	ldp	x30, x19, [sp, #48]             // 16-byte Folded Reload
	add	sp, sp, #64                     // =64
	ret
.Lfunc_end3:
	.size	mcl_fp_mulNIST_P192L, .Lfunc_end3-mcl_fp_mulNIST_P192L
                                        // -- End function
	.globl	mcl_fpDbl_mod_NIST_P521L        // -- Begin function mcl_fpDbl_mod_NIST_P521L
	.p2align	2
	.type	mcl_fpDbl_mod_NIST_P521L,@function
mcl_fpDbl_mod_NIST_P521L:               // @mcl_fpDbl_mod_NIST_P521L
// %bb.0:
	ldp	x9, x8, [x1, #120]
	ldp	x11, x10, [x1, #104]
	ldp	x13, x12, [x1, #88]
	ldp	x15, x14, [x1, #72]
	ldp	x17, x16, [x1, #56]
	ldp	x2, x18, [x1, #40]
	ldp	x4, x3, [x1, #24]
	ldp	x6, x5, [x1, #8]
	ldr	x1, [x1]
	extr	x7, x8, x9, #9
	extr	x9, x9, x10, #9
	extr	x10, x10, x11, #9
	extr	x11, x11, x12, #9
	extr	x12, x12, x13, #9
	extr	x13, x13, x14, #9
	extr	x14, x14, x15, #9
	extr	x15, x15, x16, #9
	adds	x15, x1, x15
	adcs	x14, x6, x14
	adcs	x13, x5, x13
	adcs	x12, x4, x12
	adcs	x11, x3, x11
	adcs	x1, x2, x10
	adcs	x18, x18, x9
	lsr	x8, x8, #9
	and	x16, x16, #0x1ff
	adcs	x17, x17, x7
	adcs	x16, x16, x8
	ubfx	x8, x16, #9, #1
	adds	x15, x8, x15
	adcs	x8, x14, xzr
	and	x10, x8, x15
	adcs	x9, x13, xzr
	and	x13, x10, x9
	adcs	x10, x12, xzr
	and	x12, x13, x10
	adcs	x11, x11, xzr
	and	x13, x12, x11
	adcs	x12, x1, xzr
	and	x14, x13, x12
	adcs	x13, x18, xzr
	and	x18, x14, x13
	adcs	x14, x17, xzr
	adcs	x16, x16, xzr
	and	x17, x18, x14
	orr	x18, x16, #0xfffffffffffffe00
	and	x17, x18, x17
	cmn	x17, #1                         // =1
	b.eq	.LBB4_2
// %bb.1:                               // %nonzero
	str	x15, [x0]
	and	x15, x16, #0x1ff
	stp	x14, x15, [x0, #56]
	stp	x12, x13, [x0, #40]
	stp	x10, x11, [x0, #24]
	stp	x8, x9, [x0, #8]
	ret
.LBB4_2:                                // %zero
	mov	x8, xzr
	mov	x9, xzr
	mov	x10, xzr
	mov	x11, xzr
	mov	x12, xzr
	mov	x13, xzr
	mov	x14, xzr
	mov	x15, xzr
	str	xzr, [x0]
	stp	x14, x15, [x0, #56]
	stp	x12, x13, [x0, #40]
	stp	x10, x11, [x0, #24]
	stp	x8, x9, [x0, #8]
	ret
.Lfunc_end4:
	.size	mcl_fpDbl_mod_NIST_P521L, .Lfunc_end4-mcl_fpDbl_mod_NIST_P521L
                                        // -- End function
	.globl	mulPv192x64                     // -- Begin function mulPv192x64
	.p2align	2
	.type	mulPv192x64,@function
mulPv192x64:                            // @mulPv192x64
// %bb.0:
	ldp	x9, x8, [x0, #8]
	ldr	x10, [x0]
	umulh	x11, x8, x1
	mul	x12, x8, x1
	umulh	x13, x9, x1
	mul	x8, x9, x1
	umulh	x9, x10, x1
	adds	x8, x9, x8
	adcs	x2, x13, x12
	adcs	x3, x11, xzr
	mul	x0, x10, x1
	mov	x1, x8
	ret
.Lfunc_end5:
	.size	mulPv192x64, .Lfunc_end5-mulPv192x64
                                        // -- End function
	.globl	mcl_fpDbl_mulPre3L              // -- Begin function mcl_fpDbl_mulPre3L
	.p2align	2
	.type	mcl_fpDbl_mulPre3L,@function
mcl_fpDbl_mulPre3L:                     // @mcl_fpDbl_mulPre3L
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x8, x12, [x1]
	ldp	x10, x11, [x2]
	ldr	x9, [x1, #16]
	ldr	x13, [x2, #16]
	mul	x18, x11, x12
	umulh	x1, x11, x8
	mul	x14, x8, x10
	umulh	x15, x11, x9
	mul	x16, x11, x9
	umulh	x17, x11, x12
	umulh	x2, x9, x10
	mul	x3, x9, x10
	umulh	x4, x12, x10
	mul	x5, x12, x10
	umulh	x10, x8, x10
	mul	x11, x11, x8
	umulh	x6, x13, x9
	mul	x9, x13, x9
	umulh	x7, x13, x12
	mul	x12, x13, x12
	umulh	x19, x13, x8
	mul	x8, x13, x8
	adds	x13, x1, x18
	adcs	x16, x17, x16
	adcs	x15, x15, xzr
	adds	x10, x10, x5
	adcs	x17, x4, x3
	adcs	x18, x2, xzr
	adds	x10, x11, x10
	stp	x14, x10, [x0]
	adcs	x10, x13, x17
	adcs	x11, x16, x18
	adcs	x13, x15, xzr
	adds	x12, x19, x12
	adcs	x9, x7, x9
	adcs	x14, x6, xzr
	adds	x8, x8, x10
	adcs	x10, x12, x11
	stp	x8, x10, [x0, #16]
	adcs	x8, x9, x13
	adcs	x9, x14, xzr
	stp	x8, x9, [x0, #32]
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end6:
	.size	mcl_fpDbl_mulPre3L, .Lfunc_end6-mcl_fpDbl_mulPre3L
                                        // -- End function
	.globl	mcl_fpDbl_sqrPre3L              // -- Begin function mcl_fpDbl_sqrPre3L
	.p2align	2
	.type	mcl_fpDbl_sqrPre3L,@function
mcl_fpDbl_sqrPre3L:                     // @mcl_fpDbl_sqrPre3L
// %bb.0:
	ldp	x8, x10, [x1]
	ldr	x9, [x1, #16]
	mul	x11, x8, x8
	umulh	x12, x9, x8
	mul	x13, x9, x8
	umulh	x14, x10, x8
	mul	x15, x10, x8
	umulh	x8, x8, x8
	adds	x8, x8, x15
	adcs	x1, x14, x13
	umulh	x16, x9, x10
	mul	x17, x9, x10
	umulh	x18, x10, x10
	mul	x10, x10, x10
	adcs	x2, x12, xzr
	adds	x10, x14, x10
	adcs	x14, x18, x17
	adcs	x18, x16, xzr
	adds	x8, x15, x8
	stp	x11, x8, [x0]
	adcs	x8, x10, x1
	adcs	x10, x14, x2
	adcs	x11, x18, xzr
	umulh	x15, x9, x9
	mul	x9, x9, x9
	adds	x12, x12, x17
	adcs	x9, x16, x9
	adcs	x14, x15, xzr
	adds	x8, x13, x8
	adcs	x10, x12, x10
	stp	x8, x10, [x0, #16]
	adcs	x8, x9, x11
	adcs	x9, x14, xzr
	stp	x8, x9, [x0, #32]
	ret
.Lfunc_end7:
	.size	mcl_fpDbl_sqrPre3L, .Lfunc_end7-mcl_fpDbl_sqrPre3L
                                        // -- End function
	.globl	mcl_fp_mont3L                   // -- Begin function mcl_fp_mont3L
	.p2align	2
	.type	mcl_fp_mont3L,@function
mcl_fp_mont3L:                          // @mcl_fp_mont3L
// %bb.0:
	str	x23, [sp, #-48]!                // 8-byte Folded Spill
	ldp	x15, x16, [x2]
	ldp	x12, x14, [x1, #8]
	ldr	x13, [x1]
	ldp	x11, x10, [x3, #-8]
	ldp	x9, x8, [x3, #8]
	mul	x3, x12, x15
	umulh	x4, x13, x15
	ldr	x17, [x2, #16]
	umulh	x18, x14, x15
	mul	x1, x14, x15
	umulh	x2, x12, x15
	mul	x15, x13, x15
	adds	x3, x4, x3
	mul	x4, x11, x15
	adcs	x1, x2, x1
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	mul	x22, x4, x9
	umulh	x23, x4, x10
	adcs	x18, x18, xzr
	mul	x2, x4, x8
	adds	x22, x23, x22
	umulh	x23, x4, x9
	adcs	x2, x23, x2
	umulh	x23, x4, x8
	mul	x4, x4, x10
	adcs	x23, x23, xzr
	cmn	x4, x15
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	umulh	x5, x16, x14
	mul	x6, x16, x14
	umulh	x7, x16, x12
	mul	x19, x16, x12
	umulh	x20, x16, x13
	mul	x16, x16, x13
	umulh	x21, x17, x14
	mul	x14, x17, x14
	umulh	x15, x17, x12
	mul	x12, x17, x12
	umulh	x4, x17, x13
	mul	x13, x17, x13
	adcs	x17, x22, x3
	adcs	x1, x2, x1
	adcs	x18, x23, x18
	adcs	x2, xzr, xzr
	adds	x3, x20, x19
	adcs	x6, x7, x6
	adcs	x5, x5, xzr
	adds	x16, x17, x16
	adcs	x17, x1, x3
	adcs	x18, x18, x6
	mul	x1, x11, x16
	adcs	x2, x2, x5
	mul	x6, x1, x9
	umulh	x7, x1, x10
	adcs	x5, xzr, xzr
	mul	x3, x1, x8
	adds	x6, x7, x6
	umulh	x7, x1, x9
	adcs	x3, x7, x3
	umulh	x7, x1, x8
	mul	x1, x1, x10
	adcs	x7, x7, xzr
	cmn	x16, x1
	adcs	x16, x17, x6
	adcs	x17, x18, x3
	adcs	x18, x2, x7
	adcs	x1, x5, xzr
	adds	x12, x4, x12
	adcs	x14, x15, x14
	adcs	x15, x21, xzr
	adds	x13, x16, x13
	adcs	x12, x17, x12
	adcs	x14, x18, x14
	mul	x11, x11, x13
	adcs	x15, x1, x15
	mul	x2, x11, x9
	umulh	x3, x11, x10
	adcs	x1, xzr, xzr
	mul	x17, x11, x8
	umulh	x18, x11, x9
	adds	x2, x3, x2
	umulh	x16, x11, x8
	adcs	x17, x18, x17
	mul	x11, x11, x10
	adcs	x16, x16, xzr
	cmn	x13, x11
	adcs	x11, x12, x2
	adcs	x12, x14, x17
	adcs	x13, x15, x16
	adcs	x14, x1, xzr
	subs	x10, x11, x10
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	sbcs	x14, x14, xzr
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	tst	x14, #0x1
	csel	x8, x8, x13, eq
	csel	x9, x9, x12, eq
	csel	x10, x10, x11, eq
	stp	x9, x8, [x0, #8]
	str	x10, [x0]
	ldr	x23, [sp], #48                  // 8-byte Folded Reload
	ret
.Lfunc_end8:
	.size	mcl_fp_mont3L, .Lfunc_end8-mcl_fp_mont3L
                                        // -- End function
	.globl	mcl_fp_montNF3L                 // -- Begin function mcl_fp_montNF3L
	.p2align	2
	.type	mcl_fp_montNF3L,@function
mcl_fp_montNF3L:                        // @mcl_fp_montNF3L
// %bb.0:
	ldp	x15, x16, [x2]
	ldp	x14, x13, [x1, #8]
	ldr	x12, [x1]
	ldp	x11, x10, [x3, #-8]
	ldp	x9, x8, [x3, #8]
	mul	x3, x14, x15
	umulh	x4, x12, x15
	ldr	x17, [x2, #16]
	umulh	x18, x13, x15
	mul	x1, x13, x15
	umulh	x2, x14, x15
	mul	x15, x12, x15
	adds	x3, x4, x3
	mul	x4, x11, x15
	adcs	x1, x2, x1
	mul	x2, x10, x4
	adcs	x18, x18, xzr
	cmn	x15, x2
	mul	x2, x9, x4
	adcs	x2, x3, x2
	mul	x3, x8, x4
	adcs	x1, x1, x3
	umulh	x3, x10, x4
	adcs	x18, x18, xzr
	adds	x2, x2, x3
	umulh	x3, x9, x4
	adcs	x1, x1, x3
	umulh	x4, x8, x4
	mul	x3, x14, x16
	adcs	x18, x18, x4
	umulh	x4, x12, x16
	mul	x6, x13, x16
	umulh	x15, x14, x16
	adds	x3, x4, x3
	umulh	x5, x13, x16
	adcs	x15, x15, x6
	mul	x16, x12, x16
	adcs	x5, x5, xzr
	adds	x16, x16, x2
	adcs	x1, x3, x1
	mul	x3, x11, x16
	adcs	x15, x15, x18
	mul	x18, x3, x10
	adcs	x5, x5, xzr
	cmn	x16, x18
	mul	x18, x3, x9
	mul	x16, x3, x8
	adcs	x18, x1, x18
	adcs	x15, x15, x16
	umulh	x1, x3, x8
	umulh	x16, x3, x9
	umulh	x3, x3, x10
	adcs	x5, x5, xzr
	adds	x18, x3, x18
	adcs	x15, x16, x15
	adcs	x16, x1, x5
	fmov	d0, x15
	umulh	x6, x17, x14
	mul	x14, x17, x14
	mul	x2, x17, x12
	mov	v0.d[1], x16
	umulh	x12, x17, x12
	umulh	x4, x17, x13
	mul	x13, x17, x13
	fmov	x15, d0
	fmov	d0, x2
	adds	x12, x12, x14
	adcs	x13, x6, x13
	mov	v0.d[1], x12
	adcs	x14, x4, xzr
	fmov	x17, d0
	fmov	d0, x13
	mov	v0.d[1], x14
	adds	x13, x17, x18
	fmov	x17, d0
	adcs	x12, x12, x15
	mul	x11, x11, x13
	adcs	x15, x17, x16
	mul	x18, x10, x11
	adcs	x14, x14, xzr
	mul	x17, x9, x11
	cmn	x13, x18
	mul	x16, x8, x11
	adcs	x12, x12, x17
	adcs	x13, x15, x16
	umulh	x1, x8, x11
	umulh	x2, x9, x11
	umulh	x11, x10, x11
	adcs	x14, x14, xzr
	adds	x11, x12, x11
	adcs	x12, x13, x2
	adcs	x13, x14, x1
	subs	x10, x11, x10
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	asr	x14, x8, #63
	cmp	x14, #0                         // =0
	csel	x8, x8, x13, ge
	csel	x9, x9, x12, ge
	csel	x10, x10, x11, ge
	stp	x9, x8, [x0, #8]
	str	x10, [x0]
	ret
.Lfunc_end9:
	.size	mcl_fp_montNF3L, .Lfunc_end9-mcl_fp_montNF3L
                                        // -- End function
	.globl	mcl_fp_montRed3L                // -- Begin function mcl_fp_montRed3L
	.p2align	2
	.type	mcl_fp_montRed3L,@function
mcl_fp_montRed3L:                       // @mcl_fp_montRed3L
// %bb.0:
	ldp	x10, x11, [x2, #-8]
	ldp	x14, x15, [x1]
	ldp	x9, x8, [x2, #8]
	ldp	x13, x12, [x1, #16]
	ldp	x16, x17, [x1, #32]
	mul	x18, x14, x10
	mul	x3, x18, x9
	umulh	x4, x18, x11
	mul	x2, x18, x8
	adds	x3, x4, x3
	umulh	x4, x18, x9
	umulh	x1, x18, x8
	adcs	x2, x4, x2
	mul	x18, x18, x11
	adcs	x1, x1, xzr
	cmn	x18, x14
	adcs	x14, x3, x15
	adcs	x13, x2, x13
	mul	x15, x10, x14
	adcs	x12, x1, x12
	umulh	x2, x15, x11
	mul	x3, x15, x9
	adcs	x4, xzr, xzr
	umulh	x1, x15, x9
	adds	x2, x3, x2
	mul	x3, x15, x8
	umulh	x18, x15, x8
	adcs	x1, x3, x1
	mul	x15, x15, x11
	adcs	x18, x4, x18
	cmn	x15, x14
	adcs	x13, x2, x13
	adcs	x12, x1, x12
	mul	x10, x10, x13
	adcs	x15, x18, x16
	umulh	x1, x10, x11
	mul	x2, x10, x9
	adcs	x3, xzr, xzr
	umulh	x16, x10, x9
	mul	x18, x10, x8
	adds	x1, x2, x1
	umulh	x14, x10, x8
	adcs	x16, x18, x16
	mul	x10, x10, x11
	adcs	x14, x3, x14
	cmn	x10, x13
	adcs	x10, x1, x12
	adcs	x12, x16, x15
	adcs	x13, x14, x17
	adcs	x14, xzr, xzr
	subs	x11, x10, x11
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	sbcs	x14, x14, xzr
	tst	x14, #0x1
	csel	x8, x8, x13, eq
	csel	x9, x9, x12, eq
	csel	x10, x11, x10, eq
	stp	x9, x8, [x0, #8]
	str	x10, [x0]
	ret
.Lfunc_end10:
	.size	mcl_fp_montRed3L, .Lfunc_end10-mcl_fp_montRed3L
                                        // -- End function
	.globl	mcl_fp_montRedNF3L              // -- Begin function mcl_fp_montRedNF3L
	.p2align	2
	.type	mcl_fp_montRedNF3L,@function
mcl_fp_montRedNF3L:                     // @mcl_fp_montRedNF3L
// %bb.0:
	ldp	x10, x11, [x2, #-8]
	ldp	x14, x15, [x1]
	ldp	x9, x8, [x2, #8]
	ldp	x13, x12, [x1, #16]
	ldp	x16, x17, [x1, #32]
	mul	x18, x14, x10
	mul	x3, x18, x9
	umulh	x4, x18, x11
	mul	x2, x18, x8
	adds	x3, x4, x3
	umulh	x4, x18, x9
	umulh	x1, x18, x8
	adcs	x2, x4, x2
	mul	x18, x18, x11
	adcs	x1, x1, xzr
	cmn	x18, x14
	adcs	x14, x3, x15
	adcs	x13, x2, x13
	mul	x15, x10, x14
	adcs	x12, x1, x12
	umulh	x2, x15, x11
	mul	x3, x15, x9
	adcs	x4, xzr, xzr
	umulh	x1, x15, x9
	adds	x2, x3, x2
	mul	x3, x15, x8
	umulh	x18, x15, x8
	adcs	x1, x3, x1
	mul	x15, x15, x11
	adcs	x18, x4, x18
	cmn	x15, x14
	adcs	x13, x2, x13
	adcs	x12, x1, x12
	mul	x10, x10, x13
	adcs	x15, x18, x16
	umulh	x1, x10, x11
	mul	x2, x10, x9
	adcs	x3, xzr, xzr
	umulh	x16, x10, x9
	mul	x18, x10, x8
	adds	x1, x2, x1
	umulh	x14, x10, x8
	adcs	x16, x18, x16
	mul	x10, x10, x11
	adcs	x14, x3, x14
	cmn	x10, x13
	adcs	x10, x1, x12
	adcs	x12, x16, x15
	adcs	x13, x14, x17
	subs	x11, x10, x11
	sbcs	x9, x12, x9
	sbcs	x8, x13, x8
	asr	x14, x8, #63
	cmp	x14, #0                         // =0
	csel	x8, x8, x13, ge
	csel	x9, x9, x12, ge
	csel	x10, x11, x10, ge
	stp	x9, x8, [x0, #8]
	str	x10, [x0]
	ret
.Lfunc_end11:
	.size	mcl_fp_montRedNF3L, .Lfunc_end11-mcl_fp_montRedNF3L
                                        // -- End function
	.globl	mcl_fp_addPre3L                 // -- Begin function mcl_fp_addPre3L
	.p2align	2
	.type	mcl_fp_addPre3L,@function
mcl_fp_addPre3L:                        // @mcl_fp_addPre3L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldr	x12, [x1, #16]
	adds	x8, x8, x9
	ldr	x9, [x2, #16]
	fmov	d0, x8
	adcs	x8, x11, x10
	mov	v0.d[1], x8
	adcs	x9, x12, x9
	str	q0, [x0]
	adcs	x8, xzr, xzr
	fmov	d0, x9
	mov	v0.d[1], x8
	str	d0, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end12:
	.size	mcl_fp_addPre3L, .Lfunc_end12-mcl_fp_addPre3L
                                        // -- End function
	.globl	mcl_fp_subPre3L                 // -- Begin function mcl_fp_subPre3L
	.p2align	2
	.type	mcl_fp_subPre3L,@function
mcl_fp_subPre3L:                        // @mcl_fp_subPre3L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldr	x12, [x1, #16]
	subs	x8, x8, x9
	ldr	x9, [x2, #16]
	fmov	d0, x8
	sbcs	x8, x11, x10
	mov	v0.d[1], x8
	sbcs	x8, x12, x9
	str	q0, [x0]
	ngcs	x9, xzr
	fmov	d0, x8
	mov	v0.d[1], x9
	and	x8, x9, #0x1
	str	d0, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end13:
	.size	mcl_fp_subPre3L, .Lfunc_end13-mcl_fp_subPre3L
                                        // -- End function
	.globl	mcl_fp_shr1_3L                  // -- Begin function mcl_fp_shr1_3L
	.p2align	2
	.type	mcl_fp_shr1_3L,@function
mcl_fp_shr1_3L:                         // @mcl_fp_shr1_3L
// %bb.0:
	ldp	x9, x8, [x1, #8]
	ldr	x10, [x1]
	lsr	x11, x8, #1
	extr	x8, x8, x9, #1
	extr	x9, x9, x10, #1
	stp	x8, x11, [x0, #8]
	str	x9, [x0]
	ret
.Lfunc_end14:
	.size	mcl_fp_shr1_3L, .Lfunc_end14-mcl_fp_shr1_3L
                                        // -- End function
	.globl	mcl_fp_add3L                    // -- Begin function mcl_fp_add3L
	.p2align	2
	.type	mcl_fp_add3L,@function
mcl_fp_add3L:                           // @mcl_fp_add3L
// %bb.0:
	ldp	x8, x9, [x2]
	ldp	x10, x11, [x1]
	ldr	x12, [x2, #16]
	ldr	x13, [x1, #16]
	adds	x8, x10, x8
	ldr	x10, [x3]
	fmov	d0, x8
	ldp	x8, x14, [x3, #8]
	adcs	x11, x11, x9
	mov	v0.d[1], x11
	adcs	x9, x13, x12
	adcs	x12, xzr, xzr
	fmov	d1, x9
	fmov	x9, d0
	mov	v1.d[1], x12
	subs	x9, x9, x10
	fmov	x13, d1
	sbcs	x10, x11, x8
	sbcs	x8, x13, x14
	sbcs	x11, x12, xzr
	str	q0, [x0]
	str	d1, [x0, #16]
	tbnz	w11, #0, .LBB15_2
// %bb.1:                               // %nocarry
	stp	x9, x10, [x0]
	str	x8, [x0, #16]
.LBB15_2:                               // %common.ret
	ret
.Lfunc_end15:
	.size	mcl_fp_add3L, .Lfunc_end15-mcl_fp_add3L
                                        // -- End function
	.globl	mcl_fp_addNF3L                  // -- Begin function mcl_fp_addNF3L
	.p2align	2
	.type	mcl_fp_addNF3L,@function
mcl_fp_addNF3L:                         // @mcl_fp_addNF3L
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	adds	x9, x10, x9
	ldp	x14, x10, [x3]
	adcs	x8, x11, x8
	ldr	x11, [x3, #16]
	adcs	x12, x13, x12
	subs	x13, x9, x14
	sbcs	x10, x8, x10
	sbcs	x11, x12, x11
	asr	x14, x11, #63
	cmp	x14, #0                         // =0
	csel	x11, x11, x12, ge
	csel	x8, x10, x8, ge
	csel	x9, x13, x9, ge
	stp	x8, x11, [x0, #8]
	str	x9, [x0]
	ret
.Lfunc_end16:
	.size	mcl_fp_addNF3L, .Lfunc_end16-mcl_fp_addNF3L
                                        // -- End function
	.globl	mcl_fp_sub3L                    // -- Begin function mcl_fp_sub3L
	.p2align	2
	.type	mcl_fp_sub3L,@function
mcl_fp_sub3L:                           // @mcl_fp_sub3L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldr	x12, [x1, #16]
	subs	x8, x8, x9
	ldr	x9, [x2, #16]
	fmov	d0, x8
	sbcs	x8, x11, x10
	mov	v0.d[1], x8
	sbcs	x9, x12, x9
	ngcs	x10, xzr
	fmov	d1, x9
	mov	v1.d[1], x10
	str	q0, [x0]
	str	d1, [x0, #16]
	tbz	w10, #0, .LBB17_2
// %bb.1:                               // %carry
	ldp	x10, x11, [x3]
	ldr	x13, [x3, #16]
	fmov	x12, d0
	fmov	x9, d1
	adds	x10, x10, x12
	adcs	x8, x11, x8
	stp	x10, x8, [x0]
	adcs	x8, x13, x9
	str	x8, [x0, #16]
.LBB17_2:                               // %common.ret
	ret
.Lfunc_end17:
	.size	mcl_fp_sub3L, .Lfunc_end17-mcl_fp_sub3L
                                        // -- End function
	.globl	mcl_fp_subNF3L                  // -- Begin function mcl_fp_subNF3L
	.p2align	2
	.type	mcl_fp_subNF3L,@function
mcl_fp_subNF3L:                         // @mcl_fp_subNF3L
// %bb.0:
	ldp	x9, x8, [x2]
	ldp	x10, x11, [x1]
	ldr	x12, [x2, #16]
	ldr	x13, [x1, #16]
	ldr	x14, [x3, #16]
	subs	x9, x10, x9
	sbcs	x8, x11, x8
	ldp	x10, x11, [x3]
	sbcs	x12, x13, x12
	asr	x13, x12, #63
	and	x14, x13, x14
	and	x11, x13, x11
	extr	x13, x13, x12, #63
	and	x10, x13, x10
	adds	x9, x10, x9
	adcs	x8, x11, x8
	stp	x9, x8, [x0]
	adcs	x8, x14, x12
	str	x8, [x0, #16]
	ret
.Lfunc_end18:
	.size	mcl_fp_subNF3L, .Lfunc_end18-mcl_fp_subNF3L
                                        // -- End function
	.globl	mcl_fpDbl_add3L                 // -- Begin function mcl_fpDbl_add3L
	.p2align	2
	.type	mcl_fpDbl_add3L,@function
mcl_fpDbl_add3L:                        // @mcl_fpDbl_add3L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldr	x14, [x3]
	adds	x8, x8, x9
	fmov	d0, x8
	adcs	x8, x11, x10
	ldp	x10, x11, [x2, #16]
	mov	v0.d[1], x8
	ldp	x9, x8, [x1, #16]
	str	q0, [x0]
	adcs	x9, x9, x10
	ldp	x10, x12, [x2, #32]
	fmov	d0, x9
	ldp	x9, x13, [x1, #32]
	adcs	x8, x8, x11
	mov	v0.d[1], x8
	str	d0, [x0, #16]
	adcs	x9, x9, x10
	ldp	x10, x11, [x3, #8]
	fmov	d0, x9
	adcs	x9, x13, x12
	mov	v0.d[1], x9
	adcs	x12, xzr, xzr
	fmov	x13, d0
	subs	x14, x8, x14
	sbcs	x10, x13, x10
	sbcs	x11, x9, x11
	sbcs	x12, x12, xzr
	tst	x12, #0x1
	csel	x9, x11, x9, eq
	csel	x10, x10, x13, eq
	csel	x8, x14, x8, eq
	stp	x10, x9, [x0, #32]
	str	x8, [x0, #24]
	ret
.Lfunc_end19:
	.size	mcl_fpDbl_add3L, .Lfunc_end19-mcl_fpDbl_add3L
                                        // -- End function
	.globl	mcl_fpDbl_sub3L                 // -- Begin function mcl_fpDbl_sub3L
	.p2align	2
	.type	mcl_fpDbl_sub3L,@function
mcl_fpDbl_sub3L:                        // @mcl_fpDbl_sub3L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	subs	x8, x8, x9
	ldp	x9, x12, [x2, #16]
	fmov	d0, x8
	sbcs	x8, x11, x10
	ldp	x10, x11, [x1, #16]
	mov	v0.d[1], x8
	ldp	x13, x8, [x2, #32]
	str	q0, [x0]
	sbcs	x9, x10, x9
	ldp	x14, x10, [x1, #32]
	fmov	d0, x9
	sbcs	x9, x11, x12
	mov	v0.d[1], x9
	sbcs	x12, x14, x13
	ldr	x13, [x3]
	ldp	x14, x11, [x3, #8]
	sbcs	x8, x10, x8
	ngcs	x10, xzr
	str	d0, [x0, #16]
	fmov	d0, x12
	sbfx	x10, x10, #0, #1
	mov	v0.d[1], x8
	and	x13, x10, x13
	fmov	x12, d0
	and	x14, x10, x14
	adds	x9, x13, x9
	and	x10, x10, x11
	adcs	x11, x14, x12
	adcs	x8, x10, x8
	stp	x9, x11, [x0, #24]
	str	x8, [x0, #40]
	ret
.Lfunc_end20:
	.size	mcl_fpDbl_sub3L, .Lfunc_end20-mcl_fpDbl_sub3L
                                        // -- End function
	.globl	mulPv256x64                     // -- Begin function mulPv256x64
	.p2align	2
	.type	mulPv256x64,@function
mulPv256x64:                            // @mulPv256x64
// %bb.0:
	ldp	x9, x8, [x0, #16]
	ldp	x11, x10, [x0]
	umulh	x12, x8, x1
	mul	x13, x8, x1
	umulh	x15, x10, x1
	mul	x8, x10, x1
	umulh	x10, x11, x1
	umulh	x14, x9, x1
	mul	x9, x9, x1
	adds	x8, x10, x8
	adcs	x2, x15, x9
	adcs	x3, x14, x13
	adcs	x4, x12, xzr
	mul	x0, x11, x1
	mov	x1, x8
	ret
.Lfunc_end21:
	.size	mulPv256x64, .Lfunc_end21-mulPv256x64
                                        // -- End function
	.globl	mcl_fp_mont4L                   // -- Begin function mcl_fp_mont4L
	.p2align	2
	.type	mcl_fp_mont4L,@function
mcl_fp_mont4L:                          // @mcl_fp_mont4L
// %bb.0:
	sub	sp, sp, #112                    // =112
	ldp	x15, x14, [x1]
	ldp	x17, x18, [x2]
	ldp	x13, x16, [x1, #16]
	str	x0, [sp, #8]                    // 8-byte Folded Spill
	ldp	x0, x11, [x3, #-8]
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	ldr	x10, [x3, #8]
	mul	x19, x14, x17
	umulh	x20, x15, x17
	ldp	x9, x8, [x3, #16]
	mul	x6, x13, x17
	umulh	x7, x14, x17
	adds	x19, x20, x19
	umulh	x3, x16, x17
	mul	x4, x16, x17
	umulh	x5, x13, x17
	mul	x17, x15, x17
	adcs	x6, x7, x6
	mul	x20, x0, x17
	adcs	x4, x5, x4
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	mul	x30, x20, x10
	umulh	x5, x20, x11
	adcs	x3, x3, xzr
	mul	x29, x20, x9
	adds	x5, x5, x30
	umulh	x30, x20, x10
	mul	x7, x20, x8
	adcs	x29, x30, x29
	umulh	x30, x20, x9
	adcs	x7, x30, x7
	umulh	x30, x20, x8
	mul	x20, x20, x11
	adcs	x30, x30, xzr
	cmn	x20, x17
	adcs	x5, x5, x19
	adcs	x6, x29, x6
	adcs	x4, x7, x4
	adcs	x3, x30, x3
	stp	x28, x27, [sp, #32]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             // 16-byte Folded Spill
	mul	x26, x18, x14
	umulh	x27, x18, x15
	adcs	x30, xzr, xzr
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	mul	x24, x18, x13
	umulh	x25, x18, x14
	adds	x26, x27, x26
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	mul	x22, x18, x16
	umulh	x23, x18, x13
	adcs	x24, x25, x24
	umulh	x21, x18, x16
	adcs	x22, x23, x22
	mul	x18, x18, x15
	adcs	x21, x21, xzr
	adds	x18, x5, x18
	adcs	x5, x6, x26
	adcs	x4, x4, x24
	adcs	x3, x3, x22
	mul	x6, x0, x18
	adcs	x21, x30, x21
	mul	x26, x6, x10
	umulh	x22, x6, x11
	adcs	x30, xzr, xzr
	mul	x24, x6, x9
	adds	x22, x22, x26
	umulh	x26, x6, x10
	ldp	x1, x2, [x2, #16]
	mul	x23, x6, x8
	adcs	x24, x26, x24
	umulh	x26, x6, x9
	adcs	x23, x26, x23
	umulh	x26, x6, x8
	mul	x6, x6, x11
	adcs	x26, x26, xzr
	cmn	x18, x6
	umulh	x28, x1, x16
	mul	x17, x1, x16
	umulh	x20, x1, x13
	mul	x19, x1, x13
	umulh	x29, x1, x14
	mul	x7, x1, x14
	umulh	x27, x1, x15
	mul	x1, x1, x15
	umulh	x25, x2, x16
	mul	x16, x2, x16
	umulh	x18, x2, x13
	mul	x13, x2, x13
	umulh	x6, x2, x14
	mul	x14, x2, x14
	umulh	x12, x2, x15
	mul	x15, x2, x15
	adcs	x2, x5, x22
	adcs	x4, x4, x24
	adcs	x3, x3, x23
	adcs	x5, x21, x26
	adcs	x21, x30, xzr
	adds	x7, x27, x7
	adcs	x19, x29, x19
	adcs	x17, x20, x17
	adcs	x20, x28, xzr
	adds	x1, x2, x1
	adcs	x2, x4, x7
	adcs	x3, x3, x19
	adcs	x17, x5, x17
	mul	x4, x0, x1
	adcs	x20, x21, x20
	mul	x22, x4, x10
	umulh	x5, x4, x11
	adcs	x21, xzr, xzr
	mul	x19, x4, x9
	adds	x5, x5, x22
	umulh	x22, x4, x10
	mul	x7, x4, x8
	adcs	x19, x22, x19
	umulh	x22, x4, x9
	adcs	x7, x22, x7
	umulh	x22, x4, x8
	mul	x4, x4, x11
	adcs	x22, x22, xzr
	cmn	x1, x4
	adcs	x1, x2, x5
	adcs	x2, x3, x19
	adcs	x17, x17, x7
	adcs	x3, x20, x22
	adcs	x4, x21, xzr
	adds	x12, x12, x14
	adcs	x13, x6, x13
	adcs	x14, x18, x16
	adcs	x16, x25, xzr
	adds	x15, x1, x15
	adcs	x12, x2, x12
	adcs	x13, x17, x13
	adcs	x14, x3, x14
	mul	x18, x0, x15
	adcs	x16, x4, x16
	mul	x6, x18, x10
	umulh	x7, x18, x11
	adcs	x3, xzr, xzr
	mul	x2, x18, x9
	umulh	x5, x18, x10
	adds	x4, x7, x6
	mul	x0, x18, x8
	umulh	x1, x18, x9
	adcs	x2, x5, x2
	umulh	x17, x18, x8
	adcs	x0, x1, x0
	mul	x18, x18, x11
	adcs	x17, x17, xzr
	cmn	x15, x18
	adcs	x12, x12, x4
	adcs	x13, x13, x2
	adcs	x14, x14, x0
	adcs	x15, x16, x17
	adcs	x16, x3, xzr
	subs	x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	sbcs	x16, x16, xzr
	tst	x16, #0x1
	csel	x11, x11, x12, eq
	ldr	x12, [sp, #8]                   // 8-byte Folded Reload
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	csel	x8, x8, x15, eq
	csel	x9, x9, x14, eq
	csel	x10, x10, x13, eq
	stp	x9, x8, [x12, #16]
	stp	x11, x10, [x12]
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end22:
	.size	mcl_fp_mont4L, .Lfunc_end22-mcl_fp_mont4L
                                        // -- End function
	.globl	mcl_fp_montNF4L                 // -- Begin function mcl_fp_montNF4L
	.p2align	2
	.type	mcl_fp_montNF4L,@function
mcl_fp_montNF4L:                        // @mcl_fp_montNF4L
// %bb.0:
	str	x27, [sp, #-80]!                // 8-byte Folded Spill
	ldp	x15, x14, [x1]
	ldp	x17, x18, [x2]
	ldp	x16, x13, [x1, #16]
	ldp	x12, x11, [x3, #-8]
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	mul	x19, x14, x17
	umulh	x20, x15, x17
	ldr	x10, [x3, #8]
	mul	x6, x16, x17
	umulh	x7, x14, x17
	adds	x19, x20, x19
	ldp	x9, x8, [x3, #16]
	umulh	x3, x13, x17
	mul	x4, x13, x17
	umulh	x5, x16, x17
	mul	x17, x15, x17
	adcs	x6, x7, x6
	mul	x7, x12, x17
	adcs	x4, x5, x4
	mul	x5, x7, x11
	adcs	x3, x3, xzr
	cmn	x17, x5
	mul	x5, x7, x10
	adcs	x5, x19, x5
	mul	x19, x7, x9
	adcs	x6, x6, x19
	mul	x19, x7, x8
	adcs	x4, x4, x19
	umulh	x19, x7, x11
	adcs	x3, x3, xzr
	adds	x5, x5, x19
	umulh	x19, x7, x10
	adcs	x6, x6, x19
	umulh	x19, x7, x9
	adcs	x4, x4, x19
	umulh	x7, x7, x8
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	mul	x26, x18, x14
	umulh	x27, x18, x15
	adcs	x3, x3, x7
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	mul	x24, x18, x16
	umulh	x25, x18, x14
	adds	x26, x27, x26
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	mul	x22, x18, x13
	umulh	x23, x18, x16
	adcs	x24, x25, x24
	umulh	x21, x18, x13
	adcs	x22, x23, x22
	mul	x18, x18, x15
	adcs	x21, x21, xzr
	adds	x18, x18, x5
	ldp	x1, x2, [x2, #16]
	adcs	x6, x26, x6
	adcs	x4, x24, x4
	mul	x24, x12, x18
	adcs	x3, x22, x3
	mul	x22, x24, x11
	adcs	x21, x21, xzr
	umulh	x20, x1, x13
	mul	x17, x1, x13
	umulh	x19, x1, x16
	mul	x7, x1, x16
	umulh	x27, x1, x14
	mul	x25, x1, x14
	umulh	x23, x1, x15
	mul	x1, x1, x15
	umulh	x5, x2, x13
	mul	x13, x2, x13
	umulh	x26, x2, x16
	mul	x16, x2, x16
	cmn	x18, x22
	umulh	x18, x2, x14
	mul	x14, x2, x14
	umulh	x22, x2, x15
	mul	x15, x2, x15
	mul	x2, x24, x10
	adcs	x2, x6, x2
	mul	x6, x24, x9
	adcs	x4, x4, x6
	mul	x6, x24, x8
	adcs	x3, x3, x6
	umulh	x6, x24, x11
	adcs	x21, x21, xzr
	adds	x2, x2, x6
	umulh	x6, x24, x10
	adcs	x4, x4, x6
	umulh	x6, x24, x9
	adcs	x3, x3, x6
	umulh	x6, x24, x8
	adcs	x6, x21, x6
	adds	x21, x23, x25
	adcs	x7, x27, x7
	adcs	x17, x19, x17
	adcs	x19, x20, xzr
	adds	x1, x1, x2
	adcs	x2, x21, x4
	adcs	x3, x7, x3
	mul	x4, x12, x1
	adcs	x17, x17, x6
	mul	x6, x4, x11
	adcs	x19, x19, xzr
	cmn	x1, x6
	mul	x1, x4, x10
	mul	x20, x4, x9
	adcs	x1, x2, x1
	mul	x7, x4, x8
	adcs	x3, x3, x20
	adcs	x17, x17, x7
	umulh	x6, x4, x8
	umulh	x2, x4, x9
	umulh	x20, x4, x10
	umulh	x4, x4, x11
	adcs	x7, x19, xzr
	adds	x1, x1, x4
	adcs	x3, x3, x20
	adcs	x17, x17, x2
	adcs	x2, x7, x6
	adds	x14, x22, x14
	adcs	x16, x18, x16
	adcs	x13, x26, x13
	adcs	x18, x5, xzr
	adds	x15, x15, x1
	mul	x12, x12, x15
	adcs	x14, x14, x3
	mul	x1, x12, x9
	adcs	x16, x16, x17
	mul	x17, x12, x8
	fmov	d0, x1
	umulh	x6, x12, x9
	mov	v0.d[1], x17
	umulh	x5, x12, x8
	fmov	x1, d0
	fmov	d0, x6
	mul	x3, x12, x10
	mul	x4, x12, x11
	umulh	x7, x12, x10
	umulh	x12, x12, x11
	mov	v0.d[1], x5
	adcs	x13, x13, x2
	fmov	x2, d0
	fmov	d0, x12
	adcs	x12, x18, xzr
	cmn	x15, x4
	adcs	x14, x14, x3
	adcs	x16, x16, x1
	mov	v0.d[1], x7
	adcs	x13, x13, x17
	fmov	x15, d0
	adcs	x12, x12, xzr
	adds	x14, x14, x15
	adcs	x15, x16, x7
	adcs	x13, x13, x2
	adcs	x12, x12, x5
	subs	x11, x14, x11
	sbcs	x10, x15, x10
	sbcs	x9, x13, x9
	sbcs	x8, x12, x8
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	cmp	x8, #0                          // =0
	csel	x8, x8, x12, ge
	csel	x9, x9, x13, ge
	csel	x10, x10, x15, ge
	csel	x11, x11, x14, ge
	stp	x9, x8, [x0, #16]
	stp	x11, x10, [x0]
	ldr	x27, [sp], #80                  // 8-byte Folded Reload
	ret
.Lfunc_end23:
	.size	mcl_fp_montNF4L, .Lfunc_end23-mcl_fp_montNF4L
                                        // -- End function
	.globl	mcl_fp_montRed4L                // -- Begin function mcl_fp_montRed4L
	.p2align	2
	.type	mcl_fp_montRed4L,@function
mcl_fp_montRed4L:                       // @mcl_fp_montRed4L
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x12, x11, [x2, #-8]
	ldp	x16, x17, [x1]
	ldr	x10, [x2, #8]
	ldp	x9, x8, [x2, #16]
	ldp	x15, x14, [x1, #16]
	mul	x3, x16, x12
	mul	x7, x3, x10
	umulh	x19, x3, x11
	mul	x6, x3, x9
	adds	x7, x19, x7
	umulh	x19, x3, x10
	mul	x5, x3, x8
	adcs	x6, x19, x6
	umulh	x19, x3, x9
	umulh	x4, x3, x8
	adcs	x5, x19, x5
	mul	x3, x3, x11
	adcs	x4, x4, xzr
	ldp	x13, x18, [x1, #32]
	cmn	x3, x16
	adcs	x16, x7, x17
	adcs	x15, x6, x15
	adcs	x14, x5, x14
	mul	x17, x12, x16
	adcs	x13, x4, x13
	umulh	x7, x17, x11
	mul	x19, x17, x10
	adcs	x4, xzr, xzr
	umulh	x6, x17, x10
	adds	x7, x19, x7
	mul	x19, x17, x9
	umulh	x5, x17, x9
	adcs	x6, x19, x6
	mul	x19, x17, x8
	umulh	x3, x17, x8
	adcs	x5, x19, x5
	mul	x17, x17, x11
	adcs	x3, x4, x3
	cmn	x17, x16
	adcs	x15, x7, x15
	adcs	x14, x6, x14
	adcs	x13, x5, x13
	mul	x16, x12, x15
	adcs	x18, x3, x18
	umulh	x7, x16, x11
	mul	x19, x16, x10
	adcs	x3, xzr, xzr
	umulh	x6, x16, x10
	adds	x7, x19, x7
	mul	x19, x16, x9
	umulh	x4, x16, x9
	mul	x5, x16, x8
	adcs	x6, x19, x6
	umulh	x17, x16, x8
	adcs	x4, x5, x4
	mul	x16, x16, x11
	adcs	x17, x3, x17
	cmn	x16, x15
	adcs	x14, x7, x14
	mul	x12, x12, x14
	umulh	x16, x12, x9
	umulh	x15, x12, x8
	fmov	d0, x16
	ldp	x2, x1, [x1, #48]
	adcs	x13, x6, x13
	mul	x5, x12, x9
	mov	v0.d[1], x15
	mul	x3, x12, x8
	adcs	x18, x4, x18
	fmov	x4, d0
	fmov	d0, x5
	umulh	x7, x12, x11
	mov	v0.d[1], x3
	umulh	x6, x12, x10
	fmov	x5, d0
	fmov	d0, x7
	adcs	x17, x17, x2
	mov	v0.d[1], x6
	mul	x16, x12, x10
	adcs	x2, xzr, xzr
	fmov	x7, d0
	adds	x16, x16, x7
	adcs	x5, x5, x6
	adcs	x3, x3, x4
	mul	x12, x12, x11
	adcs	x15, x2, x15
	cmn	x12, x14
	adcs	x12, x16, x13
	adcs	x13, x5, x18
	adcs	x14, x3, x17
	adcs	x15, x15, x1
	adcs	x16, xzr, xzr
	subs	x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	sbcs	x16, x16, xzr
	tst	x16, #0x1
	csel	x8, x8, x15, eq
	csel	x9, x9, x14, eq
	csel	x10, x10, x13, eq
	csel	x11, x11, x12, eq
	stp	x9, x8, [x0, #16]
	stp	x11, x10, [x0]
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end24:
	.size	mcl_fp_montRed4L, .Lfunc_end24-mcl_fp_montRed4L
                                        // -- End function
	.globl	mcl_fp_montRedNF4L              // -- Begin function mcl_fp_montRedNF4L
	.p2align	2
	.type	mcl_fp_montRedNF4L,@function
mcl_fp_montRedNF4L:                     // @mcl_fp_montRedNF4L
// %bb.0:
	stp	x20, x19, [sp, #-16]!           // 16-byte Folded Spill
	ldp	x12, x11, [x2, #-8]
	ldp	x16, x17, [x1]
	ldr	x10, [x2, #8]
	ldp	x9, x8, [x2, #16]
	ldp	x15, x14, [x1, #16]
	mul	x3, x16, x12
	mul	x19, x3, x10
	umulh	x20, x3, x11
	mul	x7, x3, x9
	adds	x19, x20, x19
	umulh	x20, x3, x10
	mul	x5, x3, x8
	umulh	x6, x3, x9
	adcs	x7, x20, x7
	umulh	x4, x3, x8
	adcs	x5, x6, x5
	mul	x3, x3, x11
	adcs	x4, x4, xzr
	ldp	x13, x2, [x1, #32]
	cmn	x3, x16
	adcs	x16, x19, x17
	adcs	x15, x7, x15
	adcs	x14, x5, x14
	mul	x17, x12, x16
	adcs	x13, x4, x13
	umulh	x19, x17, x11
	mul	x20, x17, x10
	adcs	x4, xzr, xzr
	umulh	x7, x17, x10
	adds	x19, x20, x19
	mul	x20, x17, x9
	umulh	x5, x17, x9
	mul	x6, x17, x8
	adcs	x7, x20, x7
	umulh	x3, x17, x8
	adcs	x5, x6, x5
	mul	x17, x17, x11
	adcs	x3, x4, x3
	cmn	x17, x16
	adcs	x15, x19, x15
	mul	x16, x12, x15
	umulh	x4, x16, x9
	umulh	x17, x16, x8
	fmov	d0, x4
	adcs	x14, x7, x14
	mul	x7, x16, x9
	mov	v0.d[1], x17
	mul	x6, x16, x8
	adcs	x13, x5, x13
	fmov	x5, d0
	fmov	d0, x7
	umulh	x20, x16, x11
	mov	v0.d[1], x6
	umulh	x19, x16, x10
	fmov	x7, d0
	fmov	d0, x20
	adcs	x2, x3, x2
	mov	v0.d[1], x19
	mul	x4, x16, x10
	adcs	x3, xzr, xzr
	fmov	x20, d0
	adds	x4, x4, x20
	adcs	x7, x7, x19
	adcs	x5, x6, x5
	mul	x16, x16, x11
	adcs	x17, x3, x17
	cmn	x16, x15
	adcs	x14, x4, x14
	adcs	x13, x7, x13
	mul	x12, x12, x14
	adcs	x15, x5, x2
	umulh	x2, x12, x9
	ldp	x18, x1, [x1, #48]
	umulh	x16, x12, x8
	fmov	d0, x2
	mul	x4, x12, x9
	mov	v0.d[1], x16
	mul	x3, x12, x8
	fmov	x2, d0
	fmov	d0, x4
	umulh	x6, x12, x11
	mov	v0.d[1], x3
	umulh	x5, x12, x10
	adcs	x17, x17, x18
	fmov	x18, d0
	fmov	d0, x6
	mov	v0.d[1], x5
	mul	x7, x12, x10
	adcs	x4, xzr, xzr
	fmov	x6, d0
	adds	x6, x7, x6
	adcs	x18, x18, x5
	adcs	x2, x3, x2
	mul	x12, x12, x11
	adcs	x16, x4, x16
	cmn	x12, x14
	adcs	x12, x6, x13
	adcs	x13, x18, x15
	adcs	x14, x2, x17
	adcs	x15, x16, x1
	subs	x11, x12, x11
	sbcs	x10, x13, x10
	sbcs	x9, x14, x9
	sbcs	x8, x15, x8
	cmp	x8, #0                          // =0
	csel	x8, x8, x15, ge
	csel	x9, x9, x14, ge
	csel	x10, x10, x13, ge
	csel	x11, x11, x12, ge
	stp	x9, x8, [x0, #16]
	stp	x11, x10, [x0]
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end25:
	.size	mcl_fp_montRedNF4L, .Lfunc_end25-mcl_fp_montRedNF4L
                                        // -- End function
	.globl	mcl_fp_addPre4L                 // -- Begin function mcl_fp_addPre4L
	.p2align	2
	.type	mcl_fp_addPre4L,@function
mcl_fp_addPre4L:                        // @mcl_fp_addPre4L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	adds	x8, x8, x9
	ldp	x9, x13, [x1, #16]
	fmov	d0, x8
	ldp	x8, x12, [x2, #16]
	adcs	x10, x11, x10
	mov	v0.d[1], x10
	adcs	x8, x9, x8
	fmov	d1, x8
	adcs	x8, x13, x12
	mov	v1.d[1], x8
	adcs	x8, xzr, xzr
	stp	q0, q1, [x0]
	mov	x0, x8
	ret
.Lfunc_end26:
	.size	mcl_fp_addPre4L, .Lfunc_end26-mcl_fp_addPre4L
                                        // -- End function
	.globl	mcl_fp_subPre4L                 // -- Begin function mcl_fp_subPre4L
	.p2align	2
	.type	mcl_fp_subPre4L,@function
mcl_fp_subPre4L:                        // @mcl_fp_subPre4L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	subs	x8, x8, x9
	ldp	x9, x13, [x1, #16]
	fmov	d0, x8
	ldp	x8, x12, [x2, #16]
	sbcs	x10, x11, x10
	mov	v0.d[1], x10
	sbcs	x8, x9, x8
	fmov	d1, x8
	sbcs	x8, x13, x12
	mov	v1.d[1], x8
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	q0, q1, [x0]
	mov	x0, x8
	ret
.Lfunc_end27:
	.size	mcl_fp_subPre4L, .Lfunc_end27-mcl_fp_subPre4L
                                        // -- End function
	.globl	mcl_fp_shr1_4L                  // -- Begin function mcl_fp_shr1_4L
	.p2align	2
	.type	mcl_fp_shr1_4L,@function
mcl_fp_shr1_4L:                         // @mcl_fp_shr1_4L
// %bb.0:
	ldp	x9, x8, [x1, #16]
	ldp	x11, x10, [x1]
	lsr	x12, x8, #1
	extr	x8, x8, x9, #1
	extr	x9, x9, x10, #1
	extr	x10, x10, x11, #1
	stp	x8, x12, [x0, #16]
	stp	x10, x9, [x0]
	ret
.Lfunc_end28:
	.size	mcl_fp_shr1_4L, .Lfunc_end28-mcl_fp_shr1_4L
                                        // -- End function
	.globl	mcl_fp_add4L                    // -- Begin function mcl_fp_add4L
	.p2align	2
	.type	mcl_fp_add4L,@function
mcl_fp_add4L:                           // @mcl_fp_add4L
// %bb.0:
	ldp	x8, x9, [x2]
	ldp	x10, x11, [x1]
	ldp	x12, x13, [x2, #16]
	adds	x8, x10, x8
	ldp	x10, x14, [x1, #16]
	adcs	x9, x11, x9
	ldp	x11, x16, [x3]
	fmov	d0, x8
	adcs	x10, x10, x12
	ldp	x15, x8, [x3, #16]
	mov	v0.d[1], x9
	adcs	x12, x14, x13
	fmov	d1, x10
	fmov	x10, d0
	adcs	x13, xzr, xzr
	mov	v1.d[1], x12
	subs	x11, x10, x11
	fmov	x14, d1
	sbcs	x10, x9, x16
	sbcs	x9, x14, x15
	sbcs	x8, x12, x8
	sbcs	x12, x13, xzr
	stp	q0, q1, [x0]
	tbnz	w12, #0, .LBB29_2
// %bb.1:                               // %nocarry
	stp	x11, x10, [x0]
	stp	x9, x8, [x0, #16]
.LBB29_2:                               // %common.ret
	ret
.Lfunc_end29:
	.size	mcl_fp_add4L, .Lfunc_end29-mcl_fp_add4L
                                        // -- End function
	.globl	mcl_fp_addNF4L                  // -- Begin function mcl_fp_addNF4L
	.p2align	2
	.type	mcl_fp_addNF4L,@function
mcl_fp_addNF4L:                         // @mcl_fp_addNF4L
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldp	x13, x12, [x1, #16]
	ldp	x15, x14, [x2, #16]
	adds	x9, x11, x9
	adcs	x8, x10, x8
	ldp	x11, x10, [x3]
	adcs	x13, x15, x13
	ldp	x16, x15, [x3, #16]
	adcs	x12, x14, x12
	fmov	d0, x13
	mov	v0.d[1], x12
	subs	x11, x9, x11
	fmov	x13, d0
	sbcs	x10, x8, x10
	sbcs	x14, x13, x16
	sbcs	x15, x12, x15
	cmp	x15, #0                         // =0
	csel	x12, x15, x12, ge
	csel	x13, x14, x13, ge
	csel	x8, x10, x8, ge
	csel	x9, x11, x9, ge
	stp	x13, x12, [x0, #16]
	stp	x9, x8, [x0]
	ret
.Lfunc_end30:
	.size	mcl_fp_addNF4L, .Lfunc_end30-mcl_fp_addNF4L
                                        // -- End function
	.globl	mcl_fp_sub4L                    // -- Begin function mcl_fp_sub4L
	.p2align	2
	.type	mcl_fp_sub4L,@function
mcl_fp_sub4L:                           // @mcl_fp_sub4L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldp	x12, x14, [x1, #16]
	subs	x8, x8, x9
	fmov	d0, x8
	ldp	x8, x13, [x2, #16]
	sbcs	x9, x11, x10
	mov	v0.d[1], x9
	sbcs	x8, x12, x8
	fmov	d1, x8
	sbcs	x8, x14, x13
	mov	v1.d[1], x8
	ngcs	x10, xzr
	stp	q0, q1, [x0]
	tbz	w10, #0, .LBB31_2
// %bb.1:                               // %carry
	ldp	x12, x13, [x3]
	ldp	x14, x15, [x3, #16]
	fmov	x10, d0
	fmov	x11, d1
	adds	x10, x12, x10
	adcs	x9, x13, x9
	stp	x10, x9, [x0]
	adcs	x9, x14, x11
	adcs	x8, x15, x8
	stp	x9, x8, [x0, #16]
.LBB31_2:                               // %common.ret
	ret
.Lfunc_end31:
	.size	mcl_fp_sub4L, .Lfunc_end31-mcl_fp_sub4L
                                        // -- End function
	.globl	mcl_fp_subNF4L                  // -- Begin function mcl_fp_subNF4L
	.p2align	2
	.type	mcl_fp_subNF4L,@function
mcl_fp_subNF4L:                         // @mcl_fp_subNF4L
// %bb.0:
	ldp	x9, x8, [x2]
	ldp	x11, x10, [x1]
	ldp	x13, x12, [x2, #16]
	ldp	x15, x14, [x1, #16]
	subs	x9, x11, x9
	sbcs	x8, x10, x8
	ldp	x10, x11, [x3]
	sbcs	x13, x15, x13
	ldp	x15, x16, [x3, #16]
	sbcs	x12, x14, x12
	fmov	d0, x13
	asr	x13, x12, #63
	and	x10, x13, x10
	mov	v0.d[1], x12
	and	x11, x13, x11
	adds	x9, x10, x9
	fmov	x14, d0
	and	x15, x13, x15
	adcs	x8, x11, x8
	and	x13, x13, x16
	stp	x9, x8, [x0]
	adcs	x8, x15, x14
	adcs	x9, x13, x12
	stp	x8, x9, [x0, #16]
	ret
.Lfunc_end32:
	.size	mcl_fp_subNF4L, .Lfunc_end32-mcl_fp_subNF4L
                                        // -- End function
	.globl	mcl_fpDbl_add4L                 // -- Begin function mcl_fpDbl_add4L
	.p2align	2
	.type	mcl_fpDbl_add4L,@function
mcl_fpDbl_add4L:                        // @mcl_fpDbl_add4L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	adds	x8, x8, x9
	ldp	x9, x13, [x2, #16]
	fmov	d0, x8
	ldp	x12, x8, [x1, #16]
	adcs	x10, x11, x10
	mov	v0.d[1], x10
	adcs	x9, x12, x9
	ldp	x12, x11, [x2, #32]
	fmov	d1, x9
	ldp	x10, x9, [x1, #32]
	adcs	x8, x8, x13
	ldp	x13, x14, [x2, #48]
	mov	v1.d[1], x8
	ldp	x8, x15, [x1, #48]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	stp	q0, q1, [x0]
	fmov	d0, x10
	adcs	x8, x8, x13
	ldp	x13, x10, [x3]
	mov	v0.d[1], x9
	ldp	x12, x11, [x3, #16]
	fmov	x16, d0
	fmov	d0, x8
	adcs	x8, x15, x14
	adcs	x14, xzr, xzr
	mov	v0.d[1], x8
	subs	x13, x16, x13
	fmov	x15, d0
	sbcs	x10, x9, x10
	sbcs	x12, x15, x12
	sbcs	x11, x8, x11
	sbcs	x14, x14, xzr
	tst	x14, #0x1
	csel	x13, x13, x16, eq
	csel	x9, x10, x9, eq
	csel	x10, x12, x15, eq
	csel	x8, x11, x8, eq
	stp	x13, x9, [x0, #32]
	stp	x10, x8, [x0, #48]
	ret
.Lfunc_end33:
	.size	mcl_fpDbl_add4L, .Lfunc_end33-mcl_fpDbl_add4L
                                        // -- End function
	.globl	mcl_fpDbl_sub4L                 // -- Begin function mcl_fpDbl_sub4L
	.p2align	2
	.type	mcl_fpDbl_sub4L,@function
mcl_fpDbl_sub4L:                        // @mcl_fpDbl_sub4L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	subs	x8, x8, x9
	ldp	x9, x12, [x2, #16]
	fmov	d0, x8
	sbcs	x10, x11, x10
	ldp	x8, x11, [x1, #16]
	mov	v0.d[1], x10
	sbcs	x8, x8, x9
	ldp	x9, x10, [x2, #32]
	fmov	d1, x8
	sbcs	x8, x11, x12
	ldp	x11, x12, [x1, #32]
	mov	v1.d[1], x8
	ldp	x13, x8, [x2, #48]
	stp	q0, q1, [x0]
	sbcs	x9, x11, x9
	ldp	x14, x11, [x1, #48]
	fmov	d0, x9
	sbcs	x9, x12, x10
	ldp	x10, x12, [x3]
	sbcs	x13, x14, x13
	mov	v0.d[1], x9
	sbcs	x8, x11, x8
	ldp	x14, x15, [x3, #16]
	fmov	x11, d0
	fmov	d0, x13
	ngcs	x13, xzr
	sbfx	x13, x13, #0, #1
	and	x10, x13, x10
	and	x12, x13, x12
	mov	v0.d[1], x8
	adds	x10, x10, x11
	and	x14, x13, x14
	fmov	x11, d0
	adcs	x9, x12, x9
	and	x13, x13, x15
	stp	x10, x9, [x0, #32]
	adcs	x9, x14, x11
	adcs	x8, x13, x8
	stp	x9, x8, [x0, #48]
	ret
.Lfunc_end34:
	.size	mcl_fpDbl_sub4L, .Lfunc_end34-mcl_fpDbl_sub4L
                                        // -- End function
	.globl	mulPv384x64                     // -- Begin function mulPv384x64
	.p2align	2
	.type	mulPv384x64,@function
mulPv384x64:                            // @mulPv384x64
// %bb.0:
	ldp	x9, x8, [x0, #32]
	ldp	x13, x12, [x0]
	ldp	x11, x10, [x0, #16]
	umulh	x14, x8, x1
	mul	x15, x8, x1
	umulh	x0, x12, x1
	mul	x8, x12, x1
	umulh	x12, x13, x1
	umulh	x18, x11, x1
	mul	x11, x11, x1
	adds	x8, x12, x8
	umulh	x17, x10, x1
	mul	x10, x10, x1
	adcs	x2, x0, x11
	umulh	x16, x9, x1
	mul	x9, x9, x1
	adcs	x3, x18, x10
	adcs	x4, x17, x9
	adcs	x5, x16, x15
	adcs	x6, x14, xzr
	mul	x0, x13, x1
	mov	x1, x8
	ret
.Lfunc_end35:
	.size	mulPv384x64, .Lfunc_end35-mulPv384x64
                                        // -- End function
	.globl	mcl_fp_mont6L                   // -- Begin function mcl_fp_mont6L
	.p2align	2
	.type	mcl_fp_mont6L,@function
mcl_fp_mont6L:                          // @mcl_fp_mont6L
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldr	x6, [x2]
	ldp	x10, x4, [x1]
	str	x0, [sp, #16]                   // 8-byte Folded Spill
	ldp	x17, x0, [x1, #16]
	mov	x12, x2
	ldp	x2, x5, [x1, #32]
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	mul	x26, x4, x6
	umulh	x27, x10, x6
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	ldp	x9, x18, [x3, #-8]
	mul	x24, x17, x6
	umulh	x25, x4, x6
	adds	x26, x27, x26
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	ldr	x16, [x3, #8]
	mul	x22, x0, x6
	umulh	x23, x17, x6
	adcs	x24, x25, x24
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	ldp	x15, x14, [x3, #16]
	mul	x20, x2, x6
	umulh	x21, x0, x6
	adcs	x22, x23, x22
	ldp	x13, x8, [x3, #32]
	umulh	x3, x5, x6
	mul	x7, x5, x6
	umulh	x19, x2, x6
	mul	x6, x10, x6
	adcs	x20, x21, x20
	mul	x27, x9, x6
	adcs	x7, x19, x7
	mul	x21, x27, x16
	umulh	x19, x27, x18
	adcs	x3, x3, xzr
	mul	x23, x27, x15
	adds	x19, x19, x21
	umulh	x21, x27, x16
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	mul	x30, x27, x14
	adcs	x21, x21, x23
	umulh	x23, x27, x15
	mul	x29, x27, x13
	adcs	x23, x23, x30
	umulh	x30, x27, x14
	mul	x25, x27, x8
	adcs	x29, x30, x29
	umulh	x30, x27, x13
	adcs	x25, x30, x25
	umulh	x30, x27, x8
	mul	x27, x27, x18
	adcs	x30, x30, xzr
	cmn	x27, x6
	adcs	x19, x19, x26
	adcs	x21, x21, x24
	ldr	x1, [x12, #8]
	adcs	x22, x23, x22
	adcs	x20, x29, x20
	adcs	x25, x25, x7
	adcs	x30, x30, x3
	mul	x29, x1, x4
	umulh	x7, x1, x10
	adcs	x3, xzr, xzr
	mul	x23, x1, x17
	adds	x7, x7, x29
	umulh	x29, x1, x4
	mul	x24, x1, x0
	adcs	x29, x29, x23
	umulh	x23, x1, x17
	mul	x26, x1, x2
	adcs	x24, x23, x24
	umulh	x23, x1, x0
	mul	x6, x1, x5
	umulh	x27, x1, x2
	adcs	x26, x23, x26
	umulh	x28, x1, x5
	adcs	x27, x27, x6
	mul	x1, x1, x10
	adcs	x28, x28, xzr
	adds	x1, x19, x1
	adcs	x23, x21, x7
	adcs	x29, x22, x29
	adcs	x24, x20, x24
	adcs	x25, x25, x26
	adcs	x30, x30, x27
	mul	x6, x9, x1
	adcs	x3, x3, x28
	mul	x26, x6, x16
	umulh	x27, x6, x18
	adcs	x28, xzr, xzr
	mul	x20, x6, x15
	adds	x26, x27, x26
	umulh	x27, x6, x16
	mul	x22, x6, x14
	adcs	x20, x27, x20
	umulh	x27, x6, x15
	mul	x21, x6, x13
	adcs	x22, x27, x22
	umulh	x27, x6, x14
	mul	x19, x6, x8
	adcs	x21, x27, x21
	umulh	x27, x6, x13
	umulh	x7, x6, x8
	adcs	x19, x27, x19
	mul	x6, x6, x18
	adcs	x7, x7, xzr
	cmn	x1, x6
	adcs	x23, x23, x26
	adcs	x20, x29, x20
	ldp	x27, x1, [x12, #16]
	adcs	x22, x24, x22
	adcs	x21, x25, x21
	adcs	x30, x30, x19
	adcs	x7, x3, x7
	mul	x19, x27, x4
	umulh	x3, x27, x10
	adcs	x28, x28, xzr
	mul	x25, x27, x17
	adds	x3, x3, x19
	umulh	x19, x27, x4
	mul	x24, x27, x0
	adcs	x19, x19, x25
	umulh	x25, x27, x17
	mul	x29, x27, x2
	adcs	x24, x25, x24
	umulh	x25, x27, x0
	mul	x26, x27, x5
	adcs	x25, x25, x29
	umulh	x29, x27, x2
	umulh	x6, x27, x5
	adcs	x26, x29, x26
	mul	x27, x27, x10
	adcs	x29, x6, xzr
	adds	x23, x23, x27
	adcs	x3, x20, x3
	adcs	x6, x22, x19
	adcs	x19, x21, x24
	adcs	x21, x30, x25
	stp	x21, x10, [sp]                  // 16-byte Folded Spill
	adcs	x21, x7, x26
	mul	x20, x9, x23
	adcs	x22, x28, x29
	mul	x24, x20, x16
	umulh	x25, x20, x18
	adcs	x7, xzr, xzr
	str	x9, [sp, #24]                   // 8-byte Folded Spill
	mov	x9, x8
	mul	x11, x20, x8
	mul	x8, x20, x15
	adds	x24, x25, x24
	umulh	x25, x20, x16
	mul	x10, x20, x14
	adcs	x25, x25, x8
	umulh	x8, x20, x15
	mul	x27, x20, x13
	adcs	x26, x8, x10
	umulh	x8, x20, x14
	adcs	x27, x8, x27
	umulh	x8, x20, x13
	adcs	x28, x8, x11
	umulh	x8, x20, x9
	mov	x30, x9
	mul	x9, x20, x18
	adcs	x29, x8, xzr
	cmn	x23, x9
	ldr	x9, [sp]                        // 8-byte Folded Reload
	ldp	x23, x8, [x12, #32]
	adcs	x12, x3, x24
	adcs	x6, x6, x25
	adcs	x19, x19, x26
	adcs	x25, x9, x27
	ldr	x9, [sp, #8]                    // 8-byte Folded Reload
	adcs	x21, x21, x28
	adcs	x22, x22, x29
	mul	x27, x1, x4
	umulh	x28, x1, x9
	adcs	x7, x7, xzr
	mul	x26, x1, x17
	adds	x27, x28, x27
	umulh	x28, x1, x4
	mul	x24, x1, x0
	adcs	x26, x28, x26
	umulh	x28, x1, x17
	mul	x20, x1, x2
	adcs	x24, x28, x24
	umulh	x28, x1, x0
	mul	x3, x1, x5
	adcs	x20, x28, x20
	umulh	x28, x1, x2
	umulh	x10, x1, x5
	adcs	x3, x28, x3
	mul	x1, x1, x9
	adcs	x29, x10, xzr
	adds	x10, x12, x1
	adcs	x1, x6, x27
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	adcs	x19, x19, x26
	adcs	x24, x25, x24
	adcs	x20, x21, x20
	adcs	x3, x22, x3
	mul	x6, x11, x10
	adcs	x12, x7, x29
	mul	x21, x6, x16
	umulh	x22, x6, x18
	adcs	x7, xzr, xzr
	mul	x25, x6, x15
	adds	x21, x22, x21
	umulh	x22, x6, x16
	mul	x28, x6, x14
	adcs	x22, x22, x25
	umulh	x25, x6, x15
	mul	x27, x6, x13
	adcs	x25, x25, x28
	umulh	x28, x6, x14
	mul	x26, x6, x30
	adcs	x27, x28, x27
	umulh	x28, x6, x13
	adcs	x26, x28, x26
	umulh	x28, x6, x30
	mul	x6, x6, x18
	adcs	x28, x28, xzr
	cmn	x10, x6
	adcs	x1, x1, x21
	adcs	x19, x19, x22
	adcs	x24, x24, x25
	adcs	x20, x20, x27
	adcs	x3, x3, x26
	adcs	x12, x12, x28
	mul	x26, x23, x4
	umulh	x28, x23, x9
	adcs	x7, x7, xzr
	mul	x27, x23, x17
	adds	x26, x28, x26
	umulh	x28, x23, x4
	mul	x25, x23, x0
	adcs	x27, x28, x27
	umulh	x28, x23, x17
	mul	x22, x23, x2
	adcs	x25, x28, x25
	umulh	x28, x23, x0
	mul	x6, x23, x5
	umulh	x21, x23, x2
	adcs	x22, x28, x22
	umulh	x10, x23, x5
	adcs	x6, x21, x6
	mul	x23, x23, x9
	adcs	x10, x10, xzr
	adds	x1, x1, x23
	umulh	x28, x8, x5
	adcs	x19, x19, x26
	str	x28, [sp]                       // 8-byte Folded Spill
	mul	x28, x8, x5
	adcs	x5, x24, x27
	adcs	x20, x20, x25
	adcs	x3, x3, x22
	mul	x21, x11, x1
	adcs	x11, x12, x6
	adcs	x10, x7, x10
	mul	x22, x21, x16
	umulh	x6, x21, x18
	adcs	x7, xzr, xzr
	mul	x25, x21, x15
	adds	x6, x6, x22
	umulh	x22, x21, x16
	mul	x27, x21, x14
	adcs	x22, x22, x25
	umulh	x25, x21, x15
	mul	x26, x21, x13
	adcs	x25, x25, x27
	umulh	x27, x21, x14
	mul	x24, x21, x30
	adcs	x26, x27, x26
	umulh	x27, x21, x13
	adcs	x24, x27, x24
	mul	x27, x21, x18
	umulh	x21, x21, x30
	adcs	x21, x21, xzr
	cmn	x1, x27
	adcs	x6, x19, x6
	adcs	x19, x5, x22
	adcs	x20, x20, x25
	adcs	x3, x3, x26
	adcs	x11, x11, x24
	adcs	x10, x10, x21
	mov	x23, x30
	umulh	x30, x8, x4
	mul	x4, x8, x4
	umulh	x12, x8, x9
	adcs	x7, x7, xzr
	umulh	x1, x8, x2
	mul	x2, x8, x2
	umulh	x27, x8, x0
	mul	x0, x8, x0
	umulh	x29, x8, x17
	mul	x17, x8, x17
	mul	x8, x8, x9
	adds	x9, x12, x4
	adcs	x17, x30, x17
	ldr	x12, [sp]                       // 8-byte Folded Reload
	adcs	x0, x29, x0
	adcs	x2, x27, x2
	adcs	x1, x1, x28
	adcs	x4, x12, xzr
	adds	x8, x6, x8
	adcs	x9, x19, x9
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	adcs	x17, x20, x17
	adcs	x0, x3, x0
	adcs	x11, x11, x2
	adcs	x10, x10, x1
	mul	x5, x12, x8
	adcs	x4, x7, x4
	mul	x2, x5, x16
	umulh	x1, x5, x18
	adcs	x7, xzr, xzr
	mul	x3, x5, x15
	adds	x1, x1, x2
	umulh	x2, x5, x16
	mul	x20, x5, x14
	adcs	x2, x2, x3
	umulh	x3, x5, x15
	mul	x19, x5, x13
	adcs	x3, x3, x20
	umulh	x20, x5, x14
	mov	x12, x23
	mul	x6, x5, x23
	adcs	x19, x20, x19
	umulh	x20, x5, x13
	adcs	x6, x20, x6
	umulh	x20, x5, x12
	mul	x5, x5, x18
	adcs	x20, x20, xzr
	cmn	x8, x5
	adcs	x8, x9, x1
	adcs	x9, x17, x2
	adcs	x17, x0, x3
	adcs	x11, x11, x19
	adcs	x10, x10, x6
	adcs	x0, x4, x20
	adcs	x1, x7, xzr
	mov	x23, x14
	subs	x14, x8, x18
	mov	x21, x12
	sbcs	x12, x9, x16
	mov	x22, x13
	sbcs	x13, x17, x15
	sbcs	x15, x11, x23
	sbcs	x16, x10, x22
	sbcs	x18, x0, x21
	sbcs	x1, x1, xzr
	tst	x1, #0x1
	csel	x9, x12, x9, eq
	ldr	x12, [sp, #16]                  // 8-byte Folded Reload
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	csel	x18, x18, x0, eq
	csel	x10, x16, x10, eq
	csel	x11, x15, x11, eq
	csel	x13, x13, x17, eq
	csel	x8, x14, x8, eq
	stp	x10, x18, [x12, #32]
	stp	x13, x11, [x12, #16]
	stp	x8, x9, [x12]
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end36:
	.size	mcl_fp_mont6L, .Lfunc_end36-mcl_fp_mont6L
                                        // -- End function
	.globl	mcl_fp_montNF6L                 // -- Begin function mcl_fp_montNF6L
	.p2align	2
	.type	mcl_fp_montNF6L,@function
mcl_fp_montNF6L:                        // @mcl_fp_montNF6L
// %bb.0:
	sub	sp, sp, #208                    // =208
	str	x0, [sp, #104]                  // 8-byte Folded Spill
	ldp	x17, x16, [x1, #32]
	ldp	x8, x13, [x1, #16]
	ldp	x11, x18, [x1]
	ldp	x1, x15, [x3, #-8]
	ldp	x9, x0, [x3, #32]
	ldp	x10, x4, [x3, #16]
	ldr	x14, [x3, #8]
	ldp	x5, x3, [x2]
	stp	x29, x30, [sp, #112]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #128]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #144]            // 16-byte Folded Spill
	mul	x29, x18, x5
	umulh	x30, x11, x5
	mul	x27, x8, x5
	umulh	x28, x18, x5
	adds	x29, x30, x29
	mul	x25, x13, x5
	umulh	x26, x8, x5
	adcs	x27, x28, x27
	stp	x24, x23, [sp, #160]            // 16-byte Folded Spill
	mul	x23, x17, x5
	umulh	x24, x13, x5
	adcs	x25, x26, x25
	stp	x22, x21, [sp, #176]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #192]            // 16-byte Folded Spill
	umulh	x20, x16, x5
	mul	x21, x16, x5
	umulh	x22, x17, x5
	mul	x5, x11, x5
	adcs	x23, x24, x23
	mul	x24, x1, x5
	adcs	x21, x22, x21
	mul	x22, x24, x15
	adcs	x20, x20, xzr
	cmn	x5, x22
	mul	x22, x24, x14
	adcs	x22, x29, x22
	mul	x29, x24, x10
	adcs	x27, x27, x29
	mul	x29, x24, x4
	adcs	x25, x25, x29
	mul	x29, x24, x9
	adcs	x23, x23, x29
	mul	x29, x24, x0
	adcs	x21, x21, x29
	umulh	x29, x24, x15
	adcs	x20, x20, xzr
	adds	x22, x22, x29
	umulh	x29, x24, x14
	adcs	x27, x27, x29
	umulh	x29, x24, x10
	adcs	x25, x25, x29
	umulh	x29, x24, x4
	mul	x26, x3, x13
	mov	x12, x13
	mov	x13, x0
	adcs	x23, x23, x29
	umulh	x29, x24, x9
	adcs	x21, x21, x29
	umulh	x24, x24, x13
	mul	x29, x3, x18
	adcs	x20, x20, x24
	umulh	x24, x3, x11
	mul	x5, x3, x8
	adds	x24, x24, x29
	umulh	x29, x3, x18
	adcs	x5, x29, x5
	umulh	x29, x3, x8
	mul	x28, x3, x17
	adcs	x26, x29, x26
	umulh	x29, x3, x12
	mul	x30, x3, x16
	adcs	x28, x29, x28
	umulh	x29, x3, x17
	adcs	x29, x29, x30
	umulh	x30, x3, x16
	mul	x3, x3, x11
	adcs	x30, x30, xzr
	adds	x3, x3, x22
	adcs	x24, x24, x27
	adcs	x5, x5, x25
	adcs	x23, x26, x23
	adcs	x21, x28, x21
	mul	x28, x1, x3
	adcs	x20, x29, x20
	mul	x29, x28, x15
	adcs	x30, x30, xzr
	cmn	x3, x29
	mul	x29, x28, x14
	adcs	x24, x24, x29
	mul	x29, x28, x10
	mov	x0, x9
	adcs	x5, x5, x29
	mul	x29, x28, x4
	mov	x9, x13
	adcs	x23, x23, x29
	mul	x29, x28, x0
	adcs	x21, x21, x29
	mul	x29, x28, x9
	adcs	x20, x20, x29
	umulh	x29, x28, x15
	adcs	x30, x30, xzr
	adds	x24, x24, x29
	umulh	x29, x28, x14
	ldp	x6, x7, [x2, #16]
	adcs	x5, x5, x29
	umulh	x29, x28, x10
	adcs	x23, x23, x29
	umulh	x29, x28, x4
	adcs	x21, x21, x29
	umulh	x29, x28, x0
	adcs	x20, x20, x29
	umulh	x28, x28, x9
	mul	x29, x6, x18
	adcs	x28, x30, x28
	umulh	x30, x6, x11
	mul	x3, x6, x8
	adds	x29, x30, x29
	umulh	x30, x6, x18
	mul	x26, x6, x12
	adcs	x3, x30, x3
	umulh	x30, x6, x8
	mul	x25, x6, x17
	adcs	x26, x30, x26
	umulh	x30, x6, x12
	mul	x27, x6, x16
	adcs	x25, x30, x25
	umulh	x30, x6, x17
	umulh	x22, x6, x16
	adcs	x27, x30, x27
	mul	x6, x6, x11
	adcs	x22, x22, xzr
	adds	x6, x6, x24
	adcs	x5, x29, x5
	adcs	x3, x3, x23
	adcs	x21, x26, x21
	adcs	x20, x25, x20
	mul	x25, x1, x6
	adcs	x27, x27, x28
	mul	x28, x25, x15
	adcs	x22, x22, xzr
	cmn	x6, x28
	mul	x28, x25, x14
	adcs	x5, x5, x28
	mul	x28, x25, x10
	adcs	x3, x3, x28
	mul	x28, x25, x4
	adcs	x21, x21, x28
	mul	x28, x25, x0
	adcs	x20, x20, x28
	mul	x28, x25, x9
	adcs	x27, x27, x28
	umulh	x28, x25, x15
	adcs	x22, x22, xzr
	adds	x5, x5, x28
	umulh	x28, x25, x14
	adcs	x3, x3, x28
	umulh	x28, x25, x10
	adcs	x21, x21, x28
	umulh	x28, x25, x4
	adcs	x20, x20, x28
	umulh	x28, x25, x0
	adcs	x27, x27, x28
	umulh	x25, x25, x9
	mul	x28, x7, x18
	adcs	x22, x22, x25
	umulh	x25, x7, x11
	mul	x6, x7, x8
	adds	x25, x25, x28
	umulh	x28, x7, x18
	mul	x26, x7, x12
	adcs	x6, x28, x6
	umulh	x28, x7, x8
	mul	x23, x7, x17
	adcs	x26, x28, x26
	umulh	x28, x7, x12
	ldp	x19, x2, [x2, #32]
	mul	x24, x7, x16
	umulh	x29, x7, x17
	adcs	x23, x28, x23
	umulh	x30, x7, x16
	adcs	x24, x29, x24
	mul	x7, x7, x11
	adcs	x30, x30, xzr
	adds	x5, x7, x5
	mov	x13, x10
	umulh	x10, x19, x16
	adcs	x3, x25, x3
	umulh	x29, x2, x16
	str	x10, [sp, #40]                  // 8-byte Folded Spill
	mul	x10, x19, x16
	adcs	x6, x6, x21
	str	x29, [sp, #96]                  // 8-byte Folded Spill
	mul	x29, x2, x16
	umulh	x16, x2, x17
	str	x10, [sp, #24]                  // 8-byte Folded Spill
	umulh	x10, x19, x17
	adcs	x20, x26, x20
	str	x16, [sp, #88]                  // 8-byte Folded Spill
	mul	x16, x2, x17
	str	x10, [sp, #8]                   // 8-byte Folded Spill
	mul	x21, x19, x12
	adcs	x23, x23, x27
	umulh	x10, x19, x12
	str	x16, [sp, #80]                  // 8-byte Folded Spill
	umulh	x16, x2, x12
	mul	x12, x2, x12
	mul	x26, x19, x8
	mul	x27, x1, x5
	adcs	x22, x24, x22
	umulh	x7, x19, x8
	stp	x12, x16, [sp, #64]             // 16-byte Folded Spill
	umulh	x12, x2, x8
	mul	x8, x2, x8
	mul	x24, x27, x15
	adcs	x30, x30, xzr
	stp	x8, x12, [sp, #48]              // 16-byte Folded Spill
	umulh	x8, x2, x18
	mul	x25, x19, x17
	cmn	x5, x24
	str	x8, [sp, #32]                   // 8-byte Folded Spill
	mul	x16, x2, x18
	umulh	x17, x2, x11
	mul	x8, x2, x11
	mul	x2, x27, x14
	adcs	x2, x3, x2
	mul	x3, x27, x13
	adcs	x3, x6, x3
	mul	x6, x27, x4
	adcs	x6, x20, x6
	mul	x20, x27, x0
	adcs	x20, x23, x20
	mul	x23, x27, x9
	adcs	x22, x22, x23
	adcs	x23, x30, xzr
	umulh	x30, x27, x15
	adds	x2, x2, x30
	umulh	x30, x27, x14
	adcs	x3, x3, x30
	umulh	x30, x27, x13
	adcs	x6, x6, x30
	umulh	x30, x27, x4
	adcs	x20, x20, x30
	umulh	x30, x27, x0
	adcs	x22, x22, x30
	umulh	x27, x27, x9
	mul	x5, x19, x18
	umulh	x24, x19, x11
	adcs	x23, x23, x27
	mov	x28, x1
	umulh	x1, x19, x18
	adds	x5, x24, x5
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldr	x18, [sp, #8]                   // 8-byte Folded Reload
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	adcs	x8, x1, x26
	mov	x30, x9
	adcs	x9, x7, x21
	adcs	x10, x10, x25
	adcs	x7, x18, x12
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	mul	x19, x19, x11
	mov	x24, x28
	mov	x26, x4
	adcs	x21, x12, xzr
	adds	x2, x19, x2
	adcs	x3, x5, x3
	adcs	x8, x8, x6
	adcs	x9, x9, x20
	adcs	x10, x10, x22
	mul	x5, x28, x2
	adcs	x7, x7, x23
	mul	x19, x5, x15
	adcs	x20, x21, xzr
	cmn	x2, x19
	mul	x19, x5, x14
	adcs	x3, x3, x19
	mul	x19, x5, x13
	adcs	x8, x8, x19
	mul	x19, x5, x4
	mul	x2, x5, x0
	adcs	x9, x9, x19
	mul	x6, x5, x30
	adcs	x10, x10, x2
	adcs	x6, x7, x6
	umulh	x7, x5, x15
	adcs	x20, x20, xzr
	mov	x23, x13
	adds	x3, x3, x7
	umulh	x7, x5, x14
	umulh	x19, x5, x30
	umulh	x2, x5, x0
	adcs	x8, x8, x7
	umulh	x7, x5, x4
	umulh	x5, x5, x23
	adcs	x9, x9, x5
	mov	x13, x15
	mov	x28, x14
	adcs	x10, x10, x7
	ldp	x12, x15, [sp, #48]             // 16-byte Folded Reload
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	adcs	x2, x6, x2
	adcs	x5, x20, x19
	adds	x11, x17, x16
	adcs	x12, x14, x12
	ldp	x14, x16, [sp, #64]             // 16-byte Folded Reload
	mov	x27, x23
	adcs	x15, x15, x14
	ldr	x14, [sp, #80]                  // 8-byte Folded Reload
	adcs	x16, x16, x14
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	adcs	x17, x14, x29
	ldr	x14, [sp, #96]                  // 8-byte Folded Reload
	adcs	x18, x14, xzr
	ldr	x14, [sp, #16]                  // 8-byte Folded Reload
	adds	x1, x14, x3
	adcs	x8, x11, x8
	mul	x11, x24, x1
	mul	x3, x11, x0
	adcs	x9, x12, x9
	mul	x12, x11, x30
	fmov	d0, x3
	mul	x6, x11, x23
	mov	v0.d[1], x12
	mul	x4, x11, x4
	umulh	x3, x11, x23
	fmov	x23, d0
	fmov	d0, x6
	umulh	x21, x11, x0
	mov	v0.d[1], x4
	umulh	x20, x11, x30
	fmov	x24, d0
	fmov	d0, x21
	mov	v0.d[1], x20
	umulh	x22, x11, x26
	fmov	x21, d0
	fmov	d0, x3
	mul	x7, x11, x28
	mul	x19, x11, x13
	umulh	x6, x11, x28
	umulh	x11, x11, x13
	mov	v0.d[1], x22
	adcs	x10, x15, x10
	fmov	x15, d0
	fmov	d0, x11
	adcs	x11, x16, x2
	adcs	x16, x17, x5
	adcs	x18, x18, xzr
	cmn	x1, x19
	adcs	x8, x8, x7
	adcs	x9, x9, x24
	adcs	x10, x10, x4
	adcs	x11, x11, x23
	mov	v0.d[1], x6
	adcs	x12, x16, x12
	fmov	x17, d0
	adcs	x16, x18, xzr
	adds	x8, x8, x17
	adcs	x9, x9, x6
	adcs	x10, x10, x15
	adcs	x11, x11, x22
	adcs	x12, x12, x21
	adcs	x15, x16, x20
	subs	x13, x8, x13
	sbcs	x14, x9, x28
	sbcs	x16, x10, x27
	sbcs	x17, x11, x26
	sbcs	x18, x12, x0
	sbcs	x0, x15, x30
	asr	x1, x0, #63
	cmp	x1, #0                          // =0
	csel	x8, x13, x8, ge
	ldr	x13, [sp, #104]                 // 8-byte Folded Reload
	ldp	x20, x19, [sp, #192]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #176]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #160]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #144]            // 16-byte Folded Reload
	ldp	x28, x27, [sp, #128]            // 16-byte Folded Reload
	ldp	x29, x30, [sp, #112]            // 16-byte Folded Reload
	csel	x15, x0, x15, ge
	csel	x12, x18, x12, ge
	csel	x11, x17, x11, ge
	csel	x10, x16, x10, ge
	csel	x9, x14, x9, ge
	stp	x12, x15, [x13, #32]
	stp	x10, x11, [x13, #16]
	stp	x8, x9, [x13]
	add	sp, sp, #208                    // =208
	ret
.Lfunc_end37:
	.size	mcl_fp_montNF6L, .Lfunc_end37-mcl_fp_montNF6L
                                        // -- End function
	.globl	mcl_fp_montRed6L                // -- Begin function mcl_fp_montRed6L
	.p2align	2
	.type	mcl_fp_montRed6L,@function
mcl_fp_montRed6L:                       // @mcl_fp_montRed6L
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	ldp	x14, x13, [x2, #-8]
	ldp	x3, x4, [x1]
	ldr	x12, [x2, #8]
	ldp	x11, x10, [x2, #16]
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x9, x8, [x2, #32]
	mul	x20, x3, x14
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	mul	x28, x20, x12
	umulh	x29, x20, x13
	mul	x27, x20, x11
	adds	x28, x29, x28
	umulh	x29, x20, x12
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	mul	x26, x20, x10
	adcs	x27, x29, x27
	umulh	x29, x20, x11
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	mul	x24, x20, x9
	umulh	x25, x20, x10
	adcs	x26, x29, x26
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	mul	x22, x20, x8
	umulh	x23, x20, x9
	adcs	x24, x25, x24
	ldp	x2, x18, [x1, #16]
	umulh	x21, x20, x8
	adcs	x22, x23, x22
	mul	x20, x20, x13
	adcs	x21, x21, xzr
	ldp	x16, x15, [x1, #32]
	cmn	x20, x3
	adcs	x3, x28, x4
	ldp	x17, x5, [x1, #48]
	adcs	x2, x27, x2
	adcs	x18, x26, x18
	adcs	x16, x24, x16
	adcs	x15, x22, x15
	mul	x4, x14, x3
	adcs	x17, x21, x17
	umulh	x24, x4, x13
	mul	x22, x4, x12
	adcs	x21, xzr, xzr
	umulh	x29, x4, x12
	adds	x22, x22, x24
	mul	x24, x4, x11
	umulh	x28, x4, x11
	adcs	x24, x24, x29
	mul	x29, x4, x10
	umulh	x26, x4, x10
	mul	x27, x4, x9
	adcs	x28, x29, x28
	umulh	x23, x4, x9
	mul	x25, x4, x8
	adcs	x26, x27, x26
	umulh	x20, x4, x8
	adcs	x23, x25, x23
	mul	x4, x4, x13
	adcs	x20, x21, x20
	cmn	x4, x3
	adcs	x2, x22, x2
	adcs	x18, x24, x18
	adcs	x16, x28, x16
	adcs	x15, x26, x15
	adcs	x17, x23, x17
	mul	x3, x14, x2
	adcs	x5, x20, x5
	umulh	x26, x3, x13
	mul	x23, x3, x12
	adcs	x20, xzr, xzr
	umulh	x29, x3, x12
	adds	x23, x23, x26
	mul	x26, x3, x11
	umulh	x27, x3, x11
	mul	x28, x3, x10
	adcs	x26, x26, x29
	umulh	x24, x3, x10
	mul	x25, x3, x9
	adcs	x27, x28, x27
	umulh	x21, x3, x9
	mul	x22, x3, x8
	adcs	x24, x25, x24
	umulh	x4, x3, x8
	adcs	x21, x22, x21
	mul	x3, x3, x13
	adcs	x4, x20, x4
	cmn	x3, x2
	adcs	x18, x23, x18
	ldp	x6, x7, [x1, #64]
	adcs	x16, x26, x16
	adcs	x15, x27, x15
	adcs	x17, x24, x17
	adcs	x5, x21, x5
	mul	x2, x14, x18
	adcs	x4, x4, x6
	umulh	x24, x2, x13
	mul	x21, x2, x12
	adcs	x6, xzr, xzr
	umulh	x28, x2, x12
	mul	x29, x2, x11
	adds	x21, x21, x24
	umulh	x26, x2, x11
	mul	x27, x2, x10
	adcs	x24, x29, x28
	umulh	x23, x2, x10
	mul	x25, x2, x9
	adcs	x26, x27, x26
	umulh	x20, x2, x9
	mul	x22, x2, x8
	adcs	x23, x25, x23
	umulh	x3, x2, x8
	adcs	x20, x22, x20
	mul	x2, x2, x13
	adcs	x3, x6, x3
	cmn	x2, x18
	adcs	x16, x21, x16
	adcs	x15, x24, x15
	adcs	x17, x26, x17
	adcs	x5, x23, x5
	adcs	x4, x20, x4
	mul	x18, x14, x16
	adcs	x3, x3, x7
	umulh	x29, x18, x13
	mul	x23, x18, x12
	adcs	x7, xzr, xzr
	umulh	x27, x18, x12
	mul	x28, x18, x11
	adds	x20, x23, x29
	umulh	x25, x18, x11
	mul	x26, x18, x10
	adcs	x23, x28, x27
	umulh	x22, x18, x10
	mul	x24, x18, x9
	adcs	x25, x26, x25
	umulh	x6, x18, x9
	mul	x21, x18, x8
	adcs	x22, x24, x22
	umulh	x2, x18, x8
	adcs	x6, x21, x6
	mul	x18, x18, x13
	adcs	x2, x7, x2
	cmn	x18, x16
	adcs	x15, x20, x15
	mul	x14, x14, x15
	umulh	x18, x14, x9
	adcs	x16, x23, x17
	umulh	x17, x14, x8
	fmov	d0, x18
	mul	x20, x14, x9
	mov	v0.d[1], x17
	mul	x7, x14, x8
	fmov	x28, d0
	fmov	d0, x20
	umulh	x23, x14, x11
	mov	v0.d[1], x7
	umulh	x21, x14, x10
	fmov	x20, d0
	fmov	d0, x23
	mul	x26, x14, x11
	mov	v0.d[1], x21
	ldp	x19, x1, [x1, #80]
	mul	x24, x14, x10
	adcs	x5, x25, x5
	fmov	x25, d0
	fmov	d0, x26
	umulh	x18, x14, x13
	mov	v0.d[1], x24
	fmov	x26, d0
	fmov	d0, x18
	adcs	x18, x22, x4
	umulh	x27, x14, x12
	adcs	x3, x6, x3
	mov	v0.d[1], x27
	adcs	x2, x2, x19
	mul	x23, x14, x12
	fmov	x4, d0
	adcs	x6, xzr, xzr
	adds	x4, x23, x4
	adcs	x19, x26, x27
	adcs	x22, x24, x25
	adcs	x20, x20, x21
	adcs	x7, x7, x28
	mul	x14, x14, x13
	adcs	x17, x6, x17
	cmn	x14, x15
	adcs	x14, x4, x16
	adcs	x15, x19, x5
	adcs	x16, x22, x18
	adcs	x18, x20, x3
	adcs	x2, x7, x2
	adcs	x17, x17, x1
	adcs	x1, xzr, xzr
	subs	x13, x14, x13
	sbcs	x12, x15, x12
	sbcs	x11, x16, x11
	sbcs	x10, x18, x10
	sbcs	x9, x2, x9
	sbcs	x8, x17, x8
	sbcs	x1, x1, xzr
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	tst	x1, #0x1
	csel	x8, x8, x17, eq
	csel	x9, x9, x2, eq
	csel	x10, x10, x18, eq
	csel	x11, x11, x16, eq
	csel	x12, x12, x15, eq
	csel	x13, x13, x14, eq
	stp	x9, x8, [x0, #32]
	stp	x11, x10, [x0, #16]
	stp	x13, x12, [x0]
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end38:
	.size	mcl_fp_montRed6L, .Lfunc_end38-mcl_fp_montRed6L
                                        // -- End function
	.globl	mcl_fp_montRedNF6L              // -- Begin function mcl_fp_montRedNF6L
	.p2align	2
	.type	mcl_fp_montRedNF6L,@function
mcl_fp_montRedNF6L:                     // @mcl_fp_montRedNF6L
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	ldp	x14, x13, [x2, #-8]
	ldp	x3, x4, [x1]
	ldr	x12, [x2, #8]
	ldp	x11, x10, [x2, #16]
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x9, x8, [x2, #32]
	mul	x20, x3, x14
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	mul	x28, x20, x12
	umulh	x29, x20, x13
	mul	x27, x20, x11
	adds	x28, x29, x28
	umulh	x29, x20, x12
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	mul	x26, x20, x10
	adcs	x27, x29, x27
	umulh	x29, x20, x11
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	mul	x24, x20, x9
	umulh	x25, x20, x10
	adcs	x26, x29, x26
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	mul	x22, x20, x8
	umulh	x23, x20, x9
	adcs	x24, x25, x24
	ldp	x2, x18, [x1, #16]
	umulh	x21, x20, x8
	adcs	x22, x23, x22
	mul	x20, x20, x13
	adcs	x21, x21, xzr
	ldp	x16, x15, [x1, #32]
	cmn	x20, x3
	adcs	x3, x28, x4
	ldp	x17, x5, [x1, #48]
	adcs	x2, x27, x2
	adcs	x18, x26, x18
	adcs	x16, x24, x16
	adcs	x15, x22, x15
	mul	x4, x14, x3
	adcs	x17, x21, x17
	umulh	x24, x4, x13
	mul	x22, x4, x12
	adcs	x21, xzr, xzr
	umulh	x29, x4, x12
	adds	x22, x22, x24
	mul	x24, x4, x11
	umulh	x28, x4, x11
	adcs	x24, x24, x29
	mul	x29, x4, x10
	umulh	x26, x4, x10
	mul	x27, x4, x9
	adcs	x28, x29, x28
	umulh	x23, x4, x9
	mul	x25, x4, x8
	adcs	x26, x27, x26
	umulh	x20, x4, x8
	adcs	x23, x25, x23
	mul	x4, x4, x13
	adcs	x20, x21, x20
	cmn	x4, x3
	adcs	x2, x22, x2
	adcs	x18, x24, x18
	adcs	x16, x28, x16
	adcs	x15, x26, x15
	adcs	x17, x23, x17
	mul	x3, x14, x2
	adcs	x5, x20, x5
	umulh	x26, x3, x13
	mul	x23, x3, x12
	adcs	x20, xzr, xzr
	umulh	x29, x3, x12
	adds	x23, x23, x26
	mul	x26, x3, x11
	umulh	x27, x3, x11
	mul	x28, x3, x10
	adcs	x26, x26, x29
	umulh	x24, x3, x10
	mul	x25, x3, x9
	adcs	x27, x28, x27
	umulh	x21, x3, x9
	mul	x22, x3, x8
	adcs	x24, x25, x24
	umulh	x4, x3, x8
	adcs	x21, x22, x21
	mul	x3, x3, x13
	adcs	x4, x20, x4
	cmn	x3, x2
	adcs	x18, x23, x18
	ldp	x6, x19, [x1, #64]
	adcs	x16, x26, x16
	adcs	x15, x27, x15
	adcs	x17, x24, x17
	adcs	x5, x21, x5
	mul	x2, x14, x18
	adcs	x4, x4, x6
	umulh	x24, x2, x13
	mul	x21, x2, x12
	adcs	x6, xzr, xzr
	umulh	x28, x2, x12
	mul	x29, x2, x11
	adds	x21, x21, x24
	umulh	x26, x2, x11
	mul	x27, x2, x10
	adcs	x24, x29, x28
	umulh	x23, x2, x10
	mul	x25, x2, x9
	adcs	x26, x27, x26
	umulh	x20, x2, x9
	mul	x22, x2, x8
	adcs	x23, x25, x23
	umulh	x3, x2, x8
	adcs	x20, x22, x20
	mul	x2, x2, x13
	adcs	x3, x6, x3
	cmn	x2, x18
	adcs	x16, x21, x16
	mul	x18, x14, x16
	umulh	x6, x18, x9
	umulh	x2, x18, x8
	fmov	d0, x6
	mul	x22, x18, x9
	mov	v0.d[1], x2
	mul	x21, x18, x8
	fmov	x27, d0
	fmov	d0, x22
	umulh	x25, x18, x11
	mov	v0.d[1], x21
	adcs	x15, x24, x15
	umulh	x24, x18, x10
	fmov	x28, d0
	fmov	d0, x25
	mul	x22, x18, x11
	mov	v0.d[1], x24
	mul	x6, x18, x10
	fmov	x29, d0
	fmov	d0, x22
	adcs	x17, x26, x17
	umulh	x22, x18, x13
	mov	v0.d[1], x6
	adcs	x5, x23, x5
	umulh	x25, x18, x12
	fmov	x26, d0
	fmov	d0, x22
	adcs	x4, x20, x4
	mov	v0.d[1], x25
	adcs	x3, x3, x19
	mul	x22, x18, x12
	fmov	x20, d0
	adcs	x19, xzr, xzr
	adds	x20, x22, x20
	adcs	x22, x26, x25
	adcs	x6, x6, x29
	adcs	x23, x28, x24
	adcs	x21, x21, x27
	mul	x18, x18, x13
	adcs	x2, x19, x2
	cmn	x18, x16
	adcs	x15, x20, x15
	adcs	x16, x22, x17
	mul	x14, x14, x15
	adcs	x17, x6, x5
	umulh	x5, x14, x9
	umulh	x18, x14, x8
	fmov	d0, x5
	mul	x19, x14, x9
	mov	v0.d[1], x18
	mul	x6, x14, x8
	fmov	x27, d0
	fmov	d0, x19
	umulh	x22, x14, x11
	mov	v0.d[1], x6
	umulh	x20, x14, x10
	fmov	x28, d0
	fmov	d0, x22
	ldp	x7, x1, [x1, #80]
	mul	x25, x14, x11
	mov	v0.d[1], x20
	mul	x24, x14, x10
	fmov	x22, d0
	fmov	d0, x25
	umulh	x5, x14, x13
	mov	v0.d[1], x24
	adcs	x4, x23, x4
	umulh	x26, x14, x12
	fmov	x23, d0
	fmov	d0, x5
	adcs	x3, x21, x3
	mov	v0.d[1], x26
	adcs	x2, x2, x7
	mul	x19, x14, x12
	fmov	x5, d0
	adcs	x7, xzr, xzr
	adds	x5, x19, x5
	adcs	x19, x23, x26
	adcs	x21, x24, x22
	adcs	x20, x28, x20
	adcs	x6, x6, x27
	mul	x14, x14, x13
	adcs	x18, x7, x18
	cmn	x14, x15
	adcs	x14, x5, x16
	adcs	x15, x19, x17
	adcs	x16, x21, x4
	adcs	x17, x20, x3
	adcs	x2, x6, x2
	adcs	x18, x18, x1
	subs	x13, x14, x13
	sbcs	x12, x15, x12
	sbcs	x11, x16, x11
	sbcs	x10, x17, x10
	sbcs	x9, x2, x9
	sbcs	x8, x18, x8
	asr	x1, x8, #63
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	cmp	x1, #0                          // =0
	csel	x8, x8, x18, ge
	csel	x9, x9, x2, ge
	csel	x10, x10, x17, ge
	csel	x11, x11, x16, ge
	csel	x12, x12, x15, ge
	csel	x13, x13, x14, ge
	stp	x9, x8, [x0, #32]
	stp	x11, x10, [x0, #16]
	stp	x13, x12, [x0]
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end39:
	.size	mcl_fp_montRedNF6L, .Lfunc_end39-mcl_fp_montRedNF6L
                                        // -- End function
	.globl	mcl_fp_addPre6L                 // -- Begin function mcl_fp_addPre6L
	.p2align	2
	.type	mcl_fp_addPre6L,@function
mcl_fp_addPre6L:                        // @mcl_fp_addPre6L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	adds	x8, x8, x9
	fmov	d0, x8
	ldp	x8, x12, [x2, #16]
	adcs	x10, x11, x10
	ldp	x9, x11, [x1, #16]
	mov	v0.d[1], x10
	adcs	x8, x9, x8
	fmov	d1, x8
	adcs	x9, x11, x12
	mov	v1.d[1], x9
	ldp	x10, x9, [x2, #32]
	ldp	x8, x11, [x1, #32]
	stp	q0, q1, [x0]
	adcs	x8, x8, x10
	fmov	d0, x8
	adcs	x8, x11, x9
	mov	v0.d[1], x8
	adcs	x8, xzr, xzr
	str	q0, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end40:
	.size	mcl_fp_addPre6L, .Lfunc_end40-mcl_fp_addPre6L
                                        // -- End function
	.globl	mcl_fp_subPre6L                 // -- Begin function mcl_fp_subPre6L
	.p2align	2
	.type	mcl_fp_subPre6L,@function
mcl_fp_subPre6L:                        // @mcl_fp_subPre6L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	subs	x8, x8, x9
	fmov	d0, x8
	ldp	x8, x12, [x2, #16]
	sbcs	x10, x11, x10
	ldp	x9, x11, [x1, #16]
	mov	v0.d[1], x10
	sbcs	x8, x9, x8
	fmov	d1, x8
	sbcs	x9, x11, x12
	mov	v1.d[1], x9
	ldp	x10, x9, [x2, #32]
	ldp	x8, x11, [x1, #32]
	stp	q0, q1, [x0]
	sbcs	x8, x8, x10
	fmov	d0, x8
	sbcs	x8, x11, x9
	mov	v0.d[1], x8
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	q0, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end41:
	.size	mcl_fp_subPre6L, .Lfunc_end41-mcl_fp_subPre6L
                                        // -- End function
	.globl	mcl_fp_shr1_6L                  // -- Begin function mcl_fp_shr1_6L
	.p2align	2
	.type	mcl_fp_shr1_6L,@function
mcl_fp_shr1_6L:                         // @mcl_fp_shr1_6L
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x1, #16]
	ldp	x13, x12, [x1, #32]
	extr	x9, x8, x9, #1
	extr	x8, x11, x8, #1
	extr	x11, x10, x11, #1
	extr	x10, x13, x10, #1
	extr	x13, x12, x13, #1
	lsr	x12, x12, #1
	stp	x13, x12, [x0, #32]
	stp	x11, x10, [x0, #16]
	stp	x9, x8, [x0]
	ret
.Lfunc_end42:
	.size	mcl_fp_shr1_6L, .Lfunc_end42-mcl_fp_shr1_6L
                                        // -- End function
	.globl	mcl_fp_add6L                    // -- Begin function mcl_fp_add6L
	.p2align	2
	.type	mcl_fp_add6L,@function
mcl_fp_add6L:                           // @mcl_fp_add6L
// %bb.0:
	ldp	x8, x9, [x2]
	ldp	x10, x11, [x1]
	ldp	x12, x13, [x2, #16]
	ldp	x14, x15, [x1, #16]
	ldp	x16, x17, [x2, #32]
	adds	x8, x10, x8
	ldp	x10, x18, [x1, #32]
	adcs	x9, x11, x9
	adcs	x11, x14, x12
	fmov	d1, x11
	ldp	x12, x11, [x3]
	adcs	x15, x15, x13
	fmov	d0, x8
	adcs	x10, x10, x16
	ldp	x2, x14, [x3, #16]
	mov	v0.d[1], x9
	adcs	x16, x18, x17
	fmov	x13, d0
	adcs	x17, xzr, xzr
	ldp	x1, x8, [x3, #32]
	mov	v1.d[1], x15
	subs	x13, x13, x12
	stp	q0, q1, [x0]
	fmov	d0, x10
	fmov	x10, d1
	sbcs	x12, x9, x11
	mov	v0.d[1], x16
	sbcs	x11, x10, x2
	fmov	x18, d0
	sbcs	x10, x15, x14
	sbcs	x9, x18, x1
	sbcs	x8, x16, x8
	sbcs	x14, x17, xzr
	str	q0, [x0, #32]
	tbnz	w14, #0, .LBB43_2
// %bb.1:                               // %nocarry
	stp	x13, x12, [x0]
	stp	x11, x10, [x0, #16]
	stp	x9, x8, [x0, #32]
.LBB43_2:                               // %common.ret
	ret
.Lfunc_end43:
	.size	mcl_fp_add6L, .Lfunc_end43-mcl_fp_add6L
                                        // -- End function
	.globl	mcl_fp_addNF6L                  // -- Begin function mcl_fp_addNF6L
	.p2align	2
	.type	mcl_fp_addNF6L,@function
mcl_fp_addNF6L:                         // @mcl_fp_addNF6L
// %bb.0:
	ldp	x13, x12, [x1]
	ldp	x15, x14, [x2]
	ldp	x9, x8, [x1, #32]
	ldp	x17, x16, [x1, #16]
	ldp	x1, x18, [x2, #16]
	adds	x13, x15, x13
	ldp	x11, x10, [x2, #32]
	adcs	x12, x14, x12
	adcs	x17, x1, x17
	fmov	d0, x17
	ldp	x2, x17, [x3]
	adcs	x16, x18, x16
	ldp	x1, x18, [x3, #16]
	adcs	x9, x11, x9
	mov	v0.d[1], x16
	adcs	x8, x10, x8
	ldp	x15, x14, [x3, #32]
	fmov	x10, d0
	fmov	d0, x9
	subs	x9, x13, x2
	sbcs	x17, x12, x17
	mov	v0.d[1], x8
	sbcs	x1, x10, x1
	fmov	x11, d0
	sbcs	x18, x16, x18
	sbcs	x15, x11, x15
	sbcs	x14, x8, x14
	asr	x2, x14, #63
	cmp	x2, #0                          // =0
	csel	x8, x14, x8, ge
	csel	x11, x15, x11, ge
	csel	x14, x18, x16, ge
	csel	x10, x1, x10, ge
	csel	x12, x17, x12, ge
	csel	x9, x9, x13, ge
	stp	x11, x8, [x0, #32]
	stp	x10, x14, [x0, #16]
	stp	x9, x12, [x0]
	ret
.Lfunc_end44:
	.size	mcl_fp_addNF6L, .Lfunc_end44-mcl_fp_addNF6L
                                        // -- End function
	.globl	mcl_fp_sub6L                    // -- Begin function mcl_fp_sub6L
	.p2align	2
	.type	mcl_fp_sub6L,@function
mcl_fp_sub6L:                           // @mcl_fp_sub6L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	ldp	x13, x14, [x2, #16]
	subs	x8, x8, x9
	sbcs	x9, x11, x10
	ldp	x12, x10, [x1, #16]
	fmov	d0, x8
	mov	v0.d[1], x9
	sbcs	x11, x12, x13
	fmov	d1, x11
	ldp	x11, x12, [x2, #32]
	sbcs	x8, x10, x14
	ldp	x10, x13, [x1, #32]
	mov	v1.d[1], x8
	stp	q0, q1, [x0]
	sbcs	x10, x10, x11
	fmov	d2, x10
	sbcs	x10, x13, x12
	mov	v2.d[1], x10
	ngcs	x11, xzr
	str	q2, [x0, #32]
	tbz	w11, #0, .LBB45_2
// %bb.1:                               // %carry
	ldp	x11, x12, [x3]
	fmov	x13, d0
	fmov	x14, d1
	fmov	x15, d2
	adds	x11, x11, x13
	adcs	x9, x12, x9
	ldp	x12, x13, [x3, #16]
	stp	x11, x9, [x0]
	ldp	x9, x11, [x3, #32]
	adcs	x12, x12, x14
	adcs	x8, x13, x8
	stp	x12, x8, [x0, #16]
	adcs	x8, x9, x15
	adcs	x9, x11, x10
	stp	x8, x9, [x0, #32]
.LBB45_2:                               // %common.ret
	ret
.Lfunc_end45:
	.size	mcl_fp_sub6L, .Lfunc_end45-mcl_fp_sub6L
                                        // -- End function
	.globl	mcl_fp_subNF6L                  // -- Begin function mcl_fp_subNF6L
	.p2align	2
	.type	mcl_fp_subNF6L,@function
mcl_fp_subNF6L:                         // @mcl_fp_subNF6L
// %bb.0:
	ldp	x13, x12, [x2]
	ldp	x15, x14, [x1]
	ldp	x11, x10, [x1, #32]
	ldp	x17, x16, [x2, #16]
	ldp	x1, x18, [x1, #16]
	ldp	x9, x8, [x2, #32]
	subs	x13, x15, x13
	sbcs	x12, x14, x12
	sbcs	x17, x1, x17
	sbcs	x16, x18, x16
	fmov	d0, x17
	ldp	x17, x2, [x3]
	sbcs	x9, x11, x9
	mov	v0.d[1], x16
	sbcs	x8, x10, x8
	ldp	x1, x18, [x3, #16]
	fmov	x10, d0
	fmov	d0, x9
	asr	x9, x8, #63
	extr	x11, x9, x8, #63
	ldp	x15, x14, [x3, #32]
	and	x11, x11, x17
	and	x2, x9, x2
	adds	x11, x11, x13
	and	x1, x9, x1
	adcs	x12, x2, x12
	mov	v0.d[1], x8
	and	x18, x9, x18
	adcs	x10, x1, x10
	and	x15, x9, x15
	and	x9, x9, x14
	fmov	x14, d0
	stp	x11, x12, [x0]
	adcs	x11, x18, x16
	stp	x10, x11, [x0, #16]
	adcs	x10, x15, x14
	adcs	x8, x9, x8
	stp	x10, x8, [x0, #32]
	ret
.Lfunc_end46:
	.size	mcl_fp_subNF6L, .Lfunc_end46-mcl_fp_subNF6L
                                        // -- End function
	.globl	mcl_fpDbl_add6L                 // -- Begin function mcl_fpDbl_add6L
	.p2align	2
	.type	mcl_fpDbl_add6L,@function
mcl_fpDbl_add6L:                        // @mcl_fpDbl_add6L
// %bb.0:
	str	x21, [sp, #-32]!                // 8-byte Folded Spill
	ldp	x9, x10, [x2]
	ldp	x11, x12, [x1]
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	ldp	x13, x8, [x2, #80]
	ldp	x15, x14, [x1, #80]
	adds	x9, x11, x9
	ldp	x20, x11, [x2, #16]
	fmov	d0, x9
	ldp	x21, x9, [x1, #16]
	adcs	x10, x12, x10
	ldp	x17, x16, [x2, #64]
	ldp	x4, x18, [x1, #64]
	ldp	x6, x5, [x2, #48]
	ldp	x19, x7, [x1, #48]
	ldp	x2, x12, [x2, #32]
	adcs	x20, x21, x20
	ldp	x1, x21, [x1, #32]
	fmov	d1, x20
	adcs	x9, x9, x11
	mov	v0.d[1], x10
	mov	v1.d[1], x9
	adcs	x1, x1, x2
	stp	q0, q1, [x0]
	fmov	d0, x1
	adcs	x12, x21, x12
	mov	v0.d[1], x12
	adcs	x12, x19, x6
	adcs	x1, x7, x5
	str	q0, [x0, #32]
	fmov	d0, x12
	adcs	x12, x4, x17
	mov	v0.d[1], x1
	adcs	x16, x18, x16
	fmov	x17, d0
	fmov	d0, x12
	adcs	x12, x15, x13
	ldp	x15, x13, [x3]
	ldp	x11, x9, [x3, #16]
	mov	v0.d[1], x16
	adcs	x8, x14, x8
	fmov	x18, d0
	fmov	d0, x12
	adcs	x12, xzr, xzr
	ldp	x20, x10, [x3, #32]
	subs	x15, x17, x15
	sbcs	x13, x1, x13
	mov	v0.d[1], x8
	sbcs	x11, x18, x11
	fmov	x14, d0
	sbcs	x9, x16, x9
	sbcs	x2, x14, x20
	sbcs	x10, x8, x10
	sbcs	x12, x12, xzr
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	tst	x12, #0x1
	csel	x8, x10, x8, eq
	csel	x10, x2, x14, eq
	csel	x9, x9, x16, eq
	csel	x11, x11, x18, eq
	csel	x12, x13, x1, eq
	csel	x13, x15, x17, eq
	stp	x10, x8, [x0, #80]
	stp	x11, x9, [x0, #64]
	stp	x13, x12, [x0, #48]
	ldr	x21, [sp], #32                  // 8-byte Folded Reload
	ret
.Lfunc_end47:
	.size	mcl_fpDbl_add6L, .Lfunc_end47-mcl_fpDbl_add6L
                                        // -- End function
	.globl	mcl_fpDbl_sub6L                 // -- Begin function mcl_fpDbl_sub6L
	.p2align	2
	.type	mcl_fpDbl_sub6L,@function
mcl_fpDbl_sub6L:                        // @mcl_fpDbl_sub6L
// %bb.0:
	str	x21, [sp, #-32]!                // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	ldp	x5, x6, [x2]
	ldp	x7, x19, [x1]
	ldp	x10, x8, [x2, #80]
	ldp	x11, x9, [x1, #80]
	ldp	x14, x12, [x2, #64]
	subs	x5, x7, x5
	ldp	x20, x7, [x2, #16]
	fmov	d0, x5
	ldp	x21, x5, [x1, #16]
	sbcs	x6, x19, x6
	ldp	x15, x13, [x1, #64]
	ldp	x18, x16, [x2, #48]
	ldp	x4, x17, [x1, #48]
	ldp	x2, x19, [x2, #32]
	sbcs	x20, x21, x20
	ldp	x1, x21, [x1, #32]
	fmov	d1, x20
	sbcs	x5, x5, x7
	mov	v0.d[1], x6
	mov	v1.d[1], x5
	sbcs	x1, x1, x2
	stp	q0, q1, [x0]
	fmov	d0, x1
	sbcs	x1, x21, x19
	sbcs	x18, x4, x18
	mov	v0.d[1], x1
	sbcs	x16, x17, x16
	str	q0, [x0, #32]
	fmov	d0, x18
	sbcs	x14, x15, x14
	mov	v0.d[1], x16
	sbcs	x12, x13, x12
	ldp	x6, x20, [x3]
	fmov	x15, d0
	fmov	d0, x14
	sbcs	x10, x11, x10
	mov	v0.d[1], x12
	sbcs	x8, x9, x8
	ldp	x5, x7, [x3, #16]
	fmov	x9, d0
	fmov	d0, x10
	ngcs	x10, xzr
	sbfx	x10, x10, #0, #1
	ldp	x2, x3, [x3, #32]
	and	x13, x10, x6
	and	x14, x10, x20
	adds	x13, x13, x15
	and	x17, x10, x5
	adcs	x14, x14, x16
	mov	v0.d[1], x8
	and	x18, x10, x7
	adcs	x9, x17, x9
	fmov	x11, d0
	and	x1, x10, x2
	adcs	x12, x18, x12
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	and	x10, x10, x3
	stp	x9, x12, [x0, #64]
	adcs	x9, x1, x11
	adcs	x8, x10, x8
	stp	x13, x14, [x0, #48]
	stp	x9, x8, [x0, #80]
	ldr	x21, [sp], #32                  // 8-byte Folded Reload
	ret
.Lfunc_end48:
	.size	mcl_fpDbl_sub6L, .Lfunc_end48-mcl_fpDbl_sub6L
                                        // -- End function
	.globl	mulPv512x64                     // -- Begin function mulPv512x64
	.p2align	2
	.type	mulPv512x64,@function
mulPv512x64:                            // @mulPv512x64
// %bb.0:
	ldr	x9, [x0]
	mul	x10, x9, x1
	str	x10, [x8]
	ldr	x10, [x0, #8]
	umulh	x9, x9, x1
	mul	x11, x10, x1
	adds	x9, x9, x11
	str	x9, [x8, #8]
	ldr	x9, [x0, #16]
	umulh	x10, x10, x1
	mul	x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #16]
	ldr	x10, [x0, #24]
	umulh	x9, x9, x1
	mul	x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #24]
	ldr	x9, [x0, #32]
	umulh	x10, x10, x1
	mul	x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #32]
	ldr	x10, [x0, #40]
	umulh	x9, x9, x1
	mul	x11, x10, x1
	adcs	x9, x9, x11
	str	x9, [x8, #40]
	ldr	x9, [x0, #48]
	umulh	x10, x10, x1
	mul	x11, x9, x1
	adcs	x10, x10, x11
	str	x10, [x8, #48]
	ldr	x10, [x0, #56]
	umulh	x9, x9, x1
	mul	x11, x10, x1
	umulh	x10, x10, x1
	adcs	x9, x9, x11
	adcs	x10, x10, xzr
	stp	x9, x10, [x8, #56]
	ret
.Lfunc_end49:
	.size	mulPv512x64, .Lfunc_end49-mulPv512x64
                                        // -- End function
	.globl	mcl_fp_mont8L                   // -- Begin function mcl_fp_mont8L
	.p2align	2
	.type	mcl_fp_mont8L,@function
mcl_fp_mont8L:                          // @mcl_fp_mont8L
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1424                   // =1424
	mov	x21, x1
	ldur	x19, [x3, #-8]
	ldr	x1, [x2]
	stp	x0, x21, [sp, #112]             // 16-byte Folded Spill
	add	x8, sp, #1344                   // =1344
	mov	x0, x21
	mov	x20, x3
	stp	x2, x19, [sp, #128]             // 16-byte Folded Spill
	mov	x22, x2
	bl	mulPv512x64
	ldr	x9, [sp, #1408]
	ldr	x8, [sp, #1400]
	ldr	x23, [sp, #1344]
	mov	x0, x20
	stp	x8, x9, [sp, #96]               // 16-byte Folded Spill
	ldr	x9, [sp, #1392]
	ldr	x8, [sp, #1384]
	mul	x1, x19, x23
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #1376]
	ldr	x8, [sp, #1368]
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x8, [sp, #1360]
	str	x8, [sp, #56]                   // 8-byte Folded Spill
	ldr	x8, [sp, #1352]
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1264                   // =1264
	bl	mulPv512x64
	ldr	x8, [sp, #1328]
	ldr	x1, [x22, #8]
	ldr	x24, [sp, #1320]
	ldr	x25, [sp, #1312]
	ldr	x26, [sp, #1304]
	ldr	x27, [sp, #1296]
	ldr	x28, [sp, #1288]
	ldr	x29, [sp, #1280]
	ldr	x19, [sp, #1272]
	ldr	x22, [sp, #1264]
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1184                   // =1184
	mov	x0, x21
	bl	mulPv512x64
	ldp	x9, x6, [sp, #40]               // 16-byte Folded Reload
	ldp	x12, x13, [sp, #56]             // 16-byte Folded Reload
	cmn	x22, x23
	ldp	x16, x17, [sp, #72]             // 16-byte Folded Reload
	adcs	x9, x19, x9
	adcs	x12, x29, x12
	ldp	x1, x2, [sp, #88]               // 16-byte Folded Reload
	adcs	x13, x28, x13
	adcs	x16, x27, x16
	ldr	x5, [sp, #104]                  // 8-byte Folded Reload
	adcs	x17, x26, x17
	ldr	x0, [sp, #1184]
	adcs	x1, x25, x1
	ldr	x18, [sp, #1192]
	adcs	x2, x24, x2
	ldr	x4, [sp, #1200]
	adcs	x5, x6, x5
	ldr	x3, [sp, #1208]
	adcs	x6, xzr, xzr
	ldr	x15, [sp, #1216]
	adds	x19, x9, x0
	ldr	x14, [sp, #1224]
	adcs	x9, x12, x18
	ldr	x11, [sp, #1232]
	adcs	x18, x13, x4
	ldr	x10, [sp, #1240]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #1248]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	ldr	x26, [sp, #136]                 // 8-byte Folded Reload
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x26, x19
	add	x8, sp, #1104                   // =1104
	mov	x0, x20
	bl	mulPv512x64
	ldr	x9, [sp, #1168]
	ldr	x8, [sp, #1160]
	ldp	x27, x28, [sp, #120]            // 16-byte Folded Reload
	ldr	x29, [sp, #1144]
	ldr	x24, [sp, #1136]
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	ldr	x8, [sp, #1152]
	ldr	x1, [x28, #16]
	ldr	x25, [sp, #1128]
	ldr	x22, [sp, #1120]
	ldr	x23, [sp, #1112]
	ldr	x21, [sp, #1104]
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	add	x8, sp, #1024                   // =1024
	mov	x0, x27
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	ldp	x2, x3, [sp, #16]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	adcs	x1, x1, x2
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	ldr	x6, [sp, #32]                   // 8-byte Folded Reload
	ldr	x0, [sp, #1024]
	ldr	x18, [sp, #1032]
	adcs	x2, x2, x3
	adcs	x5, x5, x6
	ldr	x6, [sp, #80]                   // 8-byte Folded Reload
	ldr	x4, [sp, #1040]
	ldr	x3, [sp, #1048]
	ldr	x15, [sp, #1056]
	adcs	x6, x6, xzr
	adds	x19, x9, x0
	ldr	x14, [sp, #1064]
	adcs	x9, x12, x18
	ldr	x11, [sp, #1072]
	adcs	x18, x13, x4
	ldr	x10, [sp, #1080]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #1088]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x26, x19
	add	x8, sp, #944                    // =944
	mov	x0, x20
	bl	mulPv512x64
	ldr	x9, [sp, #1008]
	ldr	x8, [sp, #1000]
	ldr	x1, [x28, #24]
	ldr	x28, [sp, #992]
	ldr	x29, [sp, #984]
	ldr	x24, [sp, #976]
	ldr	x25, [sp, #968]
	ldr	x22, [sp, #960]
	ldr	x23, [sp, #952]
	ldr	x21, [sp, #944]
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	add	x8, sp, #864                    // =864
	mov	x0, x27
	mov	x26, x27
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	ldp	x3, x6, [sp, #24]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	adcs	x1, x1, x28
	adcs	x2, x2, x3
	adcs	x5, x5, x6
	ldr	x6, [sp, #80]                   // 8-byte Folded Reload
	ldr	x0, [sp, #864]
	ldr	x18, [sp, #872]
	ldr	x4, [sp, #880]
	ldr	x3, [sp, #888]
	adcs	x6, x6, xzr
	ldr	x15, [sp, #896]
	adds	x19, x9, x0
	ldr	x14, [sp, #904]
	adcs	x9, x12, x18
	ldr	x11, [sp, #912]
	adcs	x18, x13, x4
	ldr	x10, [sp, #920]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #928]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	ldr	x28, [sp, #136]                 // 8-byte Folded Reload
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x28, x19
	add	x8, sp, #784                    // =784
	mov	x0, x20
	bl	mulPv512x64
	ldr	x9, [sp, #848]
	ldr	x8, [sp, #840]
	ldr	x27, [sp, #128]                 // 8-byte Folded Reload
	ldr	x29, [sp, #824]
	ldr	x24, [sp, #816]
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	ldr	x8, [sp, #832]
	ldr	x1, [x27, #32]
	ldr	x25, [sp, #808]
	ldr	x22, [sp, #800]
	ldr	x23, [sp, #792]
	ldr	x21, [sp, #784]
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	add	x8, sp, #704                    // =704
	mov	x0, x26
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	ldp	x2, x3, [sp, #16]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	adcs	x1, x1, x2
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	ldr	x6, [sp, #32]                   // 8-byte Folded Reload
	ldr	x0, [sp, #704]
	ldr	x18, [sp, #712]
	adcs	x2, x2, x3
	adcs	x5, x5, x6
	ldr	x6, [sp, #80]                   // 8-byte Folded Reload
	ldr	x4, [sp, #720]
	ldr	x3, [sp, #728]
	ldr	x15, [sp, #736]
	adcs	x6, x6, xzr
	adds	x19, x9, x0
	ldr	x14, [sp, #744]
	adcs	x9, x12, x18
	ldr	x11, [sp, #752]
	adcs	x18, x13, x4
	ldr	x10, [sp, #760]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #768]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x28, x19
	add	x8, sp, #624                    // =624
	mov	x0, x20
	bl	mulPv512x64
	ldr	x9, [sp, #688]
	ldr	x8, [sp, #680]
	ldr	x28, [sp, #120]                 // 8-byte Folded Reload
	ldr	x1, [x27, #40]
	mov	x26, x27
	ldr	x27, [sp, #672]
	ldr	x29, [sp, #664]
	ldr	x24, [sp, #656]
	ldr	x25, [sp, #648]
	ldr	x22, [sp, #640]
	ldr	x23, [sp, #632]
	ldr	x21, [sp, #624]
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	add	x8, sp, #544                    // =544
	mov	x0, x28
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	ldp	x3, x6, [sp, #24]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	adcs	x1, x1, x27
	adcs	x2, x2, x3
	adcs	x5, x5, x6
	ldr	x6, [sp, #80]                   // 8-byte Folded Reload
	ldr	x0, [sp, #544]
	ldr	x18, [sp, #552]
	ldr	x4, [sp, #560]
	ldr	x3, [sp, #568]
	adcs	x6, x6, xzr
	ldr	x15, [sp, #576]
	adds	x19, x9, x0
	ldr	x14, [sp, #584]
	adcs	x9, x12, x18
	ldr	x11, [sp, #592]
	adcs	x18, x13, x4
	ldr	x10, [sp, #600]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #608]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	ldr	x27, [sp, #136]                 // 8-byte Folded Reload
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x27, x19
	add	x8, sp, #464                    // =464
	mov	x0, x20
	bl	mulPv512x64
	ldr	x9, [sp, #528]
	ldr	x8, [sp, #520]
	ldr	x1, [x26, #48]
	ldp	x29, x26, [sp, #504]
	ldp	x25, x24, [sp, #488]
	ldp	x23, x22, [sp, #472]
	ldr	x21, [sp, #464]
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	add	x8, sp, #384                    // =384
	mov	x0, x28
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	ldp	x3, x6, [sp, #24]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	adcs	x1, x1, x26
	adcs	x2, x2, x3
	adcs	x5, x5, x6
	ldr	x6, [sp, #80]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #384]
	ldr	x4, [sp, #400]
	ldp	x3, x15, [sp, #408]
	adcs	x6, x6, xzr
	adds	x19, x9, x0
	ldp	x14, x11, [sp, #424]
	adcs	x9, x12, x18
	adcs	x18, x13, x4
	ldp	x10, x8, [sp, #440]
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x6, x8
	stp	x8, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x8, xzr, xzr
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	mul	x1, x27, x19
	add	x8, sp, #304                    // =304
	mov	x0, x20
	bl	mulPv512x64
	ldp	x0, x8, [sp, #120]              // 16-byte Folded Reload
	ldp	x28, x26, [sp, #360]
	ldp	x29, x27, [sp, #344]
	ldp	x25, x24, [sp, #328]
	ldr	x1, [x8, #56]
	ldp	x23, x22, [sp, #312]
	ldr	x21, [sp, #304]
	add	x8, sp, #224                    // =224
	bl	mulPv512x64
	ldp	x9, x13, [sp, #40]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #56]             // 16-byte Folded Reload
	cmn	x19, x21
	ldp	x16, x6, [sp, #72]              // 16-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #96]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldr	x2, [sp, #88]                   // 8-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x29
	ldp	x0, x18, [sp, #224]
	adcs	x1, x1, x27
	adcs	x2, x2, x28
	ldr	x4, [sp, #240]
	adcs	x5, x5, x26
	ldp	x3, x15, [sp, #248]
	adcs	x6, x6, xzr
	adds	x19, x9, x0
	ldp	x14, x11, [sp, #264]
	adcs	x21, x12, x18
	adcs	x22, x13, x4
	ldp	x10, x8, [sp, #280]
	adcs	x23, x16, x3
	adcs	x24, x17, x15
	adcs	x25, x1, x14
	adcs	x26, x2, x11
	adcs	x27, x5, x10
	adcs	x28, x6, x8
	ldr	x8, [sp, #136]                  // 8-byte Folded Reload
	mov	x0, x20
	adcs	x29, xzr, xzr
	mul	x1, x8, x19
	add	x8, sp, #144                    // =144
	bl	mulPv512x64
	ldp	x12, x11, [sp, #144]
	ldr	x16, [sp, #160]
	ldp	x15, x14, [sp, #168]
	ldp	x13, x10, [sp, #184]
	cmn	x19, x12
	adcs	x11, x21, x11
	adcs	x16, x22, x16
	ldp	x9, x8, [sp, #200]
	adcs	x15, x23, x15
	adcs	x14, x24, x14
	adcs	x13, x25, x13
	ldp	x4, x3, [x20]
	adcs	x10, x26, x10
	adcs	x9, x27, x9
	ldp	x2, x1, [x20, #16]
	adcs	x8, x28, x8
	adcs	x5, x29, xzr
	ldp	x0, x18, [x20, #32]
	subs	x4, x11, x4
	sbcs	x3, x16, x3
	ldp	x17, x12, [x20, #48]
	sbcs	x2, x15, x2
	sbcs	x1, x14, x1
	sbcs	x0, x13, x0
	sbcs	x18, x10, x18
	sbcs	x17, x9, x17
	sbcs	x12, x8, x12
	sbcs	x5, x5, xzr
	tst	x5, #0x1
	csel	x8, x12, x8, eq
	csel	x12, x0, x13, eq
	csel	x13, x1, x14, eq
	csel	x14, x2, x15, eq
	csel	x15, x3, x16, eq
	ldr	x16, [sp, #112]                 // 8-byte Folded Reload
	csel	x9, x17, x9, eq
	csel	x10, x18, x10, eq
	csel	x11, x4, x11, eq
	stp	x9, x8, [x16, #48]
	stp	x12, x10, [x16, #32]
	stp	x14, x13, [x16, #16]
	stp	x11, x15, [x16]
	add	sp, sp, #1424                   // =1424
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end50:
	.size	mcl_fp_mont8L, .Lfunc_end50-mcl_fp_mont8L
                                        // -- End function
	.globl	mcl_fp_montNF8L                 // -- Begin function mcl_fp_montNF8L
	.p2align	2
	.type	mcl_fp_montNF8L,@function
mcl_fp_montNF8L:                        // @mcl_fp_montNF8L
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1408                   // =1408
	mov	x21, x1
	ldur	x19, [x3, #-8]
	ldr	x1, [x2]
	stp	x0, x21, [sp, #96]              // 16-byte Folded Spill
	add	x8, sp, #1328                   // =1328
	mov	x0, x21
	mov	x20, x3
	stp	x2, x19, [sp, #112]             // 16-byte Folded Spill
	mov	x22, x2
	bl	mulPv512x64
	ldr	x9, [sp, #1392]
	ldr	x8, [sp, #1384]
	ldr	x23, [sp, #1328]
	mov	x0, x20
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #1376]
	ldr	x8, [sp, #1368]
	mul	x1, x19, x23
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x9, [sp, #1360]
	ldr	x8, [sp, #1352]
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldr	x8, [sp, #1344]
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	ldr	x8, [sp, #1336]
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	add	x8, sp, #1248                   // =1248
	bl	mulPv512x64
	ldr	x8, [sp, #1312]
	ldr	x1, [x22, #8]
	ldr	x24, [sp, #1304]
	ldr	x25, [sp, #1296]
	ldr	x26, [sp, #1288]
	ldr	x27, [sp, #1280]
	ldr	x28, [sp, #1272]
	ldr	x29, [sp, #1264]
	ldr	x19, [sp, #1256]
	ldr	x22, [sp, #1248]
	str	x8, [sp, #32]                   // 8-byte Folded Spill
	add	x8, sp, #1168                   // =1168
	mov	x0, x21
	bl	mulPv512x64
	ldp	x9, x6, [sp, #24]               // 16-byte Folded Reload
	ldp	x12, x13, [sp, #40]             // 16-byte Folded Reload
	cmn	x22, x23
	ldp	x16, x17, [sp, #56]             // 16-byte Folded Reload
	adcs	x9, x19, x9
	adcs	x12, x29, x12
	ldp	x1, x2, [sp, #72]               // 16-byte Folded Reload
	adcs	x13, x28, x13
	adcs	x16, x27, x16
	ldr	x5, [sp, #88]                   // 8-byte Folded Reload
	adcs	x17, x26, x17
	ldr	x0, [sp, #1168]
	ldr	x18, [sp, #1176]
	adcs	x1, x25, x1
	adcs	x2, x24, x2
	ldr	x4, [sp, #1184]
	ldr	x3, [sp, #1192]
	adcs	x5, x6, x5
	ldr	x15, [sp, #1200]
	adds	x19, x9, x0
	ldr	x14, [sp, #1208]
	adcs	x9, x12, x18
	ldr	x11, [sp, #1216]
	adcs	x18, x13, x4
	ldr	x10, [sp, #1224]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #1232]
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	ldr	x29, [sp, #120]                 // 8-byte Folded Reload
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x29, x19
	add	x8, sp, #1088                   // =1088
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldr	x9, [sp, #1152]
	ldr	x8, [sp, #1144]
	ldp	x28, x26, [sp, #104]            // 16-byte Folded Reload
	ldr	x27, [sp, #1128]
	ldr	x24, [sp, #1120]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	ldr	x8, [sp, #1136]
	ldr	x1, [x26, #16]
	ldr	x25, [sp, #1112]
	ldr	x22, [sp, #1104]
	ldr	x23, [sp, #1096]
	ldr	x21, [sp, #1088]
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	add	x8, sp, #1008                   // =1008
	mov	x0, x28
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #64]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	ldp	x2, x3, [sp, #8]                // 16-byte Folded Reload
	adcs	x13, x13, x25
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	adcs	x1, x1, x2
	ldr	x2, [sp, #72]                   // 8-byte Folded Reload
	ldr	x6, [sp, #24]                   // 8-byte Folded Reload
	ldr	x0, [sp, #1008]
	ldr	x18, [sp, #1016]
	adcs	x2, x2, x3
	ldr	x4, [sp, #1024]
	ldr	x3, [sp, #1032]
	adcs	x5, x5, x6
	ldr	x15, [sp, #1040]
	adds	x19, x9, x0
	ldr	x14, [sp, #1048]
	adcs	x9, x12, x18
	ldr	x11, [sp, #1056]
	adcs	x18, x13, x4
	ldr	x10, [sp, #1064]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #1072]
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x29, x19
	add	x8, sp, #928                    // =928
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldr	x9, [sp, #992]
	ldr	x8, [sp, #984]
	ldr	x1, [x26, #24]
	ldr	x26, [sp, #976]
	ldr	x27, [sp, #968]
	ldr	x24, [sp, #960]
	ldr	x25, [sp, #952]
	ldr	x22, [sp, #944]
	ldr	x23, [sp, #936]
	ldr	x21, [sp, #928]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #848                    // =848
	mov	x0, x28
	mov	x29, x28
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldp	x16, x2, [sp, #64]              // 16-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldp	x3, x6, [sp, #16]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	ldr	x0, [sp, #848]
	ldr	x18, [sp, #856]
	adcs	x1, x1, x26
	adcs	x2, x2, x3
	ldr	x4, [sp, #864]
	ldr	x3, [sp, #872]
	adcs	x5, x5, x6
	ldr	x15, [sp, #880]
	adds	x19, x9, x0
	ldr	x14, [sp, #888]
	adcs	x9, x12, x18
	ldr	x11, [sp, #896]
	adcs	x18, x13, x4
	ldr	x10, [sp, #904]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #912]
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	ldr	x26, [sp, #120]                 // 8-byte Folded Reload
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x26, x19
	add	x8, sp, #768                    // =768
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldr	x9, [sp, #832]
	ldr	x8, [sp, #824]
	ldr	x28, [sp, #112]                 // 8-byte Folded Reload
	ldr	x27, [sp, #808]
	ldr	x24, [sp, #800]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	ldr	x8, [sp, #816]
	ldr	x1, [x28, #32]
	ldr	x25, [sp, #792]
	ldr	x22, [sp, #784]
	ldr	x23, [sp, #776]
	ldr	x21, [sp, #768]
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	add	x8, sp, #688                    // =688
	mov	x0, x29
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldr	x16, [sp, #64]                  // 8-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	ldp	x2, x3, [sp, #8]                // 16-byte Folded Reload
	adcs	x13, x13, x25
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	adcs	x1, x1, x2
	ldr	x2, [sp, #72]                   // 8-byte Folded Reload
	ldr	x6, [sp, #24]                   // 8-byte Folded Reload
	ldr	x0, [sp, #688]
	ldr	x18, [sp, #696]
	adcs	x2, x2, x3
	ldr	x4, [sp, #704]
	ldr	x3, [sp, #712]
	adcs	x5, x5, x6
	ldr	x15, [sp, #720]
	adds	x19, x9, x0
	ldr	x14, [sp, #728]
	adcs	x9, x12, x18
	ldr	x11, [sp, #736]
	adcs	x18, x13, x4
	ldr	x10, [sp, #744]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #752]
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x26, x19
	add	x8, sp, #608                    // =608
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldr	x9, [sp, #672]
	ldr	x8, [sp, #664]
	ldr	x26, [sp, #104]                 // 8-byte Folded Reload
	ldr	x1, [x28, #40]
	mov	x29, x28
	ldr	x28, [sp, #656]
	ldr	x27, [sp, #648]
	ldr	x24, [sp, #640]
	ldr	x25, [sp, #632]
	ldr	x22, [sp, #624]
	ldr	x23, [sp, #616]
	ldr	x21, [sp, #608]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #528                    // =528
	mov	x0, x26
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldp	x16, x2, [sp, #64]              // 16-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldp	x3, x6, [sp, #16]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	ldr	x0, [sp, #528]
	ldr	x18, [sp, #536]
	adcs	x1, x1, x28
	adcs	x2, x2, x3
	ldr	x4, [sp, #544]
	ldr	x3, [sp, #552]
	adcs	x5, x5, x6
	ldr	x15, [sp, #560]
	adds	x19, x9, x0
	ldr	x14, [sp, #568]
	adcs	x9, x12, x18
	ldr	x11, [sp, #576]
	adcs	x18, x13, x4
	ldr	x10, [sp, #584]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	ldr	x8, [sp, #592]
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	ldr	x28, [sp, #120]                 // 8-byte Folded Reload
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x28, x19
	add	x8, sp, #448                    // =448
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldr	x1, [x29, #48]
	ldr	x9, [sp, #512]
	ldp	x29, x8, [sp, #496]
	ldp	x24, x27, [sp, #480]
	ldp	x22, x25, [sp, #464]
	ldp	x21, x23, [sp, #448]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #368                    // =368
	mov	x0, x26
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldp	x16, x2, [sp, #64]              // 16-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	ldp	x3, x6, [sp, #16]               // 16-byte Folded Reload
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	ldp	x0, x18, [sp, #368]
	adcs	x1, x1, x29
	adcs	x2, x2, x3
	ldr	x4, [sp, #384]
	ldp	x3, x15, [sp, #392]
	adcs	x5, x5, x6
	adds	x19, x9, x0
	ldp	x14, x11, [sp, #408]
	adcs	x9, x12, x18
	adcs	x18, x13, x4
	ldp	x10, x8, [sp, #424]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x9, x16, x3
	stp	x9, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x17, x15
	adcs	x9, x1, x14
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	adcs	x18, x2, x11
	adcs	x9, x5, x10
	adcs	x8, x8, xzr
	stp	x8, x18, [sp, #80]              // 16-byte Folded Spill
	mul	x1, x28, x19
	add	x8, sp, #288                    // =288
	mov	x0, x20
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	bl	mulPv512x64
	ldp	x0, x8, [sp, #104]              // 16-byte Folded Reload
	ldp	x26, x29, [sp, #344]
	ldp	x27, x28, [sp, #328]
	ldp	x25, x24, [sp, #312]
	ldr	x1, [x8, #56]
	ldp	x23, x22, [sp, #296]
	ldr	x21, [sp, #288]
	add	x8, sp, #208                    // =208
	bl	mulPv512x64
	ldp	x9, x13, [sp, #32]              // 16-byte Folded Reload
	ldp	x12, x17, [sp, #48]             // 16-byte Folded Reload
	cmn	x19, x21
	ldp	x16, x2, [sp, #64]              // 16-byte Folded Reload
	adcs	x9, x9, x23
	adcs	x12, x12, x22
	ldp	x5, x1, [sp, #80]               // 16-byte Folded Reload
	adcs	x13, x13, x25
	adcs	x16, x16, x24
	adcs	x17, x17, x27
	ldp	x0, x18, [sp, #208]
	adcs	x1, x1, x28
	adcs	x2, x2, x26
	ldr	x4, [sp, #224]
	ldp	x3, x15, [sp, #232]
	adcs	x5, x5, x29
	adds	x19, x9, x0
	ldp	x14, x11, [sp, #248]
	adcs	x21, x12, x18
	adcs	x22, x13, x4
	ldp	x10, x8, [sp, #264]
	adcs	x23, x16, x3
	adcs	x24, x17, x15
	adcs	x25, x1, x14
	adcs	x26, x2, x11
	adcs	x27, x5, x10
	adcs	x28, x8, xzr
	ldr	x8, [sp, #120]                  // 8-byte Folded Reload
	mov	x0, x20
	mul	x1, x8, x19
	add	x8, sp, #128                    // =128
	bl	mulPv512x64
	ldp	x12, x11, [sp, #128]
	ldr	x16, [sp, #144]
	ldp	x15, x14, [sp, #152]
	ldp	x13, x10, [sp, #168]
	cmn	x19, x12
	adcs	x11, x21, x11
	adcs	x16, x22, x16
	ldp	x9, x8, [sp, #184]
	adcs	x15, x23, x15
	adcs	x14, x24, x14
	adcs	x13, x25, x13
	ldp	x4, x3, [x20]
	adcs	x10, x26, x10
	ldp	x2, x1, [x20, #16]
	adcs	x9, x27, x9
	adcs	x8, x28, x8
	ldp	x0, x18, [x20, #32]
	subs	x4, x11, x4
	sbcs	x3, x16, x3
	ldp	x17, x12, [x20, #48]
	sbcs	x2, x15, x2
	sbcs	x1, x14, x1
	sbcs	x0, x13, x0
	sbcs	x18, x10, x18
	sbcs	x17, x9, x17
	sbcs	x12, x8, x12
	cmp	x12, #0                         // =0
	csel	x8, x12, x8, ge
	csel	x12, x0, x13, ge
	csel	x13, x1, x14, ge
	csel	x14, x2, x15, ge
	csel	x15, x3, x16, ge
	ldr	x16, [sp, #96]                  // 8-byte Folded Reload
	csel	x9, x17, x9, ge
	csel	x10, x18, x10, ge
	csel	x11, x4, x11, ge
	stp	x9, x8, [x16, #48]
	stp	x12, x10, [x16, #32]
	stp	x14, x13, [x16, #16]
	stp	x11, x15, [x16]
	add	sp, sp, #1408                   // =1408
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end51:
	.size	mcl_fp_montNF8L, .Lfunc_end51-mcl_fp_montNF8L
                                        // -- End function
	.globl	mcl_fp_montRed8L                // -- Begin function mcl_fp_montRed8L
	.p2align	2
	.type	mcl_fp_montRed8L,@function
mcl_fp_montRed8L:                       // @mcl_fp_montRed8L
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #736                    // =736
	ldp	x9, x8, [x2, #48]
	ldp	x29, x19, [x1]
	ldp	x24, x22, [x1, #48]
	stp	x8, x0, [sp, #80]               // 16-byte Folded Spill
	ldr	x8, [x2, #40]
	ldp	x26, x25, [x1, #32]
	ldp	x28, x27, [x1, #16]
	mov	x20, x1
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldp	x8, x9, [x2, #24]
	mov	x0, x2
	mov	x21, x2
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldp	x8, x9, [x2, #8]
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	ldp	x23, x8, [x2, #-8]
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	mul	x1, x29, x23
	add	x8, sp, #656                    // =656
	bl	mulPv512x64
	ldr	x13, [sp, #656]
	ldr	x12, [sp, #664]
	ldr	x15, [sp, #672]
	ldr	x14, [sp, #680]
	ldr	x17, [sp, #688]
	cmn	x29, x13
	ldr	x16, [sp, #696]
	adcs	x19, x19, x12
	ldr	x11, [sp, #704]
	adcs	x12, x28, x15
	ldr	x10, [sp, #712]
	adcs	x27, x27, x14
	ldr	x8, [x20, #64]
	ldr	x9, [sp, #720]
	adcs	x26, x26, x17
	adcs	x25, x25, x16
	adcs	x24, x24, x11
	adcs	x28, x22, x10
	adcs	x29, x8, x9
	mul	x1, x23, x19
	add	x8, sp, #576                    // =576
	mov	x0, x21
	str	x12, [sp, #16]                  // 8-byte Folded Spill
	adcs	x22, xzr, xzr
	bl	mulPv512x64
	ldr	x15, [sp, #576]
	ldr	x14, [sp, #584]
	ldr	x13, [sp, #592]
	ldr	x12, [sp, #600]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldr	x17, [sp, #608]
	ldr	x16, [sp, #616]
	ldr	x8, [sp, #640]
	adcs	x19, x15, x14
	ldr	x11, [sp, #624]
	adcs	x13, x27, x13
	ldr	x10, [sp, #632]
	adcs	x26, x26, x12
	ldr	x9, [x20, #72]
	adcs	x25, x25, x17
	adcs	x24, x24, x16
	add	x8, x22, x8
	adcs	x22, x28, x11
	adcs	x27, x29, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #496                    // =496
	mov	x0, x21
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldr	x15, [sp, #496]
	ldp	x14, x13, [sp, #504]
	ldr	x12, [sp, #520]
	ldr	x17, [sp, #528]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldr	x16, [sp, #536]
	ldr	x11, [sp, #544]
	ldr	x8, [sp, #560]
	adcs	x19, x15, x14
	adcs	x13, x26, x13
	ldr	x10, [sp, #552]
	adcs	x25, x25, x12
	ldr	x9, [x20, #80]
	adcs	x24, x24, x17
	adcs	x22, x22, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #416                    // =416
	mov	x0, x21
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #416]
	ldp	x13, x12, [sp, #432]
	ldr	x17, [sp, #448]
	ldp	x16, x11, [sp, #456]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #472]
	ldr	x9, [x20, #88]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x25, x13
	adcs	x24, x24, x12
	adcs	x22, x22, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #336                    // =336
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #336]
	ldp	x13, x12, [sp, #352]
	ldr	x17, [sp, #368]
	ldp	x16, x11, [sp, #376]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #392]
	ldr	x9, [x20, #96]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x24, x13
	adcs	x22, x22, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #256                    // =256
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #256]
	ldp	x13, x12, [sp, #272]
	ldr	x17, [sp, #288]
	ldp	x16, x11, [sp, #296]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #312]
	ldr	x9, [x20, #104]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x22, x13
	adcs	x22, x24, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #176                    // =176
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #176]
	ldp	x13, x12, [sp, #192]
	ldr	x17, [sp, #208]
	ldp	x16, x11, [sp, #216]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #232]
	ldr	x9, [x20, #112]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x22, x13
	adcs	x22, x24, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #96                     // =96
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #96]
	ldp	x13, x12, [sp, #112]
	ldr	x17, [sp, #128]
	ldp	x16, x11, [sp, #136]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #152]
	ldr	x9, [x20, #120]
	ldp	x0, x1, [sp, #40]               // 16-byte Folded Reload
	adcs	x14, x15, x14
	adcs	x13, x22, x13
	adcs	x12, x24, x12
	adcs	x15, x25, x17
	adcs	x16, x26, x16
	adcs	x11, x27, x11
	ldp	x17, x18, [sp, #24]             // 16-byte Folded Reload
	add	x8, x29, x8
	adcs	x10, x28, x10
	adcs	x8, x9, x8
	adcs	x9, xzr, xzr
	subs	x17, x14, x17
	ldp	x2, x3, [sp, #56]               // 16-byte Folded Reload
	sbcs	x18, x13, x18
	sbcs	x0, x12, x0
	ldp	x4, x5, [sp, #72]               // 16-byte Folded Reload
	sbcs	x1, x15, x1
	sbcs	x2, x16, x2
	sbcs	x3, x11, x3
	sbcs	x4, x10, x4
	sbcs	x5, x8, x5
	sbcs	x9, x9, xzr
	tst	x9, #0x1
	csel	x9, x4, x10, eq
	csel	x10, x3, x11, eq
	csel	x11, x2, x16, eq
	ldr	x16, [sp, #88]                  // 8-byte Folded Reload
	csel	x8, x5, x8, eq
	csel	x15, x1, x15, eq
	csel	x12, x0, x12, eq
	csel	x13, x18, x13, eq
	csel	x14, x17, x14, eq
	stp	x9, x8, [x16, #48]
	stp	x11, x10, [x16, #32]
	stp	x12, x15, [x16, #16]
	stp	x14, x13, [x16]
	add	sp, sp, #736                    // =736
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end52:
	.size	mcl_fp_montRed8L, .Lfunc_end52-mcl_fp_montRed8L
                                        // -- End function
	.globl	mcl_fp_montRedNF8L              // -- Begin function mcl_fp_montRedNF8L
	.p2align	2
	.type	mcl_fp_montRedNF8L,@function
mcl_fp_montRedNF8L:                     // @mcl_fp_montRedNF8L
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #736                    // =736
	ldp	x9, x8, [x2, #48]
	ldp	x29, x19, [x1]
	ldp	x24, x22, [x1, #48]
	stp	x8, x0, [sp, #80]               // 16-byte Folded Spill
	ldr	x8, [x2, #40]
	ldp	x26, x25, [x1, #32]
	ldp	x28, x27, [x1, #16]
	mov	x20, x1
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldp	x8, x9, [x2, #24]
	mov	x0, x2
	mov	x21, x2
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldp	x8, x9, [x2, #8]
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	ldp	x23, x8, [x2, #-8]
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	mul	x1, x29, x23
	add	x8, sp, #656                    // =656
	bl	mulPv512x64
	ldr	x13, [sp, #656]
	ldr	x12, [sp, #664]
	ldr	x15, [sp, #672]
	ldr	x14, [sp, #680]
	ldr	x17, [sp, #688]
	cmn	x29, x13
	ldr	x16, [sp, #696]
	adcs	x19, x19, x12
	ldr	x11, [sp, #704]
	adcs	x12, x28, x15
	ldr	x10, [sp, #712]
	adcs	x27, x27, x14
	ldr	x8, [x20, #64]
	ldr	x9, [sp, #720]
	adcs	x26, x26, x17
	adcs	x25, x25, x16
	adcs	x24, x24, x11
	adcs	x28, x22, x10
	adcs	x29, x8, x9
	mul	x1, x23, x19
	add	x8, sp, #576                    // =576
	mov	x0, x21
	str	x12, [sp, #16]                  // 8-byte Folded Spill
	adcs	x22, xzr, xzr
	bl	mulPv512x64
	ldr	x15, [sp, #576]
	ldr	x14, [sp, #584]
	ldr	x13, [sp, #592]
	ldr	x12, [sp, #600]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldr	x17, [sp, #608]
	ldr	x16, [sp, #616]
	ldr	x8, [sp, #640]
	adcs	x19, x15, x14
	ldr	x11, [sp, #624]
	adcs	x13, x27, x13
	ldr	x10, [sp, #632]
	adcs	x26, x26, x12
	ldr	x9, [x20, #72]
	adcs	x25, x25, x17
	adcs	x24, x24, x16
	add	x8, x22, x8
	adcs	x22, x28, x11
	adcs	x27, x29, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #496                    // =496
	mov	x0, x21
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldr	x15, [sp, #496]
	ldp	x14, x13, [sp, #504]
	ldr	x12, [sp, #520]
	ldr	x17, [sp, #528]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldr	x16, [sp, #536]
	ldr	x11, [sp, #544]
	ldr	x8, [sp, #560]
	adcs	x19, x15, x14
	adcs	x13, x26, x13
	ldr	x10, [sp, #552]
	adcs	x25, x25, x12
	ldr	x9, [x20, #80]
	adcs	x24, x24, x17
	adcs	x22, x22, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #416                    // =416
	mov	x0, x21
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #416]
	ldp	x13, x12, [sp, #432]
	ldr	x17, [sp, #448]
	ldp	x16, x11, [sp, #456]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #472]
	ldr	x9, [x20, #88]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x25, x13
	adcs	x24, x24, x12
	adcs	x22, x22, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #336                    // =336
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #336]
	ldp	x13, x12, [sp, #352]
	ldr	x17, [sp, #368]
	ldp	x16, x11, [sp, #376]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #392]
	ldr	x9, [x20, #96]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x24, x13
	adcs	x22, x22, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #256                    // =256
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #256]
	ldp	x13, x12, [sp, #272]
	ldr	x17, [sp, #288]
	ldp	x16, x11, [sp, #296]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #312]
	ldr	x9, [x20, #104]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x22, x13
	adcs	x22, x24, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #176                    // =176
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #176]
	ldp	x13, x12, [sp, #192]
	ldr	x17, [sp, #208]
	ldp	x16, x11, [sp, #216]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #232]
	ldr	x9, [x20, #112]
	mov	x0, x21
	adcs	x19, x15, x14
	adcs	x13, x22, x13
	adcs	x22, x24, x12
	adcs	x24, x25, x17
	adcs	x25, x26, x16
	adcs	x26, x27, x11
	add	x8, x29, x8
	adcs	x27, x28, x10
	adcs	x28, x9, x8
	mul	x1, x23, x19
	add	x8, sp, #96                     // =96
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x29, xzr, xzr
	bl	mulPv512x64
	ldp	x15, x14, [sp, #96]
	ldp	x13, x12, [sp, #112]
	ldr	x17, [sp, #128]
	ldp	x16, x11, [sp, #136]
	cmn	x19, x15
	ldr	x15, [sp, #16]                  // 8-byte Folded Reload
	ldp	x10, x8, [sp, #152]
	ldr	x9, [x20, #120]
	ldp	x18, x0, [sp, #40]              // 16-byte Folded Reload
	adcs	x14, x15, x14
	adcs	x13, x22, x13
	adcs	x12, x24, x12
	adcs	x15, x25, x17
	adcs	x16, x26, x16
	adcs	x11, x27, x11
	add	x8, x29, x8
	adcs	x10, x28, x10
	adcs	x8, x9, x8
	ldp	x9, x17, [sp, #24]              // 16-byte Folded Reload
	ldp	x1, x2, [sp, #56]               // 16-byte Folded Reload
	ldp	x3, x4, [sp, #72]               // 16-byte Folded Reload
	subs	x9, x14, x9
	sbcs	x17, x13, x17
	sbcs	x18, x12, x18
	sbcs	x0, x15, x0
	sbcs	x1, x16, x1
	sbcs	x2, x11, x2
	sbcs	x3, x10, x3
	sbcs	x4, x8, x4
	cmp	x4, #0                          // =0
	csel	x9, x9, x14, ge
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	csel	x8, x4, x8, ge
	csel	x10, x3, x10, ge
	csel	x11, x2, x11, ge
	csel	x16, x1, x16, ge
	csel	x15, x0, x15, ge
	csel	x12, x18, x12, ge
	csel	x13, x17, x13, ge
	stp	x10, x8, [x14, #48]
	stp	x16, x11, [x14, #32]
	stp	x12, x15, [x14, #16]
	stp	x9, x13, [x14]
	add	sp, sp, #736                    // =736
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end53:
	.size	mcl_fp_montRedNF8L, .Lfunc_end53-mcl_fp_montRedNF8L
                                        // -- End function
	.globl	mcl_fp_addPre8L                 // -- Begin function mcl_fp_addPre8L
	.p2align	2
	.type	mcl_fp_addPre8L,@function
mcl_fp_addPre8L:                        // @mcl_fp_addPre8L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	adds	x8, x8, x9
	ldp	x9, x12, [x2, #16]
	fmov	d0, x8
	adcs	x10, x11, x10
	ldp	x8, x11, [x1, #16]
	mov	v0.d[1], x10
	adcs	x8, x8, x9
	fmov	d1, x8
	adcs	x8, x11, x12
	ldp	x10, x11, [x2, #32]
	mov	v1.d[1], x8
	ldp	x9, x8, [x1, #32]
	stp	q0, q1, [x0]
	adcs	x9, x9, x10
	ldp	x10, x12, [x1, #48]
	fmov	d2, x9
	adcs	x8, x8, x11
	ldp	x9, x11, [x2, #48]
	mov	v2.d[1], x8
	adcs	x9, x10, x9
	fmov	d0, x9
	adcs	x8, x12, x11
	mov	v0.d[1], x8
	adcs	x8, xzr, xzr
	stp	q2, q0, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end54:
	.size	mcl_fp_addPre8L, .Lfunc_end54-mcl_fp_addPre8L
                                        // -- End function
	.globl	mcl_fp_subPre8L                 // -- Begin function mcl_fp_subPre8L
	.p2align	2
	.type	mcl_fp_subPre8L,@function
mcl_fp_subPre8L:                        // @mcl_fp_subPre8L
// %bb.0:
	ldp	x8, x11, [x1]
	ldp	x9, x10, [x2]
	subs	x8, x8, x9
	ldp	x9, x12, [x2, #16]
	fmov	d0, x8
	sbcs	x10, x11, x10
	ldp	x8, x11, [x1, #16]
	mov	v0.d[1], x10
	sbcs	x8, x8, x9
	fmov	d1, x8
	sbcs	x8, x11, x12
	ldp	x10, x11, [x2, #32]
	mov	v1.d[1], x8
	ldp	x9, x8, [x1, #32]
	stp	q0, q1, [x0]
	sbcs	x9, x9, x10
	ldp	x10, x12, [x1, #48]
	fmov	d2, x9
	sbcs	x8, x8, x11
	ldp	x9, x11, [x2, #48]
	mov	v2.d[1], x8
	sbcs	x9, x10, x9
	fmov	d0, x9
	sbcs	x8, x12, x11
	mov	v0.d[1], x8
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	q2, q0, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end55:
	.size	mcl_fp_subPre8L, .Lfunc_end55-mcl_fp_subPre8L
                                        // -- End function
	.globl	mcl_fp_shr1_8L                  // -- Begin function mcl_fp_shr1_8L
	.p2align	2
	.type	mcl_fp_shr1_8L,@function
mcl_fp_shr1_8L:                         // @mcl_fp_shr1_8L
// %bb.0:
	ldp	x9, x8, [x1, #48]
	ldp	x11, x10, [x1]
	ldp	x13, x12, [x1, #16]
	ldp	x15, x14, [x1, #32]
	extr	x11, x10, x11, #1
	extr	x10, x13, x10, #1
	extr	x13, x12, x13, #1
	extr	x12, x15, x12, #1
	extr	x15, x14, x15, #1
	extr	x14, x9, x14, #1
	extr	x9, x8, x9, #1
	lsr	x8, x8, #1
	stp	x9, x8, [x0, #48]
	stp	x15, x14, [x0, #32]
	stp	x13, x12, [x0, #16]
	stp	x11, x10, [x0]
	ret
.Lfunc_end56:
	.size	mcl_fp_shr1_8L, .Lfunc_end56-mcl_fp_shr1_8L
                                        // -- End function
	.globl	mcl_fp_add8L                    // -- Begin function mcl_fp_add8L
	.p2align	2
	.type	mcl_fp_add8L,@function
mcl_fp_add8L:                           // @mcl_fp_add8L
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x8, x9, [x2]
	ldp	x10, x11, [x1]
	ldp	x12, x13, [x2, #16]
	ldp	x14, x15, [x1, #16]
	ldp	x16, x17, [x2, #32]
	ldp	x18, x4, [x1, #32]
	adds	x8, x10, x8
	adcs	x9, x11, x9
	ldp	x5, x2, [x2, #48]
	ldp	x10, x1, [x1, #48]
	adcs	x11, x14, x12
	fmov	d1, x11
	adcs	x11, x15, x13
	adcs	x14, x18, x16
	ldp	x16, x15, [x3]
	adcs	x17, x4, x17
	fmov	d0, x8
	adcs	x10, x10, x5
	ldp	x13, x12, [x3, #16]
	mov	v0.d[1], x9
	adcs	x1, x1, x2
	fmov	d2, x14
	fmov	x14, d0
	adcs	x2, xzr, xzr
	ldp	x19, x7, [x3, #32]
	mov	v1.d[1], x11
	subs	x14, x14, x16
	fmov	x18, d1
	sbcs	x15, x9, x15
	ldp	x6, x8, [x3, #48]
	mov	v2.d[1], x17
	sbcs	x13, x18, x13
	stp	q0, q1, [x0]
	fmov	d0, x10
	fmov	x10, d2
	sbcs	x12, x11, x12
	mov	v0.d[1], x1
	sbcs	x11, x10, x19
	fmov	x3, d0
	sbcs	x10, x17, x7
	sbcs	x9, x3, x6
	sbcs	x8, x1, x8
	sbcs	x16, x2, xzr
	stp	q2, q0, [x0, #32]
	tbnz	w16, #0, .LBB57_2
// %bb.1:                               // %nocarry
	stp	x14, x15, [x0]
	stp	x13, x12, [x0, #16]
	stp	x11, x10, [x0, #32]
	stp	x9, x8, [x0, #48]
.LBB57_2:                               // %common.ret
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end57:
	.size	mcl_fp_add8L, .Lfunc_end57-mcl_fp_add8L
                                        // -- End function
	.globl	mcl_fp_addNF8L                  // -- Begin function mcl_fp_addNF8L
	.p2align	2
	.type	mcl_fp_addNF8L,@function
mcl_fp_addNF8L:                         // @mcl_fp_addNF8L
// %bb.0:
	ldp	x17, x16, [x1]
	ldp	x4, x18, [x2]
	ldp	x9, x8, [x1, #48]
	ldp	x11, x10, [x2, #48]
	ldp	x13, x12, [x1, #32]
	ldp	x15, x14, [x2, #32]
	ldp	x1, x5, [x1, #16]
	ldp	x2, x6, [x2, #16]
	adds	x17, x4, x17
	adcs	x16, x18, x16
	ldp	x4, x18, [x3, #48]
	adcs	x1, x2, x1
	adcs	x2, x6, x5
	fmov	d0, x1
	adcs	x13, x15, x13
	mov	v0.d[1], x2
	ldp	x6, x5, [x3, #32]
	ldp	x1, x15, [x3, #16]
	adcs	x12, x14, x12
	fmov	x14, d0
	fmov	d0, x13
	ldp	x3, x13, [x3]
	adcs	x9, x11, x9
	mov	v0.d[1], x12
	adcs	x8, x10, x8
	fmov	x10, d0
	fmov	d0, x9
	subs	x9, x17, x3
	sbcs	x13, x16, x13
	sbcs	x1, x14, x1
	sbcs	x15, x2, x15
	mov	v0.d[1], x8
	sbcs	x3, x10, x6
	fmov	x11, d0
	sbcs	x5, x12, x5
	sbcs	x4, x11, x4
	sbcs	x18, x8, x18
	cmp	x18, #0                         // =0
	csel	x8, x18, x8, ge
	csel	x11, x4, x11, ge
	csel	x12, x5, x12, ge
	csel	x10, x3, x10, ge
	csel	x15, x15, x2, ge
	csel	x14, x1, x14, ge
	csel	x13, x13, x16, ge
	csel	x9, x9, x17, ge
	stp	x11, x8, [x0, #48]
	stp	x10, x12, [x0, #32]
	stp	x14, x15, [x0, #16]
	stp	x9, x13, [x0]
	ret
.Lfunc_end58:
	.size	mcl_fp_addNF8L, .Lfunc_end58-mcl_fp_addNF8L
                                        // -- End function
	.globl	mcl_fp_sub8L                    // -- Begin function mcl_fp_sub8L
	.p2align	2
	.type	mcl_fp_sub8L,@function
mcl_fp_sub8L:                           // @mcl_fp_sub8L
// %bb.0:
	ldp	x8, x9, [x2]
	ldp	x10, x11, [x1]
	ldp	x12, x13, [x2, #16]
	ldp	x14, x15, [x1, #16]
	subs	x10, x10, x8
	sbcs	x11, x11, x9
	sbcs	x9, x14, x12
	ldp	x12, x14, [x2, #32]
	sbcs	x8, x15, x13
	ldp	x16, x13, [x1, #32]
	fmov	d0, x10
	fmov	d1, x9
	mov	v0.d[1], x11
	sbcs	x12, x16, x12
	fmov	d2, x12
	ldp	x10, x12, [x2, #48]
	sbcs	x9, x13, x14
	ldp	x13, x14, [x1, #48]
	mov	v1.d[1], x8
	mov	v2.d[1], x9
	stp	q0, q1, [x0]
	sbcs	x10, x13, x10
	fmov	d3, x10
	sbcs	x10, x14, x12
	mov	v3.d[1], x10
	ngcs	x12, xzr
	stp	q2, q3, [x0, #32]
	tbz	w12, #0, .LBB59_2
// %bb.1:                               // %carry
	ldp	x12, x13, [x3]
	fmov	x14, d0
	fmov	x15, d1
	fmov	x16, d2
	adds	x12, x12, x14
	adcs	x11, x13, x11
	ldp	x13, x14, [x3, #16]
	stp	x12, x11, [x0]
	fmov	x17, d3
	adcs	x11, x13, x15
	ldp	x12, x13, [x3, #32]
	adcs	x8, x14, x8
	ldp	x14, x15, [x3, #48]
	stp	x11, x8, [x0, #16]
	adcs	x8, x12, x16
	adcs	x9, x13, x9
	stp	x8, x9, [x0, #32]
	adcs	x8, x14, x17
	adcs	x9, x15, x10
	stp	x8, x9, [x0, #48]
.LBB59_2:                               // %common.ret
	ret
.Lfunc_end59:
	.size	mcl_fp_sub8L, .Lfunc_end59-mcl_fp_sub8L
                                        // -- End function
	.globl	mcl_fp_subNF8L                  // -- Begin function mcl_fp_subNF8L
	.p2align	2
	.type	mcl_fp_subNF8L,@function
mcl_fp_subNF8L:                         // @mcl_fp_subNF8L
// %bb.0:
	ldp	x17, x16, [x2]
	ldp	x4, x18, [x1]
	ldp	x9, x8, [x2, #48]
	ldp	x11, x10, [x1, #48]
	ldp	x13, x12, [x2, #32]
	ldp	x15, x14, [x1, #32]
	ldp	x2, x5, [x2, #16]
	ldp	x1, x6, [x1, #16]
	subs	x17, x4, x17
	sbcs	x16, x18, x16
	ldp	x4, x18, [x3, #48]
	sbcs	x1, x1, x2
	sbcs	x2, x6, x5
	fmov	d0, x1
	sbcs	x13, x15, x13
	mov	v0.d[1], x2
	ldp	x6, x5, [x3, #32]
	ldp	x1, x15, [x3, #16]
	sbcs	x12, x14, x12
	fmov	x14, d0
	fmov	d0, x13
	ldp	x13, x3, [x3]
	sbcs	x9, x11, x9
	mov	v0.d[1], x12
	sbcs	x8, x10, x8
	fmov	x10, d0
	fmov	d0, x9
	asr	x9, x8, #63
	and	x11, x9, x13
	and	x13, x9, x3
	adds	x11, x11, x17
	and	x1, x9, x1
	adcs	x13, x13, x16
	and	x15, x9, x15
	stp	x11, x13, [x0]
	adcs	x11, x1, x14
	and	x3, x9, x6
	adcs	x13, x15, x2
	mov	v0.d[1], x8
	and	x5, x9, x5
	adcs	x10, x3, x10
	fmov	x6, d0
	and	x4, x9, x4
	stp	x11, x13, [x0, #16]
	adcs	x11, x5, x12
	and	x9, x9, x18
	stp	x10, x11, [x0, #32]
	adcs	x10, x4, x6
	adcs	x8, x9, x8
	stp	x10, x8, [x0, #48]
	ret
.Lfunc_end60:
	.size	mcl_fp_subNF8L, .Lfunc_end60-mcl_fp_subNF8L
                                        // -- End function
	.globl	mcl_fpDbl_add8L                 // -- Begin function mcl_fpDbl_add8L
	.p2align	2
	.type	mcl_fpDbl_add8L,@function
mcl_fpDbl_add8L:                        // @mcl_fpDbl_add8L
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	ldp	x21, x22, [x2]
	ldp	x23, x24, [x1]
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	adds	x21, x23, x21
	ldp	x28, x23, [x2, #16]
	fmov	d0, x21
	ldp	x29, x21, [x1, #16]
	adcs	x22, x24, x22
	ldp	x10, x8, [x2, #112]
	ldp	x11, x9, [x1, #112]
	ldp	x14, x12, [x2, #96]
	ldp	x15, x13, [x1, #96]
	ldp	x18, x16, [x2, #80]
	ldp	x4, x17, [x1, #80]
	ldp	x7, x5, [x2, #64]
	ldp	x19, x6, [x1, #64]
	ldp	x25, x20, [x2, #48]
	ldp	x27, x26, [x1, #48]
	ldp	x2, x24, [x2, #32]
	adcs	x28, x29, x28
	ldp	x1, x29, [x1, #32]
	adcs	x21, x21, x23
	fmov	d1, x28
	mov	v0.d[1], x22
	adcs	x1, x1, x2
	adcs	x24, x29, x24
	adcs	x25, x27, x25
	mov	v1.d[1], x21
	adcs	x20, x26, x20
	fmov	d2, x1
	stp	q0, q1, [x0]
	fmov	d0, x25
	adcs	x7, x19, x7
	mov	v2.d[1], x24
	mov	v0.d[1], x20
	adcs	x5, x6, x5
	stp	q2, q0, [x0, #32]
	fmov	d0, x7
	adcs	x18, x4, x18
	mov	v0.d[1], x5
	adcs	x16, x17, x16
	fmov	x17, d0
	fmov	d0, x18
	adcs	x14, x15, x14
	mov	v0.d[1], x16
	adcs	x12, x13, x12
	fmov	x13, d0
	fmov	d0, x14
	adcs	x10, x11, x10
	ldp	x14, x11, [x3]
	ldp	x21, x1, [x3, #16]
	adcs	x8, x9, x8
	adcs	x9, xzr, xzr
	ldp	x23, x2, [x3, #32]
	subs	x14, x17, x14
	sbcs	x11, x5, x11
	ldp	x28, x22, [x3, #48]
	mov	v0.d[1], x12
	sbcs	x18, x13, x21
	fmov	x15, d0
	fmov	d0, x10
	sbcs	x1, x16, x1
	mov	v0.d[1], x8
	sbcs	x3, x15, x23
	fmov	x10, d0
	sbcs	x2, x12, x2
	sbcs	x4, x10, x28
	sbcs	x6, x8, x22
	sbcs	x9, x9, xzr
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	tst	x9, #0x1
	csel	x8, x6, x8, eq
	csel	x9, x4, x10, eq
	csel	x10, x2, x12, eq
	csel	x12, x3, x15, eq
	csel	x15, x1, x16, eq
	csel	x13, x18, x13, eq
	csel	x11, x11, x5, eq
	csel	x14, x14, x17, eq
	stp	x9, x8, [x0, #112]
	stp	x12, x10, [x0, #96]
	stp	x13, x15, [x0, #80]
	stp	x14, x11, [x0, #64]
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end61:
	.size	mcl_fpDbl_add8L, .Lfunc_end61-mcl_fpDbl_add8L
                                        // -- End function
	.globl	mcl_fpDbl_sub8L                 // -- Begin function mcl_fpDbl_sub8L
	.p2align	2
	.type	mcl_fpDbl_sub8L,@function
mcl_fpDbl_sub8L:                        // @mcl_fpDbl_sub8L
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	ldp	x24, x25, [x2]
	ldp	x26, x27, [x1]
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x10, x8, [x2, #112]
	subs	x24, x26, x24
	ldp	x28, x26, [x2, #16]
	fmov	d0, x24
	ldp	x29, x24, [x1, #16]
	sbcs	x25, x27, x25
	ldp	x11, x9, [x1, #112]
	ldp	x14, x12, [x2, #96]
	ldp	x15, x13, [x1, #96]
	ldp	x18, x16, [x2, #80]
	ldp	x4, x17, [x1, #80]
	ldp	x7, x5, [x2, #64]
	ldp	x19, x6, [x1, #64]
	ldp	x22, x20, [x2, #48]
	ldp	x23, x21, [x1, #48]
	ldp	x2, x27, [x2, #32]
	sbcs	x28, x29, x28
	ldp	x1, x29, [x1, #32]
	sbcs	x24, x24, x26
	fmov	d1, x28
	mov	v0.d[1], x25
	sbcs	x1, x1, x2
	sbcs	x27, x29, x27
	sbcs	x22, x23, x22
	mov	v1.d[1], x24
	sbcs	x20, x21, x20
	fmov	d2, x1
	stp	q0, q1, [x0]
	fmov	d0, x22
	sbcs	x7, x19, x7
	mov	v2.d[1], x27
	mov	v0.d[1], x20
	sbcs	x5, x6, x5
	stp	q2, q0, [x0, #32]
	fmov	d0, x7
	sbcs	x18, x4, x18
	mov	v0.d[1], x5
	sbcs	x16, x17, x16
	fmov	x4, d0
	fmov	d0, x18
	sbcs	x14, x15, x14
	mov	v0.d[1], x16
	sbcs	x12, x13, x12
	ldp	x25, x28, [x3]
	fmov	x13, d0
	fmov	d0, x14
	sbcs	x10, x11, x10
	mov	v0.d[1], x12
	sbcs	x8, x9, x8
	ldp	x2, x26, [x3, #16]
	fmov	x9, d0
	fmov	d0, x10
	ngcs	x10, xzr
	sbfx	x10, x10, #0, #1
	ldp	x1, x24, [x3, #32]
	and	x14, x10, x25
	and	x15, x10, x28
	adds	x14, x14, x4
	ldp	x29, x3, [x3, #48]
	and	x17, x10, x2
	adcs	x15, x15, x5
	and	x18, x10, x26
	adcs	x13, x17, x13
	and	x1, x10, x1
	stp	x14, x15, [x0, #64]
	adcs	x14, x18, x16
	mov	v0.d[1], x8
	and	x2, x10, x24
	adcs	x9, x1, x9
	fmov	x11, d0
	and	x6, x10, x29
	adcs	x12, x2, x12
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	and	x10, x10, x3
	stp	x9, x12, [x0, #96]
	adcs	x9, x6, x11
	adcs	x8, x10, x8
	stp	x13, x14, [x0, #80]
	stp	x9, x8, [x0, #112]
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end62:
	.size	mcl_fpDbl_sub8L, .Lfunc_end62-mcl_fpDbl_sub8L
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
