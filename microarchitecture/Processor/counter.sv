/*
Counter module
Date: 01/04/24
*/
module counter # (parameter MAX_VALUE = 15)(
    input logic clk,           // Señal de reloj
    input logic rst,         // Señal de reinicio
    output logic count         // Valor lógico que se incrementa
);

// Definición de variables locales
logic [$clog2(MAX_VALUE):0] counter;    // Contador de tamaño variable basado en MAX_VALUE

// Proceso siempre activo para la lógica del contador
always_ff @(posedge clk, posedge rst)
begin
    if (rst)              // Si hay señal de reinicio, reiniciar contador
        counter <= 0;
    else if (counter == MAX_VALUE) // Si el contador llega a su máximo, reiniciarlo
        counter <= 0;
    else
        counter <= counter + 1;     // Incrementar el contador
end

// Asignar el valor lógico basado en el valor del contador
assign count = (counter == 0) ? 1'b0 : 1'b1;

endmodule
