all: low_test

CFLAGS=-I ../include/ -m32 -Ofast -Wall -Wextra -DNDEBUG

low_test: low_test.cpp ../src/low_func_wasm.hpp
	$(CXX) -o low_test low_test.cpp $(CFLAGS)
