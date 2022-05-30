all: test

test: basic_int_stack.o basic_int_stack_test.o
	g++ -o test basic_int_stack.o basic_int_stack_test.o

basic_int_stack.o: basic_int_stack.cpp
	g++ -c basic_int_stack.cpp
basic_int_stack_test.o: basic_int_stack_test.cpp
	g++ -c basic_int_stack_test.cpp 

clean:
	rm *o test