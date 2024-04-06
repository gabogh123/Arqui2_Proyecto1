/*
Pipeline's Fetch Stage
Date: 06/04/24
*/
module Fetch # (parameter N = 24) (
		input  logic clk,
		input  logic rst,
		input  logic [N-1:0] ResultW,
		input  logic [N-1:0] ALUResultE,
		input  logic PCSrcW,
		input  logic BranchTakenE,
		input  logic StallF,
		input  logic StallD,
		input  logic FlushD,
		output logic [N-1:0] InstrD,
		output logic [N-1:0] InstrD_vector,	
		output logic [N-1:0] PCPlus8D
	);

	logic [N-1:0] PCPlus4,
	logic [N-1:0] PCJump,
	logic [N-1:0] PCNext,
	logic [N-1:0] PCout;
	logic [N-1:0] Inst;
	logic [N-1:0] InstOut;
	logic [N-1:0] InstOutV;
		
	PCreg # (32) PC (clk, rst, StallF, PCNext, PCout);
	
	assign PCPlus4 = PCout + 4;
	
	assign PCPlus8D = PCPlus4;
	
	Mux2 #(32) mux_pc4 (PCPlus4, ResultW, PCSrcW, PCJump);
	
	Mux2 # (32) mux_pcnext (PCJump, ALUResultE, BranchTakenE, PCNext);
	
	MemInst MI (PCout, Inst);
	
	InstSelector is (Inst[26], Inst[25:0], InstOut, InstOutV);
	
	//Registro de Fetch-Deco
	RegFD regfd (clk, StallD, FlushD, InstOut, InstOutV, InstrD, InstrDV);

endmodule
