	.text
	.global main
main:
	stmed sp!, {fp, lr} // push return info onto stack
	add fp, sp, #4 // set fp to be 1 byte above sp on stack

	sub r1, fp, #4 // set r1 to point to first local variable
	ldr r0, =readFormat // set r0 to format string
	bl scanf // scan in the value
	sub r1, fp, #4 // set r1 to point to the newly read string

	/* ldr r0, =printFormat
	sub r1, fp, #4
	bl printf */

	//ldr r0, =testString
	//bl printf


	mov r2, #0 // initialize a counter variable in r2
loop:	
	//add r1, r1, #1 // increment r1 to the next character
	//ldr r1, [[r1]] // get the character value at the start of the string
	//ldr r0, =testFormat
	//bl printf
	
	ldr r3, [r1] // assign character value in string to r3
	//ldr r3, [r3]
	cmp r3, #0 // check to see if it's the null character
break1:	
	beq endloop // if the condition is met, end the loop

	// test the values
	//mov r4, r1
	//mov r1, r3
	//ldr r0, =testFormat
	//bl printf
	//mov r1, r4
	
	add r2, r2, #1 // increment the counter by 1
	add r1, r1, #1 // increment pointer to next character
	b loop // branch back to the start of the loop
	
endloop: 

	// At this point, we have looped over the entire string
	mov r1, r2 // move the value in the counter to r1
	ldr r0, =printFormat // set r0 to the format string
	bl printf

	// Call memdump to find my errors
	//mov r0, sp // set r0 to point to the stack pointer
	//mov r1, #64 // set length for memdump
	//bl memdump
	
	// prepare for returning to caller function
	mov sp, fp
	ldmfd sp!, {fp, pc}
	bx lr


	.section	.rodata
readFormat:	.asciz "%s"
printFormat:	.asciz "The length of the string is %d\n"
testFormat:	.asciz "%c\n"
testString:	.asciz "%s\n"

