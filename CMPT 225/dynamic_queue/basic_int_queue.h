#include "int_node.h"

class basic_int_queue
{
  public:
    basic_int_queue();
    void enqueue( int item );
    int dequeue(); 
    int front();
    bool empty();
    int size();

  private:
    int_node *front_ptr;
    int_node *rear_ptr;
    int current_size;
};