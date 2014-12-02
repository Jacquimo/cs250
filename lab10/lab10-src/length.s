
	.globl main
main:
	enter $(8 * 502), $0 /* Save caller registers and allocate space on stack for function parameters and locals */

	/* Get address on stack with which to pass to scanf */
	mov %rsp, %r12 /* store the value of the stack pointer (edge of allocated space) into %r12 */
	mov %r12, %rsi /* move stack location in %r12 to 2nd parameter */

	mov $.readtFmt, %rdi /* move address of format string into 1st parameter */
	call scanf /* call scanf */

	/* Loop through the string to determine its length */
	mov $0, %r13 /* initialize counter variable */
.loop:
	mov (%r12), %r14 /* dereference string pointer and store value in %r14 */
	cmp $0, %r14B /* test if character value is NULL '\0', 0 */
	jle .end /* if we have reached the null-termination of the string, jump to the end of the loop */

	add $1, %r13 /* increment counter variable */
	add $1, %r12 /* increment string pointer */
	jmp .loop /* jump to start of loop */
.end:

	mov %r13, %rsi /* move the counter variable into the 2nd parameter */
	mov $.printFmt, %rdi /* move the format string into the 1st parameter */
	call printf /* call printf */

	mov $0, %rax /* move 0 into the return register */
	leave /* restore the caller registers */
	ret /* return to calling function */
 

 .readtFmt:
 	.string "%s"

 .printFmt:
 	.string "Length = %d\n"
