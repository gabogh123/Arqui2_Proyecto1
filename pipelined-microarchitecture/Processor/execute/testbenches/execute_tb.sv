/*
Testbench for Execute module
Date: 08/04/24
FALTA
*/
module execute_tb;

	parameter N = 24;

	logic clk;
	logic rst;
	logic RegWriteW;
	logic FlushE;
	logic [3:0] NFlags;
	logic [N-1:0] InstrD;
	logic [N-1:0] PCPlus8D;
	logic [N-1:0] ResultW;
	logic [3:0] WA3W;

	logic PCSrcD;
	logic PCSrcE;
	logic RegWriteE; 
	logic MemtoRegE;
	logic MemWriteE; 
	logic [2:0] ALUControlE; 
	logic BranchE; 
	logic ALUSrcE;
	logic [1:0] FlagWriteE; 
	logic CondE; 
	logic [3:0] FlagsE; 
	logic [N-1:0] RD1E; 
	logic [N-1:0] RD2E; 
	logic [3:0] WA3E; 
	logic [N-1:0] ExtImmE;
	logic [3:0] A3E;
	logic [3:0] RA1E;
	logic [3:0] RA2E;
	logic Stuck;

	/* internal signals */
	//

	
	assign V = instruction[20];
	assign opcode = instruction[23:21];

	// CAMBIAR POR LA INSTANCIA DE EXECUTE O AGREGAR Y USAR ESTA TAMBIEN PARA EL TEST
	fetch # (.N(N)) uut (.clk(clk),
						 .rst(rst),
						 .ResultW(ResultW),
						 .ALUResultE(ALUResultE),
						 .PCSrcW(PCSrcW),
						 .BranchTakenE(BranchTakenE),
						 .StallF(StallF),
						 .StallD(StallD),
						 .FlushD(FlushD),
						 .instruction(instruction),
						 .PCF(PCF),
						 .InstrD(InstrD),
						 .InstrD_vector(InstrD_vector),
						 .PCPlus8D(PCPlus8D));

	instruction_memory_v2 # (.N(N)) inst_mem_ut (.address(PCF),
												 .instruction(instruction));
				
	// Initialize inputs
    initial begin
		$display("execute stage module testbench:\n");

		clk = 0;
		ResultW = 24'b0;
		ALUResultE = 24'b0;
		PCSrcW = 1'b0;
		BranchTakenE = 1'b0;
		StallF = 1'b1; // enable pc register
		StallD = 1'b1; // enable pipeline register 
		FlushD = 1'b0; // clear pipeline register
        
        /*
        $monitor("Register_v2 Signals:\n",
                 "RegIn = %b (%h)\n", RegIn, RegIn,
                 "WriteEn = %b\n", WriteEn,
                 "RegOut = %b (%h)\n\n\n", RegOut, RegOut);*/
    end

    always begin
		#50 clk = !clk;

    end

    initial	begin

        #200

        rst = 1;

        #100

        rst = 0;

        #100

 

        #100;

		// Done

    end

    initial
	#3600 $finish;                                 

endmodule
