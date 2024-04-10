N = 16

somi $e0, $zero, 0x08E500 #Se cargan la posicion de los coeficiente
carv $v0, $e0, 0 # Se cargan los coeficientes en v0
somi $e1, $zero, 1 # contador del numero de coeficientes a utilizar
somi $e2, $zero, 8 # Condicion para cambiar de loop 
somi $e3, $zero, 0x00000 #Se carga la posicio donde inicia la entrada
carv $v1, $e3, 0 # Se cargan los primeros 16 datos de entrada 
somi $e4, $zero, 0 # regigaro para acumular el resultados
somi $e6, $zero, 0 # regigaro para controlar la suma
sou $e0, $e0, $e0 # Se reinicia e0
somi $e0, $zero, 0x08E508 #Se guarda la posicion donde se empieza a escribir la salida 

.firinit: 
    sdlv $e1, $e1, 0 # Numero de espacios
    mltv $v2, $v0, $v1
    sau suma
    sou $e6, $e6, $e6
    gar $e4, 0($e0)
    sou $e4 , $e4, $e4 
    somi $e0, $zero, 1
    somi $e1, $zero, 1
    cmpe $e1, $e2, fir
    sau _firinit

.fir:
    sdlv $e1, $e1, 0
    sou $e2, $e2 , $e2
    somi $e2, $zero,  582880 # condicion de parada
    sou $e1, $e1, $e1
    somi $e1,$zero, 0 # contador para el loop

.fir_loop:
    mltv $v2, $v0, $v1
    b sumafir
    sou $e6, $e6, $e6
    gar $e4, 0($e0)
    sou $e4 , $e4, $e4
    somi $e3, $e3, 1 # Muevo a la siguiente x
    carv $v1, $e3, 0 # Se cargan los valores de entrada
    somi $e0, $zero, 1 # Muevo a la siguiente salida 
    somi $e1, $e1, 1 # Se suma al contador
    cmpe $e1, $e2, _end
    sau _fir_loop 


.suma:
    getv $e2, $v2, $e6
    som $e4, $e4, $e2
    somi $e6, $e6, 1
    sou $e2, $e2, $e2
    somi $e2, $zero, 8 # Condicion para cambiar de loop 
    cmpe $e6, $e1, _firinit
    sau suma


.sumafir:
    getv $e2, $v2, $e6
    som $e4, $e4, $e2
    somi $e6, $e6, 1
    sou $e2, $e2, $e2
    somi $e2, $zero, 582880 # Condicion para cambiar de loop 
    cmpe $e6, $e1, _fir_loop
    sau _sumafir

.end:
    fin