all:
	make endian
	make sections
	make memdump

endian: endian.c
	gcc -o endian endian.c

sections: sections.c
	gcc -o sections sections.c

memdump: memdump.c
	gcc -o memdump memdump.c

clean:
	$(RM) endian
	$(RM) sections
	$(RM) memdump

