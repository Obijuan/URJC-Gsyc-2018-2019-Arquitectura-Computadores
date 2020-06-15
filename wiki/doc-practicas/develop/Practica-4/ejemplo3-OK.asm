## Ejemplo de llamada a subrutina. Profundidad 2
## NO FUNCIONA!!! Se queda en un bucle infinito al imprimir el tercer mensaje...


	.data
cad:	.asciiz "Saludos...\n"

	.text
	
	
	#.... se usa el registro s0 para almacenar un valor importante
	li $s0, 6
	
	#--- Llamar a la subrutina
	jal saludo3
	
	
	#-- Ahora se imprime usa o imprime $s0
	#-- Es correcto!!! Porque ninguna subrutina debe mofidicar su valor
	
	#-- Terminar
	li $v0, 10
	syscall
	

	#-- Subrutina para que me salude 3 veces
saludo3:	
		
	#-- Guardar el contexto en la pila
	
	#-- Dejar espacio para el marco de pila: 32 bytes: espacio para 8 registros!!!
	subu $sp, $sp, 32
	
	#-- Guardamos la dirección de retorno (Por ejemplo el offset 20)
	sw $ra, 20($sp)
	
	#-- Guardamos el puntero del marco de pila
	sw $fp, 16($sp)
	
	#-- Situar el puntero del marco en la cima
	addiu $fp, $sp, 28
			
		
	jal saludo1
	
	jal saludo1
	
	jal saludo1
	
	
	#-- Recuperar el contexto
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	#-- Terminar
	jr $ra
				
												
	#-- Subrutina de saludo (Función de saludo)
	#-- Imprimir por la consola 1 saludo
saludo1:

	la $a0, cad
	li $v0, 4
	syscall
	
	jr $ra
	  
	
	