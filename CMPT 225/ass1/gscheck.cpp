#include <iostream>
#include "char_stack.h"
using namespace std;

bool match(char l, char c){
	if (l == '('){
		if (c == ')')
			return true;
	}
	if (l == '['){
		if (c == ']')
			return true;
	}
	if (l == '{'){
		if (c == '}')
			return true;
	}
	return false;
}

char r(char l){
	if (l == '(')
		return ')';
	if (l == '[')
		return ']';
	if (l == '{')
		return '}';
	return l;
}

void print_error(char *input, int index){
	int tab = 0;
	for (int i = 0; i <= index; i++){
		if (input [i] == '\t')
			tab ++;
		cout << input[i];
	}
	cout << endl;
	for (int i = 0; i < tab; i++)
		cout << "\t";
	for (int i = tab; i <= index; i++)
		cout << " ";
	for (int i = index + 1; input[i] != '\0'; i++)
		cout << input[i];
	cout << endl;
}

int main (int argc, char * const argv[]){
	char_stack S;
	char end;
	char *input = new char[251];
	cin.getline(input, 251);
	int line = 1;
	do{
		int index = 0;
		while (input[index] != '\0'){
			char c = input[index];
			if (c == '(' || c == '[' || c == '{'){
				S.push(c);
			}

			else if (c == ')' || c == ']' || c == '}'){
				if (S.empty()){
					cout << "Error on line " << line << ": Too many " << c << endl;
					print_error(input, index);
					return 0;
				}

				char l = S.pop();

				if (!match(l, c)){
					cout << "Error on line " << line << ": Read " 
					<< c << " , expected " << r(l) << endl;
					// here, r is the closing symbol matching l
					print_error(input, index);
					return 0;
				}
			}
			index++;
		}

		end = cin.peek();
		line ++;
		delete input;
		char *input = new char[251];
		cin.getline(input, 251);
	} while(end != -1);

	if (!S.empty()){
		char ch = S.pop();
		cout << "Error at end of file: Too many " << ch << endl;
		return 0;
	}

	cout << "No Errors Found" << endl;
	return 0;
}