module signswitch(input logic [15:0] a,
						output logic [15:0]res
);


logic [15:0] temp; 

always @(a)
	begin 
		temp = a - 16'b0000_0001_0000_0000;
		temp[15:8] = ~(temp[15:8]);
		res = temp;
	end
endmodule
