module fixedpointAlu(input logic  [15:0] A , B,
							input logic [2:0] ALUControl,
							output logic  [15:0] Result,
							output logic [3:0] NZVCFlags
);


logic [31:0] temp = 0;
logic sign_a, sign_b;
logic opcarry;

always @(ALUControl, Result, A, B, NZVCFlags)
	begin
	sign_a = A[15];
	sign_b = B[15];
	case (ALUControl)
	3'b000: 
		begin
			if (sign_a != sign_b) begin 
				if (A[14:0] > B[14:0]) begin
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
	Result = temp[15:0];
	NZVCFlags[0] = opcarry;
	NZVCFlags[2] = (Result == 0) ? 1 : 0;
	NZVCFlags[1] = ((sign_a == 1 & sign_b == 1 & temp[15] == 0 | sign_a == 0 & sign_b == 0 & temp[15] == 1) & ALUControl == 0) ? 1 : 0;
	NZVCFlags[3] = temp[15];
	end
endmodule 