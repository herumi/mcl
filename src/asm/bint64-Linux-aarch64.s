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
	.globl	mclb_subNF1                     // -- Begin function mclb_subNF1
	.p2align	2
	.type	mclb_subNF1,@function
mclb_subNF1:                            // @mclb_subNF1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x2]
	sub	x9, x8, x9
	lsr	x8, x9, #63
	str	x9, [x0]
	mov	x0, x8
	ret
.Lfunc_end3:
	.size	mclb_subNF1, .Lfunc_end3-mclb_subNF1
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
.Lfunc_end4:
	.size	mclb_add2, .Lfunc_end4-mclb_add2
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
.Lfunc_end5:
	.size	mclb_sub2, .Lfunc_end5-mclb_sub2
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
.Lfunc_end6:
	.size	mclb_addNF2, .Lfunc_end6-mclb_addNF2
                                        // -- End function
	.globl	mclb_subNF2                     // -- Begin function mclb_subNF2
	.p2align	2
	.type	mclb_subNF2,@function
mclb_subNF2:                            // @mclb_subNF2
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x10, x11, [x2]
	subs	x9, x9, x10
	sbcs	x10, x8, x11
	lsr	x8, x10, #63
	stp	x9, x10, [x0]
	mov	x0, x8
	ret
.Lfunc_end7:
	.size	mclb_subNF2, .Lfunc_end7-mclb_subNF2
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
.Lfunc_end8:
	.size	mclb_add3, .Lfunc_end8-mclb_add3
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
.Lfunc_end9:
	.size	mclb_sub3, .Lfunc_end9-mclb_sub3
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
.Lfunc_end10:
	.size	mclb_addNF3, .Lfunc_end10-mclb_addNF3
                                        // -- End function
	.globl	mclb_subNF3                     // -- Begin function mclb_subNF3
	.p2align	2
	.type	mclb_subNF3,@function
mclb_subNF3:                            // @mclb_subNF3
// %bb.0:
	ldp	x9, x8, [x1]
	ldp	x11, x10, [x2]
	ldr	x12, [x1, #16]
	ldr	x13, [x2, #16]
	subs	x9, x9, x11
	sbcs	x8, x8, x10
	sbcs	x10, x12, x13
	stp	x9, x8, [x0]
	lsr	x8, x10, #63
	str	x10, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end11:
	.size	mclb_subNF3, .Lfunc_end11-mclb_subNF3
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
.Lfunc_end12:
	.size	mclb_add4, .Lfunc_end12-mclb_add4
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
.Lfunc_end13:
	.size	mclb_sub4, .Lfunc_end13-mclb_sub4
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
.Lfunc_end14:
	.size	mclb_addNF4, .Lfunc_end14-mclb_addNF4
                                        // -- End function
	.globl	mclb_subNF4                     // -- Begin function mclb_subNF4
	.p2align	2
	.type	mclb_subNF4,@function
mclb_subNF4:                            // @mclb_subNF4
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
	lsr	x8, x9, #63
	stp	x10, x9, [x0, #16]
	mov	x0, x8
	ret
.Lfunc_end15:
	.size	mclb_subNF4, .Lfunc_end15-mclb_subNF4
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
.Lfunc_end16:
	.size	mclb_add5, .Lfunc_end16-mclb_add5
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
.Lfunc_end17:
	.size	mclb_sub5, .Lfunc_end17-mclb_sub5
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
.Lfunc_end18:
	.size	mclb_addNF5, .Lfunc_end18-mclb_addNF5
                                        // -- End function
	.globl	mclb_subNF5                     // -- Begin function mclb_subNF5
	.p2align	2
	.type	mclb_subNF5,@function
mclb_subNF5:                            // @mclb_subNF5
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
	lsr	x8, x11, #63
	stp	x10, x9, [x0, #16]
	str	x11, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end19:
	.size	mclb_subNF5, .Lfunc_end19-mclb_subNF5
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
.Lfunc_end20:
	.size	mclb_add6, .Lfunc_end20-mclb_add6
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
.Lfunc_end21:
	.size	mclb_sub6, .Lfunc_end21-mclb_sub6
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
.Lfunc_end22:
	.size	mclb_addNF6, .Lfunc_end22-mclb_addNF6
                                        // -- End function
	.globl	mclb_subNF6                     // -- Begin function mclb_subNF6
	.p2align	2
	.type	mclb_subNF6,@function
mclb_subNF6:                            // @mclb_subNF6
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
	lsr	x8, x10, #63
	stp	x13, x12, [x0]
	stp	x9, x10, [x0, #32]
	mov	x0, x8
	ret
.Lfunc_end23:
	.size	mclb_subNF6, .Lfunc_end23-mclb_subNF6
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
.Lfunc_end24:
	.size	mclb_add7, .Lfunc_end24-mclb_add7
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
.Lfunc_end25:
	.size	mclb_sub7, .Lfunc_end25-mclb_sub7
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
.Lfunc_end26:
	.size	mclb_addNF7, .Lfunc_end26-mclb_addNF7
                                        // -- End function
	.globl	mclb_subNF7                     // -- Begin function mclb_subNF7
	.p2align	2
	.type	mclb_subNF7,@function
mclb_subNF7:                            // @mclb_subNF7
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
	lsr	x8, x11, #63
	stp	x14, x13, [x0]
	stp	x10, x9, [x0, #32]
	str	x11, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end27:
	.size	mclb_subNF7, .Lfunc_end27-mclb_subNF7
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
.Lfunc_end28:
	.size	mclb_add8, .Lfunc_end28-mclb_add8
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
.Lfunc_end29:
	.size	mclb_sub8, .Lfunc_end29-mclb_sub8
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
.Lfunc_end30:
	.size	mclb_addNF8, .Lfunc_end30-mclb_addNF8
                                        // -- End function
	.globl	mclb_subNF8                     // -- Begin function mclb_subNF8
	.p2align	2
	.type	mclb_subNF8,@function
mclb_subNF8:                            // @mclb_subNF8
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
	lsr	x8, x10, #63
	stp	x15, x14, [x0]
	stp	x13, x12, [x0, #16]
	stp	x9, x10, [x0, #48]
	mov	x0, x8
	ret
.Lfunc_end31:
	.size	mclb_subNF8, .Lfunc_end31-mclb_subNF8
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
.Lfunc_end32:
	.size	mclb_add9, .Lfunc_end32-mclb_add9
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
.Lfunc_end33:
	.size	mclb_sub9, .Lfunc_end33-mclb_sub9
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
.Lfunc_end34:
	.size	mclb_addNF9, .Lfunc_end34-mclb_addNF9
                                        // -- End function
	.globl	mclb_subNF9                     // -- Begin function mclb_subNF9
	.p2align	2
	.type	mclb_subNF9,@function
mclb_subNF9:                            // @mclb_subNF9
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
	lsr	x8, x11, #63
	stp	x16, x15, [x0]
	stp	x14, x13, [x0, #16]
	stp	x10, x9, [x0, #48]
	str	x11, [x0, #64]
	mov	x0, x8
	ret
.Lfunc_end35:
	.size	mclb_subNF9, .Lfunc_end35-mclb_subNF9
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
.Lfunc_end36:
	.size	mclb_add10, .Lfunc_end36-mclb_add10
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
.Lfunc_end37:
	.size	mclb_sub10, .Lfunc_end37-mclb_sub10
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
.Lfunc_end38:
	.size	mclb_addNF10, .Lfunc_end38-mclb_addNF10
                                        // -- End function
	.globl	mclb_subNF10                    // -- Begin function mclb_subNF10
	.p2align	2
	.type	mclb_subNF10,@function
mclb_subNF10:                           // @mclb_subNF10
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
	lsr	x8, x10, #63
	stp	x17, x16, [x0]
	stp	x15, x14, [x0, #16]
	stp	x13, x12, [x0, #32]
	stp	x9, x10, [x0, #64]
	mov	x0, x8
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end39:
	.size	mclb_subNF10, .Lfunc_end39-mclb_subNF10
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
.Lfunc_end40:
	.size	mclb_add11, .Lfunc_end40-mclb_add11
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
.Lfunc_end41:
	.size	mclb_sub11, .Lfunc_end41-mclb_sub11
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
.Lfunc_end42:
	.size	mclb_addNF11, .Lfunc_end42-mclb_addNF11
                                        // -- End function
	.globl	mclb_subNF11                    // -- Begin function mclb_subNF11
	.p2align	2
	.type	mclb_subNF11,@function
mclb_subNF11:                           // @mclb_subNF11
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
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #48]
	sbcs	x11, x8, x1
	lsr	x8, x11, #63
	stp	x18, x17, [x0]
	stp	x16, x15, [x0, #16]
	stp	x14, x13, [x0, #32]
	stp	x10, x9, [x0, #64]
	str	x11, [x0, #80]
	mov	x0, x8
	ldp	x22, x21, [sp], #32             // 16-byte Folded Reload
	ret
.Lfunc_end43:
	.size	mclb_subNF11, .Lfunc_end43-mclb_subNF11
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
.Lfunc_end44:
	.size	mclb_add12, .Lfunc_end44-mclb_add12
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
.Lfunc_end45:
	.size	mclb_sub12, .Lfunc_end45-mclb_sub12
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
.Lfunc_end46:
	.size	mclb_addNF12, .Lfunc_end46-mclb_addNF12
                                        // -- End function
	.globl	mclb_subNF12                    // -- Begin function mclb_subNF12
	.p2align	2
	.type	mclb_subNF12,@function
mclb_subNF12:                           // @mclb_subNF12
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
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	stp	x11, x10, [x0, #64]
	sbcs	x10, x8, x3
	lsr	x8, x10, #63
	stp	x1, x18, [x0]
	stp	x17, x16, [x0, #16]
	stp	x15, x14, [x0, #32]
	stp	x13, x12, [x0, #48]
	stp	x9, x10, [x0, #80]
	mov	x0, x8
	ldp	x24, x23, [sp], #48             // 16-byte Folded Reload
	ret
.Lfunc_end47:
	.size	mclb_subNF12, .Lfunc_end47-mclb_subNF12
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
.Lfunc_end48:
	.size	mclb_add13, .Lfunc_end48-mclb_add13
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
.Lfunc_end49:
	.size	mclb_sub13, .Lfunc_end49-mclb_sub13
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
.Lfunc_end50:
	.size	mclb_addNF13, .Lfunc_end50-mclb_addNF13
                                        // -- End function
	.globl	mclb_subNF13                    // -- Begin function mclb_subNF13
	.p2align	2
	.type	mclb_subNF13,@function
mclb_subNF13:                           // @mclb_subNF13
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
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #64]
	sbcs	x11, x8, x4
	lsr	x8, x11, #63
	stp	x1, x3, [x0]
	stp	x18, x17, [x0, #16]
	stp	x16, x15, [x0, #32]
	stp	x14, x13, [x0, #48]
	stp	x10, x9, [x0, #80]
	str	x11, [x0, #96]
	mov	x0, x8
	ldp	x26, x25, [sp], #64             // 16-byte Folded Reload
	ret
.Lfunc_end51:
	.size	mclb_subNF13, .Lfunc_end51-mclb_subNF13
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
.Lfunc_end52:
	.size	mclb_add14, .Lfunc_end52-mclb_add14
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
.Lfunc_end53:
	.size	mclb_sub14, .Lfunc_end53-mclb_sub14
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
.Lfunc_end54:
	.size	mclb_addNF14, .Lfunc_end54-mclb_addNF14
                                        // -- End function
	.globl	mclb_subNF14                    // -- Begin function mclb_subNF14
	.p2align	2
	.type	mclb_subNF14,@function
mclb_subNF14:                           // @mclb_subNF14
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
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	stp	x11, x10, [x0, #80]
	sbcs	x10, x8, x5
	lsr	x8, x10, #63
	stp	x1, x4, [x0]
	stp	x3, x18, [x0, #16]
	stp	x17, x16, [x0, #32]
	stp	x15, x14, [x0, #48]
	stp	x13, x12, [x0, #64]
	stp	x9, x10, [x0, #96]
	mov	x0, x8
	ldp	x28, x27, [sp], #80             // 16-byte Folded Reload
	ret
.Lfunc_end55:
	.size	mclb_subNF14, .Lfunc_end55-mclb_subNF14
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
.Lfunc_end56:
	.size	mclb_add15, .Lfunc_end56-mclb_add15
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
.Lfunc_end57:
	.size	mclb_sub15, .Lfunc_end57-mclb_sub15
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
.Lfunc_end58:
	.size	mclb_addNF15, .Lfunc_end58-mclb_addNF15
                                        // -- End function
	.globl	mclb_subNF15                    // -- Begin function mclb_subNF15
	.p2align	2
	.type	mclb_subNF15,@function
mclb_subNF15:                           // @mclb_subNF15
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
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	stp	x12, x11, [x0, #80]
	sbcs	x11, x8, x6
	lsr	x8, x11, #63
	stp	x4, x1, [x0, #16]
	stp	x18, x17, [x0, #32]
	stp	x16, x15, [x0, #48]
	stp	x14, x13, [x0, #64]
	stp	x10, x9, [x0, #96]
	str	x11, [x0, #112]
	mov	x0, x8
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end59:
	.size	mclb_subNF15, .Lfunc_end59-mclb_subNF15
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
.Lfunc_end60:
	.size	mclb_add16, .Lfunc_end60-mclb_add16
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
.Lfunc_end61:
	.size	mclb_sub16, .Lfunc_end61-mclb_sub16
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
.Lfunc_end62:
	.size	mclb_addNF16, .Lfunc_end62-mclb_addNF16
                                        // -- End function
	.globl	mclb_subNF16                    // -- Begin function mclb_subNF16
	.p2align	2
	.type	mclb_subNF16,@function
mclb_subNF16:                           // @mclb_subNF16
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
	lsr	x8, x10, #63
	stp	x9, x10, [x0, #112]
	mov	x0, x8
	ret
.Lfunc_end63:
	.size	mclb_subNF16, .Lfunc_end63-mclb_subNF16
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
.Lfunc_end64:
	.size	mclb_add17, .Lfunc_end64-mclb_add17
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
.Lfunc_end65:
	.size	mclb_sub17, .Lfunc_end65-mclb_sub17
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
.Lfunc_end66:
	.size	mclb_addNF17, .Lfunc_end66-mclb_addNF17
                                        // -- End function
	.globl	mclb_subNF17                    // -- Begin function mclb_subNF17
	.p2align	2
	.type	mclb_subNF17,@function
mclb_subNF17:                           // @mclb_subNF17
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
	lsr	x8, x10, #63
	str	x10, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end67:
	.size	mclb_subNF17, .Lfunc_end67-mclb_subNF17
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
.Lfunc_end68:
	.size	mclb_add18, .Lfunc_end68-mclb_add18
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
.Lfunc_end69:
	.size	mclb_sub18, .Lfunc_end69-mclb_sub18
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
.Lfunc_end70:
	.size	mclb_addNF18, .Lfunc_end70-mclb_addNF18
                                        // -- End function
	.globl	mclb_subNF18                    // -- Begin function mclb_subNF18
	.p2align	2
	.type	mclb_subNF18,@function
mclb_subNF18:                           // @mclb_subNF18
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
	lsr	x8, x9, #63
	stp	x10, x9, [x0, #128]
	mov	x0, x8
	ret
.Lfunc_end71:
	.size	mclb_subNF18, .Lfunc_end71-mclb_subNF18
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
.Lfunc_end72:
	.size	mclb_add19, .Lfunc_end72-mclb_add19
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
.Lfunc_end73:
	.size	mclb_sub19, .Lfunc_end73-mclb_sub19
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
.Lfunc_end74:
	.size	mclb_addNF19, .Lfunc_end74-mclb_addNF19
                                        // -- End function
	.globl	mclb_subNF19                    // -- Begin function mclb_subNF19
	.p2align	2
	.type	mclb_subNF19,@function
mclb_subNF19:                           // @mclb_subNF19
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
	lsr	x8, x10, #63
	str	x10, [x0, #144]
	mov	x0, x8
	ret
.Lfunc_end75:
	.size	mclb_subNF19, .Lfunc_end75-mclb_subNF19
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
.Lfunc_end76:
	.size	mclb_add20, .Lfunc_end76-mclb_add20
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
.Lfunc_end77:
	.size	mclb_sub20, .Lfunc_end77-mclb_sub20
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
.Lfunc_end78:
	.size	mclb_addNF20, .Lfunc_end78-mclb_addNF20
                                        // -- End function
	.globl	mclb_subNF20                    // -- Begin function mclb_subNF20
	.p2align	2
	.type	mclb_subNF20,@function
mclb_subNF20:                           // @mclb_subNF20
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
	lsr	x8, x9, #63
	mov	x0, x8
	ret
.Lfunc_end79:
	.size	mclb_subNF20, .Lfunc_end79-mclb_subNF20
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
.Lfunc_end80:
	.size	mclb_add21, .Lfunc_end80-mclb_add21
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
.Lfunc_end81:
	.size	mclb_sub21, .Lfunc_end81-mclb_sub21
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
.Lfunc_end82:
	.size	mclb_addNF21, .Lfunc_end82-mclb_addNF21
                                        // -- End function
	.globl	mclb_subNF21                    // -- Begin function mclb_subNF21
	.p2align	2
	.type	mclb_subNF21,@function
mclb_subNF21:                           // @mclb_subNF21
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
	lsr	x8, x10, #63
	str	x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end83:
	.size	mclb_subNF21, .Lfunc_end83-mclb_subNF21
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
.Lfunc_end84:
	.size	mclb_add22, .Lfunc_end84-mclb_add22
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
.Lfunc_end85:
	.size	mclb_sub22, .Lfunc_end85-mclb_sub22
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
.Lfunc_end86:
	.size	mclb_addNF22, .Lfunc_end86-mclb_addNF22
                                        // -- End function
	.globl	mclb_subNF22                    // -- Begin function mclb_subNF22
	.p2align	2
	.type	mclb_subNF22,@function
mclb_subNF22:                           // @mclb_subNF22
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
	lsr	x8, x10, #63
	stp	x9, x10, [x0, #160]
	mov	x0, x8
	ret
.Lfunc_end87:
	.size	mclb_subNF22, .Lfunc_end87-mclb_subNF22
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
.Lfunc_end88:
	.size	mclb_add23, .Lfunc_end88-mclb_add23
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
.Lfunc_end89:
	.size	mclb_sub23, .Lfunc_end89-mclb_sub23
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
.Lfunc_end90:
	.size	mclb_addNF23, .Lfunc_end90-mclb_addNF23
                                        // -- End function
	.globl	mclb_subNF23                    // -- Begin function mclb_subNF23
	.p2align	2
	.type	mclb_subNF23,@function
mclb_subNF23:                           // @mclb_subNF23
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
	lsr	x8, x10, #63
	str	x10, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end91:
	.size	mclb_subNF23, .Lfunc_end91-mclb_subNF23
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
.Lfunc_end92:
	.size	mclb_add24, .Lfunc_end92-mclb_add24
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
.Lfunc_end93:
	.size	mclb_sub24, .Lfunc_end93-mclb_sub24
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
.Lfunc_end94:
	.size	mclb_addNF24, .Lfunc_end94-mclb_addNF24
                                        // -- End function
	.globl	mclb_subNF24                    // -- Begin function mclb_subNF24
	.p2align	2
	.type	mclb_subNF24,@function
mclb_subNF24:                           // @mclb_subNF24
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
	lsr	x8, x9, #63
	stp	x10, x9, [x0, #176]
	mov	x0, x8
	ret
.Lfunc_end95:
	.size	mclb_subNF24, .Lfunc_end95-mclb_subNF24
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
.Lfunc_end96:
	.size	mclb_add25, .Lfunc_end96-mclb_add25
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
.Lfunc_end97:
	.size	mclb_sub25, .Lfunc_end97-mclb_sub25
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
.Lfunc_end98:
	.size	mclb_addNF25, .Lfunc_end98-mclb_addNF25
                                        // -- End function
	.globl	mclb_subNF25                    // -- Begin function mclb_subNF25
	.p2align	2
	.type	mclb_subNF25,@function
mclb_subNF25:                           // @mclb_subNF25
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
	lsr	x8, x10, #63
	str	x10, [x0, #192]
	mov	x0, x8
	ret
.Lfunc_end99:
	.size	mclb_subNF25, .Lfunc_end99-mclb_subNF25
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
.Lfunc_end100:
	.size	mclb_add26, .Lfunc_end100-mclb_add26
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
.Lfunc_end101:
	.size	mclb_sub26, .Lfunc_end101-mclb_sub26
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
.Lfunc_end102:
	.size	mclb_addNF26, .Lfunc_end102-mclb_addNF26
                                        // -- End function
	.globl	mclb_subNF26                    // -- Begin function mclb_subNF26
	.p2align	2
	.type	mclb_subNF26,@function
mclb_subNF26:                           // @mclb_subNF26
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
	lsr	x8, x9, #63
	mov	x0, x8
	ret
.Lfunc_end103:
	.size	mclb_subNF26, .Lfunc_end103-mclb_subNF26
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
.Lfunc_end104:
	.size	mclb_add27, .Lfunc_end104-mclb_add27
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
.Lfunc_end105:
	.size	mclb_sub27, .Lfunc_end105-mclb_sub27
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
.Lfunc_end106:
	.size	mclb_addNF27, .Lfunc_end106-mclb_addNF27
                                        // -- End function
	.globl	mclb_subNF27                    // -- Begin function mclb_subNF27
	.p2align	2
	.type	mclb_subNF27,@function
mclb_subNF27:                           // @mclb_subNF27
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
	lsr	x8, x10, #63
	str	x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end107:
	.size	mclb_subNF27, .Lfunc_end107-mclb_subNF27
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
.Lfunc_end108:
	.size	mclb_add28, .Lfunc_end108-mclb_add28
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
.Lfunc_end109:
	.size	mclb_sub28, .Lfunc_end109-mclb_sub28
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
.Lfunc_end110:
	.size	mclb_addNF28, .Lfunc_end110-mclb_addNF28
                                        // -- End function
	.globl	mclb_subNF28                    // -- Begin function mclb_subNF28
	.p2align	2
	.type	mclb_subNF28,@function
mclb_subNF28:                           // @mclb_subNF28
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
	lsr	x8, x10, #63
	stp	x9, x10, [x0, #208]
	mov	x0, x8
	ret
.Lfunc_end111:
	.size	mclb_subNF28, .Lfunc_end111-mclb_subNF28
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
.Lfunc_end112:
	.size	mclb_add29, .Lfunc_end112-mclb_add29
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
.Lfunc_end113:
	.size	mclb_sub29, .Lfunc_end113-mclb_sub29
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
.Lfunc_end114:
	.size	mclb_addNF29, .Lfunc_end114-mclb_addNF29
                                        // -- End function
	.globl	mclb_subNF29                    // -- Begin function mclb_subNF29
	.p2align	2
	.type	mclb_subNF29,@function
mclb_subNF29:                           // @mclb_subNF29
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
	lsr	x8, x10, #63
	str	x10, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end115:
	.size	mclb_subNF29, .Lfunc_end115-mclb_subNF29
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
.Lfunc_end116:
	.size	mclb_add30, .Lfunc_end116-mclb_add30
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
.Lfunc_end117:
	.size	mclb_sub30, .Lfunc_end117-mclb_sub30
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
.Lfunc_end118:
	.size	mclb_addNF30, .Lfunc_end118-mclb_addNF30
                                        // -- End function
	.globl	mclb_subNF30                    // -- Begin function mclb_subNF30
	.p2align	2
	.type	mclb_subNF30,@function
mclb_subNF30:                           // @mclb_subNF30
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
	lsr	x8, x9, #63
	stp	x10, x9, [x0, #224]
	mov	x0, x8
	ret
.Lfunc_end119:
	.size	mclb_subNF30, .Lfunc_end119-mclb_subNF30
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
.Lfunc_end120:
	.size	mclb_add31, .Lfunc_end120-mclb_add31
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
.Lfunc_end121:
	.size	mclb_sub31, .Lfunc_end121-mclb_sub31
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
.Lfunc_end122:
	.size	mclb_addNF31, .Lfunc_end122-mclb_addNF31
                                        // -- End function
	.globl	mclb_subNF31                    // -- Begin function mclb_subNF31
	.p2align	2
	.type	mclb_subNF31,@function
mclb_subNF31:                           // @mclb_subNF31
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
	lsr	x8, x10, #63
	str	x10, [x0, #240]
	mov	x0, x8
	ret
.Lfunc_end123:
	.size	mclb_subNF31, .Lfunc_end123-mclb_subNF31
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
.Lfunc_end124:
	.size	mclb_add32, .Lfunc_end124-mclb_add32
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
.Lfunc_end125:
	.size	mclb_sub32, .Lfunc_end125-mclb_sub32
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
.Lfunc_end126:
	.size	mclb_addNF32, .Lfunc_end126-mclb_addNF32
                                        // -- End function
	.globl	mclb_subNF32                    // -- Begin function mclb_subNF32
	.p2align	2
	.type	mclb_subNF32,@function
mclb_subNF32:                           // @mclb_subNF32
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
	lsr	x8, x9, #63
	mov	x0, x8
	ret
.Lfunc_end127:
	.size	mclb_subNF32, .Lfunc_end127-mclb_subNF32
                                        // -- End function
	.globl	mulUnit_inner64                 // -- Begin function mulUnit_inner64
	.p2align	2
	.type	mulUnit_inner64,@function
mulUnit_inner64:                        // @mulUnit_inner64
// %bb.0:
	ldr	x8, [x0]
	mul	x0, x8, x1
	umulh	x1, x8, x1
	ret
.Lfunc_end128:
	.size	mulUnit_inner64, .Lfunc_end128-mulUnit_inner64
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
.Lfunc_end129:
	.size	mclb_mulUnit1, .Lfunc_end129-mclb_mulUnit1
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
.Lfunc_end130:
	.size	mclb_mulUnitAdd1, .Lfunc_end130-mclb_mulUnitAdd1
                                        // -- End function
	.globl	mclb_mul1                       // -- Begin function mclb_mul1
	.p2align	2
	.type	mclb_mul1,@function
mclb_mul1:                              // @mclb_mul1
// %bb.0:
	ldr	x8, [x1]
	ldr	x9, [x2]
	umulh	x10, x9, x8
	mul	x8, x9, x8
	stp	x8, x10, [x0]
	ret
.Lfunc_end131:
	.size	mclb_mul1, .Lfunc_end131-mclb_mul1
                                        // -- End function
	.globl	mclb_sqr1                       // -- Begin function mclb_sqr1
	.p2align	2
	.type	mclb_sqr1,@function
mclb_sqr1:                              // @mclb_sqr1
// %bb.0:
	ldr	x8, [x1]
	umulh	x9, x8, x8
	mul	x8, x8, x8
	stp	x8, x9, [x0]
	ret
.Lfunc_end132:
	.size	mclb_sqr1, .Lfunc_end132-mclb_sqr1
                                        // -- End function
	.globl	mulUnit_inner128                // -- Begin function mulUnit_inner128
	.p2align	2
	.type	mulUnit_inner128,@function
mulUnit_inner128:                       // @mulUnit_inner128
// %bb.0:
	ldp	x8, x9, [x0]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x10, x9, x1
	mul	x9, x9, x1
	adds	x1, x8, x9
	adcs	x2, x10, xzr
	ret
.Lfunc_end133:
	.size	mulUnit_inner128, .Lfunc_end133-mulUnit_inner128
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
.Lfunc_end134:
	.size	mclb_mulUnit2, .Lfunc_end134-mclb_mulUnit2
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
.Lfunc_end135:
	.size	mclb_mulUnitAdd2, .Lfunc_end135-mclb_mulUnitAdd2
                                        // -- End function
	.globl	mclb_mul2                       // -- Begin function mclb_mul2
	.p2align	2
	.type	mclb_mul2,@function
mclb_mul2:                              // @mclb_mul2
// %bb.0:
	ldp	x8, x11, [x2]
	ldp	x9, x10, [x1]
	mul	x12, x9, x8
	umulh	x13, x9, x8
	umulh	x14, x10, x8
	mul	x8, x10, x8
	adds	x8, x13, x8
	mul	x15, x11, x9
	umulh	x9, x11, x9
	umulh	x16, x11, x10
	mul	x10, x11, x10
	adcs	x11, x14, xzr
	adds	x9, x9, x10
	adcs	x10, x16, xzr
	adds	x8, x15, x8
	adcs	x9, x9, x11
	stp	x12, x8, [x0]
	adcs	x8, x10, xzr
	stp	x9, x8, [x0, #16]
	ret
.Lfunc_end136:
	.size	mclb_mul2, .Lfunc_end136-mclb_mul2
                                        // -- End function
	.globl	mclb_sqr2                       // -- Begin function mclb_sqr2
	.p2align	2
	.type	mclb_sqr2,@function
mclb_sqr2:                              // @mclb_sqr2
// %bb.0:
	ldp	x8, x9, [x1]
	umulh	x10, x8, x8
	mul	x12, x9, x8
	umulh	x11, x9, x8
	adds	x10, x10, x12
	mul	x13, x9, x9
	adcs	x14, x11, xzr
	adds	x11, x11, x13
	umulh	x9, x9, x9
	adcs	x9, x9, xzr
	adds	x10, x12, x10
	mul	x8, x8, x8
	adcs	x11, x11, x14
	stp	x8, x10, [x0]
	adcs	x8, x9, xzr
	stp	x11, x8, [x0, #16]
	ret
.Lfunc_end137:
	.size	mclb_sqr2, .Lfunc_end137-mclb_sqr2
                                        // -- End function
	.globl	mulUnit_inner192                // -- Begin function mulUnit_inner192
	.p2align	2
	.type	mulUnit_inner192,@function
mulUnit_inner192:                       // @mulUnit_inner192
// %bb.0:
	ldp	x8, x9, [x0]
	ldr	x10, [x0, #16]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x11, x9, x1
	mul	x9, x9, x1
	mul	x12, x10, x1
	umulh	x10, x10, x1
	adds	x1, x8, x9
	adcs	x2, x11, x12
	adcs	x3, x10, xzr
	ret
.Lfunc_end138:
	.size	mulUnit_inner192, .Lfunc_end138-mulUnit_inner192
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
.Lfunc_end139:
	.size	mclb_mulUnit3, .Lfunc_end139-mclb_mulUnit3
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
.Lfunc_end140:
	.size	mclb_mulUnitAdd3, .Lfunc_end140-mclb_mulUnitAdd3
                                        // -- End function
	.globl	mclb_mul3                       // -- Begin function mclb_mul3
	.p2align	2
	.type	mclb_mul3,@function
mclb_mul3:                              // @mclb_mul3
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x12, [x2]
	ldr	x11, [x1, #16]
	ldr	x13, [x2, #16]
	umulh	x15, x8, x10
	mul	x17, x9, x10
	mul	x14, x8, x10
	umulh	x16, x9, x10
	umulh	x18, x11, x10
	mul	x10, x11, x10
	mul	x1, x12, x8
	umulh	x2, x12, x8
	umulh	x3, x12, x9
	mul	x4, x12, x9
	mul	x5, x12, x11
	umulh	x12, x12, x11
	mul	x6, x13, x8
	umulh	x8, x13, x8
	umulh	x7, x13, x9
	mul	x9, x13, x9
	mul	x19, x13, x11
	umulh	x11, x13, x11
	adds	x13, x15, x17
	adcs	x10, x16, x10
	adcs	x15, x18, xzr
	adds	x16, x2, x4
	adcs	x17, x3, x5
	adcs	x12, x12, xzr
	adds	x13, x1, x13
	adcs	x10, x16, x10
	stp	x14, x13, [x0]
	adcs	x13, x17, x15
	adcs	x12, x12, xzr
	adds	x8, x8, x9
	adcs	x9, x7, x19
	adcs	x11, x11, xzr
	adds	x10, x6, x10
	adcs	x8, x8, x13
	adcs	x9, x9, x12
	stp	x10, x8, [x0, #16]
	adcs	x8, x11, xzr
	stp	x9, x8, [x0, #32]
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end141:
	.size	mclb_mul3, .Lfunc_end141-mclb_mul3
                                        // -- End function
	.globl	mclb_sqr3                       // -- Begin function mclb_sqr3
	.p2align	2
	.type	mclb_sqr3,@function
mclb_sqr3:                              // @mclb_sqr3
// %bb.0:
	ldp	x8, x9, [x1]
	ldr	x10, [x1, #16]
	umulh	x11, x8, x8
	mul	x13, x9, x8
	umulh	x12, x9, x8
	mul	x15, x10, x8
	adds	x11, x11, x13
	umulh	x14, x10, x8
	adcs	x1, x12, x15
	mul	x17, x9, x9
	adcs	x2, x14, xzr
	umulh	x16, x9, x9
	umulh	x18, x10, x9
	mul	x9, x10, x9
	adds	x12, x12, x17
	adcs	x16, x16, x9
	adcs	x17, x18, xzr
	adds	x11, x13, x11
	mul	x8, x8, x8
	adcs	x12, x12, x1
	stp	x8, x11, [x0]
	adcs	x8, x16, x2
	adcs	x11, x17, xzr
	umulh	x13, x10, x10
	mul	x10, x10, x10
	adds	x9, x14, x9
	adcs	x10, x18, x10
	adcs	x13, x13, xzr
	adds	x12, x15, x12
	adcs	x8, x9, x8
	adcs	x9, x10, x11
	stp	x12, x8, [x0, #16]
	adcs	x8, x13, xzr
	stp	x9, x8, [x0, #32]
	ret
.Lfunc_end142:
	.size	mclb_sqr3, .Lfunc_end142-mclb_sqr3
                                        // -- End function
	.globl	mulUnit_inner256                // -- Begin function mulUnit_inner256
	.p2align	2
	.type	mulUnit_inner256,@function
mulUnit_inner256:                       // @mulUnit_inner256
// %bb.0:
	ldp	x8, x9, [x0]
	ldp	x10, x11, [x0, #16]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x12, x9, x1
	mul	x9, x9, x1
	mul	x13, x10, x1
	umulh	x10, x10, x1
	mul	x14, x11, x1
	umulh	x11, x11, x1
	adds	x1, x8, x9
	adcs	x2, x12, x13
	adcs	x3, x10, x14
	adcs	x4, x11, xzr
	ret
.Lfunc_end143:
	.size	mulUnit_inner256, .Lfunc_end143-mulUnit_inner256
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
.Lfunc_end144:
	.size	mclb_mulUnit4, .Lfunc_end144-mclb_mulUnit4
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
.Lfunc_end145:
	.size	mclb_mulUnitAdd4, .Lfunc_end145-mclb_mulUnitAdd4
                                        // -- End function
	.globl	mclb_mul4                       // -- Begin function mclb_mul4
	.p2align	2
	.type	mclb_mul4,@function
mclb_mul4:                              // @mclb_mul4
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x2]
	ldp	x14, x15, [x2, #16]
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	mul	x5, x13, x8
	umulh	x23, x13, x8
	umulh	x30, x13, x9
	mul	x19, x13, x9
	mul	x20, x13, x10
	umulh	x21, x13, x10
	mul	x22, x13, x11
	umulh	x7, x13, x11
	mul	x13, x14, x8
	mul	x16, x8, x12
	umulh	x17, x8, x12
	mul	x1, x9, x12
	str	x13, [sp, #8]                   // 8-byte Folded Spill
	mul	x13, x15, x8
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	str	x16, [sp, #24]                  // 8-byte Folded Spill
	umulh	x18, x9, x12
	umulh	x2, x10, x12
	mul	x3, x10, x12
	umulh	x4, x11, x12
	mul	x12, x11, x12
	umulh	x24, x14, x8
	umulh	x25, x14, x9
	mul	x26, x14, x9
	mul	x27, x14, x10
	umulh	x28, x14, x10
	mul	x29, x14, x11
	umulh	x14, x14, x11
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	umulh	x6, x15, x8
	umulh	x16, x15, x9
	mul	x9, x15, x9
	mul	x13, x15, x10
	umulh	x10, x15, x10
	mul	x8, x15, x11
	umulh	x11, x15, x11
	adds	x15, x17, x1
	adcs	x17, x18, x3
	adcs	x12, x2, x12
	adcs	x18, x4, xzr
	ldr	x1, [sp, #24]                   // 8-byte Folded Reload
	adds	x15, x15, x5
	adcs	x17, x17, x19
	adcs	x12, x12, x20
	stp	x1, x15, [x0]
	adcs	x15, x18, x22
	adcs	x18, xzr, xzr
	adds	x17, x17, x23
	adcs	x12, x12, x30
	adcs	x15, x15, x21
	adcs	x18, x18, x7
	adds	x1, x24, x26
	ldr	x4, [sp, #8]                    // 8-byte Folded Reload
	adcs	x2, x25, x27
	adcs	x3, x28, x29
	adcs	x14, x14, xzr
	adds	x17, x4, x17
	adcs	x12, x1, x12
	adcs	x15, x2, x15
	adcs	x18, x3, x18
	adcs	x14, x14, xzr
	adds	x9, x6, x9
	adcs	x13, x16, x13
	adcs	x8, x10, x8
	adcs	x10, x11, xzr
	ldr	x11, [sp, #16]                  // 8-byte Folded Reload
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	adds	x11, x11, x12
	adcs	x9, x9, x15
	stp	x17, x11, [x0, #16]
	adcs	x11, x13, x18
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	adcs	x8, x8, x14
	stp	x9, x11, [x0, #32]
	adcs	x9, x10, xzr
	stp	x8, x9, [x0, #48]
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end146:
	.size	mclb_mul4, .Lfunc_end146-mclb_mul4
                                        // -- End function
	.globl	mclb_sqr4                       // -- Begin function mclb_sqr4
	.p2align	2
	.type	mclb_sqr4,@function
mclb_sqr4:                              // @mclb_sqr4
// %bb.0:
	stp	x20, x19, [sp, #-16]!           // 16-byte Folded Spill
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	umulh	x13, x8, x8
	mul	x15, x9, x8
	umulh	x14, x9, x8
	mul	x17, x10, x8
	adds	x13, x13, x15
	mul	x12, x8, x8
	umulh	x16, x10, x8
	umulh	x18, x11, x8
	mul	x8, x11, x8
	adcs	x6, x14, x17
	adcs	x7, x16, x8
	mul	x2, x9, x9
	adcs	x19, x18, xzr
	umulh	x1, x9, x9
	mul	x4, x10, x9
	adds	x14, x14, x2
	umulh	x3, x10, x9
	umulh	x5, x11, x9
	mul	x9, x11, x9
	adcs	x1, x1, x4
	adcs	x2, x3, x9
	adcs	x20, x5, xzr
	adds	x13, x15, x13
	adcs	x14, x14, x6
	stp	x12, x13, [x0]
	adcs	x13, x1, x7
	adcs	x2, x2, x19
	adcs	x7, x20, xzr
	mul	x6, x10, x10
	adds	x16, x16, x4
	umulh	x15, x10, x10
	umulh	x12, x11, x10
	mul	x10, x11, x10
	adcs	x3, x3, x6
	adcs	x15, x15, x10
	adcs	x4, x12, xzr
	adds	x14, x17, x14
	adcs	x13, x16, x13
	adcs	x16, x3, x2
	adcs	x15, x15, x7
	adcs	x17, x4, xzr
	adds	x9, x18, x9
	umulh	x1, x11, x11
	mul	x11, x11, x11
	adcs	x10, x5, x10
	adcs	x11, x12, x11
	adcs	x12, x1, xzr
	adds	x8, x8, x13
	adcs	x9, x9, x16
	stp	x14, x8, [x0, #16]
	adcs	x8, x10, x15
	adcs	x10, x11, x17
	stp	x9, x8, [x0, #32]
	adcs	x8, x12, xzr
	stp	x10, x8, [x0, #48]
	ldp	x20, x19, [sp], #16             // 16-byte Folded Reload
	ret
.Lfunc_end147:
	.size	mclb_sqr4, .Lfunc_end147-mclb_sqr4
                                        // -- End function
	.globl	mulUnit_inner320                // -- Begin function mulUnit_inner320
	.p2align	2
	.type	mulUnit_inner320,@function
mulUnit_inner320:                       // @mulUnit_inner320
// %bb.0:
	ldp	x8, x9, [x0]
	ldp	x10, x11, [x0, #16]
	ldr	x12, [x0, #32]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x13, x9, x1
	mul	x9, x9, x1
	mul	x14, x10, x1
	umulh	x10, x10, x1
	mul	x15, x11, x1
	umulh	x11, x11, x1
	mul	x16, x12, x1
	umulh	x12, x12, x1
	adds	x1, x8, x9
	adcs	x2, x13, x14
	adcs	x3, x10, x15
	adcs	x4, x11, x16
	adcs	x5, x12, xzr
	ret
.Lfunc_end148:
	.size	mulUnit_inner320, .Lfunc_end148-mulUnit_inner320
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
.Lfunc_end149:
	.size	mclb_mulUnit5, .Lfunc_end149-mclb_mulUnit5
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
.Lfunc_end150:
	.size	mclb_mulUnitAdd5, .Lfunc_end150-mclb_mulUnitAdd5
                                        // -- End function
	.globl	mclb_mul5                       // -- Begin function mclb_mul5
	.p2align	2
	.type	mclb_mul5,@function
mclb_mul5:                              // @mclb_mul5
// %bb.0:
	sub	sp, sp, #288                    // =288
	ldp	x8, x9, [x1]
	ldp	x13, x14, [x2]
	ldp	x10, x11, [x1, #16]
	ldr	x12, [x1, #32]
	stp	x29, x30, [sp, #192]            // 16-byte Folded Spill
	mul	x18, x8, x13
	str	x18, [sp, #176]                 // 8-byte Folded Spill
	umulh	x18, x8, x13
	str	x18, [sp, #120]                 // 8-byte Folded Spill
	umulh	x18, x9, x13
	str	x18, [sp, #112]                 // 8-byte Folded Spill
	mul	x18, x9, x13
	str	x18, [sp, #40]                  // 8-byte Folded Spill
	umulh	x18, x10, x13
	stp	x26, x25, [sp, #224]            // 16-byte Folded Spill
	str	x18, [sp, #72]                  // 8-byte Folded Spill
	mul	x25, x10, x13
	umulh	x18, x11, x13
	mul	x7, x11, x13
	umulh	x29, x12, x13
	mul	x1, x12, x13
	umulh	x13, x14, x8
	ldp	x15, x16, [x2, #16]
	ldr	x17, [x2, #32]
	str	x13, [sp, #152]                 // 8-byte Folded Spill
	umulh	x13, x14, x9
	str	x13, [sp, #144]                 // 8-byte Folded Spill
	umulh	x13, x14, x10
	str	x13, [sp, #128]                 // 8-byte Folded Spill
	umulh	x13, x14, x11
	str	x13, [sp, #96]                  // 8-byte Folded Spill
	umulh	x13, x14, x12
	stp	x28, x27, [sp, #208]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #240]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #272]            // 16-byte Folded Spill
	mul	x20, x14, x8
	mul	x23, x14, x9
	mul	x24, x14, x10
	mul	x26, x14, x11
	mul	x28, x14, x12
	str	x13, [sp, #64]                  // 8-byte Folded Spill
	mul	x13, x15, x8
	umulh	x14, x15, x8
	mul	x2, x16, x8
	umulh	x5, x16, x8
	mul	x30, x17, x8
	umulh	x8, x17, x8
	str	x8, [sp, #104]                  // 8-byte Folded Spill
	umulh	x8, x17, x9
	str	x8, [sp, #136]                  // 8-byte Folded Spill
	mul	x8, x17, x9
	str	x13, [sp, #160]                 // 8-byte Folded Spill
	umulh	x13, x15, x9
	str	x2, [sp, #168]                  // 8-byte Folded Spill
	umulh	x2, x16, x9
	str	x8, [sp, #88]                   // 8-byte Folded Spill
	mul	x8, x17, x10
	stp	x22, x21, [sp, #256]            // 16-byte Folded Spill
	str	x18, [sp, #32]                  // 8-byte Folded Spill
	stp	x13, x14, [sp, #16]             // 16-byte Folded Spill
	mul	x19, x15, x9
	mul	x3, x15, x10
	umulh	x4, x15, x10
	mul	x14, x15, x11
	umulh	x18, x15, x11
	mul	x13, x15, x12
	umulh	x15, x15, x12
	stp	x2, x5, [sp, #48]               // 16-byte Folded Spill
	mul	x27, x16, x9
	mul	x21, x16, x10
	umulh	x22, x16, x10
	mul	x5, x16, x11
	umulh	x6, x16, x11
	mul	x2, x16, x12
	umulh	x16, x16, x12
	str	x30, [sp, #184]                 // 8-byte Folded Spill
	str	x8, [sp, #80]                   // 8-byte Folded Spill
	umulh	x10, x17, x10
	mul	x9, x17, x11
	umulh	x11, x17, x11
	mul	x8, x17, x12
	umulh	x12, x17, x12
	ldr	x17, [sp, #120]                 // 8-byte Folded Reload
	ldr	x30, [sp, #40]                  // 8-byte Folded Reload
	adds	x17, x17, x30
	ldr	x30, [sp, #112]                 // 8-byte Folded Reload
	adcs	x25, x30, x25
	ldr	x30, [sp, #72]                  // 8-byte Folded Reload
	adcs	x7, x30, x7
	ldr	x30, [sp, #32]                  // 8-byte Folded Reload
	adcs	x1, x30, x1
	adcs	x29, x29, xzr
	adds	x17, x17, x20
	adcs	x20, x25, x23
	ldr	x23, [sp, #176]                 // 8-byte Folded Reload
	stp	x23, x17, [x0]
	adcs	x17, x7, x24
	ldr	x24, [sp, #152]                 // 8-byte Folded Reload
	adcs	x1, x1, x26
	adcs	x7, x29, x28
	adcs	x23, xzr, xzr
	adds	x20, x20, x24
	ldr	x24, [sp, #144]                 // 8-byte Folded Reload
	ldp	x26, x25, [sp, #224]            // 16-byte Folded Reload
	ldp	x29, x30, [sp, #192]            // 16-byte Folded Reload
	adcs	x17, x17, x24
	ldr	x24, [sp, #128]                 // 8-byte Folded Reload
	adcs	x1, x1, x24
	ldr	x24, [sp, #96]                  // 8-byte Folded Reload
	adcs	x7, x7, x24
	ldr	x24, [sp, #64]                  // 8-byte Folded Reload
	adcs	x23, x23, x24
	ldr	x24, [sp, #24]                  // 8-byte Folded Reload
	adds	x19, x24, x19
	ldr	x24, [sp, #16]                  // 8-byte Folded Reload
	adcs	x3, x24, x3
	adcs	x14, x4, x14
	adcs	x13, x18, x13
	ldr	x18, [sp, #160]                 // 8-byte Folded Reload
	adcs	x15, x15, xzr
	adds	x18, x18, x20
	adcs	x17, x19, x17
	adcs	x1, x3, x1
	ldp	x4, x3, [sp, #48]               // 16-byte Folded Reload
	adcs	x14, x14, x7
	adcs	x13, x13, x23
	adcs	x15, x15, xzr
	adds	x3, x3, x27
	adcs	x4, x4, x21
	adcs	x5, x22, x5
	adcs	x2, x6, x2
	ldr	x6, [sp, #168]                  // 8-byte Folded Reload
	adcs	x16, x16, xzr
	ldp	x20, x19, [sp, #272]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #256]            // 16-byte Folded Reload
	adds	x17, x6, x17
	adcs	x1, x3, x1
	adcs	x14, x4, x14
	adcs	x13, x5, x13
	stp	x18, x17, [x0, #16]
	adcs	x15, x2, x15
	ldr	x17, [sp, #104]                 // 8-byte Folded Reload
	ldp	x2, x18, [sp, #80]              // 16-byte Folded Reload
	adcs	x16, x16, xzr
	ldp	x24, x23, [sp, #240]            // 16-byte Folded Reload
	ldp	x28, x27, [sp, #208]            // 16-byte Folded Reload
	adds	x17, x17, x18
	ldr	x18, [sp, #136]                 // 8-byte Folded Reload
	adcs	x18, x18, x2
	adcs	x9, x10, x9
	adcs	x8, x11, x8
	ldr	x11, [sp, #184]                 // 8-byte Folded Reload
	adcs	x10, x12, xzr
	adds	x11, x11, x1
	adcs	x12, x17, x14
	adcs	x13, x18, x13
	adcs	x9, x9, x15
	adcs	x8, x8, x16
	stp	x13, x9, [x0, #48]
	adcs	x9, x10, xzr
	stp	x11, x12, [x0, #32]
	stp	x8, x9, [x0, #64]
	add	sp, sp, #288                    // =288
	ret
.Lfunc_end151:
	.size	mclb_mul5, .Lfunc_end151-mclb_mul5
                                        // -- End function
	.globl	mclb_sqr5                       // -- Begin function mclb_sqr5
	.p2align	2
	.type	mclb_sqr5,@function
mclb_sqr5:                              // @mclb_sqr5
// %bb.0:
	str	x27, [sp, #-80]!                // 8-byte Folded Spill
	ldp	x8, x12, [x1]
	ldp	x13, x14, [x1, #16]
	ldr	x11, [x1, #32]
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	umulh	x16, x8, x8
	mul	x18, x12, x8
	umulh	x17, x12, x8
	mul	x2, x13, x8
	adds	x16, x16, x18
	umulh	x1, x13, x8
	mul	x10, x14, x8
	adcs	x22, x17, x2
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	mul	x15, x8, x8
	umulh	x3, x14, x8
	umulh	x9, x11, x8
	mul	x8, x11, x8
	adcs	x23, x1, x10
	adcs	x24, x3, x8
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	mul	x5, x12, x12
	adcs	x25, x9, xzr
	umulh	x4, x12, x12
	mul	x7, x13, x12
	adds	x17, x17, x5
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	umulh	x6, x13, x12
	mul	x20, x14, x12
	adcs	x4, x4, x7
	umulh	x19, x14, x12
	umulh	x21, x11, x12
	mul	x12, x11, x12
	adcs	x5, x6, x20
	adcs	x26, x19, x12
	adcs	x27, x21, xzr
	adds	x16, x18, x16
	adcs	x17, x17, x22
	stp	x15, x16, [x0]
	adcs	x16, x4, x23
	adcs	x5, x5, x24
	adcs	x24, x26, x25
	adcs	x26, x27, xzr
	mul	x22, x13, x13
	adds	x1, x1, x7
	umulh	x18, x13, x13
	mul	x4, x14, x13
	adcs	x6, x6, x22
	umulh	x15, x14, x13
	umulh	x23, x11, x13
	mul	x13, x11, x13
	adcs	x18, x18, x4
	adcs	x7, x15, x13
	adcs	x22, x23, xzr
	adds	x17, x2, x17
	adcs	x16, x1, x16
	adcs	x5, x6, x5
	adcs	x18, x18, x24
	adcs	x7, x7, x26
	adcs	x22, x22, xzr
	adds	x3, x3, x20
	mul	x2, x14, x14
	adcs	x4, x19, x4
	umulh	x25, x14, x14
	umulh	x1, x11, x14
	mul	x14, x11, x14
	adcs	x15, x15, x2
	adcs	x2, x25, x14
	adcs	x19, x1, xzr
	adds	x10, x10, x16
	adcs	x16, x3, x5
	stp	x17, x10, [x0, #16]
	adcs	x10, x4, x18
	adcs	x15, x15, x7
	adcs	x17, x2, x22
	adcs	x18, x19, xzr
	adds	x9, x9, x12
	adcs	x12, x21, x13
	umulh	x6, x11, x11
	mul	x11, x11, x11
	adcs	x13, x23, x14
	adcs	x11, x1, x11
	adcs	x14, x6, xzr
	adds	x8, x8, x16
	adcs	x9, x9, x10
	adcs	x10, x12, x15
	stp	x8, x9, [x0, #32]
	adcs	x8, x13, x17
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	adcs	x9, x11, x18
	stp	x10, x8, [x0, #48]
	adcs	x8, x14, xzr
	stp	x9, x8, [x0, #64]
	ldr	x27, [sp], #80                  // 8-byte Folded Reload
	ret
.Lfunc_end152:
	.size	mclb_sqr5, .Lfunc_end152-mclb_sqr5
                                        // -- End function
	.globl	mulUnit_inner384                // -- Begin function mulUnit_inner384
	.p2align	2
	.type	mulUnit_inner384,@function
mulUnit_inner384:                       // @mulUnit_inner384
// %bb.0:
	ldp	x8, x9, [x0]
	ldp	x10, x11, [x0, #16]
	ldp	x12, x13, [x0, #32]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x14, x9, x1
	mul	x9, x9, x1
	mul	x15, x10, x1
	umulh	x10, x10, x1
	mul	x16, x11, x1
	umulh	x11, x11, x1
	mul	x17, x12, x1
	umulh	x12, x12, x1
	mul	x18, x13, x1
	umulh	x13, x13, x1
	adds	x1, x8, x9
	adcs	x2, x14, x15
	adcs	x3, x10, x16
	adcs	x4, x11, x17
	adcs	x5, x12, x18
	adcs	x6, x13, xzr
	ret
.Lfunc_end153:
	.size	mulUnit_inner384, .Lfunc_end153-mulUnit_inner384
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
.Lfunc_end154:
	.size	mclb_mulUnit6, .Lfunc_end154-mclb_mulUnit6
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
.Lfunc_end155:
	.size	mclb_mulUnitAdd6, .Lfunc_end155-mclb_mulUnitAdd6
                                        // -- End function
	.globl	mclb_mul6                       // -- Begin function mclb_mul6
	.p2align	2
	.type	mclb_mul6,@function
mclb_mul6:                              // @mclb_mul6
// %bb.0:
	sub	sp, sp, #496                    // =496
	ldp	x8, x9, [x1]
	ldp	x14, x15, [x2]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldp	x18, x1, [x2, #32]
	ldp	x16, x17, [x2, #16]
	mul	x2, x8, x14
	stp	x22, x21, [sp, #464]            // 16-byte Folded Spill
	str	x2, [sp, #384]                  // 8-byte Folded Spill
	umulh	x3, x8, x14
	umulh	x2, x9, x14
	mul	x22, x18, x8
	stp	x2, x3, [sp, #288]              // 16-byte Folded Spill
	umulh	x2, x10, x14
	str	x22, [sp, #376]                 // 8-byte Folded Spill
	umulh	x22, x18, x8
	mul	x3, x9, x14
	str	x2, [sp, #248]                  // 8-byte Folded Spill
	umulh	x2, x11, x14
	str	x22, [sp, #312]                 // 8-byte Folded Spill
	umulh	x22, x18, x9
	mul	x4, x10, x14
	stp	x2, x3, [sp, #184]              // 16-byte Folded Spill
	umulh	x2, x12, x14
	str	x22, [sp, #304]                 // 8-byte Folded Spill
	mul	x22, x18, x9
	mul	x3, x11, x14
	stp	x2, x4, [sp, #120]              // 16-byte Folded Spill
	mul	x2, x12, x14
	str	x22, [sp, #232]                 // 8-byte Folded Spill
	mul	x22, x18, x10
	stp	x2, x3, [sp, #72]               // 16-byte Folded Spill
	umulh	x2, x13, x14
	mul	x6, x13, x14
	umulh	x14, x15, x8
	str	x22, [sp, #224]                 // 8-byte Folded Spill
	umulh	x22, x18, x10
	str	x14, [sp, #352]                 // 8-byte Folded Spill
	umulh	x14, x15, x9
	str	x22, [sp, #216]                 // 8-byte Folded Spill
	mul	x22, x18, x11
	str	x14, [sp, #344]                 // 8-byte Folded Spill
	umulh	x14, x15, x10
	str	x22, [sp, #152]                 // 8-byte Folded Spill
	umulh	x22, x18, x11
	str	x14, [sp, #320]                 // 8-byte Folded Spill
	umulh	x14, x15, x11
	str	x22, [sp, #144]                 // 8-byte Folded Spill
	mul	x22, x18, x12
	str	x14, [sp, #280]                 // 8-byte Folded Spill
	umulh	x14, x15, x12
	str	x22, [sp, #96]                  // 8-byte Folded Spill
	umulh	x22, x18, x12
	stp	x29, x30, [sp, #400]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #416]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #448]            // 16-byte Folded Spill
	str	x2, [sp, #64]                   // 8-byte Folded Spill
	mul	x24, x15, x8
	mul	x27, x15, x9
	mul	x28, x15, x10
	mul	x30, x15, x11
	mul	x2, x15, x12
	str	x14, [sp, #240]                 // 8-byte Folded Spill
	mul	x14, x15, x13
	umulh	x15, x15, x13
	str	x22, [sp, #88]                  // 8-byte Folded Spill
	mul	x22, x18, x13
	umulh	x18, x18, x13
	str	x15, [sp, #176]                 // 8-byte Folded Spill
	mul	x15, x16, x8
	mul	x5, x17, x8
	stp	x18, x22, [sp, #24]             // 16-byte Folded Spill
	mul	x18, x1, x8
	str	x15, [sp, #360]                 // 8-byte Folded Spill
	umulh	x15, x16, x8
	str	x5, [sp, #368]                  // 8-byte Folded Spill
	umulh	x5, x17, x8
	str	x18, [sp, #392]                 // 8-byte Folded Spill
	umulh	x18, x1, x8
	umulh	x8, x1, x9
	stp	x8, x18, [sp, #328]             // 16-byte Folded Spill
	mul	x18, x1, x9
	mul	x8, x1, x10
	str	x5, [sp, #168]                  // 8-byte Folded Spill
	umulh	x5, x17, x9
	stp	x8, x18, [sp, #264]             // 16-byte Folded Spill
	umulh	x8, x1, x10
	str	x15, [sp, #112]                 // 8-byte Folded Spill
	umulh	x15, x16, x9
	mul	x29, x16, x9
	str	x5, [sp, #160]                  // 8-byte Folded Spill
	mul	x5, x17, x9
	str	x8, [sp, #256]                  // 8-byte Folded Spill
	mul	x9, x1, x11
	umulh	x8, x1, x11
	stp	x8, x9, [sp, #200]              // 16-byte Folded Spill
	mul	x8, x1, x12
	str	x8, [sp, #136]                  // 8-byte Folded Spill
	ldr	x8, [sp, #296]                  // 8-byte Folded Reload
	ldr	x9, [sp, #192]                  // 8-byte Folded Reload
	str	x5, [sp, #56]                   // 8-byte Folded Spill
	mul	x5, x17, x10
	str	x15, [sp, #104]                 // 8-byte Folded Spill
	mul	x15, x16, x10
	str	x5, [sp, #48]                   // 8-byte Folded Spill
	umulh	x5, x17, x10
	stp	x26, x25, [sp, #432]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #480]            // 16-byte Folded Spill
	str	x15, [sp, #16]                  // 8-byte Folded Spill
	umulh	x26, x16, x10
	mul	x21, x16, x11
	umulh	x7, x16, x11
	mul	x4, x16, x12
	umulh	x3, x16, x12
	mul	x15, x16, x13
	umulh	x16, x16, x13
	str	x5, [sp, #40]                   // 8-byte Folded Spill
	mul	x23, x17, x11
	umulh	x25, x17, x11
	mul	x19, x17, x12
	umulh	x20, x17, x12
	mul	x5, x17, x13
	umulh	x17, x17, x13
	umulh	x12, x1, x12
	mul	x11, x1, x13
	umulh	x13, x1, x13
	adds	x1, x8, x9
	ldr	x8, [sp, #288]                  // 8-byte Folded Reload
	ldr	x9, [sp, #128]                  // 8-byte Folded Reload
	ldp	x18, x10, [sp, #72]             // 16-byte Folded Reload
	adcs	x8, x8, x9
	ldr	x9, [sp, #248]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #184]                 // 8-byte Folded Reload
	adcs	x22, x10, x18
	ldr	x10, [sp, #120]                 // 8-byte Folded Reload
	ldr	x18, [sp, #384]                 // 8-byte Folded Reload
	adcs	x6, x10, x6
	ldr	x10, [sp, #64]                  // 8-byte Folded Reload
	adcs	x10, x10, xzr
	adds	x1, x1, x24
	adcs	x8, x8, x27
	adcs	x9, x9, x28
	stp	x18, x1, [x0]
	adcs	x1, x22, x30
	ldr	x18, [sp, #352]                 // 8-byte Folded Reload
	adcs	x2, x6, x2
	adcs	x10, x10, x14
	adcs	x14, xzr, xzr
	adds	x8, x8, x18
	ldr	x18, [sp, #344]                 // 8-byte Folded Reload
	ldr	x22, [sp, #16]                  // 8-byte Folded Reload
	ldp	x28, x27, [sp, #416]            // 16-byte Folded Reload
	adcs	x9, x9, x18
	ldr	x18, [sp, #320]                 // 8-byte Folded Reload
	adcs	x1, x1, x18
	ldr	x18, [sp, #280]                 // 8-byte Folded Reload
	adcs	x2, x2, x18
	ldr	x18, [sp, #240]                 // 8-byte Folded Reload
	adcs	x10, x10, x18
	ldr	x18, [sp, #176]                 // 8-byte Folded Reload
	adcs	x14, x14, x18
	ldr	x18, [sp, #112]                 // 8-byte Folded Reload
	adds	x6, x18, x29
	ldr	x18, [sp, #104]                 // 8-byte Folded Reload
	ldp	x29, x30, [sp, #400]            // 16-byte Folded Reload
	adcs	x22, x18, x22
	adcs	x21, x26, x21
	ldr	x18, [sp, #360]                 // 8-byte Folded Reload
	adcs	x4, x7, x4
	adcs	x15, x3, x15
	adcs	x16, x16, xzr
	adds	x8, x18, x8
	adcs	x9, x6, x9
	adcs	x1, x22, x1
	adcs	x2, x21, x2
	adcs	x10, x4, x10
	adcs	x14, x15, x14
	adcs	x15, x16, xzr
	ldr	x16, [sp, #168]                 // 8-byte Folded Reload
	ldp	x3, x18, [sp, #48]              // 16-byte Folded Reload
	ldp	x22, x21, [sp, #464]            // 16-byte Folded Reload
	adds	x16, x16, x18
	ldr	x18, [sp, #160]                 // 8-byte Folded Reload
	adcs	x3, x18, x3
	ldr	x18, [sp, #40]                  // 8-byte Folded Reload
	adcs	x4, x18, x23
	ldr	x18, [sp, #368]                 // 8-byte Folded Reload
	adcs	x6, x25, x19
	adcs	x5, x20, x5
	adcs	x17, x17, xzr
	adds	x9, x18, x9
	adcs	x16, x16, x1
	stp	x8, x9, [x0, #16]
	adcs	x8, x3, x2
	adcs	x9, x4, x10
	adcs	x10, x6, x14
	adcs	x14, x5, x15
	adcs	x15, x17, xzr
	ldr	x17, [sp, #312]                 // 8-byte Folded Reload
	ldp	x1, x18, [sp, #224]             // 16-byte Folded Reload
	ldr	x2, [sp, #152]                  // 8-byte Folded Reload
	ldr	x3, [sp, #96]                   // 8-byte Folded Reload
	ldr	x4, [sp, #32]                   // 8-byte Folded Reload
	adds	x17, x17, x18
	ldr	x18, [sp, #304]                 // 8-byte Folded Reload
	ldr	x5, [sp, #376]                  // 8-byte Folded Reload
	ldp	x20, x19, [sp, #480]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #448]            // 16-byte Folded Reload
	adcs	x1, x18, x1
	ldr	x18, [sp, #216]                 // 8-byte Folded Reload
	ldp	x26, x25, [sp, #432]            // 16-byte Folded Reload
	adcs	x2, x18, x2
	ldr	x18, [sp, #144]                 // 8-byte Folded Reload
	adcs	x3, x18, x3
	ldr	x18, [sp, #88]                  // 8-byte Folded Reload
	adcs	x4, x18, x4
	ldr	x18, [sp, #24]                  // 8-byte Folded Reload
	adcs	x18, x18, xzr
	adds	x16, x5, x16
	adcs	x8, x17, x8
	adcs	x9, x1, x9
	adcs	x10, x2, x10
	adcs	x14, x3, x14
	adcs	x15, x4, x15
	adcs	x17, x18, xzr
	ldr	x18, [sp, #336]                 // 8-byte Folded Reload
	ldp	x2, x1, [sp, #264]              // 16-byte Folded Reload
	ldr	x3, [sp, #208]                  // 8-byte Folded Reload
	ldr	x4, [sp, #136]                  // 8-byte Folded Reload
	adds	x18, x18, x1
	ldr	x1, [sp, #328]                  // 8-byte Folded Reload
	adcs	x1, x1, x2
	ldr	x2, [sp, #256]                  // 8-byte Folded Reload
	adcs	x2, x2, x3
	ldr	x3, [sp, #200]                  // 8-byte Folded Reload
	adcs	x3, x3, x4
	adcs	x11, x12, x11
	adcs	x12, x13, xzr
	ldr	x13, [sp, #392]                 // 8-byte Folded Reload
	adds	x8, x13, x8
	adcs	x9, x18, x9
	stp	x16, x8, [x0, #32]
	adcs	x8, x1, x10
	adcs	x10, x2, x14
	stp	x9, x8, [x0, #48]
	adcs	x8, x3, x15
	adcs	x9, x11, x17
	stp	x10, x8, [x0, #64]
	adcs	x8, x12, xzr
	stp	x9, x8, [x0, #80]
	add	sp, sp, #496                    // =496
	ret
.Lfunc_end156:
	.size	mclb_mul6, .Lfunc_end156-mclb_mul6
                                        // -- End function
	.globl	mclb_sqr6                       // -- Begin function mclb_sqr6
	.p2align	2
	.type	mclb_sqr6,@function
mclb_sqr6:                              // @mclb_sqr6
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldp	x2, x15, [x1]
	ldp	x3, x16, [x1, #16]
	ldp	x11, x8, [x1, #32]
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	umulh	x14, x2, x2
	mul	x4, x15, x2
	umulh	x1, x15, x2
	mul	x6, x3, x2
	adds	x26, x14, x4
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	umulh	x5, x3, x2
	mul	x17, x16, x2
	adcs	x27, x1, x6
	umulh	x7, x16, x2
	mul	x12, x11, x2
	adcs	x28, x5, x17
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	umulh	x13, x11, x2
	mul	x9, x8, x2
	adcs	x29, x7, x12
	umulh	x10, x8, x2
	adcs	x30, x13, x9
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	stp	x13, x12, [sp]                  // 16-byte Folded Spill
	mul	x20, x15, x15
	adcs	x13, x10, xzr
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	umulh	x19, x15, x15
	mul	x22, x3, x15
	adds	x1, x1, x20
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	umulh	x21, x3, x15
	mul	x24, x16, x15
	adcs	x19, x19, x22
	umulh	x23, x16, x15
	mul	x25, x11, x15
	adcs	x20, x21, x24
	stp	x10, x9, [sp, #16]              // 16-byte Folded Spill
	umulh	x18, x11, x15
	umulh	x14, x8, x15
	mul	x15, x8, x15
	adcs	x9, x23, x25
	adcs	x10, x18, x15
	adcs	x12, x14, xzr
	adds	x4, x4, x26
	adcs	x1, x1, x27
	mul	x2, x2, x2
	stp	x2, x4, [x0]
	adcs	x2, x19, x28
	adcs	x19, x20, x29
	adcs	x9, x9, x30
	adcs	x10, x10, x13
	adcs	x12, x12, xzr
	mul	x20, x3, x3
	adds	x5, x5, x22
	umulh	x4, x3, x3
	mul	x13, x16, x3
	adcs	x20, x21, x20
	umulh	x26, x16, x3
	mul	x21, x11, x3
	adcs	x4, x4, x13
	umulh	x22, x11, x3
	umulh	x27, x8, x3
	mul	x3, x8, x3
	adcs	x28, x26, x21
	adcs	x29, x22, x3
	adcs	x30, x27, xzr
	adds	x1, x6, x1
	adcs	x2, x5, x2
	adcs	x5, x20, x19
	adcs	x9, x4, x9
	adcs	x10, x28, x10
	adcs	x12, x29, x12
	adcs	x19, x30, xzr
	adds	x7, x7, x24
	mul	x6, x16, x16
	adcs	x13, x23, x13
	umulh	x4, x16, x16
	mul	x23, x11, x16
	adcs	x6, x26, x6
	umulh	x20, x11, x16
	umulh	x24, x8, x16
	mul	x16, x8, x16
	adcs	x4, x4, x23
	adcs	x26, x20, x16
	adcs	x28, x24, xzr
	adds	x17, x17, x2
	adcs	x2, x7, x5
	adcs	x9, x13, x9
	stp	x1, x17, [x0, #16]
	adcs	x10, x6, x10
	ldr	x1, [sp]                        // 8-byte Folded Reload
	adcs	x12, x4, x12
	adcs	x13, x26, x19
	adcs	x17, x28, xzr
	adds	x1, x1, x25
	adcs	x18, x18, x21
	mul	x5, x11, x11
	adcs	x6, x22, x23
	adcs	x5, x20, x5
	ldr	x20, [sp, #8]                   // 8-byte Folded Reload
	umulh	x4, x11, x11
	umulh	x7, x8, x11
	mul	x11, x8, x11
	adcs	x4, x4, x11
	adcs	x19, x7, xzr
	adds	x2, x20, x2
	adcs	x9, x1, x9
	adcs	x10, x18, x10
	adcs	x12, x6, x12
	ldr	x1, [sp, #16]                   // 8-byte Folded Reload
	adcs	x13, x5, x13
	adcs	x17, x4, x17
	adcs	x18, x19, xzr
	adds	x15, x1, x15
	adcs	x14, x14, x3
	adcs	x16, x27, x16
	ldr	x3, [sp, #24]                   // 8-byte Folded Reload
	adcs	x11, x24, x11
	mul	x1, x8, x8
	adcs	x1, x7, x1
	umulh	x8, x8, x8
	adcs	x8, x8, xzr
	adds	x9, x3, x9
	adcs	x10, x15, x10
	stp	x2, x9, [x0, #32]
	adcs	x9, x14, x12
	adcs	x12, x16, x13
	stp	x10, x9, [x0, #48]
	adcs	x9, x11, x17
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	adcs	x10, x1, x18
	adcs	x8, x8, xzr
	stp	x12, x9, [x0, #64]
	stp	x10, x8, [x0, #80]
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end157:
	.size	mclb_sqr6, .Lfunc_end157-mclb_sqr6
                                        // -- End function
	.globl	mulUnit_inner448                // -- Begin function mulUnit_inner448
	.p2align	2
	.type	mulUnit_inner448,@function
mulUnit_inner448:                       // @mulUnit_inner448
// %bb.0:
	ldp	x8, x9, [x0]
	ldp	x10, x11, [x0, #16]
	ldp	x12, x13, [x0, #32]
	ldr	x14, [x0, #48]
	mul	x0, x8, x1
	umulh	x8, x8, x1
	umulh	x15, x9, x1
	mul	x9, x9, x1
	mul	x16, x10, x1
	umulh	x10, x10, x1
	mul	x17, x11, x1
	umulh	x11, x11, x1
	mul	x18, x12, x1
	umulh	x12, x12, x1
	mul	x5, x13, x1
	umulh	x13, x13, x1
	mul	x6, x14, x1
	umulh	x14, x14, x1
	adds	x1, x8, x9
	adcs	x2, x15, x16
	adcs	x3, x10, x17
	adcs	x4, x11, x18
	adcs	x5, x12, x5
	adcs	x6, x13, x6
	adcs	x7, x14, xzr
	ret
.Lfunc_end158:
	.size	mulUnit_inner448, .Lfunc_end158-mulUnit_inner448
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
.Lfunc_end159:
	.size	mclb_mulUnit7, .Lfunc_end159-mclb_mulUnit7
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
.Lfunc_end160:
	.size	mclb_mulUnitAdd7, .Lfunc_end160-mclb_mulUnitAdd7
                                        // -- End function
	.globl	mclb_mul7                       // -- Begin function mclb_mul7
	.p2align	2
	.type	mclb_mul7,@function
mclb_mul7:                              // @mclb_mul7
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #624                    // =624
	ldp	x8, x9, [x1]
	ldp	x10, x11, [x1, #16]
	ldp	x12, x13, [x1, #32]
	ldr	x14, [x1, #48]
	ldp	x1, x3, [x2, #32]
	ldp	x15, x16, [x2]
	ldp	x17, x18, [x2, #16]
	ldr	x2, [x2, #48]
	mul	x25, x1, x8
	str	x25, [sp, #592]                 // 8-byte Folded Spill
	umulh	x25, x1, x8
	str	x25, [sp, #456]                 // 8-byte Folded Spill
	umulh	x25, x1, x9
	str	x25, [sp, #448]                 // 8-byte Folded Spill
	mul	x25, x1, x9
	str	x25, [sp, #344]                 // 8-byte Folded Spill
	mul	x25, x1, x10
	str	x25, [sp, #336]                 // 8-byte Folded Spill
	umulh	x25, x1, x10
	str	x25, [sp, #328]                 // 8-byte Folded Spill
	mul	x25, x1, x11
	str	x25, [sp, #264]                 // 8-byte Folded Spill
	umulh	x25, x1, x11
	str	x25, [sp, #256]                 // 8-byte Folded Spill
	mul	x25, x1, x12
	str	x25, [sp, #200]                 // 8-byte Folded Spill
	umulh	x25, x1, x12
	mul	x4, x8, x15
	str	x25, [sp, #192]                 // 8-byte Folded Spill
	mul	x25, x1, x13
	str	x4, [sp, #608]                  // 8-byte Folded Spill
	umulh	x5, x8, x15
	umulh	x4, x9, x15
	str	x25, [sp, #128]                 // 8-byte Folded Spill
	umulh	x25, x1, x13
	stp	x4, x5, [sp, #472]              // 16-byte Folded Spill
	umulh	x4, x10, x15
	str	x25, [sp, #120]                 // 8-byte Folded Spill
	mul	x25, x1, x14
	umulh	x1, x1, x14
	mul	x5, x9, x15
	str	x4, [sp, #424]                  // 8-byte Folded Spill
	umulh	x4, x11, x15
	str	x1, [sp, #112]                  // 8-byte Folded Spill
	mul	x1, x3, x8
	mul	x6, x10, x15
	stp	x4, x5, [sp, #360]              // 16-byte Folded Spill
	umulh	x4, x12, x15
	str	x1, [sp, #600]                  // 8-byte Folded Spill
	umulh	x1, x3, x8
	mul	x5, x11, x15
	stp	x4, x6, [sp, #296]              // 16-byte Folded Spill
	umulh	x4, x13, x15
	str	x1, [sp, #512]                  // 8-byte Folded Spill
	umulh	x1, x3, x9
	mul	x6, x12, x15
	stp	x4, x5, [sp, #224]              // 16-byte Folded Spill
	mul	x5, x13, x15
	umulh	x4, x14, x15
	mul	x29, x14, x15
	mul	x15, x16, x8
	str	x1, [sp, #504]                  // 8-byte Folded Spill
	mul	x1, x3, x9
	stp	x15, x5, [sp, #80]              // 16-byte Folded Spill
	umulh	x15, x16, x8
	str	x1, [sp, #408]                  // 8-byte Folded Spill
	mul	x1, x3, x10
	str	x15, [sp, #560]                 // 8-byte Folded Spill
	umulh	x15, x16, x9
	str	x1, [sp, #400]                  // 8-byte Folded Spill
	umulh	x1, x3, x10
	str	x15, [sp, #552]                 // 8-byte Folded Spill
	mul	x15, x16, x10
	str	x1, [sp, #392]                  // 8-byte Folded Spill
	mul	x1, x3, x11
	str	x15, [sp, #72]                  // 8-byte Folded Spill
	umulh	x15, x16, x10
	str	x1, [sp, #320]                  // 8-byte Folded Spill
	umulh	x1, x3, x11
	str	x15, [sp, #520]                 // 8-byte Folded Spill
	umulh	x15, x16, x11
	str	x1, [sp, #312]                  // 8-byte Folded Spill
	mul	x1, x3, x12
	str	x15, [sp, #464]                 // 8-byte Folded Spill
	umulh	x15, x16, x12
	str	x1, [sp, #248]                  // 8-byte Folded Spill
	umulh	x1, x3, x12
	str	x15, [sp, #416]                 // 8-byte Folded Spill
	umulh	x15, x16, x13
	str	x1, [sp, #240]                  // 8-byte Folded Spill
	mul	x1, x3, x13
	stp	x4, x6, [sp, #160]              // 16-byte Folded Spill
	mul	x20, x16, x9
	mul	x28, x16, x11
	mul	x21, x16, x12
	mul	x4, x16, x13
	str	x15, [sp, #352]                 // 8-byte Folded Spill
	mul	x15, x16, x14
	umulh	x16, x16, x14
	str	x1, [sp, #184]                  // 8-byte Folded Spill
	umulh	x1, x3, x13
	str	x16, [sp, #288]                 // 8-byte Folded Spill
	mul	x16, x17, x8
	mul	x7, x18, x8
	str	x1, [sp, #176]                  // 8-byte Folded Spill
	mul	x1, x3, x14
	str	x16, [sp, #576]                 // 8-byte Folded Spill
	umulh	x16, x17, x8
	str	x7, [sp, #584]                  // 8-byte Folded Spill
	umulh	x7, x18, x8
	str	x25, [sp, #16]                  // 8-byte Folded Spill
	str	x1, [sp, #104]                  // 8-byte Folded Spill
	umulh	x1, x3, x14
	mul	x3, x2, x8
	umulh	x25, x2, x8
	umulh	x8, x2, x9
	str	x8, [sp, #568]                  // 8-byte Folded Spill
	mul	x8, x2, x9
	str	x16, [sp, #216]                 // 8-byte Folded Spill
	umulh	x16, x17, x9
	str	x7, [sp, #280]                  // 8-byte Folded Spill
	umulh	x7, x18, x9
	str	x8, [sp, #536]                  // 8-byte Folded Spill
	umulh	x8, x2, x10
	str	x16, [sp, #208]                 // 8-byte Folded Spill
	mul	x16, x17, x9
	str	x7, [sp, #272]                  // 8-byte Folded Spill
	mul	x7, x18, x9
	str	x8, [sp, #544]                  // 8-byte Folded Spill
	umulh	x8, x2, x11
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	mul	x16, x17, x10
	str	x7, [sp, #152]                  // 8-byte Folded Spill
	mul	x7, x18, x10
	mul	x9, x2, x10
	str	x8, [sp, #528]                  // 8-byte Folded Spill
	umulh	x8, x2, x12
	str	x16, [sp, #56]                  // 8-byte Folded Spill
	umulh	x16, x17, x10
	str	x7, [sp, #144]                  // 8-byte Folded Spill
	umulh	x7, x18, x10
	mul	x10, x2, x11
	stp	x8, x9, [sp, #488]              // 16-byte Folded Spill
	umulh	x8, x2, x13
	mul	x9, x2, x12
	stp	x8, x10, [sp, #432]             // 16-byte Folded Spill
	umulh	x8, x2, x14
	stp	x8, x9, [sp, #376]              // 16-byte Folded Spill
	ldr	x8, [sp, #480]                  // 8-byte Folded Reload
	ldr	x9, [sp, #368]                  // 8-byte Folded Reload
	str	x7, [sp, #136]                  // 8-byte Folded Spill
	mul	x7, x18, x11
	str	x16, [sp, #48]                  // 8-byte Folded Spill
	mul	x16, x17, x11
	str	x7, [sp, #32]                   // 8-byte Folded Spill
	umulh	x7, x18, x11
	str	x16, [sp, #40]                  // 8-byte Folded Spill
	umulh	x30, x17, x11
	mul	x19, x17, x12
	umulh	x24, x17, x12
	mul	x6, x17, x13
	umulh	x5, x17, x13
	mul	x16, x17, x14
	umulh	x17, x17, x14
	str	x7, [sp, #24]                   // 8-byte Folded Spill
	mul	x26, x18, x12
	umulh	x27, x18, x12
	mul	x22, x18, x13
	umulh	x23, x18, x13
	mul	x7, x18, x14
	umulh	x18, x18, x14
	mul	x13, x2, x13
	mul	x14, x2, x14
	adds	x2, x8, x9
	ldr	x8, [sp, #472]                  // 8-byte Folded Reload
	ldr	x9, [sp, #304]                  // 8-byte Folded Reload
	ldr	x10, [sp, #232]                 // 8-byte Folded Reload
	ldr	x11, [sp, #168]                 // 8-byte Folded Reload
	str	x1, [sp, #96]                   // 8-byte Folded Spill
	adcs	x8, x8, x9
	ldr	x9, [sp, #424]                  // 8-byte Folded Reload
	ldp	x1, x12, [sp, #80]              // 16-byte Folded Reload
	str	x3, [sp, #616]                  // 8-byte Folded Spill
	ldr	x3, [sp, #608]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	ldr	x10, [sp, #360]                 // 8-byte Folded Reload
	adcs	x10, x10, x11
	ldr	x11, [sp, #296]                 // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #224]                 // 8-byte Folded Reload
	adcs	x29, x12, x29
	ldr	x12, [sp, #160]                 // 8-byte Folded Reload
	adcs	x12, x12, xzr
	adds	x2, x2, x1
	ldr	x1, [sp, #72]                   // 8-byte Folded Reload
	adcs	x8, x8, x20
	stp	x3, x2, [x0]
	ldr	x3, [sp, #64]                   // 8-byte Folded Reload
	adcs	x9, x9, x1
	adcs	x10, x10, x28
	adcs	x11, x11, x21
	ldr	x1, [sp, #560]                  // 8-byte Folded Reload
	adcs	x2, x29, x4
	adcs	x12, x12, x15
	adcs	x15, xzr, xzr
	adds	x8, x8, x1
	ldr	x1, [sp, #552]                  // 8-byte Folded Reload
	adcs	x9, x9, x1
	ldr	x1, [sp, #520]                  // 8-byte Folded Reload
	adcs	x10, x10, x1
	ldr	x1, [sp, #464]                  // 8-byte Folded Reload
	adcs	x11, x11, x1
	ldr	x1, [sp, #416]                  // 8-byte Folded Reload
	adcs	x2, x2, x1
	ldr	x1, [sp, #352]                  // 8-byte Folded Reload
	adcs	x12, x12, x1
	ldr	x1, [sp, #288]                  // 8-byte Folded Reload
	adcs	x15, x15, x1
	ldr	x1, [sp, #216]                  // 8-byte Folded Reload
	adds	x4, x1, x3
	ldr	x1, [sp, #208]                  // 8-byte Folded Reload
	ldr	x3, [sp, #56]                   // 8-byte Folded Reload
	adcs	x20, x1, x3
	ldp	x3, x1, [sp, #40]               // 16-byte Folded Reload
	adcs	x21, x1, x3
	adcs	x19, x30, x19
	ldr	x1, [sp, #576]                  // 8-byte Folded Reload
	adcs	x6, x24, x6
	adcs	x16, x5, x16
	adcs	x17, x17, xzr
	adds	x8, x1, x8
	adcs	x9, x4, x9
	adcs	x10, x20, x10
	adcs	x11, x21, x11
	adcs	x2, x19, x2
	adcs	x12, x6, x12
	adcs	x15, x16, x15
	adcs	x16, x17, xzr
	ldr	x17, [sp, #280]                 // 8-byte Folded Reload
	ldp	x3, x1, [sp, #144]              // 16-byte Folded Reload
	adds	x17, x17, x1
	ldr	x1, [sp, #272]                  // 8-byte Folded Reload
	adcs	x4, x1, x3
	ldr	x1, [sp, #136]                  // 8-byte Folded Reload
	ldr	x3, [sp, #32]                   // 8-byte Folded Reload
	adcs	x5, x1, x3
	ldr	x1, [sp, #24]                   // 8-byte Folded Reload
	ldr	x3, [sp, #200]                  // 8-byte Folded Reload
	adcs	x6, x1, x26
	ldr	x1, [sp, #584]                  // 8-byte Folded Reload
	adcs	x19, x27, x22
	adcs	x7, x23, x7
	adcs	x18, x18, xzr
	adds	x9, x1, x9
	adcs	x10, x17, x10
	stp	x8, x9, [x0, #16]
	adcs	x8, x4, x11
	adcs	x9, x5, x2
	adcs	x11, x6, x12
	adcs	x12, x19, x15
	adcs	x15, x7, x16
	adcs	x16, x18, xzr
	ldr	x17, [sp, #456]                 // 8-byte Folded Reload
	ldp	x1, x18, [sp, #336]             // 16-byte Folded Reload
	ldr	x2, [sp, #264]                  // 8-byte Folded Reload
	ldr	x7, [sp, #600]                  // 8-byte Folded Reload
	adds	x17, x17, x18
	ldr	x18, [sp, #448]                 // 8-byte Folded Reload
	adcs	x18, x18, x1
	ldr	x1, [sp, #328]                  // 8-byte Folded Reload
	adcs	x2, x1, x2
	ldr	x1, [sp, #256]                  // 8-byte Folded Reload
	adcs	x4, x1, x3
	ldr	x1, [sp, #192]                  // 8-byte Folded Reload
	ldr	x3, [sp, #128]                  // 8-byte Folded Reload
	adcs	x5, x1, x3
	ldr	x1, [sp, #120]                  // 8-byte Folded Reload
	ldr	x3, [sp, #16]                   // 8-byte Folded Reload
	adcs	x6, x1, x3
	ldr	x1, [sp, #112]                  // 8-byte Folded Reload
	ldr	x3, [sp, #592]                  // 8-byte Folded Reload
	adcs	x1, x1, xzr
	adds	x10, x3, x10
	adcs	x8, x17, x8
	adcs	x9, x18, x9
	adcs	x11, x2, x11
	adcs	x12, x4, x12
	adcs	x15, x5, x15
	adcs	x16, x6, x16
	adcs	x17, x1, xzr
	ldr	x18, [sp, #512]                 // 8-byte Folded Reload
	ldp	x2, x1, [sp, #400]              // 16-byte Folded Reload
	ldr	x3, [sp, #320]                  // 8-byte Folded Reload
	ldr	x4, [sp, #248]                  // 8-byte Folded Reload
	ldr	x5, [sp, #184]                  // 8-byte Folded Reload
	adds	x18, x18, x1
	ldr	x1, [sp, #504]                  // 8-byte Folded Reload
	ldr	x6, [sp, #104]                  // 8-byte Folded Reload
	adcs	x1, x1, x2
	ldr	x2, [sp, #392]                  // 8-byte Folded Reload
	adcs	x2, x2, x3
	ldr	x3, [sp, #312]                  // 8-byte Folded Reload
	adcs	x4, x3, x4
	ldr	x3, [sp, #240]                  // 8-byte Folded Reload
	adcs	x5, x3, x5
	ldr	x3, [sp, #176]                  // 8-byte Folded Reload
	adcs	x6, x3, x6
	ldr	x3, [sp, #96]                   // 8-byte Folded Reload
	adcs	x3, x3, xzr
	adds	x8, x7, x8
	adcs	x9, x18, x9
	stp	x10, x8, [x0, #32]
	adcs	x8, x1, x11
	adcs	x10, x2, x12
	adcs	x11, x4, x15
	adcs	x12, x5, x16
	adcs	x15, x6, x17
	ldr	x17, [sp, #536]                 // 8-byte Folded Reload
	ldr	x18, [sp, #568]                 // 8-byte Folded Reload
	ldr	x1, [sp, #496]                  // 8-byte Folded Reload
	adcs	x16, x3, xzr
	adds	x17, x25, x17
	ldr	x2, [sp, #440]                  // 8-byte Folded Reload
	adcs	x18, x18, x1
	ldr	x1, [sp, #544]                  // 8-byte Folded Reload
	ldr	x3, [sp, #384]                  // 8-byte Folded Reload
	ldr	x4, [sp, #616]                  // 8-byte Folded Reload
	adcs	x1, x1, x2
	ldr	x2, [sp, #528]                  // 8-byte Folded Reload
	adcs	x2, x2, x3
	ldr	x3, [sp, #488]                  // 8-byte Folded Reload
	adcs	x13, x3, x13
	ldr	x3, [sp, #432]                  // 8-byte Folded Reload
	adcs	x14, x3, x14
	ldr	x3, [sp, #376]                  // 8-byte Folded Reload
	adcs	x3, x3, xzr
	adds	x9, x4, x9
	adcs	x8, x17, x8
	adcs	x10, x18, x10
	stp	x9, x8, [x0, #48]
	adcs	x8, x1, x11
	adcs	x9, x2, x12
	stp	x10, x8, [x0, #64]
	adcs	x8, x13, x15
	adcs	x10, x14, x16
	stp	x9, x8, [x0, #80]
	adcs	x8, x3, xzr
	stp	x10, x8, [x0, #96]
	add	sp, sp, #624                    // =624
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end161:
	.size	mclb_mul7, .Lfunc_end161-mclb_mul7
                                        // -- End function
	.globl	mclb_sqr7                       // -- Begin function mclb_sqr7
	.p2align	2
	.type	mclb_sqr7,@function
mclb_sqr7:                              // @mclb_sqr7
// %bb.0:
	sub	sp, sp, #224                    // =224
	ldp	x4, x16, [x1]
	ldp	x5, x3, [x1, #16]
	ldp	x15, x11, [x1, #32]
	stp	x22, x21, [sp, #192]            // 16-byte Folded Spill
	umulh	x14, x4, x4
	mul	x21, x16, x4
	stp	x28, x27, [sp, #144]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #208]            // 16-byte Folded Spill
	ldr	x12, [x1, #48]
	umulh	x1, x16, x4
	mul	x19, x5, x4
	adds	x27, x14, x21
	umulh	x22, x5, x4
	mul	x18, x3, x4
	adcs	x28, x1, x19
	stp	x29, x30, [sp, #128]            // 16-byte Folded Spill
	umulh	x7, x3, x4
	mul	x17, x15, x4
	adcs	x29, x22, x18
	umulh	x6, x15, x4
	mul	x9, x11, x4
	adcs	x30, x7, x17
	umulh	x13, x11, x4
	mul	x8, x12, x4
	adcs	x20, x6, x9
	stp	x18, x6, [sp, #32]              // 16-byte Folded Spill
	umulh	x10, x12, x4
	adcs	x6, x13, x8
	stp	x19, x7, [sp]                   // 16-byte Folded Spill
	mul	x2, x16, x16
	adcs	x7, x10, xzr
	stp	x26, x25, [sp, #160]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #176]            // 16-byte Folded Spill
	stp	x9, x10, [sp, #104]             // 16-byte Folded Spill
	umulh	x24, x16, x16
	mul	x26, x5, x16
	adds	x10, x1, x2
	umulh	x25, x5, x16
	mul	x2, x3, x16
	adcs	x24, x24, x26
	stp	x17, x13, [sp, #72]             // 16-byte Folded Spill
	umulh	x23, x3, x16
	mul	x9, x15, x16
	adcs	x17, x25, x2
	str	x8, [sp, #120]                  // 8-byte Folded Spill
	umulh	x13, x15, x16
	umulh	x19, x11, x16
	mul	x8, x11, x16
	adcs	x18, x23, x9
	stp	x8, x19, [sp, #56]              // 16-byte Folded Spill
	umulh	x1, x12, x16
	mul	x14, x12, x16
	adcs	x8, x13, x8
	stp	x14, x1, [sp, #88]              // 16-byte Folded Spill
	adcs	x14, x19, x14
	adcs	x16, x1, xzr
	adds	x21, x21, x27
	adcs	x19, x10, x28
	mul	x4, x4, x4
	stp	x4, x21, [x0]
	adcs	x21, x24, x29
	adcs	x1, x17, x30
	adcs	x4, x18, x20
	str	x13, [sp, #16]                  // 8-byte Folded Spill
	adcs	x13, x8, x6
	adcs	x14, x14, x7
	adcs	x16, x16, xzr
	adds	x17, x22, x26
	mul	x18, x5, x5
	adcs	x18, x25, x18
	umulh	x6, x5, x5
	mul	x24, x3, x5
	umulh	x22, x3, x5
	mul	x26, x15, x5
	adcs	x6, x6, x24
	umulh	x25, x15, x5
	umulh	x27, x11, x5
	mul	x28, x11, x5
	umulh	x10, x12, x5
	mul	x8, x12, x5
	adcs	x29, x22, x26
	ldr	x5, [sp]                        // 8-byte Folded Reload
	adcs	x30, x25, x28
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	adcs	x8, x27, x8
	str	x10, [sp, #48]                  // 8-byte Folded Spill
	adcs	x10, x10, xzr
	adds	x19, x5, x19
	adcs	x17, x17, x21
	adcs	x18, x18, x1
	adcs	x4, x6, x4
	adcs	x13, x29, x13
	adcs	x14, x30, x14
	adcs	x20, x8, x16
	ldr	x8, [sp, #8]                    // 8-byte Folded Reload
	adcs	x10, x10, xzr
	umulh	x6, x3, x3
	mul	x21, x15, x3
	adds	x16, x8, x2
	adcs	x1, x23, x24
	mul	x2, x3, x3
	adcs	x2, x22, x2
	umulh	x7, x15, x3
	mul	x23, x11, x3
	adcs	x6, x6, x21
	ldr	x5, [sp, #32]                   // 8-byte Folded Reload
	umulh	x22, x11, x3
	umulh	x24, x12, x3
	mul	x3, x12, x3
	adcs	x29, x7, x23
	adcs	x30, x22, x3
	adcs	x8, x24, xzr
	adds	x17, x5, x17
	adcs	x16, x16, x18
	stp	x19, x17, [x0, #16]
	adcs	x17, x1, x4
	adcs	x13, x2, x13
	adcs	x14, x6, x14
	ldr	x18, [sp, #40]                  // 8-byte Folded Reload
	adcs	x29, x29, x20
	adcs	x10, x30, x10
	adcs	x8, x8, xzr
	adds	x18, x18, x9
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	mul	x4, x15, x15
	umulh	x6, x15, x15
	mul	x19, x11, x15
	adcs	x1, x9, x26
	adcs	x2, x25, x21
	adcs	x4, x7, x4
	ldr	x26, [sp, #72]                  // 8-byte Folded Reload
	umulh	x7, x11, x15
	umulh	x20, x12, x15
	mul	x15, x12, x15
	adcs	x6, x6, x19
	adcs	x21, x7, x15
	adcs	x25, x20, xzr
	adds	x16, x26, x16
	adcs	x17, x18, x17
	adcs	x13, x1, x13
	adcs	x14, x2, x14
	adcs	x9, x4, x29
	ldr	x1, [sp, #80]                   // 8-byte Folded Reload
	ldr	x2, [sp, #56]                   // 8-byte Folded Reload
	adcs	x10, x6, x10
	adcs	x8, x21, x8
	adcs	x18, x25, xzr
	adds	x1, x1, x2
	ldr	x2, [sp, #64]                   // 8-byte Folded Reload
	mul	x21, x11, x11
	umulh	x4, x11, x11
	ldp	x26, x25, [sp, #160]            // 16-byte Folded Reload
	adcs	x2, x2, x28
	adcs	x6, x27, x23
	adcs	x19, x22, x19
	ldr	x23, [sp, #104]                 // 8-byte Folded Reload
	umulh	x22, x12, x11
	mul	x11, x12, x11
	adcs	x7, x7, x21
	adcs	x4, x4, x11
	adcs	x21, x22, xzr
	adds	x17, x23, x17
	adcs	x13, x1, x13
	adcs	x14, x2, x14
	adcs	x9, x6, x9
	adcs	x10, x19, x10
	adcs	x6, x7, x8
	stp	x16, x17, [x0, #32]
	adcs	x16, x4, x18
	ldp	x18, x4, [sp, #112]             // 16-byte Folded Reload
	ldr	x1, [sp, #88]                   // 8-byte Folded Reload
	adcs	x17, x21, xzr
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldp	x28, x27, [sp, #144]            // 16-byte Folded Reload
	adds	x18, x18, x1
	ldr	x1, [sp, #96]                   // 8-byte Folded Reload
	ldp	x29, x30, [sp, #128]            // 16-byte Folded Reload
	adcs	x1, x1, x8
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	adcs	x2, x8, x3
	adcs	x15, x24, x15
	adcs	x11, x20, x11
	mul	x3, x12, x12
	adcs	x3, x22, x3
	umulh	x8, x12, x12
	adcs	x8, x8, xzr
	adds	x13, x4, x13
	adcs	x14, x18, x14
	adcs	x12, x1, x9
	adcs	x10, x2, x10
	adcs	x9, x15, x6
	stp	x12, x10, [x0, #64]
	adcs	x10, x11, x16
	ldp	x20, x19, [sp, #208]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #192]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #176]            // 16-byte Folded Reload
	adcs	x11, x3, x17
	adcs	x8, x8, xzr
	stp	x13, x14, [x0, #48]
	stp	x9, x10, [x0, #80]
	stp	x11, x8, [x0, #96]
	add	sp, sp, #224                    // =224
	ret
.Lfunc_end162:
	.size	mclb_sqr7, .Lfunc_end162-mclb_sqr7
                                        // -- End function
	.globl	mulUnit_inner512                // -- Begin function mulUnit_inner512
	.p2align	2
	.type	mulUnit_inner512,@function
mulUnit_inner512:                       // @mulUnit_inner512
// %bb.0:
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	mul	x17, x9, x1
	umulh	x9, x9, x1
	umulh	x18, x10, x1
	mul	x10, x10, x1
	mul	x0, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x2, x12, x1
	adcs	x10, x18, x0
	umulh	x12, x12, x1
	mul	x3, x13, x1
	stp	x17, x9, [x8]
	adcs	x9, x11, x2
	umulh	x13, x13, x1
	mul	x4, x14, x1
	adcs	x11, x12, x3
	umulh	x14, x14, x1
	mul	x5, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x4
	umulh	x15, x15, x1
	mul	x6, x16, x1
	adcs	x10, x14, x5
	umulh	x16, x16, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x6
	adcs	x11, x16, xzr
	stp	x10, x9, [x8, #48]
	str	x11, [x8, #64]
	ret
.Lfunc_end163:
	.size	mulUnit_inner512, .Lfunc_end163-mulUnit_inner512
                                        // -- End function
	.globl	mclb_mulUnit8                   // -- Begin function mclb_mulUnit8
	.p2align	2
	.type	mclb_mulUnit8,@function
mclb_mulUnit8:                          // @mclb_mulUnit8
// %bb.0:
	sub	sp, sp, #96                     // =96
	stp	x30, x19, [sp, #80]             // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner512
	ldp	x8, x0, [sp, #56]
	ldp	q1, q0, [sp]
	ldr	q2, [sp, #32]
	ldr	x9, [sp, #48]
	stp	q1, q0, [x19]
	str	q2, [x19, #32]
	stp	x9, x8, [x19, #48]
	ldp	x30, x19, [sp, #80]             // 16-byte Folded Reload
	add	sp, sp, #96                     // =96
	ret
.Lfunc_end164:
	.size	mclb_mulUnit8, .Lfunc_end164-mclb_mulUnit8
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
.Lfunc_end165:
	.size	mclb_mulUnitAdd8, .Lfunc_end165-mclb_mulUnitAdd8
                                        // -- End function
	.globl	mclb_mul8                       // -- Begin function mclb_mul8
	.p2align	2
	.type	mclb_mul8,@function
mclb_mul8:                              // @mclb_mul8
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #656                    // =656
	mov	x20, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #576                    // =576
	mov	x0, x20
	mov	x21, x2
	bl	mulUnit_inner512
	ldr	x8, [sp, #576]
	ldr	x1, [x21, #8]
	ldr	x22, [sp, #640]
	ldr	x23, [sp, #632]
	ldr	x24, [sp, #624]
	ldr	x25, [sp, #616]
	ldr	x26, [sp, #608]
	ldr	x27, [sp, #600]
	ldr	x28, [sp, #592]
	ldr	x29, [sp, #584]
	str	x8, [x19]
	add	x8, sp, #496                    // =496
	mov	x0, x20
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #496]
	ldr	x16, [sp, #512]
	ldr	x15, [sp, #520]
	ldr	x14, [sp, #528]
	adds	x12, x12, x29
	ldr	x13, [sp, #536]
	adcs	x28, x11, x28
	ldr	x10, [sp, #544]
	adcs	x27, x16, x27
	ldr	x9, [sp, #552]
	adcs	x26, x15, x26
	ldr	x8, [sp, #560]
	adcs	x25, x14, x25
	ldr	x1, [x21, #16]
	adcs	x24, x13, x24
	adcs	x23, x10, x23
	adcs	x22, x9, x22
	adcs	x29, x8, xzr
	add	x8, sp, #416                    // =416
	mov	x0, x20
	str	x12, [x19, #8]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #416]
	ldr	x16, [sp, #432]
	ldp	x15, x14, [sp, #440]
	ldp	x13, x10, [sp, #456]
	adds	x12, x12, x28
	adcs	x27, x11, x27
	adcs	x26, x16, x26
	ldp	x9, x8, [sp, #472]
	adcs	x25, x15, x25
	adcs	x24, x14, x24
	ldr	x1, [x21, #24]
	adcs	x23, x13, x23
	adcs	x22, x10, x22
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #336                    // =336
	mov	x0, x20
	str	x12, [x19, #16]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #336]
	ldr	x16, [sp, #352]
	ldp	x15, x14, [sp, #360]
	ldp	x13, x10, [sp, #376]
	adds	x12, x12, x27
	adcs	x26, x11, x26
	adcs	x25, x16, x25
	ldp	x9, x8, [sp, #392]
	adcs	x24, x15, x24
	adcs	x23, x14, x23
	ldr	x1, [x21, #32]
	adcs	x22, x13, x22
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #256                    // =256
	mov	x0, x20
	str	x12, [x19, #24]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #256]
	ldr	x16, [sp, #272]
	ldp	x15, x14, [sp, #280]
	ldp	x13, x10, [sp, #296]
	adds	x12, x12, x26
	adcs	x25, x11, x25
	adcs	x24, x16, x24
	ldp	x9, x8, [sp, #312]
	adcs	x23, x15, x23
	adcs	x22, x14, x22
	ldr	x1, [x21, #40]
	adcs	x26, x13, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #176                    // =176
	mov	x0, x20
	str	x12, [x19, #32]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #176]
	ldr	x16, [sp, #192]
	ldp	x15, x14, [sp, #200]
	ldp	x13, x10, [sp, #216]
	adds	x12, x12, x25
	adcs	x24, x11, x24
	adcs	x23, x16, x23
	ldp	x9, x8, [sp, #232]
	adcs	x22, x15, x22
	adcs	x25, x14, x26
	ldr	x1, [x21, #48]
	adcs	x26, x13, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #96                     // =96
	mov	x0, x20
	str	x12, [x19, #40]
	bl	mulUnit_inner512
	ldp	x14, x13, [sp, #96]
	ldr	x16, [sp, #112]
	ldp	x15, x12, [sp, #120]
	ldp	x11, x10, [sp, #136]
	adds	x14, x14, x24
	ldr	x1, [x21, #56]
	adcs	x21, x13, x23
	adcs	x22, x16, x22
	ldp	x9, x8, [sp, #152]
	adcs	x23, x15, x25
	adcs	x24, x12, x26
	adcs	x25, x11, x27
	adcs	x26, x10, x28
	adcs	x27, x9, x29
	adcs	x28, x8, xzr
	add	x8, sp, #16                     // =16
	mov	x0, x20
	str	x14, [x19, #48]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #16]
	ldp	x14, x13, [sp, #32]
	ldr	x16, [sp, #48]
	ldp	x15, x10, [sp, #56]
	adds	x12, x12, x21
	adcs	x11, x11, x22
	adcs	x14, x14, x23
	ldp	x9, x8, [sp, #72]
	stp	x12, x11, [x19, #56]
	adcs	x11, x13, x24
	adcs	x12, x16, x25
	stp	x14, x11, [x19, #72]
	adcs	x11, x15, x26
	adcs	x10, x10, x27
	adcs	x9, x9, x28
	adcs	x8, x8, xzr
	stp	x12, x11, [x19, #88]
	stp	x10, x9, [x19, #104]
	str	x8, [x19, #120]
	add	sp, sp, #656                    // =656
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end166:
	.size	mclb_mul8, .Lfunc_end166-mclb_mul8
                                        // -- End function
	.globl	mclb_sqr8                       // -- Begin function mclb_sqr8
	.p2align	2
	.type	mclb_sqr8,@function
mclb_sqr8:                              // @mclb_sqr8
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #640                    // =640
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #560                    // =560
	mov	x0, x20
	bl	mulUnit_inner512
	ldr	x8, [sp, #560]
	ldr	x1, [x20, #8]
	ldr	x21, [sp, #624]
	ldr	x22, [sp, #616]
	ldr	x23, [sp, #608]
	ldr	x24, [sp, #600]
	ldr	x25, [sp, #592]
	ldr	x26, [sp, #584]
	ldr	x27, [sp, #576]
	ldr	x28, [sp, #568]
	str	x8, [x19]
	add	x8, sp, #480                    // =480
	mov	x0, x20
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #480]
	ldr	x16, [sp, #496]
	ldp	x15, x14, [sp, #504]
	ldr	x13, [sp, #520]
	adds	x12, x12, x28
	adcs	x27, x11, x27
	ldr	x10, [sp, #528]
	adcs	x26, x16, x26
	ldr	x9, [sp, #536]
	adcs	x25, x15, x25
	ldr	x8, [sp, #544]
	adcs	x24, x14, x24
	ldr	x1, [x20, #16]
	adcs	x23, x13, x23
	adcs	x22, x10, x22
	adcs	x21, x9, x21
	adcs	x28, x8, xzr
	add	x8, sp, #400                    // =400
	mov	x0, x20
	str	x12, [x19, #8]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #400]
	ldr	x16, [sp, #416]
	ldp	x15, x14, [sp, #424]
	ldp	x13, x10, [sp, #440]
	adds	x12, x12, x27
	adcs	x26, x11, x26
	adcs	x25, x16, x25
	ldp	x9, x8, [sp, #456]
	adcs	x24, x15, x24
	adcs	x23, x14, x23
	ldr	x1, [x20, #24]
	adcs	x22, x13, x22
	adcs	x21, x10, x21
	adcs	x27, x9, x28
	adcs	x28, x8, xzr
	add	x8, sp, #320                    // =320
	mov	x0, x20
	str	x12, [x19, #16]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #320]
	ldr	x16, [sp, #336]
	ldp	x15, x14, [sp, #344]
	ldp	x13, x10, [sp, #360]
	adds	x12, x12, x26
	adcs	x25, x11, x25
	adcs	x24, x16, x24
	ldp	x9, x8, [sp, #376]
	adcs	x23, x15, x23
	adcs	x22, x14, x22
	ldr	x1, [x20, #32]
	adcs	x21, x13, x21
	adcs	x26, x10, x27
	adcs	x27, x9, x28
	adcs	x28, x8, xzr
	add	x8, sp, #240                    // =240
	mov	x0, x20
	str	x12, [x19, #24]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #240]
	ldr	x16, [sp, #256]
	ldp	x15, x14, [sp, #264]
	ldp	x13, x10, [sp, #280]
	adds	x12, x12, x25
	adcs	x24, x11, x24
	adcs	x23, x16, x23
	ldp	x9, x8, [sp, #296]
	adcs	x22, x15, x22
	adcs	x21, x14, x21
	ldr	x1, [x20, #40]
	adcs	x25, x13, x26
	adcs	x26, x10, x27
	adcs	x27, x9, x28
	adcs	x28, x8, xzr
	add	x8, sp, #160                    // =160
	mov	x0, x20
	str	x12, [x19, #32]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #160]
	ldr	x16, [sp, #176]
	ldp	x15, x14, [sp, #184]
	ldp	x13, x10, [sp, #200]
	adds	x12, x12, x24
	adcs	x23, x11, x23
	adcs	x22, x16, x22
	ldp	x9, x8, [sp, #216]
	adcs	x21, x15, x21
	adcs	x24, x14, x25
	ldr	x1, [x20, #48]
	adcs	x25, x13, x26
	adcs	x26, x10, x27
	adcs	x27, x9, x28
	adcs	x28, x8, xzr
	add	x8, sp, #80                     // =80
	mov	x0, x20
	str	x12, [x19, #40]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp, #80]
	ldr	x16, [sp, #96]
	ldp	x15, x14, [sp, #104]
	ldp	x13, x10, [sp, #120]
	adds	x12, x12, x23
	adcs	x22, x11, x22
	adcs	x21, x16, x21
	ldp	x9, x8, [sp, #136]
	adcs	x23, x15, x24
	adcs	x24, x14, x25
	ldr	x1, [x20, #56]
	adcs	x25, x13, x26
	adcs	x26, x10, x27
	adcs	x27, x9, x28
	adcs	x28, x8, xzr
	mov	x8, sp
	mov	x0, x20
	str	x12, [x19, #48]
	bl	mulUnit_inner512
	ldp	x12, x11, [sp]
	ldp	x14, x13, [sp, #16]
	ldr	x16, [sp, #32]
	ldp	x15, x10, [sp, #40]
	adds	x12, x12, x22
	adcs	x11, x11, x21
	adcs	x14, x14, x23
	ldp	x9, x8, [sp, #56]
	stp	x12, x11, [x19, #56]
	adcs	x11, x13, x24
	adcs	x12, x16, x25
	stp	x14, x11, [x19, #72]
	adcs	x11, x15, x26
	adcs	x10, x10, x27
	adcs	x9, x9, x28
	adcs	x8, x8, xzr
	stp	x12, x11, [x19, #88]
	stp	x10, x9, [x19, #104]
	str	x8, [x19, #120]
	add	sp, sp, #640                    // =640
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end167:
	.size	mclb_sqr8, .Lfunc_end167-mclb_sqr8
                                        // -- End function
	.globl	mulUnit_inner576                // -- Begin function mulUnit_inner576
	.p2align	2
	.type	mulUnit_inner576,@function
mulUnit_inner576:                       // @mulUnit_inner576
// %bb.0:
	str	x19, [sp, #-16]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	ldr	x17, [x0, #64]
	mul	x18, x9, x1
	umulh	x9, x9, x1
	umulh	x0, x10, x1
	mul	x10, x10, x1
	mul	x2, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x3, x12, x1
	adcs	x10, x0, x2
	umulh	x12, x12, x1
	mul	x4, x13, x1
	stp	x18, x9, [x8]
	adcs	x9, x11, x3
	umulh	x13, x13, x1
	mul	x5, x14, x1
	adcs	x11, x12, x4
	umulh	x14, x14, x1
	mul	x6, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x5
	umulh	x15, x15, x1
	mul	x7, x16, x1
	adcs	x10, x14, x6
	umulh	x16, x16, x1
	mul	x19, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x7
	umulh	x17, x17, x1
	adcs	x11, x16, x19
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, xzr
	stp	x11, x9, [x8, #64]
	ldr	x19, [sp], #16                  // 8-byte Folded Reload
	ret
.Lfunc_end168:
	.size	mulUnit_inner576, .Lfunc_end168-mulUnit_inner576
                                        // -- End function
	.globl	mclb_mulUnit9                   // -- Begin function mclb_mulUnit9
	.p2align	2
	.type	mclb_mulUnit9,@function
mclb_mulUnit9:                          // @mclb_mulUnit9
// %bb.0:
	sub	sp, sp, #96                     // =96
	stp	x30, x19, [sp, #80]             // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner576
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldp	x8, x0, [sp, #64]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	str	x8, [x19, #64]
	ldp	x30, x19, [sp, #80]             // 16-byte Folded Reload
	add	sp, sp, #96                     // =96
	ret
.Lfunc_end169:
	.size	mclb_mulUnit9, .Lfunc_end169-mclb_mulUnit9
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
.Lfunc_end170:
	.size	mclb_mulUnitAdd9, .Lfunc_end170-mclb_mulUnitAdd9
                                        // -- End function
	.globl	mclb_mul9                       // -- Begin function mclb_mul9
	.p2align	2
	.type	mclb_mul9,@function
mclb_mul9:                              // @mclb_mul9
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #752                    // =752
	mov	x20, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #672                    // =672
	mov	x0, x20
	mov	x21, x2
	bl	mulUnit_inner576
	ldr	x8, [sp, #744]
	ldr	x1, [x21, #8]
	ldr	x23, [sp, #736]
	ldr	x24, [sp, #728]
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	ldr	x8, [sp, #672]
	ldr	x25, [sp, #720]
	ldr	x26, [sp, #712]
	ldr	x27, [sp, #704]
	ldr	x28, [sp, #696]
	ldr	x29, [sp, #688]
	ldr	x22, [sp, #680]
	str	x8, [x19]
	add	x8, sp, #592                    // =592
	mov	x0, x20
	bl	mulUnit_inner576
	ldr	x13, [sp, #592]
	ldr	x12, [sp, #600]
	ldr	x17, [sp, #608]
	ldr	x16, [sp, #616]
	ldr	x15, [sp, #624]
	adds	x13, x13, x22
	ldr	x14, [sp, #632]
	adcs	x22, x12, x29
	ldr	x11, [sp, #640]
	adcs	x12, x17, x28
	ldr	x10, [sp, #648]
	adcs	x27, x16, x27
	adcs	x26, x15, x26
	adcs	x25, x14, x25
	adcs	x24, x11, x24
	ldr	x9, [sp, #656]
	adcs	x23, x10, x23
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #664]
	ldr	x1, [x21, #16]
	mov	x0, x20
	adcs	x29, x9, x10
	adcs	x28, x8, xzr
	add	x8, sp, #512                    // =512
	str	x12, [sp, #16]                  // 8-byte Folded Spill
	str	x13, [x19, #8]
	bl	mulUnit_inner576
	ldr	x13, [sp, #512]
	ldr	x12, [sp, #520]
	ldr	x18, [sp, #16]                  // 8-byte Folded Reload
	ldr	x17, [sp, #528]
	ldr	x16, [sp, #536]
	ldr	x15, [sp, #544]
	adds	x13, x13, x22
	ldr	x14, [sp, #552]
	adcs	x22, x12, x18
	ldr	x11, [sp, #560]
	adcs	x12, x17, x27
	ldr	x10, [sp, #568]
	adcs	x26, x16, x26
	ldr	x9, [sp, #576]
	adcs	x25, x15, x25
	ldr	x8, [sp, #584]
	adcs	x24, x14, x24
	ldr	x1, [x21, #24]
	adcs	x23, x11, x23
	adcs	x29, x10, x29
	adcs	x28, x9, x28
	adcs	x27, x8, xzr
	add	x8, sp, #432                    // =432
	mov	x0, x20
	str	x12, [sp, #24]                  // 8-byte Folded Spill
	str	x13, [x19, #16]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #432]
	ldr	x18, [sp, #24]                  // 8-byte Folded Reload
	ldp	x17, x16, [sp, #448]
	ldp	x15, x14, [sp, #464]
	adds	x13, x13, x22
	adcs	x22, x12, x18
	ldp	x11, x10, [sp, #480]
	adcs	x12, x17, x26
	adcs	x25, x16, x25
	ldp	x9, x8, [sp, #496]
	adcs	x24, x15, x24
	adcs	x23, x14, x23
	ldr	x1, [x21, #32]
	adcs	x29, x11, x29
	adcs	x28, x10, x28
	adcs	x27, x9, x27
	adcs	x26, x8, xzr
	add	x8, sp, #352                    // =352
	mov	x0, x20
	str	x12, [sp, #24]                  // 8-byte Folded Spill
	str	x13, [x19, #24]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #352]
	ldr	x18, [sp, #24]                  // 8-byte Folded Reload
	ldp	x17, x16, [sp, #368]
	ldp	x15, x14, [sp, #384]
	adds	x13, x13, x22
	adcs	x22, x12, x18
	ldp	x11, x10, [sp, #400]
	adcs	x12, x17, x25
	adcs	x24, x16, x24
	ldp	x9, x8, [sp, #416]
	adcs	x23, x15, x23
	adcs	x29, x14, x29
	ldr	x1, [x21, #40]
	adcs	x28, x11, x28
	adcs	x27, x10, x27
	adcs	x26, x9, x26
	adcs	x25, x8, xzr
	add	x8, sp, #272                    // =272
	mov	x0, x20
	str	x12, [sp, #24]                  // 8-byte Folded Spill
	str	x13, [x19, #32]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #272]
	ldr	x18, [sp, #24]                  // 8-byte Folded Reload
	ldp	x17, x16, [sp, #288]
	ldp	x15, x14, [sp, #304]
	adds	x13, x13, x22
	adcs	x22, x12, x18
	ldp	x11, x10, [sp, #320]
	adcs	x12, x17, x24
	adcs	x23, x16, x23
	ldp	x9, x8, [sp, #336]
	adcs	x29, x15, x29
	adcs	x28, x14, x28
	ldr	x1, [x21, #48]
	adcs	x27, x11, x27
	adcs	x26, x10, x26
	adcs	x25, x9, x25
	adcs	x24, x8, xzr
	add	x8, sp, #192                    // =192
	mov	x0, x20
	str	x12, [sp, #24]                  // 8-byte Folded Spill
	str	x13, [x19, #40]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #192]
	ldr	x18, [sp, #24]                  // 8-byte Folded Reload
	ldp	x17, x16, [sp, #208]
	ldp	x15, x14, [sp, #224]
	adds	x13, x13, x22
	adcs	x22, x12, x18
	ldp	x11, x10, [sp, #240]
	adcs	x23, x17, x23
	adcs	x29, x16, x29
	ldp	x9, x8, [sp, #256]
	adcs	x28, x15, x28
	adcs	x27, x14, x27
	adcs	x26, x11, x26
	ldr	x1, [x21, #56]
	adcs	x25, x10, x25
	adcs	x24, x9, x24
	adcs	x8, x8, xzr
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	add	x8, sp, #112                    // =112
	mov	x0, x20
	str	x13, [x19, #48]
	bl	mulUnit_inner576
	ldp	x15, x14, [sp, #112]
	ldp	x17, x16, [sp, #128]
	ldp	x13, x12, [sp, #144]
	ldr	x1, [x21, #64]
	adds	x15, x15, x22
	adcs	x21, x14, x23
	ldp	x11, x10, [sp, #160]
	adcs	x22, x17, x29
	adcs	x23, x16, x28
	adcs	x27, x13, x27
	adcs	x26, x12, x26
	adcs	x25, x11, x25
	ldp	x9, x8, [sp, #176]
	adcs	x24, x10, x24
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	mov	x0, x20
	str	x15, [x19, #56]
	adcs	x28, x9, x10
	adcs	x29, x8, xzr
	add	x8, sp, #32                     // =32
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #32]
	ldp	x15, x14, [sp, #48]
	ldp	x17, x16, [sp, #64]
	ldp	x11, x10, [sp, #80]
	adds	x13, x13, x21
	adcs	x12, x12, x22
	adcs	x15, x15, x23
	ldp	x9, x8, [sp, #96]
	stp	x13, x12, [x19, #64]
	adcs	x12, x14, x27
	adcs	x13, x17, x26
	stp	x15, x12, [x19, #80]
	adcs	x12, x16, x25
	adcs	x11, x11, x24
	adcs	x10, x10, x28
	adcs	x9, x9, x29
	adcs	x8, x8, xzr
	stp	x13, x12, [x19, #96]
	stp	x11, x10, [x19, #112]
	stp	x9, x8, [x19, #128]
	add	sp, sp, #752                    // =752
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end171:
	.size	mclb_mul9, .Lfunc_end171-mclb_mul9
                                        // -- End function
	.globl	mclb_sqr9                       // -- Begin function mclb_sqr9
	.p2align	2
	.type	mclb_sqr9,@function
mclb_sqr9:                              // @mclb_sqr9
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #736                    // =736
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #656                    // =656
	mov	x0, x20
	bl	mulUnit_inner576
	ldr	x8, [sp, #656]
	ldr	x1, [x20, #8]
	ldr	x21, [sp, #728]
	ldr	x22, [sp, #720]
	ldr	x23, [sp, #712]
	ldr	x24, [sp, #704]
	ldr	x25, [sp, #696]
	ldr	x26, [sp, #688]
	ldr	x27, [sp, #680]
	ldr	x28, [sp, #672]
	ldr	x29, [sp, #664]
	str	x8, [x19]
	add	x8, sp, #576                    // =576
	mov	x0, x20
	bl	mulUnit_inner576
	ldr	x13, [sp, #576]
	ldr	x12, [sp, #584]
	ldr	x17, [sp, #592]
	ldr	x16, [sp, #600]
	ldr	x15, [sp, #608]
	adds	x13, x13, x29
	ldr	x14, [sp, #616]
	adcs	x28, x12, x28
	ldr	x11, [sp, #624]
	adcs	x27, x17, x27
	ldr	x10, [sp, #632]
	adcs	x26, x16, x26
	ldr	x9, [sp, #640]
	adcs	x25, x15, x25
	ldr	x8, [sp, #648]
	adcs	x24, x14, x24
	ldr	x1, [x20, #16]
	adcs	x23, x11, x23
	adcs	x22, x10, x22
	adcs	x21, x9, x21
	adcs	x29, x8, xzr
	add	x8, sp, #496                    // =496
	mov	x0, x20
	str	x13, [x19, #8]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #496]
	ldr	x17, [sp, #512]
	ldr	x16, [sp, #520]
	ldr	x15, [sp, #528]
	adds	x13, x13, x28
	ldr	x14, [sp, #536]
	adcs	x27, x12, x27
	ldr	x11, [sp, #544]
	adcs	x26, x17, x26
	ldr	x10, [sp, #552]
	adcs	x25, x16, x25
	ldr	x9, [sp, #560]
	adcs	x24, x15, x24
	ldr	x8, [sp, #568]
	adcs	x23, x14, x23
	ldr	x1, [x20, #24]
	adcs	x22, x11, x22
	adcs	x21, x10, x21
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #416                    // =416
	mov	x0, x20
	str	x13, [x19, #16]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #416]
	ldp	x17, x16, [sp, #432]
	ldp	x15, x14, [sp, #448]
	ldp	x11, x10, [sp, #464]
	adds	x13, x13, x27
	adcs	x26, x12, x26
	adcs	x25, x17, x25
	adcs	x24, x16, x24
	ldp	x9, x8, [sp, #480]
	adcs	x23, x15, x23
	adcs	x22, x14, x22
	ldr	x1, [x20, #32]
	adcs	x21, x11, x21
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #336                    // =336
	mov	x0, x20
	str	x13, [x19, #24]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #336]
	ldp	x17, x16, [sp, #352]
	ldp	x15, x14, [sp, #368]
	ldp	x11, x10, [sp, #384]
	adds	x13, x13, x26
	adcs	x25, x12, x25
	adcs	x24, x17, x24
	adcs	x23, x16, x23
	ldp	x9, x8, [sp, #400]
	adcs	x22, x15, x22
	adcs	x21, x14, x21
	ldr	x1, [x20, #40]
	adcs	x26, x11, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #256                    // =256
	mov	x0, x20
	str	x13, [x19, #32]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #256]
	ldp	x17, x16, [sp, #272]
	ldp	x15, x14, [sp, #288]
	ldp	x11, x10, [sp, #304]
	adds	x13, x13, x25
	adcs	x24, x12, x24
	adcs	x23, x17, x23
	adcs	x22, x16, x22
	ldp	x9, x8, [sp, #320]
	adcs	x21, x15, x21
	adcs	x25, x14, x26
	ldr	x1, [x20, #48]
	adcs	x26, x11, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #176                    // =176
	mov	x0, x20
	str	x13, [x19, #40]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #176]
	ldp	x17, x16, [sp, #192]
	ldp	x15, x14, [sp, #208]
	ldp	x11, x10, [sp, #224]
	adds	x13, x13, x24
	adcs	x23, x12, x23
	adcs	x22, x17, x22
	adcs	x21, x16, x21
	ldp	x9, x8, [sp, #240]
	adcs	x24, x15, x25
	adcs	x25, x14, x26
	ldr	x1, [x20, #56]
	adcs	x26, x11, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #96                     // =96
	mov	x0, x20
	str	x13, [x19, #48]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #96]
	ldp	x17, x16, [sp, #112]
	ldp	x15, x14, [sp, #128]
	ldp	x11, x10, [sp, #144]
	adds	x13, x13, x23
	adcs	x22, x12, x22
	adcs	x21, x17, x21
	adcs	x23, x16, x24
	ldp	x9, x8, [sp, #160]
	adcs	x24, x15, x25
	adcs	x25, x14, x26
	ldr	x1, [x20, #64]
	adcs	x26, x11, x27
	adcs	x27, x10, x28
	adcs	x28, x9, x29
	adcs	x29, x8, xzr
	add	x8, sp, #16                     // =16
	mov	x0, x20
	str	x13, [x19, #56]
	bl	mulUnit_inner576
	ldp	x13, x12, [sp, #16]
	ldp	x15, x14, [sp, #32]
	ldp	x17, x16, [sp, #48]
	ldp	x11, x10, [sp, #64]
	adds	x13, x13, x22
	adcs	x12, x12, x21
	adcs	x15, x15, x23
	ldp	x9, x8, [sp, #80]
	stp	x13, x12, [x19, #64]
	adcs	x12, x14, x24
	adcs	x13, x17, x25
	stp	x15, x12, [x19, #80]
	adcs	x12, x16, x26
	adcs	x11, x11, x27
	adcs	x10, x10, x28
	adcs	x9, x9, x29
	adcs	x8, x8, xzr
	stp	x13, x12, [x19, #96]
	stp	x11, x10, [x19, #112]
	stp	x9, x8, [x19, #128]
	add	sp, sp, #736                    // =736
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end172:
	.size	mclb_sqr9, .Lfunc_end172-mclb_sqr9
                                        // -- End function
	.globl	mulUnit_inner640                // -- Begin function mulUnit_inner640
	.p2align	2
	.type	mulUnit_inner640,@function
mulUnit_inner640:                       // @mulUnit_inner640
// %bb.0:
	str	x21, [sp, #-32]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	ldp	x17, x18, [x0, #64]
	mul	x0, x9, x1
	umulh	x9, x9, x1
	umulh	x2, x10, x1
	mul	x10, x10, x1
	mul	x3, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x4, x12, x1
	adcs	x10, x2, x3
	stp	x20, x19, [sp, #16]             // 16-byte Folded Spill
	umulh	x12, x12, x1
	mul	x5, x13, x1
	stp	x0, x9, [x8]
	adcs	x9, x11, x4
	umulh	x13, x13, x1
	mul	x6, x14, x1
	adcs	x11, x12, x5
	umulh	x14, x14, x1
	mul	x7, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x6
	umulh	x15, x15, x1
	mul	x19, x16, x1
	adcs	x10, x14, x7
	umulh	x16, x16, x1
	mul	x20, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x19
	umulh	x17, x17, x1
	mul	x21, x18, x1
	adcs	x11, x16, x20
	umulh	x18, x18, x1
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x21
	adcs	x10, x18, xzr
	stp	x11, x9, [x8, #64]
	str	x10, [x8, #80]
	ldp	x20, x19, [sp, #16]             // 16-byte Folded Reload
	ldr	x21, [sp], #32                  // 8-byte Folded Reload
	ret
.Lfunc_end173:
	.size	mulUnit_inner640, .Lfunc_end173-mulUnit_inner640
                                        // -- End function
	.globl	mclb_mulUnit10                  // -- Begin function mclb_mulUnit10
	.p2align	2
	.type	mclb_mulUnit10,@function
mclb_mulUnit10:                         // @mclb_mulUnit10
// %bb.0:
	sub	sp, sp, #112                    // =112
	stp	x30, x19, [sp, #96]             // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner640
	ldp	x8, x0, [sp, #72]
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldr	x9, [sp, #64]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	stp	x9, x8, [x19, #64]
	ldp	x30, x19, [sp, #96]             // 16-byte Folded Reload
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end174:
	.size	mclb_mulUnit10, .Lfunc_end174-mclb_mulUnit10
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
.Lfunc_end175:
	.size	mclb_mulUnitAdd10, .Lfunc_end175-mclb_mulUnitAdd10
                                        // -- End function
	.globl	mclb_mul10                      // -- Begin function mclb_mul10
	.p2align	2
	.type	mclb_mul10,@function
mclb_mul10:                             // @mclb_mul10
// %bb.0:
	sub	sp, sp, #352                    // =352
	stp	x29, x30, [sp, #256]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #272]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #288]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #304]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #320]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #336]            // 16-byte Folded Spill
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	add	x22, x1, #40                    // =40
	add	x23, x2, #40                    // =40
	add	x24, x0, #80                    // =80
	bl	mclb_mul5
	mov	x0, x24
	mov	x1, x22
	mov	x2, x23
	bl	mclb_mul5
	ldp	x13, x12, [x21, #32]
	ldp	x17, x16, [x21]
	ldp	x11, x10, [x21, #48]
	ldp	x15, x14, [x21, #16]
	ldp	x9, x8, [x21, #64]
	adds	x12, x17, x12
	adcs	x11, x16, x11
	ldp	x4, x3, [x20, #32]
	ldp	x23, x7, [x20]
	adcs	x22, x15, x10
	ldp	x2, x1, [x20, #48]
	adcs	x24, x14, x9
	ldp	x6, x5, [x20, #16]
	adcs	x25, x13, x8
	ldp	x0, x18, [x20, #64]
	adcs	x8, xzr, xzr
	adds	x23, x23, x3
	adcs	x26, x7, x2
	adcs	x27, x6, x1
	adcs	x28, x5, x0
	adcs	x29, x4, x18
	adcs	x10, xzr, xzr
	orn	x9, x8, x25
	cmp	x8, #0                          // =0
	str	x11, [sp, #72]                  // 8-byte Folded Spill
	stp	x12, x11, [sp, #136]
	cset	w11, ne
	cmp	x9, #0                          // =0
	orn	x8, x10, x29
	csel	w20, wzr, w11, eq
	cmp	x10, #0                         // =0
	cset	w9, ne
	cmp	x8, #0                          // =0
	add	x0, sp, #176                    // =176
	add	x1, sp, #136                    // =136
	add	x2, sp, #96                     // =96
	stp	x22, x24, [sp, #152]
	str	x25, [sp, #168]
	stp	x12, x23, [sp, #88]             // 8-byte Folded Spill
	stp	x26, x27, [sp, #104]
	stp	x28, x29, [sp, #120]
	csel	w21, wzr, w9, eq
	bl	mclb_mul5
	ldr	x11, [sp, #72]                  // 8-byte Folded Reload
	cmp	w20, #0                         // =0
	csel	x7, x29, xzr, ne
	csel	x28, x28, xzr, ne
	csel	x27, x27, xzr, ne
	csel	x26, x26, xzr, ne
	csel	x23, x23, xzr, ne
	cmp	w21, #0                         // =0
	csel	x29, x11, xzr, ne
	ldr	x11, [sp, #88]                  // 8-byte Folded Reload
	ldr	x8, [sp, #176]
	csel	x25, x25, xzr, ne
	csel	x24, x24, xzr, ne
	csel	x30, x11, xzr, ne
	csel	x22, x22, xzr, ne
	adds	x23, x30, x23
	str	x8, [sp, #80]                   // 8-byte Folded Spill
	ldr	x9, [sp, #248]
	ldp	x17, x8, [sp, #232]
	adcs	x26, x29, x26
	adcs	x22, x22, x27
	ldp	x16, x15, [sp, #216]
	adcs	x24, x24, x28
	adcs	x7, x25, x7
	stp	x8, x9, [sp, #56]               // 16-byte Folded Spill
	adcs	x25, xzr, xzr
	tst	w20, w21
	ldr	x11, [sp, #56]                  // 8-byte Folded Reload
	cinc	x25, x25, ne
	adds	x5, x23, x16
	adcs	x0, x26, x15
	adcs	x15, x22, x17
	adcs	x16, x24, x11
	ldr	x11, [sp, #64]                  // 8-byte Folded Reload
	ldp	x4, x3, [x19]
	ldp	x21, x20, [x19, #80]
	ldp	x2, x1, [x19, #16]
	ldp	x28, x27, [x19, #96]
	adcs	x17, x7, x11
	adcs	x7, x25, xzr
	ldp	x30, x29, [x19, #112]
	ldp	x23, x26, [x19, #32]
	adds	x4, x4, x21
	adcs	x3, x3, x20
	ldp	x6, x9, [x19, #48]
	ldp	x8, x12, [x19, #128]
	adcs	x2, x2, x28
	ldp	x13, x18, [x19, #64]
	adcs	x1, x1, x27
	ldp	x10, x14, [x19, #144]
	adcs	x22, x23, x30
	adcs	x23, x26, x29
	adcs	x24, x6, x8
	stp	x13, x8, [sp, #16]              // 16-byte Folded Spill
	adcs	x25, x9, x12
	ldr	x8, [sp, #80]                   // 8-byte Folded Reload
	stp	x12, x14, [sp, #40]             // 16-byte Folded Spill
	adcs	x12, x13, x10
	adcs	x13, x18, x14
	adcs	x14, xzr, xzr
	str	x29, [sp, #88]                  // 8-byte Folded Spill
	mov	x29, x18
	subs	x4, x8, x4
	ldp	x8, x18, [sp, #184]
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldp	x10, x11, [sp, #200]
	sbcs	x8, x8, x3
	sbcs	x2, x18, x2
	sbcs	x10, x10, x1
	sbcs	x11, x11, x22
	sbcs	x18, x5, x23
	sbcs	x0, x0, x24
	sbcs	x15, x15, x25
	sbcs	x12, x16, x12
	sbcs	x13, x17, x13
	sbcs	x14, x7, x14
	adds	x16, x26, x4
	adcs	x8, x6, x8
	stp	x16, x8, [x19, #40]
	ldr	x8, [sp, #16]                   // 8-byte Folded Reload
	adcs	x9, x9, x2
	ldp	x24, x23, [sp, #304]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #288]            // 16-byte Folded Reload
	adcs	x8, x8, x10
	adcs	x10, x29, x11
	stp	x9, x8, [x19, #56]
	adcs	x8, x21, x18
	adcs	x9, x20, x0
	stp	x10, x8, [x19, #72]
	adcs	x8, x28, x15
	adcs	x10, x27, x12
	stp	x9, x8, [x19, #88]
	adcs	x8, x30, x13
	ldr	x9, [sp, #88]                   // 8-byte Folded Reload
	stp	x10, x8, [x19, #104]
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	ldp	x22, x21, [sp, #320]            // 16-byte Folded Reload
	adcs	x9, x9, x14
	ldp	x28, x27, [sp, #272]            // 16-byte Folded Reload
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #120]
	ldp	x9, x8, [sp, #32]               // 16-byte Folded Reload
	ldp	x29, x30, [sp, #256]            // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #136]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [x19, #152]
	ldp	x20, x19, [sp, #336]            // 16-byte Folded Reload
	add	sp, sp, #352                    // =352
	ret
.Lfunc_end176:
	.size	mclb_mul10, .Lfunc_end176-mclb_mul10
                                        // -- End function
	.globl	mclb_sqr10                      // -- Begin function mclb_sqr10
	.p2align	2
	.type	mclb_sqr10,@function
mclb_sqr10:                             // @mclb_sqr10
// %bb.0:
	sub	sp, sp, #320                    // =320
	mov	x2, x1
	stp	x29, x30, [sp, #224]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #240]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #256]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #272]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #288]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #304]            // 16-byte Folded Spill
	mov	x20, x1
	mov	x19, x0
	add	x21, x1, #40                    // =40
	add	x22, x0, #80                    // =80
	bl	mclb_mul5
	mov	x0, x22
	mov	x1, x21
	mov	x2, x21
	bl	mclb_mul5
	ldp	x17, x12, [x20, #32]
	ldp	x14, x13, [x20]
	ldp	x11, x10, [x20, #48]
	ldp	x16, x15, [x20, #16]
	ldp	x9, x8, [x20, #64]
	adds	x20, x14, x12
	adcs	x21, x13, x11
	adcs	x22, x16, x10
	adcs	x23, x15, x9
	adcs	x24, x17, x8
	adcs	x8, xzr, xzr
	orn	x9, x8, x24
	cmp	x8, #0                          // =0
	cset	w8, ne
	cmp	x9, #0                          // =0
	add	x0, sp, #144                    // =144
	add	x1, sp, #104                    // =104
	add	x2, sp, #64                     // =64
	stp	x20, x21, [sp, #104]
	stp	x20, x21, [sp, #64]
	stp	x22, x23, [sp, #120]
	stp	x22, x23, [sp, #80]
	str	x24, [sp, #136]
	csel	w25, wzr, w8, eq
	str	x24, [sp, #96]
	bl	mclb_mul5
	ldr	x18, [sp, #184]
	ldp	x17, x16, [sp, #192]
	cmp	w25, #0                         // =0
	ldp	x15, x14, [sp, #208]
	csel	x20, x20, xzr, ne
	csel	x21, x21, xzr, ne
	csel	x22, x22, xzr, ne
	csel	x23, x23, xzr, ne
	csel	x24, x24, xzr, ne
	add	x25, x25, x24, lsr #63
	extr	x24, x24, x23, #63
	extr	x23, x23, x22, #63
	extr	x22, x22, x21, #63
	extr	x21, x21, x20, #63
	adds	x18, x18, x20, lsl #1
	adcs	x0, x21, x17
	ldp	x5, x4, [x19]
	ldr	x30, [x19, #80]
	adcs	x16, x22, x16
	ldp	x29, x28, [x19, #88]
	adcs	x15, x23, x15
	ldp	x3, x2, [x19, #16]
	adcs	x17, x24, x14
	ldr	x10, [sp, #144]
	ldr	x8, [x19, #152]
	ldp	x27, x26, [x19, #104]
	adcs	x22, x25, xzr
	ldp	x20, x21, [x19, #32]
	adds	x5, x5, x30
	ldp	x7, x13, [x19, #120]
	adcs	x4, x4, x29
	ldp	x1, x6, [x19, #48]
	adcs	x3, x3, x28
	stp	x8, x10, [sp, #48]              // 16-byte Folded Spill
	ldp	x12, x10, [x19, #136]
	adcs	x2, x2, x27
	ldp	x11, x9, [x19, #64]
	adcs	x20, x20, x26
	adcs	x23, x21, x7
	adcs	x24, x1, x13
	adcs	x25, x6, x12
	stp	x10, x12, [sp, #32]             // 16-byte Folded Spill
	adcs	x12, x11, x10
	stp	x26, x13, [sp, #16]             // 16-byte Folded Spill
	adcs	x13, x9, x8
	ldr	x8, [sp, #56]                   // 8-byte Folded Reload
	adcs	x14, xzr, xzr
	str	x7, [sp, #8]                    // 8-byte Folded Spill
	mov	x7, x9
	subs	x5, x8, x5
	ldp	x8, x9, [sp, #152]
	mov	x26, x11
	ldp	x10, x11, [sp, #168]
	sbcs	x8, x8, x4
	sbcs	x9, x9, x3
	sbcs	x10, x10, x2
	sbcs	x11, x11, x20
	sbcs	x18, x18, x23
	sbcs	x0, x0, x24
	sbcs	x16, x16, x25
	sbcs	x12, x15, x12
	sbcs	x13, x17, x13
	sbcs	x14, x22, x14
	adds	x15, x21, x5
	adcs	x8, x1, x8
	adcs	x9, x6, x9
	stp	x15, x8, [x19, #40]
	adcs	x8, x26, x10
	adcs	x10, x7, x11
	stp	x9, x8, [x19, #56]
	adcs	x8, x30, x18
	adcs	x9, x29, x0
	stp	x10, x8, [x19, #72]
	adcs	x8, x28, x16
	stp	x9, x8, [x19, #88]
	ldp	x9, x8, [sp, #8]                // 16-byte Folded Reload
	adcs	x10, x27, x12
	ldp	x22, x21, [sp, #288]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #272]            // 16-byte Folded Reload
	adcs	x8, x8, x13
	stp	x10, x8, [x19, #104]
	ldr	x8, [sp, #24]                   // 8-byte Folded Reload
	adcs	x9, x9, x14
	ldp	x26, x25, [sp, #256]            // 16-byte Folded Reload
	ldp	x28, x27, [sp, #240]            // 16-byte Folded Reload
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #120]
	ldp	x9, x8, [sp, #32]               // 16-byte Folded Reload
	ldp	x29, x30, [sp, #224]            // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #136]
	ldr	x8, [sp, #48]                   // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [x19, #152]
	ldp	x20, x19, [sp, #304]            // 16-byte Folded Reload
	add	sp, sp, #320                    // =320
	ret
.Lfunc_end177:
	.size	mclb_sqr10, .Lfunc_end177-mclb_sqr10
                                        // -- End function
	.globl	mulUnit_inner704                // -- Begin function mulUnit_inner704
	.p2align	2
	.type	mulUnit_inner704,@function
mulUnit_inner704:                       // @mulUnit_inner704
// %bb.0:
	str	x23, [sp, #-48]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	mul	x2, x9, x1
	umulh	x9, x9, x1
	umulh	x3, x10, x1
	mul	x10, x10, x1
	mul	x4, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x5, x12, x1
	adcs	x10, x3, x4
	stp	x22, x21, [sp, #16]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             // 16-byte Folded Spill
	ldp	x17, x18, [x0, #64]
	ldr	x0, [x0, #80]
	umulh	x12, x12, x1
	mul	x6, x13, x1
	stp	x2, x9, [x8]
	adcs	x9, x11, x5
	umulh	x13, x13, x1
	mul	x7, x14, x1
	adcs	x11, x12, x6
	umulh	x14, x14, x1
	mul	x19, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x7
	umulh	x15, x15, x1
	mul	x20, x16, x1
	adcs	x10, x14, x19
	umulh	x16, x16, x1
	mul	x21, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x20
	umulh	x17, x17, x1
	mul	x22, x18, x1
	adcs	x11, x16, x21
	umulh	x18, x18, x1
	mul	x23, x0, x1
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x22
	umulh	x0, x0, x1
	adcs	x10, x18, x23
	stp	x11, x9, [x8, #64]
	adcs	x9, x0, xzr
	stp	x10, x9, [x8, #80]
	ldp	x20, x19, [sp, #32]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             // 16-byte Folded Reload
	ldr	x23, [sp], #48                  // 8-byte Folded Reload
	ret
.Lfunc_end178:
	.size	mulUnit_inner704, .Lfunc_end178-mulUnit_inner704
                                        // -- End function
	.globl	mclb_mulUnit11                  // -- Begin function mclb_mulUnit11
	.p2align	2
	.type	mclb_mulUnit11,@function
mclb_mulUnit11:                         // @mclb_mulUnit11
// %bb.0:
	sub	sp, sp, #112                    // =112
	stp	x30, x19, [sp, #96]             // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner704
	ldp	x8, x0, [sp, #80]
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldr	q4, [sp, #64]
	str	x8, [x19, #80]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	str	q4, [x19, #64]
	ldp	x30, x19, [sp, #96]             // 16-byte Folded Reload
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end179:
	.size	mclb_mulUnit11, .Lfunc_end179-mclb_mulUnit11
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
.Lfunc_end180:
	.size	mclb_mulUnitAdd11, .Lfunc_end180-mclb_mulUnitAdd11
                                        // -- End function
	.globl	mclb_mul11                      // -- Begin function mclb_mul11
	.p2align	2
	.type	mclb_mul11,@function
mclb_mul11:                             // @mclb_mul11
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1104                   // =1104
	mov	x20, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #1008                   // =1008
	mov	x0, x20
	mov	x21, x2
	bl	mulUnit_inner704
	ldr	x9, [sp, #1096]
	ldr	x8, [sp, #1088]
	ldr	x1, [x21, #8]
	ldr	x25, [sp, #1072]
	ldr	x26, [sp, #1064]
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	ldr	x8, [sp, #1080]
	ldr	x27, [sp, #1056]
	ldr	x28, [sp, #1048]
	ldr	x29, [sp, #1040]
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	ldr	x8, [sp, #1008]
	ldr	x22, [sp, #1032]
	ldr	x23, [sp, #1024]
	ldr	x24, [sp, #1016]
	str	x8, [x19]
	add	x8, sp, #912                    // =912
	mov	x0, x20
	bl	mulUnit_inner704
	ldr	x15, [sp, #912]
	ldr	x14, [sp, #920]
	ldr	x0, [sp, #928]
	ldr	x18, [sp, #936]
	ldr	x17, [sp, #944]
	adds	x15, x15, x24
	ldr	x16, [sp, #952]
	adcs	x23, x14, x23
	ldr	x13, [sp, #960]
	adcs	x14, x0, x22
	ldr	x12, [sp, #968]
	adcs	x24, x18, x29
	adcs	x28, x17, x28
	adcs	x27, x16, x27
	adcs	x26, x13, x26
	ldr	x11, [sp, #976]
	adcs	x25, x12, x25
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldr	x10, [sp, #984]
	ldr	x9, [sp, #992]
	ldr	x8, [sp, #1000]
	adcs	x29, x11, x12
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	ldr	x1, [x21, #16]
	mov	x0, x20
	str	x15, [x19, #8]
	adcs	x10, x10, x11
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #40]                  // 8-byte Folded Reload
	adcs	x22, x9, x10
	adcs	x8, x8, xzr
	stp	x14, x8, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #816                    // =816
	bl	mulUnit_inner704
	ldr	x15, [sp, #816]
	ldr	x14, [sp, #824]
	ldr	x2, [sp, #16]                   // 8-byte Folded Reload
	ldr	x0, [sp, #832]
	ldr	x18, [sp, #840]
	ldr	x17, [sp, #848]
	adds	x15, x15, x23
	ldr	x16, [sp, #856]
	adcs	x23, x14, x2
	ldr	x13, [sp, #864]
	adcs	x14, x0, x24
	ldr	x12, [sp, #872]
	adcs	x28, x18, x28
	adcs	x27, x17, x27
	adcs	x26, x16, x26
	adcs	x25, x13, x25
	ldr	x11, [sp, #880]
	adcs	x29, x12, x29
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #888]
	ldr	x9, [sp, #896]
	ldr	x8, [sp, #904]
	adcs	x11, x11, x12
	adcs	x22, x10, x22
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x21, #24]
	mov	x0, x20
	stp	x11, x14, [sp, #32]             // 16-byte Folded Spill
	adcs	x24, x9, x10
	adcs	x8, x8, xzr
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	add	x8, sp, #720                    // =720
	str	x15, [x19, #16]
	bl	mulUnit_inner704
	ldr	x15, [sp, #720]
	ldr	x14, [sp, #728]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldr	x0, [sp, #736]
	ldr	x18, [sp, #744]
	ldr	x17, [sp, #752]
	adds	x15, x15, x23
	ldr	x16, [sp, #760]
	adcs	x23, x14, x2
	ldr	x13, [sp, #768]
	adcs	x14, x0, x28
	adcs	x27, x18, x27
	adcs	x26, x17, x26
	adcs	x25, x16, x25
	ldr	x12, [sp, #776]
	adcs	x29, x13, x29
	ldr	x13, [sp, #32]                  // 8-byte Folded Reload
	ldr	x11, [sp, #784]
	ldr	x10, [sp, #792]
	ldr	x9, [sp, #800]
	adcs	x12, x12, x13
	adcs	x22, x11, x22
	adcs	x24, x10, x24
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #808]
	ldr	x1, [x21, #32]
	mov	x0, x20
	adcs	x28, x9, x10
	adcs	x8, x8, xzr
	str	x8, [sp, #24]                   // 8-byte Folded Spill
	add	x8, sp, #624                    // =624
	stp	x12, x14, [sp, #32]             // 16-byte Folded Spill
	str	x15, [x19, #24]
	bl	mulUnit_inner704
	ldr	x15, [sp, #624]
	ldr	x14, [sp, #632]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldr	x0, [sp, #640]
	ldr	x18, [sp, #648]
	adds	x15, x15, x23
	ldr	x17, [sp, #656]
	adcs	x23, x14, x2
	ldr	x16, [sp, #664]
	adcs	x14, x0, x27
	ldr	x13, [sp, #672]
	str	x14, [sp, #40]                  // 8-byte Folded Spill
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldr	x12, [sp, #680]
	adcs	x26, x18, x26
	ldr	x11, [sp, #688]
	adcs	x25, x17, x25
	ldr	x10, [sp, #696]
	adcs	x29, x16, x29
	adcs	x13, x13, x14
	adcs	x22, x12, x22
	adcs	x24, x11, x24
	ldr	x9, [sp, #704]
	adcs	x28, x10, x28
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #712]
	ldr	x1, [x21, #40]
	mov	x0, x20
	adcs	x27, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x13, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #528                    // =528
	str	x15, [x19, #32]
	bl	mulUnit_inner704
	ldr	x15, [sp, #528]
	ldr	x14, [sp, #536]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldr	x0, [sp, #544]
	adds	x15, x15, x23
	ldr	x18, [sp, #552]
	adcs	x23, x14, x2
	ldr	x17, [sp, #560]
	adcs	x14, x0, x26
	ldr	x16, [sp, #568]
	str	x14, [sp, #40]                  // 8-byte Folded Spill
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldr	x13, [sp, #576]
	ldr	x12, [sp, #584]
	adcs	x25, x18, x25
	ldr	x11, [sp, #592]
	adcs	x29, x17, x29
	ldr	x10, [sp, #600]
	adcs	x14, x16, x14
	adcs	x22, x13, x22
	adcs	x24, x12, x24
	adcs	x28, x11, x28
	ldr	x9, [sp, #608]
	adcs	x27, x10, x27
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #616]
	ldr	x1, [x21, #48]
	mov	x0, x20
	adcs	x26, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #432                    // =432
	str	x15, [x19, #40]
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #432]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldr	x0, [sp, #448]
	ldp	x18, x17, [sp, #456]
	adds	x15, x15, x23
	adcs	x23, x14, x2
	adcs	x14, x0, x25
	str	x14, [sp, #40]                  // 8-byte Folded Spill
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldp	x16, x13, [sp, #472]
	ldp	x12, x11, [sp, #488]
	adcs	x29, x18, x29
	adcs	x14, x17, x14
	ldp	x10, x9, [sp, #504]
	adcs	x22, x16, x22
	adcs	x24, x13, x24
	adcs	x28, x12, x28
	adcs	x27, x11, x27
	adcs	x26, x10, x26
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #520]
	ldr	x1, [x21, #56]
	mov	x0, x20
	adcs	x25, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #336                    // =336
	str	x15, [x19, #48]
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #336]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #352]
	ldp	x17, x16, [sp, #368]
	adds	x15, x15, x23
	adcs	x23, x14, x2
	adcs	x14, x0, x29
	str	x14, [sp, #40]                  // 8-byte Folded Spill
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldp	x13, x12, [sp, #384]
	ldp	x11, x10, [sp, #400]
	ldp	x9, x8, [sp, #416]
	adcs	x14, x18, x14
	adcs	x22, x17, x22
	adcs	x24, x16, x24
	adcs	x28, x13, x28
	adcs	x27, x12, x27
	adcs	x26, x11, x26
	adcs	x25, x10, x25
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x21, #64]
	mov	x0, x20
	str	x15, [x19, #56]
	adcs	x29, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #240                    // =240
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #240]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #256]
	ldp	x17, x16, [sp, #272]
	adds	x15, x15, x23
	adcs	x23, x14, x2
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldp	x13, x12, [sp, #288]
	ldp	x11, x10, [sp, #304]
	ldp	x9, x8, [sp, #320]
	adcs	x14, x0, x14
	adcs	x22, x18, x22
	adcs	x24, x17, x24
	adcs	x28, x16, x28
	adcs	x27, x13, x27
	adcs	x26, x12, x26
	adcs	x25, x11, x25
	adcs	x10, x10, x29
	stp	x10, x14, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x21, #72]
	mov	x0, x20
	str	x15, [x19, #64]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #144                    // =144
	mov	x29, x20
	bl	mulUnit_inner704
	ldp	x17, x16, [sp, #144]
	ldr	x2, [sp, #40]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #160]
	ldp	x15, x14, [sp, #176]
	adds	x17, x17, x23
	adcs	x20, x16, x2
	ldp	x13, x12, [sp, #192]
	ldr	x1, [x21, #80]
	adcs	x21, x0, x22
	adcs	x22, x18, x24
	adcs	x23, x15, x28
	adcs	x24, x14, x27
	adcs	x26, x13, x26
	ldp	x11, x10, [sp, #208]
	adcs	x25, x12, x25
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x8, [sp, #224]
	mov	x0, x29
	str	x17, [x19, #72]
	adcs	x27, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	adcs	x28, x10, x11
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	add	x8, sp, #48                     // =48
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #48]
	ldp	x17, x16, [sp, #64]
	ldp	x0, x18, [sp, #80]
	ldp	x13, x12, [sp, #96]
	adds	x15, x15, x20
	adcs	x14, x14, x21
	adcs	x17, x17, x22
	ldp	x9, x8, [sp, #128]
	ldp	x11, x10, [sp, #112]
	stp	x15, x14, [x19, #80]
	adcs	x14, x16, x23
	adcs	x15, x0, x24
	stp	x17, x14, [x19, #96]
	adcs	x14, x18, x26
	adcs	x13, x13, x25
	adcs	x12, x12, x27
	stp	x13, x12, [x19, #128]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x11, x11, x28
	stp	x15, x14, [x19, #112]
	adcs	x10, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	stp	x11, x10, [x19, #144]
	adcs	x9, x9, x12
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #160]
	add	sp, sp, #1104                   // =1104
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end181:
	.size	mclb_mul11, .Lfunc_end181-mclb_mul11
                                        // -- End function
	.globl	mclb_sqr11                      // -- Begin function mclb_sqr11
	.p2align	2
	.type	mclb_sqr11,@function
mclb_sqr11:                             // @mclb_sqr11
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1088                   // =1088
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #992                    // =992
	mov	x0, x20
	bl	mulUnit_inner704
	ldr	x9, [sp, #1080]
	ldr	x8, [sp, #1072]
	ldr	x1, [x20, #8]
	ldr	x23, [sp, #1064]
	ldr	x24, [sp, #1056]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	ldr	x8, [sp, #992]
	ldr	x25, [sp, #1048]
	ldr	x26, [sp, #1040]
	ldr	x27, [sp, #1032]
	ldr	x28, [sp, #1024]
	ldr	x29, [sp, #1016]
	ldr	x21, [sp, #1008]
	ldr	x22, [sp, #1000]
	str	x8, [x19]
	add	x8, sp, #896                    // =896
	mov	x0, x20
	bl	mulUnit_inner704
	ldr	x15, [sp, #896]
	ldr	x14, [sp, #904]
	ldr	x0, [sp, #912]
	ldr	x18, [sp, #920]
	ldr	x17, [sp, #928]
	adds	x15, x15, x22
	ldr	x16, [sp, #936]
	adcs	x21, x14, x21
	ldr	x13, [sp, #944]
	adcs	x14, x0, x29
	ldr	x12, [sp, #952]
	adcs	x28, x18, x28
	ldr	x11, [sp, #960]
	adcs	x27, x17, x27
	adcs	x26, x16, x26
	adcs	x25, x13, x25
	adcs	x24, x12, x24
	ldr	x10, [sp, #968]
	adcs	x23, x11, x23
	ldr	x11, [sp, #16]                  // 8-byte Folded Reload
	ldr	x9, [sp, #976]
	ldr	x8, [sp, #984]
	ldr	x1, [x20, #16]
	adcs	x29, x10, x11
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	mov	x0, x20
	str	x15, [x19, #8]
	adcs	x22, x9, x10
	adcs	x8, x8, xzr
	stp	x14, x8, [sp, #8]               // 16-byte Folded Spill
	add	x8, sp, #800                    // =800
	bl	mulUnit_inner704
	ldr	x15, [sp, #800]
	ldr	x14, [sp, #808]
	ldr	x2, [sp, #8]                    // 8-byte Folded Reload
	ldr	x0, [sp, #816]
	ldr	x18, [sp, #824]
	ldr	x17, [sp, #832]
	adds	x15, x15, x21
	ldr	x16, [sp, #840]
	adcs	x21, x14, x2
	ldr	x13, [sp, #848]
	adcs	x14, x0, x28
	ldr	x12, [sp, #856]
	adcs	x27, x18, x27
	ldr	x11, [sp, #864]
	adcs	x26, x17, x26
	ldr	x10, [sp, #872]
	adcs	x25, x16, x25
	adcs	x24, x13, x24
	adcs	x23, x12, x23
	adcs	x29, x11, x29
	ldr	x9, [sp, #880]
	adcs	x22, x10, x22
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x8, [sp, #888]
	ldr	x1, [x20, #24]
	mov	x0, x20
	adcs	x28, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #704                    // =704
	str	x15, [x19, #16]
	bl	mulUnit_inner704
	ldr	x15, [sp, #704]
	ldr	x14, [sp, #712]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldr	x0, [sp, #720]
	ldr	x18, [sp, #728]
	ldr	x17, [sp, #736]
	adds	x15, x15, x21
	ldr	x16, [sp, #744]
	adcs	x21, x14, x2
	ldr	x13, [sp, #752]
	adcs	x14, x0, x27
	ldr	x12, [sp, #760]
	adcs	x26, x18, x26
	ldr	x11, [sp, #768]
	adcs	x25, x17, x25
	ldr	x10, [sp, #776]
	adcs	x24, x16, x24
	adcs	x23, x13, x23
	adcs	x29, x12, x29
	adcs	x22, x11, x22
	ldr	x9, [sp, #784]
	adcs	x28, x10, x28
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x8, [sp, #792]
	ldr	x1, [x20, #32]
	mov	x0, x20
	adcs	x27, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #608                    // =608
	str	x15, [x19, #24]
	bl	mulUnit_inner704
	ldr	x15, [sp, #608]
	ldr	x14, [sp, #616]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldr	x0, [sp, #624]
	ldr	x18, [sp, #632]
	ldr	x17, [sp, #640]
	adds	x15, x15, x21
	ldr	x16, [sp, #648]
	adcs	x21, x14, x2
	ldr	x13, [sp, #656]
	adcs	x14, x0, x26
	ldr	x12, [sp, #664]
	adcs	x25, x18, x25
	ldr	x11, [sp, #672]
	adcs	x24, x17, x24
	ldr	x10, [sp, #680]
	adcs	x23, x16, x23
	adcs	x29, x13, x29
	adcs	x22, x12, x22
	adcs	x28, x11, x28
	ldr	x9, [sp, #688]
	adcs	x27, x10, x27
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x8, [sp, #696]
	ldr	x1, [x20, #40]
	mov	x0, x20
	adcs	x26, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #512                    // =512
	str	x15, [x19, #32]
	bl	mulUnit_inner704
	ldr	x15, [sp, #512]
	ldr	x14, [sp, #520]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldr	x0, [sp, #528]
	ldr	x18, [sp, #536]
	ldr	x17, [sp, #544]
	adds	x15, x15, x21
	ldr	x16, [sp, #552]
	adcs	x21, x14, x2
	ldr	x13, [sp, #560]
	adcs	x14, x0, x25
	ldr	x12, [sp, #568]
	adcs	x24, x18, x24
	ldr	x11, [sp, #576]
	adcs	x23, x17, x23
	ldr	x10, [sp, #584]
	adcs	x29, x16, x29
	adcs	x22, x13, x22
	adcs	x28, x12, x28
	adcs	x27, x11, x27
	ldr	x9, [sp, #592]
	adcs	x26, x10, x26
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x8, [sp, #600]
	ldr	x1, [x20, #48]
	mov	x0, x20
	adcs	x25, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #416                    // =416
	str	x15, [x19, #40]
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #416]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #432]
	ldp	x17, x16, [sp, #448]
	adds	x15, x15, x21
	adcs	x21, x14, x2
	ldp	x13, x12, [sp, #464]
	adcs	x14, x0, x24
	adcs	x23, x18, x23
	ldp	x11, x10, [sp, #480]
	adcs	x29, x17, x29
	adcs	x22, x16, x22
	adcs	x28, x13, x28
	adcs	x27, x12, x27
	adcs	x26, x11, x26
	ldp	x9, x8, [sp, #496]
	adcs	x25, x10, x25
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x1, [x20, #56]
	mov	x0, x20
	str	x15, [x19, #48]
	adcs	x24, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #320                    // =320
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #320]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #336]
	ldp	x17, x16, [sp, #352]
	adds	x15, x15, x21
	adcs	x21, x14, x2
	ldp	x13, x12, [sp, #368]
	adcs	x14, x0, x23
	adcs	x29, x18, x29
	ldp	x11, x10, [sp, #384]
	adcs	x22, x17, x22
	adcs	x28, x16, x28
	adcs	x27, x13, x27
	adcs	x26, x12, x26
	adcs	x25, x11, x25
	ldp	x9, x8, [sp, #400]
	adcs	x24, x10, x24
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x1, [x20, #64]
	mov	x0, x20
	str	x15, [x19, #56]
	adcs	x23, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #224                    // =224
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #224]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #240]
	ldp	x17, x16, [sp, #256]
	adds	x15, x15, x21
	adcs	x21, x14, x2
	ldp	x13, x12, [sp, #272]
	adcs	x14, x0, x29
	adcs	x22, x18, x22
	ldp	x11, x10, [sp, #288]
	adcs	x28, x17, x28
	adcs	x27, x16, x27
	adcs	x26, x13, x26
	adcs	x25, x12, x25
	adcs	x24, x11, x24
	ldp	x9, x8, [sp, #304]
	adcs	x23, x10, x23
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x1, [x20, #72]
	mov	x0, x20
	str	x15, [x19, #64]
	adcs	x29, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x14, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #128                    // =128
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #128]
	ldr	x2, [sp, #24]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #144]
	ldp	x17, x16, [sp, #160]
	adds	x15, x15, x21
	adcs	x21, x14, x2
	ldp	x13, x12, [sp, #176]
	adcs	x22, x0, x22
	adcs	x28, x18, x28
	ldp	x11, x10, [sp, #192]
	adcs	x27, x17, x27
	adcs	x26, x16, x26
	adcs	x25, x13, x25
	adcs	x24, x12, x24
	adcs	x23, x11, x23
	ldp	x9, x8, [sp, #208]
	adcs	x29, x10, x29
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	ldr	x1, [x20, #80]
	mov	x0, x20
	str	x15, [x19, #72]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #32                     // =32
	bl	mulUnit_inner704
	ldp	x15, x14, [sp, #32]
	ldp	x17, x16, [sp, #48]
	ldp	x0, x18, [sp, #64]
	ldp	x13, x12, [sp, #80]
	adds	x15, x15, x21
	adcs	x14, x14, x22
	adcs	x17, x17, x28
	ldp	x9, x8, [sp, #112]
	ldp	x11, x10, [sp, #96]
	stp	x15, x14, [x19, #80]
	adcs	x14, x16, x27
	adcs	x15, x0, x26
	stp	x17, x14, [x19, #96]
	adcs	x14, x18, x25
	adcs	x13, x13, x24
	adcs	x12, x12, x23
	stp	x13, x12, [x19, #128]
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	adcs	x11, x11, x29
	stp	x15, x14, [x19, #112]
	adcs	x10, x10, x12
	ldr	x12, [sp, #16]                  // 8-byte Folded Reload
	stp	x11, x10, [x19, #144]
	adcs	x9, x9, x12
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #160]
	add	sp, sp, #1088                   // =1088
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end182:
	.size	mclb_sqr11, .Lfunc_end182-mclb_sqr11
                                        // -- End function
	.globl	mulUnit_inner768                // -- Begin function mulUnit_inner768
	.p2align	2
	.type	mulUnit_inner768,@function
mulUnit_inner768:                       // @mulUnit_inner768
// %bb.0:
	str	x25, [sp, #-64]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	mul	x3, x9, x1
	umulh	x9, x9, x1
	umulh	x4, x10, x1
	mul	x10, x10, x1
	mul	x5, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x6, x12, x1
	adcs	x10, x4, x5
	stp	x24, x23, [sp, #16]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             // 16-byte Folded Spill
	ldp	x17, x18, [x0, #64]
	ldp	x2, x0, [x0, #80]
	umulh	x12, x12, x1
	mul	x7, x13, x1
	stp	x3, x9, [x8]
	adcs	x9, x11, x6
	umulh	x13, x13, x1
	mul	x19, x14, x1
	adcs	x11, x12, x7
	umulh	x14, x14, x1
	mul	x20, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x19
	umulh	x15, x15, x1
	mul	x21, x16, x1
	adcs	x10, x14, x20
	umulh	x16, x16, x1
	mul	x22, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x21
	umulh	x17, x17, x1
	mul	x23, x18, x1
	adcs	x11, x16, x22
	umulh	x18, x18, x1
	mul	x24, x2, x1
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x23
	umulh	x2, x2, x1
	mul	x25, x0, x1
	adcs	x10, x18, x24
	umulh	x0, x0, x1
	stp	x11, x9, [x8, #64]
	adcs	x9, x2, x25
	adcs	x11, x0, xzr
	stp	x10, x9, [x8, #80]
	str	x11, [x8, #96]
	ldp	x20, x19, [sp, #48]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             // 16-byte Folded Reload
	ldr	x25, [sp], #64                  // 8-byte Folded Reload
	ret
.Lfunc_end183:
	.size	mulUnit_inner768, .Lfunc_end183-mulUnit_inner768
                                        // -- End function
	.globl	mclb_mulUnit12                  // -- Begin function mclb_mulUnit12
	.p2align	2
	.type	mclb_mulUnit12,@function
mclb_mulUnit12:                         // @mclb_mulUnit12
// %bb.0:
	sub	sp, sp, #128                    // =128
	stp	x30, x19, [sp, #112]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner768
	ldp	x8, x0, [sp, #88]
	ldr	x9, [sp, #80]
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldr	q4, [sp, #64]
	stp	x9, x8, [x19, #80]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	str	q4, [x19, #64]
	ldp	x30, x19, [sp, #112]            // 16-byte Folded Reload
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end184:
	.size	mclb_mulUnit12, .Lfunc_end184-mclb_mulUnit12
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
.Lfunc_end185:
	.size	mclb_mulUnitAdd12, .Lfunc_end185-mclb_mulUnitAdd12
                                        // -- End function
	.globl	mclb_mul12                      // -- Begin function mclb_mul12
	.p2align	2
	.type	mclb_mul12,@function
mclb_mul12:                             // @mclb_mul12
// %bb.0:
	sub	sp, sp, #416                    // =416
	stp	x29, x30, [sp, #320]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #336]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #352]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #368]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #384]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #400]            // 16-byte Folded Spill
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	add	x22, x1, #48                    // =48
	add	x23, x2, #48                    // =48
	add	x24, x0, #96                    // =96
	bl	mclb_mul6
	mov	x0, x24
	mov	x1, x22
	mov	x2, x23
	bl	mclb_mul6
	ldr	x10, [x21, #40]
	ldr	d0, [x21, #32]
	ldr	x17, [x21, #24]
	ldr	d1, [x21, #16]
	ldr	x9, [x21, #88]
	mov	v0.d[1], x10
	ldr	x15, [x21, #72]
	ldr	d2, [x21, #64]
	fmov	x16, d0
	ldr	d0, [x21, #80]
	mov	v1.d[1], x17
	ldr	x18, [x21, #56]
	fmov	x1, d1
	ldr	d1, [x21, #48]
	mov	v0.d[1], x9
	mov	v2.d[1], x15
	ldp	x0, x14, [x21]
	ldr	x12, [x20, #24]
	ldr	x13, [x20, #40]
	fmov	x2, d0
	ldr	d0, [x20, #32]
	fmov	x3, d2
	ldr	d2, [x20, #16]
	mov	v1.d[1], x18
	fmov	x5, d1
	mov	v0.d[1], x13
	mov	v2.d[1], x12
	adds	x21, x0, x5
	ldr	x8, [x20, #88]
	ldr	x11, [x20, #72]
	ldr	x4, [x20, #56]
	ldr	d1, [x20, #48]
	fmov	x6, d0
	ldr	d0, [x20, #64]
	fmov	x7, d2
	ldr	d2, [x20, #80]
	ldp	x5, x0, [x20]
	adcs	x20, x14, x18
	adcs	x1, x1, x3
	adcs	x17, x17, x15
	adcs	x24, x16, x2
	mov	v1.d[1], x4
	adcs	x25, x10, x9
	fmov	x15, d1
	adcs	x9, xzr, xzr
	mov	v0.d[1], x11
	adds	x26, x5, x15
	fmov	x18, d0
	adcs	x27, x0, x4
	mov	v2.d[1], x8
	adcs	x28, x7, x18
	fmov	x14, d2
	adcs	x29, x12, x11
	stp	x21, x17, [sp, #96]             // 16-byte Folded Spill
	stp	x21, x20, [sp, #176]
	adcs	x21, x6, x14
	stp	x1, x20, [sp, #112]             // 16-byte Folded Spill
	adcs	x20, x13, x8
	adcs	x8, xzr, xzr
	orn	x10, x9, x24
	cmp	x9, #0                          // =0
	orn	x10, x10, x25
	cset	w11, ne
	csel	w11, wzr, w11, eq
	cmp	x10, #0                         // =0
	orn	x9, x8, x21
	csel	w23, wzr, w11, eq
	cmp	x8, #0                          // =0
	orn	x9, x9, x20
	cset	w8, ne
	stp	x1, x17, [sp, #192]
	csel	w8, wzr, w8, eq
	cmp	x9, #0                          // =0
	add	x0, sp, #224                    // =224
	add	x1, sp, #176                    // =176
	add	x2, sp, #128                    // =128
	stp	x24, x25, [sp, #208]
	stp	x26, x27, [sp, #128]
	stp	x28, x29, [sp, #144]
	csel	w22, wzr, w8, eq
	stp	x21, x20, [sp, #160]
	bl	mclb_mul6
	ldr	x2, [sp, #104]                  // 8-byte Folded Reload
	cmp	w23, #0                         // =0
	csel	x7, x20, xzr, ne
	csel	x20, x21, xzr, ne
	csel	x13, x29, xzr, ne
	csel	x15, x28, xzr, ne
	csel	x21, x27, xzr, ne
	csel	x26, x26, xzr, ne
	cmp	w22, #0                         // =0
	csel	x27, x2, xzr, ne
	ldr	x2, [sp, #112]                  // 8-byte Folded Reload
	ldr	x9, [sp, #232]
	ldr	x8, [sp, #224]
	csel	x25, x25, xzr, ne
	csel	x28, x2, xzr, ne
	ldr	x2, [sp, #120]                  // 8-byte Folded Reload
	csel	x24, x24, xzr, ne
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldp	x14, x8, [sp, #304]
	csel	x29, x2, xzr, ne
	ldr	x2, [sp, #96]                   // 8-byte Folded Reload
	ldp	x1, x0, [sp, #272]
	ldp	x18, x17, [sp, #288]
	str	x8, [sp, #72]                   // 8-byte Folded Spill
	csel	x30, x2, xzr, ne
	adds	x26, x30, x26
	adcs	x2, x29, x21
	adcs	x28, x28, x15
	adcs	x27, x27, x13
	adcs	x20, x24, x20
	adcs	x7, x25, x7
	adcs	x24, xzr, xzr
	tst	w23, w22
	cinc	x24, x24, ne
	adds	x8, x26, x1
	adcs	x2, x2, x0
	adcs	x25, x28, x18
	adcs	x23, x27, x17
	adcs	x26, x20, x14
	ldr	x14, [sp, #72]                  // 8-byte Folded Reload
	ldp	x30, x29, [x19]
	ldp	x0, x18, [x19, #96]
	ldp	x6, x5, [x19, #16]
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	ldp	x8, x21, [x19, #112]
	adcs	x1, x7, x14
	adcs	x7, x24, xzr
	ldp	x4, x3, [x19, #32]
	ldp	x9, x22, [x19, #128]
	adds	x24, x30, x0
	adcs	x29, x29, x18
	ldp	x13, x15, [x19, #144]
	ldp	x27, x20, [x19, #48]
	adcs	x6, x6, x8
	adcs	x5, x5, x21
	ldp	x16, x12, [x19, #64]
	stp	x9, x21, [sp, #96]              // 16-byte Folded Spill
	adcs	x4, x4, x9
	ldp	x21, x30, [x19, #160]
	adcs	x3, x3, x22
	ldp	x10, x11, [x19, #80]
	stp	x15, x22, [sp, #112]            // 16-byte Folded Spill
	ldp	x22, x28, [x19, #176]
	adcs	x14, x27, x13
	stp	x8, x13, [sp, #56]              // 16-byte Folded Spill
	adcs	x13, x20, x15
	adcs	x15, x16, x21
	mov	x9, x16
	adcs	x16, x12, x30
	ldr	x8, [sp, #80]                   // 8-byte Folded Reload
	adcs	x17, x10, x22
	stp	x0, x18, [sp, #40]              // 16-byte Folded Spill
	adcs	x18, x11, x28
	adcs	x0, xzr, xzr
	subs	x24, x8, x24
	ldr	x8, [sp, #88]                   // 8-byte Folded Reload
	stp	x12, x11, [sp, #24]             // 16-byte Folded Spill
	str	x10, [sp, #16]                  // 8-byte Folded Spill
	ldp	x10, x11, [sp, #256]
	sbcs	x29, x8, x29
	ldp	x8, x12, [sp, #240]
	sbcs	x8, x8, x6
	sbcs	x5, x12, x5
	ldr	x12, [sp, #8]                   // 8-byte Folded Reload
	sbcs	x10, x10, x4
	sbcs	x11, x11, x3
	sbcs	x12, x12, x14
	sbcs	x13, x2, x13
	sbcs	x14, x25, x15
	sbcs	x15, x23, x16
	sbcs	x16, x26, x17
	sbcs	x17, x1, x18
	sbcs	x18, x7, x0
	adds	x0, x27, x24
	adcs	x2, x20, x29
	adcs	x8, x9, x8
	stp	x0, x2, [x19, #48]
	ldp	x0, x9, [sp, #16]               // 16-byte Folded Reload
	ldp	x24, x23, [sp, #368]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #352]            // 16-byte Folded Reload
	adcs	x9, x9, x5
	stp	x8, x9, [x19, #64]
	ldp	x8, x9, [sp, #32]               // 16-byte Folded Reload
	adcs	x10, x0, x10
	adcs	x8, x8, x11
	stp	x10, x8, [x19, #80]
	ldp	x8, x10, [sp, #48]              // 16-byte Folded Reload
	adcs	x9, x9, x12
	adcs	x8, x8, x13
	stp	x9, x8, [x19, #96]
	ldp	x9, x8, [sp, #96]               // 16-byte Folded Reload
	adcs	x10, x10, x14
	adcs	x8, x8, x15
	stp	x10, x8, [x19, #112]
	ldr	x8, [sp, #120]                  // 8-byte Folded Reload
	adcs	x9, x9, x16
	ldr	x10, [sp, #64]                  // 8-byte Folded Reload
	adcs	x8, x8, x17
	stp	x9, x8, [x19, #128]
	ldr	x8, [sp, #112]                  // 8-byte Folded Reload
	adcs	x10, x10, x18
	adcs	x8, x8, xzr
	stp	x10, x8, [x19, #144]
	adcs	x8, x21, xzr
	adcs	x9, x30, xzr
	stp	x8, x9, [x19, #160]
	adcs	x8, x22, xzr
	adcs	x9, x28, xzr
	stp	x8, x9, [x19, #176]
	ldp	x20, x19, [sp, #400]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #384]            // 16-byte Folded Reload
	ldp	x28, x27, [sp, #336]            // 16-byte Folded Reload
	ldp	x29, x30, [sp, #320]            // 16-byte Folded Reload
	add	sp, sp, #416                    // =416
	ret
.Lfunc_end186:
	.size	mclb_mul12, .Lfunc_end186-mclb_mul12
                                        // -- End function
	.globl	mclb_sqr12                      // -- Begin function mclb_sqr12
	.p2align	2
	.type	mclb_sqr12,@function
mclb_sqr12:                             // @mclb_sqr12
// %bb.0:
	sub	sp, sp, #416                    // =416
	mov	x2, x1
	stp	x29, x30, [sp, #320]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #336]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #352]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #368]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #384]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #400]            // 16-byte Folded Spill
	mov	x20, x1
	mov	x19, x0
	add	x21, x1, #48                    // =48
	add	x22, x0, #96                    // =96
	bl	mclb_mul6
	mov	x0, x22
	mov	x1, x21
	mov	x2, x21
	bl	mclb_mul6
	ldr	x12, [x20, #56]
	ldr	d2, [x20, #48]
	ldp	x9, x8, [x20]
	ldr	x11, [x20, #72]
	ldr	x13, [x20, #24]
	ldr	d1, [x20, #16]
	ldr	d3, [x20, #64]
	ldr	x10, [x20, #88]
	ldr	x14, [x20, #40]
	ldr	d0, [x20, #32]
	ldr	d4, [x20, #80]
	mov	v2.d[1], x12
	fmov	x0, d2
	mov	v1.d[1], x13
	mov	v3.d[1], x11
	adds	x20, x9, x0
	fmov	x16, d1
	fmov	x18, d3
	adcs	x21, x8, x12
	mov	v0.d[1], x14
	mov	v4.d[1], x10
	adcs	x22, x16, x18
	fmov	x15, d0
	fmov	x17, d4
	adcs	x23, x13, x11
	adcs	x24, x15, x17
	adcs	x25, x14, x10
	adcs	x8, xzr, xzr
	cmp	x8, #0                          // =0
	orn	x8, x8, x24
	cset	w9, ne
	orn	x8, x8, x25
	csel	w9, wzr, w9, eq
	cmp	x8, #0                          // =0
	add	x0, sp, #224                    // =224
	add	x1, sp, #176                    // =176
	add	x2, sp, #128                    // =128
	stp	x20, x21, [sp, #176]
	stp	x20, x21, [sp, #128]
	stp	x22, x23, [sp, #192]
	stp	x22, x23, [sp, #144]
	stp	x24, x25, [sp, #208]
	csel	w26, wzr, w9, eq
	stp	x24, x25, [sp, #160]
	bl	mclb_mul6
	ldp	x3, x2, [sp, #272]
	ldp	x1, x0, [sp, #288]
	cmp	w26, #0                         // =0
	csel	x20, x20, xzr, ne
	csel	x21, x21, xzr, ne
	csel	x22, x22, xzr, ne
	csel	x23, x23, xzr, ne
	csel	x24, x24, xzr, ne
	csel	x25, x25, xzr, ne
	ldp	x18, x17, [sp, #304]
	extr	x30, x25, x24, #63
	extr	x24, x24, x23, #63
	extr	x23, x23, x22, #63
	extr	x22, x22, x21, #63
	extr	x21, x21, x20, #63
	adds	x16, x3, x20, lsl #1
	adcs	x20, x21, x2
	add	x25, x26, x25, lsr #63
	adcs	x26, x22, x1
	ldp	x29, x28, [x19]
	ldp	x21, x2, [x19, #96]
	adcs	x3, x23, x0
	adcs	x22, x24, x18
	ldp	x27, x7, [x19, #16]
	str	x16, [sp, #16]                  // 8-byte Folded Spill
	ldp	x4, x16, [x19, #112]
	adcs	x1, x30, x17
	adcs	x25, x25, xzr
	ldp	x6, x5, [x19, #32]
	ldp	x14, x12, [x19, #128]
	adds	x29, x29, x21
	adcs	x28, x28, x2
	ldr	x9, [sp, #232]
	ldr	x8, [sp, #224]
	ldp	x13, x11, [x19, #144]
	ldp	x24, x23, [x19, #48]
	adcs	x27, x27, x4
	adcs	x7, x7, x16
	ldp	x15, x10, [x19, #64]
	str	x2, [sp, #72]                   // 8-byte Folded Spill
	adcs	x6, x6, x14
	ldp	x2, x30, [x19, #160]
	adcs	x5, x5, x12
	stp	x8, x9, [sp, #112]              // 16-byte Folded Spill
	ldp	x9, x8, [x19, #80]
	stp	x11, x12, [sp, #96]             // 16-byte Folded Spill
	stp	x21, x4, [sp, #48]              // 16-byte Folded Spill
	ldp	x4, x21, [x19, #176]
	adcs	x12, x24, x13
	str	x13, [sp, #64]                  // 8-byte Folded Spill
	adcs	x13, x23, x11
	stp	x14, x16, [sp, #80]             // 16-byte Folded Spill
	adcs	x14, x15, x2
	mov	x0, x15
	adcs	x15, x10, x30
	adcs	x16, x9, x4
	stp	x10, x8, [sp, #32]              // 16-byte Folded Spill
	adcs	x17, x8, x21
	ldr	x8, [sp, #112]                  // 8-byte Folded Reload
	adcs	x18, xzr, xzr
	str	x9, [sp, #24]                   // 8-byte Folded Spill
	ldp	x10, x11, [sp, #256]
	subs	x29, x8, x29
	ldr	x8, [sp, #120]                  // 8-byte Folded Reload
	sbcs	x28, x8, x28
	ldp	x8, x9, [sp, #240]
	sbcs	x8, x8, x27
	sbcs	x9, x9, x7
	sbcs	x10, x10, x6
	sbcs	x11, x11, x5
	ldr	x5, [sp, #16]                   // 8-byte Folded Reload
	sbcs	x12, x5, x12
	sbcs	x13, x20, x13
	sbcs	x14, x26, x14
	sbcs	x15, x3, x15
	sbcs	x16, x22, x16
	sbcs	x17, x1, x17
	sbcs	x18, x25, x18
	adds	x1, x24, x29
	adcs	x3, x23, x28
	adcs	x8, x0, x8
	ldr	x0, [sp, #32]                   // 8-byte Folded Reload
	stp	x1, x3, [x19, #48]
	ldp	x24, x23, [sp, #368]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #352]            // 16-byte Folded Reload
	adcs	x9, x0, x9
	ldr	x0, [sp, #24]                   // 8-byte Folded Reload
	stp	x8, x9, [x19, #64]
	ldp	x8, x9, [sp, #40]               // 16-byte Folded Reload
	ldp	x28, x27, [sp, #336]            // 16-byte Folded Reload
	adcs	x10, x0, x10
	adcs	x8, x8, x11
	stp	x10, x8, [x19, #80]
	ldr	x8, [sp, #72]                   // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x10, [sp, #56]                  // 8-byte Folded Reload
	adcs	x8, x8, x13
	stp	x9, x8, [x19, #96]
	ldp	x9, x8, [sp, #80]               // 16-byte Folded Reload
	adcs	x10, x10, x14
	adcs	x8, x8, x15
	stp	x10, x8, [x19, #112]
	ldr	x8, [sp, #104]                  // 8-byte Folded Reload
	adcs	x9, x9, x16
	ldr	x10, [sp, #64]                  // 8-byte Folded Reload
	adcs	x8, x8, x17
	stp	x9, x8, [x19, #128]
	ldr	x8, [sp, #96]                   // 8-byte Folded Reload
	adcs	x10, x10, x18
	adcs	x8, x8, xzr
	stp	x10, x8, [x19, #144]
	adcs	x8, x2, xzr
	adcs	x9, x30, xzr
	stp	x8, x9, [x19, #160]
	adcs	x8, x4, xzr
	adcs	x9, x21, xzr
	stp	x8, x9, [x19, #176]
	ldp	x20, x19, [sp, #400]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #384]            // 16-byte Folded Reload
	ldp	x29, x30, [sp, #320]            // 16-byte Folded Reload
	add	sp, sp, #416                    // =416
	ret
.Lfunc_end187:
	.size	mclb_sqr12, .Lfunc_end187-mclb_sqr12
                                        // -- End function
	.globl	mulUnit_inner832                // -- Begin function mulUnit_inner832
	.p2align	2
	.type	mulUnit_inner832,@function
mulUnit_inner832:                       // @mulUnit_inner832
// %bb.0:
	str	x27, [sp, #-80]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	mul	x4, x9, x1
	umulh	x9, x9, x1
	umulh	x5, x10, x1
	mul	x10, x10, x1
	mul	x6, x11, x1
	adds	x9, x9, x10
	umulh	x11, x11, x1
	mul	x7, x12, x1
	adcs	x10, x5, x6
	stp	x26, x25, [sp, #16]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             // 16-byte Folded Spill
	ldp	x17, x18, [x0, #64]
	ldp	x2, x3, [x0, #80]
	ldr	x0, [x0, #96]
	umulh	x12, x12, x1
	mul	x19, x13, x1
	stp	x4, x9, [x8]
	adcs	x9, x11, x7
	umulh	x13, x13, x1
	mul	x20, x14, x1
	adcs	x11, x12, x19
	umulh	x14, x14, x1
	mul	x21, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x20
	umulh	x15, x15, x1
	mul	x22, x16, x1
	adcs	x10, x14, x21
	umulh	x16, x16, x1
	mul	x23, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x22
	umulh	x17, x17, x1
	mul	x24, x18, x1
	adcs	x11, x16, x23
	umulh	x18, x18, x1
	mul	x25, x2, x1
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x24
	umulh	x2, x2, x1
	mul	x26, x3, x1
	adcs	x10, x18, x25
	umulh	x3, x3, x1
	mul	x27, x0, x1
	stp	x11, x9, [x8, #64]
	adcs	x9, x2, x26
	umulh	x0, x0, x1
	adcs	x11, x3, x27
	stp	x10, x9, [x8, #80]
	adcs	x9, x0, xzr
	stp	x11, x9, [x8, #96]
	ldp	x20, x19, [sp, #64]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             // 16-byte Folded Reload
	ldr	x27, [sp], #80                  // 8-byte Folded Reload
	ret
.Lfunc_end188:
	.size	mulUnit_inner832, .Lfunc_end188-mulUnit_inner832
                                        // -- End function
	.globl	mclb_mulUnit13                  // -- Begin function mclb_mulUnit13
	.p2align	2
	.type	mclb_mulUnit13,@function
mclb_mulUnit13:                         // @mclb_mulUnit13
// %bb.0:
	sub	sp, sp, #128                    // =128
	stp	x30, x19, [sp, #112]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner832
	ldp	x8, x0, [sp, #96]
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldp	q5, q4, [sp, #64]
	str	x8, [x19, #96]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	stp	q5, q4, [x19, #64]
	ldp	x30, x19, [sp, #112]            // 16-byte Folded Reload
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end189:
	.size	mclb_mulUnit13, .Lfunc_end189-mclb_mulUnit13
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
.Lfunc_end190:
	.size	mclb_mulUnitAdd13, .Lfunc_end190-mclb_mulUnitAdd13
                                        // -- End function
	.globl	mclb_mul13                      // -- Begin function mclb_mul13
	.p2align	2
	.type	mclb_mul13,@function
mclb_mul13:                             // @mclb_mul13
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1536                   // =1536
	mov	x20, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #1424                   // =1424
	mov	x0, x20
	mov	x21, x2
	bl	mulUnit_inner832
	ldr	x9, [sp, #1528]
	ldr	x8, [sp, #1520]
	ldr	x1, [x21, #8]
	ldr	x27, [sp, #1488]
	ldr	x28, [sp, #1480]
	stp	x8, x9, [sp, #56]               // 16-byte Folded Spill
	ldr	x9, [sp, #1512]
	ldr	x8, [sp, #1504]
	ldr	x29, [sp, #1472]
	ldr	x22, [sp, #1464]
	ldr	x23, [sp, #1456]
	stp	x8, x9, [sp, #40]               // 16-byte Folded Spill
	ldr	x8, [sp, #1496]
	ldr	x24, [sp, #1448]
	ldr	x25, [sp, #1440]
	ldr	x26, [sp, #1432]
	str	x8, [sp, #32]                   // 8-byte Folded Spill
	ldr	x8, [sp, #1424]
	mov	x0, x20
	str	x8, [x19]
	add	x8, sp, #1312                   // =1312
	bl	mulUnit_inner832
	ldr	x17, [sp, #1312]
	ldr	x16, [sp, #1320]
	ldr	x3, [sp, #1328]
	ldr	x2, [sp, #1336]
	ldr	x0, [sp, #1344]
	adds	x17, x17, x26
	ldr	x18, [sp, #1352]
	adcs	x25, x16, x25
	ldr	x15, [sp, #1360]
	adcs	x16, x3, x24
	ldr	x14, [sp, #1368]
	adcs	x23, x2, x23
	str	x16, [sp, #24]                  // 8-byte Folded Spill
	adcs	x16, x0, x22
	adcs	x26, x18, x29
	adcs	x28, x15, x28
	ldr	x13, [sp, #1376]
	adcs	x27, x14, x27
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	ldr	x12, [sp, #1384]
	ldr	x11, [sp, #1392]
	ldr	x10, [sp, #1400]
	adcs	x29, x13, x14
	ldr	x13, [sp, #40]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1408]
	ldr	x8, [sp, #1416]
	ldr	x1, [x21, #16]
	adcs	x14, x12, x13
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	mov	x0, x20
	str	x16, [sp, #16]                  // 8-byte Folded Spill
	str	x17, [x19, #8]
	adcs	x11, x11, x12
	stp	x14, x11, [sp, #40]             // 16-byte Folded Spill
	ldr	x11, [sp, #56]                  // 8-byte Folded Reload
	adcs	x24, x10, x11
	ldr	x10, [sp, #64]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	str	x8, [sp, #32]                   // 8-byte Folded Spill
	add	x8, sp, #1200                   // =1200
	str	x9, [sp, #56]                   // 8-byte Folded Spill
	bl	mulUnit_inner832
	ldr	x17, [sp, #1200]
	ldr	x16, [sp, #1208]
	ldr	x4, [sp, #24]                   // 8-byte Folded Reload
	ldr	x3, [sp, #1216]
	adds	x17, x17, x25
	ldr	x2, [sp, #1224]
	adcs	x25, x16, x4
	adcs	x16, x3, x23
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	ldr	x16, [sp, #16]                  // 8-byte Folded Reload
	ldr	x0, [sp, #1232]
	ldr	x18, [sp, #1240]
	ldr	x15, [sp, #1248]
	ldr	x14, [sp, #1256]
	adcs	x16, x2, x16
	adcs	x26, x0, x26
	adcs	x28, x18, x28
	adcs	x27, x15, x27
	ldr	x13, [sp, #1264]
	adcs	x29, x14, x29
	ldr	x14, [sp, #40]                  // 8-byte Folded Reload
	ldr	x12, [sp, #1272]
	ldr	x11, [sp, #1280]
	ldr	x10, [sp, #1288]
	adcs	x15, x13, x14
	ldr	x13, [sp, #48]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1296]
	ldr	x8, [sp, #1304]
	ldr	x1, [x21, #24]
	adcs	x12, x12, x13
	adcs	x24, x11, x24
	ldr	x11, [sp, #56]                  // 8-byte Folded Reload
	mov	x0, x20
	mov	x22, x21
	str	x12, [sp, #24]                  // 8-byte Folded Spill
	adcs	x23, x10, x11
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	str	x17, [x19, #16]
	mov	x21, x20
	str	x20, [sp, #72]                  // 8-byte Folded Spill
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x16, x8, [sp, #8]               // 16-byte Folded Spill
	add	x8, sp, #1088                   // =1088
	stp	x9, x15, [sp, #32]              // 16-byte Folded Spill
	bl	mulUnit_inner832
	ldr	x17, [sp, #1088]
	ldr	x16, [sp, #1096]
	ldr	x4, [sp, #64]                   // 8-byte Folded Reload
	ldr	x3, [sp, #1104]
	adds	x17, x17, x25
	ldr	x2, [sp, #1112]
	adcs	x25, x16, x4
	ldr	x16, [sp, #8]                   // 8-byte Folded Reload
	ldr	x0, [sp, #1120]
	ldr	x18, [sp, #1128]
	ldr	x15, [sp, #1136]
	adcs	x16, x3, x16
	adcs	x26, x2, x26
	adcs	x28, x0, x28
	adcs	x27, x18, x27
	ldr	x14, [sp, #1144]
	adcs	x29, x15, x29
	ldr	x15, [sp, #40]                  // 8-byte Folded Reload
	ldr	x13, [sp, #1152]
	ldr	x12, [sp, #1160]
	ldr	x11, [sp, #1168]
	adcs	x14, x14, x15
	str	x14, [sp, #64]                  // 8-byte Folded Spill
	ldr	x14, [sp, #24]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1176]
	ldr	x9, [sp, #1184]
	mov	x20, x22
	adcs	x13, x13, x14
	adcs	x24, x12, x24
	adcs	x23, x11, x23
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	ldr	x1, [x22, #32]
	ldr	x8, [sp, #1192]
	mov	x0, x21
	adcs	x22, x10, x11
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	stp	x16, x13, [sp, #48]             // 16-byte Folded Spill
	str	x17, [x19, #24]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	add	x8, sp, #976                    // =976
	bl	mulUnit_inner832
	ldr	x17, [sp, #976]
	ldr	x16, [sp, #984]
	ldr	x4, [sp, #48]                   // 8-byte Folded Reload
	ldr	x3, [sp, #992]
	ldr	x2, [sp, #1000]
	adds	x17, x17, x25
	ldr	x0, [sp, #1008]
	adcs	x25, x16, x4
	ldr	x18, [sp, #1016]
	adcs	x16, x3, x26
	ldr	x15, [sp, #1024]
	ldr	x1, [x20, #40]
	mov	x21, x20
	str	x16, [sp, #48]                  // 8-byte Folded Spill
	ldp	x16, x20, [sp, #64]             // 16-byte Folded Reload
	adcs	x28, x2, x28
	adcs	x27, x0, x27
	adcs	x29, x18, x29
	adcs	x15, x15, x16
	ldr	x14, [sp, #1032]
	str	x15, [sp, #16]                  // 8-byte Folded Spill
	ldr	x15, [sp, #56]                  // 8-byte Folded Reload
	ldr	x13, [sp, #1040]
	ldr	x12, [sp, #1048]
	ldr	x11, [sp, #1056]
	adcs	x14, x14, x15
	adcs	x24, x13, x24
	adcs	x23, x12, x23
	ldr	x10, [sp, #1064]
	adcs	x18, x11, x22
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1072]
	ldr	x8, [sp, #1080]
	mov	x0, x20
	adcs	x26, x10, x11
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	str	x14, [sp, #56]                  // 8-byte Folded Spill
	str	x17, [x19, #32]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x18, x8, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #864                    // =864
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	bl	mulUnit_inner832
	ldr	x17, [sp, #864]
	ldr	x16, [sp, #872]
	ldr	x4, [sp, #48]                   // 8-byte Folded Reload
	ldr	x3, [sp, #880]
	adds	x17, x17, x25
	ldr	x2, [sp, #888]
	adcs	x25, x16, x4
	ldr	x0, [sp, #896]
	adcs	x16, x3, x28
	ldr	x18, [sp, #904]
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	ldr	x16, [sp, #16]                  // 8-byte Folded Reload
	adcs	x27, x2, x27
	adcs	x29, x0, x29
	ldr	x15, [sp, #912]
	adcs	x16, x18, x16
	str	x16, [sp, #16]                  // 8-byte Folded Spill
	ldr	x16, [sp, #56]                  // 8-byte Folded Reload
	ldr	x14, [sp, #920]
	ldr	x13, [sp, #928]
	ldr	x12, [sp, #936]
	adcs	x15, x15, x16
	adcs	x24, x14, x24
	adcs	x23, x13, x23
	ldr	x13, [sp, #24]                  // 8-byte Folded Reload
	ldr	x11, [sp, #944]
	ldr	x10, [sp, #952]
	ldr	x9, [sp, #960]
	adcs	x12, x12, x13
	adcs	x26, x11, x26
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x8, [sp, #968]
	ldr	x1, [x21, #48]
	mov	x0, x20
	adcs	x28, x10, x11
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	mov	x22, x21
	str	x15, [sp, #56]                  // 8-byte Folded Spill
	str	x17, [x19, #40]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x12, x8, [sp, #24]              // 16-byte Folded Spill
	add	x8, sp, #752                    // =752
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	mov	x21, x20
	bl	mulUnit_inner832
	ldr	x17, [sp, #752]
	ldr	x16, [sp, #760]
	ldr	x4, [sp, #64]                   // 8-byte Folded Reload
	ldr	x3, [sp, #768]
	adds	x17, x17, x25
	ldr	x2, [sp, #776]
	adcs	x25, x16, x4
	adcs	x16, x3, x27
	ldr	x0, [sp, #784]
	str	x16, [sp, #48]                  // 8-byte Folded Spill
	ldr	x16, [sp, #16]                  // 8-byte Folded Reload
	adcs	x29, x2, x29
	ldr	x18, [sp, #792]
	ldr	x15, [sp, #800]
	adcs	x16, x0, x16
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	ldr	x16, [sp, #56]                  // 8-byte Folded Reload
	ldr	x14, [sp, #808]
	ldr	x13, [sp, #816]
	ldr	x12, [sp, #824]
	adcs	x16, x18, x16
	adcs	x24, x15, x24
	adcs	x23, x14, x23
	ldr	x14, [sp, #24]                  // 8-byte Folded Reload
	ldr	x11, [sp, #832]
	mov	x20, x22
	ldr	x1, [x22, #56]
	adcs	x22, x13, x14
	adcs	x26, x12, x26
	ldr	x10, [sp, #840]
	adcs	x28, x11, x28
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x9, [sp, #848]
	ldr	x8, [sp, #856]
	mov	x0, x21
	adcs	x27, x10, x11
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	str	x16, [sp, #56]                  // 8-byte Folded Spill
	str	x17, [x19, #48]
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	add	x8, sp, #640                    // =640
	bl	mulUnit_inner832
	ldr	x17, [sp, #640]
	ldr	x16, [sp, #648]
	ldr	x4, [sp, #48]                   // 8-byte Folded Reload
	ldr	x3, [sp, #656]
	adds	x17, x17, x25
	ldr	x2, [sp, #664]
	adcs	x25, x16, x4
	adcs	x16, x3, x29
	str	x16, [sp, #48]                  // 8-byte Folded Spill
	ldr	x16, [sp, #64]                  // 8-byte Folded Reload
	ldr	x0, [sp, #672]
	ldr	x18, [sp, #680]
	ldr	x15, [sp, #688]
	adcs	x16, x2, x16
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	ldr	x16, [sp, #56]                  // 8-byte Folded Reload
	ldr	x14, [sp, #696]
	ldr	x13, [sp, #704]
	ldr	x12, [sp, #712]
	adcs	x16, x0, x16
	adcs	x24, x18, x24
	ldr	x11, [sp, #720]
	adcs	x23, x15, x23
	adcs	x22, x14, x22
	adcs	x26, x13, x26
	adcs	x28, x12, x28
	ldr	x10, [sp, #728]
	adcs	x27, x11, x27
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x9, [sp, #736]
	ldr	x8, [sp, #744]
	ldr	x1, [x20, #64]
	adcs	x29, x10, x11
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	mov	x21, x20
	ldr	x20, [sp, #72]                  // 8-byte Folded Reload
	str	x16, [sp, #56]                  // 8-byte Folded Spill
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	add	x8, sp, #528                    // =528
	mov	x0, x20
	str	x17, [x19, #56]
	bl	mulUnit_inner832
	ldr	x17, [sp, #528]
	ldr	x16, [sp, #536]
	ldr	x4, [sp, #48]                   // 8-byte Folded Reload
	ldr	x3, [sp, #544]
	adds	x17, x17, x25
	ldr	x2, [sp, #552]
	adcs	x25, x16, x4
	ldr	x16, [sp, #64]                  // 8-byte Folded Reload
	ldr	x0, [sp, #560]
	ldr	x18, [sp, #568]
	ldr	x15, [sp, #576]
	adcs	x16, x3, x16
	str	x16, [sp, #64]                  // 8-byte Folded Spill
	ldr	x16, [sp, #56]                  // 8-byte Folded Reload
	ldr	x14, [sp, #584]
	ldr	x13, [sp, #592]
	ldr	x12, [sp, #600]
	adcs	x16, x2, x16
	adcs	x24, x0, x24
	adcs	x23, x18, x23
	ldr	x11, [sp, #608]
	adcs	x15, x15, x22
	adcs	x26, x14, x26
	adcs	x28, x13, x28
	adcs	x27, x12, x27
	ldr	x10, [sp, #616]
	adcs	x29, x11, x29
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x9, [sp, #624]
	ldr	x8, [sp, #632]
	ldr	x1, [x21, #72]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #48]             // 16-byte Folded Spill
	ldr	x10, [sp, #32]                  // 8-byte Folded Reload
	mov	x0, x20
	str	x17, [x19, #64]
	mov	x22, x20
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x15, x8, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #416                    // =416
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #416]
	ldr	x4, [sp, #64]                   // 8-byte Folded Reload
	ldr	x3, [sp, #432]
	ldp	x2, x0, [sp, #440]
	adds	x17, x17, x25
	adcs	x25, x16, x4
	ldr	x16, [sp, #56]                  // 8-byte Folded Reload
	ldp	x18, x15, [sp, #456]
	ldp	x14, x13, [sp, #472]
	ldp	x12, x11, [sp, #488]
	adcs	x16, x3, x16
	str	x16, [sp, #40]                  // 8-byte Folded Spill
	ldr	x16, [sp, #16]                  // 8-byte Folded Reload
	adcs	x24, x2, x24
	adcs	x23, x0, x23
	ldp	x10, x9, [sp, #504]
	adcs	x16, x18, x16
	adcs	x26, x15, x26
	adcs	x28, x14, x28
	adcs	x27, x13, x27
	adcs	x29, x12, x29
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x8, [sp, #520]
	ldr	x1, [x21, #80]
	mov	x0, x22
	adcs	x11, x11, x12
	stp	x11, x16, [sp, #56]             // 16-byte Folded Spill
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	mov	x20, x21
	str	x17, [x19, #72]
	mov	x21, x22
	adcs	x10, x10, x11
	str	x10, [sp, #48]                  // 8-byte Folded Spill
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #24]               // 16-byte Folded Spill
	add	x8, sp, #304                    // =304
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #304]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldp	x3, x2, [sp, #320]
	ldp	x0, x18, [sp, #336]
	adds	x17, x17, x25
	adcs	x25, x16, x4
	ldr	x16, [sp, #64]                  // 8-byte Folded Reload
	ldp	x15, x14, [sp, #352]
	adcs	x24, x3, x24
	adcs	x23, x2, x23
	ldp	x13, x12, [sp, #368]
	adcs	x22, x0, x16
	adcs	x26, x18, x26
	adcs	x28, x15, x28
	adcs	x27, x14, x27
	adcs	x29, x13, x29
	ldr	x13, [sp, #56]                  // 8-byte Folded Reload
	ldp	x11, x10, [sp, #384]
	ldp	x9, x8, [sp, #400]
	ldr	x1, [x20, #88]
	adcs	x12, x12, x13
	str	x12, [sp, #16]                  // 8-byte Folded Spill
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	mov	x0, x21
	str	x17, [x19, #80]
	adcs	x18, x11, x12
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	adcs	x10, x10, x11
	str	x10, [sp, #64]                  // 8-byte Folded Spill
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #192                    // =192
	stp	x18, x9, [sp, #48]              // 16-byte Folded Spill
	bl	mulUnit_inner832
	ldp	x0, x18, [sp, #192]
	ldp	x3, x2, [sp, #208]
	ldp	x17, x16, [sp, #224]
	ldp	x15, x14, [sp, #240]
	adds	x0, x0, x25
	adcs	x24, x18, x24
	adcs	x23, x3, x23
	adcs	x22, x2, x22
	adcs	x25, x17, x26
	adcs	x26, x16, x28
	adcs	x27, x15, x27
	ldp	x13, x12, [sp, #256]
	adcs	x28, x14, x29
	ldr	x14, [sp, #16]                  // 8-byte Folded Reload
	ldr	x1, [x20, #96]
	ldp	x11, x10, [sp, #272]
	ldp	x9, x8, [sp, #288]
	adcs	x20, x13, x14
	ldr	x13, [sp, #48]                  // 8-byte Folded Reload
	str	x0, [x19, #88]
	mov	x0, x21
	adcs	x29, x12, x13
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x18, x11, x12
	ldr	x11, [sp, #56]                  // 8-byte Folded Reload
	adcs	x10, x10, x11
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #40]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x18, x8, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #80                     // =80
	str	x9, [sp, #64]                   // 8-byte Folded Spill
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #80]
	ldp	x0, x18, [sp, #96]
	ldp	x2, x1, [sp, #112]
	ldp	x15, x14, [sp, #128]
	adds	x17, x17, x24
	adcs	x16, x16, x23
	adcs	x0, x0, x22
	ldp	x9, x8, [sp, #176]
	ldp	x11, x10, [sp, #160]
	ldp	x13, x12, [sp, #144]
	stp	x17, x16, [x19, #96]
	adcs	x16, x18, x25
	adcs	x17, x2, x26
	stp	x0, x16, [x19, #112]
	adcs	x16, x1, x27
	adcs	x15, x15, x28
	adcs	x14, x14, x20
	stp	x15, x14, [x19, #144]
	ldr	x14, [sp, #48]                  // 8-byte Folded Reload
	adcs	x13, x13, x29
	stp	x17, x16, [x19, #128]
	adcs	x12, x12, x14
	ldr	x14, [sp, #32]                  // 8-byte Folded Reload
	stp	x13, x12, [x19, #160]
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x11, x11, x14
	adcs	x10, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x11, x10, [x19, #176]
	adcs	x9, x9, x12
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #192]
	add	sp, sp, #1536                   // =1536
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end191:
	.size	mclb_mul13, .Lfunc_end191-mclb_mul13
                                        // -- End function
	.globl	mclb_sqr13                      // -- Begin function mclb_sqr13
	.p2align	2
	.type	mclb_sqr13,@function
mclb_sqr13:                             // @mclb_sqr13
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #1504                   // =1504
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #1392                   // =1392
	mov	x0, x20
	bl	mulUnit_inner832
	ldr	x9, [sp, #1496]
	ldr	x8, [sp, #1488]
	ldr	x1, [x20, #8]
	ldr	x25, [sp, #1464]
	ldr	x26, [sp, #1456]
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	ldr	x9, [sp, #1480]
	ldr	x8, [sp, #1472]
	ldr	x27, [sp, #1448]
	ldr	x28, [sp, #1440]
	ldr	x29, [sp, #1432]
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	ldr	x8, [sp, #1392]
	ldr	x21, [sp, #1424]
	ldr	x22, [sp, #1416]
	ldr	x23, [sp, #1408]
	ldr	x24, [sp, #1400]
	str	x8, [x19]
	add	x8, sp, #1280                   // =1280
	mov	x0, x20
	bl	mulUnit_inner832
	ldr	x17, [sp, #1280]
	ldr	x16, [sp, #1288]
	ldr	x3, [sp, #1296]
	ldr	x2, [sp, #1304]
	ldr	x0, [sp, #1312]
	adds	x17, x17, x24
	ldr	x18, [sp, #1320]
	adcs	x23, x16, x23
	ldr	x15, [sp, #1328]
	adcs	x16, x3, x22
	ldr	x14, [sp, #1336]
	adcs	x21, x2, x21
	ldr	x13, [sp, #1344]
	adcs	x24, x0, x29
	adcs	x28, x18, x28
	adcs	x27, x15, x27
	adcs	x26, x14, x26
	ldr	x12, [sp, #1352]
	adcs	x25, x13, x25
	ldr	x13, [sp, #16]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1360]
	ldr	x10, [sp, #1368]
	ldr	x9, [sp, #1376]
	adcs	x29, x12, x13
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldr	x8, [sp, #1384]
	ldr	x1, [x20, #16]
	mov	x0, x20
	adcs	x22, x11, x12
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	str	x17, [x19, #8]
	adcs	x18, x10, x11
	ldr	x10, [sp, #40]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x16, x8, [sp, #8]               // 16-byte Folded Spill
	add	x8, sp, #1168                   // =1168
	stp	x9, x18, [sp, #24]              // 16-byte Folded Spill
	bl	mulUnit_inner832
	ldr	x17, [sp, #1168]
	ldr	x16, [sp, #1176]
	ldr	x4, [sp, #8]                    // 8-byte Folded Reload
	ldr	x3, [sp, #1184]
	ldr	x2, [sp, #1192]
	ldr	x0, [sp, #1200]
	adds	x17, x17, x23
	ldr	x18, [sp, #1208]
	adcs	x23, x16, x4
	ldr	x15, [sp, #1216]
	adcs	x16, x3, x21
	ldr	x14, [sp, #1224]
	adcs	x24, x2, x24
	ldr	x13, [sp, #1232]
	adcs	x28, x0, x28
	ldr	x12, [sp, #1240]
	adcs	x27, x18, x27
	adcs	x26, x15, x26
	adcs	x25, x14, x25
	adcs	x29, x13, x29
	ldr	x11, [sp, #1248]
	adcs	x22, x12, x22
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1256]
	ldr	x9, [sp, #1264]
	ldr	x8, [sp, #1272]
	adcs	x21, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #24]
	mov	x0, x20
	str	x17, [x19, #16]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #1056                   // =1056
	bl	mulUnit_inner832
	ldr	x17, [sp, #1056]
	ldr	x16, [sp, #1064]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #1072]
	ldr	x2, [sp, #1080]
	ldr	x0, [sp, #1088]
	adds	x17, x17, x23
	ldr	x18, [sp, #1096]
	adcs	x23, x16, x4
	ldr	x15, [sp, #1104]
	adcs	x16, x3, x24
	ldr	x14, [sp, #1112]
	adcs	x28, x2, x28
	ldr	x13, [sp, #1120]
	adcs	x27, x0, x27
	ldr	x12, [sp, #1128]
	adcs	x26, x18, x26
	adcs	x25, x15, x25
	adcs	x29, x14, x29
	adcs	x22, x13, x22
	ldr	x11, [sp, #1136]
	adcs	x21, x12, x21
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1144]
	ldr	x9, [sp, #1152]
	ldr	x8, [sp, #1160]
	adcs	x24, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #32]
	mov	x0, x20
	str	x17, [x19, #24]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #944                    // =944
	bl	mulUnit_inner832
	ldr	x17, [sp, #944]
	ldr	x16, [sp, #952]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #960]
	ldr	x2, [sp, #968]
	ldr	x0, [sp, #976]
	adds	x17, x17, x23
	ldr	x18, [sp, #984]
	adcs	x23, x16, x4
	ldr	x15, [sp, #992]
	adcs	x16, x3, x28
	ldr	x14, [sp, #1000]
	adcs	x27, x2, x27
	ldr	x13, [sp, #1008]
	adcs	x26, x0, x26
	ldr	x12, [sp, #1016]
	adcs	x25, x18, x25
	adcs	x29, x15, x29
	adcs	x22, x14, x22
	adcs	x21, x13, x21
	ldr	x11, [sp, #1024]
	adcs	x24, x12, x24
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1032]
	ldr	x9, [sp, #1040]
	ldr	x8, [sp, #1048]
	adcs	x28, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #40]
	mov	x0, x20
	str	x17, [x19, #32]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #832                    // =832
	bl	mulUnit_inner832
	ldr	x17, [sp, #832]
	ldr	x16, [sp, #840]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #848]
	ldr	x2, [sp, #856]
	ldr	x0, [sp, #864]
	adds	x17, x17, x23
	ldr	x18, [sp, #872]
	adcs	x23, x16, x4
	ldr	x15, [sp, #880]
	adcs	x16, x3, x27
	ldr	x14, [sp, #888]
	adcs	x26, x2, x26
	ldr	x13, [sp, #896]
	adcs	x25, x0, x25
	ldr	x12, [sp, #904]
	adcs	x29, x18, x29
	adcs	x22, x15, x22
	adcs	x21, x14, x21
	adcs	x24, x13, x24
	ldr	x11, [sp, #912]
	adcs	x28, x12, x28
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #920]
	ldr	x9, [sp, #928]
	ldr	x8, [sp, #936]
	adcs	x27, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #48]
	mov	x0, x20
	str	x17, [x19, #40]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #720                    // =720
	bl	mulUnit_inner832
	ldr	x17, [sp, #720]
	ldr	x16, [sp, #728]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #736]
	ldr	x2, [sp, #744]
	ldr	x0, [sp, #752]
	adds	x17, x17, x23
	ldr	x18, [sp, #760]
	adcs	x23, x16, x4
	ldr	x15, [sp, #768]
	adcs	x16, x3, x26
	ldr	x14, [sp, #776]
	adcs	x25, x2, x25
	ldr	x13, [sp, #784]
	adcs	x29, x0, x29
	ldr	x12, [sp, #792]
	adcs	x22, x18, x22
	adcs	x21, x15, x21
	adcs	x24, x14, x24
	adcs	x28, x13, x28
	ldr	x11, [sp, #800]
	adcs	x27, x12, x27
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #808]
	ldr	x9, [sp, #816]
	ldr	x8, [sp, #824]
	adcs	x26, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #56]
	mov	x0, x20
	str	x17, [x19, #48]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #608                    // =608
	bl	mulUnit_inner832
	ldr	x17, [sp, #608]
	ldr	x16, [sp, #616]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #624]
	ldr	x2, [sp, #632]
	ldr	x0, [sp, #640]
	adds	x17, x17, x23
	ldr	x18, [sp, #648]
	adcs	x23, x16, x4
	ldr	x15, [sp, #656]
	adcs	x16, x3, x25
	ldr	x14, [sp, #664]
	adcs	x29, x2, x29
	ldr	x13, [sp, #672]
	adcs	x22, x0, x22
	ldr	x12, [sp, #680]
	adcs	x21, x18, x21
	adcs	x24, x15, x24
	adcs	x28, x14, x28
	adcs	x27, x13, x27
	ldr	x11, [sp, #688]
	adcs	x26, x12, x26
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #696]
	ldr	x9, [sp, #704]
	ldr	x8, [sp, #712]
	adcs	x25, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #64]
	mov	x0, x20
	str	x17, [x19, #56]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #496                    // =496
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #496]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldr	x3, [sp, #512]
	ldr	x2, [sp, #520]
	ldr	x0, [sp, #528]
	adds	x17, x17, x23
	ldr	x18, [sp, #536]
	adcs	x23, x16, x4
	ldr	x15, [sp, #544]
	adcs	x16, x3, x29
	ldr	x14, [sp, #552]
	adcs	x22, x2, x22
	ldr	x13, [sp, #560]
	adcs	x21, x0, x21
	ldr	x12, [sp, #568]
	adcs	x24, x18, x24
	adcs	x28, x15, x28
	adcs	x27, x14, x27
	adcs	x26, x13, x26
	ldr	x11, [sp, #576]
	adcs	x25, x12, x25
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #584]
	ldr	x9, [sp, #592]
	ldr	x8, [sp, #600]
	adcs	x29, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	ldr	x1, [x20, #72]
	mov	x0, x20
	str	x17, [x19, #64]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #384                    // =384
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #384]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldp	x3, x2, [sp, #400]
	ldp	x0, x18, [sp, #416]
	adds	x17, x17, x23
	adcs	x23, x16, x4
	ldp	x15, x14, [sp, #432]
	adcs	x16, x3, x22
	adcs	x21, x2, x21
	ldp	x13, x12, [sp, #448]
	adcs	x24, x0, x24
	adcs	x28, x18, x28
	adcs	x27, x15, x27
	adcs	x26, x14, x26
	adcs	x25, x13, x25
	ldp	x11, x10, [sp, #464]
	adcs	x29, x12, x29
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x8, [sp, #480]
	ldr	x1, [x20, #80]
	mov	x0, x20
	adcs	x22, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	str	x17, [x19, #72]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #16]               // 16-byte Folded Spill
	add	x8, sp, #272                    // =272
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #272]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldp	x3, x2, [sp, #288]
	ldp	x0, x18, [sp, #304]
	adds	x17, x17, x23
	adcs	x23, x16, x4
	ldp	x15, x14, [sp, #320]
	adcs	x16, x3, x21
	adcs	x24, x2, x24
	ldp	x13, x12, [sp, #336]
	adcs	x28, x0, x28
	adcs	x27, x18, x27
	adcs	x26, x15, x26
	adcs	x25, x14, x25
	adcs	x29, x13, x29
	ldp	x11, x10, [sp, #352]
	adcs	x22, x12, x22
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x8, [sp, #368]
	ldr	x1, [x20, #88]
	mov	x0, x20
	adcs	x21, x11, x12
	ldr	x11, [sp, #24]                  // 8-byte Folded Reload
	str	x17, [x19, #80]
	adcs	x10, x10, x11
	stp	x10, x16, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #16]                  // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #8]                // 16-byte Folded Spill
	add	x8, sp, #160                    // =160
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #160]
	ldr	x4, [sp, #40]                   // 8-byte Folded Reload
	ldp	x3, x2, [sp, #176]
	ldp	x0, x18, [sp, #192]
	adds	x17, x17, x23
	adcs	x23, x16, x4
	ldp	x15, x14, [sp, #208]
	adcs	x24, x3, x24
	adcs	x28, x2, x28
	ldp	x13, x12, [sp, #224]
	adcs	x27, x0, x27
	adcs	x26, x18, x26
	adcs	x25, x15, x25
	adcs	x29, x14, x29
	adcs	x22, x13, x22
	ldp	x11, x10, [sp, #240]
	adcs	x21, x12, x21
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x8, [sp, #256]
	ldr	x1, [x20, #96]
	mov	x0, x20
	adcs	x18, x11, x12
	ldr	x11, [sp, #16]                  // 8-byte Folded Reload
	str	x17, [x19, #88]
	adcs	x10, x10, x11
	stp	x10, x18, [sp, #16]             // 16-byte Folded Spill
	ldr	x10, [sp, #8]                   // 8-byte Folded Reload
	adcs	x9, x9, x10
	adcs	x8, x8, xzr
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	add	x8, sp, #48                     // =48
	bl	mulUnit_inner832
	ldp	x17, x16, [sp, #48]
	ldp	x0, x18, [sp, #64]
	ldp	x2, x1, [sp, #80]
	ldp	x15, x14, [sp, #96]
	adds	x17, x17, x23
	adcs	x16, x16, x24
	adcs	x0, x0, x28
	ldp	x9, x8, [sp, #144]
	ldp	x11, x10, [sp, #128]
	ldp	x13, x12, [sp, #112]
	stp	x17, x16, [x19, #96]
	adcs	x16, x18, x27
	adcs	x17, x2, x26
	stp	x0, x16, [x19, #112]
	adcs	x16, x1, x25
	adcs	x15, x15, x29
	adcs	x14, x14, x22
	stp	x15, x14, [x19, #144]
	ldr	x14, [sp, #24]                  // 8-byte Folded Reload
	adcs	x13, x13, x21
	stp	x17, x16, [x19, #128]
	adcs	x12, x12, x14
	ldr	x14, [sp, #16]                  // 8-byte Folded Reload
	stp	x13, x12, [x19, #160]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x11, x11, x14
	adcs	x10, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	stp	x11, x10, [x19, #176]
	adcs	x9, x9, x12
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #192]
	add	sp, sp, #1504                   // =1504
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end192:
	.size	mclb_sqr13, .Lfunc_end192-mclb_sqr13
                                        // -- End function
	.globl	mulUnit_inner896                // -- Begin function mulUnit_inner896
	.p2align	2
	.type	mulUnit_inner896,@function
mulUnit_inner896:                       // @mulUnit_inner896
// %bb.0:
	str	x29, [sp, #-96]!                // 8-byte Folded Spill
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	mul	x5, x9, x1
	umulh	x9, x9, x1
	umulh	x6, x10, x1
	mul	x10, x10, x1
	mul	x7, x11, x1
	adds	x9, x9, x10
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	umulh	x11, x11, x1
	mul	x19, x12, x1
	adcs	x10, x6, x7
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	ldp	x17, x18, [x0, #64]
	ldp	x2, x3, [x0, #80]
	ldp	x4, x0, [x0, #96]
	umulh	x12, x12, x1
	mul	x20, x13, x1
	stp	x5, x9, [x8]
	adcs	x9, x11, x19
	umulh	x13, x13, x1
	mul	x21, x14, x1
	adcs	x11, x12, x20
	umulh	x14, x14, x1
	mul	x22, x15, x1
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x21
	umulh	x15, x15, x1
	mul	x23, x16, x1
	adcs	x10, x14, x22
	umulh	x16, x16, x1
	mul	x24, x17, x1
	stp	x11, x9, [x8, #32]
	adcs	x9, x15, x23
	umulh	x17, x17, x1
	mul	x25, x18, x1
	adcs	x11, x16, x24
	umulh	x18, x18, x1
	mul	x26, x2, x1
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x25
	umulh	x2, x2, x1
	mul	x27, x3, x1
	adcs	x10, x18, x26
	umulh	x3, x3, x1
	mul	x28, x4, x1
	stp	x11, x9, [x8, #64]
	adcs	x9, x2, x27
	umulh	x4, x4, x1
	mul	x29, x0, x1
	adcs	x11, x3, x28
	umulh	x0, x0, x1
	stp	x10, x9, [x8, #80]
	adcs	x9, x4, x29
	adcs	x10, x0, xzr
	stp	x11, x9, [x8, #96]
	str	x10, [x8, #112]
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldr	x29, [sp], #96                  // 8-byte Folded Reload
	ret
.Lfunc_end193:
	.size	mulUnit_inner896, .Lfunc_end193-mulUnit_inner896
                                        // -- End function
	.globl	mclb_mulUnit14                  // -- Begin function mclb_mulUnit14
	.p2align	2
	.type	mclb_mulUnit14,@function
mclb_mulUnit14:                         // @mclb_mulUnit14
// %bb.0:
	sub	sp, sp, #144                    // =144
	stp	x30, x19, [sp, #128]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner896
	ldp	x8, x0, [sp, #104]
	ldr	x9, [sp, #96]
	ldp	q1, q0, [sp]
	ldp	q3, q2, [sp, #32]
	ldp	q5, q4, [sp, #64]
	stp	x9, x8, [x19, #96]
	stp	q1, q0, [x19]
	stp	q3, q2, [x19, #32]
	stp	q5, q4, [x19, #64]
	ldp	x30, x19, [sp, #128]            // 16-byte Folded Reload
	add	sp, sp, #144                    // =144
	ret
.Lfunc_end194:
	.size	mclb_mulUnit14, .Lfunc_end194-mclb_mulUnit14
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
.Lfunc_end195:
	.size	mclb_mulUnitAdd14, .Lfunc_end195-mclb_mulUnitAdd14
                                        // -- End function
	.globl	mclb_mul14                      // -- Begin function mclb_mul14
	.p2align	2
	.type	mclb_mul14,@function
mclb_mul14:                             // @mclb_mul14
// %bb.0:
	sub	sp, sp, #496                    // =496
	stp	x29, x30, [sp, #400]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #416]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #432]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #448]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #464]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #480]            // 16-byte Folded Spill
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	add	x22, x1, #56                    // =56
	add	x23, x2, #56                    // =56
	add	x24, x0, #112                   // =112
	bl	mclb_mul7
	mov	x0, x24
	mov	x1, x22
	mov	x2, x23
	bl	mclb_mul7
	ldp	x14, x17, [x21, #48]
	ldp	x4, x3, [x21]
	ldp	x16, x15, [x21, #64]
	ldp	x2, x1, [x21, #16]
	ldp	x13, x11, [x21, #80]
	ldp	x0, x18, [x21, #32]
	adds	x17, x4, x17
	ldp	x25, x26, [x21, #96]
	adcs	x16, x3, x16
	adcs	x15, x2, x15
	adcs	x13, x1, x13
	ldp	x12, x10, [x20, #96]
	ldp	x6, x5, [x20, #80]
	ldp	x27, x7, [x20, #64]
	ldp	x29, x28, [x20, #48]
	ldp	x8, x30, [x20, #32]
	ldp	x21, x9, [x20, #16]
	ldp	x20, x22, [x20]
	adcs	x24, x0, x11
	adcs	x25, x18, x25
	adcs	x26, x14, x26
	stp	x13, x15, [sp, #128]            // 16-byte Folded Spill
	stp	x15, x13, [sp, #248]
	adcs	x13, xzr, xzr
	stp	x16, x17, [sp, #144]            // 16-byte Folded Spill
	stp	x17, x16, [sp, #232]
	adds	x16, x20, x28
	adcs	x17, x22, x27
	adcs	x21, x21, x7
	adcs	x22, x9, x6
	adcs	x23, x8, x5
	adcs	x27, x30, x12
	adcs	x28, x29, x10
	mvn	x11, x24
	adcs	x9, xzr, xzr
	orn	x11, x11, x26
	orn	x14, x13, x25
	orn	x15, x13, x26
	mvn	x8, x23
	cmp	x13, #0                         // =0
	orr	x11, x11, x14
	orn	x8, x8, x28
	orn	x10, x9, x27
	cset	w13, ne
	cmp	x15, #0                         // =0
	orr	x8, x8, x10
	csel	w10, wzr, w13, eq
	cmp	x11, #0                         // =0
	orn	x12, x9, x28
	csel	w20, wzr, w10, eq
	cmp	x9, #0                          // =0
	cset	w9, ne
	cmp	x12, #0                         // =0
	csel	w9, wzr, w9, eq
	cmp	x8, #0                          // =0
	add	x0, sp, #288                    // =288
	add	x1, sp, #232                    // =232
	add	x2, sp, #176                    // =176
	stp	x24, x25, [sp, #264]
	str	x26, [sp, #280]
	stp	x17, x16, [sp, #104]            // 16-byte Folded Spill
	stp	x16, x17, [sp, #176]
	stp	x21, x22, [sp, #192]
	stp	x23, x27, [sp, #208]
	csel	w29, wzr, w9, eq
	str	x28, [sp, #224]
	bl	mclb_mul7
	ldr	x8, [sp, #304]
	ldr	x9, [sp, #296]
	cmp	w20, #0                         // =0
	mov	w11, w20
	str	x8, [sp, #120]                  // 8-byte Folded Spill
	ldr	x8, [sp, #288]
	csel	x7, x21, xzr, ne
	csel	x16, x28, xzr, ne
	csel	x13, x27, xzr, ne
	stp	x8, x9, [sp, #160]              // 16-byte Folded Spill
	ldr	x8, [sp, #104]                  // 8-byte Folded Reload
	csel	x14, x23, xzr, ne
	csel	x17, x22, xzr, ne
	ldr	x4, [sp, #344]
	csel	x20, x8, xzr, ne
	ldr	x8, [sp, #112]                  // 8-byte Folded Reload
	ldp	x3, x2, [sp, #352]
	ldp	x1, x0, [sp, #368]
	ldp	x18, x15, [sp, #384]
	csel	x21, x8, xzr, ne
	ldr	x8, [sp, #128]                  // 8-byte Folded Reload
	cmp	w29, #0                         // =0
	csel	x23, x25, xzr, ne
	csel	x22, x26, xzr, ne
	csel	x25, x8, xzr, ne
	ldr	x8, [sp, #136]                  // 8-byte Folded Reload
	csel	x24, x24, xzr, ne
	ldp	x6, x5, [x19, #32]
	ldp	x10, x9, [x19, #96]
	csel	x26, x8, xzr, ne
	ldr	x8, [sp, #144]                  // 8-byte Folded Reload
	stp	x9, x10, [sp, #56]              // 16-byte Folded Spill
	csel	x27, x8, xzr, ne
	ldr	x8, [sp, #152]                  // 8-byte Folded Reload
	csel	x28, x8, xzr, ne
	adds	x21, x28, x21
	adcs	x20, x27, x20
	adcs	x7, x26, x7
	adcs	x25, x25, x17
	adcs	x24, x24, x14
	adcs	x23, x23, x13
	adcs	x22, x22, x16
	adcs	x8, xzr, xzr
	tst	w11, w29
	cinc	x8, x8, ne
	adds	x11, x21, x4
	str	x11, [sp, #48]                  // 8-byte Folded Spill
	adcs	x11, x20, x3
	adcs	x2, x7, x2
	adcs	x1, x25, x1
	ldp	x30, x26, [x19]
	stp	x1, x2, [sp, #24]               // 16-byte Folded Spill
	ldp	x2, x1, [x19, #112]
	adcs	x0, x24, x0
	adcs	x18, x23, x18
	ldp	x28, x27, [x19, #16]
	str	x11, [sp, #40]                  // 8-byte Folded Spill
	ldp	x17, x11, [x19, #128]
	adcs	x4, x22, x15
	adcs	x3, x8, xzr
	ldp	x16, x13, [x19, #144]
	adds	x22, x30, x2
	adcs	x26, x26, x1
	ldp	x12, x14, [x19, #160]
	ldp	x23, x24, [x19, #48]
	adcs	x28, x28, x17
	adcs	x27, x27, x11
	adcs	x6, x6, x16
	adcs	x5, x5, x13
	str	x12, [sp, #152]                 // 8-byte Folded Spill
	stp	x13, x16, [sp, #128]            // 16-byte Folded Spill
	adcs	x23, x23, x12
	ldp	x12, x13, [x19, #64]
	ldp	x7, x21, [x19, #176]
	ldp	x30, x29, [x19, #80]
	ldp	x20, x25, [x19, #192]
	stp	x18, x0, [sp, #8]               // 16-byte Folded Spill
	adcs	x18, x24, x14
	stp	x2, x11, [sp, #88]              // 16-byte Folded Spill
	ldp	x11, x8, [x19, #208]
	adcs	x0, x12, x7
	str	x1, [sp, #80]                   // 8-byte Folded Spill
	adcs	x1, x13, x21
	adcs	x2, x30, x20
	str	x14, [sp, #72]                  // 8-byte Folded Spill
	adcs	x14, x29, x25
	adcs	x15, x10, x11
	str	x8, [sp, #144]                  // 8-byte Folded Spill
	adcs	x16, x9, x8
	ldr	x8, [sp, #160]                  // 8-byte Folded Reload
	str	x17, [sp, #112]                 // 8-byte Folded Spill
	adcs	x17, xzr, xzr
	str	x11, [sp, #104]                 // 8-byte Folded Spill
	subs	x22, x8, x22
	ldr	x8, [sp, #168]                  // 8-byte Folded Reload
	ldp	x10, x11, [sp, #328]
	sbcs	x26, x8, x26
	ldr	x8, [sp, #120]                  // 8-byte Folded Reload
	sbcs	x28, x8, x28
	ldp	x8, x9, [sp, #312]
	sbcs	x8, x8, x27
	sbcs	x9, x9, x6
	sbcs	x10, x10, x5
	ldr	x5, [sp, #48]                   // 8-byte Folded Reload
	sbcs	x11, x11, x23
	sbcs	x18, x5, x18
	ldr	x5, [sp, #40]                   // 8-byte Folded Reload
	sbcs	x0, x5, x0
	ldr	x5, [sp, #32]                   // 8-byte Folded Reload
	sbcs	x1, x5, x1
	ldr	x5, [sp, #24]                   // 8-byte Folded Reload
	sbcs	x2, x5, x2
	ldr	x5, [sp, #16]                   // 8-byte Folded Reload
	sbcs	x14, x5, x14
	ldr	x5, [sp, #8]                    // 8-byte Folded Reload
	sbcs	x15, x5, x15
	sbcs	x16, x4, x16
	sbcs	x17, x3, x17
	adds	x3, x24, x22
	adcs	x12, x12, x26
	adcs	x13, x13, x28
	adcs	x8, x30, x8
	stp	x13, x8, [x19, #72]
	ldr	x8, [sp, #64]                   // 8-byte Folded Reload
	adcs	x9, x29, x9
	stp	x3, x12, [x19, #56]
	ldp	x24, x23, [sp, #448]            // 16-byte Folded Reload
	adcs	x8, x8, x10
	ldr	x10, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x8, [x19, #88]
	ldp	x9, x8, [sp, #80]               // 16-byte Folded Reload
	ldp	x28, x27, [sp, #416]            // 16-byte Folded Reload
	adcs	x10, x10, x11
	ldp	x29, x30, [sp, #400]            // 16-byte Folded Reload
	adcs	x8, x8, x18
	stp	x10, x8, [x19, #104]
	ldr	x8, [sp, #112]                  // 8-byte Folded Reload
	adcs	x9, x9, x0
	ldr	x10, [sp, #96]                  // 8-byte Folded Reload
	adcs	x8, x8, x1
	stp	x9, x8, [x19, #120]
	ldp	x9, x8, [sp, #128]              // 16-byte Folded Reload
	adcs	x10, x10, x2
	adcs	x8, x8, x14
	stp	x10, x8, [x19, #136]
	ldr	x8, [sp, #152]                  // 8-byte Folded Reload
	ldr	x10, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x15
	adcs	x8, x8, x16
	adcs	x10, x10, x17
	stp	x9, x8, [x19, #152]
	adcs	x8, x7, xzr
	stp	x10, x8, [x19, #168]
	adcs	x8, x21, xzr
	adcs	x9, x20, xzr
	stp	x8, x9, [x19, #184]
	ldr	x9, [sp, #104]                  // 8-byte Folded Reload
	adcs	x8, x25, xzr
	ldp	x22, x21, [sp, #464]            // 16-byte Folded Reload
	ldp	x26, x25, [sp, #432]            // 16-byte Folded Reload
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #200]
	ldr	x8, [sp, #144]                  // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [x19, #216]
	ldp	x20, x19, [sp, #480]            // 16-byte Folded Reload
	add	sp, sp, #496                    // =496
	ret
.Lfunc_end196:
	.size	mclb_mul14, .Lfunc_end196-mclb_mul14
                                        // -- End function
	.globl	mclb_sqr14                      // -- Begin function mclb_sqr14
	.p2align	2
	.type	mclb_sqr14,@function
mclb_sqr14:                             // @mclb_sqr14
// %bb.0:
	sub	sp, sp, #480                    // =480
	mov	x2, x1
	stp	x29, x30, [sp, #384]            // 16-byte Folded Spill
	stp	x28, x27, [sp, #400]            // 16-byte Folded Spill
	stp	x26, x25, [sp, #416]            // 16-byte Folded Spill
	stp	x24, x23, [sp, #432]            // 16-byte Folded Spill
	stp	x22, x21, [sp, #448]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #464]            // 16-byte Folded Spill
	mov	x20, x1
	mov	x19, x0
	add	x21, x1, #56                    // =56
	add	x22, x0, #112                   // =112
	bl	mclb_mul7
	mov	x0, x22
	mov	x1, x21
	mov	x2, x21
	bl	mclb_mul7
	ldp	x15, x14, [x20, #48]
	ldp	x17, x16, [x20]
	ldp	x13, x12, [x20, #64]
	ldp	x0, x18, [x20, #16]
	ldp	x11, x10, [x20, #80]
	ldp	x9, x8, [x20, #96]
	ldp	x2, x1, [x20, #32]
	adds	x20, x17, x14
	adcs	x21, x16, x13
	adcs	x22, x0, x12
	adcs	x24, x18, x11
	adcs	x23, x2, x10
	adcs	x25, x1, x9
	adcs	x26, x15, x8
	mvn	x9, x23
	adcs	x8, xzr, xzr
	orn	x9, x9, x26
	orn	x10, x8, x25
	orn	x11, x8, x26
	cmp	x8, #0                          // =0
	orr	x8, x9, x10
	cset	w9, ne
	cmp	x11, #0                         // =0
	csel	w9, wzr, w9, eq
	cmp	x8, #0                          // =0
	add	x0, sp, #272                    // =272
	add	x1, sp, #216                    // =216
	add	x2, sp, #160                    // =160
	stp	x20, x21, [sp, #216]
	stp	x20, x21, [sp, #160]
	stp	x22, x24, [sp, #232]
	stp	x22, x24, [sp, #176]
	stp	x23, x25, [sp, #248]
	stp	x23, x25, [sp, #192]
	str	x26, [sp, #264]
	csel	w27, wzr, w9, eq
	str	x26, [sp, #208]
	bl	mclb_mul7
	ldr	x4, [sp, #328]
	ldp	x3, x2, [sp, #336]
	cmp	w27, #0                         // =0
	ldp	x1, x0, [sp, #352]
	csel	x20, x20, xzr, ne
	csel	x21, x21, xzr, ne
	csel	x22, x22, xzr, ne
	csel	x24, x24, xzr, ne
	csel	x23, x23, xzr, ne
	csel	x25, x25, xzr, ne
	csel	x26, x26, xzr, ne
	add	x27, x27, x26, lsr #63
	extr	x26, x26, x25, #63
	extr	x25, x25, x23, #63
	extr	x23, x23, x24, #63
	extr	x24, x24, x22, #63
	extr	x22, x22, x21, #63
	extr	x21, x21, x20, #63
	adds	x16, x4, x20, lsl #1
	ldp	x18, x17, [sp, #368]
	str	x16, [sp, #48]                  // 8-byte Folded Spill
	adcs	x16, x21, x3
	adcs	x2, x22, x2
	adcs	x1, x24, x1
	ldp	x30, x29, [x19]
	stp	x1, x2, [sp, #24]               // 16-byte Folded Spill
	ldp	x2, x1, [x19, #112]
	adcs	x0, x23, x0
	adcs	x18, x25, x18
	ldp	x28, x7, [x19, #16]
	str	x16, [sp, #40]                  // 8-byte Folded Spill
	ldp	x3, x16, [x19, #128]
	adcs	x4, x26, x17
	adcs	x26, x27, xzr
	ldp	x6, x5, [x19, #32]
	ldp	x15, x13, [x19, #144]
	adds	x27, x30, x2
	adcs	x29, x29, x1
	ldp	x12, x14, [x19, #160]
	ldp	x23, x25, [x19, #48]
	adcs	x28, x28, x3
	adcs	x7, x7, x16
	adcs	x6, x6, x15
	adcs	x5, x5, x13
	ldr	x8, [sp, #272]
	str	x12, [sp, #144]                 // 8-byte Folded Spill
	stp	x13, x15, [sp, #120]            // 16-byte Folded Spill
	adcs	x23, x23, x12
	ldp	x12, x13, [x19, #64]
	ldp	x20, x22, [x19, #176]
	str	x3, [sp, #112]                  // 8-byte Folded Spill
	ldp	x3, x30, [x19, #80]
	ldp	x21, x24, [x19, #192]
	stp	x18, x0, [sp, #8]               // 16-byte Folded Spill
	adcs	x18, x25, x14
	str	x8, [sp, #152]                  // 8-byte Folded Spill
	ldp	x9, x8, [x19, #96]
	ldp	x15, x17, [x19, #208]
	adcs	x0, x12, x20
	str	x1, [sp, #80]                   // 8-byte Folded Spill
	adcs	x1, x13, x22
	stp	x2, x16, [sp, #88]              // 16-byte Folded Spill
	adcs	x2, x3, x21
	str	x14, [sp, #72]                  // 8-byte Folded Spill
	adcs	x14, x30, x24
	str	x15, [sp, #104]                 // 8-byte Folded Spill
	adcs	x15, x9, x15
	stp	x8, x9, [sp, #56]               // 16-byte Folded Spill
	adcs	x16, x8, x17
	ldr	x8, [sp, #152]                  // 8-byte Folded Reload
	ldp	x11, x10, [sp, #280]
	str	x17, [sp, #136]                 // 8-byte Folded Spill
	adcs	x17, xzr, xzr
	subs	x27, x8, x27
	ldp	x8, x9, [sp, #296]
	sbcs	x29, x11, x29
	sbcs	x28, x10, x28
	ldp	x10, x11, [sp, #312]
	sbcs	x8, x8, x7
	sbcs	x9, x9, x6
	sbcs	x10, x10, x5
	ldr	x5, [sp, #48]                   // 8-byte Folded Reload
	sbcs	x11, x11, x23
	sbcs	x18, x5, x18
	ldr	x5, [sp, #40]                   // 8-byte Folded Reload
	sbcs	x0, x5, x0
	ldr	x5, [sp, #32]                   // 8-byte Folded Reload
	sbcs	x1, x5, x1
	ldr	x5, [sp, #24]                   // 8-byte Folded Reload
	sbcs	x2, x5, x2
	ldr	x5, [sp, #16]                   // 8-byte Folded Reload
	sbcs	x14, x5, x14
	ldr	x5, [sp, #8]                    // 8-byte Folded Reload
	sbcs	x15, x5, x15
	sbcs	x16, x4, x16
	sbcs	x17, x26, x17
	adds	x4, x25, x27
	adcs	x12, x12, x29
	adcs	x13, x13, x28
	adcs	x8, x3, x8
	stp	x13, x8, [x19, #72]
	ldr	x8, [sp, #64]                   // 8-byte Folded Reload
	adcs	x9, x30, x9
	stp	x4, x12, [x19, #56]
	ldp	x26, x25, [sp, #416]            // 16-byte Folded Reload
	adcs	x8, x8, x10
	ldr	x10, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x8, [x19, #88]
	ldp	x9, x8, [sp, #80]               // 16-byte Folded Reload
	ldp	x28, x27, [sp, #400]            // 16-byte Folded Reload
	adcs	x10, x10, x11
	ldp	x29, x30, [sp, #384]            // 16-byte Folded Reload
	adcs	x8, x8, x18
	stp	x10, x8, [x19, #104]
	ldr	x8, [sp, #112]                  // 8-byte Folded Reload
	adcs	x9, x9, x0
	ldr	x10, [sp, #96]                  // 8-byte Folded Reload
	adcs	x8, x8, x1
	stp	x9, x8, [x19, #120]
	ldp	x9, x8, [sp, #120]              // 16-byte Folded Reload
	adcs	x10, x10, x2
	adcs	x8, x8, x14
	stp	x10, x8, [x19, #136]
	ldr	x8, [sp, #144]                  // 8-byte Folded Reload
	ldr	x10, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x15
	adcs	x8, x8, x16
	adcs	x10, x10, x17
	stp	x9, x8, [x19, #152]
	adcs	x8, x20, xzr
	stp	x10, x8, [x19, #168]
	adcs	x8, x22, xzr
	adcs	x9, x21, xzr
	stp	x8, x9, [x19, #184]
	ldr	x9, [sp, #104]                  // 8-byte Folded Reload
	adcs	x8, x24, xzr
	ldp	x22, x21, [sp, #448]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #432]            // 16-byte Folded Reload
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #200]
	ldr	x8, [sp, #136]                  // 8-byte Folded Reload
	adcs	x8, x8, xzr
	str	x8, [x19, #216]
	ldp	x20, x19, [sp, #464]            // 16-byte Folded Reload
	add	sp, sp, #480                    // =480
	ret
.Lfunc_end197:
	.size	mclb_sqr14, .Lfunc_end197-mclb_sqr14
                                        // -- End function
	.globl	mulUnit_inner960                // -- Begin function mulUnit_inner960
	.p2align	2
	.type	mulUnit_inner960,@function
mulUnit_inner960:                       // @mulUnit_inner960
// %bb.0:
	sub	sp, sp, #112                    // =112
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	ldp	x17, x18, [x0, #64]
	ldp	x2, x3, [x0, #80]
	ldp	x4, x5, [x0, #96]
	ldr	x0, [x0, #112]
	mul	x6, x9, x1
	str	x6, [sp, #8]                    // 8-byte Folded Spill
	stp	x29, x30, [sp, #16]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             // 16-byte Folded Spill
	umulh	x9, x9, x1
	umulh	x7, x10, x1
	mul	x10, x10, x1
	mul	x19, x11, x1
	umulh	x6, x11, x1
	mul	x20, x12, x1
	umulh	x12, x12, x1
	mul	x21, x13, x1
	umulh	x13, x13, x1
	mul	x22, x14, x1
	umulh	x14, x14, x1
	mul	x23, x15, x1
	umulh	x15, x15, x1
	mul	x24, x16, x1
	umulh	x16, x16, x1
	mul	x25, x17, x1
	umulh	x17, x17, x1
	mul	x26, x18, x1
	umulh	x18, x18, x1
	mul	x27, x2, x1
	umulh	x2, x2, x1
	mul	x28, x3, x1
	umulh	x3, x3, x1
	mul	x29, x4, x1
	umulh	x4, x4, x1
	mul	x30, x5, x1
	umulh	x5, x5, x1
	mul	x11, x0, x1
	umulh	x0, x0, x1
	ldr	x1, [sp, #8]                    // 8-byte Folded Reload
	adds	x9, x9, x10
	adcs	x10, x7, x19
	stp	x1, x9, [x8]
	adcs	x9, x6, x20
	adcs	x12, x12, x21
	stp	x10, x9, [x8, #16]
	adcs	x9, x13, x22
	adcs	x10, x14, x23
	stp	x12, x9, [x8, #32]
	adcs	x9, x15, x24
	adcs	x12, x16, x25
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x26
	adcs	x10, x18, x27
	stp	x12, x9, [x8, #64]
	adcs	x9, x2, x28
	adcs	x12, x3, x29
	stp	x10, x9, [x8, #80]
	adcs	x9, x4, x30
	adcs	x10, x5, x11
	stp	x12, x9, [x8, #96]
	adcs	x9, x0, xzr
	stp	x10, x9, [x8, #112]
	ldp	x20, x19, [sp, #96]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #16]             // 16-byte Folded Reload
	add	sp, sp, #112                    // =112
	ret
.Lfunc_end198:
	.size	mulUnit_inner960, .Lfunc_end198-mulUnit_inner960
                                        // -- End function
	.globl	mclb_mulUnit15                  // -- Begin function mclb_mulUnit15
	.p2align	2
	.type	mclb_mulUnit15,@function
mclb_mulUnit15:                         // @mclb_mulUnit15
// %bb.0:
	sub	sp, sp, #144                    // =144
	stp	x30, x19, [sp, #128]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner960
	ldp	x8, x0, [sp, #112]
	ldp	q5, q0, [sp, #80]
	ldp	q2, q1, [sp]
	ldp	q4, q3, [sp, #32]
	ldr	q6, [sp, #64]
	str	q0, [x19, #96]
	stp	q2, q1, [x19]
	stp	q4, q3, [x19, #32]
	stp	q6, q5, [x19, #64]
	str	x8, [x19, #112]
	ldp	x30, x19, [sp, #128]            // 16-byte Folded Reload
	add	sp, sp, #144                    // =144
	ret
.Lfunc_end199:
	.size	mclb_mulUnit15, .Lfunc_end199-mclb_mulUnit15
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
.Lfunc_end200:
	.size	mclb_mulUnitAdd15, .Lfunc_end200-mclb_mulUnitAdd15
                                        // -- End function
	.globl	mclb_mul15                      // -- Begin function mclb_mul15
	.p2align	2
	.type	mclb_mul15,@function
mclb_mul15:                             // @mclb_mul15
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #2016                   // =2016
	mov	x27, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #1888                   // =1888
	mov	x0, x27
	mov	x29, x2
	bl	mulUnit_inner960
	ldr	x9, [sp, #2008]
	ldr	x8, [sp, #2000]
	ldr	x1, [x29, #8]
	ldr	x22, [sp, #1944]
	ldr	x23, [sp, #1936]
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #1992]
	ldr	x8, [sp, #1984]
	ldr	x24, [sp, #1928]
	ldr	x25, [sp, #1920]
	ldr	x20, [sp, #1912]
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x9, [sp, #1976]
	ldr	x8, [sp, #1968]
	ldr	x21, [sp, #1904]
	ldr	x26, [sp, #1896]
	mov	x0, x27
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldr	x9, [sp, #1960]
	ldr	x8, [sp, #1952]
	stp	x8, x9, [sp, #32]               // 16-byte Folded Spill
	ldr	x8, [sp, #1888]
	str	x8, [x19]
	add	x8, sp, #1760                   // =1760
	bl	mulUnit_inner960
	ldr	x8, [sp, #1760]
	ldr	x9, [sp, #1768]
	ldr	x10, [sp, #1776]
	ldr	x11, [sp, #1784]
	adds	x8, x8, x26
	adcs	x26, x9, x21
	ldr	x9, [sp, #1792]
	adcs	x18, x10, x20
	ldr	x10, [sp, #1800]
	adcs	x25, x11, x25
	ldr	x11, [sp, #1808]
	adcs	x24, x9, x24
	ldr	x9, [sp, #1816]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	adcs	x23, x10, x23
	adcs	x11, x11, x22
	ldr	x10, [sp, #1824]
	adcs	x9, x9, x12
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #16]             // 16-byte Folded Spill
	ldr	x11, [sp, #1832]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	adcs	x28, x10, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1840]
	ldr	x10, [sp, #1848]
	ldr	x1, [x29, #16]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1856]
	mov	x0, x27
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #48]              // 16-byte Folded Spill
	ldr	x9, [sp, #1864]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1872]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #64]             // 16-byte Folded Spill
	ldr	x11, [sp, #1880]
	str	x8, [x19, #8]
	adcs	x9, x9, x12
	str	x9, [sp, #80]                   // 8-byte Folded Spill
	ldr	x9, [sp, #88]                   // 8-byte Folded Reload
	add	x8, sp, #1632                   // =1632
	adcs	x20, x10, x9
	adcs	x21, x11, xzr
	bl	mulUnit_inner960
	ldr	x8, [sp, #1632]
	ldr	x9, [sp, #1640]
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1648]
	adds	x8, x8, x26
	ldr	x11, [sp, #1656]
	adcs	x22, x9, x12
	ldr	x9, [sp, #1664]
	adcs	x25, x10, x25
	ldr	x10, [sp, #1672]
	ldr	x12, [sp, #16]                  // 8-byte Folded Reload
	adcs	x24, x11, x24
	adcs	x23, x9, x23
	ldr	x11, [sp, #1680]
	adcs	x26, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1688]
	ldr	x10, [sp, #1696]
	ldr	x1, [x29, #24]
	adcs	x11, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x28, x9, x28
	str	x11, [sp, #88]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1704]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1712]
	ldr	x10, [sp, #1720]
	mov	x0, x27
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #1728]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1736]
	adcs	x10, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #64]             // 16-byte Folded Spill
	ldr	x10, [sp, #1744]
	adcs	x11, x11, x12
	str	x11, [sp, #80]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1752]
	adcs	x20, x9, x20
	adcs	x21, x10, x21
	str	x8, [x19, #16]
	adcs	x8, x11, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1504                   // =1504
	bl	mulUnit_inner960
	ldr	x8, [sp, #1504]
	ldr	x9, [sp, #1512]
	ldr	x10, [sp, #1520]
	ldr	x11, [sp, #1528]
	adds	x8, x8, x22
	adcs	x22, x9, x25
	ldr	x9, [sp, #1536]
	adcs	x24, x10, x24
	ldr	x10, [sp, #1544]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x23, x11, x23
	ldr	x11, [sp, #1552]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1560]
	adcs	x26, x10, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x18, x11, x28
	ldr	x10, [sp, #1568]
	ldr	x11, [sp, #1576]
	adcs	x28, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1584]
	ldr	x1, [x29, #32]
	mov	x0, x27
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	str	x10, [sp, #56]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1592]
	adcs	x11, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	str	x11, [sp, #64]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1600]
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1608]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	adcs	x18, x11, x20
	adcs	x9, x9, x21
	ldr	x10, [sp, #1616]
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	ldr	x9, [sp, #40]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1624]
	str	x8, [x19, #24]
	mov	x21, x29
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #40]              // 16-byte Folded Spill
	add	x8, sp, #1376                   // =1376
	bl	mulUnit_inner960
	ldr	x8, [sp, #1376]
	ldr	x9, [sp, #1384]
	ldr	x10, [sp, #1392]
	ldr	x11, [sp, #1400]
	adds	x8, x8, x22
	adcs	x22, x9, x24
	ldr	x9, [sp, #1408]
	adcs	x23, x10, x23
	ldr	x10, [sp, #1416]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x24, x11, x25
	ldr	x11, [sp, #1424]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1432]
	adcs	x26, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	adcs	x18, x11, x28
	ldr	x10, [sp, #1440]
	ldr	x11, [sp, #1448]
	adcs	x28, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1456]
	ldr	x1, [x21, #40]
	mov	x0, x27
	adcs	x29, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1464]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x11, [sp, #72]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1472]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #1480]
	adcs	x18, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1488]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #56]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #40]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1496]
	str	x8, [x19, #32]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #40]              // 16-byte Folded Spill
	add	x8, sp, #1248                   // =1248
	bl	mulUnit_inner960
	ldr	x8, [sp, #1248]
	ldr	x9, [sp, #1256]
	ldr	x10, [sp, #1264]
	ldr	x11, [sp, #1272]
	adds	x8, x8, x22
	adcs	x9, x9, x23
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1280]
	adcs	x23, x10, x24
	ldr	x10, [sp, #1288]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x24, x11, x25
	ldr	x11, [sp, #1296]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1304]
	adcs	x26, x10, x12
	ldr	x10, [sp, #1312]
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x18, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1320]
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1328]
	ldr	x10, [sp, #1336]
	ldr	x1, [x21, #48]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1344]
	mov	x0, x27
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1352]
	mov	x22, x21
	mov	x21, x27
	adcs	x10, x10, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	ldr	x10, [sp, #1360]
	adcs	x18, x11, x12
	adcs	x9, x9, x20
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	ldr	x9, [sp, #40]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1368]
	str	x8, [x19, #40]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1120                   // =1120
	bl	mulUnit_inner960
	ldr	x8, [sp, #1120]
	ldr	x11, [sp, #32]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1128]
	ldr	x10, [sp, #1136]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adds	x8, x8, x11
	ldr	x11, [sp, #1144]
	adcs	x18, x9, x23
	ldr	x9, [sp, #1152]
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #24]             // 16-byte Folded Spill
	ldr	x10, [sp, #1160]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1168]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1176]
	adcs	x26, x10, x12
	ldr	x10, [sp, #1184]
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1192]
	adcs	x29, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1200]
	ldr	x10, [sp, #1208]
	ldr	x1, [x22, #56]
	adcs	x18, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1216]
	mov	x0, x21
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #1224]
	adcs	x18, x10, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1232]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #40]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1240]
	str	x8, [x19, #48]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #992                    // =992
	bl	mulUnit_inner960
	ldr	x8, [sp, #992]
	ldp	x12, x11, [sp, #24]             // 16-byte Folded Reload
	ldr	x9, [sp, #1000]
	ldr	x10, [sp, #1008]
	ldr	x1, [x22, #64]
	adds	x8, x8, x11
	ldr	x11, [sp, #1016]
	adcs	x18, x9, x12
	ldr	x9, [sp, #1024]
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #1032]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1040]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1048]
	adcs	x26, x10, x27
	ldr	x10, [sp, #1056]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1064]
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1072]
	ldr	x10, [sp, #1080]
	mov	x0, x21
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1088]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #1096]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1104]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1112]
	str	x8, [x19, #56]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #864                    // =864
	bl	mulUnit_inner960
	ldr	x8, [sp, #864]
	ldp	x12, x11, [sp, #32]             // 16-byte Folded Reload
	ldr	x9, [sp, #872]
	ldr	x10, [sp, #880]
	ldr	x1, [x22, #72]
	adds	x8, x8, x11
	ldr	x11, [sp, #888]
	adcs	x18, x9, x12
	ldr	x9, [sp, #896]
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #904]
	adcs	x24, x11, x25
	ldr	x11, [sp, #912]
	adcs	x25, x9, x26
	ldr	x9, [sp, #920]
	adcs	x26, x10, x27
	ldr	x10, [sp, #928]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #936]
	adcs	x18, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #944]
	ldr	x10, [sp, #952]
	mov	x0, x21
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #960]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #968]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #976]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #984]
	str	x8, [x19, #64]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #736                    // =736
	bl	mulUnit_inner960
	ldr	x8, [sp, #736]
	ldp	x12, x11, [sp, #32]             // 16-byte Folded Reload
	ldr	x9, [sp, #744]
	ldr	x10, [sp, #752]
	ldr	x1, [x22, #80]
	adds	x8, x8, x11
	ldr	x11, [sp, #760]
	adcs	x18, x9, x12
	ldr	x9, [sp, #768]
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #776]
	adcs	x24, x11, x25
	ldr	x11, [sp, #784]
	adcs	x25, x9, x26
	ldr	x9, [sp, #792]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x26, x10, x27
	ldr	x10, [sp, #800]
	adcs	x27, x11, x28
	ldr	x11, [sp, #808]
	adcs	x18, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x28, x10, x29
	ldr	x9, [sp, #816]
	ldr	x10, [sp, #824]
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #832]
	mov	x0, x21
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #840]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #848]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #856]
	str	x8, [x19, #72]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #608                    // =608
	bl	mulUnit_inner960
	ldr	x8, [sp, #608]
	ldp	x12, x11, [sp, #32]             // 16-byte Folded Reload
	ldr	x9, [sp, #616]
	ldr	x10, [sp, #624]
	ldr	x1, [x22, #88]
	adds	x8, x8, x11
	ldr	x11, [sp, #632]
	adcs	x18, x9, x12
	ldr	x9, [sp, #640]
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #648]
	adcs	x24, x11, x25
	ldr	x11, [sp, #656]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x25, x9, x26
	ldr	x9, [sp, #664]
	adcs	x26, x10, x27
	ldr	x10, [sp, #672]
	adcs	x18, x11, x12
	ldr	x11, [sp, #680]
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldr	x9, [sp, #688]
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #696]
	ldr	x11, [sp, #704]
	mov	x0, x21
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #712]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #720]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #728]
	str	x8, [x19, #80]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #480                    // =480
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #480]
	ldp	x12, x11, [sp, #32]             // 16-byte Folded Reload
	ldr	x1, [x22, #96]
	mov	x0, x21
	adds	x8, x8, x11
	ldp	x10, x11, [sp, #496]
	adcs	x18, x9, x12
	ldr	x9, [sp, #512]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x10, x10, x24
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #520]
	adcs	x24, x11, x25
	ldr	x11, [sp, #528]
	adcs	x25, x9, x26
	ldr	x9, [sp, #536]
	adcs	x18, x10, x12
	ldr	x10, [sp, #544]
	adcs	x26, x11, x27
	ldr	x11, [sp, #552]
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldr	x9, [sp, #560]
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #568]
	ldr	x11, [sp, #576]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #584]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #592]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x20
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #600]
	str	x8, [x19, #88]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #352                    // =352
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #352]
	ldp	x12, x11, [sp, #32]             // 16-byte Folded Reload
	ldr	x1, [x22, #104]
	mov	x0, x21
	adds	x8, x8, x11
	ldp	x10, x11, [sp, #368]
	adcs	x9, x9, x12
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x23, x10, x24
	ldp	x9, x10, [sp, #384]
	adcs	x24, x11, x25
	adcs	x9, x9, x12
	str	x9, [sp, #88]                   // 8-byte Folded Spill
	ldp	x11, x9, [sp, #400]
	adcs	x25, x10, x26
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x26, x11, x27
	ldp	x10, x11, [sp, #416]
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldp	x9, x10, [sp, #432]
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x18, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldp	x11, x9, [sp, #448]
	adcs	x10, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	str	x10, [sp, #64]                  // 8-byte Folded Spill
	adcs	x11, x11, x12
	adcs	x9, x9, x20
	str	x11, [sp, #56]                  // 8-byte Folded Spill
	ldp	x10, x11, [sp, #464]
	stp	x9, x18, [sp, #24]              // 16-byte Folded Spill
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	str	x8, [x19, #96]
	adcs	x20, x10, x9
	adcs	x8, x11, xzr
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	add	x8, sp, #224                    // =224
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #224]
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x1, [x22, #112]
	mov	x0, x21
	adds	x8, x8, x11
	ldp	x10, x11, [sp, #240]
	adcs	x23, x9, x23
	adcs	x10, x10, x24
	str	x10, [sp, #40]                  // 8-byte Folded Spill
	ldp	x9, x10, [sp, #256]
	adcs	x24, x11, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	adcs	x18, x9, x25
	ldp	x11, x9, [sp, #272]
	adcs	x25, x10, x26
	adcs	x11, x11, x27
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldp	x10, x11, [sp, #288]
	adcs	x27, x9, x28
	adcs	x18, x10, x29
	ldp	x9, x10, [sp, #304]
	adcs	x29, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #320]
	adcs	x18, x10, x12
	ldr	x10, [sp, #24]                  // 8-byte Folded Reload
	adcs	x10, x11, x10
	stp	x18, x10, [sp, #48]             // 16-byte Folded Spill
	adcs	x20, x9, x20
	ldp	x10, x9, [sp, #336]
	ldr	x11, [sp, #16]                  // 8-byte Folded Reload
	str	x8, [x19, #104]
	add	x8, sp, #96                     // =96
	adcs	x26, x10, x11
	adcs	x28, x9, xzr
	bl	mulUnit_inner960
	ldp	x15, x14, [sp, #96]
	ldr	x3, [sp, #40]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #112]
	ldp	x9, x8, [sp, #208]
	adds	x15, x15, x23
	adcs	x14, x14, x3
	ldp	x11, x10, [sp, #192]
	ldp	x13, x12, [sp, #176]
	ldp	x17, x16, [sp, #160]
	ldp	x2, x1, [sp, #144]
	ldp	x4, x3, [sp, #128]
	stp	x15, x14, [x19, #112]
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	adcs	x0, x0, x24
	adcs	x14, x18, x14
	stp	x0, x14, [x19, #128]
	ldr	x14, [sp, #80]                  // 8-byte Folded Reload
	adcs	x15, x4, x25
	adcs	x14, x3, x14
	stp	x15, x14, [x19, #144]
	ldr	x14, [sp, #72]                  // 8-byte Folded Reload
	adcs	x18, x2, x27
	adcs	x14, x1, x14
	stp	x18, x14, [x19, #160]
	ldr	x14, [sp, #64]                  // 8-byte Folded Reload
	adcs	x15, x17, x29
	adcs	x14, x16, x14
	ldr	x16, [sp, #48]                  // 8-byte Folded Reload
	stp	x15, x14, [x19, #176]
	ldr	x14, [sp, #56]                  // 8-byte Folded Reload
	adcs	x13, x13, x16
	adcs	x12, x12, x14
	adcs	x11, x11, x20
	adcs	x10, x10, x26
	adcs	x9, x9, x28
	adcs	x8, x8, xzr
	stp	x13, x12, [x19, #192]
	stp	x11, x10, [x19, #208]
	stp	x9, x8, [x19, #224]
	add	sp, sp, #2016                   // =2016
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end201:
	.size	mclb_mul15, .Lfunc_end201-mclb_mul15
                                        // -- End function
	.globl	mclb_sqr15                      // -- Begin function mclb_sqr15
	.p2align	2
	.type	mclb_sqr15,@function
mclb_sqr15:                             // @mclb_sqr15
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #2016                   // =2016
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #1888                   // =1888
	mov	x0, x20
	bl	mulUnit_inner960
	ldr	x9, [sp, #2008]
	ldr	x8, [sp, #2000]
	ldr	x1, [x20, #8]
	ldr	x27, [sp, #1960]
	ldr	x28, [sp, #1952]
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #1992]
	ldr	x8, [sp, #1984]
	ldr	x29, [sp, #1944]
	ldr	x21, [sp, #1936]
	ldr	x22, [sp, #1928]
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x9, [sp, #1976]
	ldr	x8, [sp, #1968]
	ldr	x23, [sp, #1920]
	ldr	x24, [sp, #1912]
	ldr	x25, [sp, #1904]
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldr	x8, [sp, #1888]
	ldr	x26, [sp, #1896]
	mov	x0, x20
	str	x8, [x19]
	add	x8, sp, #1760                   // =1760
	bl	mulUnit_inner960
	ldr	x8, [sp, #1760]
	ldr	x9, [sp, #1768]
	ldr	x10, [sp, #1776]
	ldr	x11, [sp, #1784]
	adds	x8, x8, x26
	adcs	x25, x9, x25
	ldr	x9, [sp, #1792]
	adcs	x24, x10, x24
	ldr	x10, [sp, #1800]
	adcs	x23, x11, x23
	ldr	x11, [sp, #1808]
	adcs	x26, x9, x22
	ldr	x9, [sp, #1816]
	adcs	x18, x10, x21
	ldr	x10, [sp, #1824]
	adcs	x29, x11, x29
	ldr	x11, [sp, #1832]
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x28, x9, x28
	adcs	x10, x10, x27
	ldr	x9, [sp, #1840]
	stp	x10, x18, [sp, #32]             // 16-byte Folded Spill
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1848]
	ldr	x11, [sp, #1856]
	ldr	x1, [x20, #16]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #48]              // 16-byte Folded Spill
	ldr	x9, [sp, #1864]
	mov	x0, x20
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1872]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #64]             // 16-byte Folded Spill
	ldr	x11, [sp, #1880]
	str	x8, [x19, #8]
	adcs	x9, x9, x12
	str	x9, [sp, #80]                   // 8-byte Folded Spill
	ldr	x9, [sp, #88]                   // 8-byte Folded Reload
	add	x8, sp, #1632                   // =1632
	adcs	x21, x10, x9
	adcs	x22, x11, xzr
	bl	mulUnit_inner960
	ldr	x8, [sp, #1632]
	ldr	x9, [sp, #1640]
	ldr	x10, [sp, #1648]
	ldr	x11, [sp, #1656]
	adds	x8, x8, x25
	adcs	x24, x9, x24
	ldr	x9, [sp, #1664]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x23, x10, x23
	ldr	x10, [sp, #1672]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1680]
	adcs	x26, x9, x12
	ldr	x9, [sp, #1688]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	adcs	x27, x10, x29
	adcs	x28, x11, x28
	ldr	x10, [sp, #1696]
	adcs	x29, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1704]
	ldr	x9, [sp, #1712]
	ldr	x1, [x20, #24]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1720]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	str	x11, [sp, #56]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1728]
	adcs	x9, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	str	x9, [sp, #64]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1736]
	adcs	x10, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x10, [sp, #72]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1744]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1752]
	adcs	x21, x9, x21
	adcs	x22, x10, x22
	str	x8, [x19, #16]
	adcs	x8, x11, xzr
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1504                   // =1504
	bl	mulUnit_inner960
	ldr	x8, [sp, #1504]
	ldr	x9, [sp, #1512]
	ldr	x10, [sp, #1520]
	ldr	x11, [sp, #1528]
	adds	x8, x8, x24
	adcs	x23, x9, x23
	ldr	x9, [sp, #1536]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1544]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1552]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1560]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1568]
	adcs	x29, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1576]
	ldr	x9, [sp, #1584]
	ldr	x1, [x20, #32]
	adcs	x18, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1592]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	str	x11, [sp, #64]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1600]
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1608]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x10, [sp, #1616]
	adcs	x22, x9, x22
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1624]
	str	x8, [x19, #24]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1376                   // =1376
	bl	mulUnit_inner960
	ldr	x8, [sp, #1376]
	ldr	x9, [sp, #1384]
	ldr	x10, [sp, #1392]
	ldr	x11, [sp, #1400]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1408]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1416]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1424]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1432]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1440]
	adcs	x29, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1448]
	ldr	x9, [sp, #1456]
	ldr	x1, [x20, #40]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1464]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x11, [sp, #72]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1472]
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #1480]
	adcs	x18, x10, x12
	adcs	x22, x11, x22
	adcs	x9, x9, x21
	ldr	x10, [sp, #1488]
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1496]
	str	x8, [x19, #32]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1248                   // =1248
	bl	mulUnit_inner960
	ldr	x8, [sp, #1248]
	ldr	x9, [sp, #1256]
	ldr	x10, [sp, #1264]
	ldr	x11, [sp, #1272]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1280]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1288]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1296]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1304]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1312]
	adcs	x29, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1320]
	ldr	x9, [sp, #1328]
	ldr	x1, [x20, #48]
	adcs	x18, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1336]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1344]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1352]
	adcs	x22, x10, x22
	ldr	x10, [sp, #1360]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1368]
	str	x8, [x19, #40]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1120                   // =1120
	bl	mulUnit_inner960
	ldr	x8, [sp, #1120]
	ldr	x9, [sp, #1128]
	ldr	x10, [sp, #1136]
	ldr	x11, [sp, #1144]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1152]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1160]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1168]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1176]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1184]
	adcs	x29, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1192]
	ldr	x9, [sp, #1200]
	ldr	x1, [x20, #56]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1208]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x22, x9, x22
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1216]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1224]
	ldr	x10, [sp, #1232]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1240]
	str	x8, [x19, #48]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #992                    // =992
	bl	mulUnit_inner960
	ldr	x8, [sp, #992]
	ldr	x9, [sp, #1000]
	ldr	x10, [sp, #1008]
	ldr	x11, [sp, #1016]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1024]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1032]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1040]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1048]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1056]
	adcs	x29, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1064]
	ldr	x9, [sp, #1072]
	ldr	x1, [x20, #64]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x22, x11, x22
	ldr	x10, [sp, #1080]
	ldr	x11, [sp, #1088]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #1096]
	mov	x0, x20
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1104]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #1112]
	str	x8, [x19, #56]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #864                    // =864
	bl	mulUnit_inner960
	ldr	x8, [sp, #864]
	ldr	x9, [sp, #872]
	ldr	x10, [sp, #880]
	ldr	x11, [sp, #888]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #896]
	adcs	x24, x10, x25
	ldr	x10, [sp, #904]
	adcs	x25, x11, x26
	ldr	x11, [sp, #912]
	adcs	x26, x9, x27
	ldr	x9, [sp, #920]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x10, x28
	ldr	x10, [sp, #928]
	adcs	x28, x11, x29
	ldr	x11, [sp, #936]
	adcs	x29, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x22, x10, x22
	ldr	x9, [sp, #944]
	ldr	x10, [sp, #952]
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #960]
	ldr	x1, [x20, #72]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #968]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #976]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #984]
	str	x8, [x19, #64]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #736                    // =736
	bl	mulUnit_inner960
	ldr	x8, [sp, #736]
	ldr	x9, [sp, #744]
	ldr	x10, [sp, #752]
	ldr	x11, [sp, #760]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #768]
	adcs	x24, x10, x25
	ldr	x10, [sp, #776]
	adcs	x25, x11, x26
	ldr	x11, [sp, #784]
	adcs	x26, x9, x27
	ldr	x9, [sp, #792]
	adcs	x27, x10, x28
	ldr	x10, [sp, #800]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x28, x11, x29
	adcs	x22, x9, x22
	ldr	x11, [sp, #808]
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #816]
	ldr	x10, [sp, #824]
	ldr	x1, [x20, #80]
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #832]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #840]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #848]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #856]
	str	x8, [x19, #72]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #608                    // =608
	bl	mulUnit_inner960
	ldr	x8, [sp, #608]
	ldr	x9, [sp, #616]
	ldr	x10, [sp, #624]
	ldr	x11, [sp, #632]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #640]
	adcs	x24, x10, x25
	ldr	x10, [sp, #648]
	adcs	x25, x11, x26
	ldr	x11, [sp, #656]
	adcs	x26, x9, x27
	ldr	x9, [sp, #664]
	adcs	x27, x10, x28
	ldr	x10, [sp, #672]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x22, x11, x22
	adcs	x28, x9, x29
	ldr	x11, [sp, #680]
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #688]
	ldr	x10, [sp, #696]
	ldr	x1, [x20, #88]
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #704]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #712]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #720]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #728]
	str	x8, [x19, #80]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #480                    // =480
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #480]
	ldp	x10, x11, [sp, #496]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x1, [x20, #96]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #512]
	adcs	x24, x10, x25
	ldr	x10, [sp, #520]
	adcs	x25, x11, x26
	ldr	x11, [sp, #528]
	adcs	x26, x9, x27
	ldr	x9, [sp, #536]
	adcs	x22, x10, x22
	ldr	x10, [sp, #544]
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #552]
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #560]
	ldr	x10, [sp, #568]
	mov	x0, x20
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #576]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #584]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #592]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	ldr	x11, [sp, #600]
	str	x8, [x19, #88]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #352                    // =352
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #352]
	ldp	x10, x11, [sp, #368]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x1, [x20, #104]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	adcs	x24, x10, x25
	ldp	x9, x10, [sp, #384]
	adcs	x25, x11, x26
	mov	x0, x20
	adcs	x22, x9, x22
	ldp	x11, x9, [sp, #400]
	adcs	x26, x10, x27
	adcs	x27, x11, x28
	ldp	x10, x11, [sp, #416]
	adcs	x28, x9, x29
	adcs	x29, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldp	x9, x10, [sp, #432]
	adcs	x18, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #32]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #448]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #56]             // 16-byte Folded Spill
	ldp	x10, x11, [sp, #464]
	adcs	x18, x9, x21
	ldr	x9, [sp, #48]                   // 8-byte Folded Reload
	str	x8, [x19, #96]
	adcs	x21, x10, x9
	adcs	x8, x11, xzr
	stp	x8, x18, [sp, #16]              // 16-byte Folded Spill
	add	x8, sp, #224                    // =224
	bl	mulUnit_inner960
	ldp	x8, x9, [sp, #224]
	ldp	x10, x11, [sp, #240]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	ldr	x1, [x20, #112]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	adcs	x24, x10, x25
	ldp	x9, x10, [sp, #256]
	adcs	x22, x11, x22
	mov	x0, x20
	adcs	x18, x9, x26
	ldp	x11, x9, [sp, #272]
	adcs	x26, x10, x27
	adcs	x11, x11, x28
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldp	x10, x11, [sp, #288]
	adcs	x28, x9, x29
	adcs	x18, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x10, [sp, #304]
	adcs	x25, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #320]
	adcs	x27, x10, x12
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	adcs	x18, x11, x12
	adcs	x9, x9, x21
	ldp	x10, x11, [sp, #336]
	stp	x9, x18, [sp, #48]              // 16-byte Folded Spill
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	str	x8, [x19, #104]
	add	x8, sp, #96                     // =96
	adcs	x29, x10, x9
	adcs	x21, x11, xzr
	bl	mulUnit_inner960
	ldp	x15, x14, [sp, #96]
	ldp	x0, x18, [sp, #112]
	ldp	x9, x8, [sp, #208]
	ldp	x11, x10, [sp, #192]
	adds	x15, x15, x23
	adcs	x14, x14, x24
	ldp	x13, x12, [sp, #176]
	ldp	x17, x16, [sp, #160]
	ldp	x2, x1, [sp, #144]
	ldp	x4, x3, [sp, #128]
	stp	x15, x14, [x19, #112]
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	adcs	x0, x0, x22
	adcs	x14, x18, x14
	stp	x0, x14, [x19, #128]
	ldr	x14, [sp, #80]                  // 8-byte Folded Reload
	adcs	x15, x4, x26
	adcs	x14, x3, x14
	stp	x15, x14, [x19, #144]
	ldr	x14, [sp, #72]                  // 8-byte Folded Reload
	adcs	x18, x2, x28
	adcs	x14, x1, x14
	stp	x18, x14, [x19, #160]
	ldr	x14, [sp, #64]                  // 8-byte Folded Reload
	adcs	x15, x17, x25
	adcs	x14, x16, x14
	stp	x15, x14, [x19, #176]
	ldr	x14, [sp, #56]                  // 8-byte Folded Reload
	adcs	x13, x13, x27
	adcs	x12, x12, x14
	ldr	x14, [sp, #48]                  // 8-byte Folded Reload
	stp	x13, x12, [x19, #192]
	adcs	x11, x11, x14
	adcs	x10, x10, x29
	adcs	x9, x9, x21
	adcs	x8, x8, xzr
	stp	x11, x10, [x19, #208]
	stp	x9, x8, [x19, #224]
	add	sp, sp, #2016                   // =2016
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end202:
	.size	mclb_sqr15, .Lfunc_end202-mclb_sqr15
                                        // -- End function
	.globl	mulUnit_inner1024               // -- Begin function mulUnit_inner1024
	.p2align	2
	.type	mulUnit_inner1024,@function
mulUnit_inner1024:                      // @mulUnit_inner1024
// %bb.0:
	sub	sp, sp, #128                    // =128
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	ldp	x17, x18, [x0, #64]
	ldp	x2, x3, [x0, #80]
	ldp	x4, x5, [x0, #96]
	ldp	x6, x0, [x0, #112]
	mul	x7, x9, x1
	stp	x20, x19, [sp, #112]            // 16-byte Folded Spill
	str	x7, [sp, #24]                   // 8-byte Folded Spill
	mul	x20, x11, x1
	umulh	x7, x11, x1
	umulh	x11, x13, x1
	str	x11, [sp, #16]                  // 8-byte Folded Spill
	umulh	x11, x15, x1
	stp	x29, x30, [sp, #32]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #48]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             // 16-byte Folded Spill
	umulh	x9, x9, x1
	umulh	x19, x10, x1
	mul	x10, x10, x1
	mul	x21, x12, x1
	umulh	x12, x12, x1
	mul	x22, x13, x1
	mul	x23, x14, x1
	umulh	x14, x14, x1
	mul	x24, x15, x1
	str	x11, [sp, #8]                   // 8-byte Folded Spill
	mul	x25, x16, x1
	umulh	x16, x16, x1
	mul	x26, x17, x1
	umulh	x17, x17, x1
	mul	x27, x18, x1
	umulh	x18, x18, x1
	mul	x28, x2, x1
	umulh	x2, x2, x1
	mul	x29, x3, x1
	umulh	x3, x3, x1
	mul	x30, x4, x1
	umulh	x4, x4, x1
	mul	x13, x5, x1
	umulh	x5, x5, x1
	mul	x11, x6, x1
	umulh	x6, x6, x1
	mul	x15, x0, x1
	umulh	x0, x0, x1
	ldr	x1, [sp, #24]                   // 8-byte Folded Reload
	adds	x9, x9, x10
	adcs	x10, x19, x20
	stp	x1, x9, [x8]
	adcs	x9, x7, x21
	stp	x10, x9, [x8, #16]
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	adcs	x12, x12, x22
	adcs	x9, x9, x23
	stp	x12, x9, [x8, #32]
	ldr	x9, [sp, #8]                    // 8-byte Folded Reload
	adcs	x10, x14, x24
	adcs	x9, x9, x25
	adcs	x12, x16, x26
	stp	x10, x9, [x8, #48]
	adcs	x9, x17, x27
	adcs	x10, x18, x28
	stp	x12, x9, [x8, #64]
	adcs	x9, x2, x29
	adcs	x12, x3, x30
	stp	x10, x9, [x8, #80]
	adcs	x9, x4, x13
	adcs	x10, x5, x11
	stp	x12, x9, [x8, #96]
	adcs	x9, x6, x15
	stp	x10, x9, [x8, #112]
	adcs	x9, x0, xzr
	str	x9, [x8, #128]
	ldp	x20, x19, [sp, #112]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #32]             // 16-byte Folded Reload
	add	sp, sp, #128                    // =128
	ret
.Lfunc_end203:
	.size	mulUnit_inner1024, .Lfunc_end203-mulUnit_inner1024
                                        // -- End function
	.globl	mclb_mulUnit16                  // -- Begin function mclb_mulUnit16
	.p2align	2
	.type	mclb_mulUnit16,@function
mclb_mulUnit16:                         // @mclb_mulUnit16
// %bb.0:
	sub	sp, sp, #160                    // =160
	stp	x30, x19, [sp, #144]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner1024
	ldp	x8, x0, [sp, #120]
	ldr	x9, [sp, #112]
	ldp	q5, q0, [sp, #80]
	ldp	q2, q1, [sp]
	ldp	q4, q3, [sp, #32]
	ldr	q6, [sp, #64]
	str	q0, [x19, #96]
	stp	q2, q1, [x19]
	stp	q4, q3, [x19, #32]
	stp	q6, q5, [x19, #64]
	stp	x9, x8, [x19, #112]
	ldp	x30, x19, [sp, #144]            // 16-byte Folded Reload
	add	sp, sp, #160                    // =160
	ret
.Lfunc_end204:
	.size	mclb_mulUnit16, .Lfunc_end204-mclb_mulUnit16
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
.Lfunc_end205:
	.size	mclb_mulUnitAdd16, .Lfunc_end205-mclb_mulUnitAdd16
                                        // -- End function
	.globl	mclb_mul16                      // -- Begin function mclb_mul16
	.p2align	2
	.type	mclb_mul16,@function
mclb_mul16:                             // @mclb_mul16
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #496                    // =496
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	add	x22, x1, #64                    // =64
	add	x23, x2, #64                    // =64
	add	x24, x0, #128                   // =128
	bl	mclb_mul8
	mov	x0, x24
	mov	x1, x22
	mov	x2, x23
	bl	mclb_mul8
	ldr	x1, [x21, #40]
	ldr	x12, [x21, #56]
	ldr	d0, [x21, #48]
	ldr	d1, [x21, #32]
	ldr	x2, [x21, #24]
	ldr	d2, [x21, #16]
	mov	v0.d[1], x12
	mov	v1.d[1], x1
	ldr	x8, [x21, #120]
	ldr	x18, [x21, #104]
	ldr	x0, [x21, #88]
	ldr	d3, [x21, #112]
	fmov	x6, d0
	ldr	d0, [x21, #80]
	fmov	x24, d1
	ldr	d1, [x21, #96]
	mov	v2.d[1], x2
	ldr	x5, [x21, #72]
	fmov	x23, d2
	ldr	d2, [x21, #64]
	ldp	x4, x3, [x21]
	mov	v3.d[1], x8
	mov	v1.d[1], x18
	mov	v0.d[1], x0
	ldr	x16, [x20, #24]
	ldr	x15, [x20, #40]
	ldr	x14, [x20, #56]
	fmov	x7, d3
	ldr	d3, [x20, #48]
	fmov	x25, d1
	ldr	d1, [x20, #32]
	fmov	x26, d0
	ldr	d0, [x20, #16]
	mov	v2.d[1], x5
	fmov	x21, d2
	adds	x21, x4, x21
	mov	v3.d[1], x14
	mov	v1.d[1], x15
	mov	v0.d[1], x16
	adcs	x22, x3, x5
	ldp	x11, x10, [x20]
	ldr	x9, [x20, #104]
	ldr	x13, [x20, #88]
	ldr	x17, [x20, #72]
	ldr	d2, [x20, #64]
	fmov	x30, d3
	ldr	d3, [x20, #80]
	fmov	x4, d1
	ldr	d1, [x20, #96]
	fmov	x3, d0
	ldr	d0, [x20, #112]
	ldr	x5, [x20, #120]
	adcs	x20, x23, x26
	adcs	x23, x2, x0
	adcs	x24, x24, x25
	adcs	x1, x1, x18
	adcs	x6, x6, x7
	mov	v2.d[1], x17
	adcs	x29, x12, x8
	fmov	x18, d2
	adcs	x8, xzr, xzr
	stp	x22, x21, [sp, #192]            // 16-byte Folded Spill
	mov	v3.d[1], x13
	stp	x21, x22, [sp, #304]
	adds	x21, x11, x18
	fmov	x2, d3
	adcs	x27, x10, x17
	mov	v1.d[1], x9
	stp	x23, x20, [sp, #176]            // 16-byte Folded Spill
	stp	x20, x23, [sp, #320]
	adcs	x20, x3, x2
	fmov	x0, d1
	adcs	x25, x16, x13
	mov	v0.d[1], x5
	adcs	x22, x4, x0
	fmov	x26, d0
	adcs	x23, x15, x9
	adcs	x26, x30, x26
	stp	x1, x24, [sp, #160]             // 16-byte Folded Spill
	stp	x24, x1, [sp, #336]
	adcs	x24, x14, x5
	adcs	x9, xzr, xzr
	cmp	x8, #0                          // =0
	cset	w8, ne
	csel	w28, wzr, w8, eq
	cmp	x9, #0                          // =0
	cset	w8, ne
	csel	w8, wzr, w8, eq
	add	x0, sp, #368                    // =368
	add	x1, sp, #304                    // =304
	add	x2, sp, #240                    // =240
	str	x6, [sp, #152]                  // 8-byte Folded Spill
	stp	x6, x29, [sp, #352]
	stp	x21, x27, [sp, #240]
	stp	x20, x25, [sp, #256]
	stp	x22, x23, [sp, #272]
	str	w8, [sp, #144]                  // 4-byte Folded Spill
	stp	x26, x24, [sp, #288]
	bl	mclb_mul8
	ldr	w16, [sp, #144]                 // 4-byte Folded Reload
	ldr	x17, [sp, #152]                 // 8-byte Folded Reload
	cmp	w28, #0                         // =0
	csel	x13, x24, xzr, ne
	csel	x2, x26, xzr, ne
	csel	x3, x23, xzr, ne
	csel	x4, x22, xzr, ne
	csel	x5, x25, xzr, ne
	csel	x6, x20, xzr, ne
	csel	x7, x27, xzr, ne
	csel	x20, x21, xzr, ne
	cmp	w16, #0                         // =0
	csel	x22, x17, xzr, ne
	ldr	x17, [sp, #160]                 // 8-byte Folded Reload
	ldr	x9, [sp, #392]
	ldr	x8, [sp, #384]
	mov	w15, w28
	csel	x23, x17, xzr, ne
	ldr	x17, [sp, #168]                 // 8-byte Folded Reload
	csel	x21, x29, xzr, ne
	stp	x8, x9, [sp, #224]              // 16-byte Folded Spill
	ldr	x9, [sp, #376]
	csel	x24, x17, xzr, ne
	ldr	x17, [sp, #176]                 // 8-byte Folded Reload
	ldr	x8, [sp, #368]
	ldp	x14, x1, [sp, #448]
	ldp	x0, x11, [sp, #464]
	csel	x25, x17, xzr, ne
	ldr	x17, [sp, #184]                 // 8-byte Folded Reload
	stp	x8, x9, [sp, #208]              // 16-byte Folded Spill
	ldp	x12, x8, [sp, #432]
	ldp	x10, x9, [sp, #480]
	csel	x26, x17, xzr, ne
	ldr	x17, [sp, #192]                 // 8-byte Folded Reload
	csel	x27, x17, xzr, ne
	ldr	x17, [sp, #200]                 // 8-byte Folded Reload
	csel	x28, x17, xzr, ne
	adds	x20, x28, x20
	adcs	x7, x27, x7
	adcs	x6, x26, x6
	adcs	x5, x25, x5
	adcs	x4, x24, x4
	adcs	x3, x23, x3
	adcs	x2, x22, x2
	adcs	x21, x21, x13
	adcs	x13, xzr, xzr
	tst	w15, w16
	cinc	x30, x13, ne
	adds	x12, x20, x12
	adcs	x18, x7, x8
	adcs	x8, x6, x14
	adcs	x15, x5, x1
	str	x15, [sp, #56]                  // 8-byte Folded Spill
	adcs	x15, x4, x0
	ldp	x29, x22, [x19]
	str	x15, [sp, #48]                  // 8-byte Folded Spill
	ldp	x16, x15, [x19, #128]
	adcs	x11, x3, x11
	adcs	x10, x2, x10
	ldp	x24, x23, [x19, #16]
	stp	x8, x18, [sp, #64]              // 16-byte Folded Spill
	stp	x10, x11, [sp, #32]             // 16-byte Folded Spill
	ldp	x11, x10, [x19, #144]
	adcs	x18, x21, x9
	adcs	x9, x30, xzr
	ldp	x26, x25, [x19, #32]
	ldp	x14, x8, [x19, #160]
	adds	x29, x29, x16
	adcs	x22, x22, x15
	ldp	x28, x27, [x19, #48]
	str	x12, [sp, #80]                  // 8-byte Folded Spill
	ldp	x13, x12, [x19, #176]
	adcs	x24, x24, x11
	adcs	x23, x23, x10
	adcs	x26, x26, x14
	adcs	x25, x25, x8
	stp	x14, x13, [sp, #160]            // 16-byte Folded Spill
	stp	x9, x18, [sp, #16]              // 16-byte Folded Spill
	adcs	x28, x28, x13
	ldp	x30, x13, [x19, #192]
	ldp	x17, x18, [x19, #64]
	stp	x15, x10, [sp, #176]            // 16-byte Folded Spill
	stp	x16, x11, [sp, #144]            // 16-byte Folded Spill
	ldp	x14, x15, [x19, #208]
	ldp	x16, x21, [x19, #80]
	adcs	x27, x27, x12
	stp	x8, x12, [sp, #192]             // 16-byte Folded Spill
	ldp	x11, x10, [x19, #224]
	ldp	x20, x7, [x19, #96]
	adcs	x12, x17, x30
	str	x13, [sp, #104]                 // 8-byte Folded Spill
	adcs	x13, x18, x13
	ldp	x9, x8, [x19, #240]
	stp	x15, x14, [sp, #88]             // 16-byte Folded Spill
	ldp	x6, x5, [x19, #112]
	adcs	x14, x16, x14
	adcs	x15, x21, x15
	adcs	x0, x20, x11
	adcs	x1, x7, x10
	adcs	x2, x6, x9
	stp	x8, x9, [sp, #128]              // 16-byte Folded Spill
	adcs	x3, x5, x8
	ldr	x8, [sp, #208]                  // 8-byte Folded Reload
	adcs	x4, xzr, xzr
	stp	x10, x11, [sp, #112]            // 16-byte Folded Spill
	ldp	x10, x11, [sp, #416]
	subs	x29, x8, x29
	ldr	x8, [sp, #216]                  // 8-byte Folded Reload
	sbcs	x22, x8, x22
	ldr	x8, [sp, #224]                  // 8-byte Folded Reload
	sbcs	x24, x8, x24
	ldr	x8, [sp, #232]                  // 8-byte Folded Reload
	sbcs	x23, x8, x23
	ldp	x8, x9, [sp, #400]
	sbcs	x8, x8, x26
	sbcs	x9, x9, x25
	ldr	x25, [sp, #80]                  // 8-byte Folded Reload
	sbcs	x10, x10, x28
	sbcs	x11, x11, x27
	sbcs	x12, x25, x12
	ldr	x25, [sp, #72]                  // 8-byte Folded Reload
	sbcs	x13, x25, x13
	ldr	x25, [sp, #64]                  // 8-byte Folded Reload
	sbcs	x14, x25, x14
	ldr	x25, [sp, #56]                  // 8-byte Folded Reload
	sbcs	x15, x25, x15
	ldr	x25, [sp, #48]                  // 8-byte Folded Reload
	sbcs	x0, x25, x0
	ldr	x25, [sp, #40]                  // 8-byte Folded Reload
	sbcs	x1, x25, x1
	ldr	x25, [sp, #32]                  // 8-byte Folded Reload
	sbcs	x2, x25, x2
	ldr	x25, [sp, #24]                  // 8-byte Folded Reload
	sbcs	x3, x25, x3
	ldr	x25, [sp, #16]                  // 8-byte Folded Reload
	sbcs	x4, x25, x4
	adds	x17, x17, x29
	adcs	x18, x18, x22
	adcs	x16, x16, x24
	stp	x17, x18, [x19, #64]
	adcs	x17, x21, x23
	adcs	x8, x20, x8
	adcs	x9, x7, x9
	adcs	x10, x6, x10
	stp	x8, x9, [x19, #96]
	adcs	x8, x5, x11
	ldr	x9, [sp, #144]                  // 8-byte Folded Reload
	stp	x10, x8, [x19, #112]
	ldr	x8, [sp, #176]                  // 8-byte Folded Reload
	ldr	x10, [sp, #152]                 // 8-byte Folded Reload
	adcs	x9, x9, x12
	stp	x16, x17, [x19, #80]
	adcs	x8, x8, x13
	stp	x9, x8, [x19, #128]
	ldr	x8, [sp, #184]                  // 8-byte Folded Reload
	adcs	x10, x10, x14
	ldr	x9, [sp, #160]                  // 8-byte Folded Reload
	adcs	x8, x8, x15
	stp	x10, x8, [x19, #144]
	ldr	x8, [sp, #192]                  // 8-byte Folded Reload
	adcs	x9, x9, x0
	ldr	x10, [sp, #168]                 // 8-byte Folded Reload
	adcs	x8, x8, x1
	stp	x9, x8, [x19, #160]
	ldr	x8, [sp, #200]                  // 8-byte Folded Reload
	adcs	x10, x10, x2
	adcs	x8, x8, x3
	stp	x10, x8, [x19, #176]
	ldr	x8, [sp, #104]                  // 8-byte Folded Reload
	adcs	x9, x30, x4
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #192]
	ldp	x9, x8, [sp, #88]               // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #208]
	ldp	x9, x8, [sp, #112]              // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #224]
	ldp	x9, x8, [sp, #128]              // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #240]
	add	sp, sp, #496                    // =496
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end206:
	.size	mclb_mul16, .Lfunc_end206-mclb_mul16
                                        // -- End function
	.globl	mclb_sqr16                      // -- Begin function mclb_sqr16
	.p2align	2
	.type	mclb_sqr16,@function
mclb_sqr16:                             // @mclb_sqr16
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #496                    // =496
	mov	x2, x1
	mov	x20, x1
	mov	x19, x0
	add	x21, x1, #64                    // =64
	add	x22, x0, #128                   // =128
	bl	mclb_mul8
	mov	x0, x22
	mov	x1, x21
	mov	x2, x21
	bl	mclb_mul8
	ldr	x14, [x20, #72]
	ldr	d3, [x20, #64]
	ldp	x12, x11, [x20]
	ldr	x13, [x20, #88]
	ldr	x15, [x20, #24]
	ldr	d2, [x20, #16]
	ldr	d4, [x20, #80]
	ldr	x9, [x20, #104]
	ldr	x16, [x20, #40]
	ldr	d1, [x20, #32]
	ldr	d5, [x20, #96]
	mov	v3.d[1], x14
	fmov	x4, d3
	ldr	x8, [x20, #120]
	ldr	x10, [x20, #56]
	ldr	d0, [x20, #48]
	ldr	d6, [x20, #112]
	mov	v2.d[1], x15
	mov	v4.d[1], x13
	adds	x20, x12, x4
	fmov	x0, d2
	fmov	x3, d4
	adcs	x21, x11, x14
	mov	v1.d[1], x16
	mov	v5.d[1], x9
	adcs	x22, x0, x3
	fmov	x18, d1
	fmov	x2, d5
	adcs	x24, x15, x13
	mov	v0.d[1], x10
	mov	v6.d[1], x8
	adcs	x25, x18, x2
	fmov	x17, d0
	fmov	x1, d6
	adcs	x26, x16, x9
	adcs	x27, x17, x1
	adcs	x28, x10, x8
	adcs	x8, xzr, xzr
	cmp	x8, #0                          // =0
	cset	w8, ne
	add	x0, sp, #368                    // =368
	add	x1, sp, #304                    // =304
	add	x2, sp, #240                    // =240
	stp	x20, x21, [sp, #304]
	stp	x20, x21, [sp, #240]
	stp	x22, x24, [sp, #320]
	stp	x22, x24, [sp, #256]
	stp	x25, x26, [sp, #336]
	stp	x25, x26, [sp, #272]
	stp	x27, x28, [sp, #352]
	csel	w23, wzr, w8, eq
	stp	x27, x28, [sp, #288]
	bl	mclb_mul8
	ldr	x9, [sp, #392]
	ldr	x8, [sp, #384]
	ldp	x11, x15, [sp, #432]
	ldp	x14, x12, [sp, #448]
	cmp	w23, #0                         // =0
	stp	x8, x9, [sp, #224]              // 16-byte Folded Spill
	ldr	x9, [sp, #376]
	ldr	x8, [sp, #368]
	csel	x13, x20, xzr, ne
	csel	x4, x21, xzr, ne
	csel	x20, x22, xzr, ne
	csel	x21, x24, xzr, ne
	csel	x22, x25, xzr, ne
	csel	x24, x26, xzr, ne
	csel	x25, x27, xzr, ne
	csel	x26, x28, xzr, ne
	stp	x8, x9, [sp, #208]              // 16-byte Folded Spill
	ldp	x10, x9, [sp, #464]
	extr	x27, x26, x25, #63
	extr	x25, x25, x24, #63
	extr	x24, x24, x22, #63
	extr	x22, x22, x21, #63
	extr	x21, x21, x20, #63
	extr	x20, x20, x4, #63
	extr	x4, x4, x13, #63
	adds	x11, x11, x13, lsl #1
	adcs	x15, x4, x15
	ldp	x18, x1, [sp, #480]
	adcs	x14, x20, x14
	adcs	x12, x21, x12
	adcs	x10, x22, x10
	ldp	x17, x8, [x19]
	stp	x10, x12, [sp, #48]             // 16-byte Folded Spill
	ldp	x3, x10, [x19, #128]
	adcs	x9, x24, x9
	str	x9, [sp, #40]                   // 8-byte Folded Spill
	adcs	x9, x25, x18
	ldp	x30, x29, [x19, #16]
	add	x23, x23, x26, lsr #63
	str	x9, [sp, #32]                   // 8-byte Folded Spill
	ldp	x12, x9, [x19, #144]
	adcs	x18, x27, x1
	str	x18, [sp, #24]                  // 8-byte Folded Spill
	adcs	x18, x23, xzr
	ldp	x5, x2, [x19, #32]
	stp	x14, x15, [sp, #64]             // 16-byte Folded Spill
	ldp	x15, x14, [x19, #160]
	adds	x23, x17, x3
	adcs	x20, x8, x10
	ldp	x0, x16, [x19, #48]
	str	x11, [sp, #80]                  // 8-byte Folded Spill
	ldp	x13, x11, [x19, #176]
	adcs	x30, x30, x12
	adcs	x8, x29, x9
	adcs	x26, x5, x15
	adcs	x25, x2, x14
	stp	x15, x13, [sp, #160]            // 16-byte Folded Spill
	str	x18, [sp, #16]                  // 8-byte Folded Spill
	adcs	x24, x0, x13
	ldp	x28, x13, [x19, #192]
	ldp	x17, x18, [x19, #64]
	stp	x14, x11, [sp, #192]            // 16-byte Folded Spill
	adcs	x7, x16, x11
	ldp	x14, x15, [x19, #208]
	ldp	x16, x27, [x19, #80]
	stp	x3, x12, [sp, #144]             // 16-byte Folded Spill
	ldp	x1, x11, [x19, #224]
	ldp	x22, x21, [x19, #96]
	adcs	x12, x17, x28
	str	x13, [sp, #104]                 // 8-byte Folded Spill
	adcs	x13, x18, x13
	stp	x10, x9, [sp, #176]             // 16-byte Folded Spill
	ldp	x10, x9, [x19, #240]
	stp	x15, x14, [sp, #88]             // 16-byte Folded Spill
	ldp	x6, x5, [x19, #112]
	adcs	x14, x16, x14
	adcs	x15, x27, x15
	adcs	x0, x22, x1
	stp	x11, x1, [sp, #112]             // 16-byte Folded Spill
	adcs	x1, x21, x11
	adcs	x2, x6, x10
	stp	x9, x10, [sp, #128]             // 16-byte Folded Spill
	adcs	x3, x5, x9
	ldr	x9, [sp, #208]                  // 8-byte Folded Reload
	adcs	x4, xzr, xzr
	ldp	x10, x11, [sp, #416]
	subs	x23, x9, x23
	ldr	x9, [sp, #216]                  // 8-byte Folded Reload
	sbcs	x20, x9, x20
	ldr	x9, [sp, #224]                  // 8-byte Folded Reload
	sbcs	x30, x9, x30
	ldr	x9, [sp, #232]                  // 8-byte Folded Reload
	sbcs	x29, x9, x8
	ldp	x8, x9, [sp, #400]
	sbcs	x8, x8, x26
	sbcs	x9, x9, x25
	sbcs	x10, x10, x24
	sbcs	x11, x11, x7
	ldr	x7, [sp, #80]                   // 8-byte Folded Reload
	sbcs	x12, x7, x12
	ldr	x7, [sp, #72]                   // 8-byte Folded Reload
	sbcs	x13, x7, x13
	ldr	x7, [sp, #64]                   // 8-byte Folded Reload
	sbcs	x14, x7, x14
	ldr	x7, [sp, #56]                   // 8-byte Folded Reload
	sbcs	x15, x7, x15
	ldr	x7, [sp, #48]                   // 8-byte Folded Reload
	sbcs	x0, x7, x0
	ldr	x7, [sp, #40]                   // 8-byte Folded Reload
	sbcs	x1, x7, x1
	ldr	x7, [sp, #32]                   // 8-byte Folded Reload
	sbcs	x2, x7, x2
	ldr	x7, [sp, #24]                   // 8-byte Folded Reload
	sbcs	x3, x7, x3
	ldr	x7, [sp, #16]                   // 8-byte Folded Reload
	sbcs	x4, x7, x4
	adds	x17, x17, x23
	adcs	x18, x18, x20
	adcs	x16, x16, x30
	stp	x17, x18, [x19, #64]
	adcs	x17, x27, x29
	adcs	x8, x22, x8
	adcs	x9, x21, x9
	adcs	x10, x6, x10
	stp	x8, x9, [x19, #96]
	adcs	x8, x5, x11
	ldr	x9, [sp, #144]                  // 8-byte Folded Reload
	stp	x10, x8, [x19, #112]
	ldr	x8, [sp, #176]                  // 8-byte Folded Reload
	ldr	x10, [sp, #152]                 // 8-byte Folded Reload
	adcs	x9, x9, x12
	stp	x16, x17, [x19, #80]
	adcs	x8, x8, x13
	stp	x9, x8, [x19, #128]
	ldr	x8, [sp, #184]                  // 8-byte Folded Reload
	adcs	x10, x10, x14
	ldr	x9, [sp, #160]                  // 8-byte Folded Reload
	adcs	x8, x8, x15
	stp	x10, x8, [x19, #144]
	ldr	x8, [sp, #192]                  // 8-byte Folded Reload
	adcs	x9, x9, x0
	ldr	x10, [sp, #168]                 // 8-byte Folded Reload
	adcs	x8, x8, x1
	stp	x9, x8, [x19, #160]
	ldr	x8, [sp, #200]                  // 8-byte Folded Reload
	adcs	x10, x10, x2
	adcs	x8, x8, x3
	stp	x10, x8, [x19, #176]
	ldr	x8, [sp, #104]                  // 8-byte Folded Reload
	adcs	x9, x28, x4
	adcs	x8, x8, xzr
	stp	x9, x8, [x19, #192]
	ldp	x9, x8, [sp, #88]               // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #208]
	ldp	x9, x8, [sp, #112]              // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #224]
	ldp	x9, x8, [sp, #128]              // 16-byte Folded Reload
	adcs	x8, x8, xzr
	adcs	x9, x9, xzr
	stp	x8, x9, [x19, #240]
	add	sp, sp, #496                    // =496
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end207:
	.size	mclb_sqr16, .Lfunc_end207-mclb_sqr16
                                        // -- End function
	.globl	mulUnit_inner1088               // -- Begin function mulUnit_inner1088
	.p2align	2
	.type	mulUnit_inner1088,@function
mulUnit_inner1088:                      // @mulUnit_inner1088
// %bb.0:
	sub	sp, sp, #144                    // =144
	ldp	x9, x10, [x0]
	ldp	x11, x12, [x0, #16]
	ldp	x13, x14, [x0, #32]
	ldp	x15, x16, [x0, #48]
	ldp	x17, x18, [x0, #64]
	stp	x22, x21, [sp, #112]            // 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            // 16-byte Folded Spill
	ldp	x2, x3, [x0, #80]
	ldp	x4, x5, [x0, #96]
	ldp	x6, x7, [x0, #112]
	ldr	x0, [x0, #128]
	mul	x19, x9, x1
	mul	x21, x11, x1
	umulh	x11, x11, x1
	stp	x11, x19, [sp, #32]             // 16-byte Folded Spill
	umulh	x11, x13, x1
	str	x11, [sp, #24]                  // 8-byte Folded Spill
	umulh	x11, x15, x1
	str	x11, [sp, #16]                  // 8-byte Folded Spill
	umulh	x11, x17, x1
	stp	x29, x30, [sp, #48]             // 16-byte Folded Spill
	stp	x28, x27, [sp, #64]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             // 16-byte Folded Spill
	umulh	x9, x9, x1
	umulh	x20, x10, x1
	mul	x10, x10, x1
	mul	x22, x12, x1
	umulh	x19, x12, x1
	mul	x23, x13, x1
	mul	x24, x14, x1
	umulh	x14, x14, x1
	mul	x25, x15, x1
	mul	x26, x16, x1
	umulh	x16, x16, x1
	mul	x27, x17, x1
	str	x11, [sp, #8]                   // 8-byte Folded Spill
	mul	x28, x18, x1
	umulh	x18, x18, x1
	mul	x29, x2, x1
	umulh	x2, x2, x1
	mul	x30, x3, x1
	umulh	x3, x3, x1
	mul	x11, x4, x1
	umulh	x4, x4, x1
	mul	x17, x5, x1
	umulh	x5, x5, x1
	mul	x12, x6, x1
	umulh	x6, x6, x1
	mul	x15, x7, x1
	umulh	x7, x7, x1
	mul	x13, x0, x1
	umulh	x0, x0, x1
	ldr	x1, [sp, #40]                   // 8-byte Folded Reload
	adds	x9, x9, x10
	adcs	x10, x20, x21
	stp	x1, x9, [x8]
	ldr	x9, [sp, #32]                   // 8-byte Folded Reload
	adcs	x9, x9, x22
	stp	x10, x9, [x8, #16]
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	adcs	x1, x19, x23
	adcs	x9, x9, x24
	stp	x1, x9, [x8, #32]
	ldr	x9, [sp, #16]                   // 8-byte Folded Reload
	adcs	x10, x14, x25
	adcs	x9, x9, x26
	stp	x10, x9, [x8, #48]
	ldr	x9, [sp, #8]                    // 8-byte Folded Reload
	adcs	x14, x16, x27
	adcs	x9, x9, x28
	adcs	x10, x18, x29
	stp	x14, x9, [x8, #64]
	adcs	x9, x2, x30
	adcs	x11, x3, x11
	stp	x10, x9, [x8, #80]
	adcs	x9, x4, x17
	adcs	x10, x5, x12
	stp	x11, x9, [x8, #96]
	adcs	x9, x6, x15
	adcs	x11, x7, x13
	stp	x10, x9, [x8, #112]
	adcs	x9, x0, xzr
	stp	x11, x9, [x8, #128]
	ldp	x20, x19, [sp, #128]            // 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            // 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             // 16-byte Folded Reload
	ldp	x29, x30, [sp, #48]             // 16-byte Folded Reload
	add	sp, sp, #144                    // =144
	ret
.Lfunc_end208:
	.size	mulUnit_inner1088, .Lfunc_end208-mulUnit_inner1088
                                        // -- End function
	.globl	mclb_mulUnit17                  // -- Begin function mclb_mulUnit17
	.p2align	2
	.type	mclb_mulUnit17,@function
mclb_mulUnit17:                         // @mclb_mulUnit17
// %bb.0:
	sub	sp, sp, #160                    // =160
	stp	x30, x19, [sp, #144]            // 16-byte Folded Spill
	mov	x19, x0
	mov	x8, sp
	mov	x0, x1
	mov	x1, x2
	bl	mulUnit_inner1088
	ldp	x8, x0, [sp, #128]
	ldp	q1, q0, [sp, #96]
	ldp	q3, q2, [sp]
	ldp	q5, q4, [sp, #32]
	ldp	q7, q6, [sp, #64]
	stp	q1, q0, [x19, #96]
	stp	q3, q2, [x19]
	stp	q5, q4, [x19, #32]
	stp	q7, q6, [x19, #64]
	str	x8, [x19, #128]
	ldp	x30, x19, [sp, #144]            // 16-byte Folded Reload
	add	sp, sp, #160                    // =160
	ret
.Lfunc_end209:
	.size	mclb_mulUnit17, .Lfunc_end209-mclb_mulUnit17
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
.Lfunc_end210:
	.size	mclb_mulUnitAdd17, .Lfunc_end210-mclb_mulUnitAdd17
                                        // -- End function
	.globl	mclb_mul17                      // -- Begin function mclb_mul17
	.p2align	2
	.type	mclb_mul17,@function
mclb_mul17:                             // @mclb_mul17
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #2560                   // =2560
	mov	x22, x1
	ldr	x1, [x2]
	mov	x19, x0
	add	x8, sp, #2416                   // =2416
	mov	x0, x22
	mov	x29, x2
	bl	mulUnit_inner1088
	ldr	x9, [sp, #2552]
	ldr	x8, [sp, #2544]
	ldr	x1, [x29, #8]
	ldr	x23, [sp, #2480]
	ldr	x24, [sp, #2472]
	stp	x8, x9, [sp, #96]               // 16-byte Folded Spill
	ldr	x9, [sp, #2536]
	ldr	x8, [sp, #2528]
	ldr	x20, [sp, #2464]
	ldr	x21, [sp, #2456]
	ldr	x25, [sp, #2448]
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #2520]
	ldr	x8, [sp, #2512]
	ldr	x26, [sp, #2440]
	ldr	x27, [sp, #2432]
	ldr	x28, [sp, #2424]
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x9, [sp, #2504]
	ldr	x8, [sp, #2496]
	mov	x0, x22
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldr	x8, [sp, #2488]
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	ldr	x8, [sp, #2416]
	str	x8, [x19]
	add	x8, sp, #2272                   // =2272
	bl	mulUnit_inner1088
	ldr	x8, [sp, #2272]
	ldr	x9, [sp, #2280]
	ldr	x10, [sp, #2288]
	ldr	x11, [sp, #2296]
	adds	x8, x8, x28
	adcs	x27, x9, x27
	ldr	x9, [sp, #2304]
	adcs	x26, x10, x26
	ldr	x10, [sp, #2312]
	adcs	x25, x11, x25
	ldr	x11, [sp, #2320]
	adcs	x28, x9, x21
	ldr	x9, [sp, #2328]
	adcs	x18, x10, x20
	ldr	x10, [sp, #2336]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x24, x11, x24
	adcs	x23, x9, x23
	ldr	x11, [sp, #2344]
	adcs	x10, x10, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2352]
	stp	x18, x10, [sp, #32]             // 16-byte Folded Spill
	ldr	x10, [sp, #2360]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2368]
	ldr	x1, [x29, #16]
	mov	x0, x22
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #48]              // 16-byte Folded Spill
	ldr	x9, [sp, #2376]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2384]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #64]             // 16-byte Folded Spill
	ldr	x11, [sp, #2392]
	adcs	x18, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2400]
	adcs	x10, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #2408]
	str	x8, [x19, #8]
	adcs	x11, x11, x12
	str	x11, [sp, #96]                  // 8-byte Folded Spill
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	add	x8, sp, #2128                   // =2128
	adcs	x20, x9, x11
	adcs	x21, x10, xzr
	bl	mulUnit_inner1088
	ldr	x8, [sp, #2128]
	ldr	x9, [sp, #2136]
	ldr	x10, [sp, #2144]
	ldr	x11, [sp, #2152]
	adds	x8, x8, x27
	adcs	x26, x9, x26
	ldr	x9, [sp, #2160]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	adcs	x25, x10, x25
	ldr	x10, [sp, #2168]
	adcs	x27, x11, x28
	ldr	x11, [sp, #2176]
	adcs	x9, x9, x12
	str	x9, [sp, #104]                  // 8-byte Folded Spill
	ldr	x9, [sp, #2184]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x24, x10, x24
	adcs	x23, x11, x23
	ldr	x10, [sp, #2192]
	adcs	x28, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2200]
	ldr	x9, [sp, #2208]
	ldr	x1, [x29, #24]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2216]
	mov	x0, x22
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #2224]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2232]
	adcs	x10, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #64]             // 16-byte Folded Spill
	ldr	x10, [sp, #2240]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2248]
	adcs	x9, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #80]              // 16-byte Folded Spill
	ldr	x9, [sp, #2256]
	adcs	x10, x10, x12
	str	x10, [sp, #96]                  // 8-byte Folded Spill
	ldr	x10, [sp, #2264]
	adcs	x20, x11, x20
	adcs	x21, x9, x21
	str	x8, [x19, #16]
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1984                   // =1984
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1984]
	ldr	x9, [sp, #1992]
	ldr	x10, [sp, #2000]
	ldr	x11, [sp, #2008]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adds	x8, x8, x26
	adcs	x25, x9, x25
	ldr	x9, [sp, #2016]
	adcs	x26, x10, x27
	ldr	x10, [sp, #2024]
	adcs	x11, x11, x12
	str	x11, [sp, #104]                 // 8-byte Folded Spill
	ldr	x11, [sp, #2032]
	adcs	x24, x9, x24
	ldr	x9, [sp, #2040]
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x23, x10, x23
	adcs	x27, x11, x28
	ldr	x10, [sp, #2048]
	adcs	x28, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2056]
	ldr	x9, [sp, #2064]
	ldr	x1, [x29, #32]
	adcs	x18, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2072]
	mov	x0, x22
	adcs	x11, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #56]             // 16-byte Folded Spill
	ldr	x11, [sp, #2080]
	adcs	x18, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2088]
	adcs	x10, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #72]             // 16-byte Folded Spill
	ldr	x10, [sp, #2096]
	adcs	x18, x11, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2104]
	adcs	x9, x9, x12
	stp	x18, x9, [sp, #88]              // 16-byte Folded Spill
	adcs	x18, x10, x20
	adcs	x11, x11, x21
	ldr	x9, [sp, #2112]
	str	x11, [sp, #32]                  // 8-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2120]
	str	x8, [x19, #24]
	mov	x21, x29
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #40]              // 16-byte Folded Spill
	add	x8, sp, #1840                   // =1840
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1840]
	ldr	x9, [sp, #1848]
	ldr	x10, [sp, #1856]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adds	x8, x8, x25
	ldr	x11, [sp, #1864]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1872]
	adcs	x10, x10, x12
	str	x10, [sp, #104]                 // 8-byte Folded Spill
	ldr	x10, [sp, #1880]
	adcs	x24, x11, x24
	ldr	x11, [sp, #1888]
	adcs	x23, x9, x23
	ldr	x9, [sp, #1896]
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	adcs	x26, x10, x27
	adcs	x27, x11, x28
	ldr	x10, [sp, #1904]
	adcs	x28, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1912]
	ldr	x9, [sp, #1920]
	ldr	x1, [x29, #40]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1928]
	mov	x0, x22
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #64]             // 16-byte Folded Spill
	ldr	x11, [sp, #1936]
	adcs	x18, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1944]
	adcs	x10, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #1952]
	adcs	x11, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	str	x11, [sp, #96]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1960]
	adcs	x18, x9, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1968]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #48]             // 16-byte Folded Spill
	adcs	x18, x11, x20
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1976]
	str	x8, [x19, #32]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	stp	x18, x8, [sp, #32]              // 16-byte Folded Spill
	add	x8, sp, #1696                   // =1696
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1696]
	ldr	x9, [sp, #1704]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	ldr	x10, [sp, #1712]
	adds	x8, x8, x25
	ldr	x11, [sp, #1720]
	adcs	x9, x9, x12
	str	x9, [sp, #104]                  // 8-byte Folded Spill
	ldr	x9, [sp, #1728]
	adcs	x24, x10, x24
	ldr	x10, [sp, #1736]
	adcs	x11, x11, x23
	str	x11, [sp, #24]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1744]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1752]
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x26, x10, x27
	adcs	x27, x11, x28
	ldr	x10, [sp, #1760]
	adcs	x28, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1768]
	ldr	x9, [sp, #1776]
	ldr	x1, [x29, #48]
	adcs	x18, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1784]
	mov	x0, x22
	mov	x23, x22
	adcs	x11, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #72]             // 16-byte Folded Spill
	ldr	x11, [sp, #1792]
	adcs	x18, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1800]
	adcs	x10, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #88]             // 16-byte Folded Spill
	ldr	x10, [sp, #1808]
	adcs	x18, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1816]
	adcs	x9, x9, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #56]              // 16-byte Folded Spill
	ldr	x9, [sp, #1824]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	str	x11, [sp, #32]                  // 8-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1832]
	str	x8, [x19, #40]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #40]              // 16-byte Folded Spill
	add	x8, sp, #1552                   // =1552
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1552]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #1560]
	ldr	x10, [sp, #1568]
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	adds	x8, x8, x11
	ldr	x11, [sp, #1576]
	adcs	x9, x9, x24
	str	x9, [sp, #104]                  // 8-byte Folded Spill
	ldr	x9, [sp, #1584]
	adcs	x10, x10, x12
	str	x10, [sp, #24]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1592]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1600]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1608]
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x26, x10, x27
	adcs	x27, x11, x28
	ldr	x10, [sp, #1616]
	adcs	x28, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1624]
	ldr	x9, [sp, #1632]
	ldr	x1, [x21, #56]
	adcs	x29, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1640]
	mov	x0, x23
	mov	x22, x21
	adcs	x18, x11, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1648]
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #88]              // 16-byte Folded Spill
	ldr	x9, [sp, #1656]
	adcs	x18, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1664]
	adcs	x11, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #72]             // 16-byte Folded Spill
	ldr	x11, [sp, #1672]
	adcs	x18, x9, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1680]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #56]             // 16-byte Folded Spill
	adcs	x18, x11, x20
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1688]
	str	x8, [x19, #48]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #40]              // 16-byte Folded Spill
	add	x8, sp, #1408                   // =1408
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1408]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #1416]
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1424]
	adds	x8, x8, x11
	ldr	x11, [sp, #1432]
	adcs	x18, x9, x12
	ldr	x9, [sp, #1440]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1448]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1456]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1464]
	adcs	x26, x10, x27
	ldr	x10, [sp, #1472]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1480]
	adcs	x29, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1488]
	ldr	x10, [sp, #1496]
	ldr	x1, [x21, #64]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1504]
	mov	x0, x23
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1512]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #1520]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1528]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #1536]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1544]
	str	x8, [x19, #56]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1264                   // =1264
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1264]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #1272]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1280]
	adds	x8, x8, x11
	ldr	x11, [sp, #1288]
	adcs	x18, x9, x12
	ldr	x9, [sp, #1296]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1304]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1312]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1320]
	adcs	x26, x10, x27
	ldr	x10, [sp, #1328]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1336]
	adcs	x29, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1344]
	ldr	x10, [sp, #1352]
	ldr	x1, [x21, #72]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1360]
	mov	x0, x23
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1368]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #1376]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1384]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #1392]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1400]
	str	x8, [x19, #64]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #1120                   // =1120
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1120]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #1128]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1136]
	adds	x8, x8, x11
	ldr	x11, [sp, #1144]
	adcs	x18, x9, x12
	ldr	x9, [sp, #1152]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1160]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1168]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1176]
	adcs	x26, x10, x27
	ldr	x10, [sp, #1184]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1192]
	adcs	x29, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1200]
	ldr	x10, [sp, #1208]
	ldr	x1, [x21, #80]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1216]
	mov	x0, x23
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1224]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #1232]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1240]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #1248]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1256]
	str	x8, [x19, #72]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #976                    // =976
	bl	mulUnit_inner1088
	ldr	x8, [sp, #976]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #984]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #992]
	adds	x8, x8, x11
	ldr	x11, [sp, #1000]
	adcs	x18, x9, x12
	ldr	x9, [sp, #1008]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1016]
	adcs	x24, x11, x25
	ldr	x11, [sp, #1024]
	adcs	x25, x9, x26
	ldr	x9, [sp, #1032]
	adcs	x26, x10, x27
	ldr	x10, [sp, #1040]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #1048]
	adcs	x10, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1056]
	stp	x10, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x10, [sp, #1064]
	adcs	x29, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1072]
	ldr	x1, [x21, #88]
	mov	x0, x23
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1080]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #1088]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1096]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #1104]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1112]
	str	x8, [x19, #80]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #832                    // =832
	bl	mulUnit_inner1088
	ldr	x8, [sp, #832]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #840]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #848]
	adds	x8, x8, x11
	ldr	x11, [sp, #856]
	adcs	x18, x9, x12
	ldr	x9, [sp, #864]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #872]
	adcs	x24, x11, x25
	ldr	x11, [sp, #880]
	adcs	x25, x9, x26
	ldr	x9, [sp, #888]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x26, x10, x27
	ldr	x10, [sp, #896]
	adcs	x27, x11, x28
	ldr	x11, [sp, #904]
	adcs	x9, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x28, x10, x29
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #912]
	adcs	x29, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #920]
	ldr	x11, [sp, #928]
	ldr	x1, [x21, #96]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #936]
	mov	x0, x23
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #944]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #952]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #960]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #968]
	str	x8, [x19, #88]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #688                    // =688
	bl	mulUnit_inner1088
	ldr	x8, [sp, #688]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #696]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #704]
	adds	x8, x8, x11
	ldr	x11, [sp, #712]
	adcs	x18, x9, x12
	ldr	x9, [sp, #720]
	adcs	x10, x10, x24
	str	x10, [sp, #32]                  // 8-byte Folded Spill
	ldr	x10, [sp, #728]
	adcs	x24, x11, x25
	ldr	x11, [sp, #736]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x25, x9, x26
	ldr	x9, [sp, #744]
	adcs	x26, x10, x27
	ldr	x10, [sp, #752]
	adcs	x11, x11, x12
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #760]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldr	x9, [sp, #768]
	adcs	x29, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #776]
	ldr	x11, [sp, #784]
	ldr	x1, [x21, #104]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #792]
	mov	x0, x23
	mov	x21, x23
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #800]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #808]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #816]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #824]
	str	x8, [x19, #96]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #544                    // =544
	bl	mulUnit_inner1088
	ldr	x8, [sp, #544]
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	ldr	x9, [sp, #552]
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldr	x10, [sp, #560]
	adds	x8, x8, x11
	ldr	x11, [sp, #568]
	adcs	x18, x9, x12
	ldr	x9, [sp, #576]
	adcs	x23, x10, x24
	ldr	x10, [sp, #584]
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x24, x11, x25
	ldr	x11, [sp, #592]
	adcs	x25, x9, x26
	ldr	x9, [sp, #600]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x10, [sp, #608]
	adcs	x26, x11, x27
	ldr	x11, [sp, #616]
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldr	x9, [sp, #624]
	adcs	x29, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #632]
	ldr	x11, [sp, #640]
	ldr	x1, [x22, #112]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #648]
	mov	x0, x21
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x10, [sp, #656]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #664]
	adcs	x9, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #64]              // 16-byte Folded Spill
	ldr	x9, [sp, #672]
	adcs	x18, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #48]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	ldr	x10, [sp, #680]
	str	x8, [x19, #104]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #40]                   // 8-byte Folded Spill
	add	x8, sp, #400                    // =400
	bl	mulUnit_inner1088
	ldp	x8, x9, [sp, #400]
	ldp	x12, x11, [sp, #96]             // 16-byte Folded Reload
	ldr	x1, [x22, #120]
	mov	x0, x21
	adds	x8, x8, x11
	ldp	x10, x11, [sp, #416]
	adcs	x18, x9, x23
	adcs	x23, x10, x24
	ldp	x9, x10, [sp, #432]
	adcs	x24, x11, x25
	adcs	x9, x9, x12
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #448]
	adcs	x25, x10, x26
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x26, x11, x27
	ldp	x10, x11, [sp, #464]
	adcs	x27, x9, x28
	adcs	x28, x10, x29
	ldp	x9, x10, [sp, #480]
	adcs	x29, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldp	x11, x9, [sp, #496]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #72]             // 16-byte Folded Spill
	ldr	x10, [sp, #512]
	adcs	x11, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	str	x11, [sp, #64]                  // 8-byte Folded Spill
	ldr	x11, [sp, #520]
	adcs	x18, x9, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	ldr	x9, [sp, #528]
	adcs	x10, x10, x12
	adcs	x11, x11, x20
	stp	x11, x18, [sp, #24]             // 16-byte Folded Spill
	ldr	x11, [sp, #40]                  // 8-byte Folded Reload
	str	x10, [sp, #48]                  // 8-byte Folded Spill
	ldr	x10, [sp, #536]
	str	x8, [x19, #112]
	adcs	x20, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #16]                   // 8-byte Folded Spill
	add	x8, sp, #256                    // =256
	bl	mulUnit_inner1088
	ldp	x8, x9, [sp, #256]
	ldp	x12, x11, [sp, #96]             // 16-byte Folded Reload
	ldr	x1, [x22, #128]
	mov	x0, x21
	adds	x8, x8, x11
	ldp	x10, x11, [sp, #272]
	adcs	x23, x9, x23
	adcs	x10, x10, x24
	str	x10, [sp, #40]                  // 8-byte Folded Spill
	ldp	x9, x10, [sp, #288]
	adcs	x24, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x18, x9, x25
	ldp	x11, x9, [sp, #304]
	adcs	x25, x10, x26
	adcs	x11, x11, x27
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldp	x10, x11, [sp, #320]
	adcs	x27, x9, x28
	adcs	x18, x10, x29
	ldp	x9, x10, [sp, #336]
	adcs	x29, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #352]
	adcs	x18, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	adcs	x11, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	str	x11, [sp, #72]                  // 8-byte Folded Spill
	ldp	x10, x11, [sp, #368]
	adcs	x26, x9, x12
	ldr	x9, [sp, #24]                   // 8-byte Folded Reload
	adcs	x9, x10, x9
	adcs	x10, x11, x20
	stp	x18, x9, [sp, #56]              // 16-byte Folded Spill
	str	x10, [sp, #48]                  // 8-byte Folded Spill
	ldp	x9, x10, [sp, #384]
	ldr	x11, [sp, #16]                  // 8-byte Folded Reload
	str	x8, [x19, #120]
	add	x8, sp, #112                    // =112
	adcs	x28, x9, x11
	adcs	x20, x10, xzr
	bl	mulUnit_inner1088
	ldp	x15, x14, [sp, #112]
	ldr	x3, [sp, #40]                   // 8-byte Folded Reload
	ldp	x0, x18, [sp, #128]
	ldp	x9, x8, [sp, #240]
	adds	x15, x15, x23
	adcs	x14, x14, x3
	ldp	x11, x10, [sp, #224]
	ldp	x13, x12, [sp, #208]
	ldp	x17, x16, [sp, #192]
	ldp	x2, x1, [sp, #176]
	ldp	x4, x3, [sp, #160]
	ldp	x6, x5, [sp, #144]
	stp	x15, x14, [x19, #128]
	ldr	x14, [sp, #104]                 // 8-byte Folded Reload
	adcs	x0, x0, x24
	adcs	x14, x18, x14
	stp	x0, x14, [x19, #144]
	ldr	x14, [sp, #96]                  // 8-byte Folded Reload
	adcs	x15, x6, x25
	adcs	x14, x5, x14
	stp	x15, x14, [x19, #160]
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	adcs	x18, x4, x27
	adcs	x14, x3, x14
	stp	x18, x14, [x19, #176]
	ldr	x14, [sp, #80]                  // 8-byte Folded Reload
	adcs	x15, x2, x29
	ldr	x18, [sp, #56]                  // 8-byte Folded Reload
	adcs	x14, x1, x14
	stp	x15, x14, [x19, #192]
	ldr	x14, [sp, #72]                  // 8-byte Folded Reload
	adcs	x17, x17, x18
	adcs	x14, x16, x14
	stp	x17, x14, [x19, #208]
	ldr	x14, [sp, #64]                  // 8-byte Folded Reload
	adcs	x13, x13, x26
	adcs	x12, x12, x14
	ldr	x14, [sp, #48]                  // 8-byte Folded Reload
	stp	x13, x12, [x19, #224]
	adcs	x11, x11, x14
	adcs	x10, x10, x28
	adcs	x9, x9, x20
	adcs	x8, x8, xzr
	stp	x11, x10, [x19, #240]
	stp	x9, x8, [x19, #256]
	add	sp, sp, #2560                   // =2560
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end211:
	.size	mclb_mul17, .Lfunc_end211-mclb_mul17
                                        // -- End function
	.globl	mclb_sqr17                      // -- Begin function mclb_sqr17
	.p2align	2
	.type	mclb_sqr17,@function
mclb_sqr17:                             // @mclb_sqr17
// %bb.0:
	stp	x29, x30, [sp, #-96]!           // 16-byte Folded Spill
	stp	x28, x27, [sp, #16]             // 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             // 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             // 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             // 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             // 16-byte Folded Spill
	sub	sp, sp, #2560                   // =2560
	mov	x20, x1
	ldr	x1, [x1]
	mov	x19, x0
	add	x8, sp, #2416                   // =2416
	mov	x0, x20
	bl	mulUnit_inner1088
	ldr	x9, [sp, #2552]
	ldr	x8, [sp, #2544]
	ldr	x1, [x20, #8]
	ldr	x29, [sp, #2488]
	ldr	x21, [sp, #2480]
	stp	x8, x9, [sp, #96]               // 16-byte Folded Spill
	ldr	x9, [sp, #2536]
	ldr	x8, [sp, #2528]
	ldr	x22, [sp, #2472]
	ldr	x23, [sp, #2464]
	ldr	x24, [sp, #2456]
	stp	x8, x9, [sp, #80]               // 16-byte Folded Spill
	ldr	x9, [sp, #2520]
	ldr	x8, [sp, #2512]
	ldr	x25, [sp, #2448]
	ldr	x26, [sp, #2440]
	ldr	x27, [sp, #2432]
	stp	x8, x9, [sp, #64]               // 16-byte Folded Spill
	ldr	x9, [sp, #2504]
	ldr	x8, [sp, #2496]
	ldr	x28, [sp, #2424]
	mov	x0, x20
	stp	x8, x9, [sp, #48]               // 16-byte Folded Spill
	ldr	x8, [sp, #2416]
	str	x8, [x19]
	add	x8, sp, #2272                   // =2272
	bl	mulUnit_inner1088
	ldr	x8, [sp, #2272]
	ldr	x9, [sp, #2280]
	ldr	x10, [sp, #2288]
	ldr	x11, [sp, #2296]
	adds	x8, x8, x28
	adcs	x27, x9, x27
	ldr	x9, [sp, #2304]
	adcs	x26, x10, x26
	ldr	x10, [sp, #2312]
	adcs	x25, x11, x25
	ldr	x11, [sp, #2320]
	adcs	x24, x9, x24
	ldr	x9, [sp, #2328]
	adcs	x23, x10, x23
	ldr	x10, [sp, #2336]
	adcs	x28, x11, x22
	ldr	x11, [sp, #2344]
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x18, x9, x21
	adcs	x29, x10, x29
	ldr	x9, [sp, #2352]
	adcs	x11, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2360]
	stp	x18, x11, [sp, #40]             // 16-byte Folded Spill
	ldr	x11, [sp, #2368]
	adcs	x18, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2376]
	ldr	x1, [x20, #16]
	mov	x0, x20
	adcs	x10, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	stp	x18, x10, [sp, #56]             // 16-byte Folded Spill
	ldr	x10, [sp, #2384]
	adcs	x18, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2392]
	adcs	x9, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #72]              // 16-byte Folded Spill
	ldr	x9, [sp, #2400]
	adcs	x18, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2408]
	str	x8, [x19, #8]
	add	x8, sp, #2128                   // =2128
	adcs	x11, x11, x12
	stp	x18, x11, [sp, #88]             // 16-byte Folded Spill
	ldr	x11, [sp, #104]                 // 8-byte Folded Reload
	adcs	x21, x9, x11
	adcs	x22, x10, xzr
	bl	mulUnit_inner1088
	ldr	x8, [sp, #2128]
	ldr	x9, [sp, #2136]
	ldr	x10, [sp, #2144]
	ldr	x11, [sp, #2152]
	adds	x8, x8, x27
	adcs	x26, x9, x26
	ldr	x9, [sp, #2160]
	adcs	x25, x10, x25
	ldr	x10, [sp, #2168]
	adcs	x24, x11, x24
	ldr	x11, [sp, #2176]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	adcs	x23, x9, x23
	ldr	x9, [sp, #2184]
	adcs	x27, x10, x28
	ldr	x10, [sp, #2192]
	adcs	x28, x11, x12
	ldr	x12, [sp, #48]                  // 8-byte Folded Reload
	adcs	x29, x9, x29
	ldr	x11, [sp, #2200]
	ldr	x9, [sp, #2208]
	adcs	x10, x10, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	str	x10, [sp, #104]                 // 8-byte Folded Spill
	ldr	x10, [sp, #2216]
	ldr	x1, [x20, #24]
	adcs	x18, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2224]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	stp	x18, x9, [sp, #56]              // 16-byte Folded Spill
	ldr	x9, [sp, #2232]
	adcs	x18, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2240]
	adcs	x11, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	stp	x18, x11, [sp, #72]             // 16-byte Folded Spill
	ldr	x11, [sp, #2248]
	adcs	x18, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #2256]
	adcs	x10, x10, x12
	stp	x18, x10, [sp, #88]             // 16-byte Folded Spill
	ldr	x10, [sp, #2264]
	adcs	x21, x11, x21
	adcs	x22, x9, x22
	str	x8, [x19, #16]
	adcs	x8, x10, xzr
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1984                   // =1984
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1984]
	ldr	x9, [sp, #1992]
	ldr	x10, [sp, #2000]
	ldr	x11, [sp, #2008]
	adds	x8, x8, x26
	adcs	x25, x9, x25
	ldr	x9, [sp, #2016]
	adcs	x24, x10, x24
	ldr	x10, [sp, #2024]
	adcs	x23, x11, x23
	ldr	x11, [sp, #2032]
	adcs	x26, x9, x27
	ldr	x9, [sp, #2040]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #2048]
	adcs	x29, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #2056]
	ldr	x9, [sp, #2064]
	ldr	x1, [x20, #32]
	adcs	x18, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2072]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	str	x11, [sp, #64]                  // 8-byte Folded Spill
	ldr	x11, [sp, #2080]
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x9, [sp, #72]                   // 8-byte Folded Spill
	ldr	x9, [sp, #2088]
	adcs	x10, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	str	x10, [sp, #80]                  // 8-byte Folded Spill
	ldr	x10, [sp, #2096]
	adcs	x11, x11, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	str	x11, [sp, #88]                  // 8-byte Folded Spill
	ldr	x11, [sp, #2104]
	adcs	x9, x9, x12
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	adcs	x18, x10, x21
	ldr	x9, [sp, #2112]
	adcs	x22, x11, x22
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #2120]
	str	x8, [x19, #24]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1840                   // =1840
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1840]
	ldr	x9, [sp, #1848]
	ldr	x10, [sp, #1856]
	ldr	x11, [sp, #1864]
	adds	x8, x8, x25
	adcs	x24, x9, x24
	ldr	x9, [sp, #1872]
	adcs	x23, x10, x23
	ldr	x10, [sp, #1880]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1888]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1896]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1904]
	adcs	x29, x9, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1912]
	ldr	x9, [sp, #1920]
	ldr	x1, [x20, #40]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1928]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x11, [sp, #72]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1936]
	adcs	x9, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	str	x9, [sp, #80]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1944]
	adcs	x10, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	str	x10, [sp, #88]                  // 8-byte Folded Spill
	ldr	x10, [sp, #1952]
	adcs	x11, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1960]
	adcs	x18, x9, x12
	adcs	x22, x10, x22
	adcs	x11, x11, x21
	ldr	x9, [sp, #1968]
	stp	x11, x18, [sp, #56]             // 16-byte Folded Spill
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1976]
	str	x8, [x19, #32]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1696                   // =1696
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1696]
	ldr	x9, [sp, #1704]
	ldr	x10, [sp, #1712]
	ldr	x11, [sp, #1720]
	adds	x8, x8, x24
	adcs	x23, x9, x23
	ldr	x9, [sp, #1728]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1736]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1744]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1752]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1760]
	adcs	x29, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1768]
	ldr	x9, [sp, #1776]
	ldr	x1, [x20, #48]
	adcs	x18, x10, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1784]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	str	x11, [sp, #80]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1792]
	adcs	x9, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	str	x9, [sp, #88]                   // 8-byte Folded Spill
	ldr	x9, [sp, #1800]
	adcs	x10, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x10, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x10, [sp, #1808]
	adcs	x18, x11, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1816]
	adcs	x22, x9, x22
	ldr	x9, [sp, #1824]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1832]
	str	x8, [x19, #40]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1552                   // =1552
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1552]
	ldr	x9, [sp, #1560]
	ldr	x10, [sp, #1568]
	ldr	x11, [sp, #1576]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1584]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1592]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1600]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1608]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1616]
	adcs	x29, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1624]
	ldr	x9, [sp, #1632]
	ldr	x1, [x20, #56]
	adcs	x18, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1640]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	str	x11, [sp, #88]                  // 8-byte Folded Spill
	ldr	x11, [sp, #1648]
	adcs	x9, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #1656]
	adcs	x18, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x22, x11, x22
	ldr	x10, [sp, #1664]
	ldr	x11, [sp, #1672]
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #72]              // 16-byte Folded Spill
	ldr	x9, [sp, #1680]
	adcs	x18, x10, x12
	adcs	x11, x11, x21
	stp	x11, x18, [sp, #56]             // 16-byte Folded Spill
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1688]
	str	x8, [x19, #48]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #48]                   // 8-byte Folded Spill
	add	x8, sp, #1408                   // =1408
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1408]
	ldr	x9, [sp, #1416]
	ldr	x10, [sp, #1424]
	ldr	x11, [sp, #1432]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1440]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1448]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1456]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1464]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1472]
	adcs	x29, x9, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1480]
	ldr	x9, [sp, #1488]
	ldr	x1, [x20, #64]
	adcs	x18, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1496]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1504]
	adcs	x18, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	adcs	x22, x10, x22
	ldr	x9, [sp, #1512]
	ldr	x10, [sp, #1520]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1528]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1536]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1544]
	str	x8, [x19, #56]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1264                   // =1264
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1264]
	ldr	x9, [sp, #1272]
	ldr	x10, [sp, #1280]
	ldr	x11, [sp, #1288]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1296]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1304]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1312]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1320]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1328]
	adcs	x29, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1336]
	ldr	x9, [sp, #1344]
	ldr	x1, [x20, #72]
	adcs	x18, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1352]
	mov	x0, x20
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	adcs	x22, x9, x22
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldr	x11, [sp, #1360]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1368]
	ldr	x10, [sp, #1376]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1384]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1392]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1400]
	str	x8, [x19, #64]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #1120                   // =1120
	bl	mulUnit_inner1088
	ldr	x8, [sp, #1120]
	ldr	x9, [sp, #1128]
	ldr	x10, [sp, #1136]
	ldr	x11, [sp, #1144]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1152]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1160]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1168]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1176]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	adcs	x28, x11, x29
	ldr	x10, [sp, #1184]
	adcs	x29, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1192]
	ldr	x9, [sp, #1200]
	ldr	x1, [x20, #80]
	adcs	x18, x10, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x22, x11, x22
	ldr	x10, [sp, #1208]
	ldr	x11, [sp, #1216]
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #1224]
	mov	x0, x20
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1232]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1240]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1248]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1256]
	str	x8, [x19, #72]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #976                    // =976
	bl	mulUnit_inner1088
	ldr	x8, [sp, #976]
	ldr	x9, [sp, #984]
	ldr	x10, [sp, #992]
	ldr	x11, [sp, #1000]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #1008]
	adcs	x24, x10, x25
	ldr	x10, [sp, #1016]
	adcs	x25, x11, x26
	ldr	x11, [sp, #1024]
	adcs	x26, x9, x27
	ldr	x9, [sp, #1032]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x10, x28
	ldr	x10, [sp, #1040]
	adcs	x28, x11, x29
	ldr	x11, [sp, #1048]
	adcs	x29, x9, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	adcs	x22, x10, x22
	ldr	x9, [sp, #1056]
	ldr	x10, [sp, #1064]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #1072]
	ldr	x1, [x20, #88]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #1080]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1088]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #1096]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #1104]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #1112]
	str	x8, [x19, #80]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #832                    // =832
	bl	mulUnit_inner1088
	ldr	x8, [sp, #832]
	ldr	x9, [sp, #840]
	ldr	x10, [sp, #848]
	ldr	x11, [sp, #856]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #864]
	adcs	x24, x10, x25
	ldr	x10, [sp, #872]
	adcs	x25, x11, x26
	ldr	x11, [sp, #880]
	adcs	x26, x9, x27
	ldr	x9, [sp, #888]
	adcs	x27, x10, x28
	ldr	x10, [sp, #896]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x28, x11, x29
	adcs	x22, x9, x22
	ldr	x11, [sp, #904]
	adcs	x29, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #912]
	ldr	x10, [sp, #920]
	ldr	x1, [x20, #96]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #928]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #936]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #944]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #952]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #960]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #968]
	str	x8, [x19, #88]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #688                    // =688
	bl	mulUnit_inner1088
	ldr	x8, [sp, #688]
	ldr	x9, [sp, #696]
	ldr	x10, [sp, #704]
	ldr	x11, [sp, #712]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #720]
	adcs	x24, x10, x25
	ldr	x10, [sp, #728]
	adcs	x25, x11, x26
	ldr	x11, [sp, #736]
	adcs	x26, x9, x27
	ldr	x9, [sp, #744]
	adcs	x27, x10, x28
	ldr	x10, [sp, #752]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x22, x11, x22
	adcs	x28, x9, x29
	ldr	x11, [sp, #760]
	adcs	x29, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #768]
	ldr	x10, [sp, #776]
	ldr	x1, [x20, #104]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #784]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #792]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #800]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #808]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #816]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #824]
	str	x8, [x19, #96]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #544                    // =544
	bl	mulUnit_inner1088
	ldr	x8, [sp, #544]
	ldr	x9, [sp, #552]
	ldr	x10, [sp, #560]
	ldr	x11, [sp, #568]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	ldr	x9, [sp, #576]
	adcs	x24, x10, x25
	ldr	x10, [sp, #584]
	adcs	x25, x11, x26
	ldr	x11, [sp, #592]
	adcs	x26, x9, x27
	ldr	x9, [sp, #600]
	adcs	x22, x10, x22
	ldr	x10, [sp, #608]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	adcs	x27, x11, x28
	adcs	x28, x9, x29
	ldr	x11, [sp, #616]
	adcs	x29, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldr	x9, [sp, #624]
	ldr	x10, [sp, #632]
	ldr	x1, [x20, #112]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	ldr	x11, [sp, #640]
	mov	x0, x20
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #96]              // 16-byte Folded Spill
	ldr	x9, [sp, #648]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #656]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #80]             // 16-byte Folded Spill
	ldr	x11, [sp, #664]
	adcs	x18, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	ldr	x9, [sp, #672]
	adcs	x10, x10, x12
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	adcs	x18, x11, x21
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #680]
	str	x8, [x19, #104]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	stp	x8, x18, [sp, #48]              // 16-byte Folded Spill
	add	x8, sp, #400                    // =400
	bl	mulUnit_inner1088
	ldp	x8, x9, [sp, #400]
	ldp	x10, x11, [sp, #416]
	ldr	x12, [sp, #104]                 // 8-byte Folded Reload
	ldr	x1, [x20, #120]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	adcs	x24, x10, x25
	ldp	x9, x10, [sp, #432]
	adcs	x25, x11, x26
	mov	x0, x20
	adcs	x22, x9, x22
	ldp	x11, x9, [sp, #448]
	adcs	x26, x10, x27
	adcs	x27, x11, x28
	ldp	x10, x11, [sp, #464]
	adcs	x28, x9, x29
	adcs	x29, x10, x12
	ldr	x12, [sp, #96]                  // 8-byte Folded Reload
	ldp	x9, x10, [sp, #480]
	adcs	x18, x11, x12
	ldr	x12, [sp, #88]                  // 8-byte Folded Reload
	adcs	x9, x9, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #32]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #496]
	adcs	x18, x10, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	ldr	x10, [sp, #512]
	adcs	x11, x11, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	stp	x11, x18, [sp, #72]             // 16-byte Folded Spill
	ldr	x11, [sp, #520]
	adcs	x9, x9, x12
	ldr	x12, [sp, #56]                  // 8-byte Folded Reload
	str	x9, [sp, #64]                   // 8-byte Folded Spill
	ldr	x9, [sp, #528]
	adcs	x18, x10, x12
	adcs	x11, x11, x21
	stp	x11, x18, [sp, #16]             // 16-byte Folded Spill
	ldr	x11, [sp, #48]                  // 8-byte Folded Reload
	ldr	x10, [sp, #536]
	str	x8, [x19, #112]
	adcs	x21, x9, x11
	adcs	x8, x10, xzr
	str	x8, [sp, #8]                    // 8-byte Folded Spill
	add	x8, sp, #256                    // =256
	bl	mulUnit_inner1088
	ldp	x8, x9, [sp, #256]
	ldp	x10, x11, [sp, #272]
	ldr	x12, [sp, #40]                  // 8-byte Folded Reload
	ldr	x1, [x20, #128]
	adds	x8, x8, x23
	adcs	x23, x9, x24
	adcs	x24, x10, x25
	ldp	x9, x10, [sp, #288]
	adcs	x22, x11, x22
	mov	x0, x20
	adcs	x18, x9, x26
	ldp	x11, x9, [sp, #304]
	adcs	x26, x10, x27
	adcs	x11, x11, x28
	stp	x11, x18, [sp, #96]             // 16-byte Folded Spill
	ldp	x10, x11, [sp, #320]
	adcs	x28, x9, x29
	adcs	x18, x10, x12
	ldr	x12, [sp, #32]                  // 8-byte Folded Reload
	ldp	x9, x10, [sp, #336]
	adcs	x11, x11, x12
	ldr	x12, [sp, #80]                  // 8-byte Folded Reload
	str	x11, [sp, #56]                  // 8-byte Folded Spill
	adcs	x9, x9, x12
	ldr	x12, [sp, #72]                  // 8-byte Folded Reload
	stp	x9, x18, [sp, #80]              // 16-byte Folded Spill
	ldp	x11, x9, [sp, #352]
	adcs	x27, x10, x12
	ldr	x12, [sp, #64]                  // 8-byte Folded Reload
	adcs	x18, x11, x12
	ldr	x12, [sp, #24]                  // 8-byte Folded Reload
	ldp	x10, x11, [sp, #368]
	adcs	x29, x9, x12
	ldr	x12, [sp, #16]                  // 8-byte Folded Reload
	adcs	x10, x10, x12
	adcs	x11, x11, x21
	stp	x10, x18, [sp, #64]             // 16-byte Folded Spill
	ldp	x9, x10, [sp, #384]
	str	x11, [sp, #48]                  // 8-byte Folded Spill
	ldr	x11, [sp, #8]                   // 8-byte Folded Reload
	str	x8, [x19, #120]
	add	x8, sp, #112                    // =112
	adcs	x21, x9, x11
	adcs	x25, x10, xzr
	bl	mulUnit_inner1088
	ldp	x15, x14, [sp, #112]
	ldp	x0, x18, [sp, #128]
	ldp	x9, x8, [sp, #240]
	ldp	x11, x10, [sp, #224]
	adds	x15, x15, x23
	adcs	x14, x14, x24
	ldp	x13, x12, [sp, #208]
	ldp	x17, x16, [sp, #192]
	ldp	x2, x1, [sp, #176]
	ldp	x4, x3, [sp, #160]
	ldp	x6, x5, [sp, #144]
	stp	x15, x14, [x19, #128]
	ldr	x14, [sp, #104]                 // 8-byte Folded Reload
	adcs	x0, x0, x22
	adcs	x14, x18, x14
	stp	x0, x14, [x19, #144]
	ldr	x14, [sp, #96]                  // 8-byte Folded Reload
	adcs	x15, x6, x26
	adcs	x14, x5, x14
	stp	x15, x14, [x19, #160]
	ldr	x14, [sp, #88]                  // 8-byte Folded Reload
	adcs	x18, x4, x28
	ldr	x15, [sp, #56]                  // 8-byte Folded Reload
	adcs	x14, x3, x14
	stp	x18, x14, [x19, #176]
	ldr	x14, [sp, #80]                  // 8-byte Folded Reload
	adcs	x15, x2, x15
	adcs	x14, x1, x14
	stp	x15, x14, [x19, #192]
	ldr	x14, [sp, #72]                  // 8-byte Folded Reload
	adcs	x17, x17, x27
	adcs	x14, x16, x14
	stp	x17, x14, [x19, #208]
	ldr	x14, [sp, #64]                  // 8-byte Folded Reload
	adcs	x13, x13, x29
	adcs	x12, x12, x14
	ldr	x14, [sp, #48]                  // 8-byte Folded Reload
	stp	x13, x12, [x19, #224]
	adcs	x11, x11, x14
	adcs	x10, x10, x21
	adcs	x9, x9, x25
	adcs	x8, x8, xzr
	stp	x11, x10, [x19, #240]
	stp	x9, x8, [x19, #256]
	add	sp, sp, #2560                   // =2560
	ldp	x20, x19, [sp, #80]             // 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             // 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             // 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             // 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             // 16-byte Folded Reload
	ldp	x29, x30, [sp], #96             // 16-byte Folded Reload
	ret
.Lfunc_end212:
	.size	mclb_sqr17, .Lfunc_end212-mclb_sqr17
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
