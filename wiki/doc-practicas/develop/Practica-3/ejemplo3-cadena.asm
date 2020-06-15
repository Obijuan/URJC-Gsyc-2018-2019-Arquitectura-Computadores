#-- Ejemplo de recorrer una cadena leyendo sus caracteres

	.data

#-- Reservar espacio para meter la cadena
cad:	.space 1024

	.text
	
	#-- Pedir al usuario una cadena
	li $v0, 8
	la $a0, cad
	li $a1, 1024
	syscall
	
	#-- Recorrer la cadena hasta llegar al \n
	la $s1,cad   #-- Reg $s1 es el puntero

next:		
	#-- Leer caracter
	lb $t0, 0($s1)
	
	#-- Imprimir el caracter
	li $v0, 11
	move $a0, $t0
	syscall
	
	#-- ¿Es el final? \n
	li $t1, '\n'
	beq $t0, $t1, fin  #-- Si--> Terminar
	
	#-- Apuntar al siguiente caracter
	addi $s1, $s1, 1
	b next
	
fin:
	li $v0, 10
	syscall
	
	
	
	