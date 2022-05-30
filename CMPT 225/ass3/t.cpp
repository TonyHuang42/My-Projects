#include <iostream> 
#include "btree_set.h"
#include <algorithm>
#include <ctime>
#include <time.h>
using namespace std;

double elapsed_time( clock_t start, clock_t finish){
   return (finish - start)/(double)(CLOCKS_PER_SEC/1000);
}

int main (int argc, char * const argv[]) {

	srand( time(NULL) );

	int *arr = new int [2000];
	for (int i = 0; i < 2000; i++)
		arr[i] = rand() % 1000;
	btree::btree_set<int,std::less<int>,std::allocator<int>,32> S1;
	for (int i = 0; i < 2000; i++)
		S1.insert(arr[i]);

	clock_t start, finish ;
	double insert_time = 0;
	start = clock();
	S1.insert(54);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S1.nodes() << endl;
	cout << "height: " << S1.height() << endl;
	cout << "average number of bytes used per data value: " << S1.bytes_used() / (2001) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S1.insert(564);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S1.nodes() << endl;
	cout << "height: " << S1.height() << endl;
	cout << "average number of bytes used per data value: " << S1.bytes_used() / (2002) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S1.insert(735);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S1.nodes() << endl;
	cout << "height: " << S1.height() << endl;
	cout << "average number of bytes used per data value: " << S1.bytes_used() / (2003) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S1.insert(861);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S1.nodes() << endl;
	cout << "height: " << S1.height() << endl;
	cout << "average number of bytes used per data value: " << S1.bytes_used() / (2004) << endl;
	cout << "insert time = " << insert_time << endl ;

	btree::btree_set<int,std::less<int>,std::allocator<int>,64> S2;
	for (int i = 0; i < 2000; i++)
		S2.insert(arr[i]);

	insert_time = 0;
	start = clock();
	S2.insert(54);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S2.nodes() << endl;
	cout << "height: " << S2.height() << endl;
	cout << "average number of bytes used per data value: " << S2.bytes_used() / (2001) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S2.insert(564);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S2.nodes() << endl;
	cout << "height: " << S2.height() << endl;
	cout << "average number of bytes used per data value: " << S2.bytes_used() / (2002) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S2.insert(735);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S2.nodes() << endl;
	cout << "height: " << S2.height() << endl;
	cout << "average number of bytes used per data value: " << S2.bytes_used() / (2003) << endl;
	cout << "insert time = " << insert_time << endl ;

	insert_time = 0;
	start = clock();
	S2.insert(861);
	finish = clock();
	insert_time += elapsed_time(start,finish);
	cout << "number of nodes: " << S2.nodes() << endl;
	cout << "height: " << S2.height() << endl;
	cout << "average number of bytes used per data value: " << S2.bytes_used() / (2004) << endl;
	cout << "insert time = " << insert_time << endl ;

    return 0;
}