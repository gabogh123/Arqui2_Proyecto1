/*
ALU parametrizable para N
Date: 16/03/24
*/
`timescale 1 ps / 100 fs
module alu # (parameter N = 24) (
		input  [N-1:0] 			A, // Input A (24-bit)
		input  [N-1:0] 			B, // Input B (24-bit)
		input  [2:0]   ALUControl, // ALU Control (3-bit)

		output [N-1:0]	   result, // ALU Result (24-bit)
		output [3:0]		flags
	);

	logic [N-1:0] add, sub, mult, sll, srl;
	logic C_add, C_sub, C_mult;
	logic Z_add, Z_sub, Z_mult;
	logic V_add, V_sub, V_mult;
	logic N_add, N_sub, N_mult;
	logic gt_sub;
	logic [4:0] shamt;

	logic			   c_flag; // Carry Out
	logic 			   z_flag; // Zero Flag
	logic 			   v_flag; // Overflow Flag
	logic 			   n_flag; // Negative Flag
	logic 			  gt_flag; // Greater than Flag
	 
	/* Shift amount */
	assign shamt = B[7:3];

	//add
	adder #(N) adder(.A(A),
					 .B(B),
					 .C_in(1'b0),
					 .R(add),
					 .N_flag(N_add),
					 .Z_flag(Z_add),
					 .C_flag(C_add),
					 .V_flag(V_add));
	
	//sub
	adder #(N) subtractor(.A(A),
						  .B(B),
						  .C_in(1'b1),
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

	//mux7to1 #(N) mux_result(add, xori, sub, sll, srl, mult, ALUControl, result);
	mux_8NtoN # (.N(N)) m8NtoN_R (.I0(add),
								  .I1(sub),
								  .I2(mult),
								  .I3(sll), //011
								  .I4(24'hffffff),
								  .I5(24'hffffff),
								  .I6(24'hffffff),
								  .I7(srl), //111
								  .en(1'b1),
								  .rst(0),
								  .S(ALUControl),
								  .O(result));

	//mux7to1 #(1) mux_C(C_add, 0, C_sub, 0, 0, 0, C_mult, ALUControl, c_flag);
	mux_8NtoN # (.N(1)) m8NtoN_C (.I0(C_add),
								  .I1(C_sub),
								  .I2(C_mult),
								  .I3(1'b0),
								  .I4(1'b0),
								  .I5(1'b0),
								  .I6(1'b0),
								  .I7(1'b0),
								  .en(1'b1),
								  .rst(1'b0),
								  .S(ALUControl),
								  .O(c_flag));

	//mux7to1 #(1) mux_Z(Z_add, 0, Z_sub, 0, 0, 0, Z_mult, ALUControl, z_flag);
	mux_8NtoN # (.N(1)) m8NtoN_Z (.I0(Z_add),
								  .I1(Z_sub),
								  .I2(Z_mult),
								  .I3(1'b0),
								  .I4(1'b0),
								  .I5(1'b0),
								  .I6(1'b0),
								  .I7(1'b0),
								  .en(1'b1),
								  .rst(1'b0),
								  .S(ALUControl),
								  .O(z_flag));

	//mux7to1 #(1) mux_V(V_add, 0, V_sub, 0, 0, 0, V_mult, ALUControl, v_flag);
	mux_8NtoN # (.N(1)) m8NtoN_V (.I0(V_add),
								  .I1(V_sub),
								  .I2(V_mult),
								  .I3(1'b0),
								  .I4(1'b0),
								  .I5(1'b0),
								  .I6(1'b0),
								  .I7(1'b0),
								  .en(1'b1),
								  .rst(1'b0),
								  .S(ALUControl),
								  .O(v_flag));

	//mux7to1 #(1) mux_N(N_add, 0, N_sub, 0, 0, 0, N_mult, ALUControl, n_flag);
	mux_8NtoN # (.N(1)) m8NtoN_N (.I0(N_add),
								  .I1(N_sub),
								  .I2(N_mult),
								  .I3(1'b0),
								  .I4(1'b0),
								  .I5(1'b0),
								  .I6(1'b0),
								  .I7(1'b0),
								  .en(1'b1),
								  .rst(1'b0),
								  .S(ALUControl),
								  .O(n_flag));

	//mux7to1 #(1) mux_gt(0, 0, gt_sub, 0, 0, 0, 0, ALUControl, gt_flag);
	mux_8NtoN # (.N(1)) m8NtoN_GT (.I0(1'b0),
								   .I1(gt_sub),
								   .I2(1'b0),
								   .I3(1'b0),
								   .I4(1'b0),
								   .I5(1'b0),
								   .I6(1'b0),
								   .I7(1'b0),
								   .en(1'b1),
								   .rst(1'b0),
								   .S(ALUControl),
								   .O(gt_flag));

	/* All flags are in a single 4 bit bus */
	assign flags = {n_flag, z_flag, c_flag, v_flag};

endmodule
