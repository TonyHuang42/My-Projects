#include "char_stack.h"

char_stack::char_stack(){
  top_index = -1;
} 

void char_stack::push(char item){
  top_index ++;
  str[top_index] = item;
}

char char_stack::top(){
  return str[top_index];
}

char char_stack::pop(){
  top_index --;
  return str[top_index + 1];
}

bool char_stack::empty(){
  return top_index == -1 ; 
}

int char_stack::size(){
	return top_index + 1;
}