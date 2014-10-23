.data


.text

.global main

main:
	str lr, [sp, #-4]!

	



	
	/*End of main, return */
	ldr lr, [sp], #+4
	bx lr
