/* calc.c - Multithreaded calculator */

#include "calc.h"

pthread_t adderThread;
pthread_t degrouperThread;
pthread_t multiplierThread;
pthread_t readerThread;
pthread_t sentinelThread;

char buffer[BUF_SIZE];
int num_ops;
pthread_mutex_t sem;
int can_add = 1;
int can_multiple = 1;
int can_degroup = 1;


/* Utiltity functions provided for your convenience */

/* int2string converts an integer into a string and writes it in the
   passed char array s, which should be of reasonable size (e.g., 20
   characters).  */
char *int2string(int i, char *s)
{
    sprintf(s, "%d", i);
    return s;
}

/* string2int just calls atoi() */
int string2int(const char *s)
{
    return atoi(s);
}

/* isNumeric just calls isdigit() */
int isNumeric(char c)
{
    return isdigit(c);
}

/* End utility functions */


void printErrorAndExit(char *msg)
{
    msg = msg ? msg : "An unspecified error occured!";
    fprintf(stderr, "%s\n", msg);
    exit(EXIT_FAILURE);
}

int timeToFinish()
{
    /* be careful: timeToFinish() also accesses buffer */
    return buffer[0] == '.';
}

/* Looks for an addition symbol "+" surrounded by two numbers, e.g. "5+6"
   and, if found, adds the two numbers and replaces the addition subexpression 
   with the result ("(5+6)*8" becomes "(11)*8")--remember, you don't have
   to worry about associativity! */
void *adder(void *arg)
{
    int bufferlen;
    int value1, value2;
    int startOffset, remainderOffset;
    int i;
    char result[500];
    
    //return NULL; /* remove this line */

    while (1) {
		startOffset = remainderOffset = -1;
		value1 = value2 = -1;
		if (sem_wait(&sem)){
			printErrorAndExit("Failed trying to sem_wait");
		}

		if (timeToFinish()) {
			if (sem_post(&sem)){
			    printErrorAndExit("Failed trying to sem_post");
			}
		    return NULL;
		}

		/*char old_buffer[500];
		strcpy(old_buffer, buffer);*/

		/* storing this prevents having to recalculate it in the loop */
		bufferlen = strlen(buffer);
		
		for (i = 0; i < bufferlen; i++) {
		    // do we have value1 already?  If not, is this a "naked" number?
		    // if we do, is the next character after it a '+'?
		    // if so, is the next one a "naked" number?

		    // once we have value1, value2 and start and end offsets of the
		    // expression in buffer, replace it with v1+v2
		    if (isNumeric (buffer[i])){
		    	startOffset = i;
		    	value1 = string2int(buffer + i);

			    while (isNumeric(buffer[i]))
			    	i++;

			    if (buffer[i] == '+' && isNumeric(buffer[i + 1])){
			    	value2 = string2int(buffer + i + 1);
			    	i++;
			    	while (isNumeric(buffer[i]))
			    		i++;
			    	remainderOffset = i;

			    	int2string(value1 + value2,result);

			    	strcpy(buffer + startOffset, result);
        			strcpy((buffer + startOffset + strlen(result)), (buffer + remainderOffset));

			    	bufferlen = strlen(buffer);
			    	i = startOffset + strlen(result) - 1;
			    	num_ops++;
			    }
			}
		}
		for (i = 0; i < bufferlen; i++){
			if (buffer[i] == '+'){
				if (buffer[i-1] == '+' || buffer[i-1] == '*' || buffer[i-1] == '(' ||
					buffer[i+1] == '+' || buffer[i+1] == '*' || buffer[i+1] == ')'){
					can_add = 0;
				}
			}
		}
		
		if (sem_post(&sem)){
			printErrorAndExit("Failed trying to sem_post");
		}
		// something missing?
		sched_yield();
    }
}



/* Looks for a multiplication symbol "*" surrounded by two numbers, e.g.
   "5*6" and, if found, multiplies the two numbers and replaces the
   mulitplication subexpression with the result ("1+(5*6)+8" becomes
   "1+(30)+8"). */
void *multiplier(void *arg)
{
    int bufferlen;
    int value1, value2;
    int startOffset, remainderOffset;
    int i;
    char result[500];
    /*char old_buffer[500];
    strcpy(old_buffer, buffer);*/

    //return NULL; /* remove this line */

    while (1) {
    	
		startOffset = remainderOffset = -1;
		value1 = value2 = -1;

		if (sem_wait(&sem)){
			printErrorAndExit("Failed trying to sem_wait");
		}

		if (timeToFinish()) {
			if (sem_post(&sem)){
			    printErrorAndExit("Failed trying to sem_post");
			}
		    return NULL;
		}
		char old_buffer[500];
		strcpy(old_buffer, buffer);

		/* storing this prevents having to recalculate it in the loop */
		bufferlen = strlen(buffer);

		for (i = 0; i < bufferlen; i++) {
		    // same as adder, but v1*v2
		    if (isNumeric (buffer[i])){
		    	startOffset = i;
		    	value1 = string2int(buffer + i);
			
			    while (isNumeric(buffer[i]))
			    	i++;

			    if (buffer[i] == '*' && isNumeric(buffer[i + 1])){
			    	value2 = string2int(buffer + i + 1);
			    	i++;
			    	while (isNumeric(buffer[i]))
			    		i++;
			    	remainderOffset = i;

			    	int2string(value1 * value2,result);

			    	strcpy(buffer + startOffset, result);
        			strcpy((buffer + startOffset + strlen(result)), (buffer + remainderOffset));

			    	bufferlen = strlen(buffer);
			    	i = startOffset + strlen(result) - 1;
			    	num_ops++;
			    }
			}
		}
		for (i = 0; i < bufferlen; i++){
			if (buffer[i] == '*'){
				if (buffer[i-1] == '+' || buffer[i-1] == '*' || buffer[i-1] == '(' ||
					buffer[i+1] == '+' || buffer[i+1] == '*' || buffer[i+1] == ')'){
					can_multiple = 0;
				}
			}
		}

		if (sem_post(&sem)){
			printErrorAndExit("Failed trying to sem_post");
		}
		// something missing?
		sched_yield();
    }
}


 // Looks for a number immediately surrounded by parentheses [e.g.
 //   "(56)"] in the buffer and, if found, removes the parentheses leaving
 //   only the surrounded number. 
void *degrouper(void *arg)
{
    int bufferlen;
    int i;
    int startOffset, remainderOffset;
    int count = 0;

    while (1) {
    	if (sem_wait(&sem)){
			printErrorAndExit("Failed trying to sem_wait");
    	}

		if (timeToFinish()) {
			if (sem_post(&sem)){
			    printErrorAndExit("Failed trying to sem_post");
			}
		    return NULL;
		}
		char old_buffer[500];
		strcpy(old_buffer, buffer);

		/* storing this prevents having to recalculate it in the loop */
		bufferlen = strlen(buffer);

		for (i = 0; i < bufferlen; i++) {
		    // check for '(' followed by a naked number followed by ')'
		    // remove ')' by shifting the tail end of the expression
		    // remove '(' by shifting the beginning of the expression
		    if (buffer[i] == '(' && isNumeric(buffer[i + 1])){
			    startOffset = i;
			    i++;
			    while (isNumeric(buffer[i]))
			    	i++;

			    if (buffer[i] == ')'){
			    	remainderOffset = i;

			    	strcpy((buffer + remainderOffset), (buffer + remainderOffset + 1));
			        strcpy((buffer + startOffset), (buffer + startOffset + 1));

			    	bufferlen = bufferlen - 2;
			    	i = i - 2;
			    	num_ops++;		    
			    }
			}
		}
		for (i = 0; i < bufferlen; i++){
			if (buffer[i] == '(')
				count++;
			if (buffer[i] == ')')
				count--;
		}
		if (count != 0)
			can_degroup = 0;

		if (sem_post(&sem)){
			printErrorAndExit("Failed trying to sem_post");
		}
		// something missing?
		sched_yield();
    }
}


/* sentinel waits for a number followed by a ; (e.g. "453;") to appear
   at the beginning of the buffer, indicating that the current
   expression has been fully reduced by the other threads and can now be
   output.  It then "dequeues" that expression (and trailing ;) so work can
   proceed on the next (if available). */

void *sentinel(void *arg)
{
    char numberBuffer[20];
    int bufferlen;
    int i;

    //return NULL; /* remove this line */

    while (1) {
    	if (sem_wait(&sem)){
    		printErrorAndExit("Failed trying to sem_wait");
    	}

		if (timeToFinish()) {
			if (sem_post(&sem)){
				printErrorAndExit("Failed trying to sem_post");
			}
		    return NULL;
		}

		if (can_add == 0 || can_multiple == 0 || can_degroup == 0){
			fprintf(stdout, "No progress can be made\n");
			exit(EXIT_FAILURE);
		}

		/* storing this prevents having to recalculate it in the loop */
		bufferlen = strlen(buffer);

		for (i = 0; i < bufferlen; i++) {
		    if (buffer[i] == ';') {
				if (i == 0) {
				    printErrorAndExit("Sentinel found empty expression!");
				} 
				else {
				    /* null terminate the string */
				    numberBuffer[i] = '\0';
				    /* print out the number we've found */
				    fprintf(stdout, "%s\n", numberBuffer);
				    /* shift the remainder of the string to the left */
				    strcpy(buffer, &buffer[i + 1]);
				    break;
				}
		    } 
		    else if (!isNumeric(buffer[i])) {
				break;
		    } 
		    else {
				numberBuffer[i] = buffer[i];
		    }
		}
		if (sem_post(&sem)){
			printErrorAndExit("Failed trying to sem_post");
		}
		// something missing?
		sched_yield();
	}
}

/* reader reads in lines of input from stdin and writes them to the
   buffer */

void *reader(void *arg)
{
    while (1) {
		char tBuffer[100];
		int currentlen;
		int newlen;
		int free;

		fgets(tBuffer, sizeof(tBuffer), stdin);

		/* Sychronization bugs in remainder of function need to be fixed */

		newlen = strlen(tBuffer);
		currentlen = strlen(buffer);

		/* if tBuffer comes back with a newline from fgets, remove it */
		if (tBuffer[newlen - 1] == '\n') {
		    /* shift null terminator left */
		    tBuffer[newlen - 1] = tBuffer[newlen];
		    newlen--;
		}

		/* -1 for null terminator, -1 for ; separator */
		free = sizeof(buffer) - currentlen - 2;

		while (free < newlen) {
			// spinwaiting
			
			sched_yield();
		}

		/* we can add another expression now */
		if (sem_wait(&sem))
			printErrorAndExit("Failed trying to sem_wait");

		strcat(buffer, tBuffer);
		strcat(buffer, ";");

		if (sem_post(&sem))
			printErrorAndExit("Failed trying to sem_post");
		sched_yield();

		/* Stop when user enters '.' */
		if (tBuffer[0] == '.') {
		    return NULL;
		}
    }
}


/* Where it all begins */
int smp3_main(int argc, char **argv)
{
    void *arg = 0;		/* dummy value */

    if (sem_init(&sem, 0, 1))
		printErrorAndExit("Failed trying to sem_init");

    /* let's create our threads */
    if (pthread_create(&multiplierThread, NULL, multiplier, arg)
	|| pthread_create(&adderThread, NULL, adder, arg)
	|| pthread_create(&degrouperThread, NULL, degrouper, arg)
	|| pthread_create(&sentinelThread, NULL, sentinel, arg)
	|| pthread_create(&readerThread, NULL, reader, arg)) {
	printErrorAndExit("Failed trying to create threads");
    }

    /* you need to join one of these threads... but which one? */

    pthread_join(sentinelThread, NULL);
    pthread_detach(multiplierThread);
    pthread_detach(adderThread);
    pthread_detach(degrouperThread);
    pthread_detach(sentinelThread);
    pthread_detach(readerThread);

    

    /* everything is finished, print out the number of operations performed */
    fprintf(stdout, "Performed a total of %d operations\n", num_ops);
    return EXIT_SUCCESS;
}