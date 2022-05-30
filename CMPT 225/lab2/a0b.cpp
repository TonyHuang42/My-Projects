#include <iostream>   // for I/O facilities
#include "basic_int_stack.h" //  basic_int_stack declarations
using namespace std;

int main (int argc, char * const argv[]) {
   cout << "Zhixin Huang\nzha48\n301326521\n";
   Basic_int_stack s;
   int input, sum = 0;
   cin >> input;
   while (input >= 0) {
   	 s.push (input);
   	 sum += input;
   	 cin >> input;
   	}
   	cout << endl
   	<< "length: " << s.size() << endl
   	<< "sum: " << sum << endl << endl;
   	while(!s.empty()){
   		cout << s.pop() << endl;
   	}
   	cout << "goodbye" <<endl;

	    return 0;
}