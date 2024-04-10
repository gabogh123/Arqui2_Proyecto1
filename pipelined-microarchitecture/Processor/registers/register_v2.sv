/*
N bits register module
@ Posedge: D waits to be written, Q is last cycles input
@ Negedge: D has been overwritten if en = 1, Q is D (overwriteen or not)
Date: 25/03/24
*/
module register_v2 # (parameter N = 24) (
		input  logic  	     clk,
		input  logic  	     rst,
		input  logic		  en, // WriteEn
		input  logic [N-1:0]   D, // RegIn
		output logic [N-1:0]   Q  // RegOut
	);

	always_ff @ (posedge clk or posedge rst) begin
		
		if (rst)
			Q <= 0;

		else if (en)
			Q <= D;
		
	end

endmodule
