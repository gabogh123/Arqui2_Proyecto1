/*
Register for Fetch and Decode pipeline datapath.
Date: 06/04/24
*/
module register_FD # (parameter N = 24) (
		input  logic 		 clk,
		input  logic 		 rst,
		input  logic 		 en,
		input  logic 		 clr,
		input  logic [N-1:0] InstrF,
		input  logic [N-1:0] InstrF_vector,
		output logic [N-1:0] InstrD,
		output logic [N-1:0] InstrD_vector
	);
					
	always_ff @ (posedge clk) begin

		if (clr || rst) begin
			InstrD <= 24'b0;
			InstrD_vector <= 24'b0;
		end

		else if (en) begin
			InstrD <= InstrF;
			InstrD_vector <= InstrF_vector;
		end

	end

endmodule
