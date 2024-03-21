/*
Control Unit module 
Date: 20/3/2024
*/
module control_unit(

		input clk,
		input rst,
		
		input [2:0] Opcode,
		input V,
		input [2:0] Funct,
		input [3:0] Rd,

		input [3:0] ALUFlags,

		output PCSrc,
		output MemtoReg,
		output MemWrite,
		output [2:0] ALUControl,
		output ALUSrc,
		output [1:0] ImmSrc,
		output RegWrite
	);

	wire FlagW;
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
