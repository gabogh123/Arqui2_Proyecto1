module signswitchneg(input logic [15:0] a,
						output logic [15:0]res
);

logic [15:0] temp; 

always @(a)
	begin 
		temp = a;
		temp[15:8] = ~(temp[15:8]);
		temp = temp + 16'b0000_0001_0000_0000;
		res = temp;
	end
endmodule
