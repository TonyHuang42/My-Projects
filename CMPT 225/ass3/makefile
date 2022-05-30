all: t

t: t.o 
	g++ -std=c++11 -o t t.o 

t.o: t.cpp btree_set.h 
	g++ -std=c++11 -c t.cpp

clean:
	rm -f t *.o

