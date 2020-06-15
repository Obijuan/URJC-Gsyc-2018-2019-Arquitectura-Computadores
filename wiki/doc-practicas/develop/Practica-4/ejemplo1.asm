## Ejemplo de llamada a subrutina. Profundidad 1

	.data
cad:	.asciiz "Saludos...\n"

	.text
	
	
	#--- Llamar a la subrutina
	jal saludo1
	
	jal saludo1
	
	jal saludo1
	
	
	#-- Terminar
	li $v0, 10
	syscall
	
	
	#-- Subrutina de saludo (Función de saludo)
	#-- Imprimir por la consola 1 saludo
saludo1:

	la $a0, cad
	li $v0, 4
	syscall
	
	jr $ra
	  
	
	