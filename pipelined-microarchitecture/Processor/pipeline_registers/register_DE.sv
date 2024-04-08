/*
Register for Decode and Execute pipeline datapath.
Date: 07/04/24
*/
module register_DE # (parameter N = 24) (
		input logic clk,
		input logic rst,
		input logic clr,

		input logic PCSrcD,
		input logic RegWriteD,
		input logic MemtoRegD,
		input logic MemWriteD,
		input logic [2:0] ALUControlD, 
		input logic BranchD,
		input logic ALUSrcD,
		input logic [1:0] FlagWriteD, 
		input logic CondD, 
		input logic [3:0] NFlags, // A = FlagsD,
		
		input logic [N-1:0] RD1D, // A = rd1,
		input logic [N-1:0] RD2D, // A = rd2,
		input logic [N-1:0] ExtImmD, // A = ext,
		input logic [3:0] A3D, // A = a3, /* A added */
		input logic [3:0] RA1D, // /* A added */
		input logic [3:0] RA2D, // /* A added */
		
		
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
		
		output logic [N-1:0] RD1E, // A = rdo1,
		output logic [N-1:0] RD2E, // A = rdo2,
		output logic [N-1:0] ExtImmE, // A = exto,
		output logic [3:0] A3E, // A = ao3, /* A added */
		output logic [3:0] RA1E, // /* A added */
		output logic [3:0] RA2E  // /* A added */
	);
					

	always_ff @(posedge clk) begin

		if (clr || rst) begin
			PCSrcE <= 1'b0;
			RegWriteE <= 1'b0;
			MemtoRegE <= 1'b0;
			MemWriteE <= 1'b0;
			ALUControlE <= 3'b0;
			BranchE <= 1'b0;
			ALUSrcE <= 1'b0;
			FlagWriteE <= 2'b0;
			CondE <= 1'b0;
			FlagsE <= 1'b0;
			RD1E <= 24'b0;
			RD2E <= 24'b0;
			ExtImmE <= 24'b0;
			A3E <= 4'b0;
			RA1E <= 4'b0;
			RA2E <= 4'b0;
		end

		else begin
			PCSrcE <= PCSrcD;
			RegWriteE <= RegWriteD;
			MemtoRegE <= MemtoRegD;
			MemWriteE <= MemWriteD;
			ALUControlE <= ALUControlD;
			BranchE <= BranchD;
			ALUSrcE <= ALUSrcD;
			FlagWriteE <= FlagWriteD;
			CondE <= CondD;
			FlagsE <= NFlags;
			RD1E <= RD1D;
			RD2E <= RD2D;
			ExtImmE <= ExtImmD;
			A3E <= A3D;
			RA1E <= RA1D;
			RA2E <= RA2D;
		end

	end

endmodule
