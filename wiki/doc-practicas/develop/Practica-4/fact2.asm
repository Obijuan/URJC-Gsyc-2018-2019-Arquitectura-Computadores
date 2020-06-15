#-- Factorial. Optimización 1

		.data
msg:	.asciiz "El factorial es: "

	.text
	
	#--- Imprimir cadena antes del calculo
main:	la $a0, msg
	li $v0, 4
	syscall
	
	#-- Calcular el factorial de n
	li $a0, 3
	jal fact
	
	#-- Imprimir el resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall
	
	
fact:
	#---- Subrutina: Calcular el Factorial
	#-- Primero evaluamos el retorno
	#-- Si a0 es mayor que 1, calculamos factorial
	#-- en caso contrario, retornamos 1 directamente
	bgt $a0, 1, fact_recur
	li $v0, 1  #-- Devolver 1 y retornar
	jr $ra
	
fact_recur:
	#-- Crear marco de pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)    #-- Guardar a0 (n) en la pila
	
	#-- Esto se deja como antes (se puede optimizar mas)
	lw $v0, 0($fp)
	lw $v1, 0($fp)
	subu $v0, $v1, 1
	move $a0, $v0
	jal fact

	lw $v1, 0($fp)
	mul $v0, $v0, $v1
	
	#-- Recuperar marco de pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	#-- Retornar
	jr $ra
