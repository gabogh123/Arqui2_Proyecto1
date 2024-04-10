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

	/* wiring from Fetch stage */
	logic [N-1:0] wInstrF_D;
	logic [N-1:0] wPCPlus8;

	/* wiring from Decode stage */
	logic wPCSrcD_H;
	logic wPCSrcD_E;
	logic wRegWriteD_E;
	logic wMemtoRegD_E;
	logic wMemWriteD_E;
	logic [2:0] wALUControlD_E;
	logic wALUSelD_E;
	logic wBranchD_E;
	logic wALUSrcD_E;
	logic [1:0] wFlagWriteD_E;
	logic [2:0] wOpcodeD_E;
	logic [1:0] wSD_E;
	logic [3:0] wFlagsD_E;
	logic [N-1:0] wRD1D_E;
	logic [N-1:0] wRD2D_E;
	logic [3:0] wWA3D_E;
	logic [N-1:0] wExtImmD_E;
	logic [3:0] wRA1E;
	logic [3:0] wRA2E;
	logic [3:0] wRA1H;
	logic [3:0] wRA2H;

	/* wiring from Execute stage */
	logic [N-1:0] wExtImmE_F;
	logic wBranchTakenE_F;
	logic [3:0] wALUFlagsE_D;
	logic wPCSrcE_M;
	logic wRegWriteE_M;
	logic wMemtoRegE_M;
	logic [3:0] wWA3E_M;

	/* wiring from Memory stage */


	/* wiring from Writeback stage */
	logic wPCSrcW_F;
	logic wRegWriteW_D;
	logic wMemtoRegW;
	logic [N-1:0] wReadDataW;
	logic [N-1:0] wALUOutW;
	logic [N-1:0] ResultW;
	logic [3:0] wWA3W_D;

	/* wiring from Hazard Unit */
	logic wStallF;
	logic wStallD;
	logic wFlushD;
	logic wFlushE;
	logic [1:0] wForwardAE;
	logic [1:0] wForwardBE;
	logic wMatch;


	/* Fetch stage */
	fetch # (.N(N)) fetch_stage (.clk(clk),
								 .rst(rst),
								 .ResultW(ResultW),
								 .ExtImmE(wExtImmE_F),
								 .PCSrcW(wPCSrcW_F),
								 .BranchTakenE(wBranchTakenE_F),
								 .StallF(wStallF),
								 .StallD(wStallD),
								 .FlushD(wFlushD),
								 .instruction(Instr),
								 
								 .PCF(PC),
								 .InstrD(wInstrF_D),
								//  .InstrD_vector(),
								 .PCPlus8D(wPCPlus8));


	/* scalar Decode stage */
	decode # (.N(N)) sDecode (.clk(clk),
							  .rst(rst),
							  .RegWriteW(wRegWriteW_D),
							  .FlushE(wFlushE),
							  .NFlags(wALUFlagsE_D),
							  .InstrD(wInstrF_D),
							  .PCPlus8D(wPCPlus8),
							  .ResultW(ResultW),
							  .WA3W(wWA3W_D),

							  .PCSrcD(wPCSrcD_H),
							  .PCSrcE(wPCSrcD_E),
							  .RegWriteE(wRegWriteD_E),
							  .MemtoRegE(wMemtoRegD_E),
							  .MemWriteE(wMemWriteD_E),
							  .ALUControlE(wALUControlD_E),
							  .ALUSelE(wALUSelD_E),
							  .BranchE(wBranchD_E),
							  .ALUSrcE(wALUSrcD_E),
							  .FlagWriteE(wFlagWriteD_E),
							  .OpcodeE(wOpcodeD_E),
							  .SE(wSD_E),
							  .FlagsE(wFlagsD_E),
							  .RD1E(wRD1D_E),
							  .RD2E(wRD2D_E),
							  .WA3E(wWA3D_E),
							  .ExtImmE(wExtImmD_E),
							//   .A3E(),
							  .RA1H(wRA1H),
							  .RA2H(wRA2H),
							  .RA1E(wRA1E),
							  .RA2E(wRA2E));
							//   .Stuck());


	/* scalar Execute stage */
	execute # (.N(N)) sExecute (.clk(clk),
								.rst(rst),
								.RD1E(wRD1D_E),
								.RD2E(wRD2D_E),
								.ExtImmE(wExtImmD_E),
								.ResultW(ResultW),
								.ALUResultMFB(ALUResult_scalar),
								.PCSrcE(wPCSrcD_E),
								.RegWriteE(wRegWriteD_E),
								.MemtoRegE(wMemtoRegD_E),
								.MemWriteE(wMemWriteD_E),
								.ALUControlE(wALUControlD_E),
								.ALUSelE(wALUSelD_E),
								.BranchE(wBranchD_E),
								.ALUSrcE(wALUSrcD_E),
								.FlagWriteE(wFlagWriteD_E),
								.OpcodeE(wOpcodeD_E),
								.SE(wSD_E),
								.FlagsE(wFlagsD_E),
								.WA3E(wWA3D_E),
								.ForwardAE(wForwardAE),
								.ForwardBE(wForwardBE),

								.PCSrcM(wPCSrcE_M),
								.RegWriteM(wRegWriteE_M),
								.MemWriteM(MemWrite_scalar),
								.MemtoRegM(wMemtoRegE_M),
								.BranchTakenE(wBranchTakenE_F),
								.ALUResultM(ALUResult_scalar),
								.WriteDataM(WriteData_scalar),
								.ExtImmF(wExtImmE_F), 
								.WA3M(wWA3E_M),
								.ALUFlagsD(wALUFlagsE_D));


	/* Pipeline Register Memory-Writeback Stages */ /* A = regmw @ memory.sv */
	register_MW # (.N(N)) reg_MW (.clk(clk),
								  .PCSrcM(wPCSrcE_M),
								  .RegWriteM(wRegWriteE_M),
								  .MemtoRegM(wMemtoRegE_M),
								  .ReadDataM(ReadData_scalar),
								  .ALUOutM(ALUResult_scalar),
								  .WA3M(wWA3E_M),
								
								  .PCSrcW(wPCSrcW_F),
								  .RegWriteW(wRegWriteW_D),
								  .MemtoRegW(wMemtoRegW),
								  .ReadDataW(wReadDataW),
								  .ALUOutW(wALUOutW),
								  .WA3W(wWA3W_D));


	/* ResultW Mux */ /* A = mux_pcnext */
	mux_2NtoN # (.N(N)) mux_ResultW (.I0(wALUOutW), //ready
									 .I1(wReadDataW),
									 .rst(rst),
									 .S(wMemtoRegW),
									 .en(1'b1),
									 .O(ResultW));


	/* Hazard Unit */
	hazard_unit hazards (.RA1E(wRA1E),
						 .RA2E(wRA2E),
						 .WA3M(wWA3E_M),
						 .WA3W(wWA3W_D),
						 .RA1D(wRA1H),
						 .RA2D(wRA2H),
						 .WA3E(wWA3D_E),
						 .RegWriteM(wRegWriteE_M),
						 .RegWriteW(wRegWriteW_D),
						 .MemtoRegE(wMemtoRegD_E),
						 .PCSrcD(wPCSrcD_H),
						 .PCSrcE(wPCSrcD_E),
						 .PCSrcM(wPCSrcE_M),
						 .PCSrcW(wPCSrcW_F),
						 .BranchTakenE(wBranchTakenE_F),
						 
						 .ForwardAE(wForwardAE),
						 .ForwardBE(wForwardBE),
						 .StallF(wStallF),
						 .StallD(wStallD),
						 .FlushE(wFlushE),
						 .FlushD(wFlushD));

endmodule
