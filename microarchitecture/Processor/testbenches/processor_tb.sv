/*
processor testbench
Date: 20/03/24
*/
module processor_tb;

    timeunit 1ps;
    timeprecision 1ps;

	logic	      eclk;
	logic	      rst;
	logic [23:0] instruction;
	logic [23:0] read_scalar_data;
	logic [23:0] pc_address;
    logic         mem_write_scalar;
	logic [23:0] write_scalar_data;
    logic [23:0] scalar_data_address;

    /* internal signals */
    logic [23:0] next_pc_address;

    logic [23:0] ALUResult;

	logic [23:0] Result;

	/* ASIP Processor */
	processor # (.N(24)) uut (.clk(eclk),
							  .rst(rst),
							  .instruction(instruction),
							  .read_scalar_data(scalar_data_read),
							  .pc_address(pc_address),
							  .MemWrite(mem_write_scalar),
							  .alu_scalar_result(scalar_data_address),
							  .write_scalar_data(write_scalar_data));
	// Initialize inputs

    initial begin
		$display("fir_filter testbench:\n");

		eclk = 0;
		rst = 0;
		instruction = 24'b0;
		read_scalar_data = 24'hafafaf;
        
        /*
        $monitor("Processor Signals:\n",
                 "instruction = %b (%h)\n", uut.instruction, uut.instruction,
                 "read_scalar_data = %b (%h)\n", uut.scalar_data_read, uut.scalar_data_read,
                 "pc_address = %b ($%d)\n", uut.pc_address, uut.pc_address,
                 "MemWriteScalar = %b\n", uut.mem_write_scalar, uut.mem_write_scalar,
                 "alu_scalar_result = %b (%h)\n", uut.scalar_data_address, uut.scalar_data_address,
                 "write_scalar_data = %b (%h)\n\n\n", uut.write_scalar_data, uut.write_scalar_data); */
    end

    always begin
		#50 eclk = !eclk;
        next_pc_address = uut.next_pc_address;
        ALUResult = uut.ALUResult;
    end

    initial	begin

        instruction = 24'h0A8900;
        rst = 1;

        #100

        rst = 0;

        #100

        //$display("Instruction read, no data read, no data write\n");

        instruction = 24'h0B8901;

        #100


        #100;

		// Done

    end

    initial
	#1500 $finish;                                 

endmodule
