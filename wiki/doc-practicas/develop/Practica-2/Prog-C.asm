	.data
cad:
	.asciiz "El resultado es: "

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
	##  Printf ("El resultado es: ")
	li $v0, 4
	la $a0, cad
	syscall
	
	## Print $t3	
	move $a0, $t3
	li $v0, 1
	syscall
	
	## -- Fin
	li $v0, 10
	syscall
	
