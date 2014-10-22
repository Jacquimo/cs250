	.text
	.global main
main:
	push {fp, lr}
	mov fp, sp // set the fp to be the same as the sp

	// Initialize vars for call to scanf
	sub sp, sp, #20 // allocate room on the stack for 5 ints
	ldr r0, =readfmt // assign format string to r0

	sub r1, fp, #16 // set r1 to point to 4th var on stack
	str r1, [fp, #-16] // store pointer to 4th local var in 4th local var. This is so the 4th number will be stored properly
	sub r1, fp, #4 // set r1 to point to 1st local var
	
	sub r2, fp, #20 // set r2 to point to 5th local var
	str r2, [fp, #-20] // set 2nd local to point to 5th local
	sub r2, fp, #8 // set r2 to point to 2nd local
	sub r3, fp, #12 // set r3 to point to 3rd local

	bl scanf

	// Load registers with corresponding locals from stack
	ldr r1, [fp, #-4]
	ldr r2, [fp, #-8]
	ldr r3, [fp, #-12]
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-20]

	// Sum all of the register values into r10
	add r10, r1, r2
	add r10, r10, r3
	add r10, r10, r4
	add r10, r10, r5

	mov r1, r10
	ldr r0, =fmt
	bl printf

	// Return to caller function
	mov r0, #0 // set return code to 0
	mov sp, fp // delete all local vars
	pop {fp, lr}
	bx lr
	

	.section	.rodata
readfmt:	.asciz "%d %d %d %d %d"
printfmt:	.asciz "%d %d %d %d %d\n"
fmt:		.asciz "Sum of numbers: %d\n"
	