/*
Testbench for adder module
*/

module adder_tb;

    parameter N = 24; 

    // Signals definition
    logic [N-1:0] A = 24'b11000; //  24 in binary
    logic [N-1:0] B = 24'b100111; //  39 in binary
    logic C_in = 0; // Carry-in

    logic [N-1:0] R_expected;
    logic Z_flag_expected, N_flag_expected, C_flag_expected, V_flag_expected;

    // Adder module instance
    adder #(N) dut (
        .A(A),
        .B(B),
        .C_in(C_in),
        .R(R_expected),
        .Z_flag(Z_flag_expected),
        .N_flag(N_flag_expected),
        .C_flag(C_flag_expected),
        .V_flag(V_flag_expected)
    );

    // Initialize inputs
    initial begin
        
        // Clock wait
        #10;

        // Results
        R_expected = A + B + C_in;
        Z_flag_expected = (R_expected == 0) ? 1 : 0;
        N_flag_expected = R_expected[N-1];
        C_flag_expected = dut.C_flag;
        V_flag_expected = dut.V_flag;

        // Display expected values
        $display("Expected Result: %h", R_expected);
        $display("Expected Z_flag: %b", Z_flag_expected);
        $display("Expected N_flag: %b", N_flag_expected);
        $display("Expected C_flag: %b", C_flag_expected);
        $display("Expected V_flag: %b", V_flag_expected);

        // Verify the result using assertions
        assert(R_expected === dut.R) 
            $error("Error: Result mismatch. Expected: %h, Actual: %h", R_expected, dut.R);
        
        assert(Z_flag_expected === dut.Z_flag) 
            $error("Error: Z_flag mismatch. Expected: %b, Actual: %b", Z_flag_expected, dut.Z_flag);
        
        assert(N_flag_expected === dut.N_flag) 
            $error("Error: N_flag mismatch. Expected: %b, Actual: %b", N_flag_expected, dut.N_flag);
        
        assert(C_flag_expected === dut.C_flag) 
            $error("Error: C_flag mismatch. Expected: %b, Actual: %b", C_flag_expected, dut.C_flag);
        
        assert(V_flag_expected === dut.V_flag) 
            $error("Error: V_flag mismatch. Expected: %b, Actual: %b", V_flag_expected, dut.V_flag);

        $finish;
    end

endmodule