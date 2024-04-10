N = 16

addi $e0, $zero, pos_coeficientes
addi $e1, $zero, 1 # contador del numero de coeficientes a utilizar
ldrv $v0, $e0, 0 # Se cargan los coeficientes en v0
addi $e2, $zero, N # Condicion para cambiar de loop 
addi $e3, $zero, pos_entrada
ldrv $v1, $e3, 0 # Se cargan los primeros 16 datos de entrada 
addi $e4, $zero, 0 # registro para acumular el resultados
addi $e6, $zero, 0 # registro para controlar la suma
sub $e0, $e0, $e0 # Se reinicia e0
addi $e0, $zero, pos_salida

.firinit: 
    sdlv $e1, $e1, 0
    multv $v2, $v0, $v1
    b suma
    sub $e6, $e6, $e6
    str $e4, 0($e0)
    sub $e4 , $e4, $e4 
    addi $e0, $zero, 1
    addi $e1, $zero, 1
    beq $e1, $e2, fir
    b _firinit

.fir:
    sdlv $e1, $e1, 0
    sub $e2, $e2 , $e2
    addi $e2, $zero,  582896 # condicion de parada
    sub $e1, $e1, $e1
    addi $e1,$zero, 0 # contador para el loop

.fir_loop:
    multv $v2, $v0, $v1
    b sumafir
    sub $e6, $e6, $e6
    str $e4, 0($e0)
    sub $e4 , $e4, $e4
    addi $e3, $e3, 1 # Muevo a la siguiente x
    ldrv $v1, $e3, 0 # Se cargan los valores de entrada
    addi $e0, $zero, 1 # Muevo a la siguiente salida 
    addi $e1, $e1, 1 # Se suma al contador
    beq $e1, $e2, _end
    b _fir_loop 


.suma:
    add $e4, $e4, $v2($e6)
    addi $e6, $e6, 1
    beq $e6, $e1, _firinit
    b suma


.sumafir:
    add $e4, $e4, $v2($e6)
    addi $e6, $e6, 1
    beq $e6, $e1, _fir_loop
    b _sumafir

.end:
    end