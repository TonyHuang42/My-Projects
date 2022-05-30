#include "Deque.h"
#include <iostream>
#include <cstring>
using namespace std;


Deque::Deque(){
	left_p = NULL;
	rear_p = NULL;
	current_size = 0;
	cursor = NULL;
}

Deque::Deque( const Deque& dq ){
	left_p = NULL;
	rear_p = NULL;
	current_size = 0;
	cursor = NULL;
	node* temp = dq.left_p;
	while(temp != NULL){
		push_right(temp -> data);
		if(temp == dq.cursor)
			cursor = rear_p;
		temp = temp -> next;
	}
}

Deque::~Deque(){
	cursor = left_p;
	while (cursor != NULL){
		left_p = left_p -> next;
		delete cursor;
		cursor = left_p;
	}
}

void Deque::push_left(int item){
	if (empty()){
		left_p = new node(item, NULL, NULL);
		rear_p = left_p;
		cursor = left_p;
	}
	else{
		left_p -> prev = new node(item, NULL, left_p);
		left_p = left_p -> prev;
	}
	current_size ++;
}

void Deque::push_right(int item){
	if (empty()){
		rear_p = new node(item, NULL, NULL);
		left_p = rear_p;
		cursor = rear_p;
	}
	else{
		rear_p -> next = new node(item, rear_p, NULL);
		rear_p = rear_p -> next;
	}
	current_size ++;
}

int Deque::pop_left(){
	int temp = left_p -> data;
	if(cursor == left_p)
		cursor = cursor -> next;
	node* old_left = left_p;
	left_p = left_p -> next;
	delete old_left;
	current_size --;
	if (empty())
		rear_p = NULL;
	else
		left_p -> prev = NULL;
	return temp;
}

int Deque::pop_right(){
	int temp = rear_p -> data;
	if(cursor == rear_p)
		cursor = cursor -> prev;
	node* old_rear = rear_p;
	rear_p = rear_p -> prev;
	delete old_rear;
	current_size --;
	if (empty())
		left_p = NULL;
	else
		rear_p -> next = NULL;
	return temp;
}

bool Deque::empty(){
	return current_size == 0;
}

int Deque::size(){
	return current_size;
}

bool Deque::cursor_left(){
	if (cursor -> prev != NULL){
		cursor = cursor -> prev;
		return true;
	}
	else
		return false;
}

bool Deque::cursor_right(){
	if (cursor -> next != NULL){
		cursor = cursor -> next;
		return true;
	}
	else
		return false;
}

int Deque::peek_left(){
	return left_p -> data;
}

int Deque::peek_right(){
	return rear_p -> data;
}

int Deque::get_cursor(){
	return cursor -> data;
}

void Deque::set_cursor(int i){
	cursor -> data = i;
}

void Deque::display(){
	node* temp = left_p;
	cout << '[';
	while(temp != NULL){
		cout << temp -> data << ';';
		temp = temp -> next;
	}
	cout << "] size=" << size() << ", cursor=";
	if (cursor == NULL)
		cout << "NULL." << endl;
	else
		cout << get_cursor() << '.' << endl;
}

void Deque::verbose_display(){
	node* temp = left_p;
	cout << "\ndata\taddress\n" << endl;
	while(temp != NULL){
		cout << temp -> data << '\t' << &(*temp) << endl;
		temp = temp -> next;
	}
	if (empty())
		cout << "\nleft_p = NULL; rear_p = NULL; cursor = NULL;" << endl;
	else
		cout << "\nleft_p = " << peek_left() << "; rear_p = " << peek_right() << "; cursor = " << get_cursor() << ";" << endl;
}