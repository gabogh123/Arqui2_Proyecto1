/*
Multiplier parametrizable para N bits
Date: 15/03/24
*/
module multiplier #(parameter N = 24) (
		input  logic [N-1:0] a,
		input  logic [N-1:0] b,
		output logic [N-1:0] result,
		output logic z_flag,
		output logic n_flag,
		output logic c_flag,
		output logic v_flag
	);

    logic [2*N-1:0] r;
    logic sign_a, sign_b;

    assign r = a * b;
    assign result = r[N-1:0];

    assign z_flag = (result == 0) ? 1'b1 : 1'b0;
    assign c_flag = (r[2*N-2:N] > 0) ? 1'b1 : 1'b0;
    assign n_flag = r[N-1];

    assign sign_a = a[N-1];
    assign sign_b = b[N-1];
    assign v_flag = (sign_a ~^ sign_b) & n_flag;

endmodule
