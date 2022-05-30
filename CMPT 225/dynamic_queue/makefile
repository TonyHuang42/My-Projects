all : test

test: basic_int_queue.o  basic_int_queue_test.o int_node.o
	g++ -o test basic_int_queue.o  basic_int_queue_test.o int_node.o

int_node.o: int_node.cpp
	g++ -c int_node.cpp

basic_int_queue.o: basic_int_queue.cpp
	g++ -c basic_int_queue.cpp

basic_int_queue_test.o: basic_int_queue_test.cpp
	g++ -c basic_int_queue_test.cpp

clean: 
	rm *o test