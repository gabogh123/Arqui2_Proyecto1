/*
Processor Module
Date: 07/04/24
*/
module pipelined_processor # (parameter N = 24) (
        input  logic		 clk,
		input  logic		 rst,
		input  logic		 en,

        input  logic [N-1:0] Instr,       		// RD from instruction memory
        input  logic [N-1:0] ReadData_scalar, 	// RD from data memory

        output logic [N-1:0] PC,       	 		// to A from instruction memory
        output logic MemWrite_scalar,           // ScalarMemWrite from Data memory
        output logic [N-1:0] ALUResult_scalar,	// to A from, data memory
        output logic [N-1:0] WriteData_scalar  	// to WD (write_scalar_data) from data memory
    );

	/* wiring from Writeback stage */
	logic wPCSrcW;
	logic wMemtoRegW;
	logic [N-1:0] wReadDataW;
	logic [N-1:0] wALUOutW;
	logic [N-1:0] ResultW;

	/* Fetch stage */
	fetch # (.N(N)) fetch_stage (.clk(clk),
								 .rst(rst),
								 .ResultW(ResultW),
								 .ALUResultE(),
								 .PCSrcW(wPCSrcW),
								 .BranchTakenE(),
								 .StallF(),
								 .StallD(),
								 .FlushD(),
								 .instruction(Instr),
								 
								 .PCF(PC),
								 .InstrD(),
								 .InstrD_vector(),
								 .PCPlus8D());


	/*
	decode # (.N(N)) sDecode (
		.clk(),
		.rst(),
		.RegWriteW(),
		.FlushE(),
		.NFlags(),
		.InstrD(),
		.PCPlus8D(),
		.ResultW(),
		.WA3W(),

		.PCSrcD(),
		.PCSrcE(),
		.RegWriteE(),
		.MemtoRegE(),
		.MemWriteE(),
		.ALUControlE(),
		.BranchE(),
		.ALUSrcE(),
		.FlagWriteE(),
		.CondE(),
		.FlagsE(),
		.RD1E(),
		.RD2E(),
		.WA3E(),
		.ExtImmE(),
		.A3E(),
		.RA1E(),
		.RA2E(),
		.Stuck());
	*/

	/*
	execute # (.N(N)) sExecute(
		.clk(),
		.rst(),
		.RD1E(),
		.RD2E(),
		.ExtImmE(),
		.ResultW(),
		.ALUResultMFB(),

		.PCSrcE(),
		.RegWriteE(),
		.MemtoRegE(),
		.MemWriteE(),
		.ALUControlE(),
		.BranchE(),
		.ALUSrcE(),
		.FlagWriteE(),
		.CondE(),
		.FlagsE(),

		.WA3E(),
		.ForwardAE(),
		.ForwardBE(),

		.PCSrcM(),
		.RegWriteM(),
		.MemWriteM(),
		.MemtoRegM(),
		.BranchTakenE(),
		.ALUResultM(),
		.WriteDataM(),
		.ALUResultF(), 
		.WA3M(),
		.ALUFlagsD());
	*/

	/*
	INSTANTIATION OF MEMORY THAT IS GOING TO BE OUTSIDE THIS MODULE
	FOR IMPLEMENTATION HELP ONLY
	memory # (.N(N)) DUMMY_MEMORY (.clk(eclk),
								  .data_address_scalar(data_address_scalar),
								  .data_address_vector(data_address_vector),
								  .write_data_scalar(write_data_scalar),
								  .write_data_vector(write_data_vector),
								  .MemWrite_scalar(MemWrite_scalar),
								  .MemWrite_vector(MemWrite_vector),
								  .read_data_scalar(read_data_scalar),
								  .read_data_vector(read_data_vector));
	*/

	/* Pipeline Register Memory-Writeback Stages */ /* A = regmw @ memory.sv */
	register_MW # (.N(N)) (.clk(clk),
						   .PCSrcM(),
						   .RegWriteM(),
						   .MemtoRegM(),
						   .ReadDataM(),
						   .ALUOutM(),
						   .WA3M(),
						   
						   .PCSrcW(wPCSrcW),
						   .RegWriteW(),
						   .MemtoRegW(wMemtoRegW),
						   .ReadDataW(wReadDataW),
						   .ALUOutW(wALUOutW),
						   .WA3W());

	/* ResultW Mux */ /* A = mux_pcnext */
	mux_2NtoN # (.N(N)) mux_ResultW (.I0(wALUOutW), //ready
									 .I1(wReadDataW),
									 .rst(rst),
									 .S(wMemtoRegW),
									 .en(1'b1),
									 .O(ResultW));

endmodule
