/*
N bits register module
Date: 25/03/24
*/
module register_v2 # (parameter N = 24) (
		input  logic  	     clk,
		input  logic  	     rst,
		input  logic		  en,
		input  logic [N-1:0]   D, // input
		output logic [N-1:0]   Q  // output
	);

	always_ff @ (negedge clk or posedge rst) begin
		
		if (rst)
			Q <= 0;

		else if (en)
			Q <= D;
		
	end

endmodule
