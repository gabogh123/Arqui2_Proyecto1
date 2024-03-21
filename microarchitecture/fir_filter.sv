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
	wire [N-1:0] scalar_data_read;
	wire [255:0] vector_data_read;
	
	wire [N-1:0] pc_address;
	wire [N-1:0] scalar_data_address;

	wire mem_write_scalar;

	wire  [N-1:0] write_scalar_data;

	/* Inicio del Procesador al presionar un boton */
	always @ (negedge pwr) begin
		if (~pwr)
			enable = 1;
	end

	/* Inicio del clock al presionar el boton */
	assign eclk = clk & enable;


	/* ASIP Processor */
	processor # (.N(N)) asip (.clk(eclk),
							  .rst(rst),
							  .instruction(instruction),
							  .read_scalar_data(scalar_data_read),
							  .pc_address(pc_address),
							  .MemWrite(mem_write_scalar),
							  .alu_scalar_result(scalar_data_address),
							  .write_scalar_data(write_scalar_data));

	/* Instruction, Scalar and Vector Memory */
	memory # (.N(N)) full_memory (.clk(eclk),
								  .instruction_address(pc_address),
								  .scalar_data_address(scalar_data_address),
								  .vector_data_address(24'b0),
								  .write_scalar_data(write_scalar_data),
								  .write_vector_data(1'b0),
								  .InstructionMemRead(1'b1 & eclk),
								  .ScalarMemRead(1'b1 & eclk),
								  .VectorMemRead(1'b0),
								  .ScalarMemWrite(mem_write_scalar),
								  .VectorMemWrite(1'b0),
								  .instruction(instruction),
								  .scalar_data_read(scalar_data_read),
								  .vector_data(vector_data_read));
					

	assign out = pwr & stp & stp;

endmodule
