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
    lw $e1, ($e0) # Carga en $e1 lo que hay en la direccion de memoria que esta en $e0 (1000) 5
    //3
    lw $e2, 1($e0) # Carga en $e2 lo que hay en la direccion de memoria que esta en $e0+1 (1001) 3  
    //4
    # add A y B
    add $e3, $e1, $e2  # $e3 = 5 + 3 = 8 
    //5
    # Para guardar en la seccion de datos
    add $e0, $e0, $e0 # $e0 = 0x2000
    //6
    sw $e3, 2($e0) # Guardo el valor de $e3 en 0x2002 
    //7
    addi $e4, $zero, 0xa # Carga un 10 en el registro $e4 
    //8
    # sub B de A
    sub $e5, $e4, $e3  # $e5 = 10 - 8 = 2
    //9
    # Mul A por B
    mul $e6, $e4, $e3  # $e6 = 10 * 8 = 80
    //10
    sw $e6, 3($e0) # Guardo el valor de $e06 en 0x2003 
    //11
    # subi 5 de B
    subi $e0, $e6, 0xb   # $e0 = 80 - 11 = 69
    //12
    # muli A por 2
    muli $e1, $e5, 0x8   # $e1 = 2 * 8 = 16 1000
    //13
    slr $e1, $e1, 2 #$ e1 = 10 por el shift right 
    //14
    beq $e0, $e1, 0000 # beq no se cumple
    //15
    beq $e1, $e5, b1001 # beq se cumple, debe cambiar a la direccion 0001
    //16
    add $e0, $e1, $e2 # Esta instruccion tiene que ser saltada
    //17
    bgt $e6, $e4, 0000 # $e6=80 $e4=10, debe pasar a la direccion 0000 
  
