
	.globl main
main:
	enter $(8 * 6), $0 /* Save caller registers and allocate space on stack for function parameters and locals */

	mov $.readFmt, %rdi /* move format string into 1st parameter */

	/* Set callee saved registers to point to locations on the stack and scan the values in */
	mov %rbp, %rbx /* move the frame pointer into %rbx */
	add $-40, %rbx /* set register to point to 5th local var */
	mov %rbx, %r9 /* move the adjusted address pointer into %r9 */

	mov %rbp, %r15 /* move the frame pointer into %r15 */
	add $-32, %r15 /* set register to point to 4th local var */
	mov %r15, %r8 /* move the adjusted address pointer into %r8 */

	mov %rbp, %r12 /* move the frame pointer into %r12 */
	add $-8, %r12 /* set register to point to 1st local var */
	mov %r12, %rsi /* move the adjusted address pointer into %rsi */

	mov %rbp, %r13 /* move the frame pointer into %r13 */
	add $-16, %r13 /* set register to point to 2nd local var */
	mov %r13, %rdx /* move the adjusted address pointer into %rdx */

	mov %rbp, %r14 /* move the frame pointer into %r14 */
	add $-24, %r14 /* set register to point to 3rd local var */
	mov %r14, %rcx /* move the adjusted address pointer into %rcx */

	call scanf /* call scanf */

	/* Sum all of the input values */
	mov (%r12), %rax /* move dereferenced value of %r12 into accumulator */
	add (%r13), %rax /* add dereferenced value of %r13 into accumulator */
	add (%r14), %rax /* add dereferenced value of %r14 into accumulator */
	add (%r15), %rax /* add dereferenced value of %r15 into accumulator */
	add (%rbx), %rax /* add dereferenced value of %rbx into accumulator */

	/* Print Result */
	mov $.printFmt, %rdi /* move format string into 1st parameter */
	mov %rax, %rsi /* move result of summation into 2nd parameter */
	call printf /* print the result */

	/* Return */
	mov $0, %rax /* set return value to 0 */
	leave /* restore caller registers */
	ret /* return to calling function */


.readFmt:
	.string "%d %d %d %d %d"

.printFmt:
	.string "Sum = %d\n"
