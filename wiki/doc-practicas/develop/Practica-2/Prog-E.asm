	.data
cad:
	.asciiz "El resultado es: "

var1:	.space 2
var2:	.space 4

	.text

	## -- Leer primer dato desde consola y guardarlo en memoria
	li $v0, 5
	syscall
	sh $v0, var1
	
	## -- Leer segundo dato desde consola y guardarlo en memoria
	li $v0, 5
	syscall
	sw $v0, var2
			
	## -- Leer primer numero
	lh $t1, var1
	
	## -- Leer segundo numero
	lw $t2, var2
	
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
	
