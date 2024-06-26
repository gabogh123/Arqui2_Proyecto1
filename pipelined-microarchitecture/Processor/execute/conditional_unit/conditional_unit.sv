/*
Conditional Unit module 
Date: 08/04/2024
*/
module conditional_unit (
		input logic clk,
		input logic rst,
		input logic PCSrcE,
		input logic RegWriteE,
		input logic MemWriteE,
		input logic BranchE,

		input logic [1:0] FlagWriteE,
		input logic [2:0] Opcode,
		input logic [1:0] S,
		input logic [3:0] FlagsE,
		input logic [3:0] ALUFlags,
	
		output logic [3:0] ALUFlagsD, /* A = ALUFlagsOut */
		output logic BranchTakenE,
		output logic PCSrcM,
		output logic RegWriteM,
		output logic MemWriteM
	);

	logic [1:0] FlagWrite;
	logic [3:0] Flags;
	logic CondExE;

	/* Checks conditions based on flags */ /* A = cc */
	condition_checker cond_checker (.Opcode(Opcode),
									.S(S),
									.Flags(FlagsE),
									.CondEx(CondExE));

	/* Control signals based con condition */
	assign BranchTakenE = BranchE & CondExE;
	assign PCSrcM = PCSrcE & CondExE;
	assign RegWriteM = RegWriteE & CondExE;
	assign MemWriteM = MemWriteE & CondExE;

	/* FlagWrite condition */
	assign FlagWrite[0] = FlagWriteE[0] & CondExE;
	assign FlagWrite[1] = FlagWriteE[1] & CondExE;

	/* Register for N and Z flags */ /* A = flagreg1 */
	register_v2 #(.N(2)) nz_flags_reg (.clk(clk),
									   .rst(rst),
									   .en(FlagWrite[1]),
									   .D(ALUFlags[3:2]),
									   .Q(Flags[3:2]));

	/* Register for C and V flags */ /* A = flagreg0 */
	register_v2 #(.N(2)) cv_flags_reg (.clk(clk),
									   .rst(rst),
									   .en(FlagWrite[0]),
									   .D(ALUFlags[1:0]),
									   .Q(Flags[1:0]));
								
	/* ALUFlags for Decode stage */
	assign ALUFlagsD = ALUFlags;

endmodule
