	#-- calculo de la secuencia de fibonacci (Con algoritmo recursivo)
	#-- F(n):
	#--
	#--   Si n<=2, F(n) = 1
	#--   F(n) = F(n-1) + F(n-2)
	#-- 
	#-- n:   1  2  3  4  5  6  7  8  9 10  11  12   13
	#---------------------------------------------------
	#-- F(n) 1  1  2  3  5  8 13 21 34 55  89  144 233
	
	.data
msg1:	.asciiz "Termino n de Fibonnaci: "
	
	
	.text
	#-- Programa principal: main
	
	#-- Imprimir mensaje:
	li $v0, 4
	la $a0, msg1
	syscall
	
	#-- Calcular F(n)
	li $a0, 13
	jal fibonacci
	
	#-- Imprimir resultado
	move $a0, $v0
	li $v0, 1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall 
	
	
fibonacci:

	#-- Condicion de terminacion
	#-- Si n>2, se calcula fibonnaci
	#-- Si n<=2, se devuelve 1

	bgt $a0, 2, fibo_recur
	
	#-- Devolver 1 y terminar
	li $v0, 1
	jr $ra
	
fibo_recur:

	#-- Crear marco de pila
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addiu $fp, $sp, 28
	
	#-- Guardar n en la pila
	sw $a0, 0($fp)
	
	#-- Calcular F(n-1)
	subi $a0, $a0, 1
	jal fibonacci
	
	#-- Guardar en la pila F(n-1)
	sw $v0, -4($fp)
	
	#-- Calcular F(n-2)
	#-- Recuperar n
	lw $a0, 0($fp)    #-- Recuperar n
	subi $a0, $a0, 2  #-- Calcular n-2
	jal fibonacci     #-- Calcular F(n-2)
	
	#-- Recuperar F(n-1)
	lw $v1, -4($fp)
	add $v0, $v0, $v1  #-- Calcular F(n-1) + F(n-2)
	
	#-- Recuperar marco pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra
	
	
	
	
