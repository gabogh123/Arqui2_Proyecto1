/*
Register parametrizable para N bits
Date: 16/03/24
*/
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
			q_reg = 24'h00000; // On reset, set to 0
		else if (WriteEn)
			q_reg = RegIn; // Otherwise RegOut = RegIn

	assign RegOut = q_reg;

endmodule
