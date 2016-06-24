	.arch armv7-a

	.global mcl_fp_addNC64
	.global mcl_fp_addNC96
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
mcl_fp_addNC96:
	push	{r4, lr}
	ldm		r1, {r1, r3, r12}
	ldm		r2, {r2, r4, lr}
	adds	r1, r1, r2
	adcs	r3, r3, r4
	adc		r12, r12, lr
	stm		r0, {r1, r3, r12}
	pop		{r4, lr}
	bx		lr

# slower
	.align 2
mcl_fp_addNC96_2:
	ldr		r3, [r1], #4
	ldr		r12, [r2], #4
	adds	r3, r3, r12
	str		r3, [r0], #4

	ldm		r1, {r1, r3}
	ldm		r2, {r2, r12}
	adcs	r1, r1, r2
	adcs	r3, r3, r12
	stm		r0, {r1, r3}
	bx		lr
