/*
Conditional Logic module 
Date: 20/3/2024
*/
module conditional_logic(
		input  logic		clk,
		input  logic		rst,

		input  logic [2:0]  Opcode,
		input  logic 		V,
		input  logic [3:0]  ALUFlags,
		//input  logic [1:0]  FlagW,

		input  logic		PCS,
		input  logic		RegW,
		input  logic		MemW,

		output logic		PCSrc,
		output logic		RegWrite,
		output logic		MemWrite
	);

	// wire		[1:0]	FlagWrite;
	wire				CondEx;
	// wire		[3:0]   Flags;

	logic next_PCSrc;
	logic next_RegWrite;
	logic next_MemWrite;

	assign /*next_*/PCSrc = PCS | CondEx;
	assign /*next_*/RegWrite = RegW & !CondEx;
	assign /*next_*/MemWrite = MemW & !CondEx;

	//Condition checker module instance
	condition_checker cond_checker (.Opcode(Opcode),
									.V(V),
									.N_flag(ALUFlags[3]),
									.Z_flag(ALUFlags[2]),
									.C_flag(ALUFlags[1]),
									.V_flag(ALUFlags[0]),
									.condEx(CondEx));

	/*
	register_v2 #(.N(1)) reg_PCSrc (.clk(clk),
										 .rst(rst),
										 .en(1'b1),
										 .D(next_PCSrc),
										 .Q(PCSrc));
	
	register_v2 #(.N(1)) reg_RegWrite (.clk(clk),
										 .rst(rst),
										 .en(1'b1),
										 .D(next_RegWrite),
										 .Q(RegWrite));
	
	register_v2 #(.N(1)) reg_MemWrite (.clk(clk),
										 .rst(rst),
										 .en(1'b1),
										 .D(next_MemWrite),
										 .Q(MemWrite));
	*/

endmodule
