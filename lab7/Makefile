all: c arm

c: volume.c
	gcc -std=c99 -o c volume.c -lwiringPi -L. -ladc

arm: volume.s
	gcc -std=c99 -o arm volume.s -lwiringPi -L. -ladc

clean: 
	rm -r c
	rm -r arm
