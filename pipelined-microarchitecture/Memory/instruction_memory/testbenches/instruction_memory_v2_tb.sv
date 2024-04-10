/*
instruction memory testbench
Date: 31/03/24
*/
module instruction_memory_v2_tb;

    parameter N = 24;

    logic [13:0] address;	    // from PC to A in instruction memory
    logic [N-1:0] instruction;	// from ALUResult to A in data memory

	/* ASIP Processor */
	instruction_memory_v2 #(.N(N)) uut (.address(address),
						                .instruction(instruction));

	// Initialize inputs
    initial begin
		$display("instruction_memory testbench:\n");

		address = 14'h0;      
        
        $monitor("Instruction Memory Signals:\n",
                 "address = %b (%h) ", address, address,
                 "instruction = %b (%h)\n\n\n", instruction, instruction);
    end

    initial	begin

        #200

		address = 14'h0;

        #100

        address = 14'h1;

        #100

        address = 14'h2;

        #100

        address = 14'h3;

        #100

        address = 14'h4;

        #100


        #100;

    end

    initial
	#1100 $finish;                                 

endmodule
