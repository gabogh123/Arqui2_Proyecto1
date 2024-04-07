/*
Datapath Selector
Selects the type of instructions datapath.
Decides between the scalar datapath or vector datapath, based on the instruction type.
dnt instruction = 25'b0001 0000 0000 0000 00000 100
Data: 06/10/24
*/
module datapath_selector # (parameter N = 24) (
		input  logic [N-1:0] instruction,

		output logic [N-1:0] scalar_datapath_instruction,
		output logic [N-1:0] vector_datapath_instruction
	);

	/* V bit in instruction */
	logic V;
	logic [2:0] opcode;
	assign V = instruction[20];
	assign opcode = instruction[23:21];


	/* Logic signals for dnt instruction => 000100000000000000000100 */
	logic [N-1:0] dnt_instruction;
	logic [2:0] dnt_opcode;
	logic dnt_V;
	logic [3:0] dnt_rd;
	logic [3:0] dnt_rs;
	logic [3:0] dnt_rt;
	logic [4:0] dnt_shamt;
	logic [2:0] dnt_func;

	assign dnt_opcode = 3'b000;
	assign dnt_V = 1'b1;
	assign dnt_rd = 4'b0000;
	assign dnt_rs = 4'b0000;
	assign dnt_rt = 4'b0000;
	assign dnt_shamt = 5'b0000;
	assign dnt_func = 3'b100;
	/* Contructs dnt instruction based on predefined binary control signals */
	assign dnt_instruction = {dnt_opcode, dnt_V, dnt_rd, dnt_rs, dnt_rt, dnt_shamt, dnt_func};
		
	always_comb



		
		case(V)
			/* Vectorial datapath */
			1'b0: begin
				scalar_datapath_instruction = instruction;
				vector_datapath_instruction = dnt_instruction;
			end
			/* Scalar datapath */
			1'b1: begin

				if(opcode == 3'b000 || opcode == 3'b001 || opcode == 3'b010) begin
					scalar_datapath_instruction = dnt_instruction;
					vector_datapath_instruction = instruction;
				end
				else begin	
					scalar_datapath_instruction = instruction;
					vector_datapath_instruction = dnt_instruction;
				end				
			end
			/* Default */
			default: begin
				scalar_datapath_instruction = dnt_instruction;
				vector_datapath_instruction = dnt_instruction;
			end
		endcase

endmodule
