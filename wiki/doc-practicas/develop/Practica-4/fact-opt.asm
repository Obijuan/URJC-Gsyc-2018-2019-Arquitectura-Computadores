	.data
msg:	.asciiz "El factorial de 3 es: "

	.text
	
	#--- Imprimir cadena antes del calculo
main:	la $a0, msg
	li $v0, 4
	syscall
	
	#-- Calcular el factorial de 3
	li $a0, 4
	jal fact
	
	#-- Imprimir el resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall
	
	#-- Subrutina: Calcular el Factorial
fact:   ##-- Comprobar condicion de parada

	#-- Si el argumento es 1, devolvemos 1 y terminamos
	bgt $a0, 1, no_parada 
	li $v0, 1
	jr $ra
	
	#-- El argumento es mayor que 1
no_parada:

	#-- crear el marco de pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	#-- Llamar a fact (n-1)
	subu $a0, $a0, 1
	jal fact

	#-- v0 = n * fact(n-1)
	lw $v1, 0($fp)
	mul $v0, $v0, $v1
	
	#-- Eliminar el marco de pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
