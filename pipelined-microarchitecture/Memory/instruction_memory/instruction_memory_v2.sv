/*
Instruction memory module v2
Date: 31/03/24
*/
module instruction_memory_v2 # (parameter N = 24) (
        input  logic [13:0] address,
        output logic [N-1:0] instruction
    );

    // Declaración de memoria
    logic [N-1:0] memoria [1024:0];

    // Tarea para cargar la memoria desde un archivo .mif
    task cargar_memoria();
        $readmemb("../../Memory/instruction_memory/instructions.txt", memoria);
    endtask

    // Llama a la tarea para cargar la memoria al inicio
    initial begin
        cargar_memoria();
    end

    // Acceso a la memoria
    assign instruction = memoria[address];

endmodule
