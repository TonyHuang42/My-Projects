	.globl times
times:
	movl	$0, %eax	#result = 0
	movl	$1, %ecx	#count = 1

loop:	
	cmpl	%esi, %ecx	#count - b ? 0
	ja		endl		#exit loop if count > b
	addl	%edi, %eax	#result = result + a
	incl	%ecx		#count ++
	jmp		loop		#enter the loop again

endl:
	ret
