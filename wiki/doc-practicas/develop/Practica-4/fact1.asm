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
	
	#-- Subrutina: Calcular el Factorial
fact:	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	lw $v0, 0($fp)
	bgt $v0, 1, fact_recur  #-- Si n > 1 calcular el factorial
	li $v0, 1 #-- n<=1, retornar 1
	b return_fact
	
fact_recur:
	lw $v1, 0($fp)
	subu $v0, $v1, 1
	move $a0, $v0
	jal fact

	lw $v1, 0($fp)
	mul $v0, $v0, $v1
	
return_fact:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
