`timescale 1ps / 1ps

module alu_tb;

    parameter N = 24;
    
    // Signal initialization
    logic [N-1:0] A, B;
    logic [2:0] ALUControl;
    logic [N-1:0] Output;
    logic c_flag, z_flag, gt_flag, v_flag, n_flag;
    
    // ALU model instance
    alu #(N) dut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Output(Output),
        .c_flag(c_flag),
        .z_flag(z_flag),
        .gt_flag(gt_flag),
        .v_flag(v_flag),
        .n_flag(n_flag)
    );
    
    // Data 
    initial begin
        // Case sum
        A = 24'b10000010; // 130 in binary
        B = 24'b11100101; // 229 in binary 

        ALUControl = 3'b000; // add

        #10;

        assert(Output == 24'b101100111) //359 in binary
            else $error("Error: Incorrect result. Expected: %h, Obtained: %h", 24'b101100111, Output);
        
        // Case sub
        A = 24'b11100101; // 229 in binary
        B = 24'b10000010; // 130 in binary

        ALUControl = 3'b001; // sub

        #10;

        assert(Output == 24'b1100011)
            else $error("Error: Incorrect result. Expected: %h, Obtained: %h", 32'b1100011, Output);
        
        // Case left shift
        A = 24'b101;
        B = 24'b010; // Shamt

        ALUControl = 3'b010; // sll

        #10;

        assert(Output == 24'b10100)
            else $error("Error: Incorrect result: Expected: %h, Obtained: %h", 24'b10100, Output);
        
        //Case mult
        A = 24'b1010;
        B = 24'h101;

        ALUControl = 3'b011; // mult

        #10;
         
        assert(Output == 24'b110010)
            else $error("Error: Incorrect result: Expected: %h, Obtained: %h", 24'b110010, Output);
                
        $finish;
    end
    
endmodule
