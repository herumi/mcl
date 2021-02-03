all: low_test

CFLAGS=-I ../include/ -m32 -Ofast -Wall -Wextra -DNDEBUG

low_test: low_test.cpp
	$(CXX) -o low_test low_test.cpp $(CFLAGS)
