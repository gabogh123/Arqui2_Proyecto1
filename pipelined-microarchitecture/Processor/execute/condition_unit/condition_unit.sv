module condition_unit(input logic clk, reset,
							 input logic CondE,
							 input logic [3:0] ALUFlags,
							 input logic [3:0] FlagsE,
							 output logic [3:0] ALUFlags_Out,
							 input logic [1:0] FlagWriteE,
							 input logic PCSrcE, RegWriteE, MemWriteE,BranchE,
							 output logic PCSrcM, RegWriteM,MemWriteM, BranchTakenE);
							 

logic [1:0] FlagWrite;
logic [3:0] Flags;
logic CondEx;

flopenr #(2)flagreg1(clk, reset, FlagWrite[1],
							ALUFlags[3:2], Flags[3:2]);
flopenr #(2)flagreg0(clk, reset, FlagWrite[0],
							ALUFlags[1:0], Flags[1:0]);
							
							
// write controls are conditional
condition_checker cc(CondE, Flags, CondEx);

assign FlagWrite = FlagWriteE & {2{CondEx}};
assign RegWriteM = RegWriteE & CondEx;
assign MemWriteM = MemWriteE & CondEx;
assign PCSrcM = PCSrcE & CondEx;
assign BranchTakenE = CondEx & BranchE;
 
assign ALUFlags_Out = ALUFlags;

endmodule