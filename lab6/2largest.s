	.data

	.balign 4
format:	.asciz "%d %d" /* format to read numbers from stdin */

	.balign 4
printFormat: .asciz "%d\n"

	.text
	.global main
main:
	stmed sp!, {fp, lr} // Push the lr and fp onto the stack
	add fp, sp, #4 // set the fp to be last element pushed on stack
	// Therefore, at this point, sp points to first loc. for a local var.

	/* setup the registers to store the input */
	sub sp, sp, #4 // allocate memory for a 2nd local variable
	sub r1, fp, #4 // place address of 1st local var in r1
	sub r2, fp, #8 // place address of 2nd local var in r2
	ldr r0, =format // set address of format string to r0

	/* scan in the two numbers */
	bl scanf // scan in the 2 ints from stdin
	sub r1, fp, #4 // set r1 to point to 1st read value
	sub r2, fp, #8 // set r2 to point to 2nd read value
	ldr r1, [r1] // dereference r1
	ldr r2, [r2] // dereference r2
	
	/* print final output */
	ldr r0, =printFormat /* load print format */
	cmp r1, r2 // compare the 2 values
	movls r1, r2 // if r1 < r2, move r2 ro r1 so that r2 gets printed
	bl printf // print the largest value to the standard output

	mov r0, #0 // set return code to 0
	mov sp, fp // delete references to variable on the stack
	ldmfd sp!, {fp, pc} // pop return information from stack
	bx lr // return to the calling function

