## Ejemplo de llamada a subrutina. Profundidad 2
## NO FUNCIONA!!! Se queda en un bucle infinito al imprimir el tercer mensaje...


	.data
cad:	.asciiz "Saludos...\n"

	.text
	
	
	#--- Llamar a la subrutina
	jal saludo3
	
	
	#-- Terminar
	li $v0, 10
	syscall
	

	#-- Subrutina para que me salude 3 veces
saludo3:	
		
	jal saludo1
	
	jal saludo1
	
	jal saludo1
	
	#-- Bucle infinito. $ra NO contiene la dirección de retorno del programa principal...
	jr $ra
				
												
	#-- Subrutina de saludo (Función de saludo)
	#-- Imprimir por la consola 1 saludo
saludo1:

	la $a0, cad
	li $v0, 4
	syscall
	
	jr $ra
	  
	
	