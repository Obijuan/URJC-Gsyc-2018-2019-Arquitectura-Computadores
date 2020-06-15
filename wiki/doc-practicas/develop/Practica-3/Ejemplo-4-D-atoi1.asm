	.data
cad:	.space 1024
num:	.word 0
pcad:	.word 0

	.text
	
	#-- Leer cadena desde terminal
	
	li $v0, 8
	la $a0, cad
	li $a1, 1024
	syscall
	
	#--- Reg s2 contiene el numero (num)
	li $s2, 0
	
	#-- Reg s0: Puntero a la cadena
	la $s0, cad
	
	
	#-- Mientras que el siguiente caracter no sea \n
bucle:
	li $t1, '\n'
	lb $s1, 0($s0)  #-- Leer primer byte
	beq $s1, $t1, fin #-- si es '\n' terminar...
	
	#---- num = num x 10
	li $t1, 10
	mult $s2, $t1
	mflo $s2
	
	#--- num = num + (car - '0')
	li $t2, '0'
	sub $s1, $s1, $t2  #-- $s1 = car - '0'
	add $s2, $s2, $s1  #-- $s2 = $s2 + $s1
	
	#-- Apuntar al siguiente caracter
	addi $s0, $s0, 1 
	
	b bucle
	
	
	
fin:	#-- Guardar en la variable num
	la $a1, num
	sw $s2, 0($a1)
	
	#-- Imprimir el número
	li $v0, 1
	move $a0, $s2
	syscall

        #--- Fin del programa
	li $v0, 10
	syscall