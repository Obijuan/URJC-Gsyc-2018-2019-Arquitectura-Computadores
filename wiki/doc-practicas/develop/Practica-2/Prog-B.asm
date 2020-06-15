	.data
cad:	.asciiz "Ola k ase"
	
		
	.text
	
	## -- Imprimir la cadena
	li $v0, 4
	la $a0, cad
	syscall
	
	## -- Fin
	li $v0, 10
	syscall
	