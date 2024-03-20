module condition_checker(cond, N, Z, C, V, cond_ex);

    input logic [2:0] opcode;
    input logic N;
    input logic Z;
    input logic C;
    input logic V;

    output logic cond_ex;

    always_comb begin
        
        case (opcode)

            /* EQ -> Equal */
            3'b011:    cond_ex = Z;

            /* NE -> Not equal */
            3'b100:    cond_ex = ~Z;

            /* LT -> Signed less than */
            3'b110:    cond_ex = (N ^ V);

            /* GT -> Signed greater than */
            3'b101:    cond_ex = ~Z & ~(N ^ V);

            /* AL -> Always / unconditional */
            3'b111:    cond_ex = 1;
  
            /* CS/HS -> Carry set / unsigned higher or same */
            //4'b0010:    cond_ex = C;

            /* CC/LO -> Carry clear / usigned lower */
            //4'b0011:    cond_ex = ~C;

            /* MI -> Minus / negative */
            //4'b0100:    cond_ex = N;

            /* PL -> Plus / positive or zero */
            //4'b0101:    cond_ex = ~N;

            /* VS -> Overflow / overflow set */
            //4'b0110:    cond_ex = V;

            /* VC -> No overflow / overflow clear */
            //4'b0111:    cond_ex = ~V;

            /* HI -> Usigned higher */
            //4'b1000:    cond_ex = ~Z & C;

            /* LS -> Usigned lower o same */
            //4'b1001:    cond_ex = Z | ~C;

            /* GE -> Signed greater than or equal */
            //4'b1010:    cond_ex = ~(N ^ V);

            /* LE -> Signed less than or equal */
            //4'b1101:    cond_ex = Z | (N ^ V);

            default: cond_ex = 1;

        endcase

    end 

endmodule