/*
Main Decoder del Decoder del Control Unit
Lógica basada en la tabla de verdad de la tabla 7.2 del libro
Digital Design and Computer Architecture ARM Editon
de Sarah L. Harries & David Money Harries.

MODIFICAR
|---------------------------------------------------------------------------------------------------|
| Instr | Type | Opcode |  V  | Funct | | Branch | MemtoReg | MemW | ALUSrc | ImmSrc | RegW | ALUOp |
|---------------------------------------------------------------------------------------------------|
|  add  |   0   |     X     | DP Reg | |    0   |     0     |   0  |    0   |   XX   |   1  |   0   |
| 00 |     1     |     X     | DP Imm | |    0   |     0    |   0  |    1   |   00   |   1  |   X0   |
| 01 |     X     |     0     |  STR   | |    0   |     X    |   1  |    1   |   01   |   0  |   10   |
| 01 |     X     |     1     |  LDR   | |    0   |     1    |   0  |    1   |   01   |   1  |   X0   |
| 10 |     X     |     X     |   B    | |    1   |     0    |   0  |    1   |   10   |   0  |   X1   |
|---------------------------------------------------------------------------------------------------|

Date: 20/03/24
*/
module main_decoder(
        input  logic [2:0]   Opcode,
        input  logic              V,
        input  logic [2:0]    Funct,

        output logic         Branch,
        output logic       MemtoReg,
        output logic           MemW,
        output logic         ALUSrc,
        output logic [1:0]   ImmSrc,
        output logic           RegW,
        output logic          ALUOp
    );

    always @(*)
        casex (Opcode)

            /* Type R */
            3'b000 : begin
                Branch   = 1'b0;
                MemtoReg = 1'b0;
                MemW     = 1'b0;
                ALUSrc   = 1'b0;
                ImmSrc   = 2'b00; //XX
                RegW     = 1'b1;
                ALUOp    = 1'b1;
            end

            3'b100 : begin
                /* addi */
                if (V) begin
                    Branch   = 1'b0;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b1;
                    ALUOp    = 1'b1;
                end
                /* bnq */
                else begin
                    Branch   = 1'b1;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
            end

            3'b101 : begin
                /* subi */
                if (V) begin
                    Branch   = 1'b0;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b1;
                    ALUOp    = 1'b1;
                end
                /* bgt */
                else begin
                    Branch   = 1'b1;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
            end

            3'b110 : begin
                /* muli */
                if (V) begin
                    Branch   = 1'b0;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b1;
                    ALUOp    = 1'b1;
                end
                /* blt */
                else begin
                    Branch   = 1'b1;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
            end

            /* str */ /* Vector missing */
            3'b001 : begin
                Branch   = 1'b0;
                MemtoReg = 1'b0; // X
                MemW     = 1'b1;
                ALUSrc   = 1'b1;
                ImmSrc   = 2'b00;
                RegW     = 1'b0;
                ALUOp    = 1'b0;
            end

            /* ldr */ /* Vector missing */
            3'b010 : begin
                Branch   = 1'b0;
                MemtoReg = 1'b1;
                MemW     = 1'b0;
                ALUSrc   = 1'b1;
                ImmSrc   = 2'b00;
                RegW     = 1'b1;
                ALUOp    = 1'b0;
            end

            3'b111 : begin
                /* b */
                if (V) begin
                    Branch   = 1'b1;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b01;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
                /* beq */
                else begin
                    Branch   = 1'b1;
                    MemtoReg = 1'b0;
                    MemW     = 1'b0;
                    ALUSrc   = 1'b1;
                    ImmSrc   = 2'b00;
                    RegW     = 1'b0;
                    ALUOp    = 1'b0;
                end
            end

            /* default */
            default : begin 
                Branch   = 1'b0;
                MemtoReg = 1'b0;
                MemW     = 1'b0;
                ALUSrc   = 1'b0;
                ImmSrc   = 2'b00;
                RegW     = 1'b0;
                ALUOp    = 1'b0;
            end
    
        endcase

endmodule
