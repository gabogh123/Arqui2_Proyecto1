module tb_full_adder;
    // Time parameter
    parameter SIM_TIME = 20;

    // Signals
    logic A, B, C_in, R, C_out;

    // Full adder module instance
    full_adder dut (
        .A(A),
        .B(B),
        .C_in(C_in),
        .R(R),
        .C_out(C_out)
    );

    //Test cases

    initial begin
        A = 0; B = 0; C_in = 0; #1;
        A = 0; B = 0; C_in = 1; #1;
        A = 0; B = 1; C_in = 0; #1;
        A = 0; B = 1; C_in = 1; #1;
        A = 1; B = 0; C_in = 0; #1;
        A = 1; B = 0; C_in = 1; #1;
        A = 1; B = 1; C_in = 0; #1;
        A = 1; B = 1; C_in = 1; #1;

        $finish;
    end

    // Results checking
    always @(posedge $finish) 
    begin
        // Results display 
        $display("A=%b, B=%b, C_in=%b => R=%b, C_out=%b", A, B, C_in, R, C_out);
        
        // Asserts for result checking
        //assert(R == (A ^ B) ^ C_in) report "Error: Incorrect answer" severity error;
        //assert(C_out == ((A & B) | (C_in & (A ^ B)))) report "Error: Incorrect carry" severity error;
    end

endmodule