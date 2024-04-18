/*
ALU vectorial parametrizable para N
Date: 07/04/24
HACER TESTBENCH
*/
`timescale 1 ps / 100 fs
module vector_alu # (parameter N = 24) (
		input logic rst,
        input logic [255:0]  A,
        input logic [255:0]  B,
        input logic [2:0]    ALUControl,
        input logic          ALUSel,

        output logic [255:0] result,         
        output logic [63:0]   flags
	);

	logic [N-1:0] A00,A01,A02,A03,A04,A05,A06,A07,A08,A09,A10,A11,A12,A13,A14,A15;
	logic [N-1:0] B00,B01,B02,B03,B04,B05,B06,B07,B08,B09,B10,B11,B12,B13,B14,B15;
	logic [N-1:0] result00,result01,result02,result03,result04,result05,result06,result07,
                  result08,result09,result10,result11,result12,result13,result14,result15;
	logic [N-1:0] flags00,flags01,flags02,flags03,flags04,flags05,flags06,flags07,
                  flags08,flags09,flags10,flags11,flags12,flags13,flags14,flags15;

	assign A00 = A[15:0];
	assign A01 = A[31:16];
	assign A02 = A[47:32];
	assign A03 = A[63:48];
	assign A04 = A[79:64];
	assign A05 = A[95:80];
	assign A06 = A[111:96];
	assign A07 = A[127:112];
	assign A08 = A[143:128];
	assign A09 = A[159:144];
	assign A10 = A[175:160];
	assign A11 = A[191:176];
	assign A12 = A[207:192];
	assign A13 = A[223:208];
	assign A14 = A[239:224];
	assign A15 = A[255:240];

	assign B00 = B[15:0];
	assign B01 = B[31:16];
	assign B02 = B[47:32];
	assign B03 = B[63:48];
	assign B04 = B[79:64];
	assign B05 = B[95:80];
	assign B06 = B[111:96];
	assign B07 = B[127:112];
	assign B08 = B[143:128];
	assign B09 = B[159:144];
	assign B10 = B[175:160];
	assign B11 = B[191:176];
	assign B12 = B[207:192];
	assign B13 = B[223:208];
	assign B14 = B[239:224];
	assign B15 = B[255:240];

	alus #(N) vector_alu0 (.rst(rst),
					.A(A00),
					.B(B00),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result00),
					.flags(flags00));

	alus #(N) vector_alu1 (.rst(rst),
					.A(A01),
					.B(B01),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result01),
					.flags(flags01));

	alus #(N) vector_alu2(.rst(rst),
					.A(A02),
					.B(B02),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result02),
					.flags(flags02));

	alus #(N) vector_alu3(.rst(rst),
					.A(A03),
					.B(B03),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result03),
					.flags(flags03));

	alus #(N) vector_alu4(.rst(rst),
					.A(A04),
					.B(B04),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result04),
					.flags(flags04));

	alus #(N) vector_alu5(.rst(rst),
					.A(A05),
					.B(B05),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result05),
					.flags(flags05));

	alus #(N) vector_alu6(.rst(rst),
					.A(A06),
					.B(B06),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result06),
					.flags(flags06));

	alus #(N) vector_alu7(.rst(rst),
					.A(A07),
					.B(B07),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result07),
					.flags(flags07));

	alus #(N) vector_alu8(.rst(rst),
					.A(A08),
					.B(B08),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result08),
					.flags(flags08));

	alus #(N) vector_alu9(.rst(rst),
					.A(A09),
					.B(B09),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result09),
					.flags(flags09));

	alus #(N) vector_alu10(.rst(rst),
					.A(A10),
					.B(B10),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result10),
					.flags(flags10));

	alus #(N) vector_alu11(.rst(rst),
					.A(A11),
					.B(B11),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result11),
					.flags(flags11));

	alus #(N) vector_alu12(.rst(rst),
					.A(A12),
					.B(B12),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result12),
					.flags(flags12));

	alus #(N) vector_alu13(.rst(rst),
					.A(A13),
					.B(B13),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result13),
					.flags(flags13));

	alus #(N) vector_alu14(.rst(rst),
					.A(A14),
					.B(B14),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result14),
					.flags(flags14));

	alus #(N) vector_alu15(.rst(rst),
					.A(A15),
					.B(B15),
					.ALUControl(ALUControl),
					.ALUSel(ALUSel),
					.result(result15),
					.flags(flags15));

	// assign para formar el result de 256 bits
	assign result[15:0] = result00;
	assign result[31:16] = result01;
	assign result[47:32] = result02;
	assign result[63:48] = result03;
	assign result[79:64] = result04;
	assign result[95:80] = result05;
	assign result[111:96] = result06;
	assign result[127:112] = result07;
	assign result[143:128] = result08;
	assign result[159:144] = result09;
	assign result[175:160] = result10;
	assign result[191:176] = result11;
	assign result[207:192] = result12;
	assign result[223:208] = result13;
	assign result[239:224] = result14;
	assign result[255:240] = result15;

	// assign para formar las flags de 64 bits
	assign flags[3:0] = flags00;
	assign flags[7:4] = flags01;
	assign flags[11:8] = flags02;
	assign flags[15:12] = flags03;
	assign flags[19:16] = flags04;
	assign flags[23:20] = flags05;
	assign flags[27:24] = flags06;
	assign flags[31:28] = flags07;
	assign flags[35:32] = flags08;
	assign flags[39:36] = flags09;
	assign flags[43:40] = flags10;
	assign flags[47:44] = flags11;
	assign flags[51:48] = flags12;
	assign flags[55:52] = flags13;
	assign flags[59:56] = flags14;
	assign flags[63:60] = flags15;

endmodule
