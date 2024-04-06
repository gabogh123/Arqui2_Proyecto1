/*
Instruction Control Module
Selects the type of instructions datapath.
dnt instruction = 25'b0001 0000 0000 0000 00000 100
Data: 06/10/24
*/
module instruction_control # (parameter N = 24) (
		input  logic 		 V,
		input  logic [N-1:0] instruction,
		output logic [N-1:0] controlled_scalar_instruction,
		output logic [N-1:0] controlled_vector_instruction
	);
							
always_comb

	case(V)
	
		1'b0: begin
					controlled_scalar_instruction = instruction;
					controlled_vector_instruction = 25'b000100000000000000000100;
		end

		1'b1: begin
					InstOut = 25'b000100000000000000000100;
					controlled_vector_instruction = instruction;
		end
		
		default: begin
						InstOut = 25'b000100000000000000000100;
						controlled_vector_instruction = 25'b000100000000000000000100;
		end

	endcase

endmodule
