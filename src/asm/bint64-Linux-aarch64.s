	.text
	.file	"bint64.ll"
	.globl	mclb_add1                       // -- Begin function mclb_add1
	.p2align	2
	.type	mclb_add1,@function
mclb_add1:                              // @mclb_add1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x2]
	adds	x9, x9, x8
	adcs	x8, xzr, xzr
	str	x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end0:
	.size	mclb_add1, .Lfunc_end0-mclb_add1
                                        // -- End function
	.globl	mclb_sub1                       // -- Begin function mclb_sub1
	.p2align	2
	.type	mclb_sub1,@function
mclb_sub1:                              // @mclb_sub1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x2]
	subs	x9, x8, x9
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end1:
	.size	mclb_sub1, .Lfunc_end1-mclb_sub1
                                        // -- End function
	.globl	mclb_addNF1                     // -- Begin function mclb_addNF1
	.p2align	2
	.type	mclb_addNF1,@function
mclb_addNF1:                            // @mclb_addNF1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x2]
	add	x8, x9, x8
	str	x8, [x0]
	ret
.Lfunc_end2:
	.size	mclb_addNF1, .Lfunc_end2-mclb_addNF1
                                        // -- End function
	.globl	mclb_add2                       // -- Begin function mclb_add2
	.p2align	2
	.type	mclb_add2,@function
mclb_add2:                              // @mclb_add2
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	adds	x9, x10, x9
	adcs	x10, x11, x8
	adcs	x8, xzr, xzr
	stp	x9, x10, [x0]
	mov	x0, x8
	ret
.Lfunc_end3:
	.size	mclb_add2, .Lfunc_end3-mclb_add2
                                        // -- End function
	.globl	mclb_sub2                       // -- Begin function mclb_sub2
	.p2align	2
	.type	mclb_sub2,@function
mclb_sub2:                              // @mclb_sub2
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	subs	x9, x9, x10
	sbcs	x10, x8, x11
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x9, x10, [x0]
	mov	x0, x8
	ret
.Lfunc_end4:
	.size	mclb_sub2, .Lfunc_end4-mclb_sub2
                                        // -- End function
	.globl	mclb_addNF2                     // -- Begin function mclb_addNF2
	.p2align	2
	.type	mclb_addNF2,@function
mclb_addNF2:                            // @mclb_addNF2
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	stp	x9, x8, [x0]
	ret
.Lfunc_end5:
	.size	mclb_addNF2, .Lfunc_end5-mclb_addNF2
                                        // -- End function
	.globl	mclb_add3                       // -- Begin function mclb_add3
	.p2align	2
	.type	mclb_add3,@function
mclb_add3:                              // @mclb_add3
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	adds	x9, x11, x9
	adcs	x10, x10, x8
	adcs	x11, x13, x12
	adcs	x8, xzr, xzr
	stp	x9, x10, [x0]
	str	x11, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end6:
	.size	mclb_add3, .Lfunc_end6-mclb_add3
                                        // -- End function
	.globl	mclb_sub3                       // -- Begin function mclb_sub3
	.p2align	2
	.type	mclb_sub3,@function
mclb_sub3:                              // @mclb_sub3
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	subs	x9, x9, x11
	sbcs	x8, x8, x10
	sbcs	x10, x12, x13
	ngcs	x11, xzr
	stp	x9, x8, [x0]
	and	x8, x11, #0x1
	str	x10, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end7:
	.size	mclb_sub3, .Lfunc_end7-mclb_sub3
                                        // -- End function
	.globl	mclb_addNF3                     // -- Begin function mclb_addNF3
	.p2align	2
	.type	mclb_addNF3,@function
mclb_addNF3:                            // @mclb_addNF3
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	adds	x9, x11, x9
	adcs	x8, x10, x8
	adcs	x10, x13, x12
	stp	x9, x8, [x0]
	str	x10, [x0, #16]
	ret
.Lfunc_end8:
	.size	mclb_addNF3, .Lfunc_end8-mclb_addNF3
                                        // -- End function
	.globl	mclb_add4                       // -- Begin function mclb_add4
	.p2align	2
	.type	mclb_add4,@function
mclb_add4:                              // @mclb_add4
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldp	x13, x12, [x1, #16]
	ldp	x14, x15, [x2, #16]
	adds	x9, x11, x9
	adcs	x8, x10, x8
	adcs	x10, x14, x13
	stp	x9, x8, [x0]
	adcs	x9, x15, x12
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end9:
	.size	mclb_add4, .Lfunc_end9-mclb_add4
                                        // -- End function
	.globl	mclb_sub4                       // -- Begin function mclb_sub4
	.p2align	2
	.type	mclb_sub4,@function
mclb_sub4:                              // @mclb_sub4
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldp	x13, x12, [x1, #16]
	ldp	x14, x15, [x2, #16]
	subs	x9, x9, x11
	sbcs	x8, x8, x10
	sbcs	x10, x13, x14
	stp	x9, x8, [x0]
	sbcs	x9, x12, x15
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end10:
	.size	mclb_sub4, .Lfunc_end10-mclb_sub4
                                        // -- End function
	.globl	mclb_addNF4                     // -- Begin function mclb_addNF4
	.p2align	2
	.type	mclb_addNF4,@function
mclb_addNF4:                            // @mclb_addNF4
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldp	x13, x12, [x1, #16]
	ldp	x14, x15, [x2, #16]
	adds	x9, x11, x9
	adcs	x8, x10, x8
	adcs	x10, x14, x13
	stp	x9, x8, [x0]
	adcs	x8, x15, x12
	stp	x10, x8, [x0, #16]
	ret
.Lfunc_end11:
	.size	mclb_addNF4, .Lfunc_end11-mclb_addNF4
                                        // -- End function
	.globl	mclb_add5                       // -- Begin function mclb_add5
	.p2align	2
	.type	mclb_add5,@function
mclb_add5:                              // @mclb_add5
// %bb.0:
	ldr	x12, [x1]
	ldp	x14, x13, [x2]
	ldp	x11, x10, [x1, #8]
	ldp	x16, x15, [x2, #16]
	ldp	x9, x8, [x1, #24]
	ldr	x17, [x2, #32]
	adds	x12, x14, x12
	adcs	x11, x13, x11
	adcs	x10, x16, x10
	adcs	x9, x15, x9
	stp	x12, x11, [x0]
	adcs	x11, x17, x8
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #16]
	str	x11, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end12:
	.size	mclb_add5, .Lfunc_end12-mclb_add5
                                        // -- End function
	.globl	mclb_sub5                       // -- Begin function mclb_sub5
	.p2align	2
	.type	mclb_sub5,@function
mclb_sub5:                              // @mclb_sub5
// %bb.0:
	ldr	x12, [x1]
	ldp	x14, x13, [x2]
	ldp	x11, x10, [x1, #8]
	ldp	x16, x15, [x2, #16]
	ldp	x9, x8, [x1, #24]
	ldr	x17, [x2, #32]
	subs	x12, x12, x14
	sbcs	x11, x11, x13
	sbcs	x10, x10, x16
	sbcs	x9, x9, x15
	stp	x12, x11, [x0]
	sbcs	x11, x8, x17
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #16]
	str	x11, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end13:
	.size	mclb_sub5, .Lfunc_end13-mclb_sub5
                                        // -- End function
	.globl	mclb_addNF5                     // -- Begin function mclb_addNF5
	.p2align	2
	.type	mclb_addNF5,@function
mclb_addNF5:                            // @mclb_addNF5
// %bb.0:
	ldr	x12, [x1]
	ldp	x14, x13, [x2]
	ldp	x11, x10, [x1, #8]
	ldp	x16, x15, [x2, #16]
	ldp	x9, x8, [x1, #24]
	ldr	x17, [x2, #32]
	adds	x12, x14, x12
	adcs	x11, x13, x11
	adcs	x10, x16, x10
	adcs	x9, x15, x9
	adcs	x8, x17, x8
	stp	x12, x11, [x0]
	stp	x10, x9, [x0, #16]
	str	x8, [x0, #32]
	ret
.Lfunc_end14:
	.size	mclb_addNF5, .Lfunc_end14-mclb_addNF5
                                        // -- End function
	.globl	mclb_add6                       // -- Begin function mclb_add6
	.p2align	2
	.type	mclb_add6,@function
mclb_add6:                              // @mclb_add6
// %bb.0:
	ldp	x13, x12, [x1]
	ldp	x15, x14, [x2]
	ldp	x11, x10, [x1, #16]
	ldp	x17, x16, [x2, #16]
	ldp	x9, x8, [x1, #32]
	ldp	x1, x18, [x2, #32]
	adds	x13, x15, x13
	adcs	x12, x14, x12
	adcs	x11, x17, x11
	adcs	x10, x16, x10
	adcs	x9, x1, x9
	stp	x11, x10, [x0, #16]
	adcs	x10, x18, x8
	adcs	x8, xzr, xzr
	stp	x13, x12, [x0]
	stp	x9, x10, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end15:
	.size	mclb_add6, .Lfunc_end15-mclb_add6
                                        // -- End function
	.globl	mclb_sub6                       // -- Begin function mclb_sub6
	.p2align	2
	.type	mclb_sub6,@function
mclb_sub6:                              // @mclb_sub6
// %bb.0:
	ldp	x13, x12, [x1]
	ldp	x15, x14, [x2]
	ldp	x11, x10, [x1, #16]
	ldp	x17, x16, [x2, #16]
	ldp	x9, x8, [x1, #32]
	ldp	x1, x18, [x2, #32]
	subs	x13, x13, x15
	sbcs	x12, x12, x14
	sbcs	x11, x11, x17
	sbcs	x10, x10, x16
	sbcs	x9, x9, x1
	stp	x11, x10, [x0, #16]
	sbcs	x10, x8, x18
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x13, x12, [x0]
	stp	x9, x10, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end16:
	.size	mclb_sub6, .Lfunc_end16-mclb_sub6
                                        // -- End function
	.globl	mclb_addNF6                     // -- Begin function mclb_addNF6
	.p2align	2
	.type	mclb_addNF6,@function
mclb_addNF6:                            // @mclb_addNF6
// %bb.0:
	ldp	x13, x12, [x1]
	ldp	x15, x14, [x2]
	ldp	x11, x10, [x1, #16]
	ldp	x17, x16, [x2, #16]
	ldp	x9, x8, [x1, #32]
	ldp	x1, x18, [x2, #32]
	adds	x13, x15, x13
	adcs	x12, x14, x12
	adcs	x11, x17, x11
	adcs	x10, x16, x10
	adcs	x9, x1, x9
	adcs	x8, x18, x8
	stp	x13, x12, [x0]
	stp	x11, x10, [x0, #16]
	stp	x9, x8, [x0, #32]
	ret
.Lfunc_end17:
	.size	mclb_addNF6, .Lfunc_end17-mclb_addNF6
                                        // -- End function
	.globl	mclb_add7                       // -- Begin function mclb_add7
	.p2align	2
	.type	mclb_add7,@function
mclb_add7:                              // @mclb_add7
// %bb.0:
	ldr	x14, [x1]
	ldp	x17, x16, [x2]
	ldp	x13, x12, [x1, #8]
	ldp	x9, x8, [x1, #40]
	ldp	x11, x10, [x1, #24]
	ldp	x1, x18, [x2, #16]
	ldp	x3, x15, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x14, x17, x14
	adcs	x13, x16, x13
	adcs	x12, x1, x12
	adcs	x11, x18, x11
	adcs	x10, x2, x10
	adcs	x9, x3, x9
	stp	x12, x11, [x0, #16]
	adcs	x11, x15, x8
	adcs	x8, xzr, xzr
	stp	x14, x13, [x0]
	stp	x10, x9, [x0, #32]
	str	x11, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end18:
	.size	mclb_add7, .Lfunc_end18-mclb_add7
                                        // -- End function
	.globl	mclb_sub7                       // -- Begin function mclb_sub7
	.p2align	2
	.type	mclb_sub7,@function
mclb_sub7:                              // @mclb_sub7
// %bb.0:
	ldr	x14, [x1]
	ldp	x17, x16, [x2]
	ldp	x13, x12, [x1, #8]
	ldp	x9, x8, [x1, #40]
	ldp	x11, x10, [x1, #24]
	ldp	x1, x18, [x2, #16]
	ldp	x3, x15, [x2, #40]
	ldr	x2, [x2, #32]
	subs	x14, x14, x17
	sbcs	x13, x13, x16
	sbcs	x12, x12, x1
	sbcs	x11, x11, x18
	sbcs	x10, x10, x2
	sbcs	x9, x9, x3
	stp	x12, x11, [x0, #16]
	sbcs	x11, x8, x15
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x14, x13, [x0]
	stp	x10, x9, [x0, #32]
	str	x11, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end19:
	.size	mclb_sub7, .Lfunc_end19-mclb_sub7
                                        // -- End function
	.globl	mclb_addNF7                     // -- Begin function mclb_addNF7
	.p2align	2
	.type	mclb_addNF7,@function
mclb_addNF7:                            // @mclb_addNF7
// %bb.0:
	ldr	x14, [x1]
	ldp	x17, x16, [x2]
	ldp	x13, x12, [x1, #8]
	ldp	x9, x8, [x1, #40]
	ldp	x11, x10, [x1, #24]
	ldp	x1, x18, [x2, #16]
	ldp	x3, x15, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x14, x17, x14
	adcs	x13, x16, x13
	adcs	x12, x1, x12
	adcs	x11, x18, x11
	adcs	x10, x2, x10
	adcs	x9, x3, x9
	adcs	x8, x15, x8
	stp	x14, x13, [x0]
	stp	x12, x11, [x0, #16]
	stp	x10, x9, [x0, #32]
	str	x8, [x0, #48]
	ret
.Lfunc_end20:
	.size	mclb_addNF7, .Lfunc_end20-mclb_addNF7
                                        // -- End function
	.globl	mclb_add8                       // -- Begin function mclb_add8
	.p2align	2
	.type	mclb_add8,@function
mclb_add8:                              // @mclb_add8
// %bb.0:
	ldp	x9, x8, [x1, #48]
	ldp	x11, x10, [x1, #32]
	ldp	x13, x12, [x1, #16]
	ldp	x15, x14, [x1]
	ldp	x1, x18, [x2]
	ldp	x4, x3, [x2, #16]
	ldp	x17, x16, [x2, #48]
	ldp	x2, x5, [x2, #32]
	adds	x15, x1, x15
	adcs	x14, x18, x14
	adcs	x13, x4, x13
	adcs	x12, x3, x12
	adcs	x11, x2, x11
	adcs	x10, x5, x10
	adcs	x9, x17, x9
	stp	x11, x10, [x0, #32]
	adcs	x10, x16, x8
	adcs	x8, xzr, xzr
	stp	x15, x14, [x0]
	stp	x13, x12, [x0, #16]
	stp	x9, x10, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end21:
	.size	mclb_add8, .Lfunc_end21-mclb_add8
                                        // -- End function
	.globl	mclb_sub8                       // -- Begin function mclb_sub8
	.p2align	2
	.type	mclb_sub8,@function
mclb_sub8:                              // @mclb_sub8
// %bb.0:
	ldp	x9, x8, [x1, #48]
	ldp	x11, x10, [x1, #32]
	ldp	x13, x12, [x1, #16]
	ldp	x15, x14, [x1]
	ldp	x1, x18, [x2]
	ldp	x4, x3, [x2, #16]
	ldp	x17, x16, [x2, #48]
	ldp	x2, x5, [x2, #32]
	subs	x15, x15, x1
	sbcs	x14, x14, x18
	sbcs	x13, x13, x4
	sbcs	x12, x12, x3
	sbcs	x11, x11, x2
	sbcs	x10, x10, x5
	sbcs	x9, x9, x17
	stp	x11, x10, [x0, #32]
	sbcs	x10, x8, x16
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x15, x14, [x0]
	stp	x13, x12, [x0, #16]
	stp	x9, x10, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end22:
	.size	mclb_sub8, .Lfunc_end22-mclb_sub8
                                        // -- End function
	.globl	mclb_addNF8                     // -- Begin function mclb_addNF8
	.p2align	2
	.type	mclb_addNF8,@function
mclb_addNF8:                            // @mclb_addNF8
// %bb.0:
	ldp	x9, x8, [x1, #48]
	ldp	x11, x10, [x1, #32]
	ldp	x13, x12, [x1, #16]
	ldp	x15, x14, [x1]
	ldp	x1, x18, [x2]
	ldp	x4, x3, [x2, #16]
	ldp	x17, x16, [x2, #48]
	ldp	x2, x5, [x2, #32]
	adds	x15, x1, x15
	adcs	x14, x18, x14
	adcs	x13, x4, x13
	adcs	x12, x3, x12
	adcs	x11, x2, x11
	adcs	x10, x5, x10
	adcs	x9, x17, x9
	adcs	x8, x16, x8
	stp	x15, x14, [x0]
	stp	x13, x12, [x0, #16]
	stp	x11, x10, [x0, #32]
	stp	x9, x8, [x0, #48]
	ret
.Lfunc_end23:
	.size	mclb_addNF8, .Lfunc_end23-mclb_addNF8
                                        // -- End function
	.globl	mclb_add9                       // -- Begin function mclb_add9
	.p2align	2
	.type	mclb_add9,@function
mclb_add9:                              // @mclb_add9
// %bb.0:
	ldr	x16, [x1]
	ldp	x4, x3, [x2]
	ldp	x15, x14, [x1, #8]
	ldp	x6, x5, [x2, #16]
	ldp	x13, x12, [x1, #24]
	ldp	x9, x8, [x1, #56]
	ldp	x11, x10, [x1, #40]
	ldp	x18, x17, [x2, #56]
	ldp	x7, x1, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x16, x4, x16
	adcs	x15, x3, x15
	adcs	x14, x6, x14
	adcs	x13, x5, x13
	adcs	x12, x2, x12
	adcs	x11, x7, x11
	adcs	x10, x1, x10
	adcs	x9, x18, x9
	stp	x12, x11, [x0, #32]
	adcs	x11, x17, x8
	adcs	x8, xzr, xzr
	stp	x16, x15, [x0]
	stp	x14, x13, [x0, #16]
	stp	x10, x9, [x0, #48]
	str	x11, [x0, #64]
	mov	x0, x8
	ret
.Lfunc_end24:
	.size	mclb_add9, .Lfunc_end24-mclb_add9
                                        // -- End function
	.globl	mclb_sub9                       // -- Begin function mclb_sub9
	.p2align	2
	.type	mclb_sub9,@function
mclb_sub9:                              // @mclb_sub9
// %bb.0:
	ldr	x16, [x1]
	ldp	x4, x3, [x2]
	ldp	x15, x14, [x1, #8]
	ldp	x6, x5, [x2, #16]
	ldp	x13, x12, [x1, #24]
	ldp	x9, x8, [x1, #56]
	ldp	x11, x10, [x1, #40]
	ldp	x18, x17, [x2, #56]
	ldp	x7, x1, [x2, #40]
	ldr	x2, [x2, #32]
	subs	x16, x16, x4
	sbcs	x15, x15, x3
	sbcs	x14, x14, x6
	sbcs	x13, x13, x5
	sbcs	x12, x12, x2
	sbcs	x11, x11, x7
	sbcs	x10, x10, x1
	sbcs	x9, x9, x18
	stp	x12, x11, [x0, #32]
	sbcs	x11, x8, x17
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x16, x15, [x0]
	stp	x14, x13, [x0, #16]
	stp	x10, x9, [x0, #48]
	str	x11, [x0, #64]
	mov	x0, x8
	ret
.Lfunc_end25:
	.size	mclb_sub9, .Lfunc_end25-mclb_sub9
                                        // -- End function
	.globl	mclb_addNF9                     // -- Begin function mclb_addNF9
	.p2align	2
	.type	mclb_addNF9,@function
mclb_addNF9:                            // @mclb_addNF9
// %bb.0:
	ldr	x16, [x1]
	ldp	x4, x3, [x2]
	ldp	x15, x14, [x1, #8]
	ldp	x6, x5, [x2, #16]
	ldp	x13, x12, [x1, #24]
	ldp	x9, x8, [x1, #56]
	ldp	x11, x10, [x1, #40]
	ldp	x18, x17, [x2, #56]
	ldp	x7, x1, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x16, x4, x16
	adcs	x15, x3, x15
	adcs	x14, x6, x14
	adcs	x13, x5, x13
	adcs	x12, x2, x12
	adcs	x11, x7, x11
	adcs	x10, x1, x10
	adcs	x9, x18, x9
	adcs	x8, x17, x8
	stp	x16, x15, [x0]
	stp	x14, x13, [x0, #16]
	stp	x12, x11, [x0, #32]
	stp	x10, x9, [x0, #48]
	str	x8, [x0, #64]
	ret
.Lfunc_end26:
	.size	mclb_addNF9, .Lfunc_end26-mclb_addNF9
                                        // -- End function
	.globl	mclb_add10                      // -- Begin function mclb_add10
	.p2align	2
	.type	mclb_add10,@function
mclb_add10:                             // @mclb_add10
// %bb.0:
	stp	x20, x19, [sp, #-16]!           // 16-byte Folded Spill
	ldp	x17, x16, [x1]
	ldp	x6, x5, [x2]
	ldp	x15, x14, [x1, #16]
	ldp	x19, x7, [x2, #16]
	ldp	x9, x8, [x1, #64]
	ldp	x11, x10, [x1, #48]
	ldp	x13, x12, [x1, #32]
	ldp	x1, x18, [x2, #64]
	ldp	x4, x3, [x2, #48]
	ldp	x2, x20, [x2, #32]
	adds	x17, x6, x17
	adcs	x16, x5, x16
	adcs	x15, x19, x15
	adcs	x14, x7, x14
	adcs	x13, x2, x13
	adcs	x12, x20, x12
	adcs	x11, x4, x11
	adcs	x10, x3, x10
	adcs	x9, x1, x9
	stp	x11, x10, [x0, #48]
	adcs	x10, x18, x8
	adcs	x8, xzr, xzr
	stp	x17, x16, [x0]
	stp	x15, x14, [x0, #16]
	stp	x13, x12, [x0, #32]
	stp	x9, x10, [x0, #64]
	mov	x0, x8
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end27:
	.size	mclb_add10, .Lfunc_end27-mclb_add10
                                        // -- End function
	.globl	mclb_sub10                      // -- Begin function mclb_sub10
	.p2align	2
	.type	mclb_sub10,@function
mclb_sub10:                             // @mclb_sub10
// %bb.0:
	stp	x20, x19, [sp, #-16]!           // 16-byte Folded Spill
	ldp	x17, x16, [x1]
	ldp	x6, x5, [x2]
	ldp	x15, x14, [x1, #16]
	ldp	x19, x7, [x2, #16]
	ldp	x9, x8, [x1, #64]
	ldp	x11, x10, [x1, #48]
	ldp	x13, x12, [x1, #32]
	ldp	x1, x18, [x2, #64]
	ldp	x4, x3, [x2, #48]
	ldp	x2, x20, [x2, #32]
	subs	x17, x17, x6
	sbcs	x16, x16, x5
	sbcs	x15, x15, x19
	sbcs	x14, x14, x7
	sbcs	x13, x13, x2
	sbcs	x12, x12, x20
	sbcs	x11, x11, x4
	sbcs	x10, x10, x3
	sbcs	x9, x9, x1
	stp	x11, x10, [x0, #48]
	sbcs	x10, x8, x18
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x17, x16, [x0]
	stp	x15, x14, [x0, #16]
	stp	x13, x12, [x0, #32]
	stp	x9, x10, [x0, #64]
	mov	x0, x8
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end28:
	.size	mclb_sub10, .Lfunc_end28-mclb_sub10
                                        // -- End function
	.globl	mclb_addNF10                    // -- Begin function mclb_addNF10
	.p2align	2
	.type	mclb_addNF10,@function
mclb_addNF10:                           // @mclb_addNF10
// %bb.0:
	stp	x20, x19, [sp, #-16]!           // 16-byte Folded Spill
	ldp	x17, x16, [x1]
	ldp	x6, x5, [x2]
	ldp	x15, x14, [x1, #16]
	ldp	x19, x7, [x2, #16]
	ldp	x9, x8, [x1, #64]
	ldp	x11, x10, [x1, #48]
	ldp	x13, x12, [x1, #32]
	ldp	x1, x18, [x2, #64]
	ldp	x4, x3, [x2, #48]
	ldp	x2, x20, [x2, #32]
	adds	x17, x6, x17
	adcs	x16, x5, x16
	adcs	x15, x19, x15
	adcs	x14, x7, x14
	adcs	x13, x2, x13
	adcs	x12, x20, x12
	adcs	x11, x4, x11
	adcs	x10, x3, x10
	adcs	x9, x1, x9
	adcs	x8, x18, x8
	stp	x17, x16, [x0]
	stp	x15, x14, [x0, #16]
	stp	x13, x12, [x0, #32]
	stp	x11, x10, [x0, #48]
	stp	x9, x8, [x0, #64]
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end29:
	.size	mclb_addNF10, .Lfunc_end29-mclb_addNF10
                                        // -- End function
	.globl	mclb_add11                      // -- Begin function mclb_add11
	.p2align	2
	.type	mclb_add11,@function
mclb_add11:                             // @mclb_add11
// %bb.0:
	stp	x22, x21, [sp, #-32]!           // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	ldr	x18, [x1]
	ldp	x19, x7, [x2]
	ldp	x17, x16, [x1, #8]
	ldp	x21, x20, [x2, #16]
	ldp	x15, x14, [x1, #24]
	ldp	x9, x8, [x1, #72]
	ldp	x11, x10, [x1, #56]
	ldp	x13, x12, [x1, #40]
	ldp	x3, x1, [x2, #72]
	ldp	x5, x4, [x2, #56]
	ldp	x22, x6, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x18, x19, x18
	adcs	x17, x7, x17
	adcs	x16, x21, x16
	adcs	x15, x20, x15
	adcs	x14, x2, x14
	adcs	x13, x22, x13
	adcs	x12, x6, x12
	adcs	x11, x5, x11
	adcs	x10, x4, x10
	adcs	x9, x3, x9
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #48]
	adcs	x11, x1, x8
	adcs	x8, xzr, xzr
	stp	x18, x17, [x0]
	stp	x16, x15, [x0, #16]
	stp	x14, x13, [x0, #32]
	stp	x10, x9, [x0, #64]
	str	x11, [x0, #80]
	mov	x0, x8
	ldp	x22, x21, [sp], #32             // 16-byte Folded Reload
	ret
.Lfunc_end30:
	.size	mclb_add11, .Lfunc_end30-mclb_add11
                                        // -- End function
	.globl	mclb_sub11                      // -- Begin function mclb_sub11
	.p2align	2
	.type	mclb_sub11,@function
mclb_sub11:                             // @mclb_sub11
// %bb.0:
	stp	x22, x21, [sp, #-32]!           // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	ldr	x18, [x1]
	ldp	x19, x7, [x2]
	ldp	x17, x16, [x1, #8]
	ldp	x21, x20, [x2, #16]
	ldp	x15, x14, [x1, #24]
	ldp	x9, x8, [x1, #72]
	ldp	x11, x10, [x1, #56]
	ldp	x13, x12, [x1, #40]
	ldp	x3, x1, [x2, #72]
	ldp	x5, x4, [x2, #56]
	ldp	x22, x6, [x2, #40]
	ldr	x2, [x2, #32]
	subs	x18, x18, x19
	sbcs	x17, x17, x7
	sbcs	x16, x16, x21
	sbcs	x15, x15, x20
	sbcs	x14, x14, x2
	sbcs	x13, x13, x22
	sbcs	x12, x12, x6
	sbcs	x11, x11, x5
	sbcs	x10, x10, x4
	sbcs	x9, x9, x3
	stp	x12, x11, [x0, #48]
	sbcs	x11, x8, x1
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x18, x17, [x0]
	stp	x16, x15, [x0, #16]
	stp	x14, x13, [x0, #32]
	stp	x10, x9, [x0, #64]
	str	x11, [x0, #80]
	mov	x0, x8
	ldp	x22, x21, [sp], #32             // 16-byte Folded Reload
	ret
.Lfunc_end31:
	.size	mclb_sub11, .Lfunc_end31-mclb_sub11
                                        // -- End function
	.globl	mclb_addNF11                    // -- Begin function mclb_addNF11
	.p2align	2
	.type	mclb_addNF11,@function
mclb_addNF11:                           // @mclb_addNF11
// %bb.0:
	stp	x22, x21, [sp, #-32]!           // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	ldr	x18, [x1]
	ldp	x19, x7, [x2]
	ldp	x17, x16, [x1, #8]
	ldp	x21, x20, [x2, #16]
	ldp	x15, x14, [x1, #24]
	ldp	x9, x8, [x1, #72]
	ldp	x11, x10, [x1, #56]
	ldp	x13, x12, [x1, #40]
	ldp	x3, x1, [x2, #72]
	ldp	x5, x4, [x2, #56]
	ldp	x22, x6, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x18, x19, x18
	adcs	x17, x7, x17
	adcs	x16, x21, x16
	adcs	x15, x20, x15
	adcs	x14, x2, x14
	adcs	x13, x22, x13
	adcs	x12, x6, x12
	adcs	x11, x5, x11
	adcs	x10, x4, x10
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x3, x9
	adcs	x8, x1, x8
	stp	x18, x17, [x0]
	stp	x16, x15, [x0, #16]
	stp	x14, x13, [x0, #32]
	stp	x12, x11, [x0, #48]
	stp	x10, x9, [x0, #64]
	str	x8, [x0, #80]
	ldp	x22, x21, [sp], #32             // 16-byte Folded Reload
	ret
.Lfunc_end32:
	.size	mclb_addNF11, .Lfunc_end32-mclb_addNF11
                                        // -- End function
	.globl	mclb_add12                      // -- Begin function mclb_add12
	.p2align	2
	.type	mclb_add12,@function
mclb_add12:                             // @mclb_add12
// %bb.0:
	stp	x24, x23, [sp, #-48]!           // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #80]
	ldp	x11, x10, [x1, #64]
	ldp	x13, x12, [x1, #48]
	ldp	x15, x14, [x1, #32]
	ldp	x17, x16, [x1, #16]
	ldp	x1, x18, [x1]
	ldp	x21, x20, [x2]
	ldp	x23, x22, [x2, #16]
	ldp	x4, x3, [x2, #80]
	ldp	x6, x5, [x2, #64]
	ldp	x19, x7, [x2, #48]
	ldp	x2, x24, [x2, #32]
	adds	x1, x21, x1
	adcs	x18, x20, x18
	adcs	x17, x23, x17
	adcs	x16, x22, x16
	adcs	x15, x2, x15
	adcs	x14, x24, x14
	adcs	x13, x19, x13
	adcs	x12, x7, x12
	adcs	x11, x6, x11
	adcs	x10, x5, x10
	adcs	x9, x4, x9
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	stp	x11, x10, [x0, #64]
	adcs	x10, x3, x8
	adcs	x8, xzr, xzr
	stp	x1, x18, [x0]
	stp	x17, x16, [x0, #16]
	stp	x15, x14, [x0, #32]
	stp	x13, x12, [x0, #48]
	stp	x9, x10, [x0, #80]
	mov	x0, x8
	ldp	x24, x23, [sp], #48             // 16-byte Folded Reload
	ret
.Lfunc_end33:
	.size	mclb_add12, .Lfunc_end33-mclb_add12
                                        // -- End function
	.globl	mclb_sub12                      // -- Begin function mclb_sub12
	.p2align	2
	.type	mclb_sub12,@function
mclb_sub12:                             // @mclb_sub12
// %bb.0:
	stp	x24, x23, [sp, #-48]!           // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #80]
	ldp	x11, x10, [x1, #64]
	ldp	x13, x12, [x1, #48]
	ldp	x15, x14, [x1, #32]
	ldp	x17, x16, [x1, #16]
	ldp	x1, x18, [x1]
	ldp	x21, x20, [x2]
	ldp	x23, x22, [x2, #16]
	ldp	x4, x3, [x2, #80]
	ldp	x6, x5, [x2, #64]
	ldp	x19, x7, [x2, #48]
	ldp	x2, x24, [x2, #32]
	subs	x1, x1, x21
	sbcs	x18, x18, x20
	sbcs	x17, x17, x23
	sbcs	x16, x16, x22
	sbcs	x15, x15, x2
	sbcs	x14, x14, x24
	sbcs	x13, x13, x19
	sbcs	x12, x12, x7
	sbcs	x11, x11, x6
	sbcs	x10, x10, x5
	sbcs	x9, x9, x4
	stp	x11, x10, [x0, #64]
	sbcs	x10, x8, x3
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x1, x18, [x0]
	stp	x17, x16, [x0, #16]
	stp	x15, x14, [x0, #32]
	stp	x13, x12, [x0, #48]
	stp	x9, x10, [x0, #80]
	mov	x0, x8
	ldp	x24, x23, [sp], #48             // 16-byte Folded Reload
	ret
.Lfunc_end34:
	.size	mclb_sub12, .Lfunc_end34-mclb_sub12
                                        // -- End function
	.globl	mclb_addNF12                    // -- Begin function mclb_addNF12
	.p2align	2
	.type	mclb_addNF12,@function
mclb_addNF12:                           // @mclb_addNF12
// %bb.0:
	stp	x24, x23, [sp, #-48]!           // 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #80]
	ldp	x11, x10, [x1, #64]
	ldp	x13, x12, [x1, #48]
	ldp	x15, x14, [x1, #32]
	ldp	x17, x16, [x1, #16]
	ldp	x1, x18, [x1]
	ldp	x21, x20, [x2]
	ldp	x23, x22, [x2, #16]
	ldp	x4, x3, [x2, #80]
	ldp	x6, x5, [x2, #64]
	ldp	x19, x7, [x2, #48]
	ldp	x2, x24, [x2, #32]
	adds	x1, x21, x1
	adcs	x18, x20, x18
	adcs	x17, x23, x17
	adcs	x16, x22, x16
	adcs	x15, x2, x15
	adcs	x14, x24, x14
	adcs	x13, x19, x13
	adcs	x12, x7, x12
	adcs	x11, x6, x11
	adcs	x10, x5, x10
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x4, x9
	adcs	x8, x3, x8
	stp	x1, x18, [x0]
	stp	x17, x16, [x0, #16]
	stp	x15, x14, [x0, #32]
	stp	x13, x12, [x0, #48]
	stp	x11, x10, [x0, #64]
	stp	x9, x8, [x0, #80]
	ldp	x24, x23, [sp], #48             // 16-byte Folded Reload
	ret
.Lfunc_end35:
	.size	mclb_addNF12, .Lfunc_end35-mclb_addNF12
                                        // -- End function
	.globl	mclb_add13                      // -- Begin function mclb_add13
	.p2align	2
	.type	mclb_add13,@function
mclb_add13:                             // @mclb_add13
// %bb.0:
	stp	x26, x25, [sp, #-64]!           // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #88]
	ldp	x11, x10, [x1, #72]
	ldp	x13, x12, [x1, #56]
	ldp	x15, x14, [x1, #40]
	ldp	x17, x16, [x1, #24]
	ldp	x3, x18, [x1, #8]
	ldr	x1, [x1]
	ldp	x23, x22, [x2]
	ldp	x25, x24, [x2, #16]
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	ldp	x5, x4, [x2, #88]
	ldp	x7, x6, [x2, #72]
	ldp	x20, x19, [x2, #56]
	ldp	x26, x21, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x1, x23, x1
	adcs	x3, x22, x3
	adcs	x18, x25, x18
	adcs	x17, x24, x17
	adcs	x16, x2, x16
	adcs	x15, x26, x15
	adcs	x14, x21, x14
	adcs	x13, x20, x13
	adcs	x12, x19, x12
	adcs	x11, x7, x11
	adcs	x10, x6, x10
	adcs	x9, x5, x9
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #64]
	adcs	x11, x4, x8
	adcs	x8, xzr, xzr
	stp	x1, x3, [x0]
	stp	x18, x17, [x0, #16]
	stp	x16, x15, [x0, #32]
	stp	x14, x13, [x0, #48]
	stp	x10, x9, [x0, #80]
	str	x11, [x0, #96]
	mov	x0, x8
	ldp	x26, x25, [sp], #64             // 16-byte Folded Reload
	ret
.Lfunc_end36:
	.size	mclb_add13, .Lfunc_end36-mclb_add13
                                        // -- End function
	.globl	mclb_sub13                      // -- Begin function mclb_sub13
	.p2align	2
	.type	mclb_sub13,@function
mclb_sub13:                             // @mclb_sub13
// %bb.0:
	stp	x26, x25, [sp, #-64]!           // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #88]
	ldp	x11, x10, [x1, #72]
	ldp	x13, x12, [x1, #56]
	ldp	x15, x14, [x1, #40]
	ldp	x17, x16, [x1, #24]
	ldp	x3, x18, [x1, #8]
	ldr	x1, [x1]
	ldp	x23, x22, [x2]
	ldp	x25, x24, [x2, #16]
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	ldp	x5, x4, [x2, #88]
	ldp	x7, x6, [x2, #72]
	ldp	x20, x19, [x2, #56]
	ldp	x26, x21, [x2, #40]
	ldr	x2, [x2, #32]
	subs	x1, x1, x23
	sbcs	x3, x3, x22
	sbcs	x18, x18, x25
	sbcs	x17, x17, x24
	sbcs	x16, x16, x2
	sbcs	x15, x15, x26
	sbcs	x14, x14, x21
	sbcs	x13, x13, x20
	sbcs	x12, x12, x19
	sbcs	x11, x11, x7
	sbcs	x10, x10, x6
	sbcs	x9, x9, x5
	stp	x12, x11, [x0, #64]
	sbcs	x11, x8, x4
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x1, x3, [x0]
	stp	x18, x17, [x0, #16]
	stp	x16, x15, [x0, #32]
	stp	x14, x13, [x0, #48]
	stp	x10, x9, [x0, #80]
	str	x11, [x0, #96]
	mov	x0, x8
	ldp	x26, x25, [sp], #64             // 16-byte Folded Reload
	ret
.Lfunc_end37:
	.size	mclb_sub13, .Lfunc_end37-mclb_sub13
                                        // -- End function
	.globl	mclb_addNF13                    // -- Begin function mclb_addNF13
	.p2align	2
	.type	mclb_addNF13,@function
mclb_addNF13:                           // @mclb_addNF13
// %bb.0:
	stp	x26, x25, [sp, #-64]!           // 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #88]
	ldp	x11, x10, [x1, #72]
	ldp	x13, x12, [x1, #56]
	ldp	x15, x14, [x1, #40]
	ldp	x17, x16, [x1, #24]
	ldp	x3, x18, [x1, #8]
	ldr	x1, [x1]
	ldp	x23, x22, [x2]
	ldp	x25, x24, [x2, #16]
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	ldp	x5, x4, [x2, #88]
	ldp	x7, x6, [x2, #72]
	ldp	x20, x19, [x2, #56]
	ldp	x26, x21, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x1, x23, x1
	adcs	x3, x22, x3
	adcs	x18, x25, x18
	adcs	x17, x24, x17
	adcs	x16, x2, x16
	adcs	x15, x26, x15
	adcs	x14, x21, x14
	adcs	x13, x20, x13
	adcs	x12, x19, x12
	adcs	x11, x7, x11
	adcs	x10, x6, x10
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x5, x9
	adcs	x8, x4, x8
	stp	x1, x3, [x0]
	stp	x18, x17, [x0, #16]
	stp	x16, x15, [x0, #32]
	stp	x14, x13, [x0, #48]
	stp	x12, x11, [x0, #64]
	stp	x10, x9, [x0, #80]
	str	x8, [x0, #96]
	ldp	x26, x25, [sp], #64             // 16-byte Folded Reload
	ret
.Lfunc_end38:
	.size	mclb_addNF13, .Lfunc_end38-mclb_addNF13
                                        // -- End function
	.globl	mclb_add14                      // -- Begin function mclb_add14
	.p2align	2
	.type	mclb_add14,@function
mclb_add14:                             // @mclb_add14
// %bb.0:
	stp	x28, x27, [sp, #-80]!           // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #96]
	ldp	x11, x10, [x1, #80]
	ldp	x13, x12, [x1, #64]
	ldp	x15, x14, [x1, #48]
	ldp	x17, x16, [x1, #32]
	ldp	x3, x18, [x1, #16]
	ldp	x1, x4, [x1]
	ldp	x25, x24, [x2]
	ldp	x27, x26, [x2, #16]
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	ldp	x6, x5, [x2, #96]
	ldp	x19, x7, [x2, #80]
	ldp	x21, x20, [x2, #64]
	ldp	x23, x22, [x2, #48]
	ldp	x2, x28, [x2, #32]
	adds	x1, x25, x1
	adcs	x4, x24, x4
	adcs	x3, x27, x3
	adcs	x18, x26, x18
	adcs	x17, x2, x17
	adcs	x16, x28, x16
	adcs	x15, x23, x15
	adcs	x14, x22, x14
	adcs	x13, x21, x13
	adcs	x12, x20, x12
	adcs	x11, x19, x11
	adcs	x10, x7, x10
	adcs	x9, x6, x9
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	stp	x11, x10, [x0, #80]
	adcs	x10, x5, x8
	adcs	x8, xzr, xzr
	stp	x1, x4, [x0]
	stp	x3, x18, [x0, #16]
	stp	x17, x16, [x0, #32]
	stp	x15, x14, [x0, #48]
	stp	x13, x12, [x0, #64]
	stp	x9, x10, [x0, #96]
	mov	x0, x8
	ldp	x28, x27, [sp], #80             // 16-byte Folded Reload
	ret
.Lfunc_end39:
	.size	mclb_add14, .Lfunc_end39-mclb_add14
                                        // -- End function
	.globl	mclb_sub14                      // -- Begin function mclb_sub14
	.p2align	2
	.type	mclb_sub14,@function
mclb_sub14:                             // @mclb_sub14
// %bb.0:
	stp	x28, x27, [sp, #-80]!           // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #96]
	ldp	x11, x10, [x1, #80]
	ldp	x13, x12, [x1, #64]
	ldp	x15, x14, [x1, #48]
	ldp	x17, x16, [x1, #32]
	ldp	x3, x18, [x1, #16]
	ldp	x1, x4, [x1]
	ldp	x25, x24, [x2]
	ldp	x27, x26, [x2, #16]
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	ldp	x6, x5, [x2, #96]
	ldp	x19, x7, [x2, #80]
	ldp	x21, x20, [x2, #64]
	ldp	x23, x22, [x2, #48]
	ldp	x2, x28, [x2, #32]
	subs	x1, x1, x25
	sbcs	x4, x4, x24
	sbcs	x3, x3, x27
	sbcs	x18, x18, x26
	sbcs	x17, x17, x2
	sbcs	x16, x16, x28
	sbcs	x15, x15, x23
	sbcs	x14, x14, x22
	sbcs	x13, x13, x21
	sbcs	x12, x12, x20
	sbcs	x11, x11, x19
	sbcs	x10, x10, x7
	sbcs	x9, x9, x6
	stp	x11, x10, [x0, #80]
	sbcs	x10, x8, x5
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x1, x4, [x0]
	stp	x3, x18, [x0, #16]
	stp	x17, x16, [x0, #32]
	stp	x15, x14, [x0, #48]
	stp	x13, x12, [x0, #64]
	stp	x9, x10, [x0, #96]
	mov	x0, x8
	ldp	x28, x27, [sp], #80             // 16-byte Folded Reload
	ret
.Lfunc_end40:
	.size	mclb_sub14, .Lfunc_end40-mclb_sub14
                                        // -- End function
	.globl	mclb_addNF14                    // -- Begin function mclb_addNF14
	.p2align	2
	.type	mclb_addNF14,@function
mclb_addNF14:                           // @mclb_addNF14
// %bb.0:
	stp	x28, x27, [sp, #-80]!           // 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #96]
	ldp	x11, x10, [x1, #80]
	ldp	x13, x12, [x1, #64]
	ldp	x15, x14, [x1, #48]
	ldp	x17, x16, [x1, #32]
	ldp	x3, x18, [x1, #16]
	ldp	x1, x4, [x1]
	ldp	x25, x24, [x2]
	ldp	x27, x26, [x2, #16]
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	ldp	x6, x5, [x2, #96]
	ldp	x19, x7, [x2, #80]
	ldp	x21, x20, [x2, #64]
	ldp	x23, x22, [x2, #48]
	ldp	x2, x28, [x2, #32]
	adds	x1, x25, x1
	adcs	x4, x24, x4
	adcs	x3, x27, x3
	adcs	x18, x26, x18
	adcs	x17, x2, x17
	adcs	x16, x28, x16
	adcs	x15, x23, x15
	adcs	x14, x22, x14
	adcs	x13, x21, x13
	adcs	x12, x20, x12
	adcs	x11, x19, x11
	adcs	x10, x7, x10
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x6, x9
	adcs	x8, x5, x8
	stp	x1, x4, [x0]
	stp	x3, x18, [x0, #16]
	stp	x17, x16, [x0, #32]
	stp	x15, x14, [x0, #48]
	stp	x13, x12, [x0, #64]
	stp	x11, x10, [x0, #80]
	stp	x9, x8, [x0, #96]
	ldp	x28, x27, [sp], #80             // 16-byte Folded Reload
	ret
.Lfunc_end41:
	.size	mclb_addNF14, .Lfunc_end41-mclb_addNF14
                                        // -- End function
	.globl	mclb_add15                      // -- Begin function mclb_add15
	.p2align	2
	.type	mclb_add15,@function
mclb_add15:                             // @mclb_add15
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #104]
	ldp	x11, x10, [x1, #88]
	ldp	x13, x12, [x1, #72]
	ldp	x15, x14, [x1, #56]
	ldp	x17, x16, [x1, #40]
	ldp	x3, x18, [x1, #24]
	ldp	x5, x4, [x1, #8]
	ldr	x1, [x1]
	ldp	x27, x26, [x2]
	ldp	x29, x28, [x2, #16]
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x7, x6, [x2, #104]
	ldp	x20, x19, [x2, #88]
	ldp	x22, x21, [x2, #72]
	ldp	x24, x23, [x2, #56]
	ldp	x30, x25, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x1, x27, x1
	adcs	x5, x26, x5
	adcs	x4, x29, x4
	stp	x1, x5, [x0]
	adcs	x1, x28, x3
	adcs	x18, x2, x18
	adcs	x17, x30, x17
	adcs	x16, x25, x16
	adcs	x15, x24, x15
	adcs	x14, x23, x14
	adcs	x13, x22, x13
	adcs	x12, x21, x12
	adcs	x11, x20, x11
	adcs	x10, x19, x10
	adcs	x9, x7, x9
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #80]
	adcs	x11, x6, x8
	adcs	x8, xzr, xzr
	stp	x4, x1, [x0, #16]
	stp	x18, x17, [x0, #32]
	stp	x16, x15, [x0, #48]
	stp	x14, x13, [x0, #64]
	stp	x10, x9, [x0, #96]
	str	x11, [x0, #112]
	mov	x0, x8
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end42:
	.size	mclb_add15, .Lfunc_end42-mclb_add15
                                        // -- End function
	.globl	mclb_sub15                      // -- Begin function mclb_sub15
	.p2align	2
	.type	mclb_sub15,@function
mclb_sub15:                             // @mclb_sub15
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #104]
	ldp	x11, x10, [x1, #88]
	ldp	x13, x12, [x1, #72]
	ldp	x15, x14, [x1, #56]
	ldp	x17, x16, [x1, #40]
	ldp	x3, x18, [x1, #24]
	ldp	x5, x4, [x1, #8]
	ldr	x1, [x1]
	ldp	x27, x26, [x2]
	ldp	x29, x28, [x2, #16]
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x7, x6, [x2, #104]
	ldp	x20, x19, [x2, #88]
	ldp	x22, x21, [x2, #72]
	ldp	x24, x23, [x2, #56]
	ldp	x30, x25, [x2, #40]
	ldr	x2, [x2, #32]
	subs	x1, x1, x27
	sbcs	x5, x5, x26
	sbcs	x4, x4, x29
	stp	x1, x5, [x0]
	sbcs	x1, x3, x28
	sbcs	x18, x18, x2
	sbcs	x17, x17, x30
	sbcs	x16, x16, x25
	sbcs	x15, x15, x24
	sbcs	x14, x14, x23
	sbcs	x13, x13, x22
	sbcs	x12, x12, x21
	sbcs	x11, x11, x20
	sbcs	x10, x10, x19
	sbcs	x9, x9, x7
	stp	x12, x11, [x0, #80]
	sbcs	x11, x8, x6
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x4, x1, [x0, #16]
	stp	x18, x17, [x0, #32]
	stp	x16, x15, [x0, #48]
	stp	x14, x13, [x0, #64]
	stp	x10, x9, [x0, #96]
	str	x11, [x0, #112]
	mov	x0, x8
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end43:
	.size	mclb_sub15, .Lfunc_end43-mclb_sub15
                                        // -- End function
	.globl	mclb_addNF15                    // -- Begin function mclb_addNF15
	.p2align	2
	.type	mclb_addNF15,@function
mclb_addNF15:                           // @mclb_addNF15
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	ldp	x9, x8, [x1, #104]
	ldp	x11, x10, [x1, #88]
	ldp	x13, x12, [x1, #72]
	ldp	x15, x14, [x1, #56]
	ldp	x17, x16, [x1, #40]
	ldp	x3, x18, [x1, #24]
	ldp	x5, x4, [x1, #8]
	ldr	x1, [x1]
	ldp	x27, x26, [x2]
	ldp	x29, x28, [x2, #16]
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x7, x6, [x2, #104]
	ldp	x20, x19, [x2, #88]
	ldp	x22, x21, [x2, #72]
	ldp	x24, x23, [x2, #56]
	ldp	x30, x25, [x2, #40]
	ldr	x2, [x2, #32]
	adds	x1, x27, x1
	adcs	x5, x26, x5
	adcs	x4, x29, x4
	stp	x1, x5, [x0]
	adcs	x1, x28, x3
	adcs	x18, x2, x18
	adcs	x17, x30, x17
	adcs	x16, x25, x16
	adcs	x15, x24, x15
	adcs	x14, x23, x14
	adcs	x13, x22, x13
	adcs	x12, x21, x12
	adcs	x11, x20, x11
	adcs	x10, x19, x10
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x7, x9
	adcs	x8, x6, x8
	stp	x4, x1, [x0, #16]
	stp	x18, x17, [x0, #32]
	stp	x16, x15, [x0, #48]
	stp	x14, x13, [x0, #64]
	stp	x12, x11, [x0, #80]
	stp	x10, x9, [x0, #96]
	str	x8, [x0, #112]
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end44:
	.size	mclb_addNF15, .Lfunc_end44-mclb_addNF15
                                        // -- End function
	.globl	mclb_add16                      // -- Begin function mclb_add16
	.p2align	2
	.type	mclb_add16,@function
mclb_add16:                             // @mclb_add16
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	ldp	x9, x13, [x2, #112]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	adcs	x9, x9, x12
	adcs	x10, x13, x11
	adcs	x8, xzr, xzr
	stp	x9, x10, [x0, #112]
	mov	x0, x8
	ret
.Lfunc_end45:
	.size	mclb_add16, .Lfunc_end45-mclb_add16
                                        // -- End function
	.globl	mclb_sub16                      // -- Begin function mclb_sub16
	.p2align	2
	.type	mclb_sub16,@function
mclb_sub16:                             // @mclb_sub16
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	ldp	x9, x13, [x2, #112]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	sbcs	x9, x12, x9
	sbcs	x10, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x9, x10, [x0, #112]
	mov	x0, x8
	ret
.Lfunc_end46:
	.size	mclb_sub16, .Lfunc_end46-mclb_sub16
                                        // -- End function
	.globl	mclb_addNF16                    // -- Begin function mclb_addNF16
	.p2align	2
	.type	mclb_addNF16,@function
mclb_addNF16:                           // @mclb_addNF16
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	ldp	x9, x13, [x2, #112]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	adcs	x9, x9, x12
	adcs	x8, x13, x11
	stp	x9, x8, [x0, #112]
	ret
.Lfunc_end47:
	.size	mclb_addNF16, .Lfunc_end47-mclb_addNF16
                                        // -- End function
	.globl	mclb_add17                      // -- Begin function mclb_add17
	.p2align	2
	.type	mclb_add17,@function
mclb_add17:                             // @mclb_add17
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	ldp	x8, x10, [x1, #112]
	adcs	x11, x11, x13
	ldr	x13, [x2, #112]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #120]
	stp	x11, x9, [x0, #96]
	adcs	x8, x13, x8
	ldr	x13, [x1, #128]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #112]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end48:
	.size	mclb_add17, .Lfunc_end48-mclb_add17
                                        // -- End function
	.globl	mclb_sub17                      // -- Begin function mclb_sub17
	.p2align	2
	.type	mclb_sub17,@function
mclb_sub17:                             // @mclb_sub17
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	ldp	x8, x10, [x1, #112]
	sbcs	x11, x13, x11
	ldr	x13, [x2, #112]
	sbcs	x9, x9, x12
	ldp	x12, x14, [x2, #120]
	stp	x11, x9, [x0, #96]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #128]
	sbcs	x9, x10, x12
	stp	x8, x9, [x0, #112]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end49:
	.size	mclb_sub17, .Lfunc_end49-mclb_sub17
                                        // -- End function
	.globl	mclb_addNF17                    // -- Begin function mclb_addNF17
	.p2align	2
	.type	mclb_addNF17,@function
mclb_addNF17:                           // @mclb_addNF17
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	ldp	x8, x10, [x1, #112]
	adcs	x11, x11, x13
	ldr	x13, [x2, #112]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #120]
	stp	x11, x9, [x0, #96]
	adcs	x8, x13, x8
	ldr	x13, [x1, #128]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #112]
	adcs	x10, x14, x13
	str	x10, [x0, #128]
	ret
.Lfunc_end50:
	.size	mclb_addNF17, .Lfunc_end50-mclb_addNF17
                                        // -- End function
	.globl	mclb_add18                      // -- Begin function mclb_add18
	.p2align	2
	.type	mclb_add18,@function
mclb_add18:                             // @mclb_add18
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	ldp	x10, x13, [x2, #128]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	adcs	x10, x10, x12
	adcs	x9, x13, x11
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end51:
	.size	mclb_add18, .Lfunc_end51-mclb_add18
                                        // -- End function
	.globl	mclb_sub18                      // -- Begin function mclb_sub18
	.p2align	2
	.type	mclb_sub18,@function
mclb_sub18:                             // @mclb_sub18
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	ldp	x10, x13, [x2, #128]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end52:
	.size	mclb_sub18, .Lfunc_end52-mclb_sub18
                                        // -- End function
	.globl	mclb_addNF18                    // -- Begin function mclb_addNF18
	.p2align	2
	.type	mclb_addNF18,@function
mclb_addNF18:                           // @mclb_addNF18
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	ldp	x10, x13, [x2, #128]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	adcs	x10, x10, x12
	adcs	x8, x13, x11
	stp	x10, x8, [x0, #128]
	ret
.Lfunc_end53:
	.size	mclb_addNF18, .Lfunc_end53-mclb_addNF18
                                        // -- End function
	.globl	mclb_add19                      // -- Begin function mclb_add19
	.p2align	2
	.type	mclb_add19,@function
mclb_add19:                             // @mclb_add19
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x10, x10, x13
	ldr	x13, [x2, #128]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #128]
	ldp	x12, x14, [x2, #136]
	stp	x10, x9, [x0, #112]
	adcs	x8, x13, x8
	ldr	x13, [x1, #144]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #128]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #144]
	mov	x0, x8
	ret
.Lfunc_end54:
	.size	mclb_add19, .Lfunc_end54-mclb_add19
                                        // -- End function
	.globl	mclb_sub19                      // -- Begin function mclb_sub19
	.p2align	2
	.type	mclb_sub19,@function
mclb_sub19:                             // @mclb_sub19
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x10, x13, x10
	ldr	x13, [x2, #128]
	sbcs	x9, x11, x12
	ldp	x8, x11, [x1, #128]
	ldp	x12, x14, [x2, #136]
	stp	x10, x9, [x0, #112]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #144]
	sbcs	x9, x11, x12
	stp	x8, x9, [x0, #128]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #144]
	mov	x0, x8
	ret
.Lfunc_end55:
	.size	mclb_sub19, .Lfunc_end55-mclb_sub19
                                        // -- End function
	.globl	mclb_addNF19                    // -- Begin function mclb_addNF19
	.p2align	2
	.type	mclb_addNF19,@function
mclb_addNF19:                           // @mclb_addNF19
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x10, x10, x13
	ldr	x13, [x2, #128]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #128]
	ldp	x12, x14, [x2, #136]
	stp	x10, x9, [x0, #112]
	adcs	x8, x13, x8
	ldr	x13, [x1, #144]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #128]
	adcs	x10, x14, x13
	str	x10, [x0, #144]
	ret
.Lfunc_end56:
	.size	mclb_addNF19, .Lfunc_end56-mclb_addNF19
                                        // -- End function
	.globl	mclb_add20                      // -- Begin function mclb_add20
	.p2align	2
	.type	mclb_add20,@function
mclb_add20:                             // @mclb_add20
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	ldp	x8, x13, [x2, #144]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #144]
	adcs	x8, xzr, xzr
	mov	x0, x8
	ret
.Lfunc_end57:
	.size	mclb_add20, .Lfunc_end57-mclb_add20
                                        // -- End function
	.globl	mclb_sub20                      // -- Begin function mclb_sub20
	.p2align	2
	.type	mclb_sub20,@function
mclb_sub20:                             // @mclb_sub20
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	ldp	x8, x13, [x2, #144]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	sbcs	x8, x12, x8
	sbcs	x9, x11, x13
	stp	x8, x9, [x0, #144]
	ngcs	x8, xzr
	and	x8, x8, #0x1
	mov	x0, x8
	ret
.Lfunc_end58:
	.size	mclb_sub20, .Lfunc_end58-mclb_sub20
                                        // -- End function
	.globl	mclb_addNF20                    // -- Begin function mclb_addNF20
	.p2align	2
	.type	mclb_addNF20,@function
mclb_addNF20:                           // @mclb_addNF20
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	ldp	x8, x13, [x2, #144]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #144]
	ret
.Lfunc_end59:
	.size	mclb_addNF20, .Lfunc_end59-mclb_addNF20
                                        // -- End function
	.globl	mclb_add21                      // -- Begin function mclb_add21
	.p2align	2
	.type	mclb_add21,@function
mclb_add21:                             // @mclb_add21
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	ldp	x8, x11, [x1, #144]
	adcs	x9, x9, x13
	ldr	x13, [x2, #144]
	adcs	x10, x12, x10
	ldp	x12, x14, [x2, #152]
	stp	x9, x10, [x0, #128]
	adcs	x8, x13, x8
	ldr	x13, [x1, #160]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #144]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end60:
	.size	mclb_add21, .Lfunc_end60-mclb_add21
                                        // -- End function
	.globl	mclb_sub21                      // -- Begin function mclb_sub21
	.p2align	2
	.type	mclb_sub21,@function
mclb_sub21:                             // @mclb_sub21
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	ldp	x8, x11, [x1, #144]
	sbcs	x9, x13, x9
	ldr	x13, [x2, #144]
	sbcs	x10, x10, x12
	ldp	x12, x14, [x2, #152]
	stp	x9, x10, [x0, #128]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #160]
	sbcs	x9, x11, x12
	stp	x8, x9, [x0, #144]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end61:
	.size	mclb_sub21, .Lfunc_end61-mclb_sub21
                                        // -- End function
	.globl	mclb_addNF21                    // -- Begin function mclb_addNF21
	.p2align	2
	.type	mclb_addNF21,@function
mclb_addNF21:                           // @mclb_addNF21
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	ldp	x8, x11, [x1, #144]
	adcs	x9, x9, x13
	ldr	x13, [x2, #144]
	adcs	x10, x12, x10
	ldp	x12, x14, [x2, #152]
	stp	x9, x10, [x0, #128]
	adcs	x8, x13, x8
	ldr	x13, [x1, #160]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #144]
	adcs	x10, x14, x13
	str	x10, [x0, #160]
	ret
.Lfunc_end62:
	.size	mclb_addNF21, .Lfunc_end62-mclb_addNF21
                                        // -- End function
	.globl	mclb_add22                      // -- Begin function mclb_add22
	.p2align	2
	.type	mclb_add22,@function
mclb_add22:                             // @mclb_add22
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	ldp	x9, x13, [x2, #160]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	adcs	x9, x9, x12
	adcs	x10, x13, x11
	adcs	x8, xzr, xzr
	stp	x9, x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end63:
	.size	mclb_add22, .Lfunc_end63-mclb_add22
                                        // -- End function
	.globl	mclb_sub22                      // -- Begin function mclb_sub22
	.p2align	2
	.type	mclb_sub22,@function
mclb_sub22:                             // @mclb_sub22
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	ldp	x9, x13, [x2, #160]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	sbcs	x9, x12, x9
	sbcs	x10, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x9, x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end64:
	.size	mclb_sub22, .Lfunc_end64-mclb_sub22
                                        // -- End function
	.globl	mclb_addNF22                    // -- Begin function mclb_addNF22
	.p2align	2
	.type	mclb_addNF22,@function
mclb_addNF22:                           // @mclb_addNF22
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	ldp	x9, x13, [x2, #160]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	adcs	x9, x9, x12
	adcs	x8, x13, x11
	stp	x9, x8, [x0, #160]
	ret
.Lfunc_end65:
	.size	mclb_addNF22, .Lfunc_end65-mclb_addNF22
                                        // -- End function
	.globl	mclb_add23                      // -- Begin function mclb_add23
	.p2align	2
	.type	mclb_add23,@function
mclb_add23:                             // @mclb_add23
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	ldp	x8, x10, [x1, #160]
	adcs	x11, x11, x13
	ldr	x13, [x2, #160]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #168]
	stp	x11, x9, [x0, #144]
	adcs	x8, x13, x8
	ldr	x13, [x1, #176]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #160]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end66:
	.size	mclb_add23, .Lfunc_end66-mclb_add23
                                        // -- End function
	.globl	mclb_sub23                      // -- Begin function mclb_sub23
	.p2align	2
	.type	mclb_sub23,@function
mclb_sub23:                             // @mclb_sub23
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #144]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	ldp	x8, x10, [x1, #160]
	sbcs	x11, x13, x11
	ldr	x13, [x2, #160]
	sbcs	x9, x9, x12
	ldp	x12, x14, [x2, #168]
	stp	x11, x9, [x0, #144]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #176]
	sbcs	x9, x10, x12
	stp	x8, x9, [x0, #160]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end67:
	.size	mclb_sub23, .Lfunc_end67-mclb_sub23
                                        // -- End function
	.globl	mclb_addNF23                    // -- Begin function mclb_addNF23
	.p2align	2
	.type	mclb_addNF23,@function
mclb_addNF23:                           // @mclb_addNF23
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	ldp	x8, x10, [x1, #160]
	adcs	x11, x11, x13
	ldr	x13, [x2, #160]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #168]
	stp	x11, x9, [x0, #144]
	adcs	x8, x13, x8
	ldr	x13, [x1, #176]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #160]
	adcs	x10, x14, x13
	str	x10, [x0, #176]
	ret
.Lfunc_end68:
	.size	mclb_addNF23, .Lfunc_end68-mclb_addNF23
                                        // -- End function
	.globl	mclb_add24                      // -- Begin function mclb_add24
	.p2align	2
	.type	mclb_add24,@function
mclb_add24:                             // @mclb_add24
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	ldp	x10, x13, [x2, #176]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	adcs	x10, x10, x12
	adcs	x9, x13, x11
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end69:
	.size	mclb_add24, .Lfunc_end69-mclb_add24
                                        // -- End function
	.globl	mclb_sub24                      // -- Begin function mclb_sub24
	.p2align	2
	.type	mclb_sub24,@function
mclb_sub24:                             // @mclb_sub24
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	ldp	x10, x13, [x2, #176]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end70:
	.size	mclb_sub24, .Lfunc_end70-mclb_sub24
                                        // -- End function
	.globl	mclb_addNF24                    // -- Begin function mclb_addNF24
	.p2align	2
	.type	mclb_addNF24,@function
mclb_addNF24:                           // @mclb_addNF24
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	ldp	x10, x13, [x2, #176]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	adcs	x10, x10, x12
	adcs	x8, x13, x11
	stp	x10, x8, [x0, #176]
	ret
.Lfunc_end71:
	.size	mclb_addNF24, .Lfunc_end71-mclb_addNF24
                                        // -- End function
	.globl	mclb_add25                      // -- Begin function mclb_add25
	.p2align	2
	.type	mclb_add25,@function
mclb_add25:                             // @mclb_add25
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x10, x10, x13
	ldr	x13, [x2, #176]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #176]
	ldp	x12, x14, [x2, #184]
	stp	x10, x9, [x0, #160]
	adcs	x8, x13, x8
	ldr	x13, [x1, #192]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #176]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #192]
	mov	x0, x8
	ret
.Lfunc_end72:
	.size	mclb_add25, .Lfunc_end72-mclb_add25
                                        // -- End function
	.globl	mclb_sub25                      // -- Begin function mclb_sub25
	.p2align	2
	.type	mclb_sub25,@function
mclb_sub25:                             // @mclb_sub25
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #144]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #160]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	sbcs	x10, x13, x10
	ldr	x13, [x2, #176]
	sbcs	x9, x11, x12
	ldp	x8, x11, [x1, #176]
	ldp	x12, x14, [x2, #184]
	stp	x10, x9, [x0, #160]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #192]
	sbcs	x9, x11, x12
	stp	x8, x9, [x0, #176]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #192]
	mov	x0, x8
	ret
.Lfunc_end73:
	.size	mclb_sub25, .Lfunc_end73-mclb_sub25
                                        // -- End function
	.globl	mclb_addNF25                    // -- Begin function mclb_addNF25
	.p2align	2
	.type	mclb_addNF25,@function
mclb_addNF25:                           // @mclb_addNF25
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x10, x10, x13
	ldr	x13, [x2, #176]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #176]
	ldp	x12, x14, [x2, #184]
	stp	x10, x9, [x0, #160]
	adcs	x8, x13, x8
	ldr	x13, [x1, #192]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #176]
	adcs	x10, x14, x13
	str	x10, [x0, #192]
	ret
.Lfunc_end74:
	.size	mclb_addNF25, .Lfunc_end74-mclb_addNF25
                                        // -- End function
	.globl	mclb_add26                      // -- Begin function mclb_add26
	.p2align	2
	.type	mclb_add26,@function
mclb_add26:                             // @mclb_add26
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	ldp	x8, x13, [x2, #192]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #192]
	adcs	x8, xzr, xzr
	mov	x0, x8
	ret
.Lfunc_end75:
	.size	mclb_add26, .Lfunc_end75-mclb_add26
                                        // -- End function
	.globl	mclb_sub26                      // -- Begin function mclb_sub26
	.p2align	2
	.type	mclb_sub26,@function
mclb_sub26:                             // @mclb_sub26
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	ldp	x8, x13, [x2, #192]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	sbcs	x8, x12, x8
	sbcs	x9, x11, x13
	stp	x8, x9, [x0, #192]
	ngcs	x8, xzr
	and	x8, x8, #0x1
	mov	x0, x8
	ret
.Lfunc_end76:
	.size	mclb_sub26, .Lfunc_end76-mclb_sub26
                                        // -- End function
	.globl	mclb_addNF26                    // -- Begin function mclb_addNF26
	.p2align	2
	.type	mclb_addNF26,@function
mclb_addNF26:                           // @mclb_addNF26
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	ldp	x8, x13, [x2, #192]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #192]
	ret
.Lfunc_end77:
	.size	mclb_addNF26, .Lfunc_end77-mclb_addNF26
                                        // -- End function
	.globl	mclb_add27                      // -- Begin function mclb_add27
	.p2align	2
	.type	mclb_add27,@function
mclb_add27:                             // @mclb_add27
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	ldp	x8, x11, [x1, #192]
	adcs	x9, x9, x13
	ldr	x13, [x2, #192]
	adcs	x10, x12, x10
	ldp	x12, x14, [x2, #200]
	stp	x9, x10, [x0, #176]
	adcs	x8, x13, x8
	ldr	x13, [x1, #208]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #192]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end78:
	.size	mclb_add27, .Lfunc_end78-mclb_add27
                                        // -- End function
	.globl	mclb_sub27                      // -- Begin function mclb_sub27
	.p2align	2
	.type	mclb_sub27,@function
mclb_sub27:                             // @mclb_sub27
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #144]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #160]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #176]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	ldp	x8, x11, [x1, #192]
	sbcs	x9, x13, x9
	ldr	x13, [x2, #192]
	sbcs	x10, x10, x12
	ldp	x12, x14, [x2, #200]
	stp	x9, x10, [x0, #176]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #208]
	sbcs	x9, x11, x12
	stp	x8, x9, [x0, #192]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end79:
	.size	mclb_sub27, .Lfunc_end79-mclb_sub27
                                        // -- End function
	.globl	mclb_addNF27                    // -- Begin function mclb_addNF27
	.p2align	2
	.type	mclb_addNF27,@function
mclb_addNF27:                           // @mclb_addNF27
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	ldp	x8, x11, [x1, #192]
	adcs	x9, x9, x13
	ldr	x13, [x2, #192]
	adcs	x10, x12, x10
	ldp	x12, x14, [x2, #200]
	stp	x9, x10, [x0, #176]
	adcs	x8, x13, x8
	ldr	x13, [x1, #208]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #192]
	adcs	x10, x14, x13
	str	x10, [x0, #208]
	ret
.Lfunc_end80:
	.size	mclb_addNF27, .Lfunc_end80-mclb_addNF27
                                        // -- End function
	.globl	mclb_add28                      // -- Begin function mclb_add28
	.p2align	2
	.type	mclb_add28,@function
mclb_add28:                             // @mclb_add28
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	ldp	x9, x13, [x2, #208]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	adcs	x9, x9, x12
	adcs	x10, x13, x11
	adcs	x8, xzr, xzr
	stp	x9, x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end81:
	.size	mclb_add28, .Lfunc_end81-mclb_add28
                                        // -- End function
	.globl	mclb_sub28                      // -- Begin function mclb_sub28
	.p2align	2
	.type	mclb_sub28,@function
mclb_sub28:                             // @mclb_sub28
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	ldp	x9, x13, [x2, #208]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	sbcs	x9, x12, x9
	sbcs	x10, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x9, x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end82:
	.size	mclb_sub28, .Lfunc_end82-mclb_sub28
                                        // -- End function
	.globl	mclb_addNF28                    // -- Begin function mclb_addNF28
	.p2align	2
	.type	mclb_addNF28,@function
mclb_addNF28:                           // @mclb_addNF28
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	ldp	x9, x13, [x2, #208]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	adcs	x9, x9, x12
	adcs	x8, x13, x11
	stp	x9, x8, [x0, #208]
	ret
.Lfunc_end83:
	.size	mclb_addNF28, .Lfunc_end83-mclb_addNF28
                                        // -- End function
	.globl	mclb_add29                      // -- Begin function mclb_add29
	.p2align	2
	.type	mclb_add29,@function
mclb_add29:                             // @mclb_add29
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #192]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	ldp	x8, x10, [x1, #208]
	adcs	x11, x11, x13
	ldr	x13, [x2, #208]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #216]
	stp	x11, x9, [x0, #192]
	adcs	x8, x13, x8
	ldr	x13, [x1, #224]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #208]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end84:
	.size	mclb_add29, .Lfunc_end84-mclb_add29
                                        // -- End function
	.globl	mclb_sub29                      // -- Begin function mclb_sub29
	.p2align	2
	.type	mclb_sub29,@function
mclb_sub29:                             // @mclb_sub29
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #144]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #160]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #176]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #192]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	ldp	x8, x10, [x1, #208]
	sbcs	x11, x13, x11
	ldr	x13, [x2, #208]
	sbcs	x9, x9, x12
	ldp	x12, x14, [x2, #216]
	stp	x11, x9, [x0, #192]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #224]
	sbcs	x9, x10, x12
	stp	x8, x9, [x0, #208]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end85:
	.size	mclb_sub29, .Lfunc_end85-mclb_sub29
                                        // -- End function
	.globl	mclb_addNF29                    // -- Begin function mclb_addNF29
	.p2align	2
	.type	mclb_addNF29,@function
mclb_addNF29:                           // @mclb_addNF29
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #192]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	ldp	x8, x10, [x1, #208]
	adcs	x11, x11, x13
	ldr	x13, [x2, #208]
	adcs	x9, x12, x9
	ldp	x12, x14, [x2, #216]
	stp	x11, x9, [x0, #192]
	adcs	x8, x13, x8
	ldr	x13, [x1, #224]
	adcs	x9, x12, x10
	stp	x8, x9, [x0, #208]
	adcs	x10, x14, x13
	str	x10, [x0, #224]
	ret
.Lfunc_end86:
	.size	mclb_addNF29, .Lfunc_end86-mclb_addNF29
                                        // -- End function
	.globl	mclb_add30                      // -- Begin function mclb_add30
	.p2align	2
	.type	mclb_add30,@function
mclb_add30:                             // @mclb_add30
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	ldp	x10, x13, [x2, #224]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	adcs	x10, x10, x12
	adcs	x9, x13, x11
	adcs	x8, xzr, xzr
	stp	x10, x9, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end87:
	.size	mclb_add30, .Lfunc_end87-mclb_add30
                                        // -- End function
	.globl	mclb_sub30                      // -- Begin function mclb_sub30
	.p2align	2
	.type	mclb_sub30,@function
mclb_sub30:                             // @mclb_sub30
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	ldp	x10, x13, [x2, #224]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x13
	ngcs	x8, xzr
	and	x8, x8, #0x1
	stp	x10, x9, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end88:
	.size	mclb_sub30, .Lfunc_end88-mclb_sub30
                                        // -- End function
	.globl	mclb_addNF30                    // -- Begin function mclb_addNF30
	.p2align	2
	.type	mclb_addNF30,@function
mclb_addNF30:                           // @mclb_addNF30
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	ldp	x10, x13, [x2, #224]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	adcs	x10, x10, x12
	adcs	x8, x13, x11
	stp	x10, x8, [x0, #224]
	ret
.Lfunc_end89:
	.size	mclb_addNF30, .Lfunc_end89-mclb_addNF30
                                        // -- End function
	.globl	mclb_add31                      // -- Begin function mclb_add31
	.p2align	2
	.type	mclb_add31,@function
mclb_add31:                             // @mclb_add31
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #192]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #208]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #208]
	stp	x8, x9, [x0, #192]
	adcs	x10, x10, x13
	ldr	x13, [x2, #224]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #224]
	ldp	x12, x14, [x2, #232]
	stp	x10, x9, [x0, #208]
	adcs	x8, x13, x8
	ldr	x13, [x1, #240]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #224]
	adcs	x10, x14, x13
	adcs	x8, xzr, xzr
	str	x10, [x0, #240]
	mov	x0, x8
	ret
.Lfunc_end90:
	.size	mclb_add31, .Lfunc_end90-mclb_add31
                                        // -- End function
	.globl	mclb_sub31                      // -- Begin function mclb_sub31
	.p2align	2
	.type	mclb_sub31,@function
mclb_sub31:                             // @mclb_sub31
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	subs	x9, x9, x10
	sbcs	x8, x8, x11
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	sbcs	x9, x13, x10
	ldp	x13, x10, [x1, #32]
	sbcs	x11, x12, x11
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	sbcs	x8, x13, x8
	ldp	x13, x9, [x1, #48]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #64]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #80]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #96]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #112]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #128]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #144]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #160]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	sbcs	x8, x13, x10
	ldp	x13, x10, [x1, #176]
	sbcs	x11, x11, x12
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	sbcs	x8, x13, x9
	ldp	x13, x9, [x1, #192]
	sbcs	x10, x10, x12
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	sbcs	x8, x13, x11
	ldp	x13, x11, [x1, #208]
	sbcs	x9, x9, x12
	ldp	x10, x12, [x2, #208]
	stp	x8, x9, [x0, #192]
	sbcs	x10, x13, x10
	ldr	x13, [x2, #224]
	sbcs	x9, x11, x12
	ldp	x8, x11, [x1, #224]
	ldp	x12, x14, [x2, #232]
	stp	x10, x9, [x0, #208]
	sbcs	x8, x8, x13
	ldr	x13, [x1, #240]
	sbcs	x9, x11, x12
	stp	x8, x9, [x0, #224]
	sbcs	x10, x13, x14
	ngcs	x8, xzr
	and	x8, x8, #0x1
	str	x10, [x0, #240]
	mov	x0, x8
	ret
.Lfunc_end91:
	.size	mclb_sub31, .Lfunc_end91-mclb_sub31
                                        // -- End function
	.globl	mclb_addNF31                    // -- Begin function mclb_addNF31
	.p2align	2
	.type	mclb_addNF31,@function
mclb_addNF31:                           // @mclb_addNF31
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	ldp	x13, x12, [x1, #16]
	adds	x9, x10, x9
	adcs	x8, x11, x8
	ldp	x10, x11, [x2, #16]
	stp	x9, x8, [x0]
	adcs	x9, x10, x13
	ldp	x13, x10, [x1, #32]
	adcs	x11, x11, x12
	ldp	x8, x12, [x2, #32]
	stp	x9, x11, [x0, #16]
	adcs	x8, x8, x13
	ldp	x13, x9, [x1, #48]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #48]
	stp	x8, x10, [x0, #32]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #64]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #64]
	stp	x8, x9, [x0, #48]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #80]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #80]
	stp	x8, x11, [x0, #64]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #96]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #96]
	stp	x8, x10, [x0, #80]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #112]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #112]
	stp	x8, x9, [x0, #96]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #128]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #128]
	stp	x8, x11, [x0, #112]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #144]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #144]
	stp	x8, x10, [x0, #128]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #160]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #160]
	stp	x8, x9, [x0, #144]
	adcs	x8, x10, x13
	ldp	x13, x10, [x1, #176]
	adcs	x11, x12, x11
	ldp	x9, x12, [x2, #176]
	stp	x8, x11, [x0, #160]
	adcs	x8, x9, x13
	ldp	x13, x9, [x1, #192]
	adcs	x10, x12, x10
	ldp	x11, x12, [x2, #192]
	stp	x8, x10, [x0, #176]
	adcs	x8, x11, x13
	ldp	x13, x11, [x1, #208]
	adcs	x9, x12, x9
	ldp	x10, x12, [x2, #208]
	stp	x8, x9, [x0, #192]
	adcs	x10, x10, x13
	ldr	x13, [x2, #224]
	adcs	x9, x12, x11
	ldp	x8, x11, [x1, #224]
	ldp	x12, x14, [x2, #232]
	stp	x10, x9, [x0, #208]
	adcs	x8, x13, x8
	ldr	x13, [x1, #240]
	adcs	x9, x12, x11
	stp	x8, x9, [x0, #224]
	adcs	x10, x14, x13
	str	x10, [x0, #240]
	ret
.Lfunc_end92:
	.size	mclb_addNF31, .Lfunc_end92-mclb_addNF31
                                        // -- End function
	.globl	mclb_add32                      // -- Begin function mclb_add32
	.p2align	2
	.type	mclb_add32,@function
mclb_add32:                             // @mclb_add32
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	ldp	x10, x9, [x2, #224]
	ldp	x8, x13, [x2, #240]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #240]
	stp	x10, x9, [x0, #224]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #240]
	adcs	x8, xzr, xzr
	mov	x0, x8
	ret
.Lfunc_end93:
	.size	mclb_add32, .Lfunc_end93-mclb_add32
                                        // -- End function
	.globl	mclb_sub32                      // -- Begin function mclb_sub32
	.p2align	2
	.type	mclb_sub32,@function
mclb_sub32:                             // @mclb_sub32
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	subs	x8, x8, x9
	sbcs	x10, x10, x11
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	sbcs	x8, x12, x8
	sbcs	x10, x11, x10
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	sbcs	x9, x12, x9
	sbcs	x8, x11, x8
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	ldp	x10, x9, [x2, #224]
	ldp	x8, x13, [x2, #240]
	sbcs	x10, x12, x10
	sbcs	x9, x11, x9
	ldp	x12, x11, [x1, #240]
	stp	x10, x9, [x0, #224]
	sbcs	x8, x12, x8
	sbcs	x9, x11, x13
	stp	x8, x9, [x0, #240]
	ngcs	x8, xzr
	and	x8, x8, #0x1
	mov	x0, x8
	ret
.Lfunc_end94:
	.size	mclb_sub32, .Lfunc_end94-mclb_sub32
                                        // -- End function
	.globl	mclb_addNF32                    // -- Begin function mclb_addNF32
	.p2align	2
	.type	mclb_addNF32,@function
mclb_addNF32:                           // @mclb_addNF32
// %bb.0:
	ldp	x8, x10, [x1]
	ldp	x9, x11, [x2]
	adds	x8, x9, x8
	adcs	x10, x11, x10
	ldp	x12, x11, [x1, #16]
	stp	x8, x10, [x0]
	ldp	x9, x8, [x2, #16]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #32]
	stp	x9, x8, [x0, #16]
	ldp	x10, x9, [x2, #32]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #48]
	stp	x10, x9, [x0, #32]
	ldp	x8, x10, [x2, #48]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #64]
	stp	x8, x10, [x0, #48]
	ldp	x9, x8, [x2, #64]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #80]
	stp	x9, x8, [x0, #64]
	ldp	x10, x9, [x2, #80]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #96]
	stp	x10, x9, [x0, #80]
	ldp	x8, x10, [x2, #96]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #112]
	stp	x8, x10, [x0, #96]
	ldp	x9, x8, [x2, #112]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #128]
	stp	x9, x8, [x0, #112]
	ldp	x10, x9, [x2, #128]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #144]
	stp	x10, x9, [x0, #128]
	ldp	x8, x10, [x2, #144]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #160]
	stp	x8, x10, [x0, #144]
	ldp	x9, x8, [x2, #160]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #176]
	stp	x9, x8, [x0, #160]
	ldp	x10, x9, [x2, #176]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #192]
	stp	x10, x9, [x0, #176]
	ldp	x8, x10, [x2, #192]
	adcs	x8, x8, x12
	adcs	x10, x10, x11
	ldp	x12, x11, [x1, #208]
	stp	x8, x10, [x0, #192]
	ldp	x9, x8, [x2, #208]
	adcs	x9, x9, x12
	adcs	x8, x8, x11
	ldp	x12, x11, [x1, #224]
	stp	x9, x8, [x0, #208]
	ldp	x10, x9, [x2, #224]
	ldp	x8, x13, [x2, #240]
	adcs	x10, x10, x12
	adcs	x9, x9, x11
	ldp	x12, x11, [x1, #240]
	stp	x10, x9, [x0, #224]
	adcs	x8, x8, x12
	adcs	x9, x13, x11
	stp	x8, x9, [x0, #240]
	ret
.Lfunc_end95:
	.size	mclb_addNF32, .Lfunc_end95-mclb_addNF32
                                        // -- End function
	.globl	mclb_mulUnit1                   // -- Begin function mclb_mulUnit1
	.p2align	2
	.type	mclb_mulUnit1,@function
mclb_mulUnit1:                          // @mclb_mulUnit1
// %bb.0:
	ldr	x8, [x1]
	mul	x9, x8, x2
	umulh	x8, x8, x2
	str	x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end96:
	.size	mclb_mulUnit1, .Lfunc_end96-mclb_mulUnit1
                                        // -- End function
	.globl	mclb_mulUnitAdd1                // -- Begin function mclb_mulUnitAdd1
	.p2align	2
	.type	mclb_mulUnitAdd1,@function
mclb_mulUnitAdd1:                       // @mclb_mulUnitAdd1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x0]
	umulh	x10, x8, x2
	mul	x8, x8, x2
	adds	x9, x8, x9
	adcs	x8, x10, xzr
	str	x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end97:
	.size	mclb_mulUnitAdd1, .Lfunc_end97-mclb_mulUnitAdd1
                                        // -- End function
	.globl	mclb_mulUnit2                   // -- Begin function mclb_mulUnit2
	.p2align	2
	.type	mclb_mulUnit2,@function
mclb_mulUnit2:                          // @mclb_mulUnit2
// %bb.0:
	ldp	x8, x9, [x1]
	mul	x10, x8, x2
	umulh	x8, x8, x2
	umulh	x11, x9, x2
	mul	x9, x9, x2
	adds	x9, x8, x9
	adcs	x8, x11, xzr
	stp	x10, x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end98:
	.size	mclb_mulUnit2, .Lfunc_end98-mclb_mulUnit2
                                        // -- End function
	.globl	mclb_mulUnitAdd2                // -- Begin function mclb_mulUnitAdd2
	.p2align	2
	.type	mclb_mulUnitAdd2,@function
mclb_mulUnitAdd2:                       // @mclb_mulUnitAdd2
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x11, x10, [x0]
	mul	x12, x8, x2
	umulh	x13, x9, x2
	mul	x9, x9, x2
	adds	x11, x12, x11
	adcs	x9, x9, x10
	umulh	x8, x8, x2
	adcs	x10, xzr, xzr
	adds	x9, x9, x8
	adcs	x8, x10, x13
	stp	x11, x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end99:
	.size	mclb_mulUnitAdd2, .Lfunc_end99-mclb_mulUnitAdd2
                                        // -- End function
	.globl	mclb_mulUnit3                   // -- Begin function mclb_mulUnit3
	.p2align	2
	.type	mclb_mulUnit3,@function
mclb_mulUnit3:                          // @mclb_mulUnit3
// %bb.0:
	ldp	x8, x9, [x1]
	ldr	x10, [x1, #16]
	mul	x11, x8, x2
	umulh	x8, x8, x2
	umulh	x12, x9, x2
	mul	x9, x9, x2
	mul	x13, x10, x2
	adds	x9, x8, x9
	umulh	x10, x10, x2
	adcs	x12, x12, x13
	adcs	x8, x10, xzr
	stp	x11, x9, [x0]
	str	x12, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end100:
	.size	mclb_mulUnit3, .Lfunc_end100-mclb_mulUnit3
                                        // -- End function
	.globl	mclb_mulUnitAdd3                // -- Begin function mclb_mulUnitAdd3
	.p2align	2
	.type	mclb_mulUnitAdd3,@function
mclb_mulUnitAdd3:                       // @mclb_mulUnitAdd3
// %bb.0:
	ldp	x8, x9, [x1]
	ldr	x13, [x0]
	ldr	x10, [x1, #16]
	ldp	x12, x11, [x0, #8]
	mul	x14, x8, x2
	umulh	x15, x9, x2
	mul	x9, x9, x2
	adds	x13, x14, x13
	mul	x16, x10, x2
	adcs	x9, x9, x12
	adcs	x11, x16, x11
	umulh	x8, x8, x2
	adcs	x12, xzr, xzr
	adds	x9, x9, x8
	umulh	x10, x10, x2
	adcs	x11, x11, x15
	adcs	x8, x12, x10
	stp	x13, x9, [x0]
	str	x11, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end101:
	.size	mclb_mulUnitAdd3, .Lfunc_end101-mclb_mulUnitAdd3
                                        // -- End function
	.globl	mclb_mulUnit4                   // -- Begin function mclb_mulUnit4
	.p2align	2
	.type	mclb_mulUnit4,@function
mclb_mulUnit4:                          // @mclb_mulUnit4
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	mul	x12, x8, x2
	umulh	x8, x8, x2
	umulh	x13, x9, x2
	mul	x9, x9, x2
	mul	x14, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x15, x11, x2
	adcs	x9, x13, x14
	umulh	x11, x11, x2
	adcs	x10, x10, x15
	stp	x12, x8, [x0]
	adcs	x8, x11, xzr
	stp	x9, x10, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end102:
	.size	mclb_mulUnit4, .Lfunc_end102-mclb_mulUnit4
                                        // -- End function
	.globl	mclb_mulUnitAdd4                // -- Begin function mclb_mulUnitAdd4
	.p2align	2
	.type	mclb_mulUnitAdd4,@function
mclb_mulUnitAdd4:                       // @mclb_mulUnitAdd4
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x15, x14, [x0]
	ldp	x10, x11, [x1, #16]
	ldp	x13, x12, [x0, #16]
	mul	x16, x8, x2
	umulh	x17, x9, x2
	mul	x9, x9, x2
	adds	x15, x16, x15
	mul	x18, x10, x2
	adcs	x9, x9, x14
	mul	x1, x11, x2
	adcs	x13, x18, x13
	adcs	x12, x1, x12
	umulh	x8, x8, x2
	adcs	x14, xzr, xzr
	adds	x8, x9, x8
	umulh	x10, x10, x2
	adcs	x9, x13, x17
	umulh	x11, x11, x2
	adcs	x10, x12, x10
	stp	x15, x8, [x0]
	adcs	x8, x14, x11
	stp	x9, x10, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end103:
	.size	mclb_mulUnitAdd4, .Lfunc_end103-mclb_mulUnitAdd4
                                        // -- End function
	.globl	mclb_mulUnit5                   // -- Begin function mclb_mulUnit5
	.p2align	2
	.type	mclb_mulUnit5,@function
mclb_mulUnit5:                          // @mclb_mulUnit5
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldr	x12, [x1, #32]
	mul	x13, x8, x2
	umulh	x8, x8, x2
	umulh	x14, x9, x2
	mul	x9, x9, x2
	mul	x15, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x16, x11, x2
	adcs	x9, x14, x15
	umulh	x11, x11, x2
	mul	x17, x12, x2
	adcs	x10, x10, x16
	umulh	x12, x12, x2
	adcs	x11, x11, x17
	stp	x13, x8, [x0]
	adcs	x8, x12, xzr
	stp	x9, x10, [x0, #16]
	str	x11, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end104:
	.size	mclb_mulUnit5, .Lfunc_end104-mclb_mulUnit5
                                        // -- End function
	.globl	mclb_mulUnitAdd5                // -- Begin function mclb_mulUnitAdd5
	.p2align	2
	.type	mclb_mulUnitAdd5,@function
mclb_mulUnitAdd5:                       // @mclb_mulUnitAdd5
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldr	x12, [x1, #32]
	ldp	x16, x15, [x0]
	ldp	x14, x13, [x0, #16]
	mul	x17, x8, x2
	umulh	x8, x8, x2
	umulh	x18, x9, x2
	mul	x9, x9, x2
	mul	x1, x10, x2
	umulh	x10, x10, x2
	mul	x3, x11, x2
	umulh	x11, x11, x2
	mul	x4, x12, x2
	umulh	x12, x12, x2
	ldr	x2, [x0, #32]
	adds	x16, x17, x16
	adcs	x9, x9, x15
	adcs	x14, x1, x14
	adcs	x13, x3, x13
	adcs	x15, x4, x2
	adcs	x17, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x14, x18
	adcs	x10, x13, x10
	adcs	x11, x15, x11
	stp	x16, x8, [x0]
	adcs	x8, x17, x12
	stp	x9, x10, [x0, #16]
	str	x11, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end105:
	.size	mclb_mulUnitAdd5, .Lfunc_end105-mclb_mulUnitAdd5
                                        // -- End function
	.globl	mclb_mulUnit6                   // -- Begin function mclb_mulUnit6
	.p2align	2
	.type	mclb_mulUnit6,@function
mclb_mulUnit6:                          // @mclb_mulUnit6
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	mul	x14, x8, x2
	umulh	x8, x8, x2
	umulh	x15, x9, x2
	mul	x9, x9, x2
	mul	x16, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x17, x11, x2
	adcs	x9, x15, x16
	umulh	x11, x11, x2
	mul	x18, x12, x2
	stp	x14, x8, [x0]
	adcs	x8, x10, x17
	umulh	x12, x12, x2
	mul	x1, x13, x2
	adcs	x10, x11, x18
	umulh	x13, x13, x2
	stp	x9, x8, [x0, #16]
	adcs	x9, x12, x1
	adcs	x8, x13, xzr
	stp	x10, x9, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end106:
	.size	mclb_mulUnit6, .Lfunc_end106-mclb_mulUnit6
                                        // -- End function
	.globl	mclb_mulUnitAdd6                // -- Begin function mclb_mulUnitAdd6
	.p2align	2
	.type	mclb_mulUnitAdd6,@function
mclb_mulUnitAdd6:                       // @mclb_mulUnitAdd6
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x17, x16, [x0]
	ldp	x15, x14, [x0, #16]
	mul	x18, x8, x2
	umulh	x8, x8, x2
	umulh	x1, x9, x2
	mul	x9, x9, x2
	mul	x3, x10, x2
	umulh	x10, x10, x2
	mul	x4, x11, x2
	umulh	x11, x11, x2
	mul	x5, x12, x2
	umulh	x12, x12, x2
	mul	x6, x13, x2
	umulh	x13, x13, x2
	ldp	x7, x2, [x0, #32]
	adds	x17, x18, x17
	adcs	x9, x9, x16
	adcs	x15, x3, x15
	adcs	x14, x4, x14
	adcs	x16, x5, x7
	adcs	x18, x6, x2
	adcs	x2, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x15, x1
	stp	x17, x8, [x0]
	adcs	x8, x14, x10
	adcs	x10, x16, x11
	stp	x9, x8, [x0, #16]
	adcs	x9, x18, x12
	adcs	x8, x2, x13
	stp	x10, x9, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end107:
	.size	mclb_mulUnitAdd6, .Lfunc_end107-mclb_mulUnitAdd6
                                        // -- End function
	.globl	mclb_mulUnit7                   // -- Begin function mclb_mulUnit7
	.p2align	2
	.type	mclb_mulUnit7,@function
mclb_mulUnit7:                          // @mclb_mulUnit7
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldr	x14, [x1, #48]
	mul	x15, x8, x2
	umulh	x8, x8, x2
	umulh	x16, x9, x2
	mul	x9, x9, x2
	mul	x17, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x18, x11, x2
	adcs	x9, x16, x17
	umulh	x11, x11, x2
	mul	x1, x12, x2
	stp	x15, x8, [x0]
	adcs	x8, x10, x18
	umulh	x12, x12, x2
	mul	x3, x13, x2
	adcs	x10, x11, x1
	umulh	x13, x13, x2
	mul	x4, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x9, x12, x3
	umulh	x14, x14, x2
	adcs	x11, x13, x4
	adcs	x8, x14, xzr
	stp	x10, x9, [x0, #32]
	str	x11, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end108:
	.size	mclb_mulUnit7, .Lfunc_end108-mclb_mulUnit7
                                        // -- End function
	.globl	mclb_mulUnitAdd7                // -- Begin function mclb_mulUnitAdd7
	.p2align	2
	.type	mclb_mulUnitAdd7,@function
mclb_mulUnitAdd7:                       // @mclb_mulUnitAdd7
// %bb.0:
	str	x21, [sp, #-32]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldr	x14, [x1, #48]
	ldp	x1, x18, [x0]
	ldp	x17, x16, [x0, #16]
	mul	x3, x8, x2
	umulh	x4, x9, x2
	mul	x9, x9, x2
	ldr	x21, [x0, #32]
	adds	x1, x3, x1
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	mul	x5, x10, x2
	umulh	x10, x10, x2
	mul	x6, x11, x2
	umulh	x11, x11, x2
	mul	x7, x12, x2
	umulh	x12, x12, x2
	mul	x19, x13, x2
	umulh	x13, x13, x2
	mul	x20, x14, x2
	umulh	x14, x14, x2
	ldp	x2, x15, [x0, #40]
	adcs	x9, x9, x18
	adcs	x17, x5, x17
	adcs	x16, x6, x16
	adcs	x18, x7, x21
	adcs	x2, x19, x2
	adcs	x15, x20, x15
	adcs	x3, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x17, x4
	stp	x1, x8, [x0]
	adcs	x8, x16, x10
	adcs	x10, x18, x11
	stp	x9, x8, [x0, #16]
	adcs	x9, x2, x12
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	adcs	x11, x15, x13
	adcs	x8, x3, x14
	stp	x10, x9, [x0, #32]
	str	x11, [x0, #48]
	mov	x0, x8
	ldr	x21, [sp], #32                  // 8-byte Folded Reload
	ret
.Lfunc_end109:
	.size	mclb_mulUnitAdd7, .Lfunc_end109-mclb_mulUnitAdd7
                                        // -- End function
	.globl	mclb_mulUnit8                   // -- Begin function mclb_mulUnit8
	.p2align	2
	.type	mclb_mulUnit8,@function
mclb_mulUnit8:                          // @mclb_mulUnit8
// %bb.0:
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	mul	x16, x8, x2
	umulh	x8, x8, x2
	umulh	x17, x9, x2
	mul	x9, x9, x2
	mul	x18, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x1, x11, x2
	adcs	x9, x17, x18
	umulh	x11, x11, x2
	mul	x3, x12, x2
	stp	x16, x8, [x0]
	adcs	x8, x10, x1
	umulh	x12, x12, x2
	mul	x4, x13, x2
	adcs	x10, x11, x3
	umulh	x13, x13, x2
	mul	x5, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x4
	umulh	x14, x14, x2
	mul	x6, x15, x2
	adcs	x9, x13, x5
	umulh	x15, x15, x2
	stp	x10, x8, [x0, #32]
	adcs	x10, x14, x6
	adcs	x8, x15, xzr
	stp	x9, x10, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end110:
	.size	mclb_mulUnit8, .Lfunc_end110-mclb_mulUnit8
                                        // -- End function
	.globl	mclb_mulUnitAdd8                // -- Begin function mclb_mulUnitAdd8
	.p2align	2
	.type	mclb_mulUnitAdd8,@function
mclb_mulUnitAdd8:                       // @mclb_mulUnitAdd8
// %bb.0:
	stp	x24, x23, [sp, #-48]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x4, x3, [x0]
	ldp	x1, x18, [x0, #16]
	mul	x5, x8, x2
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x6, x9, x2
	mul	x9, x9, x2
	mul	x7, x10, x2
	umulh	x10, x10, x2
	mul	x19, x11, x2
	umulh	x11, x11, x2
	mul	x20, x12, x2
	umulh	x12, x12, x2
	mul	x21, x13, x2
	umulh	x13, x13, x2
	mul	x22, x14, x2
	umulh	x14, x14, x2
	mul	x23, x15, x2
	umulh	x15, x15, x2
	ldp	x24, x2, [x0, #32]
	adds	x4, x5, x4
	adcs	x9, x9, x3
	ldp	x17, x16, [x0, #48]
	adcs	x1, x7, x1
	adcs	x18, x19, x18
	adcs	x3, x20, x24
	adcs	x2, x21, x2
	adcs	x17, x22, x17
	adcs	x16, x23, x16
	adcs	x5, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x1, x6
	stp	x4, x8, [x0]
	adcs	x8, x18, x10
	adcs	x10, x3, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x2, x12
	adcs	x9, x17, x13
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	stp	x10, x8, [x0, #32]
	adcs	x10, x16, x14
	adcs	x8, x5, x15
	stp	x9, x10, [x0, #48]
	mov	x0, x8
	ldp	x24, x23, [sp], #48             // 16-byte Folded Reload
	ret
.Lfunc_end111:
	.size	mclb_mulUnitAdd8, .Lfunc_end111-mclb_mulUnitAdd8
                                        // -- End function
	.globl	mclb_mulUnit9                   // -- Begin function mclb_mulUnit9
	.p2align	2
	.type	mclb_mulUnit9,@function
mclb_mulUnit9:                          // @mclb_mulUnit9
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	mul	x17, x8, x2
	umulh	x8, x8, x2
	umulh	x18, x9, x2
	mul	x9, x9, x2
	ldr	x16, [x1, #64]
	mul	x1, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x3, x11, x2
	adcs	x9, x18, x1
	umulh	x11, x11, x2
	mul	x4, x12, x2
	stp	x17, x8, [x0]
	adcs	x8, x10, x3
	umulh	x12, x12, x2
	mul	x5, x13, x2
	adcs	x10, x11, x4
	umulh	x13, x13, x2
	mul	x6, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x5
	umulh	x14, x14, x2
	mul	x7, x15, x2
	adcs	x9, x13, x6
	umulh	x15, x15, x2
	mul	x19, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x10, x14, x7
	umulh	x16, x16, x2
	adcs	x11, x15, x19
	adcs	x8, x16, xzr
	stp	x9, x10, [x0, #48]
	str	x11, [x0, #64]
	mov	x0, x8
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end112:
	.size	mclb_mulUnit9, .Lfunc_end112-mclb_mulUnit9
                                        // -- End function
	.globl	mclb_mulUnitAdd9                // -- Begin function mclb_mulUnitAdd9
	.p2align	2
	.type	mclb_mulUnitAdd9,@function
mclb_mulUnitAdd9:                       // @mclb_mulUnitAdd9
// %bb.0:
	str	x27, [sp, #-80]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldr	x16, [x1, #64]
	ldp	x6, x5, [x0]
	ldp	x4, x3, [x0, #16]
	mul	x7, x8, x2
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x19, x9, x2
	mul	x9, x9, x2
	mul	x20, x10, x2
	umulh	x10, x10, x2
	mul	x21, x11, x2
	umulh	x11, x11, x2
	mul	x22, x12, x2
	umulh	x12, x12, x2
	mul	x23, x13, x2
	umulh	x13, x13, x2
	mul	x24, x14, x2
	umulh	x14, x14, x2
	mul	x25, x15, x2
	umulh	x15, x15, x2
	mul	x26, x16, x2
	umulh	x16, x16, x2
	ldp	x27, x2, [x0, #32]
	adds	x6, x7, x6
	adcs	x9, x9, x5
	ldr	x1, [x0, #48]
	adcs	x4, x20, x4
	ldp	x18, x17, [x0, #56]
	adcs	x3, x21, x3
	adcs	x5, x22, x27
	adcs	x2, x23, x2
	adcs	x1, x24, x1
	adcs	x18, x25, x18
	adcs	x17, x26, x17
	adcs	x7, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x4, x19
	stp	x6, x8, [x0]
	adcs	x8, x3, x10
	adcs	x10, x5, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x2, x12
	adcs	x9, x1, x13
	stp	x10, x8, [x0, #32]
	adcs	x10, x18, x14
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	adcs	x11, x17, x15
	adcs	x8, x7, x16
	stp	x9, x10, [x0, #48]
	str	x11, [x0, #64]
	mov	x0, x8
	ldr	x27, [sp], #80                  // 8-byte Folded Reload
	ret
.Lfunc_end113:
	.size	mclb_mulUnitAdd9, .Lfunc_end113-mclb_mulUnitAdd9
                                        // -- End function
	.globl	mclb_mulUnit10                  // -- Begin function mclb_mulUnit10
	.p2align	2
	.type	mclb_mulUnit10,@function
mclb_mulUnit10:                         // @mclb_mulUnit10
// %bb.0:
	str	x21, [sp, #-32]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	mul	x18, x8, x2
	umulh	x8, x8, x2
	umulh	x1, x9, x2
	mul	x9, x9, x2
	mul	x3, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x4, x11, x2
	adcs	x9, x1, x3
	umulh	x11, x11, x2
	mul	x5, x12, x2
	stp	x18, x8, [x0]
	adcs	x8, x10, x4
	umulh	x12, x12, x2
	mul	x6, x13, x2
	adcs	x10, x11, x5
	umulh	x13, x13, x2
	mul	x7, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x6
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	umulh	x14, x14, x2
	mul	x19, x15, x2
	adcs	x9, x13, x7
	umulh	x15, x15, x2
	mul	x20, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x8, x14, x19
	umulh	x16, x16, x2
	mul	x21, x17, x2
	adcs	x10, x15, x20
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	umulh	x17, x17, x2
	stp	x9, x8, [x0, #48]
	adcs	x9, x16, x21
	adcs	x8, x17, xzr
	stp	x10, x9, [x0, #64]
	mov	x0, x8
	ldr	x21, [sp], #32                  // 8-byte Folded Reload
	ret
.Lfunc_end114:
	.size	mclb_mulUnit10, .Lfunc_end114-mclb_mulUnit10
                                        // -- End function
	.globl	mclb_mulUnitAdd10               // -- Begin function mclb_mulUnitAdd10
	.p2align	2
	.type	mclb_mulUnitAdd10,@function
mclb_mulUnitAdd10:                      // @mclb_mulUnitAdd10
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x19, x7, [x0]
	ldp	x6, x5, [x0, #16]
	mul	x20, x8, x2
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x21, x9, x2
	mul	x9, x9, x2
	mul	x22, x10, x2
	umulh	x10, x10, x2
	mul	x23, x11, x2
	umulh	x11, x11, x2
	mul	x24, x12, x2
	umulh	x12, x12, x2
	mul	x25, x13, x2
	umulh	x13, x13, x2
	mul	x26, x14, x2
	umulh	x14, x14, x2
	mul	x27, x15, x2
	umulh	x15, x15, x2
	mul	x28, x16, x2
	umulh	x16, x16, x2
	mul	x29, x17, x2
	umulh	x17, x17, x2
	ldp	x30, x2, [x0, #32]
	adds	x19, x20, x19
	adcs	x9, x9, x7
	ldp	x4, x3, [x0, #48]
	adcs	x6, x22, x6
	adcs	x5, x23, x5
	ldp	x1, x18, [x0, #64]
	adcs	x7, x24, x30
	adcs	x2, x25, x2
	adcs	x4, x26, x4
	adcs	x3, x27, x3
	adcs	x1, x28, x1
	adcs	x18, x29, x18
	adcs	x20, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x6, x21
	stp	x19, x8, [x0]
	adcs	x8, x5, x10
	adcs	x10, x7, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x2, x12
	adcs	x9, x4, x13
	stp	x10, x8, [x0, #32]
	adcs	x8, x3, x14
	adcs	x10, x1, x15
	stp	x9, x8, [x0, #48]
	adcs	x9, x18, x16
	adcs	x8, x20, x17
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	stp	x10, x9, [x0, #64]
	mov	x0, x8
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end115:
	.size	mclb_mulUnitAdd10, .Lfunc_end115-mclb_mulUnitAdd10
                                        // -- End function
	.globl	mclb_mulUnit11                  // -- Begin function mclb_mulUnit11
	.p2align	2
	.type	mclb_mulUnit11,@function
mclb_mulUnit11:                         // @mclb_mulUnit11
// %bb.0:
	str	x23, [sp, #-48]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldr	x18, [x1, #80]
	mul	x1, x8, x2
	umulh	x8, x8, x2
	umulh	x3, x9, x2
	mul	x9, x9, x2
	mul	x4, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x5, x11, x2
	adcs	x9, x3, x4
	umulh	x11, x11, x2
	mul	x6, x12, x2
	stp	x1, x8, [x0]
	adcs	x8, x10, x5
	umulh	x12, x12, x2
	mul	x7, x13, x2
	adcs	x10, x11, x6
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	umulh	x13, x13, x2
	mul	x19, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x7
	umulh	x14, x14, x2
	mul	x20, x15, x2
	adcs	x9, x13, x19
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	umulh	x15, x15, x2
	mul	x21, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x8, x14, x20
	umulh	x16, x16, x2
	mul	x22, x17, x2
	adcs	x10, x15, x21
	umulh	x17, x17, x2
	mul	x23, x18, x2
	stp	x9, x8, [x0, #48]
	adcs	x9, x16, x22
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	umulh	x18, x18, x2
	adcs	x11, x17, x23
	adcs	x8, x18, xzr
	stp	x10, x9, [x0, #64]
	str	x11, [x0, #80]
	mov	x0, x8
	ldr	x23, [sp], #48                  // 8-byte Folded Reload
	ret
.Lfunc_end116:
	.size	mclb_mulUnit11, .Lfunc_end116-mclb_mulUnit11
                                        // -- End function
	.globl	mclb_mulUnitAdd11               // -- Begin function mclb_mulUnitAdd11
	.p2align	2
	.type	mclb_mulUnitAdd11,@function
mclb_mulUnitAdd11:                      // @mclb_mulUnitAdd11
// %bb.0:
	stp	x26, x25, [sp, #-64]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldr	x18, [x1, #80]
	ldp	x3, x1, [x0]
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	mul	x4, x8, x2
	umulh	x8, x8, x2
	umulh	x5, x9, x2
	mul	x9, x9, x2
	mul	x6, x10, x2
	umulh	x10, x10, x2
	mul	x7, x11, x2
	umulh	x11, x11, x2
	mul	x19, x12, x2
	umulh	x12, x12, x2
	mul	x20, x13, x2
	umulh	x13, x13, x2
	mul	x21, x14, x2
	umulh	x14, x14, x2
	mul	x22, x15, x2
	umulh	x15, x15, x2
	mul	x23, x16, x2
	umulh	x16, x16, x2
	mul	x24, x17, x2
	umulh	x17, x17, x2
	mul	x25, x18, x2
	umulh	x18, x18, x2
	ldp	x26, x2, [x0, #16]
	adds	x3, x4, x3
	adcs	x9, x9, x1
	ldp	x4, x1, [x0, #32]
	adcs	x6, x6, x26
	adcs	x2, x7, x2
	ldp	x26, x7, [x0, #48]
	adcs	x4, x19, x4
	adcs	x1, x20, x1
	ldp	x20, x19, [x0, #64]
	adcs	x21, x21, x26
	ldr	x26, [x0, #80]
	adcs	x7, x22, x7
	adcs	x20, x23, x20
	adcs	x19, x24, x19
	adcs	x22, x25, x26
	adcs	x23, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x6, x5
	stp	x3, x8, [x0]
	adcs	x8, x2, x10
	adcs	x10, x4, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x1, x12
	adcs	x9, x21, x13
	stp	x10, x8, [x0, #32]
	adcs	x8, x7, x14
	adcs	x10, x20, x15
	stp	x9, x8, [x0, #48]
	adcs	x9, x19, x16
	adcs	x11, x22, x17
	adcs	x8, x23, x18
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	stp	x10, x9, [x0, #64]
	str	x11, [x0, #80]
	mov	x0, x8
	ldp	x26, x25, [sp], #64             // 16-byte Folded Reload
	ret
.Lfunc_end117:
	.size	mclb_mulUnitAdd11, .Lfunc_end117-mclb_mulUnitAdd11
                                        // -- End function
	.globl	mclb_mulUnit12                  // -- Begin function mclb_mulUnit12
	.p2align	2
	.type	mclb_mulUnit12,@function
mclb_mulUnit12:                         // @mclb_mulUnit12
// %bb.0:
	str	x25, [sp, #-64]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	mul	x3, x8, x2
	umulh	x8, x8, x2
	umulh	x4, x9, x2
	mul	x9, x9, x2
	mul	x5, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x6, x11, x2
	adcs	x9, x4, x5
	ldp	x16, x17, [x1, #64]
	umulh	x11, x11, x2
	mul	x7, x12, x2
	stp	x3, x8, [x0]
	adcs	x8, x10, x6
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	umulh	x12, x12, x2
	mul	x19, x13, x2
	adcs	x10, x11, x7
	ldp	x18, x1, [x1, #80]
	umulh	x13, x13, x2
	mul	x20, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x19
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	umulh	x14, x14, x2
	mul	x21, x15, x2
	adcs	x9, x13, x20
	umulh	x15, x15, x2
	mul	x22, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x8, x14, x21
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	umulh	x16, x16, x2
	mul	x23, x17, x2
	adcs	x10, x15, x22
	umulh	x17, x17, x2
	mul	x24, x18, x2
	stp	x9, x8, [x0, #48]
	adcs	x8, x16, x23
	umulh	x18, x18, x2
	mul	x25, x1, x2
	adcs	x9, x17, x24
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	umulh	x1, x1, x2
	stp	x10, x8, [x0, #64]
	adcs	x10, x18, x25
	adcs	x8, x1, xzr
	stp	x9, x10, [x0, #80]
	mov	x0, x8
	ldr	x25, [sp], #64                  // 8-byte Folded Reload
	ret
.Lfunc_end118:
	.size	mclb_mulUnit12, .Lfunc_end118-mclb_mulUnit12
                                        // -- End function
	.globl	mclb_mulUnitAdd12               // -- Begin function mclb_mulUnitAdd12
	.p2align	2
	.type	mclb_mulUnitAdd12,@function
mclb_mulUnitAdd12:                      // @mclb_mulUnitAdd12
// %bb.0:
	stp	x28, x27, [sp, #-80]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x1, [x1, #80]
	ldp	x4, x3, [x0]
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	mul	x5, x8, x2
	umulh	x8, x8, x2
	umulh	x6, x9, x2
	mul	x9, x9, x2
	mul	x7, x10, x2
	umulh	x10, x10, x2
	mul	x19, x11, x2
	umulh	x11, x11, x2
	mul	x20, x12, x2
	umulh	x12, x12, x2
	mul	x21, x13, x2
	umulh	x13, x13, x2
	mul	x22, x14, x2
	umulh	x14, x14, x2
	mul	x23, x15, x2
	umulh	x15, x15, x2
	mul	x24, x16, x2
	umulh	x16, x16, x2
	mul	x25, x17, x2
	umulh	x17, x17, x2
	mul	x26, x18, x2
	umulh	x18, x18, x2
	mul	x27, x1, x2
	umulh	x1, x1, x2
	ldp	x28, x2, [x0, #16]
	adds	x4, x5, x4
	adcs	x9, x9, x3
	ldp	x5, x3, [x0, #32]
	adcs	x7, x7, x28
	adcs	x2, x19, x2
	ldp	x28, x19, [x0, #48]
	adcs	x5, x20, x5
	adcs	x3, x21, x3
	ldp	x21, x20, [x0, #64]
	adcs	x22, x22, x28
	adcs	x19, x23, x19
	ldp	x28, x23, [x0, #80]
	adcs	x21, x24, x21
	adcs	x20, x25, x20
	adcs	x24, x26, x28
	adcs	x23, x27, x23
	adcs	x25, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x7, x6
	stp	x4, x8, [x0]
	adcs	x8, x2, x10
	adcs	x10, x5, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x3, x12
	adcs	x9, x22, x13
	stp	x10, x8, [x0, #32]
	adcs	x8, x19, x14
	adcs	x10, x21, x15
	stp	x9, x8, [x0, #48]
	adcs	x8, x20, x16
	adcs	x9, x24, x17
	stp	x10, x8, [x0, #64]
	adcs	x10, x23, x18
	adcs	x8, x25, x1
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	stp	x9, x10, [x0, #80]
	mov	x0, x8
	ldp	x28, x27, [sp], #80             // 16-byte Folded Reload
	ret
.Lfunc_end119:
	.size	mclb_mulUnitAdd12, .Lfunc_end119-mclb_mulUnitAdd12
                                        // -- End function
	.globl	mclb_mulUnit13                  // -- Begin function mclb_mulUnit13
	.p2align	2
	.type	mclb_mulUnit13,@function
mclb_mulUnit13:                         // @mclb_mulUnit13
// %bb.0:
	str	x27, [sp, #-80]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	mul	x4, x8, x2
	umulh	x8, x8, x2
	umulh	x5, x9, x2
	mul	x9, x9, x2
	mul	x6, x10, x2
	adds	x8, x8, x9
	umulh	x10, x10, x2
	mul	x7, x11, x2
	adcs	x9, x5, x6
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	ldp	x16, x17, [x1, #64]
	umulh	x11, x11, x2
	mul	x19, x12, x2
	stp	x4, x8, [x0]
	adcs	x8, x10, x7
	umulh	x12, x12, x2
	mul	x20, x13, x2
	adcs	x10, x11, x19
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	ldp	x18, x3, [x1, #80]
	umulh	x13, x13, x2
	mul	x21, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x20
	umulh	x14, x14, x2
	mul	x22, x15, x2
	adcs	x9, x13, x21
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	ldr	x1, [x1, #96]
	umulh	x15, x15, x2
	mul	x23, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x8, x14, x22
	umulh	x16, x16, x2
	mul	x24, x17, x2
	adcs	x10, x15, x23
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	umulh	x17, x17, x2
	mul	x25, x18, x2
	stp	x9, x8, [x0, #48]
	adcs	x8, x16, x24
	umulh	x18, x18, x2
	mul	x26, x3, x2
	adcs	x9, x17, x25
	umulh	x3, x3, x2
	mul	x27, x1, x2
	stp	x10, x8, [x0, #64]
	adcs	x10, x18, x26
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	umulh	x1, x1, x2
	adcs	x11, x3, x27
	adcs	x8, x1, xzr
	stp	x9, x10, [x0, #80]
	str	x11, [x0, #96]
	mov	x0, x8
	ldr	x27, [sp], #80                  // 8-byte Folded Reload
	ret
.Lfunc_end120:
	.size	mclb_mulUnit13, .Lfunc_end120-mclb_mulUnit13
                                        // -- End function
	.globl	mclb_mulUnitAdd13               // -- Begin function mclb_mulUnitAdd13
	.p2align	2
	.type	mclb_mulUnitAdd13,@function
mclb_mulUnitAdd13:                      // @mclb_mulUnitAdd13
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldr	x1, [x1, #96]
	ldp	x5, x4, [x0]
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	mul	x6, x8, x2
	umulh	x8, x8, x2
	umulh	x7, x9, x2
	mul	x9, x9, x2
	mul	x19, x10, x2
	umulh	x10, x10, x2
	mul	x20, x11, x2
	umulh	x11, x11, x2
	mul	x21, x12, x2
	umulh	x12, x12, x2
	mul	x22, x13, x2
	umulh	x13, x13, x2
	mul	x23, x14, x2
	umulh	x14, x14, x2
	mul	x24, x15, x2
	umulh	x15, x15, x2
	mul	x25, x16, x2
	umulh	x16, x16, x2
	mul	x26, x17, x2
	umulh	x17, x17, x2
	mul	x27, x18, x2
	umulh	x18, x18, x2
	mul	x28, x3, x2
	umulh	x3, x3, x2
	mul	x29, x1, x2
	umulh	x1, x1, x2
	ldp	x30, x2, [x0, #16]
	adds	x5, x6, x5
	adcs	x9, x9, x4
	ldp	x6, x4, [x0, #32]
	adcs	x19, x19, x30
	adcs	x2, x20, x2
	ldp	x30, x20, [x0, #48]
	adcs	x6, x21, x6
	adcs	x4, x22, x4
	ldp	x22, x21, [x0, #64]
	adcs	x23, x23, x30
	adcs	x20, x24, x20
	ldp	x30, x24, [x0, #80]
	adcs	x22, x25, x22
	ldr	x25, [x0, #96]
	adcs	x21, x26, x21
	adcs	x26, x27, x30
	adcs	x24, x28, x24
	adcs	x25, x29, x25
	adcs	x27, xzr, xzr
	adds	x8, x9, x8
	adcs	x9, x19, x7
	stp	x5, x8, [x0]
	adcs	x8, x2, x10
	adcs	x10, x6, x11
	stp	x9, x8, [x0, #16]
	adcs	x8, x4, x12
	adcs	x9, x23, x13
	stp	x10, x8, [x0, #32]
	adcs	x8, x20, x14
	adcs	x10, x22, x15
	stp	x9, x8, [x0, #48]
	adcs	x8, x21, x16
	adcs	x9, x26, x17
	stp	x10, x8, [x0, #64]
	adcs	x10, x24, x18
	adcs	x11, x25, x3
	adcs	x8, x27, x1
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	stp	x9, x10, [x0, #80]
	str	x11, [x0, #96]
	mov	x0, x8
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end121:
	.size	mclb_mulUnitAdd13, .Lfunc_end121-mclb_mulUnitAdd13
                                        // -- End function
	.globl	mclb_mulUnit14                  // -- Begin function mclb_mulUnit14
	.p2align	2
	.type	mclb_mulUnit14,@function
mclb_mulUnit14:                         // @mclb_mulUnit14
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	mul	x5, x8, x2
	umulh	x8, x8, x2
	umulh	x6, x9, x2
	mul	x9, x9, x2
	mul	x7, x10, x2
	adds	x8, x8, x9
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	umulh	x10, x10, x2
	mul	x19, x11, x2
	adcs	x9, x6, x7
	ldp	x16, x17, [x1, #64]
	umulh	x11, x11, x2
	mul	x20, x12, x2
	stp	x5, x8, [x0]
	adcs	x8, x10, x19
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	umulh	x12, x12, x2
	mul	x21, x13, x2
	adcs	x10, x11, x20
	ldp	x18, x3, [x1, #80]
	umulh	x13, x13, x2
	mul	x22, x14, x2
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x21
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	umulh	x14, x14, x2
	mul	x23, x15, x2
	adcs	x9, x13, x22
	ldp	x4, x1, [x1, #96]
	umulh	x15, x15, x2
	mul	x24, x16, x2
	stp	x10, x8, [x0, #32]
	adcs	x8, x14, x23
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	umulh	x16, x16, x2
	mul	x25, x17, x2
	adcs	x10, x15, x24
	umulh	x17, x17, x2
	mul	x26, x18, x2
	stp	x9, x8, [x0, #48]
	adcs	x8, x16, x25
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	umulh	x18, x18, x2
	mul	x27, x3, x2
	adcs	x9, x17, x26
	umulh	x3, x3, x2
	mul	x28, x4, x2
	stp	x10, x8, [x0, #64]
	adcs	x8, x18, x27
	umulh	x4, x4, x2
	mul	x29, x1, x2
	adcs	x10, x3, x28
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	umulh	x1, x1, x2
	stp	x9, x8, [x0, #80]
	adcs	x9, x4, x29
	adcs	x8, x1, xzr
	stp	x10, x9, [x0, #96]
	mov	x0, x8
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end122:
	.size	mclb_mulUnit14, .Lfunc_end122-mclb_mulUnit14
                                        // -- End function
	.globl	mclb_mulUnitAdd14               // -- Begin function mclb_mulUnitAdd14
	.p2align	2
	.type	mclb_mulUnitAdd14,@function
mclb_mulUnitAdd14:                      // @mclb_mulUnitAdd14
// %bb.0:
	sub	sp, sp, #112                    // =112
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x1, [x1, #96]
	ldp	x6, x5, [x0]
	mul	x7, x8, x2
	umulh	x8, x8, x2
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	str	x8, [sp]                        // 8-byte Folded Spill
	umulh	x19, x9, x2
	mul	x9, x9, x2
	mul	x20, x10, x2
	umulh	x8, x10, x2
	mul	x21, x11, x2
	umulh	x11, x11, x2
	mul	x22, x12, x2
	umulh	x12, x12, x2
	mul	x23, x13, x2
	umulh	x13, x13, x2
	mul	x24, x14, x2
	umulh	x14, x14, x2
	mul	x25, x15, x2
	umulh	x15, x15, x2
	mul	x26, x16, x2
	umulh	x16, x16, x2
	mul	x27, x17, x2
	umulh	x17, x17, x2
	mul	x28, x18, x2
	umulh	x18, x18, x2
	mul	x29, x3, x2
	umulh	x3, x3, x2
	mul	x30, x4, x2
	umulh	x4, x4, x2
	mul	x10, x1, x2
	umulh	x1, x1, x2
	adds	x2, x7, x6
	adcs	x9, x9, x5
	ldp	x6, x5, [x0, #16]
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	adcs	x6, x20, x6
	ldp	x7, x20, [x0, #32]
	adcs	x5, x21, x5
	adcs	x7, x22, x7
	ldp	x21, x22, [x0, #48]
	adcs	x20, x23, x20
	adcs	x21, x24, x21
	ldp	x23, x24, [x0, #64]
	adcs	x22, x25, x22
	adcs	x23, x26, x23
	ldp	x25, x26, [x0, #80]
	adcs	x24, x27, x24
	ldp	x27, x8, [x0, #96]
	adcs	x25, x28, x25
	adcs	x26, x29, x26
	ldr	x28, [sp]                       // 8-byte Folded Reload
	adcs	x27, x30, x27
	adcs	x8, x10, x8
	adcs	x10, xzr, xzr
	adds	x9, x9, x28
	stp	x2, x9, [x0]
	ldr	x9, [sp, #8]                    // 8-byte Folded Reload
	adcs	x6, x6, x19
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x5, x9
	adcs	x11, x7, x11
	stp	x6, x9, [x0, #16]
	adcs	x9, x20, x12
	adcs	x12, x21, x13
	stp	x11, x9, [x0, #32]
	adcs	x9, x22, x14
	adcs	x11, x23, x15
	stp	x12, x9, [x0, #48]
	adcs	x9, x24, x16
	adcs	x12, x25, x17
	stp	x11, x9, [x0, #64]
	adcs	x9, x26, x18
	adcs	x11, x27, x3
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             // 16-byte Folded Reload
	stp	x12, x9, [x0, #80]
	adcs	x9, x8, x4
	adcs	x8, x10, x1
	stp	x11, x9, [x0, #96]
	mov	x0, x8
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end123:
	.size	mclb_mulUnitAdd14, .Lfunc_end123-mclb_mulUnitAdd14
                                        // -- End function
	.globl	mclb_mulUnit15                  // -- Begin function mclb_mulUnit15
	.p2align	2
	.type	mclb_mulUnit15,@function
mclb_mulUnit15:                         // @mclb_mulUnit15
// %bb.0:
	sub	sp, sp, #112                    // =112
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldr	x1, [x1, #112]
	mul	x6, x8, x2
	str	x6, [sp, #8]                    // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x7, x9, x2
	mul	x9, x9, x2
	mul	x19, x10, x2
	umulh	x6, x10, x2
	mul	x20, x11, x2
	umulh	x11, x11, x2
	mul	x21, x12, x2
	umulh	x12, x12, x2
	mul	x22, x13, x2
	umulh	x13, x13, x2
	mul	x23, x14, x2
	umulh	x14, x14, x2
	mul	x24, x15, x2
	umulh	x15, x15, x2
	mul	x25, x16, x2
	umulh	x16, x16, x2
	mul	x26, x17, x2
	umulh	x17, x17, x2
	mul	x27, x18, x2
	umulh	x18, x18, x2
	mul	x28, x3, x2
	umulh	x3, x3, x2
	mul	x29, x4, x2
	umulh	x4, x4, x2
	mul	x30, x5, x2
	umulh	x5, x5, x2
	mul	x10, x1, x2
	umulh	x1, x1, x2
	ldr	x2, [sp, #8]                    // 8-byte Folded Reload
	adds	x8, x8, x9
	adcs	x9, x7, x19
	stp	x2, x8, [x0]
	adcs	x8, x6, x20
	adcs	x11, x11, x21
	stp	x9, x8, [x0, #16]
	adcs	x8, x12, x22
	adcs	x9, x13, x23
	stp	x11, x8, [x0, #32]
	adcs	x8, x14, x24
	adcs	x11, x15, x25
	stp	x9, x8, [x0, #48]
	adcs	x8, x16, x26
	adcs	x9, x17, x27
	stp	x11, x8, [x0, #64]
	adcs	x8, x18, x28
	adcs	x11, x3, x29
	stp	x9, x8, [x0, #80]
	adcs	x8, x4, x30
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x5, x10
	stp	x11, x8, [x0, #96]
	adcs	x8, x1, xzr
	str	x9, [x0, #112]
	mov	x0, x8
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end124:
	.size	mclb_mulUnit15, .Lfunc_end124-mclb_mulUnit15
                                        // -- End function
	.globl	mclb_mulUnitAdd15               // -- Begin function mclb_mulUnitAdd15
	.p2align	2
	.type	mclb_mulUnitAdd15,@function
mclb_mulUnitAdd15:                      // @mclb_mulUnitAdd15
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	ldp	x12, x13, [x1, #32]
	mul	x7, x8, x2
	umulh	x8, x8, x2
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	umulh	x8, x9, x2
	str	x8, [sp]                        // 8-byte Folded Spill
	mul	x6, x9, x2
	umulh	x9, x10, x2
	umulh	x8, x11, x2
	mul	x19, x10, x2
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	ldp	x8, x10, [x0]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldr	x1, [x1, #112]
	ldr	x9, [x0, #16]
	adds	x8, x7, x8
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	mul	x20, x11, x2
	mul	x21, x12, x2
	umulh	x12, x12, x2
	mul	x22, x13, x2
	umulh	x13, x13, x2
	mul	x23, x14, x2
	umulh	x14, x14, x2
	mul	x24, x15, x2
	umulh	x15, x15, x2
	mul	x25, x16, x2
	umulh	x16, x16, x2
	mul	x26, x17, x2
	umulh	x17, x17, x2
	mul	x27, x18, x2
	umulh	x18, x18, x2
	mul	x28, x3, x2
	umulh	x3, x3, x2
	mul	x29, x4, x2
	umulh	x4, x4, x2
	mul	x30, x5, x2
	umulh	x5, x5, x2
	mul	x11, x1, x2
	umulh	x1, x1, x2
	adcs	x10, x6, x10
	ldp	x2, x6, [x0, #24]
	adcs	x9, x19, x9
	ldp	x7, x19, [x0, #40]
	adcs	x2, x20, x2
	adcs	x6, x21, x6
	ldp	x20, x21, [x0, #56]
	adcs	x7, x22, x7
	adcs	x19, x23, x19
	ldp	x22, x23, [x0, #72]
	adcs	x20, x24, x20
	adcs	x21, x25, x21
	ldp	x24, x25, [x0, #88]
	adcs	x22, x26, x22
	adcs	x23, x27, x23
	ldp	x26, x27, [x0, #104]
	adcs	x24, x28, x24
	adcs	x25, x29, x25
	ldr	x28, [sp, #8]                   // 8-byte Folded Reload
	adcs	x26, x30, x26
	adcs	x11, x11, x27
	adcs	x27, xzr, xzr
	adds	x10, x10, x28
	ldr	x28, [sp]                       // 8-byte Folded Reload
	stp	x8, x10, [x0]
	ldp	x10, x8, [sp, #16]              // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	adcs	x9, x9, x28
	adcs	x8, x2, x8
	adcs	x10, x6, x10
	stp	x9, x8, [x0, #16]
	adcs	x8, x7, x12
	adcs	x9, x19, x13
	stp	x10, x8, [x0, #32]
	adcs	x8, x20, x14
	adcs	x10, x21, x15
	stp	x9, x8, [x0, #48]
	adcs	x8, x22, x16
	adcs	x9, x23, x17
	stp	x10, x8, [x0, #64]
	adcs	x8, x24, x18
	adcs	x10, x25, x3
	stp	x9, x8, [x0, #80]
	adcs	x9, x26, x4
	adcs	x11, x11, x5
	adcs	x8, x27, x1
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	stp	x10, x9, [x0, #96]
	str	x11, [x0, #112]
	mov	x0, x8
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end125:
	.size	mclb_mulUnitAdd15, .Lfunc_end125-mclb_mulUnitAdd15
                                        // -- End function
	.globl	mclb_mulUnit16                  // -- Begin function mclb_mulUnit16
	.p2align	2
	.type	mclb_mulUnit16,@function
mclb_mulUnit16:                         // @mclb_mulUnit16
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldp	x6, x1, [x1, #112]
	mul	x7, x8, x2
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	str	x7, [sp, #24]                   // 8-byte Folded Spill
	mul	x20, x10, x2
	umulh	x7, x10, x2
	umulh	x10, x12, x2
	str	x10, [sp, #16]                  // 8-byte Folded Spill
	umulh	x10, x14, x2
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x19, x9, x2
	mul	x9, x9, x2
	mul	x21, x11, x2
	umulh	x11, x11, x2
	mul	x22, x12, x2
	mul	x23, x13, x2
	umulh	x13, x13, x2
	mul	x24, x14, x2
	str	x10, [sp, #8]                   // 8-byte Folded Spill
	mul	x25, x15, x2
	umulh	x15, x15, x2
	mul	x26, x16, x2
	umulh	x16, x16, x2
	mul	x27, x17, x2
	umulh	x17, x17, x2
	mul	x28, x18, x2
	umulh	x18, x18, x2
	mul	x29, x3, x2
	umulh	x3, x3, x2
	mul	x30, x4, x2
	umulh	x4, x4, x2
	mul	x12, x5, x2
	umulh	x5, x5, x2
	mul	x10, x6, x2
	umulh	x6, x6, x2
	mul	x14, x1, x2
	umulh	x1, x1, x2
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	adds	x8, x8, x9
	adcs	x9, x19, x20
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	stp	x2, x8, [x0]
	adcs	x8, x7, x21
	stp	x9, x8, [x0, #16]
	ldr	x8, [sp, #16]                   // 8-byte Folded Reload
	adcs	x11, x11, x22
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	adcs	x8, x8, x23
	stp	x11, x8, [x0, #32]
	ldr	x8, [sp, #8]                    // 8-byte Folded Reload
	adcs	x9, x13, x24
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	adcs	x8, x8, x25
	adcs	x11, x15, x26
	stp	x9, x8, [x0, #48]
	adcs	x8, x16, x27
	adcs	x9, x17, x28
	stp	x11, x8, [x0, #64]
	adcs	x8, x18, x29
	adcs	x11, x3, x30
	stp	x9, x8, [x0, #80]
	adcs	x8, x4, x12
	adcs	x9, x5, x10
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	adcs	x10, x6, x14
	stp	x11, x8, [x0, #96]
	adcs	x8, x1, xzr
	stp	x9, x10, [x0, #112]
	mov	x0, x8
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end126:
	.size	mclb_mulUnit16, .Lfunc_end126-mclb_mulUnit16
                                        // -- End function
	.globl	mclb_mulUnitAdd16               // -- Begin function mclb_mulUnitAdd16
	.p2align	2
	.type	mclb_mulUnitAdd16,@function
mclb_mulUnitAdd16:                      // @mclb_mulUnitAdd16
// %bb.0:
	sub	sp, sp, #144                    // =144
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	stp	x20, x19, [sp, #128]            // 16-byte Folded Spill
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldp	x6, x1, [x1, #112]
	mul	x19, x8, x2
	umulh	x8, x8, x2
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	umulh	x8, x9, x2
	str	x8, [sp]                        // 8-byte Folded Spill
	mul	x7, x9, x2
	umulh	x9, x10, x2
	umulh	x8, x12, x2
	mul	x20, x10, x2
	umulh	x10, x11, x2
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	umulh	x8, x13, x2
	stp	x29, x30, [sp, #48]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #64]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            // 16-byte Folded Spill
	mul	x21, x11, x2
	mul	x22, x12, x2
	mul	x23, x13, x2
	stp	x8, x10, [sp, #16]              // 16-byte Folded Spill
	mul	x24, x14, x2
	umulh	x14, x14, x2
	mul	x25, x15, x2
	umulh	x15, x15, x2
	mul	x26, x16, x2
	umulh	x16, x16, x2
	mul	x27, x17, x2
	umulh	x17, x17, x2
	mul	x28, x18, x2
	umulh	x18, x18, x2
	mul	x29, x3, x2
	umulh	x3, x3, x2
	mul	x30, x4, x2
	umulh	x4, x4, x2
	mul	x13, x5, x2
	umulh	x5, x5, x2
	mul	x12, x6, x2
	umulh	x6, x6, x2
	mul	x11, x1, x2
	umulh	x1, x1, x2
	ldp	x2, x8, [x0]
	ldp	x9, x10, [x0, #16]
	adds	x2, x19, x2
	adcs	x8, x7, x8
	ldp	x7, x19, [x0, #32]
	adcs	x9, x20, x9
	adcs	x10, x21, x10
	ldp	x20, x21, [x0, #48]
	adcs	x7, x22, x7
	adcs	x19, x23, x19
	ldp	x22, x23, [x0, #64]
	adcs	x20, x24, x20
	adcs	x21, x25, x21
	ldp	x24, x25, [x0, #80]
	adcs	x22, x26, x22
	adcs	x23, x27, x23
	ldp	x26, x27, [x0, #96]
	adcs	x24, x28, x24
	adcs	x25, x29, x25
	ldp	x28, x29, [x0, #112]
	adcs	x26, x30, x26
	adcs	x13, x13, x27
	adcs	x12, x12, x28
	ldr	x28, [sp, #8]                   // 8-byte Folded Reload
	adcs	x11, x11, x29
	adcs	x27, xzr, xzr
	ldp	x29, x30, [sp, #48]             // 16-byte Folded Reload
	adds	x8, x8, x28
	ldr	x28, [sp]                       // 8-byte Folded Reload
	stp	x2, x8, [x0]
	ldr	x8, [sp, #40]                   // 8-byte Folded Reload
	adcs	x9, x9, x28
	adcs	x8, x10, x8
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	stp	x9, x8, [x0, #16]
	ldr	x8, [sp, #32]                   // 8-byte Folded Reload
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	adcs	x10, x7, x10
	adcs	x8, x19, x8
	adcs	x9, x20, x9
	stp	x10, x8, [x0, #32]
	adcs	x8, x21, x14
	adcs	x10, x22, x15
	stp	x9, x8, [x0, #48]
	adcs	x8, x23, x16
	adcs	x9, x24, x17
	stp	x10, x8, [x0, #64]
	adcs	x8, x25, x18
	adcs	x10, x26, x3
	stp	x9, x8, [x0, #80]
	adcs	x8, x13, x4
	adcs	x9, x12, x5
	stp	x10, x8, [x0, #96]
	adcs	x10, x11, x6
	adcs	x8, x27, x1
	ldp	x20, x19, [sp, #128]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             // 16-byte Folded Reload
	stp	x9, x10, [x0, #112]
	mov	x0, x8
	add	sp, sp, #144                    // =144
	ret
.Lfunc_end127:
	.size	mclb_mulUnitAdd16, .Lfunc_end127-mclb_mulUnitAdd16
                                        // -- End function
	.globl	mclb_mulUnit17                  // -- Begin function mclb_mulUnit17
	.p2align	2
	.type	mclb_mulUnit17,@function
mclb_mulUnit17:                         // @mclb_mulUnit17
// %bb.0:
	sub	sp, sp, #144                    // =144
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x14, x15, [x1, #48]
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldp	x6, x7, [x1, #112]
	ldr	x1, [x1, #128]
	stp	x22, x21, [sp, #112]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            // 16-byte Folded Spill
	mul	x19, x8, x2
	mul	x21, x10, x2
	umulh	x10, x10, x2
	stp	x10, x19, [sp, #32]             // 16-byte Folded Spill
	mul	x22, x11, x2
	umulh	x19, x11, x2
	umulh	x11, x12, x2
	umulh	x10, x14, x2
	stp	x10, x11, [sp, #16]             // 16-byte Folded Spill
	umulh	x10, x16, x2
	stp	x29, x30, [sp, #48]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #64]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             // 16-byte Folded Spill
	umulh	x8, x8, x2
	umulh	x20, x9, x2
	mul	x9, x9, x2
	mul	x23, x12, x2
	mul	x24, x13, x2
	umulh	x13, x13, x2
	mul	x25, x14, x2
	mul	x26, x15, x2
	umulh	x15, x15, x2
	mul	x27, x16, x2
	str	x10, [sp, #8]                   // 8-byte Folded Spill
	mul	x28, x17, x2
	umulh	x17, x17, x2
	mul	x29, x18, x2
	umulh	x18, x18, x2
	mul	x30, x3, x2
	umulh	x3, x3, x2
	mul	x10, x4, x2
	umulh	x4, x4, x2
	mul	x16, x5, x2
	umulh	x5, x5, x2
	mul	x11, x6, x2
	umulh	x6, x6, x2
	mul	x14, x7, x2
	umulh	x7, x7, x2
	mul	x12, x1, x2
	umulh	x1, x1, x2
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	adds	x8, x8, x9
	adcs	x9, x20, x21
	stp	x2, x8, [x0]
	ldr	x8, [sp, #32]                   // 8-byte Folded Reload
	adcs	x8, x8, x22
	stp	x9, x8, [x0, #16]
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	adcs	x2, x19, x23
	ldp	x20, x19, [sp, #128]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            // 16-byte Folded Reload
	adcs	x8, x8, x24
	stp	x2, x8, [x0, #32]
	ldr	x8, [sp, #16]                   // 8-byte Folded Reload
	adcs	x9, x13, x25
	ldp	x24, x23, [sp, #96]             // 16-byte Folded Reload
	adcs	x8, x8, x26
	stp	x9, x8, [x0, #48]
	ldr	x8, [sp, #8]                    // 8-byte Folded Reload
	adcs	x13, x15, x27
	ldp	x26, x25, [sp, #80]             // 16-byte Folded Reload
	adcs	x8, x8, x28
	adcs	x9, x17, x29
	stp	x13, x8, [x0, #64]
	adcs	x8, x18, x30
	adcs	x10, x3, x10
	stp	x9, x8, [x0, #80]
	adcs	x8, x4, x16
	adcs	x9, x5, x11
	stp	x10, x8, [x0, #96]
	adcs	x8, x6, x14
	ldp	x28, x27, [sp, #64]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #48]             // 16-byte Folded Reload
	adcs	x10, x7, x12
	stp	x9, x8, [x0, #112]
	adcs	x8, x1, xzr
	str	x10, [x0, #128]
	mov	x0, x8
	add	sp, sp, #144                    // =144
	ret
.Lfunc_end128:
	.size	mclb_mulUnit17, .Lfunc_end128-mclb_mulUnit17
                                        // -- End function
	.globl	mclb_mulUnitAdd17               // -- Begin function mclb_mulUnitAdd17
	.p2align	2
	.type	mclb_mulUnitAdd17,@function
mclb_mulUnitAdd17:                      // @mclb_mulUnitAdd17
// %bb.0:
	sub	sp, sp, #160                    // =160
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	stp	x20, x19, [sp, #144]            // 16-byte Folded Spill
	ldp	x14, x15, [x1, #48]
	mul	x19, x8, x2
	umulh	x8, x8, x2
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	umulh	x8, x9, x2
	str	x8, [sp]                        // 8-byte Folded Spill
	mul	x20, x9, x2
	umulh	x9, x10, x2
	umulh	x8, x12, x2
	stp	x22, x21, [sp, #128]            // 16-byte Folded Spill
	mul	x21, x10, x2
	umulh	x10, x11, x2
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	umulh	x8, x13, x2
	stp	x8, x10, [sp, #24]              // 16-byte Folded Spill
	umulh	x8, x14, x2
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	umulh	x8, x15, x2
	ldp	x16, x17, [x1, #64]
	ldp	x18, x3, [x1, #80]
	ldp	x4, x5, [x1, #96]
	ldp	x6, x7, [x1, #112]
	ldr	x1, [x1, #128]
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	ldr	x8, [x0]
	stp	x29, x30, [sp, #64]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #80]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #96]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #112]            // 16-byte Folded Spill
	mul	x22, x11, x2
	mul	x23, x12, x2
	mul	x24, x13, x2
	mul	x25, x14, x2
	mul	x26, x15, x2
	mul	x27, x16, x2
	umulh	x16, x16, x2
	mul	x28, x17, x2
	umulh	x17, x17, x2
	mul	x29, x18, x2
	umulh	x18, x18, x2
	mul	x30, x3, x2
	umulh	x3, x3, x2
	mul	x12, x4, x2
	umulh	x4, x4, x2
	mul	x14, x5, x2
	umulh	x5, x5, x2
	mul	x13, x6, x2
	umulh	x6, x6, x2
	mul	x11, x7, x2
	umulh	x7, x7, x2
	mul	x10, x1, x2
	umulh	x1, x1, x2
	adds	x15, x19, x8
	ldp	x2, x19, [x0, #8]
	ldp	x8, x9, [x0, #24]
	adcs	x2, x20, x2
	adcs	x19, x21, x19
	ldp	x20, x21, [x0, #40]
	adcs	x8, x22, x8
	adcs	x9, x23, x9
	ldp	x22, x23, [x0, #56]
	adcs	x20, x24, x20
	adcs	x21, x25, x21
	ldp	x24, x25, [x0, #72]
	adcs	x22, x26, x22
	adcs	x23, x27, x23
	ldp	x26, x27, [x0, #88]
	adcs	x24, x28, x24
	adcs	x25, x29, x25
	adcs	x26, x30, x26
	adcs	x12, x12, x27
	ldp	x27, x28, [x0, #104]
	ldp	x29, x30, [x0, #120]
	adcs	x14, x14, x27
	adcs	x13, x13, x28
	ldr	x28, [sp, #8]                   // 8-byte Folded Reload
	adcs	x11, x11, x29
	adcs	x10, x10, x30
	adcs	x27, xzr, xzr
	adds	x2, x2, x28
	ldr	x28, [sp]                       // 8-byte Folded Reload
	stp	x15, x2, [x0]
	ldr	x15, [sp, #56]                  // 8-byte Folded Reload
	ldp	x29, x30, [sp, #64]             // 16-byte Folded Reload
	adcs	x19, x19, x28
	adcs	x8, x8, x15
	ldr	x15, [sp, #32]                  // 8-byte Folded Reload
	stp	x19, x8, [x0, #16]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	adcs	x9, x9, x15
	ldr	x15, [sp, #24]                  // 8-byte Folded Reload
	adcs	x8, x20, x8
	stp	x9, x8, [x0, #32]
	ldr	x8, [sp, #40]                   // 8-byte Folded Reload
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	adcs	x15, x21, x15
	ldp	x20, x19, [sp, #144]            // 16-byte Folded Reload
	adcs	x8, x22, x8
	adcs	x9, x23, x9
	stp	x15, x8, [x0, #48]
	adcs	x8, x24, x16
	adcs	x15, x25, x17
	stp	x9, x8, [x0, #64]
	adcs	x8, x26, x18
	adcs	x9, x12, x3
	stp	x15, x8, [x0, #80]
	adcs	x8, x14, x4
	adcs	x12, x13, x5
	stp	x9, x8, [x0, #96]
	adcs	x9, x11, x6
	adcs	x10, x10, x7
	adcs	x8, x27, x1
	ldp	x22, x21, [sp, #128]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             // 16-byte Folded Reload
	stp	x12, x9, [x0, #112]
	str	x10, [x0, #128]
	mov	x0, x8
	add	sp, sp, #160                    // =160
	ret
.Lfunc_end129:
	.size	mclb_mulUnitAdd17, .Lfunc_end129-mclb_mulUnitAdd17
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
