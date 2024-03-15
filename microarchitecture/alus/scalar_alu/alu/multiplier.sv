/*
Multiplier parametrizable para N bits
MODIFICAR
*/
module multiplier
	 # (parameter N = 32)
	   (clk, rst, en, D, Q);
		

	input  logic  	     clk;
	input  logic  	     rst;
	input  logic		  en;
	input  logic [N-1:0]   D;
	output logic [N-1:0]   Q;
	

	always_ff @ (negedge clk or posedge rst) begin
		
		if (rst)
			Q <= 0;

		else if (en)
			Q <= D;
		
	end
	

endmodule
