	.text

	.global main

main:
	str lr, [sp, #-4]! // store lr 1 above the starting sp
	add fp,sp,#4
	sub sp,sp,#4
	
	//push {r0-r3}
	//ldr r0, =printfmt
	ldr r1, [r1,#4]
	str r1, [sp]
	//bl printf
	//pop {r0-r3}

	/* if(wiringPiSetup() == -1)
		return 1; */
	// If wiringPiSetup func returns -1, return 1
	push {r0-r3} // save the potential arguments on the stack
	bl wiringPiSetup
	cmp r0, #-1
	beq retErr_Fix_State

	/*if(init() < 0)
		return 1; exit with error
	*/
	// If the init func returns < 0, end program with error
	bl init
	cmp r0, #0
	blt retErr_Fix_State

	/*int chan = 0;
	if(argc > 1)
		chan = atoi(argv[1]);*/
	
	// If there is a command line argument, read it and store as int
	pop {r0-r3} // Restore command line arguments
brk2:	cmp r0, #1
	movlt r4, #0 // if there's no args, set arg value to 0
	blt setPinModes
	// Otherwise, store the command arg as an int
	mov r4, r1
	//ldr r0, [r4, #4] // access the value of argv[1]

	

	// Read in the command line argument
	//ldr r0, [r4, #4] // get the string command arg
	//add r0, r4, #4
	//ldr r0, [sp]

	//ldr r1, [r1, #4]
	//str r1, [sp]
	//ldr r0, [sp]
brk4:	//bl atoi
brk1:	mov r4, r0
	
	/*
	pinMode(FIRST, OUTPUT);
	pinMode(SECOND, OUTPUT);
	pinMode(THIRD, OUTPUT);
	pinMode(FOURTH, OUTPUT);

	#define FIRST 29
	#define SECOND 3
	#define THIRD 25
	#define FOURTH 28
	*/
	// Set all the gpio pins
setPinModes:
	// Use pinMode method to set LED gpio pins to output
brk3:	mov r0, #29
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

	//while(1){
		// ********** Do not change **********/
		/*int reading = readADC(chan);
		reading *= 100;
		reading /= 1023;
		
		fprintf(stderr, "%d\n", reading); */
		// ***********************************/

	// Start of infinite loop
loop:
	/*ldr r0, =printfmt
	mov r1, r4
	bl printf*/
	
	// Read in the analog value 
	mov r0, r4
	bl readADC
	mov r4, r0

	// Adjust analog value so that it's within 0-100 range, inclusive
	mov r5, #100
	mul r4, r4, r5 // multiply analog value by 100
	// divide analog value by 1023
	ldr r5, =mult_inv_1023
	ldr r5, [r5]
	//ldr r5, .mult_inv_1023

	/*ldr r0, =printfmt
	mov r1, r5
	bl printf*/
	
	/*smull r5, r6, r5, r4 // multiply r4 by mult. inv. of 1023
	add r6, r6, r4
	mov r4, r4, asr #31
	rsb r4, r4, r6, asr #9*/

	

	//mul r4, r4, r5
	
	

	//umull r5, r6, r4, r5
	//mov r4, r6

	// Print to standard error through system call
	ldr r0, =stderr
	ldr r0, [r0]
	ldr r1, =printfmt
	mov r2, r4
	bl fprintf

	mov r0, #100
	bl delay
	
	b loop
endloop:
	// End of loop. This is more here forcode symmetry	
	
	// Program has run successfully, end the program
	mov r0, #0
	b return

retErr_Fix_State:
	pop {r0-r3}
	b retErr

retErr:
	ldr r0, =perr
	bl printf
	mov r0, #1
	b return
	
	/*End of main, return */
return:	ldr lr, [sp], #+4
	bx lr


	.section	.rodata
printfmt:	.asciz "%s\n"
perr:		.asciz "There was an error\n"
// next address is used to calculate unsigned division by 1023
mult_inv_1023:	.word 0x80200803
	
