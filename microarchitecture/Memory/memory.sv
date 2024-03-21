/*
Top Memory Module
Date: 16/03/24
FALTA VECTOR MEMORY
*/
`timescale 1 ps / 100 fs
module memory # (parameter N = 24) (
		input logic clk,

		input logic [N-1:0] instruction_address,	// from PC to A in instruction memory
		input logic [N-1:0] scalar_data_address,	// from ALUResult to A in data memory
		input logic [N-1:0] vector_data_address,	// NYI

		input logic [N-1:0] write_scalar_data,		// WriteData (RD2 from register file) to WD
		input logic [255:0] write_vector_data,		// NYI

		input logic InstructionMemRead,				// Always 1
		input logic ScalarMemRead,					// Always 1, NYI
		input logic VectorMemRead,					// NYI

		input logic ScalarMemWrite,					// MemWrite from Control Unit 
		input logic VectorMemWrite,					// NYI

		output logic [23:0] instruction,			// to Instruction after instruction memory
		output logic [23:0] scalar_data_read,		// ReadData from RD in data memory to MemtoRegMux
		output logic [255:0] vector_data			// NYI
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
        .clock (clk),
        .data_a (24'b0),		
        .data_b (write_scalar_data),
        .rden_a (InstructionMemRead),
        .rden_b (ScalarMemRead),
        .wren_a (1'b0),				// Instructions cant write
        .wren_b (ScalarMemWrite),
        .q_a (instruction),			// 24 bits
        .q_b (scalar_data_read)		// 24 bits
	);

	/* Vector Data Memory */
	// vector ram

	/*
	always @(posedge clk)
		if (ScalarMemWrite)
			$display("mem_address=", scalar_data_address, " - scalar_data_read=", scalar_data_read);
	*/

endmodule
