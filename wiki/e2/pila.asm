	.data
msg1:	.asciiz "Nodo eliminado: " 


	.text
	
	#-- Crear nodo inicial, con val = 0, next = 0
	#-- p = create_node(0, 0)  #-- a0 = 0,  a1 = 0 
	#-- Lo creamos para que en la pila siempre haya al menos un nodo
	#-- En la rutina de impresión no imprimiremos cuando el valor sea 0
	li $a0, 0
	li $a1, 0
	jal create  #-- Devuelve el puntero (p) en $v0
	
	#-- Meter en s0 el puntero al primer nodo
	#-- Lo dice así el enunciado
	move $s0, $v0
	
	
	#-- Bucle para introducir valores en la lista
bucle:	
	#-- Pedir número al usuario
	li $v0, 5
	syscall
	
	#-- V0 contiene el número pedido
	#-- Si es 0, terminar
	beq $v0, 0, fin
	
	#-- Push($s0, $v0) #-- Meter valor $v0 en la lista $s0
	move $a0, $s0
	move $a1, $v0
	jal push
	
	#-- Actualizar s0 con la cima de la pila
	move $s0, $v0
	
	b bucle

fin:

	#--- Pedir nodo a eliminar
	li $v0, 5
	syscall
	

	#-- Eliminar nodo
	#-- remove($s0, $v0)    #-- Eliminar el nodo con valor val de la lista
	move $a0, $s0
	move $a1, $v0
	jal remove
	
	#-- V0 contiene el puntero al nodo a eliminar
	#-- Lo pasamos a $s1 para no perderlo
	move $s1, $v0
	
	
	#----------- Imprimir valor del nodo eliminado, solo si $s1 es != NULL
	beq $s1,0, print_list #-- Valor no encontrado. Imprimir la lista
	
	la $a0, msg1   #-- Imprimir cadena
	li $v0, 4
	syscall
	
	#-- Imprimir valor (p->next), sólo si el puntero != NULL
	lw $a0, 0($s1)
	li $v0, 1
	syscall
	
	#-- Imprimir el \n
	li $v0,11
	li $a0,'\n'
	syscall

print_list:						
	#------- Imprimir la lista en orden natural
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

#----- Función de insertar un elemento en la cima
#-- node_t * push(node_t *top, int val)   
#--- Pseudocódigo
#--  p = create(val, top)
#--  return p
#-----------------------------
#-- a0 = top, a1 = val
push:

      #-- Crear pila
      addi $sp, $sp, -32
      sw $ra, 20($sp)
      sw $fp, 16($sp)
      addi $fp, $sp, 28  
      
      #-- Guardar argumentos a0, y a1 en la pila
      sw $a0, 0($fp)    #-- Guardar top
      sw $a1, -4($fp)   #-- Guardar val

      #-- Crear nodo: create(val, top-)
      lw $a0, -4($fp)   #-- a0: val
      lw $a1, 0($fp)    #-- a1: top
      jal create  
      
      #-- V0 contiene el puntero al nodo nuevo creado
      #-- Es lo que se devuelve
      
      #-- Recuperar la pila
      lw $ra, 20($sp)
      lw $fp, 16($sp)
      addi $sp, $sp, 32

      #-- Retornar
      jr $ra  
      
      
#-- Remove:  node_t * remove(node_t *top, int val) 
#-- Pseudocódigo
#-- Se usan los punteros t1 y t2 para recorrer la lista
#-- t1 = top  #-- T1 apunta inicialmente a la cima
#-- for(;;) {
#--   t2 = t1->next
#--   if (t2 == NULL) return 0;  //-- No encontrado
#--   if (t2->val == val) {   //-- Valor encontrado
#--     t1->next = t2->next)  //-- Enlazar con el siguiente
#--     return t2             //-- Devolver el nodo encontrado
#--   }
#--   t1 = t2;               //-- Apuntar al siguiente nodo
#-- }      
#----------------------
#-- a0: top,  a1: val
#--
remove:
	#-- t1 = top
	move $t1, $a0
	
remove_loop:
	lw $t2, 4($t1)  #-- t2 = t1->next
	beq $t2, 0, not_found  #-- Si t2 es 0, retornar 0 y terminar
	
	lw $t3, 0($t2)  #-- t3 = t2->val
	beq $t3, $a1, found  #-- Es t2->val == val? Encontrado!
	
	#-- Pasar al siguiente
	move $t1, $t2
	b remove_loop
	
	#-- Encontrado. Eliminarlo
found:  
	#-- t1->next = t2-> next
	lw $t3, 4($t2)  #-- t3 = t2->next
	sw $t3, 4($t1)  #-- t1->next = t3
	
	#-- Return t2
	move $v0, $t2
	jr $ra
	
	
not_found:
	li $v0,0
	jr $ra
      
      
            
                        
#----- Funcion de impresion
#  void print(node_t *top)
#-- Pseudocódigo
#--   if (top->next =! null) {
#       print(top->next);
#     }
#     printf(“%d\n”, top->val);
#     return;
#------------------
#-- a0: top (Puntero a la cima de la pila)     
print:
	
      #-- Crear la pila
      addi $sp, $sp, -32
      sw $ra, 20($sp)
      sw $fp, 16($sp)
      addi $fp, $sp, 28     
      
      #-- Almacenar a0 en la pila
      sw $a0, 0($fp)
      
      #-- Si top->next == NULL, nos vamos a imprimir
      lw $t0, 4($a0)   #-- t0 = top->next
      beq $t0, 0, print_val
      
      #-- Llamar a print(top->next)
      move $a0, $t0   #-- a0 = top->next
      jal print 
      
print_val:
        #-- Imprime el valor de este nodo
	#-- Recuperar el puntero del nodo de la pila
	lw $a0, 0($fp)
	
	#-- Obtener el valor del nodo
	lw $a0, 0($a0)
	
	#-- Solo se imprime si es diferente del centinela (0).
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
	                  