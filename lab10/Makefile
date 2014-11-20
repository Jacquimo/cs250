all:
	make largest
	make length
	make sumarray

largest: largest.s
	gcc  -o largest largest.s

length: length.s
	gcc -o length length.s

sumarray: sumarray.s
	gcc -o sumarray sumarray.s

clean: 
	rm -f largest
	rm -f length
	rm -f sumarray

