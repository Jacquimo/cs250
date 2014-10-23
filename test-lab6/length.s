	.text
	.global main
main:
	// Preserve return variables
	push {fp, lr}
	mov fp, sp

	// Read in the string from stdin
	sub sp, sp, #400
	mov r1, sp
	ldr r0, =readfmt
	bl scanf

	mov r1, sp
	mov r5, #0 // initialize counter variable
loop:
	ldrb r6, [r1] // load ascii value into r6
	cmp r6, #0
	beq endloop

	// Else, the null terminator hasn't bee reached
	add r5, r5, #1
	add r1, r1, #1
	b loop
	
endloop:

	// Print output
	ldr r0, =printfmt
	mov r1, r5
	bl printf

	// Return to caller
	mov r0, #0
	mov sp, fp
	pop {fp, lr}
	bx lr


	.section .rodata
readfmt:	.asciz "%99[^\n]"
printfmt:	.asciz "Length of string: %d\n"
	