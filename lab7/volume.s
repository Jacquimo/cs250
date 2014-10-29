	.text
	.global main
main:
	push {fp, lr}
	mov fp, sp

// Read the command line argument into r4 if possible
	cmp r0, #1
	movle r4, #0 // if there isn't a command arg, set channel to 0
	ble initial_setup // if no command arg, skip call to atoi

	// setup and call the atoi method
	ldr r0, [r1,#4] // get the 2nd string in argv array and put it in r0
	bl atoi
	mov r4, r0 // store the returned int value into r4

initial_setup:
// Push channel value onto stack
	sub sp, sp, #4
	str r4, [sp] // store the channel value onto 1st var on stack
	
// Setup wiringPi and return an error if it fails
	bl wiringPiSetup
	cmp r0, #-1
	beq ret_error // if the return < 0, return an error

// Call the init() function and end with an error if return < 0
	bl init
	cmp r0, #0
	blt ret_error

// Setup all of the GPIO pins
pin_setup:	
	// Use pinMode method to set LED gpio pins to "OUTPUT"
	mov r0, #29
	mov r1, #1
	bl pinMode
	mov r0, #3
	mov r1, #1
	bl pinMode
	mov r0, #25
	mov r1, #1
	bl pinMode
	mov r0, #28
	mov r1, #1
	bl pinMode

// Run the infinite loop here
	sub sp, sp, #4 // allocate var for return value of readADC
loop:
	// Call readADC method
	ldr r0, [fp, #-4] // get channel value from 1st stack var
	bl readADC

	// Adjust the reading to with 0-100 range and store it on the stack
	mov r1, #101
	mul r0, r0, r1 // multiply the reading by 100
	mov r0, r0, asr #10 // divide by 1024 through bit shifting (2^10)
	str r0, [fp, #-8] // store adjusted reading onto stack

	// Print the adjusted reading to stderr using fprintf
	ldr r0, =stderr
	ldr r0, [r0]
	ldr r1, =printfmt
	ldr r2, [fp, #-8] // load the reading from the stack
	bl fprintf

	// Light the appropriate LED's based on the reading
	/*ldr r0, [fp, #-8] // load adjusted reading from 2nd stack var
	cmp r0*/
	
	// Delay by 100 ms before reading again
	mov r0, #100
	bl delay

	b loop // return to the start of the loop
end_loop:	

ret_success:	
	mov r0, #0
return:
	mov sp, fp
	pop {fp, lr}
	bx lr

// This section is intentionally after the "main" return block
// This is so that, if execution operates normally, this block is
// never reached.
ret_error:
	mov r0, #1
	b return


	.section	.rodata
printfmt:	.asciz "%d\n"
	