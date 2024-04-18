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

		input  logic [255:0] vRD1E,
		input  logic [255:0] vRD2E,
		input  logic [255:0] vResultW,
		input  logic [255:0] vALUResultMFB,

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

		input  logic vRegWriteE,
		input  logic vMemWriteE,

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
		output logic [3:0] ALUFlagsD,

		output logic vRegWriteM,
		output logic vMemWriteM,
		output logic [255:0] vALUResultM,
		output logic [255:0] vWriteDataM
	);

	/* wiring */
	logic [N-1:0] WriteDataE;
	logic [N-1:0] SrcAE;
	logic [N-1:0] SrcBE;
	logic [N-1:0] ALUResult_nfp;
	logic [N-1:0] ALUResult_wfp;
	logic [N-1:0] ALUResultE;
	logic [3:0] ALUFlags_nfp;
	logic [3:0] ALUFlags_wfp;
	logic [3:0] ALUFlags;
	/* vector wiring */
	logic [255:0] vWriteDataE;
	logic [255:0] vSrcAE;
	logic [255:0] vSrcBE;
	logic [255:0] vALUResultE;
	logic [63:0] vALUFlags;
	

	/* SrcAE (ALU's A Operand) Mux */ /* A = mux_ra1E */
	mux_4NtoN # (.N(N)) mux_SrcAE (.I0(RD1E),
								   .I1(ResultW),
								   .I2(ALUResultMFB),
								   .I3(24'hffffff), // All 1's because it's not used
								   .rst(rst),
								   .S(ForwardAE),
								   .en(1'b1),
								   .O(SrcAE));

	/* WriteDataE (ALU's posible operand and Data Memory's write data) Mux */ /* A = mux_ra2E */
	mux_4NtoN # (.N(N)) mux_WriteDataE (.I0(RD2E),
										.I1(ResultW),
										.I2(ALUResultMFB),
										.I3(24'hffffff),
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

	/* Scalar ALU */
	alus # (.N(N)) sALU (.rst(rst),
						 .A(SrcAE),
						 .B(SrcBE),
						 .ALUControl(ALUControlE),
						 .ALUSel(ALUSelE),
						 .result(ALUResultE),
						 .flags(ALUFlags));

	/* ********************************** vector ***************************** */

	/* vSrcAE (vALU's A Operand) Mux */
	mux_4NtoN # (.N(256)) mux_vSrcAE (.I0(vRD1E),
								      .I1(vResultW),
								   	  .I2(vALUResultMFB),
								   	  .I3(256'hffffff), // All 1's because it's not used
								   	  .rst(rst),
								   	  .S(ForwardAE),
								   	  .en(1'b1),
								   	  .O(vSrcAE));

	/* vWriteDataE (vALU's posible operand and Vector Data Memory's write data) Mux */
	mux_4NtoN # (.N(N)) mux_vWriteDataE (.I0(vRD2E),
										.I1(vResultW),
										.I2(vALUResultMFB),
										.I3(256'hffffffffffffffffffffffffffffffffffff),
										.rst(rst),
										.S(ForwardBE),
										.en(1'b1),
										.O(vWriteDataE));

	/* vSrcBE (vALU's B Operand) Mux */
	mux_2NtoN # (.N(N)) mux_vSrcBE (.I0(vWriteDataE),
								   .I1(256'hffffffffffffffffffffffffffffffffffff), // posible -> vExtImmE (not implemented extend for vector)
								   .rst(rst),
								   .S(ALUSrcE),
								   .en(1'b1),
								   .O(vSrcBE));

	/* Vector ALU */
	vector_alu # (.N(16)) vALU (.A(vSrcAE),
								.B(vSrcBE),
								.ALUControl(ALUControlE),
								.ALUSel(ALUSelE),
								.result(vALUResultE),
								.flags(vALUFlags)); // ALUFlags for vector wont be needed
	

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

								.vALUResultE(vALUResultE),
								.vWriteDataE(vWriteDataE),

								.PCSrcM(PCSrcM),
								.RegWriteM(RegWriteM),
								.MemtoRegM(MemtoRegM),
								.MemWriteM(MemWriteM),
								.ALUResultM(ALUResultM),
								.WriteDataM(WriteDataM),
								.WA3M(WA3M),

								.vALUResultM(vALUResultM),
								.vWriteDataM(vWriteDataM));
	
	/* ExtImm for Fetch stage (ALUResult was used in book's implementation) */
	/* Used for sending the branch address in 'b' instruction */
	assign ExtImmF = ExtImmE;

endmodule
