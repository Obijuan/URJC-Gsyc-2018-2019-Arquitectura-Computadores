	.data
cad:
	.asciiz "El resultado es: "
vara1:	.word 3000
vara2:	.word 5000

varb1:  .half 500
varb2:  .half 200

varc1:  .byte 40
varc2:  .byte 22

	.text
	
	## -- Leer primer numero
	## lw $t1, vara1
	## lh $t1, varb1
	lb $t1, varc1
	
	## -- Leer segundo numero
	## lw $t2, vara2
	## lh $t2, varb2
	lb $t2, varc2
	
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
	
