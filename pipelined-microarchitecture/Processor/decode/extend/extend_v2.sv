/*
Extend Module v2
Makes Zero Extention with updated instruction bitstream
Date: 09/04/24
*/
module extend_v2 # (parameter N = 24) (
	input  logic  [18:0] A,
    input  logic   [1:0] ImmSrc,
	output logic [N-1:0] ExtImm
	);

	always @(*)
        casex (ImmSrc)

            /* Zero Extention 13 bits */
            2'b00 : begin
                ExtImm = {13'b0, A[10:0]};
            end 

            /* Zero Extention 5 bits */
            2'b01 : begin
                ExtImm = {5'b0, A[18:0]};
            end

            /* 2'b10 */

            /* Zero Extention 17 bits */
            2'b11 : begin
                ExtImm = {17'b0, A[6:0]};
            end

			default : begin
				ExtImm = 24'b111111111111111111111111;
			end

		endcase

endmodule
