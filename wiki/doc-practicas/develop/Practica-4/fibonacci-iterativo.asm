
	#-- Calculo de la secuencia de fibonacci de forma iterativa
	
	.text
	
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

	#-- Cuando n<=2, se devuelve 1 siempre
	bgt $a0, 2, fibo_main
	
	#-- Devolver 1
	li $v0, 1
	jr $ra
	
fibo_main:

	#-- Ya conocemos el valor de los términos 1 y 2. Empezamos por el 3
	subi $a0, $a0, 2
	
	li $t0, 1  #-- t0: Termino n-2
	li $t1, 1  #-- t1: Termino n-1
	
bucle:  
	#-- Sumar los terminos n-1 y n-2
	add $v0, $t0, $t1
	
	#-- Actualizar los terminos anteriores
	move $t0, $t1
	move $t1, $v0
	
	#-- Una vuelta menos
	subi $a0, $a0, 1
	bgtz $a0, bucle
	
	jr $ra
	
	
	