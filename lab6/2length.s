	.text
	.global main
main:
	// Initialize function call
	push {fp, lr} // push return variables onto the stack
	mov fp, sp // set the frame pointer to the stack pointer

	// Scan in the input
	sub sp, sp, #4 // allocate memory for a local variable
	sub r1, fp, #4 // set r1 to point to first local variable
	ldr r0, =readfmt // load format string into r0
	bl scanf // call scanf and scan in the string from stdin

	// Initialize variables for loop
	sub r4, fp, #4 // set r4 to point to first local var
	mov r3, #0 // initialize counter variable "int i = 0"

	/* r3 = counter, r4 = location on stack, r5 = char*, r6 = ascii value
	Start the loop */
loop:
	// Get the next ascii value
	ldr r5, [r4] // get the actual string pointer
//break1:	ldr r6, [r5] // get the ascii character value
break1:	mov r6, r5 // ???? get derferenced ascii value, maybe ????

	// Test ascii value
	ldr r0, =testing
	mov r1, r5
	bl printf
	

	// If the ascii value is null, end the loop
	cmp r6, #0
	beq endloop

	// Update vars
	add r3, r3, #1 // update the counter variable
	add r5, r5, #1 // update str pointer in register
	str r5, [r4] // update str pointer on stack

	// Return to the start of the loop
	b loop
	
endloop:

	// Print output
	ldr r0, =printfmt // load format string into r0
	mov r1, r3 // load counter variable into r1
	bl printf // print the output
	
	// Return to caller function
	pop {fp, lr}
	bx lr


	.section	.rodata
readfmt:	.asciz "%s"
printfmt:	.asciz "The length of the string is %d\n"
testing:	.asciz "%c\n"

	