`timescale 1 ps / 100 fs
// Control unit module 
//19/3/2024

module control_unit(
		
		input [2:0] Opcode,
		input [2:0] Funct,
		input Vec,

		output PCSrc,
		output RegWrite,
		output ImmSrc,
		output ALUSrc,
		output [2:0] AluOp,
		output MemWrite,
		output MemRead,
		output MemtoReg
);



casex (Opcode)

	3'b000 : begin 
	end

	3'b001 : begin
	end

	3'b010 : begin
	end

	3'b011 : begin
	end

	3'b100 : begin
	end

	3'b101 : begin
	end

	3'b110 : begin
	end

	3'b111 : begin
	end


endmodule
