
	.globl main
main:
	enter $(8 * 6), $0

	mov $.readFmt, %rdi

	/* Set callee saved registers to point to locations on the stack */
	mov %rbp, %rbx
	add $-40, %rbx
	mov %rbx, %r9

	mov %rbp, %r15
	add $-32, %r15
	mov %r15, %r8

	mov %rbp, %r12
	add $-8, %r12
	mov %r12, %rsi

	mov %rbp, %r13
	add $-16, %r13
	mov %r13, %rdx

	mov %rbp, %r14
	add $-24, %r14
	mov %r14, %rcx

	call scanf

	/* Sum all of the input values */
	mov (%r12), %rax
	add (%r13), %rax
	add (%r14), %rax
	add (%r15), %rax
	add (%rbx), %rax

	mov $.printFmt, %rdi
	mov %rax, %rsi
	call printf

	mov $0, %rax
	leave
	ret


.readFmt:
	.string "%d %d %d %d %d"

.printFmt:
	.string "Sum = %d\n"
