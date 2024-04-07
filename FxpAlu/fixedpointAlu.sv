module fixedpointAlu(input logic  [15:0] A , B,
							input logic ALUControl,
							output logic  [15:0] Result,
							output logic [3:0] NZVCFlags
);


logic [31:0] temp;
logic sign_a, sign_b;
logic [15:0] complemento;
logic [15:0] complemento_res;

signswitch comp (A, complemento);
signswitchneg compres (temp[15:0],complemento_res);

always @(ALUControl, Result, A, B, NZVCFlags)
	begin
	sign_a = A[15];
	sign_b = B[15];
	case (ALUControl)
	1'b0: temp = A + B; //ADD
	
	1'b1: 
		begin
		temp = (sign_a == 1) ?  complemento * B[8:0] : A * B[8:0];
		temp = temp >> 8;
		temp = (sign_a != sign_b) ? complemento_res : temp;
		end
	default temp = A + B; //ADD
	endcase 
	Result = temp[15:0];
	NZVCFlags[0] = temp[16];
	end
endmodule 