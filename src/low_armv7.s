	.arch armv7-a

	.global mcl_fp_addNC64

	.align 2
mcl_fp_addNC64:
	ldm		r1, {r3, r12}
	ldm		r2, {r1, r2}
	adds	r1, r1, r3
	adc		r2, r2, r12
	stm		r0, {r1, r2}
	bx		lr
