all : a0b

a0b: a0b.o  basic_int_stack.o
	g++ a0b.o basic_int_stack.o -o a0b

a0b.o: a0b.cpp
	g++ -c a0b.cpp

basic_int_stack.o: basic_int_stack.cpp
	g++ -c basic_int_stack.cpp

clean: 
	rm *o a0b