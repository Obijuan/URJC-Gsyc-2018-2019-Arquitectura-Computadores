	.data
cad:	.space 1024
num:	.word 0
signo:  .word 1  #-- Por defecto positivo

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
	
	
	#-- Leer el signo
	li $t1, '-'
	lb $s1, 0($s0)
	bne $s1, $t1, bucle     #--- Numero positivo: saltar al bucle
	
	#-- El numero es negativo
	#---- Incrementar puntero de cadena
	addi $s0, $s0, 1
	li $t1, -1
	la $a0, signo
	sw $t1, 0($a0)  #--- Almacenar un -1
	
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
	
	
	
fin:    #-- Multiplicar por el signo
	la $a0, signo
	lw $t1, 0($a0)  #-- Meter en $t1 el signo (1, o -1)
	mult $s2, $t1
	mflo $s2
	
		#-- Guardar en la variable num
	la $a1, num
	sw $s2, 0($a1)
	
	#-- Imprimir el número
	li $v0, 1
	move $a0, $s2
	syscall

        #--- Fin del programa
	li $v0, 10
	syscall