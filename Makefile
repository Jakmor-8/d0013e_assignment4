FILE = division.s

all:
	sde-as -march=r3k -O0 $(FILE) -o test.o
	sde-ld -T linker_script test.o -o a.out
	sde-objdump -h -z -s -d -t a.out > mips_ext_program.objdump
	rm a.out test.o
