_start:
    somi $e0, $zero, 2      # N-1
    som $e1, $zero, $zero   # Contador
    somi $e6, $zero, 582912

    somi $e2, $zero, 0x6000 # Salida
    sou $sp, $sp, 1
    gar $e2, ($sp)

    # Guarda las direcciones de memoria en el stack
    somi $e2, $zero, 0x00FFF # Coeficientes
    sou $sp, $sp, 1
    gar $e2, ($sp)

    somi $e2, $zero, 0x1FFF # Datos de Audio
    sou $sp, $sp, 1
    gar $e2, ($sp)

    somi $e2, $zero, $zero  # Acumulado

fir_loop_1:
    # carga el coeficiente en e4 
    car $e3, $sp
    som $e3, $e3, $e1
    car $e4, $e3

    # carga el data_audio en e5
    somi $sp, $sp, 1
    car $e3, $sp
    som $e3, $e3, $e1
    car $e5, $e3

    # multiplica coeficiente por audio data
    mltf $e4, $e4, $e5
    somf $e2, $e2, $e4

    # suma el dato al acumulado y guarda en la salida
    somi $sp, $sp, 1
    car $e3, $sp
    som $e3, $e3, $e1
    gar $e2, ($e3)
    
    soui $sp, $sp, 2

    somi $e1, $e1, 1
    cmpm $e1, $e0, fir
    sau fir_loop_1

fir:
    sou $sp, $sp, 1
    gar $e0, ($sp)
    
fir_loop_2:
    cmpm $e1, $e6, fin
    # reinicia el valor de N 
    car $e0, $sp
    somi $e0, $e0, 1 # N 
    somi $e2, $zero, $zero  # Acumulado
    
fir_loop_3:
    soui $e0, $e0, 1 # N-1
    # carga el coeficiente en e4 
    somi $sp, $sp, 1 # sp = -3
    car $e3, $sp
    som $e3, $e3, $e0
    car $e4, $e3
    sou $sp, $sp, 2 # sp = -5
    gar $e4, ($sp)

    # carga el data_audio en e5
    somi $sp, $sp, 3 # sp = -2
    car $e4, $sp
    sou $e3, $e1, $e0
    som $e3, $e4, $e3
    car $e5, $e3

    # multiplica coeficiente por audio data
    sou $sp, $sp, 2 # sp = -5
    car $e4, $sp
    mltf $e4, $e4, $e5
    somf $e2, $e2, $e4

    somi $sp, $sp, 1 # sp = -4
    cmpm $e0, $zero, save_value
    sau fir_loop_3

save_value: 
    # guarda en la salida
    somi $sp, $sp, 3 # sp = -1
    car $e3, $sp
    som $e3, $e3, $e1
    gar $e2, ($e3)
    somi $e1, $e1, 1
    soui $sp, $sp, 3 # sp = -4
    sau fir_loop_2

fin:
    end

