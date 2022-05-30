class char_stack
{
  public:
    char_stack();
    void push(char item);
    char pop(); 
    char top();
    bool empty();
    int size();

  private:
    static const int capacity = 250000;
    char str[capacity];
    int top_index;
};