#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <assert.h>
#include "mymem.h"
#include <time.h>


/* The main structure for implementing memory allocation.
 * You may change this to fit your implementation.
 */

struct memoryList
{
  // doubly-linked list
  struct memoryList *last;
  struct memoryList *next;

  int size;            // How many bytes in this block?
  char alloc;          // 1 if this block is allocated,
                       // 0 if this block is free.
  void *ptr;           // location of block in memory pool.
};

strategies myStrategy = NotSet;    // Current strategy


size_t mySize;
void *myMemory = NULL;

static struct memoryList *head;
static struct memoryList *next;


/* initmem must be called prior to mymalloc and myfree.

   initmem may be called more than once in a given exeuction;
   when this occurs, all memory you previously malloc'ed  *must* be freed,
   including any existing bookkeeping data.

   strategy must be one of the following:
		- "best" (best-fit)
		- "worst" (worst-fit)
		- "first" (first-fit)
		- "next" (next-fit)
   sz specifies the number of bytes that will be available, in total, for all mymalloc requests.
*/

void initmem(strategies strategy, size_t sz)
{
	myStrategy = strategy;

	/* all implementations will need an actual block of memory to use */
	mySize = sz;

	if (myMemory != NULL) free(myMemory); /* in case this is not the first time initmem2 is called */

	 //TODO: release any other memory you were using for bookkeeping when doing a re-initialization! 
	if (head != NULL) free(head);

	myMemory = malloc(sz);
	
	/* TODO: Initialize memory management structure. */
	head = malloc(sizeof(struct memoryList));
	head -> size = sz;
	head -> alloc = 0;
	head -> ptr = myMemory;

	head -> last = head;
	head -> next = head;
	next = head;
}



/* Allocate a block of memory with the requested size.
 *  If the requested block is not available, mymalloc returns NULL.
 *  Otherwise, it returns a pointer to the newly allocated block.
 *  Restriction: requested >= 1 
 */

void *mymalloc(size_t requested)
{
	assert((int)myStrategy > 0);
	struct memoryList *pointer = NULL;
	struct memoryList *alloc_block = NULL;
	
	switch (myStrategy)
	  {
	  case NotSet: 
	    return NULL;

	  case First:
	  	pointer = head;
	  	do{
	  		if (pointer -> alloc == 0 && pointer -> size >= requested){
	  			alloc_block = pointer;
	  			break;
	  		}
	  		pointer = pointer -> next;
	  	}while(pointer != head);
	  	break;

	  case Best:
	    pointer = head;
	    int min_size = mySize +1;
	    do{
	  		if (pointer -> alloc == 0 && pointer -> size >= requested && pointer -> size < min_size){
	  			min_size = pointer -> size;
	  			alloc_block = pointer;
	  		}
	  		pointer = pointer -> next;
	    }while(pointer != head);
	    break;

	  case Worst:
	    pointer = head;
	    int max_size = 0;
	    do{
	  		if (pointer -> alloc == 0 && pointer -> size >= requested && pointer -> size > max_size){
	  			max_size = pointer -> size;
	  			alloc_block = pointer;
	  		}
	  		pointer = pointer -> next;
	    }while(pointer != head);
	    break;

	  case Next:
	    pointer = next;
	    do{
	  		if (pointer -> alloc == 0 && pointer -> size >= requested){
	  			alloc_block = pointer;
	  			next = pointer -> next;
	  			break;
	  		}
	  		pointer = pointer -> next;
	  	}while(pointer != next);
	  	break;
	  }

	if (alloc_block == NULL)
		return NULL;

	else{
		if (alloc_block -> size > requested){
			struct memoryList *new_block = malloc(sizeof(struct memoryList));
			new_block -> size = alloc_block -> size - requested;
			new_block -> alloc = 0;
			new_block -> ptr = alloc_block -> ptr + requested;

			new_block -> next = alloc_block -> next;
			new_block -> last = alloc_block;
			new_block -> next -> last = new_block;

			alloc_block -> size = requested;
			alloc_block -> next = new_block;

			if (myStrategy == Next)
				next = new_block;
		}

		alloc_block -> alloc = 1;
		return alloc_block -> ptr;
	}
}


/* Frees a block of memory previously allocated by mymalloc. */
void myfree(void* block)
{
	struct memoryList *pointer = head;
	do{
		if (pointer -> ptr == block)
			break;
		pointer = pointer -> next;
	}while(pointer != head);

	if (pointer -> next -> alloc == 0 && pointer -> next != head){
		if (myStrategy == Next && next == pointer -> next)
			next = pointer;

		pointer -> size = pointer -> size + pointer -> next -> size;
		pointer -> next = pointer -> next -> next;
		pointer -> next -> last = pointer;
	}

	if (pointer -> last -> alloc == 0 && pointer != head){

		if (myStrategy == Next && next == pointer)
			next = pointer -> last;

		pointer = pointer -> last;

		pointer -> size = pointer -> size + pointer -> next -> size;
		pointer -> next = pointer -> next -> next;
		pointer -> next -> last = pointer;
	}

	pointer -> alloc = 0;
}


/****** Memory status/property functions ******
 * Implement these functions.
 * Note that when we refer to "memory" here, we mean the 
 * memory pool this module manages via initmem/mymalloc/myfree. 
 */

/* Get the number of contiguous areas of free space in memory. */
int mem_holes()
{
	int count = 0;
	struct memoryList* pointer = head;
	do {
		if (pointer -> alloc == 0)
			count++;
		pointer = pointer -> next;
	} while(pointer != head);
	return count;
}

/* Get the number of bytes allocated */
int mem_allocated()
{
	int count = 0;
	struct memoryList *pointer = head;
	do {
		if (pointer -> alloc == 1)
			count += pointer -> size;
		pointer = pointer -> next;
	} while(pointer != head);
	return count;
}

/* Number of non-allocated bytes */
int mem_free()
{
	int count = 0;
	struct memoryList *pointer = head;
	do {
		if (pointer -> alloc == 0)
			count += pointer -> size;
		pointer = pointer -> next;
	} while(pointer != head);
	return count;
}

/* Number of bytes in the largest contiguous area of unallocated memory */
int mem_largest_free()
{
	int max = 0;
	struct memoryList *pointer = head;
	do {
		if (pointer -> alloc == 0){
			if (pointer -> size > max)
				max = pointer -> size;
		}
		pointer = pointer -> next;
	} while(pointer != head);
	return max;
}

/* Number of free blocks smaller than "size" bytes. */
int mem_small_free(int size)
{
	int count = 0;
	struct memoryList *pointer = head;
	do {
		if (pointer -> alloc == 0){
			if (pointer -> size <= size)
				count++;
		}
		pointer = pointer -> next;
	} while(pointer != head);
	return count;
}       

char mem_is_alloc(void *ptr)
{
	struct memoryList *pointer = head;
	do {
		if (pointer -> ptr >= ptr)
			return pointer -> alloc;
		pointer = pointer -> next;
	} while(pointer != head);
	return 0;
}


/* 
 * Feel free to use these functions, but do not modify them.  
 * The test code uses them, but you may ind them useful.
 */


//Returns a pointer to the memory pool.
void *mem_pool()
{
	return myMemory;
}

// Returns the total number of bytes in the memory pool. */
int mem_total()
{
	return mySize;
}


// Get string name for a strategy. 
char *strategy_name(strategies strategy)
{
	switch (strategy)
	{
		case Best:
			return "best";
		case Worst:
			return "worst";
		case First:
			return "first";
		case Next:
			return "next";
		default:
			return "unknown";
	}
}

// Get strategy from name.
strategies strategyFromString(char * strategy)
{
	if (!strcmp(strategy,"best"))
	{
		return Best;
	}
	else if (!strcmp(strategy,"worst"))
	{
		return Worst;
	}
	else if (!strcmp(strategy,"first"))
	{
		return First;
	}
	else if (!strcmp(strategy,"next"))
	{
		return Next;
	}
	else
	{
		return 0;
	}
}


/* 
 * These functions are for you to modify however you see fit.  These will not
 * be used in tests, but you may find them useful for debugging.
 */

/* Use this function to print out the current contents of memory. */
void print_memory()
{
	return;
}

/* Use this function to track memory allocation performance.  
 * This function does not depend on your implementation, 
 * but on the functions you wrote above.
 */ 
void print_memory_status()
{
	printf("%d out of %d bytes allocated.\n",mem_allocated(),mem_total());
	printf("%d bytes are free in %d holes; maximum allocatable block is %d bytes.\n",mem_free(),mem_holes(),mem_largest_free());
	printf("Average hole size is %f.\n\n",((float)mem_free())/mem_holes());
}

/* Use this function to see what happens when your malloc and free
 * implementations are called.  Run "mem -try <args>" to call this function.
 * We have given you a simple example to start.
 */
void try_mymem(int argc, char **argv) {
        strategies strat;
	void *a, *b, *c, *d, *e;
	if(argc > 1)
	  strat = strategyFromString(argv[1]);
	else
	  strat = First;
	
	
	/* A simple example.  
	   Each algorithm should produce a different layout. */
	
	initmem(strat,500);
	
	a = mymalloc(100);
	b = mymalloc(100);
	c = mymalloc(100);
	myfree(b);
	d = mymalloc(50);
	myfree(a);
	e = mymalloc(25);
	
	print_memory();
	print_memory_status();
	
}
