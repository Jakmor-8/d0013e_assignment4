	.text
	.set noreorder

main: 	li	$a0, 13			#dividend 1
	bal	division
	li	$a1, 4			#divisor 1

#	li	$a0, 25			#dividend 2
#	bal	division	
#	li	$a1, 5			#divisor 2

#	li	$a0, 0			#dividend 3
#	bal	division	
#	li	$a1, 5			#divisor 3

#	li	$a0, 7			#dividend 4
#	bal	division	
#	li	$a1, 0			#divisor 4
	

end:	b       end             	#infinite loop
	nop


	

division:
	beq	$a0, $zero, no_div	#checks if the dividend is zero
	move	$t1, $a0
	beq	$a1, $zero, zero_div	#checks if the divisor is zero
	move	$t0, $zero


div_loop:
	sub	$t1, $t1, $a1		#subracts divisor from dividend
	bltz	$t1, remainder		#branch if dividend < zero
	nop
	beq	$t1, $zero, even_div	#branch if dividend = zero
	addiu	$t0, $t0, 1		#accumulator
	b	div_loop		#loop
	nop


remainder:
	b	exit
	add	$t1, $t1, $a1		#adds divisor to remaining dividend to get remainder


even_div:
	b	exit
	li	$t1, 0x0		#zero remainder


no_div:
	li	$t0, 0x0		#zero fraction
	b	exit
	li	$t1, 0x0		#zero remainder
	

zero_div:
	syscall
	li	$a1, 0xff		#zero division flag


exit:	move	$v0, $t0		#fraction
	jr	$31
	move	$v1, $t1		#remainder





 	.section .ktext , "xa"		#kernel code
        .set noreorder
	
	mfc0	$k0, $13		#loads EPC
	nop
	
	sll	$k0, $k0, 25		#removes bits 31:6
	srl 	$k0, $k0, 27		#removes bits 1:0
	li	$k1, 0x8		#initalize comparator
	bne	$k0, $k1, kernel_loop	#branch if k0 != 8
	nop
	
	li	$k1, 0xff		#initalize comparator
	bne	$a1, $k1, return	
	nop
	
	li	$k0, 0x7fffffff		
	addi	$k0, $k0, 0x1		#generate overflow


return:	mfc0	$k0, $14		#loads EPC register
	nop
	addiu	$k0, $k0, 4		#one instruction after syscall
	jr	$k0			#jumps to that instruction
	rfe				#switch to user mode


kernel_loop:
        b 	kernel_loop		#infinite kernel loop
        nop

