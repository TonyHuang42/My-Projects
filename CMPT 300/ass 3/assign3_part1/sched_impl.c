#include "scheduler.h"
#include "sched_impl.h"


static void init_thread_info(thread_info_t *info, sched_queue_t *queue){
	info->queue = queue;
	list_elem_t *n = (list_elem_t*) malloc(sizeof(list_elem_t));
	list_elem_init(n, info);
	info->list_elem = n;
	sem_init(&(info->sem_worker), 0, 0);
}

static void destroy_thread_info(thread_info_t *info){
	free(info->list_elem);
}

static void init_sched_queue(sched_queue_t *queue, int queue_size){
	queue->current = 0;
	queue->list = (list_t *) malloc(sizeof(list_t));
	list_init(queue->list);
	sem_init(&(queue->sem_cpu), 0, 0);
	sem_init(&(queue->sem_queue), 0, queue_size);
}

static void destroy_sched_queue(sched_queue_t *queue){
	if (queue != NULL){
		list_foreach(queue->list, (void *) free);
		free(queue->list);
		queue = NULL;
	}
}

static void enter_sched_queue(thread_info_t *info){
	sem_wait(&(info->queue->sem_queue));
	list_insert_tail(info->queue->list, info->list_elem);
}

static void leave_sched_queue(thread_info_t *info){
	list_remove_elem(info->queue->list, info->list_elem);
	sem_post(&(info->queue->sem_queue));
	info->queue->current--;
}

static void wait_for_cpu(thread_info_t * info){
	sem_wait(&(info->sem_worker));
}

static void release_cpu(thread_info_t * info){
	sem_post(&(info->queue->sem_cpu));
}

static void wake_up_worker(thread_info_t *info){
	sem_post(&(info->sem_worker));
}

static void wait_for_worker(sched_queue_t *queue){
	sem_wait(&(queue->sem_cpu));
}

thread_info_t * fifo_next_worker(sched_queue_t *queue){
	return (thread_info_t*) (list_get_head(queue->list)->datum);
}

thread_info_t * rr_next_worker(sched_queue_t *queue){
	if (queue->current == list_size(queue->list))
		queue->current = 0;
	list_elem_t *temp = list_get_head(queue->list);
	for (int i = 0; i < queue->current; i++){
		if (temp == NULL)
			temp = list_get_head(queue->list);
		else
			temp = temp->next;
	}
	queue->current++;
	return (thread_info_t*) (temp->datum);
}

static void wait_for_queue(sched_queue_t *queue){
	int numInQueue = list_size(queue->list);
	while (numInQueue == 0)
		numInQueue = list_size(queue->list);
}


sched_impl_t sched_fifo = {
	{init_thread_info, destroy_thread_info, enter_sched_queue, leave_sched_queue, wait_for_cpu, release_cpu},
	{init_sched_queue, destroy_sched_queue, wake_up_worker, wait_for_worker, fifo_next_worker, wait_for_queue}};

sched_impl_t sched_rr = {
	{init_thread_info, destroy_thread_info, enter_sched_queue, leave_sched_queue, wait_for_cpu, release_cpu},
	{init_sched_queue, destroy_sched_queue, wake_up_worker, wait_for_worker, rr_next_worker, wait_for_queue}};
