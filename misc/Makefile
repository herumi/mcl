all: low_test

CFLAGS_WASM=-I ../include/ -O2 -Wall -Wextra -DNDEBUG -DMCL_SIZEOF_UNIT=4 -DMCL_WASM32
CFLAGS=-I ../include/ -O2 -Wall -Wextra -DNDEBUG

low_test: low_test.cpp ../src/low_func.hpp
	$(CXX) -o low_test low_test.cpp $(CFLAGS_WASM) -m32

sqr.h: gen.py
	python3 $< > $@

sqr_test.exe: sqr_test.cpp sqr.h
	$(CXX) -o $@ $< $(CFLAGS_WASM) -lgmp -lgmpxx

sqr_test: sqr_test.exe
	./sqr_test.exe

gen_test_asm.asm: gen_test.py
	python3 gen_test.py -m nasm > $@

gen_test_asm.o: gen_test_asm.asm
	nasm -f elf64 $<

gen_test.o: gen_test.cpp
	$(CXX) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

gen_test.exe:  gen_test_asm.o gen_test.o
	$(CXX) -o $@ $^ ../lib/libmcl.a

gen_test: gen_test.exe
	./gen_test.exe

clean:
	$(RM) sqr_test.exe sqr.h *.o *.exe gen_test_asm.asm
