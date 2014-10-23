	.text
	.global main
main:
	// Save return variables
	push {r4-r9, fp, lr}
	mov fp, sp

	sub sp, sp, #20 // allocate 5 locals on the stack
	ldr r0, =readfmt
	sub r1, fp, #4
	sub r2, fp, #8
	sub r3, fp, #12

	// Store the stack variables
	add r4, sp, #4
	str r4, [sp, #4]
	mov r5, sp
	str r5, [sp]

	// Scan in the values
	bl scanf

	// Retrieve scanned values from memory
	ldr r4, [fp, #-4]
	ldr r5, [fp, #-8]
	ldr r6, [fp, #-12]
	ldr r7, [fp, #-16]
	ldr r8, [fp, #-20]

	// Sum the values and print them
	add r1, r4, r5
	add r1, r1, r6
	add r1, r1, r7
	add r1, r1, r8
	ldr r0, =printfmt
	bl printf

	// Return to caller
	mov r0, #0
	mov sp, fp
	pop {r4-r9, fp, lr}
	bx lr


	.section	.rodata
readfmt:	.asciz "%d %d %d %d %d"
printfmt:	.asciz "Sum: %d\n"

	