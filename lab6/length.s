	.text
	.global main
main:
	// Initialize function call
	push {fp, lr} // push return variables onto the stack
	mov fp, sp // set the frame pointer to the stack pointer
	
	// Scan in the input
	sub sp, sp, #400 // allocate memory for a local variable
	mov r1, sp // set r1 to the location of sp
	ldr r0, =readfmt // load format string into r0
	bl scanf // call scanf and scan in the string from stdin
	
	// Initialize variables for loop
	mov r6, #0 // initialize counter variable "int i = 0"
break2:	mov r4, sp // set r4 to point to first character in string
	
	/* r3 = counter, r4 = location on stack, r5 = char*, r6 = ascii value
	Start the loop */
loop:
	// Get the next ascii value
	ldrb r5, [r4] // get the actual string pointer

	// Test ascii value by printing it out
	//ldr r0, =testing
	//mov r1, r5
	//bl printf	

	// If the ascii value is null, end the loop
	cmp r5, #0
	beq endloop
	
	// Update vars
	add r6, r6, #1 // update the counter variable
	add r4, r4, #1 // move pointer to next character

	// Return to the start of the loop
break1:	b loop
	
endloop:

	// Print output
	ldr r0, =printfmt // load format string into r0
	mov r1, r6 // load counter variable into r1
break3:	bl printf // print the output
	
	// Return to caller function
	mov sp, fp
	pop {fp, lr}
	bx lr


	.section	.rodata
readfmt:	.asciz "%99[^\n]"
printfmt:	.asciz "The length of the string is: %d\n"
testing:	.asciz "%c\n"

	