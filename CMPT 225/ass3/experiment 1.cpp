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
	for (int i = 0; i < 2000; i++){
		arr[i] = rand() % 1000;
	}

	clock_t start, finish ;
	double insert_time = 0;
	btree::btree_set<int,std::less<int>,std::allocator<int>,2000> S ;
	start = clock();
	for (int i = 0; i < 2000; i++){
		S.insert(arr[i]);
	}
	finish = clock();
	insert_time += elapsed_time(start,finish);

	cout << "insert time = " << insert_time << endl ;

    return 0;
}