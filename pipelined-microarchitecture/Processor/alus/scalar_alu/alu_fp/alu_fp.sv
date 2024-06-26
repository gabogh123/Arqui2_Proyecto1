/*
ALU w fixed point parametrizable para N
Date: 16/03/24
*/
module alu_fp # (parameter N = 24)(
        input   [N-1:0] A_fp, 
        input   [N-1:0] B_fp,
        input   [2:0] ALUControl,
		
        output  [N-1:0] result,
		output  [3:0] flags
	);

	logic [N-1:0] A;
	logic [N-1:0] B;

	assign A = A_fp[14:0];
	assign B = B_fp[14:0];

	logic [31:0] temp;
	logic sign_a, sign_b;

	assign sign_a = A[15];
	assign sign_b = B[15];

	logic opcarry;

	logic [3:0] NZVCFlags;

	always @ (*) begin
		case (ALUControl)
			3'b000: 
				begin
					if (sign_a != sign_b) begin 
						if (A > B) begin
							temp = A - B;
							opcarry = 0;
							temp[15] = sign_a;
							end
						else begin
							temp = B - A;	
							opcarry = 0;
							temp[15] = sign_b;
							end
					end else begin 
						temp = A[14:0] + B[14:0];
						opcarry = temp[15];
						temp[15] = sign_a;
					end
				end
			3'b010: 
				begin
					temp =  A[8:0] * B[8:0];
					temp = temp >> 8;
					temp[15] = (sign_a != sign_b) ? 1 : 0;
				end
			default temp = A + B; //ADD
		endcase
	end

	assign result = temp[15:0];

	assign NZVCFlags[0] = opcarry;
	assign NZVCFlags[2] = (result == 0) ? 1 : 0;
	assign NZVCFlags[1] = ((sign_a == 1 & sign_b == 1 & temp[15] == 0 | sign_a == 0 & sign_b == 0 & temp[15] == 1) & ALUControl == 0) ? 1 : 0;
	assign NZVCFlags[3] = temp[15];

endmodule
