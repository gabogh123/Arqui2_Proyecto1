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

	always_ff @ (negedge clk or posedge rst) begin
		
		if (rst)
			Q <= 0;

		else if (en)
			Q <= D;
		
	end

endmodule


/*
Register parametrizable para N bits
Date: 16/03/24
*/
/*
module register	# (parameter N = 24) (
		input  logic 		 	 clk,
		input  logic 			 rst,
		input  logic [N-1:0]   RegIn,
		input  logic 		 WriteEn,
		
		output logic [N-1:0]  RegOut	
	);

	reg [N-1:0] q_reg;
	 
	always @(posedge clk or posedge rst)
		if (rst)
			q_reg = 24'h0; // On reset, set to 0
		else if (WriteEn)
			q_reg = RegIn; // Otherwise RegOut = RegIn

	assign RegOut = q_reg;

endmodule
*/
