/*
Modulo para instancias alu escalar normal y de punto fijo
Date: 07/04/24
HACER TESTBENCH 
*/
`timescale 1 ps / 100 fs
module alus # (parameter N = 24) (
		input logic 			   rst,
		input logic [N-1:0]          A,
		input logic [N-1:0]          B,
		input logic [2:0]   ALUControl,
		input logic    			ALUSel,

		output logic [N-1:0]    result,
		output logic [3:0]       flags
	);

	logic [N-1:0] result_nfp;
	logic [N-1:0] result_wfp;

	logic [3:0] flags_nfp;
	logic [3:0] flags_wfp;

	/* Scalar ALU with no fixed point */
	alu #(N) scalar_alu_nfp (.A(A),
							 .B(B),
							 .ALUControl(ALUControl),
							 .result(result_nfp),
							 .flags(flags_nfp));

	/* Scalar ALU with fixed point */
	alu_fp #(N) scalar_alu_wfp(.A_fp(A),
							   .B_fp(B),
							   .ALUControl(ALUControl),
							   .result(result_wfp),
							   .flags(flags_wfp));

	/* ALUResult Mux */
	mux_2NtoN # (.N(N)) mux_ALUResult (.I0(result_nfp),
									   .I1(result_wfp),
									   .rst(rst),
									   .S(ALUSel),
									   .en(1'b1),
									   .O(result));

	/* ALUFlags Mux */
	mux_2NtoN # (.N(4)) mux_ALUFlags (.I0(flags_nfp),
									  .I1(flags_wfp),
									  .rst(rst),
									  .S(ALUSel),
									  .en(1'b1),
									  .O(flags));

endmodule
