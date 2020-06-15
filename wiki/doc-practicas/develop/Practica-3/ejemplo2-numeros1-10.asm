#-- Imprimir los numeros del 1 al 10

	.text
	
	li $s0,0  #-- Registro indice: i
	
	
next:	
	#-- incrementar indice
	addi $s0, $s0, 1
	
	#-- Imprimir numero actual
	li $v0, 1
	move $a0, $s0
	syscall
	
	#-- Imprimir \n
	li $v0, 11
	li $a0, '\n'
	syscall
	
	#-- Si es 10 terminar
	li $t0, 10
	bne $s0, $t0, next
	
	#-- Exit
	li $v0, 10
	syscall