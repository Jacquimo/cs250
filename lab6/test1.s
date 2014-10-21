	.text
	.global main
main:
	stmfd   sp!, {fp, lr}
	add     fp, sp, #4
	ldr     r0, .L2
	bl      puts
	mov     r0, r3
	ldmfd   sp!, {fp, pc}
.L2:
	.word   .LC0

	.section        .rodata
.LC0:
	.ascii  "Hello world\000"
