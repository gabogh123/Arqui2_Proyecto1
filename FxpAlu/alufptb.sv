`timescale 1ps / 1ps

module alufptb;

logic [15:0] a,b,res;
logic ALUControl;
logic [3:0] flags;

fixedpointAlu alu (a,b,ALUControl,res,flags);

 initial begin
        // Case sum
        ALUControl = 1'b0; // add
        a = 16'b1110000011000000;// 130 in binary
        b = 16'b0011001010010000; // 229 in binary 

        #10;
		
		  // Case mul - * +
        ALUControl = 1'b1; // add
        a = 16'b1110000011000000;// 130 in binary
        b = 16'b0000000010010000; // 229 in binary 

        #10;
		  
		  // Case mul - * -
        ALUControl = 1'b1; // add
        a = 16'b1110000011000000;// 130 in binary
        b = 16'b1000000010010000; // 229 in binary 

        #10;
		  
		  // Case mul + * -
        ALUControl = 1'b1; // add
        a = 16'b0110000011000000;// 130 in binary
        b = 16'b0000000010010000; // 229 in binary 

        #10;
		  
		  // Case mul + * +
        ALUControl = 1'b1; // add
        a = 16'b1110000011000000;// 130 in binary
        b = 16'b0000000010010000; // 229 in binary 

        #10;
		  
		  end
endmodule