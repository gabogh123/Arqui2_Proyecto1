/*
Performance Monitor

Date: 10/04/24
*/
module performance_monitor (
	    input logic clk,
        input logic print,
		input logic instruction_fetched,
		input logic hazard_detected,
		input logic alu_operation_arithmetic,
		input logic MemRead,
		input logic MemWrite,

		output logic [23:0] counters[4:0]
	);

    /* Data array */
    reg [23:0] pmu_registers[4:0]; 
    /*
    pmu_registers[0] para los ciclos totales por instrucción (CPI).
    pmu_registers[1] para las instrucciones.
    pmu_registers[2] para los stalls.
    pmu_registers[3] para las operaciones aritméticas realizadas.
    pmu_registers[4] para los accesos a memoria.
    */


	always @(posedge clk) begin
        // Contador de ciclos
        pmu_registers[0] <= pmu_registers[0] + 1;

        // Contador de instrucciones (incrementado por la señal apropiada de la unidad de instrucción)
        if (instruction_fetched)
            pmu_registers[1] <= pmu_registers[1] + 1;

        // Contador de stalls (incrementado por la señal de stall de la Hazard Unit)
        if (hazard_detected)
            pmu_registers[2] <= pmu_registers[2] + 1;

        // Contador de operaciones aritméticas
        if (alu_operation_arithmetic)
            pmu_registers[3] <= pmu_registers[3] + 1;

        // Contador de accesos a memoria
        if (MemRead || MemWrite)
            pmu_registers[4] <= pmu_registers[4] + 1;

    end

    assign counters = pmu_registers;

endmodule
