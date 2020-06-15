#-- Ejemplo de convenio de paso de parámetros
#-- Subrutina que multiplica por 2
#-- En notación C estaríamos implementando una función como esta:
#
#   int mult2 (int n);
#
#  Tenemos 1 parámetro (n) y devolvemos un valor


	.text
	
	#-- Programa principal
	
	
	#-- El parametro lo pasamos por a0 (CONVENIO)
	
	li $a0, 4
	jal mult2
	
	#-- El resultado está en $v0 (CONVENIO)
	
	#-- Imprimir el resultado
	move $a0, $v0
	li $v0,1
	syscall
	
	#-- Terminar
	li $v0, 10
	syscall	
	
	#-- Subrutina de multiplicación
	#-- Parametro entrada: a0: múmero a multiplicar
	#-- Salida: V0: resultado
mult2:

	#-- En el registro temporal t0 metemos un 2
	#-- Lo podemos hacer. El valor de los registros t puede cambiar en cualquier momento
	li $t0, 2

	#-- Multiplicar a0 * 2 y dejar resultado en V0
	mul $v0, $a0, $t0

	jr $ra
