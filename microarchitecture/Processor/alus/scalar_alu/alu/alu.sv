/*
ALU parametrizable para N
Date: 16/03/24
HACER TESTBENCH
*/
`timescale 1 ps / 100 fs
module alu #(parameter N = 24) (
		input  [N-1:0] 			A, // Input A (24-bit)
		input  [N-1:0] 			B, // Input B (24-bit)
		input  [2:0]   ALUControl, // ALU Control (3-bit)

		output [N-1:0]	   result, // ALU Result (24-bit)
		output [3:0]		flags
	);

	logic [N-1:0] add, sub, slt, xori, sll, srl, mult;
	logic C_add, C_sub, C_mult, Z_add, Z_sub, Z_mult, V_add, V_sub, V_mult, N_add, N_sub, N_mult, gt_sub;
	logic [4:0] shamt;

	logic			   c_flag; // Carry Out
	logic 			   z_flag; // Zero Flag
	logic 			  gt_flag; // Greater than Flag
	logic 			   v_flag; // Overflow Flag
	logic 			   n_flag; // Negative Flag
	 
	/*
	REVISAR EN TESTBENCH QUE FUNCIONE LOL
	*/
	assign shamt = B[7:3];

	//add
	adder #(N) adder(.A(A),
					 .B(B),
					 .C_in(0),
					 .R(add),
					 .N_flag(N_add),
					 .Z_flag(Z_add),
					 .C_flag(C_add),
					 .V_flag(V_add));
	
	//sub
	adder #(N) subtractor(.A(A),
						  .B(B),
						  .C_in(1),
						  .R(sub),
						  .N_flag(N_sub),
						  .Z_flag(Z_sub),
						  .C_flag(C_sub),
						  .V_flag(V_sub));
	assign gt_sub = ~N_sub & ~V_sub & ~Z_sub;

	
	//shift left logical
	assign sll = A << shamt;

	//shift right logical 
	assign srl = A >> shamt;

	//multiplication
	multiplier #(.N(N)) multi(A,
							B,
							mult,
							Z_mult,
							C_mult,
							V_mult,
							N_mult);

	//mux7to1 #(N) mux_result(add, xori, sub, slt, sll, srl, mult, ALUControl, result);
	mux_8NtoN # (.N(N)) m8NtoN_R (.I0(add),
								  .I1(xori),
								  .I2(sub),
								  .I3(slt),
								  .I4(sll),
								  .I5(srl),
								  .I6(mult),
								  .I7(24'b0),
								  .enable(1),
								  .rst(0),
								  .S(ALUControl),
								  .O(result));

	//mux7to1 #(1) mux_C(C_add, 0, C_sub, 0, 0, 0, C_mult, ALUControl, c_flag);
	mux_8NtoN # (.N(N)) m8NtoN_C (.I0(C_add),
								  .I1(0),
								  .I2(C_sub),
								  .I3(0),
								  .I4(0),
								  .I5(0),
								  .I6(C_mult),
								  .I7(24'b0),
								  .enable(1),
								  .rst(0),
								  .S(ALUControl),
								  .O(c_flag));

	//mux7to1 #(1) mux_Z(Z_add, 0, Z_sub, 0, 0, 0, Z_mult, ALUControl, z_flag);
	mux_8NtoN # (.N(N)) m8NtoN_Z (.I0(Z_add),
								  .I1(0),
								  .I2(Z_sub),
								  .I3(0),
								  .I4(0),
								  .I5(0),
								  .I6(Z_mult),
								  .I7(24'b0),
								  .enable(1),
								  .rst(0),
								  .S(ALUControl),
								  .O(z_flag));

	//mux7to1 #(1) mux_V(V_add, 0, V_sub, 0, 0, 0, V_mult, ALUControl, v_flag);
	mux_8NtoN # (.N(N)) m8NtoN_V (.I0(V_add),
								  .I1(0),
								  .I2(V_sub),
								  .I3(0),
								  .I4(0),
								  .I5(0),
								  .I6(V_mult),
								  .I7(24'b0),
								  .enable(1),
								  .rst(0),
								  .S(ALUControl),
								  .O(v_flag));

	//mux7to1 #(1) mux_N(N_add, 0, N_sub, 0, 0, 0, N_mult, ALUControl, n_flag);
	mux_8NtoN # (.N(N)) m8NtoN_N (.I0(N_add),
								  .I1(0),
								  .I2(N_sub),
								  .I3(0),
								  .I4(0),
								  .I5(0),
								  .I6(N_mult),
								  .I7(24'b0),
								  .enable(1),
								  .rst(0),
								  .S(ALUControl),
								  .O(n_flag));

	//mux7to1 #(1) mux_gt(0, 0, gt_sub, 0, 0, 0, 0, ALUControl, gt_flag);
	mux_8NtoN # (.N(N)) m8NtoN_GT (.I0(0),
								   .I1(0),
								   .I2(gt_sub),
								   .I3(0),
								   .I4(0),
								   .I5(0),
								   .I6(0),
								   .I7(24'b0),
								   .enable(1),
								   .rst(0),
								   .S(ALUControl),
								   .O(gt_flag));

	/* All flags are in a single 4 bit bus */
	assign flags = {n_flag, z_flag, c_flag, v_flag};

endmodule
