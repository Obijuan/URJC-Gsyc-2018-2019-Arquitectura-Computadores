
	## ------Leer números por consola
	
	##-- $s1 contiene numero A
	li $v0, 5
	syscall 
	move $s1, $v0
	
	##-- $s2 contiene numero B
	li $v0, 5
	syscall
	move $s2, $v0
	
	## Imprimir el mayor
	bgt $s1, $s2, Mayor1
	
	##-- B > A ---> imprimir $s2
	move $a0,$s2
	b print
	
	##-- A > B
Mayor1: move $a0, $s1
	b print
	
	##-- Imprimir el numero en $a0
print:	li $v0, 1
	syscall
	
	##-- exit!
	li $v0, 10
	syscall
	