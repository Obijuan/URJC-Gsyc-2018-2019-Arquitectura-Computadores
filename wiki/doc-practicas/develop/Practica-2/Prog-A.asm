	.text
	
	## -- Leer primer numero
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	## -- Leer segundo numero
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	## -- Realizar la suma
	add $t3, $t1, $t2
	
	## -- Sacar resultado por la consola
	move $a0, $t3
	li $v0, 1
	syscall
	
	## -- Fin
	li $v0, 10
	syscall
	