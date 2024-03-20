/* 
Modulo extensi�n de signo 
Date: 19/3/24
*/

module sign_extension(in,out);

	input [12:0] in;
	output [23:0] out;

	assign out = {{11{in[12]}},in};

endmodule
