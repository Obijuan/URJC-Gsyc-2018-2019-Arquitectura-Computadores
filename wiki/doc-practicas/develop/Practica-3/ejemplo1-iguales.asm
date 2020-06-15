	.data
msg1:	.asciiz "Iguales\n"
	
	.text

	## ------Leer números por consola
	
	##-- $s1 contiene numero A
	li $v0, 5
	syscall 
	move $s1, $v0
	
	##-- $s2 contiene numero B
	li $v0, 5
	syscall
	move $s2, $v0
	
	## Si NO son iguales, terminar directamente
	bne $s1, $s2, fin
	
	#--- Son iguales. Imprimir mensaje
	li $v0, 4
	la $a0, msg1
	syscall
	
fin:
	##-- exit!
	li $v0, 10
	syscall