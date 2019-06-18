
#-----------------------------
#-- No hay segmento de datos
#-- Se usa memoria dinamica
#----------------------------	 


#--- Consideraciones iniciales, tras leer el enunciado
#--- Tenemos que tratar con caracteres. Para imprimir caracteres aislados usamos el servicio
#--- printchar. Para leer caracteres de la consola usamos el servio Readchar:
#----   Son los  Servicios 11 y 12
#---- Los caracteres los almacenamos como palabras en el campo car de cada nodo


	.text

#------------------------------
#-- PROGRAMA PRINCIPAL
#-- MAIN
#------------------------------
        #--------------
        #-- PARTE I:
        #---------------

	#-- ESPECIFICADO POR EL ENUNCIADO
	#-- Crear el primer nodo, inicializado con el caracter '>'
	li $a0, '>'
	jal create
	
	#-- ESPECIFICADO POR EL ENUNCIADO
	#-- s0 debe apuntar al primer nodo
	move $s0, $v0
	
        #-- ESPECIFICDO POR EL ENUNCIADO
	#-- Imprimir el nodo aislado
	move $a0, $s0
	jal print_node

	#----------------------
        #-- PARTE II
        #----------------------

        #-- ESPECIFICADO POR EL ENUNCIADO
	#-- Pedir al usuario los caracteres e 
	#-- irlos introduciendo en la lista hasta 
	#-- recibir '\n' (Tecla enter)
loop_input:	
	#-- Pedir caracter al usuario
	li $v0, 12 #-- Readchar
	syscall
	
	#-- Comprobar si es ENTER
	li $t0, '\n'
	beq $v0, $t0, fin_input
	
	#-- No es ENTER:
	#-- Insertar el caracter en un nodo nuevo
	
	#-- Para respetar el convenio, a0 se
	#-- debe iniciarlizar con s0
	move $a0, $s0
	move $a1, $v0
	jal insert_node
	
	#-- ¡¡Cuidado!!-- Despues de una llamada a subrutina
	#-- los registros temporales supondremos que estan
	#-- a indefinido (para cumplir el convenio)
	
	b loop_input

	#-- El usuario ha pulsado Enter:
fin_input:	
				
	#-- ESPECIFICADO POR EL ENUNCIADO:		
	#-- Imprimir el mensaje
	move $a0, $s0
	jal print

	#-- Terminar
	li $v0, 10
	syscall

#-----------------------------------------------------------------------------
#--- SUBRUTINAS PEDIDAS
#-----------------------------------------------------------------------------

#--------------------------------------------------------
#--- Create: Crear un nodo vacio, con next apuntando a 0 
#--- Entradas: 
#---   a0: Caracter con el que inicializar el nodo
#--- Devuelve: Puntero al nodo creado
#--------------------------------------------------------
create:

      #-- No es necesario crear la pila
      #-- porque no hay llamada a otra subrutinas
      #-- Si se ha creado pila no pasa nada
      
      #-- Para no perder a0 lo metemos en un registro temporal t0
      #-- En las llamadas a Syscall el sistema operativo
      #-- preserva el valor de todos los registros del procesador
      #-- No hace falta guardarlos en la pila
      
      #-- Guardamos a0 en t0 porque a0 hay que usarlo como parametro de  
      #-- entrada de la llamada al sistema
      move $t0, $a0

      #-- Reservar memoria para un nodo
      #-- Cada nodo necesita 2 palabras (8 bytes)
      li $a0, 8   #-- Cantidad de bytes a reservar
      li $v0, 9   #-- Servicio: sbrk
      syscall
      #-- En v0 tenemos el puntero al nuevo nodo

      #-- Guardar el caracter en el nodo
      #-- p->car = t0
      sw $t0, 0($v0)
      
      #-- El campo next se inicializa a 0 (null)
      #-- p->next = 0
      sw $zero, 4($v0)
      
      #-- En v0 se devuelve el puntero al nodo
      jr $ra

#---------------------------------------------------------
#--- Insertar un nodo al final
#--- Entradas:
#--    a0: Puntero al nodo
#--    a1: Valor a insertar
#--  Devuelve: Nada
#---------------------------------------------------------
insert_node:

        #--- Necesitamos la pila porque:
        #--  1) Hacemos una llamada a subrutina (hay que guardar $ra)
        #--  2) Necesitamos guardar $a0 para respetar el convenio

        #-- Crear la pila
        addi $sp, $sp, -32
        sw $ra, 20($sp)
        sw $fp, 16($sp)
        addi $fp, $sp, 28
        
        #-- Recorrer la lista hasta llegar al ultimo nodo

loop1:
	#-- Puntero al siguiente nodo
	#-- t0 = p->next
	lw $t0, 4($a0)

	#-- Es el ultimo nodo?
	beq $t0, $zero, fin_lista

	#-- No es el ultimo
	#-- Apuntar al siguiente
	move $a0, $t0
	
	b loop1
	
	#-- Es el ultimo nodo
	#-- a0 apunta a este ultimo nodo
fin_lista:
	
	#-- Para respetar el convenio, debemos
	#-- guardar a0 en la pila porque luego lo
	#-- necesitaremos
	#-- Guardar a0 en la pila
	sw $a0, 0($fp)
	
	#-- Crear nodo vacio. Metemos en a0 el valor del caracter a insertar, que esta en a1
	move $a0, $a1
	jal create
	
	#-- ¡¡Cuidado!!-- Despues de una llamada a subrutina
	#-- los registros temporales supondremos que estan
	#-- a indefinido (para cumplir el convenio)
	
	#-- Recuperar a0 de la pila
	lw $a0, 0($fp)
	
	#-- Añadirlo a la lista
	sw $v0, 4($a0)
	
	#-- Actualizar a0 para apuntar al nuevo nodo creado
	move $a0, $v0
	
	#-- Recuperar la pila
        lw $ra, 20($sp)
        lw $fp, 16($sp)
        addi $sp, $sp, 32
        
        #-- Retornar
	jr $ra

#--------------------------------------------------
#-- Imprimir el caracter de un nodo
#-- Entradas:
#--    a0: Puntero al nodo
#-- Devuelve: Nada
#--------------------------------------------------
print_node:
	
	#-- No es necesario crear la pila
        #-- porque no hay llamada a otra subrutinas
        #-- Si se ha creado pila no pasa nada

	#-- Imprimir el caracter
	lw $a0, 0($a0)
	li $v0, 11  #-- Print Char
	syscall
	
	#-- Terminar
	jr $ra
	

#---------------------------------------------------
#-- Imprimir todos los caracteres de la lista
#-- Entradas
#--   a0: Puntero al primer nodo del mensaje
#-- Devuelve: Nada
#-----------------------------------------------------
print:

        #--- Necesitamos la pila porque:
        #--  1) Hacemos una llamada a subrutina (hay que guardar $ra)
        #--  2) Necesitamos guardar $a0 para respetar el convenio

        #-- Crear la pila
        addi $sp, $sp, -32
        sw $ra, 20($sp)
        sw $fp, 16($sp)
        addi $fp, $sp, 28

loop2:

	#-- Si hemos llegado al final, se termina
	beq $a0, $zero, fin_print

	#-- Para respetar el convenio, debemos
	#-- guardar a0 en la pila porque luego lo
	#-- necesitaremos
	#-- Guardar a0 en la pila
	sw $a0, 0($fp)

	#-- Imprimir el nodo actual
	jal print_node
	
	#-- ¡¡Cuidado!!-- Despues de una llamada a subrutina
	#-- los registros temporales supondremos que estan
	#-- a indefinido (para cumplir el convenio)
	
	#-- Recuperar a0 de la pia
	lw $a0, 0($fp)
	
	#-- Apuntar al siguiente nodo
	#-- a0 = a0->next
	lw $t0, 4($a0)
	move $a0, $t0
	
	b loop2
	
fin_print:		
				
	#-- Recuperar la pila
        lw $ra, 20($sp)
        lw $fp, 16($sp)
        addi $sp, $sp, 32	

	#-- Retornar
	jr $ra

      
