	.arch armv7-a

	.global mcl_fp_addNC64
	.global mcl_fp_addNC96_1
	.global mcl_fp_addNC96_2

	.align 2
mcl_fp_addNC64:
	ldm		r1, {r3, r12}
	ldm		r2, {r1, r2}
	adds	r1, r1, r3
	adc		r2, r2, r12
	stm		r0, {r1, r2}
	bx		lr


	.align 2
mcl_fp_addNC96_1:
	push	{r4, lr}
	ldm	r1, {r3, r12, lr}
	ldm	r2, {r1, r4}
	ldr	r2, [r2, #8]
	adds	r1, r1, r3
	adcs	r3, r4, r12
	adc	r2, r2, lr
	stm	r0, {r1, r3}
	str	r2, [r0, #8]
	pop	{r4, lr}
	bx		lr

	.align 2
mcl_fp_addNC96_2:
	ldr		r3, [r1]
	ldr		r12, [r2]
	adds	r3, r3, r12
	str		r3, [r0]

	ldr		r3, [r1, #4]
	ldr		r12, [r2, #4]
	adcs	r3, r3, r12
	str		r3, [r0, #4]

	ldr		r3, [r1, #8]
	ldr		r12, [r2, #8]
	adcs	r3, r3, r12
	str		r3, [r0, #8]
	bx		lr
