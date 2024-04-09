/*
Processor Module
Date: 07/04/24
*/
module pipelined_processor # (parameter N = 24) (
        input  logic			clk,
		input  logic			rst,
		input  logic			en,

        input  logic [N-1:0] Instr,       		// RD from instruction memory
        input  logic [N-1:0] ReadData_scalar, 	// RD from data memory

        output logic [N-1:0] PC,       	 		// to A from instruction memory
        output logic MemWrite_scalar,           // ScalarMemWrite from Data memory
        output logic [N-1:0] ALUResult_scalar,	// to A from, data memory
        output logic [N-1:0] WriteData_scalar  	// to WD (write_scalar_data) from data memory
    );
/*
	fetch # (.N(N)) sFetch (
		input  logic clk,
		input  logic rst,
		input  logic [N-1:0] ResultW,
		input  logic [N-1:0] ALUResultE,
		input  logic PCSrcW,
		input  logic BranchTakenE,
		input  logic StallF,
		input  logic StallD,
		input  logic FlushD,
		input  logic [N-1:0] instruction, /* Input from Memory /

		output logic [N-1:0] PCF, /* Output to Memory / //A = PCout / L = PCF / RG = pc_address
		output logic [N-1:0] InstrD,
		output logic [N-1:0] InstrD_vector,
		output logic [N-1:0] PCPlus8D
	);


	decode # (parameter N = 24) (
		input logic clk,
		input logic rst,
		input logic RegWriteW,
		input logic FlushE,
		input logic [3:0] NFlags,
		input logic [N-1:0] InstrD, // instruction for decoding
		input logic [N-1:0] PCPlus8D,
		input logic [N-1:0] ResultW,
		input logic [3:0] WA3W,

		output logic PCSrcD,
		output logic PCSrcE,
		output logic RegWriteE,
		output logic MemtoRegE,
		output logic MemWriteE,
		output logic [2:0] ALUControlE,
		output logic BranchE,
		output logic ALUSrcE,
		output logic [1:0] FlagWriteE,
		output logic CondE,
		output logic [3:0] FlagsE,
		output logic [N-1:0] RD1E,
		output logic [N-1:0] RD2E,
		output logic [3:0] WA3E,
		output logic [N-1:0] ExtImmE,
		output logic [3:0] A3E,
		output logic [3:0] RA1E,
		output logic [3:0] RA2E,
		output logic Stuck
	);


	execute # (parameter N = 24) (
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
		input  logic BranchE,
		input  logic ALUSrcE,
		input  logic [1:0] FlagWriteE,
		input  logic CondE,
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
		output logic [N-1:0] ALUResultF, 
		output logic [3:0] WA3M,
		output logic [3:0] ALUFlagsD
	);


*/







endmodule
