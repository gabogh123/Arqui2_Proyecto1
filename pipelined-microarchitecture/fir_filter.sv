/*
Top module para el filtrador FIR
Date: 20/03/24
FALTA VECTOR LOGIC
*/
module fir_filter # (parameter N = 24) (
		input  logic clk,
		input  logic rst,
		input  logic pwr,
		input  logic dbg,
		input  logic stp,

		output logic out
	);

	timeunit 1ps;
    timeprecision 1ps;

	logic enable;
	logic eclk;

	wire [N-1:0] instruction;
	wire [N-1:0] read_data_scalar;
	wire [255:0] read_data_vector;
	
	wire [N-1:0] PC;
	wire [N-1:0] data_address_scalar;

	wire MemWrite_scalar;

	wire  [N-1:0] write_data_scalar;

	/* Inicio del Procesador al presionar un boton */
	always @ (negedge pwr) begin
		if (~pwr)
			enable = 1;
	end

	/* Inicio del clock al presionar el boton */
	assign eclk = clk & enable;

	/* ASIP Processor */
	pipelined_processor # (.N(N)) asip (.clk(eclk),
										.rst(!pwr),
										.en(enable),
										.Instr(instruction),
										.ReadData_scalar(read_data_scalar),
										.PC(PC),
										.MemWrite_scalar(MemWrite_scalar),
										.ALUResult_scalar(data_address_scalar),
										.WriteData_scalar(write_data_scalar));

	/* Instruction, Scalar and Vector Memory */
	memory # (.N(N)) full_memory (.clk(eclk),
								  .pc_address(PC),
								  .data_address_scalar(data_address_scalar),
								  .data_address_vector(24'b0),
								  .write_data_scalar(write_data_scalar),
								  .write_data_vector(255'b0),
								  .MemWrite_scalar(MemWrite_scalar),
								  .MemWrite_vector(1'b0),
								  .instruction(instruction),
								  .read_data_scalar(read_data_scalar),
								  .read_data_vector(read_data_vector));
					

	assign out = pwr & stp & dbg;

endmodule
