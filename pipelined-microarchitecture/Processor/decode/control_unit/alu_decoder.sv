/*
ALU Decoder del Decoder del Control Unit
Lógica basada en la tabla de verdad de la tabla 7.4 del libro
Digital Design and Computer Architecture ARM Editon
de Sarah L. Harries & David Money Harries.

MODIFICAR
|-----------------------------------------------------------------------------------------------|
|       | Funct [4:1] | Funct [0] |       | |                  |            |         |         |
| ALUOp |     cmd     |     S     | Notes | | ALUControl [1:0] | FlagW[1:0] | NoWrite | ALUSrcA |
|-----------------------------------------------------------------------------------------------|
|   0   |   X X X X   |     X     | notDP | |        00        |     00     |    0    |    0    |
|-----------------------------------------------------------------------------------------------|
|   1   |   0 1 0 0   |     0     |  ADD  | |        00        |     00     |    0    |    0    |
|       |             |     1     |       | |                  |     11     |    0    |    0    |
|       |---------------------------------------------------------------------------------------|
|       |   0 0 1 0   |     0     |  SUB  | |        01        |     00     |    0    |    0    |
|       |             |     1     |       | |                  |     11     |    0    |    0    |
|       |---------------------------------------------------------------------------------------|
|       |   0 0 0 0   |     0     |  AND  | |        10        |     00     |    0    |    0    |
|       |             |     1     |       | |                  |     10     |    0    |    0    |
|       |---------------------------------------------------------------------------------------|
|       |   1 1 0 0   |     0     |  ORR  | |        11        |     00     |    0    |    0    |
|       |             |     1     |       | |                  |     10     |    0    |    0    |
|       |---------------------------------------------------------------------------------------|
|       |   1 0 1 0   |     1     |  CMP  | |        01        |     11     |    1    |    0    |
|       |---------------------------------------------------------------------------------------|
|       |   1 1 0 1   |     0     |  MOV  | |        00        |     00     |    0    |    1    |
|       |             |     1     |       | |                  |     11     |    0    |    1    |
|-----------------------------------------------------------------------------------------------|

Date: 20/03/24
*/
module alu_decoder(
        input  logic [2:0]     Opcode,
        input  logic [2:0]      Funct,
        input  logic            ALUOp,

        output logic [2:0] ALUControl,
        output logic ALUSel
    );

    always @(*)
        if (ALUOp) begin

            casex (Opcode)

                /* Type R */
                3'b000 : begin
                    ALUControl = Funct;
                end

                /* addi */
                3'b100 : begin
                    ALUControl = 3'b000;
                end

                /* subi */
                3'b101 : begin
                    ALUControl = 3'b001;
                end

                /* muli */
                3'b110 : begin
                    ALUControl = 3'b010;
                end

                /* default */
                default : begin 
                    ALUControl = 3'b000; // add
                end
            
            endcase
            
        end
        else begin
            ALUControl = 3'b000; // add
        end

endmodule
