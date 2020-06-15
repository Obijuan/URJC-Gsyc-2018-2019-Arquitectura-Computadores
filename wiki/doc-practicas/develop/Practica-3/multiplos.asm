	
	##----- Leer dos números del terminal: A y B
	
	#-- Op A en $s1
	li $v0, 5
	syscall
	move $s1, $v0
	
	#-- Op B en $s2
	li $v0, 5
	syscall
	move $s2, $v0

	## Si B es cero, el programa debe terminar		
	li $s0, 0  #-- $s0 lo usamos como índice: i

bucle:	
			
	beq $s0, $s2, fin  #-- Si i = B, terminar
	
	#-- Incrementar indice
	addi $s0, $s0, 1
	
	#-- Multiplicar: A*i
	mult $s0, $s1
	
	#-- Imprimir A*i
	mflo $a0
	li $v0, 1
	syscall
	
	#-- Imprimir \n
	li $v0, 11
	li $a0, '\n'
	syscall
	
	b bucle
	
	
	## Cuando se llega a AxB se debe terminar
	
	## Cada multiplo se imprime en una linea
	
fin:	li $v0, 10
	syscall	
	
	## Ej.  A=5, B=3:   Salida: 5, 10, 15
