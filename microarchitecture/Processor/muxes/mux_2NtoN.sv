/*
MUX 2:1 parametrizable para N bits
Date: 16/03/24
*/
module mux_2NtoN # (parameter N = 24) (
		input  logic [N-1:0] 	 I0,
		input  logic [N-1:0] 	 I1,
		input  logic         	rst,
		input  logic 		  	  S,
		input  logic	     enable,

		output logic [N-1:0]  	  O
	);

	always_comb begin

		O = '0;
		if (enable)
			O = S ? I1 : I0;
		if (rst)
			O = '0;
		
	end

endmodule
