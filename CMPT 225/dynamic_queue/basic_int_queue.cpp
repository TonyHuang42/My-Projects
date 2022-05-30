#include <cstring>
#include "basic_int_queue.h"

basic_int_queue::basic_int_queue(){
  front_ptr = NULL;
  rear_ptr = NULL;
  current_size = 0 ;
} 

void basic_int_queue::enqueue( int item ){
  if (empty()){
  	front_ptr = new int_node(item, NULL);
  	rear_ptr = front_ptr;
  }
  else {
    rear_ptr -> next = new int_node(item, NULL);
    rear_ptr = rear_ptr -> next;
  }
  current_size ++;
}

int basic_int_queue::dequeue(){
  int temp = front_ptr -> data;
  int_node *old_front = front_ptr;
  front_ptr = front_ptr -> next;
  delete old_front;
  current_size --;
  if (empty())
  	rear_ptr = NULL;
  return temp;
}

bool basic_int_queue::empty(){
  return current_size == 0 ;
}

int basic_int_queue::front(){
  return front_ptr -> data;
}

int basic_int_queue::size(){
  return current_size;
}