/*
MUX 4:1 parametrizable para N bits
Date: 16/03/24
*/
module mux_4NtoN # (parameter N = 24) (
		input  logic [N-1:0] I0,
		input  logic [N-1:0] I1,
		input  logic [N-1:0] I2,
		input  logic [N-1:0] I3,
		
		input  logic   [1:0]  S,
		input  logic 		rst,
		input  logic	 enable,

		output logic [N-1:0]  O
	);
	
	wire [N-1:0] O_0;
	wire [N-1:0] O_1;

	mux_2NtoN # (.N(N)) m2NtoN_O0 (.I0(I0),
								   .I1(I1),
								   .rst(rst),
								   .S(S[0]),
								   .enable(enable),
								   .O(O_0));

	mux_2NtoN # (.N(N)) m2NtoN_O1 (.I0(I2),
								   .I1(I3),
								   .rst(rst),
								   .S(S[0]),
							       .enable(enable),
								   .O(O_1));


	mux_2NtoN # (.N(N)) m2NtoN_O (.I0(O_0),
								  .I1(O_1),
								  .rst(rst),
								  .S(S[1]),
								  .enable(enable),
								  .O(O));
	
endmodule
