	.arch armv7-a

	.global mcl_fp_addNC64
	.global mcl_fp_addNC64_2

	.align 2
mcl_fp_addNC64:
	ldrd	r2, [r2]
	stmfd	sp!, {r4, r5}
	ldrd	r4, [r1]
	adds	r2, r2, r4
	adc	r3, r3, r5
	ldmfd	sp!, {r4, r5}
	strd	r2, [r0]
	bx	lr

# slow
	.align 2
mcl_fp_addNC64_2:
	ldm		r1, {r3, r12}
	ldm		r2, {r1, r2}
	adds	r1, r1, r3
	adc		r2, r2, r12
	stm		r0, {r1, r2}
	bx lr
