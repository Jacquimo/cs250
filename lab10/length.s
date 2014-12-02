
	.globl main
main:
	enter $(8 * 2), $0 /* Save caller registers and allocate space on stack for function parameters */

	/* Get address on stack with which to pass to scanf */
	mov %rbp, %r12
	add $-500, %r12
	mov %r12, %rsi

	mov $.readtFmt, %rdi /* move address of format string into 1st parameter */
	call scanf /* call scanf */

	/* Loop through the string to determine its length */
	mov $0, %r13
.loop:
	mov (%r12), %r14
	cmp $0, %r14B
	jle .end

	add $1, %r13
	add $1, %r12
	jmp .loop
.end:

	mov %r13, %rsi
	mov $.printFmt, %rdi
	call printf

	mov $0, %rax
	leave
	ret
 

 .readtFmt:
 	.string "%s"

 .printFmt:
 	.string "Length = %d\n"
