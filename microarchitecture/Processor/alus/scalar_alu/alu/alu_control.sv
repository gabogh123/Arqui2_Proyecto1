/*
	ALU control unit module
	19/3/24
*/

module alu_control()(
		input [1:0] Alu_op;
		input [2:0] funct;

		reg [2:0] control;
		wire [4:0] alu_in;

		output [1:0] control;
		);

		assign alu_in = {alu_op,funct}

		always @(alu_in)

		casex(alu_in)
			5'b00000: control=3'b000; // add
			5'b00001: control=3'b001; // sub
			5'b00010: control=3'b010; // mul
			5'b00011: control=3'b011; // sll
			5'b00111: control=3'b111; // slr
		endcase

endmodule