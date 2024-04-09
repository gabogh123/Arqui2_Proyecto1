/*
Condition Checker Module
Date: 08/04/24
*/
module condition_checker(
		input logic [3:0] Cond,
		input logic [3:0] Flags,
		
		output logic CondEx
	);

	/* Flag assign */
	logic N_flag;
    logic Z_flag;
    logic C_flag;
    logic V_flag;
	assign N_flag = Flags[0];
    assign Z_flag = Flags[1];
    assign C_flag = Flags[2];
    assign V_flag = Flags[3];


	always_comb begin
        
        if (V) begin
            case (Opcode)

                /* b -> Always / unconditional */
                3'b111:    condEx = 1;

				/* undefined */
                default: condEx = 1'bx;

            endcase
        end
		else begin
            case (Opcode)

                /* EQ -> Equal */
                3'b111:    condEx = Z_flag;

                /* NE -> Not equal */
                3'b100:    condEx = ~Z_flag;

                /* GT -> Signed greater than */
                3'b101:    condEx = ~Z_flag & ~(N_flag ^ V_flag);
                
                /* LT -> Signed less than */
                3'b110:    condEx = (N_flag ^ V_flag);

                /* undefined */
                default: condEx = 1'bx;

            endcase
        end

    end 

endmodule

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
