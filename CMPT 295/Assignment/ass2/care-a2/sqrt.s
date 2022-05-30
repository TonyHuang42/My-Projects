	.globl sqrt
sqrt:
	movl 	$0, %eax   		#result = 0
	movl 	$16, %esi		#count = 16
	movl 	$0x10000, %edx 	#%edx = 0001 0000 0000 0000 0000 in binary
loop:
	shr		$1, %edx		#shift right 1 bit of %edx
	decl	%esi			#count--
	cmpl 	$0, %esi		#count - 0 ? 0
	jl 		endl			#jump to endl if count < 0
	xorl 	%edx, %eax		#change the kth bit of result to 1
	movl 	%eax, %ecx		#move result to %ecx
	imull 	%ecx, %ecx		#%ecx = result^2
	cmpl 	%edi, %ecx		#result^2 - x ? 0
	jle		loop			#jump to loop if result^2 <= x
	xorl	%edx, %eax		#change the kth bit of result to 0 if result^2 > x
	jmp	loop				#back to loop
endl:
	ret
