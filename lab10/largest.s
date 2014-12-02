
	.globl main
main:
	enter $(8 * 2), $0

	movq $.readFmt, %rdi /* move the format string into the first parameter location */
	
	/* Set scanf parameters to point to 1st and 2nd locations on the stack */
	// First Parameter 
	mov %rbp, %r13 /* move address of base pointer to r13 */
	add $-8, %r13 /* set r13 to point 1 location backwards */
	mov %r13, %rsi /* move updated address to 2nd parameter */
	// Second Parameter 
	mov %rbp, %r14 /* move address of base pointer to r14 */
	add $-16, %r14 /* set r14 to point 2 locations backwards */
	mov %r14, %rdx /* move updated address to 3rd parameter */

	call scanf /* Call the scanf function to readin the variable */

	/* Check to see which read value is larger */
	movslq (%r13), %rsi /* move first readin value to %rsi, to minimizes compares and moving registers around */
	movslq (%r14), %r15 /* move second readin value to %r15 */

	cmp %r15, %rsi /* compare %r15 and %rsi */
	jg .print /* if %rsi is larger, immediately jump to the printing step */
	mov %r15, %rsi /* if %r15 >= to %rsi, then move %r15 into %rsi (to setup the call to printf) */

	/* Print the result to stdout */
.print:
	mov $.printFmt, %rdi /* move the format string into first parameter */
	call printf /* call printf */

	mov $0, %rax /* set the return to 0 */
	leave /* restore the caller registers */
	ret /* return to caller */


.readFmt:
	.string "%d %d"

.printFmt:
	.string "%d\n"
