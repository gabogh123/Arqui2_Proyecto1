/*
Register for Execute and Memory pipeline datapath.
Date: 08/04/24
*/
module register_EM # (parameter N = 24) (
		input  logic clk,
		input  logic PCSrcE_cond,
		input  logic RegWriteE_cond,
		input  logic MemtoRegE,
		input  logic MemWriteE_cond,
		input  logic [N-1:0] ALUResultE,
		input  logic [N-1:0] WriteDataE,
		input  logic [3:0] WA3E,

		input  logic [255:0] vALUResultE,
		input  logic [255:0] vWriteDataE,

		output logic PCSrcM,
		output logic RegWriteM,
		output logic MemtoRegM,
		output logic MemWriteM,
		output logic [N-1:0] ALUResultM,
		output logic [N-1:0] WriteDataM,
		output logic [3:0] WA3M,

		output logic [N-1:0] vALUResultM,
		output logic [N-1:0] vWriteDataM
	);
					

	always_ff @ (posedge clk) begin

			PCSrcM <= PCSrcE_cond;
			RegWriteM <= RegWriteE_cond;
			MemWriteM <= MemWriteE_cond;
			MemtoRegM <= MemtoRegE;
			ALUResultM <= ALUResultE;
			WriteDataM <= WriteDataE;
			WA3M <= WA3E;

			vALUResultM <= vALUResultE;
			vWriteDataM <= vWriteDataE;

	end

endmodule
