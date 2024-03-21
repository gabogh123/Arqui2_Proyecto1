/*
Conditional Logic module 
Date: 20/3/2024
*/
module condition_logic(
		
		input  logic		clk,
		input  logic		rst,

		input  logic [2:0]  Opcode,
		input  logic [3:0]  ALUFlags,
		input  logic [1:0]  FlagW,

		input  logic		PCS,
		input  logic		RegW,
		input  logic		MemW,

		output logic		PCSrc,
		output logic		RegWrite,
		output logic		MemWrite
	);

	wire		[1:0]	FlagWrite;
	wire				CondEx;
	wire		[3:0]   Flags;

	assign PCSrc = PCS & CondEx;

	assign RegWrite = RegW & CondEx;

	assign MemWrite = MemW & CondEx;

	//Condition checked module instance

	condition_checker cond_checker (.Opcode(Opcode),
									.N(Flags[3]),
									.Z(Flags[2]),
									.C(Flags[1]),
									.V(Flags[0]),
									.condEx(CondEx));

	assign FlagWrite[1] = FlagW[1] & CondEx;

	assign FlagWrite[0] = FlagW[0] & CondEx;

	register #(.N(2)) flagsRegister1 (.clk(clk),
									  .rst(rst),
									  .WriteEn(FlagWrite[1]),
									  .RegIn(ALUFlags[1:0]),
									  .RegOut(Flags[1:0]));

	register #(.N(2)) flagsRegister2 (.clk(clk),
									  .rst(rst),
									  .WriteEn(FlagWrite[0]),
									  .RegIn(ALUFlags[1:0]),
									  .RegOut(Flags[3:2]));


endmodule
