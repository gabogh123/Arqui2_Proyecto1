`timescale 1ps / 1ps

module alufptb;

logic [15:0] a,b,res;
logic [2:0] ALUControl;
logic [3:0] flags;

fixedpointAlu alu (a,b,ALUControl,res,flags);

 initial begin
        // Case sum b-0.75 + a3.125
        ALUControl = 3'b000; // add
        a = 16'b0000001100100000;// 
        b = 16'b1000000011000000; // 

        #10;
		  
		   // Case sum a-0.375 + 1.5
        ALUControl = 3'b000; // add
        a = 16'b1000000001100000;// 
        b = 16'b0000000110000000; // 

        #10;
		  
		  // Case sum a-0.375 + b-0.75
        ALUControl = 3'b000; // add
        a = 16'b1000000001100000;// 
        b = 16'b1000000011000000; // 
		  
		  #10;
		  
		  // Case sum a-35.375 + b-6.75
        ALUControl = 3'b000; // add
        a = 16'b10100011_01100000;// 
        b = 16'b10000110_11000000; // 

        #10;
		  
		  // Case sum a27.375 + b33.21875
        ALUControl = 3'b000; // add
        a = 16'b00011011_01100000;// 
        b = 16'b00100001_00111000; // 

        #10;

		  
		  // Case mul -0.X * 0.X
        ALUControl = 3'b010; // mul
        a = 16'b10000000_11000000;
        b = 16'b00000000_10010000;  

        #10;
		  
		  // B = -1 A 0.X
		   ALUControl = 3'b010; // mul
        a = 16'b00000000_11000000;
        b = 16'b10000001_00000000; 

        #10;
		  
		  	// B = -1 A -0.X
		   ALUControl = 3'b010; // mul
        a = 16'b10000000_11000000;
        b = 16'b10000001_00000000; 

        #10;
		  
		  
		  end
endmodule