#ifndef	__SCHED_IMPL__H__
#define	__SCHED_IMPL__H__

#include <semaphore.h>
#include "list.h"
#include <stdlib.h>
#include <stdio.h>


struct thread_info {
	sched_queue_t *queue;
	list_elem_t *list_elem;
	sem_t sem_worker;
};

struct sched_queue {
	int current;
	list_t *list;
	sem_t sem_queue;
	sem_t sem_cpu;
};

#endif /* __SCHED_IMPL__H__ */
