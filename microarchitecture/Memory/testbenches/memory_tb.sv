/*
memory testbench
Date: 27/03/24
ONLY SCALAR TESTS YET
*/
module memory_tb;

    timeunit 1ps;
    timeprecision 1ps;

    parameter N = 24;

	logic	      clk;

    logic [N-1:0] instruction_address;	// from PC to A in instruction memory
    logic [N-1:0] scalar_data_address;	// from ALUResult to A in data memory
    logic [N-1:0] vector_data_address;	// NYI

    logic [N-1:0] write_scalar_data;	// WriteData (RD2 from register file) to WD
    logic [255:0] write_vector_data;	// NYI

    logic InstructionMemRead;			// Control Signal: Always 1
    logic ScalarMemRead;				// Control Signal: Always 1; NYI
    logic VectorMemRead;				// Control Signal: NYI

    logic ScalarMemWrite;				// Control Signal: MemWrite from Control Unit 
    logic VectorMemWrite;				// Control Signal: sNYI

    logic [N-1:0] instruction;			// to Instruction after instruction memory
    logic [N-1:0] scalar_data_read;		// ReadData from RD in data memory to MemtoRegMux
    logic [255:0] vector_data;  		// NYI

    /* internal signals */
    logic [13:0] in_address;
	logic [13:0] sd_address;	// 16384 addresses de 24 bits
	// logic [17:0] vd_address;	// 32768 addresses de 256 bits

	/* ASIP Processor */
	memory # (.N(N)) uut (.eclk(clk),
						  .instruction_address(instruction_address),
						  .scalar_data_address(scalar_data_address),
						  .vector_data_address(vector_data_address),
						  .write_scalar_data(write_scalar_data),
						  .write_vector_data(write_vector_data),
						  .InstructionMemRead(InstructionMemRead),
						  .ScalarMemRead(ScalarMemRead),
						  .VectorMemRead(VectorMemRead),
						  .ScalarMemWrite(ScalarMemWrite),
						  .VectorMemWrite(VectorMemWrite),
						  .instruction(instruction),
						  .scalar_data_read(scalar_data_read),
						  .vector_data(vector_data));

	// Initialize inputs
    initial begin
		$display("memory testbench:\n");

		clk = 1;

		instruction_address = 24'h0;;
		scalar_data_address = 24'h2000;
		// vector_data_address = 24'b0;

		write_scalar_data = 24'b0;
		// write_vector_data = 255'b0;
		
		InstructionMemRead = 0;
		ScalarMemRead = 0;
		// VectorMemRead = 0;

		ScalarMemWrite = 0;
		// VectorMemWrite = 0;
        
        
        $monitor("Memory (Scalar) Signals:\n",
                 "instruction_address = %b (%h) ", instruction_address, instruction_address,
                 "[in_address = %b (%h)]\n", uut.in_address, uut.in_address,
                 "scalar_data_address = %b (%h) ", scalar_data_address, scalar_data_address,
                 "[sd_address = %b (%h)]\n", uut.sd_address, uut.sd_address,

                 "write_scalar_data = %b ($%d)\n", write_scalar_data, write_scalar_data,

                 "InstructionMemRead = %b\n", InstructionMemRead, InstructionMemRead,
                 "ScalarMemRead = %b (%h)\n", ScalarMemRead, ScalarMemRead,

                 "ScalarMemWrite = %b (%h)\n", ScalarMemWrite, ScalarMemWrite,

                 "instruction = %b (%h)\n", instruction, instruction,
                 "scalar_data_read = %b (%h)\n\n\n", scalar_data_read, scalar_data_read);
    end

    always begin
		#50 clk = !clk;
    end

    always begin

        in_address = uut.in_address;
        sd_address = uut.sd_address;
        // vd_address = uut.vd_address;
        #1;
    end

    initial	begin

        #300

		scalar_data_address = 24'h1;    // cambio address si
		ScalarMemRead = 0;              // cambio enable  no
		ScalarMemWrite = 0;

        #100

		scalar_data_address = 24'h2;    // cambio address si
		ScalarMemRead = 1;              // cambio enable  si
		ScalarMemWrite = 0;

        #100
    	
		scalar_data_address = 24'h3;    // cambio address si
		ScalarMemRead = 1;              // cambio enable  no
		ScalarMemWrite = 0;

        #100

		scalar_data_address = 24'h3;    // cambio address no
		ScalarMemRead = 1;              // cambio enable  no
		ScalarMemWrite = 0;

        #100

		scalar_data_address = 24'h3;    // cambio address no
		ScalarMemRead = 0;              // cambio enable  si
		ScalarMemWrite = 0;

        #100

        scalar_data_address = 24'h4;    // cambio address si
		ScalarMemRead = 1;              // cambio enable  si
		ScalarMemWrite = 0;

        #100





        #100;

    end

    initial
	#1100 $finish;                                 

endmodule
