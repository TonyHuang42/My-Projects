	.globl conv
conv:
	movq 	$0, %rax			#result = 0
	movq 	$0, %rcx			#m = 0
	leaq 	(%rsi,%rdx,1), %rsi
	decq 	%rsi				#%rsi points to h[n-1]
loop:
	cmpq 	%rdx, %rcx			#m - length ? 0
	jge 	end					#end loop if m >= length	
	movq 	(%rdi), %r8			#move x[m] to temp
	imulq 	(%rsi), %r8			#temp = temp * h[n-m-1]
	addq 	%r8, %rax			#result = result + temp
	incq	%rdi				#%rdi = %rdi + 1
	decq	%rsi				#%rsi = %rsi - 1
	incq 	%rcx				#m++
	jmp 	loop
end:
	ret


#result = 0;
#m = 0;
#while m < length
#{
#	temp = x[m] * h[n-m-1]
#	result = result + temp
#	m++
#}
#return result

