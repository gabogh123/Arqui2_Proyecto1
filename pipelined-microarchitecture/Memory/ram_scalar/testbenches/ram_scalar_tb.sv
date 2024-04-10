/*
Scalar RAM testbench
17/03/24
*/
module ram_scalar_tb;

    timeunit 1ps;
    timeprecision 1ps;

	logic [23:0] address_t;
    logic 			   clk;
	logic  [23:0]    data_t;
	logic 		    rden_t;
	logic 		    wren_t;
	logic  [23:0]       q_t;

	// ram module instance
    ram_scalar uut (.address(address_t),
				    .clock(clk),
				    .data(data_t),
				    .rden(rden_t),
				    .wren(wren_t),
				    .q(q_t));

	// Initialize inputs

    initial begin
		$display("ram_scalar Test Bench:\n");

		clk = 0;

        address_t = 24'h1000;
        data_t = 24'habcdef;
        rden_t = 1'b0;
        wren_t = 1'b0;

        $monitor("address_t = %b (%h)\n", address_t, address_t,
                 "data_t = %b (%h)\n", data_t, data_t,
                 "rden_t = %b\n", rden_t,
                 "wren_t = %b\n", wren_t,
                 "q_t = %b (%h)\n", q_t, q_t);
    end

    always
		#50 clk = !clk;

    initial	begin

        #200

		rden_t = 1'b1;

		#200

		address_t = 24'h1001;

        #200

        wren_t = 1'b1;

		#200

		address_t = 24'h1002;

		#100

        wren_t = 1'b0;

        #100

        rden_t = 1'b0;
        
		#200

		address_t = 24'h1003;

        #100;

		// Done

    end

    initial
	#2500 $finish;                                 

endmodule
