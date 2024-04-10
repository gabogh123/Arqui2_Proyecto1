/*
Adder parametrizable para N bits
Date: 15/03/24
*/
module adder # (parameter N = 24) (
		input  logic [N-1:0]   A,
		input  logic [N-1:0]   B,
		input  logic  	     C_in,

		output logic [N-1:0] R,
		output N_flag,
		output Z_flag,
		output C_flag,
		output V_flag
	);

	logic [N:0] C_ins, B_logic;
	assign C_ins[0] = C_in;
	assign B_logic = (C_in) ? ~B : B;
	
	genvar i;
	
	generate
		for (i = 0; i < N; i += 1) begin : GenAdders
			full_adder fu (.A(A[i]),
						   .B(B_logic[i]),
						   .C_in(C_ins[i]),
						   .C_out(C_ins[i + 1]),
						   .R(R[i]));
		end
	endgenerate

	assign Z_flag = (R == 24'h00000) ? 1 : 0;
	assign N_flag = R[N-1];
	assign C_flag = C_ins[N];
	assign V_flag = (~C_in && (A[N-1] == B[N-1]) && (R[N-1] != A[N-1])) || (C_in && (A[N-1] != B[N-1]) && (R[N-1] != A[N-1])); 

endmodule
