/*
Register for Memory and Writeback pipeline datapath.
Date: 08/04/24
*/
module register_MW # (parameter N = 24) (
		input logic clk,
		input logic PCSrcM,
		input logic RegWriteM,
		input logic MemtoRegM,
		input logic [N-1:0] ReadDataM,
		input logic [N-1:0] ALUOutM, // ALUResultM
		input logic [3:0] WA3M,
		
		output logic PCSrcW,
		output logic RegWriteW,
		output logic MemtoRegW,
		output logic [N-1:0] ReadDataW,
		output logic [N-1:0] ALUOutW,
		output logic [3:0] WA3W
	);
					

	always_ff @ (posedge clk) begin

			PCSrcW <= PCSrcM;
			RegWriteW <= RegWriteM;
			MemtoRegW <= MemtoRegM;
			ReadDataW <= ReadDataM;
			ALUOutW <= ALUOutM;
			WA3W <= WA3M;

	end

endmodule 