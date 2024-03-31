/*
Control Unit module 
Date: 20/3/2024
*/
module control_unit(

		input  logic clk,
		input  logic rst,
		
		input  logic [2:0] Opcode,
		input  logic V,
		input  logic [2:0] Funct,
		input  logic [3:0] Rd,

		input  logic [3:0] ALUFlags,

		output logic PCSrc,
		output logic MemtoReg,
		output logic MemWrite,
		output logic [2:0] ALUControl,
		output logic ALUSrc,
		output logic [1:0] ImmSrc,
		output logic RegWrite
	);

	wire [1:0] FlagW;
	wire PCS;
	wire RegW;
	wire MemW;

	/* Decoder */
	control_unit_decoder decoder (.Opcode(Opcode),
                            	  .V(V),
                            	  .Funct(Funct),
								  .Rd(Rd),
								  .PCS(PCS),
								  .RegW(RegW),
								  .MemW(MemW),
								  .MemtoReg(MemtoReg),
								  .ALUSrc(ALUSrc),
								  .ImmSrc(ImmSrc),
								  .ALUControl(ALUControl));

	/* Conditional Logic */
    condition_logic cond_logic (.clk(clk),
                         .rst(rst),
                         .Opcode(Opcode),
                        .ALUFlags(ALUFlags),
                        .FlagW(FlagW),
                        .PCS(PCS),
                        .RegW(RegW),
                        .MemW(MemW),
                        .PCSrc(PCSrc),
                        .RegWrite(RegWrite),
                        .MemWrite(MemWrite));

endmodule
