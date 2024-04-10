/*
Multiplier testbench
*/
module tb_multiplier;


    parameter N = 24; 

    // Signals definition
    logic [N-1:0] a = 24'b1111; // Example: 15 in binary
    logic [N-1:0] b = 24'b111; // Example: 7 in binary
    logic [N-1:0] result_expected;
    logic z_flag_expected, n_flag_expected, c_flag_expected, v_flag_expected;

    // Multiplier module instance
    multiplier #(N) dut (
        .a(a),
        .b(b),
        .result(result_expected),
        .z_flag(z_flag_expected),
        .n_flag(n_flag_expected),
        .c_flag(c_flag_expected),
        .v_flag(v_flag_expected)
    );

    // Initialize inputs
    initial begin
        // Clock wait
        #10;

        // Results
        result_expected = a * b;
        z_flag_expected = (result_expected == 0) ? 1 : 0;
        c_flag_expected = (result_expected[N*2-1]) ? 1 : 0;
        n_flag_expected = result_expected[N-1];
        v_flag_expected = ((a[N-1] ^ b[N-1]) & n_flag_expected) ? 1 : 0;

        // Display expected values
        $display("Expected Result: %h", R_expected);
        $display("Expected Z_flag: %b", Z_flag_expected);
        $display("Expected N_flag: %b", N_flag_expected);
        $display("Expected C_flag: %b", C_flag_expected);
        $display("Expected V_flag: %b", V_flag_expected);

        // Verify the result using assertions
        assert(result_expected === dut.result) 
        else $error("Error: Result mismatch");

        assert(z_flag_expected === dut.z_flag) 
        else $error("Error: z_flag mismatch");

        assert(c_flag_expected === dut.c_flag) 
        else $error("Error: c_flag mismatch");

        assert(n_flag_expected === dut.n_flag) 
        else $error("Error: n_flag mismatch");

        assert(v_flag_expected === dut.v_flag) 
        else $error("Error: v_flag mismatch");

        // Display message if all checks pass
        $display("All checks passed");

        // Finish simulation
        $finish;
    end

endmodule