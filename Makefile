DIR := masm

all: assemble_prog output build test

assemble_prog:
	cd $(DIR) && $(MAKE)

output: my_new_microcode.mc
	./mcc < my_new_microcode.mc > prom_new.dat

build:
	./masm/masm < a4_rshift_test.asm > rshift.obj
	./masm/masm < a4_mult_test.asm > mult.obj
	./masm/masm < a4_div_test.asm > div.obj

test:
	./mic1 prom_new.dat rshift.obj 0 512 < rshift.in > output.out || true
	./mic1 prom_new.dat mult.obj 0 512 < mult.in > output.out || true

clean:
	rm prom_new.dat *.obj
	cd $(DIR) && make clean
