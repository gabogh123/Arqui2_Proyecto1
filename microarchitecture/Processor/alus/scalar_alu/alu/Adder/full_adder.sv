/*
Full Adder
Date: 15/03/24
*/
module full_adder (
		input  logic A,
		input  logic B,
		input  logic C_in,
		output logic R,
		output logic C_out
	);

	assign R = (A ^ B) ^ C_in;
	assign C_out = (A & B) || (C_in & (A ^ B));

endmodule
