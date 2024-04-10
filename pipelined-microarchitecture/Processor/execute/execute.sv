/*
Pipeline's Execute Stage
Date: 08/04/24
*/
module execute # (parameter N = 24) (
		input  logic clk,
		input  logic rst,
		input  logic [N-1:0] RD1E,
		input  logic [N-1:0] RD2E,
		input  logic [N-1:0] ExtImmE,
		input  logic [N-1:0] ResultW,
		input  logic [N-1:0] ALUResultMFB,

		input  logic PCSrcE,
		input  logic RegWriteE,
		input  logic MemtoRegE,
		input  logic MemWriteE,
		input  logic [2:0] ALUControlE,
		input  logic ALUSelE,
		input  logic BranchE,
		input  logic ALUSrcE,
		input  logic [1:0] FlagWriteE,
		input  logic [2:0] OpcodeE,
		input  logic [1:0] SE,
		input  logic [3:0] FlagsE,

		input  logic [3:0] WA3E,
		input  logic [1:0] ForwardAE,
		input  logic [1:0] ForwardBE,

		output logic PCSrcM,
		output logic RegWriteM,
		output logic MemWriteM,
		output logic MemtoRegM,
		output logic BranchTakenE,
		output logic [N-1:0] ALUResultM,
		output logic [N-1:0] WriteDataM,
		output logic [N-1:0] ExtImmF, 
		output logic [3:0] WA3M,
		output logic [3:0] ALUFlagsD
	);

	/* wiring */
	logic [N-1:0] WriteDataE;
	logic [N-1:0] SrcAE;
	logic [N-1:0] SrcBE;
	logic [N-1:0] ALUResultE;
	logic [3:0] ALUFlags;
	

	/* SrcAE (ALU's A Operand) Mux */ /* A = mux_ra1E */
	mux_4NtoN # (.N(N)) mux_SrcAE (.I0(RD1E),
								   .I1(ResultW),
								   .I2(ALUResultMFB),
								   .I3(24'hFFFFFF), // All 1's because it's not used
								   .rst(rst),
								   .S(ForwardAE),
								   .en(1'b1),
								   .O(SrcAE));

	/* WriteDataE (ALU's posible operand and Data Memory's write data) Mux */ /* A = mux_ra2E */
	mux_4NtoN # (.N(N)) mux_WriteDataE (.I0(RD2E),
										.I1(ResultW),
										.I2(ALUResultMFB),
										.I3(24'hFFFFFF),
										.rst(rst),
										.S(ForwardBE),
										.en(1'b1),
										.O(WriteDataE));

	/* SrcBE (ALU's B Operand) Mux */ /* A = mux_op2 */
	mux_2NtoN # (.N(N)) mux_SrcBE (.I0(WriteDataE),
								   .I1(ExtImmE),
								   .rst(rst),
								   .S(ALUSrcE),
								   .en(1'b1),
								   .O(SrcBE));

	/* ALU Scalar */
	alu # (.N(N)) alu_scalar (.A(SrcAE),
                              .B(SrcBE),
                              .ALUControl(ALUControlE),
                              .result(ALUResultE),
                              .flags(ALUFlags));

	/* ALU Scalar w FP */
	// alu_fp

	/* ALUFlags Mux */
	// mux_2NtoN
	// usar ALUSel

	/* ALUResult Mux */
	// mux_2NtoN
	// usar ALUSel
	
	/* Conditioned control signals */
	logic PCSrcE_cond;
	logic RegWriteE_cond;
	logic MemWriteE_cond;
	
	/* Conditional Unit checks flags and branches */
	conditional_unit cond_unit (.clk(clk),
							  	.rst(rst),
								.PCSrcE(PCSrcE),
								.RegWriteE(RegWriteE),
								.MemWriteE(MemWriteE),
								.BranchE(BranchE),

								.FlagWriteE(FlagWriteE),
								.Opcode(OpcodeE),
								.S(SE),
								.FlagsE(FlagsE),
								.ALUFlags(ALUFlags),

								.ALUFlagsD(ALUFlagsD),
								.BranchTakenE(BranchTakenE),
								.PCSrcM(PCSrcE_cond),
								.RegWriteM(RegWriteE_cond),
								.MemWriteM(MemWriteE_cond));
	
	/* Pipeline Register Decode-Memory Stages */ /* A = regem */
	register_EM # (.N(N)) reg_EM (.clk(clk),
								.PCSrcE_cond(PCSrcE_cond),
								.RegWriteE_cond(RegWriteE_cond),
								.MemtoRegE(MemtoRegE),
								.MemWriteE_cond(MemWriteE_cond),
								.ALUResultE(ALUResultE),
								.WriteDataE(WriteDataE),
								.WA3E(WA3E),
								.PCSrcM(PCSrcM),
								.RegWriteM(RegWriteM),
								.MemtoRegM(MemtoRegM),
								.MemWriteM(MemWriteM),
								.ALUResultM(ALUResultM),
								.WriteDataM(WriteDataM),
								.WA3M(WA3M));
	
	/* ExtImm for Fetch stage (ALUResult was used in book's implementation) */
	/* Used for sending the branch address in 'b' instruction */
	assign ExtImmF = ExtImmE;

endmodule
