	.text
	.global main

main:
	// Save the return variables
	push {fp, lr}
	mov fp, sp

	// Read the input nums onto the stack
	sub sp, sp, #8 // allocate 2 vars on the stack
	ldr r0, =readfmt // load format string
	sub r1, fp, #4 // point r1 to 1st local
	sub r2, fp, #8 // point r2 to 2nd local
	bl scanf

	// Load scanned values into r1 and r2
	ldr r1, [fp, #-4] // load value of 1st local into r1
	ldr r2, [fp, #-8] // load value of 2nd local into r2

	// Put greater number into r1
	cmp r1, r2
	movlt r1, r2 // if r1 < r2, then move the value over

	// Print greater value
	ldr r0, =printfmt
	bl printf

	// Return to caller
	mov r0, #0
	mov sp, fp
	pop {fp, lr}
	bx lr


	.section	.rodata
readfmt:	.asciz "%d %d"
printfmt:	.asciz "%d\n"

	