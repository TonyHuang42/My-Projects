# var map:
# %rdi	*A
# %rsi	n
# %rdx	target
# %r9d	temp	
# %eax	result
	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi				# if (n <= 0)
	jle		return_neg_one			# 	return -1
	movslq	%esi, %rax				# rax = n
	leaq	-4(%rdi,%rax,4), %rax	# rax points to A[n-1]
	movl	(%rax), %r9d			# temp = A[n-1]
	movl	%edx, (%rax)			# A[n-1] = target
	cmpl	(%rdi), %edx			# if target = A[0]
	je		target_equals_A_zero	# 	i = 0, jump to if
	movl	$1, %ecx				# else i = 1
loop:
	movl	%ecx, %r8d				# while (A[i-1] != target){
	addq	$1, %rcx				# 	r8d = i
	cmpl	%edx, -4(%rdi,%rcx,4)	# 	i++
	jne		loop					# }
if:
	movl	%r9d, (%rax)			# A[n-1] = temp
	leal	-1(%rsi), %eax			# result = n-1
	cmpl	%r8d, %eax				# if (i < n-1)
	jg		return_i				# 	return i
	cmpl	%edx, %r9d				# else if (temp != target)
	jne		return_neg_one			# 	return -1
	rep 	ret						# else return n-1
return_i:
	movl	%r8d, %eax				# result = i
	ret								# return
target_equals_A_zero:
	xorl	%r8d, %r8d				# i = 0
	jmp		if						# jump to if
return_neg_one:
	movl	$-1, %eax				# result = -1
	ret								# return -1

