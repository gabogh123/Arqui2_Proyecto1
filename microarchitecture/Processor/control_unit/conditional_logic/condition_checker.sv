/* Condition checked module 
   Date: 20/3/2024
*/

module condition_checker(cond, N, Z, C, V, condEx);

    input logic [2:0] opcode;
    input logic N;
    input logic Z;
    input logic C;
    input logic V;

    output logic condEx;

    always_comb begin
        
        case (opcode)

            /* EQ -> Equal */
            3'b011:    condEx = Z;

            /* NE -> Not equal */
            3'b100:    condEx = ~Z;

            /* LT -> Signed less than */
            3'b110:    condEx = (N ^ V);

            /* GT -> Signed greater than */
            3'b101:    condEx = ~Z & ~(N ^ V);

            /* AL -> Always / unconditional */
            3'b111:    condEx = 1;
  
            /* CS/HS -> Carry set / unsigned higher or same */
            //4'b0010:    condEx = C;

            /* CC/LO -> Carry clear / usigned lower */
            //4'b0011:    condEx = ~C;

            /* MI -> Minus / negative */
            //4'b0100:    condEx = N;

            /* PL -> Plus / positive or zero */
            //4'b0101:    condEx = ~N;

            /* VS -> Overflow / overflow set */
            //4'b0110:    condEx = V;

            /* VC -> No overflow / overflow clear */
            //4'b0111:    condEx = ~V;

            /* HI -> Usigned higher */
            //4'b1000:    condEx = ~Z & C;

            /* LS -> Usigned lower o same */
            //4'b1001:    condEx = Z | ~C;

            /* GE -> Signed greater than or equal */
            //4'b1010:    condEx = ~(N ^ V);

            /* LE -> Signed less than or equal */
            //4'b1101:    condEx = Z | (N ^ V);

            default: condEx = 1;

        endcase

    end 

endmodule