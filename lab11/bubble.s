
	.global bubble
bubble:
	enter $(8 * 0), $0

	mov $0, %r12 /* initialize counter variable */

outerLoop:
	cmp $1, (%rdi) /* see if the the number of elements to iterate over is <= 1 */
	jle endOuter

	mov (%rdi), %r8
	add $-1, %r8
	mov %r8, (%rdi)
	jmp outerLoop
endOuter:

	leave
	ret


printFmt:
	.string "%d\n"
