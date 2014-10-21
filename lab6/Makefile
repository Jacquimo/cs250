all:
	make largest
	make 2largest
	make length

largest: largest.s
	gcc -o largest largest.s

2largest: 2largest.s
	gcc -o 2largest 2largest.s

length: length.s
	gcc -o length length.s

clean:
	$(RM) largest
	$(RM) 2largest
	$(RM) length


