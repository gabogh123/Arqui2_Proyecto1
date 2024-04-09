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

    logic V;
    assign V = 1;


	always_comb begin
        
        if (V) begin
            case (Cond)

                /* b -> Always / unconditional */
                3'b111:    CondEx = 1;

				/* undefined */
                default: CondEx = 1'bx;

            endcase
        end
		else begin
            case (Cond)

                /* EQ -> Equal */
                3'b111:    CondEx = Z_flag;

                /* NE -> Not equal */
                3'b100:    CondEx = ~Z_flag;

                /* GT -> Signed greater than */
                3'b101:    CondEx = ~Z_flag & ~(N_flag ^ V_flag);
                
                /* LT -> Signed less than */
                3'b110:    CondEx = (N_flag ^ V_flag);

                /* undefined */
                default: CondEx = 1'bx;

            endcase
        end

    end 

endmodule

/* CS/HS -> Carry set / unsigned higher or same */
//4'b0010:    CondEx = C;

/* CC/LO -> Carry clear / usigned lower */
//4'b0011:    CondEx = ~C;

/* MI -> Minus / negative */
//4'b0100:    CondEx = N;

/* PL -> Plus / positive or zero */
//4'b0101:    CondEx = ~N;

/* VS -> Overflow / overflow set */
//4'b0110:    CondEx = V;

/* VC -> No overflow / overflow clear */
//4'b0111:    CondEx = ~V;

/* HI -> Usigned higher */
//4'b1000:    CondEx = ~Z & C;

/* LS -> Usigned lower o same */
//4'b1001:    CondEx = Z | ~C;

/* GE -> Signed greater than or equal */
//4'b1010:    CondEx = ~(N ^ V);

/* LE -> Signed less than or equal */
//4'b1101:    CondEx = Z | (N ^ V);
