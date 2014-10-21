all:
	make test1
	make largest
	make 2largest
	make length

test1: test1.s
	gcc -o test1 test1.s

largest: largest.s
	gcc -o largest largest.s

2largest: 2largest.s
	gcc -o 2largest 2largest.s

length: length.s
	gcc -o length length.s

clean:
	$(RM) test1
	$(RM) largest
	$(RM) 2largest
	$(RM) length


