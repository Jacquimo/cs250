	.data

	.balign 4
format:	.asciz "%d %d" /* format to read numbers from stdin */

	.balign 4
printFormat: .asciz "%d\n"

	.balign 4
num1:	.word 0

	.balign 4
num2:	.word 0
	

	.text
	.global main
main:
	stmfd sp!, {fp, lr} /* Push the lr and fp onto the stack */
	add fp, sp, #4 /* set the frame pointer to be 1 byte higher than the stack pointer on the stack */

	ldr r0, =format /* load format for scanf */
	ldr r1, =num1 /* load location to store first number */
	ldr r2, =num2 /* load location to store second number */
	bl scanf /* call scanf function */

	/* this code ran a test for an error I was having
	ldr r0, =printFormat
	ldr r1, =num1
	ldr r2, =num2
	ldr r1, [r1]
	ldr r2, [r2]
	bl printf */

	/* load the values just scanned into registers 1 and 2 */
	ldr r1, =num1
	ldr r2, =num2
	ldr r1, [r1]
	ldr r2, [r2]

	ldr r0, =printFormat /* load print format */
	cmp r1, r2 
	movls r1, r2 /* if r1 < r2, move r2 ro r1 so that r2 gets printed */
	bl printf

	mov r0, #0
	ldmfd sp!, {fp, pc} /* pop return information from stack */
	bx lr /* return to the calling function */

