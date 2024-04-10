/*
Datapath Selector
Selects the type of instructions datapath.
Decides between the scalar datapath or vector datapath, based on the instruction type.
dnt instruction = 24'b111 1 1111 1111 1111 1111 111 1
Data: 06/10/24
*/
module datapath_selector # (parameter N = 24) (
		input  logic [N-1:0] instruction,

		output logic [N-1:0] scalar_datapath_instruction,
		output logic [N-1:0] vector_datapath_instruction
	);
	

	/* Control bits in instruction */
	logic [2:0] opcode;
	assign opcode = instruction[23:21];


	/* Logic signals for dnt instruction => 24'b111 1 1111 1111 1111 1111 111 1 */
	logic [N-1:0] dnt_instruction;
	logic [2:0] dnt_opcode;
	logic dnt_s1;
	logic [3:0] dnt_rd;
	logic [3:0] dnt_rs;
	logic [3:0] dnt_rt;
	logic [3:0] dnt_shamt;
	logic [2:0] dnt_func;
	logic dnt_s0;

	assign dnt_opcode = 3'b111;
	assign dnt_s1 = 1'b1;
	assign dnt_rd = 4'b1111;
	assign dnt_rs = 4'b1111;
	assign dnt_rt = 4'b1111;
	assign dnt_shamt = 4'b1111;
	assign dnt_func = 3'b111;
	assign dnt_s0 = 1'b1;
	/* Contructs dnt instruction based on predefined binary control signals */
	assign dnt_instruction = {dnt_opcode, dnt_s1, dnt_rd, dnt_rs, dnt_rt, dnt_shamt, dnt_func, dnt_s0};
		
	always_comb
		
		case(opcode)
			
			/* Scalar datapath */ /* Scalar Arithmetic Operations */
			3'b000: begin
				scalar_datapath_instruction = instruction;
				vector_datapath_instruction = dnt_instruction;
			end
			
			/* Vectorial datapath */ /* Vector Arithmetic Operations */
			3'b001: begin
				scalar_datapath_instruction = dnt_instruction;
				vector_datapath_instruction = instruction;
			end

			/* Scalar datapath */ /* Scalar Immediate Arithmetic Operations */
			3'b010: begin
				scalar_datapath_instruction = instruction;
				vector_datapath_instruction = dnt_instruction;
			end

			/* Scalar datapath */ /* Scalar memory access */
			3'b011: begin
				scalar_datapath_instruction = instruction;
				vector_datapath_instruction = dnt_instruction;
			end

			/* Vectorial datapath */ /* Vector Memory access */
			3'b101: begin
				scalar_datapath_instruction = dnt_instruction;
				vector_datapath_instruction = instruction;
			end

			/* Scalar datapath */ /* Branches */
			3'b110: begin
				scalar_datapath_instruction = instruction;
				vector_datapath_instruction = dnt_instruction;
			end

			/* Vector datapath */ /* Vector management  */
			3'b100: begin
				scalar_datapath_instruction = dnt_instruction;
				vector_datapath_instruction = instruction;
			end

			/* Default */
			default: begin
				scalar_datapath_instruction = dnt_instruction;
				vector_datapath_instruction = dnt_instruction;
			end

		endcase

endmodule
