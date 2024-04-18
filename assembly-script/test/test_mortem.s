 # data
  #  A: .word 5        A = 5 en la posicion 1000
  #  B: .word 3        B = 3 en la posicion 1001

.text
    # Cargar A en un registro
    //0
    addi $e0, $zero, 0x1 # $e0 = 1 
    //1
    sll $e0, $e0, 12 # $e0 = 1 0000 0000 0000
    //2
    addi $e3, $zero, 0x10 # $e3 = 0x10 
     //3
    lw $e1, ($e0) # Carga en $e1 lo que hay en la direccion de memoria que esta en $e0 (1000) 5

    lw $e2, 1($e0) # Carga en $e2 lo que hay en la direccion de memoria que esta en $e0+1 (1001) 3  
    //5
    # add A y B
    add $e3, $e1, $e2  # $e3 = 5 + 3 = 8 

	# Para guardar en la seccion de datos
    add $e0, $e0, $e0 # $e0 = 0x2000

 	//7
    sw $e3, 2($e0) # Guardo el valor de $e3 en 0x2002

    lw $e1, 2($e0) # Carga en $e1 lo que hay en la direccion de memoria que esta en $e0 (1000) 5
 