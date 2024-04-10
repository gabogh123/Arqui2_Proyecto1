/*
ram_scalar testbench
Date: 19/03/24
*/
module ram_scalar_tb;

    timeunit 1ps;
    timeprecision 1ps;

    logic	[13:0]  address_a_t;    // Instructions
	logic	[13:0]  address_b_t;    // Data
	logic	                clk;
	logic	[23:0]     data_a_t;
	logic	[23:0]     data_b_t;
	logic	           rden_a_t;
	logic	           rden_b_t;
	logic	           wren_a_t;
	logic	           wren_b_t;
	logic	[23:0]        q_a_t;
	logic	[23:0]        q_b_t;

    /* ram_scalar instance */
    ram_scalar	uut (
        .address_a ( address_a_t ),
        .address_b ( address_b_t ),
        .clk0 ( clk ),
        .clk1 ( dclk ),
        .data_a ( data_a_t ),
        .data_b ( data_b_t ),
        .rden_a ( rden_a_t ),
        .rden_b ( rden_b_t ),
        .wren_a ( wren_a_t ),
        .wren_b ( wren_b_t ),
        .q_a ( q_a_t ),
        .q_b ( q_b_t )
	);

	// Initialize inputs

    initial begin
		$display("ram_scalar testbench:\n");

		clk = 0;

        address_a_t = 14'b01;
        address_b_t = 14'b00;

        data_a_t = 24'h666666;
        data_b_t = 24'h888888;

        rden_a_t = 1'b0;
        rden_b_t = 1'b0;
        
        wren_a_t = 1'b0;    // Don't change
        wren_b_t = 1'b0;

        $monitor("Instruccion Memory:\n",
                 "address_a_t = %b (%h)\n", address_a_t, address_a_t,
                 "data_a_t = %b (%h)\n", data_a_t, data_a_t,
                 "rden_a_t = %b\n", rden_a_t,
                 "wren_a_t = %b\n", wren_a_t,
                 "q_a_t = %b (%h)\n", q_a_t, q_a_t,
                 "\nData Memory:\n",
                 "address_b_t = %b (%h)\n", address_b_t, address_b_t,
                 "data_b_t = %b (%h)\n", data_b_t, data_b_t,
                 "rden_b_t = %b\n", rden_b_t,
                 "wren_b_t = %b\n", wren_b_t,
                 "q_b_t = %b (%h)\n\n\n", q_b_t, q_b_t);
    end

    always
		#50 clk = !clk;
    
    always
		#25 dclk = !dclk;
    

    initial	begin

        #100

        $display("Instruction read, no data read, no data write\n");

        #100

		rden_a_t = 1'b1;
		rden_b_t = 1'b0;
		wren_b_t = 1'b0;

		#100

        $display("instruction read, data read, no data write\n");

        #100

        rden_a_t = 1'b1;
		rden_b_t = 1'b1;
		wren_b_t = 1'b0;

		#200

        rden_a_t = 1'b0;
		rden_b_t = 1'b0;
		wren_b_t = 1'b0;

		#100

        $display("Address change\n");

        address_a_t = 14'b10;
        address_b_t = 14'b01;

        #100

        $display("no instruction read, no data read, data write\n");

        rden_a_t = 1'b0;
		rden_b_t = 1'b0;
		wren_b_t = 1'b1;

        #50

        $display("instruction read, no data read, no data write\n");

        #50

        rden_a_t = 1'b1;
		rden_b_t = 1'b1;
		wren_b_t = 1'b0;

		#100

        $display("instruction read, data read, no data write\n");

        #100

        rden_a_t = 1'b0;
		rden_b_t = 1'b0;
		wren_b_t = 1'b0;

		#100

        rden_a_t = 1'b1;
		rden_b_t = 1'b1;
		wren_b_t = 1'b0;

		#100;

		// Done

    end

    initial
	#1500 $finish;                                 

endmodule
