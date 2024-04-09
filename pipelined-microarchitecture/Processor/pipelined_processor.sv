/*
Processor Module
Date: 07/04/24
*/
module pipelined_processor # (parameter N = 24) (
        input  logic			clk,
		input  logic			rst,
		input  logic			en,

        input  logic [N-1:0] Instr,       		// RD from instruction memory
        input  logic [N-1:0] ReadData_scalar, 	// RD from data memory

        output logic [N-1:0] PC,       	 		// to A from instruction memory
        output logic MemWrite_scalar,           // ScalarMemWrite from Data memory
        output logic [N-1:0] ALUResult_scalar,	// to A from, data memory
        output logic [N-1:0] WriteData_scalar  	// to WD (write_scalar_data) from data memory
    );

	/*
	fetch # (.N(N)) fetch_stage (.clk(clk),
							.rst(rst),
							.ResultW(),
							.ALUResultE(),
							.PCSrcW(),
							.BranchTakenE(),
							.StallF(),
							.StallD(),
							.FlushD(),
							.instruction(),

							.PCF(),
							.InstrD(),
							.InstrD_vector(),
							.PCPlus8D());
	*/

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

	/*
	THIS ARE THE VARIABLES IN MEMORY MODULE FROM A(),
	SOME VARIABLES MUST BE INSTANTIATED OR PASSED IN THIS MODULE
	CHECK
	memory (.clk(),
			.clock_img(),
			.PCSrcM(),
			.RegWriteM(),
			.MemtoRegM(),
			.MemWriteM(),
			.ALUResultM(),
			.WriteDataM(),
			.WA3M(),
			.ImgAddr(),
			.PCSrcMV(),
			.RegWriteMV(),
			.MemtoRegMV(),
			.MemWriteMV(),
			.ALUResultMV(),
			.WriteDataMV(),
			.WA3MV(),
			.ImgAddrV(),
			
			.PCSrcW(),
			.RegWriteW(),
			.MemtoRegW(),
			.ReadDataW(),
			.ALUOutW(),
			.ALUOutM(),
			.ImgData(),
			.WA3W(),
			.PCSrcWV(),
			.RegWriteWV(),
			.MemtoRegWV(),
			.ReadDataWV(),
			.ALUOutWV(),
			.ALUOutMV(),
			.ImgDataV(),
			.WA3WV());
		*/

	/* Pipeline Register Memory-Writeback Stages */ /* A = regmw @ memory.sv */
	/*
	register_MW # (.N(N)) (.clk(clk),
						   .PCSrcM(),
						   .RegWriteM(),
						   .MemtoRegM(),
						   .ReadDataM(),
						   .ALUOutM(),
						   .WA3M(),
						   
						   .PCSrcW(),
						   .RegWriteW(),
						   .MemtoRegW(),
						   .ReadDataW(),
						   .ALUOutW(),
						   .WA3W());
	*/

	/* ResultW Mux */ /* A = mux_pcnext */
	mux_2NtoN # (.N(N)) mux_ResultW (.I0(xxxxxxxxxxxxxx),
									 .I1(xxxxxxxxxxxxxx),
									 .rst(rst),
									 .S(xxxxxxxxxxxxxx),
									 .en(1'b1),
									 .O(xxxxxxxxxxxxxx));

endmodule
