# Crear una lista simplemente enlazada.
# Las inserciones se hacen de mayor a menor

#-- Estructura de la lista

   #  Val 0($t1)
   #  next  4($t1)


#--- Main

	.text

	#-- Crear nodo inicial, con val = 0, next = 0
	#-- p = create_node(0, 0)  #-- a0 = 0,  a1 = 0
	li $a0, 0
	li $a1, 0
	jal create  #-- Devuelve el puntero (p) en $v0
	
	#-- Meter en s0 el puntero al primer nodo
	#-- Lo dice así el enunciado
	move $s0, $v0
	
main_loop:	
	#----------- Bucle
	#-- Pedir número al usuario
	li $v0, 5
	syscall
	
	#-- V0 contiene el número pedido
	#-- Si es 0, terminar
	beq $v0, 0, fin
	
	#-- Insertar el numero en la lista
	#-- Hay que llamar a la funcion insert_in_order
	#-- p = insert_in_order(first, val)
	#-- v0 = insert_in_order($s0, $v0)
	move $a0, $s0
	move $a1, $v0
	jal insert_in_order
	
	
	#-- Si $v0 es 0, no se actualiza $s0
	beq $v0,0,main_loop
	
	#---Actualizar $s0 
	#-- Hay que hacerlo porque $v0 es != 0
	move $s0, $v0
	
	#-- Repetir bucle
	b main_loop
	
fin:	

	#-- Imprimir la lista (en orden inverso)
	#-- print(first)
	#-- print($s0)
	move $a0, $s0
	jal print
	
	
	#-- Terminar
	li $v0, 10
	syscall


#-- p = Create(val, next)
#-- Crea un nodo y devuelve el puntero al nodo--
#-- Parámetros:
#--  a0: val
#--  a1: next 
create:

      #-- Crear la pila
      addi $sp, $sp, -32
      sw $ra, 20($sp)
      sw $fp, 16($sp)
      addi $fp, $sp, 28

      #-- Guardar a0 y a1 en la pila
      sw $a0, 0($fp)
      sw $a1, -4($fp)

      #-- Reservar memoria para un nodo
      #-- Cada nodo necesita 2 palabras (8 bytes)
      li $a0, 8
      li $v0, 9
      syscall
      
      #-- Recuperamos los argumentos
      lw $a0, 0($fp)
      lw $a1, -4($fp)
      
      #-- En v0 tenemos el puntero al nuevo nodo
      #-- Inicializar el nodo
      #-- p->val = val
      sw $a0, 0($v0) 
      
      #-- p->next = next  
      sw $a1, 4($v0)  

      #-- Recuperar la pila
      lw $ra, 20($sp)
      lw $fp, 16($sp)
      addi $sp, $sp, 32

      #-- Retornar
      jr $ra   
         
#----- p = Insert_in_orden(first, valor) -----
#--- a0: First (Puntero al primer elemento de la lista)
#--- a1: Val (Valor a insertar)
#-- Devuelve el puntero al nuevo comienzo de la lista, ó 0 si no cambia
insert_in_order:

	 #-- Crear la pila
         addi $sp, $sp, -32
         sw $ra, 20($sp)
         sw $fp, 16($sp)
         addi $fp, $sp, 28


	#-- Guardar el puntero a la lista y el valor a insertar en la pila
	sw $a0, 0($fp)  #-- Guardar first
	sw $a1, -4($fp) #-- Guardar val

	#-- Crear nuevo nodo con el valor, sin enlazar
	#-- v0 = create(val, 0)
	move $a0, $a1
	li $a1, 0
	jal create
	#-- v0 Contiene el puntero al nuevo nodo creado
	
	#-- Recuperar los argumentos originales
	lw $a0, 0($fp)   #-- a0 = first
	lw $a1, -4($fp)  #-- a1 = Val
	
	#-- Caso: ¿Es el primer elemento?
	#-- Si val > first->val, terminar
	#-- first->val es 0($a0)
	lw $t0, 0($a0)  #--- $t0 = first->val
	bgt $a1, $t0, caso1
	
	
	##-- t1 = first
	##-- Usaremos t1 para recorrer la lista
	##-- Inicialmente a punta al primer elemento
	move $t1, $a0 
	
	#-- Recorrer la lista
bucle_insert:

        #-- t2 apunta al siguiente nodo
	#-- t2 = t1.next
	lw $t2, 4($t1)
		
	#-- ¿Es el ultimo nodo?
	# t2 == NULL??
	beq $t2,0, caso2  #-- Si, ir al caso 2
	
	#-- Caso 3. Si val > t2->val
	lw $t3, 0($t2)  #-- t3 = t2->val
	bgt $a1, $t3, caso3  #-- Si, ir al caso 3
	
	#-- t1 = t2;
	#-- Apuntar al siguiente nodo
	move $t1, $t2
	
	#-- Seguir recorriendo la lista
	b bucle_insert
	
caso3: #-- Introducir entre medias de t1 y t2
       #-- t1->next = v0 (nodo)
       sw $v0, 4($t1)
       
       #-- t1->next = t2
       sw $t2, 4($v0)
       
       #-- Retornar 0
       li $v0,0	
       b fin_insert
	
caso2: #-- Introducir el valor en el último nodo (cola)
	#-- t1->next = v0
	sw $v0, 4($t1)
	
	#-- Retornar 0
	li $v0,0
	
	b fin_insert
	

	#-- Introducir el valor en la cabeza
caso1:	
        #-- En v0 está en nuevo nodo que hemos creado
        #-- Lo colocamos delante
	#-------- v0->next = first
	sw  $a0, 4($v0)	
	
	#--- return v0

fin_insert:
        #-- Recuperar la pila		
	lw $ra, 20($sp)
        lw $fp, 16($sp)
        addi $sp, $sp, 32
	
	#-- Retornar
	jr $ra
	
  
#-----  void print(node *first): Imprimir los elementos de menor a mayor
print:
        #-- Crear marco de pila
	addi $sp, $sp, -32
        sw $ra, 20($sp)
        sw $fp, 16($sp)
        addi $fp, $sp, 28
	
	#-- Guardar en la pila a0 (fist)
	sw $a0, 0($fp)

	#-- ¿es el ultimo nodo?
	#-- first->next = 0?
	lw $t0, 4($a0)
	beq $t0,0, print_val
	
	#--- Imprime los anteriores
	#-- print(first->next)
	move $a0,$t0
	jal print
	
	#-- Imprime el valor de este nodo
	#-- Recuperar el puntero del nodo de la pila
	lw $a0, 0($fp)
	
print_val:	
	
	#-- Imprimir el valor (si es diferente del centinela)
	lw $a0, 0($a0)
	beq $a0,0,fin_print
	
	#-- Imprimir valor
	li $v0, 1
	syscall
	
	#-- Imprimir el \n
	li $v0,11
	li $a0,'\n'
	syscall

fin_print:

	#-- Recuperar la pila
	lw $ra, 20($sp)
        lw $fp, 16($sp)
        addi $sp, $sp, 32

	#-- Retornar
	jr $ra
	
	
	
