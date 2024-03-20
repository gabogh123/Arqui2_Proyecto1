/*
Zero Extend Module 
Date: 19/3/24
*/

module zero_extension(in,out);

	input [12:0] in;
	output [23:0] out;

	assign out = {{11{1'b0}},in};

endmodule
