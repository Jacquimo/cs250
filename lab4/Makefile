all: main pwm

main: readWrite.c
	gcc -std=c99 -o main readWrite.c -lwiringPi

pwm: pwm.c
	gcc -std=c99 -o pwm pwm.c -lwiringPi -lpthread
    
clean: 
	rm -r *.o
