.data
    A: .word 5       # A = 5
    B: .word 3       # B = 3
    Result: .word 0  # Resultado = 0

.text
    # Cargar A en un registro
    lw $e0, A($zero)         # $e0 = 5
    
    # Cargar B en un registro 
    lw $e1, B($zero)  # $e1 = 3
    
    # add A y B
    add $e2, $e0, $e1  # $e2 = 5 + 3 = 8
    
    # sub B de A
    sub $e3, $e0, $e1  # $e3 = 5 - 3 = 2
    
    # Mul A por B
    mul $e4, $e0, $e1  # $e4 = 5 * 3 = 15
    
    # addi 10 a A
    addi $e0, $e0, 10  # $e0 = 5 + 10 = 15
    
    # subi 5 de B
    subi $e1, $e1, 5   # $e1 = 3 - 5 = -2
    
    # muli A por 2
    muli $e3, $e3, 2   # $e3 = 15 * 2 = 30

    sw $e2, Result($zero)
    
    b End

End:
    end $zero
    