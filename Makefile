floatDivision: floatDivision.o
	gcc -m64 -o floatDivision floatDivision.o
floatDivision.o: floatDivision.asm
	nasm -g -f elf64 -l floatDivision.lst floatDivision.asm
clean:
	rm -rf *.o
run:
	./floatDivision
