/*
Extend Module
Makes Zero Extention
Date: 20/03/24
*/
module extend # (parameter N = 24) (
	input  logic  [19:0] A,
    input  logic   [1:0] ImmSrc,
	output logic [N-1:0] ExtImm
	);

	always @(*)
        casex (ImmSrc)

            /* Zero Extention 12 bits */
            2'b00 : begin
                ExtImm = {12'b0, A[11:0]};
            end

            /* Zero Extention 4 bits */
            2'b01 : begin
                ExtImm = {4'b0, A[19:0]};
            end

			default : begin
				ExtImm = 24'b111111111111111111111111;
			end

		endcase

endmodule
