/*
Testbench for Decode module
Date: 08/04/24
FALTA
*/
module decode_tb;

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

	decode # (.N(N)) uut (.clk(clk),
						  .rst(rst),
						  .RegWriteW(RegWriteW),
						  .FlushE(FlushE),
						  .NFlags(NFlags),
						  .InstrD(InstrD),
						  .PCPlus8D(PCPlus8D),
						  .ResultW(ResultW),
						  .WA3E(WA3E),

						  .PCSrcD(PCSrcD),
						  .PCSrcE(PCSrcE),
						  .RegWriteE(RegWriteE),
						  .MemtoRegE(MemtoRegE),
						  .MemWriteE(MemWriteE),
						  .ALUControlE(ALUControlE),
						  .BranchE(BranchE),
						  .ALUSrcE(ALUSrcE),
						  .FlagWriteE(FlagWriteE),
						  .OpcodeE(OpcodeE),
						  .SE(SE),
						  .FlagsE(FlagsE),
						  .RD1E(RD1E),
						  .RD2E(RD2E),
						  .WA3E(WA3E),
						  .ExtImmE(ExtImmE),
						  .A3E(A3E),
						  .RA1E(RA1E),
						  .RA2E(RA2E),
						  ,Stuck(Stuck)
						);

		
	// Initialize inputs
    initial begin
		$display("decode stage module testbench:\n");

		clk = 0;
		rst = 0,
		RegWriteW = 1;
		FlushE = 1;
		PCPlus8D = 24'b1000;
		ResultW = 24'b0;
		WA3W = 4'b1000;
        
        /*
        $monitor("Decode Signals:\n",
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
