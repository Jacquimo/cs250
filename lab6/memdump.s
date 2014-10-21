	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"memdump.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"0x%x: \000"
	.align	2
.LC1:
	.ascii	"%02x \000"
	.align	2
.LC2:
	.ascii	"\011%s\012\000"
	.text
	.align	2
	.global	memdump
	.type	memdump, %function
memdump:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
.L7:
	ldr	r3, .L8
	mov	r0, r3
	ldr	r1, [fp, #-16]
	bl	printf
	mov	r0, #17
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-12]
	mov	r3, #16
	str	r3, [fp, #-8]
	b	.L2
.L6:
	ldr	r2, .L8+4
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r0, r2
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	cmp	r3, #31
	bls	.L3
	ldr	r3, [fp, #-16]
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	uxtb	r3, r3
	sxtb	r3, r3
	cmp	r3, #0
	blt	.L3
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #16
	ldr	r2, [fp, #-12]
	add	r3, r2, r3
	ldr	r2, [fp, #-16]
	ldrb	r2, [r2, #0]	@ zero_extendqisi2
	strb	r2, [r3, #0]
	b	.L4
.L3:
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #16
	ldr	r2, [fp, #-12]
	add	r3, r2, r3
	mov	r2, #46
	strb	r2, [r3, #0]
.L4:
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	str	r3, [fp, #-20]
.L2:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	ble	.L5
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bgt	.L6
.L5:
	ldr	r3, [fp, #-8]
	rsb	r3, r3, #16
	ldr	r2, [fp, #-12]
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3, #0]
	ldr	r3, .L8+8
	mov	r0, r3
	ldr	r1, [fp, #-12]
	bl	printf
	ldr	r0, [fp, #-12]
	bl	free
	mov	r3, #0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bgt	.L7
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L9:
	.align	2
.L8:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	memdump, .-memdump
	.section	.rodata
	.align	2
.LC3:
	.ascii	"Hello world\012\000"
	.align	2
.LC4:
	.ascii	"&x=0x%x\012\000"
	.align	2
.LC5:
	.ascii	"&y=0x%x\012\000"
	.align	2
.LC6:
	.ascii	"Welcome \000"
	.align	2
.LC7:
	.ascii	"to \000"
	.align	2
.LC8:
	.ascii	"cs250\000"
	.align	2
.LC9:
	.ascii	"head=0x%x\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #60
	mov	r3, #5
	str	r3, [fp, #-16]
	mvn	r3, #4
	str	r3, [fp, #-20]
	adr	r3, .L11
	ldrd	r2, [r3]
	strd	r2, [fp, #-52]
	mov	r3, #65
	strb	r3, [fp, #-68]
	mov	r3, #9
	str	r3, [fp, #-64]
	mov	r3, #48
	strb	r3, [fp, #-60]
	sub	r3, fp, #68
	add	r3, r3, #4
	str	r3, [fp, #-56]
	ldr	r3, .L11+8
	sub	r2, fp, #44
	mov	r1, r2
	mov	r2, r3
	mov	r3, #13
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	ldr	r2, .L11+12
	sub	r3, fp, #68
	mov	r0, r2
	mov	r1, r3
	bl	printf
	ldr	r2, .L11+16
	sub	r3, fp, #52
	mov	r0, r2
	mov	r1, r3
	bl	printf
	sub	r3, fp, #68
	mov	r0, r3
	mov	r1, #64
	bl	memdump
	mov	r0, #8
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-24]
	ldr	r0, .L11+20
	bl	strdup
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3, #0]
	mov	r0, #8
	bl	malloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-24]
	str	r2, [r3, #4]
	ldr	r3, [fp, #-24]
	ldr	r4, [r3, #4]
	ldr	r0, .L11+24
	bl	strdup
	mov	r3, r0
	str	r3, [r4, #0]
	ldr	r3, [fp, #-24]
	ldr	r4, [r3, #4]
	mov	r0, #8
	bl	malloc
	mov	r3, r0
	str	r3, [r4, #4]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #4]
	ldr	r4, [r3, #4]
	ldr	r0, .L11+28
	bl	strdup
	mov	r3, r0
	str	r3, [r4, #0]
	ldr	r3, [fp, #-24]
	ldr	r3, [r3, #4]
	ldr	r3, [r3, #4]
	mov	r2, #0
	str	r2, [r3, #4]
	ldr	r3, .L11+32
	mov	r0, r3
	ldr	r1, [fp, #-24]
	bl	printf
	ldr	r0, [fp, #-24]
	mov	r1, #128
	bl	memdump
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
.L12:
	.align	3
.L11:
	.word	0
	.word	1076363264
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (Debian 4.6.3-14+rpi1) 4.6.3"
	.section	.note.GNU-stack,"",%progbits
