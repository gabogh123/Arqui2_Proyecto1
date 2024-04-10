/*
Control Unit's Main Decoder v2.
Based on the pipeline's implementation from the book
Digital Design and Computer Architecture ARM Editon
by Sarah L. Harries & David Money Harries.

Date: 09/04/24
*/
module main_decoder_v2(
        input  logic [2:0]   Opcode,
        input  logic [1:0]        S,
        input  logic [2:0]     Func,

        output logic         Branch,
        output logic [1:0]   RegSrc,
        output logic           RegW,
        output logic           MemW,
        output logic       MemtoReg,
        output logic         ALUSrc,
        output logic [1:0]   ImmSrc,
        output logic          ALUOp
    );

    always @ (*)
        casex (Opcode)

            /* Scalar datapath */ /* Scalar Arithmetic Operations */
			3'b000: begin
                /* sll => 011 & slr => 111 */
                if (Func[1:0] == 2'b11) begin
                    Branch   = 1'b0;
                    RegSrc   = 2'b0x;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b11;
                    RegW     = 1'b1;
                    ALUOp    = 1'b1;
                end
                /* everything else doesn't need to extend the immediate */
                else begin
                    Branch   = 1'b0;
                    RegSrc   = 2'b00;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b0;
                    ImmSrc   = 2'bxx;
                    RegW     = 1'b1;
                    ALUOp    = 1'b1;
                end
			end
			
			/* Vectorial datapath */ /* Vector Arithmetic Operations */
			3'b001: begin
				Branch   = 1'bx;    // not implemented yet
                RegSrc   = 2'bxx;
                MemtoReg = 1'bx;
                MemW     = 1'bx;
                ALUSrc   = 1'bx;
                ImmSrc   = 2'bxx;
                RegW     = 1'bx;
                ALUOp    = 1'bx;
			end

			/* Scalar datapath */ /* Scalar Immediate Arithmetic Operations */
			3'b010: begin
				Branch   = 1'b0;
                RegSrc   = 2'b0x;
                MemtoReg = 1'b0;
                MemW     = 1'b0;
                ALUSrc   = 1'b1;
                ImmSrc   = 2'b00; // needs to extend the immediate
                RegW     = 1'b1;
                ALUOp    = 1'b1;
			end

			/* Scalar datapath */ /* Scalar memory access */
			3'b011: begin
				/* str */
                if (S == 2'b00) begin
                    Branch   = 1'b0;
                    RegSrc   = 2'b0x;
                    MemtoReg = 1'bx;
                    MemW     = 1'b1; // writes on memory
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
                /* ldr */
                else if (S == 2'b01) begin
                    Branch   = 1'b0;
                    RegSrc   = 2'b0x;
                    MemtoReg = 1'b1; // writes on regs from memory
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b1;
                    ALUOp    = 1'b0;
                end
                /* unimplemented */
                else begin
                    Branch   = 1'bx;    // not implemented
                    RegSrc   = 2'bxx;
                    MemtoReg = 1'bx;
                    MemW     = 1'bx;
                    ALUSrc   = 1'bx;
                    ImmSrc   = 2'bxx;
                    RegW     = 1'bx;
                    ALUOp    = 1'bx;
                end
			end

			/* Vectorial datapath */ /* Vector Memory access */
			3'b101: begin
				Branch   = 1'bx;    // not implemented yet
                RegSrc   = 2'bxx;
                MemtoReg = 1'bx;
                MemW     = 1'bx;
                ALUSrc   = 1'bx;
                ImmSrc   = 2'bxx;
                RegW     = 1'bx;
                ALUOp    = 1'bx;
			end

			/* Scalar datapath */ /* Branches */
			3'b110: begin
				/* b (J type instruction) */
                if (Func[1:0] == 2'b11) begin
                    Branch   = 1'b1;
                    RegSrc   = 2'bxx;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'bx;
                    ImmSrc   = 2'b01;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
                /* everything else doesn't need to extend the immediate */
                else begin
                    Branch   = 1'b1;
                    RegSrc   = 2'b01;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b0;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b1;
                end
			end

			/* Vector datapath */ /* Vector management  */
			3'b100: begin
				Branch   = 1'bx;    // not implemented yet
                RegSrc   = 2'bxx;
                MemtoReg = 1'bx;
                MemW     = 1'bx;
                ALUSrc   = 1'bx;
                ImmSrc   = 2'bxx;
                RegW     = 1'bx;
                ALUOp    = 1'bx;
			end

			/* Default */
            /* Datapath management  */
			3'b111: begin
				Branch   = 1'bx;    // not implemented yet
                RegSrc   = 2'bxx;
                MemtoReg = 1'bx;
                MemW     = 1'bx;
                ALUSrc   = 1'bx;
                ImmSrc   = 2'bxx;
                RegW     = 1'bx;
                ALUOp    = 1'bx;
			end
    
        endcase

endmodule
