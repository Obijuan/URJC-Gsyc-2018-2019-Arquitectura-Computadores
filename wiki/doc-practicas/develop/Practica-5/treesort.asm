# Sugerencia de utilización de los registros
# $s0 – Nodo raíz del árbol (root)
# $s1 – Siguiente número introducido por el usuario
# $s2 – Valor centinela (número 0)

	       .data
msg_test:      .asciiz "Test!!!\n"
msg_resultado: .asciiz "Resultado:\n"
msg_fin:       .asciiz "\nFin\n"

 	  .text

main:
  
  #------------ Paso 1: crear el nodo raíz
  
  #-- Valor centinela
  li $s2, 0
  
  move $a0, $s2  #-- Valor centinela: 0
  li $a1, 0
  li $a2, 0
  # root = tree_node_create ($s2, 0, 0);
  jal tree_node_create
  
  #-- Guardar en s0 el nodo raiz
  move $s0, $v0

  #--- DEBUG!!
  ##move $a0, $v0
  ##jal tree_print
  ##j exit


  #------------ Paso 2: leer números e insertarlos en el árbol hasta leer el 0
in_loop:

  #-- Leer un entero introducido por el usuario
  li $v0, 5
  syscall 
  
  #-- En V0 tenemos el numero leido
  #-- Lo metemos en si
  move $s1, $v0
  
  #-- Si el entero es 0, terminar
  beq $s1, $s2, print
  
  #-- Insertar el numero en el arbol
  # Tree_insert (number, root)
  move $a0, $s1  #-- Argumento 1
  move $a1, $s0  #-- Argumento 2
  jal tree_insert 
  
  #-- Repetir
  j in_loop


# Paso 3: imprimir los subárboles izquierdo y derecho
print:

  #-- Imprimir mensaje
  li $v0, 4
  la $a0, msg_resultado
  syscall

   # tree_print(left_tree);
   move $a0, $s0
   jal tree_print
   
    #-- Imprimir mensaje
  li $v0, 4
  la $a0, msg_fin
  syscall


exit:
  #-- Exit
  li $v0, 10
  syscall
# end main




# tree_node_create (val, left, right): crear un nuevo nodo con el valor indicado y
# con los punteros a los subárboles y izquierdo y derecho indicados

tree_node_create:

  #--------- Crear pila  
  addi $sp,$sp, -32  #-- Espacio para la pila
  sw $ra, 16($sp)    #-- Direccion de retorno
  sw $fp, 20($sp)    #-- Frame pointer
  add $fp, $sp, 28
  
  #-- Guardar val en la pila
  sw $a0, 0($fp)
  
  #-------- Invocar sbrk syscall
  
  #-- Cada nodo son 12 bytes
  li $a0, 12
  li $v0, 9    #-- sbrk
  syscall
  
  # Comprobar si queda memoria
  #-- $v0 es 0?
  bne $v0, 0, mem_ok
  
  #-- NO HAY MEMORIA!!!!!
  #-- Guardar 0 en S0 y terminar!
  #-- Código de error 1
  li $a0, 1
  li $v0, 17
  syscall
  
mem_ok:

  #----- Almacenar el valor
  #- Recuperar va-l de la pila
  lw $a0, 0($fp)
  
  #-- Almacenar val en el nodo creado
  sw $a0, 0($v0) 

  #--------- Recuperar la pila
  lw $ra, 16($sp)
  lw $fp, 20($sp)
  addi $sp, $sp, 32
  
  #--------- Retornar
   jr $ra 
 # end tree_node_create
 
  
 
#--------- tree_insert (val, root): crea un nuevo nodo y lo inserta en el árbol de forma ordenada

tree_insert:
  # Crear pila
  addi $sp, $sp, -32
  sw $ra, 16($sp)
  sw $fp, 20($sp)
  addi $fp, $sp, 28
  
  #-- Guardar los registro a0 y a1 (con los argumentos: valor y root)
  sw $a0, 0($fp)
  sw $a1, -4($fp)
  
  
  # Crear un nuevo nodo, tree_node_create (val, 0, 0);
  li $a1, 0
  li $a2, 0
  jal tree_node_create
  
  #-- En v0 tenemos el puntero al nuevo nodo creado
  
  #-- Recuperar los registros a0 = val y a1 = root
  lw $a0, 0($fp)  #-- Val
  lw $a1, -4($fp) #-- root
    
  #...
  # Insertar el nuevo nodo creado implementando el siguiente algoritmo en C
  # for (;;)
  tree_insert_loop:
 
      #-- Leer el valor del nodo
      #   root_val = root->val;
      lw $t0, 0($a1)
      
      #-- if (val <= root_val) --> recorrer arbol izquierdo
      bgt $a0, $t0, insertar_derecha #-- En caso contrario, insertamos por la derecha      
  
      #--- Insertar por la izquierda
      #-- $t0: val
      #-- $t1: left
      #-- $t2: right
      #-- Leer puntero arbol izquierdo
      lw $t1, 4($a1)  #-- ptr = root->left; 
      
      #-- Si es NULL, hay que
      beq $t1, $zero, colocar_izquierda
      
      #-- Si != NULL seguimos recorriendo
      # root = ptr;
      move $a1, $t1
      j tree_insert_loop
      
 colocar_izquierda:
      #-- root->left = new_node;
      sw $v0, 4($a1)
      j end_tree_insert
  
  
  #--- Insertar por la derecha
 insertar_derecha:
 
      #-- $t0: val
      #-- $t1: left
      #-- $t2: right
      #-- Leer puntero arbol derecho
      lw $t1, 8($a1)  #-- ptr = root->right; 
      
      #-- Si es NULL, insertamos por al dderecha
      beq $t1, $zero, colocar_derecha
      
      #-- Si != NULL seguimos recorriendo
      # root = ptr;
      move $a1, $t1
      j tree_insert_loop
      
 colocar_derecha:
      #-- root->right = new_node;
      sw $v0, 8($a1)
      j end_tree_insert
 # TODO
 #   if (val <= root_val) // Recorrer subárbol izquierdo
  #   {
  #      ptr = root->left;
  #      if (ptr != NULL)
  #      {
  #        root = ptr;
  #        continue;
  #      }
  #      else
  #      {
  #        root->left = new_node;
  #        break;
  #      }
  #    }
  #  else // Recorrer subárbol derecho
  # {
  #    // Igual que para el subárbol izquierdo
  # }
 
  
  #-- Traza de prueba
  li $v0, 4
  la $a0, msg_test
  syscall
  
  
 end_tree_insert:
  
  # Liberar pila
  lw $ra, 16($sp)
  lw $fp, 20($sp)
  addi $sp, $sp, 32
  
  # Retornar
  jr $ra
  
# end tree_insert  
  
  
  
# tree_print(tree): recorre el árbol de forma inorder imprimiendo el
# valor de cada nodo. Código C equivalente:
# void tree_print (tree_t *tree)
# {
#   if (tree != NULL)
#   {
#     tree_print (tree->left);
#     printf ("%d\n", tree->val);
#     tree_print (tree->right);
#   }
# }

tree_print:
  # Crear pila
  addi $sp, $sp, -32
  sw $ra, 20($sp)
  sw $fp, 16($sp)
  addi $fp, $sp, 28
  
  #-- $a0 contiene el arbol a imprimir
  #-- Guardar a0 en la pila
  sw $a0, 0($fp)
  
  #-- Si el arbol es NULL, retornamos sin mas
  beq $a0, $zero, tree_print_end
  
  #-- tree_print (tree->left);
  lw $a0, 4($a0)
  jal tree_print
  
  #--- printf ("%d\n", tree->val);
  lw $a0, 0($fp) ##-- Recuperar tree
  lw $a0, 0($a0) ##-- Almacenar en a0 tree->val
  li $v0, 1
  syscall
  
   #-- Print \n o espacio
  li $v0, 11
  li $a0, ' '
  syscall 
  
  #-- tree_print (tree->right);
  lw $a0, 0($fp) ##-- Recuperar tree
  lw $a0, 8($a0)
  jal tree_print
 
  
  tree_print_end:
  
  # Liberar pila
  lw $ra, 20($sp)
  lw $fp, 16($sp)
  addi $sp, $sp, 32
  
  # Retornar
  jr $ra
  
# end tree_print  
  
