/*
Control Unit's ALU Decoder v2.
Based on the pipeline's implementation from the book
Digital Design and Computer Architecture ARM Editon
by Sarah L. Harries & David Money Harries.

Date: 09/04/24
*/
module alu_decoder_v2(
        input  logic [2:0]     Opcode,
        input  logic [1:0]          S,
        input  logic [2:0]       Func,
        input  logic            ALUOp,

        output logic [2:0] ALUControl,
        output logic           ALUSel,
        output logic [1:0]  FlagWrite
    );

    /* All 1's so that flags are always writen if conditions are met */
    assign FlagWrite = 2'b11;

    always @ (*)
        if (ALUOp) begin

            casex (Opcode)

                /* Scalar datapath */ /* Scalar Arithmetic Operations */
                3'b000: begin
                    casex (Func)

                        /* add */
                        3'b000 : begin
                            ALUControl = 3'b000;
                            ALUSel = 1'b0;
                        end

                        /* sub */
                        3'b001 : begin
                            ALUControl = 3'b001;
                            ALUSel = 1'b0;
                        end

                        /* mul */
                        3'b010 : begin
                            ALUControl = 3'b010;
                            ALUSel = 1'b0;
                        end

                        /* sll */
                        3'b011 : begin
                            ALUControl = 3'b011;
                            ALUSel = 1'b0;
                        end

                        /* addf */
                        3'b100 : begin
                            ALUControl = 3'b000;
                            ALUSel = 1'b1;
                        end

                        /* subf */
                        3'b101 : begin
                            ALUControl = 3'b001;
                            ALUSel = 1'b1;
                        end

                        /* mulf */
                        3'b110 : begin
                            ALUControl = 3'b010;
                            ALUSel = 1'b1;
                        end

                        /* slr */
                        3'b111 : begin
                            ALUControl = 3'b111;
                            ALUSel = 1'b0;
                        end

                        /* default */
                        default : begin 
                            ALUControl = 3'bxxx;
                            ALUSel = 1'bx;
                        end
                    
                    endcase
                end
                
                /* Vectorial datapath */ /* Vector Arithmetic Operations */
                3'b001: begin
                    casex (Func)

                        /* addv */
                        3'b000 : begin
                            ALUControl = 3'b000;
                            ALUSel = 1'b0;
                        end

                        /* subv */
                        3'b001 : begin
                            ALUControl = 3'b001;
                            ALUSel = 1'b0;
                        end

                        /* mulv */
                        3'b010 : begin
                            ALUControl = 3'b010;
                            ALUSel = 1'b0;
                        end

                        /* unimplemented */
                        3'b011 : begin
                            ALUControl = 3'bxxx;
                            ALUSel = 1'bx;
                        end

                        /* addvf */
                        3'b100 : begin
                            ALUControl = 3'b000;
                            ALUSel = 1'b1;
                        end

                        /* subvf */
                        3'b101 : begin
                            ALUControl = 3'b001;
                            ALUSel = 1'b1;
                        end

                        /* mulvf */
                        3'b110 : begin
                            ALUControl = 3'b010;
                            ALUSel = 1'b1;
                        end

                        /* unimplemented */
                        3'b111 : begin
                            ALUControl = 3'bxxx;
                            ALUSel = 1'bx;
                        end

                        /* default */
                        default : begin 
                            ALUControl = 3'bxxx;
                            ALUSel = 1'bx;
                        end
                    
                    endcase
                end

                /* Scalar datapath */ /* Scalar Immediate Arithmetic Operations */
                3'b010: begin
                    casex (S)

                        /* addi */
                        2'b00 : begin
                            ALUControl = 3'b000;
                            ALUSel = 1'b0;
                        end

                        /* subi */
                        2'b01 : begin
                            ALUControl = 3'b001;
                            ALUSel = 1'b0;
                        end

                        /* muli */
                        2'b10 : begin
                            ALUControl = 3'b010;
                            ALUSel = 1'b0;
                        end

                        /* ... */

                        /* default */
                        default : begin 
                            ALUControl = 3'bxxx;
                            ALUSel = 1'bx;
                        end
                    
                    endcase
                end

                /* Scalar datapath */ /* Branches */
                3'b110: begin
                    ALUControl = 3'b001; // Branches use substraction for flag generation
                    ALUSel = 1'b0;
                end

                /* ... */

                /* default */
                default : begin 
                    ALUControl = 3'b000; // add
                    ALUSel = 1'b0; // no fp alu
                end
            
            endcase
            
        end
        else begin
            ALUControl = 3'b000; // add
            ALUSel = 1'b0; // no fp alu
        end

endmodule
