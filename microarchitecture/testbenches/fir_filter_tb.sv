/*
fir_filter (Top Module) testbench
Date: 20/03/24
MODIFICAR
*/
module fir_filter_tb;

    timeunit 1ps;
    timeprecision 1ps;

	logic	                clk;
	logic	                rst;
	logic	                pwr;
	logic	                dbg;
	logic	                stp;
	logic	                out;

    logic eclk;

    /* fir_filter instance */
    fir_filter uut (
        .clk(clk),
        .rst(rst),
        .pwr(pwr),
        .dbg(dbg),
        .stp(stp),
        .out(out)
	);

	// Initialize inputs

    initial begin
		$display("fir_filter testbench:\n");

		clk = 0;
		rst = 0;
		pwr = 1;
		dbg = 0;
		stp = 0;

        

        $monitor("Processor Signals:\n",
                 "instruction = %b (%h)\n", uut.instruction, uut.instruction,
                 "read_scalar_data = %b (%h)\n", uut.scalar_data_read, uut.scalar_data_read,
                 "pc_address = %b ($%d)\n", uut.pc_address, uut.pc_address,
                 "MemWriteScalar = %b\n", uut.mem_write_scalar, uut.mem_write_scalar,
                 "alu_scalar_result = %b (%h)\n", uut.scalar_data_address, uut.scalar_data_address,
                 "write_scalar_data = %b (%h)\n\n\n", uut.write_scalar_data, uut.write_scalar_data);
    end

    always begin
		#50 clk = !clk;
        eclk = uut.eclk;
    end

    initial	begin

        #100

        //$display("Instruction read, no data read, no data write\n");

        rst <= 1;

		#100
        
        pwr <= 0;
        rst <= 0;

        #100

        pwr = 1;

        #100;

		// Done

    end

    initial
	#1500 $finish;                                 

endmodule
