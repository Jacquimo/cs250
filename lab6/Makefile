all:
	make largest
	make 2largest
	make length
	make sumarray

largest: largest.s
	gcc -o largest largest.s

2largest: 2largest.s
	gcc -o 2largest 2largest.s

length: length.s
	gcc -o length length.s

sumarray: sumarray.s
	gcc -o sumarray sumarray.s

clean:
	$(RM) largest
	$(RM) 2largest
	$(RM) length
	$(RM) sumarray


