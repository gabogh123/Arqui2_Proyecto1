/*
Top Memory Module
16/03/24
FALTA VECTOR RAM
*/
`timescale 1 ps / 100 fs
module memory #(parameter N = 24) (
		input logic [N-1:0] instruction_address,
		input logic [N-1:0] scalar_data_address,
		input logic [N-1:0] vector_data_address,

		input logic [N-1:0] write_scalar_data,
		input logic [255:0] write_vector_data,

		input logic InstructionMemRead,
		input logic ScalarMemRead,
		input logic VectorMemRead,

		input logic ScalarMemWrite,
		input logic VectorMemWrite,
		
		input logic clk,

		output logic [23:0] instruction,
		output logic [23:0] scalar_data,
		output logic [255:0] vector_data
	);

	// Specific addresses for ips
	logic [11:0] in_address;
	logic [17:0] sd_address;	// 16384 addresses de 24 bits
	logic [17:0] vd_address;	// 32768 addresses de 256 bits

	// Bus length adjust
	assign in_address = instruction_address[13:0];
	assign sd_address = scalar_data_address[13:0];
	assign vd_address = vector_data_address[14:0];

	/* Scalar Data Memory */
	ram_scalar	instructions_and_scalar_data (
        .address_a (in_address),	// 13 bits
        .address_b (sd_address),	// 13 bits
        .clock (~clk),
        .data_a (24'b0),		
        .data_b (write_scalar_data),
        .rden_a (InstructionMemRead),
        .rden_b (ScalarMemRead),
        .wren_a (1'b0),				// Instructions cant write
        .wren_b (ScalarMemWrite),
        .q_a (instruction),			// 24 bits
        .q_b (scalar_data)			// 24 bits
	);

	/* Vector Data Memory */
	// vector ram

	/*
	always @(posedge clk)
		if (ScalarMemWrite)
			$display("mem_address=", scalar_data_address, " - scalar_data=", scalar_data);
	*/

endmodule
