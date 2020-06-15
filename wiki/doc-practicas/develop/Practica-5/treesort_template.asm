# Sugerencia de utilización de los registros
# $s0 – Nodo raíz del árbol
# $s1 – Siguiente número introducido por el usuario
# $s2 – Valor centinela (número 0)


main:
  
  # Paso 1: crear el nodo raíz
  # root = tree_node_create ($s2, 0, 0);
  ##......
  jal tree_node_create
  ##...

  # Paso 2: leer números e insertarlos en el árbol hasta leer el 0
  # in_loop:
  #  ...
  #  jal tree_insert # tree_insert (number, root);
  #  ...
  #end_in:

  # Paso 3: imprimir los subárboles izquierdo y derecho
  #...
  #jal tree_print # tree_print(left_tree);
  #...
  #jal tree_print # tree_print(right_tree);
  #...
# end main


# tree_node_create (val, left, right): crear un nuevo nodo con el valor indicado y
  # con los punteros a los subárboles y izquierdo y derecho indicados

tree_node_create:
  # Crear pila
  # Invocar sbrk syscall
  # Comprobar si queda memoria
  # Liberar pila
  # Retornar
  # end tree_node_create
  
# tree_insert (val, root): crea un nuevo nodo y lo inserta en el árbol de forma
  # ordenada

tree_insert:
  # Crear pila
  # Crear un nuevo nodo, tree_node_create (val, 0, 0);
  #jal tree_node_create
  #...
  # Insertar el nuevo nodo creado implementando el siguiente algoritmo en C
  # for (;;)
  # {
  #   root_val = root->val;
  #   if (val <= root_val) // Recorrer subárbol izquierdo
  #   {
  #      ptr = root->left;
  #      if (ptr != NULL)
  #      {
  #        root = ptr;
  #        continue;
  #      }
  #    else
  #    {
  #      root->left = new_node;
  #      break;
  #    }
  #  }
  #  else // Recorrer subárbol derecho
  # {
  #    // Igual que para el subárbol izquierdo
  # }
  # Liberar pila
  # Retornar
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
  #...
  #jal tree_print # Recursivo por la izquierda
  #...
  #jal tree_print # Recursivo por la derecha
  #...
  # Liberar pila
  # Retornar
# end tree_print  
  
