	#--- Ejemplo 1. Impresión de una cadena en la consola, desde una subrutina

	.data
cad:	.asciiz "Probando...\n"

	.text
	

	jal msg
	jal msg
	jal msg
	jal msg

	# -- Terminar
	li $v0, 10
	syscall


	#-- Impresión de la cadena
msg:	la $a0, cad
	li $v0, 4
	syscall
	jr $ra
